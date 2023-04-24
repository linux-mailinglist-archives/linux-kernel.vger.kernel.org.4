Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 417956ECBB1
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 13:58:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231750AbjDXL6a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 07:58:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231733AbjDXL61 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 07:58:27 -0400
Received: from smtp.smtpout.orange.fr (smtp-23.smtpout.orange.fr [80.12.242.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69044127
        for <linux-kernel@vger.kernel.org>; Mon, 24 Apr 2023 04:58:25 -0700 (PDT)
Received: from [192.168.1.18] ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id qupppaqoMvolhqupppSRih; Mon, 24 Apr 2023 13:58:23 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
        s=t20230301; t=1682337503;
        bh=iXDLseyY1n0HF1Z5SbkVidLZi+wzOYTFDupttXM2hhc=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To;
        b=Bzl5+xurVFD/jhmFUMWRprz+C81zCR8sAC6u6l7RLb0N8hKHiDRwcsY8oXWa59eDQ
         a/4RpUQML7OCXFGo/oG5z5GhBFZaPacmYVClfCcd8/J+K97nORmm0lEU2q5DoWBvcF
         AI+IjGwB7GEF/urYUvoylAx9zGnnIAWLARncg6I1xjWtH1JFlPWU1t+nMBBzvYMNJv
         FEs+vyAPArhwvWBAcJw8VJPx2MTKrd6SHJEK8M8IFLrK05mxNhC/CfDwucxBeOTFdP
         z5DrlyzrGsDqOmIR9mPB7jL64kg1A2B1rvzWUyupi447D7AWSV3Rdims6Yuv4X0uIg
         ZGq8ozO5sTRKQ==
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Mon, 24 Apr 2023 13:58:23 +0200
X-ME-IP: 86.243.2.178
Message-ID: <ad525b3d-e8f9-2701-a6c2-9dd102f51ac0@wanadoo.fr>
Date:   Mon, 24 Apr 2023 13:58:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 06/43] clocksource: ep93xx: Add driver for Cirrus Logic
 EP93xx
To:     Nikita Shubin <nikita.shubin@maquefel.me>
Cc:     Arnd Bergmann <arnd@kernel.org>, Linus Walleij <linusw@kernel.org>,
        Alexander Sverdlin <alexander.sverdlin@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
References: <20230424123522.18302-1-nikita.shubin@maquefel.me>
 <20230424123522.18302-7-nikita.shubin@maquefel.me>
Content-Language: fr
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20230424123522.18302-7-nikita.shubin@maquefel.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 24/04/2023 à 14:34, Nikita Shubin a écrit :
> This us a rewrite of EP93xx timer driver in
> arch/arm/mach-ep93xx/timer-ep93xx.c trying to do everything
> the device tree way:
> 
> - Make every IO-access relative to a base address and dynamic
>    so we can do a dynamic ioremap and get going.
> - Find register range and interrupt from the device tree.
> 
> Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>
> ---
>   drivers/clocksource/Kconfig        |  11 ++
>   drivers/clocksource/Makefile       |   1 +
>   drivers/clocksource/timer-ep93xx.c | 191 +++++++++++++++++++++++++++++
>   3 files changed, 203 insertions(+)
>   create mode 100644 drivers/clocksource/timer-ep93xx.c
> 
> diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
> index 5fc8f0e7fb38..40bfc7c86756 100644
> --- a/drivers/clocksource/Kconfig
> +++ b/drivers/clocksource/Kconfig
> @@ -721,4 +721,15 @@ config GOLDFISH_TIMER
>   	help
>   	  Support for the timer/counter of goldfish-rtc
>   
> +config EP93XX_TIMER
> +	bool "Cirrus Logic ep93xx timer driver" if COMPILE_TEST
> +	depends on ARCH_EP93XX
> +	depends on GENERIC_CLOCKEVENTS
> +	depends on HAS_IOMEM
> +	select CLKSRC_MMIO
> +	select TIMER_OF
> +	help
> +	  Enables support for the Cirrus Logic timer block
> +	  EP93XX.
> +
>   endmenu
> diff --git a/drivers/clocksource/Makefile b/drivers/clocksource/Makefile
> index 64ab547de97b..09c2d4e5d809 100644
> --- a/drivers/clocksource/Makefile
> +++ b/drivers/clocksource/Makefile
> @@ -88,3 +88,4 @@ obj-$(CONFIG_MICROCHIP_PIT64B)		+= timer-microchip-pit64b.o
>   obj-$(CONFIG_MSC313E_TIMER)		+= timer-msc313e.o
>   obj-$(CONFIG_GOLDFISH_TIMER)		+= timer-goldfish.o
>   obj-$(CONFIG_GXP_TIMER)			+= timer-gxp.o
> +obj-$(CONFIG_EP93XX_TIMER)		+= timer-ep93xx.o
> diff --git a/drivers/clocksource/timer-ep93xx.c b/drivers/clocksource/timer-ep93xx.c
> new file mode 100644
> index 000000000000..58dc15a21318
> --- /dev/null
> +++ b/drivers/clocksource/timer-ep93xx.c
> @@ -0,0 +1,191 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Cirrus Logic EP93xx timer driver.
> + * Copyright (C) 2021 Nikita Shubin <nikita.shubin@maquefel.me>
> + *
> + * Based on a rewrite of arch/arm/mach-ep93xx/timer.c:
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/init.h>
> +#include <linux/clocksource.h>
> +#include <linux/clockchips.h>
> +#include <linux/sched_clock.h>
> +#include <linux/interrupt.h>
> +#include <linux/irq.h>
> +#include <linux/of_irq.h>
> +#include <linux/of_address.h>
> +#include <linux/io.h>
> +#include <linux/regmap.h>
> +#include <linux/mfd/syscon.h>
> +#include <asm/mach/time.h>
> +
> +/*************************************************************************
> + * Timer handling for EP93xx
> + *************************************************************************
> + * The ep93xx has four internal timers.  Timers 1, 2 (both 16 bit) and
> + * 3 (32 bit) count down at 508 kHz, are self-reloading, and can generate
> + * an interrupt on underflow.  Timer 4 (40 bit) counts down at 983.04 kHz,
> + * is free-running, and can't generate interrupts.
> + *
> + * The 508 kHz timers are ideal for use for the timer interrupt, as the
> + * most common values of HZ divide 508 kHz nicely.  We pick the 32 bit
> + * timer (timer 3) to get as long sleep intervals as possible when using
> + * CONFIG_NO_HZ.
> + *
> + * The higher clock rate of timer 4 makes it a better choice than the
> + * other timers for use as clock source and for sched_clock(), providing
> + * a stable 40 bit time base.
> + *************************************************************************
> + */
> +
> +#define EP93XX_TIMER1_LOAD		0x00
> +#define EP93XX_TIMER1_VALUE		0x04
> +#define EP93XX_TIMER1_CONTROL		0x08
> +#define EP93XX_TIMER123_CONTROL_ENABLE	BIT(7)
> +#define EP93XX_TIMER123_CONTROL_MODE	BIT(6)
> +#define EP93XX_TIMER123_CONTROL_CLKSEL	BIT(3)
> +#define EP93XX_TIMER1_CLEAR		0x0c
> +#define EP93XX_TIMER2_LOAD		0x20
> +#define EP93XX_TIMER2_VALUE		0x24
> +#define EP93XX_TIMER2_CONTROL		0x28
> +#define EP93XX_TIMER2_CLEAR		0x2c
> +/* This read-only register contains the low word of the time stamp debug timer
> + * ( Timer4). When this register is read, the high byte of the Timer4 counter is
> + * saved in the Timer4ValueHigh register.
> + */
> +#define EP93XX_TIMER4_VALUE_LOW		0x60
> +#define EP93XX_TIMER4_VALUE_HIGH	0x64
> +#define EP93XX_TIMER4_VALUE_HIGH_ENABLE	BIT(8)
> +#define EP93XX_TIMER3_LOAD		0x80
> +#define EP93XX_TIMER3_VALUE		0x84
> +#define EP93XX_TIMER3_CONTROL		0x88
> +#define EP93XX_TIMER3_CLEAR		0x8c
> +
> +#define EP93XX_TIMER123_RATE		508469
> +#define EP93XX_TIMER4_RATE		983040
> +
> +struct ep93xx_tcu {
> +	void __iomem *base;
> +};
> +
> +static struct ep93xx_tcu *ep93xx_tcu;
> +
> +static u64 ep93xx_clocksource_read(struct clocksource *c)
> +{
> +	struct ep93xx_tcu *tcu = ep93xx_tcu;
> +	u64 ret;
> +
> +	ret = readl(tcu->base + EP93XX_TIMER4_VALUE_LOW);
> +	ret |= ((u64) (readl(tcu->base + EP93XX_TIMER4_VALUE_HIGH) & 0xff) << 32);
> +	return (u64) ret;
> +}
> +
> +static u64 notrace ep93xx_read_sched_clock(void)
> +{
> +	return ep93xx_clocksource_read(NULL);
> +}
> +
> +static int ep93xx_clkevt_set_next_event(unsigned long next,
> +					struct clock_event_device *evt)
> +{
> +	struct ep93xx_tcu *tcu = ep93xx_tcu;
> +	/* Default mode: periodic, off, 508 kHz */
> +	u32 tmode = EP93XX_TIMER123_CONTROL_MODE |
> +	EP93XX_TIMER123_CONTROL_CLKSEL;
> +
> +	/* Clear timer */
> +	writel(tmode, tcu->base + EP93XX_TIMER3_CONTROL);
> +
> +	/* Set next event */
> +	writel(next, tcu->base + EP93XX_TIMER3_LOAD);
> +	writel(tmode | EP93XX_TIMER123_CONTROL_ENABLE,
> +	       tcu->base + EP93XX_TIMER3_CONTROL);
> +	return 0;
> +}
> +
> +static int ep93xx_clkevt_shutdown(struct clock_event_device *evt)
> +{
> +	struct ep93xx_tcu *tcu = ep93xx_tcu;
> +	/* Disable timer */
> +	writel(0, tcu->base + EP93XX_TIMER3_CONTROL);
> +
> +	return 0;
> +}
> +
> +static struct clock_event_device ep93xx_clockevent = {
> +	.name			= "timer1",
> +	.features		= CLOCK_EVT_FEAT_ONESHOT,
> +	.set_state_shutdown	= ep93xx_clkevt_shutdown,
> +	.set_state_oneshot	= ep93xx_clkevt_shutdown,
> +	.tick_resume		= ep93xx_clkevt_shutdown,
> +	.set_next_event		= ep93xx_clkevt_set_next_event,
> +	.rating			= 300,
> +};
> +
> +static irqreturn_t ep93xx_timer_interrupt(int irq, void *dev_id)
> +{
> +	struct ep93xx_tcu *tcu = ep93xx_tcu;
> +	struct clock_event_device *evt = dev_id;
> +
> +	/* Writing any value clears the timer interrupt */
> +	writel(1, tcu->base + EP93XX_TIMER3_CLEAR);
> +
> +	evt->event_handler(evt);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static int __init ep93xx_timer_of_init(struct device_node *np)
> +{
> +	int irq;
> +	unsigned long flags = IRQF_TIMER | IRQF_IRQPOLL;
> +	struct ep93xx_tcu *tcu;
> +	int ret;
> +
> +	tcu = kzalloc(sizeof(*tcu), GFP_KERNEL);
> +	if (!tcu)
> +		return -ENOMEM;
> +
> +	tcu->base = of_iomap(np, 0);
> +	if (!tcu->base) {
> +		pr_err("Can't remap registers\n");
> +		ret = -ENXIO;
> +		goto out_free;
> +	}

Hi,
missing iounmap() in the error handling path below?

CJ

> +
> +	ep93xx_tcu = tcu;
> +
> +	irq = irq_of_parse_and_map(np, 0);
> +	if (irq <= 0) {
> +		pr_err("ERROR: invalid interrupt number\n");
> +		ret = -EINVAL;
> +		goto out_free;
> +	}
> +
> +	/* Enable and register clocksource and sched_clock on timer 4 */
> +	writel(EP93XX_TIMER4_VALUE_HIGH_ENABLE,
> +	       tcu->base + EP93XX_TIMER4_VALUE_HIGH);
> +	clocksource_mmio_init(NULL, "timer4",
> +				EP93XX_TIMER4_RATE, 200, 40,
> +				ep93xx_clocksource_read);
> +	sched_clock_register(ep93xx_read_sched_clock, 40,
> +			     EP93XX_TIMER4_RATE);
> +
> +	/* Set up clockevent on timer 3 */
> +	if (request_irq(irq, ep93xx_timer_interrupt, flags, "ep93xx timer",
> +		&ep93xx_clockevent))
> +		pr_err("Failed to request irq %d (ep93xx timer)\n", irq);
> +	clockevents_config_and_register(&ep93xx_clockevent,
> +				EP93XX_TIMER123_RATE,
> +				1,
> +				0xffffffffU);
> +
> +	return 0;
> +
> +out_free:
> +	kfree(tcu);
> +	return ret;
> +}
> +
> +TIMER_OF_DECLARE(ep93xx_timer, "cirrus,ep9301-timer", ep93xx_timer_of_init);

