Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 611235F3F92
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 11:29:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229689AbiJDJ3n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 05:29:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229824AbiJDJ1z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 05:27:55 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA086E098;
        Tue,  4 Oct 2022 02:27:18 -0700 (PDT)
Date:   Tue, 04 Oct 2022 09:27:16 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1664875637;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mlHVLqeOJwEZgumZKxWdJjnhXggw0NKgopM54JreM7A=;
        b=NXXlB0THvJU1oHUMdHrh7ZBkGZT5zG9GBhQbTITEOPeXOTwmQ9COzB4EscpokfJSnFnzrf
        TgszR+DYc4U0zZFB1m0J5F2wA7X817onRQwWy3G+4luoKh/8nZBpg8HKXIY5t782I7x8O+
        3tE417P/MpXeXvX6amzHej5iW4eQgQknCBiuPMkDZwEzc2GLSbIhYAw+3clXBRn2a0beU9
        xCd+iLGuviogJXao0FlU6AhWJLP0lgyi83NV7HUEK5DjsIPs9gpsk+lDLsbwwwTwVeWSTD
        mvxMb8/OQfsZxDOXhxvKVlU/dUo7BWCt4kgwDCQVVcGJbscY8pN4dxLjC1v7TQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1664875637;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mlHVLqeOJwEZgumZKxWdJjnhXggw0NKgopM54JreM7A=;
        b=+4BQk48uhngl1luVWj2cYKSrrLopKerPq9BxBLinamNl4wGAwJ+YzTXy98fz5E84yFk2pZ
        vhmDFnaU2XHS0lCA==
From:   "tip-bot2 for Tony Lindgren" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] clocksource/drivers/timer-ti-dm: Simplify register
 reads with dmtimer_read()
Cc:     Tony Lindgren <tony@atomide.com>,
        Janusz Krzysztofik <jmkrzyszt@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220815131250.34603-3-tony@atomide.com>
References: <20220815131250.34603-3-tony@atomide.com>
MIME-Version: 1.0
Message-ID: <166487563636.401.10549265040517081536.tip-bot2@tip-bot2>
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

Commit-ID:     90c9aada19606ae78259cef78a46646a97ec8f67
Gitweb:        https://git.kernel.org/tip/90c9aada19606ae78259cef78a46646a97ec8f67
Author:        Tony Lindgren <tony@atomide.com>
AuthorDate:    Mon, 15 Aug 2022 16:12:43 +03:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Tue, 20 Sep 2022 10:49:45 +02:00

clocksource/drivers/timer-ti-dm: Simplify register reads with dmtimer_read()

We can simplify register read access by checking for the register write
posted mode in the read function. This way we can combine the functions
for __omap_dm_timer_read() and omap_dm_timer_read_reg() into a single
function dmtimer_read().

We update the shared register access first, the timer revision specific
register access will be updated in a later patch.

Signed-off-by: Tony Lindgren <tony@atomide.com>
Reviewed-by: Janusz Krzysztofik <jmkrzyszt@gmail.com>
Link: https://lore.kernel.org/r/20220815131250.34603-3-tony@atomide.com
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/clocksource/timer-ti-dm.c | 88 +++++++++++++-----------------
 1 file changed, 40 insertions(+), 48 deletions(-)

diff --git a/drivers/clocksource/timer-ti-dm.c b/drivers/clocksource/timer-ti-dm.c
index b8f8c11..070d47d 100644
--- a/drivers/clocksource/timer-ti-dm.c
+++ b/drivers/clocksource/timer-ti-dm.c
@@ -44,14 +44,28 @@ enum {
 	REQUEST_BY_NODE,
 };
 
-static inline u32 __omap_dm_timer_read(struct omap_dm_timer *timer, u32 reg,
-						int posted)
+/**
+ * dmtimer_read - read timer registers in posted and non-posted mode
+ * @timer:	timer pointer over which read operation to perform
+ * @reg:	lowest byte holds the register offset
+ *
+ * The posted mode bit is encoded in reg. Note that in posted mode, write
+ * pending bit must be checked. Otherwise a read of a non completed write
+ * will produce an error.
+ */
+static inline u32 dmtimer_read(struct omap_dm_timer *timer, u32 reg)
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
 
