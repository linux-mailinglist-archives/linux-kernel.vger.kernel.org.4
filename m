Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF0836EAE38
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 17:44:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232762AbjDUPns (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 11:43:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232573AbjDUPnn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 11:43:43 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13B9C1385F
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 08:43:35 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id ffacd0b85a97d-2f939bea9ebso1740838f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 08:43:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1682091813; x=1684683813;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3EQLBHp8LKtmE2FtHSzAOWDxYQlcAD1HNJT4CQStpTw=;
        b=QyS8B1MQx3WHIiGc51EdtnvmOAJSgkuEoS0xI/q/o/U5BsNuiaqIirBP94D/fjtDW8
         xZKJHoSR9cv5sDB/2IFPRHLG09GhqCZuXxUpDUnC+N+8ud2p/WZxU941vnXbPuwpCFGW
         1Mgz1plJS834q+5y+z7G9TNzqprdzulOTIhN0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682091813; x=1684683813;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3EQLBHp8LKtmE2FtHSzAOWDxYQlcAD1HNJT4CQStpTw=;
        b=Uw8BebqCqgH/ENEwwvxRBYKF/E2Zid/PKxSbUBC4gIGNkakCM6Dla/QrEgh22mZcw3
         kQqm8KiNqbNAWWNUIPfjIjgSH1SavZcOD5HJ5duv7jsQby7l71tZGBcj2c8ieEi4+m7w
         pdMpEFOcWRhNsCSPYIMB8Qf+l0aDPtA7wSAavCKPGTWVWz1Pqk+JnToaWQe94syul1ZO
         1uOpkirdRcMkeu6E9D7p3KBBtzSpNSnA0mGPLoJzhrnEJQd4Vy6xgPWR4QhMoutLhmFe
         gupz0/iFV85/3TJpm4UnUTlGAqoo3raU+ZCeslg0UMj7inHmqKvajakoLgeYdWCiRQxV
         hsGg==
X-Gm-Message-State: AAQBX9f63420jZiO/k8yfetKWhZ8TUxWd7ncPwN4rzefUBYfq3nAU7hz
        GwWIMj4ey8IzUB3Eag6QqjyTH5qfv5ji2BrHg23F6Q==
X-Google-Smtp-Source: AKy350bg/RElVqSuIFOseVBmnJUL2mcF1i0dWRrsVh0lzCYUF4TRlXcR/glRrOLnSU0syZXYt/bK7w==
X-Received: by 2002:a5d:4e04:0:b0:2f4:30ee:310b with SMTP id p4-20020a5d4e04000000b002f430ee310bmr4090705wrt.26.1682091813106;
        Fri, 21 Apr 2023 08:43:33 -0700 (PDT)
Received: from dario-ThinkPad-T14s-Gen-2i.. ([37.159.127.129])
        by smtp.gmail.com with ESMTPSA id g18-20020a5d5552000000b002e51195a3e2sm4651609wrw.79.2023.04.21.08.43.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Apr 2023 08:43:32 -0700 (PDT)
From:   Dario Binacchi <dario.binacchi@amarulasolutions.com>
To:     linux-kernel@vger.kernel.org
Cc:     michael@amarulasolutions.com,
        Amarula patchwork <linux-amarula@amarulasolutions.com>,
        Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        Fabio Estevam <festevam@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 3/7] arm64: dts: imx8mn-bsh-smm-s2/pro: add display setup
Date:   Fri, 21 Apr 2023 17:43:04 +0200
Message-Id: <20230421154308.527128-4-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20230421154308.527128-1-dario.binacchi@amarulasolutions.com>
References: <20230421154308.527128-1-dario.binacchi@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michael Trimarchi <michael@amarulasolutions.com>

Add the display and nodes required for its operation.

Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
---

 .../freescale/imx8mn-bsh-smm-s2-common.dtsi   |   1 +
 .../freescale/imx8mn-bsh-smm-s2-display.dtsi  | 111 ++++++++++++++++++
 2 files changed, 112 insertions(+)
 create mode 100644 arch/arm64/boot/dts/freescale/imx8mn-bsh-smm-s2-display.dtsi

