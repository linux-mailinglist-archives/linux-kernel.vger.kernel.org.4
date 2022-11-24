Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F702637F44
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 19:45:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230062AbiKXSpB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 13:45:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229985AbiKXSoY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 13:44:24 -0500
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD655133970
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 10:44:00 -0800 (PST)
Received: by mail-lj1-x236.google.com with SMTP id a15so2848654ljb.7
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 10:44:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/yDE3gRUNG67QM74MH23NrqOxB5UmpZn9c+KMHml1Tg=;
        b=flDS2b0G431Ael55u4XvBgIdPcY0/tcfoay6S8aRcUCQQYnAeOGkAHzYtKgbzHDQZj
         Appvy3+589mSyojvsHBWQnIAftbxKUMLqknmn7ygiTbolRDE6iW9VYpc2jgEz29xbdiS
         6pPTrm5cl6+ZidZNKzWR0G653TMIQKQG+wMfVX8qBAay2AJm7VgXI/1S5s7xJ4+Qox8C
         5QT7rlR3OyjH3mx7s2fY3TKUcCOqjnUAQP2rBERFdPCn8VbgKs3IvX4GQfEL/8JdBXKz
         oKhArWVjy5+4awHVxZGmziaTBoH1gDijgEzrwxanSEuDwIB/cFH90WuhuvPFY0fR7KCY
         Zh+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/yDE3gRUNG67QM74MH23NrqOxB5UmpZn9c+KMHml1Tg=;
        b=MjivS7BlCKDiXWtbplHMPOjWpSfNvPN0ZHGEB4TI2nqT/keClcQ7OIVvzKRxZCTFB/
         zxyjyoIUL2tUL4OYxi+Po4KSrnBpzJClL+h/EzAU+Vj+4zRyCF4D24Kw2jAune4qE6To
         0YJbbUjZR8wuopgonR15dybkF/D85KNciCOD0xe2FLAw8fYq+Z/oh5dEXHfM9AfXsooD
         I5HWueWhrBbBPLB/hEwoGkpi+sW67oxu+NdRb2zSWeSzpAeoNNxOqVfHspVaGUK9ds+r
         5+LyNSBWipqvC/BJHHY5jtPWoK2Ini9bN7yOFCbtR3cbJPtOw+mUnnxpfeAZbjTARNky
         8E9w==
X-Gm-Message-State: ANoB5pmRuBqiksO6ax0HCJqrYL40k5P58ChRoXtfNsCbiPLY5uAu1FJE
        oJWiZaeo7cTthY17Ej2W0G08ow==
X-Google-Smtp-Source: AA0mqf64hjLBIk366+jisGSi2sQaCYHQutz3nogH6c63mAGFQvmMIm4fkSYiAaSXqzY8nxpiryyd0A==
X-Received: by 2002:a05:651c:906:b0:279:1349:b2e2 with SMTP id e6-20020a05651c090600b002791349b2e2mr10464425ljq.382.1669315438899;
        Thu, 24 Nov 2022 10:43:58 -0800 (PST)
