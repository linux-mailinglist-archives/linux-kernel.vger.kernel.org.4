Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12F98637F27
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 19:44:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229951AbiKXSoR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 13:44:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229807AbiKXSn4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 13:43:56 -0500
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8C3D129C11
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 10:43:51 -0800 (PST)
Received: by mail-lj1-x231.google.com with SMTP id j2so330684ljg.10
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 10:43:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hFQ5Tybue2hPXwLWua5e6rjcLimDchEklSap0fSlOTE=;
        b=FsQtwPe3KpwFXZMf0pqPMC1w0azWK/O7k3FwF75UfhISBJuQHDJN6HJ7NC0SmHMjA2
         cFDg4uhxk59Qqsv7uVnhOPPa53sNEZ8Q5Q4QtmOmE9hupTOLEuKf89sTnHp+qCLFCs8Y
         drdjpsFTPzhcuk61KIMQNDZlqiUd6EGbro7M9kau8aNYiebjJaSKu73Vc1F7Tyj0EmxD
         YydIzd0ffwoQFuJXiZtCNBNMfVqtx8v5h1VIA7i6gaLsXsPmfndVOBIrH4hYMToLKzcP
         YmYb+unw0l1cRAjmpAqxyPAUdSyrjTyVxv2HUm3M/7DFG4Nl1wBJ0f4YcV5Saadesj6d
         tF5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hFQ5Tybue2hPXwLWua5e6rjcLimDchEklSap0fSlOTE=;
        b=Tudhxv3nfQnWiI6mwp9ym83Zth2mjtzmkVSF15quyWCJjU/SiLN2XCp1Nc2Yl42rNQ
         mYNaN1tGMQ96Ia5hqcN5bj66gRX0Uwr8l9cim7PDbwGRRi+EV2ghw0JA6GwowTl9eRh1
         s4SroUozbHKlWTGAjfrieGMKwvb8iYnXcWOTkxqgym81MndED222VBG8NFN5swL7l/QX
         RsebCLX3QbeMjaqoBrZsP2OQVnynIoApFHm8iisGaAssXhtSSVOSPtkymOYgurGGEE+m
         x2KyskfSE8B4IPpn9vVnj6koFC54RMmgPe6NH1FMI2nD6Ncx0j7Il1anlfV9ymvoGOvS
         Y/WA==
X-Gm-Message-State: ANoB5pkGolyVpW5Ju2MVF0nq+eGiWYnGUjvSX8jwCCLkBmsXE5lcWXf1
        zt9S+gSu43MF5NSQFkKQItvrmw==
X-Google-Smtp-Source: AA0mqf4GO4QIQ6/ODUUF41oqbfSlG01sQ+HgKSpMJ4F8DDXLfEwBBvp0kY5PRzOZklGDfE7V3oYwSA==
X-Received: by 2002:a2e:3806:0:b0:277:b84:81b6 with SMTP id f6-20020a2e3806000000b002770b8481b6mr10402345lja.425.1669315431407;
        Thu, 24 Nov 2022 10:43:51 -0800 (PST)
Received: from krzk-bin.NAT.warszawa.vectranet.pl (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id v7-20020a2ea607000000b0026e0434eb1esm159098ljp.67.2022.11.24.10.43.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Nov 2022 10:43:50 -0800 (PST)
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
Subject: [PATCH v3 07/15] dt-bindings: remoteproc: qcom,sm8350-pas: split into separate file
Date:   Thu, 24 Nov 2022 19:43:25 +0100
Message-Id: <20221124184333.133911-8-krzysztof.kozlowski@linaro.org>
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

Split SM8350 and SM8450 remote processor Peripheral Authentication
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
 .../bindings/remoteproc/qcom,adsp.yaml        |  48 -----
 .../bindings/remoteproc/qcom,sm8350-pas.yaml  | 174 ++++++++++++++++++
 2 files changed, 174 insertions(+), 48 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/remoteproc/qcom,sm8350-pas.yaml

diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,adsp.yaml b/Documentation/devicetree/bindings/remoteproc/qcom,adsp.yaml
index 596149f71485..67941e79a4a0 100644
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
@@ -109,14 +101,6 @@ allOf:
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
@@ -172,12 +156,6 @@ allOf:
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
@@ -196,8 +174,6 @@ allOf:
               - qcom,sdx55-mpss-pas
               - qcom,sm6350-mpss-pas
               - qcom,sm8150-mpss-pas
-              - qcom,sm8350-mpss-pas
-              - qcom,sm8450-mpss-pas
     then:
       properties:
         interrupts:
@@ -297,8 +273,6 @@ allOf:
               - qcom,sdx55-mpss-pas
               - qcom,sm6350-mpss-pas
               - qcom,sm8150-mpss-pas
-              - qcom,sm8350-mpss-pas
-              - qcom,sm8450-mpss-pas
     then:
       properties:
         power-domains:
@@ -322,10 +296,6 @@ allOf:
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
@@ -337,24 +307,6 @@ allOf:
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
index 000000000000..853f97d6879f
--- /dev/null
+++ b/Documentation/devicetree/bindings/remoteproc/qcom,sm8350-pas.yaml
@@ -0,0 +1,174 @@
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

