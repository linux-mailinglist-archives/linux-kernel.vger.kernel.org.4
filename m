Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9845F732D46
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 12:17:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245725AbjFPKRr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 06:17:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232292AbjFPKRZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 06:17:25 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CFDE2D67;
        Fri, 16 Jun 2023 03:17:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1686910645; x=1718446645;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2qNwSdEgN1RaimJx1SZpG9LQraX7Rtvs7wkFVvba3II=;
  b=T7aeyUKCUFGYaEIEhnd8DRc2RqiTCP83IBEE4y+TaIEK4IZ6DzbQBJpg
   0eNFl00cE65BJ7oBkNUzWNTWkaWiW98/QGeJ+inYabcjRg6atbynb0QFZ
   yFH5cStwQ2uEveyckpDbiRiTvCt05VFCb06B8PR7ev9SkaKrT7xr70llO
   TXOt15HqH8m3QpgMW4jKADy595fD9ZxfuvlrP+oPoKSPzrrIao6vc3x6y
   GzRo42dBjlVW02PtL9fWeD+tFhdD1sI0rZNo17YKD3lhMYz3rHTMllSrm
   oJMuhABph12c8Zp9RlZbTKuC2H+Gnq6bUYgh6g/MzdttMF+UErZGUZNux
   A==;
X-IronPort-AV: E=Sophos;i="6.00,247,1681196400"; 
   d="scan'208";a="216335035"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 16 Jun 2023 03:17:24 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Fri, 16 Jun 2023 03:17:14 -0700
Received: from m18063-ThinkPad-T460p.mchp-main.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.21 via Frontend Transport; Fri, 16 Jun 2023 03:17:11 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <sre@kernel.org>, <conor+dt@kernel.org>
CC:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v3 3/4] dt-bindings: power: reset: atmel,sama5d2-shdwc: convert to yaml
Date:   Fri, 16 Jun 2023 13:16:45 +0300
Message-ID: <20230616101646.879480-4-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230616101646.879480-1-claudiu.beznea@microchip.com>
References: <20230616101646.879480-1-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert Microchip AT91 SAMA5D2 shutdown controller to YAML. SAMA7G5 SHDWC
DT node (available in arch/arm/boot/dts/sama7g5.dtsi) has syscon along with
its compatible. There is no usage of this syscon in the current code but it
may be necessary in future as some registers of SHDWC are accessed in
different drivers (at91-sama5d2_shdwc.c and arch/arm/mach-at91/pm.c).
Thus update the YAML with it to make DT checkers happy.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>
---
 .../devicetree/bindings/arm/atmel-sysregs.txt |  63 ----------
 .../power/reset/atmel,sama5d2-shdwc.yaml      | 114 ++++++++++++++++++
 2 files changed, 114 insertions(+), 63 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/power/reset/atmel,sama5d2-shdwc.yaml

diff --git a/Documentation/devicetree/bindings/arm/atmel-sysregs.txt b/Documentation/devicetree/bindings/arm/atmel-sysregs.txt
index e6b2fb291b45..67a66bf74895 100644
--- a/Documentation/devicetree/bindings/arm/atmel-sysregs.txt
+++ b/Documentation/devicetree/bindings/arm/atmel-sysregs.txt
@@ -52,69 +52,6 @@ Example:
 		reg = <0xe3804000 0x1000>;
 };
 
