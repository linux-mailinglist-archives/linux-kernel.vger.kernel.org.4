Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E244B67EF73
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 21:20:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229757AbjA0UUu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 15:20:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232688AbjA0UUq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 15:20:46 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97A374A238
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 12:20:44 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id l41-20020a05600c1d2900b003daf986faaeso4268567wms.3
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 12:20:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MQJZG/xKcCJsVsFDHrDpLNHly5wPWcC1lO6W1/tImAQ=;
        b=XLswvSn0iWJEiVX86b3AojUKI6gFD+xJfDL0WBc+eU64CJKFU/9zPdXobp2My2DRdM
         qY792thqiotAKFM+YmxxS1AievxqjzritonPJ9vyD5RVNPW8QsNK9/bnYCMPFgYGQIPZ
         SgOLFmJr1a+jhEFFCISU1l/G5+HrMaL+nf2FoQSyUlicGwJmjOFy/3qFDXCXJJcZ+yw0
         IOf1Sf76AUWDCEu0hyxRIfL2Iv3E1jn5Zf/q1ALJYV/gamGrUad5eK6eeEyDE+qIGscb
         tA0Z3USSOxPo8ThdS8K4e+CaEZizIxxSwiyYQvd26m9e6VliSuaHPjKitpiLhGHMc8vZ
         IUVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MQJZG/xKcCJsVsFDHrDpLNHly5wPWcC1lO6W1/tImAQ=;
        b=TNKZT0hI1l42dZP0ETfX6BB+Sj7+dzGQB87f9X+Zfi+oxN4GoHZFX8N9wSBJb3oDj3
         IIeU7lchifcTKR2V8ri9WMRhgYZg00tjrdQFqcWL5eCNiINVc49zEzg5qgCKgeMNMGkc
         EGIWwH0tsG3zgNHcLAW3pR4d8OeIQ2rMAT/3Ptlf+KQG1iO6Ukjfkkk0L9838ec2QmZd
         DP/Nq/JZ6zYDu4zlg7E62HMr9vUlR7PC0zZNi3AO49rl0JxEu1m3qGg7iggxh7PTCh5s
         Tpa9uvMlwFjichyUXfG+rdO/4IRx6sNGlyjuP1g5ITcg24TNyABbmmpuAszRTOhbIovI
         S23Q==
X-Gm-Message-State: AFqh2kold6IzV11qsvhYTO+4ek0w5CvvRHNN0ElERklW8NXRr6rm5riM
        HI/kP6qILGE8s1d2X0A4/IfTPA==
X-Google-Smtp-Source: AMrXdXuNRILKOhT1cKmkeLlOlAI5U7DaEFjqsMn3TViTMRmv1RGPuc0oBtcBH0u3ppdFai6vxu/YCA==
X-Received: by 2002:a05:600c:540d:b0:3d9:fb59:c16b with SMTP id he13-20020a05600c540d00b003d9fb59c16bmr37938172wmb.36.1674850843204;
        Fri, 27 Jan 2023 12:20:43 -0800 (PST)
Received: from krzk-bin.. ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id t1-20020adfe441000000b002bfd524255esm2116881wrm.43.2023.01.27.12.20.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jan 2023 12:20:42 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] dt-bindings: input: touchscreen: st,stmfts: convert to dtschema
Date:   Fri, 27 Jan 2023 21:20:40 +0100
Message-Id: <20230127202040.196411-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the ST-Microelectronics FingerTip touchscreen controller
bindings to DT schema.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../bindings/input/touchscreen/st,stmfts.txt  | 41 -----------
 .../bindings/input/touchscreen/st,stmfts.yaml | 72 +++++++++++++++++++
 2 files changed, 72 insertions(+), 41 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/input/touchscreen/st,stmfts.txt
 create mode 100644 Documentation/devicetree/bindings/input/touchscreen/st,stmfts.yaml

diff --git a/Documentation/devicetree/bindings/input/touchscreen/st,stmfts.txt b/Documentation/devicetree/bindings/input/touchscreen/st,stmfts.txt
deleted file mode 100644
index 0a5d0cb4a280..000000000000
--- a/Documentation/devicetree/bindings/input/touchscreen/st,stmfts.txt
+++ /dev/null
@@ -1,41 +0,0 @@
-* ST-Microelectronics FingerTip touchscreen controller
-
-The ST-Microelectronics FingerTip device provides a basic touchscreen
-functionality. Along with it the user can enable the touchkey which can work as
-a basic HOME and BACK key for phones.
-
-The driver supports also hovering as an absolute single touch event with x, y, z
-coordinates.
-
-Required properties:
-- compatible		: must be "st,stmfts"
-- reg			: I2C slave address, (e.g. 0x49)
-- interrupts		: interrupt specification
-- avdd-supply		: analogic power supply
-- vdd-supply		: power supply
-- touchscreen-size-x	: see touchscreen.txt
-- touchscreen-size-y	: see touchscreen.txt
-
-Optional properties:
-- touch-key-connected	: specifies whether the touchkey feature is connected
-- ledvdd-supply		: power supply to the touch key leds
-
-Example:
-
-i2c@00000000 {
-
-	/* ... */
-
-	touchscreen@49 {
-		compatible = "st,stmfts";
-		reg = <0x49>;
-		interrupt-parent = <&gpa1>;
-		interrupts = <1 IRQ_TYPE_NONE>;
-		touchscreen-size-x = <1599>;
-		touchscreen-size-y = <2559>;
-		touch-key-connected;
-		avdd-supply = <&ldo30_reg>;
-		vdd-supply = <&ldo31_reg>;
-		ledvdd-supply = <&ldo33_reg>;
-	};
-};
diff --git a/Documentation/devicetree/bindings/input/touchscreen/st,stmfts.yaml b/Documentation/devicetree/bindings/input/touchscreen/st,stmfts.yaml
new file mode 100644
index 000000000000..c593ae63d0ec
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/touchscreen/st,stmfts.yaml
@@ -0,0 +1,72 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/input/touchscreen/st,stmfts.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: ST-Microelectronics FingerTip touchscreen controller
+
+maintainers:
+  - Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
+
+description:
+  The ST-Microelectronics FingerTip device provides a basic touchscreen
+  functionality. Along with it the user can enable the touchkey which can work
+  as a basic HOME and BACK key for phones.
+
+allOf:
+  - $ref: touchscreen.yaml#
+
+properties:
+  compatible:
+    const: st,stmfts
+
+  reg:
+    maxItems: 1
+
+  avdd-supply:
+    description: Analogic power supply
+
+  interrupts:
+    maxItems: 1
+
+  ledvdd-supply:
+    description: Power supply to the touch key leds
+
+  touch-key-connected:
+    type: boolean
+    description: The touchkey feature is connected
+
+  vdd-supply:
+    description: Power supply
+
+required:
+  - compatible
+  - reg
+  - avdd-supply
+  - interrupts
+  - vdd-supply
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        touchscreen@49 {
+            compatible = "st,stmfts";
+            reg = <0x49>;
+            interrupt-parent = <&gpa1>;
+            interrupts = <1 IRQ_TYPE_LEVEL_LOW>;
+            touchscreen-size-x = <1599>;
+            touchscreen-size-y = <2559>;
+            touch-key-connected;
+            avdd-supply = <&ldo30_reg>;
+            vdd-supply = <&ldo31_reg>;
+            ledvdd-supply = <&ldo33_reg>;
+        };
+    };
-- 
2.34.1

