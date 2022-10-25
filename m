Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5781860C63F
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 10:19:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232195AbiJYITR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 04:19:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232155AbiJYITB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 04:19:01 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B2B0C34EC;
        Tue, 25 Oct 2022 01:19:00 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id 13so10594240ejn.3;
        Tue, 25 Oct 2022 01:19:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oV6G9nTvr1w3GpejNf86DyCpCwFqN6NkmZKLRhHZTmw=;
        b=UECeuirkGvTT1ScwcMhqSKOoInm8r3nxRZF7xE8tc4KXtrOgqLmnO74yFQrbSwBlTZ
         oUp66VkAOh9gskxKGal5r6djYENy40sZ5y57zclod/lwn0t9Q8D692hi8lba+3NQiYFX
         o9szeTb6hcemL8VlaeO+CTEfY+BjXo5hg0XLsGdIM0b3v9Bj/PNsQ5kqFyJrGnq9hi1F
         wjdpxSY5PbMTIa/2RGlk84M5c2j41uKrsv1NPp94nSkg61csT+izcNw5JRiuc4aTMUIj
         ywl2BFmrN4kcZKDSc1uMvrwX7W1M+NNZKU+Lcp1xxyqfLzqSYQLXRF+lG3iqr4KNe6or
         eAnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oV6G9nTvr1w3GpejNf86DyCpCwFqN6NkmZKLRhHZTmw=;
        b=GKGA4KQIaqTzF53RjBes7G7uhyKeVMIdUxmA9YkWvZ3Yjh5ni2293r34xxSW6qHTa+
         7hda2Up3J73S/o51hI1Vov/gLhHsqamQD758yk/RsDMp22uYjc24mm8Bqg8CiK8MME1v
         jyGPp8oH/Zb5XkGIk87a2rJilHRJg/yS+8MxALzjnewB4h5P6XEPRyt3hfZhxJ2iezUy
         wbAfec2YSJbhENBPKTr8fDQ5tlInEth9+qEfOgia0aaTJhL3jxo0J/DoSx6wysFVeFNK
         vN/CBfyrKcmbPlm14e/a2X2k2WZyYntV6xD23IppxZknPVk1GBW+dekl34nbYfUYvb5O
         G1dw==
X-Gm-Message-State: ACrzQf1NxJUpEKc/9BpKBSWBInqwbj/GRQLr6BcqOwYUVMYTJQKYvkmb
        wc8w7asV8ULdaT4iSdqFk7c=
X-Google-Smtp-Source: AMsMyM7E9pP59QlMnCjWnIBp8/Ts8Kyfqo2enLJckE+MWTODJANzSkTSUsxgU2foq5HcZWAeqa6uCg==
X-Received: by 2002:a17:907:3ea4:b0:78e:25e2:c33b with SMTP id hs36-20020a1709073ea400b0078e25e2c33bmr30116735ejc.603.1666685939182;
        Tue, 25 Oct 2022 01:18:59 -0700 (PDT)
Received: from localhost.localdomain ([5.2.194.157])
        by smtp.gmail.com with ESMTPSA id l1-20020a1709060cc100b007822196378asm992898ejh.176.2022.10.25.01.18.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Oct 2022 01:18:58 -0700 (PDT)
From:   Cosmin Tanislav <demonsingur@gmail.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Cosmin Tanislav <cosmin.tanislav@analog.com>
Subject: [PATCH v3 3/4] dt-bindings: iio: temperature: ltc2983: support more parts
Date:   Tue, 25 Oct 2022 11:18:41 +0300
Message-Id: <20221025081842.1896748-4-demonsingur@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221025081842.1896748-1-demonsingur@gmail.com>
References: <20221025081842.1896748-1-demonsingur@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Cosmin Tanislav <cosmin.tanislav@analog.com>

Add support for the following parts:
 * LTC2984
 * LTC2986
 * LTM2985

The LTC2984 is a variant of the LTC2983 with EEPROM.
The LTC2986 is a variant of the LTC2983 with only 10 channels,
EEPROM and support for active analog temperature sensors.
The LTM2985 is software-compatible with the LTC2986.

Signed-off-by: Cosmin Tanislav <cosmin.tanislav@analog.com>
---
 .../bindings/iio/temperature/adi,ltc2983.yaml | 59 +++++++++++++++++--
 1 file changed, 55 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/temperature/adi,ltc2983.yaml b/Documentation/devicetree/bindings/iio/temperature/adi,ltc2983.yaml
index a878fd84636f..5380a3b4e508 100644
--- a/Documentation/devicetree/bindings/iio/temperature/adi,ltc2983.yaml
+++ b/Documentation/devicetree/bindings/iio/temperature/adi,ltc2983.yaml
@@ -4,19 +4,30 @@
 $id: http://devicetree.org/schemas/iio/temperature/adi,ltc2983.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: Analog Devices LTC2983 Multi-sensor Temperature system
+title: Analog Devices LTC2983, LTC2986, LTM2985 Multi-sensor Temperature system
 
 maintainers:
   - Nuno Sá <nuno.sa@analog.com>
 
 description: |
-  Analog Devices LTC2983 Multi-Sensor Digital Temperature Measurement System
+  Analog Devices LTC2983, LTC2984, LTC2986, LTM2985 Multi-Sensor Digital
+  Temperature Measurement Systems
+
   https://www.analog.com/media/en/technical-documentation/data-sheets/2983fc.pdf
+  https://www.analog.com/media/en/technical-documentation/data-sheets/2984fb.pdf
+  https://www.analog.com/media/en/technical-documentation/data-sheets/29861fa.pdf
+  https://www.analog.com/media/en/technical-documentation/data-sheets/ltm2985.pdf
 
 properties:
   compatible:
-    enum:
-      - adi,ltc2983
+    oneOf:
+      - enum:
+          - adi,ltc2983
+          - adi,ltc2986
+          - adi,ltm2985
+      - items:
+          - const: adi,ltc2984
+          - const: adi,ltc2983
 
   reg:
     maxItems: 1
@@ -376,6 +387,34 @@ patternProperties:
         description: Whether the sensor is single-ended.
         type: boolean
 
+  "^temp@":
+    type: object
+    description: Active analog temperature sensor.
+    properties:
+      adi,sensor-type:
+        description: Sensor type for active analog temperature sensors.
+        $ref: /schemas/types.yaml#/definitions/uint32
+        const: 31
+
+      adi,single-ended:
+        description: Whether the sensor is single-ended.
+        type: boolean
+
+      adi,custom-temp:
+        description:
+          Used for digitizing active analog temperature sensors.
+          See Page 67 of the LTM2985 datasheet.
+        $ref: /schemas/types.yaml#/definitions/uint64-matrix
+        minItems: 3
+        maxItems: 64
+        items:
+          items:
+            - description: Voltage point in nV, signed.
+            - description: Temperature point in uK.
+
+    required:
+      - adi,custom-temp
+
   "^rsense@":
     type: object
     description: Sense resistor sensor.
@@ -402,6 +441,18 @@ required:
 
 additionalProperties: false
 
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - adi,ltc2983
+              - adi,ltc2984
+    then:
+      patternProperties:
+        "^temp@": false
+
 examples:
   - |
     #include <dt-bindings/interrupt-controller/irq.h>
-- 
2.38.1

