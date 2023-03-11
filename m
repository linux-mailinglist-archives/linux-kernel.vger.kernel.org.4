Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6DCE6B5C93
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Mar 2023 15:04:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229958AbjCKOER (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Mar 2023 09:04:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbjCKOEO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Mar 2023 09:04:14 -0500
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8133DF146E;
        Sat, 11 Mar 2023 06:04:10 -0800 (PST)
Received: by mail-ot1-x331.google.com with SMTP id q11-20020a056830440b00b00693c1a62101so4573780otv.0;
        Sat, 11 Mar 2023 06:04:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678543450;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lHbYfWWFMq3xnfq8RK48zaeSfQyOjYz9H9AeVr7JDkI=;
        b=VSuD1HPMoR8jMcVqSmVwP16birkFAsyWL8T9rTU8gib6oQjzN7aJsGKu4CfC6q1l79
         G/MzAJaljkexPdToBpeZqRYKCNUwC+8sMvWZEEMlGxevBTLZAlIdf7tJATO1Tx+l/8At
         AQ1b0lsrvv8gJAjS3ugAPWILzVr+2g/NC0batxEBIi9UNN7ZcFbG3o6XiGTtbVDOzZVr
         TwJrAx/wH8QQKpsV3eC+bAZQMDDU4SHzmRNZD5M6O7aDKOiFMQmpVef2mV/kg3H+y3pf
         tWoaFFNxqPVW6IqQiJVln2qHHkBxaDgl+DGyusJoABHQbn9DpavcZElIOj2PxAc5vMA3
         KLOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678543450;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lHbYfWWFMq3xnfq8RK48zaeSfQyOjYz9H9AeVr7JDkI=;
        b=3BqfdgRyCAWmljivFbj3w35fI2lM+Ethb8Wn4Oj6hwYDsaN7BRyd9QwsfuCQcAcwVS
         THPu2h0gtWfZEwGT9FLBklRWEdBo/yyhx37iRWfYy425jqoZPx6pxxHn8NYqS9ldVtx7
         2av4qkRnFH56IRrhDRcqwDg1HhTEBgIIf2tbQWbhvhrHzDZCSLyojR7vHBq8pES9VAx/
         4xjv2Nxh1FCmcjP2pPJNr1IDqkwJQJiTrqJEK3gd7zBrG7oMJBbTVREXCpUZu4Iqdw8y
         MLDVpZuIbOBrneOh+9LvSSdKeAxNouWFklVFuF9Eq26JKm/1WBLdWIqtRq5nMK6PTq1t
         fneQ==
X-Gm-Message-State: AO0yUKWdcQjgv+90jKRncMeu4hRHPN3kkMk7xAJxoGQ6LkTxAw3dcpOO
        BT1U1FEISDCABR551OMYL9Ldh1pDsdw=
X-Google-Smtp-Source: AK7set+IWuZ9Mh0/VK7kFulWIn5n9rP+YfScDH/5eoHPT4RE3YW6S5Miq5wtKTUgJ8EooryMLcDZEg==
X-Received: by 2002:a05:6830:6210:b0:68b:d62a:a64a with SMTP id cd16-20020a056830621000b0068bd62aa64amr6055562otb.29.1678543449779;
        Sat, 11 Mar 2023 06:04:09 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id v6-20020a05683024a600b00690e7b0f9e3sm1181701ots.34.2023.03.11.06.04.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Mar 2023 06:04:09 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Sat, 11 Mar 2023 06:04:08 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     William Breathitt Gray <william.gray@linaro.org>
Cc:     wim@linux-watchdog.org, linux-watchdog@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH] watchdog: ebc-c384_wdt: Migrate to the regmap API
Message-ID: <b65233f4-c8e2-435d-8321-03cc5f6b1c3d@roeck-us.net>
References: <20230311004404.62980-1-william.gray@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230311004404.62980-1-william.gray@linaro.org>
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

On Fri, Mar 10, 2023 at 07:44:04PM -0500, William Breathitt Gray wrote:
> The regmap API supports IO port accessors so we can take advantage of
> regmap abstractions rather than handling access to the device registers
> directly in the driver.
> 
> Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Signed-off-by: William Breathitt Gray <william.gray@linaro.org>

I assume you did, but just to be sure: Did you test this on hardware ?

