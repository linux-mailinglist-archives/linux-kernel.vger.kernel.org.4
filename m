Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3407B67A5DB
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 23:33:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234972AbjAXWdT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 17:33:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233983AbjAXWdB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 17:33:01 -0500
Received: from relay.smtp-ext.broadcom.com (relay.smtp-ext.broadcom.com [192.19.144.205])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DD84658C;
        Tue, 24 Jan 2023 14:32:50 -0800 (PST)
Received: from mail-lvn-it-01.lvn.broadcom.net (mail-lvn-it-01.lvn.broadcom.net [10.75.146.107])
        by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id 15907C0000F1;
        Tue, 24 Jan 2023 14:32:49 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com 15907C0000F1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
        s=dkimrelay; t=1674599569;
        bh=Tx1+5rUoGajz6QcIySFSqWNJkbw3Y5M8aGLdQJSafow=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JL9s1QaZqOqDSFXZaBP0rTM7wMCrPfuQJ0sPHS44Aio4l3m/SiCTo5DvMWxpoH2ih
         EHIdKHcgdfXM/t9FNrCFgqst8MeCs3o08RBdW58NXXuG49gN0W0FT+Dj9RUSwBhoMU
         /m0arxfAg/XMxRPYk6+JgEYY/TgvZKSSoCBggtQg=
Received: from bcacpedev-irv-3.lvn.broadcom.net (bcacpedev-irv-3.lvn.broadcom.net [10.75.138.105])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail-lvn-it-01.lvn.broadcom.net (Postfix) with ESMTPS id D15C818041CAC6;
        Tue, 24 Jan 2023 14:32:48 -0800 (PST)
Received: by bcacpedev-irv-3.lvn.broadcom.net (Postfix, from userid 28376)
        id 14F98101B54; Tue, 24 Jan 2023 14:32:39 -0800 (PST)
From:   William Zhang <william.zhang@broadcom.com>
To:     Linux SPI List <linux-spi@vger.kernel.org>,
        Broadcom Kernel List <bcm-kernel-feedback-list@broadcom.com>
Cc:     tomer.yacoby@broadcom.com, kursad.oney@broadcom.com,
        dregan@mail.com, f.fainelli@gmail.com, anand.gore@broadcom.com,
        jonas.gorski@gmail.com, dan.beygelman@broadcom.com,
        joel.peshkin@broadcom.com,
        William Zhang <william.zhang@broadcom.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 02/14] dt-bindings: spi: Add bcmbca-hsspi controller support
Date:   Tue, 24 Jan 2023 14:12:05 -0800
Message-Id: <20230124221218.341511-3-william.zhang@broadcom.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20230124221218.341511-1-william.zhang@broadcom.com>
References: <20230124221218.341511-1-william.zhang@broadcom.com>
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
controller. Add new compatible strings to differentiate the old and new
controller while keeping MIPS based chip with the old compatible. Update
property requirements for these two revisions of the controller.  Also
add myself and Kursad as the maintainers.

Signed-off-by: William Zhang <william.zhang@broadcom.com>

---

Changes in v2:
- Update new compatible string to follow Broadcom convention <chip
specific compatible>, <version of the IP>, <fallback>
- Add reg-names min/maxItem constraints to be consistent with reg
property
- Make interrupts required property
- Remove double quote from spi-controller.yaml reference
- Remove brcm,use-cs-workaround flag
- Update the example with new compatile and interrupts property
- Update commit message

 .../bindings/spi/brcm,bcm63xx-hsspi.yaml      | 106 +++++++++++++++++-
 1 file changed, 101 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/spi/brcm,bcm63xx-hsspi.yaml b/Documentation/devicetree/bindings/spi/brcm,bcm63xx-hsspi.yaml
index d1a0c9adee7a..d39604654c9e 100644
--- a/Documentation/devicetree/bindings/spi/brcm,bcm63xx-hsspi.yaml
+++ b/Documentation/devicetree/bindings/spi/brcm,bcm63xx-hsspi.yaml
@@ -4,20 +4,73 @@
 $id: http://devicetree.org/schemas/spi/brcm,bcm63xx-hsspi.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: Broadcom BCM6328 High Speed SPI controller
