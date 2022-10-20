Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2608B60654D
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 18:03:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230478AbiJTQDp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 12:03:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230456AbiJTQDa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 12:03:30 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 551751BA1C8;
        Thu, 20 Oct 2022 09:03:28 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 29KG3FjZ111512;
        Thu, 20 Oct 2022 11:03:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1666281795;
        bh=pZsO3amkfQ1HIHNTQQ0MJOglQVh8v3n2fb3NX/AXI3I=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=pixEbo9ZPK8K0WfOm5akyAxRl66LVuD/LUoL68vk6eRv3HxWTVbhP3ngJ3IaaGjKq
         cDEmLE36TacyYjMeY+5KyCFCPIZl4g6r9PT7cIvC8ObHyXALwHQdLfdk964TcuzxbF
         C8LbujO3sPzXTzR5IUJJ56yKnP7y0VIboz+Z5xBk=
Received: from DFLE111.ent.ti.com (dfle111.ent.ti.com [10.64.6.32])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 29KG3F2l052205
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 20 Oct 2022 11:03:15 -0500
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6; Thu, 20
 Oct 2022 11:03:15 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6 via
 Frontend Transport; Thu, 20 Oct 2022 11:03:15 -0500
Received: from ula0226330.dal.design.ti.com (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 29KG363K059665;
        Thu, 20 Oct 2022 11:03:14 -0500
From:   Andrew Davis <afd@ti.com>
To:     Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bryan Brattlof <bb@ti.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Andrew Davis <afd@ti.com>
Subject: [PATCH 12/12] arm64: dts: ti: k3-j721s2: Enable I2C nodes at the board level
Date:   Thu, 20 Oct 2022 11:03:05 -0500
Message-ID: <20221020160305.18711-13-afd@ti.com>
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

I2C nodes defined in the top-level J721s2 SoC dtsi files are incomplete
and will not be functional unless they are extended with pinmux
information.

As the pinmux is only known at the board integration level, these
nodes should only be enabled when provided with this information.

Disable the I2C nodes in the dtsi files and only enable the ones that
are actually pinned out on a given board.

Signed-off-by: Andrew Davis <afd@ti.com>
---
 .../dts/ti/k3-j721s2-common-proc-board.dts    | 24 -------------------
 arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi    |  6 +++++
 .../boot/dts/ti/k3-j721s2-mcu-wakeup.dtsi     |  3 +++
 arch/arm64/boot/dts/ti/k3-j721s2-som-p0.dtsi  |  1 +
 4 files changed, 10 insertions(+), 24 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-j721s2-common-proc-board.dts b/arch/arm64/boot/dts/ti/k3-j721s2-common-proc-board.dts
index 3f4106f76893b..a7aa6cf08acd4 100644
--- a/arch/arm64/boot/dts/ti/k3-j721s2-common-proc-board.dts
+++ b/arch/arm64/boot/dts/ti/k3-j721s2-common-proc-board.dts
@@ -261,30 +261,6 @@ exp2: gpio@22 {
 	};
 };
 
