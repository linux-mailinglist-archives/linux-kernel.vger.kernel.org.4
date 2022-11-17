Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56BB562E26D
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 18:00:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234843AbiKQRAn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 12:00:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240176AbiKQRAe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 12:00:34 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0E6874AAE
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 09:00:27 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id e13so3442711edj.7
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 09:00:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jd4p2I7yGB7uWXZ+VfF85da9wsvFoB37KC6Iup0lcCs=;
        b=mItNrmeKOWJic33I0H+R7Or2QVOdG/EUlgrUh0J+bFQbDVzXktteuvM/pncfMeeLln
         GgDUHHweavvIurNhrkVQ+ZTVLLKLc7v0G89NUj0FPZi7ciRWGEZQxBBfCEUNCvPDi7ai
         sudckKEcfF60Zxz++RhsyMWtwzjS9Owjyu9LBZSoxElgYJWFSjm1csNRrxJh2y+wDGua
         +0d5sQWVndemdjYSbFlnpxLKBFVUFiAqExuaQPu40+NqOjkaAzAQNyU0gK3OHQgPk5ib
         k3WitKkGTkRoMq36fblaqhKrsEYlAeT6ZV8tSgiDGp4zV3hvIqj1tu4FfHljRsAHkl6l
         t5qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Jd4p2I7yGB7uWXZ+VfF85da9wsvFoB37KC6Iup0lcCs=;
        b=Uya05r79rSZnsXHl3Ye8WddyH6tv4t2oeh0hT8m5iRBBbt3e5EM0RxPcT6Qw4PvekZ
         ydaXu7Tg2d9bWfYuzjGYWgaNhqzQq29lQOgNyyYh2DcNJ1D+HRcZOgYUiiCY2cg0Qwkg
         h9ipw668VrYD8A/+ugIgihfja5jyLrHQNXRMiFSD3kTNvRSxqN8hfXBunkl6Wiiy7XTx
         0a04SVEu72zBVceAR/PeU1nVJiD7f29DGrX+NF6v4pbZ4jn5GppEg5raY3QtiLc60Akk
         N5SoW0kH9WzmT/k1e+Fu0nhzjGmMycuf7F1cbggUxbqs7dqw7UOsyUZTmkUFaNwu5CSL
         XcaA==
X-Gm-Message-State: ANoB5pl2G7BO50K+Q28r3BH1DrAk+rTxlIeP0gmGA29zUdzNV4fHvdyI
        0HOdCNiqwJ8qpgkbhXS4eqfhT/ncR1vqqhYrl9s=
X-Google-Smtp-Source: AA0mqf7ejQxsQfL6QGbuZ+L/XO88BdSqQGwZENnpBDOdbxudB0aNKTHU8nIzCYS1UqKPiXtRCktPfWrXH+vxOWkXENI=
X-Received: by 2002:a05:6402:2421:b0:461:524f:a8f4 with SMTP id
 t33-20020a056402242100b00461524fa8f4mr1050230eda.260.1668704426099; Thu, 17
 Nov 2022 09:00:26 -0800 (PST)
MIME-Version: 1.0
References: <Y3Yy5DFEoCEBv/Qi@kernel.org>
In-Reply-To: <Y3Yy5DFEoCEBv/Qi@kernel.org>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 17 Nov 2022 09:00:14 -0800
Message-ID: <CAEf4BzZT28PrpSNdGU29X0aRT6nQrGwm168apmKOre4giZkv-g@mail.gmail.com>
Subject: Re: Building perf with BUILD_BPF_SKEL=1
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc:     Namhyung Kim <namhyung@kernel.org>,
        Song Liu <songliubraving@fb.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 17, 2022 at 5:11 AM Arnaldo Carvalho de Melo
