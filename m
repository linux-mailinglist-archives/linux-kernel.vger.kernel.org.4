Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C225A6AFFDE
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 08:36:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230020AbjCHHgR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 02:36:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229754AbjCHHfi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 02:35:38 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88D3D84816;
        Tue,  7 Mar 2023 23:35:31 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id s11so62021969edy.8;
        Tue, 07 Mar 2023 23:35:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678260930;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=39MKY2PBggsOqLz16dtI8J1bAyc0BT5d5OTGVqhjQKs=;
        b=QHNf0aLV0JBCmKc7lo9CAcdqetX0+L7WO5mOJT6e1MG2iD5mPktKd8CpCvITismNE8
         nAZbon1hMTDWH09FXCFpkBeJiqt4LhWe0frq9/LtZIhSMrd8Er0+VvpimR8KbJtjHFZe
         ShlFEbH/K7Vpz65ubEXRTnjKglid7YAbP9NQGR+tKBzWZX8mv1S7YANnYTRcJ7fh6OhS
         NyHDOUMasETq8xtiwNndMKQlL24TffXN4qtUUmF1S97ASdNp57vJTJ5a5yUYaWsouYCS
         Nq94fWqucEqCW9D9ZJLVLFlL6HRf2w01sjBcWaUZtNoVQ+Tkcv5U6QGtKjsyMAFomo6p
         /ogQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678260930;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=39MKY2PBggsOqLz16dtI8J1bAyc0BT5d5OTGVqhjQKs=;
        b=fea7K7hBLItL09xpdVX4qJ/Muun87JXJFYnV/48gpb2AAZ2VuCmo+G2quBkm6Q1+7r
         vTsQS4YGer9BhUF0NrphDEqjfB4SOsct1d0CDXUaLidsRB/kEwCp/47DNu1gXCs5YkBT
         VELfnr52GjRXCMYGjPcZyMZu8w6+NztZJhTFuYBOqU507T65GhRPCig9RMtFiNmvBkP4
         nzRHA6fBvj69rYkIrsKquJ04vUAeEOJSUDPc4Br5eooy3LTjSKpqP8O7HGP5eMnaoILO
         +TFSBrYh1vd21NdJyaW9T1TOXrCsypaGlY41TwHfKC5+UB39d2l7EeK2+8sdeBL/CfGU
         VMag==
X-Gm-Message-State: AO0yUKVrBwtu1g4Fln8Zc2r592CRFWhrAmjHBr+b8hklckVogk+XfGFt
        WUqDM0fzn8Tq9JMGatWCEAU=
X-Google-Smtp-Source: AK7set8ZGa8fQHr0KjSuQKfjIPJyG5o7GhZibY+r358ltED0FvEzlU0aKzEoqt3sLzCE8W9a4IOqnw==
X-Received: by 2002:a05:6402:1810:b0:4ab:ec2:3cd1 with SMTP id g16-20020a056402181000b004ab0ec23cd1mr15708604edy.25.1678260930042;
        Tue, 07 Mar 2023 23:35:30 -0800 (PST)
Received: from xeon.. ([188.163.112.76])
        by smtp.gmail.com with ESMTPSA id h15-20020a1709062dcf00b008dffda52d71sm7051880eji.124.2023.03.07.23.35.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Mar 2023 23:35:29 -0800 (PST)
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
Subject: [PATCH v2 6/8] ARM: tegra: transformers: bind RT5631 sound nodes
Date:   Wed,  8 Mar 2023 09:35:00 +0200
Message-Id: <20230308073502.5421-7-clamor95@gmail.com>
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

TF201, TF300TG and TF700T support RT5631 codec.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 arch/arm/boot/dts/tegra30-asus-tf201.dts   | 17 +++++++++++++++++
 arch/arm/boot/dts/tegra30-asus-tf300tg.dts | 17 +++++++++++++++++
 arch/arm/boot/dts/tegra30-asus-tf700t.dts  | 17 +++++++++++++++++
 3 files changed, 51 insertions(+)