-&main_i2c1 {
-	status = "disabled";
-};
-
-&main_i2c2 {
-	status = "disabled";
-};
-
-&main_i2c3 {
-	status = "disabled";
-};
-
-&main_i2c4 {
-	status = "disabled";
-};
-
-&main_i2c5 {
-	status = "disabled";
-};
-
-&main_i2c6 {
-	status = "disabled";
-};
-
 &main_sdhci0 {
 	/* eMMC */
 	non-removable;
diff --git a/arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi b/arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi
index 1c18d6df6361a..d1ec261103761 100644
--- a/arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi
@@ -266,6 +266,7 @@ main_i2c1: i2c@2010000 {
 		clocks = <&k3_clks 215 1>;
 		clock-names = "fck";
 		power-domains = <&k3_pds 215 TI_SCI_PD_EXCLUSIVE>;
+		status = "disabled";
 	};
 
 	main_i2c2: i2c@2020000 {
@@ -277,6 +278,7 @@ main_i2c2: i2c@2020000 {
 		clocks = <&k3_clks 216 1>;
 		clock-names = "fck";
 		power-domains = <&k3_pds 216 TI_SCI_PD_EXCLUSIVE>;
+		status = "disabled";
 	};
 
 	main_i2c3: i2c@2030000 {
@@ -288,6 +290,7 @@ main_i2c3: i2c@2030000 {
 		clocks = <&k3_clks 217 1>;
 		clock-names = "fck";
 		power-domains = <&k3_pds 217 TI_SCI_PD_EXCLUSIVE>;
+		status = "disabled";
 	};
 
 	main_i2c4: i2c@2040000 {
@@ -299,6 +302,7 @@ main_i2c4: i2c@2040000 {
 		clocks = <&k3_clks 218 1>;
 		clock-names = "fck";
 		power-domains = <&k3_pds 218 TI_SCI_PD_EXCLUSIVE>;
+		status = "disabled";
 	};
 
 	main_i2c5: i2c@2050000 {
@@ -310,6 +314,7 @@ main_i2c5: i2c@2050000 {
 		clocks = <&k3_clks 219 1>;
 		clock-names = "fck";
 		power-domains = <&k3_pds 219 TI_SCI_PD_EXCLUSIVE>;
+		status = "disabled";
 	};
 
 	main_i2c6: i2c@2060000 {
@@ -321,6 +326,7 @@ main_i2c6: i2c@2060000 {
 		clocks = <&k3_clks 220 1>;
 		clock-names = "fck";
 		power-domains = <&k3_pds 220 TI_SCI_PD_EXCLUSIVE>;
+		status = "disabled";
 	};
 
 	main_sdhci0: mmc@4f80000 {
diff --git a/arch/arm64/boot/dts/ti/k3-j721s2-mcu-wakeup.dtsi b/arch/arm64/boot/dts/ti/k3-j721s2-mcu-wakeup.dtsi
index d1dd40a6e42a4..3264b8e8faea5 100644
--- a/arch/arm64/boot/dts/ti/k3-j721s2-mcu-wakeup.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j721s2-mcu-wakeup.dtsi
@@ -146,6 +146,7 @@ wkup_i2c0: i2c@42120000 {
 		clocks = <&k3_clks 223 1>;
 		clock-names = "fck";
 		power-domains = <&k3_pds 223 TI_SCI_PD_EXCLUSIVE>;
+		status = "disabled";
 	};
 
 	mcu_i2c0: i2c@40b00000 {
@@ -157,6 +158,7 @@ mcu_i2c0: i2c@40b00000 {
 		clocks = <&k3_clks 221 1>;
 		clock-names = "fck";
 		power-domains = <&k3_pds 221 TI_SCI_PD_EXCLUSIVE>;
+		status = "disabled";
 	};
 
 	mcu_i2c1: i2c@40b10000 {
@@ -168,6 +170,7 @@ mcu_i2c1: i2c@40b10000 {
 		clocks = <&k3_clks 222 1>;
 		clock-names = "fck";
 		power-domains = <&k3_pds 222 TI_SCI_PD_EXCLUSIVE>;
+		status = "disabled";
 	};
 
 	mcu_mcan0: can@40528000 {
diff --git a/arch/arm64/boot/dts/ti/k3-j721s2-som-p0.dtsi b/arch/arm64/boot/dts/ti/k3-j721s2-som-p0.dtsi
index a2cb0916e4a2f..6930efff8a5a3 100644
--- a/arch/arm64/boot/dts/ti/k3-j721s2-som-p0.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j721s2-som-p0.dtsi
@@ -56,6 +56,7 @@ J721S2_IOPAD(0x024, PIN_OUTPUT, 0) /* (Y28) MCAN16_TX */
 };
 
 &main_i2c0 {
+	status = "okay";
 	pinctrl-names = "default";
 	pinctrl-0 = <&main_i2c0_pins_default>;
 	clock-frequency = <400000>;
-- 
2.37.3

