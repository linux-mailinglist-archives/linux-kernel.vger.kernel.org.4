Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D243960EFC3
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 08:02:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234369AbiJ0GC0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 02:02:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234260AbiJ0GCH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 02:02:07 -0400
Received: from mxout1.routing.net (mxout1.routing.net [IPv6:2a03:2900:1:a::a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 609A41552F6;
        Wed, 26 Oct 2022 23:01:55 -0700 (PDT)
Received: from mxbox1.masterlogin.de (unknown [192.168.10.88])
        by mxout1.routing.net (Postfix) with ESMTP id 7B25140723;
        Thu, 27 Oct 2022 06:01:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailerdienst.de;
        s=20200217; t=1666850513;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uln4V35RcPImW46pzUuhXszDT2qiOG8FqGH36U8Pisk=;
        b=BhSXLTKRhnWCX9udAN01IKpSWcFHyUFR/qgbbREn2DzDoDlGw1pHYCht2haEqsvKlYQ05E
        S+iFQCS5DW2+0BEO/8X/4zwW5/JfqhTAr9csnqUMk9oBhAEvPEA06CyAoS1bxi29snhcXQ
        ti4JrhiK7c1yWLNSDaYMRsZUZlcGIkE=
Received: from frank-G5.. (fttx-pool-80.245.77.6.bambit.de [80.245.77.6])
        by mxbox1.masterlogin.de (Postfix) with ESMTPSA id A6B1D406D6;
        Thu, 27 Oct 2022 06:01:52 +0000 (UTC)
From:   Frank Wunderlich <linux@fw-web.de>
To:     linux-mediatek@lists.infradead.org
Cc:     Frank Wunderlich <frank-w@public-files.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Sam Shih <sam.shih@mediatek.com>,
        Jieyy Yang <jieyy.yang@mediatek.com>
Subject: [PATCH v1 1/2] arm64: dts: mt7986: add pcie related device nodes
Date:   Thu, 27 Oct 2022 08:01:41 +0200
Message-Id: <20221027060142.6354-2-linux@fw-web.de>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221027060142.6354-1-linux@fw-web.de>
References: <20221027060142.6354-1-linux@fw-web.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mail-ID: 4e27c71e-cb8d-40a9-8962-daf18afb8793
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sam Shih <sam.shih@mediatek.com>

This patch adds PCIe support for MT7986.

Signed-off-by: Jieyy Yang <jieyy.yang@mediatek.com>
Signed-off-by: Sam Shih <sam.shih@mediatek.com>
Signed-off-by: Frank Wunderlich <frank-w@public-files.de>

---
changes compared to sams original version:

- add clock-names to pcie node
- update clocks to new binding
---
 arch/arm64/boot/dts/mediatek/mt7986a-rfb.dts | 16 ++++++
 arch/arm64/boot/dts/mediatek/mt7986a.dtsi    | 52 ++++++++++++++++++++
 2 files changed, 68 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt7986a-rfb.dts b/arch/arm64/boot/dts/mediatek/mt7986a-rfb.dts
index c5cc7bd19dbf..1f29e6da856e 100644
--- a/arch/arm64/boot/dts/mediatek/mt7986a-rfb.dts
+++ b/arch/arm64/boot/dts/mediatek/mt7986a-rfb.dts
@@ -100,6 +100,15 @@ &mmc0 {
 	non-removable;
 	no-sd;
 	no-sdio;
+};
+
+&pcie {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pcie_pins>;
+	status = "okay";
+};
+
+&pcie_phy {
 	status = "okay";
 };
 
@@ -162,6 +171,13 @@ conf-rst {
 		};
 	};
 
+	pcie_pins: pcie-pins {
+		mux {
+			function = "pcie";
+			groups = "pcie_clk", "pcie_wake", "pcie_pereset";
+		};
+	};
+
 	spi_flash_pins: spi-flash-pins {
 		mux {
 			function = "spi";
diff --git a/arch/arm64/boot/dts/mediatek/mt7986a.dtsi b/arch/arm64/boot/dts/mediatek/mt7986a.dtsi
index a1a788db113a..eb9023857a05 100644
--- a/arch/arm64/boot/dts/mediatek/mt7986a.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt7986a.dtsi
@@ -8,6 +8,7 @@
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/clock/mt7986-clk.h>
 #include <dt-bindings/reset/mt7986-resets.h>
+#include <dt-bindings/phy/phy.h>
 
 / {
 	interrupt-parent = <&gic>;
@@ -313,6 +314,57 @@ mmc0: mmc@11230000 {
 			status = "disabled";
 		};
 
+		pcie: pcie@11280000 {
+			compatible = "mediatek,mt7986-pcie",
+				     "mediatek,mt8192-pcie";
+			device_type = "pci";
+			#address-cells = <3>;
+			#size-cells = <2>;
+			reg = <0x00 0x11280000 0x00 0x4000>;
+			reg-names = "pcie-mac";
+			interrupts = <GIC_SPI 168 IRQ_TYPE_LEVEL_HIGH>;
+			bus-range = <0x00 0xff>;
+			ranges = <0x82000000 0x00 0x20000000 0x00
+				  0x20000000 0x00 0x10000000>;
+			clocks = <&infracfg CLK_INFRA_IPCIE_PIPE_CK>,
+				 <&infracfg CLK_INFRA_IPCIE_CK>,
+				 <&infracfg CLK_INFRA_IPCIER_CK>,
+				 <&infracfg CLK_INFRA_IPCIEB_CK>;
+			clock-names = "pl_250m", "tl_26m", "peri_26m", "top_133m";
+			status = "disabled";
+
+			phys = <&pcie_port PHY_TYPE_PCIE>;
+			phy-names = "pcie-phy";
+
+			#interrupt-cells = <1>;
+			interrupt-map-mask = <0 0 0 0x7>;
+			interrupt-map = <0 0 0 1 &pcie_intc 0>,
+					<0 0 0 2 &pcie_intc 1>,
+					<0 0 0 3 &pcie_intc 2>,
+					<0 0 0 4 &pcie_intc 3>;
+			pcie_intc: interrupt-controller {
+				#address-cells = <0>;
+				#interrupt-cells = <1>;
+				interrupt-controller;
+			};
+		};
+
+		pcie_phy: t-phy@11c00000 {
+			compatible = "mediatek,mt7986-tphy",
+				     "mediatek,generic-tphy-v2";
+			#address-cells = <2>;
+			#size-cells = <2>;
+			ranges;
+			status = "disabled";
+
+			pcie_port: pcie-phy@11c00000 {
+				reg = <0 0x11c00000 0 0x20000>;
+				clocks = <&clk40m>;
+				clock-names = "ref";
+				#phy-cells = <1>;
+			};
+		};
+
 		usb_phy: t-phy@11e10000 {
 			compatible = "mediatek,mt7986-tphy",
 				     "mediatek,generic-tphy-v2";
-- 
2.34.1

