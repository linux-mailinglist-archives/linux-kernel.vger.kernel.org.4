Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 577556AF611
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 20:46:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231266AbjCGTp7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 14:45:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231636AbjCGToc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 14:44:32 -0500
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A30CE984F0;
        Tue,  7 Mar 2023 11:33:51 -0800 (PST)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 327JXkRc032049;
        Tue, 7 Mar 2023 13:33:46 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1678217626;
        bh=0XkjNsVopQ86YcRrh07SREUk+5/73GCZODfBxC2xybw=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=TWi2c3hfntsI4caegan3sT5CLvp8soTVM9VXiSTkFwMsXlypMzOWGngsjix86LRve
         DRRMIFK8/TrTtmF/seb6C+DLsVulAJ7yGbnr9UKIaCPoxR0RT4midTU+XOHFkzsquP
         Gn0QYIvQp5gIi9nLiE2I58jAdIyJDfxQLbOjisE8=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 327JXkGS007548
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 7 Mar 2023 13:33:46 -0600
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Tue, 7
 Mar 2023 13:33:46 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Tue, 7 Mar 2023 13:33:46 -0600
Received: from ula0226330.dal.design.ti.com (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 327JXkWn026389;
        Tue, 7 Mar 2023 13:33:46 -0600
From:   Andrew Davis <afd@ti.com>
To:     Peter Tyser <ptyser@xes-inc.com>,
        Andy Shevchenko <andy@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>
CC:     <linux-gpio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Andrew Davis <afd@ti.com>
Subject: [PATCH v2 2/6] gpio: twl4030: Use devm_gpiochip_add_data() to simplify remove path
Date:   Tue, 7 Mar 2023 13:33:42 -0600
Message-ID: <20230307193346.8718-2-afd@ti.com>
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

Changes from v1:
 - Actually add the devm call

 drivers/gpio/gpio-twl4030.c | 23 +++--------------------
 1 file changed, 3 insertions(+), 20 deletions(-)

diff --git a/drivers/gpio/gpio-twl4030.c b/drivers/gpio/gpio-twl4030.c
index c1bb2c3ca6f2..3708ed2314e8 100644
--- a/drivers/gpio/gpio-twl4030.c
+++ b/drivers/gpio/gpio-twl4030.c
@@ -492,18 +492,6 @@ static struct twl4030_gpio_platform_data *of_gpio_twl4030(struct device *dev,
 	return omap_twl_info;
 }
 
-/* Cannot use as gpio_twl4030_probe() calls us */
-static int gpio_twl4030_remove(struct platform_device *pdev)
-{
-	struct gpio_twl4030_priv *priv = platform_get_drvdata(pdev);
-
-	gpiochip_remove(&priv->gpio_chip);
-
-	/* REVISIT no support yet for deregistering all the IRQs */
-	WARN_ON(!is_module());
-	return 0;
-}
-
 static int gpio_twl4030_probe(struct platform_device *pdev)
 {
 	struct twl4030_gpio_platform_data *pdata = dev_get_platdata(&pdev->dev);
@@ -577,16 +565,13 @@ static int gpio_twl4030_probe(struct platform_device *pdev)
 	if (pdata->use_leds)
 		priv->gpio_chip.ngpio += 2;
 
-	ret = gpiochip_add_data(&priv->gpio_chip, priv);
+	ret = devm_gpiochip_add_data(&pdev->dev, &priv->gpio_chip, priv);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "could not register gpiochip, %d\n", ret);
 		priv->gpio_chip.ngpio = 0;
-		gpio_twl4030_remove(pdev);
-		goto out;
+		return ret;
 	}
 
-	platform_set_drvdata(pdev, priv);
-
 	if (pdata->setup) {
 		int status;
 
@@ -596,8 +581,7 @@ static int gpio_twl4030_probe(struct platform_device *pdev)
 			dev_dbg(&pdev->dev, "setup --> %d\n", status);
 	}
 
-out:
-	return ret;
+	return 0;
 }
 
 static const struct of_device_id twl_gpio_match[] = {
@@ -615,7 +599,6 @@ static struct platform_driver gpio_twl4030_driver = {
 		.of_match_table = twl_gpio_match,
 	},
 	.probe		= gpio_twl4030_probe,
-	.remove		= gpio_twl4030_remove,
 };
 
 static int __init gpio_twl4030_init(void)
-- 
2.39.2

