Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE766688E5B
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 05:01:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232301AbjBCEBw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 23:01:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232340AbjBCEBr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 23:01:47 -0500
Received: from n169-114.mail.139.com (n169-114.mail.139.com [120.232.169.114])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E5706A30E;
        Thu,  2 Feb 2023 20:01:36 -0800 (PST)
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM:                                                                                        
X-RM-SPAM-FLAG: 00000000
Received: from localhost.localdomain (unknown[183.194.156.72])
        by rmsmtp-lg-appmail-43-12057 (RichMail) with SMTP id 2f1963dc8710dba-5c12d;
        Fri, 03 Feb 2023 12:01:24 +0800 (CST)
X-RM-TRANSID: 2f1963dc8710dba-5c12d
From:   Shenghao Ding <13916275206@139.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        broonie@kernel.org, lgirdwood@gmail.com
Cc:     kevin-lu@ti.com, shenghao-ding@ti.com, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shenghao Ding <13916275206@139.com>
Subject: [PATCH v5] ASoC: dt-bindings: Add tas2781 amplifier
Date:   Fri,  3 Feb 2023 12:01:15 +0800
Message-Id: <20230203040115.27321-1-13916275206@139.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,FROM_LOCAL_DIGITS,
        FROM_LOCAL_HEX,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Create tas2781.yaml for tas2781 driver.

Signed-off-by: Shenghao Ding <13916275206@139.com>

---
Changes in v5:
 - Drop the full stop in the Subject.
 - Drop the reset-gpios reference to gpio.txt.
 - Add Changelog.
 Changes to be committed:
	new file:   Documentation/devicetree/bindings/sound/ti,tas2781.yaml
---
 .../devicetree/bindings/sound/ti,tas2781.yaml | 87 +++++++++++++++++++
 1 file changed, 87 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/ti,tas2781.yaml

diff --git a/Documentation/devicetree/bindings/sound/ti,tas2781.yaml b/Documentation/devicetree/bindings/sound/ti,tas2781.yaml
new file mode 100644
index 000000000000..8af44792a904
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/ti,tas2781.yaml
@@ -0,0 +1,87 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+# Copyright (C) 2022 - 2023 Texas Instruments Incorporated
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/ti,tas2781.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Texas Instruments TAS2781 SmartAMP
+
+maintainers:
+  - Shenghao Ding <shenghao-ding@ti.com>
+  - Kevin Lu <kevin-lu@ti.com>
+
+description: |
+  The TAS2781 is a mono, digital input Class-D audio amplifier
+  optimized for efficiently driving high peak power into small
+  loudspeakers. Integrated an on-chip DSP supports Texas Instruments
+  Smart Amp speaker protection algorithm. The integrated speaker
+  voltage and current sense provides for real time
+  monitoring of loudspeaker behavior.
+
+properties:
+  compatible:
+    enum:
+      - ti,tas2781
+
+  reg:
+    maxItems: 1
+    description: |
+      I2C address of the device can be in range from 0x38 to 0x40.
+
+  reset-gpios:
+    maxItems: 1
+    description: |
+      A GPIO line handling reset of the chip. As the line is active high,
+      it should be marked GPIO_ACTIVE_HIGH.
+
+  interrupts:
+    maxItems: 1
+
+  ti,audio-slots:
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+    minItems: 1
+    maxItems: 4
+    description: |
+      I2c address of the device for different audio slots,
+      useless in mono case.
+
+  ti,broadcast-addr:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: |
+      Generic i2c address for all the tas2781 devices in
+      purpose of I2C broadcast during the multi-device
+      writes, useless in mono case.
+
+  '#sound-dai-cells':
+    const: 1
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+   #include <dt-bindings/gpio/gpio.h>
+   i2c {
+     /* example with quad support, such as tablet or pad device */
+     #address-cells = <1>;
+     #size-cells = <0>;
+     quad: codec@38 {
+       compatible = "ti,tas2781";
+       reg = <0x38>;
+       #sound-dai-cells = <1>;
+       reset-gpios = < &gpio1 10 GPIO_ACTIVE_HIGH >;
+       interrupt-parent = <&gpio1>;
+       interrupts = <15>;
+       ti,audio-slots = < 0x38 /* topleft-channel */
+                          0x39 /* topright-channel */
+                          0x3a /* bottomleft-channel */
+                          0x3b /* bottomright-channel */
+                        >;
+       ti,broadcast-addr = <0x40>;
+     };
+   };
+...
-- 
2.34.1


