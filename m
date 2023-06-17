Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2783C7343C0
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Jun 2023 22:41:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346550AbjFQUlh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Jun 2023 16:41:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346469AbjFQUl0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Jun 2023 16:41:26 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CAA71700
        for <linux-kernel@vger.kernel.org>; Sat, 17 Jun 2023 13:41:25 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-986d871a9beso223270766b.1
        for <linux-kernel@vger.kernel.org>; Sat, 17 Jun 2023 13:41:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687034484; x=1689626484;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=l4vgBQIdezab+uv8qKX62YxsEkskvdgwPbAcwg7/AX8=;
        b=jh0IDKMzx58PthW4kACF8YpXD+TGBvd3q0tJhF5gO3RvOSgXE7HkDQyyk7ZkRKukff
         DhJKdlQa8CZQRSpxBeZzAOnjNopKoQkzGd4w/PNe6j/v5/I5jknDYrfS7ejMWEAAcYF9
         lMRsquqzDarHg3IMS3wcoJZnulOz8z/7Cwt46TNAZyWMYeFZ62E0WYaVpaYWCi6jUdDj
         JF2/9cT/6bCq4StxUlmrHJPZNMmhbTd97eguN8mdTixTUDT99lP+VYFZW8tt3FX+XnZ9
         GjieT2r+lJPDTEDnfIbXGSKVdqXZoGTSZoe4Yhu4K6FvU2S5ZkBkBsISAGwN0ukywSjF
         qquQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687034484; x=1689626484;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=l4vgBQIdezab+uv8qKX62YxsEkskvdgwPbAcwg7/AX8=;
        b=aThO/cwi6lIgwfL5G8PwJttHCkXv5CyGrZkhTSEgBYvLOFS/nMUasL/ccPMeSN4hfT
         263OsJRDQG6bYH99rOBwoTkK6ryWbQA75Yz/an/WJFJesLciTyL6MfvHTs1E+CoXg2VC
         o1A3MEAxswRMnL8Q+rhF3AYF2v4w2HgIBonoQMabaEXB6xmeWJVpP/CFcwkHI+s9HwRc
         unBlNmOXHb9mAxeyeBFZz4MNYEnFws2NSXlekJk6cMBNnibBLecTOW+yOMSH6VH8USct
         V9TAklei0sr8JotOo0GkFg243SuHkg3R16sQj9c/C1UCPmzhBqSfDllCQBvvRv17Ecxs
         zLTA==
X-Gm-Message-State: AC+VfDyjvsnPrUdb6h98L8UvD3eexT7GTUJdkxEuqb5WSVmF7YDsKArG
        zsnw2OjbP3Fb6of29jXaTEXmMg==
X-Google-Smtp-Source: ACHHUZ4l/VAynlLGat76XroIqRsYR6P0DP3wBd8BenejvZVtmo8JIzHkblXP2J/HbCKAH8jgey7sDQ==
X-Received: by 2002:a17:906:4fd1:b0:973:ff8d:2a46 with SMTP id i17-20020a1709064fd100b00973ff8d2a46mr5776689ejw.3.1687034483837;
        Sat, 17 Jun 2023 13:41:23 -0700 (PDT)
Received: from krzk-bin.. ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id qn18-20020a170907211200b00982c33ea394sm3349203ejb.97.2023.06.17.13.41.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Jun 2023 13:41:23 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Abel Vesa <abel.vesa@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 1/3] arm64: dts: qcom: sm8150: Fix OSM L3 interconnect cells
Date:   Sat, 17 Jun 2023 22:41:16 +0200
Message-Id: <20230617204118.61959-1-krzysztof.kozlowski@linaro.org>
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

Qualcomm Operating State Manager (OSM) L3 Interconnect does not take
path (third) argument.  This was introduced by commit 97c289026c62
("arm64: dts: qcom: sm8150: Use 2 interconnect cells") which probably
wanted to use 2 cells only for RPMh interconnects.

  sm8150-microsoft-surface-duo.dtb: interconnect@18321000: #interconnect-cells:0:0: 1 was expected

