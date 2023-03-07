Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D67F16AEC12
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 18:52:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231975AbjCGRv4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 12:51:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232267AbjCGRvc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 12:51:32 -0500
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B06B9AA16;
        Tue,  7 Mar 2023 09:46:09 -0800 (PST)
Received: by mail-ot1-x333.google.com with SMTP id p13-20020a9d744d000000b0069438f0db7eso7593203otk.3;
        Tue, 07 Mar 2023 09:46:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678211168;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OFJC9GtvOmON1SGRH9OoQgSaTAxJ43HISNmvxqbzzwc=;
        b=O19j31qa8ZsdJF8+6oabWCye0AZW5OQ7brRr5+CkqUh57KtJzl4ObeglJ6lhFi9XBe
         JcQ0cozlqrSgs5YKhFLeGS9iY4IGlK75wW5Pb+xcb5/A4jtEXVOB7pOqFAr3fSYVD1qE
         jcRIgt3dFqhiRChyfFBv03kUDzkMua0ILMUhrkSPzkjd63OT9fr+hdmJhcaD7/Pvv0Md
         FNbwzeF8kNnTp638psB1CpZ17da5NE6vmW8iqvc4iBS+tr2TBWINNsWahSZb9V8+IpMp
         rrtLUOf7YB3KNxkla3g3bvO7zDTpecMECp5Y6Tfg+SVgVHbjYgjiYn93iqi2QkPnXaEx
         s7wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678211168;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OFJC9GtvOmON1SGRH9OoQgSaTAxJ43HISNmvxqbzzwc=;
        b=Ys4eXm7GGLa8+A6hVNElkRZbLSNIyfEZfzOqAyAx9LxqP/w/NcRfmiUQHh7PbvhyVV
         TIHcYmIfTTTKji0Y8MaLWBxKhLmJCfJssRm3CMSP1Mt8mcUU6StBdfhjauaOxJ8lWc1t
         GoQ7/uBghgMmBnAwh4on47wFJnBYMXukvdeVRQSwMsoghGzGd8cdSKLc7IOdWP3n6l87
         omSN7DUJZhJ4Lq6G23JnGPrukkn8ewlStPC0dA2GU9l5uW/R+uJ28DDFp4ydWRc+lNOW
         vgxWz1OJRjWMheAQvENetdEuHfS8drSv6SxOATT2qg/0Pk1yZytTAOgnFP+F6oGXCsKj
         I1VA==
X-Gm-Message-State: AO0yUKW7UXeRuyBelHPdEAIC6tCSWiogxc2tMCeZq2sqbysjvNEiBxdu
        eMuzVkyXPqR/cce9Elkqpf/814ypgWM=
X-Google-Smtp-Source: AK7set8R9WJ1dRmyO+CFyOTDGBsUBsqzq85PRh9ZLNxm3gFW8AOu49eycitql+O95Jd1B3hUtCZBVA==
X-Received: by 2002:a9d:4c9:0:b0:68b:e603:5b7 with SMTP id 67-20020a9d04c9000000b0068be60305b7mr7195854otm.15.1678211168187;
        Tue, 07 Mar 2023 09:46:08 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id f8-20020a9d2c08000000b00690dc5d9b9esm5571453otb.6.2023.03.07.09.46.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Mar 2023 09:46:07 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Tue, 7 Mar 2023 09:46:05 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Sergio Paracuellos <sergio.paracuellos@gmail.com>
Cc:     linux-watchdog@vger.kernel.org, wim@linux-watchdog.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] watchdog: rt2880-wdt: avoid static global
 declarations
