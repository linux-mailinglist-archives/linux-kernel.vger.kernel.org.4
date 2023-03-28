Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 564E56CBA56
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 11:18:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230347AbjC1JSo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 05:18:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229647AbjC1JSk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 05:18:40 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A94EEFB;
        Tue, 28 Mar 2023 02:18:39 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id mp3-20020a17090b190300b0023fcc8ce113so14473840pjb.4;
        Tue, 28 Mar 2023 02:18:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679995119;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/+IPyyhNp73qoNltvA0xh+DDeED+Hk5szkp3yIzG5ew=;
        b=Mj1BLXSaOhBXPLLhEtibxY7jIHXTcO/YzK5aJ5dpWaGXzDvvh2QyjiFD7zRy+xcffv
         cyu3eNIEkPTzAA58KOGOuarRsTECcGBaQcEEWueCgQyALD+udeI07Bf5J80wGw6cPyKt
         ER4C22UdTCos5B/Kn3QathHgJguioBVtVZO3mIJvT+UspUFlafQv4wwoHtPfhf6CGUHp
         b8ig2cRnHxftJq+8MyMpNncmchjRzQdlsokHp1LcgeEh2j1jUz1PMrJOiJLE+afBNm/M
         4w6GO1gLE1jeIqTB1Lq8312Au2SzD2L5RcJbuOo66MdJu5gV/DKySSCDgI6lM5QomnP3
         1X8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679995119;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/+IPyyhNp73qoNltvA0xh+DDeED+Hk5szkp3yIzG5ew=;
        b=VsR4QK09c8VupzYtPpcIMKAoxsVe3QLoiKvJHB1heVXfXjYzGd206zwdzuRUFt/ONv
         4HHAEuUhJ2zgTd6HidH/oe9GlvuDKaLCmrNBjBfBlglGkVMfBTUIP0sM0Co+RC7dd6MO
         N2oj1Jcfrn9H6qj0W0QjzdvTwyBZlhKYyUFf5/zffKt31t2RTWjnCE7kFGj9ORqCK6vB
         cQP/m05wvb9jGRfX3Sbn7pQOtN/u/PogjxTSCeE9p2/BSAF3aFuX+A1JUSbs0RPoFFd3
         l683S4TyqpR5bPSaHX19jsH0ED5012ytwm+HlovXdMJwb/Eol+455WMNp0kT1SGK6vjL
         70PQ==
X-Gm-Message-State: AAQBX9coj02BLK0axBqK2wzH8wpKXu8fZzr6JRsYJP0V+/FaOpCSSBus
        OV8ZHXUSZe0ByspFaYLsxbJDUcJQnAjA/6pp
X-Google-Smtp-Source: AKy350YxEK6TluXcHjKwaXVIAR7NSDQHdUy6r51cfLAe5Q8pIhm+lPEQLnN4FhsLLz3J5pLQEOqeJg==
X-Received: by 2002:a17:902:c950:b0:19e:b9f8:1fca with SMTP id i16-20020a170902c95000b0019eb9f81fcamr19023968pla.10.1679995118814;
        Tue, 28 Mar 2023 02:18:38 -0700 (PDT)
Received: from pavilion.. ([2402:e280:2146:a9a:db37:2c9f:dcb8:89a9])
        by smtp.gmail.com with ESMTPSA id g2-20020a170902c38200b001960706141fsm20587360plg.149.2023.03.28.02.18.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Mar 2023 02:18:38 -0700 (PDT)
From:   Saalim Quadri <danascape@gmail.com>
To:     krzysztof.kozlowski@linaro.org, broonie@kernel.org,
        daniel.baluta@nxp.com, krzysztof.kozlowski+dt@linaro.org,
        robh+dt@kernel.org, shengjiu.wang@nxp.com
Cc:     alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Saalim Quadri <danascape@gmail.com>
Subject: [PATCH v5] ASoC: dt-bindings: ak4458: Convert to dtschema
Date:   Tue, 28 Mar 2023 14:48:31 +0530
Message-Id: <20230328091831.55690-1-danascape@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the AK4458 audio DAC bindings to DT schema.

