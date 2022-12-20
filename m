Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED1A5652325
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 15:52:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234232AbiLTOwB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 09:52:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229994AbiLTOv0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 09:51:26 -0500
X-Greylist: delayed 405 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 20 Dec 2022 06:51:23 PST
Received: from n169-112.mail.139.com (n169-112.mail.139.com [120.232.169.112])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08DFC1AA2B;
        Tue, 20 Dec 2022 06:51:22 -0800 (PST)
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM:                                                                                        
X-RM-SPAM-FLAG: 00000000
Received: from localhost.localdomain (unknown[61.152.193.32])
        by rmsmtp-lg-appmail-25-12028 (RichMail) with SMTP id 2efc63a1c993073-87152;
        Tue, 20 Dec 2022 22:41:24 +0800 (CST)
X-RM-TRANSID: 2efc63a1c993073-87152
From:   Kevin Lu <luminlong@139.com>
To:     lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, shenghao-ding@ti.com,
        kevin-lu@ti.com, navada@ti.com, peeyush@ti.com,
        Kevin Lu <luminlong@139.com>
Subject: [PATCH] New yaml file: tas2781
Date:   Tue, 20 Dec 2022 22:41:14 +0800
Message-Id: <20221220144114.2137-1-luminlong@139.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,FREEMAIL_FROM,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add DTS discription for tas2781 driver code

Signed-off-by: Kevin Lu <luminlong@139.com>
---
 .../devicetree/bindings/sound/tas2781.yaml    | 90 +++++++++++++++++++
 1 file changed, 90 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/tas2781.yaml

diff --git a/Documentation/devicetree/bindings/sound/tas2781.yaml b/Documentation/devicetree/bindings/sound/tas2781.yaml
new file mode 100644
index 000000000..96fa45bf6
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/tas2781.yaml
@@ -0,0 +1,90 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+# Copyright (C) 2022 Texas Instruments Incorporated
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/sound/tas2781.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
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
+      - ti,audev
+    description: |
+        ti,audev will disable the irq of tas2781.
+  reg:
+    maxItems: 1
+    description: |
+       I2C address of the device can be between 0x38 to 0x40.
+
+  reset-gpioN:
+    maxItems: 4
+    description: GPIO used to reset the device.
+
+  ti,topleft-channel:
+    maxItems: 1
+    description: I2C Address for each specific device.
+
+  ti,topright-channel:
+    maxItems: 1
+
+  ti,bottomleft-channel:
+    maxItems: 1
+
+  ti,bottomright-channel:
+    maxItems: 1
+
+  ti,global-address:
+    maxItems: 1
+    description: This item is not mandatory. if the device support gloabel mode, this item should be active.
+
+  ti,irq-gpio:
+    maxItems: 1
+    description: GPIO used to interrupt the device.
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
+   i2c0 {
+     #address-cells = <1>;
+     #size-cells = <0>;
+     codec: codec@38 {
+       compatible = "ti,tas2781";
+       reg = <0x38>;
+       #sound-dai-cells = <1>;
+       ti,topleft-channel = <0x38>;
+       ti,topright-channel = <0x39>;
+       ti,bottomright-channel = <0x3a>;
+       ti,bottomright-channel = <0x3b>;
+       ti,global-address = <0x40>;
+       ti,reset-gpio0 = <&gpio1 10 GPIO_ACTIVE_HIGH>;
+       ti,reset-gpio1 = <&gpio1 11 GPIO_ACTIVE_HIGH>;
+       ti,reset-gpio2 = <&gpio1 12 GPIO_ACTIVE_HIGH>;
+       ti,reset-gpio3 = <&gpio1 13 GPIO_ACTIVE_HIGH>;
+       ti,irq-gpio = <&gpio1 15 0>;
+     };
+   };
+...
-- 
2.17.1


