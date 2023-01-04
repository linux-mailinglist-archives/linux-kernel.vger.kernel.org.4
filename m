Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB1E265D450
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 14:32:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239598AbjADNco (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 08:32:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231722AbjADNbd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 08:31:33 -0500
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4093B63E4
        for <linux-kernel@vger.kernel.org>; Wed,  4 Jan 2023 05:29:24 -0800 (PST)
Received: by mail-lj1-x233.google.com with SMTP id x37so28495612ljq.1
        for <linux-kernel@vger.kernel.org>; Wed, 04 Jan 2023 05:29:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xVuXOvsxO/ihY44a6eTHqj7za6so2owzQQFtxjcx7GU=;
        b=T703tyuFLKLsCVU3p84s8yHODKT9mKxVemimX2RHQJYwWpICSxBVeXML4vTCS8Tq5n
         3ngrHmEl9zDBpTP3vYUw9mxhrTV5iMgocpnuJHeJKK+290rLu2WzRDODnZ08CywMrmP+
         it+uPTq87SZu3TBHMtqNYHTR6PEN+/sdAx6RBgLvppk642jgBDQYBtQC+H9oS976iTo0
         FBWIUrvGIVrsm4H/ACFMRNsGpqx5u01FmtdLPtlZObXO1Uc005M8VW0obrVenW8WcHt5
         GMYXfS+E+nO3j3sXz6F62kh/+4nBAVlAy/40bzb+01Z7IsPjQbjpUVLktBWfFpF7dgci
         f1ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xVuXOvsxO/ihY44a6eTHqj7za6so2owzQQFtxjcx7GU=;
        b=CpB/jHE5/b2k0oqXV0EDvbykVl87adefBC+0y9yzNR4xYHfrMKYjfaArYcYKsbvyR2
         KpTozDArlcPufY0299/ZvqMRx83Q4nT9QSYzqvNmRWrjQcak1pNyqeTubbai3HGMYck+
         /cjR2TMSHh7fS/PzAkP+w0+D9wruV12ZfvwPLheG2LMUzs9hlix02fKS/wEi2UvANKF2
         1KO1IfWdSRg70dfv1UqkKnTm6DvspoIylHVUT0M6ynCJUFtJJnm6H3aNOiBwyJPayH6x
         3oEZ5V41zW8chXV+Sehai4lFrC1vl2r8lNVGdNUlhJew03h1uND0BsJPpRYbvUpgjQh3
         yQkw==
X-Gm-Message-State: AFqh2ko+bedWMsrDf9xxRVnayouGZIWoJ3BV3q5vJ2CPRqnIBtKz5AAp
        GFLNMsxN/Vzw4DklgVBATDi4kA==
X-Google-Smtp-Source: AMrXdXsCHTtCq1zI/kyHL05wEIvNylzcwS1IsjBP4EpJaMils03GnIY3/wotosZA0OL1GBFqFl5sFA==
X-Received: by 2002:a2e:b179:0:b0:27f:b9d4:9ed3 with SMTP id a25-20020a2eb179000000b0027fb9d49ed3mr9861406ljm.15.1672838962585;
        Wed, 04 Jan 2023 05:29:22 -0800 (PST)
Received: from localhost.localdomain (abxi45.neoplus.adsl.tpnet.pl. [83.9.2.45])
        by smtp.gmail.com with ESMTPSA id k23-20020a2e92d7000000b0027fd02c99d4sm1947071ljh.75.2023.01.04.05.29.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Jan 2023 05:29:22 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
To:     linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org, krzysztof.kozlowski@linaro.org
Cc:     marijn.suijten@somainline.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Georgi Djakov <djakov@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Sibi Sankar <quic_sibis@quicinc.com>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] arm64: dts: qcom: sm6350: Set up DDR & L3 scaling
Date:   Wed,  4 Jan 2023 14:29:15 +0100
Message-Id: <20230104132915.667946-3-konrad.dybcio@linaro.org>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230104132915.667946-1-konrad.dybcio@linaro.org>
References: <20230104132915.667946-1-konrad.dybcio@linaro.org>
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

