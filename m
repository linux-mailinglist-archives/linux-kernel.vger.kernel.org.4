Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F230629681
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 11:57:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229863AbiKOK5Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 05:57:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237288AbiKOK4n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 05:56:43 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A64427DCD
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 02:55:11 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 91B40B818B8
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 10:55:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F219AC43470
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 10:55:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668509708;
        bh=kTalv8TULuHEO/75QH3GGQ8eFmKQS+TZVFh7h/09IhI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Z89TB/I9O7b1mXi97vxDsxh3MQprQoPVtbZu9k4KTOtBJEQdCe45tvOLLNQEel+9H
         a31Q7Lvf+sTl2WLqjptpKAi9myIu5/NYqr73gfrrXmST6kGf4mXctPgFjlS81tcJ8b
         GIBxC3+4TKMqpltBm8MdGj0CtkFnBdQAkcCV5+7cdsTzOprn4/ZQvY9j10qMwTifog
         50E/4D08+28HC75pFB30x/hwMjfzNVxT29bkahm25+l/pz1QE3dJhPBJMt4v2+A1Hk
         zjhBQc5EB1zDmsw5RvfU4dQPpDnntJtyUP0dD9YHRtEJ/X68S8ZL0GuqYBai2HwpA3
         +KoxJPe8348MQ==
Received: by mail-ej1-f46.google.com with SMTP id bj12so34982500ejb.13
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 02:55:07 -0800 (PST)
X-Gm-Message-State: ANoB5pkrK2WIp0AukDW0PHQeaFyc89M5OjPDoNT31tfsUXIOpXdVYuTG
        OoR7o57m02bcC9b48xc1OISIDKQiJKn3GgaIuQA=
X-Google-Smtp-Source: AA0mqf7zlYqPal6wKD3T5AXqPLJD7u7HdirKsd4p1ZajGSBJaa1lRA5AmdN+9fzS6qO5D77lMuIKWWu9vBvNmsWmc2Y=
X-Received: by 2002:a17:906:940b:b0:7ad:d250:b904 with SMTP id
 q11-20020a170906940b00b007add250b904mr13364288ejx.633.1668509706030; Tue, 15
 Nov 2022 02:55:06 -0800 (PST)
MIME-Version: 1.0
References: <20221115025527.13382-1-zhangqing@loongson.cn> <20221115025527.13382-4-zhangqing@loongson.cn>
In-Reply-To: <20221115025527.13382-4-zhangqing@loongson.cn>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Tue, 15 Nov 2022 18:54:53 +0800
X-Gmail-Original-Message-ID: <CAAhV-H41XxvVhtkL3WhHH_iFVWu1E28dPNZAbNCOgtrzfrZmpQ@mail.gmail.com>
Message-ID: <CAAhV-H41XxvVhtkL3WhHH_iFVWu1E28dPNZAbNCOgtrzfrZmpQ@mail.gmail.com>
Subject: Re: [PATCH v6 3/9] LoongArch/ftrace: Add dynamic function tracer support
To:     Qing Zhang <zhangqing@loongson.cn>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, loongarch@lists.linux.dev,
        linux-kernel@vger.kernel.org, Jinyang He <hejinyang@loongson.cn>
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

