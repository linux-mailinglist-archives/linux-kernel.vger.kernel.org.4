Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BDA0668EA0
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 07:59:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240873AbjAMG7O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 01:59:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240995AbjAMG5I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 01:57:08 -0500
Received: from mg.richtek.com (mg.richtek.com [220.130.44.152])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 33FDC81C34;
        Thu, 12 Jan 2023 22:42:28 -0800 (PST)
X-MailGates: (compute_score:DELIVER,40,3)
Received: from 192.168.8.21
        by mg.richtek.com with MailGates ESMTP Server V3.0(2732:0:AUTH_RELAY)
        (envelope-from <prvs=1372DA5DC2=cy_huang@richtek.com>); Fri, 13 Jan 2023 14:23:39 +0800 (CST)
X-MailGates: (compute_score:DELIVER,40,3)
Received: from 192.168.10.46
        by mg.richtek.com with MailGates ESMTP Server V5.0(16494:0:AUTH_RELAY)
        (envelope-from <cy_huang@richtek.com>); Fri, 13 Jan 2023 14:17:47 +0800 (CST)
Received: from ex4.rt.l (192.168.10.47) by ex3.rt.l (192.168.10.46) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.20; Fri, 13 Jan
 2023 14:17:47 +0800
Received: from linuxcarl2.richtek.com (192.168.10.154) by ex4.rt.l
 (192.168.10.45) with Microsoft SMTP Server id 15.2.1118.20 via Frontend
 Transport; Fri, 13 Jan 2023 14:17:47 +0800
From:   <cy_huang@richtek.com>
To:     <sre@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>
CC:     <alina_yu@richtek.com>, <cy_huang@richtek.com>,
        <u0084500@gmail.com>, <linux-pm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH RESEND v8 1/3] dt-bindings: power: supply: Add Richtek RT9471 battery charger
Date:   Fri, 13 Jan 2023 14:17:44 +0800
Message-ID: <1673590666-24618-2-git-send-email-cy_huang@richtek.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1673590666-24618-1-git-send-email-cy_huang@richtek.com>
References: <1673590666-24618-1-git-send-email-cy_huang@richtek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: ChiYuan Huang <cy_huang@richtek.com>

Add bindings for the Richtek RT9471 I2C controlled battery charger.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Co-developed-by: Alina Yu <alina_yu@richtek.com>
Signed-off-by: Alina Yu <alina_yu@richtek.com>
Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
---
Since v3
- Move unevaluatedProperties line after $ref for binding patch.
- Add Reviewed-by tag for binding patch.

Since v2
- Remove the properties for interrupt controller things in the binding documentation.
- Fix dtc error for typo, it's 'regulator-name', not 'regulator-compatible'.
- Add regulator min/max microamp to allow otg vbus current adjustable in example.
- Specify the active-level for charge-enable-gpios in binding example.

---
 .../bindings/power/supply/richtek,rt9471.yaml      | 73 ++++++++++++++++++++++
 1 file changed, 73 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/supply/richtek,rt9471.yaml

diff --git a/Documentation/devicetree/bindings/power/supply/richtek,rt9471.yaml b/Documentation/devicetree/bindings/power/supply/richtek,rt9471.yaml
new file mode 100644
index 00000000..fbb54cf
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/supply/richtek,rt9471.yaml
@@ -0,0 +1,73 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/power/supply/richtek,rt9471.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Richtek RT9471 3A Single Cell Switching Battery charger
+
+maintainers:
+  - Alina Yu <alina_yu@richtek.com>
+  - ChiYuan Huang <cy_huang@richtek.com>
+
+description: |
+  RT9471 is a switch-mode single cell Li-Ion/Li-Polymer battery charger for
+  portable applications. It supports USB BC1.2 port detection, current and
+  voltage regulations in both charging and boost mode.
+
+  Datasheet is available at
+  https://www.richtek.com/assets/product_file/RT9471=RT9471D/DS9471D-02.pdf
+
+properties:
+  compatible:
+    const: richtek,rt9471
+
+  reg:
+    maxItems: 1
+
+  charge-enable-gpios:
+    description: GPIO used to turn on and off charging.
+    maxItems: 1
+
+  wakeup-source: true
+
+  interrupts:
+    maxItems: 1
+
+  usb-otg-vbus-regulator:
+    type: object
+    $ref: /schemas/regulator/regulator.yaml#
+    unevaluatedProperties: false
+
+required:
+  - compatible
+  - reg
+  - wakeup-source
+  - interrupts
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    #include <dt-bindings/gpio/gpio.h>
+    i2c {
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      charger@53 {
+        compatible = "richtek,rt9471";
+        reg = <0x53>;
+        charge-enable-gpios = <&gpio26 1 GPIO_ACTIVE_LOW>;
+        wakeup-source;
+        interrupts-extended = <&gpio_intc 32 IRQ_TYPE_EDGE_FALLING>;
+
+        usb-otg-vbus-regulator {
+          regulator-name = "usb-otg-vbus";
+          regulator-min-microvolt = <4850000>;
+          regulator-max-microvolt = <5300000>;
+          regulator-min-microamp = <500000>;
+          regulator-max-microamp = <1200000>;
+        };
+      };
+    };
-- 
2.7.4

