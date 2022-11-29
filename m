Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59BAE63C200
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 15:11:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235241AbiK2OK4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 09:10:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235314AbiK2OKS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 09:10:18 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44A3D5F858;
        Tue, 29 Nov 2022 06:10:16 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id p24so9764919plw.1;
        Tue, 29 Nov 2022 06:10:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cAmdPwxeV/gmwrZFUCjIqIdjxeWkPmcTFRtF8kijtD8=;
        b=L7E15i11LH899DwPT2jWyRY3zYfaCL5kCTEOkOHF0KRRPmojCmCpjHYU0ij1jOoREh
         q1w59KBmdEeCojMFJMg/I5mIS3/GMf4aaPt5TP37JPS0P+rbnzo22kaLJ3HnYSbVWi2g
         Juyhf8scAkjX4v/jgRKs8jBBuBxwPBQjuimrjS3YXCCbJ7MJ6aSLAXPYLhZogxdBUiBX
         Se1lJ5RMM8dzBwFSgsy7GS3arDKWTU9G7hEq5sGlq8KFAilP6KHgV8nLUN+iujHcniK4
         txiYMY5o4efzDHnECBIWCeiQzOHg7sEBK5u4n11HbOLRgRAXAdlgyrdc/QqOBj6OUsRm
         +ufg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cAmdPwxeV/gmwrZFUCjIqIdjxeWkPmcTFRtF8kijtD8=;
        b=kRn1M0yCVD+KwCXO9D1BzvnwcOl1qWhAx+7kbzyrU2XPlTCPZOx+taGrWYHs0J2W7V
         A5dNLjugKWIf903vDx6eUw2BBJGzlHy0MrrQeWTPxeBbR9+MVUoJ08r6WmaoHLmGcKoW
         XgA9xAHOcDIf5RVtO7+42yZlOZbOez66t/ud5QW6eosmBWRuk+wfh2RuKEePakSJkdPK
         bE72LLHkiXgBrz4NFh2rbrzB5UuI2JwUqnyOppW+aR4muVbxafcLFJAm8cZ+Ff275om/
         7UvCfqK7SwjIEXa1srkAF3i4e0kpiYi7ke7V6/P5tzdI7XGPsFgLH9X5uOOMiAckAhsl
         bGig==
X-Gm-Message-State: ANoB5plsLCBr+zw0Hr6k372DsST9PYY++HXsoUKB/YSeSaEpBBep+3iw
        rgr1wSqrZDthw0FTr7n6D4DQvJHq9nc=
X-Google-Smtp-Source: AA0mqf5mVohJJr822gYGrE1q5vJhKvIkHt3GESFsGio1KQfQLRdc+Ed2Lq7KrobYE4dh5F0tQbtnhQ==
X-Received: by 2002:a17:90b:3d0d:b0:1fd:5b5d:f09d with SMTP id pt13-20020a17090b3d0d00b001fd5b5df09dmr60832901pjb.69.1669731015551;
        Tue, 29 Nov 2022 06:10:15 -0800 (PST)
Received: from guoguo-omen.scut.edu.cn ([2401:c080:1400:4da2:5400:3ff:feb4:7578])
        by smtp.gmail.com with ESMTPSA id a5-20020a170902710500b0017854cee6ebsm10932342pll.72.2022.11.29.06.10.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Nov 2022 06:10:15 -0800 (PST)
From:   Chuanhong Guo <gch981213@gmail.com>
To:     linux-leds@vger.kernel.org
Cc:     Chuanhong Guo <gch981213@gmail.com>, Pavel Machek <pavel@ucw.cz>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Stanislav Jakubek <stano.jakubek@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Johan Hovold <johan+linaro@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Sven Schwermer <sven.schwermer@disruptive-technologies.com>,
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 2/3] dt-bindings: leds: add dt schema for worldsemi,ws2812b-spi
Date:   Tue, 29 Nov 2022 22:09:54 +0800
Message-Id: <20221129140955.137361-3-gch981213@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221129140955.137361-1-gch981213@gmail.com>
References: <20221129140955.137361-1-gch981213@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds dt binding schema for WorldSemi WS2812B driven using SPI
bus.

