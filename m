Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D154F6A734A
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 19:17:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229525AbjCASRy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 13:17:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbjCASRv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 13:17:51 -0500
Received: from smtp.smtpout.orange.fr (smtp-25.smtpout.orange.fr [80.12.242.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D203B34020
        for <linux-kernel@vger.kernel.org>; Wed,  1 Mar 2023 10:17:48 -0800 (PST)
Received: from [192.168.1.18] ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id XR1IphQCnyrvBXR1IptlD8; Wed, 01 Mar 2023 19:17:45 +0100
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Wed, 01 Mar 2023 19:17:45 +0100
X-ME-IP: 86.243.2.178
Message-ID: <3da08274-5a7c-6f0e-d093-508494de0c1f@wanadoo.fr>
Date:   Wed, 1 Mar 2023 19:17:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH V2 3/4] watchdog: xilinx_wwdt: Add Versal window watchdog
 support
To:     Srinivas Neeli <srinivas.neeli@amd.com>, linux@roeck-us.net,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        michal.simek@amd.com, neelisrinivas18@gmail.com
Cc:     wim@linux-watchdog.org, linux-watchdog@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        git@xilinx.com, git@amd.com, devicetree@vger.kernel.org
References: <20230301175229.342004-1-srinivas.neeli@amd.com>
 <20230301175229.342004-4-srinivas.neeli@amd.com>
Content-Language: fr
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20230301175229.342004-4-srinivas.neeli@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 01/03/2023 à 18:52, Srinivas Neeli a écrit :
> Versal watchdog driver uses window watchdog mode. Window watchdog
> timer(WWDT) contains closed(first) and open(second) window with
> 32 bit width. Write to the watchdog timer within predefined window
> periods of time. This means a period that is not too soon and a
> period that is not too late. The WWDT has to be restarted within
> the open window time. If software tries to restart WWDT outside of
> the open window time period, it generates a reset.
> 
> Signed-off-by: Srinivas Neeli <srinivas.neeli@amd.com>

Hi,

a few nits below.

> ---
> Changes in V2:
> - Takes "xlnx,close-percent" property from device tree parameter.
> - Removed clk_disable() function.
> - Removed module parameter permisions and using readomly.
> - Added check for close_percent( 0 < close_perecent < 100).
> - Updated other minor comments.
> ---
>   drivers/watchdog/Kconfig       |  18 +++
>   drivers/watchdog/Makefile      |   1 +
>   drivers/watchdog/xilinx_wwdt.c | 232 +++++++++++++++++++++++++++++++++
>   3 files changed, 251 insertions(+)
>   create mode 100644 drivers/watchdog/xilinx_wwdt.c
> 
> diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
> index f0872970daf9..ec4b522ae29e 100644
> --- a/drivers/watchdog/Kconfig
> +++ b/drivers/watchdog/Kconfig
> @@ -304,6 +304,24 @@ config XILINX_WATCHDOG
>   	  To compile this driver as a module, choose M here: the
>   	  module will be called of_xilinx_wdt.
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
>   config ZIIRAVE_WATCHDOG
>   	tristate "Zodiac RAVE Watchdog Timer"
>   	depends on I2C
> diff --git a/drivers/watchdog/Makefile b/drivers/watchdog/Makefile
> index 9cbf6580f16c..6cb5f1dfb492 100644
> --- a/drivers/watchdog/Makefile
> +++ b/drivers/watchdog/Makefile
> @@ -157,6 +157,7 @@ obj-$(CONFIG_M54xx_WATCHDOG) += m54xx_wdt.o
>   
>   # MicroBlaze Architecture
>   obj-$(CONFIG_XILINX_WATCHDOG) += of_xilinx_wdt.o
> +obj-$(CONFIG_XILINX_WINDOW_WATCHDOG) += xilinx_wwdt.o
>   
>   # MIPS Architecture
>   obj-$(CONFIG_ATH79_WDT) += ath79_wdt.o
> diff --git a/drivers/watchdog/xilinx_wwdt.c b/drivers/watchdog/xilinx_wwdt.c
> new file mode 100644
> index 000000000000..5b50376d1474
> --- /dev/null
> +++ b/drivers/watchdog/xilinx_wwdt.c
> @@ -0,0 +1,232 @@
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
> +#define XWWDT_CLOSE_WINDOW_PERCENT		50
> +
> +static int xwwdt_timeout;
> +
> +module_param(xwwdt_timeout, int, 0);
> +MODULE_PARM_DESC(xwwdt_timeout,
> +		 "Watchdog time in seconds. (default="
> +		 __MODULE_STRING(XWWDT_DEFAULT_TIMEOUT) ")");
> +
> +/**
> + * struct xwwdt_device - Watchdog device structure
> + * @base: base io address of WDT device
> + * @spinlock: spinlock for IO register access
> + * @xilinx_wwdt_wdd: watchdog device structure
> + * @clk: struct clk * of a clock source
> + * @freq: source clock frequency of WWDT
> + * @close_percent : Closed window percent
                     ~
extra space?

> + */
> +struct xwwdt_device {
> +	void __iomem *base;
> +	spinlock_t spinlock; /* spinlock for register handling */
> +	struct watchdog_device xilinx_wwdt_wdd;
> +	struct clk *clk;

Is clk needed here?
(see other comment below that explain why)

> +	unsigned long	freq;

                      ~~~
extra spaces?

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
> +
> +	spin_lock(&xdev->spinlock);
> +
> +	iowrite32(XWWDT_MWR_MASK, xdev->base + XWWDT_MWR_OFFSET);
> +	iowrite32(~(u32)XWWDT_ESR_WEN_MASK, xdev->base + XWWDT_ESR_OFFSET);
> +
> +	if (xdev->close_percent && xdev->close_percent < 100) {
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
> +static void xwwdt_clk_disable_unprepare(void *data)
> +{
> +	clk_disable_unprepare(data);
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
> +	xdev->clk = devm_clk_get(dev, NULL);
> +	if (IS_ERR(xdev->clk))
> +		return PTR_ERR(xdev->clk);

devm_clk_get_enabled() could also be used here.
It saves clk_prepare_enable(), devm_add_action_or_reset() and 
xwwdt_clk_disable_unprepare(), and maybe even clk.

Several watchdog drivers have been updated this way a few weeks ago.

CJ

> +
> +	xdev->freq = clk_get_rate(xdev->clk);
> +	if (!xdev->freq)
> +		return -EINVAL;
> +
> +	ret = clk_prepare_enable(xdev->clk);
> +	if (ret) {
> +		dev_err(dev, "unable to enable clock\n");
> +		return ret;
> +	}
> +
> +	ret = devm_add_action_or_reset(dev, xwwdt_clk_disable_unprepare,
> +				       xdev->clk);
> +	if (ret)
> +		return ret;
> +
> +	ret = of_property_read_u32(dev->of_node, "xlnx,close-percent",
> +				   &xdev->close_percent);
> +	if (ret)
> +		xdev->close_percent = XWWDT_CLOSE_WINDOW_PERCENT;
> +
> +	xilinx_wwdt_wdd->timeout = XWWDT_DEFAULT_TIMEOUT;
> +	xilinx_wwdt_wdd->min_timeout = XWWDT_MIN_TIMEOUT;
> +	xilinx_wwdt_wdd->max_hw_heartbeat_ms = 1000 * xilinx_wwdt_wdd->timeout;
> +
> +	ret = watchdog_init_timeout(xilinx_wwdt_wdd,
> +				    xwwdt_timeout, &pdev->dev);
> +	if (ret)
> +		dev_info(&pdev->dev, "Configured default timeout value\n");
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

