Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AC7D664FD2
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 00:18:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235300AbjAJXSs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 18:18:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234942AbjAJXSE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 18:18:04 -0500
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66D98209;
        Tue, 10 Jan 2023 15:18:03 -0800 (PST)
Received: by mail-ot1-f48.google.com with SMTP id y18-20020a0568301d9200b0067082cd4679so7899579oti.4;
        Tue, 10 Jan 2023 15:18:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YKqbPxuNlLMWlnGwAI1muAnTPiYazZZrzZlJ0EyIAOM=;
        b=5NmZVusQMI1ieZtCzWUT9HELyW5xndYegENcDDxUywQp6nUFYUtKRF9QpIoP2mKWaN
         mURT3k4aYOztyEUgGHI+H4LVxkaGN/KTTCiBk8fdCQd6OGbzoXpElRc0R7qoZ17TL/z+
         8DpD3kelX6PVvO+ydQ+HPNNfLMZvgCeYC05+6s0nqNVt3vHyXqIJoXaIGPoVTr8R2WsU
         wTw/SusC17n9QRPTNSxEhQ1tYsjDWUOrveKY9Ob423FHR5urWJZJOGZ+vYThqkoTfI+g
         OTjWCk1zG3pxIdcAVCWqNKjR3mpUGDKD7QME00R4ZWpEBNMMJayKaD2WwE5JrD61oN9s
         byZQ==
X-Gm-Message-State: AFqh2kp+GYDiEPJh2ECu69T6WTn6rnaXs1R2IcjwWGfA/FJfqA75JIPE
        kmbbSrVtlhnD7yknjk85uw==
X-Google-Smtp-Source: AMrXdXtp7PWqTwPCdF0yEaG/dj0ISDPlz0vgdaNDVFuF3mqX4Fw+WiUvd1m9VldQLl2Egf8XFuQtRQ==
X-Received: by 2002:a05:6830:d0f:b0:684:958c:ff83 with SMTP id bu15-20020a0568300d0f00b00684958cff83mr4386542otb.33.1673392682582;
        Tue, 10 Jan 2023 15:18:02 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id cb2-20020a056830618200b0068460566f4bsm6782711otb.30.2023.01.10.15.18.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jan 2023 15:18:02 -0800 (PST)
Received: (nullmailer pid 3145660 invoked by uid 1000);
        Tue, 10 Jan 2023 23:17:55 -0000
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 10 Jan 2023 17:17:45 -0600
Subject: [PATCH 2/4] dt-bindings: usb: Convert multiple "usb-ohci" bindings
 to DT schema
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230110-dt-usb-v1-2-8e366e326513@kernel.org>
References: <20230110-dt-usb-v1-0-8e366e326513@kernel.org>
In-Reply-To: <20230110-dt-usb-v1-0-8e366e326513@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Avi Fishman <avifishman70@gmail.com>,
        Tomer Maimon <tmaimon77@gmail.com>,
        Tali Perry <tali.perry1@gmail.com>,
        Patrick Venture <venture@google.com>,
        Nancy Yuen <yuenn@google.com>,
        Benjamin Fair <benjaminfair@google.com>
Cc:     linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        openbmc@lists.ozlabs.org
X-Mailer: b4 0.12-dev
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"usb-ohci" is another "generic" OHCI controller compatible string used by
several platforms. Add it to the generic-ohci.yaml schema and remove all
the old binding docs.

Marvell pxa-usb.txt has "usb-ohci" in the example, but actual users don't,
so drop it.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/powerpc/nintendo/wii.txt   | 10 -------
 .../devicetree/bindings/usb/generic-ohci.yaml      | 31 ++++++++++++++++---
 Documentation/devicetree/bindings/usb/ohci-nxp.txt | 24 ---------------
 .../devicetree/bindings/usb/ohci-omap3.txt         | 15 ----------
 Documentation/devicetree/bindings/usb/pxa-usb.txt  |  2 +-
 .../devicetree/bindings/usb/spear-usb.txt          | 35 ----------------------
 6 files changed, 28 insertions(+), 89 deletions(-)

diff --git a/Documentation/devicetree/bindings/powerpc/nintendo/wii.txt b/Documentation/devicetree/bindings/powerpc/nintendo/wii.txt
index c4d78f28d23c..3ff6ebbb4998 100644
--- a/Documentation/devicetree/bindings/powerpc/nintendo/wii.txt
+++ b/Documentation/devicetree/bindings/powerpc/nintendo/wii.txt
@@ -97,16 +97,6 @@ Nintendo Wii device tree
    - reg : should contain the EXI registers location and length
    - interrupts : should contain the EXI interrupt
 
-1.g) The Open Host Controller Interface (OHCI) nodes
-
-  Represent the USB 1.x Open Host Controller Interfaces.
-
-  Required properties:
-
-   - compatible : should be "nintendo,hollywood-usb-ohci","usb-ohci"
-   - reg : should contain the OHCI registers location and length
-   - interrupts : should contain the OHCI interrupt
-
 1.h) The Enhanced Host Controller Interface (EHCI) node
 
   Represents the USB 2.0 Enhanced Host Controller Interface.
diff --git a/Documentation/devicetree/bindings/usb/generic-ohci.yaml b/Documentation/devicetree/bindings/usb/generic-ohci.yaml
index 4fcbd0add49d..b898303381f8 100644
--- a/Documentation/devicetree/bindings/usb/generic-ohci.yaml
+++ b/Documentation/devicetree/bindings/usb/generic-ohci.yaml
@@ -6,9 +6,6 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
 
 title: USB OHCI Controller
 
