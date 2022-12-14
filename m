Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA87064C7AB
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 12:05:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238120AbiLNLFB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 06:05:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237566AbiLNLE5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 06:04:57 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5775A10B5D
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 03:04:53 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id cf42so9840935lfb.1
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 03:04:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ksoP1SHSdumT+7EPzU7XBy01Ehvt72FwCLx6AsO5tU4=;
        b=LQh0+X0p6hye5N7aYdl1+88GM23Z0QnVnH99D+xz7z3Tovj79NkbaFik1+zAaEEhaj
         PLFiJ/P1oYp7rpDciqwzO30RbhAR7SqoXSZerovr6ONrIKgX6CVTSMenlp6ftLyNXpsb
         C916D/3cnYQuDpC9vZaz0DZNJ595i2NLlVlT1FoVqN/7JqlsYoSy6Ti7zvtbepP23Xxf
         cRs0sNaBXAE7xAVixtEbV0GIUT7YJEH8s28ZhQCZAYaH+ADvOaVlFGpWEmvMUVJ9L+Gm
         VxKfeKY+TBKxFAnlCbCVsIcKMn+Lwd1aFSGPVEfkIgt6v2auRSbXr5v2+aYeuGeG4cTW
         uMrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ksoP1SHSdumT+7EPzU7XBy01Ehvt72FwCLx6AsO5tU4=;
        b=jTdIoR1GUdvP9j43epnTajNgKoQYT87Jgwzl184kUYjlck1yLQvqwmsPnvhcBO/WXz
         lrHVHH8WfWKjUj+24Gkuuwe4WmIBfzVZtPbmAQ6Uwzqwxr9mKoWG/QjphKYOj+xEupu/
         YMRpfiHhrq6+LAZCIUSMMwppII5EEPlNZS7P9AG1CF0ZyKIBC0f3vh7gBc6HHrGuSsk/
         glmSYdlFziH0R403rgIVaFYwN2EhSQC2rFV4D6bN6275fueP5BDU5p9kY0UjbUjZIp9B
         JYzZ9Cngj8HfkyQJtO9//M2EANL9KBIqiCYyay0ivZVoQrSGQ9ODfVcDkU1GnF/On1Ql
         pBNg==
X-Gm-Message-State: ANoB5pkqgu6eotVRFYkVKA6PpPrxALaj9E0h3EbnqfK3+zNOOdUwvd0C
        MYFi3wuFm4GMspJygX2TPjj5DQ==
X-Google-Smtp-Source: AA0mqf6rohNsGnK+P551pYxGK3uzJqfSVv0bHgunzBjPCaA7Eyx/Smf8YeZEoE2zgTYUftho6zR9EA==
X-Received: by 2002:a05:6512:2215:b0:4b5:4606:7ae3 with SMTP id h21-20020a056512221500b004b546067ae3mr8303223lfu.46.1671015891512;
        Wed, 14 Dec 2022 03:04:51 -0800 (PST)
Received: from krzk-bin.NAT.warszawa.vectranet.pl (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id d20-20020a056512369400b004b55c1b5c66sm758249lfs.157.2022.12.14.03.04.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Dec 2022 03:04:51 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] arm64: dts: qcom: replace underscores in node names
Date:   Wed, 14 Dec 2022 12:04:48 +0100
Message-Id: <20221214110448.86268-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Underscores should not be used in node names (dtc with W=2 warns about
them), so replace them with hyphens.  In few places adjust the name to
match other nodes (e.g. xxx-regulator).

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/qcom/msm8916.dtsi         |  6 +--
 arch/arm64/boot/dts/qcom/msm8953.dtsi         |  4 +-
 arch/arm64/boot/dts/qcom/msm8996.dtsi         |  8 +--
 arch/arm64/boot/dts/qcom/msm8998.dtsi         | 16 +++---
 arch/arm64/boot/dts/qcom/qcs404.dtsi          | 10 ++--
 arch/arm64/boot/dts/qcom/sa8155p-adp.dts      |  2 +-
 arch/arm64/boot/dts/qcom/sc7180.dtsi          | 50 +++++++++----------
 .../dts/qcom/sdm630-sony-xperia-nile.dtsi     |  6 +--
 arch/arm64/boot/dts/qcom/sdm630.dtsi          | 10 ++--
 arch/arm64/boot/dts/qcom/sdm845-db845c.dts    |  6 +--
 arch/arm64/boot/dts/qcom/sdm845.dtsi          | 16 +++---
 .../qcom/sm6125-sony-xperia-seine-pdx201.dts  |  2 +-
 arch/arm64/boot/dts/qcom/sm8150.dtsi          | 24 ++++-----
 arch/arm64/boot/dts/qcom/sm8250.dtsi          | 24 ++++-----
 arch/arm64/boot/dts/qcom/sm8350.dtsi          | 24 ++++-----
 arch/arm64/boot/dts/qcom/sm8450.dtsi          | 30 +++++------
 16 files changed, 119 insertions(+), 119 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8916.dtsi b/arch/arm64/boot/dts/qcom/msm8916.dtsi
index 2ca8e977fc2a..dd2c9e2edeb0 100644
--- a/arch/arm64/boot/dts/qcom/msm8916.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8916.dtsi
@@ -1998,7 +1998,7 @@ cpu0_1_alert0: trip-point0 {
 					hysteresis = <2000>;
 					type = "passive";
 				};
