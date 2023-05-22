Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8ECC70B8CB
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 11:23:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232831AbjEVJWm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 05:22:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232822AbjEVJWc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 05:22:32 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EC69AA;
        Mon, 22 May 2023 02:22:23 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 34M9MEJj037039;
        Mon, 22 May 2023 04:22:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1684747334;
        bh=wDgPzOwuJ7VmNIIW05F9YcnAadh7iac1nWFlVt8J6so=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=xito0OO/xGYxwlG/EhdaC45DDc6EDR1dZoD46+p1eFMS8unMQ2SZqAcSZj9Z8Asfh
         wd7zJ3KcWX2x4YMBnlYjdV4MDh8BB8RpJLscO9plCtS+W05/Gp2thWuMrkXgO6PE3w
         ajixaKHfDhkfCX7okhk6/CCnXrRen3ULYzKeqneE=
Received: from DFLE108.ent.ti.com (dfle108.ent.ti.com [10.64.6.29])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 34M9MEY3046869
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 22 May 2023 04:22:14 -0500
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 22
 May 2023 04:22:13 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 22 May 2023 04:22:13 -0500
Received: from uda0492258.dhcp.ti.com (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 34M9M2e6127198;
        Mon, 22 May 2023 04:22:10 -0500
From:   Siddharth Vadapalli <s-vadapalli@ti.com>
To:     <nm@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski@linaro.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <afd@ti.com>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <srk@ti.com>,
        <s-vadapalli@ti.com>
Subject: [PATCH 2/3] arm64: dts: ti: k3-j784s4: Add overlay to enable QSGMII mode with CPSW9G
Date:   Mon, 22 May 2023 14:52:00 +0530
Message-ID: <20230522092201.127598-3-s-vadapalli@ti.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230522092201.127598-1-s-vadapalli@ti.com>
References: <20230522092201.127598-1-s-vadapalli@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The J7 Quad Port Add-On Ethernet Card for J784S4 EVM supports QSGMII
mode. Use the overlay to configure CPSW9G ports in QSGMII mode with the
Add-On Ethernet Card connected to the ENET Expansion 1 slot on the EVM.

Add support to reset the PHY from kernel by using gpio-hog and gpio-reset.

Add aliases for CPSW9G ports to enable kernel to fetch MAC Addresses
directly from U-Boot.

Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
---
 arch/arm64/boot/dts/ti/Makefile               |   2 +
 .../ti/k3-j784s4-evm-quad-port-eth-exp1.dtso  | 144 ++++++++++++++++++
 2 files changed, 146 insertions(+)
 create mode 100644 arch/arm64/boot/dts/ti/k3-j784s4-evm-quad-port-eth-exp1.dtso

diff --git a/arch/arm64/boot/dts/ti/Makefile b/arch/arm64/boot/dts/ti/Makefile
index c83c9d772b81..88c43f1f211b 100644
--- a/arch/arm64/boot/dts/ti/Makefile
+++ b/arch/arm64/boot/dts/ti/Makefile
@@ -46,6 +46,8 @@ dtb-$(CONFIG_ARCH_K3) += k3-j721s2-common-proc-board.dtb
 # Boards with J784s4 SoC
 dtb-$(CONFIG_ARCH_K3) += k3-am69-sk.dtb
 dtb-$(CONFIG_ARCH_K3) += k3-j784s4-evm.dtb
+dtb-$(CONFIG_ARCH_K3) += k3-j784s4-evm-quad-port-eth-exp1.dtbo
 
 # Enable support for device-tree overlays
 DTC_FLAGS_k3-am6548-iot2050-advanced-m2 += -@
+DTC_FLAGS_k3-j784s4-evm += -@
diff --git a/arch/arm64/boot/dts/ti/k3-j784s4-evm-quad-port-eth-exp1.dtso b/arch/arm64/boot/dts/ti/k3-j784s4-evm-quad-port-eth-exp1.dtso
new file mode 100644
index 000000000000..32b0c8d45488
--- /dev/null
+++ b/arch/arm64/boot/dts/ti/k3-j784s4-evm-quad-port-eth-exp1.dtso
@@ -0,0 +1,144 @@
+// SPDX-License-Identifier: GPL-2.0
+/**
+ * DT Overlay for CPSW9G in QSGMII mode using J7 Quad Port ETH EXP Add-On Ethernet Card with
+ * J7AHP board. The Add-On Ethernet Card has to be connected to ENET Expansion 1 slot on the
+ * board.
+ *
+ * Product Datasheet: https://www.ti.com/lit/ug/spruj74/spruj74.pdf
+ *
+ * Copyright (C) 2023 Texas Instruments Incorporated - https://www.ti.com/
+ */
+
+/dts-v1/;
+/plugin/;
+
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/mux/ti-serdes.h>
+#include <dt-bindings/phy/phy-cadence.h>
+#include <dt-bindings/phy/phy.h>
+
+#include "k3-pinctrl.h"
+
+&{/} {
+	aliases {
+		ethernet1 = "/bus@100000/ethernet@c000000/ethernet-ports/port@5";
+		ethernet2 = "/bus@100000/ethernet@c000000/ethernet-ports/port@6";
+		ethernet3 = "/bus@100000/ethernet@c000000/ethernet-ports/port@7";
+		ethernet4 = "/bus@100000/ethernet@c000000/ethernet-ports/port@8";
+	};
+};
+
+&main_cpsw0 {
+	status = "okay";
+};
+
+&main_cpsw0_port5 {
+	status = "okay";
+	phy-handle = <&cpsw9g_phy1>;
+	phy-mode = "qsgmii";
+	mac-address = [00 00 00 00 00 00];
+	phys = <&cpsw0_phy_gmii_sel 5>, <&serdes2_qsgmii_link>;
+	phy-names = "mac", "serdes";
+};
+
+&main_cpsw0_port6 {
+	status = "okay";
+	phy-handle = <&cpsw9g_phy2>;
+	phy-mode = "qsgmii";
+	mac-address = [00 00 00 00 00 00];
+	phys = <&cpsw0_phy_gmii_sel 6>, <&serdes2_qsgmii_link>;
+	phy-names = "mac", "serdes";
+};
+
+&main_cpsw0_port7 {
+	status = "okay";
+	phy-handle = <&cpsw9g_phy0>;
+	phy-mode = "qsgmii";
+	mac-address = [00 00 00 00 00 00];
+	phys = <&cpsw0_phy_gmii_sel 7>, <&serdes2_qsgmii_link>;
+	phy-names = "mac", "serdes";
+};
+
+&main_cpsw0_port8 {
+	status = "okay";
+	phy-handle = <&cpsw9g_phy3>;
+	phy-mode = "qsgmii";
+	mac-address = [00 00 00 00 00 00];
+	phys = <&cpsw0_phy_gmii_sel 8>, <&serdes2_qsgmii_link>;
+	phy-names = "mac", "serdes";
+};
+
+&main_cpsw0_mdio {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&mdio0_pins_default>;
+	bus_freq = <1000000>;
+	reset-gpios = <&exp2 17 GPIO_ACTIVE_LOW>;
+	reset-post-delay-us = <120000>;
+	#address-cells = <1>;
+	#size-cells = <0>;
+
+	cpsw9g_phy0: ethernet-phy@16 {
+		reg = <16>;
+	};
+	cpsw9g_phy1: ethernet-phy@17 {
+		reg = <17>;
+	};
+	cpsw9g_phy2: ethernet-phy@18 {
+		reg = <18>;
+	};
+	cpsw9g_phy3: ethernet-phy@19 {
+		reg = <19>;
+	};
+};
+
+&exp2 {
+	/* Power-up ENET1 EXPANDER PHY. */
+	qsgmii-line-hog {
+		gpio-hog;
+		gpios = <16 GPIO_ACTIVE_HIGH>;
+		output-low;
+	};
+	/* Toggle MUX2 for MDIO lines */
+	mux-sel-hog {
+		gpio-hog;
+		gpios = <13 GPIO_ACTIVE_HIGH>, <14 GPIO_ACTIVE_HIGH>, <15 GPIO_ACTIVE_HIGH>;
+		output-high;
+	};
+};
+
+&main_pmx0 {
+	mdio0_pins_default: mdio0-pins-default {
+		pinctrl-single,pins = <
+			J784S4_IOPAD(0x05c, PIN_INPUT, 4) /* (AC36) MCASP2_AXR0.MDIO1_MDIO */
+			J784S4_IOPAD(0x058, PIN_INPUT, 4) /* (AE37) MCASP2_AFSX.MDIO1_MDC */
+		>;
+	};
+};
+
+&serdes_ln_ctrl {
+	idle-states = <J784S4_SERDES0_LANE0_PCIE1_LANE0>, <J784S4_SERDES0_LANE1_PCIE1_LANE1>,
+		      <J784S4_SERDES0_LANE2_IP3_UNUSED>, <J784S4_SERDES0_LANE3_USB>,
+		      <J784S4_SERDES1_LANE0_PCIE0_LANE0>, <J784S4_SERDES1_LANE1_PCIE0_LANE1>,
+		      <J784S4_SERDES1_LANE2_PCIE0_LANE2>, <J784S4_SERDES1_LANE3_PCIE0_LANE3>,
+		      <J784S4_SERDES2_LANE0_QSGMII_LANE5>, <J784S4_SERDES2_LANE1_QSGMII_LANE6>,
+		      <J784S4_SERDES2_LANE2_QSGMII_LANE7>, <J784S4_SERDES2_LANE3_QSGMII_LANE8>;
+};
+
+&serdes_wiz2 {
+	status = "okay";
+};
+
+&serdes2 {
+	status = "okay";
+	#address-cells = <1>;
+	#size-cells = <0>;
+
+	serdes2_qsgmii_link: phy@0 {
+		reg = <2>;
+		cdns,num-lanes = <1>;
+		#phy-cells = <0>;
+		cdns,phy-type = <PHY_TYPE_QSGMII>;
+		resets = <&serdes_wiz2 3>;
+	};
+};
-- 
2.25.1

