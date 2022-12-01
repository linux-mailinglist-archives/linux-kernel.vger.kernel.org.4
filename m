Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90E1363F5BF
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 17:54:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229848AbiLAQyu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 11:54:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229696AbiLAQys (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 11:54:48 -0500
Received: from mail.marcansoft.com (marcansoft.com [212.63.210.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF99DA13DB;
        Thu,  1 Dec 2022 08:54:45 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sendonly@marcansoft.com)
        by mail.marcansoft.com (Postfix) with ESMTPSA id A9D2241F98;
        Thu,  1 Dec 2022 16:54:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=marcan.st; s=default;
        t=1669913683; bh=nogEBZiP4Pq9k70q1r1Sq2fpcE7vD0XmA4xsz0zgPB8=;
        h=From:To:Cc:Subject:Date;
        b=m+HqsX80i/hTevzBoiCOp1gnSN6JMGTjAy33KWRmPgUkZtUE4CVEfiL3fZoCXgFwN
         8ovO7Qrf9XfefvDsvhKf39k+GF9xbl+eKQkbXQd0QMRL8bQpgoI7wfc+Qd022HKOCi
         53YAsr3uDXHHGZsd4H0ExEUvyDJcGxGGrZmoA+FfWP5LSZtrvBai/2E9qZgqOA+QdH
         uCt0hIwGZN3IchgomdMasygBVCaG9SW++4Cw+gtbkRwGrJhU/3ppgVkI7NIm5ywBo7
         hA1VI0nLaLEu1r6I2hk7ux7OIrY13q9ng+YjqG5G1Tnm2G9xvlhYilvxyorZsXHVly
         mgjLDH/fS4KYg==
From:   Hector Martin <marcan@marcan.st>
To:     Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>
Cc:     Mark Kettenis <kettenis@openbsd.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, asahi@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Hector Martin <marcan@marcan.st>
Subject: [PATCH] arm64: dts: apple: Add CPU topology & cpufreq nodes for t600x
Date:   Fri,  2 Dec 2022 01:53:45 +0900
Message-Id: <20221201165344.32505-1-marcan@marcan.st>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the missing CPU topology/capacity information and the cpufreq nodes,
so we can have CPU frequency scaling and the scheduler has the
information it needs to make the correct decisions.

As with t8103, boost states are commented out pending PSCI/etc support
for deep sleep states.

Signed-off-by: Hector Martin <marcan@marcan.st>
---
 arch/arm64/boot/dts/apple/t6002.dtsi        |  72 +++++++-
 arch/arm64/boot/dts/apple/t600x-common.dtsi | 186 ++++++++++++++++++++
 arch/arm64/boot/dts/apple/t600x-dieX.dtsi   |  18 ++
 3 files changed, 275 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/apple/t6002.dtsi b/arch/arm64/boot/dts/apple/t6002.dtsi
index 731d61fbb05f..15da2c7eb1fe 100644
--- a/arch/arm64/boot/dts/apple/t6002.dtsi
+++ b/arch/arm64/boot/dts/apple/t6002.dtsi
@@ -23,6 +23,47 @@ / {
 	#size-cells = <2>;
 
 	cpus {
+		cpu-map {
+			cluster3 {
+				core0 {
+					cpu = <&cpu_e10>;
+				};
+				core1 {
+					cpu = <&cpu_e11>;
+				};
+			};
+
+			cluster4 {
+				core0 {
+					cpu = <&cpu_p20>;
+				};
+				core1 {
+					cpu = <&cpu_p21>;
+				};
+				core2 {
+					cpu = <&cpu_p22>;
+				};
+				core3 {
+					cpu = <&cpu_p23>;
+				};
+			};
+
+			cluster5 {
+				core0 {
+					cpu = <&cpu_p30>;
+				};
+				core1 {
+					cpu = <&cpu_p31>;
+				};
+				core2 {
+					cpu = <&cpu_p32>;
+				};
+				core3 {
+					cpu = <&cpu_p33>;
+				};
+			};
+		};
+
 		cpu_e10: cpu@800 {
 			compatible = "apple,icestorm";
 			device_type = "cpu";
@@ -32,6 +73,9 @@ cpu_e10: cpu@800 {
 			next-level-cache = <&l2_cache_3>;
 			i-cache-size = <0x20000>;
 			d-cache-size = <0x10000>;
+			operating-points-v2 = <&icestorm_opp>;
+			capacity-dmips-mhz = <714>;
+			performance-domains = <&cpufreq_e_die1>;
 		};
 
 		cpu_e11: cpu@801 {
@@ -43,6 +87,9 @@ cpu_e11: cpu@801 {
 			next-level-cache = <&l2_cache_3>;
 			i-cache-size = <0x20000>;
 			d-cache-size = <0x10000>;
+			operating-points-v2 = <&icestorm_opp>;
+			capacity-dmips-mhz = <714>;
+			performance-domains = <&cpufreq_e_die1>;
 		};
 
 		cpu_p20: cpu@10900 {
@@ -54,6 +101,9 @@ cpu_p20: cpu@10900 {
 			next-level-cache = <&l2_cache_4>;
 			i-cache-size = <0x30000>;
 			d-cache-size = <0x20000>;
+			operating-points-v2 = <&firestorm_opp>;
+			capacity-dmips-mhz = <1024>;
+			performance-domains = <&cpufreq_p0_die1>;
 		};
 
 		cpu_p21: cpu@10901 {
@@ -65,6 +115,9 @@ cpu_p21: cpu@10901 {
 			next-level-cache = <&l2_cache_4>;
 			i-cache-size = <0x30000>;
 			d-cache-size = <0x20000>;
+			operating-points-v2 = <&firestorm_opp>;
+			capacity-dmips-mhz = <1024>;
+			performance-domains = <&cpufreq_p0_die1>;
 		};
 
 		cpu_p22: cpu@10902 {
@@ -76,6 +129,9 @@ cpu_p22: cpu@10902 {
 			next-level-cache = <&l2_cache_4>;
 			i-cache-size = <0x30000>;
 			d-cache-size = <0x20000>;
+			operating-points-v2 = <&firestorm_opp>;
+			capacity-dmips-mhz = <1024>;
+			performance-domains = <&cpufreq_p0_die1>;
 		};
 
 		cpu_p23: cpu@10903 {
@@ -87,6 +143,9 @@ cpu_p23: cpu@10903 {
 			next-level-cache = <&l2_cache_4>;
 			i-cache-size = <0x30000>;
 			d-cache-size = <0x20000>;
+			operating-points-v2 = <&firestorm_opp>;
+			capacity-dmips-mhz = <1024>;
+			performance-domains = <&cpufreq_p0_die1>;
 		};
 
 		cpu_p30: cpu@10a00 {
@@ -98,6 +157,9 @@ cpu_p30: cpu@10a00 {
 			next-level-cache = <&l2_cache_5>;
 			i-cache-size = <0x30000>;
 			d-cache-size = <0x20000>;
+			operating-points-v2 = <&firestorm_opp>;
+			capacity-dmips-mhz = <1024>;
+			performance-domains = <&cpufreq_p1_die1>;
 		};
 
 		cpu_p31: cpu@10a01 {
@@ -109,6 +171,9 @@ cpu_p31: cpu@10a01 {
 			next-level-cache = <&l2_cache_5>;
 			i-cache-size = <0x30000>;
 			d-cache-size = <0x20000>;
+			operating-points-v2 = <&firestorm_opp>;
+			capacity-dmips-mhz = <1024>;
+			performance-domains = <&cpufreq_p1_die1>;
 		};
 
 		cpu_p32: cpu@10a02 {
@@ -120,6 +185,9 @@ cpu_p32: cpu@10a02 {
 			next-level-cache = <&l2_cache_5>;
 			i-cache-size = <0x30000>;
 			d-cache-size = <0x20000>;
+			operating-points-v2 = <&firestorm_opp>;
+			capacity-dmips-mhz = <1024>;
+			performance-domains = <&cpufreq_p1_die1>;
 		};
 
 		cpu_p33: cpu@10a03 {
@@ -131,6 +199,9 @@ cpu_p33: cpu@10a03 {
 			next-level-cache = <&l2_cache_5>;
 			i-cache-size = <0x30000>;
 			d-cache-size = <0x20000>;
+			operating-points-v2 = <&firestorm_opp>;
+			capacity-dmips-mhz = <1024>;
+			performance-domains = <&cpufreq_p1_die1>;
 		};
 
 		l2_cache_3: l2-cache-3 {
@@ -206,7 +277,6 @@ &die1 {
 #undef DIE
 #undef DIE_NO
 
-
 &aic {
 	affinities {
 		e-core-pmu-affinity {
diff --git a/arch/arm64/boot/dts/apple/t600x-common.dtsi b/arch/arm64/boot/dts/apple/t600x-common.dtsi
index e2568d914719..fa8ead699363 100644
--- a/arch/arm64/boot/dts/apple/t600x-common.dtsi
+++ b/arch/arm64/boot/dts/apple/t600x-common.dtsi
@@ -15,6 +15,47 @@ cpus {
 		#address-cells = <2>;
 		#size-cells = <0>;
 
+		cpu-map {
+			cluster0 {
+				core0 {
+					cpu = <&cpu_e00>;
+				};
+				core1 {
+					cpu = <&cpu_e01>;
+				};
+			};
+
+			cluster1 {
+				core0 {
+					cpu = <&cpu_p00>;
+				};
+				core1 {
+					cpu = <&cpu_p01>;
+				};
+				core2 {
+					cpu = <&cpu_p02>;
+				};
+				core3 {
+					cpu = <&cpu_p03>;
+				};
+			};
+
+			cluster2 {
+				core0 {
+					cpu = <&cpu_p10>;
+				};
+				core1 {
+					cpu = <&cpu_p11>;
+				};
+				core2 {
+					cpu = <&cpu_p12>;
+				};
+				core3 {
+					cpu = <&cpu_p13>;
+				};
+			};
+		};
+
 		cpu_e00: cpu@0 {
 			compatible = "apple,icestorm";
 			device_type = "cpu";
@@ -24,6 +65,9 @@ cpu_e00: cpu@0 {
 			next-level-cache = <&l2_cache_0>;
 			i-cache-size = <0x20000>;
 			d-cache-size = <0x10000>;
+			operating-points-v2 = <&icestorm_opp>;
+			capacity-dmips-mhz = <714>;
+			performance-domains = <&cpufreq_e>;
 		};
 
 		cpu_e01: cpu@1 {
@@ -35,6 +79,9 @@ cpu_e01: cpu@1 {
 			next-level-cache = <&l2_cache_0>;
 			i-cache-size = <0x20000>;
 			d-cache-size = <0x10000>;
+			operating-points-v2 = <&icestorm_opp>;
+			capacity-dmips-mhz = <714>;
+			performance-domains = <&cpufreq_e>;
 		};
 
 		cpu_p00: cpu@10100 {
@@ -46,6 +93,9 @@ cpu_p00: cpu@10100 {
 			next-level-cache = <&l2_cache_1>;
 			i-cache-size = <0x30000>;
 			d-cache-size = <0x20000>;
+			operating-points-v2 = <&firestorm_opp>;
+			capacity-dmips-mhz = <1024>;
+			performance-domains = <&cpufreq_p0>;
 		};
 
 		cpu_p01: cpu@10101 {
@@ -57,6 +107,9 @@ cpu_p01: cpu@10101 {
 			next-level-cache = <&l2_cache_1>;
 			i-cache-size = <0x30000>;
 			d-cache-size = <0x20000>;
+			operating-points-v2 = <&firestorm_opp>;
+			capacity-dmips-mhz = <1024>;
+			performance-domains = <&cpufreq_p0>;
 		};
 
 		cpu_p02: cpu@10102 {
@@ -68,6 +121,9 @@ cpu_p02: cpu@10102 {
 			next-level-cache = <&l2_cache_1>;
 			i-cache-size = <0x30000>;
 			d-cache-size = <0x20000>;
+			operating-points-v2 = <&firestorm_opp>;
+			capacity-dmips-mhz = <1024>;
+			performance-domains = <&cpufreq_p0>;
 		};
 
 		cpu_p03: cpu@10103 {
@@ -79,6 +135,9 @@ cpu_p03: cpu@10103 {
 			next-level-cache = <&l2_cache_1>;
 			i-cache-size = <0x30000>;
 			d-cache-size = <0x20000>;
+			operating-points-v2 = <&firestorm_opp>;
+			capacity-dmips-mhz = <1024>;
+			performance-domains = <&cpufreq_p0>;
 		};
 
 		cpu_p10: cpu@10200 {
@@ -90,6 +149,9 @@ cpu_p10: cpu@10200 {
 			next-level-cache = <&l2_cache_2>;
 			i-cache-size = <0x30000>;
 			d-cache-size = <0x20000>;
+			operating-points-v2 = <&firestorm_opp>;
+			capacity-dmips-mhz = <1024>;
+			performance-domains = <&cpufreq_p1>;
 		};
 
 		cpu_p11: cpu@10201 {
@@ -101,6 +163,9 @@ cpu_p11: cpu@10201 {
 			next-level-cache = <&l2_cache_2>;
 			i-cache-size = <0x30000>;
 			d-cache-size = <0x20000>;
+			operating-points-v2 = <&firestorm_opp>;
+			capacity-dmips-mhz = <1024>;
+			performance-domains = <&cpufreq_p1>;
 		};
 
 		cpu_p12: cpu@10202 {
@@ -112,6 +177,9 @@ cpu_p12: cpu@10202 {
 			next-level-cache = <&l2_cache_2>;
 			i-cache-size = <0x30000>;
 			d-cache-size = <0x20000>;
+			operating-points-v2 = <&firestorm_opp>;
+			capacity-dmips-mhz = <1024>;
+			performance-domains = <&cpufreq_p1>;
 		};
 
 		cpu_p13: cpu@10203 {
@@ -123,6 +191,9 @@ cpu_p13: cpu@10203 {
 			next-level-cache = <&l2_cache_2>;
 			i-cache-size = <0x30000>;
 			d-cache-size = <0x20000>;
+			operating-points-v2 = <&firestorm_opp>;
+			capacity-dmips-mhz = <1024>;
+			performance-domains = <&cpufreq_p1>;
 		};
 
 		l2_cache_0: l2-cache-0 {
@@ -147,6 +218,121 @@ l2_cache_2: l2-cache-2 {
 		};
 	};
 
+	icestorm_opp: opp-table-0 {
+		compatible = "operating-points-v2";
+
+		opp01 {
+			opp-hz = /bits/ 64 <600000000>;
+			opp-level = <1>;
+			clock-latency-ns = <7500>;
+		};
+		opp02 {
+			opp-hz = /bits/ 64 <972000000>;
+			opp-level = <2>;
+			clock-latency-ns = <23000>;
+		};
+		opp03 {
+			opp-hz = /bits/ 64 <1332000000>;
+			opp-level = <3>;
+			clock-latency-ns = <29000>;
+		};
+		opp04 {
+			opp-hz = /bits/ 64 <1704000000>;
+			opp-level = <4>;
+			clock-latency-ns = <40000>;
+		};
+		opp05 {
+			opp-hz = /bits/ 64 <2064000000>;
+			opp-level = <5>;
+			clock-latency-ns = <50000>;
+		};
+	};
+
+	firestorm_opp: opp-table-1 {
+		compatible = "operating-points-v2";
+
+		opp01 {
+			opp-hz = /bits/ 64 <600000000>;
+			opp-level = <1>;
+			clock-latency-ns = <8000>;
+		};
+		opp02 {
+			opp-hz = /bits/ 64 <828000000>;
+			opp-level = <2>;
+			clock-latency-ns = <18000>;
+		};
+		opp03 {
+			opp-hz = /bits/ 64 <1056000000>;
+			opp-level = <3>;
+			clock-latency-ns = <19000>;
+		};
+		opp04 {
+			opp-hz = /bits/ 64 <1296000000>;
+			opp-level = <4>;
+			clock-latency-ns = <23000>;
+		};
+		opp05 {
+			opp-hz = /bits/ 64 <1524000000>;
+			opp-level = <5>;
+			clock-latency-ns = <24000>;
+		};
+		opp06 {
+			opp-hz = /bits/ 64 <1752000000>;
+			opp-level = <6>;
+			clock-latency-ns = <28000>;
+		};
+		opp07 {
+			opp-hz = /bits/ 64 <1980000000>;
+			opp-level = <7>;
+			clock-latency-ns = <31000>;
+		};
+		opp08 {
+			opp-hz = /bits/ 64 <2208000000>;
+			opp-level = <8>;
+			clock-latency-ns = <45000>;
+		};
+		opp09 {
+			opp-hz = /bits/ 64 <2448000000>;
+			opp-level = <9>;
+			clock-latency-ns = <49000>;
+		};
+		opp10 {
+			opp-hz = /bits/ 64 <2676000000>;
+			opp-level = <10>;
+			clock-latency-ns = <53000>;
+		};
+		opp11 {
+			opp-hz = /bits/ 64 <2904000000>;
+			opp-level = <11>;
+			clock-latency-ns = <56000>;
+		};
+		opp12 {
+			opp-hz = /bits/ 64 <3036000000>;
+			opp-level = <12>;
+			clock-latency-ns = <56000>;
+		};
+		/* Not available until CPU deep sleep is implemented
+		opp13 {
+			opp-hz = /bits/ 64 <3132000000>;
+			opp-level = <13>;
+			clock-latency-ns = <56000>;
+			turbo-mode;
+		};
+		opp14 {
+			opp-hz = /bits/ 64 <3168000000>;
+			opp-level = <14>;
+			clock-latency-ns = <56000>;
+			turbo-mode;
+		};
+		opp15 {
+			opp-hz = /bits/ 64 <3228000000>;
+			opp-level = <15>;
+			clock-latency-ns = <56000>;
+			turbo-mode;
+		};
+		*/
+	};
+
 	pmu-e {
 		compatible = "apple,icestorm-pmu";
 		interrupt-parent = <&aic>;
diff --git a/arch/arm64/boot/dts/apple/t600x-dieX.dtsi b/arch/arm64/boot/dts/apple/t600x-dieX.dtsi
index 0a437b68e86c..a32ff0c9d7b0 100644
--- a/arch/arm64/boot/dts/apple/t600x-dieX.dtsi
+++ b/arch/arm64/boot/dts/apple/t600x-dieX.dtsi
@@ -6,6 +6,24 @@
  * Copyright The Asahi Linux Contributors
  */
 
+	DIE_NODE(cpufreq_e): cpufreq@210e20000 {
+		compatible = "apple,t6000-cluster-cpufreq", "apple,t8103-cluster-cpufreq", "apple,cluster-cpufreq";
+		reg = <0x2 0x10e20000 0 0x1000>;
+		#performance-domain-cells = <0>;
+	};
+
+	DIE_NODE(cpufreq_p0): cpufreq@211e20000 {
+		compatible = "apple,t6000-cluster-cpufreq", "apple,t8103-cluster-cpufreq", "apple,cluster-cpufreq";
+		reg = <0x2 0x11e20000 0 0x1000>;
+		#performance-domain-cells = <0>;
+	};
+
+	DIE_NODE(cpufreq_p1): cpufreq@212e20000 {
+		compatible = "apple,t6000-cluster-cpufreq", "apple,t8103-cluster-cpufreq", "apple,cluster-cpufreq";
+		reg = <0x2 0x12e20000 0 0x1000>;
+		#performance-domain-cells = <0>;
+	};
+
 	DIE_NODE(pmgr): power-management@28e080000 {
 		compatible = "apple,t6000-pmgr", "apple,pmgr", "syscon", "simple-mfd";
 		#address-cells = <1>;
-- 
2.35.1