diff --git a/arch/arm64/boot/dts/freescale/imx8mn-bsh-smm-s2-common.dtsi b/arch/arm64/boot/dts/freescale/imx8mn-bsh-smm-s2-common.dtsi
index c11895d9d582..5f9c0df0ec7d 100644
--- a/arch/arm64/boot/dts/freescale/imx8mn-bsh-smm-s2-common.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mn-bsh-smm-s2-common.dtsi
@@ -7,6 +7,7 @@
 /dts-v1/;
 
 #include "imx8mn.dtsi"
+#include "imx8mn-bsh-smm-s2-display.dtsi"
 
 / {
 	chosen {
diff --git a/arch/arm64/boot/dts/freescale/imx8mn-bsh-smm-s2-display.dtsi b/arch/arm64/boot/dts/freescale/imx8mn-bsh-smm-s2-display.dtsi
new file mode 100644
index 000000000000..bac987d76f1e
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/imx8mn-bsh-smm-s2-display.dtsi
@@ -0,0 +1,111 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright 2021 BSH
+ */
+
+/ {
+	backlight: backlight {
+		compatible = "pwm-backlight";
+		pwms = <&pwm1 0 700000 0>;	/* 700000 ns = 1337Hz */
+		brightness-levels = <0 100>;
+		num-interpolated-steps = <100>;
+		default-brightness-level = <50>;
+		status = "okay";
+	};
+
+	reg_3v3_dvdd: regulator-3v3-O3 {
+		compatible = "regulator-fixed";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_dvdd>;
+		regulator-name = "3v3-dvdd-supply";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		gpio = <&gpio1 7 GPIO_ACTIVE_LOW>;
+	};
+
+	reg_v3v3_avdd: regulator-3v3-O2 {
+		compatible = "regulator-fixed";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_avdd>;
+		regulator-name = "3v3-avdd-supply";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		gpio = <&gpio1 5 GPIO_ACTIVE_LOW>;
+	};
+};
+
+&pwm1 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_bl>;
+};
+
+&lcdif {
+	status = "okay";
+};
+
+&dsi {
+	#address-cells = <1>;
+	#size-cells = <0>;
+	status = "okay";
+
+	panel@0 {
+		compatible = "sharp,ls068b3sx02", "synaptics,r63353";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_panel>;
+		reg = <0>;
+
+		backlight = <&backlight>;
+		dvdd-supply = <&reg_3v3_dvdd>;
+		avdd-supply = <&reg_v3v3_avdd>;
+		reset-gpios = <&gpio4 29 GPIO_ACTIVE_HIGH>;
+
+		port {
+			panel_in: endpoint {
+				remote-endpoint = <&mipi_dsi_out>;
+			};
+		};
+
+	};
+
+	ports {
+		port@1 {
+			reg = <1>;
+			mipi_dsi_out: endpoint {
+				remote-endpoint = <&panel_in>;
+			};
+		};
+	};
+};
+
+&gpu {
+	status = "okay";
+};
+
+&iomuxc {
+
+	/* This is for both PWM and voltage regulators for display */
+	pinctrl_bl: pwm1grp {
+		fsl,pins = <
+			MX8MN_IOMUXC_GPIO1_IO01_PWM1_OUT	0x16
+		>;
+	};
+
+	pinctrl_panel: panelgrp {
+		fsl,pins = <
+			MX8MN_IOMUXC_SAI3_RXC_GPIO4_IO29	0x16	/* panel reset */
+		>;
+	};
+
+	pinctrl_dvdd: dvddgrp {
+		fsl,pins = <
+			MX8MN_IOMUXC_GPIO1_IO07_GPIO1_IO7	0x16	/* VDD 3V3_VO3 */
+		>;
+	};
+
+	pinctrl_avdd: avddgrp {
+		fsl,pins = <
+			MX8MN_IOMUXC_GPIO1_IO05_GPIO1_IO5	0x16	/* VDD 3V3_VO2 */
+		>;
+	};
+};
-- 
2.32.0

