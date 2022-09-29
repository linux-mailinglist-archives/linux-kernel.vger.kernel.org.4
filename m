Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B42115EF578
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 14:29:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235575AbiI2M3a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 08:29:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234300AbiI2M3V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 08:29:21 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A5CE14F8DA;
        Thu, 29 Sep 2022 05:29:20 -0700 (PDT)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 6248266022B3;
        Thu, 29 Sep 2022 13:29:18 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1664454558;
        bh=tWLISRDl8sSojAqI5mblzCEFbyqsAUeF/F2kOkv3Nnw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BSI8FxOjAEwgx4DMqNZoFeLylCj2W98/WMufWQTutMgpUu9dSnT317uvizQhlhIzN
         ha76+VfOD8avSFtjKWo6VVzJDa1BUGHc5Cgv7e+KV/UuW12b2f74KB5Y/MHHQxmPqE
         0y7lQserTDS4XD5iY7ScG/94BkvedBuQq4Ttpma6dkgXAV8we4gwQiVokEKOzE0hZO
         4tQRhfV68yA6bXtxeK7XsryUzjuqBs5ic3PGpCs3PvKhWRu5IZkubVVAW342oKWHv4
         A5jSjDlEhlY9MSv7SevCP6LIdd0qZuYkZdJPVn6t6/PndZz0AfZFo/aa9NsHtGv4Sj
         ID4vsRbNHEy2g==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     daniel.lezcano@linaro.org
Cc:     tglx@linutronix.de, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Subject: [PATCH 2/2] dt-bindings: timer: mediatek: Convert to json-schema
Date:   Thu, 29 Sep 2022 14:29:01 +0200
Message-Id: <20220929122901.614315-3-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220929122901.614315-1-angelogioacchino.delregno@collabora.com>
References: <20220929122901.614315-1-angelogioacchino.delregno@collabora.com>
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

Convert the MediaTek SoC timer txt binding to json-schema.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 .../bindings/timer/mediatek,mtk-timer.txt     | 47 ----------
 .../bindings/timer/mediatek,timer.yaml        | 86 +++++++++++++++++++
 2 files changed, 86 insertions(+), 47 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/timer/mediatek,mtk-timer.txt
 create mode 100644 Documentation/devicetree/bindings/timer/mediatek,timer.yaml

diff --git a/Documentation/devicetree/bindings/timer/mediatek,mtk-timer.txt b/Documentation/devicetree/bindings/timer/mediatek,mtk-timer.txt
deleted file mode 100644
index 8bbb6e94508b..000000000000
--- a/Documentation/devicetree/bindings/timer/mediatek,mtk-timer.txt
+++ /dev/null
@@ -1,47 +0,0 @@
-MediaTek Timers
----------------
-
-MediaTek SoCs have different timers on different platforms,
-- CPUX (ARM/ARM64 System Timer)
-- GPT (General Purpose Timer)
-- SYST (System Timer)
-
-The proper timer will be selected automatically by driver.
-
-Required properties:
-- compatible should contain:
-	For those SoCs that use GPT
-	* "mediatek,mt2701-timer" for MT2701 compatible timers (GPT)
-	* "mediatek,mt6580-timer" for MT6580 compatible timers (GPT)
-	* "mediatek,mt6582-timer" for MT6582 compatible timers (GPT)
-	* "mediatek,mt6589-timer" for MT6589 compatible timers (GPT)
-	* "mediatek,mt7623-timer" for MT7623 compatible timers (GPT)
-	* "mediatek,mt8127-timer" for MT8127 compatible timers (GPT)
-	* "mediatek,mt8135-timer" for MT8135 compatible timers (GPT)
-	* "mediatek,mt8173-timer" for MT8173 compatible timers (GPT)
-	* "mediatek,mt8516-timer" for MT8516 compatible timers (GPT)
-	* "mediatek,mt6577-timer" for MT6577 and all above compatible timers (GPT)
-
-	For those SoCs that use SYST
-	* "mediatek,mt8183-timer" for MT8183 compatible timers (SYST)
-	* "mediatek,mt8186-timer" for MT8186 compatible timers (SYST)
-	* "mediatek,mt8188-timer" for MT8188 compatible timers (SYST)
-	* "mediatek,mt8192-timer" for MT8192 compatible timers (SYST)
-	* "mediatek,mt8195-timer" for MT8195 compatible timers (SYST)
-	* "mediatek,mt7629-timer" for MT7629 compatible timers (SYST)
-	* "mediatek,mt6765-timer" for MT6765 and all above compatible timers (SYST)
-
-	For those SoCs that use CPUX
-	* "mediatek,mt6795-systimer" for MT6795 compatible timers (CPUX)
-
-- reg: Should contain location and length for timer register.
-- clocks: Should contain system clock.
-
-Examples:
-
-	timer@10008000 {
-		compatible = "mediatek,mt6577-timer";
-		reg = <0x10008000 0x80>;
-		interrupts = <GIC_SPI 113 IRQ_TYPE_LEVEL_LOW>;
-		clocks = <&system_clk>;
-	};
diff --git a/Documentation/devicetree/bindings/timer/mediatek,timer.yaml b/Documentation/devicetree/bindings/timer/mediatek,timer.yaml
new file mode 100644
index 000000000000..a5ea4095852e
--- /dev/null
+++ b/Documentation/devicetree/bindings/timer/mediatek,timer.yaml
@@ -0,0 +1,86 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/timer/mediatek,timer.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+
+title: MediaTek SoC timers
+
+maintainers:
+  - Matthias Brugger <matthias.bgg@gmail.com>
+
+description:
+  MediaTek SoCs have different timers on different platforms,
+  CPUX (ARM/ARM64 System Timer), GPT (General Purpose Timer)
+  and SYST (System Timer).
+
+properties:
+  compatible:
+    oneOf:
+      - items:
+          - enum:
+              - mediatek,mt6577-timer
+              - mediatek,mt6765-timer
+              - mediatek,mt6795-systimer
+      # GPT Timers
+      - items:
+          - enum:
+              - mediatek,mt2701-timer
+              - mediatek,mt6580-timer
+              - mediatek,mt6582-timer
+              - mediatek,mt6589-timer
+              - mediatek,mt7623-timer
+              - mediatek,mt8127-timer
+              - mediatek,mt8135-timer
+              - mediatek,mt8173-timer
+              - mediatek,mt8516-timer
+          - const: mediatek,mt6577-timer
+      # SYST Timers
+      - items:
+          - enum:
+              - mediatek,mt7629-timer
+              - mediatek,mt8183-timer
+              - mediatek,mt8186-timer
+              - mediatek,mt8188-timer
+              - mediatek,mt8192-timer
+              - mediatek,mt8195-timer
+          - const: mediatek,mt6765-timer
+      # CPUX Timers
+      - items:
+          - const: mediatek,mt6795-systimer
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    minItems: 1
+    items:
+      - description: Timer clock
+      - description: RTC or bus clock
+
+  clock-names:
+    minItems: 1
+    maxItems: 2
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    timer@10008000 {
+      compatible = "mediatek,mt6577-timer";
+      reg = <0x10008000 0x80>;
+      interrupts = <GIC_SPI 113 IRQ_TYPE_LEVEL_LOW>;
+      clocks = <&system_clk>;
+    };
-- 
2.37.2

