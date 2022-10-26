Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB4EE60DE48
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 11:37:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233431AbiJZJhd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 05:37:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233365AbiJZJhG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 05:37:06 -0400
Received: from mxout2.routing.net (mxout2.routing.net [IPv6:2a03:2900:1:a::b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DC3CB87B5;
        Wed, 26 Oct 2022 02:37:04 -0700 (PDT)
Received: from mxbox4.masterlogin.de (unknown [192.168.10.79])
        by mxout2.routing.net (Postfix) with ESMTP id 8A56F61916;
        Wed, 26 Oct 2022 09:37:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailerdienst.de;
        s=20200217; t=1666777023;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4054z3WmrXLjwEDQezr4htc5YT1t0re5zBkfawFOcfc=;
        b=W282V9Bf1ejSdHX/0C4BqJwFVYUdAezOPRn6QESMgJ2C0czrLVSfOD2q/OENpeimOwn2cY
        eY5zms8wB6TFK0D2FZeujYGtDlLz0CC7THpZvKKOprZZIMUm+Ojp8YBHxPS/HIL0btJ2U2
        aha2uaB+YkXzxfZPAJtOgrLaPXprkDU=
Received: from frank-G5.. (fttx-pool-80.245.72.174.bambit.de [80.245.72.174])
        by mxbox4.masterlogin.de (Postfix) with ESMTPSA id BC1138026C;
        Wed, 26 Oct 2022 09:37:02 +0000 (UTC)
From:   Frank Wunderlich <linux@fw-web.de>
To:     linux-mediatek@lists.infradead.org
Cc:     Frank Wunderlich <frank-w@public-files.de>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Sam Shih <sam.shih@mediatek.com>
Subject: [RFC v2 5/7] arm64: dts: mt7986: add mmc related device nodes
Date:   Wed, 26 Oct 2022 11:36:48 +0200
Message-Id: <20221026093650.110290-6-linux@fw-web.de>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221026093650.110290-1-linux@fw-web.de>
References: <20221026093650.110290-1-linux@fw-web.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mail-ID: c6edbe6a-b290-41a5-bcc9-bd9d874071a6
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sam Shih <sam.shih@mediatek.com>

This patch adds mmc support for MT7986.

Signed-off-by: Sam Shih <sam.shih@mediatek.com>
Signed-off-by: Frank Wunderlich <frank-w@public-files.de>

v2:
- update mmc-node because clocks changed
---
 arch/arm64/boot/dts/mediatek/mt7986a-rfb.dts | 85 ++++++++++++++++++++
 arch/arm64/boot/dts/mediatek/mt7986a.dtsi    | 15 ++++
 2 files changed, 100 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt7986a-rfb.dts b/arch/arm64/boot/dts/mediatek/mt7986a-rfb.dts
index 2b5d7ea31b4d..c5cc7bd19dbf 100644
--- a/arch/arm64/boot/dts/mediatek/mt7986a-rfb.dts
+++ b/arch/arm64/boot/dts/mediatek/mt7986a-rfb.dts
@@ -24,6 +24,15 @@ memory@40000000 {
 		reg = <0 0x40000000 0 0x40000000>;
 	};
 
+	reg_1p8v: regulator-1p8v {
+		compatible = "regulator-fixed";
+		regulator-name = "fixed-1.8V";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+		regulator-boot-on;
+		regulator-always-on;
+	};
+
 	reg_3p3v: regulator-3p3v {
 		compatible = "regulator-fixed";
 		regulator-name = "fixed-3.3V";
@@ -76,7 +85,83 @@ switch: switch@0 {
 	};
 };
 
+&mmc0 {
+	pinctrl-names = "default", "state_uhs";
+	pinctrl-0 = <&mmc0_pins_default>;
+	pinctrl-1 = <&mmc0_pins_uhs>;
+	bus-width = <8>;
+	max-frequency = <200000000>;
+	cap-mmc-highspeed;
+	mmc-hs200-1_8v;
+	mmc-hs400-1_8v;
+	hs400-ds-delay = <0x14014>;
+	vmmc-supply = <&reg_3p3v>;
+	vqmmc-supply = <&reg_1p8v>;
+	non-removable;
+	no-sd;
+	no-sdio;
+	status = "okay";
+};
+
 &pio {
+	mmc0_pins_default: mmc0-pins {
+		mux {
+			function = "emmc";
+			groups = "emmc_51";
+		};
+		conf-cmd-dat {
+			pins = "EMMC_DATA_0", "EMMC_DATA_1", "EMMC_DATA_2",
+			       "EMMC_DATA_3", "EMMC_DATA_4", "EMMC_DATA_5",
+			       "EMMC_DATA_6", "EMMC_DATA_7", "EMMC_CMD";
+			input-enable;
+			drive-strength = <4>;
+			mediatek,pull-up-adv = <1>;	/* pull-up 10K */
+		};
+		conf-clk {
+			pins = "EMMC_CK";
+			drive-strength = <6>;
+			mediatek,pull-down-adv = <2>;	/* pull-down 50K */
+		};
+		conf-ds {
+			pins = "EMMC_DSL";
+			mediatek,pull-down-adv = <2>;	/* pull-down 50K */
+		};
+		conf-rst {
+			pins = "EMMC_RSTB";
+			drive-strength = <4>;
+			mediatek,pull-up-adv = <1>;	/* pull-up 10K */
+		};
+	};
+
+	mmc0_pins_uhs: mmc0-uhs-pins {
+		mux {
+			function = "emmc";
+			groups = "emmc_51";
+		};
+		conf-cmd-dat {
+			pins = "EMMC_DATA_0", "EMMC_DATA_1", "EMMC_DATA_2",
+			       "EMMC_DATA_3", "EMMC_DATA_4", "EMMC_DATA_5",
+			       "EMMC_DATA_6", "EMMC_DATA_7", "EMMC_CMD";
+			input-enable;
+			drive-strength = <4>;
+			mediatek,pull-up-adv = <1>;	/* pull-up 10K */
+		};
+		conf-clk {
+			pins = "EMMC_CK";
+			drive-strength = <6>;
+			mediatek,pull-down-adv = <2>;	/* pull-down 50K */
+		};
+		conf-ds {
+			pins = "EMMC_DSL";
+			mediatek,pull-down-adv = <2>;	/* pull-down 50K */
+		};
+		conf-rst {
+			pins = "EMMC_RSTB";
+			drive-strength = <4>;
+			mediatek,pull-up-adv = <1>;	/* pull-up 10K */
+		};
+	};
+
 	spi_flash_pins: spi-flash-pins {
 		mux {
 			function = "spi";
diff --git a/arch/arm64/boot/dts/mediatek/mt7986a.dtsi b/arch/arm64/boot/dts/mediatek/mt7986a.dtsi
index 1c7a973c28ca..32c26b239ae6 100644
--- a/arch/arm64/boot/dts/mediatek/mt7986a.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt7986a.dtsi
@@ -284,6 +284,21 @@ ssusb: usb@11200000 {
 			status = "disabled";
 		};
 
+		mmc0: mmc@11230000 {
+			compatible = "mediatek,mt7986-mmc";
+			reg = <0 0x11230000 0 0x1000>,
+			      <0 0x11c20000 0 0x1000>;
+			interrupts = <GIC_SPI 143 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&topckgen CLK_TOP_EMMC_416M_SEL>,
+				 <&infracfg CLK_INFRA_MSDC_HCK_CK>,
+				 <&infracfg CLK_INFRA_MSDC_CK>,
+				 <&infracfg CLK_INFRA_MSDC_133M_CK>,
+				 <&infracfg CLK_INFRA_MSDC_66M_CK>;
+			clock-names = "source", "hclk", "source_cg", "bus_clk",
+				      "sys_cg";
+			status = "disabled";
+		};
+
 		usb_phy: t-phy@11e10000 {
 			compatible = "mediatek,mt7986-tphy",
 				     "mediatek,generic-tphy-v2";
-- 
2.34.1

