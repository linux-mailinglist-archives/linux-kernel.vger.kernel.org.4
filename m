Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F25C667E0AC
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 10:49:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233271AbjA0JtO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 04:49:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232078AbjA0Js7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 04:48:59 -0500
Received: from mail-ua1-x933.google.com (mail-ua1-x933.google.com [IPv6:2607:f8b0:4864:20::933])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B25CB771
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 01:48:25 -0800 (PST)
Received: by mail-ua1-x933.google.com with SMTP id r10so944015ual.3
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 01:48:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Y8mj6KYI9SMz5c+akcHzCTLUq01OOb7f1RneqG57bVU=;
        b=OXPPTcSbm91C/3tGFzsK6id75nZmIge+I6bARezNOObtadzbYhBEhT7t7A7jJfgeuN
         JIjB8BeLKOI6hOqjWIu0ReJAYifACb5VCdi9OdbLFjBzA/MqaBIcdb1guiMCLgULjmqY
         QBCTkLHenGsEphhVb/8546MNwBY2MhFLQ/kuMkt1HTaYgIdWXHJzPI0N/zwpXbjcSfyH
         SboDxcZRfq30IuG2/rQuIaNaX1Jd4UKbJuuNgpn4/1QPErBj1et558t1KkxW9UeHUUZx
         oofnZMPX/6xROqU4ozEfSSSiNbT1QCAuqL1y+07AxmaXfwBjQmMI63c5dLXRoERMiKju
         sZdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Y8mj6KYI9SMz5c+akcHzCTLUq01OOb7f1RneqG57bVU=;
        b=NCO04qpkm1wXISr4MpmkyPTzaSLz5Ryj7fz4bpNa1IahB6X3Z7C8uxhyvzFiQBq4Ir
         UWAU6KfNp43RUKzukHeeapFzVvbe/avhKdZWx/JJ+Nko2ht7YPHFVv0AUOqu4HjxIHcc
         7eQD07GgSQz7uiNZ13y/5v1FZwbmc2Wvrz9SQXSTKPOa7lgqhQ2pvKdvWfU4ThRodrmu
         JQih7rvLZzDfBJ+lwWxKmUsvZc/zru40LkdgEO/ok6XX83QSRUPOEucZ/NSs4QIrMAV4
         oSO835K+VGkZevrhZ/v7/9YHOjKyDlPmo2edzb3pNBC/824miMxzblrlzFvI16RdtvdG
         juew==
X-Gm-Message-State: AFqh2koqmGewhnNITz+ONpLUe2xYmcMHlElZk4SLWwg2mYWQSpmEig5p
        u8j99yjpbgHuSJu3iTautK9XdYW4dGslyXG8u0uhWw==
X-Google-Smtp-Source: AMrXdXvE+vELs6fI/rCgyeJBX8jAkPtIFBkM/AtEBAPoh9hQiDxRP7IByPlIZdxu1KX72IRbQhdio1hGvHeQVqjlTAU=
X-Received: by 2002:ab0:274a:0:b0:63d:5ab4:6c66 with SMTP id
 c10-20020ab0274a000000b0063d5ab46c66mr3096383uap.25.1674812904393; Fri, 27
 Jan 2023 01:48:24 -0800 (PST)
MIME-Version: 1.0
References: <20221219102452.2860088-1-sumit.garg@linaro.org>
 <20221219102452.2860088-2-sumit.garg@linaro.org> <20230126133929.GC29148@willie-the-truck>
In-Reply-To: <20230126133929.GC29148@willie-the-truck>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Fri, 27 Jan 2023 15:18:13 +0530
Message-ID: <CAFA6WYOcfdSfmV3FBYaPTc8vf7xrcfEje6d_mpH7Lv1OHb+bMg@mail.gmail.com>
Subject: Re: [PATCH v5 1/2] arm64: entry: Skip single stepping into interrupt handlers
To:     Will Deacon <will@kernel.org>
Cc:     catalin.marinas@arm.com, mark.rutland@arm.com,
        daniel.thompson@linaro.org, dianders@chromium.org,
        liwei391@huawei.com, mhiramat@kernel.org, maz@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Will,

Thanks for your review.

