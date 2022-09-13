Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E2805B66DB
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 06:26:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230048AbiIME03 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 00:26:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230268AbiIMEZl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 00:25:41 -0400
Received: from mx.socionext.com (mx.socionext.com [202.248.49.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1AC5458099;
        Mon, 12 Sep 2022 21:22:57 -0700 (PDT)
Received: from unknown (HELO kinkan2-ex.css.socionext.com) ([172.31.9.52])
  by mx.socionext.com with ESMTP; 13 Sep 2022 13:22:53 +0900
Received: from mail.mfilter.local (m-filter-2 [10.213.24.62])
        by kinkan2-ex.css.socionext.com (Postfix) with ESMTP id E9A142059027;
        Tue, 13 Sep 2022 13:22:53 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP; Tue, 13 Sep 2022 13:22:53 +0900
Received: from plum.e01.socionext.com (unknown [10.212.243.119])
        by kinkan2.css.socionext.com (Postfix) with ESMTP id 4CF59B62A4;
        Tue, 13 Sep 2022 13:22:53 +0900 (JST)
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
To:     soc@kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Olof Johansson <olof@lixom.net>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Subject: [PATCH v3 6/9] ARM: dts: uniphier: Add ahci controller nodes for Pro4
Date:   Tue, 13 Sep 2022 13:22:46 +0900
Message-Id: <20220913042249.4708-7-hayashi.kunihiko@socionext.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220913042249.4708-1-hayashi.kunihiko@socionext.com>
References: <20220913042249.4708-1-hayashi.kunihiko@socionext.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add ahci controller, glue layer, and clock nodes for Pro4 SoC. The glue
layer includes reset and phy, and the clock node is used for handling ahci
clocks on SoC-glue.

Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
---
 arch/arm/boot/dts/uniphier-pro4-ace.dts |  8 ++
 arch/arm/boot/dts/uniphier-pro4-ref.dts |  8 ++
 arch/arm/boot/dts/uniphier-pro4.dtsi    | 97 +++++++++++++++++++++++++
 3 files changed, 113 insertions(+)

diff --git a/arch/arm/boot/dts/uniphier-pro4-ace.dts b/arch/arm/boot/dts/uniphier-pro4-ace.dts
index 27ff2b7b9d0e..6baee4410d9c 100644
--- a/arch/arm/boot/dts/uniphier-pro4-ace.dts
+++ b/arch/arm/boot/dts/uniphier-pro4-ace.dts
@@ -99,3 +99,11 @@ &usb0 {
 &usb1 {
 	status = "okay";
 };
+
+&ahci0 {
+	status = "okay";
+};
+
+&ahci1 {
+	status = "okay";
+};
diff --git a/arch/arm/boot/dts/uniphier-pro4-ref.dts b/arch/arm/boot/dts/uniphier-pro4-ref.dts
index 48f7f23bab91..d2ce5c039865 100644
--- a/arch/arm/boot/dts/uniphier-pro4-ref.dts
+++ b/arch/arm/boot/dts/uniphier-pro4-ref.dts
@@ -108,3 +108,11 @@ nand@0 {
 		reg = <0>;
 	};
 };
+
+&ahci0 {
+	status = "okay";
+};
+
+&ahci1 {
+	status = "okay";
+};
diff --git a/arch/arm/boot/dts/uniphier-pro4.dtsi b/arch/arm/boot/dts/uniphier-pro4.dtsi
index 8cb4e7043e60..a309e64c57c8 100644
--- a/arch/arm/boot/dts/uniphier-pro4.dtsi
+++ b/arch/arm/boot/dts/uniphier-pro4.dtsi
@@ -411,6 +411,11 @@ usb_phy3: phy@3 {
 					vbus-supply = <&usb1_vbus>;
 				};
 			};
+
+			sg_clk: clock {
+				compatible = "socionext,uniphier-pro4-sg-clock";
+				#clock-cells = <1>;
+			};
 		};
 
 		soc-glue@5f900000 {
@@ -513,6 +518,98 @@ mdio: mdio {
 			};
 		};
 
