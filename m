Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20FEA5F3FB9
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 11:31:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230435AbiJDJbY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 05:31:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229656AbiJDJ1u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 05:27:50 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A905CB8E;
        Tue,  4 Oct 2022 02:27:12 -0700 (PDT)
Date:   Tue, 04 Oct 2022 09:27:10 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1664875631;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=z+XWvRX1Rl1VuqkMrdEzMJPu4W5ECY2LKlIt9ZQ9JNk=;
        b=sYg0qITuk9jj4s4Ookv8dOsM+XNsh9SgA+pzKZJW3OTw67mzmftIxnoJbAVVkZuyeBiYPq
        lsHFuUz19Hno6VWiSFJfsNvoN8eP2UaH4JcEptRHsmY8+j8JaQLaCA9ixuyAYH3JQyA1Eg
        ls3dqqDepqjzjyMXuHEbLUl8z6VhycGehrPmO/+ARGLKwfvOl2O0/+a5Cc9YI/apT649NE
        SyvZTVuOTv1VNG+NfbBS9yMTBWsTq6+1M94g3bIzNipcP2urZrnsX8kS8L8buC89ovo5XQ
        lU2kq5Twc6zvadBkL8qaCjbW5A/L/6UHsGHJCPjBTH25Bd5QmZZU7qWyJJ11ZQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1664875631;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=z+XWvRX1Rl1VuqkMrdEzMJPu4W5ECY2LKlIt9ZQ9JNk=;
        b=e3EoZEdQPwF10XxYMGvwzWEKoXokd9K4Q6V0kyVLZDWRyoYSjtdXA/bpSyaCVU3HYUeTHI
        zcWyA3iTKO4mY8Cw==
From:   "tip-bot2 for Tony Lindgren" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] clocksource/drivers/timer-ti-dm: Add flag to detect omap1
Cc:     Tony Lindgren <tony@atomide.com>,
        Janusz Krzysztofik <jmkrzyszt@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220815131250.34603-9-tony@atomide.com>
References: <20220815131250.34603-9-tony@atomide.com>
MIME-Version: 1.0
Message-ID: <166487563010.401.13771168833507122319.tip-bot2@tip-bot2>
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

Commit-ID:     664ad59da11687ef9b518fc2519af6a71a1db9f1
Gitweb:        https://git.kernel.org/tip/664ad59da11687ef9b518fc2519af6a71a1db9f1
Author:        Tony Lindgren <tony@atomide.com>
AuthorDate:    Mon, 15 Aug 2022 16:12:49 +03:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Tue, 20 Sep 2022 10:49:46 +02:00

clocksource/drivers/timer-ti-dm: Add flag to detect omap1

Let's make it clear that some features need to be tested currently on
omap1. Only omap1 still uses platform_data.

Signed-off-by: Tony Lindgren <tony@atomide.com>
Reviewed-by: Janusz Krzysztofik <jmkrzyszt@gmail.com>
Link: https://lore.kernel.org/r/20220815131250.34603-9-tony@atomide.com
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/clocksource/timer-ti-dm.c |  9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/clocksource/timer-ti-dm.c b/drivers/clocksource/timer-ti-dm.c
index 0d0130e..2310f97 100644
--- a/drivers/clocksource/timer-ti-dm.c
+++ b/drivers/clocksource/timer-ti-dm.c
@@ -133,6 +133,7 @@ struct dmtimer {
 	unsigned long rate;
 	unsigned reserved:1;
 	unsigned posted:1;
+	unsigned omap1:1;
 	struct timer_regs context;
 	int revision;
 	u32 capability;
@@ -423,7 +424,7 @@ static int omap_dm_timer_set_source(struct omap_dm_timer *cookie, int source)
 	 * use the clock framework to set the parent clock. To be removed
 	 * once OMAP1 migrated to using clock framework for dmtimers
 	 */
-	if (pdata && pdata->set_timer_src)
+	if (timer->omap1 && pdata && pdata->set_timer_src)
 		return pdata->set_timer_src(timer->pdev, source);
 
 #if defined(CONFIG_COMMON_CLK)
@@ -476,7 +477,7 @@ static int omap_dm_timer_prepare(struct dmtimer *timer)
 	 * FIXME: OMAP1 devices do not use the clock framework for dmtimers so
 	 * do not call clk_get() for these devices.
 	 */
-	if (!(timer->capability & OMAP_TIMER_NEEDS_RESET)) {
+	if (!timer->omap1) {
 		timer->fclk = clk_get(&timer->pdev->dev, "fck");
 		if (WARN_ON_ONCE(IS_ERR(timer->fclk))) {
 			dev_err(&timer->pdev->dev, ": No fclk handle.\n");
@@ -763,7 +764,7 @@ static int omap_dm_timer_stop(struct omap_dm_timer *cookie)
 
 	dev = &timer->pdev->dev;
 
-	if (!(timer->capability & OMAP_TIMER_NEEDS_RESET))
+	if (!timer->omap1)
 		rate = clk_get_rate(timer->fclk);
 
 	__omap_dm_timer_stop(timer, rate);
@@ -1119,6 +1120,8 @@ static int omap_dm_timer_probe(struct platform_device *pdev)
 		timer->reserved = omap_dm_timer_reserved_systimer(timer->id);
 	}
 
+	timer->omap1 = timer->capability & OMAP_TIMER_NEEDS_RESET;
+
 	if (!(timer->capability & OMAP_TIMER_ALWON)) {
 		timer->nb.notifier_call = omap_timer_context_notifier;
 		cpu_pm_register_notifier(&timer->nb);
