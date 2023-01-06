Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46BCF660815
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 21:19:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235256AbjAFUTj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 15:19:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235927AbjAFUS6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 15:18:58 -0500
Received: from relay.smtp-ext.broadcom.com (relay.smtp-ext.broadcom.com [192.19.144.205])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB2463C0EE;
        Fri,  6 Jan 2023 12:18:26 -0800 (PST)
Received: from mail-lvn-it-01.lvn.broadcom.net (mail-lvn-it-01.lvn.broadcom.net [10.75.146.107])
        by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id D1001C0000FC;
        Fri,  6 Jan 2023 12:09:18 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com D1001C0000FC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
        s=dkimrelay; t=1673035758;
        bh=MYUsSHLgP7dHC8xMB/DwQimm9HCWfdRSSh+vEZ+hw8s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Uq6Jb+tn9ukWSXoSh2hF7LoPWK1VUcXvm8aP/V0NXjb2RNC8j/gkXL7W617D4aSZ8
         hASKvlQgVkQ1gNVWhb7uy4Cw08f4KIyxL+cxufGOmXpX2lR5GNk8To6Oygf8GVZSlz
         9kXvRxSuVwUsieGlx95AiVujcuQ4onFIPNWK+Moc=
Received: from bcacpedev-irv-3.lvn.broadcom.net (bcacpedev-irv-3.lvn.broadcom.net [10.75.138.105])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail-lvn-it-01.lvn.broadcom.net (Postfix) with ESMTPS id 90FF518041CAC6;
        Fri,  6 Jan 2023 12:09:18 -0800 (PST)
Received: by bcacpedev-irv-3.lvn.broadcom.net (Postfix, from userid 28376)
        id DE031101B33; Fri,  6 Jan 2023 12:09:08 -0800 (PST)
From:   William Zhang <william.zhang@broadcom.com>
To:     Linux SPI List <linux-spi@vger.kernel.org>,
        Broadcom Kernel List <bcm-kernel-feedback-list@broadcom.com>
Cc:     anand.gore@broadcom.com, tomer.yacoby@broadcom.com,
        dan.beygelman@broadcom.com, joel.peshkin@broadcom.com,
        f.fainelli@gmail.com, jonas.gorski@gmail.com,
        kursad.oney@broadcom.com, dregan@mail.com,
        William Zhang <william.zhang@broadcom.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 02/16] dt-bindings: spi: Add bcmbca-hsspi controller support
Date:   Fri,  6 Jan 2023 12:07:54 -0800
Message-Id: <20230106200809.330769-3-william.zhang@broadcom.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20230106200809.330769-1-william.zhang@broadcom.com>
References: <20230106200809.330769-1-william.zhang@broadcom.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The new Broadcom Broadband BCMBCA SoCs includes a updated HSSPI
controller. Add a new compatible string and required fields for the new
driver.  Also add myself and Kursad as the maintainers.

Signed-off-by: William Zhang <william.zhang@broadcom.com>
---

 .../bindings/spi/brcm,bcm63xx-hsspi.yaml      | 84 +++++++++++++++++--
 1 file changed, 78 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/spi/brcm,bcm63xx-hsspi.yaml b/Documentation/devicetree/bindings/spi/brcm,bcm63xx-hsspi.yaml
index 45f1417b1213..56e69d4a1faf 100644
--- a/Documentation/devicetree/bindings/spi/brcm,bcm63xx-hsspi.yaml
+++ b/Documentation/devicetree/bindings/spi/brcm,bcm63xx-hsspi.yaml
@@ -4,22 +4,51 @@
 $id: http://devicetree.org/schemas/spi/brcm,bcm63xx-hsspi.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: Broadcom BCM6328 High Speed SPI controller
+title: Broadcom Broadband SoC High Speed SPI controller
 
 maintainers:
+
+  - William Zhang <william.zhang@broadcom.com>
+  - Kursad Oney <kursad.oney@broadcom.com>
   - Jonas Gorski <jonas.gorski@gmail.com>
 
+description: |
+  Broadcom Broadband SoC supports High Speed SPI master controller since the
+  early MIPS based chips such as BCM6328 and BCM63268.  This controller was
+  carried over to recent ARM based chips, such as BCM63138, BCM4908 and BCM6858.
+
+  It has a limitation that can not keep the chip select line active between
+  the SPI transfers within the same SPI message. This can terminate the
+  transaction to some SPI devices prematurely. The issue can be worked around by
+  either the controller's prepend mode or using the dummy chip select
+  workaround. This controller uses the compatible string brcm,bcm6328-hsspi.
+
+  The newer SoCs such as BCM6756, BCM4912 and BCM6855 include an updated SPI
+  controller that add the capability to allow the driver to control chip select
+  explicitly. This solves the issue in the old controller. This new controller
+  uses the compatible string brcm,bcmbca-hsspi.
+
 properties:
   compatible:
-    const: brcm,bcm6328-hsspi
+    enum:
+      - brcm,bcm6328-hsspi
+      - brcm,bcmbca-hsspi
 
   reg:
-    maxItems: 1
+    items:
+      - description: main registers
+      - description: miscellaneous control registers
+    minItems: 1
+
+  reg-names:
+    items:
+      - const: hsspi
+      - const: spim-ctrl
 
   clocks:
     items:
-      - description: spi master reference clock
-      - description: spi master pll clock
+      - description: SPI master reference clock
+      - description: SPI master pll clock
 
   clock-names:
     items:
@@ -29,12 +58,43 @@ properties:
   interrupts:
     maxItems: 1
 
+  brcm,use-cs-workaround:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description: |
+      Enable dummy chip select workaround for SPI transfers that can not be
+      supported by the default controller's prepend mode, i.e. delay or cs
+      change needed between SPI transfers.
+
 required:
   - compatible
   - reg
   - clocks
   - clock-names
-  - interrupts
+
+allOf:
+  - $ref: "spi-controller.yaml#"
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - brcm,bcm6328-hsspi
+    then:
+      properties:
+        reg:
+          minItems: 1
+          maxItems: 1
+    else:
+      properties:
+        reg:
+          minItems: 2
+          maxItems: 2
+        reg-names:
+          minItems: 2
+          maxItems: 2
+        brcm,use-cs-workaround: false
+      required:
+        - reg-names
 
 unevaluatedProperties: false
 
@@ -50,3 +110,15 @@ examples:
         #address-cells = <1>;
         #size-cells = <0>;
     };
+  - |
+    spi@ff801000 {
+        compatible = "brcm,bcmbca-hsspi";
+        reg = <0xff801000 0x1000>,
+              <0xff802610 0x4>;
+        reg-names = "hsspi", "spim-ctrl";
+        clocks = <&hsspi>, <&hsspi_pll>;
+        clock-names = "hsspi", "pll";
+        num-cs = <8>;
+        #address-cells = <1>;
+        #size-cells = <0>;
+    };
-- 
2.37.3

