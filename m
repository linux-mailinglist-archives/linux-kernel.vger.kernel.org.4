Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28BC2637F30
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 19:44:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229997AbiKXSo2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 13:44:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229908AbiKXSoL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 13:44:11 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD5EE12E20C
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 10:43:54 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id d6so3671966lfs.10
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 10:43:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hNv81I24c4nW4TnQKbq5VcxO89XGCSPoda7sXO5iVm0=;
        b=km8PpuycPK4oCL6FGMX69h4Q/f6PmRUrDk9iERcDyA+c1acXCMrWvs3Agt//LF50Db
         ENjoBkJPkWkF5GHSBFuYnLGFiBJh4XIa4tcSBjyBjesLv5ALRaTeoCqlm7H6/GFa0iaU
         2cccJOiQ5l9NU93rFuwSEe+qrpyI/Gt+LWQrUjHfKdAUtfve0vt7ZQSbImz6ACoxeAXh
         kHS6rs4Mc78zDoK8XHyIC2oazMiCTps8Ek0W9f7E33RcE3J63zgb6E8PvYnElk2ywkNR
         SUiRsfIVmhCDiXGYkygDmV5KWhHztX831OTTgKykwQL1/PI+dSYHlKyo3G68KZDW5muW
         oJug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hNv81I24c4nW4TnQKbq5VcxO89XGCSPoda7sXO5iVm0=;
        b=YnKECG/O8Bxx6gjL8t+EJB25YcA2PDjGtsOM4Ii29+Kqz57dFMNW5CV+9pOre7rszr
         rv9TPROuLX1aAX24aQXhnKlLiPb3i5f26xOTbQe9BON88e5EKQkPiZNfKieUsRoAh7HE
         OGqF14dD0ElCofzNS744+5Nl6ppH5bj+cIq4ExayQnpq09Q97bCyfqwYZcRagGIqdEeg
         kn+rZuPtKgb3D1guM2f8mp5bJQYXBRb9PAaatnTKPB8UVouBgv41D6ceNbGPMhurArzT
         hAOn3lDAYvjVU21pHqzLRFcpgl/2rTO+hzT8ijZ03ZYxM/5G9jHCIU21zYsegNU1Hs5B
         u/RQ==
X-Gm-Message-State: ANoB5pm9dzfyzeJDZwpyPx94mmZ0kLZvMlqco7lPLgaYwrgPyBz+tVTa
        OGWKoPoB1a+s2coPIHYJSeT3iw==
X-Google-Smtp-Source: AA0mqf6mzB/cTVPtIwD7M0XtdkTXEBm+Fvvs22pa6m+tpEhmxG+vIUJQtzQSbr2Kkd2qeShr7YsSIA==
X-Received: by 2002:a19:f716:0:b0:4b4:b5da:ea56 with SMTP id z22-20020a19f716000000b004b4b5daea56mr11264075lfe.547.1669315434096;
        Thu, 24 Nov 2022 10:43:54 -0800 (PST)
Received: from krzk-bin.NAT.warszawa.vectranet.pl (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id v7-20020a2ea607000000b0026e0434eb1esm159098ljp.67.2022.11.24.10.43.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Nov 2022 10:43:53 -0800 (PST)
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
Subject: [PATCH v3 09/15] dt-bindings: remoteproc: qcom,sm6350-pas: split into separate file
Date:   Thu, 24 Nov 2022 19:43:27 +0100
Message-Id: <20221124184333.133911-10-krzysztof.kozlowski@linaro.org>
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

Split SM6350 remote processor Peripheral Authentication Service bindings
into their own file to reduce complexity and make maintenance easier.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Changes since v2:
1. Drop if:then: for the clock and put it directly under properties.
2. Merge two if:then: clauses for setting interrupts.

Changes since v1:
1. Add qcom,qmp (not part of qcom,pas-common.yaml# anymore).
---
 .../bindings/remoteproc/qcom,adsp.yaml        |  28 ---
 .../bindings/remoteproc/qcom,sm6350-pas.yaml  | 159 ++++++++++++++++++
 2 files changed, 159 insertions(+), 28 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/remoteproc/qcom,sm6350-pas.yaml

diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,adsp.yaml b/Documentation/devicetree/bindings/remoteproc/qcom,adsp.yaml
index e8d66eefd522..b14a83da37c2 100644
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
@@ -84,9 +81,6 @@ allOf:
               - qcom,sc8280xp-nsp1-pas
               - qcom,sdm845-adsp-pas
               - qcom,sdm845-cdsp-pas
-              - qcom,sm6350-adsp-pas
-              - qcom,sm6350-cdsp-pas
-              - qcom,sm6350-mpss-pas
     then:
       properties:
         clocks:
@@ -134,8 +128,6 @@ allOf:
               - qcom,sc8280xp-nsp1-pas
               - qcom,sdm845-adsp-pas
               - qcom,sdm845-cdsp-pas
-              - qcom,sm6350-adsp-pas
-              - qcom,sm6350-cdsp-pas
     then:
       properties:
         interrupts:
@@ -152,7 +144,6 @@ allOf:
               - qcom,sc7280-mpss-pas
               - qcom,sc8180x-mpss-pas
               - qcom,sdx55-mpss-pas
-              - qcom,sm6350-mpss-pas
     then:
       properties:
         interrupts:
@@ -224,23 +215,6 @@ allOf:
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
@@ -248,7 +222,6 @@ allOf:
             enum:
               - qcom,sc7280-mpss-pas
               - qcom,sdx55-mpss-pas
-              - qcom,sm6350-mpss-pas
     then:
       properties:
         power-domains:
@@ -268,7 +241,6 @@ allOf:
               - qcom,sc8180x-adsp-pas
               - qcom,sc8180x-cdsp-pas
               - qcom,sc8280xp-adsp-pas
-              - qcom,sm6350-adsp-pas
     then:
       properties:
         power-domains:
diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,sm6350-pas.yaml b/Documentation/devicetree/bindings/remoteproc/qcom,sm6350-pas.yaml
new file mode 100644
index 000000000000..911529400142
--- /dev/null
+++ b/Documentation/devicetree/bindings/remoteproc/qcom,sm6350-pas.yaml
@@ -0,0 +1,159 @@
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
+            - qcom,sm6350-adsp-pas
+            - qcom,sm6350-cdsp-pas
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

