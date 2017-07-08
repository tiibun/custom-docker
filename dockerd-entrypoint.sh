#!/bin/sh
set -e

sh $(which dind) docker daemon \
	--host=unix:///var/run/docker.sock \
	--host=tcp://0.0.0.0:2375 \
	--storage-driver=overlay2 &>/var/log/docker.log &

timeout -t 15 sh -c "until docker info >/dev/null 2>&1; do echo .; sleep 1; done"

eval "$@"
