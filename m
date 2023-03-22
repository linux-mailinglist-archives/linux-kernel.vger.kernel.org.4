Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A519D6C52C3
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 18:42:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230238AbjCVRl7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 13:41:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230171AbjCVRl4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 13:41:56 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79BD65F6FA
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 10:41:54 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id o12so76139606edb.9
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 10:41:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679506913;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J7HvLHiM0yNYVR94aOydsK2tw/ZrP3jrkkPekAOv51g=;
        b=GZvF2cNEbd5qaVApCSOIZ82OiRHJYd2LczLtSLFYVHP5Wn7lH0PUdA7OeADEZlEi7x
         rF1pH4yC1mNtvCUQbrOFtSbWZQ+tHy3fVZ0lnDxKJaxGedHBNk/LuVGExHaMQC9+wSZQ
         h0OEkYtzeOUcPYEgEhmX3Z0kxyabISOhQgXSU7swbx8fq+5Qt1PisD/MVY6QpKO2oiUr
         AdXidgMu5Y0YwILtTM84tqqvhHVSmC+lQlxPa/rAUn0dzaLjpLCE9ZTwVpYPIZ+/cr37
         tkR91i2WOgf8hzj/KF+xlKV/Kw6EBBt3o4wz7sgUA2tXZV5nLrk9BrBNXMRSNydg8DnO
         EGjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679506913;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J7HvLHiM0yNYVR94aOydsK2tw/ZrP3jrkkPekAOv51g=;
        b=PYI5uEErOOqWI/VIafzBfWSdXD5D17g6QJYt0NmXXUL137N9k5UT6olhTTdHDo+gBB
         bF/pU6tgFlaSCcMvNX8UeIRHkySIQcxsXtMcbkQVgx5Lq0E1UptoCMXUF2LrtrLXNLBa
         /TV9+BhV3C9mi4zJdXmzewvL6JhxHlEgvMJvbqJUrK1gE9IhMWECazAVeo4ZoMhL78O2
         M0Z5zHZ8JmF8araZ7oK8pWWu5Ah2ZqwPmrG0PxONgvgZstOwUQLNoSttMaZe4Uwm/SGs
         9u+yEZyq4KBCJobIZeNcEx7SaqMV6N6U7B0nGNZJVe4ks2n4463WgsWMkXjpYoB/H4o1
         uQyw==
X-Gm-Message-State: AO0yUKWep3pdg20i5thjKqPuNKMHK3s+TeschpzgHvkRi/XD4n0hL73H
        Lg3IxMOZHDNJsBOSNQuo8AD0wTaIriyQzNTtiZA=
X-Google-Smtp-Source: AK7set8Qqg/m7sdwIgjryhOkmY8jcPoyODI+I9mg0UQifuIq5KlCNLLRUuC/Ss7ttCwDhznmt7KfTg==
X-Received: by 2002:a17:907:100b:b0:8f6:88b7:73a7 with SMTP id ox11-20020a170907100b00b008f688b773a7mr2909465ejb.7.1679506912987;
        Wed, 22 Mar 2023 10:41:52 -0700 (PDT)
Received: from krzk-bin.. ([2a02:810d:15c0:828:5050:151b:e755:1c6])
        by smtp.gmail.com with ESMTPSA id jx3-20020a170907760300b00930876176e2sm7548088ejc.29.2023.03.22.10.41.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Mar 2023 10:41:52 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v3 01/11] dt-bindings: mailbox: qcom,apcs-kpss-global: use fallbacks
Date:   Wed, 22 Mar 2023 18:41:38 +0100
Message-Id: <20230322174148.810938-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230322174148.810938-1-krzysztof.kozlowski@linaro.org>
References: <20230322174148.810938-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
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
Acked-by: Rob Herring <robh@kernel.org>

---

Depends on:
https://lore.kernel.org/linux-arm-msm/20230322173559.809805-1-krzysztof.kozlowski@linaro.org/T/#t
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

