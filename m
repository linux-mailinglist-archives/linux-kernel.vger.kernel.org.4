Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14F876658B9
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 11:14:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238523AbjAKKNT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 05:13:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238325AbjAKKMU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 05:12:20 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6976211172
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 02:11:17 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id q64so15386147pjq.4
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 02:11:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KHc91LrGmq4A7cTvful+3iiobKLVW5j6v6dgY6L22tM=;
        b=gDdCEFfyyXqGsavm6uOHxXhw06NR3BiU+egwUtKjys6V/C4n9systCCnWvnpwiatTM
         DM6Ld1YSkSYqyzOVLoJZhv5QOjxaHtd7tfTeK6KBTnv/dH6jHRSXSPsP79J4HPGM+lCR
         GIfclFsF38AVBVz3yfdjxSCYkkqJrmh67gNc8+DRMTKqG/IDyN6/7KtiTvDyCjbKhBE6
         rrc9Rihpc+8s4fDAW3UKkOvymvOgepRDjcBG+HOjUADAGg/7cZdIeMYEhQUYoFO9sz77
         11v39AqL/FhAKqLYOs9YE7h2ZgDl2tNj2HGXl1dihksMJpZPorg9s9tlV5Do9Elwl1k0
         Vdwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KHc91LrGmq4A7cTvful+3iiobKLVW5j6v6dgY6L22tM=;
        b=IBI4FnLLZa1eLzHanoI1sUjC/KlYVGJsEYAos43PTb2pBWTgevJP8Wm72vF2F0oo7A
         9HTiStAp1Uzb5dyyR7YTBIqMytf+0Vx9pQ7Ux05ljouuGurBUrVwyGYnB23fIPjZEuMR
         be8Z1AevPIjWgLQM0Mu4bmFZyQH4lFyyjs4mpJZZgunE86KagThg6rn1evDubuM7hTJX
         uk8HxdLTS10UdGyUUBgeH5MHMHNem+r9z1MKnQvqpE3ap4qHHJSHv7hruDLm44sVfpq+
         LgNDRaI4tCq3UDkYjs5M7ntclIPofhPObprn2v57Dof94W1REnuDH+PB0MqI9ra9HkRf
         RvwQ==
X-Gm-Message-State: AFqh2kogcQPfXlfXj3d7j3P5J9TLlQa4cOkNcD4CHi7TWcZH4hWSLhyi
        AwBS3X9COcLFgC21njQWFftCefxxKBa4R92ZilE=
X-Google-Smtp-Source: AMrXdXvaWHV0NJpotxkUP7nLkLAAetfmGDhsRpr43aY8Av8x8Ol/2SzqOEygtI/NRERkq6CHVgOMEUVoWGmm2VwK7R0=
X-Received: by 2002:a17:902:6b4b:b0:18e:6517:70cf with SMTP id
 g11-20020a1709026b4b00b0018e651770cfmr3563869plt.107.1673431876811; Wed, 11
 Jan 2023 02:11:16 -0800 (PST)
MIME-Version: 1.0
References: <20230107133549.4192639-1-guoren@kernel.org>
In-Reply-To: <20230107133549.4192639-1-guoren@kernel.org>
From:   Song Shuai <suagrfillet@gmail.com>
Date:   Wed, 11 Jan 2023 10:11:04 +0000
Message-ID: <CAAYs2=j1pM_XXjJietLceFcWydaXFMLYJmPQiYL2RUzK1g9r2A@mail.gmail.com>
Subject: Re: [PATCH -next V6 0/7] riscv: Optimize function trace
To:     guoren@kernel.org
Cc:     anup@brainfault.org, paul.walmsley@sifive.com, palmer@dabbelt.com,
        conor.dooley@microchip.com, heiko@sntech.de, rostedt@goodmis.org,
        mhiramat@kernel.org, jolsa@redhat.com, bp@suse.de,
        jpoimboe@kernel.org, andy.chiu@sifive.com, e.shatokhin@yadro.com,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Guo Ren <guoren@linux.alibaba.com>
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

