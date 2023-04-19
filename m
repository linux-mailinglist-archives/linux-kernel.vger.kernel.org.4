Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDAA26E7D8F
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 17:01:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232427AbjDSPBI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 11:01:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231822AbjDSPBF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 11:01:05 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9658527C;
        Wed, 19 Apr 2023 08:01:00 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1a6762fd23cso472685ad.3;
        Wed, 19 Apr 2023 08:01:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681916460; x=1684508460;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Kop7LhZoVrKBA/ST70vjwH94OaZGQqZPRDxyeLg7D6k=;
        b=Hvl2PdRa3vo8xmJmQsqsf93wWOorioA9ZYWAO9knBmzcAq5PXm87b80AGsPqenqIf8
         MPuw1mxRdqOXIo1WbbDdtYTpvK/c33ySYVTBIG072rAevSYzoG2Ex7FOSn6ypPkJHsh9
         qPc2DguboKugZkSew1B/QwO+VyPLhtUoHIpKYT4tTXMAjXP4G1Fmldo+zbBonwfFirdr
         19klzCiONcCIbHr5KkPeMWyScLm0Qhc9A/jaHtLYJpULT4bIp0Kp3F23XdDKQ1p0bDYn
         w03vcgYGICV5Gxfaqjw3w5/iVAo6r/h82ARI5w2nYj8AYQXJqcoMhezt7c/JkCUQdMJ/
         zlJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681916460; x=1684508460;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Kop7LhZoVrKBA/ST70vjwH94OaZGQqZPRDxyeLg7D6k=;
        b=Nyziki7bHMvgTu6jNqKfV54HxPuBP7XJfgp/UjAHfW4OWKhDBUUZjBOzOb9QafiKmU
         wuLSwG8aN0I8goS0q3/MRkSy4R5M+LXlfl6TaLzaamo9Zy7jjz3cm7WlQ78wyyUV/JoT
         YjI1GTjRq8T5NblbSpEaWa2emw/F5nDvctsp8U+midCzWTzr0WBo1pHgqBfbDZ/wnZNP
         SnN6B5pGDZiBjU80t358fd/XJ2c50eXfYI86PmuUW+9P1CBeWhC3sSiDfSnU0978xbuX
         6FNoT8wBGCKyVJrJ819YVyQ1E+DfLOjqzGClFO/oL4QIZVoe+DJzlKgaZPWc0aW3obqE
         WWBw==
X-Gm-Message-State: AAQBX9dzbyl5YQh6i5qjbvVnn8mQozUNcNJ/A+Y70egE3Nrfw+cUtipH
        jdd4w3UMYsHclK6apABMVRJRoxlRGSz8avVC/0w=
X-Google-Smtp-Source: AKy350ZbqznWiNkGijDCMuDYRDtdisEfcQxTVBN0yqHDahMc1uTcOHGO0nJCb8Q2cyYyjZNPA7lhpxdchS6zyKf01MA=
X-Received: by 2002:a17:902:daca:b0:1a0:1f4e:a890 with SMTP id
 q10-20020a170902daca00b001a01f4ea890mr2322957plx.1.1681916460024; Wed, 19 Apr
 2023 08:01:00 -0700 (PDT)
MIME-Version: 1.0
References: <20230324033342.3177979-1-suagrfillet@gmail.com>
In-Reply-To: <20230324033342.3177979-1-suagrfillet@gmail.com>
From:   Song Shuai <suagrfillet@gmail.com>
Date:   Wed, 19 Apr 2023 23:00:51 +0800
Message-ID: <CAAYs2=it1F6e8JzHiC2rC+cEybMePcZSWB11+Q+==TPDTzq7sQ@mail.gmail.com>
Subject: Re: [PATCH V8 0/4] riscv: Optimize function trace
To:     paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, rostedt@goodmis.org, mhiramat@kernel.org,
        mark.rutland@arm.com, guoren@kernel.org, e.shatokhin@yadro.com
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ping...