Fixes: 97c289026c62 ("arm64: dts: qcom: sm8150: Use 2 interconnect cells")
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8150.dtsi | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8150.dtsi b/arch/arm64/boot/dts/qcom/sm8150.dtsi
index 18c822abdb88..b46e55bb8bde 100644
--- a/arch/arm64/boot/dts/qcom/sm8150.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8150.dtsi
@@ -56,7 +56,7 @@ CPU0: cpu@0 {
 			qcom,freq-domain = <&cpufreq_hw 0>;
 			operating-points-v2 = <&cpu0_opp_table>;
 			interconnects = <&gem_noc MASTER_AMPSS_M0 0 &mc_virt SLAVE_EBI_CH0 0>,
-					<&osm_l3 MASTER_OSM_L3_APPS 0 &osm_l3 SLAVE_OSM_L3 0>;
+					<&osm_l3 MASTER_OSM_L3_APPS &osm_l3 SLAVE_OSM_L3>;
 			power-domains = <&CPU_PD0>;
 			power-domain-names = "psci";
 			#cooling-cells = <2>;
@@ -85,7 +85,7 @@ CPU1: cpu@100 {
 			qcom,freq-domain = <&cpufreq_hw 0>;
 			operating-points-v2 = <&cpu0_opp_table>;
 			interconnects = <&gem_noc MASTER_AMPSS_M0 0 &mc_virt SLAVE_EBI_CH0 0>,
-					<&osm_l3 MASTER_OSM_L3_APPS 0 &osm_l3 SLAVE_OSM_L3 0>;
+					<&osm_l3 MASTER_OSM_L3_APPS &osm_l3 SLAVE_OSM_L3>;
 			power-domains = <&CPU_PD1>;
 			power-domain-names = "psci";
 			#cooling-cells = <2>;
@@ -109,7 +109,7 @@ CPU2: cpu@200 {
 			qcom,freq-domain = <&cpufreq_hw 0>;
 			operating-points-v2 = <&cpu0_opp_table>;
 			interconnects = <&gem_noc MASTER_AMPSS_M0 0 &mc_virt SLAVE_EBI_CH0 0>,
-					<&osm_l3 MASTER_OSM_L3_APPS 0 &osm_l3 SLAVE_OSM_L3 0>;
+					<&osm_l3 MASTER_OSM_L3_APPS &osm_l3 SLAVE_OSM_L3>;
 			power-domains = <&CPU_PD2>;
 			power-domain-names = "psci";
 			#cooling-cells = <2>;
@@ -133,7 +133,7 @@ CPU3: cpu@300 {
 			qcom,freq-domain = <&cpufreq_hw 0>;
 			operating-points-v2 = <&cpu0_opp_table>;
 			interconnects = <&gem_noc MASTER_AMPSS_M0 0 &mc_virt SLAVE_EBI_CH0 0>,
-					<&osm_l3 MASTER_OSM_L3_APPS 0 &osm_l3 SLAVE_OSM_L3 0>;
+					<&osm_l3 MASTER_OSM_L3_APPS &osm_l3 SLAVE_OSM_L3>;
 			power-domains = <&CPU_PD3>;
 			power-domain-names = "psci";
 			#cooling-cells = <2>;
@@ -157,7 +157,7 @@ CPU4: cpu@400 {
 			qcom,freq-domain = <&cpufreq_hw 1>;
 			operating-points-v2 = <&cpu4_opp_table>;
 			interconnects = <&gem_noc MASTER_AMPSS_M0 0 &mc_virt SLAVE_EBI_CH0 0>,
-					<&osm_l3 MASTER_OSM_L3_APPS 0 &osm_l3 SLAVE_OSM_L3 0>;
+					<&osm_l3 MASTER_OSM_L3_APPS &osm_l3 SLAVE_OSM_L3>;
 			power-domains = <&CPU_PD4>;
 			power-domain-names = "psci";
 			#cooling-cells = <2>;
@@ -181,7 +181,7 @@ CPU5: cpu@500 {
 			qcom,freq-domain = <&cpufreq_hw 1>;
 			operating-points-v2 = <&cpu4_opp_table>;
 			interconnects = <&gem_noc MASTER_AMPSS_M0 0 &mc_virt SLAVE_EBI_CH0 0>,
-					<&osm_l3 MASTER_OSM_L3_APPS 0 &osm_l3 SLAVE_OSM_L3 0>;
+					<&osm_l3 MASTER_OSM_L3_APPS &osm_l3 SLAVE_OSM_L3>;
 			power-domains = <&CPU_PD5>;
 			power-domain-names = "psci";
 			#cooling-cells = <2>;
@@ -205,7 +205,7 @@ CPU6: cpu@600 {
 			qcom,freq-domain = <&cpufreq_hw 1>;
 			operating-points-v2 = <&cpu4_opp_table>;
 			interconnects = <&gem_noc MASTER_AMPSS_M0 0 &mc_virt SLAVE_EBI_CH0 0>,
-					<&osm_l3 MASTER_OSM_L3_APPS 0 &osm_l3 SLAVE_OSM_L3 0>;
+					<&osm_l3 MASTER_OSM_L3_APPS &osm_l3 SLAVE_OSM_L3>;
 			power-domains = <&CPU_PD6>;
 			power-domain-names = "psci";
 			#cooling-cells = <2>;
@@ -229,7 +229,7 @@ CPU7: cpu@700 {
 			qcom,freq-domain = <&cpufreq_hw 2>;
 			operating-points-v2 = <&cpu7_opp_table>;
 			interconnects = <&gem_noc MASTER_AMPSS_M0 0 &mc_virt SLAVE_EBI_CH0 0>,
-					<&osm_l3 MASTER_OSM_L3_APPS 0 &osm_l3 SLAVE_OSM_L3 0>;
+					<&osm_l3 MASTER_OSM_L3_APPS &osm_l3 SLAVE_OSM_L3>;
 			power-domains = <&CPU_PD7>;
 			power-domain-names = "psci";
 			#cooling-cells = <2>;
@@ -4342,7 +4342,7 @@ osm_l3: interconnect@18321000 {
 			clocks = <&rpmhcc RPMH_CXO_CLK>, <&gcc GPLL0>;
 			clock-names = "xo", "alternate";
 
-			#interconnect-cells = <2>;
+			#interconnect-cells = <1>;
 		};
 
 		cpufreq_hw: cpufreq@18323000 {
-- 
2.34.1

