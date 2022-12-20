Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D991165175A
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 01:51:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232967AbiLTAvd convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 19 Dec 2022 19:51:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232789AbiLTAvF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 19:51:05 -0500
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48727FAF9;
        Mon, 19 Dec 2022 16:51:03 -0800 (PST)
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
        by fd01.gateway.ufhost.com (Postfix) with ESMTP id CB6C624DFE2;
        Tue, 20 Dec 2022 08:51:01 +0800 (CST)
Received: from EXMBX172.cuchost.com (172.16.6.92) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Tue, 20 Dec
 2022 08:51:02 +0800
Received: from ubuntu.localdomain (183.27.97.120) by EXMBX172.cuchost.com
 (172.16.6.92) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Tue, 20 Dec
 2022 08:51:00 +0800
From:   Hal Feng <hal.feng@starfivetech.com>
To:     <linux-riscv@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-clk@vger.kernel.org>
CC:     Conor Dooley <conor@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        "Rob Herring" <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        "Michael Turquette" <mturquette@baylibre.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        Hal Feng <hal.feng@starfivetech.com>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 08/11] dt-bindings: clock: Add StarFive JH7110 always-on clock and reset generator
Date:   Tue, 20 Dec 2022 08:50:51 +0800
Message-ID: <20221220005054.34518-9-hal.feng@starfivetech.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221220005054.34518-1-hal.feng@starfivetech.com>
References: <20221220005054.34518-1-hal.feng@starfivetech.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [183.27.97.120]
X-ClientProxiedBy: EXCAS066.cuchost.com (172.16.6.26) To EXMBX172.cuchost.com
 (172.16.6.92)
X-YovoleRuleAgent: yovoleflag
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Emil Renner Berthing <kernel@esmil.dk>

Add bindings for the always-on clock and reset generator (AONCRG) on the
JH7110 RISC-V SoC by StarFive Ltd.

Signed-off-by: Emil Renner Berthing <kernel@esmil.dk>
Signed-off-by: Hal Feng <hal.feng@starfivetech.com>
---
 .../clock/starfive,jh7110-aoncrg.yaml         | 76 +++++++++++++++++++
 .../dt-bindings/clock/starfive,jh7110-crg.h   | 18 +++++
 .../dt-bindings/reset/starfive,jh7110-crg.h   | 12 +++
 3 files changed, 106 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/starfive,jh7110-aoncrg.yaml

diff --git a/Documentation/devicetree/bindings/clock/starfive,jh7110-aoncrg.yaml b/Documentation/devicetree/bindings/clock/starfive,jh7110-aoncrg.yaml
new file mode 100644
index 000000000000..a3cf0570d950
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/starfive,jh7110-aoncrg.yaml
@@ -0,0 +1,76 @@
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
+    items:
+      - description: Main Oscillator (24 MHz)
+      - description: RTC Oscillator (32.768 kHz)
+      - description: GMAC0 RMII reference
+      - description: GMAC0 RGMII RX
+      - description: STG AXI/AHB
+      - description: APB Bus
+      - description: GMAC0 GTX
+
+  clock-names:
+    items:
+      - const: osc
+      - const: rtc_osc
+      - const: gmac0_rmii_refin
+      - const: gmac0_rgmii_rxin
+      - const: stg_axiahb
+      - const: apb_bus
+      - const: gmac0_gtxclk
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
+        clocks = <&osc>, <&rtc_osc>,
+                 <&gmac0_rmii_refin>, <&gmac0_rgmii_rxin>,
+                 <&syscrg JH7110_SYSCLK_STG_AXIAHB>,
+                 <&syscrg JH7110_SYSCLK_APB_BUS>,
+                 <&syscrg JH7110_SYSCLK_GMAC0_GTXCLK>;
+        clock-names = "osc", "rtc_osc", "gmac0_rmii_refin",
+                      "gmac0_rgmii_rxin", "stg_axiahb",
+                      "apb_bus", "gmac0_gtxclk";
+        #clock-cells = <1>;
+        #reset-cells = <1>;
+    };
diff --git a/include/dt-bindings/clock/starfive,jh7110-crg.h b/include/dt-bindings/clock/starfive,jh7110-crg.h
index cda199084bcf..5e4f21ca0642 100644
--- a/include/dt-bindings/clock/starfive,jh7110-crg.h
+++ b/include/dt-bindings/clock/starfive,jh7110-crg.h
@@ -204,4 +204,22 @@
 
 #define JH7110_SYSCLK_END			193
 
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

