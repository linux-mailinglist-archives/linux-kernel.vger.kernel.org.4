Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F01064EF9E
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 17:45:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229892AbiLPQpB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 11:45:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231372AbiLPQow (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 11:44:52 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0B944FA
        for <linux-kernel@vger.kernel.org>; Fri, 16 Dec 2022 08:44:50 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 374341042;
        Fri, 16 Dec 2022 08:45:31 -0800 (PST)
Received: from FVFF77S0Q05N.cambridge.arm.com (FVFF77S0Q05N.cambridge.arm.com [10.1.27.147])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1F8F83F5A1;
        Fri, 16 Dec 2022 08:44:49 -0800 (PST)
Date:   Fri, 16 Dec 2022 16:44:43 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Sumit Garg <sumit.garg@linaro.org>
Cc:     will@kernel.org, catalin.marinas@arm.com,
        daniel.thompson@linaro.org, dianders@chromium.org,
        liwei391@huawei.com, mhiramat@kernel.org, maz@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/2] arm64: entry: Skip single stepping into interrupt
 handlers
Message-ID: <Y5yge52LQGp0uhIF@FVFF77S0Q05N.cambridge.arm.com>
References: <20221215142903.2624142-1-sumit.garg@linaro.org>
 <20221215142903.2624142-2-sumit.garg@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221215142903.2624142-2-sumit.garg@linaro.org>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 15, 2022 at 07:59:02PM +0530, Sumit Garg wrote:
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

FWIW, this looks reasonable to me; I have a couple of minor style/structure
comments below.

> ---
>  arch/arm64/kernel/entry-common.c | 18 +++++++++++++++++-
>  1 file changed, 17 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/kernel/entry-common.c b/arch/arm64/kernel/entry-common.c
> index cce1167199e3..53bcb1902f2f 100644
> --- a/arch/arm64/kernel/entry-common.c
> +++ b/arch/arm64/kernel/entry-common.c
> @@ -471,19 +471,35 @@ static __always_inline void __el1_irq(struct pt_regs *regs,
>  	do_interrupt_handler(regs, handler);
>  	irq_exit_rcu();
>  
> -	arm64_preempt_schedule_irq();
> +	/* Don't reschedule in case we are single stepping */
> +	if (!(regs->pstate & DBG_SPSR_SS))
> +		arm64_preempt_schedule_irq();

Please change arm64_preempt_schedule_irq() to take the regs as an argument, and
put this test inside arm64_preempt_schedule_irq(). That way all the
decision-making about whether to preempt is in one place.

That can go immediately after the need_irq_preemption() test.

>  
>  	exit_to_kernel_mode(regs);
>  }
> +
>  static void noinstr el1_interrupt(struct pt_regs *regs,
>  				  void (*handler)(struct pt_regs *))
>  {
> +	unsigned long reg;

Please s/reg/mdscr/. That way it's harder to confuse with 'regs', it's clearer
that it's the MDSCR_ELx value, and if we have to save/restore any other
registers in future it'll be obvious how to name things.

Thanks,
Mark.

> +
> +	/* Disable single stepping within interrupt handler */
> +	if (regs->pstate & DBG_SPSR_SS) {
> +		reg = read_sysreg(mdscr_el1);
> +		write_sysreg(reg & ~DBG_MDSCR_SS, mdscr_el1);
> +	}
> +
>  	write_sysreg(DAIF_PROCCTX_NOIRQ, daif);
>  
>  	if (IS_ENABLED(CONFIG_ARM64_PSEUDO_NMI) && !interrupts_enabled(regs))
>  		__el1_pnmi(regs, handler);
>  	else
>  		__el1_irq(regs, handler);
> +
> +	if (regs->pstate & DBG_SPSR_SS) {
> +		write_sysreg(DAIF_PROCCTX_NOIRQ | PSR_D_BIT, daif);
> +		write_sysreg(reg, mdscr_el1);
> +	}
>  }
>  
>  asmlinkage void noinstr el1h_64_irq_handler(struct pt_regs *regs)
> -- 
> 2.34.1
> 
