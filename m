Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21441718E5D
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 00:22:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230505AbjEaWWP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 18:22:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbjEaWWL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 18:22:11 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3AFD9D;
        Wed, 31 May 2023 15:22:09 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 34VLWMMq099106;
        Wed, 31 May 2023 16:32:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1685568742;
        bh=5WvvsLmp/AqRDQdpfpvuLdiTsHTP4d1sVxZCw8P+T3g=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=HKM5ec0SqCfGZxLZUuX+HDGLSZA+n3IOqtH3M+ow6TSDXr/T97IVsSJ5vLqRvCM4v
         baeah/CncCBxn5WyzqyiI5wit0RL/Kyky8Ejv5KC5WnXYsFfyVOUhXwB4GgkEM7VAU
         0asxwB9dVL6dAXrUOzeFPiz7SPo/rIgTR/8teCpk=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 34VLWMNS025456
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 31 May 2023 16:32:22 -0500
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 31
 May 2023 16:32:22 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 31 May 2023 16:32:22 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 34VLWMK7105112;
        Wed, 31 May 2023 16:32:22 -0500
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
Subject: [PATCH 6/6] arm64: dts: ti: k3-j784s4: Configure pinctrl for timer IO
Date:   Wed, 31 May 2023 16:32:15 -0500
Message-ID: <20230531213215.602395-7-nm@ti.com>
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

There are timer IO pads in the MCU domain, and in the MAIN domain.
These pads can be muxed for the related timers.

The details of the multiplexing can be found in the register
documentation and Technical Reference Manual[1].

These are similar to J721e/J7200, but have different mux capabilities.

[1] http://www.ti.com/lit/zip/spruj52

Signed-off-by: Nishanth Menon <nm@ti.com>
---
 arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi    | 18 +++++++++++++++
 .../boot/dts/ti/k3-j784s4-mcu-wakeup.dtsi     | 22 +++++++++++++++++++
 2 files changed, 40 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi b/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi
index f2ddd79f748d..7784278755a8 100644
--- a/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi
@@ -72,6 +72,24 @@ main_pmx0: pinctrl@11c000 {
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
 	main_crypto: crypto@4e00000 {
 		compatible = "ti,j721e-sa2ul";
 		reg = <0x00 0x4e00000 0x00 0x1200>;
diff --git a/arch/arm64/boot/dts/ti/k3-j784s4-mcu-wakeup.dtsi b/arch/arm64/boot/dts/ti/k3-j784s4-mcu-wakeup.dtsi
index 8623937e9506..4720d89ab4d7 100644
--- a/arch/arm64/boot/dts/ti/k3-j784s4-mcu-wakeup.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j784s4-mcu-wakeup.dtsi
@@ -83,6 +83,28 @@ wkup_gpio_intr: interrupt-controller@42200000 {
 		ti,interrupt-ranges = <16 928 16>;
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
 	mcu_conf: syscon@40f00000 {
 		compatible = "ti,j721e-system-controller", "syscon", "simple-mfd";
 		reg = <0x00 0x40f00000 0x00 0x20000>;
-- 
2.40.0

