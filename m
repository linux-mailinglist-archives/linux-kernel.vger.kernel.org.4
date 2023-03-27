Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B00266CB0B9
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 23:33:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231359AbjC0VdA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 17:33:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbjC0Vc6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 17:32:58 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E09F1FCF;
        Mon, 27 Mar 2023 14:32:57 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id p3-20020a17090a74c300b0023f69bc7a68so10432621pjl.4;
        Mon, 27 Mar 2023 14:32:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679952777;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XS2emH9pO0VgJZsxSC0xvhXyPpgeamtgkfj2ufmzoQ4=;
        b=Xwdz5uLYMkKRlJ7QhGHhUC5a0UXyllyo2QTGKel5MghlcGLxRd7qS32BKrQGGRTUVO
         dS2EBwDqrsCp43dEDKpFrQwqOSirUzUd7Zx6ef+klRwvlEmPXsMkxO1de9sZ45IeIRLr
         thbxu7pCIPnD9WHTmgOr2nEB3tkvXF3fAA//SopzBmrE5gCNirZ/yzQUlC939aTAQubv
         7ZU7rBejIkb/1D8We0DDriPd6ps3/mHIeUae3Q4NSImnrh6oD6f3V+lE9sRgFQCfM/iM
         l18V511EuGsVQDYxbGdSymvXl2ZluFZ0XYpXR41aUM/BNbm5jFrB5kdCNI0Aqq6i8Hhd
         i5bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679952777;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XS2emH9pO0VgJZsxSC0xvhXyPpgeamtgkfj2ufmzoQ4=;
        b=Rc3oOxabaJRrq0lV6ca9tgP2pppeaoM4rawb/sz/3Vjii8s5xhXGmFH9DTTJAY0EBW
         K44z0Sr/klbTCMZXoj7IJQU5qygjHHndigA98DnBici+PZ7SmRjiFb9SMt3bVkwW150Y
         Urgf36ClQp0gLqYgVbD71SSO17kDgVoOlf0cqXK+XdUSdouMLEtqJwrhgS3kQWUH/h0W
         dMwN3LKm2qaeKMhI21f5+bT0QV1w8DhkdJUM4R8w9jLFjnsVjmNkwd8GaiGtbgxaZ7xZ
         G7zUtuc12nZ5q4nOQnCXvN0jrHu1Mgfwape+yvNn5TkLy0dj0wPjjq+6VCrj4vQfSRIA
         AoBQ==
X-Gm-Message-State: AAQBX9f+6FOxHC3i2s+Ua79ttDx+4zwYVYU/zojPBiEdn6kmCLGPe9Oe
        QRNP3RhnRzPPFk78h3AMdf54unQqjTxwbZUr
X-Google-Smtp-Source: AKy350YAuWuNPsuEzw8wb8fThG1T4e3di0A7+p9ziVG/f3zg3S/YXInHB0CFIngc350y0EZkMIaXXA==
X-Received: by 2002:a17:90b:314e:b0:23d:286:47d3 with SMTP id ip14-20020a17090b314e00b0023d028647d3mr14953135pjb.40.1679952776972;
        Mon, 27 Mar 2023 14:32:56 -0700 (PDT)
Received: from pavilion.. ([2402:e280:2146:a9a:db37:2c9f:dcb8:89a9])
        by smtp.gmail.com with ESMTPSA id z18-20020a63e552000000b0050f6add54fcsm15294399pgj.44.2023.03.27.14.32.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Mar 2023 14:32:56 -0700 (PDT)
From:   Saalim Quadri <danascape@gmail.com>
To:     krzysztof.kozlowski@linaro.org, broonie@kernel.org,
        daniel.baluta@nxp.com, krzysztof.kozlowski+dt@linaro.org,
        robh+dt@kernel.org, shengjiu.wang@nxp.com
Cc:     alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Saalim Quadri <danascape@gmail.com>
Subject: [PATCH v3] ASoC: dt-bindings: ak4458: Convert to dtschema
Date:   Tue, 28 Mar 2023 03:02:50 +0530
Message-Id: <20230327213250.29199-1-danascape@gmail.com>
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

 .../devicetree/bindings/sound/ak4458.txt      | 28 --------
 .../bindings/sound/asahi-kasei,ak4458.yaml    | 65 +++++++++++++++++++
 2 files changed, 65 insertions(+), 28 deletions(-)
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
index 000000000000..3842e75d9921
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/asahi-kasei,ak4458.yaml
@@ -0,0 +1,65 @@
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
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            const:
+              asahi-kasei,ak4458
+
+    then:
+      properties:
+        dsd-path: false
+
+required:
+  - compatible
+  - reg
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

