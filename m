Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C89C6BA7C2
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 07:23:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231191AbjCOGXv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 02:23:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231297AbjCOGXj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 02:23:39 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 284A65CEC5;
        Tue, 14 Mar 2023 23:23:33 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 32F6NJ17026505;
        Wed, 15 Mar 2023 01:23:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1678861399;
        bh=uRUtUijRLyNsDgP8KQmrRsKViYd2Axqz/DSbt5xYI+g=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=mAf528CvxGwNwL7EVYHrItctYlrCb9xha8482WaXl+iAjJArdWHXwNDOXniDuEksl
         NaNEBVPzHX5CQ1pxsMNiNS3UuH16FLmhVMojldHMlRf4fBKcC3vM8isXZeC8RxI1XX
         GeGQz/YXiczAnNexa5k1o8Nch1fNaNganXgspzhM=
Received: from DFLE107.ent.ti.com (dfle107.ent.ti.com [10.64.6.28])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 32F6NJt5104529
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 15 Mar 2023 01:23:19 -0500
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Wed, 15
 Mar 2023 01:23:18 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Wed, 15 Mar 2023 01:23:19 -0500
Received: from uda0492258.dhcp.ti.com (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 32F6N7bt024744;
        Wed, 15 Mar 2023 01:23:15 -0500
From:   Siddharth Vadapalli <s-vadapalli@ti.com>
To:     <nm@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski@linaro.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <afd@ti.com>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <srk@ti.com>,
        <s-vadapalli@ti.com>
Subject: [PATCH v3 2/4] arm64: dts: ti: k3-j721e: Add overlay to enable CPSW9G ports in QSGMII mode
Date:   Wed, 15 Mar 2023 11:53:05 +0530
Message-ID: <20230315062307.1612220-3-s-vadapalli@ti.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230315062307.1612220-1-s-vadapalli@ti.com>
References: <20230315062307.1612220-1-s-vadapalli@ti.com>
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
 arch/arm64/boot/dts/ti/Makefile               |   3 +-
 .../ti/k3-j721e-evm-quad-port-eth-exp.dtso    | 132 ++++++++++++++++++
 2 files changed, 134 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm64/boot/dts/ti/k3-j721e-evm-quad-port-eth-exp.dtso

diff --git a/arch/arm64/boot/dts/ti/Makefile b/arch/arm64/boot/dts/ti/Makefile
index 6acd12409d59..7ded6dacd3f2 100644
--- a/arch/arm64/boot/dts/ti/Makefile
+++ b/arch/arm64/boot/dts/ti/Makefile
@@ -31,8 +31,9 @@ dtb-$(CONFIG_ARCH_K3) += k3-am654-base-board.dtb
 dtb-$(CONFIG_ARCH_K3) += k3-j7200-common-proc-board.dtb
 
 # Boards with J721e SoC
+k3-j721e-evm-dtbs := k3-j721e-common-proc-board.dtb k3-j721e-evm-quad-port-eth-exp.dtbo
 dtb-$(CONFIG_ARCH_K3) += k3-j721e-beagleboneai64.dtb
-dtb-$(CONFIG_ARCH_K3) += k3-j721e-common-proc-board.dtb
+dtb-$(CONFIG_ARCH_K3) += k3-j721e-evm.dtb
 dtb-$(CONFIG_ARCH_K3) += k3-j721e-sk.dtb
 
 # Boards with J721s2 SoC
diff --git a/arch/arm64/boot/dts/ti/k3-j721e-evm-quad-port-eth-exp.dtso b/arch/arm64/boot/dts/ti/k3-j721e-evm-quad-port-eth-exp.dtso
new file mode 100644
index 000000000000..0acdb59d789b
--- /dev/null
+++ b/arch/arm64/boot/dts/ti/k3-j721e-evm-quad-port-eth-exp.dtso
@@ -0,0 +1,132 @@
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
+&{/} {
+	aliases {
+		ethernet1 = "/bus@100000/ethernet@c000000/ethernet-ports/port@1";
+		ethernet2 = "/bus@100000/ethernet@c000000/ethernet-ports/port@2";
+		ethernet3 = "/bus@100000/ethernet@c000000/ethernet-ports/port@3";
+		ethernet4 = "/bus@100000/ethernet@c000000/ethernet-ports/port@4";
+	};
+};
+
+&cpsw0 {
+	status = "okay";
+};
+
+&cpsw0_port1 {
+	status = "okay";
+	phy-handle = <&cpsw9g_phy0>;
+	phy-mode = "qsgmii";
+	mac-address = [00 00 00 00 00 00];
+	phys = <&cpsw0_phy_gmii_sel 1>;
+};
+
+&cpsw0_port2 {
+	status = "okay";
+	phy-handle = <&cpsw9g_phy1>;
+	phy-mode = "qsgmii";
+	mac-address = [00 00 00 00 00 00];
+	phys = <&cpsw0_phy_gmii_sel 2>;
+};
+
+&cpsw0_port3 {
+	status = "okay";
+	phy-handle = <&cpsw9g_phy2>;
+	phy-mode = "qsgmii";
+	mac-address = [00 00 00 00 00 00];
+	phys = <&cpsw0_phy_gmii_sel 3>;
+};
+
+&cpsw0_port4 {
+	status = "okay";
+	phy-handle = <&cpsw9g_phy3>;
+	phy-mode = "qsgmii";
+	mac-address = [00 00 00 00 00 00];
+	phys = <&cpsw0_phy_gmii_sel 4>;
+};
+
+&cpsw9g_mdio {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&mdio0_pins_default>;
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
+	mdio0_pins_default: mdio0-pins-default {
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

