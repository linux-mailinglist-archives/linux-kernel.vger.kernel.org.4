Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA18062F220
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 11:07:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241774AbiKRKHH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 05:07:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241442AbiKRKGx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 05:06:53 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9177F8FB19;
        Fri, 18 Nov 2022 02:06:50 -0800 (PST)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 91E446602AA5;
        Fri, 18 Nov 2022 10:06:48 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1668766009;
        bh=wPHPCMj7i9crbfMFAZjYN9WOVm5VI57WehML5RuHHc0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OYfuN31W0XwJvdc1KoLUb+YljXaVIfui1PA7A/tGgliaJRcB+ZuRjkkGytNmeMBRw
         ptXG85699/bAYmu7oOC+LqxIGNBQ4kpGaFKGaZwIqqCRcbaPSYN2u6earinQy1XkXw
         EExQd1VA69ZDpMxRixic+qUkKUIyN0Pyr2FQYDBlqCh7g7fpVkgUubooJtTno4v/vw
         lCY2nUbFFaIFzJv4JDuwJfT8FGcSzvhTTIdbLj7yohXBtfHd3MyLKm8naQnN2rgogN
         KDiCeb4UlV71s5CeZbR8vUW7Q6NpUN3BXuxpcV+sS0tISAK3ohuNNQUssWVvJBDkNE
         dkJgrO7jrc3Fg==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     tglx@linutronix.de
Cc:     maz@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com,
        youlin.pei@mediatek.com, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Subject: [PATCH v1 1/4] dt-bindings: interrupt-controller: mediatek,cirq: Migrate to dt schema
Date:   Fri, 18 Nov 2022 11:06:36 +0100
Message-Id: <20221118100639.33704-2-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221118100639.33704-1-angelogioacchino.delregno@collabora.com>
References: <20221118100639.33704-1-angelogioacchino.delregno@collabora.com>
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

Migrate mediatek,cirq.txt to dt schema as mediatek,mtk-cirq.yaml.
While at it, I've also fixed some typos that were present in the
original txt binding, as it was suggesting that the compatible
string would have "mediatek,cirq" as compatible but, in reality,
that's supposed to be "mediatek,mtk-cirq" instead.

Little rewording on property descriptions also happened for
them to be more concise.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 .../interrupt-controller/mediatek,cirq.txt    | 33 ---------
 .../mediatek,mtk-cirq.yaml                    | 70 +++++++++++++++++++
 2 files changed, 70 insertions(+), 33 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/interrupt-controller/mediatek,cirq.txt
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/mediatek,mtk-cirq.yaml

diff --git a/Documentation/devicetree/bindings/interrupt-controller/mediatek,cirq.txt b/Documentation/devicetree/bindings/interrupt-controller/mediatek,cirq.txt
deleted file mode 100644
index 5865f4f2c69d..000000000000
--- a/Documentation/devicetree/bindings/interrupt-controller/mediatek,cirq.txt
+++ /dev/null
@@ -1,33 +0,0 @@
-* Mediatek 27xx cirq
-
-In Mediatek SOCs, the CIRQ is a low power interrupt controller designed to
-work outside MCUSYS which comprises with Cortex-Ax cores,CCI and GIC.
-The external interrupts (outside MCUSYS) will feed through CIRQ and connect
-to GIC in MCUSYS. When CIRQ is enabled, it will record the edge-sensitive
-interrupts and generate a pulse signal to parent interrupt controller when
-flush command is executed. With CIRQ, MCUSYS can be completely turned off
-to improve the system power consumption without losing interrupts.
-
-Required properties:
-- compatible: should be one of
-  - "mediatek,mt2701-cirq" for mt2701 CIRQ
-  - "mediatek,mt8135-cirq" for mt8135 CIRQ
-  - "mediatek,mt8173-cirq" for mt8173 CIRQ
-  and "mediatek,cirq" as a fallback.
-- interrupt-controller : Identifies the node as an interrupt controller.
-- #interrupt-cells : Use the same format as specified by GIC in arm,gic.txt.
-- reg: Physical base address of the cirq registers and length of memory
-  mapped region.
-- mediatek,ext-irq-range: Identifies external irq number range in different
-  SOCs.
-
-Example:
-	cirq: interrupt-controller@10204000 {
-		compatible = "mediatek,mt2701-cirq",
-			     "mediatek,mtk-cirq";
-		interrupt-controller;
-		#interrupt-cells = <3>;
-		interrupt-parent = <&sysirq>;
-		reg = <0 0x10204000 0 0x400>;
-		mediatek,ext-irq-start = <32 200>;
-	};
diff --git a/Documentation/devicetree/bindings/interrupt-controller/mediatek,mtk-cirq.yaml b/Documentation/devicetree/bindings/interrupt-controller/mediatek,mtk-cirq.yaml
new file mode 100644
index 000000000000..21e709169907
--- /dev/null
+++ b/Documentation/devicetree/bindings/interrupt-controller/mediatek,mtk-cirq.yaml
@@ -0,0 +1,70 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/interrupt-controller/mediatek,mtk-cirq.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: MediaTek System Interrupt Controller
+
+maintainers:
+  - Youlin Pei <youlin.pei@mediatek.com>
+
+description:
+  In MediaTek SoCs, the CIRQ is a low power interrupt controller designed to
+  work outside of MCUSYS which comprises with Cortex-Ax cores, CCI and GIC.
+  The external interrupts (outside MCUSYS) will feed through CIRQ and connect
+  to GIC in MCUSYS. When CIRQ is enabled, it will record the edge-sensitive
+  interrupts and generate a pulse signal to parent interrupt controller when
+  flush command is executed. With CIRQ, MCUSYS can be completely turned off
+  to improve the system power consumption without losing interrupts.
+
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - mediatek,mt2701-cirq
+          - mediatek,mt8135-cirq
+          - mediatek,mt8173-cirq
+      - const: mediatek,mtk-cirq
+
+  reg:
+    maxItems: 1
+    description: Address and size of the CIRQ registers
+
+  '#interrupt-cells':
+    const: 3
+
+  interrupt-controller: true
+
+  mediatek,ext-irq-range:
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+    maxItems: 1
+    items:
+      items:
+        - description: First CIRQ interrupt
+        - description: Last CIRQ interrupt
+    description:
+      Identifies the range of external interrupts in different SoCs
+
+required:
+  - compatible
+  - reg
+  - '#interrupt-cells'
+  - interrupt-controller
+  - mediatek,ext-irq-range
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    cirq: interrupt-controller@10204000 {
+        compatible = "mediatek,mt2701-cirq", "mediatek,mtk-cirq";
+        reg = <0x10204000 0x400>;
+        #interrupt-cells = <3>;
+        interrupt-controller;
+        interrupt-parent = <&sysirq>;
+        mediatek,ext-irq-range = <32 200>;
+    };
-- 
2.38.1

