Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52A315FB803
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 18:11:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230152AbiJKQLT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 12:11:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbiJKQLR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 12:11:17 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C7FBA47C;
        Tue, 11 Oct 2022 09:11:12 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id e62so17027707yba.6;
        Tue, 11 Oct 2022 09:11:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=vx/i4FLHOiBcikAiz6lqx8qMyGl3xkt/GHSt8Bt/HGc=;
        b=coynS7KDkLZtM73+brpkJwrc2Gva+Eqcb/OYXg1s7sbirsQT3iUoZt2Z/8Ytc0ZnTm
         9bRkY2UXJ3vGiUX/Ywwm5/3uK9hS13ykS+XYPLdqeVJ0IKnHNrJm4aV/GpSrC+14Z8uf
         vTjvJY9sB20dWEMsB7TveF4nYYO8xWtHHnSF4AxxluCb3KHeY+xnxf2cFoNeJml1eLcu
         j7bNNFXs6IlcrkiS1cdckyAQn6vguIdDtekuvw8/kvy9d9EZAaL7dgbu2jNQv2e9g95A
         YzQ89L1eVzxdNA0AEmZkf/cGjLRfx3J622/+Jup2IKGjhYJi00WICSEoMe9UDOPpn4lW
         umlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vx/i4FLHOiBcikAiz6lqx8qMyGl3xkt/GHSt8Bt/HGc=;
        b=paRIwAq0mRzcdIQovmrRyjO9JOA0wHr33EZhAewFTm4eWOf+U0/l7IG95PURloL+XJ
         ZSyBZ+MjAI+5k9BcIncCuEloNrYCjF0nAEVHbhtY/CTBXycruu/JL2Id+AHL2Zq36/I1
         SNYBcoOx/hQcUBaDJyboNmTPaEc+mYPgYLVfjSm+yqsXl2q+S7kHfsz1TasQ58UVfn8L
         nQVrqNnZoeKgoV3bn2rt50bCVSlbNhgMcUp0YtJuzpy9zlfoGXy3olVyzgcrm0Jz83Wv
         lZ/oqiknejmgBJQRlHe7xCqLBgUnT8rNVDjMGJv+HiP4RR4tdRlbj7p0rBJK9sgn3BrO
         Q0og==
X-Gm-Message-State: ACrzQf2EE3Gdb8AL3O1XTnCU5c9pQn0iJ1KBIhk5pYBJVOh0yGiv84YS
        Mu57bjBJI4z73SHydUZGVJoVmxytUfCKj5MhNTxegtNyL+k=
X-Google-Smtp-Source: AMsMyM5fNSUzBEHycwQI5TfHiowXIh/3AO2kHM+sV2vQkDppfu0eXQgf9ZOtb40G9XbPbjrpP7yei5trSoP1ahno2PU=
X-Received: by 2002:a05:6902:1146:b0:6bd:f92b:b014 with SMTP id
 p6-20020a056902114600b006bdf92bb014mr24330713ybu.175.1665504671479; Tue, 11
 Oct 2022 09:11:11 -0700 (PDT)
MIME-Version: 1.0
References: <CAKXUXMzmfeF9K4SkUcR2i6T+ZqEXvwod4hOzCPfQowMJULy7eg@mail.gmail.com>
 <20221011155051.qgwfbbeeshvoaotj@revolver>
In-Reply-To: <20221011155051.qgwfbbeeshvoaotj@revolver>
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
Date:   Tue, 11 Oct 2022 18:11:00 +0200
Message-ID: <CAKXUXMxzsmQO=trGzA7DJVpLw6HTaRMrcYeyTfqeX-3r0-KaJw@mail.gmail.com>
Subject: Re: Observed recent memory leak in __anon_vma_prepare
To:     Liam Howlett <liam.howlett@oracle.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>,
        kernel-janitors <kernel-janitors@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        Matthew Wilcox <willy@infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URI_DOTEDU autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 11, 2022 at 5:51 PM Liam Howlett <liam.howlett@oracle.com> wrote:
