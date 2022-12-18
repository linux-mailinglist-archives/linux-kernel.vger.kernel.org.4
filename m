Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16AF2650441
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Dec 2022 19:10:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230152AbiLRSK2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Dec 2022 13:10:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230499AbiLRSKC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Dec 2022 13:10:02 -0500
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFCB6D6526;
        Sun, 18 Dec 2022 09:05:55 -0800 (PST)
Received: by mail-il1-x134.google.com with SMTP id y2so3741429ily.5;
        Sun, 18 Dec 2022 09:05:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OgOSUqKhKmN0gkj/ZYhYVdSQNMe/JfU2z8Ox21C/PKc=;
        b=oSovyA7APlyKf7MOPiKXb/QkUKMc2CL02XPXvn1xFgfpOyBDfJu5uRGwxU68f2qKlh
         kpSr+9aK2zk3LA+1Avy9stR80djC2M3MmhOCus4tvJPra20BKooLT3SBSiaQnAdDy6N+
         XF8nhpWr3877mVxm2SGhZTlQkyGzyo8r3FddCvw4oyXLFQnoRCiEEggPuCId1g9TpJUa
         /LlTFy9ZeZsEvuuNXP8aeDf+P1JnWopBbL8ColIi0F2bEpro62m6fjCMPeqE7HnsV4J2
         mXAWSsSWqHnw2Z1kN0bO6ZPRHkDJ0kn8S3hGqJLNiBs3S6AnC9V3LaEcy+KrgWXODfKV
         0nPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OgOSUqKhKmN0gkj/ZYhYVdSQNMe/JfU2z8Ox21C/PKc=;
        b=5PQbrAdSoyJOcZJZ7ZLyRxAX3S0UpXV8XSQTZDl7vSzeqWg2HfiQ2eMJKY3FMssMzj
         XYB3NKn//9jm2qIBB4Wwm/n+CIqRbFsCbAxNUE3X0PvMvO26luKgUIdbkGfiJ1+YwolU
         I7tbiFB2h96ptHnU1bBQ4gQ2oIuKCN8iZlqNTerpTjhe/qHAxuamEIwd/h9R8p4znimH
         EL02gGD79sCo6zpfRmaxr1CC3vJwxdOHYBI/hDbGg1aWT9je12jzUiAFuwhXpDv66VC7
         JoguAD+Ca1DeZ5T0bAxsTGe6o9EIR169HcLsxwvCQW1zKc5AxydapAgzJL93vE6oiybr
         1GHQ==
X-Gm-Message-State: AFqh2kqzqARaIcFMAREQsCD810Kg/2XA1pj6Ph0tpqVS7D4EURSXV1kk
        wUsoid3TdG+xRWO+xTzPCOI=
X-Google-Smtp-Source: AMrXdXs6L4V8GTvalb5dTD0ZHa08kBUqeHPwuHOh2OVborwiR2Mlj8A7tn12vGnNWCdM/odmnpVjlg==
X-Received: by 2002:a92:c805:0:b0:303:452b:27e1 with SMTP id v5-20020a92c805000000b00303452b27e1mr3749960iln.28.1671383154119;
        Sun, 18 Dec 2022 09:05:54 -0800 (PST)
Received: from aford-IdeaCentre-A730.lan ([2601:447:d001:9aea:c8ad:17b9:7862:6614])
        by smtp.gmail.com with ESMTPSA id n15-20020a92dd0f000000b003032a97913asm2525296ilm.17.2022.12.18.09.05.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Dec 2022 09:05:53 -0800 (PST)
From:   Adam Ford <aford173@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     aford@beaconembedded.com, marex@denx.de,
        Adam Ford <aford173@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: imx8mp: Enable spba-bus on AIPS3
Date:   Sun, 18 Dec 2022 11:05:44 -0600
Message-Id: <20221218170545.1472746-1-aford173@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is an SPBA bus on AIPS3 which includes ecspi1-3,
UART1-3, and Flexcan1-2 according to the TRM.

Signed-off-by: Adam Ford <aford173@gmail.com>