-				cpu0_1_crit: cpu_crit {
+				cpu0_1_crit: cpu-crit {
 					temperature = <110000>;
 					hysteresis = <2000>;
 					type = "critical";
@@ -2028,7 +2028,7 @@ cpu2_3_alert0: trip-point0 {
 					hysteresis = <2000>;
 					type = "passive";
 				};
-				cpu2_3_crit: cpu_crit {
+				cpu2_3_crit: cpu-crit {
 					temperature = <110000>;
 					hysteresis = <2000>;
 					type = "critical";
@@ -2058,7 +2058,7 @@ gpu_alert0: trip-point0 {
 					hysteresis = <2000>;
 					type = "passive";
 				};
-				gpu_crit: gpu_crit {
+				gpu_crit: gpu-crit {
 					temperature = <95000>;
 					hysteresis = <2000>;
 					type = "critical";
diff --git a/arch/arm64/boot/dts/qcom/msm8953.dtsi b/arch/arm64/boot/dts/qcom/msm8953.dtsi
index 32349174c4bd..60ef163c8602 100644
--- a/arch/arm64/boot/dts/qcom/msm8953.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8953.dtsi
@@ -202,12 +202,12 @@ core3 {
 			};
 		};
 
-		L2_0: l2-cache_0 {
+		L2_0: l2-cache-0 {
 			compatible = "cache";
 			cache-level = <2>;
 		};
 
-		L2_1: l2-cache_1 {
+		L2_1: l2-cache-1 {
 			compatible = "cache";
 			cache-level = <2>;
 		};
diff --git a/arch/arm64/boot/dts/qcom/msm8996.dtsi b/arch/arm64/boot/dts/qcom/msm8996.dtsi
index d31464204f69..25616a0fe63e 100644
--- a/arch/arm64/boot/dts/qcom/msm8996.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8996.dtsi
@@ -3580,7 +3580,7 @@ cpu0_alert0: trip-point0 {
 					type = "passive";
 				};
 
-				cpu0_crit: cpu_crit {
+				cpu0_crit: cpu-crit {
 					temperature = <110000>;
 					hysteresis = <2000>;
 					type = "critical";
@@ -3601,7 +3601,7 @@ cpu1_alert0: trip-point0 {
 					type = "passive";
 				};
 
-				cpu1_crit: cpu_crit {
+				cpu1_crit: cpu-crit {
 					temperature = <110000>;
 					hysteresis = <2000>;
 					type = "critical";
@@ -3622,7 +3622,7 @@ cpu2_alert0: trip-point0 {
 					type = "passive";
 				};
 
-				cpu2_crit: cpu_crit {
+				cpu2_crit: cpu-crit {
 					temperature = <110000>;
 					hysteresis = <2000>;
 					type = "critical";
@@ -3643,7 +3643,7 @@ cpu3_alert0: trip-point0 {
 					type = "passive";
 				};
 
-				cpu3_crit: cpu_crit {
+				cpu3_crit: cpu-crit {
 					temperature = <110000>;
 					hysteresis = <2000>;
 					type = "critical";
diff --git a/arch/arm64/boot/dts/qcom/msm8998.dtsi b/arch/arm64/boot/dts/qcom/msm8998.dtsi
index 539382dab0ad..f137cdc55772 100644
--- a/arch/arm64/boot/dts/qcom/msm8998.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8998.dtsi
@@ -465,7 +465,7 @@ cpu0_alert0: trip-point0 {
 					type = "passive";
 				};
 
-				cpu0_crit: cpu_crit {
+				cpu0_crit: cpu-crit {
 					temperature = <110000>;
 					hysteresis = <2000>;
 					type = "critical";
@@ -486,7 +486,7 @@ cpu1_alert0: trip-point0 {
 					type = "passive";
 				};
 
-				cpu1_crit: cpu_crit {
+				cpu1_crit: cpu-crit {
 					temperature = <110000>;
 					hysteresis = <2000>;
 					type = "critical";
@@ -507,7 +507,7 @@ cpu2_alert0: trip-point0 {
 					type = "passive";
 				};
 
-				cpu2_crit: cpu_crit {
+				cpu2_crit: cpu-crit {
 					temperature = <110000>;
 					hysteresis = <2000>;
 					type = "critical";
@@ -528,7 +528,7 @@ cpu3_alert0: trip-point0 {
 					type = "passive";
 				};
 
-				cpu3_crit: cpu_crit {
+				cpu3_crit: cpu-crit {
 					temperature = <110000>;
 					hysteresis = <2000>;
 					type = "critical";
@@ -549,7 +549,7 @@ cpu4_alert0: trip-point0 {
 					type = "passive";
 				};
 
-				cpu4_crit: cpu_crit {
+				cpu4_crit: cpu-crit {
 					temperature = <110000>;
 					hysteresis = <2000>;
 					type = "critical";
@@ -570,7 +570,7 @@ cpu5_alert0: trip-point0 {
 					type = "passive";
 				};
 
-				cpu5_crit: cpu_crit {
+				cpu5_crit: cpu-crit {
 					temperature = <110000>;
 					hysteresis = <2000>;
 					type = "critical";
@@ -591,7 +591,7 @@ cpu6_alert0: trip-point0 {
 					type = "passive";
 				};
 
-				cpu6_crit: cpu_crit {
+				cpu6_crit: cpu-crit {
 					temperature = <110000>;
 					hysteresis = <2000>;
 					type = "critical";
@@ -612,7 +612,7 @@ cpu7_alert0: trip-point0 {
 					type = "passive";
 				};
 
-				cpu7_crit: cpu_crit {
+				cpu7_crit: cpu-crit {
 					temperature = <110000>;
 					hysteresis = <2000>;
 					type = "critical";
diff --git a/arch/arm64/boot/dts/qcom/qcs404.dtsi b/arch/arm64/boot/dts/qcom/qcs404.dtsi
index a5324eecb50a..b4d230d8e5cd 100644
--- a/arch/arm64/boot/dts/qcom/qcs404.dtsi
+++ b/arch/arm64/boot/dts/qcom/qcs404.dtsi
@@ -1502,7 +1502,7 @@ cluster_alert1: trip-point1 {
 					hysteresis = <2000>;
 					type = "passive";
 				};
-				cluster_crit: cluster_crit {
+				cluster_crit: cluster-crit {
 					temperature = <120000>;
 					hysteresis = <2000>;
 					type = "critical";
@@ -1536,7 +1536,7 @@ cpu0_alert1: trip-point1 {
 					hysteresis = <2000>;
 					type = "passive";
 				};
-				cpu0_crit: cpu_crit {
+				cpu0_crit: cpu-crit {
 					temperature = <120000>;
 					hysteresis = <2000>;
 					type = "critical";
@@ -1570,7 +1570,7 @@ cpu1_alert1: trip-point1 {
 					hysteresis = <2000>;
 					type = "passive";
 				};
-				cpu1_crit: cpu_crit {
+				cpu1_crit: cpu-crit {
 					temperature = <120000>;
 					hysteresis = <2000>;
 					type = "critical";
@@ -1604,7 +1604,7 @@ cpu2_alert1: trip-point1 {
 					hysteresis = <2000>;
 					type = "passive";
 				};
-				cpu2_crit: cpu_crit {
+				cpu2_crit: cpu-crit {
 					temperature = <120000>;
 					hysteresis = <2000>;
 					type = "critical";
@@ -1638,7 +1638,7 @@ cpu3_alert1: trip-point1 {
 					hysteresis = <2000>;
 					type = "passive";
 				};
-				cpu3_crit: cpu_crit {
+				cpu3_crit: cpu-crit {
 					temperature = <120000>;
 					hysteresis = <2000>;
 					type = "critical";
diff --git a/arch/arm64/boot/dts/qcom/sa8155p-adp.dts b/arch/arm64/boot/dts/qcom/sa8155p-adp.dts
index f41dcc379dce..eafdfbbf40b9 100644
--- a/arch/arm64/boot/dts/qcom/sa8155p-adp.dts
+++ b/arch/arm64/boot/dts/qcom/sa8155p-adp.dts
@@ -23,7 +23,7 @@ chosen {
 		stdout-path = "serial0:115200n8";
 	};
 
-	vreg_3p3: vreg_3p3_regulator {
+	vreg_3p3: vreg-3p3-regulator {
 		compatible = "regulator-fixed";
 		regulator-name = "vreg_3p3";
 		regulator-min-microvolt = <3300000>;
diff --git a/arch/arm64/boot/dts/qcom/sc7180.dtsi b/arch/arm64/boot/dts/qcom/sc7180.dtsi
index f71cf21a8dd8..792e1e5fe70d 100644
--- a/arch/arm64/boot/dts/qcom/sc7180.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7180.dtsi
@@ -3681,7 +3681,7 @@ cpu0_alert1: trip-point1 {
 					type = "passive";
 				};
 
-				cpu0_crit: cpu_crit {
+				cpu0_crit: cpu-crit {
 					temperature = <110000>;
 					hysteresis = <1000>;
 					type = "critical";
@@ -3730,7 +3730,7 @@ cpu1_alert1: trip-point1 {
 					type = "passive";
 				};
 
-				cpu1_crit: cpu_crit {
+				cpu1_crit: cpu-crit {
 					temperature = <110000>;
 					hysteresis = <1000>;
 					type = "critical";
@@ -3779,7 +3779,7 @@ cpu2_alert1: trip-point1 {
 					type = "passive";
 				};
 
-				cpu2_crit: cpu_crit {
+				cpu2_crit: cpu-crit {
 					temperature = <110000>;
 					hysteresis = <1000>;
 					type = "critical";
@@ -3828,7 +3828,7 @@ cpu3_alert1: trip-point1 {
 					type = "passive";
 				};
 
-				cpu3_crit: cpu_crit {
+				cpu3_crit: cpu-crit {
 					temperature = <110000>;
 					hysteresis = <1000>;
 					type = "critical";
@@ -3877,7 +3877,7 @@ cpu4_alert1: trip-point1 {
 					type = "passive";
 				};
 
-				cpu4_crit: cpu_crit {
+				cpu4_crit: cpu-crit {
 					temperature = <110000>;
 					hysteresis = <1000>;
 					type = "critical";
@@ -3926,7 +3926,7 @@ cpu5_alert1: trip-point1 {
 					type = "passive";
 				};
 
-				cpu5_crit: cpu_crit {
+				cpu5_crit: cpu-crit {
 					temperature = <110000>;
 					hysteresis = <1000>;
 					type = "critical";
@@ -3975,7 +3975,7 @@ cpu6_alert1: trip-point1 {
 					type = "passive";
 				};
 
-				cpu6_crit: cpu_crit {
+				cpu6_crit: cpu-crit {
 					temperature = <110000>;
 					hysteresis = <1000>;
 					type = "critical";
@@ -4016,7 +4016,7 @@ cpu7_alert1: trip-point1 {
 					type = "passive";
 				};
 
-				cpu7_crit: cpu_crit {
+				cpu7_crit: cpu-crit {
 					temperature = <110000>;
 					hysteresis = <1000>;
 					type = "critical";
@@ -4057,7 +4057,7 @@ cpu8_alert1: trip-point1 {
 					type = "passive";
 				};
 
-				cpu8_crit: cpu_crit {
+				cpu8_crit: cpu-crit {
 					temperature = <110000>;
 					hysteresis = <1000>;
 					type = "critical";
@@ -4098,7 +4098,7 @@ cpu9_alert1: trip-point1 {
 					type = "passive";
 				};
 
-				cpu9_crit: cpu_crit {
+				cpu9_crit: cpu-crit {
 					temperature = <110000>;
 					hysteresis = <1000>;
 					type = "critical";
@@ -4132,7 +4132,7 @@ aoss0_alert0: trip-point0 {
 					type = "hot";
 				};
 
-				aoss0_crit: aoss0_crit {
+				aoss0_crit: aoss0-crit {
 					temperature = <110000>;
 					hysteresis = <2000>;
 					type = "critical";
@@ -4152,7 +4152,7 @@ cpuss0_alert0: trip-point0 {
 					hysteresis = <2000>;
 					type = "hot";
 				};
-				cpuss0_crit: cluster0_crit {
+				cpuss0_crit: cluster0-crit {
 					temperature = <110000>;
 					hysteresis = <2000>;
 					type = "critical";
@@ -4172,7 +4172,7 @@ cpuss1_alert0: trip-point0 {
 					hysteresis = <2000>;
 					type = "hot";
 				};
-				cpuss1_crit: cluster0_crit {
+				cpuss1_crit: cluster0-crit {
 					temperature = <110000>;
 					hysteresis = <2000>;
 					type = "critical";
@@ -4193,7 +4193,7 @@ gpuss0_alert0: trip-point0 {
 					type = "passive";
 				};
 
-				gpuss0_crit: gpuss0_crit {
+				gpuss0_crit: gpuss0-crit {
 					temperature = <110000>;
 					hysteresis = <2000>;
 					type = "critical";
@@ -4221,7 +4221,7 @@ gpuss1_alert0: trip-point0 {
 					type = "passive";
 				};
 
-				gpuss1_crit: gpuss1_crit {
+				gpuss1_crit: gpuss1-crit {
 					temperature = <110000>;
 					hysteresis = <2000>;
 					type = "critical";
@@ -4249,7 +4249,7 @@ aoss1_alert0: trip-point0 {
 					type = "hot";
 				};
 
-				aoss1_crit: aoss1_crit {
+				aoss1_crit: aoss1-crit {
 					temperature = <110000>;
 					hysteresis = <2000>;
 					type = "critical";
@@ -4270,7 +4270,7 @@ cwlan_alert0: trip-point0 {
 					type = "hot";
 				};
 
-				cwlan_crit: cwlan_crit {
+				cwlan_crit: cwlan-crit {
 					temperature = <110000>;
 					hysteresis = <2000>;
 					type = "critical";
@@ -4291,7 +4291,7 @@ audio_alert0: trip-point0 {
 					type = "hot";
 				};
 
-				audio_crit: audio_crit {
+				audio_crit: audio-crit {
 					temperature = <110000>;
 					hysteresis = <2000>;
 					type = "critical";
@@ -4312,7 +4312,7 @@ ddr_alert0: trip-point0 {
 					type = "hot";
 				};
 
-				ddr_crit: ddr_crit {
+				ddr_crit: ddr-crit {
 					temperature = <110000>;
 					hysteresis = <2000>;
 					type = "critical";
@@ -4333,7 +4333,7 @@ q6_hvx_alert0: trip-point0 {
 					type = "hot";
 				};
 
-				q6_hvx_crit: q6_hvx_crit {
+				q6_hvx_crit: q6-hvx-crit {
 					temperature = <110000>;
 					hysteresis = <2000>;
 					type = "critical";
@@ -4354,7 +4354,7 @@ camera_alert0: trip-point0 {
 					type = "hot";
 				};
 
-				camera_crit: camera_crit {
+				camera_crit: camera-crit {
 					temperature = <110000>;
 					hysteresis = <2000>;
 					type = "critical";
@@ -4375,7 +4375,7 @@ mdm_alert0: trip-point0 {
 					type = "hot";
 				};
 
-				mdm_crit: mdm_crit {
+				mdm_crit: mdm-crit {
 					temperature = <110000>;
 					hysteresis = <2000>;
 					type = "critical";
@@ -4396,7 +4396,7 @@ mdm_dsp_alert0: trip-point0 {
 					type = "hot";
 				};
 
-				mdm_dsp_crit: mdm_dsp_crit {
+				mdm_dsp_crit: mdm-dsp-crit {
 					temperature = <110000>;
 					hysteresis = <2000>;
 					type = "critical";
@@ -4417,7 +4417,7 @@ npu_alert0: trip-point0 {
 					type = "hot";
 				};
 
-				npu_crit: npu_crit {
+				npu_crit: npu-crit {
 					temperature = <110000>;
 					hysteresis = <2000>;
 					type = "critical";
@@ -4438,7 +4438,7 @@ video_alert0: trip-point0 {
 					type = "hot";
 				};
 
-				video_crit: video_crit {
+				video_crit: video-crit {
 					temperature = <110000>;
 					hysteresis = <2000>;
 					type = "critical";
diff --git a/arch/arm64/boot/dts/qcom/sdm630-sony-xperia-nile.dtsi b/arch/arm64/boot/dts/qcom/sdm630-sony-xperia-nile.dtsi
index 3d2b08d551d0..0259e90aad1c 100644
--- a/arch/arm64/boot/dts/qcom/sdm630-sony-xperia-nile.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm630-sony-xperia-nile.dtsi
@@ -57,7 +57,7 @@ vph_pwr: vph-pwr-regulator {
 		regulator-boot-on;
 	};
 
-	cam_vdig_imx300_219_vreg: cam_vdig_imx300_219_vreg {
+	cam_vdig_imx300_219_vreg: cam-vdig-imx300-219-regulator {
 		compatible = "regulator-fixed";
 		regulator-name = "cam_vdig_imx300_219_vreg";
 		startup-delay-us = <0>;
@@ -67,7 +67,7 @@ cam_vdig_imx300_219_vreg: cam_vdig_imx300_219_vreg {
 		pinctrl-0 = <&cam_vdig_default>;
 	};
 
-	cam_vana_front_vreg: cam_vana_front_vreg {
+	cam_vana_front_vreg: cam-vana-front-regulator {
 		compatible = "regulator-fixed";
 		regulator-name = "cam_vana_front_vreg";
 		startup-delay-us = <0>;
@@ -77,7 +77,7 @@ cam_vana_front_vreg: cam_vana_front_vreg {
 		pinctrl-0 = <&imx219_vana_default>;
 	};
 
-	cam_vana_rear_vreg: cam_vana_rear_vreg {
+	cam_vana_rear_vreg: cam-vana-rear-regulator {
 		compatible = "regulator-fixed";
 		regulator-name = "cam_vana_rear_vreg";
 		startup-delay-us = <0>;
diff --git a/arch/arm64/boot/dts/qcom/sdm630.dtsi b/arch/arm64/boot/dts/qcom/sdm630.dtsi
index 13e6a4fbba27..810f51b48dce 100644
--- a/arch/arm64/boot/dts/qcom/sdm630.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm630.dtsi
@@ -2409,7 +2409,7 @@ cpu0_alert0: trip-point0 {
 					type = "passive";
 				};
 
-				cpu0_crit: cpu_crit {
+				cpu0_crit: cpu-crit {
 					temperature = <110000>;
 					hysteresis = <1000>;
 					type = "critical";
@@ -2430,7 +2430,7 @@ cpu1_alert0: trip-point0 {
 					type = "passive";
 				};
 
-				cpu1_crit: cpu_crit {
+				cpu1_crit: cpu-crit {
 					temperature = <110000>;
 					hysteresis = <1000>;
 					type = "critical";
@@ -2451,7 +2451,7 @@ cpu2_alert0: trip-point0 {
 					type = "passive";
 				};
 
-				cpu2_crit: cpu_crit {
+				cpu2_crit: cpu-crit {
 					temperature = <110000>;
 					hysteresis = <1000>;
 					type = "critical";
@@ -2472,7 +2472,7 @@ cpu3_alert0: trip-point0 {
 					type = "passive";
 				};
 
-				cpu3_crit: cpu_crit {
+				cpu3_crit: cpu-crit {
 					temperature = <110000>;
 					hysteresis = <1000>;
 					type = "critical";
@@ -2499,7 +2499,7 @@ pwr_cluster_alert0: trip-point0 {
 					type = "passive";
 				};
 
-				pwr_cluster_crit: cpu_crit {
+				pwr_cluster_crit: cpu-crit {
 					temperature = <110000>;
 					hysteresis = <1000>;
 					type = "critical";
diff --git a/arch/arm64/boot/dts/qcom/sdm845-db845c.dts b/arch/arm64/boot/dts/qcom/sdm845-db845c.dts
index f41c6d600ea8..4f64f4115175 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-db845c.dts
+++ b/arch/arm64/boot/dts/qcom/sdm845-db845c.dts
@@ -142,7 +142,7 @@ pcie0_1p05v: pcie-0-1p05v-regulator {
 		 */
 	};
 
-	cam0_dvdd_1v2: reg_cam0_dvdd_1v2 {
+	cam0_dvdd_1v2: cam0-dvdd-1v2-regulator {
 		compatible = "regulator-fixed";
 		regulator-name = "CAM0_DVDD_1V2";
 		regulator-min-microvolt = <1200000>;
@@ -154,7 +154,7 @@ cam0_dvdd_1v2: reg_cam0_dvdd_1v2 {
 		vin-supply = <&vbat>;
 	};
 
-	cam0_avdd_2v8: reg_cam0_avdd_2v8 {
+	cam0_avdd_2v8: cam0-avdd-2v8-regulator {
 		compatible = "regulator-fixed";
 		regulator-name = "CAM0_AVDD_2V8";
 		regulator-min-microvolt = <2800000>;
@@ -167,7 +167,7 @@ cam0_avdd_2v8: reg_cam0_avdd_2v8 {
 	};
 
 	/* This regulator is enabled when the VREG_LVS1A_1P8 trace is enabled */
-	cam3_avdd_2v8: reg_cam3_avdd_2v8 {
+	cam3_avdd_2v8: cam3-avdd-2v8-regulator {
 		compatible = "regulator-fixed";
 		regulator-name = "CAM3_AVDD_2V8";
 		regulator-min-microvolt = <2800000>;
diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index 65032b94b46d..444fe75ede13 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -5385,7 +5385,7 @@ cpu0_alert1: trip-point1 {
 					type = "passive";
 				};
 
-				cpu0_crit: cpu_crit {
+				cpu0_crit: cpu-crit {
 					temperature = <110000>;
 					hysteresis = <1000>;
 					type = "critical";
@@ -5412,7 +5412,7 @@ cpu1_alert1: trip-point1 {
 					type = "passive";
 				};
 
-				cpu1_crit: cpu_crit {
+				cpu1_crit: cpu-crit {
 					temperature = <110000>;
 					hysteresis = <1000>;
 					type = "critical";
@@ -5439,7 +5439,7 @@ cpu2_alert1: trip-point1 {
 					type = "passive";
 				};
 
-				cpu2_crit: cpu_crit {
+				cpu2_crit: cpu-crit {
 					temperature = <110000>;
 					hysteresis = <1000>;
 					type = "critical";
@@ -5466,7 +5466,7 @@ cpu3_alert1: trip-point1 {
 					type = "passive";
 				};
 
-				cpu3_crit: cpu_crit {
+				cpu3_crit: cpu-crit {
 					temperature = <110000>;
 					hysteresis = <1000>;
 					type = "critical";
@@ -5493,7 +5493,7 @@ cpu4_alert1: trip-point1 {
 					type = "passive";
 				};
 
-				cpu4_crit: cpu_crit {
+				cpu4_crit: cpu-crit {
 					temperature = <110000>;
 					hysteresis = <1000>;
 					type = "critical";
@@ -5520,7 +5520,7 @@ cpu5_alert1: trip-point1 {
 					type = "passive";
 				};
 
-				cpu5_crit: cpu_crit {
+				cpu5_crit: cpu-crit {
 					temperature = <110000>;
 					hysteresis = <1000>;
 					type = "critical";
@@ -5547,7 +5547,7 @@ cpu6_alert1: trip-point1 {
 					type = "passive";
 				};
 
-				cpu6_crit: cpu_crit {
+				cpu6_crit: cpu-crit {
 					temperature = <110000>;
 					hysteresis = <1000>;
 					type = "critical";
@@ -5574,7 +5574,7 @@ cpu7_alert1: trip-point1 {
 					type = "passive";
 				};
 
-				cpu7_crit: cpu_crit {
+				cpu7_crit: cpu-crit {
 					temperature = <110000>;
 					hysteresis = <1000>;
 					type = "critical";
diff --git a/arch/arm64/boot/dts/qcom/sm6125-sony-xperia-seine-pdx201.dts b/arch/arm64/boot/dts/qcom/sm6125-sony-xperia-seine-pdx201.dts
index 0de6c5b7f742..476df4f6e58a 100644
--- a/arch/arm64/boot/dts/qcom/sm6125-sony-xperia-seine-pdx201.dts
+++ b/arch/arm64/boot/dts/qcom/sm6125-sony-xperia-seine-pdx201.dts
@@ -55,7 +55,7 @@ key-vol-dn {
 		};
 	};
 
-	reserved_memory {
+	reserved-memory {
 		#address-cells = <2>;
 		#size-cells = <2>;
 		debug_mem: memory@ffb00000 {
diff --git a/arch/arm64/boot/dts/qcom/sm8150.dtsi b/arch/arm64/boot/dts/qcom/sm8150.dtsi
index a0c57fb798d3..e3997a0e3dff 100644
--- a/arch/arm64/boot/dts/qcom/sm8150.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8150.dtsi
@@ -4057,7 +4057,7 @@ cpu0_alert1: trip-point1 {
 					type = "passive";
 				};
 
-				cpu0_crit: cpu_crit {
+				cpu0_crit: cpu-crit {
 					temperature = <110000>;
 					hysteresis = <1000>;
 					type = "critical";
@@ -4101,7 +4101,7 @@ cpu1_alert1: trip-point1 {
 					type = "passive";
 				};
 
-				cpu1_crit: cpu_crit {
+				cpu1_crit: cpu-crit {
 					temperature = <110000>;
 					hysteresis = <1000>;
 					type = "critical";
@@ -4145,7 +4145,7 @@ cpu2_alert1: trip-point1 {
 					type = "passive";
 				};
 
-				cpu2_crit: cpu_crit {
+				cpu2_crit: cpu-crit {
 					temperature = <110000>;
 					hysteresis = <1000>;
 					type = "critical";
@@ -4189,7 +4189,7 @@ cpu3_alert1: trip-point1 {
 					type = "passive";
 				};
 
-				cpu3_crit: cpu_crit {
+				cpu3_crit: cpu-crit {
 					temperature = <110000>;
 					hysteresis = <1000>;
 					type = "critical";
@@ -4233,7 +4233,7 @@ cpu4_top_alert1: trip-point1 {
 					type = "passive";
 				};
 
-				cpu4_top_crit: cpu_crit {
+				cpu4_top_crit: cpu-crit {
 					temperature = <110000>;
 					hysteresis = <1000>;
 					type = "critical";
@@ -4277,7 +4277,7 @@ cpu5_top_alert1: trip-point1 {
 					type = "passive";
 				};
 
-				cpu5_top_crit: cpu_crit {
+				cpu5_top_crit: cpu-crit {
 					temperature = <110000>;
 					hysteresis = <1000>;
 					type = "critical";
@@ -4321,7 +4321,7 @@ cpu6_top_alert1: trip-point1 {
 					type = "passive";
 				};
 
-				cpu6_top_crit: cpu_crit {
+				cpu6_top_crit: cpu-crit {
 					temperature = <110000>;
 					hysteresis = <1000>;
 					type = "critical";
@@ -4365,7 +4365,7 @@ cpu7_top_alert1: trip-point1 {
 					type = "passive";
 				};
 
-				cpu7_top_crit: cpu_crit {
+				cpu7_top_crit: cpu-crit {
 					temperature = <110000>;
 					hysteresis = <1000>;
 					type = "critical";
@@ -4409,7 +4409,7 @@ cpu4_bottom_alert1: trip-point1 {
 					type = "passive";
 				};
 
-				cpu4_bottom_crit: cpu_crit {
+				cpu4_bottom_crit: cpu-crit {
 					temperature = <110000>;
 					hysteresis = <1000>;
 					type = "critical";
@@ -4453,7 +4453,7 @@ cpu5_bottom_alert1: trip-point1 {
 					type = "passive";
 				};
 
-				cpu5_bottom_crit: cpu_crit {
+				cpu5_bottom_crit: cpu-crit {
 					temperature = <110000>;
 					hysteresis = <1000>;
 					type = "critical";
@@ -4497,7 +4497,7 @@ cpu6_bottom_alert1: trip-point1 {
 					type = "passive";
 				};
 
-				cpu6_bottom_crit: cpu_crit {
+				cpu6_bottom_crit: cpu-crit {
 					temperature = <110000>;
 					hysteresis = <1000>;
 					type = "critical";
@@ -4541,7 +4541,7 @@ cpu7_bottom_alert1: trip-point1 {
 					type = "passive";
 				};
 
-				cpu7_bottom_crit: cpu_crit {
+				cpu7_bottom_crit: cpu-crit {
 					temperature = <110000>;
 					hysteresis = <1000>;
 					type = "critical";
diff --git a/arch/arm64/boot/dts/qcom/sm8250.dtsi b/arch/arm64/boot/dts/qcom/sm8250.dtsi
index dab5579946f3..46186e521aba 100644
--- a/arch/arm64/boot/dts/qcom/sm8250.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8250.dtsi
@@ -5500,7 +5500,7 @@ cpu0_alert1: trip-point1 {
 					type = "passive";
 				};
 
-				cpu0_crit: cpu_crit {
+				cpu0_crit: cpu-crit {
 					temperature = <110000>;
 					hysteresis = <1000>;
 					type = "critical";
@@ -5544,7 +5544,7 @@ cpu1_alert1: trip-point1 {
 					type = "passive";
 				};
 
-				cpu1_crit: cpu_crit {
+				cpu1_crit: cpu-crit {
 					temperature = <110000>;
 					hysteresis = <1000>;
 					type = "critical";
@@ -5588,7 +5588,7 @@ cpu2_alert1: trip-point1 {
 					type = "passive";
 				};
 
-				cpu2_crit: cpu_crit {
+				cpu2_crit: cpu-crit {
 					temperature = <110000>;
 					hysteresis = <1000>;
 					type = "critical";
@@ -5632,7 +5632,7 @@ cpu3_alert1: trip-point1 {
 					type = "passive";
 				};
 
-				cpu3_crit: cpu_crit {
+				cpu3_crit: cpu-crit {
 					temperature = <110000>;
 					hysteresis = <1000>;
 					type = "critical";
@@ -5676,7 +5676,7 @@ cpu4_top_alert1: trip-point1 {
 					type = "passive";
 				};
 
-				cpu4_top_crit: cpu_crit {
+				cpu4_top_crit: cpu-crit {
 					temperature = <110000>;
 					hysteresis = <1000>;
 					type = "critical";
@@ -5720,7 +5720,7 @@ cpu5_top_alert1: trip-point1 {
 					type = "passive";
 				};
 
-				cpu5_top_crit: cpu_crit {
+				cpu5_top_crit: cpu-crit {
 					temperature = <110000>;
 					hysteresis = <1000>;
 					type = "critical";
@@ -5764,7 +5764,7 @@ cpu6_top_alert1: trip-point1 {
 					type = "passive";
 				};
 
-				cpu6_top_crit: cpu_crit {
+				cpu6_top_crit: cpu-crit {
 					temperature = <110000>;
 					hysteresis = <1000>;
 					type = "critical";
@@ -5808,7 +5808,7 @@ cpu7_top_alert1: trip-point1 {
 					type = "passive";
 				};
 
-				cpu7_top_crit: cpu_crit {
+				cpu7_top_crit: cpu-crit {
 					temperature = <110000>;
 					hysteresis = <1000>;
 					type = "critical";
@@ -5852,7 +5852,7 @@ cpu4_bottom_alert1: trip-point1 {
 					type = "passive";
 				};
 
-				cpu4_bottom_crit: cpu_crit {
+				cpu4_bottom_crit: cpu-crit {
 					temperature = <110000>;
 					hysteresis = <1000>;
 					type = "critical";
@@ -5896,7 +5896,7 @@ cpu5_bottom_alert1: trip-point1 {
 					type = "passive";
 				};
 
-				cpu5_bottom_crit: cpu_crit {
+				cpu5_bottom_crit: cpu-crit {
 					temperature = <110000>;
 					hysteresis = <1000>;
 					type = "critical";
@@ -5940,7 +5940,7 @@ cpu6_bottom_alert1: trip-point1 {
 					type = "passive";
 				};
 
-				cpu6_bottom_crit: cpu_crit {
+				cpu6_bottom_crit: cpu-crit {
 					temperature = <110000>;
 					hysteresis = <1000>;
 					type = "critical";
@@ -5984,7 +5984,7 @@ cpu7_bottom_alert1: trip-point1 {
 					type = "passive";
 				};
 
-				cpu7_bottom_crit: cpu_crit {
+				cpu7_bottom_crit: cpu-crit {
 					temperature = <110000>;
 					hysteresis = <1000>;
 					type = "critical";
diff --git a/arch/arm64/boot/dts/qcom/sm8350.dtsi b/arch/arm64/boot/dts/qcom/sm8350.dtsi
index 245dce24ec59..b41bc3b005fb 100644
--- a/arch/arm64/boot/dts/qcom/sm8350.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8350.dtsi
@@ -2728,7 +2728,7 @@ cpu0_alert1: trip-point1 {
 					type = "passive";
 				};
 
-				cpu0_crit: cpu_crit {
+				cpu0_crit: cpu-crit {
 					temperature = <110000>;
 					hysteresis = <1000>;
 					type = "critical";
@@ -2772,7 +2772,7 @@ cpu1_alert1: trip-point1 {
 					type = "passive";
 				};
 
-				cpu1_crit: cpu_crit {
+				cpu1_crit: cpu-crit {
 					temperature = <110000>;
 					hysteresis = <1000>;
 					type = "critical";
@@ -2816,7 +2816,7 @@ cpu2_alert1: trip-point1 {
 					type = "passive";
 				};
 
-				cpu2_crit: cpu_crit {
+				cpu2_crit: cpu-crit {
 					temperature = <110000>;
 					hysteresis = <1000>;
 					type = "critical";
@@ -2860,7 +2860,7 @@ cpu3_alert1: trip-point1 {
 					type = "passive";
 				};
 
-				cpu3_crit: cpu_crit {
+				cpu3_crit: cpu-crit {
 					temperature = <110000>;
 					hysteresis = <1000>;
 					type = "critical";
@@ -2904,7 +2904,7 @@ cpu4_top_alert1: trip-point1 {
 					type = "passive";
 				};
 
-				cpu4_top_crit: cpu_crit {
+				cpu4_top_crit: cpu-crit {
 					temperature = <110000>;
 					hysteresis = <1000>;
 					type = "critical";
@@ -2948,7 +2948,7 @@ cpu5_top_alert1: trip-point1 {
 					type = "passive";
 				};
 
-				cpu5_top_crit: cpu_crit {
+				cpu5_top_crit: cpu-crit {
 					temperature = <110000>;
 					hysteresis = <1000>;
 					type = "critical";
@@ -2992,7 +2992,7 @@ cpu6_top_alert1: trip-point1 {
 					type = "passive";
 				};
 
-				cpu6_top_crit: cpu_crit {
+				cpu6_top_crit: cpu-crit {
 					temperature = <110000>;
 					hysteresis = <1000>;
 					type = "critical";
@@ -3036,7 +3036,7 @@ cpu7_top_alert1: trip-point1 {
 					type = "passive";
 				};
 
-				cpu7_top_crit: cpu_crit {
+				cpu7_top_crit: cpu-crit {
 					temperature = <110000>;
 					hysteresis = <1000>;
 					type = "critical";
@@ -3080,7 +3080,7 @@ cpu4_bottom_alert1: trip-point1 {
 					type = "passive";
 				};
 
-				cpu4_bottom_crit: cpu_crit {
+				cpu4_bottom_crit: cpu-crit {
 					temperature = <110000>;
 					hysteresis = <1000>;
 					type = "critical";
@@ -3124,7 +3124,7 @@ cpu5_bottom_alert1: trip-point1 {
 					type = "passive";
 				};
 
-				cpu5_bottom_crit: cpu_crit {
+				cpu5_bottom_crit: cpu-crit {
 					temperature = <110000>;
 					hysteresis = <1000>;
 					type = "critical";
@@ -3168,7 +3168,7 @@ cpu6_bottom_alert1: trip-point1 {
 					type = "passive";
 				};
 
-				cpu6_bottom_crit: cpu_crit {
+				cpu6_bottom_crit: cpu-crit {
 					temperature = <110000>;
 					hysteresis = <1000>;
 					type = "critical";
@@ -3212,7 +3212,7 @@ cpu7_bottom_alert1: trip-point1 {
 					type = "passive";
 				};
 
-				cpu7_bottom_crit: cpu_crit {
+				cpu7_bottom_crit: cpu-crit {
 					temperature = <110000>;
 					hysteresis = <1000>;
 					type = "critical";
diff --git a/arch/arm64/boot/dts/qcom/sm8450.dtsi b/arch/arm64/boot/dts/qcom/sm8450.dtsi
index 570475040d95..8b0a0c990392 100644
--- a/arch/arm64/boot/dts/qcom/sm8450.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8450.dtsi
@@ -3953,7 +3953,7 @@ cpu4_top_alert1: trip-point1 {
 					type = "passive";
 				};
 
-				cpu4_top_crit: cpu_crit {
+				cpu4_top_crit: cpu-crit {
 					temperature = <110000>;
 					hysteresis = <1000>;
 					type = "critical";
@@ -3979,7 +3979,7 @@ cpu4_bottom_alert1: trip-point1 {
 					type = "passive";
 				};
 
-				cpu4_bottom_crit: cpu_crit {
+				cpu4_bottom_crit: cpu-crit {
 					temperature = <110000>;
 					hysteresis = <1000>;
 					type = "critical";
@@ -4005,7 +4005,7 @@ cpu5_top_alert1: trip-point1 {
 					type = "passive";
 				};
 
-				cpu5_top_crit: cpu_crit {
+				cpu5_top_crit: cpu-crit {
 					temperature = <110000>;
 					hysteresis = <1000>;
 					type = "critical";
@@ -4031,7 +4031,7 @@ cpu5_bottom_alert1: trip-point1 {
 					type = "passive";
 				};
 
-				cpu5_bottom_crit: cpu_crit {
+				cpu5_bottom_crit: cpu-crit {
 					temperature = <110000>;
 					hysteresis = <1000>;
 					type = "critical";
@@ -4057,7 +4057,7 @@ cpu6_top_alert1: trip-point1 {
 					type = "passive";
 				};
 
-				cpu6_top_crit: cpu_crit {
+				cpu6_top_crit: cpu-crit {
 					temperature = <110000>;
 					hysteresis = <1000>;
 					type = "critical";
@@ -4083,7 +4083,7 @@ cpu6_bottom_alert1: trip-point1 {
 					type = "passive";
 				};
 
-				cpu6_bottom_crit: cpu_crit {
+				cpu6_bottom_crit: cpu-crit {
 					temperature = <110000>;
 					hysteresis = <1000>;
 					type = "critical";
@@ -4109,7 +4109,7 @@ cpu7_top_alert1: trip-point1 {
 					type = "passive";
 				};
 
-				cpu7_top_crit: cpu_crit {
+				cpu7_top_crit: cpu-crit {
 					temperature = <110000>;
 					hysteresis = <1000>;
 					type = "critical";
@@ -4135,7 +4135,7 @@ cpu7_middle_alert1: trip-point1 {
 					type = "passive";
 				};
 
-				cpu7_middle_crit: cpu_crit {
+				cpu7_middle_crit: cpu-crit {
 					temperature = <110000>;
 					hysteresis = <1000>;
 					type = "critical";
@@ -4161,7 +4161,7 @@ cpu7_bottom_alert1: trip-point1 {
 					type = "passive";
 				};
 
-				cpu7_bottom_crit: cpu_crit {
+				cpu7_bottom_crit: cpu-crit {
 					temperature = <110000>;
 					hysteresis = <1000>;
 					type = "critical";
@@ -4193,7 +4193,7 @@ reset-mon-cfg {
 					type = "passive";
 				};
 
-				gpu0_tj_cfg: tj_cfg {
+				gpu0_tj_cfg: tj-cfg {
 					temperature = <95000>;
 					hysteresis = <5000>;
 					type = "passive";
@@ -4225,7 +4225,7 @@ reset-mon-cfg {
 					type = "passive";
 				};
 
-				gpu1_tj_cfg: tj_cfg {
+				gpu1_tj_cfg: tj-cfg {
 					temperature = <95000>;
 					hysteresis = <5000>;
 					type = "passive";
@@ -4271,7 +4271,7 @@ cpu0_alert1: trip-point1 {
 					type = "passive";
 				};
 
-				cpu0_crit: cpu_crit {
+				cpu0_crit: cpu-crit {
 					temperature = <110000>;
 					hysteresis = <1000>;
 					type = "critical";
@@ -4297,7 +4297,7 @@ cpu1_alert1: trip-point1 {
 					type = "passive";
 				};
 
-				cpu1_crit: cpu_crit {
+				cpu1_crit: cpu-crit {
 					temperature = <110000>;
 					hysteresis = <1000>;
 					type = "critical";
@@ -4323,7 +4323,7 @@ cpu2_alert1: trip-point1 {
 					type = "passive";
 				};
 
-				cpu2_crit: cpu_crit {
+				cpu2_crit: cpu-crit {
 					temperature = <110000>;
 					hysteresis = <1000>;
 					type = "critical";
@@ -4349,7 +4349,7 @@ cpu3_alert1: trip-point1 {
 					type = "passive";
 				};
 
-				cpu3_crit: cpu_crit {
+				cpu3_crit: cpu-crit {
 					temperature = <110000>;
 					hysteresis = <1000>;
 					type = "critical";
-- 
2.34.1