+		ahci0: sata@65600000 {
+			compatible = "socionext,uniphier-pro4-ahci",
+				     "generic-ahci";
+			status = "disabled";
+			reg = <0x65600000 0x10000>;
+			interrupts = <GIC_SPI 142 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&sys_clk 12>, <&sys_clk 28>;
+			resets = <&sys_rst 12>, <&sys_rst 28>, <&ahci0_rst 3>;
+			ports-implemented = <1>;
+			phys = <&ahci0_phy>;
+			assigned-clocks = <&sg_clk 0>;
+			assigned-clock-rates = <25000000>;
+		};
+
+		sata-controller@65700000 {
+			compatible = "socionext,uniphier-pxs2-ahci-glue",
+				     "simple-mfd";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges = <0 0x65700000 0x100>;
+
+			ahci0_rst: reset-controller@0 {
+				compatible = "socionext,uniphier-pro4-ahci-reset";
+				reg = <0x0 0x4>;
+				clock-names = "gio", "link";
+				clocks = <&sys_clk 12>, <&sys_clk 28>;
+				reset-names = "gio", "link";
+				resets = <&sys_rst 12>, <&sys_rst 28>;
+				#reset-cells = <1>;
+			};
+
+			ahci0_phy: sata-phy@10 {
+				compatible = "socionext,uniphier-pro4-ahci-phy";
+				reg = <0x10 0x40>;
+				clock-names = "link", "gio";
+				clocks = <&sys_clk 28>, <&sys_clk 12>;
+				reset-names = "link", "gio", "phy",
+					      "pm", "tx", "rx";
+				resets = <&sys_rst 28>, <&sys_rst 12>,
+					 <&sys_rst 30>,
+					 <&ahci0_rst 0>, <&ahci0_rst 1>,
+					 <&ahci0_rst 2>;
+				#phy-cells = <0>;
+			};
+		};
+
+		ahci1: sata@65800000 {
+			compatible = "socionext,uniphier-pro4-ahci",
+				     "generic-ahci";
+			status = "disabled";
+			reg = <0x65800000 0x10000>;
+			interrupts = <GIC_SPI 143 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&sys_clk 12>, <&sys_clk 29>;
+			resets = <&sys_rst 12>, <&sys_rst 29>, <&ahci1_rst 3>;
+			ports-implemented = <1>;
+			phys = <&ahci1_phy>;
+			assigned-clocks = <&sg_clk 0>;
+			assigned-clock-rates = <25000000>;
+		};
+
+		sata-controller@65900000 {
+			compatible = "socionext,uniphier-pro4-ahci-glue",
+				     "simple-mfd";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges = <0 0x65900000 0x100>;
+
+			ahci1_rst: reset-controller@0 {
+				compatible = "socionext,uniphier-pro4-ahci-reset";
+				reg = <0x0 0x4>;
+				clock-names = "gio", "link";
+				clocks = <&sys_clk 12>, <&sys_clk 29>;
+				reset-names = "gio", "link";
+				resets = <&sys_rst 12>, <&sys_rst 29>;
+				#reset-cells = <1>;
+			};
+
+			ahci1_phy: sata-phy@10 {
+				compatible = "socionext,uniphier-pro4-ahci-phy";
+				reg = <0x10 0x40>;
+				clock-names = "link", "gio";
+				clocks = <&sys_clk 29>, <&sys_clk 12>;
+				reset-names = "link", "gio", "phy",
+					      "pm", "tx", "rx";
+				resets = <&sys_rst 29>, <&sys_rst 12>,
+					 <&sys_rst 30>,
+					 <&ahci1_rst 0>, <&ahci1_rst 1>,
+					 <&ahci1_rst 2>;
+				#phy-cells = <0>;
+			};
+		};
+
 		usb0: usb@65a00000 {
 			compatible = "socionext,uniphier-dwc3", "snps,dwc3";
 			status = "disabled";
-- 
2.25.1

