Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EA746453BE
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 06:55:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229892AbiLGFzU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 00:55:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229743AbiLGFyi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 00:54:38 -0500
Received: from mx.socionext.com (mx.socionext.com [202.248.49.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EC36E5914D;
        Tue,  6 Dec 2022 21:54:35 -0800 (PST)
Received: from unknown (HELO kinkan2-ex.css.socionext.com) ([172.31.9.52])
  by mx.socionext.com with ESMTP; 07 Dec 2022 14:54:32 +0900
Received: from mail.mfilter.local (m-filter-2 [10.213.24.62])
        by kinkan2-ex.css.socionext.com (Postfix) with ESMTP id 54F012059054;
        Wed,  7 Dec 2022 14:54:32 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP; Wed, 7 Dec 2022 14:54:32 +0900
Received: from plum.e01.socionext.com (unknown [10.212.243.119])
        by kinkan2.css.socionext.com (Postfix) with ESMTP id 1A5221DA5;
        Wed,  7 Dec 2022 14:54:32 +0900 (JST)
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Subject: [PATCH v2 15/16] dt-bindings: soc: socionext: Add UniPhier DWC3 USB glue layer
Date:   Wed,  7 Dec 2022 14:54:04 +0900
Message-Id: <20221207055405.30940-16-hayashi.kunihiko@socionext.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221207055405.30940-1-hayashi.kunihiko@socionext.com>
References: <20221207055405.30940-1-hayashi.kunihiko@socionext.com>
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
index 000000000000..1b5585a5a3a2
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
+  '#address-cells':
+    const: 1
+
+  '#size-cells':
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

