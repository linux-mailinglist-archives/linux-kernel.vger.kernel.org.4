Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9A94683844
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 22:05:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231836AbjAaVFV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 16:05:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229876AbjAaVFQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 16:05:16 -0500
Received: from aposti.net (aposti.net [89.234.176.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD8E0B1;
        Tue, 31 Jan 2023 13:05:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1675199113; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:references; bh=1V5cuuwav3MMPhfUaTAvqss/U5kHMNq2CLWt809qYns=;
        b=WgV2FwCk0FUAi8lZNNgSmYjvrJ+1V9pTMNi0J+ifSPY2TM8JVQzvH2MTGzI6kamryI53eR
        Y5xb7/2qAq+VIveHHqm6p6YSYOFm0nZcTKYxJXq1KIcAiWfAIs7rin8pymnc91kYYAu8QS
        EiQAdLdu8cPeO7wpwFR3gxl72Oruwdw=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-mips@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, list@opendingux.net,
        Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH] pinctrl: ingenic: Add I2S pins for the JZ4760(B) and JZ4770
Date:   Tue, 31 Jan 2023 21:05:08 +0000
Message-Id: <20230131210508.68775-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam: Yes
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        SUSPICIOUS_RECIPS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the data structures to support the I2S pins of the JZ4760(B) and
JZ4770 SoCs, which are mostly similar to the JZ4780 ones.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 drivers/pinctrl/pinctrl-ingenic.c | 57 +++++++++++++++++++++++--------
 1 file changed, 43 insertions(+), 14 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-ingenic.c b/drivers/pinctrl/pinctrl-ingenic.c
index 2f220a47b749..efcf6b9d88f3 100644
--- a/drivers/pinctrl/pinctrl-ingenic.c
+++ b/drivers/pinctrl/pinctrl-ingenic.c
@@ -901,7 +901,15 @@ static int jz4760_pwm_pwm5_pins[] = { 0x85, };
 static int jz4760_pwm_pwm6_pins[] = { 0x6a, };
 static int jz4760_pwm_pwm7_pins[] = { 0x6b, };
 static int jz4760_otg_pins[] = { 0x8a, };
-
+static int jz4760_i2s_data_tx0_pins[] = { 0x87, };
+static int jz4760_i2s_data_tx1_pins[] = { 0x8b, };
+static int jz4760_i2s_data_tx2_pins[] = { 0x8c, };
+static int jz4760_i2s_data_tx3_pins[] = { 0x8d, };
+static int jz4760_i2s_data_rx_pins[] = { 0x86, };
+static int jz4760_i2s_clk_txrx_pins[] = { 0x6c, 0x6d, };
+static int jz4760_i2s_sysclk_pins[] = { 0x85, };
+
+static u8 jz4760_i2s_clk_txrx_funcs[] = { 1, 0, };
 static u8 jz4760_uart3_data_funcs[] = { 0, 1, };
 static u8 jz4760_mmc0_1bit_a_funcs[] = { 1, 1, 0, };
 
@@ -1014,6 +1022,14 @@ static const struct group_desc jz4760_groups[] = {
 	INGENIC_PIN_GROUP("pwm6", jz4760_pwm_pwm6, 0),
 	INGENIC_PIN_GROUP("pwm7", jz4760_pwm_pwm7, 0),
 	INGENIC_PIN_GROUP("otg-vbus", jz4760_otg, 0),
+	INGENIC_PIN_GROUP("i2s-data-tx0", jz4760_i2s_data_tx0, 0),
+	INGENIC_PIN_GROUP("i2s-data-tx1", jz4760_i2s_data_tx1, 0),
+	INGENIC_PIN_GROUP("i2s-data-tx2", jz4760_i2s_data_tx2, 0),
+	INGENIC_PIN_GROUP("i2s-data-tx3", jz4760_i2s_data_tx3, 0),
+	INGENIC_PIN_GROUP("i2s-data-rx", jz4760_i2s_data_rx, 0),
+	INGENIC_PIN_GROUP_FUNCS("i2s-clk-txrx", jz4760_i2s_clk_txrx,
+				jz4760_i2s_clk_txrx_funcs),
+	INGENIC_PIN_GROUP("i2s-sysclk", jz4760_i2s_sysclk, 2),
 };
 
 static const char *jz4760_uart0_groups[] = { "uart0-data", "uart0-hwflow", };
@@ -1074,6 +1090,10 @@ static const char *jz4760_pwm5_groups[] = { "pwm5", };
 static const char *jz4760_pwm6_groups[] = { "pwm6", };
 static const char *jz4760_pwm7_groups[] = { "pwm7", };
 static const char *jz4760_otg_groups[] = { "otg-vbus", };
+static const char *jz4760_i2s_groups[] = {
+	"i2s-data-tx0", "i2s-data-tx1", "i2s-data-tx2", "i2s-data-tx3",
+	"i2s-data-rx", "i2s-clk-txrx", "i2s-sysclk",
+};
 
 static const struct function_desc jz4760_functions[] = {
 	{ "uart0", jz4760_uart0_groups, ARRAY_SIZE(jz4760_uart0_groups), },
@@ -1105,6 +1125,7 @@ static const struct function_desc jz4760_functions[] = {
 	{ "pwm6", jz4760_pwm6_groups, ARRAY_SIZE(jz4760_pwm6_groups), },
 	{ "pwm7", jz4760_pwm7_groups, ARRAY_SIZE(jz4760_pwm7_groups), },
 	{ "otg", jz4760_otg_groups, ARRAY_SIZE(jz4760_otg_groups), },
+	{ "i2s", jz4760_i2s_groups, ARRAY_SIZE(jz4760_i2s_groups), },
 };
 
 static const struct ingenic_chip_info jz4760_chip_info = {
@@ -1249,6 +1270,7 @@ static int jz4770_mac_rmii_pins[] = {
 static int jz4770_mac_mii_pins[] = {
 	0x7b, 0x7a, 0x7d, 0x7c, 0xa7, 0x24, 0xaf,
 };
+static int jz4770_i2s_clk_rx_pins[] = { 0x88, 0x89, };
 
 static const struct group_desc jz4770_groups[] = {
 	INGENIC_PIN_GROUP("uart0-data", jz4770_uart0_data, 0),
@@ -1351,6 +1373,15 @@ static const struct group_desc jz4770_groups[] = {
 	INGENIC_PIN_GROUP("mac-rmii", jz4770_mac_rmii, 0),
 	INGENIC_PIN_GROUP("mac-mii", jz4770_mac_mii, 0),
 	INGENIC_PIN_GROUP("otg-vbus", jz4760_otg, 0),
+	INGENIC_PIN_GROUP("i2s-data-tx0", jz4760_i2s_data_tx0, 0),
+	INGENIC_PIN_GROUP("i2s-data-tx1", jz4760_i2s_data_tx1, 0),
+	INGENIC_PIN_GROUP("i2s-data-tx2", jz4760_i2s_data_tx2, 0),
+	INGENIC_PIN_GROUP("i2s-data-tx3", jz4760_i2s_data_tx3, 0),
+	INGENIC_PIN_GROUP("i2s-data-rx", jz4760_i2s_data_rx, 0),
+	INGENIC_PIN_GROUP_FUNCS("i2s-clk-txrx", jz4760_i2s_clk_txrx,
+				jz4760_i2s_clk_txrx_funcs),
+	INGENIC_PIN_GROUP("i2s-sysclk", jz4760_i2s_sysclk, 2),
+	INGENIC_PIN_GROUP("i2s-clk-rx", jz4770_i2s_clk_rx, 1),
 };
 
 static const char *jz4770_uart0_groups[] = { "uart0-data", "uart0-hwflow", };
@@ -1412,6 +1443,10 @@ static const char *jz4770_pwm5_groups[] = { "pwm5", };
 static const char *jz4770_pwm6_groups[] = { "pwm6", };
 static const char *jz4770_pwm7_groups[] = { "pwm7", };
 static const char *jz4770_mac_groups[] = { "mac-rmii", "mac-mii", };
+static const char *jz4770_i2s_groups[] = {
+	"i2s-data-tx0", "i2s-data-tx1", "i2s-data-tx2", "i2s-data-tx3",
+	"i2s-data-rx", "i2s-clk-txrx", "i2s-sysclk", "i2s-clk-rx",
+};
 
 static const struct function_desc jz4770_functions[] = {
 	{ "uart0", jz4770_uart0_groups, ARRAY_SIZE(jz4770_uart0_groups), },
@@ -1445,6 +1480,7 @@ static const struct function_desc jz4770_functions[] = {
 	{ "pwm7", jz4770_pwm7_groups, ARRAY_SIZE(jz4770_pwm7_groups), },
 	{ "mac", jz4770_mac_groups, ARRAY_SIZE(jz4770_mac_groups), },
 	{ "otg", jz4760_otg_groups, ARRAY_SIZE(jz4760_otg_groups), },
+	{ "i2s", jz4770_i2s_groups, ARRAY_SIZE(jz4770_i2s_groups), },
 };
 
 static const struct ingenic_chip_info jz4770_chip_info = {
@@ -1780,16 +1816,9 @@ static int jz4780_mmc0_8bit_a_pins[] = { 0x04, 0x05, 0x06, 0x07, 0x18, };
 static int jz4780_i2c3_pins[] = { 0x6a, 0x6b, };
 static int jz4780_i2c4_e_pins[] = { 0x8c, 0x8d, };
 static int jz4780_i2c4_f_pins[] = { 0xb9, 0xb8, };
-static int jz4780_i2s_data_tx_pins[] = { 0x87, };
-static int jz4780_i2s_data_rx_pins[] = { 0x86, };
-static int jz4780_i2s_clk_txrx_pins[] = { 0x6c, 0x6d, };
-static int jz4780_i2s_clk_rx_pins[] = { 0x88, 0x89, };
-static int jz4780_i2s_sysclk_pins[] = { 0x85, };
 static int jz4780_dmic_pins[] = { 0x32, 0x33, };
 static int jz4780_hdmi_ddc_pins[] = { 0xb9, 0xb8, };
 
-static u8 jz4780_i2s_clk_txrx_funcs[] = { 1, 0, };
-
 static const struct group_desc jz4780_groups[] = {
 	INGENIC_PIN_GROUP("uart0-data", jz4770_uart0_data, 0),
 	INGENIC_PIN_GROUP("uart0-hwflow", jz4770_uart0_hwflow, 0),
@@ -1878,12 +1907,12 @@ static const struct group_desc jz4780_groups[] = {
 	INGENIC_PIN_GROUP("i2c3-data", jz4780_i2c3, 1),
 	INGENIC_PIN_GROUP("i2c4-data-e", jz4780_i2c4_e, 1),
 	INGENIC_PIN_GROUP("i2c4-data-f", jz4780_i2c4_f, 1),
-	INGENIC_PIN_GROUP("i2s-data-tx", jz4780_i2s_data_tx, 0),
-	INGENIC_PIN_GROUP("i2s-data-rx", jz4780_i2s_data_rx, 0),
-	INGENIC_PIN_GROUP_FUNCS("i2s-clk-txrx", jz4780_i2s_clk_txrx,
-				jz4780_i2s_clk_txrx_funcs),
-	INGENIC_PIN_GROUP("i2s-clk-rx", jz4780_i2s_clk_rx, 1),
-	INGENIC_PIN_GROUP("i2s-sysclk", jz4780_i2s_sysclk, 2),
+	INGENIC_PIN_GROUP("i2s-data-tx", jz4760_i2s_data_tx0, 0),
+	INGENIC_PIN_GROUP("i2s-data-rx", jz4760_i2s_data_rx, 0),
+	INGENIC_PIN_GROUP_FUNCS("i2s-clk-txrx", jz4760_i2s_clk_txrx,
+				jz4760_i2s_clk_txrx_funcs),
+	INGENIC_PIN_GROUP("i2s-clk-rx", jz4770_i2s_clk_rx, 1),
+	INGENIC_PIN_GROUP("i2s-sysclk", jz4760_i2s_sysclk, 2),
 	INGENIC_PIN_GROUP("dmic", jz4780_dmic, 1),
 	INGENIC_PIN_GROUP("hdmi-ddc", jz4780_hdmi_ddc, 0),
 	INGENIC_PIN_GROUP("cim-data", jz4770_cim_8bit, 0),
-- 
2.39.1

