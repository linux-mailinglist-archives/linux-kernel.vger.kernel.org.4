Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B18C719135
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 05:16:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231231AbjFADQE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 23:16:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231325AbjFADPt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 23:15:49 -0400
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 577FB136;
        Wed, 31 May 2023 20:15:47 -0700 (PDT)
Received: by mail-io1-xd2d.google.com with SMTP id ca18e2360f4ac-7748d634a70so18800239f.2;
        Wed, 31 May 2023 20:15:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685589346; x=1688181346;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IaYUh6udDd9THZST3S1u3zp6I5I+YG9NsVc6tO6Kw5Y=;
        b=pay7dN0xJANz/ygkmPegA/Ili85G+ez6kBMmt/EmI9wIzQnQ7+W0n16H1W+ZMow4se
         DOqJobuP5JEYgGbIpK/KufS3Y+3/bUZvpCPUzC2CvIL0fP0J895w6OrIWyHe9WERV9Se
         iCASxRE3MCHyFcZL/FDcO3NVkZ2LvDr7ngzN2bd1guhWun1xzUGw27emNrf7sapazJ0d
         yszhPPxZfbyw2YpKNORuQhzpTUNkxBP1V/cflsqTGfPETttAUTOSCVHVdlq4c58x+yRE
         BO82SYVdMR2xcaOML1g1C1aiPK0XenXBIRu7POYJ3OtoJSuwozCxT5S2oA4GL8uGZvkC
         FHeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685589346; x=1688181346;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IaYUh6udDd9THZST3S1u3zp6I5I+YG9NsVc6tO6Kw5Y=;
        b=RDSrIVrU1n0gMFq/yOjmWC0cZFSTHfUahCloI6HVUm8g2+uZZ/jIVKf29LhKZFG6dE
         22hK0Dy3ixymt97K6XYPnCcUqLhXUcxD/1xsMOLm8KZm1X27jkGEprrF6feHyhlETXTw
         DWSw+Drt2hZEyasNzC5ZfRmiiI6DRq6za0OlNmREkjIJULizBTJMCMTxOnQbdQVr6bOB
         Bh7TWYT5lrw89dYzTp7s6HZg2Ny69+kKfD0jglI74OdTgWSA/bsZOI3K5w6Wxwahdoc8
         YUgNBrMCTCZ+bKJeRHYw59gw5hnftGUI8x24o26mseSSRn9CrUi+qstSoRXg3JgS84fX
         NitA==
X-Gm-Message-State: AC+VfDxUiOJa9Zxqeoe3Sw+ZRTWViVFunaddS8/qMV/O3KKBbG002LGR
        r5d8K/nriZy2xDeC4+1f2o/Pi+GWKwM=
X-Google-Smtp-Source: ACHHUZ6V1l4xu9iSeqWvUgoLjkIMd+VSckIxbEigJYZTda/nMbEHr1PQqiQP95OFcl2XPXbbqIdaaQ==
X-Received: by 2002:a5e:8f44:0:b0:775:8241:724a with SMTP id x4-20020a5e8f44000000b007758241724amr6092806iop.16.1685589346525;
        Wed, 31 May 2023 20:15:46 -0700 (PDT)
Received: from aford-B741.lan ([2601:447:d001:897f:6ae0:d0f8:5d79:f782])
        by smtp.gmail.com with ESMTPSA id b66-20020a0295c8000000b004165d7d6711sm1852590jai.71.2023.05.31.20.15.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 May 2023 20:15:46 -0700 (PDT)
From:   Adam Ford <aford173@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     aford@beaconembedded.com, Adam Ford <aford173@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] arm64: dts: imx8mn-beacon: Add HDMI video with sound
Date:   Wed, 31 May 2023 22:15:25 -0500
Message-Id: <20230601031527.271232-2-aford173@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230601031527.271232-1-aford173@gmail.com>
References: <20230601031527.271232-1-aford173@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Beacon Embedded imx8mn development kit has a DSI
to HDMI bridge chip.  The bridge supports stereo audio
and hot-plugging.

Signed-off-by: Adam Ford <aford173@gmail.com>

