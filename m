Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8532F62F4F8
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 13:34:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235301AbiKRMev (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 07:34:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241721AbiKRMeX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 07:34:23 -0500
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7790182BEF
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 04:34:19 -0800 (PST)
Received: by mail-lj1-x229.google.com with SMTP id d20so6555795ljc.12
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 04:34:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0dXPLa/w5AdXo7WzV4zcD7Nm8P+4CaGSGkNdT1ex5Ww=;
        b=mKork/XOajAP71cBOVENZOmKVCXGGskfek5NOto0rQLzl1j4qVI4POGXeD3WixfZrI
         s1OXbk0rHOx9ugrgW/veOf6gwgNqO690L9biEfr2n6+emJvB8IwszjRo9VAW8Vuoty2R
         dpKQ9GQzkB0TMqgVk/ZuhmUgOr2eAneM1hG/ZyJH63Qoontr2Qvq6KgenThwL7krHmz+
         dcysJGs3l3R/yLAh7affg0TTMp7eMIhQFHipDPm3lm3BKKHo7nHMEsX5A+x+dxNg0Kyd
         TqM6l3lfZBB4qWyiCrhCDuoEnxiZhyYuKTI7+o7pBl4aAzoL7sBekQvcab0TqMwq6FGw
         SjmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0dXPLa/w5AdXo7WzV4zcD7Nm8P+4CaGSGkNdT1ex5Ww=;
        b=LJDzNXvzGkMwJUm8Cm4cC/oyqAjYjwc5jH+DRw8W7Ltc9WA5GYlKLBjKY4RkPHn+8y
         R3m1OZT/3xhuYMNJ0GJ/BHZ8C8jgjyGRI0dTPvA/DhYGecIAmhi+QzfuALBt9nU76O42
         Z3SHEfQneTC3MghLk6Qnvj4RqhABLm/T0fkpT2rcuAcrPVEaZMmKse2TPVQ/Fod3pFm3
         eLnLsNq0AmH1ohSOb7PGyOwPp8ArQERGBv1GwduSIARGTCAMjqDJQ6i3rsg0JYaP7H8i
         jeVG3lU9zpcGSFyQEO0+vR3tz2P7SOvLScYLlcV1i3c6lqizXFoBVxGoUdxAXycvoDpJ
         QcYQ==
X-Gm-Message-State: ANoB5plxGYmFdSTep8ldpssG4e87wDxNUeyy6X3xo+HQjeIK/K/z1QrQ
        sbZ7x5Edi/KzVRESdZHatCNXTw==
X-Google-Smtp-Source: AA0mqf5Hl7YlR/ZI000yMPIFRoe5uihf2ntxwwSBf6HDxoPGFlMPnFDJFXaGjzoJaFOrSDlY78WvXQ==
X-Received: by 2002:a2e:9252:0:b0:270:74fd:8fb with SMTP id v18-20020a2e9252000000b0027074fd08fbmr2338435ljg.500.1668774857734;
        Fri, 18 Nov 2022 04:34:17 -0800 (PST)
Received: from krzk-bin.NAT.warszawa.vectranet.pl (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id m10-20020a19434a000000b004ac088fdfd2sm645833lfj.85.2022.11.18.04.34.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Nov 2022 04:34:17 -0800 (PST)
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
Subject: [PATCH v2 3/7] dt-bindings: remoteproc: qcom,sm8150-pas: split into separate file
Date:   Fri, 18 Nov 2022 13:33:58 +0100
Message-Id: <20221118123402.95784-4-krzysztof.kozlowski@linaro.org>
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

Split SM8150 and SM8250 remote processor Peripheral Authentication
Service bindings into their own file to reduce complexity and make
maintenance easier.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Changes since v1:
1. Add qcom,qmp (not part of qcom,pas-common.yaml# anymore).
2. Add firmware-name to example.
---
 .../bindings/remoteproc/qcom,adsp.yaml        |  27 ---
 .../bindings/remoteproc/qcom,sm8150-pas.yaml  | 184 ++++++++++++++++++
 2 files changed, 184 insertions(+), 27 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/remoteproc/qcom,sm8150-pas.yaml

diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,adsp.yaml b/Documentation/devicetree/bindings/remoteproc/qcom,adsp.yaml
index 7a562a9bcfad..881752348e10 100644
--- a/Documentation/devicetree/bindings/remoteproc/qcom,adsp.yaml
+++ b/Documentation/devicetree/bindings/remoteproc/qcom,adsp.yaml
@@ -40,13 +40,6 @@ properties:
       - qcom,sm6350-adsp-pas
       - qcom,sm6350-cdsp-pas
       - qcom,sm6350-mpss-pas
-      - qcom,sm8150-adsp-pas
-      - qcom,sm8150-cdsp-pas
-      - qcom,sm8150-mpss-pas
-      - qcom,sm8150-slpi-pas
-      - qcom,sm8250-adsp-pas
-      - qcom,sm8250-cdsp-pas
-      - qcom,sm8250-slpi-pas
 
   reg:
     maxItems: 1
@@ -112,13 +105,6 @@ allOf:
               - qcom,sm6350-adsp-pas
               - qcom,sm6350-cdsp-pas
               - qcom,sm6350-mpss-pas
-              - qcom,sm8150-adsp-pas
-              - qcom,sm8150-cdsp-pas
-              - qcom,sm8150-mpss-pas
-              - qcom,sm8150-slpi-pas
-              - qcom,sm8250-adsp-pas
-              - qcom,sm8250-cdsp-pas
-              - qcom,sm8250-slpi-pas
     then:
       properties:
         clocks:
@@ -222,12 +208,6 @@ allOf:
               - qcom,sdm845-cdsp-pas
               - qcom,sm6350-adsp-pas
               - qcom,sm6350-cdsp-pas
-              - qcom,sm8150-adsp-pas
-              - qcom,sm8150-cdsp-pas
-              - qcom,sm8150-slpi-pas
-              - qcom,sm8250-adsp-pas
-              - qcom,sm8250-cdsp-pas
-              - qcom,sm8250-slpi-pas
     then:
       properties:
         interrupts:
@@ -245,7 +225,6 @@ allOf:
               - qcom,sc8180x-mpss-pas
               - qcom,sdx55-mpss-pas
               - qcom,sm6350-mpss-pas
-              - qcom,sm8150-mpss-pas
     then:
       properties:
         interrupts:
@@ -271,8 +250,6 @@ allOf:
               - qcom,msm8226-adsp-pil
               - qcom,msm8996-adsp-pil
               - qcom,msm8998-adsp-pas
-              - qcom,sm8150-adsp-pas
-              - qcom,sm8150-cdsp-pas
     then:
       properties:
         power-domains:
@@ -344,7 +321,6 @@ allOf:
               - qcom,sc7280-mpss-pas
               - qcom,sdx55-mpss-pas
               - qcom,sm6350-mpss-pas
-              - qcom,sm8150-mpss-pas
     then:
       properties:
         power-domains:
@@ -365,9 +341,6 @@ allOf:
               - qcom,sc8180x-cdsp-pas
               - qcom,sc8280xp-adsp-pas
               - qcom,sm6350-adsp-pas
-              - qcom,sm8150-slpi-pas
-              - qcom,sm8250-adsp-pas
-              - qcom,sm8250-slpi-pas
     then:
       properties:
         power-domains:
diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,sm8150-pas.yaml b/Documentation/devicetree/bindings/remoteproc/qcom,sm8150-pas.yaml
new file mode 100644
index 000000000000..fa8b80f2f749
--- /dev/null
+++ b/Documentation/devicetree/bindings/remoteproc/qcom,sm8150-pas.yaml
@@ -0,0 +1,184 @@
+# SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/remoteproc/qcom,sm8150-pas.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm SM8150/SM8250 Peripheral Authentication Service
+
+maintainers:
+  - Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
+
+description:
+  Qualcomm SM8150/SM8250 SoC Peripheral Authentication Service loads and boots
+  firmware on the Qualcomm DSP Hexagon cores.
+
+properties:
+  compatible:
+    enum:
+      - qcom,sm8150-adsp-pas
+      - qcom,sm8150-cdsp-pas
+      - qcom,sm8150-mpss-pas
+      - qcom,sm8150-slpi-pas
+      - qcom,sm8250-adsp-pas
+      - qcom,sm8250-cdsp-pas
+      - qcom,sm8250-slpi-pas
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
+            - qcom,sm8150-adsp-pas
+            - qcom,sm8150-cdsp-pas
+            - qcom,sm8150-mpss-pas
+            - qcom,sm8150-slpi-pas
+            - qcom,sm8250-adsp-pas
+            - qcom,sm8250-cdsp-pas
+            - qcom,sm8250-slpi-pas
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
+            - qcom,sm8150-adsp-pas
+            - qcom,sm8150-cdsp-pas
+            - qcom,sm8150-slpi-pas
+            - qcom,sm8250-adsp-pas
+            - qcom,sm8250-cdsp-pas
+            - qcom,sm8250-slpi-pas
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
+            - qcom,sm8150-mpss-pas
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
+            - qcom,sm8150-adsp-pas
+            - qcom,sm8150-cdsp-pas
+            - qcom,sm8250-cdsp-pas
+    then:
+      properties:
+        power-domains:
+          items:
+            - description: CX power domain
+        power-domain-names:
+          items:
+            - const: cx
+
+  - if:
+      properties:
+        compatible:
+          enum:
+            - qcom,sm8150-mpss-pas
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
+            - qcom,sm8150-slpi-pas
+            - qcom,sm8250-adsp-pas
+            - qcom,sm8250-slpi-pas
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
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+    #include <dt-bindings/power/qcom-rpmpd.h>
+
+    remoteproc@17300000 {
+        compatible = "qcom,sm8150-adsp-pas";
+        reg = <0x17300000 0x4040>;
+
+        clocks = <&rpmhcc RPMH_CXO_CLK>;
+        clock-names = "xo";
+
+        firmware-name = "qcom/sm8150/adsp.mbn";
+
+        interrupts-extended = <&intc GIC_SPI 162 IRQ_TYPE_EDGE_RISING>,
+                              <&adsp_smp2p_in 0 IRQ_TYPE_EDGE_RISING>,
+                              <&adsp_smp2p_in 1 IRQ_TYPE_EDGE_RISING>,
+                              <&adsp_smp2p_in 2 IRQ_TYPE_EDGE_RISING>,
+                              <&adsp_smp2p_in 3 IRQ_TYPE_EDGE_RISING>;
+        interrupt-names = "wdog", "fatal", "ready",
+                          "handover", "stop-ack";
+
+        memory-region = <&adsp_mem>;
+
+        power-domains = <&rpmhpd SM8150_CX>;
+
+        qcom,qmp = <&aoss_qmp>;
+        qcom,smem-states = <&adsp_smp2p_out 0>;
+        qcom,smem-state-names = "stop";
+
+        glink-edge {
+            interrupts = <GIC_SPI 156 IRQ_TYPE_EDGE_RISING>;
+            label = "lpass";
+            qcom,remote-pid = <2>;
+            mboxes = <&apss_shared 8>;
+
+            /* ... */
+
+        };
+    };
-- 
2.34.1

