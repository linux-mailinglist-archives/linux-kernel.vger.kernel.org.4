Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D226670B8CE
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 11:23:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232861AbjEVJWq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 05:22:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232833AbjEVJWe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 05:22:34 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2369E9;
        Mon, 22 May 2023 02:22:25 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 34M9MHsN049107;
        Mon, 22 May 2023 04:22:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1684747337;
        bh=Ppdp6mq1esy3x8XkblPahsO1RcBX9wHN1CQbS7/jecc=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=HttH6RxucYa/Gjva5Ayttu9gYuoNNq+EJONr2iXXrhO1/DD/N0hF5dqZRQDZbl9W6
         iPDy8vtlHFdoSiVXtX0uOzjrzaT67Ye+h1ux4NmXboQfFCY5u0mZ30G7tc+zvZndCa
         ieXPQCAQ/VjIxcbhEAQhS/lLL8HXVet4Nu/x5Re8=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 34M9MHrR038619
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 22 May 2023 04:22:17 -0500
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 22
 May 2023 04:22:17 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 22 May 2023 04:22:17 -0500
Received: from uda0492258.dhcp.ti.com (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 34M9M2e7127198;
        Mon, 22 May 2023 04:22:14 -0500
From:   Siddharth Vadapalli <s-vadapalli@ti.com>
To:     <nm@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski@linaro.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <afd@ti.com>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <srk@ti.com>,
        <s-vadapalli@ti.com>
Subject: [PATCH 3/3] arm64: dts: ti: k3-j784s4: Add overlay for dual port USXGMII mode
Date:   Mon, 22 May 2023 14:52:01 +0530
Message-ID: <20230522092201.127598-4-s-vadapalli@ti.com>
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

The CPSW9G instance of the CPSW Ethernet Switch supports USXGMII mode
with MAC Ports 1 and 2 of the instance, which are connected to ENET
Expansion 1 and ENET Expansion 2 slots on the EVM respectively, through
the Serdes2 instance of the SERDES.

Enable CPSW9G MAC Ports 1 and 2 in fixed-link configuration USXGMII mode
at 5 Gbps each.

Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
---
 arch/arm64/boot/dts/ti/Makefile               |  1 +
 .../ti/k3-j784s4-evm-usxgmii-exp1-exp2.dtso   | 72 +++++++++++++++++++
 2 files changed, 73 insertions(+)
 create mode 100644 arch/arm64/boot/dts/ti/k3-j784s4-evm-usxgmii-exp1-exp2.dtso

diff --git a/arch/arm64/boot/dts/ti/Makefile b/arch/arm64/boot/dts/ti/Makefile
index 88c43f1f211b..8ac7507f60ba 100644
--- a/arch/arm64/boot/dts/ti/Makefile
+++ b/arch/arm64/boot/dts/ti/Makefile
@@ -47,6 +47,7 @@ dtb-$(CONFIG_ARCH_K3) += k3-j721s2-common-proc-board.dtb
 dtb-$(CONFIG_ARCH_K3) += k3-am69-sk.dtb
 dtb-$(CONFIG_ARCH_K3) += k3-j784s4-evm.dtb
 dtb-$(CONFIG_ARCH_K3) += k3-j784s4-evm-quad-port-eth-exp1.dtbo
+dtb-$(CONFIG_ARCH_K3) += k3-j784s4-evm-usxgmii-exp1-exp2.dtbo
 
 # Enable support for device-tree overlays
 DTC_FLAGS_k3-am6548-iot2050-advanced-m2 += -@
diff --git a/arch/arm64/boot/dts/ti/k3-j784s4-evm-usxgmii-exp1-exp2.dtso b/arch/arm64/boot/dts/ti/k3-j784s4-evm-usxgmii-exp1-exp2.dtso
new file mode 100644
index 000000000000..1482a61d5487
--- /dev/null
+++ b/arch/arm64/boot/dts/ti/k3-j784s4-evm-usxgmii-exp1-exp2.dtso
@@ -0,0 +1,72 @@
+// SPDX-License-Identifier: GPL-2.0
+/**
+ * DT Overlay for CPSW9G in dual port fixed-link USXGMII mode using ENET-1
+ * and ENET-2 Expansion slots of J784S4 EVM.
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
+&main_cpsw0 {
+	status = "okay";
+	pinctrl-names = "default";
+};
+
+&main_cpsw0_port1 {
+	status = "okay";
+	phy-mode = "usxgmii";
+	mac-address = [00 00 00 00 00 00];
+	phys = <&cpsw0_phy_gmii_sel 1>, <&serdes2_usxgmii_link>;
+	phy-names = "mac", "serdes";
+	fixed-link {
+		speed = <5000>;
+		full-duplex;
+	};
+};
+
+&main_cpsw0_port2 {
+	status = "okay";
+	phy-mode = "usxgmii";
+	mac-address = [00 00 00 00 00 00];
+	phys = <&cpsw0_phy_gmii_sel 2>, <&serdes2_usxgmii_link>;
+	phy-names = "mac", "serdes";
+	fixed-link {
+		speed = <5000>;
+		full-duplex;
+	};
+};
+
+&serdes_wiz2 {
+	status = "okay";
+	assigned-clock-parents = <&k3_clks 406 9>;
+};
+
+&serdes2 {
+	status = "okay";
+	#address-cells = <1>;
+	#size-cells = <0>;
+
+	serdes2_usxgmii_link: phy@2 {
+		reg = <2>;
+		cdns,num-lanes = <2>;
+		#phy-cells = <0>;
+		cdns,phy-type = <PHY_TYPE_USXGMII>;
+		resets = <&serdes_wiz2 3>, <&serdes_wiz2 4>;
+	};
+};
+
+&serdes_ln_ctrl {
+	idle-states = <J784S4_SERDES0_LANE0_PCIE1_LANE0>, <J784S4_SERDES0_LANE1_PCIE1_LANE1>,
+		      <J784S4_SERDES0_LANE2_IP3_UNUSED>, <J784S4_SERDES0_LANE3_USB>,
+		      <J784S4_SERDES1_LANE0_PCIE0_LANE0>, <J784S4_SERDES1_LANE1_PCIE0_LANE1>,
+		      <J784S4_SERDES1_LANE2_PCIE0_LANE2>, <J784S4_SERDES1_LANE3_PCIE0_LANE3>,
+		      <J784S4_SERDES2_LANE0_IP2_UNUSED>, <J784S4_SERDES2_LANE1_IP2_UNUSED>,
+		      <J784S4_SERDES2_LANE2_QSGMII_LANE1>, <J784S4_SERDES2_LANE3_QSGMII_LANE2>;
+};
-- 
2.25.1

