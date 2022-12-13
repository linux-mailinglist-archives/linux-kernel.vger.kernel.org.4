Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A40364B5AD
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 14:06:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234934AbiLMNFR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 08:05:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235403AbiLMNFJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 08:05:09 -0500
Received: from sender4-op-o14.zoho.com (sender4-op-o14.zoho.com [136.143.188.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E98921DF19;
        Tue, 13 Dec 2022 05:05:07 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1670936699; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=Z6ZDWutsm05abJl/WI0ISJqCqIpODUCMPr+EjriadotFkq+LcWFsdBC6KVZi1l1i2XBwdLY57TdyT5h4TtMro9NhWw0ibvw8mN9SSOblFGFwzSvSwLanUjgPaBMc+ljR113Hg9EZWKLbj/rEyVaOWrAmav/keHCpxxgdM6TSHow=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1670936699; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=dR6Q4QOPDzbeauoB+9/LiC7PLplhLZ75NkuuNY2Juzc=; 
        b=JHB6UTgBzkXdDUuguVeXEx++AvLSdQ69LTkEUrARLQZQt1n7xykB4jTvfmXZ1B5MuuAwVm21Lf6MGk3wy71xB5qf/FCiibsBKGFEeZadr68pFTr7fYIE3R5Js0cdGRh1eUmApyUg4aB8m+eqYTW/oyH6kBpfVLSrCRexn1d9sIk=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=arinc9.com;
        spf=pass  smtp.mailfrom=arinc.unal@arinc9.com;
        dmarc=pass header.from=<arinc.unal@arinc9.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1670936699;
        s=zmail; d=arinc9.com; i=arinc.unal@arinc9.com;
        h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:In-Reply-To:References:MIME-Version:Content-Type:Content-Transfer-Encoding:Reply-To;
        bh=dR6Q4QOPDzbeauoB+9/LiC7PLplhLZ75NkuuNY2Juzc=;
        b=GKoXPU0nRtbmEOt1qGEkEGegqxARIYskiG056MP3wjbqRIuV7RaX8NtjpZX34Jcp
        dF4+H4Qn5nRtPxGdHySgzz6x0T/hlA5joZT8J2pQfTfuTIOis0FFbxUhwy4g3tiYFZo
        urphvZBweldecs/3p/35IPyfYPOCVUtz3M5J+How=
Received: from arinc9-PC.lan (37.120.152.236 [37.120.152.236]) by mx.zohomail.com
        with SMTPS id 1670936696361349.29194398961965; Tue, 13 Dec 2022 05:04:56 -0800 (PST)
From:   =?UTF-8?q?Ar=C4=B1n=C3=A7=20=C3=9CNAL?= <arinc.unal@arinc9.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Sergio Paracuellos <sergio.paracuellos@gmail.com>,
        Luiz Angelo Daros de Luca <luizluca@gmail.com>
Cc:     =?UTF-8?q?Ar=C4=B1n=C3=A7=20=C3=9CNAL?= <arinc.unal@arinc9.com>,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mips@vger.kernel.org
Subject: [PATCH 2/6] dt-bindings: pinctrl: mt7620: add proper function muxing binding
Date:   Tue, 13 Dec 2022 16:04:26 +0300
Message-Id: <20221213130430.172876-3-arinc.unal@arinc9.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20221213130430.172876-1-arinc.unal@arinc9.com>
References: <20221213130430.172876-1-arinc.unal@arinc9.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Not every function can be muxed to a group. Add proper binding which
documents which function can be muxed to a group or set of groups.

Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
---
 .../pinctrl/ralink,mt7620-pinctrl.yaml        | 632 +++++++++++++++++-
 1 file changed, 596 insertions(+), 36 deletions(-)

diff --git a/Documentation/devicetree/bindings/pinctrl/ralink,mt7620-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/ralink,mt7620-pinctrl.yaml
index 6f17f3991640..06880c80ba80 100644
--- a/Documentation/devicetree/bindings/pinctrl/ralink,mt7620-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/ralink,mt7620-pinctrl.yaml
@@ -29,47 +29,608 @@ patternProperties:
         $ref: pinmux-node.yaml#
 
         properties:
-          groups:
-            description: The pin group to select.
-            enum: [
-              # common
-              i2c, spi, wdt,
-
-              # For MT7620 SoC
-              ephy, mdio, nd_sd, pa, pcie, rgmii1, rgmii2, spi refclk,
-              uartf, uartlite, wled,
-
-              # For MT7628 and MT7688 SoCs
-              gpio, i2s, p0led_an, p0led_kn, p1led_an, p1led_kn, p2led_an,
-              p2led_kn, p3led_an, p3led_kn, p4led_an, p4led_kn, perst, pwm0,
-              pwm1, refclk, sdmode, spi cs1, spis, uart0, uart1, uart2,
-              wled_an, wled_kn,
-            ]
-
           function:
-            description: The mux function to select.
-            enum: [
-              # common
-              gpio, i2c, refclk, spi,
-
-              # For MT7620 SoC
-              ephy, gpio i2s, gpio uartf, i2s uartf, mdio, nand, pa,
-              pcie refclk, pcie rst, pcm gpio, pcm i2s, pcm uartf,
-              rgmii1, rgmii2, sd, spi refclk, uartf, uartlite, wdt refclk,
-              wdt rst, wled,
-
-              # For MT7628 and MT7688 SoCs
-              antenna, debug, i2s, jtag, p0led_an, p0led_kn,
-              p1led_an, p1led_kn, p2led_an, p2led_kn, p3led_an, p3led_kn,
-              p4led_an, p4led_kn, pcie, pcm, perst, pwm, pwm0, pwm1, pwm_uart2,
-              rsvd, sdxc, sdxc d5 d4, sdxc d6, sdxc d7, spi cs1,
-              spis, sw_r, uart0, uart1, uart2, utif, wdt, wled_an, wled_kn, -,
-            ]
+            description:
+              A string containing the name of the function to mux to the group.
+            anyOf:
+              - description: For MT7620 SoC
+                enum: [ephy, gpio, gpio i2s, gpio uartf, i2c, i2s uartf, mdio, nand, pa,
+                       pcie refclk, pcie rst, pcm gpio, pcm i2s, pcm uartf, refclk,
+                       rgmii1, rgmii2, sd, spi, spi refclk, uartf, uartlite, wdt refclk,
+                       wdt rst, wled]
+
+              - description: For MT7628 and MT7688 SoCs
+                enum: [antenna, debug, gpio, i2c, i2s, jtag, p0led_an, p0led_kn,
+                       p1led_an, p1led_kn, p2led_an, p2led_kn, p3led_an, p3led_kn,
+                       p4led_an, p4led_kn, pcie, pcm, perst, pwm, pwm0, pwm1, pwm_uart2,
+                       refclk, rsvd, sdxc, sdxc d5 d4, sdxc d6, sdxc d7, spi, spi cs1,
+                       spis, sw_r, uart0, uart1, uart2, utif, wdt, wled_an, wled_kn, -]
+
+          groups:
+            description:
+              An array of strings. Each string contains the name of a group.
 
         required:
           - groups
           - function
 
+        allOf:
+          - if:
+              properties:
+                function:
+                  const: antenna
+            then:
+              properties:
+                groups:
+                  enum: [i2s]
+
+          - if:
+              properties:
+                function:
+                  const: debug
+            then:
+              properties:
+                groups:
+                  enum: [i2c]
+
+          - if:
+              properties:
+                function:
+                  const: ephy
+            then:
+              properties:
+                groups:
+                  enum: [ephy]
+
+          - if:
+              properties:
+                function:
+                  const: gpio
+            then:
+              properties:
+                groups:
+                  oneOf:
+                    - description: For MT7620 SoC
+                      enum: [ephy, i2c, mdio, nd_sd, pa, pcie, rgmii1, rgmii2,
+                             spi, spi refclk, uartf, uartlite, wdt, wled]
+
+                    - description: For MT7628 and MT7688 SoCs
+                      enum: [gpio, i2c, i2s, p0led_an, p0led_kn, p1led_an,
+                             p1led_kn, p2led_an, p2led_kn, p3led_an, p3led_kn,
+                             p4led_an, p4led_kn, perst, pwm0, pwm1, refclk,
+                             sdmode, spi, spi cs1, spis, uart0, uart1, uart2,
+                             wdt, wled_an, wled_kn]
+
+          - if:
+              properties:
+                function:
+                  const: gpio i2s
+            then:
+              properties:
+                groups:
+                  enum: [uartf]
+
+          - if:
+              properties:
+                function:
+                  const: gpio uartf
+            then:
+              properties:
+                groups:
+                  enum: [uartf]
+
+          - if:
+              properties:
+                function:
+                  const: i2c
+            then:
+              properties:
+                groups:
+                  enum: [i2c]
+
+          - if:
+              properties:
+                function:
+                  const: i2s
+            then:
+              properties:
+                groups:
+                  enum: [i2s]
+
+          - if:
+              properties:
+                function:
+                  const: i2s uartf
+            then:
+              properties:
+                groups:
+                  enum: [uartf]
+
+          - if:
+              properties:
+                function:
+                  const: jtag
+            then:
+              properties:
+                groups:
+                  enum: [p0led_an, p0led_kn, p1led_an, p1led_kn, p2led_an,
+                         p2led_kn, p3led_an, p3led_kn, p4led_an, p4led_kn,
+                         sdmode]
+
+          - if:
+              properties:
+                function:
+                  const: mdio
+            then:
+              properties:
+                groups:
+                  enum: [mdio]
+
+          - if:
+              properties:
+                function:
+                  const: nand
+            then:
+              properties:
+                groups:
+                  enum: [nd_sd]
+
+          - if:
+              properties:
+                function:
+                  const: p0led_an
+            then:
+              properties:
+                groups:
+                  enum: [p0led_an]
+
+          - if:
+              properties:
+                function:
+                  const: p0led_kn
+            then:
+              properties:
+                groups:
+                  enum: [p0led_kn]
+
+          - if:
+              properties:
+                function:
+                  const: p1led_an
+            then:
+              properties:
+                groups:
+                  enum: [p1led_an]
+
+          - if:
+              properties:
+                function:
+                  const: p1led_kn
+            then:
+              properties:
+                groups:
+                  enum: [p1led_kn]
+
+          - if:
+              properties:
+                function:
+                  const: p2led_an
+            then:
+              properties:
+                groups:
+                  enum: [p2led_an]
+
+          - if:
+              properties:
+                function:
+                  const: p2led_kn
+            then:
+              properties:
+                groups:
+                  enum: [p2led_kn]
+
+          - if:
+              properties:
+                function:
+                  const: p3led_an
+            then:
+              properties:
+                groups:
+                  enum: [p3led_an]
+
+          - if:
+              properties:
+                function:
+                  const: p3led_kn
+            then:
+              properties:
+                groups:
+                  enum: [p3led_kn]
+
+          - if:
+              properties:
+                function:
+                  const: p4led_an
+            then:
+              properties:
+                groups:
+                  enum: [p4led_an]
+
+          - if:
+              properties:
+                function:
+                  const: p4led_kn
+            then:
+              properties:
+                groups:
+                  enum: [p4led_kn]
+
+          - if:
+              properties:
+                function:
+                  const: pa
+            then:
+              properties:
+                groups:
+                  enum: [pa]
+
+          - if:
+              properties:
+                function:
+                  const: pcie
+            then:
+              properties:
+                groups:
+                  enum: [gpio]
+
+          - if:
+              properties:
+                function:
+                  const: pcie refclk
+            then:
+              properties:
+                groups:
+                  enum: [pcie]
+
+          - if:
+              properties:
+                function:
+                  const: pcie rst
+            then:
+              properties:
+                groups:
+                  enum: [pcie]
+
+          - if:
+              properties:
+                function:
+                  const: pcm
+            then:
+              properties:
+                groups:
+                  enum: [i2s]
+
+          - if:
+              properties:
+                function:
+                  const: pcm gpio
+            then:
+              properties:
+                groups:
+                  enum: [uartf]
+
+          - if:
+              properties:
+                function:
+                  const: pcm i2s
+            then:
+              properties:
+                groups:
+                  enum: [uartf]
+
+          - if:
+              properties:
+                function:
+                  const: pcm uartf
+            then:
+              properties:
+                groups:
+                  enum: [uartf]
+
+          - if:
+              properties:
+                function:
+                  const: perst
+            then:
+              properties:
+                groups:
+                  enum: [perst]
+
+          - if:
+              properties:
+                function:
+                  const: pwm
+            then:
+              properties:
+                groups:
+                  enum: [uart1, uart2]
+
+          - if:
+              properties:
+                function:
+                  const: pwm0
+            then:
+              properties:
+                groups:
+                  enum: [pwm0]
+
+          - if:
+              properties:
+                function:
+                  const: pwm1
+            then:
+              properties:
+                groups:
+                  enum: [pwm1]
+
+          - if:
+              properties:
+                function:
+                  const: pwm_uart2
+            then:
+              properties:
+                groups:
+                  enum: [spis]
+
+          - if:
+              properties:
+                function:
+                  const: refclk
+            then:
+              properties:
+                groups:
+                  oneOf:
+                    - description: For MT7620 SoC
+                      enum: [mdio]
+
+                    - description: For MT7628 and MT7688 SoCs
+                      enum: [gpio, refclk, spi cs1]
+
+          - if:
+              properties:
+                function:
+                  const: rgmii1
+            then:
+              properties:
+                groups:
+                  enum: [rgmii1]
+
+          - if:
+              properties:
+                function:
+                  const: rgmii2
+            then:
+              properties:
+                groups:
+                  enum: [rgmii2]
+
+          - if:
+              properties:
+                function:
+                  const: rsvd
+            then:
+              properties:
+                groups:
+                  enum: [p0led_an, p0led_kn, wled_an, wled_kn]
+
+          - if:
+              properties:
+                function:
+                  const: sd
+            then:
+              properties:
+                groups:
+                  enum: [nd_sd]
+
+          - if:
+              properties:
+                function:
+                  const: sdxc
+            then:
+              properties:
+                groups:
+                  enum: [sdmode]
+
+          - if:
+              properties:
+                function:
+                  const: sdxc d5 d4
+            then:
+              properties:
+                groups:
+                  enum: [uart2]
+
+          - if:
+              properties:
+                function:
+                  const: sdxc d6
+            then:
+              properties:
+                groups:
+                  enum: [pwm1]
+
+          - if:
+              properties:
+                function:
+                  const: sdxc d7
+            then:
+              properties:
+                groups:
+                  enum: [pwm0]
+
+          - if:
+              properties:
+                function:
+                  const: spi
+            then:
+              properties:
+                groups:
+                  enum: [spi]
+
+          - if:
+              properties:
+                function:
+                  const: spi cs1
+            then:
+              properties:
+                groups:
+                  enum: [spi cs1]
+
+          - if:
+              properties:
+                function:
+                  const: spi refclk
+            then:
+              properties:
+                groups:
+                  enum: [spi refclk]
+
+          - if:
+              properties:
+                function:
+                  const: spis
+            then:
+              properties:
+                groups:
+                  enum: [spis]
+
+          - if:
+              properties:
+                function:
+                  const: sw_r
+            then:
+              properties:
+                groups:
+                  enum: [uart1]
+
+          - if:
+              properties:
+                function:
+                  const: uart0
+            then:
+              properties:
+                groups:
+                  enum: [uart0]
+
+          - if:
+              properties:
+                function:
+                  const: uart1
+            then:
+              properties:
+                groups:
+                  enum: [uart1]
+
+          - if:
+              properties:
+                function:
+                  const: uart2
+            then:
+              properties:
+                groups:
+                  enum: [uart2]
+
+          - if:
+              properties:
+                function:
+                  const: uartf
+            then:
+              properties:
+                groups:
+                  enum: [uartf]
+
+          - if:
+              properties:
+                function:
+                  const: uartlite
+            then:
+              properties:
+                groups:
+                  enum: [uartlite]
+
+          - if:
+              properties:
+                function:
+                  const: utif
+            then:
+              properties:
+                groups:
+                  enum: [p1led_an, p1led_kn, p2led_an, p2led_kn, p3led_an,
+                         p3led_kn, p4led_an, p4led_kn, pwm0, pwm1, sdmode, spis]
+
+          - if:
+              properties:
+                function:
+                  const: wdt
+            then:
+              properties:
+                groups:
+                  enum: [wdt]
+
+          - if:
+              properties:
+                function:
+                  const: wdt refclk
+            then:
+              properties:
+                groups:
+                  enum: [wdt]
+
+          - if:
+              properties:
+                function:
+                  const: wdt rst
+            then:
+              properties:
+                groups:
+                  enum: [wdt]
+
+          - if:
+              properties:
+                function:
+                  const: wled
+            then:
+              properties:
+                groups:
+                  enum: [wled]
+
+          - if:
+              properties:
+                function:
+                  const: wled_an
+            then:
+              properties:
+                groups:
+                  enum: [wled_an]
+
+          - if:
+              properties:
+                function:
+                  const: wled_kn
+            then:
+              properties:
+                groups:
+                  enum: [wled_kn]
+
+          - if:
+              properties:
+                function:
+                  const: "-"
+            then:
+              properties:
+                groups:
+                  enum: [i2c, spi cs1, uart0]
+
         additionalProperties: false
 
     additionalProperties: false
@@ -83,7 +644,6 @@ required:
 additionalProperties: false
 
 examples:
-  # Pinmux controller node
   - |
     pinctrl {
       compatible = "ralink,mt7620-pinctrl";
-- 
2.37.2

