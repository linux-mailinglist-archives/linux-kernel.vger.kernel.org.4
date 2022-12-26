Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BC516560D3
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Dec 2022 08:39:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231749AbiLZHjv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Dec 2022 02:39:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231740AbiLZHjs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Dec 2022 02:39:48 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA8515FCF;
        Sun, 25 Dec 2022 23:39:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1672040385; x=1703576385;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/rDIr06Ya8FrrFC7WG0rQNpWeQWxKLIOjBpNInJ2h64=;
  b=bIt1IcfNjoXP97twsANQ+nBdyZJX/z/LwTAmNhNQB07Ou0hY8HdU/8CS
   TteWbjjk+wFrZaL3Wj8daEwAN444muf81CZN7qy9uNq/A9gmtLwQtjlqD
   EeqUX6A7rfEo94Rt6SXROmRJQyCmuv0SVCDMY7WZzvWcUVleWW+FeRqMu
   MMSHlgapQm6N8ECvuBOyIFwjYAd3Wu5/askbMr1ocFYXAEm1i3ER3TkI3
   st9S6Cf2ngN1tojEWiGLIG/ZadahTeIQX2MAwsN3AeUEDOx+qqPrxpbNH
   hkfFc/laDsNc/0tUPtawIvdP6gCNZ+viOqzOvrCBJ4ZDLBM1SNilTpUvH
   A==;
X-IronPort-AV: E=Sophos;i="5.96,274,1665471600"; 
   d="scan'208";a="194420560"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 26 Dec 2022 00:39:44 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Mon, 26 Dec 2022 00:39:44 -0700
Received: from che-lt-i64410lx.amer.actel.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.16 via Frontend Transport; Mon, 26 Dec 2022 00:39:39 -0700
From:   Balamanikandan Gunasundar 
        <balamanikandan.gunasundar@microchip.com>
To:     <ludovic.desroches@microchip.com>, <nicolas.ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <linux-kernel@vger.kernel.org>,
        <linux-mmc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linus.walleij@linaro.org>,
        <hari.prasathge@microchip.com>, <dmitry.torokhov@gmail.com>,
        <ulf.hansson@linaro.org>
CC:     <balamanikandan.gunasundar@microchip.com>
Subject: [PATCH v3 1/2] mmc: atmel-mci: Convert to gpio descriptors
Date:   Mon, 26 Dec 2022 13:09:07 +0530
Message-ID: <20221226073908.17317-2-balamanikandan.gunasundar@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221226073908.17317-1-balamanikandan.gunasundar@microchip.com>
References: <20221226073908.17317-1-balamanikandan.gunasundar@microchip.com>
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

Replace the legacy GPIO APIs with gpio descriptor consumer interface.

To maintain backward compatibility, we rely on the "cd-inverted"
property to manage the invertion flag instead of GPIO property.

Signed-off-by: Balamanikandan Gunasundar <balamanikandan.gunasundar@microchip.com>
---
 drivers/mmc/host/atmel-mci.c | 78 +++++++++++++++++-------------------
 include/linux/atmel-mci.h    |  4 +-
 2 files changed, 39 insertions(+), 43 deletions(-)

diff --git a/drivers/mmc/host/atmel-mci.c b/drivers/mmc/host/atmel-mci.c
index 67b2cd166e56..6ab43733ba9f 100644
--- a/drivers/mmc/host/atmel-mci.c
+++ b/drivers/mmc/host/atmel-mci.c
@@ -11,7 +11,6 @@
 #include <linux/dmaengine.h>
 #include <linux/dma-mapping.h>
 #include <linux/err.h>
-#include <linux/gpio.h>
 #include <linux/init.h>
 #include <linux/interrupt.h>
 #include <linux/io.h>
@@ -19,7 +18,8 @@
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/of_device.h>
-#include <linux/of_gpio.h>
+#include <linux/irq.h>
+#include <linux/gpio/consumer.h>
 #include <linux/platform_device.h>
 #include <linux/scatterlist.h>
 #include <linux/seq_file.h>
