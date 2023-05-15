Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AE207039B5
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 19:45:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244160AbjEORpU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 13:45:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243494AbjEORo6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 13:44:58 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3C9F147E8;
        Mon, 15 May 2023 10:42:34 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 34FHgPLJ025588;
        Mon, 15 May 2023 12:42:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1684172545;
        bh=kUoLNLKxxpWuzV2FDVeOM5tQWxiRCQGbtbtkwHxuXrY=;
        h=From:To:CC:Subject:Date;
        b=fOG+Gl2tN9XnaoDl9cE9YaZneXCIJabc8zQaW0llSLFPg5WgOh540mNO0xQp4mxTJ
         EL9vzJHW2Mx7VdesiuAF8U3mHcf+6B030uGfSJu4ZF02lnLT+ORyYCn84eFdeP/nPp
         qheEMQFDB8INXfsUe4Spav3sfhItF0LLZktt/NEY=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 34FHgPLU095087
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 15 May 2023 12:42:25 -0500
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 15
 May 2023 12:42:25 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 15 May 2023 12:42:25 -0500
Received: from fllv0039.itg.ti.com (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 34FHgP8f096075;
        Mon, 15 May 2023 12:42:25 -0500
From:   Andrew Davis <afd@ti.com>
To:     Peter Tyser <ptyser@xes-inc.com>,
        Andy Shevchenko <andy@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>
CC:     <linux-gpio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Andrew Davis <afd@ti.com>
Subject: [PATCH v3] gpio: sch311x: Use devm_gpiochip_add_data() to simplify remove path
Date:   Mon, 15 May 2023 12:42:24 -0500
Message-ID: <20230515174224.494631-1-afd@ti.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use devm version of gpiochip add function to handle removal for us.

Signed-off-by: Andrew Davis <afd@ti.com>
---

Changes from v2:
 - Remove platform_driver.remove (thanks kernel test robot)

 drivers/gpio/gpio-sch311x.c | 26 ++------------------------
 1 file changed, 2 insertions(+), 24 deletions(-)

diff --git a/drivers/gpio/gpio-sch311x.c b/drivers/gpio/gpio-sch311x.c
index da01e1cad7cb..ba4fccf3cc94 100644
--- a/drivers/gpio/gpio-sch311x.c
+++ b/drivers/gpio/gpio-sch311x.c
@@ -281,8 +281,6 @@ static int sch311x_gpio_probe(struct platform_device *pdev)
 	if (!priv)
 		return -ENOMEM;
 
-	platform_set_drvdata(pdev, priv);
-
 	for (i = 0; i < ARRAY_SIZE(priv->blocks); i++) {
 		block = &priv->blocks[i];
 
@@ -305,42 +303,22 @@ static int sch311x_gpio_probe(struct platform_device *pdev)
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
 	.driver.name	= DRV_NAME,
 	.probe		= sch311x_gpio_probe,
-	.remove		= sch311x_gpio_remove,
 };
 
 
-- 
2.39.2

