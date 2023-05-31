Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F075718D34
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 23:36:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230511AbjEaVf6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 17:35:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230319AbjEaVfo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 17:35:44 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C840F10EB;
        Wed, 31 May 2023 14:33:42 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 34VLWMB8082981;
        Wed, 31 May 2023 16:32:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1685568742;
        bh=B7kUZpcyaG86TTQJGbXFHqeSZOvOpXqDxg/IqQx9f30=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=qdlAuR6gqQojKq/uNfdaCqnc2fEc0O6lzTN9fo5tYNSUp7Fp6nj1FpYkqFpue7zLS
         9ipHrSbFrtbZ91oO4B88aUIn1QmfwbrHr7xzP/KFQQElWk2DbJO14YKjQZP4LUfQ31
         eGrYoaTDNo2zKdMnbNCbk8z6aqhTVLiGr9nEja6A=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 34VLWM5n101262
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 31 May 2023 16:32:22 -0500
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 31
 May 2023 16:32:21 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 31 May 2023 16:32:21 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 34VLWLFH094233;
        Wed, 31 May 2023 16:32:21 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Tero Kristo <kristo@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Nishanth Menon <nm@ti.com>, Udit Kumar <u-kumar1@ti.com>,
        Nitin Yadav <n-yadav@ti.com>,
        Neha Malcom Francis <n-francis@ti.com>,
        Tony Lindgren <tony@atomide.com>
Subject: [PATCH 2/6] arm64: dts: ti: k3-j721e: Configure pinctrl for timer IO
Date:   Wed, 31 May 2023 16:32:11 -0500
Message-ID: <20230531213215.602395-3-nm@ti.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230531213215.602395-1-nm@ti.com>
References: <20230531213215.602395-1-nm@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

There are timer IO pads in the MCU domain, and in the MAIN domain. These
pads can be muxed for the related timers.

There are timer IO control registers for input and output. The registers
for CTRLMMR_TIMER*_CTRL and CTRLMMR_MCU_TIMER*_CTRL are used to control
the input. The registers for CTCTRLMMR_TIMERIO*_CTRL and
CTRLMMR_MCU_TIMERIO*_CTRL the output.

The multiplexing is documented in Technical Reference Manual[1] under
"Timer IO Muxing Control Registers" and "Timer IO Muxing Control
Registers", and the "Timers Overview" chapters.

We do not expose the cascade_en bit due to the racy usage of
independent 32 bit registers in-line with the timer instantiation in
the device tree. The MCU timer controls are also marked as reserved for
usage by the MCU firmware.

[1] http://www.ti.com/lit/pdf/spruil1

Signed-off-by: Nishanth Menon <nm@ti.com>
---
 arch/arm64/boot/dts/ti/k3-j721e-main.dtsi     | 18 +++++++++++++++
 .../boot/dts/ti/k3-j721e-mcu-wakeup.dtsi      | 22 +++++++++++++++++++
 2 files changed, 40 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi b/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
index 57f888c9353e..35b943e7f5c3 100644
--- a/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
@@ -548,6 +548,24 @@ main_pmx0: pinctrl@11c000 {
 		pinctrl-single,function-mask = <0xffffffff>;
 	};
 
+	/* TIMERIO pad input CTRLMMR_TIMER*_CTRL registers */
+	main_timerio_input: pinctrl@104200 {
+		compatible = "pinctrl-single";
+		reg = <0x00 0x104200 0x00 0x50>;
+		#pinctrl-cells = <1>;
+		pinctrl-single,register-width = <32>;
+		pinctrl-single,function-mask = <0x00000007>;
+	};
+
+	/* TIMERIO pad output CTCTRLMMR_TIMERIO*_CTRL registers */
+	main_timerio_output: pinctrl@104280 {
+		compatible = "pinctrl-single";
+		reg = <0x00 0x104280 0x00 0x20>;
+		#pinctrl-cells = <1>;
+		pinctrl-single,register-width = <32>;
+		pinctrl-single,function-mask = <0x0000001f>;
+	};
+
 	serdes_wiz0: wiz@5000000 {
 		compatible = "ti,j721e-wiz-16g";
 		#address-cells = <1>;
diff --git a/arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi b/arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi
index 053c771129d6..3b4295eab6f6 100644
--- a/arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi
@@ -62,6 +62,28 @@ wkup_pmx0: pinctrl@4301c000 {
 		pinctrl-single,function-mask = <0xffffffff>;
 	};
 
+	/* MCU_TIMERIO pad input CTRLMMR_MCU_TIMER*_CTRL registers */
+	mcu_timerio_input: pinctrl@40f04200 {
+		compatible = "pinctrl-single";
+		reg = <0x00 0x40f04200 0x00 0x28>;
+		#pinctrl-cells = <1>;
+		pinctrl-single,register-width = <32>;
+		pinctrl-single,function-mask = <0x0000000f>;
+		/* Non-MPU Firmware usage */
+		status = "reserved";
+	};
+
+	/* MCU_TIMERIO pad output CTRLMMR_MCU_TIMERIO*_CTRL registers */
+	mcu_timerio_output: pinctrl@40f04280 {
+		compatible = "pinctrl-single";
+		reg = <0x00 0x40f04280 0x00 0x28>;
+		#pinctrl-cells = <1>;
+		pinctrl-single,register-width = <32>;
+		pinctrl-single,function-mask = <0x0000000f>;
+		/* Non-MPU Firmware usage */
+		status = "reserved";
+	};
+
 	mcu_ram: sram@41c00000 {
 		compatible = "mmio-sram";
 		reg = <0x00 0x41c00000 0x00 0x100000>;
-- 
2.40.0

