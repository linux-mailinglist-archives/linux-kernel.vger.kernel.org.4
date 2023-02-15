Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE0CC6976CF
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 07:57:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233730AbjBOG5Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 01:57:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233652AbjBOG4f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 01:56:35 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D36BF36687
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 22:56:06 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id w20-20020a17090a8a1400b00233d7314c1cso1143029pjn.5
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 22:56:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MSprQRzUAPAcRKdXmOH1+IXrj92bjRdjsdi9aS/W/NY=;
        b=f4YNHiUrKOy7cdBSnBD5UTsHc+gB1AKul1UNMKktndUWpQlt9o9VsEH4rewrx2qOe5
         wPJv6QbUomhvfnvWCbZIhQXqSo50f7oLYnFIgzD4IKJ8ltSd8bgSEyG2ugDqs+lYnh6L
         4Bc8b+A0Kg/Adwo4MEedBUHDo0v7TAODMKgx5/QqVpuxUPGqs3Sm7hjD1kpr3L0EYZEl
         frRDrc25T2YF6V8k5KzG5QoFLwyTlGPXZRhv0bZf5O75BrHU3qVSj1DuqhAmlyJ9/K11
         MYZAnyQIW52CV/WNo2AlbbOeUQ2YBO17iYvzpn05ndEzBAdEmpvm7fw9G5UX5f0wxnfq
         o2Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MSprQRzUAPAcRKdXmOH1+IXrj92bjRdjsdi9aS/W/NY=;
        b=bK09OrfWmvHtOBSspyY0gxWxV7NCkvVmhSCRqTZZE+vMs+oT+ewXyu6FV3Soy+a8xj
         U/IrnKnHMrYsLVI5k98esIQl6UGI6NHmN2lHrUVzxKe9kZAaICaLZvmh+BsijIo5b2GR
         OOPUcO0V6Nb1wQhdDiy5p2s9qhYRDkStSAxIiK+67SUd7Dqvk8EZpZGNuN/KJNU7EdGO
         yncXcb8pWtfJEw2g4gH5NNJz24HOo61td4kA7/Le+yzC7lwIpzlqJRBjz51bIy+y5bIm
         m46uN5JYtqW2MTxzlIxOrCFyEcyx8ie9LIesbg1BQ+Y/nk1gd503UV8mT7kk4zYYfnHR
         6Sog==
X-Gm-Message-State: AO0yUKVuNcdCXDBW7YrV3vxUuq0dH+6OLJEZjh6GBwlf0glS9IlGf6Hr
        8wfT48jKrIskITshQVpPXFH6
X-Google-Smtp-Source: AK7set/faHchsvkUvLEBdmmSzOm1COAtSWydGfthpCbP+3HYIe1oSrQxX4x9iVdcpjLNzEUePx2log==
X-Received: by 2002:a17:902:d4cc:b0:199:16c6:8a24 with SMTP id o12-20020a170902d4cc00b0019916c68a24mr1590256plg.61.1676444166085;
        Tue, 14 Feb 2023 22:56:06 -0800 (PST)
Received: from localhost.localdomain ([117.217.179.87])
        by smtp.gmail.com with ESMTPSA id d23-20020a170902b71700b001933b4b1a49sm10276870pls.183.2023.02.14.22.56.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Feb 2023 22:56:05 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     andersson@kernel.org
Cc:     konrad.dybcio@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        viresh.kumar@linaro.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 09/12] arm64: dts: qcom: sm8350: Supply clock from cpufreq node to CPUs
Date:   Wed, 15 Feb 2023 12:25:20 +0530
Message-Id: <20230215065520.5535-10-manivannan.sadhasivam@linaro.org>
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
 arch/arm64/boot/dts/qcom/sm8350.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8350.dtsi b/arch/arm64/boot/dts/qcom/sm8350.dtsi
index 0a422637b61f..1b423c42ec0d 100644
--- a/arch/arm64/boot/dts/qcom/sm8350.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8350.dtsi
@@ -48,6 +48,7 @@ CPU0: cpu@0 {
 			device_type = "cpu";
 			compatible = "qcom,kryo685";
 			reg = <0x0 0x0>;
+			clocks = <&cpufreq_hw 0>;
 			enable-method = "psci";
 			next-level-cache = <&L2_0>;
 			qcom,freq-domain = <&cpufreq_hw 0>;
@@ -69,6 +70,7 @@ CPU1: cpu@100 {
 			device_type = "cpu";
 			compatible = "qcom,kryo685";
 			reg = <0x0 0x100>;
+			clocks = <&cpufreq_hw 0>;
 			enable-method = "psci";
 			next-level-cache = <&L2_100>;
 			qcom,freq-domain = <&cpufreq_hw 0>;
@@ -86,6 +88,7 @@ CPU2: cpu@200 {
 			device_type = "cpu";
 			compatible = "qcom,kryo685";
 			reg = <0x0 0x200>;
+			clocks = <&cpufreq_hw 0>;
 			enable-method = "psci";
 			next-level-cache = <&L2_200>;
 			qcom,freq-domain = <&cpufreq_hw 0>;
@@ -103,6 +106,7 @@ CPU3: cpu@300 {
 			device_type = "cpu";
 			compatible = "qcom,kryo685";
 			reg = <0x0 0x300>;
+			clocks = <&cpufreq_hw 0>;
 			enable-method = "psci";
 			next-level-cache = <&L2_300>;
 			qcom,freq-domain = <&cpufreq_hw 0>;
@@ -120,6 +124,7 @@ CPU4: cpu@400 {
 			device_type = "cpu";
 			compatible = "qcom,kryo685";
 			reg = <0x0 0x400>;
+			clocks = <&cpufreq_hw 1>;
 			enable-method = "psci";
 			next-level-cache = <&L2_400>;
 			qcom,freq-domain = <&cpufreq_hw 1>;
@@ -137,6 +142,7 @@ CPU5: cpu@500 {
 			device_type = "cpu";
 			compatible = "qcom,kryo685";
 			reg = <0x0 0x500>;
+			clocks = <&cpufreq_hw 1>;
 			enable-method = "psci";
 			next-level-cache = <&L2_500>;
 			qcom,freq-domain = <&cpufreq_hw 1>;
@@ -155,6 +161,7 @@ CPU6: cpu@600 {
 			device_type = "cpu";
 			compatible = "qcom,kryo685";
 			reg = <0x0 0x600>;
+			clocks = <&cpufreq_hw 1>;
 			enable-method = "psci";
 			next-level-cache = <&L2_600>;
 			qcom,freq-domain = <&cpufreq_hw 1>;
@@ -172,6 +179,7 @@ CPU7: cpu@700 {
 			device_type = "cpu";
 			compatible = "qcom,kryo685";
 			reg = <0x0 0x700>;
+			clocks = <&cpufreq_hw 2>;
 			enable-method = "psci";
 			next-level-cache = <&L2_700>;
 			qcom,freq-domain = <&cpufreq_hw 2>;
@@ -2283,6 +2291,7 @@ cpufreq_hw: cpufreq@18591000 {
 			clock-names = "xo", "alternate";
 
 			#freq-domain-cells = <1>;
+			#clock-cells = <1>;
 		};
 
 		ufs_mem_hc: ufshc@1d84000 {
-- 
2.25.1

