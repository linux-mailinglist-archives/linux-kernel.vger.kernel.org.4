Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F20761F6BE
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 15:56:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232301AbiKGOz5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 09:55:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232517AbiKGOzn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 09:55:43 -0500
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 193291E3E5
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 06:55:30 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id sc25so30709327ejc.12
        for <linux-kernel@vger.kernel.org>; Mon, 07 Nov 2022 06:55:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8q5/sPJ8PzwqMDWQnWVQ3yndf3DiMrXzDKeslcAimJs=;
        b=ISQidbMpqbz3BK7Rlc6O0fxMSCHzgM7gnVXyvqBk9Mu15MujguVyxgs2itrVqI7nYe
         HZuFyoeww4VBkSnf9vBc9N85eWXNjSq7UfBynImwcqVLUfIg8NBqZc5uuCJBWJpLr7w5
         DzJ76XTiATPQUPIPBAYMVLDsQnZh7+CNzY4JaIlFMg62S6Kg/5/cWa7pmTLBXpA58l+u
         MbpHsGBI0I20xtYQW7t6r1IWGEDtPgBq4wtVAIGdr/qNLG7B7E9e5c4HXyl0+qR6Tqh4
         +fzrCEQATBAVBI61Ln+HAX1YmD1CEjFv6oJZ6ov8uUMmqSvbLsFjeMIlVnbxE3h/+Jf+
         20IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8q5/sPJ8PzwqMDWQnWVQ3yndf3DiMrXzDKeslcAimJs=;
        b=qyDmBYYRIXoYCxqrOx4rgHjn//aiZZLp07fjYYUuTN0PJdksx7RjmLnHQJQhQLcE+J
         ePjXztT7jrwKfmapnECmioQZ/Dx27to6TlXXLc+bmg78vhT7K0pE5dcZ45nXfutMPOHD
         7S2ls3C3YjVuJQQY+YUZVC6ky5Rpr7ZxwP9Ki4v1gAcS6Fagzn02WoavbZeF/iQiP/Mc
         H7nALoJehfYK/2r07fVEZmZX6vup8YY7deEtrMf7xSH4vSeFvw+SAOusAg0YWw/DmvZA
         hIkgz09KwaUbqGC2teJ2l0J2SoN63Zdnpd4Z5O2rIA6jSfVb8cttSxParraNiNHDgKTM
         zwOA==
X-Gm-Message-State: ACrzQf3zpIeSs0uQVWptmgW6T8ZiquA9gL/oiNLlNE2x6ka4Rn4GsgXp
        6wBxMD8L/Jq/R5pGEaIIMUlxZw==
X-Google-Smtp-Source: AMsMyM5LMGVcC2wSuMoQAfKDTU4V4JzRtSwZlFPg0NXTsJbwLwSk83XT9ULRZii1ijHeO6kXEANWlA==
X-Received: by 2002:a17:907:7da8:b0:7ae:2278:ba02 with SMTP id oz40-20020a1709077da800b007ae2278ba02mr21050301ejc.326.1667832928544;
        Mon, 07 Nov 2022 06:55:28 -0800 (PST)
