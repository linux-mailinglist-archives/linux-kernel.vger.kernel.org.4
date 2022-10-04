Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA6D65F3FB4
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 11:31:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231246AbiJDJbA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 05:31:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229747AbiJDJ1v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 05:27:51 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3206113B;
        Tue,  4 Oct 2022 02:27:14 -0700 (PDT)
Date:   Tue, 04 Oct 2022 09:27:12 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1664875633;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4Axy6oEl0G/m1QYDzCDNBtl17CMA6/eZk2j5dYDV6BU=;
        b=sOpvgYPFA4q82Z5HRqSHFZzeGUkHghUIrcEEPK0ELXArRjXuD3CabzBs0fpUMvuejfcddH
        CXhFuiMFS7OEDG5jWzD5RqWYA0reHgQYHuVUy+mDUXLlNW8jPedG8O+zY9DBKFqW/f6/Xc
        FgHzrRppiIqNOteH07Vqgo/D9cP0nioY0DT+5cTa2EYLmnuWRl8shtB5XPiXaF6UqdlVMR
        gloKVE1U688IpXNjsrXQSfDAxyNcFxQr94ZeOzBME8qzoocxvBPAMTQHHN+OvBqGSfPz0Z
        6rxIDxlw3zgJhMEXiqHSK/6uN2t/uE0vwOK59dOfJjiWWq1HSlglbVnm/7gjgA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1664875633;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4Axy6oEl0G/m1QYDzCDNBtl17CMA6/eZk2j5dYDV6BU=;
        b=ukZv2vnpImusdVbRwxlQQUvvaIuv6UhtybDFgwAj5k6ZyAza/rpUnf8BavBOZeOc5Z5V+m
        +KBDPKtBNkoWfWAA==
From:   "tip-bot2 for Tony Lindgren" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] clocksource/drivers/timer-ti-dm: Use runtime PM
 directly and check errors
Cc:     Tony Lindgren <tony@atomide.com>,
        Janusz Krzysztofik <jmkrzyszt@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220815131250.34603-7-tony@atomide.com>
References: <20220815131250.34603-7-tony@atomide.com>
MIME-Version: 1.0
Message-ID: <166487563219.401.775787710496247933.tip-bot2@tip-bot2>
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

Commit-ID:     bd351f1aee21ca667b39658550b5f3c61e8bb77f
Gitweb:        https://git.kernel.org/tip/bd351f1aee21ca667b39658550b5f3c61e8bb77f
Author:        Tony Lindgren <tony@atomide.com>
AuthorDate:    Mon, 15 Aug 2022 16:12:47 +03:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Tue, 20 Sep 2022 10:49:46 +02:00

clocksource/drivers/timer-ti-dm: Use runtime PM directly and check errors

Use pm_runtime_resume_and_get() and check for a possible error returned.

We want to do this as omap_dm_timer_enable() and omap_dm_timer_disable()
are exposed to the pwm and remoteproc drivers, and in the following patch
we turn struct omap_dm_timer into a cookie used by the exposed functions
only.

Signed-off-by: Tony Lindgren <tony@atomide.com>
Reviewed-by: Janusz Krzysztofik <jmkrzyszt@gmail.com>
Link: https://lore.kernel.org/r/20220815131250.34603-7-tony@atomide.com
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/clocksource/timer-ti-dm.c | 117 ++++++++++++++++++++++-------
 1 file changed, 91 insertions(+), 26 deletions(-)

