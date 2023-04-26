Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36B0D6EF0CA
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 11:13:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240067AbjDZJNA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 05:13:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240021AbjDZJMe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 05:12:34 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13CAE186;
        Wed, 26 Apr 2023 02:12:33 -0700 (PDT)
Date:   Wed, 26 Apr 2023 09:12:31 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1682500351;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GuxVjsoTXKU254LFESPJjHlOjjGGmyQlCK89QiYa1Mc=;
        b=A43yC7y7Z7nqh1GriBaom01QU4fEEeQsRIWFzCzfNJDu5UFoCtgvMt41B/KemcphHEfTKo
        wUiIaFHKc9cRvFmcxvUrI/US0TtFcsXh8xVcFzv6JafWqK0eSfziwahlfu0c4xV9yK53Nd
        QJjKXjIb/nUM5zzkmqKcXJ0BJ/cVnEtVoJp4h53cPbr4M9CgeZvxv9FfyktR7ltD6nd8gS
        ZXd1fu97npiHd7KjFoPg8NLObtA8iC2uPHESqeIjuRT7HyXYfzCm7SAgdYdWTzGbvTaRRQ
        6LT5+0iFsvPzeNiIJSbpzn7SQh/nOx1Kpzjp+jUQeq/hN4ab0KtoEjPNGcgz5g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1682500351;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GuxVjsoTXKU254LFESPJjHlOjjGGmyQlCK89QiYa1Mc=;
        b=vbgr1vKXWUAGkYUbLOh6W3RfBQd2YKKDlPbWJWVaxMHZZs99AFRWs8zz2n7eSWaEJgTBz1
        a0/ykiZpZ+v1PeCg==
From:   "tip-bot2 for Qinrun Dai" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] clocksource/drivers/davinci: Fix memory leak in
 davinci_timer_register when init fails
Cc:     Qinrun Dai <flno@hust.edu.cn>,
        Daniel Lezcano <daniel.lezcano@linaro.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230413135037.1505799-1-flno@hust.edu.cn>
References: <20230413135037.1505799-1-flno@hust.edu.cn>
MIME-Version: 1.0
Message-ID: <168250035114.404.784113346970013195.tip-bot2@tip-bot2>
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

Commit-ID:     fb73556386e074e9bee9fa2d253aeaefe4e063e0
Gitweb:        https://git.kernel.org/tip/fb73556386e074e9bee9fa2d253aeaefe4e063e0
Author:        Qinrun Dai <flno@hust.edu.cn>
AuthorDate:    Thu, 13 Apr 2023 13:50:37 
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Mon, 24 Apr 2023 16:56:13 +02:00

clocksource/drivers/davinci: Fix memory leak in davinci_timer_register when init fails

Smatch reports:
drivers/clocksource/timer-davinci.c:332 davinci_timer_register()
warn: 'base' from ioremap() not released on lines: 274.

Fix this and other potential memory leak problems
by adding a set of corresponding exit lables.

Fixes: 721154f972aa ("clocksource/drivers/davinci: Add support for clockevents")
Signed-off-by: Qinrun Dai <flno@hust.edu.cn>
Link: https://lore.kernel.org/r/20230413135037.1505799-1-flno@hust.edu.cn
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/clocksource/timer-davinci.c | 30 ++++++++++++++++++++++------
 1 file changed, 24 insertions(+), 6 deletions(-)

diff --git a/drivers/clocksource/timer-davinci.c b/drivers/clocksource/timer-davinci.c
index 9996c05..b1c2484 100644
--- a/drivers/clocksource/timer-davinci.c
+++ b/drivers/clocksource/timer-davinci.c
@@ -257,21 +257,25 @@ int __init davinci_timer_register(struct clk *clk,
 				resource_size(&timer_cfg->reg),
 				"davinci-timer")) {
 		pr_err("Unable to request memory region\n");
-		return -EBUSY;
+		rv = -EBUSY;
+		goto exit_clk_disable;
 	}
 
 	base = ioremap(timer_cfg->reg.start, resource_size(&timer_cfg->reg));
 	if (!base) {
 		pr_err("Unable to map the register range\n");
-		return -ENOMEM;
+		rv = -ENOMEM;
+		goto exit_mem_region;
 	}
 
 	davinci_timer_init(base);
 	tick_rate = clk_get_rate(clk);
 
 	clockevent = kzalloc(sizeof(*clockevent), GFP_KERNEL);
-	if (!clockevent)
-		return -ENOMEM;
+	if (!clockevent) {
+		rv = -ENOMEM;
+		goto exit_iounmap_base;
+	}
 
 	clockevent->dev.name = "tim12";
 	clockevent->dev.features = CLOCK_EVT_FEAT_ONESHOT;
@@ -296,7 +300,7 @@ int __init davinci_timer_register(struct clk *clk,
 			 "clockevent/tim12", clockevent);
 	if (rv) {
 		pr_err("Unable to request the clockevent interrupt\n");
-		return rv;
+		goto exit_free_clockevent;
 	}
 
 	davinci_clocksource.dev.rating = 300;
@@ -323,13 +327,27 @@ int __init davinci_timer_register(struct clk *clk,
 	rv = clocksource_register_hz(&davinci_clocksource.dev, tick_rate);
 	if (rv) {
 		pr_err("Unable to register clocksource\n");
-		return rv;
+		goto exit_free_irq;
 	}
 
 	sched_clock_register(davinci_timer_read_sched_clock,
 			     DAVINCI_TIMER_CLKSRC_BITS, tick_rate);
 
 	return 0;
+
+exit_free_irq:
+	free_irq(timer_cfg->irq[DAVINCI_TIMER_CLOCKEVENT_IRQ].start,
+			clockevent);
+exit_free_clockevent:
+	kfree(clockevent);
+exit_iounmap_base:
+	iounmap(base);
+exit_mem_region:
+	release_mem_region(timer_cfg->reg.start,
+			   resource_size(&timer_cfg->reg));
+exit_clk_disable:
+	clk_disable_unprepare(clk);
+	return rv;
 }
 
 static int __init of_davinci_timer_register(struct device_node *np)
