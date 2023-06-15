Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECB16731481
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 11:51:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243536AbjFOJvp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 05:51:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241039AbjFOJvO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 05:51:14 -0400
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A5C110D8;
        Thu, 15 Jun 2023 02:51:13 -0700 (PDT)
Received: from francesco-nb.toradex.int (31-10-206-125.static.upc.ch [31.10.206.125])
        by mail11.truemail.it (Postfix) with ESMTPA id BC6C42147E;
        Thu, 15 Jun 2023 11:51:06 +0200 (CEST)
From:   Francesco Dolcini <francesco@dolcini.it>
To:     Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>
Cc:     Francesco Dolcini <francesco.dolcini@toradex.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 5/5] arm64: dts: ti: add verdin am62 yavia
Date:   Thu, 15 Jun 2023 11:50:58 +0200
Message-Id: <20230615095058.33890-6-francesco@dolcini.it>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230615095058.33890-1-francesco@dolcini.it>
References: <20230615095058.33890-1-francesco@dolcini.it>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Francesco Dolcini <francesco.dolcini@toradex.com>

Add Toradex Verdin AM62 Yavia.

Link: https://www.toradex.com/products/carrier-board/yavia
Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
---
v3: no changes
v2:
 - added link to product pages on dts/dtsi
 - fixed pinctrl definition
---
 arch/arm64/boot/dts/ti/Makefile               |   2 +
 .../boot/dts/ti/k3-am62-verdin-yavia.dtsi     | 207 ++++++++++++++++++
 .../dts/ti/k3-am625-verdin-nonwifi-yavia.dts  |  22 ++
 .../dts/ti/k3-am625-verdin-wifi-yavia.dts     |  22 ++
 4 files changed, 253 insertions(+)
 create mode 100644 arch/arm64/boot/dts/ti/k3-am62-verdin-yavia.dtsi
 create mode 100644 arch/arm64/boot/dts/ti/k3-am625-verdin-nonwifi-yavia.dts
 create mode 100644 arch/arm64/boot/dts/ti/k3-am625-verdin-wifi-yavia.dts

diff --git a/arch/arm64/boot/dts/ti/Makefile b/arch/arm64/boot/dts/ti/Makefile
index f6b38ae10988..3af38aaf6463 100644
--- a/arch/arm64/boot/dts/ti/Makefile
+++ b/arch/arm64/boot/dts/ti/Makefile
@@ -13,8 +13,10 @@ dtb-$(CONFIG_ARCH_K3) += k3-am625-beagleplay.dtb
 dtb-$(CONFIG_ARCH_K3) += k3-am625-sk.dtb
 dtb-$(CONFIG_ARCH_K3) += k3-am625-verdin-nonwifi-dahlia.dtb
 dtb-$(CONFIG_ARCH_K3) += k3-am625-verdin-nonwifi-dev.dtb
+dtb-$(CONFIG_ARCH_K3) += k3-am625-verdin-nonwifi-yavia.dtb
 dtb-$(CONFIG_ARCH_K3) += k3-am625-verdin-wifi-dahlia.dtb
 dtb-$(CONFIG_ARCH_K3) += k3-am625-verdin-wifi-dev.dtb
+dtb-$(CONFIG_ARCH_K3) += k3-am625-verdin-wifi-yavia.dtb
 dtb-$(CONFIG_ARCH_K3) += k3-am62-lp-sk.dtb
 
 # Boards with AM62Ax SoC
