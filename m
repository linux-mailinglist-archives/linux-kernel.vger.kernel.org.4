Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 010CB6144CD
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 07:48:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229964AbiKAGsz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 02:48:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229672AbiKAGsx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 02:48:53 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DACF05F63
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 23:48:52 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <lgo@pengutronix.de>)
        id 1opl4h-0004HL-NK; Tue, 01 Nov 2022 07:48:39 +0100
Received: from [2a0a:edc0:0:1101:1d::39] (helo=dude03.red.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <lgo@pengutronix.de>)
        id 1opl4h-001clN-Gj; Tue, 01 Nov 2022 07:48:38 +0100
Received: from lgo by dude03.red.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <lgo@pengutronix.de>)
        id 1opl4f-0031LM-QQ; Tue, 01 Nov 2022 07:48:37 +0100
From:   =?UTF-8?q?Leonard=20G=C3=B6hrs?= <l.goehrs@pengutronix.de>
To:     =?UTF-8?q?Leonard=20G=C3=B6hrs?= <l.goehrs@pengutronix.de>,
        kernel@pengutronix.de, Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] dt-bindings: iio: adc: add TI LMP92064 controller
Date:   Tue,  1 Nov 2022 07:48:03 +0100
Message-Id: <20221101064804.720050-1-l.goehrs@pengutronix.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: lgo@pengutronix.de
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

Add binding documentation for the TI LMP92064 dual channel SPI ADC.

Changes from v1 -> v2:

 - Rename the "shunt-resistor" devicetree property to
   "shunt-resistor-micro-ohms".
 - Add supply regulator support for the two voltage domains of the chip
   (vdd and vdig).
 - Add reference to spi-peripheral-props.yaml

Signed-off-by: Leonard Göhrs <l.goehrs@pengutronix.de>
---
 .../bindings/iio/adc/ti,lmp92064.yaml         | 70 +++++++++++++++++++
 1 file changed, 70 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/ti,lmp92064.yaml

diff --git a/Documentation/devicetree/bindings/iio/adc/ti,lmp92064.yaml b/Documentation/devicetree/bindings/iio/adc/ti,lmp92064.yaml
new file mode 100644
index 000000000000..357b15ebd897
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/ti,lmp92064.yaml
@@ -0,0 +1,70 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/adc/ti,lmp92064.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Texas Instruments LMP92064 Precision Current and Voltage Sensor.
+
+maintainers:
+  - Leonard Göhrs <l.goehrs@pengutronix.de>
+
+description: |
+  The LMP92064 is a two channel ADC intended for combined voltage and current
+  measurements.
+
+  The device contains two ADCs to allow simultaneous sampling of voltage and
+  current and thus of instantaneous power consumption.
+
+properties:
+  compatible:
+    enum:
+      - ti,lmp92064
+
+  reg:
+    maxItems: 1
+
+  vdd-supply:
+    description: Regulator that provides power to the main part of the chip
+
+  vdig-supply:
+    description: |
+      Regulator that provides power to the digital I/O part of the chip
+
+  shunt-resistor-micro-ohms:
+    description: |
+      Value of the shunt resistor (in µΩ) connected between INCP and INCN,
+      across which current is measured. Used to provide correct scaling of the
+      raw ADC measurement.
+
+  reset-gpios:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - shunt-resistor-micro-ohms
+
+allOf:
+  - $ref: /schemas/spi/spi-peripheral-props.yaml#
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+    spi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        adc@0 {
+            compatible = "ti,lmp92064";
+            reg = <0>;
+            vdd-supply = <&vdd>;
+            vdig-supply = <&vdd>;
+            spi-max-frequency = <20000000>;
+            shunt-resistor-micro-ohms = <15000>;
+            reset-gpios = <&gpio1 16 GPIO_ACTIVE_HIGH>;
+        };
+    };
+...
-- 
2.30.2

