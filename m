Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7030A6B8CB8
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 09:13:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229765AbjCNIL1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 04:11:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230174AbjCNIKz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 04:10:55 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 452848C0F2
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 01:09:27 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id y4so29000891edo.2
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 01:09:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678781362;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XiYe59K/JW84fiGlU+Xr8BHz4mzNfyCUd0UP7U7R+9g=;
        b=Oqor/XJwqHibojde+FBDU2dTKkGRM+AcLI0oYDIN/DgzIWQ5rw1+huz5c373gjSDsO
         KObw4HLJKYSIEEpyhG4Bf7cHBMpJkAtGAoakGBj/jme3m3j1xjW/5MJlIl5EtjyR+mfz
         go1pCH9nWTxkvBRy4nI13VqGPdUObPeAo1sL+AEurNH7DntfAGgx9I7G5q2XbKeKtOP0
         kZxHjsZcDSPMKGxDXPhVAYQnGtikHJ/XroxP1cHO1su9u57vn+j2M5F8Lvvva5iithZ4
         Ur49KgvTMta/KWMODxSyHGHYwUV/+xI5AGa7TaxlCJ4BtJxyRJNS9ny8M4swR8YurlS5
         jPgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678781362;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XiYe59K/JW84fiGlU+Xr8BHz4mzNfyCUd0UP7U7R+9g=;
        b=Lul/Ah/ND1DRdHQhZnAMlKuNkOfHNorLXS8YT3NRe+8KaN3NuwSIx+mWh/HeaWMUoS
         dqZ6yVo/kk+qXnt6esaahuPfJQO1+qHUj6rR1//1ml+0aKyGac+jWIHSu04jiQn+Etm5
         E0qGp9qcxReSFrwBli1cjYK7YD4/3UzlzU67XQZfDmJHzdTgrL1f/O4KekzQVc99d9lt
         WFaWHN424g1XHNUfDcr4L+KgIRhB6DDNalVWFTKJv8I0Dx2p4u/eEMD4FOGxprCED4Uj
         9ZclM+adkwWclkpigTPDX0SiO5tyjtr61uARiGXST/z3NxDwag3XGOoiTbdp9mxXrUTj
         Gr8g==
X-Gm-Message-State: AO0yUKW1ZOZCiGO7D2uaLm8EpraH2fj/arFgH5kFI9afRPGk2JMNinAC
        hOxcdl7pvf8eCsgh4ujYt48how==
X-Google-Smtp-Source: AK7set+LlV5CIyiauVOMC8t3dQe7Rg9cos5bcrkS51O2YfnuFIJ3dELTYBBXuTqJ5VVhAjSFk/QYzw==
X-Received: by 2002:a17:906:9acf:b0:8b1:756c:1a30 with SMTP id ah15-20020a1709069acf00b008b1756c1a30mr1473562ejc.59.1678781362458;
        Tue, 14 Mar 2023 01:09:22 -0700 (PDT)
Received: from krzk-bin.. ([2a02:810d:15c0:828:6932:5570:6254:9edd])
        by smtp.gmail.com with ESMTPSA id co2-20020a0564020c0200b004fce9ff4830sm584872edb.88.2023.03.14.01.09.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Mar 2023 01:09:22 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2 03/13] dt-bindings: mailbox: qcom,apcs-kpss-global: use fallbacks
Date:   Tue, 14 Mar 2023 09:09:07 +0100
Message-Id: <20230314080917.68246-4-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230314080917.68246-1-krzysztof.kozlowski@linaro.org>
References: <20230314080917.68246-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rework the compatibles and group devices which have similar interface
(same from Linux driver point of view) as compatible.  This allows
smaller of_device_id table in the Linux driver and smaller
allOf:if:then: constraints.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../mailbox/qcom,apcs-kpss-global.yaml        | 58 ++++++++++---------
 1 file changed, 31 insertions(+), 27 deletions(-)

diff --git a/Documentation/devicetree/bindings/mailbox/qcom,apcs-kpss-global.yaml b/Documentation/devicetree/bindings/mailbox/qcom,apcs-kpss-global.yaml
index 4d2f408a5efb..792778924eb3 100644
--- a/Documentation/devicetree/bindings/mailbox/qcom,apcs-kpss-global.yaml
+++ b/Documentation/devicetree/bindings/mailbox/qcom,apcs-kpss-global.yaml
@@ -19,32 +19,46 @@ properties:
       - items:
           - enum:
               - qcom,ipq5332-apcs-apps-global
+              - qcom,ipq8074-apcs-apps-global
           - const: qcom,ipq6018-apcs-apps-global
       - items:
           - enum:
