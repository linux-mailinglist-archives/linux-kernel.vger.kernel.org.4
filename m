Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65AD4661F23
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 08:22:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236309AbjAIHWF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 02:22:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233106AbjAIHVz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 02:21:55 -0500
Received: from SHSQR01.spreadtrum.com (unknown [222.66.158.135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FE20958E;
        Sun,  8 Jan 2023 23:21:50 -0800 (PST)
Received: from SHSend.spreadtrum.com (bjmbx02.spreadtrum.com [10.0.64.8])
        by SHSQR01.spreadtrum.com with ESMTP id 3097LI0f092948;
        Mon, 9 Jan 2023 15:21:19 +0800 (+08)
        (envelope-from Chunyan.Zhang@unisoc.com)
Received: from ubt.spreadtrum.com (10.0.74.87) by BJMBX02.spreadtrum.com
 (10.0.64.8) with Microsoft SMTP Server (TLS) id 15.0.1497.23; Mon, 9 Jan 2023
 15:21:14 +0800
From:   Chunyan Zhang <chunyan.zhang@unisoc.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>
CC:     <linux-gpio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [RESEND PATCH V3 2/3] dt-bindings: gpio: Convert Unisoc EIC controller binding to yaml
Date:   Mon, 9 Jan 2023 15:21:05 +0800
Message-ID: <20230109072106.2176048-3-chunyan.zhang@unisoc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230109072106.2176048-1-chunyan.zhang@unisoc.com>
References: <20230109072106.2176048-1-chunyan.zhang@unisoc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.0.74.87]
X-ClientProxiedBy: SHCAS03.spreadtrum.com (10.0.1.207) To
 BJMBX02.spreadtrum.com (10.0.64.8)
X-MAIL: SHSQR01.spreadtrum.com 3097LI0f092948
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the Unisoc EIC controller binding to DT schema format.
Update the maxItems of 'reg' property, since the current gpio-eic-sprd
driver supports 3 reg items. Also removed a few similar examples.

Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../bindings/gpio/gpio-eic-sprd.txt           |  97 -----------------
 .../bindings/gpio/sprd,gpio-eic.yaml          | 103 ++++++++++++++++++
 2 files changed, 103 insertions(+), 97 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/gpio/gpio-eic-sprd.txt
 create mode 100644 Documentation/devicetree/bindings/gpio/sprd,gpio-eic.yaml

diff --git a/Documentation/devicetree/bindings/gpio/gpio-eic-sprd.txt b/Documentation/devicetree/bindings/gpio/gpio-eic-sprd.txt
deleted file mode 100644
index 54040a2bfe3a..000000000000
--- a/Documentation/devicetree/bindings/gpio/gpio-eic-sprd.txt
+++ /dev/null
@@ -1,97 +0,0 @@
-Spreadtrum EIC controller bindings
-
-The EIC is the abbreviation of external interrupt controller, which can
-be used only in input mode. The Spreadtrum platform has 2 EIC controllers,
-one is in digital chip, and another one is in PMIC. The digital chip EIC
-controller contains 4 sub-modules: EIC-debounce, EIC-latch, EIC-async and
-EIC-sync. But the PMIC EIC controller contains only one EIC-debounce sub-
-module.
-
-The EIC-debounce sub-module provides up to 8 source input signal
-connections. A debounce mechanism is used to capture the input signals'
-stable status (millisecond resolution) and a single-trigger mechanism
-is introduced into this sub-module to enhance the input event detection
-reliability. In addition, this sub-module's clock can be shut off
-automatically to reduce power dissipation. Moreover the debounce range
-is from 1ms to 4s with a step size of 1ms. The input signal will be
-ignored if it is asserted for less than 1 ms.
-
-The EIC-latch sub-module is used to latch some special power down signals
-and generate interrupts, since the EIC-latch does not depend on the APB
-clock to capture signals.
-
-The EIC-async sub-module uses a 32kHz clock to capture the short signals
-(microsecond resolution) to generate interrupts by level or edge trigger.
-
-The EIC-sync is similar with GPIO's input function, which is a synchronized
-signal input register. It can generate interrupts by level or edge trigger
-when detecting input signals.
-
-Required properties:
-- compatible: Should be one of the following:
-  "sprd,sc9860-eic-debounce",
-  "sprd,sc9860-eic-latch",
-  "sprd,sc9860-eic-async",
-  "sprd,sc9860-eic-sync",
-  "sprd,sc2731-eic".
-- reg: Define the base and range of the I/O address space containing
-  the GPIO controller registers.
-- gpio-controller: Marks the device node as a GPIO controller.
-- #gpio-cells: Should be <2>. The first cell is the gpio number and
-  the second cell is used to specify optional parameters.
-- interrupt-controller: Marks the device node as an interrupt controller.
-- #interrupt-cells: Should be <2>. Specifies the number of cells needed
-  to encode interrupt source.
-- interrupts: Should be the port interrupt shared by all the gpios.
-
-Example:
-	eic_debounce: gpio@40210000 {
-		compatible = "sprd,sc9860-eic-debounce";
-		reg = <0 0x40210000 0 0x80>;
-		gpio-controller;
-		#gpio-cells = <2>;
-		interrupt-controller;
-		#interrupt-cells = <2>;
-		interrupts = <GIC_SPI 52 IRQ_TYPE_LEVEL_HIGH>;
-	};
-
-	eic_latch: gpio@40210080 {
-		compatible = "sprd,sc9860-eic-latch";
-		reg = <0 0x40210080 0 0x20>;
-		gpio-controller;
-		#gpio-cells = <2>;
-		interrupt-controller;
-		#interrupt-cells = <2>;
-		interrupts = <GIC_SPI 52 IRQ_TYPE_LEVEL_HIGH>;
-	};
-
-	eic_async: gpio@402100a0 {
-		compatible = "sprd,sc9860-eic-async";
-		reg = <0 0x402100a0 0 0x20>;
-		gpio-controller;
-		#gpio-cells = <2>;
-		interrupt-controller;
-		#interrupt-cells = <2>;
-		interrupts = <GIC_SPI 52 IRQ_TYPE_LEVEL_HIGH>;
-	};
-
-	eic_sync: gpio@402100c0 {
-		compatible = "sprd,sc9860-eic-sync";
-		reg = <0 0x402100c0 0 0x20>;
-		gpio-controller;
-		#gpio-cells = <2>;
-		interrupt-controller;
-		#interrupt-cells = <2>;
-		interrupts = <GIC_SPI 52 IRQ_TYPE_LEVEL_HIGH>;
-	};
-
-	pmic_eic: gpio@300 {
-		compatible = "sprd,sc2731-eic";
-		reg = <0x300>;
-		interrupt-parent = <&sc2731_pmic>;
-		interrupts = <5 IRQ_TYPE_LEVEL_HIGH>;
-		gpio-controller;
-		#gpio-cells = <2>;
-		interrupt-controller;
-		#interrupt-cells = <2>;
-	};
diff --git a/Documentation/devicetree/bindings/gpio/sprd,gpio-eic.yaml b/Documentation/devicetree/bindings/gpio/sprd,gpio-eic.yaml
new file mode 100644
index 000000000000..a21350bd0f2c
--- /dev/null
+++ b/Documentation/devicetree/bindings/gpio/sprd,gpio-eic.yaml
@@ -0,0 +1,103 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+# Copyright 2022 Unisoc Inc.
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/gpio/sprd,gpio-eic.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Unisoc EIC controller
+
+maintainers:
+  - Orson Zhai <orsonzhai@gmail.com>
+  - Baolin Wang <baolin.wang7@gmail.com>
+  - Chunyan Zhang <zhang.lyra@gmail.com>
+
+description: |
+  The EIC is the abbreviation of external interrupt controller, which can
+  be used only in input mode. The Spreadtrum platform has 2 EIC controllers,
+  one is in digital chip, and another one is in PMIC. The digital chip EIC
+  controller contains 4 sub-modules, i.e. EIC-debounce, EIC-latch, EIC-async and
+  EIC-sync. But the PMIC EIC controller contains only one EIC-debounce sub-
+  module.
+
+  The EIC-debounce sub-module provides up to 8 source input signal
+  connections. A debounce mechanism is used to capture the input signals'
+  stable status (millisecond resolution) and a single-trigger mechanism
+  is introduced into this sub-module to enhance the input event detection
+  reliability. In addition, this sub-module's clock can be shut off
+  automatically to reduce power dissipation. Moreover the debounce range
+  is from 1ms to 4s with a step size of 1ms. The input signal will be
+  ignored if it is asserted for less than 1 ms.
+
+  The EIC-latch sub-module is used to latch some special power down signals
+  and generate interrupts, since the EIC-latch does not depend on the APB
+  clock to capture signals.
+
+  The EIC-async sub-module uses a 32kHz clock to capture the short signals
+  (microsecond resolution) to generate interrupts by level or edge trigger.
+
+  The EIC-sync is similar with GPIO's input function, which is a synchronized
+  signal input register. It can generate interrupts by level or edge trigger
+  when detecting input signals.
+
+properties:
+  compatible:
+    enum:
+      - sprd,sc9860-eic-debounce
+      - sprd,sc9860-eic-latch
+      - sprd,sc9860-eic-async
+      - sprd,sc9860-eic-sync
+      - sprd,sc2731-eic
+
+  reg:
+    minItems: 1
+    maxItems: 3
+    description:
+      EIC controller can support maximum 3 banks which has its own
+      address base.
+
+  gpio-controller: true
+
+  "#gpio-cells":
+    const: 2
+
+  interrupt-controller: true
+
+  "#interrupt-cells":
+    const: 2
+
+  interrupts:
+    maxItems: 1
+    description:
+      The interrupt shared by all GPIO lines for this controller.
+
+required:
+  - compatible
+  - reg
+  - gpio-controller
+  - "#gpio-cells"
+  - interrupt-controller
+  - "#interrupt-cells"
+  - interrupts
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    soc {
+        #address-cells = <2>;
+        #size-cells = <2>;
+
+        eic_debounce: gpio@40210000 {
+            compatible = "sprd,sc9860-eic-debounce";
+            reg = <0 0x40210000 0 0x80>;
+            gpio-controller;
+            #gpio-cells = <2>;
+            interrupt-controller;
+            #interrupt-cells = <2>;
+            interrupts = <GIC_SPI 52 IRQ_TYPE_LEVEL_HIGH>;
+        };
+    };
+...
-- 
2.25.1

