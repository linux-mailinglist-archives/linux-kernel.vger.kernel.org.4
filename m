Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73CA7739D02
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 11:30:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230378AbjFVJaF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 05:30:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231768AbjFVJ3i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 05:29:38 -0400
Received: from albert.telenet-ops.be (albert.telenet-ops.be [IPv6:2a02:1800:110:4::f00:1a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25A3F4208
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 02:22:43 -0700 (PDT)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed20:991a:a831:ea4b:6058])
        by albert.telenet-ops.be with bizsmtp
        id C9Nd2A0091yfRTD069Ndiq; Thu, 22 Jun 2023 11:22:41 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtp (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1qCGWR-000BvG-H5;
        Thu, 22 Jun 2023 11:22:37 +0200
Received: from geert by rox.of.borg with local (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1qCGWT-003Vvf-37;
        Thu, 22 Jun 2023 11:22:37 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Magnus Damm <magnus.damm@gmail.com>
Cc:     dri-devel@lists.freedesktop.org, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org
Subject: [PATCH 01/39] dt-bindings: display: Add Renesas SH-Mobile LCDC bindings
Date:   Thu, 22 Jun 2023 11:21:13 +0200
Message-Id: <2259ff548f007afcb5a315a4c95c83a0ee4b7e03.1687423204.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1687423204.git.geert+renesas@glider.be>
References: <cover.1687423204.git.geert+renesas@glider.be>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add device tree bindings for the LCD Controller (LCDC) found in Renesas
SuperH SH-Mobile and ARM SH/R-Mobile SOCs.

Based on a plain text prototype by Laurent Pinchart.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc: Conor Dooley <conor+dt@kernel.org>
Cc: devicetree@vger.kernel.org
---
Changes compared to Laurent's original:
  - Convert to json-schema,
  - Rename compatible values from "renesas,lcdc-<SoC>" to
    "renesas,<SoC>-lcdc",
  - Add power-domains property,
  - Add MIPI-DSI port on SH-Mobile AG5,
  - Update example to reflect reality,
  - Add to MAINTAINERS.
---
 .../display/renesas,shmobile-lcdc.yaml        | 108 ++++++++++++++++++
 MAINTAINERS                                   |   1 +
 2 files changed, 109 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/renesas,shmobile-lcdc.yaml

diff --git a/Documentation/devicetree/bindings/display/renesas,shmobile-lcdc.yaml b/Documentation/devicetree/bindings/display/renesas,shmobile-lcdc.yaml
new file mode 100644
index 0000000000000000..72a39fce7294d56d
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/renesas,shmobile-lcdc.yaml
@@ -0,0 +1,108 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/renesas,shmobile-lcdc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Renesas SH-Mobile LCD Controller (LCDC)
+
+maintainers:
+  - Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
+
+properties:
+  compatible:
+    enum:
+      - renesas,r8a7740-lcdc # R-Mobile A1
+      - renesas,sh73a0-lcdc  # SH-Mobile AG5
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    minItems: 1
+    maxItems: 5
+    description:
+      Only the functional clock is mandatory.
+      Some of the optional clocks are model-dependent (e.g. "video" (a.k.a.
+      "vou" or "dv_clk") is available on R-Mobile A1 only).
+
+  clock-names:
+    minItems: 1
+    maxItems: 5
+    items:
+      enum: [ fck, media, lclk, hdmi, video ]
+
+  power-domains:
+    maxItems: 1
+
+  ports:
+    $ref: /schemas/graph.yaml#/properties/ports
+    description: |
+      The connections to the output video ports are modeled using the OF graph
+      bindings specified in Documentation/devicetree/bindings/graph.txt.
+      The number of ports and their assignment are model-dependent.
+      Each port shall have a single endpoint.
+
+    properties:
+      port@0:
+        $ref: /schemas/graph.yaml#/properties/port
+        description: LCD port (R-Mobile A1 and SH-Mobile AG5)
+        unevaluatedProperties: false
+
+      port@1:
+        $ref: /schemas/graph.yaml#/properties/port
+        description: HDMI port (R-Mobile A1 LCDC1 and SH-Mobile AG5)
+        unevaluatedProperties: false
+
+      port@2:
+        $ref: /schemas/graph.yaml#/properties/port
+        description: MIPI-DSI port (SH-Mobile AG5)
+        unevaluatedProperties: false
+
+    required:
+      - port@0
+
+    unevaluatedProperties: false
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+  - clock-names
+  - power-domains
+  - ports
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/r8a7740-clock.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    lcdc0: lcd-controller@fe940000 {
+        compatible = "renesas,r8a7740-lcdc";
+        reg = <0xfe940000 0x4000>;
+        interrupts = <GIC_SPI 177 IRQ_TYPE_LEVEL_HIGH>;
+        clocks = <&mstp1_clks R8A7740_CLK_LCDC0>,
+                 <&cpg_clocks R8A7740_CLK_M3>, <&lcdlclk0_clk>,
+                 <&vou_clk>;
+        clock-names = "fck", "media", "lclk", "video";
+        power-domains = <&pd_a4lc>;
+        status = "disabled";
+
+        ports {
+            #address-cells = <1>;
+            #size-cells = <0>;
+
+            port@0 {
+                reg = <0>;
+
+                lcdc0_rgb: endpoint {
+                };
+            };
+        };
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index 83e9f4ac6bedaa9f..dc1935c196cb0e0b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7023,6 +7023,7 @@ F:	Documentation/devicetree/bindings/display/bridge/renesas,dsi-csi2-tx.yaml
 F:	Documentation/devicetree/bindings/display/bridge/renesas,dw-hdmi.yaml
 F:	Documentation/devicetree/bindings/display/bridge/renesas,lvds.yaml
 F:	Documentation/devicetree/bindings/display/renesas,du.yaml
+F:	Documentation/devicetree/bindings/display/renesas,shmobile-lcdc.yaml
 F:	drivers/gpu/drm/renesas/
 F:	include/linux/platform_data/shmob_drm.h
 
-- 
2.34.1

