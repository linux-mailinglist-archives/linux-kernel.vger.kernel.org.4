Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C26465F3FBB
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 11:31:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231260AbiJDJbd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 05:31:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229848AbiJDJ1z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 05:27:55 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA61DE029;
        Tue,  4 Oct 2022 02:27:17 -0700 (PDT)
Date:   Tue, 04 Oct 2022 09:27:15 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1664875636;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=l8LTAmluJKAk7IOKZE1WIo5WvecNKne+9Viri7jGqk0=;
        b=cGk/Ai4R1KlpGdd9CoTZCJsSeg4x3+MItdHC/ZU9Hx6SSFariiCESDZXmfbNa9LV2dSB8w
        McaDVl6bEtC5TS9gCMQdCZWaQucbvt7Ed7D0Mz9zi8H9bdroD3kBW6cu3RLP/+B1BekmTw
        EtAkHFhkblWuR+IPPQqgi3rfcMpivrgAXthh2eLSlqMLBryWSaU0bNRhKRMEeaQTkL3HKG
        EqiCfKis5No1DgSNv3Vm0D/xVO8z3I3cc1qS7gXAhV0EtJdAvzeQ4GFyp3ZWVTy0fgof7J
        cgc/NKAOZkJEVFfTc+TFXL6XDpnVaDAs0y35oFoxX3uFzRNWiZA1EABUhzAdig==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1664875636;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=l8LTAmluJKAk7IOKZE1WIo5WvecNKne+9Viri7jGqk0=;
        b=+sP5Pi0RC+uHfPG/t+dM7gnBCm0GLhi1u1L1IzUN7CnBdycBkRy3G19gPT2A98XRc90En1
        nyLY2abEQ1pb9CBw==
From:   "tip-bot2 for Tony Lindgren" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] clocksource/drivers/timer-ti-dm: Simplify register
 writes with dmtimer_write()
Cc:     Tony Lindgren <tony@atomide.com>,
        Janusz Krzysztofik <jmkrzyszt@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220815131250.34603-4-tony@atomide.com>
References: <20220815131250.34603-4-tony@atomide.com>
MIME-Version: 1.0
Message-ID: <166487563532.401.14537944551288717649.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     49cd16bb573e43dc2ee64d734b9b545475dbb35f
Gitweb:        https://git.kernel.org/tip/49cd16bb573e43dc2ee64d734b9b545475dbb35f
Author:        Tony Lindgren <tony@atomide.com>
AuthorDate:    Mon, 15 Aug 2022 16:12:44 +03:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Tue, 20 Sep 2022 10:49:45 +02:00

clocksource/drivers/timer-ti-dm: Simplify register writes with dmtimer_write()

We can simplify register write access by checking for the register write
posted mode in the write function. This way we can combine the functions
for __omap_dm_timer_write() and omap_dm_timer_write_reg() into a single
function dmtimer_write().

We update the shared register access first, the timer revision specific
register access will be updated in a later patch.

Signed-off-by: Tony Lindgren <tony@atomide.com>
Reviewed-by: Janusz Krzysztofik <jmkrzyszt@gmail.com>
Link: https://lore.kernel.org/r/20220815131250.34603-4-tony@atomide.com
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/clocksource/timer-ti-dm.c | 98 +++++++++++++-----------------
 1 file changed, 44 insertions(+), 54 deletions(-)

diff --git a/drivers/clocksource/timer-ti-dm.c b/drivers/clocksource/timer-ti-dm.c
index 070d47d..61c3c76 100644
--- a/drivers/clocksource/timer-ti-dm.c
+++ b/drivers/clocksource/timer-ti-dm.c
@@ -68,14 +68,29 @@ static inline u32 dmtimer_read(struct omap_dm_timer *timer, u32 reg)
 	return readl_relaxed(timer->func_base + offset);
 }
 
-static inline void __omap_dm_timer_write(struct omap_dm_timer *timer,
-					u32 reg, u32 val, int posted)
+/**
+ * dmtimer_write - write timer registers in posted and non-posted mode
+ * @timer:      timer pointer over which write operation is to perform
+ * @reg:        lowest byte holds the register offset
+ * @value:      data to write into the register
+ *
+ * The posted mode bit is encoded in reg. Note that in posted mode, the write
+ * pending bit must be checked. Otherwise a write on a register which has a
+ * pending write will be lost.
+ */
+static inline void dmtimer_write(struct omap_dm_timer *timer, u32 reg, u32 val)
 {
-	if (posted)
-		while (readl_relaxed(timer->pend) & (reg >> WPSHIFT))
+	u16 wp, offset;
+
+	wp = reg >> WPSHIFT;
+	offset = reg & 0xff;
+
+	/* Wait for a possible write pending bit in posted mode */
+	if (wp && timer->posted)
+		while (readl_relaxed(timer->pend) & wp)
 			cpu_relax();
 
-	writel_relaxed(val, timer->func_base + (reg & 0xff));
+	writel_relaxed(val, timer->func_base + offset);
 }
 
 static inline void __omap_dm_timer_init_regs(struct omap_dm_timer *timer)
