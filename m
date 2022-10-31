Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D318C613297
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 10:21:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230238AbiJaJVi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 05:21:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230222AbiJaJVM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 05:21:12 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6B35ADEFD;
        Mon, 31 Oct 2022 02:20:53 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7E88F113E;
        Mon, 31 Oct 2022 02:20:59 -0700 (PDT)
Received: from pierre123.arm.com (unknown [10.57.7.107])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 874773F703;
        Mon, 31 Oct 2022 02:20:50 -0700 (PDT)
From:   Pierre Gondois <pierre.gondois@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     pierre.gondois@arm.com, Rob.Herring@arm.com,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH 15/20] arm64: dts: Update cache properties for qcom
Date:   Mon, 31 Oct 2022 10:20:50 +0100
Message-Id: <20221031092051.533305-1-pierre.gondois@arm.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The DeviceTree Specification v0.3 specifies that the cache node
'compatible' and 'cache-level' properties are 'required'. Cf.
s3.8 Multi-level and Shared Cache Nodes

The recently added init_of_cache_level() function checks
these properties. Add them if missing.

About msm8953.dtsi:
According to the Devicetree Specification v0.3,
s3.7.3 'Internal (L1) Cache Properties',
  cache-unified:
  If present, specifies the cache has a unified or-
  ganization. If not present, specifies that the
  cache has a Harvard architecture with separate
  caches for instructions and data.
Plus, the 'cache-level' property seems to be reserved to higher
cache levels (cf s3.8).

To describe a l1 data/instruction cache couple, no cache
information should be described. Remove the l1 cache nodes.

Signed-off-by: Pierre Gondois <pierre.gondois@arm.com>
---
 arch/arm64/boot/dts/qcom/msm8953.dtsi  | 56 --------------------------
 arch/arm64/boot/dts/qcom/sc7180.dtsi   |  9 +++++
 arch/arm64/boot/dts/qcom/sc7280.dtsi   |  9 +++++
 arch/arm64/boot/dts/qcom/sc8280xp.dtsi |  9 +++++
 arch/arm64/boot/dts/qcom/sdm845.dtsi   |  9 +++++
 arch/arm64/boot/dts/qcom/sm6125.dtsi   |  2 +
 arch/arm64/boot/dts/qcom/sm6350.dtsi   |  9 +++++
 arch/arm64/boot/dts/qcom/sm8150.dtsi   |  9 +++++
 arch/arm64/boot/dts/qcom/sm8250.dtsi   |  9 +++++
 arch/arm64/boot/dts/qcom/sm8350.dtsi   |  9 +++++
 arch/arm64/boot/dts/qcom/sm8450.dtsi   |  9 +++++
 11 files changed, 83 insertions(+), 56 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8953.dtsi b/arch/arm64/boot/dts/qcom/msm8953.dtsi
