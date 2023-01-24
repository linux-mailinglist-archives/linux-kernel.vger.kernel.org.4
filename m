Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06BF5678EC1
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 04:05:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232653AbjAXDFh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 22:05:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232305AbjAXDFY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 22:05:24 -0500
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 998192CC76;
        Mon, 23 Jan 2023 19:05:23 -0800 (PST)
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-15eec491b40so16240112fac.12;
        Mon, 23 Jan 2023 19:05:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q/AFIBZBlVMlUymjRHheiMpee3m76POsDggSk1UWmhI=;
        b=meQaFErwWPyxqYXEPA2vpAgdnEWrUcvWHyHfmp0aXkWPzoiJQpFSqt8TQhY+FfxPiZ
         QrFPqEJzq06MxFSPgwwAG+zVlAzrKVHBdOlH+8x5DfdqQsf0C+SO5nd35BsWZuWAC6bw
         SY2qqanlSmVxs0PrcmwZ74pL6sF+KuM60UyRFEijpcy8SFVHfwiBzLjFIO/ufq0f4WBW
         aijgzvrhszJ4ru69sW7XE0/iMMg4jWfpEnB3e0BjAldp/U80macCDkpbFgl5rdwE32Jy
         lA9GhaHGG/0WIJhwpFcNIsu5SAFTfupo+cHTr1c3sA+166tcC4OOAjWhWrTFwKptWUra
         E7Ug==
X-Gm-Message-State: AFqh2ko9bQPyHxYwEy30+b4UuXvxLT2J2R04uXmOaO35qNIsX0lUAZsQ
        qR3OpwKJgmPRR48YUIAagA==
X-Google-Smtp-Source: AMrXdXtLjF7KETuY0Xd3Nk9VYIhUHuC3c+T3ChWZB5joiQamOBF0Q4wxZ7GtxK4IzYtccz//wXwirA==
X-Received: by 2002:a05:6870:4508:b0:154:3fcb:bc20 with SMTP id e8-20020a056870450800b001543fcbbc20mr14559591oao.17.1674529522783;
        Mon, 23 Jan 2023 19:05:22 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id t12-20020a056870e74c00b0013bc95650c8sm230827oak.54.2023.01.23.19.05.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jan 2023 19:05:22 -0800 (PST)
Received: (nullmailer pid 3266344 invoked by uid 1000);
        Tue, 24 Jan 2023 03:05:20 -0000
From:   Rob Herring <robh@kernel.org>
Date:   Mon, 23 Jan 2023 21:05:17 -0600
Subject: [PATCH v3 3/5] dt-bindings: usb: Convert OMAP OHCI/EHCI bindings
 to schema
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230110-dt-usb-v3-3-5af0541fcf8c@kernel.org>
References: <20230110-dt-usb-v3-0-5af0541fcf8c@kernel.org>
In-Reply-To: <20230110-dt-usb-v3-0-5af0541fcf8c@kernel.org>
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
        Benjamin Fair <benjaminfair@google.com>,
        Lee Jones <lee@kernel.org>
Cc:     linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        openbmc@lists.ozlabs.org
X-Mailer: b4 0.12-dev
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The OMAP OHCI and EHCI USB host bindings follow the generic binding, so
add the compatibles and remove the old txt binding docs.

The examples in omap-usb-host.txt don't match actual users, so update
them dropping the fallback compatible.

Signed-off-by: Rob Herring <robh@kernel.org>
---
v3:
 - Fix document references to generic-ehci.yaml and generic-ohci.yaml (0-day)
v2:
 - New patch
---
 .../devicetree/bindings/mfd/omap-usb-host.txt      |  8 +++---
 .../devicetree/bindings/usb/ehci-omap.txt          | 31 ----------------------
 .../devicetree/bindings/usb/generic-ehci.yaml      |  1 +
 .../devicetree/bindings/usb/generic-ohci.yaml      |  4 ++-
 .../devicetree/bindings/usb/ohci-omap3.txt         | 15 -----------
 5 files changed, 8 insertions(+), 51 deletions(-)

