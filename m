Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 935126FEE77
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 11:16:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235698AbjEKJQA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 05:16:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbjEKJP5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 05:15:57 -0400
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A60026A2;
        Thu, 11 May 2023 02:15:53 -0700 (PDT)
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
        by fd01.gateway.ufhost.com (Postfix) with ESMTP id A6B6482EB;
        Thu, 11 May 2023 17:15:51 +0800 (CST)
Received: from EXMBX168.cuchost.com (172.16.6.78) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Thu, 11 May
 2023 17:15:51 +0800
Received: from SD-Server.starfivetech.com (113.72.146.187) by
 EXMBX168.cuchost.com (172.16.6.78) with Microsoft SMTP Server (TLS) id
 15.0.1497.42; Thu, 11 May 2023 17:15:50 +0800
From:   Walker Chen <walker.chen@starfivetech.com>
To:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Claudiu Beznea <Claudiu.Beznea@microchip.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor.dooley@microchip.com>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        Walker Chen <walker.chen@starfivetech.com>
CC:     <alsa-devel@alsa-project.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>
Subject: [PATCH v4 1/3] ASoC: dt-bindings: Add TDM controller bindings for StarFive JH7110
Date:   Thu, 11 May 2023 17:15:47 +0800
Message-ID: <20230511091549.28003-2-walker.chen@starfivetech.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230511091549.28003-1-walker.chen@starfivetech.com>
References: <20230511091549.28003-1-walker.chen@starfivetech.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [113.72.146.187]
X-ClientProxiedBy: EXCAS062.cuchost.com (172.16.6.22) To EXMBX168.cuchost.com
 (172.16.6.78)
X-YovoleRuleAgent: yovoleflag
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add bindings for TDM driver which supports multi-channel audio playback
and capture on JH7110 platform.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Walker Chen <walker.chen@starfivetech.com>
---
 .../bindings/sound/starfive,jh7110-tdm.yaml   | 98 +++++++++++++++++++
 1 file changed, 98 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/starfive,jh7110-tdm.yaml

diff --git a/Documentation/devicetree/bindings/sound/starfive,jh7110-tdm.yaml b/Documentation/devicetree/bindings/sound/starfive,jh7110-tdm.yaml
new file mode 100644
index 000000000000..abb373fbfa26
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/starfive,jh7110-tdm.yaml
@@ -0,0 +1,98 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/starfive,jh7110-tdm.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: StarFive JH7110 TDM Controller
+
+description: |
+  The TDM Controller is a Time Division Multiplexed audio interface
+  integrated in StarFive JH7110 SoC, allowing up to 8 channels of
+  audio over a serial interface. The TDM controller can operate both
+  in master and slave mode.
+
+maintainers:
+  - Walker Chen <walker.chen@starfivetech.com>
+
+allOf:
+  - $ref: dai-common.yaml#
+
+properties:
+  compatible:
+    enum:
+      - starfive,jh7110-tdm
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    items:
+      - description: TDM AHB Clock
+      - description: TDM APB Clock
+      - description: TDM Internal Clock
+      - description: TDM Clock
+      - description: Inner MCLK
+      - description: TDM External Clock
+
+  clock-names:
+    items:
+      - const: tdm_ahb
+      - const: tdm_apb
+      - const: tdm_internal
+      - const: tdm
+      - const: mclk_inner
+      - const: tdm_ext
+
+  resets:
+    items:
+      - description: tdm ahb reset line
+      - description: tdm apb reset line
+      - description: tdm core reset line
+
+  dmas:
+    items:
+      - description: RX DMA Channel
+      - description: TX DMA Channel
+
+  dma-names:
+    items:
+      - const: rx
+      - const: tx
+
+  "#sound-dai-cells":
+    const: 0
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - clock-names
+  - resets
+  - dmas
+  - dma-names
+  - "#sound-dai-cells"
+
+additionalProperties: false
+
+examples:
+  - |
+    tdm@10090000 {
+        compatible = "starfive,jh7110-tdm";
+        reg = <0x10090000 0x1000>;
+        clocks = <&syscrg 184>,
+                 <&syscrg 185>,
+                 <&syscrg 186>,
+                 <&syscrg 187>,
+                 <&syscrg 17>,
+                 <&tdm_ext>;
+        clock-names = "tdm_ahb", "tdm_apb",
+                      "tdm_internal", "tdm",
+                      "mclk_inner", "tdm_ext";
+        resets = <&syscrg 105>,
+                 <&syscrg 107>,
+                 <&syscrg 106>;
+        dmas = <&dma 20>, <&dma 21>;
+        dma-names = "rx","tx";
+        #sound-dai-cells = <0>;
+    };
-- 
2.17.1

