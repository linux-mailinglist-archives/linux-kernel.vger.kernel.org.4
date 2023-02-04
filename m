Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3355668A89C
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Feb 2023 07:41:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232568AbjBDGlM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Feb 2023 01:41:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjBDGlK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Feb 2023 01:41:10 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E93B61E5DA
        for <linux-kernel@vger.kernel.org>; Fri,  3 Feb 2023 22:41:07 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 668C060AF2
        for <linux-kernel@vger.kernel.org>; Sat,  4 Feb 2023 06:41:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0AABC433B0
        for <linux-kernel@vger.kernel.org>; Sat,  4 Feb 2023 06:41:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675492866;
        bh=a3elunWF9f0UJFqvpeUSP9fsOo0UOqQZhqxxpsLRSAc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Pc++0J3W0HR20jcYoRrTbxv/HQbiBNtmnlMaxDvQWiY1i/cynUjsfbbe5ek9F7PLX
         C7wlOj+HCRqublorlruTr4935LqslDN4QOrsWqbVY9Lz3bnfnpL0NTrTR5nFHaEWN1
         +CVdYQLVr7Wvig29b5S/z5ixChVLeySwAk/jzU5/VrAetXLItkx4n8so/bw7YMx1VA
         LOLanDxlAPS8fhs/ObMV4I0aiw6I5Gi7G4+Plnls8p/w7cU8bUL4M3jvs3K8aRQJsK
         jqpdZmfUDW0X+a/jMkZMCAi+I5UeTx+2yeDAYsvK8yBw+uIRWUk5alrLLNDxNUYULM
         fftQ+bgFXtI2g==
Received: by mail-ej1-f49.google.com with SMTP id mf7so20982589ejc.6
        for <linux-kernel@vger.kernel.org>; Fri, 03 Feb 2023 22:41:06 -0800 (PST)
X-Gm-Message-State: AO0yUKUmCZw4HQD9H0FxgtNLIFbNiLkHiPkamdZYb/alypT7FLv5bwl+
        PCJb0SkRWtlPjsIrRcWen2I1gKWRqlGNnCFZ48A=
X-Google-Smtp-Source: AK7set+VJ5xpZAoVX9GB41i301CKKJDM9pDqAdwi1mmTbmRK8LC8Q0FmW2phiJYJ3bz8MFify8K2Q6meLIU3QfKIHac=
X-Received: by 2002:a17:906:8419:b0:884:c19c:7c6 with SMTP id
 n25-20020a170906841900b00884c19c07c6mr3440661ejx.120.1675492864694; Fri, 03
 Feb 2023 22:41:04 -0800 (PST)
MIME-Version: 1.0
References: <20230112090603.1295340-1-guoren@kernel.org> <c68bac83-5c88-80b1-bac9-e1fd4ea8f07e@yadro.com>
In-Reply-To: <c68bac83-5c88-80b1-bac9-e1fd4ea8f07e@yadro.com>
From:   Guo Ren <guoren@kernel.org>
Date:   Sat, 4 Feb 2023 14:40:52 +0800
X-Gmail-Original-Message-ID: <CAJF2gTQm11px3mqyrNk1SRiJZud1yeY2avK99UX9KetWAGe5BA@mail.gmail.com>
Message-ID: <CAJF2gTQm11px3mqyrNk1SRiJZud1yeY2avK99UX9KetWAGe5BA@mail.gmail.com>
Subject: Re: [PATCH -next V7 0/7] riscv: Optimize function trace
To:     Evgenii Shatokhin <e.shatokhin@yadro.com>
Cc:     suagrfillet@gmail.com, andy.chiu@sifive.com,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Guo Ren <guoren@linux.alibaba.com>, anup@brainfault.org,
        paul.walmsley@sifive.com, palmer@dabbelt.com,
        conor.dooley@microchip.com, heiko@sntech.de, rostedt@goodmis.org,
        mhiramat@kernel.org, jolsa@redhat.com, bp@suse.de,
        jpoimboe@kernel.org, linux@yadro.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 16, 2023 at 11:02 PM Evgenii Shatokhin
