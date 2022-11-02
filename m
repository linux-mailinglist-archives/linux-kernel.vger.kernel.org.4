Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BA4D615DEF
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 09:38:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230462AbiKBIiW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 04:38:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230440AbiKBIiO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 04:38:14 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C2C824F25
        for <linux-kernel@vger.kernel.org>; Wed,  2 Nov 2022 01:38:13 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id l2so15885651pld.13
        for <linux-kernel@vger.kernel.org>; Wed, 02 Nov 2022 01:38:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jQnAjVM8KfWMqcwU3yG9m91ABhfRemXy71C0Mul10HU=;
        b=BI5z3t5yh+o/6QROXQ6AMqcln1aDKa4g86WvBaWv08SoJh/CN4rpQJxusRiuGqubs3
         0WKp/NDTUz2/m4GvxtOKJybTLZBtjcCpjj2xkSoaqzwHfLROyh4mIRqDiuEPWkeSsBJz
         mJ0WEEO7xVScBm9QejSv5iKbaDFRPnEY+LhjOrEGX4V9nOd91nFhC95M0GNBinOthfQA
         bdH9/BADrpnxUJTwYvjk2RDtf+NFSc3pPYzZs48nYMYxMoj+2vXn6IY4Yb39O1nt+p9A
         tr6pOV3jUfPvwEL2quP5wv98BXGLmipv9MQoUzIWqMTRMMEMsGTJcY8Ysrf5YeuUYfB+
         tdCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jQnAjVM8KfWMqcwU3yG9m91ABhfRemXy71C0Mul10HU=;
        b=G4xY9r1x4UjPKrFUGMiOF8vSe2jadVf8wB8o3d9bwTonoDvSnNYDF/pTJLEO9VAgZ+
         bf3AxrpSnxVeM6F/YaOBb12BjuzPHgW8hNiMD36wz1BhA4R5YhrYq9zIC21CMPbG8uM/
         XCX28gdvEAo0zAYo6WFuSz3lkZd7F0GcabDRMT0FurDYv8tOd0mcj6XUi0yT0N7kN32C
         Ya7LSGHybYi3GygWuO/D33COI8fdhXvIdNvF41iNK8GEWlYCNES4WhHNGMurpV7Dwc6p
         V15GDhP4LMc2C/qzwjhoEBoK4uhx9dr/eWylCAL4ERLDwcjDKiKtYPy2iovMw4zjNKyF
         8lLw==
X-Gm-Message-State: ACrzQf0sv/UQHh5eKl82EDMHaV8pgCEOuUA13EwkfaWA7SgsKIsYIwn7
        AOiq4wthPa0xWzTSyKnIOHEs
X-Google-Smtp-Source: AMsMyM77dg5YxTTvjtwAYBd+pJTnRDwtud450+37wTGwfMoZBBFV0IUkYDuLrrWRee0lywU00ZFaSw==
X-Received: by 2002:a17:90b:1bc1:b0:213:e2af:b1f4 with SMTP id oa1-20020a17090b1bc100b00213e2afb1f4mr15165846pjb.47.1667378292730;
        Wed, 02 Nov 2022 01:38:12 -0700 (PDT)
Received: from localhost.localdomain ([117.193.209.178])
        by smtp.gmail.com with ESMTPSA id x19-20020aa79573000000b0056bcb102e7bsm7887770pfq.68.2022.11.02.01.38.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Nov 2022 01:38:11 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     andersson@kernel.org, viresh.kumar@linaro.org,
        krzysztof.kozlowski+dt@linaro.org, rafael@kernel.org,
        robh+dt@kernel.org
Cc:     johan@kernel.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v3 1/3] dt-bindings: cpufreq: cpufreq-qcom-hw: Add cpufreq clock provider
Date:   Wed,  2 Nov 2022 14:07:49 +0530
Message-Id: <20221102083751.56330-2-manivannan.sadhasivam@linaro.org>
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
to the CPU cores. Document the same in the binding to reflect the actual
implementation.

CPUFreq HW will become the clock provider and CPU cores will become the
clock consumers.

The clock index for each CPU core is based on the frequency domain index.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml b/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml
index cbba8979fe0e..2e0336163ffb 100644
--- a/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml
+++ b/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml
@@ -57,6 +57,9 @@ properties:
   '#freq-domain-cells':
     const: 1
 
+  '#clock-cells':
+    const: 1
+
 required:
   - compatible
   - reg
@@ -84,6 +87,7 @@ examples:
         enable-method = "psci";
         next-level-cache = <&L2_0>;
         qcom,freq-domain = <&cpufreq_hw 0>;
+        clocks = <&cpufreq_hw 0>;
         L2_0: l2-cache {
           compatible = "cache";
           next-level-cache = <&L3_0>;
@@ -100,6 +104,7 @@ examples:
         enable-method = "psci";
         next-level-cache = <&L2_100>;
         qcom,freq-domain = <&cpufreq_hw 0>;
+        clocks = <&cpufreq_hw 0>;
         L2_100: l2-cache {
           compatible = "cache";
           next-level-cache = <&L3_0>;
@@ -113,6 +118,7 @@ examples:
         enable-method = "psci";
         next-level-cache = <&L2_200>;
         qcom,freq-domain = <&cpufreq_hw 0>;
+        clocks = <&cpufreq_hw 0>;
         L2_200: l2-cache {
           compatible = "cache";
           next-level-cache = <&L3_0>;
@@ -126,6 +132,7 @@ examples:
         enable-method = "psci";
         next-level-cache = <&L2_300>;
         qcom,freq-domain = <&cpufreq_hw 0>;
+        clocks = <&cpufreq_hw 0>;
         L2_300: l2-cache {
           compatible = "cache";
           next-level-cache = <&L3_0>;
@@ -139,6 +146,7 @@ examples:
         enable-method = "psci";
         next-level-cache = <&L2_400>;
         qcom,freq-domain = <&cpufreq_hw 1>;
+        clocks = <&cpufreq_hw 1>;
         L2_400: l2-cache {
           compatible = "cache";
           next-level-cache = <&L3_0>;
@@ -152,6 +160,7 @@ examples:
         enable-method = "psci";
         next-level-cache = <&L2_500>;
         qcom,freq-domain = <&cpufreq_hw 1>;
+        clocks = <&cpufreq_hw 1>;
         L2_500: l2-cache {
           compatible = "cache";
           next-level-cache = <&L3_0>;
@@ -165,6 +174,7 @@ examples:
         enable-method = "psci";
         next-level-cache = <&L2_600>;
         qcom,freq-domain = <&cpufreq_hw 1>;
+        clocks = <&cpufreq_hw 1>;
         L2_600: l2-cache {
           compatible = "cache";
           next-level-cache = <&L3_0>;
@@ -178,6 +188,7 @@ examples:
         enable-method = "psci";
         next-level-cache = <&L2_700>;
         qcom,freq-domain = <&cpufreq_hw 1>;
+        clocks = <&cpufreq_hw 1>;
         L2_700: l2-cache {
           compatible = "cache";
           next-level-cache = <&L3_0>;
@@ -198,6 +209,7 @@ examples:
         clock-names = "xo", "alternate";
 
         #freq-domain-cells = <1>;
+        #clock-cells = <1>;
       };
     };
 ...
-- 
2.25.1

