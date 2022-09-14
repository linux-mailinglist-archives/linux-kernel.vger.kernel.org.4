Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C446C5B862A
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 12:21:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229678AbiINKVZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 06:21:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229717AbiINKVQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 06:21:16 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6D691F62E;
        Wed, 14 Sep 2022 03:21:14 -0700 (PDT)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 1EA4A6601FF1;
        Wed, 14 Sep 2022 11:21:13 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1663150873;
        bh=P5j5gDWE9s2Ntl2W8jsDy0++Zt/hGRLwgx/zymqCOEE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QzRqr6E0fd5qWf7F6Fyks5wrokcjBvAuwT+piZsXCFs0bBxGEb4V+UXlIjZv98Svj
         WngpDkoNmMHkEhqGyp2dDSgf7isMZVaR1af+UDPfxaNlKuD/G+YkNpGkmix2mhkeog
         euO0KFj3347nB8RSsKYm4E+/MDzpHwp7An3cMkYh4IeL/chEI/uJngZlce5uDSRYur
         4aJy7hSauvhZB8BmtDojJnLgH8jWraWbSLXq/TY9GJmy3qJ7qBnPfwB9PqAoBev4Es
         70kxa8BARNDrsWk8WIxlAr1/p6kvMLuCH/6+lqF8f4CJwlo1HQKw1+xa/Ehp471hkd
         xzYhjviK2pdaw==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     krzysztof.kozlowski+dt@linaro.org
Cc:     dmitry.torokhov@gmail.com, robh+dt@kernel.org,
        matthias.bgg@gmail.com, chen.zhong@mediatek.com,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Subject: [PATCH 1/2] dt-bindings: input: Convert mtk-pmic-keys to DT schema
Date:   Wed, 14 Sep 2022 12:20:58 +0200
Message-Id: <20220914102059.41757-2-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220914102059.41757-1-angelogioacchino.delregno@collabora.com>
References: <20220914102059.41757-1-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the mtk-pmic-keys to DT schema format.

The old binding was missing documentation for key press/release
interrupts, even though it was supported in hardware and driver,
so support for the same was added during the conversion.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 .../bindings/input/mediatek,pmic-keys.yaml    | 117 ++++++++++++++++++
 .../bindings/input/mtk-pmic-keys.txt          |  46 -------
 2 files changed, 117 insertions(+), 46 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/input/mediatek,pmic-keys.yaml
 delete mode 100644 Documentation/devicetree/bindings/input/mtk-pmic-keys.txt

diff --git a/Documentation/devicetree/bindings/input/mediatek,pmic-keys.yaml b/Documentation/devicetree/bindings/input/mediatek,pmic-keys.yaml
new file mode 100644
index 000000000000..e33fdca50b16
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/mediatek,pmic-keys.yaml
@@ -0,0 +1,117 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/input/mediatek,pmic-keys.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: MediaTek PMIC Keys
+
+maintainers:
+  - Chen Zhong <chen.zhong@mediatek.com>
+
+allOf:
+  - $ref: input.yaml#
+
+description: |
+  There are two key functions provided by MT6397, MT6323 and other MediaTek
+  PMICs: pwrkey and homekey.
+  The key functions are defined as the subnode of the function node provided
+  by the PMIC that is defined as a Multi-Function Device (MFD).
+
+  For MediaTek MT6323/MT6397 PMIC bindings see
+  Documentation/devicetree/bindings/mfd/mt6397.txt
+
+properties:
+  compatible:
+    enum:
+      - mediatek,mt6323-keys
+      - mediatek,mt6358-keys
+      - mediatek,mt6397-keys
+
+  power-off-time-sec: true
+
+  mediatek,long-press-mode:
+    description: |
+      Key long-press force shutdown setting
+      0 - disabled
+      1 - pwrkey
+      2 - pwrkey+homekey
+    $ref: /schemas/types.yaml#/definitions/uint32
+    default: 0
+    maximum: 2
+
+patternProperties:
+  "^((power|home)|(key-[a-z0-9-]+|[a-z0-9-]+-key))$":
+    $ref: input.yaml#
+
+    properties:
+      interrupts:
+        minItems: 1
+        items:
+          - description: Key press interrupt
+          - description: Key release interrupt
+
+      interrupt-names: true
+
+      linux-keycodes:
+        maxItems: 1
+
+      wakeup-source: true
+
+    required:
+      - linux,keycodes
+
+    if:
+      properties:
+        interrupt-names:
+          contains:
+            const: powerkey
+    then:
+      properties:
+        interrupt-names:
+          minItems: 1
+          items:
+            - const: powerkey
+            - const: powerkey_r
+    else:
+      properties:
+        interrupt-names:
+          minItems: 1
+          items:
+            - const: homekey
+            - const: homekey_r
+
+    unevaluatedProperties: false
+
+required:
+  - compatible
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/input/input.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    pmic {
+        compatible = "mediatek,mt6397";
+
+        keys {
+          compatible = "mediatek,mt6397-keys";
+          mediatek,long-press-mode = <1>;
+          power-off-time-sec = <0>;
+
+          key-power {
+            interrupts = <GIC_SPI 75 IRQ_TYPE_EDGE_FALLING>;
+            interrupt-names = "powerkey";
+            linux,keycodes = <KEY_POWER>;
+            wakeup-source;
+          };
+
+          key-home {
+            interrupts = <GIC_SPI 76 IRQ_TYPE_EDGE_FALLING>, <GIC_SPI 76 IRQ_TYPE_EDGE_FALLING>;
+            interrupt-names = "homekey", "homekey_r";
+            linux,keycodes = <KEY_VOLUMEDOWN>;
+          };
+        };
+    };
diff --git a/Documentation/devicetree/bindings/input/mtk-pmic-keys.txt b/Documentation/devicetree/bindings/input/mtk-pmic-keys.txt
deleted file mode 100644
index 9d00f2a8e13a..000000000000
--- a/Documentation/devicetree/bindings/input/mtk-pmic-keys.txt
+++ /dev/null
@@ -1,46 +0,0 @@
-MediaTek MT6397/MT6323 PMIC Keys Device Driver
-
-There are two key functions provided by MT6397/MT6323 PMIC, pwrkey
-and homekey. The key functions are defined as the subnode of the function
-node provided by MT6397/MT6323 PMIC that is being defined as one kind
-of Muti-Function Device (MFD)
-
-For MT6397/MT6323 MFD bindings see:
-Documentation/devicetree/bindings/mfd/mt6397.txt
-
-Required properties:
-- compatible: Should be one of:
-	- "mediatek,mt6397-keys"
-	- "mediatek,mt6323-keys"
-	- "mediatek,mt6358-keys"
-- linux,keycodes: See Documentation/devicetree/bindings/input/input.yaml
-
-Optional Properties:
-- wakeup-source: See Documentation/devicetree/bindings/power/wakeup-source.txt
-- mediatek,long-press-mode: Long press key shutdown setting, 1 for
-	pwrkey only, 2 for pwrkey/homekey together, others for disabled.
-- power-off-time-sec: See Documentation/devicetree/bindings/input/input.yaml
-
-Example:
-
-	pmic: mt6397 {
-		compatible = "mediatek,mt6397";
-
-		...
-
-		mt6397keys: mt6397keys {
-			compatible = "mediatek,mt6397-keys";
-			mediatek,long-press-mode = <1>;
-			power-off-time-sec = <0>;
-
-			power {
-				linux,keycodes = <116>;
-				wakeup-source;
-			};
-
-			home {
-				linux,keycodes = <114>;
-			};
-		};
-
-	};
-- 
2.37.2

