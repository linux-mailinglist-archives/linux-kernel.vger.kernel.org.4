Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23FC16976EE
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 08:04:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233521AbjBOHE2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 02:04:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233545AbjBOHEX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 02:04:23 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D73DE34F59
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 23:04:20 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id fu4-20020a17090ad18400b002341fadc370so1192103pjb.1
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 23:04:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AL6l5KdLl+g77HDa3WqYUX34iRKmo63b52JJZRcNsok=;
        b=zX4vvoFbCXw/rtzp8IJzOsYTS64/AiC2Af1jtVktHAXFS3Bb9hChglRONV10BQoU1r
         af01rWab8uuQyMPWdzT7Tw2pf/3+tOpgVLqcn0Qgv1I7DVcS41CvDGpB6WlnhM7HRfLD
         hHu1ru1FN+OSsBEU8ZZI/YO/tToG8dmWsIYnXIX5SpqtaMmMw/RNn0tmdse2xc0Mdckt
         VgWvUHIkAk/tEVgNVX+FeGWBfvFNBLbKMa/xyuxDqbKPDXWQf371Om1Y4W30sat4XBDm
         ZYtH/U4rKdAznjUW4MTkxcZJgMy1MeWW0ubI4yMaY9XACZPEwyn0gd0A6V4GRZmd6rYW
         Fd6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AL6l5KdLl+g77HDa3WqYUX34iRKmo63b52JJZRcNsok=;
        b=TeFwGG8sHZSQhQctlE1g6fnpxH0MRgtgTO0/UJkPYvG5FgdEPRPjjfO4PsmGZcKm5H
         PeYBjKpc49tdcauc3L8jwX8vfU8/CGHgJkBzbpPX5RhHhNOJR0tWASWvBkDpIzYFFA1P
         PoO8YMHmfIKncGlFBlIN533wNmecdgC9M9TpESJ7p46ni9z3eQ4Y5sIIBCBnrIc5k+WQ
         qMAvl5BZPWuBEMKuCboVSGaHrQ0u4hEnAVDEh0WwPDwgJUnHGbh/rdQN2Jr25RB4KaMF
         EOba8x8s6fvdKS2LzEePdQVtEUxuFaTfyep/SVpFpD+8wTG1/sMSthgTTLGxqSYqFiur
         L3ww==
X-Gm-Message-State: AO0yUKV7Q7xRiL99w0BOXvunWbfpnJ/e8FQv+VENNPikgY+vdy/R44a+
        kEwWodeke91jBoVp+lWIH0HdWuVcwIyhZAY=
X-Google-Smtp-Source: AK7set9bfC1fFeuXWyihZs3eAxRkWHrFlj+1LyhEzqmxcQYkkrv87ecBNbxIt/BSSYRdvwEHqsdyJg==
X-Received: by 2002:a05:6a20:1582:b0:c6:c85f:da59 with SMTP id h2-20020a056a20158200b000c6c85fda59mr1052731pzj.55.1676444660283;
        Tue, 14 Feb 2023 23:04:20 -0800 (PST)
Received: from localhost.localdomain ([117.217.179.87])
        by smtp.gmail.com with ESMTPSA id e23-20020a63db17000000b004fb26a80875sm9953795pgg.22.2023.02.14.23.04.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Feb 2023 23:04:19 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     andersson@kernel.org
Cc:     konrad.dybcio@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        viresh.kumar@linaro.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [RESEND PATCH 02/12] arm64: dts: qcom: sc7280: Supply clock from cpufreq node to CPUs
Date:   Wed, 15 Feb 2023 12:33:50 +0530
Message-Id: <20230215070400.5901-3-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230215070400.5901-1-manivannan.sadhasivam@linaro.org>
References: <20230215070400.5901-1-manivannan.sadhasivam@linaro.org>
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

Qualcomm platforms making use of CPUFreq HW Engine (EPSS/OSM) supply clocks
to the CPU cores. But this relationship is not represented in DTS so far.

