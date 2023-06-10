Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C50F72AE61
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Jun 2023 21:27:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229676AbjFJT0v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Jun 2023 15:26:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231856AbjFJT0r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Jun 2023 15:26:47 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDC1D270B;
        Sat, 10 Jun 2023 12:26:46 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id ca18e2360f4ac-77acb04309dso173165439f.2;
        Sat, 10 Jun 2023 12:26:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686425206; x=1689017206;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KxOISFldC7A+Maohwx70ZQPm8G36oFAf/BfbH4DHEI8=;
        b=dubLY1GcXQLEunu1nrsGPfPrxZI84NhZFV6ojH1vTWueN/hWPp9mW5bQzEANWE/H5O
         2ykaZCpGLafh1XD08o11qMbAj2lX5kBeLCJU/8RgXtnlXc61rVPqv/PCH08sSz29OCSF
         qvceM9r45fUeAhuzkFKSBZSRsSeZ+H2MKDIcQG9gh3WNzFWqhro5dn+haa+oo5CcI7ZO
         fb3/WtpErKuVOGk1EKdh20u5ooAyPOn3ITzkp8UIoQEbyxpdqveMMu1nuhhZBgneg+D/
         g31yw+LHidbZ+0bKZ8Kh0eCGOr+KQ1K0oy2Apwx08Dv9YZxHjsIAj2AxTvNkahvj2L+I
         FQ5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686425206; x=1689017206;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KxOISFldC7A+Maohwx70ZQPm8G36oFAf/BfbH4DHEI8=;
        b=WMdtZ/G0oASs3C5g0ejrtAwSwK3MFIvJx47wlPLYALDD8wCI00TQrkmLZDsZ6iFGEG
         0dxM3WgJOXhCh4dEvKsE1dsg5HWDWDA+ONWEG9FK/CzJ6KOvzZQj3tdFwG4eox2ZGX0w
         8pLpgL8OH5OUjvB8V31yn2KhKx2+ClT2qzFcHRF6Gm3Qa2Bk/dz8q/HwL700eJ+kUhCD
         HZ7EH6nnr7Y1PdlBDTFGenE4iLlDRgUdP52znjxYTDD53Y7pCj5oQ+lYUu3nsdTTd39X
         BOOLW80FAKfuRxdtMLa1eYmqkVZUgpA5RrFAHx6ZKgY+d4HSyvq8GuZGyAVEqNYC+L0i
         Wetg==
X-Gm-Message-State: AC+VfDzFWkAnmysy3yUitOTXO0gJ2WHQI+DzC/c9M3nBUSb1T7kAqofX
        0/yVjMfzHpw6ddRnTv1PKc0=
X-Google-Smtp-Source: ACHHUZ5PoFOlAP6uSKilaPruueVAJC3EUhRyZeWw94OqAo995azeUJ2e7Il+lFZE21QhUeixNpYPlg==
X-Received: by 2002:a5e:a714:0:b0:777:aa56:f5e9 with SMTP id b20-20020a5ea714000000b00777aa56f5e9mr4666510iod.16.1686425206081;
        Sat, 10 Jun 2023 12:26:46 -0700 (PDT)
Received: from aford-B741.lan ([2601:447:d001:897f:7d74:3e3b:c016:e413])
        by smtp.gmail.com with ESMTPSA id a24-20020a6b6618000000b00752f62cd3bdsm1963834ioc.12.2023.06.10.12.26.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Jun 2023 12:26:45 -0700 (PDT)
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
Subject: [PATCH V3 1/3] arm64: dts: imx8mn-beacon: Add HDMI video with sound
Date:   Sat, 10 Jun 2023 14:26:34 -0500
Message-Id: <20230610192637.263600-2-aford173@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230610192637.263600-1-aford173@gmail.com>
References: <20230610192637.263600-1-aford173@gmail.com>
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

