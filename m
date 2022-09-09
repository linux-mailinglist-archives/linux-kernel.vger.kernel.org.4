Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57D2D5B3FF3
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 21:39:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232114AbiIITjR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 15:39:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231824AbiIITiM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 15:38:12 -0400
Received: from mail.baikalelectronics.com (mail.baikalelectronics.com [87.245.175.230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BA7F3139C20;
        Fri,  9 Sep 2022 12:36:55 -0700 (PDT)
Received: from mail (mail.baikal.int [192.168.51.25])
        by mail.baikalelectronics.com (Postfix) with ESMTP id C62C5DB9;
        Fri,  9 Sep 2022 22:40:34 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.baikalelectronics.com C62C5DB9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baikalelectronics.ru; s=mail; t=1662752434;
        bh=K3vap0FpFoGMz05xBagElq3cuTU5ZyDcEp63VapujxY=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=XEIlIEdjLShNl6K4fV3jXjZ4H4k53kd74RVy138R493p+QhQWmY1B2EKzjeAU/zg8
         jVqyx+sYHEtQz5QZcMh3mgQGayUT0d8i33WWztv9swAplo+bxL602VOp3eHWJaioWV
         Bo2kDFKmsDQUBHL3El7AwbaSFgOVjW3oWhUwyQ2E=
Received: from localhost (192.168.168.10) by mail (192.168.51.25) with
 Microsoft SMTP Server (TLS) id 15.0.1395.4; Fri, 9 Sep 2022 22:36:46 +0300
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Jens Axboe <axboe@kernel.dk>, Hannes Reinecke <hare@suse.de>,
        Serge Semin <fancer.lancer@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        <linux-ide@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, Rob Herring <robh@kernel.org>
Subject: [PATCH v8 20/23] dt-bindings: ata: ahci: Add Baikal-T1 AHCI SATA controller DT schema
Date:   Fri, 9 Sep 2022 22:36:18 +0300
Message-ID: <20220909193621.17380-21-Sergey.Semin@baikalelectronics.ru>
In-Reply-To: <20220909193621.17380-1-Sergey.Semin@baikalelectronics.ru>
References: <20220909193621.17380-1-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Baikal-T1 AHCI controller is based on the DWC AHCI SATA IP-core v4.10a
with the next specific settings: two SATA ports, cascaded CSR access based
on two clock domains (APB and AXI), selectable source of the reference
clock (though stable work is currently available from the external source
only), two reset lanes for the application and SATA ports domains. Other
than that the device is fully compatible with the generic DWC AHCI SATA
bindings.

Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Rob Herring <robh@kernel.org>

---

Changelog v2:
- Rename 'syscon' property to 'baikal,bt1-syscon'.
- Drop macro usage from the example node.

Changelog v4:
- Use the DWC AHCI port properties definition from the DWC AHCI SATA
  common schema. (@Rob)
- Drop Baikal-T1 syscon reference and implement the clock signal
  source in the framework of the clock controller. (@Rob)

Changelog v5:
- Drop generic compatible fallback "snps,dwc-ahci". (@Rob)
- Define SATA-port pattern property to be applicable for two ports
  only.
- Drop "|" qualifier from the description property.
---
 .../bindings/ata/baikal,bt1-ahci.yaml         | 115 ++++++++++++++++++
 1 file changed, 115 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/ata/baikal,bt1-ahci.yaml

diff --git a/Documentation/devicetree/bindings/ata/baikal,bt1-ahci.yaml b/Documentation/devicetree/bindings/ata/baikal,bt1-ahci.yaml
new file mode 100644
index 000000000000..9b7ca4759bd7
--- /dev/null
+++ b/Documentation/devicetree/bindings/ata/baikal,bt1-ahci.yaml
@@ -0,0 +1,115 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/ata/baikal,bt1-ahci.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Baikal-T1 SoC AHCI SATA controller
+
+maintainers:
+  - Serge Semin <fancer.lancer@gmail.com>
+
+description:
+  AHCI SATA controller embedded into the Baikal-T1 SoC is based on the
+  DWC AHCI SATA v4.10a IP-core.
+
+allOf:
+  - $ref: snps,dwc-ahci-common.yaml#
+
+properties:
+  compatible:
+    const: baikal,bt1-ahci
+
+  clocks:
+    items:
+      - description: Peripheral APB bus clock
+      - description: Application AXI BIU clock
+      - description: SATA Ports reference clock
+
+  clock-names:
+    items:
+      - const: pclk
+      - const: aclk
+      - const: ref
+
+  resets:
+    items:
+      - description: Application AXI BIU domain reset
+      - description: SATA Ports clock domain reset
+
+  reset-names:
+    items:
+      - const: arst
+      - const: ref
+
+  ports-implemented:
+    maximum: 0x3
+
+patternProperties:
+  "^sata-port@[0-1]$":
+    $ref: /schemas/ata/snps,dwc-ahci-common.yaml#/$defs/dwc-ahci-port
+
+    properties:
+      reg:
+        minimum: 0
+        maximum: 1
+
+      snps,tx-ts-max:
+        $ref: /schemas/types.yaml#/definitions/uint32
+        description:
+          Due to having AXI3 bus interface utilized the maximum Tx DMA
+          transaction size can't exceed 16 beats (AxLEN[3:0]).
+        enum: [ 1, 2, 4, 8, 16 ]
+
+      snps,rx-ts-max:
+        $ref: /schemas/types.yaml#/definitions/uint32
+        description:
+          Due to having AXI3 bus interface utilized the maximum Rx DMA
+          transaction size can't exceed 16 beats (AxLEN[3:0]).
+        enum: [ 1, 2, 4, 8, 16 ]
+
+    unevaluatedProperties: false
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+  - clock-names
+  - resets
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    sata@1f050000 {
+      compatible = "baikal,bt1-ahci";
+      reg = <0x1f050000 0x2000>;
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      interrupts = <0 64 4>;
+
+      clocks = <&ccu_sys 1>, <&ccu_axi 2>, <&sata_ref_clk>;
+      clock-names = "pclk", "aclk", "ref";
+
+      resets = <&ccu_axi 2>, <&ccu_sys 0>;
+      reset-names = "arst", "ref";
+
+      ports-implemented = <0x3>;
+
+      sata-port@0 {
+        reg = <0>;
+
+        snps,tx-ts-max = <4>;
+        snps,rx-ts-max = <4>;
+      };
+
+      sata-port@1 {
+        reg = <1>;
+
+        snps,tx-ts-max = <4>;
+        snps,rx-ts-max = <4>;
+      };
+    };
+...
-- 
2.37.2

