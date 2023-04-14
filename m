Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1661B6E25D7
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 16:34:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230351AbjDNOer (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 10:34:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbjDNOep (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 10:34:45 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F55BBB8E;
        Fri, 14 Apr 2023 07:34:41 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-63b4a64c72bso410060b3a.0;
        Fri, 14 Apr 2023 07:34:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681482881; x=1684074881;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AwrWdHvHT8Xj1AFCQgklwLawGZOz7vHq/1obf/6FJ94=;
        b=HqmOEIyRSB0nOr61tYz3PrrMzKP1JNsJOTq6xKSm+SCOlV7spopp7niNkKZ88cNeF4
         tpixlH9w4dKKdGXlZTWCS/dBnH01+Cg/lRGj9T62Pvm8HpvjQfsokyr6KfzRJwlqPoeB
         hRhZTkDsP3+rSdGE48E8TOdt64Fa+AIQDEvrfo8tVWkcHL0zbxR/+1EroDBM33bxMyo+
         8Er23ofxjzWbDvUGe6YJbq5BlyBZX4EgRBEpeCopBXk3y/77sYwJPgU0ppdByaNqmcuW
         Vu1zyFL8xMMO/q5M219Tbo2kWueweyDNHTx9yaZWLnaB5u3YBJ42T6ji45AqwBZNAsA0
         Hd0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681482881; x=1684074881;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AwrWdHvHT8Xj1AFCQgklwLawGZOz7vHq/1obf/6FJ94=;
        b=RuVKeAFt810GtLF9AhfjuPmfsnUP6g2tX2LkdOFTgHlcZ7XnEFKHSeLiC5/SoKCLIZ
         3vayhv512xcZqLcUAJo9yL5bGtOdk4riflM44p/OhXgm+bzCLDdVmLpH+QevDOPV5Yq6
         SKCTVConn8/xxvBSFi9loOeCWXihBwVLNCe0mILI1vrrh/XL+2dmctXJ3mu0A1oGpA8+
         ZBdSctfv2cvjlJU+R0LfmzmQeMShSievuedwtlf1lp1Fx3SSYmaC1d/2PpYmiXprjF/b
         a28naCdzbcrw5ED9RQVVpIuz0pmxHnm320yiFKbZgWdzvOwvsn1uMNFh6cGRX923xN/y
         mMig==
X-Gm-Message-State: AAQBX9c4O1j/h2gA8QHmkS7jnhqJJ4JmgN1Ig5iyPyCqKOD2IWCF/LbI
        RIDo2FlewiBgnjOPO9HGPFw=
X-Google-Smtp-Source: AKy350ZGXI5+xRHtBEdU9aVDIxXixw9g+IjG8F5JcAMNXS2t+dy6uNGgQvcG1YRmNe0bWaRLjh/Atg==
X-Received: by 2002:a05:6a00:2401:b0:626:2ce1:263c with SMTP id z1-20020a056a00240100b006262ce1263cmr8192185pfh.5.1681482880767;
        Fri, 14 Apr 2023 07:34:40 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id z5-20020aa791c5000000b0062e00158bf4sm3094676pfa.208.2023.04.14.07.34.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Apr 2023 07:34:39 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Fri, 14 Apr 2023 07:34:38 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Bharat Bhushan <bbhushan2@marvell.com>
Cc:     wim@linux-watchdog.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-watchdog@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] Watchdog: Add octeontx2 GTI watchdog driver
Message-ID: <b3087a0c-d079-4ccb-8202-593abb4a4d44@roeck-us.net>
References: <20230414102342.23696-1-bbhushan2@marvell.com>
 <20230414102342.23696-2-bbhushan2@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230414102342.23696-2-bbhushan2@marvell.com>
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

On Fri, Apr 14, 2023 at 03:53:42PM +0530, Bharat Bhushan wrote:
> GTI watchdog timer are programmed in "interrupt + del3t + reset mode"
> and del3t traps are not enabled.
> GTI watchdog exception flow is:
>  - 1st timer expiration generates watchdog interrupt.
>  - 2nd timer expiration is ignored
>  - On 3rd timer expiration will trigger a system-wide core reset.
> 

This means the interrupt should not result in a panic, the programmed 
timeout value should be considered a pretimeout which is set to (timeout
/ 3), and the interrupt handler should call watchdog_notify_pretimeout().

Either case, the above should be documented in the driver but does not
make much if any sense as patch description. If not, what are the other
modes, and why is this mode used instead of any of those modes ?

> Signed-off-by: Bharat Bhushan <bbhushan2@marvell.com>
> ---
>  drivers/watchdog/Kconfig         |   9 ++
>  drivers/watchdog/Makefile        |   1 +
>  drivers/watchdog/octeontx2_wdt.c | 238 +++++++++++++++++++++++++++++++
>  3 files changed, 248 insertions(+)
>  create mode 100644 drivers/watchdog/octeontx2_wdt.c
> 
> diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
> index f0872970daf9..31ff282c62ad 100644
> --- a/drivers/watchdog/Kconfig
> +++ b/drivers/watchdog/Kconfig
> @@ -2212,4 +2212,13 @@ config KEEMBAY_WATCHDOG
>  	  To compile this driver as a module, choose M here: the
>  	  module will be called keembay_wdt.
>  
> +config OCTEONTX2_WATCHDOG
> +	tristate "OCTEONTX2 Watchdog driver"
> +	depends on ARCH_THUNDER || (COMPILE_TEST && 64BIT)
> +	help
> +	 OCTEONTX2 GTI hardware supports watchdog timer. This watchdog timer are
> +	 programmed in "interrupt + del3t + reset" mode. On first expiry it will
> +	 generate interrupt. Second expiry (del3t) is ignored and system will reset
> +	 on final timer expiry.
> +

The above should be part of the in-driver documentation but those details
should not be in Kconfig.

Is the documentation available in public ? I'd like to check if this mode,
especially the ignored del3t mode, really makes sense.

>  endif # WATCHDOG
> diff --git a/drivers/watchdog/Makefile b/drivers/watchdog/Makefile
> index 9cbf6580f16c..aa1b813ad1f9 100644
> --- a/drivers/watchdog/Makefile
> +++ b/drivers/watchdog/Makefile
> @@ -230,3 +230,4 @@ obj-$(CONFIG_MENZ069_WATCHDOG) += menz69_wdt.o
>  obj-$(CONFIG_RAVE_SP_WATCHDOG) += rave-sp-wdt.o
>  obj-$(CONFIG_STPMIC1_WATCHDOG) += stpmic1_wdt.o
>  obj-$(CONFIG_SL28CPLD_WATCHDOG) += sl28cpld_wdt.o
> +obj-$(CONFIG_OCTEONTX2_WATCHDOG) += octeontx2_wdt.o
> diff --git a/drivers/watchdog/octeontx2_wdt.c b/drivers/watchdog/octeontx2_wdt.c
> new file mode 100644
> index 000000000000..7b78a092e83f
> --- /dev/null
> +++ b/drivers/watchdog/octeontx2_wdt.c
> @@ -0,0 +1,238 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Marvell Octeontx2 Watchdog driver
> + *
> + * Copyright (C) 2023 Marvell International Ltd.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#include <linux/module.h>
> +#include <linux/cpu.h>
> +#include <linux/interrupt.h>
> +#include <linux/of_platform.h>
> +#include <linux/platform_device.h>
> +#include <linux/watchdog.h>
> +#include <linux/sched/debug.h>

What is this include for ?

> +
> +#include <asm/arch_timer.h>
> +
> +/* GTI CWD Watchdog Registers */
> +#define GTI_CWD_GLOBAL_WDOG_IDX		63
> +#define GTI_CWD_WDOG			(0x8 * GTI_CWD_GLOBAL_WDOG_IDX)
> +#define GTI_CWD_WDOG_MODE_INT_DEL3T_RST	0x3
> +#define GTI_CWD_WDOG_MODE_MASK		0x3
> +#define GTI_CWD_WDOG_LEN_SHIFT		4
> +#define GTI_CWD_WDOG_CNT_SHIFT		20
> +
> +/* GTI Per-core Watchdog Interrupt Register */
> +#define GTI_CWD_INT			0x200
> +#define GTI_CWD_INT_PENDING_STATUS	(1ULL << GTI_CWD_GLOBAL_WDOG_IDX)
> +
> +/* GTI Per-core Watchdog Interrupt Enable Clear Register */
> +#define GTI_CWD_INT_ENA_CLR		0x210
> +#define GTI_CWD_INT_ENA_CLR_VAL		(1ULL << GTI_CWD_GLOBAL_WDOG_IDX)
> +
> +/* GTI Per-core Watchdog Interrupt Enable Set Register */
> +#define GTI_CWD_INT_ENA_SET		0x218
> +#define GTI_CWD_INT_ENA_SET_VAL		(1ULL << GTI_CWD_GLOBAL_WDOG_IDX)
> +
> +/* GTI Per-core Watchdog Poke Registers */
> +#define GTI_CWD_POKE		(0x10000 + 0x8 * GTI_CWD_GLOBAL_WDOG_IDX)
> +#define GTI_CWD_POKE_VAL	(1ULL << GTI_CWD_GLOBAL_WDOG_IDX)
> +
> +struct octeontx2_wdt_priv {
> +	struct watchdog_device wdev;
> +	void __iomem *base;
> +	u64 clock_freq;
> +	int irq;
> +};
> +
> +static irqreturn_t octeontx2_wdt_interrupt(int irq, void *data)
> +{
> +	panic("Kernel Watchdog");
> +	return IRQ_HANDLED;
> +}
> +
> +static int octeontx2_wdt_ping(struct watchdog_device *wdev)
> +{
> +	struct octeontx2_wdt_priv *priv = watchdog_get_drvdata(wdev);
> +
> +	writeq(GTI_CWD_POKE_VAL, priv->base + GTI_CWD_POKE);
> +	return 0;
> +}
> +
> +static int octeontx2_wdt_start(struct watchdog_device *wdev)
> +{
> +	struct octeontx2_wdt_priv *priv = watchdog_get_drvdata(wdev);
> +	u64 regval;
> +
> +	set_bit(WDOG_HW_RUNNING, &wdev->status);
> +
> +	/* Clear any pending interrupt */
> +	writeq(GTI_CWD_INT_PENDING_STATUS, priv->base + GTI_CWD_INT);
> +
> +	/* Enable Interrupt */
> +	writeq(GTI_CWD_INT_ENA_SET_VAL, priv->base + GTI_CWD_INT_ENA_SET);
> +
> +	/* Set (Interrupt + SCP interrupt (DEL3T) + core domain reset) Mode */
> +	regval = readq(priv->base + GTI_CWD_WDOG);
> +	regval |= GTI_CWD_WDOG_MODE_INT_DEL3T_RST;
> +	writeq(regval, priv->base + GTI_CWD_WDOG);
> +
> +	return 0;
> +}
> +
> +static int octeontx2_wdt_stop(struct watchdog_device *wdev)
> +{
> +	struct octeontx2_wdt_priv *priv = watchdog_get_drvdata(wdev);
> +	u64 regval;
> +
> +	/* Disable Interrupt */
> +	writeq(GTI_CWD_INT_ENA_CLR_VAL, priv->base + GTI_CWD_INT_ENA_CLR);
> +
> +	/* Set GTI_CWD_WDOG.Mode = 0 to stop the timer */
> +	regval = readq(priv->base + GTI_CWD_WDOG);
> +	regval &= ~GTI_CWD_WDOG_MODE_MASK;
> +	writeq(regval, priv->base + GTI_CWD_WDOG);
> +
> +	return 0;
> +}
> +
> +static int octeontx2_wdt_settimeout(struct watchdog_device *wdev,
> +					unsigned int timeout)
> +{
> +	struct octeontx2_wdt_priv *priv = watchdog_get_drvdata(wdev);
> +	u64 timeout_wdog, regval;
> +
> +	/* Update new timeout */
> +	wdev->timeout = timeout;
> +
> +	/* Get clock cycles from timeout in second */
> +	timeout_wdog = (u64)timeout * priv->clock_freq;
> +
> +	/* Watchdog counts in 1024 cycle steps */
> +	timeout_wdog = timeout_wdog >> 10;
> +
> +	/*
> +	 * Hardware allows programming of upper 16-bits of 24-bits cycles
> +	 * Round up and use upper 16-bits only.
> +	 * Set max if timeout more than h/w supported

This should be covered when setting max_timeout or max_hw_heartbeat_ms.
Setting the actual timeout to a value smaller than configured may result
in the watchdog firing before its configured timeout expires.

> +	 */
> +	timeout_wdog = (timeout_wdog + 0xff) >> 8;
> +	if (timeout_wdog >= 0x10000)
> +		timeout_wdog = 0xffff;
> +
> +	/*
> +	 * GTI_CWD_WDOG.LEN have only upper 16-bits of 24-bits
> +	 * GTI_CWD_WDOG.CNT, need addition shift of 8.
> +	 */
> +	regval = readq(priv->base + GTI_CWD_WDOG);
> +	regval &= GTI_CWD_WDOG_MODE_MASK;
> +	regval |= ((timeout_wdog) << (GTI_CWD_WDOG_CNT_SHIFT + 8)) |
> +		   (timeout_wdog << GTI_CWD_WDOG_LEN_SHIFT);

() around timeout is unnecessary. Why does the timeout need to be
programmed twice into the register ? The shift values are odd.
Are you sure this does what you expect it to do ?

> +	writeq(regval, priv->base + GTI_CWD_WDOG);
> +	return 0;
> +}
> +
> +static const struct watchdog_info octeontx2_wdt_ident = {
> +	.identity = "OcteonTX2 watchdog",
> +	.options	= WDIOF_SETTIMEOUT | WDIOF_KEEPALIVEPING | WDIOF_MAGICCLOSE |
> +			  WDIOF_CARDRESET,
> +};
> +
> +static const struct watchdog_ops octeontx2_wdt_ops = {
> +	.owner = THIS_MODULE,
> +	.start = octeontx2_wdt_start,
> +	.stop = octeontx2_wdt_stop,
> +	.ping = octeontx2_wdt_ping,
> +	.set_timeout = octeontx2_wdt_settimeout,
> +};
> +
> +static int octeontx2_wdt_probe(struct platform_device *pdev)
> +{
> +	struct octeontx2_wdt_priv *priv;
> +	struct device *dev = &pdev->dev;
> +	struct watchdog_device *wdog_dev;
> +	int irq;
> +	int err;
> +
> +	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
> +	if (!priv)
> +		return -ENOMEM;
> +
> +	priv->base = devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(priv->base))
> +		return dev_err_probe(&pdev->dev, PTR_ERR(priv->base),
> +			      "reg property not valid/found\n");
> +
> +	priv->clock_freq = arch_timer_get_cntfrq();
> +
> +	wdog_dev = &priv->wdev;
> +	wdog_dev->info = &octeontx2_wdt_ident,
> +	wdog_dev->ops = &octeontx2_wdt_ops,
> +	wdog_dev->parent = dev;
> +	wdog_dev->min_timeout = 1;
> +	wdog_dev->max_timeout = 16;

Setting max_timeout makes max_hw_heartbeat_ms useless. Use only
max_hw_heartbeat_ms to enable larger soft timeouts, or use only
max_timeout to set the hard limit, but not both.

> +	wdog_dev->max_hw_heartbeat_ms = 16000;
> +	wdog_dev->timeout = 8;
> +
> +	irq = platform_get_irq(pdev, 0);
> +	if (irq < 0) {
> +		dev_err(&pdev->dev, "IRQ resource not found\n");
> +		return -ENODEV;
> +	}
> +
> +	err = request_irq(irq, octeontx2_wdt_interrupt, 0, pdev->name, priv);
> +	if (err) {
> +		dev_err(dev, "cannot register interrupt handler %d\n", err);
> +		return err;
> +	}

Use devm_request_irq() and request the interrupt after registering
the watchdog.

> +
> +	priv->irq = irq;
> +	watchdog_set_drvdata(wdog_dev, priv);
> +	platform_set_drvdata(pdev, priv);
> +	watchdog_init_timeout(wdog_dev, wdog_dev->timeout, dev);

watchdog_init_timeout sets wdog_dev->timeout, so this is pointless.
Calling watchdog_init_timeout() only makes sense if the parameter
is either a timeout module parameter or 0 and the idea is to use
a value from devicetree if configured.

> +	octeontx2_wdt_settimeout(wdog_dev, wdog_dev->timeout);
> +	watchdog_stop_on_reboot(wdog_dev);
> +	watchdog_stop_on_unregister(wdog_dev);
> +
> +	err = devm_watchdog_register_device(dev, wdog_dev);
> +	if (err) {
> +		free_irq(irq, priv);
> +		return err;
> +	}
> +
> +	dev_info(dev, "Watchdog enabled (timeout=%d sec)\n", wdog_dev->timeout);
> +	return 0;
> +}
> +
> +static int octeontx2_wdt_remove(struct platform_device *pdev)
> +{
> +	struct octeontx2_wdt_priv *priv = platform_get_drvdata(pdev);
> +
> +	if (priv->irq)
> +		free_irq(priv->irq, priv);
> +
> +	return 0;
> +}
> +
> +static const struct of_device_id octeontx2_wdt_of_match[] = {
> +	{ .compatible = "marvell-octeontx2-wdt", },
> +	{ },
> +};
> +MODULE_DEVICE_TABLE(of, octeontx2_wdt_of_match);
> +
> +static struct platform_driver octeontx2_wdt_driver = {
> +	.driver = {
> +		.name = "octeontx2-wdt",
> +		.of_match_table = octeontx2_wdt_of_match,
> +	},
> +	.probe = octeontx2_wdt_probe,
> +	.remove = octeontx2_wdt_remove,
> +};
> +module_platform_driver(octeontx2_wdt_driver);
> +
> +MODULE_AUTHOR("Bharat Bhushan <bbhushan2@marvell.com>");
> +MODULE_DESCRIPTION("OcteonTX2 watchdog driver");
> -- 
> 2.17.1
> 
