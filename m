Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F24586D0A6A
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 17:52:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233405AbjC3PwG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 11:52:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233344AbjC3PwE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 11:52:04 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F475D524
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 08:51:34 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id om3-20020a17090b3a8300b0023efab0e3bfso22397184pjb.3
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 08:51:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680191493;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+UiZ1OnVN4eKK6Y2ubWlnceTNBKlqFHwpFESVYfLs/8=;
        b=S/vO94S1KrhqZU+6ElYPyVmX/X2aqQ0WwjpCi7kD9I/GGADZwABRLXuThUACybh9fW
         Jc8vWoM54trxFU9jTD8vT9qv1/YzIAK+t/+iSWqMHV3VvmbMbsFpPNPkLOWtNmQdr2M+
         NOOglXpvt8QOovjU6tyAronds4rHDHXiVsrcr4pHOxIf4Mkc2kMCPS9E9hbM0FRc8Xap
         OQzVkVSSJebU6P3/ujxSbgclr7egmG7yYKWaU9hkWjPXB+5srf+8/G/mryMBSsZC5uOk
         AkZ+twFDDAEi1OvD7mYJUYLc+FXyT2GV6BPHwciyaDhucZPypkEltVKvz07HzD3Kxq9w
         tEFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680191493;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+UiZ1OnVN4eKK6Y2ubWlnceTNBKlqFHwpFESVYfLs/8=;
        b=bWbVDgWsXMLwRGU5ms7cF7iRnV/R5UyH/oM8mHnjUfKc0G14Hv36pF8TkOJJKYCby2
         KgZrPed1VhQa6Hm0nhN2zu5t5ckocAW3ybJW7dZnXSgfkEHbnO1X3tHEYg5WUbJvv8EH
         9qprb0KP+58NWXhyf7iGWFcE7kLOa0c8n3rLyzbOrH74LwPWDlkeZBYciYklc82277gG
         l7cp1S2zTHMFBhzvNK47VUU6+53cZ9jyZ9nMlZ9yRCkBVWzPjsPJtkYB/uMfd2gGUtQs
         cSFrB6YwW+U9UUjTOM5L5qeXoD5LZB9EFtRBSTTi32rKOuLvYh8Uo0cTxFiLhWC9HCpq
         6Hig==
X-Gm-Message-State: AAQBX9cApDPbO40FymzNRhVUb9NZtRW9GGu+TWHviA0Ng8FEWbMFKFII
        ps5GuOs1hloVJB3653tgGPrWf26TU+YmHxX0hVg=
X-Google-Smtp-Source: AKy350Z/fQwD6SWUO0Js9b6F9iq2N+n6uG5uCtOKnAI5zH9aI+LgGmdPVVeCxTY1fZdDZEXa5GtkUA==
X-Received: by 2002:a17:902:f543:b0:1a1:ce5d:5a15 with SMTP id h3-20020a170902f54300b001a1ce5d5a15mr25852068plf.50.1680191492871;
        Thu, 30 Mar 2023 08:51:32 -0700 (PDT)
Received: from localhost.localdomain ([2401:4900:1c5e:53ce:1f39:30a5:d20f:f205])
        by smtp.gmail.com with ESMTPSA id b2-20020a170902ed0200b0019c8ef78d52sm24799025pld.21.2023.03.30.08.51.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Mar 2023 08:51:32 -0700 (PDT)
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
To:     linux-arm-msm@vger.kernel.org
Cc:     agross@kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, andersson@kernel.org,
        bhupesh.sharma@linaro.org, bhupesh.linux@gmail.com,
        krzysztof.kozlowski@linaro.org, robh+dt@kernel.org,
        konrad.dybcio@linaro.org
Subject: [PATCH v2 1/1] arm64: dts: qcom: sm6115: Add CPU idle-states
Date:   Thu, 30 Mar 2023 21:21:22 +0530
Message-Id: <20230330155122.591099-1-bhupesh.sharma@linaro.org>
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

 arch/arm64/boot/dts/qcom/sm6115.dtsi | 132 +++++++++++++++++++++++++++
 1 file changed, 132 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm6115.dtsi b/arch/arm64/boot/dts/qcom/sm6115.dtsi
index 2a51c938bbcb..c93677e97076 100644
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
@@ -199,6 +277,60 @@ pmu {
 	psci {
 		compatible = "arm,psci-1.0";
 		method = "smc";
+
+		CPU_PD0: power-domain-cpu0 {
+			#power-domain-cells = <0>;
+			power-domains = <&CLUSTER_PD>;
+			domain-idle-states = <&LITTLE_CPU_SLEEP_0>;
+		};
+
+		CPU_PD1: power-domain-cpu1 {
+			#power-domain-cells = <0>;
+			power-domains = <&CLUSTER_PD>;
+			domain-idle-states = <&LITTLE_CPU_SLEEP_0>;
+		};
+
+		CPU_PD2: power-domain-cpu2 {
+			#power-domain-cells = <0>;
+			power-domains = <&CLUSTER_PD>;
+			domain-idle-states = <&LITTLE_CPU_SLEEP_0>;
+		};
+
+		CPU_PD3: power-domain-cpu3 {
+			#power-domain-cells = <0>;
+			power-domains = <&CLUSTER_PD>;
+			domain-idle-states = <&LITTLE_CPU_SLEEP_0>;
+		};
+
+		CPU_PD4: power-domain-cpu4 {
+			#power-domain-cells = <0>;
+			power-domains = <&CLUSTER_PD>;
+			domain-idle-states = <&BIG_CPU_SLEEP_0>;
+		};
+
+		CPU_PD5: power-domain-cpu5 {
+			#power-domain-cells = <0>;
+			power-domains = <&CLUSTER_PD>;
+			domain-idle-states = <&BIG_CPU_SLEEP_0>;
+		};
+
+		CPU_PD6: power-domain-cpu6 {
+			#power-domain-cells = <0>;
+			power-domains = <&CLUSTER_PD>;
+			domain-idle-states = <&BIG_CPU_SLEEP_0>;
+		};
+
+		CPU_PD7: power-domain-cpu7 {
+			#power-domain-cells = <0>;
+			power-domains = <&CLUSTER_PD>;
+			domain-idle-states = <&BIG_CPU_SLEEP_0>;
+		};
+
+		CLUSTER_PD: power-domain-cpu-cluster0 {
+			#power-domain-cells = <0>;
+			domain-idle-states = <&CLUSTER_0_SLEEP_0>, <&CLUSTER_0_SLEEP_1>,
+					     <&CLUSTER_1_SLEEP_0>, <&CLUSTER_1_SLEEP_1>;
+		};
 	};
 
 	reserved_memory: reserved-memory {
-- 
2.38.1

