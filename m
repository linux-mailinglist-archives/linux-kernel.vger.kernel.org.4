Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F03B715EA3
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 14:14:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231314AbjE3MOh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 08:14:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbjE3MOf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 08:14:35 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AAB8B0;
        Tue, 30 May 2023 05:14:34 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id 41be03b00d2f7-528cdc9576cso2740999a12.0;
        Tue, 30 May 2023 05:14:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685448873; x=1688040873;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GUAHLyW4Mwa10E5lGR45u2QHobFCtv0ae9zjpfWR6zY=;
        b=o8ERgmqSntcl941jaBm/+Wir08wTJRTo7hXwf6R5foHOu+8iuxjMpFbOmMdKPIJzHH
         QL9+TN4pxk3Wn0e/OaZP2wCDfZSLPULldEjiXSHM0gOrUdDLOuArD1SVPaXvRKZPbgmK
         Mqa0P6iv7GFiSfPWhPQ948171+Ahw4DnIR7mMlhmyqqPv85a33UmSlv6bU1pLrLsoWdL
         W3Mb9S27XPl70Brfxfd0h3STxoL+AhMif/Kuktw+v8+THh66ioNdmwWQKRSefRcllFbd
         jLF3Fs+4MBSTNWtVEkRwUK2xaRwGJI2gpVdEi6Oo3peKiNcd1BRd1Ivnhz4xQIxblIbm
         Pexg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685448873; x=1688040873;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GUAHLyW4Mwa10E5lGR45u2QHobFCtv0ae9zjpfWR6zY=;
        b=YkuE0zK3CpiW3ja10CChX/saqMHdgFcAJtnujAUyyx8Yiyk5qkfneWdR39FD/7rKYP
         b6Qp/kp4ryxxvBn8NEKhgZin9B6sruBneGOgZS45+9YCNkaSSTW1cHHCYLjfJrcMaenI
         pIM63FE2gbh6Q4pCIlRihLvz2ktFI1C8LtAsU5PizApJHUKn7lYEnZFJXNJM8Tu+zXqw
         RzesBE2didLO6GZu70RnvLZU4WMuMChO++YqzEwq+NIMCgL2LuMUWTghUbk8zwqgwKqh
         cdhv9xm36ImltoYrYpRApTPCGTb/Gw0+sI4YpEywUNlVDmqvnV2B9Go435te8y6B8ndr
         QUlw==
X-Gm-Message-State: AC+VfDwraEroW/veilGq/+aAvTw5qOXLNAGtctqNS6/poGrB9pAAFuP2
        cazhglJsii9tBzah2giRRAc=
X-Google-Smtp-Source: ACHHUZ4JPwBRHhguNQ5FpIMAGUyPIbYwjeJQdom4zA6Cks836J9NNHktXoKZTf++erAnZyxHUjGRZw==
X-Received: by 2002:a17:903:11c9:b0:1ae:2e0d:b38c with SMTP id q9-20020a17090311c900b001ae2e0db38cmr2807673plh.12.1685448873540;
        Tue, 30 May 2023 05:14:33 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id c10-20020a170903234a00b001ab2b4105ddsm10173599plh.60.2023.05.30.05.14.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 May 2023 05:14:32 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Tue, 30 May 2023 05:14:31 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Srinivas Neeli <srinivas.neeli@amd.com>
Cc:     shubhrajyoti.datta@amd.com, michal.simek@amd.com,
        srinivas.goud@amd.com, wim@linux-watchdog.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-watchdog@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, git@amd.com, git@xilinx.com,
        neelisrinivas18@gmail.com
Subject: Re: [PATCH V4 3/4] watchdog: xilinx_wwdt: Add Versal window watchdog
 support
Message-ID: <e53c8e09-2ea6-4ce7-a5fa-811c7b3dd838@roeck-us.net>
References: <20230420104231.2243079-1-srinivas.neeli@amd.com>
 <20230420104231.2243079-4-srinivas.neeli@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230420104231.2243079-4-srinivas.neeli@amd.com>
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

On Thu, Apr 20, 2023 at 04:12:30PM +0530, Srinivas Neeli wrote:
> Versal watchdog driver uses window watchdog mode. Window watchdog
> timer(WWDT) contains closed(first) and open(second) window with
> 32 bit width. Write to the watchdog timer within predefined window
> periods of time. This means a period that is not too soon and a
> period that is not too late. The WWDT has to be restarted within
> the open window time. If software tries to restart WWDT outside of
> the open window time period, it generates a reset.
> 
> Signed-off-by: Srinivas Neeli <srinivas.neeli@amd.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
> Changes in V4:
> -Maximum timeout value calculated at 100Mhz source clock. This value
>  vary depending on the source clock to IP.
> -Removed module parameters prefix("x").
> -Moved closed window percent check to the probe fucntion and updated
>  dependent code.
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
>  drivers/watchdog/xilinx_wwdt.c | 201 +++++++++++++++++++++++++++++++++
>  3 files changed, 220 insertions(+)
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
> index 000000000000..2585038d5575
> --- /dev/null
> +++ b/drivers/watchdog/xilinx_wwdt.c
> @@ -0,0 +1,201 @@
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
> +/* Max timeout is calculated at 100MHz source clock */
> +#define XWWDT_DEFAULT_TIMEOUT	42
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
> +static int wwdt_timeout;
> +static int closed_window_percent;
> +
> +module_param(wwdt_timeout, int, 0);
> +MODULE_PARM_DESC(wwdt_timeout,
> +		 "Watchdog time in seconds. (default="
> +		 __MODULE_STRING(XWWDT_DEFAULT_TIMEOUT) ")");
> +module_param(closed_window_percent, int, 0);
> +MODULE_PARM_DESC(closed_window_percent,
> +		 "Watchdog closed window percentage. (default="
> +		 __MODULE_STRING(XWWDT_CLOSE_WINDOW_PERCENT) ")");
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
> +	closed_timeout = (time_out * xdev->close_percent) / 100;
> +	open_timeout = time_out - closed_timeout;
> +	wdd->min_hw_heartbeat_ms = xdev->close_percent * 10 * wdd->timeout;
> +
> +	spin_lock(&xdev->spinlock);
> +
> +	iowrite32(XWWDT_MWR_MASK, xdev->base + XWWDT_MWR_OFFSET);
> +	iowrite32(~(u32)XWWDT_ESR_WEN_MASK, xdev->base + XWWDT_ESR_OFFSET);
> +	iowrite32((u32)closed_timeout, xdev->base + XWWDT_FWR_OFFSET);
> +	iowrite32((u32)open_timeout, xdev->base + XWWDT_SWR_OFFSET);
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
> +	xilinx_wwdt_wdd->min_timeout = XWWDT_MIN_TIMEOUT;
> +	xilinx_wwdt_wdd->timeout = XWWDT_DEFAULT_TIMEOUT;
> +	xilinx_wwdt_wdd->max_hw_heartbeat_ms = 1000 * xilinx_wwdt_wdd->timeout;
> +
> +	if (closed_window_percent == 0 || closed_window_percent >= 100)
> +		xdev->close_percent = XWWDT_CLOSE_WINDOW_PERCENT;
> +	else
> +		xdev->close_percent = closed_window_percent;
> +
> +	watchdog_init_timeout(xilinx_wwdt_wdd, wwdt_timeout, &pdev->dev);
> +	spin_lock_init(&xdev->spinlock);
> +	watchdog_set_drvdata(xilinx_wwdt_wdd, xdev);
> +	watchdog_set_nowayout(xilinx_wwdt_wdd, 1);
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
> -- 
> 2.25.1
> 
