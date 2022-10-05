Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E786F5F53D5
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 13:41:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230415AbiJELlI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 07:41:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230122AbiJELkp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 07:40:45 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D554F7A50C;
        Wed,  5 Oct 2022 04:38:00 -0700 (PDT)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 9284366022F8;
        Wed,  5 Oct 2022 12:35:37 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1664969738;
        bh=3t7BDTuD27Hzn+PWYye7KW5kxqz4FnjQqvH/Ul9Or9s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=O9g3zdbMO4lO+2i/SRgQYg7EaM8oExhDfmVqCi05WaC39n4baw4xEPO2T9urtMlOE
         CIyIepD4V2WE+34PghHaO+NFOWaPlb6vZZ3R5sCFSMAbtLn1zxbfizxi4JmNg5RLuH
         Y1WxjhZ5p2NW3Zg3IhuEb21R8vwSnySxwdjbhmfrthzx1m4WahnDqok2crWyPIAvud
         qXhFQjL5GzZBruECTEIIahRCDisSQbkWn/tEIl3on0m/A0FkS9KI9Yu1kRkDEzSzOP
         yAhuuJ6MtHhRJoJQmfdD6x6pARRldLJdspWdQ/JmaEqg5/Pz4Ml34l6LM5gm7q+SZ+
         SwXoMSmNrrOSQ==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     wim@linux-watchdog.org
Cc:     linux@roeck-us.net, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com,
        allen-kh.cheng@mediatek.com, seiya.wang@mediatek.com,
        angelogioacchino.delregno@collabora.com, tinghan.shen@mediatek.com,
        linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/5] dt-bindings: watchdog: mediatek: Convert mtk-wdt to json-schema
Date:   Wed,  5 Oct 2022 13:35:15 +0200
Message-Id: <20221005113517.70628-4-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20221005113517.70628-1-angelogioacchino.delregno@collabora.com>
References: <20221005113517.70628-1-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the MediaTek watchdog bindings to schema.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 .../bindings/watchdog/mediatek,mtk-wdt.yaml   | 80 +++++++++++++++++++
 .../devicetree/bindings/watchdog/mtk-wdt.txt  | 42 ----------
 2 files changed, 80 insertions(+), 42 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/watchdog/mediatek,mtk-wdt.yaml
 delete mode 100644 Documentation/devicetree/bindings/watchdog/mtk-wdt.txt

diff --git a/Documentation/devicetree/bindings/watchdog/mediatek,mtk-wdt.yaml b/Documentation/devicetree/bindings/watchdog/mediatek,mtk-wdt.yaml
new file mode 100644
index 000000000000..f43b5af92d40
--- /dev/null
+++ b/Documentation/devicetree/bindings/watchdog/mediatek,mtk-wdt.yaml
@@ -0,0 +1,80 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/watchdog/mediatek,mtk-wdt.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: MediaTek SoCs Watchdog timer
+
+maintainers:
+  - Matthias Brugger <matthias.bgg@gmail.com>
+
+description:
+  The watchdog supports a pre-timeout interrupt that fires
+  timeout-sec/2 before the expiry.
+
+allOf:
+  - $ref: watchdog.yaml#
+
+properties:
+  compatible:
+    oneOf:
+      - items:
+          - enum:
+              - mediatek,mt2712-wdt
+              - mediatek,mt6589-wdt
+              - mediatek,mt7986-wdt
+              - mediatek,mt8183-wdt
+              - mediatek,mt8186-wdt
+              - mediatek,mt8192-wdt
+              - mediatek,mt8195-wdt
+      - items:
+          - enum:
+              - mediatek,mt2701-wdt
+              - mediatek,mt6582-wdt
+              - mediatek,mt6797-wdt
+              - mediatek,mt7622-wdt
+              - mediatek,mt7623-wdt
+              - mediatek,mt7629-wdt
+              - mediatek,mt8516-wdt
+          - const: mediatek,mt6589-wdt
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    items:
+      - description: Watchdog pre-timeout (bark) interrupt
+
+  mediatek,disable-extrst:
+    description: Disable sending output reset signal
+    type: boolean
+
+  timeout-sec: true
+
+  '#reset-cells':
+    const: 1
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    soc {
+        #address-cells = <2>;
+        #size-cells = <2>;
+
+        watchdog: watchdog@10007000 {
+            compatible = "mediatek,mt8183-wdt";
+            reg = <0 0x10007000 0 0x100>;
+            interrupts = <GIC_SPI 139 IRQ_TYPE_LEVEL_LOW>;
+            mediatek,disable-extrst;
+            timeout-sec = <10>;
+            #reset-cells = <1>;
+        };
+    };
diff --git a/Documentation/devicetree/bindings/watchdog/mtk-wdt.txt b/Documentation/devicetree/bindings/watchdog/mtk-wdt.txt
deleted file mode 100644
index 762c62e428ef..000000000000
--- a/Documentation/devicetree/bindings/watchdog/mtk-wdt.txt
+++ /dev/null
@@ -1,42 +0,0 @@
-Mediatek SoCs Watchdog timer
-
-The watchdog supports a pre-timeout interrupt that fires timeout-sec/2
-before the expiry.
-
-Required properties:
-
-- compatible should contain:
-	"mediatek,mt2701-wdt", "mediatek,mt6589-wdt": for MT2701
-	"mediatek,mt2712-wdt": for MT2712
-	"mediatek,mt6582-wdt", "mediatek,mt6589-wdt": for MT6582
-	"mediatek,mt6589-wdt": for MT6589
-	"mediatek,mt6797-wdt", "mediatek,mt6589-wdt": for MT6797
-	"mediatek,mt7622-wdt", "mediatek,mt6589-wdt": for MT7622
-	"mediatek,mt7623-wdt", "mediatek,mt6589-wdt": for MT7623
-	"mediatek,mt7629-wdt", "mediatek,mt6589-wdt": for MT7629
-	"mediatek,mt7986-wdt", "mediatek,mt6589-wdt": for MT7986
-	"mediatek,mt8183-wdt": for MT8183
-	"mediatek,mt8186-wdt", "mediatek,mt6589-wdt": for MT8186
-	"mediatek,mt8516-wdt", "mediatek,mt6589-wdt": for MT8516
-	"mediatek,mt8192-wdt": for MT8192
-	"mediatek,mt8195-wdt", "mediatek,mt6589-wdt": for MT8195
-
-- reg : Specifies base physical address and size of the registers.
-
-Optional properties:
-- mediatek,disable-extrst: disable send output reset signal
-- interrupts: Watchdog pre-timeout (bark) interrupt.
-- timeout-sec: contains the watchdog timeout in seconds.
-- #reset-cells: Should be 1.
-
-Example:
-
-watchdog: watchdog@10007000 {
-	compatible = "mediatek,mt8183-wdt",
-		     "mediatek,mt6589-wdt";
-	mediatek,disable-extrst;
-	reg = <0 0x10007000 0 0x100>;
-	interrupts = <GIC_SPI 139 IRQ_TYPE_NONE>;
-	timeout-sec = <10>;
-	#reset-cells = <1>;
-};
-- 
2.37.2

