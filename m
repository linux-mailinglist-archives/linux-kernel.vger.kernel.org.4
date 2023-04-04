Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2406D6D6E64
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 22:50:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236329AbjDDUuV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 16:50:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232313AbjDDUuT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 16:50:19 -0400
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0F90AC;
        Tue,  4 Apr 2023 13:50:18 -0700 (PDT)
Received: by mail-oi1-f180.google.com with SMTP id b19so25205964oib.7;
        Tue, 04 Apr 2023 13:50:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680641418;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cuM6Q6XsNQriUPvaV/azpo/EuSP1O+QRacD+aarjr5s=;
        b=hg5IOD7kVdbQk8PCjZo82JdaXood30U6qlXNNj4ihEJbm60k14VWdgHkcOgnNxgf9G
         8sKY+aA8UBhAh+F3pOhE4sKpu11Ahsmj5gMqKzdzGI+p19n+U2ekCkGL1iKvVBo2edD2
         G0bnqr5NNBMErWh9giSzboc876fjPTs9UDoGrl85mgMgFEyWmQlzKfRbCBSVmnRstnBI
         Vr/baQ/ZmxxHm7xDtGCqoz7OGuzQNVdBmAnVREPHT7otrGNDBRID07vbEuQwsCxWQXCU
         tlb/OKjHO0l18gSIEoUBnowJIbiu7oNkayvNnFY1UELFgBRxaCTbbi23cKO5hDBloIcH
         djSg==
X-Gm-Message-State: AAQBX9fCsln2eTfqfWWlKn7hRVfgcVMzd5zGlFlRae1i0SmXsG2Z5OjG
        S2PSpkQHKNJH/Ryv3nm474A1+OTBBg==
X-Google-Smtp-Source: AKy350avONUpmrgeg1TMxpSIXnQKKstOT4RgBKsLEkLEaYzGD2/sfVJtO7hTe4RmMvzhMwWBTuyO+w==
X-Received: by 2002:a05:6808:23c9:b0:386:94f0:cb27 with SMTP id bq9-20020a05680823c900b0038694f0cb27mr2960463oib.39.1680641417982;
        Tue, 04 Apr 2023 13:50:17 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id z184-20020a4a49c1000000b005252d376caesm5930652ooa.22.2023.04.04.13.50.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Apr 2023 13:50:17 -0700 (PDT)
Received: (nullmailer pid 644399 invoked by uid 1000);
        Tue, 04 Apr 2023 20:50:16 -0000
From:   Rob Herring <robh@kernel.org>
To:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] dt-bindings: iio: temperature: ltc2983: Fix child node unevaluated properties
Date:   Tue,  4 Apr 2023 15:50:13 -0500
Message-Id: <20230404205014.644336-1-robh@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.7 required=5.0 tests=FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The child node schemas are missing 'unevaluatedProperties' constraints,
so any unknown properties are allowed. The current structure with
multiple patternProperties schemas doesn't work for
unevaluatedProperties as each sub-schema is evaluated independently. To
fix this, move the sub-schema for all child nodes to a $defs entry and
reference it from each named child node.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 .../bindings/iio/temperature/adi,ltc2983.yaml | 65 +++++++++++--------
 1 file changed, 38 insertions(+), 27 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/temperature/adi,ltc2983.yaml b/Documentation/devicetree/bindings/iio/temperature/adi,ltc2983.yaml
index f44fc32ce87e..e04f961ab92c 100644
--- a/Documentation/devicetree/bindings/iio/temperature/adi,ltc2983.yaml
+++ b/Documentation/devicetree/bindings/iio/temperature/adi,ltc2983.yaml
@@ -18,6 +18,28 @@ description: |
   https://www.analog.com/media/en/technical-documentation/data-sheets/29861fa.pdf
   https://www.analog.com/media/en/technical-documentation/data-sheets/ltm2985.pdf
 
+$defs:
+  sensor-node:
+    type: object
+    description: Sensor node common constraints
+
+    properties:
+      reg:
+        description:
+          Channel number. Connects the sensor to the channel with this number
+          of the device.
+        minimum: 1
+        maximum: 20
+
+      adi,sensor-type:
+        description: Type of sensor connected to the device.
+        $ref: /schemas/types.yaml#/definitions/uint32
+
+    required:
+      - reg
+      - adi,sensor-type
+
+
 properties:
   compatible:
     oneOf:
@@ -64,28 +86,10 @@ properties:
     const: 0
 
 patternProperties:
-  "@([0-9a-f]+)$":
-    type: object
-    description: Sensor.
-
-    properties:
-      reg:
-        description:
-          Channel number. Connects the sensor to the channel with this number
-          of the device.
-        minimum: 1
-        maximum: 20
-
-      adi,sensor-type:
-        description: Type of sensor connected to the device.
-        $ref: /schemas/types.yaml#/definitions/uint32
-
-    required:
-      - reg
-      - adi,sensor-type
-
   "^thermocouple@":
-    type: object
+    $ref: '#/$defs/sensor-node'
+    unevaluatedProperties: false
+
     description: Thermocouple sensor.
 
     properties:
@@ -141,7 +145,9 @@ patternProperties:
             - adi,custom-thermocouple
 
   "^diode@":
-    type: object
+    $ref: '#/$defs/sensor-node'
+    unevaluatedProperties: false
+
     description: Diode sensor.
 
     properties:
@@ -184,7 +190,8 @@ patternProperties:
         default: 0
 
   "^rtd@":
-    type: object
+    $ref: '#/$defs/sensor-node'
+    unevaluatedProperties: false
     description: RTD sensor.
 
     properties:
@@ -282,7 +289,8 @@ patternProperties:
             - adi,custom-rtd
 
   "^thermistor@":
-    type: object
+    $ref: '#/$defs/sensor-node'
+    unevaluatedProperties: false
     description: Thermistor sensor.
 
     properties:
@@ -383,7 +391,8 @@ patternProperties:
             - adi,custom-thermistor
 
   "^adc@":
-    type: object
+    $ref: '#/$defs/sensor-node'
+    unevaluatedProperties: false
     description: Direct ADC sensor.
 
     properties:
@@ -397,7 +406,8 @@ patternProperties:
         type: boolean
 
   "^temp@":
-    type: object
+    $ref: '#/$defs/sensor-node'
+    unevaluatedProperties: false
     description: Active analog temperature sensor.
 
     properties:
@@ -426,7 +436,8 @@ patternProperties:
       - adi,custom-temp
 
   "^rsense@":
-    type: object
+    $ref: '#/$defs/sensor-node'
+    unevaluatedProperties: false
     description: Sense resistor sensor.
 
     properties:
-- 
2.39.2

