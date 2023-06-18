Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 264157346D4
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Jun 2023 17:39:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229774AbjFRPjs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Jun 2023 11:39:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbjFRPjr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Jun 2023 11:39:47 -0400
Received: from aposti.net (aposti.net [89.234.176.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 215D1E4F
        for <linux-kernel@vger.kernel.org>; Sun, 18 Jun 2023 08:39:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1687102784;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=yU6rdYSr0fdjxZNOHrIN3OBxjocoOCe94dU5mt/YZD8=;
        b=grHSJzDIjuXQPAmynNUh7dFvbw/kpQ5wpXyTZ93L4DC+Vy/UFJnDtPovISmYY9+Rj3mZC6
        rYVFZFC99SOuYYWKvuD5otizWSfpCW0AX6KCO6eHNYhnfWGKWNKF7uj+uZCktYC5HIgNgW
        o52SoXtMBZRM1fj+mXn2kzQ7RaGWSPk=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     list@opendingux.net, linux-kernel@vger.kernel.org,
        Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH] clocksource: ingenic-timer: Use pm_sleep_ptr() macro
Date:   Sun, 18 Jun 2023 17:39:37 +0200
Message-Id: <20230618153937.96649-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The use of the pm_sleep_ptr() macro allows the compiler to always see
the dev_pm_ops structure and related functions, while still allowing the
unused code to be removed, without the need for the __maybe_unused
markings.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 drivers/clocksource/ingenic-timer.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/clocksource/ingenic-timer.c b/drivers/clocksource/ingenic-timer.c
index 089ce64b1c3f..154ee5f7954a 100644
--- a/drivers/clocksource/ingenic-timer.c
+++ b/drivers/clocksource/ingenic-timer.c
@@ -369,7 +369,7 @@ static int __init ingenic_tcu_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int __maybe_unused ingenic_tcu_suspend(struct device *dev)
+static int ingenic_tcu_suspend(struct device *dev)
 {
 	struct ingenic_tcu *tcu = dev_get_drvdata(dev);
 	unsigned int cpu;
@@ -382,7 +382,7 @@ static int __maybe_unused ingenic_tcu_suspend(struct device *dev)
 	return 0;
 }
 
-static int __maybe_unused ingenic_tcu_resume(struct device *dev)
+static int ingenic_tcu_resume(struct device *dev)
 {
 	struct ingenic_tcu *tcu = dev_get_drvdata(dev);
 	unsigned int cpu;
@@ -406,7 +406,7 @@ static int __maybe_unused ingenic_tcu_resume(struct device *dev)
 	return ret;
 }
 
-static const struct dev_pm_ops __maybe_unused ingenic_tcu_pm_ops = {
+static const struct dev_pm_ops ingenic_tcu_pm_ops = {
 	/* _noirq: We want the TCU clocks to be gated last / ungated first */
 	.suspend_noirq = ingenic_tcu_suspend,
 	.resume_noirq  = ingenic_tcu_resume,
@@ -415,9 +415,7 @@ static const struct dev_pm_ops __maybe_unused ingenic_tcu_pm_ops = {
 static struct platform_driver ingenic_tcu_driver = {
 	.driver = {
 		.name	= "ingenic-tcu-timer",
-#ifdef CONFIG_PM_SLEEP
-		.pm	= &ingenic_tcu_pm_ops,
-#endif
+		.pm	= pm_sleep_ptr(&ingenic_tcu_pm_ops),
 		.of_match_table = ingenic_tcu_of_match,
 	},
 };
-- 
2.39.2

