Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CC97699371
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 12:44:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230424AbjBPLoU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 06:44:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229761AbjBPLoR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 06:44:17 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F055114E97
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 03:44:15 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id a3so4506687ejb.3
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 03:44:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RPdX1SQa7MIN/T0cQApl5XekElCN+FQYDVXKXp8YrhQ=;
        b=hUk7G9yiVJFl0iSLZ1brk8uZWu7x44aghU2nTGqCSmaS4gQxZZcUoo9b6zXjQI4Sv1
         XFXKwiGRQ8aneKB4fUC+S8gfNrJrNDlaf7A4heBm1vTzQ7/NhWTi7lyNfIVuK0A7OacC
         gFKboeB/tq3P+vDZ08lKrZeB85uBxdBuodf+8yzIqT24ZP5136jilx3BeVl2PI/azNRE
         xSg+gKSoMItt4DeAdu7tX0bk6w+Susmer1V6fd6gtDwFFQTjVE5hpz0vp5dtCtfBDCHd
         NCWzIuzJtpGNX0BAI4yijvVuTgbVk4+9AfQEf58AX+y9+0d/CC28AdrA8529tE+HSw5K
         v4qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RPdX1SQa7MIN/T0cQApl5XekElCN+FQYDVXKXp8YrhQ=;
        b=pCcGwTlNg8WZQR4bkaFkvl3vviTRtd7m/mVW7+ZYQjdzRuomd2WcefworgOpOwv/Ey
         KopDwczzZ14g87QBlhLZ6OavS2cstfbOHiiFUwLCSIgGLjVmSw/9pSZBWwCrLcSMjfA3
         d10VSHkf2B5iLB2CreF5jWWPKZ5fQf5pFMNrwiHY0LtXNg9srVv1dO3OAmWZdTfomW1/
         ra8v0j5nI/j1petcH7biwnZYjeUwMD4zIasxpKbPhmZ/wxOfnJKOniKlBevgThkWn/EU
         dz6GjcT+1gtRDEr9CvZnviArLBxTIdOS6J5j/pghlxBMldHITleqySgHmNoEAu1sEcyE
         fFKg==
X-Gm-Message-State: AO0yUKVSQ+vMRHnzhi3lQVqGqVBh+JvQEPiI6jmwwUr6rNh0KSu+V3Gb
        Y0G9ITLtgI1z5FAo7hTblidmLQ==
X-Google-Smtp-Source: AK7set8g3ExLf30OnGF9/mmf9InGB0533W2WKoRXq3Gylfp451WE9CJXTlMECip8rWzZgzqyrH0EvA==
X-Received: by 2002:a17:906:f6d4:b0:872:84dd:8903 with SMTP id jo20-20020a170906f6d400b0087284dd8903mr5863829ejb.59.1676547854511;
        Thu, 16 Feb 2023 03:44:14 -0800 (PST)
Received: from baylibre-ThinkPad-T14s-Gen-2i.. (247.165.185.81.rev.sfr.net. [81.185.165.247])
        by smtp.gmail.com with ESMTPSA id k20-20020a170906a39400b008b14c5a82e7sm698153ejz.127.2023.02.16.03.44.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Feb 2023 03:44:14 -0800 (PST)
From:   Julien Panis <jpanis@baylibre.com>
To:     lee@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, corbet@lwn.net
Cc:     hdegoede@redhat.com, eric.auger@redhat.com, jgg@ziepe.ca,
        razor@blackwall.org, suma.hegde@amd.com,
        stephen@networkplumber.org, arnd@arndb.de,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, eblanc@baylibre.com,
        jneanne@baylibre.com
Subject: [PATCH v1 1/4] dt-bindings: mfd: Add DT bindings for TI TPS6594 PMIC
Date:   Thu, 16 Feb 2023 12:44:07 +0100
Message-Id: <20230216114410.183489-2-jpanis@baylibre.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20230216114410.183489-1-jpanis@baylibre.com>
References: <20230216114410.183489-1-jpanis@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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
 .../devicetree/bindings/mfd/ti,tps6594.yaml   | 164 ++++++++++++++++++
 1 file changed, 164 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mfd/ti,tps6594.yaml

diff --git a/Documentation/devicetree/bindings/mfd/ti,tps6594.yaml b/Documentation/devicetree/bindings/mfd/ti,tps6594.yaml
new file mode 100644
index 000000000000..37968d6c0420
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/ti,tps6594.yaml
@@ -0,0 +1,164 @@
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
+      - ti,tps6594
+      - ti,tps6593
+      - ti,lp8764x
+
+  reg:
+    description: I2C slave address or SPI chip select number.
+    maxItems: 1
+
+  ti,use-crc:
+    type: boolean
+    description: If true, use CRC for I2C and SPI interface protocols.
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
+patternProperties:
+  "^buck([1-5]|12|34|123|1234)-supply$":
+    description: Input supply phandle for each buck.
+
+  "^ldo[1-4]-supply$":
+    description: Input supply phandle for each ldo.
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
+    additionalProperties: false
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
+            ti,use-crc;
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