@@ -389,8 +389,8 @@ struct atmel_mci_slot {
 #define ATMCI_CARD_NEED_INIT	1
 #define ATMCI_SHUTDOWN		2
 
-	int			detect_pin;
-	int			wp_pin;
+	struct gpio_desc        *detect_pin;
+	struct gpio_desc	*wp_pin;
 	bool			detect_is_active_high;
 
 	struct timer_list	detect_timer;
@@ -638,7 +638,10 @@ atmci_of_init(struct platform_device *pdev)
 			pdata->slot[slot_id].bus_width = 1;
 
 		pdata->slot[slot_id].detect_pin =
-			of_get_named_gpio(cnp, "cd-gpios", 0);
+			devm_fwnode_gpiod_get(&pdev->dev, of_fwnode_handle(cnp),
+					      "cd", GPIOD_IN, "cd-gpios");
+		if (IS_ERR(pdata->slot[slot_id].detect_pin))
+			pdata->slot[slot_id].detect_pin = NULL;
 
 		pdata->slot[slot_id].detect_is_active_high =
 			of_property_read_bool(cnp, "cd-inverted");
@@ -647,7 +650,10 @@ atmci_of_init(struct platform_device *pdev)
 			of_property_read_bool(cnp, "non-removable");
 
 		pdata->slot[slot_id].wp_pin =
-			of_get_named_gpio(cnp, "wp-gpios", 0);
+			devm_fwnode_gpiod_get(&pdev->dev, of_fwnode_handle(cnp),
+					      "wp", GPIOD_IN, "wp-gpios");
+		if (IS_ERR(pdata->slot[slot_id].wp_pin))
+			pdata->slot[slot_id].wp_pin = NULL;
 	}
 
 	return pdata;
@@ -1511,8 +1517,8 @@ static int atmci_get_ro(struct mmc_host *mmc)
 	int			read_only = -ENOSYS;
 	struct atmel_mci_slot	*slot = mmc_priv(mmc);
 
