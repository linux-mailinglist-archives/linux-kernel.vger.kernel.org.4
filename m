Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A648C718162
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 15:22:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236387AbjEaNW5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 09:22:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236374AbjEaNWv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 09:22:51 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C66C5A0
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 06:22:48 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-4f3b39cea1eso6578855e87.3
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 06:22:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685539367; x=1688131367;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nof0fcraUf7ziAMYvboreBBmHnbxyW58ozUlb23q/Is=;
        b=QtNGn/b1WZTG6Icg8tsfvn5PP28xeApGsFniTvTRezvjFcp4V7tcg2dxND3KPbkbN6
         Df76+qebEz6t4lD85BCjj8tfEqoZ2KrhYvoy4eQLRbwzsnV0BJk0JBg9D51DVMzPhXVs
         +UHB63JWhLyfTWW+JioQ00lD8tDNACa3AR1d2NOph2mbIgcJ6rcGWyY0zezfcj3ToQXw
         kE2ugUnqeb2QqfcbETQEdB34NHStmKJQSvsRe7hE5AaYfmsNVDD3ScBGkttjxc8hGUNs
         41pSjULhhbaq/D848Ta11tlNaiWggd1B2VSPRMYu14ANfuGxQ16ysEYaDPqO6URfM+iD
         s5DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685539367; x=1688131367;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nof0fcraUf7ziAMYvboreBBmHnbxyW58ozUlb23q/Is=;
        b=h0Sl+oXiiyqKzFBCMyDlukOeHB8Ng3N1ItMKGxQYLU0lCrDjobX07D1nYMhmN12ZiV
         u/EBWiY7B88+Lf5WfeKeLOiJhvY7nuwY6V6BhhGz5ckwIMJsX1US9NKaFpvMztQkdX4v
         UP0RhC+nGTar2kGcqoGgW9jgsSmt1j3WPw8iWLhOWGMddZGm2I5cshtN8X9GNZdHMDDi
         oCGz6K/0sSsatZo/HPE99yVY+a/w63UGN9OwWPbts3Y0pN5MBbAL9tH8pd4kw7slWkYI
         g7CiG3FjhBLHlqHB5eVRvBInmssBYFzste6pLKPkHlhU61iXVrv1EPlk5ZsitUzIEvG/
         MhhQ==
X-Gm-Message-State: AC+VfDya1bPXBsteSvmWekDBa8UMrO6sJybDrtSfRCzwA61PIhlLErnh
        2JxQrQpPF5SXqTlhbKmT5HVHlg==
X-Google-Smtp-Source: ACHHUZ4M0YRHPLHmVOuOjWHCRHyP3n9BhL+VVdS/h+4Fv13yJnP3jvo+l3OsdJmkNtqjW+AnwlvCeQ==
X-Received: by 2002:ac2:5238:0:b0:4f2:4419:932c with SMTP id i24-20020ac25238000000b004f24419932cmr2539922lfl.23.1685539367031;
        Wed, 31 May 2023 06:22:47 -0700 (PDT)
Received: from [192.168.1.101] (abyj77.neoplus.adsl.tpnet.pl. [83.9.29.77])
        by smtp.gmail.com with ESMTPSA id w8-20020ac24428000000b004eb0c51780bsm720138lfl.29.2023.05.31.06.22.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 May 2023 06:22:46 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Wed, 31 May 2023 15:22:36 +0200
