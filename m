Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D732D627C19
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 12:19:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236175AbiKNLTb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 06:19:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235660AbiKNLRd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 06:17:33 -0500
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 424E85F59;
        Mon, 14 Nov 2022 03:15:38 -0800 (PST)
Received: (Authenticated sender: herve.codina@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPA id 5021960004;
        Mon, 14 Nov 2022 11:15:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1668424537;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=erW/gAS4dULA5JTOLl0FGx1bAeaHIYZy6jpj3FKM28s=;
        b=Bflxvrp7c3nXu/Kr/0hrFTO2EHZ6ONMIQHFqPMc6WfW5LqLxreWMhI06Bs4dUy8KaNlMfm
        wgmaHq2U6ke2q1OTwmGuWch9Szpe3BH7GS2k5wI7AISz/l+bkbbqoAnbRej7nSWpwjJlbq
        Yr7C7iURAgXf/wkGzILPKTRgfplwCLielX0wsfSAyKIsKTdmzD4Hc1zbnE9X8iautFNFzu
        MMg/TpWgAuh4KlFPT2YRC7UEgT2Qiv0eENyQTc+NXn6Hrx6QrqyQlbKyPguOgqujBN3Xnh
        qcFRQqcWWVZnnCRpP1JrSeI9Uo+tH1cu5p9lF2NwB8zjB7Vq2lobr1KachUFsQ==
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
Subject: [PATCH v2 4/7] dt-bindings: usb: add the Renesas RZ/N1 USBF controller binding
Date:   Mon, 14 Nov 2022 12:15:10 +0100
Message-Id: <20221114111513.1436165-5-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221114111513.1436165-1-herve.codina@bootlin.com>
References: <20221114111513.1436165-1-herve.codina@bootlin.com>
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
 .../bindings/usb/renesas,rzn1-usbf.yaml       | 68 +++++++++++++++++++
 1 file changed, 68 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/usb/renesas,rzn1-usbf.yaml

diff --git a/Documentation/devicetree/bindings/usb/renesas,rzn1-usbf.yaml b/Documentation/devicetree/bindings/usb/renesas,rzn1-usbf.yaml
new file mode 100644
index 000000000000..b67e9cea2522
--- /dev/null
+++ b/Documentation/devicetree/bindings/usb/renesas,rzn1-usbf.yaml
@@ -0,0 +1,68 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/usb/renesas,rzn1-usbf.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Renesas RZ/N1 SoCs USBF (USB Function) controller binding
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
+required:
+  - compatible
+  - reg
+  - clocks
+  - clock-names
+  - power-domains
+  - interrupts
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
+    };
-- 
2.38.1