Signed-off-by: Saalim Quadri <danascape@gmail.com>
---
Changes:
V1 -> V2: Use the correct way for dsd-path property
          Drop ak4458 label form example
V2 -> V3: ak4458 is the only one that does not support dsd-path, so we
          do not require to define an array
V3 -> V4: Add back dsd-path property description
V4 -> V5: Fix yaml format as per example-schema

 .../devicetree/bindings/sound/ak4458.txt      | 28 -------
 .../bindings/sound/asahi-kasei,ak4458.yaml    | 73 +++++++++++++++++++
 2 files changed, 73 insertions(+), 28 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/sound/ak4458.txt
 create mode 100644 Documentation/devicetree/bindings/sound/asahi-kasei,ak4458.yaml

diff --git a/Documentation/devicetree/bindings/sound/ak4458.txt b/Documentation/devicetree/bindings/sound/ak4458.txt
deleted file mode 100644
index 0416c14895d6..000000000000
--- a/Documentation/devicetree/bindings/sound/ak4458.txt
+++ /dev/null
@@ -1,28 +0,0 @@
-AK4458 audio DAC
-
-This device supports I2C mode.
-
-Required properties:
-
-- compatible : "asahi-kasei,ak4458" or "asahi-kasei,ak4497"
-- reg : The I2C address of the device for I2C
-
-Optional properties:
-- reset-gpios: A GPIO specifier for the power down & reset pin
-- mute-gpios: A GPIO specifier for the soft mute pin
-- AVDD-supply: Analog power supply
-- DVDD-supply: Digital power supply
-- dsd-path: Select DSD input pins for ak4497
-            0: select #16, #17, #19 pins
-            1: select #3, #4, #5 pins
-
-Example:
-
-&i2c {
-	ak4458: dac@10 {
-		compatible = "asahi-kasei,ak4458";
-		reg = <0x10>;
-		reset-gpios = <&gpio1 10 GPIO_ACTIVE_LOW>
-		mute-gpios = <&gpio1 11 GPIO_ACTIVE_HIGH>
-	};
-};
diff --git a/Documentation/devicetree/bindings/sound/asahi-kasei,ak4458.yaml b/Documentation/devicetree/bindings/sound/asahi-kasei,ak4458.yaml
new file mode 100644
index 000000000000..0db0c8e923a0
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/asahi-kasei,ak4458.yaml
@@ -0,0 +1,73 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/asahi-kasei,ak4458.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: AK4458 audio DAC
+
+maintainers:
+  - Shengjiu Wang <shengjiu.wang@nxp.com>
+
+properties:
+  compatible:
+    enum:
+      - asahi-kasei,ak4458
+      - asahi-kasei,ak4497
+
+  reg:
+    maxItems: 1
+
+  avdd-supply:
+    description: Analog power supply
+
+  dvdd-supply:
+    description: Digital power supply
+
+  reset-gpios:
+    maxItems: 1
+
+  mute-gpios:
+    maxItems: 1
+    description:
+      GPIO used to mute all the outputs
+
+  dsd-path:
+    description: Select DSD input pins for ak4497
+    $ref: /schemas/types.yaml#/definitions/uint32
+    oneOf:
+      - const: 0
+        description: select #16, #17, #19 pins
+      - const: 1
+        description: select #3, #4, #5 pins
+
+required:
+  - compatible
+  - reg
+
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: asahi-kasei,ak4458
+
+    then:
+      properties:
+        dsd-path: false
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+        codec@10 {
+            compatible = "asahi-kasei,ak4458";
+            reg = <0x10>;
+            reset-gpios = <&gpio1 10 GPIO_ACTIVE_LOW>;
+            mute-gpios = <&gpio1 11 GPIO_ACTIVE_HIGH>;
+        };
+    };
-- 
2.34.1

