Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF73562F4F9
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 13:35:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241920AbiKRMez (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 07:34:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241782AbiKRMe3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 07:34:29 -0500
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F11C485EC9
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 04:34:20 -0800 (PST)
Received: by mail-lj1-x22c.google.com with SMTP id h12so6575094ljg.9
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 04:34:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pch0UU53BjlYAfxkLJM1TCs6TcWgBHpSUU1H4+uHyUY=;
        b=bPz8iGYfN03l/g4R646ZpyDhaxZ4np7Euuy6IYq/u0TgiUb8UeWJvRo14SNb+QYvDm
         TI/8bObBe4bop5TmaqxRZz1D5STixDig9n16IWtEAQIt8eQQaytemZsBSIzyQ37xA/SU
         DPKNrvPomQ8aHDsT/zFYUQKMSAGduqs7XBDBZuywSZUmK8RKAcRPxb2WSURjbd+Hxyso
         xw2K08KrUGUnG19JgGoPek3a0E/LJsPo868w1AZ0Ny7BUw49mzt5sml/irlV/VisHj4S
         p6eumRN4NjA4tQ0R9W9nmKm1w9SQpn9NqO+CoYj/18ppE9uPVcqFrIdXeUBIwmmiOq77
         piNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Pch0UU53BjlYAfxkLJM1TCs6TcWgBHpSUU1H4+uHyUY=;
        b=JpRc6ApFEBOqqdUKAMUUhJD5z+fwLisC2ASVy71kbQ+7g9xGraN52Q2JIEKNqciDbM
         CKm389nzrOyO5ew+CaKJMepzoWQ6e/H7uLh/Am2Mv2iyq9kgQ69VFevCYrQL6VV7r8H4
         MkPhdl403cvpeL8bVa/0pWyRF+XK9lkXLYOrEBe9YuewElgSJnBB4/jaD8mQZom86xem
         Bej6TDZSYi+zw7klM97GH1L0XyUXXI296nkSyVTWZbiuuGtvn2pyimhdyBVZgR1yKBfP
         xXleGOesS9MJ164W20C2J0FKOhQFqqvpOC82/YvNglQlDP6pLTy9s3OgEu3W1t/nueXj
         8Aww==
X-Gm-Message-State: ANoB5pnuG8308NC9zOrFPYlVfm6YFC2w3ZYd+NGpr48PmkmDN743GkKq
        Nxc2VJf1Jfucwm6KYauJdT7O5w==
X-Google-Smtp-Source: AA0mqf4rbzYxCQ+s0wDzI92fzcPuuaVJ2B4Vd2YjS7MNNmhD/6C0BJcs8NRioyvquU0EAdIbtj/EyA==
X-Received: by 2002:a2e:b63b:0:b0:277:56d:fcfb with SMTP id s27-20020a2eb63b000000b00277056dfcfbmr2246557ljn.264.1668774860518;
        Fri, 18 Nov 2022 04:34:20 -0800 (PST)
Received: from krzk-bin.NAT.warszawa.vectranet.pl (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id m10-20020a19434a000000b004ac088fdfd2sm645833lfj.85.2022.11.18.04.34.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Nov 2022 04:34:20 -0800 (PST)
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
Subject: [PATCH v2 5/7] dt-bindings: remoteproc: qcom,sc8280xp-pas: split into separate file
Date:   Fri, 18 Nov 2022 13:34:00 +0100
Message-Id: <20221118123402.95784-6-krzysztof.kozlowski@linaro.org>
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

Split SC8280XP remote processor Peripheral Authentication Service bindings
into their own file to reduce complexity and make maintenance easier.

While moving correctly constrain the number of interrupts per specific
device.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Changes since v1:
1. Add qcom,qmp (not part of qcom,pas-common.yaml# anymore).
2. Add firmware-name to example.
3. Correct maxItems: 5 for interrupts.
---
 .../bindings/remoteproc/qcom,adsp.yaml        |  26 ---
 .../remoteproc/qcom,sc8280xp-pas.yaml         | 160 ++++++++++++++++++
 2 files changed, 160 insertions(+), 26 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/remoteproc/qcom,sc8280xp-pas.yaml

diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,adsp.yaml b/Documentation/devicetree/bindings/remoteproc/qcom,adsp.yaml
index 8f491ded8816..ea2c14a2f3f9 100644
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
@@ -94,9 +91,6 @@ allOf:
               - qcom,sc8180x-adsp-pas
               - qcom,sc8180x-cdsp-pas
               - qcom,sc8180x-mpss-pas
-              - qcom,sc8280xp-adsp-pas
-              - qcom,sc8280xp-nsp0-pas
-              - qcom,sc8280xp-nsp1-pas
               - qcom,sdm845-adsp-pas
               - qcom,sdm845-cdsp-pas
     then:
@@ -195,9 +189,6 @@ allOf:
               - qcom,qcs404-wcss-pas
               - qcom,sc8180x-adsp-pas
               - qcom,sc8180x-cdsp-pas
-              - qcom,sc8280xp-adsp-pas
-              - qcom,sc8280xp-nsp0-pas
-              - qcom,sc8280xp-nsp1-pas
               - qcom,sdm845-adsp-pas
               - qcom,sdm845-cdsp-pas
     then:
@@ -312,7 +303,6 @@ allOf:
             enum:
               - qcom,sc8180x-adsp-pas
               - qcom,sc8180x-cdsp-pas
-              - qcom,sc8280xp-adsp-pas
     then:
       properties:
         power-domains:
@@ -324,22 +314,6 @@ allOf:
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
index 000000000000..c7300354a075
--- /dev/null
+++ b/Documentation/devicetree/bindings/remoteproc/qcom,sc8280xp-pas.yaml
@@ -0,0 +1,160 @@
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
+          maxItems: 5
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
+        firmware-name = "qcom/sc8280xp/qcadsp8280.mbn";
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

