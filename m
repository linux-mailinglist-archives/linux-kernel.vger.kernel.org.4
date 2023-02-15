Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C64AF6976C5
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 07:56:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233673AbjBOG4i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 01:56:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233676AbjBOG4Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 01:56:16 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E920536473
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 22:55:54 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id h4so11531883pll.9
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 22:55:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LHVr08cnTjJMehZboB/JWbeUqVs1oVn1lVODeozYst8=;
        b=pMM8GzBVPWy86Rwc1zYw6ZDFkA2WMhuWq4lbXVzKg2/P6jc5ym0hPiW8I5jHLjSYbX
         0VyWgZHqBZxNvd0xLEXxAQVaV6aSX+D19VuYwC+L4v4gNvr7SsUJF4H2jKDh0v9L/Erg
         w5VVTU7W/V/tRakxA4byRSKVy5Hk4dOn03Xj0pmLJxn0SiLV5sqR/n5jtWBDVglfYscp
         LbZzFfHZEnpyKGt3ZiKhnvsweYgagX+tGMP6QpYCskh3wMl+Y7AiywM7xUeJyuXl70QP
         OwZQEl5Kf8EoKhPiI4gh8B9bEL59rdGzC28WTU1hatDpC8ONXkOOtLT43GmnLfWViC9G
         S+ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LHVr08cnTjJMehZboB/JWbeUqVs1oVn1lVODeozYst8=;
        b=VSRVidw+kuCZjCDd659+wB7071zv19+CgDOfn0cxd8lWhG7J2dTKCEdruDZjfyUEbf
         A1HKcKgFMzwG6xwLfQaMPeITaEEVu9lDEkLkUzo1nm4mfW8Aih8MxWepj+Xl/O8ePNA4
         V5kGv5wtGdtjWB+cCKQKibyhxOypYPDPViKL4UmX7Twho5V5U1Q476NmCdsGq5FbvQHf
         m5C75CilSpwfAILUD4C4j/cGqjfIM4KOQyQbdUsWoDzLH0IPyF42lS4PXH6t3V8d0qvB
         n0Dg2gxipqdT9IdJtTtq1PFVA7bxZEHjgCvu+eLd+tQ1zLf/vyqggXNOKHx8UJFAb/D3
         LNIQ==
X-Gm-Message-State: AO0yUKXYxgX0sfd8zzn5QlvBSlS4um/sVtNo3jgFHaGHcNAYXGugmV0P
        yEkg9yirhUlZ9fnyhkK5gi6V
X-Google-Smtp-Source: AK7set/y3m8sr5fPLNwHiiBORmPqhEMjoedI+QogoTGmcs9kiy8465+pUtzeB4hHFfJpXeyPv8jlHw==
X-Received: by 2002:a17:902:c949:b0:19a:9691:196d with SMTP id i9-20020a170902c94900b0019a9691196dmr1688099pla.29.1676444154135;
        Tue, 14 Feb 2023 22:55:54 -0800 (PST)
Received: from localhost.localdomain ([117.217.179.87])
        by smtp.gmail.com with ESMTPSA id d23-20020a170902b71700b001933b4b1a49sm10276870pls.183.2023.02.14.22.55.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Feb 2023 22:55:53 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     andersson@kernel.org
Cc:     konrad.dybcio@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        viresh.kumar@linaro.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 06/12] arm64: dts: qcom: qdu1000: Supply clock from cpufreq node to CPUs
Date:   Wed, 15 Feb 2023 12:25:17 +0530
Message-Id: <20230215065520.5535-7-manivannan.sadhasivam@linaro.org>
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
 arch/arm64/boot/dts/qcom/qdu1000.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/qdu1000.dtsi b/arch/arm64/boot/dts/qcom/qdu1000.dtsi
index f234159d2060..98a859ad5229 100644
--- a/arch/arm64/boot/dts/qcom/qdu1000.dtsi
+++ b/arch/arm64/boot/dts/qcom/qdu1000.dtsi
@@ -27,6 +27,7 @@ CPU0: cpu@0 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a55";
 			reg = <0x0 0x0>;
+			clocks = <&cpufreq_hw 0>;
 			enable-method = "psci";
 			power-domains = <&CPU_PD0>;
 			power-domain-names = "psci";
@@ -45,6 +46,7 @@ CPU1: cpu@100 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a55";
 			reg = <0x0 0x100>;
+			clocks = <&cpufreq_hw 0>;
 			enable-method = "psci";
 			power-domains = <&CPU_PD1>;
 			power-domain-names = "psci";
@@ -60,6 +62,7 @@ CPU2: cpu@200 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a55";
 			reg = <0x0 0x200>;
+			clocks = <&cpufreq_hw 0>;
 			enable-method = "psci";
 			power-domains = <&CPU_PD2>;
 			power-domain-names = "psci";
@@ -75,6 +78,7 @@ CPU3: cpu@300 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a55";
 			reg = <0x0 0x300>;
+			clocks = <&cpufreq_hw 0>;
 			enable-method = "psci";
 			power-domains = <&CPU_PD3>;
 			power-domain-names = "psci";
@@ -1312,6 +1316,7 @@ cpufreq_hw: cpufreq@17d90000 {
 			clocks = <&rpmhcc RPMH_CXO_CLK>, <&gcc GCC_GPLL0>;
 			clock-names = "xo", "alternate";
 			#freq-domain-cells = <1>;
+			#clock-cells = <1>;
 		};
 
 		gem_noc: interconnect@19100000 {
-- 
2.25.1

