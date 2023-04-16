Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CC8F6E3A48
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Apr 2023 18:28:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230229AbjDPQ2X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Apr 2023 12:28:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbjDPQ2V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Apr 2023 12:28:21 -0400
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F996115;
        Sun, 16 Apr 2023 09:28:20 -0700 (PDT)
Received: by mail-il1-x136.google.com with SMTP id e9e14a558f8ab-32933a4af12so17740875ab.3;
        Sun, 16 Apr 2023 09:28:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681662499; x=1684254499;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZxeYb2/hrDIy1xZ8JKBTKIXidcsw+9tMRcKm6qogpao=;
        b=gDJQVFWuTdfB2xIg5xijIT2fsG7Pi0Ilrq0DMeMV5YAU6S8y/BQk6MtDS2/8nwBvFI
         qMzZoAc9ycaIY+vJfFqKLoVWbdpJG/7m20VAOGqna2Af4QOccs5XpJ7Ne0AXCtZOxJMR
         qdDkq9tPLxqy4zAO+gpxYs6jNicdZygbAHxIjxYMmSKcY2+WMqBpJyMUL1+luJm/srU4
         gzYC3o02ZIAtcetGSaSE3KqTJKIfxW4OAfic5YBd1xrD178D/KeM92OJPJiQc0aIeEER
         ZmHe2NqsOLpTLX2DPYjjohNGeRC8qq7dD4pOhaZZHKMRGTbcDFif9GZNBd7fTFpD8b6e
         Mf8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681662499; x=1684254499;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZxeYb2/hrDIy1xZ8JKBTKIXidcsw+9tMRcKm6qogpao=;
        b=W/j84l7SN4tqYNAvw6cG5c65V+pmSm84R27RxsJqVhlboiSPr8+yUSM91ZTQkIvY8P
         j/wZkWreaqa6OI428rhVKoPgqBsUTSA3hntGY9b1LaBz+Fxv0U/E76TpfIxwvhlDSUEn
         +N1W7DuGFd2zoQWydJe/AqYsktTix/zQGrg5Y0dv6dydPgsCeVgFEwT5cOjBX3uNfAzM
         GMcn8qBjFQf04bVEhcOVH+VXADRWZuG5RhH3JfQ+vLSdSl6QLOaUY4ckGJqmv6VCp75O
         Jw6+yYwHLTXot7jf/qx7rF5BHg99xwxdUQnbEezIv2N4Zz3yhfJLWboJBSvi3AH9W9Lv
         oWxQ==
X-Gm-Message-State: AAQBX9cbQTMhQqY4b7rKWJORwMCnBwIebqkAXnMFu1U9wPge6IEcXH54
        G6ra97xZbRM6hS2jii16qpg=
X-Google-Smtp-Source: AKy350bLgoxakzl/y2NQ3Tj5UGr9YL8E5uL0x3wZ6YccXqZm/paVuGefoQotEJpj3Nl25LcqhGkQfw==
X-Received: by 2002:a92:d48f:0:b0:328:ebec:1967 with SMTP id p15-20020a92d48f000000b00328ebec1967mr8172374ilg.16.1681662499440;
        Sun, 16 Apr 2023 09:28:19 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id m44-20020a026a6c000000b0040b1ecc3ec4sm2622451jaf.11.2023.04.16.09.28.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Apr 2023 09:28:19 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Sun, 16 Apr 2023 09:28:17 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Srinivas Neeli <srinivas.neeli@amd.com>
Cc:     shubhrajyoti.datta@amd.com, michal.simek@amd.com,
        srinivas.goud@amd.com, wim@linux-watchdog.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-watchdog@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, git@amd.com, git@xilinx.com,
        neelisrinivas18@gmail.com
Subject: Re: [PATCH V3 3/4] watchdog: xilinx_wwdt: Add Versal window watchdog
 support
Message-ID: <b625d3e1-a7b4-4845-be02-1c81cbdec276@roeck-us.net>
References: <20230331074117.356339-1-srinivas.neeli@amd.com>
 <20230331074117.356339-4-srinivas.neeli@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230331074117.356339-4-srinivas.neeli@amd.com>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 31, 2023 at 01:11:16PM +0530, Srinivas Neeli wrote:
