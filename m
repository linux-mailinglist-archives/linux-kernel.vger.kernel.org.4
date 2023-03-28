Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06FF76CBE89
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 14:05:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232750AbjC1MFu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 08:05:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230280AbjC1MFr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 08:05:47 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9359793C3;
        Tue, 28 Mar 2023 05:05:22 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id le6so11386805plb.12;
        Tue, 28 Mar 2023 05:05:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680005121;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iCzXNIYQLlaRYU7ZogUgHF9j0l1HrLJQb1SPX081M7g=;
        b=gRr90qeL/gjfNQEgduUUbmJXYgfkRgGZ+TKTciuQTJRTN4qRxvEyOjEFztICyVdliD
         mH/NebAzrEgPcO80I5vDICNg8qNya4s9MW1zBMHWcYW0Yzww5cVgmBqhqpLgfKbziFOY
         7vznpwkxW+fMC+VNNFVgIt05JhmFrIukJodmZ96UnLYuDmB6PVPmA+RG9mO0eQ20arX+
         LSEb6CbSF5jA8Z6w1f8/MUYL6hkwdCHe9W6tVOUIYb2yui02gvg7aBSqbA1SamnAHv51
         sGraEOEM5XNTMOwdkLktT+ljZ1ZA44ILUqAa+oW+VDBXZcQFUlq6NiBkbBz0q3Vogsdq
         NvcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680005121;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iCzXNIYQLlaRYU7ZogUgHF9j0l1HrLJQb1SPX081M7g=;
        b=bOo3MyFRGStXaM5odSnhhJ47OmmXRdrfeEVqT1qzLBk9vMkVdtadYn+Q6vf4hWbCHs
         f/aphh3fZL1no/Y2HVjbzkJxZiHheFcs9pgX+H3iWS0m6l4dO7/C+ZbVoDTegKiqsn/D
         Qdns5NWrH3UQ5qHNW97MgI4plLRhdj1Q1vyz/SCncDYc0m47dKjGZ8hZOOjhZJPUvh3q
         uKXvtk7JrFlshb00wtdjg4phZMvfIwKa2NAdF8oKGr6glwO4hUg3LBWEMGDOvxHmHTUN
         PW/S4dVOp256sZSzE8ej+kqLTfGQA7xTAV+gF+IeHfxQY5G7JEbR7c6FsS2+XnvH8Ov7
         FbEA==
X-Gm-Message-State: AAQBX9dnnifN0WSjCWzLdwrcHCl7UP+2fajMLwWPEe/UtuSrMYpzdRPY
        uGEKkZ8wCHghJbw3MRlkk+cHml99mokLXQ==
X-Google-Smtp-Source: AKy350aRXwHQRyB+t6HBqQ7anWxNo4R42W4+8V+izqoLlg4yBcC+ODpQL96UXAMpG8ovrSUwsk18lw==
X-Received: by 2002:a17:903:124c:b0:19c:a9bc:ce57 with SMTP id u12-20020a170903124c00b0019ca9bcce57mr17280866plh.64.1680005121584;
        Tue, 28 Mar 2023 05:05:21 -0700 (PDT)
Received: from kelvin-ThinkPad-L14-Gen-1.. (94.130.220.35.bc.googleusercontent.com. [35.220.130.94])
        by smtp.gmail.com with ESMTPSA id ju10-20020a170903428a00b0019a83f2c99bsm21013956plb.28.2023.03.28.05.05.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Mar 2023 05:05:21 -0700 (PDT)
From:   Keguang Zhang <keguang.zhang@gmail.com>
To:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-mips@vger.kernel.org
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Stephen Boyd <sboyd@kernel.org>,
        Keguang Zhang <keguang.zhang@gmail.com>
Subject: [PATCH 1/3] MIPS: Loongson32: Remove deprecated PWM timer clocksource
Date:   Tue, 28 Mar 2023 20:05:04 +0800
Message-Id: <20230328120506.375864-2-keguang.zhang@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230328120506.375864-1-keguang.zhang@gmail.com>
References: <20230328120506.375864-1-keguang.zhang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=3.4 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: ***
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Loongson1 PWM timer will be moved to clocksource framework.
Then, the old driver is no longer needed.
Remove the deprecated code and update the Kconfig accordingly.

Signed-off-by: Keguang Zhang <keguang.zhang@gmail.com>
---
 arch/mips/loongson32/Kconfig       |  37 -----
 arch/mips/loongson32/common/time.c | 210 -----------------------------
 2 files changed, 247 deletions(-)

diff --git a/arch/mips/loongson32/Kconfig b/arch/mips/loongson32/Kconfig
index 2ef9da0016df..a7c500959577 100644
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
index 965c04aa56fd..74ad2b17918d 100644
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
-- 
2.34.1

