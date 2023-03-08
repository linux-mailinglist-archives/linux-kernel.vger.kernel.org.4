Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BCBF6AFFD9
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 08:35:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229966AbjCHHf4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 02:35:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229657AbjCHHfg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 02:35:36 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CCF72FCF4;
        Tue,  7 Mar 2023 23:35:28 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id k10so38121569edk.13;
        Tue, 07 Mar 2023 23:35:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678260926;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Sw6Zqne2z7YifJ5cyYa9t+wWI0sG16wXBTs6NvHN/Wk=;
        b=H5ySkeSBojKDLn9ziiQj/VN4R2TuGi3ptHrTGL5+4i5PLSHGhULRP4wKjh2za4ih0y
         f4ul79eEQClRwZ4ZnKbVfwJUnpet0B35mxxMelxp6jDpC+F4dGVRnRVk5keB25zkY/TJ
         DUnZM2M/Wa2cCVSY7KugZ4vC8fjO0wgOM6qWfcdkSuwqvw9FI/VP50LK5Bt0nTsDmCxm
         MqJmGjbOOg9OWnn4l4Vkq4K2ubOnb+Jv2KjkiHhX1UE38IH5XF0QQppUFdvIZI1zAd+I
         d1+CKSOIrsozHV55AVae1y4wcT7iN0iLucKtsptcPlfd7+Zxc1ULkF/DuceLxJHQR7td
         2UwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678260926;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Sw6Zqne2z7YifJ5cyYa9t+wWI0sG16wXBTs6NvHN/Wk=;
        b=XdgiyQ7vlT/qfTPAVjbw7rGJEhSJuKz6JAwAsgSJLNJUs1vo9gZ0jPHAMpzkAQVYYN
         GL0/HSv2WcPls0/l83ubblpaecyMN+P7Tb+9qKOcMnyjgsmeRzOw7WFS8p48BMOjaWm5
         TicDFTcg6076GKmKr9FVVEPniMkAbOueWz74ECQpDGa2QmmglsOt/JoBjacXEalmFx2A
         DWrVkPycRtgUNjJr6qeNs256CID4eLa5ys23a5Q8/KaMjUVZxbxZc7yRF8W4OXkCpKNr
         0LcjOWi0xg7BglsAco4qLR60epg0C+9ctF+8aJrpZDdHh6U/jA8wr9e7NSywjiBayIgf
         aabA==
X-Gm-Message-State: AO0yUKWQmEL3/7V1QqmfZqV/E6ED+qm1m7upWFznZ0pRcqn9REh2O0e9
        DZApzJAA3jMSm2H4FT1l/zo=
X-Google-Smtp-Source: AK7set8pPSSbDp1FRM8zW0XDN2Qq8wKkVkZoYOk4mWKDRu3FvSALDJN6E4fhJ33O8slvQmGDeYGYxQ==
X-Received: by 2002:a17:906:b007:b0:8aa:c038:974c with SMTP id v7-20020a170906b00700b008aac038974cmr16145441ejy.54.1678260926392;
        Tue, 07 Mar 2023 23:35:26 -0800 (PST)
Received: from xeon.. ([188.163.112.76])
        by smtp.gmail.com with ESMTPSA id h15-20020a1709062dcf00b008dffda52d71sm7051880eji.124.2023.03.07.23.35.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Mar 2023 23:35:26 -0800 (PST)
From:   Svyatoslav Ryhel <clamor95@gmail.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Svyatoslav Ryhel <clamor95@gmail.com>,
        Maxim Schwalm <maxim.schwalm@gmail.com>,
        Dmitry Osipenko <digetx@gmail.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-tegra@vger.kernel.org,
        linux-staging@lists.linux.dev
Subject: [PATCH v2 3/8] ARM: tegra: transformers: update sound nodes
Date:   Wed,  8 Mar 2023 09:34:57 +0200
Message-Id: <20230308073502.5421-4-clamor95@gmail.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230308073502.5421-1-clamor95@gmail.com>
References: <20230308073502.5421-1-clamor95@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

- fix headset detection in common device tree;
- diverge control and detect elements for mic;
- use GPIO mic detection on wm8903 devices;

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 arch/arm/boot/dts/tegra20-asus-tf101.dts               | 7 ++++---
 arch/arm/boot/dts/tegra30-asus-tf300t.dts              | 5 ++---
 arch/arm/boot/dts/tegra30-asus-transformer-common.dtsi | 9 +++++----
 3 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/arch/arm/boot/dts/tegra20-asus-tf101.dts b/arch/arm/boot/dts/tegra20-asus-tf101.dts
index c39ddb462ad0..4ed50b8300b1 100644
--- a/arch/arm/boot/dts/tegra20-asus-tf101.dts
+++ b/arch/arm/boot/dts/tegra20-asus-tf101.dts
@@ -1179,15 +1179,16 @@ sound {
 			"Int Spk", "RON",
 			"Int Spk", "LOP",
 			"Int Spk", "LON",
-			"Mic Jack", "MICBIAS",
-			"IN1L", "Mic Jack";
+			"IN1L", "Int Mic",
+			"IN2L", "Headset Mic";
 
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
index f47434871a5c..78f78cca337a 100644
--- a/arch/arm/boot/dts/tegra30-asus-tf300t.dts
+++ b/arch/arm/boot/dts/tegra30-asus-tf300t.dts
@@ -1011,13 +1011,12 @@ sound {
 			"Int Spk", "RON",
 			"Int Spk", "LOP",
 			"Int Spk", "LON",
-			"IN1L", "Mic Jack",
-			"IN2L", "Mic Jack",
+			"IN1L", "Headset Mic",
+			"IN2L", "Headset Mic",
 			"DMICDAT", "Int Mic";
 
 		nvidia,audio-codec = <&wm8903>;
 		nvidia,spkr-en-gpios = <&wm8903 2 GPIO_ACTIVE_HIGH>;
-		nvidia,headset;
 	};
 };
 
diff --git a/arch/arm/boot/dts/tegra30-asus-transformer-common.dtsi b/arch/arm/boot/dts/tegra30-asus-transformer-common.dtsi
index 08ea9cb32d0e..42dae0f4759e 100644
--- a/arch/arm/boot/dts/tegra30-asus-transformer-common.dtsi
+++ b/arch/arm/boot/dts/tegra30-asus-transformer-common.dtsi
@@ -550,7 +550,7 @@ spi1_mosi_px4 {
 				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
 			};
 
-			spi2_cs1_n_pw2 {
+			hp_detect {
 				nvidia,pins = "spi2_cs1_n_pw2";
 				nvidia,function = "spi2";
 				nvidia,pull = <TEGRA_PIN_PULL_UP>;
@@ -558,10 +558,10 @@ spi2_cs1_n_pw2 {
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

