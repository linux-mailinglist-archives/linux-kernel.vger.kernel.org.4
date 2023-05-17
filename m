Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BF3F70672D
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 13:54:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230489AbjEQLyO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 07:54:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230417AbjEQLyL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 07:54:11 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A2C959D6;
        Wed, 17 May 2023 04:54:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1684324449; x=1715860449;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=H3FtDCLhrVU8sD+tqYMnUEm+nabD8KDFiQrtCAaSPlU=;
  b=EnSHgpOxs0ub92xHwWDSwPbNEGYxrSpTH65SviPhtu2EVoi/OzY7c9zL
   noDFVzHuwB1T254l/wmnOz7/0anjyd/M6zb2Z4xARp+D0LiQzQ1iQvd/z
   TuayyBQoT6znfqb+1EDW9bm8hV6gmZjcxuDN2dsl5l91JcNuEvhHQVVDR
   bevuAoNAxiU3srMlhWd7nbg4uEKDFlvjBDKHqd8J7WMTk/v4/nprh+Wo4
   wwpKt82lpXK5H6XvVG302rL75ayjRVbpdL9zWzx5zyu7/gFaWUapiLZUB
   waHCpcCy04L3l9mSiJK5NG5DBk15wu8gXLoiCR3q3r7IJ+6G2wjpSwZna
   w==;
X-IronPort-AV: E=Sophos;i="5.99,282,1677567600"; 
   d="scan'208";a="213707567"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 17 May 2023 04:54:08 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 17 May 2023 04:54:08 -0700
Received: from ryan-Precision-5560.microchip.com (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.21 via Frontend Transport; Wed, 17 May 2023 04:54:04 -0700
From:   <Ryan.Wanner@microchip.com>
To:     <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <nicolas.ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <claudiu.beznea@microchip.com>,
        <linus.walleij@linaro.org>, <ludovic.desroches@microchip.com>
CC:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-gpio@vger.kernel.org>,
        Ryan Wanner <Ryan.Wanner@microchip.com>
Subject: [PATCH 1/3] pinctrl: at91-pio4: Enable Push-Pull configuration
Date:   Wed, 17 May 2023 13:54:04 +0200
Message-ID: <d898c31277f6bce6f7d830edf4332ff605498c7b.1684313910.git.Ryan.Wanner@microchip.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1684313910.git.Ryan.Wanner@microchip.com>
References: <cover.1684313910.git.Ryan.Wanner@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ryan Wanner <Ryan.Wanner@microchip.com>

Enable push-pull configuration. Remove integer value argument from
open-drain configuration as it is discarded when pinconf function is
called from gpiolib. Add push-pull do debug and get functions.

Signed-off-by: Ryan Wanner <Ryan.Wanner@microchip.com>
---
 drivers/pinctrl/pinctrl-at91-pio4.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-at91-pio4.c b/drivers/pinctrl/pinctrl-at91-pio4.c
index 2fe40acb6a3e..3c39d62bbc3c 100644
--- a/drivers/pinctrl/pinctrl-at91-pio4.c
+++ b/drivers/pinctrl/pinctrl-at91-pio4.c
@@ -762,6 +762,11 @@ static int atmel_conf_pin_config_group_get(struct pinctrl_dev *pctldev,
 			return -EINVAL;
 		arg = 1;
 		break;
+	case PIN_CONFIG_DRIVE_PUSH_PULL:
+		if (res & ATMEL_PIO_OPD_MASK)
+			return -EINVAL;
+		arg = 1;
+		break;
 	case PIN_CONFIG_INPUT_SCHMITT_ENABLE:
 		if (!(res & ATMEL_PIO_SCHMITT_MASK))
 			return -EINVAL;
@@ -827,10 +832,10 @@ static int atmel_conf_pin_config_group_set(struct pinctrl_dev *pctldev,
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
@@ -948,6 +953,8 @@ static void atmel_conf_pin_config_dbg_show(struct pinctrl_dev *pctldev,
 		seq_printf(s, "%s ", "debounce");
 	if (conf & ATMEL_PIO_OPD_MASK)
 		seq_printf(s, "%s ", "open-drain");
+	if (!(conf & ATMEL_PIO_OPD_MASK))
+		seq_printf(s, "%s ", "push-pull");
 	if (conf & ATMEL_PIO_SCHMITT_MASK)
 		seq_printf(s, "%s ", "schmitt");
 	if (atmel_pioctrl->slew_rate_support && (conf & ATMEL_PIO_SR_MASK))
-- 
2.39.2

