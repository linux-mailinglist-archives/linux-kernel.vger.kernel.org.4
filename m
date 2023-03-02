Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A3AB6A80A4
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 12:02:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230096AbjCBLB7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 06:01:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229947AbjCBLBv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 06:01:51 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42BA9460AF;
        Thu,  2 Mar 2023 03:01:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1677754899; x=1709290899;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Bf1Z7/sfzlJmrMOEOjhTIy25zAMrI0ji7izXGtHopIU=;
  b=dYO4Di4CJyy1Aaqk+akeLRkiMp+nyps3JxGJRHa9nF5ncv8oQ/3O+bP5
   hN3EuQS5f/kktg4A3OWE380E8dR33b8w6pBEhk/pjNBYSAdNpknTzB4gj
   CgTMUZE2qMcX3j/BOS05Lw+PP+WrDW7wLUokSNhkDRtN8U1oxRjmR8e9e
   Kh8lZbNKYBA2G1YMalGIcQeS1A/BUPieFSVP8r2DdvgrXL88G2wZAgFrq
   xTSQ8IBclg1zDGJu+bgUwfg048ig+QiMSaXYlskmZIwtqECjJ1f6s1QVC
   uyJ4ILPQgmyMM9Y8WOWsH/dhfrZl3cjjgANzvISV7u+ayxLql7gOijMUC
   A==;
X-IronPort-AV: E=Sophos;i="5.98,227,1673938800"; 
   d="scan'208";a="203271644"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 02 Mar 2023 04:01:37 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Thu, 2 Mar 2023 04:01:35 -0700
Received: from m18063-ThinkPad-T460p.mchp-main.com (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.16 via Frontend Transport; Thu, 2 Mar 2023 04:01:33 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <ludovic.desroches@microchip.com>, <linus.walleij@linaro.org>,
        <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-gpio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH 2/4] pinctrl: at91-pio4: use device_get_match_data()
Date:   Thu, 2 Mar 2023 13:01:14 +0200
Message-ID: <20230302110116.342486-3-claudiu.beznea@microchip.com>
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

Use device_get_match_data() to simplify the code.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 drivers/pinctrl/pinctrl-at91-pio4.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-at91-pio4.c b/drivers/pinctrl/pinctrl-at91-pio4.c
index 0aceb723f94c..93023d0fd75b 100644
--- a/drivers/pinctrl/pinctrl-at91-pio4.c
+++ b/drivers/pinctrl/pinctrl-at91-pio4.c
@@ -1067,7 +1067,6 @@ static int atmel_pinctrl_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct pinctrl_pin_desc	*pin_desc;
 	const char **group_names;
-	const struct of_device_id *match;
 	int i, ret;
 	struct atmel_pioctrl *atmel_pioctrl;
 	const struct atmel_pioctrl_data *atmel_pioctrl_data;
@@ -1079,12 +1078,11 @@ static int atmel_pinctrl_probe(struct platform_device *pdev)
 	atmel_pioctrl->node = dev->of_node;
 	platform_set_drvdata(pdev, atmel_pioctrl);
 
-	match = of_match_node(atmel_pctrl_of_match, dev->of_node);
-	if (!match) {
-		dev_err(dev, "unknown compatible string\n");
+	atmel_pioctrl_data = device_get_match_data(dev);
+	if (!atmel_pioctrl_data) {
+		dev_err(dev, "Invalid device data\n");
 		return -ENODEV;
 	}
-	atmel_pioctrl_data = match->data;
 	atmel_pioctrl->nbanks = atmel_pioctrl_data->nbanks;
 	atmel_pioctrl->npins = atmel_pioctrl->nbanks * ATMEL_PIO_NPINS_PER_BANK;
 	/* if last bank has limited number of pins, adjust accordingly */
-- 
2.34.1

