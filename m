Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F1AA62C322
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 16:54:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233627AbiKPPyc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 10:54:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233512AbiKPPyZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 10:54:25 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EFBD54B03
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 07:54:23 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id a29so30182426lfj.9
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 07:54:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2V12JlcSl94vkY+Edc4Ht8IeJ7PWHFm+mhf24WLZ2Qw=;
        b=KwgrFOsHiwli6p6CMq9Bb1Fb1eE4/yDd/K6K8OmelsXnDAC2GBcUIZdRyRwnlpsbyN
         q90Qj3pxb2RaMk0cwHNo0PUkT7Ut7hNLQLoCrdt58fNMhSullzfSXa1T/xCPfUSsydWv
         8RWEeal7Eoj+jFH4W8r89ntUNK9xWiTzQ5t0Pd59vf4Us/KWh0OHX346Z9lZvbDalnvR
         JiW2F/SgFr9E5D79jtXgIOpngXIdQb2KOX9uL7HOuIS8ENAWqkxuD13UjvRl65g6pgPM
         GxxNDEcIf1sGBm3uoFVLtvEwIswBMNx6m7ERA3l6667G9Y14NfY27ndjrykQ4RbUl0Kn
         Ey4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2V12JlcSl94vkY+Edc4Ht8IeJ7PWHFm+mhf24WLZ2Qw=;
        b=YpiCjWbMEYYrrOZerh5LsU1ksuQSRwCrV4tKzjewm7w3XW4O1cIm+/01WDX6t3E9TO
         GkJa/UkKk0cbKvC7qFRcIX//Pm8EusgNI9Xqox1vTY8ei4fXF8BX+JGB+xCY2PDFqdFC
         2zh7EQpQARpvVryoDVvHefKAr4/pkseQiJvUSCwUmKMyXQ6YjGaSnO5h5Jq1ZFgMstla
         MA+42RKELDs+Dbq4e4POzefa3Kvawu9lDL1t1NA5qv6fRssP8dSyYWPdaxsIvVWq8Lvd
         xXXj+O/KhssvaLBnLxMDEdGxWzEUaZ6910Fk9JEVC4Qi9FLi9nTMlCEb7JkutChxbxM2
         e/IA==
X-Gm-Message-State: ANoB5pletQ6DLLTScS50bIIszh1YflQ/We64fCAZSzHN0KZtNsgqwcFI
        Wp5r1Q5e7ncIcmoAsK2Sp+2a5g==
X-Google-Smtp-Source: AA0mqf7Pyq7IKTP1Qk6RdcPeEmpKpme+F23IbdPpGZsPqVxrs8VmdTCsIwcIBXLN013F8MJsl3IgCA==
X-Received: by 2002:a05:6512:3124:b0:4a4:77a8:5ba9 with SMTP id p4-20020a056512312400b004a477a85ba9mr6960474lfd.21.1668614061214;
        Wed, 16 Nov 2022 07:54:21 -0800 (PST)
Received: from krzk-bin.NAT.warszawa.vectranet.pl (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id u19-20020a05651220d300b0049462af8614sm2655128lfr.145.2022.11.16.07.54.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Nov 2022 07:54:20 -0800 (PST)
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
Subject: [PATCH 2/5] dt-bindings: remoteproc: qcom,sm8350-pas: split into separate file
Date:   Wed, 16 Nov 2022 16:54:13 +0100
Message-Id: <20221116155416.164239-3-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221116155416.164239-1-krzysztof.kozlowski@linaro.org>
References: <20221116155416.164239-1-krzysztof.kozlowski@linaro.org>
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
 .../bindings/remoteproc/qcom,adsp.yaml        |  48 -----
 .../bindings/remoteproc/qcom,sm8350-pas.yaml  | 188 ++++++++++++++++++
 2 files changed, 188 insertions(+), 48 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/remoteproc/qcom,sm8350-pas.yaml

diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,adsp.yaml b/Documentation/devicetree/bindings/remoteproc/qcom,adsp.yaml
index 49b789f8ef0c..c1d9bd364e90 100644
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
@@ -103,14 +95,6 @@ allOf:
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
@@ -220,12 +204,6 @@ allOf:
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
@@ -244,8 +222,6 @@ allOf:
               - qcom,sdx55-mpss-pas
               - qcom,sm6350-mpss-pas
               - qcom,sm8150-mpss-pas
-              - qcom,sm8350-mpss-pas
-              - qcom,sm8450-mpss-pas
     then:
       properties:
         interrupts:
@@ -345,8 +321,6 @@ allOf:
               - qcom,sdx55-mpss-pas
               - qcom,sm6350-mpss-pas
               - qcom,sm8150-mpss-pas
-              - qcom,sm8350-mpss-pas
-              - qcom,sm8450-mpss-pas
     then:
       properties:
         power-domains:
@@ -370,10 +344,6 @@ allOf:
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
@@ -385,24 +355,6 @@ allOf:
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
index 000000000000..5218ae2b0146
--- /dev/null
+++ b/Documentation/devicetree/bindings/remoteproc/qcom,sm8350-pas.yaml
@@ -0,0 +1,188 @@
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
+  Qualcomm SM8350/SM8450 SoC Peripheral Authentication Service loads and boots firmware
+  on the Qualcomm DSP Hexagon cores.
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