diff --git a/arch/arm64/boot/dts/ti/k3-am62-verdin-yavia.dtsi b/arch/arm64/boot/dts/ti/k3-am62-verdin-yavia.dtsi
new file mode 100644
index 000000000000..cb11d6e7f525
--- /dev/null
+++ b/arch/arm64/boot/dts/ti/k3-am62-verdin-yavia.dtsi
@@ -0,0 +1,207 @@
+// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
+/*
+ * Copyright 2023 Toradex
+ *
+ * Common dtsi for Verdin AM62 SoM on Yavia carrier board
+ *
+ * https://www.toradex.com/computer-on-modules/verdin-arm-family/ti-am62
+ * https://www.toradex.com/products/carrier-board/yavia
+ */
+
+#include <dt-bindings/leds/common.h>
+
+/ {
+	leds {
+		compatible = "gpio-leds";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_qspi1_clk_gpio>,
+			    <&pinctrl_qspi1_cs_gpio>,
+			    <&pinctrl_qspi1_io0_gpio>,
+			    <&pinctrl_qspi1_io1_gpio>,
+			    <&pinctrl_qspi1_io2_gpio>,
+			    <&pinctrl_qspi1_io3_gpio>;
+
+		/* SODIMM 52 - LD1_RED */
+		led-0 {
+			color = <LED_COLOR_ID_RED>;
+			function = LED_FUNCTION_DEBUG;
+			function-enumerator = <1>;
+			gpios = <&main_gpio0 0 GPIO_ACTIVE_HIGH>;
+		};
+		/* SODIMM 54 - LD1_GREEN */
+		led-1 {
+			color = <LED_COLOR_ID_GREEN>;
+			function = LED_FUNCTION_DEBUG;
+			function-enumerator = <1>;
+			gpios = <&main_gpio0 11 GPIO_ACTIVE_HIGH>;
+		};
+		/* SODIMM 56 - LD1_BLUE */
+		led-2 {
+			color = <LED_COLOR_ID_BLUE>;
+			function = LED_FUNCTION_DEBUG;
+			function-enumerator = <1>;
+			gpios = <&main_gpio0 3 GPIO_ACTIVE_HIGH>;
+		};
+		/* SODIMM 58 - LD2_RED */
+		led-3 {
+			color = <LED_COLOR_ID_RED>;
+			function = LED_FUNCTION_DEBUG;
+			function-enumerator = <2>;
+			gpios = <&main_gpio0 4 GPIO_ACTIVE_HIGH>;
+		};
+		/* SODIMM 60 - LD2_GREEN */
+		led-4 {
+			color = <LED_COLOR_ID_GREEN>;
+			function = LED_FUNCTION_DEBUG;
+			function-enumerator = <2>;
+			gpios = <&main_gpio0 5 GPIO_ACTIVE_HIGH>;
+		};
+		/* SODIMM 62 - LD2_BLUE */
+		led-5 {
+			color = <LED_COLOR_ID_BLUE>;
+			function = LED_FUNCTION_DEBUG;
+			function-enumerator = <2>;
+			gpios = <&main_gpio0 6 GPIO_ACTIVE_HIGH>;
+		};
+	};
+};
+
+/* Verdin ETHs */
+&cpsw3g {
+	status = "okay";
+};
+
+/* MDIO, shared by Verdin ETH_1 (On-module PHY) and Verdin ETH_2_RGMII */
+&cpsw3g_mdio {
+	status = "okay";
+};
+
+/* Verdin ETH_1 (On-module PHY) */
+&cpsw_port1 {
+	status = "okay";
+};
+
+/* Verdin PWM_1, PWM_2 */
+&epwm0 {
+	status = "okay";
+};
+
+/* Verdin PWM_3_DSI */
+&epwm1 {
+	status = "okay";
+};
+
+&main_gpio0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_ctrl_sleep_moci>,
+		    <&pinctrl_gpio_5>,
+		    <&pinctrl_gpio_6>,
+		    <&pinctrl_gpio_7>,
+		    <&pinctrl_gpio_8>,
+		    <&pinctrl_qspi1_cs2_gpio>;
+};
+
+&main_gpio1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_qspi1_dqs_gpio>;
+};
+
+/* Verdin I2C_1 */
+&main_i2c1 {
+	status = "okay";
+
+	/* Temperature sensor */
+	sensor@4f {
+		compatible = "ti,tmp75c";
+		reg = <0x4f>;
+	};
+
+	/* EEPROM */
+	eeprom@57 {
+		compatible = "st,24c02";
+		reg = <0x57>;
+		pagesize = <16>;
+	};
+};
+
+/* Verdin I2C_2_DSI */
+&main_i2c2 {
+	status = "okay";
+};
+
+/* Verdin I2C_4_CSI */
+&main_i2c3 {
+	status = "okay";
+};
+
+/* Verdin CAN_1 */
+&main_mcan0 {
+	status = "okay";
+};
+
+/* Verdin SPI_1 */
+&main_spi1 {
+	status = "okay";
+};
+
+/* Verdin UART_3 */
+&main_uart0 {
+	status = "okay";
+};
+
+/* Verdin UART_1 */
+&main_uart1 {
+	status = "okay";
+};
+
+&mcu_gpio0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_gpio_1>,
+		    <&pinctrl_gpio_2>,
+		    <&pinctrl_gpio_3>,
+		    <&pinctrl_gpio_4>;
+};
+
+/* Verdin I2C_3_HDMI */
+&mcu_i2c0 {
+	status = "okay";
+};
+
+/* Verdin UART_4 */
+&mcu_uart0 {
+	status = "okay";
+};
+
+/* Verdin SD_1 */
+&sdhci1 {
+	status = "okay";
+};
+
+/* Verdin USB_1 */
+&usbss0 {
+	status = "okay";
+};
+
+&usb0 {
+	status = "okay";
+};
+
+/* Verdin USB_2 */
+&usbss1 {
+	status = "okay";
+};
+
+&usb1 {
+	status = "okay";
+};
+
+/* Verdin CTRL_WAKE1_MICO# */
+&verdin_gpio_keys {
+	status = "okay";
+};
+
+/* Verdin UART_2 */
+&wkup_uart0 {
+	/* FIXME: WKUP UART0 is used by DM firmware */
+	status = "reserved";
+};
diff --git a/arch/arm64/boot/dts/ti/k3-am625-verdin-nonwifi-yavia.dts b/arch/arm64/boot/dts/ti/k3-am625-verdin-nonwifi-yavia.dts
new file mode 100644
index 000000000000..e80332e1f030
--- /dev/null
+++ b/arch/arm64/boot/dts/ti/k3-am625-verdin-nonwifi-yavia.dts
@@ -0,0 +1,22 @@
+// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
+/*
+ * Copyright 2023 Toradex
+ *
+ * https://www.toradex.com/computer-on-modules/verdin-arm-family/ti-am62
+ * https://www.toradex.com/products/carrier-board/yavia
+ */
+
+/dts-v1/;
+
+#include "k3-am625.dtsi"
+#include "k3-am62-verdin.dtsi"
+#include "k3-am62-verdin-nonwifi.dtsi"
+#include "k3-am62-verdin-yavia.dtsi"
+
+/ {
+	model = "Toradex Verdin AM62 on Yavia Board";
+	compatible = "toradex,verdin-am62-nonwifi-yavia",
+		     "toradex,verdin-am62-nonwifi",
+		     "toradex,verdin-am62",
+		     "ti,am625";
+};
diff --git a/arch/arm64/boot/dts/ti/k3-am625-verdin-wifi-yavia.dts b/arch/arm64/boot/dts/ti/k3-am625-verdin-wifi-yavia.dts
new file mode 100644
index 000000000000..8a2506068ac4
--- /dev/null
+++ b/arch/arm64/boot/dts/ti/k3-am625-verdin-wifi-yavia.dts
@@ -0,0 +1,22 @@
+// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
+/*
+ * Copyright 2023 Toradex
+ *
+ * https://www.toradex.com/computer-on-modules/verdin-arm-family/ti-am62
+ * https://www.toradex.com/products/carrier-board/yavia
+ */
+
+/dts-v1/;
+
+#include "k3-am625.dtsi"
+#include "k3-am62-verdin.dtsi"
+#include "k3-am62-verdin-wifi.dtsi"
+#include "k3-am62-verdin-yavia.dtsi"
+
+/ {
+	model = "Toradex Verdin AM62 WB on Yavia Board";
+	compatible = "toradex,verdin-am62-wifi-yavia",
+		     "toradex,verdin-am62-wifi",
+		     "toradex,verdin-am62",
+		     "ti,am625";
+};
-- 
2.25.1

