Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8827161DAC1
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Nov 2022 15:07:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229745AbiKEOHT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Nov 2022 10:07:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229713AbiKEOHR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Nov 2022 10:07:17 -0400
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2930C20F52
        for <linux-kernel@vger.kernel.org>; Sat,  5 Nov 2022 07:07:17 -0700 (PDT)
Received: by mail-oi1-x22d.google.com with SMTP id r76so7899420oie.13
        for <linux-kernel@vger.kernel.org>; Sat, 05 Nov 2022 07:07:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QBL3RU6Tyc1K9O7fYJMpWmMKy6h7ktSFbU1hgrOg5lI=;
        b=cjcS1O/Qh+gd/6Xzs/PzFy1+5nBlTqq/d1HaED/mRNtq682n8E5wKJx+YmNyWXF28g
         RMQCq1wf10ml2PZGy+yWDwCOSUZxgbrsBquJwiRyE+esA5HSLFicrhIvWj5KZkwrs9sf
         3uYDNBKjaCdZ18cq4HZ8eik4dqYy99ZXla63zmhWw3Sdk9lFAzcXsXeB7trPMpdxmUPs
         v8WrSjBg8YteAarRxXO++c4nQyWVKYLN4yAoW5vbV8/TaZruJbWHNv2KWKZ4b2Ir7h+I
         zinnacfgclxjT0REk3iBWqc3r5JrEEpoINVlTSA4zW5dYFrfo8oP7HJyqfC7PHEGChOC
         HMMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QBL3RU6Tyc1K9O7fYJMpWmMKy6h7ktSFbU1hgrOg5lI=;
        b=lTVQsyUhA6QKmYZZBm+HbuyEUi3vbAOP/Ruo975/k7R/rpdYgejpQAm2Y5ykaxFBjz
         X9cJhzXpX10+Kkrj5bl0YeNutQMcFNWURhuYZ0w0fZ1Hz3o4E+Mawt2B2eEjilQzbuJq
         /lcBWaS098MPnspBI8FIcPtb1g9KKCDv54Ree0noaXp2cdG+Yp/CgpZEwDXE1EAjndH2
         IsgLmkVWFpGsute0vp9J8oVEnhz/vTXnQrnnyehT/AUjM88C4ERaxZ91BxXMKvVI3HoS
         4oDHehn0VSuzTZH0AeO7cQfGutDhs9F0K21nH53FmX3yltioHVr57BPDW8k4siRETVcs
         KVwg==
X-Gm-Message-State: ACrzQf2N3nzqImJ9x+guThF5EpuhVOm1QNImv91pTokukMxInJj/cuP+
        3BC9LOjqWtDqz7ri/5+sPak=
X-Google-Smtp-Source: AMsMyM6Hmuotf1LGV7tNOGQBXu+QV36l8QwYJOb8BeDypnRVVWloN/B6CE7v9FihqXwJN8aOxgIOzQ==
X-Received: by 2002:a05:6808:1817:b0:359:d97b:561 with SMTP id bh23-20020a056808181700b00359d97b0561mr22306718oib.10.1667657236502;
        Sat, 05 Nov 2022 07:07:16 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id er33-20020a056870c8a100b00131c3d4d38fsm833197oab.39.2022.11.05.07.07.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Nov 2022 07:07:14 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Sat, 5 Nov 2022 07:07:13 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        Anna-Maria Gleixner <anna-maria@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v4a 03/38] clocksource/drivers/arm_arch_timer: Do not use
 timer namespace for timer_shutdown() function
Message-ID: <20221105140713.GE1606271@roeck-us.net>
References: <20221105060024.598488967@goodmis.org>
 <20221105060155.409832154@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221105060155.409832154@goodmis.org>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 05, 2022 at 02:00:27AM -0400, Steven Rostedt wrote:
> From: "Steven Rostedt (Google)" <rostedt@goodmis.org>
> 
> A new "shutdown" timer state is being added to the generic timer code. One
> of the functions to change the timer into the state is called
> "timer_shutdown()". This means that there can not be other functions
> called "timer_shutdown()" as the timer code owns the "timer_*" name space.
> 
> Rename timer_shutdown() to clk_timer_shutdown() to avoid this conflict.
> 
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Marc Zyngier <maz@kernel.org>
> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: linux-arm-kernel@lists.infradead.org
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>

Same nitpick as Marc (arch_timer_shutdown), but this is POV, so

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  drivers/clocksource/arm_arch_timer.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
> index a7ff77550e17..c36042d6a2f8 100644
> --- a/drivers/clocksource/arm_arch_timer.c
> +++ b/drivers/clocksource/arm_arch_timer.c
> @@ -687,8 +687,8 @@ static irqreturn_t arch_timer_handler_virt_mem(int irq, void *dev_id)
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
> @@ -701,22 +701,22 @@ static __always_inline int timer_shutdown(const int access,
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
>  static int arch_timer_shutdown_virt_mem(struct clock_event_device *clk)
>  {
> -	return timer_shutdown(ARCH_TIMER_MEM_VIRT_ACCESS, clk);
> +	return clk_timer_shutdown(ARCH_TIMER_MEM_VIRT_ACCESS, clk);
>  }
>  
>  static int arch_timer_shutdown_phys_mem(struct clock_event_device *clk)
>  {
> -	return timer_shutdown(ARCH_TIMER_MEM_PHYS_ACCESS, clk);
> +	return clk_timer_shutdown(ARCH_TIMER_MEM_PHYS_ACCESS, clk);
>  }
>  
>  static __always_inline void set_next_event(const int access, unsigned long evt,
> -- 
> 2.35.1
