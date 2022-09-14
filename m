Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9380F5B8D22
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 18:32:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230146AbiINQcG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 12:32:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230137AbiINQbc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 12:31:32 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B746A65674;
        Wed, 14 Sep 2022 09:30:26 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id s14-20020a17090a6e4e00b0020057c70943so19597927pjm.1;
        Wed, 14 Sep 2022 09:30:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date;
        bh=WdPMA2pH0mS9gX0lH3J9f/5y/00ONBhVpJZxWxuBUaU=;
        b=NjxUwk0G3MFYreEdPOVK7c0KYfAdv8/fFap3Godlw4xloSUyodqKXyjqfogqvBWtwV
         uM+WW38NpZpChmDP4VdXOxmAL4LJrIfbvKLvMWtMEaAcMCaN+tEcAy2Ao5h3Tj9i1Twx
         HAYvbLhcn8YTR4KKNTD14FBWYaRrhXbHikxUP0LL+inkHrh3JXggGnCI3NvaeJCxifx2
         iyd/RTI4gHCsfGSKcAp7AuRL45ukyF71hltZL3wPjwKM6eAlaEy5zZ1UrwqnwK5v0wz6
         XoxMqMxEmEGFCMxYM2njXzbYqMU5gWnCzimzr7qEuBG5nUyc4WNeu/WkEbjIttiV5DRD
         o5Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date;
        bh=WdPMA2pH0mS9gX0lH3J9f/5y/00ONBhVpJZxWxuBUaU=;
        b=GRBXDH/Sl3p/M7Jv/jp7g1VdM++WI+JFmkSkJerupCh+aKsuuuw4Wanz9b1JFMDtma
         je7P7bXCjnwKuOVnR8TDVmTbmjKRr5CTxsRsoeVf86pu7sPQM5g6KRm0ba2AhKHtrFcp
         LHrPs/88sJu/U5Vt/rXteGMJdes9Zj5zu0eRWgSXBL09QH/KIXHpkJA5sNb72NrwuvQ6
         4V5Z5t1uGOIHJCS43WsY3Az/f4aAdcMN8c+ViK5yz1ddTb3/q1VxQ5lARwKr569Tf/xa
         hi398Vc3BMLDM9Wnv4sFKLbjBdMSeRJ/UVMM02Y3+1ssUi5dqWq24OxCbI2lHZlJRLGQ
         Yq7w==
X-Gm-Message-State: ACgBeo12d9GzcLh5+EqPCBB5QogRk/aD3KeqhcVZCv9VintucGcXUCsk
        MGXUDNy6NCvYLHEE3bwmywc=
X-Google-Smtp-Source: AA6agR7YABGhbP2rPjKqyCzHG7vi4XliI2iZnkCKvhfScqrJLqF8JKDJVcu7YZIwAHBllw92zLr/WA==
X-Received: by 2002:a17:903:244a:b0:177:f32b:19ff with SMTP id l10-20020a170903244a00b00177f32b19ffmr32361712pls.103.1663173025540;
        Wed, 14 Sep 2022 09:30:25 -0700 (PDT)
Received: from localhost.localdomain (1-171-4-145.dynamic-ip.hinet.net. [1.171.4.145])
        by smtp.gmail.com with ESMTPSA id l22-20020a17090af8d600b002031264a864sm1899991pjd.41.2022.09.14.09.30.23
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 14 Sep 2022 09:30:25 -0700 (PDT)
From:   cy_huang <u0084500@gmail.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        sre@kernel.org
Cc:     mazziesaccount@gmail.com, alina_yu@richtek.com,
        cy_huang@richtek.com, alinayu829@gmail.com,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 1/3] dt-bindings: power: supply: Add Richtek RT9471 battery charger
Date:   Thu, 15 Sep 2022 00:30:13 +0800
Message-Id: <1663173015-7934-2-git-send-email-u0084500@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1663173015-7934-1-git-send-email-u0084500@gmail.com>
References: <1663173015-7934-1-git-send-email-u0084500@gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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

