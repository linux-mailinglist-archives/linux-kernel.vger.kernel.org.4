Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 823646452E4
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 05:09:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229763AbiLGEJu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 23:09:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229739AbiLGEJ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 23:09:28 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCF4855CA6;
        Tue,  6 Dec 2022 20:09:27 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id o1-20020a17090a678100b00219cf69e5f0so323842pjj.2;
        Tue, 06 Dec 2022 20:09:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WvITMhNpp4wujSvPRq6ryQwFJeNS/vlhuHNThznnYLU=;
        b=MHmfwFJ0pE/Vk4vLr87jCFtCAyGGQ4TxNVnmlPInCdeSMqymmGH15rEa2gbb5NAW8J
         8nZ5su+fZZOLrN7lMTvbbzOME0/b8kWfqBJ7oIMK5v1q46sZir8vYa8plMEXx6iah7yj
         adC8ySSv1J6Mg0TmzjzG/ElX0KgHc2xSacRWznyy1nggn9srdTB7i23T5hMhWYgkS7og
         lN30qj9nXJjYH0EjvPdenjFGgJI82Ax2SkZOzR19tMZa7uGaQFUT8gAxe2xaAZ57DWnx
         gBdVlgaukRnxO4vxpolWSEwtCOLCNmmgyMRKBU60Sd94WQ9kQZ/tfgo2xx+jMgyJlmGi
         2VEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WvITMhNpp4wujSvPRq6ryQwFJeNS/vlhuHNThznnYLU=;
        b=rC1/DZFqpNevw5aWtAghTRRR0PTElICPyVY0r5idHPjc62Kz/g0jf140+iDZ0sMBIa
         r5qyZEw8Tfp3UoKLGXKTIA/Brog7NQwaGS8Asy3L5afPR0djnIGm+GhjuaGk/JwPyOWI
         TMqIetN3pQukGwvfFTf9hfH5oDr0GiAH9aeerEZ/wUh2DQxFtOV48o7Flsl/wI0ujoNc
         Bp+8HCRNRF0JVwXY6eNKdZSApe0pDZqPg4B1xQAs02WMRhgZeyw5njFjYAlyvzoaIX5i
         9J6oaIwySN+B33ZzN0kdtSz4e3QnieUTB9IGBBgBxbVx36niVz1rlmmuE3Bg8LP2Er34
         y2fg==
X-Gm-Message-State: ANoB5plWNfxD5HKKCQA9oxLKCZyzwqwel8hms0hkSh5BYWHIjx05VDbt
        yh0W6ToRETMhtkNNS6QXn3XAQM0ms/c=
X-Google-Smtp-Source: AA0mqf6cooC0fTglps51eHe3Rr73O9nXDOruiYZbI5c7SeLnr/FicWyeStJ2jBGDspyWTo+QOOx1JA==
X-Received: by 2002:a17:902:bf06:b0:188:5688:828b with SMTP id bi6-20020a170902bf0600b001885688828bmr78880981plb.129.1670386167146;
        Tue, 06 Dec 2022 20:09:27 -0800 (PST)
Received: from guoguo-omen.lan ([2401:c080:1400:4da2:5400:3ff:feb4:7578])
        by smtp.gmail.com with ESMTPSA id i15-20020a63130f000000b00478eb777d18sm587822pgl.72.2022.12.06.20.09.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Dec 2022 20:09:26 -0800 (PST)
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
Subject: [PATCH v3 2/3] dt-bindings: leds: add dt schema for worldsemi,ws2812b
Date:   Wed,  7 Dec 2022 12:09:03 +0800
Message-Id: <20221207040904.582585-3-gch981213@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221207040904.582585-1-gch981213@gmail.com>
References: <20221207040904.582585-1-gch981213@gmail.com>
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

Add dt binding schema for WorldSemi WS2812B driven using SPI
bus.

Signed-off-by: Chuanhong Guo <gch981213@gmail.com>
---
Changes since v1:
remove linux driver reference from description
remove some obvious descriptions
fix unit address regex in multi-led property
drop various minItems
add maxItems = 1 to reg
fix node names and property orders in binding example
drop -spi from compatible string
add default-brightness

Change since v2:
drop "this patch" from commit message
rename leds to led-controller
drop default-brightness and default-intensity

 .../bindings/leds/worldsemi,ws2812b.yaml      | 116 ++++++++++++++++++
 1 file changed, 116 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/leds/worldsemi,ws2812b.yaml

diff --git a/Documentation/devicetree/bindings/leds/worldsemi,ws2812b.yaml b/Documentation/devicetree/bindings/leds/worldsemi,ws2812b.yaml
new file mode 100644
index 000000000000..548c05ac3d31
--- /dev/null
+++ b/Documentation/devicetree/bindings/leds/worldsemi,ws2812b.yaml
@@ -0,0 +1,116 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/leds/worldsemi,ws2812b.yaml#
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
+  This binding describes a chain of WS2812B LEDs connected to the SPI MOSI pin.
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
+    const: worldsemi,ws2812b
+
+  reg:
+    maxItems: 1
+
+  spi-max-frequency:
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
+  "^multi-led@[0-9a-f]+$":
+    type: object
+    $ref: leds-class-multicolor.yaml#
+    unevaluatedProperties: false
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
+        maxItems: 3
+
+      reg:
+        description: |
+          Which LED this node represents. The reg of the first LED on the chain
+          is 0.
+        maxItems: 1
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
+        led-controller@0 {
+            compatible = "worldsemi,ws2812b";
+            reg = <0>;
+            #address-cells = <1>;
+            #size-cells = <0>;
+            spi-max-frequency = <2850000>;
+            multi-led@0 {
+                reg = <0>;
+                color-index = <LED_COLOR_ID_RED LED_COLOR_ID_GREEN LED_COLOR_ID_BLUE>;
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

