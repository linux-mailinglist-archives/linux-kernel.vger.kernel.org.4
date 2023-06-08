Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87B687284CE
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 18:23:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234329AbjFHQW6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 12:22:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233770AbjFHQWq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 12:22:46 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C207270F;
        Thu,  8 Jun 2023 09:22:43 -0700 (PDT)
Received: from jupiter.universe (dyndsl-091-248-189-092.ewe-ip-backbone.de [91.248.189.92])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id E351A6606F23;
        Thu,  8 Jun 2023 17:22:41 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1686241362;
        bh=FonCoURcO7g6os0P5Lry6rxjs+kuIZse14bTr8E1Exk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=F5KlnpTuQFJ4my18FW/nI8RQGW0+E5iTneKQNFOHw2yiomPyhhch+cGXVduah2w1a
         vaeAa/eGnc3YPyU9rq/ZQClj2huNrYHURfv5U0QwCXH9YlfSridso03knEp6VaBMum
         eQ88TdD3kLsfwEGu0ex2CaH3t5ih6lnU31tWlgPD6KtGSDivxLGDjX/TdZwOw4JduM
         VlhgZ8fAyLvNpE145fOttcGApiOeWBec+ewjpE1E5iV49IoDx0SnAY87cbotYd7zVs
         ZcVeo8dnGntbn682aPm4fKiPvA0T6eosqF9S7+K6ezF8o7L/YdnxskDMJt3cB9/8HL
         0FC70aBvf9HJQ==
Received: by jupiter.universe (Postfix, from userid 1000)
        id CC1714807E1; Thu,  8 Jun 2023 18:22:39 +0200 (CEST)
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Serge Semin <fancer.lancer@gmail.com>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        linux-ide@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        kernel@collabora.com
Subject: [PATCH v3 2/5] dt-bindings: ata: dwc-ahci: add Rockchip RK3588
Date:   Thu,  8 Jun 2023 18:22:35 +0200
Message-Id: <20230608162238.50078-3-sebastian.reichel@collabora.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230608162238.50078-1-sebastian.reichel@collabora.com>
References: <20230608162238.50078-1-sebastian.reichel@collabora.com>
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

This adds Rockchip RK3588 AHCI binding. In order to narrow down the
allowed clocks without bloating the generic binding, the description
of Rockchip's AHCI controllers has been moved to its own file.

Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 .../bindings/ata/rockchip,dwc-ahci.yaml       | 114 ++++++++++++++++++
 .../bindings/ata/snps,dwc-ahci.yaml           |  17 ++-
 2 files changed, 125 insertions(+), 6 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/ata/rockchip,dwc-ahci.yaml

diff --git a/Documentation/devicetree/bindings/ata/rockchip,dwc-ahci.yaml b/Documentation/devicetree/bindings/ata/rockchip,dwc-ahci.yaml
new file mode 100644
index 000000000000..86da9bd594a7
--- /dev/null
+++ b/Documentation/devicetree/bindings/ata/rockchip,dwc-ahci.yaml
@@ -0,0 +1,114 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/ata/rockchip,dwc-ahci.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Synopsys DWC AHCI SATA controller for Rockchip devices
+
+maintainers:
+  - Serge Semin <fancer.lancer@gmail.com>
+
+description:
+  This document defines device tree bindings for the Synopsys DWC
+  implementation of the AHCI SATA controller found in Rockchip
+  devices.
+
+select:
+  properties:
+    compatible:
+      contains:
+        enum:
+          - rockchip,rk3568-dwc-ahci
+          - rockchip,rk3588-dwc-ahci
+  required:
+    - compatible
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - rockchip,rk3568-dwc-ahci
+          - rockchip,rk3588-dwc-ahci
+      - const: snps,dwc-ahci
+
+  ports-implemented:
+    const: 1
+
+patternProperties:
+  "^sata-port@[0-9a-e]$":
+    $ref: /schemas/ata/snps,dwc-ahci-common.yaml#/$defs/dwc-ahci-port
+
+    unevaluatedProperties: false
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+  - clock-names
+  - ports-implemented
+
+allOf:
+  - $ref: snps,dwc-ahci-common.yaml#
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - rockchip,rk3588-dwc-ahci
+    then:
+      properties:
+        clock-names:
+          items:
+            - const: sata
+            - const: pmalive
+            - const: rxoob
+            - const: ref
+            - const: asic
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - rockchip,rk3568-dwc-ahci
+    then:
+      properties:
+        clock-names:
+          items:
+            - const: sata
+            - const: pmalive
+            - const: rxoob
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/rockchip,rk3588-cru.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/ata/ahci.h>
+    #include <dt-bindings/phy/phy.h>
+
+    sata@fe210000 {
+      compatible = "rockchip,rk3588-dwc-ahci", "snps,dwc-ahci";
+      reg = <0xfe210000 0x1000>;
+      clocks = <&cru ACLK_SATA0>, <&cru CLK_PMALIVE0>,
+               <&cru CLK_RXOOB0>, <&cru CLK_PIPEPHY0_REF>,
+               <&cru CLK_PIPEPHY0_PIPE_ASIC_G>;
+      clock-names = "sata", "pmalive", "rxoob", "ref", "asic";
+      interrupts = <GIC_SPI 273 IRQ_TYPE_LEVEL_HIGH 0>;
+      ports-implemented = <0x1>;
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      sata-port@0 {
+        reg = <0>;
+        hba-port-cap = <HBA_PORT_FBSCP>;
+        phys = <&combphy0_ps PHY_TYPE_SATA>;
+        phy-names = "sata-phy";
+        snps,rx-ts-max = <32>;
+        snps,tx-ts-max = <32>;
+      };
+    };
+
+...
diff --git a/Documentation/devicetree/bindings/ata/snps,dwc-ahci.yaml b/Documentation/devicetree/bindings/ata/snps,dwc-ahci.yaml
index 5afa4b57ce20..55a4bdfa3d9a 100644
--- a/Documentation/devicetree/bindings/ata/snps,dwc-ahci.yaml
+++ b/Documentation/devicetree/bindings/ata/snps,dwc-ahci.yaml
@@ -13,8 +13,14 @@ description:
   This document defines device tree bindings for the generic Synopsys DWC
   implementation of the AHCI SATA controller.
 
-allOf:
-  - $ref: snps,dwc-ahci-common.yaml#
+select:
+  properties:
+    compatible:
+      enum:
+        - snps,dwc-ahci
+        - snps,spear-ahci
+  required:
+    - compatible
 
 properties:
   compatible:
@@ -23,10 +29,6 @@ properties:
         const: snps,dwc-ahci
       - description: SPEAr1340 AHCI SATA device
         const: snps,spear-ahci
-      - description: Rockhip RK3568 AHCI controller
-        items:
-          - const: rockchip,rk3568-dwc-ahci
-          - const: snps,dwc-ahci
 
 patternProperties:
   "^sata-port@[0-9a-e]$":
@@ -39,6 +41,9 @@ required:
   - reg
   - interrupts
 
+allOf:
+  - $ref: snps,dwc-ahci-common.yaml#
+
 unevaluatedProperties: false
 
 examples:
-- 
2.39.2