diff --git a/Documentation/devicetree/bindings/mfd/omap-usb-host.txt b/Documentation/devicetree/bindings/mfd/omap-usb-host.txt
index aa1eaa59581b..a0d8c30c2631 100644
--- a/Documentation/devicetree/bindings/mfd/omap-usb-host.txt
+++ b/Documentation/devicetree/bindings/mfd/omap-usb-host.txt
@@ -64,8 +64,8 @@ Required properties if child node exists:
 Properties for children:
 
 The OMAP HS USB Host subsystem contains EHCI and OHCI controllers.
-See Documentation/devicetree/bindings/usb/ehci-omap.txt and
-Documentation/devicetree/bindings/usb/ohci-omap3.txt.
+See Documentation/devicetree/bindings/usb/generic-ehci.yaml and
+Documentation/devicetree/bindings/usb/generic-ohci.yaml.
 
 Example for OMAP4:
 
@@ -78,14 +78,14 @@ usbhshost: usbhshost@4a064000 {
 	ranges;
 
 	usbhsohci: ohci@4a064800 {
-		compatible = "ti,ohci-omap3", "usb-ohci";
+		compatible = "ti,ohci-omap3";
 		reg = <0x4a064800 0x400>;
 		interrupt-parent = <&gic>;
 		interrupts = <0 76 0x4>;
 	};
 
 	usbhsehci: ehci@4a064c00 {
-		compatible = "ti,ehci-omap", "usb-ehci";
+		compatible = "ti,ehci-omap";
 		reg = <0x4a064c00 0x400>;
 		interrupt-parent = <&gic>;
 		interrupts = <0 77 0x4>;
diff --git a/Documentation/devicetree/bindings/usb/ehci-omap.txt b/Documentation/devicetree/bindings/usb/ehci-omap.txt
deleted file mode 100644
index d77e11a975a2..000000000000
--- a/Documentation/devicetree/bindings/usb/ehci-omap.txt
+++ /dev/null
@@ -1,31 +0,0 @@
-OMAP HS USB EHCI controller
-
-This device is usually the child of the omap-usb-host
-Documentation/devicetree/bindings/mfd/omap-usb-host.txt
-
-Required properties:
-
-- compatible: should be "ti,ehci-omap"
-- reg: should contain one register range i.e. start and length
-- interrupts: description of the interrupt line
-
-Optional properties:
-
-- phys: list of phandles to PHY nodes.
-  This property is required if at least one of the ports are in
-  PHY mode i.e. OMAP_EHCI_PORT_MODE_PHY
-
-To specify the port mode, see
-Documentation/devicetree/bindings/mfd/omap-usb-host.txt
-
-Example for OMAP4:
-
-usbhsehci: ehci@4a064c00 {
-	compatible = "ti,ehci-omap";
-	reg = <0x4a064c00 0x400>;
-	interrupts = <0 77 0x4>;
-};
-
-&usbhsehci {
-	phys = <&hsusb1_phy 0 &hsusb3_phy>;
-};
diff --git a/Documentation/devicetree/bindings/usb/generic-ehci.yaml b/Documentation/devicetree/bindings/usb/generic-ehci.yaml
index 994818cb6044..2d382ae424da 100644
--- a/Documentation/devicetree/bindings/usb/generic-ehci.yaml
+++ b/Documentation/devicetree/bindings/usb/generic-ehci.yaml
@@ -74,6 +74,7 @@ properties:
           - const: usb-ehci
       - enum:
           - generic-ehci
+          - ti,ehci-omap
           - usb-ehci
 
   reg:
diff --git a/Documentation/devicetree/bindings/usb/generic-ohci.yaml b/Documentation/devicetree/bindings/usb/generic-ohci.yaml
index 8492d809ba40..a9ba7257b884 100644
--- a/Documentation/devicetree/bindings/usb/generic-ohci.yaml
+++ b/Documentation/devicetree/bindings/usb/generic-ohci.yaml
@@ -46,7 +46,9 @@ properties:
               - ingenic,jz4740-ohci
               - snps,hsdk-v1.0-ohci
           - const: generic-ohci
-      - const: generic-ohci
+      - enum:
+          - generic-ohci
+          - ti,ohci-omap3
       - items:
           - enum:
               - cavium,octeon-6335-ohci
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

-- 
2.39.0

