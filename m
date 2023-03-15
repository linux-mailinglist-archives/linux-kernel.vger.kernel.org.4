Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D17C6BAEDF
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 12:10:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232032AbjCOLK0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 07:10:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232122AbjCOLJu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 07:09:50 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99FD587A03
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 04:07:52 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id bh21-20020a05600c3d1500b003ed1ff06fb0so906559wmb.3
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 04:07:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112; t=1678878461;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xVmeDWZk28b0/wD+No3jLTyFsoEsJG1VIdEcja/q2aU=;
        b=ftW8vhXPxmxLeyN+WWsmaTvKCy3Z8J3uIhfqgFvK8+8vJExyLvbUXoHXO1vIqokhGH
         GO47kFjJu1zy3fIdBPIXmhY8KS2der7vySJ+bs/XuvBBL4NzhtZXbp96y9LZ/C14RpjC
         4JW/njRSsTLjviVTTm6gfgWruyWzmKyA0U9w4N5N4vjTXj7uK5mn29mup9ZzIlv5pPvO
         huxbooGO3qLAWKaHvDN0auTjzm9eap8G3oont1oOQaMS3oO8znLOsx/XY13gbaJE5d8d
         gAgMYtvXskBPo4pt/ioh9NpoTSQ0sipdLpHRCz2n/2JTsrLpw0QLN6v1Ml4ZuI7/i6WO
         ssIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678878461;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xVmeDWZk28b0/wD+No3jLTyFsoEsJG1VIdEcja/q2aU=;
        b=A+HXsBYfRredYH6TZQHnmh/OsOqJch25veoMerBSkqsCH0h4u5mZfpSkaUNi8ZletC
         souCP86sby0B1P+QCzI4J/bxzqTikyrYs73yWVmgUG915G1rN0XRIw87UF3aTA9jMRc3
         6yYdXM6KWnS9ArsOg5aGjBxZoHlWYaLuThJZvTxPP+H+CrosAlIjXaIspf8PoDc07a4l
         IBeAoF+HXB/+zTgrXkcV1IwLb8gDqf2QevuIwhS2l8gEiBDYh2VYhxIDp8bvEsoISVuu
         8IY0hpZqbEy1wNlnvtZaAinN8itxBFHgxpqycJx527Y5uOPWOLvQdOrsnEidg5wU3QoS
         yFMw==
X-Gm-Message-State: AO0yUKVrve2BSymyg3TO69WEycLED506A2TG/u7F7XujDlI1q/LIPSwD
        g/bT4FAFH/kW3OELxHvMLr8eBw==
X-Google-Smtp-Source: AK7set8TsyS/kWgy/Gxuw2/pCk1ph6lwvZnXMVfvQK0qjWh6x7FAhJkIFKoI/v5NWLiqNotF8/LYtA==
X-Received: by 2002:a05:600c:4f02:b0:3eb:39c3:8844 with SMTP id l2-20020a05600c4f0200b003eb39c38844mr18362043wmq.12.1678878461186;
        Wed, 15 Mar 2023 04:07:41 -0700 (PDT)
Received: from baylibre-ThinkPad-T14s-Gen-2i.. (151.31.102.84.rev.sfr.net. [84.102.31.151])
        by smtp.gmail.com with ESMTPSA id n5-20020adfe785000000b002c7066a6f77sm4339745wrm.31.2023.03.15.04.07.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Mar 2023 04:07:40 -0700 (PDT)
From:   Julien Panis <jpanis@baylibre.com>
To:     lee@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, corbet@lwn.net, arnd@arndb.de,
        gregkh@linuxfoundation.org, derek.kiernan@xilinx.com,
        dragan.cvetic@xilinx.com
Cc:     eric.auger@redhat.com, jgg@ziepe.ca, razor@blackwall.org,
        stephen@networkplumber.org, davem@davemloft.net,
        christian.koenig@amd.com, contact@emersion.fr,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, sterzik@ti.com, u-kumar1@ti.com,
        eblanc@baylibre.com, jneanne@baylibre.com
Subject: [PATCH v2 1/4] dt-bindings: mfd: Add TI TPS6594 PMIC
Date:   Wed, 15 Mar 2023 12:07:33 +0100
Message-Id: <20230315110736.35506-2-jpanis@baylibre.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20230315110736.35506-1-jpanis@baylibre.com>
References: <20230315110736.35506-1-jpanis@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

TPS6594 is a Power Management IC which provides regulators and others
features like GPIOs, RTC, watchdog, ESMs (Error Signal Monitor), and
PFSM (Pre-configurable Finite State Machine) managing the state of the
device.
TPS6594 is the super-set device while TPS6593 and LP8764X are derivatives.

Signed-off-by: Julien Panis <jpanis@baylibre.com>
---
 .../devicetree/bindings/mfd/ti,tps6594.yaml   | 191 ++++++++++++++++++
 1 file changed, 191 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mfd/ti,tps6594.yaml

