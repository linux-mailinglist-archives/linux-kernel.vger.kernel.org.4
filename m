Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FF99697708
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 08:05:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233754AbjBOHFc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 02:05:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233599AbjBOHEk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 02:04:40 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04CCE35272
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 23:04:29 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id o8so17021550pls.11
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 23:04:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1fQsTTXBNiNhOtrjU3bWR9pOnFEJRPHEV6xz3+pJ+84=;
        b=MoCFxa4cV6PHPAcLikTuqBzNOR8GiGP0yozb2bL/XlajB03Xztjldzrr3VqtH9qhQo
         wmB36VziV+Zu88mlCCgg3lEgC6sNnJ+OL6Fh9IfoGB6aSjNEIwve9iXZppFD3ZUw8yR8
         M4JG7g5uB94SCIEu4qF0iW604sna9gCC/iQf2me0UfHU2RAmo1M0C8B+1T5c2j5dbB21
         feDqD84HbnUIfx9Rp+48/O52acZmDOuaSiCGzramCyokcmO3GOuhX8eBZZzTT/q5PQkJ
         ZYSapE4rgmy61nfq1aCeogofViR+ZMSnWNLfPaJsb5c52yWvFjQcj1g85zOJLr8o+doQ
         1BbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1fQsTTXBNiNhOtrjU3bWR9pOnFEJRPHEV6xz3+pJ+84=;
        b=sgmlOOOmo7+91LtHguD1fZZQJhQCdtSqLE3x6W1xJYZJ3StoZqW4fkrsmn5wGWMYiu
         EXbpNTCR2KBdurXnIOewpw6wGofVneHyLpqnwyd/lZuAUFXvvgV2VWkvIWZYF3EL1ly9
         EaYVLUMYPUaBv7Vf6EsmLIvuA4BerAfiX5bOX2ViRPwSVxheCN5Pym11vQ2vFYgSXifU
         ERNbeXKC6mf0M8Ke7UE+27o7RYkBKhzYaznrxzyp7kHcjtM/58DK51lEhqrlKjZqukN3
         pEndMxQpVZpzkLRhcXj6/opXjdZyjrQQu1iWEn7V4veXTXhcZKiSgTm3AxcQcv71X6lg
         BCUA==
X-Gm-Message-State: AO0yUKXIKd/kJRsInSUNvyuSVfC0Mfvg+g+vUXn6BQXhVyVAuUAGqKLf
        2nH0WNhOpfvT3t1HWQwk8j9d
X-Google-Smtp-Source: AK7set+EweX/xMQJzJWzvjsBIpm3Zgd9TYuuSZOocPcQnOqCw2LyT65/olCTkRT8Qu8kxR+8BDMNog==
X-Received: by 2002:a17:90b:1b0b:b0:234:e3f:f52d with SMTP id nu11-20020a17090b1b0b00b002340e3ff52dmr1945120pjb.2.1676444668559;
        Tue, 14 Feb 2023 23:04:28 -0800 (PST)
Received: from localhost.localdomain ([117.217.179.87])
        by smtp.gmail.com with ESMTPSA id e23-20020a63db17000000b004fb26a80875sm9953795pgg.22.2023.02.14.23.04.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Feb 2023 23:04:28 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     andersson@kernel.org
Cc:     konrad.dybcio@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        viresh.kumar@linaro.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [RESEND PATCH 04/12] arm64: dts: qcom: sm8550: Supply clock from cpufreq node to CPUs
Date:   Wed, 15 Feb 2023 12:33:52 +0530
Message-Id: <20230215070400.5901-5-manivannan.sadhasivam@linaro.org>
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
 arch/arm64/boot/dts/qcom/sm8550.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8550.dtsi b/arch/arm64/boot/dts/qcom/sm8550.dtsi
index 9910006c32aa..21b4f668889d 100644
--- a/arch/arm64/boot/dts/qcom/sm8550.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8550.dtsi
@@ -68,6 +68,7 @@ CPU0: cpu@0 {
 			device_type = "cpu";
 			compatible = "qcom,kryo";
 			reg = <0 0>;
+			clocks = <&cpufreq_hw 0>;
 			enable-method = "psci";
 			next-level-cache = <&L2_0>;
 			power-domains = <&CPU_PD0>;
@@ -91,6 +92,7 @@ CPU1: cpu@100 {
 			device_type = "cpu";
 			compatible = "qcom,kryo";
 			reg = <0 0x100>;
+			clocks = <&cpufreq_hw 0>;
 			enable-method = "psci";
 			next-level-cache = <&L2_100>;
 			power-domains = <&CPU_PD1>;
@@ -110,6 +112,7 @@ CPU2: cpu@200 {
 			device_type = "cpu";
 			compatible = "qcom,kryo";
 			reg = <0 0x200>;
+			clocks = <&cpufreq_hw 0>;
 			enable-method = "psci";
 			next-level-cache = <&L2_200>;
 			power-domains = <&CPU_PD2>;
@@ -129,6 +132,7 @@ CPU3: cpu@300 {
 			device_type = "cpu";
 			compatible = "qcom,kryo";
 			reg = <0 0x300>;
+			clocks = <&cpufreq_hw 1>;
 			enable-method = "psci";
 			next-level-cache = <&L2_300>;
 			power-domains = <&CPU_PD3>;
@@ -148,6 +152,7 @@ CPU4: cpu@400 {
 			device_type = "cpu";
 			compatible = "qcom,kryo";
 			reg = <0 0x400>;
+			clocks = <&cpufreq_hw 1>;
 			enable-method = "psci";
 			next-level-cache = <&L2_400>;
 			power-domains = <&CPU_PD4>;
@@ -167,6 +172,7 @@ CPU5: cpu@500 {
 			device_type = "cpu";
 			compatible = "qcom,kryo";
 			reg = <0 0x500>;
+			clocks = <&cpufreq_hw 1>;
 			enable-method = "psci";
 			next-level-cache = <&L2_500>;
 			power-domains = <&CPU_PD5>;
@@ -186,6 +192,7 @@ CPU6: cpu@600 {
 			device_type = "cpu";
 			compatible = "qcom,kryo";
 			reg = <0 0x600>;
+			clocks = <&cpufreq_hw 1>;
 			enable-method = "psci";
 			next-level-cache = <&L2_600>;
 			power-domains = <&CPU_PD6>;
@@ -205,6 +212,7 @@ CPU7: cpu@700 {
 			device_type = "cpu";
 			compatible = "qcom,kryo";
 			reg = <0 0x700>;
+			clocks = <&cpufreq_hw 2>;
 			enable-method = "psci";
 			next-level-cache = <&L2_700>;
 			power-domains = <&CPU_PD7>;
@@ -3341,6 +3349,7 @@ cpufreq_hw: cpufreq@17d91000 {
 				     <GIC_SPI 19 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-names = "dcvsh-irq-0", "dcvsh-irq-1", "dcvsh-irq-2";
 			#freq-domain-cells = <1>;
+			#clock-cells = <1>;
 		};
 
 		pmu@24091000 {
-- 
2.25.1

