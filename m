Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77C3065DB17
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 18:17:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239966AbjADRRh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 12:17:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239803AbjADRQx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 12:16:53 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2282813DD8
        for <linux-kernel@vger.kernel.org>; Wed,  4 Jan 2023 09:16:51 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id y25so51380871lfa.9
        for <linux-kernel@vger.kernel.org>; Wed, 04 Jan 2023 09:16:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ch6/y+WqEvaqNcXLTo9/PlLHC2sfP0seupkFoL9CYQY=;
        b=oqv0Bu21zVcvr8zqh7LlN9FmkI2p8lTFVm4+Qk3Yi7tFjlGQPnwIBeU7aRoZr2u4KF
         LcsBPcOj/gW1nGf+K60hpAtVcI8Yv0hrAkWrENpgBMmwltgvz3ddWGTe0GcAfArTjpTX
         hCi4PtDNHv/OygtoBTaSpL0f6kauiHPAu7oWu6CaBHmhSbujYVa9KW3cx+ojUhetYH4s
         EjGxNWOfTj5XxgZezFOflbxr0sb29MWxZ1h3FoJuYFPerikwh1H9NPufWk8VlOB7JyFm
         eTIdfQE5ky9kjRcbHW/2okoOd9DciidT921zq/zcCvdS10HyXnOkEyh5tfvfCNbtthzP
         TvWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ch6/y+WqEvaqNcXLTo9/PlLHC2sfP0seupkFoL9CYQY=;
        b=D5O+E4yDCOqr1p7cb31cBX+7eBdb3fqIu9W24YG7U7P1o/PLogV6hbdc/FwzolPoaF
         k3+8xR1vHqSVspto8ttz5yoQa8b178SQ4gUaYd1fY4Y4yNcs7K/Slb4K8+IhqlldfhDm
         ETq6Ue5VcY7lk133nmJ6nqwhlWwaESbyHzQ+wlmtkbwMcGGVSA+JbJmpOKSJu20my4mU
         n3c0Z/kTABwjkxLQYlyh/PhJXuQy65aT2Jz2bqWVgbmsuueG1DA18Vy7ytHKSPHh/q1i
         YFlb0aMu8Jw+Nyk00uMXasU+9t9mvyKYOHJ2RQ3hwdeP6ZR7AivMYTOwc8AvfArQE9R7
         +5OQ==
X-Gm-Message-State: AFqh2krCq28DoafGgmHRvVOa2qFEMzdltLWopPTh/mln3EQfLjbCtF6D
        OlcnGWzoZmaiagWZWhCsdDtHgg==
X-Google-Smtp-Source: AMrXdXu0RihaaHzJ/qZZvLo0qXusFXwbOc6bfz24b14C+amrbeZXk/SkaDQWQlIp8ztdyzSU+Utf2A==
X-Received: by 2002:a05:6512:3ba1:b0:4b5:8fbf:7dd6 with SMTP id g33-20020a0565123ba100b004b58fbf7dd6mr22488780lfv.61.1672852609444;
        Wed, 04 Jan 2023 09:16:49 -0800 (PST)
Received: from localhost.localdomain (abxi45.neoplus.adsl.tpnet.pl. [83.9.2.45])
        by smtp.gmail.com with ESMTPSA id o22-20020a056512051600b004a44ffb1050sm5179520lfb.171.2023.01.04.09.16.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Jan 2023 09:16:49 -0800 (PST)
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
Subject: [PATCH v2 3/3] arm64: dts: qcom: sm6350: Set up DDR & L3 scaling
Date:   Wed,  4 Jan 2023 18:16:42 +0100
Message-Id: <20230104171643.1004054-3-konrad.dybcio@linaro.org>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230104171643.1004054-1-konrad.dybcio@linaro.org>
References: <20230104171643.1004054-1-konrad.dybcio@linaro.org>
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
v1 -> v2:
Make sure to tag the paths with an ACTIVE moniker, so that the poor
thing doesn't spontaneously decide to vote for 8GiB/s of DDR bandwith
while sleeping..

 arch/arm64/boot/dts/qcom/sm6350.dtsi | 140 +++++++++++++++++++++++++++
 arch/arm64/boot/dts/qcom/sm7225.dtsi |  19 ++++
 2 files changed, 159 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm6350.dtsi b/arch/arm64/boot/dts/qcom/sm6350.dtsi
index 893a1ffb5e3d..94a6f6cdfdd6 100644
--- a/arch/arm64/boot/dts/qcom/sm6350.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm6350.dtsi
@@ -10,6 +10,8 @@
 #include <dt-bindings/clock/qcom,rpmh.h>
 #include <dt-bindings/dma/qcom-gpi.h>
 #include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/interconnect/qcom,icc.h>
+#include <dt-bindings/interconnect/qcom,osm-l3.h>
 #include <dt-bindings/interconnect/qcom,sm6350.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/mailbox/qcom-ipcc.h>
