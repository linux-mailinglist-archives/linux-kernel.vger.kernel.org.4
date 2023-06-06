Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1230E72507F
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 01:04:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240173AbjFFXE2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 19:04:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234392AbjFFXE0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 19:04:26 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B2251725
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 16:04:24 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id 38308e7fff4ca-2b1b6865c7cso57198101fa.3
        for <linux-kernel@vger.kernel.org>; Tue, 06 Jun 2023 16:04:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686092662; x=1688684662;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BX36jW40IzH6+V8/Zm6XQYAycJ9Ld3LGaHQyXOj8PuE=;
        b=oK+V6WlOxYmT5DHf2wZOEmcYGKgLPWugNd8GIMOhUCRcV0BqzRhLrph4+yM2ysgvU+
         g2B1/A5hQonodSDusJByBH4ZAVL+Zz+x3k9+vqZRGskar/Xv4GDIABOYPnAU4V9aCRvB
         Gdsvh5cuw/wY1C5v8VC6Z9Ndby0EwRkdKzXZEjZbLwauh7y8yFU7F62SwMvYpFs2r9MT
         gx/SOc/7+EMIbbxHLBFCbiRa8VsJKB9xxyfrHi8pF+DOsj9WQRTU2i1YS2TFytO4K3IX
         0QUNlBMJ89HTDrZ9jvui4XNyAlXRJNVC1wASYQy4dwmrnjgkWzbiDrAZo0L2zIZEDIMW
         Xz3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686092662; x=1688684662;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BX36jW40IzH6+V8/Zm6XQYAycJ9Ld3LGaHQyXOj8PuE=;
        b=eHG25KoV7V4ktA1ndfq4aP4NBas8Uby0IE5QcptSFg2vYxHQ2J2p7kgLIBAvFnNZWS
         salsoUtpMq/dzcJC4zQ8Twd0dzxlyBJEx0uiPRlQkVUg6TTh3K/AHrHF/gaNbF1uqH8W
         cI1hGbZCHVPbqrAEgCwxsW/5xSeOz/ff3qLAzUEX9CqeD4WUoj1hidVX38qdCfgDXn/J
         7msqxT1PJ8weJxeMftKHgij4Yy9dk6B9nnTukbFILusl+QaarTcglvE0IlffExyl8qmj
         oOk3uR+YFQx/dIECbfRRGdlEzrA4yruPOnLGOEb7EhNVUDhU1z/gLxFRlGxYR4kes2tr
         DdGg==
X-Gm-Message-State: AC+VfDxaGsS2qafIu8YafS3fa+oVCV4qZSNz6zB5J1yCfHCbi4FOnZp5
        +09ZjthkzIJm3uQ1fYxfMSNxydcKFTq1zdBFe+g=
X-Google-Smtp-Source: ACHHUZ6EQzwHC/KXZudfaahcH/egh5V/t9i5eUSngtXc5jrH4LhhjUNaackdLPt9PSRjU6x/gQXVRQ==
X-Received: by 2002:a2e:818f:0:b0:2ac:6858:45ba with SMTP id e15-20020a2e818f000000b002ac685845bamr1543688ljg.48.1686092662529;
        Tue, 06 Jun 2023 16:04:22 -0700 (PDT)
Received: from [192.168.1.101] (abyl150.neoplus.adsl.tpnet.pl. [83.9.31.150])
        by smtp.gmail.com with ESMTPSA id e25-20020a2e8199000000b002adbf24212esm2052384ljg.49.2023.06.06.16.04.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jun 2023 16:04:22 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Wed, 07 Jun 2023 01:04:19 +0200
Subject: [PATCH v2] arm64: dts: qcom: qcm2290: Add CPU idle states
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230606-topic-qcm2290_idlestates-v2-1-580a5a2d28c9@linaro.org>
X-B4-Tracking: v=1; b=H4sIAHK7f2QC/42NWw6CMBREt0L6bU2pWpQv92GI6eMCN6kttpVoC
 Hv3ygr8PDOZOQvLkBAya6uFJZgxYwwEclcxO+owAEdHzKSQB6GE4iVOaPnTPqS8iDs6D7noApm
 fDNXSiP5oFaO50Rm4STrYkQ7Cy3sKpwQ9vjffrSMeMZeYPpt+rn/pH6a55jV3rmkAeiHOCq4eg
 05xH9PAunVdv9GMJLDWAAAA
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1686092661; l=3464;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=9nKmu31YD8GcSD2/6NbQ7qO/EwtCV6fy082gMFHlK5U=;
 b=wKP8/iEbDbsH4/RtM8CoEhKALhodBs3ASHW8Wx+4US6dv653eMVIW2uhT3l2wZEtVWr5DKFBj
 8+pjviD33GgBUtazu7ddpyt1V0JBRi2tfLEFGmo/K0d7KVS3qYYBEsA
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the (scarce) idle states for the individual CPUs, as well as the
whole cluster. This enables deeper-than-WFI cpuidle

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
Changes in v2:
- Add missing BIT(24) ("last in power level")
- Use the correct CPU low-power state (0x3 instead of 0x4)
- Link to v1: https://lore.kernel.org/r/20230606-topic-qcm2290_idlestates-v1-1-dd77eef0086e@linaro.org
---
 arch/arm64/boot/dts/qcom/qcm2290.dtsi | 61 +++++++++++++++++++++++++++++++++++
 1 file changed, 61 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/qcm2290.dtsi b/arch/arm64/boot/dts/qcom/qcm2290.dtsi
