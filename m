Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA83B5F53E1
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 13:44:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230280AbiJELo0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 07:44:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230366AbiJELnX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 07:43:23 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B54077EBC;
        Wed,  5 Oct 2022 04:41:46 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id w191so6159165pfc.5;
        Wed, 05 Oct 2022 04:41:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=OGQtGbNST61z32nTeyZWgElXzweJVoYL16GGInnSB6o=;
        b=CP+PyIimLQA1to17/ATwgBtIiXKWhfaTvUwF953+3P92zTiQS/XIwEkyQoRnsS60hY
         eCVzVq0iljT6L9VJl1Jlqgj9K/huA2+GoxU47p1kuFj51jt+ZQCmkhWhqvN7Rr/TXc1W
         T5UutWJj0iGAIydQSEWEhWZaxU6zHL01Eo48kIa5qX5oc8YAeMGIHxBJrzlmn2bbQkCu
         RGCV/sTAl4wxACCsc9zK675IrJXTTsI6Mt2H6o6X49vr1KiCsOl1YwMB7OFwIeHW8U5Q
         w2v3apqyBqn0/hWvOwHFbifSPSRFaCM+Mrb/emcLpU6F5e/HDtlF1JEhLfr6cCP619rU
         0LNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=OGQtGbNST61z32nTeyZWgElXzweJVoYL16GGInnSB6o=;
        b=cnLC0XhFfAcJL90RuKIVdr9EQz75bbRTJeRna9RGtNcRIkOCPxwRrDRAWKgWJZfw0f
         H9G5p9veV/QoURBgBa71L35HRWOlpYPxX1yqGu15WJC90xrR5pmHDb1bcpTMJKrYxJnY
         XzR9JcUGtSx8PVSNzQkcuRKMaO8OxF4BRaTtFjpGfZwn6OkvTimxfxM+FBkUZv9BKiUt
         wml47PROFJgeLrWoTlp+kCw3QagnKXocZHHCgNxBFDs2PxM//ITKHb6Xdojx6kBOjpET
         KuVYh/UO0QS3EtmkTXw7WjMrVs9oIGbpAe32+Y4hvikF0d+xSvlHmQsrbU5ouX2lVsCn
         9jGw==
X-Gm-Message-State: ACrzQf1WBGeOPQ1kRuxr8SveTy6iaJZTAU2HFgpGCPHEbJvVBo2vZ1sm
        k7azSNhjW75gbkwVkHI6iCPt0h0q5Ndeeg==
X-Google-Smtp-Source: AMsMyM6jbnK7JCwBK1K7yAgYYfTv/gxNGeGTiuO6FKD51tnGfP7Cy5QJv82+hHcyXS5fMa2a9hlNlQ==
X-Received: by 2002:aa7:8299:0:b0:562:4c48:a0cb with SMTP id s25-20020aa78299000000b005624c48a0cbmr1447823pfm.66.1664969981230;
        Wed, 05 Oct 2022 04:39:41 -0700 (PDT)
Received: from RD-3580-24288.rt.l (42-73-126-108.emome-ip.hinet.net. [42.73.126.108])
        by smtp.gmail.com with ESMTPSA id v9-20020a17090a4ec900b00200b2894648sm979202pjl.52.2022.10.05.04.39.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Oct 2022 04:39:40 -0700 (PDT)
From:   ChiaEn Wu <peterwu.pub@gmail.com>
To:     sre@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     chiaen_wu@richtek.com, cy_huang@richtek.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: [PATCH v2 1/3] dt-bindings: power: supply: Add Richtek RT9467 battery charger
Date:   Wed,  5 Oct 2022 19:37:21 +0800
Message-Id: <0a4a6dfcec35160bb89a932ff73bc2cc0bbd6555.1664997251.git.chiaen_wu@richtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1664997251.git.chiaen_wu@richtek.com>
References: <cover.1664997251.git.chiaen_wu@richtek.com>
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

Co-developed-by: ChiYuan Huang <cy_huang@richtek.com>
Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
Signed-off-by: ChiaEn Wu <chiaen_wu@richtek.com>
---

v2
- Revise the definition of 'enable-gpios'
- Revise the node name to generic name in the example
  ('rt9467@5b' --> 'charger@5b')
- Revise the example usage of 'charge-enable-gpios' with GPIO flags
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

