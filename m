Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88409747B81
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 04:23:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230513AbjGECXu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 22:23:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229676AbjGECXr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 22:23:47 -0400
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EED4810E3;
        Tue,  4 Jul 2023 19:23:45 -0700 (PDT)
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 97F951A09D5;
        Wed,  5 Jul 2023 04:23:44 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 329FA1A09B7;
        Wed,  5 Jul 2023 04:23:44 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id A67571820F57;
        Wed,  5 Jul 2023 10:23:42 +0800 (+08)
From:   Shengjiu Wang <shengjiu.wang@nxp.com>
To:     abelvesa@kernel.org, peng.fan@nxp.com, mturquette@baylibre.com,
        sboyd@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, shengjiu.wang@gmail.com
Cc:     linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/3] dt-bindings: clock: fsl,imx8-acm: Add audio clock mux support
Date:   Wed,  5 Jul 2023 09:50:37 +0800
Message-Id: <1688521839-3036-2-git-send-email-shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1688521839-3036-1-git-send-email-shengjiu.wang@nxp.com>
References: <1688521839-3036-1-git-send-email-shengjiu.wang@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the clock dt-binding file for audio clock mux. which
is the IP for i.MX8QM, i.MX8QXP, i.MX8DXL.

Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
---
 .../bindings/clock/fsl,imx8-acm.yaml          | 159 ++++++++++++++++++
 1 file changed, 159 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/fsl,imx8-acm.yaml

