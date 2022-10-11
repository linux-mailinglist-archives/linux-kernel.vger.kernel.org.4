Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69CF95FB9F3
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 19:52:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229966AbiJKRwv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 13:52:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230015AbiJKRwp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 13:52:45 -0400
Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64C194F18E;
        Tue, 11 Oct 2022 10:52:44 -0700 (PDT)
Received: by mail-oo1-f42.google.com with SMTP id h1-20020a4aa741000000b004756c611188so10587040oom.4;
        Tue, 11 Oct 2022 10:52:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=06y4LPa2ARF61oYkkmp5uqG5RC795RcUrnsHXwHkyVI=;
        b=17On4Z1I0IRgh+mwDuwyeiFzz0SiT5lLktUiMvWv377IZ7ORDJ11JxRWxko/Zkdr31
         CEk2A0i19wVuAOZ/3dGZSbfpINWfPOZ0vLEMjM70y7ukUDqceDSgRwyOzMutueBCXqJE
         rjnxldz3XLmr7VKuAKPD78021ADDUSOFC8h4pX7Z2Sf22cypmmTZ/Aua4Mes3yxbVuKn
         QxheXejVE8vbYI2OHAGrS71LBV350Db+rbBKWVCwCTGS+897sE87rgOAe9aMwQbhyTQ1
         51DAxHRo40uJ9y33Ev1Vjl7raDRP/hD0cRA5+uqRreuqmK50TVoBBmpe5ePHqJKqQUDc
         FlHg==
X-Gm-Message-State: ACrzQf1KcHZUv+SSi1sduKwMhkPhXjCEydwmIhE1Gw9UfRoHqv1cfM2+
        3KaGd4IxteOsZ+c4oJW/QQ==
X-Google-Smtp-Source: AMsMyM6qzjWoKY66x3ERX/h+VaCthT/iVnP1s+NJpheeyaoElqOI8gxqgwb90rNfuE84zsFOyBMrHw==
X-Received: by 2002:a05:6820:408:b0:476:229c:141d with SMTP id o8-20020a056820040800b00476229c141dmr9570931oou.64.1665510763475;
        Tue, 11 Oct 2022 10:52:43 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id p186-20020acabfc3000000b00354b0850fb6sm1638072oif.33.2022.10.11.10.52.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Oct 2022 10:52:42 -0700 (PDT)
Received: (nullmailer pid 3191691 invoked by uid 1000);
        Tue, 11 Oct 2022 17:52:44 -0000
From:   Rob Herring <robh@kernel.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Laxman Dewangan <ldewangan@nvidia.com>
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: thermal: Convert generic-adc-thermal to DT schema
Date:   Tue, 11 Oct 2022 12:52:35 -0500
Message-Id: <20221011175235.3191509-1-robh@kernel.org>
X-Mailer: git-send-email 2.35.1
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

Convert the 'generic-adc-thermal' binding to DT schema format.

The binding said '#thermal-sensor-cells' should be 1, but all in tree
users are 0 and 1 doesn't make sense for a single channel.

Drop the example's related providers and consumers of the
'generic-adc-thermal' node as the convention is to not have those in
the examples.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 .../bindings/thermal/generic-adc-thermal.yaml | 84 ++++++++++++++++
 .../bindings/thermal/thermal-generic-adc.txt  | 95 -------------------
 2 files changed, 84 insertions(+), 95 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/thermal/generic-adc-thermal.yaml
 delete mode 100644 Documentation/devicetree/bindings/thermal/thermal-generic-adc.txt

