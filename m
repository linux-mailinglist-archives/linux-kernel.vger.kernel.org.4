Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82A8C713716
	for <lists+linux-kernel@lfdr.de>; Sun, 28 May 2023 00:37:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229539AbjE0WhV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 May 2023 18:37:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbjE0WhT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 May 2023 18:37:19 -0400
Received: from n169-111.mail.139.com (n169-111.mail.139.com [120.232.169.111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0839B198;
        Sat, 27 May 2023 15:36:41 -0700 (PDT)
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM:                                                                                        
X-RM-SPAM-FLAG: 00000000
Received: from localhost.localdomain (unknown[183.238.123.190])
        by rmsmtp-lg-appmail-18-12021 (RichMail) with SMTP id 2ef5647285f4565-be684;
        Sun, 28 May 2023 06:36:39 +0800 (CST)
X-RM-TRANSID: 2ef5647285f4565-be684
From:   Shenghao Ding <13916275206@139.com>
To:     broonie@kernel.org, devicetree@vger.kernel.org,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        lgirdwood@gmail.com, perex@perex.cz,
        pierre-louis.bossart@linux.intel.com
Cc:     kevin-lu@ti.com, shenghao-ding@ti.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, x1077012@ti.com, peeyush@ti.com,
        navada@ti.com, gentuser@gmail.com, Ryan_Chu@wistron.com,
        Sam_Wu@wistron.com, tiwai@suse.de,
        Shenghao Ding <13916275206@139.com>
Subject: [PATCH v4 6/6] ASoC: dt-bindings: Add tas2781 amplifier
Date:   Sun, 28 May 2023 06:36:32 +0800
Message-Id: <20230527223632.11781-1-13916275206@139.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,FROM_LOCAL_DIGITS,
        FROM_LOCAL_HEX,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Create tas2781.yaml for tas2781 driver.

Signed-off-by: Shenghao Ding <13916275206@139.com>

---
Changes in v4:
 - remove '\t' in the file
 Changes to be committed:
	new file:   Documentation/devicetree/bindings/sound/ti,tas2781.yaml
---
 .../devicetree/bindings/sound/ti,tas2781.yaml | 88 +++++++++++++++++++
 1 file changed, 88 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/ti,tas2781.yaml

diff --git a/Documentation/devicetree/bindings/sound/ti,tas2781.yaml b/Documentation/devicetree/bindings/sound/ti,tas2781.yaml
new file mode 100644
index 000000000000..b3dcd7b18f5d
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/ti,tas2781.yaml
@@ -0,0 +1,88 @@
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
+
+description:
+  The TAS2781 is a mono, digital input Class-D audio amplifier
+  optimized for efficiently driving high peak power into small
+  loudspeakers. Integrated an on-chip DSP supports Texas Instruments
+  Smart Amp speaker protection algorithm. The integrated speaker
+  voltage and current sense provides for real time
+  monitoring of loudspeaker behavior.
+
+allOf:
+  - $ref: dai-common.yaml#
+
+properties:
+  '#address-cells':
+    const: 1
+  '#size-cells':
+    const: 0
+
+  compatible:
+    enum:
+      - ti,tas2781
+
+  reg:
+    description:
+      I2C address, in multiple tas2781s case, all the i2c address
+      aggreate as one Audio Device to support multiple audio slots.
+    maxItems: 4
+    items:
+      minimum: 0x38
+      maximum: 0x3f
+
+  reset-gpios:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  ti,broadcast-addr:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      Generic I2C address for all the tas2781 devices in
+      purpose of I2C broadcast during the multi-device
+      writes, useless in mono case or remove this item to
+      disable broadcast mode.
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
+       reg = < 0x38 /* Audio slot 0 */
+               0x3a /* Audio slot 1 */
+               0x39 /* Audio slot 2 */
+               0x3b /* Audio slot 3 */
+               >;
+       #sound-dai-cells = <1>;
+       reset-gpios = < &gpio1 10 GPIO_ACTIVE_HIGH >;
+       interrupt-parent = <&gpio1>;
+       interrupts = <15>;
+       /* Generic I2C addr among all the tas2781s for i2c data broadcast */
+       ti,broadcast-addr = <0x40>;
+     };
+   };
+...
-- 
2.34.1


