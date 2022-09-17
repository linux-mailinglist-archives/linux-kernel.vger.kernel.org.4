Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 870F05BB792
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Sep 2022 11:39:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229577AbiIQJix (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Sep 2022 05:38:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbiIQJiu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Sep 2022 05:38:50 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBC91476E4
        for <linux-kernel@vger.kernel.org>; Sat, 17 Sep 2022 02:38:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 88486B80AD4
        for <linux-kernel@vger.kernel.org>; Sat, 17 Sep 2022 09:38:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40347C433C1
        for <linux-kernel@vger.kernel.org>; Sat, 17 Sep 2022 09:38:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663407526;
        bh=r+Uo9R8MD/odL1SIJDzHGnMk2eHaevGi4U5rUy+i7zc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=DjI/eW0jMKRXjUWsxbV7qgqfbhmzvMhTcPHig87sKod1Qa1QKKje5uqAnyEJUuw/j
         znDg3HIGQYjUCjroGGKypa6vLG/eAKCRElWanrBq8jbwVzn9fSdFBzMzGjgA6iVg+J
         vvkM8i7HXmpYNLpbTl0voH3syuzYVIoFlYeXIunrAfgQp6Mjo66ysXta3IC1E44eff
         996eRAwtI7q8BD25uYdIfdT5lEUGutN1MSn3Uldg6d4qbMqUPU64OF0CsL7EViTz9i
         bG7mDqDdwP5QzSCGyjFPUKrxXTGE31dLIjBcvRM2PE4j7Yw25Gchi/WX+hcUXUay+T
         kTyhoG3LarYnA==
Received: by mail-vs1-f51.google.com with SMTP id m66so25054508vsm.12
        for <linux-kernel@vger.kernel.org>; Sat, 17 Sep 2022 02:38:46 -0700 (PDT)
X-Gm-Message-State: ACrzQf0VqDoCp5Hoc3/IUhdsEHkzHH5qYH+6UDoq4PR58yqXT5Z3gCDK
        HSPV0gl6Di4XWxd6UD1YhFUs3IVGsEh0YND6nA4=
X-Google-Smtp-Source: AMsMyM6D+fU5XlKawMudw7uKmXIvIJuR+CszW2/USSB5FwQt595QTp88pgjpmOONpJTlv8+r5T8uOcrQS60LB/fdyzE=
X-Received: by 2002:a67:d59d:0:b0:398:211f:9a45 with SMTP id
 m29-20020a67d59d000000b00398211f9a45mr3746042vsj.78.1663407525033; Sat, 17
 Sep 2022 02:38:45 -0700 (PDT)
MIME-Version: 1.0
References: <20220916025533.18771-1-zhangqing@loongson.cn> <20220916025533.18771-2-zhangqing@loongson.cn>
In-Reply-To: <20220916025533.18771-2-zhangqing@loongson.cn>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Sat, 17 Sep 2022 17:38:32 +0800
X-Gmail-Original-Message-ID: <CAAhV-H6r5VtjseAQ50YKa3gbZ555FOH1p88Y+hj2mC-bBX5v8w@mail.gmail.com>
Message-ID: <CAAhV-H6r5VtjseAQ50YKa3gbZ555FOH1p88Y+hj2mC-bBX5v8w@mail.gmail.com>
Subject: Re: [PATCH v4 01/10] LoongArch/ftrace: Add basic support
To:     Qing Zhang <zhangqing@loongson.cn>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        WANG Xuerui <kernel@xen0n.name>, loongarch@lists.linux.dev,
        LKML <linux-kernel@vger.kernel.org>,
        Jinyang He <hejinyang@loongson.cn>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Qing,

On Fri, Sep 16, 2022 at 10:55 AM Qing Zhang <zhangqing@loongson.cn> wrote:
>
> This patch contains basic ftrace support for LoongArch.
> Specifically, function tracer (HAVE_FUNCTION_TRACER), function graph
> tracer (HAVE_FUNCTION_GRAPH_TRACER) are implemented following the
> instructions in Documentation/trace/ftrace-design.txt.
>
> Use `-pg` makes stub like a child function `void _mcount(void *ra)`.
> Thus, it can be seen store RA and open stack before `call _mcount`.
> Find `open stack` at first, and then find `store RA`
>
> Note that the functions in both inst.c and time.c should not be
> hooked with the compiler's -pg option: to prevent infinite self-
> referencing for the former, and to ignore early setup stuff for the
> latter.
>
> Co-developed-by: Jinyang He <hejinyang@loongson.cn>
> Signed-off-by: Jinyang He <hejinyang@loongson.cn>
> Signed-off-by: Qing Zhang <zhangqing@loongson.cn>
> ---
>  arch/loongarch/Kconfig              |  2 +
>  arch/loongarch/Makefile             |  5 ++
>  arch/loongarch/include/asm/ftrace.h | 18 ++++++
>  arch/loongarch/kernel/Makefile      |  8 +++
>  arch/loongarch/kernel/ftrace.c      | 74 +++++++++++++++++++++++
>  arch/loongarch/kernel/mcount.S      | 94 +++++++++++++++++++++++++++++
>  6 files changed, 201 insertions(+)
>  create mode 100644 arch/loongarch/include/asm/ftrace.h
>  create mode 100644 arch/loongarch/kernel/ftrace.c
>  create mode 100644 arch/loongarch/kernel/mcount.S
>
> diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
> index 9b1f2ab878e9..95eab9611191 100644
> --- a/arch/loongarch/Kconfig
> +++ b/arch/loongarch/Kconfig
> @@ -90,6 +90,8 @@ config LOONGARCH
>         select HAVE_EBPF_JIT
>         select HAVE_EXIT_THREAD
>         select HAVE_FAST_GUP
> +        select HAVE_FUNCTION_GRAPH_TRACER
> +        select HAVE_FUNCTION_TRACER
The indentation is obviously wrong here, and some other patches have
the same problem.


Huacai

>         select HAVE_GENERIC_VDSO
>         select HAVE_IOREMAP_PROT
>         select HAVE_IRQ_EXIT_ON_IRQ_STACK
> diff --git a/arch/loongarch/Makefile b/arch/loongarch/Makefile
> index 69b39ba3a09d..1149a17dc04f 100644
> --- a/arch/loongarch/Makefile
> +++ b/arch/loongarch/Makefile
> @@ -33,6 +33,11 @@ ifneq ($(SUBARCH),$(ARCH))
>    endif
>  endif
>
> +ifdef CONFIG_DYNAMIC_FTRACE
> +  KBUILD_CPPFLAGS += -DCC_USING_PATCHABLE_FUNCTION_ENTRY
> +  CC_FLAGS_FTRACE := -fpatchable-function-entry=2
> +endif
> +
>  ifdef CONFIG_64BIT
>  ld-emul                        = $(64bit-emul)
>  cflags-y               += -mabi=lp64s
> diff --git a/arch/loongarch/include/asm/ftrace.h b/arch/loongarch/include/asm/ftrace.h
> new file mode 100644
> index 000000000000..6a3e76234618
> --- /dev/null
> +++ b/arch/loongarch/include/asm/ftrace.h
> @@ -0,0 +1,18 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (C) 2022 Loongson Technology Corporation Limited
> + */
> +
> +#ifndef _ASM_LOONGARCH_FTRACE_H
> +#define _ASM_LOONGARCH_FTRACE_H
> +
> +#ifdef CONFIG_FUNCTION_TRACER
> +#define MCOUNT_INSN_SIZE 4             /* sizeof mcount call */
> +
> +#ifndef __ASSEMBLY__
> +extern void _mcount(void);
> +#define mcount _mcount
> +
> +#endif /* __ASSEMBLY__ */
> +#endif /* CONFIG_FUNCTION_TRACER */
> +#endif /* _ASM_LOONGARCH_FTRACE_H */
> diff --git a/arch/loongarch/kernel/Makefile b/arch/loongarch/kernel/Makefile
> index 7225916dd378..7db7ab152f71 100644
> --- a/arch/loongarch/kernel/Makefile
> +++ b/arch/loongarch/kernel/Makefile
> @@ -14,6 +14,14 @@ obj-$(CONFIG_EFI)            += efi.o
>
>  obj-$(CONFIG_CPU_HAS_FPU)      += fpu.o
>
> +ifdef CONFIG_FUNCTION_TRACER
> +    obj-y += mcount.o ftrace.o
> +    CFLAGS_REMOVE_ftrace.o = $(CC_FLAGS_FTRACE)
> +  CFLAGS_REMOVE_inst.o = $(CC_FLAGS_FTRACE)
> +  CFLAGS_REMOVE_time.o = $(CC_FLAGS_FTRACE)
> +  CFLAGS_REMOVE_perf_event.o = $(CC_FLAGS_FTRACE)
> +endif
> +
>  obj-$(CONFIG_MODULES)          += module.o module-sections.o
>  obj-$(CONFIG_STACKTRACE)       += stacktrace.o
>
> diff --git a/arch/loongarch/kernel/ftrace.c b/arch/loongarch/kernel/ftrace.c
> new file mode 100644
> index 000000000000..c8ddc5f11f32
> --- /dev/null
> +++ b/arch/loongarch/kernel/ftrace.c
> @@ -0,0 +1,74 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2022 Loongson Technology Corporation Limited
> + */
> +
> +#include <linux/uaccess.h>
> +#include <linux/init.h>
> +#include <linux/ftrace.h>
> +#include <linux/syscalls.h>
> +
> +#include <asm/asm.h>
> +#include <asm/asm-offsets.h>
> +#include <asm/cacheflush.h>
> +#include <asm/inst.h>
> +#include <asm/loongarch.h>
> +#include <asm/syscall.h>
> +#include <asm/unistd.h>
> +
> +#include <asm-generic/sections.h>
> +
> +#ifdef CONFIG_FUNCTION_GRAPH_TRACER
> +
> +/*
> + * As `call _mcount` follows LoongArch psABI, ra-saved operation and
> + * stack operation can be found before this insn.
> + */
> +
> +static int ftrace_get_parent_ra_addr(unsigned long insn_addr, int *ra_off)
> +{
> +       union loongarch_instruction *insn;
> +       int limit = 32;
> +
> +       insn = (union loongarch_instruction *)insn_addr;
> +
> +       do {
> +               insn--;
> +               limit--;
> +
> +               if (is_ra_save_ins(insn))
> +                       *ra_off = -((1 << 12) - insn->reg2i12_format.immediate);
> +
> +       } while (!is_stack_alloc_ins(insn) && limit);
> +
> +       if (!limit)
> +               return -EINVAL;
> +
> +       return 0;
> +}
> +
> +void prepare_ftrace_return(unsigned long self_addr,
> +               unsigned long callsite_sp, unsigned long old)
> +{
> +       int ra_off;
> +       unsigned long return_hooker = (unsigned long)&return_to_handler;
> +
> +       if (unlikely(ftrace_graph_is_dead()))
> +               return;
> +
> +       if (unlikely(atomic_read(&current->tracing_graph_pause)))
> +               return;
> +
> +       if (ftrace_get_parent_ra_addr(self_addr, &ra_off))
> +               goto out;
> +
> +       if (!function_graph_enter(old, self_addr, 0, NULL))
> +               *(unsigned long *)(callsite_sp + ra_off) = return_hooker;
> +
> +       return;
> +
> +out:
> +       ftrace_graph_stop();
> +       WARN_ON(1);
> +}
> +#endif /* CONFIG_FUNCTION_GRAPH_TRACER */
> diff --git a/arch/loongarch/kernel/mcount.S b/arch/loongarch/kernel/mcount.S
> new file mode 100644
> index 000000000000..3de7c2d7fd12
> --- /dev/null
> +++ b/arch/loongarch/kernel/mcount.S
> @@ -0,0 +1,94 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * LoongArch specific _mcount support
> + *
> + * Copyright (C) 2022 Loongson Technology Corporation Limited
> + */
> +
> +#include <asm/export.h>
> +#include <asm/regdef.h>
> +#include <asm/stackframe.h>
> +#include <asm/ftrace.h>
> +
> +       .text
> +
> +#define MCOUNT_STACK_SIZE      (2 * SZREG)
> +#define MCOUNT_S0_OFFSET       (0)
> +#define MCOUNT_RA_OFFSET       (SZREG)
> +
> +       .macro MCOUNT_SAVE_REGS
> +       PTR_ADDI sp, sp, -MCOUNT_STACK_SIZE
> +       PTR_S   s0, sp, MCOUNT_S0_OFFSET
> +       PTR_S   ra, sp, MCOUNT_RA_OFFSET
> +       move    s0, a0
> +       .endm
> +
> +       .macro MCOUNT_RESTORE_REGS
> +       move    a0, s0
> +       PTR_L   ra, sp, MCOUNT_RA_OFFSET
> +       PTR_L   s0, sp, MCOUNT_S0_OFFSET
> +       PTR_ADDI sp, sp, MCOUNT_STACK_SIZE
> +       .endm
> +
> +
> +SYM_FUNC_START(_mcount)
> +       la.pcrel        t1, ftrace_stub
> +       la.pcrel        t2, ftrace_trace_function       /* Prepare t2 for (1) */
> +       PTR_L   t2, t2, 0
> +       beq     t1, t2, fgraph_trace
> +
> +       MCOUNT_SAVE_REGS
> +
> +       move    a0, ra                          /* arg0: self return address */
> +       move    a1, s0                          /* arg1: parent's return address */
> +       jirl    ra, t2, 0                       /* (1) call *ftrace_trace_function */
> +
> +       MCOUNT_RESTORE_REGS
> +
> +fgraph_trace:
> +#ifdef CONFIG_FUNCTION_GRAPH_TRACER
> +       la.pcrel        t1, ftrace_stub
> +       la.pcrel        t3, ftrace_graph_return
> +       PTR_L   t3, t3, 0
> +       bne     t1, t3, ftrace_graph_caller
> +       la.pcrel        t1, ftrace_graph_entry_stub
> +       la.pcrel        t3, ftrace_graph_entry
> +       PTR_L   t3, t3, 0
> +       bne     t1, t3, ftrace_graph_caller
> +#endif
> +
> +       .globl ftrace_stub
> +ftrace_stub:
> +       jr      ra
> +SYM_FUNC_END(_mcount)
> +EXPORT_SYMBOL(_mcount)
> +
> +#ifdef CONFIG_FUNCTION_GRAPH_TRACER
> +SYM_FUNC_START(ftrace_graph_caller)
> +       MCOUNT_SAVE_REGS
> +
> +       PTR_ADDI        a0, ra, -4                      /* arg0: Callsite self return addr */
> +       PTR_ADDI        a1, sp, MCOUNT_STACK_SIZE       /* arg1: Callsite sp */
> +       move    a2, s0                                  /* arg2: Callsite parent ra */
> +       bl      prepare_ftrace_return
> +
> +       MCOUNT_RESTORE_REGS
> +       jr      ra
> +SYM_FUNC_END(ftrace_graph_caller)
> +
> +SYM_FUNC_START(return_to_handler)
> +       PTR_ADDI sp, sp, -2 * SZREG
> +       PTR_S   a0, sp, 0
> +       PTR_S   a1, sp, SZREG
> +
> +       bl      ftrace_return_to_handler
> +
> +       /* restore the real parent address: a0 -> ra */
> +       move    ra, a0
> +
> +       PTR_L   a0, sp, 0
> +       PTR_L   a1, sp, SZREG
> +       PTR_ADDI        sp, sp, 2 * SZREG
> +       jr      ra
> +SYM_FUNC_END(return_to_handler)
> +#endif /* CONFIG_FUNCTION_GRAPH_TRACER */
> --
> 2.36.1
>
