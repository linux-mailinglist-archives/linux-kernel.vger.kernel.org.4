Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72F9D5BAD69
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 14:27:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231410AbiIPM1S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 08:27:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229849AbiIPM1L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 08:27:11 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AB34B1B8A;
        Fri, 16 Sep 2022 05:27:08 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id z12so17462321wrp.9;
        Fri, 16 Sep 2022 05:27:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=cOLkxoeEOWsmKRIP09yUrkjvL+lO7P1sPAoxG0Opak0=;
        b=F/33OAmXVFY6GdizxmzDMSvne95cc6qnIZcaAkfLFupBOFbXPD5A2AjjjsPy7w6T28
         5GkxOzFcKnc5RTOmpVgnjRB5Mwx23PaScOmafpIE52OBmlTPnfYPmwwuwx9F99wJTMZX
         q0TIokMpL9pS7b8ekKFGi9b/ybUHLkbjcngOCm6v+QwrcIZx6ykVRuyMcSoibxyUKqOE
         g3uKfQShRBcBjqbVFnBQATVshjzPUXum8PMKZTX0g8WAOhAbgCNZZvJqGL3qQwFmK51H
         aduJ4i8eAFl5z0AymZMcI2d8KvYFwkoMR0tGyyCv9LeZyEcTaiY//56amgnyZCRjRwUL
         N/OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=cOLkxoeEOWsmKRIP09yUrkjvL+lO7P1sPAoxG0Opak0=;
        b=w8GDWyo866uDpkjf6C9Jd2WlOwecUGIalphh6j3U8PPxdoYJInKcU0cqkg0M0V0CMy
         vM7lZx6j93J4FXmpB26Y5odZaxGVm+2CpzMjcA3rfBiVAr8w8qzs5tpZgrSAAczpmSB8
         iG6G8RCqcnauXsv9aLG/XrWIcjpipj9rQdVMx9MH4SpxgHc49jM+/lFxxbbjRxEMTxxW
         GChP45lUVTN6q4sWEOSx/uPSSLuaXFtZEF1D1KMyvrlJQdnhvNPJUX6JIJ30H4KU9UbL
         kk9aBkPehfoxzyJiEoRlfovXlvNrILYijjbGfBQlvoUBBlgbJf3i+ESfvd/hlLuEbnml
         WTEw==
X-Gm-Message-State: ACrzQf0t3vX+lo5CCGRdfT6l0zOcPQ9nFccCM7kKjTSt4ciNt5eJAS2p
        RbEZ1bymRQ+7KszOrLX7eug=
X-Google-Smtp-Source: AMsMyM5XezU9M4L8+g8Uc93Xn3ozTgnRpyFbM7mpK8F51Pqg0neivoLbr+p0V1rkBkop0LNt0xPPkw==
X-Received: by 2002:adf:eb89:0:b0:22a:c7fc:27c8 with SMTP id t9-20020adfeb89000000b0022ac7fc27c8mr2790605wrn.397.1663331226810;
        Fri, 16 Sep 2022 05:27:06 -0700 (PDT)
Received: from prasmi.home ([2a00:23c8:2501:c701:453:ec29:bd55:6b15])
        by smtp.gmail.com with ESMTPSA id g3-20020a5d46c3000000b0022acb7195aesm4788510wrs.33.2022.09.16.05.27.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Sep 2022 05:27:05 -0700 (PDT)
From:   Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        Hans Verkuil <hverkuil@xs4all.nl>, linux-media@vger.kernel.org,
        Tommaso Merciai <tommaso.merciai@amarulasolutions.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH v2] media: dt-bindings: ov5645: Convert OV5645 binding to a schema
Date:   Fri, 16 Sep 2022 13:26:27 +0100
Message-Id: <20220916122627.28461-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Convert the simple OV5645 Device Tree binding to json-schema.

The previous binding marked the below properties as required which was a
driver requirement and not the device requirement so just drop them from
the required list during the conversion.
- clock-names
- clock-frequency
- vdda-supply
- vddd-supply
- vdddo-supply
- enable-gpios
- reset-gpios

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
v1->v2
* Dropped ref to video-interface-devices.yaml#
* Dropped driver specific required items from the list
* Updated commit message
* Dropped clock-lanes and bus-type from the port and example node
* Marked data-lanes as required in port node
---
 .../devicetree/bindings/media/i2c/ov5645.txt  |  54 ---------
 .../bindings/media/i2c/ovti,ov5645.yaml       | 105 ++++++++++++++++++
 2 files changed, 105 insertions(+), 54 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/media/i2c/ov5645.txt
 create mode 100644 Documentation/devicetree/bindings/media/i2c/ovti,ov5645.yaml

