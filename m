Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B6B870B205
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 01:11:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230400AbjEUXLQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 May 2023 19:11:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230083AbjEUXLO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 May 2023 19:11:14 -0400
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95AFEC5;
        Sun, 21 May 2023 16:11:05 -0700 (PDT)
Received: by mail-io1-xd2d.google.com with SMTP id ca18e2360f4ac-76c636b6306so192558739f.3;
        Sun, 21 May 2023 16:11:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684710665; x=1687302665;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2nVhPh+AVbdoZqcTB31R1u6P0E7hg2Z9UmsS+z7GZjc=;
        b=NpZD+Rw2xmxMS3KJtKOf1YPhJq34lmSxa4BrvR2K+RQRPMFJUkfBbX9nISTibYRYUs
         D1bnu7UAPRohuOBjKLPg+No/CIM83GO+xHuhUAEZtpdV2qqgLeP3+mpJWkCB5e9bTWrf
         GUOGR/2I9ufyVS3I+obr5MICVHly25OFNC2qtHaxwrtCL06QRqjdrmM8xJzBowJEZIS7
         Ms6mjs3tW81wE7VQfrpDfxUYoQtZn4wWPqtO0NC2ibODI3EnhAcJ10mHnA7TiGGTnj5J
         bf7aDytD/QgA2yU6tE/XBxmvDf9MyRJDcZ55duCnifqUfBBO1VwodRENjZfXqdt67mHP
         RKdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684710665; x=1687302665;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2nVhPh+AVbdoZqcTB31R1u6P0E7hg2Z9UmsS+z7GZjc=;
        b=jHkDUuohF0VPChWt75zFlbuhUyAYf2HSwCEdy7mRUN1KPOZSEGOL1RECdVFD+tvsGl
         K7Edjdn4p/sGg9bK12vhWSDC9/fR9wngrhiNmSFrDg2xdbTQSkNtcRhDAzhHFhlguzNK
         Vywp/HRGTgyeU813ri6ySw/ZGcUYFvfeHbikdBs9ayhBntrGdkh6wgPqpxXHoN+eDiAh
         AMnXDDbFGX46Wj2BeHGTyOgWPbmwUXtmXxAHgnTHbeEi7cyN2MG/MPVSzoNExb8ny+JL
         NR+uDJsAwvYgflJkC62+R5i89jYPidOE4gVoGgfzmJAI2FK6QDCFxWEuWFIDPcczB+Fm
         ErsA==
X-Gm-Message-State: AC+VfDy6aW+1BT2rUkJ/CHAgtRnwFrCqNz8Tyw70nXiIws+CNXJODidt
        qZrqH1z4MmmRR5HIrdP8mxk=
X-Google-Smtp-Source: ACHHUZ7lLqLkvJq6ql1iQtOZi5AZfrE9vfPzmk6OBw3VqXXA/4Nnssmw4jp3QCJsW/XVQytKGDDzFw==
X-Received: by 2002:a05:6602:201a:b0:760:f856:18b7 with SMTP id y26-20020a056602201a00b00760f85618b7mr5569243iod.16.1684710664711;
        Sun, 21 May 2023 16:11:04 -0700 (PDT)
Received: from aford-B741.lan ([2601:447:d001:897f:84e4:c2f6:44bb:b929])
        by smtp.gmail.com with ESMTPSA id a93-20020a029466000000b00416789bfd70sm1367468jai.1.2023.05.21.16.11.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 May 2023 16:11:04 -0700 (PDT)
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
Subject: [PATCH 2/2] arm64: dts: imx8mn-beacon: Fix SPI CS pinmux
Date:   Sun, 21 May 2023 18:10:55 -0500
Message-Id: <20230521231055.167351-2-aford173@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230521231055.167351-1-aford173@gmail.com>
References: <20230521231055.167351-1-aford173@gmail.com>
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

The final production baseboard had a different chip select than
earlier prototype boards.  When the newer board was released,
the SPI stopped working because the wrong pin was used in the device
tree and conflicted with the UART RTS. Fix the pinmux for
production boards.

Fixes: 36ca3c8ccb53 ("arm64: dts: imx: Add Beacon i.MX8M Nano development kit")
Signed-off-by: Adam Ford <aford173@gmail.com>

diff --git a/arch/arm64/boot/dts/freescale/imx8mn-beacon-baseboard.dtsi b/arch/arm64/boot/dts/freescale/imx8mn-beacon-baseboard.dtsi
index 9e82069c941f..d38745237d3c 100644
--- a/arch/arm64/boot/dts/freescale/imx8mn-beacon-baseboard.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mn-beacon-baseboard.dtsi
@@ -63,25 +63,35 @@ reg_usb_otg_vbus: regulator-usb {
 		enable-active-high;
 	};
 
-	sound {
-		compatible = "fsl,imx-audio-wm8962";
-		model = "wm8962-audio";
-		audio-cpu = <&sai3>;
-		audio-codec = <&wm8962>;
-		audio-routing =
-			"Headphone Jack", "HPOUTL",
-			"Headphone Jack", "HPOUTR",
-			"Ext Spk", "SPKOUTL",
-			"Ext Spk", "SPKOUTR",
-			"AMIC", "MICBIAS",
-			"IN3R", "AMIC";
+	sound-wm8962 {
+		compatible = "simple-audio-card";
+		simple-audio-card,name = "wm8962";
+		simple-audio-card,format = "i2s";
+		simple-audio-card,widgets = "Headphone", "Headphones",
+					    "Microphone", "Headset Mic",
+					    "Speaker", "Speaker";
+		simple-audio-card,routing = "Headphones", "HPOUTL",
+					    "Headphones", "HPOUTR",
+					    "Speaker", "SPKOUTL",
+					    "Speaker", "SPKOUTR",
+					    "Headset Mic", "MICBIAS",
+					    "IN3R", "Headset Mic";
+		simple-audio-card,cpu {
+			sound-dai = <&sai3>;
+		};
+		simple-audio-card,codec {
+			sound-dai = <&wm8962>;
+			clocks = <&clk IMX8MN_CLK_SAI3_ROOT>;
+			frame-master;
+			bitclock-master;
+		};
 	};
 };
 
 &ecspi2 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_espi2>;
-	cs-gpios = <&gpio5 9 GPIO_ACTIVE_LOW>;
+	cs-gpios = <&gpio5 13 GPIO_ACTIVE_LOW>;
 	status = "okay";
 
 	eeprom@0 {
@@ -142,6 +152,7 @@ wm8962: audio-codec@1a {
 			0x0000 /* 4:FN_DMICCDAT */
 			0x0000 /* 5:Default */
 		>;
+		#sound-dai-cells = <0>;
 	};
 };
 
@@ -202,7 +213,7 @@ pinctrl_espi2: espi2grp {
 			MX8MN_IOMUXC_ECSPI2_SCLK_ECSPI2_SCLK		0x82
 			MX8MN_IOMUXC_ECSPI2_MOSI_ECSPI2_MOSI		0x82
 			MX8MN_IOMUXC_ECSPI2_MISO_ECSPI2_MISO		0x82
-			MX8MN_IOMUXC_ECSPI1_SS0_GPIO5_IO9		0x41
+			MX8MN_IOMUXC_ECSPI2_SS0_GPIO5_IO13		0x41
 		>;
 	};
 
-- 
2.39.2

