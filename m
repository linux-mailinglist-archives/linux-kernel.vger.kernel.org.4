Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D284661BA2
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 01:47:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231238AbjAIArM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Jan 2023 19:47:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229693AbjAIArK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Jan 2023 19:47:10 -0500
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEF20101FE;
        Sun,  8 Jan 2023 16:47:08 -0800 (PST)
Received: by mail-qt1-f177.google.com with SMTP id z12so6747737qtv.5;
        Sun, 08 Jan 2023 16:47:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zZA6oP2a40183ZjMgqJ/lEXYXeS4CqviLYyXC0p0X3c=;
        b=IUT1c3npw39d3hYZKJGt59e23kAvL3ps03BqDuVv40+9ZbVgjldLGWlFD1gp0Fb4sR
         Vk0IlY2t4sl+ICnyCPziJXgXqeMcGLeyl5W15R+tYxWwcuYtwawYSTbKY67zFsl31uM+
         1EZDZ5PH8EzBfoMKiIICjhDHJ/B5eE2KxIJxjEpHP24PPHEeCjEgep7sVwOafgvkHx6B
         1Bntx+rlbuIlY19dZCVjSR0qxkjZKWtKp7VqerQp3+9M9sCxiTM4UB4kIED0dNy/Cfjd
         ODmunckck4/IXmpMGHoRpBHPsjyRUQk1lA5K5g8/LURTAPIntkk6OqQ8ZZSwf4Wouf6m
         pIdg==
X-Gm-Message-State: AFqh2kpF3vWYGjfPrv2MyfdzEgSHO8R565PKzKnYetPgF8LpqD2dnAY4
        ydGPoUSr82+kHUM0kD0mriBbcDOtJg==
X-Google-Smtp-Source: AMrXdXuGvoGOeS0d0QjqwsD7S9IDaAlr2IYj4+ERDsmz8xEdpP4oSIkw2kdpR0naQO8QWFIP3FAoKA==
X-Received: by 2002:ac8:4606:0:b0:3ac:6ce1:944c with SMTP id p6-20020ac84606000000b003ac6ce1944cmr6401318qtn.23.1673225227744;
        Sun, 08 Jan 2023 16:47:07 -0800 (PST)
Received: from robh_at_kernel.org ([2605:ef80:80a9:4fff:3718:36aa:838a:7b88])
        by smtp.gmail.com with ESMTPSA id c8-20020ac86608000000b003a4f435e381sm3864130qtp.18.2023.01.08.16.47.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Jan 2023 16:47:07 -0800 (PST)
Received: (nullmailer pid 451413 invoked by uid 1000);
        Mon, 09 Jan 2023 00:47:05 -0000
From:   Rob Herring <robh@kernel.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH v2] regulator: dt-bindings: Convert Fairchild FAN53555 to DT schema
Date:   Sun,  8 Jan 2023 18:46:56 -0600
Message-Id: <20230109004656.451231-1-robh@kernel.org>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the Fairchild FAN53555 and compatible variants binding to DT
schema format.

Add the undocumented 'vsel-gpios' property used to control the VSEL pin.

The example was missing 'reg', so add it.

Signed-off-by: Rob Herring <robh@kernel.org>
---
v2:
 - Add vsel-gpios property
---
 .../bindings/regulator/fan53555.txt           | 24 -------
 .../bindings/regulator/fcs,fan53555.yaml      | 64 +++++++++++++++++++
 2 files changed, 64 insertions(+), 24 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/regulator/fan53555.txt
 create mode 100644 Documentation/devicetree/bindings/regulator/fcs,fan53555.yaml

diff --git a/Documentation/devicetree/bindings/regulator/fan53555.txt b/Documentation/devicetree/bindings/regulator/fan53555.txt
deleted file mode 100644
index 013f096ac0aa..000000000000
--- a/Documentation/devicetree/bindings/regulator/fan53555.txt
+++ /dev/null
@@ -1,24 +0,0 @@
-Binding for Fairchild FAN53555 regulators
-
-Required properties:
-  - compatible: one of "fcs,fan53555", "fcs,fan53526", "silergy,syr827",
-		"silergy,syr828" or "tcs,tcs4525".
-  - reg: I2C address
-
-Optional properties:
-  - fcs,suspend-voltage-selector: declare which of the two available
-		voltage selector registers should be used for the suspend
-		voltage. The other one is used for the runtime voltage setting
-		Possible values are either <0> or <1>
-  - vin-supply: regulator supplying the vin pin
-
-Example:
-
-	regulator@40 {
-		compatible = "fcs,fan53555";
-		regulator-name = "fan53555";
-		regulator-min-microvolt = <1000000>;
-		regulator-max-microvolt = <1800000>;
-		vin-supply = <&parent_reg>;
-		fcs,suspend-voltage-selector = <1>;
-	};
diff --git a/Documentation/devicetree/bindings/regulator/fcs,fan53555.yaml b/Documentation/devicetree/bindings/regulator/fcs,fan53555.yaml
new file mode 100644
index 000000000000..c0dbba843f70
--- /dev/null
+++ b/Documentation/devicetree/bindings/regulator/fcs,fan53555.yaml
@@ -0,0 +1,64 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/regulator/fcs,fan53555.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Fairchild FAN53555 regulators
+
+maintainers:
+  - Heiko Stuebner <heiko@sntech.de>
+
+allOf:
+  - $ref: regulator.yaml#
+
+properties:
+  compatible:
+    enum:
+      - fcs,fan53555
+      - fcs,fan53526
+      - silergy,syr827
+      - silergy,syr828
+      - tcs,tcs4525
+
+  reg:
+    maxItems: 1
+
+  fcs,suspend-voltage-selector:
+    description: Declares which of the two available voltage selector
+      registers should be used for the suspend voltage. The other one is used
+      for the runtime voltage setting.
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum: [ 0, 1 ]
+
+  vin-supply:
+    description: Supply for the vin pin
+
+  vsel-gpios:
+    description: Voltage Select. When this pin is LOW, VOUT is set by the
+      VSEL0 register. When this pin is HIGH, VOUT is set by the VSEL1 register.
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        regulator@40 {
+            compatible = "fcs,fan53555";
+            reg = <0x40>;
+            regulator-name = "fan53555";
+            regulator-min-microvolt = <1000000>;
+            regulator-max-microvolt = <1800000>;
+            vin-supply = <&parent_reg>;
+            fcs,suspend-voltage-selector = <1>;
+        };
+    };
+...
-- 
2.39.0

