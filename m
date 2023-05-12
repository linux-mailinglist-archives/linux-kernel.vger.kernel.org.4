Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 565D56FFEEE
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 04:23:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239840AbjELCWj convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 11 May 2023 22:22:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239780AbjELCWW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 22:22:22 -0400
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B90365BA5;
        Thu, 11 May 2023 19:22:20 -0700 (PDT)
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
        by fd01.gateway.ufhost.com (Postfix) with ESMTP id 00D1E817A;
        Fri, 12 May 2023 10:22:14 +0800 (CST)
Received: from EXMBX061.cuchost.com (172.16.6.61) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Fri, 12 May
 2023 10:22:13 +0800
Received: from localhost.localdomain (113.72.146.187) by EXMBX061.cuchost.com
 (172.16.6.61) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Fri, 12 May
 2023 10:22:12 +0800
From:   Xingyu Wu <xingyu.wu@starfivetech.com>
To:     <linux-riscv@lists.infradead.org>, <devicetree@vger.kernel.org>,
        "Michael Turquette" <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Conor Dooley <conor@kernel.org>,
        "Emil Renner Berthing" <kernel@esmil.dk>
CC:     Rob Herring <robh+dt@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Hal Feng <hal.feng@starfivetech.com>,
        Xingyu Wu <xingyu.wu@starfivetech.com>,
        William Qiu <william.qiu@starfivetech.com>,
        <linux-kernel@vger.kernel.org>, <linux-clk@vger.kernel.org>
Subject: [PATCH v4 1/7] dt-bindings: clock: Add StarFive JH7110 PLL clock generator
Date:   Fri, 12 May 2023 10:20:30 +0800
Message-ID: <20230512022036.97987-2-xingyu.wu@starfivetech.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230512022036.97987-1-xingyu.wu@starfivetech.com>
References: <20230512022036.97987-1-xingyu.wu@starfivetech.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [113.72.146.187]
X-ClientProxiedBy: EXCAS062.cuchost.com (172.16.6.22) To EXMBX061.cuchost.com
 (172.16.6.61)
X-YovoleRuleAgent: yovoleflag
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add bindings for the PLL clock generator on the JH7110 RISC-V SoC.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Xingyu Wu <xingyu.wu@starfivetech.com>
---
 .../bindings/clock/starfive,jh7110-pll.yaml   | 46 +++++++++++++++++++
 .../dt-bindings/clock/starfive,jh7110-crg.h   |  6 +++
 2 files changed, 52 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/starfive,jh7110-pll.yaml

diff --git a/Documentation/devicetree/bindings/clock/starfive,jh7110-pll.yaml b/Documentation/devicetree/bindings/clock/starfive,jh7110-pll.yaml
new file mode 100644
index 000000000000..8aa8c7b8e42f
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/starfive,jh7110-pll.yaml
@@ -0,0 +1,46 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/starfive,jh7110-pll.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: StarFive JH7110 PLL Clock Generator
+
+description:
+  This PLL are high speed, low jitter frequency synthesizers in JH7110.
+  Each PLL clocks work in integer mode or fraction mode by some dividers,
+  and the configuration registers and dividers are set in several syscon
+  registers. So pll node should be a child of SYS-SYSCON node.
+  The formula for calculating frequency is that,
+  Fvco = Fref * (NI + NF) / M / Q1
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
+    description: Main Oscillator (24 MHz)
+
+  '#clock-cells':
+    const: 1
+    description:
+      See <dt-bindings/clock/starfive,jh7110-crg.h> for valid indices.
+
+required:
+  - compatible
+  - clocks
+  - '#clock-cells'
+
+additionalProperties: false
+
+examples:
+  - |
+    pll-clock-controller {
+      compatible = "starfive,jh7110-pll";
+      clocks = <&osc>;
+      #clock-cells = <1>;
+    };
diff --git a/include/dt-bindings/clock/starfive,jh7110-crg.h b/include/dt-bindings/clock/starfive,jh7110-crg.h
index 06257bfd9ac1..086a6ddcf380 100644
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
-- 
2.25.1