diff --git a/Documentation/devicetree/bindings/mfd/ti,tps6594.yaml b/Documentation/devicetree/bindings/mfd/ti,tps6594.yaml
new file mode 100644
index 000000000000..18f47cd6a2f9
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/ti,tps6594.yaml
@@ -0,0 +1,191 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mfd/ti,tps6594.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: TI TPS6594 Power Management Integrated Circuit
+
+maintainers:
+  - Julien Panis <jpanis@baylibre.com>
+
+description: |
+  TPS6594 is a Power Management IC which provides regulators and others
+  features like GPIOs, RTC, watchdog, ESMs (Error Signal Monitor), and
+  PFSM (Pre-configurable Finite State Machine) managing the state of the device.
+  TPS6594 is the super-set device while TPS6593 and LP8764X are derivatives.
+
+properties:
+  compatible:
+    enum:
+      - ti,lp8764x
+      - ti,tps6593
+      - ti,tps6594
+
+  reg:
+    description: I2C slave address or SPI chip select number.
+    maxItems: 1
+
+  ti,spmi-controller:
+    type: boolean
+    description: |
+      Identify the primary PMIC on SPMI bus.
+      A multi-PMIC synchronization scheme is implemented in the PMIC device
+      to synchronize the power state changes with other PMIC devices. This is
+      accomplished through a SPMI bus: the primary PMIC is the controller
+      device on the SPMI bus, and the secondary PMICs are the target devices
+      on the SPMI bus.
+
+  system-power-controller: true
+
+  interrupts:
+    maxItems: 1
+
+  ti,multi-phase-id:
+    description: |
+      Describes buck multi-phase configuration, if any. For instance, XY id means
+      that outputs of buck converters X and Y are combined in multi-phase mode.
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum: [12, 34, 123, 1234]
+
+  regulators:
+    type: object
+    description: List of regulators provided by this controller.
+
+    patternProperties:
+      "^buck([1-5]|12|34|123|1234)$":
+        type: object
+        $ref: /schemas/regulator/regulator.yaml#
+
+        unevaluatedProperties: false
+
+      "^ldo[1-4]$":
+        type: object
+        $ref: /schemas/regulator/regulator.yaml#
+
+        unevaluatedProperties: false
+
+    allOf:
+      - if:
+          required:
+            - buck12
+        then:
+          properties:
+            buck123: false
+            buck1234: false
+      - if:
+          required:
+            - buck123
+        then:
+          properties:
+            buck34: false
+      - if:
+          required:
+            - buck1234
+        then:
+          properties:
+            buck34: false
+
+    additionalProperties: false
+
+patternProperties:
+  "^buck([1-5]|12|34|123|1234)-supply$":
+    description: Input supply phandle for each buck.
+
+  "^ldo[1-4]-supply$":
+    description: Input supply phandle for each ldo.
+
+required:
+  - compatible
+  - reg
+  - interrupts
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        tps6593: pmic@48 {
+            compatible = "ti,tps6593";
+            reg = <0x48>;
+            ti,spmi-controller;
+            system-power-controller;
+
+            pinctrl-names = "default";
+            pinctrl-0 = <&pmic_irq_pins_default>;
+            interrupt-parent = <&mcu_gpio0>;
+            interrupts = <0 IRQ_TYPE_EDGE_FALLING>;
+
+            ti,multi-phase-id = <123>;
+
+            buck123-supply = <&vcc_3v3_sys>;
+            buck4-supply = <&vcc_3v3_sys>;
+            buck5-supply = <&vcc_3v3_sys>;
+            ldo1-supply = <&vcc_3v3_sys>;
+            ldo2-supply = <&vcc_3v3_sys>;
+            ldo3-supply = <&buck5>;
+            ldo4-supply = <&vcc_3v3_sys>;
+
+            regulators {
+                buck123: buck123 {
+                    regulator-name = "vcc_core";
+                    regulator-min-microvolt = <750000>;
+                    regulator-max-microvolt = <850000>;
+                    regulator-boot-on;
+                    regulator-always-on;
+                };
+
+                buck4: buck4 {
+                    regulator-name = "vcc_1v1";
+                    regulator-min-microvolt = <1100000>;
+                    regulator-max-microvolt = <1100000>;
+                    regulator-boot-on;
+                    regulator-always-on;
+                };
+
+                buck5: buck5 {
+                    regulator-name = "vcc_1v8_sys";
+                    regulator-min-microvolt = <1800000>;
+                    regulator-max-microvolt = <1800000>;
+                    regulator-boot-on;
+                    regulator-always-on;
+                };
+
+                ldo1: ldo1 {
+                    regulator-name = "vddshv5_sdio";
+                    regulator-min-microvolt = <3300000>;
+                    regulator-max-microvolt = <3300000>;
+                    regulator-boot-on;
+                    regulator-always-on;
+                };
+
+                ldo2: ldo2 {
+                    regulator-name = "vpp_1v8";
+                    regulator-min-microvolt = <1800000>;
+                    regulator-max-microvolt = <1800000>;
+                    regulator-boot-on;
+                    regulator-always-on;
+                };
+
+                ldo3: ldo3 {
+                    regulator-name = "vcc_0v85";
+                    regulator-min-microvolt = <850000>;
+                    regulator-max-microvolt = <850000>;
+                    regulator-boot-on;
+                    regulator-always-on;
+                };
+
+                ldo4: ldo4 {
+                    regulator-name = "vdda_1v8";
+                    regulator-min-microvolt = <1800000>;
+                    regulator-max-microvolt = <1800000>;
+                    regulator-boot-on;
+                    regulator-always-on;
+                };
+            };
+        };
+    };
-- 
2.37.3

