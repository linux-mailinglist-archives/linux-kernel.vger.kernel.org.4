Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 788E0601797
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 21:26:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231398AbiJQT0q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 15:26:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230513AbiJQT0S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 15:26:18 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42FDF2F39F;
        Mon, 17 Oct 2022 12:26:03 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 29HJPZoa121472;
        Mon, 17 Oct 2022 14:25:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1666034735;
        bh=OlZs8l4qQv5w44/U0ilvFxYS91AV1bcS98B4zdPUC44=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=vgJtKxSVvIWC28AwEY7qsODk5tCQS6p3I0pysFm9L/0HiUZFjpWFSXF7IBk170Tk3
         q7+usP1eLFURsHVYV164bSB1VmIzJnQiIELS47RLg1afBiSs2fIn5AjcHWymoHjgaK
         DkZG6KTlJON7s79zqVvtb3Ia7R7bMVZSz1BXYAd8=
Received: from DFLE108.ent.ti.com (dfle108.ent.ti.com [10.64.6.29])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 29HJPYAQ120613
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 17 Oct 2022 14:25:34 -0500
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6; Mon, 17
 Oct 2022 14:25:34 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6 via
 Frontend Transport; Mon, 17 Oct 2022 14:25:34 -0500
Received: from ula0226330.dal.design.ti.com (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 29HJPWXK026106;
        Mon, 17 Oct 2022 14:25:34 -0500
From:   Andrew Davis <afd@ti.com>
To:     Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Andrew Davis <afd@ti.com>
Subject: [PATCH 03/10] arm64: dts: ti: k3-am64: Enable SPI nodes at the board level
Date:   Mon, 17 Oct 2022 14:25:25 -0500
Message-ID: <20221017192532.23825-4-afd@ti.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221017192532.23825-1-afd@ti.com>
References: <20221017192532.23825-1-afd@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SPI nodes defined in the top-level AM64x SoC dtsi files are incomplete
and will not be functional unless they are extended with pinmux
information.

As the pinmux is only known at the board integration level, these
nodes should only be enabled when provided with this information.

Disable the SPI nodes in the dtsi files and only enable the ones that
are actually pinned out on a given board.

Signed-off-by: Andrew Davis <afd@ti.com>
---
 arch/arm64/boot/dts/ti/k3-am64-main.dtsi | 5 +++++
 arch/arm64/boot/dts/ti/k3-am64-mcu.dtsi  | 2 ++
 arch/arm64/boot/dts/ti/k3-am642-evm.dts  | 9 +--------
 arch/arm64/boot/dts/ti/k3-am642-sk.dts   | 8 --------
 4 files changed, 8 insertions(+), 16 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-am64-main.dtsi b/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
index fdcacf78f4a6..375078ca4fdd 100644
--- a/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
@@ -370,6 +370,7 @@ main_spi0: spi@20100000 {
 		clocks = <&k3_clks 141 0>;
 		dmas = <&main_pktdma 0xc300 0>, <&main_pktdma 0x4300 0>;
 		dma-names = "tx0", "rx0";
+		status = "disabled";
 	};
 
 	main_spi1: spi@20110000 {
@@ -380,6 +381,7 @@ main_spi1: spi@20110000 {
 		#size-cells = <0>;
 		power-domains = <&k3_pds 142 TI_SCI_PD_EXCLUSIVE>;
 		clocks = <&k3_clks 142 0>;
+		status = "disabled";
 	};
 
 	main_spi2: spi@20120000 {
@@ -390,6 +392,7 @@ main_spi2: spi@20120000 {
 		#size-cells = <0>;
 		power-domains = <&k3_pds 143 TI_SCI_PD_EXCLUSIVE>;
 		clocks = <&k3_clks 143 0>;
+		status = "disabled";
 	};
 
 	main_spi3: spi@20130000 {
@@ -400,6 +403,7 @@ main_spi3: spi@20130000 {
 		#size-cells = <0>;
 		power-domains = <&k3_pds 144 TI_SCI_PD_EXCLUSIVE>;
 		clocks = <&k3_clks 144 0>;
+		status = "disabled";
 	};
 
 	main_spi4: spi@20140000 {
@@ -410,6 +414,7 @@ main_spi4: spi@20140000 {
 		#size-cells = <0>;
 		power-domains = <&k3_pds 145 TI_SCI_PD_EXCLUSIVE>;
 		clocks = <&k3_clks 145 0>;
+		status = "disabled";
 	};
 
 	main_gpio_intr: interrupt-controller@a00000 {
diff --git a/arch/arm64/boot/dts/ti/k3-am64-mcu.dtsi b/arch/arm64/boot/dts/ti/k3-am64-mcu.dtsi
index 5ce8ceb3779d..38ddf0b3b8a0 100644
--- a/arch/arm64/boot/dts/ti/k3-am64-mcu.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am64-mcu.dtsi
@@ -60,6 +60,7 @@ mcu_spi0: spi@4b00000 {
 		#size-cells = <0>;
 		power-domains = <&k3_pds 147 TI_SCI_PD_EXCLUSIVE>;
 		clocks = <&k3_clks 147 0>;
+		status = "disabled";
 	};
 
 	mcu_spi1: spi@4b10000 {
@@ -70,6 +71,7 @@ mcu_spi1: spi@4b10000 {
 		#size-cells = <0>;
 		power-domains = <&k3_pds 148 TI_SCI_PD_EXCLUSIVE>;
 		clocks = <&k3_clks 148 0>;
+		status = "disabled";
 	};
 
 	mcu_gpio_intr: interrupt-controller@4210000 {
diff --git a/arch/arm64/boot/dts/ti/k3-am642-evm.dts b/arch/arm64/boot/dts/ti/k3-am642-evm.dts
index 3903e907244e..12d971c3bc3a 100644
--- a/arch/arm64/boot/dts/ti/k3-am642-evm.dts
+++ b/arch/arm64/boot/dts/ti/k3-am642-evm.dts
@@ -379,15 +379,8 @@ &mcu_gpio0 {
 	status = "reserved";
 };
 
-&mcu_spi0 {
-	status = "disabled";
-};
-
-&mcu_spi1 {
-	status = "disabled";
-};
-
 &main_spi0 {
+	status = "okay";
 	pinctrl-names = "default";
 	pinctrl-0 = <&main_spi0_pins_default>;
 	ti,pindir-d0-out-d1-in;
diff --git a/arch/arm64/boot/dts/ti/k3-am642-sk.dts b/arch/arm64/boot/dts/ti/k3-am642-sk.dts
index 56763d839e05..1a116593a771 100644
--- a/arch/arm64/boot/dts/ti/k3-am642-sk.dts
+++ b/arch/arm64/boot/dts/ti/k3-am642-sk.dts
@@ -375,14 +375,6 @@ exp2: gpio@60 {
 	};
 };
 
-&mcu_spi0 {
-	status = "disabled";
-};
-
-&mcu_spi1 {
-	status = "disabled";
-};
-
 /* mcu_gpio0 is reserved for mcu firmware usage */
 &mcu_gpio0 {
 	status = "reserved";
-- 
2.37.3

