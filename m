Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC551659C20
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Dec 2022 21:37:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235607AbiL3UgF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Dec 2022 15:36:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231171AbiL3Ufu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Dec 2022 15:35:50 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA369116F
        for <linux-kernel@vger.kernel.org>; Fri, 30 Dec 2022 12:35:47 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id r26so26508405edc.5
        for <linux-kernel@vger.kernel.org>; Fri, 30 Dec 2022 12:35:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X/YvHElO1B1L96Q/ryL2GcQHBR6R6iwvqncvsZcjNEM=;
        b=FwHXJj/0hE2ocjmVzKl7OsUdAR2wshEC1VxX6arYVk2fB5OTyw8SEuWRMuL0Ai4UXG
         3eZHZp21/PLb0dKBmGNT/4bwC50RN/PGsX7R4AjHd0+gSq2dT12dtjQM5i9LtIuiznnp
         VlspXQTNxugYOXAsV880Gwfu/OOAAXQkUfa+N/8RzJfr3JAzxPc0oXAa2BDFBERXgnYU
         jYXbXzjguMQCRA+QpYhgVsx2uaA3u2A8q5hGFfUBMOBDKhpkc21VZ5uwPNuFEz8ndoOh
         4QCDUgi6DyB/73CoILFHyiLPfDWwH0sfEWhI8KuQ5jdESdh7b7qR3ah4A3+adxgHxWFf
         mMKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X/YvHElO1B1L96Q/ryL2GcQHBR6R6iwvqncvsZcjNEM=;
        b=tppnlyeHM3zQ8L/hrDbpHVi3Z8rA6/GpcKQx4/mkrJzp41R4LLCcAG4XH8qC3JF1gU
         2OFkLaXLD4UNIigmaasab8AOQqG7+lWlU7LaCphq5FndIc3f+WZ2ucJUcLlAB3Hn4s/x
         Zum8AYhJ+Es7RQmci8gPHplRYInmBziOJj3MYzm/pZQtEA2Sw2SGNZBmGE3I397BoIR0
         yOmrelGJbT8je94vhMZto+W1N3v23OGWdZr7WyN2T9B8UPWsDJokBK5VEUVeAfN7OsjQ
         JpZuSIuagOOO5E0ym1KaYvj/O1/DfOMQr3e6WlRar3lZOPGOouS8M5Vt5xZnAcZSDGjd
         kmlg==
X-Gm-Message-State: AFqh2kqi9rjJMZzyFqCK5iE1fJi+gs2BY1RYm9QYHzKU+gWnbX3lsN3H
        vrnfL2XgPmkO6zILPMbgv5bIpw==
X-Google-Smtp-Source: AMrXdXudWOuZiaJ0H5ELIr6PxS7d0qIx/RI5pwX/fV3HsKlOYONQLc/EOZTfdZs2G0Ad/VBVktqgGA==
X-Received: by 2002:aa7:c053:0:b0:482:e3b9:f46e with SMTP id k19-20020aa7c053000000b00482e3b9f46emr18963761edo.39.1672432547178;
        Fri, 30 Dec 2022 12:35:47 -0800 (PST)
Received: from predatorhelios.fritz.box (dynamic-2a01-0c22-cd9d-4b00-ef17-3c78-1696-7315.c22.pool.telefonica.de. [2a01:c22:cd9d:4b00:ef17:3c78:1696:7315])
        by smtp.gmail.com with ESMTPSA id c10-20020a056402158a00b00482c1f1a039sm8350500edv.30.2022.12.30.12.35.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Dec 2022 12:35:46 -0800 (PST)
From:   =?UTF-8?q?Bernhard=20Rosenkr=C3=A4nzer?= <bero@baylibre.com>
To:     linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        matthias.bgg@gmail.com, krzysztof.kozlowski+dt@linaro.org,
        robh+dt@kernel.org, gregkh@linuxfoundation.org,
        chunfeng.yun@mediatek.com, linus.walleij@linaro.org,
        lee@kernel.org, maz@kernel.org, tglx@linutronix.de,
        angelogioacchino.delregno@collabora.com
