Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D32616EC991
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 11:55:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231630AbjDXJzt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 05:55:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231133AbjDXJzq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 05:55:46 -0400
Received: from forward502c.mail.yandex.net (forward502c.mail.yandex.net [178.154.239.210])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13B173C06
        for <linux-kernel@vger.kernel.org>; Mon, 24 Apr 2023 02:55:20 -0700 (PDT)
Received: from mail-nwsmtp-smtp-production-main-39.myt.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-39.myt.yp-c.yandex.net [IPv6:2a02:6b8:c12:261e:0:640:2e3d:0])
        by forward502c.mail.yandex.net (Yandex) with ESMTP id E21365ECA7;
        Mon, 24 Apr 2023 12:35:40 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-39.myt.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id JZBb1pbWwKo0-TQ2nZL1G;
        Mon, 24 Apr 2023 12:35:40 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maquefel.me; s=mail; t=1682328940;
        bh=IhqPZ/qxZ9/sRxxhCs0FKyNtz7tmKyjSTBRi5ZDq8aY=;
        h=Message-Id:Date:In-Reply-To:Cc:Subject:References:To:From;
        b=e/D9V0moQ4Q/XWfvUQbvOAldoLl3KtoIJaE5snrkUesHW5vJ2pvDDJbyBYxrnXSjB
         WLX2r0njia3jVzkIhL/NBCritpQnlq6YuhHYt5ZYJlNGVgQE+gAfDiWXC1gWLV9Ayg
         iXewXZveBIezlqoYggvIIcDHiaVEzVfUcDEU5+bg=
Authentication-Results: mail-nwsmtp-smtp-production-main-39.myt.yp-c.yandex.net; dkim=pass header.i=@maquefel.me
From:   Nikita Shubin <nikita.shubin@maquefel.me>
Cc:     Arnd Bergmann <arnd@kernel.org>, Linus Walleij <linusw@kernel.org>,
        Alexander Sverdlin <alexander.sverdlin@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 06/43] clocksource: ep93xx: Add driver for Cirrus Logic EP93xx
Date:   Mon, 24 Apr 2023 15:34:22 +0300
Message-Id: <20230424123522.18302-7-nikita.shubin@maquefel.me>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230424123522.18302-1-nikita.shubin@maquefel.me>
References: <20230424123522.18302-1-nikita.shubin@maquefel.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This us a rewrite of EP93xx timer driver in
arch/arm/mach-ep93xx/timer-ep93xx.c trying to do everything
the device tree way:

- Make every IO-access relative to a base address and dynamic
  so we can do a dynamic ioremap and get going.
- Find register range and interrupt from the device tree.

Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>
---
 drivers/clocksource/Kconfig        |  11 ++
 drivers/clocksource/Makefile       |   1 +
 drivers/clocksource/timer-ep93xx.c | 191 +++++++++++++++++++++++++++++
 3 files changed, 203 insertions(+)
 create mode 100644 drivers/clocksource/timer-ep93xx.c

diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
index 5fc8f0e7fb38..40bfc7c86756 100644
--- a/drivers/clocksource/Kconfig
+++ b/drivers/clocksource/Kconfig
@@ -721,4 +721,15 @@ config GOLDFISH_TIMER
 	help
 	  Support for the timer/counter of goldfish-rtc
 
+config EP93XX_TIMER
+	bool "Cirrus Logic ep93xx timer driver" if COMPILE_TEST
+	depends on ARCH_EP93XX
+	depends on GENERIC_CLOCKEVENTS
+	depends on HAS_IOMEM
+	select CLKSRC_MMIO
+	select TIMER_OF
+	help
+	  Enables support for the Cirrus Logic timer block
+	  EP93XX.
+
 endmenu
diff --git a/drivers/clocksource/Makefile b/drivers/clocksource/Makefile
index 64ab547de97b..09c2d4e5d809 100644
--- a/drivers/clocksource/Makefile
+++ b/drivers/clocksource/Makefile
@@ -88,3 +88,4 @@ obj-$(CONFIG_MICROCHIP_PIT64B)		+= timer-microchip-pit64b.o
 obj-$(CONFIG_MSC313E_TIMER)		+= timer-msc313e.o
 obj-$(CONFIG_GOLDFISH_TIMER)		+= timer-goldfish.o
 obj-$(CONFIG_GXP_TIMER)			+= timer-gxp.o
