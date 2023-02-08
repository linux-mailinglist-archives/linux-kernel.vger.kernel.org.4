Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D56FC68F2C1
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 17:04:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230399AbjBHQEk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 11:04:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229936AbjBHQEi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 11:04:38 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA63A4C6C5
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 08:04:14 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id l37-20020a05600c1d2500b003dfe46a9801so1873020wms.0
        for <linux-kernel@vger.kernel.org>; Wed, 08 Feb 2023 08:04:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=b3CDLhH74FCeSUPTOHzbalK9eb79PCH4NRsNL5rLPMM=;
        b=Edc74FsgmKXLOG0ZR6HQjwP9yftQcJizuP+WZlO9qUoJcFg7kg8qut22i1j8qOLwxu
         1bTWi4XRAeDnOIps51NKqboATk3FGa+C7fy6JsQF294KpLb6OnWD65NoEdJ3I/WBPjSn
         yxSHzTnH+39143fhysMVHRwrQs07TeMJggyX5/ee9kp/hdpGGmnVjoLhkYgEOedfuRbC
         z0mAyCTkgnWrTom0VpzZHujQGrk4bZJCZ9PW8o8Myq4A16un3K5CN9B3e/hqsTccu1UX
         e2k+HjkrdQn9/S9OtbrhfAVes0as0stPG/LASwHdlu5k45Ptgj2Zs23K8LiCfBn2dxjT
         8h5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=b3CDLhH74FCeSUPTOHzbalK9eb79PCH4NRsNL5rLPMM=;
        b=BqzlEl3TzsAN7JprViGiNuZstv2jeAfnzowYkT2H8bCBr/EkPVTo433+GZofCdYbLE
         QHt3cEqccnjnIlzmYl4gfNGB6uMpa31MwsqBc2zJoxavO75TCfNWTj4vC2adQ8wPFlPo
         GVDlQXx82s/fb86tFSoSljBCTn5ju7xIqxxFiOnf7RfxUdMRImll4xQnELTM4IA1UP3B
         vHeec8ZY+74by5O4y+AduJscxn5vh3P23SepICz9SsrvOLVWuS78ntyllmI2NO43hWWI
         ymgNUpA8Xf/5bRX2MNBvzCBiqxSmPJQiB8eVHU9FevKrLSUMhm6fx4C3e4tsbd8mxr0X
         77EQ==
X-Gm-Message-State: AO0yUKU/NBJSv1mdSsgcvhu9lbPZRYNU1Dir5j6zeMZ14qzzpGqycqTs
        sBJKtR83vDEYVSWrYii26yNHug==
X-Google-Smtp-Source: AK7set8rRNl5+WiwFKafSSJy9OG2By4H+IU1mLIA2v3InH/jpHuaUb65+tJa2NrGIG7RJ8JoJ4YQdw==
X-Received: by 2002:a05:600c:328f:b0:3dc:5674:66e6 with SMTP id t15-20020a05600c328f00b003dc567466e6mr7093228wmp.25.1675872253263;
        Wed, 08 Feb 2023 08:04:13 -0800 (PST)
Received: from krzk-bin.. ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id o18-20020a05600c2e1200b003dd1b00bd9asm2169890wmf.32.2023.02.08.08.04.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Feb 2023 08:04:12 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 1/2] ASoC: dt-bindings: maxim,max98090: Convert to dtschema
Date:   Wed,  8 Feb 2023 17:04:09 +0100
Message-Id: <20230208160410.371609-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the Maxim Integrated MAX98090/MAX98091 audio codecs bindings to
DT schema.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../devicetree/bindings/sound/max98090.txt    | 59 -------------
 .../bindings/sound/maxim,max98090.yaml        | 84 +++++++++++++++++++
 2 files changed, 84 insertions(+), 59 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/sound/max98090.txt
 create mode 100644 Documentation/devicetree/bindings/sound/maxim,max98090.yaml

diff --git a/Documentation/devicetree/bindings/sound/max98090.txt b/Documentation/devicetree/bindings/sound/max98090.txt
deleted file mode 100644
index 39d640294c62..000000000000
--- a/Documentation/devicetree/bindings/sound/max98090.txt
+++ /dev/null
@@ -1,59 +0,0 @@
-MAX98090 audio CODEC
-
-This device supports I2C only.
-
-Required properties:
-
-- compatible : "maxim,max98090" or "maxim,max98091".
-
-- reg : The I2C address of the device.
-
-- interrupts : The CODEC's interrupt output.
-
-Optional properties:
-
-- clocks: The phandle of the master clock to the CODEC
-
-- clock-names: Should be "mclk"
-
-- #sound-dai-cells : should be 0.
-
-- maxim,dmic-freq: Frequency at which to clock DMIC
-
-- maxim,micbias: Micbias voltage applies to the analog mic, valid voltages value are:
-	0 - 2.2v
-	1 - 2.55v
-	2 - 2.4v
-	3 - 2.8v
-
-Pins on the device (for linking into audio routes):
-
-  * MIC1
-  * MIC2
-  * DMICL
-  * DMICR
-  * IN1
-  * IN2
-  * IN3
-  * IN4
-  * IN5
-  * IN6
-  * IN12
-  * IN34
-  * IN56
-  * HPL
-  * HPR
-  * SPKL
-  * SPKR
-  * RCVL
-  * RCVR
-  * MICBIAS
-
-Example:
-
-audio-codec@10 {
-	compatible = "maxim,max98090";
-	reg = <0x10>;
-	interrupt-parent = <&gpio>;
-	interrupts = <TEGRA_GPIO(H, 4) IRQ_TYPE_LEVEL_HIGH>;
-};
diff --git a/Documentation/devicetree/bindings/sound/maxim,max98090.yaml b/Documentation/devicetree/bindings/sound/maxim,max98090.yaml
new file mode 100644
index 000000000000..65e4c516912f
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/maxim,max98090.yaml
@@ -0,0 +1,84 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/maxim,max98090.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Maxim Integrated MAX98090/MAX98091 audio codecs
+
+maintainers:
+  - Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
+
+description: |
+  Pins on the device (for linking into audio routes):
+  MIC1, MIC2, DMICL, DMICR, IN1, IN2, IN3, IN4, IN5, IN6, IN12, IN34, IN56,
+  HPL, HPR, SPKL, SPKR, RCVL, RCVR, MICBIAS
+
+allOf:
+  - $ref: dai-common.yaml#
+
+properties:
+  compatible:
+    enum:
+      - maxim,max98090
+      - maxim,max98091
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    items:
+      - description: master clock
+
+  clock-names:
+    items:
+      - const: mclk
+
+  interrupts:
+    maxItems: 1
+
+  maxim,dmic-freq:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    default: 2500000
+    description:
+      DMIC clock frequency
+
+  maxim,micbias:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum: [ 0, 1, 2, 3 ]
+    default: 3
+    description: |
+      Micbias voltage applied to the analog mic, valid voltages value are:
+        0 - 2.2v
+        1 - 2.55v
+        2 - 2.4v
+        3 - 2.8v
+
+  '#sound-dai-cells':
+    const: 0
+
+required:
+  - compatible
+  - reg
+  - interrupts
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
+        audio-codec@10 {
+            compatible = "maxim,max98090";
+            reg = <0x10>;
+            interrupt-parent = <&gpx3>;
+            interrupts = <2 IRQ_TYPE_EDGE_FALLING>;
+            clocks = <&i2s0 0>;
+            clock-names = "mclk";
+            #sound-dai-cells = <0>;
+        };
+    };
-- 
2.34.1

