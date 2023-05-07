Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C661D6F993F
	for <lists+linux-kernel@lfdr.de>; Sun,  7 May 2023 17:16:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229460AbjEGPQP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 May 2023 11:16:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231593AbjEGPQE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 May 2023 11:16:04 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68806124A7;
        Sun,  7 May 2023 08:16:03 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id ca18e2360f4ac-768d75b2369so283612739f.0;
        Sun, 07 May 2023 08:16:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683472563; x=1686064563;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Myks9ibscFfLfkvDsV+jBK2okCgS5xjyuH4qT5dxmZ0=;
        b=onyWJMmFOO1TQOmJseYcIWCtrQBEiplRPkAB9WIdvl5+kyG8S9ge3IF2L46VZ7KKm1
         yFhmuTtY52l9OTE/zBZZKTRMc2yl+N2aUpEFmxOmFax3IsOQD9MNgLwctwZcN3Ci5I8o
         OktDqnAlxKcvyWi+Jo/x78AaM5jMxMpPY5/vU7qeiqxYsu9XgljVYy1qkjR/6C/YygEF
         SO8D2/L7N/ai6zjD4n2dHtWuC4YhXNZsJNEUXGWhmC5LIYEO+Qihqu59DEDZ8p3IcW5u
         4OcBfjrZ6toWObcWdn78qUtMF22lPDUvNpkpURA7ADUgXPo9BY43NjaL35yxRsJvW1Ou
         rO7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683472563; x=1686064563;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Myks9ibscFfLfkvDsV+jBK2okCgS5xjyuH4qT5dxmZ0=;
        b=ZTS2AR/PdV75jyLjhVUM41Rvi7J7iN/MjXQD4a1PdsUNhEnTa1O6gD+JnmfTsAnr1F
         WHLO8YyLyafSx0NGLaobjgCpmnghuwRUqY12Srsjy3fwBb2UvCMiWcogYG9Hs3SleBeb
         XrfTPWZEKq/t4Ml5csw6hl79S0Xs3Iq6VVzW79WkKaJGwVS9Tzyz7Jmjz3HKFCjgYkVL
         POTXSITJAFexuCfokG8NMx60ZZkV2syHraavBa1066wQYUlfolVa2BTYiwRABCWxC1md
         0aImbZWQICcqJRlfc/OrM63viyymd6i8o7FhX+zuiUmwVqiQoWKGW17qmfE3K0IN9c8Q
         PvFg==
X-Gm-Message-State: AC+VfDx9h9M4XPRI07al2QdAcLENryrAWQxxL1bG9y9hCSOVHmFQ8l66
        7dFfAuTYiw8ipQEsINnlgAM=
X-Google-Smtp-Source: ACHHUZ5EW+UX337znXIuV+VfxGZaiPOGCaaj+iujviYeC29RLMN38vohJNQq5Vi2M2qpiuXKCvlD+w==
X-Received: by 2002:a92:c04d:0:b0:331:3fe4:f2ec with SMTP id o13-20020a92c04d000000b003313fe4f2ecmr5082583ilf.26.1683472562627;
        Sun, 07 May 2023 08:16:02 -0700 (PDT)
Received: from aford-B741.lan ([2601:447:d001:897f:32f2:3dc9:fe53:5220])
        by smtp.gmail.com with ESMTPSA id s1-20020a02b141000000b0040faf05071asm1293566jah.156.2023.05.07.08.16.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 May 2023 08:16:01 -0700 (PDT)
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
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH V2 3/3] arm64: dts: imx8mn-beacon:  Add support for OV5640 Camera
Date:   Sun,  7 May 2023 10:15:48 -0500
Message-Id: <20230507151549.1216019-3-aford173@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230507151549.1216019-1-aford173@gmail.com>
References: <20230507151549.1216019-1-aford173@gmail.com>
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

The baseboard has a very specific pinout for the TD Next 5640
camera which uses an OV5640 sensor.  Enable it as part of the
deveopment kit baseboard instead of an overlay.

