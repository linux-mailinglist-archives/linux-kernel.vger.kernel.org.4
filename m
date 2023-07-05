Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA0EE748802
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 17:27:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233193AbjGEP1b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 11:27:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232674AbjGEP11 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 11:27:27 -0400
Received: from mg.richtek.com (mg.richtek.com [220.130.44.152])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 772281709
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jul 2023 08:27:24 -0700 (PDT)
X-MailGates: (SIP:2,PASS,NONE)(compute_score:DELIVER,40,3)
Received: from 192.168.10.47
        by mg.richtek.com with MailGates ESMTP Server V6.0(297520:0:AUTH_RELAY)
        (envelope-from <alina_yu@richtek.com>); Wed, 05 Jul 2023 23:27:09 +0800 (CST)
Received: from ex4.rt.l (192.168.10.47) by ex4.rt.l (192.168.10.47) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.25; Wed, 5 Jul
 2023 23:27:09 +0800
Received: from linuxcarl2.richtek.com (192.168.10.154) by ex4.rt.l
 (192.168.10.45) with Microsoft SMTP Server id 15.2.1118.25 via Frontend
 Transport; Wed, 5 Jul 2023 23:27:09 +0800
From:   <alina_yu@richtek.com>
To:     <broonie@kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <alina_yu@richtek.com>, <cy_huang@richtek.com>
Subject: [PATCH v2 1/2] regulator: dt-bindings: rtq2208: Add Richtek RTQ2208 SubPMIC
Date:   Wed, 5 Jul 2023 23:27:08 +0800
Message-ID: <341af3996c430549243365bb8204d33a15a482be.1688569987.git.alina_yu@richtek.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <cover.1688569987.git.alina_yu@richtek.com>
References: <cover.1688569987.git.alina_yu@richtek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: alinayu <alina_yu@richtek.com>

Add bindings for Richtek RTQ2208 IC controlled SubPMIC

Signed-off-by: alinayu <alina_yu@richtek.com>
---
 .../regulator/richtek,rtq2208-regulator.yaml       | 228 +++++++++++++++++++++
 1 file changed, 228 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/regulator/richtek,rtq2208-regulator.yaml

