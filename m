Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 254507323D7
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 01:46:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240481AbjFOXqg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 19:46:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240274AbjFOXq3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 19:46:29 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B5E42D47
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 16:46:22 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id 38308e7fff4ca-2b35109e934so568611fa.0
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 16:46:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686872780; x=1689464780;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=q+PvbIyvHRl4FSoE9uzVYKxRDamiFRuOsnGAUc6cVuo=;
        b=O+8oOs0mQPAOyXRuNb9vDh0IzKIxHksY00MsMvG+yA0lKdP/tsB/k0lIp2jEmLNBO1
         ByQVOMp+T/0PZFSx61lAlVTHn9UeQwc/f87BvH8i6jv0FD48cZCeKT5kfPw+NQTG2JWQ
         25ZhX8QpThKd5ES1atQhySHxB64cSxCvrRBl9UZLwPtxAwYN9/EEaFkzy/cSoJI1OygA
         jypk862Uor7EQ3vwrlBDE4Y5aK9EzC332aQV6j6fxiur/KEkfxsnAB3urUeTImMxkQNC
         C4hoaCoKPBUO5J+WiOp0R8ofk8bYA07yVN5o+CQjHxMF01hsMx5kyscf55JcIr3jJ1D3
         e6Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686872780; x=1689464780;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q+PvbIyvHRl4FSoE9uzVYKxRDamiFRuOsnGAUc6cVuo=;
        b=iblhz1P21VvJj+gKwtTp49fQBGbs69t/EMaKSk2hqcz5LmiXBGsyebk2zxTAoO04GI
         hUln1G70RqZZ6wsFktIVD1KqYmHBT+N9b+7Q92ACvTTbntEDT2GL9WJ+b06C7tUPft6L
         Loa4GGdO2+yMAFlqhVGkdTo5F7WjscouuTyAqkpAhNkAZO8ccQJlnkOo2thv0rpVFWIJ
         6FB5lHzpqX0hePgy8yEhFvo4QHk/B5eRbvkk17EJpeh4zE1Thb476ZVXH1jQpeOpHm1p
         a6eYER9C8ytXBoP7JNnpjamS/hpiI9xyTiTciVIDluUDtCz0EXB2NbSlfmektJp6Yb88
         xHZw==
X-Gm-Message-State: AC+VfDxTuepffNMSWgDGCrCMstPIDBm52yrW5XIONQ2o22QXthabyX8/
        JmB/Gyq29UVfLs8R76G/WbQRWg==
X-Google-Smtp-Source: ACHHUZ5mOBNnISBEh7eq/utV46UY4kVc3L5dlVGF6K10qOA7ZbsZlqbBi0MADJe11jhJn79CvPxpKg==
X-Received: by 2002:a2e:88d0:0:b0:2b3:46ec:8014 with SMTP id a16-20020a2e88d0000000b002b346ec8014mr481970ljk.47.1686872780352;
        Thu, 15 Jun 2023 16:46:20 -0700 (PDT)
Received: from [192.168.1.101] (abyj190.neoplus.adsl.tpnet.pl. [83.9.29.190])
        by smtp.gmail.com with ESMTPSA id y16-20020a05651c021000b002ac82a995fcsm3344596ljn.23.2023.06.15.16.46.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jun 2023 16:46:20 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Fri, 16 Jun 2023 01:46:10 +0200
Subject: [PATCH 2/2] arm64: dts: qcom: sc7180: Hook up BWMONs
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230616-topic-sc7180_bwmons-v1-2-4ddb96f9a6cd@linaro.org>
References: <20230616-topic-sc7180_bwmons-v1-0-4ddb96f9a6cd@linaro.org>
In-Reply-To: <20230616-topic-sc7180_bwmons-v1-0-4ddb96f9a6cd@linaro.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Georgi Djakov <djakov@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        cros-qcom-dts-watchers@chromium.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        Nikita Travkin <nikita@trvn.ru>, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1686872776; l=11455;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=Gy0nc/M3o6MCmy28Sto0NlhJAaM2QOc7qKiXiWyzZ+U=;
 b=CWK4DgIVGzvs+VSmow7gqwmVDXhtNIk+kmE8beYgdxIsVwVDCr2/HGnZGGktAK1E4Pntln/O1
 ihfI4/tsMgeCTZ7dOK85LiU9OHcATAEk66GEHlTrkmcvRfTOSUDooHj
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hook up 2 out of 4 (the rest are for NPU) BWMONs exposed on the SC7180.
This allows for scaling DDR and LLCC independently from cpufreq.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 arch/arm64/boot/dts/qcom/sc7180-lite.dtsi |  10 +-
 arch/arm64/boot/dts/qcom/sc7180.dtsi      | 161 ++++++++++++++++++++++--------
 2 files changed, 124 insertions(+), 47 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sc7180-lite.dtsi b/arch/arm64/boot/dts/qcom/sc7180-lite.dtsi
