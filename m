Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1830E6E360D
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Apr 2023 10:32:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230298AbjDPIce (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Apr 2023 04:32:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229891AbjDPIcc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Apr 2023 04:32:32 -0400
Received: from smtp.smtpout.orange.fr (smtp-26.smtpout.orange.fr [80.12.242.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B1AE2D5D
        for <linux-kernel@vger.kernel.org>; Sun, 16 Apr 2023 01:32:30 -0700 (PDT)
Received: from pop-os.home ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id nxoBpUp5GSbkVnxoBp6SVd; Sun, 16 Apr 2023 10:32:28 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=orange.fr;
        s=t20230301; t=1681633948;
        bh=6Nh9SbNnwZaFDBB1P2bWoSGbGhDLyt3bjRnq7fv3tcQ=;
        h=From:To:Cc:Subject:Date;
        b=qFdGVJRwqDfnU9DfilquMgxQjV9J9mgxoH27+b8QY0gKrhl2ccxCYzou2MtAnD5ae
         z0HourN8rMXV8JErxeZhIFcWiCliAqAmsA6WxwF5GMxRgHHQnoi+PrIBJKv7B0La23
         8yjXbmlDHjyhgakbQSwaXyHW2dSD3Yv2u7Qvclm2aqU5in7R8jYE/daNW9A9u7NLsk
         Nu6PfQA3Sl/DB+nFTc5vNzueEoyGmKmGzIt3nOnsBP63iFET/tYIyR/hPrHAt2esu/
         bjNUGmEfRGEB3ilzvEdg0Uw1AEbRH2mbgjremW9TGWqPLQgQsjPIsJ6EaI2kboiSmc
         qKbmfNnECzyHw==
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 16 Apr 2023 10:32:28 +0200
X-ME-IP: 86.243.2.178
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-pwm@vger.kernel.org
Subject: [PATCH] pwm: sti: Fix the error handling path of sti_pwm_probe()
Date:   Sun, 16 Apr 2023 10:32:24 +0200
Message-Id: <ef5d6301cb120db5d52175a7bf94b5095beaaeef.1681633924.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rewrite the error handing path of sti_pwm_probe() to avoid some leaks.

Fixes: 3f0925b5a864 ("pwm: sti: Initialise PWM capture device data")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
I also wonder if some clk_put() are also missing in the error handling path
and in the remove function.

This could be split in several patches because some issues were
introduced before 3f0925b5a864.
But it is already nearly 7 years old, so it should be enough, should it be
back-ported.
---
 drivers/pwm/pwm-sti.c | 26 +++++++++++++++++---------
 1 file changed, 17 insertions(+), 9 deletions(-)

diff --git a/drivers/pwm/pwm-sti.c b/drivers/pwm/pwm-sti.c
index b1d1373648a3..7e678cab2991 100644
--- a/drivers/pwm/pwm-sti.c
+++ b/drivers/pwm/pwm-sti.c
@@ -630,13 +630,14 @@ static int sti_pwm_probe(struct platform_device *pdev)
 		pc->cpt_clk = of_clk_get_by_name(dev->of_node, "capture");
 		if (IS_ERR(pc->cpt_clk)) {
 			dev_err(dev, "failed to get PWM capture clock\n");
-			return PTR_ERR(pc->cpt_clk);
+			ret = PTR_ERR(pc->cpt_clk);
+			goto err_unprepare_pwm;
 		}
 
 		ret = clk_prepare(pc->cpt_clk);
 		if (ret) {
 			dev_err(dev, "failed to prepare clock\n");
-			return ret;
+			goto err_unprepare_pwm;
 		}
 	}
 
@@ -645,18 +646,17 @@ static int sti_pwm_probe(struct platform_device *pdev)
 	pc->chip.npwm = pc->cdata->pwm_num_devs;
 
 	ret = pwmchip_add(&pc->chip);
-	if (ret < 0) {
-		clk_unprepare(pc->pwm_clk);
-		clk_unprepare(pc->cpt_clk);
-		return ret;
-	}
+	if (ret < 0)
+		goto err_unprepare_cpt;
 
 	for (i = 0; i < cdata->cpt_num_devs; i++) {
 		struct sti_cpt_ddata *ddata;
 
 		ddata = devm_kzalloc(dev, sizeof(*ddata), GFP_KERNEL);
-		if (!ddata)
-			return -ENOMEM;
+		if (!ddata) {
+			ret = -ENOMEM;
+			goto err_remove_pwmchip;
+		}
 
 		init_waitqueue_head(&ddata->wait);
 		mutex_init(&ddata->lock);
@@ -667,6 +667,14 @@ static int sti_pwm_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, pc);
 
 	return 0;
+
+err_remove_pwmchip:
+	pwmchip_remove(&pc->chip);
+err_unprepare_cpt:
+	clk_unprepare(pc->cpt_clk);
+err_unprepare_pwm:
+	clk_unprepare(pc->pwm_clk);
+	return ret;
 }
 
 static void sti_pwm_remove(struct platform_device *pdev)
-- 
2.34.1

