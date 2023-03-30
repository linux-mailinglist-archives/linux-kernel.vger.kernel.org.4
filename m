Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E1026D0EE8
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 21:33:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232217AbjC3TdQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 15:33:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232216AbjC3TdP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 15:33:15 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08081D31A
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 12:33:13 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id o11so19133792ple.1
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 12:33:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680204792;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=i6JuvYmYJCj0w3cmFeh/1DSQl/9BrhvO1sQcJl2DJ6s=;
        b=rD6xqSmuN7f9T3bBAcfIeecEZ8zbF3WWnbD5MUeXkuHYRZ1Ot/MHFdY0+NMMDnxXVF
         nI7XP3eNwfIgLdGyisNIC84I/8r2vuxUwN13fcAxUTvBKIjCvU+Ozt34RI4ksIYxp/QW
         kcg4EGKgP+Md5xXYasUjAC9BYHjRJPfcGgeqYy5ipvUIG+KquXJg3TND+cm0Ci2WHqrU
         u/XKg+4vUDWVgfstcU2oGNjdFEPhBi0FZ5csQiMmZJSzIUY7cS51NisBo7zOOdDZXu6I
         xG+PgPJeIly6xYLRgab8GK2FaX1LFTrdjcKOJua9hI2B+mvxQbBIbq9WqBSuU7kQYAXY
         r+Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680204792;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=i6JuvYmYJCj0w3cmFeh/1DSQl/9BrhvO1sQcJl2DJ6s=;
        b=co1fM6FFlPC/xSp/yfYmwMD3ef83SQPaDToyW6kjP9EPn2PSmWaIvdBKMgF5LC4SMr
         d4KUAZiBStLduqIKQcQEgqhtvvxwIL5DNo87oClApLyAZpF0105ToCFx32W7pPb10uZg
         ZLPLEYQxiGlvH1TzubnsrPIgGv2t9uS1vEiyh4k+D8Woqs/qqtC0PIwzsB0xRfIlO6K3
         VasvoW7SABCc8Fd6PRtfSaPyU/B1pBXYP4ggQivC3Dve0Ti6T3uAdO+JhTsA3boFBTTm
         wKHxayv8V+BZ2aCJXPTlXa/cRRW/u0AyZUPCJEM9JnFXZXtvtzMN7uisDXIztoH693r9
         ++Pg==
X-Gm-Message-State: AAQBX9fTfuXmwZnJ/Kc0hcJ1hc79MEZWtZFfJ2iJ32zIhKVdAWIJ9kfn
        YOyrOJrpuOUwZ/6s+pDqH5tsRA==
X-Google-Smtp-Source: AKy350bwnzSO1atdK4SjssSFu51Ce4F/E0AWt/J5nDUy29uUaW4L6CMPp5W/74N+w4A8cEqTVe/zlg==
X-Received: by 2002:a17:90b:1c8b:b0:234:d78:9b4c with SMTP id oo11-20020a17090b1c8b00b002340d789b4cmr26470010pjb.18.1680204792371;
        Thu, 30 Mar 2023 12:33:12 -0700 (PDT)
Received: from localhost.localdomain ([2401:4900:1c5e:53ce:1f39:30a5:d20f:f205])
        by smtp.gmail.com with ESMTPSA id g3-20020a170902934300b0019e8c3cd3f4sm84616plp.201.2023.03.30.12.33.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Mar 2023 12:33:12 -0700 (PDT)
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
To:     linux-arm-msm@vger.kernel.org
Cc:     agross@kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, andersson@kernel.org,
        bhupesh.sharma@linaro.org, bhupesh.linux@gmail.com,
        krzysztof.kozlowski@linaro.org, robh+dt@kernel.org,
        konrad.dybcio@linaro.org
Subject: [RESEND PATCH v2 1/1] arm64: dts: qcom: sm6115: Add CPU idle-states
Date:   Fri, 31 Mar 2023 01:03:03 +0530
Message-Id: <20230330193303.612475-1-bhupesh.sharma@linaro.org>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add CPU idle-state nodes and power-domains in Qualcomm sm6115 SoC dtsi.

Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
---
Changes since v1:
- v1 can be viewed here: https://lore.kernel.org/lkml/e5cda4cf-5c2a-a7ed-9e1d-1fe9f2cbef40@linaro.org
- Addressed Konrad's comments on v1 and added GDHS and Power Collapse
  cluster power states.

 arch/arm64/boot/dts/qcom/sm6115.dtsi | 136 +++++++++++++++++++++++++++
 1 file changed, 136 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm6115.dtsi b/arch/arm64/boot/dts/qcom/sm6115.dtsi