@@ -120,25 +135,24 @@ static inline void __omap_dm_timer_enable_posted(struct omap_dm_timer *timer)
 
 	if (timer->errata & OMAP_TIMER_ERRATA_I103_I767) {
 		timer->posted = OMAP_TIMER_NONPOSTED;
-		__omap_dm_timer_write(timer, OMAP_TIMER_IF_CTRL_REG, 0, 0);
+		dmtimer_write(timer, OMAP_TIMER_IF_CTRL_REG, 0);
 		return;
 	}
 
-	__omap_dm_timer_write(timer, OMAP_TIMER_IF_CTRL_REG,
-			      OMAP_TIMER_CTRL_POSTED, 0);
+	dmtimer_write(timer, OMAP_TIMER_IF_CTRL_REG, OMAP_TIMER_CTRL_POSTED);
 	timer->context.tsicr = OMAP_TIMER_CTRL_POSTED;
 	timer->posted = OMAP_TIMER_POSTED;
 }
 
 static inline void __omap_dm_timer_stop(struct omap_dm_timer *timer,
-					int posted, unsigned long rate)
+					unsigned long rate)
 {
 	u32 l;
 
 	l = dmtimer_read(timer, OMAP_TIMER_CTRL_REG);
 	if (l & OMAP_TIMER_CTRL_ST) {
 		l &= ~0x1;
-		__omap_dm_timer_write(timer, OMAP_TIMER_CTRL_REG, l, posted);
+		dmtimer_write(timer, OMAP_TIMER_CTRL_REG, l);
 #ifdef CONFIG_ARCH_OMAP2PLUS
 		/* Readback to make sure write has completed */
 		dmtimer_read(timer, OMAP_TIMER_CTRL_REG);
@@ -158,7 +172,7 @@ static inline void __omap_dm_timer_int_enable(struct omap_dm_timer *timer,
 						unsigned int value)
 {
 	writel_relaxed(value, timer->irq_ena);
-	__omap_dm_timer_write(timer, OMAP_TIMER_WAKEUP_EN_REG, value, 0);
+	dmtimer_write(timer, OMAP_TIMER_WAKEUP_EN_REG, value);
 }
 
 static inline unsigned int
@@ -173,41 +187,17 @@ static inline void __omap_dm_timer_write_status(struct omap_dm_timer *timer,
 	writel_relaxed(value, timer->irq_stat);
 }
 
-/**
- * omap_dm_timer_write_reg - write timer registers in posted and non-posted mode
- * @timer:      timer pointer over which write operation is to perform
- * @reg:        lowest byte holds the register offset
- * @value:      data to write into the register
- *
- * The posted mode bit is encoded in reg. Note that in posted mode the write
- * pending bit must be checked. Otherwise a write on a register which has a
- * pending write will be lost.
- */
-static void omap_dm_timer_write_reg(struct omap_dm_timer *timer, u32 reg,
-						u32 value)
-{
-	WARN_ON((reg & 0xff) < _OMAP_TIMER_WAKEUP_EN_OFFSET);
-	__omap_dm_timer_write(timer, reg, value, timer->posted);
-}
-
 static void omap_timer_restore_context(struct omap_dm_timer *timer)
 {
-	__omap_dm_timer_write(timer, OMAP_TIMER_OCP_CFG_OFFSET,
-			      timer->context.ocp_cfg, 0);
-
-	omap_dm_timer_write_reg(timer, OMAP_TIMER_WAKEUP_EN_REG,
-				timer->context.twer);
-	omap_dm_timer_write_reg(timer, OMAP_TIMER_COUNTER_REG,
-				timer->context.tcrr);
-	omap_dm_timer_write_reg(timer, OMAP_TIMER_LOAD_REG,
-				timer->context.tldr);
-	omap_dm_timer_write_reg(timer, OMAP_TIMER_MATCH_REG,
-				timer->context.tmar);
-	omap_dm_timer_write_reg(timer, OMAP_TIMER_IF_CTRL_REG,
-				timer->context.tsicr);
+	dmtimer_write(timer, OMAP_TIMER_OCP_CFG_OFFSET, timer->context.ocp_cfg);
+
+	dmtimer_write(timer, OMAP_TIMER_WAKEUP_EN_REG, timer->context.twer);
+	dmtimer_write(timer, OMAP_TIMER_COUNTER_REG, timer->context.tcrr);
+	dmtimer_write(timer, OMAP_TIMER_LOAD_REG, timer->context.tldr);
+	dmtimer_write(timer, OMAP_TIMER_MATCH_REG, timer->context.tmar);
+	dmtimer_write(timer, OMAP_TIMER_IF_CTRL_REG, timer->context.tsicr);
 	writel_relaxed(timer->context.tier, timer->irq_ena);
-	omap_dm_timer_write_reg(timer, OMAP_TIMER_CTRL_REG,
-				timer->context.tclr);
+	dmtimer_write(timer, OMAP_TIMER_CTRL_REG, timer->context.tclr);
 }
 
 static void omap_timer_save_context(struct omap_dm_timer *timer)
@@ -256,7 +246,7 @@ static int omap_dm_timer_reset(struct omap_dm_timer *timer)
 	if (timer->revision != 1)
 		return -EINVAL;
 
-	omap_dm_timer_write_reg(timer, OMAP_TIMER_IF_CTRL_REG, 0x06);
+	dmtimer_write(timer, OMAP_TIMER_IF_CTRL_REG, 0x06);
 
 	do {
 		l = dmtimer_read(timer, OMAP_TIMER_V1_SYS_STAT_OFFSET);
@@ -270,7 +260,7 @@ static int omap_dm_timer_reset(struct omap_dm_timer *timer)
 	/* Configure timer for smart-idle mode */
 	l = dmtimer_read(timer, OMAP_TIMER_OCP_CFG_OFFSET);
 	l |= 0x2 << 0x3;
-	__omap_dm_timer_write(timer, OMAP_TIMER_OCP_CFG_OFFSET, l, 0);
+	dmtimer_write(timer, OMAP_TIMER_OCP_CFG_OFFSET, l);
 
 	timer->posted = 0;
 
@@ -586,7 +576,7 @@ static int omap_dm_timer_start(struct omap_dm_timer *timer)
 	l = dmtimer_read(timer, OMAP_TIMER_CTRL_REG);
 	if (!(l & OMAP_TIMER_CTRL_ST)) {
 		l |= OMAP_TIMER_CTRL_ST;
-		omap_dm_timer_write_reg(timer, OMAP_TIMER_CTRL_REG, l);
+		dmtimer_write(timer, OMAP_TIMER_CTRL_REG, l);
 	}
 
 	return 0;
@@ -602,7 +592,7 @@ static int omap_dm_timer_stop(struct omap_dm_timer *timer)
 	if (!(timer->capability & OMAP_TIMER_NEEDS_RESET))
 		rate = clk_get_rate(timer->fclk);
 
-	__omap_dm_timer_stop(timer, timer->posted, rate);
+	__omap_dm_timer_stop(timer, rate);
 
 	omap_dm_timer_disable(timer);
 	return 0;
@@ -615,7 +605,7 @@ static int omap_dm_timer_set_load(struct omap_dm_timer *timer,
 		return -EINVAL;
 
 	omap_dm_timer_enable(timer);
-	omap_dm_timer_write_reg(timer, OMAP_TIMER_LOAD_REG, load);
+	dmtimer_write(timer, OMAP_TIMER_LOAD_REG, load);
 
 	omap_dm_timer_disable(timer);
 	return 0;
@@ -635,8 +625,8 @@ static int omap_dm_timer_set_match(struct omap_dm_timer *timer, int enable,
 		l |= OMAP_TIMER_CTRL_CE;
 	else
 		l &= ~OMAP_TIMER_CTRL_CE;
-	omap_dm_timer_write_reg(timer, OMAP_TIMER_MATCH_REG, match);
-	omap_dm_timer_write_reg(timer, OMAP_TIMER_CTRL_REG, l);
+	dmtimer_write(timer, OMAP_TIMER_MATCH_REG, match);
+	dmtimer_write(timer, OMAP_TIMER_CTRL_REG, l);
 
 	omap_dm_timer_disable(timer);
 	return 0;
@@ -661,7 +651,7 @@ static int omap_dm_timer_set_pwm(struct omap_dm_timer *timer, int def_on,
 	l |= trigger << 10;
 	if (autoreload)
 		l |= OMAP_TIMER_CTRL_AR;
-	omap_dm_timer_write_reg(timer, OMAP_TIMER_CTRL_REG, l);
+	dmtimer_write(timer, OMAP_TIMER_CTRL_REG, l);
 
 	omap_dm_timer_disable(timer);
 	return 0;
@@ -696,7 +686,7 @@ static int omap_dm_timer_set_prescaler(struct omap_dm_timer *timer,
 		l |= OMAP_TIMER_CTRL_PRE;
 		l |= prescaler << 2;
 	}
-	omap_dm_timer_write_reg(timer, OMAP_TIMER_CTRL_REG, l);
+	dmtimer_write(timer, OMAP_TIMER_CTRL_REG, l);
 
 	omap_dm_timer_disable(timer);
 	return 0;
@@ -736,7 +726,7 @@ static int omap_dm_timer_set_int_disable(struct omap_dm_timer *timer, u32 mask)
 
 	writel_relaxed(l, timer->irq_dis);
 	l = dmtimer_read(timer, OMAP_TIMER_WAKEUP_EN_REG) & ~mask;
-	omap_dm_timer_write_reg(timer, OMAP_TIMER_WAKEUP_EN_REG, l);
+	dmtimer_write(timer, OMAP_TIMER_WAKEUP_EN_REG, l);
 
 	omap_dm_timer_disable(timer);
 	return 0;
@@ -783,7 +773,7 @@ static int omap_dm_timer_write_counter(struct omap_dm_timer *timer, unsigned int
 		return -EINVAL;
 	}
 
-	omap_dm_timer_write_reg(timer, OMAP_TIMER_COUNTER_REG, value);
+	dmtimer_write(timer, OMAP_TIMER_COUNTER_REG, value);
 
 	/* Save the context */
 	timer->context.tcrr = value;
