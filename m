Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A53C6CA889
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 17:04:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232542AbjC0PD5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 11:03:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231913AbjC0PDt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 11:03:49 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C93AB30E9;
        Mon, 27 Mar 2023 08:03:02 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id y20so11888274lfj.2;
        Mon, 27 Mar 2023 08:03:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679929355;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2R4nSlYFpaaH1DqF4jj0/gkMQlHMptuPEzO27FqolJo=;
        b=dubQc+BhyIhjUBjsrxSypFOxYNUAUdqwcqNRv5KT/H7U9kLkCCMwgi60P/Tj+5l4AK
         PbVARzOcfiC+4NdYIgtzVfIP45ZquR37GxTHP1q5vJeAhACvKRxrOd6vTrgdhHB6sDCo
         EpYy9jYsqmzci0i4RpmKuPO8WxcxHZw4sGnjElFDi7yMaQzUZfs7JE/9kdf/0JMpjo46
         EC/apoUdozU7dunUaC4H+ssmcbVkHFWn4Vx2JBGPSQ2t5CRQwakBnssfe2iW6WtVwnCu
         HJqdF4sWilSMC9/NqzJ9YYothjf+z/hC4A+HVQNMqOtQxycte7NfNiUXdLZWvUDlKaxr
         dz8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679929355;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2R4nSlYFpaaH1DqF4jj0/gkMQlHMptuPEzO27FqolJo=;
        b=d4lCsa8Jx/1OHfSKl7PBZFQM573xplQNhTLY4nkjjTGGQJ/8h361Qxlqh4wuIJKfM6
         vMiXbP5whUjohzPnj/Lo8v/rZM1OpWRP1k5sbHMC+SoRUNIFtg7qqVRufCYHUJkcZueh
         vSy4+IXMZ3f3jmD6OR+jz4Z2dGHvQBUlnYZXLlpDsyWXqzfo3kKeWMZai5ijcrYcklvk
         j2jqlUbx55MfXx4e+TYSCcIsTzXHtZOf7g7MGw9qpd5eeY8Y2EidG0U0YoSqNqza90hK
         fdhJDJOMisdJmt9dBhLkEpIQhf+3qthzplchWVmdlo0cPa8ZLoYkgkD0/8/biqGKVNrh
         DStg==
X-Gm-Message-State: AAQBX9cbwY0FTygDwp9N1ozpUD4D0eKo66+qRw3t7jXh3iHqiWu7PyCR
        iyaOD8KNuNhGRALqJpj0oC8=
X-Google-Smtp-Source: AKy350a0RulKKfAGKOX/qGSFAiGfDfzbPANsHACrrH2PIPH2ItMZDBxgn44MjP/oEaqzbf7Ar8UTzg==
X-Received: by 2002:ac2:51c7:0:b0:4ea:f7be:e06e with SMTP id u7-20020ac251c7000000b004eaf7bee06emr3340230lfm.17.1679929355367;
        Mon, 27 Mar 2023 08:02:35 -0700 (PDT)
Received: from xeon.. ([188.163.112.76])
        by smtp.gmail.com with ESMTPSA id f4-20020a19ae04000000b0049ad2619becsm4706923lfc.131.2023.03.27.08.02.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Mar 2023 08:02:35 -0700 (PDT)
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
Subject: [PATCH v4 1/2] ARM: tegra: transformers: update WM8903 sound nodes
Date:   Mon, 27 Mar 2023 18:02:18 +0300
Message-Id: <20230327150219.13636-2-clamor95@gmail.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230327150219.13636-1-clamor95@gmail.com>
References: <20230327150219.13636-1-clamor95@gmail.com>
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
- use device GPIO mic detection on wm8903 transformers;

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 arch/arm/boot/dts/tegra20-asus-tf101.dts            | 13 +++++++------
 arch/arm/boot/dts/tegra30-asus-tf300t.dts           |  6 ++----
 .../boot/dts/tegra30-asus-transformer-common.dtsi   |  9 +++++----
 3 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/arch/arm/boot/dts/tegra20-asus-tf101.dts b/arch/arm/boot/dts/tegra20-asus-tf101.dts
index 7b2969656ec9..3f1da75a2736 100644
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
+			"DMICDAT", "Int Mic";
 
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
index 506ae3626731..970a1f08dc8c 100644
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
 			"DMICDAT", "Int Mic";
 
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

