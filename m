Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E71976AE7A7
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 17:59:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230026AbjCGQ7d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 11:59:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230435AbjCGQ6J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 11:58:09 -0500
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF4D2943A5;
        Tue,  7 Mar 2023 08:54:38 -0800 (PST)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 327GsXCs094193;
        Tue, 7 Mar 2023 10:54:33 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1678208073;
        bh=rp24ZeGWZpg4SMuqNbRGr6tdFc0xbZJPtzZjm57ZCIo=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=XmCCnD/lCwgMxN77KmJaSRCTvYegXMqhz1gWR9I8MA7LWFARegn6Guft7KcFW2Ls3
         nG/7ws2hr2VdMEp/LYCPQTtCUgYFO1Pwc+9J/vEOdtC4zcjKTxqSurO7mwl7PKpozK
         ID54odEXBbcgkwHcIOSafZpmp5guzw2PNhvcL6Pw=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 327GsXZk052508
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 7 Mar 2023 10:54:33 -0600
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Tue, 7
 Mar 2023 10:54:33 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Tue, 7 Mar 2023 10:54:32 -0600
Received: from ula0226330.dal.design.ti.com (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 327GsWdT084852;
        Tue, 7 Mar 2023 10:54:32 -0600
From:   Andrew Davis <afd@ti.com>
To:     Peter Tyser <ptyser@xes-inc.com>,
        Andy Shevchenko <andy@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>
CC:     <linux-gpio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Andrew Davis <afd@ti.com>
Subject: [PATCH 2/6] gpio: twl4030: Use devm_gpiochip_add_data() to simplify remove path
Date:   Tue, 7 Mar 2023 10:54:28 -0600
Message-ID: <20230307165432.25484-2-afd@ti.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230307165432.25484-1-afd@ti.com>
References: <20230307165432.25484-1-afd@ti.com>
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
 drivers/gpio/gpio-twl4030.c | 16 ----------------
 1 file changed, 16 deletions(-)

diff --git a/drivers/gpio/gpio-twl4030.c b/drivers/gpio/gpio-twl4030.c
index c1bb2c3ca6f2..23f58bf3a415 100644
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
@@ -581,12 +569,9 @@ static int gpio_twl4030_probe(struct platform_device *pdev)
 	if (ret < 0) {
 		dev_err(&pdev->dev, "could not register gpiochip, %d\n", ret);
 		priv->gpio_chip.ngpio = 0;
-		gpio_twl4030_remove(pdev);
 		goto out;
 	}
 
-	platform_set_drvdata(pdev, priv);
-
 	if (pdata->setup) {
 		int status;
 
@@ -615,7 +600,6 @@ static struct platform_driver gpio_twl4030_driver = {
 		.of_match_table = twl_gpio_match,
 	},
 	.probe		= gpio_twl4030_probe,
-	.remove		= gpio_twl4030_remove,
 };
 
 static int __init gpio_twl4030_init(void)
-- 
2.39.2

