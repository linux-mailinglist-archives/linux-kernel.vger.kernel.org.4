Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E980762F3C3
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 12:33:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241674AbiKRLdB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 06:33:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240540AbiKRLcV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 06:32:21 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29F15657D5;
        Fri, 18 Nov 2022 03:32:05 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id v1so8762459wrt.11;
        Fri, 18 Nov 2022 03:32:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=12BigG8eO8PODlW6xDeYgIHqa4GEKQKJXIZWhZtDqFw=;
        b=PTDUBXsBYbL6zydgkmQX/TCUY2fO9hmAFN/jaq9q1BPtWorEpFaJhlXH7x4EUHcQOj
         TJmvV69YEdTUym06chdAQJT6aM2T9G7gRl7/aZloWc3CI39HdQHC2fjw9rdhI/pQWt4y
         jhTDlhK1+BcnBhrYV/KewlXaW8ywuXDKYHAdmJhM4i2XZRu+npujLnSF6IRQZS1xpeX/
         f2T+hZJfql97rOOxWQUjMwOAD6ftB28xk2FaV4tNgUZfDmhBvQtZvys/ZpyGKnSUtvhD
         jZPu+V7iHJy2TuWdYTjPkgU/nxfsgXynq5BZ4BZBRGBiXmKG8o1wOAClqesx2CbgLbct
         15QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=12BigG8eO8PODlW6xDeYgIHqa4GEKQKJXIZWhZtDqFw=;
        b=oQq1t7v5GCTj9YJLNBmu5MtFClj92ith50TBC7LHxnbaPDVh2aoeIB5bZM6C1hvnPp
         XKSlP4p2sTA0WA6oTDs541NmG11YxvY7EzGF7n5YqbJhtTvXYjZ/LvPuxyI5NKnMr1k4
         tMn3uIXNVfSYB2G/KILR1enR7P10gA+5SYb0JIV2Jqf5KiZJ3mhIGEwDY4ATYwHtwozr
         77BXTYO/ePsDR81BptKHPjnuLGwCY8BnFUMPR1JTulqM92xRpJPhZqKeKl4hH2SOZnbu
         J+ibMDEuH3bLI3axhgFsnOPvgiG4RU7NnWCVXFnuNXbYEZwu4hgrtQN/kiIdC++LpTrX
         1l/w==
X-Gm-Message-State: ANoB5plUe7WNK3urpgEGsg1iX6vkA5Owo0+oeDJoXur3OdUZ4W2muBum
        K9ihM5P83TsX8tzHdoZ3DK8=
X-Google-Smtp-Source: AA0mqf66CLlG2XiMQXE/qkk/pOHIbzDqWch3J0S3cXTJ8pLwJP3eFJ79qqXLWJNHPTw9SMBbNlKq+A==
X-Received: by 2002:a5d:4f90:0:b0:236:8cc9:1a04 with SMTP id d16-20020a5d4f90000000b002368cc91a04mr4038268wru.419.1668771123540;
        Fri, 18 Nov 2022 03:32:03 -0800 (PST)
Received: from localhost.localdomain ([95.183.227.98])
        by smtp.gmail.com with ESMTPSA id l24-20020a05600c1d1800b003cf878c4468sm9894817wms.5.2022.11.18.03.32.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Nov 2022 03:32:03 -0800 (PST)
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
Subject: [PATCH v5 3/7] dt-bindings: pinctrl: mediatek,mt6779-pinctrl: Add MT6795
Date:   Fri, 18 Nov 2022 14:30:24 +0300
Message-Id: <20221118113028.145348-4-y.oudjana@protonmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221118113028.145348-1-y.oudjana@protonmail.com>
References: <20221118113028.145348-1-y.oudjana@protonmail.com>
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
process, amend the example with comments and additional pinctrl
nodes from the MT6795 example, replace the current interrupts
property description with the one from the MT6795 document since
it makes more sense and define its items using conditionals
as they now vary between variants. Also use conditionals to define
valid values for the drive-strength property as well as items of
the interrupts property for each variant since they are different
on MT6795.