Subject: [PATCH v6 4/7] dt-bindings: pinctrl: add bindings for Mediatek MT8365 SoC
Date:   Fri, 30 Dec 2022 21:35:38 +0100
Message-Id: <20221230203541.146807-5-bero@baylibre.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20221230203541.146807-1-bero@baylibre.com>
References: <20221230203541.146807-1-bero@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add devicetree bindings for Mediatek MT8365 pinctrl driver.

Signed-off-by: Bernhard Rosenkränzer <bero@baylibre.com>
---
 .../pinctrl/mediatek,mt8365-pinctrl.yaml      | 197 ++++++++++++++++++
 1 file changed, 197 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pinctrl/mediatek,mt8365-pinctrl.yaml

diff --git a/Documentation/devicetree/bindings/pinctrl/mediatek,mt8365-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/mediatek,mt8365-pinctrl.yaml
new file mode 100644
index 0000000000000..4b96884a1afc7
--- /dev/null
+++ b/Documentation/devicetree/bindings/pinctrl/mediatek,mt8365-pinctrl.yaml
@@ -0,0 +1,197 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pinctrl/mediatek,mt8365-pinctrl.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Mediatek MT8365 Pin Controller
+
+maintainers:
+  - Zhiyong Tao <zhiyong.tao@mediatek.com>
+  - Bernhard Rosenkränzer <bero@baylibre.com>
+
+description: |
+  The MediaTek's MT8365 Pin controller is used to control SoC pins.
+
+properties:
+  compatible:
+    const: mediatek,mt8365-pinctrl
+
+  reg:
+    maxItems: 1
+
+  mediatek,pctl-regmap:
+    $ref: /schemas/types.yaml#/definitions/phandle-array
+    items:
+      maxItems: 1
+    minItems: 1
+    maxItems: 2
+    description: |
+      Should be phandles of the syscfg node.
+
+  gpio-controller: true
+
+  "#gpio-cells":
+    const: 2
+    description: |
+      Number of cells in GPIO specifier. Since the generic GPIO
+      binding is used, the amount of cells must be specified as 2. See the below
+      mentioned gpio binding representation for description of particular cells.
+
+  interrupt-controller: true
+
+  interrupts:
+    maxItems: 1
+
+  "#interrupt-cells":
+    const: 2
+
+patternProperties:
+  "-pins$":
+    type: object
+    additionalProperties: false
+    patternProperties:
+      "pins$":
+        type: object
+        additionalProperties: false
+        description: |
+          A pinctrl node should contain at least one subnode representing the
+          pinctrl groups available on the machine. Each subnode will list the
+          pins it needs, and how they should be configured, with regard to muxer
+          configuration, pullups, drive strength, input enable/disable and input
+          schmitt.
+        $ref: /schemas/pinctrl/pincfg-node.yaml
+
+        properties:
+          pinmux:
+            description:
+              integer array, represents gpio pin number and mux setting.
+              Supported pin number and mux varies for different SoCs, and are
+              defined as macros in <soc>-pinfunc.h directly.
+
+          bias-disable: true
+
+          bias-pull-up:
+            description: |
+              Besides generic pinconfig options, it can be used as the pull up
+              settings for 2 pull resistors, R0 and R1. User can configure those
+              special pins.
+
+          bias-pull-down: true
+
+          input-enable: true
+
+          input-disable: true
+
+          output-low: true
+
+          output-high: true
+
+          input-schmitt-enable: true
+
+          input-schmitt-disable: true
+
+          mediatek,drive-strength-adv:
+            description: |
+              Describe the specific driving setup property.
+              For I2C pins, the existing generic driving setup can only support
+              2/4/6/8/10/12/14/16mA driving. But in specific driving setup, they
+              can support 0.125/0.25/0.5/1mA adjustment. If we enable specific
+              driving setup, the existing generic setup will be disabled.
+              The specific driving setup is controlled by E1E0EN.
+              When E1=0/E0=0, the strength is 0.125mA.
+              When E1=0/E0=1, the strength is 0.25mA.
+              When E1=1/E0=0, the strength is 0.5mA.
+              When E1=1/E0=1, the strength is 1mA.
+              EN is used to enable or disable the specific driving setup.
+              Valid arguments are described as below:
+              0: (E1, E0, EN) = (0, 0, 0)
+              1: (E1, E0, EN) = (0, 0, 1)
+              2: (E1, E0, EN) = (0, 1, 0)
+              3: (E1, E0, EN) = (0, 1, 1)
+              4: (E1, E0, EN) = (1, 0, 0)
+              5: (E1, E0, EN) = (1, 0, 1)
+              6: (E1, E0, EN) = (1, 1, 0)
+              7: (E1, E0, EN) = (1, 1, 1)
+              So the valid arguments are from 0 to 7.
+            $ref: /schemas/types.yaml#/definitions/uint32
+            enum: [0, 1, 2, 3, 4, 5, 6, 7]
+
+          mediatek,pull-up-adv:
+            description: |
+              Pull up setings for 2 pull resistors, R0 and R1. User can
+              configure those special pins. Valid arguments are described as below:
+              0: (R1, R0) = (0, 0) which means R1 disabled and R0 disabled.
+              1: (R1, R0) = (0, 1) which means R1 disabled and R0 enabled.
+              2: (R1, R0) = (1, 0) which means R1 enabled and R0 disabled.
+              3: (R1, R0) = (1, 1) which means R1 enabled and R0 enabled.
+            $ref: /schemas/types.yaml#/definitions/uint32
+            enum: [0, 1, 2, 3]
+
+          mediatek,pull-down-adv:
+            description: |
+              Pull down settings for 2 pull resistors, R0 and R1. User can
+              configure those special pins. Valid arguments are described as below:
+              0: (R1, R0) = (0, 0) which means R1 disabled and R0 disabled.
+              1: (R1, R0) = (0, 1) which means R1 disabled and R0 enabled.
+              2: (R1, R0) = (1, 0) which means R1 enabled and R0 disabled.
+              3: (R1, R0) = (1, 1) which means R1 enabled and R0 enabled.
+            $ref: /schemas/types.yaml#/definitions/uint32
+            enum: [0, 1, 2, 3]
+
+          mediatek,tdsel:
+            description: |
+              An integer describing the steps for output level shifter duty
+              cycle when asserted (high pulse width adjustment). Valid arguments
+              are from 0 to 15.
+            $ref: /schemas/types.yaml#/definitions/uint32
+
+          mediatek,rdsel:
+            description: |
+              An integer describing the steps for input level shifter duty cycle
+              when asserted (high pulse width adjustment). Valid arguments are
+              from 0 to 63.
+            $ref: /schemas/types.yaml#/definitions/uint32
+
+        required:
+          - pinmux
+
+required:
+  - compatible
+  - reg
+  - gpio-controller
+  - "#gpio-cells"
+
+allOf:
+  - $ref: pinctrl.yaml#
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/pinctrl/mt8365-pinfunc.h>
+    soc {
+      #address-cells = <2>;
+      #size-cells = <2>;
+
+      pio: pinctrl@1000b000 {
+        compatible = "mediatek,mt8365-pinctrl";
+        reg = <0 0x1000b000 0 0x1000>;
+        mediatek,pctl-regmap = <&syscfg_pctl>;
+        gpio-controller;
+        #gpio-cells = <2>;
+        interrupt-controller;
+        #interrupt-cells = <2>;
+        interrupts = <GIC_SPI 115 IRQ_TYPE_LEVEL_HIGH>;
+
+        pio-pins {
+          pins {
+            pinmux = <MT8365_PIN_59_SDA1__FUNC_SDA1_0>, <MT8365_PIN_60_SCL1__FUNC_SCL1_0>;
+            mediatek,pull-up-adv = <3>;
+            mediatek,drive-strength-adv = <00>;
+            bias-pull-up;
+          };
+        };
+      };
+    };
-- 
2.39.0

