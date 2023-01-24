Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D65EF67A5D4
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 23:33:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234618AbjAXWdK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 17:33:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229646AbjAXWc7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 17:32:59 -0500
Received: from relay.smtp-ext.broadcom.com (saphodev.broadcom.com [192.19.144.205])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A14010F7;
        Tue, 24 Jan 2023 14:32:45 -0800 (PST)
Received: from mail-lvn-it-01.lvn.broadcom.net (mail-lvn-it-01.lvn.broadcom.net [10.75.146.107])
        by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id 55ABDC0000EC;
        Tue, 24 Jan 2023 14:32:44 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com 55ABDC0000EC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
        s=dkimrelay; t=1674599564;
        bh=1AasMDJlVG8RK3Nq7eNCAOUs+eQGJ1QI2Hr2WwNZNu8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dQzWBwfMmzEYT86/g5Y58g3VIi8Dzxkor7emouWIq/FiDwq1XCtkyywNv5EqilTBq
         jLjVRqHBb6vrYtlAVWOekykwRB6laAvezsKtZVAzoSIrlNxtmysE66GozPJobCy0Cn
         clEhn+0ACSND0XwKq2J8p0JbKLYHV17iEmjH61mI=
Received: from bcacpedev-irv-3.lvn.broadcom.net (bcacpedev-irv-3.lvn.broadcom.net [10.75.138.105])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail-lvn-it-01.lvn.broadcom.net (Postfix) with ESMTPS id 157F618041CAC6;
        Tue, 24 Jan 2023 14:32:44 -0800 (PST)
Received: by bcacpedev-irv-3.lvn.broadcom.net (Postfix, from userid 28376)
        id 44351101ACF; Tue, 24 Jan 2023 14:32:34 -0800 (PST)
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
Subject: [PATCH v2 01/14] dt-bindings: spi: Convert bcm63xx-hsspi bindings to json-schema
Date:   Tue, 24 Jan 2023 14:12:04 -0800
Message-Id: <20230124221218.341511-2-william.zhang@broadcom.com>
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

This is the preparation for updates on the bcm63xx hsspi driver. Convert
the text based bindings to json-schema per new dts requirement.

Signed-off-by: William Zhang <william.zhang@broadcom.com>

---

Changes in v2:
- Add the missing reference to spi-controller which fix the
  dt_binding_check error.
- Use SPI intead of spi in the description.

 .../bindings/spi/brcm,bcm63xx-hsspi.yaml      | 55 +++++++++++++++++++
 .../bindings/spi/spi-bcm63xx-hsspi.txt        | 33 -----------
 2 files changed, 55 insertions(+), 33 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/spi/brcm,bcm63xx-hsspi.yaml
 delete mode 100644 Documentation/devicetree/bindings/spi/spi-bcm63xx-hsspi.txt

diff --git a/Documentation/devicetree/bindings/spi/brcm,bcm63xx-hsspi.yaml b/Documentation/devicetree/bindings/spi/brcm,bcm63xx-hsspi.yaml
new file mode 100644
index 000000000000..d1a0c9adee7a
--- /dev/null
+++ b/Documentation/devicetree/bindings/spi/brcm,bcm63xx-hsspi.yaml
@@ -0,0 +1,55 @@
+# SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/spi/brcm,bcm63xx-hsspi.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Broadcom BCM6328 High Speed SPI controller
+
+maintainers:
+  - Jonas Gorski <jonas.gorski@gmail.com>
+
+allOf:
+  - $ref: spi-controller.yaml#
+
+properties:
+  compatible:
+    const: brcm,bcm6328-hsspi
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    items:
+      - description: SPI master reference clock
+      - description: SPI master pll clock
+
+  clock-names:
+    items:
+      - const: hsspi
+      - const: pll
+
+  interrupts:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - clock-names
+  - interrupts
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    spi@10001000 {
+        compatible = "brcm,bcm6328-hsspi";
+        reg = <0x10001000 0x600>;
+        interrupts = <29>;
+        clocks = <&clkctl 9>, <&hsspi_pll>;
+        clock-names = "hsspi", "pll";
+        num-cs = <2>;
+        #address-cells = <1>;
+        #size-cells = <0>;
+    };
diff --git a/Documentation/devicetree/bindings/spi/spi-bcm63xx-hsspi.txt b/Documentation/devicetree/bindings/spi/spi-bcm63xx-hsspi.txt
deleted file mode 100644
index 37b29ee13860..000000000000
--- a/Documentation/devicetree/bindings/spi/spi-bcm63xx-hsspi.txt
+++ /dev/null
@@ -1,33 +0,0 @@
-Binding for Broadcom BCM6328 High Speed SPI controller
-
-Required properties:
-- compatible: must contain of "brcm,bcm6328-hsspi".
-- reg: Base address and size of the controllers memory area.
-- interrupts: Interrupt for the SPI block.
-- clocks: phandles of the SPI clock and the PLL clock.
-- clock-names: must be "hsspi", "pll".
-- #address-cells: <1>, as required by generic SPI binding.
-- #size-cells: <0>, also as required by generic SPI binding.
-
-Optional properties:
-- num-cs: some controllers have less than 8 cs signals. Defaults to 8
-  if absent.
-
-Child nodes as per the generic SPI binding.
-
-Example:
-
-	spi@10001000 {
-		compatible = "brcm,bcm6328-hsspi";
-		reg = <0x10001000 0x600>;
-
-		interrupts = <29>;
-
-		clocks = <&clkctl 9>, <&hsspi_pll>;
-		clock-names = "hsspi", "pll";
-
-		num-cs = <2>;
-
-		#address-cells = <1>;
-		#size-cells = <0>;
-	};
-- 
2.37.3