index 8416a45ca4fd..3a01ddba7ee5 100644
--- a/arch/arm64/boot/dts/qcom/msm8953.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8953.dtsi
@@ -42,13 +42,6 @@ CPU0: cpu@0 {
 			capacity-dmips-mhz = <1024>;
 			next-level-cache = <&L2_0>;
 			#cooling-cells = <2>;
-
-			l1-icache {
-				compatible = "cache";
-			};
-			l1-dcache {
-				compatible = "cache";
-			};
 		};
 
 		CPU1: cpu@1 {
@@ -59,13 +52,6 @@ CPU1: cpu@1 {
 			capacity-dmips-mhz = <1024>;
 			next-level-cache = <&L2_0>;
 			#cooling-cells = <2>;
-
-			l1-icache {
-				compatible = "cache";
-			};
-			l1-dcache {
-				compatible = "cache";
-			};
 		};
 
 		CPU2: cpu@2 {
@@ -76,13 +62,6 @@ CPU2: cpu@2 {
 			capacity-dmips-mhz = <1024>;
 			next-level-cache = <&L2_0>;
 			#cooling-cells = <2>;
-
-			l1-icache {
-				compatible = "cache";
-			};
-			l1-dcache {
-				compatible = "cache";
-			};
 		};
 
 		CPU3: cpu@3 {
@@ -93,13 +72,6 @@ CPU3: cpu@3 {
 			capacity-dmips-mhz = <1024>;
 			next-level-cache = <&L2_0>;
 			#cooling-cells = <2>;
-
-			l1-icache {
-				compatible = "cache";
-			};
-			l1-dcache {
-				compatible = "cache";
-			};
 		};
 
 		CPU4: cpu@100 {
@@ -110,13 +82,6 @@ CPU4: cpu@100 {
 			capacity-dmips-mhz = <1024>;
 			next-level-cache = <&L2_1>;
 			#cooling-cells = <2>;
-
-			l1-icache {
-				compatible = "cache";
-			};
-			l1-dcache {
-				compatible = "cache";
-			};
 		};
 
 		CPU5: cpu@101 {
@@ -127,13 +92,6 @@ CPU5: cpu@101 {
 			capacity-dmips-mhz = <1024>;
 			next-level-cache = <&L2_1>;
 			#cooling-cells = <2>;
-
-			l1-icache {
-				compatible = "cache";
-			};
-			l1-dcache {
-				compatible = "cache";
-			};
 		};
 
 		CPU6: cpu@102 {
@@ -144,13 +102,6 @@ CPU6: cpu@102 {
 			capacity-dmips-mhz = <1024>;
 			next-level-cache = <&L2_1>;
 			#cooling-cells = <2>;
-
-			l1-icache {
-				compatible = "cache";
-			};
-			l1-dcache {
-				compatible = "cache";
-			};
 		};
 
 		CPU7: cpu@103 {
@@ -161,13 +112,6 @@ CPU7: cpu@103 {
 			capacity-dmips-mhz = <1024>;
 			next-level-cache = <&L2_1>;
 			#cooling-cells = <2>;
-
-			l1-icache {
-				compatible = "cache";
-			};
-			l1-dcache {
-				compatible = "cache";
-			};
 		};
 
 		cpu-map {
diff --git a/arch/arm64/boot/dts/qcom/sc7180.dtsi b/arch/arm64/boot/dts/qcom/sc7180.dtsi
index b82c335c25af..4d66d9148dcd 100644
--- a/arch/arm64/boot/dts/qcom/sc7180.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7180.dtsi
@@ -146,9 +146,11 @@ &LITTLE_CPU_SLEEP_1
 			qcom,freq-domain = <&cpufreq_hw 0>;
 			L2_0: l2-cache {
 				compatible = "cache";
+				cache-level = <2>;
 				next-level-cache = <&L3_0>;
 				L3_0: l3-cache {
 					compatible = "cache";
+					cache-level = <3>;
 				};
 			};
 		};
@@ -171,6 +173,7 @@ &LITTLE_CPU_SLEEP_1
 			qcom,freq-domain = <&cpufreq_hw 0>;
 			L2_100: l2-cache {
 				compatible = "cache";
+				cache-level = <2>;
 				next-level-cache = <&L3_0>;
 			};
 		};
@@ -193,6 +196,7 @@ &LITTLE_CPU_SLEEP_1
 			qcom,freq-domain = <&cpufreq_hw 0>;
 			L2_200: l2-cache {
 				compatible = "cache";
+				cache-level = <2>;
 				next-level-cache = <&L3_0>;
 			};
 		};
@@ -215,6 +219,7 @@ &LITTLE_CPU_SLEEP_1
 			qcom,freq-domain = <&cpufreq_hw 0>;
 			L2_300: l2-cache {
 				compatible = "cache";
+				cache-level = <2>;
 				next-level-cache = <&L3_0>;
 			};
 		};
@@ -237,6 +242,7 @@ &LITTLE_CPU_SLEEP_1
 			qcom,freq-domain = <&cpufreq_hw 0>;
 			L2_400: l2-cache {
 				compatible = "cache";
+				cache-level = <2>;
 				next-level-cache = <&L3_0>;
 			};
 		};
@@ -259,6 +265,7 @@ &LITTLE_CPU_SLEEP_1
 			qcom,freq-domain = <&cpufreq_hw 0>;
 			L2_500: l2-cache {
 				compatible = "cache";
+				cache-level = <2>;
 				next-level-cache = <&L3_0>;
 			};
 		};
@@ -281,6 +288,7 @@ &BIG_CPU_SLEEP_1
 			qcom,freq-domain = <&cpufreq_hw 1>;
 			L2_600: l2-cache {
 				compatible = "cache";
+				cache-level = <2>;
 				next-level-cache = <&L3_0>;
 			};
 		};
@@ -303,6 +311,7 @@ &BIG_CPU_SLEEP_1
 			qcom,freq-domain = <&cpufreq_hw 1>;
 			L2_700: l2-cache {
 				compatible = "cache";
+				cache-level = <2>;
 				next-level-cache = <&L3_0>;
 			};
 		};
diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi b/arch/arm64/boot/dts/qcom/sc7280.dtsi
index 13d7f267b289..bf2cd427de98 100644
--- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
@@ -179,9 +179,11 @@ &LITTLE_CPU_SLEEP_1
 			#cooling-cells = <2>;
 			L2_0: l2-cache {
 				compatible = "cache";
+				cache-level = <2>;
 				next-level-cache = <&L3_0>;
 				L3_0: l3-cache {
 					compatible = "cache";
+					cache-level = <3>;
 				};
 			};
 		};
@@ -202,6 +204,7 @@ &LITTLE_CPU_SLEEP_1
 			#cooling-cells = <2>;
 			L2_100: l2-cache {
 				compatible = "cache";
+				cache-level = <2>;
 				next-level-cache = <&L3_0>;
 			};
 		};
@@ -222,6 +225,7 @@ &LITTLE_CPU_SLEEP_1
 			#cooling-cells = <2>;
 			L2_200: l2-cache {
 				compatible = "cache";
+				cache-level = <2>;
 				next-level-cache = <&L3_0>;
 			};
 		};
@@ -242,6 +246,7 @@ &LITTLE_CPU_SLEEP_1
 			#cooling-cells = <2>;
 			L2_300: l2-cache {
 				compatible = "cache";
+				cache-level = <2>;
 				next-level-cache = <&L3_0>;
 			};
 		};
@@ -262,6 +267,7 @@ &BIG_CPU_SLEEP_1
 			#cooling-cells = <2>;
 			L2_400: l2-cache {
 				compatible = "cache";
+				cache-level = <2>;
 				next-level-cache = <&L3_0>;
 			};
 		};
@@ -282,6 +288,7 @@ &BIG_CPU_SLEEP_1
 			#cooling-cells = <2>;
 			L2_500: l2-cache {
 				compatible = "cache";
+				cache-level = <2>;
 				next-level-cache = <&L3_0>;
 			};
 		};
@@ -302,6 +309,7 @@ &BIG_CPU_SLEEP_1
 			#cooling-cells = <2>;
 			L2_600: l2-cache {
 				compatible = "cache";
+				cache-level = <2>;
 				next-level-cache = <&L3_0>;
 			};
 		};
@@ -322,6 +330,7 @@ &BIG_CPU_SLEEP_1
 			#cooling-cells = <2>;
 			L2_700: l2-cache {
 				compatible = "cache";
+				cache-level = <2>;
 				next-level-cache = <&L3_0>;
 			};
 		};
diff --git a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
index 49ea8b5612fc..45ef0d419ef1 100644
--- a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
@@ -188,9 +188,11 @@ CPU0: cpu@0 {
 			#cooling-cells = <2>;
 			L2_0: l2-cache {
 				compatible = "cache";
+				cache-level = <2>;
 				next-level-cache = <&L3_0>;
 				L3_0: l3-cache {
 				      compatible = "cache";
+				      cache-level = <3>;
 				};
 			};
 		};
@@ -209,6 +211,7 @@ CPU1: cpu@100 {
 			#cooling-cells = <2>;
 			L2_100: l2-cache {
 				compatible = "cache";
+				cache-level = <2>;
 				next-level-cache = <&L3_0>;
 			};
 		};
@@ -227,6 +230,7 @@ CPU2: cpu@200 {
 			#cooling-cells = <2>;
 			L2_200: l2-cache {
 				compatible = "cache";
+				cache-level = <2>;
 				next-level-cache = <&L3_0>;
 			};
 		};
@@ -245,6 +249,7 @@ CPU3: cpu@300 {
 			#cooling-cells = <2>;
 			L2_300: l2-cache {
 				compatible = "cache";
+				cache-level = <2>;
 				next-level-cache = <&L3_0>;
 			};
 		};
