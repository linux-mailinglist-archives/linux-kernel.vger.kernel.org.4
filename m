Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D38F96B3BCB
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 11:14:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231138AbjCJKOe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 05:14:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229598AbjCJKOZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 05:14:25 -0500
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB5EC10C722;
        Fri, 10 Mar 2023 02:14:23 -0800 (PST)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 32AAEIxu108147;
        Fri, 10 Mar 2023 04:14:18 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1678443258;
        bh=pwOt/uEj2pkzB/suUkIUg9ic3JUX/kEHRfFn+j21zT4=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=dWghT0REVUCO7PV19EfVP1PeEDzpyDgLXzbpSvr4ZMYVTymH6KePSqBcuFYxm0Qxb
         qncYDa8bPTUGvOmeDt1cUjrgQ/Tmx/ryV5HoCN42zmN4kvddJgSZapkAtzxoKy8YIo
         AMCHL+S4pKQQU5DfnVtcjwktOhYYtrb9k40CMg5c=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 32AAEIwd063475
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 10 Mar 2023 04:14:18 -0600
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Fri, 10
 Mar 2023 04:14:18 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Fri, 10 Mar 2023 04:14:18 -0600
Received: from uda0492258.dhcp.ti.com (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 32AAE8f9024145;
        Fri, 10 Mar 2023 04:14:15 -0600
From:   Siddharth Vadapalli <s-vadapalli@ti.com>
To:     <nm@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski@linaro.org>,
        <krzysztof.kozlowski+dt@linaro.org>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <srk@ti.com>,
        <s-vadapalli@ti.com>
Subject: [PATCH 2/2] arm64: dts: ti: k3-j7200: Add overlay to enable CPSW5G ports in QSGMII mode
Date:   Fri, 10 Mar 2023 15:44:07 +0530
Message-ID: <20230310101407.722334-3-s-vadapalli@ti.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230310101407.722334-1-s-vadapalli@ti.com>
References: <20230310101407.722334-1-s-vadapalli@ti.com>
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

The J7 Quad Port Add-On Ethernet Card for J7200 Common-Proc-Board supports
QSGMII mode. Use the overlay to configure CPSW5G ports in QSGMII mode.

Add support to reset the PHY from kernel by using gpio-hog and gpio-reset.

Add aliases for CPSW5G ports to enable kernel to fetch MAC addresses
directly from U-Boot.

Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
---
 arch/arm64/boot/dts/ti/Makefile               |   2 +
 .../dts/ti/k3-j7200-quad-port-eth-exp.dtso    | 100 ++++++++++++++++++
 2 files changed, 102 insertions(+)
 create mode 100644 arch/arm64/boot/dts/ti/k3-j7200-quad-port-eth-exp.dtso

diff --git a/arch/arm64/boot/dts/ti/Makefile b/arch/arm64/boot/dts/ti/Makefile
index 167bcd9b09b7..04e95377a72a 100644
--- a/arch/arm64/boot/dts/ti/Makefile
+++ b/arch/arm64/boot/dts/ti/Makefile
@@ -45,7 +45,9 @@ dtb-$(CONFIG_ARCH_K3) += k3-j784s4-evm.dtb
 
 # Enable support for device-tree overlays
 DTC_FLAGS_k3-am6548-iot2050-advanced-m2 += -@
+DTC_FLAGS_k3-j7200-common-proc-board += -@
 DTC_FLAGS_k3-j721e-common-proc-board += -@
 
 # Device-tree overlays
+dtb-$(CONFIG_ARCH_K3) += k3-j7200-quad-port-eth-exp.dtbo
 dtb-$(CONFIG_ARCH_K3) += k3-j721e-quad-port-eth-exp.dtbo
diff --git a/arch/arm64/boot/dts/ti/k3-j7200-quad-port-eth-exp.dtso b/arch/arm64/boot/dts/ti/k3-j7200-quad-port-eth-exp.dtso
new file mode 100644
index 000000000000..b84f185c0a31
--- /dev/null
+++ b/arch/arm64/boot/dts/ti/k3-j7200-quad-port-eth-exp.dtso
@@ -0,0 +1,100 @@
+// SPDX-License-Identifier: GPL-2.0
+/**
+ * DT Overlay for CPSW5G in QSGMII mode using J7 Quad Port ETH EXP Add-On Ethernet Card with
+ * J7200 board.
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
+
+/ {
+	fragment@101 {
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
+	pinctrl-0 = <&mdio0_pins_default>;
+};
+
+&cpsw0_port1 {
+	phy-handle = <&cpsw5g_phy0>;
+	phy-mode = "qsgmii";
+	mac-address = [00 00 00 00 00 00];
+	phys = <&cpsw0_phy_gmii_sel 1>;
+};
+
+&cpsw0_port2 {
+	phy-handle = <&cpsw5g_phy1>;
+	phy-mode = "qsgmii";
+	mac-address = [00 00 00 00 00 00];
+	phys = <&cpsw0_phy_gmii_sel 2>;
+};
+
+&cpsw0_port3 {
+	phy-handle = <&cpsw5g_phy2>;
+	phy-mode = "qsgmii";
+	mac-address = [00 00 00 00 00 00];
+	phys = <&cpsw0_phy_gmii_sel 3>;
+};
+
+&cpsw0_port4 {
+	phy-handle = <&cpsw5g_phy3>;
+	phy-mode = "qsgmii";
+	mac-address = [00 00 00 00 00 00];
+	phys = <&cpsw0_phy_gmii_sel 4>;
+};
+
+&cpsw5g_mdio {
+	reset-gpios = <&exp2 17 GPIO_ACTIVE_LOW>;
+	reset-post-delay-us = <120000>;
+	#address-cells = <1>;
+	#size-cells = <0>;
+
+	cpsw5g_phy0: ethernet-phy@16 {
+		reg = <16>;
+	};
+	cpsw5g_phy1: ethernet-phy@17 {
+		reg = <17>;
+	};
+	cpsw5g_phy2: ethernet-phy@18 {
+		reg = <18>;
+	};
+	cpsw5g_phy3: ethernet-phy@19 {
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
+			J721E_IOPAD(0x00a8, PIN_OUTPUT, 5) /* (W19) UART8_TXD.MDIO0_MDC */
+			J721E_IOPAD(0x00a4, PIN_INPUT, 5) /* (W14) UART8_RXD.MDIO0_MDIO */
+		>;
+	};
+};
-- 
2.25.1

