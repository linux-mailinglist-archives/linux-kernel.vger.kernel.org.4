Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C81667DE64
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 08:18:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232461AbjA0HS3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 02:18:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231824AbjA0HS1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 02:18:27 -0500
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E78584E533
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 23:18:25 -0800 (PST)
Received: by mail-lj1-x22a.google.com with SMTP id j15so3653613ljg.8
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 23:18:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=In8HPEUR3rkYjVSEV5mTYuM2J5NBJVyHjEY+q+ssdRA=;
        b=h32SnYbNcTEpgRSCSyKQV5un3A7fbAiEIMethaUYZhiQLkicD1nC7IKRHW0j5nKVB5
         UTjUUXTLSjLSe1kMYUp4buHmXwEPGUpnoZeVvG2UuyE7EeVmaoPObB/yoQnVNtX5j69z
         gADS0W4RHmukEZnGfb3f89uz84xzCNfYqkShDbgosl/Xp6tExwHk65jszsQSD3Xuikck
         4ELXdr+20JfJONU1cjEk6dPRN3S5VQmsYKjCibu37mGdAgJuLrbq3VT3AEejm3fvEfFu
         vPi8wr+zns07BW4PCfdG1JKjtD8Vc03V8LT0DlgjDkEWISZqRY6tdHYPBDOl3VPPA8fH
         l3gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=In8HPEUR3rkYjVSEV5mTYuM2J5NBJVyHjEY+q+ssdRA=;
        b=0ow74kPw9lo8BtOtUBcrknG4WG9rNKtRMNNtv3RjJnAavwmBRcR1//e1mwEpDPAE+w
         wTheJVsIq4tyVdjQhKA1oJpjVr4j5JVQmf+tFcGxtzXx9DtIxnZD+W6vkPATSNQiPKYW
         UkiGmA6qa4uwOWQG0AYJErX7bPhdA+B4vObxFosCLon5ti/Kvsi7MX4TwYqJ/GGqZJMV
         2d+OKcLsZtrPJmNxfOzEfyKXbcz3J+ssYncbPDndF8XJHnXesE7tc7SKmLIIIoqIuKlO
         NRfzhKri/v4o4wL2P37sYAhaXQU6T279VLKYDrFanTHjNNhHQtJmABwevMhSUQ/spl4/
         0eFA==
X-Gm-Message-State: AFqh2koflN+DxNDMUtWeabIIhOrRTiPaHi8P/6qfMbtTbKIN4zG0B82u
        BWw2P/QSgV3G8Jco7SJA3jZJTgbF0zdvwHHmPtVyYg==
X-Google-Smtp-Source: AMrXdXsgud8St7chf4CgtrHnAbG2rHMOvqCxZALyqh9CWxJg5beNqMf1+amMaZCQOYpN5GG7vG8ln46w1uLjCmauTdY=
X-Received: by 2002:a2e:3611:0:b0:287:e806:82d4 with SMTP id
 d17-20020a2e3611000000b00287e80682d4mr3874550lja.1.1674803903934; Thu, 26 Jan
 2023 23:18:23 -0800 (PST)
MIME-Version: 1.0
References: <20230123082114.4291-1-hdanton@sina.com> <0000000000006b647005f2ece55e@google.com>
In-Reply-To: <0000000000006b647005f2ece55e@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Fri, 27 Jan 2023 08:18:11 +0100
Message-ID: <CACT4Y+bAbSBBYVnBGqZechS_aV=zX6J-B2wdUC_acYYkQur1kw@mail.gmail.com>
Subject: Re: [syzbot] [xfs?] KASAN: stack-out-of-bounds Read in xfs_buf_lock
To:     syzbot <syzbot+0bc698a422b5e4ac988c@syzkaller.appspotmail.com>,
        syzkaller <syzkaller@googlegroups.com>,
        Aleksandr Nogikh <nogikh@google.com>
Cc:     hdanton@sina.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 23 Jan 2023 at 12:42, syzbot
<syzbot+0bc698a422b5e4ac988c@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot tried to test the proposed patch but the build/boot failed:
>
> failed to delete instance: googleapi: Error 400: Invalid value for field =
'instance': 'ci-upstream-kasan-gce-root-test-job-parallel-test-job-parallel=
-1'. Must be a match of regex '[a-z](?:[-a-z0-9]{0,61}[a-z0-9])?|[1-9][0-9]=
{0,19}', invalid

+Aleksandr, was this fixed already?

