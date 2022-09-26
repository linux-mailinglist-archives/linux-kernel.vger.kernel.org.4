Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 486435E9800
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 04:40:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233210AbiIZCkB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Sep 2022 22:40:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233163AbiIZCjw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Sep 2022 22:39:52 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29C9EDFB6;
        Sun, 25 Sep 2022 19:39:47 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d24so4979854pls.4;
        Sun, 25 Sep 2022 19:39:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date;
        bh=WdPMA2pH0mS9gX0lH3J9f/5y/00ONBhVpJZxWxuBUaU=;
        b=i46z/9h4eCp2BjXwoBf1jB8mkWv+ktOSV/sqUZe6WAUgmVDAKTaXGhtpGfhr9gfnVf
         MQcOw1nO0gbWe0w3gP60kKaF8Nwlb54hr9WSLV7Fi01fiyFaAYcvbzVPbgWW+1HqgHsy
         98hvw7+Svp1y26yZZ3E4evhMDsgSKfEs0owQCfMrlslHDWhtnbLG/OtbAMl4oDnM7TJo
         j4/Lg5LGfGYj10tpU/fwKfMmZAS32SG52czeqR4JrTj5uleDb7CCI3BIvfcE71E2A7vl
         YBL9ffx7gzYiJ0cEo4l2aU8/NXL0vVkaX/lPNKsOHpli/VitKCs9ltrJvOOotIynOc5w
         2PTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date;
        bh=WdPMA2pH0mS9gX0lH3J9f/5y/00ONBhVpJZxWxuBUaU=;
        b=8EEv4ic5rFtSrmfKa87sh3Ia+mTLk36nyALWL4Y6xa6C5U/36MlsEl7wFr+ID9H7Be
         2wxEN9Jl4YXwP71ogl+KGceDcc7/P2atnz0DcTs8lR31JnpAAzMnENTbYH9Uvof5qQ+d
         MILGin5B7w+4bYis7RfnDB6bLD6mtcdIKSQ6MFrdH3LXpg9n0p81ZTHzayURA0AAE2Sz
         Kf7h5n8IqzZBwk6rh4M0gJG8CvHNzL7ZGqgG4Sm/QflckWh56caFWnp2IwQdgLDsXHlf
         ReBccglTIPsJSWmLoocMUDGophrQwqVf3RYtQ3KK6Fr+EeZjUtd++pmt4YQLB9A1j01o
         0XHA==
X-Gm-Message-State: ACrzQf1oBeJ+/DZmgMk1bdskSXmQazZvqdTHskoKOT2GjqBKbP7YGTMu
        sPlutHoBGCMZiFCH4rp09KU=
X-Google-Smtp-Source: AMsMyM7Q+Flm9GfFLAHcTEJeG9s9XKjirJnSjJvWEVlnXcTpIAG37D+dQGXPe+OPwk7CsQDRcMdGgA==
X-Received: by 2002:a17:90b:1b4c:b0:202:c1a3:25ce with SMTP id nv12-20020a17090b1b4c00b00202c1a325cemr34956911pjb.232.1664159986404;
        Sun, 25 Sep 2022 19:39:46 -0700 (PDT)
Received: from localhost.localdomain ([49.216.30.246])
        by smtp.gmail.com with ESMTPSA id y3-20020aa793c3000000b005383988ec0fsm10667584pff.162.2022.09.25.19.39.42
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 25 Sep 2022 19:39:45 -0700 (PDT)
From:   cy_huang <u0084500@gmail.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        sre@kernel.org
Cc:     mazziesaccount@gmail.com, alina_yu@richtek.com,
        cy_huang@richtek.com, alinayu829@gmail.com,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v6 1/3] dt-bindings: power: supply: Add Richtek RT9471 battery charger
Date:   Mon, 26 Sep 2022 10:39:30 +0800
Message-Id: <1664159972-4391-2-git-send-email-u0084500@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1664159972-4391-1-git-send-email-u0084500@gmail.com>
References: <1664159972-4391-1-git-send-email-u0084500@gmail.com>
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

