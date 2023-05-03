Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A93076F5327
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 10:32:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229666AbjECIcF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 04:32:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjECIcC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 04:32:02 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A037026A0;
        Wed,  3 May 2023 01:31:59 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3438Vl3k121181;
        Wed, 3 May 2023 03:31:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1683102707;
        bh=7E+b59g9ZUnT0DGj/ASCkfNAb/3LpiC3e12t/ZXeFRs=;
        h=From:To:CC:Subject:Date;
        b=Z6IL4fkmuL6gHxtZtRSYk1xTtBQwbUVv6ckWRjomzvGt6BKB3w4v8BpusWzujwoqW
         yrUdBRTkJ4RsNrHQTpcUFmgQpYw6SLRIilkW/TgPp+jhK05V+je457fpvVjorqDEzU
         FlCv2TpBM/CGE8aRtuNAirSlJehB1xjcBx7d/AXU=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3438VlI5056563
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 3 May 2023 03:31:47 -0500
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 3
 May 2023 03:31:47 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 3 May 2023 03:31:47 -0500
Received: from ul0491018.dal.design.ti.com (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3438VhlN042501;
        Wed, 3 May 2023 03:31:44 -0500
From:   Thejasvi Konduru <t-konduru@ti.com>
To:     Tero Kristo <kristo@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Nishanth Menon <nm@ti.com>, Andrew Davis <afd@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Apurva Nandan <a-nandan@ti.com>, Udit Kumar <u-kumar1@ti.com>,
        Thejasvi Konduru <t-konduru@ti.com>
Subject: [PATCH] arm64: dts: ti: k3-j784s4: Fix wakeup pinmux range and pinctrl node offsets
Date:   Wed, 3 May 2023 14:01:43 +0530
Message-ID: <20230503083143.32369-1-t-konduru@ti.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The wkup_pmx register region in j784s4 has multiple non-addressable
regions, hence the existing wkup_pmx region is split as follows to
avoid the non-addressable regions. The pinctrl node offsets are
also corrected as per the newly split wkup_pmx* nodes.

wkup_pmx0 -> 13 pins (WKUP_PADCONFIG 0 - 12)
wkup_pmx1 -> 11 pins (WKUP_PADCONFIG 14 - 24)
wkup_pmx2 -> 72 pins (WKUP_PADCONFIG 26 - 97)
wkup_pmx3 -> 1 pin (WKUP_PADCONFIG 100)

Fixes: 4664ebd8346a ("arm64: dts: ti: Add initial support for J784S4 SoC")
Signed-off-by: Thejasvi Konduru <t-konduru@ti.com>
---
 arch/arm64/boot/dts/ti/k3-j784s4-evm.dts      | 30 +++++++++----------
 .../boot/dts/ti/k3-j784s4-mcu-wakeup.dtsi     | 29 +++++++++++++++++-
 2 files changed, 43 insertions(+), 16 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-j784s4-evm.dts b/arch/arm64/boot/dts/ti/k3-j784s4-evm.dts
index f33815953e77..490d0b8624f3 100644
--- a/arch/arm64/boot/dts/ti/k3-j784s4-evm.dts
+++ b/arch/arm64/boot/dts/ti/k3-j784s4-evm.dts
@@ -141,28 +141,28 @@
 	};
 };
 
