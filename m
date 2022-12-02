Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01DC063FF2E
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 04:43:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231908AbiLBDnV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 22:43:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232250AbiLBDnT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 22:43:19 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F29F920AE;
        Thu,  1 Dec 2022 19:43:18 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id k2-20020a17090a4c8200b002187cce2f92so7130327pjh.2;
        Thu, 01 Dec 2022 19:43:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DcgpSVWbdnGyz27O63kyyynW87PPwff4FTigIa8LAE8=;
        b=ZSCPwyLaDzy9gC5ISXUZhJVzlWx38kHqwDmkd3+h63VteuZkUmnF65ke8rjjIzZsoO
         eofp8zUMtwU0sL0Lu1dLHWVZDJOdnr7WvwNr8iJcC/WLcMvf13+d7uo3u3lCdTAlqUiF
         41kcEeDqQA339abK0OojrKUF2zztAV7bZeS5LHoUFSEXVkisFylg7qOK0wT0o0+CsYQN
         tlH2Z7Qi+lxpN2f5XtJ5QYcv55831FJWBTBfoC2llWai3UyqASEpdr9UtILdHql09TTY
         KD91HcVjkxjIdCtOQ2fchV7o8OIOBNIEOJoirqdjMCioA/IF9o7lQKw1T6FnHIGevwBe
         9tsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DcgpSVWbdnGyz27O63kyyynW87PPwff4FTigIa8LAE8=;
        b=VffP2zvkbrOVvUMwFFkRAt5jM7p0XJ+PxZ6c0TUbx0PktMzYvSq/Cdc78u1H8yP7IR
         tujrozIHZPGrJS1NJMpqkVD4F6s6R2ToQ0u1vogJGe68xKRgOpD5lgmCZVC+wvcG/5Ph
         zcFeZqSGoa62RS/4OpdnmXSZ5q8xujYkJxpHgSlGURAkW1jnv8pDzFonJhW8wRxZnqxj
         o1wkSltY03NS5jpCmbvogMK2MK8Ljko6SYJbGsJKwzkOzyde4ILIkJt6QReMwNdp2GTS
         B71vWnH43ew7WVTmN3NjmtWRJJQRyKLmflmXzf5EVVxsoimANDOZKQ67Kx4a3tJmefNU
         J2eA==
X-Gm-Message-State: ANoB5pljvU5prp2239i+slwOAA/10OSu5JkRTGMxNqotkRV1PnbNUowL
        7vbVgAAtxvfMcFtkA6D3KkMyZESlgrg=
X-Google-Smtp-Source: AA0mqf5pBHuD74+gyQawU+H3V8GojiH5S3AiPfHrU1wxLJSOa4XUZEcOq4bTio/AwGenm9fg7Rmycg==
X-Received: by 2002:a17:90b:264a:b0:213:7030:f69a with SMTP id pa10-20020a17090b264a00b002137030f69amr73829602pjb.231.1669952597261;
        Thu, 01 Dec 2022 19:43:17 -0800 (PST)
Received: from guoguo-omen.scut.edu.cn ([2401:c080:1400:4da2:5400:3ff:feb4:7578])
        by smtp.gmail.com with ESMTPSA id v3-20020a170902e8c300b0017f59ebafe7sm4370636plg.212.2022.12.01.19.43.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Dec 2022 19:43:16 -0800 (PST)
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
Subject: [PATCH v2 2/3] dt-bindings: leds: add dt schema for worldsemi,ws2812b-spi
Date:   Fri,  2 Dec 2022 11:42:39 +0800
Message-Id: <20221202034240.455831-3-gch981213@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221202034240.455831-1-gch981213@gmail.com>
References: <20221202034240.455831-1-gch981213@gmail.com>
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
Changes since v1:
remove linux driver reference from description
remove some obvious descriptions
fix unit address regex in multi-led property
drop various minItems
add maxItems = 1 to reg
fix node names and property orders in binding example
drop -spi from compatible string
add default-brightness

 .../bindings/leds/worldsemi,ws2812b.yaml      | 138 ++++++++++++++++++
 1 file changed, 138 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/leds/worldsemi,ws2812b.yaml

diff --git a/Documentation/devicetree/bindings/leds/worldsemi,ws2812b.yaml b/Documentation/devicetree/bindings/leds/worldsemi,ws2812b.yaml
new file mode 100644
index 000000000000..f91908d0acef
--- /dev/null
+++ b/Documentation/devicetree/bindings/leds/worldsemi,ws2812b.yaml
@@ -0,0 +1,138 @@
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
+      default-brightness:
+        description:
+          The default brightness that should be applied to the LED by the operating
+          system on start-up. The brightness should not exceed the brightness the
+          LED can provide.
+        $ref: /schemas/types.yaml#/definitions/uint32
+        minimum: 0
+        maximum: 255
+        default: 0
+
+      default-intensity:
+        description: |
+          An array of 3 integer specifying the default intensity of each color
+          components in this LED. <255 255 255> if unspecified.
+        $ref: /schemas/types.yaml#/definitions/uint32-array
+        maxItems: 3
+        items:
+          minimum: 0
+          maximum: 255
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
+        leds@0 {
+            compatible = "worldsemi,ws2812b";
+            reg = <0>;
+            #address-cells = <1>;
+            #size-cells = <0>;
+            spi-max-frequency = <2850000>;
+            multi-led@0 {
+                reg = <0>;
+                color-index = <LED_COLOR_ID_RED LED_COLOR_ID_GREEN LED_COLOR_ID_BLUE>;
+                default-brightness = <30>;
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

