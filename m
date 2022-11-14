Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CAAE628523
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 17:26:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237456AbiKNQ0B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 11:26:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237407AbiKNQZ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 11:25:58 -0500
Received: from relay03.th.seeweb.it (relay03.th.seeweb.it [5.144.164.164])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 235F73A6
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 08:25:56 -0800 (PST)
Received: from TimeMachine.lan (bband-dyn193.178-41-216.t-com.sk [178.41.216.193])
        by m-r1.th.seeweb.it (Postfix) with ESMTPA id 6DE2F1F539;
        Mon, 14 Nov 2022 17:25:54 +0100 (CET)
From:   Martin Botka <martin.botka@somainline.org>
To:     martin.botka1@gmail.com
Cc:     ~postmarketos/upstreaming@lists.sr.ht,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Jami Kettunen <jamipkettunen@somainline.org>,
        Paul Bouchara <paul.bouchara@somainline.org>,
        Yenda <jtrmal@gmail.com>,
        Martin Botka <martin.botka@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: Add basic support for BIQU CB1
Date:   Mon, 14 Nov 2022 17:25:46 +0100
Message-Id: <20221114162547.1802689-1-martin.botka@somainline.org>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CB1 is Compute Module style board that plugs into Rpi board style adapter or
Manta 3D printer boards (M4P/M8P).

The board has:
	H616 SoC
	1GB of RAM
	AXP313A PMIC

And the actual boards that CB1 plugs in are just extension to it with ports and
thus are not split in DT.

Boards have:
	4x (3x for Manta boards) USB and 1 USB OTG.
	SDcard slot for loading images.
	Ethernet port wired to the internal PHY.
	2x HDMI 2.0.
	Power and Status LEDs.

Currently working:
	Booting
	USB
	UART

Signed-off-by: Martin Botka <martin.botka@somainline.org>
---
 arch/arm64/boot/dts/allwinner/Makefile        |   1 +
 .../dts/allwinner/sun50i-h616-biqu-cb1.dts    | 191 ++++++++++++++++++
 2 files changed, 192 insertions(+)
 create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-h616-biqu-cb1.dts

diff --git a/arch/arm64/boot/dts/allwinner/Makefile b/arch/arm64/boot/dts/allwinner/Makefile
index 6a96494a2e0a..223f1be73541 100644
--- a/arch/arm64/boot/dts/allwinner/Makefile
+++ b/arch/arm64/boot/dts/allwinner/Makefile
@@ -38,5 +38,6 @@ dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h6-pine-h64.dtb
 dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h6-pine-h64-model-b.dtb
 dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h6-tanix-tx6.dtb
 dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h6-tanix-tx6-mini.dtb
+dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h616-biqu-cb1.dtb
 dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h616-orangepi-zero2.dtb
 dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h616-x96-mate.dtb
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h616-biqu-cb1.dts b/arch/arm64/boot/dts/allwinner/sun50i-h616-biqu-cb1.dts
new file mode 100644
index 000000000000..2225a965dddc
--- /dev/null
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h616-biqu-cb1.dts
@@ -0,0 +1,191 @@
+// SPDX-License-Identifier: (GPL-2.0+ or MIT)
+/*
+ * Copyright (C) 2022 Arm Ltd.
+ */
+
+/dts-v1/;
+
+#include "sun50i-h616.dtsi"
+
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/interrupt-controller/arm-gic.h>
+#include <dt-bindings/leds/common.h>
+
+/ {
+	model = "BIQU CB1";
+	compatible = "allwinner,sun50i-h616";
+
+	aliases {
+		serial0 = &uart0;
+	};
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+
+	leds {
+		compatible = "gpio-leds";
+
+		led-0 {
+			function = LED_FUNCTION_POWER;
+			color = <LED_COLOR_ID_RED>;
+			gpios = <&pio 2 12 GPIO_ACTIVE_HIGH>; /* PC12 */
+			default-state = "on";
+		};
+
+		led-1 {
+			function = LED_FUNCTION_STATUS;
+			color = <LED_COLOR_ID_GREEN>;
+			gpios = <&pio 2 13 GPIO_ACTIVE_HIGH>; /* PC13 */
+		};
+	};
+
+	reg_vcc5v: vcc5v {
+		/* board wide 5V supply directly from the USB-C socket */
+		compatible = "regulator-fixed";
+		regulator-name = "vcc-5v";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		regulator-always-on;
+	};
+
+	reg_usb1_vbus: regulator-usb1-vbus {
+		compatible = "regulator-fixed";
+		regulator-name = "usb1-vbus";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		vin-supply = <&reg_vcc5v>;
+		enable-active-high;
+		gpio = <&pio 2 16 GPIO_ACTIVE_HIGH>; /* PC16 */
+	};
+};
+
+&ehci0 {
+	status = "okay";
+};
+
+&ehci1 {
+	status = "okay";
+};
+
+&ehci2 {
+	status = "okay";
+};
+
+&ehci3 {
+	status = "okay";
+};
+
+&mmc0 {
+	vmmc-supply = <&reg_dldo1>;
+	cd-gpios = <&pio 5 6 GPIO_ACTIVE_LOW>;	/* PF6 */
+	no-1-8-v;
+	bus-width = <4>;
+	status = "disabled";
+};
+
+&ohci0 {
+	status = "okay";
+};
+
+&ohci1 {
+	status = "okay";
+};
+
+&ohci2 {
+	status = "okay";
+};
+
+&ohci3 {
+	status = "okay";
+};
+
+&r_i2c {
+	status = "okay";
+
+	axp1530: pmic@36 {
+		compatible = "x-powers,axp1530";
+		status = "okay";
+		reg = <0x36>;
+		wakeup-source;
+
+		standby_param: standby_param {
+			vcc-dram = <0x4>;
+		};
+
+		regulators{
+			reg_dcdc1: dcdc1 {
+				regulator-name = "axp1530-dcdc1";
+				regulator-min-microvolt = <500000>;
+				regulator-max-microvolt = <3400000>;
+				regulator-step-delay-us = <25>;
+				regulator-final-delay-us = <50>;
+				regulator-always-on;
+			};
+
+			reg_dcdc2: dcdc2 {
+				regulator-name = "axp1530-dcdc2";
+				regulator-min-microvolt = <500000>;
+				regulator-max-microvolt = <1540000>;
+				regulator-step-delay-us = <25>;
+				regulator-final-delay-us = <50>;
+				regulator-ramp-delay = <200>;
+				regulator-always-on;
+			};
+
+			reg_dcdc3: dcdc3 {
+				regulator-name = "axp1530-dcdc3";
+				regulator-min-microvolt = <500000>;
+				regulator-max-microvolt = <1840000>;
+				regulator-step-delay-us = <25>;
+				regulator-final-delay-us = <50>;
+				regulator-always-on;
+			};
+
+			reg_aldo1: ldo1 {
+				regulator-name = "axp1530-aldo1";
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+				regulator-step-delay-us = <25>;
+				regulator-final-delay-us = <50>;
+				regulator-always-on;
+			};
+
+			reg_dldo1: ldo2 {
+				regulator-name = "axp1530-dldo1";
+				regulator-min-microvolt = <3300000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-step-delay-us = <25>;
+				regulator-final-delay-us = <50>;
+				regulator-always-on;
+			};
+		};
+	};
+};
+
+&uart0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart0_ph_pins>;
+	status = "okay";
+};
+
+&usbotg {
+	/*
+	 * PHY0 pins are connected to a USB-C socket, but a role switch
+	 * is not implemented: both CC pins are pulled to GND.
+	 * The VBUS pins power the device, so a fixed peripheral mode
+	 * is the best choice.
+	 * The board can be powered via GPIOs, in this case port0 *can*
+	 * act as a host (with a cable/adapter ignoring CC), as VBUS is
+	 * then provided by the GPIOs. Any user of this setup would
+	 * need to adjust the DT accordingly: dr_mode set to "host",
+	 * enabling OHCI0 and EHCI0.
+	 */
+	dr_mode = "peripheral";
+	status = "okay";
+};
+
+&usbphy {
+	usb1_vbus-supply = <&reg_usb1_vbus>;
+	status = "okay";
+};
-- 
2.38.1

