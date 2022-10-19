Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17FFC603841
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 04:52:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229834AbiJSCwu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 22:52:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbiJSCwh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 22:52:37 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 029C2E52F3
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 19:52:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6BDD1B821E9
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 02:52:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C51EC43142
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 02:52:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666147950;
        bh=K+QuC5meHZo6BrLK0LkS7uWDjQ0k4bJWjop/tds7mR4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=hUljwbM0Fn9+XOlgn6cf4K2Ej/AITItf84YOsNCRH1w0AG9mOlIzc2/L9uiSa1Pi2
         SI6yeqGwxES3NP++7bFOhaG5RRyntgeQ/3cxUFZBiXa7Q75V/xxDOVrc9+wcBo4abC
         ekRaUW7P0zy/2787vnqAXraem9pR1cfexST+e8bCxCOeeDWnqr4o50d6QQD7cf0a9v
         1k+yeENBWZjBnAedhNnITxdrxSnVKMMu32uxMynrdlmG+NCisXQ1E6Vsa06lqslbxu
         QxNQU+/+ZRne/TRRIphafdY1rSBet/uvW+cx4OisCbd2N8QF/XpqQD6kqPtBwWaA53
         EfVZR5eCmmKhw==
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-1322fa1cf6fso19121242fac.6
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 19:52:30 -0700 (PDT)
X-Gm-Message-State: ACrzQf1BWM1GiOB8b8831DM3VBAQyFp3Ko6dx950BoL8+t3kuiyE8YPN
        JrKb+5Cld1TIibGM2+7hK7Nd+ehY18Dqp6h5ZWY=
X-Google-Smtp-Source: AMsMyM7ZxkytzVU3yu34mw7+Rp+uGIBPCR0bX0iDXuW6Uq4pQz0bHvNuy2RrphslW9j4wJ5u8JERoKn2cX6UsJnLA1s=
X-Received: by 2002:a05:6870:5803:b0:12c:c3e0:99dc with SMTP id
 r3-20020a056870580300b0012cc3e099dcmr19367066oap.19.1666147949080; Tue, 18
 Oct 2022 19:52:29 -0700 (PDT)
MIME-Version: 1.0
References: <20220928162007.3791-1-jszhang@kernel.org> <20220928162007.3791-4-jszhang@kernel.org>
 <YzR8OUFuV+R1i1Y6@xhacker> <CAJF2gTSaCGeMG06xrRxjkk2UnjqcgrRTwdch9Ug_TyH-9LsP4g@mail.gmail.com>
In-Reply-To: <CAJF2gTSaCGeMG06xrRxjkk2UnjqcgrRTwdch9Ug_TyH-9LsP4g@mail.gmail.com>
From:   Guo Ren <guoren@kernel.org>
Date:   Wed, 19 Oct 2022 10:52:16 +0800
X-Gmail-Original-Message-ID: <CAJF2gTSPYscHa6s3HOjAKb3ggaSvggM=+qDzCeESZwY-vO2RJQ@mail.gmail.com>
Message-ID: <CAJF2gTSPYscHa6s3HOjAKb3ggaSvggM=+qDzCeESZwY-vO2RJQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] riscv: fix race when vmap stack overflow and
 remove shadow_stack
