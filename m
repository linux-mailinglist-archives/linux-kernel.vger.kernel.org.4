Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2F8E703986
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 19:43:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244526AbjEORnT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 13:43:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244493AbjEORm5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 13:42:57 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0188B16902;
        Mon, 15 May 2023 10:40:34 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 34FHeSwc069276;
        Mon, 15 May 2023 12:40:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1684172428;
        bh=QFz3oTrA3pkyZzNa7g6DhNARu1SSRuQphy9OmLQk2ts=;
        h=From:To:CC:Subject:Date;
        b=xt1c9BRe1l1my7S1505Ze/JULJAqJG7MaJSz53kj9jC3miMxX4zXD5TFcMJZjXyRC
         ncBYyU2xNLJfsDkBkcgGoHjCtehNl2oQPJ8VB80QMGOKYL421FnPAVNMMIGqu0mpNc
         TETaF4sCTx9QsK6YLNTiBdU+u/vTFUHbizw/UQmE=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 34FHeSKw043913
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 15 May 2023 12:40:28 -0500
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 15
 May 2023 12:40:27 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 15 May 2023 12:40:27 -0500
Received: from lelv0327.itg.ti.com (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 34FHeRu1019475;
        Mon, 15 May 2023 12:40:27 -0500
From:   Andrew Davis <afd@ti.com>
To:     Peter Tyser <ptyser@xes-inc.com>,
        Andy Shevchenko <andy@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>
CC:     <linux-gpio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Andrew Davis <afd@ti.com>
Subject: [PATCH v3] gpio: twl4030: Use devm_gpiochip_add_data() to simplify remove path
Date:   Mon, 15 May 2023 12:40:26 -0500
Message-ID: <20230515174026.494496-1-afd@ti.com>
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
 - Rebase on v6.4-rc2

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

