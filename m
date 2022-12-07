Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E7016453B7
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 06:55:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229844AbiLGFzG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 00:55:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229734AbiLGFyh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 00:54:37 -0500
Received: from mx.socionext.com (mx.socionext.com [202.248.49.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3D71C58BE5;
        Tue,  6 Dec 2022 21:54:35 -0800 (PST)
Received: from unknown (HELO kinkan2-ex.css.socionext.com) ([172.31.9.52])
  by mx.socionext.com with ESMTP; 07 Dec 2022 14:54:32 +0900
Received: from mail.mfilter.local (m-filter-1 [10.213.24.61])
        by kinkan2-ex.css.socionext.com (Postfix) with ESMTP id 0A9AB2058442;
        Wed,  7 Dec 2022 14:54:32 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP; Wed, 7 Dec 2022 14:54:32 +0900
Received: from plum.e01.socionext.com (unknown [10.212.243.119])
        by kinkan2.css.socionext.com (Postfix) with ESMTP id A3B2A1DA6;
        Wed,  7 Dec 2022 14:54:31 +0900 (JST)
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Subject: [PATCH v2 12/16] dt-bindings: soc: socionext: Add UniPhier media I/O block
Date:   Wed,  7 Dec 2022 14:54:01 +0900
Message-Id: <20221207055405.30940-13-hayashi.kunihiko@socionext.com>
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

Add devicetree binding schema for the media I/O block implemented on
Socionext Uniphier SoCs. This block is implemented on LD4, sLD8, Pro4,
and LD11 SoCs.

Media I/O block implemented on Socionext UniPhier SoCs is an integrated
component of the stream type peripherals including SD, USB2.0, eMMC,
and MIO-DMAC.

Media I/O block has a common logic to control the component.

Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
---
 .../socionext/socionext,uniphier-mioctrl.yaml | 66 +++++++++++++++++++
 1 file changed, 66 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/soc/socionext/socionext,uniphier-mioctrl.yaml

diff --git a/Documentation/devicetree/bindings/soc/socionext/socionext,uniphier-mioctrl.yaml b/Documentation/devicetree/bindings/soc/socionext/socionext,uniphier-mioctrl.yaml
new file mode 100644
index 000000000000..1994355a27d3
--- /dev/null
+++ b/Documentation/devicetree/bindings/soc/socionext/socionext,uniphier-mioctrl.yaml
@@ -0,0 +1,66 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/soc/socionext/socionext,uniphier-mioctrl.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Socionext UniPhier media I/O block (MIO) controller
+
+maintainers:
+  - Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
+
+description: |+
+  Media I/O block implemented on Socionext UniPhier SoCs is a legacy
+  integrated component of the stream type peripherals including USB2.0,
+  SD/eMMC, and MIO-DMAC.
+  Media I/O block has a common logic to control the component.
+
+  Recent SoCs have SD interface logic specialized only for SD functions
+  as a subset of media I/O block. See socionext,uniphier-sdctrl.yaml.
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - socionext,uniphier-ld4-mioctrl
+          - socionext,uniphier-pro4-mioctrl
+          - socionext,uniphier-sld8-mioctrl
+          - socionext,uniphier-ld11-mioctrl
+      - const: simple-mfd
+      - const: syscon
+
+  reg:
+    maxItems: 1
+
+patternProperties:
+  "^clock-controller(@[0-9a-f]+)?$":
+    $ref: /schemas/clock/socionext,uniphier-clock.yaml#
+
+  "^reset-controller(@[0-9a-f]+)?$":
+    $ref: /schemas/reset/socionext,uniphier-reset.yaml#
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    syscon@5b3e0000 {
+        compatible = "socionext,uniphier-ld11-mioctrl",
+                     "simple-mfd", "syscon";
+        reg = <0x5b3e0000 0x800>;
+
+        clock-controller {
+            compatible = "socionext,uniphier-ld11-mio-clock";
+            #clock-cells = <1>;
+        };
+
+        reset-controller {
+            compatible = "socionext,uniphier-ld11-mio-reset";
+            #reset-cells = <1>;
+            resets = <&sys_rst 7>;
+        };
+    };
+
-- 
2.25.1