> ---
>  drivers/watchdog/Kconfig        |  1 +
>  drivers/watchdog/ebc-c384_wdt.c | 64 +++++++++++++++++++++++----------
>  2 files changed, 46 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
> index f0872970daf9..301cfe79263c 100644
> --- a/drivers/watchdog/Kconfig
> +++ b/drivers/watchdog/Kconfig
> @@ -1089,6 +1089,7 @@ config EBC_C384_WDT
>  	tristate "WinSystems EBC-C384 Watchdog Timer"
>  	depends on X86
>  	select ISA_BUS_API
> +	select REGMAP_MMIO
>  	select WATCHDOG_CORE
>  	help
>  	  Enables watchdog timer support for the watchdog timer on the
> diff --git a/drivers/watchdog/ebc-c384_wdt.c b/drivers/watchdog/ebc-c384_wdt.c
> index 8ef4b0df3855..3776d32cb863 100644
> --- a/drivers/watchdog/ebc-c384_wdt.c
> +++ b/drivers/watchdog/ebc-c384_wdt.c
> @@ -3,15 +3,15 @@
>   * Watchdog timer driver for the WinSystems EBC-C384
>   * Copyright (C) 2016 William Breathitt Gray
>   */
> +#include <linux/bits.h>
>  #include <linux/device.h>
>  #include <linux/dmi.h>
> -#include <linux/errno.h>
> -#include <linux/io.h>
> -#include <linux/ioport.h>
> +#include <linux/err.h>
>  #include <linux/isa.h>
>  #include <linux/kernel.h>
>  #include <linux/module.h>
>  #include <linux/moduleparam.h>
> +#include <linux/regmap.h>
>  #include <linux/types.h>
>  #include <linux/watchdog.h>
>  
> @@ -24,8 +24,11 @@
>  #define WATCHDOG_MAX_TIMEOUT	15300
>  #define BASE_ADDR		0x564
>  #define ADDR_EXTENT		5
> -#define CFG_ADDR		(BASE_ADDR + 1)
> -#define PET_ADDR		(BASE_ADDR + 2)
> +#define CFG_REG			0x1
> +#define PET_REG			0x2
> +#define CFG_MINUTES		0x00
> +#define CFG_SECONDS		BIT(7)
> +#define PET_DISABLED		0x00
>  
>  static bool nowayout = WATCHDOG_NOWAYOUT;
>  module_param(nowayout, bool, 0);
> @@ -37,43 +40,54 @@ module_param(timeout, uint, 0);
>  MODULE_PARM_DESC(timeout, "Watchdog timeout in seconds (default="
>  	__MODULE_STRING(WATCHDOG_TIMEOUT) ")");
>  
> +static const struct regmap_range ebc_c384_wdt_wr_ranges[] = {
> +	regmap_reg_range(0x1, 0x2),

Any reasons for not using defines ?

> +};
> +static const struct regmap_access_table ebc_c384_wdt_wr_table = {
> +	.yes_ranges = ebc_c384_wdt_wr_ranges,
> +	.n_yes_ranges = ARRAY_SIZE(ebc_c384_wdt_wr_ranges),
> +};
> +static const struct regmap_config ebc_c384_wdt_regmap_config = {
> +	.reg_bits = 8,
> +	.reg_stride = 1,
> +	.val_bits = 8,
> +	.io_port = true,
> +	.max_register = 0x2,

Any reason for not using a define ?

> +	.wr_table = &ebc_c384_wdt_wr_table,
> +};
> +
>  static int ebc_c384_wdt_start(struct watchdog_device *wdev)
>  {
> +	struct regmap *const map = wdev->driver_data;

Please use watchdog_get_drvdata() and watchdog_set_drvdata() when accessing
or setting watchdog driver data.

Guenter

>  	unsigned t = wdev->timeout;
>  
>  	/* resolution is in minutes for timeouts greater than 255 seconds */
>  	if (t > 255)
>  		t = DIV_ROUND_UP(t, 60);
>  
> -	outb(t, PET_ADDR);
> -
> -	return 0;
> +	return regmap_write(map, PET_REG, t);
>  }
>  
>  static int ebc_c384_wdt_stop(struct watchdog_device *wdev)
>  {
> -	outb(0x00, PET_ADDR);
> +	struct regmap *const map = wdev->driver_data;
>  
> -	return 0;
> +	return regmap_write(map, PET_REG, PET_DISABLED);
>  }
>  
>  static int ebc_c384_wdt_set_timeout(struct watchdog_device *wdev, unsigned t)
>  {
> +	struct regmap *const map = wdev->driver_data;
> +
>  	/* resolution is in minutes for timeouts greater than 255 seconds */
>  	if (t > 255) {
>  		/* round second resolution up to minute granularity */
>  		wdev->timeout = roundup(t, 60);
> -
> -		/* set watchdog timer for minutes */
> -		outb(0x00, CFG_ADDR);
> -	} else {
> -		wdev->timeout = t;
> -
> -		/* set watchdog timer for seconds */
> -		outb(0x80, CFG_ADDR);
> +		return regmap_write(map, CFG_REG, CFG_MINUTES);
>  	}
>  
> -	return 0;
> +	wdev->timeout = t;
> +	return regmap_write(map, CFG_REG, CFG_SECONDS);
>  }
>  
>  static const struct watchdog_ops ebc_c384_wdt_ops = {
> @@ -89,6 +103,8 @@ static const struct watchdog_info ebc_c384_wdt_info = {
>  
>  static int ebc_c384_wdt_probe(struct device *dev, unsigned int id)
>  {
> +	void __iomem *regs;
> +	struct regmap *map;
>  	struct watchdog_device *wdd;
>  
>  	if (!devm_request_region(dev, BASE_ADDR, ADDR_EXTENT, dev_name(dev))) {
> @@ -97,6 +113,15 @@ static int ebc_c384_wdt_probe(struct device *dev, unsigned int id)
>  		return -EBUSY;
>  	}
>  
> +	regs = devm_ioport_map(dev, BASE_ADDR, ADDR_EXTENT);
> +	if (!regs)
> +		return -ENOMEM;
> +
> +	map = devm_regmap_init_mmio(dev, regs, &ebc_c384_wdt_regmap_config);
> +	if (IS_ERR(map))
> +		return dev_err_probe(dev, PTR_ERR(map),
> +				     "Unable to initialize register map\n");
> +
>  	wdd = devm_kzalloc(dev, sizeof(*wdd), GFP_KERNEL);
>  	if (!wdd)
>  		return -ENOMEM;
> @@ -106,6 +131,7 @@ static int ebc_c384_wdt_probe(struct device *dev, unsigned int id)
>  	wdd->timeout = WATCHDOG_TIMEOUT;
>  	wdd->min_timeout = 1;
>  	wdd->max_timeout = WATCHDOG_MAX_TIMEOUT;
> +	wdd->driver_data = map;
>  
>  	watchdog_set_nowayout(wdd, nowayout);
>  	watchdog_init_timeout(wdd, timeout, dev);
> 
> base-commit: fe15c26ee26efa11741a7b632e9f23b01aca4cc6
> -- 
> 2.39.2
> 
