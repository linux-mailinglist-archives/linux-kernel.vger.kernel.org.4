Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0B91606552
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 18:04:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231158AbiJTQEU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 12:04:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230467AbiJTQDc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 12:03:32 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 681AC1BA1C8;
        Thu, 20 Oct 2022 09:03:30 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 29KG3BJK014346;
        Thu, 20 Oct 2022 11:03:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1666281791;
        bh=bbu0VTiUOlhe2xFYcmaEYSLSJFfxCD9ynmOG3OBu3no=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=NQv0NMOWjcBl5T1BDcpNfHliSRnT3RNrc0nO1Q0IBo7D0kFVnbLx0S8BtbwOcl+xa
         QwemeGHZN87i1RWm9ikmL9+MrFl3lmwG8AUrb26B5/eSZrNgAKX+TbzX8pDW4O0AdK
         DvI1pa11orUiEOk/gs7DU00Yjl6kHweOW8fE9Rpo=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 29KG3Bd2013916
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 20 Oct 2022 11:03:11 -0500
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6; Thu, 20
 Oct 2022 11:03:11 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6 via
 Frontend Transport; Thu, 20 Oct 2022 11:03:10 -0500
Received: from ula0226330.dal.design.ti.com (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 29KG363E059665;
        Thu, 20 Oct 2022 11:03:10 -0500
From:   Andrew Davis <afd@ti.com>
To:     Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bryan Brattlof <bb@ti.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Andrew Davis <afd@ti.com>
Subject: [PATCH 06/12] arm64: dts: ti: k3-j7200: Enable I2C nodes at the board level
Date:   Thu, 20 Oct 2022 11:02:59 -0500
Message-ID: <20221020160305.18711-7-afd@ti.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221020160305.18711-1-afd@ti.com>
References: <20221020160305.18711-1-afd@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I2C nodes defined in the top-level J7200 SoC dtsi files are incomplete
and will not be functional unless they are extended with pinmux
information.

As the pinmux is only known at the board integration level, these
nodes should only be enabled when provided with this information.

Disable the I2C nodes in the dtsi files and only enable the ones that
are actually pinned out on a given board.

Signed-off-by: Andrew Davis <afd@ti.com>
---
 arch/arm64/boot/dts/ti/k3-j7200-common-proc-board.dts | 2 ++
 arch/arm64/boot/dts/ti/k3-j7200-main.dtsi             | 7 +++++++
 arch/arm64/boot/dts/ti/k3-j7200-mcu-wakeup.dtsi       | 3 +++
 3 files changed, 12 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-j7200-common-proc-board.dts b/arch/arm64/boot/dts/ti/k3-j7200-common-proc-board.dts
index bc3d1831f5cda..6240856e48631 100644
--- a/arch/arm64/boot/dts/ti/k3-j7200-common-proc-board.dts
+++ b/arch/arm64/boot/dts/ti/k3-j7200-common-proc-board.dts
@@ -210,6 +210,7 @@ &cpsw_port1 {
 };
 
 &main_i2c0 {
+	status = "okay";
 	pinctrl-names = "default";
 	pinctrl-0 = <&main_i2c0_pins_default>;
 	clock-frequency = <400000>;
@@ -237,6 +238,7 @@ exp2: gpio@22 {
  * The i2c1 of the CPB (as it is labeled) is not connected to j7200.
  */
 &main_i2c1 {
+	status = "okay";
 	pinctrl-names = "default";
 	pinctrl-0 = <&main_i2c1_pins_default>;
 	clock-frequency = <400000>;
diff --git a/arch/arm64/boot/dts/ti/k3-j7200-main.dtsi b/arch/arm64/boot/dts/ti/k3-j7200-main.dtsi
index f9aefd3dbdcaf..610d042ffa1d6 100644
--- a/arch/arm64/boot/dts/ti/k3-j7200-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j7200-main.dtsi
@@ -439,6 +439,7 @@ main_i2c0: i2c@2000000 {
 		clock-names = "fck";
 		clocks = <&k3_clks 187 1>;
 		power-domains = <&k3_pds 187 TI_SCI_PD_SHARED>;
+		status = "disabled";
 	};
 
 	main_i2c1: i2c@2010000 {
@@ -450,6 +451,7 @@ main_i2c1: i2c@2010000 {
 		clock-names = "fck";
 		clocks = <&k3_clks 188 1>;
 		power-domains = <&k3_pds 188 TI_SCI_PD_EXCLUSIVE>;
+		status = "disabled";
 	};
 
 	main_i2c2: i2c@2020000 {
@@ -461,6 +463,7 @@ main_i2c2: i2c@2020000 {
 		clock-names = "fck";
 		clocks = <&k3_clks 189 1>;
 		power-domains = <&k3_pds 189 TI_SCI_PD_EXCLUSIVE>;
+		status = "disabled";
 	};
 
 	main_i2c3: i2c@2030000 {
@@ -472,6 +475,7 @@ main_i2c3: i2c@2030000 {
 		clock-names = "fck";
 		clocks = <&k3_clks 190 1>;
 		power-domains = <&k3_pds 190 TI_SCI_PD_EXCLUSIVE>;
+		status = "disabled";
 	};
 
 	main_i2c4: i2c@2040000 {
@@ -483,6 +487,7 @@ main_i2c4: i2c@2040000 {
 		clock-names = "fck";
 		clocks = <&k3_clks 191 1>;
 		power-domains = <&k3_pds 191 TI_SCI_PD_EXCLUSIVE>;
+		status = "disabled";
 	};
 
 	main_i2c5: i2c@2050000 {
@@ -494,6 +499,7 @@ main_i2c5: i2c@2050000 {
 		clock-names = "fck";
 		clocks = <&k3_clks 192 1>;
 		power-domains = <&k3_pds 192 TI_SCI_PD_EXCLUSIVE>;
+		status = "disabled";
 	};
 
 	main_i2c6: i2c@2060000 {
@@ -505,6 +511,7 @@ main_i2c6: i2c@2060000 {
 		clock-names = "fck";
 		clocks = <&k3_clks 193 1>;
 		power-domains = <&k3_pds 193 TI_SCI_PD_EXCLUSIVE>;
+		status = "disabled";
 	};
 
 	main_sdhci0: mmc@4f80000 {
diff --git a/arch/arm64/boot/dts/ti/k3-j7200-mcu-wakeup.dtsi b/arch/arm64/boot/dts/ti/k3-j7200-mcu-wakeup.dtsi
index 7c205b347f813..2006933f9b497 100644
--- a/arch/arm64/boot/dts/ti/k3-j7200-mcu-wakeup.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j7200-mcu-wakeup.dtsi
@@ -251,6 +251,7 @@ mcu_i2c0: i2c@40b00000 {
 		clock-names = "fck";
 		clocks = <&k3_clks 194 1>;
 		power-domains = <&k3_pds 194 TI_SCI_PD_EXCLUSIVE>;
+		status = "disabled";
 	};
 
 	mcu_i2c1: i2c@40b10000 {
@@ -262,6 +263,7 @@ mcu_i2c1: i2c@40b10000 {
 		clock-names = "fck";
 		clocks = <&k3_clks 195 1>;
 		power-domains = <&k3_pds 195 TI_SCI_PD_EXCLUSIVE>;
+		status = "disabled";
 	};
 
 	wkup_i2c0: i2c@42120000 {
@@ -273,6 +275,7 @@ wkup_i2c0: i2c@42120000 {
 		clock-names = "fck";
 		clocks = <&k3_clks 197 1>;
 		power-domains = <&k3_pds 197 TI_SCI_PD_SHARED>;
+		status = "disabled";
 	};
 
 	fss: syscon@47000000 {
-- 
2.37.3

