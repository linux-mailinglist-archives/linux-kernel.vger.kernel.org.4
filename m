Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D4C8606540
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 18:03:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230399AbiJTQDb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 12:03:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229832AbiJTQD1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 12:03:27 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84BCE1B233E;
        Thu, 20 Oct 2022 09:03:25 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 29KG39CL005193;
        Thu, 20 Oct 2022 11:03:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1666281789;
        bh=psSkaiJKxjpZkZVUsEF0tDT8RyFYBIHMrUMBTtkMGGo=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=AijA2Brv6uLhnIDuVpL/y/E6uX0IsiGXWd1lef0bmtBKU8r9GyJzsOV5lhpmNq5PJ
         yI00niIcGup4RSOOV4gL/9/aOZxg42QCR6Wfp37emtdzPAab26SqawI8CI9m4MM0UM
         iaHltL5/D6LhrWNZWhgaOYeC7nJsT7LLJHKr/p6c=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 29KG39at052151
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 20 Oct 2022 11:03:09 -0500
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6; Thu, 20
 Oct 2022 11:03:09 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6 via
 Frontend Transport; Thu, 20 Oct 2022 11:03:08 -0500
Received: from ula0226330.dal.design.ti.com (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 29KG363B059665;
        Thu, 20 Oct 2022 11:03:08 -0500
From:   Andrew Davis <afd@ti.com>
To:     Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bryan Brattlof <bb@ti.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Andrew Davis <afd@ti.com>
Subject: [PATCH 03/12] arm64: dts: ti: k3-j721e: Enable MCASP nodes at the board level
Date:   Thu, 20 Oct 2022 11:02:56 -0500
Message-ID: <20221020160305.18711-4-afd@ti.com>
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

MCASP nodes defined in the top-level J721e SoC dtsi files are incomplete
and may not be functional unless they are extended with pinmux
information.

As the pinmux is only known at the board integration level, these
nodes should only be enabled when provided with this information.

Disable the MCASP nodes in the dtsi files and only enable the ones that
are actually pinned out on a given board.

Signed-off-by: Andrew Davis <afd@ti.com>
---
 .../dts/ti/k3-j721e-common-proc-board.dts     | 45 +-------------
 arch/arm64/boot/dts/ti/k3-j721e-main.dtsi     | 12 ++++
 arch/arm64/boot/dts/ti/k3-j721e-sk.dts        | 60 -------------------
 3 files changed, 13 insertions(+), 104 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dts b/arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dts
index 24e9db563b234..6cee708e0d170 100644
--- a/arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dts
+++ b/arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dts
@@ -709,47 +709,8 @@ dp0_out: endpoint {
 	};
 };
 
