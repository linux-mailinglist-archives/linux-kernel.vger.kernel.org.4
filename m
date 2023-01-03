Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA8A765BB3A
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 08:30:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236878AbjACHaN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 02:30:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236907AbjACHaK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 02:30:10 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BED89DEB8;
        Mon,  2 Jan 2023 23:30:09 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id m7-20020a17090a730700b00225ebb9cd01so23171812pjk.3;
        Mon, 02 Jan 2023 23:30:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W+TEMXtlD8IfIyObCOJOIDxMSfmiP50ZU+lxr4CNSac=;
        b=B8XP+Pa4CPwUZ7Kxc/0k5JS89cn+jmNecF/tCrlqKY/gTS8SdtVJftUEuqOgQSB6yD
         kbSR/cW7U0OMjvgyGMyF12u3hOpSQCCq5e/SXtezGw1Qi3IKDG/r7g1rkG/bgwxA395+
         lakdzkbAdKVyohQdtpImJrTJsJhj892yyZaoiTNUJfjICvA5GlieLIyFMIyGhUue/HLj
         RDBVVf0DS3sioh1lIy87RyGMgNtGItlX3+A7ALU9o+TRnFgYs7VJBsZt1P0O1TK+mZQq
         LP2SKwgUykbn45kuRlgkGD66utkDQ49CBnqwfr8suRzQjHJi1lW7MzLhHNU2DzLsbqQ5
         lXbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W+TEMXtlD8IfIyObCOJOIDxMSfmiP50ZU+lxr4CNSac=;
        b=wqrEBnQ5GVAaUBjBzifLRt0wVUtf7ZeXlfyeBDOk7YFZJNKECs5QvDqmWWsnTLfI3q
         +cZgwseJHHsK9Vd/2qKDNbjDc2mXmqb6uShuqGY01vIOivbbju0z0Gy+wqoqfNNkgbeX
         BCF93LlReXOqjfADW1UmphRdWgpAdeW9V6GuQ5Fcxs4CMRHI09NnvWb74IGfBgXeo6rU
         +tZIIQlkUard8SVfOVN4sKLuJIRqOIyV/CTqNYwF7ijkujDr+qXyqDRR89aWePs8J6us
         6CDz6PdeLqzwDj1sSGhcO/CBqVI/kNTl/FNP3qcx0YqRWRcd0ZlsIwbHFMKavwfHeZp9
         60zA==
X-Gm-Message-State: AFqh2kpderXKxAXi+3rjbkI6j/XFEuoQSs7iDy392RwcKKaYuIuqbNzV
        bPEdbOjtEAAy1ZKqc3yOi7E=
X-Google-Smtp-Source: AMrXdXv+dhuIo4AwlfUZpg+5WsIYr7Bfm3EzeaNrfB9En+jCMEL523jrNbu8Q8GIlEDgzjm4+WsVUw==
X-Received: by 2002:a17:902:7c8a:b0:192:835d:c861 with SMTP id y10-20020a1709027c8a00b00192835dc861mr25846602pll.68.1672731009259;
        Mon, 02 Jan 2023 23:30:09 -0800 (PST)
Received: from RD-3580-24288.rt.l (42-73-255-34.emome-ip.hinet.net. [42.73.255.34])
        by smtp.gmail.com with ESMTPSA id f4-20020a170902684400b00189f69c1aa0sm21449839pln.270.2023.01.02.23.30.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Jan 2023 23:30:09 -0800 (PST)
From:   ChiaEn Wu <peterwu.pub@gmail.com>
To:     sre@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     chiaen_wu@richtek.com, cy_huang@richtek.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH RESEND v3 1/3] dt-bindings: power: supply: Add Richtek RT9467 battery charger
Date:   Tue,  3 Jan 2023 15:29:56 +0800
Message-Id: <87f9570fa87fad828cb2f67e448ad867384ea958.1672730839.git.chiaen_wu@richtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1672730839.git.chiaen_wu@richtek.com>
References: <cover.1672730839.git.chiaen_wu@richtek.com>
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
 .../power/supply/richtek,rt9467-charger.yaml  | 82 +++++++++++++++++++
 1 file changed, 82 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/supply/richtek,rt9467-charger.yaml

diff --git a/Documentation/devicetree/bindings/power/supply/richtek,rt9467-charger.yaml b/Documentation/devicetree/bindings/power/supply/richtek,rt9467-charger.yaml
new file mode 100644
index 000000000000..92c570643d2c
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
2.25.1

