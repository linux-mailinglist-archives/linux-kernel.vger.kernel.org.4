Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9520692150
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 16:00:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232316AbjBJPAf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 10:00:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232101AbjBJPAc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 10:00:32 -0500
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC0B6E387;
        Fri, 10 Feb 2023 07:00:29 -0800 (PST)
Received: by mail-ot1-x332.google.com with SMTP id j6-20020a9d7686000000b0068d4ba9d141so1600501otl.6;
        Fri, 10 Feb 2023 07:00:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=hkG5F6FfqxiRmGZr9MvPZGc5PmNjg+sydBTMNlTr+Vw=;
        b=qZEViGiIoH1AZMleIoZPddyCigeTGEYT/sASKMQDKw7mjofX1idoJ36SGxXaSqtE79
         aq212pu39Ukzv5wvC46dW1EEO6VnTf1wmieWGD3Betm6A8R9TlK5pBq2YGQcwYFB2CyB
         Xk9T9o1ptLV1sJPgLITUvD/CIWzT6f3PVkx6kftj23wZQVWIdlxA8LEzMrR04XU/1ndB
         JvOj8rN5DTi7XtmMzCOBdTLyudJd136p1lew+aUfIQyYYWY0F7OCMQmIDTGsWirLYDTn
         12aRw4z91yI9whFCSts37b5oLYlsTnp3+cqy2KQTaKR1EHSbECICH7WjvWVIBhKWVVId
         Jhcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hkG5F6FfqxiRmGZr9MvPZGc5PmNjg+sydBTMNlTr+Vw=;
        b=EHcPeuCbfariA0Axrc8fymum49sc0h8q9Lb/ImnoBHMtwM6yEu9QvtxpfCN6Wto9wW
         bxtkbRwUMhDlotz7kZH3E4UNjg+Gn5hIxjHE2D//d4tk8t6y9cfVQPpJlkKiCGx7hKhG
         kQXHwhNeO3cZzpbu99cArPvSGQKlPCYeiLEbYkyjEUqs4/nC5KUuvCExXNaDqrYMWBNF
         8EJS0/j90GqNKMN4Chrz2qJskKA1Uc+Y/HCDXowEniuPpMWe9bmRYbFwPvazoPhUIDOq
         E3CcPBK0SU+OBEtyXfv2qtnTKe0GxKnx//bD2EGmye/+wF1TF4C4qL5pX5V2X1AEs6Y2
         EOpg==
X-Gm-Message-State: AO0yUKXKzLfPHgnHzcrWX6XxgNZLaSLYmIdWfNE/jQUqETBtSKmfPV4k
        mY4svyDmz4yTfu4nXdl3eyM=
X-Google-Smtp-Source: AK7set8Xs782gGs134tanS6YvV3pniIpDNmAbo+uSqtkciGHSP8kHgBgR2UJhKybt7xOj2eNZps7nw==
X-Received: by 2002:a05:6830:3890:b0:684:e29a:ac5 with SMTP id bq16-20020a056830389000b00684e29a0ac5mr9462636otb.36.1676041228992;
        Fri, 10 Feb 2023 07:00:28 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id h18-20020a9d6a52000000b00688449397d3sm2079593otn.15.2023.02.10.07.00.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Feb 2023 07:00:28 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <b586fd0f-f5b3-6fd1-3cce-2809e5476bf5@roeck-us.net>
Date:   Fri, 10 Feb 2023 07:00:25 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v2 3/4] watchdog: mt7621-wdt: avoid static global
 declarations
Content-Language: en-US
To:     Sergio Paracuellos <sergio.paracuellos@gmail.com>,
        linux-watchdog@vger.kernel.org
Cc:     wim@linux-watchdog.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com,
        arinc.unal@arinc9.com, tsbogend@alpha.franken.de,
        p.zabel@pengutronix.de, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-mips@vger.kernel.org
References: <20230210121735.639089-1-sergio.paracuellos@gmail.com>
 <20230210121735.639089-4-sergio.paracuellos@gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <20230210121735.639089-4-sergio.paracuellos@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/10/23 04:17, Sergio Paracuellos wrote:
> Instead of using static global definitions in driver code, refactor code
> introducing a new watchdog driver data structure and use it along the
> code.
> 
> Signed-off-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>
> ---
>   drivers/watchdog/mt7621_wdt.c | 104 ++++++++++++++++++++++------------
>   1 file changed, 67 insertions(+), 37 deletions(-)
> 
> diff --git a/drivers/watchdog/mt7621_wdt.c b/drivers/watchdog/mt7621_wdt.c
> index a8aa3522c..f1c702971 100644
> --- a/drivers/watchdog/mt7621_wdt.c
> +++ b/drivers/watchdog/mt7621_wdt.c
> @@ -31,8 +31,11 @@
>   #define TMR1CTL_RESTART			BIT(9)
>   #define TMR1CTL_PRESCALE_SHIFT		16
>   
> -static void __iomem *mt7621_wdt_base;
> -static struct reset_control *mt7621_wdt_reset;
> +struct mt7621_wdt_data {
> +	void __iomem *base;
> +	struct reset_control *rst;
> +	struct watchdog_device wdt;
> +};
>   
>   static bool nowayout = WATCHDOG_NOWAYOUT;
>   module_param(nowayout, bool, 0);
> @@ -40,27 +43,31 @@ MODULE_PARM_DESC(nowayout,
>   		 "Watchdog cannot be stopped once started (default="
>   		 __MODULE_STRING(WATCHDOG_NOWAYOUT) ")");
>   
> -static inline void rt_wdt_w32(unsigned reg, u32 val)
> +static inline void rt_wdt_w32(void __iomem *base, unsigned reg, u32 val)
>   {
> -	iowrite32(val, mt7621_wdt_base + reg);
> +	iowrite32(val, base + reg);
>   }
>   
> -static inline u32 rt_wdt_r32(unsigned reg)
> +static inline u32 rt_wdt_r32(void __iomem *base, unsigned reg)
>   {
> -	return ioread32(mt7621_wdt_base + reg);
> +	return ioread32(base + reg);
>   }
>   
>   static int mt7621_wdt_ping(struct watchdog_device *w)
>   {
> -	rt_wdt_w32(TIMER_REG_TMRSTAT, TMR1CTL_RESTART);
> +	struct mt7621_wdt_data *drvdata = watchdog_get_drvdata(w);
> +
> +	rt_wdt_w32(drvdata->base, TIMER_REG_TMRSTAT, TMR1CTL_RESTART);
>   
>   	return 0;
>   }
>   
>   static int mt7621_wdt_set_timeout(struct watchdog_device *w, unsigned int t)
>   {
> +	struct mt7621_wdt_data *drvdata = watchdog_get_drvdata(w);
> +
>   	w->timeout = t;
> -	rt_wdt_w32(TIMER_REG_TMR1LOAD, t * 1000);
> +	rt_wdt_w32(drvdata->base, TIMER_REG_TMR1LOAD, t * 1000);
>   	mt7621_wdt_ping(w);
>   
>   	return 0;
> @@ -68,29 +75,31 @@ static int mt7621_wdt_set_timeout(struct watchdog_device *w, unsigned int t)
>   
>   static int mt7621_wdt_start(struct watchdog_device *w)
>   {
> +	struct mt7621_wdt_data *drvdata = watchdog_get_drvdata(w);
>   	u32 t;
>   
>   	/* set the prescaler to 1ms == 1000us */
> -	rt_wdt_w32(TIMER_REG_TMR1CTL, 1000 << TMR1CTL_PRESCALE_SHIFT);
> +	rt_wdt_w32(drvdata->base, TIMER_REG_TMR1CTL, 1000 << TMR1CTL_PRESCALE_SHIFT);
>   
>   	mt7621_wdt_set_timeout(w, w->timeout);
>   
> -	t = rt_wdt_r32(TIMER_REG_TMR1CTL);
> +	t = rt_wdt_r32(drvdata->base, TIMER_REG_TMR1CTL);
>   	t |= TMR1CTL_ENABLE;
> -	rt_wdt_w32(TIMER_REG_TMR1CTL, t);
> +	rt_wdt_w32(drvdata->base, TIMER_REG_TMR1CTL, t);
>   
>   	return 0;
>   }
>   
>   static int mt7621_wdt_stop(struct watchdog_device *w)
>   {
> +	struct mt7621_wdt_data *drvdata = watchdog_get_drvdata(w);
>   	u32 t;
>   
>   	mt7621_wdt_ping(w);
>   
> -	t = rt_wdt_r32(TIMER_REG_TMR1CTL);
> +	t = rt_wdt_r32(drvdata->base, TIMER_REG_TMR1CTL);
>   	t &= ~TMR1CTL_ENABLE;
> -	rt_wdt_w32(TIMER_REG_TMR1CTL, t);
> +	rt_wdt_w32(drvdata->base, TIMER_REG_TMR1CTL, t);
>   
>   	return 0;
>   }
> @@ -105,7 +114,9 @@ static int mt7621_wdt_bootcause(void)
>   
>   static int mt7621_wdt_is_running(struct watchdog_device *w)
>   {
> -	return !!(rt_wdt_r32(TIMER_REG_TMR1CTL) & TMR1CTL_ENABLE);
> +	struct mt7621_wdt_data *drvdata = watchdog_get_drvdata(w);
> +
> +	return !!(rt_wdt_r32(drvdata->base, TIMER_REG_TMR1CTL) & TMR1CTL_ENABLE);
>   }
>   
>   static const struct watchdog_info mt7621_wdt_info = {
> @@ -121,30 +132,39 @@ static const struct watchdog_ops mt7621_wdt_ops = {
>   	.set_timeout = mt7621_wdt_set_timeout,
>   };
>   
> -static struct watchdog_device mt7621_wdt_dev = {
> -	.info = &mt7621_wdt_info,
> -	.ops = &mt7621_wdt_ops,
> -	.min_timeout = 1,
> -	.max_timeout = 0xfffful / 1000,
> -};
> -
>   static int mt7621_wdt_probe(struct platform_device *pdev)
>   {
>   	struct device *dev = &pdev->dev;
> -	mt7621_wdt_base = devm_platform_ioremap_resource(pdev, 0);
> -	if (IS_ERR(mt7621_wdt_base))
> -		return PTR_ERR(mt7621_wdt_base);
> +	struct watchdog_device *mt7621_wdt;
> +	struct mt7621_wdt_data *drvdata;
> +	int err;
> +
> +	drvdata = devm_kzalloc(dev, sizeof(*drvdata), GFP_KERNEL);
> +	if (!drvdata)
> +		return -ENOMEM;
> +
> +	drvdata->base = devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(drvdata->base))
> +		return PTR_ERR(drvdata->base);
>   
> -	mt7621_wdt_reset = devm_reset_control_get_exclusive(dev, NULL);
> -	if (!IS_ERR(mt7621_wdt_reset))
> -		reset_control_deassert(mt7621_wdt_reset);
> +	drvdata->rst = devm_reset_control_get_exclusive(dev, NULL);
> +	if (!IS_ERR(drvdata->rst))
> +		reset_control_deassert(drvdata->rst);
>   
> -	mt7621_wdt_dev.bootstatus = mt7621_wdt_bootcause();
> +	mt7621_wdt = &drvdata->wdt;
> +	mt7621_wdt->info = &mt7621_wdt_info;
> +	mt7621_wdt->ops = &mt7621_wdt_ops;
> +	mt7621_wdt->min_timeout = 1;
> +	mt7621_wdt->max_timeout = 0xfffful / 1000;
> +	mt7621_wdt->parent = dev;
>   
> -	watchdog_init_timeout(&mt7621_wdt_dev, mt7621_wdt_dev.max_timeout,
> -			      dev);
> -	watchdog_set_nowayout(&mt7621_wdt_dev, nowayout);
> -	if (mt7621_wdt_is_running(&mt7621_wdt_dev)) {
> +	mt7621_wdt->bootstatus = mt7621_wdt_bootcause();
> +
> +	watchdog_init_timeout(mt7621_wdt, mt7621_wdt->max_timeout, dev);

FWIW, setting ->timeout would have been sufficient. watchdog_init_timeout()
is only really valuable if there is a module parameter, or if the timeout
is set from devicetree. That won't work here, though, because the passed
value takes precedence. Changing that would change functionality and thus would
have to be done in a separate patch, I just wanted to mention it.

> +	watchdog_set_nowayout(mt7621_wdt, nowayout);
> +	watchdog_set_drvdata(mt7621_wdt, drvdata);
> +
> +	if (mt7621_wdt_is_running(mt7621_wdt)) {
>   		/*
>   		 * Make sure to apply timeout from watchdog core, taking
>   		 * the prescaler of this driver here into account (the
> @@ -154,17 +174,27 @@ static int mt7621_wdt_probe(struct platform_device *pdev)
>   		 * we first disable the watchdog, set the new prescaler
>   		 * and timeout, and then re-enable the watchdog.
>   		 */
> -		mt7621_wdt_stop(&mt7621_wdt_dev);
> -		mt7621_wdt_start(&mt7621_wdt_dev);
> -		set_bit(WDOG_HW_RUNNING, &mt7621_wdt_dev.status);
> +		mt7621_wdt_stop(mt7621_wdt);
> +		mt7621_wdt_start(mt7621_wdt);
> +		set_bit(WDOG_HW_RUNNING, &mt7621_wdt->status);
> +	}
> +
> +	err = devm_watchdog_register_device(dev, &drvdata->wdt);
> +	if (err) {
> +		dev_err(dev, "Error registering watchdog device\n");
> +		return err;
>   	}

This is a functional change. If you want to add an error message,
do it in a separate patch and provide a rationale for it.

>   
> -	return devm_watchdog_register_device(dev, &mt7621_wdt_dev);
> +	platform_set_drvdata(pdev, drvdata);
> +
> +	return 0;
>   }
>   
>   static void mt7621_wdt_shutdown(struct platform_device *pdev)
>   {
> -	mt7621_wdt_stop(&mt7621_wdt_dev);
> +	struct mt7621_wdt_data *drvdata = platform_get_drvdata(pdev);
> +
> +	mt7621_wdt_stop(&drvdata->wdt);
>   }

Also FWIW, we have watchdog_stop_on_reboot() for that purpose.
Changing that would be a separate patch, though.

>   static const struct of_device_id mt7621_wdt_match[] = {