On Tue, Nov 15, 2022 at 10:55 AM Qing Zhang <zhangqing@loongson.cn> wrote:
>
> The compiler has inserted 2 NOPs before the regular function prologue.
> T series registers are available and safe because of LoongArch psABI.
>
> At runtime, replace nop with bl to enable ftrace call and replace bl with
> nop to disable ftrace call. The bl requires us to save the original RA
> value, so here it saves RA at t0.
> details are:
>
> | Compiled   |       Disabled         |        Enabled         |
> +------------+------------------------+------------------------+
> | nop        | move     t0, ra        | move     t0, ra        |
> | nop        | nop                    | bl      ftrace_caller  |
> | func_body  | func_body              | func_body              |
>
> The RA value will be recovered by ftrace_regs_entry, and restored into RA
> before returning to the regular function prologue. When a function is not
> being traced, the move t0, ra is not harmful.
>
> 1) ftrace_make_call, ftrace_make_nop (in kernel/ftrace.c)
>    The two functions turn each recorded call site of filtered functions
>    into a call to ftrace_caller or nops.
>
> 2) ftracce_update_ftrace_func (in kernel/ftrace.c)
>    turns the nops at ftrace_call into a call to a generic entry for
>    function tracers.
>
> 3) ftrace_caller (in kernel/mcount-dyn.S)
>    The entry where each _mcount call sites calls to once they are
>    filtered to be traced.
>
> Co-developed-by: Jinyang He <hejinyang@loongson.cn>
> Signed-off-by: Jinyang He <hejinyang@loongson.cn>
> Signed-off-by: Qing Zhang <zhangqing@loongson.cn>
> ---
>  arch/loongarch/Kconfig                  |   1 +
>  arch/loongarch/include/asm/ftrace.h     |  16 ++++
>  arch/loongarch/include/asm/inst.h       |  15 ++++
>  arch/loongarch/include/asm/unwind.h     |   2 +-
>  arch/loongarch/kernel/Makefile          |   5 ++
>  arch/loongarch/kernel/ftrace_dyn.c      | 111 ++++++++++++++++++++++++
>  arch/loongarch/kernel/inst.c            |  92 ++++++++++++++++++++
>  arch/loongarch/kernel/mcount-dyn.S      |  89 +++++++++++++++++++
>  arch/loongarch/kernel/unwind_prologue.c |  35 ++++++--
>  9 files changed, 360 insertions(+), 6 deletions(-)
>  create mode 100644 arch/loongarch/kernel/ftrace_dyn.c
>  create mode 100644 arch/loongarch/kernel/mcount-dyn.S
>
> diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
> index e6b1defca1f1..615ce62422b8 100644
> --- a/arch/loongarch/Kconfig
> +++ b/arch/loongarch/Kconfig
> @@ -89,6 +89,7 @@ config LOONGARCH
>         select HAVE_C_RECORDMCOUNT
>         select HAVE_DEBUG_STACKOVERFLOW
>         select HAVE_DMA_CONTIGUOUS
> +       select HAVE_DYNAMIC_FTRACE
>         select HAVE_EBPF_JIT
>         select HAVE_EXIT_THREAD
>         select HAVE_FAST_GUP
> diff --git a/arch/loongarch/include/asm/ftrace.h b/arch/loongarch/include/asm/ftrace.h
> index 6a3e76234618..76ca58767f4d 100644
> --- a/arch/loongarch/include/asm/ftrace.h
> +++ b/arch/loongarch/include/asm/ftrace.h
> @@ -10,9 +10,25 @@
>  #define MCOUNT_INSN_SIZE 4             /* sizeof mcount call */
>
>  #ifndef __ASSEMBLY__
> +#ifndef CONFIG_DYNAMIC_FTRACE
>  extern void _mcount(void);
>  #define mcount _mcount
> +#endif
>
> +#ifdef CONFIG_DYNAMIC_FTRACE
> +static inline unsigned long ftrace_call_adjust(unsigned long addr)
> +{
> +       return addr;
> +}
> +
> +struct dyn_arch_ftrace {
> +};
> +
> +struct dyn_ftrace;
> +int ftrace_init_nop(struct module *mod, struct dyn_ftrace *rec);
> +#define ftrace_init_nop ftrace_init_nop
> +
> +#endif /* CONFIG_DYNAMIC_FTRACE */
>  #endif /* __ASSEMBLY__ */
>  #endif /* CONFIG_FUNCTION_TRACER */
>  #endif /* _ASM_LOONGARCH_FTRACE_H */
> diff --git a/arch/loongarch/include/asm/inst.h b/arch/loongarch/include/asm/inst.h
> index a52913787183..0ec775d39ca5 100644
> --- a/arch/loongarch/include/asm/inst.h
> +++ b/arch/loongarch/include/asm/inst.h
> @@ -11,6 +11,9 @@
>  #define INSN_NOP               0x03400000
>  #define INSN_BREAK             0x002a0000
>
> +#define INSN_NOP 0x03400000
> +#define INSN_BREAK 0x002a0000
They are already defined.

