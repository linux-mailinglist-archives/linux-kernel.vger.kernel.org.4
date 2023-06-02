Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DE7671FA04
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 08:21:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233803AbjFBGUc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 02:20:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233679AbjFBGU2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 02:20:28 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90D6F13E
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 23:20:25 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-3f6d7abe9a4so16044975e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 01 Jun 2023 23:20:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685686824; x=1688278824;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NdX8p/1XtE1nNIAntYrNLxuKcQs6UetH0iBitbHVzhU=;
        b=Lv0c957O6ldAS4DvVPNfIZZ6jY1YPQ3gf4q0Arrc8rorMBtkXpLx2SRTOrCUelLipx
         B++tQf40Dzl7vIeXpe+O5loh36OFXvSWSr4Fvq2MdNUuZlYkTivsFQzaWLgH7g73EQAI
         74DdNGx/3DJG7MOQT8ajD82Hnb7wzBqn8hRZxcZBc8/N+oEX3eCPztD1Hs3GZnYTY9LK
         BwfHthJ7X9gmoYiEoINFtwCa3s4afYrubVmuSP0vQjMBtR08WW3vdVNG9cnKt1vMmv3x
         6kDHFfpg7xdu4nYt2Eg0R1UhfdcU5R8BA1STT31xwWE4aR1X4MrZEknVCNgb+0U4rpNX
         66jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685686824; x=1688278824;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NdX8p/1XtE1nNIAntYrNLxuKcQs6UetH0iBitbHVzhU=;
        b=QTSo5rbIAXRRN4pWXeLAtp9fV2Y7vQNYYIIm1hn8ahfJakbLlganOhHonTxwsXqxBv
         0IQg3E7yzaYjLvp4qyoOFpRgzMUKNF+HOk1rwdS9bDd0/wC7tRBm1PtH9tuYN+8fHzUh
         Jkost/X4q9bRhf+Bgv1ijkuhWT9CZMTavoOICcKr55xBgvZCs3VPdg8fBQlBRlK6Tord
         GGu1i73Or5FTR8TRSKu/8Pfko8NLjhbT/vM0oSfBgW9fZIWSgeHbcMVR8OMYQ2jzzoXv
         tcunP9A1u8ansHBq6YQQYVM5Lgxhh8PruPDPwWzjdsdlF6iO+crP+p9wU+0RfiFIQLye
         1vfQ==
X-Gm-Message-State: AC+VfDxQmQ7zKGQs/9ogwagUaxvDKvNUwzap9O3eI2AJUyjK2Xp7ROZB
        0nTVt7/SGVoKNDDsgfzaFlLtSMIWewajsWgcuj8=
X-Google-Smtp-Source: ACHHUZ7wubS+z3hticHRRCk911XfHKR7MjkuX6BEjA/+8KHSGq6DIVlk45OrD3ZesYeG+kwriVdwOw==
X-Received: by 2002:a1c:7404:0:b0:3f5:d313:db68 with SMTP id p4-20020a1c7404000000b003f5d313db68mr988006wmc.5.1685686823915;
        Thu, 01 Jun 2023 23:20:23 -0700 (PDT)
Received: from hackbox.lan ([86.121.163.20])
        by smtp.gmail.com with ESMTPSA id 23-20020a05600c229700b003f42894ebe2sm4388213wmf.23.2023.06.01.23.20.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jun 2023 23:20:23 -0700 (PDT)
From:   Abel Vesa <abel.vesa@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 1/6] arm64: dts: qcom: sm8150: Use 2 interconnect cells
Date:   Fri,  2 Jun 2023 09:20:11 +0300
Message-Id: <20230602062016.1883171-1-abel.vesa@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
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

 arch/arm64/boot/dts/qcom/sm8150.dtsi | 60 ++++++++++++++--------------
 1 file changed, 30 insertions(+), 30 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8150.dtsi b/arch/arm64/boot/dts/qcom/sm8150.dtsi
