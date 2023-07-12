Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F36F774FE6B
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 06:43:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231689AbjGLEnx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 00:43:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229843AbjGLEns (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 00:43:48 -0400
X-Greylist: delayed 206 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 11 Jul 2023 21:43:45 PDT
Received: from n169-114.mail.139.com (n169-114.mail.139.com [120.232.169.114])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DB911731;
        Tue, 11 Jul 2023 21:43:44 -0700 (PDT)
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM:                                                                                        
X-RM-SPAM-FLAG: 00000000
Received: from u22.. (unknown[14.26.80.93])
        by rmsmtp-lg-appmail-43-12057 (RichMail) with SMTP id 2f1964ae2ea70d1-e0300;
        Wed, 12 Jul 2023 12:40:11 +0800 (CST)
X-RM-TRANSID: 2f1964ae2ea70d1-e0300
From:   Kevin Lu <luminlong@139.com>
To:     broonie@kernel.org, lgirdwood@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        tiwai@suse.com
Cc:     kevin-lu@ti.com, shenghao-ding@ti.com, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kevin Lu <luminlong@139.com>
Subject: [PATCH v1] ASoC: dt-bindings: Add tas2505 audio amplifier
Date:   Wed, 12 Jul 2023 12:40:06 +0800
Message-Id: <20230712044006.48456-1-luminlong@139.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,FREEMAIL_FROM,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Create tas2505.yaml for tas2505.

Signed-off-by: Kevin Lu <luminlong@139.com>
---
 .../devicetree/bindings/sound/tas2505.yaml    | 72 +++++++++++++++++++
 1 file changed, 72 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/tas2505.yaml

diff --git a/Documentation/devicetree/bindings/sound/tas2505.yaml b/Documentation/devicetree/bindings/sound/tas2505.yaml
new file mode 100644
index 0000000..6cc3fe4
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/tas2505.yaml
@@ -0,0 +1,72 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+# Copyright (C) 2019 Texas Instruments Incorporated
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/sound/tas2505.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+
+title: Texas Instruments TAS2505 Mono Audio Amplifier
+
+maintainers:
+  - Kevin Lu <kevin-lu@ti.com>
+
+description: |
+  The TAS2505 is a mono Class-D speaker amp that supports both Digital
+  and Analog inputs. The device is ideal for automotive instrument cluster,
+  emergency call (eCall), and telematics applications. Direct I2S input
+  removes the need for an external DAC in the audio signal path.
+  An on-chip PLL provides the high speed clock needed by the DSP.
+  The volume level is register controlled.
+
+  Specifications about the audio amplifier can be found at:
+    https://www.ti.com/lit/gpn/tas2505
+
+allOf:
+  - $ref: dai-common.yaml#
+
+properties:
+  compatible:
+    enum:
+      - ti,tas2505
+
+  reg:
+    maxItems: 1
+    description: |
+       I2C address of the device can be set to 0x18.
+
+  reset-gpios:
+    maxItems: 1
+    description: GPIO used to reset the device.
+
+  clock-source:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: Sets TDM clock sourse.
+    enum:
+      - 0 # Select MLCK
+      - 1 # Select BLCK
+
+  '#sound-dai-cells':
+    # The codec has a single DAI, the #sound-dai-cells=<1>; case is left in for backward
+    # compatibility but is deprecated.
+    enum: [0, 1]
+
+required:
+  - compatible
+  - reg
+
+unevaluatedProperties: false
+
+examples:
+  - |
+   #include <dt-bindings/gpio/gpio.h>
+   i2c {
+     #address-cells = <1>;
+     #size-cells = <0>;
+     codec: codec@18 {
+       compatible = "ti,tas2505";
+       reg = <0x18>;
+       #sound-dai-cells = <0>;
+       reset-gpios = <&gpio4 21 GPIO_ACTIVE_LOW>;
+       clock-source = <0>;
+     };
+   };
-- 
2.34.1


