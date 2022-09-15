Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DD615BA34C
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 01:36:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229991AbiIOXfK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 19:35:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229768AbiIOXeq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 19:34:46 -0400
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C4A5AE5C;
        Thu, 15 Sep 2022 16:34:45 -0700 (PDT)
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 0C90E205BB9;
        Fri, 16 Sep 2022 01:34:44 +0200 (CEST)
Received: from smtp.na-rdc02.nxp.com (usphx01srsp001v.us-phx01.nxp.com [134.27.49.11])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id BDF61205BBA;
        Fri, 16 Sep 2022 01:34:43 +0200 (CEST)
Received: from right.am.freescale.net (right.am.freescale.net [10.81.116.134])
        by usphx01srsp001v.us-phx01.nxp.com (Postfix) with ESMTP id 265AB4060A;
        Thu, 15 Sep 2022 16:34:42 -0700 (MST)
From:   Li Yang <leoyang.li@nxp.com>
To:     shawnguo@kernel.org, devicetree@vger.kernel.org
Cc:     robh+dt@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Li Yang <leoyang.li@nxp.com>,
        Zhang Ying <ying.zhang22455@nxp.com>
Subject: [PATCH v2 7/9] arm64: dts: ls1046a: add gpios based i2c recovery information
Date:   Thu, 15 Sep 2022 18:34:30 -0500
Message-Id: <20220915233432.31660-8-leoyang.li@nxp.com>
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

Add scl-gpios property for i2c recovery and add SoC specific
compatible string for SoC specific fixup.

Signed-off-by: Zhang Ying <ying.zhang22455@nxp.com>
Signed-off-by: Li Yang <leoyang.li@nxp.com>
---
 arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
index 132d7893b4b8..3d9e29824bb2 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
@@ -11,6 +11,7 @@
 #include <dt-bindings/clock/fsl,qoriq-clockgen.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/thermal/thermal.h>
+#include <dt-bindings/gpio/gpio.h>
 
 / {
 	compatible = "fsl,ls1046a";
@@ -501,7 +502,7 @@ dspi: spi@2100000 {
 		};
 
 		i2c0: i2c@2180000 {
-			compatible = "fsl,vf610-i2c";
+			compatible = "fsl,ls1046a-i2c", "fsl,vf610-i2c";
 			#address-cells = <1>;
 			#size-cells = <0>;
 			reg = <0x0 0x2180000 0x0 0x10000>;
@@ -515,35 +516,38 @@ i2c0: i2c@2180000 {
 		};
 
 		i2c1: i2c@2190000 {
-			compatible = "fsl,vf610-i2c";
+			compatible = "fsl,ls1046a-i2c", "fsl,vf610-i2c";
 			#address-cells = <1>;
 			#size-cells = <0>;
 			reg = <0x0 0x2190000 0x0 0x10000>;
 			interrupts = <GIC_SPI 57 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&clockgen QORIQ_CLK_PLATFORM_PLL
 					    QORIQ_CLK_PLL_DIV(2)>;
+			scl-gpios = <&gpio3 2 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
 			status = "disabled";
 		};
 
 		i2c2: i2c@21a0000 {
-			compatible = "fsl,vf610-i2c";
+			compatible = "fsl,ls1046a-i2c", "fsl,vf610-i2c";
 			#address-cells = <1>;
 			#size-cells = <0>;
 			reg = <0x0 0x21a0000 0x0 0x10000>;
 			interrupts = <GIC_SPI 58 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&clockgen QORIQ_CLK_PLATFORM_PLL
 					    QORIQ_CLK_PLL_DIV(2)>;
+			scl-gpios = <&gpio3 10 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
 			status = "disabled";
 		};
 
 		i2c3: i2c@21b0000 {
-			compatible = "fsl,vf610-i2c";
+			compatible = "fsl,ls1046a-i2c", "fsl,vf610-i2c";
 			#address-cells = <1>;
 			#size-cells = <0>;
 			reg = <0x0 0x21b0000 0x0 0x10000>;
 			interrupts = <GIC_SPI 59 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&clockgen QORIQ_CLK_PLATFORM_PLL
 					    QORIQ_CLK_PLL_DIV(2)>;
+			scl-gpios = <&gpio3 12 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
 			status = "disabled";
 		};
 
-- 
2.37.1