diff --git a/arch/arm64/boot/dts/freescale/imx8mp.dtsi b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
index 2ce45e7cbbdf..9b0a47e7b8fd 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
@@ -719,121 +719,129 @@ aips3: bus@30800000 {
 			#size-cells = <1>;
 			ranges;
 
-			ecspi1: spi@30820000 {
+			spba-bus@30800000 {
+				compatible = "fsl,spba-bus", "simple-bus";
+				reg = <0x30800000 0x100000>;
 				#address-cells = <1>;
-				#size-cells = <0>;
-				compatible = "fsl,imx8mp-ecspi", "fsl,imx6ul-ecspi";
-				reg = <0x30820000 0x10000>;
-				interrupts = <GIC_SPI 31 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&clk IMX8MP_CLK_ECSPI1_ROOT>,
-					 <&clk IMX8MP_CLK_ECSPI1_ROOT>;
-				clock-names = "ipg", "per";
-				assigned-clock-rates = <80000000>;
-				assigned-clocks = <&clk IMX8MP_CLK_ECSPI1>;
-				assigned-clock-parents = <&clk IMX8MP_SYS_PLL1_800M>;
-				dmas = <&sdma1 0 7 1>, <&sdma1 1 7 2>;
-				dma-names = "rx", "tx";
-				status = "disabled";
-			};
+				#size-cells = <1>;
+				ranges;
 
-			ecspi2: spi@30830000 {
-				#address-cells = <1>;
-				#size-cells = <0>;
-				compatible = "fsl,imx8mp-ecspi", "fsl,imx6ul-ecspi";
-				reg = <0x30830000 0x10000>;
-				interrupts = <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&clk IMX8MP_CLK_ECSPI2_ROOT>,
-					 <&clk IMX8MP_CLK_ECSPI2_ROOT>;
-				clock-names = "ipg", "per";
-				assigned-clock-rates = <80000000>;
-				assigned-clocks = <&clk IMX8MP_CLK_ECSPI2>;
-				assigned-clock-parents = <&clk IMX8MP_SYS_PLL1_800M>;
-				dmas = <&sdma1 2 7 1>, <&sdma1 3 7 2>;
-				dma-names = "rx", "tx";
-				status = "disabled";
-			};
+				ecspi1: spi@30820000 {
+					#address-cells = <1>;
+					#size-cells = <0>;
+					compatible = "fsl,imx8mp-ecspi", "fsl,imx6ul-ecspi";
+					reg = <0x30820000 0x10000>;
+					interrupts = <GIC_SPI 31 IRQ_TYPE_LEVEL_HIGH>;
+					clocks = <&clk IMX8MP_CLK_ECSPI1_ROOT>,
+						 <&clk IMX8MP_CLK_ECSPI1_ROOT>;
+					clock-names = "ipg", "per";
+					assigned-clock-rates = <80000000>;
+					assigned-clocks = <&clk IMX8MP_CLK_ECSPI1>;
+					assigned-clock-parents = <&clk IMX8MP_SYS_PLL1_800M>;
+					dmas = <&sdma1 0 7 1>, <&sdma1 1 7 2>;
+					dma-names = "rx", "tx";
+					status = "disabled";
+				};
 
-			ecspi3: spi@30840000 {
-				#address-cells = <1>;
-				#size-cells = <0>;
-				compatible = "fsl,imx8mp-ecspi", "fsl,imx6ul-ecspi";
-				reg = <0x30840000 0x10000>;
-				interrupts = <GIC_SPI 33 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&clk IMX8MP_CLK_ECSPI3_ROOT>,
-					 <&clk IMX8MP_CLK_ECSPI3_ROOT>;
-				clock-names = "ipg", "per";
-				assigned-clock-rates = <80000000>;
-				assigned-clocks = <&clk IMX8MP_CLK_ECSPI3>;
-				assigned-clock-parents = <&clk IMX8MP_SYS_PLL1_800M>;
-				dmas = <&sdma1 4 7 1>, <&sdma1 5 7 2>;
-				dma-names = "rx", "tx";
-				status = "disabled";
-			};
+				ecspi2: spi@30830000 {
+					#address-cells = <1>;
+					#size-cells = <0>;
+					compatible = "fsl,imx8mp-ecspi", "fsl,imx6ul-ecspi";
+					reg = <0x30830000 0x10000>;
+					interrupts = <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>;
+					clocks = <&clk IMX8MP_CLK_ECSPI2_ROOT>,
+						 <&clk IMX8MP_CLK_ECSPI2_ROOT>;
+					clock-names = "ipg", "per";
+					assigned-clock-rates = <80000000>;
+					assigned-clocks = <&clk IMX8MP_CLK_ECSPI2>;
+					assigned-clock-parents = <&clk IMX8MP_SYS_PLL1_800M>;
+					dmas = <&sdma1 2 7 1>, <&sdma1 3 7 2>;
+					dma-names = "rx", "tx";
+					status = "disabled";
+				};
 
-			uart1: serial@30860000 {
-				compatible = "fsl,imx8mp-uart", "fsl,imx6q-uart";
-				reg = <0x30860000 0x10000>;
-				interrupts = <GIC_SPI 26 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&clk IMX8MP_CLK_UART1_ROOT>,
-					 <&clk IMX8MP_CLK_UART1_ROOT>;
-				clock-names = "ipg", "per";
-				dmas = <&sdma1 22 4 0>, <&sdma1 23 4 0>;
-				dma-names = "rx", "tx";
-				status = "disabled";
-			};
+				ecspi3: spi@30840000 {
+					#address-cells = <1>;
+					#size-cells = <0>;
+					compatible = "fsl,imx8mp-ecspi", "fsl,imx6ul-ecspi";
+					reg = <0x30840000 0x10000>;
+					interrupts = <GIC_SPI 33 IRQ_TYPE_LEVEL_HIGH>;
+					clocks = <&clk IMX8MP_CLK_ECSPI3_ROOT>,
+						 <&clk IMX8MP_CLK_ECSPI3_ROOT>;
+					clock-names = "ipg", "per";
+					assigned-clock-rates = <80000000>;
+					assigned-clocks = <&clk IMX8MP_CLK_ECSPI3>;
+					assigned-clock-parents = <&clk IMX8MP_SYS_PLL1_800M>;
+					dmas = <&sdma1 4 7 1>, <&sdma1 5 7 2>;
+					dma-names = "rx", "tx";
+					status = "disabled";
+				};
 
-			uart3: serial@30880000 {
-				compatible = "fsl,imx8mp-uart", "fsl,imx6q-uart";
-				reg = <0x30880000 0x10000>;
-				interrupts = <GIC_SPI 28 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&clk IMX8MP_CLK_UART3_ROOT>,
-					 <&clk IMX8MP_CLK_UART3_ROOT>;
-				clock-names = "ipg", "per";
-				dmas = <&sdma1 26 4 0>, <&sdma1 27 4 0>;
-				dma-names = "rx", "tx";
-				status = "disabled";
-			};
+				uart1: serial@30860000 {
+					compatible = "fsl,imx8mp-uart", "fsl,imx6q-uart";
+					reg = <0x30860000 0x10000>;
+					interrupts = <GIC_SPI 26 IRQ_TYPE_LEVEL_HIGH>;
+					clocks = <&clk IMX8MP_CLK_UART1_ROOT>,
+						 <&clk IMX8MP_CLK_UART1_ROOT>;
+					clock-names = "ipg", "per";
+					dmas = <&sdma1 22 4 0>, <&sdma1 23 4 0>;
+					dma-names = "rx", "tx";
+					status = "disabled";
+				};
 
-			uart2: serial@30890000 {
-				compatible = "fsl,imx8mp-uart", "fsl,imx6q-uart";
-				reg = <0x30890000 0x10000>;
-				interrupts = <GIC_SPI 27 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&clk IMX8MP_CLK_UART2_ROOT>,
-					 <&clk IMX8MP_CLK_UART2_ROOT>;
-				clock-names = "ipg", "per";
-				dmas = <&sdma1 24 4 0>, <&sdma1 25 4 0>;
-				dma-names = "rx", "tx";
-				status = "disabled";
-			};
+				uart3: serial@30880000 {
+					compatible = "fsl,imx8mp-uart", "fsl,imx6q-uart";
+					reg = <0x30880000 0x10000>;
+					interrupts = <GIC_SPI 28 IRQ_TYPE_LEVEL_HIGH>;
+					clocks = <&clk IMX8MP_CLK_UART3_ROOT>,
+						 <&clk IMX8MP_CLK_UART3_ROOT>;
+					clock-names = "ipg", "per";
+					dmas = <&sdma1 26 4 0>, <&sdma1 27 4 0>;
+					dma-names = "rx", "tx";
+					status = "disabled";
+				};
 
-			flexcan1: can@308c0000 {
-				compatible = "fsl,imx8mp-flexcan";
-				reg = <0x308c0000 0x10000>;
-				interrupts = <GIC_SPI 142 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&clk IMX8MP_CLK_IPG_ROOT>,
-					 <&clk IMX8MP_CLK_CAN1_ROOT>;
-				clock-names = "ipg", "per";
-				assigned-clocks = <&clk IMX8MP_CLK_CAN1>;
-				assigned-clock-parents = <&clk IMX8MP_SYS_PLL1_40M>;
-				assigned-clock-rates = <40000000>;
-				fsl,clk-source = /bits/ 8 <0>;
-				fsl,stop-mode = <&gpr 0x10 4>;
-				status = "disabled";
-			};
+				uart2: serial@30890000 {
+					compatible = "fsl,imx8mp-uart", "fsl,imx6q-uart";
+					reg = <0x30890000 0x10000>;
+					interrupts = <GIC_SPI 27 IRQ_TYPE_LEVEL_HIGH>;
+					clocks = <&clk IMX8MP_CLK_UART2_ROOT>,
+						 <&clk IMX8MP_CLK_UART2_ROOT>;
+					clock-names = "ipg", "per";
+					dmas = <&sdma1 24 4 0>, <&sdma1 25 4 0>;
+					dma-names = "rx", "tx";
+					status = "disabled";
+				};
 
-			flexcan2: can@308d0000 {
-				compatible = "fsl,imx8mp-flexcan";
-				reg = <0x308d0000 0x10000>;
-				interrupts = <GIC_SPI 144 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&clk IMX8MP_CLK_IPG_ROOT>,
-					 <&clk IMX8MP_CLK_CAN2_ROOT>;
-				clock-names = "ipg", "per";
-				assigned-clocks = <&clk IMX8MP_CLK_CAN2>;
-				assigned-clock-parents = <&clk IMX8MP_SYS_PLL1_40M>;
-				assigned-clock-rates = <40000000>;
-				fsl,clk-source = /bits/ 8 <0>;
-				fsl,stop-mode = <&gpr 0x10 5>;
-				status = "disabled";
+				flexcan1: can@308c0000 {
+					compatible = "fsl,imx8mp-flexcan";
+					reg = <0x308c0000 0x10000>;
+					interrupts = <GIC_SPI 142 IRQ_TYPE_LEVEL_HIGH>;
+					clocks = <&clk IMX8MP_CLK_IPG_ROOT>,
+						 <&clk IMX8MP_CLK_CAN1_ROOT>;
+					clock-names = "ipg", "per";
+					assigned-clocks = <&clk IMX8MP_CLK_CAN1>;
+					assigned-clock-parents = <&clk IMX8MP_SYS_PLL1_40M>;
+					assigned-clock-rates = <40000000>;
+					fsl,clk-source = /bits/ 8 <0>;
+					fsl,stop-mode = <&gpr 0x10 4>;
+					status = "disabled";
+				};
+
+				flexcan2: can@308d0000 {
+					compatible = "fsl,imx8mp-flexcan";
+					reg = <0x308d0000 0x10000>;
+					interrupts = <GIC_SPI 144 IRQ_TYPE_LEVEL_HIGH>;
+					clocks = <&clk IMX8MP_CLK_IPG_ROOT>,
+						 <&clk IMX8MP_CLK_CAN2_ROOT>;
+					clock-names = "ipg", "per";
+					assigned-clocks = <&clk IMX8MP_CLK_CAN2>;
+					assigned-clock-parents = <&clk IMX8MP_SYS_PLL1_40M>;
+					assigned-clock-rates = <40000000>;
+					fsl,clk-source = /bits/ 8 <0>;
+					fsl,stop-mode = <&gpr 0x10 5>;
+					status = "disabled";
+				};
 			};
 
 			crypto: crypto@30900000 {
-- 
2.34.1

