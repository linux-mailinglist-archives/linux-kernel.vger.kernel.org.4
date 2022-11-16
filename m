Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56F7A62C32A
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 16:54:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233761AbiKPPyq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 10:54:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233539AbiKPPy2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 10:54:28 -0500
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F75951C18
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 07:54:26 -0800 (PST)
Received: by mail-lj1-x235.google.com with SMTP id z24so22372414ljn.4
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 07:54:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RCQr1z1wFwAd1N4S4Gfm4bIvE8xYgZpk3YOweYwBoP8=;
        b=VhXvvsxy0oZ7u5eOmH8zlaXlosWHcNx6xj670/3wl2m7dx+TXjxfUwu7Ij8UP2Gt4J
         H2wkk0m66AzQfDvLzSickRqZmbBxtJg/4K/RSE8r2DsoDVetCiCnBR/Gv6RMJuuKSzBN
         1d10b/Da6Dvvx96E8UtBqJui2+WdyUfEuDdDiHpJ13bv6tDeBDznAAYA6HU1kWJVcKIF
         zelAGib+mEijRHdj1J6O5cBwBakJ4A4sX3iJUKkRMGYhRlIXOlEYPyseBuJjikNh6oEC
         dyIR0zqU1JplUZNJKzkQ+CDmdHrNf+jgkyZ8UKUCN3Orp8ImML0rHSOOwReQkZFYTIx6
         m+XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RCQr1z1wFwAd1N4S4Gfm4bIvE8xYgZpk3YOweYwBoP8=;
        b=m50QvHm6BHrB4BybR7n3PJ4JsmOzUc3XFPSKT/lxDQ96grUjCecv0SGBXO3zAowXRW
         70LLpYOysmD2IaB71xbjkmR22PkwNpRzEnsV1EdPLckL2YSqIWTRcH+VLFjM+2upVCXa
         c7XDqN1Ypx16gigf5XFM6p0yYnhrnFeixL9I07tOKn4uyG4In/Sv0k1eNiTLzYrcnOq0
         Sma0mYD+Kv1XB3wVy8buvU6HYAqS9gss/fj6qEEHiQiQoc/hi3asxMcxfGd0i27OJpT+
         yA1gPsTKADv9y5dvEgcfI00enx8oBZGNKoN57k7H0+A14UoXrFIcIpTS1av6ZZWj2Zxx
         v2PA==
X-Gm-Message-State: ANoB5pkfxQZDtqpT7bQ3Qrqwq4eNPJe5/V9gSZojv/0fwyf0HaSw3807
        ud7OWtOejeYWF366MFIi0N7qKQ==
X-Google-Smtp-Source: AA0mqf479H9+o0ei4Cn8YCPA4bFqg7QHuiZQirxu/475dKHAR6f1nInwwJG8qWtAlLxyXBXsvm291A==
X-Received: by 2002:a2e:bc11:0:b0:279:ab3:32e8 with SMTP id b17-20020a2ebc11000000b002790ab332e8mr4431430ljf.389.1668614065019;
        Wed, 16 Nov 2022 07:54:25 -0800 (PST)
