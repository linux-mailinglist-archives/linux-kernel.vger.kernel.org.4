Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82E0F622509
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 09:02:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229795AbiKIICF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 03:02:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229821AbiKIIBy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 03:01:54 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 305231CB0F
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 00:01:51 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id 187-20020a1c02c4000000b003cf9c3f3b80so713543wmc.0
        for <linux-kernel@vger.kernel.org>; Wed, 09 Nov 2022 00:01:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cWX3PFtX+iNvvcqKHYXPbN+3ItiEZ3sX7UGhc0uTyP8=;
        b=YMY82KVHHtrKVPisic7cjXWyZ9YngGsDShFyXwRCVQLB0NnHcPe/C1DoWm94FBPICb
         Tc2cwOehcP/LsLGQi/GLi0ql8QiEngdNKK1UErsOwZyTg+Dtoqsr2DUSoOqG57iArbKk
         PqNzaXb1ix0nstzhlh2/Fp4dokJHMO//FX5qvHU6lqXgPiPy/jTFYvWEotad7Rq5DbOK
         PP4bGK1eTjsvv49f4oLB5ebiu3GSRyO0exGLVwj7ET2FefYy3NxdDlRm1td4TzHHz7yj
         NWFyrh9eS7QHYudm3pAvTaw7e8CKy8M6vEh/8oFreexp/+u91YYmLMleh4x/UJ0qRXij
         QZNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cWX3PFtX+iNvvcqKHYXPbN+3ItiEZ3sX7UGhc0uTyP8=;
        b=4T1r6GuGVXznd5Z65Zmt5h6G0E3cUvCFedROl8qcVIjD4A5VpVKD2V5o0G+sOJdYnG
         eWFml6hN93IuQb5uTLc/FMtKBtPhoi9z2tnO2AlLSLY4u6tvWLl/yEkmscFGg8jc+CyJ
         3udsvWgJILmOD6ugCZcJrJDgec7ZmU0NCpa+aGQlS95bbxRWWeC0oheLhLz8AFfrHMj7
         uEcPnQk849wwllatsejkZNvXP1LR6ptAwQk4wmShBZCwNiAB4JgTNNSo9JER6/wVYoqn
         MNqozwrydsrtJbN2XRLJHJXD6LAi5ARObUFmH7IEc+omSZfr+G+6GYQ258wfBrnucgAd
         uxug==
X-Gm-Message-State: ACrzQf1UbkaUav86lRntFfN4tFof78U2S7hS8FsPgZUYx8A24M8KdgHY
        opLau5G/gEn2tga28htZRlm5
X-Google-Smtp-Source: AMsMyM7kqiCTE2VnhXroBqFsOZN9mAugt0dDbSIFOwkHLmmwaga0pT9EoQk/dZzvso3xL6JuZIx7bA==
X-Received: by 2002:a05:600c:1da4:b0:3c6:b656:5b52 with SMTP id p36-20020a05600c1da400b003c6b6565b52mr866689wms.1.1667980909659;
        Wed, 09 Nov 2022 00:01:49 -0800 (PST)
Received: from localhost.localdomain ([117.202.189.229])
        by smtp.gmail.com with ESMTPSA id l26-20020a05600c2cda00b003cf774c31a0sm769427wmc.16.2022.11.09.00.01.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Nov 2022 00:01:48 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     andersson@kernel.org, viresh.kumar@linaro.org,
        krzysztof.kozlowski+dt@linaro.org, rafael@kernel.org,
        robh+dt@kernel.org
Cc:     johan@kernel.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v6 2/3] arm64: dts: qcom: sm8450: Supply clock from cpufreq node to CPUs
Date:   Wed,  9 Nov 2022 13:31:19 +0530
Message-Id: <20221109080120.19078-3-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221109080120.19078-1-manivannan.sadhasivam@linaro.org>
References: <20221109080120.19078-1-manivannan.sadhasivam@linaro.org>
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
 arch/arm64/boot/dts/qcom/sm8450.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8450.dtsi b/arch/arm64/boot/dts/qcom/sm8450.dtsi
index d32f08df743d..234d2722a4fa 100644
--- a/arch/arm64/boot/dts/qcom/sm8450.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8450.dtsi
@@ -51,6 +51,7 @@ CPU0: cpu@0 {
 			power-domain-names = "psci";
 			qcom,freq-domain = <&cpufreq_hw 0>;
 			#cooling-cells = <2>;
+			clocks = <&cpufreq_hw 0>;
 			L2_0: l2-cache {
 			      compatible = "cache";
 			      next-level-cache = <&L3_0>;
@@ -70,6 +71,7 @@ CPU1: cpu@100 {
 			power-domain-names = "psci";
 			qcom,freq-domain = <&cpufreq_hw 0>;
 			#cooling-cells = <2>;
+			clocks = <&cpufreq_hw 0>;
 			L2_100: l2-cache {
 			      compatible = "cache";
 			      next-level-cache = <&L3_0>;
@@ -86,6 +88,7 @@ CPU2: cpu@200 {
 			power-domain-names = "psci";
 			qcom,freq-domain = <&cpufreq_hw 0>;
 			#cooling-cells = <2>;
+			clocks = <&cpufreq_hw 0>;
 			L2_200: l2-cache {
 			      compatible = "cache";
 			      next-level-cache = <&L3_0>;
@@ -102,6 +105,7 @@ CPU3: cpu@300 {
 			power-domain-names = "psci";
 			qcom,freq-domain = <&cpufreq_hw 0>;
 			#cooling-cells = <2>;
+			clocks = <&cpufreq_hw 0>;
 			L2_300: l2-cache {
 			      compatible = "cache";
 			      next-level-cache = <&L3_0>;
@@ -118,6 +122,7 @@ CPU4: cpu@400 {
 			power-domain-names = "psci";
 			qcom,freq-domain = <&cpufreq_hw 1>;
 			#cooling-cells = <2>;
+			clocks = <&cpufreq_hw 1>;
 			L2_400: l2-cache {
 			      compatible = "cache";
 			      next-level-cache = <&L3_0>;
@@ -134,6 +139,7 @@ CPU5: cpu@500 {
 			power-domain-names = "psci";
 			qcom,freq-domain = <&cpufreq_hw 1>;
 			#cooling-cells = <2>;
+			clocks = <&cpufreq_hw 1>;
 			L2_500: l2-cache {
 			      compatible = "cache";
 			      next-level-cache = <&L3_0>;
@@ -151,6 +157,7 @@ CPU6: cpu@600 {
 			power-domain-names = "psci";
 			qcom,freq-domain = <&cpufreq_hw 1>;
 			#cooling-cells = <2>;
+			clocks = <&cpufreq_hw 1>;
 			L2_600: l2-cache {
 			      compatible = "cache";
 			      next-level-cache = <&L3_0>;
@@ -167,6 +174,7 @@ CPU7: cpu@700 {
 			power-domain-names = "psci";
 			qcom,freq-domain = <&cpufreq_hw 2>;
 			#cooling-cells = <2>;
+			clocks = <&cpufreq_hw 2>;
 			L2_700: l2-cache {
 			      compatible = "cache";
 			      next-level-cache = <&L3_0>;
@@ -3075,6 +3083,7 @@ cpufreq_hw: cpufreq@17d91000 {
 				     <GIC_SPI 19 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-names = "dcvsh-irq-0", "dcvsh-irq-1", "dcvsh-irq-2";
 			#freq-domain-cells = <1>;
+			#clock-cells = <1>;
 		};
 
 		gem_noc: interconnect@19100000 {
-- 
2.25.1