index b29bc4e4b837..0ed11e80e5e2 100644
--- a/arch/arm64/boot/dts/qcom/qcm2290.dtsi
+++ b/arch/arm64/boot/dts/qcom/qcm2290.dtsi
@@ -48,6 +48,8 @@ CPU0: cpu@0 {
 			enable-method = "psci";
 			next-level-cache = <&L2_0>;
 			qcom,freq-domain = <&cpufreq_hw 0>;
+			power-domains = <&CPU_PD0>;
+			power-domain-names = "psci";
 			L2_0: l2-cache {
 				compatible = "cache";
 				cache-level = <2>;
@@ -65,6 +67,8 @@ CPU1: cpu@1 {
 			enable-method = "psci";
 			next-level-cache = <&L2_0>;
 			qcom,freq-domain = <&cpufreq_hw 0>;
+			power-domains = <&CPU_PD1>;
+			power-domain-names = "psci";
 		};
 
 		CPU2: cpu@2 {
@@ -77,6 +81,8 @@ CPU2: cpu@2 {
 			enable-method = "psci";
 			next-level-cache = <&L2_0>;
 			qcom,freq-domain = <&cpufreq_hw 0>;
+			power-domains = <&CPU_PD2>;
+			power-domain-names = "psci";
 		};
 
 		CPU3: cpu@3 {
@@ -89,6 +95,8 @@ CPU3: cpu@3 {
 			enable-method = "psci";
 			next-level-cache = <&L2_0>;
 			qcom,freq-domain = <&cpufreq_hw 0>;
+			power-domains = <&CPU_PD3>;
+			power-domain-names = "psci";
 		};
 
 		cpu-map {
@@ -110,6 +118,30 @@ core3 {
 				};
 			};
 		};
+
+		domain-idle-states {
+			CLUSTER_SLEEP: cluster-sleep-0 {
+				compatible = "domain-idle-state";
+				arm,psci-suspend-param = <0x41000043>;
+				entry-latency-us = <800>;
+				exit-latency-us = <2118>;
+				min-residency-us = <7376>;
+			};
+		};
+
+		idle-states {
+			entry-method = "psci";
+
+			CPU_SLEEP: cpu-sleep-0 {
+				compatible = "arm,idle-state";
+				idle-state-name = "power-collapse";
+				arm,psci-suspend-param = <0x40000003>;
+				entry-latency-us = <290>;
+				exit-latency-us = <376>;
+				min-residency-us = <1182>;
+				local-timer-stop;
+			};
+		};
 	};
 
 	firmware {
@@ -135,6 +167,35 @@ pmu {
 	psci {
 		compatible = "arm,psci-1.0";
 		method = "smc";
+
+		CPU_PD0: power-domain-cpu0 {
+			#power-domain-cells = <0>;
+			power-domains = <&CLUSTER_PD>;
+			domain-idle-states = <&CPU_SLEEP>;
+		};
+
+		CPU_PD1: power-domain-cpu1 {
+			#power-domain-cells = <0>;
+			power-domains = <&CLUSTER_PD>;
+			domain-idle-states = <&CPU_SLEEP>;
+		};
+
+		CPU_PD2: power-domain-cpu2 {
+			#power-domain-cells = <0>;
+			power-domains = <&CLUSTER_PD>;
+			domain-idle-states = <&CPU_SLEEP>;
+		};
+
+		CPU_PD3: power-domain-cpu3 {
+			#power-domain-cells = <0>;
+			power-domains = <&CLUSTER_PD>;
+			domain-idle-states = <&CPU_SLEEP>;
+		};
+
+		CLUSTER_PD: power-domain-cpu-cluster {
+			#power-domain-cells = <0>;
+			domain-idle-states = <&CLUSTER_SLEEP>;
+		};
 	};
 
 	reserved_memory: reserved-memory {

---
base-commit: 6db29e14f4fb7bce9eb5290288e71b05c2b0d118
change-id: 20230606-topic-qcm2290_idlestates-5b6062b0f4c6

Best regards,
-- 
Konrad Dybcio <konrad.dybcio@linaro.org>

