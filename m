Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7956B62D2BC
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 06:32:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234477AbiKQFcF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 00:32:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229658AbiKQFcC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 00:32:02 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34146554DC
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 21:32:01 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id l2so599178pld.13
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 21:32:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J2RysX7TiVCclv2UJBtgXviDFq2/T3mQypqGPEA1b7s=;
        b=RZsVifCuuHh4V2cxHmbtLYLghbm1LoZSUWYte+QctCQW1n0hXcgdQfISnQVDiXRd4d
         OTtW281b+r7/C8nkpSesqja0z3EkWcRrWujsthf3dQi+PL0wKCsll/S6gT1HTE/Ahv7S
         oPiU38AWsO9mG3YspF5IePBxZC1cK5bZgd6AfXtA73gvXJIzgWObGX5qmMXcwpabYqaD
         LJGiwb6dWfP5sXX8ac/rSCQZkzMyxASwAcH/xZP/DzMz68duHb2on/psSLpqbNum4a5w
         GYr1M8pfADMvBsAgDy7UFaPE/cn49s05qL91v6tXGr+kzJBMn5mEAJqFRQWYVOgLbDvc
         9XdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J2RysX7TiVCclv2UJBtgXviDFq2/T3mQypqGPEA1b7s=;
        b=2p//P4shsZm5AZaEYXWasd+jJmC5+dKH3Q23ZgfIUr5kOs8twsNBBRwPFVjkQu4Rd6
         IWiF59brcyEbZeeWdNpTjFOpFN7F06nFLIfQ1vtrxC2Z09w210/k74jS87/07qxvReRe
         YNEC0VmLJwcq3QBTrlOcLFPwrg47yh3Mf0p9LkZAd0gmp45uxt3C3KqBe6HFsK7kl+bF
         ELtRDoXCNklPSOePJzBAO+HWQ7tATaRTUOv73n4CoH7s8MxXAjUAee1m+9ne0PFMp3sr
         8bBbm8RuGYX3nj5Z0QZ0qkdZTEQtzOS/50tkOJHgnqI9dD/JwI0ndLwvKlSRbGEYwN6H
         3hxw==
X-Gm-Message-State: ANoB5plpJ6sNmBA0xiCpG0EXXfQw3UXcjKLJ16Zg0ykSdeSosZXAzqiU
        6kVngrZ+UtIi6ZV1ahEU3S2H
X-Google-Smtp-Source: AA0mqf6KxByoSdNPUxxW77iz8DQDSNjXZ3URm4SVhOb0yWJnDsmL1LIGuoSI/jJxNa1Wmy5cAJoPPg==
X-Received: by 2002:a17:902:d38c:b0:186:8c19:d436 with SMTP id e12-20020a170902d38c00b001868c19d436mr1245857pld.96.1668663120669;
        Wed, 16 Nov 2022 21:32:00 -0800 (PST)
Received: from localhost.localdomain ([117.193.208.31])
        by smtp.gmail.com with ESMTPSA id q4-20020a17090311c400b001865c298588sm96600plh.258.2022.11.16.21.31.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Nov 2022 21:31:59 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     andersson@kernel.org, viresh.kumar@linaro.org,
        krzysztof.kozlowski+dt@linaro.org, rafael@kernel.org,
        robh+dt@kernel.org
Cc:     johan@kernel.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v7 1/4] dt-bindings: cpufreq: cpufreq-qcom-hw: Add cpufreq clock provider
Date:   Thu, 17 Nov 2022 11:01:42 +0530
Message-Id: <20221117053145.10409-2-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221117053145.10409-1-manivannan.sadhasivam@linaro.org>
References: <20221117053145.10409-1-manivannan.sadhasivam@linaro.org>
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
index e58c55f78aaa..676d369a6fdd 100644
--- a/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml
+++ b/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml
@@ -56,6 +56,9 @@ properties:
   '#freq-domain-cells':
     const: 1
 
+  '#clock-cells':
+    const: 1
+
 required:
   - compatible
   - reg
@@ -83,6 +86,7 @@ examples:
         enable-method = "psci";
         next-level-cache = <&L2_0>;
         qcom,freq-domain = <&cpufreq_hw 0>;
+        clocks = <&cpufreq_hw 0>;
         L2_0: l2-cache {
           compatible = "cache";
           cache-unified;
@@ -103,6 +107,7 @@ examples:
         enable-method = "psci";
         next-level-cache = <&L2_100>;
         qcom,freq-domain = <&cpufreq_hw 0>;
+        clocks = <&cpufreq_hw 0>;
         L2_100: l2-cache {
           compatible = "cache";
           cache-unified;
@@ -118,6 +123,7 @@ examples:
         enable-method = "psci";
         next-level-cache = <&L2_200>;
         qcom,freq-domain = <&cpufreq_hw 0>;
+        clocks = <&cpufreq_hw 0>;
         L2_200: l2-cache {
           compatible = "cache";
           cache-unified;
@@ -133,6 +139,7 @@ examples:
         enable-method = "psci";
         next-level-cache = <&L2_300>;
         qcom,freq-domain = <&cpufreq_hw 0>;
+        clocks = <&cpufreq_hw 0>;
         L2_300: l2-cache {
           compatible = "cache";
           cache-unified;
@@ -148,6 +155,7 @@ examples:
         enable-method = "psci";
         next-level-cache = <&L2_400>;
         qcom,freq-domain = <&cpufreq_hw 1>;
+        clocks = <&cpufreq_hw 1>;
         L2_400: l2-cache {
           compatible = "cache";
           cache-unified;
@@ -163,6 +171,7 @@ examples:
         enable-method = "psci";
         next-level-cache = <&L2_500>;
         qcom,freq-domain = <&cpufreq_hw 1>;
+        clocks = <&cpufreq_hw 1>;
         L2_500: l2-cache {
           compatible = "cache";
           cache-unified;
@@ -178,6 +187,7 @@ examples:
         enable-method = "psci";
         next-level-cache = <&L2_600>;
         qcom,freq-domain = <&cpufreq_hw 1>;
+        clocks = <&cpufreq_hw 1>;
         L2_600: l2-cache {
           compatible = "cache";
           cache-unified;
@@ -193,6 +203,7 @@ examples:
         enable-method = "psci";
         next-level-cache = <&L2_700>;
         qcom,freq-domain = <&cpufreq_hw 1>;
+        clocks = <&cpufreq_hw 1>;
         L2_700: l2-cache {
           compatible = "cache";
           cache-unified;
@@ -215,6 +226,7 @@ examples:
         clock-names = "xo", "alternate";
 
         #freq-domain-cells = <1>;
+        #clock-cells = <1>;
       };
     };
 ...
-- 
2.25.1

