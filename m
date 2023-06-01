Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13CCC719728
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 11:39:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232901AbjFAJi5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 05:38:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232891AbjFAJix (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 05:38:53 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93921193;
        Thu,  1 Jun 2023 02:38:48 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3519cYtR102210;
        Thu, 1 Jun 2023 04:38:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1685612314;
        bh=dzR/M89RZSFt3KI0fZN4F/Ibnuh5m91ANq22uH4vIAY=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=npV0p7iHHf6PIUqZKgXRW1bcua1urrppso4+nk5Mddxow0PUiWBMwb9xATX03C3DD
         ifz5cgzxAoZQOeKr/xVpWvLrSabiNICkTzGAsj+9yKUbANc4zssXXLiPtfOXNZ9rOb
         2ifdCeJsO4h3rYPKbif3X0Tcar94W/mxs/1p/IZc=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3519cYvW040582
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 1 Jun 2023 04:38:34 -0500
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 1
 Jun 2023 04:38:34 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 1 Jun 2023 04:38:34 -0500
Received: from udit-HP-Z2-Tower-G9-Workstation-Desktop-PC.dhcp.ti.com (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3519cNqU072495;
        Thu, 1 Jun 2023 04:38:30 -0500
From:   Udit Kumar <u-kumar1@ti.com>
To:     <nm@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <conor+dt@kernel.org>, <m-chawdhry@ti.com>, <n-francis@ti.com>
CC:     Udit Kumar <u-kumar1@ti.com>, Tony Lindgren <tony@atomide.com>
Subject: [PATCH v2 2/5] arm64: dts: ti: k3-j7200: Configure pinctrl for timer IO pads
Date:   Thu, 1 Jun 2023 15:07:41 +0530
Message-ID: <20230601093744.1565802-3-u-kumar1@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230601093744.1565802-1-u-kumar1@ti.com>
References: <20230601093744.1565802-1-u-kumar1@ti.com>
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

There are timer IO pads in the MCU domain, and in the MAIN domain. These
pads can be muxed for the related timers.

There are timer IO control registers for input and output. The registers
for CTRLMMR_TIMER*_CTRL and CTRLMMR_MCU_TIMER*_CTRL are used to control
the input. The registers for CTCTRLMMR_TIMERIO*_CTRL and
CTRLMMR_MCU_TIMERIO*_CTRL the output.

The multiplexing is documented in TRM "5.1.2.3.1.4 Timer IO Muxing Control
Registers" and "5.1.3.3.1.5 Timer IO Muxing Control Registers", and the
CASCADE_EN bit is documented in TRM "12.6.3.1 Timers Overview".

For chaining timers, the timer IO control registers also have a CASCADE_EN
input bit in the CTRLMMR_TIMER*_CTRL in the registers. The CASCADE_EN bit
muxes the previous timer output, or possibly and external TIMER_IO pad
source, to the input clock of the selected timer instance for odd numered
timers. For the even numbered timers, the CASCADE_EN bit does not do
anything. The timer cascade input routing options are shown in TRM
"Figure 12-3224. Timers Overview". For handling beyond multiplexing, the
driver support for timer cascading should be likely be handled via the
clock framework.

The MCU timer controls are also marked as reserved for
usage by the MCU firmware.

Cc: Nishanth Menon <nm@ti.com>
Cc: Vignesh Raghavendra <vigneshr@ti.com>
Cc: Tony Lindgren <tony@atomide.com>
Signed-off-by: Udit Kumar <u-kumar1@ti.com>
---
 arch/arm64/boot/dts/ti/k3-j7200-main.dtsi     | 18 +++++++++++++++++
 .../boot/dts/ti/k3-j7200-mcu-wakeup.dtsi      | 20 +++++++++++++++++++
 2 files changed, 38 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-j7200-main.dtsi b/arch/arm64/boot/dts/ti/k3-j7200-main.dtsi
index c6b15aceea82..a9b3bf8a5c6a 100644
--- a/arch/arm64/boot/dts/ti/k3-j7200-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j7200-main.dtsi
@@ -392,6 +392,24 @@ cpts@3d000 {
 		};
 	};
 
+	/* TIMERIO pad input CTRLMMR_TIMER*_CTRL registers */
+	main_timerio_input: pinctrl@104200 {
+		compatible = "pinctrl-single";
+		reg = <0x0 0x104200 0x0 0x50>;
+		#pinctrl-cells = <1>;
+		pinctrl-single,register-width = <32>;
+		pinctrl-single,function-mask = <0x000001ff>;
+	};
+
+	/* TIMERIO pad output CTCTRLMMR_TIMERIO*_CTRL registers */
+	main_timerio_output: pinctrl@104280 {
+		compatible = "pinctrl-single";
+		reg = <0x0 0x104280 0x0 0x20>;
+		#pinctrl-cells = <1>;
+		pinctrl-single,register-width = <32>;
+		pinctrl-single,function-mask = <0x0000001f>;
+	};
+
 	main_pmx0: pinctrl@11c000 {
 		compatible = "pinctrl-single";
 		/* Proxy 0 addressing */
diff --git a/arch/arm64/boot/dts/ti/k3-j7200-mcu-wakeup.dtsi b/arch/arm64/boot/dts/ti/k3-j7200-mcu-wakeup.dtsi
index dcb6696cff17..b518ec9eea32 100644
--- a/arch/arm64/boot/dts/ti/k3-j7200-mcu-wakeup.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j7200-mcu-wakeup.dtsi
@@ -183,6 +183,26 @@ chipid@43000014 {
 		reg = <0x00 0x43000014 0x00 0x4>;
 	};
 
+	/* MCU_TIMERIO pad input CTRLMMR_MCU_TIMER*_CTRL registers */
+	mcu_timerio_input: pinctrl@40f04200 {
+		compatible = "pinctrl-single";
+		reg = <0x0 0x40f04200 0x0 0x28>;
+		#pinctrl-cells = <1>;
+		pinctrl-single,register-width = <32>;
+		pinctrl-single,function-mask = <0x0000000F>;
+		status = "reserved";
+	};
+
+	/* MCU_TIMERIO pad output CTRLMMR_MCU_TIMERIO*_CTRL registers */
+	mcu_timerio_output: pinctrl@40f04280 {
+		compatible = "pinctrl-single";
+		reg = <0x0 0x40f04280 0x0 0x28>;
+		#pinctrl-cells = <1>;
+		pinctrl-single,register-width = <32>;
+		pinctrl-single,function-mask = <0x0000000F>;
+		status = "reserved";
+	};
+
 	wkup_pmx0: pinctrl@4301c000 {
 		compatible = "pinctrl-single";
 		/* Proxy 0 addressing */
-- 
2.34.1