So let's make cpufreq node as the clock provider and CPU nodes as the
consumers. The clock index for each CPU node is based on the frequency
domain index.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 arch/arm64/boot/dts/qcom/sc7280.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi b/arch/arm64/boot/dts/qcom/sc7280.dtsi
index bdcb74925313..d9b6e028cdac 100644
--- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
@@ -168,6 +168,7 @@ CPU0: cpu@0 {
 			device_type = "cpu";
 			compatible = "qcom,kryo";
 			reg = <0x0 0x0>;
+			clocks = <&cpufreq_hw 0>;
 			enable-method = "psci";
 			cpu-idle-states = <&LITTLE_CPU_SLEEP_0
 					   &LITTLE_CPU_SLEEP_1
@@ -193,6 +194,7 @@ CPU1: cpu@100 {
 			device_type = "cpu";
 			compatible = "qcom,kryo";
 			reg = <0x0 0x100>;
+			clocks = <&cpufreq_hw 0>;
 			enable-method = "psci";
 			cpu-idle-states = <&LITTLE_CPU_SLEEP_0
 					   &LITTLE_CPU_SLEEP_1
@@ -214,6 +216,7 @@ CPU2: cpu@200 {
 			device_type = "cpu";
 			compatible = "qcom,kryo";
 			reg = <0x0 0x200>;
+			clocks = <&cpufreq_hw 0>;
 			enable-method = "psci";
 			cpu-idle-states = <&LITTLE_CPU_SLEEP_0
 					   &LITTLE_CPU_SLEEP_1
@@ -235,6 +238,7 @@ CPU3: cpu@300 {
 			device_type = "cpu";
 			compatible = "qcom,kryo";
 			reg = <0x0 0x300>;
+			clocks = <&cpufreq_hw 0>;
 			enable-method = "psci";
 			cpu-idle-states = <&LITTLE_CPU_SLEEP_0
 					   &LITTLE_CPU_SLEEP_1
@@ -256,6 +260,7 @@ CPU4: cpu@400 {
 			device_type = "cpu";
 			compatible = "qcom,kryo";
 			reg = <0x0 0x400>;
+			clocks = <&cpufreq_hw 1>;
 			enable-method = "psci";
 			cpu-idle-states = <&BIG_CPU_SLEEP_0
 					   &BIG_CPU_SLEEP_1
@@ -277,6 +282,7 @@ CPU5: cpu@500 {
 			device_type = "cpu";
 			compatible = "qcom,kryo";
 			reg = <0x0 0x500>;
+			clocks = <&cpufreq_hw 1>;
 			enable-method = "psci";
 			cpu-idle-states = <&BIG_CPU_SLEEP_0
 					   &BIG_CPU_SLEEP_1
@@ -298,6 +304,7 @@ CPU6: cpu@600 {
 			device_type = "cpu";
 			compatible = "qcom,kryo";
 			reg = <0x0 0x600>;
+			clocks = <&cpufreq_hw 1>;
 			enable-method = "psci";
 			cpu-idle-states = <&BIG_CPU_SLEEP_0
 					   &BIG_CPU_SLEEP_1
@@ -319,6 +326,7 @@ CPU7: cpu@700 {
 			device_type = "cpu";
 			compatible = "qcom,kryo";
 			reg = <0x0 0x700>;
+			clocks = <&cpufreq_hw 2>;
 			enable-method = "psci";
 			cpu-idle-states = <&BIG_CPU_SLEEP_0
 					   &BIG_CPU_SLEEP_1
@@ -5337,6 +5345,7 @@ cpufreq_hw: cpufreq@18591000 {
 			clocks = <&rpmhcc RPMH_CXO_CLK>, <&gcc GCC_GPLL0>;
 			clock-names = "xo", "alternate";
 			#freq-domain-cells = <1>;
+			#clock-cells = <1>;
 		};
 	};
 
-- 
2.25.1