@@ -49,6 +51,10 @@ CPU0: cpu@0 {
 			dynamic-power-coefficient = <100>;
 			next-level-cache = <&L2_0>;
 			qcom,freq-domain = <&cpufreq_hw 0>;
+			operating-points-v2 = <&cpu0_opp_table>;
+			interconnects = <&gem_noc MASTER_AMPSS_M0 QCOM_ICC_TAG_ACTIVE_ONLY
+					 &clk_virt SLAVE_EBI_CH0 QCOM_ICC_TAG_ACTIVE_ONLY>,
+					<&osm_l3 MASTER_OSM_L3_APPS &osm_l3 SLAVE_OSM_L3>;
 			#cooling-cells = <2>;
 			L2_0: l2-cache {
 				compatible = "cache";
@@ -68,6 +74,10 @@ CPU1: cpu@100 {
 			dynamic-power-coefficient = <100>;
 			next-level-cache = <&L2_100>;
 			qcom,freq-domain = <&cpufreq_hw 0>;
+			operating-points-v2 = <&cpu0_opp_table>;
+			interconnects = <&gem_noc MASTER_AMPSS_M0 QCOM_ICC_TAG_ACTIVE_ONLY
+					 &clk_virt SLAVE_EBI_CH0 QCOM_ICC_TAG_ACTIVE_ONLY>,
+					<&osm_l3 MASTER_OSM_L3_APPS &osm_l3 SLAVE_OSM_L3>;
 			#cooling-cells = <2>;
 			L2_100: l2-cache {
 				compatible = "cache";
@@ -84,6 +94,10 @@ CPU2: cpu@200 {
 			dynamic-power-coefficient = <100>;
 			next-level-cache = <&L2_200>;
 			qcom,freq-domain = <&cpufreq_hw 0>;
+			operating-points-v2 = <&cpu0_opp_table>;
+			interconnects = <&gem_noc MASTER_AMPSS_M0 QCOM_ICC_TAG_ACTIVE_ONLY
+					 &clk_virt SLAVE_EBI_CH0 QCOM_ICC_TAG_ACTIVE_ONLY>,
+					<&osm_l3 MASTER_OSM_L3_APPS &osm_l3 SLAVE_OSM_L3>;
 			#cooling-cells = <2>;
 			L2_200: l2-cache {
 				compatible = "cache";
@@ -100,6 +114,10 @@ CPU3: cpu@300 {
 			dynamic-power-coefficient = <100>;
 			next-level-cache = <&L2_300>;
 			qcom,freq-domain = <&cpufreq_hw 0>;
+			operating-points-v2 = <&cpu0_opp_table>;
+			interconnects = <&gem_noc MASTER_AMPSS_M0 QCOM_ICC_TAG_ACTIVE_ONLY
+					 &clk_virt SLAVE_EBI_CH0 QCOM_ICC_TAG_ACTIVE_ONLY>,
+					<&osm_l3 MASTER_OSM_L3_APPS &osm_l3 SLAVE_OSM_L3>;
 			#cooling-cells = <2>;
 			L2_300: l2-cache {
 				compatible = "cache";
@@ -116,6 +134,10 @@ CPU4: cpu@400 {
 			dynamic-power-coefficient = <100>;
 			next-level-cache = <&L2_400>;
 			qcom,freq-domain = <&cpufreq_hw 0>;
+			operating-points-v2 = <&cpu0_opp_table>;
+			interconnects = <&gem_noc MASTER_AMPSS_M0 QCOM_ICC_TAG_ACTIVE_ONLY
+					 &clk_virt SLAVE_EBI_CH0 QCOM_ICC_TAG_ACTIVE_ONLY>,
+					<&osm_l3 MASTER_OSM_L3_APPS &osm_l3 SLAVE_OSM_L3>;
 			#cooling-cells = <2>;
 			L2_400: l2-cache {
 				compatible = "cache";
@@ -132,6 +154,10 @@ CPU5: cpu@500 {
 			dynamic-power-coefficient = <100>;
 			next-level-cache = <&L2_500>;
 			qcom,freq-domain = <&cpufreq_hw 0>;
+			operating-points-v2 = <&cpu0_opp_table>;
+			interconnects = <&gem_noc MASTER_AMPSS_M0 QCOM_ICC_TAG_ACTIVE_ONLY
+					 &clk_virt SLAVE_EBI_CH0 QCOM_ICC_TAG_ACTIVE_ONLY>,
+					<&osm_l3 MASTER_OSM_L3_APPS &osm_l3 SLAVE_OSM_L3>;
 			#cooling-cells = <2>;
 			L2_500: l2-cache {
 				compatible = "cache";
@@ -149,6 +175,10 @@ CPU6: cpu@600 {
 			dynamic-power-coefficient = <703>;
 			next-level-cache = <&L2_600>;
 			qcom,freq-domain = <&cpufreq_hw 1>;
+			operating-points-v2 = <&cpu6_opp_table>;
+			interconnects = <&gem_noc MASTER_AMPSS_M0 QCOM_ICC_TAG_ACTIVE_ONLY
+					 &clk_virt SLAVE_EBI_CH0 QCOM_ICC_TAG_ACTIVE_ONLY>,
+					<&osm_l3 MASTER_OSM_L3_APPS &osm_l3 SLAVE_OSM_L3>;
 			#cooling-cells = <2>;
 			L2_600: l2-cache {
 				compatible = "cache";
@@ -165,6 +195,10 @@ CPU7: cpu@700 {
 			dynamic-power-coefficient = <703>;
 			next-level-cache = <&L2_700>;
 			qcom,freq-domain = <&cpufreq_hw 1>;
+			operating-points-v2 = <&cpu6_opp_table>;
+			interconnects = <&gem_noc MASTER_AMPSS_M0 QCOM_ICC_TAG_ACTIVE_ONLY
+					 &clk_virt SLAVE_EBI_CH0 QCOM_ICC_TAG_ACTIVE_ONLY>,
+					<&osm_l3 MASTER_OSM_L3_APPS &osm_l3 SLAVE_OSM_L3>;
 			#cooling-cells = <2>;
 			L2_700: l2-cache {
 				compatible = "cache";
@@ -222,6 +256,112 @@ memory@80000000 {
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