diff --git a/drivers/clocksource/timer-ti-dm.c b/drivers/clocksource/timer-ti-dm.c
index e82ec56..4967a91 100644
--- a/drivers/clocksource/timer-ti-dm.c
+++ b/drivers/clocksource/timer-ti-dm.c
@@ -387,16 +387,24 @@ static int omap_dm_timer_set_source(struct omap_dm_timer *timer, int source)
 
 static void omap_dm_timer_enable(struct omap_dm_timer *timer)
 {
-	pm_runtime_get_sync(&timer->pdev->dev);
+	struct device *dev = &timer->pdev->dev;
+	int rc;
+
+	rc = pm_runtime_resume_and_get(dev);
+	if (rc)
+		dev_err(dev, "could not enable timer\n");
 }
 
 static void omap_dm_timer_disable(struct omap_dm_timer *timer)
 {
-	pm_runtime_put_sync(&timer->pdev->dev);
+	struct device *dev = &timer->pdev->dev;
+
+	pm_runtime_put_sync(dev);
 }
 
 static int omap_dm_timer_prepare(struct omap_dm_timer *timer)
 {
+	struct device *dev = &timer->pdev->dev;
 	int rc;
 
 	/*
@@ -411,18 +419,20 @@ static int omap_dm_timer_prepare(struct omap_dm_timer *timer)
 		}
 	}
 
-	omap_dm_timer_enable(timer);
+	rc = pm_runtime_resume_and_get(dev);
+	if (rc)
+		return rc;
 
 	if (timer->capability & OMAP_TIMER_NEEDS_RESET) {
 		rc = omap_dm_timer_reset(timer);
 		if (rc) {
-			omap_dm_timer_disable(timer);
+			pm_runtime_put_sync(dev);
 			return rc;
 		}
 	}
 
 	__omap_dm_timer_enable_posted(timer);
-	omap_dm_timer_disable(timer);
+	pm_runtime_put_sync(dev);
 
 	return 0;
 }
@@ -628,12 +638,16 @@ __u32 omap_dm_timer_modify_idlect_mask(__u32 inputmask)
 
 static int omap_dm_timer_start(struct omap_dm_timer *timer)
 {
+	struct device *dev = &timer->pdev->dev;
+	int rc;
 	u32 l;
 
 	if (unlikely(!timer))
 		return -EINVAL;
 
-	omap_dm_timer_enable(timer);
+	rc = pm_runtime_resume_and_get(dev);
+	if (rc)
+		return rc;
 
 	l = dmtimer_read(timer, OMAP_TIMER_CTRL_REG);
 	if (!(l & OMAP_TIMER_CTRL_ST)) {
@@ -646,6 +660,7 @@ static int omap_dm_timer_start(struct omap_dm_timer *timer)
 
 static int omap_dm_timer_stop(struct omap_dm_timer *timer)
 {
+	struct device *dev = &timer->pdev->dev;
 	unsigned long rate = 0;
 
 	if (unlikely(!timer))
@@ -656,32 +671,47 @@ static int omap_dm_timer_stop(struct omap_dm_timer *timer)
 
 	__omap_dm_timer_stop(timer, rate);
 
-	omap_dm_timer_disable(timer);
+	pm_runtime_put_sync(dev);
+
 	return 0;
 }
 
 static int omap_dm_timer_set_load(struct omap_dm_timer *timer,
 				  unsigned int load)
 {
+	struct device *dev;
+	int rc;
+
 	if (unlikely(!timer))
 		return -EINVAL;
 
-	omap_dm_timer_enable(timer);
+	dev = &timer->pdev->dev;
+	rc = pm_runtime_resume_and_get(dev);
+	if (rc)
+		return rc;
+
 	dmtimer_write(timer, OMAP_TIMER_LOAD_REG, load);
 
-	omap_dm_timer_disable(timer);
+	pm_runtime_put_sync(dev);
+
 	return 0;
 }
 
 static int omap_dm_timer_set_match(struct omap_dm_timer *timer, int enable,
 				   unsigned int match)
 {
+	struct device *dev;
+	int rc;
 	u32 l;
 
 	if (unlikely(!timer))
 		return -EINVAL;
 
-	omap_dm_timer_enable(timer);
+	dev = &timer->pdev->dev;
+	rc = pm_runtime_resume_and_get(dev);
+	if (rc)
+		return rc;
+
 	l = dmtimer_read(timer, OMAP_TIMER_CTRL_REG);
 	if (enable)
 		l |= OMAP_TIMER_CTRL_CE;
@@ -690,19 +720,26 @@ static int omap_dm_timer_set_match(struct omap_dm_timer *timer, int enable,
 	dmtimer_write(timer, OMAP_TIMER_MATCH_REG, match);
 	dmtimer_write(timer, OMAP_TIMER_CTRL_REG, l);
 
-	omap_dm_timer_disable(timer);
+	pm_runtime_put_sync(dev);
+
 	return 0;
 }
 
 static int omap_dm_timer_set_pwm(struct omap_dm_timer *timer, int def_on,
 				 int toggle, int trigger, int autoreload)
 {
+	struct device *dev;
+	int rc;
 	u32 l;
 
 	if (unlikely(!timer))
 		return -EINVAL;
 
-	omap_dm_timer_enable(timer);
+	dev = &timer->pdev->dev;
+	rc = pm_runtime_resume_and_get(dev);
+	if (rc)
+		return rc;
+
 	l = dmtimer_read(timer, OMAP_TIMER_CTRL_REG);
 	l &= ~(OMAP_TIMER_CTRL_GPOCFG | OMAP_TIMER_CTRL_SCPWM |
 	       OMAP_TIMER_CTRL_PT | (0x03 << 10) | OMAP_TIMER_CTRL_AR);
@@ -715,20 +752,28 @@ static int omap_dm_timer_set_pwm(struct omap_dm_timer *timer, int def_on,
 		l |= OMAP_TIMER_CTRL_AR;
 	dmtimer_write(timer, OMAP_TIMER_CTRL_REG, l);
 
-	omap_dm_timer_disable(timer);
+	pm_runtime_put_sync(dev);
+
 	return 0;
 }
 
 static int omap_dm_timer_get_pwm_status(struct omap_dm_timer *timer)
 {
+	struct device *dev;
+	int rc;
 	u32 l;
 
 	if (unlikely(!timer))
 		return -EINVAL;
 
-	omap_dm_timer_enable(timer);
+	dev = &timer->pdev->dev;
+	rc = pm_runtime_resume_and_get(dev);
+	if (rc)
+		return rc;
+
 	l = dmtimer_read(timer, OMAP_TIMER_CTRL_REG);
-	omap_dm_timer_disable(timer);
+
+	pm_runtime_put_sync(dev);
 
 	return l;
 }
@@ -736,12 +781,18 @@ static int omap_dm_timer_get_pwm_status(struct omap_dm_timer *timer)
 static int omap_dm_timer_set_prescaler(struct omap_dm_timer *timer,
 					int prescaler)
 {
+	struct device *dev;
+	int rc;
 	u32 l;
 
 	if (unlikely(!timer) || prescaler < -1 || prescaler > 7)
 		return -EINVAL;
 
-	omap_dm_timer_enable(timer);
+	dev = &timer->pdev->dev;
+	rc = pm_runtime_resume_and_get(dev);
+	if (rc)
+		return rc;
+
 	l = dmtimer_read(timer, OMAP_TIMER_CTRL_REG);
 	l &= ~(OMAP_TIMER_CTRL_PRE | (0x07 << 2));
 	if (prescaler >= 0) {
@@ -750,20 +801,29 @@ static int omap_dm_timer_set_prescaler(struct omap_dm_timer *timer,
 	}
 	dmtimer_write(timer, OMAP_TIMER_CTRL_REG, l);
 
-	omap_dm_timer_disable(timer);
+	pm_runtime_put_sync(dev);
+
 	return 0;
 }
 
 static int omap_dm_timer_set_int_enable(struct omap_dm_timer *timer,
 					unsigned int value)
 {
+	struct device *dev;
+	int rc;
+
 	if (unlikely(!timer))
 		return -EINVAL;
 
-	omap_dm_timer_enable(timer);
+	dev = &timer->pdev->dev;
+	rc = pm_runtime_resume_and_get(dev);
+	if (rc)
+		return rc;
+
 	__omap_dm_timer_int_enable(timer, value);
 
-	omap_dm_timer_disable(timer);
+	pm_runtime_put_sync(dev);
+
 	return 0;
 }
 
@@ -776,12 +836,17 @@ static int omap_dm_timer_set_int_enable(struct omap_dm_timer *timer,
  */
 static int omap_dm_timer_set_int_disable(struct omap_dm_timer *timer, u32 mask)
 {
+	struct device *dev;
 	u32 l = mask;
+	int rc;
 
 	if (unlikely(!timer))
 		return -EINVAL;
 
-	omap_dm_timer_enable(timer);
+	dev = &timer->pdev->dev;
+	rc = pm_runtime_resume_and_get(dev);
+	if (rc)
+		return rc;
 
 	if (timer->revision == 1)
 		l = dmtimer_read(timer, timer->irq_ena) & ~mask;
@@ -790,7 +855,8 @@ static int omap_dm_timer_set_int_disable(struct omap_dm_timer *timer, u32 mask)
 	l = dmtimer_read(timer, OMAP_TIMER_WAKEUP_EN_REG) & ~mask;
 	dmtimer_write(timer, OMAP_TIMER_WAKEUP_EN_REG, l);
 
-	omap_dm_timer_disable(timer);
+	pm_runtime_put_sync(dev);
+
 	return 0;
 }
 
@@ -943,11 +1009,11 @@ static int omap_dm_timer_probe(struct platform_device *pdev)
 	pm_runtime_enable(dev);
 
 	if (!timer->reserved) {
-		ret = pm_runtime_get_sync(dev);
-		if (ret < 0) {
+		ret = pm_runtime_resume_and_get(dev);
+		if (ret) {
 			dev_err(dev, "%s: pm_runtime_get_sync failed!\n",
 				__func__);
-			goto err_get_sync;
+			goto err_disable;
 		}
 		__omap_dm_timer_init_regs(timer);
 		pm_runtime_put(dev);
@@ -962,8 +1028,7 @@ static int omap_dm_timer_probe(struct platform_device *pdev)
 
 	return 0;
 
-err_get_sync:
-	pm_runtime_put_noidle(dev);
+err_disable:
 	pm_runtime_disable(dev);
 	return ret;
 }