Received: from localhost.localdomain ([194.29.137.22])
        by smtp.gmail.com with ESMTPSA id d1-20020a1709067f0100b0078907275a44sm3503049ejr.42.2022.11.07.06.55.26
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 07 Nov 2022 06:55:27 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
To:     linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org, krzysztof.kozlowski@linaro.org
Cc:     patches@linaro.org, Konrad Dybcio <konrad.dybcio@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 01/11] arm64: dts: qcom: msm/apq8x16-*: Fix up comments
Date:   Mon,  7 Nov 2022 15:55:11 +0100
Message-Id: <20221107145522.6706-2-konrad.dybcio@linaro.org>
X-Mailer: git-send-email 2.32.0 (Apple Git-132)
In-Reply-To: <20221107145522.6706-1-konrad.dybcio@linaro.org>
References: <20221107145522.6706-1-konrad.dybcio@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Switch '//' comments to C-style /* */ and fix up the contents of some.
Make sure all multiline C-style commends begin with just '/*' with
the comment text starting on a new line.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 arch/arm64/boot/dts/qcom/apq8016-sbc.dts               |  2 +-
 arch/arm64/boot/dts/qcom/msm8916-huawei-g7.dts         |  4 +++-
 arch/arm64/boot/dts/qcom/msm8916-longcheer-l8150.dts   |  6 +++---
 arch/arm64/boot/dts/qcom/msm8916-pins.dtsi             |  2 +-
 arch/arm64/boot/dts/qcom/msm8916-samsung-serranove.dts |  4 +++-
 arch/arm64/boot/dts/qcom/msm8916-wingtech-wt88047.dts  |  4 +++-
 arch/arm64/boot/dts/qcom/msm8916.dtsi                  | 10 +++++-----
 7 files changed, 19 insertions(+), 13 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/apq8016-sbc.dts b/arch/arm64/boot/dts/qcom/apq8016-sbc.dts
