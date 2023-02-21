Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5CAC69E30F
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 16:06:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234439AbjBUPF6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 10:05:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234436AbjBUPFz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 10:05:55 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4E2CB763
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 07:05:53 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id o14so3808624wms.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 07:05:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l1i149aTLNTOLkmkyvTEcAaXgMJdiI2YD/KUpWRXaaA=;
        b=nZImdhglNUEScK1GjzBwIFIncyE6SLWbEYg5kAfxR5dt/o6o3T53UL11KPwyLmN1Bs
         ebCn35FX8cxCiSk8xT7aSiaL+r2C3tY2si8M+bLoP7Pjrx042y/pFpAMj00Kyzi9dLIr
         N/V3qjYZTmP7jEO8Jyxb/Zvvsb3Hkz0bM/yGP/tuO3vldxIrUmONOBO5CSZY19CbdzBo
         zGyZDidXxOmxH2DVSG56Lf4G7bD3oudCYtJtR8yql76sQOWET1YsUIdKzeE4nzIVR56n
         WLLNElor9meGT8lXFAzeCP/1oWTNeXJ70lmNoU2JzogbX/hZDx/qyUT6MBdMO5H+rqfE
         eTUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l1i149aTLNTOLkmkyvTEcAaXgMJdiI2YD/KUpWRXaaA=;
        b=TKf1jnsWuHqgQKGRpTStmLYS1NXCTndUQWPRtTHdUKuEOV1aX1RRtuunfYLSH1Z7c4
         1oMlZXxzSwcuDwxWYFrQB6GmVqNZaOeY5VUBFiC42iOgsRD9nb9SEuzL+OoyWPUkg9Iv
         ffLZq/h3QtGWuiTZePUFwlJGxXNdiD3OiAD+GtTU89223I+igZbdqdJn8e6uL05rFRnd
         dyha7XtgU4oLF6IuXrSZf7xVhKEhIDFS8PtzzguRM+aeqvcuuzEMJxGbGC0vmyF9ZGFl
         ffhmJPjnQjjbA+GNtBS0ZXak6mXHEDtcOv3cwlpLEV3+RIBzrjGMisUwsU+TpUTIXws1
         iJBg==
X-Gm-Message-State: AO0yUKUDVdEIFyqKA0lzESHl6PhJwNWdsWWp+80JcoyyfJqla4R6jW+6
        R0vdnrup5UTUlk13ApyX0wt8gA==
X-Google-Smtp-Source: AK7set8Ntvu4HilU/sI4URZx0iaMNEdxXnAvFGiSMkOuQcwlad5ePdFRr1QT6eVqPEY8Zy7uXc4BjQ==
X-Received: by 2002:a05:600c:448a:b0:3e1:97d:612e with SMTP id e10-20020a05600c448a00b003e1097d612emr9154458wmo.29.1676991952314;
        Tue, 21 Feb 2023 07:05:52 -0800 (PST)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:4c24:722f:312a:76c4])
        by smtp.gmail.com with ESMTPSA id n30-20020a05600c3b9e00b003e206cc7237sm5331687wms.24.2023.02.21.07.05.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Feb 2023 07:05:51 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH 2/2] arm64: dts: qcom: sa8775p: add cpufreq node