>
> * Lukas Bulwahn <lukas.bulwahn@gmail.com> [221011 12:35]:
> > Dear Liam, dear Matthew, dear all,
> >
> > The reproducer for the 'memory leak in __anon_vma_prepare' bug (see
> > https://elisa-builder-00.iol.unh.edu/syzkaller-next/report?id=3113810b9abd3dfeb581759df93d3171d1a90f18)
> > is reproducible, it is triggering the memory leak on the current
> > mainline (commit 60bb8154d1d7), and it was not triggering on v6.0. My
> > build config is a x86_64 defconfig.
> >
> > My git bisection showed that:
> >
> > 524e00b36e8c547f5582eef3fb645a8d9fc5e3df is the first bad commit
> > commit 524e00b36e8c547f5582eef3fb645a8d9fc5e3df
> > Author: Liam R. Howlett <Liam.Howlett@Oracle.com>
> > Date:   Tue Sep 6 19:48:48 2022 +0000
> >
> > The git bisect log is below, note that the commits 7fdbd37da5c6,
> > d0cf3dd47f0d and 0c563f148043 are marked good in the git bisect as
> > they caused bugs "BUG: Bad rss-counter state mm: ... type:MM_ANONPAGES
> > val:2". This bug report might have overshadowed the actual issue, and
> > hence the bug might have been introduced earlier, but was only visible
> > once the Bad rss-counter state bug disappeared.
> >
> >
>
> ...
>
> > # first bad commit: [524e00b36e8c547f5582eef3fb645a8d9fc5e3df] mm:
> > remove rb tree.
> >
> >
> > If there is more information needed or other bisection to be done,
> > please let me know.
>
>
> Lukas,
>
> Thanks for the report.  I am trying to reproduce this issue and have not
> been able to trigger a memory leak.  So far I have built using the
> defconfig from arch/x86/configs/x86_64_defconfig and run the C code from
> the end of your report above.  It also produces some output that is not
> captured in your report.  Are you sure it's the defconfig being used?
>
> ------
> # ./repro
> write to /proc/sys/kernel/hung_task_check_interval_secs failed: No such
> file or directory
> write to /proc/sys/net/core/bpf_jit_kallsyms failed: No such file or
> directory
> write to /proc/sys/net/core/bpf_jit_harden failed: No such file or
> directory
> write to /proc/sys/kernel/softlockup_all_cpu_backtrace failed: No such
> file or directory
> ------
>
> Note your output does not mention softlockup or hung_task issues.  This
> is on 6.0.0-rc3-00207-g524e00b36e8c.  It is also worth noting that the
> resulting kernel does not have /sys/kernel/debug/kmemleak.
>
> I have also tested your reproducer with my own config which does have
> the kmemleak debug file, but it did not trigger a memory leak either.  I
> suspect I am missing a config option?  Are you using gcc or clang?
>

Liam,

This is how I am building the kernel:

make O=$BUILD defconfig && make O=$BUILD kvm_guest.config && \
./scripts/kconfig/merge_config.sh -O $BUILD -r $BUILD/.config
kernel/configs/syzkaller-recommended.config && \
make O=$BUILD -j`nproc`

My syzkaller-recommended.config is:

CONFIG_KCOV=y
CONFIG_KCOV_INSTRUMENT_ALL=y
CONFIG_KCOV_ENABLE_COMPARISONS=y
CONFIG_DEBUG_FS=y
CONFIG_DEBUG_KMEMLEAK=y
CONFIG_DEBUG_INFO=y
CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT=y
CONFIG_KALLSYMS=y
CONFIG_KALLSYMS_ALL=y
CONFIG_CONFIGFS_FS=y
CONFIG_SECURITYFS=y
# CONFIG_RANDOMIZE_BASE is not set
CONFIG_KASAN=y
CONFIG_KASAN_INLINE=y
CONFIG_FAULT_INJECTION=y
CONFIG_FAULT_INJECTION_DEBUG_FS=y
CONFIG_FAULT_INJECTION_USERCOPY=y
CONFIG_FAILSLAB=y
CONFIG_FAIL_PAGE_ALLOC=y
CONFIG_FAIL_MAKE_REQUEST=y
CONFIG_FAIL_IO_TIMEOUT=y
CONFIG_FAIL_FUTEX=y
CONFIG_LOCKDEP=y
CONFIG_PROVE_LOCKING=y
CONFIG_DEBUG_ATOMIC_SLEEP=y
CONFIG_PROVE_RCU=y
CONFIG_DEBUG_VM=y
CONFIG_FORTIFY_SOURCE=y
CONFIG_HARDENED_USERCOPY=y
CONFIG_LOCKUP_DETECTOR=y
CONFIG_SOFTLOCKUP_DETECTOR=y
CONFIG_HARDLOCKUP_DETECTOR=y
CONFIG_BOOTPARAM_HARDLOCKUP_PANIC=y
CONFIG_DETECT_HUNG_TASK=y
CONFIG_WQ_WATCHDOG=y
CONFIG_DEFAULT_HUNG_TASK_TIMEOUT=140
CONFIG_RCU_CPU_STALL_TIMEOUT=100


So, it is "defconfig" + syzkaller debug features; sorry for being a
bit too brief in my first report.

The gcc version is:
gcc (Debian 8.3.0-6) 8.3.0
Copyright (C) 2018 Free Software Foundation, Inc.
This is free software; see the source for copying conditions.  There is NO
warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.


But I doubt that the gcc version is really relevant.

I am running this in a pretty simple qemu instance. I can provide more
information on my qemu setup if needed.

Lukas