Add the CPU OPP tables including core frequency and L3 bus frequency.
The L3 throughput values were chosen by studying the frequencies
available in HW LUT and picking the highest one that's less than the
CPU frequency. DDR clock rates come from the vendor kernel.

Available values from the HW LUT:
300000000
556800000
652800000
806400000
844800000
940800000
1132800000
1209600000
1286400000
1401600000
1459200000

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm6350.dtsi | 131 +++++++++++++++++++++++++++
 arch/arm64/boot/dts/qcom/sm7225.dtsi |  19 ++++
 2 files changed, 150 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm6350.dtsi b/arch/arm64/boot/dts/qcom/sm6350.dtsi
index 893a1ffb5e3d..411a8279f84f 100644
--- a/arch/arm64/boot/dts/qcom/sm6350.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm6350.dtsi
@@ -10,6 +10,7 @@
 #include <dt-bindings/clock/qcom,rpmh.h>
 #include <dt-bindings/dma/qcom-gpi.h>
 #include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/interconnect/qcom,osm-l3.h>
 #include <dt-bindings/interconnect/qcom,sm6350.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/mailbox/qcom-ipcc.h>
@@ -49,6 +50,9 @@ CPU0: cpu@0 {
 			dynamic-power-coefficient = <100>;
 			next-level-cache = <&L2_0>;
 			qcom,freq-domain = <&cpufreq_hw 0>;
+			operating-points-v2 = <&cpu0_opp_table>;
+			interconnects = <&gem_noc MASTER_AMPSS_M0 0 &clk_virt SLAVE_EBI_CH0 0>,
+					<&osm_l3 MASTER_OSM_L3_APPS &osm_l3 SLAVE_OSM_L3>;
 			#cooling-cells = <2>;
 			L2_0: l2-cache {
 				compatible = "cache";
@@ -68,6 +72,9 @@ CPU1: cpu@100 {
 			dynamic-power-coefficient = <100>;
 			next-level-cache = <&L2_100>;
 			qcom,freq-domain = <&cpufreq_hw 0>;
+			operating-points-v2 = <&cpu0_opp_table>;
+			interconnects = <&gem_noc MASTER_AMPSS_M0 0 &clk_virt SLAVE_EBI_CH0 0>,
+					<&osm_l3 MASTER_OSM_L3_APPS &osm_l3 SLAVE_OSM_L3>;
 			#cooling-cells = <2>;
 			L2_100: l2-cache {
 				compatible = "cache";
@@ -84,6 +91,9 @@ CPU2: cpu@200 {
 			dynamic-power-coefficient = <100>;
 			next-level-cache = <&L2_200>;
 			qcom,freq-domain = <&cpufreq_hw 0>;
+			operating-points-v2 = <&cpu0_opp_table>;
+			interconnects = <&gem_noc MASTER_AMPSS_M0 0 &clk_virt SLAVE_EBI_CH0 0>,
+					<&osm_l3 MASTER_OSM_L3_APPS &osm_l3 SLAVE_OSM_L3>;
 			#cooling-cells = <2>;
 			L2_200: l2-cache {
 				compatible = "cache";
@@ -100,6 +110,9 @@ CPU3: cpu@300 {
 			dynamic-power-coefficient = <100>;
 			next-level-cache = <&L2_300>;
 			qcom,freq-domain = <&cpufreq_hw 0>;
+			operating-points-v2 = <&cpu0_opp_table>;
+			interconnects = <&gem_noc MASTER_AMPSS_M0 0 &clk_virt SLAVE_EBI_CH0 0>,
+					<&osm_l3 MASTER_OSM_L3_APPS &osm_l3 SLAVE_OSM_L3>;
 			#cooling-cells = <2>;
 			L2_300: l2-cache {
 				compatible = "cache";
@@ -116,6 +129,9 @@ CPU4: cpu@400 {
 			dynamic-power-coefficient = <100>;
 			next-level-cache = <&L2_400>;
 			qcom,freq-domain = <&cpufreq_hw 0>;
+			operating-points-v2 = <&cpu0_opp_table>;
+			interconnects = <&gem_noc MASTER_AMPSS_M0 0 &clk_virt SLAVE_EBI_CH0 0>,
+					<&osm_l3 MASTER_OSM_L3_APPS &osm_l3 SLAVE_OSM_L3>;
 			#cooling-cells = <2>;
 			L2_400: l2-cache {
 				compatible = "cache";
@@ -132,6 +148,9 @@ CPU5: cpu@500 {
 			dynamic-power-coefficient = <100>;
 			next-level-cache = <&L2_500>;
 			qcom,freq-domain = <&cpufreq_hw 0>;
+			operating-points-v2 = <&cpu0_opp_table>;
+			interconnects = <&gem_noc MASTER_AMPSS_M0 0 &clk_virt SLAVE_EBI_CH0 0>,
+					<&osm_l3 MASTER_OSM_L3_APPS &osm_l3 SLAVE_OSM_L3>;
 			#cooling-cells = <2>;
 			L2_500: l2-cache {
 				compatible = "cache";
@@ -149,6 +168,9 @@ CPU6: cpu@600 {
 			dynamic-power-coefficient = <703>;
 			next-level-cache = <&L2_600>;
 			qcom,freq-domain = <&cpufreq_hw 1>;
+			operating-points-v2 = <&cpu6_opp_table>;
+			interconnects = <&gem_noc MASTER_AMPSS_M0 0 &clk_virt SLAVE_EBI_CH0 0>,
+					<&osm_l3 MASTER_OSM_L3_APPS &osm_l3 SLAVE_OSM_L3>;
 			#cooling-cells = <2>;
 			L2_600: l2-cache {
 				compatible = "cache";
@@ -165,6 +187,9 @@ CPU7: cpu@700 {
 			dynamic-power-coefficient = <703>;
 			next-level-cache = <&L2_700>;
 			qcom,freq-domain = <&cpufreq_hw 1>;
+			operating-points-v2 = <&cpu6_opp_table>;
+			interconnects = <&gem_noc MASTER_AMPSS_M0 0 &clk_virt SLAVE_EBI_CH0 0>,
+					<&osm_l3 MASTER_OSM_L3_APPS &osm_l3 SLAVE_OSM_L3>;
 			#cooling-cells = <2>;
 			L2_700: l2-cache {
 				compatible = "cache";
@@ -222,6 +247,112 @@ memory@80000000 {
 		reg = <0x0 0x80000000 0x0 0x0>;
 	};
 
+	cpu0_opp_table: opp-table-cpu0 {
+		compatible = "operating-points-v2";
+		opp-shared;
+
+		opp-300000000 {
+			opp-hz = /bits/ 64 <300000000>;
+			/* DDR: 4-wide, 2 channels, double data rate, L3: 16-wide, 2 channels */
+			opp-peak-kBps = <(200000 * 4 * 2 * 2) (300000 * 16 * 2)>;
+		};
+
+		opp-576000000 {
+			opp-hz = /bits/ 64 <576000000>;
+			opp-peak-kBps = <(547000 * 4 * 2 * 2) (556800 * 16 * 2)>;
+		};
+
+		opp-768000000 {
+			opp-hz = /bits/ 64 <768000000>;
+			opp-peak-kBps = <(768000 * 4 * 2 * 2) (652800 * 16 * 2)>;
+		};
+
+		opp-1017600000 {
+			opp-hz = /bits/ 64 <1017600000>;
+			opp-peak-kBps = <(1017000 * 4 * 2 * 2) (940800 * 16 * 2)>;
+		};
+
+		opp-1248000000 {
+			opp-hz = /bits/ 64 <1248000000>;
+			opp-peak-kBps = <(1017000 * 4 * 2 * 2) (1209600 * 16 * 2)>;
+		};
+
+		opp-1324800000 {
+			opp-hz = /bits/ 64 <1324800000>;
+			opp-peak-kBps = <(1017000 * 4 * 2 * 2) (1286400 * 16 * 2)>;
+		};
+
+		opp-1516800000 {
+			opp-hz = /bits/ 64 <1516800000>;
+			opp-peak-kBps = <(1353000 * 4 * 2 * 2) (1459200 * 16 * 2)>;
+		};
+
+		opp-1612800000 {
+			opp-hz = /bits/ 64 <1612800000>;
+			opp-peak-kBps = <(1555000 * 4 * 2 * 2) (1459200 * 16 * 2)>;
+		};
+
+		opp-1708800000 {
+			opp-hz = /bits/ 64 <1708800000>;
+			opp-peak-kBps = <(1555000 * 4 * 2 * 2) (1459200 * 16 * 2)>;
+		};
+	};
+
+	cpu6_opp_table: opp-table-cpu6 {
+		compatible = "operating-points-v2";
+		opp-shared;
+
+		opp-300000000 {
+			opp-hz = /bits/ 64 <300000000>;
+			opp-peak-kBps = <(200000 * 4 * 2 * 2) (300000 * 16 * 2)>;
+		};
+
+		opp-787200000 {
+			opp-hz = /bits/ 64 <787200000>;
+			opp-peak-kBps = <(768000 * 4 * 2 * 2) (652800 * 16 * 2)>;
+		};
+
+		opp-979200000 {
+			opp-hz = /bits/ 64 <979200000>;
+			opp-peak-kBps = <(768000 * 4 * 2 * 2) (940800 * 16 * 2)>;
+		};
+
+		opp-1036800000 {
+			opp-hz = /bits/ 64 <1036800000>;
+			opp-peak-kBps = <(1017000 * 4 * 2 * 2) (940800 * 16 * 2)>;
+		};
+
+		opp-1248000000 {
+			opp-hz = /bits/ 64 <1248000000>;
+			opp-peak-kBps = <(1017000 * 4 * 2 * 2) (1209600 * 16 * 2)>;
+		};
+
+		opp-1401600000 {
+			opp-hz = /bits/ 64 <1401600000>;
+			opp-peak-kBps = <(1353000 * 4 * 2 * 2) (1401600 * 16 * 2)>;
+		};
+
+		opp-1555200000 {
+			opp-hz = /bits/ 64 <1555200000>;
+			opp-peak-kBps = <(1555000 * 4 * 2 * 2) (1459200 * 16 * 2)>;
+		};
+
+		opp-1766400000 {
+			opp-hz = /bits/ 64 <1766400000>;
+			opp-peak-kBps = <(1555000 * 4 * 2 * 2) (1459200 * 16 * 2)>;
+		};
+
+		opp-1900800000 {
+			opp-hz = /bits/ 64 <1900800000>;
+			opp-peak-kBps = <(1804000 * 4 * 2 * 2) (1459200 * 16 * 2)>;
+		};
+
+		opp-2073600000 {
+			opp-hz = /bits/ 64 <2073600000>;
+			opp-peak-kBps = <(2092000 * 4 * 2 * 2) (1459200 * 16 * 2)>;
+		};
+	};
+
 	pmu {
 		compatible = "arm,armv8-pmuv3";
 		interrupts = <GIC_PPI 5 IRQ_TYPE_LEVEL_LOW>;
diff --git a/arch/arm64/boot/dts/qcom/sm7225.dtsi b/arch/arm64/boot/dts/qcom/sm7225.dtsi
index 7b2a002ca7ff..b7b4044e9bb0 100644
--- a/arch/arm64/boot/dts/qcom/sm7225.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm7225.dtsi
@@ -14,3 +14,22 @@
 &CPU5 { compatible = "qcom,kryo570"; };
 &CPU6 { compatible = "qcom,kryo570"; };
 &CPU7 { compatible = "qcom,kryo570"; };
+
+&cpu0_opp_table {
+	opp-1804800000 {
+		opp-hz = /bits/ 64 <1804800000>;
+		opp-peak-kBps = <(1804000 * 4 * 2 * 2) (1459200 * 16 * 2)>;
+	};
+};
+
+&cpu6_opp_table {
+	opp-2131200000 {
+		opp-hz = /bits/ 64 <2131200000>;
+		opp-peak-kBps = <(2092000 * 4 * 2 * 2) (1459200 * 16 * 2)>;
+	};
+
+	opp-2208000000 {
+		opp-hz = /bits/ 64 <2208000000>;
+		opp-peak-kBps = <(2092000 * 4 * 2 * 2) (1459200 * 16 * 2)>;
+	};
+};
-- 
2.39.0

