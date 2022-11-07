Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D6AC61F4D9
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 15:00:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232140AbiKGOAK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 09:00:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232099AbiKGOAE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 09:00:04 -0500
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56183635E;
        Mon,  7 Nov 2022 06:00:01 -0800 (PST)
Received: (Authenticated sender: herve.codina@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPA id EA3F24000D;
        Mon,  7 Nov 2022 13:59:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1667829600;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Nr0MWFd6v89DxvG5hmkKma8o7WLm2qLInkEbwYJ1akc=;
        b=fd1/3FMy9oIhCDEYAPt26LG7Aho5Yiu2RZ2E8Ah607tirDLJFySgvqDtzWNkfnBZn7YKxs
        GVOo/407JcsjxNx9eIGvl2bQJ8GZScaHKWtM0c2GXVTuMdUo6CLs8D7UxP4uccKzAsd6Tz
        Ed3qfyb24ALN3oPxrdXm/1Ho2t31fUBgC9b3rO7rZ23zDT1PlcUVclEcWrFfAS+MciKtMv
        5xYXcSTvpZlGzIg5bD0eO1BQro+jmPiShJQ/IlQaqT1aG1Jd71UFSZcwJjrN1v1QyP8cso
        pZX5/f0+Gi/0BwRoeH7KIk8N6wu1LgQxO2gRyRoF14AsW0SyT3Dm59j0CDGMOQ==
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
Subject: [PATCH 4/7] dt-bindings: usb: add the Renesas USBF controller binding
Date:   Mon,  7 Nov 2022 14:58:22 +0100
Message-Id: <20221107135825.583877-5-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221107135825.583877-1-herve.codina@bootlin.com>
References: <20221107135825.583877-1-herve.codina@bootlin.com>
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

The Renesas USBF controller is an USB2.0 device controller
(UDC) available in Renesas r9a06g032 SoC (RZ/N1 family).

Signed-off-by: Herve Codina <herve.codina@bootlin.com>
---
 .../devicetree/bindings/usb/renesas,usbf.yaml | 64 +++++++++++++++++++
 1 file changed, 64 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/usb/renesas,usbf.yaml

diff --git a/Documentation/devicetree/bindings/usb/renesas,usbf.yaml b/Documentation/devicetree/bindings/usb/renesas,usbf.yaml
new file mode 100644
index 000000000000..f2b146d9d37b
--- /dev/null
+++ b/Documentation/devicetree/bindings/usb/renesas,usbf.yaml
@@ -0,0 +1,64 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/usb/renesas,usbf.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Renesas USBF (USB Function) controller binding
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
+    oneOf:
+      - items:
+          - enum:
+              - renesas,r9a06g032-usbf
+          - const: renesas,rzn1-usbf
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    items:
+      - description: Internal bus clock (AHB) for Function
+      - description: Internal bus clock (AHB) for Power Management
+  clock-names:
+    items:
+      - const: hclkf
+      - const: hclkpm
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
+        interrupts =
+            <GIC_SPI 77 IRQ_TYPE_LEVEL_HIGH>,
+            <GIC_SPI 78 IRQ_TYPE_LEVEL_HIGH>;
+        clocks = <&sysctrl R9A06G032_HCLK_USBF>,
+                 <&sysctrl R9A06G032_HCLK_USBPM>;
+        clock-names = "hclkf", "hclkpm";
+    };
-- 
2.37.3

