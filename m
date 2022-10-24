Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1FE7609F7F
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 12:58:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229917AbiJXK6I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 06:58:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230007AbiJXK50 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 06:57:26 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D78575BC94;
        Mon, 24 Oct 2022 03:57:07 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id m6-20020a17090a5a4600b00212f8dffec9so3145778pji.0;
        Mon, 24 Oct 2022 03:57:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gPbVTFyk3tltxSTq5T8PYk7djg+cSGB9qpQcQ22RTgU=;
        b=QJ1wMiI9PwI4ebe9DWp/6xTxEWbGJQ5wKGQfZWfCGkBqK59VL1EfCVNuY5uILd3Gda
         cVdls9CaxLzFVZDoj9kt5GS69OPz0GGAVK1WQ9miv86MgWZCwo79SZw7EX/gx5ookIFl
         8Lb6Ei6NkmPq+z0Wdihqa1pX/8ZrmHuK/zc7JexSFjWescHvgLSCtUd6LsyZuoWonsZj
         CJAOKlTL5uXdYy9jcbXn4idVU6hfFR2jmclgaaqPBKD/y/Y+oi0wQT4XFPNMv7P+Npr/
         kjH3nfj7LBgG3D2YsXsuogtsxyXVxmzAk9zeQsButy8FQ1U6cgdrv+zEaz/y/qB6/atL
         QATw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gPbVTFyk3tltxSTq5T8PYk7djg+cSGB9qpQcQ22RTgU=;
        b=W7BCtWO20gLpZFo+P80kyyAlWjLq1uKecdp7ZuRhOZlMOaLX4uhrV19dK+R8j6Roz4
         /0XdTt3GX6sNWSVTY2MIxEX4mfL3n39dJlIJgizuqMywJqemDrVUo4RBjfR1EkiXeB9s
         HuCRPF/X3qtv6EQJji3fc+Dy31T7w7h/aLY/6ttk5ZsRVzRf5/+1odz8Fo1urKoVLddY
         h6Vwh2i+ozfe2KjfaQllXJJ5dZIYENMcLe1PXPkMAKQfVF1ifL02isxyfYno46NvyqL/
         ZKbY998mxgiQcbQYxrn1sQUCCjHXSsVbjk/Qb/nzls4EmiAZYK+MsuYJP4WO3eEWeb96
         JQvw==
X-Gm-Message-State: ACrzQf1jOiAKbr9/r9X9feYStJvUN30IC+I+uoHlOSdubvgMFJ8yDNXk
        eL5+JbizAotcKQhKN7ljrUkSOPd/LNY=
X-Google-Smtp-Source: AMsMyM68kUOwnsAJtYSklJybuOLJOEQhF43qMf+c7tW3kq7ODKmYHATRVMaMEcH9hj67XN2AMZTdPg==
X-Received: by 2002:a17:90a:e593:b0:212:f0e8:46ca with SMTP id g19-20020a17090ae59300b00212f0e846camr10608970pjz.144.1666609015464;
        Mon, 24 Oct 2022 03:56:55 -0700 (PDT)
Received: from RD-3580-24288.rt.l (111-82-141-7.emome-ip.hinet.net. [111.82.141.7])
        by smtp.gmail.com with ESMTPSA id a15-20020a631a4f000000b0045751ef6423sm1366696pgm.87.2022.10.24.03.56.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Oct 2022 03:56:55 -0700 (PDT)
From:   ChiaEn Wu <peterwu.pub@gmail.com>
To:     sre@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     chiaen_wu@richtek.com, cy_huang@richtek.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v3 1/3] dt-bindings: power: supply: Add Richtek RT9467 battery charger
Date:   Mon, 24 Oct 2022 18:55:46 +0800
Message-Id: <d34b98ea46d10f6292d4d5d45f2b355e60854abe.1666633143.git.chiaen_wu@richtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1666633143.git.chiaen_wu@richtek.com>
References: <cover.1666633143.git.chiaen_wu@richtek.com>
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

From: ChiaEn Wu <chiaen_wu@richtek.com>

Add bindings for the Richtek RT9467 battery charger.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Co-developed-by: ChiYuan Huang <cy_huang@richtek.com>
Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
Signed-off-by: ChiaEn Wu <chiaen_wu@richtek.com>
---

v3
- Add 'Reviewed-by' tag
---
 .../power/supply/richtek,rt9467-charger.yaml       | 82 ++++++++++++++++++++++
 1 file changed, 82 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/supply/richtek,rt9467-charger.yaml

diff --git a/Documentation/devicetree/bindings/power/supply/richtek,rt9467-charger.yaml b/Documentation/devicetree/bindings/power/supply/richtek,rt9467-charger.yaml
new file mode 100644
index 0000000..92c5706
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/supply/richtek,rt9467-charger.yaml
@@ -0,0 +1,82 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/power/supply/richtek,rt9467-charger.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Richtek RT9467 Switching Battery Charger with Power Path Management
+
+maintainers:
+  - ChiYuan Huang <cy_huang@richtek.com>
+  - ChiaEn Wu <chiaen_wu@richtek.com>
+
+description: |
+  RT9467 is a switch-mode single cell Li-Ion/Li-Polymer battery charger for
+  portable applications. It integrates a synchronous PWM controller, power
+  MOSFETs, input current sensing and regulation, high-accuracy voltage
+  regulation, and charge termination. The charge current is regulated through
+  integrated sensing resistors.
+
+  The RT9467 also features USB On-The-Go (OTG) support. It also integrates
+  D+/D- pin for USB host/charging port detection.
+
+  Datasheet is available at
+  https://www.richtek.com/assets/product_file/RT9467/DS9467-01.pdf
+
+properties:
+  compatible:
+    const: richtek,rt9467-charger
+
+  reg:
+    maxItems: 1
+
+  wakeup-source: true
+
+  interrupts:
+    maxItems: 1
+
+  charge-enable-gpios:
+    description: GPIO is used to turn on and off charging.
+    maxItems: 1
+
+  usb-otg-vbus-regulator:
+    type: object
+    description: OTG boost regulator.
+    unevaluatedProperties: false
+    $ref: /schemas/regulator/regulator.yaml#
+
+    properties:
+      enable-gpios: true
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
+      charger@5b {
+        compatible = "richtek,rt9467-charger";
+        reg = <0x5b>;
+        wakeup-source;
+        interrupts-extended = <&gpio_intc 32 IRQ_TYPE_LEVEL_LOW>;
+        charge-enable-gpios = <&gpio26 1 GPIO_ACTIVE_LOW>;
+
+        rt9467_otg_vbus: usb-otg-vbus-regulator {
+          regulator-name = "rt9467-usb-otg-vbus";
+          regulator-min-microvolt = <4425000>;
+          regulator-max-microvolt = <5825000>;
+          regulator-min-microamp = <500000>;
+          regulator-max-microamp = <3000000>;
+        };
+      };
+    };
-- 
2.7.4