diff --git a/Documentation/devicetree/bindings/thermal/generic-adc-thermal.yaml b/Documentation/devicetree/bindings/thermal/generic-adc-thermal.yaml
new file mode 100644
index 000000000000..f1fc3b0d8608
--- /dev/null
+++ b/Documentation/devicetree/bindings/thermal/generic-adc-thermal.yaml
@@ -0,0 +1,84 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/thermal/generic-adc-thermal.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: General Purpose Analog To Digital Converter (ADC) based thermal sensor
+
+maintainers:
+  - Laxman Dewangan <ldewangan@nvidia.com>
+
+description:
+  On some of platforms, thermal sensor like thermistors are connected to
+  one of ADC channel and sensor resistance is read via voltage across the
+  sensor resistor. The voltage read across the sensor is mapped to
+  temperature using voltage-temperature lookup table.
+
+properties:
+  compatible:
+    const: generic-adc-thermal
+
+  '#thermal-sensor-cells':
+    const: 0
+
+  io-channels:
+    maxItems: 1
+
+  io-channel-names:
+    const: sensor-channel
+
+  temperature-lookup-table:
+    description: |
+      Lookup table to map the relation between ADC value and temperature.
+      When ADC is read, the value is looked up on the table to get the
+      equivalent temperature.
+
+      If not specified, driver assumes the ADC channel gives milliCelsius
+      directly.
+    $ref: /schemas/types.yaml#/definitions/int32-matrix
+    items:
+      items:
+        - description: Temperature in milliCelsius
+        - description: ADC read value
+
+required:
+  - compatible
+  - '#thermal-sensor-cells'
+  - io-channels
+  - io-channel-names
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/thermal/thermal.h>
+
+    thermal-sensor {
+        compatible = "generic-adc-thermal";
+        #thermal-sensor-cells = <0>;
+        io-channels = <&ads1015 1>;
+        io-channel-names = "sensor-channel";
+        temperature-lookup-table = <
+              (-40000) 2578
+              (-39000) 2577
+              (-38000) 2576
+              (-37000) 2575
+              (-36000) 2574
+              (-35000) 2573
+              (-34000) 2572
+              (-33000) 2571
+              (-32000) 2569
+              (-31000) 2568
+              (-30000) 2567
+              /* skip */
+              118000 254
+              119000 247
+              120000 240
+              121000 233
+              122000 226
+              123000 220
+              124000 214
+              125000 208>;
+    };
+...
diff --git a/Documentation/devicetree/bindings/thermal/thermal-generic-adc.txt b/Documentation/devicetree/bindings/thermal/thermal-generic-adc.txt
deleted file mode 100644
index e136946a2f4f..000000000000
--- a/Documentation/devicetree/bindings/thermal/thermal-generic-adc.txt
+++ /dev/null
@@ -1,95 +0,0 @@
-General Purpose Analog To Digital Converter (ADC) based thermal sensor.
-
-On some of platforms, thermal sensor like thermistors are connected to
-one of ADC channel and sensor resistance is read via voltage across the
-sensor resistor. The voltage read across the sensor is mapped to
-temperature using voltage-temperature lookup table.
-
-Required properties:
-===================
-- compatible:		     Must be "generic-adc-thermal".
-- #thermal-sensor-cells:     Should be 1. See Documentation/devicetree/bindings/thermal/thermal-sensor.yaml for a description
-		             of this property.
-Optional properties:
-===================
-- temperature-lookup-table:  Two dimensional array of Integer; lookup table
-			     to map the relation between ADC value and
-			     temperature. When ADC is read, the value is
-			     looked up on the table to get the equivalent
-			     temperature.
-
-			     The first value of the each row of array is the
-			     temperature in milliCelsius and second value of
-			     the each row of array is the ADC read value.
-
-			     If not specified, driver assumes the ADC channel
-			     gives milliCelsius directly.
-
-Example :
-#include <dt-bindings/thermal/thermal.h>
-
-i2c@7000c400 {
-	ads1015: ads1015@4a {
-		reg = <0x4a>;
-		compatible = "ads1015";
-		sampling-frequency = <3300>;
-		#io-channel-cells = <1>;
-	};
-};
-
-tboard_thermistor: thermal-sensor {
-	compatible = "generic-adc-thermal";
-	#thermal-sensor-cells = <0>;
-	io-channels = <&ads1015 1>;
-	io-channel-names = "sensor-channel";
-	temperature-lookup-table = <    (-40000) 2578
-					(-39000) 2577
-					(-38000) 2576
-					(-37000) 2575
-					(-36000) 2574
-					(-35000) 2573
-					(-34000) 2572
-					(-33000) 2571
-					(-32000) 2569
-					(-31000) 2568
-					(-30000) 2567
-					::::::::::
-					118000 254
-					119000 247
-					120000 240
-					121000 233
-					122000 226
-					123000 220
-					124000 214
-					125000 208>;
-};
-
-dummy_cool_dev: dummy-cool-dev {
-	compatible = "dummy-cooling-dev";
-	#cooling-cells = <2>; /* min followed by max */
-};
-
-thermal-zones {
-	Tboard {
-		polling-delay = <15000>; /* milliseconds */
-		polling-delay-passive = <0>; /* milliseconds */
-		thermal-sensors = <&tboard_thermistor>;
-
-		trips {
-			therm_est_trip: therm_est_trip {
-				temperature = <40000>;
-				type = "active";
-				hysteresis = <1000>;
-			};
-		};
-
-		cooling-maps {
-			map0 {
-				trip = <&therm_est_trip>;
-				cooling-device = <&dummy_cool_dev THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
-				contribution = <100>;
-			};
-
-		};
-	};
-};
-- 
2.35.1