On Thu, 26 Jan 2023 at 19:09, Will Deacon <will@kernel.org> wrote:
>
> On Mon, Dec 19, 2022 at 03:54:51PM +0530, Sumit Garg wrote:
> > Currently on systems where the timer interrupt (or any other
> > fast-at-human-scale periodic interrupt) is active then it is impossible
> > to step any code with interrupts unlocked because we will always end up
> > stepping into the timer interrupt instead of stepping the user code.
> >
> > The common user's goal while single stepping is that when they step then
> > the system will stop at PC+4 or PC+I for a branch that gets taken
> > relative to the instruction they are stepping. So, fix broken single step
> > implementation via skipping single stepping into interrupt handlers.
> >
> > The methodology is when we receive an interrupt from EL1, check if we
> > are single stepping (pstate.SS). If yes then we save MDSCR_EL1.SS and
> > clear the register bit if it was set. Then unmask only D and leave I set.
> > On return from the interrupt, set D and restore MDSCR_EL1.SS. Along with
> > this skip reschedule if we were stepping.
> >
> > Suggested-by: Will Deacon <will@kernel.org>
> > Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> > Tested-by: Douglas Anderson <dianders@chromium.org>
> > ---
> >  arch/arm64/kernel/entry-common.c | 22 ++++++++++++++++++++--
> >  1 file changed, 20 insertions(+), 2 deletions(-)
> >
> > diff --git a/arch/arm64/kernel/entry-common.c b/arch/arm64/kernel/entry-common.c
> > index cce1167199e3..688d1ef8e864 100644
> > --- a/arch/arm64/kernel/entry-common.c
> > +++ b/arch/arm64/kernel/entry-common.c
> > @@ -231,11 +231,15 @@ DEFINE_STATIC_KEY_TRUE(sk_dynamic_irqentry_exit_cond_resched);
> >  #define need_irq_preemption()        (IS_ENABLED(CONFIG_PREEMPTION))
> >  #endif
> >
> > -static void __sched arm64_preempt_schedule_irq(void)
> > +static void __sched arm64_preempt_schedule_irq(struct pt_regs *regs)
> >  {
> >       if (!need_irq_preemption())
> >               return;
> >
> > +     /* Don't reschedule in case we are single stepping */
> > +     if (!(regs->pstate & DBG_SPSR_SS))
> > +             return;
>
> Hmm, isn't this the common case? PSTATE.SS will usually be clear, no?
>

Ah I see, looks like a copy paste error from v4. This check should be instead:

     /* Don't reschedule in case we are single stepping */
     if (regs->pstate & DBG_SPSR_SS)
             return;

Thanks for catching this, I will correct it in the next version.

> >        * Note: thread_info::preempt_count includes both thread_info::count
> >        * and thread_info::need_resched, and is not equivalent to
> > @@ -471,19 +475,33 @@ static __always_inline void __el1_irq(struct pt_regs *regs,
> >       do_interrupt_handler(regs, handler);
> >       irq_exit_rcu();
> >
> > -     arm64_preempt_schedule_irq();
> > +     arm64_preempt_schedule_irq(regs);
> >
> >       exit_to_kernel_mode(regs);
> >  }
> > +
> >  static void noinstr el1_interrupt(struct pt_regs *regs,
> >                                 void (*handler)(struct pt_regs *))
> >  {
> > +     unsigned long mdscr;
> > +
> > +     /* Disable single stepping within interrupt handler */
> > +     if (regs->pstate & DBG_SPSR_SS) {
> > +             mdscr = read_sysreg(mdscr_el1);
> > +             write_sysreg(mdscr & ~DBG_MDSCR_SS, mdscr_el1);
> > +     }
>
> I think this will break the implicit handling of kernel {break,watch}points.
>

Can you please elaborate here? AFAICS, this change will only omit the
interrupt handler while stepping.

> Sadly, I think any attempts to workaround the issues here are likely just
> to push the problems around. We really need to overhaul the debug exception
> handling logic we have, which means I need to get back to writing up a
> proposal.
>

I will be very happy to assist you if you can help me understand the
problem here.

BTW, patch #2 should be an independent fix from patch #1. Can you pull
that alone?

-Sumit

> Will
