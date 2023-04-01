Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 020296D2FE8
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Apr 2023 13:19:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229870AbjDALTx convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sat, 1 Apr 2023 07:19:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229754AbjDALTs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Apr 2023 07:19:48 -0400
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0949C20318;
        Sat,  1 Apr 2023 04:19:45 -0700 (PDT)
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
        by ex01.ufhost.com (Postfix) with ESMTP id 9F11724DBC0;
        Sat,  1 Apr 2023 19:19:39 +0800 (CST)
Received: from EXMBX172.cuchost.com (172.16.6.92) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Sat, 1 Apr
 2023 19:19:39 +0800
Received: from ubuntu.localdomain (113.72.144.76) by EXMBX172.cuchost.com
 (172.16.6.92) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Sat, 1 Apr
 2023 19:19:38 +0800
From:   Hal Feng <hal.feng@starfivetech.com>
To:     <linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>
CC:     Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        "Rob Herring" <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor@kernel.org>,
        "Palmer Dabbelt" <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Ben Dooks <ben.dooks@sifive.com>,
        "Daniel Lezcano" <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        Hal Feng <hal.feng@starfivetech.com>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v7 02/22] dt-bindings: clock: Add StarFive JH7110 always-on clock and reset generator
Date:   Sat, 1 Apr 2023 19:19:14 +0800
Message-ID: <20230401111934.130844-3-hal.feng@starfivetech.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230401111934.130844-1-hal.feng@starfivetech.com>
References: <20230401111934.130844-1-hal.feng@starfivetech.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [113.72.144.76]
X-ClientProxiedBy: EXCAS066.cuchost.com (172.16.6.26) To EXMBX172.cuchost.com
 (172.16.6.92)
X-YovoleRuleAgent: yovoleflag
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=0.0 required=5.0 tests=SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Emil Renner Berthing <kernel@esmil.dk>

Add bindings for the always-on clock and reset generator (AONCRG) on the
JH7110 RISC-V SoC by StarFive Ltd.

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Emil Renner Berthing <kernel@esmil.dk>
Signed-off-by: Hal Feng <hal.feng@starfivetech.com>
---
 .../clock/starfive,jh7110-aoncrg.yaml         | 107 ++++++++++++++++++
 .../dt-bindings/clock/starfive,jh7110-crg.h   |  18 +++
 .../dt-bindings/reset/starfive,jh7110-crg.h   |  12 ++
 3 files changed, 137 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/starfive,jh7110-aoncrg.yaml

