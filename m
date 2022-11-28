Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE81463AAFD
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 15:30:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232587AbiK1OaU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 09:30:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232565AbiK1O3o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 09:29:44 -0500
Received: from mail.marcansoft.com (marcansoft.com [212.63.210.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76FCA22504;
        Mon, 28 Nov 2022 06:29:42 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sendonly@marcansoft.com)
        by mail.marcansoft.com (Postfix) with ESMTPSA id A852341E2F;
        Mon, 28 Nov 2022 14:29:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=marcan.st; s=default;
        t=1669645781; bh=59CSFOX97npsoJgTAQusPWIZ1PoRhHaim0uMHhjm+K0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=HLu7Zwn9C6DoiPJmcVGLSVIkC2dKmcxpsOjGsN/JLbs/EHno/FqJCKdL7zfFCmGGE
         g1CcfFG4fn9sljNMBuoPsKPMa/4sJlAMShnYp0nGFLxo6dHeImJp+cRTs/3nK+9ZLf
         41qSe0nRUudMYGDO75PWVvZhoiykQJ3d4jkJy9g8bJTPHM+TKRR0eX3qjbI9ZXowHm
         U0WqtpDSBWeGS8xSwELFflDJr4f0JtY7LJXHeemI6kKDqjEEdAfsMWtHjiHRUSMxzC
         NMFyyHDlEsl8V3Mt148jeGggRRKXePqUKEPxEh/3EGdiN+hdHAIrufUnvq+ujMFsnb
         9lsraulqQCrVA==
From:   Hector Martin <marcan@marcan.st>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Hector Martin <marcan@marcan.st>, Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Marc Zyngier <maz@kernel.org>,
        Mark Kettenis <mark.kettenis@xs4all.nl>, asahi@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5 4/4] arm64: dts: apple: Add CPU topology & cpufreq nodes for t8103
Date:   Mon, 28 Nov 2022 23:29:12 +0900
Message-Id: <20221128142912.16022-5-marcan@marcan.st>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221128142912.16022-1-marcan@marcan.st>
References: <20221128142912.16022-1-marcan@marcan.st>
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

Boost states are commented out, as they are not yet available (that
requires CPU deep sleep support, to be eventually done via PSCI).
The driver supports them fine; the hardware will just refuse to ever
go into them at this time, so don't expose them to users until that's
done.

Acked-by: Marc Zyngier <maz@kernel.org>
Signed-off-by: Hector Martin <marcan@marcan.st>
---
 arch/arm64/boot/dts/apple/t8103.dtsi | 204 +++++++++++++++++++++++++--
 1 file changed, 194 insertions(+), 10 deletions(-)