@@ -263,6 +268,7 @@ CPU4: cpu@400 {
 			#cooling-cells = <2>;
 			L2_400: l2-cache {
 				compatible = "cache";
+				cache-level = <2>;
 				next-level-cache = <&L3_0>;
 			};
 		};
@@ -281,6 +287,7 @@ CPU5: cpu@500 {
 			#cooling-cells = <2>;
 			L2_500: l2-cache {
 				compatible = "cache";
+				cache-level = <2>;
 				next-level-cache = <&L3_0>;
 			};
 		};
@@ -299,6 +306,7 @@ CPU6: cpu@600 {
 			#cooling-cells = <2>;
 			L2_600: l2-cache {
 				compatible = "cache";
+				cache-level = <2>;
 				next-level-cache = <&L3_0>;
 			};
 		};
@@ -317,6 +325,7 @@ CPU7: cpu@700 {
 			#cooling-cells = <2>;
 			L2_700: l2-cache {
 				compatible = "cache";
+				cache-level = <2>;
 				next-level-cache = <&L3_0>;
 			};
 		};
diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index 8ec144919ef1..2aa2a4c80f8a 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -209,9 +209,11 @@ CPU0: cpu@0 {
 			next-level-cache = <&L2_0>;
 			L2_0: l2-cache {
 				compatible = "cache";
+				cache-level = <2>;
 				next-level-cache = <&L3_0>;
 				L3_0: l3-cache {
 				      compatible = "cache";
+				      cache-level = <3>;
 				};
 			};
 		};
@@ -233,6 +235,7 @@ CPU1: cpu@100 {
 			next-level-cache = <&L2_100>;
 			L2_100: l2-cache {
 				compatible = "cache";
+				cache-level = <2>;
 				next-level-cache = <&L3_0>;
 			};
 		};
@@ -254,6 +257,7 @@ CPU2: cpu@200 {
 			next-level-cache = <&L2_200>;
 			L2_200: l2-cache {
 				compatible = "cache";
+				cache-level = <2>;
 				next-level-cache = <&L3_0>;
 			};
 		};
@@ -275,6 +279,7 @@ CPU3: cpu@300 {
 			next-level-cache = <&L2_300>;
 			L2_300: l2-cache {
 				compatible = "cache";
+				cache-level = <2>;
 				next-level-cache = <&L3_0>;
 			};
 		};
@@ -296,6 +301,7 @@ CPU4: cpu@400 {
 			next-level-cache = <&L2_400>;
 			L2_400: l2-cache {
 				compatible = "cache";
+				cache-level = <2>;
 				next-level-cache = <&L3_0>;
 			};
 		};
@@ -317,6 +323,7 @@ CPU5: cpu@500 {
 			next-level-cache = <&L2_500>;
 			L2_500: l2-cache {
 				compatible = "cache";
+				cache-level = <2>;
 				next-level-cache = <&L3_0>;
 			};
 		};
@@ -338,6 +345,7 @@ CPU6: cpu@600 {
 			next-level-cache = <&L2_600>;
 			L2_600: l2-cache {
 				compatible = "cache";
+				cache-level = <2>;
 				next-level-cache = <&L3_0>;
 			};
 		};
@@ -359,6 +367,7 @@ CPU7: cpu@700 {
 			next-level-cache = <&L2_700>;
 			L2_700: l2-cache {
 				compatible = "cache";
+				cache-level = <2>;
 				next-level-cache = <&L3_0>;
 			};
 		};
diff --git a/arch/arm64/boot/dts/qcom/sm6125.dtsi b/arch/arm64/boot/dts/qcom/sm6125.dtsi
index 8c582a9e4ada..1e68475a4757 100644
--- a/arch/arm64/boot/dts/qcom/sm6125.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm6125.dtsi
@@ -45,6 +45,7 @@ CPU0: cpu@0 {
 			next-level-cache = <&L2_0>;
 			L2_0: l2-cache {
 				compatible = "cache";
+				cache-level = <2>;
 			};
 		};
 
@@ -84,6 +85,7 @@ CPU4: cpu@100 {
 			next-level-cache = <&L2_1>;
 			L2_1: l2-cache {
 				compatible = "cache";
+				cache-level = <2>;
 			};
 		};
 
