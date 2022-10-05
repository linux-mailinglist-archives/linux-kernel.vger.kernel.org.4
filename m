Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C51FE5F5945
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 19:44:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230499AbiJERok (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 13:44:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230453AbiJERoa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 13:44:30 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA0C67F09F;
        Wed,  5 Oct 2022 10:44:27 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id z13-20020a7bc7cd000000b003b5054c6f9bso1423683wmk.2;
        Wed, 05 Oct 2022 10:44:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=R5V9XL61CvLrWTitaAk3IV4z/7vaqFwBxHB+dhQiJmU=;
        b=VNuTzrG95urLF81YJdZboObgF6osUcvRWPCKgG0kxSvNaihUVHoSmdmDPraIjawVY0
         Jv/07CbaY2fz2b9Z70wL1U7IbbzcNocW/6iFcuEC4zoefp4QJz3LBRcIWJMAWUQVbFsw
         /J5KPRo/RNI4J6UJa3nz9l+j/mprFLiX6kbsXsw2168SYy75+8sfFR09UxJEBOdj1+HR
         TQURzmbnc3qNFteNiS9R/+nR0ia+plqrVZaHKAwYJ79whx+2ECwgPrAAFenA+Eh6MYxa
         ZGJvUegV8cv03E+rhn2P60AZK/jXz7tijNayIhS0u8FuFqLXaCYsV1v13bMmwk+UG6hy
         Xf6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=R5V9XL61CvLrWTitaAk3IV4z/7vaqFwBxHB+dhQiJmU=;
        b=Pjau5LSiBa/0e0J2zOCdcnLZszdcudIhiMllkI6mdjqUYsw5VqST8DwZBSDqNfMMCl
         sxJcaVtYDgSg8TB/+LoHiO8s5JYybuYb5opoK09mKjXdAXxpsJ4mEJg9of/Geujf5lUn
         K1GL2FB1t2Bq15AcjE6VNs0pN/zmfyI6gGAU/R2C/7SKBxLsX9Emtmn6LqQP//J+voBN
         pqUMI8B5z1sSuYymrs2bYXP6gNXiis7eq9AbJFcW4G3xb+oVFXDJpzZlR+2vNLJRN21v
         B5qHkoSFt/T17onVaV5EpINwl80rywdvJoQKHThGnOcSCFlLTWAq6HkAtsotRWbjqzG6
         Qqag==
X-Gm-Message-State: ACrzQf24V3VuqU1BlkDrL6WRUhseqzIeJc7zazUERFlJZOUC25Llee/j
        ZvkUKTw3Jsb7z8E39Lqbwoc=
X-Google-Smtp-Source: AMsMyM4cwnR+z1FcZoKQl6zwvm87KZHzi1VndZvrpT+wTyDDiFZ4ksar90GqtLG/6XvbLmerjJaC8w==
X-Received: by 2002:a1c:7c12:0:b0:3b4:73e1:bdd7 with SMTP id x18-20020a1c7c12000000b003b473e1bdd7mr4300206wmc.32.1664991866047;
        Wed, 05 Oct 2022 10:44:26 -0700 (PDT)
Received: from localhost.localdomain ([95.183.227.98])
        by smtp.gmail.com with ESMTPSA id c6-20020a5d4146000000b0022a403954c3sm16075491wrq.42.2022.10.05.10.44.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Oct 2022 10:44:25 -0700 (PDT)
From:   Yassine Oudjana <yassine.oudjana@gmail.com>
X-Google-Original-From: Yassine Oudjana <y.oudjana@protonmail.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Sean Wang <sean.wang@kernel.org>,
        Andy Teng <andy.teng@mediatek.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     Yassine Oudjana <y.oudjana@protonmail.com>,
        Yassine Oudjana <yassine.oudjana@gmail.com>,
        linux-mediatek@lists.infradead.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 06/10] dt-bindings: pinctrl: mediatek,mt6779-pinctrl: Add MT6795
Date:   Wed,  5 Oct 2022 20:43:39 +0300
Message-Id: <20221005174343.24240-7-y.oudjana@protonmail.com>
X-Mailer: git-send-email 2.38.0
In-Reply-To: <20221005174343.24240-1-y.oudjana@protonmail.com>
References: <20221005174343.24240-1-y.oudjana@protonmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yassine Oudjana <y.oudjana@protonmail.com>

Combine MT6795 pin controller document into MT6779 one. In the
process, replace the current interrupts property description with
the one from the MT6795 document since it makes more sense. Also
amend property descriptions with more detailed information that
was available in the MT6795 document, and replace the current
pinmux node name patterns with ones from it since they are more
common across mediatek pin controller bindings.