> Versal watchdog driver uses window watchdog mode. Window watchdog
> timer(WWDT) contains closed(first) and open(second) window with
> 32 bit width. Write to the watchdog timer within predefined window
> periods of time. This means a period that is not too soon and a
> period that is not too late. The WWDT has to be restarted within
> the open window time. If software tries to restart WWDT outside of
> the open window time period, it generates a reset.
> 
> Signed-off-by: Srinivas Neeli <srinivas.neeli@amd.com>
> ---
> Changes in V3:
> -Removed "xlnx,close_percent" support from dtb.
> -Added "xlnx,close_percent" property as module paratmeter.
> -Updated code with devm_clk_get_enabled().
> Changes in V2:
> - Takes "xlnx,close-percent" property from device tree parameter.
> - Removed clk_disable() function.
> - Removed module parameter permisions and using readomly.
> - Added check for close_percent( 0 < close_perecent < 100).
> - Updated other minor comments.
> ---
>  drivers/watchdog/Kconfig       |  18 +++
>  drivers/watchdog/Makefile      |   1 +
>  drivers/watchdog/xilinx_wwdt.c | 215 +++++++++++++++++++++++++++++++++
>  3 files changed, 234 insertions(+)
>  create mode 100644 drivers/watchdog/xilinx_wwdt.c
> 
> diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
> index f0872970daf9..ec4b522ae29e 100644
> --- a/drivers/watchdog/Kconfig
> +++ b/drivers/watchdog/Kconfig
> @@ -304,6 +304,24 @@ config XILINX_WATCHDOG
>  	  To compile this driver as a module, choose M here: the
>  	  module will be called of_xilinx_wdt.
>  
> +config XILINX_WINDOW_WATCHDOG
> +	tristate "Xilinx window watchdog timer"
> +	depends on HAS_IOMEM
> +	depends on ARM64
> +	select WATCHDOG_CORE
> +	help
> +	  Window watchdog driver for the versal_wwdt IP core.
> +	  Window watchdog timer(WWDT) contains closed(first) and
> +	  open(second) window with 32 bit width. Write to the watchdog
> +	  timer within predefined window periods of time. This means
> +	  a period that is not too soon and a period that is not too
> +	  late. The WWDT has to be restarted within the open window time.
> +	  If software tries to restart WWDT outside of the open window
> +	  time period, it generates a reset.
> +
> +	  To compile this driver as a module, choose M here: the
> +	  module will be called xilinx_wwdt.
> +
>  config ZIIRAVE_WATCHDOG
>  	tristate "Zodiac RAVE Watchdog Timer"
>  	depends on I2C
> diff --git a/drivers/watchdog/Makefile b/drivers/watchdog/Makefile
> index 9cbf6580f16c..6cb5f1dfb492 100644
> --- a/drivers/watchdog/Makefile
> +++ b/drivers/watchdog/Makefile
> @@ -157,6 +157,7 @@ obj-$(CONFIG_M54xx_WATCHDOG) += m54xx_wdt.o
>  
>  # MicroBlaze Architecture
>  obj-$(CONFIG_XILINX_WATCHDOG) += of_xilinx_wdt.o
> +obj-$(CONFIG_XILINX_WINDOW_WATCHDOG) += xilinx_wwdt.o
>  
>  # MIPS Architecture
>  obj-$(CONFIG_ATH79_WDT) += ath79_wdt.o
> diff --git a/drivers/watchdog/xilinx_wwdt.c b/drivers/watchdog/xilinx_wwdt.c
> new file mode 100644
> index 000000000000..7e9205bbf160
> --- /dev/null
> +++ b/drivers/watchdog/xilinx_wwdt.c
> @@ -0,0 +1,215 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Window watchdog device driver for Xilinx Versal WWDT
> + *
> + * Copyright (C) 2022 - 2023, Advanced Micro Devices, Inc.
> + */
> +
> +#include <linux/clk.h>
> +#include <linux/interrupt.h>
> +#include <linux/io.h>
> +#include <linux/ioport.h>
> +#include <linux/module.h>
> +#include <linux/of_device.h>
> +#include <linux/of_address.h>
> +#include <linux/watchdog.h>
> +
> +#define XWWDT_DEFAULT_TIMEOUT	40
> +#define XWWDT_MIN_TIMEOUT	1
> +
> +/* Register offsets for the WWDT device */
> +#define XWWDT_MWR_OFFSET	0x00
> +#define XWWDT_ESR_OFFSET	0x04
> +#define XWWDT_FCR_OFFSET	0x08
> +#define XWWDT_FWR_OFFSET	0x0c
> +#define XWWDT_SWR_OFFSET	0x10
> +
> +/* Master Write Control Register Masks */
> +#define XWWDT_MWR_MASK		BIT(0)
> +
> +/* Enable and Status Register Masks */
> +#define XWWDT_ESR_WINT_MASK	BIT(16)
> +#define XWWDT_ESR_WSW_MASK	BIT(8)
> +#define XWWDT_ESR_WEN_MASK	BIT(0)
> +
> +#define XWWDT_CLOSE_WINDOW_PERCENT	50
> +
> +static int xwwdt_timeout;
> +static int xclosed_window_percent;
> +
> +module_param(xwwdt_timeout, int, 0);
> +MODULE_PARM_DESC(xwwdt_timeout,
> +		 "Watchdog time in seconds. (default="
> +		 __MODULE_STRING(XWWDT_DEFAULT_TIMEOUT) ")");
> +module_param(xclosed_window_percent, int, 0);
> +MODULE_PARM_DESC(xclosed_window_percent,
> +		 "Watchdog closed window percentage. (default="
> +		 __MODULE_STRING(XWWDT_CLOSE_WINDOW_PERCENT) ")");

