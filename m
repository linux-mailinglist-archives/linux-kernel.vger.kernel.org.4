Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FE2F6A80A5
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 12:02:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230131AbjCBLCC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 06:02:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229957AbjCBLBw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 06:01:52 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6DC448E1B;
        Thu,  2 Mar 2023 03:01:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1677754900; x=1709290900;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=gX9P046dW17ln8lj8QobxPkcMbEPnX2RXibkQe5EQhM=;
  b=T1xvdqkYKaBAI5U8Hkx0x/VUgRKCQVSHKRzIMTZIwxZwGgS2m/gupWMe
   0sVRC4uElOfp6a3CxgXoOiy52gbil+jHpfiLvWoewIqF5LqoSH1Ba+H/4
   TOoq9IsjBoz+h3lam//H8Uz1fOe4xTBUKUDlb5gK5Rz1C/DuyksSeT+sA
   7SLEyi4+yEenbpPUoYC18wdeT8dARazmsv6QHGNAbTSxkSahTcZxkAoth
   mynpNvhykr4Pp4eJe16UnOCzvgRt5XY/l2ZhrVEfx+PRYjunCz6DvI84l
   RXv3y/gFbJYeS/jYQCW+AFZaPRJ46JU2uqhmbQH/y8lXuhQDpDCOYjaFH
   Q==;
X-IronPort-AV: E=Sophos;i="5.98,227,1673938800"; 
   d="scan'208";a="199564392"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 02 Mar 2023 04:01:39 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Thu, 2 Mar 2023 04:01:38 -0700
Received: from m18063-ThinkPad-T460p.mchp-main.com (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.16 via Frontend Transport; Thu, 2 Mar 2023 04:01:36 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <ludovic.desroches@microchip.com>, <linus.walleij@linaro.org>,
        <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-gpio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH 3/4] pinctrl: at91-pio4: use dev_err_probe()
Date:   Thu, 2 Mar 2023 13:01:15 +0200
Message-ID: <20230302110116.342486-4-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230302110116.342486-1-claudiu.beznea@microchip.com>
References: <20230302110116.342486-1-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use dev_err_probe() to simplify the code.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 drivers/pinctrl/pinctrl-at91-pio4.c | 19 +++++++------------
 1 file changed, 7 insertions(+), 12 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-at91-pio4.c b/drivers/pinctrl/pinctrl-at91-pio4.c
index 93023d0fd75b..783968182bc7 100644
--- a/drivers/pinctrl/pinctrl-at91-pio4.c
+++ b/drivers/pinctrl/pinctrl-at91-pio4.c
@@ -1079,10 +1079,9 @@ static int atmel_pinctrl_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, atmel_pioctrl);
 
 	atmel_pioctrl_data = device_get_match_data(dev);
-	if (!atmel_pioctrl_data) {
-		dev_err(dev, "Invalid device data\n");
-		return -ENODEV;
-	}
+	if (!atmel_pioctrl_data)
+		return dev_err_probe(dev, -ENODEV, "Invalid device data\n");
+
 	atmel_pioctrl->nbanks = atmel_pioctrl_data->nbanks;
 	atmel_pioctrl->npins = atmel_pioctrl->nbanks * ATMEL_PIO_NPINS_PER_BANK;
 	/* if last bank has limited number of pins, adjust accordingly */
@@ -1097,10 +1096,8 @@ static int atmel_pinctrl_probe(struct platform_device *pdev)
 		return PTR_ERR(atmel_pioctrl->reg_base);
 
 	atmel_pioctrl->clk = devm_clk_get_enabled(dev, NULL);
-	if (IS_ERR(atmel_pioctrl->clk)) {
-		dev_err(dev, "failed to get clock\n");
-		return PTR_ERR(atmel_pioctrl->clk);
-	}
+	if (IS_ERR(atmel_pioctrl->clk))
+		return dev_err_probe(dev, PTR_ERR(atmel_pioctrl->clk), "failed to get clock\n");
 
 	atmel_pioctrl->pins = devm_kcalloc(dev,
 					   atmel_pioctrl->npins,
@@ -1200,10 +1197,8 @@ static int atmel_pinctrl_probe(struct platform_device *pdev)
 	atmel_pioctrl->irq_domain = irq_domain_add_linear(dev->of_node,
 			atmel_pioctrl->gpio_chip->ngpio,
 			&irq_domain_simple_ops, NULL);
-	if (!atmel_pioctrl->irq_domain) {
-		dev_err(dev, "can't add the irq domain\n");
-		return -ENODEV;
-	}
+	if (!atmel_pioctrl->irq_domain)
+		return dev_err_probe(dev, -ENODEV, "can't add the irq domain\n");
 	atmel_pioctrl->irq_domain->name = "atmel gpio";
 
 	for (i = 0; i < atmel_pioctrl->npins; i++) {
-- 
2.34.1