-	if (gpio_is_valid(slot->wp_pin)) {
-		read_only = gpio_get_value(slot->wp_pin);
+	if (slot->wp_pin) {
+		read_only = gpiod_get_value(slot->wp_pin);
 		dev_dbg(&mmc->class_dev, "card is %s\n",
 				read_only ? "read-only" : "read-write");
 	}
@@ -1525,8 +1531,8 @@ static int atmci_get_cd(struct mmc_host *mmc)
 	int			present = -ENOSYS;
 	struct atmel_mci_slot	*slot = mmc_priv(mmc);
 
-	if (gpio_is_valid(slot->detect_pin)) {
-		present = !(gpio_get_value(slot->detect_pin) ^
+	if (slot->detect_pin) {
+		present = !(gpiod_get_raw_value(slot->detect_pin) ^
 			    slot->detect_is_active_high);
 		dev_dbg(&mmc->class_dev, "card is %spresent\n",
 				present ? "" : "not ");
@@ -1639,8 +1645,8 @@ static void atmci_detect_change(struct timer_list *t)
 	if (test_bit(ATMCI_SHUTDOWN, &slot->flags))
 		return;
 
-	enable_irq(gpio_to_irq(slot->detect_pin));
-	present = !(gpio_get_value(slot->detect_pin) ^
+	enable_irq(gpiod_to_irq(slot->detect_pin));
+	present = !(gpiod_get_raw_value(slot->detect_pin) ^
 		    slot->detect_is_active_high);
 	present_old = test_bit(ATMCI_CARD_PRESENT, &slot->flags);
 
@@ -2241,9 +2247,9 @@ static int atmci_init_slot(struct atmel_mci *host,
 	dev_dbg(&mmc->class_dev,
 	        "slot[%u]: bus_width=%u, detect_pin=%d, "
 		"detect_is_active_high=%s, wp_pin=%d\n",
-		id, slot_data->bus_width, slot_data->detect_pin,
+		id, slot_data->bus_width, desc_to_gpio(slot_data->detect_pin),
 		slot_data->detect_is_active_high ? "true" : "false",
-		slot_data->wp_pin);
+		desc_to_gpio(slot_data->wp_pin));
 
 	mmc->ops = &atmci_ops;
 	mmc->f_min = DIV_ROUND_UP(host->bus_hz, 512);
@@ -2279,51 +2285,43 @@ static int atmci_init_slot(struct atmel_mci *host,
 
 	/* Assume card is present initially */
 	set_bit(ATMCI_CARD_PRESENT, &slot->flags);
-	if (gpio_is_valid(slot->detect_pin)) {
-		if (devm_gpio_request(&host->pdev->dev, slot->detect_pin,
-				      "mmc_detect")) {
-			dev_dbg(&mmc->class_dev, "no detect pin available\n");
-			slot->detect_pin = -EBUSY;
-		} else if (gpio_get_value(slot->detect_pin) ^
-				slot->detect_is_active_high) {
+	if (slot->detect_pin) {
+		if (gpiod_get_raw_value(slot->detect_pin) ^
+		    slot->detect_is_active_high) {
 			clear_bit(ATMCI_CARD_PRESENT, &slot->flags);
 		}
+	} else {
+		dev_dbg(&mmc->class_dev, "no detect pin available\n");
 	}
 
-	if (!gpio_is_valid(slot->detect_pin)) {
+	if (!slot->detect_pin) {
 		if (slot_data->non_removable)
 			mmc->caps |= MMC_CAP_NONREMOVABLE;
 		else
 			mmc->caps |= MMC_CAP_NEEDS_POLL;
 	}
 
-	if (gpio_is_valid(slot->wp_pin)) {
-		if (devm_gpio_request(&host->pdev->dev, slot->wp_pin,
-				      "mmc_wp")) {
-			dev_dbg(&mmc->class_dev, "no WP pin available\n");
-			slot->wp_pin = -EBUSY;
-		}
-	}
+	if (!slot->wp_pin)
+		dev_dbg(&mmc->class_dev, "no WP pin available\n");
 
 	host->slot[id] = slot;
 	mmc_regulator_get_supply(mmc);
-	mmc_pwrseq_alloc(slot->mmc);
 	mmc_add_host(mmc);
 
-	if (gpio_is_valid(slot->detect_pin)) {
+	if (slot->detect_pin) {
 		int ret;
 
 		timer_setup(&slot->detect_timer, atmci_detect_change, 0);
 
-		ret = request_irq(gpio_to_irq(slot->detect_pin),
-				atmci_detect_interrupt,
-				IRQF_TRIGGER_FALLING | IRQF_TRIGGER_RISING,
-				"mmc-detect", slot);
+		ret = request_irq(gpiod_to_irq(slot->detect_pin),
+				  atmci_detect_interrupt,
+				  IRQF_TRIGGER_FALLING | IRQF_TRIGGER_RISING,
+				  "mmc-detect", slot);
 		if (ret) {
 			dev_dbg(&mmc->class_dev,
 				"could not request IRQ %d for detect pin\n",
-				gpio_to_irq(slot->detect_pin));
-			slot->detect_pin = -EBUSY;
+				gpiod_to_irq(slot->detect_pin));
+			slot->detect_pin = NULL;
 		}
 	}
 
@@ -2342,10 +2340,8 @@ static void atmci_cleanup_slot(struct atmel_mci_slot *slot,
 
 	mmc_remove_host(slot->mmc);
 
-	if (gpio_is_valid(slot->detect_pin)) {
-		int pin = slot->detect_pin;
-
-		free_irq(gpio_to_irq(pin), slot);
+	if (slot->detect_pin) {
+		free_irq(gpiod_to_irq(slot->detect_pin), slot);
 		del_timer_sync(&slot->detect_timer);
 	}
 
diff --git a/include/linux/atmel-mci.h b/include/linux/atmel-mci.h
index 1491af38cc6e..017e7d8f6126 100644
--- a/include/linux/atmel-mci.h
+++ b/include/linux/atmel-mci.h
@@ -26,8 +26,8 @@
  */
 struct mci_slot_pdata {
 	unsigned int		bus_width;
-	int			detect_pin;
-	int			wp_pin;
+	struct gpio_desc        *detect_pin;
+	struct gpio_desc	*wp_pin;
 	bool			detect_is_active_high;
 	bool			non_removable;
 };
-- 
2.25.1

