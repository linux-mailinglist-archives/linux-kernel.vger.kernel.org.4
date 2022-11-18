Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E3A162F4EC
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 13:34:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240920AbiKRMer (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 07:34:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241647AbiKRMeW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 07:34:22 -0500
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2250F87A7C
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 04:34:18 -0800 (PST)
Received: by mail-lj1-x22f.google.com with SMTP id s24so6569948ljs.11
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 04:34:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HNUrtyWi9SF1WjiyydZUH0FXhTmFkl2HJ0ZGvBcvxwQ=;
        b=DqLEqgzS8djRYyjCZbOCFDf9066kiDrERCr4nbmPHE3nrWgd6c30n+nam24y3ksANE
         RYHg7SVKS0QBKWpQvlmrJBrLRRJgeQ55ycwqSi+pejQ18uoQbDxGq+cNt9/47RlamMJ0
         hggUVjkxTlw/3X89F9AI/QmQNXpg8BJ8lTJur1W++X1pdiZCDRv3sgNkAuF48Aa4tQkk
         6e13aR+p7YgLCvUISUmnwgImXRZxUVzYToOo72BS+99n7dUINfWcxKif9UG6Lyk4sRnJ
         /gWvHZZtJBay7/AikZkyg2/M2mNq/vWzcBW8ETWmzui4/igF0KvRkWJoACVXLz/4I3bV
         SUuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HNUrtyWi9SF1WjiyydZUH0FXhTmFkl2HJ0ZGvBcvxwQ=;
        b=Kylyld+fqDA2oK3W1OoePUmVx3lEBpNe91sCw99Yqz7vH85LC7HTyJTGxiF21pDze7
         Rwux76XauQmibEa3Ibo9lcObWXnD2LQ0nlnhpMYDuw8z0NLY6Y/KVSbq/E/NNZO90UG7
         o6tMeVld1qGTbCDPnyWYBD2gV6Y5tyteZSLGTUOuAm0PyTv4g31jXzot0h1WGInVeyzA
         6ACbm10T3jSnQmgp6FDS4UDBiqG2jQNYKqe2XioRY+Qy1ko+ZwtQNBwKQXOQf6Uq6gbj
         F1rYpetiJxdqj+vqOcQe7rrSp+k8FVUIpD0jSBIhMN/Fw1SGNRLdWnwe03Xx/HNMjeLL
         2IDQ==
X-Gm-Message-State: ANoB5pl6MktpE9ekdyORReAemsKQEvLVi6/s6ittCamHTBOURiei26Dw
        w2jnd6KnnlPG+fr/ozqVuXUV+w==
X-Google-Smtp-Source: AA0mqf7poPaycrc0LgD1OwBMo23Mavn5v/JsTBrFJZfY9Kfm7tMbI+3x1/mqZuFYd/QDFqTB7Q9pyg==
X-Received: by 2002:a2e:a885:0:b0:26e:768c:11ed with SMTP id m5-20020a2ea885000000b0026e768c11edmr2590348ljq.436.1668774856276;
        Fri, 18 Nov 2022 04:34:16 -0800 (PST)
Received: from krzk-bin.NAT.warszawa.vectranet.pl (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id m10-20020a19434a000000b004ac088fdfd2sm645833lfj.85.2022.11.18.04.34.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Nov 2022 04:34:15 -0800 (PST)
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
Subject: [PATCH v2 2/7] dt-bindings: remoteproc: qcom,sm8350-pas: split into separate file
Date:   Fri, 18 Nov 2022 13:33:57 +0100
Message-Id: <20221118123402.95784-3-krzysztof.kozlowski@linaro.org>
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

Split SM8350 and SM8450 remote processor Peripheral Authentication
Service bindings into their own file to reduce complexity and make
maintenance easier.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Changes since v1:
1. Add qcom,qmp (not part of qcom,pas-common.yaml# anymore).
2. Add firmware-name to example.
---
 .../bindings/remoteproc/qcom,adsp.yaml        |  48 -----
 .../bindings/remoteproc/qcom,sm8350-pas.yaml  | 194 ++++++++++++++++++
 2 files changed, 194 insertions(+), 48 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/remoteproc/qcom,sm8350-pas.yaml

diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,adsp.yaml b/Documentation/devicetree/bindings/remoteproc/qcom,adsp.yaml
index bd4082411bf5..7a562a9bcfad 100644
--- a/Documentation/devicetree/bindings/remoteproc/qcom,adsp.yaml
+++ b/Documentation/devicetree/bindings/remoteproc/qcom,adsp.yaml
@@ -47,14 +47,6 @@ properties:
       - qcom,sm8250-adsp-pas
       - qcom,sm8250-cdsp-pas
       - qcom,sm8250-slpi-pas
-      - qcom,sm8350-adsp-pas
-      - qcom,sm8350-cdsp-pas
-      - qcom,sm8350-slpi-pas
-      - qcom,sm8350-mpss-pas
-      - qcom,sm8450-adsp-pas
-      - qcom,sm8450-cdsp-pas
-      - qcom,sm8450-mpss-pas
-      - qcom,sm8450-slpi-pas
 
   reg:
     maxItems: 1
@@ -127,14 +119,6 @@ allOf:
               - qcom,sm8250-adsp-pas
               - qcom,sm8250-cdsp-pas
               - qcom,sm8250-slpi-pas
-              - qcom,sm8350-adsp-pas
-              - qcom,sm8350-cdsp-pas
-              - qcom,sm8350-slpi-pas
-              - qcom,sm8350-mpss-pas
-              - qcom,sm8450-adsp-pas
-              - qcom,sm8450-cdsp-pas
-              - qcom,sm8450-slpi-pas
-              - qcom,sm8450-mpss-pas
     then:
       properties:
         clocks:
@@ -244,12 +228,6 @@ allOf:
               - qcom,sm8250-adsp-pas
               - qcom,sm8250-cdsp-pas
               - qcom,sm8250-slpi-pas
-              - qcom,sm8350-adsp-pas
-              - qcom,sm8350-cdsp-pas
-              - qcom,sm8350-slpi-pas
-              - qcom,sm8450-adsp-pas
-              - qcom,sm8450-cdsp-pas
-              - qcom,sm8450-slpi-pas
     then:
       properties:
         interrupts:
@@ -268,8 +246,6 @@ allOf:
               - qcom,sdx55-mpss-pas
               - qcom,sm6350-mpss-pas
               - qcom,sm8150-mpss-pas
-              - qcom,sm8350-mpss-pas
-              - qcom,sm8450-mpss-pas
     then:
       properties:
         interrupts:
@@ -369,8 +345,6 @@ allOf:
               - qcom,sdx55-mpss-pas
               - qcom,sm6350-mpss-pas
               - qcom,sm8150-mpss-pas
-              - qcom,sm8350-mpss-pas
-              - qcom,sm8450-mpss-pas
     then:
       properties:
         power-domains:
@@ -394,10 +368,6 @@ allOf:
               - qcom,sm8150-slpi-pas
               - qcom,sm8250-adsp-pas
               - qcom,sm8250-slpi-pas
-              - qcom,sm8350-adsp-pas
-              - qcom,sm8350-slpi-pas
-              - qcom,sm8450-adsp-pas
-              - qcom,sm8450-slpi-pas
     then:
       properties:
         power-domains:
@@ -409,24 +379,6 @@ allOf:
             - const: lcx
             - const: lmx
 
-  - if:
-      properties:
-        compatible:
-          contains:
-            enum:
-              - qcom,sm8350-cdsp-pas
-              - qcom,sm8450-cdsp-pas
-    then:
-      properties:
-        power-domains:
-          items:
-            - description: CX power domain
-            - description: MXC power domain
-        power-domain-names:
-          items:
-            - const: cx
-            - const: mxc
-
   - if:
       properties:
         compatible:
diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,sm8350-pas.yaml b/Documentation/devicetree/bindings/remoteproc/qcom,sm8350-pas.yaml
new file mode 100644
index 000000000000..bc7bd41b409e
--- /dev/null
+++ b/Documentation/devicetree/bindings/remoteproc/qcom,sm8350-pas.yaml
@@ -0,0 +1,194 @@
+# SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/remoteproc/qcom,sm8350-pas.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm SM8350/SM8450 Peripheral Authentication Service
+
+maintainers:
+  - Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
+
+description:
+  Qualcomm SM8350/SM8450 SoC Peripheral Authentication Service loads and boots
+  firmware on the Qualcomm DSP Hexagon cores.
+
+properties:
+  compatible:
+    enum:
+      - qcom,sm8350-adsp-pas
+      - qcom,sm8350-cdsp-pas
+      - qcom,sm8350-slpi-pas
+      - qcom,sm8350-mpss-pas
+      - qcom,sm8450-adsp-pas
+      - qcom,sm8450-cdsp-pas
+      - qcom,sm8450-mpss-pas
+      - qcom,sm8450-slpi-pas
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
+            - qcom,sm8350-adsp-pas
+            - qcom,sm8350-cdsp-pas
+            - qcom,sm8350-mpss-pas
+            - qcom,sm8350-slpi-pas
+            - qcom,sm8450-adsp-pas
+            - qcom,sm8450-cdsp-pas
+            - qcom,sm8450-mpss-pas
+            - qcom,sm8450-slpi-pas
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
+            - qcom,sm8350-adsp-pas
+            - qcom,sm8350-cdsp-pas
+            - qcom,sm8350-slpi-pas
+            - qcom,sm8450-adsp-pas
+            - qcom,sm8450-cdsp-pas
+            - qcom,sm8450-slpi-pas
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
+            - qcom,sm8350-mpss-pas
+            - qcom,sm8450-mpss-pas
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
+            - qcom,sm8350-mpss-pas
+            - qcom,sm8450-mpss-pas
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
+            - qcom,sm8350-adsp-pas
+            - qcom,sm8350-slpi-pas
+            - qcom,sm8450-adsp-pas
+            - qcom,sm8450-slpi-pas
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
+  - if:
+      properties:
+        compatible:
+          enum:
+            - qcom,sm8350-cdsp-pas
+            - qcom,sm8450-cdsp-pas
+    then:
+      properties:
+        power-domains:
+          items:
+            - description: CX power domain
+            - description: MXC power domain
+        power-domain-names:
+          items:
+            - const: cx
+            - const: mxc
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
+    remoteproc@30000000 {
+        compatible = "qcom,sm8450-adsp-pas";
+        reg = <0x030000000 0x100>;
+
+        clocks = <&rpmhcc RPMH_CXO_CLK>;
+        clock-names = "xo";
+
+        firmware-name = "qcom/sm8450/adsp.mbn";
+
+        interrupts-extended = <&pdc 6 IRQ_TYPE_EDGE_RISING>,
+                              <&smp2p_adsp_in 0 IRQ_TYPE_EDGE_RISING>,
+                              <&smp2p_adsp_in 1 IRQ_TYPE_EDGE_RISING>,
+                              <&smp2p_adsp_in 2 IRQ_TYPE_EDGE_RISING>,
+                              <&smp2p_adsp_in 3 IRQ_TYPE_EDGE_RISING>;
+        interrupt-names = "wdog", "fatal", "ready",
+                          "handover", "stop-ack";
+
+        memory-region = <&adsp_mem>;
+
+        power-domains = <&rpmhpd SM8450_LCX>,
+                        <&rpmhpd SM8450_LMX>;
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
+            mboxes = <&ipcc IPCC_CLIENT_LPASS IPCC_MPROC_SIGNAL_GLINK_QMP>;
+
+            label = "lpass";
+            qcom,remote-pid = <2>;
+
+            /* ... */
+        };
+    };
-- 
2.34.1

