Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E7E16C8738
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 22:04:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231248AbjCXVE4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 17:04:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231840AbjCXVEx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 17:04:53 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [IPv6:2a01:4f8:c010:41de::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE68B166C1;
        Fri, 24 Mar 2023 14:04:50 -0700 (PDT)
Date:   Fri, 24 Mar 2023 21:04:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=t-8ch.de; s=mail;
        t=1679691889; bh=iJwH2Fx5hEcdYN83wELFnuodo3IDfMVb36Ko204Svr8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=R5tGWXMz3Lj8bjqMAX4pyfLYgoKNcBhlt7dyHzQBw5jabcFocfljPdFzH9pEwD4kA
         Eel/6Dp/JddURQIt3YYr1prptvJzNs+zLkw+lJnQCHgTTx3bOgkJz85+e0ZCW6zNrn
         TaR+QZCz6J9onZqmXeYMvbfwJFL6RjHBvOpcs5jY=
From:   Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas@t-8ch.de>
To:     Bharat Bhushan <bbhushan2@marvell.com>
Cc:     wim@linux-watchdog.org, linux@roeck-us.net, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-watchdog@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] Watchdog: octeontx2: Add Pseudo-NMI GTI watchdog
 driver
Message-ID: <6ede1391-7b60-4c78-a93b-40d2c96e6ae8@t-8ch.de>
References: <20230324145652.19221-1-bbhushan2@marvell.com>
 <20230324145652.19221-2-bbhushan2@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230324145652.19221-2-bbhushan2@marvell.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-03-24 20:26:52+0530, Bharat Bhushan wrote:
> GTI hardware supports per-core watchdog timer which are programmed
> in "interrupt + del3t + reset mode" and del3t traps are not enabled.
> This driver uses ARM64 pseudo-nmi interrupt support.
> GTI watchdog exception flow is:
>  - 1st timer expiration generates pseudo-nmi interrupt.
>    NMI exception handler dumps register/context state on all cpu's.
>  - 2nd timer expiration is ignored
> 
>  - On 3rd timer expiration will trigger a system-wide core reset.
> 
> Signed-off-by: Bharat Bhushan <bbhushan2@marvell.com>
> ---
>  drivers/watchdog/Kconfig                  |   9 +
>  drivers/watchdog/Makefile                 |   1 +
>  drivers/watchdog/octeontx2_gti_watchdog.c | 352 ++++++++++++++++++++++
>  3 files changed, 362 insertions(+)
>  create mode 100644 drivers/watchdog/octeontx2_gti_watchdog.c
> 
> diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
> index f0872970daf9..9607d36645f6 100644
> --- a/drivers/watchdog/Kconfig
> +++ b/drivers/watchdog/Kconfig
> @@ -2212,4 +2212,13 @@ config KEEMBAY_WATCHDOG
>  	  To compile this driver as a module, choose M here: the
>  	  module will be called keembay_wdt.
>  
> +config OCTEON_GTI_WATCHDOG
> +	tristate "OCTEONTX2 GTI Watchdog driver"
> +	depends on ARM64
> +	help
> +	 OCTEONTX2 GTI hardware supports per-core watchdog timer which
> +	 are programmed in "interrupt + del3t + reset mode" and del3t
> +	 traps are not enabled.
> +	 This driver uses ARM64 pseudo-nmi interrupt support.
> +
>  endif # WATCHDOG
> diff --git a/drivers/watchdog/Makefile b/drivers/watchdog/Makefile
> index 9cbf6580f16c..11af3db62fec 100644
> --- a/drivers/watchdog/Makefile
> +++ b/drivers/watchdog/Makefile
> @@ -230,3 +230,4 @@ obj-$(CONFIG_MENZ069_WATCHDOG) += menz69_wdt.o
>  obj-$(CONFIG_RAVE_SP_WATCHDOG) += rave-sp-wdt.o
>  obj-$(CONFIG_STPMIC1_WATCHDOG) += stpmic1_wdt.o
>  obj-$(CONFIG_SL28CPLD_WATCHDOG) += sl28cpld_wdt.o
> +obj-$(CONFIG_OCTEON_GTI_WATCHDOG) += octeontx2_gti_watchdog.o
> diff --git a/drivers/watchdog/octeontx2_gti_watchdog.c b/drivers/watchdog/octeontx2_gti_watchdog.c
> new file mode 100644
> index 000000000000..766b7d41defe
> --- /dev/null
> +++ b/drivers/watchdog/octeontx2_gti_watchdog.c
> @@ -0,0 +1,352 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Marvell GTI Watchdog driver
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
> +
> +#include <asm/arch_timer.h>
> +
> +/* GTI CWD Watchdog Registers */
> +#define GTI_CWD_WDOG(cpu)		(0x8 * cpu)
> +#define GTI_CWD_WDOG_MODE_INT_DEL3T_RST	(0x3)
> +#define GTI_CWD_WDOG_MODE_MASK		(0x3)
> +#define GTI_CWD_WDOG_LEN_SHIFT		(4)
> +#define GTI_CWD_WDOG_CNT_SHIFT		(20)
> +
> +/* GTI Per-core Watchdog Interrupt Register */
> +#define GTI_CWD_INT			0x200
> +
> +/* GTI Per-core Watchdog Interrupt Enable Clear Register */
> +#define GTI_CWD_INT_ENA_CLR		0x210
> +
> +/* GTI Per-core Watchdog Interrupt Enable Set Register */
> +#define GTI_CWD_INT_ENA_SET		0x218
> +
> +/* GTI Per-core Watchdog Poke Registers */
> +#define GTI_CWD_POKE(cpu)		(0x10000 + 0x8 * cpu)
> +
> +struct octeontx2_gti_wdt_percpu_priv {
> +	struct watchdog_device wdev;
> +	int irq;
> +};
> +
> +struct octeontx2_gti_wdt_priv {
> +	void __iomem *base;
> +	u64 clock_freq;
> +	int is_nmi;
> +	struct octeontx2_gti_wdt_percpu_priv __percpu *percpu_priv;
> +};
> +
> +static int octeontx2_gti_wdt_get_cpuid(struct watchdog_device *wdev)
> +{
> +	struct octeontx2_gti_wdt_priv *priv = watchdog_get_drvdata(wdev);
> +	struct octeontx2_gti_wdt_percpu_priv *percpu_priv;
> +	int cpu;
> +
> +	for_each_online_cpu(cpu) {
> +		percpu_priv = per_cpu_ptr(priv->percpu_priv, cpu);
> +		if (&percpu_priv->wdev == wdev)
> +			return cpu;
> +	}
> +
> +	return -1;
> +}
> +
> +void octeontx2_gti_wdt_callback_other_cpus(void *unused)

