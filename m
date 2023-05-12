Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9247D7008DB
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 15:13:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241289AbjELNNO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 09:13:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241193AbjELNMx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 09:12:53 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FABD14E58
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 06:12:08 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id ffacd0b85a97d-3063afa2372so9246382f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 06:12:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683897126; x=1686489126;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=E3Upg3aTXOSykFBuswINw2Ynr/KPWdYMePDYZ0wYPGo=;
        b=D18WqcyhsEHteDCWs+WiqPrx7Bfi9Z9vjJLQW9XSPMpl1L05XYddY4gGHzkNGgLYHk
         +frzBijkWqgPEz1j6GP3+EL3wqWndJDgFiCO0f2Ugd6/EUKZJo2Z3CUBbrwVobVww0AX
         z3LBTW5FfjrK+ugRkeD4Jn1x7ZKMDVJUZsCnkD6qLLTIzMKeoo4j5K1AqV5wvu4ZGA3u
         2+4ixIjvhAVoCs6XqBEZkf2Nv1P6CUkC0Jl4bLBYvUps+pGxsI1WqZoxSy0/XraTB1MU
         J5jqZfzRb5S/UTj/UXJNTxClmha7Pv0UR6wme/its+waC3R3ORMYzsrRMMAPlAE6as8n
         DJ2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683897126; x=1686489126;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E3Upg3aTXOSykFBuswINw2Ynr/KPWdYMePDYZ0wYPGo=;
        b=d+aNSNorLaQLgZZrQTj0NzHjt4mZXfjeh2Zn4cq55TcDZrKVD5vq7eCIMWviz4sAD+
         lbmVVSHKdsNFT+ut2BldKuuPwEmeuyoGB8/WrI8lCXUfh3RRNCy6YqM1ZkGQdblgKbNb
         a6HsJhxyT6FUY8JzHiBtu1OsRuCY74Ns0tA7l9rx7JY5cVF6X6Ng8PYtndKJvOsvCAdh
         JeZVbwGmu9GGg0JzM6xtyY2DZsEEnafZKfPgfbP8wlT82paKGOPjy8OxEuiIV1lqczzL
         0w4bqQjmiq4PCKtg4PobHF/khVlE1dP0bUQs14yFrnitOynzSYsW7pCSwQRl4JPmePTD
         GbLw==
X-Gm-Message-State: AC+VfDxtYLa8NdYLf6oFY+XQya78UzcDigZ2f1Xs6wymr8xfb059V85w
        aFkwTqYk3CaHzUSbWubMsUVTpg==
X-Google-Smtp-Source: ACHHUZ4tGXsd4xDhgDdFc7lEbJoFXvqExD7Gt0l3qykkz0SpblsqEw6QIG1AIvKGoKHKnq1EofVGEQ==
X-Received: by 2002:adf:fe45:0:b0:307:cf55:a7d8 with SMTP id m5-20020adffe45000000b00307cf55a7d8mr4294187wrs.42.1683897126615;
        Fri, 12 May 2023 06:12:06 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id v10-20020a5d610a000000b0030647449730sm23461965wrt.74.2023.05.12.06.12.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 May 2023 06:12:06 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Fri, 12 May 2023 15:11:43 +0200
Subject: [PATCH v4 12/13] arm64: meson: g12-common: add the MIPI DSI nodes
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230512-amlogic-v6-4-upstream-dsi-ccf-vim3-v4-12-2592c29ea263@linaro.org>
References: <20230512-amlogic-v6-4-upstream-dsi-ccf-vim3-v4-0-2592c29ea263@linaro.org>
In-Reply-To: <20230512-amlogic-v6-4-upstream-dsi-ccf-vim3-v4-0-2592c29ea263@linaro.org>
To:     Jerome Brunet <jbrunet@baylibre.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Sam Ravnborg <sam@ravnborg.org>
Cc:     Nicolas Belin <nbelin@baylibre.com>,
        linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-phy@lists.infradead.org,
        Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3041;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=ZpI/PJO6Xf8WoOhiydrQaAvUUYE2Db1Ge8Vycxk5Hk4=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBkXjsWS1bDD1T7c5jHtVh2mDmi/N/tULfkoyJonBy6
 aAYW1eGJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZF47FgAKCRB33NvayMhJ0X0hD/
 kBZHtVqfzeeLoJIm5iDoFYZXWOAwmCuCyXP4SkCEaW14dW6l+MHsVfy7MBBZDE2iy0PQXRuPHE3XUP
 TtXewezdiGStTjoz79vjbHJdmqA9IVLlPOO4SaH+Ch3QNHk1YW5a6Q0l3fT2DIDH3jUZL5/GN7Ykd6
 dynU4y5nuqtCwmVWe3/8iXzrKW24pPcx5Z3H73V2jvWyDve35hEVTJ4SAUHdLg5VaJOpI5YaUgCeBv
 jvgmC9Y8gszu0f5hxrLdRuIDC7O4N8V6QYDNMrqnLoDvLSRmeew8sNRGQBXt1XRBErjP/bJCSosPIc
 KY623vQ1OC987+OJ5O7W5LUxgPUsLYfxGon4u2Vw5p2dnR/aEafzbgqSPCnTpDDKFy0fM9lZCB7KD7
 5cufJ2HNshucaKwqPcv6Fd5k9wdTvs2ssLm7eo/neK+cEKzmO/3twdiQJjgUPZZ3uTD2xFMVi2Mbuk
 9P3axoWbL23M6qLbU5T/YVYgk5UrzCdiiPvqaYLIT+kU/QjzuiKg3K+vCm54rkdhzVenyrge2w/oAF
 N+khm9OMQ5XTzNcdGlN+xOedrnsn5ODaI2KQZjcrGIiKdXH8FHDPw5uQCachOzQg1jOlIxxl/rjjxI
 GT/OdXMkGmSWxikippEJd0yQb8M+T3jlhQ/j1Mt+JmeEK1+DyPS2ekpHWcvA==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the MIPI DSI Analog & Digital PHY nodes and the DSI control
