Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2133617D3C
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 14:01:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231655AbiKCNBW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 09:01:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231571AbiKCNBK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 09:01:10 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C00AB11C3B;
        Thu,  3 Nov 2022 06:01:09 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id t25so4959617ejb.8;
        Thu, 03 Nov 2022 06:01:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6jP3J9plPDooyKZLUAyrWRWPPQKz9UGS5zDe2H3qftM=;
        b=qO6z56/TPubFq3qhOmYFRhAs+SaRv1kQLkMq+HgDfKTh5VyAri4rsXd+CJtMZRgWRM
         895YVwl4G/pMDz10OsDrSq8MTXMxYkOsz0fsnWcN9RI+PF5j0lEzOmF+CWp4tgm96Avl
         YM2tblBLoLz/x0N9pkLdravCF13nsKJzTof983sJXxxhWea0cwhFMjgUBlHvhN36y1UJ
         NVoLEFC9gumNCZMN3tcEPZYFjFhMSkJy7ZobPOiVqrD5/m9dWuUPmDTiJgi1jxMwRZZF
         pmPZTRyS2mJ69h49Jz7qsKvKl5liEKobx0GG8DLE62tR2WO4b6sRwGYAwWHn3uCPkMdd
         3c4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6jP3J9plPDooyKZLUAyrWRWPPQKz9UGS5zDe2H3qftM=;
        b=npVd086G3/z8VTUwZSlxyTt/7cTjZQ9sD+ytkirE9Ra0i6Sc/ne8L/Ekg6274IbxTJ
         Sth4veYRIHIrKJguO5+kSKEoHag5BGpEB1UodbM/eV2/C1i9G0x8Jq2ij3IDvInX9NEF
         u7PjALX/roIDRC7zPhL0pX5ttM+Qkes9bJoPZyDc+JmbCgW11dsHTiIeK0atOUHOc4CN
         FJSj6b0fRCAak09hMHclLu+/N0lug2M8aPSlsoj6lMYfvtjACdwP0VojQbD1CBohU0XU
         8LEGC7UddpYoyJywdeEbXE54G/YksQLnFWS3DZWclXGx92dVc4iczZiK6ek4+IIduun/
         g6vg==
X-Gm-Message-State: ACrzQf2xB6loRJrnBQ7Vnj9TFP2ihntrOoMg/Fko+yJTZNGcFwAmzlXr
        fee4U+WborPR1dg99Uxc+WE=
X-Google-Smtp-Source: AMsMyM52gWX8ne0nbzQO6bDlX7crGGYRjfTDGI2xPAQgPqVpQxTxxAW53WyCQG8bG3xJ3F8oE3Y66A==
X-Received: by 2002:a17:907:2c74:b0:7a1:d333:f214 with SMTP id ib20-20020a1709072c7400b007a1d333f214mr29597833ejc.14.1667480468352;
        Thu, 03 Nov 2022 06:01:08 -0700 (PDT)
Received: from localhost.localdomain ([5.2.194.157])
        by smtp.gmail.com with ESMTPSA id q12-20020a17090676cc00b00779a605c777sm451829ejn.192.2022.11.03.06.01.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Nov 2022 06:01:08 -0700 (PDT)
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
Subject: [PATCH v4 02/13] dt-bindings: iio: temperature: ltc2983: add default values
Date:   Thu,  3 Nov 2022 15:00:30 +0200
Message-Id: <20221103130041.2153295-3-demonsingur@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221103130041.2153295-1-demonsingur@gmail.com>
References: <20221103130041.2153295-1-demonsingur@gmail.com>
MIME-Version: 1.0
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

Binding properties should have default values to let the reader
know if they should change it. Add them based on driver logic.

Signed-off-by: Cosmin Tanislav <cosmin.tanislav@analog.com>
---
 .../devicetree/bindings/iio/temperature/adi,ltc2983.yaml | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/temperature/adi,ltc2983.yaml b/Documentation/devicetree/bindings/iio/temperature/adi,ltc2983.yaml
index 722781aa4697..82667adc85b1 100644
--- a/Documentation/devicetree/bindings/iio/temperature/adi,ltc2983.yaml
+++ b/Documentation/devicetree/bindings/iio/temperature/adi,ltc2983.yaml
@@ -34,6 +34,7 @@ properties:
       cases. An extra delay can be configured using this property. The value is
       rounded to nearest 100us.
     maximum: 255
+    default: 0
 
   adi,filter-notch-freq:
     description:
@@ -45,6 +46,7 @@ properties:
     $ref: /schemas/types.yaml#/definitions/uint32
     minimum: 0
     maximum: 2
+    default: 0
 
   '#address-cells':
     const: 1
@@ -104,6 +106,7 @@ patternProperties:
           This property set's the pulsed current value applied during
           open-circuit detect.
         enum: [10, 100, 500, 1000]
+        default: 10
 
       adi,cold-junction-handle:
         description:
@@ -163,6 +166,7 @@ patternProperties:
           cycles, this property will assume different predefined values on
           each cycle. Just set the value of the first cycle (1l).
         enum: [10, 20, 40, 80]
+        default: 10
 
       adi,ideal-factor-value:
         description:
@@ -170,6 +174,7 @@ patternProperties:
           be multiplied by 1000000 to remove the fractional part. For more
           information look at table 20 of the datasheet.
         $ref: /schemas/types.yaml#/definitions/uint32
+        default: 0
 
   "^rtd@":
     type: object
@@ -207,6 +212,7 @@ patternProperties:
           property to 5 means 4 wires with Kelvin Rsense.
         $ref: /schemas/types.yaml#/definitions/uint32
         enum: [2, 3, 4, 5]
+        default: 2
 
       adi,rsense-share:
         description:
@@ -226,6 +232,7 @@ patternProperties:
           This property controls the magnitude of the excitation current
           applied to the RTD.
         enum: [5, 10, 25, 50, 100, 250, 500, 1000]
+        default: 5
 
       adi,rtd-curve:
         description:
@@ -234,6 +241,7 @@ patternProperties:
         $ref: /schemas/types.yaml#/definitions/uint32
         minimum: 0
         maximum: 3
+        default: 0
 
       adi,custom-rtd:
         description:
@@ -308,6 +316,7 @@ patternProperties:
         $ref: /schemas/types.yaml#/definitions/uint32
         enum: [0, 250, 500, 1000, 5000, 10000, 25000, 50000, 100000, 250000,
                500000, 1000000]
+        default: 0
 
       adi,custom-thermistor:
         description:
-- 
2.38.1

