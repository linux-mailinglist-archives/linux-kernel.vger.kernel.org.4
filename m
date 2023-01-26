Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0144C67CC63
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 14:39:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237133AbjAZNj5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 08:39:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236377AbjAZNjk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 08:39:40 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0E51442FF
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 05:39:38 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5CD31B81DBB
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 13:39:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F00CC4339C;
        Thu, 26 Jan 2023 13:39:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674740376;
        bh=JubJEGHP7L4BLz+Yv107k+IilgVcrBBFP6L7DrL83Qw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hfeuHN+xYiDzBOd1yd65YRHWnHAlwdILwlugc9bJFSxFmDausavMiu5CGyHWc8aub
         HWgASUXP3tnSVApnsLCjJ8LskitebU1QB+3W2PbZPbi7Yle/BZ/fgU+k+rddLAk9vT
         E6spsE/p2l4HrRbEhn3damJrxHQne/o0wbAMCK8GsyuOBr/Rh3z4+AkPTOmWDrVuv5
         emffqnkhgty65XVwGrdS5sfHl9U4IIvAPcBs1HFr2KmSimoOSbbyHCi9nZU3nG+8cD
         L5InkY4tXsu/QaKG/iP7Caxphgn137B6tEdHWefzBK6z0LrPIrWoJ/PM7LlLAa2hmS
         CtnJtcIIWTsPQ==
Date:   Thu, 26 Jan 2023 13:39:30 +0000
From:   Will Deacon <will@kernel.org>
To:     Sumit Garg <sumit.garg@linaro.org>
Cc:     catalin.marinas@arm.com, mark.rutland@arm.com,
        daniel.thompson@linaro.org, dianders@chromium.org,
        liwei391@huawei.com, mhiramat@kernel.org, maz@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 1/2] arm64: entry: Skip single stepping into interrupt
 handlers
Message-ID: <20230126133929.GC29148@willie-the-truck>
References: <20221219102452.2860088-1-sumit.garg@linaro.org>
 <20221219102452.2860088-2-sumit.garg@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221219102452.2860088-2-sumit.garg@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 19, 2022 at 03:54:51PM +0530, Sumit Garg wrote:
> Currently on systems where the timer interrupt (or any other
> fast-at-human-scale periodic interrupt) is active then it is impossible
> to step any code with interrupts unlocked because we will always end up
> stepping into the timer interrupt instead of stepping the user code.
> 
> The common user's goal while single stepping is that when they step then
> the system will stop at PC+4 or PC+I for a branch that gets taken
> relative to the instruction they are stepping. So, fix broken single step
> implementation via skipping single stepping into interrupt handlers.
> 
> The methodology is when we receive an interrupt from EL1, check if we
> are single stepping (pstate.SS). If yes then we save MDSCR_EL1.SS and
> clear the register bit if it was set. Then unmask only D and leave I set.
> On return from the interrupt, set D and restore MDSCR_EL1.SS. Along with
> this skip reschedule if we were stepping.
> 
> Suggested-by: Will Deacon <will@kernel.org>
> Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> Tested-by: Douglas Anderson <dianders@chromium.org>
> ---
>  arch/arm64/kernel/entry-common.c | 22 ++++++++++++++++++++--
>  1 file changed, 20 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/kernel/entry-common.c b/arch/arm64/kernel/entry-common.c
> index cce1167199e3..688d1ef8e864 100644
> --- a/arch/arm64/kernel/entry-common.c
> +++ b/arch/arm64/kernel/entry-common.c
> @@ -231,11 +231,15 @@ DEFINE_STATIC_KEY_TRUE(sk_dynamic_irqentry_exit_cond_resched);
>  #define need_irq_preemption()	(IS_ENABLED(CONFIG_PREEMPTION))
>  #endif
>  
> -static void __sched arm64_preempt_schedule_irq(void)
> +static void __sched arm64_preempt_schedule_irq(struct pt_regs *regs)
>  {
>  	if (!need_irq_preemption())
>  		return;
>  
> +	/* Don't reschedule in case we are single stepping */
> +	if (!(regs->pstate & DBG_SPSR_SS))
> +		return;

Hmm, isn't this the common case? PSTATE.SS will usually be clear, no?

>  	 * Note: thread_info::preempt_count includes both thread_info::count
>  	 * and thread_info::need_resched, and is not equivalent to
> @@ -471,19 +475,33 @@ static __always_inline void __el1_irq(struct pt_regs *regs,
>  	do_interrupt_handler(regs, handler);
>  	irq_exit_rcu();
>  
> -	arm64_preempt_schedule_irq();
> +	arm64_preempt_schedule_irq(regs);
>  
>  	exit_to_kernel_mode(regs);
>  }
> +
>  static void noinstr el1_interrupt(struct pt_regs *regs,
>  				  void (*handler)(struct pt_regs *))
>  {
> +	unsigned long mdscr;
> +
> +	/* Disable single stepping within interrupt handler */
> +	if (regs->pstate & DBG_SPSR_SS) {
> +		mdscr = read_sysreg(mdscr_el1);
> +		write_sysreg(mdscr & ~DBG_MDSCR_SS, mdscr_el1);
> +	}

I think this will break the implicit handling of kernel {break,watch}points.

Sadly, I think any attempts to workaround the issues here are likely just
to push the problems around. We really need to overhaul the debug exception
handling logic we have, which means I need to get back to writing up a
proposal.

Will
