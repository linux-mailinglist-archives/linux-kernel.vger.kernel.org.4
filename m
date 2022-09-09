Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2A6C5B3A2E
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 16:01:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231987AbiIINwV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 09:52:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231825AbiIINvi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 09:51:38 -0400
Received: from soltyk.jannau.net (soltyk.jannau.net [144.76.91.90])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F40B2142D8F;
        Fri,  9 Sep 2022 06:51:24 -0700 (PDT)
Received: from robin.home.jannau.net (p54acc2ba.dip0.t-ipconnect.de [84.172.194.186])
        by soltyk.jannau.net (Postfix) with ESMTPSA id CF35A26EFF2;
        Fri,  9 Sep 2022 15:51:07 +0200 (CEST)
From:   Janne Grunau <j@jannau.net>
To:     asahi@lists.linux.dev
Cc:     Mark Kettenis <kettenis@openbsd.org>,
        =?UTF-8?q?Martin=20Povi=C5=A1er?= <povik+lin@cutebit.org>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Hector Martin <marcan@marcan.st>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sven Peter <sven@svenpeter.dev>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH 09/10] arm64: dts: apple: t8103: Add MCA and its support
Date:   Fri,  9 Sep 2022 15:51:02 +0200
Message-Id: <20220909135103.98179-10-j@jannau.net>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220909135103.98179-1-j@jannau.net>
References: <20220909135103.98179-1-j@jannau.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Martin PoviÅ¡er <povik+lin@cutebit.org>

Add the MCA I2S transceiver node and its supporting NCO, ADMAC nodes.

Signed-off-by: Martin Povišer <povik+lin@cutebit.org>
Signed-off-by: Janne Grunau <j@jannau.net>
---

 arch/arm64/boot/dts/apple/t8103-jxxx.dtsi |  4 ++
 arch/arm64/boot/dts/apple/t8103.dtsi      | 73 +++++++++++++++++++++++
 2 files changed, 77 insertions(+)

diff --git a/arch/arm64/boot/dts/apple/t8103-jxxx.dtsi b/arch/arm64/boot/dts/apple/t8103-jxxx.dtsi
index fe2ae40fa9dd..503a1b243efa 100644
--- a/arch/arm64/boot/dts/apple/t8103-jxxx.dtsi
+++ b/arch/arm64/boot/dts/apple/t8103-jxxx.dtsi
@@ -76,3 +76,7 @@ wifi0: network@0,0 {
 		local-mac-address = [00 00 00 00 00 00];
 	};
 };
+
+&nco_clkref {
+	clock-frequency = <900000000>;
+};
diff --git a/arch/arm64/boot/dts/apple/t8103.dtsi b/arch/arm64/boot/dts/apple/t8103.dtsi
index 51a63b29d404..51bc901482db 100644
--- a/arch/arm64/boot/dts/apple/t8103.dtsi
+++ b/arch/arm64/boot/dts/apple/t8103.dtsi
@@ -116,6 +116,16 @@ clkref: clock-ref {
 		clock-output-names = "clkref";
 	};
 
+	/*
+	 * This is a fabulated representation of the input clock
+	 * to NCO since we don't know the true clock tree.
+	 */
+	nco_clkref: clock-ref-nco {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-output-names = "nco_ref";
+	};
+
 	soc {
 		compatible = "simple-bus";
 		#address-cells = <2>;
@@ -124,6 +134,15 @@ soc {
 		ranges;
 		nonposted-mmio;
 
+		dart_sio: iommu@235004000 {
+			compatible = "apple,t8103-dart";
+			reg = <0x2 0x35004000 0x0 0x4000>;
+			interrupt-parent = <&aic>;
+			interrupts = <AIC_IRQ 635 IRQ_TYPE_LEVEL_HIGH>;
+			#iommu-cells = <1>;
+			power-domains = <&ps_sio_cpu>;
+		};
+
 		i2c0: i2c@235010000 {
 			compatible = "apple,t8103-i2c", "apple,i2c";
 			reg = <0x2 0x35010000 0x0 0x4000>;
@@ -219,6 +238,60 @@ serial2: serial@235208000 {
 			status = "disabled";
 		};
 
+		admac: dma-controller@238200000 {
+			compatible = "apple,t8103-admac", "apple,admac";
+			reg = <0x2 0x38200000 0x0 0x34000>;
+			dma-channels = <24>;
+			interrupts-extended = <0>,
+					      <&aic AIC_IRQ 626 IRQ_TYPE_LEVEL_HIGH>,
+					      <0>,
+					      <0>;
+			#dma-cells = <1>;
+			iommus = <&dart_sio 2>;
+			power-domains = <&ps_sio_adma>;
+		};
+
+		mca: i2s@238400000 {
+			compatible = "apple,t8103-mca", "apple,mca";
+			reg = <0x2 0x38400000 0x0 0x18000>,
+			      <0x2 0x38300000 0x0 0x30000>;
+
+			interrupt-parent = <&aic>;
+			interrupts = <AIC_IRQ 619 IRQ_TYPE_LEVEL_HIGH>,
+				     <AIC_IRQ 620 IRQ_TYPE_LEVEL_HIGH>,
+				     <AIC_IRQ 621 IRQ_TYPE_LEVEL_HIGH>,
+				     <AIC_IRQ 622 IRQ_TYPE_LEVEL_HIGH>,
+				     <AIC_IRQ 623 IRQ_TYPE_LEVEL_HIGH>,
+				     <AIC_IRQ 624 IRQ_TYPE_LEVEL_HIGH>;
+
+			resets = <&ps_audio_p>;
+			clocks = <&nco 0>, <&nco 1>, <&nco 2>,
+				 <&nco 3>, <&nco 4>, <&nco 4>;
+			power-domains = <&ps_audio_p>, <&ps_mca0>, <&ps_mca1>,
+					<&ps_mca2>, <&ps_mca3>, <&ps_mca4>, <&ps_mca5>;
+			dmas = <&admac 0>, <&admac 1>, <&admac 2>, <&admac 3>,
+			       <&admac 4>, <&admac 5>, <&admac 6>, <&admac 7>,
+			       <&admac 8>, <&admac 9>, <&admac 10>, <&admac 11>,
+			       <&admac 12>, <&admac 13>, <&admac 14>, <&admac 15>,
+			       <&admac 16>, <&admac 17>, <&admac 18>, <&admac 19>,
+			       <&admac 20>, <&admac 21>, <&admac 22>, <&admac 23>;
+			dma-names = "tx0a", "rx0a", "tx0b", "rx0b",
+				"tx1a", "rx1a", "tx1b", "rx1b",
+				"tx2a", "rx2a", "tx2b", "rx2b",
+				"tx3a", "rx3a", "tx3b", "rx3b",
+				"tx4a", "rx4a", "tx4b", "rx4b",
+				"tx5a", "rx5a", "tx5b", "rx5b";
+
+			#sound-dai-cells = <1>;
+		};
+
+		nco: clock-controller@23b044000 {
+			compatible = "apple,t8103-nco", "apple,nco";
+			reg = <0x2 0x3b044000 0x0 0x14000>;
+			clocks = <&nco_clkref>;
+			#clock-cells = <1>;
+		};
+
 		aic: interrupt-controller@23b100000 {
 			compatible = "apple,t8103-aic", "apple,aic";
 			#interrupt-cells = <3>;
-- 
2.35.1

