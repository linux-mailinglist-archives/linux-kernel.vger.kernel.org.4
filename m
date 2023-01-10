Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B51B6636EF
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 02:50:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235118AbjAJBul (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 20:50:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235148AbjAJBue (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 20:50:34 -0500
Received: from SHSQR01.spreadtrum.com (mx1.unisoc.com [222.66.158.135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43E5810042;
        Mon,  9 Jan 2023 17:50:31 -0800 (PST)
Received: from SHSend.spreadtrum.com (bjmbx02.spreadtrum.com [10.0.64.8])
        by SHSQR01.spreadtrum.com with ESMTP id 30A1noT9015334;
        Tue, 10 Jan 2023 09:49:50 +0800 (+08)
        (envelope-from Chunyan.Zhang@unisoc.com)
Received: from ubt.spreadtrum.com (10.0.74.87) by BJMBX02.spreadtrum.com
 (10.0.64.8) with Microsoft SMTP Server (TLS) id 15.0.1497.23; Tue, 10 Jan
 2023 09:49:49 +0800
From:   Chunyan Zhang <chunyan.zhang@unisoc.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC:     <linux-gpio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        "Chunyan Zhang" <zhang.lyra@gmail.com>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH V4 1/3] dt-bindings: gpio: Convert Unisoc GPIO controller binding to yaml
Date:   Tue, 10 Jan 2023 09:49:41 +0800
Message-ID: <20230110014943.2196046-2-chunyan.zhang@unisoc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230110014943.2196046-1-chunyan.zhang@unisoc.com>
References: <20230110014943.2196046-1-chunyan.zhang@unisoc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.0.74.87]
X-ClientProxiedBy: SHCAS03.spreadtrum.com (10.0.1.207) To
 BJMBX02.spreadtrum.com (10.0.64.8)
X-MAIL: SHSQR01.spreadtrum.com 30A1noT9015334
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the Unisoc gpio controller binding to DT schema format.

Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../devicetree/bindings/gpio/gpio-sprd.txt    | 28 --------
 .../devicetree/bindings/gpio/sprd,gpio.yaml   | 70 +++++++++++++++++++
 2 files changed, 70 insertions(+), 28 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/gpio/gpio-sprd.txt
 create mode 100644 Documentation/devicetree/bindings/gpio/sprd,gpio.yaml

diff --git a/Documentation/devicetree/bindings/gpio/gpio-sprd.txt b/Documentation/devicetree/bindings/gpio/gpio-sprd.txt
deleted file mode 100644
index eca97d45388f..000000000000
--- a/Documentation/devicetree/bindings/gpio/gpio-sprd.txt
+++ /dev/null
@@ -1,28 +0,0 @@
-Spreadtrum GPIO controller bindings
-
-The controller's registers are organized as sets of sixteen 16-bit
-registers with each set controlling a bank of up to 16 pins. A single
-interrupt is shared for all of the banks handled by the controller.
-
-Required properties:
-- compatible: Should be "sprd,sc9860-gpio".
-- reg: Define the base and range of the I/O address space containing
-the GPIO controller registers.
-- gpio-controller: Marks the device node as a GPIO controller.
-- #gpio-cells: Should be <2>. The first cell is the gpio number and
-the second cell is used to specify optional parameters.
-- interrupt-controller: Marks the device node as an interrupt controller.
-- #interrupt-cells: Should be <2>. Specifies the number of cells needed
-to encode interrupt source.
-- interrupts: Should be the port interrupt shared by all the gpios.
-
-Example:
-	ap_gpio: gpio@40280000 {
-		compatible = "sprd,sc9860-gpio";
-		reg = <0 0x40280000 0 0x1000>;
-		gpio-controller;
-		#gpio-cells = <2>;
-		interrupt-controller;
-		#interrupt-cells = <2>;
-		interrupts = <GIC_SPI 50 IRQ_TYPE_LEVEL_HIGH>;
-	};
diff --git a/Documentation/devicetree/bindings/gpio/sprd,gpio.yaml b/Documentation/devicetree/bindings/gpio/sprd,gpio.yaml
new file mode 100644
index 000000000000..40924123d184
--- /dev/null
+++ b/Documentation/devicetree/bindings/gpio/sprd,gpio.yaml
@@ -0,0 +1,70 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+# Copyright 2022 Unisoc Inc.
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/gpio/sprd,gpio.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Unisoc GPIO controller
+
+maintainers:
+  - Orson Zhai <orsonzhai@gmail.com>
+  - Baolin Wang <baolin.wang7@gmail.com>
+  - Chunyan Zhang <zhang.lyra@gmail.com>
+
+description: |
+  The controller's registers are organized as sets of sixteen 16-bit
+  registers with each set controlling a bank of up to 16 pins. A single
+  interrupt is shared for all of the banks handled by the controller.
+
+properties:
+  compatible:
+    const: sprd,sc9860-gpio
+
+  reg:
+    maxItems: 1
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
+    description: The interrupt shared by all GPIO lines for this controller.
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
+        ap_gpio: gpio@40280000 {
+            compatible = "sprd,sc9860-gpio";
+            reg = <0 0x40280000 0 0x1000>;
+            gpio-controller;
+            #gpio-cells = <2>;
+            interrupt-controller;
+            #interrupt-cells = <2>;
+            interrupts = <GIC_SPI 50 IRQ_TYPE_LEVEL_HIGH>;
+        };
+    };
+...
-- 
2.25.1