diff --git a/Documentation/devicetree/bindings/media/i2c/ov5645.txt b/Documentation/devicetree/bindings/media/i2c/ov5645.txt
deleted file mode 100644
index 72ad992f77be..000000000000
--- a/Documentation/devicetree/bindings/media/i2c/ov5645.txt
+++ /dev/null
@@ -1,54 +0,0 @@
-* Omnivision 1/4-Inch 5Mp CMOS Digital Image Sensor
-
-The Omnivision OV5645 is a 1/4-Inch CMOS active pixel digital image sensor with
-an active array size of 2592H x 1944V. It is programmable through a serial I2C
-interface.
-
-Required Properties:
-- compatible: Value should be "ovti,ov5645".
-- clocks: Reference to the xclk clock.
-- clock-names: Should be "xclk".
-- clock-frequency: Frequency of the xclk clock.
-- enable-gpios: Chip enable GPIO. Polarity is GPIO_ACTIVE_HIGH. This corresponds
-  to the hardware pin PWDNB which is physically active low.
-- reset-gpios: Chip reset GPIO. Polarity is GPIO_ACTIVE_LOW. This corresponds to
-  the hardware pin RESETB.
-- vdddo-supply: Chip digital IO regulator.
-- vdda-supply: Chip analog regulator.
-- vddd-supply: Chip digital core regulator.
-
-The device node must contain one 'port' child node for its digital output
-video port, in accordance with the video interface bindings defined in
-Documentation/devicetree/bindings/media/video-interfaces.txt.
-
-Example:
-
-	&i2c1 {
-		...
-
-		ov5645: ov5645@3c {
-			compatible = "ovti,ov5645";
-			reg = <0x3c>;
-
-			enable-gpios = <&gpio1 6 GPIO_ACTIVE_HIGH>;
-			reset-gpios = <&gpio5 20 GPIO_ACTIVE_LOW>;
-			pinctrl-names = "default";
-			pinctrl-0 = <&camera_rear_default>;
-
-			clocks = <&clks 200>;
-			clock-names = "xclk";
-			clock-frequency = <24000000>;
-
-			vdddo-supply = <&camera_dovdd_1v8>;
-			vdda-supply = <&camera_avdd_2v8>;
-			vddd-supply = <&camera_dvdd_1v2>;
-
-			port {
-				ov5645_ep: endpoint {
-					clock-lanes = <1>;
-					data-lanes = <0 2>;
-					remote-endpoint = <&csi0_ep>;
-				};
-			};
-		};
-	};
diff --git a/Documentation/devicetree/bindings/media/i2c/ovti,ov5645.yaml b/Documentation/devicetree/bindings/media/i2c/ovti,ov5645.yaml
new file mode 100644
index 000000000000..22e685729bcf
--- /dev/null
+++ b/Documentation/devicetree/bindings/media/i2c/ovti,ov5645.yaml
@@ -0,0 +1,105 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/media/i2c/ovti,ov5645.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: OmniVision OV5645 Image Sensor Device Tree Bindings
+
+maintainers:
+  - Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
+
+properties:
+  compatible:
+    const: ovti,ov5645
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    description: XCLK Input Clock
+
+  clock-names:
+    const: xclk
+
+  clock-frequency:
+    description: Frequency of the xclk clock in Hz.
+
+  vdda-supply:
+    description: Analog voltage supply, 2.8 volts
+
+  vddd-supply:
+    description: Digital core voltage supply, 1.5 volts
+
+  vdddo-supply:
+    description: Digital I/O voltage supply, 1.8 volts
+
+  enable-gpios:
+    maxItems: 1
+    description:
+      Reference to the GPIO connected to the PWDNB pin, if any.
+
+  reset-gpios:
+    maxItems: 1
+    description:
+      Reference to the GPIO connected to the RESETB pin, if any.
+
+  port:
+    description: Digital Output Port
+    $ref: /schemas/graph.yaml#/$defs/port-base
+    additionalProperties: false
+
+    properties:
+      endpoint:
+        $ref: /schemas/media/video-interfaces.yaml#
+        unevaluatedProperties: false
+
+        properties:
+          data-lanes:
+            minItems: 1
+            maxItems: 2
+            items:
+              enum: [1, 2]
+
+        required:
+          - data-lanes
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - port
+
+additionalProperties: false
+
+examples:
+  - |
+      #include <dt-bindings/gpio/gpio.h>
+
+      i2c {
+          #address-cells = <1>;
+          #size-cells = <0>;
+
+          camera@3c {
+              compatible = "ovti,ov5645";
+              pinctrl-names = "default";
+              pinctrl-0 = <&pinctrl_ov5645>;
+              reg = <0x3c>;
+              clocks = <&clks 1>;
+              clock-names = "xclk";
+              clock-frequency = <24000000>;
+              vdddo-supply = <&ov5645_vdddo_1v8>; /* 1.8v */
+              vdda-supply = <&ov5645_vdda_2v8>;  /* 2.8v */
+              vddd-supply = <&ov5645_vddd_1v5>;  /* 1.5v */
+              enable-gpios = <&gpio1 19 GPIO_ACTIVE_HIGH>;
+              reset-gpios = <&gpio1 20 GPIO_ACTIVE_LOW>;
+
+              port {
+                  ov5645_ep: endpoint {
+                      remote-endpoint = <&csi0_ep>;
+                      data-lanes = <1 2>;
+                  };
+              };
+          };
+      };
+...
-- 
2.25.1

