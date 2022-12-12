Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1412649890
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 05:57:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231279AbiLLE5L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Dec 2022 23:57:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231308AbiLLE4m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Dec 2022 23:56:42 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B885DF2B;
        Sun, 11 Dec 2022 20:56:23 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id e7-20020a17090a77c700b00216928a3917so14348745pjs.4;
        Sun, 11 Dec 2022 20:56:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hFOhHl9x/eniJ2ycOcv7dU0kegtvbeOEHvYNasTYocI=;
        b=OlFN+IION7DBMwiBPCqSNj3AKAt39E+vq/IUs0wQXylYuCxsmqzqzE1cuuNbnilinT
         SXcyl7R+MXQdwosi2/6h7MPMOzjxcFq9sLUv1acPC9NgaRjoBAkVUTKkY//PHbK1zhpS
         Z1uOcYXPuip2lXdEbxtN9qw8oCEwV3lFof5j6Cs5m8v/upV1Ie5hzv3g6zd025TlMM+t
         VV/BKHisO/YBE6KuoVx5yAXR19Z6nGSlIajTZNfdGBFn/t4NEvFCbCflKy6A7qfSuUBK
         e5bsgeZ7hMvTnLyfSSXetU4PXVJr6KTFvl8WxGhmXtJzgtHPPeDOI/imaccPqt5qYSl/
         VjWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hFOhHl9x/eniJ2ycOcv7dU0kegtvbeOEHvYNasTYocI=;
        b=EFvTQfY5Ic/cOv+0n78mgVbj8IQPzQYeRr9TupgNv9MiziT1xCoJajrXFJjmUb6fGC
         JxS1HqBBxQ2fbL6ofqZsakGce+sWMalpcggN1yjdzsMKD5IEYA78VbVH0nwrJksjrMc2
         V/4qSv1sSHBNXiEby7+h0/CQ09QIZSzfgXtbd0WzlCt5EfdGf8ApKjOPEuz7CnB2hPQr
         sZ0otjo/HvPPDtsvD1YVwGiFDOLJXTL41rq9wjtoUc+btQQYLFJpZupmO4C1m4DPF0Mj
         4ESGHN7cUlDjGGpN2YRgNq9tqaZpWvzMxW5c3RiQY5GOzjQi0O84L/gbQ+fj5J1DG+Ep
         aPZg==
X-Gm-Message-State: ANoB5pntIObUpDJLJuAAwou9MjSTlalVKZUJJuYiRzuOYhpzo26oKuJd
        OXSWqf3ZjVqCPLXA+UTvRHWREQfhGCA=
X-Google-Smtp-Source: AA0mqf5fNdWyxkKMb0ttwLdVs8aCPILY7zkfeNFZuwun5AUkMNcMp6lK4y9iD434dsw4b5ADV0YiRg==
X-Received: by 2002:a05:6a20:9c8f:b0:9d:efbf:6623 with SMTP id mj15-20020a056a209c8f00b0009defbf6623mr3207120pzb.49.1670820982551;
        Sun, 11 Dec 2022 20:56:22 -0800 (PST)
Received: from guoguo-omen.lan ([2401:c080:1400:4da2:5400:3ff:feb4:7578])
        by smtp.gmail.com with ESMTPSA id s20-20020a639254000000b00478eb777d18sm4217674pgn.72.2022.12.11.20.56.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Dec 2022 20:56:22 -0800 (PST)
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
Subject: [PATCH v4 2/3] dt-bindings: leds: add worldsemi,ws2812b
Date:   Mon, 12 Dec 2022 12:55:57 +0800
Message-Id: <20221212045558.69602-3-gch981213@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221212045558.69602-1-gch981213@gmail.com>
References: <20221212045558.69602-1-gch981213@gmail.com>
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

Change since v3:
reword commit title

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

