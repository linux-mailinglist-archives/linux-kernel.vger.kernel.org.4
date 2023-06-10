Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD15E72AE63
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Jun 2023 21:27:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229551AbjFJT07 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Jun 2023 15:26:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbjFJT0y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Jun 2023 15:26:54 -0400
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19B68270F;
        Sat, 10 Jun 2023 12:26:50 -0700 (PDT)
Received: by mail-io1-xd2b.google.com with SMTP id ca18e2360f4ac-777a78739ccso174029039f.3;
        Sat, 10 Jun 2023 12:26:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686425209; x=1689017209;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lWZAOrpxcPy/VaZT1TR0uZvyQNu/oBKtJleKxtxgvfg=;
        b=QabA6z7N9TIpLITyUdMT51E826/kxGyzJT7Aqxg9Ekm0R9QNwy8VUmx28y/2ANDMYJ
         VgbNUfpgZs25xWKAru+97r9wVkrQGwmzItIIob5Um+vIIdA4E1UiP0EpZgrvz7bRNgaq
         JBQZ+eZQapnnHtc8O+V8a5jEBuVt18V4DmqeaKkwy8IIrwEFsThFRpv+oOCXl/ny0qra
         XO2fPXQV734jkzqHk6axbxr4YkAbl7g93093PBKwb0ANqT82qAysem8Lng3ReMB/hLGG
         ncMRbkAtVfHYSJIJYVmmklLioAfhOHt+28hF+sog8QGa/J/eKd/yuyz9CxkZ3jRDyfb6
         y/pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686425209; x=1689017209;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lWZAOrpxcPy/VaZT1TR0uZvyQNu/oBKtJleKxtxgvfg=;
        b=Yn4F+AFtjVtgl5RIvHr9qnZRVLXWEe+MuWffZTR355U2zwVUmgQw+1Od7m2qtPFrDM
         ZAmp5eKP0YzUtno26dXc9UimScOzSpAb4aXiQX+M5ieRO27+q2wgX0YxI2S0NQzTin1q
         NkeAZ9zjuGeYmKnBfNOu2E/zchajBnXD20IOj3bIWqt2GgaqcthSEN1UokRTTE/igrR7
         z5IJA0EBy0AUfsFbH+5wiLQEAAYE6a1YNpD0UpWZYN2ODX201xDYcLfAz56zHhObQ3gK
         waQxSR2jBycIOUDSq2gDuAkIFg9PX1xJbR1RuN9nfc5zZNI5aJz7upQjAOAwDWMXeFA/
         6qxQ==
X-Gm-Message-State: AC+VfDzfmegJiGRgg+ZotKvPtFRSLAG6gMPPXJC4KsyoG5rkJ+CWT5os
        JqJ/IOKI02XzFdEvb0FOWnQ=
X-Google-Smtp-Source: ACHHUZ6YYKgbLdxr2hJFDVazgC0gQN/yg0Db0b1l1IDJbUTtVEmFKSOoeH98UzIG28zZSZT5U7KqxA==
X-Received: by 2002:a05:6602:1851:b0:777:a970:b382 with SMTP id d17-20020a056602185100b00777a970b382mr5146501ioi.18.1686425209342;
        Sat, 10 Jun 2023 12:26:49 -0700 (PDT)
Received: from aford-B741.lan ([2601:447:d001:897f:7d74:3e3b:c016:e413])
        by smtp.gmail.com with ESMTPSA id a24-20020a6b6618000000b00752f62cd3bdsm1963834ioc.12.2023.06.10.12.26.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Jun 2023 12:26:48 -0700 (PDT)
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
Subject: [PATCH V3 3/3] arm64: dts: imx8mm-beacon: Add HDMI video with sound
Date:   Sat, 10 Jun 2023 14:26:36 -0500
Message-Id: <20230610192637.263600-4-aford173@gmail.com>
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

