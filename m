Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC1C65F8618
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Oct 2022 18:48:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229919AbiJHQsP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Oct 2022 12:48:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229683AbiJHQsN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Oct 2022 12:48:13 -0400
Received: from mxout1.routing.net (mxout1.routing.net [IPv6:2a03:2900:1:a::a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0828F33377
        for <linux-kernel@vger.kernel.org>; Sat,  8 Oct 2022 09:48:11 -0700 (PDT)
Received: from mxbox2.masterlogin.de (unknown [192.168.10.89])
        by mxout1.routing.net (Postfix) with ESMTP id 03C8940111;
        Sat,  8 Oct 2022 16:48:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailerdienst.de;
        s=20200217; t=1665247690;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=DxNxzdYg2Gd1UoiiK/RSd/MZ7RJMS/NxPqm3JHVevEI=;
        b=v05q0/shnTZpdt0ltREShkAQJu6etlGixgI+/hhmxQIWaT/YqZ1mSi9NJEIMdFzf6gXmGa
        PTHY4Q1bBLvau9HM1pvOswnfX0ZljX4ShI35/jIgzr/6sY/zKi1qTywF+xQgOGfxhXr/U+
        oAQZbmiepXphvtQ3pEiZNfaCgTwKdbo=
Received: from frank-G5.. (fttx-pool-217.61.149.60.bambit.de [217.61.149.60])
        by mxbox2.masterlogin.de (Postfix) with ESMTPSA id 3B9F310042C;
        Sat,  8 Oct 2022 16:48:09 +0000 (UTC)
From:   Frank Wunderlich <linux@fw-web.de>
To:     linux-mediatek@lists.infradead.org
Cc:     Sam Shih <sam.shih@mediatek.com>, Sean Wang <sean.wang@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Frank Wunderlich <frank-w@public-files.de>
Subject: [PATCH] pinctrl: mediatek: allow configuring uart rx/tx and rts/cts separately
Date:   Sat,  8 Oct 2022 18:48:06 +0200
Message-Id: <20221008164807.113590-1-linux@fw-web.de>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mail-ID: 9c542c94-e206-4f0b-99de-2c03d23c5142
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sam Shih <sam.shih@mediatek.com>

Some mt7986 boards use uart rts/cts pins as gpio,
This patch allows to change rts/cts to gpio mode, but keep
rx/tx as UART function.

Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
Signed-off-by: Sam Shih <sam.shih@mediatek.com>
---
 drivers/pinctrl/mediatek/pinctrl-mt7986.c | 32 ++++++++++++++++++-----
 1 file changed, 25 insertions(+), 7 deletions(-)

diff --git a/drivers/pinctrl/mediatek/pinctrl-mt7986.c b/drivers/pinctrl/mediatek/pinctrl-mt7986.c
index f26869f1a367..95f32e62e02f 100644
--- a/drivers/pinctrl/mediatek/pinctrl-mt7986.c
+++ b/drivers/pinctrl/mediatek/pinctrl-mt7986.c
@@ -675,11 +675,17 @@ static int mt7986_uart1_1_funcs[] = { 4, 4, 4, 4, };
 static int mt7986_spi1_2_pins[] = { 29, 30, 31, 32, };
 static int mt7986_spi1_2_funcs[] = { 1, 1, 1, 1, };
 
-static int mt7986_uart1_2_pins[] = { 29, 30, 31, 32, };
-static int mt7986_uart1_2_funcs[] = { 3, 3, 3, 3, };
+static int mt7986_uart1_2_rx_tx_pins[] = { 29, 30, };
+static int mt7986_uart1_2_rx_tx_funcs[] = { 3, 3, };
 
-static int mt7986_uart2_0_pins[] = { 29, 30, 31, 32, };
-static int mt7986_uart2_0_funcs[] = { 4, 4, 4, 4, };
+static int mt7986_uart1_2_cts_rts_pins[] = { 31, 32, };
+static int mt7986_uart1_2_cts_rts_funcs[] = { 3, 3, };
+
+static int mt7986_uart2_0_rx_tx_pins[] = { 29, 30, };
+static int mt7986_uart2_0_rx_tx_funcs[] = { 4, 4, };
+
+static int mt7986_uart2_0_cts_rts_pins[] = { 31, 32, };
+static int mt7986_uart2_0_cts_rts_funcs[] = { 4, 4, };
 
 static int mt7986_spi0_pins[] = { 33, 34, 35, 36, };
 static int mt7986_spi0_funcs[] = { 1, 1, 1, 1, };
@@ -708,6 +714,12 @@ static int mt7986_pcie_reset_funcs[] = { 1, };
 static int mt7986_uart1_pins[] = { 42, 43, 44, 45, };
 static int mt7986_uart1_funcs[] = { 1, 1, 1, 1, };
 
+static int mt7986_uart1_rx_tx_pins[] = { 42, 43, };
+static int mt7986_uart1_rx_tx_funcs[] = { 1, 1, };
+
+static int mt7986_uart1_cts_rts_pins[] = { 44, 45, };
+static int mt7986_uart1_cts_rts_funcs[] = { 1, 1, };
+
 static int mt7986_uart2_pins[] = { 46, 47, 48, 49, };
 static int mt7986_uart2_funcs[] = { 1, 1, 1, 1, };
 
@@ -749,6 +761,8 @@ static const struct group_desc mt7986_groups[] = {
 	PINCTRL_PIN_GROUP("wifi_led", mt7986_wifi_led),
 	PINCTRL_PIN_GROUP("i2c", mt7986_i2c),
 	PINCTRL_PIN_GROUP("uart1_0", mt7986_uart1_0),
+	PINCTRL_PIN_GROUP("uart1_rx_tx", mt7986_uart1_rx_tx),
+	PINCTRL_PIN_GROUP("uart1_cts_rts", mt7986_uart1_cts_rts),
 	PINCTRL_PIN_GROUP("pcie_clk", mt7986_pcie_clk),
 	PINCTRL_PIN_GROUP("pcie_wake", mt7986_pcie_wake),
 	PINCTRL_PIN_GROUP("spi1_0", mt7986_spi1_0),
@@ -760,8 +774,10 @@ static const struct group_desc mt7986_groups[] = {
 	PINCTRL_PIN_GROUP("spi1_1", mt7986_spi1_1),
 	PINCTRL_PIN_GROUP("uart1_1", mt7986_uart1_1),
 	PINCTRL_PIN_GROUP("spi1_2", mt7986_spi1_2),
-	PINCTRL_PIN_GROUP("uart1_2", mt7986_uart1_2),
-	PINCTRL_PIN_GROUP("uart2_0", mt7986_uart2_0),
+	PINCTRL_PIN_GROUP("uart1_2_rx_tx", mt7986_uart1_2_rx_tx),
+	PINCTRL_PIN_GROUP("uart1_2_cts_rts", mt7986_uart1_2_cts_rts),
+	PINCTRL_PIN_GROUP("uart2_0_rx_tx", mt7986_uart2_0_rx_tx),
+	PINCTRL_PIN_GROUP("uart2_0_cts_rts", mt7986_uart2_0_cts_rts),
 	PINCTRL_PIN_GROUP("spi0", mt7986_spi0),
 	PINCTRL_PIN_GROUP("spi0_wp_hold", mt7986_spi0_wp_hold),
 	PINCTRL_PIN_GROUP("uart2_1", mt7986_uart2_1),
@@ -800,7 +816,9 @@ static const char *mt7986_pwm_groups[] = { "pwm0", "pwm1_0", "pwm1_1", };
 static const char *mt7986_spi_groups[] = {
 	"spi0", "spi0_wp_hold", "spi1_0", "spi1_1", "spi1_2", "spi1_3", };
 static const char *mt7986_uart_groups[] = {
-	"uart1_0", "uart1_1", "uart1_2", "uart1_3_rx_tx", "uart1_3_cts_rts",
+	"uart1_0", "uart1_1", "uart1_rx_tx", "uart1_cts_rts",
+	"uart1_2_rx_tx", "uart1_2_cts_rts",
+	"uart1_3_rx_tx", "uart1_3_cts_rts", "uart2_0_rx_tx", "uart2_0_cts_rts",
 	"uart2_0", "uart2_1", "uart0", "uart1", "uart2",
 };
 static const char *mt7986_wdt_groups[] = { "watchdog", };
-- 
2.34.1

