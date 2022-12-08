Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30CC1646AF2
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 09:46:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230085AbiLHIqt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 03:46:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230119AbiLHIq0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 03:46:26 -0500
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3B616723D;
        Thu,  8 Dec 2022 00:45:36 -0800 (PST)
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
        by ex01.ufhost.com (Postfix) with ESMTP id 98CE824E27B;
        Thu,  8 Dec 2022 16:45:35 +0800 (CST)
Received: from EXMBX068.cuchost.com (172.16.6.68) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Thu, 8 Dec
 2022 16:45:35 +0800
Received: from localhost.localdomain (113.72.146.33) by EXMBX068.cuchost.com
 (172.16.6.68) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Thu, 8 Dec
 2022 16:45:34 +0800
From:   Walker Chen <walker.chen@starfivetech.com>
To:     <linux-riscv@lists.infradead.org>, <linux-pm@vger.kernel.org>,
        <devicetree@vger.kernel.org>
CC:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor.dooley@microchip.com>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Walker Chen <walker.chen@starfivetech.com>,
        <linux-kernel@vger.kernel.org>
Subject: [RESEND PATCH v2 1/3] dt-bindings: power: Add starfive,jh71xx-pmu
Date:   Thu, 8 Dec 2022 16:45:21 +0800
Message-ID: <20221208084523.9733-2-walker.chen@starfivetech.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221208084523.9733-1-walker.chen@starfivetech.com>
References: <20221208084523.9733-1-walker.chen@starfivetech.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [113.72.146.33]
X-ClientProxiedBy: EXCAS066.cuchost.com (172.16.6.26) To EXMBX068.cuchost.com
 (172.16.6.68)
X-YovoleRuleAgent: yovoleflag
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add bindings for Power Management Unit (PMU) on the StarFive JH71XX SoC.

Signed-off-by: Walker Chen <walker.chen@starfivetech.com>
---
 .../bindings/power/starfive,jh71xx-pmu.yaml   | 45 +++++++++++++++++++
 .../dt-bindings/power/starfive,jh7110-pmu.h   | 17 +++++++
 2 files changed, 62 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/starfive,jh71xx-pmu.yaml
 create mode 100644 include/dt-bindings/power/starfive,jh7110-pmu.h

diff --git a/Documentation/devicetree/bindings/power/starfive,jh71xx-pmu.yaml b/Documentation/devicetree/bindings/power/starfive,jh71xx-pmu.yaml
new file mode 100644
index 000000000000..f308ae136a57
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/starfive,jh71xx-pmu.yaml
@@ -0,0 +1,45 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/power/starfive,jh71xx-pmu.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: StarFive JH71xx Power Management Unit
+
+maintainers:
+  - Walker Chen <walker.chen@starfivetech.com>
+
+description: |
+  StarFive JH71xx SoCs include support for multiple power domains which can be
+  powered on/off by software based on different application scenes to save power.
+
+properties:
+  compatible:
+      - enum:
+          - starfive,jh7110-pmu
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  "#power-domain-cells":
+    const: 1
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - "#power-domain-cells"
+
+additionalProperties: false
+
+examples:
+  - |
+    pwrc: power-controller@17030000 {
+        compatible = "starfive,jh7110-pmu";
+        reg = <0x17030000 0x10000>;
+        interrupts = <111>;
+        #power-domain-cells = <1>;
+    };
diff --git a/include/dt-bindings/power/starfive,jh7110-pmu.h b/include/dt-bindings/power/starfive,jh7110-pmu.h
new file mode 100644
index 000000000000..73c6a79a2181
--- /dev/null
+++ b/include/dt-bindings/power/starfive,jh7110-pmu.h
@@ -0,0 +1,17 @@
+/* SPDX-License-Identifier: (GPL-2.0 OR MIT) */
+/*
+ * Copyright (C) 2022 StarFive Technology Co., Ltd.
+ * Author: Walker Chen <walker.chen@starfivetech.com>
+ */
+#ifndef __DT_BINDINGS_POWER_JH7110_POWER_H__
+#define __DT_BINDINGS_POWER_JH7110_POWER_H__
+
+#define JH7110_PD_SYSTOP	0
+#define JH7110_PD_CPU		1
+#define JH7110_PD_GPUA		2
+#define JH7110_PD_VDEC		3
+#define JH7110_PD_VOUT		4
+#define JH7110_PD_ISP		5
+#define JH7110_PD_VENC		6
+
+#endif
-- 
2.17.1

