Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBE1F6EF0BF
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 11:12:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240222AbjDZJMv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 05:12:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240020AbjDZJMe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 05:12:34 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B23940EB;
        Wed, 26 Apr 2023 02:12:32 -0700 (PDT)
Date:   Wed, 26 Apr 2023 09:12:30 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1682500351;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PW2qdQNYhjoc3puUY5UKoVoCOqDj2zdCmLzkt/LCC4w=;
        b=an9ooknCDztkENrctmPhNJLnTMLa5px7gapNmTdn2e18P5evIvH8Cykrrp6gvOeNimc5r6
        rKDuejLaGU+y8y7AUZ4l5zv97Qa+4AmvIQl2PTQdUBTnF7xkLXgB8XPrg34DWCWneZHIkl
        SKWE2/FtwFvwSJ7VtslFoe8O7cXnjpZuogiay82i0tDy4hSc0XcT0c3ol8nb1ZZoasAc4K
        eATFvWy4ueOOHFgVqJf++q//gt+JTM/zM4e61yeYBvYwRoJLVSevODyhXf6SnbpiVDzgeu
        r5My1ACfTKYLICg7KHnaCR21E6XElmCPE0ww6GKjH2Nmhfnx/a0MR0E3wh4hQA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1682500351;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PW2qdQNYhjoc3puUY5UKoVoCOqDj2zdCmLzkt/LCC4w=;
        b=Bh/Es1c6zWu+32DP7NPEWFt1GQfLa/IByWY6YnK2mAHGCNwUc5DVBwVw0+GFE+DxGnHj2n
        ak7x06hXsZaEtJAg==
From:   "tip-bot2 for Rob Herring" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] clocksource/drivers/ti: Use
 of_property_read_bool() for boolean properties
Cc:     Rob Herring <robh@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230310144702.1541660-1-robh@kernel.org>
References: <20230310144702.1541660-1-robh@kernel.org>
MIME-Version: 1.0
Message-ID: <168250035069.404.8593852242747733907.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     87dd04f9b1a37a92ebbea5eb46e4941551d3547e
Gitweb:        https://git.kernel.org/tip/87dd04f9b1a37a92ebbea5eb46e4941551d3547e
Author:        Rob Herring <robh@kernel.org>
AuthorDate:    Fri, 10 Mar 2023 08:47:01 -06:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Mon, 24 Apr 2023 16:56:14 +02:00

clocksource/drivers/ti: Use of_property_read_bool() for boolean properties

It is preferred to use typed property access functions (i.e.
of_property_read_<type> functions) rather than low-level
of_get_property/of_find_property functions for reading properties.
Convert reading boolean properties to to of_property_read_bool().

Signed-off-by: Rob Herring <robh@kernel.org>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20230310144702.1541660-1-robh@kernel.org
---
 drivers/clocksource/timer-ti-dm-systimer.c | 4 ++--
 drivers/clocksource/timer-ti-dm.c          | 8 ++++----
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/clocksource/timer-ti-dm-systimer.c b/drivers/clocksource/timer-ti-dm-systimer.c
index 4fa68f6..c2dcd8d 100644
--- a/drivers/clocksource/timer-ti-dm-systimer.c
+++ b/drivers/clocksource/timer-ti-dm-systimer.c
@@ -584,7 +584,7 @@ static int __init dmtimer_clkevt_init_common(struct dmtimer_clockevent *clkevt,
 	writel_relaxed(OMAP_TIMER_INT_OVERFLOW, t->base + t->wakeup);
 
 	pr_info("TI gptimer %s: %s%lu Hz at %pOF\n",
-		name, of_find_property(np, "ti,timer-alwon", NULL) ?
+		name, of_property_read_bool(np, "ti,timer-alwon") ?
 		"always-on " : "", t->rate, np->parent);
 
 	return 0;
@@ -785,7 +785,7 @@ static int __init dmtimer_clocksource_init(struct device_node *np)
 		       t->base + t->ctrl);
 
 	pr_info("TI gptimer clocksource: %s%pOF\n",
-		of_find_property(np, "ti,timer-alwon", NULL) ?
+		of_property_read_bool(np, "ti,timer-alwon") ?
 		"always-on " : "", np->parent);
 
 	if (!dmtimer_sched_clock_counter) {
diff --git a/drivers/clocksource/timer-ti-dm.c b/drivers/clocksource/timer-ti-dm.c
index ab7a6ca..1d3ad51 100644
--- a/drivers/clocksource/timer-ti-dm.c
+++ b/drivers/clocksource/timer-ti-dm.c
@@ -1104,13 +1104,13 @@ static int omap_dm_timer_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, timer);
 
 	if (dev->of_node) {
-		if (of_find_property(dev->of_node, "ti,timer-alwon", NULL))
+		if (of_property_read_bool(dev->of_node, "ti,timer-alwon"))
 			timer->capability |= OMAP_TIMER_ALWON;
-		if (of_find_property(dev->of_node, "ti,timer-dsp", NULL))
+		if (of_property_read_bool(dev->of_node, "ti,timer-dsp"))
 			timer->capability |= OMAP_TIMER_HAS_DSP_IRQ;
-		if (of_find_property(dev->of_node, "ti,timer-pwm", NULL))
+		if (of_property_read_bool(dev->of_node, "ti,timer-pwm"))
 			timer->capability |= OMAP_TIMER_HAS_PWM;
-		if (of_find_property(dev->of_node, "ti,timer-secure", NULL))
+		if (of_property_read_bool(dev->of_node, "ti,timer-secure"))
 			timer->capability |= OMAP_TIMER_SECURE;
 	} else {
 		timer->id = pdev->id;
