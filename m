Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D59BA64B5B7
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 14:06:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235157AbiLMNFx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 08:05:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235524AbiLMNFZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 08:05:25 -0500
Received: from sender4-op-o14.zoho.com (sender4-op-o14.zoho.com [136.143.188.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62EDE1F635;
        Tue, 13 Dec 2022 05:05:19 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1670936711; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=lDfKs5bqZhUBmIyQhmWyuIepKaXBbQAe1M/Tjo4qm1i69nwcgvvXdfLOPhDX1sMCEOgC7wATMzCvZxJM6wOSRkuKzij8jWrpH2ei3T/MNW7PyDP5KFD5wjR2HlqCSiSc/FjYbMW9r7hrNRhKL2Qbfs2HVKhUpNlw1Woy4Ykqqkk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1670936711; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=v0s/3V39m6q+UFQsK9fKPxehRNP7xs6yKszeFIHOlpQ=; 
        b=e9s093AM9NzCOEoMkV7OOj7RbiljyMISQXEeXLwbB/YPhAo6V9ljj6FV6VR6TlVVd3HUgxR+/WmcJpJeQICZQo3K+fbuKZg3mG6PrWMIyvtnGiL6k67eT9xR85JYCe3uQ7pi9SDX7LNSxnLGjZzdoX5jATGB+tWmgN9XjXe37wg=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=arinc9.com;
        spf=pass  smtp.mailfrom=arinc.unal@arinc9.com;
        dmarc=pass header.from=<arinc.unal@arinc9.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1670936711;
        s=zmail; d=arinc9.com; i=arinc.unal@arinc9.com;
        h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:In-Reply-To:References:MIME-Version:Content-Type:Content-Transfer-Encoding:Reply-To;
        bh=v0s/3V39m6q+UFQsK9fKPxehRNP7xs6yKszeFIHOlpQ=;
        b=dHJPhXLKJYuy+5Iv5ytQsT3REJ7q2bHwPyIwB3uCDmQaVgF+6Ymk2Ml0Cej+Jz/4
        ZRqFXzBFfN4mmBQOnyxqyf9pckhmXlP1Avd2afjoWbeb+QuHrRT8N1D2MGAHoULACLa
        qLoIcZ9zJvtuP1NqJBo2J43Lg0CuHYbDauxZ/yrk=
Received: from arinc9-PC.lan (37.120.152.236 [37.120.152.236]) by mx.zohomail.com
        with SMTPS id 1670936710543434.395317053791; Tue, 13 Dec 2022 05:05:10 -0800 (PST)
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
Subject: [PATCH 6/6] dt-bindings: pinctrl: rt3883: add proper function muxing binding
Date:   Tue, 13 Dec 2022 16:04:30 +0300
Message-Id: <20221213130430.172876-7-arinc.unal@arinc9.com>
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
 .../pinctrl/ralink,rt3883-pinctrl.yaml        | 204 +++++++++++++++++-
 1 file changed, 197 insertions(+), 7 deletions(-)

diff --git a/Documentation/devicetree/bindings/pinctrl/ralink,rt3883-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/ralink,rt3883-pinctrl.yaml
index feb6e66dcb61..9fbd6de13c03 100644
--- a/Documentation/devicetree/bindings/pinctrl/ralink,rt3883-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/ralink,rt3883-pinctrl.yaml
@@ -29,21 +29,212 @@ patternProperties:
         $ref: pinmux-node.yaml#
 
         properties:
-          groups:
-            description: The pin group to select.
-            enum: [ge1, ge2, i2c, jtag, lna a, lna g, mdio, pci, spi, uartf,
-                   uartlite]
-
           function:
-            description: The mux function to select.
+            description:
+              A string containing the name of the function to mux to the group.
             enum: [ge1, ge2, gpio, gpio i2s, gpio uartf, i2c, i2s uartf, jtag,
                    lna a, lna g, mdio, pci-dev, pci-fnc, pci-host1, pci-host2,
                    pcm gpio, pcm i2s, pcm uartf, spi, uartf, uartlite]
 
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
+                  const: ge1
+            then:
+              properties:
+                groups:
+                  enum: [ge1]
+
+          - if:
+              properties:
+                function:
+                  const: ge2
+            then:
+              properties:
+                groups:
+                  enum: [ge2]
+
+          - if:
+              properties:
+                function:
+                  const: gpio
+            then:
+              properties:
+                groups:
+                  enum: [ge1, ge2, i2c, jtag, lna a, lna g, mdio, pci, spi,
+                         uartf, uartlite]
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
+                  const: lna a
+            then:
+              properties:
+                groups:
+                  enum: [lna a]
+
+          - if:
+              properties:
+                function:
+                  const: lna g
+            then:
+              properties:
+                groups:
+                  enum: [lna g]
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
+                  const: pci-dev
+            then:
+              properties:
+                groups:
+                  enum: [pci]
+
+          - if:
+              properties:
+                function:
+                  const: pci-fnc
+            then:
+              properties:
+                groups:
+                  enum: [pci]
+
+          - if:
+              properties:
+                function:
+                  const: pci-host1
+            then:
+              properties:
+                groups:
+                  enum: [pci]
+
+          - if:
+              properties:
+                function:
+                  const: pci-host2
+            then:
+              properties:
+                groups:
+                  enum: [pci]
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
+                  const: spi
+            then:
+              properties:
+                groups:
+                  enum: [spi]
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
         additionalProperties: false
 
     additionalProperties: false
@@ -57,7 +248,6 @@ required:
 additionalProperties: false
 
 examples:
-  # Pinmux controller node
   - |
     pinctrl {
       compatible = "ralink,rt3883-pinctrl";
-- 
2.37.2

