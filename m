Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19DB564B641
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 14:33:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235605AbiLMNdZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 08:33:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235281AbiLMNdU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 08:33:20 -0500
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::222])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23D286361;
        Tue, 13 Dec 2022 05:33:17 -0800 (PST)
Received: (Authenticated sender: herve.codina@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPA id A94F040004;
        Tue, 13 Dec 2022 13:33:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1670938396;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gT1SzmrwD2Q3IGrDxGN5feKqp7sHflj9viAxhsZoKW4=;
        b=MiKvh6M6NohegQpF1nyE16nFbZAqezBz0yefbmh9X5Rb1nO8uqnq3wo1Kgva5UC7bz/avV
        1VMKO559UhUt0X40Qei11UIUhbixd5TAUi5KFpSftYXacCD+vO8O2BXenmv6J5CCbSfAXD
        gmOvQz1L9YIVeHsgx22Zz15Rqn2j0BE/1o+PpJJlzo29zNexIvvrBLyy3FNl9D1iEGLKgd
        7gaQ6b1SJdzG9ImtdiUx9NjYDKZKr/aFLQ2P/7VXtoFeGJffJ+FlOz5BDuDezXItFAkj5N
        VOlko2XohpKb/ktikMeDH5FKmpyObZkwz2AHD39DxfiFwR8aUf42FlzbcIp3yA==
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
Subject: [PATCH v4 1/5] dt-bindings: usb: add the Renesas RZ/N1 USBF controller
Date:   Tue, 13 Dec 2022 14:32:58 +0100
Message-Id: <20221213133302.218955-2-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221213133302.218955-1-herve.codina@bootlin.com>
References: <20221213133302.218955-1-herve.codina@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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
index 000000000000..b6e84a2a6925
--- /dev/null
+++ b/Documentation/devicetree/bindings/usb/renesas,rzn1-usbf.yaml
@@ -0,0 +1,68 @@
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

