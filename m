Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (unknown [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F40B5F97CB
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 07:34:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231224AbiJJFe2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 01:34:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231173AbiJJFeT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 01:34:19 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A813250183;
        Sun,  9 Oct 2022 22:34:18 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id y1so2730388pfr.3;
        Sun, 09 Oct 2022 22:34:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=dLRkucuIoxKRmUZI1QpIC5BAZr/CZYrUSORj06J1xo0=;
        b=LnLtBwFn1AfUR5CjQaPpakzN9gmMyktwgCC/JGR4VEy5KreudPA6qNKlkHAU6/muvI
         GEzbnnRN7w5APO7XihJ3iGGO4/00J5tQpLHNxWZUcivaZyoTV4xdcwcBGeGUPXw/GS6u
         0eShi7j769WZlvCdWftf1KebaGLBUb/F19G+WVmmWWtCpeycLmoPp4TdJF0t4DgzcKCS
         xHMNkz6Cod/R80Hy9HeEdGmYLbo1HLzlrTcBW0GG25Niy4+G1povi0iFOeCAlwoO9g+I
         ZCXjRRgVns5FnCVwrnbc2vJiD2IbrhuyBascSe9rmUNJecX+xQAvLz4iVs7EO/Wbi7uN
         OUHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dLRkucuIoxKRmUZI1QpIC5BAZr/CZYrUSORj06J1xo0=;
        b=DvMT/Q8XYgE89vxP8JRrp5TdDWaP1b1MioVqOn1RdnePF/tp8YDqISNeL9u3EEElH0
         xTUPCKayNA8ZXjDmq+epWRLKzihywgAQwPcTINmJqJdtD0W3gszhQEdgHw998TZdpKx4
         LfV28hiyyb28S+dTOu6yAcUcsu7Q+71hnr7MPrcAuasxenSxlqtsbTD2xF0ckGzOvhWj
         PETLSO99bxv45PFs1gRIudXt3SKXzk9trzX1oFkiHPAoYj7qNAwlfYaQZXjmQoYp5VZ2
         25Pdt0FyfYPvyaw/f4F7v4H3BShk1CUIukZF86c70zx+FsYwSJ/X+3+/m0bTtvSywUJt
         zzcQ==
X-Gm-Message-State: ACrzQf049WV/ZyiRnuXuiySrfO3hjqx2CvneZKVMymGx08tgx29NjAvM
        Fg/L2rYB3UAq26puns72lug=
X-Google-Smtp-Source: AMsMyM6mAodFann9MhekFexSYQraTr6IZLEgCm3bYAMoAEqIGCPHBSPlJQnsfKqrmbCMzt3SJQbkhA==
X-Received: by 2002:a63:6cca:0:b0:43c:7998:8a78 with SMTP id h193-20020a636cca000000b0043c79988a78mr15075072pgc.600.1665380058146;
        Sun, 09 Oct 2022 22:34:18 -0700 (PDT)
Received: from xm06403pcu.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id 126-20020a620584000000b00562519cad97sm5891920pff.19.2022.10.09.22.34.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Oct 2022 22:34:17 -0700 (PDT)
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
Subject: [PATCH V3 1/3] dt-bindings: gpio: Convert Unisoc GPIO controller binding to yaml
Date:   Mon, 10 Oct 2022 13:33:36 +0800
Message-Id: <20221010053338.22580-2-zhang.lyra@gmail.com>
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

Convert the Unisoc gpio controller binding to DT schema format.

Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
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
index 000000000000..40924123d184
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
+description: |
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

