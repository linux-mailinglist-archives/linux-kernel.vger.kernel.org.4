Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6182610EB4
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 12:38:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230522AbiJ1Kit (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 06:38:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230448AbiJ1KiS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 06:38:18 -0400
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 91A581C73D8;
        Fri, 28 Oct 2022 03:38:17 -0700 (PDT)
Received: from hillo.muru.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTP id 0056A8061;
        Fri, 28 Oct 2022 10:28:52 +0000 (UTC)
From:   Tony Lindgren <tony@atomide.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Grygorii Strashko <grygorii.strashko@ti.com>,
        Keerthy <j-keerthy@ti.com>,
        Ladislav Michl <ladis@linux-mips.org>,
        Nishanth Menon <nm@ti.com>, Suman Anna <s-anna@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH] clocksource/drivers/timer-ti-dm: Clear settings on probe and free
Date:   Fri, 28 Oct 2022 13:38:13 +0300
Message-Id: <20221028103813.40783-1-tony@atomide.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clear the timer control register on driver probe and omap_dm_timer_free().
Otherwise we assume the consumer driver takes care of properly
initializing timer interrupts on PWM driver module reload for example.

AFAIK this is not currently needed as a fix, I just happened to run into
this while cleaning up things.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/clocksource/timer-ti-dm.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/clocksource/timer-ti-dm.c b/drivers/clocksource/timer-ti-dm.c
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
 
-- 
2.37.3