index 2a51c938bbcb..b63395d476ed 100644
--- a/arch/arm64/boot/dts/qcom/sm6115.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm6115.dtsi
@@ -45,6 +45,8 @@ CPU0: cpu@0 {
 			enable-method = "psci";
 			next-level-cache = <&L2_0>;
 			qcom,freq-domain = <&cpufreq_hw 0>;
+			power-domains = <&CPU_PD0>;
+			power-domain-names = "psci";
 			L2_0: l2-cache {
 				compatible = "cache";
 				cache-level = <2>;
@@ -61,6 +63,8 @@ CPU1: cpu@1 {
 			enable-method = "psci";
 			next-level-cache = <&L2_0>;
 			qcom,freq-domain = <&cpufreq_hw 0>;
+			power-domains = <&CPU_PD1>;
+			power-domain-names = "psci";
 		};
 
 		CPU2: cpu@2 {
@@ -73,6 +77,8 @@ CPU2: cpu@2 {
 			enable-method = "psci";
 			next-level-cache = <&L2_0>;
 			qcom,freq-domain = <&cpufreq_hw 0>;
+			power-domains = <&CPU_PD2>;
+			power-domain-names = "psci";
 		};
 
 		CPU3: cpu@3 {
@@ -85,6 +91,8 @@ CPU3: cpu@3 {
 			enable-method = "psci";
 			next-level-cache = <&L2_0>;
 			qcom,freq-domain = <&cpufreq_hw 0>;
+			power-domains = <&CPU_PD3>;
+			power-domain-names = "psci";
 		};
 
 		CPU4: cpu@100 {
@@ -97,6 +105,8 @@ CPU4: cpu@100 {
 			dynamic-power-coefficient = <282>;
 			next-level-cache = <&L2_1>;
 			qcom,freq-domain = <&cpufreq_hw 1>;
+			power-domains = <&CPU_PD4>;
+			power-domain-names = "psci";
 			L2_1: l2-cache {
 				compatible = "cache";
 				cache-level = <2>;
@@ -113,6 +123,8 @@ CPU5: cpu@101 {
 			enable-method = "psci";
 			next-level-cache = <&L2_1>;
 			qcom,freq-domain = <&cpufreq_hw 1>;
+			power-domains = <&CPU_PD5>;
+			power-domain-names = "psci";
 		};
 
 		CPU6: cpu@102 {
@@ -125,6 +137,8 @@ CPU6: cpu@102 {
 			enable-method = "psci";
 			next-level-cache = <&L2_1>;
 			qcom,freq-domain = <&cpufreq_hw 1>;
+			power-domains = <&CPU_PD6>;
+			power-domain-names = "psci";
 		};
 
 		CPU7: cpu@103 {
@@ -137,6 +151,8 @@ CPU7: cpu@103 {
 			enable-method = "psci";
 			next-level-cache = <&L2_1>;
 			qcom,freq-domain = <&cpufreq_hw 1>;
+			power-domains = <&CPU_PD7>;
+			power-domain-names = "psci";
 		};
 
 		cpu-map {
@@ -176,6 +192,68 @@ core3 {
 				};
 			};
 		};
+
+		idle-states {
+			entry-method = "psci";
+
+			LITTLE_CPU_SLEEP_0: cpu-sleep-0-0 {
+				compatible = "arm,idle-state";
+				idle-state-name = "silver-rail-power-collapse";
+				arm,psci-suspend-param = <0x40000003>;
+				entry-latency-us = <290>;
+				exit-latency-us = <376>;
+				min-residency-us = <1182>;
+				local-timer-stop;
+			};
+
+			BIG_CPU_SLEEP_0: cpu-sleep-1-0 {
+				compatible = "arm,idle-state";
+				idle-state-name = "gold-rail-power-collapse";
+				arm,psci-suspend-param = <0x40000003>;
+				entry-latency-us = <297>;
+				exit-latency-us = <324>;
+				min-residency-us = <1110>;
+				local-timer-stop;
+			};
+		};
+
+		domain-idle-states {
+			CLUSTER_0_SLEEP_0: cluster-sleep-0-0 {
+				/* GDHS */
+				compatible = "domain-idle-state";
+				arm,psci-suspend-param = <0x40000022>;
+				entry-latency-us = <360>;
+				exit-latency-us = <421>;
+				min-residency-us = <782>;
+			};
+
+			CLUSTER_0_SLEEP_1: cluster-sleep-0-1 {
+				/* Power Collapse */
+				compatible = "domain-idle-state";
+				arm,psci-suspend-param = <0x41000044>;
+				entry-latency-us = <800>;
+				exit-latency-us = <2118>;
+				min-residency-us = <7376>;
+			};
+
+			CLUSTER_1_SLEEP_0: cluster-sleep-1-0 {
+				/* GDHS */
+				compatible = "domain-idle-state";
+				arm,psci-suspend-param = <0x40000042>;
+				entry-latency-us = <314>;
+				exit-latency-us = <345>;
+				min-residency-us = <660>;
+			};
+
+			CLUSTER_1_SLEEP_1: cluster-sleep-1-1 {
+				/* Power Collapse */
+				compatible = "domain-idle-state";
+				arm,psci-suspend-param = <0x41000044>;
+				entry-latency-us = <640>;
+				exit-latency-us = <1654>;
+				min-residency-us = <8094>;
+			};
+		};
 	};
 
 	firmware {
@@ -199,6 +277,64 @@ pmu {
 	psci {
 		compatible = "arm,psci-1.0";
 		method = "smc";
+
+		CPU_PD0: power-domain-cpu0 {
+			#power-domain-cells = <0>;
+			power-domains = <&CLUSTER_0_PD>;
+			domain-idle-states = <&LITTLE_CPU_SLEEP_0>;
+		};
+
+		CPU_PD1: power-domain-cpu1 {
+			#power-domain-cells = <0>;
+			power-domains = <&CLUSTER_0_PD>;
+			domain-idle-states = <&LITTLE_CPU_SLEEP_0>;
+		};
+
+		CPU_PD2: power-domain-cpu2 {
+			#power-domain-cells = <0>;
+			power-domains = <&CLUSTER_0_PD>;
+			domain-idle-states = <&LITTLE_CPU_SLEEP_0>;
+		};
+
+		CPU_PD3: power-domain-cpu3 {
+			#power-domain-cells = <0>;
+			power-domains = <&CLUSTER_0_PD>;
+			domain-idle-states = <&LITTLE_CPU_SLEEP_0>;
+		};
+
+		CPU_PD4: power-domain-cpu4 {
+			#power-domain-cells = <0>;
+			power-domains = <&CLUSTER_1_PD>;
+			domain-idle-states = <&BIG_CPU_SLEEP_0>;
+		};
+
+		CPU_PD5: power-domain-cpu5 {
+			#power-domain-cells = <0>;
+			power-domains = <&CLUSTER_1_PD>;
+			domain-idle-states = <&BIG_CPU_SLEEP_0>;
+		};
+
+		CPU_PD6: power-domain-cpu6 {
+			#power-domain-cells = <0>;
+			power-domains = <&CLUSTER_1_PD>;
+			domain-idle-states = <&BIG_CPU_SLEEP_0>;
+		};
+
+		CPU_PD7: power-domain-cpu7 {
+			#power-domain-cells = <0>;
+			power-domains = <&CLUSTER_1_PD>;
+			domain-idle-states = <&BIG_CPU_SLEEP_0>;
+		};
+
+		CLUSTER_0_PD: power-domain-cpu-cluster0 {
+			#power-domain-cells = <0>;
+			domain-idle-states = <&CLUSTER_0_SLEEP_0>, <&CLUSTER_0_SLEEP_1>;
+		};
+
+		CLUSTER_1_PD: power-domain-cpu-cluster1 {
+			#power-domain-cells = <0>;
+			domain-idle-states = <&CLUSTER_1_SLEEP_0>, <&CLUSTER_1_SLEEP_1>;
+		};
 	};
 
 	reserved_memory: reserved-memory {
-- 
2.38.1