index 197c016aaeba..50a21062ea24 100644
--- a/arch/arm64/boot/dts/qcom/sm8150.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8150.dtsi
@@ -55,8 +55,8 @@ CPU0: cpu@0 {
 			next-level-cache = <&L2_0>;
 			qcom,freq-domain = <&cpufreq_hw 0>;
 			operating-points-v2 = <&cpu0_opp_table>;
-			interconnects = <&gem_noc MASTER_AMPSS_M0 &mc_virt SLAVE_EBI_CH0>,
-					<&osm_l3 MASTER_OSM_L3_APPS &osm_l3 SLAVE_OSM_L3>;
+			interconnects = <&gem_noc MASTER_AMPSS_M0 0 &mc_virt SLAVE_EBI_CH0 0>,
+					<&osm_l3 MASTER_OSM_L3_APPS 0 &osm_l3 SLAVE_OSM_L3 0>;
 			power-domains = <&CPU_PD0>;
 			power-domain-names = "psci";
 			#cooling-cells = <2>;
@@ -84,8 +84,8 @@ CPU1: cpu@100 {
 			next-level-cache = <&L2_100>;
 			qcom,freq-domain = <&cpufreq_hw 0>;
 			operating-points-v2 = <&cpu0_opp_table>;
-			interconnects = <&gem_noc MASTER_AMPSS_M0 &mc_virt SLAVE_EBI_CH0>,
-					<&osm_l3 MASTER_OSM_L3_APPS &osm_l3 SLAVE_OSM_L3>;
+			interconnects = <&gem_noc MASTER_AMPSS_M0 0 &mc_virt SLAVE_EBI_CH0 0>,
+					<&osm_l3 MASTER_OSM_L3_APPS 0 &osm_l3 SLAVE_OSM_L3 0>;
 			power-domains = <&CPU_PD1>;
 			power-domain-names = "psci";
 			#cooling-cells = <2>;
@@ -108,8 +108,8 @@ CPU2: cpu@200 {
 			next-level-cache = <&L2_200>;
 			qcom,freq-domain = <&cpufreq_hw 0>;
 			operating-points-v2 = <&cpu0_opp_table>;
-			interconnects = <&gem_noc MASTER_AMPSS_M0 &mc_virt SLAVE_EBI_CH0>,
-					<&osm_l3 MASTER_OSM_L3_APPS &osm_l3 SLAVE_OSM_L3>;
+			interconnects = <&gem_noc MASTER_AMPSS_M0 0 &mc_virt SLAVE_EBI_CH0 0>,
+					<&osm_l3 MASTER_OSM_L3_APPS 0 &osm_l3 SLAVE_OSM_L3 0>;
 			power-domains = <&CPU_PD2>;
 			power-domain-names = "psci";
 			#cooling-cells = <2>;
@@ -132,8 +132,8 @@ CPU3: cpu@300 {
 			next-level-cache = <&L2_300>;
 			qcom,freq-domain = <&cpufreq_hw 0>;
 			operating-points-v2 = <&cpu0_opp_table>;
-			interconnects = <&gem_noc MASTER_AMPSS_M0 &mc_virt SLAVE_EBI_CH0>,
-					<&osm_l3 MASTER_OSM_L3_APPS &osm_l3 SLAVE_OSM_L3>;
+			interconnects = <&gem_noc MASTER_AMPSS_M0 0 &mc_virt SLAVE_EBI_CH0 0>,
+					<&osm_l3 MASTER_OSM_L3_APPS 0 &osm_l3 SLAVE_OSM_L3 0>;
 			power-domains = <&CPU_PD3>;
 			power-domain-names = "psci";
 			#cooling-cells = <2>;
@@ -156,8 +156,8 @@ CPU4: cpu@400 {
 			next-level-cache = <&L2_400>;
 			qcom,freq-domain = <&cpufreq_hw 1>;
 			operating-points-v2 = <&cpu4_opp_table>;
-			interconnects = <&gem_noc MASTER_AMPSS_M0 &mc_virt SLAVE_EBI_CH0>,
-					<&osm_l3 MASTER_OSM_L3_APPS &osm_l3 SLAVE_OSM_L3>;
+			interconnects = <&gem_noc MASTER_AMPSS_M0 0 &mc_virt SLAVE_EBI_CH0 0>,
+					<&osm_l3 MASTER_OSM_L3_APPS 0 &osm_l3 SLAVE_OSM_L3 0>;
 			power-domains = <&CPU_PD4>;
 			power-domain-names = "psci";
 			#cooling-cells = <2>;
@@ -180,8 +180,8 @@ CPU5: cpu@500 {
 			next-level-cache = <&L2_500>;
 			qcom,freq-domain = <&cpufreq_hw 1>;
 			operating-points-v2 = <&cpu4_opp_table>;
-			interconnects = <&gem_noc MASTER_AMPSS_M0 &mc_virt SLAVE_EBI_CH0>,
-					<&osm_l3 MASTER_OSM_L3_APPS &osm_l3 SLAVE_OSM_L3>;
+			interconnects = <&gem_noc MASTER_AMPSS_M0 0 &mc_virt SLAVE_EBI_CH0 0>,
+					<&osm_l3 MASTER_OSM_L3_APPS 0 &osm_l3 SLAVE_OSM_L3 0>;
 			power-domains = <&CPU_PD5>;
 			power-domain-names = "psci";
 			#cooling-cells = <2>;
@@ -204,8 +204,8 @@ CPU6: cpu@600 {
 			next-level-cache = <&L2_600>;
 			qcom,freq-domain = <&cpufreq_hw 1>;
 			operating-points-v2 = <&cpu4_opp_table>;
-			interconnects = <&gem_noc MASTER_AMPSS_M0 &mc_virt SLAVE_EBI_CH0>,
-					<&osm_l3 MASTER_OSM_L3_APPS &osm_l3 SLAVE_OSM_L3>;
+			interconnects = <&gem_noc MASTER_AMPSS_M0 0 &mc_virt SLAVE_EBI_CH0 0>,
+					<&osm_l3 MASTER_OSM_L3_APPS 0 &osm_l3 SLAVE_OSM_L3 0>;
 			power-domains = <&CPU_PD6>;
 			power-domain-names = "psci";
 			#cooling-cells = <2>;
@@ -228,8 +228,8 @@ CPU7: cpu@700 {
 			next-level-cache = <&L2_700>;
 			qcom,freq-domain = <&cpufreq_hw 2>;
 			operating-points-v2 = <&cpu7_opp_table>;
-			interconnects = <&gem_noc MASTER_AMPSS_M0 &mc_virt SLAVE_EBI_CH0>,
-					<&osm_l3 MASTER_OSM_L3_APPS &osm_l3 SLAVE_OSM_L3>;
+			interconnects = <&gem_noc MASTER_AMPSS_M0 0 &mc_virt SLAVE_EBI_CH0 0>,
+					<&osm_l3 MASTER_OSM_L3_APPS 0 &osm_l3 SLAVE_OSM_L3 0>;
 			power-domains = <&CPU_PD7>;
 			power-domain-names = "psci";
 			#cooling-cells = <2>;
@@ -1760,49 +1760,49 @@ spi15: spi@c94000 {
 		config_noc: interconnect@1500000 {
 			compatible = "qcom,sm8150-config-noc";
 			reg = <0 0x01500000 0 0x7400>;
-			#interconnect-cells = <1>;
+			#interconnect-cells = <2>;
 			qcom,bcm-voters = <&apps_bcm_voter>;
 		};
 
 		system_noc: interconnect@1620000 {
 			compatible = "qcom,sm8150-system-noc";
 			reg = <0 0x01620000 0 0x19400>;
-			#interconnect-cells = <1>;
+			#interconnect-cells = <2>;
 			qcom,bcm-voters = <&apps_bcm_voter>;
 		};
 
 		mc_virt: interconnect@163a000 {
 			compatible = "qcom,sm8150-mc-virt";
 			reg = <0 0x0163a000 0 0x1000>;
-			#interconnect-cells = <1>;
+			#interconnect-cells = <2>;
 			qcom,bcm-voters = <&apps_bcm_voter>;
 		};
 
 		aggre1_noc: interconnect@16e0000 {
 			compatible = "qcom,sm8150-aggre1-noc";
 			reg = <0 0x016e0000 0 0xd080>;
-			#interconnect-cells = <1>;
+			#interconnect-cells = <2>;
 			qcom,bcm-voters = <&apps_bcm_voter>;
 		};
 
 		aggre2_noc: interconnect@1700000 {
 			compatible = "qcom,sm8150-aggre2-noc";
 			reg = <0 0x01700000 0 0x20000>;
-			#interconnect-cells = <1>;
+			#interconnect-cells = <2>;
 			qcom,bcm-voters = <&apps_bcm_voter>;
 		};
 
 		compute_noc: interconnect@1720000 {
 			compatible = "qcom,sm8150-compute-noc";
 			reg = <0 0x01720000 0 0x7000>;
-			#interconnect-cells = <1>;
+			#interconnect-cells = <2>;
 			qcom,bcm-voters = <&apps_bcm_voter>;
 		};
 
 		mmss_noc: interconnect@1740000 {
 			compatible = "qcom,sm8150-mmss-noc";
 			reg = <0 0x01740000 0 0x1c100>;
-			#interconnect-cells = <1>;
+			#interconnect-cells = <2>;
 			qcom,bcm-voters = <&apps_bcm_voter>;
 		};
 
@@ -2120,7 +2120,7 @@ crypto: crypto@1dfa000 {
 				 <&apps_smmu 0x506 0x0011>,
 				 <&apps_smmu 0x508 0x0011>,
 				 <&apps_smmu 0x512 0x0000>;
-			interconnects = <&aggre2_noc MASTER_CRYPTO_CORE_0 &mc_virt SLAVE_EBI_CH0>;
+			interconnects = <&aggre2_noc MASTER_CRYPTO_CORE_0 0 &mc_virt SLAVE_EBI_CH0 0>;
 			interconnect-names = "memory";
 		};
 
@@ -3547,14 +3547,14 @@ opp-202000000 {
 		dc_noc: interconnect@9160000 {
 			compatible = "qcom,sm8150-dc-noc";
 			reg = <0 0x09160000 0 0x3200>;
-			#interconnect-cells = <1>;
+			#interconnect-cells = <2>;
 			qcom,bcm-voters = <&apps_bcm_voter>;
 		};
 
 		gem_noc: interconnect@9680000 {
 			compatible = "qcom,sm8150-gem-noc";
 			reg = <0 0x09680000 0 0x3e200>;
-			#interconnect-cells = <1>;
+			#interconnect-cells = <2>;
 			qcom,bcm-voters = <&apps_bcm_voter>;
 		};
 
@@ -3659,7 +3659,7 @@ usb_2_dwc3: usb@a800000 {
 		camnoc_virt: interconnect@ac00000 {
 			compatible = "qcom,sm8150-camnoc-virt";
 			reg = <0 0x0ac00000 0 0x1000>;
-			#interconnect-cells = <1>;
+			#interconnect-cells = <2>;
 			qcom,bcm-voters = <&apps_bcm_voter>;
 		};
 
@@ -3668,8 +3668,8 @@ mdss: display-subsystem@ae00000 {
 			reg = <0 0x0ae00000 0 0x1000>;
 			reg-names = "mdss";
 
-			interconnects = <&mmss_noc MASTER_MDP_PORT0 &mc_virt SLAVE_EBI_CH0>,
-					<&mmss_noc MASTER_MDP_PORT1 &mc_virt SLAVE_EBI_CH0>;
+			interconnects = <&mmss_noc MASTER_MDP_PORT0 0 &mc_virt SLAVE_EBI_CH0 0>,
+					<&mmss_noc MASTER_MDP_PORT1 0 &mc_virt SLAVE_EBI_CH0 0>;
 			interconnect-names = "mdp0-mem", "mdp1-mem";
 
 			power-domains = <&dispcc MDSS_GDSC>;
@@ -4334,7 +4334,7 @@ osm_l3: interconnect@18321000 {
 			clocks = <&rpmhcc RPMH_CXO_CLK>, <&gcc GPLL0>;
 			clock-names = "xo", "alternate";
 
-			#interconnect-cells = <1>;
+			#interconnect-cells = <2>;
 		};
 
 		cpufreq_hw: cpufreq@18323000 {
-- 
2.34.1

