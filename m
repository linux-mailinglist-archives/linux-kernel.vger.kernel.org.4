Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63981650787
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Dec 2022 07:24:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231320AbiLSGYG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 01:24:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229598AbiLSGYE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 01:24:04 -0500
Received: from mail-vs1-xe2b.google.com (mail-vs1-xe2b.google.com [IPv6:2607:f8b0:4864:20::e2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C448F2AEE
        for <linux-kernel@vger.kernel.org>; Sun, 18 Dec 2022 22:24:03 -0800 (PST)
Received: by mail-vs1-xe2b.google.com with SMTP id q128so7725070vsa.13
        for <linux-kernel@vger.kernel.org>; Sun, 18 Dec 2022 22:24:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ieg4mz8CGz63hjlbn3pVUMyrP+qTfkGOkwLRN6lSU9o=;
        b=KTdQmpkUsHVou/93MldHqzVuJg5zKQG9hLxOCAFp6Y/MmwhxX8wwVgQ9zzghRCdIjn
         4mdfqTzkAYAU1rHjykIi92E5hF0hncNMyfMV8FL1UWaRrFlnMAO6N+iw+9bSaTNK4sdD
         wPxLYyt1s83+ivt7ofc3GDHisQov2Wa1aUd0gcmkBBIiuaJ8xEfkDRxxnhbdqGLsNdaq
         m5hMAPTCWVkiPaisDSRtVa4Cu0HwG4Vvln1BWXgmDFrW20YzTFVOLtN9VvKVhAFH5N/V
         1d02pu2WjDMYTWUwGgtqv2LaZo9zMyF+1yoeCXxeXJit9uVkLTxp3zo79zlj9hKpeknQ
         XOMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ieg4mz8CGz63hjlbn3pVUMyrP+qTfkGOkwLRN6lSU9o=;
        b=UNdupAFOuVrSmZRfOuQ2GVd9CGt5kyi3B7SOpE2PrT8mpKzkJOvV+GUSB50QPUOWrp
         VHoBZZ0aYLoUHiGHnau2Dj2xVxHFEtWoZXV/ruKeKFrj7dad6yl+a7hmB2rObmA710oe
         OS7KAampKPHnRnwtMGmbs20y9xxqeliI/4uGy2uYA1WdHrGOU/ddQV6lj1XaWmpE1brO
         cMN8YVNRlqYzgcY6P3+0gRHNKeHz9NiLMl1cMZJUStpqx/tVdWVUOYyWPUDTIWkMAxjc
         3LCP5sBb5zFMlRnElkyeQtFDO7+717+jMNKaK8ww/KAeVyiJMjlCnDfn/cn8/q6yP6iq
         BJnw==
X-Gm-Message-State: ANoB5pnllhYMYVkLPl8PapxJyjZuZM1plKqp3kP9pMOPRUlsdcLZUJkP
        uT69IkekxQvKbIDSvgBQC2QvOswpMFkb6tr62Y+P9Q==
X-Google-Smtp-Source: AA0mqf4YTPfMaZHoacpB8JvPh5iQOa4VIgX6mgFM7bLOWfUuWxNM2BPiaQlkpjLrN8ysfdosCiNO1wZi2QHrQqT69LA=
X-Received: by 2002:a67:c810:0:b0:3b3:10b1:8e22 with SMTP id
 u16-20020a67c810000000b003b310b18e22mr5142061vsk.50.1671431042866; Sun, 18
 Dec 2022 22:24:02 -0800 (PST)
MIME-Version: 1.0
References: <20221215142903.2624142-1-sumit.garg@linaro.org>
 <20221215142903.2624142-2-sumit.garg@linaro.org> <Y5yge52LQGp0uhIF@FVFF77S0Q05N.cambridge.arm.com>
In-Reply-To: <Y5yge52LQGp0uhIF@FVFF77S0Q05N.cambridge.arm.com>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Mon, 19 Dec 2022 11:53:52 +0530
Message-ID: <CAFA6WYN9qx4G=2hh_xcASU5MBoCDA8AHdmnyENmk6YSn88YFxA@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] arm64: entry: Skip single stepping into interrupt handlers
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     will@kernel.org, catalin.marinas@arm.com,
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

 On Fri, 16 Dec 2022 at 22:14, Mark Rutland <mark.rutland@arm.com> wrote:
>
> On Thu, Dec 15, 2022 at 07:59:02PM +0530, Sumit Garg wrote:
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
>
> FWIW, this looks reasonable to me; I have a couple of minor style/structure
> comments below.

Thanks Mark for your review.

>
> > ---
> >  arch/arm64/kernel/entry-common.c | 18 +++++++++++++++++-
> >  1 file changed, 17 insertions(+), 1 deletion(-)
> >
> > diff --git a/arch/arm64/kernel/entry-common.c b/arch/arm64/kernel/entry-common.c
> > index cce1167199e3..53bcb1902f2f 100644
> > --- a/arch/arm64/kernel/entry-common.c
> > +++ b/arch/arm64/kernel/entry-common.c
> > @@ -471,19 +471,35 @@ static __always_inline void __el1_irq(struct pt_regs *regs,
> >       do_interrupt_handler(regs, handler);
> >       irq_exit_rcu();
> >
> > -     arm64_preempt_schedule_irq();
> > +     /* Don't reschedule in case we are single stepping */
> > +     if (!(regs->pstate & DBG_SPSR_SS))
> > +             arm64_preempt_schedule_irq();
>
> Please change arm64_preempt_schedule_irq() to take the regs as an argument, and
> put this test inside arm64_preempt_schedule_irq(). That way all the
> decision-making about whether to preempt is in one place.
>
> That can go immediately after the need_irq_preemption() test.

Okay, I will change arm64_preempt_schedule_irq() accordingly.

>
> >
> >       exit_to_kernel_mode(regs);
> >  }
> > +
> >  static void noinstr el1_interrupt(struct pt_regs *regs,
> >                                 void (*handler)(struct pt_regs *))
> >  {
> > +     unsigned long reg;
>
> Please s/reg/mdscr/. That way it's harder to confuse with 'regs', it's clearer
> that it's the MDSCR_ELx value, and if we have to save/restore any other
> registers in future it'll be obvious how to name things.
>

Ack.

-Sumit

> Thanks,
> Mark.
>
> > +
> > +     /* Disable single stepping within interrupt handler */
> > +     if (regs->pstate & DBG_SPSR_SS) {
> > +             reg = read_sysreg(mdscr_el1);
> > +             write_sysreg(reg & ~DBG_MDSCR_SS, mdscr_el1);
> > +     }
> > +
> >       write_sysreg(DAIF_PROCCTX_NOIRQ, daif);
> >
> >       if (IS_ENABLED(CONFIG_ARM64_PSEUDO_NMI) && !interrupts_enabled(regs))
> >               __el1_pnmi(regs, handler);
> >       else
> >               __el1_irq(regs, handler);
> > +
> > +     if (regs->pstate & DBG_SPSR_SS) {
> > +             write_sysreg(DAIF_PROCCTX_NOIRQ | PSR_D_BIT, daif);
> > +             write_sysreg(reg, mdscr_el1);
> > +     }
> >  }
> >
> >  asmlinkage void noinstr el1h_64_irq_handler(struct pt_regs *regs)
> > --
> > 2.34.1
> >