To:     Jisheng Zhang <jszhang@kernel.org>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 29, 2022 at 1:54 PM Guo Ren <guoren@kernel.org> wrote:
>
> On Thu, Sep 29, 2022 at 1:03 AM Jisheng Zhang <jszhang@kernel.org> wrote:
> >
> > On Thu, Sep 29, 2022 at 12:20:06AM +0800, Jisheng Zhang wrote:
> > > Currently, when detecting vmap stack overflow, riscv firstly switches
> > > to the so called shadow stack, then use this shadow stack to call the
> > > get_overflow_stack() to get the overflow stack. However, there's
> > > a race here if two or more harts use the same shadow stack at the same
> > > time.
> > >
> > > To solve this race, we rely on two facts:
> > > 1. the content of kernel thread pointer I.E "tp" register can still
> > > be gotten from the the CSR_SCRATCH register, thus we can clobber tp
> > > under the condtion that we restore tp from CSR_SCRATCH later.
> > >
> > > 2. Once vmap stack overflow happen, panic is comming soon, no
> > > performance concern at all, so we don't need to define the overflow
> > > stack as percpu var, we can simplify it into a pointer array which
> > > points to allocated pages.
> > >
> > > Thus we can use tp as a tmp register to get the cpu id to calculate
> > > the offset of overflow stack pointer array for each cpu w/o shadow
> > > stack any more. Thus the race condition is removed as a side effect.
> > >
> > > NOTE: we can use similar mechanism to let each cpu use different shadow
> > > stack to fix the race codition, but if we can remove shadow stack usage
> > > totally, why not.
> > >
> > > Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> > > Fixes: 31da94c25aea ("riscv: add VMAP_STACK overflow detection")
> > > ---
> > >  arch/riscv/include/asm/asm-prototypes.h |  1 -
> > >  arch/riscv/include/asm/thread_info.h    |  4 +-
> > >  arch/riscv/kernel/asm-offsets.c         |  1 +
> > >  arch/riscv/kernel/entry.S               | 56 ++++---------------------
> > >  arch/riscv/kernel/traps.c               | 31 ++++++++------
> > >  5 files changed, 29 insertions(+), 64 deletions(-)
> > >
> > > diff --git a/arch/riscv/include/asm/asm-prototypes.h b/arch/riscv/include/asm/asm-prototypes.h
> > > index ef386fcf3939..4a06fa0f6493 100644
> > > --- a/arch/riscv/include/asm/asm-prototypes.h
> > > +++ b/arch/riscv/include/asm/asm-prototypes.h
> > > @@ -25,7 +25,6 @@ DECLARE_DO_ERROR_INFO(do_trap_ecall_s);
> > >  DECLARE_DO_ERROR_INFO(do_trap_ecall_m);
> > >  DECLARE_DO_ERROR_INFO(do_trap_break);
> > >
> > > -asmlinkage unsigned long get_overflow_stack(void);
> > >  asmlinkage void handle_bad_stack(struct pt_regs *regs);
> > >
> > >  #endif /* _ASM_RISCV_PROTOTYPES_H */
> > > diff --git a/arch/riscv/include/asm/thread_info.h b/arch/riscv/include/asm/thread_info.h
> > > index c970d41dc4c6..c604a5212a73 100644
> > > --- a/arch/riscv/include/asm/thread_info.h
> > > +++ b/arch/riscv/include/asm/thread_info.h
> > > @@ -28,14 +28,12 @@
> > >
> > >  #define THREAD_SHIFT            (PAGE_SHIFT + THREAD_SIZE_ORDER)
> > >  #define OVERFLOW_STACK_SIZE     SZ_4K
> > > -#define SHADOW_OVERFLOW_STACK_SIZE (1024)
> > > +#define OVERFLOW_STACK_SHIFT 12
> >
> > oops, this should be removed, will update it in a newer version after
> > collecting review comments.
> >
> > >
> > >  #define IRQ_STACK_SIZE               THREAD_SIZE
> > >
> > >  #ifndef __ASSEMBLY__
> > >
> > > -extern long shadow_stack[SHADOW_OVERFLOW_STACK_SIZE / sizeof(long)];
> > > -
> > >  #include <asm/processor.h>
> > >  #include <asm/csr.h>
> > >
> > > diff --git a/arch/riscv/kernel/asm-offsets.c b/arch/riscv/kernel/asm-offsets.c
> > > index df9444397908..62bf3bacc322 100644
> > > --- a/arch/riscv/kernel/asm-offsets.c
> > > +++ b/arch/riscv/kernel/asm-offsets.c
> > > @@ -37,6 +37,7 @@ void asm_offsets(void)
> > >       OFFSET(TASK_TI_PREEMPT_COUNT, task_struct, thread_info.preempt_count);
> > >       OFFSET(TASK_TI_KERNEL_SP, task_struct, thread_info.kernel_sp);
> > >       OFFSET(TASK_TI_USER_SP, task_struct, thread_info.user_sp);
> > > +     OFFSET(TASK_TI_CPU, task_struct, thread_info.cpu);
> > >
> > >       OFFSET(TASK_THREAD_F0,  task_struct, thread.fstate.f[0]);
> > >       OFFSET(TASK_THREAD_F1,  task_struct, thread.fstate.f[1]);
> > > diff --git a/arch/riscv/kernel/entry.S b/arch/riscv/kernel/entry.S
> > > index a3e1ed2fa2ac..5a6171a90d81 100644
> > > --- a/arch/riscv/kernel/entry.S
> > > +++ b/arch/riscv/kernel/entry.S
> > > @@ -223,54 +223,16 @@ END(ret_from_exception)
> > >
> > >  #ifdef CONFIG_VMAP_STACK
> > >  ENTRY(handle_kernel_stack_overflow)
> > > -     la sp, shadow_stack
> > > -     addi sp, sp, SHADOW_OVERFLOW_STACK_SIZE
> > > -
> > > -     //save caller register to shadow stack
> > > -     addi sp, sp, -(PT_SIZE_ON_STACK)
> > > -     REG_S x1,  PT_RA(sp)
> > > -     REG_S x5,  PT_T0(sp)
> > > -     REG_S x6,  PT_T1(sp)
> > > -     REG_S x7,  PT_T2(sp)
> > > -     REG_S x10, PT_A0(sp)
> > > -     REG_S x11, PT_A1(sp)
> > > -     REG_S x12, PT_A2(sp)
> > > -     REG_S x13, PT_A3(sp)
> > > -     REG_S x14, PT_A4(sp)
> > > -     REG_S x15, PT_A5(sp)
> > > -     REG_S x16, PT_A6(sp)
> > > -     REG_S x17, PT_A7(sp)
> > > -     REG_S x28, PT_T3(sp)
> > > -     REG_S x29, PT_T4(sp)
> > > -     REG_S x30, PT_T5(sp)
> > > -     REG_S x31, PT_T6(sp)
> > > -
> > > -     la ra, restore_caller_reg
> > > -     tail get_overflow_stack
> > > -
> > > -restore_caller_reg:
> > > -     //save per-cpu overflow stack
> > > -     REG_S a0, -8(sp)
> > > -     //restore caller register from shadow_stack
> > > -     REG_L x1,  PT_RA(sp)
> > > -     REG_L x5,  PT_T0(sp)
> > > -     REG_L x6,  PT_T1(sp)
> > > -     REG_L x7,  PT_T2(sp)
> > > -     REG_L x10, PT_A0(sp)
> > > -     REG_L x11, PT_A1(sp)
> > > -     REG_L x12, PT_A2(sp)
> > > -     REG_L x13, PT_A3(sp)
> > > -     REG_L x14, PT_A4(sp)
> > > -     REG_L x15, PT_A5(sp)
> > > -     REG_L x16, PT_A6(sp)
> > > -     REG_L x17, PT_A7(sp)
> > > -     REG_L x28, PT_T3(sp)
> > > -     REG_L x29, PT_T4(sp)
> > > -     REG_L x30, PT_T5(sp)
> > > -     REG_L x31, PT_T6(sp)
> > > +     la sp, overflow_stack
> > > +     /* use tp as tmp register since we can restore it from CSR_SCRATCH */
> > > +     REG_L tp, TASK_TI_CPU(tp)
> > > +     slli tp, tp, RISCV_LGPTR
> > > +     add tp, sp, tp
> > > +     REG_L sp, 0(tp)
> > > +
> > > +     /* restore tp */
> > > +     csrr tp, CSR_SCRATCH
> > >
> > > -     //load per-cpu overflow stack
> > > -     REG_L sp, -8(sp)
> > >       addi sp, sp, -(PT_SIZE_ON_STACK)
> > >
> > >       //save context to overflow stack
> > > diff --git a/arch/riscv/kernel/traps.c b/arch/riscv/kernel/traps.c
> > > index 73f06cd149d9..b6c64f0fb70f 100644
> > > --- a/arch/riscv/kernel/traps.c
> > > +++ b/arch/riscv/kernel/traps.c
> > > @@ -216,23 +216,12 @@ int is_valid_bugaddr(unsigned long pc)
> > >  #endif /* CONFIG_GENERIC_BUG */
> > >
> > >  #ifdef CONFIG_VMAP_STACK
> > > -static DEFINE_PER_CPU(unsigned long [OVERFLOW_STACK_SIZE/sizeof(long)],
> > > -             overflow_stack)__aligned(16);
> > > -/*
> > > - * shadow stack, handled_ kernel_ stack_ overflow(in kernel/entry.S) is used
> > > - * to get per-cpu overflow stack(get_overflow_stack).
> > > - */
> > > -long shadow_stack[SHADOW_OVERFLOW_STACK_SIZE/sizeof(long)];
> > > -asmlinkage unsigned long get_overflow_stack(void)
> > > -{
> > > -     return (unsigned long)this_cpu_ptr(overflow_stack) +
> > > -             OVERFLOW_STACK_SIZE;
> > > -}
> > > +void *overflow_stack[NR_CPUS] __ro_after_init __aligned(16);
> Er... We've talked NR_CPUS = 8192, even a pointer would cause 64KB wasted.
>
> I prefer the previous solution with a atomic flag.
>
> diff --git a/arch/riscv/kernel/entry.S b/arch/riscv/kernel/entry.S
> index 5cbd6684ef52..42a3b14a20ab 100644
> --- a/arch/riscv/kernel/entry.S
> +++ b/arch/riscv/kernel/entry.S
> @@ -223,6 +223,9 @@ END(ret_from_exception)
>
>  #ifdef CONFIG_VMAP_STACK
>  ENTRY(handle_kernel_stack_overflow)
> +1:     la sp, spin_ shadow_stack
> +       amoswap.w sp, sp, (sp)
> +       bnez sp, 1b
>         la sp, shadow_stack
>         addi sp, sp, SHADOW_OVERFLOW_STACK_SIZE
>
> diff --git a/arch/riscv/kernel/traps.c b/arch/riscv/kernel/traps.c
> index 73f06cd149d9..9058a05cac53 100644
> --- a/arch/riscv/kernel/traps.c
> +++ b/arch/riscv/kernel/traps.c
> @@ -229,11 +229,15 @@ asmlinkage unsigned long get_overflow_stack(void)
>                 OVERFLOW_STACK_SIZE;
>  }
>
> +atomic_t spin_ shadow_stack __section(".sdata");
> +
>  asmlinkage void handle_bad_stack(struct pt_regs *regs)
>  {
>         unsigned long tsk_stk = (unsigned long)current->stack;
>         unsigned long ovf_stk = (unsigned long)this_cpu_ptr(overflow_stack);
>
> +       atomic_set_release(spin_ shadow_stack, 0);
> +
>         console_verbose();
>
>         pr_emerg("Insufficient stack space to handle exception!\n");
Hi Jisheng,

Could you give out a new patch based on the above style to fix the
problem first? It's a minor modification and consolidate the entry.S
procedure.


>
>
>
>
>
> > >
> > >  asmlinkage void handle_bad_stack(struct pt_regs *regs)
> > >  {
> > >       unsigned long tsk_stk = (unsigned long)current->stack;
> > > -     unsigned long ovf_stk = (unsigned long)this_cpu_ptr(overflow_stack);
> > > +     unsigned long ovf_stk = (unsigned long)overflow_stack[raw_smp_processor_id()];
> > >
> > >       console_verbose();
> > >
> > > @@ -248,4 +237,20 @@ asmlinkage void handle_bad_stack(struct pt_regs *regs)
> > >       for (;;)
> > >               wait_for_interrupt();
> > >  }
> > > +
> > > +static int __init alloc_overflow_stacks(void)
> > > +{
> > > +     u8 *s;
> > > +     int cpu;
> > > +
> > > +     for_each_possible_cpu(cpu) {
> > > +             s = (u8 *)__get_free_pages(GFP_KERNEL, get_order(OVERFLOW_STACK_SIZE));
> > > +             if (WARN_ON(!s))
> > > +                     return -ENOMEM;
> > > +             overflow_stack[cpu] = &s[OVERFLOW_STACK_SIZE];
> >
> > Since overflow_stack[cpu] points to the top of the slack, we need to
> > update the ovf_stack dumping in handle_bad_stack(). will take care
> > this in newer version.
> >
> > > +             printk("%px\n", overflow_stack[cpu]);
> >
> > forget to remove this printk :(
>
>
>
> --
> Best Regards
>  Guo Ren



-- 
Best Regards
 Guo Ren
