Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69A9364B5BC
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 14:06:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235477AbiLMNFW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 08:05:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235419AbiLMNFJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 08:05:09 -0500
Received: from sender4-op-o14.zoho.com (sender4-op-o14.zoho.com [136.143.188.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABF191DF2E;
        Tue, 13 Dec 2022 05:05:08 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1670936701; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=UN28AEnvakxlu8HdN3GamGKdatjoPskFemz4qp7FXIoUWsMnz5Ejz02QuLt65Fy+2mNdD2650ZJ7ALMkwatu1usyfAWCjBLlvFsdzobIT/xl0S7bn/bwxybM9IIXrxuRjqW3w+GT6Ftm6nWUl74VRsowYcBloDy8X9I+t2FTWpQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1670936701; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=4NWg4L4e7gMtf1qz2fIgp9UPi7DAAzsBAd4S1EFIjMA=; 
        b=f2FyywFOuR132lONRkp8mPMbj1gBq+bybkO8h4KwbZxMIlcnEJKiMf7WMxInVIyBkqaG1nO01I+rGntnY2RFHY3vWOxrNHsU7dW+nDR66NK/hJ7afnp74Kl2/DoPTz9zNXy1WP8W4xfreVr0wozEOJGrjuU9ukN5tvDd60oCwuQ=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=arinc9.com;
        spf=pass  smtp.mailfrom=arinc.unal@arinc9.com;
        dmarc=pass header.from=<arinc.unal@arinc9.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1670936701;
        s=zmail; d=arinc9.com; i=arinc.unal@arinc9.com;
        h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:In-Reply-To:References:MIME-Version:Content-Type:Content-Transfer-Encoding:Reply-To;
        bh=4NWg4L4e7gMtf1qz2fIgp9UPi7DAAzsBAd4S1EFIjMA=;
        b=fQPr+zzET7V9sX9DED8LDNm4VGcd2CH5a+l8hPPLGH+UNmbyyNWkzp1Nc1a+Wo5o
        YpBKxoyl3ncSK8SoaY9pc0xvQ7638mKwPWPSRFSoqlEy8qB+P/eIB3L4YzAa25w+oEd
        CHYynM5tI5ycqoFgy8Az5EMnzkklG3WMubUSGWEc=
Received: from arinc9-PC.lan (37.120.152.236 [37.120.152.236]) by mx.zohomail.com
        with SMTPS id 1670936699911841.8828768624544; Tue, 13 Dec 2022 05:04:59 -0800 (PST)
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
Subject: [PATCH 3/6] dt-bindings: pinctrl: mt7621: add proper function muxing binding
Date:   Tue, 13 Dec 2022 16:04:27 +0300
Message-Id: <20221213130430.172876-4-arinc.unal@arinc9.com>
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
 .../pinctrl/ralink,mt7621-pinctrl.yaml        | 204 +++++++++++++++++-
 1 file changed, 197 insertions(+), 7 deletions(-)

diff --git a/Documentation/devicetree/bindings/pinctrl/ralink,mt7621-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/ralink,mt7621-pinctrl.yaml
index 61e5c847e8c8..0efb03f1d88e 100644
--- a/Documentation/devicetree/bindings/pinctrl/ralink,mt7621-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/ralink,mt7621-pinctrl.yaml
@@ -29,21 +29,212 @@ patternProperties:
         $ref: pinmux-node.yaml#
 
         properties:
-          groups:
-            description: The pin group to select.
-            enum: [i2c, jtag, mdio, pcie, rgmii1, rgmii2, sdhci, spi, uart1,
-                   uart2, uart3, wdt]
-
           function:
-            description: The mux function to select.
+            description:
+              A string containing the name of the function to mux to the group.
             enum: [gpio, i2c, i2s, jtag, mdio, nand1, nand2, pcie refclk,
                    pcie rst, pcm, rgmii1, rgmii2, sdhci, spdif2, spdif3, spi,
                    uart1, uart2, uart3, wdt refclk, wdt rst]
 
+          groups:
+            description:
+              An array of strings. Each string contains the name of a group.
+
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
+                  enum: [i2c, jtag, mdio, pcie, rgmii1, rgmii2, sdhci, spi,
+                         uart1, uart2, uart3, wdt]
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
+                  enum: [uart3]
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
+                  const: mdio
+            then:
+              properties:
+                groups:
+                  enum: [mdio]
+
+          - if:
+              properties:
+                function:
+                  const: nand1
+            then:
+              properties:
+                groups:
+                  enum: [spi]
+
+          - if:
+              properties:
+                function:
+                  const: nand2
+            then:
+              properties:
+                groups:
+                  enum: [sdhci]
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
+                  enum: [uart2]
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
+                  const: sdhci
+            then:
+              properties:
+                groups:
+                  enum: [sdhci]
+
+          - if:
+              properties:
+                function:
+                  const: spdif2
+            then:
+              properties:
+                groups:
+                  enum: [uart2]
+
+          - if:
+              properties:
+                function:
+                  const: spdif3
+            then:
+              properties:
+                groups:
+                  enum: [uart3]
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
+                  const: uart3
+            then:
+              properties:
+                groups:
+                  enum: [uart3]
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
         additionalProperties: false
 
     additionalProperties: false
@@ -57,7 +248,6 @@ required:
 additionalProperties: false
 
 examples:
-  # Pinmux controller node
   - |
     pinctrl {
       compatible = "ralink,mt7621-pinctrl";
-- 
2.37.2

