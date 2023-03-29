Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0EFF6CCF13
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 02:44:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229756AbjC2An7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 20:43:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjC2Anz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 20:43:55 -0400
Received: from mg.richtek.com (mg.richtek.com [220.130.44.152])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 83B0B2109;
        Tue, 28 Mar 2023 17:43:49 -0700 (PDT)
X-MailGates: (flag:4,DYNAMIC,BADHELO,RELAY,NOHOST:PASS)(compute_score:DE
        LIVER,40,3)
Received: from 192.168.10.47
        by mg.richtek.com with MailGates ESMTP Server V5.0(26679:0:AUTH_RELAY)
        (envelope-from <cy_huang@richtek.com>); Wed, 29 Mar 2023 08:43:28 +0800 (CST)
Received: from ex4.rt.l (192.168.10.47) by ex4.rt.l (192.168.10.47) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.25; Wed, 29 Mar
 2023 08:43:27 +0800
Received: from linuxcarl2.richtek.com (192.168.10.154) by ex4.rt.l
 (192.168.10.45) with Microsoft SMTP Server id 15.2.1118.25 via Frontend
 Transport; Wed, 29 Mar 2023 08:43:27 +0800
From:   <cy_huang@richtek.com>
To:     <broonie@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>
CC:     <lgirdwood@gmail.com>, <cy_huang@richtek.com>,
        <jeff_chang@richtek.com>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
Subject: [PATCH v2 1/2] regulator: dt-bindings: Add Richtek RT4803
Date:   Wed, 29 Mar 2023 08:43:25 +0800
Message-ID: <1680050606-461-1-git-send-email-cy_huang@richtek.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=0.0 required=5.0 tests=SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: ChiYuan Huang <cy_huang@richtek.com>

Add the binding document for Richtek RT4803.

Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
Since v2
- Subject prefix change to 'regulator: dt-bindings: .....'
- Add Reviewed-by tag.
---
 .../bindings/regulator/richtek,rt4803.yaml         | 68 ++++++++++++++++++++++
 1 file changed, 68 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/regulator/richtek,rt4803.yaml

diff --git a/Documentation/devicetree/bindings/regulator/richtek,rt4803.yaml b/Documentation/devicetree/bindings/regulator/richtek,rt4803.yaml
new file mode 100644
index 00000000..6ceba02
--- /dev/null
+++ b/Documentation/devicetree/bindings/regulator/richtek,rt4803.yaml
@@ -0,0 +1,68 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/regulator/richtek,rt4803.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Richtek RT4803 Boost Regulator
+
+maintainers:
+  - ChiYuan Huang <cy_huang@richtek.com>
+
+description: |
+  RT4803 is a boost regulator that's designed to provide the minimum output
+  voltage, even if the input voltage is lower than the required voltage. It
+  supports boost and auto bypass mode that depends on the difference between the
+  input and output voltage. If the input is lower than the output, mode will
+  transform to boost mode. Otherwise, turn on bypass switch to enter bypass mode.
+
+  Datasheet is available at
+  https://www.richtek.com/assets/product_file/RT4803/DS4803-03.pdf
+  https://www.richtek.com/assets/product_file/RT4803A/DS4803A-06.pdf
+
+allOf:
+  - $ref: regulator.yaml#
+
+properties:
+  compatible:
+    enum:
+      - richtek,rt4803
+
+  reg:
+    maxItems: 1
+
+  richtek,vsel-active-high:
+    type: boolean
+    description: Specify the VSEL register group is using when system is active
+
+  regulator-allowed-modes:
+    description: |
+      Available operating mode
+        1: Auto PFM/PWM
+        2: Force PWM
+    items:
+      enum: [1, 2]
+
+required:
+  - compatible
+  - reg
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    i2c {
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      regulator@75 {
+        compatible = "richtek,rt4803";
+        reg = <0x75>;
+        richtek,vsel-active-high;
+        regulator-name = "rt4803-regulator";
+        regulator-min-microvolt = <2850000>;
+        regulator-max-microvolt = <4400000>;
+        regulator-allowed-modes = <1 2>;
+        regulator-always-on;
+      };
+    };
-- 
2.7.4

