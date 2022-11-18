Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0BE162F4FB
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 13:35:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241981AbiKRMfE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 07:35:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235333AbiKRMeX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 07:34:23 -0500
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDCB9239
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 04:34:19 -0800 (PST)
Received: by mail-lj1-x236.google.com with SMTP id c25so6580896ljr.8
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 04:34:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0YegXCBLmuM2Py0NZu57AkOiNX/8HjpXH+5jrnHW9s8=;
        b=AWOUwE1L0e1bLm6/p8ZRhiEREQNrkUe/Z4eH0SlGI2CIMaeFiVPiNzkGqQ3kMXHL9w
         UqOAQlojU3ogRjmjM/rUmQ3xA16XkrLDAYALXBrQrFVjk78O2HvUH8+9E6Apd/aroueV
         9AsPb2yMWzzeF5F3x1tKzYNHxRv/eq5Ot4Z8EZOuuFY9eqaIYT+OHEjg+NQEVYqsYogP
         g29TCBnltfiaE7vJHDCwExcu1JpgRBJ0RgRcsbJyDkOSJ9n2ELRlpEL4vjW2oEkYJmsc
         RxnVJMP10kCZxEIIx7NYBaM1ilZq5tYTfdghStSnd0KYXYxStzmBXlEWGYWt2TJHlHkd
         eE7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0YegXCBLmuM2Py0NZu57AkOiNX/8HjpXH+5jrnHW9s8=;
        b=a6BE9AiAmnQc3+GrM0YeCedXE3t6M/juhNttOhUlUxysL/qaFU5FMfOdY8kUnk91O8
         OgrxF40X7kcWpRW1pIibN3jqTbKc8KNvOLcxOyT3+FKToZnR8puwiXW9ibENcXc7nrdh
         xVxqAzsHvhO1rmxzJT75xZXa7OWZkYm9Z5uhhz/TpJAUwuH+O8myNlvIjqR55Nar2oya
         IgH2FrK+3Yqk1ACCC1+W7SXEMLD5fkh1a60uLFMzRWUerhLQ0ghVZWU98lZ+0wLXHp4M
         H58kOMs2kVg/hCXoM6xrYJNgY8ROXP4pHfj93ymoJRunKi+zlpTBilrKS+nct8avQuMr
         bZww==
X-Gm-Message-State: ANoB5pmrx+yAzB1dozhSfqETv06HNRvYs9dDb//QfN1ccAW4kU7Gvews
        lMEHK3jJa6Gwb9+8XkODU4mWxA==
X-Google-Smtp-Source: AA0mqf4DweCvC4XV1PpXdIQaqkp3IjcZbrHb/zDyBE7HusjqAw0zIrOJEOxxFgOI0ej0igGF/1zHxw==
X-Received: by 2002:a05:651c:894:b0:277:3e1:297c with SMTP id d20-20020a05651c089400b0027703e1297cmr2249483ljq.109.1668774859299;
        Fri, 18 Nov 2022 04:34:19 -0800 (PST)
