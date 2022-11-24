Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 618B5637F39
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 19:44:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229946AbiKXSon (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 13:44:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229938AbiKXSoQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 13:44:16 -0500
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19E4B12F429
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 10:43:57 -0800 (PST)
Received: by mail-lj1-x234.google.com with SMTP id q7so2830820ljp.9
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 10:43:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h7Ovu2dQSWjj+PMtEiS086lrhl+cBObJWo88HoZZPz0=;
        b=NlQa0yimv+aayQe08WqHkEOJ5WuOAqW50BgQfAn/IWceRrK31Ek80SUc6zYVOq27UW
         mzjIjVTsgnX8Xrk7zqGwpm6kMLiU/476IcR1tttSYd/F+qXY7ZHDFPI9VKJ67ArtOQrR
         ZLSgN1hTScHMbOHLfKndv/2xzx3aD6T8prtC9PJbyEDRv/FtetWXnx9RW4nAQ4Irl/oO
         CSlVsnUaH2DUkcLt3ciumCG4PBhEYdqnEXY0J8RFTdoRjOHBvHVUgc+YS1oRXtU38idc
         aj6CrV4mj0avlajifEDaNnGd2qOtJHnJx8JSTV/nqqI3oXrelb/UY5gsUdPLnymb3UpB
         bJwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h7Ovu2dQSWjj+PMtEiS086lrhl+cBObJWo88HoZZPz0=;
        b=0vA9kNygkckD8HfJkcAFIkh8F2/TUC5Yp6dzMYhoOSwvsMvCWm+iKAHMb73eaqxNnJ
         mKevR65514wGFt6owh8/KMPcqUlv+8EZmPQDjcSgnn4ijNkbo0Z12Sj/505STuCVP+jn
         jhM1vJK18UI3KmC+dovfcWdNSCUrC9QW/UIfhAzFY60aYFb5RsRfYpozTbb1jF2BnONA
         Pg7TF1paK5T/vXWXwRbJvCQ0vRd/fpG+/muac/Jp50FLVDk6Ae5hzF0V5lHsqPwIOhKi
         3DDfpDao0ZWnJFWVZTrZ003AP5N7++MHfjeWyhxSwAm4hrtiy9Klv1bjU+samWUn9Rge
         sDUw==
X-Gm-Message-State: ANoB5plQwXkPK8nGfMLdRBiK8h78tgewoPQvYR8rGAgfT23R8BMLEP94
        ArnVw8y3QdBGZoZjobg6hBHUng==
X-Google-Smtp-Source: AA0mqf6+n/uIv6RhQ9/6RcnsBq6UkRWNwq6almJKc0AV70Zep9OZu2TkD9lH4LdQNXhap+lK9IPLqw==
X-Received: by 2002:a2e:be8b:0:b0:278:ea67:a38c with SMTP id a11-20020a2ebe8b000000b00278ea67a38cmr5015842ljr.63.1669315436597;
        Thu, 24 Nov 2022 10:43:56 -0800 (PST)
Received: from krzk-bin.NAT.warszawa.vectranet.pl (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id v7-20020a2ea607000000b0026e0434eb1esm159098ljp.67.2022.11.24.10.43.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Nov 2022 10:43:56 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v3 11/15] dt-bindings: remoteproc: qcom,sc8180x-pas: split into separate file
Date:   Thu, 24 Nov 2022 19:43:29 +0100
Message-Id: <20221124184333.133911-12-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221124184333.133911-1-krzysztof.kozlowski@linaro.org>
References: <20221124184333.133911-1-krzysztof.kozlowski@linaro.org>
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

Split SC8180x remote processor Peripheral Authentication Service bindings
into their own file to reduce complexity and make maintenance easier.

The binding is incomplete due to lack of upstreamed DTS - no example and
not all power domains defined.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Changes since v2:
1. Drop if:then: for the clock and put it directly under properties.
2. Merge two if:then: clauses for setting interrupts.

Changes since v1:
1. New patch.
---
 .../bindings/remoteproc/qcom,adsp.yaml        | 27 ------
 .../bindings/remoteproc/qcom,sc8180x-pas.yaml | 87 +++++++++++++++++++
 2 files changed, 87 insertions(+), 27 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/remoteproc/qcom,sc8180x-pas.yaml

diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,adsp.yaml b/Documentation/devicetree/bindings/remoteproc/qcom,adsp.yaml
index 67a68a8edc44..7b93064fa0ae 100644
--- a/Documentation/devicetree/bindings/remoteproc/qcom,adsp.yaml
+++ b/Documentation/devicetree/bindings/remoteproc/qcom,adsp.yaml
@@ -27,9 +27,6 @@ properties:
       - qcom,qcs404-wcss-pas
       - qcom,sc7180-mpss-pas
       - qcom,sc7280-mpss-pas
-      - qcom,sc8180x-adsp-pas
-      - qcom,sc8180x-cdsp-pas
-      - qcom,sc8180x-mpss-pas
       - qcom,sdm660-adsp-pas
       - qcom,sdm845-adsp-pas
       - qcom,sdm845-cdsp-pas
@@ -70,9 +67,6 @@ allOf:
               - qcom,qcs404-wcss-pas
               - qcom,sc7180-mpss-pas
               - qcom,sc7280-mpss-pas
-              - qcom,sc8180x-adsp-pas
-              - qcom,sc8180x-cdsp-pas
-              - qcom,sc8180x-mpss-pas
               - qcom,sdm845-adsp-pas
               - qcom,sdm845-cdsp-pas
     then:
@@ -115,8 +109,6 @@ allOf:
               - qcom,qcs404-adsp-pas
               - qcom,qcs404-cdsp-pas
               - qcom,qcs404-wcss-pas
-              - qcom,sc8180x-adsp-pas
-              - qcom,sc8180x-cdsp-pas
               - qcom,sdm845-adsp-pas
               - qcom,sdm845-cdsp-pas
     then:
@@ -133,7 +125,6 @@ allOf:
             enum:
               - qcom,sc7180-mpss-pas
               - qcom,sc7280-mpss-pas
-              - qcom,sc8180x-mpss-pas
               - qcom,sdx55-mpss-pas
     then:
       properties:
@@ -224,24 +215,6 @@ allOf:
             - const: cx
             - const: mss
 
-  - if:
-      properties:
-        compatible:
-          contains:
-            enum:
-              - qcom,sc8180x-adsp-pas
-              - qcom,sc8180x-cdsp-pas
-    then:
-      properties:
-        power-domains:
-          items:
-            - description: LCX power domain
-            - description: LMX power domain
-        power-domain-names:
-          items:
-            - const: lcx
-            - const: lmx
-
   - if:
       properties:
         compatible:
diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,sc8180x-pas.yaml b/Documentation/devicetree/bindings/remoteproc/qcom,sc8180x-pas.yaml
new file mode 100644
index 000000000000..3026cfde5582
--- /dev/null
+++ b/Documentation/devicetree/bindings/remoteproc/qcom,sc8180x-pas.yaml
@@ -0,0 +1,87 @@
+# SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/remoteproc/qcom,sc8180x-pas.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm SC8180X Peripheral Authentication Service
+
+maintainers:
+  - Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
+
+description:
+  Qualcomm SC8180X SoC Peripheral Authentication Service loads and boots
+  firmware on the Qualcomm DSP Hexagon cores.
+
+properties:
+  compatible:
+    enum:
+      - qcom,sc8180x-adsp-pas
+      - qcom,sc8180x-cdsp-pas
+      - qcom,sc8180x-mpss-pas
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    items:
+      - description: XO clock
+
+  clock-names:
+    items:
+      - const: xo
+
+  qcom,qmp:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description: Reference to the AOSS side-channel message RAM.
+
+  smd-edge: false
+
+required:
+  - compatible
+  - reg
+
+allOf:
+  - $ref: /schemas/remoteproc/qcom,pas-common.yaml#
+  - if:
+      properties:
+        compatible:
+          enum:
+            - qcom,sc8180x-adsp-pas
+            - qcom,sc8180x-cdsp-pas
+    then:
+      properties:
+        interrupts:
+          maxItems: 5
+        interrupt-names:
+          maxItems: 5
+    else:
+      properties:
+        interrupts:
+          minItems: 6
+        interrupt-names:
+          minItems: 6
+
+  - if:
+      properties:
+        compatible:
+          enum:
+            - qcom,sc8180x-adsp-pas
+            - qcom,sc8180x-cdsp-pas
+    then:
+      properties:
+        power-domains:
+          items:
+            - description: LCX power domain
+            - description: LMX power domain
+        power-domain-names:
+          items:
+            - const: lcx
+            - const: lmx
+    else:
+      properties:
+        # TODO: incomplete
+        power-domains: false
+        power-domain-names: false
+
+unevaluatedProperties: false
-- 
2.34.1

