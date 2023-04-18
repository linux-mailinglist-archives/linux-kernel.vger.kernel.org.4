Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C59796E696C
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 18:25:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232278AbjDRQZh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 12:25:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232515AbjDRQZS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 12:25:18 -0400
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09F5EC17A;
        Tue, 18 Apr 2023 09:24:40 -0700 (PDT)
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-6a5f765d595so534620a34.0;
        Tue, 18 Apr 2023 09:24:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681835079; x=1684427079;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eYXOXhwOuaN5BYLVD5MINTzgcivFMP6OFM9Ouw1eMEA=;
        b=GOh9MxLu+ZShnfO7pSzuy1uTuU4a9Neapha0Wrpbi65Xjkt+Zx+l6Qi/QxBZn4zeWA
         s02xNLAxTxtiPCJZma4VXn1sdFsFhCE/e7HuBW3CfgN13W6/Sm4M+XgzPBJHP+bfjIqU
         G5sACTX0NEU/fHNHPMO3UdDhv7eOc5TyLTTZdrVyVd6Fm91yeI93G24a/Oj9OxGvmLCM
         vGEBPtJCdQUNpi+Hvn/5VospueeHoAlQiocJWAzplcU2O5rw4EaxLq/HI9IvBl/aqqP6
         +dgHQ/QTZXU6GE7LQjvwMHfcoGtuzmOSXNI+izMRn1iyvgJs1qzrT3n9PGnvo6jcFoHX
         RPYQ==
X-Gm-Message-State: AAQBX9dA8yJRH+23GpeZSgqXwLm+XKo0wIZqxscEiDJaPZ/RSH4Iav5U
        QbVLPOMlMIWYL6WQR3FuDeI65KRETw==
X-Google-Smtp-Source: AKy350Z7UHBVwbyA0BC5lT06FS4ir+D/OjL45d9qZkXsNVnYVv+Pi0wNah1TK3EDUA1L7EwivZej4g==
X-Received: by 2002:a9d:7a93:0:b0:6a5:e9e8:cb1f with SMTP id l19-20020a9d7a93000000b006a5e9e8cb1fmr1324094otn.20.1681835079114;
        Tue, 18 Apr 2023 09:24:39 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id m9-20020a9d7e89000000b0069f9203967bsm5609729otp.76.2023.04.18.09.24.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Apr 2023 09:24:38 -0700 (PDT)
Received: (nullmailer pid 1807089 invoked by uid 1000);
        Tue, 18 Apr 2023 16:24:37 -0000
Date:   Tue, 18 Apr 2023 11:24:37 -0500
From:   Rob Herring <robh@kernel.org>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] clocksource: ti: Use of_property_read_bool() for boolean
 properties
Message-ID: <20230418162437.GB1764573-robh@kernel.org>
References: <20230310144702.1541660-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230310144702.1541660-1-robh@kernel.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 10, 2023 at 08:47:01AM -0600, Rob Herring wrote:
> It is preferred to use typed property access functions (i.e.
> of_property_read_<type> functions) rather than low-level
> of_get_property/of_find_property functions for reading properties.
> Convert reading boolean properties to to of_property_read_bool().
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  drivers/clocksource/timer-ti-dm-systimer.c | 4 ++--
>  drivers/clocksource/timer-ti-dm.c          | 8 ++++----
>  2 files changed, 6 insertions(+), 6 deletions(-)

Ping!

> 
> diff --git a/drivers/clocksource/timer-ti-dm-systimer.c b/drivers/clocksource/timer-ti-dm-systimer.c
> index 632523c1232f..efa5f55a65f8 100644
> --- a/drivers/clocksource/timer-ti-dm-systimer.c
> +++ b/drivers/clocksource/timer-ti-dm-systimer.c
> @@ -586,7 +586,7 @@ static int __init dmtimer_clkevt_init_common(struct dmtimer_clockevent *clkevt,
>  	writel_relaxed(OMAP_TIMER_INT_OVERFLOW, t->base + t->wakeup);
>  
>  	pr_info("TI gptimer %s: %s%lu Hz at %pOF\n",
> -		name, of_find_property(np, "ti,timer-alwon", NULL) ?
> +		name, of_property_read_bool(np, "ti,timer-alwon") ?
>  		"always-on " : "", t->rate, np->parent);
>  
>  	return 0;
> @@ -787,7 +787,7 @@ static int __init dmtimer_clocksource_init(struct device_node *np)
>  		       t->base + t->ctrl);
>  
>  	pr_info("TI gptimer clocksource: %s%pOF\n",
> -		of_find_property(np, "ti,timer-alwon", NULL) ?
> +		of_property_read_bool(np, "ti,timer-alwon") ?
>  		"always-on " : "", np->parent);
>  
>  	if (!dmtimer_sched_clock_counter) {
> diff --git a/drivers/clocksource/timer-ti-dm.c b/drivers/clocksource/timer-ti-dm.c
> index b24b903a8822..7031aa1bfdcb 100644
> --- a/drivers/clocksource/timer-ti-dm.c
> +++ b/drivers/clocksource/timer-ti-dm.c
> @@ -1104,13 +1104,13 @@ static int omap_dm_timer_probe(struct platform_device *pdev)
>  	platform_set_drvdata(pdev, timer);
>  
>  	if (dev->of_node) {
> -		if (of_find_property(dev->of_node, "ti,timer-alwon", NULL))
> +		if (of_property_read_bool(dev->of_node, "ti,timer-alwon"))
>  			timer->capability |= OMAP_TIMER_ALWON;
> -		if (of_find_property(dev->of_node, "ti,timer-dsp", NULL))
> +		if (of_property_read_bool(dev->of_node, "ti,timer-dsp"))
>  			timer->capability |= OMAP_TIMER_HAS_DSP_IRQ;
> -		if (of_find_property(dev->of_node, "ti,timer-pwm", NULL))
> +		if (of_property_read_bool(dev->of_node, "ti,timer-pwm"))
>  			timer->capability |= OMAP_TIMER_HAS_PWM;
> -		if (of_find_property(dev->of_node, "ti,timer-secure", NULL))
> +		if (of_property_read_bool(dev->of_node, "ti,timer-secure"))
>  			timer->capability |= OMAP_TIMER_SECURE;
>  	} else {
>  		timer->id = pdev->id;
> -- 
> 2.39.2
> 