diff --git a/Documentation/devicetree/bindings/clock/starfive,jh7110-aoncrg.yaml b/Documentation/devicetree/bindings/clock/starfive,jh7110-aoncrg.yaml
new file mode 100644
index 000000000000..923680a44aef
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/starfive,jh7110-aoncrg.yaml
@@ -0,0 +1,107 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/starfive,jh7110-aoncrg.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: StarFive JH7110 Always-On Clock and Reset Generator
+
+maintainers:
+  - Emil Renner Berthing <kernel@esmil.dk>
+
+properties:
+  compatible:
+    const: starfive,jh7110-aoncrg
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    oneOf:
+      - items:
+          - description: Main Oscillator (24 MHz)
+          - description: GMAC0 RMII reference or GMAC0 RGMII RX
+          - description: STG AXI/AHB
+          - description: APB Bus
+          - description: GMAC0 GTX
+
+      - items:
+          - description: Main Oscillator (24 MHz)
+          - description: GMAC0 RMII reference or GMAC0 RGMII RX
+          - description: STG AXI/AHB or GMAC0 RGMII RX
+          - description: APB Bus or STG AXI/AHB
+          - description: GMAC0 GTX or APB Bus
+          - description: RTC Oscillator (32.768 kHz) or GMAC0 GTX
+
+      - items:
+          - description: Main Oscillator (24 MHz)
+          - description: GMAC0 RMII reference
+          - description: GMAC0 RGMII RX
+          - description: STG AXI/AHB
+          - description: APB Bus
+          - description: GMAC0 GTX
+          - description: RTC Oscillator (32.768 kHz)
+
+  clock-names:
+    oneOf:
+      - minItems: 5
+        items:
+          - const: osc
+          - enum:
+              - gmac0_rmii_refin
+              - gmac0_rgmii_rxin
+          - const: stg_axiahb
+          - const: apb_bus
+          - const: gmac0_gtxclk
+          - const: rtc_osc
+
+      - minItems: 6
+        items:
+          - const: osc
+          - const: gmac0_rmii_refin
+          - const: gmac0_rgmii_rxin
+          - const: stg_axiahb
+          - const: apb_bus
+          - const: gmac0_gtxclk
+          - const: rtc_osc
+
+  '#clock-cells':
+    const: 1
+    description:
+      See <dt-bindings/clock/starfive,jh7110-crg.h> for valid indices.
+
+  '#reset-cells':
+    const: 1
+    description:
+      See <dt-bindings/reset/starfive,jh7110-crg.h> for valid indices.
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - clock-names
+  - '#clock-cells'
+  - '#reset-cells'
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/starfive,jh7110-crg.h>
+
+    clock-controller@17000000 {
+        compatible = "starfive,jh7110-aoncrg";
+        reg = <0x17000000 0x10000>;
+        clocks = <&osc>, <&gmac0_rmii_refin>,
+                 <&gmac0_rgmii_rxin>,
+                 <&syscrg JH7110_SYSCLK_STG_AXIAHB>,
+                 <&syscrg JH7110_SYSCLK_APB_BUS>,
+                 <&syscrg JH7110_SYSCLK_GMAC0_GTXCLK>,
+                 <&rtc_osc>;
+        clock-names = "osc", "gmac0_rmii_refin",
+                      "gmac0_rgmii_rxin", "stg_axiahb",
+                      "apb_bus", "gmac0_gtxclk",
+                      "rtc_osc";
+        #clock-cells = <1>;
+        #reset-cells = <1>;
+    };
diff --git a/include/dt-bindings/clock/starfive,jh7110-crg.h b/include/dt-bindings/clock/starfive,jh7110-crg.h
index fdd1852e34cc..06257bfd9ac1 100644
--- a/include/dt-bindings/clock/starfive,jh7110-crg.h
+++ b/include/dt-bindings/clock/starfive,jh7110-crg.h
@@ -200,4 +200,22 @@
 
 #define JH7110_SYSCLK_END			190
 
+/* AONCRG clocks */
+#define JH7110_AONCLK_OSC_DIV4			0
+#define JH7110_AONCLK_APB_FUNC			1
+#define JH7110_AONCLK_GMAC0_AHB			2
+#define JH7110_AONCLK_GMAC0_AXI			3
+#define JH7110_AONCLK_GMAC0_RMII_RTX		4
+#define JH7110_AONCLK_GMAC0_TX			5
+#define JH7110_AONCLK_GMAC0_TX_INV		6
+#define JH7110_AONCLK_GMAC0_RX			7
+#define JH7110_AONCLK_GMAC0_RX_INV		8
+#define JH7110_AONCLK_OTPC_APB			9
+#define JH7110_AONCLK_RTC_APB			10
+#define JH7110_AONCLK_RTC_INTERNAL		11
+#define JH7110_AONCLK_RTC_32K			12
+#define JH7110_AONCLK_RTC_CAL			13
+
+#define JH7110_AONCLK_END			14
+
 #endif /* __DT_BINDINGS_CLOCK_STARFIVE_JH7110_CRG_H__ */
diff --git a/include/dt-bindings/reset/starfive,jh7110-crg.h b/include/dt-bindings/reset/starfive,jh7110-crg.h
index b88216a4fe40..d78e38690ceb 100644
--- a/include/dt-bindings/reset/starfive,jh7110-crg.h
+++ b/include/dt-bindings/reset/starfive,jh7110-crg.h
@@ -139,4 +139,16 @@
 
 #define JH7110_SYSRST_END			126
 
+/* AONCRG resets */
+#define JH7110_AONRST_GMAC0_AXI			0
+#define JH7110_AONRST_GMAC0_AHB			1
+#define JH7110_AONRST_IOMUX			2
+#define JH7110_AONRST_PMU_APB			3
+#define JH7110_AONRST_PMU_WKUP			4
+#define JH7110_AONRST_RTC_APB			5
+#define JH7110_AONRST_RTC_CAL			6
+#define JH7110_AONRST_RTC_32K			7
+
+#define JH7110_AONRST_END			8
+
 #endif /* __DT_BINDINGS_RESET_STARFIVE_JH7110_CRG_H__ */
-- 
2.38.1