index 1b613098fb4a..334f28385716 100644
--- a/arch/arm64/boot/dts/qcom/apq8016-sbc.dts
+++ b/arch/arm64/boot/dts/qcom/apq8016-sbc.dts
@@ -839,7 +839,7 @@ ls_exp_gpio_f: pm8916-mpp4-state {
 		function = "digital";
 
 		output-low;
-		power-source = <PM8916_MPP_L5>;	// 1.8V
+		power-source = <PM8916_MPP_L5>;	/* 1.8V */
 	};
 
 	pm8916_mpps_leds: pm8916-mpps-state {
diff --git a/arch/arm64/boot/dts/qcom/msm8916-huawei-g7.dts b/arch/arm64/boot/dts/qcom/msm8916-huawei-g7.dts
index 9e470c67274e..93e95ff41d08 100644
--- a/arch/arm64/boot/dts/qcom/msm8916-huawei-g7.dts
+++ b/arch/arm64/boot/dts/qcom/msm8916-huawei-g7.dts
@@ -1,5 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0-only
-// Copyright (C) 2021 Stephan Gerhold
+/*
+ * Copyright (C) 2021 Stephan Gerhold
+ */
 
 /dts-v1/;
 
diff --git a/arch/arm64/boot/dts/qcom/msm8916-longcheer-l8150.dts b/arch/arm64/boot/dts/qcom/msm8916-longcheer-l8150.dts
index d85e7f7c0835..c158f884d29e 100644
--- a/arch/arm64/boot/dts/qcom/msm8916-longcheer-l8150.dts
+++ b/arch/arm64/boot/dts/qcom/msm8916-longcheer-l8150.dts
@@ -22,7 +22,7 @@ chosen {
 	};
 
 	reserved-memory {
-		// wcnss.mdt is not relocatable, so it must be loaded at 0x8b600000
+		/* wcnss.mdt is not relocatable, so it must be loaded at 0x8b600000 */
 		/delete-node/ wcnss@89300000;
 
 		wcnss_mem: wcnss@8b600000 {
@@ -204,12 +204,12 @@ rmi4@20 {
 
 		rmi4-f01@1 {
 			reg = <0x1>;
-			syna,nosleep-mode = <1>; // Allow sleeping
+			syna,nosleep-mode = <1>; /* Allow sleeping */
 		};
 
 		rmi4-f12@12 {
 			reg = <0x12>;
-			syna,sensor-type = <1>; // Touchscreen
+			syna,sensor-type = <1>; /* Touchscreen */
 		};
 	};
 };
diff --git a/arch/arm64/boot/dts/qcom/msm8916-pins.dtsi b/arch/arm64/boot/dts/qcom/msm8916-pins.dtsi
index 7dedb91b9930..1bb7df185ac4 100644
--- a/arch/arm64/boot/dts/qcom/msm8916-pins.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8916-pins.dtsi
@@ -6,7 +6,7 @@
 &msmgpio {
 
 	blsp1_uart1_default: blsp1-uart1-default {
-		//	TX, RX, CTS_N, RTS_N
+		/* TX, RX, CTS_N, RTS_N */
 		pins = "gpio0", "gpio1", "gpio2", "gpio3";
 		function = "blsp_uart1";
 
diff --git a/arch/arm64/boot/dts/qcom/msm8916-samsung-serranove.dts b/arch/arm64/boot/dts/qcom/msm8916-samsung-serranove.dts
index bbd6bb3f4fd7..73f980a4b213 100644
--- a/arch/arm64/boot/dts/qcom/msm8916-samsung-serranove.dts
+++ b/arch/arm64/boot/dts/qcom/msm8916-samsung-serranove.dts
@@ -1,5 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0-only
-// Copyright (C) 2019 Stephan Gerhold
+/*
+ * Copyright (C) 2019 Stephan Gerhold
+ */
 
 /dts-v1/;
 
diff --git a/arch/arm64/boot/dts/qcom/msm8916-wingtech-wt88047.dts b/arch/arm64/boot/dts/qcom/msm8916-wingtech-wt88047.dts
index 84a352dcf9a2..147e187fc403 100644
--- a/arch/arm64/boot/dts/qcom/msm8916-wingtech-wt88047.dts
+++ b/arch/arm64/boot/dts/qcom/msm8916-wingtech-wt88047.dts
@@ -1,5 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0-only
-// Copyright (C) 2020 Stephan Gerhold
+/*
+ * Copyright (C) 2020 Stephan Gerhold
+ */
 
 /dts-v1/;
 
diff --git a/arch/arm64/boot/dts/qcom/msm8916.dtsi b/arch/arm64/boot/dts/qcom/msm8916.dtsi
index a60eb8a59dca..d7af9318b1cc 100644
--- a/arch/arm64/boot/dts/qcom/msm8916.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8916.dtsi
@@ -1263,21 +1263,21 @@ apps_iommu: iommu@1ef0000 {
 			clock-names = "iface", "bus";
 			qcom,iommu-secure-id = <17>;
 
-			// vfe:
+			/* VFE */
 			iommu-ctx@3000 {
 				compatible = "qcom,msm-iommu-v1-sec";
 				reg = <0x3000 0x1000>;
 				interrupts = <GIC_SPI 70 IRQ_TYPE_LEVEL_HIGH>;
 			};
 
-			// mdp_0:
+			/* MDP_0 */
 			iommu-ctx@4000 {
 				compatible = "qcom,msm-iommu-v1-ns";
 				reg = <0x4000 0x1000>;
 				interrupts = <GIC_SPI 70 IRQ_TYPE_LEVEL_HIGH>;
 			};
 
-			// venus_ns:
+			/* VENUS_NS */
 			iommu-ctx@5000 {
 				compatible = "qcom,msm-iommu-v1-sec";
 				reg = <0x5000 0x1000>;
@@ -1296,14 +1296,14 @@ gpu_iommu: iommu@1f08000 {
 			clock-names = "iface", "bus";
 			qcom,iommu-secure-id = <18>;
 
-			// gfx3d_user:
+			/* GFX3D_USER */
 			iommu-ctx@1000 {
 				compatible = "qcom,msm-iommu-v1-ns";
 				reg = <0x1000 0x1000>;
 				interrupts = <GIC_SPI 241 IRQ_TYPE_LEVEL_HIGH>;
 			};
 
-			// gfx3d_priv:
+			/* GFX3D_PRIV */
 			iommu-ctx@2000 {
 				compatible = "qcom,msm-iommu-v1-ns";
 				reg = <0x2000 0x1000>;
-- 
2.38.1

