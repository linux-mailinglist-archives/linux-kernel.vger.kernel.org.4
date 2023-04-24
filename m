Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AD896ECB48
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 13:25:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230504AbjDXLZn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 07:25:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231398AbjDXLZd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 07:25:33 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71CEF30ED;
        Mon, 24 Apr 2023 04:25:32 -0700 (PDT)
Received: from IcarusMOD.eternityproject.eu (unknown [IPv6:2001:b07:2ed:14ed:c5f8:7372:f042:90a2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 9EE7C66032BD;
        Mon, 24 Apr 2023 12:25:30 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1682335531;
        bh=dO1hZUstNQtKtr3TLhRob5mShnIqqvW0/SOx8Z1uypE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eVSNrabl+GlmepXkmf6OXM9CqTbAc8I0E9B1NIQzfec2ETKV/mzeALAnwpLU32jCT
         CXPd/UthxRWIzBxnEagKACIICl0DIOVGGcFd1MwFxvtQTwsg5Ot/fR9I0zs1T3vRfb
         kZYjIukZYWE88wVcWDP3rxnYlZsfekrsCwTLWmI4iJY0oPMTdCyC9lKZi3JrqI7S+y
         x7eYVYN761wlKn2f4NjbULxPIC6Cvvv6djjQ3EkR9XOtWkioQUa1yWehjdAFPokF3U
         dhHq9cv+ps9rcJYVQN/pgufTMRTV2Z9EXumw++yMvRQfJlu0ym6lK/BlK4PARdXAev
         tQJlTIUWvaTXg==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     matthias.bgg@gmail.com
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, kernel@collabora.com,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Subject: [PATCH v2 3/4] arm64: dts: mediatek: cherry: Configure eDP and internal display
Date:   Mon, 24 Apr 2023 13:25:22 +0200
Message-Id: <20230424112523.1436926-4-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230424112523.1436926-1-angelogioacchino.delregno@collabora.com>
References: <20230424112523.1436926-1-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the required nodes to enable the DisplayPort interface, connected
to the Embedded DisplayPort port, where we have an internal display.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 .../boot/dts/mediatek/mt8195-cherry.dtsi      | 32 +++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi b/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi
index 4229f4f7dc2f..adbda4dccdd5 100644
--- a/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi
@@ -47,6 +47,18 @@ memory@40000000 {
 		reg = <0 0x40000000 0 0x80000000>;
 	};
 
+	pp3300_disp_x: regulator-pp3300-disp-x {
+		compatible = "regulator-fixed";
+		regulator-name = "pp3300_disp_x";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		enable-active-high;
+		gpio = <&pio 55 GPIO_ACTIVE_HIGH>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&panel_fixed_pins>;
+		regulator-always-on;
+	};
+
 	/* system wide LDO 3.3V power rail */
 	pp3300_z5: regulator-pp3300-ldo-z5 {
 		compatible = "regulator-fixed";
@@ -288,6 +300,20 @@ port@1 {
 			reg = <1>;
 			edp_out: endpoint {
 				data-lanes = <0 1 2 3>;
+				remote-endpoint = <&panel_in>;
+			};
+		};
+	};
+
+	aux-bus {
+		panel {
+			compatible = "edp-panel";
+			power-supply = <&pp3300_disp_x>;
+			backlight = <&backlight_lcd0>;
+			port {
+				panel_in: endpoint {
+					remote-endpoint = <&edp_out>;
+				};
 			};
 		};
 	};
@@ -927,6 +953,12 @@ pins-cs {
 		};
 	};
 
+	panel_fixed_pins: panel-pwr-default-pins {
+		pins-vreg-en {
+			pinmux = <PINMUX_GPIO55__FUNC_GPIO55>;
+		};
+	};
+
 	pio_default: pio-default-pins {
 		pins-wifi-enable {
 			pinmux = <PINMUX_GPIO58__FUNC_GPIO58>;
-- 
2.40.0

