Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40C8661DAE9
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Nov 2022 15:19:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229837AbiKEOTH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Nov 2022 10:19:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229851AbiKEOSv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Nov 2022 10:18:51 -0400
Received: from mail.z3ntu.xyz (mail.z3ntu.xyz [128.199.32.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07D6FBBD;
        Sat,  5 Nov 2022 07:18:36 -0700 (PDT)
Received: from g550jk.. (unknown [46.183.103.8])
        by mail.z3ntu.xyz (Postfix) with ESMTPSA id 48C9AD0409;
        Sat,  5 Nov 2022 14:18:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=z3ntu.xyz; s=z3ntu;
        t=1667657914; bh=1SgFc7do9FxwPKWcXsHvto6nssiqHLSglAvy8Itz6a8=;
        h=From:To:Cc:Subject:Date;
        b=pmYbjG/hx1B1rKL9yk3VFW6u/4xnu4cyvNIakg6Ss/ZxoTjS3VqjMX2FVT8LNga9z
         RmGropT1C1ix57+gJ6DE7Om1An3PImYgTUXpbBQb5efuQlGs9UjkRkCDynFx940NY7
         fE3viUvYIU3mkTUyCpyrKltn7lPOTS8iEqpzZAmc=
From:   Luca Weiss <luca@z3ntu.xyz>
To:     linux-input@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Luca Weiss <luca@z3ntu.xyz>, Andrew Davis <afd@ti.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3] dt-bindings: input: Convert ti,drv260x to DT schema
Date:   Sat,  5 Nov 2022 15:17:06 +0100
Message-Id: <20221105141707.92652-1-luca@z3ntu.xyz>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FROM_SUSPICIOUS_NTLD,
        FROM_SUSPICIOUS_NTLD_FP,PDS_OTHER_BAD_TLD,RCVD_IN_SBL_CSS,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the drv260x haptics binding to DT schema format.

The only notable change from .txt format is that vbat-supply is not
actually required, so don't make it a required property.

Acked-by: Andrew Davis <afd@ti.com>
Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
---
Changes since v2:
* add default values for vib-*-mv
* add note about 'mode' property
* add enable-gpios, deprecate enable-gpio

 .../devicetree/bindings/input/ti,drv260x.txt  |  50 --------
 .../devicetree/bindings/input/ti,drv260x.yaml | 109 ++++++++++++++++++
 2 files changed, 109 insertions(+), 50 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/input/ti,drv260x.txt
 create mode 100644 Documentation/devicetree/bindings/input/ti,drv260x.yaml

diff --git a/Documentation/devicetree/bindings/input/ti,drv260x.txt b/Documentation/devicetree/bindings/input/ti,drv260x.txt
deleted file mode 100644
index 4c5312eaaa85..000000000000
--- a/Documentation/devicetree/bindings/input/ti,drv260x.txt
+++ /dev/null
@@ -1,50 +0,0 @@
-* Texas Instruments - drv260x Haptics driver family
-
-Required properties:
-	- compatible - One of:
-		"ti,drv2604" - DRV2604
-		"ti,drv2605" - DRV2605
-		"ti,drv2605l" - DRV2605L
-	- reg -  I2C slave address
-	- vbat-supply - Required supply regulator
-	- mode - Power up mode of the chip (defined in include/dt-bindings/input/ti-drv260x.h)
-		DRV260X_LRA_MODE - Linear Resonance Actuator mode (Piezoelectric)
-		DRV260X_LRA_NO_CAL_MODE - This is a LRA Mode but there is no calibration
-				sequence during init.  And the device is configured for real
-				time playback mode (RTP mode).
-		DRV260X_ERM_MODE - Eccentric Rotating Mass mode (Rotary vibrator)
-	- library-sel - These are ROM based waveforms pre-programmed into the IC.
-				This should be set to set the library to use at power up.
-				(defined in include/dt-bindings/input/ti-drv260x.h)
-		DRV260X_LIB_EMPTY - Do not use a pre-programmed library
-		DRV260X_ERM_LIB_A - Pre-programmed Library
-		DRV260X_ERM_LIB_B - Pre-programmed Library
-		DRV260X_ERM_LIB_C - Pre-programmed Library
-		DRV260X_ERM_LIB_D - Pre-programmed Library
-		DRV260X_ERM_LIB_E - Pre-programmed Library
-		DRV260X_ERM_LIB_F - Pre-programmed Library
-		DRV260X_LIB_LRA - Pre-programmed LRA Library
-
-Optional properties:
-	- enable-gpio - gpio pin to enable/disable the device.
-	- vib-rated-mv - The rated voltage of the actuator in millivolts.
-			  If this is not set then the value will be defaulted to
-			  3.2 v.
-	- vib-overdrive-mv - The overdrive voltage of the actuator in millivolts.
-			  If this is not set then the value will be defaulted to
-			  3.2 v.
-Example:
-
-haptics: haptics@5a {
-	compatible = "ti,drv2605l";
-	reg = <0x5a>;
-	vbat-supply = <&vbat>;
-	enable-gpio = <&gpio1 28 GPIO_ACTIVE_HIGH>;
-	mode = <DRV260X_LRA_MODE>;
-	library-sel = <DRV260X_LIB_LRA>;
-	vib-rated-mv = <3200>;
-	vib-overdrive-mv = <3200>;
-}
-
-For more product information please see the link below:
-http://www.ti.com/product/drv2605
diff --git a/Documentation/devicetree/bindings/input/ti,drv260x.yaml b/Documentation/devicetree/bindings/input/ti,drv260x.yaml
new file mode 100644
index 000000000000..63230977043e
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/ti,drv260x.yaml
@@ -0,0 +1,109 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/input/ti,drv260x.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Texas Instruments - drv260x Haptics driver family
+
+maintainers:
+  - Andrew Davis <afd@ti.com>
+
+properties:
+  compatible:
+    enum:
+      - ti,drv2604
+      - ti,drv2605
+      - ti,drv2605l
+
+  reg:
+    maxItems: 1
+
+  vbat-supply:
+    description: Power supply to the haptic motor
+
+  # TODO: Deprecate 'mode' in favor of differently named property
+  mode:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: |
+      Power up mode of the chip
+      (defined in include/dt-bindings/input/ti-drv260x.h)
+
+      DRV260X_LRA_MODE
+        Linear Resonance Actuator mode (Piezoelectric)
+
+      DRV260X_LRA_NO_CAL_MODE
+        This is a LRA Mode but there is no calibration sequence during init.
+        And the device is configured for real time playback mode (RTP mode).
+
+      DRV260X_ERM_MODE
+        Eccentric Rotating Mass mode (Rotary vibrator)
+    enum: [ 0, 1, 2 ]
+
+  library-sel:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: |
+      These are ROM based waveforms pre-programmed into the IC.
+      This should be set to set the library to use at power up.
+      (defined in include/dt-bindings/input/ti-drv260x.h)
+
+      DRV260X_LIB_EMPTY - Do not use a pre-programmed library
+      DRV260X_ERM_LIB_A - Pre-programmed Library
+      DRV260X_ERM_LIB_B - Pre-programmed Library
+      DRV260X_ERM_LIB_C - Pre-programmed Library
+      DRV260X_ERM_LIB_D - Pre-programmed Library
+      DRV260X_ERM_LIB_E - Pre-programmed Library
+      DRV260X_ERM_LIB_F - Pre-programmed Library
+      DRV260X_LIB_LRA - Pre-programmed LRA Library
+    enum: [ 0, 1, 2, 3, 4, 5, 6, 7 ]
+
+  enable-gpio:
+    maxItems: 1
+    deprecated: true
+
+  enable-gpios:
+    maxItems: 1
+
+  vib-rated-mv:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: |
+      The rated voltage of the actuator in millivolts.
+      If this is not set then the value will be defaulted to 3200 mV.
+    default: 3200
+
+  vib-overdrive-mv:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: |
+      The overdrive voltage of the actuator in millivolts.
+      If this is not set then the value will be defaulted to 3200 mV.
+    default: 3200
+
+required:
+  - compatible
+  - reg
+  - enable-gpio
+  - mode
+  - library-sel
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+    #include <dt-bindings/input/ti-drv260x.h>
+
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        haptics@5a {
+            compatible = "ti,drv2605l";
+            reg = <0x5a>;
+            vbat-supply = <&vbat>;
+            enable-gpio = <&gpio1 28 GPIO_ACTIVE_HIGH>;
+            mode = <DRV260X_LRA_MODE>;
+            library-sel = <DRV260X_LIB_LRA>;
+            vib-rated-mv = <3200>;
+            vib-overdrive-mv = <3200>;
+        };
+    };
-- 
2.38.1