Date:   Tue, 21 Feb 2023 16:05:43 +0100
Message-Id: <20230221150543.283487-3-brgl@bgdev.pl>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230221150543.283487-1-brgl@bgdev.pl>
References: <20230221150543.283487-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Add a node for the cpufreq engine and specify the frequency domains for
all CPUs.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 arch/arm64/boot/dts/qcom/sa8775p.dtsi | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sa8775p.dtsi b/arch/arm64/boot/dts/qcom/sa8775p.dtsi
index ce5976e36aee..5e2bc67b3178 100644
--- a/arch/arm64/boot/dts/qcom/sa8775p.dtsi
+++ b/arch/arm64/boot/dts/qcom/sa8775p.dtsi
@@ -37,6 +37,7 @@ CPU0: cpu@0 {
 			compatible = "qcom,kryo";
 			reg = <0x0 0x0>;
 			enable-method = "psci";
+			qcom,freq-domain = <&cpufreq_hw 0>;
 			next-level-cache = <&L2_0>;
 			L2_0: l2-cache {
 				compatible = "cache";
@@ -52,6 +53,7 @@ CPU1: cpu@100 {
 			compatible = "qcom,kryo";
 			reg = <0x0 0x100>;
 			enable-method = "psci";
+			qcom,freq-domain = <&cpufreq_hw 0>;
 			next-level-cache = <&L2_1>;
 			L2_1: l2-cache {
 				compatible = "cache";
@@ -64,6 +66,7 @@ CPU2: cpu@200 {
 			compatible = "qcom,kryo";
 			reg = <0x0 0x200>;
 			enable-method = "psci";
+			qcom,freq-domain = <&cpufreq_hw 0>;
 			next-level-cache = <&L2_2>;
 			L2_2: l2-cache {
 				compatible = "cache";
@@ -76,6 +79,7 @@ CPU3: cpu@300 {
 			compatible = "qcom,kryo";
 			reg = <0x0 0x300>;
 			enable-method = "psci";
+			qcom,freq-domain = <&cpufreq_hw 0>;
 			next-level-cache = <&L2_3>;
 			L2_3: l2-cache {
 				compatible = "cache";
@@ -88,6 +92,7 @@ CPU4: cpu@10000 {
 			compatible = "qcom,kryo";
 			reg = <0x0 0x10000>;
 			enable-method = "psci";
+			qcom,freq-domain = <&cpufreq_hw 1>;
 			next-level-cache = <&L2_4>;
 			L2_4: l2-cache {
 				compatible = "cache";
@@ -104,6 +109,7 @@ CPU5: cpu@10100 {
 			compatible = "qcom,kryo";
 			reg = <0x0 0x10100>;
 			enable-method = "psci";
+			qcom,freq-domain = <&cpufreq_hw 1>;
 			next-level-cache = <&L2_5>;
 			L2_5: l2-cache {
 				compatible = "cache";
@@ -116,6 +122,7 @@ CPU6: cpu@10200 {
 			compatible = "qcom,kryo";
 			reg = <0x0 0x10200>;
 			enable-method = "psci";
+			qcom,freq-domain = <&cpufreq_hw 1>;
 			next-level-cache = <&L2_6>;
 			L2_6: l2-cache {
 				compatible = "cache";
@@ -128,6 +135,7 @@ CPU7: cpu@10300 {
 			compatible = "qcom,kryo";
 			reg = <0x0 0x10300>;
 			enable-method = "psci";
+			qcom,freq-domain = <&cpufreq_hw 1>;
 			next-level-cache = <&L2_7>;
 			L2_7: l2-cache {
 				compatible = "cache";
@@ -731,6 +739,19 @@ tcsr_mutex: hwlock@1f40000 {
 			#hwlock-cells = <1>;
 		};
 
+		cpufreq_hw: cpufreq@18591000 {
+			compatible = "qcom,sa8775p-cpufreq-epss",
+				     "qcom,cpufreq-epss";
+			reg = <0x0 0x18591000 0x0 0x1000>,
+			      <0x0 0x18593000 0x0 0x1000>;
+			reg-names = "freq-domain0", "freq-domain1";
+
+			clocks = <&rpmhcc RPMH_CXO_CLK>, <&gcc GCC_GPLL0>;
+			clock-names = "xo", "alternate";
+
+			#freq-domain-cells = <1>;
+		};
+
 		tlmm: pinctrl@f000000 {
 			compatible = "qcom,sa8775p-tlmm";
 			reg = <0x0 0xf000000 0x0 0x1000000>;
-- 
2.37.2

