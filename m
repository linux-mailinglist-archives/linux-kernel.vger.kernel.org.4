Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B306973DB03
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 11:14:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229786AbjFZJOZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 05:14:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229712AbjFZJNN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 05:13:13 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DFBEF7;
        Mon, 26 Jun 2023 02:11:41 -0700 (PDT)
Date:   Mon, 26 Jun 2023 09:11:39 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1687770700;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UIa2t0Ao2Aj54WjxyNY/4aQCunMPPaLmpDBuy0zsHmo=;
        b=EhlGMKcHy+TfMyX1BZ8EBR1tpvLc+b75PWxOKH+/SP55hiRtGS/Kywrn4rSdivevXTMBRV
        pNYoLA/Td0FGOWgCYSw5mK9nVSeb8a/BrGGvyMz1fpDFFTytceCHfF/z0SwjzGeM3PU1IG
        oMAcCNJgEYy1rcOFaX6ViDzirD2O/3ZB2OkAvmy2O8cRullsmmvUSqOskPVI62I+Fn/H4X
        Mj9wX3DFunSt/7rLNB7o8CBmgMqdof5I8N4oeUZILVkfeGDeUZDzFx2qjCcolpl2rT26Sc
        9MNrO/8lRENyPe3KibTIKAeKIEmwk1y7nMch875btR39+dOX/SQz2qRIldM9qQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1687770700;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UIa2t0Ao2Aj54WjxyNY/4aQCunMPPaLmpDBuy0zsHmo=;
        b=U5qX0t3rT3knQAWTGgGRYGehi034SMtAcmo2OPDfDf/+e1AJGzRmJQd3uxkM0oZsBrtd62
        9DdA63REfbymGdBg==
From:   "tip-bot2 for Keguang Zhang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] MIPS: Loongson32: Remove deprecated PWM timer clocksource
Cc:     Keguang Zhang <keguang.zhang@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230512103724.587760-2-keguang.zhang@gmail.com>
References: <20230512103724.587760-2-keguang.zhang@gmail.com>
MIME-Version: 1.0
Message-ID: <168777069948.404.5077543884007097949.tip-bot2@tip-bot2>
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

Commit-ID:     9e130e2be4e7ac54de1ecc3fa424ca7ddfb1a748
Gitweb:        https://git.kernel.org/tip/9e130e2be4e7ac54de1ecc3fa424ca7ddfb1a748
Author:        Keguang Zhang <keguang.zhang@gmail.com>
AuthorDate:    Fri, 12 May 2023 18:37:22 +08:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Mon, 19 Jun 2023 17:06:55 +02:00

MIPS: Loongson32: Remove deprecated PWM timer clocksource

The Loongson1 PWM timer will be moved to clocksource framework.
Then, the old driver is no longer needed.
Remove the deprecated code and update the Kconfig.

Signed-off-by: Keguang Zhang <keguang.zhang@gmail.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20230512103724.587760-2-keguang.zhang@gmail.com
---
 arch/mips/include/asm/mach-loongson32/loongson1.h |   1 +-
 arch/mips/include/asm/mach-loongson32/regs-pwm.h  |  25 +--
 arch/mips/loongson32/Kconfig                      |  37 +--
 arch/mips/loongson32/common/time.c                | 210 +-------------
 4 files changed, 273 deletions(-)
 delete mode 100644 arch/mips/include/asm/mach-loongson32/regs-pwm.h

diff --git a/arch/mips/include/asm/mach-loongson32/loongson1.h b/arch/mips/include/asm/mach-loongson32/loongson1.h
index eb3ddbe..d8f9dec 100644
--- a/arch/mips/include/asm/mach-loongson32/loongson1.h
+++ b/arch/mips/include/asm/mach-loongson32/loongson1.h
@@ -47,7 +47,6 @@
 
 #include <regs-clk.h>
 #include <regs-mux.h>
-#include <regs-pwm.h>
 #include <regs-rtc.h>
 #include <regs-wdt.h>
 
