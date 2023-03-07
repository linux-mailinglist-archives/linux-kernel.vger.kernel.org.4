Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 532636AF614
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 20:46:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231769AbjCGTqP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 14:46:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231940AbjCGToe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 14:44:34 -0500
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D4E498EAE;
        Tue,  7 Mar 2023 11:33:51 -0800 (PST)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 327JXkUo129397;
        Tue, 7 Mar 2023 13:33:46 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1678217626;
        bh=2QKk8MDasC9TQp6Y/MGWR5Z7h/GdVQwRLQTrVMYwwAU=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=qIJxhOmytpNBGTwFVkqA6fcECG1b/POelKbKOD7gzUYobfwP6yqjhwazWtY0IlN8s
         b3ic42MCYEY11U6NA3I+KWuLGgYl3JjiE0U3o78kGYRdKROUXaoOu0vxIWwxvFYZ0V
         sxQetdKFVL54LdUgTCpAM0qZC97FGguXm7N43KMg=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 327JXkOC123439
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 7 Mar 2023 13:33:46 -0600
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Tue, 7
 Mar 2023 13:33:46 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Tue, 7 Mar 2023 13:33:46 -0600
Received: from ula0226330.dal.design.ti.com (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 327JXkWo026389;
        Tue, 7 Mar 2023 13:33:46 -0600
From:   Andrew Davis <afd@ti.com>
To:     Peter Tyser <ptyser@xes-inc.com>,
        Andy Shevchenko <andy@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>
CC:     <linux-gpio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Andrew Davis <afd@ti.com>
Subject: [PATCH v2 3/6] gpio: sch311x: Use devm_gpiochip_add_data() to simplify remove path
Date:   Tue, 7 Mar 2023 13:33:43 -0600
Message-ID: <20230307193346.8718-3-afd@ti.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230307193346.8718-1-afd@ti.com>
References: <20230307193346.8718-1-afd@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use devm version of gpiochip add function to handle removal for us.

Signed-off-by: Andrew Davis <afd@ti.com>
---
 drivers/gpio/gpio-sch311x.c | 25 ++-----------------------
 1 file changed, 2 insertions(+), 23 deletions(-)

diff --git a/drivers/gpio/gpio-sch311x.c b/drivers/gpio/gpio-sch311x.c
index da01e1cad7cb..ba7c300511a5 100644
--- a/drivers/gpio/gpio-sch311x.c
+++ b/drivers/gpio/gpio-sch311x.c
@@ -281,8 +281,6 @@ static int sch311x_gpio_probe(struct platform_device *pdev)
 	if (!priv)
 		return -ENOMEM;
 
-	platform_set_drvdata(pdev, priv);
-
 	for (i = 0; i < ARRAY_SIZE(priv->blocks); i++) {
 		block = &priv->blocks[i];
 
@@ -305,36 +303,17 @@ static int sch311x_gpio_probe(struct platform_device *pdev)
 		block->data_reg = sch311x_gpio_blocks[i].data_reg;
 		block->runtime_reg = pdata->runtime_reg;
 
-		err = gpiochip_add_data(&block->chip, block);
+		err = devm_gpiochip_add_data(&pdev->dev, &block->chip, block);
 		if (err < 0) {
 			dev_err(&pdev->dev,
 				"Could not register gpiochip, %d\n", err);
-			goto exit_err;
+			return err;
 		}
 		dev_info(&pdev->dev,
 			 "SMSC SCH311x GPIO block %d registered.\n", i);
 	}
 
 	return 0;
-
-exit_err:
-	/* release already registered chips */
-	for (--i; i >= 0; i--)
-		gpiochip_remove(&priv->blocks[i].chip);
-	return err;
-}
-
-static int sch311x_gpio_remove(struct platform_device *pdev)
-{
-	struct sch311x_gpio_priv *priv = platform_get_drvdata(pdev);
-	int i;
-
-	for (i = 0; i < ARRAY_SIZE(priv->blocks); i++) {
-		gpiochip_remove(&priv->blocks[i].chip);
-		dev_info(&pdev->dev,
-			 "SMSC SCH311x GPIO block %d unregistered.\n", i);
-	}
-	return 0;
 }
 
 static struct platform_driver sch311x_gpio_driver = {
-- 
2.39.2

