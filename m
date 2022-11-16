Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14BE262C324
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 16:54:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233677AbiKPPyg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 10:54:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233206AbiKPPy0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 10:54:26 -0500
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5121954B16
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 07:54:24 -0800 (PST)
Received: by mail-lj1-x22a.google.com with SMTP id s24so22349028ljs.11
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 07:54:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c4jPMesfhnIvrI/3c1kKO64Ncpx1Za6PsYpRjprnN80=;
        b=huBl6kx6emJZurCWmJIfIQ18F783gU1UOmrI3U3UaIUvJp6xQDC9tK23PlxTuwov7q
         fQRmz8731hmNAg68nW5d/r0w9JS0RNGc6+L38aqbvHrubjsrFtxkDBeJ9dWBofxihtUt
         aVCmjrvijA8hRK71xAFO6EodDDOyME6bbaUzEFoSx6m0/uf+HDoFd2d1oJW75Fh6l69R
         0t84ePnKdQduQuPmdRMzkhntv/WxsgLij1fbzPOV3QR3qSLhOO1GF4vNc96MCohSEz7Z
         I5f10eBpTfdqDMeKD6Z44hvNV14pcXlbOH8aJdQQbRG/4u2/WN/caSVCmTkM0wvlRUU1
         pfQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c4jPMesfhnIvrI/3c1kKO64Ncpx1Za6PsYpRjprnN80=;
        b=UEJE5d+rYb/BFobemchqKKmas5zAAyHVsBD2snDJRHbDC72f1TiqL5oHvQI7VU5Ymu
         PMuEAA9af16hH85lNluNYUD4qiMprp9ri/dHDkp43FU/lQcf1RIUeWKn3Kr4c4lXNX0D
         7EEjICWdJSjYbmEVzBkPyucuYnWFWOFB3c1oVan6fp0cemwr+9iF5+pkDCt0Wmx+jdWi
         eDcXeJQDjX0jba6V/Tov+v4hATKfY7YynmvADsNusXDiEZxJw0oPlAz9QxBdB1Cav1Hl
         76rt5L/T1gliwTcPsSmUIwe2jY4KlyTom8XPT09e1CfEvba9XgR0SQuYOGXWrR1dedvT
         7IwQ==
X-Gm-Message-State: ANoB5pnQ+JzsH/Qzg1K37Hht6h7XX8TxidEZlxI8bnaSttOeGJGZYbjF
        ocm6dDYPh9xtAks8OxEPdH651qopC3wIovN2
X-Google-Smtp-Source: AA0mqf4P3eefzNNNSA2q2lAG9158D4fO3oskqCaK8tvGiYggUfUErWJBWl3huY+qjG3X1VRxuu+xfA==
X-Received: by 2002:a05:651c:194f:b0:278:eef5:8d19 with SMTP id bs15-20020a05651c194f00b00278eef58d19mr6551094ljb.429.1668614062659;
        Wed, 16 Nov 2022 07:54:22 -0800 (PST)
Received: from krzk-bin.NAT.warszawa.vectranet.pl (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id u19-20020a05651220d300b0049462af8614sm2655128lfr.145.2022.11.16.07.54.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Nov 2022 07:54:22 -0800 (PST)
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
Subject: [PATCH 3/5] dt-bindings: remoteproc: qcom,sm8150-pas: split into separate file
Date:   Wed, 16 Nov 2022 16:54:14 +0100
Message-Id: <20221116155416.164239-4-krzysztof.kozlowski@linaro.org>
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

Split SM8150 and SM8250 remote processor Peripheral Authentication
Service bindings into their own file to reduce complexity and make
maintenance easier.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../bindings/remoteproc/qcom,adsp.yaml        |  27 ---
 .../bindings/remoteproc/qcom,sm8150-pas.yaml  | 178 ++++++++++++++++++
 2 files changed, 178 insertions(+), 27 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/remoteproc/qcom,sm8150-pas.yaml

diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,adsp.yaml b/Documentation/devicetree/bindings/remoteproc/qcom,adsp.yaml
index c1d9bd364e90..875783b6b585 100644
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
@@ -88,13 +81,6 @@ allOf:
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
@@ -198,12 +184,6 @@ allOf:
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
@@ -221,7 +201,6 @@ allOf:
               - qcom,sc8180x-mpss-pas
               - qcom,sdx55-mpss-pas
               - qcom,sm6350-mpss-pas
-              - qcom,sm8150-mpss-pas
     then:
       properties:
         interrupts:
@@ -247,8 +226,6 @@ allOf:
               - qcom,msm8226-adsp-pil
               - qcom,msm8996-adsp-pil
               - qcom,msm8998-adsp-pas
-              - qcom,sm8150-adsp-pas
-              - qcom,sm8150-cdsp-pas
     then:
       properties:
         power-domains:
@@ -320,7 +297,6 @@ allOf:
               - qcom,sc7280-mpss-pas
               - qcom,sdx55-mpss-pas
               - qcom,sm6350-mpss-pas
-              - qcom,sm8150-mpss-pas
     then:
       properties:
         power-domains:
@@ -341,9 +317,6 @@ allOf:
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
index 000000000000..bbf949711ec5
--- /dev/null
+++ b/Documentation/devicetree/bindings/remoteproc/qcom,sm8150-pas.yaml
@@ -0,0 +1,178 @@
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