diff --git a/arch/mips/include/asm/mach-loongson32/regs-pwm.h b/arch/mips/include/asm/mach-loongson32/regs-pwm.h
deleted file mode 100644
index ec870c8..0000000
--- a/arch/mips/include/asm/mach-loongson32/regs-pwm.h
+++ /dev/null
@@ -1,25 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-or-later */
-/*
- * Copyright (c) 2014 Zhang, Keguang <keguang.zhang@gmail.com>
- *
- * Loongson 1 PWM Register Definitions.
- */
-
-#ifndef __ASM_MACH_LOONGSON32_REGS_PWM_H
-#define __ASM_MACH_LOONGSON32_REGS_PWM_H
-
-/* Loongson 1 PWM Timer Register Definitions */
-#define PWM_CNT			0x0
-#define PWM_HRC			0x4
-#define PWM_LRC			0x8
-#define PWM_CTRL		0xc
-
-/* PWM Control Register Bits */
-#define CNT_RST			BIT(7)
-#define INT_SR			BIT(6)
-#define INT_EN			BIT(5)
-#define PWM_SINGLE		BIT(4)
-#define PWM_OE			BIT(3)
-#define CNT_EN			BIT(0)
-
-#endif /* __ASM_MACH_LOONGSON32_REGS_PWM_H */
diff --git a/arch/mips/loongson32/Kconfig b/arch/mips/loongson32/Kconfig
index 2ef9da0..a7c5009 100644
--- a/arch/mips/loongson32/Kconfig
+++ b/arch/mips/loongson32/Kconfig
@@ -35,41 +35,4 @@ config LOONGSON1_LS1C
 	select COMMON_CLK
 endchoice
 
-menuconfig CEVT_CSRC_LS1X
-	bool "Use PWM Timer for clockevent/clocksource"
-	select MIPS_EXTERNAL_TIMER
-	depends on CPU_LOONGSON32
-	help
-	  This option changes the default clockevent/clocksource to PWM Timer,
-	  and is required by Loongson1 CPUFreq support.
-
-	  If unsure, say N.
-
-choice
-	prompt "Select clockevent/clocksource"
-	depends on CEVT_CSRC_LS1X
-	default TIMER_USE_PWM0
-
-config TIMER_USE_PWM0
-	bool "Use PWM Timer 0"
-	help
-	  Use PWM Timer 0 as the default clockevent/clocksourcer.
-
-config TIMER_USE_PWM1
-	bool "Use PWM Timer 1"
-	help
-	  Use PWM Timer 1 as the default clockevent/clocksourcer.
-
-config TIMER_USE_PWM2
-	bool "Use PWM Timer 2"
-	help
-	  Use PWM Timer 2 as the default clockevent/clocksourcer.
-
-config TIMER_USE_PWM3
-	bool "Use PWM Timer 3"
-	help
-	  Use PWM Timer 3 as the default clockevent/clocksourcer.
-
-endchoice
-
 endif # MACH_LOONGSON32
diff --git a/arch/mips/loongson32/common/time.c b/arch/mips/loongson32/common/time.c
index 965c04a..74ad2b1 100644
--- a/arch/mips/loongson32/common/time.c
+++ b/arch/mips/loongson32/common/time.c
@@ -5,208 +5,8 @@
 
 #include <linux/clk.h>
 #include <linux/of_clk.h>
-#include <linux/interrupt.h>
-#include <linux/sizes.h>
 #include <asm/time.h>
 