diff --git a/arch/arm64/boot/dts/qcom/sm6350.dtsi b/arch/arm64/boot/dts/qcom/sm6350.dtsi
index d06aefdf3d9e..3305c00a0a77 100644
--- a/arch/arm64/boot/dts/qcom/sm6350.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm6350.dtsi
@@ -47,9 +47,11 @@ CPU0: cpu@0 {
 			#cooling-cells = <2>;
 			L2_0: l2-cache {
 				compatible = "cache";
+				cache-level = <2>;
 				next-level-cache = <&L3_0>;
 				L3_0: l3-cache {
 					compatible = "cache";
+					cache-level = <3>;
 				};
 			};
 		};
@@ -66,6 +68,7 @@ CPU1: cpu@100 {
 			#cooling-cells = <2>;
 			L2_100: l2-cache {
 				compatible = "cache";
+				cache-level = <2>;
 				next-level-cache = <&L3_0>;
 			};
 		};
@@ -82,6 +85,7 @@ CPU2: cpu@200 {
 			#cooling-cells = <2>;
 			L2_200: l2-cache {
 				compatible = "cache";
+				cache-level = <2>;
 				next-level-cache = <&L3_0>;
 			};
 		};
@@ -98,6 +102,7 @@ CPU3: cpu@300 {
 			#cooling-cells = <2>;
 			L2_300: l2-cache {
 				compatible = "cache";
+				cache-level = <2>;
 				next-level-cache = <&L3_0>;
 			};
 		};
@@ -114,6 +119,7 @@ CPU4: cpu@400 {
 			#cooling-cells = <2>;
 			L2_400: l2-cache {
 				compatible = "cache";
+				cache-level = <2>;
 				next-level-cache = <&L3_0>;
 			};
 		};
