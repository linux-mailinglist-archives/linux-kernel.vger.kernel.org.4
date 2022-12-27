Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56C7C6567E3
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Dec 2022 08:37:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229968AbiL0HhP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Dec 2022 02:37:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbiL0HhN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Dec 2022 02:37:13 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B540D2616
        for <linux-kernel@vger.kernel.org>; Mon, 26 Dec 2022 23:37:12 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 47BA460F37
        for <linux-kernel@vger.kernel.org>; Tue, 27 Dec 2022 07:37:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96AB8C433F2
        for <linux-kernel@vger.kernel.org>; Tue, 27 Dec 2022 07:37:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672126631;
        bh=yW8sx49Bqj1F3p6Fj5aD8adoFCB5BVioG2FGMnGJrV8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=jyv1p1vBfd96xG4OUC/RY8B2KgTSgEpoaFeN6tw+dM03mK/wN+/8bidRXdSRA6wdS
         wx0kN+DcBAVA9/6UBaZ4h4cdNBF6YSLqnY6h3ONYB5pbXJ3GJKTQeJXrqAMPSXPDgO
         iIkuQRPSosVf3DgJriCGEqYkRy5J/oUAWHYW/JLLGpKvahkam0ZFYsKBWTQ8z0C5ln
         rvBJyiVJwW6Oyptr7FJQ2ljU5kfXjGQrhDnXzSa05rsfSiL6pi+sVNViznk0k2yujl
         63tFom1JXRQxeWOIx4UXV0bx6/Y4/IIOMcnGYPmX4+Sa58uvfnM14gvAChqi6MGRm5
         eYTqdh9CfLJrQ==
Received: by mail-ed1-f52.google.com with SMTP id i15so18032357edf.2
        for <linux-kernel@vger.kernel.org>; Mon, 26 Dec 2022 23:37:11 -0800 (PST)
X-Gm-Message-State: AFqh2kqIOQ4Ia3Cimt0NeGjOu0TefYxd0P6uNdifWosPSkwGc0eAVGgC
        SUiC0WxXg1wvSDso5eGHL3R4Boj4jSSXRK4hGrQ=
X-Google-Smtp-Source: AMrXdXvmq/FhZkjr3S4+YTytjaL9PDB1Uw5yUcQf97+8tz46lVqGs/oVq6hBB+L0g+ao8PIowtXoGfl2ly/Pt7vvYGQ=
X-Received: by 2002:aa7:cdc5:0:b0:470:327d:c46c with SMTP id
 h5-20020aa7cdc5000000b00470327dc46cmr1814812edw.298.1672126629656; Mon, 26
 Dec 2022 23:37:09 -0800 (PST)
MIME-Version: 1.0
References: <20221221074238.6699-1-hejinyang@loongson.cn>
In-Reply-To: <20221221074238.6699-1-hejinyang@loongson.cn>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Tue, 27 Dec 2022 15:37:02 +0800
X-Gmail-Original-Message-ID: <CAAhV-H6VX=d1oymY0rh-mwOPMuBsYd7C9RzQat8BmmnrJ7apng@mail.gmail.com>
Message-ID: <CAAhV-H6VX=d1oymY0rh-mwOPMuBsYd7C9RzQat8BmmnrJ7apng@mail.gmail.com>
Subject: Re: [PATCH] LoongArch: Fix irq enable in exception handlers
To:     Jinyang He <hejinyang@loongson.cn>
Cc:     WANG Xuerui <kernel@xen0n.name>,
        Tiezhu Yang <yangtiezhu@loongson.cn>,
        loongarch@lists.linux.dev, linux-kernel@vger.kernel.org
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

Move die_if_kernel to irq disabled context to solve what? And LBT is
surely allowed to be triggered in kernel context.

Huacai