Could be static.

> +{
> +	struct pt_regs *regs = get_irq_regs();
> +
> +	pr_emerg("GTI Watchdog CPU:%d\n", raw_smp_processor_id());
> +
> +	if (regs)
> +		show_regs(regs);
> +	else
> +		dump_stack();
> +}
> +
> +static irqreturn_t octeontx2_gti_wdt_interrupt(int irq, void *data)
> +{
> +	struct octeontx2_gti_wdt_priv *priv = (struct octeontx2_gti_wdt_priv *)data;
> +	int cpu = smp_processor_id();
> +
> +	/* Clear interrupt to fire again if delayed poke happens */
> +	writeq(1 << cpu, priv->base + GTI_CWD_INT);
> +	dump_stack();
> +
> +	for_each_online_cpu(cpu) {
> +		if (cpu == raw_smp_processor_id())
> +			continue;
> +
> +		smp_call_function_single(cpu,
> +					 octeontx2_gti_wdt_callback_other_cpus,
> +					 NULL, 1);
> +	}
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static int octeontx2_gti_wdt_ping(struct watchdog_device *wdev)
> +{
> +	struct octeontx2_gti_wdt_priv *priv = watchdog_get_drvdata(wdev);
> +	int cpu = octeontx2_gti_wdt_get_cpuid(wdev);
> +
> +	if (cpu < 0)
> +		return -EINVAL;
> +
> +	writeq(1, priv->base + GTI_CWD_POKE(cpu));
> +	return 0;
> +}
> +
> +static int octeontx2_gti_wdt_start(struct watchdog_device *wdev)
> +{
> +	struct octeontx2_gti_wdt_priv *priv = watchdog_get_drvdata(wdev);
> +	int cpu = octeontx2_gti_wdt_get_cpuid(wdev);
> +	u64 regval;
> +
> +	if (cpu < 0)
> +		return -EINVAL;
> +
> +	set_bit(WDOG_HW_RUNNING, &wdev->status);
> +
> +	/* Clear any pending interrupt */
> +	writeq(1 << cpu, priv->base + GTI_CWD_INT);
> +
> +	/* Enable Interrupt */
> +	writeq(1 << cpu, priv->base + GTI_CWD_INT_ENA_SET);
> +
> +	/* Set (Interrupt + SCP interrupt (DEL3T) + core domain reset) Mode */
> +	regval = readq(priv->base + GTI_CWD_WDOG(cpu));
> +	regval |= GTI_CWD_WDOG_MODE_INT_DEL3T_RST;
> +	writeq(regval, priv->base + GTI_CWD_WDOG(cpu));
> +
> +	return 0;
> +}
> +
> +static int octeontx2_gti_wdt_stop(struct watchdog_device *wdev)
> +{
> +	struct octeontx2_gti_wdt_priv *priv = watchdog_get_drvdata(wdev);
> +	u64 regval;
> +	int cpu = octeontx2_gti_wdt_get_cpuid(wdev);
> +
> +	if (cpu < 0)
> +		return -EINVAL;
> +
> +	/* Disable Interrupt */
> +	writeq(1 << cpu, priv->base + GTI_CWD_INT_ENA_CLR);
> +
> +	/* Set GTI_CWD_WDOG.Mode = 0 to stop the timer */
> +	regval = readq(priv->base + GTI_CWD_WDOG(cpu));
> +	regval &= ~GTI_CWD_WDOG_MODE_MASK;
> +	writeq(regval, priv->base + GTI_CWD_WDOG(cpu));
> +
> +	return 0;
> +}
> +
> +static int octeontx2_gti_wdt_settimeout(struct watchdog_device *wdev,
> +					unsigned int timeout)
> +{
> +	struct octeontx2_gti_wdt_priv *priv = watchdog_get_drvdata(wdev);
> +	int cpu = octeontx2_gti_wdt_get_cpuid(wdev);
> +	u64 timeout_wdog, regval;
> +
> +	if (cpu < 0)
> +		return -EINVAL;
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
> +	 */
> +	timeout_wdog = (timeout_wdog + 0xff) >> 8;
> +	if (timeout_wdog >= 0x10000)
> +		timeout_wdog = 0xffff;
> +
> +	/*
> +	 * GTI_CWD_WDOG.LEN have only upper 16-bits of 24-bits
> +	 * GTI_CWD_WDOG.CNT, need addition shift of 8.
> +	 */
> +	regval = readq(priv->base + GTI_CWD_WDOG(cpu));
> +	regval &= GTI_CWD_WDOG_MODE_MASK;
> +	regval |= ((timeout_wdog) << (GTI_CWD_WDOG_CNT_SHIFT + 8)) |
> +		   (timeout_wdog << GTI_CWD_WDOG_LEN_SHIFT);
> +	writeq(regval, priv->base + GTI_CWD_WDOG(cpu));
> +	return 0;
> +}
> +
> +static const struct watchdog_info octeontx2_gti_wdt_ident = {
> +	.identity = "OcteonTX2 GTI watchdog",
> +	.options	= WDIOF_SETTIMEOUT | WDIOF_KEEPALIVEPING | WDIOF_MAGICCLOSE |
> +			  WDIOF_CARDRESET,

Weird alignment.

> +};
> +
> +static const struct watchdog_ops octeontx2_gti_wdt_ops = {
> +	.owner = THIS_MODULE,
> +	.start = octeontx2_gti_wdt_start,
> +	.stop = octeontx2_gti_wdt_stop,
> +	.ping = octeontx2_gti_wdt_ping,
> +	.set_timeout = octeontx2_gti_wdt_settimeout,
> +};
> +
> +static void octeontx2_gti_wdt_free_irqs(struct octeontx2_gti_wdt_priv *priv)
> +{
> +	struct octeontx2_gti_wdt_percpu_priv *percpu_priv;
> +	int irq, cpu = 0;
> +
> +	for_each_online_cpu(cpu) {
> +		percpu_priv = per_cpu_ptr(priv->percpu_priv, cpu);
> +		irq = percpu_priv->irq;
> +		if (irq) {
> +			if (priv->is_nmi) {
> +				disable_nmi_nosync(irq);
> +				free_nmi(irq, priv);
> +			} else {
> +				disable_irq_nosync(irq);
> +				free_irq(irq, priv);
> +			}
> +
> +			percpu_priv->irq = 0;
> +		}
> +	}
> +}
> +
> +static int octeontx2_gti_wdt_probe(struct platform_device *pdev)
> +{
> +	struct octeontx2_gti_wdt_percpu_priv *percpu_priv;
> +	struct octeontx2_gti_wdt_priv *priv;
> +	struct device *dev = &pdev->dev;
> +	struct watchdog_device *wdog_dev;
> +	unsigned long irq_flags;
> +	int irq, cpu, num_irqs;
> +	int err;
> +
> +	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
> +	if (!priv)
> +		return -ENOMEM;
> +
> +	priv->percpu_priv = devm_alloc_percpu(&pdev->dev, *priv->percpu_priv);
> +	if (!priv->percpu_priv)
> +		return -ENOMEM;
> +
> +	priv->base = devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(priv->base))
> +		return dev_err_probe(&pdev->dev, PTR_ERR(priv->base),
> +			      "reg property not valid/found\n");
> +
> +	num_irqs = platform_irq_count(pdev);
> +	if (num_irqs < 0)
> +		return dev_err_probe(dev, num_irqs, "GTI CWD no IRQs\n");
> +
> +	if (num_irqs < num_online_cpus())
> +		return dev_err_probe(dev, -EINVAL, "IRQs (%d) < CPUs (%d)\n",
> +				     num_irqs, num_online_cpus());
> +
> +	priv->clock_freq = arch_timer_get_cntfrq();
> +
> +	for_each_online_cpu(cpu) {
> +		percpu_priv = per_cpu_ptr(priv->percpu_priv, cpu);
> +		wdog_dev = &percpu_priv->wdev;
> +		wdog_dev->info = &octeontx2_gti_wdt_ident,
> +		wdog_dev->ops = &octeontx2_gti_wdt_ops,
> +		wdog_dev->parent = dev;
> +		wdog_dev->min_timeout = 1;
> +		wdog_dev->max_timeout = 16;
> +		wdog_dev->max_hw_heartbeat_ms = 16000;
> +		wdog_dev->timeout = 8;
> +
> +		irq = platform_get_irq(pdev, cpu);
> +		if (irq < 0) {
> +			dev_err(&pdev->dev, "IRQ resource not found\n");
> +			err = -ENODEV;
> +			goto out;
> +		}
> +
> +		err = irq_force_affinity(irq, cpumask_of(cpu));
> +		if (err) {
> +			pr_warn("unable to set irq affinity (irq=%d, cpu=%u)\n", irq, cpu);
> +			goto out;
> +		}
> +
> +		irq_flags = IRQF_PERCPU | IRQF_NOBALANCING | IRQF_NO_AUTOEN |
> +			    IRQF_NO_THREAD;
> +		err = request_nmi(irq, octeontx2_gti_wdt_interrupt, irq_flags,
> +				  pdev->name, priv);
> +		if (err) {
> +			err = request_irq(irq, octeontx2_gti_wdt_interrupt, irq_flags,
> +					  pdev->name, priv);
> +			if (err) {
> +				dev_err(dev, "cannot register interrupt handler %d\n", err);
> +				goto out;
> +			}
> +			enable_irq(irq);
> +		} else {
> +			priv->is_nmi = 1;
> +			enable_nmi(irq);
> +		}
> +
> +		percpu_priv->irq = irq;
> +		watchdog_set_drvdata(wdog_dev, priv);
> +		platform_set_drvdata(pdev, priv);
> +		watchdog_init_timeout(wdog_dev, wdog_dev->timeout, dev);
> +		octeontx2_gti_wdt_settimeout(wdog_dev, wdog_dev->timeout);
> +		watchdog_stop_on_reboot(wdog_dev);
> +		watchdog_stop_on_unregister(wdog_dev);
> +
> +		err = devm_watchdog_register_device(dev, wdog_dev);
> +		if (unlikely(err))

This unlikely() should really not be needed.

> +			goto out;
> +		dev_info(dev, "Watchdog enabled (timeout=%d sec)", wdog_dev->timeout);
> +	}
> +	return 0;
> +
> +out:
> +	octeontx2_gti_wdt_free_irqs(priv);
> +	return err;
> +}
> +
> +static int octeontx2_gti_wdt_remove(struct platform_device *pdev)
> +{
> +	struct octeontx2_gti_wdt_priv *priv = platform_get_drvdata(pdev);
> +
> +	octeontx2_gti_wdt_free_irqs(priv);
> +	return 0;
> +}
> +
> +static const struct of_device_id octeontx2_gti_wdt_of_match[] = {
> +	{ .compatible = "mrvl,octeontx2-gti-wdt", },
> +	{ },

No trailing comma for end-of-array marker.

> +};
> +MODULE_DEVICE_TABLE(of, octeontx2_gti_wdt_of_match);
> +
> +static struct platform_driver octeontx2_gti_wdt_driver = {
> +	.driver = {
> +		.name = "octeontx2-gti-wdt",
> +		.of_match_table = octeontx2_gti_wdt_of_match,
> +	},
> +	.probe = octeontx2_gti_wdt_probe,
> +	.remove = octeontx2_gti_wdt_remove,
> +};
> +module_platform_driver(octeontx2_gti_wdt_driver);
> +
> +MODULE_AUTHOR("Bharat Bhushan <bbhushan2@marvell.com>");
> +MODULE_DESCRIPTION("OcteonTX2 GTI per cpu watchdog driver");

No MODULE_LICENSE() ?