@@ -130,6 +136,7 @@ CPU5: cpu@500 {
 			#cooling-cells = <2>;
 			L2_500: l2-cache {
 				compatible = "cache";
+				cache-level = <2>;
 				next-level-cache = <&L3_0>;
 			};
 
@@ -147,6 +154,7 @@ CPU6: cpu@600 {
 			#cooling-cells = <2>;
 			L2_600: l2-cache {
 				compatible = "cache";
+				cache-level = <2>;
 				next-level-cache = <&L3_0>;
 			};
 		};
@@ -163,6 +171,7 @@ CPU7: cpu@700 {
 			#cooling-cells = <2>;
 			L2_700: l2-cache {
 				compatible = "cache";
+				cache-level = <2>;
 				next-level-cache = <&L3_0>;
 			};
 		};
diff --git a/arch/arm64/boot/dts/qcom/sm8150.dtsi b/arch/arm64/boot/dts/qcom/sm8150.dtsi
index 7d509ecd44da..0fc083505776 100644
--- a/arch/arm64/boot/dts/qcom/sm8150.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8150.dtsi
@@ -60,9 +60,11 @@ CPU0: cpu@0 {
 			#cooling-cells = <2>;
 			L2_0: l2-cache {
 				compatible = "cache";
+				cache-level = <2>;
 				next-level-cache = <&L3_0>;
 				L3_0: l3-cache {
 				      compatible = "cache";
+				      cache-level = <3>;
 				};
 			};
 		};
@@ -84,6 +86,7 @@ CPU1: cpu@100 {
 			#cooling-cells = <2>;
 			L2_100: l2-cache {
 				compatible = "cache";
+				cache-level = <2>;
 				next-level-cache = <&L3_0>;
 			};
 
@@ -106,6 +109,7 @@ CPU2: cpu@200 {
 			#cooling-cells = <2>;
 			L2_200: l2-cache {
 				compatible = "cache";
+				cache-level = <2>;
 				next-level-cache = <&L3_0>;
 			};
 		};
@@ -127,6 +131,7 @@ CPU3: cpu@300 {
 			#cooling-cells = <2>;
 			L2_300: l2-cache {
 				compatible = "cache";
+				cache-level = <2>;
 				next-level-cache = <&L3_0>;
 			};
 		};
@@ -148,6 +153,7 @@ CPU4: cpu@400 {
 			#cooling-cells = <2>;
 			L2_400: l2-cache {
 				compatible = "cache";
+				cache-level = <2>;
 				next-level-cache = <&L3_0>;
 			};
 		};
@@ -169,6 +175,7 @@ CPU5: cpu@500 {
 			#cooling-cells = <2>;
 			L2_500: l2-cache {
 				compatible = "cache";
+				cache-level = <2>;
 				next-level-cache = <&L3_0>;
 			};
 		};
@@ -190,6 +197,7 @@ CPU6: cpu@600 {
 			#cooling-cells = <2>;
 			L2_600: l2-cache {
 				compatible = "cache";
+				cache-level = <2>;
 				next-level-cache = <&L3_0>;
 			};
 		};
@@ -211,6 +219,7 @@ CPU7: cpu@700 {
 			#cooling-cells = <2>;
 			L2_700: l2-cache {
 				compatible = "cache";
+				cache-level = <2>;
 				next-level-cache = <&L3_0>;
 			};
 		};
diff --git a/arch/arm64/boot/dts/qcom/sm8250.dtsi b/arch/arm64/boot/dts/qcom/sm8250.dtsi
index bc773e210023..65dd382a3c40 100644
--- a/arch/arm64/boot/dts/qcom/sm8250.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8250.dtsi
@@ -110,9 +110,11 @@ CPU0: cpu@0 {
 			#cooling-cells = <2>;
 			L2_0: l2-cache {
 				compatible = "cache";
+				cache-level = <2>;
 				next-level-cache = <&L3_0>;
 				L3_0: l3-cache {
 					compatible = "cache";
+					cache-level = <3>;
 				};
 			};
 		};
@@ -134,6 +136,7 @@ CPU1: cpu@100 {
 			#cooling-cells = <2>;
 			L2_100: l2-cache {
 				compatible = "cache";
+				cache-level = <2>;
 				next-level-cache = <&L3_0>;
 			};
 		};
@@ -155,6 +158,7 @@ CPU2: cpu@200 {
 			#cooling-cells = <2>;
 			L2_200: l2-cache {
 				compatible = "cache";
+				cache-level = <2>;
 				next-level-cache = <&L3_0>;
 			};
 		};
@@ -176,6 +180,7 @@ CPU3: cpu@300 {
 			#cooling-cells = <2>;
 			L2_300: l2-cache {
 				compatible = "cache";
+				cache-level = <2>;
 				next-level-cache = <&L3_0>;
 			};
 		};
@@ -197,6 +202,7 @@ CPU4: cpu@400 {
 			#cooling-cells = <2>;
 			L2_400: l2-cache {
 				compatible = "cache";
+				cache-level = <2>;
 				next-level-cache = <&L3_0>;
 			};
 		};
@@ -218,6 +224,7 @@ CPU5: cpu@500 {
 			#cooling-cells = <2>;
 			L2_500: l2-cache {
 				compatible = "cache";
+				cache-level = <2>;
 				next-level-cache = <&L3_0>;
 			};
 
@@ -240,6 +247,7 @@ CPU6: cpu@600 {
 			#cooling-cells = <2>;
 			L2_600: l2-cache {
 				compatible = "cache";
+				cache-level = <2>;
 				next-level-cache = <&L3_0>;
 			};
 		};
@@ -261,6 +269,7 @@ CPU7: cpu@700 {
 			#cooling-cells = <2>;
 			L2_700: l2-cache {
 				compatible = "cache";
+				cache-level = <2>;
 				next-level-cache = <&L3_0>;
 			};
 		};
diff --git a/arch/arm64/boot/dts/qcom/sm8350.dtsi b/arch/arm64/boot/dts/qcom/sm8350.dtsi
index e72a04411888..ec5bdd25a580 100644
--- a/arch/arm64/boot/dts/qcom/sm8350.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8350.dtsi
@@ -73,9 +73,11 @@ CPU0: cpu@0 {
 			#cooling-cells = <2>;
 			L2_0: l2-cache {
 			      compatible = "cache";
+			      cache-level = <2>;
 			      next-level-cache = <&L3_0>;
 				L3_0: l3-cache {
 				      compatible = "cache";
+				      cache-level = <3>;
 				};
 			};
 		};
@@ -92,6 +94,7 @@ CPU1: cpu@100 {
 			#cooling-cells = <2>;
 			L2_100: l2-cache {
 			      compatible = "cache";
+			      cache-level = <2>;
 			      next-level-cache = <&L3_0>;
 			};
 		};
@@ -108,6 +111,7 @@ CPU2: cpu@200 {
 			#cooling-cells = <2>;
 			L2_200: l2-cache {
 			      compatible = "cache";
+			      cache-level = <2>;
 			      next-level-cache = <&L3_0>;
 			};
 		};
@@ -124,6 +128,7 @@ CPU3: cpu@300 {
 			#cooling-cells = <2>;
 			L2_300: l2-cache {
 			      compatible = "cache";
+			      cache-level = <2>;
 			      next-level-cache = <&L3_0>;
 			};
 		};
@@ -140,6 +145,7 @@ CPU4: cpu@400 {
 			#cooling-cells = <2>;
 			L2_400: l2-cache {
 			      compatible = "cache";
+			      cache-level = <2>;
 			      next-level-cache = <&L3_0>;
 			};
 		};
@@ -156,6 +162,7 @@ CPU5: cpu@500 {
 			#cooling-cells = <2>;
 			L2_500: l2-cache {
 			      compatible = "cache";
+			      cache-level = <2>;
 			      next-level-cache = <&L3_0>;
 			};
 
@@ -173,6 +180,7 @@ CPU6: cpu@600 {
 			#cooling-cells = <2>;
 			L2_600: l2-cache {
 			      compatible = "cache";
+			      cache-level = <2>;
 			      next-level-cache = <&L3_0>;
 			};
 		};
@@ -189,6 +197,7 @@ CPU7: cpu@700 {
 			#cooling-cells = <2>;
 			L2_700: l2-cache {
 			      compatible = "cache";
+			      cache-level = <2>;
 			      next-level-cache = <&L3_0>;
 			};
 		};
diff --git a/arch/arm64/boot/dts/qcom/sm8450.dtsi b/arch/arm64/boot/dts/qcom/sm8450.dtsi
index 4978c5ba5dd0..038e1a53f209 100644
--- a/arch/arm64/boot/dts/qcom/sm8450.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8450.dtsi
@@ -53,9 +53,11 @@ CPU0: cpu@0 {
 			#cooling-cells = <2>;
 			L2_0: l2-cache {
 			      compatible = "cache";
+			      cache-level = <2>;
 			      next-level-cache = <&L3_0>;
 				L3_0: l3-cache {
 				      compatible = "cache";
+				      cache-level = <3>;
 				};
 			};
 		};
@@ -72,6 +74,7 @@ CPU1: cpu@100 {
 			#cooling-cells = <2>;
 			L2_100: l2-cache {
 			      compatible = "cache";
+			      cache-level = <2>;
 			      next-level-cache = <&L3_0>;
 			};
 		};
@@ -88,6 +91,7 @@ CPU2: cpu@200 {
 			#cooling-cells = <2>;
 			L2_200: l2-cache {
 			      compatible = "cache";
+			      cache-level = <2>;
 			      next-level-cache = <&L3_0>;
 			};
 		};
@@ -104,6 +108,7 @@ CPU3: cpu@300 {
 			#cooling-cells = <2>;
 			L2_300: l2-cache {
 			      compatible = "cache";
+			      cache-level = <2>;
 			      next-level-cache = <&L3_0>;
 			};
 		};
@@ -120,6 +125,7 @@ CPU4: cpu@400 {
 			#cooling-cells = <2>;
 			L2_400: l2-cache {
 			      compatible = "cache";
+			      cache-level = <2>;
 			      next-level-cache = <&L3_0>;
 			};
 		};
@@ -136,6 +142,7 @@ CPU5: cpu@500 {
 			#cooling-cells = <2>;
 			L2_500: l2-cache {
 			      compatible = "cache";
+			      cache-level = <2>;
 			      next-level-cache = <&L3_0>;
 			};
 
@@ -153,6 +160,7 @@ CPU6: cpu@600 {
 			#cooling-cells = <2>;
 			L2_600: l2-cache {
 			      compatible = "cache";
+			      cache-level = <2>;
 			      next-level-cache = <&L3_0>;
 			};
 		};
@@ -169,6 +177,7 @@ CPU7: cpu@700 {
 			#cooling-cells = <2>;
 			L2_700: l2-cache {
 			      compatible = "cache";
+			      cache-level = <2>;
 			      next-level-cache = <&L3_0>;
 			};
 		};
-- 
2.25.1

