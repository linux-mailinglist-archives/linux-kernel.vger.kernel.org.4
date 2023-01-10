Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9ECE06647F1
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 18:59:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234339AbjAJR7O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 12:59:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235220AbjAJR5h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 12:57:37 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71D8D564FA
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 09:56:25 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id cf42so19722274lfb.1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 09:56:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mQlkBj2OgdgFkjkLsNi6p0JUYURF58uY6ZkGNBHnNEU=;
        b=XmJfS/GTQ0KhZwEJWjIaBIB6SlTDMGYN2WpDytYrVx3VE4UnN4V2wZHxF1VthRURak
         Q8tCWNDj4Z8mymaqwRo+Dc7yj/ebCK7OZM7TtJs6cYls18EwimzxYAiBD+dOSV3K2g83
         WsMmUOdnaJ0b0MMdeo8ve3I8bMhYThahpuhX5+29aN7UjwlzlK5/Yjg5LvIDCH+Nt01p
         +bYSyoWlmWI/+399IcWk2gKL3Bqg8xtUL/53KUZRANMKClCpoPs8BUYatUd7iM6VhDTJ
         l7nsup58UqcOVX2EKdx7wd5uTFiK63PNSQi5OafK5MvgpBvhQhRYGU3mJlCNP0lWkMUk
         IZ7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mQlkBj2OgdgFkjkLsNi6p0JUYURF58uY6ZkGNBHnNEU=;
        b=ofdruMA9eawPgg/hiBlqi9v4fAsT7E96hlFeQUySE+aO/riTGbXQthCx0T6GPXdVP2
         /46kYKScu5zm+MS4McbtsUGtl1UQ5gSH5pSg0F4MVvP6U33Ptrk4U1ZZwPVkuf6xB6m2
         HJNqc3QqgErkwSUIycaglR7caeJLxeS408VTrNmbV0cICANEt1Sr0kIoo/Hb6G40F27t
         yu3gCQvj7U6IS9dBNnJnuLxseHI9QS/NvvY6UWGto9pq/VJZWIc6Ndsrfh12nHocu/yQ
         ctQOcMTSc6BJ8JYFVbbgL/ryAScCF0p9dOHFUn+nirm3ThkUOwl4wW7gojSUBmsURw/w
         aNfA==
X-Gm-Message-State: AFqh2kqn+gLdILpX0JZphUfxbZUjHHnaiB8vLMVIaNAa00xU3DpdEr57
        XrvGIxqkA0NsLkZSVg3axDTrhw==
X-Google-Smtp-Source: AMrXdXvnVWjFL2YUUGpGod7nra5WZUjqbOI8xNeH/ygIJT2+F6ACQBtIDB9nosw7soQ73txX+dB0Rg==
X-Received: by 2002:a05:6512:3b9:b0:4c8:9b9f:b1f8 with SMTP id v25-20020a05651203b900b004c89b9fb1f8mr16544050lfp.18.1673373384205;
        Tue, 10 Jan 2023 09:56:24 -0800 (PST)
Received: from localhost.localdomain (abxi45.neoplus.adsl.tpnet.pl. [83.9.2.45])
        by smtp.gmail.com with ESMTPSA id x9-20020a0565123f8900b004a1e104b269sm2275056lfa.34.2023.01.10.09.56.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jan 2023 09:56:23 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
To:     linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org, krzysztof.kozlowski@linaro.org
Cc:     marijn.suijten@somainline.org,
        angelogioacchino.delregno@collabora.com,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v8 5/5] arm64: dts: qcom: msm8998: Configure CPRh
Date:   Tue, 10 Jan 2023 18:56:05 +0100
Message-Id: <20230110175605.1240188-6-konrad.dybcio@linaro.org>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230110175605.1240188-1-konrad.dybcio@linaro.org>
References: <20230110175605.1240188-1-konrad.dybcio@linaro.org>
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

From: AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>

