Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4CF069254B
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 19:25:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233035AbjBJSZY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 13:25:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232990AbjBJSZV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 13:25:21 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9F3E61D2B;
        Fri, 10 Feb 2023 10:25:19 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id p26so18117816ejx.13;
        Fri, 10 Feb 2023 10:25:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XuwRMKnXVYShc3P97jDcb26qSE0+haHJPdzfJ4jdlqw=;
        b=pSxAbA2+FG3gPP+UFueQU6KD/r1XwB9gdLl8GEWhj8qXxrmwgi3uvSkTVkH2nln/98
         S2mpguECWVgHXrevhaIPbW7+EYm2lldR0Mw0FtvHEq6AaDQ7ZWIkEKYHLKrEzFZV2jBR
         nK3gotcHYrlLlpFLHHLOexSFRXeYddRXrTRCm/yqf3cGgY3OE/GrxeYHmvw3TfUoFw35
         oLDMWekqp7TVLaruIbyrgQq4tmjlylboR0mvANrkypIHHirNVdCtIU59GIZopjJ9wL+C
         ++76MeI37cuDyqFHG2xG8wUB9GN9XogSgK80HhAHu1bcA6HOX+RKigT6iRUaLKM9sbXj
         QRuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XuwRMKnXVYShc3P97jDcb26qSE0+haHJPdzfJ4jdlqw=;
        b=AcEQvEXYTjXd3oNQGoAuRdkkJBhzuXzwUP58dsFXi2zj3xniwU5GRUgCcDndvIDAvC
         cHcTGCxmxxpaPTjY0uxfAKnAYUwa9Tsp1colONsQX0gtBV4RP9FQcWTYE5yKHgnbCS1a
         jdFW1Zk4Yh2kfuMgIhaMY6xcTuuh8SziUbmbPt6H1VivTUW90G+BKLlis+rA9Bx7xyOd
         n2qDHGj0+h0OAvhMsl+s5dPjymixJAovPVt9QUtTXhWgW6tZ3F/ZZceAldUSGJI07y01
         XUyuIp3k9hRakM8sKpEGKYpzI3HtRCCNQRGQh+NmRdrVLpVNr+MFmYyZ1lRote2rm/E9
         TjUw==
X-Gm-Message-State: AO0yUKUP7pLmeuBKp74RKJVBp7h9dY8Wr+bQfM3aMq/v/pfsqQoT1Rqs
        A3guRYH1e8ac9wxOMbiuJTxgEEf13NyNRUAUFxY=
X-Google-Smtp-Source: AK7set9KKmd/XMoxaSFG+41MnGmoEWfK0335H5K/dBcod/4BoKwJVmS9dtDaVS/wURUS+y5HMR0jXw==
X-Received: by 2002:a17:907:20cb:b0:87f:89f2:c012 with SMTP id qq11-20020a17090720cb00b0087f89f2c012mr17409171ejb.24.1676053518552;
        Fri, 10 Feb 2023 10:25:18 -0800 (PST)
Received: from arinc9-PC.lan ([37.120.152.236])
        by smtp.gmail.com with ESMTPSA id 4-20020a170906024400b008aef19f678asm2708966ejl.165.2023.02.10.10.25.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Feb 2023 10:25:18 -0800 (PST)
From:   arinc9.unal@gmail.com
X-Google-Original-From: arinc.unal@arinc9.com
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     =?UTF-8?q?Ar=C4=B1n=C3=A7=20=C3=9CNAL?= <arinc.unal@arinc9.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Frank Wunderlich <frank-w@public-files.de>,
        erkin.bozoglu@xeront.com
Subject: [PATCH v3 1/5] arm: dts: mt7623: add gmacs to mt7623.dtsi
Date:   Fri, 10 Feb 2023 21:25:01 +0300
Message-Id: <20230210182505.24597-2-arinc.unal@arinc9.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230210182505.24597-1-arinc.unal@arinc9.com>
References: <20230210182505.24597-1-arinc.unal@arinc9.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arınç ÜNAL <arinc.unal@arinc9.com>

There are two gigabit MACs on the MT7623AI and MT7623NI SoCs. Add them to
mt7623.dtsi and adjust the DTs that call mt7623.dtsi.

Now that there are labels for the MACs, remove them from under &eth on the
DTs that call mt7623.dtsi. Remove the unnecessary mdio label from Bananapi
BPI-R2.

Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
---
 arch/arm/boot/dts/mt7623.dtsi                 | 12 +++++++
 arch/arm/boot/dts/mt7623a-rfb-emmc.dts        | 21 ++++++------
 arch/arm/boot/dts/mt7623a-rfb-nand.dts        | 21 ++++++------
 arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dts | 23 +++++++------
 arch/arm/boot/dts/mt7623n-rfb-emmc.dts        | 32 +++++++++----------
 5 files changed, 58 insertions(+), 51 deletions(-)