Signed-off-by: Yassine Oudjana <y.oudjana@protonmail.com>
---
 .../pinctrl/mediatek,mt6779-pinctrl.yaml      |  90 +++++--
 .../pinctrl/mediatek,pinctrl-mt6795.yaml      | 225 ------------------
 2 files changed, 73 insertions(+), 242 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/pinctrl/mediatek,pinctrl-mt6795.yaml

diff --git a/Documentation/devicetree/bindings/pinctrl/mediatek,mt6779-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/mediatek,mt6779-pinctrl.yaml
index a2141eb0854e..64d4b6a3b5bd 100644
--- a/Documentation/devicetree/bindings/pinctrl/mediatek,mt6779-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/mediatek,mt6779-pinctrl.yaml
@@ -8,6 +8,7 @@ title: Mediatek MT6779 Pin Controller
 
 maintainers:
   - Andy Teng <andy.teng@mediatek.com>
+  - AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
   - Sean Wang <sean.wang@kernel.org>
 
 description:
@@ -18,6 +19,7 @@ properties:
   compatible:
     enum:
       - mediatek,mt6779-pinctrl
+      - mediatek,mt6795-pinctrl
       - mediatek,mt6797-pinctrl
 
   reg:
@@ -43,9 +45,8 @@ properties:
   interrupt-controller: true
 
   interrupts:
-    maxItems: 1
     description: |
-      Specifies the summary IRQ.
+      The interrupt output to sysirq.
 
   "#interrupt-cells":
     const: 2
@@ -81,6 +82,28 @@ allOf:
             - const: iocfg_lt
             - const: iocfg_tl
             - const: eint
+
+        interrupts:
+          maxItems: 1
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: mediatek,mt6795-pinctrl
+    then:
+      properties:
+        reg:
+          minItems: 2
+
+        reg-names:
+          items:
+            - const: base
+            - const: eint
+
+        interrupts:
+          minItems: 2
+          maxItems: 2
   - if:
       properties:
         compatible:
@@ -111,32 +134,65 @@ allOf:
         - "#interrupt-cells"
 
 patternProperties:
-  '-[0-9]*$':
+  '-pins$':
     type: object
     additionalProperties: false
 
     patternProperties:
-      '-pins*$':
+      '^pins':
         type: object
         description: |
           A pinctrl node should contain at least one subnodes representing the
           pinctrl groups available on the machine. Each subnode will list the
           pins it needs, and how they should be configured, with regard to muxer
-          configuration, pullups, drive strength, input enable/disable and input schmitt.
-        $ref: "/schemas/pinctrl/pincfg-node.yaml"
+          configuration, pullups, drive strength, input enable/disable and
+          input schmitt.
+          An example of using macro:
+          pincontroller {
+            /* GPIO0 set as multifunction GPIO0 */
+            gpio-pins {
+              pins {
+                pinmux = <PINMUX_GPIO0__FUNC_GPIO0>;
+              }
+            };
+            /* GPIO45 set as multifunction SDA0 */
+            i2c0-pins {
+              pins {
+                pinmux = <PINMUX_GPIO45__FUNC_SDA0>;
+              }
+            };
+          };
+        $ref: "pinmux-node.yaml"
 
         properties:
           pinmux:
             description:
-              integer array, represents gpio pin number and mux setting.
-              Supported pin number and mux varies for different SoCs, and are defined
-              as macros in boot/dts/<soc>-pinfunc.h directly.
+              Integer array, represents gpio pin number and mux setting.
+              Supported pin number and mux varies for different SoCs, and are
+              defined as macros in dt-bindings/pinctrl/<soc>-pinfunc.h
+              directly.
 
           bias-disable: true
 
-          bias-pull-up: true
-
-          bias-pull-down: true
+          bias-pull-up:
+            oneOf:
+              - type: boolean
+              - enum: [100, 101, 102, 103]
+                description: Pull up PUPD/R0/R1 type define value.
+            description: |
+               For normal pull up type, it is not necessary to specify R1R0
+               values; When pull up type is PUPD/R0/R1, adding R1R0 defines
+               will set different resistance values.
+
+          bias-pull-down:
+            oneOf:
+              - type: boolean
+              - enum: [100, 101, 102, 103]
+                description: Pull down PUPD/R0/R1 type define value.
+            description: |
+               For normal pull down type, it is not necessary to specify R1R0
+               values; When pull down type is PUPD/R0/R1, adding R1R0 defines
+               will set different resistance values.
 
           input-enable: true
 
@@ -151,7 +207,7 @@ patternProperties:
           input-schmitt-disable: true
 
           drive-strength:
-            enum: [2, 4, 8, 12, 16]
+            enum: [2, 4, 6, 8, 10, 12, 14, 16]
 
           slew-rate:
             enum: [0, 1]