-&wkup_pmx0 {
+&wkup_pmx2 {
 	mcu_cpsw_pins_default: mcu-cpsw-pins-default {
 		pinctrl-single,pins = <
-			J784S4_WKUP_IOPAD(0x094, PIN_INPUT, 0) /* (A35) MCU_RGMII1_RD0 */
-			J784S4_WKUP_IOPAD(0x090, PIN_INPUT, 0) /* (B36) MCU_RGMII1_RD1 */
-			J784S4_WKUP_IOPAD(0x08c, PIN_INPUT, 0) /* (C36) MCU_RGMII1_RD2 */
-			J784S4_WKUP_IOPAD(0x088, PIN_INPUT, 0) /* (D36) MCU_RGMII1_RD3 */
-			J784S4_WKUP_IOPAD(0x084, PIN_INPUT, 0) /* (B37) MCU_RGMII1_RXC */
-			J784S4_WKUP_IOPAD(0x06c, PIN_INPUT, 0) /* (C37) MCU_RGMII1_RX_CTL */
-			J784S4_WKUP_IOPAD(0x07c, PIN_OUTPUT, 0) /* (D37) MCU_RGMII1_TD0 */
-			J784S4_WKUP_IOPAD(0x078, PIN_OUTPUT, 0) /* (D38) MCU_RGMII1_TD1 */
-			J784S4_WKUP_IOPAD(0x074, PIN_OUTPUT, 0) /* (E37) MCU_RGMII1_TD2 */
-			J784S4_WKUP_IOPAD(0x070, PIN_OUTPUT, 0) /* (E38) MCU_RGMII1_TD3 */
-			J784S4_WKUP_IOPAD(0x080, PIN_OUTPUT, 0) /* (E36) MCU_RGMII1_TXC */
-			J784S4_WKUP_IOPAD(0x068, PIN_OUTPUT, 0) /* (C38) MCU_RGMII1_TX_CTL */
+			J784S4_WKUP_IOPAD(0x02c, PIN_INPUT, 0) /* (A35) MCU_RGMII1_RD0 */
+			J784S4_WKUP_IOPAD(0x028, PIN_INPUT, 0) /* (B36) MCU_RGMII1_RD1 */
+			J784S4_WKUP_IOPAD(0x024, PIN_INPUT, 0) /* (C36) MCU_RGMII1_RD2 */
+			J784S4_WKUP_IOPAD(0x020, PIN_INPUT, 0) /* (D36) MCU_RGMII1_RD3 */
+			J784S4_WKUP_IOPAD(0x01c, PIN_INPUT, 0) /* (B37) MCU_RGMII1_RXC */
+			J784S4_WKUP_IOPAD(0x004, PIN_INPUT, 0) /* (C37) MCU_RGMII1_RX_CTL */
+			J784S4_WKUP_IOPAD(0x014, PIN_OUTPUT, 0) /* (D37) MCU_RGMII1_TD0 */
+			J784S4_WKUP_IOPAD(0x010, PIN_OUTPUT, 0) /* (D38) MCU_RGMII1_TD1 */
+			J784S4_WKUP_IOPAD(0x00c, PIN_OUTPUT, 0) /* (E37) MCU_RGMII1_TD2 */
+			J784S4_WKUP_IOPAD(0x008, PIN_OUTPUT, 0) /* (E38) MCU_RGMII1_TD3 */
+			J784S4_WKUP_IOPAD(0x018, PIN_OUTPUT, 0) /* (E36) MCU_RGMII1_TXC */
+			J784S4_WKUP_IOPAD(0x000, PIN_OUTPUT, 0) /* (C38) MCU_RGMII1_TX_CTL */
 		>;
 	};
 
 	mcu_mdio_pins_default: mcu-mdio-pins-default {
 		pinctrl-single,pins = <
-			J784S4_WKUP_IOPAD(0x09c, PIN_OUTPUT, 0) /* (A36) MCU_MDIO0_MDC */
-			J784S4_WKUP_IOPAD(0x098, PIN_INPUT, 0) /* (B35) MCU_MDIO0_MDIO */
+			J784S4_WKUP_IOPAD(0x034, PIN_OUTPUT, 0) /* (A36) MCU_MDIO0_MDC */
+			J784S4_WKUP_IOPAD(0x030, PIN_INPUT, 0) /* (B35) MCU_MDIO0_MDIO */
 		>;
 	};
 };
diff --git a/arch/arm64/boot/dts/ti/k3-j784s4-mcu-wakeup.dtsi b/arch/arm64/boot/dts/ti/k3-j784s4-mcu-wakeup.dtsi
index f04fcb614cbe..ed2b40369c59 100644
--- a/arch/arm64/boot/dts/ti/k3-j784s4-mcu-wakeup.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j784s4-mcu-wakeup.dtsi
@@ -50,7 +50,34 @@
 	wkup_pmx0: pinctrl@4301c000 {
 		compatible = "pinctrl-single";
 		/* Proxy 0 addressing */
-		reg = <0x00 0x4301c000 0x00 0x178>;
+		reg = <0x00 0x4301c000 0x00 0x034>;
+		#pinctrl-cells = <1>;
+		pinctrl-single,register-width = <32>;
+		pinctrl-single,function-mask = <0xffffffff>;
+	};
+
+	wkup_pmx1: pinctrl@4301c038 {
+		compatible = "pinctrl-single";
+		/* Proxy 0 addressing */
+		reg = <0x00 0x4301c038 0x00 0x02c>;
+		#pinctrl-cells = <1>;
+		pinctrl-single,register-width = <32>;
+		pinctrl-single,function-mask = <0xffffffff>;
+	};
+
+	wkup_pmx2: pinctrl@4301c068 {
+		compatible = "pinctrl-single";
+		/* Proxy 0 addressing */
+		reg = <0x00 0x4301c068 0x00 0x120>;
+		#pinctrl-cells = <1>;
+		pinctrl-single,register-width = <32>;
+		pinctrl-single,function-mask = <0xffffffff>;
+	};
+
+	wkup_pmx3: pinctrl@4301c190 {
+		compatible = "pinctrl-single";
+		/* Proxy 0 addressing */
+		reg = <0x00 0x4301c190 0x00 0x004>;
 		#pinctrl-cells = <1>;
 		pinctrl-single,register-width = <32>;
 		pinctrl-single,function-mask = <0xffffffff>;
-- 
2.17.1

