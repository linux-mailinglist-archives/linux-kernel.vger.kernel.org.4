Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6A416034BF
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 23:16:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230376AbiJRVQK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 17:16:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230292AbiJRVPu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 17:15:50 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBC6497EEC;
        Tue, 18 Oct 2022 14:15:49 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 29ILFZsA108201;
        Tue, 18 Oct 2022 16:15:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1666127735;
        bh=gTQ4B39bfCOAR51Vjp8Il96QxRTSl3I2LdM3FOs7Vmc=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=g58nKVg/EylAFMX/iaWIK+QnE1VXF+tFWuxKg4mgt6bTleX8t02t8rMGqwchl6TFH
         UIeUWCj1ZQYTVBv5NpeRTBiho0bW+npoK5lLT4GImnVm1lzDpOOlHY4fSjNm5sDsT1
         aeW2UgbJyZcBVYY8iwFmRwOO2BdJRG6ndrhX9sx4=
Received: from DFLE106.ent.ti.com (dfle106.ent.ti.com [10.64.6.27])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 29ILFZT3051875
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 18 Oct 2022 16:15:35 -0500
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6; Tue, 18
 Oct 2022 16:15:35 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6 via
 Frontend Transport; Tue, 18 Oct 2022 16:15:35 -0500
Received: from ula0226330.dal.design.ti.com (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 29ILFXoC014456;
        Tue, 18 Oct 2022 16:15:35 -0500
From:   Andrew Davis <afd@ti.com>
To:     Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bryan Brattlof <bb@ti.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Andrew Davis <afd@ti.com>
Subject: [PATCH 02/10] arm64: dts: ti: k3-am62: Enable I2C nodes at the board level
Date:   Tue, 18 Oct 2022 16:15:25 -0500
Message-ID: <20221018211533.21335-3-afd@ti.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221018211533.21335-1-afd@ti.com>
References: <20221018211533.21335-1-afd@ti.com>
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

I2C nodes defined in the top-level AM62x SoC dtsi files are incomplete
and will not be functional unless they are extended with pinmux
information.

As the pinmux is only known at the board integration level, these
nodes should only be enabled when provided with this information.

Disable the I2C nodes in the dtsi files and only enable the ones that
are actually pinned out on a given board.

Signed-off-by: Andrew Davis <afd@ti.com>
---
 arch/arm64/boot/dts/ti/k3-am62-main.dtsi   |  4 ++++
 arch/arm64/boot/dts/ti/k3-am62-mcu.dtsi    |  1 +
 arch/arm64/boot/dts/ti/k3-am62-wakeup.dtsi |  1 +
 arch/arm64/boot/dts/ti/k3-am625-sk.dts     | 18 ++----------------
 4 files changed, 8 insertions(+), 16 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-am62-main.dtsi b/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
index f6f8ccdb5f55..295c9bb22e7d 100644
--- a/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
@@ -271,6 +271,7 @@ main_i2c0: i2c@20000000 {
 		power-domains = <&k3_pds 102 TI_SCI_PD_EXCLUSIVE>;
 		clocks = <&k3_clks 102 2>;
 		clock-names = "fck";
+		status = "disabled";
 	};
 
 	main_i2c1: i2c@20010000 {
@@ -282,6 +283,7 @@ main_i2c1: i2c@20010000 {
 		power-domains = <&k3_pds 103 TI_SCI_PD_EXCLUSIVE>;
 		clocks = <&k3_clks 103 2>;
 		clock-names = "fck";
+		status = "disabled";
 	};
 
 	main_i2c2: i2c@20020000 {
@@ -293,6 +295,7 @@ main_i2c2: i2c@20020000 {
 		power-domains = <&k3_pds 104 TI_SCI_PD_EXCLUSIVE>;
 		clocks = <&k3_clks 104 2>;
 		clock-names = "fck";
+		status = "disabled";
 	};
 
 	main_i2c3: i2c@20030000 {
@@ -304,6 +307,7 @@ main_i2c3: i2c@20030000 {
 		power-domains = <&k3_pds 105 TI_SCI_PD_EXCLUSIVE>;
 		clocks = <&k3_clks 105 2>;
 		clock-names = "fck";
+		status = "disabled";
 	};
 
 	main_spi0: spi@20100000 {
diff --git a/arch/arm64/boot/dts/ti/k3-am62-mcu.dtsi b/arch/arm64/boot/dts/ti/k3-am62-mcu.dtsi
index 8dff39723628..7f715ebe8e24 100644
--- a/arch/arm64/boot/dts/ti/k3-am62-mcu.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62-mcu.dtsi
@@ -33,6 +33,7 @@ mcu_i2c0: i2c@4900000 {
 		power-domains = <&k3_pds 106 TI_SCI_PD_EXCLUSIVE>;
 		clocks = <&k3_clks 106 2>;
 		clock-names = "fck";
+		status = "disabled";
 	};
 
 	mcu_spi0: spi@4b00000 {
diff --git a/arch/arm64/boot/dts/ti/k3-am62-wakeup.dtsi b/arch/arm64/boot/dts/ti/k3-am62-wakeup.dtsi
index 94cfc549f644..ff936d547c99 100644
--- a/arch/arm64/boot/dts/ti/k3-am62-wakeup.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62-wakeup.dtsi
@@ -38,5 +38,6 @@ wkup_i2c0: i2c@2b200000 {
 		power-domains = <&k3_pds 107 TI_SCI_PD_EXCLUSIVE>;
 		clocks = <&k3_clks 107 4>;
 		clock-names = "fck";
+		status = "disabled";
 	};
 };
diff --git a/arch/arm64/boot/dts/ti/k3-am625-sk.dts b/arch/arm64/boot/dts/ti/k3-am625-sk.dts
index 0c7b25213e97..c280d6c00412 100644
--- a/arch/arm64/boot/dts/ti/k3-am625-sk.dts
+++ b/arch/arm64/boot/dts/ti/k3-am625-sk.dts
@@ -293,21 +293,15 @@ &main_uart1 {
 	status = "reserved";
 };
 
-&mcu_i2c0 {
-	status = "disabled";
-};
-
-&wkup_i2c0 {
-	status = "disabled";
-};
-
 &main_i2c0 {
+	status = "okay";
 	pinctrl-names = "default";
 	pinctrl-0 = <&main_i2c0_pins_default>;
 	clock-frequency = <400000>;
 };
 
 &main_i2c1 {
+	status = "okay";
 	pinctrl-names = "default";
 	pinctrl-0 = <&main_i2c1_pins_default>;
 	clock-frequency = <400000>;
@@ -340,14 +334,6 @@ exp1: gpio@22 {
 	};
 };
 
-&main_i2c2 {
-	status = "disabled";
-};
-
-&main_i2c3 {
-	status = "disabled";
-};
-
 &sdhci0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&main_mmc0_pins_default>;
-- 
2.37.3