<e.shatokhin@yadro.com> wrote:
>
> Hi,
>
> On 12.01.2023 12:05, guoren@kernel.org wrote:
> > From: Guo Ren <guoren@linux.alibaba.com>
> >
> > The previous ftrace detour implementation fc76b8b8011 ("riscv: Using
> > PATCHABLE_FUNCTION_ENTRY instead of MCOUNT") contain three problems.
> >
> >   - The most horrible bug is preemption panic which found by Andy [1].
> >     Let's disable preemption for ftrace first, and Andy could continue
> >     the ftrace preemption work.
>
> It seems, the patches #2-#7 of this series do not require "riscv:
> ftrace: Fixup panic by disabling preemption" and can be used without it.
>
> How about moving that patch out of the series and processing it separately?
Okay.

>
> As it was pointed out in the discussion of that patch, some other
> solution to non-atomic changes of the prologue might be needed anyway.
I think you mean Mark Rutland's DYNAMIC_FTRACE_WITH_CALL_OPS. But that
still needs to be ready. Let's disable PREEMPT for ftrace first.

>
> >   - The "-fpatchable-function-entry= CFLAG" wasted code size
> >     !RISCV_ISA_C.
> >   - The ftrace detour implementation wasted code size.
> >   - When livepatching, the trampoline (ftrace_regs_caller) would not
> >     return to <func_prolog+12> but would rather jump to the new function.
> >     So, "REG_L ra, -SZREG(sp)" would not run and the original return
> >     address would not be restored. The kernel is likely to hang or crash
> >     as a result. (Found by Evgenii Shatokhin [4])
> >
> > Patches 1,2,3 fixup above problems.
> >
> > Patches 4,5,6,7 are the features based on reduced detour code
> > patch, we include them in the series for test and maintenance.
> >
> > You can directly try it with:
> > https://github.com/guoren83/linux/tree/ftrace_fixup_v7
> >
> > Make function graph use ftrace directly [2] (patch 4, 5)
> > ========================================================
> >
> > In RISC-V architecture, when we enable the ftrace_graph tracer on some
> > functions, the function tracings on other functions will suffer extra
> > graph tracing work. In essence, graph_ops isn't limited by its func_hash
> > due to the global ftrace_graph_[regs]_call label. That should be
> > corrected.
> >
> > What inspires me is the commit 0c0593b45c9b ("x86/ftrace: Make function
> > graph use ftrace directly") that uses graph_ops::func function to
> > install return_hooker and makes the function called against its
> > func_hash.
> >
> > This series of patches makes function graph use ftrace directly for
> > riscv.
> >
> > If FTRACE_WITH_REGS isn't defined, ftrace_caller keeps ftrace_graph_call
> > so that it can be replaced with the calling of prepare_ftrace_return by
> > the enable/disable helper.
> >
> > As for defining FTRACE_WITH_REGS, ftrace_caller is adjusted to save the
> > necessary regs against the pt_regs layout, so it can reasonably call the
> > graph_ops::func function - ftrace_graph_func. And
> > ftrace_graph_[regs]_call
> > and its enable/disable helper aren't needed.
> >
> > Test log:
> >
> > The tests generated by CONFIG_FTRACE_STARTUP_TEST have passed in the
> > local
> > qemu-system-riscv64 virt machine. The following is the log during
> > startup.
> >
> > ```
> > Nov 15 03:07:13 stage4 kernel: Testing tracer function: PASSED
> > Nov 15 03:07:13 stage4 kernel: Testing dynamic ftrace: PASSED
> > Nov 15 03:07:13 stage4 kernel: Testing dynamic ftrace ops #1:
> > Nov 15 03:07:13 stage4 kernel: (1 0 1 0 0)
> > Nov 15 03:07:13 stage4 kernel: (1 1 2 0 0)
> > Nov 15 03:07:13 stage4 kernel: (2 1 3 0 365)
> > Nov 15 03:07:13 stage4 kernel: (2 2 4 0 399)
> > Nov 15 03:07:13 stage4 kernel: (3 2 4 0 146071)
> > Nov 15 03:07:13 stage4 kernel: (3 3 5 0 146105) PASSED
> > Nov 15 03:07:13 stage4 kernel: Testing dynamic ftrace ops #2:
> > Nov 15 03:07:13 stage4 kernel: (1 0 1 589 0)
> > Nov 15 03:07:13 stage4 kernel: (1 1 2 635 0)
> > Nov 15 03:07:13 stage4 kernel: (2 1 3 1 2)
> > Nov 15 03:07:13 stage4 kernel: (2 2 4 125 126)
> > Nov 15 03:07:13 stage4 kernel: (3 2 4 146001 146078)
> > Nov 15 03:07:13 stage4 kernel: (3 3 5 146035 146112) PASSED
> > Nov 15 03:07:13 stage4 kernel: Testing ftrace recursion: PASSED
> > Nov 15 03:07:13 stage4 kernel: Testing ftrace recursion safe: PASSED
> > Nov 15 03:07:13 stage4 kernel: Testing ftrace regs: PASSED
> > Nov 15 03:07:13 stage4 kernel: Testing tracer nop: PASSED
> > Nov 15 03:07:13 stage4 kernel: Testing tracer irqsoff: PASSED
> > Nov 15 03:07:13 stage4 kernel: Testing tracer wakeup:
> > Nov 15 03:07:13 stage4 kernel: sched: DL replenish lagged too much
> > Nov 15 03:07:13 stage4 kernel: PASSED
> > Nov 15 03:07:13 stage4 kernel: Testing tracer wakeup_rt: PASSED
> > Nov 15 03:07:13 stage4 kernel: Testing tracer wakeup_dl: PASSED
> > Nov 15 03:07:13 stage4 kernel: Testing tracer function_graph: PASSED
> > ```
> >
> > Add WITH_DIRECT_CALLS support [3] (patch 6, 7)
> > ==============================================
> >
> > This series adds DYNAMIC_FTRACE_WITH_DIRECT_CALLS support for RISC-V.
> > SAMPLE_FTRACE_DIRECT and SAMPLE_FTRACE_DIRECT_MULTI are also included
> > here as the samples for testing DIRECT_CALLS related interface.
> >
> > First, select the DYNAMIC_FTRACE_WITH_DIRECT_CALLS to provide
> > register_ftrace_direct[_multi] interfaces allowing user to register
> > the customed trampoline (direct_caller) as the mcount for one or
> > more target functions. And modify_ftrace_direct[_multi] are also
> > provided for modify direct_caller.
> >
> > At the same time, the samples in ./samples/ftrace/ can be built
> > as kerenl module for testing these interfaces with SAMPLE_FTRACE_DIRECT
> > and SAMPLE_FTRACE_DIRECT_MULTI selected.
> >
> > Second, to make the direct_caller and the other ftrace hooks
> > (eg. function/fgraph tracer, k[ret]probes) co-exist, a temporary
> > register
> > are nominated to store the address of direct_caller in
> > ftrace_regs_caller.
> > After the setting of the address direct_caller by direct_ops->func and
> > the RESTORE_REGS in ftrace_regs_caller, direct_caller will be jumped to
> > by the `jr` inst.
> >
> > The following tests have been passed in my local qemu-riscv64 virt
> > machine.
> >
> > 1. tests with CONFIG_FTRACE_STARTUP_TEST
> > 2. tests of samples/ftrace/ftrace*.ko
> > 3. manual tests with any combination of the following hooks
> >    - function/function_graph tracer
> >    - ftrace*.ko
> >    - kprobe/kretprobe
> >
> > For your reference, here is the log when function tracer, kretprobe and
> > ftrace-direct-too.ko co-hooks the handle_mm_fault function.
> >
> > ```
> > [root@stage4 tracing]# echo handle_mm_fault > set_ftrace_filter
> > [root@stage4 tracing]# echo 'r:myr handle_mm_fault' > kprobe_events
> > [root@stage4 tracing]# echo function > current_tracer
> > [root@stage4 tracing]# echo 1 > events/kprobes/myr/enable
> > [root@stage4 tracing]# insmod /root/ftrace-direct-too.ko
> > [root@stage4 tracing]#
> > [root@stage4 tracing]# cat trace | tail
> >               cat-388     [000] ...1.   583.051438: myr:
> > (do_page_fault+0x16c/0x5f2 <- handle_mm_fault)
> >               cat-388     [000] ...2.   583.057930: handle_mm_fault
> > <-do_page_fault
> >               cat-388     [000] .....   583.057990: my_direct_func:
> > handle mm fault vma=000000002d9fe19c address=ffffffae9b7000 flags=215
> >               cat-388     [000] ...1.   583.058284: myr:
> > (do_page_fault+0x16c/0x5f2 <- handle_mm_fault)
> >              tail-389     [001] ...2.   583.059062: handle_mm_fault
> > <-do_page_fault
> >              tail-389     [001] .....   583.059104: my_direct_func:
> > handle mm fault vma=0000000017f3c48e address=aaaaaabebf3000 flags=215
> >              tail-389     [001] ...1.   583.059325: myr:
> > (do_page_fault+0x16c/0x5f2 <- handle_mm_fault)
> >              tail-389     [001] ...2.   583.060371: handle_mm_fault
> > <-do_page_fault
> >              tail-389     [001] .....   583.060410: my_direct_func:
> > handle mm fault vma=0000000017f3c48e address=aaaaaabebf1000 flags=255
> >              tail-389     [001] ...1.   583.060996: myr:
> > (do_page_fault+0x16c/0x5f2 <- handle_mm_fault)
> > ```
> > Note1:
> >
> > The checkpatch.pl will output some warnings on this series, like this
> >
> > ```
> > WARNING: Prefer using '"%s...", __func__' to using 'my_direct_func2',
> > this function's name, in a string
> > 111: FILE: samples/ftrace/ftrace-direct-multi-modify.c:48:
> > +"       call my_direct_func2\n"
> > ```
> >
> > The reason is that checkpatch depends on patch context providing the
> > function name. In the above warning, my_direct_func2 has some codeline
> > distance with the changed trunk, so its declaration doesn't come into
> > the patch, and then the warning jumps out.
> >
> > You may notice the location of `my_ip` variable changes in the 2nd
> > patch. I did that for reducing the warnings to some extent. But killing
> > all the warnings will makes the patch less readable, so I stopped here.
> >
> > [1] https://lpc.events/event/16/contributions/1171/
> > [2] https://lore.kernel.org/lkml/20221120084230.910152-1-suagrfillet@gmail.com/
> > [3] https://lore.kernel.org/linux-riscv/20221123142025.1504030-1-suagrfillet@gmail.com/
> > [4] https://lore.kernel.org/linux-riscv/d7d5730b-ebef-68e5-5046-e763e1ee6164@yadro.com/
> >
> > Changes in v7:
> >   - Fixup RESTORE_ABI_REGS by remove PT_T0(sp) overwrite.
> >   - Add FTRACE_MCOUNT_USE_PATCHABLE_FUNCTION_ENTRY
> >   - Fixup kconfig with HAVE_SAMPLE_FTRACE_DIRECT &
> >     HAVE_SAMPLE_FTRACE_DIRECT_MULTI
> >
> > Changes in v6:
> > https://lore.kernel.org/linux-riscv/20230107133549.4192639-1-guoren@kernel.org/
> >   - Replace 8 with MCOUNT_INSN_SIZE
> >   - Replace "REG_L a1, PT_RA(sp)" with "mv a1, ra"
> >   - Add Evgenii Shatokhin comment
> >
> > Changes in v5:
> > https://lore.kernel.org/linux-riscv/20221208091244.203407-1-guoren@kernel.org/
> >   - Sort Kconfig entries in alphabetical order.
> >
> > Changes in v4:
> > https://lore.kernel.org/linux-riscv/20221129033230.255947-1-guoren@kernel.org/
> >   - Include [3] for maintenance. [Song Shuai]
> >
> > Changes in V3:
> > https://lore.kernel.org/linux-riscv/20221123153950.2911981-1-guoren@kernel.org/
> >   - Include [2] for maintenance. [Song Shuai]
> >
> > Changes in V2:
> > https://lore.kernel.org/linux-riscv/20220921034910.3142465-1-guoren@kernel.org/
> >   - Add Signed-off for preemption fixup.
> >
> > Changes in V1:
> > https://lore.kernel.org/linux-riscv/20220916103817.9490-1-guoren@kernel.org/
> >
> > Andy Chiu (1):
> >    riscv: ftrace: Fixup panic by disabling preemption
> >
> > Guo Ren (2):
> >    riscv: ftrace: Remove wasted nops for !RISCV_ISA_C
> >    riscv: ftrace: Reduce the detour code size to half
> >
> > Song Shuai (4):
> >    riscv: ftrace: Add ftrace_graph_func
> >    riscv: ftrace: Add DYNAMIC_FTRACE_WITH_DIRECT_CALLS support
> >    samples: ftrace: Add riscv support for SAMPLE_FTRACE_DIRECT[_MULTI]
> >    riscv : select FTRACE_MCOUNT_USE_PATCHABLE_FUNCTION_ENTRY
> >
> >   arch/riscv/Kconfig                          |   6 +-
> >   arch/riscv/Makefile                         |   6 +-
> >   arch/riscv/include/asm/ftrace.h             |  71 ++++++--
> >   arch/riscv/kernel/ftrace.c                  |  91 ++++------
> >   arch/riscv/kernel/mcount-dyn.S              | 179 +++++++++++++-------
> >   samples/ftrace/ftrace-direct-modify.c       |  33 ++++
> >   samples/ftrace/ftrace-direct-multi-modify.c |  37 ++++
> >   samples/ftrace/ftrace-direct-multi.c        |  22 +++
> >   samples/ftrace/ftrace-direct-too.c          |  26 +++
> >   samples/ftrace/ftrace-direct.c              |  22 +++
> >   10 files changed, 356 insertions(+), 137 deletions(-)
> >
> > --
> > 2.36.1
> >
> >
>
> I tested this series a bit on top of 6.2-rc4, with
> https://github.com/sugarfillet/linux/commit/9539a80dc6e7d1137ec7a96ebef2ab912a694bd7.patch
> added.
>
> The kernel was built with CONFIG_DYNAMIC_FTRACE_WITH_REGS=y and
> CONFIG_RISCV_ISA_C=y.
>
> Here are some results:
>
> * The kernel was built without visible issues.
>
> * Most of the Ftrace startup tests ran and passed. Certain
> event-specific tests caused soft lockups in one of the test runs but
> they are likely unrelated to this patchset and could happen without it too.
>
> * "function" and "function_graph" tracers worked in my simple use cases.
>
> * "ipmodify" functionality worked.
>
> * kprobe sample modules worked OK, which is good, because they actually
> use Ftrace: they plant the probes at the beginning of the resp. functions.
Thx for test

>
> * ftrace-direct-multi and ftrace-direct-multi-modify sample modules
> reported possibly invalid data. More info - in my reply to
> "[PATCH -next V7 6/7] samples: ftrace: Add riscv support for
> SAMPLE_FTRACE_DIRECT[_MULTI]"
Good report! We will solve it in the next version.

>
> Regards,
> Evgenii
>



--
Best Regards
 Guo Ren