diff --git a/arch/arm64/boot/dts/freescale/imx8mn-beacon-kit.dts b/arch/arm64/boot/dts/freescale/imx8mn-beacon-kit.dts
index 1392ce02587b..3758c46c7162 100644
--- a/arch/arm64/boot/dts/freescale/imx8mn-beacon-kit.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mn-beacon-kit.dts
@@ -16,4 +16,138 @@ / {
 	chosen {
 		stdout-path = &uart2;
 	};
+
+	connector {
+		compatible = "hdmi-connector";
+		type = "a";
+
+		port {
+			hdmi_connector_in: endpoint {
+				remote-endpoint = <&adv7535_out>;
+			};
+		};
+	};
+
+	reg_hdmi: regulator-hdmi-dvdd {
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_reg_hdmi>;
+		compatible = "regulator-fixed";
+		regulator-name = "hdmi_pwr_en";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		gpio = <&gpio2 11 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+		startup-delay-us = <70000>;
+		regulator-always-on;
+	};
+
+	sound-hdmi {
+		compatible = "simple-audio-card";
+		simple-audio-card,name = "sound-hdmi";
+		simple-audio-card,format = "i2s";
+
+		simple-audio-card,cpu {
+			sound-dai = <&sai5 0>;
+			system-clock-direction-out;
+		};
+
+		simple-audio-card,codec {
+			sound-dai = <&adv_bridge>;
+		};
+	};
+};
+
+&i2c2 {
+	adv_bridge: hdmi@3d {
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_hdmi_bridge>;
+		compatible = "adi,adv7535";
+		reg = <0x3d>, <0x3b>;
+		reg-names = "main", "cec";
+		adi,dsi-lanes = <4>;
+		adi,fixed-lanes;
+		dvdd-supply = <&reg_hdmi>;
+		v3p3-supply = <&reg_hdmi>;
+		v1p2-supply = <&reg_hdmi>;
+		a2vdd-supply = <&reg_hdmi>;
+		avdd-supply = <&reg_hdmi>;
+		pvdd-supply = <&reg_hdmi>;
+		interrupt-parent = <&gpio1>;
+		interrupts = <9 IRQ_TYPE_LEVEL_LOW>;
+		#sound-dai-cells = <0>;
+
+		ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			port@0 {
+				reg = <0>;
+
+				adv7535_in: endpoint {
+					remote-endpoint = <&dsi_out>;
+				};
+			};
+
+			port@1 {
+				reg = <1>;
+
+				adv7535_out: endpoint {
+					remote-endpoint = <&hdmi_connector_in>;
+				};
+			};
+		};
+	};
+};
+
+&lcdif {
+	assigned-clocks = <&clk IMX8MN_VIDEO_PLL1>;
+	assigned-clock-rates = <594000000>;
+	status = "okay";
+};
+
+&mipi_dsi {
+	samsung,esc-clock-frequency = <20000000>;
+	status = "okay";
+
+	ports {
+		port@1 {
+			reg = <1>;
+
+			dsi_out: endpoint {
+				remote-endpoint = <&adv7535_in>;
+			};
+		};
+	};
+};
+
+&sai5 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_sai5>;
+	assigned-clocks = <&clk IMX8MN_CLK_SAI5>;
+	assigned-clock-parents = <&clk IMX8MN_AUDIO_PLL1_OUT>;
+	assigned-clock-rates = <24576000>;
+	#sound-dai-cells = <0>;
+	status = "okay";
+};
+
+&iomuxc {
+	pinctrl_hdmi_bridge: hdmibridgegrp {
+		fsl,pins = <
+			MX8MN_IOMUXC_GPIO1_IO09_GPIO1_IO9		0x19
+		>;
+	};
+
+	pinctrl_reg_hdmi: reghdmigrp {
+		fsl,pins = <
+			MX8MN_IOMUXC_SD1_STROBE_GPIO2_IO11              0x16
+		>;
+	};
+
+	pinctrl_sai5: sai5grp {
+		fsl,pins = <
+			MX8MN_IOMUXC_SAI5_RXD3_SAI5_TX_DATA0	0xd6
+			MX8MN_IOMUXC_SAI5_RXD2_SAI5_TX_BCLK	0xd6
+			MX8MN_IOMUXC_SAI5_RXD1_SAI5_TX_SYNC	0xd6
+		>;
+	};
 };
-- 
2.39.2

