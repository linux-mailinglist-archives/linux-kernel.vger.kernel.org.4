Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DB245BA34F
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 01:36:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229924AbiIOXfO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 19:35:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229761AbiIOXeq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 19:34:46 -0400
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF58DA456;
        Thu, 15 Sep 2022 16:34:44 -0700 (PDT)
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 08FB6205BB1;
        Fri, 16 Sep 2022 01:34:42 +0200 (CEST)
Received: from smtp.na-rdc02.nxp.com (usphx01srsp001v.us-phx01.nxp.com [134.27.49.11])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id BBCA1205BAD;
        Fri, 16 Sep 2022 01:34:41 +0200 (CEST)
Received: from right.am.freescale.net (right.am.freescale.net [10.81.116.134])
        by usphx01srsp001v.us-phx01.nxp.com (Postfix) with ESMTP id 7EDC14060A;
        Thu, 15 Sep 2022 16:34:40 -0700 (MST)
From:   Li Yang <leoyang.li@nxp.com>
To:     shawnguo@kernel.org, devicetree@vger.kernel.org
Cc:     robh+dt@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Li Yang <leoyang.li@nxp.com>,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>
Subject: [PATCH v2 5/9] arm64: dts: ls1046a: make dma-coherent global to the SoC
Date:   Thu, 15 Sep 2022 18:34:28 -0500
Message-Id: <20220915233432.31660-6-leoyang.li@nxp.com>
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

These SoCs are really completely dma coherent in their entirety so add
the dma-coherent property at the soc level in the device tree and drop
the instances where it's specifically added to a few select devices.

Signed-off-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>
Signed-off-by: Li Yang <leoyang.li@nxp.com>
---
 arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
index 27033c558e3e..e406499a26b4 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
@@ -273,6 +273,7 @@ soc: soc {
 		#size-cells = <2>;
 		ranges;
 		dma-ranges = <0x0 0x0 0x0 0x0 0x10000 0x00000000>;
+		dma-coherent;
 
 		ddr: memory-controller@1080000 {
 			compatible = "fsl,qoriq-memory-controller";
@@ -355,7 +356,6 @@ crypto: crypto@1700000 {
 			ranges = <0x0 0x00 0x1700000 0x100000>;
 			reg = <0x00 0x1700000 0x0 0x100000>;
 			interrupts = <GIC_SPI 75 IRQ_TYPE_LEVEL_HIGH>;
-			dma-coherent;
 
 			sec_jr0: jr@10000 {
 				compatible = "fsl,sec-v5.4-job-ring",
@@ -794,7 +794,6 @@ pcie1: pcie@3400000 {
 			#address-cells = <3>;
 			#size-cells = <2>;
 			device_type = "pci";
-			dma-coherent;
 			num-viewport = <8>;
 			bus-range = <0x0 0xff>;
 			ranges = <0x81000000 0x0 0x00000000 0x40 0x00010000 0x0 0x00010000   /* downstream I/O */
@@ -834,7 +833,6 @@ pcie2: pcie@3500000 {
 			#address-cells = <3>;
 			#size-cells = <2>;
 			device_type = "pci";
-			dma-coherent;
 			num-viewport = <8>;
 			bus-range = <0x0 0xff>;
 			ranges = <0x81000000 0x0 0x00000000 0x48 0x00010000 0x0 0x00010000   /* downstream I/O */
@@ -874,7 +872,6 @@ pcie3: pcie@3600000 {
 			#address-cells = <3>;
 			#size-cells = <2>;
 			device_type = "pci";
-			dma-coherent;
 			num-viewport = <8>;
 			bus-range = <0x0 0xff>;
 			ranges = <0x81000000 0x0 0x00000000 0x50 0x00010000 0x0 0x00010000   /* downstream I/O */
-- 
2.37.1

