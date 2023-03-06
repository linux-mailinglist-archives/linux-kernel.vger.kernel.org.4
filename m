Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF28B6AB3D1
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 01:43:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229609AbjCFAnE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Mar 2023 19:43:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjCFAm7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Mar 2023 19:42:59 -0500
Received: from mg.richtek.com (mg.richtek.com [220.130.44.152])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 441AB199F;
        Sun,  5 Mar 2023 16:42:55 -0800 (PST)
X-MailGates: (flag:4,DYNAMIC,BADHELO,RELAY,NOHOST:PASS)(compute_score:DE
        LIVER,40,3)
Received: from 192.168.10.46
        by mg.richtek.com with MailGates ESMTP Server V5.0(16313:0:AUTH_RELAY)
        (envelope-from <cy_huang@richtek.com>); Mon, 06 Mar 2023 08:42:40 +0800 (CST)
Received: from ex4.rt.l (192.168.10.47) by ex3.rt.l (192.168.10.46) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.25; Mon, 6 Mar
 2023 08:42:39 +0800
Received: from linuxcarl2.richtek.com (192.168.10.154) by ex4.rt.l
 (192.168.10.45) with Microsoft SMTP Server id 15.2.1118.25 via Frontend
 Transport; Mon, 6 Mar 2023 08:42:39 +0800
From:   <cy_huang@richtek.com>
To:     <broonie@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>
CC:     <lgirdwood@gmail.com>, <cy_huang@richtek.com>,
        <u0084500@gmail.com>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
Subject: [PATCH v3 1/2] dt-bindings: regulator: Add Richtek RT5739
Date:   Mon, 6 Mar 2023 08:42:37 +0800
Message-ID: <1678063358-18128-1-git-send-email-cy_huang@richtek.com>
X-Mailer: git-send-email 1.8.3.1
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

Add the binding document for Richtek RT5739.

Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
Since v3:
- Add 'Reviewed-by" tag.

Since v2:
- Refine dt-binding patch subject
- Shorten and refine title and description without too much marketing text.
- Fix the typo from 'connecton' to 'connection' in 'richtek,vsel-active-high'
  property description
- Remove maxItems in property 'regulator-allowed-modes'
- Fix the wrong min/max microvolt in binding example. Must be '300000' and
  '1300000', respectively.
---
 .../bindings/regulator/richtek,rt5739.yaml         | 72 ++++++++++++++++++++++
 1 file changed, 72 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/regulator/richtek,rt5739.yaml

diff --git a/Documentation/devicetree/bindings/regulator/richtek,rt5739.yaml b/Documentation/devicetree/bindings/regulator/richtek,rt5739.yaml
new file mode 100644
index 00000000..358297d
--- /dev/null
+++ b/Documentation/devicetree/bindings/regulator/richtek,rt5739.yaml
@@ -0,0 +1,72 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/regulator/richtek,rt5739.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Richtek RT5739 Step-Down Buck Converter
+
+maintainers:
+  - ChiYuan Huang <cy_huang@richtek.com>
+
+description: |
+  The RT5739 is a step-down switching buck converter that can deliver the
+  programmable output voltage from 300mV to 1300mV with wide input voltage
+  supply of 2.5V to 5.5V. It can provide up to 3.5A continuous current
+  capability at over 80% high efficiency.
+
+allOf:
+  - $ref: regulator.yaml#
+
+properties:
+  compatible:
+    enum:
+      - richtek,rt5739
+
+  reg:
+    maxItems: 1
+
+  enable-gpios:
+    maxItems: 1
+
+  richtek,vsel-active-high:
+    description: |
+      If property is present, use the 'VSEL1' register group for buck control.
+      Else, use the 'VSEL0' register group. This depends on external hardware
+      'VSEL' pin connection.
+    type: boolean
+
+  regulator-allowed-modes:
+    description: |
+      buck allowed operating mode
+        0: Auto PFM/PWM mode
+        1: Forced PWM mode
+    items:
+      enum: [0, 1]
+
+required:
+  - compatible
+  - reg
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+
+    i2c {
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      regulator@50 {
+        compatible = "richtek,rt5739";
+        reg = <0x50>;
+        enable-gpios = <&gpio26 1 GPIO_ACTIVE_HIGH>;
+        richtek,vsel-active-high;
+        regulator-name = "richtek,rt5739-buck";
+        regulator-min-microvolt = <300000>;
+        regulator-max-microvolt = <1300000>;
+        regulator-allowed-modes = <0 1>;
+        regulator-boot-on;
+      };
+    };
-- 
2.7.4

