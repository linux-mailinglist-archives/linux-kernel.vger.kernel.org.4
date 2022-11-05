Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E68A361D928
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Nov 2022 10:38:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229546AbiKEJiR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Nov 2022 05:38:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbiKEJiP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Nov 2022 05:38:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FEB72F3B8
        for <linux-kernel@vger.kernel.org>; Sat,  5 Nov 2022 02:38:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D97FC60B0D
        for <linux-kernel@vger.kernel.org>; Sat,  5 Nov 2022 09:38:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1183CC433C1;
        Sat,  5 Nov 2022 09:38:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667641093;
        bh=yCWj+XA04ZTlVCdL88pc7Uvsh6vI6Qz0YyTu54vfw1A=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=anXi2ll6orx4ryxYKCwtZDuh6aIOK53d1KLpUIgnU97wD4fCGBOigJgNx1rQDfvyL
         K9KJKn7jfiTjyrIdlX8xuLgjiTFU7kUrW15p6wmWkB3nS18W7IK8WNQxjhpqm9t9Gc
         khNG1HePqtTKdrJqHWO/YtaX1Q+3GAiyPjlKJd9Xar7IJR11CXLL41KcX7YD+xPHmE
         nMw2+qc/n/3kqngoslnrRByN52XZKLVTWw6M/TToPuggeI9X9y0MtA1HS0RiFKoEQA
         rOo7WNyIEys512WiGCPh19XA52R0dZAIaHMgaUtEDNt8nVmMYEy3juR4kHsb/7wEAu
         Bu87s9M7jRXgQ==
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <maz@kernel.org>)
        id 1orFcw-0041AX-H9;
        Sat, 05 Nov 2022 09:38:10 +0000
MIME-Version: 1.0
Date:   Sat, 05 Nov 2022 09:38:10 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Anna-Maria Gleixner <anna-maria@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v4a 03/38] clocksource/drivers/arm_arch_timer: Do not use
 timer namespace for timer_shutdown() function
In-Reply-To: <20221105060155.409832154@goodmis.org>
References: <20221105060024.598488967@goodmis.org>
 <20221105060155.409832154@goodmis.org>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <a8cfb3a13d6a4a424edbbb8bf28b101c@kernel.org>
X-Sender: maz@kernel.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: rostedt@goodmis.org, linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, tglx@linutronix.de, sboyd@kernel.org, linux@roeck-us.net, anna-maria@linutronix.de, akpm@linux-foundation.org, mark.rutland@arm.com, daniel.lezcano@linaro.org, linux-arm-kernel@lists.infradead.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-11-05 06:00, Steven Rostedt wrote:
> From: "Steven Rostedt (Google)" <rostedt@goodmis.org>
> 
> A new "shutdown" timer state is being added to the generic timer code. 
> One
> of the functions to change the timer into the state is called
> "timer_shutdown()". This means that there can not be other functions
> called "timer_shutdown()" as the timer code owns the "timer_*" name 
> space.
> 
> Rename timer_shutdown() to clk_timer_shutdown() to avoid this conflict.
> 

bikeshed: s/clk_timer/arch_timer/ would make the naming consistent
with the rest of the code.

Thanks,

          M.

> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Marc Zyngier <maz@kernel.org>
> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: linux-arm-kernel@lists.infradead.org
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> ---
>  drivers/clocksource/arm_arch_timer.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/clocksource/arm_arch_timer.c
> b/drivers/clocksource/arm_arch_timer.c
> index a7ff77550e17..c36042d6a2f8 100644
> --- a/drivers/clocksource/arm_arch_timer.c
> +++ b/drivers/clocksource/arm_arch_timer.c
> @@ -687,8 +687,8 @@ static irqreturn_t arch_timer_handler_virt_mem(int
> irq, void *dev_id)
>  	return timer_handler(ARCH_TIMER_MEM_VIRT_ACCESS, evt);
>  }
> 
> -static __always_inline int timer_shutdown(const int access,
> -					  struct clock_event_device *clk)
> +static __always_inline int clk_timer_shutdown(const int access,
> +					      struct clock_event_device *clk)
>  {
>  	unsigned long ctrl;
> 
> @@ -701,22 +701,22 @@ static __always_inline int timer_shutdown(const
> int access,
> 
>  static int arch_timer_shutdown_virt(struct clock_event_device *clk)
>  {
> -	return timer_shutdown(ARCH_TIMER_VIRT_ACCESS, clk);
> +	return clk_timer_shutdown(ARCH_TIMER_VIRT_ACCESS, clk);
>  }
> 
>  static int arch_timer_shutdown_phys(struct clock_event_device *clk)
>  {
> -	return timer_shutdown(ARCH_TIMER_PHYS_ACCESS, clk);
> +	return clk_timer_shutdown(ARCH_TIMER_PHYS_ACCESS, clk);
>  }
> 
>  static int arch_timer_shutdown_virt_mem(struct clock_event_device 
> *clk)
>  {
> -	return timer_shutdown(ARCH_TIMER_MEM_VIRT_ACCESS, clk);
> +	return clk_timer_shutdown(ARCH_TIMER_MEM_VIRT_ACCESS, clk);
>  }
> 
>  static int arch_timer_shutdown_phys_mem(struct clock_event_device 
> *clk)
>  {
> -	return timer_shutdown(ARCH_TIMER_MEM_PHYS_ACCESS, clk);
> +	return clk_timer_shutdown(ARCH_TIMER_MEM_PHYS_ACCESS, clk);
>  }
> 
>  static __always_inline void set_next_event(const int access, unsigned 
> long evt,

-- 
Jazz is not dead. It just smells funny...
