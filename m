Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 196B9645EC9
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 17:25:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229733AbiLGQZJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 11:25:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229634AbiLGQYz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 11:24:55 -0500
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5269654C5;
        Wed,  7 Dec 2022 08:24:53 -0800 (PST)
Received: (Authenticated sender: herve.codina@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPA id 1BA6840002;
        Wed,  7 Dec 2022 16:24:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1670430292;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Cw1SD2x2j9VwG5OfOxSIfzoHCrLTb+QOElcScbrzv58=;
        b=Hkxkn/PiG3n5PuVYBTTcdXohsjj1XD/w/ITs/yTxn6IcF29RaPmbylXvApwzBI1twbgert
        dxdMQWgDUvTNf5Ozg7L92XSDvt+TBk99YsqpKAhJQcvEcfSjwG8LUuVAQ61L+PUvqSB5a/
        jL662I6zZEMQaPqG5ulaI2+odF4ALyG7HhL6UGqtbP0LrcE471l2QMUKjgMU8CK1J+SPRd
        tnD75izDW2Z9xPwE0T42U7aGZXs7SlXgP9zsFDq4iT+WrOcFowff6/2TwVpFifIfgu5nwa
        5fWmiSmyUvSbB/vc77olpgUdvnonUDPomfBRUgbnl/BQbTEvWmkgaVB2fCmmzg==
From:   Herve Codina <herve.codina@bootlin.com>
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Herve Codina <herve.codina@bootlin.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Magnus Damm <magnus.damm@gmail.com>,
        Gareth Williams <gareth.williams.jx@renesas.com>
Cc:     linux-renesas-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH v3 5/9] dt-bindings: usb: add the Renesas RZ/N1 USBF controller
Date:   Wed,  7 Dec 2022 17:24:31 +0100
Message-Id: <20221207162435.1001782-6-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221207162435.1001782-1-herve.codina@bootlin.com>
References: <20221207162435.1001782-1-herve.codina@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Renesas RZ/N1 USBF controller is an USB2.0 device controller
(UDC) available in the Renesas r9a06g032 SoC (RZ/N1 family).

Signed-off-by: Herve Codina <herve.codina@bootlin.com>
---
 .../bindings/usb/renesas,rzn1-usbf.yaml       | 77 +++++++++++++++++++
 1 file changed, 77 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/usb/renesas,rzn1-usbf.yaml

diff --git a/Documentation/devicetree/bindings/usb/renesas,rzn1-usbf.yaml b/Documentation/devicetree/bindings/usb/renesas,rzn1-usbf.yaml
new file mode 100644
index 000000000000..e746ea55b78d
--- /dev/null
+++ b/Documentation/devicetree/bindings/usb/renesas,rzn1-usbf.yaml
@@ -0,0 +1,77 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/usb/renesas,rzn1-usbf.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Renesas RZ/N1 SoCs USBF (USB Function) controller
+
+description: |
+   The Renesas USBF controller is an USB2.0 device
+   controller (UDC).
+
+maintainers:
+  - Herve Codina <herve.codina@bootlin.com>
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - renesas,r9a06g032-usbf
+      - const: renesas,rzn1-usbf
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    items:
+      - description: Internal bus clock (AHB) for Function
+      - description: Internal bus clock (AHB) for Power Management
+
+  clock-names:
+    items:
+      - const: hclkf
+      - const: hclkpm
+
+  power-domains:
+    maxItems: 1
+
+  interrupts:
+    items:
+      - description: The USBF EPC interrupt
+      - description: The USBF AHB-EPC interrupt
+
+  depends-on:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description:
+      Phandle to the node (sysctrl node) that set the 'h2mode' value in
+      order to express the fact that sysctrl must set the 'h2mode' before
+      the USB device controller starts.
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - clock-names
+  - power-domains
+  - interrupts
+  - depends-on
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/clock/r9a06g032-sysctrl.h>
+
+    usb@4001e000 {
+        compatible = "renesas,r9a06g032-usbf", "renesas,rzn1-usbf";
+        reg = <0x4001e000 0x2000>;
+        interrupts = <GIC_SPI 77 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 78 IRQ_TYPE_LEVEL_HIGH>;
+        clocks = <&sysctrl R9A06G032_HCLK_USBF>,
+                 <&sysctrl R9A06G032_HCLK_USBPM>;
+        clock-names = "hclkf", "hclkpm";
+        power-domains = <&sysctrl>;
+        depends-on = <&sysctrl>;
+    };
-- 
2.38.1

