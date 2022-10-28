Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA3DD61087D
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 04:56:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234184AbiJ1C4x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 22:56:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236440AbiJ1C4o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 22:56:44 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CCBDBC617
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 19:56:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 175F8B82743
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 02:56:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB5E3C433D7
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 02:56:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666925799;
        bh=eEZ479mwlZLwESpR3a0U3Mb/0z62u+o77mdrfd6sXc4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=lmb57Epb8GhtW2XTDbChxaS9qMVlsEAonqXU1wfhvQrpDjQ/Gf1k619rvfqtRx2/X
         PaAIYGe8FfZIadyUTuRBKhxb531W4iWRmnGkOcjgySY1nvizNOk2YmxWpYCU5MepQs
         Ny1U+lkNu1AL/rII0vJVcw8SiDiTrz0sb+y9Wev0aAGsPBbDjkvo0AsC34pSAlVLs5
         bwGLbe1+an684AAI99u8BZLA5EEKmKLdZFc9DXh9M//8FWJMFLln5m9L6Vbe7cdXWk
         8noh/RSZeP7Z4nxzAO/pJJ6eWzR2cpY5EEtEzE1XVFUlpd4M5BX6lmbagzCmzw053/
         YPp9PCJZ8s1qA==
Received: by mail-ej1-f48.google.com with SMTP id sc25so9871995ejc.12
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 19:56:39 -0700 (PDT)
X-Gm-Message-State: ACrzQf3/1+FdowycK0LIO1DIadMt7PCZ2tvCkz2B7G5L2GiUOsOcqBJN
        6eNTTvCh+8EGfieDYMUPUCBz8dROGZmqajDPgLQ=
X-Google-Smtp-Source: AMsMyM6Aa6ZL+1KhGUP6Yk848C23h0RTAPTFpVgo7WiZnrd9s8YsN5ruVz6X49Z9pYsXzRdzOT6Bd6BALmWWiO1FJM4=
X-Received: by 2002:a17:907:2cf7:b0:78d:c7fc:29ff with SMTP id
 hz23-20020a1709072cf700b0078dc7fc29ffmr46016705ejc.748.1666925797879; Thu, 27
 Oct 2022 19:56:37 -0700 (PDT)
MIME-Version: 1.0
References: <20220919031910.15512-1-zhangqing@loongson.cn>
In-Reply-To: <20220919031910.15512-1-zhangqing@loongson.cn>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Fri, 28 Oct 2022 10:56:26 +0800
X-Gmail-Original-Message-ID: <CAAhV-H7G53unX8CBN637kmpKBfYuJb4RZnFXOuVnPCq4xNav3Q@mail.gmail.com>
Message-ID: <CAAhV-H7G53unX8CBN637kmpKBfYuJb4RZnFXOuVnPCq4xNav3Q@mail.gmail.com>
Subject: Re: [PATCH v5 10/10] LoongArch/ftrace: Fix unwind state when option func_stack_trace
To:     Qing Zhang <zhangqing@loongson.cn>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, loongarch@lists.linux.dev,
        linux-kernel@vger.kernel.org, Jeff Xie <xiehuan09@gmail.com>,
        Jinyang He <hejinyang@loongson.cn>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Qing,

Can this patch be squashed to a previous one?

Huacai

On Mon, Sep 19, 2022 at 11:19 AM Qing Zhang <zhangqing@loongson.cn> wrote:
>
> Ftrace plays like function head exception, prologue analysis will stop soon
> because PC is at entry.
>
>    90000000004c5a54 <callee>:
>    90000000004c5a54:    03400000  andi   $zero, $zero, 0x0   ==>move  t0, ra
>    90000000004c5a58:    03400000  andi   $zero, $zero, 0x0   ==>bl callsite
> ==>90000000004c5a5c:    02fcc063  addi.d $sp, $sp, -208(0xf30)
>    ...
>
> When encountering ftrace_call, save trace function ra at PT_ERA, save
> parent ra at PT_R1, At this time, pc is the position after the two nops
> of callee. There is no conventional prologue operation between this
> position and the function entry, so we need to reset the first flag to
> make the caller continue to unwind.
>
> testing method:
>   echo path_openat > ./set_ftrace_filter
>   echo 1 > ./options/func_stack_trace
>   echo function > ./current_tracer
>
> Reported-by: Jeff Xie <xiehuan09@gmail.com>
> Tested-by: Jinyang He <hejinyang@loongson.cn>
> Tested-by: Jeff Xie <xiehuan09@gmail.com>
> Signed-off-by: Qing Zhang <zhangqing@loongson.cn>
> ---
>  arch/loongarch/include/asm/unwind.h     |  2 +-
>  arch/loongarch/kernel/unwind_prologue.c | 35 +++++++++++++++++++++----
>  2 files changed, 31 insertions(+), 6 deletions(-)
>
> diff --git a/arch/loongarch/include/asm/unwind.h b/arch/loongarch/include/asm/unwind.h
> index f66b07c3e6a1..f2b52b9ea93d 100644
> --- a/arch/loongarch/include/asm/unwind.h
> +++ b/arch/loongarch/include/asm/unwind.h
> @@ -20,7 +20,7 @@ struct unwind_state {
>         char type; /* UNWINDER_XXX */
>         struct stack_info stack_info;
>         struct task_struct *task;
> -       bool first, error;
> +       bool first, error, is_ftrace;
>         int graph_idx;
>         unsigned long sp, pc, ra;
>  };
> diff --git a/arch/loongarch/kernel/unwind_prologue.c b/arch/loongarch/kernel/unwind_prologue.c
> index f77f3b6f3f06..4fb4923b68cc 100644
> --- a/arch/loongarch/kernel/unwind_prologue.c
> +++ b/arch/loongarch/kernel/unwind_prologue.c
> @@ -14,9 +14,7 @@ unsigned long unwind_get_return_address(struct unwind_state *state)
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
> @@ -42,16 +40,41 @@ static bool unwind_by_guess(struct unwind_state *state)
>         return false;
>  }
>
> +static inline void unwind_state_fixup(struct unwind_state *state)
> +{
> +#ifdef CONFIG_FUNCTION_TRACER
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
> @@ -97,7 +120,7 @@ static bool unwind_by_prologue(struct unwind_state *state)
>
>         state->pc = *(unsigned long *)(state->sp + frame_ra);
>         state->sp = state->sp + frame_size;
> -       return !!__kernel_text_address(state->pc);
> +       goto out;
>
>  first:
>         state->first = false;
> @@ -106,7 +129,9 @@ static bool unwind_by_prologue(struct unwind_state *state)
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
> 2.36.1
>
