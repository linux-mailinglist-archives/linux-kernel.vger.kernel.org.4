Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10EF569FB5E
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 19:48:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232696AbjBVSly (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 13:41:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232676AbjBVSlX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 13:41:23 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F7B143444;
        Wed, 22 Feb 2023 10:40:42 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id c12so8755981wrw.1;
        Wed, 22 Feb 2023 10:40:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JGSNKz0q0gsC5HLgSbrlpiQsXVswleKhPPANT6X3ZpI=;
        b=GYafZWwDleHBnO/XlsX3CZ/87Pf2sxrXHGv2JBHFJGTRi8Ixhpk48QnV+XQomsohF0
         XDEZlJPvVH696bvNEENlheCJ3Q4r0OXlLdTzl4Eu+7yL2gK07lKLFFHI11IXY156SXAK
         5MWPBI9C5zJtNnkw917bVtQavhldG/kIlDvzD0UpO1GGzkwxYpll4MV1QznCs9p66oKN
         In5i/CTJVS3wYms2I3Sy64sOd9TZA5it7XCiwD2YITSM3Fpz8XH/gTJmS1MLKjOxonyh
         AnBRPnTKxGCNi6mrDd0KkFlK/pIsSX3y6YrXex69P6Z8iIK9S6rAN60s/Jz0hEF5Xptd
         WqNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JGSNKz0q0gsC5HLgSbrlpiQsXVswleKhPPANT6X3ZpI=;
        b=lL+4iMtSWsKcZzwiJOdkyKlw8WRqY4/HZVMiymTUbRXAs8ctqar3FPPgR+SqZUKaIC
         J+NCySy9hAFgG1PrQWDyxBJa5BCAp40x7XJkIS17vajb9Ud8bkAWgAjW5fpq3bNX6aFX
         ydp6IDjSLCGGSSbYV9go5pfgPm9cSU9rnjrp6khwZfJ140NpzDEcAmawof2bimhAuHG9
         ap1eJ56POMzggDyqAOjUKezWC1eksnew3ywP0y6VW4hzQLUWXXVEFKuEf3z7bvaRfkdD
         qIGObIrHqIcTO+KhRfaFTFOC+JDxdlgl0c3XIsWrF9z9kmMtMixejSEijd1O/Wo+z9Pe
         RRAQ==
X-Gm-Message-State: AO0yUKVp3uw/oXw2/4NJLuh3JgdgjEtGxGDkr10RGHRViSo7BFTw3DgH
        iGV0JWVgB4KomX4v+TjCAl0=
X-Google-Smtp-Source: AK7set9XZ6fejEokWr/EtWMPZHKgIkMVbfEKSDaxuwCBb7P6IStu3GLCN2B9q0DPRJkFROsTrHVOKQ==
X-Received: by 2002:adf:dfd0:0:b0:2c5:54a7:3646 with SMTP id q16-20020adfdfd0000000b002c554a73646mr7460724wrn.5.1677091240944;
        Wed, 22 Feb 2023 10:40:40 -0800 (PST)
Received: from arinc9-PC.lan ([37.120.152.236])
        by smtp.gmail.com with ESMTPSA id l18-20020a5d4112000000b002c56179d39esm9372845wrp.44.2023.02.22.10.40.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Feb 2023 10:40:40 -0800 (PST)
From:   arinc9.unal@gmail.com
X-Google-Original-From: arinc.unal@arinc9.com
To:     Sergio Paracuellos <sergio.paracuellos@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     =?UTF-8?q?Ar=C4=B1n=C3=A7=20=C3=9CNAL?= <arinc.unal@arinc9.com>,
        linux-mediatek@lists.infradead.org, linux-mips@vger.kernel.org,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Sean Wang <sean.wang@kernel.org>,
        William Dean <williamsukatube@gmail.com>,
        Daniel Golle <daniel@makrotopia.org>,
        Daniel Santos <daniel.santos@pobox.com>,
        Luiz Angelo Daros de Luca <luizluca@gmail.com>,
        Frank Wunderlich <frank-w@public-files.de>,
        Landen Chao <Landen.Chao@mediatek.com>,
        DENG Qingfang <dqfext@gmail.com>,
        Sean Wang <sean.wang@mediatek.com>, erkin.bozoglu@xeront.com
Subject: [RFC PATCH 16/16] dt-bindings: pinctrl: mediatek: improve schemas
Date:   Wed, 22 Feb 2023 21:39:32 +0300
Message-Id: <20230222183932.33267-17-arinc.unal@arinc9.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230222183932.33267-1-arinc.unal@arinc9.com>
References: <20230222183932.33267-1-arinc.unal@arinc9.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Arınç ÜNAL <arinc.unal@arinc9.com>

Some schemas include "MediaTek", some "Mediatek". Rename all to "MediaTek"
to address the naming inconsistency.

Change the style of description properties to plain style where there's no
need to preserve the line endings, and vice versa.

Fit the schemas to 80 columns for each line.

Set patternProperties to '^.*mux.*$' on mediatek,mt7986-pinctrl.yaml.

Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
---
 .../pinctrl/mediatek,mt65xx-pinctrl.yaml      | 24 +++---
 .../pinctrl/mediatek,mt6779-pinctrl.yaml      | 33 +++++----
 .../pinctrl/mediatek,mt6795-pinctrl.yaml      | 33 +++++----
 .../pinctrl/mediatek,mt7620-pinctrl.yaml      |  2 +-
 .../pinctrl/mediatek,mt7621-pinctrl.yaml      |  2 +-
 .../pinctrl/mediatek,mt7622-pinctrl.yaml      | 26 +++----
 .../pinctrl/mediatek,mt76x8-pinctrl.yaml      |  2 +-
 .../pinctrl/mediatek,mt7981-pinctrl.yaml      | 35 +++++----
 .../pinctrl/mediatek,mt7986-pinctrl.yaml      | 64 ++++++++--------
 .../pinctrl/mediatek,mt8183-pinctrl.yaml      | 26 ++++---
 .../pinctrl/mediatek,mt8186-pinctrl.yaml      | 47 ++++++------
 .../pinctrl/mediatek,mt8188-pinctrl.yaml      | 74 ++++++++++---------
 .../pinctrl/mediatek,mt8192-pinctrl.yaml      | 47 ++++++------
 .../pinctrl/mediatek,mt8195-pinctrl.yaml      | 38 +++++-----
 .../pinctrl/mediatek,mt8365-pinctrl.yaml      | 28 +++----
 .../pinctrl/mediatek,rt2880-pinctrl.yaml      |  2 +-
 .../pinctrl/mediatek,rt305x-pinctrl.yaml      |  2 +-
 .../pinctrl/mediatek,rt3352-pinctrl.yaml      |  2 +-
 .../pinctrl/mediatek,rt3883-pinctrl.yaml      |  2 +-
 .../pinctrl/mediatek,rt5350-pinctrl.yaml      |  2 +-
 20 files changed, 256 insertions(+), 235 deletions(-)

diff --git a/Documentation/devicetree/bindings/pinctrl/mediatek,mt65xx-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/mediatek,mt65xx-pinctrl.yaml
index a55c8e4ff26e..206fa8ba9502 100644
--- a/Documentation/devicetree/bindings/pinctrl/mediatek,mt65xx-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/mediatek,mt65xx-pinctrl.yaml
@@ -4,13 +4,13 @@
 $id: http://devicetree.org/schemas/pinctrl/mediatek,mt65xx-pinctrl.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: Mediatek MT65xx Pin Controller
+title: MediaTek MT65xx Pin Controller
 
 maintainers:
   - Sean Wang <sean.wang@kernel.org>
 
-description: |+
-  The Mediatek's Pin controller is used to control SoC pins.
+description:
+  The MediaTek's Pin controller is used to control SoC pins.
 
 properties:
   compatible:
@@ -30,7 +30,7 @@ properties:
 
   pins-are-numbered:
     $ref: /schemas/types.yaml#/definitions/flag
-    description: |
+    description:
       Specify the subnodes are using numbered pinmux to specify pins. (UNUSED)
     deprecated: true
 
@@ -38,10 +38,10 @@ properties:
 
   "#gpio-cells":
     const: 2
-    description: |
-      Number of cells in GPIO specifier. Since the generic GPIO
-      binding is used, the amount of cells must be specified as 2. See the below
-      mentioned gpio binding representation for description of particular cells.
+    description:
+      Number of cells in GPIO specifier. Since the generic GPIO binding is used,
+      the amount of cells must be specified as 2. See the below mentioned gpio
+      binding representation for description of particular cells.
 
   mediatek,pctl-regmap:
     $ref: /schemas/types.yaml#/definitions/phandle-array
@@ -49,7 +49,7 @@ properties:
       maxItems: 1
     minItems: 1
     maxItems: 2
-    description: |
+    description:
       Should be phandles of the syscfg node.
 
   interrupt-controller: true
@@ -77,7 +77,7 @@ patternProperties:
       '(^pins|pins?$)':
         type: object
         additionalProperties: false
-        description: |
+        description:
           A pinctrl node should contain at least one subnodes representing the
           pinctrl groups available on the machine. Each subnode will list the
           pins it needs, and how they should be configured, with regard to muxer
@@ -95,7 +95,7 @@ patternProperties:
           bias-disable: true
 
           bias-pull-up:
-            description: |
+            description:
               Besides generic pinconfig options, it can be used as the pull up
               settings for 2 pull resistors, R0 and R1. User can configure those
               special pins. Some macros have been defined for this usage, such
@@ -117,7 +117,7 @@ patternProperties:
           input-schmitt-disable: true
 
           drive-strength:
-            description: |
+            description:
               Can support some arguments, such as MTK_DRIVE_4mA, MTK_DRIVE_6mA,
               etc. See dt-bindings/pinctrl/mt65xx.h for valid arguments.
 
diff --git a/Documentation/devicetree/bindings/pinctrl/mediatek,mt6779-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/mediatek,mt6779-pinctrl.yaml
index a2141eb0854e..17046d204087 100644
--- a/Documentation/devicetree/bindings/pinctrl/mediatek,mt6779-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/mediatek,mt6779-pinctrl.yaml
@@ -4,15 +4,15 @@
 $id: http://devicetree.org/schemas/pinctrl/mediatek,mt6779-pinctrl.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: Mediatek MT6779 Pin Controller
+title: MediaTek MT6779 Pin Controller
 
 maintainers:
   - Andy Teng <andy.teng@mediatek.com>
   - Sean Wang <sean.wang@kernel.org>
 
 description:
-  The MediaTek pin controller on MT6779 is used to control pin
-  functions, pull up/down resistance and drive strength options.
+  The MediaTek pin controller on MT6779 is used to control pin functions, pull
+  up/down resistance and drive strength options.
 
 properties:
   compatible:
@@ -29,22 +29,22 @@ properties:
 
   "#gpio-cells":
     const: 2
-    description: |
-      Number of cells in GPIO specifier. Since the generic GPIO
-      binding is used, the amount of cells must be specified as 2. See the below
-      mentioned gpio binding representation for description of particular cells.
+    description:
+      Number of cells in GPIO specifier. Since the generic GPIO binding is used,
+      the amount of cells must be specified as 2. See the below mentioned gpio
+      binding representation for description of particular cells.
 
   gpio-ranges:
     minItems: 1
     maxItems: 5
-    description: |
+    description:
       GPIO valid number range.
 
   interrupt-controller: true
 
   interrupts:
     maxItems: 1
-    description: |
+    description:
       Specifies the summary IRQ.
 
   "#interrupt-cells":
@@ -118,19 +118,20 @@ patternProperties:
     patternProperties:
       '-pins*$':
         type: object
-        description: |
+        description:
           A pinctrl node should contain at least one subnodes representing the
           pinctrl groups available on the machine. Each subnode will list the
           pins it needs, and how they should be configured, with regard to muxer
-          configuration, pullups, drive strength, input enable/disable and input schmitt.
+          configuration, pullups, drive strength, input enable/disable and input
+          schmitt.
         $ref: "/schemas/pinctrl/pincfg-node.yaml"
 
         properties:
           pinmux:
             description:
               integer array, represents gpio pin number and mux setting.
-              Supported pin number and mux varies for different SoCs, and are defined
-              as macros in boot/dts/<soc>-pinfunc.h directly.
+              Supported pin number and mux varies for different SoCs, and are
+              defined as macros in boot/dts/<soc>-pinfunc.h directly.
 
           bias-disable: true
 
@@ -159,7 +160,8 @@ patternProperties:
           mediatek,pull-up-adv:
             description: |
               Pull up setings for 2 pull resistors, R0 and R1. User can
-              configure those special pins. Valid arguments are described as below:
+              configure those special pins. Valid arguments are described as
+              below:
               0: (R1, R0) = (0, 0) which means R1 disabled and R0 disabled.
               1: (R1, R0) = (0, 1) which means R1 disabled and R0 enabled.
               2: (R1, R0) = (1, 0) which means R1 enabled and R0 disabled.
@@ -170,7 +172,8 @@ patternProperties:
           mediatek,pull-down-adv:
             description: |
               Pull down settings for 2 pull resistors, R0 and R1. User can
-              configure those special pins. Valid arguments are described as below:
+              configure those special pins. Valid arguments are described as
+              below:
               0: (R1, R0) = (0, 0) which means R1 disabled and R0 disabled.
               1: (R1, R0) = (0, 1) which means R1 disabled and R0 enabled.
               2: (R1, R0) = (1, 0) which means R1 enabled and R0 disabled.
diff --git a/Documentation/devicetree/bindings/pinctrl/mediatek,mt6795-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/mediatek,mt6795-pinctrl.yaml
index c5131f053b61..5bd78e88fea3 100644
--- a/Documentation/devicetree/bindings/pinctrl/mediatek,mt6795-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/mediatek,mt6795-pinctrl.yaml
@@ -4,14 +4,14 @@
 $id: http://devicetree.org/schemas/pinctrl/mediatek,mt6795-pinctrl.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: Mediatek MT6795 Pin Controller
+title: MediaTek MT6795 Pin Controller
 
 maintainers:
   - AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
   - Sean Wang <sean.wang@kernel.org>
 
-description: |
-  The Mediatek's Pin controller is used to control SoC pins.
+description:
+  The MediaTek's MT6795 Pin controller is used to control SoC pins.
 
 properties:
   compatible:
@@ -22,8 +22,8 @@ properties:
   '#gpio-cells':
     description: |
       Number of cells in GPIO specifier. Since the generic GPIO binding is used,
-      the amount of cells must be specified as 2. See the below
-      mentioned gpio binding representation for description of particular cells.
+      the amount of cells must be specified as 2. See the below mentioned gpio
+      binding representation for description of particular cells.
     const: 2
 
   gpio-ranges:
@@ -65,8 +65,8 @@ patternProperties:
           A pinctrl node should contain at least one subnodes representing the
           pinctrl groups available on the machine. Each subnode will list the
           pins it needs, and how they should be configured, with regard to muxer
-          configuration, pullups, drive strength, input enable/disable and
-          input schmitt.
+          configuration, pullups, drive strength, input enable/disable and input
+          schmitt.
           An example of using macro:
           pincontroller {
             /* GPIO0 set as multifunction GPIO0 */
@@ -86,11 +86,10 @@ patternProperties:
 
         properties:
           pinmux:
-            description: |
+            description:
               Integer array, represents gpio pin number and mux setting.
               Supported pin number and mux varies for different SoCs, and are
-              defined as macros in dt-bindings/pinctrl/<soc>-pinfunc.h
-              directly.
+              defined as macros in dt-bindings/pinctrl/<soc>-pinfunc.h directly.
 
           drive-strength:
             enum: [2, 4, 6, 8, 10, 12, 14, 16]
@@ -100,7 +99,7 @@ patternProperties:
               - type: boolean
               - enum: [100, 101, 102, 103]
                 description: mt6795 pull down PUPD/R0/R1 type define value.
-            description: |
+            description:
                For normal pull down type, it is not necessary to specify R1R0
                values; When pull down type is PUPD/R0/R1, adding R1R0 defines
                will set different resistance values.
@@ -110,10 +109,10 @@ patternProperties:
               - type: boolean
               - enum: [100, 101, 102, 103]
                 description: mt6795 pull up PUPD/R0/R1 type define value.
-            description: |
+            description:
                For normal pull up type, it is not necessary to specify R1R0
-               values; When pull up type is PUPD/R0/R1, adding R1R0 defines
-               will set different resistance values.
+               values; When pull up type is PUPD/R0/R1, adding R1R0 defines will
+               set different resistance values.
 
           bias-disable: true
 
@@ -132,7 +131,8 @@ patternProperties:
           mediatek,pull-up-adv:
             description: |
               Pull up setings for 2 pull resistors, R0 and R1. User can
-              configure those special pins. Valid arguments are described as below:
+              configure those special pins. Valid arguments are described as
+              below:
               0: (R1, R0) = (0, 0) which means R1 disabled and R0 disabled.
               1: (R1, R0) = (0, 1) which means R1 disabled and R0 enabled.
               2: (R1, R0) = (1, 0) which means R1 enabled and R0 disabled.
@@ -143,7 +143,8 @@ patternProperties:
           mediatek,pull-down-adv:
             description: |
               Pull down settings for 2 pull resistors, R0 and R1. User can
-              configure those special pins. Valid arguments are described as below:
+              configure those special pins. Valid arguments are described as
+              below:
               0: (R1, R0) = (0, 0) which means R1 disabled and R0 disabled.
               1: (R1, R0) = (0, 1) which means R1 disabled and R0 enabled.
               2: (R1, R0) = (1, 0) which means R1 enabled and R0 disabled.
diff --git a/Documentation/devicetree/bindings/pinctrl/mediatek,mt7620-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/mediatek,mt7620-pinctrl.yaml
index ea4a1194fbc4..2a5495a3a717 100644
--- a/Documentation/devicetree/bindings/pinctrl/mediatek,mt7620-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/mediatek,mt7620-pinctrl.yaml
@@ -10,7 +10,7 @@ maintainers:
   - Arınç ÜNAL <arinc.unal@arinc9.com>
   - Sergio Paracuellos <sergio.paracuellos@gmail.com>
 
-description:
+description: |
   MediaTek MT7620 pin controller for MT7620 SoC.
   The pin controller can only set the muxing of pin groups. Muxing individual
   pins is not supported. There is no pinconf support.
diff --git a/Documentation/devicetree/bindings/pinctrl/mediatek,mt7621-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/mediatek,mt7621-pinctrl.yaml
index 4dfe3da5fd40..1fc227c27bd0 100644
--- a/Documentation/devicetree/bindings/pinctrl/mediatek,mt7621-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/mediatek,mt7621-pinctrl.yaml
@@ -10,7 +10,7 @@ maintainers:
   - Arınç ÜNAL <arinc.unal@arinc9.com>
   - Sergio Paracuellos <sergio.paracuellos@gmail.com>
 
-description:
+description: |
   MediaTek MT7621 pin controller for MT7621 SoC.
   The pin controller can only set the muxing of pin groups. Muxing individual
   pins is not supported. There is no pinconf support.
diff --git a/Documentation/devicetree/bindings/pinctrl/mediatek,mt7622-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/mediatek,mt7622-pinctrl.yaml
index ac93eb8f01a6..740a26e1ede1 100644
--- a/Documentation/devicetree/bindings/pinctrl/mediatek,mt7622-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/mediatek,mt7622-pinctrl.yaml
@@ -4,12 +4,12 @@
 $id: http://devicetree.org/schemas/pinctrl/mediatek,mt7622-pinctrl.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: Mediatek MT7622 Pin Controller
+title: MediaTek MT7622 Pin Controller
 
 maintainers:
   - Sean Wang <sean.wang@kernel.org>
 
-description: |+
+description:
   The MediaTek's MT7622 Pin controller is used to control SoC pins.
 
 properties:
@@ -29,10 +29,10 @@ properties:
 
   "#gpio-cells":
     const: 2
-    description: |
-      Number of cells in GPIO specifier. Since the generic GPIO
-      binding is used, the amount of cells must be specified as 2. See the below
-      mentioned gpio binding representation for description of particular cells.
+    description:
+      Number of cells in GPIO specifier. Since the generic GPIO binding is used,
+      the amount of cells must be specified as 2. See the below mentioned gpio
+      binding representation for description of particular cells.
 
   interrupt-controller: true
 
@@ -68,18 +68,18 @@ patternProperties:
       '^mux(-|$)':
         type: object
         additionalProperties: false
-        description: |
+        description:
           pinmux configuration nodes.
         $ref: "/schemas/pinctrl/pinmux-node.yaml"
         properties:
           function:
-            description: |
+            description:
               A string containing the name of the function to mux to the group.
             enum: [emmc, eth, i2c, i2s, ir, led, flash, pcie, pmic, pwm, sd,
                    spi, tdm, uart, watchdog, wifi]
 
           groups:
-            description: |
+            description:
               An array of strings. Each string contains the name of a group.
 
           drive-strength:
@@ -247,7 +247,7 @@ patternProperties:
       '^conf(-|$)':
         type: object
         additionalProperties: false
-        description: |
+        description:
           pinconf configuration nodes.
         $ref: "/schemas/pinctrl/pincfg-node.yaml"
 
@@ -258,7 +258,7 @@ patternProperties:
               Valid values are the same as the pinmux node.
 
           pins:
-            description: |
+            description:
               An array of strings. Each string contains the name of a pin.
             enum: [GPIO_A, I2S1_IN, I2S1_OUT, I2S_BCLK, I2S_WS, I2S_MCLK, TXD0,
                    RXD0, SPI_WP, SPI_HOLD, SPI_CLK, SPI_MOSI, SPI_MISO, SPI_CS,
@@ -315,14 +315,14 @@ patternProperties:
             enum: [0, 1]
 
           mediatek,tdsel:
-            description: |
+            description:
               An integer describing the steps for output level shifter duty
               cycle when asserted (high pulse width adjustment). Valid arguments
               are from 0 to 15.
             $ref: /schemas/types.yaml#/definitions/uint32
 
           mediatek,rdsel:
-            description: |
+            description:
               An integer describing the steps for input level shifter duty cycle
               when asserted (high pulse width adjustment). Valid arguments are
               from 0 to 63.
diff --git a/Documentation/devicetree/bindings/pinctrl/mediatek,mt76x8-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/mediatek,mt76x8-pinctrl.yaml
index c818c8947866..48d563886e57 100644
--- a/Documentation/devicetree/bindings/pinctrl/mediatek,mt76x8-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/mediatek,mt76x8-pinctrl.yaml
@@ -10,7 +10,7 @@ maintainers:
   - Arınç ÜNAL <arinc.unal@arinc9.com>
   - Sergio Paracuellos <sergio.paracuellos@gmail.com>
 
-description:
+description: |
   MediaTek MT76X8 pin controller for MT7628 and MT7688 SoCs.
   The pin controller can only set the muxing of pin groups. Muxing individual
   pins is not supported. There is no pinconf support.
diff --git a/Documentation/devicetree/bindings/pinctrl/mediatek,mt7981-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/mediatek,mt7981-pinctrl.yaml
index 74c66fbcb2ae..10717cee9058 100644
--- a/Documentation/devicetree/bindings/pinctrl/mediatek,mt7981-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/mediatek,mt7981-pinctrl.yaml
@@ -4,7 +4,7 @@
 $id: http://devicetree.org/schemas/pinctrl/mediatek,mt7981-pinctrl.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: Mediatek MT7981 Pin Controller
+title: MediaTek MT7981 Pin Controller
 
 maintainers:
   - Daniel Golle <daniel@makrotopia.org>
@@ -37,7 +37,7 @@ properties:
 
   "#gpio-cells":
     const: 2
-    description: >
+    description:
       Number of cells in GPIO specifier. Since the generic GPIO binding is used,
       the amount of cells must be specified as 2. See the below mentioned gpio
       binding representation for description of particular cells.
@@ -111,7 +111,9 @@ patternProperties:
           "watchdog1"            "watchdog"  13
           "udi"                  "udi"       9, 10, 11, 12, 13
           "drv_vbus"             "usb"       14
-          "emmc_45"              "flash"     15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25
+          "emmc_45"              "flash"     15, 16, 17, 18, 19, 20, 21, 22, 23,
+                                             24, 25
+
           "snfi"                 "flash"     16, 17, 18, 19, 20, 21
           "spi0"                 "spi"       16, 17, 18, 19
           "spi0_wp_hold"         "spi"       20, 21
@@ -148,7 +150,7 @@ patternProperties:
           "wf5g_led0"            "led"       31
           "wf5g_led1"            "led"       35
           "mt7531_int"           "eth"       38
-          "ant_sel"              "ant"       14, 15, 16, 17, 18, 19, 20, 21, 22
+          "ant_sel"              "ant"       14, 15, 16, 17, 18, 19, 20, 21, 22,
                                              23, 24, 25, 34, 35
 
         $ref: /schemas/pinctrl/pinmux-node.yaml
@@ -256,7 +258,8 @@ patternProperties:
             then:
               properties:
                 groups:
-                  enum: [gbe_led0, gbe_led1, wf2g_led0, wf2g_led1, wf5g_led0, wf5g_led1]
+                  enum: [gbe_led0, gbe_led1, wf2g_led0, wf2g_led1, wf5g_led0,
+                         wf5g_led1]
           - if:
               properties:
                 function:
@@ -275,7 +278,8 @@ patternProperties:
               properties:
                 groups:
                   items:
-                    enum: [spi1_0, spi0, spi0_wp_hold, spi1_1, spi2, spi2_wp_hold]
+                    enum: [spi1_0, spi0, spi0_wp_hold, spi1_1, spi2,
+                           spi2_wp_hold]
                   maxItems: 4
           - if:
               properties:
@@ -332,13 +336,14 @@ patternProperties:
                      JTAG_JTDO, JTAG_JTDI, JTAG_JTMS, JTAG_JTCLK, JTAG_JTRST_N,
                      WO_JTAG_JTDO, WO_JTAG_JTDI, WO_JTAG_JTMS, WO_JTAG_JTCLK,
                      WO_JTAG_JTRST_N, USB_VBUS, PWM0, SPI0_CLK, SPI0_MOSI,
-                     SPI0_MISO, SPI0_CS, SPI0_HOLD, SPI0_WP, SPI1_CLK, SPI1_MOSI,
-                     SPI1_MISO, SPI1_CS, SPI2_CLK, SPI2_MOSI, SPI2_MISO, SPI2_CS,
-                     SPI2_HOLD, SPI2_WP, UART0_RXD, UART0_TXD, PCIE_CLK_REQ,
-                     PCIE_WAKE_N, SMI_MDC, SMI_MDIO, GBE_INT, GBE_RESET,
-                     WF_DIG_RESETB, WF_CBA_RESETB, WF_XO_REQ, WF_TOP_CLK,
-                     WF_TOP_DATA, WF_HB1, WF_HB2, WF_HB3, WF_HB4, WF_HB0,
-                     WF_HB0_B, WF_HB5, WF_HB6, WF_HB7, WF_HB8, WF_HB9, WF_HB10]
+                     SPI0_MISO, SPI0_CS, SPI0_HOLD, SPI0_WP, SPI1_CLK,
+                     SPI1_MOSI, SPI1_MISO, SPI1_CS, SPI2_CLK, SPI2_MOSI,
+                     SPI2_MISO, SPI2_CS, SPI2_HOLD, SPI2_WP, UART0_RXD,
+                     UART0_TXD, PCIE_CLK_REQ, PCIE_WAKE_N, SMI_MDC, SMI_MDIO,
+                     GBE_INT, GBE_RESET, WF_DIG_RESETB, WF_CBA_RESETB,
+                     WF_XO_REQ, WF_TOP_CLK, WF_TOP_DATA, WF_HB1, WF_HB2, WF_HB3,
+                     WF_HB4, WF_HB0, WF_HB0_B, WF_HB5, WF_HB6, WF_HB7, WF_HB8,
+                     WF_HB9, WF_HB10]
             maxItems: 57
 
           bias-disable: true
@@ -348,7 +353,7 @@ patternProperties:
               - type: boolean
                 description: normal pull up.
               - enum: [100, 101, 102, 103]
-                description: >
+                description:
                   PUPD/R1/R0 pull down type. See MTK_PUPD_SET_R1R0 defines in
                   dt-bindings/pinctrl/mt65xx.h.
 
@@ -357,7 +362,7 @@ patternProperties:
               - type: boolean
                 description: normal pull down.
               - enum: [100, 101, 102, 103]
-                description: >
+                description:
                   PUPD/R1/R0 pull down type. See MTK_PUPD_SET_R1R0 defines in
                   dt-bindings/pinctrl/mt65xx.h.
 
diff --git a/Documentation/devicetree/bindings/pinctrl/mediatek,mt7986-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/mediatek,mt7986-pinctrl.yaml
index 216b356cd519..f5e982375b44 100644
--- a/Documentation/devicetree/bindings/pinctrl/mediatek,mt7986-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/mediatek,mt7986-pinctrl.yaml
@@ -4,12 +4,12 @@
 $id: http://devicetree.org/schemas/pinctrl/mediatek,mt7986-pinctrl.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: Mediatek MT7986 Pin Controller
+title: MediaTek MT7986 Pin Controller
 
 maintainers:
   - Sean Wang <sean.wang@kernel.org>
 
-description: |+
+description:
   The MediaTek's MT7986 Pin controller is used to control SoC pins.
 
 properties:
@@ -37,15 +37,15 @@ properties:
 
   "#gpio-cells":
     const: 2
-    description: |
-      Number of cells in GPIO specifier. Since the generic GPIO
-      binding is used, the amount of cells must be specified as 2. See the below
-      mentioned gpio binding representation for description of particular cells.
+    description:
+      Number of cells in GPIO specifier. Since the generic GPIO binding is used,
+      the amount of cells must be specified as 2. See the below mentioned gpio
+      binding representation for description of particular cells.
 
   gpio-ranges:
     minItems: 1
     maxItems: 5
-    description: |
+    description:
       GPIO valid number range.
 
   interrupt-controller: true
@@ -72,7 +72,7 @@ patternProperties:
     additionalProperties: false
 
     patternProperties:
-      '.*mux.*':
+      '^.*mux.*$':
         type: object
         additionalProperties: false
         description: |
@@ -81,7 +81,7 @@ patternProperties:
           The following table shows the effective values of "group", "function"
           properties and chip pinout pins
 
-          groups	    function    pins (in pin#)
+          groups            function    pins (in pin#)
           ---------------------------------------------------------------------
           "watchdog"        "watchdog"  0
           "wifi_led"        "led"       1, 2
@@ -97,8 +97,9 @@ patternProperties:
           "pwm1_0"          "pwm"       22,
           "snfi"            "flash"     23, 24, 25, 26, 27, 28
           "spi1_2"          "spi"       29, 30, 31, 32
-          "emmc_45"         "emmc"      22, 23, 24, 25, 26, 27, 28, 29, 30,
-                                        31, 32
+          "emmc_45"         "emmc"      22, 23, 24, 25, 26, 27, 28, 29, 30, 31,
+                                        32
+
           "spi1_1"          "spi"       23, 24, 25, 26
           "uart1_2_rx_tx"   "uart"      29, 30
           "uart1_2_cts_rts" "uart"      31, 32
@@ -115,8 +116,9 @@ patternProperties:
           "pcie_pereset"    "pcie"      41
           "uart1"           "uart"      42, 43, 44, 45
           "uart2"           "uart"      46, 47, 48, 49
-          "emmc_51"         "emmc"      50, 51, 52, 53, 54, 55, 56, 57, 57,
-                                        59, 60, 61
+          "emmc_51"         "emmc"      50, 51, 52, 53, 54, 55, 56, 57, 58, 59,
+                                        60, 61
+
           "pcm"             "audio"     62, 63, 64, 65
           "i2s"             "audio"     62, 63, 64, 65
           "switch_int"      "eth"       66
@@ -129,18 +131,17 @@ patternProperties:
         $ref: "/schemas/pinctrl/pinmux-node.yaml"
         properties:
           function:
-            description: |
+            description:
               A string containing the name of the function to mux to the group.
               There is no "audio", "pcie" functions on mt7986b, you can only use
               those functions on mt7986a.
             enum: [audio, emmc, eth, i2c, led, flash, pcie, pwm, spi, uart,
                    watchdog, wifi]
           groups:
-            description: |
+            description:
               An array of strings. Each string contains the name of a group.
-              There is no "pcie_pereset", "uart1", "uart2" "emmc_51", "pcm",
-              and "i2s" groups on mt7986b, you can only use those groups on
-              mt7986a.
+              There is no "pcie_pereset", "uart1", "uart2" "emmc_51", "pcm", and
+              "i2s" groups on mt7986b, you can only use those groups on mt7986a.
         required:
           - function
           - groups
@@ -258,7 +259,7 @@ patternProperties:
       '.*conf.*':
         type: object
         additionalProperties: false
-        description: |
+        description:
           pinconf configuration nodes.
         $ref: "/schemas/pinctrl/pincfg-node.yaml"
 
@@ -271,16 +272,17 @@ patternProperties:
             items:
               enum: [SYS_WATCHDOG, WF2G_LED, WF5G_LED, I2C_SCL, I2C_SDA, GPIO_0,
                      GPIO_1, GPIO_2, GPIO_3, GPIO_4, GPIO_5, GPIO_6, GPIO_7,
-                     GPIO_8, GPIO_9, GPIO_10, GPIO_11, GPIO_12, GPIO_13, GPIO_14,
-                     GPIO_15, PWM0, PWM1, SPI0_CLK, SPI0_MOSI, SPI0_MISO, SPI0_CS,
-                     SPI0_HOLD, SPI0_WP, SPI1_CLK, SPI1_MOSI, SPI1_MISO, SPI1_CS,
-                     SPI2_CLK, SPI2_MOSI, SPI2_MISO, SPI2_CS, SPI2_HOLD, SPI2_WP,
-                     UART0_RXD, UART0_TXD, PCIE_PERESET_N, UART1_RXD, UART1_TXD,
-                     UART1_CTS, UART1_RTS, UART2_RXD, UART2_TXD, UART2_CTS,
-                     UART2_RTS, EMMC_DATA_0, EMMC_DATA_1, EMMC_DATA_2,
-                     EMMC_DATA_3, EMMC_DATA_4, EMMC_DATA_5, EMMC_DATA_6,
-                     EMMC_DATA_7, EMMC_CMD, EMMC_CK, EMMC_DSL, EMMC_RSTB, PCM_DTX,
-                     PCM_DRX, PCM_CLK, PCM_FS, MT7531_INT, SMI_MDC, SMI_MDIO,
+                     GPIO_8, GPIO_9, GPIO_10, GPIO_11, GPIO_12, GPIO_13,
+                     GPIO_14, GPIO_15, PWM0, PWM1, SPI0_CLK, SPI0_MOSI,
+                     SPI0_MISO, SPI0_CS, SPI0_HOLD, SPI0_WP, SPI1_CLK,
+                     SPI1_MOSI, SPI1_MISO, SPI1_CS, SPI2_CLK, SPI2_MOSI,
+                     SPI2_MISO, SPI2_CS, SPI2_HOLD, SPI2_WP, UART0_RXD,
+                     UART0_TXD, PCIE_PERESET_N, UART1_RXD, UART1_TXD, UART1_CTS,
+                     UART1_RTS, UART2_RXD, UART2_TXD, UART2_CTS, UART2_RTS,
+                     EMMC_DATA_0, EMMC_DATA_1, EMMC_DATA_2, EMMC_DATA_3,
+                     EMMC_DATA_4, EMMC_DATA_5, EMMC_DATA_6, EMMC_DATA_7,
+                     EMMC_CMD, EMMC_CK, EMMC_DSL, EMMC_RSTB, PCM_DTX, PCM_DRX,
+                     PCM_CLK, PCM_FS, MT7531_INT, SMI_MDC, SMI_MDIO,
                      WF0_DIG_RESETB, WF0_CBA_RESETB, WF0_XO_REQ, WF0_TOP_CLK,
                      WF0_TOP_DATA, WF0_HB1, WF0_HB2, WF0_HB3, WF0_HB4, WF0_HB0,
                      WF0_HB0_B, WF0_HB5, WF0_HB6, WF0_HB7, WF0_HB8, WF0_HB9,
@@ -297,7 +299,7 @@ patternProperties:
               - type: boolean
                 description: normal pull up.
               - enum: [100, 101, 102, 103]
-                description: |
+                description:
                   PUPD/R1/R0 pull down type. See MTK_PUPD_SET_R1R0 defines in
                   dt-bindings/pinctrl/mt65xx.h.
 
@@ -306,7 +308,7 @@ patternProperties:
               - type: boolean
                 description: normal pull down.
               - enum: [100, 101, 102, 103]
-                description: |
+                description:
                   PUPD/R1/R0 pull down type. See MTK_PUPD_SET_R1R0 defines in
                   dt-bindings/pinctrl/mt65xx.h.
 
diff --git a/Documentation/devicetree/bindings/pinctrl/mediatek,mt8183-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/mediatek,mt8183-pinctrl.yaml
index c30cd0d010dd..3b1be7949e8c 100644
--- a/Documentation/devicetree/bindings/pinctrl/mediatek,mt8183-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/mediatek,mt8183-pinctrl.yaml
@@ -4,12 +4,12 @@
 $id: http://devicetree.org/schemas/pinctrl/mediatek,mt8183-pinctrl.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: Mediatek MT8183 Pin Controller
+title: MediaTek MT8183 Pin Controller
 
 maintainers:
   - Sean Wang <sean.wang@kernel.org>
 
-description: |+
+description:
   The MediaTek's MT8183 Pin controller is used to control SoC pins.
 
 properties:
@@ -37,15 +37,15 @@ properties:
 
   "#gpio-cells":
     const: 2
-    description: |
-      Number of cells in GPIO specifier. Since the generic GPIO
-      binding is used, the amount of cells must be specified as 2. See the below
-      mentioned gpio binding representation for description of particular cells.
+    description:
+      Number of cells in GPIO specifier. Since the generic GPIO binding is used,
+      the amount of cells must be specified as 2. See the below mentioned gpio
+      binding representation for description of particular cells.
 
   gpio-ranges:
     minItems: 1
     maxItems: 5
-    description: |
+    description:
       GPIO valid number range.
 
   interrupt-controller: true
@@ -74,7 +74,7 @@ patternProperties:
       '^pins':
         type: object
         additionalProperties: false
-        description: |
+        description:
           A pinctrl node should contain at least one subnodes representing the
           pinctrl groups available on the machine. Each subnode will list the
           pins it needs, and how they should be configured, with regard to muxer
@@ -139,7 +139,8 @@ patternProperties:
           mediatek,pull-up-adv:
             description: |
               Pull up setings for 2 pull resistors, R0 and R1. User can
-              configure those special pins. Valid arguments are described as below:
+              configure those special pins. Valid arguments are described as
+              below:
               0: (R1, R0) = (0, 0) which means R1 disabled and R0 disabled.
               1: (R1, R0) = (0, 1) which means R1 disabled and R0 enabled.
               2: (R1, R0) = (1, 0) which means R1 enabled and R0 disabled.
@@ -150,7 +151,8 @@ patternProperties:
           mediatek,pull-down-adv:
             description: |
               Pull down settings for 2 pull resistors, R0 and R1. User can
-              configure those special pins. Valid arguments are described as below:
+              configure those special pins. Valid arguments are described as
+              below:
               0: (R1, R0) = (0, 0) which means R1 disabled and R0 disabled.
               1: (R1, R0) = (0, 1) which means R1 disabled and R0 enabled.
               2: (R1, R0) = (1, 0) which means R1 enabled and R0 disabled.
@@ -159,14 +161,14 @@ patternProperties:
             enum: [0, 1, 2, 3]
 
           mediatek,tdsel:
-            description: |
+            description:
               An integer describing the steps for output level shifter duty
               cycle when asserted (high pulse width adjustment). Valid arguments
               are from 0 to 15.
             $ref: /schemas/types.yaml#/definitions/uint32
 
           mediatek,rdsel:
-            description: |
+            description:
               An integer describing the steps for input level shifter duty cycle
               when asserted (high pulse width adjustment). Valid arguments are
               from 0 to 63.
diff --git a/Documentation/devicetree/bindings/pinctrl/mediatek,mt8186-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/mediatek,mt8186-pinctrl.yaml
index 32d64416eb16..c7abc13a167d 100644
--- a/Documentation/devicetree/bindings/pinctrl/mediatek,mt8186-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/mediatek,mt8186-pinctrl.yaml
@@ -4,13 +4,13 @@
 $id: http://devicetree.org/schemas/pinctrl/mediatek,mt8186-pinctrl.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: Mediatek MT8186 Pin Controller
+title: MediaTek MT8186 Pin Controller
 
 maintainers:
   - Sean Wang <sean.wang@mediatek.com>
 
-description: |
-  The Mediatek's Pin controller is used to control SoC pins.
+description:
+  The MediaTek's MT8186 Pin controller is used to control SoC pins.
 
 properties:
   compatible:
@@ -19,10 +19,10 @@ properties:
   gpio-controller: true
 
   '#gpio-cells':
-    description: |
+    description:
       Number of cells in GPIO specifier. Since the generic GPIO binding is used,
-      the amount of cells must be specified as 2. See the below
-      mentioned gpio binding representation for description of particular cells.
+      the amount of cells must be specified as 2. See the below mentioned gpio
+      binding representation for description of particular cells.
     const: 2
 
   gpio-ranges:
@@ -31,13 +31,13 @@ properties:
   gpio-line-names: true
 
   reg:
-    description: |
+    description:
       Physical address base for gpio base registers. There are 8 different GPIO
       physical address base in mt8186.
     maxItems: 8
 
   reg-names:
-    description: |
+    description:
       Gpio base register names.
     items:
       - const: iocfg0
@@ -60,9 +60,9 @@ properties:
 
   mediatek,rsel-resistance-in-si-unit:
     type: boolean
-    description: |
-      Identifying i2c pins pull up/down type which is RSEL. It can support
-      RSEL define or si unit value(ohm) to set different resistance.
+    description:
+      Identifying i2c pins pull up/down type which is RSEL. It can support RSEL
+      define or si unit value(ohm) to set different resistance.
 
 # PIN CONFIGURATION NODES
 patternProperties:
@@ -77,8 +77,8 @@ patternProperties:
           A pinctrl node should contain at least one subnodes representing the
           pinctrl groups available on the machine. Each subnode will list the
           pins it needs, and how they should be configured, with regard to muxer
-          configuration, pullups, drive strength, input enable/disable and
-          input schmitt.
+          configuration, pullups, drive strength, input enable/disable and input
+          schmitt.
           An example of using macro:
           pincontroller {
             /* GPIO0 set as multifunction GPIO0 */
@@ -98,11 +98,10 @@ patternProperties:
 
         properties:
           pinmux:
-            description: |
+            description:
               Integer array, represents gpio pin number and mux setting.
               Supported pin number and mux varies for different SoCs, and are
-              defined as macros in dt-bindings/pinctrl/<soc>-pinfunc.h
-              directly.
+              defined as macros in dt-bindings/pinctrl/<soc>-pinfunc.h directly.
 
           drive-strength:
             enum: [2, 4, 6, 8, 10, 12, 14, 16]
@@ -129,10 +128,10 @@ patternProperties:
               For pull down type is RSEL, it can add RSEL define & resistance
               value(ohm) to set different resistance by identifying property
               "mediatek,rsel-resistance-in-si-unit".
-              It can support "MTK_PULL_SET_RSEL_000" & "MTK_PULL_SET_RSEL_001"
-              & "MTK_PULL_SET_RSEL_010" & "MTK_PULL_SET_RSEL_011"
-              define in mt8186. It can also support resistance value(ohm)
-              "75000" & "5000" in mt8186.
+              It can support "MTK_PULL_SET_RSEL_000" & "MTK_PULL_SET_RSEL_001" &
+              "MTK_PULL_SET_RSEL_010" & "MTK_PULL_SET_RSEL_011" define in
+              mt8186. It can also support resistance value(ohm) "75000" & "5000"
+              in mt8186.
               An example of using RSEL define:
               pincontroller {
                 i2c0_pin {
@@ -174,10 +173,10 @@ patternProperties:
               For pull up type is RSEL, it can add RSEL define & resistance
               value(ohm) to set different resistance by identifying property
               "mediatek,rsel-resistance-in-si-unit".
-              It can support "MTK_PULL_SET_RSEL_000" & "MTK_PULL_SET_RSEL_001"
-              & "MTK_PULL_SET_RSEL_010" & "MTK_PULL_SET_RSEL_011"
-              define in mt8186. It can also support resistance value(ohm)
-              "1000" & "5000" & "10000" & "75000" in mt8186.
+              It can support "MTK_PULL_SET_RSEL_000" & "MTK_PULL_SET_RSEL_001" &
+              "MTK_PULL_SET_RSEL_010" & "MTK_PULL_SET_RSEL_011" define in
+              mt8186. It can also support resistance value(ohm) "1000" & "5000"
+              & "10000" & "75000" in mt8186.
               An example of using si unit resistance value(ohm):
               &pio {
                 mediatek,rsel-resistance-in-si-unit;
diff --git a/Documentation/devicetree/bindings/pinctrl/mediatek,mt8188-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/mediatek,mt8188-pinctrl.yaml
index 7e750f1e643d..51b3d1247614 100644
--- a/Documentation/devicetree/bindings/pinctrl/mediatek,mt8188-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/mediatek,mt8188-pinctrl.yaml
@@ -9,7 +9,7 @@ title: MediaTek MT8188 Pin Controller
 maintainers:
   - Hui Liu <hui.liu@mediatek.com>
 
-description: |
+description:
   The MediaTek's MT8188 Pin controller is used to control SoC pins.
 
 properties:
@@ -19,10 +19,10 @@ properties:
   gpio-controller: true
 
   '#gpio-cells':
-    description: |
-      Number of cells in GPIO specifier, should be two. The first cell
-      is the pin number, the second cell is used to specify optional
-      parameters which are defined in <dt-bindings/gpio/gpio.h>.
+    description:
+      Number of cells in GPIO specifier, should be two. The first cell is the
+      pin number, the second cell is used to specify optional parameters which
+      are defined in <dt-bindings/gpio/gpio.h>.
     const: 2
 
   gpio-ranges:
@@ -59,10 +59,11 @@ properties:
 
   mediatek,rsel-resistance-in-si-unit:
     type: boolean
-    description: |
-      We provide two methods to select the resistance for I2C when pull up or pull down.
-      The first is by RSEL definition value, another one is by resistance value(ohm).
-      This flag is used to identify if the method is resistance(si unit) value.
+    description:
+      We provide two methods to select the resistance for I2C when pull up or
+      pull down. The first is by RSEL definition value, another one is by
+      resistance value(ohm). This flag is used to identify if the method is
+      resistance(si unit) value.
 
 # PIN CONFIGURATION NODES
 patternProperties:
@@ -75,16 +76,16 @@ patternProperties:
         type: object
         $ref: "/schemas/pinctrl/pincfg-node.yaml"
         additionalProperties: false
-        description: |
+        description:
           A pinctrl node should contain at least one subnode representing the
           pinctrl groups available on the machine. Each subnode will list the
           pins it needs, and how they should be configured, with regard to muxer
-          configuration, pullups, drive strength, input enable/disable and
-          input schmitt.
+          configuration, pullups, drive strength, input enable/disable and input
+          schmitt.
 
         properties:
           pinmux:
-            description: |
+            description:
               Integer array, represents gpio pin number and mux setting.
               Supported pin number and mux varies for different SoCs, and are
               defined as macros in dt-bindings/pinctrl/mediatek,<soc>-pinfunc.h
@@ -106,18 +107,21 @@ patternProperties:
               - enum: [75000, 5000]
                 description: mt8188 pull down RSEL type si unit value(ohm).
             description: |
-              For pull down type is normal, it doesn't need add RSEL & R1R0 define
-              and resistance value.
+              For pull down type is normal, it doesn't need add RSEL & R1R0
+              define and resistance value.
               For pull down type is PUPD/R0/R1 type, it can add R1R0 define to
               set different resistance. It can support "MTK_PUPD_SET_R1R0_00" &
-              "MTK_PUPD_SET_R1R0_01" & "MTK_PUPD_SET_R1R0_10" & "MTK_PUPD_SET_R1R0_11"
-              define in mt8188.
-              For pull down type is RSEL, it can add RSEL define & resistance value(ohm)
-              to set different resistance by identifying property "mediatek,rsel-resistance-in-si-unit".
-              It can support "MTK_PULL_SET_RSEL_000" & "MTK_PULL_SET_RSEL_001"
-              & "MTK_PULL_SET_RSEL_010" & "MTK_PULL_SET_RSEL_011" & "MTK_PULL_SET_RSEL_100"
-              & "MTK_PULL_SET_RSEL_101" & "MTK_PULL_SET_RSEL_110" & "MTK_PULL_SET_RSEL_111"
-              define in mt8188. It can also support resistance value(ohm) "75000" & "5000" in mt8188.
+              "MTK_PUPD_SET_R1R0_01" & "MTK_PUPD_SET_R1R0_10" &
+              "MTK_PUPD_SET_R1R0_11" define in mt8188.
+              For pull down type is RSEL, it can add RSEL define & resistance
+              value(ohm) to set different resistance by identifying property
+              "mediatek,rsel-resistance-in-si-unit". It can support
+              "MTK_PULL_SET_RSEL_000" & "MTK_PULL_SET_RSEL_001" &
+              "MTK_PULL_SET_RSEL_010" & "MTK_PULL_SET_RSEL_011" &
+              "MTK_PULL_SET_RSEL_100" & "MTK_PULL_SET_RSEL_101" &
+              "MTK_PULL_SET_RSEL_110" & "MTK_PULL_SET_RSEL_111" define in
+              mt8188. It can also support resistance value(ohm) "75000" & "5000"
+              in mt8188.
 
           bias-pull-up:
             oneOf:
@@ -131,17 +135,19 @@ patternProperties:
             description: |
               For pull up type is normal, it don't need add RSEL & R1R0 define
               and resistance value.
-              For pull up type is PUPD/R0/R1 type, it can add R1R0 define to
-              set different resistance. It can support "MTK_PUPD_SET_R1R0_00" &
-              "MTK_PUPD_SET_R1R0_01" & "MTK_PUPD_SET_R1R0_10" & "MTK_PUPD_SET_R1R0_11"
-              define in mt8188.
-              For pull up type is RSEL, it can add RSEL define & resistance value(ohm)
-              to set different resistance by identifying property "mediatek,rsel-resistance-in-si-unit".
-              It can support "MTK_PULL_SET_RSEL_000" & "MTK_PULL_SET_RSEL_001"
-              & "MTK_PULL_SET_RSEL_010" & "MTK_PULL_SET_RSEL_011" & "MTK_PULL_SET_RSEL_100"
-              & "MTK_PULL_SET_RSEL_101" & "MTK_PULL_SET_RSEL_110" & "MTK_PULL_SET_RSEL_111"
-              define in mt8188. It can also support resistance value(ohm)
-              "1000" & "1500" & "2000" & "3000" & "4000" & "5000" & "10000" & "75000" in mt8188.
+              For pull up type is PUPD/R0/R1 type, it can add R1R0 define to set
+              different resistance. It can support "MTK_PUPD_SET_R1R0_00" &
+              "MTK_PUPD_SET_R1R0_01" & "MTK_PUPD_SET_R1R0_10" &
+              "MTK_PUPD_SET_R1R0_11" define in mt8188.
+              For pull up type is RSEL, it can add RSEL define & resistance
+              value(ohm) to set different resistance by identifying property
+              "mediatek,rsel-resistance-in-si-unit". It can support
+              "MTK_PULL_SET_RSEL_000" & "MTK_PULL_SET_RSEL_001" &
+              "MTK_PULL_SET_RSEL_010" & "MTK_PULL_SET_RSEL_011" &
+              "MTK_PULL_SET_RSEL_100" & "MTK_PULL_SET_RSEL_101" &
+              "MTK_PULL_SET_RSEL_110" & "MTK_PULL_SET_RSEL_111" define in
+              mt8188. It can also support resistance value(ohm) "1000" & "1500"
+              & "2000" & "3000" & "4000" & "5000" & "10000" & "75000" in mt8188.
 
           bias-disable: true
 
diff --git a/Documentation/devicetree/bindings/pinctrl/mediatek,mt8192-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/mediatek,mt8192-pinctrl.yaml
index e764cb0f8c1a..88a466769938 100644
--- a/Documentation/devicetree/bindings/pinctrl/mediatek,mt8192-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/mediatek,mt8192-pinctrl.yaml
@@ -4,13 +4,13 @@
 $id: http://devicetree.org/schemas/pinctrl/mediatek,mt8192-pinctrl.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: Mediatek MT8192 Pin Controller
+title: MediaTek MT8192 Pin Controller
 
 maintainers:
   - Sean Wang <sean.wang@mediatek.com>
 
-description: |
-  The Mediatek's Pin controller is used to control SoC pins.
+description:
+  The MediaTek's MT8192 Pin controller is used to control SoC pins.
 
 properties:
   compatible:
@@ -19,10 +19,10 @@ properties:
   gpio-controller: true
 
   '#gpio-cells':
-    description: |
+    description:
       Number of cells in GPIO specifier. Since the generic GPIO binding is used,
-      the amount of cells must be specified as 2. See the below
-      mentioned gpio binding representation for description of particular cells.
+      the amount of cells must be specified as 2. See the below mentioned gpio
+      binding representation for description of particular cells.
     const: 2
 
   gpio-ranges:
@@ -32,13 +32,13 @@ properties:
   gpio-line-names: true
 
   reg:
-    description: |
-      Physical address base for gpio base registers. There are 11 GPIO
-      physical address base in mt8192.
+    description:
+      Physical address base for gpio base registers. There are 11 GPIO physical
+      address base in mt8192.
     maxItems: 11
 
   reg-names:
-    description: |
+    description:
       Gpio base register names.
     maxItems: 11
 
@@ -59,25 +59,26 @@ patternProperties:
     patternProperties:
       '^pins':
         type: object
-        description: |
+        description:
           A pinctrl node should contain at least one subnodes representing the
           pinctrl groups available on the machine. Each subnode will list the
           pins it needs, and how they should be configured, with regard to muxer
-          configuration, pullups, drive strength, input enable/disable and
-          input schmitt.
+          configuration, pullups, drive strength, input enable/disable and input
+          schmitt.
         $ref: "pinmux-node.yaml"
 
         properties:
           pinmux:
-            description: |
+            description:
               Integer array, represents gpio pin number and mux setting.
-              Supported pin number and mux varies for different SoCs, and are defined
-              as macros in dt-bindings/pinctrl/<soc>-pinfunc.h directly.
+              Supported pin number and mux varies for different SoCs, and are
+              defined as macros in dt-bindings/pinctrl/<soc>-pinfunc.h directly.
 
           drive-strength:
-            description: |
-              It can support some arguments, such as MTK_DRIVE_4mA, MTK_DRIVE_6mA, etc. See
-              dt-bindings/pinctrl/mt65xx.h. It can only support 2/4/6/8/10/12/14/16mA in mt8192.
+            description:
+              It can support some arguments, such as MTK_DRIVE_4mA,
+              MTK_DRIVE_6mA, etc. See dt-bindings/pinctrl/mt65xx.h. It can only
+              support 2/4/6/8/10/12/14/16mA in mt8192.
             enum: [2, 4, 6, 8, 10, 12, 14, 16]
 
           drive-strength-microamp:
@@ -91,8 +92,8 @@ patternProperties:
                 description: PUPD/R1/R0 pull down type. See MTK_PUPD_SET_R1R0_
                   defines in dt-bindings/pinctrl/mt65xx.h.
               - enum: [200, 201, 202, 203]
-                description: RSEL pull down type. See MTK_PULL_SET_RSEL_
-                  defines in dt-bindings/pinctrl/mt65xx.h.
+                description: RSEL pull down type. See MTK_PULL_SET_RSEL_ defines
+                  in dt-bindings/pinctrl/mt65xx.h.
 
           bias-pull-up:
             oneOf:
@@ -102,8 +103,8 @@ patternProperties:
                 description: PUPD/R1/R0 pull up type. See MTK_PUPD_SET_R1R0_
                   defines in dt-bindings/pinctrl/mt65xx.h.
               - enum: [200, 201, 202, 203]
-                description: RSEL pull up type. See MTK_PULL_SET_RSEL_
-                  defines in dt-bindings/pinctrl/mt65xx.h.
+                description: RSEL pull up type. See MTK_PULL_SET_RSEL_ defines
+                  in dt-bindings/pinctrl/mt65xx.h.
 
           bias-disable: true
 
diff --git a/Documentation/devicetree/bindings/pinctrl/mediatek,mt8195-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/mediatek,mt8195-pinctrl.yaml
index 7b3dfc14eedc..c1c8c99ba139 100644
--- a/Documentation/devicetree/bindings/pinctrl/mediatek,mt8195-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/mediatek,mt8195-pinctrl.yaml
@@ -4,13 +4,13 @@
 $id: http://devicetree.org/schemas/pinctrl/mediatek,mt8195-pinctrl.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: Mediatek MT8195 Pin Controller
+title: MediaTek MT8195 Pin Controller
 
 maintainers:
   - Sean Wang <sean.wang@mediatek.com>
 
-description: |
-  The Mediatek's Pin controller is used to control SoC pins.
+description:
+  The MediaTek's MT8195 Pin controller is used to control SoC pins.
 
 properties:
   compatible:
@@ -19,10 +19,10 @@ properties:
   gpio-controller: true
 
   '#gpio-cells':
-    description: |
+    description:
       Number of cells in GPIO specifier. Since the generic GPIO binding is used,
-      the amount of cells must be specified as 2. See the below
-      mentioned gpio binding representation for description of particular cells.
+      the amount of cells must be specified as 2. See the below mentioned gpio
+      binding representation for description of particular cells.
     const: 2
 
   gpio-ranges:
@@ -32,13 +32,13 @@ properties:
   gpio-line-names: true
 
   reg:
-    description: |
-      Physical address base for gpio base registers. There are 8 GPIO
-      physical address base in mt8195.
+    description:
+      Physical address base for gpio base registers. There are 8 GPIO physical
+      address base in mt8195.
     maxItems: 8
 
   reg-names:
-    description: |
+    description:
       Gpio base register names.
     maxItems: 8
 
@@ -53,9 +53,9 @@ properties:
 
   mediatek,rsel-resistance-in-si-unit:
     type: boolean
-    description: |
-      Identifying i2c pins pull up/down type which is RSEL. It can support
-      RSEL define or si unit value(ohm) to set different resistance.
+    description:
+      Identifying i2c pins pull up/down type which is RSEL. It can support RSEL
+      define or si unit value(ohm) to set different resistance.
 
 # PIN CONFIGURATION NODES
 patternProperties:
@@ -70,8 +70,8 @@ patternProperties:
           A pinctrl node should contain at least one subnodes representing the
           pinctrl groups available on the machine. Each subnode will list the
           pins it needs, and how they should be configured, with regard to muxer
-          configuration, pullups, drive strength, input enable/disable and
-          input schmitt.
+          configuration, pullups, drive strength, input enable/disable and input
+          schmitt.
           An example of using macro:
           pincontroller {
             /* GPIO0 set as multifunction GPIO0 */
@@ -91,7 +91,7 @@ patternProperties:
 
         properties:
           pinmux:
-            description: |
+            description:
               Integer array, represents gpio pin number and mux setting.
               Supported pin number and mux varies for different SoCs, and are
               defined as macros in dt-bindings/pinctrl/<soc>-pinfunc.h
@@ -174,9 +174,9 @@ patternProperties:
               & "MTK_PULL_SET_RSEL_010" & "MTK_PULL_SET_RSEL_011"
               & "MTK_PULL_SET_RSEL_100" & "MTK_PULL_SET_RSEL_101"
               & "MTK_PULL_SET_RSEL_110" & "MTK_PULL_SET_RSEL_111"
-              define in mt8195. It can also support resistance value(ohm)
-              "1000" & "1500" & "2000" & "3000" & "4000" & "5000" & "10000" &
-              "75000" in mt8195.
+              define in mt8195. It can also support resistance value(ohm) "1000"
+              & "1500" & "2000" & "3000" & "4000" & "5000" & "10000" & "75000"
+              in mt8195.
               An example of using RSEL define:
               pincontroller {
                 i2c0-pins {
diff --git a/Documentation/devicetree/bindings/pinctrl/mediatek,mt8365-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/mediatek,mt8365-pinctrl.yaml
index 4b96884a1afc..1cd9d6e55866 100644
--- a/Documentation/devicetree/bindings/pinctrl/mediatek,mt8365-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/mediatek,mt8365-pinctrl.yaml
@@ -4,13 +4,13 @@
 $id: http://devicetree.org/schemas/pinctrl/mediatek,mt8365-pinctrl.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: Mediatek MT8365 Pin Controller
+title: MediaTek MT8365 Pin Controller
 
 maintainers:
   - Zhiyong Tao <zhiyong.tao@mediatek.com>
   - Bernhard Rosenkränzer <bero@baylibre.com>
 
-description: |
+description:
   The MediaTek's MT8365 Pin controller is used to control SoC pins.
 
 properties:
@@ -26,17 +26,17 @@ properties:
       maxItems: 1
     minItems: 1
     maxItems: 2
-    description: |
+    description:
       Should be phandles of the syscfg node.
 
   gpio-controller: true
 
   "#gpio-cells":
     const: 2
-    description: |
-      Number of cells in GPIO specifier. Since the generic GPIO
-      binding is used, the amount of cells must be specified as 2. See the below
-      mentioned gpio binding representation for description of particular cells.
+    description:
+      Number of cells in GPIO specifier. Since the generic GPIO binding is used,
+      the amount of cells must be specified as 2. See the below mentioned gpio
+      binding representation for description of particular cells.
 
   interrupt-controller: true
 
@@ -54,7 +54,7 @@ patternProperties:
       "pins$":
         type: object
         additionalProperties: false
-        description: |
+        description:
           A pinctrl node should contain at least one subnode representing the
           pinctrl groups available on the machine. Each subnode will list the
           pins it needs, and how they should be configured, with regard to muxer
@@ -72,7 +72,7 @@ patternProperties:
           bias-disable: true
 
           bias-pull-up:
-            description: |
+            description:
               Besides generic pinconfig options, it can be used as the pull up
               settings for 2 pull resistors, R0 and R1. User can configure those
               special pins.
@@ -120,7 +120,8 @@ patternProperties:
           mediatek,pull-up-adv:
             description: |
               Pull up setings for 2 pull resistors, R0 and R1. User can
-              configure those special pins. Valid arguments are described as below:
+              configure those special pins. Valid arguments are described as
+              below:
               0: (R1, R0) = (0, 0) which means R1 disabled and R0 disabled.
               1: (R1, R0) = (0, 1) which means R1 disabled and R0 enabled.
               2: (R1, R0) = (1, 0) which means R1 enabled and R0 disabled.
@@ -131,7 +132,8 @@ patternProperties:
           mediatek,pull-down-adv:
             description: |
               Pull down settings for 2 pull resistors, R0 and R1. User can
-              configure those special pins. Valid arguments are described as below:
+              configure those special pins. Valid arguments are described as
+              below:
               0: (R1, R0) = (0, 0) which means R1 disabled and R0 disabled.
               1: (R1, R0) = (0, 1) which means R1 disabled and R0 enabled.
               2: (R1, R0) = (1, 0) which means R1 enabled and R0 disabled.
@@ -140,14 +142,14 @@ patternProperties:
             enum: [0, 1, 2, 3]
 
           mediatek,tdsel:
-            description: |
+            description:
               An integer describing the steps for output level shifter duty
               cycle when asserted (high pulse width adjustment). Valid arguments
               are from 0 to 15.
             $ref: /schemas/types.yaml#/definitions/uint32
 
           mediatek,rdsel:
-            description: |
+            description:
               An integer describing the steps for input level shifter duty cycle
               when asserted (high pulse width adjustment). Valid arguments are
               from 0 to 63.
diff --git a/Documentation/devicetree/bindings/pinctrl/mediatek,rt2880-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/mediatek,rt2880-pinctrl.yaml
index 7395e4434e64..fa03560a13f8 100644
--- a/Documentation/devicetree/bindings/pinctrl/mediatek,rt2880-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/mediatek,rt2880-pinctrl.yaml
@@ -10,7 +10,7 @@ maintainers:
   - Arınç ÜNAL <arinc.unal@arinc9.com>
   - Sergio Paracuellos <sergio.paracuellos@gmail.com>
 
-description:
+description: |
   MediaTek RT2880 pin controller for RT2880 SoC.
   The pin controller can only set the muxing of pin groups. Muxing individual
   pins is not supported. There is no pinconf support.
diff --git a/Documentation/devicetree/bindings/pinctrl/mediatek,rt305x-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/mediatek,rt305x-pinctrl.yaml
index 1e6c7e7f2fe2..11b46aee36d4 100644
--- a/Documentation/devicetree/bindings/pinctrl/mediatek,rt305x-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/mediatek,rt305x-pinctrl.yaml
@@ -10,7 +10,7 @@ maintainers:
   - Arınç ÜNAL <arinc.unal@arinc9.com>
   - Sergio Paracuellos <sergio.paracuellos@gmail.com>
 
-description:
+description: |
   MediaTek RT305X pin controller for RT3050, RT3052, and RT3350 SoCs.
   The pin controller can only set the muxing of pin groups. Muxing individual
   pins is not supported. There is no pinconf support.
diff --git a/Documentation/devicetree/bindings/pinctrl/mediatek,rt3352-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/mediatek,rt3352-pinctrl.yaml
index 7a74c1602afc..c88b9fefb9ef 100644
--- a/Documentation/devicetree/bindings/pinctrl/mediatek,rt3352-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/mediatek,rt3352-pinctrl.yaml
@@ -10,7 +10,7 @@ maintainers:
   - Arınç ÜNAL <arinc.unal@arinc9.com>
   - Sergio Paracuellos <sergio.paracuellos@gmail.com>
 
-description:
+description: |
   MediaTek RT3352 pin controller for RT3352 SoC.
   The pin controller can only set the muxing of pin groups. Muxing individual
   pins is not supported. There is no pinconf support.
diff --git a/Documentation/devicetree/bindings/pinctrl/mediatek,rt3883-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/mediatek,rt3883-pinctrl.yaml
index ab20f67c47f0..bafc2b820dd8 100644
--- a/Documentation/devicetree/bindings/pinctrl/mediatek,rt3883-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/mediatek,rt3883-pinctrl.yaml
@@ -10,7 +10,7 @@ maintainers:
   - Arınç ÜNAL <arinc.unal@arinc9.com>
   - Sergio Paracuellos <sergio.paracuellos@gmail.com>
 
-description:
+description: |
   MediaTek RT3883 pin controller for RT3883 SoC.
   The pin controller can only set the muxing of pin groups. Muxing individual
   pins is not supported. There is no pinconf support.
diff --git a/Documentation/devicetree/bindings/pinctrl/mediatek,rt5350-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/mediatek,rt5350-pinctrl.yaml
index 5184cea62640..070a9d59e639 100644
--- a/Documentation/devicetree/bindings/pinctrl/mediatek,rt5350-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/mediatek,rt5350-pinctrl.yaml
@@ -10,7 +10,7 @@ maintainers:
   - Arınç ÜNAL <arinc.unal@arinc9.com>
   - Sergio Paracuellos <sergio.paracuellos@gmail.com>
 
-description:
+description: |
   MediaTek RT5350 pin controller for RT5350 SoC.
   The pin controller can only set the muxing of pin groups. Muxing individual
   pins is not supported. There is no pinconf support.
-- 
2.37.2

