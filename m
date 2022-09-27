Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FDBE5EC73E
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 17:09:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231837AbiI0PJ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 11:09:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229773AbiI0PJY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 11:09:24 -0400
Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FFF8ED5C7;
        Tue, 27 Sep 2022 08:09:23 -0700 (PDT)
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-1318443dbdfso2295206fac.3;
        Tue, 27 Sep 2022 08:09:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=1ZWmPycHUkkFEQR2ZsGpxQk0g/W60HxvJ1Q7FAci2J4=;
        b=L+ii6VVKnK5x/FHaKT59G6act7ch4ziRQjVN56BkheM35qKL0hsR8kwh1GJPT3IJ3S
         FuOta7y30UUN5sCDHfo5Spbsy45RffRYKJNnPqM/kI+Jgt4T1HivV8DFdwHKQt2H4wv/
         d7LPnC/ODGtk59VkzWU/80ypnoDMUxjoUooifiOxtuxbrhYrxkJZisC1EKbQiEaa2kmX
         OZw374JlnMNsu1sUb6hasZmW8tCbxuj7/FSPYV7mRv8FMH695JNUOw2lTuPrIHMni/Gn
         enKAHwDS5ITN25korn8S8OKIVxGr9kuTM3yZQ5C5b2APNuOfW/DqTJhMVpIgmv8efvMN
         AksQ==
X-Gm-Message-State: ACrzQf0UfRtf/GmofrUWBps/jBdmFWTX9g2zAEj88rcAt1gbKn0jARm9
        y/rLT4ADFMUAiL671dr3kA==
X-Google-Smtp-Source: AMsMyM7APdedr7GTCehozM/Pn4pn3u16sNQkYQCLotrGXzCOPCX9JgcatneA+sxDI36vhFUqMSl67A==
X-Received: by 2002:a05:6870:ac0d:b0:127:bf92:581f with SMTP id kw13-20020a056870ac0d00b00127bf92581fmr2612535oab.270.1664291362323;
        Tue, 27 Sep 2022 08:09:22 -0700 (PDT)
Received: from xps15.herring.priv (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.googlemail.com with ESMTPSA id br25-20020a056830391900b00654625c0c4dsm780884otb.17.2022.09.27.08.09.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Sep 2022 08:09:22 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Jiri Kosina <jkosina@suse.cz>
Cc:     linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] dt-bindings: input: Convert hid-over-i2c to DT schema
Date:   Tue, 27 Sep 2022 10:09:15 -0500
Message-Id: <20220927150916.1091217-1-robh@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the hid-over-i2c binding to DT schema format. The supplies should
probably be specific to a specific device, but it seems they are already
in use otherwise. 'wakeup-source' is added as it was not explicitly
documented.

There's a few warnings for undocumented properties 'vcc-supply' and
'reset-gpios'. Those remain as they probably should have a specific
compatible as well.

Signed-off-by: Rob Herring <robh@kernel.org>
---
v2:
 - Fix example dtc warnings
---
 .../bindings/input/hid-over-i2c.txt           | 46 ----------
 .../bindings/input/hid-over-i2c.yaml          | 83 +++++++++++++++++++
 2 files changed, 83 insertions(+), 46 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/input/hid-over-i2c.txt
 create mode 100644 Documentation/devicetree/bindings/input/hid-over-i2c.yaml

diff --git a/Documentation/devicetree/bindings/input/hid-over-i2c.txt b/Documentation/devicetree/bindings/input/hid-over-i2c.txt
deleted file mode 100644
index 34c43d3bddfd..000000000000
--- a/Documentation/devicetree/bindings/input/hid-over-i2c.txt
+++ /dev/null
@@ -1,46 +0,0 @@
-* HID over I2C Device-Tree bindings
-
-HID over I2C provides support for various Human Interface Devices over the
-I2C bus. These devices can be for example touchpads, keyboards, touch screens
-or sensors.
-
-The specification has been written by Microsoft and is currently available here:
-http://msdn.microsoft.com/en-us/library/windows/hardware/hh852380.aspx
-
-If this binding is used, the kernel module i2c-hid will handle the communication
-with the device and the generic hid core layer will handle the protocol.
-
-Required properties:
-- compatible: must be "hid-over-i2c"
-- reg: i2c slave address
-- hid-descr-addr: HID descriptor address
-- interrupts: interrupt line
-
-Additional optional properties:
-
-Some devices may support additional optional properties to help with, e.g.,
-power sequencing. The following properties can be supported by one or more
-device-specific compatible properties, which should be used in addition to the
-"hid-over-i2c" string.
-
-- compatible:
-  * "wacom,w9013" (Wacom W9013 digitizer). Supports:
-    - vdd-supply (3.3V)
-    - vddl-supply (1.8V)
-    - post-power-on-delay-ms
-
-- vdd-supply: phandle of the regulator that provides the supply voltage.
-- post-power-on-delay-ms: time required by the device after enabling its regulators
-  or powering it on, before it is ready for communication.
-- touchscreen-inverted-x: See touchscreen.txt
-- touchscreen-inverted-y: See touchscreen.txt
-
-Example:
-
-	i2c-hid-dev@2c {
-		compatible = "hid-over-i2c";
-		reg = <0x2c>;
-		hid-descr-addr = <0x0020>;
-		interrupt-parent = <&gpx3>;
-		interrupts = <3 2>;
-	};
diff --git a/Documentation/devicetree/bindings/input/hid-over-i2c.yaml b/Documentation/devicetree/bindings/input/hid-over-i2c.yaml
new file mode 100644
index 000000000000..7156b08f7645
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/hid-over-i2c.yaml
@@ -0,0 +1,83 @@
+# SPDX-License-Identifier: GPL-2.0-only
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/input/hid-over-i2c.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: HID over I2C Devices
+
+maintainers:
+  - Benjamin Tissoires <benjamin.tissoires@redhat.com>
+  - Jiri Kosina <jkosina@suse.cz>
+
+description: |+
+  HID over I2C provides support for various Human Interface Devices over the
+  I2C bus. These devices can be for example touchpads, keyboards, touch screens
+  or sensors.
+
+  The specification has been written by Microsoft and is currently available here:
+  https://msdn.microsoft.com/en-us/library/windows/hardware/hh852380.aspx
+
+  If this binding is used, the kernel module i2c-hid will handle the communication
+  with the device and the generic hid core layer will handle the protocol.
+
+allOf:
+  - $ref: /schemas/input/touchscreen/touchscreen.yaml#
+
+properties:
+  compatible:
+    oneOf:
+      - items:
+          - enum:
+              - wacom,w9013
+          - const: hid-over-i2c
+      - description: Just "hid-over-i2c" alone is allowed, but not recommended.
+        const: hid-over-i2c
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  hid-descr-addr:
+    description: HID descriptor address
+    $ref: /schemas/types.yaml#/definitions/uint32
+
+  post-power-on-delay-ms:
+    description: Time required by the device after enabling its regulators
+      or powering it on, before it is ready for communication.
+
+  touchscreen-inverted-x: true
+
+  touchscreen-inverted-y: true
+
+  vdd-supply:
+    description: 3.3V supply
+
+  vddl-supply:
+    description: 1.8V supply
+
+  wakeup-source: true
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
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        hid@2c {
+            compatible = "hid-over-i2c";
+            reg = <0x2c>;
+            hid-descr-addr = <0x0020>;
+            interrupts = <3 2>;
+        };
+    };
+...
-- 
2.34.1

