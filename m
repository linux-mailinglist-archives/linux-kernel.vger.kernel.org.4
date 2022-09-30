Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73E2B5F0BFE
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 14:49:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231402AbiI3Ms6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 08:48:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231263AbiI3Msp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 08:48:45 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DF8D157B9D
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 05:48:44 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1oeFRI-0007W1-Aw; Fri, 30 Sep 2022 14:48:24 +0200
Received: from [2a0a:edc0:0:1101:1d::28] (helo=dude02.red.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <mfe@pengutronix.de>)
        id 1oeFRH-003nva-Fs; Fri, 30 Sep 2022 14:48:22 +0200
Received: from mfe by dude02.red.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <mfe@pengutronix.de>)
        id 1oeFRE-001tq1-QE; Fri, 30 Sep 2022 14:48:20 +0200
From:   Marco Felsch <m.felsch@pengutronix.de>
To:     mchehab@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, kishon@ti.com, vkoul@kernel.org,
        laurent.pinchart@ideasonboard.com, sakari.ailus@linux.intel.com,
        jacopo@jmondi.org, hverkuil@xs4all.nl
Cc:     linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@pengutronix.de,
        linux-media@vger.kernel.org
Subject: [PATCH v4 3/4] media: dt-bindings: add bindings for Toshiba TC358746
Date:   Fri, 30 Sep 2022 14:48:11 +0200
Message-Id: <20220930124812.450332-4-m.felsch@pengutronix.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220930124812.450332-1-m.felsch@pengutronix.de>
References: <20220930124812.450332-1-m.felsch@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mfe@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the bindings for the Toshiba TC358746 Parallel <-> MIPI-CSI bridge
driver.

Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
Reviewed-by: Rob Herring <robh@kernel.org>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
Changelog

v3:
- put the mclk comment into the description of #clock-cells
- make bus-type required
- allow all sync values
- allow all possible parallel bus-types
- added Laurent's r-b

v2:
- addded Robs r-b
- s/than/then/
- added hsync/vsync/bus-type, make hsync/vsync required
- fix example indent

 .../bindings/media/i2c/toshiba,tc358746.yaml  | 178 ++++++++++++++++++
 1 file changed, 178 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/media/i2c/toshiba,tc358746.yaml

diff --git a/Documentation/devicetree/bindings/media/i2c/toshiba,tc358746.yaml b/Documentation/devicetree/bindings/media/i2c/toshiba,tc358746.yaml
new file mode 100644
index 000000000000..b8ba85a2416c
--- /dev/null
+++ b/Documentation/devicetree/bindings/media/i2c/toshiba,tc358746.yaml
@@ -0,0 +1,178 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/media/i2c/toshiba,tc358746.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Toshiba TC358746 Parallel to MIPI CSI2 Bridge
+
+maintainers:
+  - Marco Felsch <kernel@pengutronix.de>
+
+description: |-
+  The Toshiba TC358746 converts a parallel video stream into a MIPI CSI-2
+  stream. The direction can be either parallel-in -> csi-out or csi-in ->
+  parallel-out The chip is programmable trough I2C and SPI but the SPI
+  interface is only supported in parallel-in -> csi-out mode.
+
+  Note that the current device tree bindings only support the
+  parallel-in -> csi-out path.
+
+properties:
+  compatible:
+    const: toshiba,tc358746
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    description:
+      The phandle to the reference clock source. This corresponds to the
+      hardware pin REFCLK.
+    maxItems: 1
+
+  clock-names:
+    const: refclk
+
+  "#clock-cells":
+    description: |
+      The bridge can act as clock provider for the sensor. To enable this
+      support #clock-cells must be specified. Attention if this feature is used
+      then the mclk rate must be at least: (2 * link-frequency) / 8
+                                           `------------------´   ^
+                                           internal PLL rate   smallest possible
+                                                                   mclk-div
+    const: 0
+
+  clock-output-names:
+    description:
+      The clock name of the MCLK output, the default name is tc358746-mclk.
+    maxItems: 1
+
+  vddc-supply:
+    description: Digital core voltage supply, 1.2 volts
+
+  vddio-supply:
+    description: Digital I/O voltage supply, 1.8 volts
+
+  vddmipi-supply:
+    description: MIPI CSI phy voltage supply, 1.2 volts
+
+  reset-gpios:
+    description:
+      The phandle and specifier for the GPIO that controls the chip reset.
+      This corresponds to the hardware pin RESX which is physically active low.
+    maxItems: 1
+
+  ports:
+    $ref: /schemas/graph.yaml#/properties/ports
+    properties:
+      port@0:
+        $ref: /schemas/graph.yaml#/$defs/port-base
+        description: Input port
+
+        properties:
+          endpoint:
+            $ref: /schemas/media/video-interfaces.yaml#
+            unevaluatedProperties: false
+
+            properties:
+              hsync-active: true
+              vsync-active: true
+              bus-type:
+                enum: [ 5, 6 ]
+
+            required:
+              - hsync-active
+              - vsync-active
+              - bus-type
+
+      port@1:
+        $ref: /schemas/graph.yaml#/$defs/port-base
+        description: Output port
+
+        properties:
+          endpoint:
+            $ref: /schemas/media/video-interfaces.yaml#
+            unevaluatedProperties: false
+
+            properties:
+              data-lanes:
+                minItems: 1
+                maxItems: 4
+
+              clock-noncontinuous: true
+              link-frequencies: true
+
+            required:
+              - data-lanes
+              - link-frequencies
+
+    required:
+      - port@0
+      - port@1
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - clock-names
+  - vddc-supply
+  - vddio-supply
+  - vddmipi-supply
+  - ports
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+
+    i2c {
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      csi-bridge@e {
+        compatible = "toshiba,tc358746";
+        reg = <0xe>;
+
+        clocks = <&refclk>;
+        clock-names = "refclk";
+
+        reset-gpios = <&gpio 2 GPIO_ACTIVE_LOW>;
+
+        vddc-supply = <&v1_2d>;
+        vddio-supply = <&v1_8d>;
+        vddmipi-supply = <&v1_2d>;
+
+        /* sensor mclk provider */
+        #clock-cells = <0>;
+
+        ports {
+          #address-cells = <1>;
+          #size-cells = <0>;
+
+          /* Input */
+          port@0 {
+            reg = <0>;
+            tc358746_in: endpoint {
+              remote-endpoint = <&sensor_out>;
+              hsync-active = <0>;
+              vsync-active = <0>;
+              bus-type = <5>;
+            };
+          };
+
+          /* Output */
+          port@1 {
+            reg = <1>;
+            tc358746_out: endpoint {
+              remote-endpoint = <&mipi_csi2_in>;
+              data-lanes = <1 2>;
+              clock-noncontinuous;
+              link-frequencies = /bits/ 64 <216000000>;
+            };
+          };
+        };
+      };
+    };
-- 
2.30.2

