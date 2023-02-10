Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 108E36925B3
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 19:47:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232495AbjBJSrX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 13:47:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233210AbjBJSrT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 13:47:19 -0500
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 070527D3E7;
        Fri, 10 Feb 2023 10:47:04 -0800 (PST)
Received: by mail-oi1-x236.google.com with SMTP id s17so5186475ois.10;
        Fri, 10 Feb 2023 10:47:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BOs5daA5BK1EHhP+xhoSwPR77UO8CITlx0veBenH6JU=;
        b=jcBMONpsj3RtQwNGu+QdJZthUgn3ZO+KSJ8RFnYGUVmTEN0jLOJxHwSZ16AWyzoQKT
         UkQCmQm+W9KWDQ4FIZJNZ5nnSetfBtJ7gr9E3oRkMsLqnlGx/gg44QcwtaA8pWr60cLr
         xhN8Qq7mQjiofNXmAadgQ6IqypH+Ig5Mv9HyhYa7D5Yf/gw5b3hrPJjt13gzE4LKP+Pr
         vsZXLEftLJSp+vxE3WhQoDBmNVAsEbX3Iybs2ly/vphLzA2ve3/XuXVUyLNXArjMQOYy
         U2Uq7lqsKuLds7ftZfaG5OJWIodb2R1YjD44SpnxRKP37GcDFVixj4jzrBrIc522WLVL
         7pLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BOs5daA5BK1EHhP+xhoSwPR77UO8CITlx0veBenH6JU=;
        b=HNf6U11Wvz1VKMq4/Soj0ddHtwidb0J/j1/1cQPZaiHdtbVv+6u5UKxQIlVoDT/BAF
         jNW+vE2ICdsJQY0kUV+CWZ3+fRTdJEvKpbEdVX6qqXKhyIoHATpIHteXDQW4us+vRawc
         3+kRcGGh0HkXIXz8b7vuMaufWeArXDn9CgCq5UWhluI6o0r2+Hj9hcrurLBNtEgubL5b
         PED7WqWUoN9u/6DnHU34SlXChc1lU5kVOcl9ml4WgDTcGYFdV+EeFPMNuRGO4mbP2TaH
         8Q0dbOnMpefUP8fJUU7ijqWVzQql87C7whjXluTc+UFXTM+tKCpU6HXaSWWrYnr/8aMa
         TeuQ==
X-Gm-Message-State: AO0yUKXv5XAP4H88UWOo6Nmq8M/LOn5yZWdp/7w3KvkTH5f+isK3eWNt
        f2NrqLDNZvEh6FBePSsO4C4=
X-Google-Smtp-Source: AK7set93NzHPAg2oO+fzzdAzNyG55UI2OiRV8nZYiQSBLfQl/DricYmr3N/QEwKKq40QzpNmVc/yYQ==
X-Received: by 2002:a05:6808:3c7:b0:35c:51c3:8cb1 with SMTP id o7-20020a05680803c700b0035c51c38cb1mr7225206oie.13.1676054823372;
        Fri, 10 Feb 2023 10:47:03 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id p185-20020aca42c2000000b0037b753356b1sm2435534oia.50.2023.02.10.10.47.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Feb 2023 10:47:02 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Fri, 10 Feb 2023 10:47:01 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Sergio Paracuellos <sergio.paracuellos@gmail.com>
Cc:     linux-watchdog@vger.kernel.org, wim@linux-watchdog.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        matthias.bgg@gmail.com, arinc.unal@arinc9.com,
        tsbogend@alpha.franken.de, p.zabel@pengutronix.de,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-mips@vger.kernel.org
Subject: Re: [PATCH v3 4/4] watchdog: mt7621-wdt: avoid ralink architecture
 dependent code
Message-ID: <20230210184701.GE3670524@roeck-us.net>
References: <20230210173841.705783-1-sergio.paracuellos@gmail.com>
 <20230210173841.705783-5-sergio.paracuellos@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230210173841.705783-5-sergio.paracuellos@gmail.com>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 10, 2023 at 06:38:41PM +0100, Sergio Paracuellos wrote:
> MT7621 SoC has a system controller node. Watchdog need to access to reset
> status register. Ralink architecture and related driver are old and from
> the beggining they are using some architecture dependent operations for
> accessing this shared registers through 'asm/mach-ralink/ralink_regs.h'
> header file. However this is not ideal from a driver perspective which can
> just access to the system controller registers in an arch independent way
> using regmap syscon APIs. Update Kconfig accordingly to select new added
> dependencies and allow driver to be compile tested.
> 
> Signed-off-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  drivers/watchdog/Kconfig      |  2 ++
>  drivers/watchdog/mt7621_wdt.c | 19 ++++++++++++++-----
>  2 files changed, 16 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
> index b64bc49c7..0759de670 100644
> --- a/drivers/watchdog/Kconfig
> +++ b/drivers/watchdog/Kconfig
> @@ -1865,6 +1865,8 @@ config GXP_WATCHDOG
>  config MT7621_WDT
>  	tristate "Mediatek SoC watchdog"
>  	select WATCHDOG_CORE
> +	select REGMAP_MMIO
> +	select MFD_SYSCON
>  	depends on SOC_MT7620 || SOC_MT7621
>  	help
>  	  Hardware driver for the Mediatek/Ralink MT7621/8 SoC Watchdog Timer.
> diff --git a/drivers/watchdog/mt7621_wdt.c b/drivers/watchdog/mt7621_wdt.c
> index 40fb2c9ba..9ed07c187 100644
> --- a/drivers/watchdog/mt7621_wdt.c
> +++ b/drivers/watchdog/mt7621_wdt.c
> @@ -15,8 +15,8 @@
>  #include <linux/moduleparam.h>
>  #include <linux/platform_device.h>
>  #include <linux/mod_devicetable.h>
> -
> -#include <asm/mach-ralink/ralink_regs.h>
> +#include <linux/mfd/syscon.h>
> +#include <linux/regmap.h>
>  
>  #define SYSC_RSTSTAT			0x38
>  #define WDT_RST_CAUSE			BIT(1)
> @@ -34,6 +34,7 @@
>  struct mt7621_wdt_data {
>  	void __iomem *base;
>  	struct reset_control *rst;
> +	struct regmap *sysc;
>  	struct watchdog_device wdt;
>  };
>  
> @@ -104,9 +105,12 @@ static int mt7621_wdt_stop(struct watchdog_device *w)
>  	return 0;
>  }
>  
> -static int mt7621_wdt_bootcause(void)
> +static int mt7621_wdt_bootcause(struct mt7621_wdt_data *d)
>  {
> -	if (rt_sysc_r32(SYSC_RSTSTAT) & WDT_RST_CAUSE)
> +	u32 val;
> +
> +	regmap_read(d->sysc, SYSC_RSTSTAT, &val);
> +	if (val & WDT_RST_CAUSE)
>  		return WDIOF_CARDRESET;
>  
>  	return 0;
> @@ -134,6 +138,7 @@ static const struct watchdog_ops mt7621_wdt_ops = {
>  
>  static int mt7621_wdt_probe(struct platform_device *pdev)
>  {
> +	struct device_node *np = pdev->dev.of_node;
>  	struct device *dev = &pdev->dev;
>  	struct watchdog_device *mt7621_wdt;
>  	struct mt7621_wdt_data *drvdata;
> @@ -143,6 +148,10 @@ static int mt7621_wdt_probe(struct platform_device *pdev)
>  	if (!drvdata)
>  		return -ENOMEM;
>  
> +	drvdata->sysc = syscon_regmap_lookup_by_phandle(np, "mediatek,sysctl");
> +	if (IS_ERR(drvdata->sysc))
> +		return PTR_ERR(drvdata->sysc);
> +
>  	drvdata->base = devm_platform_ioremap_resource(pdev, 0);
>  	if (IS_ERR(drvdata->base))
>  		return PTR_ERR(drvdata->base);
> @@ -158,7 +167,7 @@ static int mt7621_wdt_probe(struct platform_device *pdev)
>  	mt7621_wdt->max_timeout = 0xfffful / 1000;
>  	mt7621_wdt->parent = dev;
>  
> -	mt7621_wdt->bootstatus = mt7621_wdt_bootcause();
> +	mt7621_wdt->bootstatus = mt7621_wdt_bootcause(drvdata);
>  
>  	watchdog_init_timeout(mt7621_wdt, mt7621_wdt->max_timeout, dev);
>  	watchdog_set_nowayout(mt7621_wdt, nowayout);
> -- 
> 2.25.1
> 
