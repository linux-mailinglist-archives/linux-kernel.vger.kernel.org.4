Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 417BE71F9F9
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 08:21:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233818AbjFBGUj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 02:20:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232558AbjFBGUa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 02:20:30 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC0DB1A1
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 23:20:27 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-3f60e730bf2so16996965e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 01 Jun 2023 23:20:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685686826; x=1688278826;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S23vyLlGFeLhb3KP4r0YPNItKCBQqYIT+QYfxUAegMQ=;
        b=hZiBtmBCz7VhsRYMjFsRBY/ZlGw9mfTL5i+sWmK9SLJATuA4+S4nmk57I+o4P/Mjws
         H0pZ2HM5sBKcObUaPsKlFOEyYoHlH6qiLtYSeeKiXYBkkoyqYRqXpm8VVUURBgmrXW6o
         B3GmiCLf2qqPOS50oBid2xC0Bx5Iey3pKCvrvVaBtKyRF0uWdOYG4OOYgQW8GL4cy+nz
         NqV3q+K7UIe9VxcXqCyavjZMp1Zanw4ZDAsDtPWjwbKREm5tpUhdsQy9BfId2B+v4sMh
         zid6ldm7Fk9T+T8kTgMtrXgwQPjoayGhzZqc6w4Lz+xRONVQcbXg6O8tzw3033OGmiQK
         /vZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685686826; x=1688278826;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S23vyLlGFeLhb3KP4r0YPNItKCBQqYIT+QYfxUAegMQ=;
        b=HvVp1sOJzZSDIiNhZVVGfBwHvD3Txr3rF7pjB7klcxe0YnjGIJ17WGh8bbNmML5Qi7
         XgH0qQnwCinc/cJI3sxA4NoJQVBygp0qnqzrkf5yrnn2kqbglSVLjcG/H4e8nte4RJ5P
         iW//lzQaKJuGgVvoNLQiOs5DJ1fCQPuk9UtEfsu5INC73JEWNd5Z0e5pY7glriBiOy6u
         iYbDZn3cIqrdt80OvW90SF3xph7DZ7lrmZkEnVQwZMdXe/eu/iOIGGwKXd/qpmCdAi1k
         BsbhJ8s0Qsb2f3UgoWMnbHUCtCgr47EQsQI9YEQqplcBWecANZhd/umE/Snda5t11/jj
         htgA==
X-Gm-Message-State: AC+VfDz52xmGwK4jbJT0atpjnog23wrVAgkpkWl08wHXUUgWG7AGqBDx
        fb4IF/rx+wiQDE0h+nbM56Medg==
X-Google-Smtp-Source: ACHHUZ5ux7MxklX9lx0Bs0z3XeOvPtjRGaMHSZJHT9g2O6IcWKf4WcVQc7RvvUop3Fu+jQGXDBWOPg==
X-Received: by 2002:a5d:4487:0:b0:30a:ebe2:5e4f with SMTP id j7-20020a5d4487000000b0030aebe25e4fmr3786973wrq.36.1685686826365;
        Thu, 01 Jun 2023 23:20:26 -0700 (PDT)
Received: from hackbox.lan ([86.121.163.20])
        by smtp.gmail.com with ESMTPSA id 23-20020a05600c229700b003f42894ebe2sm4388213wmf.23.2023.06.01.23.20.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jun 2023 23:20:25 -0700 (PDT)
From:   Abel Vesa <abel.vesa@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 3/6] arm64: dts: qcom: sm8250: Use 2 interconnect cells
Date:   Fri,  2 Jun 2023 09:20:13 +0300
Message-Id: <20230602062016.1883171-3-abel.vesa@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230602062016.1883171-1-abel.vesa@linaro.org>
References: <20230602062016.1883171-1-abel.vesa@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use two interconnect cells in order to optionally support a path tag.

Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---

Changes since v1:
 * This patch was not part of v1

 arch/arm64/boot/dts/qcom/sm8250.dtsi | 72 ++++++++++++++--------------
 1 file changed, 36 insertions(+), 36 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8250.dtsi b/arch/arm64/boot/dts/qcom/sm8250.dtsi
