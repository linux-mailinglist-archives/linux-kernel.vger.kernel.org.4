Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 132256A80A3
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 12:02:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230082AbjCBLB5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 06:01:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229719AbjCBLBt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 06:01:49 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29197457DB;
        Thu,  2 Mar 2023 03:01:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1677754895; x=1709290895;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hyWxrfmSizpBS+n92kWqaBMSXOT85gSrHaQamS5MXSQ=;
  b=ryLkpByoZuydQnf0QOQtP53i2Cf2DFYDICH+2sH6oTN8i82XmCmJxFdw
   Uu6okBb6qeLWEqYNZyjAmfef3PfGtWougzkyNOrjqPsg3UhZ3VZDREyyG
   og3IIcdfVai/lQYBvUXOO83TSojkWFuo8rnKPpno19hkhjK2xtT/Y88ql
   +ZTNHMYeygfN6rDJEoc+lJ+5DJmv6jHwGOaOV4u3i2NJNpBLVMiSFsDJn
   /rN3E0VUyHOiv3B1tDUXRkou5uFSgy+dwbNwXjcx5vxoq1BIZJHS7hFrU
   pr4cmqy20p7UgxyM4OMte2TNL8HpCHgHnD1FUBrpDSmvlQq4cap79uBeF
   w==;
X-IronPort-AV: E=Sophos;i="5.98,227,1673938800"; 
   d="scan'208";a="199564352"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 02 Mar 2023 04:01:34 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Thu, 2 Mar 2023 04:01:33 -0700
Received: from m18063-ThinkPad-T460p.mchp-main.com (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.16 via Frontend Transport; Thu, 2 Mar 2023 04:01:30 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <ludovic.desroches@microchip.com>, <linus.walleij@linaro.org>,
        <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-gpio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH 1/4] pinctrl: at91-pio4: use devm_clk_get_enabled()
Date:   Thu, 2 Mar 2023 13:01:13 +0200
Message-ID: <20230302110116.342486-2-claudiu.beznea@microchip.com>
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

Use devm_clk_get_enabled() to simplify the code.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 drivers/pinctrl/pinctrl-at91-pio4.c | 17 ++++-------------
 1 file changed, 4 insertions(+), 13 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-at91-pio4.c b/drivers/pinctrl/pinctrl-at91-pio4.c
index 39b233f73e13..0aceb723f94c 100644
--- a/drivers/pinctrl/pinctrl-at91-pio4.c
+++ b/drivers/pinctrl/pinctrl-at91-pio4.c
@@ -1098,7 +1098,7 @@ static int atmel_pinctrl_probe(struct platform_device *pdev)
 	if (IS_ERR(atmel_pioctrl->reg_base))
 		return PTR_ERR(atmel_pioctrl->reg_base);
 
-	atmel_pioctrl->clk = devm_clk_get(dev, NULL);
+	atmel_pioctrl->clk = devm_clk_get_enabled(dev, NULL);
 	if (IS_ERR(atmel_pioctrl->clk)) {
 		dev_err(dev, "failed to get clock\n");
 		return PTR_ERR(atmel_pioctrl->clk);
@@ -1219,25 +1219,19 @@ static int atmel_pinctrl_probe(struct platform_device *pdev)
 			i, irq);
 	}
 
-	ret = clk_prepare_enable(atmel_pioctrl->clk);
-	if (ret) {
-		dev_err(dev, "failed to prepare and enable clock\n");
-		goto clk_prepare_enable_error;
-	}
-
 	atmel_pioctrl->pinctrl_dev = devm_pinctrl_register(&pdev->dev,
 							   &atmel_pinctrl_desc,
 							   atmel_pioctrl);
 	if (IS_ERR(atmel_pioctrl->pinctrl_dev)) {
 		ret = PTR_ERR(atmel_pioctrl->pinctrl_dev);
 		dev_err(dev, "pinctrl registration failed\n");
-		goto clk_unprep;
+		goto irq_domain_remove_error;
 	}
 
 	ret = gpiochip_add_data(atmel_pioctrl->gpio_chip, atmel_pioctrl);
 	if (ret) {
 		dev_err(dev, "failed to add gpiochip\n");
-		goto clk_unprep;
+		goto irq_domain_remove_error;
 	}
 
 	ret = gpiochip_add_pin_range(atmel_pioctrl->gpio_chip, dev_name(dev),
@@ -1254,10 +1248,7 @@ static int atmel_pinctrl_probe(struct platform_device *pdev)
 gpiochip_add_pin_range_error:
 	gpiochip_remove(atmel_pioctrl->gpio_chip);
 
-clk_unprep:
-	clk_disable_unprepare(atmel_pioctrl->clk);
-
-clk_prepare_enable_error:
+irq_domain_remove_error:
 	irq_domain_remove(atmel_pioctrl->irq_domain);
 
 	return ret;
-- 
2.34.1