nodes with proper port endpoint to the VPU.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi | 70 +++++++++++++++++++++++
 1 file changed, 70 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi b/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi
index 0c49655cc90c..a62fd3656406 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi
@@ -1662,9 +1662,28 @@ pwrc: power-controller {
 								       <250000000>,
 								       <0>; /* Do Nothing */
 					};
+
+					mipi_analog_dphy: phy {
+						compatible = "amlogic,g12a-mipi-dphy-analog";
+						#phy-cells = <0>;
+						status = "disabled";
+					};
 				};
 			};
 
+			mipi_dphy: phy@44000 {
+				compatible = "amlogic,axg-mipi-dphy";
+				reg = <0x0 0x44000 0x0 0x2000>;
+				clocks = <&clkc CLKID_MIPI_DSI_PHY>;
+				clock-names = "pclk";
+				resets = <&reset RESET_MIPI_DSI_PHY>;
+				reset-names = "phy";
+				phys = <&mipi_analog_dphy>;
+				phy-names = "analog";
+				#phy-cells = <0>;
+				status = "disabled";
+			};
+
 			usb3_pcie_phy: phy@46000 {
 				compatible = "amlogic,g12a-usb3-pcie-phy";
 				reg = <0x0 0x46000 0x0 0x2000>;
@@ -2151,6 +2170,15 @@ hdmi_tx_out: endpoint {
 					remote-endpoint = <&hdmi_tx_in>;
 				};
 			};
+
+			/* DPI output port */
+			dpi_port: port@2 {
+				reg = <2>;
+
+				dpi_out: endpoint {
+					remote-endpoint = <&mipi_dsi_in>;
+				};
+			};
 		};
 
 		gic: interrupt-controller@ffc01000 {
@@ -2188,6 +2216,48 @@ gpio_intc: interrupt-controller@f080 {
 				amlogic,channel-interrupts = <64 65 66 67 68 69 70 71>;
 			};
 
+			mipi_dsi: mipi-dsi@7000 {
+				compatible = "amlogic,meson-g12a-dw-mipi-dsi";
+				reg = <0x0 0x7000 0x0 0x1000>;
+				resets = <&reset RESET_MIPI_DSI_HOST>;
+				reset-names = "top";
+				clocks = <&clkc CLKID_MIPI_DSI_HOST>,
+					 <&clkc CLKID_MIPI_DSI_PXCLK>,
+					 <&clkc CLKID_CTS_ENCL>;
+				clock-names = "pclk", "bit_clk", "px_clk";
+				phys = <&mipi_dphy>;
+				phy-names = "dphy";
+				#address-cells = <1>;
+				#size-cells = <0>;
+				status = "disabled";
+
+				assigned-clocks = <&clkc CLKID_MIPI_DSI_PXCLK_SEL>,
+					 <&clkc CLKID_CTS_ENCL_SEL>,
+					 <&clkc CLKID_VCLK2_SEL>;
+				assigned-clock-parents = <&clkc CLKID_GP0_PLL>,
+					 <&clkc CLKID_VCLK2_DIV1>,
+					 <&clkc CLKID_GP0_PLL>;
+
+				ports {
+					#address-cells = <1>;
+					#size-cells = <0>;
+
+					/* VPU VENC Input */
+					mipi_dsi_venc_port: port@0 {
+						reg = <0>;
+
+						mipi_dsi_in: endpoint {
+							remote-endpoint = <&dpi_out>;
+						};
+					};
+
+					/* DSI Output */
+					mipi_dsi_panel_port: port@1 {
+						reg = <1>;
+					};
+				};
+			};
+
 			watchdog: watchdog@f0d0 {
 				compatible = "amlogic,meson-gxbb-wdt";
 				reg = <0x0 0xf0d0 0x0 0x10>;

-- 
2.34.1