-	return readl_relaxed(timer->func_base + (reg & 0xff));
+	return readl_relaxed(timer->func_base + offset);
 }
 
 static inline void __omap_dm_timer_write(struct omap_dm_timer *timer,
@@ -121,13 +135,13 @@ static inline void __omap_dm_timer_stop(struct omap_dm_timer *timer,
 {
 	u32 l;
 
-	l = __omap_dm_timer_read(timer, OMAP_TIMER_CTRL_REG, posted);
+	l = dmtimer_read(timer, OMAP_TIMER_CTRL_REG);
 	if (l & OMAP_TIMER_CTRL_ST) {
 		l &= ~0x1;
 		__omap_dm_timer_write(timer, OMAP_TIMER_CTRL_REG, l, posted);
 #ifdef CONFIG_ARCH_OMAP2PLUS
 		/* Readback to make sure write has completed */
-		__omap_dm_timer_read(timer, OMAP_TIMER_CTRL_REG, posted);
+		dmtimer_read(timer, OMAP_TIMER_CTRL_REG);
 		/*
 		 * Wait for functional clock period x 3.5 to make sure that
 		 * timer is stopped
@@ -148,9 +162,9 @@ static inline void __omap_dm_timer_int_enable(struct omap_dm_timer *timer,
 }
 
 static inline unsigned int
-__omap_dm_timer_read_counter(struct omap_dm_timer *timer, int posted)
+__omap_dm_timer_read_counter(struct omap_dm_timer *timer)
 {
-	return __omap_dm_timer_read(timer, OMAP_TIMER_COUNTER_REG, posted);
+	return dmtimer_read(timer, OMAP_TIMER_COUNTER_REG);
 }
 
 static inline void __omap_dm_timer_write_status(struct omap_dm_timer *timer,
@@ -160,21 +174,6 @@ static inline void __omap_dm_timer_write_status(struct omap_dm_timer *timer,
 }
 
 /**
- * omap_dm_timer_read_reg - read timer registers in posted and non-posted mode
- * @timer:      timer pointer over which read operation to perform
- * @reg:        lowest byte holds the register offset
- *
- * The posted mode bit is encoded in reg. Note that in posted mode write
- * pending bit must be checked. Otherwise a read of a non completed write
- * will produce an error.
- */
-static inline u32 omap_dm_timer_read_reg(struct omap_dm_timer *timer, u32 reg)
-{
-	WARN_ON((reg & 0xff) < _OMAP_TIMER_WAKEUP_EN_OFFSET);
-	return __omap_dm_timer_read(timer, reg, timer->posted);
-}
-
-/**
  * omap_dm_timer_write_reg - write timer registers in posted and non-posted mode
  * @timer:      timer pointer over which write operation is to perform
  * @reg:        lowest byte holds the register offset
@@ -213,20 +212,14 @@ static void omap_timer_restore_context(struct omap_dm_timer *timer)
 
 static void omap_timer_save_context(struct omap_dm_timer *timer)
 {
-	timer->context.ocp_cfg =
-		__omap_dm_timer_read(timer, OMAP_TIMER_OCP_CFG_OFFSET, 0);
-
-	timer->context.tclr =
-			omap_dm_timer_read_reg(timer, OMAP_TIMER_CTRL_REG);
-	timer->context.twer =
-			omap_dm_timer_read_reg(timer, OMAP_TIMER_WAKEUP_EN_REG);
-	timer->context.tldr =
-			omap_dm_timer_read_reg(timer, OMAP_TIMER_LOAD_REG);
-	timer->context.tmar =
-			omap_dm_timer_read_reg(timer, OMAP_TIMER_MATCH_REG);
+	timer->context.ocp_cfg = dmtimer_read(timer, OMAP_TIMER_OCP_CFG_OFFSET);
+
+	timer->context.tclr = dmtimer_read(timer, OMAP_TIMER_CTRL_REG);
+	timer->context.twer = dmtimer_read(timer, OMAP_TIMER_WAKEUP_EN_REG);
+	timer->context.tldr = dmtimer_read(timer, OMAP_TIMER_LOAD_REG);
+	timer->context.tmar = dmtimer_read(timer, OMAP_TIMER_MATCH_REG);
 	timer->context.tier = readl_relaxed(timer->irq_ena);
-	timer->context.tsicr =
-			omap_dm_timer_read_reg(timer, OMAP_TIMER_IF_CTRL_REG);
+	timer->context.tsicr = dmtimer_read(timer, OMAP_TIMER_IF_CTRL_REG);
 }
 
 static int omap_timer_context_notifier(struct notifier_block *nb,
@@ -266,8 +259,7 @@ static int omap_dm_timer_reset(struct omap_dm_timer *timer)
 	omap_dm_timer_write_reg(timer, OMAP_TIMER_IF_CTRL_REG, 0x06);
 
 	do {
-		l = __omap_dm_timer_read(timer,
-					 OMAP_TIMER_V1_SYS_STAT_OFFSET, 0);
+		l = dmtimer_read(timer, OMAP_TIMER_V1_SYS_STAT_OFFSET);
 	} while (!l && timeout--);
 
 	if (!timeout) {
@@ -276,7 +268,7 @@ static int omap_dm_timer_reset(struct omap_dm_timer *timer)
 	}
 
 	/* Configure timer for smart-idle mode */
-	l = __omap_dm_timer_read(timer, OMAP_TIMER_OCP_CFG_OFFSET, 0);
+	l = dmtimer_read(timer, OMAP_TIMER_OCP_CFG_OFFSET);
 	l |= 0x2 << 0x3;
 	__omap_dm_timer_write(timer, OMAP_TIMER_OCP_CFG_OFFSET, l, 0);
 
@@ -550,7 +542,7 @@ __u32 omap_dm_timer_modify_idlect_mask(__u32 inputmask)
 	list_for_each_entry(timer, &omap_timer_list, node) {
 		u32 l;
 
-		l = omap_dm_timer_read_reg(timer, OMAP_TIMER_CTRL_REG);
+		l = dmtimer_read(timer, OMAP_TIMER_CTRL_REG);
 		if (l & OMAP_TIMER_CTRL_ST) {
 			if (((omap_readl(MOD_CONF_CTRL_1) >> (i * 2)) & 0x03) == 0)
 				inputmask &= ~(1 << 1);
@@ -591,7 +583,7 @@ static int omap_dm_timer_start(struct omap_dm_timer *timer)
 
 	omap_dm_timer_enable(timer);
 
-	l = omap_dm_timer_read_reg(timer, OMAP_TIMER_CTRL_REG);
+	l = dmtimer_read(timer, OMAP_TIMER_CTRL_REG);
 	if (!(l & OMAP_TIMER_CTRL_ST)) {
 		l |= OMAP_TIMER_CTRL_ST;
 		omap_dm_timer_write_reg(timer, OMAP_TIMER_CTRL_REG, l);
@@ -638,7 +630,7 @@ static int omap_dm_timer_set_match(struct omap_dm_timer *timer, int enable,
 		return -EINVAL;
 
 	omap_dm_timer_enable(timer);
-	l = omap_dm_timer_read_reg(timer, OMAP_TIMER_CTRL_REG);
+	l = dmtimer_read(timer, OMAP_TIMER_CTRL_REG);
 	if (enable)
 		l |= OMAP_TIMER_CTRL_CE;
 	else
@@ -659,7 +651,7 @@ static int omap_dm_timer_set_pwm(struct omap_dm_timer *timer, int def_on,
 		return -EINVAL;
 
 	omap_dm_timer_enable(timer);
-	l = omap_dm_timer_read_reg(timer, OMAP_TIMER_CTRL_REG);
+	l = dmtimer_read(timer, OMAP_TIMER_CTRL_REG);
 	l &= ~(OMAP_TIMER_CTRL_GPOCFG | OMAP_TIMER_CTRL_SCPWM |
 	       OMAP_TIMER_CTRL_PT | (0x03 << 10) | OMAP_TIMER_CTRL_AR);
 	if (def_on)
@@ -683,7 +675,7 @@ static int omap_dm_timer_get_pwm_status(struct omap_dm_timer *timer)
 		return -EINVAL;
 
 	omap_dm_timer_enable(timer);
-	l = omap_dm_timer_read_reg(timer, OMAP_TIMER_CTRL_REG);
+	l = dmtimer_read(timer, OMAP_TIMER_CTRL_REG);
 	omap_dm_timer_disable(timer);
 
 	return l;
@@ -698,7 +690,7 @@ static int omap_dm_timer_set_prescaler(struct omap_dm_timer *timer,
 		return -EINVAL;
 
 	omap_dm_timer_enable(timer);
-	l = omap_dm_timer_read_reg(timer, OMAP_TIMER_CTRL_REG);
+	l = dmtimer_read(timer, OMAP_TIMER_CTRL_REG);
 	l &= ~(OMAP_TIMER_CTRL_PRE | (0x07 << 2));
 	if (prescaler >= 0) {
 		l |= OMAP_TIMER_CTRL_PRE;
@@ -743,7 +735,7 @@ static int omap_dm_timer_set_int_disable(struct omap_dm_timer *timer, u32 mask)
 		l = readl_relaxed(timer->irq_ena) & ~mask;
 
 	writel_relaxed(l, timer->irq_dis);
-	l = omap_dm_timer_read_reg(timer, OMAP_TIMER_WAKEUP_EN_REG) & ~mask;
+	l = dmtimer_read(timer, OMAP_TIMER_WAKEUP_EN_REG) & ~mask;
 	omap_dm_timer_write_reg(timer, OMAP_TIMER_WAKEUP_EN_REG, l);
 
 	omap_dm_timer_disable(timer);
@@ -781,7 +773,7 @@ static unsigned int omap_dm_timer_read_counter(struct omap_dm_timer *timer)
 		return 0;
 	}
 
-	return __omap_dm_timer_read_counter(timer, timer->posted);
+	return __omap_dm_timer_read_counter(timer);
 }
 
 static int omap_dm_timer_write_counter(struct omap_dm_timer *timer, unsigned int value)
