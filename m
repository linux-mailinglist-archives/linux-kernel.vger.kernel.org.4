Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 408F761DF3B
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Nov 2022 23:58:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230022AbiKEW6Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Nov 2022 18:58:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbiKEW6O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Nov 2022 18:58:14 -0400
Received: from aposti.net (aposti.net [89.234.176.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E907BCBF;
        Sat,  5 Nov 2022 15:58:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1667689089; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:references; bh=g/Mrmepn0j9F08KmY8f23q6UHnOyEjvzRWFLMGBS8oA=;
        b=w+GP04LrDof0eGDLZxkzu+HKmKc6LFLRaCS2z2k1h6apVLgBQHhGD+86cGThg/jg3dt68D
        qz2zGXpVPQ+daqoxwNRZN6y6I+vBD9c01Cg++K8Q5p5U7rziPDSzEMM/upRKRPK9YjhERL
        XN4xgPJcdjuBhylzLTU/uXYpr0Lq2mA=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        list@opendingux.net, Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH v2] dt-bindings: Convert active-semi PMIC docs to YAML schemas
Date:   Sat,  5 Nov 2022 22:58:03 +0000
Message-Id: <20221105225803.39197-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Create YAML bindings for the Active-semi PMICs and remove the old text
files.

The bindings aren't perfect, for instance I couldn't find good
descriptions for the vendor properties in the "charger" node of the
ACT8945A because I am not familiar with the hardware and these
properties were not documented anywhere.

The YAML schemas are a bit different than what is described in the old
text files, because these were sometimes wrong or had missing
information. This is the case for the ACT8600 documentation, which
specified the valid node names for the regulators, while the driver was
expecting different names. This led to the current situation where we
have two different boards using different names for the regulators:
- arch/mips/boot/dts/ingenic/ci20.dts uses the names documented in the
  text file,
- arch/mips/boot/dts/ingenic/gcw0.dts uses the names that the driver
  expects.
In theory, the driver should be fixed to follow the documentation, and
accept both naming schemes. In practice though, when the PMIC node was
added to the ci20.dts board file, the names were already wrong in
regards to what the driver expected, so it never really worked
correctly and wasn't tested properly. Furthermore, in that board the
consumers of the regulators aren't working for various other reasons
(invalid GPIOs, etc.).

For that reason, for the ACT8600 bindings I decided to only use the node
names that the driver expects (and that gcw0.dts uses), instead of
accepting both old and new names. A follow-up patch will update the CI20
board to use the new regulator names.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---

Notes:
    v2:
    - Avoid | character in descriptions that can be single-line
    - Remove unevaluatedProperties when additionalProperties is also present
    - Remove useless inner parentheses in regular expressions
    - Rename I2C nodes to just... i2c
    - Remove node handles
    
    Note:
    I set Liam Girdwood and Mark Brown as the maintainers by default, since
    it doesn't appear that anybody is managing the Active-semi drivers, but
    if anybody steps up I can update it.

 .../bindings/regulator/act8865-regulator.txt  | 117 --------
 .../bindings/regulator/act8945a-regulator.txt | 113 --------
 .../regulator/active-semi,act8600.yaml        | 141 ++++++++++
 .../regulator/active-semi,act8846.yaml        | 207 ++++++++++++++
 .../regulator/active-semi,act8865.yaml        | 162 +++++++++++
 .../regulator/active-semi,act8945a.yaml       | 261 ++++++++++++++++++
 6 files changed, 771 insertions(+), 230 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/regulator/act8865-regulator.txt
 delete mode 100644 Documentation/devicetree/bindings/regulator/act8945a-regulator.txt
 create mode 100644 Documentation/devicetree/bindings/regulator/active-semi,act8600.yaml
 create mode 100644 Documentation/devicetree/bindings/regulator/active-semi,act8846.yaml
 create mode 100644 Documentation/devicetree/bindings/regulator/active-semi,act8865.yaml
 create mode 100644 Documentation/devicetree/bindings/regulator/active-semi,act8945a.yaml

diff --git a/Documentation/devicetree/bindings/regulator/act8865-regulator.txt b/Documentation/devicetree/bindings/regulator/act8865-regulator.txt
deleted file mode 100644
index b9f58e480349..000000000000
--- a/Documentation/devicetree/bindings/regulator/act8865-regulator.txt
+++ /dev/null
@@ -1,117 +0,0 @@
-ACT88xx regulators
--------------------
-
-Required properties:
-- compatible: "active-semi,act8846" or "active-semi,act8865" or "active-semi,act8600"
-- reg: I2C slave address
-
-Optional properties:
-- system-power-controller: Telling whether or not this pmic is controlling
-  the system power. See Documentation/devicetree/bindings/power/power-controller.txt .
-- active-semi,vsel-high: Indicates the VSEL pin is high.
-  If this property is missing, assume the VSEL pin is low(0).
-
-Optional input supply properties:
-- for act8600:
-  - vp1-supply: The input supply for DCDC_REG1
-  - vp2-supply: The input supply for DCDC_REG2
-  - vp3-supply: The input supply for DCDC_REG3
-  - inl-supply: The input supply for LDO_REG5, LDO_REG6, LDO_REG7 and LDO_REG8
-  SUDCDC_REG4, LDO_REG9 and LDO_REG10 do not have separate supplies.
-- for act8846:
-  - vp1-supply: The input supply for REG1
-  - vp2-supply: The input supply for REG2
-  - vp3-supply: The input supply for REG3
-  - vp4-supply: The input supply for REG4
-  - inl1-supply: The input supply for REG5, REG6 and REG7
-  - inl2-supply: The input supply for REG8 and LDO_REG9
-  - inl3-supply: The input supply for REG10, REG11 and REG12
-- for act8865:
-  - vp1-supply: The input supply for DCDC_REG1
-  - vp2-supply: The input supply for DCDC_REG2
-  - vp3-supply: The input supply for DCDC_REG3
-  - inl45-supply: The input supply for LDO_REG1 and LDO_REG2
-  - inl67-supply: The input supply for LDO_REG3 and LDO_REG4
-
-Any standard regulator properties can be used to configure the single regulator.
-regulator-initial-mode, regulator-allowed-modes and regulator-mode could be specified
-for act8865 using mode values from dt-bindings/regulator/active-semi,8865-regulator.h
-file.
-
-The valid names for regulators are:
-	- for act8846:
-	REG1, REG2, REG3, REG4, REG5, REG6, REG7, REG8, REG9, REG10, REG11, REG12
-	- for act8865:
-	DCDC_REG1, DCDC_REG2, DCDC_REG3, LDO_REG1, LDO_REG2, LDO_REG3, LDO_REG4.
-	- for act8600:
-	DCDC_REG1, DCDC_REG2, DCDC_REG3, SUDCDC_REG4, LDO_REG5, LDO_REG6, LDO_REG7,
-	LDO_REG8, LDO_REG9, LDO_REG10,
-
-Example:
---------
-
-#include <dt-bindings/regulator/active-semi,8865-regulator.h>
-
-		i2c1: i2c@f0018000 {
-			pmic: act8865@5b {
-				compatible = "active-semi,act8865";
-				reg = <0x5b>;
-				active-semi,vsel-high;
-
-				regulators {
-					vcc_1v8_reg: DCDC_REG1 {
-						regulator-name = "VCC_1V8";
-						regulator-min-microvolt = <1800000>;
-						regulator-max-microvolt = <1800000>;
-						regulator-always-on;
-					};
-
-					vcc_1v2_reg: DCDC_REG2 {
-						regulator-name = "VCC_1V2";
-						regulator-min-microvolt = <1100000>;
-						regulator-max-microvolt = <1300000>;
-						regulator-always-on;
-
-						regulator-allowed-modes = <ACT8865_REGULATOR_MODE_FIXED>,
-									  <ACT8865_REGULATOR_MODE_LOWPOWER>;
-						regulator-initial-mode = <ACT8865_REGULATOR_MODE_FIXED>;
-
-						regulator-state-mem {
-							regulator-on-in-suspend;
-							regulator-suspend-min-microvolt = <1150000>;
-							regulator-suspend-max-microvolt = <1150000>;
-							regulator-changeable-in-suspend;
-							regulator-mode = <ACT8865_REGULATOR_MODE_LOWPOWER>;
-						};
-					};
-
-					vcc_3v3_reg: DCDC_REG3 {
-						regulator-name = "VCC_3V3";
-						regulator-min-microvolt = <3300000>;
-						regulator-max-microvolt = <3300000>;
-						regulator-always-on;
-					};
-
-					vddana_reg: LDO_REG1 {
-						regulator-name = "VDDANA";
-						regulator-min-microvolt = <3300000>;
-						regulator-max-microvolt = <3300000>;
-						regulator-always-on;
-
-						regulator-allowed-modes = <ACT8865_REGULATOR_MODE_NORMAL>,
-									  <ACT8865_REGULATOR_MODE_LOWPOWER>;
-						regulator-initial-mode = <ACT8865_REGULATOR_MODE_NORMAL>;
-
-						regulator-state-mem {
-							regulator-off-in-suspend;
-						};
-					};
-
-					vddfuse_reg: LDO_REG2 {
-						regulator-name = "FUSE_2V5";
-						regulator-min-microvolt = <2500000>;
-						regulator-max-microvolt = <2500000>;
-					};
-				};
-			};
-		};
diff --git a/Documentation/devicetree/bindings/regulator/act8945a-regulator.txt b/Documentation/devicetree/bindings/regulator/act8945a-regulator.txt
deleted file mode 100644
index 4017527619ab..000000000000
--- a/Documentation/devicetree/bindings/regulator/act8945a-regulator.txt
+++ /dev/null
@@ -1,113 +0,0 @@
-Device-Tree bindings for regulators of Active-semi ACT8945A Multi-Function Device
-
-Required properties:
- - compatible: "active-semi,act8945a", please refer to ../mfd/act8945a.txt.
-
-Optional properties:
-- active-semi,vsel-high: Indicates if the VSEL pin is set to logic-high.
-  If this property is missing, assume the VSEL pin is set to logic-low.
-
-Optional input supply properties:
-  - vp1-supply: The input supply for REG_DCDC1
-  - vp2-supply: The input supply for REG_DCDC2
-  - vp3-supply: The input supply for REG_DCDC3
-  - inl45-supply: The input supply for REG_LDO1 and REG_LDO2
-  - inl67-supply: The input supply for REG_LDO3 and REG_LDO4
-
-Any standard regulator properties can be used to configure the single regulator.
-regulator-initial-mode, regulator-allowed-modes and regulator-mode could be
-specified using mode values from dt-bindings/regulator/active-semi,8945a-regulator.h
-file.
-
-The valid names for regulators are:
-	REG_DCDC1, REG_DCDC2, REG_DCDC3, REG_LDO1, REG_LDO2, REG_LDO3, REG_LDO4.
-
-Example:
-
-#include <dt-bindings/regulator/active-semi,8945a-regulator.h>
-
-	pmic@5b {
-		compatible = "active-semi,act8945a";
-		reg = <0x5b>;
-
-		active-semi,vsel-high;
-
-		regulators {
-			vdd_1v35_reg: REG_DCDC1 {
-				regulator-name = "VDD_1V35";
-				regulator-min-microvolt = <1350000>;
-				regulator-max-microvolt = <1350000>;
-				regulator-always-on;
-
-				regulator-allowed-modes = <ACT8945A_REGULATOR_MODE_FIXED>,
-							  <ACT8945A_REGULATOR_MODE_LOWPOWER>;
-				regulator-initial-mode = <ACT8945A_REGULATOR_MODE_FIXED>;
-
-				regulator-state-mem {
-					regulator-on-in-suspend;
-					regulator-suspend-min-microvolt=<1400000>;
-					regulator-suspend-max-microvolt=<1400000>;
-					regulator-changeable-in-suspend;
-					regulator-mode=<ACT8945A_REGULATOR_MODE_LOWPOWER>;
-				};
-			};
-
-			vdd_1v2_reg: REG_DCDC2 {
-				regulator-name = "VDD_1V2";
-				regulator-min-microvolt = <1100000>;
-				regulator-max-microvolt = <1300000>;
-				regulator-always-on;
-
-				regulator-allowed-modes = <ACT8945A_REGULATOR_MODE_FIXED>,
-							  <ACT8945A_REGULATOR_MODE_LOWPOWER>;
-				regulator-initial-mode = <ACT8945A_REGULATOR_MODE_FIXED>;
-
-				regulator-state-mem {
-					regulator-off-in-suspend;
-				};
-			};
-
-			vdd_3v3_reg: REG_DCDC3 {
-				regulator-name = "VDD_3V3";
-				regulator-min-microvolt = <3300000>;
-				regulator-max-microvolt = <3300000>;
-				regulator-always-on;
-			};
-
-			vdd_fuse_reg: REG_LDO1 {
-				regulator-name = "VDD_FUSE";
-				regulator-min-microvolt = <2500000>;
-				regulator-max-microvolt = <2500000>;
-				regulator-always-on;
-
-				regulator-allowed-modes = <ACT8945A_REGULATOR_MODE_NORMAL>,
-							  <ACT8945A_REGULATOR_MODE_LOWPOWER>;
-				regulator-initial-mode = <ACT8945A_REGULATOR_MODE_NORMAL>;
-
-				regulator-state-mem {
-					regulator-off-in-suspend;
-				};
-			};
-
-			vdd_3v3_lp_reg: REG_LDO2 {
-				regulator-name = "VDD_3V3_LP";
-				regulator-min-microvolt = <3300000>;
-				regulator-max-microvolt = <3300000>;
-				regulator-always-on;
-			};
-
-			vdd_led_reg: REG_LDO3 {
-				regulator-name = "VDD_LED";
-				regulator-min-microvolt = <3300000>;
-				regulator-max-microvolt = <3300000>;
-				regulator-always-on;
-			};
-
-			vdd_sdhc_1v8_reg: REG_LDO4 {
-				regulator-name = "VDD_SDHC_1V8";
-				regulator-min-microvolt = <1800000>;
-				regulator-max-microvolt = <1800000>;
-				regulator-always-on;
-			};
-		};
-	};
diff --git a/Documentation/devicetree/bindings/regulator/active-semi,act8600.yaml b/Documentation/devicetree/bindings/regulator/active-semi,act8600.yaml
new file mode 100644
index 000000000000..ca0ac316dff2
--- /dev/null
+++ b/Documentation/devicetree/bindings/regulator/active-semi,act8600.yaml
@@ -0,0 +1,141 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/regulator/active-semi,act8600.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Active-semi ACT8600 regulator
+
+maintainers:
+  - Liam Girdwood <lgirdwood@gmail.com>
+  - Mark Brown <broonie@kernel.org>
+
+properties:
+  compatible:
+    const: active-semi,act8600
+
+  reg:
+    description: I2C address
+    maxItems: 1
+
+  system-power-controller:
+    description:
+      Indicates that the ACT8600 is responsible for powering OFF
+      the system.
+    type: boolean
+
+  active-semi,vsel-high:
+    description:
+      Indicates the VSEL pin is high. If this property is missing,
+      the VSEL pin is assumed to be low.
+    type: boolean
+
+  regulators:
+    type: object
+    additionalProperties: false
+
+    properties:
+      DCDC1:
+        type: object
+        $ref: /schemas/regulator/regulator.yaml#
+        unevaluatedProperties: false
+
+        properties:
+          vp1-supply:
+            description: Handle to the VP1 input supply
+
+      DCDC2:
+        type: object
+        $ref: /schemas/regulator/regulator.yaml#
+        unevaluatedProperties: false
+
+        properties:
+          vp2-supply:
+            description: Handle to the VP2 input supply
+
+      DCDC3:
+        type: object
+        $ref: /schemas/regulator/regulator.yaml#
+        unevaluatedProperties: false
+
+        properties:
+          vp3-supply:
+            description: Handle to the VP3 input supply
+
+    patternProperties:
+      "^(SUDCDC_REG4|LDO_REG9|LDO_REG10)$":
+        type: object
+        $ref: /schemas/regulator/regulator.yaml#
+        unevaluatedProperties: false
+
+      "^LDO[5-8]$":
+        type: object
+        $ref: /schemas/regulator/regulator.yaml#
+        unevaluatedProperties: false
+
+        properties:
+          inl-supply:
+            description: Handle to the INL input supply
+
+additionalProperties: false
+
+required:
+  - reg
+  - compatible
+  - regulators
+
+examples:
+  - |
+    i2c {
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      pmic@5a {
+        compatible = "active-semi,act8600";
+        reg = <0x5a>;
+
+        regulators {
+          SUDCDC_REG4 {
+            regulator-min-microvolt = <5300000>;
+            regulator-max-microvolt = <5300000>;
+            inl-supply = <&vcc>;
+          };
+
+          LDO5 {
+            regulator-min-microvolt = <2500000>;
+            regulator-max-microvolt = <2500000>;
+            inl-supply = <&vcc>;
+          };
+
+          LDO6 {
+            regulator-min-microvolt = <3300000>;
+            regulator-max-microvolt = <3300000>;
+            inl-supply = <&vcc>;
+          };
+
+          LDO7 {
+            regulator-min-microvolt = <3300000>;
+            regulator-max-microvolt = <3300000>;
+            inl-supply = <&vcc>;
+          };
+
+          LDO8 {
+            regulator-min-microvolt = <1800000>;
+            regulator-max-microvolt = <1800000>;
+            regulator-always-on;
+            inl-supply = <&vcc>;
+          };
+
+          LDO_REG9 {
+            regulator-min-microvolt = <3300000>;
+            regulator-max-microvolt = <3300000>;
+            regulator-always-on;
+            inl-supply = <&vcc>;
+          };
+
+          LDO_REG10 {
+            inl-supply = <&vcc>;
+          };
+        };
+      };
+    };
diff --git a/Documentation/devicetree/bindings/regulator/active-semi,act8846.yaml b/Documentation/devicetree/bindings/regulator/active-semi,act8846.yaml
new file mode 100644
index 000000000000..2fa2e43ddf01
--- /dev/null
+++ b/Documentation/devicetree/bindings/regulator/active-semi,act8846.yaml
@@ -0,0 +1,207 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/regulator/active-semi,act8846.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Active-semi ACT8846 regulator
+
+maintainers:
+  - Liam Girdwood <lgirdwood@gmail.com>
+  - Mark Brown <broonie@kernel.org>
+
+properties:
+  compatible:
+    const: active-semi,act8846
+
+  reg:
+    description: I2C address
+    maxItems: 1
+
+  system-power-controller:
+    description:
+      Indicates that the ACT8846 is responsible for powering OFF
+      the system.
+    type: boolean
+
+  active-semi,vsel-high:
+    description:
+      Indicates the VSEL pin is high. If this property is missing,
+      the VSEL pin is assumed to be low.
+    type: boolean
+
+  regulators:
+    type: object
+    additionalProperties: false
+
+    properties:
+      REG1:
+        type: object
+        $ref: /schemas/regulator/regulator.yaml#
+        unevaluatedProperties: false
+
+        properties:
+          vp1-supply:
+            description: Handle to the VP1 input supply
+
+      REG2:
+        type: object
+        $ref: /schemas/regulator/regulator.yaml#
+        unevaluatedProperties: false
+
+        properties:
+          vp2-supply:
+            description: Handle to the VP2 input supply
+
+      REG3:
+        type: object
+        $ref: /schemas/regulator/regulator.yaml#
+        unevaluatedProperties: false
+
+        properties:
+          vp3-supply:
+            description: Handle to the VP3 input supply
+
+      REG4:
+        type: object
+        $ref: /schemas/regulator/regulator.yaml#
+        unevaluatedProperties: false
+
+        properties:
+          vp4-supply:
+            description: Handle to the VP4 input supply
+
+    patternProperties:
+      "^REG[5-7]$":
+        type: object
+        $ref: /schemas/regulator/regulator.yaml#
+        unevaluatedProperties: false
+
+        properties:
+          inl1-supply:
+            description: Handle to the INL1 input supply
+
+      "^REG[8-9]$":
+        type: object
+        $ref: /schemas/regulator/regulator.yaml#
+        unevaluatedProperties: false
+
+        properties:
+          inl2-supply:
+            description: Handle to the INL2 input supply
+
+      "^REG1[0-2]$":
+        type: object
+        $ref: /schemas/regulator/regulator.yaml#
+        unevaluatedProperties: false
+
+        properties:
+          inl3-supply:
+            description: Handle to the INL3 input supply
+
+additionalProperties: false
+
+required:
+  - reg
+  - compatible
+  - regulators
+
+examples:
+  - |
+    i2c {
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      pmic@5a {
+        compatible = "active-semi,act8846";
+        reg = <0x5a>;
+
+        system-power-controller;
+
+        regulators {
+          REG1 {
+            regulator-name = "VCC_DDR";
+            regulator-min-microvolt = <1200000>;
+            regulator-max-microvolt = <1200000>;
+            regulator-always-on;
+          };
+
+          REG2 {
+            regulator-name = "VCC_IO";
+            regulator-min-microvolt = <3300000>;
+            regulator-max-microvolt = <3300000>;
+            regulator-always-on;
+          };
+
+          REG3 {
+            regulator-name = "VDD_LOG";
+            regulator-min-microvolt = <1000000>;
+            regulator-max-microvolt = <1000000>;
+            regulator-always-on;
+          };
+
+          REG4 {
+            regulator-name = "VCC_20";
+            regulator-min-microvolt = <2000000>;
+            regulator-max-microvolt = <2000000>;
+            regulator-always-on;
+          };
+
+          REG5 {
+            regulator-name = "VCCIO_SD";
+            regulator-min-microvolt = <3300000>;
+            regulator-max-microvolt = <3300000>;
+            regulator-always-on;
+          };
+
+          REG6 {
+            regulator-name = "VDD10_LCD";
+            regulator-min-microvolt = <1000000>;
+            regulator-max-microvolt = <1000000>;
+            regulator-always-on;
+          };
+
+          REG7 {
+            regulator-name = "VCC_WL";
+            regulator-min-microvolt = <3300000>;
+            regulator-max-microvolt = <3300000>;
+            regulator-always-on;
+          };
+
+          REG8 {
+            regulator-name = "VCCA_33";
+            regulator-min-microvolt = <3300000>;
+            regulator-max-microvolt = <3300000>;
+            regulator-always-on;
+          };
+
+          REG9 {
+            regulator-name = "VCC_LAN";
+            regulator-min-microvolt = <3300000>;
+            regulator-max-microvolt = <3300000>;
+            regulator-always-on;
+          };
+
+          REG10 {
+            regulator-name = "VDD_10";
+            regulator-min-microvolt = <1000000>;
+            regulator-max-microvolt = <1000000>;
+            regulator-always-on;
+          };
+
+          REG11 {
+            regulator-name = "VCC_18";
+            regulator-min-microvolt = <1800000>;
+            regulator-max-microvolt = <1800000>;
+            regulator-always-on;
+          };
+
+          REG12 {
+            regulator-name = "VCC18_LCD";
+            regulator-min-microvolt = <1800000>;
+            regulator-max-microvolt = <1800000>;
+            regulator-always-on;
+          };
+        };
+      };
+    };
diff --git a/Documentation/devicetree/bindings/regulator/active-semi,act8865.yaml b/Documentation/devicetree/bindings/regulator/active-semi,act8865.yaml
new file mode 100644
index 000000000000..cf36ab7c82c4
--- /dev/null
+++ b/Documentation/devicetree/bindings/regulator/active-semi,act8865.yaml
@@ -0,0 +1,162 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/regulator/active-semi,act8865.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Active-semi ACT8865 regulator
+
+maintainers:
+  - Liam Girdwood <lgirdwood@gmail.com>
+  - Mark Brown <broonie@kernel.org>
+
+properties:
+  compatible:
+    const: active-semi,act8865
+
+  reg:
+    description: I2C address
+    maxItems: 1
+
+  system-power-controller:
+    description: |
+      Indicates that the ACT8865 is responsible for powering OFF
+      the system.
+    type: boolean
+
+  active-semi,vsel-high:
+    description: |
+      Indicates the VSEL pin is high. If this property is missing,
+      the VSEL pin is assumed to be low.
+    type: boolean
+
+  regulators:
+    type: object
+    unevaluatedProperties: false
+
+    properties:
+      DCDC_REG1:
+        type: object
+        $ref: /schemas/regulator/regulator.yaml#
+        unevaluatedProperties: false
+
+        properties:
+          vp1-supply:
+            description: Handle to the VP1 input supply
+
+      DCDC_REG2:
+        type: object
+        $ref: /schemas/regulator/regulator.yaml#
+        unevaluatedProperties: false
+
+        properties:
+          vp2-supply:
+            description: Handle to the VP2 input supply
+
+      DCDC_REG3:
+        type: object
+        $ref: /schemas/regulator/regulator.yaml#
+        unevaluatedProperties: false
+
+        properties:
+          vp3-supply:
+            description: Handle to the VP3 input supply
+
+    patternProperties:
+      "^LDO_REG[1-2]$":
+        type: object
+        $ref: /schemas/regulator/regulator.yaml#
+        unevaluatedProperties: false
+
+        properties:
+          inl45-supply:
+            description: Handle to the INL45 input supply
+
+      "^LDO_REG[3-4]$":
+        type: object
+        $ref: /schemas/regulator/regulator.yaml#
+        unevaluatedProperties: false
+
+        properties:
+          inl67-supply:
+            description: Handle to the INL67 input supply
+
+    additionalProperties: false
+
+additionalProperties: false
+
+required:
+  - reg
+  - compatible
+  - regulators
+
+examples:
+  - |
+    #include <dt-bindings/regulator/active-semi,8865-regulator.h>
+
+    i2c1 {
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      pmic: act8865@5b {
+        compatible = "active-semi,act8865";
+        reg = <0x5b>;
+        active-semi,vsel-high;
+
+        regulators {
+          vcc_1v8_reg: DCDC_REG1 {
+            regulator-name = "VCC_1V8";
+            regulator-min-microvolt = <1800000>;
+            regulator-max-microvolt = <1800000>;
+            regulator-always-on;
+          };
+
+          vcc_1v2_reg: DCDC_REG2 {
+            regulator-name = "VCC_1V2";
+            regulator-min-microvolt = <1100000>;
+            regulator-max-microvolt = <1300000>;
+            regulator-always-on;
+
+            regulator-allowed-modes = <ACT8865_REGULATOR_MODE_FIXED>,
+                                      <ACT8865_REGULATOR_MODE_LOWPOWER>;
+            regulator-initial-mode = <ACT8865_REGULATOR_MODE_FIXED>;
+
+            regulator-state-mem {
+              regulator-on-in-suspend;
+              regulator-suspend-min-microvolt = <1150000>;
+              regulator-suspend-max-microvolt = <1150000>;
+              regulator-changeable-in-suspend;
+              regulator-mode = <ACT8865_REGULATOR_MODE_LOWPOWER>;
+            };
+          };
+
+          vcc_3v3_reg: DCDC_REG3 {
+            regulator-name = "VCC_3V3";
+            regulator-min-microvolt = <3300000>;
+            regulator-max-microvolt = <3300000>;
+            regulator-always-on;
+          };
+
+          vddana_reg: LDO_REG1 {
+            regulator-name = "VDDANA";
+            regulator-min-microvolt = <3300000>;
+            regulator-max-microvolt = <3300000>;
+            regulator-always-on;
+
+            regulator-allowed-modes = <ACT8865_REGULATOR_MODE_NORMAL>,
+            <ACT8865_REGULATOR_MODE_LOWPOWER>;
+            regulator-initial-mode = <ACT8865_REGULATOR_MODE_NORMAL>;
+
+            regulator-state-mem {
+              regulator-off-in-suspend;
+            };
+          };
+
+          vddfuse_reg: LDO_REG2 {
+            regulator-name = "FUSE_2V5";
+            regulator-min-microvolt = <2500000>;
+            regulator-max-microvolt = <2500000>;
+          };
+        };
+      };
+    };
diff --git a/Documentation/devicetree/bindings/regulator/active-semi,act8945a.yaml b/Documentation/devicetree/bindings/regulator/active-semi,act8945a.yaml
new file mode 100644
index 000000000000..9c5dcde1d0df
--- /dev/null
+++ b/Documentation/devicetree/bindings/regulator/active-semi,act8945a.yaml
@@ -0,0 +1,261 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/regulator/active-semi,act8945a.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Active-semi ACT8945a regulator
+
+maintainers:
+  - Liam Girdwood <lgirdwood@gmail.com>
+  - Mark Brown <broonie@kernel.org>
+
+properties:
+  compatible:
+    const: active-semi,act8945a
+
+  reg:
+    description: I2C address
+    maxItems: 1
+
+  system-power-controller:
+    description:
+      Indicates that the ACT8945a is responsible for powering OFF
+      the system.
+    type: boolean
+
+  active-semi,vsel-high:
+    description:
+      Indicates the VSEL pin is high. If this property is missing,
+      the VSEL pin is assumed to be low.
+    type: boolean
+
+  regulators:
+    type: object
+    additionalProperties: false
+
+    properties:
+      REG_DCDC1:
+        type: object
+        $ref: /schemas/regulator/regulator.yaml#
+        unevaluatedProperties: false
+
+        properties:
+          vp1-supply:
+            description: Handle to the VP1 input supply
+
+      REG_DCDC2:
+        type: object
+        $ref: /schemas/regulator/regulator.yaml#
+        unevaluatedProperties: false
+
+        properties:
+          vp2-supply:
+            description: Handle to the VP2 input supply
+
+      REG_DCDC3:
+        type: object
+        $ref: /schemas/regulator/regulator.yaml#
+        unevaluatedProperties: false
+
+        properties:
+          vp3-supply:
+            description: Handle to the VP3 input supply
+
+    patternProperties:
+      "^REG_LDO[1-2]$":
+        type: object
+        $ref: /schemas/regulator/regulator.yaml#
+        unevaluatedProperties: false
+
+        properties:
+          inl45-supply:
+            description: Handle to the INL45 input supply
+
+      "^REG_LDO[3-4]$":
+        type: object
+        $ref: /schemas/regulator/regulator.yaml#
+        unevaluatedProperties: false
+
+        properties:
+          inl67-supply:
+            description: Handle to the INL67 input supply
+
+  charger:
+    type: object
+    additionalProperties: false
+
+    properties:
+      compatible:
+        const: active-semi,act8945a-charger
+
+      interrupts:
+        maxItems: 1
+
+      active-semi,chglev-gpios:
+        description: CGHLEV GPIO
+        maxItems: 1
+
+      active-semi,lbo-gpios:
+        description: LBO GPIO
+        maxItems: 1
+
+      active-semi,input-voltage-threshold-microvolt:
+        description: Input voltage threshold
+        maxItems: 1
+
+      active-semi,precondition-timeout:
+        description: Precondition timeout
+        $ref: /schemas/types.yaml#/definitions/uint32
+
+      active-semi,total-timeout:
+        description: Total timeout
+        $ref: /schemas/types.yaml#/definitions/uint32
+
+    required:
+      - compatible
+      - interrupts
+
+additionalProperties: false
+
+required:
+  - reg
+  - compatible
+  - regulators
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+    #include <dt-bindings/mfd/atmel-flexcom.h>
+    #include <dt-bindings/regulator/active-semi,8945a-regulator.h>
+
+    i2c {
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      pmic@5b {
+        compatible = "active-semi,act8945a";
+        reg = <0x5b>;
+        active-semi,vsel-high;
+
+        regulators {
+          REG_DCDC1 {
+            regulator-name = "VDD_1V35";
+            regulator-min-microvolt = <1350000>;
+            regulator-max-microvolt = <1350000>;
+            regulator-allowed-modes = <ACT8945A_REGULATOR_MODE_FIXED>,
+            <ACT8945A_REGULATOR_MODE_LOWPOWER>;
+            regulator-initial-mode = <ACT8945A_REGULATOR_MODE_FIXED>;
+            regulator-always-on;
+
+            regulator-state-mem {
+              regulator-on-in-suspend;
+              regulator-suspend-min-microvolt = <1400000>;
+              regulator-suspend-max-microvolt = <1400000>;
+              regulator-changeable-in-suspend;
+              regulator-mode = <ACT8945A_REGULATOR_MODE_LOWPOWER>;
+            };
+          };
+
+          REG_DCDC2 {
+            regulator-name = "VDD_1V2";
+            regulator-min-microvolt = <1100000>;
+            regulator-max-microvolt = <1300000>;
+            regulator-allowed-modes = <ACT8945A_REGULATOR_MODE_FIXED>,
+            <ACT8945A_REGULATOR_MODE_LOWPOWER>;
+            regulator-initial-mode = <ACT8945A_REGULATOR_MODE_FIXED>;
+            regulator-always-on;
+
+            regulator-state-mem {
+              regulator-off-in-suspend;
+            };
+          };
+
+          REG_DCDC3 {
+            regulator-name = "VDD_3V3";
+            regulator-min-microvolt = <3300000>;
+            regulator-max-microvolt = <3300000>;
+            regulator-allowed-modes = <ACT8945A_REGULATOR_MODE_FIXED>,
+            <ACT8945A_REGULATOR_MODE_LOWPOWER>;
+            regulator-initial-mode = <ACT8945A_REGULATOR_MODE_FIXED>;
+            regulator-always-on;
+
+            regulator-state-mem {
+              regulator-off-in-suspend;
+            };
+          };
+
+          REG_LDO1 {
+            regulator-name = "VDD_FUSE";
+            regulator-min-microvolt = <2500000>;
+            regulator-max-microvolt = <2500000>;
+            regulator-allowed-modes = <ACT8945A_REGULATOR_MODE_NORMAL>,
+            <ACT8945A_REGULATOR_MODE_LOWPOWER>;
+            regulator-initial-mode = <ACT8945A_REGULATOR_MODE_NORMAL>;
+            regulator-always-on;
+
+            regulator-state-mem {
+              regulator-off-in-suspend;
+            };
+          };
+
+          REG_LDO2 {
+            regulator-name = "VDD_3V3_LP";
+            regulator-min-microvolt = <3300000>;
+            regulator-max-microvolt = <3300000>;
+            regulator-allowed-modes = <ACT8945A_REGULATOR_MODE_NORMAL>,
+            <ACT8945A_REGULATOR_MODE_LOWPOWER>;
+            regulator-initial-mode = <ACT8945A_REGULATOR_MODE_NORMAL>;
+            regulator-always-on;
+
+            regulator-state-mem {
+              regulator-off-in-suspend;
+            };
+          };
+
+          REG_LDO3 {
+            regulator-name = "VDD_LED";
+            regulator-min-microvolt = <3300000>;
+            regulator-max-microvolt = <3300000>;
+            regulator-allowed-modes = <ACT8945A_REGULATOR_MODE_NORMAL>,
+            <ACT8945A_REGULATOR_MODE_LOWPOWER>;
+            regulator-initial-mode = <ACT8945A_REGULATOR_MODE_NORMAL>;
+            regulator-always-on;
+
+            regulator-state-mem {
+              regulator-off-in-suspend;
+            };
+          };
+
+          REG_LDO4 {
+            regulator-name = "VDD_SDHC_1V8";
+            regulator-min-microvolt = <1800000>;
+            regulator-max-microvolt = <1800000>;
+            regulator-allowed-modes = <ACT8945A_REGULATOR_MODE_NORMAL>,
+            <ACT8945A_REGULATOR_MODE_LOWPOWER>;
+            regulator-initial-mode = <ACT8945A_REGULATOR_MODE_NORMAL>;
+            regulator-always-on;
+
+            regulator-state-mem {
+              regulator-off-in-suspend;
+            };
+          };
+        };
+
+        charger {
+          compatible = "active-semi,act8945a-charger";
+          pinctrl-names = "default";
+          pinctrl-0 = <&pinctrl_charger_chglev &pinctrl_charger_lbo &pinctrl_charger_irq>;
+          interrupt-parent = <&pioA>;
+          interrupts = <45 IRQ_TYPE_EDGE_RISING>;
+
+          active-semi,chglev-gpios = <&pioA 12 GPIO_ACTIVE_HIGH>;
+          active-semi,lbo-gpios = <&pioA 72 GPIO_ACTIVE_LOW>;
+          active-semi,input-voltage-threshold-microvolt = <6600>;
+          active-semi,precondition-timeout = <40>;
+          active-semi,total-timeout = <3>;
+          status = "okay";
+        };
+      };
+    };
-- 
2.35.1