The prefixes for those module parameters are really unnecessary.

> +/**
> + * struct xwwdt_device - Watchdog device structure
> + * @base: base io address of WDT device
> + * @spinlock: spinlock for IO register access
> + * @xilinx_wwdt_wdd: watchdog device structure
> + * @freq: source clock frequency of WWDT
> + * @close_percent: Closed window percent
> + */
> +struct xwwdt_device {
> +	void __iomem *base;
> +	spinlock_t spinlock; /* spinlock for register handling */
> +	struct watchdog_device xilinx_wwdt_wdd;
> +	unsigned long freq;
> +	u32 close_percent;
> +};
> +
> +static int xilinx_wwdt_start(struct watchdog_device *wdd)
> +{
> +	struct xwwdt_device *xdev = watchdog_get_drvdata(wdd);
> +	struct watchdog_device *xilinx_wwdt_wdd = &xdev->xilinx_wwdt_wdd;
> +	u64 time_out, closed_timeout, open_timeout;
> +	u32 control_status_reg;
> +
> +	/* Calculate timeout count */
> +	time_out = xdev->freq * wdd->timeout;
> +
> +	if (xdev->close_percent && xdev->close_percent < 100) {
> +		closed_timeout = (time_out * xdev->close_percent) / 100;
> +		open_timeout = time_out - closed_timeout;
> +		wdd->min_hw_heartbeat_ms = xdev->close_percent * 10 * wdd->timeout;
> +	} else {
> +		/* Calculate XWWDT_CLOSE_WINDOW_PERCENT of timeout */
> +		time_out *= XWWDT_CLOSE_WINDOW_PERCENT;
> +		time_out /= 100;
> +		wdd->min_hw_heartbeat_ms = XWWDT_CLOSE_WINDOW_PERCENT * 10 * wdd->timeout;
> +	}

Why not set close_percent to the default value in the probe function
if it is not provided as module parameter ?

> +
> +	spin_lock(&xdev->spinlock);
> +
> +	iowrite32(XWWDT_MWR_MASK, xdev->base + XWWDT_MWR_OFFSET);
> +	iowrite32(~(u32)XWWDT_ESR_WEN_MASK, xdev->base + XWWDT_ESR_OFFSET);
> +
> +	if (xdev->close_percent && xdev->close_percent < 100) {

This should really be validated once in the probe function.
The provided value should always be valid here.

> +		iowrite32((u32)closed_timeout, xdev->base + XWWDT_FWR_OFFSET);
> +		iowrite32((u32)open_timeout, xdev->base + XWWDT_SWR_OFFSET);
> +	} else {
> +		/* Configure closed and open windows with XWWDT_CLOSE_WINDOW_PERCENT of timeout */
> +		iowrite32((u32)time_out, xdev->base + XWWDT_FWR_OFFSET);
> +		iowrite32((u32)time_out, xdev->base + XWWDT_SWR_OFFSET);
> +	}
> +
> +	/* Enable the window watchdog timer */
> +	control_status_reg = ioread32(xdev->base + XWWDT_ESR_OFFSET);
> +	control_status_reg |= XWWDT_ESR_WEN_MASK;
> +	iowrite32(control_status_reg, xdev->base + XWWDT_ESR_OFFSET);
> +
> +	spin_unlock(&xdev->spinlock);
> +
> +	dev_dbg(xilinx_wwdt_wdd->parent, "Watchdog Started!\n");
> +
> +	return 0;
> +}
> +
> +static int xilinx_wwdt_keepalive(struct watchdog_device *wdd)
> +{
> +	struct xwwdt_device *xdev = watchdog_get_drvdata(wdd);
> +	u32 control_status_reg;
> +
> +	spin_lock(&xdev->spinlock);
> +
> +	/* Enable write access control bit for the window watchdog */
> +	iowrite32(XWWDT_MWR_MASK, xdev->base + XWWDT_MWR_OFFSET);
> +
> +	/* Trigger restart kick to watchdog */
> +	control_status_reg = ioread32(xdev->base + XWWDT_ESR_OFFSET);
> +	control_status_reg |= XWWDT_ESR_WSW_MASK;
> +	iowrite32(control_status_reg, xdev->base + XWWDT_ESR_OFFSET);
> +
> +	spin_unlock(&xdev->spinlock);
> +
> +	return 0;
> +}
> +
> +static const struct watchdog_info xilinx_wwdt_ident = {
> +	.options = WDIOF_KEEPALIVEPING |
> +		WDIOF_SETTIMEOUT,
> +	.firmware_version = 1,
> +	.identity = "xlnx_window watchdog",
> +};
> +
> +static const struct watchdog_ops xilinx_wwdt_ops = {
> +	.owner = THIS_MODULE,
> +	.start = xilinx_wwdt_start,
> +	.ping = xilinx_wwdt_keepalive,
> +};
> +
> +static int xwwdt_probe(struct platform_device *pdev)
> +{
> +	struct watchdog_device *xilinx_wwdt_wdd;
> +	struct device *dev = &pdev->dev;
> +	struct xwwdt_device *xdev;
> +	struct clk *clk;
> +	int ret;
> +
> +	xdev = devm_kzalloc(dev, sizeof(*xdev), GFP_KERNEL);
> +	if (!xdev)
> +		return -ENOMEM;
> +
> +	xilinx_wwdt_wdd = &xdev->xilinx_wwdt_wdd;
> +	xilinx_wwdt_wdd->info = &xilinx_wwdt_ident;
> +	xilinx_wwdt_wdd->ops = &xilinx_wwdt_ops;
> +	xilinx_wwdt_wdd->parent = dev;
> +
> +	xdev->base = devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(xdev->base))
> +		return PTR_ERR(xdev->base);
> +
> +	clk = devm_clk_get_enabled(dev, NULL);
> +	if (IS_ERR(clk))
> +		return PTR_ERR(clk);
> +
> +	xdev->freq = clk_get_rate(clk);
> +	if (!xdev->freq)
> +		return -EINVAL;
> +
> +	xilinx_wwdt_wdd->timeout = XWWDT_DEFAULT_TIMEOUT;
> +	xilinx_wwdt_wdd->min_timeout = XWWDT_MIN_TIMEOUT;
> +	xilinx_wwdt_wdd->max_hw_heartbeat_ms = 1000 * xilinx_wwdt_wdd->timeout;