diff --git a/arch/arm64/boot/dts/apple/t8103.dtsi b/arch/arm64/boot/dts/apple/t8103.dtsi
index 51a63b29d404..d56708038d05 100644
--- a/arch/arm64/boot/dts/apple/t8103.dtsi
+++ b/arch/arm64/boot/dts/apple/t8103.dtsi
@@ -22,71 +22,243 @@ cpus {
 		#address-cells = <2>;
 		#size-cells = <0>;
 
-		cpu0: cpu@0 {
+		cpu-map {
+			cluster0 {
+				core0 {
+					cpu = <&cpu_e0>;
+				};
+				core1 {
+					cpu = <&cpu_e1>;
+				};
+				core2 {
+					cpu = <&cpu_e2>;
+				};
+				core3 {
+					cpu = <&cpu_e3>;
+				};
+			};
+
+			cluster1 {
+				core0 {
+					cpu = <&cpu_p0>;
+				};
+				core1 {
+					cpu = <&cpu_p1>;
+				};
+				core2 {
+					cpu = <&cpu_p2>;
+				};
+				core3 {
+					cpu = <&cpu_p3>;
+				};
+			};
+		};
+
+		cpu_e0: cpu@0 {
 			compatible = "apple,icestorm";
 			device_type = "cpu";
 			reg = <0x0 0x0>;
 			enable-method = "spin-table";
 			cpu-release-addr = <0 0>; /* To be filled by loader */
+			operating-points-v2 = <&ecluster_opp>;
+			capacity-dmips-mhz = <714>;
+			performance-domains = <&cpufreq_e>;
 		};
 
-		cpu1: cpu@1 {
+		cpu_e1: cpu@1 {
 			compatible = "apple,icestorm";
 			device_type = "cpu";
 			reg = <0x0 0x1>;
 			enable-method = "spin-table";
 			cpu-release-addr = <0 0>; /* To be filled by loader */
+			operating-points-v2 = <&ecluster_opp>;
+			capacity-dmips-mhz = <714>;
+			performance-domains = <&cpufreq_e>;
 		};
 
-		cpu2: cpu@2 {
+		cpu_e2: cpu@2 {
 			compatible = "apple,icestorm";
 			device_type = "cpu";
 			reg = <0x0 0x2>;
 			enable-method = "spin-table";
 			cpu-release-addr = <0 0>; /* To be filled by loader */
+			operating-points-v2 = <&ecluster_opp>;
+			capacity-dmips-mhz = <714>;
+			performance-domains = <&cpufreq_e>;
 		};
 
-		cpu3: cpu@3 {
+		cpu_e3: cpu@3 {
 			compatible = "apple,icestorm";
 			device_type = "cpu";
 			reg = <0x0 0x3>;
 			enable-method = "spin-table";
 			cpu-release-addr = <0 0>; /* To be filled by loader */
+			operating-points-v2 = <&ecluster_opp>;
+			capacity-dmips-mhz = <714>;
+			performance-domains = <&cpufreq_e>;
 		};
 
-		cpu4: cpu@10100 {
+		cpu_p0: cpu@10100 {
 			compatible = "apple,firestorm";
 			device_type = "cpu";
 			reg = <0x0 0x10100>;
 			enable-method = "spin-table";
 			cpu-release-addr = <0 0>; /* To be filled by loader */
+			operating-points-v2 = <&pcluster_opp>;
+			capacity-dmips-mhz = <1024>;
+			performance-domains = <&cpufreq_p>;
 		};
 
-		cpu5: cpu@10101 {
+		cpu_p1: cpu@10101 {
 			compatible = "apple,firestorm";
 			device_type = "cpu";
 			reg = <0x0 0x10101>;
 			enable-method = "spin-table";
 			cpu-release-addr = <0 0>; /* To be filled by loader */
+			operating-points-v2 = <&pcluster_opp>;
+			capacity-dmips-mhz = <1024>;
+			performance-domains = <&cpufreq_p>;
 		};
 
-		cpu6: cpu@10102 {
+		cpu_p2: cpu@10102 {
 			compatible = "apple,firestorm";
 			device_type = "cpu";
 			reg = <0x0 0x10102>;
 			enable-method = "spin-table";
 			cpu-release-addr = <0 0>; /* To be filled by loader */
+			operating-points-v2 = <&pcluster_opp>;
+			capacity-dmips-mhz = <1024>;
+			performance-domains = <&cpufreq_p>;
 		};
 
-		cpu7: cpu@10103 {
+		cpu_p3: cpu@10103 {
 			compatible = "apple,firestorm";
 			device_type = "cpu";
 			reg = <0x0 0x10103>;
 			enable-method = "spin-table";
 			cpu-release-addr = <0 0>; /* To be filled by loader */
+			operating-points-v2 = <&pcluster_opp>;
+			capacity-dmips-mhz = <1024>;
+			performance-domains = <&cpufreq_p>;
 		};
 	};
 
+	ecluster_opp: opp-table-0 {
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
+			clock-latency-ns = <22000>;
+		};
+		opp03 {
+			opp-hz = /bits/ 64 <1332000000>;
+			opp-level = <3>;
+			clock-latency-ns = <27000>;
+		};
+		opp04 {
+			opp-hz = /bits/ 64 <1704000000>;
+			opp-level = <4>;
+			clock-latency-ns = <33000>;
+		};
+		opp05 {
+			opp-hz = /bits/ 64 <2064000000>;
+			opp-level = <5>;
+			clock-latency-ns = <50000>;
+		};
+	};
+
+	pcluster_opp: opp-table-1 {
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
+			clock-latency-ns = <19000>;
+		};
+		opp03 {
+			opp-hz = /bits/ 64 <1056000000>;
+			opp-level = <3>;
+			clock-latency-ns = <21000>;
+		};
+		opp04 {
+			opp-hz = /bits/ 64 <1284000000>;
+			opp-level = <4>;
+			clock-latency-ns = <23000>;
+		};
+		opp05 {
+			opp-hz = /bits/ 64 <1500000000>;
+			opp-level = <5>;
+			clock-latency-ns = <24000>;
+		};
+		opp06 {
+			opp-hz = /bits/ 64 <1728000000>;
+			opp-level = <6>;
+			clock-latency-ns = <29000>;
+		};
+		opp07 {
+			opp-hz = /bits/ 64 <1956000000>;
+			opp-level = <7>;
+			clock-latency-ns = <31000>;
+		};
+		opp08 {
+			opp-hz = /bits/ 64 <2184000000>;
+			opp-level = <8>;
+			clock-latency-ns = <34000>;
+		};
+		opp09 {
+			opp-hz = /bits/ 64 <2388000000>;
+			opp-level = <9>;
+			clock-latency-ns = <36000>;
+		};
+		opp10 {
+			opp-hz = /bits/ 64 <2592000000>;
+			opp-level = <10>;
+			clock-latency-ns = <51000>;
+		};
+		opp11 {
+			opp-hz = /bits/ 64 <2772000000>;
+			opp-level = <11>;
+			clock-latency-ns = <54000>;
+		};
+		opp12 {
+			opp-hz = /bits/ 64 <2988000000>;
+			opp-level = <12>;
+			clock-latency-ns = <55000>;
+		};
+#if 0
+		/* Not available until CPU deep sleep is implemented */
+		opp13 {
+			opp-hz = /bits/ 64 <3096000000>;
+			opp-level = <13>;
+			clock-latency-ns = <55000>;
+			turbo-mode;
+		};
+		opp14 {
+			opp-hz = /bits/ 64 <3144000000>;
+			opp-level = <14>;
+			clock-latency-ns = <56000>;
+			turbo-mode;
+		};
+		opp15 {
+			opp-hz = /bits/ 64 <3204000000>;
+			opp-level = <15>;
+			clock-latency-ns = <56000>;
+			turbo-mode;
+		};
+#endif
+	};
+
 	timer {
 		compatible = "arm,armv8-timer";
 		interrupt-parent = <&aic>;
@@ -124,6 +296,18 @@ soc {
 		ranges;
 		nonposted-mmio;
 
+		cpufreq_e: performance-controller@210e20000 {
+			compatible = "apple,t8103-cluster-cpufreq", "apple,cluster-cpufreq";
+			reg = <0x2 0x10e20000 0 0x1000>;
+			#performance-domain-cells = <0>;
+		};
+
+		cpufreq_p: performance-controller@211e20000 {
+			compatible = "apple,t8103-cluster-cpufreq", "apple,cluster-cpufreq";
+			reg = <0x2 0x11e20000 0 0x1000>;
+			#performance-domain-cells = <0>;
+		};
+
 		i2c0: i2c@235010000 {
 			compatible = "apple,t8103-i2c", "apple,i2c";
 			reg = <0x2 0x35010000 0x0 0x4000>;
@@ -229,12 +413,12 @@ aic: interrupt-controller@23b100000 {
 			affinities {
 				e-core-pmu-affinity {
 					apple,fiq-index = <AIC_CPU_PMU_E>;
-					cpus = <&cpu0 &cpu1 &cpu2 &cpu3>;
+					cpus = <&cpu_e0 &cpu_e1 &cpu_e2 &cpu_e3>;
 				};
 
 				p-core-pmu-affinity {
 					apple,fiq-index = <AIC_CPU_PMU_P>;
-					cpus = <&cpu4 &cpu5 &cpu6 &cpu7>;
+					cpus = <&cpu_p0 &cpu_p1 &cpu_p2 &cpu_p3>;
 				};
 			};
 		};
-- 
2.35.1