index 4b306a59d9be..975d4422f27b 100644
--- a/arch/arm64/boot/dts/qcom/sc7180-lite.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7180-lite.dtsi
@@ -6,21 +6,21 @@
  */
 
 &cpu6_opp10 {
-	opp-peak-kBps = <7216000 22425600>;
+	opp-peak-kBps = <22425600>;
 };
 
 &cpu6_opp11 {
-	opp-peak-kBps = <7216000 22425600>;
+	opp-peak-kBps = <22425600>;
 };
 
 &cpu6_opp12 {
-	opp-peak-kBps = <8532000 23347200>;
+	opp-peak-kBps = <23347200>;
 };
 
 &cpu6_opp13 {
-	opp-peak-kBps = <8532000 23347200>;
+	opp-peak-kBps = <23347200>;
 };
 
 &cpu6_opp14 {
-	opp-peak-kBps = <8532000 23347200>;
+	opp-peak-kBps = <23347200>;
 };
diff --git a/arch/arm64/boot/dts/qcom/sc7180.dtsi b/arch/arm64/boot/dts/qcom/sc7180.dtsi
index 34eff97f8630..e0c5881d8eb8 100644
--- a/arch/arm64/boot/dts/qcom/sc7180.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7180.dtsi
@@ -11,6 +11,7 @@
 #include <dt-bindings/clock/qcom,lpasscorecc-sc7180.h>
 #include <dt-bindings/clock/qcom,rpmh.h>
 #include <dt-bindings/clock/qcom,videocc-sc7180.h>
+#include <dt-bindings/interconnect/qcom,icc.h>
 #include <dt-bindings/interconnect/qcom,osm-l3.h>
 #include <dt-bindings/interconnect/qcom,sc7180.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
@@ -84,8 +85,7 @@ &LITTLE_CPU_SLEEP_1
 			capacity-dmips-mhz = <415>;
 			dynamic-power-coefficient = <137>;
 			operating-points-v2 = <&cpu0_opp_table>;
-			interconnects = <&gem_noc MASTER_APPSS_PROC 3 &mc_virt SLAVE_EBI1 3>,
-					<&osm_l3 MASTER_OSM_L3_APPS &osm_l3 SLAVE_OSM_L3>;
+			interconnects = <&osm_l3 MASTER_OSM_L3_APPS &osm_l3 SLAVE_OSM_L3>;
 			next-level-cache = <&L2_0>;
 			#cooling-cells = <2>;
 			qcom,freq-domain = <&cpufreq_hw 0>;
@@ -115,8 +115,7 @@ &LITTLE_CPU_SLEEP_1
 			dynamic-power-coefficient = <137>;
 			next-level-cache = <&L2_100>;
 			operating-points-v2 = <&cpu0_opp_table>;
