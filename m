Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54E446B7FE9
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 19:04:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229734AbjCMSEf convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 13 Mar 2023 14:04:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbjCMSEd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 14:04:33 -0400
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E579832E67
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 11:04:26 -0700 (PDT)
Received: by mail-io1-f71.google.com with SMTP id k23-20020a5e8917000000b0074cbfb58b5bso6733390ioj.14
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 11:04:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678730666;
        h=content-transfer-encoding:to:from:subject:message-id:in-reply-to
         :date:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IUClCA8ixvbHg3XIwEr+29D5IhwBAvU2c3FyGS/wwzA=;
        b=b7PltW9jeRZYgZv1De4zKYvkYpZ80h+Ep9Zz63TPqpFHodxQCnyJ0/gFFADNib6P+A
         kpaZVXsN9oRkIPsthNolwiPtC3FllxdbaD0nqfWpHVPz+gcLFwusT38WbgjlMirfkv1o
         r0XMMV7fKg6I2HHj4JVsdZEVu8ts6zcNJGjfgo3vUl5WkLVC+6uYmvuT8HZBAqnHFjs3
         a5YCSt1bhq7YeosKVOa086joGTgrYdRlq7pemZQD8KoFameEHk7vGBx+SQYo/1Mjph6i
         3zlmUHV6Z5scLI2FLy/wff0t6gbX4nJOr6ttm+a3E2ZDIlaScFKyG4yvRZlplRQxrCNB
         c0gw==
X-Gm-Message-State: AO0yUKWabmMWlxzbz+lUL4mA85j1uTjsqQFamOXSiW58MIgteRNF2dTy
        WV7aj8wDPpUmlwqJnhAwEwSW2E6S70L4dnAupPsiaAaCHkH5
X-Google-Smtp-Source: AK7set/nf4mFYdToQ28x4zNXFvUhaQsgQ8310zoFHs/2hWGi16zmqOB8dH6xQjU5KCsj/L8c1evLCBADMxLi8TPhH/NRpoSFjnZ0
MIME-Version: 1.0
X-Received: by 2002:a02:a98f:0:b0:3b7:9d19:fec7 with SMTP id
 q15-20020a02a98f000000b003b79d19fec7mr16446833jam.0.1678730666212; Mon, 13
 Mar 2023 11:04:26 -0700 (PDT)
Date:   Mon, 13 Mar 2023 11:04:26 -0700
In-Reply-To: <20230313174118.325aaafflrliiehe@fpc>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000000883f905f6cbf108@google.com>
Subject: Re: [syzbot] [wireless?] KMSAN: uninit-value in ath9k_hw_init
From:   syzbot <syzbot+df61b36319e045c00a08@syzkaller.appspotmail.com>
To:     glider@google.com, linux-kernel@vger.kernel.org,
        pchelkin@ispras.ru, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=0.1 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLACK autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

failed to copy binary to VM: failed to run ["scp" "-P" "22" "-F" "/dev/null" "-o" "UserKnownHostsFile=/dev/null" "-o" "BatchMode=yes" "-o" "IdentitiesOnly=yes" "-o" "StrictHostKeyChecking=no" "-o" "ConnectTimeout=10" "/tmp/syz-executor3739450099" "root@10.128.0.155:./syz-executor3739450099"]: exit status 1
ssh: connect to host 10.128.0.155 port 22: Connection timed out
lost connection




