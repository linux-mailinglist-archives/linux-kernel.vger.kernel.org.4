Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09565614189
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 00:22:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229846AbiJaXWZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 19:22:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229839AbiJaXWP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 19:22:15 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9525A15801;
        Mon, 31 Oct 2022 16:22:14 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id l16-20020a05600c4f1000b003c6c0d2a445so8966767wmq.4;
        Mon, 31 Oct 2022 16:22:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GVip8IOpyMxjep2B0xWdSusXNinq79sxctTxO3WsNTg=;
        b=BzOiQz3khhlS5lwRxTlUiNaP3JUy9XE1LhgHHLsBVOw6sL/p87LQ+Qsqi2W9tvNeS9
         BQ9bf9XauoB/Vgo6HYbv1vz6piBl5ejpynsBdKkjopYw2pDyOnqL7H08+BvWZ6ZHPDkz
         SR1AbURGF7IU7xe9VQVKcvdaDBNBZtPlL016XZN+gX+6CBr3P0aA2QlPP/prtz5FtvWN
         oqIRld7CdDNMPSuDXHu48dxOJlXos6INLT8nT5gv0pgS2kSAqZbgmT+KQN71yls3oMOA
         2ELVPDwz7yzuv0Oh4KALqv5Lcpmp7mJeUB27m5XIsOQjfZKq7NU+Q3OK86gulNauC2Q3
         HjxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GVip8IOpyMxjep2B0xWdSusXNinq79sxctTxO3WsNTg=;
        b=QEBDbPim+9ilEVtDJUf1Gh9HTDccEq4B5hj2L8EfcxGiHcpeYYz5vrY5vKwb/LzCSl
         2bDBod12viRFg3JP3zNkjoSCXNcMOVIfafOIUEt8HirLOB9BWrsPh5iJ870+yn0vjcgj
         iG4U0TkTFz7IS5fMw2epUSIlKQWhVz1mvN86wGKZX/GZmu158MAa0WrIkB1/uBoOv5hW
         ylEKexs4wgXSBesAEStT3RMLma+ERB04aNh57xu6mRDfwHnBpaHKEme/L0QzO75g35Zh
         rvbm8v/UTsaltYKaSp6TiFEiWlU3S8SJPMZzhs/ihbkJoHZFsKBXfBtaRD5DWCp4S0Mi
         mCKg==
X-Gm-Message-State: ACrzQf1R49ax4XxeBxxqZ68zGFVJJsYMtrloJSW/0Y7Ubu01PWqACykc
        +uj7e8OLY0OM0yd8OLmskV8=
X-Google-Smtp-Source: AMsMyM4gjZCg3yaqoXhBgzxKHeJrqOi9G7ZHu6ppPxCLtaiNRJW1cZ+9wi/YYVNX4sVQUZubQNtiXQ==
X-Received: by 2002:a05:600c:4f04:b0:3c6:fae5:b4d4 with SMTP id l4-20020a05600c4f0400b003c6fae5b4d4mr9897262wmq.103.1667258532998;
        Mon, 31 Oct 2022 16:22:12 -0700 (PDT)
Received: from prasmi.home ([2a00:23c8:2501:c701:15da:d6ab:ec79:436])
        by smtp.gmail.com with ESMTPSA id l24-20020a1c7918000000b003cf7928e731sm2190343wme.9.2022.10.31.16.22.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Oct 2022 16:22:12 -0700 (PDT)
From:   Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Sakari Ailus <sakari.ailus@linux.intel.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Hans Verkuil <hverkuil@xs4all.nl>
Cc:     Shawn Tu <shawnx.tu@intel.com>, Jacopo Mondi <jacopo@jmondi.org>,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-renesas-soc@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH v4 5/9] media: dt-bindings: ov5645: Convert OV5645 binding to a schema
Date:   Mon, 31 Oct 2022 23:21:58 +0000
Message-Id: <20221031232202.131945-6-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221031232202.131945-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20221031232202.131945-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
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
- clock-frequency
- enable-gpios
- reset-gpios

Also drop the "clock-names" property as we have a single clock source for
the sensor and the driver has been updated to drop the clk referencing by
name.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
v3->v4:
* Used 4 spaces for example node
* Added reg property after compatible

v3:
* No change

v2 -> v3
* Dropped clock-names property
* Marked power supplies as mandatory
* Dropped the comment for voltage power supplies
* Included RB tag from Laurent
* Driver change to drop clock-names [0]

[0] https://lore.kernel.org/linux-media/Yyh%2F3uzOJOu3drEB@pendragon.ideasonboard.com/T/#t

v1 -> v2
* Dropped ref to video-interface-devices.yaml#
* Dropped driver specific required items from the list
* Updated commit message
* Dropped clock-lanes and bus-type from the port and example node
* Marked data-lanes as required in port node
---
 .../devicetree/bindings/media/i2c/ov5645.txt  |  54 ---------
 .../bindings/media/i2c/ovti,ov5645.yaml       | 104 ++++++++++++++++++
 2 files changed, 104 insertions(+), 54 deletions(-)
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
index 000000000000..52c6281a6684
--- /dev/null
+++ b/Documentation/devicetree/bindings/media/i2c/ovti,ov5645.yaml
@@ -0,0 +1,104 @@
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
+  - vdddo-supply
+  - vdda-supply
+  - vddd-supply
+  - port
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        camera@3c {
+            compatible = "ovti,ov5645";
+            reg = <0x3c>;
+            clocks = <&clks 1>;
+            clock-frequency = <24000000>;
+            vdddo-supply = <&ov5645_vdddo_1v8>;
+            vdda-supply = <&ov5645_vdda_2v8>;
+            vddd-supply = <&ov5645_vddd_1v5>;
+            enable-gpios = <&gpio1 19 GPIO_ACTIVE_HIGH>;
+            reset-gpios = <&gpio1 20 GPIO_ACTIVE_LOW>;
+            pinctrl-names = "default";
+            pinctrl-0 = <&pinctrl_ov5645>;
+
+            port {
+                ov5645_ep: endpoint {
+                    remote-endpoint = <&csi0_ep>;
+                    data-lanes = <1 2>;
+                };
+            };
+        };
+    };
+...
-- 
2.25.1