Received: from krzk-bin.NAT.warszawa.vectranet.pl (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id v7-20020a2ea607000000b0026e0434eb1esm159098ljp.67.2022.11.24.10.43.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Nov 2022 10:43:58 -0800 (PST)
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
Subject: [PATCH v3 13/15] dt-bindings: remoteproc: qcom,qcs404-pas: split into separate file
Date:   Thu, 24 Nov 2022 19:43:31 +0100
Message-Id: <20221124184333.133911-14-krzysztof.kozlowski@linaro.org>
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

Split QCS404 remote processor Peripheral Authentication Service bindings
into their own file to reduce complexity and make maintenance easier.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Changes since v2:
1. New patch.
---
 .../bindings/remoteproc/qcom,adsp.yaml        | 12 ---
 .../bindings/remoteproc/qcom,qcs404-pas.yaml  | 86 +++++++++++++++++++
 2 files changed, 86 insertions(+), 12 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/remoteproc/qcom,qcs404-pas.yaml

diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,adsp.yaml b/Documentation/devicetree/bindings/remoteproc/qcom,adsp.yaml
index 10c96445da11..9fdfa9476ca9 100644
--- a/Documentation/devicetree/bindings/remoteproc/qcom,adsp.yaml
+++ b/Documentation/devicetree/bindings/remoteproc/qcom,adsp.yaml
@@ -22,9 +22,6 @@ properties:
       - qcom,msm8996-slpi-pil
       - qcom,msm8998-adsp-pas
       - qcom,msm8998-slpi-pas
-      - qcom,qcs404-adsp-pas
-      - qcom,qcs404-cdsp-pas
-      - qcom,qcs404-wcss-pas
       - qcom,sc7180-mpss-pas
       - qcom,sc7280-mpss-pas
       - qcom,sdm660-adsp-pas
@@ -61,9 +58,6 @@ allOf:
               - qcom,msm8996-adsp-pil
               - qcom,msm8996-slpi-pil
               - qcom,msm8998-adsp-pas
-              - qcom,qcs404-adsp-pas
-              - qcom,qcs404-cdsp-pas
-              - qcom,qcs404-wcss-pas
               - qcom,sc7180-mpss-pas
               - qcom,sc7280-mpss-pas
               - qcom,sdm845-adsp-pas
@@ -105,9 +99,6 @@ allOf:
               - qcom,msm8996-slpi-pil
               - qcom,msm8998-adsp-pas
               - qcom,msm8998-slpi-pas
-              - qcom,qcs404-adsp-pas
-              - qcom,qcs404-cdsp-pas
-              - qcom,qcs404-wcss-pas
               - qcom,sdm845-adsp-pas
               - qcom,sdm845-cdsp-pas
     then:
@@ -223,9 +214,6 @@ allOf:
               - qcom,msm8996-slpi-pil
               - qcom,msm8998-adsp-pas
               - qcom,msm8998-slpi-pas
-              - qcom,qcs404-adsp-pas
-              - qcom,qcs404-cdsp-pas
-              - qcom,qcs404-wcss-pas
               - qcom,sdm660-adsp-pas
     then:
       properties:
diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,qcs404-pas.yaml b/Documentation/devicetree/bindings/remoteproc/qcom,qcs404-pas.yaml
new file mode 100644
index 000000000000..007349ef51ed
--- /dev/null
+++ b/Documentation/devicetree/bindings/remoteproc/qcom,qcs404-pas.yaml
@@ -0,0 +1,86 @@
+# SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/remoteproc/qcom,qcs404-pas.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm QCS404 Peripheral Authentication Service
+
+maintainers:
+  - Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
+
+description:
+  Qualcomm QCS404 SoC Peripheral Authentication Service loads and boots
+  firmware on the Qualcomm DSP Hexagon cores.
+
+properties:
+  compatible:
+    enum:
+      - qcom,qcs404-adsp-pas
+      - qcom,qcs404-cdsp-pas
+      - qcom,qcs404-wcss-pas
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
+    maxItems: 5
+
+  interrupt-names:
+    maxItems: 5
+
+  power-domains: false
+  power-domain-names: false
+  smd-edge: false
+
+required:
+  - compatible
+  - reg
+
+allOf:
+  - $ref: /schemas/remoteproc/qcom,pas-common.yaml#
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    remoteproc@c700000 {
+        compatible = "qcom,qcs404-adsp-pas";
+        reg = <0x0c700000 0x4040>;
+
+        clocks = <&xo_board>;
+        clock-names = "xo";
+
+        interrupts-extended = <&intc GIC_SPI 293 IRQ_TYPE_EDGE_RISING>,
+                              <&adsp_smp2p_in 0 IRQ_TYPE_EDGE_RISING>,
+                              <&adsp_smp2p_in 1 IRQ_TYPE_EDGE_RISING>,
+                              <&adsp_smp2p_in 2 IRQ_TYPE_EDGE_RISING>,
+                              <&adsp_smp2p_in 3 IRQ_TYPE_EDGE_RISING>;
+        interrupt-names = "wdog", "fatal", "ready",
+                          "handover", "stop-ack";
+
+        memory-region = <&adsp_fw_mem>;
+
+        qcom,smem-states = <&adsp_smp2p_out 0>;
+        qcom,smem-state-names = "stop";
+
+        glink-edge {
+            interrupts = <GIC_SPI 289 IRQ_TYPE_EDGE_RISING>;
+
+            qcom,remote-pid = <2>;
+            mboxes = <&apcs_glb 8>;
+
+            label = "adsp";
+        };
+    };
-- 
2.34.1

