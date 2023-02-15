Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17A246976B9
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 07:55:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233597AbjBOGzv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 01:55:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233569AbjBOGzm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 01:55:42 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD1A334C1D
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 22:55:39 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id e12so1852049plh.6
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 22:55:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AL6l5KdLl+g77HDa3WqYUX34iRKmo63b52JJZRcNsok=;
        b=vp0mHjG9CfzPnB1ZOuXZIJYu6sYl5fYq128lIB13AmCjSGq5rwHCmF2UudOwYU9RRj
         vTvJDATqAqotJCHb48jMZ5ESQ1/kQpuV9k+VhIDxVbfTqn56ohRPt7EkVs08HYP3edVo
         F1+gj4r8WFgRlEMyqEcahmaoqoxbmDlY3r+yQ9OFRNHbAbVzj5eyq46+m/v1NDZQjV5i
         K1j7Q8ObXnlHTM0/+j2UKtUwEOqSOJs4fgcw1xQ3C8HuSMNZUEMI1VsyyR/qXVmKfLcV
         LpbWOVPnX+o8AEFAd5fmmjgA6x6LuQH0PPh8n8qdAdH3qeMFhlfMM9sV/hd0fJTEk+A8
         TUZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AL6l5KdLl+g77HDa3WqYUX34iRKmo63b52JJZRcNsok=;
        b=JN+GE95S1hyNz2TWBBePPyuopOwVeALvfCHXukGxqcJ0L/11QXyQ6KHB6T8KbX0ESH
         p5nTwbzHr5XuQd0HciQ8/rgtozYaHmannYMwdIB9XNcXIZ79tJ1fsFks1qJ9fz2n93EZ
         r6wnAhk0crqzOzLSLhw4n2+aEOrcv+5SKqYQnTLqEArXYQ619Y1dObQdr+dZKYrrowvA
         m6ohEIV5F3jmK07OYtQoTKOCKut4iO9QQy+phUUHNnOZfiIjP8xRo4Iw5DMImRhS5qnu
         DUtHZ8cj8IDAohaF85ThYjNr9ARmCbahrJXPDvhXoM+LlVFQpOpUNUc9rv6O2zrSL5Z5
         EpQw==
X-Gm-Message-State: AO0yUKUdkbvMjAJNDTrL7G94edrWfu0a+QzxZvDedaCZvevexEvmkk3U
        cIKb1y0dWcTZCxiEcpp87c/J
X-Google-Smtp-Source: AK7set92cvmPLctcppeUHTztse+uqS1Nypapzbtc1yL/n5QOZjLIIjLnQCwCgyyYjIJZy4M728miqw==
X-Received: by 2002:a05:6a21:3609:b0:b8:ca86:d1e8 with SMTP id yg9-20020a056a21360900b000b8ca86d1e8mr797027pzb.14.1676444139019;
        Tue, 14 Feb 2023 22:55:39 -0800 (PST)
Received: from localhost.localdomain ([117.217.179.87])
        by smtp.gmail.com with ESMTPSA id d23-20020a170902b71700b001933b4b1a49sm10276870pls.183.2023.02.14.22.55.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Feb 2023 22:55:38 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     andersson@kernel.org
Cc:     konrad.dybcio@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        viresh.kumar@linaro.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 02/12] arm64: dts: qcom: sc7280: Supply clock from cpufreq node to CPUs
Date:   Wed, 15 Feb 2023 12:25:13 +0530
Message-Id: <20230215065520.5535-3-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230215065520.5535-1-manivannan.sadhasivam@linaro.org>
References: <20230215065520.5535-1-manivannan.sadhasivam@linaro.org>
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