-allOf:
-  - $ref: "usb-hcd.yaml"
-
 maintainers:
   - Greg Kroah-Hartman <gregkh@linuxfoundation.org>
 
@@ -49,7 +46,16 @@ properties:
               - ingenic,jz4740-ohci
               - snps,hsdk-v1.0-ohci
           - const: generic-ohci
-      - const: generic-ohci
+      - enum:
+          - generic-ohci
+          - ti,ohci-omap3
+      - items:
+          - enum:
+              - cavium,octeon-6335-ohci
+              - nintendo,hollywood-usb-ohci
+              - nxp,ohci-nxp
+              - st,spear600-ohci
+          - const: usb-ohci
 
   reg:
     maxItems: 1
@@ -119,11 +125,28 @@ properties:
       - host
       - otg
 
+  transceiver:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description:
+      The associated ISP1301 device. Necessary for the UDC controller for
+      connecting to the USB physical layer.
+
 required:
   - compatible
   - reg
   - interrupts
 
+allOf:
+  - $ref: usb-hcd.yaml
+  - if:
+      not:
+        properties:
+          compatible:
+            contains:
+              const: nxp,ohci-nxp
+    then:
+      transceiver: false
+
 additionalProperties: false
 
 examples:
diff --git a/Documentation/devicetree/bindings/usb/ohci-nxp.txt b/Documentation/devicetree/bindings/usb/ohci-nxp.txt
deleted file mode 100644
index 71e28c1017ed..000000000000
--- a/Documentation/devicetree/bindings/usb/ohci-nxp.txt
+++ /dev/null
@@ -1,24 +0,0 @@
-* OHCI controller, NXP ohci-nxp variant
-
-Required properties:
-- compatible: must be "nxp,ohci-nxp"
-- reg: physical base address of the controller and length of memory mapped
-  region.
-- interrupts: The OHCI interrupt
-- transceiver: phandle of the associated ISP1301 device - this is necessary for
-               the UDC controller for connecting to the USB physical layer
-
-Example (LPC32xx):
-
-	isp1301: usb-transceiver@2c {
-		compatible = "nxp,isp1301";
-		reg = <0x2c>;
-	};
-
-	ohci@31020000 {
-		compatible = "nxp,ohci-nxp";
-		reg = <0x31020000 0x300>;
-		interrupt-parent = <&mic>;
-		interrupts = <0x3b 0>;
-		transceiver = <&isp1301>;
-	};
diff --git a/Documentation/devicetree/bindings/usb/ohci-omap3.txt b/Documentation/devicetree/bindings/usb/ohci-omap3.txt
deleted file mode 100644
index ce8c47cff6d0..000000000000
--- a/Documentation/devicetree/bindings/usb/ohci-omap3.txt
+++ /dev/null
@@ -1,15 +0,0 @@
-OMAP HS USB OHCI controller (OMAP3 and later)
-
-Required properties:
-
-- compatible: should be "ti,ohci-omap3"
-- reg: should contain one register range i.e. start and length
-- interrupts: description of the interrupt line
-
-Example for OMAP4:
-
-usbhsohci: ohci@4a064800 {
-	compatible = "ti,ohci-omap3";
-	reg = <0x4a064800 0x400>;
-	interrupts = <0 76 0x4>;
-};
diff --git a/Documentation/devicetree/bindings/usb/pxa-usb.txt b/Documentation/devicetree/bindings/usb/pxa-usb.txt
index 9c331799b87c..53fdae4fa6f6 100644
--- a/Documentation/devicetree/bindings/usb/pxa-usb.txt
+++ b/Documentation/devicetree/bindings/usb/pxa-usb.txt
@@ -22,7 +22,7 @@ Optional properties:
 Example:
 
 	usb0: ohci@4c000000 {
-		compatible = "marvell,pxa-ohci", "usb-ohci";
+		compatible = "marvell,pxa-ohci";
 		reg = <0x4c000000 0x100000>;
 		interrupts = <18>;
 		marvell,enable-port1;
diff --git a/Documentation/devicetree/bindings/usb/spear-usb.txt b/Documentation/devicetree/bindings/usb/spear-usb.txt
deleted file mode 100644
index 1dc91cc459c0..000000000000
--- a/Documentation/devicetree/bindings/usb/spear-usb.txt
+++ /dev/null
@@ -1,35 +0,0 @@
-ST SPEAr SoC USB controllers:
------------------------------
-
-EHCI:
------
-
-Required properties:
-- compatible: "st,spear600-ehci"
-- interrupts: Should contain the EHCI interrupt
-
-Example:
-
-	ehci@e1800000 {
-		compatible = "st,spear600-ehci", "usb-ehci";
-		reg = <0xe1800000 0x1000>;
-		interrupt-parent = <&vic1>;
-		interrupts = <27>;
-	};
-
-
-OHCI:
------
-
-Required properties:
-- compatible: "st,spear600-ohci"
-- interrupts: Should contain the OHCI interrupt
-
-Example:
-
-	ohci@e1900000 {
-		compatible = "st,spear600-ohci", "usb-ohci";
-		reg = <0xe1800000 0x1000>;
-		interrupt-parent = <&vic1>;
-		interrupts = <26>;
-	};

-- 
2.39.0

