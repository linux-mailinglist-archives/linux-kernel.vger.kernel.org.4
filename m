Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00E916E3661
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Apr 2023 11:02:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230458AbjDPJCX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Apr 2023 05:02:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230461AbjDPJCV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Apr 2023 05:02:21 -0400
Received: from smtp.smtpout.orange.fr (smtp-11.smtpout.orange.fr [80.12.242.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 570012693
        for <linux-kernel@vger.kernel.org>; Sun, 16 Apr 2023 02:02:17 -0700 (PDT)
Received: from pop-os.home ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id nyH0pbG1aZuz8nyH0pkDjf; Sun, 16 Apr 2023 11:02:15 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=orange.fr;
        s=t20230301; t=1681635735;
        bh=jElERW5oAW/BA/iWn/iMwYZcr8+bBQCwjgCK64tXWvg=;
        h=From:To:Cc:Subject:Date;
        b=AIFyl+4LMWAYJKXQSaTaP5fgyO1X8fiTU5MY+pi2PUbnxU7yuDCdbbAqrdvqIoC2h
         /Re8WzFeK5MuZBRZbUy9r5Cix6r43nGExGv8WCSS1eAQ+NgHVhiZkTN5DE4ewWCQDC
         NbVJ6cEGaHYvwFd32K5yLQ6bNHg5xfO73Jevs/tYWvkserBdeLMwZdlLpWrePByJWn
         XotY/Qt9wK/Om2MHEnD6yTzrjqBSz8r8V66GWYGXaF1q2DDJhWtr/82Az59vQsP4wj
         r1lqMEBTl29BivO+S4LZCIC4h0isnAtjiYXkTBL8RA6Kjfqg27z7+pUBLJhM1C3Bgs
         yLXACoYbAFv1w==
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 16 Apr 2023 11:02:15 +0200
X-ME-IP: 86.243.2.178
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-pwm@vger.kernel.org
Subject: [PATCH] pwm: clk: Use the devm_clk_get_prepared() helper function
Date:   Sun, 16 Apr 2023 11:02:13 +0200
Message-Id: <9281571825c365c1591fcf31527d45ec576c19b4.1681635694.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the devm_clk_get_prepared() helper function instead of hand-writing it.
It saves some line of codes.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/pwm/pwm-clk.c | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/drivers/pwm/pwm-clk.c b/drivers/pwm/pwm-clk.c
index f1da99881adf..0ee4d2aee4df 100644
--- a/drivers/pwm/pwm-clk.c
+++ b/drivers/pwm/pwm-clk.c
@@ -89,7 +89,7 @@ static int pwm_clk_probe(struct platform_device *pdev)
 	if (!pcchip)
 		return -ENOMEM;
 
-	pcchip->clk = devm_clk_get(&pdev->dev, NULL);
+	pcchip->clk = devm_clk_get_prepared(&pdev->dev, NULL);
 	if (IS_ERR(pcchip->clk))
 		return dev_err_probe(&pdev->dev, PTR_ERR(pcchip->clk),
 				     "Failed to get clock\n");
@@ -98,15 +98,9 @@ static int pwm_clk_probe(struct platform_device *pdev)
 	pcchip->chip.ops = &pwm_clk_ops;
 	pcchip->chip.npwm = 1;
 
-	ret = clk_prepare(pcchip->clk);
-	if (ret < 0)
-		return dev_err_probe(&pdev->dev, ret, "Failed to prepare clock\n");
-
 	ret = pwmchip_add(&pcchip->chip);
-	if (ret < 0) {
-		clk_unprepare(pcchip->clk);
+	if (ret < 0)
 		return dev_err_probe(&pdev->dev, ret, "Failed to add pwm chip\n");
-	}
 
 	platform_set_drvdata(pdev, pcchip);
 	return 0;
@@ -120,8 +114,6 @@ static void pwm_clk_remove(struct platform_device *pdev)
 
 	if (pcchip->clk_enabled)
 		clk_disable(pcchip->clk);
-
-	clk_unprepare(pcchip->clk);
 }
 
 static const struct of_device_id pwm_clk_dt_ids[] = {
-- 
2.34.1