Received: from krzk-bin.NAT.warszawa.vectranet.pl (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id m10-20020a19434a000000b004ac088fdfd2sm645833lfj.85.2022.11.18.04.34.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Nov 2022 04:34:18 -0800 (PST)
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
Subject: [PATCH v2 4/7] dt-bindings: remoteproc: qcom,sm6350-pas: split into separate file
Date:   Fri, 18 Nov 2022 13:33:59 +0100
Message-Id: <20221118123402.95784-5-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221118123402.95784-1-krzysztof.kozlowski@linaro.org>
References: <20221118123402.95784-1-krzysztof.kozlowski@linaro.org>
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

Split SM6350 remote processor Peripheral Authentication Service bindings
into their own file to reduce complexity and make maintenance easier.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Changes since v1:
1. Add qcom,qmp (not part of qcom,pas-common.yaml# anymore).
---
 .../bindings/remoteproc/qcom,adsp.yaml        |  28 ---
 .../bindings/remoteproc/qcom,sm6350-pas.yaml  | 173 ++++++++++++++++++
 2 files changed, 173 insertions(+), 28 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/remoteproc/qcom,sm6350-pas.yaml

diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,adsp.yaml b/Documentation/devicetree/bindings/remoteproc/qcom,adsp.yaml
index 881752348e10..8f491ded8816 100644
--- a/Documentation/devicetree/bindings/remoteproc/qcom,adsp.yaml
+++ b/Documentation/devicetree/bindings/remoteproc/qcom,adsp.yaml
@@ -37,9 +37,6 @@ properties:
       - qcom,sdm845-adsp-pas
       - qcom,sdm845-cdsp-pas
       - qcom,sdx55-mpss-pas
-      - qcom,sm6350-adsp-pas
-      - qcom,sm6350-cdsp-pas
-      - qcom,sm6350-mpss-pas
 
   reg:
     maxItems: 1
@@ -102,9 +99,6 @@ allOf:
               - qcom,sc8280xp-nsp1-pas
               - qcom,sdm845-adsp-pas
               - qcom,sdm845-cdsp-pas
-              - qcom,sm6350-adsp-pas
-              - qcom,sm6350-cdsp-pas
-              - qcom,sm6350-mpss-pas
     then:
       properties:
         clocks:
@@ -206,8 +200,6 @@ allOf:
               - qcom,sc8280xp-nsp1-pas
               - qcom,sdm845-adsp-pas
               - qcom,sdm845-cdsp-pas
-              - qcom,sm6350-adsp-pas
-              - qcom,sm6350-cdsp-pas
     then:
       properties:
         interrupts:
@@ -224,7 +216,6 @@ allOf:
               - qcom,sc7280-mpss-pas
               - qcom,sc8180x-mpss-pas
               - qcom,sdx55-mpss-pas
-              - qcom,sm6350-mpss-pas
     then:
       properties:
         interrupts:
@@ -296,23 +287,6 @@ allOf:
             - const: mx
             - const: mss
 
-  - if:
-      properties:
-        compatible:
-          contains:
-            enum:
-              - qcom,sm6350-cdsp-pas
-    then:
-      properties:
-        power-domains:
-          items:
-            - description: CX power domain
-            - description: MX power domain
-        power-domain-names:
-          items:
-            - const: cx
-            - const: mx
-
   - if:
       properties:
         compatible:
@@ -320,7 +294,6 @@ allOf:
             enum:
               - qcom,sc7280-mpss-pas
               - qcom,sdx55-mpss-pas
-              - qcom,sm6350-mpss-pas
     then:
       properties:
         power-domains:
@@ -340,7 +313,6 @@ allOf:
               - qcom,sc8180x-adsp-pas
               - qcom,sc8180x-cdsp-pas
               - qcom,sc8280xp-adsp-pas
-              - qcom,sm6350-adsp-pas
     then:
       properties:
         power-domains:
diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,sm6350-pas.yaml b/Documentation/devicetree/bindings/remoteproc/qcom,sm6350-pas.yaml
new file mode 100644
index 000000000000..f0960a301de7
--- /dev/null
+++ b/Documentation/devicetree/bindings/remoteproc/qcom,sm6350-pas.yaml
@@ -0,0 +1,173 @@
+# SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/remoteproc/qcom,sm6350-pas.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm SM6350 Peripheral Authentication Service
+
+maintainers:
+  - Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
+
+description:
+  Qualcomm SM6350 SoC Peripheral Authentication Service loads and boots
+  firmware on the Qualcomm DSP Hexagon cores.
+
+properties:
+  compatible:
+    enum:
+      - qcom,sm6350-adsp-pas
+      - qcom,sm6350-cdsp-pas
+      - qcom,sm6350-mpss-pas
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
+            - qcom,sm6350-adsp-pas
+            - qcom,sm6350-cdsp-pas
+            - qcom,sm6350-mpss-pas
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
+            - qcom,sm6350-adsp-pas
+            - qcom,sm6350-cdsp-pas
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
+            - qcom,sm6350-mpss-pas
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
+            - qcom,sm6350-cdsp-pas
+    then:
+      properties:
+        power-domains:
+          items:
+            - description: CX power domain
+            - description: MX power domain
+        power-domain-names:
+          items:
+            - const: cx
+            - const: mx
+
+  - if:
+      properties:
+        compatible:
+          enum:
+            - qcom,sm6350-mpss-pas
+    then:
+      properties:
+        power-domains:
+          items:
+            - description: CX power domain
+            - description: MSS power domain
+        power-domain-names:
+          items:
+            - const: cx
+            - const: mss
+
+  - if:
+      properties:
+        compatible:
+          enum:
+            - qcom,sm6350-adsp-pas
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
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/qcom,rpmh.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+    #include <dt-bindings/mailbox/qcom-ipcc.h>
+    #include <dt-bindings/power/qcom-rpmpd.h>
+
+    remoteproc@3000000 {
+        compatible = "qcom,sm6350-adsp-pas";
+        reg = <0x03000000 0x100>;
+
+        clocks = <&rpmhcc RPMH_CXO_CLK>;
+        clock-names = "xo";
+
+        interrupts-extended = <&pdc 6 IRQ_TYPE_LEVEL_HIGH>,
+                              <&smp2p_adsp_in 0 IRQ_TYPE_EDGE_RISING>,
+                              <&smp2p_adsp_in 1 IRQ_TYPE_EDGE_RISING>,
+                              <&smp2p_adsp_in 2 IRQ_TYPE_EDGE_RISING>,
+                              <&smp2p_adsp_in 3 IRQ_TYPE_EDGE_RISING>;
+        interrupt-names = "wdog", "fatal", "ready",
+                          "handover", "stop-ack";
+
+        memory-region = <&pil_adsp_mem>;
+
+        power-domains = <&rpmhpd SM6350_LCX>,
+                        <&rpmhpd SM6350_LMX>;
+        power-domain-names = "lcx", "lmx";
+
+        qcom,qmp = <&aoss_qmp>;
+        qcom,smem-states = <&smp2p_adsp_out 0>;
+        qcom,smem-state-names = "stop";
+
+        glink-edge {
+            interrupts-extended = <&ipcc IPCC_CLIENT_LPASS
+                                         IPCC_MPROC_SIGNAL_GLINK_QMP
+                                         IRQ_TYPE_EDGE_RISING>;
+            mboxes = <&ipcc IPCC_CLIENT_LPASS
+                            IPCC_MPROC_SIGNAL_GLINK_QMP>;
+
+            label = "lpass";
+            qcom,remote-pid = <2>;
+
+            /* ... */
+        };
+    };
-- 
2.34.1

