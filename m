Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A509F7248C1
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 18:16:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238112AbjFFQQN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 12:16:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237598AbjFFQQL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 12:16:11 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0400172D
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 09:15:50 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-4f61735676fso5381632e87.2
        for <linux-kernel@vger.kernel.org>; Tue, 06 Jun 2023 09:15:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686068138; x=1688660138;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1SRSxQC2WdIw+o34oUy6oIpy06/ZQlGIR8S4Mw4guc8=;
        b=JLQx6wZg51LiGMJkB3FuCjWr1x2UpBIkYLDQr63kVjxZtnetkqCycqMuOnVKYS8W6p
         X8bnJZQSB0IsltdDIC1bL/bk0ApBWzeyGMVfRTu7UsWRTnqE1idyPI4qWktu+zxgxdFe
         8EWaimCcjEkWMUkdQBrCshIaeSaSIsLsI1l/95rD4uD0lPOGvpIGzew7I1tqc2eZoIG+
         nOVSAIS50nClYKRrhl6wS6NDTOZCOrmfRR6KNt/Cyjgea/R/yUwc1jiZvlXGGeSiZED1
         zvTQEgUkBUFWLEo/r89I+YT9NagB6ujSBGcqskTxgVwb1xNCoU0MZKU47rJTrbT7oDAV
         s3ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686068138; x=1688660138;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1SRSxQC2WdIw+o34oUy6oIpy06/ZQlGIR8S4Mw4guc8=;
        b=LQ7hPErU/PYRNiuWNh5PhA0/V875SHJQzuw+rwF8L3TyKAGCpGZlnZkagBLlJn7jOj
         Cz9wUgATtbM+g91Kz95pN55OCbn5G1OuENlWNCDwsVBVh9YueWjQAZVTGr5y5QEZGWal
         xipzm/4sN9RZJJoaMlJvY4MhfLCNnA4SORkIGjYPzdTw44Lm4ILIN2sMlKyi4AAQ0tfl
         JpOH1nadIcMtJHTWlPYwzoB+kDbXxOfwooUsvWESgiD5U58cNJN6BwSU5VNf0k/P0E2G
         BmujvEuF7feNUZJoiIRC0AsFWfp7y1mdzH+KXqeoOAgJ3oVZCC4BUj7cJ9Xh1rimhzy/
         IJmg==
X-Gm-Message-State: AC+VfDx+EuUkxgHe+DED83drLVWETrYW/Rh8VUuPsJ0h9gmqJ0hXYKX3
        tK8BJD2MpIcz3uapL1gTjtYBYCwn2gxuhaJtsz8=
X-Google-Smtp-Source: ACHHUZ5EwNmXbbl+bq5I/Nio0HUpAFM64hQwYFzQVck3Kdo2r0JJTnANiLUHg4xh50MZp7RecdKH5w==
X-Received: by 2002:a19:c50a:0:b0:4f4:d2ed:410 with SMTP id w10-20020a19c50a000000b004f4d2ed0410mr959991lfe.41.1686068138383;
        Tue, 06 Jun 2023 09:15:38 -0700 (PDT)
Received: from [192.168.1.101] (abyl150.neoplus.adsl.tpnet.pl. [83.9.31.150])
        by smtp.gmail.com with ESMTPSA id d8-20020ac241c8000000b004f160559d4asm1508197lfi.183.2023.06.06.09.15.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jun 2023 09:15:37 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Tue, 06 Jun 2023 18:15:28 +0200
Subject: [PATCH] arm64: dts: qcom: qcm2290: Add CPU idle states
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230606-topic-qcm2290_idlestates-v1-1-dd77eef0086e@linaro.org>
X-B4-Tracking: v=1; b=H4sIAJ9bf2QC/x2NUQrCMBBEr1L224W41oBeRUSSdGsXYlqzUQqld
 3fx883wZjZQrsIK126Dyl9RmYvB8dBBmkJ5MspgDOTo5Lzz2OZFEr7Ti+jiHjJk1hYaK56j1RT
 d2CcPpsegjLGGkiYbKJ+cLVwqj7L+/273ff8B9GGfQn8AAAA=
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1686068136; l=3232;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=mpM3TvARKVZf/Judx+8Gfrm0HsqhvtIO1689cde3IoQ=;
 b=OwAjVMp/BY+dJ4CzOFcuAV/14H/Ih5vqbWLvyxZEL4/GyjJTtRPPDnqzd71lTSyiCAlKLOkBV
 ATUt818LLNYDlHMrwBXC2IFd39FPui1Pd7BNNNm8Mu+hffnfdM31FD8
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
 arch/arm64/boot/dts/qcom/qcm2290.dtsi | 61 +++++++++++++++++++++++++++++++++++
 1 file changed, 61 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/qcm2290.dtsi b/arch/arm64/boot/dts/qcom/qcm2290.dtsi
index b29bc4e4b837..a8a1ce58c0b7 100644
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
+				arm,psci-suspend-param = <0x40000044>;
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

