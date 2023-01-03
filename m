Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 541C165BC97
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 09:59:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236936AbjACI7P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 03:59:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231145AbjACI66 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 03:58:58 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3181A2DE
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 00:58:55 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5B212611F9
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 08:58:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C6CEC433F2
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 08:58:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672736334;
        bh=XtLtqiz20t99NLW1SJaIufxtn21H6y1AVvyf97/yRaA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=eGgXhotOlb1l/8Mbi2jRxO2jRbPn/ULOMc6VMfHb6msXxBemFdCj80kmXvvPR1Q2t
         8jir/zAeHmKNebbkoB3QVr9YTooDh1j4Vu6AfaSTaeeeVSCCRG9Qlw9rk9ypwMND8Y
         KbXeZK/SgeAzuTBC84fqUVp/XUR39iHvwQOq68GDSv0YC23wLjj2tEHcbA7jrLIVoO
         +R2uB1+Hrgl/Fl7MGJuKnqfshIsU/2MSeCQrkwg8rpBTbqqPB2wPDQY7A3haCK/BHM
         wNdmK1XI47Sq+9DRXAKcsfMzNWvKQNf+Zz6IvBJLe/WkjRP4o8ZqqYzV2ua3xPpbF7
         6++xWQ6uIQSJQ==
Received: by mail-ed1-f46.google.com with SMTP id j16so10369720edw.11
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jan 2023 00:58:54 -0800 (PST)
X-Gm-Message-State: AFqh2kqzJPeKFW1pnUCQdRNj4D+dPofWBwVnN9E1Wp4xcu2q310BI/nU
        C74eFAJW3mFedwm5N/M5Y1rMwxWZmQ2EaqSyB74=
X-Google-Smtp-Source: AMrXdXsEuy/k7rgkOezBfX4czLspQVdtEIL1Xe7+MYe+bFb71b3Vya73t4PiIrzjYaauhX5r/BC/teIdlWKi9UG+ogc=
X-Received: by 2002:a05:6402:1751:b0:488:51bf:f809 with SMTP id
 v17-20020a056402175100b0048851bff809mr1742116edx.156.1672736332649; Tue, 03
 Jan 2023 00:58:52 -0800 (PST)
MIME-Version: 1.0
References: <20221229061516.31671-1-hejinyang@loongson.cn> <20221229061516.31671-5-hejinyang@loongson.cn>
 <CAAhV-H7J7yWpM-xLpK38gwEw3cMNU-BaxF3atVmDLyRxBcVrLg@mail.gmail.com> <ab0b221e-db13-3cac-dca1-bbd67f739ab3@loongson.cn>
In-Reply-To: <ab0b221e-db13-3cac-dca1-bbd67f739ab3@loongson.cn>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Tue, 3 Jan 2023 16:58:40 +0800
X-Gmail-Original-Message-ID: <CAAhV-H6feh3tD6myg5ALhVk8VxfkP-EnUxrgQ4F3JkKNZsfk0w@mail.gmail.com>
Message-ID: <CAAhV-H6feh3tD6myg5ALhVk8VxfkP-EnUxrgQ4F3JkKNZsfk0w@mail.gmail.com>
Subject: Re: [PATCH v2 4/6] LoongArch: Strip guess_unwinder out from prologue_unwinder
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

