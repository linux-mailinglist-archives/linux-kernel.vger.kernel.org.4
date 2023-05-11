Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A7CF6FEF53
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 11:52:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237789AbjEKJwK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 05:52:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237624AbjEKJwD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 05:52:03 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92840A5D5
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 02:51:31 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-3f417ea5252so40830125e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 02:51:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1683798690; x=1686390690;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=67/6bAcN5c2GUFRah8RhXGRCsZJE/Ek9N/Y5A37vLkc=;
        b=RAI4i/gTipbG/OYvkfsJo6hlMYKOeVCAFGzm4BEaxORP45xZWMM+PqTZCbxHoLFXyV
         YCSlbiE9aib1W1XhOcuYVC4UWbmwU3uC6379QD8umv2PYY7Jkz+EdiUpOhdTWq4Izn0f
         43YVDlTDH4HM/y8viBZLK+M/cTI3jpBgNXvuJCxU04KG7DSMg5srzr6sv8wnl+XyaOII
         zv0POnZK2llt3S8eIB5PHSbYwWyTYzy/VLuo6MY62YgJ41QZfLsVo6AaTjFbHIOVkyaS
         lgwuZY+YjydsjjdmEHllOzg6J6h/NRQF0MaWXcQmQKwQtDKQhY1BatM69gxMnNu3i7LS
         LmRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683798690; x=1686390690;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=67/6bAcN5c2GUFRah8RhXGRCsZJE/Ek9N/Y5A37vLkc=;
        b=kSVAptOe0IX36015xX8FSOL3oUUC7THAUdpSTKihDXMtCYVIpfFRM08tdVdztgxRyg
         lQq32NrolvUy43/YPMSYu6JdY198enuG/hmJeEVq1bPQz/pRlYKXWZzkXAE3Ypy4rmN6
         A5+QCuWMj85/+PY9sORLQK8fG5DXQMdu040I3gY5/S1rCn3pcnGpqggpF53+HHre/tJx
         JM0vmo+cC3UmaMGUUkE7x5A//5rAncgFSydOeo/HiIaiYmGfXTIREMuuwBaQzgtpO+7T
         FV2/eFQyUedAcRkEGtjQaau+8iM39jwaqFOzR/I/5w8OZxzfwgaRuRJIs08bpd63y+A8
         sIrA==
X-Gm-Message-State: AC+VfDwiB9lCuEXCThh4HMXe0VOmKI2dYZTM1LRJTJW7DNrQzHJUxbKy
        5107f0+u+ld/IYAFRZbNcbTcYQ==
X-Google-Smtp-Source: ACHHUZ6EMq2pHjfcKtG0BqQ6x9EUcaSzjC8zOJ89Wmbp3sTvRcWb9z7mA2X1W0bnscb4M6ZvHPjLTg==
X-Received: by 2002:a05:600c:2116:b0:3f4:294d:8524 with SMTP id u22-20020a05600c211600b003f4294d8524mr7201971wml.22.1683798689891;
        Thu, 11 May 2023 02:51:29 -0700 (PDT)
Received: from baylibre-ThinkPad-T14s-Gen-2i.. (120.205.87.79.rev.sfr.net. [79.87.205.120])
        by smtp.gmail.com with ESMTPSA id z9-20020a05600c114900b003f4069417absm22389956wmz.24.2023.05.11.02.51.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 May 2023 02:51:29 -0700 (PDT)
From:   Julien Panis <jpanis@baylibre.com>
To:     lee@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        corbet@lwn.net, arnd@arndb.de, gregkh@linuxfoundation.org,
        derek.kiernan@xilinx.com, dragan.cvetic@xilinx.com
Cc:     macro@orcam.me.uk, baolu.lu@linux.intel.com, yi.l.liu@intel.com,
        jirislaby@kernel.org, rostedt@goodmis.org, revest@chromium.org,
        gehao@kylinos.cn, akpm@linux-foundation.org, jgg@ziepe.ca,
        razor@blackwall.org, stephen@networkplumber.org,
        prabhakar.csengg@gmail.com, contact@emersion.fr,
        alex.williamson@redhat.com, akrowiak@linux.ibm.com,
        mark.rutland@arm.com, ye.xingchen@zte.com.cn, ojeda@kernel.org,
        me@kloenk.de, milan@mdaverde.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        sterzik@ti.com, u-kumar1@ti.com, eblanc@baylibre.com,
        jneanne@baylibre.com, aseketeli@baylibre.com
Subject: [PATCH v7 1/6] dt-bindings: mfd: Add TI TPS6594 PMIC
Date:   Thu, 11 May 2023 11:51:21 +0200
Message-Id: <20230511095126.105104-2-jpanis@baylibre.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20230511095126.105104-1-jpanis@baylibre.com>
References: <20230511095126.105104-1-jpanis@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

TPS6594 is a Power Management IC which provides regulators and others
features like GPIOs, RTC, watchdog, ESMs (Error Signal Monitor), and
PFSM (Pre-configurable Finite State Machine) managing the state of the
device.
TPS6594 is the super-set device while TPS6593 and LP8764 are derivatives.

Signed-off-by: Julien Panis <jpanis@baylibre.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/mfd/ti,tps6594.yaml   | 193 ++++++++++++++++++
 1 file changed, 193 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mfd/ti,tps6594.yaml

diff --git a/Documentation/devicetree/bindings/mfd/ti,tps6594.yaml b/Documentation/devicetree/bindings/mfd/ti,tps6594.yaml
new file mode 100644
index 000000000000..9d43376bebed
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/ti,tps6594.yaml
@@ -0,0 +1,193 @@
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
+description:
+  TPS6594 is a Power Management IC which provides regulators and others
+  features like GPIOs, RTC, watchdog, ESMs (Error Signal Monitor), and
+  PFSM (Pre-configurable Finite State Machine) managing the state of the device.
+  TPS6594 is the super-set device while TPS6593 and LP8764 are derivatives.
+
+properties:
+  compatible:
+    enum:
+      - ti,lp8764-q1
+      - ti,tps6593-q1
+      - ti,tps6594-q1
+
+  reg:
+    description: I2C slave address or SPI chip select number.
+    maxItems: 1
+
+  ti,primary-pmic:
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
+  gpio-controller: true
+
+  '#gpio-cells':
+    const: 2
+    description: |
+      The first cell is the pin number, the second cell is used to specify flags.
+      See ../gpio/gpio.txt for more information.
+
+  interrupts:
+    maxItems: 1
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
+            compatible = "ti,tps6593-q1";
+            reg = <0x48>;
+            ti,primary-pmic;
+            system-power-controller;
+
+            gpio-controller;
+            #gpio-cells = <2>;
+
+            pinctrl-names = "default";
+            pinctrl-0 = <&pmic_irq_pins_default>;
+            interrupt-parent = <&mcu_gpio0>;
+            interrupts = <0 IRQ_TYPE_EDGE_FALLING>;
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