<arnaldo.melo@gmail.com> wrote:
>
> Hi guys,
>
>         At some point we should switch to building with BPF skels by
> default as there are many features that are implemented that way in
> perf:
>
> =E2=AC=A2[acme@toolbox perf]$ ls -la tools/perf/util/bpf_skel/
> total 464
> drwxr-xr-x. 1 acme acme  334 Oct 14 10:28 .
> drwxr-xr-x. 1 acme acme 7380 Nov 17 09:22 ..
> -rw-r--r--. 1 acme acme 5581 Oct 14 10:28 bperf_cgroup.bpf.c
> -rw-r--r--. 1 acme acme 1764 Mar 14  2022 bperf_follower.bpf.c
> -rw-r--r--. 1 acme acme 1438 Mar 14  2022 bperf_leader.bpf.c
> -rw-r--r--. 1 acme acme  285 Mar 14  2022 bperf_u.h
> -rw-r--r--. 1 acme acme 2290 Mar 14  2022 bpf_prog_profiler.bpf.c
> -rw-r--r--. 1 acme acme 2164 Mar 27  2022 func_latency.bpf.c
> -rw-r--r--. 1 acme acme   53 Nov  6  2021 .gitignore
> -rw-r--r--. 1 acme acme 9017 Sep 27 09:29 kwork_trace.bpf.c
> -rw-r--r--. 1 acme acme 3691 Oct  6 08:03 lock_contention.bpf.c
> -rw-r--r--. 1 acme acme 6102 Oct  4 08:55 off_cpu.bpf.c
> =E2=AC=A2[acme@toolbox perf]$
>
>
> Since I'm finally using the Firefly ARM board the fine folks at
> Librecomputer gave us at Kernel Recipes, I'm noticing issues as I go on
> adding the components, for instance:
>
> /bin/sh: 2: llvm-strip: not found
> make[2]: *** [Makefile.perf:1136: /tmp/build/perf/util/bpf_skel/.tmp/bper=
f_follower.bpf.o] Error 127
> make[2]: *** Waiting for unfinished jobs....
> /bin/sh: 2: llvm-strip: not found
> make[2]: *** [Makefile.perf:1136: /tmp/build/perf/util/bpf_skel/.tmp/bpf_=
prog_profiler.bpf.o] Error 127
> /bin/sh: 2: llvm-strip: not found
> make[2]: *** [Makefile.perf:1136: /tmp/build/perf/util/bpf_skel/.tmp/bper=
f_leader.bpf.o] Error 127
> /bin/sh: 2: llvm-strip: not found
> make[2]: *** [Makefile.perf:1136: /tmp/build/perf/util/bpf_skel/.tmp/func=
_latency.bpf.o] Error 127
> /bin/sh: 2: llvm-strip: not found
> make[2]: *** [Makefile.perf:1136: /tmp/build/perf/util/bpf_skel/.tmp/bper=
f_cgroup.bpf.o] Error 127
> make[1]: *** [Makefile.perf:240: sub-make] Error 2
> make: *** [Makefile:113: install-bin] Error 2
> make: Leaving directory '/home/acme/git/perf/tools/perf'
>
> So this is just me taking notes, feel free to fix it if you want ;-)
>
> acme@roc-rk3399-pc:~/git/perf$ cat /etc/os-release
> PRETTY_NAME=3D"Ubuntu 22.04.1 LTS"
> NAME=3D"Ubuntu"
> VERSION_ID=3D"22.04"
> VERSION=3D"22.04.1 LTS (Jammy Jellyfish)"
> VERSION_CODENAME=3Djammy
> ID=3Dubuntu
> ID_LIKE=3Ddebian
> HOME_URL=3D"https://www.ubuntu.com/"
> SUPPORT_URL=3D"https://help.ubuntu.com/"
> BUG_REPORT_URL=3D"https://bugs.launchpad.net/ubuntu/"
> PRIVACY_POLICY_URL=3D"https://www.ubuntu.com/legal/terms-and-policies/pri=
vacy-policy"
> UBUNTU_CODENAME=3Djammy
> acme@roc-rk3399-pc:~/git/perf$
>
> perf should check for that and give per-distro hints on how to overcome
> those, for instance, on ubuntu I had to:

there is no need to use llvm-strip anymore, if you use BPF static
linking (even if for single .bpf.o file). We do `bpftool obj gen` and
that effectively strips away DWARF.

>
> acme@roc-rk3399-pc:~/git/perf$ dpkg -L llvm-14 | grep strip
> /usr/share/man/man1/llvm-strip-14.1.gz
> /usr/bin/llvm-bitcode-strip-14
> /usr/bin/llvm-strip-14
> /usr/lib/llvm-14/bin/llvm-bitcode-strip
> /usr/lib/llvm-14/bin/llvm-strip
> acme@roc-rk3399-pc:~/git/perf$ export PATH=3D$PATH:/usr/lib/llvm-14/bin
>
>
> and now:
>

[...]
