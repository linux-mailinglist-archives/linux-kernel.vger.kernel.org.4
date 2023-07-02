Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58542745007
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jul 2023 20:53:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230206AbjGBSxW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Jul 2023 14:53:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230171AbjGBSxV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jul 2023 14:53:21 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E6B21703
        for <linux-kernel@vger.kernel.org>; Sun,  2 Jul 2023 11:52:51 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-51dff848168so1866700a12.2
        for <linux-kernel@vger.kernel.org>; Sun, 02 Jul 2023 11:52:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688323943; x=1690915943;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=12XU73OcNWpEtxBwwXS3Dzf/1RwIDgzZw/PCty1APUw=;
        b=LPwGbpF4SgWH6ET6FeiiHOH+U+x1JSzaQmMEnnh5xGbhQhIpwGnjmwEG8pHM+w8/OV
         kOzjhXpPzVjH2PDzNV1pOdA0lZ06lvfMI+xjz4BwL2D9q1ruDkhlOODcMHOkUBC8Qh6r
         PN+ctkGUtMy1WDtBIi3yoaQDqiJTa8KvrRBOByJPl4FxPtiy2BC83M8oV+Xg+IdhWw68
         yfAnzZ0/Wh6SjJWExmninEZrpTyXYV4Le5LoPF0s/tONqLG6VPrehLOxZpTl63r0dlle
         gT+PNPU+YG8niwHFd1g/Wc+1O1ShjpR0HHRglGDSc9PfK5nQW97h7bFiXa/q12qU+EnV
         n1SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688323943; x=1690915943;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=12XU73OcNWpEtxBwwXS3Dzf/1RwIDgzZw/PCty1APUw=;
        b=Buz3WtDl0x+2Kry47z2TfOr0ymKaN7zSRdQ1+DbHDNUdMYkBThcAZIaTBPgS3WMAZ3
         YzEy4uC7DaxolDM+W0ppWBr+wy0QTbKHrdAZJPlHLcArT/zmILxULWqTvr7gJYLIp0eF
         OQxP+Z4oTm501yXXm92zeV6RiBAyM6MK1P5nJfyKTvE8RMmsa2sHLnlHVYI6G6+v/a9M
         jeFQetsexg6I4Nf/5MB5T9/S3YtkvdBHpV6lxsHKQPl0y+YfOJ2Nxa9r+TmwsahrsX06
         42uL0Dc8ILaX63HrHTDsvUUZgRMk/tQqGl+wuP/sObzmwIkw3pNDHYebqaFUukR2xcwW
         SjgQ==
X-Gm-Message-State: ABy/qLYb4DQXxJmTXf199KLXub8UpwCjv8YKrFOr6LXcBvu1yrQgFFpt
        bBP0EpvNrNf0OdwKqH4XrRBuAQ==
X-Google-Smtp-Source: APBJJlG6x3iGxVpjhOxtd9j+z21H4Q8uN9emBLgnhg1rWA8BUJ85rpGDF/Dnk0xszq7QlAxoW8iKGw==
X-Received: by 2002:a17:906:854c:b0:992:b66e:72f9 with SMTP id h12-20020a170906854c00b00992b66e72f9mr6118706ejy.69.1688323943606;
        Sun, 02 Jul 2023 11:52:23 -0700 (PDT)
Received: from krzk-bin.. ([217.169.179.6])
        by smtp.gmail.com with ESMTPSA id b27-20020a170906195b00b00991e2b5a27dsm8255287eje.37.2023.07.02.11.52.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Jul 2023 11:52:23 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] arm64: dts: ti: minor whitespace cleanup around '='
