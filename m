Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9554D64B5AE
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 14:06:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234631AbiLMNFr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 08:05:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235468AbiLMNFU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 08:05:20 -0500
Received: from sender4-op-o14.zoho.com (sender4-op-o14.zoho.com [136.143.188.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B11AD1F62D;
        Tue, 13 Dec 2022 05:05:16 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1670936709; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=jZCp1JGpjSxsQkzHqY6VhYZIzGESdKIZDvWiFaqzRUuH4p/mL5xl3fnfo4YmW7sqG4NBeKh/kdwvdfanuGfOGNckKHVTPrrvbGWGBy56eWnTF/t7vCNuNbJR5uF4Ofg/JzljsSsYDv+JxKAvxUejtD4qiGlpON52ynOkCeXlbuE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1670936709; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=gu/6BNrbZp9njCa8iLIpe9m+ZmHNz+PxLqalouL2mRo=; 
        b=AL/DZPEGQoG28FVKwpxNQDiPecaE9gHB52iEIU3CSO9SehWiW8e8iapeR4i6SsjxYONO37q5tCR3VLHfu4B5+YUd2BqnlKFBMVjWZMFwWnmSYpuLCqcDKMEmUtyzbsLpPEzhFUAFGRpXDUbGF6lO5Bft+rqJ4CISSq+Tk2pNy74=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=arinc9.com;
        spf=pass  smtp.mailfrom=arinc.unal@arinc9.com;
        dmarc=pass header.from=<arinc.unal@arinc9.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1670936709;
        s=zmail; d=arinc9.com; i=arinc.unal@arinc9.com;
        h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:In-Reply-To:References:MIME-Version:Content-Type:Content-Transfer-Encoding:Reply-To;
        bh=gu/6BNrbZp9njCa8iLIpe9m+ZmHNz+PxLqalouL2mRo=;
        b=U7DaW1cX0FF5vbrGnWQYU/HTsJSyrpIbEuJQfSd8meNOROvM9ohpx/m56itzyQ2v
        v2pEKk8/l3QyYAtE22zcT2PXOePbWVdhwf5LqiuqOEjaSJ5H4WZ9CMzjR/fOIhXTKy1
        4pME8xg/n8mmb10rPNTK+2sQkX7MjCwNFYB956mk=
Received: from arinc9-PC.lan (37.120.152.236 [37.120.152.236]) by mx.zohomail.com
        with SMTPS id 1670936707079394.1052154066318; Tue, 13 Dec 2022 05:05:07 -0800 (PST)
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
Subject: [PATCH 5/6] dt-bindings: pinctrl: rt305x: add proper function muxing binding
Date:   Tue, 13 Dec 2022 16:04:29 +0300
Message-Id: <20221213130430.172876-6-arinc.unal@arinc9.com>
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
 .../pinctrl/ralink,rt305x-pinctrl.yaml        | 235 ++++++++++++++++--
 1 file changed, 210 insertions(+), 25 deletions(-)

diff --git a/Documentation/devicetree/bindings/pinctrl/ralink,rt305x-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/ralink,rt305x-pinctrl.yaml
index f602a5d6e13a..30779a1a90b0 100644
--- a/Documentation/devicetree/bindings/pinctrl/ralink,rt305x-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/ralink,rt305x-pinctrl.yaml
@@ -30,38 +30,224 @@ patternProperties:
         $ref: pinmux-node.yaml#
 
         properties:
-          groups:
-            description: The pin group to select.
-            enum: [
-              # common
-              i2c, jtag, led, mdio, rgmii, spi, spi_cs1, uartf, uartlite,
-
-              # For RT3050, RT3052 and RT3350 SoCs
-              sdram,
-
-              # For RT3352 SoC
-              lna, pa
-            ]
-
           function:
-            description: The mux function to select.
-            enum: [
-              # common
-              gpio, gpio i2s, gpio uartf, i2c, i2s uartf, jtag, led, mdio,
-              pcm gpio, pcm i2s, pcm uartf, rgmii, spi, spi_cs1, uartf,
-              uartlite, wdg_cs1,
+            description:
+              A string containing the name of the function to mux to the group.
+            anyOf:
+              - description: For RT3050, RT3052 and RT3350 SoCs
+                enum: [gpio, gpio i2s, gpio uartf, i2c, i2s uartf, jtag, mdio,
+                       pcm gpio, pcm i2s, pcm uartf, rgmii, sdram, spi, uartf,
+                       uartlite]
 
-              # For RT3050, RT3052 and RT3350 SoCs
-              sdram,
+              - description: For RT3352 SoC
+                enum: [gpio, gpio i2s, gpio uartf, i2c, i2s uartf, jtag, led,
+                       lna, mdio, pa, pcm gpio, pcm i2s, pcm uartf, rgmii, spi,
+                       spi_cs1, uartf, uartlite, wdg_cs1]
 
-              # For RT3352 SoC
-              lna, pa
-            ]
+              - description: For RT5350 SoC
+                enum: [gpio, gpio i2s, gpio uartf, i2c, i2s uartf, jtag, led,
+                       pcm gpio, pcm i2s, pcm uartf, spi, spi_cs1, uartf,
+                       uartlite, wdg_cs1]
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
+                  const: gpio
+            then:
+              properties:
+                groups:
+                  oneOf:
+                    - description: For RT3050, RT3052 and RT3350 SoCs
+                      enum: [i2c, jtag, mdio, rgmii, sdram, spi, uartf,
+                             uartlite]
+
+                    - description: For RT3352 SoC
+                      enum: [i2c, jtag, led, lna, mdio, pa, rgmii, spi, spi_cs1,
+                             uartf, uartlite]
+
+                    - description: For RT5350 SoC
+                      enum: [i2c, jtag, led, spi, spi_cs1, uartf, uartlite]
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
+                  enum: [jtag]
+
+          - if:
+              properties:
+                function:
+                  const: led
+            then:
+              properties:
+                groups:
+                  enum: [led]
+
+          - if:
+              properties:
+                function:
+                  const: lna
+            then:
+              properties:
+                groups:
+                  enum: [lna]
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
+                  const: pa
+            then:
+              properties:
+                groups:
+                  enum: [pa]
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
+                  const: rgmii
+            then:
+              properties:
+                groups:
+                  enum: [rgmii]
+
+          - if:
+              properties:
+                function:
+                  const: sdram
+            then:
+              properties:
+                groups:
+                  enum: [sdram]
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
+                  const: spi_cs1
+            then:
+              properties:
+                groups:
+                  enum: [spi_cs1]
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
+                  const: wdg_cs1
+            then:
+              properties:
+                groups:
+                  enum: [spi_cs1]
+
         additionalProperties: false
 
     additionalProperties: false
@@ -75,7 +261,6 @@ required:
 additionalProperties: false
 
 examples:
-  # Pinmux controller node
   - |
     pinctrl {
       compatible = "ralink,rt305x-pinctrl";
-- 
2.37.2