+title: Broadcom Broadband SoC High Speed SPI controller
 
 maintainers:
+
+  - William Zhang <william.zhang@broadcom.com>
+  - Kursad Oney <kursad.oney@broadcom.com>
   - Jonas Gorski <jonas.gorski@gmail.com>
 
-allOf:
-  - $ref: spi-controller.yaml#
+description: |
+  Broadcom Broadband SoC supports High Speed SPI master controller since the
+  early MIPS based chips such as BCM6328 and BCM63268.  This initial rev 1.0
+  controller was carried over to recent ARM based chips, such as BCM63138,
+  BCM4908 and BCM6858. The old MIPS based chip should continue to use the
+  brcm,bcm6328-hsspi compatible string. The recent ARM based chip is required to
+  use the brcm,bcmbca-hsspi-v1.0 as part of its compatible string list as
+  defined below to match the specific chip along with ip revision info.
+
+  This rev 1.0 controller has a limitation that can not keep the chip select line
+  active between the SPI transfers within the same SPI message. This can
+  terminate the transaction to some SPI devices prematurely. The issue can be
+  worked around by either the controller's prepend mode or using the dummy chip
+  select workaround. Driver automatically picks the suitable mode based on
+  transfer type so it is transparent to the user.
+
+  The newer SoCs such as BCM6756, BCM4912 and BCM6855 include an updated SPI
+  controller rev 1.1 that add the capability to allow the driver to control chip
+  select explicitly. This solves the issue in the old controller.
 
 properties:
   compatible:
-    const: brcm,bcm6328-hsspi
+    oneOf:
+      - const: brcm,bcm6328-hsspi
+      - items:
+          - enum:
+              - brcm,bcm47622-hsspi
+              - brcm,bcm4908-hsspi
+              - brcm,bcm63138-hsspi
+              - brcm,bcm63146-hsspi
+              - brcm,bcm63148-hsspi
+              - brcm,bcm63158-hsspi
+              - brcm,bcm63178-hsspi
+              - brcm,bcm6846-hsspi
+              - brcm,bcm6856-hsspi
+              - brcm,bcm6858-hsspi
+              - brcm,bcm6878-hsspi
+          - const: brcm,bcmbca-hsspi-v1.0
+          - const: brcm,bcmbca-hsspi
+      - items:
+          - enum:
+              - brcm,bcm4912-hsspi
+              - brcm,bcm6756-hsspi
+              - brcm,bcm6813-hsspi
+              - brcm,bcm6855-hsspi
+          - const: brcm,bcmbca-hsspi-v1.1
+          - const: brcm,bcmbca-hsspi
 
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
+    minItems: 1
 
   clocks:
     items:
@@ -39,10 +92,39 @@ required:
   - clock-names
   - interrupts
 
+allOf:
+  - $ref: spi-controller.yaml#
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - brcm,bcm6328-hsspi
+              - brcm,bcmbca-hsspi-v1.0
+    then:
+      properties:
+        reg:
+          minItems: 1
+          maxItems: 1
+        reg-names:
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
+      required:
+        - reg-names
+
 unevaluatedProperties: false
 
 examples:
   - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
     spi@10001000 {
         compatible = "brcm,bcm6328-hsspi";
         reg = <0x10001000 0x600>;
@@ -53,3 +135,17 @@ examples:
         #address-cells = <1>;
         #size-cells = <0>;
     };
+  - |
+    spi@ff801000 {
+        compatible = "brcm,bcm6756-hsspi", "brcm,bcmbca-hsspi-v1.1",
+                     "brcm,bcmbca-hsspi";
+        reg = <0xff801000 0x1000>,
+              <0xff802610 0x4>;
+        reg-names = "hsspi", "spim-ctrl";
+        interrupts = <GIC_SPI 36 IRQ_TYPE_LEVEL_HIGH>;
+        clocks = <&hsspi>, <&hsspi_pll>;
+        clock-names = "hsspi", "pll";
+        num-cs = <8>;
+        #address-cells = <1>;
+        #size-cells = <0>;
+    };
-- 
2.37.3

