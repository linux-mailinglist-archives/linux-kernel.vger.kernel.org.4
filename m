Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A53EC73DB00
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 11:14:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229724AbjFZJOS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 05:14:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229706AbjFZJNN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 05:13:13 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9B6E187;
        Mon, 26 Jun 2023 02:11:41 -0700 (PDT)
Date:   Mon, 26 Jun 2023 09:11:39 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1687770700;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xcynkB+2ejgdgKoIuzW5rnBkYwgbpMkmunTrjH3Cs28=;
        b=X/BKPCu3dnb/hSvCi9HqJjXyjBvSvfZaBwzfAGMzDhToDLm7IydPnFyVrwklRU7eb+k1/t
        dGRN5cilHs3BqSFQEmgWvhUyZwophnGNAIOsILle5lIGnYfZhHgzeYS45AX3JQD4ZTSoOR
        c72J7ynoomPa5xG5DbeJ7uo7wybm9uTne0ezUhD6b5ksDRV31mUVz9EdgUBdtYQXx5OZX9
        g5L36WukJSlbcA5nzhWWjgMiJgSp4AZvMV6OZKL8Upb0UZcF2JTGeB15Uyr0Q6aRZVAbeg
        qT9eGzgGdKRgGkOYFQf6FUUgeQwqV7CSIg+OEDEONPmapW5UrasPvAJpk5uNLA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1687770700;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xcynkB+2ejgdgKoIuzW5rnBkYwgbpMkmunTrjH3Cs28=;
        b=+ysDEB9MecAj9isETE4vohW1v6c5mlWE+6RkNWsL17THgRa9aYtXi5tzrQmtS6ltYHMOkK
        exz91wA+t5gBj2CA==
From:   "tip-bot2 for Paul Cercueil" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] clocksource/drivers/ingenic-timer: Use
 pm_sleep_ptr() macro
Cc:     Paul Cercueil <paul@crapouillou.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230618153937.96649-1-paul@crapouillou.net>
References: <20230618153937.96649-1-paul@crapouillou.net>
MIME-Version: 1.0
Message-ID: <168777069988.404.5923193634383986176.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     ea95051063f95bf612683f5697e44604d0cbd0f1
Gitweb:        https://git.kernel.org/tip/ea95051063f95bf612683f5697e44604d0cbd0f1
Author:        Paul Cercueil <paul@crapouillou.net>
AuthorDate:    Sun, 18 Jun 2023 17:39:37 +02:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Mon, 19 Jun 2023 16:17:42 +02:00

clocksource/drivers/ingenic-timer: Use pm_sleep_ptr() macro

The use of the pm_sleep_ptr() macro allows the compiler to always see
the dev_pm_ops structure and related functions, while still allowing the
unused code to be removed, without the need for the __maybe_unused
markings.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20230618153937.96649-1-paul@crapouillou.net
---
 drivers/clocksource/ingenic-timer.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/clocksource/ingenic-timer.c b/drivers/clocksource/ingenic-timer.c
index 089ce64..154ee5f 100644
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
@@ -406,7 +406,7 @@ err_timer_clk_disable:
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
