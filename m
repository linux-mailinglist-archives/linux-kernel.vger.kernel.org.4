Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 679CB5BA47F
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 04:04:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229863AbiIPCDz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 22:03:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229966AbiIPCDi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 22:03:38 -0400
Received: from mail-sh.amlogic.com (mail-sh.amlogic.com [58.32.228.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8813531DD2;
        Thu, 15 Sep 2022 19:03:37 -0700 (PDT)
Received: from droid01-xa.amlogic.com (10.88.11.200) by mail-sh.amlogic.com
 (10.18.11.5) with Microsoft SMTP Server id 15.1.2507.9; Fri, 16 Sep 2022
 10:03:28 +0800
From:   Jiucheng Xu <jiucheng.xu@amlogic.com>
To:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-amlogic@lists.infradead.org>, <devicetree@vger.kernel.org>
CC:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Chris Healy <cphealy@gmail.com>,
        Jianxin Pan <jianxin.pan@amlogic.com>,
        Kelvin Zhang <kelvin.zhang@amlogic.com>,
        Jiucheng Xu <jiucheng.xu@amlogic.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v8 3/4] dt-binding: perf: Add Amlogic DDR PMU
Date:   Fri, 16 Sep 2022 10:03:19 +0800
Message-ID: <20220916020320.2455580-3-jiucheng.xu@amlogic.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220916020320.2455580-1-jiucheng.xu@amlogic.com>
References: <20220916020320.2455580-1-jiucheng.xu@amlogic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.88.11.200]
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add binding documentation for the Amlogic G12 series DDR
performance monitor unit.

Signed-off-by: Jiucheng Xu <jiucheng.xu@amlogic.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
Changes v7 -> v8:
  - No change

Changes v6 -> v7:
  - No change

Changes v5 -> v6:
  - remove blank line

Changes v4 -> v5:
  - Remove "items" in compatible since have only one item
  - Condense description of reg
  - Rename node
  - Split one reg into two reg items.
  - Binding go first
 
Changes v3 -> v4:
  - Fix "$id: relative path/filename doesn't match actual path or
    filename" warning

Changes v2 -> v3:
  - Remove oneOf
  - Add descriptions
  - Fix compiling warning

Changes v1 -> v2:
  - Rename file, from aml_ddr_pmu.yaml to amlogic,g12_ddr_pmu.yaml
  - Delete "model", "dmc_nr", "chann_nr" new properties
  - Fix compiling error
---
 .../bindings/perf/amlogic,g12-ddr-pmu.yaml    | 54 +++++++++++++++++++
 MAINTAINERS                                   |  1 +
 2 files changed, 55 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/perf/amlogic,g12-ddr-pmu.yaml

diff --git a/Documentation/devicetree/bindings/perf/amlogic,g12-ddr-pmu.yaml b/Documentation/devicetree/bindings/perf/amlogic,g12-ddr-pmu.yaml
new file mode 100644
index 000000000000..50f46a6898b1
--- /dev/null
+++ b/Documentation/devicetree/bindings/perf/amlogic,g12-ddr-pmu.yaml
@@ -0,0 +1,54 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/perf/amlogic,g12-ddr-pmu.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Amlogic G12 DDR performance monitor
+
+maintainers:
+  - Jiucheng Xu <jiucheng.xu@amlogic.com>
+
+description: |
+  Amlogic G12 series SoC integrate DDR bandwidth monitor.
+  A timer is inside and can generate interrupt when timeout.
+  The bandwidth is counted in the timer ISR. Different platform
+  has different subset of event format attribute.
+
+properties:
+  compatible:
+    enum:
+      - amlogic,g12a-ddr-pmu
+      - amlogic,g12b-ddr-pmu
+      - amlogic,sm1-ddr-pmu
+
+  reg:
+    items:
+      - description: DMC bandwidth register space.
+      - description: DMC PLL register space.
+
+  interrupts:
+    items:
+      - description: The IRQ of the inside timer timeout.
+
+required:
+  - compatible
+  - reg
+  - interrupts
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    pmu {
+        #address-cells=<2>;
+        #size-cells=<2>;
+
+        pmu@ff638000 {
+            compatible = "amlogic,g12a-ddr-pmu";
+            reg = <0x0 0xff638000 0x0 0x100>,
+                  <0x0 0xff638c00 0x0 0x100>;
+            interrupts = <GIC_SPI 52 IRQ_TYPE_EDGE_RISING>;
+        };
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index 5ed563368a48..b03e821a9e3c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1056,6 +1056,7 @@ L:	linux-amlogic@lists.infradead.org
 S:	Supported
 W:	http://www.amlogic.com
 F:	Documentation/admin-guide/perf/meson-ddr-pmu.rst
+F:	Documentation/devicetree/bindings/perf/amlogic,g12-ddr-pmu.yaml
 F:	drivers/perf/amlogic/
 F:	include/soc/amlogic/
 
-- 
2.25.1

