Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05C107321ED
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 23:53:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231842AbjFOVx3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 17:53:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230459AbjFOVxZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 17:53:25 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80F0C2962;
        Thu, 15 Jun 2023 14:53:24 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id ca18e2360f4ac-77ac14ff51bso455939f.3;
        Thu, 15 Jun 2023 14:53:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686866004; x=1689458004;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KxOISFldC7A+Maohwx70ZQPm8G36oFAf/BfbH4DHEI8=;
        b=BKiPagzVldM97SdtvbzzJ3fMuPcIG9UfcWpfccqoA4ao+iKXoyAgE0PMcKjKZzhSiF
         9ry/hndubJxK97fG6rNyBx4wEAP2S9DPa5CfAWlAlLik7gMwV8qUaLEFMc/tjVKRvIEl
         qFe6LI0EepjoS0OtiulfG9gZKNO8rldsg7bFUPuJ2bmBpmU7+AS2zW+n42xQDvXSGlmW
         20fjx2rRjrHXVnnYT3WC8cVOEhwIXcGFyipPg1D5iR8XynwV/98CUqRHWHS81VgM3Wla
         QG0x9VniYbI/tWxyZOEWZlMfYGSmLIi2Hh3NdAcuTbSXYH7XuWI+4/0fZw3VODF8tNAB
         9Rzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686866004; x=1689458004;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KxOISFldC7A+Maohwx70ZQPm8G36oFAf/BfbH4DHEI8=;
        b=Lcrhs8VaFd2+Xs9gm7Ue/4/iMUnw8QbMFzjgOl4lYYS2K30Fvm/0wwqz8X/0KBlht4
         i39+NgZVq49EVA6C+vQ+bm9Lg0gftlWgDUwJD0x2xyNNOJInd72AKOeyuy0SrBm8JZ43
         cFc8sH7TWly2LHQhRaRWzDMxaCyfL/CmUl+MyxQd68bt2TC3EytHSvXaSdv8FujCdqJd
         KOso4FI0r04q1lx8DtTWzGtlNWsR2ZXjYfQnD/r2mBczCxCC/eRSiOTzdVUe4xL1qxxx
         Eggg7nbaGSJCAkEw5zP+FFGON3x3hAJ+Z9Y1Uq62aptCEyW9iTtm23d20Jx+nJx+rTQj
         H08Q==
X-Gm-Message-State: AC+VfDzzQIjPfQJ056kYe7m53U9+6e2WBH56+Ltmn7RpPj4l9n1rFu7N
        OUKPUTeBOroOD9TT4X+QMXA=
X-Google-Smtp-Source: ACHHUZ6EwYGs6J0oPHAlxGhKGB5G5Cy7ddkOWD40WaG1nv3+KBkwbg1W/qfgErWv4SBNID63fr3KgQ==
X-Received: by 2002:a05:6602:228f:b0:777:b64b:9b92 with SMTP id d15-20020a056602228f00b00777b64b9b92mr592447iod.18.1686866003706;
        Thu, 15 Jun 2023 14:53:23 -0700 (PDT)
Received: from aford-B741.lan ([2601:447:d001:897f:bba3:fc99:5334:6f55])
        by smtp.gmail.com with ESMTPSA id z3-20020a5ec903000000b0077ac811b20dsm6264272iol.38.2023.06.15.14.53.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jun 2023 14:53:23 -0700 (PDT)
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
Subject: [PATCH 1/3] arm64: dts: imx8mn-beacon: Add HDMI video with sound
Date:   Thu, 15 Jun 2023 16:53:11 -0500
Message-Id: <20230615215314.5402-2-aford173@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230615215314.5402-1-aford173@gmail.com>
References: <20230615215314.5402-1-aford173@gmail.com>
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
and hot-plug detection.

Signed-off-by: Adam Ford <aford173@gmail.com>

diff --git a/arch/arm64/boot/dts/freescale/imx8mn-beacon-kit.dts b/arch/arm64/boot/dts/freescale/imx8mn-beacon-kit.dts
index 1392ce02587b..442ff2960677 100644
--- a/arch/arm64/boot/dts/freescale/imx8mn-beacon-kit.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mn-beacon-kit.dts
@@ -16,4 +16,137 @@ / {
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
+		compatible = "regulator-fixed";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_reg_hdmi>;
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
+		compatible = "adi,adv7535";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_hdmi_bridge>;
+		reg = <0x3d>, <0x3c>, <0x3e>, <0x3f>;
+		reg-names = "main", "cec", "edid", "packet";
+		adi,dsi-lanes = <4>;
+		avdd-supply = <&reg_hdmi>;
+		a2vdd-supply = <&reg_hdmi>;
+		dvdd-supply = <&reg_hdmi>;
+		pvdd-supply = <&reg_hdmi>;
+		v1p2-supply = <&reg_hdmi>;
+		v3p3-supply = <&reg_hdmi>;
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