<guoren@kernel.org> =E4=BA=8E2023=E5=B9=B41=E6=9C=887=E6=97=A5=E5=91=A8=E5=
=85=AD 13:36=E5=86=99=E9=81=93=EF=BC=9A
>
> From: Guo Ren <guoren@linux.alibaba.com>
>
> The previous ftrace detour implementation fc76b8b8011 ("riscv: Using
> PATCHABLE_FUNCTION_ENTRY instead of MCOUNT") contain three problems.
>
>  - The most horrible bug is preemption panic which found by Andy [1].
>    Let's disable preemption for ftrace first, and Andy could continue
>    the ftrace preemption work.
>  - The "-fpatchable-function-entry=3D CFLAG" wasted code size
>    !RISCV_ISA_C.
>  - The ftrace detour implementation wasted code size.
>  - When livepatching, the trampoline (ftrace_regs_caller) would not
>    return to <func_prolog+12> but would rather jump to the new function.
>    So, "REG_L ra, -SZREG(sp)" would not run and the original return
>    address would not be restored. The kernel is likely to hang or crash
>    as a result. (Found by Evgenii Shatokhin [4])
>
> Patches 1,2,3 fixup above problems.
>
> Patches 4,5,6,7 are the features based on reduced detour code
> patch, we include them in the series for test and maintenance.
>
> You can directly try it with:
> https://github.com/guoren83/linux/tree/ftrace_fixup_v6
>
This link is broken, maybe you forget to push the branch to remote.

And the patch ("riscv : select FTRACE_MCOUNT_USE_PATCHABLE_FUNCTION_ENTRY")
was folded in the PR ( https://github.com/guoren83/linux/pull/1 )
I guess you might omit it. Hope its debut in the next version.

> Make function graph use ftrace directly [2] (patch 4, 5)
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
>
> In RISC-V architecture, when we enable the ftrace_graph tracer on some
> functions, the function tracings on other functions will suffer extra
> graph tracing work. In essence, graph_ops isn't limited by its func_hash
> due to the global ftrace_graph_[regs]_call label. That should be
> corrected.
>
> What inspires me is the commit 0c0593b45c9b ("x86/ftrace: Make function
> graph use ftrace directly") that uses graph_ops::func function to
> install return_hooker and makes the function called against its
> func_hash.
>
> This series of patches makes function graph use ftrace directly for
> riscv.
>
> If FTRACE_WITH_REGS isn't defined, ftrace_caller keeps ftrace_graph_call
> so that it can be replaced with the calling of prepare_ftrace_return by
> the enable/disable helper.
>
> As for defining FTRACE_WITH_REGS, ftrace_caller is adjusted to save the
> necessary regs against the pt_regs layout, so it can reasonably call the
> graph_ops::func function - ftrace_graph_func. And
> ftrace_graph_[regs]_call
> and its enable/disable helper aren't needed.
>
> Test log:
>
> The tests generated by CONFIG_FTRACE_STARTUP_TEST have passed in the
> local
> qemu-system-riscv64 virt machine. The following is the log during
> startup.
>
> ```
> Nov 15 03:07:13 stage4 kernel: Testing tracer function: PASSED
> Nov 15 03:07:13 stage4 kernel: Testing dynamic ftrace: PASSED
> Nov 15 03:07:13 stage4 kernel: Testing dynamic ftrace ops #1:
> Nov 15 03:07:13 stage4 kernel: (1 0 1 0 0)
> Nov 15 03:07:13 stage4 kernel: (1 1 2 0 0)
> Nov 15 03:07:13 stage4 kernel: (2 1 3 0 365)
> Nov 15 03:07:13 stage4 kernel: (2 2 4 0 399)
> Nov 15 03:07:13 stage4 kernel: (3 2 4 0 146071)
> Nov 15 03:07:13 stage4 kernel: (3 3 5 0 146105) PASSED
> Nov 15 03:07:13 stage4 kernel: Testing dynamic ftrace ops #2:
> Nov 15 03:07:13 stage4 kernel: (1 0 1 589 0)
> Nov 15 03:07:13 stage4 kernel: (1 1 2 635 0)
> Nov 15 03:07:13 stage4 kernel: (2 1 3 1 2)
> Nov 15 03:07:13 stage4 kernel: (2 2 4 125 126)
> Nov 15 03:07:13 stage4 kernel: (3 2 4 146001 146078)
> Nov 15 03:07:13 stage4 kernel: (3 3 5 146035 146112) PASSED
> Nov 15 03:07:13 stage4 kernel: Testing ftrace recursion: PASSED
> Nov 15 03:07:13 stage4 kernel: Testing ftrace recursion safe: PASSED
> Nov 15 03:07:13 stage4 kernel: Testing ftrace regs: PASSED
> Nov 15 03:07:13 stage4 kernel: Testing tracer nop: PASSED
> Nov 15 03:07:13 stage4 kernel: Testing tracer irqsoff: PASSED
> Nov 15 03:07:13 stage4 kernel: Testing tracer wakeup:
> Nov 15 03:07:13 stage4 kernel: sched: DL replenish lagged too much
> Nov 15 03:07:13 stage4 kernel: PASSED
> Nov 15 03:07:13 stage4 kernel: Testing tracer wakeup_rt: PASSED
> Nov 15 03:07:13 stage4 kernel: Testing tracer wakeup_dl: PASSED
> Nov 15 03:07:13 stage4 kernel: Testing tracer function_graph: PASSED
> ```
>
> Add WITH_DIRECT_CALLS support [3] (patch 6, 7)
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> This series adds DYNAMIC_FTRACE_WITH_DIRECT_CALLS support for RISC-V.
> SAMPLE_FTRACE_DIRECT and SAMPLE_FTRACE_DIRECT_MULTI are also included
> here as the samples for testing DIRECT_CALLS related interface.
>
> First, select the DYNAMIC_FTRACE_WITH_DIRECT_CALLS to provide
> register_ftrace_direct[_multi] interfaces allowing user to register
> the customed trampoline (direct_caller) as the mcount for one or
> more target functions. And modify_ftrace_direct[_multi] are also
> provided for modify direct_caller.
>
> At the same time, the samples in ./samples/ftrace/ can be built
> as kerenl module for testing these interfaces with SAMPLE_FTRACE_DIRECT
> and SAMPLE_FTRACE_DIRECT_MULTI selected.
>
> Second, to make the direct_caller and the other ftrace hooks
> (eg. function/fgraph tracer, k[ret]probes) co-exist, a temporary
> register
> are nominated to store the address of direct_caller in
> ftrace_regs_caller.
> After the setting of the address direct_caller by direct_ops->func and
> the RESTORE_REGS in ftrace_regs_caller, direct_caller will be jumped to
> by the `jr` inst.
>
> The following tests have been passed in my local qemu-riscv64 virt
> machine.
>
> 1. tests with CONFIG_FTRACE_STARTUP_TEST
> 2. tests of samples/ftrace/ftrace*.ko
> 3. manual tests with any combination of the following hooks
>   - function/function_graph tracer
>   - ftrace*.ko
>   - kprobe/kretprobe
>
> For your reference, here is the log when function tracer, kretprobe and
> ftrace-direct-too.ko co-hooks the handle_mm_fault function.
>
> ```
> [root@stage4 tracing]# echo handle_mm_fault > set_ftrace_filter
> [root@stage4 tracing]# echo 'r:myr handle_mm_fault' > kprobe_events
> [root@stage4 tracing]# echo function > current_tracer
> [root@stage4 tracing]# echo 1 > events/kprobes/myr/enable
> [root@stage4 tracing]# insmod /root/ftrace-direct-too.ko
> [root@stage4 tracing]#
> [root@stage4 tracing]# cat trace | tail
>              cat-388     [000] ...1.   583.051438: myr:
> (do_page_fault+0x16c/0x5f2 <- handle_mm_fault)
>              cat-388     [000] ...2.   583.057930: handle_mm_fault
> <-do_page_fault
>              cat-388     [000] .....   583.057990: my_direct_func:
> handle mm fault vma=3D000000002d9fe19c address=3Dffffffae9b7000 flags=3D2=
15
>              cat-388     [000] ...1.   583.058284: myr:
> (do_page_fault+0x16c/0x5f2 <- handle_mm_fault)
>             tail-389     [001] ...2.   583.059062: handle_mm_fault
> <-do_page_fault
>             tail-389     [001] .....   583.059104: my_direct_func:
> handle mm fault vma=3D0000000017f3c48e address=3Daaaaaabebf3000 flags=3D2=
15
>             tail-389     [001] ...1.   583.059325: myr:
> (do_page_fault+0x16c/0x5f2 <- handle_mm_fault)
>             tail-389     [001] ...2.   583.060371: handle_mm_fault
> <-do_page_fault
>             tail-389     [001] .....   583.060410: my_direct_func:
> handle mm fault vma=3D0000000017f3c48e address=3Daaaaaabebf1000 flags=3D2=
55
>             tail-389     [001] ...1.   583.060996: myr:
> (do_page_fault+0x16c/0x5f2 <- handle_mm_fault)
> ```
> Note1:
>
> The checkpatch.pl will output some warnings on this series, like this
>
> ```
> WARNING: Prefer using '"%s...", __func__' to using 'my_direct_func2',
> this function's name, in a string
> 111: FILE: samples/ftrace/ftrace-direct-multi-modify.c:48:
> +"       call my_direct_func2\n"
> ```
>
> The reason is that checkpatch depends on patch context providing the
> function name. In the above warning, my_direct_func2 has some codeline
> distance with the changed trunk, so its declaration doesn't come into
> the patch, and then the warning jumps out.
>
> You may notice the location of `my_ip` variable changes in the 2nd
> patch. I did that for reducing the warnings to some extent. But killing
> all the warnings will makes the patch less readable, so I stopped here.
>
> [1] https://lpc.events/event/16/contributions/1171/
> [2] https://lore.kernel.org/lkml/20221120084230.910152-1-suagrfillet@gmai=
l.com/
> [3] https://lore.kernel.org/linux-riscv/20221123142025.1504030-1-suagrfil=
let@gmail.com/
> [4] https://lore.kernel.org/linux-riscv/d7d5730b-ebef-68e5-5046-e763e1ee6=
164@yadro.com/
>
> Changes in v6:
>  - Replace 8 with MCOUNT_INSN_SIZE
>  - Replace "REG_L a1, PT_RA(sp)" with "mv a1, ra"
>  - Add Evgenii Shatokhin comment
>
> Changes in v5:
> https://lore.kernel.org/linux-riscv/20221208091244.203407-1-guoren@kernel=
.org/
>  - Sort Kconfig entries in alphabetical order.
>
> Changes in v4:
> https://lore.kernel.org/linux-riscv/20221129033230.255947-1-guoren@kernel=
.org/
>  - Include [3] for maintenance. [Song Shuai]
>
> Changes in V3:
> https://lore.kernel.org/linux-riscv/20221123153950.2911981-1-guoren@kerne=
l.org/
>  - Include [2] for maintenance. [Song Shuai]
>
> Changes in V2:
> https://lore.kernel.org/linux-riscv/20220921034910.3142465-1-guoren@kerne=
l.org/
>  - Add Signed-off for preemption fixup.
>
> Changes in V1:
> https://lore.kernel.org/linux-riscv/20220916103817.9490-1-guoren@kernel.o=
rg/
>
> Andy Chiu (1):
>   riscv: ftrace: Fixup panic by disabling preemption
>
> Guo Ren (2):
>   riscv: ftrace: Remove wasted nops for !RISCV_ISA_C
>   riscv: ftrace: Reduce the detour code size to half
>
> Song Shuai (4):
>   riscv: ftrace: Add ftrace_graph_func
>   riscv: ftrace: Make ftrace_caller call ftrace_graph_func
>   riscv: ftrace: Add DYNAMIC_FTRACE_WITH_DIRECT_CALLS support
>   samples: ftrace: Add riscv support for SAMPLE_FTRACE_DIRECT[_MULTI]
>
>  arch/riscv/Kconfig                          |   3 +-
>  arch/riscv/Makefile                         |   6 +-
>  arch/riscv/include/asm/ftrace.h             |  71 ++++++--
>  arch/riscv/kernel/ftrace.c                  |  91 ++++------
>  arch/riscv/kernel/mcount-dyn.S              | 181 +++++++++++++-------
>  samples/ftrace/ftrace-direct-modify.c       |  33 ++++
>  samples/ftrace/ftrace-direct-multi-modify.c |  37 ++++
>  samples/ftrace/ftrace-direct-multi.c        |  22 +++
>  samples/ftrace/ftrace-direct-too.c          |  26 +++
>  samples/ftrace/ftrace-direct.c              |  22 +++
>  10 files changed, 355 insertions(+), 137 deletions(-)
>
> --
> 2.36.1
>


--
Thanks,
Song