diff --git a/arch/arm/boot/dts/mt7623.dtsi b/arch/arm/boot/dts/mt7623.dtsi
index 25d31e40a553..2bc3c49dc3df 100644
--- a/arch/arm/boot/dts/mt7623.dtsi
+++ b/arch/arm/boot/dts/mt7623.dtsi
@@ -981,6 +981,18 @@ eth: ethernet@1b100000 {
 		#address-cells = <1>;
 		#size-cells = <0>;
 		status = "disabled";
+
+		gmac0: mac@0 {
+			compatible = "mediatek,eth-mac";
+			reg = <0>;
+			status = "disabled";
+		};
+
+		gmac1: mac@1 {
+			compatible = "mediatek,eth-mac";
+			reg = <1>;
+			status = "disabled";
+		};
 	};
 
 	crypto: crypto@1b240000 {
diff --git a/arch/arm/boot/dts/mt7623a-rfb-emmc.dts b/arch/arm/boot/dts/mt7623a-rfb-emmc.dts
index e8b4b6d30d19..a64d68b6e165 100644
--- a/arch/arm/boot/dts/mt7623a-rfb-emmc.dts
+++ b/arch/arm/boot/dts/mt7623a-rfb-emmc.dts
@@ -112,20 +112,19 @@ &crypto {
 	status = "okay";
 };
 
-&eth {
+&gmac0 {
 	status = "okay";
+	phy-mode = "trgmii";
 
-	gmac0: mac@0 {
-		compatible = "mediatek,eth-mac";
-		reg = <0>;
-		phy-mode = "trgmii";
-
-		fixed-link {
-			speed = <1000>;
-			full-duplex;
-			pause;
-		};
+	fixed-link {
+		speed = <1000>;
+		full-duplex;
+		pause;
 	};
+};
+
+&eth {
+	status = "okay";
 
 	mdio-bus {
 		#address-cells = <1>;
diff --git a/arch/arm/boot/dts/mt7623a-rfb-nand.dts b/arch/arm/boot/dts/mt7623a-rfb-nand.dts
index 61f5da68d4b0..fac3ca0322c8 100644
--- a/arch/arm/boot/dts/mt7623a-rfb-nand.dts
+++ b/arch/arm/boot/dts/mt7623a-rfb-nand.dts
@@ -116,20 +116,19 @@ &crypto {
 	status = "okay";
 };
 
-&eth {
+&gmac0 {
 	status = "okay";
+	phy-mode = "trgmii";
 
-	gmac0: mac@0 {
-		compatible = "mediatek,eth-mac";
-		reg = <0>;
-		phy-mode = "trgmii";
-
-		fixed-link {
-			speed = <1000>;
-			full-duplex;
-			pause;
-		};
+	fixed-link {
+		speed = <1000>;
+		full-duplex;
+		pause;
 	};
+};
+
+&eth {
+	status = "okay";
 
 	mdio-bus {
 		#address-cells = <1>;
diff --git a/arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dts b/arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dts
index 5008115d2494..1e03a3de654f 100644
--- a/arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dts
+++ b/arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dts
@@ -171,22 +171,21 @@ dpi0_out: endpoint {
 	};
 };
 
-&eth {
+&gmac0 {
 	status = "okay";
+	phy-mode = "trgmii";
 
-	gmac0: mac@0 {
-		compatible = "mediatek,eth-mac";
-		reg = <0>;
-		phy-mode = "trgmii";
-
-		fixed-link {
-			speed = <1000>;
-			full-duplex;
-			pause;
-		};
+	fixed-link {
+		speed = <1000>;
+		full-duplex;
+		pause;
 	};
+};
+
+&eth {
+	status = "okay";
 
-	mdio: mdio-bus {
+	mdio-bus {
 		#address-cells = <1>;
 		#size-cells = <0>;
 
diff --git a/arch/arm/boot/dts/mt7623n-rfb-emmc.dts b/arch/arm/boot/dts/mt7623n-rfb-emmc.dts
index bf67a8e9be59..5e328c2a6a6e 100644
--- a/arch/arm/boot/dts/mt7623n-rfb-emmc.dts
+++ b/arch/arm/boot/dts/mt7623n-rfb-emmc.dts
@@ -156,27 +156,25 @@ dpi0_out: endpoint {
 	};
 };
 
-&eth {
+&gmac0 {
 	status = "okay";
+	phy-mode = "trgmii";
 
-	gmac0: mac@0 {
-		compatible = "mediatek,eth-mac";
-		reg = <0>;
-		phy-mode = "trgmii";
-
-		fixed-link {
-			speed = <1000>;
-			full-duplex;
-			pause;
-		};
+	fixed-link {
+		speed = <1000>;
+		full-duplex;
+		pause;
 	};
+};
 
-	mac@1 {
-		compatible = "mediatek,eth-mac";
-		reg = <1>;
-		phy-mode = "rgmii";
-		phy-handle = <&phy5>;
-	};
+&gmac1 {
+	status = "okay";
+	phy-mode = "rgmii";
+	phy-handle = <&phy5>;
+};
+
+&eth {
+	status = "okay";
 
 	mdio-bus {
 		#address-cells = <1>;
-- 
2.37.2

