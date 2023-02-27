Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2A886A4945
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 19:08:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230394AbjB0SI1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 13:08:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230323AbjB0SIX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 13:08:23 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F247983ED;
        Mon, 27 Feb 2023 10:08:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1677521286; x=1709057286;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ZohFvfWo263Ee4SU+7SItzPED/qSzAp2y0OSDCQoags=;
  b=cT/DQPEH0g2JxLILPkke0SOy/Gb6e581bGGBi8qKI7/DoeuLjoIoa5UR
   wa2C98sNZi1OuuSZoga5blr8oxm4qqiWYRfGEz9oSBNx/jVROfzkme+Yd
   Er0U0RM8yEwRsGqWYmhe+4fzN/y90PwvESL4zA4NlHvq2oKeQJX1jKQS3
   iV2i1EolOqKT+YpG9c+/OmeybzYV7lkKFbXcbUcqxSp46KeOhZnUP8V1e
   eBnYBSdGrVExjfJW5lI55/XJKq/sU6uThi4g6D6GE1/CJEZAL6pRslGJl
   w6N+fgjDTstFke7sbJ42D+9R9hH3nAsax/IVJ0PL5qHW7HupMKaQF26Ln
   w==;
X-IronPort-AV: E=Sophos;i="5.98,219,1673938800"; 
   d="scan'208";a="202436818"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 27 Feb 2023 11:07:26 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Mon, 27 Feb 2023 11:07:20 -0700
