Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86FC55B9044
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 23:48:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229990AbiINVsH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 17:48:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229896AbiINVra (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 17:47:30 -0400
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DB7186B5E;
        Wed, 14 Sep 2022 14:47:17 -0700 (PDT)
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 71D32201B33;
        Wed, 14 Sep 2022 23:47:15 +0200 (CEST)
Received: from smtp.na-rdc02.nxp.com (usphx01srsp001v.us-phx01.nxp.com [134.27.49.11])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 0BB6C201AD0;
        Wed, 14 Sep 2022 23:47:15 +0200 (CEST)
Received: from right.am.freescale.net (right.am.freescale.net [10.81.116.134])
        by usphx01srsp001v.us-phx01.nxp.com (Postfix) with ESMTP id 2C7DB40AA4;
        Wed, 14 Sep 2022 14:47:14 -0700 (MST)
From:   Li Yang <leoyang.li@nxp.com>
To:     shawnguo@kernel.org, devicetree@vger.kernel.org
Cc:     robh+dt@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Li Yang <leoyang.li@nxp.com>
Subject: [PATCH v2 10/11] arm64: dts: ls1043a-qds: add mmio based mdio-mux support
Date:   Wed, 14 Sep 2022 16:47:02 -0500
Message-Id: <20220914214703.29706-11-leoyang.li@nxp.com>
X-Mailer: git-send-email 2.25.1.377.g2d2118b
In-Reply-To: <20220914214703.29706-1-leoyang.li@nxp.com>
References: <20220914214703.29706-1-leoyang.li@nxp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is mmio based mdio mux function in the FPGA device on ls1043a-qds
board.  Add the mmio based mdio-mux nodes to ls1043a-qds boards and
add simple-mfd as a compatbile for the FPGA node to reflect the
multi-function nature of it.  Also connect the ethernet interfaces to
these phy interfaces.

Signed-off-by: Li Yang <leoyang.li@nxp.com>
---
 .../boot/dts/freescale/fsl-ls1043a-qds.dts    | 173 +++++++++++++++++-
 1 file changed, 171 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1043a-qds.dts b/arch/arm64/boot/dts/freescale/fsl-ls1043a-qds.dts
index fea167d222cf..9b726c2a4842 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1043a-qds.dts
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1043a-qds.dts
@@ -3,7 +3,7 @@
  * Device Tree Include file for Freescale Layerscape-1043A family SoC.
  *
  * Copyright 2014-2015 Freescale Semiconductor, Inc.
- * Copyright 2018 NXP
+ * Copyright 2018-2021 NXP
  *
  * Mingkai Hu <Mingkai.hu@freescale.com>
  */
@@ -24,6 +24,22 @@ aliases {
 		serial1 = &duart1;
 		serial2 = &duart2;
 		serial3 = &duart3;
+		sgmii-riser-s1-p1 = &sgmii_phy_s1_p1;
+		sgmii-riser-s2-p1 = &sgmii_phy_s2_p1;
+		sgmii-riser-s3-p1 = &sgmii_phy_s3_p1;
+		sgmii-riser-s4-p1 = &sgmii_phy_s4_p1;
+		qsgmii-s1-p1 = &qsgmii_phy_s1_p1;
+		qsgmii-s1-p2 = &qsgmii_phy_s1_p2;
+		qsgmii-s1-p3 = &qsgmii_phy_s1_p3;
+		qsgmii-s1-p4 = &qsgmii_phy_s1_p4;
+		qsgmii-s2-p1 = &qsgmii_phy_s2_p1;
+		qsgmii-s2-p2 = &qsgmii_phy_s2_p2;
+		qsgmii-s2-p3 = &qsgmii_phy_s2_p3;
+		qsgmii-s2-p4 = &qsgmii_phy_s2_p4;
+		emi1-slot1 = &ls1043mdio_s1;
+		emi1-slot2 = &ls1043mdio_s2;
+		emi1-slot3 = &ls1043mdio_s3;
+		emi1-slot4 = &ls1043mdio_s4;
 	};
 
 	chosen {
@@ -62,8 +78,11 @@ nand@1,0 {
 	};
 
 	fpga: board-control@2,0 {
-		compatible = "fsl,ls1043aqds-fpga", "fsl,fpga-qixis";
+		compatible = "fsl,ls1043aqds-fpga", "fsl,fpga-qixis", "simple-mfd";
 		reg = <0x2 0x0 0x0000100>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges = <0 2 0 0x100>;
 	};
 };
 
@@ -153,3 +172,153 @@ &usb0 {
 };
 
 #include "fsl-ls1043-post.dtsi"
+
+&fman0 {
+	ethernet@e0000 {
+		phy-handle = <&qsgmii_phy_s2_p1>;
+		phy-connection-type = "sgmii";
+	};
+
+	ethernet@e2000 {
+		phy-handle = <&qsgmii_phy_s2_p2>;
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
+		phy-handle = <&qsgmii_phy_s2_p3>;
+		phy-connection-type = "sgmii";
+	};
+
+	ethernet@ea000 {
+		phy-handle = <&qsgmii_phy_s2_p4>;
+		phy-connection-type = "sgmii";
+	};
+
+	ethernet@f0000 { /* DTSEC9/10GEC1 */
+		fixed-link = <1 1 10000 0 0>;
+		phy-connection-type = "xgmii";
+	};
+};
+
+&fpga {
+	mdio-mux-emi1@54 {
+		compatible = "mdio-mux-mmioreg", "mdio-mux";
+		mdio-parent-bus = <&mdio0>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		reg = <0x54 1>;    /* BRDCFG4 */
+		mux-mask = <0xe0>; /* EMI1 */
+
+		/* On-board RGMII1 PHY */
+		ls1043mdio0: mdio@0 {
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
+		ls1043mdio1: mdio@20 {
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
+		ls1043mdio_s1: mdio@40 {
+			reg = <0x40>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+
+			qsgmii_phy_s1_p1: ethernet-phy@4 {
+				reg = <0x4>;
+			};
+
+			qsgmii_phy_s1_p2: ethernet-phy@5 {
+				reg = <0x5>;
+			};
+
+			qsgmii_phy_s1_p3: ethernet-phy@6 {
+				reg = <0x6>;
+			};
+
+			qsgmii_phy_s1_p4: ethernet-phy@7 {
+				reg = <0x7>;
+			};
+
+			sgmii_phy_s1_p1: ethernet-phy@1c {
+				reg = <0x1c>;
+			};
+		};
+
+		/* Slot 2 */
+		ls1043mdio_s2: mdio@60 {
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
+
+			sgmii_phy_s2_p1: ethernet-phy@1c {
+				reg = <0x1c>;
+			};
+		};
+
+		/* Slot 3 */
+		ls1043mdio_s3: mdio@80 {
+			reg = <0x80>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+
+			sgmii_phy_s3_p1: ethernet-phy@1c {
+				reg = <0x1c>;
+			};
+		};
+
+		/* Slot 4 */
+		ls1043mdio_s4: mdio@a0 {
+			reg = <0xa0>;
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

