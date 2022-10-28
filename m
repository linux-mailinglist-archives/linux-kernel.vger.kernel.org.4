Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF3FC61147F
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 16:25:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231209AbiJ1OZe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 10:25:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230238AbiJ1OYj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 10:24:39 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CC77F1C;
        Fri, 28 Oct 2022 07:24:33 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 29SEOOR6026570;
        Fri, 28 Oct 2022 09:24:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1666967064;
        bh=thI8gY7TszK4NMBgRo4Ut9XjHt2FFaPnIVg5c5tAsmU=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=jAW/ANC/7+nwS8jbx3d878PgBXoPxQ4/mykKWVa8QXIA5U9pbsquYRr0XjA4IHwQT
         Cgm9u0z/ZWniGzxLFfLVCM6mArlEMk0kd2x6dM1OQNIFHY+7LcGfyvX376vnNGjWY/
         hvV8KaOEcQjQxnrZkuH3sfpJmVoQsPUX5hoc37gQ=
Received: from DLEE110.ent.ti.com (dlee110.ent.ti.com [157.170.170.21])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 29SEOOlr062546
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 28 Oct 2022 09:24:24 -0500
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6; Fri, 28
 Oct 2022 09:24:24 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6 via
 Frontend Transport; Fri, 28 Oct 2022 09:24:24 -0500
Received: from ula0226330.dal.design.ti.com (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 29SEOHfY039275;
        Fri, 28 Oct 2022 09:24:23 -0500
From:   Andrew Davis <afd@ti.com>
To:     Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bryan Brattlof <bb@ti.com>, Le Jin <le.jin@siemens.com>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        <linux-arm-kernel@lists.infradead.org>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Andrew Davis <afd@ti.com>
Subject: [PATCH 09/11] arm64: dts: ti: k3-am65: Enable PCIe nodes at the board level
Date:   Fri, 28 Oct 2022 09:24:15 -0500
Message-ID: <20221028142417.10642-10-afd@ti.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221028142417.10642-1-afd@ti.com>
References: <20221028142417.10642-1-afd@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PCIe nodes defined in the top-level AM65x SoC dtsi files are incomplete
and will not be functional unless they are extended with a SerDes PHY.
And usually only one of the two modes can be used at a time as they
share a SerDes link.

As the PHY and mode is only known at the board integration level, these
nodes should only be enabled when provided with this information.

Disable the PCIe nodes in the dtsi files and only enable the ones that
are actually pinned out on a given board.

Signed-off-by: Andrew Davis <afd@ti.com>
---
 .../boot/dts/ti/k3-am65-iot2050-common.dtsi      | 13 +------------
 arch/arm64/boot/dts/ti/k3-am65-main.dtsi         |  4 ++++
 arch/arm64/boot/dts/ti/k3-am654-base-board.dts   | 16 ----------------
 3 files changed, 5 insertions(+), 28 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-am65-iot2050-common.dtsi b/arch/arm64/boot/dts/ti/k3-am65-iot2050-common.dtsi
index c431d670757ba..dd7c6aee8c613 100644
--- a/arch/arm64/boot/dts/ti/k3-am65-iot2050-common.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am65-iot2050-common.dtsi
@@ -632,15 +632,8 @@ dpi_out: endpoint {
 	};
 };
 
-&pcie0_rc {
-	status = "disabled";
-};
-
-&pcie0_ep {
-	status = "disabled";
-};
-
 &pcie1_rc {
+	status = "okay";
 	pinctrl-names = "default";
 	pinctrl-0 = <&minipcie_pins_default>;
 
@@ -650,10 +643,6 @@ &pcie1_rc {
 	reset-gpios = <&wkup_gpio0 27 GPIO_ACTIVE_HIGH>;
 };
 
-&pcie1_ep {
-	status = "disabled";
-};
-
 &mailbox0_cluster0 {
 	interrupts = <436>;
 
diff --git a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
index 9cdde6e25e7de..9081c791a3123 100644
--- a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
@@ -720,6 +720,7 @@ pcie0_rc: pcie@5500000 {
 		interrupts = <GIC_SPI 340 IRQ_TYPE_EDGE_RISING>;
 		msi-map = <0x0 &gic_its 0x0 0x10000>;
 		device_type = "pci";
+		status = "disabled";
 	};
 
 	pcie0_ep: pcie-ep@5500000 {
@@ -733,6 +734,7 @@ pcie0_ep: pcie-ep@5500000 {
 		max-link-speed = <2>;
 		dma-coherent;
 		interrupts = <GIC_SPI 340 IRQ_TYPE_EDGE_RISING>;
+		status = "disabled";
 	};
 
 	pcie1_rc: pcie@5600000 {
@@ -753,6 +755,7 @@ pcie1_rc: pcie@5600000 {
 		interrupts = <GIC_SPI 355 IRQ_TYPE_EDGE_RISING>;
 		msi-map = <0x0 &gic_its 0x10000 0x10000>;
 		device_type = "pci";
+		status = "disabled";
 	};
 
 	pcie1_ep: pcie-ep@5600000 {
@@ -766,6 +769,7 @@ pcie1_ep: pcie-ep@5600000 {
 		max-link-speed = <2>;
 		dma-coherent;
 		interrupts = <GIC_SPI 355 IRQ_TYPE_EDGE_RISING>;
+		status = "disabled";
 	};
 
 	mcasp0: mcasp@2b00000 {
diff --git a/arch/arm64/boot/dts/ti/k3-am654-base-board.dts b/arch/arm64/boot/dts/ti/k3-am654-base-board.dts
index bf6a6fe3d7ba3..a61060c6bc198 100644
--- a/arch/arm64/boot/dts/ti/k3-am654-base-board.dts
+++ b/arch/arm64/boot/dts/ti/k3-am654-base-board.dts
@@ -415,22 +415,6 @@ &serdes1 {
 	status = "disabled";
 };
 
-&pcie0_rc {
-	status = "disabled";
-};
-
-&pcie0_ep {
-	status = "disabled";
-};
-
-&pcie1_rc {
-	status = "disabled";
-};
-
-&pcie1_ep {
-	status = "disabled";
-};
-
 &mailbox0_cluster0 {
 	interrupts = <436>;
 
-- 
2.37.3

