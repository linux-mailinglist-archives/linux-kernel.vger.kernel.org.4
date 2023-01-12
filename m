Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4383466682E
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 01:59:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229726AbjALA7n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 19:59:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230270AbjALA7l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 19:59:41 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3F321A07B
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 16:59:39 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2B62AB81DA5
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 00:59:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6858C433F1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 00:59:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673485176;
        bh=TT/Y7hIeQw1DXoXtbRNnXe5+Y/xnTCFsp6Nk8sjS+f4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=eLy6cjuOjyOIgFwZm8WubLFXBO33lWFEPuVfYJ4CcHotf8VcEhgFjlSebZv5UJDfT
         EOXJNRiBqFB4BzyC9gXTyiz7xinJQrIkAPAsl2ywUIDARL7G3jt4V+YS9WHRGJCvrY
         f0ApAb0MjCkXHMgj10Y1hxjy3o3vcZyLudMtKHPyGdwVnb0pbfp0A8cZqZIz1GGiPO
         PWwrg86QqM/3RuqRwiRhJIvQkPFjL7yoVx1H0HbbWnMNZFX/YfB2zEUx358aUiQopX
         ujvqnKhF5jWTsXWs0puCqsPsJK8ZGEuNWeE+om9ZzH7x2Hrza9DZ5Z795tKgHaO7o3
         7gLq6uJFxHDJw==
Received: by mail-ej1-f42.google.com with SMTP id fy8so41003891ejc.13
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 16:59:36 -0800 (PST)
X-Gm-Message-State: AFqh2krKoxX7knebf70Cv5sDtkKns3LLGDNt76D3Z30nljRTu4HjtZvJ
        rVxKOnIEgiw11jaSW+oTtGeFsp5bL7tAui39Mck=
X-Google-Smtp-Source: AMrXdXuW/ogJ4wj3usOAcVkVZUdam6aewau6TPDNSdvX8xMT3Fbcc/WgRUUrqlgRKfwLBxDez7UaNpQ/SRt7JeOtFg4=
X-Received: by 2002:a17:906:5616:b0:852:132b:2d7e with SMTP id
 f22-20020a170906561600b00852132b2d7emr1023741ejq.224.1673485175029; Wed, 11
 Jan 2023 16:59:35 -0800 (PST)
MIME-Version: 1.0
References: <20230112004048.26191-1-hejinyang@loongson.cn>
In-Reply-To: <20230112004048.26191-1-hejinyang@loongson.cn>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Thu, 12 Jan 2023 08:59:23 +0800
X-Gmail-Original-Message-ID: <CAAhV-H7XKtkFoC=8ahME2L=nGzo4DHG6g7XMVcCCrMop_aSEwA@mail.gmail.com>
Message-ID: <CAAhV-H7XKtkFoC=8ahME2L=nGzo4DHG6g7XMVcCCrMop_aSEwA@mail.gmail.com>
Subject: Re: [PATCH v3 5/5] LoongArch: Add generic ex-handler unwind in
 prologue unwinder
To:     Jinyang He <hejinyang@loongson.cn>
Cc:     WANG Xuerui <kernel@xen0n.name>,
        Qing Zhang <zhangqing@loongson.cn>, loongarch@lists.linux.dev,
        linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Jinyang,

Have you tested this patch on NUMA systems?  I don't say it cannot
work, I just concern about it, because NUMA systems use different
exception tables.

Huacai

