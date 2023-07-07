Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3291774B87B
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 23:07:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232798AbjGGVHD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 17:07:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232301AbjGGVG4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 17:06:56 -0400
Received: from mail-il1-f173.google.com (mail-il1-f173.google.com [209.85.166.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 273CA1FC7;
        Fri,  7 Jul 2023 14:06:54 -0700 (PDT)
Received: by mail-il1-f173.google.com with SMTP id e9e14a558f8ab-34574eb05f4so9005005ab.0;
        Fri, 07 Jul 2023 14:06:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688764013; x=1691356013;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+idSLmbMdumqAzjaQfv7AEhyG7CoLt1vn0LI9DnSRgs=;
        b=aBt8UyrlQV7QJrKGL+/lZj6FqpyOy1SGQ+0Hz4vorUhtRyoZda9AIVA8x/GaD26zai
         3fXBKI+oGRKNxYqwXnqFnoSkDv4/Q6Fm8hVvKiizroM9AtnBaICH2c83cWIrDTYj4o+n
         ogSuq+5+FTIFVwlDgVD/Ij8YDGulmO0gYeHv0rdm8RtGvnid5KdnTu7Rzr8OAf5zb8h2
         hN+Jt5ZoxzKgZolmeE73xNSqlI/MCWbJ5mCWYIiURXz2KgR43OpH9PLej1T1vNqsrJtF
         /8GVUjffZ2sr/4Kflq+HFiJSNiqG5EuyMH9axBIchhQc3bC1WzMNhSfO+BVYYKgF50nm
         3dVw==
X-Gm-Message-State: ABy/qLb9hm01FwdphXNpBtneOKXDVyHNoDqM9NvikksrU5qGSvFMm2R3
        sYsIS9AnA3/i1R3XZPoqqQ==
X-Google-Smtp-Source: APBJJlHGmULlfinqCRnfTOfXeJUr+GO1379slbmQEf83+Oxfa5iV/XS9lY0TOib45dzDVfoi568lJA==
X-Received: by 2002:a92:ca91:0:b0:345:b923:971a with SMTP id t17-20020a92ca91000000b00345b923971amr6452462ilo.0.1688764013137;
        Fri, 07 Jul 2023 14:06:53 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id z1-20020a029f01000000b0042b8566a982sm958344jal.41.2023.07.07.14.06.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jul 2023 14:06:52 -0700 (PDT)
Received: (nullmailer pid 868854 invoked by uid 1000);
        Fri, 07 Jul 2023 21:06:50 -0000
From:   Rob Herring <robh@kernel.org>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Todor Tomov <todor.too@gmail.com>
Cc:     linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] media: dt-bindings: Convert Omnivision OV7251 to DT schema
Date:   Fri,  7 Jul 2023 15:06:46 -0600
Message-Id: <20230707210646.868758-1-robh@kernel.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the OmniVision OV7251 Image Sensor binding to DT schema format.

vddd-supply was listed as required, but the example and actual user
don't have it. Also, the data brief says it has an internal regulator,
so perhaps it is truly optional.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/media/i2c/ov7251.txt  |  52 ---------
 .../bindings/media/i2c/ovti,ov7251.yaml       | 105 ++++++++++++++++++
 2 files changed, 105 insertions(+), 52 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/media/i2c/ov7251.txt
 create mode 100644 Documentation/devicetree/bindings/media/i2c/ovti,ov7251.yaml

diff --git a/Documentation/devicetree/bindings/media/i2c/ov7251.txt b/Documentation/devicetree/bindings/media/i2c/ov7251.txt
deleted file mode 100644
index 8281151f7493..000000000000
--- a/Documentation/devicetree/bindings/media/i2c/ov7251.txt
+++ /dev/null
@@ -1,52 +0,0 @@
-* Omnivision 1/7.5-Inch B&W VGA CMOS Digital Image Sensor
-
-The Omnivision OV7251 is a 1/7.5-Inch CMOS active pixel digital image sensor
-with an active array size of 640H x 480V. It is programmable through a serial
-I2C interface.
-
-Required Properties:
-- compatible: Value should be "ovti,ov7251".
-- clocks: Reference to the xclk clock.
-- clock-names: Should be "xclk".
-- clock-frequency: Frequency of the xclk clock.
-- enable-gpios: Chip enable GPIO. Polarity is GPIO_ACTIVE_HIGH. This corresponds
-  to the hardware pin XSHUTDOWN which is physically active low.
-- vdddo-supply: Chip digital IO regulator.
-- vdda-supply: Chip analog regulator.
-- vddd-supply: Chip digital core regulator.
-
-The device node shall contain one 'port' child node with a single 'endpoint'
-subnode for its digital output video port, in accordance with the video
-interface bindings defined in
-Documentation/devicetree/bindings/media/video-interfaces.txt.
-
-Example:
-
-	&i2c1 {
-		...
-
-		ov7251: camera-sensor@60 {
-			compatible = "ovti,ov7251";
-			reg = <0x60>;
-
-			enable-gpios = <&gpio1 6 GPIO_ACTIVE_HIGH>;
-			pinctrl-names = "default";
-			pinctrl-0 = <&camera_bw_default>;
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
-				ov7251_ep: endpoint {
-					clock-lanes = <1>;
-					data-lanes = <0>;
-					remote-endpoint = <&csi0_ep>;
-				};
-			};
-		};
-	};
diff --git a/Documentation/devicetree/bindings/media/i2c/ovti,ov7251.yaml b/Documentation/devicetree/bindings/media/i2c/ovti,ov7251.yaml
new file mode 100644
index 000000000000..8d939858d950
--- /dev/null
+++ b/Documentation/devicetree/bindings/media/i2c/ovti,ov7251.yaml
@@ -0,0 +1,105 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/media/i2c/ovti,ov7251.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: OmniVision OV7251 Image Sensor
+
+description:
+  The Omnivision OV7251 is a 1/7.5-Inch CMOS active pixel digital image sensor
+  with an active array size of 640H x 480V. It is programmable through a serial
+  I2C interface.
+
+maintainers:
+  - Todor Tomov <todor.too@gmail.com>
+
+properties:
+  compatible:
+    const: ovti,ov7251
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
+    description: Digital core voltage supply, 1.2 volts
+
+  vdddo-supply:
+    description: Digital I/O voltage supply, 1.8 volts
+
+  enable-gpios:
+    maxItems: 1
+    description:
+      Reference to the GPIO connected to the XSHUTDOWN pin, if any. Polarity
+      is GPIO_ACTIVE_HIGH.
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
+            maximum: 1
+
+          data-lanes:
+            maxItems: 1
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
+            compatible = "ovti,ov7251";
+            reg = <0x3c>;
+            clocks = <&clks 1>;
+            clock-frequency = <24000000>;
+            vdddo-supply = <&ov7251_vdddo_1v8>;
+            vdda-supply = <&ov7251_vdda_2v8>;
+            vddd-supply = <&ov7251_vddd_1v5>;
+            enable-gpios = <&gpio1 19 GPIO_ACTIVE_HIGH>;
+
+            port {
+                ov7251_ep: endpoint {
+                    remote-endpoint = <&csi0_ep>;
+                    clock-lanes = <1>;
+                    data-lanes = <0>;
+                };
+            };
+        };
+    };
+...
-- 
2.40.1