Huacai
> +
>  #define ADDR_IMMMASK_LU52ID    0xFFF0000000000000
>  #define ADDR_IMMMASK_LU32ID    0x000FFFFF00000000
>  #define ADDR_IMMMASK_ADDU16ID  0x00000000FFFF0000
> @@ -349,6 +352,18 @@ static inline bool is_stack_alloc_ins(union loongarch_instruction *ip)
>                 is_imm12_negative(ip->reg2i12_format.immediate);
>  }
>
> +int larch_insn_read(void *addr, u32 *insnp);
> +int larch_insn_write(void *addr, u32 insn);
> +int larch_insn_patch_text(void *addr, u32 insn);
> +
> +u32 larch_insn_gen_nop(void);
> +u32 larch_insn_gen_b(unsigned long pc, unsigned long dest);
> +u32 larch_insn_gen_bl(unsigned long pc, unsigned long dest);
> +
> +u32 larch_insn_gen_or(enum loongarch_gpr rd, enum loongarch_gpr rj,
> +                       enum loongarch_gpr rk);
> +u32 larch_insn_gen_move(enum loongarch_gpr rd, enum loongarch_gpr rj);
> +
>  u32 larch_insn_gen_lu32id(enum loongarch_gpr rd, int imm);
>  u32 larch_insn_gen_lu52id(enum loongarch_gpr rd, enum loongarch_gpr rj, int imm);
>  u32 larch_insn_gen_jirl(enum loongarch_gpr rd, enum loongarch_gpr rj, unsigned long pc, unsigned long dest);
> diff --git a/arch/loongarch/include/asm/unwind.h b/arch/loongarch/include/asm/unwind.h
> index 6af4718bdf01..a51eec00efb8 100644
> --- a/arch/loongarch/include/asm/unwind.h
> +++ b/arch/loongarch/include/asm/unwind.h
> @@ -20,7 +20,7 @@ struct unwind_state {
>         char type; /* UNWINDER_XXX */
>         struct stack_info stack_info;
>         struct task_struct *task;
> -       bool first, error;
> +       bool first, error, is_ftrace;
>         unsigned long sp, pc, ra;
>  };
>
> diff --git a/arch/loongarch/kernel/Makefile b/arch/loongarch/kernel/Makefile
> index 3f71bce1c7ce..c5e2bfd8247d 100644
> --- a/arch/loongarch/kernel/Makefile
> +++ b/arch/loongarch/kernel/Makefile
> @@ -16,8 +16,13 @@ obj-$(CONFIG_EFI)            += efi.o
>  obj-$(CONFIG_CPU_HAS_FPU)      += fpu.o
>
>  ifdef CONFIG_FUNCTION_TRACER
> +ifndef CONFIG_DYNAMIC_FTRACE
>  obj-y += mcount.o ftrace.o
>  CFLAGS_REMOVE_ftrace.o = $(CC_FLAGS_FTRACE)
> +else
> +obj-y += mcount-dyn.o ftrace_dyn.o
> +CFLAGS_REMOVE_ftrace_dyn.o = $(CC_FLAGS_FTRACE)
> +endif
>  CFLAGS_REMOVE_inst.o = $(CC_FLAGS_FTRACE)
>  CFLAGS_REMOVE_time.o = $(CC_FLAGS_FTRACE)
>  CFLAGS_REMOVE_perf_event.o = $(CC_FLAGS_FTRACE)
> diff --git a/arch/loongarch/kernel/ftrace_dyn.c b/arch/loongarch/kernel/ftrace_dyn.c
> new file mode 100644
> index 000000000000..1f8955be8b64
> --- /dev/null
> +++ b/arch/loongarch/kernel/ftrace_dyn.c
> @@ -0,0 +1,111 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Based on arch/arm64/kernel/ftrace.c
> + *
> + * Copyright (C) 2022 Loongson Technology Corporation Limited
> + */
> +
> +#include <linux/ftrace.h>
> +#include <linux/uaccess.h>
> +
> +#include <asm/inst.h>
> +
> +static int ftrace_modify_code(unsigned long pc, u32 old, u32 new,
> +                             bool validate)
> +{
> +       u32 replaced;
> +
> +       if (validate) {
> +               if (larch_insn_read((void *)pc, &replaced))
> +                       return -EFAULT;
> +
> +               if (replaced != old)
> +                       return -EINVAL;
> +       }
> +
> +       if (larch_insn_patch_text((void *)pc, new))
> +               return -EPERM;
> +
> +       return 0;
> +}
> +
> +int ftrace_update_ftrace_func(ftrace_func_t func)
> +{
> +       unsigned long pc;
> +       u32 new;
> +
> +       pc = (unsigned long)&ftrace_call;
> +       new = larch_insn_gen_bl(pc, (unsigned long)func);
> +
> +       return ftrace_modify_code(pc, 0, new, false);
> +}
> +
> +/*
> + * The compiler has inserted 2 NOPs before the regular function prologue.
> + * T series registers are available and safe because of LoongArch psABI.
> + *
> + * At runtime, replace nop with bl to enable ftrace call and replace bl with
> + * nop to disable ftrace call. The bl requires us to save the original RA value,
> + * so here it saves RA at t0.
> + * details are:
> + *
> + * | Compiled   |       Disabled         |        Enabled         |
> + * +------------+------------------------+------------------------+
> + * | nop        | move     t0, ra        | move     t0, ra        |
> + * | nop        | nop                    | bl      ftrace_caller  |
> + * | func_body  | func_body              | func_body              |
> + *
> + * The RA value will be recovered by ftrace_regs_entry, and restored into RA
> + * before returning to the regular function prologue. When a function is not
> + * being traced, the move t0, ra is not harmful.
> + */
> +
> +int ftrace_init_nop(struct module *mod, struct dyn_ftrace *rec)
> +{
> +       unsigned long pc;
> +       u32 old, new;
> +
> +       pc = rec->ip;
> +       old = larch_insn_gen_nop();
> +       new = larch_insn_gen_move(LOONGARCH_GPR_T0, LOONGARCH_GPR_RA);
> +
> +       return ftrace_modify_code(pc, old, new, true);
> +}
> +
> +int ftrace_make_call(struct dyn_ftrace *rec, unsigned long addr)
> +{
> +       unsigned long pc;
> +       u32 old, new;
> +
> +       pc = rec->ip + LOONGARCH_INSN_SIZE;
> +
> +       old = larch_insn_gen_nop();
> +       new = larch_insn_gen_bl(pc, addr);
> +
> +       return ftrace_modify_code(pc, old, new, true);
> +}
> +
> +int ftrace_make_nop(struct module *mod, struct dyn_ftrace *rec,
> +                   unsigned long addr)
> +{
> +       unsigned long pc;
> +       u32 old, new;
> +
> +       pc = rec->ip + LOONGARCH_INSN_SIZE;
> +
> +       new = larch_insn_gen_nop();
> +       old = larch_insn_gen_bl(pc, addr);
> +
> +       return ftrace_modify_code(pc, old, new, true);
> +}
> +
> +void arch_ftrace_update_code(int command)
> +{
> +       command |= FTRACE_MAY_SLEEP;
> +       ftrace_modify_all_code(command);
> +}
> +
> +int __init ftrace_dyn_arch_init(void)
> +{
> +       return 0;
> +}
> diff --git a/arch/loongarch/kernel/inst.c b/arch/loongarch/kernel/inst.c
> index b1df0ec34bd1..d62cdf4a9ffb 100644
> --- a/arch/loongarch/kernel/inst.c
> +++ b/arch/loongarch/kernel/inst.c
> @@ -2,8 +2,83 @@
>  /*
>   * Copyright (C) 2020-2022 Loongson Technology Corporation Limited
>   */
> +#include <linux/sizes.h>
> +#include <linux/uaccess.h>
> +
> +#include <asm/cacheflush.h>
>  #include <asm/inst.h>
>
> +static DEFINE_RAW_SPINLOCK(patch_lock);
> +
> +int larch_insn_read(void *addr, u32 *insnp)
> +{
> +       int ret;
> +       u32 val;
> +
> +       ret = copy_from_kernel_nofault(&val, addr, LOONGARCH_INSN_SIZE);
> +       if (!ret)
> +               *insnp = val;
> +
> +       return ret;
> +}
> +
> +int larch_insn_write(void *addr, u32 insn)
> +{
> +       int ret;
> +       unsigned long flags = 0;
> +
> +       raw_spin_lock_irqsave(&patch_lock, flags);
> +       ret = copy_to_kernel_nofault(addr, &insn, LOONGARCH_INSN_SIZE);
> +       raw_spin_unlock_irqrestore(&patch_lock, flags);
> +
> +       return ret;
> +}
> +
> +int larch_insn_patch_text(void *addr, u32 insn)
> +{
> +       int ret;
> +       u32 *tp = addr;
> +
> +       if ((unsigned long)tp & 3)
> +               return -EINVAL;
> +
> +       ret = larch_insn_write(tp, insn);
> +       if (!ret)
> +               flush_icache_range((unsigned long)tp,
> +                                  (unsigned long)tp + LOONGARCH_INSN_SIZE);
> +
> +       return ret;
> +}
> +
> +u32 larch_insn_gen_nop(void)
> +{
> +       return INSN_NOP;
> +}
> +
> +u32 larch_insn_gen_bl(unsigned long pc, unsigned long dest)
> +{
> +       unsigned int immediate_l, immediate_h;
> +       union loongarch_instruction insn;
> +       long offset = dest - pc;
> +
> +       if ((offset & 3) || offset < -SZ_128M || offset >= SZ_128M) {
> +               pr_warn("The generated bl instruction is out of range.\n");
> +               return INSN_BREAK;
> +       }
> +
> +       offset >>= 2;
> +
> +       immediate_l = offset & 0xffff;
> +       offset >>= 16;
> +       immediate_h = offset & 0x3ff;
> +
> +       insn.reg0i26_format.opcode = bl_op;
> +       insn.reg0i26_format.immediate_l = immediate_l;
> +       insn.reg0i26_format.immediate_h = immediate_h;
> +
> +       return insn.word;
> +}
> +
>  u32 larch_insn_gen_lu32id(enum loongarch_gpr rd, int imm)
>  {
>         union loongarch_instruction insn;
> @@ -38,3 +113,20 @@ u32 larch_insn_gen_jirl(enum loongarch_gpr rd, enum loongarch_gpr rj, unsigned l
>
>         return insn.word;
>  }
> +
> +u32 larch_insn_gen_or(enum loongarch_gpr rd, enum loongarch_gpr rj, enum loongarch_gpr rk)
> +{
> +       union loongarch_instruction insn;
> +
> +       insn.reg3_format.opcode = or_op;
> +       insn.reg3_format.rd = rd;
> +       insn.reg3_format.rj = rj;
> +       insn.reg3_format.rk = rk;
> +
> +       return insn.word;
> +}
> +
> +u32 larch_insn_gen_move(enum loongarch_gpr rd, enum loongarch_gpr rj)
> +{
> +       return larch_insn_gen_or(rd, rj, 0);
> +}
> diff --git a/arch/loongarch/kernel/mcount-dyn.S b/arch/loongarch/kernel/mcount-dyn.S
> new file mode 100644
> index 000000000000..205925bc3822
> --- /dev/null
> +++ b/arch/loongarch/kernel/mcount-dyn.S
> @@ -0,0 +1,89 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (C) 2022 Loongson Technology Corporation Limited
> + */
> +
> +#include <asm/export.h>
> +#include <asm/regdef.h>
> +#include <asm/stackframe.h>
> +#include <asm/ftrace.h>
> +
> +       .text
> +/*
> + * Due to -fpatchable-function-entry=2: the compiler inserted 2 NOPs before the
> + * regular C function prologue. When PC arrived here, the last 2 instructions
> + * as follows,
> + *     move            t0, ra
> + *     bl              callsite (for modules, callsite is a tramplione)
> + *
> + * modules tramplione as follows,
> + *     lu12i.w         t1, callsite[31:12]
> + *     lu32i.d         t1, callsite[51:32]
> + *     lu52i.d         t1, t1, callsite[63:52]
> + *     jirl            zero, t1, callsite[11:0] >> 2
> + *
> + * See arch/loongarch/kernel/ftrace_dyn.c for details. Here, pay attention to
> + * that the T series regs are available and safe because each C functions
> + * follows the LoongArch psABI well.
> + */
> +
> +       .macro  ftrace_regs_entry
> +       PTR_ADDI sp, sp, -PT_SIZE
> +       /* Save trace function ra at PT_ERA */
> +       PTR_S   ra, sp, PT_ERA
> +       /* Save parent ra at PT_R1(RA) */
> +       PTR_S   t0, sp, PT_R1
> +       PTR_S   a0, sp, PT_R4
> +       PTR_S   a1, sp, PT_R5
> +       PTR_S   a2, sp, PT_R6
> +       PTR_S   a3, sp, PT_R7
> +       PTR_S   a4, sp, PT_R8
> +       PTR_S   a5, sp, PT_R9
> +       PTR_S   a6, sp, PT_R10
> +       PTR_S   a7, sp, PT_R11
> +       PTR_S   fp, sp, PT_R22
> +
> +       PTR_ADDI t8, sp, PT_SIZE
> +       PTR_S   t8, sp, PT_R3
> +
> +       .endm
> +
> +SYM_CODE_START(ftrace_caller)
> +       ftrace_regs_entry
> +       b       ftrace_common
> +SYM_CODE_END(ftrace_caller)
> +
> +SYM_CODE_START(ftrace_common)
> +       PTR_ADDI        a0, ra, -8      /* arg0: ip */
> +       move            a1, t0          /* arg1: parent_ip */
> +       la.pcrel        t1, function_trace_op
> +       PTR_L           a2, t1, 0       /* arg2: op */
> +       move            a3, sp          /* arg3: regs */
> +       .globl ftrace_call
> +ftrace_call:
> +       bl              ftrace_stub
> +/*
> + * As we didn't use S series regs in this assmembly code and all calls
> + * are C function which will save S series regs by themselves, there is
> + * no need to restore S series regs. The T series is available and safe
> + * at the callsite, so there is no need to restore the T series regs.
> + */
> +ftrace_common_return:
> +       PTR_L   a0, sp, PT_R4
> +       PTR_L   a1, sp, PT_R5
> +       PTR_L   a2, sp, PT_R6
> +       PTR_L   a3, sp, PT_R7
> +       PTR_L   a4, sp, PT_R8
> +       PTR_L   a5, sp, PT_R9
> +       PTR_L   a6, sp, PT_R10
> +       PTR_L   a7, sp, PT_R11
> +       PTR_L   fp, sp, PT_R22
> +       PTR_L   ra, sp, PT_R1
> +       PTR_L   t0, sp, PT_ERA
> +       PTR_ADDI sp, sp, PT_SIZE
> +       jr      t0
> +SYM_CODE_END(ftrace_common)
> +
> +SYM_FUNC_START(ftrace_stub)
> +       jr      ra
> +SYM_FUNC_END(ftrace_stub)
> diff --git a/arch/loongarch/kernel/unwind_prologue.c b/arch/loongarch/kernel/unwind_prologue.c
> index b206d9159205..c5df4ae73e0d 100644
> --- a/arch/loongarch/kernel/unwind_prologue.c
> +++ b/arch/loongarch/kernel/unwind_prologue.c
> @@ -13,9 +13,7 @@ unsigned long unwind_get_return_address(struct unwind_state *state)
>
>         if (unwind_done(state))
>                 return 0;
> -       else if (state->type)
> -               return state->pc;
> -       else if (state->first)
> +       else if (state->type || state->first)
>                 return state->pc;
>
>         return *(unsigned long *)(state->sp);
> @@ -39,16 +37,41 @@ static bool unwind_by_guess(struct unwind_state *state)
>         return false;
>  }
>
> +static inline void unwind_state_fixup(struct unwind_state *state)
> +{
> +#ifdef CONFIG_DYNAMIC_FTRACE
> +       static unsigned long ftrace_case = (unsigned long)ftrace_call + 4;
> +
> +       if (state->pc == ftrace_case)
> +               state->is_ftrace = true;
> +#endif
> +}
> +
>  static bool unwind_by_prologue(struct unwind_state *state)
>  {
>         struct stack_info *info = &state->stack_info;
>         union loongarch_instruction *ip, *ip_end;
>         unsigned long frame_size = 0, frame_ra = -1;
>         unsigned long size, offset, pc = state->pc;
> +       struct pt_regs *regs;
>
>         if (state->sp >= info->end || state->sp < info->begin)
>                 return false;
>
> +       if (state->is_ftrace) {
> +               /*
> +                * As we meet ftrace_regs_entry, reset first flag like first doing
> +                * tracing, Prologue analysis will stop soon because PC is at entry.
> +                */
> +               regs = (struct pt_regs *)state->sp;
> +               state->pc = regs->csr_era;
> +               state->ra = regs->regs[1];
> +               state->sp = regs->regs[3];
> +               state->first = true;
> +               state->is_ftrace = false;
> +               return true;
> +       }
> +
>         if (!kallsyms_lookup_size_offset(pc, &size, &offset))
>                 return false;
>
> @@ -94,7 +117,7 @@ static bool unwind_by_prologue(struct unwind_state *state)
>
>         state->pc = *(unsigned long *)(state->sp + frame_ra);
>         state->sp = state->sp + frame_size;
> -       return !!__kernel_text_address(state->pc);
> +       goto out;
>
>  first:
>         state->first = false;
> @@ -103,7 +126,9 @@ static bool unwind_by_prologue(struct unwind_state *state)
>
>         state->pc = state->ra;
>
> -       return !!__kernel_text_address(state->ra);
> +out:
> +       unwind_state_fixup(state);
> +       return !!__kernel_text_address(state->pc);
>  }
>
>  void unwind_start(struct unwind_state *state, struct task_struct *task,
> --
> 2.36.0
>
>
