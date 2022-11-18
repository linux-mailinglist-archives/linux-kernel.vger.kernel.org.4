Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EA0D62EB3E
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 02:46:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240999AbiKRBq1 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 17 Nov 2022 20:46:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239229AbiKRBqY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 20:46:24 -0500
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 565BE742CC;
        Thu, 17 Nov 2022 17:46:22 -0800 (PST)
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
        by ex01.ufhost.com (Postfix) with ESMTP id 7678F24E1F8;
        Fri, 18 Nov 2022 09:11:13 +0800 (CST)
Received: from EXMBX072.cuchost.com (172.16.6.82) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Fri, 18 Nov
 2022 09:11:13 +0800
Received: from ubuntu.localdomain (183.27.96.116) by EXMBX072.cuchost.com
 (172.16.6.82) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Fri, 18 Nov
 2022 09:11:12 +0800
From:   Hal Feng <hal.feng@starfivetech.com>
To:     <linux-riscv@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-gpio@vger.kernel.org>
CC:     Conor Dooley <conor@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        "Rob Herring" <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        Hal Feng <hal.feng@starfivetech.com>,
        Jianlong Huang <jianlong.huang@starfivetech.com>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 3/5] dt-bindings: pinctrl: Add StarFive JH7110 aon pinctrl
Date:   Fri, 18 Nov 2022 09:11:06 +0800
Message-ID: <20221118011108.70715-4-hal.feng@starfivetech.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221118011108.70715-1-hal.feng@starfivetech.com>
References: <20221118011108.70715-1-hal.feng@starfivetech.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [183.27.96.116]
X-ClientProxiedBy: EXCAS064.cuchost.com (172.16.6.24) To EXMBX072.cuchost.com
 (172.16.6.82)
X-YovoleRuleAgent: yovoleflag
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jianlong Huang <jianlong.huang@starfivetech.com>

Add pinctrl bindings for StarFive JH7110 SoC aon pinctrl controller.

Signed-off-by: Jianlong Huang <jianlong.huang@starfivetech.com>
Signed-off-by: Hal Feng <hal.feng@starfivetech.com>
---
 .../pinctrl/starfive,jh7110-aon-pinctrl.yaml  | 134 ++++++++++++++++++
 1 file changed, 134 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pinctrl/starfive,jh7110-aon-pinctrl.yaml

diff --git a/Documentation/devicetree/bindings/pinctrl/starfive,jh7110-aon-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/starfive,jh7110-aon-pinctrl.yaml
new file mode 100644
index 000000000000..1dd000e1f614
--- /dev/null
+++ b/Documentation/devicetree/bindings/pinctrl/starfive,jh7110-aon-pinctrl.yaml
@@ -0,0 +1,134 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pinctrl/starfive,jh7110-aon-pinctrl.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: StarFive JH7110 Aon Pin Controller
+
+description: |
+  Bindings for the JH7110 RISC-V SoC from StarFive Technology Ltd.
+
+  Out of the SoC's many pins only the ones named PAD_GPIO0 to PAD_GPIO4
+  can be multiplexed and have configurable bias, drive strength,
+  schmitt trigger etc.
+  Some peripherals have their I/O go through the 4 "GPIOs". This also
+  includes PWM.
+
+maintainers:
+  - Jianlong Huang <jianlong.huang@starfivetech.com>
+
+properties:
+  compatible:
+    const: starfive,jh7110-aon-pinctrl
+
+  reg:
+    maxItems: 1
+
+  reg-names:
+    items:
+      - const: control
+
+  clocks:
+    maxItems: 1
+
+  resets:
+    maxItems: 1
+
+  gpio-controller: true
+
+  "#gpio-cells":
+    const: 2
+
+  interrupts:
+    maxItems: 1
+    description: The GPIO parent interrupt.
+
+  interrupt-controller: true
+
+  "#interrupt-cells":
+    const: 2
+
+required:
+  - compatible
+  - reg
+  - reg-names
+  - gpio-controller
+  - "#gpio-cells"
+  - interrupts
+  - interrupt-controller
+  - "#interrupt-cells"
+
+patternProperties:
+  '-[0-9]+$':
+    type: object
+    patternProperties:
+      '-pins$':
+        type: object
+        description: |
+          A pinctrl node should contain at least one subnode representing the
+          pinctrl groups available on the machine. Each subnode will list the
+          pins it needs, and how they should be configured, with regard to
+          muxer configuration, system signal configuration, pin groups for
+          vin/vout module, pin voltage, mux functions for output, mux functions
+          for output enable, mux functions for input.
+
+        properties:
+          pinmux:
+            description: |
+              The list of GPIOs and their mux settings that properties in the
+              node apply to. This should be set using the GPIOMUX macro.
+            $ref: "/schemas/pinctrl/pinmux-node.yaml#/properties/pinmux"
+
+          bias-disable: true
+
+          bias-pull-up:
+            type: boolean
+
+          bias-pull-down:
+            type: boolean
+
+          drive-strength:
+            enum: [ 2, 4, 8, 12 ]
+
+          input-enable: true
+
+          input-disable: true
+
+          input-schmitt-enable: true
+
+          input-schmitt-disable: true
+
+          slew-rate:
+            maximum: 1
+
+        additionalProperties: false
+
+    additionalProperties: false
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/starfive-jh7110.h>
+    #include <dt-bindings/reset/starfive-jh7110.h>
+    #include <dt-bindings/pinctrl/pinctrl-starfive-jh7110.h>
+
+        soc {
+                #address-cells = <2>;
+                #size-cells = <2>;
+
+                gpioa: gpio@17020000 {
+                        compatible = "starfive,jh7110-aon-pinctrl";
+                        reg = <0x0 0x17020000 0x0 0x10000>;
+                        reg-names = "control";
+                        resets = <&aoncrg_rst JH7110_AONRST_AON_IOMUX>;
+                        interrupts = <85>;
+                        interrupt-controller;
+                        #interrupt-cells = <2>;
+                        #gpio-cells = <2>;
+                        gpio-controller;
+                };
+        };
+
+...
-- 
2.38.1