-#include <loongson1.h>
-#include <platform.h>
-
-#ifdef CONFIG_CEVT_CSRC_LS1X
-
-#if defined(CONFIG_TIMER_USE_PWM1)
-#define LS1X_TIMER_BASE	LS1X_PWM1_BASE
-#define LS1X_TIMER_IRQ	LS1X_PWM1_IRQ
-
-#elif defined(CONFIG_TIMER_USE_PWM2)
-#define LS1X_TIMER_BASE	LS1X_PWM2_BASE
-#define LS1X_TIMER_IRQ	LS1X_PWM2_IRQ
-
-#elif defined(CONFIG_TIMER_USE_PWM3)
-#define LS1X_TIMER_BASE	LS1X_PWM3_BASE
-#define LS1X_TIMER_IRQ	LS1X_PWM3_IRQ
-
-#else
-#define LS1X_TIMER_BASE	LS1X_PWM0_BASE
-#define LS1X_TIMER_IRQ	LS1X_PWM0_IRQ
-#endif
-
-DEFINE_RAW_SPINLOCK(ls1x_timer_lock);
-
-static void __iomem *timer_reg_base;
-static uint32_t ls1x_jiffies_per_tick;
-
-static inline void ls1x_pwmtimer_set_period(uint32_t period)
-{
-	__raw_writel(period, timer_reg_base + PWM_HRC);
-	__raw_writel(period, timer_reg_base + PWM_LRC);
-}
-
-static inline void ls1x_pwmtimer_restart(void)
-{
-	__raw_writel(0x0, timer_reg_base + PWM_CNT);
-	__raw_writel(INT_EN | CNT_EN, timer_reg_base + PWM_CTRL);
-}
-
-void __init ls1x_pwmtimer_init(void)
-{
-	timer_reg_base = ioremap(LS1X_TIMER_BASE, SZ_16);
-	if (!timer_reg_base)
-		panic("Failed to remap timer registers");
-
-	ls1x_jiffies_per_tick = DIV_ROUND_CLOSEST(mips_hpt_frequency, HZ);
-
-	ls1x_pwmtimer_set_period(ls1x_jiffies_per_tick);
-	ls1x_pwmtimer_restart();
-}
-
-static u64 ls1x_clocksource_read(struct clocksource *cs)
-{
-	unsigned long flags;
-	int count;
-	u32 jifs;
-	static int old_count;
-	static u32 old_jifs;
-
-	raw_spin_lock_irqsave(&ls1x_timer_lock, flags);
-	/*
-	 * Although our caller may have the read side of xtime_lock,
-	 * this is now a seqlock, and we are cheating in this routine
-	 * by having side effects on state that we cannot undo if
-	 * there is a collision on the seqlock and our caller has to
-	 * retry.  (Namely, old_jifs and old_count.)  So we must treat
-	 * jiffies as volatile despite the lock.  We read jiffies
-	 * before latching the timer count to guarantee that although
-	 * the jiffies value might be older than the count (that is,
-	 * the counter may underflow between the last point where
-	 * jiffies was incremented and the point where we latch the
-	 * count), it cannot be newer.
-	 */
-	jifs = jiffies;
-	/* read the count */
-	count = __raw_readl(timer_reg_base + PWM_CNT);
-
-	/*
-	 * It's possible for count to appear to go the wrong way for this
-	 * reason:
-	 *
-	 *  The timer counter underflows, but we haven't handled the resulting
-	 *  interrupt and incremented jiffies yet.
-	 *
-	 * Previous attempts to handle these cases intelligently were buggy, so
-	 * we just do the simple thing now.
-	 */
-	if (count < old_count && jifs == old_jifs)
-		count = old_count;
-
-	old_count = count;
-	old_jifs = jifs;
-
-	raw_spin_unlock_irqrestore(&ls1x_timer_lock, flags);
-
-	return (u64) (jifs * ls1x_jiffies_per_tick) + count;
-}
-
-static struct clocksource ls1x_clocksource = {
-	.name		= "ls1x-pwmtimer",
-	.read		= ls1x_clocksource_read,
-	.mask		= CLOCKSOURCE_MASK(24),
-	.flags		= CLOCK_SOURCE_IS_CONTINUOUS,
-};
-
-static irqreturn_t ls1x_clockevent_isr(int irq, void *devid)
-{
-	struct clock_event_device *cd = devid;
-
-	ls1x_pwmtimer_restart();
-	cd->event_handler(cd);
-
-	return IRQ_HANDLED;
-}
-
-static int ls1x_clockevent_set_state_periodic(struct clock_event_device *cd)
-{
-	raw_spin_lock(&ls1x_timer_lock);
-	ls1x_pwmtimer_set_period(ls1x_jiffies_per_tick);
-	ls1x_pwmtimer_restart();
-	__raw_writel(INT_EN | CNT_EN, timer_reg_base + PWM_CTRL);
-	raw_spin_unlock(&ls1x_timer_lock);
-
-	return 0;
-}
-
-static int ls1x_clockevent_tick_resume(struct clock_event_device *cd)
-{
-	raw_spin_lock(&ls1x_timer_lock);
-	__raw_writel(INT_EN | CNT_EN, timer_reg_base + PWM_CTRL);
-	raw_spin_unlock(&ls1x_timer_lock);
-
-	return 0;
-}
-
-static int ls1x_clockevent_set_state_shutdown(struct clock_event_device *cd)
-{
-	raw_spin_lock(&ls1x_timer_lock);
-	__raw_writel(__raw_readl(timer_reg_base + PWM_CTRL) & ~CNT_EN,
-		     timer_reg_base + PWM_CTRL);
-	raw_spin_unlock(&ls1x_timer_lock);
-
-	return 0;
-}
-
-static int ls1x_clockevent_set_next(unsigned long evt,
-				    struct clock_event_device *cd)
-{
-	raw_spin_lock(&ls1x_timer_lock);
-	ls1x_pwmtimer_set_period(evt);
-	ls1x_pwmtimer_restart();
-	raw_spin_unlock(&ls1x_timer_lock);
-
-	return 0;
-}
-
-static struct clock_event_device ls1x_clockevent = {
-	.name			= "ls1x-pwmtimer",
-	.features		= CLOCK_EVT_FEAT_PERIODIC,
-	.rating			= 300,
-	.irq			= LS1X_TIMER_IRQ,
-	.set_next_event		= ls1x_clockevent_set_next,
-	.set_state_shutdown	= ls1x_clockevent_set_state_shutdown,
-	.set_state_periodic	= ls1x_clockevent_set_state_periodic,
-	.set_state_oneshot	= ls1x_clockevent_set_state_shutdown,
-	.tick_resume		= ls1x_clockevent_tick_resume,
-};
-
-static void __init ls1x_time_init(void)
-{
-	struct clock_event_device *cd = &ls1x_clockevent;
-	int ret;
-
-	if (!mips_hpt_frequency)
-		panic("Invalid timer clock rate");
-
-	ls1x_pwmtimer_init();
-
-	clockevent_set_clock(cd, mips_hpt_frequency);
-	cd->max_delta_ns = clockevent_delta2ns(0xffffff, cd);
-	cd->max_delta_ticks = 0xffffff;
-	cd->min_delta_ns = clockevent_delta2ns(0x000300, cd);
-	cd->min_delta_ticks = 0x000300;
-	cd->cpumask = cpumask_of(smp_processor_id());
-	clockevents_register_device(cd);
-
-	ls1x_clocksource.rating = 200 + mips_hpt_frequency / 10000000;
-	ret = clocksource_register_hz(&ls1x_clocksource, mips_hpt_frequency);
-	if (ret)
-		panic(KERN_ERR "Failed to register clocksource: %d\n", ret);
-
-	if (request_irq(LS1X_TIMER_IRQ, ls1x_clockevent_isr,
-			IRQF_PERCPU | IRQF_TIMER, "ls1x-pwmtimer",
-			&ls1x_clockevent))
-		pr_err("Failed to register ls1x-pwmtimer interrupt\n");
-}
-#endif /* CONFIG_CEVT_CSRC_LS1X */
-
 void __init plat_time_init(void)
 {
 	struct clk *clk = NULL;
@@ -214,20 +14,10 @@ void __init plat_time_init(void)
 	/* initialize LS1X clocks */
 	of_clk_init(NULL);
 
-#ifdef CONFIG_CEVT_CSRC_LS1X
-	/* setup LS1X PWM timer */
-	clk = clk_get(NULL, "ls1x-pwmtimer");
-	if (IS_ERR(clk))
-		panic("unable to get timer clock, err=%ld", PTR_ERR(clk));
-
-	mips_hpt_frequency = clk_get_rate(clk);
-	ls1x_time_init();
-#else
 	/* setup mips r4k timer */
 	clk = clk_get(NULL, "cpu_clk");
 	if (IS_ERR(clk))
 		panic("unable to get cpu clock, err=%ld", PTR_ERR(clk));
 
 	mips_hpt_frequency = clk_get_rate(clk) / 2;
-#endif /* CONFIG_CEVT_CSRC_LS1X */
 }
