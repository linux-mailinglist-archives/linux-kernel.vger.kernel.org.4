Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E280161F163
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 12:03:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231145AbiKGLDh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 06:03:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229929AbiKGLDf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 06:03:35 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 25104BE30
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 03:03:34 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0CB501FB;
        Mon,  7 Nov 2022 03:03:40 -0800 (PST)
Received: from FVFF77S0Q05N (unknown [10.57.69.132])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 21D9A3F73D;
        Mon,  7 Nov 2022 03:03:32 -0800 (PST)
Date:   Mon, 7 Nov 2022 11:03:29 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Anna-Maria Gleixner <anna-maria@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Marc Zyngier <maz@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v5a 2/5] clocksource/drivers/arm_arch_timer: Do not use
 timer namespace for timer_shutdown() function
Message-ID: <Y2jmAWxLjaCMQx/O@FVFF77S0Q05N>
References: <20221106054535.709068702@goodmis.org>
 <20221106054648.549609750@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221106054648.549609750@goodmis.org>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 06, 2022 at 01:45:37AM -0400, Steven Rostedt wrote:
> From: "Steven Rostedt (Google)" <rostedt@goodmis.org>
> 
> A new "shutdown" timer state is being added to the generic timer code. One
> of the functions to change the timer into the state is called
> "timer_shutdown()". This means that there can not be other functions
> called "timer_shutdown()" as the timer code owns the "timer_*" name space.
> 
> Rename timer_shutdown() to arch_timer_shutdown() to avoid this conflict.
> 
> Link: https://lore.kernel.org/all/20221105060155.409832154@goodmis.org/
> 
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Marc Zyngier <maz@kernel.org>
> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: linux-arm-kernel@lists.infradead.org
> Reviewed-by: Guenter Roeck <linux@roeck-us.net>
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>

Acked-by: Mark Rutland <mark.rutland@arm.com>

Mark.

> ---
>  drivers/clocksource/arm_arch_timer.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
> index a7ff77550e17..9c3420a0d19d 100644
> --- a/drivers/clocksource/arm_arch_timer.c
> +++ b/drivers/clocksource/arm_arch_timer.c
> @@ -687,8 +687,8 @@ static irqreturn_t arch_timer_handler_virt_mem(int irq, void *dev_id)
>  	return timer_handler(ARCH_TIMER_MEM_VIRT_ACCESS, evt);
>  }
>  
> -static __always_inline int timer_shutdown(const int access,
> -					  struct clock_event_device *clk)
> +static __always_inline int arch_timer_shutdown(const int access,
> +					       struct clock_event_device *clk)
>  {
>  	unsigned long ctrl;
>  
> @@ -701,22 +701,22 @@ static __always_inline int timer_shutdown(const int access,
>  
>  static int arch_timer_shutdown_virt(struct clock_event_device *clk)
>  {
> -	return timer_shutdown(ARCH_TIMER_VIRT_ACCESS, clk);
> +	return arch_timer_shutdown(ARCH_TIMER_VIRT_ACCESS, clk);
>  }
>  
>  static int arch_timer_shutdown_phys(struct clock_event_device *clk)
>  {
> -	return timer_shutdown(ARCH_TIMER_PHYS_ACCESS, clk);
> +	return arch_timer_shutdown(ARCH_TIMER_PHYS_ACCESS, clk);
>  }
>  
>  static int arch_timer_shutdown_virt_mem(struct clock_event_device *clk)
>  {
> -	return timer_shutdown(ARCH_TIMER_MEM_VIRT_ACCESS, clk);
> +	return arch_timer_shutdown(ARCH_TIMER_MEM_VIRT_ACCESS, clk);
>  }
>  
>  static int arch_timer_shutdown_phys_mem(struct clock_event_device *clk)
>  {
> -	return timer_shutdown(ARCH_TIMER_MEM_PHYS_ACCESS, clk);
> +	return arch_timer_shutdown(ARCH_TIMER_MEM_PHYS_ACCESS, clk);
>  }
>  
>  static __always_inline void set_next_event(const int access, unsigned long evt,
> -- 
> 2.35.1