Received: from krzk-bin.NAT.warszawa.vectranet.pl (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id u19-20020a05651220d300b0049462af8614sm2655128lfr.145.2022.11.16.07.54.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Nov 2022 07:54:24 -0800 (PST)
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
Subject: [PATCH 5/5] dt-bindings: remoteproc: qcom,sc8280xp-pas: split into separate file
Date:   Wed, 16 Nov 2022 16:54:16 +0100
Message-Id: <20221116155416.164239-6-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221116155416.164239-1-krzysztof.kozlowski@linaro.org>
References: <20221116155416.164239-1-krzysztof.kozlowski@linaro.org>
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

Split SC8280XP remote processor Peripheral Authentication Service bindings
into their own file to reduce complexity and make maintenance easier.

While moving correctly constrain the number of interrupts per specific
device.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../bindings/remoteproc/qcom,adsp.yaml        |  26 ---
 .../remoteproc/qcom,sc8280xp-pas.yaml         | 154 ++++++++++++++++++
 2 files changed, 154 insertions(+), 26 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/remoteproc/qcom,sc8280xp-pas.yaml

diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,adsp.yaml b/Documentation/devicetree/bindings/remoteproc/qcom,adsp.yaml
index 1460fbd5adab..fc3d2363ac23 100644
--- a/Documentation/devicetree/bindings/remoteproc/qcom,adsp.yaml
+++ b/Documentation/devicetree/bindings/remoteproc/qcom,adsp.yaml
@@ -30,9 +30,6 @@ properties:
       - qcom,sc8180x-adsp-pas
       - qcom,sc8180x-cdsp-pas
       - qcom,sc8180x-mpss-pas
-      - qcom,sc8280xp-adsp-pas
-      - qcom,sc8280xp-nsp0-pas
-      - qcom,sc8280xp-nsp1-pas
       - qcom,sdm660-adsp-pas
       - qcom,sdm845-adsp-pas
       - qcom,sdm845-cdsp-pas
@@ -70,9 +67,6 @@ allOf:
               - qcom,sc8180x-adsp-pas
               - qcom,sc8180x-cdsp-pas
               - qcom,sc8180x-mpss-pas
-              - qcom,sc8280xp-adsp-pas
-              - qcom,sc8280xp-nsp0-pas
-              - qcom,sc8280xp-nsp1-pas
               - qcom,sdm845-adsp-pas
               - qcom,sdm845-cdsp-pas
     then:
@@ -171,9 +165,6 @@ allOf:
               - qcom,qcs404-wcss-pas
               - qcom,sc8180x-adsp-pas
               - qcom,sc8180x-cdsp-pas
-              - qcom,sc8280xp-adsp-pas
-              - qcom,sc8280xp-nsp0-pas
-              - qcom,sc8280xp-nsp1-pas
               - qcom,sdm845-adsp-pas
               - qcom,sdm845-cdsp-pas
     then:
@@ -288,7 +279,6 @@ allOf:
             enum:
               - qcom,sc8180x-adsp-pas
               - qcom,sc8180x-cdsp-pas
-              - qcom,sc8280xp-adsp-pas
     then:
       properties:
         power-domains:
@@ -300,22 +290,6 @@ allOf:
             - const: lcx
             - const: lmx
 
-  - if:
-      properties:
-        compatible:
-          contains:
-            enum:
-              - qcom,sc8280xp-nsp0-pas
-              - qcom,sc8280xp-nsp1-pas
-    then:
-      properties:
-        power-domains:
-          items:
-            - description: NSP power domain
-        power-domain-names:
-          items:
-            - const: nsp
-
   - if:
       properties:
         compatible:
diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,sc8280xp-pas.yaml b/Documentation/devicetree/bindings/remoteproc/qcom,sc8280xp-pas.yaml
new file mode 100644
index 000000000000..7efdd684f0eb
--- /dev/null
+++ b/Documentation/devicetree/bindings/remoteproc/qcom,sc8280xp-pas.yaml
@@ -0,0 +1,154 @@
+# SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/remoteproc/qcom,sc8280xp-pas.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm SC8280XP Peripheral Authentication Service
+
+maintainers:
+  - Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
+
+description:
+  Qualcomm SC8280XP SoC Peripheral Authentication Service loads and boots
+  firmware on the Qualcomm DSP Hexagon cores.
+
+properties:
+  compatible:
+    enum:
+      - qcom,sc8280xp-adsp-pas
+      - qcom,sc8280xp-nsp0-pas
+      - qcom,sc8280xp-nsp1-pas
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
+            - qcom,sc8280xp-adsp-pas
+            - qcom,sc8280xp-nsp0-pas
+            - qcom,sc8280xp-nsp1-pas
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
+            - qcom,sc8280xp-nsp0-pas
+            - qcom,sc8280xp-nsp1-pas
+    then:
+      properties:
+        interrupts:
+          minItems: 5
+        interrupt-names:
+          maxItems: 5
+
+  - if:
+      properties:
+        compatible:
+          enum:
+            - qcom,sc8280xp-adsp-pas
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
+            - qcom,sc8280xp-adsp-pas
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
+            - qcom,sc8280xp-nsp0-pas
+            - qcom,sc8280xp-nsp1-pas
+    then:
+      properties:
+        power-domains:
+          items:
+            - description: NSP power domain
+        power-domain-names:
+          items:
+            - const: nsp
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/qcom,rpmh.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+    #include <dt-bindings/mailbox/qcom-ipcc.h>
+    #include <dt-bindings/power/qcom-rpmpd.h>
+
+    remoteproc@3000000 {
+        compatible = "qcom,sc8280xp-adsp-pas";
+        reg = <0x03000000 0x100>;
+
+        clocks = <&rpmhcc RPMH_CXO_CLK>;
+        clock-names = "xo";
+
+        interrupts-extended = <&intc GIC_SPI 162 IRQ_TYPE_LEVEL_HIGH>,
+                              <&smp2p_adsp_in 0 IRQ_TYPE_EDGE_RISING>,
+                              <&smp2p_adsp_in 1 IRQ_TYPE_EDGE_RISING>,
+                              <&smp2p_adsp_in 2 IRQ_TYPE_EDGE_RISING>,
+                              <&smp2p_adsp_in 3 IRQ_TYPE_EDGE_RISING>,
+                              <&smp2p_adsp_in 7 IRQ_TYPE_EDGE_RISING>;
+        interrupt-names = "wdog", "fatal", "ready",
+                          "handover", "stop-ack", "shutdown-ack";
+
+        memory-region = <&pil_adsp_mem>;
+
+        power-domains = <&rpmhpd SC8280XP_LCX>,
+                        <&rpmhpd SC8280XP_LMX>;
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

