Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63D86637F42
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 19:45:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230054AbiKXSo7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 13:44:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229980AbiKXSoY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 13:44:24 -0500
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B85013182A
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 10:44:00 -0800 (PST)
Received: by mail-lj1-x22b.google.com with SMTP id l8so2818102ljh.13
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 10:44:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=58JRv9nwfZ1dka7LFvcfd23UiYZAX7REr403+LL6/r0=;
        b=qGfoN3eR1ixTOAq2JSlcvGCar3wwmIbRHxxDp1ouaBo1p/7zB3iTS7rutp/j2yLr8P
         6fn3ZEJPswKD0xxG7DUVd2xLiiEN83dRBfwQ0in5u1FJcYLAEiR2mQLVqyjZi2ugvRJg
         wVoKcZ+RhqkkJ5Ib5ycq/ub+1N7LnAHhDaJFrpwZnGYrUFw62MYOEERcI5vGpSQeH+JV
         s7XhubgFYJ70ygSkNZnmDuNUQL85NMVV3kXvEgoeJ/L0NP3AxDmJR3cA70/ftvIkxDWL
         X/dswNIxHw19hLhxGRPVCu4xraqtLDV6ckjZjWg7r5NRyjjk0tMBjnz1ahUS1Opv0dzw
         BD2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=58JRv9nwfZ1dka7LFvcfd23UiYZAX7REr403+LL6/r0=;
        b=Qzi4czA6F4dcdcAn8b7CXnaV0LcdDaHJEW0KGVhfflPzwEAZkN9tu/LXA1BOAHajoY
         Voqgrcc37GsUarRP36vPvOT2QNY7nMvZJwj+/GwxgZ0G073SBZ1ScNhcJEVOEzmJoDlj
         HGJ4L6hU8JPpL+Jm+4Rl8D1NYtUsLQIpMXXAownMSqbfJRmuJO3l+54BxsbEb3fwDnu1
         F1AfEP4Ie32Qf1m7Rh6c4tEhzKWyRibGnoz5oR9XX75B17pkY9mX1PIHVOh4cWV6oUOc
         qtos1X1MSg7g1WE5MM/jalnn00eI/eqrzC/mMJlSwfP2U6VtCF/b0Y30gY0iO7aeOUEI
         e8JA==
X-Gm-Message-State: ANoB5pmd7e/Q5ifM4jhmQzjiunWyy7gReZj+PJGkkMTRfFoTJ8KzTq4g
        omLg/rGEBtterNrnzgetdVAqlw==
X-Google-Smtp-Source: AA0mqf4SiiPNeiBuBjvWu4E/3cVYoVliYm84ZirFM9WNtSiWHswzoC5H9PoMncXaxFs3NPiFns/6NA==
X-Received: by 2002:a05:651c:198d:b0:278:eef5:8d16 with SMTP id bx13-20020a05651c198d00b00278eef58d16mr6819436ljb.220.1669315440098;
        Thu, 24 Nov 2022 10:44:00 -0800 (PST)
