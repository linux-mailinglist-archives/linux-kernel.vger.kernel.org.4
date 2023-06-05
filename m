Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA43372333A
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 00:33:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232644AbjFEWdo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 18:33:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230269AbjFEWdl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 18:33:41 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8978C100;
        Mon,  5 Jun 2023 15:33:38 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id ca18e2360f4ac-777ac791935so66076839f.2;
        Mon, 05 Jun 2023 15:33:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686004418; x=1688596418;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9qrkcUSJMXH0Vt6X0WzrKau5dB9wxr1OuFrtEpxM138=;
        b=foBOUhVPyFSo4R2VJVY+bzWa0TWVFyZXWaT1nHlIivK/JyLo7Xx/YT8yh+n2lQJmau
         lOBBG+GlqHiQtjT2gAdnHFHpzIymm0Ewa96zQeGib9SBe4xRUNeRYKvtqsYDHHsfR+f/
         dZW3ETpwuoFc0og+Q3kTh31Z0SmYvjnzyAxDHinihLr1uIRs5wKD/TAgYJkBXL7qXZSW
         kPX96FWdnKqawXcSs0y9ghCzzEme4Ts7LF6jSzpSPpsZUgKfbEbWJ6WZla39v+nTcORC
         n3MG8HjBwLX6qisvrohCI2UWU7kZ/wERDchQD/JV7Q0Lo/tuF8ulCDqier/Mh+hWnoKo
         qDXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686004418; x=1688596418;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9qrkcUSJMXH0Vt6X0WzrKau5dB9wxr1OuFrtEpxM138=;
        b=ad8USeD4usHznneNMOV0Bf6dAu5Qxsb3yiQhhxoy0vuAjN7oZW7iHHwVmKo9MfHCnp
         UteVcxrWLqa3GuhLZEsZGk2Rip1Ppg05TRzFIkVDGRmcNyIQWj3FpstKs+H2nIx3NwvH
         7FGov0EXIM8DKwS9TfexVR9aLbP6CX8ByNtSaK8lLpfrusQ3NJz6s52qGBLNooKMBOkH
         1vfX06qAq/NaZmk/XLNrMRvP9A0TXh7Buo7bZOlVpp/ehArIwQbNAgzZSzPipGU8wl7Y
         Jv4ve0X72TF6qI6+hlsqpK2b3s2gPMr5ArD8viqDg195RolOS9GiL4WzWGF2QZi8iESV
         VaJA==
X-Gm-Message-State: AC+VfDyecu3V8awK5zpyJSWV68Xy5o9iKkFxPQ+O8MoOOUdSnY34dXxM
        C/eHdQT9AeeHdEnskiysJDtFxO7Ys48=
X-Google-Smtp-Source: ACHHUZ6qqwYQUMR8XXbCSTHLzYCt0qGkMkl47HileTiVYidnsBv8EYjHHEPtBZlvQcy4mUlh3ZA/7A==
X-Received: by 2002:a05:6602:54:b0:762:f8d4:6f9 with SMTP id z20-20020a056602005400b00762f8d406f9mr565989ioz.2.1686004417754;
        Mon, 05 Jun 2023 15:33:37 -0700 (PDT)
Received: from aford-B741.lan ([2601:447:d001:897f:f45b:1201:1374:ebd2])
        by smtp.gmail.com with ESMTPSA id j13-20020a02a68d000000b004035b26b6d8sm2477068jam.2.2023.06.05.15.33.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jun 2023 15:33:37 -0700 (PDT)
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
Subject: [PATCH V2 1/2] arm64: dts: imx8mn-beacon: Add HDMI video with sound
Date:   Mon,  5 Jun 2023 17:33:22 -0500
Message-Id: <20230605223323.578198-2-aford173@gmail.com>
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

The Beacon Embedded imx8mn development kit has a DSI
to HDMI bridge chip.  The bridge supports stereo audio
and hot-plug detection.

Signed-off-by: Adam Ford <aford173@gmail.com>

diff --git a/arch/arm64/boot/dts/freescale/imx8mn-beacon-kit.dts b/arch/arm64/boot/dts/freescale/imx8mn-beacon-kit.dts
index 1392ce02587b..2108ec8c019c 100644
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

