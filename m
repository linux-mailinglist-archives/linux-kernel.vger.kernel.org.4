Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (unknown [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA7365F97CC
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 07:34:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231233AbiJJFed (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 01:34:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231211AbiJJFe0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 01:34:26 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11C134F6B7;
        Sun,  9 Oct 2022 22:34:24 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id d24so9453939pls.4;
        Sun, 09 Oct 2022 22:34:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=0D8oUaZmT4I0yy6RsHfeXtojWjxAHAVwrgD0XhAhavM=;
        b=BcmTe9ZOMJS02cLjncHBrX3ixmotFUfq0Iqp29boUI1dNmRoCcN1HCDJnQ4jOBTCT3
         TwBMh4Z/I5C44/qD3gIuDgEi6BjvMDLqDSCZZUW/Z/JLSxP03cauir1RtliHtdxhPMui
         SRaJj3hCy4HcO+2pO80b2+H87hlN7yrdSOG07p+vRzS1xfptIir51BT/mftzid9mfhUV
         daeozj0FcxiGoVdmJJxIkEnYXCmdv2IMDqHLGi0rEWLbVUE+Jf/T4vMNWqZsdI9/A4Gk
         ZAdQ7oTYiGYeLlh+Edw4nV3RsU5ybRtpq+OoEcHrIh1qTwhcSGJsThWfdiFTS/L3MiDT
         EYXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0D8oUaZmT4I0yy6RsHfeXtojWjxAHAVwrgD0XhAhavM=;
        b=Xl369Hs/GCPoi22gsY9CG6StHjd8hxKW9LcNHe6j9RVIbgmHnX7ryO69opXwEnewSB
         tE4lj6LT3zPJtau3AR17cGVZMKOaNiWDfScZSjTsmGqovDSz7UhLVIKl3hnh+Uvwusyc
         xITlZSkoOeYeDp03PSEqmpxeReZyCR8JUXpqbGA3XhAcA9sz/eUXzET3v5xdC4kzPbxa
         f/l7cU4n0xFKMxJXWm4IDjXeT1Ld+HDagcHZd/wYZmsj6VePMzQAF95JpxbvMBEAoBT/
         qlf7O+FrvA6IBn6Meu5hRtIMqw6srSrQ1AAHZRFV5+4BOCnYQgmfIVYEz9dfUHBoJc3y
         90EA==
X-Gm-Message-State: ACrzQf3FFjya/NqHQIKkHNnalrYoaAVUG6CaVYBkE5gxlfvaid7GiLwr
        M260bRC+DO7EUqT0KougdRQ=
X-Google-Smtp-Source: AMsMyM7SvEs1BG6kD8J8xpLVGDgI5heyoyS3dMDqLyVDwngQ66wESe0nZnRFH0LKPXSvWLRpiYO/NA==
X-Received: by 2002:a17:902:d2cc:b0:182:d901:5d28 with SMTP id n12-20020a170902d2cc00b00182d9015d28mr1399214plc.142.1665380063136;
        Sun, 09 Oct 2022 22:34:23 -0700 (PDT)
Received: from xm06403pcu.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id 126-20020a620584000000b00562519cad97sm5891920pff.19.2022.10.09.22.34.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Oct 2022 22:34:22 -0700 (PDT)
From:   Chunyan Zhang <zhang.lyra@gmail.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        Baolin Wang <baolin.wang7@gmail.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>,
        Cixi Geng <cixi.geng1@unisoc.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH V3 2/3] dt-bindings: gpio: Convert Unisoc EIC controller binding to yaml
Date:   Mon, 10 Oct 2022 13:33:37 +0800
Message-Id: <20221010053338.22580-3-zhang.lyra@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221010053338.22580-1-zhang.lyra@gmail.com>
References: <20221010053338.22580-1-zhang.lyra@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chunyan Zhang <chunyan.zhang@unisoc.com>

Convert the Unisoc EIC controller binding to DT schema format.
Update the maxItems of 'reg' property, since the current gpio-eic-sprd
driver supports 3 reg items. Also removed a few similar examples.

Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>
---
 .../bindings/gpio/gpio-eic-sprd.txt           |  97 -----------------
 .../bindings/gpio/sprd,gpio-eic.yaml          | 103 ++++++++++++++++++
 2 files changed, 103 insertions(+), 97 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/gpio/gpio-eic-sprd.txt
 create mode 100644 Documentation/devicetree/bindings/gpio/sprd,gpio-eic.yaml

diff --git a/Documentation/devicetree/bindings/gpio/gpio-eic-sprd.txt b/Documentation/devicetree/bindings/gpio/gpio-eic-sprd.txt
deleted file mode 100644
index 54040a2bfe3a..000000000000
--- a/Documentation/devicetree/bindings/gpio/gpio-eic-sprd.txt
+++ /dev/null
@@ -1,97 +0,0 @@
-Spreadtrum EIC controller bindings
-
-The EIC is the abbreviation of external interrupt controller, which can
-be used only in input mode. The Spreadtrum platform has 2 EIC controllers,
-one is in digital chip, and another one is in PMIC. The digital chip EIC
-controller contains 4 sub-modules: EIC-debounce, EIC-latch, EIC-async and
-EIC-sync. But the PMIC EIC controller contains only one EIC-debounce sub-
-module.
-
-The EIC-debounce sub-module provides up to 8 source input signal
-connections. A debounce mechanism is used to capture the input signals'
-stable status (millisecond resolution) and a single-trigger mechanism
-is introduced into this sub-module to enhance the input event detection
-reliability. In addition, this sub-module's clock can be shut off
-automatically to reduce power dissipation. Moreover the debounce range
-is from 1ms to 4s with a step size of 1ms. The input signal will be
-ignored if it is asserted for less than 1 ms.
-
-The EIC-latch sub-module is used to latch some special power down signals
-and generate interrupts, since the EIC-latch does not depend on the APB
-clock to capture signals.
-
-The EIC-async sub-module uses a 32kHz clock to capture the short signals
-(microsecond resolution) to generate interrupts by level or edge trigger.
-
-The EIC-sync is similar with GPIO's input function, which is a synchronized
-signal input register. It can generate interrupts by level or edge trigger
-when detecting input signals.
-
-Required properties:
-- compatible: Should be one of the following:
-  "sprd,sc9860-eic-debounce",
-  "sprd,sc9860-eic-latch",
-  "sprd,sc9860-eic-async",
-  "sprd,sc9860-eic-sync",
-  "sprd,sc2731-eic".
-- reg: Define the base and range of the I/O address space containing
-  the GPIO controller registers.
-- gpio-controller: Marks the device node as a GPIO controller.
-- #gpio-cells: Should be <2>. The first cell is the gpio number and
-  the second cell is used to specify optional parameters.
-- interrupt-controller: Marks the device node as an interrupt controller.
-- #interrupt-cells: Should be <2>. Specifies the number of cells needed
-  to encode interrupt source.
-- interrupts: Should be the port interrupt shared by all the gpios.
-
-Example:
-	eic_debounce: gpio@40210000 {
-		compatible = "sprd,sc9860-eic-debounce";
-		reg = <0 0x40210000 0 0x80>;
-		gpio-controller;
-		#gpio-cells = <2>;
-		interrupt-controller;
-		#interrupt-cells = <2>;
-		interrupts = <GIC_SPI 52 IRQ_TYPE_LEVEL_HIGH>;
-	};
-
-	eic_latch: gpio@40210080 {
-		compatible = "sprd,sc9860-eic-latch";
-		reg = <0 0x40210080 0 0x20>;
-		gpio-controller;
-		#gpio-cells = <2>;
-		interrupt-controller;
-		#interrupt-cells = <2>;
-		interrupts = <GIC_SPI 52 IRQ_TYPE_LEVEL_HIGH>;
-	};
-
-	eic_async: gpio@402100a0 {
-		compatible = "sprd,sc9860-eic-async";
-		reg = <0 0x402100a0 0 0x20>;
-		gpio-controller;
-		#gpio-cells = <2>;
-		interrupt-controller;
-		#interrupt-cells = <2>;
-		interrupts = <GIC_SPI 52 IRQ_TYPE_LEVEL_HIGH>;
-	};
-
-	eic_sync: gpio@402100c0 {
-		compatible = "sprd,sc9860-eic-sync";
-		reg = <0 0x402100c0 0 0x20>;
-		gpio-controller;
-		#gpio-cells = <2>;
-		interrupt-controller;
-		#interrupt-cells = <2>;
-		interrupts = <GIC_SPI 52 IRQ_TYPE_LEVEL_HIGH>;
-	};
-
-	pmic_eic: gpio@300 {
-		compatible = "sprd,sc2731-eic";
-		reg = <0x300>;
-		interrupt-parent = <&sc2731_pmic>;
-		interrupts = <5 IRQ_TYPE_LEVEL_HIGH>;
-		gpio-controller;
-		#gpio-cells = <2>;
-		interrupt-controller;
-		#interrupt-cells = <2>;
-	};
diff --git a/Documentation/devicetree/bindings/gpio/sprd,gpio-eic.yaml b/Documentation/devicetree/bindings/gpio/sprd,gpio-eic.yaml
new file mode 100644
index 000000000000..a21350bd0f2c
--- /dev/null
+++ b/Documentation/devicetree/bindings/gpio/sprd,gpio-eic.yaml
@@ -0,0 +1,103 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+# Copyright 2022 Unisoc Inc.
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/gpio/sprd,gpio-eic.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Unisoc EIC controller
+
+maintainers:
+  - Orson Zhai <orsonzhai@gmail.com>
+  - Baolin Wang <baolin.wang7@gmail.com>
+  - Chunyan Zhang <zhang.lyra@gmail.com>
+
+description: |
+  The EIC is the abbreviation of external interrupt controller, which can
+  be used only in input mode. The Spreadtrum platform has 2 EIC controllers,
+  one is in digital chip, and another one is in PMIC. The digital chip EIC
+  controller contains 4 sub-modules, i.e. EIC-debounce, EIC-latch, EIC-async and
+  EIC-sync. But the PMIC EIC controller contains only one EIC-debounce sub-
+  module.
+
+  The EIC-debounce sub-module provides up to 8 source input signal
+  connections. A debounce mechanism is used to capture the input signals'
+  stable status (millisecond resolution) and a single-trigger mechanism
+  is introduced into this sub-module to enhance the input event detection
+  reliability. In addition, this sub-module's clock can be shut off
+  automatically to reduce power dissipation. Moreover the debounce range
+  is from 1ms to 4s with a step size of 1ms. The input signal will be
+  ignored if it is asserted for less than 1 ms.
+
+  The EIC-latch sub-module is used to latch some special power down signals
+  and generate interrupts, since the EIC-latch does not depend on the APB
+  clock to capture signals.
+
+  The EIC-async sub-module uses a 32kHz clock to capture the short signals
+  (microsecond resolution) to generate interrupts by level or edge trigger.
+
+  The EIC-sync is similar with GPIO's input function, which is a synchronized
+  signal input register. It can generate interrupts by level or edge trigger
+  when detecting input signals.
+
+properties:
+  compatible:
+    enum:
+      - sprd,sc9860-eic-debounce
+      - sprd,sc9860-eic-latch
+      - sprd,sc9860-eic-async
+      - sprd,sc9860-eic-sync
+      - sprd,sc2731-eic
+
+  reg:
+    minItems: 1
+    maxItems: 3
+    description:
+      EIC controller can support maximum 3 banks which has its own
+      address base.
+
+  gpio-controller: true
+
+  "#gpio-cells":
+    const: 2
+
+  interrupt-controller: true
+
+  "#interrupt-cells":
+    const: 2
+
+  interrupts:
+    maxItems: 1
+    description:
+      The interrupt shared by all GPIO lines for this controller.
+
+required:
+  - compatible
+  - reg
+  - gpio-controller
+  - "#gpio-cells"
+  - interrupt-controller
+  - "#interrupt-cells"
+  - interrupts
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    soc {
+        #address-cells = <2>;
+        #size-cells = <2>;
+
+        eic_debounce: gpio@40210000 {
+            compatible = "sprd,sc9860-eic-debounce";
+            reg = <0 0x40210000 0 0x80>;
+            gpio-controller;
+            #gpio-cells = <2>;
+            interrupt-controller;
+            #interrupt-cells = <2>;
+            interrupts = <GIC_SPI 52 IRQ_TYPE_LEVEL_HIGH>;
+        };
+    };
+...
-- 
2.25.1