syzkaller build log:
go env (err=<nil>)
GO111MODULE="auto"
GOARCH="amd64"
GOBIN=""
GOCACHE="/syzkaller/.cache/go-build"
GOENV="/syzkaller/.config/go/env"
GOEXE=""
GOEXPERIMENT=""
GOFLAGS=""
GOHOSTARCH="amd64"
GOHOSTOS="linux"
GOINSECURE=""
GOMODCACHE="/syzkaller/jobs-2/linux/gopath/pkg/mod"
GONOPROXY=""
GONOSUMDB=""
GOOS="linux"
GOPATH="/syzkaller/jobs-2/linux/gopath"
GOPRIVATE=""
GOPROXY="https://proxy.golang.org,direct"
GOROOT="/usr/local/go"
GOSUMDB="sum.golang.org"
GOTMPDIR=""
GOTOOLDIR="/usr/local/go/pkg/tool/linux_amd64"
GOVCS=""
GOVERSION="go1.20.1"
GCCGO="gccgo"
GOAMD64="v1"
AR="ar"
CC="gcc"
CXX="g++"
CGO_ENABLED="1"
GOMOD="/syzkaller/jobs-2/linux/gopath/src/github.com/google/syzkaller/go.mod"
GOWORK=""
CGO_CFLAGS="-O2 -g"
CGO_CPPFLAGS=""
CGO_CXXFLAGS="-O2 -g"
CGO_FFLAGS="-O2 -g"
CGO_LDFLAGS="-O2 -g"
PKG_CONFIG="pkg-config"
GOGCCFLAGS="-fPIC -m64 -pthread -Wl,--no-gc-sections -fmessage-length=0 -fdebug-prefix-map=/tmp/go-build388716093=/tmp/go-build -gno-record-gcc-switches"

git status (err=<nil>)
HEAD detached at f8902b574
nothing to commit, working tree clean


tput: No value for $TERM and no -T specified
tput: No value for $TERM and no -T specified
Makefile:32: run command via tools/syz-env for best compatibility, see:
Makefile:33: https://github.com/google/syzkaller/blob/master/docs/contributing.md#using-syz-env
go list -f '{{.Stale}}' ./sys/syz-sysgen | grep -q false || go install ./sys/syz-sysgen
make .descriptions
tput: No value for $TERM and no -T specified
tput: No value for $TERM and no -T specified
bin/syz-sysgen
touch .descriptions
GOOS=linux GOARCH=amd64 go build "-ldflags=-s -w -X github.com/google/syzkaller/prog.GitRevision=f8902b5747fbe3d5b860bd782eec63fc9c7da6e7 -X 'github.com/google/syzkaller/prog.gitRevisionDate=20230301-104759'" "-tags=syz_target syz_os_linux syz_arch_amd64 " -o ./bin/linux_amd64/syz-fuzzer github.com/google/syzkaller/syz-fuzzer
GOOS=linux GOARCH=amd64 go build "-ldflags=-s -w -X github.com/google/syzkaller/prog.GitRevision=f8902b5747fbe3d5b860bd782eec63fc9c7da6e7 -X 'github.com/google/syzkaller/prog.gitRevisionDate=20230301-104759'" "-tags=syz_target syz_os_linux syz_arch_amd64 " -o ./bin/linux_amd64/syz-execprog github.com/google/syzkaller/tools/syz-execprog
GOOS=linux GOARCH=amd64 go build "-ldflags=-s -w -X github.com/google/syzkaller/prog.GitRevision=f8902b5747fbe3d5b860bd782eec63fc9c7da6e7 -X 'github.com/google/syzkaller/prog.gitRevisionDate=20230301-104759'" "-tags=syz_target syz_os_linux syz_arch_amd64 " -o ./bin/linux_amd64/syz-stress github.com/google/syzkaller/tools/syz-stress
mkdir -p ./bin/linux_amd64
gcc -o ./bin/linux_amd64/syz-executor executor/executor.cc \
	-m64 -O2 -pthread -Wall -Werror -Wparentheses -Wunused-const-variable -Wframe-larger-than=16384 -Wno-stringop-overflow -Wno-array-bounds -Wno-format-overflow -Wno-unused-but-set-variable -Wno-unused-command-line-argument -static-pie -fpermissive -w -DGOOS_linux=1 -DGOARCH_amd64=1 \
	-DHOSTGOOS_linux=1 -DGIT_REVISION=\"f8902b5747fbe3d5b860bd782eec63fc9c7da6e7\"



Tested on:

commit:         34add094 kmsan: add test_stackdepot_roundtrip
git tree:       https://github.com/google/kmsan.git master
kernel config:  https://syzkaller.appspot.com/x/.config?x=76a9330669c37355
dashboard link: https://syzkaller.appspot.com/bug?extid=df61b36319e045c00a08
compiler:       Debian clang version 15.0.7, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=12969e56c80000

