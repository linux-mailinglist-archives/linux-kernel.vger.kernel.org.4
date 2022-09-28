Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E91725ED8F3
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 11:29:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233586AbiI1J3z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 05:29:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229838AbiI1J3x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 05:29:53 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B1D31D0C7;
        Wed, 28 Sep 2022 02:29:50 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id e11-20020a17090a77cb00b00205edbfd646so1507146pjs.1;
        Wed, 28 Sep 2022 02:29:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=tJu5+3r8ivCyAS03HPqEIU5aJjM4gwmSBQgnIQ+4SPM=;
        b=VpOahVSjO5al4k6Oz8lZxxcglS9LeVuTHIsbp2xGQ34520KHaXfABa0Njr6IU1PPag
         WPoNMLLsZY9ufUMAU10LOXwD4Wym1JEBS+K23MrfaqffgjrIVEvmnGsloVBP4bm07cPC
         bhSl1vsFQISLsJAlkx9M19oFD/9vm/iPvSQTrlGCPBDSb3LsDf5gSJ9aoackzXY6BBU2
         2VaXujWX+iSYrRuvhM6u9YKryf0IjYklZwpWTCwTDPgFw7rreWNCks7xz5LIdx1pncDo
         iTwIJKbMQQi/dZpvDWIjMBvaLrDMIAR85sZtRHOzqyjNa3zddbRHSEt9zAmH6N7CoEEW
         o7DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=tJu5+3r8ivCyAS03HPqEIU5aJjM4gwmSBQgnIQ+4SPM=;
        b=UX9WmiVPKrEwJcK/ieUk0g6Qxt0DmhwbdkJeSflPUxbbUCimqH2LHzLF+7JJ391MRV
         i33plDlzqzkGFnG8GFSzAysdiXoz6Q5kasvk+33mPOo1TPHmGddgqdtzWICvAKOjDb7n
         m+kNm+ddqBs/yCKk7ph2V5lHdY39pSKGkIKwnsCLcERNajyfyjC5BHnGpn3JLevpc8xN
         JfxIr5K2QP0NNra+egp5+NE6HBZuqX3X9KG5KFY36G4I1ib1OJuFjku1eY4D072kW0rC
         EmZe0TAugZhbLDwA1eZRqvkOp7iznW6/hMIKVtkMDIJbKpYO/h0y6KkBiObI3FlOhXRk
         SmjA==
X-Gm-Message-State: ACrzQf1BaFRnlXbQ828m1GobL3gc443Q76ktSfO7lBt2mG/YkynRk/jT
        jK0yAmOVVKXkv8cb9Nbcx0g=
X-Google-Smtp-Source: AMsMyM7DMllFRiL1QIaYIiPsZis835Han9NNI9x7AIEa+c2olw+/cyVJ3z/YF7gR4IyhY3NNG/rEYQ==
X-Received: by 2002:a17:90b:358e:b0:200:9d8a:7a70 with SMTP id mm14-20020a17090b358e00b002009d8a7a70mr9288152pjb.61.1664357389723;
        Wed, 28 Sep 2022 02:29:49 -0700 (PDT)
Received: from xm06403pcu.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id b22-20020a17090a101600b0020071acaecasm1026831pja.42.2022.09.28.02.29.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Sep 2022 02:29:49 -0700 (PDT)
From:   Chunyan Zhang <zhang.lyra@gmail.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        Baolin Wang <baolin.wang7@gmail.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/3] dt-bindings: gpio: Conver Unisoc GPIO controller binding to yaml
Date:   Wed, 28 Sep 2022 17:29:35 +0800
Message-Id: <20220928092937.27120-1-zhang.lyra@gmail.com>
X-Mailer: git-send-email 2.17.1
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

Convert the Unisoc gpio controller binding to DT schema format.

Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>
---
 .../devicetree/bindings/gpio/gpio-sprd.txt    | 28 --------
 .../devicetree/bindings/gpio/sprd,gpio.yaml   | 70 +++++++++++++++++++
 2 files changed, 70 insertions(+), 28 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/gpio/gpio-sprd.txt
 create mode 100644 Documentation/devicetree/bindings/gpio/sprd,gpio.yaml

diff --git a/Documentation/devicetree/bindings/gpio/gpio-sprd.txt b/Documentation/devicetree/bindings/gpio/gpio-sprd.txt
deleted file mode 100644
index eca97d45388f..000000000000
--- a/Documentation/devicetree/bindings/gpio/gpio-sprd.txt
+++ /dev/null
@@ -1,28 +0,0 @@
-Spreadtrum GPIO controller bindings
-
-The controller's registers are organized as sets of sixteen 16-bit
-registers with each set controlling a bank of up to 16 pins. A single
-interrupt is shared for all of the banks handled by the controller.
-
-Required properties:
-- compatible: Should be "sprd,sc9860-gpio".
-- reg: Define the base and range of the I/O address space containing
-the GPIO controller registers.
-- gpio-controller: Marks the device node as a GPIO controller.
-- #gpio-cells: Should be <2>. The first cell is the gpio number and
-the second cell is used to specify optional parameters.
-- interrupt-controller: Marks the device node as an interrupt controller.
-- #interrupt-cells: Should be <2>. Specifies the number of cells needed
-to encode interrupt source.
-- interrupts: Should be the port interrupt shared by all the gpios.
-
-Example:
-	ap_gpio: gpio@40280000 {
-		compatible = "sprd,sc9860-gpio";
-		reg = <0 0x40280000 0 0x1000>;
-		gpio-controller;
-		#gpio-cells = <2>;
-		interrupt-controller;
-		#interrupt-cells = <2>;
-		interrupts = <GIC_SPI 50 IRQ_TYPE_LEVEL_HIGH>;
-	};
diff --git a/Documentation/devicetree/bindings/gpio/sprd,gpio.yaml b/Documentation/devicetree/bindings/gpio/sprd,gpio.yaml
new file mode 100644
index 000000000000..c0cd1ed9809b
--- /dev/null
+++ b/Documentation/devicetree/bindings/gpio/sprd,gpio.yaml
@@ -0,0 +1,70 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+# Copyright 2022 Unisoc Inc.
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/gpio/sprd,gpio.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Unisoc GPIO controller
+
+maintainers:
+  - Orson Zhai <orsonzhai@gmail.com>
+  - Baolin Wang <baolin.wang7@gmail.com>
+  - Chunyan Zhang <zhang.lyra@gmail.com>
+
+description:
+  The controller's registers are organized as sets of sixteen 16-bit
+  registers with each set controlling a bank of up to 16 pins. A single
+  interrupt is shared for all of the banks handled by the controller.
+
+properties:
+  compatible:
+    const: sprd,sc9860-gpio
+
+  reg:
+    maxItems: 1
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
+    description: The interrupt shared by all GPIO lines for this controller.
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
+        ap_gpio: gpio@40280000 {
+            compatible = "sprd,sc9860-gpio";
+            reg = <0 0x40280000 0 0x1000>;
+            gpio-controller;
+            #gpio-cells = <2>;
+            interrupt-controller;
+            #interrupt-cells = <2>;
+            interrupts = <GIC_SPI 50 IRQ_TYPE_LEVEL_HIGH>;
+        };
+    };
+...
-- 
2.25.1