On Wed, Dec 21, 2022 at 3:43 PM Jinyang He <hejinyang@loongson.cn> wrote:
>
> The interrupt state can be got by regs->csr_prmd. Once previous
> interrupt state is disable, we shouldn't enable interrupt if we
> triggered exception which can be triggered in kernel mode. So
> conditionally enable interrupt. For those do_\exception which
> can not triggered in kernel mode but need enable interrupt, call
> die_if_kernel() firstly. And for do_lsx, do_lasx and do_lbt cannot
> triggered in kernel mode, too.
>
> Signed-off-by: Jinyang He <hejinyang@loongson.cn>
> ---
>  arch/loongarch/kernel/traps.c | 19 ++++++++++---------
>  1 file changed, 10 insertions(+), 9 deletions(-)
>
> diff --git a/arch/loongarch/kernel/traps.c b/arch/loongarch/kernel/traps.c
> index 1ea14f6c18d3..3ac7b32d1e15 100644
> --- a/arch/loongarch/kernel/traps.c
> +++ b/arch/loongarch/kernel/traps.c
> @@ -340,9 +340,9 @@ asmlinkage void noinstr do_fpe(struct pt_regs *regs, unsigned long fcsr)
>
>         /* Clear FCSR.Cause before enabling interrupts */
>         write_fcsr(LOONGARCH_FCSR0, fcsr & ~mask_fcsr_x(fcsr));
> -       local_irq_enable();
>
>         die_if_kernel("FP exception in kernel code", regs);
> +       local_irq_enable();
>
>         sig = SIGFPE;
>         fault_addr = (void __user *) regs->csr_era;
> @@ -432,7 +432,8 @@ asmlinkage void noinstr do_bp(struct pt_regs *regs)
>         unsigned long era = exception_era(regs);
>         irqentry_state_t state = irqentry_enter(regs);
>
> -       local_irq_enable();
> +       if (regs->csr_prmd & CSR_PRMD_PIE)
> +               local_irq_enable();
>         current->thread.trap_nr = read_csr_excode();
>         if (__get_inst(&opcode, (u32 *)era, user))
>                 goto out_sigsegv;
> @@ -514,7 +515,8 @@ asmlinkage void noinstr do_ri(struct pt_regs *regs)
>         unsigned int __user *era = (unsigned int __user *)exception_era(regs);
>         irqentry_state_t state = irqentry_enter(regs);
>
> -       local_irq_enable();
> +       if (regs->csr_prmd & CSR_PRMD_PIE)
> +               local_irq_enable();
>         current->thread.trap_nr = read_csr_excode();
>
>         if (notify_die(DIE_RI, "RI Fault", regs, 0, current->thread.trap_nr,
> @@ -606,8 +608,8 @@ asmlinkage void noinstr do_fpu(struct pt_regs *regs)
>  {
>         irqentry_state_t state = irqentry_enter(regs);
>
> -       local_irq_enable();
>         die_if_kernel("do_fpu invoked from kernel context!", regs);
> +       local_irq_enable();
>         BUG_ON(is_lsx_enabled());
>         BUG_ON(is_lasx_enabled());
>
> @@ -623,13 +625,13 @@ asmlinkage void noinstr do_lsx(struct pt_regs *regs)
>  {
>         irqentry_state_t state = irqentry_enter(regs);
>
> +       die_if_kernel("do_lsx invoked from kernel context!", regs);
>         local_irq_enable();
>         if (!cpu_has_lsx) {
>                 force_sig(SIGILL);
>                 goto out;
>         }
>
> -       die_if_kernel("do_lsx invoked from kernel context!", regs);
>         BUG_ON(is_lasx_enabled());
>
>         preempt_disable();
> @@ -645,14 +647,13 @@ asmlinkage void noinstr do_lasx(struct pt_regs *regs)
>  {
>         irqentry_state_t state = irqentry_enter(regs);
>
> +       die_if_kernel("do_lasx invoked from kernel context!", regs);
>         local_irq_enable();
>         if (!cpu_has_lasx) {
>                 force_sig(SIGILL);
>                 goto out;
>         }
>
> -       die_if_kernel("do_lasx invoked from kernel context!", regs);
> -
>         preempt_disable();
>         init_restore_lasx();
>         preempt_enable();
> @@ -666,6 +667,7 @@ asmlinkage void noinstr do_lbt(struct pt_regs *regs)
>  {
>         irqentry_state_t state = irqentry_enter(regs);
>
> +       die_if_kernel("do_lbt invoked from kernel context!", regs);
>         local_irq_enable();
>         force_sig(SIGILL);
>         local_irq_disable();
> @@ -677,7 +679,6 @@ asmlinkage void noinstr do_reserved(struct pt_regs *regs)
>  {
>         irqentry_state_t state = irqentry_enter(regs);
>
> -       local_irq_enable();
>         /*
>          * Game over - no way to handle this if it ever occurs. Most probably
>          * caused by a fatal error after another hardware/software error.
> @@ -685,8 +686,8 @@ asmlinkage void noinstr do_reserved(struct pt_regs *regs)
>         pr_err("Caught reserved exception %u on pid:%d [%s] - should not happen\n",
>                 read_csr_excode(), current->pid, current->comm);
>         die_if_kernel("do_reserved exception", regs);
> +       local_irq_enable();
>         force_sig(SIGUNUSED);
> -
>         local_irq_disable();
>
>         irqentry_exit(regs, state);
> --
> 2.34.3
>