@@ -218,8 +274,8 @@ examples:
             #interrupt-cells = <2>;
             interrupts = <GIC_SPI 204 IRQ_TYPE_LEVEL_HIGH>;
 
-            mmc0_pins_default: mmc0-0 {
-                cmd-dat-pins {
+            mmc0_pins_default: mmc0-pins {
+                pins-cmd-dat {
                     pinmux = <PINMUX_GPIO168__FUNC_MSDC0_DAT0>,
                         <PINMUX_GPIO172__FUNC_MSDC0_DAT1>,
                         <PINMUX_GPIO169__FUNC_MSDC0_DAT2>,
@@ -232,11 +288,11 @@ examples:
                     input-enable;
                     mediatek,pull-up-adv = <1>;
                 };
-                clk-pins {
+                pins-clk {
                     pinmux = <PINMUX_GPIO176__FUNC_MSDC0_CLK>;
                     mediatek,pull-down-adv = <2>;
                 };
-                rst-pins {
+                pins-rst {
                     pinmux = <PINMUX_GPIO178__FUNC_MSDC0_RSTB>;
                     mediatek,pull-up-adv = <0>;
                 };
diff --git a/Documentation/devicetree/bindings/pinctrl/mediatek,pinctrl-mt6795.yaml b/Documentation/devicetree/bindings/pinctrl/mediatek,pinctrl-mt6795.yaml
deleted file mode 100644
index 483fcdc60487..000000000000
--- a/Documentation/devicetree/bindings/pinctrl/mediatek,pinctrl-mt6795.yaml
+++ /dev/null
@@ -1,225 +0,0 @@
-# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
-%YAML 1.2
----
-$id: http://devicetree.org/schemas/pinctrl/mediatek,pinctrl-mt6795.yaml#
-$schema: http://devicetree.org/meta-schemas/core.yaml#
-
-title: Mediatek MT6795 Pin Controller
-
-maintainers:
-  - AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
-  - Sean Wang <sean.wang@kernel.org>
-
-description: |
-  The Mediatek's Pin controller is used to control SoC pins.
-
-properties:
-  compatible:
-    const: mediatek,mt6795-pinctrl
-
-  gpio-controller: true
-
-  '#gpio-cells':
-    description: |
-      Number of cells in GPIO specifier. Since the generic GPIO binding is used,
-      the amount of cells must be specified as 2. See the below
-      mentioned gpio binding representation for description of particular cells.
-    const: 2
-
-  gpio-ranges:
-    description: GPIO valid number range.
-    maxItems: 1
-
-  reg:
-    description:
-      Physical address base for gpio base and eint registers.
-    minItems: 2
-
-  reg-names:
-    items:
-      - const: base
-      - const: eint
-
-  interrupt-controller: true
-
-  '#interrupt-cells':
-    const: 2
-
-  interrupts:
-    description: The interrupt outputs to sysirq.
-    minItems: 2
-    maxItems: 2
-
-# PIN CONFIGURATION NODES
-patternProperties:
-  '-pins$':
-    type: object
-    additionalProperties: false
-    patternProperties:
-      '^pins':
-        type: object
-        additionalProperties: false
-        description: |
-          A pinctrl node should contain at least one subnodes representing the
-          pinctrl groups available on the machine. Each subnode will list the
-          pins it needs, and how they should be configured, with regard to muxer
-          configuration, pullups, drive strength, input enable/disable and
-          input schmitt.
-          An example of using macro:
-          pincontroller {
-            /* GPIO0 set as multifunction GPIO0 */
-            gpio-pins {
-              pins {
-                pinmux = <PINMUX_GPIO0__FUNC_GPIO0>;
-              }
-            };
-            /* GPIO45 set as multifunction SDA0 */
-            i2c0-pins {
-              pins {
-                pinmux = <PINMUX_GPIO45__FUNC_SDA0>;
-              }
-            };
-          };
-        $ref: "pinmux-node.yaml"
-
-        properties:
-          pinmux:
-            description: |
-              Integer array, represents gpio pin number and mux setting.
-              Supported pin number and mux varies for different SoCs, and are
-              defined as macros in dt-bindings/pinctrl/<soc>-pinfunc.h
-              directly.
-
-          drive-strength:
-            enum: [2, 4, 6, 8, 10, 12, 14, 16]
-
-          bias-pull-down:
-            oneOf:
-              - type: boolean
-              - enum: [100, 101, 102, 103]
-                description: mt6795 pull down PUPD/R0/R1 type define value.
-            description: |
-               For normal pull down type, it is not necessary to specify R1R0
-               values; When pull down type is PUPD/R0/R1, adding R1R0 defines
-               will set different resistance values.
-
-          bias-pull-up:
-            oneOf:
-              - type: boolean
-              - enum: [100, 101, 102, 103]
-                description: mt6795 pull up PUPD/R0/R1 type define value.
-            description: |
-               For normal pull up type, it is not necessary to specify R1R0
-               values; When pull up type is PUPD/R0/R1, adding R1R0 defines
-               will set different resistance values.
-
-          bias-disable: true
-
-          output-high: true
-
-          output-low: true
-
-          input-enable: true
-
-          input-disable: true
-
-          input-schmitt-enable: true
-
-          input-schmitt-disable: true
-
-          mediatek,pull-up-adv:
-            description: |
-              Pull up setings for 2 pull resistors, R0 and R1. User can
-              configure those special pins. Valid arguments are described as below:
-              0: (R1, R0) = (0, 0) which means R1 disabled and R0 disabled.
-              1: (R1, R0) = (0, 1) which means R1 disabled and R0 enabled.
-              2: (R1, R0) = (1, 0) which means R1 enabled and R0 disabled.
-              3: (R1, R0) = (1, 1) which means R1 enabled and R0 enabled.
-            $ref: /schemas/types.yaml#/definitions/uint32
-            enum: [0, 1, 2, 3]
-
-          mediatek,pull-down-adv:
-            description: |
-              Pull down settings for 2 pull resistors, R0 and R1. User can
-              configure those special pins. Valid arguments are described as below:
-              0: (R1, R0) = (0, 0) which means R1 disabled and R0 disabled.
-              1: (R1, R0) = (0, 1) which means R1 disabled and R0 enabled.
-              2: (R1, R0) = (1, 0) which means R1 enabled and R0 disabled.
-              3: (R1, R0) = (1, 1) which means R1 enabled and R0 enabled.
-            $ref: /schemas/types.yaml#/definitions/uint32
-            enum: [0, 1, 2, 3]
-
-        required:
-          - pinmux
-
-allOf:
-  - $ref: "pinctrl.yaml#"
-
-required:
-  - compatible
-  - reg
-  - reg-names
-  - interrupts
-  - interrupt-controller
-  - '#interrupt-cells'
-  - gpio-controller
-  - '#gpio-cells'
-  - gpio-ranges
-
-additionalProperties: false
-
-examples:
-  - |
-    #include <dt-bindings/interrupt-controller/arm-gic.h>
-    #include <dt-bindings/interrupt-controller/irq.h>
-    #include <dt-bindings/pinctrl/mt6795-pinfunc.h>
-
-    soc {
-        #address-cells = <2>;
-        #size-cells = <2>;
-
-        pio: pinctrl@10005000 {
-            compatible = "mediatek,mt6795-pinctrl";
-            reg = <0 0x10005000 0 0x1000>, <0 0x1000b000 0 0x1000>;
-            reg-names = "base", "eint";
-            gpio-controller;
-            #gpio-cells = <2>;
-            gpio-ranges = <&pio 0 0 196>;
-            interrupt-controller;
-            interrupts = <GIC_SPI 153 IRQ_TYPE_LEVEL_HIGH>;
-            #interrupt-cells = <2>;
-
-            i2c0-pins {
-                pins-sda-scl {
-                    pinmux = <PINMUX_GPIO45__FUNC_SDA0>,
-                             <PINMUX_GPIO46__FUNC_SCL0>;
-                };
-            };
-
-            mmc0-pins {
-                pins-cmd-dat {
-                    pinmux = <PINMUX_GPIO154__FUNC_MSDC0_DAT0>,
-                             <PINMUX_GPIO155__FUNC_MSDC0_DAT1>,
-                             <PINMUX_GPIO156__FUNC_MSDC0_DAT2>,
-                             <PINMUX_GPIO157__FUNC_MSDC0_DAT3>,
-                             <PINMUX_GPIO158__FUNC_MSDC0_DAT4>,
-                             <PINMUX_GPIO159__FUNC_MSDC0_DAT5>,
-                             <PINMUX_GPIO160__FUNC_MSDC0_DAT6>,
-                             <PINMUX_GPIO161__FUNC_MSDC0_DAT7>,
-                             <PINMUX_GPIO162__FUNC_MSDC0_CMD>;
-                    input-enable;
-                    bias-pull-up = <MTK_PUPD_SET_R1R0_01>;
-                };
-
-                pins-clk {
-                    pinmux = <PINMUX_GPIO163__FUNC_MSDC0_CLK>;
-                    bias-pull-down = <MTK_PUPD_SET_R1R0_10>;
-                };
-
-                pins-rst {
-                    pinmux = <PINMUX_GPIO165__FUNC_MSDC0_RSTB>;
-                    bias-pull-up = <MTK_PUPD_SET_R1R0_10>;
-                };
-            };
-        };
-    };
-- 
2.38.0

