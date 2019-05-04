FROM ubuntu:trusty as build

ARG MONO_VERSION=3.12.1

RUN apt -qq update && apt -qq upgrade -y && \
    apt -qq install -y wget build-essential gettext file && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /usr/local/src
RUN wget -q http://download.mono-project.com/sources/mono/mono-$MONO_VERSION.tar.bz2
RUN tar -xf mono-$MONO_VERSION.tar.bz2 && rm mono-$MONO_VERSION.tar.bz2

WORKDIR /usr/local/src/mono-$MONO_VERSION
RUN ./configure --prefix=/usr/local
RUN make
RUN make install

ENTRYPOINT ["/usr/local/bin/mono"]