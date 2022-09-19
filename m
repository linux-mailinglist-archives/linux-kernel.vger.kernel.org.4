Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF4E15BD5B4
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 22:25:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229612AbiISUZF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 16:25:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229652AbiISUYy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 16:24:54 -0400
Received: from polaris.svanheule.net (polaris.svanheule.net [84.16.241.116])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B484BB7FE
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 13:24:50 -0700 (PDT)
Received: from terra.. (unknown [109.129.72.247])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sander@svanheule.net)
        by polaris.svanheule.net (Postfix) with ESMTPSA id 944C8321014;
        Mon, 19 Sep 2022 22:24:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svanheule.net;
        s=mail1707; t=1663619088;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7Zp/fML4R6bQWK2xw8NhbgkdHX48WYjlXlybyIsOCjE=;
        b=AUFX1h3OGrrsXN2DjukyUi6MVAJanQ6CzrbJ/tednftY6faVowjdRogxbgGhzaBL2x8Qmz
        JnX6zAlwyiSJPsEpo4EMFfU7Rznv6ZOQvkkXhFz84TtiCNj9Dt5WN4xSZXapTOkLitRb/y
        KnXRPoeNlYsLnLEvM/7Tc7GYYdz2+TDP05m0+tXt4fIIb5vsDuihQg0kUwZ8/ULpIyBCdT
        qqSvfIhq2M9YlCBqJsy8c98iOQXmJqhfEHgUEY0jYj78W6sKTsbGWe3sQ3c/Lu6cODVEMR
        +h7ZzUUImXb9D4z25GoMopK+ZrONzatLS4/AO1xDZF5ABIYZy8yI8GQi0IvKMQ==
From:   Sander Vanheule <sander@svanheule.net>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Sander Vanheule <sander@svanheule.net>
Subject: [PATCH v6 2/3] dt-bindings: interrupt-controller: realtek,rtl-intc: require parents
Date:   Mon, 19 Sep 2022 22:24:42 +0200
Message-Id: <ba3ae8e521ef82dd94f18a602ef53078f4a0d8d5.1663617425.git.sander@svanheule.net>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <cover.1663617425.git.sander@svanheule.net>
References: <cover.1663617425.git.sander@svanheule.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The interrupt router has 32 inputs, and up to 15 outputs connected to
the MIPS CPU's interrupts. The way these are mapped to each other is
runtime configurable. This controller can also mask individual interrupt
sources, and has a status register to indicate pending interrupts. This
means the controller is not transparent, and the use of "interrupt-map"
inappropriate. Instead, a list of parent interrupts should be specified.

Two-part compatibles are introduced to be able to require "interrupts"
for new devicetrees. For backward compatibility "interrupt-map" is still
allowed on these new compatibles, but deprecated. The old compatible,
with required "interrupt-map" and "#address-cells", is also deprecated.
The relevant descriptions are added or extended to more clearly describe
the functionality of this controller.

To prevent spurious changes to the binding when more SoCs are added,
"allOf" is used with one "if", and the compatible enum only has one
item.

The example is updated to provide a correct example for RTL8380 SoCs.

Signed-off-by: Sander Vanheule <sander@svanheule.net>
---
Changes in v6:
- Allow interrupt-map for backwards compatibility, but mark as
  deprecated.
- Update commit message to explain forward/backward compatibility
- Drop Rob's Reviewed-by because of above changes

Changes in v5:
- Add Rob's Reviewed-by

Changes in v4:
- Indicate more clearly that the controller is not transparent.
---
 .../realtek,rtl-intc.yaml                     | 60 ++++++++++++++-----
 1 file changed, 45 insertions(+), 15 deletions(-)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/realtek,rtl-intc.yaml b/Documentation/devicetree/bindings/interrupt-controller/realtek,rtl-intc.yaml
index 9e76fff20323..13a893b18fb6 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/realtek,rtl-intc.yaml
+++ b/Documentation/devicetree/bindings/interrupt-controller/realtek,rtl-intc.yaml
@@ -6,6 +6,14 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
 
 title: Realtek RTL SoC interrupt controller devicetree bindings
 
+description:
+  Interrupt controller and router for Realtek MIPS SoCs, allowing each SoC
+  interrupt to be routed to one parent CPU (hardware) interrupt, or left
+  disconnected.
+  All connected input lines from SoC peripherals can be masked individually,
+  and an interrupt status register is present to indicate which interrupts are
+  pending.
+
 maintainers:
   - Birger Koblitz <mail@birger-koblitz.de>
   - Bert Vermeulen <bert@biot.com>
@@ -13,23 +21,33 @@ maintainers:
 
 properties:
   compatible:
-    const: realtek,rtl-intc
+    oneOf:
+      - items:
+          - enum:
+              - realtek,rtl8380-intc
+          - const: realtek,rtl-intc
+      - const: realtek,rtl-intc
+        deprecated: true
 
   "#interrupt-cells":
+    description:
+      SoC interrupt line index.
     const: 1
 
   reg:
     maxItems: 1
 
   interrupts:
-    maxItems: 1
+    minItems: 1
+    maxItems: 15
+    description:
+      List of parent interrupts, in the order that they are connected to this
+      interrupt router's outputs, starting at the first output.
 
   interrupt-controller: true
 
-  "#address-cells":
-    const: 0
-
   interrupt-map:
+    deprecated: true
     description: Describes mapping from SoC interrupts to CPU interrupts
 
 required:
@@ -37,21 +55,33 @@ required:
   - reg
   - "#interrupt-cells"
   - interrupt-controller
-  - "#address-cells"
-  - interrupt-map
+
+allOf:
+  - if:
+      properties:
+        compatible:
+          const: realtek,rtl-intc
+    then:
+      properties:
+        "#address-cells":
+          const: 0
+      required:
+        - "#address-cells"
+        - interrupt-map
+    else:
+      required:
+        - interrupts
 
 additionalProperties: false
 
 examples:
   - |
-    intc: interrupt-controller@3000 {
-      compatible = "realtek,rtl-intc";
+    interrupt-controller@3000 {
+      compatible = "realtek,rtl8380-intc", "realtek,rtl-intc";
       #interrupt-cells = <1>;
       interrupt-controller;
-      reg = <0x3000 0x20>;
-      #address-cells = <0>;
-      interrupt-map =
-              <31 &cpuintc 2>,
-              <30 &cpuintc 1>,
-              <29 &cpuintc 5>;
+      reg = <0x3000 0x18>;
+
+      interrupt-parent = <&cpuintc>;
+      interrupts = <2>, <3>, <4>, <5>, <6>;
     };
-- 
2.37.3