diff --git a/Documentation/devicetree/bindings/regulator/richtek,rtq2208-regulator.yaml b/Documentation/devicetree/bindings/regulator/richtek,rtq2208-regulator.yaml
new file mode 100644
index 0000000..2a060ce
--- /dev/null
+++ b/Documentation/devicetree/bindings/regulator/richtek,rtq2208-regulator.yaml
@@ -0,0 +1,228 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/regulator/richtek,rtq2208-regulator.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Richtek RTQ2208 SubPMIC Regulator
+
+maintainers:
+  - Alina Yu <alina_yu@richtek.com>
+
+description: |
+  The RTQ2208 is a highly integrated multi-configurable power converter that
+  offers functional safety embedded dual multi-configurable synchronous buck
+  converters and two LDOs.
+
+  Bucks support "regulator-allowed-modes" and "regulator-mode". The former defines the permitted
+  swiching operation in normal mode; the latter defines the operation in suspend to RAM mode.
+
+  No matter the RTQ2208 is configured in normal or suspend to RAM mode, there are two switching
+  operation modes for all buck rails, automic power saving mode (Auto mode) and forced continious
+  conduction mode (FCCM).
+
+  The meaning of modes is defined in the datasheet which is avaliabe in below link
+  and their meaning is::
+    0 - Auto mode for power saving, which reducing the switching frequency at light load condition
+    to maintain high frequency.
+    1 - FCCM to meet the strict voltage regulation accuracy, which keeping constant switching frequency.
+
+  Datasheet will be available soon at
+  https://www.richtek.com/assets/Products
+
+  The standard "regulator-mode" property can only be used for bucks that
+  changing their mode to suspend to RAM mode. Also, it only takes effect if the
+  regulator has been enabled for the given suspend state using "regulator-on-in-suspend".
+
+properties:
+  compatible:
+    enum:
+      - richtek,rtq2208
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+    
+  richtek,mtp-sel:
+    description: |
+      Buck and ldo vout selection is based on this value.
+      There are two independently programmable voltage settings named as mtp-sel0 and
+      mtp-sel1 for RTQ2208 bucks vout voltage. 0 which means this property isn't present
+      and 1 which means this property is present corresponds to different adjustable registers.
+
+      0 - DVS0 registers to adjust buck vout and BUCK_[A-H]_EN_NR_MTP_SEL0 register to en/disable vout.
+      1 - DVS1 registers to adjust buck vout and BUCK_[A-H]_EN_NR_MTP_SEL1 register to en/disable vout.
+
+    type: boolean
+
+  regulators:
+    type: object
+
+    patternProperties:
+      "^buck_[A-H]$":
+        type: object
+        $ref: regulator.yaml#
+        description: |
+          regulator description for buck[A-H].
+
+        properties:
+          regulator-compatible:
+            pattern: "^BUCK_[A-H]$"
+
+          regulator-allowed-modes:
+            description: |
+              describe buck permitted modes.
+
+      "^ldo[1-2]$":
+        type: object
+        $ref: regulator.yaml#
+        description: |
+          regulator description for ldo[1-2].
+
+        properties:
+          regulator-compatible:
+            pattern: "^LDO[1-2]$"
+
+          richtek,fixed_uV:
+            $ref: "/schemas/types.yaml#/definitions/uint32"
+            enum: [ 900000, 1200000, 1800000, 3300000 ]
+            description: |
+              the fixed voltage in microvolt which is descided at the factory.
+
+      regulator-state-(mem):
+        type: object
+        additionalProperties: true
+        properties:
+          regulator-on-in-suspend: false
+          regulator-mode: false
+
+required:
+  - compatible
+  - reg
+  - regulators
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    i2c {
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      rtq2208@10 {
+        compatible = "richtek,rtq2208";
+        reg = <0x10>;
+        interrupts-extended = <&gpio26 0 IRQ_TYPE_LEVEL_LOW>;
+        richtek,mtp-sel;
+
+        regulators {
+         BUCK_A:buck_A {
+            regulator-compatible = "BUCK_A";
+            regulator-min-microvolt = <400000>;
+            regulator-max-microvolt = <2050000>;
+            regulator-allowed-modes = <0 1>;
+            regulator-always-on;
+            regulator-state-mem {
+              regulator-on-in-suspend;
+              regulator-mode = <1>;
+            };
+          };
+         BUCK_B:buck_B {
+            regulator-compatible = "BUCK_B";
+            regulator-min-microvolt = <400000>;
+            regulator-max-microvolt = <2050000>;
+            regulator-allowed-modes = <0 1>;
+            regulator-always-on;
+            regulator-state-mem {
+              regulator-on-in-suspend;
+              regulator-mode = <1>;
+            };
+          };
+         BUCK_C:buck_C {
+            regulator-compatible = "BUCK_C";
+            regulator-min-microvolt = <400000>;
+            regulator-max-microvolt = <2050000>;
+            regulator-allowed-modes = <0 1>;
+            regulator-always-on;
+            regulator-state-mem {
+              regulator-on-in-suspend;
+              regulator-mode = <1>;
+            };
+          };
+         BUCK_D:buck_D {
+            regulator-compatible = "BUCK_D";
+            regulator-min-microvolt = <400000>;
+            regulator-max-microvolt = <2050000>;
+            regulator-allowed-modes = <0 1>;
+            regulator-always-on;
+            regulator-state-mem {
+              regulator-on-in-suspend;
+              regulator-mode = <1>;
+            };
+          };
+         BUCK_E:buck_E {
+            regulator-compatible = "BUCK_E";
+            regulator-min-microvolt = <400000>;
+            regulator-max-microvolt = <2050000>;
+            regulator-allowed-modes = <0 1>;
+            regulator-always-on;
+            regulator-state-mem {
+              regulator-on-in-suspend;
+              regulator-mode = <1>;
+            };
+          };
+         BUCK_F:buck_F {
+            regulator-compatible = "BUCK_F";
+            regulator-min-microvolt = <400000>;
+            regulator-max-microvolt = <2050000>;
+            regulator-allowed-modes = <0 1>;
+            regulator-always-on;
+            regulator-state-mem {
+              regulator-on-in-suspend;
+              regulator-mode = <1>;
+            };
+          };
+         BUCK_G:buck_G {
+            regulator-compatible = "BUCK_G";
+            regulator-min-microvolt = <400000>;
+            regulator-max-microvolt = <2050000>;
+            regulator-allowed-modes = <0 1>;
+            regulator-always-on;
+            regulator-state-mem {
+              regulator-on-in-suspend;
+              regulator-mode = <1>;
+            };
+          };
+         BUCK_H:buck_H {
+            regulator-compatible = "BUCK_H";
+            regulator-min-microvolt = <400000>;
+            regulator-max-microvolt = <2050000>;
+            regulator-allowed-modes = <0 1>;
+            regulator-always-on;
+            regulator-state-mem {
+              regulator-on-in-suspend;
+              regulator-mode = <1>;
+            };
+          };
+         LDO1:ldo1 {
+            regulator-compatible = "LDO1";
+            richtek,fixed_uV = <1200000>;
+            regulator-always-on;
+            regulator-state-mem {
+              regulator-on-in-suspend;
+            };
+          };
+         LDO2:ldo2 {
+            regulator-compatible = "LDO2";
+            regulator-always-on;
+            richtek,fixed_uV = <3300000>;
+            regulator-state-mem {
+              regulator-on-in-suspend;
+            };
+          };
+        };
+      };
+    };
-- 
2.7.4

