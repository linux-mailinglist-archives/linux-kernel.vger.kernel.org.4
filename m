Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E811B668E4C
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 07:52:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239755AbjAMGwE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 01:52:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233217AbjAMGvZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 01:51:25 -0500
Received: from mg.richtek.com (mg.richtek.com [220.130.44.152])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 313977F443;
        Thu, 12 Jan 2023 22:35:22 -0800 (PST)
X-MailGates: (flag:4,DYNAMIC,BADHELO,RELAY,NOHOST:PASS)(compute_score:DE
        LIVER,40,3)
Received: from 192.168.10.47
        by mg.richtek.com with MailGates ESMTP Server V5.0(16474:0:AUTH_RELAY)
        (envelope-from <cy_huang@richtek.com>); Fri, 13 Jan 2023 14:34:43 +0800 (CST)
Received: from ex4.rt.l (192.168.10.47) by ex4.rt.l (192.168.10.47) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.20; Fri, 13 Jan
 2023 14:34:43 +0800
Received: from linuxcarl2.richtek.com (192.168.10.154) by ex4.rt.l
 (192.168.10.45) with Microsoft SMTP Server id 15.2.1118.20 via Frontend
 Transport; Fri, 13 Jan 2023 14:34:43 +0800
From:   <cy_huang@richtek.com>
To:     <sre@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>
CC:     <allen_chiang@richtek.com>, <cy_huang@richtek.com>,
        <u0084500@gmail.com>, <linux-pm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH RESEND v3 1/3] dt-bindings: power: supply: Add Richtek RT9759 smart cap divider charger
Date:   Fri, 13 Jan 2023 14:34:40 +0800
Message-ID: <1673591682-25789-2-git-send-email-cy_huang@richtek.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1673591682-25789-1-git-send-email-cy_huang@richtek.com>
References: <1673591682-25789-1-git-send-email-cy_huang@richtek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: ChiYuan Huang <cy_huang@richtek.com>

Add bindings for the Richtek RT9759 smart cap divider charger.

Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
Since v2
- Add Reviewed-by tag for dt-binding patch

---
 .../bindings/power/supply/richtek,rt9759.yaml      | 61 ++++++++++++++++++++++
 1 file changed, 61 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/supply/richtek,rt9759.yaml

diff --git a/Documentation/devicetree/bindings/power/supply/richtek,rt9759.yaml b/Documentation/devicetree/bindings/power/supply/richtek,rt9759.yaml
new file mode 100644
index 00000000..04fc6b0
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/supply/richtek,rt9759.yaml
@@ -0,0 +1,61 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/power/supply/richtek,rt9759.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Richtek RT9759 Smart Cap Divider Charger
+
+maintainers:
+  - ChiYuan Huang <cy_huang@richtek.com>
+
+description: |
+  The RT9759 is a high efficiency and high charge current charger.
+  The efficiency is up to 97.8% when VBAT = 4.2V, IBAT = 2.5A and the maximum
+  charge current is up to 8A. The device integrates smart cap divider topology
+  with dual phase charge pump core. The ADCs provide input and output voltage,
+  current and temperature information to monitor the whole charging process.
+
+  Datasheet is available at
+  https://www.richtek.com/assets/product_file/RT9759/DS9759-02.pdf
+
+properties:
+  compatible:
+    enum:
+      - richtek,rt9759
+
+  reg:
+    maxItems: 1
+
+  wakeup-source: true
+
+  interrupts:
+    maxItems: 1
+
+  shunt-resistor-micro-ohms:
+    description: Battery current sense resistor mounted.
+    default: 2000
+
+required:
+  - compatible
+  - reg
+  - wakeup-source
+  - interrupts
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    i2c {
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      charger@66 {
+        compatible = "richtek,rt9759";
+        reg = <0x66>;
+        wakeup-source;
+        interrupts-extended = <&gpio_intc 32 IRQ_TYPE_EDGE_FALLING>;
+        shunt-resistor-micro-ohms = <5000>;
+      };
+    };
-- 
2.7.4

