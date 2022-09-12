Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C84F5B552C
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 09:17:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229629AbiILHRj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 03:17:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229978AbiILHQz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 03:16:55 -0400
Received: from mx.socionext.com (mx.socionext.com [202.248.49.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 874FD2ED6E;
        Mon, 12 Sep 2022 00:16:04 -0700 (PDT)
Received: from unknown (HELO iyokan2-ex.css.socionext.com) ([172.31.9.54])
  by mx.socionext.com with ESMTP; 12 Sep 2022 16:15:58 +0900
Received: from mail.mfilter.local (m-filter-2 [10.213.24.62])
        by iyokan2-ex.css.socionext.com (Postfix) with ESMTP id B093820584CE;
        Mon, 12 Sep 2022 16:15:58 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP; Mon, 12 Sep 2022 16:15:58 +0900
Received: from plum.e01.socionext.com (unknown [10.212.243.119])
        by kinkan2.css.socionext.com (Postfix) with ESMTP id 5FF38B62AE;
        Mon, 12 Sep 2022 16:15:58 +0900 (JST)
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
To:     soc@kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Olof Johansson <olof@lixom.net>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Subject: [PATCH v2 5/9] arm64: dts: uniphier: Add ahci controller and glue layer nodes for PXs3
Date:   Mon, 12 Sep 2022 16:15:50 +0900
Message-Id: <20220912071554.1480-6-hayashi.kunihiko@socionext.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220912071554.1480-1-hayashi.kunihiko@socionext.com>
References: <20220912071554.1480-1-hayashi.kunihiko@socionext.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add ahci controller and glue layer nodes including reset and phy.
This supports for PXs3 and the boards.

Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
---
 .../boot/dts/socionext/uniphier-pxs3-ref.dts  |  8 ++
 .../boot/dts/socionext/uniphier-pxs3.dtsi     | 80 +++++++++++++++++++
 2 files changed, 88 insertions(+)

diff --git a/arch/arm64/boot/dts/socionext/uniphier-pxs3-ref.dts b/arch/arm64/boot/dts/socionext/uniphier-pxs3-ref.dts
index 506c7b9ff50d..1ced6190ab2b 100644
--- a/arch/arm64/boot/dts/socionext/uniphier-pxs3-ref.dts
+++ b/arch/arm64/boot/dts/socionext/uniphier-pxs3-ref.dts
@@ -137,6 +137,14 @@ nand@0 {
 	};
 };
 
+&ahci0 {
+	status = "okay";
+};
+
+&ahci1 {
+	status = "okay";
+};
+
 &pinctrl_ether_rgmii {
 	tx {
 		pins = "RGMII0_TXCLK", "RGMII0_TXD0", "RGMII0_TXD1",
diff --git a/arch/arm64/boot/dts/socionext/uniphier-pxs3.dtsi b/arch/arm64/boot/dts/socionext/uniphier-pxs3.dtsi
index 7304dee2e504..f49a8db3e918 100644
--- a/arch/arm64/boot/dts/socionext/uniphier-pxs3.dtsi
+++ b/arch/arm64/boot/dts/socionext/uniphier-pxs3.dtsi
@@ -596,6 +596,86 @@ mdio1: mdio {
 			};
 		};
 
+		ahci0: ahci@65600000 {
+			compatible = "socionext,uniphier-pxs3-ahci",
+				     "generic-ahci";
+			status = "disabled";
+			reg = <0x65600000 0x10000>;
+			interrupts = <GIC_SPI 142 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&sys_clk 28>;
+			resets = <&sys_rst 28>, <&ahci0_rst 0>;
+			ports-implemented = <1>;
+			phys = <&ahci0_phy>;
+		};
+
+		ahci-glue@65700000 {
+			compatible = "socionext,uniphier-pxs3-ahci-glue",
+				     "simple-mfd";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges = <0 0x65700000 0x100>;
+
+			ahci0_rst: reset@0 {
+				compatible = "socionext,uniphier-pxs3-ahci-reset";
+				reg = <0x0 0x4>;
+				clock-names = "link";
+				clocks = <&sys_clk 28>;
+				reset-names = "link";
+				resets = <&sys_rst 28>;
+				#reset-cells = <1>;
+			};
+
+			ahci0_phy: phy@10 {
+				compatible = "socionext,uniphier-pxs3-ahci-phy";
+				reg = <0x10 0x10>;
+				clock-names = "link", "phy";
+				clocks = <&sys_clk 28>, <&sys_clk 30>;
+				reset-names = "link", "phy";
+				resets = <&sys_rst 28>, <&sys_rst 30>;
+				#phy-cells = <0>;
+			};
+		};
+
+		ahci1: ahci@65800000 {
+			compatible = "socionext,uniphier-pxs3-ahci",
+				     "generic-ahci";
+			status = "disabled";
+			reg = <0x65800000 0x10000>;
+			interrupts = <GIC_SPI 143 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&sys_clk 29>;
+			resets = <&sys_rst 29>, <&ahci1_rst 0>;
+			ports-implemented = <1>;
+			phys = <&ahci1_phy>;
+		};
+
+		ahci-glue@65900000 {
+			compatible = "socionext,uniphier-pxs3-ahci-glue",
+				     "simple-mfd";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges = <0 0x65900000 0x100>;
+
+			ahci1_rst: reset@0 {
+				compatible = "socionext,uniphier-pxs3-ahci-reset";
+				reg = <0x0 0x4>;
+				clock-names = "link";
+				clocks = <&sys_clk 29>;
+				reset-names = "link";
+				resets = <&sys_rst 29>;
+				#reset-cells = <1>;
+			};
+
+			ahci1_phy: phy@10 {
+				compatible = "socionext,uniphier-pxs3-ahci-phy";
+				reg = <0x10 0x10>;
+				clock-names = "link", "phy";
+				clocks = <&sys_clk 29>, <&sys_clk 30>;
+				reset-names = "link", "phy";
+				resets = <&sys_rst 29>, <&sys_rst 30>;
+				#phy-cells = <0>;
+			};
+		};
+
 		usb0: usb@65a00000 {
 			compatible = "socionext,uniphier-dwc3", "snps,dwc3";
 			status = "disabled";
-- 
2.25.1

