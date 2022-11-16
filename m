Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51CB362C329
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 16:54:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233467AbiKPPym (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 10:54:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233523AbiKPPy1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 10:54:27 -0500
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FB4E286E5
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 07:54:25 -0800 (PST)
Received: by mail-lj1-x231.google.com with SMTP id a15so22334327ljb.7
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 07:54:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o6viXCq0jHK5utKMBOmXoIEjhRqi04K4NyL3hmOqLsU=;
        b=xWZv+fM9L/19lQIosDNS2glwDsdMXS+bvGGIa2VfP7iX76+09NcCoqEjwynONcHuiK
         FPvucmMVLsk3rfQGNpb1vATPCSQYVoBA8RGZgI+s4skT95gHzp4lXpNWOrKtA9Zod1UE
         FUGUn2yzrO1/7aRVIJF9ZzpsjYUpsyP9t+FfG0lD/tlZe/UF2q/j9sAOraalBwjFyuMO
         Sz89YDmhVpRYOOmSwsN4KNUFbzBSaeACX0//1ZEZbieM8/20KlEOeZj0OxEf3/zaDt/H
         qg1Bm74xu0eYUvEFWoRi8XpsgzMhtA0+POsSklui5XAaweZT2NdPqIp+ExVbSZZ+DUBG
         hu2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o6viXCq0jHK5utKMBOmXoIEjhRqi04K4NyL3hmOqLsU=;
        b=EVPe/HviZaoG9sKvku0otHJmdaxklQ5QU3BJ8bUXKRuo2nv//p8xSVjc0iXm+8sc9V
         uRWtlJmvcJYrN/N/6RJyp1ifoh95jTApcyrajEijcdG7W5/BGGTeD/lnBiIjerJ1+3Ez
         arBNm6/C7bXoZ5RowxNANGgScdQrASI9UCUtkdL28kLBgQQbdFx/Zqkst2ijJhCHm4Ji
         RyZZ5Mo/riYeeW72BG1/fKrT08CF6HZALrYBo8l31XH4iLtpGxZV58F7pvS1APMdZKGK
         R1ykXNsGCDFsDch4u7Bp2Vy6/2UjDKcM0puUZLI5UlcNUgah+8sMwjJvSajJpJyKBh6r
         bERA==
X-Gm-Message-State: ANoB5pksXGI9zOD4lGn/ZfWPbyJm0mAPwVTjZi3eRR9ivqlqXQgVV/lF
        UbIFLwtbhFiwYUn+26O5ZwsrK57dPkLAqqrH
X-Google-Smtp-Source: AA0mqf6nGtebfpGua843f2jZokAmxmc72a1Y+vHKzQavPsQRLjoIloVJEK3v8jIXsdgxwUjzXFkHvA==
X-Received: by 2002:a2e:9052:0:b0:277:56d:fcfb with SMTP id n18-20020a2e9052000000b00277056dfcfbmr7416354ljg.264.1668614064000;
        Wed, 16 Nov 2022 07:54:24 -0800 (PST)
Received: from krzk-bin.NAT.warszawa.vectranet.pl (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id u19-20020a05651220d300b0049462af8614sm2655128lfr.145.2022.11.16.07.54.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Nov 2022 07:54:23 -0800 (PST)
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
Subject: [PATCH 4/5] dt-bindings: remoteproc: qcom,sm6350-pas: split into separate file
Date:   Wed, 16 Nov 2022 16:54:15 +0100
Message-Id: <20221116155416.164239-5-krzysztof.kozlowski@linaro.org>
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

Split SM6350 remote processor Peripheral Authentication Service bindings
into their own file to reduce complexity and make maintenance easier.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../bindings/remoteproc/qcom,adsp.yaml        |  28 ---
 .../bindings/remoteproc/qcom,sm6350-pas.yaml  | 169 ++++++++++++++++++
 2 files changed, 169 insertions(+), 28 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/remoteproc/qcom,sm6350-pas.yaml

diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,adsp.yaml b/Documentation/devicetree/bindings/remoteproc/qcom,adsp.yaml
index 875783b6b585..1460fbd5adab 100644
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
@@ -78,9 +75,6 @@ allOf:
               - qcom,sc8280xp-nsp1-pas
               - qcom,sdm845-adsp-pas
               - qcom,sdm845-cdsp-pas
-              - qcom,sm6350-adsp-pas
-              - qcom,sm6350-cdsp-pas
-              - qcom,sm6350-mpss-pas
     then:
       properties:
         clocks:
@@ -182,8 +176,6 @@ allOf:
               - qcom,sc8280xp-nsp1-pas
               - qcom,sdm845-adsp-pas
               - qcom,sdm845-cdsp-pas
-              - qcom,sm6350-adsp-pas
-              - qcom,sm6350-cdsp-pas
     then:
       properties:
         interrupts:
@@ -200,7 +192,6 @@ allOf:
               - qcom,sc7280-mpss-pas
               - qcom,sc8180x-mpss-pas
               - qcom,sdx55-mpss-pas
-              - qcom,sm6350-mpss-pas
     then:
       properties:
         interrupts:
@@ -272,23 +263,6 @@ allOf:
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
@@ -296,7 +270,6 @@ allOf:
             enum:
               - qcom,sc7280-mpss-pas
               - qcom,sdx55-mpss-pas
-              - qcom,sm6350-mpss-pas
     then:
       properties:
         power-domains:
@@ -316,7 +289,6 @@ allOf:
               - qcom,sc8180x-adsp-pas
               - qcom,sc8180x-cdsp-pas
               - qcom,sc8280xp-adsp-pas
-              - qcom,sm6350-adsp-pas
     then:
       properties:
         power-domains:
diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,sm6350-pas.yaml b/Documentation/devicetree/bindings/remoteproc/qcom,sm6350-pas.yaml
new file mode 100644
index 000000000000..092d90beb91d
--- /dev/null
+++ b/Documentation/devicetree/bindings/remoteproc/qcom,sm6350-pas.yaml
@@ -0,0 +1,169 @@
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

