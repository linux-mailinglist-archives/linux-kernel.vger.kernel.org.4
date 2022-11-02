Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 892FE615DF4
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 09:38:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230494AbiKBIia (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 04:38:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230440AbiKBIi1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 04:38:27 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73E9E275F8
        for <linux-kernel@vger.kernel.org>; Wed,  2 Nov 2022 01:38:18 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id b29so15744534pfp.13
        for <linux-kernel@vger.kernel.org>; Wed, 02 Nov 2022 01:38:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5vgVZXeinbhpnwzOcj3FGms9cM/M5Xj4R/cDa4Tk1cA=;
        b=YvOb5CFjmq7QmgcbRyfxDALfMgiQ7VSmimDfE9Rrpy9P/+6LYmITFXsjGRqQOOw3/x
         kdRsRI56VCLcNGx7hn9mtTazIQwj/8EYvKAeymXUExvsH5lS6YTJV3H6J5cHMx0SIdqa
         Sjc6If8UY9GhK3q8sgJqKIiX6Y+j5WdVlIfj4as0q9q1XI+hSew5KEZ4XfM5pIs7fPfA
         B+BK2UcZfTcYXrshnLT/d/iM5x/G8qD6bZJSdbEtGutmUsSNQ9jqkUYFnmxyzuQzgtqf
         V6igL07Zx19ka14ZwMPTbDJ7KEBy1s0CUHMgGQMklkzF+I8JAdR+/z8p2w8h0f6LKCbC
         USjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5vgVZXeinbhpnwzOcj3FGms9cM/M5Xj4R/cDa4Tk1cA=;
        b=GukIyeQ/StCYx5Jgjy3xSazLQqptxW3sfB4hqxeKJGyJFty3++eHPzY6rRRTpeetdv
         2CldNvMzaWDACJAf9fUziw4SvWxePMBnI97ioNMSd/W856Y2Ka/q/7YiloCfKQnXbrF1
         amZZIj6WKVOEzh00E6hNgpl/45m1iKilBfWAvO8cyNUoVN48RrI8+NxfgyhsDWt48qZU
         oQI3OJ3Xxu6vebp1AziJc1p4Iq/8VJcwcF/cDAxRYZ4AmTusm9LObMrK0NBDILuHaP0m
         HMrRk72m8W4Q+o2vbCi3qY3rn0JowlE+VBRDTfH3gPnsN65pZBHZXrofcFO3TIrKg+oH
         Urjw==
X-Gm-Message-State: ACrzQf02GrK8DnB5byjbCDNUZ252fmjVNWwZX0FOCLd44UwAsXET8C/4
        YN4AxFIGIWUQ14bWNyiAdvAv
X-Google-Smtp-Source: AMsMyM6S11SO8OBFBe1XKuUwmkGZMiin5El65unTd9sjHU9560O4JQ7IGxl0HXUc+9atUPWPqu0CXA==
X-Received: by 2002:a62:1a97:0:b0:562:5587:12d6 with SMTP id a145-20020a621a97000000b00562558712d6mr23473027pfa.37.1667378297911;
        Wed, 02 Nov 2022 01:38:17 -0700 (PDT)
Received: from localhost.localdomain ([117.193.209.178])
        by smtp.gmail.com with ESMTPSA id x19-20020aa79573000000b0056bcb102e7bsm7887770pfq.68.2022.11.02.01.38.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Nov 2022 01:38:17 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     andersson@kernel.org, viresh.kumar@linaro.org,
        krzysztof.kozlowski+dt@linaro.org, rafael@kernel.org,
        robh+dt@kernel.org
Cc:     johan@kernel.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v3 2/3] arm64: dts: qcom: sm8450: Supply clock from cpufreq node to CPUs
Date:   Wed,  2 Nov 2022 14:07:50 +0530
Message-Id: <20221102083751.56330-3-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221102083751.56330-1-manivannan.sadhasivam@linaro.org>
References: <20221102083751.56330-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
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
index 6c18cfca9a34..8f26cf9aad01 100644
--- a/arch/arm64/boot/dts/qcom/sm8450.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8450.dtsi
@@ -52,6 +52,7 @@ CPU0: cpu@0 {
 			power-domain-names = "psci";
 			qcom,freq-domain = <&cpufreq_hw 0>;
 			#cooling-cells = <2>;
+			clocks = <&cpufreq_hw 0>;
 			L2_0: l2-cache {
 			      compatible = "cache";
 			      next-level-cache = <&L3_0>;
@@ -71,6 +72,7 @@ CPU1: cpu@100 {
 			power-domain-names = "psci";
 			qcom,freq-domain = <&cpufreq_hw 0>;
 			#cooling-cells = <2>;
+			clocks = <&cpufreq_hw 0>;
 			L2_100: l2-cache {
 			      compatible = "cache";
 			      next-level-cache = <&L3_0>;
@@ -87,6 +89,7 @@ CPU2: cpu@200 {
 			power-domain-names = "psci";
 			qcom,freq-domain = <&cpufreq_hw 0>;
 			#cooling-cells = <2>;
+			clocks = <&cpufreq_hw 0>;
 			L2_200: l2-cache {
 			      compatible = "cache";
 			      next-level-cache = <&L3_0>;
@@ -103,6 +106,7 @@ CPU3: cpu@300 {
 			power-domain-names = "psci";
 			qcom,freq-domain = <&cpufreq_hw 0>;
 			#cooling-cells = <2>;
+			clocks = <&cpufreq_hw 0>;
 			L2_300: l2-cache {
 			      compatible = "cache";
 			      next-level-cache = <&L3_0>;
@@ -119,6 +123,7 @@ CPU4: cpu@400 {
 			power-domain-names = "psci";
 			qcom,freq-domain = <&cpufreq_hw 1>;
 			#cooling-cells = <2>;
+			clocks = <&cpufreq_hw 1>;
 			L2_400: l2-cache {
 			      compatible = "cache";
 			      next-level-cache = <&L3_0>;
@@ -135,6 +140,7 @@ CPU5: cpu@500 {
 			power-domain-names = "psci";
 			qcom,freq-domain = <&cpufreq_hw 1>;
 			#cooling-cells = <2>;
+			clocks = <&cpufreq_hw 1>;
 			L2_500: l2-cache {
 			      compatible = "cache";
 			      next-level-cache = <&L3_0>;
@@ -152,6 +158,7 @@ CPU6: cpu@600 {
 			power-domain-names = "psci";
 			qcom,freq-domain = <&cpufreq_hw 1>;
 			#cooling-cells = <2>;
+			clocks = <&cpufreq_hw 1>;
 			L2_600: l2-cache {
 			      compatible = "cache";
 			      next-level-cache = <&L3_0>;
@@ -168,6 +175,7 @@ CPU7: cpu@700 {
 			power-domain-names = "psci";
 			qcom,freq-domain = <&cpufreq_hw 2>;
 			#cooling-cells = <2>;
+			clocks = <&cpufreq_hw 2>;
 			L2_700: l2-cache {
 			      compatible = "cache";
 			      next-level-cache = <&L3_0>;
@@ -3804,6 +3812,7 @@ cpufreq_hw: cpufreq@17d91000 {
 				     <GIC_SPI 19 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-names = "dcvsh-irq-0", "dcvsh-irq-1", "dcvsh-irq-2";
 			#freq-domain-cells = <1>;
+			#clock-cells = <1>;
 		};
 
 		gem_noc: interconnect@19100000 {
-- 
2.25.1

