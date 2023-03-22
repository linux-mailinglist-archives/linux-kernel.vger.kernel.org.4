Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEADB6C4F54
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 16:21:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231612AbjCVPVt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 11:21:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230476AbjCVPVr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 11:21:47 -0400
Received: from hust.edu.cn (unknown [202.114.0.240])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 250C65C137
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 08:21:45 -0700 (PDT)
Received: from dqrubuntu.lan ([172.16.0.254])
        (user=flno@hust.edu.cn mech=LOGIN bits=0)
        by mx1.hust.edu.cn  with ESMTP id 32MFKJY7011977-32MFKJYA011977
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 22 Mar 2023 23:20:19 +0800
From:   Qinrun Dai <flno@hust.edu.cn>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Cc:     hust-os-kernel-patches@googlegroups.com,
        Qinrun Dai <flno@hust.edu.cn>, linux-kernel@vger.kernel.org
Subject: [PATCH] drivers: clocksource: fix memory leak in davinci_timer_register
Date:   Wed, 22 Mar 2023 15:19:45 +0000
Message-Id: <20230322151945.102353-1-flno@hust.edu.cn>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-FEAS-AUTH-USER: flno@hust.edu.cn
X-Spam-Status: No, score=-0.0 required=5.0 tests=SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Smatch reports:
drivers/clocksource/timer-davinci.c:332 davinci_timer_register()
warn: 'base' from ioremap() not released on lines: 274.

Fix this by defining a unified function exit
to iounmap 'base' and return corresponding value.

Fixes: 721154f972aa ("clocksource/drivers/davinci: Add support for clockevents")
Signed-off-by: Qinrun Dai <flno@hust.edu.cn>
---
 drivers/clocksource/timer-davinci.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/clocksource/timer-davinci.c b/drivers/clocksource/timer-davinci.c
index 9996c0542520..a6dd1da9e6d1 100644
--- a/drivers/clocksource/timer-davinci.c
+++ b/drivers/clocksource/timer-davinci.c
@@ -270,8 +270,10 @@ int __init davinci_timer_register(struct clk *clk,
 	tick_rate = clk_get_rate(clk);
 
 	clockevent = kzalloc(sizeof(*clockevent), GFP_KERNEL);
-	if (!clockevent)
-		return -ENOMEM;
+	if (!clockevent) {
+		rv = -ENOMEM;
+		goto iounmap_base;
+	}
 
 	clockevent->dev.name = "tim12";
 	clockevent->dev.features = CLOCK_EVT_FEAT_ONESHOT;
@@ -296,7 +298,7 @@ int __init davinci_timer_register(struct clk *clk,
 			 "clockevent/tim12", clockevent);
 	if (rv) {
 		pr_err("Unable to request the clockevent interrupt\n");
-		return rv;
+		goto iounmap_base;
 	}
 
 	davinci_clocksource.dev.rating = 300;
@@ -323,13 +325,17 @@ int __init davinci_timer_register(struct clk *clk,
 	rv = clocksource_register_hz(&davinci_clocksource.dev, tick_rate);
 	if (rv) {
 		pr_err("Unable to register clocksource\n");
-		return rv;
+		goto iounmap_base;
 	}
 
 	sched_clock_register(davinci_timer_read_sched_clock,
 			     DAVINCI_TIMER_CLKSRC_BITS, tick_rate);
 
 	return 0;
+
+iounmap_base:
+	iounmap(base);
+	return rv;
 }
 
 static int __init of_davinci_timer_register(struct device_node *np)
-- 
2.37.2

