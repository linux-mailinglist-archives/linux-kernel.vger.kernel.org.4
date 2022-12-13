Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3305D64B11F
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 09:26:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234885AbiLMI0c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 03:26:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234764AbiLMIZN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 03:25:13 -0500
Received: from mx.socionext.com (mx.socionext.com [202.248.49.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 394B513DF9;
        Tue, 13 Dec 2022 00:25:08 -0800 (PST)
Received: from unknown (HELO kinkan2-ex.css.socionext.com) ([172.31.9.52])
  by mx.socionext.com with ESMTP; 13 Dec 2022 17:25:06 +0900
Received: from mail.mfilter.local (m-filter-1 [10.213.24.61])
        by kinkan2-ex.css.socionext.com (Postfix) with ESMTP id 7CBBE2059054;
        Tue, 13 Dec 2022 17:25:06 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP; Tue, 13 Dec 2022 17:25:06 +0900
Received: from plum.e01.socionext.com (unknown [10.212.243.119])
        by kinkan2.css.socionext.com (Postfix) with ESMTP id D6428A855C;
        Tue, 13 Dec 2022 17:25:05 +0900 (JST)
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Subject: [PATCH v3 17/17] dt-bindings: soc: socionext: Add UniPhier AHCI glue layer
Date:   Tue, 13 Dec 2022 17:24:49 +0900
Message-Id: <20221213082449.2721-18-hayashi.kunihiko@socionext.com>
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
AHCI glue layer implemented in UniPhier SoCs.

This AHCI glue layer works as a sideband logic for the host controller,
including core reset, PHYs, and some signals to the controller.

Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
---
 .../socionext,uniphier-ahci-glue.yaml         | 77 +++++++++++++++++++
 1 file changed, 77 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/soc/socionext/socionext,uniphier-ahci-glue.yaml

diff --git a/Documentation/devicetree/bindings/soc/socionext/socionext,uniphier-ahci-glue.yaml b/Documentation/devicetree/bindings/soc/socionext/socionext,uniphier-ahci-glue.yaml
new file mode 100644
index 000000000000..09f861cc068f
--- /dev/null
+++ b/Documentation/devicetree/bindings/soc/socionext/socionext,uniphier-ahci-glue.yaml
@@ -0,0 +1,77 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/soc/socionext/socionext,uniphier-ahci-glue.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Socionext UniPhier SoC AHCI glue layer
+
+maintainers:
+  - Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
+
+description: |+
+  AHCI glue layer implemented on Socionext UniPhier SoCs is a sideband
+  logic handling signals to AHCI host controller inside AHCI component.
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - socionext,uniphier-pro4-ahci-glue
+          - socionext,uniphier-pxs2-ahci-glue
+          - socionext,uniphier-pxs3-ahci-glue
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
+  "phy@[0-9a-f]+$":
+    $ref: /schemas/phy/socionext,uniphier-ahci-phy.yaml#
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    sata-controller@65700000 {
+        compatible = "socionext,uniphier-pxs3-ahci-glue", "simple-mfd";
+        reg = <0x65b00000 0x400>;
+        #address-cells = <1>;
+        #size-cells = <1>;
+        ranges = <0 0x65700000 0x100>;
+
+        reset-controller@0 {
+            compatible = "socionext,uniphier-pxs3-ahci-reset";
+            reg = <0x0 0x4>;
+            clock-names = "link";
+            clocks = <&sys_clk 28>;
+            reset-names = "link";
+            resets = <&sys_rst 28>;
+            #reset-cells = <1>;
+        };
+
+        phy@10 {
+            compatible = "socionext,uniphier-pxs3-ahci-phy";
+            reg = <0x10 0x10>;
+            clock-names = "link", "phy";
+            clocks = <&sys_clk 28>, <&sys_clk 30>;
+            reset-names = "link", "phy";
+            resets = <&sys_rst 28>, <&sys_rst 30>;
+            #phy-cells = <0>;
+        };
+    };
-- 
2.25.1

