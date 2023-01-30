Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E805C681A09
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 20:12:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238252AbjA3TMS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 14:12:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237950AbjA3TML (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 14:12:11 -0500
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 05CB930D9;
        Mon, 30 Jan 2023 11:11:59 -0800 (PST)
X-IronPort-AV: E=Sophos;i="5.97,258,1669042800"; 
   d="scan'208";a="147890848"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 31 Jan 2023 04:11:59 +0900
Received: from mulinux.home (unknown [10.226.92.190])
        by relmlir5.idc.renesas.com (Postfix) with ESMTP id D70FF4003FDC;
        Tue, 31 Jan 2023 04:11:55 +0900 (JST)
From:   Fabrizio Castro <fabrizio.castro.jz@renesas.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
        Magnus Damm <magnus.damm@gmail.com>,
        linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Jacopo Mondi <jacopo@jmondi.org>
Subject: [PATCH v2] arm64: dts: renesas: v2mevk2: Add uSD card and eMMC support
Date:   Mon, 30 Jan 2023 19:11:52 +0000
Message-Id: <20230130191152.182826-1-fabrizio.castro.jz@renesas.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.5 required=5.0 tests=AC_FROM_MANY_DOTS,BAYES_00,
        LOTS_OF_MONEY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The RZ/V2M EVK comes with a slot for a uSD card, and an eMMC.
Add support for the both of them.

Please note that the pinctrl driver for RZ/V2M doesn't support
interrupts yet, therefore the card detect pin has been connected
to the SDHI IP directly in this patch.
We'll connect the card detect pin to its corresponding GPIO when
we'll have driver support for interrupts in the RZ/V2M pinctrl
driver.

Signed-off-by: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v1->v2: Add properties no-sd; and no-sdio; to emmc node
	Moved emmc_pins to respect sort order
	Added Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

 .../boot/dts/renesas/r9a09g011-v2mevk2.dts    | 124 ++++++++++++++++++
 1 file changed, 124 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r9a09g011-v2mevk2.dts b/arch/arm64/boot/dts/renesas/r9a09g011-v2mevk2.dts
index d6737395df67..36a2afeb6c74 100644
--- a/arch/arm64/boot/dts/renesas/r9a09g011-v2mevk2.dts
+++ b/arch/arm64/boot/dts/renesas/r9a09g011-v2mevk2.dts
@@ -7,6 +7,7 @@
 
 /dts-v1/;
 #include "r9a09g011.dtsi"
+#include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/pinctrl/rzv2m-pinctrl.h>
 
 / {
@@ -35,6 +36,36 @@ memory@180000000 {
 		device_type = "memory";
 		reg = <0x1 0x80000000 0x0 0x80000000>;
 	};
+
+	reg_1v8: regulator-1v8 {
+		compatible = "regulator-fixed";
+		regulator-name = "fixed-1.8V";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+		regulator-boot-on;
+		regulator-always-on;
+	};
+
+	reg_3v3: regulator-3v3 {
+		compatible = "regulator-fixed";
+		regulator-name = "fixed-3.3V";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-boot-on;
+		regulator-always-on;
+	};
+
+	vccq_sdhi0: regulator-vccq-sdhi0 {
+		compatible = "regulator-gpio";
+
+		regulator-name = "SDHI0 VccQ";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <3300000>;
+
+		gpios = <&pwc 0 GPIO_ACTIVE_HIGH>;
+		gpios-states = <1>;
+		states = <3300000 0>, <1800000 1>;
+	};
 };
 
 &avb {
@@ -50,6 +81,24 @@ phy0: ethernet-phy@0 {
 	};
 };
 
+&emmc {
+	pinctrl-0 = <&emmc_pins>;
+	pinctrl-1 = <&emmc_pins>;
+	pinctrl-names = "default", "state_uhs";
+
+	vmmc-supply = <&reg_3v3>;
+	vqmmc-supply = <&reg_1v8>;
+	bus-width = <8>;
+	mmc-hs200-1_8v;
+	no-sd;
+	no-sdio;
+	non-removable;
+	fixed-emmc-driver-type = <1>;
+	max-frequency = <200000000>;
+	status = "okay";
+};
+
+
 &extal_clk {
 	clock-frequency = <48000000>;
 };
@@ -69,6 +118,26 @@ &i2c2 {
 };
 
 &pinctrl {
+	emmc_pins: emmc {
+		emmc_pins_data {
+			pinmux = <RZV2M_PORT_PINMUX(0, 0, 2)>, /* MMDAT0 */
+				 <RZV2M_PORT_PINMUX(0, 1, 2)>, /* MMDAT1 */
+				 <RZV2M_PORT_PINMUX(0, 2, 2)>, /* MMDAT2 */
+				 <RZV2M_PORT_PINMUX(0, 3, 2)>, /* MMDAT3 */
+				 <RZV2M_PORT_PINMUX(0, 4, 2)>, /* MMDAT4 */
+				 <RZV2M_PORT_PINMUX(0, 5, 2)>, /* MMDAT5 */
+				 <RZV2M_PORT_PINMUX(0, 6, 2)>, /* MMDAT6 */
+				 <RZV2M_PORT_PINMUX(0, 7, 2)>; /* MMDAT7 */
+			power-source = <1800>;
+		};
+
+		emmc_pins_ctrl {
+			pinmux = <RZV2M_PORT_PINMUX(0, 10, 2)>, /* MMCMD */
+				 <RZV2M_PORT_PINMUX(0, 11, 2)>; /* MMCLK */
+			power-source = <1800>;
+		};
+	};
+
 	i2c0_pins: i2c0 {
 		pinmux = <RZV2M_PORT_PINMUX(5, 0, 2)>, /* SDA */
 			 <RZV2M_PORT_PINMUX(5, 1, 2)>; /* SCL */
@@ -78,6 +147,48 @@ i2c2_pins: i2c2 {
 		pinmux = <RZV2M_PORT_PINMUX(3, 8, 2)>, /* SDA */
 			 <RZV2M_PORT_PINMUX(3, 9, 2)>; /* SCL */
 	};
+
+	sdhi0_pins: sd0 {
+		sd0_data {
+			pinmux = <RZV2M_PORT_PINMUX(8, 2, 1)>, /* SD0DAT0 */
+				 <RZV2M_PORT_PINMUX(8, 3, 1)>, /* SD0DAT1 */
+				 <RZV2M_PORT_PINMUX(8, 4, 1)>, /* SD0DAT2 */
+				 <RZV2M_PORT_PINMUX(8, 5, 1)>; /* SD0DAT3 */
+			power-source = <3300>;
+		};
+
+		sd0_ctrl {
+			pinmux = <RZV2M_PORT_PINMUX(8, 0, 1)>, /* SD0CMD */
+				 <RZV2M_PORT_PINMUX(8, 1, 1)>; /* SD0CLK */
+			power-source = <3300>;
+		};
+
+		sd0_cd {
+			pinmux = <RZV2M_PORT_PINMUX(8, 7, 1)>; /* SD0CD */
+			power-source = <3300>;
+		};
+	};
+
+	sdhi0_pins_uhs: sd0_uhs {
+		sd0_data_uhs {
+			pinmux = <RZV2M_PORT_PINMUX(8, 2, 1)>, /* SD0DAT0 */
+				 <RZV2M_PORT_PINMUX(8, 3, 1)>, /* SD0DAT1 */
+				 <RZV2M_PORT_PINMUX(8, 4, 1)>, /* SD0DAT2 */
+				 <RZV2M_PORT_PINMUX(8, 5, 1)>; /* SD0DAT3 */
+			power-source = <1800>;
+		};
+
+		sd0_ctrl_uhs {
+			pinmux = <RZV2M_PORT_PINMUX(8, 0, 1)>, /* SD0CMD */
+				 <RZV2M_PORT_PINMUX(8, 1, 1)>; /* SD0CLK */
+			power-source = <1800>;
+		};
+
+		sd0_cd_uhs {
+			pinmux = <RZV2M_PORT_PINMUX(8, 7, 1)>; /* SD0CD */
+			power-source = <1800>;
+		};
+	};
 };
 
 &pwc {
@@ -85,6 +196,19 @@ &pwc {
 	status = "okay";
 };
 
+&sdhi0 {
+	pinctrl-0 = <&sdhi0_pins>;
+	pinctrl-1 = <&sdhi0_pins_uhs>;
+	pinctrl-names = "default", "state_uhs";
+
+	vmmc-supply = <&reg_3v3>;
+	vqmmc-supply = <&vccq_sdhi0>;
+	bus-width = <4>;
+	sd-uhs-sdr50;
+	sd-uhs-sdr104;
+	status = "okay";
+};
+
 &uart0 {
 	status = "okay";
 };
-- 
2.34.1

