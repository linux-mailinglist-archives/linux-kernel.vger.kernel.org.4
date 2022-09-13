Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E4145B7789
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 19:16:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232699AbiIMRPN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 13:15:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232616AbiIMROd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 13:14:33 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6B8FD076B;
        Tue, 13 Sep 2022 09:03:11 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id g3so657008wrq.13;
        Tue, 13 Sep 2022 09:03:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=q9dIspQTU0av/CmaF79qqgUN2bSkSgVAACf4aW4xX6k=;
        b=EZw4GlpBEsKDwY9Vn1y36CdUECm7DCP+AA5gCXuuc7tyjLj7coaS1qpT4DaPI1LUwX
         qH43fimk85v9fIQALrARFtShmT11MjiAa4jmT1ktMvHwgL94r3gvTtUm4xS3mvq7rx7o
         SChbj3QtJRlrrsZdjBOYDxgDjO3Igtdi0VOr0euOP/cY3mUyi4uSgI6yL/YwIT75B6L3
         SG5fM/WvGXsheyULrDYh7RzW3zBtlIdIXJpwxY18BoROFKV6+t3l9yDLQ7xDNzPmPS+M
         1gLYoW52kF01L1PYmZIS1cjZqX2JPAi/+xWeLnuZHuz0y1Kc0IfHjn8qviu84ZLFmOYh
         Joqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=q9dIspQTU0av/CmaF79qqgUN2bSkSgVAACf4aW4xX6k=;
        b=BTf/DQTNPlA2AC51kYw5QZ7YltCDw4aAz5bhxmidubOnbCMwHzBoR0Eh1dvaoy6Qnb
         wyQbCeNbvhvx61CP9MuaF7IZptHlhjqTQbmOwX3NDRdwOqPu1SwUUu3cU9U3Xk9zxX9r
         EiQyNokL6dTUB2Iomu3DoQVjXgLATyt1Uc2c/QBGr5oOLp5J+BEKFKMisD9mQZAtKJH0
         NRdKBZsugago97YJkDWIUfl5Ikxswrzz21V0E8WfoiSgbnppcVHtdkrN1gchl+Z3G7j8
         B2sivuWnr8ZDBRd5a8VIaGHuPosYLd+hQiYHbZrgHwK2tQyKcIdtz/OfKn3E4eAt3qXi
         RTjQ==
X-Gm-Message-State: ACgBeo2emAMM8/BXlJTZEmaifFX918YVobBlrjMHjm1Ws2v85CJiiGhS
        4edC4oApoZkD7bTiEE23OCg=
X-Google-Smtp-Source: AA6agR6FXo2eDIl0MQGY4qrIKW20mkTpBU7CcTRg/DuFdoBkQK2/GJBJ38Sg8AVB2weSBYCkgq6bgw==
X-Received: by 2002:a05:6000:168e:b0:22a:4e45:7469 with SMTP id y14-20020a056000168e00b0022a4e457469mr8999494wrd.681.1663084970033;
        Tue, 13 Sep 2022 09:02:50 -0700 (PDT)
Received: from prasmi.home ([2a00:23c8:2501:c701:fc6e:cfa1:9281:3490])
        by smtp.gmail.com with ESMTPSA id az8-20020a05600c600800b003b27f644488sm14116064wmb.29.2022.09.13.09.02.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Sep 2022 09:02:48 -0700 (PDT)
From:   Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Cc:     Prabhakar <prabhakar.csengg@gmail.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Hans Verkuil <hverkuil@xs4all.nl>, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH] media: dt-bindings: ov5645: Convert OV5645 binding to a schema
Date:   Tue, 13 Sep 2022 17:02:24 +0100
Message-Id: <20220913160224.14951-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Convert the simple OV5645 Device Tree binding to json-schema.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 .../devicetree/bindings/media/i2c/ov5645.txt  |  54 --------
 .../bindings/media/i2c/ovti,ov5645.yaml       | 119 ++++++++++++++++++
 2 files changed, 119 insertions(+), 54 deletions(-)
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
index 000000000000..7f407c988f87
--- /dev/null
+++ b/Documentation/devicetree/bindings/media/i2c/ovti,ov5645.yaml
@@ -0,0 +1,119 @@
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
+allOf:
+  - $ref: /schemas/media/video-interface-devices.yaml#
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
+          clock-lanes:
+            const: 0
+
+          bus-type:
+            const: 4
+
+          data-lanes:
+            minItems: 1
+            maxItems: 2
+            items:
+              enum: [1, 2]
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - clock-names
+  - clock-frequency
+  - vdda-supply
+  - vddd-supply
+  - vdddo-supply
+  - enable-gpios
+  - reset-gpios
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
+                      clock-lanes = <0>;
+                      data-lanes = <1 2>;
+                  };
+              };
+          };
+      };
+...
-- 
2.25.1

