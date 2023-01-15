Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75FC066B0ED
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Jan 2023 13:19:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231328AbjAOMTJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Jan 2023 07:19:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231229AbjAOMTG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Jan 2023 07:19:06 -0500
Received: from n169-111.mail.139.com (n169-111.mail.139.com [120.232.169.111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BAC7EC6B;
        Sun, 15 Jan 2023 04:19:01 -0800 (PST)
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM:                                                                                        
X-RM-SPAM-FLAG: 00000005
Received: from lml-VirtualBox.. (unknown[183.14.134.10])
        by rmsmtp-lg-appmail-13-12002 (RichMail) with SMTP id 2ee263c3ee9ef57-7c0a4;
        Sun, 15 Jan 2023 20:16:31 +0800 (CST)
X-RM-TRANSID: 2ee263c3ee9ef57-7c0a4
From:   Kevin Lu <luminlong@139.com>
To:     lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, shenghao-ding@ti.com,
        kevin-lu@ti.com, navada@ti.com, peeyush@ti.com,
        Kevin Lu <luminlong@139.com>
Subject: [PATCH v1] Asoc: dt_bindings: Add tas2781 yaml
Date:   Sun, 15 Jan 2023 20:16:29 +0800
Message-Id: <20230115121629.2420-1-luminlong@139.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,FREEMAIL_FROM,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Complete the DTS for tas2781

Signed-off-by: Kevin Lu <luminlong@139.com>
---
 .../devicetree/bindings/sound/ti,tas2781.yaml | 122 ++++++++++++++++++
 1 file changed, 122 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/ti,tas2781.yaml

diff --git a/Documentation/devicetree/bindings/sound/ti,tas2781.yaml b/Documentation/devicetree/bindings/sound/ti,tas2781.yaml
new file mode 100644
index 0000000..7d73f46
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/ti,tas2781.yaml
@@ -0,0 +1,122 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+# Copyright (C) 2022 Texas Instruments Incorporated
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/ti,tas2781.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Texas Instruments TAS2781 Smart PA
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
+  ti,audio-slots:
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+    minItems: 1
+    maxItems: 4
+    description: |
+      This item is used to store the i2c address of the device
+      for deifferent audio slots. It is not required for Mono case.
+
+  ti,global-addr:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: |
+      This item is used to store the generic i2c address of
+      all the tas2781 devices for I2C broadcast during the multi-device
+      writes, useless in mono case.
+
+  ti,reset-gpios:
+    minItems: 1
+    maxItems: 4
+    description: GPIO specifier for the reset pin.
+
+  ti,irq-gpio:
+    maxItems: 1
+    description: GPIO used to interrupts the device.
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
+     /* example with mono support */
+     #address-cells = <1>;
+     #size-cells = <0>;
+     mono: codec@38 {
+       compatible = "ti,tas2781";
+       reg = <0x38>;
+       #sound-dai-cells = <1>;
+       ti,reset-gpios = <&gpio1 10 GPIO_ACTIVE_HIGH>;
+       ti,irq-gpio = <&gpio1 15 0>;
+     };
+   };
+  - |
+   #include <dt-bindings/gpio/gpio.h>
+   i2c {
+     /* Stereo without irq-gpio and global-addr */
+     #address-cells = <1>;
+     #size-cells = <0>;
+     stereo: codec@38 {
+       compatible = "ti,tas2781";
+       reg = <0x38>;
+       #sound-dai-cells = <1>;
+       ti,audio-slots = < 0x38 /* left-channel */
+                          0x39 /* right-channel */
+                        >;
+       ti,reset-gpios = < &gpio1 10 GPIO_ACTIVE_HIGH
+                          &gpio1 11 GPIO_ACTIVE_HIGH
+                        >;
+     };
+   };
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
+       ti,audio-slots = < 0x38 /* topleft-channel */
+                          0x39 /* topright-channel */
+                          0x3a /* bottomleft-channel */
+                          0x3b /* bottomright-channel */
+                        >;
+       ti,global-addr = <0x40>;
+       ti,reset-gpios = < &gpio1 10 GPIO_ACTIVE_HIGH
+                          &gpio1 11 GPIO_ACTIVE_HIGH
+                          &gpio1 12 GPIO_ACTIVE_HIGH
+                          &gpio1 13 GPIO_ACTIVE_HIGH
+                        >;
+       ti,irq-gpio = <&gpio1 15 0>;
+     };
+   };
+...
-- 
2.34.1


