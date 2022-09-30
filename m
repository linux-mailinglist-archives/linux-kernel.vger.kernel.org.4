Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A01B5F0E0D
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 16:53:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231491AbiI3OxM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 10:53:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232165AbiI3Owd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 10:52:33 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A7427FF98;
        Fri, 30 Sep 2022 07:50:30 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id bh13so4383326pgb.4;
        Fri, 30 Sep 2022 07:50:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date;
        bh=WdPMA2pH0mS9gX0lH3J9f/5y/00ONBhVpJZxWxuBUaU=;
        b=pB/uSZK7TKtoHb3P0tHZlxiVb2MmVxFiTctltLmpYgs0/zKbkTeTSH6lnPbvysV/ee
         pGWGqlS4rqM9EHaqI4F8jrIUleR1oUlBeooK3T6lKV8yMfyj42m3XrC1FVJY4SbSdpjC
         jgL86gVpjY+cMf/pGla+lEJEKjdOzM0odw2LvQdQV98XHOlhywbd7g7Vg5Uo7cjr9FIa
         X4NWrag8Ux2wsCZUeYEniT4w7gTwGzhi9FNWmDvWuPfFi0W9DfsRnGQLSQnOF5hTEoJ6
         cByZS05azTMmAHy0gHh0LZ3gWgb3XGcMXBRKsAmpeNkB31a8nD1qRQKJBMGkwbjpo3tQ
         v1+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date;
        bh=WdPMA2pH0mS9gX0lH3J9f/5y/00ONBhVpJZxWxuBUaU=;
        b=6QDpjKAtkYOiRmM+iA3jIf6Pg4q/paQmtlBuQvvZIUijO2U8moX0i0YQn6qfBLYaUS
         GWOfpcmlGr+MG/e5L7smkaV96xsL3EORQHi0Hi/uh+KhVRternOzFzfZ3iEr7oUOuzfQ
         gb55KPnAfV2XfTyg2N0cYFIP0l6JPmK6AB8izs2mN8/5HP3ixFcCtIhKYDxbqA33LW9y
         Lykvq+f805OiK/5tQKyjMQSCrBQ5eGWYl0bRZWQqF4mQZ64sYpvHTJgV3ZZzUdgQZxSK
         wEsNlVvp81FakeK8g6qA6ZF2tl2SXM1WrHAVBuOZIUXc//tcXhisp9y7co5uAotNc1bj
         j3YQ==
X-Gm-Message-State: ACrzQf1i6Bp9CqvZ8akT49N9vdr7WCzWlt78UxzYnyjJu0PA4vjCe3sU
        oO5Pmwzzsik/E9wxV75T4/o=
X-Google-Smtp-Source: AMsMyM7lSrd6I+EyrmIKZ59HeFNBzzzwzvzBqa1+6T5I8vacNfC+a5B4TulUNv+nlxZ/VkVbva86GA==
X-Received: by 2002:a05:6a00:2409:b0:54e:a3ad:d32d with SMTP id z9-20020a056a00240900b0054ea3add32dmr9569310pfh.70.1664549424091;
        Fri, 30 Sep 2022 07:50:24 -0700 (PDT)
Received: from localhost.localdomain (1-171-4-69.dynamic-ip.hinet.net. [1.171.4.69])
        by smtp.gmail.com with ESMTPSA id 3-20020a17090a01c300b001fb1de10a4dsm1731608pjd.33.2022.09.30.07.50.21
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 30 Sep 2022 07:50:23 -0700 (PDT)
From:   cy_huang <u0084500@gmail.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        sre@kernel.org
Cc:     mazziesaccount@gmail.com, alina_yu@richtek.com,
        cy_huang@richtek.com, alinayu829@gmail.com,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v8 1/3] dt-bindings: power: supply: Add Richtek RT9471 battery charger
Date:   Fri, 30 Sep 2022 22:50:07 +0800
Message-Id: <1664549409-4280-2-git-send-email-u0084500@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1664549409-4280-1-git-send-email-u0084500@gmail.com>
References: <1664549409-4280-1-git-send-email-u0084500@gmail.com>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: ChiYuan Huang <cy_huang@richtek.com>

Add bindings for the Richtek RT9471 I2C controlled battery charger.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Co-developed-by: Alina Yu <alina_yu@richtek.com>
Signed-off-by: Alina Yu <alina_yu@richtek.com>
Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
---
Since v3
- Move unevaluatedProperties line after $ref for binding patch.
- Add Reviewed-by tag for binding patch.

Since v2
- Remove the properties for interrupt controller things in the binding documentation.
- Fix dtc error for typo, it's 'regulator-name', not 'regulator-compatible'.
- Add regulator min/max microamp to allow otg vbus current adjustable in example.
- Specify the active-level for charge-enable-gpios in binding example.

---
 .../bindings/power/supply/richtek,rt9471.yaml      | 73 ++++++++++++++++++++++
 1 file changed, 73 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/supply/richtek,rt9471.yaml

diff --git a/Documentation/devicetree/bindings/power/supply/richtek,rt9471.yaml b/Documentation/devicetree/bindings/power/supply/richtek,rt9471.yaml
new file mode 100644
index 00000000..fbb54cf
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/supply/richtek,rt9471.yaml
@@ -0,0 +1,73 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/power/supply/richtek,rt9471.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Richtek RT9471 3A Single Cell Switching Battery charger
+
+maintainers:
+  - Alina Yu <alina_yu@richtek.com>
+  - ChiYuan Huang <cy_huang@richtek.com>
+
+description: |
+  RT9471 is a switch-mode single cell Li-Ion/Li-Polymer battery charger for
+  portable applications. It supports USB BC1.2 port detection, current and
+  voltage regulations in both charging and boost mode.
+
+  Datasheet is available at
+  https://www.richtek.com/assets/product_file/RT9471=RT9471D/DS9471D-02.pdf
+
+properties:
+  compatible:
+    const: richtek,rt9471
+
+  reg:
+    maxItems: 1
+
+  charge-enable-gpios:
+    description: GPIO used to turn on and off charging.
+    maxItems: 1
+
+  wakeup-source: true
+
+  interrupts:
+    maxItems: 1
+
+  usb-otg-vbus-regulator:
+    type: object
+    $ref: /schemas/regulator/regulator.yaml#
+    unevaluatedProperties: false
+
+required:
+  - compatible
+  - reg
+  - wakeup-source
+  - interrupts
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    #include <dt-bindings/gpio/gpio.h>
+    i2c {
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      charger@53 {
+        compatible = "richtek,rt9471";
+        reg = <0x53>;
+        charge-enable-gpios = <&gpio26 1 GPIO_ACTIVE_LOW>;
+        wakeup-source;
+        interrupts-extended = <&gpio_intc 32 IRQ_TYPE_EDGE_FALLING>;
+
+        usb-otg-vbus-regulator {
+          regulator-name = "usb-otg-vbus";
+          regulator-min-microvolt = <4850000>;
+          regulator-max-microvolt = <5300000>;
+          regulator-min-microamp = <500000>;
+          regulator-max-microamp = <1200000>;
+        };
+      };
+    };
-- 
2.7.4

