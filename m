Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D15AC71F260
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 20:50:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233187AbjFASt4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 14:49:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231691AbjFAStr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 14:49:47 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51F2318D;
        Thu,  1 Jun 2023 11:49:45 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 351InZKD107564;
        Thu, 1 Jun 2023 13:49:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1685645375;
        bh=krlI7zBjpD9L7kbQEVnqELx+bszogFDUsKdMJkJah0E=;
        h=From:To:CC:Subject:Date;
        b=cDI2EpYo0Umr4lCox+u0YtBMUkPL6WDWJsLyddLLxQXsrMBcqgcOL7VbSb9D7Fw/K
         tqu8ntbGQkYHeytGn99+khFwFn2f/co3S4ovx8//d3TDeLUU0sSZQIA8X98JtfFr+7
         lR7xdTHULc7NUzMWH5qDsIcDX9Y44aQNtN/8Ih3E=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 351InZWb113981
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 1 Jun 2023 13:49:35 -0500
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 1
 Jun 2023 13:49:35 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 1 Jun 2023 13:49:35 -0500
Received: from fllv0040.itg.ti.com (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 351InYGk073938;
        Thu, 1 Jun 2023 13:49:34 -0500
From:   Andrew Davis <afd@ti.com>
To:     Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Wadim Egorov <w.egorov@phytec.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Andrew Davis <afd@ti.com>
Subject: [PATCH 1/2] arm64: dts: ti: k3-am64: Only set UART baud for used ports
Date:   Thu, 1 Jun 2023 13:49:32 -0500
Message-ID: <20230601184933.358731-1-afd@ti.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As the binding for "current-speed" states, this should only be used
when the baud rate of an attached device cannot be detected. This is
the case for our attached on-board USB-to-UART converter used for
early kernel console. For all other unconnected/disabled ports this
can be configured in userspace later, DT is not the place for device
configuration, especially when there are already standard ways to
set serial baud in userspace.

Remove setting baud for all disabled serial ports and move setting
it for the couple enabled ports down into the board files.

Signed-off-by: Andrew Davis <afd@ti.com>
---
 arch/arm64/boot/dts/ti/k3-am64-main.dtsi                 | 7 -------
 arch/arm64/boot/dts/ti/k3-am64-mcu.dtsi                  | 2 --
 arch/arm64/boot/dts/ti/k3-am642-evm.dts                  | 1 +
 arch/arm64/boot/dts/ti/k3-am642-phyboard-electra-rdk.dts | 2 ++
 arch/arm64/boot/dts/ti/k3-am642-sk.dts                   | 1 +
 5 files changed, 4 insertions(+), 9 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-am64-main.dtsi b/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
index f5e25d6c3c28b..a5df81c6b0f9f 100644
--- a/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
@@ -377,7 +377,6 @@ main_uart0: serial@2800000 {
 		reg = <0x00 0x02800000 0x00 0x100>;
 		interrupts = <GIC_SPI 178 IRQ_TYPE_LEVEL_HIGH>;
 		clock-frequency = <48000000>;
-		current-speed = <115200>;
 		power-domains = <&k3_pds 146 TI_SCI_PD_EXCLUSIVE>;
 		clocks = <&k3_clks 146 0>;
 		clock-names = "fclk";
@@ -389,7 +388,6 @@ main_uart1: serial@2810000 {
 		reg = <0x00 0x02810000 0x00 0x100>;
 		interrupts = <GIC_SPI 179 IRQ_TYPE_LEVEL_HIGH>;
 		clock-frequency = <48000000>;
-		current-speed = <115200>;
 		power-domains = <&k3_pds 152 TI_SCI_PD_EXCLUSIVE>;
 		clocks = <&k3_clks 152 0>;
 		clock-names = "fclk";
@@ -401,7 +399,6 @@ main_uart2: serial@2820000 {
 		reg = <0x00 0x02820000 0x00 0x100>;
 		interrupts = <GIC_SPI 180 IRQ_TYPE_LEVEL_HIGH>;
 		clock-frequency = <48000000>;
-		current-speed = <115200>;
 		power-domains = <&k3_pds 153 TI_SCI_PD_EXCLUSIVE>;
 		clocks = <&k3_clks 153 0>;
 		clock-names = "fclk";
@@ -413,7 +410,6 @@ main_uart3: serial@2830000 {
 		reg = <0x00 0x02830000 0x00 0x100>;
 		interrupts = <GIC_SPI 181 IRQ_TYPE_LEVEL_HIGH>;
 		clock-frequency = <48000000>;
-		current-speed = <115200>;
 		power-domains = <&k3_pds 154 TI_SCI_PD_EXCLUSIVE>;
 		clocks = <&k3_clks 154 0>;
 		clock-names = "fclk";
@@ -425,7 +421,6 @@ main_uart4: serial@2840000 {
 		reg = <0x00 0x02840000 0x00 0x100>;
 		interrupts = <GIC_SPI 182 IRQ_TYPE_LEVEL_HIGH>;
 		clock-frequency = <48000000>;
-		current-speed = <115200>;
 		power-domains = <&k3_pds 155 TI_SCI_PD_EXCLUSIVE>;
 		clocks = <&k3_clks 155 0>;
 		clock-names = "fclk";
@@ -437,7 +432,6 @@ main_uart5: serial@2850000 {
 		reg = <0x00 0x02850000 0x00 0x100>;
 		interrupts = <GIC_SPI 183 IRQ_TYPE_LEVEL_HIGH>;
 		clock-frequency = <48000000>;
-		current-speed = <115200>;
 		power-domains = <&k3_pds 156 TI_SCI_PD_EXCLUSIVE>;
 		clocks = <&k3_clks 156 0>;
 		clock-names = "fclk";
@@ -449,7 +443,6 @@ main_uart6: serial@2860000 {
 		reg = <0x00 0x02860000 0x00 0x100>;
 		interrupts = <GIC_SPI 184 IRQ_TYPE_LEVEL_HIGH>;
 		clock-frequency = <48000000>;
-		current-speed = <115200>;
 		power-domains = <&k3_pds 158 TI_SCI_PD_EXCLUSIVE>;
 		clocks = <&k3_clks 158 0>;
 		clock-names = "fclk";
diff --git a/arch/arm64/boot/dts/ti/k3-am64-mcu.dtsi b/arch/arm64/boot/dts/ti/k3-am64-mcu.dtsi
index 31336b0e290e5..67ad414a5eab9 100644
--- a/arch/arm64/boot/dts/ti/k3-am64-mcu.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am64-mcu.dtsi
@@ -55,7 +55,6 @@ mcu_uart0: serial@4a00000 {
 		compatible = "ti,am64-uart", "ti,am654-uart";
 		reg = <0x00 0x04a00000 0x00 0x100>;
 		interrupts = <GIC_SPI 185 IRQ_TYPE_LEVEL_HIGH>;
-		current-speed = <115200>;
 		power-domains = <&k3_pds 149 TI_SCI_PD_EXCLUSIVE>;
 		clocks = <&k3_clks 149 0>;
 		clock-names = "fclk";
@@ -66,7 +65,6 @@ mcu_uart1: serial@4a10000 {
 		compatible = "ti,am64-uart", "ti,am654-uart";
 		reg = <0x00 0x04a10000 0x00 0x100>;
 		interrupts = <GIC_SPI 186 IRQ_TYPE_LEVEL_HIGH>;
-		current-speed = <115200>;
 		power-domains = <&k3_pds 160 TI_SCI_PD_EXCLUSIVE>;
 		clocks = <&k3_clks 160 0>;
 		clock-names = "fclk";
diff --git a/arch/arm64/boot/dts/ti/k3-am642-evm.dts b/arch/arm64/boot/dts/ti/k3-am642-evm.dts
index 3db740f78cd25..2b7373207cb71 100644
--- a/arch/arm64/boot/dts/ti/k3-am642-evm.dts
+++ b/arch/arm64/boot/dts/ti/k3-am642-evm.dts
@@ -375,6 +375,7 @@ &main_uart0 {
 	status = "okay";
 	pinctrl-names = "default";
 	pinctrl-0 = <&main_uart0_pins_default>;
+	current-speed = <115200>;
 };
 
 /* main_uart1 is reserved for firmware usage */
diff --git a/arch/arm64/boot/dts/ti/k3-am642-phyboard-electra-rdk.dts b/arch/arm64/boot/dts/ti/k3-am642-phyboard-electra-rdk.dts
index 8d3114d14a8b5..e4c2944f5dc8c 100644
--- a/arch/arm64/boot/dts/ti/k3-am642-phyboard-electra-rdk.dts
+++ b/arch/arm64/boot/dts/ti/k3-am642-phyboard-electra-rdk.dts
@@ -230,6 +230,7 @@ &main_uart0 {
 	status = "okay";
 	pinctrl-names = "default";
 	pinctrl-0 = <&main_uart0_pins_default>;
+	current-speed = <115200>;
 };
 
 &main_uart1 {
@@ -237,6 +238,7 @@ &main_uart1 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&main_uart1_pins_default>;
 	uart-has-rtscts;
+	current-speed = <115200>;
 };
 
 &sdhci1 {
diff --git a/arch/arm64/boot/dts/ti/k3-am642-sk.dts b/arch/arm64/boot/dts/ti/k3-am642-sk.dts
index 003cff9a27990..cab5fe9e7a784 100644
--- a/arch/arm64/boot/dts/ti/k3-am642-sk.dts
+++ b/arch/arm64/boot/dts/ti/k3-am642-sk.dts
@@ -369,6 +369,7 @@ &main_uart0 {
 	status = "okay";
 	pinctrl-names = "default";
 	pinctrl-0 = <&main_uart0_pins_default>;
+	current-speed = <115200>;
 };
 
 &main_uart1 {
-- 
2.39.2

