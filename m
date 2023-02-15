Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C4BB697405
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 03:01:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232781AbjBOCBX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 21:01:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbjBOCBT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 21:01:19 -0500
Received: from mg.richtek.com (mg.richtek.com [220.130.44.152])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3277423640;
        Tue, 14 Feb 2023 18:01:15 -0800 (PST)
X-MailGates: (flag:4,DYNAMIC,BADHELO,RELAY,NOHOST:PASS)(compute_score:DE
        LIVER,40,3)
Received: from 192.168.10.46
        by mg.richtek.com with MailGates ESMTP Server V5.0(23451:0:AUTH_RELAY)
        (envelope-from <cy_huang@richtek.com>); Wed, 15 Feb 2023 10:00:59 +0800 (CST)
Received: from ex3.rt.l (192.168.10.46) by ex3.rt.l (192.168.10.46) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.20; Wed, 15 Feb
 2023 10:00:58 +0800
Received: from linuxcarl2.richtek.com (192.168.10.154) by ex3.rt.l
 (192.168.10.45) with Microsoft SMTP Server id 15.2.1118.20 via Frontend
 Transport; Wed, 15 Feb 2023 10:00:58 +0800
From:   <cy_huang@richtek.com>
To:     <broonie@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>
CC:     <lgirdwood@gmail.com>, <cy_huang@richtek.com>,
        <u0084500@gmail.com>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
Subject: [PATCH 1/2] dt-bindings: regulator: Add bindings for Richtek RT5739
Date:   Wed, 15 Feb 2023 10:00:56 +0800
Message-ID: <1676426457-1389-2-git-send-email-cy_huang@richtek.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1676426457-1389-1-git-send-email-cy_huang@richtek.com>
References: <1676426457-1389-1-git-send-email-cy_huang@richtek.com>
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
---
 .../bindings/regulator/richtek,rt5739.yaml         | 80 ++++++++++++++++++++++
 1 file changed, 80 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/regulator/richtek,rt5739.yaml

diff --git a/Documentation/devicetree/bindings/regulator/richtek,rt5739.yaml b/Documentation/devicetree/bindings/regulator/richtek,rt5739.yaml
new file mode 100644
index 00000000..7dc4f78
--- /dev/null
+++ b/Documentation/devicetree/bindings/regulator/richtek,rt5739.yaml
@@ -0,0 +1,80 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/regulator/richtek,rt5739.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Richtek RT5739 2.4MHz 3.5A Step-Down Converter
+
+maintainers:
+  - ChiYuan Huang <cy_huang@richtek.com>
+
+description: |
+  The RT5739 is a step-down switching voltage regulator that delivers a
+  digitally programmable output from an input voltage supply of 2.5V to 5.5V.
+  The output voltage is programmed through an I2C interface capable of
+  operating up to 3.4MHz.
+
+  Using a proprietary architecture with synchronous rectification, the RT5739
+  is capable of delivering 3.5A continuously at over 80% efficiency,
+  maintaining that efficiency at load current as low as 10mA. The regulator
+  operates at a normal fixed frequency of 2.4MHz, which reduces the value of
+  the external components. Additional output capacitance can be added to
+  improve regulation during load transients without affecting stability.
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
+      'VSEL' pin connecton.
+    type: boolean
+
+  regulator-allowed-modes:
+    description: |
+      buck allowed operating mode
+        0: Auto PFM/PWM mode
+        1: Forced PWM mode
+    maxItems: 2
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
+        regulator-min-microvolt = <3000000>;
+        regulator-max-microvolt = <13000000>;
+        regulator-allowed-modes = <0 1>;
+        regulator-boot-on;
+      };
+    };
-- 
2.7.4

