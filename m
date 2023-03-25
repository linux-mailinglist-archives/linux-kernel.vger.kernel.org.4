Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A501F6C8C90
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Mar 2023 09:20:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231949AbjCYIUh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Mar 2023 04:20:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231629AbjCYIUc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Mar 2023 04:20:32 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36BC616AD9;
        Sat, 25 Mar 2023 01:20:30 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id j24so3889274wrd.0;
        Sat, 25 Mar 2023 01:20:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679732428;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qdYPgJ9kVAY+FX7JFEaDiM/XsHcLyA9JSPLKQoGwx+A=;
        b=nyPcGAyWU/F0iZBJn9zXNBSilQ86Zh80RQERfz9WnwWkTnpdKVgBkQtKAJGhkt7Qtb
         oMYeY+jlESJdDeRgAx97s44vd+EWMsewp4dZTPjopalYergNhC6jsCpnB6zvjz6G4vum
         c7P6d4GIkhytu4BzYQXFC62iRu5OcUKCYe3p1b3Y87LfRZPcvIjtVISNbs4BWNtuGDO+
         YUhmWfdHaGI3lrO/A54tLrI1XEdVnLc6WvbM5etK6NB4ahtoOx4CrWEUg14z9rYyYYmk
         K2HHeQPxJb2UD6o8Sk+h+LOSrmG43gYJg9397cxy2ncLgdY8zUDj6GAQBPYfk8lmXfTR
         Uzlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679732428;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qdYPgJ9kVAY+FX7JFEaDiM/XsHcLyA9JSPLKQoGwx+A=;
        b=j8UpZOPZZXRO6ZhQ/t6TPDjJEapT4VHaUDBGjywJrTtiNxccq7m73OYJbgsdCPqwSn
         6jOPO2uITfNtIvaK1j4DVpEB2tINx6RiN3dJY4dIc2HgmKBCDeW78j1Tk93pCjg5Wp7l
         YFZ26WYz5issd16ZLQ3l4MeoYs/OL7GRe1FZhfV/Vg/lNhmBMyShofdVien2bsw4EggJ
         8K5kZQUbkKF4Ftp0JXir+q/la5Xo0/YysGqRN45Ams7WsagLI8GUOl67ELHc/qywwXXC
         i8JPDdNBJsi6FHtTyh4y4qnt18NXfbjVWweR0kraAi2gYdUAjfKLAsDMPNOqz8Kxu9NH
         HeIw==
X-Gm-Message-State: AAQBX9fogADnF7CY/ePQR786uWxdt1GnlmzuyflvIFwHeNJqWOym//Es
        3qoYB20gQdOwFVs7QBHDpCC0I+2Eh/Y=
X-Google-Smtp-Source: AKy350a1dcuMNQ/PP4gN43DZzZiGjXgHUpe9apKQ0L+hd4vMV2y/K5DuveJ1FGo2WvRikjZjR0+CFw==
X-Received: by 2002:adf:e7c2:0:b0:2d3:1c7d:a396 with SMTP id e2-20020adfe7c2000000b002d31c7da396mr4345114wrn.68.1679732428688;
        Sat, 25 Mar 2023 01:20:28 -0700 (PDT)
Received: from xeon.. ([188.163.112.76])
        by smtp.gmail.com with ESMTPSA id n12-20020a5d484c000000b002c59f18674asm20175918wrs.22.2023.03.25.01.20.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Mar 2023 01:20:28 -0700 (PDT)
From:   Svyatoslav Ryhel <clamor95@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Svyatoslav Ryhel <clamor95@gmail.com>,
        Maxim Schwalm <maxim.schwalm@gmail.com>,
        Dmitry Osipenko <digetx@gmail.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org
Subject: [PATCH v3 1/2] ARM: tegra: transformers: update sound nodes
Date:   Sat, 25 Mar 2023 10:20:10 +0200
Message-Id: <20230325082011.6985-2-clamor95@gmail.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230325082011.6985-1-clamor95@gmail.com>
References: <20230325082011.6985-1-clamor95@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

- fix headset detection in common device tree;
- use GPIO mic detection on wm8903 devices;

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 arch/arm/boot/dts/tegra20-asus-tf101.dts            | 13 +++++++------
 arch/arm/boot/dts/tegra30-asus-tf300t.dts           |  8 +++-----
 .../boot/dts/tegra30-asus-transformer-common.dtsi   |  9 +++++----
 3 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/arch/arm/boot/dts/tegra20-asus-tf101.dts b/arch/arm/boot/dts/tegra20-asus-tf101.dts
