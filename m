Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19C8161DABB
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Nov 2022 15:06:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229645AbiKEOGA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Nov 2022 10:06:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiKEOF6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Nov 2022 10:05:58 -0400
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com [IPv6:2001:4860:4864:20::2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AABA20F52
        for <linux-kernel@vger.kernel.org>; Sat,  5 Nov 2022 07:05:57 -0700 (PDT)
Received: by mail-oa1-x2f.google.com with SMTP id 586e51a60fabf-13b23e29e36so8332769fac.8
        for <linux-kernel@vger.kernel.org>; Sat, 05 Nov 2022 07:05:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8Bw328y2bVSAsU6M+b6Cqflfx2UQ2J4p0Zb/NQFKXJ8=;
        b=S34IWwxCPFjK3gTNiS+7/ui94MFPB5mi1t+pWqvcgwfcOdSeFSwiAKrBJOOJKwh5C0
         arTFR38OjfsJdLcM6Rv94GH56yEZ9TRfxQYQgc0CEi3mC8C3fm/hiuhP7eQQjAOdmJ6M
         +kbMnKKDMtOl95UhO+SB60NCGX6YoGz8W8rEjQrLFaUvXckvd+LkIfkXFcq3bSb4kic0
         lUwdQDdQka484e6pkgx9eegVIiJjBDtlnoExNz1rMPoI6POBy9pWo9MbV9aL2UEzBiHM
         OuNrDHvwACgi4w9PDw+RiuaKezVnIu32dR61YJfsjg2HLOHK7ogeRkAXw0QUAutaBBHZ
         P4Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8Bw328y2bVSAsU6M+b6Cqflfx2UQ2J4p0Zb/NQFKXJ8=;
        b=ekqwCgN371URtio+rFXDb/2G76jzCrURqsjSYxNMfVRSNtO/tq2HuOiBnS6KurU671
         aJGL9Uidl+iZeLDPOcJY/OE0+0I0Nf46jV4iVTnWy5FumbLq3iYwkPzRlDcWIV9LmiWG
         RWIl0fnpFkC2uE9OZBng8gtfuw6HJNaVnVwyZD/D0/r0p8qLFzWF49a9hwGPmwyqZf3b
         ZeSmDEN1HzDMoQBL5RnrPwuTXdOcH1LdtzAkKwSn58NgpXN1ZF+RDfPIF6Lq0mYZvFrN
         GmwkKkl6qRr+FYt6SWmnH+TsF0h9I2oOXWj5azB6Z9QhsmyqcoAZ4EbJK2t4mcEhidL1
         HZ1A==
X-Gm-Message-State: ACrzQf0nQHqcx/xQ4v6E34VATjnJt2vxeNSfvRA3ygb6DVgAEQ+vz6ka
        /8+ZnYHRsv6joKCu5hCgXeqd6z7cHAU=
X-Google-Smtp-Source: AMsMyM4O2xKxqglPQbMZ6j5scgQkj5CrqrKDHWc9w3V01Uf2BG/n3UTYNm7zcvvx8yCZB7S0ibZ2sA==
X-Received: by 2002:a05:6870:7682:b0:13b:ba8f:413d with SMTP id dx2-20020a056870768200b0013bba8f413dmr353354oab.236.1667657156815;
        Sat, 05 Nov 2022 07:05:56 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id o198-20020a4a2ccf000000b004968311a31asm625577ooo.39.2022.11.05.07.05.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Nov 2022 07:05:54 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Sat, 5 Nov 2022 07:05:53 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        Anna-Maria Gleixner <anna-maria@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Viresh Kumar <vireshk@kernel.org>,
        Shiraz Hashim <shiraz.linux.kernel@gmail.com>,
        Russell King <linux@armlinux.org.uk>, soc@kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v4a 02/38] ARM: spear: Do not use timer namespace for
 timer_shutdown() function
Message-ID: <20221105140553.GC1606271@roeck-us.net>
References: <20221105060024.598488967@goodmis.org>
 <20221105060155.228348078@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221105060155.228348078@goodmis.org>
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

On Sat, Nov 05, 2022 at 02:00:26AM -0400, Steven Rostedt wrote:
> From: "Steven Rostedt (Google)" <rostedt@goodmis.org>
> 
> A new "shutdown" timer state is being added to the generic timer code. One
> of the functions to change the timer into the state is called
> "timer_shutdown()". This means that there can not be other functions
> called "timer_shutdown()" as the timer code owns the "timer_*" name space.
> 
> Rename timer_shutdown() to evt_timer_shutdown() to avoid this conflict.
> 
> Cc: Viresh Kumar <vireshk@kernel.org>
> Cc: Shiraz Hashim <shiraz.linux.kernel@gmail.com>
> Cc: Russell King <linux@armlinux.org.uk>
> Cc: soc@kernel.org
> Cc: linux-arm-kernel@lists.infradead.org
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>

Nitpick: I would have called it spear_timer_shutdown(). POV, so

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  arch/arm/mach-spear/time.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm/mach-spear/time.c b/arch/arm/mach-spear/time.c
> index e979e2197f8e..9629b8fae85f 100644
> --- a/arch/arm/mach-spear/time.c
> +++ b/arch/arm/mach-spear/time.c
> @@ -90,7 +90,7 @@ static void __init spear_clocksource_init(void)
>  		200, 16, clocksource_mmio_readw_up);
>  }
>  
> -static inline void timer_shutdown(struct clock_event_device *evt)
> +static inline void evt_timer_shutdown(struct clock_event_device *evt)
>  {
>  	u16 val = readw(gpt_base + CR(CLKEVT));
>  
> @@ -101,7 +101,7 @@ static inline void timer_shutdown(struct clock_event_device *evt)
>  
>  static int spear_shutdown(struct clock_event_device *evt)
>  {
> -	timer_shutdown(evt);
> +	evt_timer_shutdown(evt);
>  
>  	return 0;
>  }
> @@ -111,7 +111,7 @@ static int spear_set_oneshot(struct clock_event_device *evt)
>  	u16 val;
>  
>  	/* stop the timer */
> -	timer_shutdown(evt);
> +	evt_timer_shutdown(evt);
>  
>  	val = readw(gpt_base + CR(CLKEVT));
>  	val |= CTRL_ONE_SHOT;
> @@ -126,7 +126,7 @@ static int spear_set_periodic(struct clock_event_device *evt)
>  	u16 val;
>  
>  	/* stop the timer */
> -	timer_shutdown(evt);
> +	evt_timer_shutdown(evt);
>  
>  	period = clk_get_rate(gpt_clk) / HZ;
>  	period >>= CTRL_PRESCALER16;
> -- 
> 2.35.1