Is it indeed correct that the maximum timeout supported
by the hardware is XWWDT_DEFAULT_TIMEOUT, ie 40 seconds ?

> +	xdev->close_percent = xclosed_window_percent;
> +
> +	ret = watchdog_init_timeout(xilinx_wwdt_wdd,
> +				    xwwdt_timeout, &pdev->dev);
> +	if (ret)
> +		dev_info(&pdev->dev, "Configured default timeout value\n");

Isn't that a bit redundant with the message below ?

> +
> +	spin_lock_init(&xdev->spinlock);
> +	watchdog_set_drvdata(xilinx_wwdt_wdd, xdev);
> +	watchdog_set_nowayout(xilinx_wwdt_wdd, WATCHDOG_NOWAYOUT);
> +
> +	ret = devm_watchdog_register_device(dev, xilinx_wwdt_wdd);
> +	if (ret)
> +		return ret;
> +
> +	dev_info(dev, "Xilinx window watchdog Timer with timeout %ds\n",
> +		 xilinx_wwdt_wdd->timeout);
> +
> +	return 0;
> +}
> +
> +static const struct of_device_id xwwdt_of_match[] = {
> +	{ .compatible = "xlnx,versal-wwdt", },
> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, xwwdt_of_match);
> +
> +static struct platform_driver xwwdt_driver = {
> +	.probe = xwwdt_probe,
> +	.driver = {
> +		.name = "Xilinx window watchdog",
> +		.of_match_table = xwwdt_of_match,
> +	},
> +};
> +
> +module_platform_driver(xwwdt_driver);
> +
> +MODULE_AUTHOR("Neeli Srinivas <srinivas.neeli@amd.com>");
> +MODULE_DESCRIPTION("Xilinx window watchdog driver");
> +MODULE_LICENSE("GPL");