On Tue, Jan 3, 2023 at 4:41 PM Jinyang He <hejinyang@loongson.cn> wrote:
>
> On 2023-01-01 17:56, Huacai Chen wrote:
>
> > Hi, Jinyang,
> >
> > On Thu, Dec 29, 2022 at 2:15 PM Jinyang He <hejinyang@loongson.cn> wrote:
> >> The prolugue unwinder rely on symbol info. When PC is not in kernel
> >> text address, it cannot find relative symbol info and it will be broken.
> >> The guess unwinder will be used in this case. And the guess unwinder
> >> codes in prolugue unwinder is redundant. Strip it out and set the
> >> unwinder info in unwind_state.
> >>
> >> Signed-off-by: Jinyang He <hejinyang@loongson.cn>
> >> ---
> >>   arch/loongarch/include/asm/unwind.h     |  26 ++++-
> >>   arch/loongarch/kernel/Makefile          |   3 +-
> >>   arch/loongarch/kernel/traps.c           |   3 -
> >>   arch/loongarch/kernel/unwind.c          |  52 +++++++++
> >>   arch/loongarch/kernel/unwind_guess.c    |  41 ++------
> >>   arch/loongarch/kernel/unwind_prologue.c | 133 +++++++++---------------
> >>   6 files changed, 132 insertions(+), 126 deletions(-)
> >>   create mode 100644 arch/loongarch/kernel/unwind.c
> >>
> >> diff --git a/arch/loongarch/include/asm/unwind.h b/arch/loongarch/include/asm/unwind.h
> >> index 6ece48f0ff77..4a55fd7b77ad 100644
> >> --- a/arch/loongarch/include/asm/unwind.h
> >> +++ b/arch/loongarch/include/asm/unwind.h
> >> @@ -13,20 +13,30 @@
> >>   #include <asm/ptrace.h>
> >>   #include <asm/stacktrace.h>
> >>
> >> -enum unwinder_type {
> >> -       UNWINDER_GUESS,
> >> -       UNWINDER_PROLOGUE,
> >> -};
> >> +struct unwinder_ops;
> >>
> >>   struct unwind_state {
> >> -       char type; /* UNWINDER_XXX */
> >>          struct stack_info stack_info;
> >>          struct task_struct *task;
> >>          bool first, error, is_ftrace;
> >>          int graph_idx;
> >>          unsigned long sp, pc, ra;
> >> +       const struct unwinder_ops *ops;
> >> +};
> >> +
> >> +struct unwinder_ops {
> >> +       void (*unwind_start)(struct unwind_state *state,
> >> +                            struct task_struct *task, struct pt_regs *regs);
> >> +       bool (*unwind_next_frame)(struct unwind_state *state);
> >> +       unsigned long (*unwind_get_return_address)(struct unwind_state *state);
> >>   };
> >>
> >> +extern const struct unwinder_ops *default_unwinder;
> >> +extern const struct unwinder_ops unwinder_guess;
> >> +#ifdef CONFIG_UNWINDER_PROLOGUE
> >> +extern const struct unwinder_ops unwinder_prologue;
> >> +#endif
> >> +
> >>   void unwind_start(struct unwind_state *state,
> >>                    struct task_struct *task, struct pt_regs *regs);
> >>   bool unwind_next_frame(struct unwind_state *state);
> >> @@ -49,4 +59,10 @@ static inline unsigned long unwind_graph_addr(struct unwind_state *state,
> >>          return ftrace_graph_ret_addr(state->task, &state->graph_idx,
> >>                                       pc, (unsigned long *)(cfa - GRAPH_FAKE_OFFSET));
> >>   }
> >> +
> >> +static inline void unwind_register_unwinder(struct unwind_state *state,
> >> +                                         const struct unwinder_ops *unwinder)
> >> +{
> >> +       state->ops = unwinder;
> >> +}
> >>   #endif /* _ASM_UNWIND_H */
> >> diff --git a/arch/loongarch/kernel/Makefile b/arch/loongarch/kernel/Makefile
> >> index 7ca65195f7f8..cb6029ea3ea9 100644
> >> --- a/arch/loongarch/kernel/Makefile
> >> +++ b/arch/loongarch/kernel/Makefile
> >> @@ -8,7 +8,7 @@ extra-y         := vmlinux.lds
> >>   obj-y          += head.o cpu-probe.o cacheinfo.o env.o setup.o entry.o genex.o \
> >>                     traps.o irq.o idle.o process.o dma.o mem.o io.o reset.o switch.o \
> >>                     elf.o syscall.o signal.o time.o topology.o inst.o ptrace.o vdso.o \
> >> -                  alternative.o unaligned.o
> >> +                  alternative.o unaligned.o unwind.o unwind_guess.o
> >>
> >>   obj-$(CONFIG_ACPI)             += acpi.o
> >>   obj-$(CONFIG_EFI)              += efi.o
> >> @@ -42,7 +42,6 @@ obj-$(CONFIG_MAGIC_SYSRQ)     += sysrq.o
> >>   obj-$(CONFIG_KEXEC)            += machine_kexec.o relocate_kernel.o
> >>   obj-$(CONFIG_CRASH_DUMP)       += crash_dump.o
> >>
> >> -obj-$(CONFIG_UNWINDER_GUESS)   += unwind_guess.o
> >>   obj-$(CONFIG_UNWINDER_PROLOGUE) += unwind_prologue.o
> > We do have CONFIG_UNWINDER_GUESS and I don't like to build guess
> > unwinder unconditionally, maybe we can refactor it to make the
> > unwinder still user selectable.
>
>
> In order to provide backtrace info to the user, prologue unwinder
> will use guess unwinder when its first pc is not a kernel address,
> such as the first PC is in ebpf generated codes. This patch is intended
> to extract guess unwinder codes to avoid redundant codes. And if we provide
> a new unwinder in the future like orc unwinder which take effect after
> orc_init is set, we can use another backup unwinder like guess unwinder in
> case we need backtrace before orc_init being set.
>
> If you mind this, could we just do as follows,
>
> obj-$(CONFIG_UNWINDER_GUESS)   += unwind_guess.o
> obj-$(CONFIG_UNWINDER_PROLOGUE) += unwind_prologue.o unwind_guess.o
>
> Or copy the guess unwinder codes to unwind_prologue.c and set another
> name for guess unwinder.
Can we move common functions to unwind.c (or something similar) and
make unwind_guess.c/unwind_prologue.c as a frontend?