> syzkaller build log:
> go env (err=3D<nil>)
> GO111MODULE=3D"auto"
> GOARCH=3D"amd64"
> GOBIN=3D""
> GOCACHE=3D"/syzkaller/.cache/go-build"
> GOENV=3D"/syzkaller/.config/go/env"
> GOEXE=3D""
> GOEXPERIMENT=3D""
> GOFLAGS=3D""
> GOHOSTARCH=3D"amd64"
> GOHOSTOS=3D"linux"
> GOINSECURE=3D""
> GOMODCACHE=3D"/syzkaller/jobs-2/linux/gopath/pkg/mod"
> GONOPROXY=3D""
> GONOSUMDB=3D""
> GOOS=3D"linux"
> GOPATH=3D"/syzkaller/jobs-2/linux/gopath"
> GOPRIVATE=3D""
> GOPROXY=3D"https://proxy.golang.org,direct"
> GOROOT=3D"/usr/local/go"
> GOSUMDB=3D"sum.golang.org"
> GOTMPDIR=3D""
> GOTOOLDIR=3D"/usr/local/go/pkg/tool/linux_amd64"
> GOVCS=3D""
> GOVERSION=3D"go1.17"
> GCCGO=3D"gccgo"
> AR=3D"ar"
> CC=3D"gcc"
> CXX=3D"g++"
> CGO_ENABLED=3D"1"
> GOMOD=3D"/syzkaller/jobs-2/linux/gopath/src/github.com/google/syzkaller/g=
o.mod"
> CGO_CFLAGS=3D"-g -O2"
> CGO_CPPFLAGS=3D""
> CGO_CXXFLAGS=3D"-g -O2"
> CGO_FFLAGS=3D"-g -O2"
> CGO_LDFLAGS=3D"-g -O2"
> PKG_CONFIG=3D"pkg-config"
> GOGCCFLAGS=3D"-fPIC -m64 -pthread -fmessage-length=3D0 -fdebug-prefix-map=
=3D/tmp/go-build480514578=3D/tmp/go-build -gno-record-gcc-switches"
>
> git status (err=3D<nil>)
> HEAD detached at 1dac8c7a0
> nothing to commit, working tree clean
>
>
> tput: No value for $TERM and no -T specified
> tput: No value for $TERM and no -T specified
> Makefile:32: run command via tools/syz-env for best compatibility, see:
> Makefile:33: https://github.com/google/syzkaller/blob/master/docs/contrib=
uting.md#using-syz-env
> go list -f '{{.Stale}}' ./sys/syz-sysgen | grep -q false || go install ./=
sys/syz-sysgen
> make .descriptions
> tput: No value for $TERM and no -T specified
> tput: No value for $TERM and no -T specified
> bin/syz-sysgen
> touch .descriptions
> GOOS=3Dlinux GOARCH=3Damd64 go build "-ldflags=3D-s -w -X github.com/goog=
le/syzkaller/prog.GitRevision=3D1dac8c7a01e2bdd35cb04eb4901ddb157291ac2d -X=
 'github.com/google/syzkaller/prog.gitRevisionDate=3D20230103-123455'" "-ta=
gs=3Dsyz_target syz_os_linux syz_arch_amd64 " -o ./bin/linux_amd64/syz-fuzz=
er github.com/google/syzkaller/syz-fuzzer
> GOOS=3Dlinux GOARCH=3Damd64 go build "-ldflags=3D-s -w -X github.com/goog=
le/syzkaller/prog.GitRevision=3D1dac8c7a01e2bdd35cb04eb4901ddb157291ac2d -X=
 'github.com/google/syzkaller/prog.gitRevisionDate=3D20230103-123455'" "-ta=
gs=3Dsyz_target syz_os_linux syz_arch_amd64 " -o ./bin/linux_amd64/syz-exec=
prog github.com/google/syzkaller/tools/syz-execprog
> GOOS=3Dlinux GOARCH=3Damd64 go build "-ldflags=3D-s -w -X github.com/goog=
le/syzkaller/prog.GitRevision=3D1dac8c7a01e2bdd35cb04eb4901ddb157291ac2d -X=
 'github.com/google/syzkaller/prog.gitRevisionDate=3D20230103-123455'" "-ta=
gs=3Dsyz_target syz_os_linux syz_arch_amd64 " -o ./bin/linux_amd64/syz-stre=
ss github.com/google/syzkaller/tools/syz-stress
> mkdir -p ./bin/linux_amd64
> gcc -o ./bin/linux_amd64/syz-executor executor/executor.cc \
>         -m64 -O2 -pthread -Wall -Werror -Wparentheses -Wunused-const-vari=
able -Wframe-larger-than=3D16384 -Wno-stringop-overflow -Wno-array-bounds -=
Wno-format-overflow -static-pie -fpermissive -w -DGOOS_linux=3D1 -DGOARCH_a=
md64=3D1 \
>         -DHOSTGOOS_linux=3D1 -DGIT_REVISION=3D\"1dac8c7a01e2bdd35cb04eb49=
01ddb157291ac2d\"
>
>
>
> Tested on:
>
> commit:         7dd4b804 Merge tag 'nfsd-6.2-3' of git://git.kernel.or..
> git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/=
linux.git
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3D2b6ecad960fc7=
03e
> dashboard link: https://syzkaller.appspot.com/bug?extid=3D0bc698a422b5e4a=
c988c
> compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binuti=
ls for Debian) 2.35.2
> patch:          https://syzkaller.appspot.com/x/patch.diff?x=3D145887ee48=
0000
