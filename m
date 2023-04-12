Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C40536DFCFA
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 19:51:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230048AbjDLRvh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 13:51:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229831AbjDLRvf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 13:51:35 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 933749E;
        Wed, 12 Apr 2023 10:51:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1681321894; x=1712857894;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=gmb/rlmitwhnf0NxNDqppMtOJV914w5lfvnM7EmTvKM=;
  b=Q2RAGvsJnIsGjDEKtk9ZLmKTsMjZ/C0VOiGxKuNjrbA+Z9VzVZzSPJVh
   D/pocVK7J6s+6R2cP5FztBvDL+MMm2lAJFskBUVJlmEPfFCw7NbVXq1Ml
   YWR/J09D83Z8ToIzEmN46HvyZkbm1bs8vsIcHdTyEBmwBeODCXcyT8UrC
   FdmiYml4/2A1X0DCGH4cGn6XlLTSI2H3tcVHD65EAs02ZFcWYcZo+TNyO
   U5PNPC5v4d1zCGFCxDN1OT3RDWGhPA5hjQ+K5FXNhuIy1svxmjqcM4Sgh
   Sx+4ChBXXlJAaSlnio7NX8EkCMo5n01UQvvAidZTJucSkOIFCF8aHWFBA
   w==;
X-IronPort-AV: E=Sophos;i="5.98,339,1673938800"; 
   d="scan'208";a="208825837"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 12 Apr 2023 10:51:34 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 12 Apr 2023 10:51:33 -0700
Received: from ryan-Precision-3630-Tower.microchip.com (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.21 via Frontend Transport; Wed, 12 Apr 2023 10:51:33 -0700
From:   <Ryan.Wanner@microchip.com>
To:     <ludovic.desroches@microchip.com>, <linus.walleij@linaro.org>,
        <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <claudiu.beznea@microchip.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-gpio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Ryan Wanner <Ryan.Wanner@microchip.com>
Subject: [linux][PATCH] pinctrl: at91-pio4: Add push-pull drive configuration
Date:   Wed, 12 Apr 2023 10:51:46 -0700
Message-ID: <20230412175146.886684-1-Ryan.Wanner@microchip.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ryan Wanner <Ryan.Wanner@microchip.com>

The PIO4 does support push-pull configuration as this is the default
state of the open-drain register. Adapt the driver for this.

Signed-off-by: Ryan Wanner <Ryan.Wanner@microchip.com>
---
This patch also fixes the warning of unsupported
configuration param 8.

This was tested on both sama5d2-som1-ek and sama7g5ek. I used dbg_show
fucntion to test if the configuration was correct when adding
drive-open-drain or drive-push-pull to the dts file.

 drivers/pinctrl/pinctrl-at91-pio4.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-at91-pio4.c b/drivers/pinctrl/pinctrl-at91-pio4.c
index a30c6f7c9016..9a0cddfeaf92 100644
--- a/drivers/pinctrl/pinctrl-at91-pio4.c
+++ b/drivers/pinctrl/pinctrl-at91-pio4.c
@@ -776,6 +776,11 @@ static int atmel_conf_pin_config_group_get(struct pinctrl_dev *pctldev,
 			return -EINVAL;
 		arg = 1;
 		break;
+	case PIN_CONFIG_DRIVE_PUSH_PULL:
+		if ((res & ATMEL_PIO_OPD_MASK))
+			return -EINVAL;
+		arg = 1;
+		break;
 	case PIN_CONFIG_INPUT_SCHMITT_ENABLE:
 		if (!(res & ATMEL_PIO_SCHMITT_MASK))
 			return -EINVAL;
@@ -839,10 +844,10 @@ static int atmel_conf_pin_config_group_set(struct pinctrl_dev *pctldev,
 			conf &= (~ATMEL_PIO_PUEN_MASK);
 			break;
 		case PIN_CONFIG_DRIVE_OPEN_DRAIN:
-			if (arg == 0)
-				conf &= (~ATMEL_PIO_OPD_MASK);
-			else
-				conf |= ATMEL_PIO_OPD_MASK;
+			conf |= ATMEL_PIO_OPD_MASK;
+			break;
+		case PIN_CONFIG_DRIVE_PUSH_PULL:
+			conf &= (~ATMEL_PIO_OPD_MASK);
 			break;
 		case PIN_CONFIG_INPUT_SCHMITT_ENABLE:
 			if (arg == 0)
@@ -937,8 +942,10 @@ static void atmel_conf_pin_config_dbg_show(struct pinctrl_dev *pctldev,
 		seq_printf(s, "%s ", "pull-down");
 	if (conf & ATMEL_PIO_IFEN_MASK)
 		seq_printf(s, "%s ", "debounce");
-	if (conf & ATMEL_PIO_OPD_MASK)
+	if ((conf & ATMEL_PIO_OPD_MASK) > 0)
 		seq_printf(s, "%s ", "open-drain");
+	if ((conf & ATMEL_PIO_OPD_MASK) == 0)
+		seq_printf(s, "%s ", "push-pull");
 	if (conf & ATMEL_PIO_SCHMITT_MASK)
 		seq_printf(s, "%s ", "schmitt");
 	if (atmel_pioctrl->slew_rate_support && (conf & ATMEL_PIO_SR_MASK))
-- 
2.37.2