index 7b2969656ec9..420481077685 100644
--- a/arch/arm/boot/dts/tegra20-asus-tf101.dts
+++ b/arch/arm/boot/dts/tegra20-asus-tf101.dts
@@ -520,10 +520,10 @@ wm8903: audio-codec@1a {
 			micdet-delay = <100>;
 
 			gpio-cfg = <
-				0xffffffff /* don't touch */
-				0xffffffff /* don't touch */
+				0x00000600 /* DMIC_LR, output */
+				0x00000680 /* DMIC_DAT, input */
 				0x00000000 /* Speaker-enable GPIO, output, low */
-				0x00000400 /* Mic bias current detect */
+				0xffffffff /* don't touch */
 				0xffffffff /* don't touch */
 			>;
 
@@ -1184,15 +1184,16 @@ sound {
 			"Int Spk", "RON",
 			"Int Spk", "LOP",
 			"Int Spk", "LON",
-			"Mic Jack", "MICBIAS",
-			"IN1L", "Mic Jack";
+			"IN2L", "Mic Jack",
+			"DMIC", "Int Mic";
 
 		nvidia,i2s-controller = <&tegra_i2s1>;
 		nvidia,audio-codec = <&wm8903>;
 
 		nvidia,spkr-en-gpios = <&wm8903 2 GPIO_ACTIVE_HIGH>;
 		nvidia,hp-det-gpios = <&gpio TEGRA_GPIO(W, 2) GPIO_ACTIVE_LOW>;
-		nvidia,headset;
+		nvidia,mic-det-gpios = <&gpio TEGRA_GPIO(X, 1) GPIO_ACTIVE_LOW>;
+		nvidia,coupled-mic-hp-det;
 
 		clocks = <&tegra_car TEGRA20_CLK_PLL_A>,
 			 <&tegra_car TEGRA20_CLK_PLL_A_OUT0>,
diff --git a/arch/arm/boot/dts/tegra30-asus-tf300t.dts b/arch/arm/boot/dts/tegra30-asus-tf300t.dts
index 506ae3626731..3ef670ca0edb 100644
--- a/arch/arm/boot/dts/tegra30-asus-tf300t.dts
+++ b/arch/arm/boot/dts/tegra30-asus-tf300t.dts
@@ -128,8 +128,8 @@ wm8903: audio-codec@1a {
 			micdet-delay = <100>;
 
 			gpio-cfg = <
-				0xffffffff /* don't touch */
-				0xffffffff /* don't touch */
+				0x00000600 /* DMIC_LR, output */
+				0x00000680 /* DMIC_DAT, input */
 				0x00000000 /* Speaker-enable GPIO, output, low */
 				0xffffffff /* don't touch */
 				0xffffffff /* don't touch */
@@ -1023,12 +1023,10 @@ sound {
 			"Int Spk", "RON",
 			"Int Spk", "LOP",
 			"Int Spk", "LON",
-			"IN1L", "Mic Jack",
 			"IN2L", "Mic Jack",
-			"DMICDAT", "Int Mic";
+			"DMIC", "Int Mic";
 
 		nvidia,audio-codec = <&wm8903>;
 		nvidia,spkr-en-gpios = <&wm8903 2 GPIO_ACTIVE_HIGH>;
-		nvidia,headset;
 	};
 };
diff --git a/arch/arm/boot/dts/tegra30-asus-transformer-common.dtsi b/arch/arm/boot/dts/tegra30-asus-transformer-common.dtsi
index 1861b2de2dc3..bdb898ad6262 100644
--- a/arch/arm/boot/dts/tegra30-asus-transformer-common.dtsi
+++ b/arch/arm/boot/dts/tegra30-asus-transformer-common.dtsi
@@ -558,7 +558,7 @@ spi1_mosi_px4 {
 				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
 			};
 
-			spi2_cs1_n_pw2 {
+			hp_detect {
 				nvidia,pins = "spi2_cs1_n_pw2";
 				nvidia,function = "spi2";
 				nvidia,pull = <TEGRA_PIN_PULL_UP>;
@@ -566,10 +566,10 @@ spi2_cs1_n_pw2 {
 				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
 			};
 
-			spi2_sck_px2 {
+			mic_detect {
 				nvidia,pins = "spi2_sck_px2";
 				nvidia,function = "spi2";
-				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,pull = <TEGRA_PIN_PULL_UP>;
 				nvidia,tristate = <TEGRA_PIN_DISABLE>;
 				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
 			};
@@ -1674,7 +1674,8 @@ sound {
 		nvidia,i2s-controller = <&tegra_i2s1>;
 
 		nvidia,hp-det-gpios = <&gpio TEGRA_GPIO(W, 2) GPIO_ACTIVE_LOW>;
-		nvidia,hp-mute-gpios = <&gpio TEGRA_GPIO(X, 2) GPIO_ACTIVE_LOW>;
+		nvidia,mic-det-gpios = <&gpio TEGRA_GPIO(X, 2) GPIO_ACTIVE_LOW>;
+		nvidia,coupled-mic-hp-det;
 
 		clocks = <&tegra_car TEGRA30_CLK_PLL_A>,
 			 <&tegra_car TEGRA30_CLK_PLL_A_OUT0>,
-- 
2.37.2