diff --git a/arch/arm/boot/dts/tegra30-asus-tf201.dts b/arch/arm/boot/dts/tegra30-asus-tf201.dts
index 315c6dc068c5..47865deeb88a 100644
--- a/arch/arm/boot/dts/tegra30-asus-tf201.dts
+++ b/arch/arm/boot/dts/tegra30-asus-tf201.dts
@@ -605,6 +605,23 @@ haptic-feedback {
 		enable-gpios = <&gpio TEGRA_GPIO(H, 7) GPIO_ACTIVE_HIGH>;
 		vcc-supply = <&vdd_3v3_sys>;
 	};
+
+	sound {
+		compatible = "asus,tegra-audio-rt5631-tf201",
+			     "nvidia,tegra-audio-rt5631";
+		nvidia,model = "Asus Transformer Prime TF201 RT5631";
+
+		nvidia,audio-routing =
+			"Headphone Jack", "HPOL",
+			"Headphone Jack", "HPOR",
+			"Int Spk", "SPOL",
+			"Int Spk", "SPOR",
+			"MIC1", "MIC Bias1",
+			"MIC Bias1", "Headset Mic",
+			"DMIC", "Int Mic";
+
+		nvidia,audio-codec = <&rt5631>;
+	};
 };
 
 &emc_icc_dvfs_opp_table {
diff --git a/arch/arm/boot/dts/tegra30-asus-tf300tg.dts b/arch/arm/boot/dts/tegra30-asus-tf300tg.dts
index 96345f821c3d..82c51e177a70 100644
--- a/arch/arm/boot/dts/tegra30-asus-tf300tg.dts
+++ b/arch/arm/boot/dts/tegra30-asus-tf300tg.dts
@@ -1072,6 +1072,23 @@ timing-667000000 {
 	display-panel {
 		compatible = "innolux,g101ice-l01";
 	};
+
+	sound {
+		compatible = "asus,tegra-audio-rt5631-tf300tg",
+			     "nvidia,tegra-audio-rt5631";
+		nvidia,model = "Asus Transformer Pad TF300TG RT5631";
+
+		nvidia,audio-routing =
+			"Headphone Jack", "HPOL",
+			"Headphone Jack", "HPOR",
+			"Int Spk", "SPOL",
+			"Int Spk", "SPOR",
+			"MIC1", "MIC Bias1",
+			"MIC Bias1", "Headset Mic",
+			"DMIC", "Int Mic";
+
+		nvidia,audio-codec = <&rt5631>;
+	};
 };
 
 &emc_icc_dvfs_opp_table {
diff --git a/arch/arm/boot/dts/tegra30-asus-tf700t.dts b/arch/arm/boot/dts/tegra30-asus-tf700t.dts
index 1a331dec3cfe..766225ebdeab 100644
--- a/arch/arm/boot/dts/tegra30-asus-tf700t.dts
+++ b/arch/arm/boot/dts/tegra30-asus-tf700t.dts
@@ -812,6 +812,23 @@ vdd_1v2_mipi: regulator-mipi {
 		enable-active-high;
 		vin-supply = <&vdd_3v3_sys>;
 	};
+
+	sound {
+		compatible = "asus,tegra-audio-rt5631-tf700t",
+			     "nvidia,tegra-audio-rt5631";
+		nvidia,model = "Asus Transformer Infinity TF700T RT5631";
+
+		nvidia,audio-routing =
+			"Headphone Jack", "HPOL",
+			"Headphone Jack", "HPOR",
+			"Int Spk", "SPOL",
+			"Int Spk", "SPOR",
+			"MIC1", "MIC Bias1",
+			"MIC Bias1", "Headset Mic",
+			"DMIC", "Int Mic";
+
+		nvidia,audio-codec = <&rt5631>;
+	};
 };
 
 &emc_icc_dvfs_opp_table {
-- 
2.37.2

