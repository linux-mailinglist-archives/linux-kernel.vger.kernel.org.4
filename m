Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62BF45F3FB7
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 11:31:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229766AbiJDJbM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 05:31:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbiJDJ1t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 05:27:49 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A70AE268;
        Tue,  4 Oct 2022 02:27:11 -0700 (PDT)
Date:   Tue, 04 Oct 2022 09:27:09 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1664875630;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bjO1yx2ZmJ/fwGYbywClmLhI9D7iW4UUWVmJvkwsN2A=;
        b=lx1wOLFV5R5OYy/hNntAmOk9dE/cWq1CVHyJg3I8iaMgfNdXaLIiS3p9fZR2msJCBU2s2a
        3CwKPab92oMB44vUTVsMK8sJIBGqcHZN+CKD1iXZxPWcXjXbqdOO9eko7OIGOTkjtUN30g
        VJqjinJ7yIUR4cN3JT7pQyF0wvqqeGOWHb8G0NI4vgUFFQuLYyU3cjTKX7SQBUI+/U4b8Y
        c94N92vmoMxkHjxqESHnhLykYfhQCWpmSM4g9eqpnXgDSOsAkZ7RsuxBfM+AtUnksuK6B1
        JDT4zLyCr68N04DS1Ms8Mhyq1m+khnc0uIrJuRYq1jKhmcE6/sPzbapLGzxlMQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1664875630;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bjO1yx2ZmJ/fwGYbywClmLhI9D7iW4UUWVmJvkwsN2A=;
        b=cyzK8yH0M0x0Uooc4sTyq37ToP428aKESmlimqIvyW5bUHnllSXuQr9ADziCsjUd5e5osx
        6xnkfhfmMXYfEmAg==
From:   "tip-bot2 for Tony Lindgren" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] clocksource/drivers/timer-ti-dm: Get clock in
 probe with devm_clk_get()
Cc:     Tony Lindgren <tony@atomide.com>,
        Janusz Krzysztofik <jmkrzyszt@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220815131250.34603-10-tony@atomide.com>
References: <20220815131250.34603-10-tony@atomide.com>
MIME-Version: 1.0
Message-ID: <166487562906.401.7725425779932812533.tip-bot2@tip-bot2>
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

Commit-ID:     789d4b1070261fa98b06384d2067f23c080dc9f1
Gitweb:        https://git.kernel.org/tip/789d4b1070261fa98b06384d2067f23c080dc9f1
Author:        Tony Lindgren <tony@atomide.com>
AuthorDate:    Mon, 15 Aug 2022 16:12:50 +03:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Tue, 20 Sep 2022 10:49:46 +02:00

clocksource/drivers/timer-ti-dm: Get clock in probe with devm_clk_get()

We can simplify the code a bit by getting the clock in probe, and using
devm_clk_get(). This will also make further changes easier as the clock
is available in probe instead of prepare.

Signed-off-by: Tony Lindgren <tony@atomide.com>
Reviewed-by: Janusz Krzysztofik <jmkrzyszt@gmail.com>
Link: https://lore.kernel.org/r/20220815131250.34603-10-tony@atomide.com
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/clocksource/timer-ti-dm.c | 24 +++++++++---------------
 1 file changed, 9 insertions(+), 15 deletions(-)

diff --git a/drivers/clocksource/timer-ti-dm.c b/drivers/clocksource/timer-ti-dm.c
index 2310f97..cad29de 100644
--- a/drivers/clocksource/timer-ti-dm.c
+++ b/drivers/clocksource/timer-ti-dm.c
@@ -473,18 +473,6 @@ static int omap_dm_timer_prepare(struct dmtimer *timer)
 	struct device *dev = &timer->pdev->dev;
 	int rc;
 
-	/*
-	 * FIXME: OMAP1 devices do not use the clock framework for dmtimers so
-	 * do not call clk_get() for these devices.
-	 */
-	if (!timer->omap1) {
-		timer->fclk = clk_get(&timer->pdev->dev, "fck");
-		if (WARN_ON_ONCE(IS_ERR(timer->fclk))) {
-			dev_err(&timer->pdev->dev, ": No fclk handle.\n");
-			return -EINVAL;
-		}
-	}
-
 	rc = pm_runtime_resume_and_get(dev);
 	if (rc)
 		return rc;
@@ -650,8 +638,6 @@ static int omap_dm_timer_free(struct omap_dm_timer *cookie)
 	if (unlikely(!timer))
 		return -EINVAL;
 
-	clk_put(timer->fclk);
-
 	WARN_ON(!timer->reserved);
 	timer->reserved = 0;
 	return 0;
@@ -1098,7 +1084,6 @@ static int omap_dm_timer_probe(struct platform_device *pdev)
 	if (timer->irq < 0)
 		return timer->irq;
 
-	timer->fclk = ERR_PTR(-ENODEV);
 	timer->io_base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(timer->io_base))
 		return PTR_ERR(timer->io_base);
@@ -1122,6 +1107,15 @@ static int omap_dm_timer_probe(struct platform_device *pdev)
 
 	timer->omap1 = timer->capability & OMAP_TIMER_NEEDS_RESET;
 
+	/* OMAP1 devices do not yet use the clock framework for dmtimers */
+	if (!timer->omap1) {
+		timer->fclk = devm_clk_get(dev, "fck");
+		if (IS_ERR(timer->fclk))
+			return PTR_ERR(timer->fclk);
+	} else {
+		timer->fclk = ERR_PTR(-ENODEV);
+	}
+
 	if (!(timer->capability & OMAP_TIMER_ALWON)) {
 		timer->nb.notifier_call = omap_timer_context_notifier;
 		cpu_pm_register_notifier(&timer->nb);
