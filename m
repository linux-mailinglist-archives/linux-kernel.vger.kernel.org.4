Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1642366577B
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 10:30:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238620AbjAKJ21 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 04:28:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238357AbjAKJ1d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 04:27:33 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEE4C7653
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 01:26:46 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id bs20so14392289wrb.3
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 01:26:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ijaG+3xVaggm1nN+YcJuB4uQ1h3E1edhyS34My8RK9U=;
        b=UcUYdgfVkx+/huAyFeMIWq8AKsuIT0lCwNpCXQwNVxsODhE41vFlTpK8oQKQu+Sk71
         iqec1Emx+AcrhMNnDTtIWB5rcBjluIlmnp/5ELGY4JzgfMgtzVTjX/IhDWZQWKLJvRwQ
         AkmD2kUOJSf2R1hHeC6YrhN9ft2+2uzev5DMoh8YvtozEZ99koeXsTHQ9TAuopT7a81/
         cslX1oYfNQtWJcdUbGuiJc+JXsj8F98jvbT1XPHtD4G5WhWfdSx1RzoDtD1jFfDlueYM
         UlZFGhZAGwP7sb9TmRgY1ItfLLF6WTX7Smatl/VzuPzXOpH8lZ2cwM0XK5P4x9SEm2AV
         bgHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ijaG+3xVaggm1nN+YcJuB4uQ1h3E1edhyS34My8RK9U=;
        b=3Fv24QT61n3dBI2FfjtYFleJUi8asy+c8P0Qh0grCsBmmippb4Gks1y/TRgLqbN3kZ
         U26ydMRGyEuGb59lMbXs9y5dg8s5K3sLQHwPhFC+SBe/z5ul6Vma+RiBu6jQoNPxpfyA
         5etqCfTXQZqbLeli5EOITfZqCn97JPL2j0TnWBJxfRH+322f/Rmx33QUfraxpIBkcbgO
         tfwXGs7L0LKRNx6Y5Fbl8GMP2S+JlJFO41XPJ5H0brOhAzihdI4XC7fl+0sjydIgaDQO
         DOpf00SNsLzupoF+fIaEPYJseCKIfpXj/yYKkP95yF+o3KC8UkAdL/gTB2AHxqwvG9mA
         +zcQ==
X-Gm-Message-State: AFqh2kp/Xg994wcBBI6aTBskcyz309CP914zeNHskWFLFi/eJvcWwDho
        iJZuP6rjfxj7r5VHwQABB+IL2g==
X-Google-Smtp-Source: AMrXdXua/exNGec9rYPEz47RlWiBjQQnRKQ6BT4h4yhr8xgtTjbwLnicEOy45QbTWwqIwl9PFLzauA==
X-Received: by 2002:adf:f107:0:b0:284:5050:5e4f with SMTP id r7-20020adff107000000b0028450505e4fmr33901248wro.33.1673429205337;
        Wed, 11 Jan 2023 01:26:45 -0800 (PST)
Received: from krzk-bin.. ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id n16-20020a5d4010000000b002bbed1388a5sm7954177wrp.15.2023.01.11.01.26.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jan 2023 01:26:45 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Georgi Djakov <djakov@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Odelu Kukatla <okukatla@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2 3/3] dt-bindings: interconnect: split SM8450 to own schema
Date:   Wed, 11 Jan 2023 10:26:37 +0100
Message-Id: <20230111092637.17946-3-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230111092637.17946-1-krzysztof.kozlowski@linaro.org>
References: <20230111092637.17946-1-krzysztof.kozlowski@linaro.org>
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

SM8450 comes with interconnects having and missing IO address space, and
variable number of clocks, so split it from common file for easier
maintenance and to fix warnings like:

  sm8450-hdk.dtb: interconnect-0: 'reg' is a required property

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../bindings/interconnect/qcom,rpmh.yaml      |  11 --
 .../interconnect/qcom,sm8450-rpmh.yaml        | 124 ++++++++++++++++++
 2 files changed, 124 insertions(+), 11 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/interconnect/qcom,sm8450-rpmh.yaml

