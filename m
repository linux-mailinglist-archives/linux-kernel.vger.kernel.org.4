Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7292C7321F1
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 23:53:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234932AbjFOVxf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 17:53:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231830AbjFOVx3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 17:53:29 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC7732965;
        Thu, 15 Jun 2023 14:53:27 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id ca18e2360f4ac-77aec3ce39aso1245139f.0;
        Thu, 15 Jun 2023 14:53:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686866007; x=1689458007;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lWZAOrpxcPy/VaZT1TR0uZvyQNu/oBKtJleKxtxgvfg=;
        b=GUPSHwODv4uOyTnpjACBroWj0fjXIGLtKW8s34XQVyj+wDoOcsJdotOBtFWq71NmiO
         m933eS27rZvxDv7sq9gSczQnOmGyrkRSB2kgkVovmzmgefZk2cVaUd35YVgDmQlbAq0B
         EatQfoYSb2iz9PJkuPmRT8kqVdombISdb+jcfPYk93MUdJIFBwTGvONPTqhUBiAgSMA+
         CwWgE9N7UEYb4T3wjrYcqMxz8ZprOkno49A+fBMyixB8vkqNJRQTBaJQkSJOGeiYopz1
         W3Cga6+B7mgD9vqyFNPRIOMvGKBCT0NUQPdl2kZlY3ynB00fFUvEzzG0ExiWw4hYY3M7
         WcXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686866007; x=1689458007;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lWZAOrpxcPy/VaZT1TR0uZvyQNu/oBKtJleKxtxgvfg=;
        b=jWbcr8ijVRxjgGvuFzEl1X1xRch17ycYl7xasIknUPBktvDpK44XI4lstsHtnQUeC5
         4defa2s1i5xLZXFm6DPBq93Pz8SDhJ0WA1+UBPfHlqJz1XA/2I8bjogyQJaNPG86rIrl
         4f7SWM59NClENy3rDlaj7x2jDTOZ19o3725elR35weRi2kl7ryQD/NzvcShpj2Ynntjd
         Wx87yYIxhCP2NWiYf0FK2lbNtffqqyjtECxuUkj6nZeJQvj/tmGTTLYA3MTdefiGmAkH
         xMN7wGiUDUZQHfePtBE14ecdpS7TAANGzDOiAhnBrvfp3+4dYrQ3fSUlXEtSgn996wXL
         l1MQ==
X-Gm-Message-State: AC+VfDwPd5McKpJZBY/ag9but2BIZm+y5P+bn0fQn47EDzmITqKN+aOw
        ZBYW+xoRAIMT+6qOuuXY/5M=
X-Google-Smtp-Source: ACHHUZ7P9JHfmrxjz3gkzxk85PGcy+51poUIx6M/mG11P38zZet+WuvVGzcH5YXkGExtXOAn7V3rDw==
X-Received: by 2002:a6b:e00e:0:b0:777:84d7:8e89 with SMTP id z14-20020a6be00e000000b0077784d78e89mr650064iog.13.1686866007103;
        Thu, 15 Jun 2023 14:53:27 -0700 (PDT)
Received: from aford-B741.lan ([2601:447:d001:897f:bba3:fc99:5334:6f55])
        by smtp.gmail.com with ESMTPSA id z3-20020a5ec903000000b0077ac811b20dsm6264272iol.38.2023.06.15.14.53.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jun 2023 14:53:26 -0700 (PDT)
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
Subject: [PATCH 3/3] arm64: dts: imx8mm-beacon: Add HDMI video with sound
Date:   Thu, 15 Jun 2023 16:53:13 -0500
Message-Id: <20230615215314.5402-4-aford173@gmail.com>
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

The Beacon Embedded imx8mm development kit has a DSI
to HDMI bridge chip.  The bridge supports stereo audio
and hot-plugging.

Signed-off-by: Adam Ford <aford173@gmail.com>

diff --git a/arch/arm64/boot/dts/freescale/imx8mm-beacon-kit.dts b/arch/arm64/boot/dts/freescale/imx8mm-beacon-kit.dts
index 74a7b0cc10c2..66d68ce98ca4 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-beacon-kit.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mm-beacon-kit.dts
@@ -16,4 +16,135 @@ / {
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

