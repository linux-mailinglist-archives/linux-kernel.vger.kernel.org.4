Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BA0A621896
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 16:41:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234341AbiKHPlV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 10:41:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234302AbiKHPlR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 10:41:17 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E5F95C757
        for <linux-kernel@vger.kernel.org>; Tue,  8 Nov 2022 07:41:15 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id j15so21601233wrq.3
        for <linux-kernel@vger.kernel.org>; Tue, 08 Nov 2022 07:41:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cWX3PFtX+iNvvcqKHYXPbN+3ItiEZ3sX7UGhc0uTyP8=;
        b=SN/ia2UBYTbAJSUyCtsXAjcn2MGPRc+MnHdnuBTzTdHL6/hFipntDHQFMypA51YZMc
         vF969I+0TVmKTFA0XekEhBc1WvoVvgXLLoWmqOQbSslYWBwt3TzT9tnG6YLsOeLpmAIP
         9BNiwm77cxLMgrWRJCqeHkLYCLw9CfPHDFJwNpLCElBVvuCnQZWkDmCA9ytnqat7vrD/
         8lB6ehzXdQCw0cHUlHFI8Q+MrMnNZ+rI+r8HVcNfULNgFk80ceY8sRMeGADjiby7A5S4
         HaUELXxUV0DkcWvaQRPrQ5auWiXGuPLMvH9KxdyFCvessH5qFe8F2b68CFXnw84UF7vx
         SGXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cWX3PFtX+iNvvcqKHYXPbN+3ItiEZ3sX7UGhc0uTyP8=;
        b=KJ5faqLxDL7cLORdxTMNragCPMkxMGY7xgVLtOlA9oqQ6ituyP8V5b6PhwXp7FFX0i
         IGKPzo+/9JeF4/2EbFu23vOeWjFcsv7ArcaK/NZtoQyoNyO66vLlbOR2u449d055AAzX
         xqvdZvY5xAU0XOX3b2rb/3D+S4d+soMQKrTsVLqUM20hlRHDCgVBDx9SOkryC2QfJ7ws
         FBP69Ch3QLgAwozPyhQepkT9sHqdwKHxgo1IG0D1WWIgehAQOoxw22RCrcnyOrZ/ep/E
         ScHauJm2vM0NfHQ9RXade7WS7v4jcS/OKCtZgjPf8vIOcAJYQowUHBuiP6Ej2RBqzbES
         /EPg==
X-Gm-Message-State: ACrzQf0kIBs3UklZSFxaXEtkPDCuC9vc6sKEXqkwBehU0WmRuTZzuAgL
        y1Y8wWCsAzRWQ5r77G3mMr+B
X-Google-Smtp-Source: AMsMyM7EvByKFQE3Sa+3+R8HeZoJMarZqQL6BY912NFMY4JdUPyC0vTdMOrcnrpGDJM2pc7SRtQ4zg==
X-Received: by 2002:adf:e64e:0:b0:236:76a9:446 with SMTP id b14-20020adfe64e000000b0023676a90446mr36796027wrn.696.1667922074031;
        Tue, 08 Nov 2022 07:41:14 -0800 (PST)
Received: from localhost.localdomain ([117.207.25.46])
        by smtp.gmail.com with ESMTPSA id e4-20020adff344000000b002364c77bc96sm10906899wrp.33.2022.11.08.07.41.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Nov 2022 07:41:12 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     andersson@kernel.org, viresh.kumar@linaro.org,
        krzysztof.kozlowski+dt@linaro.org, rafael@kernel.org,
        robh+dt@kernel.org
Cc:     johan@kernel.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v5 2/3] arm64: dts: qcom: sm8450: Supply clock from cpufreq node to CPUs
Date:   Tue,  8 Nov 2022 21:10:36 +0530
Message-Id: <20221108154037.111794-3-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221108154037.111794-1-manivannan.sadhasivam@linaro.org>
References: <20221108154037.111794-1-manivannan.sadhasivam@linaro.org>
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

