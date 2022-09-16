Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9AA95BA34D
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 01:36:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229892AbiIOXfX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 19:35:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229696AbiIOXer (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 19:34:47 -0400
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8A73D10F;
        Thu, 15 Sep 2022 16:34:45 -0700 (PDT)
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id A663E205BBF;
        Fri, 16 Sep 2022 01:34:44 +0200 (CEST)
Received: from smtp.na-rdc02.nxp.com (usphx01srsp001v.us-phx01.nxp.com [134.27.49.11])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 3EC5D205BBA;
        Fri, 16 Sep 2022 01:34:44 +0200 (CEST)
Received: from right.am.freescale.net (right.am.freescale.net [10.81.116.134])
        by usphx01srsp001v.us-phx01.nxp.com (Postfix) with ESMTP id E4C3A40AB4;
        Thu, 15 Sep 2022 16:34:42 -0700 (MST)
From:   Li Yang <leoyang.li@nxp.com>
To:     shawnguo@kernel.org, devicetree@vger.kernel.org
Cc:     robh+dt@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Li Yang <leoyang.li@nxp.com>,
        Camelia Groza <camelia.groza@nxp.com>,
        Pankaj Bansal <pankaj.bansal@nxp.com>
Subject: [PATCH v2 8/9] arm64: dts: ls1046a-qds: add mmio based mdio-mux nodes for FPGA
Date:   Thu, 15 Sep 2022 18:34:31 -0500
Message-Id: <20220915233432.31660-9-leoyang.li@nxp.com>
X-Mailer: git-send-email 2.25.1.377.g2d2118b
In-Reply-To: <20220915233432.31660-1-leoyang.li@nxp.com>
References: <20220915233432.31660-1-leoyang.li@nxp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is mmio based mdio mux function in the FPGA device on ls1046a-qds
board.  Add the mmio based mdio-mux nodes to ls1043a-qds boards and
add simple-mfd as a compatbile for the FPGA node to reflect the
multi-function nature of it.

Signed-off-by: Camelia Groza <camelia.groza@nxp.com>
Signed-off-by: Pankaj Bansal <pankaj.bansal@nxp.com>
Signed-off-by: Li Yang <leoyang.li@nxp.com>
---
 .../boot/dts/freescale/fsl-ls1046a-qds.dts    | 155 +++++++++++++++++-
 1 file changed, 153 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1046a-qds.dts b/arch/arm64/boot/dts/freescale/fsl-ls1046a-qds.dts
index eec62c63dafe..f969173fb337 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1046a-qds.dts
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1046a-qds.dts
@@ -3,7 +3,7 @@
  * Device Tree Include file for Freescale Layerscape-1046A family SoC.
  *
  * Copyright 2016 Freescale Semiconductor, Inc.
- * Copyright 2018 NXP
+ * Copyright 2018-2019 NXP
  *
  * Shaohui Xie <Shaohui.Xie@nxp.com>
  */
@@ -17,14 +17,26 @@ / {
 	compatible = "fsl,ls1046a-qds", "fsl,ls1046a";
 
 	aliases {
+		emi1-slot1 = &ls1046mdio_s1;
+		emi1-slot2 = &ls1046mdio_s2;
+		emi1-slot4 = &ls1046mdio_s4;
 		gpio0 = &gpio0;
 		gpio1 = &gpio1;
 		gpio2 = &gpio2;
 		gpio3 = &gpio3;
+		qsgmii-s2-p1 = &qsgmii_phy_s2_p1;
+		qsgmii-s2-p2 = &qsgmii_phy_s2_p2;
+		qsgmii-s2-p3 = &qsgmii_phy_s2_p3;
+		qsgmii-s2-p4 = &qsgmii_phy_s2_p4;
 		serial0 = &duart0;
 		serial1 = &duart1;
 		serial2 = &duart2;
 		serial3 = &duart3;
+		sgmii-s1-p1 = &sgmii_phy_s1_p1;
+		sgmii-s1-p2 = &sgmii_phy_s1_p2;
+		sgmii-s1-p3 = &sgmii_phy_s1_p3;
+		sgmii-s1-p4 = &sgmii_phy_s1_p4;
+		sgmii-s4-p1 = &sgmii_phy_s4_p1;
 	};
 
 	chosen {
@@ -153,8 +165,9 @@ nand@1,0 {
 	};
 
 	fpga: board-control@2,0 {
-		compatible = "fsl,ls1046aqds-fpga", "fsl,fpga-qixis";
+		compatible = "fsl,ls1046aqds-fpga", "fsl,fpga-qixis", "simple-mfd";
 		reg = <0x2 0x0 0x0000100>;
+		ranges = <0 2 0 0x100>;
 	};
 };
 
@@ -177,3 +190,141 @@ qflash0: flash@0 {
 };
 
 #include "fsl-ls1046-post.dtsi"
+
+&fman0 {
+	ethernet@e0000 {
+		phy-handle = <&qsgmii_phy_s2_p1>;
+		phy-connection-type = "sgmii";
+	};
+
+	ethernet@e2000 {
+		phy-handle = <&sgmii_phy_s4_p1>;
+		phy-connection-type = "sgmii";
+	};
+
+	ethernet@e4000 {
+		phy-handle = <&rgmii_phy1>;
+		phy-connection-type = "rgmii";
+	};
+
+	ethernet@e6000 {
+		phy-handle = <&rgmii_phy2>;
+		phy-connection-type = "rgmii";
+	};
+
+	ethernet@e8000 {
+		phy-handle = <&sgmii_phy_s1_p3>;
+		phy-connection-type = "sgmii";
+	};
+
+	ethernet@ea000 {
+		phy-handle = <&sgmii_phy_s1_p4>;
+		phy-connection-type = "sgmii";
+	};
+
+	ethernet@f0000 { /* DTSEC9/10GEC1 */
+		phy-handle = <&sgmii_phy_s1_p1>;
+		phy-connection-type = "xgmii";
+	};
+
+	ethernet@f2000 { /* DTSEC10/10GEC2 */
+		phy-handle = <&sgmii_phy_s1_p2>;
+		phy-connection-type = "xgmii";
+	};
+};
+
+&fpga {
+	#address-cells = <1>;
+	#size-cells = <1>;
+
+	mdio-mux-emi1 {
+		compatible = "mdio-mux-mmioreg", "mdio-mux";
+		mdio-parent-bus = <&mdio0>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		reg = <0x54 1>;    /* BRDCFG4 */
+		mux-mask = <0xe0>; /* EMI1 */
+
+		/* On-board RGMII1 PHY */
+		ls1046mdio0: mdio@0 {
+			reg = <0>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			rgmii_phy1: ethernet-phy@1 { /* MAC3 */
+				reg = <0x1>;
+			};
+		};
+
+		/* On-board RGMII2 PHY */
+		ls1046mdio1: mdio@1 {
+			reg = <0x20>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			rgmii_phy2: ethernet-phy@2 { /* MAC4 */
+				reg = <0x2>;
+			};
+		};
+
+		/* Slot 1 */
+		ls1046mdio_s1: mdio@2 {
+			reg = <0x40>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+
+			sgmii_phy_s1_p1: ethernet-phy@1c {
+				reg = <0x1c>;
+			};
+
+			sgmii_phy_s1_p2: ethernet-phy@1d {
+				reg = <0x1d>;
+			};
+
+			sgmii_phy_s1_p3: ethernet-phy@1e {
+				reg = <0x1e>;
+			};
+
+			sgmii_phy_s1_p4: ethernet-phy@1f {
+				reg = <0x1f>;
+			};
+		};
+
+		/* Slot 2 */
+		ls1046mdio_s2: mdio@3 {
+			reg = <0x60>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+
+			qsgmii_phy_s2_p1: ethernet-phy@8 {
+				reg = <0x8>;
+			};
+
+			qsgmii_phy_s2_p2: ethernet-phy@9 {
+				reg = <0x9>;
+			};
+
+			qsgmii_phy_s2_p3: ethernet-phy@a {
+				reg = <0xa>;
+			};
+
+			qsgmii_phy_s2_p4: ethernet-phy@b {
+				reg = <0xb>;
+			};
+		};
+
+		/* Slot 4 */
+		ls1046mdio_s4: mdio@5 {
+			reg = <0x80>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+
+			sgmii_phy_s4_p1: ethernet-phy@1c {
+				reg = <0x1c>;
+			};
+		};
+	};
+};
-- 
2.37.1