Huacai
>
>
> Thanks,
>
> Jinyang
>
> > Huacai
> >>   obj-$(CONFIG_PERF_EVENTS)      += perf_event.o perf_regs.o
> >> diff --git a/arch/loongarch/kernel/traps.c b/arch/loongarch/kernel/traps.c
> >> index 3adc44832205..1ea14f6c18d3 100644
> >> --- a/arch/loongarch/kernel/traps.c
> >> +++ b/arch/loongarch/kernel/traps.c
> >> @@ -72,9 +72,6 @@ static void show_backtrace(struct task_struct *task, const struct pt_regs *regs,
> >>          if (!task)
> >>                  task = current;
> >>
> >> -       if (user_mode(regs))
> >> -               state.type = UNWINDER_GUESS;
> >> -
> >>          printk("%sCall Trace:", loglvl);
> >>          for (unwind_start(&state, task, pregs);
> >>                !unwind_done(&state); unwind_next_frame(&state)) {
> >> diff --git a/arch/loongarch/kernel/unwind.c b/arch/loongarch/kernel/unwind.c
> >> new file mode 100644
> >> index 000000000000..24d2cf99bfb6
> >> --- /dev/null
> >> +++ b/arch/loongarch/kernel/unwind.c
> >> @@ -0,0 +1,52 @@
> >> +// SPDX-License-Identifier: GPL-2.0
> >> +/*
> >> + * Copyright (C) 2022 Loongson Technology Corporation Limited
> >> + */
> >> +#include <asm/unwind.h>
> >> +
> >> +#if defined(CONFIG_UNWINDER_GUESS)
> >> +const struct unwinder_ops *default_unwinder = &unwinder_guess;
> >> +#elif defined(CONFIG_UNWINDER_PROLOGUE)
> >> +const struct unwinder_ops *default_unwinder = &unwinder_prologue;
> >> +#endif
> >> +
> >> +unsigned long unwind_get_return_address(struct unwind_state *state)
> >> +{
> >> +       if (!state->ops || unwind_done(state))
> >> +               return 0;
> >> +       return state->ops->unwind_get_return_address(state);
> >> +}
> >> +EXPORT_SYMBOL_GPL(unwind_get_return_address);
> >> +
> >> +void unwind_start(struct unwind_state *state, struct task_struct *task,
> >> +                   struct pt_regs *regs)
> >> +{
> >> +       memset(state, 0, sizeof(*state));
> >> +       unwind_register_unwinder(state, default_unwinder);
> >> +       if (regs) {
> >> +               state->sp = regs->regs[3];
> >> +               state->pc = regs->csr_era;
> >> +               state->ra = regs->regs[1];
> >> +       } else if (task == current || task == NULL) {
> >> +               state->sp = (unsigned long)__builtin_frame_address(0);
> >> +               state->pc = (unsigned long)__builtin_return_address(0);
> >> +               state->ra = 0;
> >> +       } else {
> >> +               state->sp = thread_saved_fp(task);
> >> +               state->pc = thread_saved_ra(task);
> >> +               state->ra = 0;
> >> +       }
> >> +       state->task = task;
> >> +       get_stack_info(state->sp, state->task, &state->stack_info);
> >> +       state->pc = unwind_graph_addr(state, state->pc, state->sp);
> >> +       state->ops->unwind_start(state, task, regs);
> >> +}
> >> +EXPORT_SYMBOL_GPL(unwind_start);
> >> +
> >> +bool unwind_next_frame(struct unwind_state *state)
> >> +{
> >> +       if (!state->ops || unwind_done(state))
> >> +               return false;
> >> +       return state->ops->unwind_next_frame(state);
> >> +}
> >> +EXPORT_SYMBOL_GPL(unwind_next_frame);
> >> diff --git a/arch/loongarch/kernel/unwind_guess.c b/arch/loongarch/kernel/unwind_guess.c
> >> index 935d24f8c95c..b7ca2b88ac63 100644
> >> --- a/arch/loongarch/kernel/unwind_guess.c
> >> +++ b/arch/loongarch/kernel/unwind_guess.c
> >> @@ -7,51 +7,23 @@
> >>
> >>   #include <asm/unwind.h>
> >>
> >> -unsigned long unwind_get_return_address(struct unwind_state *state)
> >> +static unsigned long get_return_address(struct unwind_state *state)
> >>   {
> >> -       if (unwind_done(state))
> >> -               return 0;
> >>          return state->pc;
> >>   }
> >> -EXPORT_SYMBOL_GPL(unwind_get_return_address);
> >>
> >> -void unwind_start(struct unwind_state *state, struct task_struct *task,
> >> +static void start(struct unwind_state *state, struct task_struct *task,
> >>                      struct pt_regs *regs)
> >>   {
> >> -       memset(state, 0, sizeof(*state));
> >> -
> >> -       if (regs) {
> >> -               state->sp = regs->regs[3];
> >> -               state->pc = regs->csr_era;
> >> -       } else if (task == current || task == NULL) {
> >> -               state->sp = (unsigned long)__builtin_frame_address(0);
> >> -               state->pc = (unsigned long)__builtin_return_address(0);
> >> -       } else {
> >> -               state->sp = thread_saved_fp(task);
> >> -               state->pc = thread_saved_ra(task);
> >> -       }
> >> -
> >> -       state->task = task;
> >> -       state->first = true;
> >> -       state->pc = unwind_graph_addr(state, state->pc, state->sp);
> >> -       get_stack_info(state->sp, state->task, &state->stack_info);
> >> -
> >>          if (!unwind_done(state) && !__kernel_text_address(state->pc))
> >>                  unwind_next_frame(state);
> >>   }
> >> -EXPORT_SYMBOL_GPL(unwind_start);
> >>
> >> -bool unwind_next_frame(struct unwind_state *state)
> >> +static bool next_frame(struct unwind_state *state)
> >>   {
> >>          struct stack_info *info = &state->stack_info;
> >>          unsigned long addr;
> >>
> >> -       if (unwind_done(state))
> >> -               return false;
> >> -
> >> -       if (state->first)
> >> -               state->first = false;
> >> -
> >>          do {
> >>                  for (state->sp += sizeof(unsigned long);
> >>                       state->sp < info->end;
> >> @@ -68,4 +40,9 @@ bool unwind_next_frame(struct unwind_state *state)
> >>
> >>          return false;
> >>   }
> >> -EXPORT_SYMBOL_GPL(unwind_next_frame);
> >> +
> >> +const struct unwinder_ops unwinder_guess = {
> >> +       .unwind_start = start,
> >> +       .unwind_next_frame = next_frame,
> >> +       .unwind_get_return_address = get_return_address,
> >> +};
> >> diff --git a/arch/loongarch/kernel/unwind_prologue.c b/arch/loongarch/kernel/unwind_prologue.c
> >> index f7994ed05f04..beb57ea24da2 100644
> >> --- a/arch/loongarch/kernel/unwind_prologue.c
> >> +++ b/arch/loongarch/kernel/unwind_prologue.c
> >> @@ -19,31 +19,19 @@ static inline void unwind_state_fixup(struct unwind_state *state)
> >>   #endif
> >>   }
> >>
> >> -unsigned long unwind_get_return_address(struct unwind_state *state)
> >> +static unsigned long get_return_address(struct unwind_state *state)
> >>   {
> >> -       if (unwind_done(state))
> >> -               return 0;
> >>          return state->pc;
> >>   }
> >> -EXPORT_SYMBOL_GPL(unwind_get_return_address);
> >> -
> >> -static bool unwind_by_guess(struct unwind_state *state)
> >> -{
> >> -       struct stack_info *info = &state->stack_info;
> >> -       unsigned long addr;
> >> -
> >> -       for (state->sp += sizeof(unsigned long);
> >> -            state->sp < info->end;
> >> -            state->sp += sizeof(unsigned long)) {
> >> -               addr = *(unsigned long *)(state->sp);
> >> -               state->pc = unwind_graph_addr(state, addr, state->sp + 8);
> >> -               if (__kernel_text_address(state->pc))
> >> -                       return true;
> >> -       }
> >> -
> >> -       return false;
> >> -}
> >>
> >> +/*
> >> + * LoongArch function prologue like follows,
> >> + *     [others instructions not use stack var]
> >> + *     addi.d sp, sp, -imm
> >> + *     st.d   xx, sp, offset <- save callee saved regs and
> >> + *     st.d   yy, sp, offset    save ra if function is nest.
> >> + *     [others instructions]
> >> + */
> >>   static bool unwind_by_prologue(struct unwind_state *state)
> >>   {
> >>          long frame_ra = -1;
> >> @@ -89,6 +77,10 @@ static bool unwind_by_prologue(struct unwind_state *state)
> >>                  ip++;
> >>          }
> >>
> >> +       /*
> >> +        * Not find stack alloc action, PC may be in a leaf function. Only the
> >> +        * first being true is reasonable, otherwise indicate analysis is broken.
> >> +        */
> >>          if (!frame_size) {
> >>                  if (state->first)
> >>                          goto first;
> >> @@ -106,6 +98,7 @@ static bool unwind_by_prologue(struct unwind_state *state)
> >>                  ip++;
> >>          }
> >>
> >> +       /* Not find save $ra action, PC may be in a leaf function, too. */
> >>          if (frame_ra < 0) {
> >>                  if (state->first) {
> >>                          state->sp = state->sp + frame_size;
> >> @@ -114,96 +107,63 @@ static bool unwind_by_prologue(struct unwind_state *state)
> >>                  return false;
> >>          }
> >>
> >> -       if (state->first)
> >> -               state->first = false;
> >> -
> >>          state->pc = *(unsigned long *)(state->sp + frame_ra);
> >>          state->sp = state->sp + frame_size;
> >>          goto out;
> >>
> >>   first:
> >> -       state->first = false;
> >> -       if (state->pc == state->ra)
> >> -               return false;
> >> -
> >>          state->pc = state->ra;
> >>
> >>   out:
> >> +       state->first = false;
> >>          unwind_state_fixup(state);
> >>          return !!__kernel_text_address(state->pc);
> >>   }
> >>
> >> -void unwind_start(struct unwind_state *state, struct task_struct *task,
> >> +static void start(struct unwind_state *state, struct task_struct *task,
> >>                      struct pt_regs *regs)
> >>   {
> >> -       memset(state, 0, sizeof(*state));
> >> -       state->type = UNWINDER_PROLOGUE;
> >> -
> >> -       if (regs) {
> >> -               state->sp = regs->regs[3];
> >> -               state->pc = regs->csr_era;
> >> -               state->ra = regs->regs[1];
> >> -               if (!__kernel_text_address(state->pc))
> >> -                       state->type = UNWINDER_GUESS;
> >> -       } else if (task == current || task == NULL) {
> >> -               state->sp = (unsigned long)__builtin_frame_address(0);
> >> -               state->pc = (unsigned long)__builtin_return_address(0);
> >> -               state->ra = 0;
> >> -       } else {
> >> -               state->sp = thread_saved_fp(task);
> >> -               state->pc = thread_saved_ra(task);
> >> -               state->ra = 0;
> >> -       }
> >> -
> >> -       state->task = task;
> >>          state->first = true;
> >> -       state->pc = unwind_graph_addr(state, state->pc, state->sp);
> >> -       get_stack_info(state->sp, state->task, &state->stack_info);
> >>
> >> -       if (!unwind_done(state) && !__kernel_text_address(state->pc))
> >> -               unwind_next_frame(state);
> >> +       /*
> >> +        * The current PC is not kernel text address, we cannot find its
> >> +        * relative symbol. Thus, prologue analysis will be broken. Luckly,
> >> +        * we can use the guess unwinder.
> >> +        */
> >> +       if (!__kernel_text_address(state->pc)) {
> >> +               unwind_register_unwinder(state, &unwinder_guess);
> >> +               if (!unwind_done(state))
> >> +                       unwind_next_frame(state);
> >> +       }
> >>   }
> >> -EXPORT_SYMBOL_GPL(unwind_start);
> >>
> >> -bool unwind_next_frame(struct unwind_state *state)
> >> +static bool next_frame(struct unwind_state *state)
> >>   {
> >>          struct stack_info *info = &state->stack_info;
> >>          struct pt_regs *regs;
> >>          unsigned long pc;
> >>
> >> -       if (unwind_done(state))
> >> -               return false;
> >> -
> >>          do {
> >> -               switch (state->type) {
> >> -               case UNWINDER_GUESS:
> >> -                       state->first = false;
> >> -                       if (unwind_by_guess(state))
> >> -                               return true;
> >> -                       break;
> >> -
> >> -               case UNWINDER_PROLOGUE:
> >> -                       if (unwind_by_prologue(state)) {
> >> -                               state->pc = unwind_graph_addr(state, state->pc, state->sp);
> >> -                               return true;
> >> -                       }
> >> +               if (unwind_by_prologue(state)) {
> >> +                       state->pc = unwind_graph_addr(state, state->pc, state->sp);
> >> +                       return true;
> >> +               }
> >>
> >> -                       if (info->type == STACK_TYPE_IRQ &&
> >> -                               info->end == state->sp) {
> >> -                               regs = (struct pt_regs *)info->next_sp;
> >> -                               pc = regs->csr_era;
> >> +               if (info->type == STACK_TYPE_IRQ &&
> >> +                   info->end == state->sp) {
> >> +                       regs = (struct pt_regs *)info->next_sp;
> >> +                       pc = regs->csr_era;
> >>
> >> -                               if (user_mode(regs) || !__kernel_text_address(pc))
> >> -                                       return false;
> >> +                       if (user_mode(regs) || !__kernel_text_address(pc))
> >> +                               return false;
> >>
> >> -                               state->first = true;
> >> -                               state->ra = regs->regs[1];
> >> -                               state->sp = regs->regs[3];
> >> -                               state->pc = pc;
> >> -                               get_stack_info(state->sp, state->task, info);
> >> +                       state->first = true;
> >> +                       state->ra = regs->regs[1];
> >> +                       state->sp = regs->regs[3];
> >> +                       state->pc = pc;
> >> +                       get_stack_info(state->sp, state->task, info);
> >>
> >> -                               return true;
> >> -                       }
> >> +                       return true;
> >>                  }
> >>
> >>                  state->sp = info->next_sp;
> >> @@ -212,4 +172,9 @@ bool unwind_next_frame(struct unwind_state *state)
> >>
> >>          return false;
> >>   }
> >> -EXPORT_SYMBOL_GPL(unwind_next_frame);
> >> +
> >> +const struct unwinder_ops unwinder_prologue = {
> >> +       .unwind_start = start,
> >> +       .unwind_next_frame = next_frame,
> >> +       .unwind_get_return_address = get_return_address,
> >> +};
> >> --
> >> 2.34.3
> >>
> >>
>
