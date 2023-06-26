Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A9C473DB02
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 11:14:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230336AbjFZJOM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 05:14:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229638AbjFZJNM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 05:13:12 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91105E4;
        Mon, 26 Jun 2023 02:11:40 -0700 (PDT)
Date:   Mon, 26 Jun 2023 09:11:38 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1687770699;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=c+ceHt1DD0QltV7K0nCGt9pxCKL/Mu8yRvs4aGZejgY=;
        b=4esV2INvy5TNr51fAkoM6YPDRGBhXcaMd4WlpbRAl8XJ43UtPvoPxg8/E/11N6nXkJ2PrK
        ngjZo8TBXP7eRkzGVmoe4jX+Fre+biwZMlbc8tdFQLb8L7Ca4Gl/iKpknDj3HqnqNcEWAP
        KDK0itNnFsoA68M2WlkESNovajfHDgXA/BLobOrWUes1HKrT4p1c74lFM7OvU0Dtn/kL94
        /0Yb574JvU1nZ+M8MIyWX2spa/LnFqQ1y+MgwcZcTLvla/eVgv576vnUi7j1IjmtJemjxF
        2TqXEy2tV1uhU1uuTNjcNGWWiVn/DssgIpN0G00tAV5SZF1b8DhEwYLAqbaI9Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1687770699;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=c+ceHt1DD0QltV7K0nCGt9pxCKL/Mu8yRvs4aGZejgY=;
        b=45Yp+sB0IsZybOuH+4F0QQRR6Kx/kOCS+x4KtJdjrX6Nj9n3nAB/6V9C05P+tdFy2Tp9i1
        xP66BP654pSqYJBg==
From:   "tip-bot2 for Keguang Zhang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] clocksource/drivers/loongson1: Move PWM timer to
 clocksource framework
Cc:     Keguang Zhang <keguang.zhang@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230512103724.587760-4-keguang.zhang@gmail.com>
References: <20230512103724.587760-4-keguang.zhang@gmail.com>
MIME-Version: 1.0
Message-ID: <168777069862.404.16842099416566387754.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     e738521a11f13e40af89f66527e59306c4169782
Gitweb:        https://git.kernel.org/tip/e738521a11f13e40af89f66527e59306c4169782
Author:        Keguang Zhang <keguang.zhang@gmail.com>
AuthorDate:    Fri, 12 May 2023 18:37:24 +08:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Mon, 19 Jun 2023 17:07:03 +02:00

clocksource/drivers/loongson1: Move PWM timer to clocksource framework

This patch moves most part of arch/mips/loongson32/common/time.c
into drivers/clocksource.

Adapt the driver to clocksource framework with devicetree support
and updates Kconfig/Makefile options.

Signed-off-by: Keguang Zhang <keguang.zhang@gmail.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20230512103724.587760-4-keguang.zhang@gmail.com
---
 drivers/clocksource/Kconfig               |   9 +-
 drivers/clocksource/Makefile              |   1 +-
 drivers/clocksource/timer-loongson1-pwm.c | 236 +++++++++++++++++++++-
 3 files changed, 246 insertions(+)
 create mode 100644 drivers/clocksource/timer-loongson1-pwm.c

diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
index 526382d..c4d671a 100644
--- a/drivers/clocksource/Kconfig
+++ b/drivers/clocksource/Kconfig
@@ -612,6 +612,15 @@ config TIMER_IMX_SYS_CTR
 	  Enable this option to use i.MX system counter timer as a
 	  clockevent.
 
+config CLKSRC_LOONGSON1_PWM
+	bool "Clocksource using Loongson1 PWM"
+	depends on MACH_LOONGSON32 || COMPILE_TEST
+	select MIPS_EXTERNAL_TIMER
+	select TIMER_OF
+	help
+	  Enable this option to use Loongson1 PWM timer as clocksource
+	  instead of the performance counter.
+
 config CLKSRC_ST_LPC
 	bool "Low power clocksource found in the LPC" if COMPILE_TEST
 	select TIMER_OF if OF
diff --git a/drivers/clocksource/Makefile b/drivers/clocksource/Makefile
index f12d398..5d93c9e 100644
--- a/drivers/clocksource/Makefile
+++ b/drivers/clocksource/Makefile
@@ -89,3 +89,4 @@ obj-$(CONFIG_MICROCHIP_PIT64B)		+= timer-microchip-pit64b.o
 obj-$(CONFIG_MSC313E_TIMER)		+= timer-msc313e.o
 obj-$(CONFIG_GOLDFISH_TIMER)		+= timer-goldfish.o
 obj-$(CONFIG_GXP_TIMER)			+= timer-gxp.o