Song Shuai <suagrfillet@gmail.com> =E4=BA=8E2023=E5=B9=B43=E6=9C=8824=E6=97=
=A5=E5=91=A8=E4=BA=94 11:33=E5=86=99=E9=81=93=EF=BC=9A
>
> The first 3 independent patches has been picked in the V7 version of
> this series, this version continues the following 4 patches.
>
> select FTRACE_MCOUNT_USE_PATCHABLE_FUNCTION_ENTRY [1] (patch 1)
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> In RISC-V, -fpatchable-function-entry option is used to support
> dynamic ftrace in this commit afc76b8b8011 ("riscv: Using
> PATCHABLE_FUNCTION_ENTRY instead of MCOUNT"). So recordmcount
> don't have to be called to create the __mcount_loc section before
> the vmlinux linking.
>
> Here selects FTRACE_MCOUNT_USE_PATCHABLE_FUNCTION_ENTRY to tell
> Makefile not to run recordmcount.
>
> Make function graph use ftrace directly [2] (patch 2)
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
> Add WITH_DIRECT_CALLS support [3] (patch 3, 4)
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
> (eg. function/fgraph tracer, k[ret]probes) co-exist, a temporary register
> are nominated to store the address of direct_caller in ftrace_regs_caller=
.
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
> The reason is that checkpatch depends on patch context providing the
> function name. In the above warning, my_direct_func2 has some codeline
> distance with the changed trunk, so its declaration doesn't come into
> the patch, and then the warning jumps out.
>
> You may notice the location of `my_ip` variable changes in the 2nd
> patch. I did that for reducing the warnings to some extent. But killing
> all the warnings will makes the patch less readable, so I stopped here.
>
> [1]
> https://lore.kernel.org/linux-riscv/CAAYs2=3Dj3Eak9vU6xbAw0zPuoh00rh8v5C2=
U3fePkokZFibWs2g@mail.gmail.com/T/#t
> [2]
> https://lore.kernel.org/lkml/20221120084230.910152-1-suagrfillet@gmail.co=
m/
> [3]
> https://lore.kernel.org/linux-riscv/20221123142025.1504030-1-suagrfillet@=
gmail.com/
>
> The series's changes related these patches
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> Changes in v8:
>  - Fix incorrect address values in the 4nd patch
>  - Rebased on v6.3-rc2
>
> Changes in v7:
> https://lore.kernel.org/linux-riscv/20230112090603.1295340-1-guoren@kerne=
l.org/
>  - Fixup RESTORE_ABI_REGS by remove PT_T0(sp) overwrite.
>  - Add FTRACE_MCOUNT_USE_PATCHABLE_FUNCTION_ENTRY
>  - Fixup kconfig with HAVE_SAMPLE_FTRACE_DIRECT &
>    HAVE_SAMPLE_FTRACE_DIRECT_MULTI
>
> Changes in v6:
> https://lore.kernel.org/linux-riscv/20230107133549.4192639-1-guoren@kerne=
l.org/
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
> Song Shuai (4):
>   riscv: select FTRACE_MCOUNT_USE_PATCHABLE_FUNCTION_ENTRY
>   riscv: ftrace: Add ftrace_graph_func
>   riscv: ftrace: Add DYNAMIC_FTRACE_WITH_DIRECT_CALLS support
>   samples: ftrace: Add riscv support for SAMPLE_FTRACE_DIRECT[_MULTI]
>
>  arch/riscv/Kconfig                          |   4 +
>  arch/riscv/include/asm/ftrace.h             |  19 ++-
>  arch/riscv/kernel/ftrace.c                  |  30 ++--
>  arch/riscv/kernel/mcount-dyn.S              | 143 +++++++++++++++-----
>  samples/ftrace/ftrace-direct-modify.c       |  33 +++++
>  samples/ftrace/ftrace-direct-multi-modify.c |  39 ++++++
>  samples/ftrace/ftrace-direct-multi.c        |  23 ++++
>  samples/ftrace/ftrace-direct-too.c          |  26 ++++
>  samples/ftrace/ftrace-direct.c              |  22 +++
>  9 files changed, 284 insertions(+), 55 deletions(-)
>
> --
> 2.20.1
>


--=20
Thanks,
Song