On Thu, Jan 12, 2023 at 8:41 AM Jinyang He <hejinyang@loongson.cn> wrote:
>
> When exception is triggered, code flow go handle_\exception in some
> cases. One of stackframe in this case as follows,
>
> high -> +-------+
>         | REGS  |  <- a pt_regs
>         |       |
>         |       |  <- ex trigger
>         | REGS  |  <- ex pt_regs   <-+
>         |       |                    |
>         |       |                    |
> low  -> +-------+           ->unwind-+
>
> When unwinder unwind to handler_\exception it cannot go on prologue
> analysis. It is asynchronous code flow, we should get the next frame
> PC from regs->csr_era but not from regs->regs[1]. And we copy the
> handler codes to eentry in the early time and copy the handler codes
> to NUMA-relative memory named pcpu_handlers if NUMA is enabled. Thus,
> unwinder cannot unwind normally. Therefore, try to give some hint in
> handler_\exception and fixup it in unwind_next_frame.
>
> Reported-by: Qing Zhang <zhangqing@loongson.cn>
> Signed-off-by: Jinyang He <hejinyang@loongson.cn>
> ---
>  arch/loongarch/include/asm/unwind.h     |   2 +-
>  arch/loongarch/kernel/genex.S           |   3 +
>  arch/loongarch/kernel/unwind_prologue.c | 100 +++++++++++++++++++++---
>  arch/loongarch/mm/tlb.c                 |   2 +-
>  4 files changed, 92 insertions(+), 15 deletions(-)
>
> diff --git a/arch/loongarch/include/asm/unwind.h b/arch/loongarch/include/asm/unwind.h
> index cb428e1b19af..a38eb152aefb 100644
> --- a/arch/loongarch/include/asm/unwind.h
> +++ b/arch/loongarch/include/asm/unwind.h
> @@ -22,7 +22,7 @@ struct unwind_state {
>         char type; /* UNWINDER_XXX */
>         struct stack_info stack_info;
>         struct task_struct *task;
> -       bool first, error, is_ftrace;
> +       bool first, error, reset;
>         int graph_idx;
>         unsigned long sp, pc, ra;
>  };
> diff --git a/arch/loongarch/kernel/genex.S b/arch/loongarch/kernel/genex.S
> index 75e5be807a0d..7e5c293ed89f 100644
> --- a/arch/loongarch/kernel/genex.S
> +++ b/arch/loongarch/kernel/genex.S
> @@ -67,14 +67,17 @@ SYM_FUNC_END(except_vec_cex)
>         .macro  BUILD_HANDLER exception handler prep
>         .align  5
>         SYM_FUNC_START(handle_\exception)
> +       666:
>         BACKUP_T0T1
>         SAVE_ALL
>         build_prep_\prep
>         move    a0, sp
>         la.abs  t0, do_\handler
>         jirl    ra, t0, 0
> +       668:
>         RESTORE_ALL_AND_RET
>         SYM_FUNC_END(handle_\exception)
> +       SYM_DATA(unwind_hint_\exception, .word 668b - 666b)
>         .endm
>
>         BUILD_HANDLER ade ade badv
> diff --git a/arch/loongarch/kernel/unwind_prologue.c b/arch/loongarch/kernel/unwind_prologue.c
> index e6c3f2ee507c..e52c18c2b604 100644
> --- a/arch/loongarch/kernel/unwind_prologue.c
> +++ b/arch/loongarch/kernel/unwind_prologue.c
> @@ -2,21 +2,100 @@
>  /*
>   * Copyright (C) 2022 Loongson Technology Corporation Limited
>   */
> +#include <linux/cpumask.h>
>  #include <linux/ftrace.h>
>  #include <linux/kallsyms.h>
>
>  #include <asm/inst.h>
> +#include <asm/loongson.h>
>  #include <asm/ptrace.h>
> +#include <asm/setup.h>
>  #include <asm/unwind.h>
>
> -static inline void unwind_state_fixup(struct unwind_state *state)
> +extern const int unwind_hint_ade;
> +extern const int unwind_hint_ale;
> +extern const int unwind_hint_bp;
> +extern const int unwind_hint_fpe;
> +extern const int unwind_hint_fpu;
> +extern const int unwind_hint_lsx;
> +extern const int unwind_hint_lasx;
> +extern const int unwind_hint_lbt;
> +extern const int unwind_hint_ri;
> +extern const int unwind_hint_watch;
> +extern unsigned long eentry;
> +#ifdef CONFIG_NUMA
> +extern unsigned long pcpu_handlers[NR_CPUS];
> +#endif
> +
> +static inline bool scan_handler(unsigned long entry_offset)
>  {
> -#ifdef CONFIG_DYNAMIC_FTRACE
> -       static unsigned long ftrace = (unsigned long)ftrace_call + 4;
> +       int idx, offset;
>
> -       if (state->pc == ftrace)
> -               state->is_ftrace = true;
> +       if (entry_offset >= EXCCODE_INT_START * VECSIZE)
> +               return false;
> +
> +       idx = entry_offset / VECSIZE;
> +       offset = entry_offset % VECSIZE;
> +       switch (idx) {
> +       case EXCCODE_ADE:
> +               return offset == unwind_hint_ade;
> +       case EXCCODE_ALE:
> +               return offset == unwind_hint_ale;
> +       case EXCCODE_BP:
> +               return offset == unwind_hint_bp;
> +       case EXCCODE_FPE:
> +               return offset == unwind_hint_fpe;
> +       case EXCCODE_FPDIS:
> +               return offset == unwind_hint_fpu;
> +       case EXCCODE_LSXDIS:
> +               return offset == unwind_hint_lsx;
> +       case EXCCODE_LASXDIS:
> +               return offset == unwind_hint_lasx;
> +       case EXCCODE_BTDIS:
> +               return offset == unwind_hint_lbt;
> +       case EXCCODE_INE:
> +               return offset == unwind_hint_ri;
> +       case EXCCODE_WATCH:
> +               return offset == unwind_hint_watch;
> +       default:
> +               return false;
> +       }
> +}
> +
> +static inline bool fix_exceptions(unsigned long pc)
> +{
> +#ifdef CONFIG_NUMA
> +       int cpu;
> +
> +       for_each_possible_cpu(cpu) {
> +               if (!pcpu_handlers[cpu])
> +                       continue;
> +               if (scan_handler(pc - pcpu_handlers[cpu]))
> +                       return true;
> +       }
>  #endif
> +       return scan_handler(pc - eentry);
> +}
> +
> +/*
> + * As we meet ftrace_regs_entry, reset first flag like first doing
> + * tracing. Prologue analysis will stop soon because PC is at entry.
> + */
> +static inline bool fix_ftrace(unsigned long pc)
> +{
> +#ifdef CONFIG_DYNAMIC_FTRACE
> +       return pc == (unsigned long)ftrace_call + LOONGARCH_INSN_SIZE;
> +#else
> +       return false;
> +#endif
> +}
> +
> +static inline bool unwind_state_fixup(struct unwind_state *state)
> +{
> +       if (!fix_exceptions(state->pc) && !fix_ftrace(state->pc))
> +               return false;
> +       state->reset = true;
> +       return true;
>  }
>
>  /*
> @@ -39,14 +118,10 @@ static bool unwind_by_prologue(struct unwind_state *state)
>         if (state->sp >= info->end || state->sp < info->begin)
>                 return false;
>
> -       if (state->is_ftrace) {
> -               /*
> -                * As we meet ftrace_regs_entry, reset first flag like first doing
> -                * tracing. Prologue analysis will stop soon because PC is at entry.
> -                */
> +       if (state->reset) {
>                 regs = (struct pt_regs *)state->sp;
>                 state->first = true;
> -               state->is_ftrace = false;
> +               state->reset = false;
>                 state->pc = regs->csr_era;
>                 state->ra = regs->regs[1];
>                 state->sp = regs->regs[3];
> @@ -111,8 +186,7 @@ static bool unwind_by_prologue(struct unwind_state *state)
>
>  out:
>         state->first = false;
> -       unwind_state_fixup(state);
> -       return !!__kernel_text_address(state->pc);
> +       return unwind_state_fixup(state) || __kernel_text_address(state->pc);
>  }
>
>  static bool next_frame(struct unwind_state *state)
> diff --git a/arch/loongarch/mm/tlb.c b/arch/loongarch/mm/tlb.c
> index da3681f131c8..8bad6b0cff59 100644
> --- a/arch/loongarch/mm/tlb.c
> +++ b/arch/loongarch/mm/tlb.c
> @@ -251,7 +251,7 @@ static void output_pgtable_bits_defines(void)
>  }
>
>  #ifdef CONFIG_NUMA
> -static unsigned long pcpu_handlers[NR_CPUS];
> +unsigned long pcpu_handlers[NR_CPUS];
>  #endif
>  extern long exception_handlers[VECSIZE * 128 / sizeof(long)];
>
> --
> 2.34.3
>
>
