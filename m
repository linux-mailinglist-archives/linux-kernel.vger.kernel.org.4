Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 925A16B3A7E
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 10:31:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231268AbjCJJbt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 04:31:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230372AbjCJJbP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 04:31:15 -0500
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87ABF5F519;
        Fri, 10 Mar 2023 01:28:37 -0800 (PST)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 32A9SFVu042714;
        Fri, 10 Mar 2023 03:28:15 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1678440495;
        bh=9mGwYUc0gIJIQm5CB34LSX5n3OOTqwceEq2LAFUAH1Y=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=AYI/O8v7Ze5oXkmeHzuFPUeRV7tAW08JMpal3oLVWv5xP9+XgkOG0NTNqcYNKQgud
         Uex6A2hz8YHy2mGeWAJTTHIxRkmetv6mKbJ6UkN8/w7UDWehtlywPWOKNnqGXhCsMe
         c0oMJz7jkv9hPikmItRYxilQIJnAghY3oXr84XT8=
Received: from DLEE101.ent.ti.com (dlee101.ent.ti.com [157.170.170.31])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 32A9SFw8026728
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 10 Mar 2023 03:28:15 -0600
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Fri, 10
 Mar 2023 03:28:14 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Fri, 10 Mar 2023 03:28:15 -0600
Received: from uda0492258.dhcp.ti.com (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 32A9S4LI022476;
        Fri, 10 Mar 2023 03:28:12 -0600
From:   Siddharth Vadapalli <s-vadapalli@ti.com>
To:     <nm@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski@linaro.org>,
        <krzysztof.kozlowski+dt@linaro.org>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <srk@ti.com>,
        <s-vadapalli@ti.com>
Subject: [PATCH 2/2] arm64: dts: ti: k3-j721e: Add overlay to enable CPSW9G ports in QSGMII mode
Date:   Fri, 10 Mar 2023 14:58:04 +0530
Message-ID: <20230310092804.692303-3-s-vadapalli@ti.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230310092804.692303-1-s-vadapalli@ti.com>
References: <20230310092804.692303-1-s-vadapalli@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The J7 Quad Port Add-On Ethernet Card for J721E Common-Proc-Board supports
QSGMII mode. Use the overlay to configure CPSW9G ports in QSGMII mode.

Add support to reset the PHY from kernel by using gpio-hog and gpio-reset.

Add aliases for CPSW9G ports to enable kernel to fetch MAC addresses
directly from U-Boot.

Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
---
 arch/arm64/boot/dts/ti/Makefile               |   4 +
 .../dts/ti/k3-j721e-quad-port-eth-exp.dtso    | 148 ++++++++++++++++++
 2 files changed, 152 insertions(+)
 create mode 100644 arch/arm64/boot/dts/ti/k3-j721e-quad-port-eth-exp.dtso

diff --git a/arch/arm64/boot/dts/ti/Makefile b/arch/arm64/boot/dts/ti/Makefile
index 6acd12409d59..167bcd9b09b7 100644
--- a/arch/arm64/boot/dts/ti/Makefile
+++ b/arch/arm64/boot/dts/ti/Makefile
@@ -45,3 +45,7 @@ dtb-$(CONFIG_ARCH_K3) += k3-j784s4-evm.dtb
 
 # Enable support for device-tree overlays
 DTC_FLAGS_k3-am6548-iot2050-advanced-m2 += -@
+DTC_FLAGS_k3-j721e-common-proc-board += -@
+
+# Device-tree overlays
+dtb-$(CONFIG_ARCH_K3) += k3-j721e-quad-port-eth-exp.dtbo
diff --git a/arch/arm64/boot/dts/ti/k3-j721e-quad-port-eth-exp.dtso b/arch/arm64/boot/dts/ti/k3-j721e-quad-port-eth-exp.dtso
new file mode 100644
index 000000000000..c63e1454614e
--- /dev/null
+++ b/arch/arm64/boot/dts/ti/k3-j721e-quad-port-eth-exp.dtso
@@ -0,0 +1,148 @@
+// SPDX-License-Identifier: GPL-2.0
+/**
+ * DT Overlay for CPSW9G in QSGMII mode using J7 Quad Port ETH EXP Add-On Ethernet Card with
+ * J721E board.
+ *
+ * Copyright (C) 2023 Texas Instruments Incorporated - https://www.ti.com/
+ */
+
+/dts-v1/;
+/plugin/;
+
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/mux/ti-serdes.h>
+#include <dt-bindings/pinctrl/k3.h>
+#include <dt-bindings/phy/phy.h>
+#include <dt-bindings/phy/phy-cadence.h>
+
+/ {
+	fragment@102 {
+		target-path = "/";
+		__overlay__ {
+			aliases {
+				ethernet1 = "/bus@100000/ethernet@c000000/ethernet-ports/port@1";
+				ethernet2 = "/bus@100000/ethernet@c000000/ethernet-ports/port@2";
+				ethernet3 = "/bus@100000/ethernet@c000000/ethernet-ports/port@3";
+				ethernet4 = "/bus@100000/ethernet@c000000/ethernet-ports/port@4";
+			};
+		};
+	};
+};
+
+&cpsw0 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&mdio_pins_default>;
+};
+
+&cpsw0_port1 {
+	phy-handle = <&cpsw9g_phy0>;
+	phy-mode = "qsgmii";
+	mac-address = [00 00 00 00 00 00];
+	phys = <&cpsw0_phy_gmii_sel 1>;
+};
+
+&cpsw0_port2 {
+	phy-handle = <&cpsw9g_phy1>;
+	phy-mode = "qsgmii";
+	mac-address = [00 00 00 00 00 00];
+	phys = <&cpsw0_phy_gmii_sel 2>;
+};
+
+&cpsw0_port3 {
+	phy-handle = <&cpsw9g_phy2>;
+	phy-mode = "qsgmii";
+	mac-address = [00 00 00 00 00 00];
+	phys = <&cpsw0_phy_gmii_sel 3>;
+};
+
+&cpsw0_port4 {
+	phy-handle = <&cpsw9g_phy3>;
+	phy-mode = "qsgmii";
+	mac-address = [00 00 00 00 00 00];
+	phys = <&cpsw0_phy_gmii_sel 4>;
+};
+
+&cpsw0_port5 {
+	status = "disabled";
+};
+
+&cpsw0_port6 {
+	status = "disabled";
+};
+
+&cpsw0_port7 {
+	status = "disabled";
+};
+
+&cpsw0_port8 {
+	status = "disabled";
+};
+
+&cpsw9g_mdio {
+	reset-gpios = <&exp2 17 GPIO_ACTIVE_LOW>;
+	reset-post-delay-us = <120000>;
+	#address-cells = <1>;
+	#size-cells = <0>;
+
+	cpsw9g_phy0: ethernet-phy@17 {
+		reg = <17>;
+	};
+	cpsw9g_phy1: ethernet-phy@16 {
+		reg = <16>;
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
+	qsgmii-line-hog {
+		gpio-hog;
+		gpios = <16 GPIO_ACTIVE_HIGH>;
+		output-low;
+		line-name = "qsgmii-pwrdn-line";
+	};
+};
+
+&main_pmx0 {
+	mdio_pins_default: mdio_pins_default {
+		pinctrl-single,pins = <
+			J721E_IOPAD(0x1bc, PIN_OUTPUT, 0) /* (V24) MDIO0_MDC */
+			J721E_IOPAD(0x1b8, PIN_INPUT, 0) /* (V26) MDIO0_MDIO */
+		>;
+	};
+};
+
+&serdes_ln_ctrl {
+	idle-states = <J721E_SERDES0_LANE0_PCIE0_LANE0>, <J721E_SERDES0_LANE1_QSGMII_LANE2>,
+		      <J721E_SERDES1_LANE0_PCIE1_LANE0>, <J721E_SERDES1_LANE1_PCIE1_LANE1>,
+		      <J721E_SERDES2_LANE0_PCIE2_LANE0>, <J721E_SERDES2_LANE1_PCIE2_LANE1>,
+		      <J721E_SERDES3_LANE0_USB3_0_SWAP>, <J721E_SERDES3_LANE1_USB3_0>,
+		      <J721E_SERDES4_LANE0_EDP_LANE0>, <J721E_SERDES4_LANE1_EDP_LANE1>,
+		      <J721E_SERDES4_LANE2_EDP_LANE2>, <J721E_SERDES4_LANE3_EDP_LANE3>;
+};
+
+&serdes_wiz0 {
+	status = "okay";
+};
+
+&serdes0 {
+	status = "okay";
+
+	assigned-clocks = <&serdes0 CDNS_SIERRA_PLL_CMNLC>, <&serdes0 CDNS_SIERRA_PLL_CMNLC1>;
+	assigned-clock-parents = <&wiz0_pll1_refclk>, <&wiz0_pll1_refclk>;
+	#address-cells = <1>;
+	#size-cells = <0>;
+
+	serdes0_qsgmii_link: phy@1 {
+		reg = <1>;
+		cdns,num-lanes = <1>;
+		#phy-cells = <0>;
+		cdns,phy-type = <PHY_TYPE_QSGMII>;
+		resets = <&serdes_wiz0 2>;
+	};
+};
-- 
2.25.1

