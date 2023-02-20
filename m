Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9082069C55E
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 07:33:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230238AbjBTGbf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 01:31:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229662AbjBTGbd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 01:31:33 -0500
Received: from twspam01.aspeedtech.com (twspam01.aspeedtech.com [211.20.114.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6470DCA0D
        for <linux-kernel@vger.kernel.org>; Sun, 19 Feb 2023 22:31:28 -0800 (PST)
Received: from twspam01.aspeedtech.com (localhost [127.0.0.2] (may be forged))
        by twspam01.aspeedtech.com with ESMTP id 31K6ACHW023836
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 14:10:12 +0800 (GMT-8)
        (envelope-from ryan_chen@aspeedtech.com)
Received: from mail.aspeedtech.com ([192.168.0.24])
        by twspam01.aspeedtech.com with ESMTP id 31K64wMU022737;
        Mon, 20 Feb 2023 14:04:58 +0800 (GMT-8)
        (envelope-from ryan_chen@aspeedtech.com)
Received: from aspeedtech.com (192.168.10.13) by TWMBX02.aspeed.com
 (192.168.0.24) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 20 Feb
 2023 14:17:51 +0800
From:   Ryan Chen <ryan_chen@aspeedtech.com>
To:     Ryan Chen <ryan_chen@aspeedtech.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        <openbmc@lists.ozlabs.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-aspeed@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v5 1/2] dt-bindings: i2c: Add support for ASPEED i2Cv2
Date:   Mon, 20 Feb 2023 14:17:44 +0800
Message-ID: <20230220061745.1973981-2-ryan_chen@aspeedtech.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230220061745.1973981-1-ryan_chen@aspeedtech.com>
References: <20230220061745.1973981-1-ryan_chen@aspeedtech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [192.168.10.13]
X-ClientProxiedBy: TWMBX02.aspeed.com (192.168.0.24) To TWMBX02.aspeed.com
 (192.168.0.24)
X-DNSRBL: 
X-MAIL: twspam01.aspeedtech.com 31K64wMU022737
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        T_SPF_TEMPERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

AST2600 support new register set for I2Cv2 controller, add bindings
document to support driver of i2cv2 new register mode controller.

Signed-off-by: Ryan Chen <ryan_chen@aspeedtech.com>
---
 .../devicetree/bindings/i2c/aspeed,i2cv2.yaml | 83 +++++++++++++++++++
 1 file changed, 83 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/i2c/aspeed,i2cv2.yaml

diff --git a/Documentation/devicetree/bindings/i2c/aspeed,i2cv2.yaml b/Documentation/devicetree/bindings/i2c/aspeed,i2cv2.yaml
new file mode 100644
index 000000000000..913fb45d5fbe
--- /dev/null
+++ b/Documentation/devicetree/bindings/i2c/aspeed,i2cv2.yaml
@@ -0,0 +1,83 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/i2c/aspeed,i2cv2.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: ASPEED I2Cv2 Controller on the AST26XX SoCs
+
+maintainers:
+  - Ryan Chen <ryan_chen@aspeedtech.com>
+
+allOf:
+  - $ref: /schemas/i2c/i2c-controller.yaml#
+
+properties:
+  compatible:
+    enum:
+      - aspeed,ast2600-i2cv2
+
+  reg:
+    minItems: 1
+    items:
+      - description: address offset and range of register
+      - description: address offset and range of buffer register
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+    description:
+      Reference clock for the I2C bus
+
+  resets:
+    maxItems: 1
+
+  clock-frequency:
+    description:
+      Desired I2C bus clock frequency in Hz. default 100khz.
+
+  multi-master:
+    type: boolean
+    description:
+      states that there is another master active on this bus
+
+  timeout:
+    type: boolean
+    description: Enable i2c bus timeout for master/slave (35ms)
+
+  byte-mode:
+    type: boolean
+    description: Force i2c driver use byte mode transmit
+
+  buff-mode:
+    type: boolean
+    description: Force i2c driver use buffer mode transmit
+
+  aspeed,gr:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description: The phandle of i2c global register node.
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+  - resets
+  - aspeed,gr
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/clock/ast2600-clock.h>
+    i2c: i2c-bus@80 {
+      compatible = "aspeed,ast2600-i2cv2";
+      reg = <0x80 0x80>, <0xc00 0x20>;
+      interrupts = <GIC_SPI 110 IRQ_TYPE_LEVEL_HIGH>;
+      aspeed,gr = <&i2c_gr>;
+      clocks = <&syscon ASPEED_CLK_APB2>;
+      resets = <&syscon ASPEED_RESET_I2C>;
+    };
-- 
2.34.1