diff --git a/Documentation/devicetree/bindings/interconnect/qcom,rpmh.yaml b/Documentation/devicetree/bindings/interconnect/qcom,rpmh.yaml
index 448829ecf6b6..335836a1b3c4 100644
--- a/Documentation/devicetree/bindings/interconnect/qcom,rpmh.yaml
+++ b/Documentation/devicetree/bindings/interconnect/qcom,rpmh.yaml
@@ -97,17 +97,6 @@ properties:
       - qcom,sm8350-mmss-noc
       - qcom,sm8350-compute-noc
       - qcom,sm8350-system-noc
-      - qcom,sm8450-aggre1-noc
-      - qcom,sm8450-aggre2-noc
-      - qcom,sm8450-clk-virt
-      - qcom,sm8450-config-noc
-      - qcom,sm8450-gem-noc
-      - qcom,sm8450-lpass-ag-noc
-      - qcom,sm8450-mc-virt
-      - qcom,sm8450-mmss-noc
-      - qcom,sm8450-nsp-noc
-      - qcom,sm8450-pcie-anoc
-      - qcom,sm8450-system-noc
 
   '#interconnect-cells': true
 
diff --git a/Documentation/devicetree/bindings/interconnect/qcom,sm8450-rpmh.yaml b/Documentation/devicetree/bindings/interconnect/qcom,sm8450-rpmh.yaml
new file mode 100644
index 000000000000..3cff7e662255
--- /dev/null
+++ b/Documentation/devicetree/bindings/interconnect/qcom,sm8450-rpmh.yaml
@@ -0,0 +1,124 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/interconnect/qcom,sm8450-rpmh.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm RPMh Network-On-Chip Interconnect on SM8450
+
+maintainers:
+  - Bjorn Andersson <andersson@kernel.org>
+  - Konrad Dybcio <konrad.dybcio@linaro.org>
+
+description: |
+  RPMh interconnect providers support system bandwidth requirements through
+  RPMh hardware accelerators known as Bus Clock Manager (BCM).
+
+  See also:: include/dt-bindings/interconnect/qcom,sm8450.h
+
+properties:
+  compatible:
+    enum:
+      - qcom,sm8450-aggre1-noc
+      - qcom,sm8450-aggre2-noc
+      - qcom,sm8450-clk-virt
+      - qcom,sm8450-config-noc
+      - qcom,sm8450-gem-noc
+      - qcom,sm8450-lpass-ag-noc
+      - qcom,sm8450-mc-virt
+      - qcom,sm8450-mmss-noc
+      - qcom,sm8450-nsp-noc
+      - qcom,sm8450-pcie-anoc
+      - qcom,sm8450-system-noc
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    minItems: 1
+    maxItems: 4
+
+required:
+  - compatible
+
+allOf:
+  - $ref: qcom,rpmh-common.yaml#
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,sm8450-clk-virt
+              - qcom,sm8450-mc-virt
+    then:
+      properties:
+        reg: false
+    else:
+      required:
+        - reg
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,sm8450-aggre1-noc
+    then:
+      properties:
+        clocks:
+          items:
+            - description: aggre UFS PHY AXI clock
+            - description: aggre USB3 PRIM AXI clock
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,sm8450-aggre2-noc
+    then:
+      properties:
+        clocks:
+          items:
+            - description: aggre-NOC PCIe 0 AXI clock
+            - description: aggre-NOC PCIe 1 AXI clock
+            - description: aggre UFS PHY AXI clock
+            - description: RPMH CC IPA clock
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,sm8450-aggre1-noc
+              - qcom,sm8450-aggre2-noc
+    then:
+      required:
+        - clocks
+    else:
+      properties:
+        clocks: false
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/qcom,gcc-sm8450.h>
+    #include <dt-bindings/clock/qcom,rpmh.h>
+
+    interconnect-0 {
+        compatible = "qcom,sm8450-clk-virt";
+        #interconnect-cells = <2>;
+        qcom,bcm-voters = <&apps_bcm_voter>;
+    };
+
+    interconnect@1700000 {
+        compatible = "qcom,sm8450-aggre2-noc";
+        reg = <0x01700000 0x31080>;
+        #interconnect-cells = <2>;
+        qcom,bcm-voters = <&apps_bcm_voter>;
+        clocks = <&gcc GCC_AGGRE_NOC_PCIE_0_AXI_CLK>,
+                 <&gcc GCC_AGGRE_NOC_PCIE_1_AXI_CLK>,
+                 <&gcc GCC_AGGRE_UFS_PHY_AXI_CLK>,
+                 <&rpmhcc RPMH_IPA_CLK>;
+    };
-- 
2.34.1

