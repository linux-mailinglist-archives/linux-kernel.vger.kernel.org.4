Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4158669E23
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 17:29:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229482AbjAMQ3d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 11:29:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjAMQ2S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 11:28:18 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 347D17FCBA
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 08:22:53 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id tz12so53491461ejc.9
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 08:22:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fnVtvFawVpV3KJa9ONAL2rnmrZMCi9ibWg5d5qBwrac=;
        b=acuPodL80DoOMZFzgngiGVoubtTp6+GD16Nq955kKatgHpGGDs8HVsqL+cQ+CAIxEj
         6oL7TG5U7yASViqW6Td525Ft32ZORyTc5mbm5jcqCPHrJL3Y596apsJb65eHpnF4JyXP
         Miw8XkS9TL7pjJaEcyI9qnkqHiiNdHaowCMEfw9H6GvkG1MH+EsJDI9siYQwD7IJi7Ob
         fs2QtgkxW02baDkUXV15x9nC3yexaRj/+tC1jJJWg4FgtgEwur1hOwV2Vs8jcMAFtczP
         IfoEKJpufOhtNXYSpAsks4/ta0lm7iAmXGrkmAfByF8ksz4lND4/F+NkX/hB3wtnlgqD
         8HwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fnVtvFawVpV3KJa9ONAL2rnmrZMCi9ibWg5d5qBwrac=;
        b=C2KapGhpUD8kYZhZha6YUEGMZYnR8WHWl+q3Y3CGmxTJbdX2IcDjZro4aDwmAp7h6N
         8YN2fiDHN3UPxDdI4vTG2TBofMBsXe/Sve+VKwQb78BJhUdOCgdxmSujeNiScLo9FV/C
         GbDyhGpSbHvqt0P7WTF37NlPRYc5KGpROarUGhP3bgp/qmi4z8jrX8nkmu5reuWftNFy
         t2GHcJzxYQU5+moUbZ4e8rV8IuRtICsWd4twGElP4CfAoIxqdSpmByq+5xjgWmeEvTKt
         sTJRENhX2tS7AKe0KwkDbjshnizArj1WjjhWNXdwZCN260JWvlIIPOZ6dF4j+w6ZIfjt
         Z/OQ==
X-Gm-Message-State: AFqh2kqO2yUEh5vyuzlRGn6dXLnE8ap2JPSnnm41wKjuEihP2bIazgUq
        c59LwbS5GJH3snEBFFHCV3h6Xg==
X-Google-Smtp-Source: AMrXdXsHJ9+CI681M+zCj4MM0Lb9ILc5bJ8pPBP3dz0uGvp99uUw6aUb3zDXywLlskCBRaaeHoGWug==
X-Received: by 2002:a17:906:33d0:b0:854:6e3:2388 with SMTP id w16-20020a17090633d000b0085406e32388mr14219914eja.12.1673626971764;
        Fri, 13 Jan 2023 08:22:51 -0800 (PST)
Received: from krzk-bin.. ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id q1-20020a17090676c100b007c0d4d3a0c1sm8739479ejn.32.2023.01.13.08.22.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jan 2023 08:22:51 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 3/6] arm64: dts: qcom: sdm845-audio-wcd9340: commonize pinctrl
Date:   Fri, 13 Jan 2023 17:22:42 +0100
Message-Id: <20230113162245.117324-3-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230113162245.117324-1-krzysztof.kozlowski@linaro.org>
References: <20230113162245.117324-1-krzysztof.kozlowski@linaro.org>
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

Pin configuration fow WCD9340 is the same in all users, so move it to
common file to reduce the code duplication (which still allows further
customizations per board).

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../arm64/boot/dts/qcom/sdm845-audio-wcd9340.dtsi | 15 +++++++++++++++
 arch/arm64/boot/dts/qcom/sdm845-db845c.dts        | 11 -----------
 .../dts/qcom/sdm845-xiaomi-beryllium-common.dtsi  | 11 -----------
 .../arm64/boot/dts/qcom/sdm845-xiaomi-polaris.dts | 10 ----------
 .../boot/dts/qcom/sdm850-lenovo-yoga-c630.dts     | 11 -----------
 arch/arm64/boot/dts/qcom/sdm850-samsung-w737.dts  | 11 -----------
 6 files changed, 15 insertions(+), 54 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sdm845-audio-wcd9340.dtsi b/arch/arm64/boot/dts/qcom/sdm845-audio-wcd9340.dtsi
index 5bcce7d0d709..33718cb95c83 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-audio-wcd9340.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845-audio-wcd9340.dtsi
@@ -32,6 +32,10 @@ wcd9340: codec@1,0 {
 			#clock-cells = <0>;
 			clock-frequency = <9600000>;
 			clock-output-names = "mclk";
+
+			pinctrl-0 = <&wcd_intr_default>;
+			pinctrl-names = "default";
+
 			qcom,micbias1-microvolt = <1800000>;
 			qcom,micbias2-microvolt = <1800000>;
 			qcom,micbias3-microvolt = <1800000>;
@@ -67,3 +71,14 @@ swm: swm@c85 {
 		};
 	};
 };
+
+&tlmm {
+	wcd_intr_default: wcd-intr-default-state {
+		pins = "gpio54";
+		function = "gpio";
+
+		input-enable;
+		bias-pull-down;
+		drive-strength = <2>;
+	};
+};
diff --git a/arch/arm64/boot/dts/qcom/sdm845-db845c.dts b/arch/arm64/boot/dts/qcom/sdm845-db845c.dts
index 3726465acbde..33ec79afbb62 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-db845c.dts
+++ b/arch/arm64/boot/dts/qcom/sdm845-db845c.dts
@@ -971,15 +971,6 @@ sdc2_card_det_n: sd-card-det-n-state {
 		function = "gpio";
 		bias-pull-up;
 	};
