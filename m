Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D96BC5FEE0B
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 14:38:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229972AbiJNMiO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 08:38:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229887AbiJNMiJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 08:38:09 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FE1C181D85;
        Fri, 14 Oct 2022 05:38:08 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id q19so6637536edd.10;
        Fri, 14 Oct 2022 05:38:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oOue6b/tBUVpJACBkl/SKLRZywbGEtbM4CPUrofCxvQ=;
        b=NoK7UUubQgssBL2LUy2GZI6v9wzTst4ZIY7T0pV/j7Pk+uRCxiJrHGc2+0yuMGq12w
         9VUdmUO9ETXR1y550pklE5XcElyuDrNL/4jCJwoGCM4bav8qqiCGGeIK012pFGMwzgvd
         tfZgoRZTSLTBn6pcWqGxxutpOa4KE3nxp3U6WJFjlxc6rtXEB8+UyDLD0Isi/iKbUtUa
         6NLjtNBlqKxn3qBJy58ew20OhfEjESSF/Wbld2FCQHj0KvsOS0migoHzcDcBMfTpeeEr
         ypMKPGxFVuWFPZXOtt+oQnUdHqWjOeNlcYMxm3xcwfQF2j92AF3zKMMR8yCSTeOvHlYe
         FNJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oOue6b/tBUVpJACBkl/SKLRZywbGEtbM4CPUrofCxvQ=;
        b=6zAUddIfiuDAxSgQLUBZfEeX9y7lAIYbP5uEzck85czeb1Y29yoXdQBo/YmyYusGAF
         /5ikf/8GdNdG9su7xvxOwprp7Shll76u7XYjd/earCopwoDxMDgsrPA4H8X9lG5fXje6
         RzmzVa9bai9OAKu/4H1U5jE8l+ilUiPiN5l1kfGVWaszBvs00PhVK/w61SpiBB+dRbFf
         ixogDLbT4C4sR0BnupwSX0kZav+j7bJSlOusVtK/U3XTFI3bI8l8zr2GhLYg2TxTL68F
         VPG7I4bxT1fKQ/t2ThXVFIl4uaRuG54RvdRmKEGf5v6x3cStMtzI9Fx6pZqzpOdzaE+m
         VtTw==
X-Gm-Message-State: ACrzQf0/k6GU8Kr922cII9sS9fbboho8KOT4sTToex+i7JDhDse4H+hA
        ARrIUWx2ZMFLvCdbNh9j2ec=
X-Google-Smtp-Source: AMsMyM4EEFqxtV4JPmULqO61txZ0xeXBSm/9516l0CiWOWvYGvdS1QHHxl+NarQqiHXHHDcYZCZgpA==
X-Received: by 2002:a05:6402:27c8:b0:458:ecf7:7248 with SMTP id c8-20020a05640227c800b00458ecf77248mr4215937ede.67.1665751086788;
        Fri, 14 Oct 2022 05:38:06 -0700 (PDT)
Received: from localhost.localdomain ([5.2.194.157])
        by smtp.gmail.com with ESMTPSA id dk24-20020a0564021d9800b0045b910b0542sm1774756edb.15.2022.10.14.05.38.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Oct 2022 05:38:06 -0700 (PDT)
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
Subject: [PATCH 2/3] dt-bindings: iio: temperature: ltc2983: support more parts
Date:   Fri, 14 Oct 2022 15:37:23 +0300
Message-Id: <20221014123724.1401011-3-demonsingur@gmail.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221014123724.1401011-1-demonsingur@gmail.com>
References: <20221014123724.1401011-1-demonsingur@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
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
 .../bindings/iio/temperature/adi,ltc2983.yaml | 63 +++++++++++++++++--
 1 file changed, 59 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/temperature/adi,ltc2983.yaml b/Documentation/devicetree/bindings/iio/temperature/adi,ltc2983.yaml
index 722781aa4697..c33ab524fb64 100644
--- a/Documentation/devicetree/bindings/iio/temperature/adi,ltc2983.yaml
+++ b/Documentation/devicetree/bindings/iio/temperature/adi,ltc2983.yaml
@@ -4,19 +4,27 @@
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
     enum:
       - adi,ltc2983
+      - adi,ltc2984
+      - adi,ltc2986
+      - adi,ltm2985
 
   reg:
     maxItems: 1
@@ -26,7 +34,7 @@ properties:
 
   adi,mux-delay-config-us:
     description:
-      The LTC2983 performs 2 or 3 internal conversion cycles per temperature
+      The device performs 2 or 3 internal conversion cycles per temperature
       result. Each conversion cycle is performed with different excitation and
       input multiplexer configurations. Prior to each conversion, these
       excitation circuits and input switch configurations are changed and an
@@ -145,7 +153,7 @@ patternProperties:
       adi,three-conversion-cycles:
         description:
           Boolean property which set's three conversion cycles removing
-          parasitic resistance effects between the LTC2983 and the diode.
+          parasitic resistance effects between the device and the diode.
         type: boolean
 
       adi,average-on:
@@ -353,6 +361,41 @@ patternProperties:
         description: Boolean property which set's the adc as single-ended.
         type: boolean
 
+  "^temp@":
+    type: object
+    description:
+      Represents a channel which is being used as an active analog temperature
+      sensor.
+
+    properties:
+      adi,sensor-type:
+        description:
+          Identifies the sensor as an active analog temperature sensor.
+        $ref: /schemas/types.yaml#/definitions/uint32
+        const: 31
+
+      adi,single-ended:
+        description: Boolean property which sets the sensor as single-ended.
+        type: boolean
+
+      adi,custom-temp:
+        description:
+          This is a table, where each entry should be a pair of
+          voltage(mv)-temperature(K). The entries must be given in nv and uK
+          so that, the original values must be multiplied by 1000000. For
+          more details look at table 71 and 72.
+          Note should be signed, but dtc doesn't currently maintain the
+          sign.
+        $ref: /schemas/types.yaml#/definitions/uint64-matrix
+        minItems: 3
+        maxItems: 64
+        items:
+          minItems: 2
+          maxItems: 2
+
+    required:
+      - adi,custom-temp
+
   "^rsense@":
     type: object
     description:
@@ -382,6 +425,18 @@ required:
   - reg
   - interrupts
 
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
 additionalProperties: false
 
 examples:
-- 
2.37.3

