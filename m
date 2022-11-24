Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35FC7637F2D
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 19:44:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229988AbiKXSoY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 13:44:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229877AbiKXSoA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 13:44:00 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83C2012E206
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 10:43:54 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id g7so3694030lfv.5
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 10:43:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4cmieysHy6QLmIblSNrv79qb6XCiqgVZ6yuCtnljXuU=;
        b=CH0CgZN84vQe+wZ607rsJQJabpSeD5zZJyYHdvMutzY3oPK3hjwygf3UfPKvqZJCq7
         cIltAccMxB4y0+QqgGB9JGf0FTU4APirVK7UDAHy57nJpe72+5ZW4fo7g23vWKGLOtqD
         QV8sNBBfv3RDbgm7Qg73lxIMkuc4FeCjIcVgF9+qf4YMslZhxyIpYsePuDKHBwVAp338
         lcDCMItgyOcYzW1A9kbag51LXHR3itf0mWO2GC1BiDgcUHF0k1Gthc7wV7KKrKLrK3t0
         7iP2hO+MonEPpsVvOnpOpCflRGee99Q5DekZhyzaAqUidQjJdLIq72+7wgJXHnI4W3YJ
         xS5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4cmieysHy6QLmIblSNrv79qb6XCiqgVZ6yuCtnljXuU=;
        b=mG3l05ZBMIKtdOEmSs4+kiVnjsIG4t4x17tnICd4GPH9F+MV9V+eVVeHZReRplOv4X
         9iKBC5VpgF4b9oXYoWHLhudMpzHleRArXrJ7y74YXq0cxCDmKXuyXkXBJ4SMDMUfOCnj
         RejC4/7pTXdikl3QsdGUyccML+U5sViZp0Ri+qVd+wBMOwIM2Mc23z+EawPNlC3+hib8
         jl2tgXJnDN8F0T3IPI97W9Y4NviW/+gm2K4R5V3XZWm6DT4ejfXTZBxhmUavUcRW8EER
         wVKLY4LVHlHmuV7iXxjILOnnavyqJoJyTIPDNUr3UFP96eBbW1ehe5VSa0pDfT3MnsyY
         Rcog==
X-Gm-Message-State: ANoB5pltiEHOC+jzTM8JO7BfBr8m7fQ3I+u64yULLT+oP9hVFSm6J23z
        kTuu1XaGr74jYl8buvwVsviuczx1EwnOlyyO
X-Google-Smtp-Source: AA0mqf4iiUVSyHFfBD0X1ifMug7Can+h8BKcaEHaLN8s9y4e1zVByb5wetWx1+VGxYg+aN30DlSZ3Q==
X-Received: by 2002:a05:6512:2523:b0:4a6:fac4:596c with SMTP id be35-20020a056512252300b004a6fac4596cmr5464474lfb.220.1669315432876;
        Thu, 24 Nov 2022 10:43:52 -0800 (PST)
Received: from krzk-bin.NAT.warszawa.vectranet.pl (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id v7-20020a2ea607000000b0026e0434eb1esm159098ljp.67.2022.11.24.10.43.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Nov 2022 10:43:52 -0800 (PST)
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
Subject: [PATCH v3 08/15] dt-bindings: remoteproc: qcom,sm8150-pas: split into separate file
Date:   Thu, 24 Nov 2022 19:43:26 +0100
Message-Id: <20221124184333.133911-9-krzysztof.kozlowski@linaro.org>
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

Split SM8150 and SM8250 remote processor Peripheral Authentication
Service bindings into their own file to reduce complexity and make
maintenance easier.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Changes since v2:
1. Drop if:then: for the clock and put it directly under properties.
2. Merge two if:then: clauses for setting interrupts.

Changes since v1:
1. Add qcom,qmp (not part of qcom,pas-common.yaml# anymore).
2. Add firmware-name to example.
---
 .../bindings/remoteproc/qcom,adsp.yaml        |  27 ---
 .../bindings/remoteproc/qcom,sm8150-pas.yaml  | 166 ++++++++++++++++++
 2 files changed, 166 insertions(+), 27 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/remoteproc/qcom,sm8150-pas.yaml

diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,adsp.yaml b/Documentation/devicetree/bindings/remoteproc/qcom,adsp.yaml
index 67941e79a4a0..e8d66eefd522 100644
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
@@ -94,13 +87,6 @@ allOf:
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
@@ -150,12 +136,6 @@ allOf:
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
@@ -173,7 +153,6 @@ allOf:
               - qcom,sc8180x-mpss-pas
               - qcom,sdx55-mpss-pas
               - qcom,sm6350-mpss-pas
-              - qcom,sm8150-mpss-pas
     then:
       properties:
         interrupts:
@@ -199,8 +178,6 @@ allOf:
               - qcom,msm8226-adsp-pil
               - qcom,msm8996-adsp-pil
               - qcom,msm8998-adsp-pas
-              - qcom,sm8150-adsp-pas
-              - qcom,sm8150-cdsp-pas
     then:
       properties:
         power-domains:
@@ -272,7 +249,6 @@ allOf:
               - qcom,sc7280-mpss-pas
               - qcom,sdx55-mpss-pas
               - qcom,sm6350-mpss-pas
-              - qcom,sm8150-mpss-pas
     then:
       properties:
         power-domains:
@@ -293,9 +269,6 @@ allOf:
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
index 000000000000..b934252cf02b
--- /dev/null
+++ b/Documentation/devicetree/bindings/remoteproc/qcom,sm8150-pas.yaml
@@ -0,0 +1,166 @@
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