-
-	wcd_intr_default: wcd-intr-default-state {
-		pins = "gpio54";
-		function = "gpio";
-
-		input-enable;
-		bias-pull-down;
-		drive-strength = <2>;
-	};
 };
 
 &uart3 {
@@ -1085,8 +1076,6 @@ &venus {
 };
 
 &wcd9340 {
-	pinctrl-0 = <&wcd_intr_default>;
-	pinctrl-names = "default";
 	clock-names = "extclk";
 	clocks = <&rpmhcc RPMH_LN_BB_CLK2>;
 	reset-gpios = <&tlmm 64 GPIO_ACTIVE_HIGH>;
diff --git a/arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium-common.dtsi b/arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium-common.dtsi
index e530a676b250..a7a3f7ce2809 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium-common.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium-common.dtsi
@@ -466,15 +466,6 @@ sdc2_card_det_n: sd-card-det-n-state {
 		function = "gpio";
 		bias-pull-up;
 	};
-
-	wcd_intr_default: wcd-intr-default-state {
-		pins = "gpio54";
-		function = "gpio";
-
-		input-enable;
-		bias-pull-down;
-		drive-strength = <2>;
-	};
 };
 
 &uart6 {
@@ -543,8 +534,6 @@ &venus {
 };
 
 &wcd9340 {
-	pinctrl-0 = <&wcd_intr_default>;
-	pinctrl-names = "default";
 	clock-names = "extclk";
 	clocks = <&rpmhcc RPMH_LN_BB_CLK2>;
 	reset-gpios = <&tlmm 64 GPIO_ACTIVE_HIGH>;
diff --git a/arch/arm64/boot/dts/qcom/sdm845-xiaomi-polaris.dts b/arch/arm64/boot/dts/qcom/sdm845-xiaomi-polaris.dts
index f81619c8a3ba..1ceeea0885b9 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-xiaomi-polaris.dts
+++ b/arch/arm64/boot/dts/qcom/sdm845-xiaomi-polaris.dts
@@ -616,14 +616,6 @@ sde_dsi_suspend: sde-dsi-suspend-state {
 		drive-strength = <2>;
 		bias-pull-down;
 	};
-
-	wcd_intr_default: wcd-intr-default-state {
-		pins = "gpio54";
-		function = "gpio";
-		input-enable;
-		bias-pull-down;
-		drive-strength = <2>;
-	};
 };
 
 &uart6 {
@@ -700,8 +692,6 @@ &venus {
 };
 
 &wcd9340 {
-	pinctrl-0 = <&wcd_intr_default>;
-	pinctrl-names = "default";
 	clock-names = "extclk";
 	clocks = <&rpmhcc RPMH_LN_BB_CLK2>;
 	reset-gpios = <&tlmm 64 GPIO_ACTIVE_HIGH>;
diff --git a/arch/arm64/boot/dts/qcom/sdm850-lenovo-yoga-c630.dts b/arch/arm64/boot/dts/qcom/sdm850-lenovo-yoga-c630.dts
index 5586c95aa1ff..f3dd0ff1d5c6 100644
--- a/arch/arm64/boot/dts/qcom/sdm850-lenovo-yoga-c630.dts
+++ b/arch/arm64/boot/dts/qcom/sdm850-lenovo-yoga-c630.dts
@@ -628,15 +628,6 @@ i2c11_hid_active: i2c11-hid-active-state {
 		drive-strength = <2>;
 	};
 
-	wcd_intr_default: wcd-intr-default-state {
-		pins = "gpio54";
-		function = "gpio";
-
-		input-enable;
-		bias-pull-down;
-		drive-strength = <2>;
-	};
-
 	lid_pin_active: lid-pin-state {
 		pins = "gpio124";
 		function = "gpio";
@@ -747,8 +738,6 @@ &venus {
 };
 
 &wcd9340 {
-	pinctrl-0 = <&wcd_intr_default>;
-	pinctrl-names = "default";
 	clock-names = "extclk";
 	clocks = <&rpmhcc RPMH_LN_BB_CLK2>;
 	reset-gpios = <&tlmm 64 GPIO_ACTIVE_HIGH>;
diff --git a/arch/arm64/boot/dts/qcom/sdm850-samsung-w737.dts b/arch/arm64/boot/dts/qcom/sdm850-samsung-w737.dts
index 40223704a2c7..fc9369eafd23 100644
--- a/arch/arm64/boot/dts/qcom/sdm850-samsung-w737.dts
+++ b/arch/arm64/boot/dts/qcom/sdm850-samsung-w737.dts
@@ -552,15 +552,6 @@ pen_rst_l: pen-rst-l-state {
 		 */
 		output-high;
 	};
-
-	wcd_intr_default: wcd-intr-default-state {
-		pins = "gpio54";
-		function = "gpio";
-
-		input-enable;
-		bias-pull-down;
-		drive-strength = <2>;
-	};
 };
 
 &uart6 {
@@ -656,8 +647,6 @@ &venus {
 };
 
 &wcd9340 {
-	pinctrl-0 = <&wcd_intr_default>;
-	pinctrl-names = "default";
 	clock-names = "extclk";
 	clocks = <&rpmhcc RPMH_LN_BB_CLK2>;
 	reset-gpios = <&tlmm 64 GPIO_ACTIVE_HIGH>;
-- 
2.34.1