Received: from krzk-bin.NAT.warszawa.vectranet.pl (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id v7-20020a2ea607000000b0026e0434eb1esm159098ljp.67.2022.11.24.10.43.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Nov 2022 10:43:59 -0800 (PST)
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
Subject: [PATCH v3 14/15] dt-bindings: remoteproc: qcom,sc7180-pas: split into separate file
Date:   Thu, 24 Nov 2022 19:43:32 +0100
Message-Id: <20221124184333.133911-15-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221124184333.133911-1-krzysztof.kozlowski@linaro.org>
References: <20221124184333.133911-1-krzysztof.kozlowski@linaro.org>
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

Split SC7180 and SC7280remote processor Peripheral Authentication
Service bindings into their own file to reduce complexity and make
maintenance easier.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Changes since v2:
1. New patch.
---
 .../bindings/remoteproc/qcom,adsp.yaml        |  54 --------
 .../bindings/remoteproc/qcom,sc7180-pas.yaml  | 125 ++++++++++++++++++
 2 files changed, 125 insertions(+), 54 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/remoteproc/qcom,sc7180-pas.yaml

diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,adsp.yaml b/Documentation/devicetree/bindings/remoteproc/qcom,adsp.yaml
index 9fdfa9476ca9..7848d1d658f4 100644
--- a/Documentation/devicetree/bindings/remoteproc/qcom,adsp.yaml
+++ b/Documentation/devicetree/bindings/remoteproc/qcom,adsp.yaml
@@ -22,8 +22,6 @@ properties:
       - qcom,msm8996-slpi-pil
       - qcom,msm8998-adsp-pas
       - qcom,msm8998-slpi-pas
-      - qcom,sc7180-mpss-pas
-      - qcom,sc7280-mpss-pas
       - qcom,sdm660-adsp-pas
       - qcom,sdm845-adsp-pas
       - qcom,sdm845-cdsp-pas
@@ -58,8 +56,6 @@ allOf:
               - qcom,msm8996-adsp-pil
               - qcom,msm8996-slpi-pil
               - qcom,msm8998-adsp-pas
-              - qcom,sc7180-mpss-pas
-              - qcom,sc7280-mpss-pas
               - qcom,sdm845-adsp-pas
               - qcom,sdm845-cdsp-pas
     then:
@@ -108,20 +104,6 @@ allOf:
         interrupt-names:
           maxItems: 5
 
-  - if:
-      properties:
-        compatible:
-          contains:
-            enum:
-              - qcom,sc7180-mpss-pas
-              - qcom,sc7280-mpss-pas
-    then:
-      properties:
-        interrupts:
-          minItems: 6
-        interrupt-names:
-          minItems: 6
-
   - if:
       properties:
         compatible:
@@ -167,42 +149,6 @@ allOf:
       required:
         - px-supply
 
-  - if:
-      properties:
-        compatible:
-          contains:
-            enum:
-              - qcom,sc7180-mpss-pas
-    then:
-      properties:
-        power-domains:
-          items:
-            - description: CX power domain
-            - description: MX power domain
-            - description: MSS power domain
-        power-domain-names:
-          items:
-            - const: cx
-            - const: mx
-            - const: mss
-
-  - if:
-      properties:
-        compatible:
-          contains:
-            enum:
-              - qcom,sc7280-mpss-pas
-    then:
-      properties:
-        power-domains:
-          items:
-            - description: CX power domain
-            - description: MSS power domain
-        power-domain-names:
-          items:
-            - const: cx
-            - const: mss
-
   - if:
       properties:
         compatible:
diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,sc7180-pas.yaml b/Documentation/devicetree/bindings/remoteproc/qcom,sc7180-pas.yaml
new file mode 100644
index 000000000000..6fd768609a66
--- /dev/null
+++ b/Documentation/devicetree/bindings/remoteproc/qcom,sc7180-pas.yaml
@@ -0,0 +1,125 @@
+# SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/remoteproc/qcom,sc7180-pas.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm SC7180/SC7280 Peripheral Authentication Service
+
+maintainers:
+  - Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
+
+description:
+  Qualcomm SC7180/SC7280 SoC Peripheral Authentication Service loads and boots
+  firmware on the Qualcomm DSP Hexagon cores.
+
+properties:
+  compatible:
+    enum:
+      - qcom,sc7180-mpss-pas
+      - qcom,sc7280-mpss-pas
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
+  interrupts:
+    minItems: 6
+
+  interrupt-names:
+    minItems: 6
+
+  power-domains:
+    minItems: 2
+    items:
+      - description: CX power domain
+      - description: MX power domain
+      - description: MSS power domain
+
+  power-domain-names:
+    minItems: 2
+    items:
+      - const: cx
+      - const: mx
+      - const: mss
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
+            - qcom,sc7180-mpss-pas
+    then:
+      properties:
+        power-domains:
+          minItems: 3
+        power-domain-names:
+          minItems: 3
+    else:
+      properties:
+        power-domains:
+          maxItems: 2
+        power-domain-names:
+          maxItems: 2
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/qcom,rpmh.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+    #include <dt-bindings/power/qcom-rpmpd.h>
+
+    remoteproc@4080000 {
+        compatible = "qcom,sc7180-mpss-pas";
+        reg = <0x04080000 0x4040>;
+
+        clocks = <&rpmhcc RPMH_CXO_CLK>;
+        clock-names = "xo";
+
+        interrupts-extended = <&intc GIC_SPI 266 IRQ_TYPE_EDGE_RISING>,
+                              <&modem_smp2p_in 0 IRQ_TYPE_EDGE_RISING>,
+                              <&modem_smp2p_in 1 IRQ_TYPE_EDGE_RISING>,
+                              <&modem_smp2p_in 2 IRQ_TYPE_EDGE_RISING>,
+                              <&modem_smp2p_in 3 IRQ_TYPE_EDGE_RISING>,
+                              <&modem_smp2p_in 7 IRQ_TYPE_EDGE_RISING>;
+        interrupt-names = "wdog", "fatal", "ready", "handover",
+                          "stop-ack", "shutdown-ack";
+
+        memory-region = <&mpss_mem>;
+
+        power-domains = <&rpmhpd SC7180_CX>,
+                        <&rpmhpd SC7180_MX>,
+                        <&rpmhpd SC7180_MSS>;
+        power-domain-names = "cx", "mx", "mss";
+
+        qcom,qmp = <&aoss_qmp>;
+        qcom,smem-states = <&modem_smp2p_out 0>;
+        qcom,smem-state-names = "stop";
+
+        glink-edge {
+            interrupts = <GIC_SPI 449 IRQ_TYPE_EDGE_RISING>;
+            label = "modem";
+            qcom,remote-pid = <1>;
+            mboxes = <&apss_shared 12>;
+        };
+    };
-- 
2.34.1

