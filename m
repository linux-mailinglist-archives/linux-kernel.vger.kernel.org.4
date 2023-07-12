Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2E94750AE1
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 16:25:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232163AbjGLOZl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 10:25:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231893AbjGLOZb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 10:25:31 -0400
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 409BA1BCB;
        Wed, 12 Jul 2023 07:25:19 -0700 (PDT)
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36CAr7Cq022859;
        Wed, 12 Jul 2023 16:24:41 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=selector1;
 bh=bnK9OMExY2xUPrMO6NdrFFXOkm8tCHUzxNMKfOVmGvI=;
 b=zfBYzISLPlRLVoL7pxfvP9QDoBhxRC7wxo9lGZLDfyeU/myWhlnSyj+uIf2w3TyABcBf
 g0RIDQlN57YuIn7yt2dPRusyc3WopXKxZr4JiZ6l7taajxy/o+Hpp6IZvgsE3wyUYadh
 CyGsE75X8CRKdISKgG603OLPkJ6rquqfeh7AeARSDM6+2Ja7kkM0ppmocuwtQ3MQDqU7
 BXnl+XqZXVlyZeNy0fvJn4p2d64R3nCZgAEfamVkeFLLBj2jAc7qQawDWspvEh16/d/M
 Tzc5C6TZugEWOBGaIWPHVVQoNPeSUNtJtlw7DGN5zZvmdX3ZbYuQtWP41hJghuckoEib 5A== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3rsr19b147-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 12 Jul 2023 16:24:41 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 96029100064;
        Wed, 12 Jul 2023 16:24:39 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 5A1EF21BF67;
        Wed, 12 Jul 2023 16:24:38 +0200 (CEST)
Received: from localhost (10.252.136.3) by SHFDAG1NODE2.st.com (10.75.129.70)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21; Wed, 12 Jul
 2023 16:24:37 +0200
From:   <p.paillet@foss.st.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Russell King <linux@armlinux.org.uk>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
        Alexander Stein <alexander.stein@ew.tq-group.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <p.paillet@foss.st.com>,
        Etienne Carriere <etienne.carriere@foss.st.com>
Subject: [PATCH 2/4] ARM: dts: stm32: STM32MP13x SoC exposes SCMI regulators
Date:   Wed, 12 Jul 2023 16:24:30 +0200
Message-ID: <20230712142432.1885162-3-p.paillet@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230712142432.1885162-1-p.paillet@foss.st.com>
References: <20230712142432.1885162-1-p.paillet@foss.st.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.252.136.3]
X-ClientProxiedBy: EQNCAS1NODE4.st.com (10.75.129.82) To SHFDAG1NODE2.st.com
 (10.75.129.70)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-12_09,2023-07-11_01,2023-05-22_02
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Etienne Carriere <etienne.carriere@foss.st.com>

Updates STM32MP13x SoC DTSI file to define the SoC voltage regulators
exposed by OP-TEE SCMI service and remove the fixed regulator
abstraction previously used until OP-TEE OS firmware embeds the
service which it does since its release tag 3.22.0.

Signed-off-by: Etienne Carriere <etienne.carriere@foss.st.com>
Signed-off-by: Pascal Paillet <p.paillet@foss.st.com>
---
 arch/arm/boot/dts/st/stm32mp131.dtsi | 50 ++++++++++++++--------------
 1 file changed, 25 insertions(+), 25 deletions(-)

diff --git a/arch/arm/boot/dts/st/stm32mp131.dtsi b/arch/arm/boot/dts/st/stm32mp131.dtsi
index 672f3b7735a2..ac90fcbf0c09 100644
--- a/arch/arm/boot/dts/st/stm32mp131.dtsi
+++ b/arch/arm/boot/dts/st/stm32mp131.dtsi
@@ -52,6 +52,28 @@ scmi_reset: protocol@16 {
 				reg = <0x16>;
 				#reset-cells = <1>;
 			};
+
+			scmi_voltd: protocol@17 {
+				reg = <0x17>;
+
+				scmi_regu: regulators {
+					#address-cells = <1>;
+					#size-cells = <0>;
+
+					scmi_reg11: regulator@0 {
+						reg = <VOLTD_SCMI_REG11>;
+						regulator-name = "reg11";
+					};
+					scmi_reg18: regulator@1 {
+						reg = <VOLTD_SCMI_REG18>;
+						regulator-name = "reg18";
+					};
+					scmi_usb33: regulator@2 {
+						reg = <VOLTD_SCMI_USB33>;
+						regulator-name = "usb33";
+					};
+				};
+			};
 		};
 	};
 
@@ -78,28 +100,6 @@ timer {
 		always-on;
 	};
 
-	/* PWR 1v1, 1v8 and 3v3 regulators defined as fixed, waiting for SCMI */
-	reg11: reg11 {
-		compatible = "regulator-fixed";
-		regulator-name = "reg11";
-		regulator-min-microvolt = <1100000>;
-		regulator-max-microvolt = <1100000>;
-	};
-
-	reg18: reg18 {
-		compatible = "regulator-fixed";
-		regulator-name = "reg18";
-		regulator-min-microvolt = <1800000>;
-		regulator-max-microvolt = <1800000>;
-	};
-
-	usb33: usb33 {
-		compatible = "regulator-fixed";
-		regulator-name = "usb33";
-		regulator-min-microvolt = <3300000>;
-		regulator-max-microvolt = <3300000>;
-	};
-
 	soc {
 		compatible = "simple-bus";
 		#address-cells = <1>;
@@ -801,7 +801,7 @@ usbotg_hs: usb@49000000 {
 			g-tx-fifo-size = <256 16 16 16 16 16 16 16>;
 			dr_mode = "otg";
 			otg-rev = <0x200>;
-			usb33d-supply = <&usb33>;
+			usb33d-supply = <&scmi_usb33>;
 			status = "disabled";
 		};
 
@@ -1331,8 +1331,8 @@ usbphyc: usbphyc@5a006000 {
 			reg = <0x5a006000 0x1000>;
 			clocks = <&rcc USBPHY_K>;
 			resets = <&rcc USBPHY_R>;
-			vdda1v1-supply = <&reg11>;
-			vdda1v8-supply = <&reg18>;
+			vdda1v1-supply = <&scmi_reg11>;
+			vdda1v8-supply = <&scmi_reg18>;
 			status = "disabled";
 
 			usbphyc_port0: usb-phy@0 {
-- 
2.25.1