+obj-$(CONFIG_CLKSRC_LOONGSON1_PWM)	+= timer-loongson1-pwm.o
diff --git a/drivers/clocksource/timer-loongson1-pwm.c b/drivers/clocksource/timer-loongson1-pwm.c
new file mode 100644
index 0000000..6335fee
--- /dev/null
+++ b/drivers/clocksource/timer-loongson1-pwm.c
@@ -0,0 +1,236 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Clocksource driver for Loongson-1 SoC
+ *
+ * Copyright (c) 2023 Keguang Zhang <keguang.zhang@gmail.com>
+ */
+
+#include <linux/clockchips.h>
+#include <linux/interrupt.h>
+#include <linux/sizes.h>
+#include "timer-of.h"
+
+/* Loongson-1 PWM Timer Register Definitions */
+#define PWM_CNTR		0x0
+#define PWM_HRC			0x4
+#define PWM_LRC			0x8
+#define PWM_CTRL		0xc
+
+/* PWM Control Register Bits */
+#define INT_LRC_EN		BIT(11)
+#define INT_HRC_EN		BIT(10)
+#define CNTR_RST		BIT(7)
+#define INT_SR			BIT(6)
+#define INT_EN			BIT(5)
+#define PWM_SINGLE		BIT(4)
+#define PWM_OE			BIT(3)
+#define CNT_EN			BIT(0)
+
+#define CNTR_WIDTH		24
+
+DEFINE_RAW_SPINLOCK(ls1x_timer_lock);
+
+struct ls1x_clocksource {
+	void __iomem *reg_base;
+	unsigned long ticks_per_jiffy;
+	struct clocksource clksrc;
+};
+
+static inline struct ls1x_clocksource *to_ls1x_clksrc(struct clocksource *c)
+{
+	return container_of(c, struct ls1x_clocksource, clksrc);
+}
+
+static inline void ls1x_pwmtimer_set_period(unsigned int period,
+					    struct timer_of *to)
+{
+	writel(period, timer_of_base(to) + PWM_LRC);
+	writel(period, timer_of_base(to) + PWM_HRC);
+}
+
+static inline void ls1x_pwmtimer_clear(struct timer_of *to)
+{
+	writel(0, timer_of_base(to) + PWM_CNTR);
+}
+
+static inline void ls1x_pwmtimer_start(struct timer_of *to)
+{
+	writel((INT_EN | PWM_OE | CNT_EN), timer_of_base(to) + PWM_CTRL);
+}
+
+static inline void ls1x_pwmtimer_stop(struct timer_of *to)
+{
+	writel(0, timer_of_base(to) + PWM_CTRL);
+}
+
+static inline void ls1x_pwmtimer_irq_ack(struct timer_of *to)
+{
+	int val;
+
+	val = readl(timer_of_base(to) + PWM_CTRL);
+	val |= INT_SR;
+	writel(val, timer_of_base(to) + PWM_CTRL);
+}
+
+static irqreturn_t ls1x_clockevent_isr(int irq, void *dev_id)
+{
+	struct clock_event_device *clkevt = dev_id;
+	struct timer_of *to = to_timer_of(clkevt);
+
+	ls1x_pwmtimer_irq_ack(to);
+	ls1x_pwmtimer_clear(to);
+	ls1x_pwmtimer_start(to);
+
+	clkevt->event_handler(clkevt);
+
+	return IRQ_HANDLED;
+}
+
+static int ls1x_clockevent_set_state_periodic(struct clock_event_device *clkevt)
+{
+	struct timer_of *to = to_timer_of(clkevt);
+
+	raw_spin_lock(&ls1x_timer_lock);
+	ls1x_pwmtimer_set_period(timer_of_period(to), to);
+	ls1x_pwmtimer_clear(to);
+	ls1x_pwmtimer_start(to);
+	raw_spin_unlock(&ls1x_timer_lock);
+
+	return 0;
+}
+
+static int ls1x_clockevent_tick_resume(struct clock_event_device *clkevt)
+{
+	raw_spin_lock(&ls1x_timer_lock);
+	ls1x_pwmtimer_start(to_timer_of(clkevt));
+	raw_spin_unlock(&ls1x_timer_lock);
+
+	return 0;
+}
+
+static int ls1x_clockevent_set_state_shutdown(struct clock_event_device *clkevt)
+{
+	raw_spin_lock(&ls1x_timer_lock);
+	ls1x_pwmtimer_stop(to_timer_of(clkevt));
+	raw_spin_unlock(&ls1x_timer_lock);
+
+	return 0;
+}
+
+static int ls1x_clockevent_set_next(unsigned long evt,
+				    struct clock_event_device *clkevt)
+{
+	struct timer_of *to = to_timer_of(clkevt);
+
+	raw_spin_lock(&ls1x_timer_lock);
+	ls1x_pwmtimer_set_period(evt, to);
+	ls1x_pwmtimer_clear(to);
+	ls1x_pwmtimer_start(to);
+	raw_spin_unlock(&ls1x_timer_lock);
+
+	return 0;
+}
+
+static struct timer_of ls1x_to = {
+	.flags = TIMER_OF_IRQ | TIMER_OF_BASE | TIMER_OF_CLOCK,
+	.clkevt = {
+		.name			= "ls1x-pwmtimer",
+		.features		= CLOCK_EVT_FEAT_PERIODIC |
+					  CLOCK_EVT_FEAT_ONESHOT,
+		.rating			= 300,
+		.set_next_event		= ls1x_clockevent_set_next,
+		.set_state_periodic	= ls1x_clockevent_set_state_periodic,
+		.set_state_oneshot	= ls1x_clockevent_set_state_shutdown,
+		.set_state_shutdown	= ls1x_clockevent_set_state_shutdown,
+		.tick_resume		= ls1x_clockevent_tick_resume,
+	},
+	.of_irq = {
+		.handler		= ls1x_clockevent_isr,
+		.flags			= IRQF_TIMER,
+	},
+};
+
+/*
+ * Since the PWM timer overflows every two ticks, its not very useful
+ * to just read by itself. So use jiffies to emulate a free
+ * running counter:
+ */
+static u64 ls1x_clocksource_read(struct clocksource *cs)
+{
+	struct ls1x_clocksource *ls1x_cs = to_ls1x_clksrc(cs);
+	unsigned long flags;
+	int count;
+	u32 jifs;
+	static int old_count;
+	static u32 old_jifs;
+
+	raw_spin_lock_irqsave(&ls1x_timer_lock, flags);
+	/*
+	 * Although our caller may have the read side of xtime_lock,
+	 * this is now a seqlock, and we are cheating in this routine
+	 * by having side effects on state that we cannot undo if
+	 * there is a collision on the seqlock and our caller has to
+	 * retry.  (Namely, old_jifs and old_count.)  So we must treat
+	 * jiffies as volatile despite the lock.  We read jiffies
+	 * before latching the timer count to guarantee that although
+	 * the jiffies value might be older than the count (that is,
+	 * the counter may underflow between the last point where
+	 * jiffies was incremented and the point where we latch the
+	 * count), it cannot be newer.
+	 */
+	jifs = jiffies;
+	/* read the count */
+	count = readl(ls1x_cs->reg_base + PWM_CNTR);
+
+	/*
+	 * It's possible for count to appear to go the wrong way for this
+	 * reason:
+	 *
+	 *  The timer counter underflows, but we haven't handled the resulting
+	 *  interrupt and incremented jiffies yet.
+	 *
+	 * Previous attempts to handle these cases intelligently were buggy, so
+	 * we just do the simple thing now.
+	 */
+	if (count < old_count && jifs == old_jifs)
+		count = old_count;
+
+	old_count = count;
+	old_jifs = jifs;
+
+	raw_spin_unlock_irqrestore(&ls1x_timer_lock, flags);
+
+	return (u64)(jifs * ls1x_cs->ticks_per_jiffy) + count;
+}
+
+static struct ls1x_clocksource ls1x_clocksource = {
+	.clksrc = {
+		.name           = "ls1x-pwmtimer",
+		.rating		= 300,
+		.read           = ls1x_clocksource_read,
+		.mask           = CLOCKSOURCE_MASK(CNTR_WIDTH),
+		.flags          = CLOCK_SOURCE_IS_CONTINUOUS,
+	},
+};
+
+static int __init ls1x_pwm_clocksource_init(struct device_node *np)
+{
+	struct timer_of *to = &ls1x_to;
+	int ret;
+
+	ret = timer_of_init(np, to);
+	if (ret)
+		return ret;
+
+	clockevents_config_and_register(&to->clkevt, timer_of_rate(to),
+					0x1, GENMASK(CNTR_WIDTH - 1, 0));
+
+	ls1x_clocksource.reg_base = timer_of_base(to);
+	ls1x_clocksource.ticks_per_jiffy = timer_of_period(to);
+
+	return clocksource_register_hz(&ls1x_clocksource.clksrc,
+				       timer_of_rate(to));
+}
+
+TIMER_OF_DECLARE(ls1x_pwm_clocksource, "loongson,ls1b-pwmtimer",
+		 ls1x_pwm_clocksource_init);