-SHDWC SAMA5D2-Compatible Shutdown Controller
-
-1) shdwc node
-
-required properties:
-- compatible: should be "atmel,sama5d2-shdwc", "microchip,sam9x60-shdwc" or
-  "microchip,sama7g5-shdwc"
-- reg: should contain registers location and length
-- clocks: phandle to input clock.
-- #address-cells: should be one. The cell is the wake-up input index.
-- #size-cells: should be zero.
-
-optional properties:
-
-- debounce-delay-us: minimum wake-up inputs debouncer period in
-  microseconds. It's usually a board-related property.
-- atmel,wakeup-rtc-timer: boolean to enable Real-Time Clock wake-up.
-
-optional microchip,sam9x60-shdwc or microchip,sama7g5-shdwc properties:
-- atmel,wakeup-rtt-timer: boolean to enable Real-time Timer Wake-up.
-
-The node contains child nodes for each wake-up input that the platform uses.
-
-2) input nodes
-
-Wake-up input nodes are usually described in the "board" part of the Device
-Tree. Note also that input 0 is linked to the wake-up pin and is frequently
-used.
-
-Required properties:
-- reg: should contain the wake-up input index [0 - 15].
-
-Optional properties:
-- atmel,wakeup-active-high: boolean, the corresponding wake-up input described
-  by the child, forces the wake-up of the core power supply on a high level.
-  The default is to be active low.
-
-Example:
-
-On the SoC side:
-	shdwc@f8048010 {
-		compatible = "atmel,sama5d2-shdwc";
-		reg = <0xf8048010 0x10>;
-		clocks = <&clk32k>;
-		#address-cells = <1>;
-		#size-cells = <0>;
-		atmel,wakeup-rtc-timer;
-	};
-
-On the board side:
-	shdwc@f8048010 {
-		debounce-delay-us = <976>;
-
-		input@0 {
-			reg = <0>;
-		};
-
-		input@1 {
-			reg = <1>;
-			atmel,wakeup-active-high;
-		};
-	};
-
 Special Function Registers (SFR)
 
 Special Function Registers (SFR) manage specific aspects of the integrated
diff --git a/Documentation/devicetree/bindings/power/reset/atmel,sama5d2-shdwc.yaml b/Documentation/devicetree/bindings/power/reset/atmel,sama5d2-shdwc.yaml
new file mode 100644
index 000000000000..8c58e12cdb60
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/reset/atmel,sama5d2-shdwc.yaml
@@ -0,0 +1,114 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/power/reset/atmel,sama5d2-shdwc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Microchip AT91 SAMA5D2 SHDWC Shutdown Controller
+
+maintainers:
+  - Claudiu Beznea <claudiu.beznea@microchip.com>
+
+description: |
+  Microchip AT91 SHDWC shutdown controller controls the power supplies VDDIO
+  and VDDCORE and the wake-up detection on debounced input lines.
+
+properties:
+  compatible:
+    oneOf:
+      - items:
+          - const: microchip,sama7g5-shdwc
+          - const: syscon
+      - enum:
+          - atmel,sama5d2-shdwc
+          - microchip,sam9x60-shdwc
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  "#address-cells":
+    const: 1
+
+  "#size-cells":
+    const: 0
+
+  debounce-delay-us:
+    description:
+      Minimum wake-up inputs debouncer period in microseconds. It is usually a
+      board-related property.
+
+  atmel,wakeup-rtc-timer:
+    description: enable real-time clock wake-up
+    type: boolean
+
+  atmel,wakeup-rtt-timer:
+    description: enable real-time timer wake-up
+    type: boolean
+
+patternProperties:
+  "^input@[0-15]$":
+    description:
+      Wake-up input nodes. These are usually described in the "board" part of
+      the Device Tree. Note also that input 0 is linked to the wake-up pin and
+      is frequently used.
+    type: object
+    properties:
+      reg:
+        description: contains the wake-up input index
+        minimum: 0
+        maximum: 15
+
+      atmel,wakeup-active-high:
+        description:
+          The corresponding wake-up input described by the child forces the
+          wake-up of the core power supply on a high level. The default is to
+          be active low.
+        type: boolean
+
+    required:
+      - reg
+
+    additionalProperties: false
+
+required:
+  - compatible
+  - reg
+  - clocks
+
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: atmel,sama5d2-shdwc
+    then:
+      properties:
+        atmel,wakeup-rtt-timer: false
+
+additionalProperties: false
+
+examples:
+  - |
+    shdwc: poweroff@f8048010 {
+        compatible = "atmel,sama5d2-shdwc";
+        reg = <0xf8048010 0x10>;
+        clocks = <&clk32k>;
+        #address-cells = <1>;
+        #size-cells = <0>;
+        atmel,wakeup-rtc-timer;
+        debounce-delay-us = <976>;
+
+        input@0 {
+            reg = <0>;
+        };
+
+        input@1 {
+            reg = <1>;
+            atmel,wakeup-active-high;
+        };
+    };
+
+...
-- 
2.34.1

