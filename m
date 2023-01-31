Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 272E46832EA
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 17:41:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230249AbjAaQlq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 11:41:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231454AbjAaQlk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 11:41:40 -0500
Received: from relay10.mail.gandi.net (relay10.mail.gandi.net [217.70.178.230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FCDE561A2
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 08:41:38 -0800 (PST)
Received: (Authenticated sender: gregory.clement@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 147CD240009;
        Tue, 31 Jan 2023 16:41:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1675183295;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=euDzKHP9/mtuK4Sv6gmdi0F88PCk07Xbz8L5E8Kz3kU=;
        b=gUXjnRAfNZaRf5ey5PfkDn+Il1s9laCJdGtd3dJY8iyRrhbHBL7xnQi+HPbe+0k4vkNH+d
        VXdqGOM3r8kDYflvrHO3/DE5mkYOwpPWvFSy2ovyKmSYw/jyJxZItR6bSCNB0Vq30wWDRv
        Ge0QmukmalggjGepa3NnnbPUaOqdoCfEy7rwL0EwWbl+RF1bS7eZv7qVBVEgvlgrqapsDa
        UUKAwJBuKYyJkMPwOSmpdgP4MRBAg2YLYpbudijNuA9IG+imy8vUlBT5FxRN6xge7K4rEW
        +hCYiGNar5YZX10UTzO1vTn3EXn2sVF2mC/nPVidXPpKt2K7wgPbIgB1KunC4Q==
From:   Gregory CLEMENT <gregory.clement@bootlin.com>
To:     Arnd Bergmann <arnd@kernel.org>,
        Russell King <linux@armlinux.org.uk>
Cc:     Marc Zyngier <maz@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Andrew Lunn <andrew@lunn.ch>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: irq: remove handle_IRQ() for good
In-Reply-To: <20230117174117.3314951-1-arnd@kernel.org>
References: <20230117174117.3314951-1-arnd@kernel.org>
Date:   Tue, 31 Jan 2023 17:41:33 +0100
Message-ID: <87k012bqrm.fsf@BL-laptop>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Arnd Bergmann <arnd@kernel.org> writes:

> From: Arnd Bergmann <arnd@arndb.de>
>
> The only difference between generic_handle_irq() and the ARM
> handle_IRQ() version is now the range check, and in the remaining
> drivers this does not appear to be needed any more.
>
> Remove this old interface and use the generic version in its place.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  arch/arm/include/asm/irq.h  |  4 ----
>  arch/arm/kernel/irq.c       | 25 -------------------------
>  arch/arm/mach-dove/irq.c    |  6 ++----
>  arch/arm/mach-mv78xx0/irq.c |  9 +++------
>  arch/arm/mach-orion5x/irq.c |  3 +--
>  arch/arm/mach-pxa/irq.c     |  4 ++--

For mvebu related platform

Acked-by: Gregory CLEMENT <gregory.clement@bootlin.com>

Thanks,

Gregory


>  6 files changed, 8 insertions(+), 43 deletions(-)
>
> diff --git a/arch/arm/include/asm/irq.h b/arch/arm/include/asm/irq.h
> index a7c2337b0c7d..f62fa9f36192 100644
> --- a/arch/arm/include/asm/irq.h
> +++ b/arch/arm/include/asm/irq.h
> @@ -23,10 +23,6 @@
>  #endif
>  
>  #ifndef __ASSEMBLY__
> -struct irqaction;
> -struct pt_regs;
> -
> -void handle_IRQ(unsigned int, struct pt_regs *);
>  void init_IRQ(void);
>  
>  #ifdef CONFIG_SMP
> diff --git a/arch/arm/kernel/irq.c b/arch/arm/kernel/irq.c
> index fe28fc1f759d..e0983269729f 100644
> --- a/arch/arm/kernel/irq.c
> +++ b/arch/arm/kernel/irq.c
> @@ -96,31 +96,6 @@ int arch_show_interrupts(struct seq_file *p, int prec)
>  	return 0;
>  }
>  
> -/*
> - * handle_IRQ handles all hardware IRQ's.  Decoded IRQs should
> - * not come via this function.  Instead, they should provide their
> - * own 'handler'.  Used by platform code implementing C-based 1st
> - * level decoding.
> - */
> -void handle_IRQ(unsigned int irq, struct pt_regs *regs)
> -{
> -	struct irq_desc *desc;
> -
> -	/*
> -	 * Some hardware gives randomly wrong interrupts.  Rather
> -	 * than crashing, do something sensible.
> -	 */
> -	if (unlikely(!irq || irq >= nr_irqs))
> -		desc = NULL;
> -	else
> -		desc = irq_to_desc(irq);
> -
> -	if (likely(desc))
> -		handle_irq_desc(desc);
> -	else
> -		ack_bad_irq(irq);
> -}
> -
>  void __init init_IRQ(void)
>  {
>  	int ret;
> diff --git a/arch/arm/mach-dove/irq.c b/arch/arm/mach-dove/irq.c
> index 027a8f87bc2e..500f097e09b3 100644
> --- a/arch/arm/mach-dove/irq.c
> +++ b/arch/arm/mach-dove/irq.c
> @@ -47,15 +47,13 @@ __exception_irq_entry dove_legacy_handle_irq(struct pt_regs *regs)
>  	stat = readl_relaxed(dove_irq_base + IRQ_CAUSE_LOW_OFF);
>  	stat &= readl_relaxed(dove_irq_base + IRQ_MASK_LOW_OFF);
>  	if (stat) {
> -		unsigned int hwirq = 1 + __fls(stat);
> -		handle_IRQ(hwirq, regs);
> +		generic_handle_irq(1 + __fls(stat));
>  		return;
>  	}
>  	stat = readl_relaxed(dove_irq_base + IRQ_CAUSE_HIGH_OFF);
>  	stat &= readl_relaxed(dove_irq_base + IRQ_MASK_HIGH_OFF);
>  	if (stat) {
> -		unsigned int hwirq = 33 + __fls(stat);
> -		handle_IRQ(hwirq, regs);
> +		generic_handle_irq(33 + __fls(stat));
>  		return;
>  	}
>  }
> diff --git a/arch/arm/mach-mv78xx0/irq.c b/arch/arm/mach-mv78xx0/irq.c
> index a34b6855fb19..6114ccbcdab2 100644
> --- a/arch/arm/mach-mv78xx0/irq.c
> +++ b/arch/arm/mach-mv78xx0/irq.c
> @@ -31,22 +31,19 @@ __exception_irq_entry mv78xx0_legacy_handle_irq(struct pt_regs *regs)
>  	stat = readl_relaxed(mv78xx0_irq_base + IRQ_CAUSE_LOW_OFF);
>  	stat &= readl_relaxed(mv78xx0_irq_base + IRQ_MASK_LOW_OFF);
>  	if (stat) {
> -		unsigned int hwirq = __fls(stat);
> -		handle_IRQ(hwirq, regs);
> +		generic_handle_irq(__fls(stat));
>  		return;
>  	}
>  	stat = readl_relaxed(mv78xx0_irq_base + IRQ_CAUSE_HIGH_OFF);
>  	stat &= readl_relaxed(mv78xx0_irq_base + IRQ_MASK_HIGH_OFF);
>  	if (stat) {
> -		unsigned int hwirq = 32 + __fls(stat);
> -		handle_IRQ(hwirq, regs);
> +		generic_handle_irq(32 + __fls(stat));
>  		return;
>  	}
>  	stat = readl_relaxed(mv78xx0_irq_base + IRQ_CAUSE_ERR_OFF);
>  	stat &= readl_relaxed(mv78xx0_irq_base + IRQ_MASK_ERR_OFF);
>  	if (stat) {
> -		unsigned int hwirq = 64 + __fls(stat);
> -		handle_IRQ(hwirq, regs);
> +		generic_handle_irq(64 + __fls(stat));
>  		return;
>  	}
>  }
> diff --git a/arch/arm/mach-orion5x/irq.c b/arch/arm/mach-orion5x/irq.c
> index e17727e53cb4..41d08934a918 100644
> --- a/arch/arm/mach-orion5x/irq.c
> +++ b/arch/arm/mach-orion5x/irq.c
> @@ -31,8 +31,7 @@ __exception_irq_entry orion5x_legacy_handle_irq(struct pt_regs *regs)
>  	stat = readl_relaxed(MAIN_IRQ_CAUSE);
>  	stat &= readl_relaxed(MAIN_IRQ_MASK);
>  	if (stat) {
> -		unsigned int hwirq = 1 + __fls(stat);
> -		handle_IRQ(hwirq, regs);
> +		generic_handle_irq(1 + __fls(stat));
>  		return;
>  	}
>  }
> diff --git a/arch/arm/mach-pxa/irq.c b/arch/arm/mach-pxa/irq.c
> index 96f33ef1d9ea..1fe551b60eed 100644
> --- a/arch/arm/mach-pxa/irq.c
> +++ b/arch/arm/mach-pxa/irq.c
> @@ -101,7 +101,7 @@ asmlinkage void __exception_irq_entry icip_handle_irq(struct pt_regs *regs)
>  		if (mask == 0)
>  			break;
>  
> -		handle_IRQ(PXA_IRQ(fls(mask) - 1), regs);
> +		generic_handle_irq(PXA_IRQ(fls(mask) - 1));
>  	} while (1);
>  }
>  
> @@ -115,7 +115,7 @@ asmlinkage void __exception_irq_entry ichp_handle_irq(struct pt_regs *regs)
>  		if ((ichp & ICHP_VAL_IRQ) == 0)
>  			break;
>  
> -		handle_IRQ(PXA_IRQ(ICHP_IRQ(ichp)), regs);
> +		generic_handle_irq(PXA_IRQ(ICHP_IRQ(ichp)));
>  	} while (1);
>  }
>  
> -- 
> 2.39.0
>

-- 
Gregory Clement, Bootlin
Embedded Linux and Kernel engineering
http://bootlin.com