Enable the camera with the following
  media-ctl -l "'ov5640 1-0010':0 -> 'csis-32e30000.mipi-csi':0 [1]"
  media-ctl -v -V "'ov5640 1-0010':0 [fmt:UYVY8_1X16/640x480 field:none]"
  media-ctl -v -V "'crossbar':0 [fmt:UYVY8_1X16/640x480 field:none]"
  media-ctl -v -V "'mxc_isi.0':0 [fmt:UYVY8_1X16/640x480 field:none]"

Signed-off-by: Adam Ford <aford173@gmail.com>
---
V2:  New to series, since Laurent asked me to add a board which supports
     the previous two commits.
     
diff --git a/arch/arm64/boot/dts/freescale/imx8mn-beacon-baseboard.dtsi b/arch/arm64/boot/dts/freescale/imx8mn-beacon-baseboard.dtsi
index 9e82069c941f..6dce77a6114c 100644
--- a/arch/arm64/boot/dts/freescale/imx8mn-beacon-baseboard.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mn-beacon-baseboard.dtsi
@@ -43,6 +43,17 @@ reg_audio: regulator-audio {
 		enable-active-high;
 	};
 
+	reg_camera: regulator-camera {
+		compatible = "regulator-fixed";
+		regulator-name = "mipi_pwr";
+		regulator-min-microvolt = <2800000>;
+		regulator-max-microvolt = <2800000>;
+		gpio = <&pca6416_1 0 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+		startup-delay-us = <100000>;
+		regulator-always-on;
+	};
+
 	reg_usdhc2_vmmc: regulator-usdhc2 {
 		compatible = "regulator-fixed";
 		regulator-name = "vsd_3v3";
@@ -96,6 +107,36 @@ eeprom@0 {
 	};
 };
 
+&i2c2 {
+	clock-frequency = <384000>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_i2c2>;
+	status = "okay";
+
+	camera@10 {
+		compatible = "ovti,ov5640";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_ov5640>;
+		reg = <0x10>;
+		clocks = <&clk IMX8MN_CLK_CLKO1>;
+		clock-names = "xclk";
+		assigned-clocks = <&clk IMX8MN_CLK_CLKO1>;
+		assigned-clock-parents = <&clk IMX8MN_CLK_24M>;
+		assigned-clock-rates = <24000000>;
+		AVDD-supply = <&reg_camera>;  /* 2.8v */
+		powerdown-gpios = <&gpio1 7 GPIO_ACTIVE_HIGH>;
+		reset-gpios = <&gpio1 6 GPIO_ACTIVE_LOW>;
+
+		port {
+			/* MIPI CSI-2 bus endpoint */
+			ov5640_to_mipi_csi2: endpoint {
+				remote-endpoint = <&mipi_csi_in>;
+				clock-lanes = <0>;
+				data-lanes = <1 2>;
+			};
+		};
+	};
+};
 &i2c4 {
 	clock-frequency = <400000>;
 	pinctrl-names = "default";
@@ -145,11 +186,28 @@ wm8962: audio-codec@1a {
 	};
 };
 
+&isi {
+	status = "okay";
+};
+
 &easrc {
 	fsl,asrc-rate = <48000>;
 	status = "okay";
 };
 
+&mipi_csi {
+	status = "okay";
+
+	ports {
+		port@0 {
+			mipi_csi_in: endpoint {
+				remote-endpoint = <&ov5640_to_mipi_csi2>;
+				data-lanes = <1 2>;
+			};
+		};
+	};
+};
+
 &sai3 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_sai3>;
@@ -226,6 +284,14 @@ MX8MN_IOMUXC_SAI3_RXFS_GPIO4_IO28	0x41
 		>;
 	};
 
+	pinctrl_ov5640: ov5640grp {
+		fsl,pins = <
+			MX8MN_IOMUXC_GPIO1_IO07_GPIO1_IO7		0x19
+			MX8MN_IOMUXC_GPIO1_IO06_GPIO1_IO6		0x19
+			MX8MN_IOMUXC_GPIO1_IO14_CCMSRCGPCMIX_CLKO1	0x59
+		>;
+	};
+
 	pinctrl_pcal6414: pcal6414-gpiogrp {
 		fsl,pins = <
 			MX8MN_IOMUXC_SAI2_MCLK_GPIO4_IO27		0x19
-- 
2.39.2

