Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29D1B6550DA
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Dec 2022 14:21:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236312AbiLWNVF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Dec 2022 08:21:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236260AbiLWNUv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Dec 2022 08:20:51 -0500
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEAE662C5
        for <linux-kernel@vger.kernel.org>; Fri, 23 Dec 2022 05:20:47 -0800 (PST)
Received: by mail-lj1-x235.google.com with SMTP id f20so5002096lja.4
        for <linux-kernel@vger.kernel.org>; Fri, 23 Dec 2022 05:20:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7vpelYbZ2CZ71ir8I9eV6R8yg0lPmPjYmYdPxnjBzak=;
        b=sFmU6T1pTUbS96njlBXd8rPgDghuHYDFp2KFmj2k3EAuCgNh8NGIJjuC81Zwyey+vy
         OHypVcY5I4eXGO2boKJsWJ4UJ5LlIUQzG5nxpYLsNz1oTSLcdTdENPjyy0G4y2jicbVs
         nLadSydRA+ydZwxqZb8zBLFyJcFg6upKybhK4RifChDXDnXDmXPHdKWkmVBKvoHqgMN7
         Zm3KeI9drjMBCaLTp+Ayhw6uAgA2iT+N+iJ8p52hnOovsYLsTNF2n3bK7B7uQAT7r6Lf
         KC8pEHKWT1b8KWjhIGfv83uoi52sVwRwzKbfFu02HqiK/F3BNQNrjhjOJxBgZ4ahKA93
         cR0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7vpelYbZ2CZ71ir8I9eV6R8yg0lPmPjYmYdPxnjBzak=;
        b=PSoY4DWbmawoADI/pWI4hdu61Y0TOmh8qSptNP7mW6YTNYTt2rToOA4cSc9zKXyss3
         9usIJlXciXVcH4QkPgUo4qNZuevM/U3bHmzo2MSLU1dPcp1OW3v6ov6HIs7kWGuE563v
         azn5tZkR3Cv+MtjjUwvV62RTdkntsl4SnQp7qO4vBCqZzOK7JpRWq91Z+mWWKgKlyOF6
         4fE6CgYU61xX5DBpyDYGLMfWqUd/w4liDYori2vU97wxYIzOLsO+cl94uilRDSflMtvH
         03qlN+8lmhktZKu4bBYLBB42u74OpFpPgi6JJjmuaNlF37utKsNbUUe56bwBhNAv85+S
         O+DQ==
X-Gm-Message-State: AFqh2krDpeOb2pZOokKB0kQEJIJ+pbSQhFKzzdXUThME4CDElU5kWsto
        7OENED7eJu/xPSKiPP31cS2/7A==
X-Google-Smtp-Source: AMrXdXsXZpD+XYE4U62yzkISiO3OiTfBaqD6ceG9XoVihva4qaAzWpcaeR9CF+jQXe9/pJcU2MPdrg==
X-Received: by 2002:a05:651c:48e:b0:27d:5e67:cb15 with SMTP id s14-20020a05651c048e00b0027d5e67cb15mr3181596ljc.4.1671801645723;
        Fri, 23 Dec 2022 05:20:45 -0800 (PST)
Received: from krzk-bin.NAT.warszawa.vectranet.pl (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id v11-20020a2ea60b000000b0026c2baa72d4sm426753ljp.27.2022.12.23.05.20.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Dec 2022 05:20:45 -0800 (PST)
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
Subject: [PATCH 3/3] dt-bindings: interconnect: split SM8450 to own schema
Date:   Fri, 23 Dec 2022 14:20:40 +0100
Message-Id: <20221223132040.80858-3-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221223132040.80858-1-krzysztof.kozlowski@linaro.org>
References: <20221223132040.80858-1-krzysztof.kozlowski@linaro.org>
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

SM8450 comes with interconnects having and missing IO address space, and
variable number of clocks, so split it from common file for easier
maintenancen and to fix warnings like:

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

