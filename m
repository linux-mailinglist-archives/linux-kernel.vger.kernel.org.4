Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B57468CFEC
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 07:59:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230116AbjBGG7S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 01:59:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230351AbjBGG7O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 01:59:14 -0500
Received: from relay.smtp-ext.broadcom.com (lpdvsmtp09.broadcom.com [192.19.166.228])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD13B25979;
        Mon,  6 Feb 2023 22:59:11 -0800 (PST)
Received: from mail-lvn-it-01.lvn.broadcom.net (mail-lvn-it-01.lvn.broadcom.net [10.75.146.107])
        by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id 22444C0000EE;
        Mon,  6 Feb 2023 22:59:11 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com 22444C0000EE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
        s=dkimrelay; t=1675753151;
        bh=vC2bM5qH9UbFvUgk2V7YqcH0nVMzmEMetZuatluXB4c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TyoM5kDliZJpVfEI6bUTVQMQeHOUuB7vdJqq0busZgCZc2+8YVS063qnQyV9wBeL1
         CxRLgARF1rpwwlwar7GiH3hoM8vl9WNTu13xCOBtV/XyKawlBJzyatyPOOiuXTryOO
         WewBYWGLX2WiN5HpkKXDUaS5TQkVGZ6GSNLbtlkk=
Received: from bcacpedev-irv-3.lvn.broadcom.net (bcacpedev-irv-3.lvn.broadcom.net [10.75.138.105])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail-lvn-it-01.lvn.broadcom.net (Postfix) with ESMTPS id 1F86818041CAC6;
        Mon,  6 Feb 2023 22:59:11 -0800 (PST)
Received: by bcacpedev-irv-3.lvn.broadcom.net (Postfix, from userid 28376)
        id 17ABD101B35; Mon,  6 Feb 2023 22:59:11 -0800 (PST)
From:   William Zhang <william.zhang@broadcom.com>
To:     Linux SPI List <linux-spi@vger.kernel.org>,
        Broadcom Kernel List <bcm-kernel-feedback-list@broadcom.com>
Cc:     kursad.oney@broadcom.com, anand.gore@broadcom.com,
        dan.beygelman@broadcom.com, dregan@mail.com, f.fainelli@gmail.com,
        joel.peshkin@broadcom.com, jonas.gorski@gmail.com,
        tomer.yacoby@broadcom.com,
        William Zhang <william.zhang@broadcom.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 02/15] dt-bindings: spi: Add bcmbca-hsspi controller support
Date:   Mon,  6 Feb 2023 22:58:13 -0800
Message-Id: <20230207065826.285013-3-william.zhang@broadcom.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20230207065826.285013-1-william.zhang@broadcom.com>
References: <20230207065826.285013-1-william.zhang@broadcom.com>
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

Changes in v3:
- Remove the blank line after maintainers tag
- Drop the minItems for brcm,bcmbca-hsspi-v1.0 binding requirement
- Replace the old example with the more recent and complex example
- Drop the generic compatible string brcm,bcmbca-hsspi

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

 .../bindings/spi/brcm,bcm63xx-hsspi.yaml      | 97 +++++++++++++++++--
 1 file changed, 88 insertions(+), 9 deletions(-)

diff --git a/Documentation/devicetree/bindings/spi/brcm,bcm63xx-hsspi.yaml b/Documentation/devicetree/bindings/spi/brcm,bcm63xx-hsspi.yaml
index 3c646997e399..6554978583f8 100644
--- a/Documentation/devicetree/bindings/spi/brcm,bcm63xx-hsspi.yaml
+++ b/Documentation/devicetree/bindings/spi/brcm,bcm63xx-hsspi.yaml
@@ -4,17 +4,70 @@
 $id: http://devicetree.org/schemas/spi/brcm,bcm63xx-hsspi.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: Broadcom BCM6328 High Speed SPI controller
+title: Broadcom Broadband SoC High Speed SPI controller
 
 maintainers:
+  - William Zhang <william.zhang@broadcom.com>
+  - Kursad Oney <kursad.oney@broadcom.com>
   - Jonas Gorski <jonas.gorski@gmail.com>
 
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
+
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
+      - items:
+          - enum:
+              - brcm,bcm4912-hsspi
+              - brcm,bcm6756-hsspi
+              - brcm,bcm6813-hsspi
+              - brcm,bcm6855-hsspi
+          - const: brcm,bcmbca-hsspi-v1.1
 
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
@@ -38,18 +91,44 @@ required:
 
 allOf:
   - $ref: spi-controller.yaml#
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
+          maxItems: 1
+        reg-names:
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
 
 unevaluatedProperties: false
 
 examples:
   - |
-    spi@10001000 {
-        compatible = "brcm,bcm6328-hsspi";
-        reg = <0x10001000 0x600>;
-        interrupts = <29>;
-        clocks = <&clkctl 9>, <&hsspi_pll>;
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    spi@ff801000 {
+        compatible = "brcm,bcm6756-hsspi", "brcm,bcmbca-hsspi-v1.1";
+        reg = <0xff801000 0x1000>,
+              <0xff802610 0x4>;
+        reg-names = "hsspi", "spim-ctrl";
+        interrupts = <GIC_SPI 36 IRQ_TYPE_LEVEL_HIGH>;
+        clocks = <&hsspi>, <&hsspi_pll>;
         clock-names = "hsspi", "pll";
-        num-cs = <2>;
+        num-cs = <8>;
         #address-cells = <1>;
         #size-cells = <0>;
     };
-- 
2.37.3