Message-ID: <9c8de316-404d-40e4-85df-910b5d1b09bf@roeck-us.net>
References: <20230301065510.2818425-1-sergio.paracuellos@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230301065510.2818425-1-sergio.paracuellos@gmail.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 01, 2023 at 07:55:09AM +0100, Sergio Paracuellos wrote:
> Instead of using static global definitions in driver code, refactor code
> introducing a new watchdog driver data structure and use it along the code.
> 
> Signed-off-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  drivers/watchdog/rt2880_wdt.c | 89 ++++++++++++++++++++---------------
>  1 file changed, 50 insertions(+), 39 deletions(-)
> 
> diff --git a/drivers/watchdog/rt2880_wdt.c b/drivers/watchdog/rt2880_wdt.c
> index 49aff800824d..e54737bcf939 100644
> --- a/drivers/watchdog/rt2880_wdt.c
> +++ b/drivers/watchdog/rt2880_wdt.c
> @@ -40,10 +40,13 @@
>  #define TMR1CTL_PRESCALE_MASK		0xf
>  #define TMR1CTL_PRESCALE_65536		0xf
>  
> -static struct clk *rt288x_wdt_clk;
> -static unsigned long rt288x_wdt_freq;
> -static void __iomem *rt288x_wdt_base;
> -static struct reset_control *rt288x_wdt_reset;
> +struct rt2880_wdt_data {
> +	void __iomem *base;
> +	unsigned long freq;
> +	struct clk *clk;
> +	struct reset_control *rst;
> +	struct watchdog_device wdt;
> +};
>  
>  static bool nowayout = WATCHDOG_NOWAYOUT;
>  module_param(nowayout, bool, 0);
> @@ -51,52 +54,56 @@ MODULE_PARM_DESC(nowayout,
>  		"Watchdog cannot be stopped once started (default="
>  		__MODULE_STRING(WATCHDOG_NOWAYOUT) ")");
>  
> -static inline void rt_wdt_w32(unsigned reg, u32 val)
> +static inline void rt_wdt_w32(void __iomem *base, unsigned reg, u32 val)
>  {
> -	iowrite32(val, rt288x_wdt_base + reg);
> +	iowrite32(val, base + reg);
>  }
>  
> -static inline u32 rt_wdt_r32(unsigned reg)
> +static inline u32 rt_wdt_r32(void __iomem *base, unsigned reg)
>  {
> -	return ioread32(rt288x_wdt_base + reg);
> +	return ioread32(base + reg);
>  }
>  
>  static int rt288x_wdt_ping(struct watchdog_device *w)
>  {
> -	rt_wdt_w32(TIMER_REG_TMR1LOAD, w->timeout * rt288x_wdt_freq);
> +	struct rt2880_wdt_data *drvdata = watchdog_get_drvdata(w);
> +
> +	rt_wdt_w32(drvdata->base, TIMER_REG_TMR1LOAD, w->timeout * drvdata->freq);
>  
>  	return 0;
>  }
>  
>  static int rt288x_wdt_start(struct watchdog_device *w)
>  {
> +	struct rt2880_wdt_data *drvdata = watchdog_get_drvdata(w);
>  	u32 t;
>  
> -	t = rt_wdt_r32(TIMER_REG_TMR1CTL);
> +	t = rt_wdt_r32(drvdata->base, TIMER_REG_TMR1CTL);
>  	t &= ~(TMR1CTL_MODE_MASK << TMR1CTL_MODE_SHIFT |
>  		TMR1CTL_PRESCALE_MASK);
>  	t |= (TMR1CTL_MODE_WDT << TMR1CTL_MODE_SHIFT |
>  		TMR1CTL_PRESCALE_65536);
> -	rt_wdt_w32(TIMER_REG_TMR1CTL, t);
> +	rt_wdt_w32(drvdata->base, TIMER_REG_TMR1CTL, t);
>  
>  	rt288x_wdt_ping(w);
>  
> -	t = rt_wdt_r32(TIMER_REG_TMR1CTL);
> +	t = rt_wdt_r32(drvdata->base, TIMER_REG_TMR1CTL);
>  	t |= TMR1CTL_ENABLE;
> -	rt_wdt_w32(TIMER_REG_TMR1CTL, t);
> +	rt_wdt_w32(drvdata->base, TIMER_REG_TMR1CTL, t);
>  
>  	return 0;
>  }
>  
>  static int rt288x_wdt_stop(struct watchdog_device *w)
>  {
> +	struct rt2880_wdt_data *drvdata = watchdog_get_drvdata(w);
>  	u32 t;
>  
>  	rt288x_wdt_ping(w);
>  
> -	t = rt_wdt_r32(TIMER_REG_TMR1CTL);
> +	t = rt_wdt_r32(drvdata->base, TIMER_REG_TMR1CTL);
>  	t &= ~TMR1CTL_ENABLE;
> -	rt_wdt_w32(TIMER_REG_TMR1CTL, t);
> +	rt_wdt_w32(drvdata->base, TIMER_REG_TMR1CTL, t);
>  
>  	return 0;
>  }
> @@ -130,41 +137,45 @@ static const struct watchdog_ops rt288x_wdt_ops = {
>  	.set_timeout = rt288x_wdt_set_timeout,
>  };
>  
> -static struct watchdog_device rt288x_wdt_dev = {
> -	.info = &rt288x_wdt_info,
> -	.ops = &rt288x_wdt_ops,
> -	.min_timeout = 1,
> -};
> -
>  static int rt288x_wdt_probe(struct platform_device *pdev)
>  {
>  	struct device *dev = &pdev->dev;
> +	struct watchdog_device *wdt;
> +	struct rt2880_wdt_data *drvdata;
>  	int ret;
>  
> -	rt288x_wdt_base = devm_platform_ioremap_resource(pdev, 0);
> -	if (IS_ERR(rt288x_wdt_base))
> -		return PTR_ERR(rt288x_wdt_base);
> +	drvdata = devm_kzalloc(dev, sizeof(*drvdata), GFP_KERNEL);
> +	if (!drvdata)
> +		return -ENOMEM;
> +
> +	drvdata->base = devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(drvdata->base))
> +		return PTR_ERR(drvdata->base);
>  
> -	rt288x_wdt_clk = devm_clk_get(dev, NULL);
> -	if (IS_ERR(rt288x_wdt_clk))
> -		return PTR_ERR(rt288x_wdt_clk);
> +	drvdata->clk = devm_clk_get(dev, NULL);
> +	if (IS_ERR(drvdata->clk))
> +		return PTR_ERR(drvdata->clk);
>  
> -	rt288x_wdt_reset = devm_reset_control_get_exclusive(dev, NULL);
> -	if (!IS_ERR(rt288x_wdt_reset))
> -		reset_control_deassert(rt288x_wdt_reset);
> +	drvdata->rst = devm_reset_control_get_exclusive(dev, NULL);
> +	if (!IS_ERR(drvdata->rst))
> +		reset_control_deassert(drvdata->rst);
>  
> -	rt288x_wdt_freq = clk_get_rate(rt288x_wdt_clk) / RALINK_WDT_PRESCALE;
> +	drvdata->freq = clk_get_rate(drvdata->clk) / RALINK_WDT_PRESCALE;
>  
> -	rt288x_wdt_dev.bootstatus = rt288x_wdt_bootcause();
> -	rt288x_wdt_dev.max_timeout = (0xfffful / rt288x_wdt_freq);
> -	rt288x_wdt_dev.parent = dev;
> +	wdt = &drvdata->wdt;
> +	wdt->info = &rt288x_wdt_info;
> +	wdt->ops = &rt288x_wdt_ops;
> +	wdt->min_timeout = 1;
> +	wdt->max_timeout = (0xfffful / drvdata->freq);
> +	wdt->parent = dev;
> +	wdt->bootstatus = rt288x_wdt_bootcause();
>  
> -	watchdog_init_timeout(&rt288x_wdt_dev, rt288x_wdt_dev.max_timeout,
> -			      dev);
> -	watchdog_set_nowayout(&rt288x_wdt_dev, nowayout);
> +	watchdog_init_timeout(wdt, wdt->max_timeout, dev);
> +	watchdog_set_nowayout(wdt, nowayout);
> +	watchdog_set_drvdata(wdt, drvdata);
>  
> -	watchdog_stop_on_reboot(&rt288x_wdt_dev);
> -	ret = devm_watchdog_register_device(dev, &rt288x_wdt_dev);
> +	watchdog_stop_on_reboot(wdt);
> +	ret = devm_watchdog_register_device(dev, &drvdata->wdt);
>  	if (!ret)
>  		dev_info(dev, "Initialized\n");
>  