Signed-off-by: Chuanhong Guo <gch981213@gmail.com>
---
 .../bindings/leds/worldsemi,ws2812b-spi.yaml  | 131 ++++++++++++++++++
 1 file changed, 131 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/leds/worldsemi,ws2812b-spi.yaml

diff --git a/Documentation/devicetree/bindings/leds/worldsemi,ws2812b-spi.yaml b/Documentation/devicetree/bindings/leds/worldsemi,ws2812b-spi.yaml
new file mode 100644
index 000000000000..8544bde4f261
--- /dev/null
+++ b/Documentation/devicetree/bindings/leds/worldsemi,ws2812b-spi.yaml
@@ -0,0 +1,131 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/leds/worldsemi,ws2812b-spi.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: WS2812B LEDs driven using SPI
+
+maintainers:
+  - Chuanhong Guo <gch981213@gmail.com>
+
+description: |
+  WorldSemi WS2812B is a individually addressable LED chip that can be chained
+  together and controlled individually using a single wire.
+  This driver simulates the protocol used by this LED chip with SPI bus.
+  Typical setups includes connecting the data pin of the LED chain to MOSI as
+  the only device or using CS and MOSI with a tri-state voltage-level shifter
+  for the data pin.
+  The SPI frequency needs to be 2.105MHz~2.85MHz for the timing to be correct
+  and the controller needs to send all the bytes continuously.
+
+allOf:
+  - $ref: /schemas/spi/spi-peripheral-props.yaml#
+
+properties:
+  compatible:
+    const: worldsemi,ws2812b-spi
+
+  reg:
+    description: The chip-select line on the SPI bus
+    maxItems: 1
+
+  spi-max-frequency:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      Maximum SPI clocking speed of the device in Hz.
+    minimum: 2105000
+    maximum: 2850000
+
+  "#address-cells":
+    const: 1
+
+  "#size-cells":
+    const: 0
+
+patternProperties:
+  "^multi-led(@[0-9a-f])?$":
+    type: object
+    $ref: leds-class-multicolor.yaml#
+
+    properties:
+      color-index:
+        description: |
+          A 3-item array specifying color of each components in this LED. It
+          should be one of the LED_COLOR_ID_* prefixed definitions from the
+          header include/dt-bindings/leds/common.h. Defaults to
+          <LED_COLOR_ID_GREEN LED_COLOR_ID_RED LED_COLOR_ID_BLUE>
+          if unspecified.
+        $ref: /schemas/types.yaml#/definitions/uint32-array
+        minItems: 3
+        maxItems: 3
+
+      default-intensity:
+        description: |
+          An array of 3 integer specifying the default intensity of each color
+          components in this LED. <255 255 255> if unspecified.
+        $ref: /schemas/types.yaml#/definitions/uint32-array
+        minItems: 3
+        maxItems: 3
+        items:
+          minimum: 0
+          maximum: 255
+
+      reg:
+        description: |
+          Which LED this node represents. The reg of the first LED on the chain
+          is 0.
+
+    required:
+      - reg
+      - color
+      - function
+
+required:
+  - compatible
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/leds/common.h>
+    spi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        ws2812b@0 {
+            #address-cells = <1>;
+            #size-cells = <0>;
+            compatible = "worldsemi,ws2812b-spi";
+            reg = <0>;
+            spi-max-frequency = <2850000>;
+            multi-led@0 {
+                reg = <0>;
+                color-index = <LED_COLOR_ID_RED LED_COLOR_ID_GREEN LED_COLOR_ID_BLUE>;
+                default-intensity = <10 50 90>;
+                color = <LED_COLOR_ID_RGB>;
+                function = LED_FUNCTION_STATUS;
+                function-enumerator = <0>;
+            };
+            multi-led@1 {
+                reg = <1>;
+                color = <LED_COLOR_ID_RGB>;
+                function = LED_FUNCTION_STATUS;
+                function-enumerator = <1>;
+            };
+            multi-led@2 {
+                reg = <2>;
+                color = <LED_COLOR_ID_RGB>;
+                function = LED_FUNCTION_STATUS;
+                function-enumerator = <2>;
+            };
+            multi-led@3 {
+                reg = <3>;
+                color = <LED_COLOR_ID_RGB>;
+                function = LED_FUNCTION_STATUS;
+                function-enumerator = <3>;
+            };
+        };
+    };
+
+...
-- 
2.38.1

