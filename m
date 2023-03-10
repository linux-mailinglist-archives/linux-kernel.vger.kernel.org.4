Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 008376B4706
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 15:48:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233145AbjCJOsL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 09:48:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233040AbjCJOr0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 09:47:26 -0500
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE4AA106A21;
        Fri, 10 Mar 2023 06:47:09 -0800 (PST)
Received: by mail-ot1-f44.google.com with SMTP id q11-20020a056830440b00b00693c1a62101so3124717otv.0;
        Fri, 10 Mar 2023 06:47:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678459628;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hfLrJYXWK6RyVTaifFzrweAneLATHq9QV1m6jErXVD8=;
        b=F6BMe8pidXZ5zbKSS0fAMCL/gysF2B2fqRy9qSFtQyjVAb7h5P0FpprVVjO2LXwm+3
         s6ylM/SwKLaGn2l1PoVMqiNLNeNHCd7nGNrIOzPrrZCFfNPzImKwTDORw6f4YYk6Bwf0
         Ns0hyclywW0vLisM3sPblmBFBTUDhXrdWf3ooRWD2llxqWI91EKzXFXvKIFMfcjWSpz7
         HVaSebdZtgvKczT6jdrhiEd01ekTRVQ/KWmi4aUF4OaX51R9oBsvF54yzG1mdX2nFbMe
         MCsPebZSkcb+9CMec1rx/dwNIiM7g/p1BXk454quRo5c8kF05Q9eP6wX6gd2L8I2LKUN
         7Bxw==
X-Gm-Message-State: AO0yUKU432Tw/AGikBkzjldZ7tW4LNAWixgDEzBg7SU4AB44M41ED82/
        HD7oHtYBWu7fHb6DADpT6/z9Gku2aQ==
X-Google-Smtp-Source: AK7set9qQDk7ob7K6LJecfWfBdx84fXQeqqY7Mtlmf7ALkvJplnG8TCZ8x/cabw61/2bPBnXyo9o8w==
X-Received: by 2002:a05:6830:3692:b0:68d:3fc8:7c0a with SMTP id bk18-20020a056830369200b0068d3fc87c0amr1209666otb.5.1678459628279;
        Fri, 10 Mar 2023 06:47:08 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id p7-20020a0568301d4700b0068bcadcad5bsm103732oth.57.2023.03.10.06.47.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Mar 2023 06:47:07 -0800 (PST)
Received: (nullmailer pid 1541686 invoked by uid 1000);
        Fri, 10 Mar 2023 14:47:02 -0000
From:   Rob Herring <robh@kernel.org>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] clocksource: ti: Use of_property_read_bool() for boolean properties
Date:   Fri, 10 Mar 2023 08:47:01 -0600
Message-Id: <20230310144702.1541660-1-robh@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is preferred to use typed property access functions (i.e.
of_property_read_<type> functions) rather than low-level
of_get_property/of_find_property functions for reading properties.
Convert reading boolean properties to to of_property_read_bool().

Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/clocksource/timer-ti-dm-systimer.c | 4 ++--
 drivers/clocksource/timer-ti-dm.c          | 8 ++++----
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/clocksource/timer-ti-dm-systimer.c b/drivers/clocksource/timer-ti-dm-systimer.c
index 632523c1232f..efa5f55a65f8 100644
--- a/drivers/clocksource/timer-ti-dm-systimer.c
+++ b/drivers/clocksource/timer-ti-dm-systimer.c
@@ -586,7 +586,7 @@ static int __init dmtimer_clkevt_init_common(struct dmtimer_clockevent *clkevt,
 	writel_relaxed(OMAP_TIMER_INT_OVERFLOW, t->base + t->wakeup);
 
 	pr_info("TI gptimer %s: %s%lu Hz at %pOF\n",
-		name, of_find_property(np, "ti,timer-alwon", NULL) ?
+		name, of_property_read_bool(np, "ti,timer-alwon") ?
 		"always-on " : "", t->rate, np->parent);
 
 	return 0;
@@ -787,7 +787,7 @@ static int __init dmtimer_clocksource_init(struct device_node *np)
 		       t->base + t->ctrl);
 
 	pr_info("TI gptimer clocksource: %s%pOF\n",
-		of_find_property(np, "ti,timer-alwon", NULL) ?
+		of_property_read_bool(np, "ti,timer-alwon") ?
 		"always-on " : "", np->parent);
 
 	if (!dmtimer_sched_clock_counter) {
diff --git a/drivers/clocksource/timer-ti-dm.c b/drivers/clocksource/timer-ti-dm.c
index b24b903a8822..7031aa1bfdcb 100644
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
-- 
2.39.2