Now that the CPR v3/v4/Hardened is ready, enable it on MSM8998.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>
[Konrad: separate from adding cpufreq, sort nodes and use lowercase hex]
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 arch/arm64/boot/dts/qcom/msm8998.dtsi | 325 ++++++++++++++++++++++++++
 1 file changed, 325 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/msm8998.dtsi b/arch/arm64/boot/dts/qcom/msm8998.dtsi
index af29a4bfd109..84f73484441f 100644
--- a/arch/arm64/boot/dts/qcom/msm8998.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8998.dtsi
@@ -139,6 +139,9 @@ CPU0: cpu@0 {
 			capacity-dmips-mhz = <1024>;
 			cpu-idle-states = <&LITTLE_CPU_SLEEP_0 &LITTLE_CPU_SLEEP_1>;
 			next-level-cache = <&L2_0>;
+			operating-points-v2 = <&cpu_gold_opp_table>;
+			power-domains = <&apc_cprh 0>;
+			power-domain-names = "cprh";
 			L2_0: l2-cache {
 				compatible = "cache";
 				cache-level = <2>;
@@ -153,6 +156,9 @@ CPU1: cpu@1 {
 			capacity-dmips-mhz = <1024>;
 			cpu-idle-states = <&LITTLE_CPU_SLEEP_0 &LITTLE_CPU_SLEEP_1>;
 			next-level-cache = <&L2_0>;
+			operating-points-v2 = <&cpu_gold_opp_table>;
+			power-domains = <&apc_cprh 0>;
+			power-domain-names = "cprh";
 		};
 
 		CPU2: cpu@2 {
@@ -163,6 +169,9 @@ CPU2: cpu@2 {
 			capacity-dmips-mhz = <1024>;
 			cpu-idle-states = <&LITTLE_CPU_SLEEP_0 &LITTLE_CPU_SLEEP_1>;
 			next-level-cache = <&L2_0>;
+			operating-points-v2 = <&cpu_gold_opp_table>;
+			power-domains = <&apc_cprh 0>;
+			power-domain-names = "cprh";
 		};
 
 		CPU3: cpu@3 {
@@ -173,6 +182,9 @@ CPU3: cpu@3 {
 			capacity-dmips-mhz = <1024>;
 			cpu-idle-states = <&LITTLE_CPU_SLEEP_0 &LITTLE_CPU_SLEEP_1>;
 			next-level-cache = <&L2_0>;
+			operating-points-v2 = <&cpu_gold_opp_table>;
+			power-domains = <&apc_cprh 0>;
+			power-domain-names = "cprh";
 		};
 
 		CPU4: cpu@100 {
@@ -183,6 +195,9 @@ CPU4: cpu@100 {
 			capacity-dmips-mhz = <1536>;
 			cpu-idle-states = <&BIG_CPU_SLEEP_0 &BIG_CPU_SLEEP_1>;
 			next-level-cache = <&L2_1>;
+			operating-points-v2 = <&cpu_silver_opp_table>;
+			power-domains = <&apc_cprh 1>;
+			power-domain-names = "cprh";
 			L2_1: l2-cache {
 				compatible = "cache";
 				cache-level = <2>;
@@ -197,6 +212,9 @@ CPU5: cpu@101 {
 			capacity-dmips-mhz = <1536>;
 			cpu-idle-states = <&BIG_CPU_SLEEP_0 &BIG_CPU_SLEEP_1>;
 			next-level-cache = <&L2_1>;
+			operating-points-v2 = <&cpu_silver_opp_table>;
+			power-domains = <&apc_cprh 1>;
+			power-domain-names = "cprh";
 		};
 
 		CPU6: cpu@102 {
@@ -207,6 +225,9 @@ CPU6: cpu@102 {
 			capacity-dmips-mhz = <1536>;
 			cpu-idle-states = <&BIG_CPU_SLEEP_0 &BIG_CPU_SLEEP_1>;
 			next-level-cache = <&L2_1>;
+			operating-points-v2 = <&cpu_silver_opp_table>;
+			power-domains = <&apc_cprh 1>;
+			power-domain-names = "cprh";
 		};
 
 		CPU7: cpu@103 {
@@ -217,6 +238,9 @@ CPU7: cpu@103 {
 			capacity-dmips-mhz = <1536>;
 			cpu-idle-states = <&BIG_CPU_SLEEP_0 &BIG_CPU_SLEEP_1>;
 			next-level-cache = <&L2_1>;
+			operating-points-v2 = <&cpu_silver_opp_table>;
+			power-domains = <&apc_cprh 1>;
+			power-domain-names = "cprh";
 		};
 
 		cpu-map {
@@ -310,6 +334,65 @@ scm {
 		};
 	};
 
+	cpu_gold_opp_table: opp-table-gold {
+		compatible = "operating-points-v2";
+		opp-shared;
+
+		opp-2208000000 {
+			opp-hz = /bits/ 64 <2208000000>;
+			required-opps = <&cprh_opp3>;
+		};
+
+		opp-1113600000 {
+			opp-hz = /bits/ 64 <1113600000>;
+			required-opps = <&cprh_opp2>;
+		};
+
+		opp-300000000 {
+			opp-hz = /bits/ 64 <300000000>;
+			required-opps = <&cprh_opp1>;
+		};
+	};
+
+	cpu_silver_opp_table: opp-table-silver {
+		compatible = "operating-points-v2";
+		opp-shared;
+
+		opp-1843200000 {
+			opp-hz = /bits/ 64 <1843200000>;
+			required-opps = <&cprh_opp3>;
+		};
+
+		opp-1094400000 {
+			opp-hz = /bits/ 64 <1094400000>;
+			required-opps = <&cprh_opp2>;
+		};
+
+		opp-300000000 {
+			opp-hz = /bits/ 64 <300000000>;
+			required-opps = <&cprh_opp1>;
+		};
+	};
+
+	cprh_opp_table: opp-table-cprh {
+		compatible = "operating-points-v2-qcom-level";
+
+		cprh_opp1: opp1 {
+			opp-level = <1>;
+			qcom,opp-fuse-level = <1>;
+		};
+
+		cprh_opp2: opp2 {
+			opp-level = <2>;
+			qcom,opp-fuse-level = <2>;
+		};
+
+		cprh_opp3: opp3 {
+			opp-level = <3>;
+			qcom,opp-fuse-level = <2 3>;
+		};
+	};
+
 	psci {
 		compatible = "arm,psci-1.0";
 		method = "smc";
@@ -839,6 +922,174 @@ qfprom: qfprom@784000 {
 			#address-cells = <1>;
 			#size-cells = <1>;
 
+			cpr_efuse_speedbin: speedbin@133 {
+				reg = <0x133 0x8>;
+				bits = <5 3>;
+			};
+
+			cpr_fuse_revision: cpr_fusing_rev@13e {
+				reg = <0x13e 0x1>;
+				bits = <3 3>;
+			};
+
+			/* CPR Ring Oscillator: Power Cluster */
+			cpr_ro_sel3_pwrcl: rosel3_pwrcl@218 {
+				reg = <0x218 0x1>;
+				bits = <0 4>;
+			};
+
+			cpr_ro_sel2_pwrcl: rosel2_pwrcl@218 {
+				reg = <0x218 0x1>;
+				bits = <4 4>;
+			};
+
+			cpr_ro_sel1_pwrcl: rosel1_pwrcl@219 {
+				reg = <0x219 0x1>;
+				bits = <0 4>;
+			};
+
+			cpr_ro_sel0_pwrcl: rosel0_pwrcl@219 {
+				reg = <0x219 0x1>;
+				bits = <4 4>;
+			};
+
+			/* CPR Init Voltage: Power Cluster */
+			cpr_init_voltage3_pwrcl: ivolt3_pwrcl@21a {
+				reg = <0x21a 0x1>;
+				bits = <0 6>;
+			};
+
+			cpr_init_voltage2_pwrcl: ivolt2_pwrcl@21a {
+				reg = <0x21a 0x1>;
+				bits = <6 6>;
+			};
+
+			cpr_init_voltage1_pwrcl: ivolt1_pwrcl@21b {
+				reg = <0x21b 0x1>;
+				bits = <4 6>;
+			};
+
+			cpr_init_voltage0_pwrcl: ivolt0_pwrcl@21c {
+				reg = <0x21c 0x1>;
+				bits = <2 6>;
+			};
+
+			/* CPR Target Quotients: Power Cluster */
+			cpr_quot3_pwrcl: quot3_pwrcl@21d {
+				reg = <0x21d 0x2>;
+				bits = <6 12>;
+			};
+
+			cpr_quot2_pwrcl: quot2_pwrcl@21f {
+				reg = <0x21f 0x2>;
+				bits = <2 11>;
+			};
+
+			cpr_quot1_pwrcl: quot1_pwrcl@220 {
+				reg = <0x220 0x2>;
+				bits = <6 12>;
+			};
+
+			cpr_quot0_pwrcl: quot0_pwrcl@222 {
+				reg = <0x222 0x2>;
+				bits = <2 12>;
+			};
+
+			/* CPR Quotient Offsets: Power Cluster */
+			cpr_quot_offset3_pwrcl: qoff3_pwrcl@226 {
+				reg = <0x226 0x1>;
+				bits = <1 7>;
+			};
+
+			cpr_quot_offset2_pwrcl: qoff2_pwrcl@227 {
+				reg = <0x227 0x1>;
+				bits = <0 7>;
+			};
+
+			cpr_quot_offset1_pwrcl: qoff1_pwrcl@227 {
+				reg = <0x227 0x1>;
+				bits = <7 6>;
+			};
+
+			/* CPR Ring Oscillator: Performance Cluster */
+			cpr_ro_sel3_perfcl: rosel3_perfcl@229 {
+				reg = <0x229 0x1>;
+				bits = <6 4>;
+			};
+
+			cpr_ro_sel2_perfcl: rosel2_perfcl@22a {
+				reg = <0x22a 0x1>;
+				bits = <2 4>;
+			};
+
+			cpr_ro_sel1_perfcl: rosel1_perfcl@22a {
+				reg = <0x22a 0x1>;
+				bits = <6 4>;
+			};
+
+			cpr_ro_sel0_perfcl: rosel0_perfcl@22b {
+				reg = <0x22b 0x1>;
+				bits = <2 4>;
+			};
+
+			/* CPR Init Voltage: Performance Cluster */
+			cpr_init_voltage3_perfcl: ivolt3_perfcl@22b {
+				reg = <0x22b 0x1>;
+				bits = <6 6>;
+			};
+
+			cpr_init_voltage2_perfcl: ivolt2_perfcl@22c {
+				reg = <0x22c 0x1>;
+				bits = <4 6>;
+			};
+
+			cpr_init_voltage1_perfcl: ivolt1_perfcl@22d {
+				reg = <0x22d 0x1>;
+				bits = <2 6>;
+			};
+
+			cpr_init_voltage0_perfcl: ivolt0_perfcl@22e {
+				reg = <0x22e 0x1>;
+				bits = <0 6>;
+			};
+
+			/* CPR Target Quotients: Performance Cluster */
+			cpr_quot3_perfcl: quot3_perfcl@22f {
+				reg = <0x22f 0x2>;
+				bits = <4 11>;
+			};
+
+			cpr_quot2_perfcl: quot2_perfcl@231 {
+				reg = <0x231 0x2>;
+				bits = <0 12>;
+			};
+
+			cpr_quot1_perfcl: quot1_perfcl@232 {
+				reg = <0x232 0x2>;
+				bits = <4 12>;
+			};
+
+			cpr_quot0_perfcl: quot0_perfcl@234 {
+				reg = <0x234 0x2>;
+				bits = <0 12>;
+			};
+
+			/* CPR Quotient Offsets: Performance Cluster */
+			cpr_quot_offset3_perfcl: qoff3_perfcl@237 {
+				reg = <0x237 0x1>;
+				bits = <7 6>;
+			};
+
+			cpr_quot_offset2_perfcl: qoff2_perfcl@238 {
+				reg = <0x238 0x1>;
+				bits = <6 7>;
+			};
+
+			cpr_quot_offset1_perfcl: qoff1_perfcl@239 {
+				reg = <0x239 0x1>;
+				bits = <5 3>;
+			};
+
 			qusb2_hstx_trim: hstx-trim@23a {
 				reg = <0x23a 0x1>;
 				bits = <0 4>;
@@ -2998,6 +3249,80 @@ frame@17928000 {
 			};
 		};
 
+		apc_cprh: power-controller@179c8000 {
+			compatible = "qcom,msm8998-cprh", "qcom,cprh";
+			reg = <0x0179c4000 0x4000>, <0x0179c8000 0x4000>;
+			clocks = <&gcc GCC_HMSS_RBCPR_CLK>;
+			clock-names = "ref";
+			operating-points-v2 = <&cprh_opp_table>;
+			#power-domain-cells = <1>;
+
+			nvmem-cells = <&cpr_efuse_speedbin>,
+				      <&cpr_fuse_revision>,
+				      <&cpr_quot0_pwrcl>,
+				      <&cpr_quot1_pwrcl>,
+				      <&cpr_quot2_pwrcl>,
+				      <&cpr_quot3_pwrcl>,
+				      <&cpr_quot_offset1_pwrcl>,
+				      <&cpr_quot_offset2_pwrcl>,
+				      <&cpr_quot_offset3_pwrcl>,
+				      <&cpr_init_voltage0_pwrcl>,
+				      <&cpr_init_voltage1_pwrcl>,
+				      <&cpr_init_voltage2_pwrcl>,
+				      <&cpr_init_voltage3_pwrcl>,
+				      <&cpr_ro_sel0_pwrcl>,
+				      <&cpr_ro_sel1_pwrcl>,
+				      <&cpr_ro_sel2_pwrcl>,
+				      <&cpr_ro_sel3_pwrcl>,
+				      <&cpr_quot0_perfcl>,
+				      <&cpr_quot1_perfcl>,
+				      <&cpr_quot2_perfcl>,
+				      <&cpr_quot3_perfcl>,
+				      <&cpr_quot_offset1_perfcl>,
+				      <&cpr_quot_offset2_perfcl>,
+				      <&cpr_quot_offset3_perfcl>,
+				      <&cpr_init_voltage0_perfcl>,
+				      <&cpr_init_voltage1_perfcl>,
+				      <&cpr_init_voltage2_perfcl>,
+				      <&cpr_init_voltage3_perfcl>,
+				      <&cpr_ro_sel0_perfcl>,
+				      <&cpr_ro_sel1_perfcl>,
+				      <&cpr_ro_sel2_perfcl>,
+				      <&cpr_ro_sel3_perfcl>;
+			nvmem-cell-names = "cpr_speed_bin",
+					   "cpr_fuse_revision",
+					   "cpr0_quotient1",
+					   "cpr0_quotient2",
+					   "cpr0_quotient3",
+					   "cpr0_quotient4",
+					   "cpr0_quotient_offset2",
+					   "cpr0_quotient_offset3",
+					   "cpr0_quotient_offset4",
+					   "cpr0_init_voltage1",
+					   "cpr0_init_voltage2",
+					   "cpr0_init_voltage3",
+					   "cpr0_init_voltage4",
+					   "cpr0_ring_osc1",
+					   "cpr0_ring_osc2",
+					   "cpr0_ring_osc3",
+					   "cpr0_ring_osc4",
+					   "cpr1_quotient1",
+					   "cpr1_quotient2",
+					   "cpr1_quotient3",
+					   "cpr1_quotient4",
+					   "cpr1_quotient_offset2",
+					   "cpr1_quotient_offset3",
+					   "cpr1_quotient_offset4",
+					   "cpr1_init_voltage1",
+					   "cpr1_init_voltage2",
+					   "cpr1_init_voltage3",
+					   "cpr1_init_voltage4",
+					   "cpr1_ring_osc1",
+					   "cpr1_ring_osc2",
+					   "cpr1_ring_osc3",
+					   "cpr1_ring_osc4";
+		};
+
 		intc: interrupt-controller@17a00000 {
 			compatible = "arm,gic-v3";
 			reg = <0x17a00000 0x10000>,       /* GICD */
-- 
2.39.0

