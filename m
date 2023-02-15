Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADF326976C0
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 07:56:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233584AbjBOG4T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 01:56:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233618AbjBOG4B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 01:56:01 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DABD36097
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 22:55:47 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id nh19-20020a17090b365300b00233ceae8407so1038212pjb.3
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 22:55:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1fQsTTXBNiNhOtrjU3bWR9pOnFEJRPHEV6xz3+pJ+84=;
        b=TuwDaaE7LdnLXK4YrioiPla2vJl/aGptSMJfQtsroASSlbaVCYItee0mcNQ1uKJYNT
         vc+BSCpV08nnzIWckk4MjjKklRWV9KrUdEoVZ+B8NCn+ym3LAlRxwT6CmQElJ9w7coFX
         2C3hqFL2vEyzOOjiKANhVQE+XeoqSwT30wyQtTGna7cBSVBj0GdtMQQqE1RIMz+Bxj1T
         BPcv9EyjTl67FS44Yn1sQoXdiDNaP3ceVqau4YOaN5SOWT/1+sqvczdXtyO1EWOPrlCi
         2ni3cnJoD/382/wMCRh69c2BE8b8oA/7xQFrvngBiiP+jMJupIfMFhiuJs5Jiojtylhp
         l/xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1fQsTTXBNiNhOtrjU3bWR9pOnFEJRPHEV6xz3+pJ+84=;
        b=ifs9gPsERIsFAWBF88gST6umMr6kZ4O/P0W0JGkQuhe2VNs3rKMICXUXOUq85Z9IZJ
         a5cMvyO4Eh/YlBn3jyoUHq2WJTnmlnWpJ5dGEmGBrd8UTWe7aZNCvYSuLPnn12Lhy1OF
         MDOvCNC6QNY7Y/eIe8XojHrd0gDpl8fFd7mgsF/e7gihmxeNwhdWggWq9Mpm/8iLdb6C
         NyeCrACfKnbXstg/W5eJKW8fMRPdhNyEfzokJKOHBY/6KShJRmCcDNZMXVO3WaDPcHhn
         XVCZLDFkacwC4VOSidznJRLuOcm5G3n5e+2Wr4uWnkXDrL6oWgYKolnqsKuscpkh8R5n
         L7wg==
X-Gm-Message-State: AO0yUKVDHxY8ZK3jK9QamsXLFAvYtzIh6qBCv0G8zjjyDOrCUE/efYhc
        QRB1fJDhCiHQf5101zB3HfGB
X-Google-Smtp-Source: AK7set/iFM79DF2Ah8GqtdKVp+mgUR159zaaTrsvjm5QWYubJBlMsTfdsKxIlUkFCUCy4xVSEDJBrA==
X-Received: by 2002:a17:903:22c1:b0:19a:5958:15e7 with SMTP id y1-20020a17090322c100b0019a595815e7mr1750159plg.15.1676444146555;
        Tue, 14 Feb 2023 22:55:46 -0800 (PST)
Received: from localhost.localdomain ([117.217.179.87])
        by smtp.gmail.com with ESMTPSA id d23-20020a170902b71700b001933b4b1a49sm10276870pls.183.2023.02.14.22.55.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Feb 2023 22:55:46 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     andersson@kernel.org
Cc:     konrad.dybcio@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        viresh.kumar@linaro.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 04/12] arm64: dts: qcom: sm8550: Supply clock from cpufreq node to CPUs
Date:   Wed, 15 Feb 2023 12:25:15 +0530
Message-Id: <20230215065520.5535-5-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230215065520.5535-1-manivannan.sadhasivam@linaro.org>
References: <20230215065520.5535-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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

