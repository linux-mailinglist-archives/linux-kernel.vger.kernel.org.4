Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F39E72AFC5
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Jun 2023 02:33:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231752AbjFKAdQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Jun 2023 20:33:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjFKAdN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Jun 2023 20:33:13 -0400
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A953EE1;
        Sat, 10 Jun 2023 17:33:12 -0700 (PDT)
Received: from local
        by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
         (Exim 4.96)
        (envelope-from <daniel@makrotopia.org>)
        id 1q8913-0005BG-1W;
        Sun, 11 Jun 2023 00:33:09 +0000
Date:   Sun, 11 Jun 2023 01:32:27 +0100
From:   Daniel Golle <daniel@makrotopia.org>
To:     netdev@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Russell King <linux@armlinux.org.uk>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Mark Lee <Mark-MC.Lee@mediatek.com>,
        Sean Wang <sean.wang@mediatek.com>,
        John Crispin <john@phrozen.org>, Felix Fietkau <nbd@nbd.name>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sam Shih <Sam.Shih@mediatek.com>
Subject: [PATCH net-next 1/8] dt-bindings: net: mediatek,net: add mt7988-eth
 binding
Message-ID: <ZIUWGxUV8mxYns_l@makrotopia.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce DT bindings for the MT7988 SoC to mediatek,net.yaml.
The MT7988 SoC got 3 Ethernet MACs operating at a maximum of
10 Gigabit/sec supported by 2 packet processor engines for
offloading tasks.
The first MAC is hard-wired to a built-in switch which exposes
four 1000Base-T PHYs as user ports.
It also comes with built-in 2500Base-T PHY which can be used
with the 2nd GMAC.
The 2nd and 3rd GMAC can be connected to external PHYs or provide
SFP(+) cages attached via SGMII, 1000Base-X, 2500Base-X, USXGMII,
5GBase-KR or 10GBase-KR.

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
 .../devicetree/bindings/net/mediatek,net.yaml | 111 ++++++++++++++++++
 1 file changed, 111 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/mediatek,net.yaml b/Documentation/devicetree/bindings/net/mediatek,net.yaml
index acb2b2ac4fe1e..f08151a60084b 100644
--- a/Documentation/devicetree/bindings/net/mediatek,net.yaml
+++ b/Documentation/devicetree/bindings/net/mediatek,net.yaml
@@ -23,6 +23,7 @@ properties:
       - mediatek,mt7629-eth
       - mediatek,mt7981-eth
       - mediatek,mt7986-eth
+      - mediatek,mt7988-eth
       - ralink,rt5350-eth
 
   reg:
@@ -70,6 +71,22 @@ properties:
       A list of phandle to the syscon node that handles the SGMII setup which is required for
       those SoCs equipped with SGMII.
 
+  mediatek,toprgu:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description:
+      Phandle to the mediatek toprgu controller used to provide various clocks
+      and reset to the system.
+
+  mediatek,usxgmiisys:
+    $ref: /schemas/types.yaml#/definitions/phandle-array
+    minItems: 2
+    maxItems: 2
+    items:
+      maxItems: 1
+    description:
+      A list of phandle to the syscon node that handles the USXGMII setup which is required for
+      those SoCs equipped with USXGMII.
+
   mediatek,wed:
     $ref: /schemas/types.yaml#/definitions/phandle-array
     minItems: 2
@@ -84,6 +101,21 @@ properties:
     description:
       Phandle to the mediatek wed-pcie controller.
 
+  mediatek,xfi_pextp:
+    $ref: /schemas/types.yaml#/definitions/phandle-array
+    minItems: 2
+    maxItems: 2
+    items:
+      maxItems: 1
+    description:
+      A list of phandle to the syscon node that handles the XFI setup which is required for
+      those SoCs equipped with XFI.
+
+  mediatek,xfi_pll:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description:
+      Phandle to the XFI PLL unit.
+
   dma-coherent: true
 
   mdio-bus:
@@ -290,6 +322,85 @@ allOf:
           minItems: 2
           maxItems: 2
 
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: mediatek,mt7988-eth
+    then:
+      properties:
+        interrupts:
+          minItems: 4
+
+        clocks:
+          minItems: 34
+          maxItems: 34
+
+        clock-names:
+          items:
+            - const: crypto
+            - const: fe
+            - const: gp2
+            - const: gp1
+            - const: gp3
+            - const: ethwarp_wocpu2
+            - const: ethwarp_wocpu1
+            - const: ethwarp_wocpu0
+            - const: esw
+            - const: netsys0
+            - const: netsys1
+            - const: sgmii_tx250m
+            - const: sgmii_rx250m
+            - const: sgmii2_tx250m
+            - const: sgmii2_rx250m
+            - const: top_usxgmii0_sel
+            - const: top_usxgmii1_sel
+            - const: top_sgm0_sel
+            - const: top_sgm1_sel
+            - const: top_xfi_phy0_xtal_sel
+            - const: top_xfi_phy1_xtal_sel
+            - const: top_eth_gmii_sel
+            - const: top_eth_refck_50m_sel
+            - const: top_eth_sys_200m_sel
+            - const: top_eth_sys_sel
+            - const: top_eth_xgmii_sel
+            - const: top_eth_mii_sel
+            - const: top_netsys_sel
+            - const: top_netsys_500m_sel
+            - const: top_netsys_pao_2x_sel
+            - const: top_netsys_sync_250m_sel
+            - const: top_netsys_ppefb_250m_sel
+            - const: top_netsys_warp_sel
+            - const: wocpu1
+            - const: wocpu0
+            - const: xgp1
+            - const: xgp2
+            - const: xgp3
+
+        mediatek,sgmiisys:
+          minItems: 2
+          maxItems: 2
+
+        mediatek,usxgmiisys:
+          minItems: 2
+          maxItems: 2
+
+        mediatek,xfi_pextp:
+          minItems: 2
+          maxItems: 2
+
+        mediatek,xfi_pll:
+          minItems: 1
+          maxItems: 1
+
+        mediatek,infracfg:
+          minItems: 1
+          maxItems: 1
+
+        mediatek,toprgu:
+          minItems: 1
+          maxItems: 1
+
 patternProperties:
   "^mac@[0-1]$":
     type: object

base-commit: e431e712c83676a8a9cd3988b323e3ef994a8ff3
-- 
2.41.0