+obj-$(CONFIG_EP93XX_TIMER)		+= timer-ep93xx.o
diff --git a/drivers/clocksource/timer-ep93xx.c b/drivers/clocksource/timer-ep93xx.c
new file mode 100644
index 000000000000..58dc15a21318
--- /dev/null
+++ b/drivers/clocksource/timer-ep93xx.c
@@ -0,0 +1,191 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Cirrus Logic EP93xx timer driver.
+ * Copyright (C) 2021 Nikita Shubin <nikita.shubin@maquefel.me>
+ *
+ * Based on a rewrite of arch/arm/mach-ep93xx/timer.c:
+ */
+
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/clocksource.h>
+#include <linux/clockchips.h>
+#include <linux/sched_clock.h>
+#include <linux/interrupt.h>
+#include <linux/irq.h>
+#include <linux/of_irq.h>
+#include <linux/of_address.h>
+#include <linux/io.h>
+#include <linux/regmap.h>
+#include <linux/mfd/syscon.h>
+#include <asm/mach/time.h>
+
+/*************************************************************************
+ * Timer handling for EP93xx
+ *************************************************************************
+ * The ep93xx has four internal timers.  Timers 1, 2 (both 16 bit) and
+ * 3 (32 bit) count down at 508 kHz, are self-reloading, and can generate
+ * an interrupt on underflow.  Timer 4 (40 bit) counts down at 983.04 kHz,
+ * is free-running, and can't generate interrupts.
+ *
+ * The 508 kHz timers are ideal for use for the timer interrupt, as the
+ * most common values of HZ divide 508 kHz nicely.  We pick the 32 bit
+ * timer (timer 3) to get as long sleep intervals as possible when using
+ * CONFIG_NO_HZ.
+ *
+ * The higher clock rate of timer 4 makes it a better choice than the
+ * other timers for use as clock source and for sched_clock(), providing
+ * a stable 40 bit time base.
+ *************************************************************************
+ */
+
+#define EP93XX_TIMER1_LOAD		0x00
+#define EP93XX_TIMER1_VALUE		0x04
+#define EP93XX_TIMER1_CONTROL		0x08
+#define EP93XX_TIMER123_CONTROL_ENABLE	BIT(7)
+#define EP93XX_TIMER123_CONTROL_MODE	BIT(6)
+#define EP93XX_TIMER123_CONTROL_CLKSEL	BIT(3)
+#define EP93XX_TIMER1_CLEAR		0x0c
+#define EP93XX_TIMER2_LOAD		0x20
+#define EP93XX_TIMER2_VALUE		0x24
+#define EP93XX_TIMER2_CONTROL		0x28
+#define EP93XX_TIMER2_CLEAR		0x2c
+/* This read-only register contains the low word of the time stamp debug timer
+ * ( Timer4). When this register is read, the high byte of the Timer4 counter is
+ * saved in the Timer4ValueHigh register.
+ */
+#define EP93XX_TIMER4_VALUE_LOW		0x60
+#define EP93XX_TIMER4_VALUE_HIGH	0x64
+#define EP93XX_TIMER4_VALUE_HIGH_ENABLE	BIT(8)
+#define EP93XX_TIMER3_LOAD		0x80
+#define EP93XX_TIMER3_VALUE		0x84
+#define EP93XX_TIMER3_CONTROL		0x88
+#define EP93XX_TIMER3_CLEAR		0x8c
+
+#define EP93XX_TIMER123_RATE		508469
+#define EP93XX_TIMER4_RATE		983040
+
+struct ep93xx_tcu {
+	void __iomem *base;
+};
+
+static struct ep93xx_tcu *ep93xx_tcu;
+
+static u64 ep93xx_clocksource_read(struct clocksource *c)
+{
+	struct ep93xx_tcu *tcu = ep93xx_tcu;
+	u64 ret;
+
+	ret = readl(tcu->base + EP93XX_TIMER4_VALUE_LOW);
+	ret |= ((u64) (readl(tcu->base + EP93XX_TIMER4_VALUE_HIGH) & 0xff) << 32);
+	return (u64) ret;
+}
+
+static u64 notrace ep93xx_read_sched_clock(void)
+{
+	return ep93xx_clocksource_read(NULL);
+}
+
+static int ep93xx_clkevt_set_next_event(unsigned long next,
+					struct clock_event_device *evt)
+{
+	struct ep93xx_tcu *tcu = ep93xx_tcu;
+	/* Default mode: periodic, off, 508 kHz */
+	u32 tmode = EP93XX_TIMER123_CONTROL_MODE |
+	EP93XX_TIMER123_CONTROL_CLKSEL;
+
+	/* Clear timer */
+	writel(tmode, tcu->base + EP93XX_TIMER3_CONTROL);
+
+	/* Set next event */
+	writel(next, tcu->base + EP93XX_TIMER3_LOAD);
+	writel(tmode | EP93XX_TIMER123_CONTROL_ENABLE,
+	       tcu->base + EP93XX_TIMER3_CONTROL);
+	return 0;
+}
+
+static int ep93xx_clkevt_shutdown(struct clock_event_device *evt)
+{
+	struct ep93xx_tcu *tcu = ep93xx_tcu;
+	/* Disable timer */
+	writel(0, tcu->base + EP93XX_TIMER3_CONTROL);
+
+	return 0;
+}
+
+static struct clock_event_device ep93xx_clockevent = {
+	.name			= "timer1",
+	.features		= CLOCK_EVT_FEAT_ONESHOT,
+	.set_state_shutdown	= ep93xx_clkevt_shutdown,
+	.set_state_oneshot	= ep93xx_clkevt_shutdown,
+	.tick_resume		= ep93xx_clkevt_shutdown,
+	.set_next_event		= ep93xx_clkevt_set_next_event,
+	.rating			= 300,
+};
+
+static irqreturn_t ep93xx_timer_interrupt(int irq, void *dev_id)
+{
+	struct ep93xx_tcu *tcu = ep93xx_tcu;
+	struct clock_event_device *evt = dev_id;
+
+	/* Writing any value clears the timer interrupt */
+	writel(1, tcu->base + EP93XX_TIMER3_CLEAR);
+
+	evt->event_handler(evt);
+
+	return IRQ_HANDLED;
+}
+
+static int __init ep93xx_timer_of_init(struct device_node *np)
+{
+	int irq;
+	unsigned long flags = IRQF_TIMER | IRQF_IRQPOLL;
+	struct ep93xx_tcu *tcu;
+	int ret;
+
+	tcu = kzalloc(sizeof(*tcu), GFP_KERNEL);
+	if (!tcu)
+		return -ENOMEM;
+
+	tcu->base = of_iomap(np, 0);
+	if (!tcu->base) {
+		pr_err("Can't remap registers\n");
+		ret = -ENXIO;
+		goto out_free;
+	}
+
+	ep93xx_tcu = tcu;
+
+	irq = irq_of_parse_and_map(np, 0);
+	if (irq <= 0) {
+		pr_err("ERROR: invalid interrupt number\n");
+		ret = -EINVAL;
+		goto out_free;
+	}
+
+	/* Enable and register clocksource and sched_clock on timer 4 */
+	writel(EP93XX_TIMER4_VALUE_HIGH_ENABLE,
+	       tcu->base + EP93XX_TIMER4_VALUE_HIGH);
+	clocksource_mmio_init(NULL, "timer4",
+				EP93XX_TIMER4_RATE, 200, 40,
+				ep93xx_clocksource_read);
+	sched_clock_register(ep93xx_read_sched_clock, 40,
+			     EP93XX_TIMER4_RATE);
+
+	/* Set up clockevent on timer 3 */
+	if (request_irq(irq, ep93xx_timer_interrupt, flags, "ep93xx timer",
+		&ep93xx_clockevent))
+		pr_err("Failed to request irq %d (ep93xx timer)\n", irq);
+	clockevents_config_and_register(&ep93xx_clockevent,
+				EP93XX_TIMER123_RATE,
+				1,
+				0xffffffffU);
+
+	return 0;
+
+out_free:
+	kfree(tcu);
+	return ret;
+}
+
+TIMER_OF_DECLARE(ep93xx_timer, "cirrus,ep9301-timer", ep93xx_timer_of_init);
-- 
2.39.2

