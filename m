Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED9686B7F93
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 18:35:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229922AbjCMRff convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 13 Mar 2023 13:35:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbjCMRfd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 13:35:33 -0400
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 019E759DB
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 10:35:32 -0700 (PDT)
Received: by mail-il1-f200.google.com with SMTP id z8-20020a92cd08000000b00317b27a795aso6874419iln.0
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 10:35:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678728931;
        h=content-transfer-encoding:to:from:subject:message-id:in-reply-to
         :date:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8vaDPs3AxVMtZLJGCYe6vcDohp2pAroQPLYAG7N9yYU=;
        b=0ojwX6kcgyvHKmeDKt1OxZ4hG6jTS3quTRiamBfJ+zo/2fZ9679BG4w68badQiIQQs
         7DxeZH22GmPOvp8/nFl6eNtIYEN/knjX5BnLXn7oGtmKedkeTcDIHDx1TJC+tGp51zbP
         M0RothH9bxk7HRf2lXyk6BWJeBaWSyTEE+hFeM6X+JyaQGcAnE7A+qhsw2eqxs0OVSID
         EG/o2s5Y2rhevdBzrJKf3FJ1nYSTyKBmThAUb0uQ+l9iIruPlusslfeJYJrCHN9QNixD
         mKAgrXVqXo9Ra3SrQT329Q9hUIbyvU4trAK9ONKwmyzdB1o8lAVW2rApAPxCR0hitZGt
         7NWw==
X-Gm-Message-State: AO0yUKXz6y7ghel3Tge+KllI12VBE+kIeU0y8Ysh9wTg6mnPenYoh/E+
        IZ/eTJuBrIl9fSAfEu9aGQFkS0AZyWA4ztqOfcSqYRUheBC5
X-Google-Smtp-Source: AK7set/24yB9DFYHLUCACZsk0PYRsogkdJpI/5FLxtQWk7LDeYlrFSCTqhREgmmQL5Qk66QVyPatAKv4491IducvXRr1m5lxJKm7
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:13e4:b0:30f:6172:b11f with SMTP id
 w4-20020a056e0213e400b0030f6172b11fmr239333ilj.4.1678728931331; Mon, 13 Mar
 2023 10:35:31 -0700 (PDT)
Date:   Mon, 13 Mar 2023 10:35:31 -0700
In-Reply-To: <20230313170124.dcko4zbkpsnxnbws@fpc>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a0575c05f6cb89dd@google.com>
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

failed to copy binary to VM: failed to run ["scp" "-P" "22" "-F" "/dev/null" "-o" "UserKnownHostsFile=/dev/null" "-o" "BatchMode=yes" "-o" "IdentitiesOnly=yes" "-o" "StrictHostKeyChecking=no" "-o" "ConnectTimeout=10" "/tmp/syz-executor1725951009" "root@10.128.0.114:./syz-executor1725951009"]: exit status 1
ssh: connect to host 10.128.0.114 port 22: Connection timed out
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
GOGCCFLAGS="-fPIC -m64 -pthread -Wl,--no-gc-sections -fmessage-length=0 -fdebug-prefix-map=/tmp/go-build2755527109=/tmp/go-build -gno-record-gcc-switches"

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
patch:          https://syzkaller.appspot.com/x/patch.diff?x=150386dcc80000

