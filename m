Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 038C7611603
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 17:36:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229817AbiJ1Pfz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 11:35:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230230AbiJ1Pff (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 11:35:35 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1D6F78BE4;
        Fri, 28 Oct 2022 08:35:30 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id z18so3403028edb.9;
        Fri, 28 Oct 2022 08:35:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+rjM9lCoFGf3RT/o2EnifjQmQBBIlv25kewk8GPQmYY=;
        b=KDT+rSVUgOWeJ3sAzuxMMsYPGPM22sEw6ANWwnNL0mv1cneOlqTbJ8r0o+BX7Ut8pe
         21tz7WBjrQWJD7Xj9Pb0ynCQE8WkPzMFlQm1zldUU6r/DUqmt9lS9KMX/7/oxLJg2XmE
         xGLzF7NcyePzwmcPBwfNpTjyRWKRhTdqqOez/1EVvSKhmL1gjOVyIq7LafTW6Z7u6QSc
         eWEQMEgeHtNzGuH+s5jE3CjInJedto78Fi/kXPdwLjaB6+kT+Y1+z6I6kHAUY+FbE4I/
         d7vOHpGfK7ggMSH0fCmLb5UZVBYd/4trph4JGKne4Arvmu/kQLEjUDjhA5Av+OYAOk4r
         Yspg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+rjM9lCoFGf3RT/o2EnifjQmQBBIlv25kewk8GPQmYY=;
        b=lwTfaq4G1oNb+5xUtOT/2RSHSLeaPKzEwHKE5CzayImto02G0KY9diSPTt2sYOXFL2
         4v2vXZVobzWO4e9qUdk8LaEGRB/Xz2ilJ1YSbhAW8T0Y5Uj6C/uQlvomgYf4gQyafjH3
         y82aCiJU8u+/z+bu0vhlUjHY0C+/igM2Bfou+a1nAm7wK6PrQhGTxHQn+NA1YKz1YMpA
         zjJQ+K3RKBCGPRjKh72ljCUN+ZItjgzFve9Ex/81apJT5h2Xn5k9UqKl9bd/LG6xuVDj
         DBzhBuZFQl4+396U9Kxtm7HoHk1TqTOQMSxFoq8XsosiV4OyQDk8AvGv9kztXn99tQT4
         +9XQ==
X-Gm-Message-State: ACrzQf3CkQe1L0xypBOXW98qWnYXIminuzXC1RMT3dZ1oUatRqvHHfd9
        uoR6U2KFr8IYBzkdd/10Bn0=
X-Google-Smtp-Source: AMsMyM6pLB8Ryr3cpAAdfXhy4Xwkl9uCmBdpeiyTeIY0KxCS5JGchDWuRxkAB2v9g+owHellobl7+g==
X-Received: by 2002:a05:6402:4411:b0:437:b723:72 with SMTP id y17-20020a056402441100b00437b7230072mr47700eda.38.1666971329105;
        Fri, 28 Oct 2022 08:35:29 -0700 (PDT)
Received: from localhost.localdomain ([95.183.227.98])
        by smtp.gmail.com with ESMTPSA id ds12-20020a0564021ccc00b00461aebb2fe2sm2830635edb.54.2022.10.28.08.35.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Oct 2022 08:35:28 -0700 (PDT)
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
        linux-kernel@vger.kernel.org, Rob Herring <robh@kernel.org>
Subject: [PATCH v4 04/13] dt-bindings: pinctrl: mediatek,mt6779-pinctrl: Add MT6797
Date:   Fri, 28 Oct 2022 18:34:56 +0300
Message-Id: <20221028153505.23741-5-y.oudjana@protonmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221028153505.23741-1-y.oudjana@protonmail.com>
References: <20221028153505.23741-1-y.oudjana@protonmail.com>
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

Combine MT6797 pin controller document into MT6779 one. reg and
reg-names property constraints are set using conditionals.
A conditional is also used to make interrupt-related properties
required on the MT6779 pin controller only, since the MT6797
controller doesn't support interrupts (or not yet, at least).
drive-strength and slew-rate properties which weren't described
in the MT6779 document before are brought in from the MT6797 one.
Both pin controllers share a common driver core so they should
both support these properties.

Signed-off-by: Yassine Oudjana <y.oudjana@protonmail.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 .../pinctrl/mediatek,mt6779-pinctrl.yaml      |  87 ++++++---
 .../pinctrl/mediatek,mt6797-pinctrl.yaml      | 176 ------------------
 MAINTAINERS                                   |   2 +-
 3 files changed, 67 insertions(+), 198 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/pinctrl/mediatek,mt6797-pinctrl.yaml

diff --git a/Documentation/devicetree/bindings/pinctrl/mediatek,mt6779-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/mediatek,mt6779-pinctrl.yaml
index d45f0e75a698..a2141eb0854e 100644
--- a/Documentation/devicetree/bindings/pinctrl/mediatek,mt6779-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/mediatek,mt6779-pinctrl.yaml
@@ -8,6 +8,7 @@ title: Mediatek MT6779 Pin Controller
 
 maintainers:
   - Andy Teng <andy.teng@mediatek.com>
+  - Sean Wang <sean.wang@kernel.org>
 
 description:
   The MediaTek pin controller on MT6779 is used to control pin
@@ -15,23 +16,14 @@ description:
 
 properties:
   compatible:
-    const: mediatek,mt6779-pinctrl
+    enum:
+      - mediatek,mt6779-pinctrl
+      - mediatek,mt6797-pinctrl
 
   reg:
-    minItems: 9
-    maxItems: 9
-
-  reg-names:
-    items:
-      - const: "gpio"
-      - const: "iocfg_rm"
-      - const: "iocfg_br"
-      - const: "iocfg_lm"
-      - const: "iocfg_lb"
-      - const: "iocfg_rt"
-      - const: "iocfg_lt"
-      - const: "iocfg_tl"
-      - const: "eint"
+    description: Physical addresses for GPIO base(s) and EINT registers.
+
+  reg-names: true
 
   gpio-controller: true
 
@@ -58,18 +50,65 @@ properties:
   "#interrupt-cells":
     const: 2
 
-allOf:
-  - $ref: "pinctrl.yaml#"
-
 required:
   - compatible
   - reg
   - reg-names
   - gpio-controller
   - "#gpio-cells"
-  - interrupt-controller
-  - interrupts
-  - "#interrupt-cells"
+
+allOf:
+  - $ref: "pinctrl.yaml#"
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: mediatek,mt6779-pinctrl
+    then:
+      properties:
+        reg:
+          minItems: 9
+          maxItems: 9
+
+        reg-names:
+          items:
+            - const: gpio
+            - const: iocfg_rm
+            - const: iocfg_br
+            - const: iocfg_lm
+            - const: iocfg_lb
+            - const: iocfg_rt
+            - const: iocfg_lt
+            - const: iocfg_tl
+            - const: eint
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: mediatek,mt6797-pinctrl
+    then:
+      properties:
+        reg:
+          minItems: 5
+          maxItems: 5
+
+        reg-names:
+          items:
+            - const: gpio
+            - const: iocfgl
+            - const: iocfgb
+            - const: iocfgr
+            - const: iocfgt
+  - if:
+      properties:
+        reg-names:
+          contains:
+            const: eint
+    then:
+      required:
+        - interrupts
+        - interrupt-controller
+        - "#interrupt-cells"
 
 patternProperties:
   '-[0-9]*$':
@@ -111,6 +150,12 @@ patternProperties:
 
           input-schmitt-disable: true
 
+          drive-strength:
+            enum: [2, 4, 8, 12, 16]
+
+          slew-rate:
+            enum: [0, 1]
+
           mediatek,pull-up-adv:
             description: |
               Pull up setings for 2 pull resistors, R0 and R1. User can
diff --git a/Documentation/devicetree/bindings/pinctrl/mediatek,mt6797-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/mediatek,mt6797-pinctrl.yaml
deleted file mode 100644
index 637a8386e23e..000000000000
--- a/Documentation/devicetree/bindings/pinctrl/mediatek,mt6797-pinctrl.yaml
+++ /dev/null
@@ -1,176 +0,0 @@
-# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
-%YAML 1.2
----
-$id: http://devicetree.org/schemas/pinctrl/mediatek,mt6797-pinctrl.yaml#
-$schema: http://devicetree.org/meta-schemas/core.yaml#
-
-title: Mediatek MT6797 Pin Controller
-
-maintainers:
-  - Sean Wang <sean.wang@kernel.org>
-
-description: |+
-  The MediaTek's MT6797 Pin controller is used to control SoC pins.
-
-properties:
-  compatible:
-    const: mediatek,mt6797-pinctrl
-
-  reg:
-    minItems: 5
-    maxItems: 5
-
-  reg-names:
-    items:
-      - const: gpio
-      - const: iocfgl
-      - const: iocfgb
-      - const: iocfgr
-      - const: iocfgt
-
-  gpio-controller: true
-
-  "#gpio-cells":
-    const: 2
-    description: |
-      Number of cells in GPIO specifier. Since the generic GPIO
-      binding is used, the amount of cells must be specified as 2. See the below
-      mentioned gpio binding representation for description of particular cells.
-
-  interrupt-controller: true
-
-  interrupts:
-    maxItems: 1
-
-  "#interrupt-cells":
-    const: 2
-
-allOf:
-  - $ref: "pinctrl.yaml#"
-
-required:
-  - compatible
-  - reg
-  - reg-names
-  - gpio-controller
-  - "#gpio-cells"
-
-patternProperties:
-  '-[0-9]+$':
-    type: object
-    additionalProperties: false
-    patternProperties:
-      'pins':
-        type: object
-        additionalProperties: false
-        description: |
-          A pinctrl node should contain at least one subnodes representing the
-          pinctrl groups available on the machine. Each subnode will list the
-          pins it needs, and how they should be configured, with regard to muxer
-          configuration, pullups, drive strength, input enable/disable and input
-          schmitt.
-        $ref: "/schemas/pinctrl/pincfg-node.yaml"
-
-        properties:
-          pinmux:
-            description:
-              integer array, represents gpio pin number and mux setting.
-              Supported pin number and mux varies for different SoCs, and are
-              defined as macros in <soc>-pinfunc.h directly.
-
-          bias-disable: true
-
-          bias-pull-up: true
-
-          bias-pull-down: true
-
-          input-enable: true
-
-          input-disable: true
-
-          output-enable: true
-
-          output-low: true
-
-          output-high: true
-
-          input-schmitt-enable: true
-
-          input-schmitt-disable: true
-
-          drive-strength:
-            enum: [2, 4, 8, 12, 16]
-
-          slew-rate:
-            enum: [0, 1]
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
-          mediatek,tdsel:
-            description: |
-              An integer describing the steps for output level shifter duty
-              cycle when asserted (high pulse width adjustment). Valid arguments
-              are from 0 to 15.
-            $ref: /schemas/types.yaml#/definitions/uint32
-
-          mediatek,rdsel:
-            description: |
-              An integer describing the steps for input level shifter duty cycle
-              when asserted (high pulse width adjustment). Valid arguments are
-              from 0 to 63.
-            $ref: /schemas/types.yaml#/definitions/uint32
-
-        required:
-          - pinmux
-
-additionalProperties: false
-
-examples:
-  - |
-    #include <dt-bindings/interrupt-controller/irq.h>
-    #include <dt-bindings/interrupt-controller/arm-gic.h>
-    #include <dt-bindings/pinctrl/mt6797-pinfunc.h>
-
-    soc {
-        #address-cells = <2>;
-        #size-cells = <2>;
-
-        pio: pinctrl@10005000 {
-            compatible = "mediatek,mt6797-pinctrl";
-            reg = <0 0x10005000 0 0x1000>,
-                  <0 0x10002000 0 0x400>,
-                  <0 0x10002400 0 0x400>,
-                  <0 0x10002800 0 0x400>,
-                  <0 0x10002C00 0 0x400>;
-            reg-names = "gpio", "iocfgl", "iocfgb", "iocfgr", "iocfgt";
-            gpio-controller;
-            #gpio-cells = <2>;
-
-            uart_pins_a: uart-0 {
-                pins1 {
-                    pinmux = <MT6797_GPIO232__FUNC_URXD1>,
-                            <MT6797_GPIO233__FUNC_UTXD1>;
-                };
-            };
-        };
-    };
diff --git a/MAINTAINERS b/MAINTAINERS
index e9759eb08c57..4fd8037263d9 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -16309,7 +16309,7 @@ M:	Sean Wang <sean.wang@kernel.org>
 L:	linux-mediatek@lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
 F:	Documentation/devicetree/bindings/pinctrl/mediatek,mt65xx-pinctrl.yaml
-F:	Documentation/devicetree/bindings/pinctrl/mediatek,mt6797-pinctrl.yaml
+F:	Documentation/devicetree/bindings/pinctrl/mediatek,mt6779-pinctrl.yaml
 F:	Documentation/devicetree/bindings/pinctrl/mediatek,mt7622-pinctrl.yaml
 F:	Documentation/devicetree/bindings/pinctrl/mediatek,mt8183-pinctrl.yaml
 F:	drivers/pinctrl/mediatek/
-- 
2.38.1

