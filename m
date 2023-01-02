Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14EC865B78C
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Jan 2023 23:18:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233250AbjABWSg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 17:18:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbjABWSa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 17:18:30 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 448399594;
        Mon,  2 Jan 2023 14:18:28 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id h16so27533793wrz.12;
        Mon, 02 Jan 2023 14:18:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+0wFxbOlh8ICvHtgsIDG7wS5Sd+zVzWOdtiA01uzC98=;
        b=oISt4CZnewFhvfxu9saSqH/zyEvlYbeYeAIwyEiaS60AqYQKFIWQe6fKy0j1AcJlpn
         MZvcKbaUAOkKOTvueq92OpsB+SCfB8mERk/T3Xgqhdef8C3ZmV7Fr+4EJ/Wqfw9Xg5sR
         OzDHgJtaqLlvg5mEwg9n0NUVJrb+EqQhmX9QimBpT5qbTxtjZFP3084T1Se7UNIN7oTG
         e1ELPKzdA3VthAdW2t+uClB9KlWYcRv/rxb7yPBMJFA6xUQWhn7mG5sbQ2Ax3msMQl8H
         +iKYp6yg9p7iW1VqUJ2NbYwUPFHvacfnHIq2PYRYXBp401V/Exdo08STAO0V56UC2VuF
         Jzng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+0wFxbOlh8ICvHtgsIDG7wS5Sd+zVzWOdtiA01uzC98=;
        b=sBlVN3Hu+Xm65Kq7+Od0XhKS0wGnVNSHnNT8kG8zNIZvSDdoKeF7mH0JddRpwYsERW
         PV/1JKZ5kgeM4MEdqYUiE+03kp5KQLtatevuXlakTOJTrZQdnFjrR069mMFodaiYYzSj
         CnuIFXR46AtfuHM7B05GT5jEYpD+o3MsyOsqkga1Gg+kZXS72uix5xtoK9nBDm3VXjQa
         UsDN73EqhrrlaTmZNn+r5VaF2oAGP6CbhpxQtuOJZJ/JkbrvOTegwU80O4n0bzk4tTqv
         mRyiHLABZCjdenUKcZLiswgAgolvAHE/4oPcyA4uVON+lUG7tEnIYSGuUWE3XkmwgLbM
         aE3w==
X-Gm-Message-State: AFqh2krHW0TlywO7d23Z/WLZybFw5iO6VSrM77chpFgbVStZjKRYMikc
        rFRw/N+JO9PHAoQgn9xy/3I=
X-Google-Smtp-Source: AMrXdXsvL1E8MXmdNnp+4PhH9I+be+FqV2ZQc2MWMuw6stdpcLjG4NavPR46ukE3BpKXnkOguohK+Q==
X-Received: by 2002:adf:f14c:0:b0:26f:63ec:eb79 with SMTP id y12-20020adff14c000000b0026f63eceb79mr33302603wro.50.1672697906786;
        Mon, 02 Jan 2023 14:18:26 -0800 (PST)
Received: from prasmi.home ([2a00:23c8:2501:c701:8a7:e535:b020:566a])
        by smtp.gmail.com with ESMTPSA id n14-20020adfe34e000000b002366dd0e030sm29872463wrj.68.2023.01.02.14.18.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Jan 2023 14:18:26 -0800 (PST)
From:   Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, linux-gpio@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH v3 1/6] dt-bindings: interrupt-controller: renesas,rzg2l-irqc: Document RZ/G2UL SoC
Date:   Mon,  2 Jan 2023 22:18:10 +0000
Message-Id: <20230102221815.273719-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230102221815.273719-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20230102221815.273719-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Document RZ/G2UL (R9A07G043U) IRQC bindings. The IRQC block on RZ/G2UL SoC
is almost identical to one found on the RZ/G2L SoC the only difference
being it can support BUS_ERR_INT for which it has additional registers.
Hence new generic compatible string "renesas,r9a07g043u-irqc" is added
for RZ/G2UL SoC.

Now that we have additional interrupt for RZ/G2UL and RZ/Five SoC
interrupt-names property is added so that we can parse them based on
names.

While at it updated the example node to four spaces and added
interrupt-names property.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
v2->v3
* Dropped RZ/G2UL specific string

v1- > v2
* Dropped RB tags
* Added generic compatible string for rzg2ul
* Added interrupt-names
* Added checks for RZ/G2UL to make sure interrupts are 42 and interrupt-names
* Updated example node with interrupt-names
* Used 4 spaces for example node
---
 .../renesas,rzg2l-irqc.yaml                   | 225 +++++++++++++-----
 1 file changed, 170 insertions(+), 55 deletions(-)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/renesas,rzg2l-irqc.yaml b/Documentation/devicetree/bindings/interrupt-controller/renesas,rzg2l-irqc.yaml
index 33b90e975e33..fc900ce2fe0a 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/renesas,rzg2l-irqc.yaml
+++ b/Documentation/devicetree/bindings/interrupt-controller/renesas,rzg2l-irqc.yaml
@@ -19,13 +19,11 @@ description: |
     - NMI edge select (NMI is not treated as NMI exception and supports fall edge and
       stand-up edge detection interrupts)
 
