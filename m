Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A29416967B1
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 16:11:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233052AbjBNPLf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 10:11:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233038AbjBNPLd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 10:11:33 -0500
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0C1229433;
        Tue, 14 Feb 2023 07:11:31 -0800 (PST)
Received: by mail-ot1-x32d.google.com with SMTP id 38-20020a9d04a9000000b0068f24f576c5so4455407otm.11;
        Tue, 14 Feb 2023 07:11:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Rae9+YoXyO1Yk7gg3jdPV0K2HtFxHeOaLCxM6ooUoo0=;
        b=BWjcAzvuKXOgY/GgiC4AYhzHi//g8zAQOrOzvFGJrcxumMausmkHtmy+CgmxKKiPk0
         Oe4eYSFS+9JK1tQem/LP05bKSSds7D3/brGUe3A6ry5HcdM6c3rsnvPBRcNFr/iLEWdG
         8dWc1p4b1+6yKtognnm41c/gqcsiMjWBbgaLcl0ABSvCOgFLUo6gQze41cH2IAa2iemb
         Pbee5B6DxJ7ARiaGqnwsmdLl/U2ypA1RMGyaGp4YAhoMzGbYkDcqiBRXnYma3K+yLKO0
         yIG2f3N5dZ9t60kZkiWbr2ALeoJFjZxRmgydKyFiCx1zV0xIbgkm+zGfrncHDWpP3eIT
         17sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Rae9+YoXyO1Yk7gg3jdPV0K2HtFxHeOaLCxM6ooUoo0=;
        b=2LaJg2q5k50p66KJnB3uD8iJ5GNrDZ6tlWC4iTbZ8IIksc3txQ0y8SQ6rpQpML3uwI
         mfhwyYendDADZaSBNR09PY5PvnUcBRISz4z2dYjRsn2H90uilDEV030mH9vqVEhsfh8r
         xXkkIQJ62TgZPKBV16jA6alkrJZa8+Jnuze7ds478iOThEHrIN64mcRXZarUlKrqS53P
         rbIOIqPaH91I8/ong91zdE9A0CbeC+CeQ9yviqDAtsydHnOuJjwNDL/iAY9xZrPa8VF7
         p+tHfzJbrfyeDyM2+MJRLU+ned1s1c97sUhjWIcjlzJKB7n2jHZeHu2O8NnALZe7RCx5
         S9qQ==
X-Gm-Message-State: AO0yUKXqsHbVjBQ0jjqSt9DZtGG0AVAnmhxo7TKzEl78CvfbN2/lgt3e
        0VAMrfHnMV2KrkxIDPne6Gs=
X-Google-Smtp-Source: AK7set+eKl7t7/pu+gstA2sCKI5tysyaJSPlPBwiMPNHxZlEKkCDwRTnbDGMIHLhqMyCC6UI+fLZNw==
X-Received: by 2002:a9d:6a96:0:b0:68f:37e0:3af6 with SMTP id l22-20020a9d6a96000000b0068f37e03af6mr1191787otq.11.1676387491188;
        Tue, 14 Feb 2023 07:11:31 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id h26-20020a9d641a000000b0068bd9a6d644sm6454420otl.23.2023.02.14.07.11.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Feb 2023 07:11:30 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Tue, 14 Feb 2023 07:11:29 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Sergio Paracuellos <sergio.paracuellos@gmail.com>
Cc:     linux-watchdog@vger.kernel.org, wim@linux-watchdog.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        matthias.bgg@gmail.com, arinc.unal@arinc9.com,
        tsbogend@alpha.franken.de, p.zabel@pengutronix.de,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-mips@vger.kernel.org
Subject: Re: [PATCH v7 5/5] watchdog: mt7621-wdt: avoid ralink architecture
 dependent code
Message-ID: <20230214151129.GD742354@roeck-us.net>
References: <20230214103936.1061078-1-sergio.paracuellos@gmail.com>
 <20230214103936.1061078-6-sergio.paracuellos@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230214103936.1061078-6-sergio.paracuellos@gmail.com>
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

On Tue, Feb 14, 2023 at 11:39:36AM +0100, Sergio Paracuellos wrote:
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
>  drivers/watchdog/Kconfig      |  4 +++-
>  drivers/watchdog/mt7621_wdt.c | 22 +++++++++++++++++-----
>  2 files changed, 20 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
> index b64bc49c7f30..cf752ad64392 100644
> --- a/drivers/watchdog/Kconfig
> +++ b/drivers/watchdog/Kconfig
> @@ -1865,7 +1865,9 @@ config GXP_WATCHDOG
>  config MT7621_WDT
>  	tristate "Mediatek SoC watchdog"
>  	select WATCHDOG_CORE
> -	depends on SOC_MT7620 || SOC_MT7621
> +	select REGMAP_MMIO
> +	select MFD_SYSCON
> +	depends on SOC_MT7620 || SOC_MT7621 || COMPILE_TEST
>  	help
>  	  Hardware driver for the Mediatek/Ralink MT7621/8 SoC Watchdog Timer.
>  
> diff --git a/drivers/watchdog/mt7621_wdt.c b/drivers/watchdog/mt7621_wdt.c
> index 40fb2c9ba9d9..f37d8298a480 100644
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
> @@ -143,6 +148,13 @@ static int mt7621_wdt_probe(struct platform_device *pdev)
>  	if (!drvdata)
>  		return -ENOMEM;
>  
> +	drvdata->sysc = syscon_regmap_lookup_by_phandle(np, "mediatek,sysctl");
> +	if (IS_ERR(drvdata->sysc)) {
> +		drvdata->sysc = syscon_regmap_lookup_by_compatible("mediatek,mt7621-sysc");
> +		if (IS_ERR(drvdata->sysc))
> +			return PTR_ERR(drvdata->sysc);
> +	}
> +
>  	drvdata->base = devm_platform_ioremap_resource(pdev, 0);
>  	if (IS_ERR(drvdata->base))
>  		return PTR_ERR(drvdata->base);
> @@ -158,7 +170,7 @@ static int mt7621_wdt_probe(struct platform_device *pdev)
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
