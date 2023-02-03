Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D797D6899BA
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 14:30:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232700AbjBCNaI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 08:30:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232776AbjBCNaE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 08:30:04 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2C74627B5;
        Fri,  3 Feb 2023 05:29:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1675430968; x=1706966968;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=HRL4soUZGhkgOpsuFJTflw9CMFVUDRCcn8Px2h/bpVI=;
  b=Tvz8v9i2OZW2uOxG/PYCiXNZN2pEApfUnskhaNC6e8bJiGIZoPEYLb6p
   zdZdoO3o/W/lsFPFbXZ9BAjUE3ADh5+d48C32bGdubbOask2mo+44Xk+g
   tdBSIaJCWsMYT7VEDftqLoG2wRk0ickJW2adkT7iTTNFWCixQTC+m7jTw
   kItRJuVq1LXdQd8fr0ewd2/K4Fs72vHj3Rk1dqFJ0Ehz7hk+YjuZ/tFo2
   dPvj/bOLHX91eA/ts15lNfcaFRnehjLi/Bu56fUsHxhuIhNxT9SR28ow4
   BrRVGesMF3minCxE1Xl9BUHawDdb6fvaPlK7oo+nPUaDxvWBS44Nme3j5
   w==;
X-IronPort-AV: E=Sophos;i="5.97,270,1669100400"; 
   d="scan'208";a="135441456"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 03 Feb 2023 06:29:27 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Fri, 3 Feb 2023 06:29:20 -0700
Received: from m18063-ThinkPad-T460p.mchp-main.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.16 via Frontend Transport; Fri, 3 Feb 2023 06:29:18 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <ludovic.desroches@microchip.com>, <linus.walleij@linaro.org>,
        <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-gpio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH] pinctrl: at91: use devm_kasprintf() to avoid potential leaks
Date:   Fri, 3 Feb 2023 15:27:14 +0200
Message-ID: <20230203132714.1931596-1-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.34.1
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

Use devm_kasprintf() instead of kasprintf() to avoid any potential
leaks. At the moment drivers have no remove functionality thus
there is no need for fixes tag.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 drivers/pinctrl/pinctrl-at91-pio4.c | 4 ++--
 drivers/pinctrl/pinctrl-at91.c      | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-at91-pio4.c b/drivers/pinctrl/pinctrl-at91-pio4.c
index 39b233f73e13..373eed8bc4be 100644
--- a/drivers/pinctrl/pinctrl-at91-pio4.c
+++ b/drivers/pinctrl/pinctrl-at91-pio4.c
@@ -1149,8 +1149,8 @@ static int atmel_pinctrl_probe(struct platform_device *pdev)
 
 		pin_desc[i].number = i;
 		/* Pin naming convention: P(bank_name)(bank_pin_number). */
-		pin_desc[i].name = kasprintf(GFP_KERNEL, "P%c%d",
-					     bank + 'A', line);
+		pin_desc[i].name = devm_kasprintf(&pdev->dev, GFP_KERNEL, "P%c%d",
+						  bank + 'A', line);
 
 		group->name = group_names[i] = pin_desc[i].name;
 		group->pin = pin_desc[i].number;
diff --git a/drivers/pinctrl/pinctrl-at91.c b/drivers/pinctrl/pinctrl-at91.c
index 1e1813d7c550..c405296e4989 100644
--- a/drivers/pinctrl/pinctrl-at91.c
+++ b/drivers/pinctrl/pinctrl-at91.c
@@ -1885,7 +1885,7 @@ static int at91_gpio_probe(struct platform_device *pdev)
 	}
 
 	for (i = 0; i < chip->ngpio; i++)
-		names[i] = kasprintf(GFP_KERNEL, "pio%c%d", alias_idx + 'A', i);
+		names[i] = devm_kasprintf(&pdev->dev, GFP_KERNEL, "pio%c%d", alias_idx + 'A', i);
 
 	chip->names = (const char *const *)names;
 
-- 
2.34.1