index e5c60a6e4074..c5787489b05c 100644
--- a/arch/arm64/boot/dts/qcom/sm8250.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8250.dtsi
@@ -106,8 +106,8 @@ CPU0: cpu@0 {
 			power-domain-names = "psci";
 			qcom,freq-domain = <&cpufreq_hw 0>;
 			operating-points-v2 = <&cpu0_opp_table>;
-			interconnects = <&gem_noc MASTER_AMPSS_M0 &mc_virt SLAVE_EBI_CH0>,
-					<&epss_l3 MASTER_OSM_L3_APPS &epss_l3 SLAVE_OSM_L3>;
+			interconnects = <&gem_noc MASTER_AMPSS_M0 0 &mc_virt SLAVE_EBI_CH0 0>,
+					<&epss_l3 MASTER_OSM_L3_APPS 0 &epss_l3 SLAVE_OSM_L3 0>;
 			#cooling-cells = <2>;
 			L2_0: l2-cache {
 				compatible = "cache";
@@ -137,8 +137,8 @@ CPU1: cpu@100 {
 			power-domain-names = "psci";
 			qcom,freq-domain = <&cpufreq_hw 0>;
 			operating-points-v2 = <&cpu0_opp_table>;
-			interconnects = <&gem_noc MASTER_AMPSS_M0 &mc_virt SLAVE_EBI_CH0>,
-					<&epss_l3 MASTER_OSM_L3_APPS &epss_l3 SLAVE_OSM_L3>;
+			interconnects = <&gem_noc MASTER_AMPSS_M0 0 &mc_virt SLAVE_EBI_CH0 0>,
+					<&epss_l3 MASTER_OSM_L3_APPS 0 &epss_l3 SLAVE_OSM_L3 0>;
 			#cooling-cells = <2>;
 			L2_100: l2-cache {
 				compatible = "cache";
@@ -162,8 +162,8 @@ CPU2: cpu@200 {
 			power-domain-names = "psci";
 			qcom,freq-domain = <&cpufreq_hw 0>;
 			operating-points-v2 = <&cpu0_opp_table>;
-			interconnects = <&gem_noc MASTER_AMPSS_M0 &mc_virt SLAVE_EBI_CH0>,
-					<&epss_l3 MASTER_OSM_L3_APPS &epss_l3 SLAVE_OSM_L3>;
+			interconnects = <&gem_noc MASTER_AMPSS_M0 0 &mc_virt SLAVE_EBI_CH0 0>,
+					<&epss_l3 MASTER_OSM_L3_APPS 0 &epss_l3 SLAVE_OSM_L3 0>;
 			#cooling-cells = <2>;
 			L2_200: l2-cache {
 				compatible = "cache";
@@ -187,8 +187,8 @@ CPU3: cpu@300 {
 			power-domain-names = "psci";
 			qcom,freq-domain = <&cpufreq_hw 0>;
 			operating-points-v2 = <&cpu0_opp_table>;
-			interconnects = <&gem_noc MASTER_AMPSS_M0 &mc_virt SLAVE_EBI_CH0>,
-					<&epss_l3 MASTER_OSM_L3_APPS &epss_l3 SLAVE_OSM_L3>;
+			interconnects = <&gem_noc MASTER_AMPSS_M0 0 &mc_virt SLAVE_EBI_CH0 0>,
+					<&epss_l3 MASTER_OSM_L3_APPS 0 &epss_l3 SLAVE_OSM_L3 0>;
 			#cooling-cells = <2>;
 			L2_300: l2-cache {
 				compatible = "cache";
@@ -212,8 +212,8 @@ CPU4: cpu@400 {
 			power-domain-names = "psci";
 			qcom,freq-domain = <&cpufreq_hw 1>;
 			operating-points-v2 = <&cpu4_opp_table>;
-			interconnects = <&gem_noc MASTER_AMPSS_M0 &mc_virt SLAVE_EBI_CH0>,
-					<&epss_l3 MASTER_OSM_L3_APPS &epss_l3 SLAVE_OSM_L3>;
+			interconnects = <&gem_noc MASTER_AMPSS_M0 0 &mc_virt SLAVE_EBI_CH0 0>,
+					<&epss_l3 MASTER_OSM_L3_APPS 0 &epss_l3 SLAVE_OSM_L3 0>;
 			#cooling-cells = <2>;
 			L2_400: l2-cache {
 				compatible = "cache";
@@ -237,8 +237,8 @@ CPU5: cpu@500 {
 			power-domain-names = "psci";
 			qcom,freq-domain = <&cpufreq_hw 1>;
 			operating-points-v2 = <&cpu4_opp_table>;
-			interconnects = <&gem_noc MASTER_AMPSS_M0 &mc_virt SLAVE_EBI_CH0>,
-					<&epss_l3 MASTER_OSM_L3_APPS &epss_l3 SLAVE_OSM_L3>;
+			interconnects = <&gem_noc MASTER_AMPSS_M0 0 &mc_virt SLAVE_EBI_CH0 0>,
+					<&epss_l3 MASTER_OSM_L3_APPS 0 &epss_l3 SLAVE_OSM_L3 0>;
 			#cooling-cells = <2>;
 			L2_500: l2-cache {
 				compatible = "cache";
@@ -262,8 +262,8 @@ CPU6: cpu@600 {
 			power-domain-names = "psci";
 			qcom,freq-domain = <&cpufreq_hw 1>;
 			operating-points-v2 = <&cpu4_opp_table>;
-			interconnects = <&gem_noc MASTER_AMPSS_M0 &mc_virt SLAVE_EBI_CH0>,
-					<&epss_l3 MASTER_OSM_L3_APPS &epss_l3 SLAVE_OSM_L3>;
+			interconnects = <&gem_noc MASTER_AMPSS_M0 0 &mc_virt SLAVE_EBI_CH0 0>,
+					<&epss_l3 MASTER_OSM_L3_APPS 0 &epss_l3 SLAVE_OSM_L3 0>;
 			#cooling-cells = <2>;
 			L2_600: l2-cache {
 				compatible = "cache";
@@ -287,8 +287,8 @@ CPU7: cpu@700 {
 			power-domain-names = "psci";
 			qcom,freq-domain = <&cpufreq_hw 2>;
 			operating-points-v2 = <&cpu7_opp_table>;
-			interconnects = <&gem_noc MASTER_AMPSS_M0 &mc_virt SLAVE_EBI_CH0>,
-					<&epss_l3 MASTER_OSM_L3_APPS &epss_l3 SLAVE_OSM_L3>;
+			interconnects = <&gem_noc MASTER_AMPSS_M0 0 &mc_virt SLAVE_EBI_CH0 0>,
+					<&epss_l3 MASTER_OSM_L3_APPS 0 &epss_l3 SLAVE_OSM_L3 0>;
 			#cooling-cells = <2>;
 			L2_700: l2-cache {
 				compatible = "cache";
@@ -1789,49 +1789,49 @@ spi13: spi@a94000 {
 		config_noc: interconnect@1500000 {
 			compatible = "qcom,sm8250-config-noc";
 			reg = <0 0x01500000 0 0xa580>;
-			#interconnect-cells = <1>;
+			#interconnect-cells = <2>;
 			qcom,bcm-voters = <&apps_bcm_voter>;
 		};
 
 		system_noc: interconnect@1620000 {
 			compatible = "qcom,sm8250-system-noc";
 			reg = <0 0x01620000 0 0x1c200>;
-			#interconnect-cells = <1>;
+			#interconnect-cells = <2>;
 			qcom,bcm-voters = <&apps_bcm_voter>;
 		};
 
 		mc_virt: interconnect@163d000 {
 			compatible = "qcom,sm8250-mc-virt";
 			reg = <0 0x0163d000 0 0x1000>;
-			#interconnect-cells = <1>;
+			#interconnect-cells = <2>;
 			qcom,bcm-voters = <&apps_bcm_voter>;
 		};
 
 		aggre1_noc: interconnect@16e0000 {
 			compatible = "qcom,sm8250-aggre1-noc";
 			reg = <0 0x016e0000 0 0x1f180>;
-			#interconnect-cells = <1>;
+			#interconnect-cells = <2>;
 			qcom,bcm-voters = <&apps_bcm_voter>;
 		};
 
 		aggre2_noc: interconnect@1700000 {
 			compatible = "qcom,sm8250-aggre2-noc";
 			reg = <0 0x01700000 0 0x33000>;
-			#interconnect-cells = <1>;
+			#interconnect-cells = <2>;
 			qcom,bcm-voters = <&apps_bcm_voter>;
 		};
 
 		compute_noc: interconnect@1733000 {
 			compatible = "qcom,sm8250-compute-noc";
 			reg = <0 0x01733000 0 0xa180>;
-			#interconnect-cells = <1>;
+			#interconnect-cells = <2>;
 			qcom,bcm-voters = <&apps_bcm_voter>;
 		};
 
 		mmss_noc: interconnect@1740000 {
 			compatible = "qcom,sm8250-mmss-noc";
 			reg = <0 0x01740000 0 0x1f080>;
-			#interconnect-cells = <1>;
+			#interconnect-cells = <2>;
 			qcom,bcm-voters = <&apps_bcm_voter>;
 		};
 
@@ -2260,7 +2260,7 @@ crypto: crypto@1dfa000 {
 				 <&apps_smmu 0x59f 0x0000>,
 				 <&apps_smmu 0x586 0x0011>,
 				 <&apps_smmu 0x596 0x0011>;
-			interconnects = <&aggre2_noc MASTER_CRYPTO_CORE_0 &mc_virt SLAVE_EBI_CH0>;
+			interconnects = <&aggre2_noc MASTER_CRYPTO_CORE_0 0 &mc_virt SLAVE_EBI_CH0 0>;
 			interconnect-names = "memory";
 		};
 
@@ -3693,21 +3693,21 @@ opp-202000000 {
 		dc_noc: interconnect@90c0000 {
 			compatible = "qcom,sm8250-dc-noc";
 			reg = <0 0x090c0000 0 0x4200>;
-			#interconnect-cells = <1>;
+			#interconnect-cells = <2>;
 			qcom,bcm-voters = <&apps_bcm_voter>;
 		};
 
 		gem_noc: interconnect@9100000 {
 			compatible = "qcom,sm8250-gem-noc";
 			reg = <0 0x09100000 0 0xb4000>;
-			#interconnect-cells = <1>;
+			#interconnect-cells = <2>;
 			qcom,bcm-voters = <&apps_bcm_voter>;
 		};
 
 		npu_noc: interconnect@9990000 {
 			compatible = "qcom,sm8250-npu-noc";
 			reg = <0 0x09990000 0 0x1600>;
-			#interconnect-cells = <1>;
+			#interconnect-cells = <2>;
 			qcom,bcm-voters = <&apps_bcm_voter>;
 		};
 
@@ -3837,8 +3837,8 @@ venus: video-codec@aa00000 {
 				 <&videocc VIDEO_CC_MVS0_CLK>;
 			clock-names = "iface", "core", "vcodec0_core";
 
-			interconnects = <&gem_noc MASTER_AMPSS_M0 &config_noc SLAVE_VENUS_CFG>,
-					<&mmss_noc MASTER_VIDEO_P0 &mc_virt SLAVE_EBI_CH0>;
+			interconnects = <&gem_noc MASTER_AMPSS_M0 0 &config_noc SLAVE_VENUS_CFG 0>,
+					<&mmss_noc MASTER_VIDEO_P0 0 &mc_virt SLAVE_EBI_CH0 0>;
 			interconnect-names = "cpu-cfg", "video-mem";
 
 			iommus = <&apps_smmu 0x2100 0x0400>;
@@ -4122,10 +4122,10 @@ camss: camss@ac6a000 {
 				 <&apps_smmu 0xc40 0x400>,
 				 <&apps_smmu 0xc41 0x400>;
 
-			interconnects = <&gem_noc MASTER_AMPSS_M0 &config_noc SLAVE_CAMERA_CFG>,
-					<&mmss_noc MASTER_CAMNOC_HF &mc_virt SLAVE_EBI_CH0>,
-					<&mmss_noc MASTER_CAMNOC_SF &mc_virt SLAVE_EBI_CH0>,
-					<&mmss_noc MASTER_CAMNOC_ICP &mc_virt SLAVE_EBI_CH0>;
+			interconnects = <&gem_noc MASTER_AMPSS_M0 0 &config_noc SLAVE_CAMERA_CFG 0>,
+					<&mmss_noc MASTER_CAMNOC_HF 0 &mc_virt SLAVE_EBI_CH0 0>,
+					<&mmss_noc MASTER_CAMNOC_SF 0 &mc_virt SLAVE_EBI_CH0 0>,
+					<&mmss_noc MASTER_CAMNOC_ICP 0 &mc_virt SLAVE_EBI_CH0 0>;
 			interconnect-names = "cam_ahb",
 					     "cam_hf_0_mnoc",
 					     "cam_sf_0_mnoc",
@@ -4182,8 +4182,8 @@ mdss: display-subsystem@ae00000 {
 			reg = <0 0x0ae00000 0 0x1000>;
 			reg-names = "mdss";
 
-			interconnects = <&mmss_noc MASTER_MDP_PORT0 &mc_virt SLAVE_EBI_CH0>,
-					<&mmss_noc MASTER_MDP_PORT1 &mc_virt SLAVE_EBI_CH0>;
+			interconnects = <&mmss_noc MASTER_MDP_PORT0 0 &mc_virt SLAVE_EBI_CH0 0>,
+					<&mmss_noc MASTER_MDP_PORT1 0 &mc_virt SLAVE_EBI_CH0 0>;
 			interconnect-names = "mdp0-mem", "mdp1-mem";
 
 			power-domains = <&dispcc MDSS_GDSC>;
@@ -5671,7 +5671,7 @@ epss_l3: interconnect@18590000 {
 			clocks = <&rpmhcc RPMH_CXO_CLK>, <&gcc GPLL0>;
 			clock-names = "xo", "alternate";
 
-			#interconnect-cells = <1>;
+			#interconnect-cells = <2>;
 		};
 
 		cpufreq_hw: cpufreq@18591000 {
-- 
2.34.1