-              - qcom,ipq6018-apcs-apps-global
-              - qcom,ipq8074-apcs-apps-global
-              - qcom,msm8996-apcs-hmss-global
+              - qcom,msm8939-apcs-kpss-global
+              - qcom,qcs404-apcs-apps-global
+          - const: qcom,msm8916-apcs-kpss-global
+          - const: syscon
+      - items:
+          - enum:
+              - qcom,msm8976-apcs-kpss-global
+          - const: qcom,msm8994-apcs-kpss-global
+          - const: syscon
+      - items:
+          - enum:
               - qcom,msm8998-apcs-hmss-global
               - qcom,qcm2290-apcs-hmss-global
-              - qcom,sc7180-apss-shared
-              - qcom,sc8180x-apss-shared
               - qcom,sdm660-apcs-hmss-global
-              - qcom,sdm845-apss-shared
               - qcom,sm4250-apcs-hmss-global
-              - qcom,sm6125-apcs-hmss-global
               - qcom,sm6115-apcs-hmss-global
+              - qcom,sm6125-apcs-hmss-global
+          - const: qcom,msm8994-apcs-kpss-global
+      - items:
+          - enum:
+              - qcom,sc7180-apss-shared
+              - qcom,sc8180x-apss-shared
               - qcom,sm8150-apss-shared
+          - const: qcom,sdm845-apss-shared
       - items:
           - enum:
               - qcom,msm8916-apcs-kpss-global
-              - qcom,msm8939-apcs-kpss-global
               - qcom,msm8953-apcs-kpss-global
-              - qcom,msm8976-apcs-kpss-global
               - qcom,msm8994-apcs-kpss-global
-              - qcom,qcs404-apcs-apps-global
               - qcom,sdx55-apcs-gcc
           - const: syscon
+      - enum:
+          - qcom,ipq6018-apcs-apps-global
+          - qcom,msm8996-apcs-hmss-global
+          - qcom,sdm845-apss-shared
+
   reg:
     maxItems: 1
 
@@ -74,10 +88,9 @@ allOf:
   - if:
       properties:
         compatible:
-          enum:
-            - qcom,msm8916-apcs-kpss-global
-            - qcom,msm8939-apcs-kpss-global
-            - qcom,qcs404-apcs-apps-global
+          contains:
+            enum:
+              - qcom,msm8916-apcs-kpss-global
     then:
       properties:
         clocks:
@@ -88,6 +101,7 @@ allOf:
           items:
             - const: pll
             - const: aux
+
   - if:
       properties:
         compatible:
@@ -106,13 +120,13 @@ allOf:
             - const: ref
             - const: pll
             - const: aux
+
   - if:
       properties:
         compatible:
           contains:
             enum:
               - qcom,ipq6018-apcs-apps-global
-              - qcom,ipq8074-apcs-apps-global
     then:
       properties:
         clocks:
@@ -129,19 +143,9 @@ allOf:
         compatible:
           enum:
             - qcom,msm8953-apcs-kpss-global
-            - qcom,msm8976-apcs-kpss-global
             - qcom,msm8994-apcs-kpss-global
             - qcom,msm8996-apcs-hmss-global
-            - qcom,msm8998-apcs-hmss-global
-            - qcom,qcm2290-apcs-hmss-global
-            - qcom,sc7180-apss-shared
-            - qcom,sc8180x-apss-shared
-            - qcom,sdm660-apcs-hmss-global
             - qcom,sdm845-apss-shared
-            - qcom,sm4250-apcs-hmss-global
-            - qcom,sm6115-apcs-hmss-global
-            - qcom,sm6125-apcs-hmss-global
-            - qcom,sm8150-apss-shared
     then:
       properties:
         clocks: false
@@ -153,7 +157,6 @@ allOf:
           contains:
             enum:
               - qcom,ipq6018-apcs-apps-global
-              - qcom,ipq8074-apcs-apps-global
     then:
       properties:
         '#clock-cells':
@@ -188,7 +191,8 @@ examples:
     #define GCC_APSS_AHB_CLK_SRC  1
     #define GCC_GPLL0_AO_OUT_MAIN 123
     apcs: mailbox@b011000 {
-        compatible = "qcom,qcs404-apcs-apps-global", "syscon";
+        compatible = "qcom,qcs404-apcs-apps-global",
+                     "qcom,msm8916-apcs-kpss-global", "syscon";
         reg = <0x0b011000 0x1000>;
         #mbox-cells = <1>;
         clocks = <&apcs_hfpll>, <&gcc GCC_GPLL0_AO_OUT_MAIN>;
-- 
2.34.1