Date:   Sun,  2 Jul 2023 20:52:21 +0200
Message-Id: <20230702185221.44319-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The DTS code coding style expects exactly one space before and after '='
sign.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/ti/k3-am62-main.dtsi      |  4 +--
 .../arm64/boot/dts/ti/k3-am625-beagleplay.dts |  2 +-
 arch/arm64/boot/dts/ti/k3-am62a-main.dtsi     |  8 +++---
 arch/arm64/boot/dts/ti/k3-am62a7-sk.dts       |  2 +-
 arch/arm64/boot/dts/ti/k3-am65-main.dtsi      | 28 +++++++++----------
 arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi       | 14 +++++-----
 arch/arm64/boot/dts/ti/k3-j7200-main.dtsi     | 14 +++++-----
 .../boot/dts/ti/k3-j7200-mcu-wakeup.dtsi      | 14 +++++-----
 arch/arm64/boot/dts/ti/k3-j721e-main.dtsi     | 24 ++++++++--------
 .../boot/dts/ti/k3-j721e-mcu-wakeup.dtsi      | 14 +++++-----
 arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi    |  4 +--
 11 files changed, 64 insertions(+), 64 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-am62-main.dtsi b/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
index 2488e3a537fe..4a1dab9e40a0 100644
--- a/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
@@ -590,7 +590,7 @@ usbss0: dwc3-usb@f900000 {
 
 		usb0: usb@31000000 {
 			compatible = "snps,dwc3";
-			reg =<0x00 0x31000000 0x00 0x50000>;
+			reg = <0x00 0x31000000 0x00 0x50000>;
 			interrupts = <GIC_SPI 188 IRQ_TYPE_LEVEL_HIGH>, /* irq.0 */
 				     <GIC_SPI 188 IRQ_TYPE_LEVEL_HIGH>; /* irq.0 */
 			interrupt-names = "host", "peripheral";
@@ -613,7 +613,7 @@ usbss1: dwc3-usb@f910000 {
 
 		usb1: usb@31100000 {
 			compatible = "snps,dwc3";
-			reg =<0x00 0x31100000 0x00 0x50000>;
+			reg = <0x00 0x31100000 0x00 0x50000>;
 			interrupts = <GIC_SPI 226 IRQ_TYPE_LEVEL_HIGH>, /* irq.0 */
 				     <GIC_SPI 226 IRQ_TYPE_LEVEL_HIGH>; /* irq.0 */
 			interrupt-names = "host", "peripheral";
diff --git a/arch/arm64/boot/dts/ti/k3-am625-beagleplay.dts b/arch/arm64/boot/dts/ti/k3-am625-beagleplay.dts
index 589bf998bc52..7c1402b0fa2d 100644
--- a/arch/arm64/boot/dts/ti/k3-am625-beagleplay.dts
+++ b/arch/arm64/boot/dts/ti/k3-am625-beagleplay.dts
@@ -14,7 +14,7 @@
 #include "k3-am625.dtsi"
 
 / {
-	compatible =  "beagle,am625-beagleplay", "ti,am625";
+	compatible = "beagle,am625-beagleplay", "ti,am625";
 	model = "BeagleBoard.org BeaglePlay";
 
 	aliases {
diff --git a/arch/arm64/boot/dts/ti/k3-am62a-main.dtsi b/arch/arm64/boot/dts/ti/k3-am62a-main.dtsi
index 8b315cc61550..8397cb80f559 100644
--- a/arch/arm64/boot/dts/ti/k3-am62a-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62a-main.dtsi
@@ -150,8 +150,8 @@ dmsc: system-controller@44043000 {
 		reg-names = "debug_messages";
 		ti,host-id = <12>;
 		mbox-names = "rx", "tx";
-		mboxes= <&secure_proxy_main 12>,
-			<&secure_proxy_main 13>;
+		mboxes = <&secure_proxy_main 12>,
+			 <&secure_proxy_main 13>;
 
 		k3_pds: power-controller {
 			compatible = "ti,sci-pm-domain";
@@ -527,7 +527,7 @@ usbss0: dwc3-usb@f900000 {
 
 		usb0: usb@31000000 {
 			compatible = "snps,dwc3";
-			reg =<0x00 0x31000000 0x00 0x50000>;
+			reg = <0x00 0x31000000 0x00 0x50000>;
 			interrupts = <GIC_SPI 188 IRQ_TYPE_LEVEL_HIGH>, /* irq.0 */
 				     <GIC_SPI 188 IRQ_TYPE_LEVEL_HIGH>; /* irq.0 */
 			interrupt-names = "host", "peripheral";
@@ -550,7 +550,7 @@ usbss1: dwc3-usb@f910000 {
 
 		usb1: usb@31100000 {
 			compatible = "snps,dwc3";
-			reg =<0x00 0x31100000 0x00 0x50000>;
+			reg = <0x00 0x31100000 0x00 0x50000>;
 			interrupts = <GIC_SPI 226 IRQ_TYPE_LEVEL_HIGH>, /* irq.0 */
 				     <GIC_SPI 226 IRQ_TYPE_LEVEL_HIGH>; /* irq.0 */
 			interrupt-names = "host", "peripheral";
diff --git a/arch/arm64/boot/dts/ti/k3-am62a7-sk.dts b/arch/arm64/boot/dts/ti/k3-am62a7-sk.dts
index ecc0e13331c4..d2cca6182738 100644
--- a/arch/arm64/boot/dts/ti/k3-am62a7-sk.dts
+++ b/arch/arm64/boot/dts/ti/k3-am62a7-sk.dts
@@ -13,7 +13,7 @@
 #include "k3-am62a7.dtsi"
 
 / {
-	compatible =  "ti,am62a7-sk", "ti,am62a7";
+	compatible = "ti,am62a7-sk", "ti,am62a7";
 	model = "Texas Instruments AM62A7 SK";
 
 	aliases {
diff --git a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
index 3f8ff2589842..791c6b38993d 100644
--- a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
@@ -773,10 +773,10 @@ mailbox0_cluster11: mailbox@31f8b000 {
 
 		ringacc: ringacc@3c000000 {
 			compatible = "ti,am654-navss-ringacc";
-			reg =	<0x0 0x3c000000 0x0 0x400000>,
-				<0x0 0x38000000 0x0 0x400000>,
-				<0x0 0x31120000 0x0 0x100>,
-				<0x0 0x33000000 0x0 0x40000>;
+			reg = <0x0 0x3c000000 0x0 0x400000>,
+			      <0x0 0x38000000 0x0 0x400000>,
+			      <0x0 0x31120000 0x0 0x100>,
+			      <0x0 0x33000000 0x0 0x40000>;
 			reg-names = "rt", "fifos", "proxy_gcfg", "proxy_target";
 			ti,num-rings = <818>;
 			ti,sci-rm-range-gp-rings = <0x1>; /* GP ring range */
@@ -787,9 +787,9 @@ ringacc: ringacc@3c000000 {
 
 		main_udmap: dma-controller@31150000 {
 			compatible = "ti,am654-navss-main-udmap";
-			reg =	<0x0 0x31150000 0x0 0x100>,
-				<0x0 0x34000000 0x0 0x100000>,
-				<0x0 0x35000000 0x0 0x100000>;
+			reg = <0x0 0x31150000 0x0 0x100>,
+			      <0x0 0x34000000 0x0 0x100000>,
+			      <0x0 0x35000000 0x0 0x100000>;
 			reg-names = "gcfg", "rchanrt", "tchanrt";
 			msi-parent = <&inta_main_udmass>;
 			#dma-cells = <1>;
@@ -1006,13 +1006,13 @@ csi2_0: port@0 {
 
 	dss: dss@4a00000 {
 		compatible = "ti,am65x-dss";
-		reg =	<0x0 0x04a00000 0x0 0x1000>, /* common */
-			<0x0 0x04a02000 0x0 0x1000>, /* vidl1 */
-			<0x0 0x04a06000 0x0 0x1000>, /* vid */
-			<0x0 0x04a07000 0x0 0x1000>, /* ovr1 */
-			<0x0 0x04a08000 0x0 0x1000>, /* ovr2 */
-			<0x0 0x04a0a000 0x0 0x1000>, /* vp1 */
-			<0x0 0x04a0b000 0x0 0x1000>; /* vp2 */
+		reg = <0x0 0x04a00000 0x0 0x1000>, /* common */
+		      <0x0 0x04a02000 0x0 0x1000>, /* vidl1 */
+		      <0x0 0x04a06000 0x0 0x1000>, /* vid */
+		      <0x0 0x04a07000 0x0 0x1000>, /* ovr1 */
+		      <0x0 0x04a08000 0x0 0x1000>, /* ovr2 */
+		      <0x0 0x04a0a000 0x0 0x1000>, /* vp1 */
+		      <0x0 0x04a0b000 0x0 0x1000>; /* vp2 */
 		reg-names = "common", "vidl1", "vid",
 			"ovr1", "ovr2", "vp1", "vp2";
 
diff --git a/arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi b/arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi
index b7a4b5a89aaf..7b1f94a89eca 100644
--- a/arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi
@@ -194,10 +194,10 @@ mcu_navss: bus@28380000 {
 
 		mcu_ringacc: ringacc@2b800000 {
 			compatible = "ti,am654-navss-ringacc";
-			reg =	<0x0 0x2b800000 0x0 0x400000>,
-				<0x0 0x2b000000 0x0 0x400000>,
-				<0x0 0x28590000 0x0 0x100>,
-				<0x0 0x2a500000 0x0 0x40000>;
+			reg = <0x0 0x2b800000 0x0 0x400000>,
+			      <0x0 0x2b000000 0x0 0x400000>,
+			      <0x0 0x28590000 0x0 0x100>,
+			      <0x0 0x2a500000 0x0 0x40000>;
 			reg-names = "rt", "fifos", "proxy_gcfg", "proxy_target";
 			ti,num-rings = <286>;
 			ti,sci-rm-range-gp-rings = <0x1>; /* GP ring range */
@@ -208,9 +208,9 @@ mcu_ringacc: ringacc@2b800000 {
 
 		mcu_udmap: dma-controller@285c0000 {
 			compatible = "ti,am654-navss-mcu-udmap";
-			reg =	<0x0 0x285c0000 0x0 0x100>,
-				<0x0 0x2a800000 0x0 0x40000>,
-				<0x0 0x2aa00000 0x0 0x40000>;
+			reg = <0x0 0x285c0000 0x0 0x100>,
+			      <0x0 0x2a800000 0x0 0x40000>,
+			      <0x0 0x2aa00000 0x0 0x40000>;
 			reg-names = "gcfg", "rchanrt", "tchanrt";
 			msi-parent = <&inta_main_udmass>;
 			#dma-cells = <1>;
diff --git a/arch/arm64/boot/dts/ti/k3-j7200-main.dtsi b/arch/arm64/boot/dts/ti/k3-j7200-main.dtsi
index ac62bbc1660d..6eaade5aeb42 100644
--- a/arch/arm64/boot/dts/ti/k3-j7200-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j7200-main.dtsi
@@ -264,10 +264,10 @@ mailbox0_cluster11: mailbox@31f8b000 {
 
 		main_ringacc: ringacc@3c000000 {
 			compatible = "ti,am654-navss-ringacc";
-			reg =	<0x00 0x3c000000 0x00 0x400000>,
-				<0x00 0x38000000 0x00 0x400000>,
-				<0x00 0x31120000 0x00 0x100>,
-				<0x00 0x33000000 0x00 0x40000>;
+			reg = <0x00 0x3c000000 0x00 0x400000>,
+			      <0x00 0x38000000 0x00 0x400000>,
+			      <0x00 0x31120000 0x00 0x100>,
+			      <0x00 0x33000000 0x00 0x40000>;
 			reg-names = "rt", "fifos", "proxy_gcfg", "proxy_target";
 			ti,num-rings = <1024>;
 			ti,sci-rm-range-gp-rings = <0x1>; /* GP ring range */
@@ -278,9 +278,9 @@ main_ringacc: ringacc@3c000000 {
 
 		main_udmap: dma-controller@31150000 {
 			compatible = "ti,j721e-navss-main-udmap";
-			reg =	<0x00 0x31150000 0x00 0x100>,
-				<0x00 0x34000000 0x00 0x100000>,
-				<0x00 0x35000000 0x00 0x100000>;
+			reg = <0x00 0x31150000 0x00 0x100>,
+			      <0x00 0x34000000 0x00 0x100000>,
+			      <0x00 0x35000000 0x00 0x100000>;
 			reg-names = "gcfg", "rchanrt", "tchanrt";
 			msi-parent = <&main_udmass_inta>;
 			#dma-cells = <1>;
diff --git a/arch/arm64/boot/dts/ti/k3-j7200-mcu-wakeup.dtsi b/arch/arm64/boot/dts/ti/k3-j7200-mcu-wakeup.dtsi
index c5e4c41effd1..ee7860913c38 100644
--- a/arch/arm64/boot/dts/ti/k3-j7200-mcu-wakeup.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j7200-mcu-wakeup.dtsi
@@ -326,10 +326,10 @@ mcu_navss: bus@28380000 {
 
 		mcu_ringacc: ringacc@2b800000 {
 			compatible = "ti,am654-navss-ringacc";
-			reg =	<0x00 0x2b800000 0x00 0x400000>,
-				<0x00 0x2b000000 0x00 0x400000>,
-				<0x00 0x28590000 0x00 0x100>,
-				<0x00 0x2a500000 0x00 0x40000>;
+			reg = <0x00 0x2b800000 0x00 0x400000>,
+			      <0x00 0x2b000000 0x00 0x400000>,
+			      <0x00 0x28590000 0x00 0x100>,
+			      <0x00 0x2a500000 0x00 0x40000>;
 			reg-names = "rt", "fifos", "proxy_gcfg", "proxy_target";
 			ti,num-rings = <286>;
 			ti,sci-rm-range-gp-rings = <0x1>; /* GP ring range */
@@ -340,9 +340,9 @@ mcu_ringacc: ringacc@2b800000 {
 
 		mcu_udmap: dma-controller@285c0000 {
 			compatible = "ti,j721e-navss-mcu-udmap";
-			reg =	<0x00 0x285c0000 0x00 0x100>,
-				<0x00 0x2a800000 0x00 0x40000>,
-				<0x00 0x2aa00000 0x00 0x40000>;
+			reg = <0x00 0x285c0000 0x00 0x100>,
+			      <0x00 0x2a800000 0x00 0x40000>,
+			      <0x00 0x2aa00000 0x00 0x40000>;
 			reg-names = "gcfg", "rchanrt", "tchanrt";
 			msi-parent = <&main_udmass_inta>;
 			#dma-cells = <1>;
diff --git a/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi b/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
index 2ded1ee1a854..649628685c32 100644
--- a/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
@@ -364,10 +364,10 @@ mailbox0_cluster11: mailbox@31f8b000 {
 
 		main_ringacc: ringacc@3c000000 {
 			compatible = "ti,am654-navss-ringacc";
-			reg =	<0x0 0x3c000000 0x0 0x400000>,
-				<0x0 0x38000000 0x0 0x400000>,
-				<0x0 0x31120000 0x0 0x100>,
-				<0x0 0x33000000 0x0 0x40000>;
+			reg = <0x0 0x3c000000 0x0 0x400000>,
+			      <0x0 0x38000000 0x0 0x400000>,
+			      <0x0 0x31120000 0x0 0x100>,
+			      <0x0 0x33000000 0x0 0x40000>;
 			reg-names = "rt", "fifos", "proxy_gcfg", "proxy_target";
 			ti,num-rings = <1024>;
 			ti,sci-rm-range-gp-rings = <0x1>; /* GP ring range */
@@ -378,9 +378,9 @@ main_ringacc: ringacc@3c000000 {
 
 		main_udmap: dma-controller@31150000 {
 			compatible = "ti,j721e-navss-main-udmap";
-			reg =	<0x0 0x31150000 0x0 0x100>,
-				<0x0 0x34000000 0x0 0x100000>,
-				<0x0 0x35000000 0x0 0x100000>;
+			reg = <0x0 0x31150000 0x0 0x100>,
+			      <0x0 0x34000000 0x0 0x100000>,
+			      <0x0 0x35000000 0x0 0x100000>;
 			reg-names = "gcfg", "rchanrt", "tchanrt";
 			msi-parent = <&main_udmass_inta>;
 			#dma-cells = <1>;
@@ -1761,11 +1761,11 @@ dss: dss@4a00000 {
 			"vp1", "vp2", "vp3", "vp4",
 			"wb";
 
-		clocks =	<&k3_clks 152 0>,
-				<&k3_clks 152 1>,
-				<&k3_clks 152 4>,
-				<&k3_clks 152 9>,
-				<&k3_clks 152 13>;
+		clocks = <&k3_clks 152 0>,
+			 <&k3_clks 152 1>,
+			 <&k3_clks 152 4>,
+			 <&k3_clks 152 9>,
+			 <&k3_clks 152 13>;
 		clock-names = "fck", "vp1", "vp2", "vp3", "vp4";
 
 		power-domains = <&k3_pds 152 TI_SCI_PD_EXCLUSIVE>;
diff --git a/arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi b/arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi
index ea5b9e104491..c1b6f8d7d189 100644
--- a/arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi
@@ -445,10 +445,10 @@ mcu_navss: bus@28380000 {
 
 		mcu_ringacc: ringacc@2b800000 {
 			compatible = "ti,am654-navss-ringacc";
-			reg =	<0x0 0x2b800000 0x0 0x400000>,
-				<0x0 0x2b000000 0x0 0x400000>,
-				<0x0 0x28590000 0x0 0x100>,
-				<0x0 0x2a500000 0x0 0x40000>;
+			reg = <0x0 0x2b800000 0x0 0x400000>,
+			      <0x0 0x2b000000 0x0 0x400000>,
+			      <0x0 0x28590000 0x0 0x100>,
+			      <0x0 0x2a500000 0x0 0x40000>;
 			reg-names = "rt", "fifos", "proxy_gcfg", "proxy_target";
 			ti,num-rings = <286>;
 			ti,sci-rm-range-gp-rings = <0x1>; /* GP ring range */
@@ -459,9 +459,9 @@ mcu_ringacc: ringacc@2b800000 {
 
 		mcu_udmap: dma-controller@285c0000 {
 			compatible = "ti,j721e-navss-mcu-udmap";
-			reg =	<0x0 0x285c0000 0x0 0x100>,
-				<0x0 0x2a800000 0x0 0x40000>,
-				<0x0 0x2aa00000 0x0 0x40000>;
+			reg = <0x0 0x285c0000 0x0 0x100>,
+			      <0x0 0x2a800000 0x0 0x40000>,
+			      <0x0 0x2aa00000 0x0 0x40000>;
 			reg-names = "gcfg", "rchanrt", "tchanrt";
 			msi-parent = <&main_udmass_inta>;
 			#dma-cells = <1>;
diff --git a/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi b/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi
index 2ea0adae6832..11f163e5cadf 100644
--- a/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi
@@ -618,7 +618,7 @@ main_sdhci0: mmc@4f80000 {
 		interrupts = <GIC_SPI 3 IRQ_TYPE_LEVEL_HIGH>;
 		power-domains = <&k3_pds 140 TI_SCI_PD_EXCLUSIVE>;
 		clocks = <&k3_clks 140 1>, <&k3_clks 140 2>;
-		clock-names =  "clk_ahb", "clk_xin";
+		clock-names = "clk_ahb", "clk_xin";
 		assigned-clocks = <&k3_clks 140 2>;
 		assigned-clock-parents = <&k3_clks 140 3>;
 		bus-width = <8>;
@@ -646,7 +646,7 @@ main_sdhci1: mmc@4fb0000 {
 		interrupts = <GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>;
 		power-domains = <&k3_pds 141 TI_SCI_PD_EXCLUSIVE>;
 		clocks = <&k3_clks 141 3>, <&k3_clks 141 4>;
-		clock-names =  "clk_ahb", "clk_xin";
+		clock-names = "clk_ahb", "clk_xin";
 		assigned-clocks = <&k3_clks 141 4>;
 		assigned-clock-parents = <&k3_clks 141 5>;
 		bus-width = <4>;
-- 
2.34.1