Subject: [PATCH 2/8] arm64: dts: qcom: sm6350: Add PSCI idle states
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230531-topic-rsc-v1-2-b4a985f57b8b@linaro.org>
References: <20230531-topic-rsc-v1-0-b4a985f57b8b@linaro.org>
In-Reply-To: <20230531-topic-rsc-v1-0-b4a985f57b8b@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Melody Olvera <quic_molvera@quicinc.com>,
        Vinod Koul <vkoul@kernel.org>,
        Richard Acayan <mailingradian@gmail.com>,
        Lina Iyer <ilina@codeaurora.org>,
        Douglas Anderson <dianders@chromium.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Abel Vesa <abel.vesa@linaro.org>,
        Sai Prakash Ranjan <quic_saipraka@quicinc.com>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Luca Weiss <luca.weiss@fairphone.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Andy Gross <andy.gross@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1685539362; l=7351;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=qTMZv+oBuQzxfRAczHq2kgWkd1AVOwgX8ifCX4qtLiA=;
 b=9GbD5WdJT72ka28Wq714XVJZ4eaxAjvcCPTiOBSxW1SLvBUyVLxp7YDnaizIBfXzDA6v1dGfp
 XG8VGPt2E/KD/hFwq/TCGeo61bu/yRPK8o2ClNvaO8TUpj2RZhPTy9s
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the PSCI idle states so that the CPU (among other things) can
reach lower power states.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm6350.dtsi | 141 +++++++++++++++++++++++++++++++++++
 1 file changed, 141 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm6350.dtsi b/arch/arm64/boot/dts/qcom/sm6350.dtsi