Received: from ryan-Precision-3630-Tower.microchip.com (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.16 via Frontend Transport; Mon, 27 Feb 2023 11:07:20 -0700
From:   <Ryan.Wanner@microchip.com>
To:     <ludovic.desroches@microchip.com>, <linus.walleij@linaro.org>,
        <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <claudiu.beznea@microchip.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-gpio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        Ryan Wanner <Ryan.Wanner@microchip.com>
Subject: [PATCH v3 1/2] pinctrl: at91-pio4: Implement the correct drive values for sama7g5
Date:   Mon, 27 Feb 2023 11:07:27 -0700
Message-ID: <43fbb5306ccb8852e43d730a88be7bbd3973535d.1677520830.git.Ryan.Wanner@microchip.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <cover.1677520830.git.Ryan.Wanner@microchip.com>
References: <cover.1677520830.git.Ryan.Wanner@microchip.com>
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

From: Ryan Wanner <Ryan.Wanner@microchip.com>

Sama7g5 drive strength options have been updated from previous pio4
products. Now values will correctly align with sama7g5 drive strength
options highlighted in the sama7g5 data sheet.

Add xlate to separate the sama7g5 drive values and the sama5d27
drive values.

Signed-off-by: Ryan Wanner <Ryan.Wanner@microchip.com>
---
changes since v2:
-Add sama7g5 differences to dbg_show.
-Remove array length for xlate.

 drivers/pinctrl/pinctrl-at91-pio4.c | 54 ++++++++++++++++++++++++++---
 1 file changed, 49 insertions(+), 5 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-at91-pio4.c b/drivers/pinctrl/pinctrl-at91-pio4.c
index 82b921fd630d..76af50d62404 100644
--- a/drivers/pinctrl/pinctrl-at91-pio4.c
+++ b/drivers/pinctrl/pinctrl-at91-pio4.c
@@ -72,17 +72,33 @@
 /* Custom pinconf parameters */
 #define ATMEL_PIN_CONFIG_DRIVE_STRENGTH	(PIN_CONFIG_END + 1)
 
+static const unsigned int drive_strength_xlate_sama7g5[] = {
+	ATMEL_PIO_DRVSTR_LO_D,
+	ATMEL_PIO_DRVSTR_HI_A,
+	ATMEL_PIO_DRVSTR_LO_C,
+	ATMEL_PIO_DRVSTR_LO_B
+};
+
+static const unsigned int drive_strength_xlate_sama5d2[] = {
+	ATMEL_PIO_DRVSTR_LO,
+	ATMEL_PIO_DRVSTR_LO_1,
+	ATMEL_PIO_DRVSTR_ME,
+	ATMEL_PIO_DRVSTR_HI
+};
+
 /**
  * struct atmel_pioctrl_data - Atmel PIO controller (pinmux + gpio) data struct
  * @nbanks: number of PIO banks
  * @last_bank_count: number of lines in the last bank (can be less than
  *	the rest of the banks).
  * @slew_rate_support: slew rate support
+ * @drv_stre_xlate: xlate for different drive values
  */
 struct atmel_pioctrl_data {
 	unsigned int nbanks;
 	unsigned int last_bank_count;
 	unsigned int slew_rate_support;
+	const unsigned int *drv_stre_xlate;
 };
 
 struct atmel_group {
@@ -121,6 +137,7 @@ struct atmel_pin {
  * @dev: device entry for the Atmel PIO controller.
  * @node: node of the Atmel PIO controller.
  * @slew_rate_support: slew rate support
+ * @drv_stre_xlate: xlate for different drive values
  */
 struct atmel_pioctrl {
 	void __iomem		*reg_base;
@@ -143,6 +160,7 @@ struct atmel_pioctrl {
 	struct device		*dev;
 	struct device_node	*node;
 	unsigned int		slew_rate_support;
+	const unsigned int	*drv_stre_xlate;
 };
 
 static const char * const atmel_functions[] = {
@@ -872,12 +890,17 @@ static int atmel_conf_pin_config_group_set(struct pinctrl_dev *pctldev,
 				conf &= ~ATMEL_PIO_SR_MASK;
 			break;
 		case ATMEL_PIN_CONFIG_DRIVE_STRENGTH:
+			if (arg > ATMEL_PIO_DRVSTR_HI || arg < ATMEL_PIO_DRVSTR_LO) {
+				dev_warn(pctldev->dev, "drive strength not updated (incorrect value)\n");
+				break;
+			}
 			switch (arg) {
 			case ATMEL_PIO_DRVSTR_LO:
+			case ATMEL_PIO_DRVSTR_LO_1:
 			case ATMEL_PIO_DRVSTR_ME:
 			case ATMEL_PIO_DRVSTR_HI:
 				conf &= (~ATMEL_PIO_DRVSTR_MASK);
-				conf |= arg << ATMEL_PIO_DRVSTR_OFFSET;
+				conf |= atmel_pioctrl->drv_stre_xlate[arg] << ATMEL_PIO_DRVSTR_OFFSET;
 				break;
 			default:
 				dev_warn(pctldev->dev, "drive strength not updated (incorrect value)\n");
@@ -903,6 +926,8 @@ static void atmel_conf_pin_config_dbg_show(struct pinctrl_dev *pctldev,
 {
 	struct atmel_pioctrl *atmel_pioctrl = pinctrl_dev_get_drvdata(pctldev);
 	u32 conf;
+	unsigned int arg;
+	u8 is_sama7 = atmel_pioctrl->drv_stre_xlate == drive_strength_xlate_sama7g5;
 
 	if (!atmel_pioctrl->pins[pin_id]->device)
 		return;
@@ -926,16 +951,32 @@ static void atmel_conf_pin_config_dbg_show(struct pinctrl_dev *pctldev,
 	if (atmel_pioctrl->slew_rate_support && (conf & ATMEL_PIO_SR_MASK))
 		seq_printf(s, "%s ", "slew-rate");
 	if (conf & ATMEL_PIO_DRVSTR_MASK) {
-		switch ((conf & ATMEL_PIO_DRVSTR_MASK) >> ATMEL_PIO_DRVSTR_OFFSET) {
+		arg = (conf & ATMEL_PIO_DRVSTR_MASK) >> ATMEL_PIO_DRVSTR_OFFSET;
+		switch (atmel_pioctrl->drv_stre_xlate[arg]) {
 		case ATMEL_PIO_DRVSTR_ME:
-			seq_printf(s, "%s ", "medium-drive");
+			if (is_sama7)
+				seq_printf(s, "%s ", "low-drive-typeD");
+			else
+				seq_printf(s, "%s ", "medium-drive");
 			break;
 		case ATMEL_PIO_DRVSTR_HI:
-			seq_printf(s, "%s ", "high-drive");
+			if (is_sama7)
+				seq_printf(s, "%s ", "low-drive-typeB");
+			else
+				seq_printf(s, "%s ", "high-drive");
+			break;
+		case ATMEL_PIO_DRVSTR_HI_A:
+			if (is_sama7)
+				seq_printf(s, "%s ", "high-drive-typeA");
+			else
+				seq_printf(s, "%s ", "low-drive");
 			break;
 		/* ATMEL_PIO_DRVSTR_LO and 0 which is the default value at reset */
 		default:
-			seq_printf(s, "%s ", "low-drive");
+			if (is_sama7)
+				seq_printf(s, "%s ", "low-drive-typeD");
+			else
+				seq_printf(s, "%s ", "low-drive");
 		}
 	}
 }
@@ -1013,12 +1054,14 @@ static const struct dev_pm_ops atmel_pctrl_pm_ops = {
 static const struct atmel_pioctrl_data atmel_sama5d2_pioctrl_data = {
 	.nbanks			= 4,
 	.last_bank_count	= ATMEL_PIO_NPINS_PER_BANK,
+	.drv_stre_xlate		= drive_strength_xlate_sama5d2,
 };
 
 static const struct atmel_pioctrl_data microchip_sama7g5_pioctrl_data = {
 	.nbanks			= 5,
 	.last_bank_count	= 8, /* sama7g5 has only PE0 to PE7 */
 	.slew_rate_support	= 1,
+	.drv_stre_xlate		= drive_strength_xlate_sama7g5,
 };
 
 static const struct of_device_id atmel_pctrl_of_match[] = {
@@ -1064,6 +1107,7 @@ static int atmel_pinctrl_probe(struct platform_device *pdev)
 		atmel_pioctrl->npins += atmel_pioctrl_data->last_bank_count;
 	}
 	atmel_pioctrl->slew_rate_support = atmel_pioctrl_data->slew_rate_support;
+	atmel_pioctrl->drv_stre_xlate = atmel_pioctrl_data->drv_stre_xlate;
 
 	atmel_pioctrl->reg_base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(atmel_pioctrl->reg_base))
-- 
2.37.2

