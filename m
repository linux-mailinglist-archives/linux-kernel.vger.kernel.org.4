Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C66172333B
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 00:33:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232812AbjFEWdr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 18:33:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232565AbjFEWdm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 18:33:42 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0548DF3;
        Mon,  5 Jun 2023 15:33:40 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id ca18e2360f4ac-777a9d7efabso80438839f.0;
        Mon, 05 Jun 2023 15:33:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686004419; x=1688596419;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wtUVpP6es6yg1qk2MeHjSfVIxOPxP0g6I1UOB9ugWXk=;
        b=XaDviP3PGd1V7YtV0tQg8h3isRt6DZ4YlW0W5YV7IYW2LaYwYSAjvviQcvDf+H+9B5
         QeXgEgnsSjWP9QoQHq/WdZv/arXv0q3YHVfoKyOtnPpO3Z3LVbBY3FBMMLN2EzMJ+I5f
         jWABOlypPLqbPR+it4tCumq4JU42/evlkk+9CoKYmbmlLf2ElQ+JZ4BMUF/JqecSpu+b
         h9pxI88c8c+af0M0GLPEG942UvVgPbLN50jnNQDPtnisDWpVj/oc7rcmotHdPZP+DNMQ
         cGL+mxRMWYTxNTtgd2vwQHgRgX04cvWVbeY0Hkw6J9DU1CmNcfNYEU+b9MJVbxgJMnha
         kHTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686004419; x=1688596419;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wtUVpP6es6yg1qk2MeHjSfVIxOPxP0g6I1UOB9ugWXk=;
        b=j+ES9okXVEyIavTTN861N7sb1PpYaHRKHF6MZF9c9jGdotVqnha9PIePIOSkdeiuyo
         D2pYol+rhBO9lOIOp6Kthe09kfkOBlR3XmxzPHbIZT+m2BsGuQ/Dsrz/Ki+qmWBXtNJb
         01X4QhC4gA4yyMzggZovF5KC+wETqJs6Yh2Iy0nm8GjGAFD7xaQsX+6iDPSMsmspGjsV
         Atm585i2ATRf6737i0njbKWdhsuU97S5WywGEMS843PU4HcWtfp47emhLqEsWiSoFdiQ
         sqP8rQ5R4I8efpPoKRmITcH3bIymjlWiL1hv2V4aB9Id6qO54jNTzAakmiI65gE/ZL3w
         LfjQ==
X-Gm-Message-State: AC+VfDySX0RNJ0zQXqmeKqLzRZO2478FDuELgBdP6a3AZ/G0dDfP8fAg
        9TUwxUPVWQvCbGZw1o3Zlt4=
X-Google-Smtp-Source: ACHHUZ5uScyXiUNNTrMaP7qAeOzLigUEMX+vl6YWxmBast5Ye8L0DaYMk+7E65jGheuDq55QL3EMhQ==
X-Received: by 2002:a6b:7f08:0:b0:776:fce3:4763 with SMTP id l8-20020a6b7f08000000b00776fce34763mr441549ioq.20.1686004419308;
        Mon, 05 Jun 2023 15:33:39 -0700 (PDT)
Received: from aford-B741.lan ([2601:447:d001:897f:f45b:1201:1374:ebd2])
        by smtp.gmail.com with ESMTPSA id j13-20020a02a68d000000b004035b26b6d8sm2477068jam.2.2023.06.05.15.33.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jun 2023 15:33:39 -0700 (PDT)
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
Subject: [PATCH V2 2/2] arm64: dts: imx8mm-beacon: Add HDMI video with sound
Date:   Mon,  5 Jun 2023 17:33:23 -0500
Message-Id: <20230605223323.578198-3-aford173@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230605223323.578198-1-aford173@gmail.com>
References: <20230605223323.578198-1-aford173@gmail.com>
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

The Beacon Embedded imx8mm development kit has a DSI
to HDMI bridge chip.  The bridge supports stereo audio
and hot-plugging.

Signed-off-by: Adam Ford <aford173@gmail.com>

diff --git a/arch/arm64/boot/dts/freescale/imx8mm-beacon-kit.dts b/arch/arm64/boot/dts/freescale/imx8mm-beacon-kit.dts
index 74a7b0cc10c2..499217ff30b4 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-beacon-kit.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mm-beacon-kit.dts
@@ -16,4 +16,136 @@ / {
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
+	assigned-clocks = <&clk IMX8MM_CLK_SAI5>;
+	assigned-clock-parents = <&clk IMX8MM_AUDIO_PLL1_OUT>;
+	assigned-clock-rates = <24576000>;
+	#sound-dai-cells = <0>;
+	status = "okay";
+};
+
+&iomuxc {
+	pinctrl_hdmi_bridge: hdmibridgegrp {
+		fsl,pins = <
+			MX8MM_IOMUXC_GPIO1_IO09_GPIO1_IO9		0x19
+		>;
+	};
+
+	pinctrl_reg_hdmi: reghdmigrp {
+		fsl,pins = <
+			MX8MM_IOMUXC_SD1_STROBE_GPIO2_IO11              0x16
+		>;
+	};
+
+	pinctrl_sai5: sai5grp {
+		fsl,pins = <
+			MX8MM_IOMUXC_SAI5_RXD3_SAI5_TX_DATA0	0xd6
+			MX8MM_IOMUXC_SAI5_RXD2_SAI5_TX_BCLK	0xd6
+			MX8MM_IOMUXC_SAI5_RXD1_SAI5_TX_SYNC	0xd6
+		>;
+	};
 };
-- 
2.39.2

