Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CB576453AF
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 06:54:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229791AbiLGFyt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 00:54:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbiLGFye (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 00:54:34 -0500
Received: from mx.socionext.com (mx.socionext.com [202.248.49.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EB6B558BF6;
        Tue,  6 Dec 2022 21:54:32 -0800 (PST)
Received: from unknown (HELO kinkan2-ex.css.socionext.com) ([172.31.9.52])
  by mx.socionext.com with ESMTP; 07 Dec 2022 14:54:31 +0900
Received: from mail.mfilter.local (m-filter-1 [10.213.24.61])
        by kinkan2-ex.css.socionext.com (Postfix) with ESMTP id 7F92B2059054;
        Wed,  7 Dec 2022 14:54:31 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP; Wed, 7 Dec 2022 14:54:31 +0900
Received: from plum.e01.socionext.com (unknown [10.212.243.119])
        by kinkan2.css.socionext.com (Postfix) with ESMTP id 155931DA5;
        Wed,  7 Dec 2022 14:54:31 +0900 (JST)
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Subject: [PATCH v2 08/16] dt-bindings: soc: socionext: Add UniPhier system controller
Date:   Wed,  7 Dec 2022 14:53:57 +0900
Message-Id: <20221207055405.30940-9-hayashi.kunihiko@socionext.com>
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

Add devicetree binding schema for the system controller implemented on
Socionext Uniphier SoCs.

This system controller has multiple functions such as clock control,
reset control, internal watchdog timer, thermal management, and so on.

Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
---
 .../socionext/socionext,uniphier-sysctrl.yaml | 105 ++++++++++++++++++
 MAINTAINERS                                   |   1 +
 2 files changed, 106 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/soc/socionext/socionext,uniphier-sysctrl.yaml

diff --git a/Documentation/devicetree/bindings/soc/socionext/socionext,uniphier-sysctrl.yaml b/Documentation/devicetree/bindings/soc/socionext/socionext,uniphier-sysctrl.yaml
new file mode 100644
index 000000000000..c1b7cec8def4
--- /dev/null
+++ b/Documentation/devicetree/bindings/soc/socionext/socionext,uniphier-sysctrl.yaml
@@ -0,0 +1,105 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/soc/socionext/socionext,uniphier-sysctrl.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Socionext UniPhier system controller
+
+maintainers:
+  - Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
+
+description: |+
+  System controller implemented on Socionext UniPhier SoCs has multiple
+  functions such as clock control, reset control, internal watchdog timer,
+  thermal management, and so on.
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - socionext,uniphier-ld4-sysctrl
+          - socionext,uniphier-pro4-sysctrl
+          - socionext,uniphier-pro5-sysctrl
+          - socionext,uniphier-pxs2-sysctrl
+          - socionext,uniphier-sld8-sysctrl
+          - socionext,uniphier-ld11-sysctrl
+          - socionext,uniphier-ld20-sysctrl
+          - socionext,uniphier-pxs3-sysctrl
+          - socionext,uniphier-nx1-sysctrl
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
+  "^watchdog(@[0-9a-f]+)?$":
+    $ref: /schemas/watchdog/socionext,uniphier-wdt.yaml#
+
+  "^thermal-sensor(@[0-9a-f]+)?$":
+    $ref: /schemas/thermal/socionext,uniphier-thermal.yaml#
+
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: socionext,uniphier-ld4-sysctrl
+    then:
+      patternProperties:
+        "^watchdog(@[0-9a-f]+)?$": false
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - socionext,uniphier-ld4-sysctrl
+              - socionext,uniphier-pro4-sysctrl
+              - socionext,uniphier-sld8-sysctrl
+              - socionext,uniphier-ld11-sysctrl
+    then:
+      patternProperties:
+        "^thermal-sensor(@[0-9a-f]+)?$": false
+
+additionalProperties: false
+
+required:
+  - compatible
+  - reg
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    syscon@61840000 {
+        compatible = "socionext,uniphier-ld20-sysctrl",
+                     "simple-mfd", "syscon";
+        reg = <0x61840000 0x4000>;
+
+        clock-controller {
+            compatible = "socionext,uniphier-ld20-clock";
+            #clock-cells = <1>;
+        };
+
+        reset-controller {
+            compatible = "socionext,uniphier-ld20-reset";
+            #reset-cells = <1>;
+        };
+
+        watchdog {
+            compatible = "socionext,uniphier-wdt";
+        };
+
+        thermal-sensor {
+            compatible = "socionext,uniphier-ld20-thermal";
+            interrupts = <GIC_SPI 3 IRQ_TYPE_LEVEL_HIGH>;
+            #thermal-sensor-cells = <0>;
+        };
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index 0d8faba73fe8..8cec8ea46dd1 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3103,6 +3103,7 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/arm/socionext/uniphier.yaml
 F:	Documentation/devicetree/bindings/gpio/socionext,uniphier-gpio.yaml
 F:	Documentation/devicetree/bindings/pinctrl/socionext,uniphier-pinctrl.yaml
+F:	Documentation/devicetree/bindings/soc/socionext/socionext,uniphier*.yaml
 F:	arch/arm/boot/dts/uniphier*
 F:	arch/arm/include/asm/hardware/cache-uniphier.h
 F:	arch/arm/mach-uniphier/
-- 
2.25.1

