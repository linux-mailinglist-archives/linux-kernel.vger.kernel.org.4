Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED9BF690BF7
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 15:37:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231174AbjBIOhW convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 9 Feb 2023 09:37:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231129AbjBIOhP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 09:37:15 -0500
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A7C56A59;
        Thu,  9 Feb 2023 06:37:12 -0800 (PST)
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
        by ex01.ufhost.com (Postfix) with ESMTP id 4014324E0FC;
        Thu,  9 Feb 2023 22:37:05 +0800 (CST)
Received: from EXMBX172.cuchost.com (172.16.6.92) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Thu, 9 Feb
 2023 22:37:05 +0800
Received: from ubuntu.localdomain (183.27.96.33) by EXMBX172.cuchost.com
 (172.16.6.92) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Thu, 9 Feb
 2023 22:37:04 +0800
From:   Hal Feng <hal.feng@starfivetech.com>
To:     <linux-gpio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>
CC:     Linus Walleij <linus.walleij@linaro.org>,
        Andreas Schwab <schwab@suse.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor@kernel.org>,
        "Palmer Dabbelt" <palmer@dabbelt.com>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        Jianlong Huang <jianlong.huang@starfivetech.com>,
        Hal Feng <hal.feng@starfivetech.com>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v5 2/4] dt-bindings: pinctrl: Add StarFive JH7110 aon pinctrl
Date:   Thu, 9 Feb 2023 22:37:00 +0800
Message-ID: <20230209143702.44408-3-hal.feng@starfivetech.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230209143702.44408-1-hal.feng@starfivetech.com>
References: <20230209143702.44408-1-hal.feng@starfivetech.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [183.27.96.33]
X-ClientProxiedBy: EXCAS066.cuchost.com (172.16.6.26) To EXMBX172.cuchost.com
 (172.16.6.92)
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

Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Jianlong Huang <jianlong.huang@starfivetech.com>
Co-developed-by: Emil Renner Berthing <kernel@esmil.dk>
Signed-off-by: Emil Renner Berthing <kernel@esmil.dk>
Signed-off-by: Hal Feng <hal.feng@starfivetech.com>
---
 .../pinctrl/starfive,jh7110-aon-pinctrl.yaml  | 124 ++++++++++++++++++
 .../pinctrl/starfive,jh7110-pinctrl.h         |  22 ++++
 2 files changed, 146 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pinctrl/starfive,jh7110-aon-pinctrl.yaml

diff --git a/Documentation/devicetree/bindings/pinctrl/starfive,jh7110-aon-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/starfive,jh7110-aon-pinctrl.yaml
new file mode 100644
index 000000000000..b470901f5f56
--- /dev/null
+++ b/Documentation/devicetree/bindings/pinctrl/starfive,jh7110-aon-pinctrl.yaml
@@ -0,0 +1,124 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pinctrl/starfive,jh7110-aon-pinctrl.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: StarFive JH7110 AON Pin Controller
+
+description: |
+  Bindings for the JH7110 RISC-V SoC from StarFive Technology Ltd.
+
+  Out of the SoC's many pins only the ones named PAD_RGPIO0 to PAD_RGPIO3
+  can be multiplexed and have configurable bias, drive strength,
+  schmitt trigger etc.
+  Some peripherals such as PWM have their I/O go through the 4 "GPIOs".
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
+  resets:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  interrupt-controller: true
+
+  '#interrupt-cells':
+    const: 2
+
+  gpio-controller: true
+
+  '#gpio-cells':
+    const: 2
+
+patternProperties:
+  '-[0-9]+$':
+    type: object
+    additionalProperties: false
+    patternProperties:
+      '-pins$':
+        type: object
+        description: |
+          A pinctrl node should contain at least one subnode representing the
+          pinctrl groups available on the machine. Each subnode will list the
+          pins it needs, and how they should be configured, with regard to
+          muxer configuration, bias, input enable/disable, input schmitt
+          trigger enable/disable, slew-rate and drive strength.
+        allOf:
+          - $ref: /schemas/pinctrl/pincfg-node.yaml
+          - $ref: /schemas/pinctrl/pinmux-node.yaml
+        additionalProperties: false
+
+        properties:
+          pinmux:
+            description: |
+              The list of GPIOs and their mux settings that properties in the
+              node apply to. This should be set using the GPIOMUX macro.
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
+required:
+  - compatible
+  - reg
+  - interrupts
+  - interrupt-controller
+  - '#interrupt-cells'
+  - gpio-controller
+  - '#gpio-cells'
+
+additionalProperties: false
+
+examples:
+  - |
+    pinctrl@17020000 {
+        compatible = "starfive,jh7110-aon-pinctrl";
+        reg = <0x17020000 0x10000>;
+        resets = <&aoncrg 2>;
+        interrupts = <85>;
+        interrupt-controller;
+        #interrupt-cells = <2>;
+        gpio-controller;
+        #gpio-cells = <2>;
+
+        pwm-0 {
+            pwm-pins {
+                pinmux = <0xff030802>;
+                bias-disable;
+                drive-strength = <12>;
+                input-disable;
+                input-schmitt-disable;
+                slew-rate = <0>;
+            };
+        };
+    };
+
+...
diff --git a/include/dt-bindings/pinctrl/starfive,jh7110-pinctrl.h b/include/dt-bindings/pinctrl/starfive,jh7110-pinctrl.h
index 57c1659e4bbf..3865f0139639 100644
--- a/include/dt-bindings/pinctrl/starfive,jh7110-pinctrl.h
+++ b/include/dt-bindings/pinctrl/starfive,jh7110-pinctrl.h
@@ -104,6 +104,28 @@
 #define	PAD_QSPI_DATA2		93
 #define	PAD_QSPI_DATA3		94
 
+/* aon_iomux pins */
+#define	PAD_TESTEN		0
+#define	PAD_RGPIO0		1
+#define	PAD_RGPIO1		2
+#define	PAD_RGPIO2		3
+#define	PAD_RGPIO3		4
+#define	PAD_RSTN		5
+#define	PAD_GMAC0_MDC		6
+#define	PAD_GMAC0_MDIO		7
+#define	PAD_GMAC0_RXD0		8
+#define	PAD_GMAC0_RXD1		9
+#define	PAD_GMAC0_RXD2		10
+#define	PAD_GMAC0_RXD3		11
+#define	PAD_GMAC0_RXDV		12
+#define	PAD_GMAC0_RXC		13
+#define	PAD_GMAC0_TXD0		14
+#define	PAD_GMAC0_TXD1		15
+#define	PAD_GMAC0_TXD2		16
+#define	PAD_GMAC0_TXD3		17
+#define	PAD_GMAC0_TXEN		18
+#define	PAD_GMAC0_TXC		19
+
 #define GPOUT_LOW		0
 #define GPOUT_HIGH		1
 
-- 
2.38.1

