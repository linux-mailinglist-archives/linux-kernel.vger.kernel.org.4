Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9B385BA350
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 01:36:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229943AbiIOXfF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 19:35:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229758AbiIOXeq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 19:34:46 -0400
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEC8D9FF2;
        Thu, 15 Sep 2022 16:34:44 -0700 (PDT)
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 0E29B1A22F0;
        Fri, 16 Sep 2022 01:34:43 +0200 (CEST)
Received: from smtp.na-rdc02.nxp.com (usphx01srsp001v.us-phx01.nxp.com [134.27.49.11])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 9C4911A22E5;
        Fri, 16 Sep 2022 01:34:42 +0200 (CEST)
Received: from right.am.freescale.net (right.am.freescale.net [10.81.116.134])
        by usphx01srsp001v.us-phx01.nxp.com (Postfix) with ESMTP id 4ACA44060D;
        Thu, 15 Sep 2022 16:34:41 -0700 (MST)
From:   Li Yang <leoyang.li@nxp.com>
To:     shawnguo@kernel.org, devicetree@vger.kernel.org
Cc:     robh+dt@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Li Yang <leoyang.li@nxp.com>
Subject: [PATCH v2 6/9] arm64: dts: ls1046a: use a pseudo-bus to constrain usb and sata dma size
Date:   Thu, 15 Sep 2022 18:34:29 -0500
Message-Id: <20220915233432.31660-7-leoyang.li@nxp.com>
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
 .../arm64/boot/dts/freescale/fsl-ls1046a.dtsi | 90 ++++++++++---------
 1 file changed, 49 insertions(+), 41 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
index e406499a26b4..132d7893b4b8 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
@@ -710,47 +710,55 @@ QORIQ_CLK_PLL_DIV(2)>,
 					    QORIQ_CLK_PLL_DIV(2)>;
 		};
 
-		usb0: usb@2f00000 {
-			compatible = "snps,dwc3";
-			reg = <0x0 0x2f00000 0x0 0x10000>;
-			interrupts = <GIC_SPI 60 IRQ_TYPE_LEVEL_HIGH>;
-			dr_mode = "host";
-			snps,quirk-frame-length-adjustment = <0x20>;
-			snps,dis_rxdet_inp3_quirk;
-			snps,incr-burst-type-adjustment = <1>, <4>, <8>, <16>;
-			usb3-lpm-capable;
-		};
-
-		usb1: usb@3000000 {
-			compatible = "snps,dwc3";
-			reg = <0x0 0x3000000 0x0 0x10000>;
-			interrupts = <GIC_SPI 61 IRQ_TYPE_LEVEL_HIGH>;
-			dr_mode = "host";
-			snps,quirk-frame-length-adjustment = <0x20>;
-			snps,dis_rxdet_inp3_quirk;
-			snps,incr-burst-type-adjustment = <1>, <4>, <8>, <16>;
-			usb3-lpm-capable;
-		};
-
-		usb2: usb@3100000 {
-			compatible = "snps,dwc3";
-			reg = <0x0 0x3100000 0x0 0x10000>;
-			interrupts = <GIC_SPI 63 IRQ_TYPE_LEVEL_HIGH>;
-			dr_mode = "host";
-			snps,quirk-frame-length-adjustment = <0x20>;
-			snps,dis_rxdet_inp3_quirk;
-			snps,incr-burst-type-adjustment = <1>, <4>, <8>, <16>;
-			usb3-lpm-capable;
-		};
-
-		sata: sata@3200000 {
-			compatible = "fsl,ls1046a-ahci";
-			reg = <0x0 0x3200000 0x0 0x10000>,
-				<0x0 0x20140520 0x0 0x4>;
-			reg-names = "ahci", "sata-ecc";
-			interrupts = <GIC_SPI 69 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&clockgen QORIQ_CLK_PLATFORM_PLL
-					    QORIQ_CLK_PLL_DIV(2)>;
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
+				interrupts = <GIC_SPI 60 IRQ_TYPE_LEVEL_HIGH>;
+				dr_mode = "host";
+				snps,quirk-frame-length-adjustment = <0x20>;
+				snps,dis_rxdet_inp3_quirk;
+				snps,incr-burst-type-adjustment = <1>, <4>, <8>, <16>;
+				usb3-lpm-capable;
+			};
+
+			usb1: usb@3000000 {
+				compatible = "snps,dwc3";
+				reg = <0x0 0x3000000 0x0 0x10000>;
+				interrupts = <GIC_SPI 61 IRQ_TYPE_LEVEL_HIGH>;
+				dr_mode = "host";
+				snps,quirk-frame-length-adjustment = <0x20>;
+				snps,dis_rxdet_inp3_quirk;
+				snps,incr-burst-type-adjustment = <1>, <4>, <8>, <16>;
+				usb3-lpm-capable;
+			};
+
+			usb2: usb@3100000 {
+				compatible = "snps,dwc3";
+				reg = <0x0 0x3100000 0x0 0x10000>;
+				interrupts = <GIC_SPI 63 IRQ_TYPE_LEVEL_HIGH>;
+				dr_mode = "host";
+				snps,quirk-frame-length-adjustment = <0x20>;
+				snps,dis_rxdet_inp3_quirk;
+				snps,incr-burst-type-adjustment = <1>, <4>, <8>, <16>;
+				usb3-lpm-capable;
+			};
+
+			sata: sata@3200000 {
+				compatible = "fsl,ls1046a-ahci";
+				reg = <0x0 0x3200000 0x0 0x10000>,
+					<0x0 0x20140520 0x0 0x4>;
+				reg-names = "ahci", "sata-ecc";
+				interrupts = <GIC_SPI 69 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&clockgen QORIQ_CLK_PLATFORM_PLL
+						    QORIQ_CLK_PLL_DIV(2)>;
+			};
 		};
 
 		msi1: msi-controller@1580000 {
-- 
2.37.1

