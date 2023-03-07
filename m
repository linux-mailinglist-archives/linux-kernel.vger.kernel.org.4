Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A40826AF612
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 20:46:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231727AbjCGTqJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 14:46:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232512AbjCGToe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 14:44:34 -0500
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 959DA9AFD2;
        Tue,  7 Mar 2023 11:33:52 -0800 (PST)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 327JXkLV129393;
        Tue, 7 Mar 2023 13:33:46 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1678217626;
        bh=VZPQo90BF4za+2DxTnTfA4rqN5o7cRlXJuablQTN0vI=;
        h=From:To:CC:Subject:Date;
        b=s3h3WlDG9pUBA/NUm3vq1MQtBXYjRR+DzoctbMy4B8PC61IQOiCU/fPY5XNNRTeO/
         d1AFt1+ue4ol9FOC3OOvhDZ36iWhgp9Q/6OYduT030cUjRuioM3ts4AZTxXcNXcsai
         DlhLlBXU/rA5ZvB/bWXhNqw2Zkcwf8/aMMYBOAXE=
Received: from DLEE111.ent.ti.com (dlee111.ent.ti.com [157.170.170.22])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 327JXkEA123433
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 7 Mar 2023 13:33:46 -0600
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Tue, 7
 Mar 2023 13:33:46 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Tue, 7 Mar 2023 13:33:46 -0600
Received: from ula0226330.dal.design.ti.com (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 327JXkWm026389;
        Tue, 7 Mar 2023 13:33:46 -0600
From:   Andrew Davis <afd@ti.com>
To:     Peter Tyser <ptyser@xes-inc.com>,
        Andy Shevchenko <andy@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>
CC:     <linux-gpio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Andrew Davis <afd@ti.com>
Subject: [PATCH v2 1/6] gpio: ich: Use devm_gpiochip_add_data() to simplify remove path
Date:   Tue, 7 Mar 2023 13:33:41 -0600
Message-ID: <20230307193346.8718-1-afd@ti.com>
X-Mailer: git-send-email 2.39.2
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
 drivers/gpio/gpio-ich.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/drivers/gpio/gpio-ich.c b/drivers/gpio/gpio-ich.c
index 3b31f5e9bf40..0be9285efebc 100644
--- a/drivers/gpio/gpio-ich.c
+++ b/drivers/gpio/gpio-ich.c
@@ -457,7 +457,7 @@ static int ichx_gpio_probe(struct platform_device *pdev)
 
 init:
 	ichx_gpiolib_setup(&ichx_priv.chip);
-	err = gpiochip_add_data(&ichx_priv.chip, NULL);
+	err = devm_gpiochip_add_data(dev, &ichx_priv.chip, NULL);
 	if (err) {
 		dev_err(dev, "Failed to register GPIOs\n");
 		return err;
@@ -469,19 +469,11 @@ static int ichx_gpio_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int ichx_gpio_remove(struct platform_device *pdev)
-{
-	gpiochip_remove(&ichx_priv.chip);
-
-	return 0;
-}
-
 static struct platform_driver ichx_gpio_driver = {
 	.driver		= {
 		.name	= DRV_NAME,
 	},
 	.probe		= ichx_gpio_probe,
-	.remove		= ichx_gpio_remove,
 };
 
 module_platform_driver(ichx_gpio_driver);
-- 
2.39.2

