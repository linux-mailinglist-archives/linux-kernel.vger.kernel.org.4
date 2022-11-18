Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4868962F4FA
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 13:35:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241932AbiKRMe6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 07:34:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241857AbiKRMeb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 07:34:31 -0500
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8277285A28
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 04:34:23 -0800 (PST)
Received: by mail-lj1-x232.google.com with SMTP id h12so6575154ljg.9
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 04:34:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OdC8m/lMtz6Ihsbauza6enft2sHpHF62AIG3huK1UyY=;
        b=iRKseK3E9STbfjUAfLFyVeSqlTKKGgl56HTLsofDMmhP0SG0wnEHtMhYd14kutAycd
         ii4Sn1va1I9I8ER4/jyaacUeygZc4j66Yt9TKVJ0kxltzBjHIxBA6UbnaiyeSn3p78jX
         SDfybPJ7DeHA67Uw6tbIceR643VpAHiSjP9EkuLYTrJRdElOWq9y6pQ5fBXO27dczXDN
         1rpZf32vQHtZbhLc6lP7SBM2UgzZqxk8KMQPWjrATKqI5TIDLw1BX4233S8XehiklYYF
         /MlIzdvnk+ucnAk0LYo76f0V26ExjqUfPKpDaXw7slLYbuvgTT4LHeeunksi7sgRI9WF
         Ybcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OdC8m/lMtz6Ihsbauza6enft2sHpHF62AIG3huK1UyY=;
        b=4625VT8pCdxB43gajNMHPWs1ufkAuxpgNAfLJLGOBd7sevSsUgJ6VkePUSq+RVi//D
         xEi9twEKwDjYi16WelnOo7Nbp5kfDzS9nIxKUbAK0sISxUM+mMBHSy0WhaXrMLj9ttam
         fccTr48n7IToGCln20pKUlxL5mK3UULYBQ+zW3qJPFvxrdJRxVQXPJhQoJkws4CkR8Nl
         eGFddudNVsPiCXekZ+K7/LW/BR+4gzOP9gw3ZkoFK/eaA5FqRSQGZndxdlSZ3r1dZ+wV
         68AXNMg3I9KFyoxVz29CKAgihTWSmh+Ghfwa5QM9qjLUeBEI22i4DWE9iSWolQjae9jP
         QLHg==
X-Gm-Message-State: ANoB5pmmpvF/qm8FCL62sCX1eXXWp/dr7shWqy2Aj4AI1+Wcr1mvMvuo
        YsLBQOtYiLo65z9aqbTKuERHeQ==
X-Google-Smtp-Source: AA0mqf4XfLb3zRFi8VGhsHZSw934FHdT0ZFeWn4BIVcWVEE6vZbDi2K35F4H4DS2hqLaM5Lq6zKQ5w==
X-Received: by 2002:a05:651c:2324:b0:277:64ad:383d with SMTP id bi36-20020a05651c232400b0027764ad383dmr2282966ljb.67.1668774861735;
        Fri, 18 Nov 2022 04:34:21 -0800 (PST)
Received: from krzk-bin.NAT.warszawa.vectranet.pl (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id m10-20020a19434a000000b004ac088fdfd2sm645833lfj.85.2022.11.18.04.34.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Nov 2022 04:34:21 -0800 (PST)
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
Subject: [PATCH v2 6/7] dt-bindings: remoteproc: qcom,sc8180x-pas: split into separate file
Date:   Fri, 18 Nov 2022 13:34:01 +0100
Message-Id: <20221118123402.95784-7-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221118123402.95784-1-krzysztof.kozlowski@linaro.org>
References: <20221118123402.95784-1-krzysztof.kozlowski@linaro.org>
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

Changes since v1:
1. New patch.
---
 .../bindings/remoteproc/qcom,adsp.yaml        |  27 -----
 .../bindings/remoteproc/qcom,sc8180x-pas.yaml | 101 ++++++++++++++++++
 2 files changed, 101 insertions(+), 27 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/remoteproc/qcom,sc8180x-pas.yaml

diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,adsp.yaml b/Documentation/devicetree/bindings/remoteproc/qcom,adsp.yaml
index ea2c14a2f3f9..bb7646446881 100644
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
@@ -88,9 +85,6 @@ allOf:
               - qcom,qcs404-adsp-pas
               - qcom,qcs404-wcss-pas
               - qcom,sc7280-mpss-pas
-              - qcom,sc8180x-adsp-pas
-              - qcom,sc8180x-cdsp-pas
-              - qcom,sc8180x-mpss-pas
               - qcom,sdm845-adsp-pas
               - qcom,sdm845-cdsp-pas
     then:
@@ -187,8 +181,6 @@ allOf:
               - qcom,qcs404-adsp-pas
               - qcom,qcs404-cdsp-pas
               - qcom,qcs404-wcss-pas
-              - qcom,sc8180x-adsp-pas
-              - qcom,sc8180x-cdsp-pas
               - qcom,sdm845-adsp-pas
               - qcom,sdm845-cdsp-pas
     then:
@@ -205,7 +197,6 @@ allOf:
             enum:
               - qcom,sc7180-mpss-pas
               - qcom,sc7280-mpss-pas
-              - qcom,sc8180x-mpss-pas
               - qcom,sdx55-mpss-pas
     then:
       properties:
@@ -296,24 +287,6 @@ allOf:
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
index 000000000000..f126fc862cfe
--- /dev/null
+++ b/Documentation/devicetree/bindings/remoteproc/qcom,sc8180x-pas.yaml
@@ -0,0 +1,101 @@
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
+            - qcom,sc8180x-mpss-pas
+    then:
+      properties:
+        clocks:
+          items:
+            - description: XO clock
+        clock-names:
+          items:
+            - const: xo
+
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
+
+  - if:
+      properties:
+        compatible:
+          enum:
+            - qcom,sc8180x-mpss-pas
+    then:
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

