Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F89667E327
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 12:24:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233158AbjA0LYR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 06:24:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233098AbjA0LXw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 06:23:52 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 932A580001
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 03:22:33 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 11AC761B13
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 11:21:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72BD4C433EF
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 11:21:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674818474;
        bh=IdGJPyMFJkFVpbYJF/C1epgqzdq7ZIE0YLqvF9vfNb8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Gb597iy3pRfpAh7GFIt9C7CZFVZboNxr+ZE1bESbOsbIYbHMAFdNxsuAiinUGpanr
         QoZjgxJmwn0p8+/e/WlrvX6teC34Yn9vwOd83dveP6VOsBtmIb+cMUeJurqKjRjTl1
         vouKYvS+AOSuVB7ObhpThStJrmLVfIw9KHh6SdxllEfr/A/KUCDy8xdUYfkLCkWElA
         MDumIhI2RUMqZ8AS9L1HJ+jAC3DPbkpAVfWIoAfcX+F4lKXj2QVLrwZ4woBXt2ucKC
         oO9RhCb2FPiHbfOvZ3tczItvBjqVC42K175QDqTYtxpW8xWmqXl4DWXbKorjX8pNzh
         0TGBm1nqyJ4qg==
Received: by mail-lf1-f43.google.com with SMTP id a11so7733588lfg.0
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 03:21:14 -0800 (PST)
X-Gm-Message-State: AFqh2kpBLJLETGQ3SdKDtBQ8eH/u7MadYKYlwaDdmfnzuTr9u4X20NOP
        dRI4tb7I4Q6k6OH7stdoe5P5WilhKRIDeSJPkwI=
X-Google-Smtp-Source: AMrXdXui12sWIOEWieyBaJG+vlw8+vrFVXxrVp9x7HOdS8usuOcqyiK0Hg3Uj7khYyzXZuQZ0AK6flgWIp6xQJ7vFME=
X-Received: by 2002:a19:8c19:0:b0:4ca:f3c2:2670 with SMTP id
 o25-20020a198c19000000b004caf3c22670mr3655665lfd.166.1674818472450; Fri, 27
 Jan 2023 03:21:12 -0800 (PST)
MIME-Version: 1.0
References: <20221219102452.2860088-1-sumit.garg@linaro.org>
 <20221219102452.2860088-2-sumit.garg@linaro.org> <20230126133929.GC29148@willie-the-truck>
In-Reply-To: <20230126133929.GC29148@willie-the-truck>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Fri, 27 Jan 2023 12:21:00 +0100
X-Gmail-Original-Message-ID: <CAMj1kXEx_5oESx9eEOPh6ZzHT8=fZcpfz6ps7ZZ8ADFAJvEvjQ@mail.gmail.com>
Message-ID: <CAMj1kXEx_5oESx9eEOPh6ZzHT8=fZcpfz6ps7ZZ8ADFAJvEvjQ@mail.gmail.com>
Subject: Re: [PATCH v5 1/2] arm64: entry: Skip single stepping into interrupt handlers
To:     Will Deacon <will@kernel.org>
Cc:     Sumit Garg <sumit.garg@linaro.org>, catalin.marinas@arm.com,
        mark.rutland@arm.com, daniel.thompson@linaro.org,
        dianders@chromium.org, liwei391@huawei.com, mhiramat@kernel.org,
        maz@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 26 Jan 2023 at 14:40, Will Deacon <will@kernel.org> wrote:
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
> Sadly, I think any attempts to workaround the issues here are likely just
> to push the problems around. We really need to overhaul the debug exception
> handling logic we have, which means I need to get back to writing up a
> proposal.
>

That would be much appreciated.

This patch makes single step debugging of VMs running under QEMU much
more useful (using QEMU gdbstub), for the same reason as with kdb, as
otherwise, there's a 50/50 chance (in my experience) that doing a
single step will take you the IRQ handler instead of to the next
instruction in program order.

FWIW, I tested this patch with that scenario, and it seems to work
much better, but not 100%: I still end up in the IRQ handler
occasionally, but considerably less often.
