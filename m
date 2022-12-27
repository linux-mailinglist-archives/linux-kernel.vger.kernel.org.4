Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B177C656934
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Dec 2022 10:53:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231403AbiL0JxQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Dec 2022 04:53:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231558AbiL0Jw0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Dec 2022 04:52:26 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7F68A46F
        for <linux-kernel@vger.kernel.org>; Tue, 27 Dec 2022 01:52:13 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8D54DB80EA6
        for <linux-kernel@vger.kernel.org>; Tue, 27 Dec 2022 09:52:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DB6AC433F0
        for <linux-kernel@vger.kernel.org>; Tue, 27 Dec 2022 09:52:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672134731;
        bh=kIeKnTiu2FsGj/AVb8v4P3M58p9y+MLgZKr3pyI5Br0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=AM1O0ev+S1zDkCDcok3SLYVlno053VLM1nOcmK+VHlB5kYDdBwdrQo11LN5ep9hmi
         lk3k4SW4UsiUW3CupXnV+am5CeUNgSmHt7STasLbLYLzFz1qrgovHfsooCCBVSGjBF
         KndN2Iw/Y5KearNJZKFUxx2+jWn+LR6u0OyVJG67Pw6c0kOO7DDugSk7esjAnEPWeO
         WwdBPfObDN6ZGKb9uIl/WZ+nFANW7RookteFdm52vrViGlIqbR+OdczL/dpP4thr31
         XZPuacfm0RborZu96uve7l+37GwPeRyEFSb6FdOO0ZJKjh71WdTzNjsziHPnwNVZwT
         mrBWmJkdrz8NQ==
Received: by mail-ej1-f47.google.com with SMTP id jo4so30800817ejb.7
        for <linux-kernel@vger.kernel.org>; Tue, 27 Dec 2022 01:52:11 -0800 (PST)
X-Gm-Message-State: AFqh2kqBpNnKIb7e7MyQks6EOq1yZXUjJb5ea7MyaDiAAy94lbh3/OfR
        6Jp3xNl/17FhpqGAytc26A+fSZr550dk7rA2Zz8=
X-Google-Smtp-Source: AMrXdXvWxPbx2UHbpPRVQl/7++65hvK3e/tm/G4ee5+Tt3IkFgau8aGPHMoiCaZPPSG8iV1ocr8eLgD3H2YK5z1kGdY=
X-Received: by 2002:a17:906:5255:b0:7c1:6b1f:e131 with SMTP id
 y21-20020a170906525500b007c16b1fe131mr1298717ejm.557.1672134729505; Tue, 27
 Dec 2022 01:52:09 -0800 (PST)
MIME-Version: 1.0
References: <20221221074238.6699-1-hejinyang@loongson.cn> <CAAhV-H6VX=d1oymY0rh-mwOPMuBsYd7C9RzQat8BmmnrJ7apng@mail.gmail.com>
 <8eaea09e-67b0-5e51-4632-2c31a4c56a3e@loongson.cn>
In-Reply-To: <8eaea09e-67b0-5e51-4632-2c31a4c56a3e@loongson.cn>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Tue, 27 Dec 2022 17:52:02 +0800
X-Gmail-Original-Message-ID: <CAAhV-H7maW1YWhfvCzYVix=aCMMFbx0KkGodaBjka4ThunBO5Q@mail.gmail.com>
Message-ID: <CAAhV-H7maW1YWhfvCzYVix=aCMMFbx0KkGodaBjka4ThunBO5Q@mail.gmail.com>
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

On Tue, Dec 27, 2022 at 5:30 PM Jinyang He <hejinyang@loongson.cn> wrote:
>
>
> On 2022-12-27 15:37, Huacai Chen wrote:
> > Hi, Jinyang,
> >
> > Move die_if_kernel to irq disabled context to solve what?
>
> For more strict logical. If the code flow go to die in die_if_kernel(),
> its interrupt state is enable, that means it may cause schedule.
> So I think it is better to call die_if_kernel() firstly.
die_if_kernel is called with irq enabled in old kernels for several
years, and has no problems.

>
>
> >   And LBT is
> > surely allowed to be triggered in kernel context.
>
> I'm not familar with lbt, I just not see any lbt codes in kernel. Plz,
> how lbt exception triggered, and how kernel trigger lbt exception?
You can ask Huqi for more details, and this was discussed publicly last week.

