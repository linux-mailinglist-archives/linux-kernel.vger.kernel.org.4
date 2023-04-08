Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11FE46DBB9F
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Apr 2023 16:37:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230037AbjDHOhq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Apr 2023 10:37:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230075AbjDHOhn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Apr 2023 10:37:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FD4DCA0B;
        Sat,  8 Apr 2023 07:37:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 095D360B9F;
        Sat,  8 Apr 2023 14:37:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B31FBC433D2;
        Sat,  8 Apr 2023 14:37:33 +0000 (UTC)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Adam Skladowski <a_skl39@protonmail.com>,
        Sireesh Kodali <sireeshkodali@protonmail.com>,
        Taniya Das <tdas@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] dt-bindings: clock: qcom,gcc-msm8953: split to separate schema
Date:   Sat,  8 Apr 2023 16:37:29 +0200
Message-Id: <20230408143729.84097-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Qualcomm MSM8953 GCC clock controller has clock inputs, thus
existing gcc-other.yaml was not describing it fully.  Move the binding
to its own schema file and document the clocks based on DTS.  Add driver
contributors as its maintainers.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../bindings/clock/qcom,gcc-msm8953.yaml      | 73 +++++++++++++++++++
 .../bindings/clock/qcom,gcc-other.yaml        |  1 -
 2 files changed, 73 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/clock/qcom,gcc-msm8953.yaml

diff --git a/Documentation/devicetree/bindings/clock/qcom,gcc-msm8953.yaml b/Documentation/devicetree/bindings/clock/qcom,gcc-msm8953.yaml
new file mode 100644
index 000000000000..fe9fd4cb185f
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/qcom,gcc-msm8953.yaml
@@ -0,0 +1,73 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/qcom,gcc-msm8953.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm Global Clock & Reset Controller on MSM8953
+
+maintainers:
+  - Adam Skladowski <a_skl39@protonmail.com>
+  - Sireesh Kodali <sireeshkodali@protonmail.com>
+
+description: |
+  Qualcomm global clock control module provides the clocks, resets and power
+  domains on MSM8953.
+
+  See also: include/dt-bindings/clock/qcom,gcc-msm8953.h
+
+properties:
+  compatible:
+    const: qcom,gcc-msm8953
+
+  clocks:
+    items:
+      - description: Board XO source
+      - description: Sleep clock source
+      - description: Byte clock from DSI PHY0
+      - description: Pixel clock from DSI PHY0
+      - description: Byte clock from DSI PHY1
+      - description: Pixel clock from DSI PHY1
+
+  clock-names:
+    items:
+      - const: xo
+      - const: sleep
+      - const: dsi0pll
+      - const: dsi0pllbyte
+      - const: dsi1pll
+      - const: dsi1pllbyte
+
+required:
+  - compatible
+  - clocks
+  - clock-names
+
+allOf:
+  - $ref: qcom,gcc.yaml#
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/qcom,rpmcc.h>
+
+    clock-controller@1800000 {
+        compatible = "qcom,gcc-msm8953";
+        reg = <0x01800000 0x80000>;
+        clocks = <&rpmcc RPM_SMD_XO_CLK_SRC>,
+                 <&sleep_clk>,
+                 <&dsi0_phy 1>,
+                 <&dsi0_phy 0>,
+                 <&dsi1_phy 1>,
+                 <&dsi1_phy 0>;
+        clock-names = "xo",
+                      "sleep",
+                      "dsi0pll",
+                      "dsi0pllbyte",
+                      "dsi1pll",
+                      "dsi1pllbyte";
+        #clock-cells = <1>;
+        #reset-cells = <1>;
+        #power-domain-cells = <1>;
+    };
diff --git a/Documentation/devicetree/bindings/clock/qcom,gcc-other.yaml b/Documentation/devicetree/bindings/clock/qcom,gcc-other.yaml
index ae01e7749534..ba969e7a57bf 100644
--- a/Documentation/devicetree/bindings/clock/qcom,gcc-other.yaml
+++ b/Documentation/devicetree/bindings/clock/qcom,gcc-other.yaml
@@ -30,7 +30,6 @@ properties:
     enum:
       - qcom,gcc-ipq6018
       - qcom,gcc-mdm9607
-      - qcom,gcc-msm8953
       - qcom,gcc-mdm9615
 
 required:
-- 
2.34.1

