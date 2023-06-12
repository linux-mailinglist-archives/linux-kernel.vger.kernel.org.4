Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32DC672CC32
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 19:14:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231328AbjFLROI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 13:14:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236948AbjFLRNp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 13:13:45 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03D7010E3;
        Mon, 12 Jun 2023 10:13:42 -0700 (PDT)
Received: from jupiter.universe (dyndsl-091-248-210-131.ewe-ip-backbone.de [91.248.210.131])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 04B4B6606EBB;
        Mon, 12 Jun 2023 18:13:41 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1686590021;
        bh=VJpqZyVFrCk2SKOCiAs/vOmL6h0Sc0ZuNVY80eWQnII=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gVEkaJp21zFOAxvtACw6eyLVWi+x2W932RzMN8czl7lpS4QRTRk6JLX8OsuelJ7q3
         zyjf4NdvAygv0fgoBIqIZ8ZSPb810kjkuKf9xESkI8AB6nnpV+QlO0Ar7inSNZyvPk
         lPwX8kNAeyInhGxWkP4CPmBG/3wSsrTFVqpNxOJNPfOifVljB2e5ug5QfI5raXa3XU
         b8tqRIxYtzbr3wm2XeK33ScfkkzLJzKHmbwG6cdpvUVUmDIT19k/EXrWn3IfF0gDvC
         ojeIuKlsT2qyaOI6bSmiMrZEm/fqLXh1J/9/2FOc4kCes9C4IdOCyBJrClTFtKIyXV
         YHCnQd3Hd989g==
Received: by jupiter.universe (Postfix, from userid 1000)
        id A57AE4807E1; Mon, 12 Jun 2023 19:13:38 +0200 (CEST)
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
Subject: [PATCH v4 2/5] dt-bindings: ata: dwc-ahci: add Rockchip RK3588
Date:   Mon, 12 Jun 2023 19:13:34 +0200
Message-Id: <20230612171337.74576-3-sebastian.reichel@collabora.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230612171337.74576-1-sebastian.reichel@collabora.com>
References: <20230612171337.74576-1-sebastian.reichel@collabora.com>
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
 .../bindings/ata/rockchip,dwc-ahci.yaml       | 124 ++++++++++++++++++
 .../bindings/ata/snps,dwc-ahci.yaml           |  13 +-
 2 files changed, 133 insertions(+), 4 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/ata/rockchip,dwc-ahci.yaml

diff --git a/Documentation/devicetree/bindings/ata/rockchip,dwc-ahci.yaml b/Documentation/devicetree/bindings/ata/rockchip,dwc-ahci.yaml
new file mode 100644
index 000000000000..b5e5767d8698
--- /dev/null
+++ b/Documentation/devicetree/bindings/ata/rockchip,dwc-ahci.yaml
@@ -0,0 +1,124 @@
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
+  sata-port@0:
+    $ref: /schemas/ata/snps,dwc-ahci-common.yaml#/$defs/dwc-ahci-port
+
+    properties:
+      reg:
+        const: 0
+
+    unevaluatedProperties: false
+
+patternProperties:
+  "^sata-port@[1-9a-e]$": false
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
+        clocks:
+          maxItems: 5
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
+        clocks:
+          maxItems: 3
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
index 5afa4b57ce20..4c848fcb5a5d 100644
--- a/Documentation/devicetree/bindings/ata/snps,dwc-ahci.yaml
+++ b/Documentation/devicetree/bindings/ata/snps,dwc-ahci.yaml
@@ -13,6 +13,15 @@ description:
   This document defines device tree bindings for the generic Synopsys DWC
   implementation of the AHCI SATA controller.
 
+select:
+  properties:
+    compatible:
+      enum:
+        - snps,dwc-ahci
+        - snps,spear-ahci
+  required:
+    - compatible
+
 allOf:
   - $ref: snps,dwc-ahci-common.yaml#
 
@@ -23,10 +32,6 @@ properties:
         const: snps,dwc-ahci
       - description: SPEAr1340 AHCI SATA device
         const: snps,spear-ahci
-      - description: Rockhip RK3568 AHCI controller
-        items:
-          - const: rockchip,rk3568-dwc-ahci
-          - const: snps,dwc-ahci
 
 patternProperties:
   "^sata-port@[0-9a-e]$":
-- 
2.39.2