Huacai
>
>
> Thanks,
>
> Jinyang
>
>
> >
> > Huacai
> >
> > On Wed, Dec 21, 2022 at 3:43 PM Jinyang He <hejinyang@loongson.cn> wrote:
> >> The interrupt state can be got by regs->csr_prmd. Once previous
> >> interrupt state is disable, we shouldn't enable interrupt if we
> >> triggered exception which can be triggered in kernel mode. So
> >> conditionally enable interrupt. For those do_\exception which
> >> can not triggered in kernel mode but need enable interrupt, call
> >> die_if_kernel() firstly. And for do_lsx, do_lasx and do_lbt cannot
> >> triggered in kernel mode, too.
> >>
> >> Signed-off-by: Jinyang He <hejinyang@loongson.cn>
> >> ---
> >>   arch/loongarch/kernel/traps.c | 19 ++++++++++---------
> >>   1 file changed, 10 insertions(+), 9 deletions(-)
> >>
> >> diff --git a/arch/loongarch/kernel/traps.c b/arch/loongarch/kernel/traps.c
> >> index 1ea14f6c18d3..3ac7b32d1e15 100644
> >> --- a/arch/loongarch/kernel/traps.c
> >> +++ b/arch/loongarch/kernel/traps.c
> >> @@ -340,9 +340,9 @@ asmlinkage void noinstr do_fpe(struct pt_regs *regs, unsigned long fcsr)
> >>
> >>          /* Clear FCSR.Cause before enabling interrupts */
> >>          write_fcsr(LOONGARCH_FCSR0, fcsr & ~mask_fcsr_x(fcsr));
> >> -       local_irq_enable();
> >>
> >>          die_if_kernel("FP exception in kernel code", regs);
> >> +       local_irq_enable();
> >>
> >>          sig = SIGFPE;
> >>          fault_addr = (void __user *) regs->csr_era;
> >> @@ -432,7 +432,8 @@ asmlinkage void noinstr do_bp(struct pt_regs *regs)
> >>          unsigned long era = exception_era(regs);
> >>          irqentry_state_t state = irqentry_enter(regs);
> >>
> >> -       local_irq_enable();
> >> +       if (regs->csr_prmd & CSR_PRMD_PIE)
> >> +               local_irq_enable();
> >>          current->thread.trap_nr = read_csr_excode();
> >>          if (__get_inst(&opcode, (u32 *)era, user))
> >>                  goto out_sigsegv;
> >> @@ -514,7 +515,8 @@ asmlinkage void noinstr do_ri(struct pt_regs *regs)
> >>          unsigned int __user *era = (unsigned int __user *)exception_era(regs);
> >>          irqentry_state_t state = irqentry_enter(regs);
> >>
> >> -       local_irq_enable();
> >> +       if (regs->csr_prmd & CSR_PRMD_PIE)
> >> +               local_irq_enable();
> >>          current->thread.trap_nr = read_csr_excode();
> >>
> >>          if (notify_die(DIE_RI, "RI Fault", regs, 0, current->thread.trap_nr,
> >> @@ -606,8 +608,8 @@ asmlinkage void noinstr do_fpu(struct pt_regs *regs)
> >>   {
> >>          irqentry_state_t state = irqentry_enter(regs);
> >>
> >> -       local_irq_enable();
> >>          die_if_kernel("do_fpu invoked from kernel context!", regs);
> >> +       local_irq_enable();
> >>          BUG_ON(is_lsx_enabled());
> >>          BUG_ON(is_lasx_enabled());
> >>
> >> @@ -623,13 +625,13 @@ asmlinkage void noinstr do_lsx(struct pt_regs *regs)
> >>   {
> >>          irqentry_state_t state = irqentry_enter(regs);
> >>
> >> +       die_if_kernel("do_lsx invoked from kernel context!", regs);
> >>          local_irq_enable();
> >>          if (!cpu_has_lsx) {
> >>                  force_sig(SIGILL);
> >>                  goto out;
> >>          }
> >>
> >> -       die_if_kernel("do_lsx invoked from kernel context!", regs);
> >>          BUG_ON(is_lasx_enabled());
> >>
> >>          preempt_disable();
> >> @@ -645,14 +647,13 @@ asmlinkage void noinstr do_lasx(struct pt_regs *regs)
> >>   {
> >>          irqentry_state_t state = irqentry_enter(regs);
> >>
> >> +       die_if_kernel("do_lasx invoked from kernel context!", regs);
> >>          local_irq_enable();
> >>          if (!cpu_has_lasx) {
> >>                  force_sig(SIGILL);
> >>                  goto out;
> >>          }
> >>
> >> -       die_if_kernel("do_lasx invoked from kernel context!", regs);
> >> -
> >>          preempt_disable();
> >>          init_restore_lasx();
> >>          preempt_enable();
> >> @@ -666,6 +667,7 @@ asmlinkage void noinstr do_lbt(struct pt_regs *regs)
> >>   {
> >>          irqentry_state_t state = irqentry_enter(regs);
> >>
> >> +       die_if_kernel("do_lbt invoked from kernel context!", regs);
> >>          local_irq_enable();
> >>          force_sig(SIGILL);
> >>          local_irq_disable();
> >> @@ -677,7 +679,6 @@ asmlinkage void noinstr do_reserved(struct pt_regs *regs)
> >>   {
> >>          irqentry_state_t state = irqentry_enter(regs);
> >>
> >> -       local_irq_enable();
> >>          /*
> >>           * Game over - no way to handle this if it ever occurs. Most probably
> >>           * caused by a fatal error after another hardware/software error.
> >> @@ -685,8 +686,8 @@ asmlinkage void noinstr do_reserved(struct pt_regs *regs)
> >>          pr_err("Caught reserved exception %u on pid:%d [%s] - should not happen\n",
> >>                  read_csr_excode(), current->pid, current->comm);
> >>          die_if_kernel("do_reserved exception", regs);
> >> +       local_irq_enable();
> >>          force_sig(SIGUNUSED);
> >> -
> >>          local_irq_disable();
> >>
> >>          irqentry_exit(regs, state);
> >> --
> >> 2.34.3
> >>
>
>
