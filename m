Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87756726A9A
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 22:17:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232590AbjFGURR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 16:17:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231611AbjFGUQ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 16:16:59 -0400
Received: from mx.sberdevices.ru (mx.sberdevices.ru [45.89.227.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D9871BD3;
        Wed,  7 Jun 2023 13:16:58 -0700 (PDT)
Received: from s-lin-edge02.sberdevices.ru (localhost [127.0.0.1])
        by mx.sberdevices.ru (Postfix) with ESMTP id 3BC105FD73;
        Wed,  7 Jun 2023 23:16:56 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1686169016;
        bh=ZYzm10ARzicI/VkalxH9IaqGb8tcNyA0d5VD1WYq+Ig=;
        h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
        b=tFuV+yAWUo7Q0sYLMKf2M4BuNmvcVlg643acSfnG19o9ztjGz5c14v0md6UFe1hum
         L5M1cTrJFMmA02ElgVAKzuP1Em/6iGgBbpzRzlWwDeO5UGtddWkkrcQd1DTCLMJpCz
         zNpERrZdP4tvAosYgpSoCL2LI7p4m3pxq7hfZ5s7YTtKxlRXK5cnTz/6LVLQJ4yyBg
         4TamtmB64oysLQ02Qu9uFe9+erDwZCkLMYD//roEmxlIBPUFRW1AOZUA2yqSAengyx
         vP60/8mI6Haow3vDD9UT5F1RtRXPYNsSxVafXtXjVKGKJfbYfBhvXDFJ7A6SAJxChj
         CpF4yCInn2Qrg==
Received: from S-MS-EXCH01.sberdevices.ru (S-MS-EXCH01.sberdevices.ru [172.16.1.4])
        by mx.sberdevices.ru (Postfix) with ESMTP;
        Wed,  7 Jun 2023 23:16:56 +0300 (MSK)
From:   Dmitry Rokosov <ddrokosov@sberdevices.ru>
To:     <neil.armstrong@linaro.org>, <jbrunet@baylibre.com>,
        <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <khilman@baylibre.com>, <martin.blumenstingl@googlemail.com>,
        <conor+dt@kernel.org>
CC:     <kernel@sberdevices.ru>, <sdfw_system_team@sberdevices.ru>,
        <rockosov@gmail.com>, <linux-amlogic@lists.infradead.org>,
        <linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Jan Dakinevich <yvdakinevich@sberdevices.ru>,
        Dmitry Rokosov <ddrokosov@sberdevices.ru>
Subject: [PATCH v1 6/6] arm64: dts: meson: a1: add eMMC controller and its pins
Date:   Wed, 7 Jun 2023 23:16:41 +0300
Message-ID: <20230607201641.20982-7-ddrokosov@sberdevices.ru>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <20230607201641.20982-1-ddrokosov@sberdevices.ru>
References: <20230607201641.20982-1-ddrokosov@sberdevices.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.16.1.6]
X-ClientProxiedBy: S-MS-EXCH01.sberdevices.ru (172.16.1.4) To
 S-MS-EXCH01.sberdevices.ru (172.16.1.4)
X-KSMG-Rule-ID: 4
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Status: not scanned, disabled by settings
X-KSMG-AntiSpam-Interceptor-Info: not scanned
X-KSMG-AntiPhishing: not scanned, disabled by settings
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2023/06/07 16:55:00 #21454472
X-KSMG-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jan Dakinevich <yvdakinevich@sberdevices.ru>

The definition is inspired by a similar one for AXG SoC family.
'sdio_pins' and 'sdio_clk_gate_pins' pinctrls are supposed to be used as
"default" and "clk-gate" in board-specific device trees.

'meson-gx' driver during initialization sets clock to safe low-frequency
value (400kHz). However, both source clocks ("clkin0" and "clkin1") are
high-frequency by default, and using of eMMC's internal divider is not
enough to achieve so low values. To provide low-frequency source,
reparent "sd_emmc_sel2" clock using 'assigned-clocks' property.

Signed-off-by: Jan Dakinevich <yvdakinevich@sberdevices.ru>
Signed-off-by: Dmitry Rokosov <ddrokosov@sberdevices.ru>
---
 arch/arm64/boot/dts/amlogic/meson-a1.dtsi | 43 +++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-a1.dtsi b/arch/arm64/boot/dts/amlogic/meson-a1.dtsi
index 3eb6aa9c00e0..a25170c61462 100644
--- a/arch/arm64/boot/dts/amlogic/meson-a1.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-a1.dtsi
@@ -134,6 +134,32 @@ mux {
 						bias-pull-down;
 					};
 				};
+
+				sdio_pins: sdio {
+					mux-0 {
+						groups = "sdcard_d0_x",
+							 "sdcard_d1_x",
+							 "sdcard_d2_x",
+							 "sdcard_d3_x",
+							 "sdcard_cmd_x";
+						function = "sdcard";
+						bias-pull-up;
+					};
+
+					mux-1 {
+						groups = "sdcard_clk_x";
+						function = "sdcard";
+						bias-disable;
+					};
+				};
+
+				sdio_clk_gate_pins: sdio_clk_gate {
+					mux {
+						groups = "sdcard_clk_x";
+						function = "sdcard";
+						bias-pull-down;
+					};
+				};
 			};
 
 			uart_AO: serial@1c00 {
@@ -200,6 +226,23 @@ usb2_phy1: phy@4000 {
 				#phy-cells = <0>;
 				power-domains = <&pwrc PWRC_USB_ID>;
 			};
+
+			sd_emmc: sd@10000 {
+				compatible = "amlogic,meson-axg-mmc";
+				reg = <0x0 0x10000 0x0 0x800>;
+				interrupts = <GIC_SPI 58 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&clkc_periphs CLKID_SD_EMMC_A>,
+					 <&clkc_periphs CLKID_SD_EMMC>,
+					 <&clkc_pll CLKID_FCLK_DIV2>;
+				clock-names = "core",
+					      "clkin0",
+					      "clkin1";
+				assigned-clocks = <&clkc_periphs CLKID_SD_EMMC_SEL2>;
+				assigned-clock-parents = <&xtal>;
+				resets = <&reset RESET_SD_EMMC_A>;
+				power-domains = <&pwrc PWRC_SD_EMMC_ID>;
+				status = "disabled";
+			};
 		};
 
 		gic: interrupt-controller@ff901000 {
-- 
2.36.0

