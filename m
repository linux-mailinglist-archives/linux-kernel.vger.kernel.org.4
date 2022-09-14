Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D9555B9046
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 23:48:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229961AbiINVr4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 17:47:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229889AbiINVr3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 17:47:29 -0400
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 764F486B52;
        Wed, 14 Sep 2022 14:47:16 -0700 (PDT)
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id CF6B2201B2D;
        Wed, 14 Sep 2022 23:47:14 +0200 (CEST)
Received: from smtp.na-rdc02.nxp.com (usphx01srsp001v.us-phx01.nxp.com [134.27.49.11])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 59DE6201AD0;
        Wed, 14 Sep 2022 23:47:14 +0200 (CEST)
Received: from right.am.freescale.net (right.am.freescale.net [10.81.116.134])
        by usphx01srsp001v.us-phx01.nxp.com (Postfix) with ESMTP id 491FE40AA3;
        Wed, 14 Sep 2022 14:47:13 -0700 (MST)
From:   Li Yang <leoyang.li@nxp.com>
To:     shawnguo@kernel.org, devicetree@vger.kernel.org
Cc:     robh+dt@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Li Yang <leoyang.li@nxp.com>
Subject: [PATCH v2 09/11] arm64: dts: ls1043a: use a pseudo-bus to constrain usb and sata dma size
Date:   Wed, 14 Sep 2022 16:47:01 -0500
Message-Id: <20220914214703.29706-10-leoyang.li@nxp.com>
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

From: Laurentiu Tudor <laurentiu.tudor@nxp.com>

Wrap the usb and sata controllers in an intermediate simple-bus and use
it to constrain the dma address size of these usb controllers to the 40
bits that they generate toward the interconnect.  This is required
because the SoC uses 48 bits address sizes and this mismatch would lead
to smmu context faults because the usb generates 40-bit addresses while
the smmu page tables are populated with 48-bit wide addresses.

Suggested-by: Robin Murphy <robin.murphy@arm.com>
Signed-off-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>
Signed-off-by: Li Yang <leoyang.li@nxp.com>
---
 .../arm64/boot/dts/freescale/fsl-ls1043a.dtsi | 92 ++++++++++---------
 1 file changed, 50 insertions(+), 42 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
index 58c55335f09c..704f72caddd3 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
@@ -816,51 +816,59 @@ QORIQ_CLK_PLL_DIV(1)>,
 					    QORIQ_CLK_PLL_DIV(1)>;
 		};
 
-		usb0: usb@2f00000 {
-			compatible = "snps,dwc3";
-			reg = <0x0 0x2f00000 0x0 0x10000>;
-			interrupts = <0 60 0x4>;
-			dr_mode = "host";
-			snps,quirk-frame-length-adjustment = <0x20>;
-			snps,dis_rxdet_inp3_quirk;
-			usb3-lpm-capable;
-			snps,incr-burst-type-adjustment = <1>, <4>, <8>, <16>;
-			status = "disabled";
-		};
+		aux_bus: aux_bus {
+			#address-cells = <2>;
+			#size-cells = <2>;
+			compatible = "simple-bus";
+			ranges;
+			dma-ranges = <0x0 0x0 0x0 0x0 0x100 0x00000000>;
+
+			usb0: usb@2f00000 {
+				compatible = "snps,dwc3";
+				reg = <0x0 0x2f00000 0x0 0x10000>;
+				interrupts = <0 60 IRQ_TYPE_LEVEL_HIGH>;
+				dr_mode = "host";
+				snps,quirk-frame-length-adjustment = <0x20>;
+				snps,dis_rxdet_inp3_quirk;
+				usb3-lpm-capable;
+				snps,incr-burst-type-adjustment = <1>, <4>, <8>, <16>;
+				status = "disabled";
+			};
 
-		usb1: usb@3000000 {
-			compatible = "snps,dwc3";
-			reg = <0x0 0x3000000 0x0 0x10000>;
-			interrupts = <0 61 0x4>;
-			dr_mode = "host";
-			snps,quirk-frame-length-adjustment = <0x20>;
-			snps,dis_rxdet_inp3_quirk;
-			usb3-lpm-capable;
-			snps,incr-burst-type-adjustment = <1>, <4>, <8>, <16>;
-			status = "disabled";
-		};
+			usb1: usb@3000000 {
+				compatible = "snps,dwc3";
+				reg = <0x0 0x3000000 0x0 0x10000>;
+				interrupts = <0 61 IRQ_TYPE_LEVEL_HIGH>;
+				dr_mode = "host";
+				snps,quirk-frame-length-adjustment = <0x20>;
+				snps,dis_rxdet_inp3_quirk;
+				usb3-lpm-capable;
+				snps,incr-burst-type-adjustment = <1>, <4>, <8>, <16>;
+				status = "disabled";
+			};
 
-		usb2: usb@3100000 {
-			compatible = "snps,dwc3";
-			reg = <0x0 0x3100000 0x0 0x10000>;
-			interrupts = <0 63 0x4>;
-			dr_mode = "host";
-			snps,quirk-frame-length-adjustment = <0x20>;
-			snps,dis_rxdet_inp3_quirk;
-			usb3-lpm-capable;
-			snps,incr-burst-type-adjustment = <1>, <4>, <8>, <16>;
-			status = "disabled";
-		};
+			usb2: usb@3100000 {
+				compatible = "snps,dwc3";
+				reg = <0x0 0x3100000 0x0 0x10000>;
+				interrupts = <0 63 IRQ_TYPE_LEVEL_HIGH>;
+				dr_mode = "host";
+				snps,quirk-frame-length-adjustment = <0x20>;
+				snps,dis_rxdet_inp3_quirk;
+				usb3-lpm-capable;
+				snps,incr-burst-type-adjustment = <1>, <4>, <8>, <16>;
+				status = "disabled";
+			};
 
-		sata: sata@3200000 {
-			compatible = "fsl,ls1043a-ahci";
-			reg = <0x0 0x3200000 0x0 0x10000>,
-				<0x0 0x20140520 0x0 0x4>;
-			reg-names = "ahci", "sata-ecc";
-			interrupts = <0 69 0x4>;
-			clocks = <&clockgen QORIQ_CLK_PLATFORM_PLL
-					    QORIQ_CLK_PLL_DIV(1)>;
-			dma-coherent;
+			sata: sata@3200000 {
+				compatible = "fsl,ls1043a-ahci";
+				reg = <0x0 0x3200000 0x0 0x10000>,
+					<0x0 0x20140520 0x0 0x4>;
+				reg-names = "ahci", "sata-ecc";
+				interrupts = <0 69 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&clockgen QORIQ_CLK_PLATFORM_PLL
+						    QORIQ_CLK_PLL_DIV(1)>;
+				dma-coherent;
+			};
 		};
 
 		msi1: msi-controller1@1571000 {
-- 
2.37.1

