Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B553469E20F
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 15:12:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234265AbjBUOMH convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 21 Feb 2023 09:12:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233587AbjBUOL5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 09:11:57 -0500
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38333279BE;
        Tue, 21 Feb 2023 06:11:54 -0800 (PST)
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
        by ex01.ufhost.com (Postfix) with ESMTP id DE73724E1C7;
        Tue, 21 Feb 2023 22:11:52 +0800 (CST)
Received: from EXMBX061.cuchost.com (172.16.6.61) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Tue, 21 Feb
 2023 22:11:52 +0800
Received: from localhost.localdomain (183.27.98.67) by EXMBX061.cuchost.com
 (172.16.6.61) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Tue, 21 Feb
 2023 22:11:51 +0800
From:   Xingyu Wu <xingyu.wu@starfivetech.com>
To:     <linux-riscv@lists.infradead.org>, <devicetree@vger.kernel.org>,
        "Michael Turquette" <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Emil Renner Berthing <kernel@esmil.dk>
CC:     Rob Herring <robh+dt@kernel.org>, Conor Dooley <conor@kernel.org>,
        "Paul Walmsley" <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Hal Feng <hal.feng@starfivetech.com>,
        Xingyu Wu <xingyu.wu@starfivetech.com>,
        <linux-kernel@vger.kernel.org>, <linux-clk@vger.kernel.org>
Subject: [PATCH v1 1/3] dt-bindings: clock: Add StarFive JH7110 PLL clock generator
Date:   Tue, 21 Feb 2023 22:11:45 +0800
Message-ID: <20230221141147.303642-2-xingyu.wu@starfivetech.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230221141147.303642-1-xingyu.wu@starfivetech.com>
References: <20230221141147.303642-1-xingyu.wu@starfivetech.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [183.27.98.67]
X-ClientProxiedBy: EXCAS064.cuchost.com (172.16.6.24) To EXMBX061.cuchost.com
 (172.16.6.61)
X-YovoleRuleAgent: yovoleflag
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add bindings for the PLL clock generator on the JH7110 RISC-V SoC.

Signed-off-by: Xingyu Wu <xingyu.wu@starfivetech.com>
---
 .../bindings/clock/starfive,jh7110-pll.yaml   | 45 +++++++++++++++++++
 .../dt-bindings/clock/starfive,jh7110-crg.h   | 12 ++---
 2 files changed, 52 insertions(+), 5 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/starfive,jh7110-pll.yaml

diff --git a/Documentation/devicetree/bindings/clock/starfive,jh7110-pll.yaml b/Documentation/devicetree/bindings/clock/starfive,jh7110-pll.yaml
new file mode 100644
index 000000000000..8fd18e6c2e9b
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/starfive,jh7110-pll.yaml
@@ -0,0 +1,45 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/starfive,jh7110-pll.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: StarFive JH7110 PLL Clock Generator
+
+maintainers:
+  - Xingyu Wu <xingyu.wu@starfivetech.com>
+
+properties:
+  compatible:
+    const: starfive,jh7110-pll
+
+  clocks:
+    maxItems: 1
+      - description: Main Oscillator (24 MHz)
+
+  '#clock-cells':
+    const: 1
+    description:
+      See <dt-bindings/clock/starfive,jh7110-crg.h> for valid indices.
+
+  starfive,sysreg:
+    $ref: /schemas/types.yaml#/definitions/phandle-array
+    description:
+      the phandle to System Register Controller syscon node.
+
+required:
+  - compatible
+  - clocks
+  - '#clock-cells'
+  - starfive,sysreg
+
+additionalProperties: false
+
+examples:
+  - |
+    pllclk: pll-clock-controller {
+      compatible = "starfive,jh7110-pll";
+      clocks = <&osc>;
+      #clock-cells = <1>;
+      starfive,sysreg = <&sys_syscon>;
+    };
diff --git a/include/dt-bindings/clock/starfive,jh7110-crg.h b/include/dt-bindings/clock/starfive,jh7110-crg.h
index 5e4f21ca0642..086a6ddcf380 100644
--- a/include/dt-bindings/clock/starfive,jh7110-crg.h
+++ b/include/dt-bindings/clock/starfive,jh7110-crg.h
@@ -6,6 +6,12 @@
 #ifndef __DT_BINDINGS_CLOCK_STARFIVE_JH7110_CRG_H__
 #define __DT_BINDINGS_CLOCK_STARFIVE_JH7110_CRG_H__
 
+/* PLL clocks */
+#define JH7110_CLK_PLL0_OUT			0
+#define JH7110_CLK_PLL1_OUT			1
+#define JH7110_CLK_PLL2_OUT			2
+#define JH7110_PLLCLK_END			3
+
 /* SYSCRG clocks */
 #define JH7110_SYSCLK_CPU_ROOT			0
 #define JH7110_SYSCLK_CPU_CORE			1
@@ -198,11 +204,7 @@
 #define JH7110_SYSCLK_TDM_TDM_INV		188
 #define JH7110_SYSCLK_JTAG_CERTIFICATION_TRNG	189
 
-#define JH7110_SYSCLK_PLL0_OUT			190
-#define JH7110_SYSCLK_PLL1_OUT			191
-#define JH7110_SYSCLK_PLL2_OUT			192
-
-#define JH7110_SYSCLK_END			193
+#define JH7110_SYSCLK_END			190
 
 /* AONCRG clocks */
 #define JH7110_AONCLK_OSC_DIV4			0
-- 
2.25.1