-allOf:
-  - $ref: /schemas/interrupt-controller.yaml#
-
 properties:
   compatible:
     items:
       - enum:
+          - renesas,r9a07g043u-irqc   # RZ/G2UL
           - renesas,r9a07g044-irqc    # RZ/G2{L,LC}
           - renesas,r9a07g054-irqc    # RZ/V2L
       - const: renesas,rzg2l-irqc
@@ -44,7 +42,96 @@ properties:
     maxItems: 1
 
   interrupts:
-    maxItems: 41
+    minItems: 41
+    items:
+      - description: NMI interrupt
+      - description: IRQ0 interrupt
+      - description: IRQ1 interrupt
+      - description: IRQ2 interrupt
+      - description: IRQ3 interrupt
+      - description: IRQ4 interrupt
+      - description: IRQ5 interrupt
+      - description: IRQ6 interrupt
+      - description: IRQ7 interrupt
+      - description: GPIO interrupt, TINT0
+      - description: GPIO interrupt, TINT1
+      - description: GPIO interrupt, TINT2
+      - description: GPIO interrupt, TINT3
+      - description: GPIO interrupt, TINT4
+      - description: GPIO interrupt, TINT5
+      - description: GPIO interrupt, TINT6
+      - description: GPIO interrupt, TINT7
+      - description: GPIO interrupt, TINT8
+      - description: GPIO interrupt, TINT9
+      - description: GPIO interrupt, TINT10
+      - description: GPIO interrupt, TINT11
+      - description: GPIO interrupt, TINT12
+      - description: GPIO interrupt, TINT13
+      - description: GPIO interrupt, TINT14
+      - description: GPIO interrupt, TINT15
+      - description: GPIO interrupt, TINT16
+      - description: GPIO interrupt, TINT17
+      - description: GPIO interrupt, TINT18
+      - description: GPIO interrupt, TINT19
+      - description: GPIO interrupt, TINT20
+      - description: GPIO interrupt, TINT21
+      - description: GPIO interrupt, TINT22
+      - description: GPIO interrupt, TINT23
+      - description: GPIO interrupt, TINT24
+      - description: GPIO interrupt, TINT25
+      - description: GPIO interrupt, TINT26
+      - description: GPIO interrupt, TINT27
+      - description: GPIO interrupt, TINT28
+      - description: GPIO interrupt, TINT29
+      - description: GPIO interrupt, TINT30
+      - description: GPIO interrupt, TINT31
+      - description: Bus error interrupt
+
+  interrupt-names:
+    minItems: 41
+    items:
+      - const: nmi
+      - const: irq0
+      - const: irq1
+      - const: irq2
+      - const: irq3
+      - const: irq4
+      - const: irq5
+      - const: irq6
+      - const: irq7
+      - const: tint0
+      - const: tint1
+      - const: tint2
+      - const: tint3
+      - const: tint4
+      - const: tint5
+      - const: tint6
+      - const: tint7
+      - const: tint8
+      - const: tint9
+      - const: tint10
+      - const: tint11
+      - const: tint12
+      - const: tint13
+      - const: tint14
+      - const: tint15
+      - const: tint16
+      - const: tint17
+      - const: tint18
+      - const: tint19
+      - const: tint20
+      - const: tint21
+      - const: tint22
+      - const: tint23
+      - const: tint24
+      - const: tint25
+      - const: tint26
+      - const: tint27
+      - const: tint28
+      - const: tint29
+      - const: tint30
+      - const: tint31
+      - const: bus-err
 
   clocks:
     maxItems: 2
@@ -72,6 +159,23 @@ required:
   - power-domains
   - resets
 
+allOf:
+  - $ref: /schemas/interrupt-controller.yaml#
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: renesas,r9a07g043u-irqc
+    then:
+      properties:
+        interrupts:
+          minItems: 42
+        interrupt-names:
+          minItems: 42
+      required:
+        - interrupt-names
+
 unevaluatedProperties: false
 
 examples:
@@ -80,55 +184,66 @@ examples:
     #include <dt-bindings/clock/r9a07g044-cpg.h>
 
     irqc: interrupt-controller@110a0000 {
-            compatible = "renesas,r9a07g044-irqc", "renesas,rzg2l-irqc";
-            reg = <0x110a0000 0x10000>;
-            #interrupt-cells = <2>;
-            #address-cells = <0>;
-            interrupt-controller;
-            interrupts = <GIC_SPI 0 IRQ_TYPE_LEVEL_HIGH>,
-                         <GIC_SPI 1 IRQ_TYPE_LEVEL_HIGH>,
-                         <GIC_SPI 2 IRQ_TYPE_LEVEL_HIGH>,
-                         <GIC_SPI 3 IRQ_TYPE_LEVEL_HIGH>,
-                         <GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>,
-                         <GIC_SPI 5 IRQ_TYPE_LEVEL_HIGH>,
-                         <GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>,
-                         <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>,
-                         <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>,
-                         <GIC_SPI 444 IRQ_TYPE_LEVEL_HIGH>,
-                         <GIC_SPI 445 IRQ_TYPE_LEVEL_HIGH>,
-                         <GIC_SPI 446 IRQ_TYPE_LEVEL_HIGH>,
-                         <GIC_SPI 447 IRQ_TYPE_LEVEL_HIGH>,
-                         <GIC_SPI 448 IRQ_TYPE_LEVEL_HIGH>,
-                         <GIC_SPI 449 IRQ_TYPE_LEVEL_HIGH>,
-                         <GIC_SPI 450 IRQ_TYPE_LEVEL_HIGH>,
-                         <GIC_SPI 451 IRQ_TYPE_LEVEL_HIGH>,
-                         <GIC_SPI 452 IRQ_TYPE_LEVEL_HIGH>,
-                         <GIC_SPI 453 IRQ_TYPE_LEVEL_HIGH>,
-                         <GIC_SPI 454 IRQ_TYPE_LEVEL_HIGH>,
-                         <GIC_SPI 455 IRQ_TYPE_LEVEL_HIGH>,
-                         <GIC_SPI 456 IRQ_TYPE_LEVEL_HIGH>,
-                         <GIC_SPI 457 IRQ_TYPE_LEVEL_HIGH>,
-                         <GIC_SPI 458 IRQ_TYPE_LEVEL_HIGH>,
-                         <GIC_SPI 459 IRQ_TYPE_LEVEL_HIGH>,
-                         <GIC_SPI 460 IRQ_TYPE_LEVEL_HIGH>,
-                         <GIC_SPI 461 IRQ_TYPE_LEVEL_HIGH>,
-                         <GIC_SPI 462 IRQ_TYPE_LEVEL_HIGH>,
-                         <GIC_SPI 463 IRQ_TYPE_LEVEL_HIGH>,
-                         <GIC_SPI 464 IRQ_TYPE_LEVEL_HIGH>,
-                         <GIC_SPI 465 IRQ_TYPE_LEVEL_HIGH>,
-                         <GIC_SPI 466 IRQ_TYPE_LEVEL_HIGH>,
-                         <GIC_SPI 467 IRQ_TYPE_LEVEL_HIGH>,
-                         <GIC_SPI 468 IRQ_TYPE_LEVEL_HIGH>,
-                         <GIC_SPI 469 IRQ_TYPE_LEVEL_HIGH>,
-                         <GIC_SPI 470 IRQ_TYPE_LEVEL_HIGH>,
-                         <GIC_SPI 471 IRQ_TYPE_LEVEL_HIGH>,
-                         <GIC_SPI 472 IRQ_TYPE_LEVEL_HIGH>,
-                         <GIC_SPI 473 IRQ_TYPE_LEVEL_HIGH>,
-                         <GIC_SPI 474 IRQ_TYPE_LEVEL_HIGH>,
-                         <GIC_SPI 475 IRQ_TYPE_LEVEL_HIGH>;
-            clocks = <&cpg CPG_MOD R9A07G044_IA55_CLK>,
-                     <&cpg CPG_MOD R9A07G044_IA55_PCLK>;
-            clock-names = "clk", "pclk";
-            power-domains = <&cpg>;
-            resets = <&cpg R9A07G044_IA55_RESETN>;
+        compatible = "renesas,r9a07g044-irqc", "renesas,rzg2l-irqc";
+        reg = <0x110a0000 0x10000>;
+        #interrupt-cells = <2>;
+        #address-cells = <0>;
+        interrupt-controller;
+        interrupts = <GIC_SPI 0 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 1 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 2 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 3 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 5 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 444 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 445 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 446 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 447 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 448 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 449 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 450 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 451 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 452 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 453 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 454 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 455 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 456 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 457 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 458 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 459 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 460 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 461 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 462 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 463 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 464 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 465 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 466 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 467 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 468 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 469 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 470 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 471 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 472 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 473 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 474 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 475 IRQ_TYPE_LEVEL_HIGH>;
+        interrupt-names = "nmi",
+                          "irq0", "irq1", "irq2", "irq3",
+                          "irq4", "irq5", "irq6", "irq7",
+                          "tint0", "tint1", "tint2", "tint3",
+                          "tint4", "tint5", "tint6", "tint7",
+                          "tint8", "tint9", "tint10", "tint11",
+                          "tint12", "tint13", "tint14", "tint15",
+                          "tint16", "tint17", "tint18", "tint19",
+                          "tint20", "tint21", "tint22", "tint23",
+                          "tint24", "tint25", "tint26", "tint27",
+                          "tint28", "tint29", "tint30", "tint31";
+        clocks = <&cpg CPG_MOD R9A07G044_IA55_CLK>,
+                 <&cpg CPG_MOD R9A07G044_IA55_PCLK>;
+        clock-names = "clk", "pclk";
+        power-domains = <&cpg>;
+        resets = <&cpg R9A07G044_IA55_RESETN>;
     };
-- 
2.25.1

