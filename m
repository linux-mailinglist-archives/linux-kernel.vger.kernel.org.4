Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42BE96B7E45
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 17:57:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231299AbjCMQ4y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 12:56:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230053AbjCMQ4r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 12:56:47 -0400
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E60FD56159;
        Mon, 13 Mar 2023 09:56:28 -0700 (PDT)
Received: from francesco-nb.pivistrello.it (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
        by mail11.truemail.it (Postfix) with ESMTPA id B874921E29;
        Mon, 13 Mar 2023 17:50:44 +0100 (CET)
From:   Francesco Dolcini <francesco@dolcini.it>
To:     linux-usb@vger.kernel.org, devicetree@vger.kernel.org
Cc:     Emanuele Ghidoli <emanuele.ghidoli@toradex.com>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Dongjin Kim <tobetter@gmail.com>,
        Francesco Dolcini <francesco.dolcini@toradex.com>
Subject: [PATCH v1 1/3] dt-bindings: usb: smsc,usb3503: Add usb3803
Date:   Mon, 13 Mar 2023 17:50:37 +0100
Message-Id: <20230313165039.255579-2-francesco@dolcini.it>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230313165039.255579-1-francesco@dolcini.it>
References: <20230313165039.255579-1-francesco@dolcini.it>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NO_DNS_FOR_FROM,
        SPF_HELO_PASS,T_SPF_TEMPERROR autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>

Add support for usb3803, compared to usb3503 it uses a regular USB
connection to upstream instead of HSIC, it has an additional
low power mode (bypass) and an additional control signal (BYPASS_N).

In bypass mode the downstream port 3 is connected to the upstream port
with low switch resistance R_on.

Signed-off-by: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>
Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
---
 .../devicetree/bindings/usb/smsc,usb3503.yaml | 54 ++++++++++++++++++-
 1 file changed, 52 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/usb/smsc,usb3503.yaml b/Documentation/devicetree/bindings/usb/smsc,usb3503.yaml
index a09f4528aea3..6156dc26e65c 100644
--- a/Documentation/devicetree/bindings/usb/smsc,usb3503.yaml
+++ b/Documentation/devicetree/bindings/usb/smsc,usb3503.yaml
@@ -14,6 +14,7 @@ properties:
     enum:
       - smsc,usb3503
       - smsc,usb3503a
+      - smsc,usb3803
 
   reg:
     maxItems: 1
@@ -33,6 +34,12 @@ properties:
     description: >
       GPIO for reset
 
+  bypass-gpios:
+    maxItems: 1
+    description: >
+      GPIO for bypass.
+      Control signal to select between HUB MODE and BYPASS MODE.
+
   disabled-ports:
     $ref: /schemas/types.yaml#/definitions/uint32-array
     minItems: 1
@@ -46,9 +53,10 @@ properties:
 
   initial-mode:
     $ref: /schemas/types.yaml#/definitions/uint32
-    enum: [1, 2]
     description: >
-      Specifies initial mode. 1 for Hub mode, 2 for standby mode.
+      Specifies initial mode. 1 for Hub mode, 2 for standby mode and 3 for bypass mode.
+      In bypass mode the downstream port 3 is connected to the upstream port with low
+      switch resistance R_on.
 
   clocks:
     maxItems: 1
@@ -71,6 +79,29 @@ properties:
 required:
   - compatible
 
+allOf:
+  - if:
+      not:
+        properties:
+          compatible:
+            enum:
+              - smsc,usb3803
+    then:
+      properties:
+        bypass-gpios: false
+
+  - if:
+      required:
+        - bypass-gpios
+    then:
+      properties:
+        initial-mode:
+          enum: [1, 2, 3]
+    else:
+      properties:
+        initial-mode:
+          enum: [1, 2]
+
 additionalProperties: false
 
 examples:
@@ -92,6 +123,25 @@ examples:
           };
       };
 
+  - |
+      i2c {
+          #address-cells = <1>;
+          #size-cells = <0>;
+
+          usb-hub@8 {
+              compatible = "smsc,usb3803";
+              reg = <0x08>;
+              connect-gpios = <&gpx3 0 1>;
+              disabled-ports = <2 3>;
+              intn-gpios = <&gpx3 4 1>;
+              reset-gpios = <&gpx3 5 1>;
+              bypass-gpios = <&gpx3 6 1>;
+              initial-mode = <3>;
+              clocks = <&clks 80>;
+              clock-names = "refclk";
+          };
+      };
+
   - |
       #include <dt-bindings/gpio/gpio.h>
 
-- 
2.25.1

