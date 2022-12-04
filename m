Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91913641C67
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Dec 2022 11:43:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230174AbiLDKnj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Dec 2022 05:43:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230160AbiLDKne (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Dec 2022 05:43:34 -0500
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10A19F037
        for <linux-kernel@vger.kernel.org>; Sun,  4 Dec 2022 02:43:32 -0800 (PST)
Received: by mail-lj1-x235.google.com with SMTP id b9so10380558ljr.5
        for <linux-kernel@vger.kernel.org>; Sun, 04 Dec 2022 02:43:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wKxfJBtE9R/RmkSFqJuCs7AeQseJPQiGfkmXFgO8eRE=;
        b=NygHRy+2Rq2KEujc0x//tVDRPbwYxxkTgX0T8P3Q/v5z3iW/dLE0/BDRYVBawgtseE
         eL4FgeKIuUuY2tGMaqMlw9fZdNPZZt5ePgAH/Eto9xbh3DkxYud33xSJB0mbnxefpfGU
         sGu/ZcKSq53vZmHeg6kuu/+i8rdk4dLzICM3EF49ab4hc6THSqcTNkFoACIedqh2yyA8
         PvQul1RCxyko/hakFADrfzbTHb2my/63HUGLIpbG9/gKzhCn5WlkxUs9yQnDmxWE4cq6
         0qJqpG35dZ8ctNqOCwJ81nwzpUanTauxvBV9obWzs3HI++tIB48tCyzp5VkEWowh4pKF
         zfxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wKxfJBtE9R/RmkSFqJuCs7AeQseJPQiGfkmXFgO8eRE=;
        b=clRW+bQcjbHcNsKNHtqJ+cP4xnzaFyNiFvhvWfNOncWoRPvR9huxVBablr0QDmnybD
         1e2+FL/Wj2nwVUX171lASeDemcXuRozI950BAP7QiuRN5plm0E5KQe7kRQKX+78eyaCT
         mLRA3UG77yX7EBghbVK1o2n9yKQj7AWqRbfgegSErkN65c/68w4PmZbBG2sS33nBLVme
         ABCfxHuyagcHmhyNrCI5RonMwUIn2PpuBKhpWXVwlklUSqkVS1Qd+UnLs+UCnZn5ySiT
         x1Iqjeiy/+O8Suqy4nII6ZFoi83grWZQMZ6tfMaD/LA7Y99LN3CVeS1Ch0d0i+NayAWt
         5E2w==
X-Gm-Message-State: ANoB5pmWqhJY+7QlktHqZ91jpO3EptXzCQrmR05t3PdQ4BPGV4MJU8du
        6+wdCpD5+0QbVZVRYqw4NpXjneVEzUikSuKcODU=
X-Google-Smtp-Source: AA0mqf7rV6MT2d/H87OYhumdmZsVNt9zVAycKUBv1fuw5Ut5PGBgkF6tBZoRJNoqMP/K0QgxgJWjMg==
X-Received: by 2002:a05:651c:1187:b0:279:d72d:215e with SMTP id w7-20020a05651c118700b00279d72d215emr3750216ljo.184.1670150611194;
        Sun, 04 Dec 2022 02:43:31 -0800 (PST)
Received: from krzk-bin.NAT.warszawa.vectranet.pl (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id w13-20020a05651c118d00b0026c42f67eb8sm893318ljo.7.2022.12.04.02.43.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Dec 2022 02:43:30 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Sean Young <sean@mess.org>, linux-leds@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 3/3] dt-bindings: leds: irled: ir-spi-led: convert to DT schema
Date:   Sun,  4 Dec 2022 11:43:23 +0100
Message-Id: <20221204104323.117974-3-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221204104323.117974-1-krzysztof.kozlowski@linaro.org>
References: <20221204104323.117974-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the SPI IR LED bindings to DT schema.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../bindings/leds/irled/ir-spi-led.yaml       | 61 +++++++++++++++++++
 .../bindings/leds/irled/spi-ir-led.txt        | 29 ---------
 2 files changed, 61 insertions(+), 29 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/leds/irled/ir-spi-led.yaml
 delete mode 100644 Documentation/devicetree/bindings/leds/irled/spi-ir-led.txt

diff --git a/Documentation/devicetree/bindings/leds/irled/ir-spi-led.yaml b/Documentation/devicetree/bindings/leds/irled/ir-spi-led.yaml
new file mode 100644
index 000000000000..72cadebf6e3e
--- /dev/null
+++ b/Documentation/devicetree/bindings/leds/irled/ir-spi-led.yaml
@@ -0,0 +1,61 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/leds/irled/ir-spi-led.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: IR LED connected through SPI bus
+
+maintainers:
+  - Sean Young <sean@mess.org>
+
+description:
+  IR LED switch is connected to the MOSI line of the SPI device and the data
+  is delivered through that.
+
+allOf:
+  - $ref: /schemas/spi/spi-peripheral-props.yaml#
+
+properties:
+  compatible:
+    const: ir-spi-led
+
+  reg:
+    maxItems: 1
+
+  duty-cycle:
+    $ref: /schemas/types.yaml#/definitions/uint8
+    enum: [50, 60, 70, 75, 80, 90]
+    description:
+      Percentage of one period in which the signal is active.
+
+  led-active-low:
+    type: boolean
+    description:
+      Output is negated with a NOT gate.
+
+  power-supply: true
+
+required:
+  - compatible
+  - reg
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    spi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        irled@0 {
+            compatible = "ir-spi-led";
+            reg = <0x0>;
+
+            duty-cycle = /bits/ 8 <60>;
+            led-active-low;
+            power-supply = <&irda_regulator>;
+            spi-max-frequency = <5000000>;
+        };
+    };
+
diff --git a/Documentation/devicetree/bindings/leds/irled/spi-ir-led.txt b/Documentation/devicetree/bindings/leds/irled/spi-ir-led.txt
deleted file mode 100644
index 83ff1b4d70a6..000000000000
--- a/Documentation/devicetree/bindings/leds/irled/spi-ir-led.txt
+++ /dev/null
@@ -1,29 +0,0 @@
-Device tree bindings for IR LED connected through SPI bus which is used as
-remote controller.
-
-The IR LED switch is connected to the MOSI line of the SPI device and the data
-are delivered thourgh that.
-
-Required properties:
-	- compatible: should be "ir-spi-led".
-
-Optional properties:
-	- duty-cycle: 8 bit value that represents the percentage of one period
-	  in which the signal is active.  It can be 50, 60, 70, 75, 80 or 90.
-	- led-active-low: boolean value that specifies whether the output is
-	  negated with a NOT gate.
-	- power-supply: specifies the power source. It can either be a regulator
-	  or a gpio which enables a regulator, i.e. a regulator-fixed as
-	  described in
-	  Documentation/devicetree/bindings/regulator/fixed-regulator.yaml
-
-Example:
-
-	irled@0 {
-		compatible = "ir-spi-led";
-		reg = <0x0>;
-		spi-max-frequency = <5000000>;
-		power-supply = <&vdd_led>;
-		led-active-low;
-		duty-cycle = /bits/ 8 <60>;
-	};
-- 
2.34.1

