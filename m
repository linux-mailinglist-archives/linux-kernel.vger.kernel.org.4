Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80474721264
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Jun 2023 22:08:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231241AbjFCUIq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Jun 2023 16:08:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230521AbjFCUID (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Jun 2023 16:08:03 -0400
Received: from fgw22-7.mail.saunalahti.fi (fgw22-7.mail.saunalahti.fi [62.142.5.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2582E4C
        for <linux-kernel@vger.kernel.org>; Sat,  3 Jun 2023 13:07:34 -0700 (PDT)
Received: from localhost (88-113-26-95.elisa-laajakaista.fi [88.113.26.95])
        by fgw22.mail.saunalahti.fi (Halon) with ESMTP
        id 2144f3fc-024a-11ee-a9de-005056bdf889;
        Sat, 03 Jun 2023 23:06:30 +0300 (EEST)
From:   andy.shevchenko@gmail.com
Date:   Sat, 3 Jun 2023 23:06:30 +0300
To:     Nikita Shubin <nikita.shubin@maquefel.me>
Cc:     Alexander Sverdlin <alexander.sverdlin@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Michael Peters <mpeters@embeddedts.com>,
        Kris Bahnsen <kris@embeddedts.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 09/43] clocksource: ep93xx: Add driver for Cirrus
 Logic EP93xx
Message-ID: <ZHudRkB1YcMD_DaQ@surfacebook>
References: <20230424123522.18302-1-nikita.shubin@maquefel.me>
 <20230601053546.9574-10-nikita.shubin@maquefel.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230601053546.9574-10-nikita.shubin@maquefel.me>
X-Spam-Status: No, score=0.7 required=5.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
        FORGED_GMAIL_RCVD,FREEMAIL_FROM,NML_ADSP_CUSTOM_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thu, Jun 01, 2023 at 08:34:00AM +0300, Nikita Shubin kirjoitti:
> This us a rewrite of EP93xx timer driver in
> arch/arm/mach-ep93xx/timer-ep93xx.c trying to do everything
> the device tree way:
> 
> - Make every IO-access relative to a base address and dynamic
>   so we can do a dynamic ioremap and get going.
> - Find register range and interrupt from the device tree.

...

> +config EP93XX_TIMER
> +	bool "Cirrus Logic ep93xx timer driver" if COMPILE_TEST

This is strange. What do you gain with this "if COMPILE_TEST"?

> +	depends on ARCH_EP93XX
> +	depends on GENERIC_CLOCKEVENTS
> +	depends on HAS_IOMEM
> +	select CLKSRC_MMIO
> +	select TIMER_OF

...

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

Can you keep that ordered?
Missing bits.h.

+ Blank line.

> +#include <asm/mach/time.h>

...

> +/* This read-only register contains the low word of the time stamp debug timer
> + * ( Timer4). When this register is read, the high byte of the Timer4 counter is
> + * saved in the Timer4ValueHigh register.
> + */

/*
 * Wrong multi-line comment style.
 * Use this example, for example.
 */

...

> +static struct ep93xx_tcu *ep93xx_tcu;

Global?!
Can it be derived from struct clocksource?

...

> +static u64 ep93xx_clocksource_read(struct clocksource *c)
> +{
> +	struct ep93xx_tcu *tcu = ep93xx_tcu;
> +	u64 ret;
> +
> +	ret = readl(tcu->base + EP93XX_TIMER4_VALUE_LOW);
> +	ret |= ((u64) (readl(tcu->base + EP93XX_TIMER4_VALUE_HIGH) & 0xff) << 32);

GENMASK()

Why you are not using non-atomic 64-bit io accessors? Becomes as simple as

	return lo_hi_readq() & GENMASK();

> +	return (u64) ret;

Redundant casting.

> +}

...

> +	irq = irq_of_parse_and_map(np, 0);
> +	if (irq <= 0) {
> +		pr_err("ERROR: invalid interrupt number\n");
> +		ret = -EINVAL;

Shadowed error in case of negative returned code. Why?

> +		goto out_free;
> +	}

...

> +	clockevents_config_and_register(&ep93xx_clockevent,
> +				EP93XX_TIMER123_RATE,
> +				1,
> +				0xffffffffU);

UINT_MAX? GENMASK() ?

...

> +

Redundant blank line.

> +TIMER_OF_DECLARE(ep93xx_timer, "cirrus,ep9301-timer", ep93xx_timer_of_init);

-- 
With Best Regards,
Andy Shevchenko