-			interconnects = <&gem_noc MASTER_APPSS_PROC 3 &mc_virt SLAVE_EBI1 3>,
-					<&osm_l3 MASTER_OSM_L3_APPS &osm_l3 SLAVE_OSM_L3>;
+			interconnects = <&osm_l3 MASTER_OSM_L3_APPS &osm_l3 SLAVE_OSM_L3>;
 			#cooling-cells = <2>;
 			qcom,freq-domain = <&cpufreq_hw 0>;
 			L2_100: l2-cache {
@@ -140,8 +139,7 @@ &LITTLE_CPU_SLEEP_1
 			dynamic-power-coefficient = <137>;
 			next-level-cache = <&L2_200>;
 			operating-points-v2 = <&cpu0_opp_table>;
-			interconnects = <&gem_noc MASTER_APPSS_PROC 3 &mc_virt SLAVE_EBI1 3>,
-					<&osm_l3 MASTER_OSM_L3_APPS &osm_l3 SLAVE_OSM_L3>;
+			interconnects = <&osm_l3 MASTER_OSM_L3_APPS &osm_l3 SLAVE_OSM_L3>;
 			#cooling-cells = <2>;
 			qcom,freq-domain = <&cpufreq_hw 0>;
 			L2_200: l2-cache {
@@ -165,8 +163,7 @@ &LITTLE_CPU_SLEEP_1
 			dynamic-power-coefficient = <137>;
 			next-level-cache = <&L2_300>;
 			operating-points-v2 = <&cpu0_opp_table>;
-			interconnects = <&gem_noc MASTER_APPSS_PROC 3 &mc_virt SLAVE_EBI1 3>,
-					<&osm_l3 MASTER_OSM_L3_APPS &osm_l3 SLAVE_OSM_L3>;
+			interconnects = <&osm_l3 MASTER_OSM_L3_APPS &osm_l3 SLAVE_OSM_L3>;
 			#cooling-cells = <2>;
 			qcom,freq-domain = <&cpufreq_hw 0>;
 			L2_300: l2-cache {
@@ -190,8 +187,7 @@ &LITTLE_CPU_SLEEP_1
 			dynamic-power-coefficient = <137>;
 			next-level-cache = <&L2_400>;
 			operating-points-v2 = <&cpu0_opp_table>;
-			interconnects = <&gem_noc MASTER_APPSS_PROC 3 &mc_virt SLAVE_EBI1 3>,
-					<&osm_l3 MASTER_OSM_L3_APPS &osm_l3 SLAVE_OSM_L3>;
+			interconnects = <&osm_l3 MASTER_OSM_L3_APPS &osm_l3 SLAVE_OSM_L3>;
 			#cooling-cells = <2>;
 			qcom,freq-domain = <&cpufreq_hw 0>;
 			L2_400: l2-cache {
@@ -215,8 +211,7 @@ &LITTLE_CPU_SLEEP_1
 			dynamic-power-coefficient = <137>;
 			next-level-cache = <&L2_500>;
 			operating-points-v2 = <&cpu0_opp_table>;
-			interconnects = <&gem_noc MASTER_APPSS_PROC 3 &mc_virt SLAVE_EBI1 3>,
-					<&osm_l3 MASTER_OSM_L3_APPS &osm_l3 SLAVE_OSM_L3>;
+			interconnects = <&osm_l3 MASTER_OSM_L3_APPS &osm_l3 SLAVE_OSM_L3>;
 			#cooling-cells = <2>;
 			qcom,freq-domain = <&cpufreq_hw 0>;
 			L2_500: l2-cache {
@@ -240,8 +235,7 @@ &BIG_CPU_SLEEP_1
 			dynamic-power-coefficient = <480>;
 			next-level-cache = <&L2_600>;
 			operating-points-v2 = <&cpu6_opp_table>;
-			interconnects = <&gem_noc MASTER_APPSS_PROC 3 &mc_virt SLAVE_EBI1 3>,
-					<&osm_l3 MASTER_OSM_L3_APPS &osm_l3 SLAVE_OSM_L3>;
+			interconnects = <&osm_l3 MASTER_OSM_L3_APPS &osm_l3 SLAVE_OSM_L3>;
 			#cooling-cells = <2>;
 			qcom,freq-domain = <&cpufreq_hw 1>;
 			L2_600: l2-cache {
@@ -265,8 +259,7 @@ &BIG_CPU_SLEEP_1
 			dynamic-power-coefficient = <480>;
 			next-level-cache = <&L2_700>;
 			operating-points-v2 = <&cpu6_opp_table>;
-			interconnects = <&gem_noc MASTER_APPSS_PROC 3 &mc_virt SLAVE_EBI1 3>,
-					<&osm_l3 MASTER_OSM_L3_APPS &osm_l3 SLAVE_OSM_L3>;
+			interconnects = <&osm_l3 MASTER_OSM_L3_APPS &osm_l3 SLAVE_OSM_L3>;
 			#cooling-cells = <2>;
 			qcom,freq-domain = <&cpufreq_hw 1>;
 			L2_700: l2-cache {
@@ -386,52 +379,52 @@ cpu0_opp_table: opp-table-cpu0 {
 
 		cpu0_opp1: opp-300000000 {
 			opp-hz = /bits/ 64 <300000000>;
-			opp-peak-kBps = <1200000 4800000>;
+			opp-peak-kBps = <4800000>;
 		};
 
 		cpu0_opp2: opp-576000000 {
 			opp-hz = /bits/ 64 <576000000>;
-			opp-peak-kBps = <1200000 4800000>;
+			opp-peak-kBps = <4800000>;
 		};
 
 		cpu0_opp3: opp-768000000 {
 			opp-hz = /bits/ 64 <768000000>;
-			opp-peak-kBps = <1200000 4800000>;
+			opp-peak-kBps = <4800000>;
 		};
 
 		cpu0_opp4: opp-1017600000 {
 			opp-hz = /bits/ 64 <1017600000>;
-			opp-peak-kBps = <1804000 8908800>;
+			opp-peak-kBps = <8908800>;
 		};
 
 		cpu0_opp5: opp-1248000000 {
 			opp-hz = /bits/ 64 <1248000000>;
-			opp-peak-kBps = <2188000 12902400>;
+			opp-peak-kBps = <12902400>;
 		};
 
 		cpu0_opp6: opp-1324800000 {
 			opp-hz = /bits/ 64 <1324800000>;
-			opp-peak-kBps = <2188000 12902400>;
+			opp-peak-kBps = <12902400>;
 		};
 
 		cpu0_opp7: opp-1516800000 {
 			opp-hz = /bits/ 64 <1516800000>;
-			opp-peak-kBps = <3072000 15052800>;
+			opp-peak-kBps = <15052800>;
 		};
 
 		cpu0_opp8: opp-1612800000 {
 			opp-hz = /bits/ 64 <1612800000>;
-			opp-peak-kBps = <3072000 15052800>;
+			opp-peak-kBps = <15052800>;
 		};
 
 		cpu0_opp9: opp-1708800000 {
 			opp-hz = /bits/ 64 <1708800000>;
-			opp-peak-kBps = <3072000 15052800>;
+			opp-peak-kBps = <15052800>;
 		};
 
 		cpu0_opp10: opp-1804800000 {
 			opp-hz = /bits/ 64 <1804800000>;
-			opp-peak-kBps = <4068000 22425600>;
+			opp-peak-kBps = <22425600>;
 		};
 	};
 
@@ -441,82 +434,82 @@ cpu6_opp_table: opp-table-cpu6 {
 
 		cpu6_opp1: opp-300000000 {
 			opp-hz = /bits/ 64 <300000000>;
-			opp-peak-kBps = <2188000 8908800>;
+			opp-peak-kBps = <8908800>;
 		};
 
 		cpu6_opp2: opp-652800000 {
 			opp-hz = /bits/ 64 <652800000>;
-			opp-peak-kBps = <2188000 8908800>;
+			opp-peak-kBps = <8908800>;
 		};
 
 		cpu6_opp3: opp-825600000 {
 			opp-hz = /bits/ 64 <825600000>;
-			opp-peak-kBps = <2188000 8908800>;
+			opp-peak-kBps = <8908800>;
 		};
 
 		cpu6_opp4: opp-979200000 {
 			opp-hz = /bits/ 64 <979200000>;
-			opp-peak-kBps = <2188000 8908800>;
+			opp-peak-kBps = <8908800>;
 		};
 
 		cpu6_opp5: opp-1113600000 {
 			opp-hz = /bits/ 64 <1113600000>;
-			opp-peak-kBps = <2188000 8908800>;
+			opp-peak-kBps = <8908800>;
 		};
 
 		cpu6_opp6: opp-1267200000 {
 			opp-hz = /bits/ 64 <1267200000>;
-			opp-peak-kBps = <4068000 12902400>;
+			opp-peak-kBps = <12902400>;
 		};
 
 		cpu6_opp7: opp-1555200000 {
 			opp-hz = /bits/ 64 <1555200000>;
-			opp-peak-kBps = <4068000 15052800>;
+			opp-peak-kBps = <15052800>;
 		};
 
 		cpu6_opp8: opp-1708800000 {
 			opp-hz = /bits/ 64 <1708800000>;
-			opp-peak-kBps = <6220000 19353600>;
+			opp-peak-kBps = <19353600>;
 		};
 
 		cpu6_opp9: opp-1843200000 {
 			opp-hz = /bits/ 64 <1843200000>;
-			opp-peak-kBps = <6220000 19353600>;
+			opp-peak-kBps = <19353600>;
 		};
 
 		cpu6_opp10: opp-1900800000 {
 			opp-hz = /bits/ 64 <1900800000>;
-			opp-peak-kBps = <6220000 22425600>;
+			opp-peak-kBps = <22425600>;
 		};
 
 		cpu6_opp11: opp-1996800000 {
 			opp-hz = /bits/ 64 <1996800000>;
-			opp-peak-kBps = <6220000 22425600>;
+			opp-peak-kBps = <22425600>;
 		};
 
 		cpu6_opp12: opp-2112000000 {
 			opp-hz = /bits/ 64 <2112000000>;
-			opp-peak-kBps = <6220000 22425600>;
+			opp-peak-kBps = <22425600>;
 		};
 
 		cpu6_opp13: opp-2208000000 {
 			opp-hz = /bits/ 64 <2208000000>;
-			opp-peak-kBps = <7216000 22425600>;
+			opp-peak-kBps = <22425600>;
 		};
 
 		cpu6_opp14: opp-2323200000 {
 			opp-hz = /bits/ 64 <2323200000>;
-			opp-peak-kBps = <7216000 22425600>;
+			opp-peak-kBps = <22425600>;
 		};
 
 		cpu6_opp15: opp-2400000000 {
 			opp-hz = /bits/ 64 <2400000000>;
-			opp-peak-kBps = <8532000 23347200>;
+			opp-peak-kBps = <23347200>;
 		};
 
 		cpu6_opp16: opp-2553600000 {
 			opp-hz = /bits/ 64 <2553600000>;
-			opp-peak-kBps = <8532000 23347200>;
+			opp-peak-kBps = <23347200>;
 		};
 	};
 
@@ -2773,6 +2766,90 @@ dp_phy: dp-phy@88ea200 {
 			};
 		};
 
+		pmu@90b6300 {
+			compatible = "qcom,sc7180-cpu-bwmon", "qcom,sdm845-bwmon";
+			reg = <0 0x090b6300 0 0x600>;
+			interrupts = <GIC_SPI 581 IRQ_TYPE_LEVEL_HIGH>;
+
+			interconnects = <&gem_noc MASTER_APPSS_PROC QCOM_ICC_TAG_ACTIVE_ONLY
+					 &gem_noc SLAVE_LLCC QCOM_ICC_TAG_ACTIVE_ONLY>;
+			operating-points-v2 = <&cpu_bwmon_opp_table>;
+
+			cpu_bwmon_opp_table: opp-table {
+				compatible = "operating-points-v2";
+
+				opp-0 {
+					opp-peak-kBps = <2288000>;
+				};
+
+				opp-1 {
+					opp-peak-kBps = <4577000>;
+				};
+
+				opp-2 {
+					opp-peak-kBps = <7110000>;
+				};
+
+				opp-3 {
+					opp-peak-kBps = <9155000>;
+				};
+
+				opp-4 {
+					opp-peak-kBps = <12298000>;
+				};
+
+				opp-5 {
+					opp-peak-kBps = <14236000>;
+				};
+			};
+		};
+
+		pmu@90cd000 {
+			compatible = "qcom,sc7180-llcc-bwmon", "qcom,sc7280-llcc-bwmon";
+			reg = <0 0x090cd000 0 0x1000>;
+			interrupts = <GIC_SPI 241 IRQ_TYPE_LEVEL_HIGH>;
+
+			interconnects = <&mc_virt MASTER_LLCC QCOM_ICC_TAG_ACTIVE_ONLY
+					 &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ACTIVE_ONLY>;
+			operating-points-v2 = <&llcc_bwmon_opp_table>;
+
+			llcc_bwmon_opp_table: opp-table {
+				compatible = "operating-points-v2";
+
+				opp-0 {
+					opp-peak-kBps = <1144000>;
+				};
+
+				opp-1 {
+					opp-peak-kBps = <1720000>;
+				};
+
+				opp-2 {
+					opp-peak-kBps = <2086000>;
+				};
+
+				opp-3 {
+					opp-peak-kBps = <2929000>;
+				};
+
+				opp-4 {
+					opp-peak-kBps = <3879000>;
+				};
+
+				opp-5 {
+					opp-peak-kBps = <5931000>;
+				};
+
+				opp-6 {
+					opp-peak-kBps = <6881000>;
+				};
+
+				opp-7 {
+					opp-peak-kBps = <8137000>;
+				};
+			};
+		};
+
 		dc_noc: interconnect@9160000 {
 			compatible = "qcom,sc7180-dc-noc";
 			reg = <0 0x09160000 0 0x03200>;

-- 
2.41.0