diff --git a/Documentation/devicetree/bindings/clock/fsl,imx8-acm.yaml b/Documentation/devicetree/bindings/clock/fsl,imx8-acm.yaml
new file mode 100644
index 000000000000..b79dd080c008
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/fsl,imx8-acm.yaml
@@ -0,0 +1,159 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/fsl,imx8-acm.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: NXP i.MX8 Audio Clock Mux
+
+maintainers:
+  - Shengjiu Wang <shengjiu.wang@nxp.com>
+
+description: |
+  NXP i.MX8 Audio Clock Mux is dedicated clock muxing IP
+  used to control Audio related clock on the SoC.
+
+properties:
+  compatible:
+    enum:
+      - nxp,imx8qm-acm
+      - nxp,imx8qxp-acm
+      - nxp,imx8dxl-acm
+
+  reg:
+    maxItems: 1
+
+  power-domains:
+    description:
+      List of phandle and PM domain specifier as documented in
+      Documentation/devicetree/bindings/power/power_domain.txt
+    minItems: 13
+    maxItems: 21
+
+  '#clock-cells':
+    const: 1
+    description:
+      The clock consumer should specify the desired clock by having the clock
+      ID in its "clocks" phandle cell. See include/dt-bindings/clock/imx8-clock.h
+      for the full list of i.MX8 ACM clock IDs.
+
+required:
+  - compatible
+  - reg
+  - power-domains
+  - '#clock-cells'
+
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - nxp,imx8qxp-acm
+    then:
+      properties:
+        power-domains:
+          items:
+            - description: power domain of IMX_SC_R_AUDIO_CLK_0
+            - description: power domain of IMX_SC_R_AUDIO_CLK_1
+            - description: power domain of IMX_SC_R_MCLK_OUT_0
+            - description: power domain of IMX_SC_R_MCLK_OUT_1
+            - description: power domain of IMX_SC_R_AUDIO_PLL_0
+            - description: power domain of IMX_SC_R_AUDIO_PLL_1
+            - description: power domain of IMX_SC_R_ASRC_0
+            - description: power domain of IMX_SC_R_ASRC_1
+            - description: power domain of IMX_SC_R_ESAI_0
+            - description: power domain of IMX_SC_R_SAI_0
+            - description: power domain of IMX_SC_R_SAI_1
+            - description: power domain of IMX_SC_R_SAI_2
+            - description: power domain of IMX_SC_R_SAI_3
+            - description: power domain of IMX_SC_R_SAI_4
+            - description: power domain of IMX_SC_R_SAI_5
+            - description: power domain of IMX_SC_R_SPDIF_0
+            - description: power domain of IMX_SC_R_MQS_0
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - nxp,imx8qm-acm
+    then:
+      properties:
+        power-domains:
+          items:
+            - description: power domain of IMX_SC_R_AUDIO_CLK_0
+            - description: power domain of IMX_SC_R_AUDIO_CLK_1
+            - description: power domain of IMX_SC_R_MCLK_OUT_0
+            - description: power domain of IMX_SC_R_MCLK_OUT_1
+            - description: power domain of IMX_SC_R_AUDIO_PLL_0
+            - description: power domain of IMX_SC_R_AUDIO_PLL_1
+            - description: power domain of IMX_SC_R_ASRC_0
+            - description: power domain of IMX_SC_R_ASRC_1
+            - description: power domain of IMX_SC_R_ESAI_0
+            - description: power domain of IMX_SC_R_ESAI_1
+            - description: power domain of IMX_SC_R_SAI_0
+            - description: power domain of IMX_SC_R_SAI_1
+            - description: power domain of IMX_SC_R_SAI_2
+            - description: power domain of IMX_SC_R_SAI_3
+            - description: power domain of IMX_SC_R_SAI_4
+            - description: power domain of IMX_SC_R_SAI_5
+            - description: power domain of IMX_SC_R_SAI_6
+            - description: power domain of IMX_SC_R_SAI_7
+            - description: power domain of IMX_SC_R_SPDIF_0
+            - description: power domain of IMX_SC_R_SPDIF_1
+            - description: power domain of IMX_SC_R_MQS_0
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - nxp,imx8dxl-acm
+    then:
+      properties:
+        power-domains:
+          items:
+            - description: power domain of IMX_SC_R_AUDIO_CLK_0
+            - description: power domain of IMX_SC_R_AUDIO_CLK_1
+            - description: power domain of IMX_SC_R_MCLK_OUT_0
+            - description: power domain of IMX_SC_R_MCLK_OUT_1
+            - description: power domain of IMX_SC_R_AUDIO_PLL_0
+            - description: power domain of IMX_SC_R_AUDIO_PLL_1
+            - description: power domain of IMX_SC_R_ASRC_0
+            - description: power domain of IMX_SC_R_SAI_0
+            - description: power domain of IMX_SC_R_SAI_1
+            - description: power domain of IMX_SC_R_SAI_2
+            - description: power domain of IMX_SC_R_SAI_3
+            - description: power domain of IMX_SC_R_SPDIF_0
+            - description: power domain of IMX_SC_R_MQS_0
+
+additionalProperties: false
+
+examples:
+  # Clock Control Module node:
+  - |
+    #include <dt-bindings/firmware/imx/rsrc.h>
+
+    clock-controller@59e00000 {
+        compatible = "nxp,imx8qxp-acm";
+        reg = <0x59e00000 0x1d0000>;
+        #clock-cells = <1>;
+        power-domains = <&pd IMX_SC_R_AUDIO_CLK_0>,
+                        <&pd IMX_SC_R_AUDIO_CLK_1>,
+                        <&pd IMX_SC_R_MCLK_OUT_0>,
+                        <&pd IMX_SC_R_MCLK_OUT_1>,
+                        <&pd IMX_SC_R_AUDIO_PLL_0>,
+                        <&pd IMX_SC_R_AUDIO_PLL_1>,
+                        <&pd IMX_SC_R_ASRC_0>,
+                        <&pd IMX_SC_R_ASRC_1>,
+                        <&pd IMX_SC_R_ESAI_0>,
+                        <&pd IMX_SC_R_SAI_0>,
+                        <&pd IMX_SC_R_SAI_1>,
+                        <&pd IMX_SC_R_SAI_2>,
+                        <&pd IMX_SC_R_SAI_3>,
+                        <&pd IMX_SC_R_SAI_4>,
+                        <&pd IMX_SC_R_SAI_5>,
+                        <&pd IMX_SC_R_SPDIF_0>,
+                        <&pd IMX_SC_R_MQS_0>;
+    };
-- 
2.34.1