-&mcasp0 {
-	status = "disabled";
-};
-
-&mcasp1 {
-	status = "disabled";
-};
-
-&mcasp2 {
-	status = "disabled";
-};
-
-&mcasp3 {
-	status = "disabled";
-};
-
-&mcasp4 {
-	status = "disabled";
-};
-
-&mcasp5 {
-	status = "disabled";
-};
-
-&mcasp6 {
-	status = "disabled";
-};
-
-&mcasp7 {
-	status = "disabled";
-};
-
-&mcasp8 {
-	status = "disabled";
-};
-
-&mcasp9 {
-	status = "disabled";
-};
-
 &mcasp10 {
+	status = "okay";
 	#sound-dai-cells = <0>;
 
 	pinctrl-names = "default";
@@ -767,10 +728,6 @@ &mcasp10 {
 	rx-num-evt = <0>;
 };
 
-&mcasp11 {
-	status = "disabled";
-};
-
 &cmn_refclk1 {
 	clock-frequency = <100000000>;
 };
diff --git a/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi b/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
index 61bba78ce354e..3706b319c46c6 100644
--- a/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
@@ -1425,6 +1425,7 @@ mcasp0: mcasp@2b00000 {
 		clocks = <&k3_clks 174 1>;
 		clock-names = "fck";
 		power-domains = <&k3_pds 174 TI_SCI_PD_EXCLUSIVE>;
+		status = "disabled";
 	};
 
 	mcasp1: mcasp@2b10000 {
@@ -1442,6 +1443,7 @@ mcasp1: mcasp@2b10000 {
 		clocks = <&k3_clks 175 1>;
 		clock-names = "fck";
 		power-domains = <&k3_pds 175 TI_SCI_PD_EXCLUSIVE>;
+		status = "disabled";
 	};
 
 	mcasp2: mcasp@2b20000 {
@@ -1459,6 +1461,7 @@ mcasp2: mcasp@2b20000 {
 		clocks = <&k3_clks 176 1>;
 		clock-names = "fck";
 		power-domains = <&k3_pds 176 TI_SCI_PD_EXCLUSIVE>;
+		status = "disabled";
 	};
 
 	mcasp3: mcasp@2b30000 {
@@ -1476,6 +1479,7 @@ mcasp3: mcasp@2b30000 {
 		clocks = <&k3_clks 177 1>;
 		clock-names = "fck";
 		power-domains = <&k3_pds 177 TI_SCI_PD_EXCLUSIVE>;
+		status = "disabled";
 	};
 
 	mcasp4: mcasp@2b40000 {
@@ -1493,6 +1497,7 @@ mcasp4: mcasp@2b40000 {
 		clocks = <&k3_clks 178 1>;
 		clock-names = "fck";
 		power-domains = <&k3_pds 178 TI_SCI_PD_EXCLUSIVE>;
+		status = "disabled";
 	};
 
 	mcasp5: mcasp@2b50000 {
@@ -1510,6 +1515,7 @@ mcasp5: mcasp@2b50000 {
 		clocks = <&k3_clks 179 1>;
 		clock-names = "fck";
 		power-domains = <&k3_pds 179 TI_SCI_PD_EXCLUSIVE>;
+		status = "disabled";
 	};
 
 	mcasp6: mcasp@2b60000 {
@@ -1527,6 +1533,7 @@ mcasp6: mcasp@2b60000 {
 		clocks = <&k3_clks 180 1>;
 		clock-names = "fck";
 		power-domains = <&k3_pds 180 TI_SCI_PD_EXCLUSIVE>;
+		status = "disabled";
 	};
 
 	mcasp7: mcasp@2b70000 {
@@ -1544,6 +1551,7 @@ mcasp7: mcasp@2b70000 {
 		clocks = <&k3_clks 181 1>;
 		clock-names = "fck";
 		power-domains = <&k3_pds 181 TI_SCI_PD_EXCLUSIVE>;
+		status = "disabled";
 	};
 
 	mcasp8: mcasp@2b80000 {
@@ -1561,6 +1569,7 @@ mcasp8: mcasp@2b80000 {
 		clocks = <&k3_clks 182 1>;
 		clock-names = "fck";
 		power-domains = <&k3_pds 182 TI_SCI_PD_EXCLUSIVE>;
+		status = "disabled";
 	};
 
 	mcasp9: mcasp@2b90000 {
@@ -1578,6 +1587,7 @@ mcasp9: mcasp@2b90000 {
 		clocks = <&k3_clks 183 1>;
 		clock-names = "fck";
 		power-domains = <&k3_pds 183 TI_SCI_PD_EXCLUSIVE>;
+		status = "disabled";
 	};
 
 	mcasp10: mcasp@2ba0000 {
@@ -1595,6 +1605,7 @@ mcasp10: mcasp@2ba0000 {
 		clocks = <&k3_clks 184 1>;
 		clock-names = "fck";
 		power-domains = <&k3_pds 184 TI_SCI_PD_EXCLUSIVE>;
+		status = "disabled";
 	};
 
 	mcasp11: mcasp@2bb0000 {
@@ -1612,6 +1623,7 @@ mcasp11: mcasp@2bb0000 {
 		clocks = <&k3_clks 185 1>;
 		clock-names = "fck";
 		power-domains = <&k3_pds 185 TI_SCI_PD_EXCLUSIVE>;
+		status = "disabled";
 	};
 
 	watchdog0: watchdog@2200000 {
diff --git a/arch/arm64/boot/dts/ti/k3-j721e-sk.dts b/arch/arm64/boot/dts/ti/k3-j721e-sk.dts
index 1d5a90d968497..b7cb34007fb68 100644
--- a/arch/arm64/boot/dts/ti/k3-j721e-sk.dts
+++ b/arch/arm64/boot/dts/ti/k3-j721e-sk.dts
@@ -796,66 +796,6 @@ dp0_out: endpoint {
 	};
 };
 
-&mcasp0 {
-	/* Unused */
-	status = "disabled";
-};
-
-&mcasp1 {
-	/* Unused */
-	status = "disabled";
-};
-
-&mcasp2 {
-	/* Unused */
-	status = "disabled";
-};
-
-&mcasp3 {
-	/* Unused */
-	status = "disabled";
-};
-
-&mcasp4 {
-	/* Unused */
-	status = "disabled";
-};
-
-&mcasp5 {
-	/* Unused */
-	status = "disabled";
-};
-
-&mcasp6 {
-	/* Brought out on RPi header */
-	status = "disabled";
-};
-
-&mcasp7 {
-	/* Unused */
-	status = "disabled";
-};
-
-&mcasp8 {
-	/* Unused */
-	status = "disabled";
-};
-
-&mcasp9 {
-	/* Unused */
-	status = "disabled";
-};
-
-&mcasp10 {
-	/* Unused */
-	status = "disabled";
-};
-
-&mcasp11 {
-	/* Brought out on M.2 E Key */
-	status = "disabled";
-};
-
 &serdes0 {
 	serdes0_pcie_link: phy@0 {
 		reg = <0>;
-- 
2.37.3

