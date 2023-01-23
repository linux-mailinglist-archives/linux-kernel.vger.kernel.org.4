Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCA1B677A4B
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 12:42:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231515AbjAWLmm convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 23 Jan 2023 06:42:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229868AbjAWLmk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 06:42:40 -0500
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FE2C1352C
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 03:42:39 -0800 (PST)
Received: by mail-io1-f69.google.com with SMTP id d22-20020a5d9656000000b00704d3bd8c07so6715846ios.8
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 03:42:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:from:subject:message-id:in-reply-to
         :date:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i5vlEfAiIqVpUlapdWYrWugECG++bILJJkQRJhbIFWM=;
        b=DpGCfH6Bj64UoOhN6dN7hBzwz4NK9MzMq385QXxeWw72pSCHODT/VXigqd5dzLg4lO
         z3B9RpGqL2FuFRRuaIs4KU9TdUYLI0WlTeVYJwgGhAX/6sZjXUdvotsNbAyr67v8EnaV
         uybmjLxRoEQetbwgN9I7KleH+Dam/QZizxme/GAH9f358SlYypb57Vvz7FY6ny6AZPTF
         0xwlPtBx3Cv6oZz06bHxpsIBkNUsQZ9vtpTsc0+BbWLDpDCLYVT1iRo4b55WafD9RKAC
         iwkQHuJSNJxwSyCU8mpVlhMBi7yjAxvS7HuS3bLI6IUgx8plb6iw5VypHeWQ7gaGByUq
         /+2w==
X-Gm-Message-State: AFqh2kpzRfMsp5cMCC7iWADdXoInZaLYMmXh39AhqmF3qEK9AVbbUjs+
        37sGAzcokFaFwX+96s3f3d8mAzsGB0i3TTe0u8tMER7noOd6
X-Google-Smtp-Source: AMrXdXsDORNRzWUGfMM/zZYOAdJWySDNJYaamp1VuMJDrAChe1CpgmvUJyOLM7WQqKyy++YZpQKyHKlZbHwA2HJNAAkxHtzeRTWF
MIME-Version: 1.0
X-Received: by 2002:a92:d3d1:0:b0:30e:ec63:1a1f with SMTP id
 c17-20020a92d3d1000000b0030eec631a1fmr2423978ilh.220.1674474158775; Mon, 23
 Jan 2023 03:42:38 -0800 (PST)
Date:   Mon, 23 Jan 2023 03:42:38 -0800
In-Reply-To: <20230123082114.4291-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000006b647005f2ece55e@google.com>
Subject: Re: [syzbot] [xfs?] KASAN: stack-out-of-bounds Read in xfs_buf_lock
From:   syzbot <syzbot+0bc698a422b5e4ac988c@syzkaller.appspotmail.com>
To:     hdanton@sina.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

failed to delete instance: googleapi: Error 400: Invalid value for field 'instance': 'ci-upstream-kasan-gce-root-test-job-parallel-test-job-parallel-1'. Must be a match of regex '[a-z](?:[-a-z0-9]{0,61}[a-z0-9])?|[1-9][0-9]{0,19}', invalid



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
GOVERSION="go1.17"
GCCGO="gccgo"
AR="ar"
CC="gcc"
CXX="g++"
CGO_ENABLED="1"
GOMOD="/syzkaller/jobs-2/linux/gopath/src/github.com/google/syzkaller/go.mod"
CGO_CFLAGS="-g -O2"
CGO_CPPFLAGS=""
CGO_CXXFLAGS="-g -O2"
CGO_FFLAGS="-g -O2"
CGO_LDFLAGS="-g -O2"
PKG_CONFIG="pkg-config"
GOGCCFLAGS="-fPIC -m64 -pthread -fmessage-length=0 -fdebug-prefix-map=/tmp/go-build480514578=/tmp/go-build -gno-record-gcc-switches"

git status (err=<nil>)
HEAD detached at 1dac8c7a0
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
GOOS=linux GOARCH=amd64 go build "-ldflags=-s -w -X github.com/google/syzkaller/prog.GitRevision=1dac8c7a01e2bdd35cb04eb4901ddb157291ac2d -X 'github.com/google/syzkaller/prog.gitRevisionDate=20230103-123455'" "-tags=syz_target syz_os_linux syz_arch_amd64 " -o ./bin/linux_amd64/syz-fuzzer github.com/google/syzkaller/syz-fuzzer
GOOS=linux GOARCH=amd64 go build "-ldflags=-s -w -X github.com/google/syzkaller/prog.GitRevision=1dac8c7a01e2bdd35cb04eb4901ddb157291ac2d -X 'github.com/google/syzkaller/prog.gitRevisionDate=20230103-123455'" "-tags=syz_target syz_os_linux syz_arch_amd64 " -o ./bin/linux_amd64/syz-execprog github.com/google/syzkaller/tools/syz-execprog
GOOS=linux GOARCH=amd64 go build "-ldflags=-s -w -X github.com/google/syzkaller/prog.GitRevision=1dac8c7a01e2bdd35cb04eb4901ddb157291ac2d -X 'github.com/google/syzkaller/prog.gitRevisionDate=20230103-123455'" "-tags=syz_target syz_os_linux syz_arch_amd64 " -o ./bin/linux_amd64/syz-stress github.com/google/syzkaller/tools/syz-stress
mkdir -p ./bin/linux_amd64
gcc -o ./bin/linux_amd64/syz-executor executor/executor.cc \
	-m64 -O2 -pthread -Wall -Werror -Wparentheses -Wunused-const-variable -Wframe-larger-than=16384 -Wno-stringop-overflow -Wno-array-bounds -Wno-format-overflow -static-pie -fpermissive -w -DGOOS_linux=1 -DGOARCH_amd64=1 \
	-DHOSTGOOS_linux=1 -DGIT_REVISION=\"1dac8c7a01e2bdd35cb04eb4901ddb157291ac2d\"



Tested on:

commit:         7dd4b804 Merge tag 'nfsd-6.2-3' of git://git.kernel.or..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
kernel config:  https://syzkaller.appspot.com/x/.config?x=2b6ecad960fc703e
dashboard link: https://syzkaller.appspot.com/bug?extid=0bc698a422b5e4ac988c
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=145887ee480000

