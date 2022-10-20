Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B020605A83
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 11:03:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230388AbiJTJDc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 05:03:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230253AbiJTJDY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 05:03:24 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B1B9196EEE;
        Thu, 20 Oct 2022 02:03:20 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id d26so45771219ejc.8;
        Thu, 20 Oct 2022 02:03:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ocaa0fWoUBQts1Nll9hf2RSXba2nGL80I4cFxGD4zfw=;
        b=b5sdQPZBGojRFy+o/RHtPAQUZqYZC9zZt2BeyUz+jmujTlrUCPyYW8SpLQZV8aF0Je
         9pqPPz+93xgkfjLphFpn/KKOX0I02mig0kQDP66M4X4Jk+pYBLpWTzAZh/grAQ+upaI4
         l4slRSpheqrIuXjLa0wGIhq8lmXWCC3+HBOatebsbgLOm9qAD1ckMYSh3zCawT73MxqY
         /iEUeWL4YoME1vUV8edBXg2qdjvJdYpjYGA5pRd49X5lW+3smwaEl/CjAE5VKiMdmFrU
         HMp5v2RfvMyLv5JC9JSERkRYJ8Um9uJLDaMjtEeJrFPzPH7L1YzQGNxQ5E8DEKDkxu2+
         tuWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ocaa0fWoUBQts1Nll9hf2RSXba2nGL80I4cFxGD4zfw=;
        b=0R4dIJ9Vjda55JXeUuX4Y0utb/aK8NJv3yBmQU/rBRCsV9Y2Gbh304pq66wbN2J3Gz
         ZDoueDc0AuXbW2TCPUIE0DPM54v3xceop+lRtFOuGJQ2aWcWV6fO9H9aQ50nAeLsoP3a
         QTTvISyPlMR4cjxvTzfu+ieIdCU6ZbJkH4jJsL8Yl19Q9g9V4VnvHkUNolGKkKVD8WyY
         0bdMQkwFN665b9V8HQErYujVNtcTsL1YPCkICDu/sHpHVbuWl8cuNtnlUECZvZo3aWCV
         kRt0rpJyWeIWH0gCNzckuzl2VHsO075UKjNTDoNoWnXZ30x2gyD9Ig/saEhLwQzj2m6H
         KZGA==
X-Gm-Message-State: ACrzQf3F23B1/H5szu3PkQR0i8xBj58lWOB7nLap6imSMwWWSwcrJVsQ
        RUiVx+mH62DaOjDxcksWQC8=
X-Google-Smtp-Source: AMsMyM7bMHq9D8BSYNSObP2Yv9V+MZrkr3tzLVjRzoojcVfENQgyLd+JaPcs7c//ZdT2ez7sr1XONw==
X-Received: by 2002:a17:907:2e0d:b0:78e:314:9d88 with SMTP id ig13-20020a1709072e0d00b0078e03149d88mr10223826ejc.54.1666256599010;
        Thu, 20 Oct 2022 02:03:19 -0700 (PDT)
Received: from localhost.localdomain ([5.2.194.157])
        by smtp.gmail.com with ESMTPSA id c2-20020a17090618a200b007933047f923sm1668381ejf.118.2022.10.20.02.03.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Oct 2022 02:03:18 -0700 (PDT)
From:   Cosmin Tanislav <demonsingur@gmail.com>
Cc:     =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Cosmin Tanislav <cosmin.tanislav@analog.com>
Subject: [PATCH v2 4/5] dt-bindings: iio: temperature: ltc2983: support more parts
Date:   Thu, 20 Oct 2022 12:02:56 +0300
Message-Id: <20221020090257.1717053-5-demonsingur@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221020090257.1717053-1-demonsingur@gmail.com>
References: <20221020090257.1717053-1-demonsingur@gmail.com>
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
 .../bindings/iio/temperature/adi,ltc2983.yaml | 69 +++++++++++++++++--
 1 file changed, 65 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/temperature/adi,ltc2983.yaml b/Documentation/devicetree/bindings/iio/temperature/adi,ltc2983.yaml
index 3e97ec841fd6..1cb31d896c9a 100644
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
@@ -413,6 +424,44 @@ patternProperties:
             reg:
               minimum: 1
 
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
+    allOf:
+      - if:
+          properties:
+            adi,single-ended:
+              const: true
+        then:
+          properties:
+            reg:
+              minimum: 1
+
   "^rsense@":
     type: object
     description: Sense resistor sensor.
@@ -439,6 +488,18 @@ required:
 
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