index 46c29a190f1d..9311bb6bddab 100644
--- a/arch/arm64/boot/dts/qcom/sm6350.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm6350.dtsi
@@ -56,6 +56,8 @@ CPU0: cpu@0 {
 			interconnects = <&gem_noc MASTER_AMPSS_M0 QCOM_ICC_TAG_ACTIVE_ONLY
 					 &clk_virt SLAVE_EBI_CH0 QCOM_ICC_TAG_ACTIVE_ONLY>,
 					<&osm_l3 MASTER_OSM_L3_APPS &osm_l3 SLAVE_OSM_L3>;
+			power-domains = <&CPU_PD0>;
+			power-domain-names = "psci";
 			#cooling-cells = <2>;
 			L2_0: l2-cache {
 				compatible = "cache";
@@ -84,6 +86,8 @@ CPU1: cpu@100 {
 			interconnects = <&gem_noc MASTER_AMPSS_M0 QCOM_ICC_TAG_ACTIVE_ONLY
 					 &clk_virt SLAVE_EBI_CH0 QCOM_ICC_TAG_ACTIVE_ONLY>,
 					<&osm_l3 MASTER_OSM_L3_APPS &osm_l3 SLAVE_OSM_L3>;
+			power-domains = <&CPU_PD1>;
+			power-domain-names = "psci";
 			#cooling-cells = <2>;
 			L2_100: l2-cache {
 				compatible = "cache";
@@ -107,6 +111,8 @@ CPU2: cpu@200 {
 			interconnects = <&gem_noc MASTER_AMPSS_M0 QCOM_ICC_TAG_ACTIVE_ONLY
 					 &clk_virt SLAVE_EBI_CH0 QCOM_ICC_TAG_ACTIVE_ONLY>,
 					<&osm_l3 MASTER_OSM_L3_APPS &osm_l3 SLAVE_OSM_L3>;
+			power-domains = <&CPU_PD2>;
+			power-domain-names = "psci";
 			#cooling-cells = <2>;
 			L2_200: l2-cache {
 				compatible = "cache";
@@ -130,6 +136,8 @@ CPU3: cpu@300 {
 			interconnects = <&gem_noc MASTER_AMPSS_M0 QCOM_ICC_TAG_ACTIVE_ONLY
 					 &clk_virt SLAVE_EBI_CH0 QCOM_ICC_TAG_ACTIVE_ONLY>,
 					<&osm_l3 MASTER_OSM_L3_APPS &osm_l3 SLAVE_OSM_L3>;
+			power-domains = <&CPU_PD3>;
+			power-domain-names = "psci";
 			#cooling-cells = <2>;
 			L2_300: l2-cache {
 				compatible = "cache";
@@ -153,6 +161,8 @@ CPU4: cpu@400 {
 			interconnects = <&gem_noc MASTER_AMPSS_M0 QCOM_ICC_TAG_ACTIVE_ONLY
 					 &clk_virt SLAVE_EBI_CH0 QCOM_ICC_TAG_ACTIVE_ONLY>,
 					<&osm_l3 MASTER_OSM_L3_APPS &osm_l3 SLAVE_OSM_L3>;
+			power-domains = <&CPU_PD4>;
+			power-domain-names = "psci";
 			#cooling-cells = <2>;
 			L2_400: l2-cache {
 				compatible = "cache";
@@ -176,6 +186,8 @@ CPU5: cpu@500 {
 			interconnects = <&gem_noc MASTER_AMPSS_M0 QCOM_ICC_TAG_ACTIVE_ONLY
 					 &clk_virt SLAVE_EBI_CH0 QCOM_ICC_TAG_ACTIVE_ONLY>,
 					<&osm_l3 MASTER_OSM_L3_APPS &osm_l3 SLAVE_OSM_L3>;
+			power-domains = <&CPU_PD5>;
+			power-domain-names = "psci";
 			#cooling-cells = <2>;
 			L2_500: l2-cache {
 				compatible = "cache";
@@ -199,6 +211,8 @@ CPU6: cpu@600 {
 			interconnects = <&gem_noc MASTER_AMPSS_M0 QCOM_ICC_TAG_ACTIVE_ONLY
 					 &clk_virt SLAVE_EBI_CH0 QCOM_ICC_TAG_ACTIVE_ONLY>,
 					<&osm_l3 MASTER_OSM_L3_APPS &osm_l3 SLAVE_OSM_L3>;
+			power-domains = <&CPU_PD6>;
+			power-domain-names = "psci";
 			#cooling-cells = <2>;
 			L2_600: l2-cache {
 				compatible = "cache";
@@ -222,6 +236,8 @@ CPU7: cpu@700 {
 			interconnects = <&gem_noc MASTER_AMPSS_M0 QCOM_ICC_TAG_ACTIVE_ONLY
 					 &clk_virt SLAVE_EBI_CH0 QCOM_ICC_TAG_ACTIVE_ONLY>,
 					<&osm_l3 MASTER_OSM_L3_APPS &osm_l3 SLAVE_OSM_L3>;
+			power-domains = <&CPU_PD7>;
+			power-domain-names = "psci";
 			#cooling-cells = <2>;
 			L2_700: l2-cache {
 				compatible = "cache";
@@ -266,6 +282,76 @@ core7 {
 				};
 			};
 		};
+
+		domain-idle-states {
+			CLUSTER_SLEEP_PC: cluster-sleep-0 {
+				compatible = "domain-idle-state";
+				arm,psci-suspend-param = <0x41000044>;
+				entry-latency-us = <2752>;
+				exit-latency-us = <3048>;
+				min-residency-us = <6118>;
+			};
+
+			CLUSTER_SLEEP_CX_RET: cluster-sleep-1 {
+				compatible = "domain-idle-state";
+				arm,psci-suspend-param = <0x41001244>;
+				entry-latency-us = <3638>;
+				exit-latency-us = <4562>;
+				min-residency-us = <8467>;
+			};
+
+			CLUSTER_AOSS_SLEEP: cluster-sleep-2 {
+				compatible = "domain-idle-state";
+				arm,psci-suspend-param = <0x4100b244>;
+				entry-latency-us = <3263>;
+				exit-latency-us = <6562>;
+				min-residency-us = <9987>;
+			};
+		};
+
+		cpu_idle_states: idle-states {
+			entry-method = "psci";
+
+			LITTLE_CPU_SLEEP_0: cpu-sleep-0-0 {
+				compatible = "arm,idle-state";
+				idle-state-name = "little-power-collapse";
+				arm,psci-suspend-param = <0x40000003>;
+				entry-latency-us = <549>;
+				exit-latency-us = <901>;
+				min-residency-us = <1774>;
+				local-timer-stop;
+			};
+
+			LITTLE_CPU_SLEEP_1: cpu-sleep-0-1 {
+				compatible = "arm,idle-state";
+				idle-state-name = "little-rail-power-collapse";
+				arm,psci-suspend-param = <0x40000004>;
+				entry-latency-us = <702>;
+				exit-latency-us = <915>;
+				min-residency-us = <4001>;
+				local-timer-stop;
+			};
+
+			BIG_CPU_SLEEP_0: cpu-sleep-1-0 {
+				compatible = "arm,idle-state";
+				idle-state-name = "big-power-collapse";
+				arm,psci-suspend-param = <0x40000003>;
+				entry-latency-us = <523>;
+				exit-latency-us = <1244>;
+				min-residency-us = <2207>;
+				local-timer-stop;
+			};
+
+			BIG_CPU_SLEEP_1: cpu-sleep-1-1 {
+				compatible = "arm,idle-state";
+				idle-state-name = "big-rail-power-collapse";
+				arm,psci-suspend-param = <0x40000004>;
+				entry-latency-us = <526>;
+				exit-latency-us = <1854>;
+				min-residency-us = <5555>;
+				local-timer-stop;
+			};
+		};
 	};
 
 	firmware {
@@ -395,6 +481,61 @@ pmu {
 	psci {
 		compatible = "arm,psci-1.0";
 		method = "smc";
+
+		CPU_PD0: power-domain-cpu0 {
+			#power-domain-cells = <0>;
+			power-domains = <&CLUSTER_PD>;
+			domain-idle-states = <&LITTLE_CPU_SLEEP_0 &LITTLE_CPU_SLEEP_1>;
+		};
+
+		CPU_PD1: power-domain-cpu1 {
+			#power-domain-cells = <0>;
+			power-domains = <&CLUSTER_PD>;
+			domain-idle-states = <&LITTLE_CPU_SLEEP_0 &LITTLE_CPU_SLEEP_1>;
+		};
+
+		CPU_PD2: power-domain-cpu2 {
+			#power-domain-cells = <0>;
+			power-domains = <&CLUSTER_PD>;
+			domain-idle-states = <&LITTLE_CPU_SLEEP_0 &LITTLE_CPU_SLEEP_1>;
+		};
+
+		CPU_PD3: power-domain-cpu3 {
+			#power-domain-cells = <0>;
+			power-domains = <&CLUSTER_PD>;
+			domain-idle-states = <&LITTLE_CPU_SLEEP_0 &LITTLE_CPU_SLEEP_1>;
+		};
+
+		CPU_PD4: power-domain-cpu4 {
+			#power-domain-cells = <0>;
+			power-domains = <&CLUSTER_PD>;
+			domain-idle-states = <&LITTLE_CPU_SLEEP_0 &LITTLE_CPU_SLEEP_1>;
+		};
+
+		CPU_PD5: power-domain-cpu5 {
+			#power-domain-cells = <0>;
+			power-domains = <&CLUSTER_PD>;
+			domain-idle-states = <&LITTLE_CPU_SLEEP_0 &LITTLE_CPU_SLEEP_1>;
+		};
+
+		CPU_PD6: power-domain-cpu6 {
+			#power-domain-cells = <0>;
+			power-domains = <&CLUSTER_PD>;
+			domain-idle-states = <&BIG_CPU_SLEEP_0 &BIG_CPU_SLEEP_1>;
+		};
+
+		CPU_PD7: power-domain-cpu7 {
+			#power-domain-cells = <0>;
+			power-domains = <&CLUSTER_PD>;
+			domain-idle-states = <&BIG_CPU_SLEEP_0 &BIG_CPU_SLEEP_1>;
+		};
+
+		CLUSTER_PD: power-domain-cpu-cluster0 {
+			#power-domain-cells = <0>;
+			domain-idle-states = <&CLUSTER_SLEEP_PC
+					      &CLUSTER_SLEEP_CX_RET
+					      &CLUSTER_AOSS_SLEEP>;
+		};
 	};
 
 	reserved_memory: reserved-memory {

-- 
2.40.1