Signed-off-by: Yassine Oudjana <y.oudjana@protonmail.com>
---
 .../pinctrl/mediatek,mt6779-pinctrl.yaml      |  78 +++++-
 .../pinctrl/mediatek,pinctrl-mt6795.yaml      | 227 ------------------
 2 files changed, 73 insertions(+), 232 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/pinctrl/mediatek,pinctrl-mt6795.yaml

diff --git a/Documentation/devicetree/bindings/pinctrl/mediatek,mt6779-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/mediatek,mt6779-pinctrl.yaml
index 9d481311cc6b..f26584af5c8c 100644
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
@@ -43,9 +45,7 @@ properties:
   interrupt-controller: true
 
   interrupts:
-    maxItems: 1
-    description: |
-      Specifies the summary IRQ.
+    description: Interrupt outputs to the system interrupt controller (sysirq).
 
   "#interrupt-cells":
     const: 2
@@ -81,6 +81,48 @@ allOf:
             - const: iocfg_lt
             - const: iocfg_tl
             - const: eint
+
+        interrupts:
+          items:
+            - description: EINT interrupt
+
+      patternProperties:
+        '-pins$':
+          patternProperties:
+            '^pins':
+              properties:
+                drive-strength:
+                  enum: [2, 4, 8, 12, 16]
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
+          maxItems: 2
+
+        reg-names:
+          items:
+            - const: base
+            - const: eint
+
+        interrupts:
+          items:
+            - description: EINT interrupt
+            - description: EINT event_b interrupt
+
+      patternProperties:
+        '-pins$':
+          patternProperties:
+            '^pins':
+              properties:
+                drive-strength:
+                  enum: [2, 4, 6, 8, 10, 12, 14, 16]
+
   - if:
       properties:
         compatible:
@@ -99,6 +141,19 @@ allOf:
             - const: iocfgb
             - const: iocfgr
             - const: iocfgt
+
+        interrupts:
+          items:
+            - description: EINT interrupt
+
+      patternProperties:
+        '-pins$':
+          patternProperties:
+            '^pins':
+              properties:
+                drive-strength:
+                  enum: [2, 4, 8, 12, 16]
+
   - if:
       properties:
         reg-names:
@@ -169,8 +224,7 @@ patternProperties:
 
           input-schmitt-disable: true
 
-          drive-strength:
-            enum: [2, 4, 8, 12, 16]
+          drive-strength: true
 
           slew-rate:
             enum: [0, 1]
@@ -260,6 +314,20 @@ examples:
                     mediatek,pull-up-adv = <0>;
                 };
             };
+
+            /* GPIO0 set as multifunction GPIO0 */
+            gpio-pins {
+                pins {
+                    pinmux = <PINMUX_GPIO0__FUNC_GPIO0>;
+                };
+            };
+
+            /* GPIO52 set as multifunction SDA0 */
+            i2c0-pins {
+                pins {
+                  pinmux = <PINMUX_GPIO52__FUNC_SDA0>;
+                };
+            };
         };
 
         mmc0 {
diff --git a/Documentation/devicetree/bindings/pinctrl/mediatek,pinctrl-mt6795.yaml b/Documentation/devicetree/bindings/pinctrl/mediatek,pinctrl-mt6795.yaml
deleted file mode 100644
index 9399e0215526..000000000000
--- a/Documentation/devicetree/bindings/pinctrl/mediatek,pinctrl-mt6795.yaml
+++ /dev/null
@@ -1,227 +0,0 @@
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
-    description: Interrupt outputs to the system interrupt controller (sysirq).
-    minItems: 1
-    items:
-      - description: EINT interrupt
-      - description: EINT event_b interrupt
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
2.38.1

