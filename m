Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E809561DAC0
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Nov 2022 15:06:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229729AbiKEOGZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Nov 2022 10:06:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229713AbiKEOGW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Nov 2022 10:06:22 -0400
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4F1120F6A
        for <linux-kernel@vger.kernel.org>; Sat,  5 Nov 2022 07:06:21 -0700 (PDT)
Received: by mail-ot1-x332.google.com with SMTP id cb2-20020a056830618200b00661b6e5dcd8so4155051otb.8
        for <linux-kernel@vger.kernel.org>; Sat, 05 Nov 2022 07:06:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=a/eLeVdFoBRXyHx+UXazVi2XkiPmBusVXLRJ123Rj50=;
        b=j//uH3pNKiW9xnqa+o7TANKNa27VvswBNw6KSpiphVZrDvrPLq+NCTJLb24z9Ilm2y
         nM03QGujj4ZBcmYwKogBIDugbSgKy202txsin9BjUtlnqC93eqaFWLB8jNFML0ubuA1h
         f1vtM3ZJN08vgq7SOJLIMPEelo41HTNs7FX2faEuiX5iw8S7XOK4ksbAdxqk5iFnMfBb
         ZHqFtqMBIYh5X6o/mjBCqXSVTsTKE3xD/L4FA0TKcamkL65W1Xi09SDyZH/xjEphACgR
         dkqQ86EcvEuaHSMhMdNevy+g0jnEykehQCfI02XG0FbJ0AzJLxRIbb4wWuLgGwu4u76k
         BRpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a/eLeVdFoBRXyHx+UXazVi2XkiPmBusVXLRJ123Rj50=;
        b=0B8Lv3KpNRklcUiNLd6iZ4DFR0hzR2PBGWtQqJSxhnoJiJfM0zolqMvx23sS7IEIpB
         sLcojJ14PH9JJLgw8gWqJPhw5OHJid0RgBztJSQ3itBjyUEhPLZDPBNv3MZvcrYnQz3e
         vtG+3PuNZCiu+NA6Ze3YKcINsoBciPPoJlBFcOAD0DbRbp7i15db/PzPWWRfF2fuyzD1
         F57iaPZQ0gkURIgs57xhgDcaIg8HZyUnu/prheFa2QQChkgvMCwhCIb+qg+ryzAJFH+y
         ML1YlaSyRdP+aKcxkREBS005dNMdAgT37O4qIs0aMhbn9C7Qg/bRz1VAaU6LtcnwADpU
         T5ew==
X-Gm-Message-State: ACrzQf0NPmRqcJdgpCUgdTvKcWIpBT/tzv/aTHYLuewJh+cG92iU8luQ
        rkAx3U3Y7/p/oX3JNC4welKBvcsDyUo=
X-Google-Smtp-Source: AMsMyM4zu7qAigq9TwUHjuXHbuLKDhUtqwe2p8MU+l1bTBhanZ2sY+X3LCRG5K6suJXurAPYzbjrdw==
X-Received: by 2002:a05:6830:1012:b0:66c:6237:e6e4 with SMTP id a18-20020a056830101200b0066c6237e6e4mr13829296otp.72.1667657181009;
        Sat, 05 Nov 2022 07:06:21 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id n82-20020aca4055000000b003546fada8f6sm727326oia.12.2022.11.05.07.06.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Nov 2022 07:06:19 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Sat, 5 Nov 2022 07:06:18 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        Anna-Maria Gleixner <anna-maria@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH v4a 04/38] clocksource/drivers/sp804: Do not use timer
 namespace for timer_shutdown() function
Message-ID: <20221105140618.GD1606271@roeck-us.net>
References: <20221105060024.598488967@goodmis.org>
 <20221105060155.592778858@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221105060155.592778858@goodmis.org>
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

On Sat, Nov 05, 2022 at 02:00:28AM -0400, Steven Rostedt wrote:
> From: "Steven Rostedt (Google)" <rostedt@goodmis.org>
> 
> A new "shutdown" timer state is being added to the generic timer code. One
> of the functions to change the timer into the state is called
> "timer_shutdown()". This means that there can not be other functions
> called "timer_shutdown()" as the timer code owns the "timer_*" name space.
> 
> Rename timer_shutdown() to evt_timer_shutdown() to avoid this conflict.
> 
> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  drivers/clocksource/timer-sp804.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/clocksource/timer-sp804.c b/drivers/clocksource/timer-sp804.c
> index e6a87f4af2b5..cd1916c05325 100644
> --- a/drivers/clocksource/timer-sp804.c
> +++ b/drivers/clocksource/timer-sp804.c
> @@ -155,14 +155,14 @@ static irqreturn_t sp804_timer_interrupt(int irq, void *dev_id)
>  	return IRQ_HANDLED;
>  }
>  
> -static inline void timer_shutdown(struct clock_event_device *evt)
> +static inline void evt_timer_shutdown(struct clock_event_device *evt)
>  {
>  	writel(0, common_clkevt->ctrl);
>  }
>  
>  static int sp804_shutdown(struct clock_event_device *evt)
>  {
> -	timer_shutdown(evt);
> +	evt_timer_shutdown(evt);
>  	return 0;
>  }
>  
> @@ -171,7 +171,7 @@ static int sp804_set_periodic(struct clock_event_device *evt)
>  	unsigned long ctrl = TIMER_CTRL_32BIT | TIMER_CTRL_IE |
>  			     TIMER_CTRL_PERIODIC | TIMER_CTRL_ENABLE;
>  
> -	timer_shutdown(evt);
> +	evt_timer_shutdown(evt);
>  	writel(common_clkevt->reload, common_clkevt->load);
>  	writel(ctrl, common_clkevt->ctrl);
>  	return 0;
> -- 
> 2.35.1
