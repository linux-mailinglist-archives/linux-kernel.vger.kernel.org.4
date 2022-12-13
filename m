Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B193164B11E
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 09:26:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234566AbiLMI01 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 03:26:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234765AbiLMIZN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 03:25:13 -0500
Received: from mx.socionext.com (mx.socionext.com [202.248.49.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 675F413F6E;
        Tue, 13 Dec 2022 00:25:09 -0800 (PST)
Received: from unknown (HELO iyokan2-ex.css.socionext.com) ([172.31.9.54])
  by mx.socionext.com with ESMTP; 13 Dec 2022 17:25:06 +0900
Received: from mail.mfilter.local (m-filter-1 [10.213.24.61])
        by iyokan2-ex.css.socionext.com (Postfix) with ESMTP id F30662058B4F;
        Tue, 13 Dec 2022 17:25:05 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP; Tue, 13 Dec 2022 17:25:05 +0900
Received: from plum.e01.socionext.com (unknown [10.212.243.119])
        by kinkan2.css.socionext.com (Postfix) with ESMTP id B1DB9A855C;
        Tue, 13 Dec 2022 17:25:05 +0900 (JST)
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Subject: [PATCH v3 16/17] dt-bindings: soc: socionext: Add UniPhier DWC3 USB glue layer
Date:   Tue, 13 Dec 2022 17:24:48 +0900
Message-Id: <20221213082449.2721-17-hayashi.kunihiko@socionext.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221213082449.2721-1-hayashi.kunihiko@socionext.com>
References: <20221213082449.2721-1-hayashi.kunihiko@socionext.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add DT binding schema for components belonging to the platform-specific
DWC3 USB glue layer implemented in UniPhier SoCs.

This USB glue layer works as a sideband logic for the host controller,
including core reset, vbus control, PHYs, and some signals to the
controller.

Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
---
 .../socionext,uniphier-dwc3-glue.yaml         | 106 ++++++++++++++++++
 1 file changed, 106 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/soc/socionext/socionext,uniphier-dwc3-glue.yaml

diff --git a/Documentation/devicetree/bindings/soc/socionext/socionext,uniphier-dwc3-glue.yaml b/Documentation/devicetree/bindings/soc/socionext/socionext,uniphier-dwc3-glue.yaml
new file mode 100644
index 000000000000..bd0def7236b5
--- /dev/null
+++ b/Documentation/devicetree/bindings/soc/socionext/socionext,uniphier-dwc3-glue.yaml
@@ -0,0 +1,106 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/soc/socionext/socionext,uniphier-dwc3-glue.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Socionext UniPhier SoC DWC3 USB3.0 glue layer
+
+maintainers:
+  - Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
+
+description: |+
+  DWC3 USB3.0 glue layer implemented on Socionext UniPhier SoCs is
+  a sideband logic handling signals to DWC3 host controller inside
+  USB3.0 component.
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - socionext,uniphier-pro4-dwc3-glue
+          - socionext,uniphier-pro5-dwc3-glue
+          - socionext,uniphier-pxs2-dwc3-glue
+          - socionext,uniphier-ld20-dwc3-glue
+          - socionext,uniphier-pxs3-dwc3-glue
+          - socionext,uniphier-nx1-dwc3-glue
+      - const: simple-mfd
+
+  reg:
+    maxItems: 1
+
+  "#address-cells":
+    const: 1
+
+  "#size-cells":
+    const: 1
+
+  ranges: true
+
+patternProperties:
+  "^reset-controller@[0-9a-f]+$":
+    $ref: /schemas/reset/socionext,uniphier-glue-reset.yaml#
+
+  "^regulator@[0-9a-f]+$":
+    $ref: /schemas/regulator/socionext,uniphier-regulator.yaml#
+
+  "^phy@[0-9a-f]+$":
+    oneOf:
+      - $ref: /schemas/phy/socionext,uniphier-usb3hs-phy.yaml#
+      - $ref: /schemas/phy/socionext,uniphier-usb3ss-phy.yaml#
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    usb@65b00000 {
+        compatible = "socionext,uniphier-ld20-dwc3-glue", "simple-mfd";
+        reg = <0x65b00000 0x400>;
+        #address-cells = <1>;
+        #size-cells = <1>;
+        ranges = <0 0x65b00000 0x400>;
+
+        reset-controller@0 {
+            compatible = "socionext,uniphier-ld20-usb3-reset";
+            reg = <0x0 0x4>;
+            #reset-cells = <1>;
+            clock-names = "link";
+            clocks = <&sys_clk 14>;
+            reset-names = "link";
+            resets = <&sys_rst 14>;
+        };
+
+        regulator@100 {
+            compatible = "socionext,uniphier-ld20-usb3-regulator";
+            reg = <0x100 0x10>;
+            clock-names = "link";
+            clocks = <&sys_clk 14>;
+            reset-names = "link";
+            resets = <&sys_rst 14>;
+        };
+
+        phy@200 {
+            compatible = "socionext,uniphier-ld20-usb3-hsphy";
+            reg = <0x200 0x10>;
+            #phy-cells = <0>;
+            clock-names = "link", "phy";
+            clocks = <&sys_clk 14>, <&sys_clk 16>;
+            reset-names = "link", "phy";
+            resets = <&sys_rst 14>, <&sys_rst 16>;
+        };
+
+        phy@300 {
+            compatible = "socionext,uniphier-ld20-usb3-ssphy";
+            reg = <0x300 0x10>;
+            #phy-cells = <0>;
+            clock-names = "link", "phy";
+            clocks = <&sys_clk 14>, <&sys_clk 18>;
+            reset-names = "link", "phy";
+            resets = <&sys_rst 14>, <&sys_rst 18>;
+        };
+    };
+
-- 
2.25.1

