Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD5736485D9
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 16:47:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230438AbiLIPrj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 10:47:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230205AbiLIPrZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 10:47:25 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65FDC37F88;
        Fri,  9 Dec 2022 07:47:24 -0800 (PST)
Date:   Fri, 09 Dec 2022 15:47:22 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1670600843;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/L89Jisaszb2KZ82TACDoQmvI8vtjDwMU2HkvQaUgm0=;
        b=S7Y6R39e9P/x5NKovC5IoWgzZQ4Y1wkgA9CAiiWy2ru1BPXObHRQtSGlcggzjtnlD4lcCU
        ekQcTcyXTo07hQYbOCii6ZpFIcOWZBq2jNrCZsCuUgwKuPyYF/9xaKq9mino29wBmz8b7Q
        F1UXynSCE42fK2HYP02wIAT7e/xCoynmxWW1Fc7zNl0SPzZqKcx7xG/Fq0J4gEr4iGLK0Y
        EeEdCvZcts0v7nolfMY8HRGHsv9un9NHrQzbhdHwp3bTziPExZBkpSLNsNpFl4L+kI2A7B
        gMTVqEWLgqTXwUF4pSjRXSw+La+pCqy2JXZ5KmpRSj5+KeDWTm0LT3pid/pY1A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1670600843;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/L89Jisaszb2KZ82TACDoQmvI8vtjDwMU2HkvQaUgm0=;
        b=PN78vMFWIOUWyZeaEeVZXX8aaF/ZGgZfvNzkiFQO6YGONsaf6nYP0KpO8a8+LPLc20g4w7
        /viSSxfOftcrPnAg==
From:   "tip-bot2 for Tony Lindgren" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] clocksource/drivers/timer-ti-dm: Clear settings on
 probe and free
Cc:     Tony Lindgren <tony@atomide.com>,
        Daniel Lezcano <daniel.lezcano@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20221028103813.40783-1-tony@atomide.com>
References: <20221028103813.40783-1-tony@atomide.com>
MIME-Version: 1.0
Message-ID: <167060084277.4906.10637289144406021448.tip-bot2@tip-bot2>
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

Commit-ID:     822963b96dfdb72ec4fb1395fbdfa778656b49d1
Gitweb:        https://git.kernel.org/tip/822963b96dfdb72ec4fb1395fbdfa778656b49d1
Author:        Tony Lindgren <tony@atomide.com>
AuthorDate:    Fri, 28 Oct 2022 13:38:13 +03:00
Committer:     Daniel Lezcano <daniel.lezcano@kernel.org>
CommitterDate: Fri, 02 Dec 2022 13:16:46 +01:00

clocksource/drivers/timer-ti-dm: Clear settings on probe and free

Clear the timer control register on driver probe and omap_dm_timer_free().
Otherwise we assume the consumer driver takes care of properly
initializing timer interrupts on PWM driver module reload for example.

AFAIK this is not currently needed as a fix, I just happened to run into
this while cleaning up things.

Signed-off-by: Tony Lindgren <tony@atomide.com>
Link: https://lore.kernel.org/r/20221028103813.40783-1-tony@atomide.com
Signed-off-by: Daniel Lezcano <daniel.lezcano@kernel.org>
---
 drivers/clocksource/timer-ti-dm.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/clocksource/timer-ti-dm.c b/drivers/clocksource/timer-ti-dm.c
index eeeeb3c..b24b903 100644
--- a/drivers/clocksource/timer-ti-dm.c
+++ b/drivers/clocksource/timer-ti-dm.c
@@ -633,6 +633,8 @@ static struct omap_dm_timer *omap_dm_timer_request_by_node(struct device_node *n
 static int omap_dm_timer_free(struct omap_dm_timer *cookie)
 {
 	struct dmtimer *timer;
+	struct device *dev;
+	int rc;
 
 	timer = to_dmtimer(cookie);
 	if (unlikely(!timer))
@@ -640,6 +642,17 @@ static int omap_dm_timer_free(struct omap_dm_timer *cookie)
 
 	WARN_ON(!timer->reserved);
 	timer->reserved = 0;
+
+	dev = &timer->pdev->dev;
+	rc = pm_runtime_resume_and_get(dev);
+	if (rc)
+		return rc;
+
+	/* Clear timer configuration */
+	dmtimer_write(timer, OMAP_TIMER_CTRL_REG, 0);
+
+	pm_runtime_put_sync(dev);
+
 	return 0;
 }
 
@@ -1135,6 +1148,10 @@ static int omap_dm_timer_probe(struct platform_device *pdev)
 			goto err_disable;
 		}
 		__omap_dm_timer_init_regs(timer);
+
+		/* Clear timer configuration */
+		dmtimer_write(timer, OMAP_TIMER_CTRL_REG, 0);
+
 		pm_runtime_put(dev);
 	}
 
