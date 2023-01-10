Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1027B663C9A
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 10:17:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238072AbjAJJRx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 04:17:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232008AbjAJJRm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 04:17:42 -0500
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C418731F;
        Tue, 10 Jan 2023 01:17:40 -0800 (PST)
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30A74xmu015388;
        Tue, 10 Jan 2023 10:17:23 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=selector1;
 bh=zp8f5r7JpJ37hB9gKDJRzZureGPk29xqTzrO5IKaCbo=;
 b=1a8WAOUv1vqPzCWmfxRKUtUAY+ZoAh0xp+6Y1r67wo5zMgrSCmcMSugWhsCNpA9BLvCH
 bpP1jMF6XMZYnyUrYzVnQU/84zuO2WxioGWxBu04LQhzO6A6fs/TCqe+ct/AMI/QOWSM
 2cfNAIyduoUKuNO+FxZzAAoASZksQC7ZZjbAxtMs7c+8rhORxgfCCWiQhBuuQ4nfY9u1
 evBZSFUOl6dkO5Szql5qvPW0UORXstcRztPY69eKWgDb5myZo7uBvRP+QUSxl47EaBm9
 8ObaN/UMdjiA88NgpmECJSfR6MyI7Xmu2gsgFPfgaRdDnA6Kbgmw/dweiFm+D6bEsZba kw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3my0gp0k9c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 10 Jan 2023 10:17:23 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id A0D89100034;
        Tue, 10 Jan 2023 10:17:22 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 9980C20A8CB;
        Tue, 10 Jan 2023 10:17:22 +0100 (CET)
Received: from localhost (10.201.20.178) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.13; Tue, 10 Jan
 2023 10:17:22 +0100
From:   Olivier Moysan <olivier.moysan@foss.st.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>
CC:     Olivier Moysan <olivier.moysan@foss.st.com>,
        <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 1/3] ARM: dts: stm32: add timers support on stm32mp131
Date:   Tue, 10 Jan 2023 10:17:10 +0100
Message-ID: <20230110091713.444395-2-olivier.moysan@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230110091713.444395-1-olivier.moysan@foss.st.com>
References: <20230110091713.444395-1-olivier.moysan@foss.st.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.201.20.178]
X-ClientProxiedBy: EQNCAS1NODE4.st.com (10.75.129.82) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-10_02,2023-01-09_02,2022-06-22_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add timers support to STM32MP13x SoC family.

Signed-off-by: Olivier Moysan <olivier.moysan@foss.st.com>
---
 arch/arm/boot/dts/stm32mp131.dtsi | 557 ++++++++++++++++++++++++++++++
 1 file changed, 557 insertions(+)

diff --git a/arch/arm/boot/dts/stm32mp131.dtsi b/arch/arm/boot/dts/stm32mp131.dtsi
index 2f0f60e4766f..f50051e81ee3 100644
--- a/arch/arm/boot/dts/stm32mp131.dtsi
+++ b/arch/arm/boot/dts/stm32mp131.dtsi
@@ -119,6 +119,221 @@ scmi_shm: scmi-sram@0 {
 			};
 		};
 
+		timers2: timer@40000000 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "st,stm32-timers";
+			reg = <0x40000000 0x400>;
+			interrupts = <GIC_SPI 29 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "global";
+			clocks = <&rcc TIM2_K>;
+			clock-names = "int";
+			dmas = <&dmamux1 18 0x400 0x1>,
+			       <&dmamux1 19 0x400 0x1>,
+			       <&dmamux1 20 0x400 0x1>,
+			       <&dmamux1 21 0x400 0x1>,
+			       <&dmamux1 22 0x400 0x1>;
+			dma-names = "ch1", "ch2", "ch3", "ch4", "up";
+			status = "disabled";
+
+			pwm {
+				compatible = "st,stm32-pwm";
+				#pwm-cells = <3>;
+				status = "disabled";
+			};
+
+			timer@1 {
+				compatible = "st,stm32h7-timer-trigger";
+				reg = <1>;
+				status = "disabled";
+			};
+
+			counter {
+				compatible = "st,stm32-timer-counter";
+				status = "disabled";
+			};
+		};
+
+		timers3: timer@40001000 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "st,stm32-timers";
+			reg = <0x40001000 0x400>;
+			interrupts = <GIC_SPI 30 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "global";
+			clocks = <&rcc TIM3_K>;
+			clock-names = "int";
+			dmas = <&dmamux1 23 0x400 0x1>,
+			       <&dmamux1 24 0x400 0x1>,
+			       <&dmamux1 25 0x400 0x1>,
+			       <&dmamux1 26 0x400 0x1>,
+			       <&dmamux1 27 0x400 0x1>,
+			       <&dmamux1 28 0x400 0x1>;
+			dma-names = "ch1", "ch2", "ch3", "ch4", "up", "trig";
+			status = "disabled";
+
+			pwm {
+				compatible = "st,stm32-pwm";
+				#pwm-cells = <3>;
+				status = "disabled";
+			};
+
+			timer@2 {
+				compatible = "st,stm32h7-timer-trigger";
+				reg = <2>;
+				status = "disabled";
+			};
+
+			counter {
+				compatible = "st,stm32-timer-counter";
+				status = "disabled";
+			};
+		};
+
+		timers4: timer@40002000 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "st,stm32-timers";
+			reg = <0x40002000 0x400>;
+			interrupts = <GIC_SPI 31 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "global";
+			clocks = <&rcc TIM4_K>;
+			clock-names = "int";
+			dmas = <&dmamux1 29 0x400 0x1>,
+			       <&dmamux1 30 0x400 0x1>,
+			       <&dmamux1 31 0x400 0x1>,
+			       <&dmamux1 32 0x400 0x1>;
+			dma-names = "ch1", "ch2", "ch3", "up";
+			status = "disabled";
+
+			pwm {
+				compatible = "st,stm32-pwm";
+				#pwm-cells = <3>;
+				status = "disabled";
+			};
+
+			timer@3 {
+				compatible = "st,stm32h7-timer-trigger";
+				reg = <3>;
+				status = "disabled";
+			};
+
+			counter {
+				compatible = "st,stm32-timer-counter";
+				status = "disabled";
+			};
+		};
+
+		timers5: timer@40003000 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "st,stm32-timers";
+			reg = <0x40003000 0x400>;
+			interrupts = <GIC_SPI 51 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "global";
+			clocks = <&rcc TIM5_K>;
+			clock-names = "int";
+			dmas = <&dmamux1 55 0x400 0x1>,
+			       <&dmamux1 56 0x400 0x1>,
+			       <&dmamux1 57 0x400 0x1>,
+			       <&dmamux1 58 0x400 0x1>,
+			       <&dmamux1 59 0x400 0x1>,
+			       <&dmamux1 60 0x400 0x1>;
+			dma-names = "ch1", "ch2", "ch3", "ch4", "up", "trig";
+			status = "disabled";
+
+			pwm {
+				compatible = "st,stm32-pwm";
+				#pwm-cells = <3>;
+				status = "disabled";
+			};
+
+			timer@4 {
+				compatible = "st,stm32h7-timer-trigger";
+				reg = <4>;
+				status = "disabled";
+			};
+
+			counter {
+				compatible = "st,stm32-timer-counter";
+				status = "disabled";
+			};
+		};
+
+		timers6: timer@40004000 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "st,stm32-timers";
+			reg = <0x40004000 0x400>;
+			interrupts = <GIC_SPI 55 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "global";
+			clocks = <&rcc TIM6_K>;
+			clock-names = "int";
+			dmas = <&dmamux1 69 0x400 0x1>;
+			dma-names = "up";
+			status = "disabled";
+
+			timer@5 {
+				compatible = "st,stm32h7-timer-trigger";
+				reg = <5>;
+				status = "disabled";
+			};
+		};
+
+		timers7: timer@40005000 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "st,stm32-timers";
+			reg = <0x40005000 0x400>;
+			interrupts = <GIC_SPI 56 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "global";
+			clocks = <&rcc TIM7_K>;
+			clock-names = "int";
+			dmas = <&dmamux1 70 0x400 0x1>;
+			dma-names = "up";
+			status = "disabled";
+
+			timer@6 {
+				compatible = "st,stm32h7-timer-trigger";
+				reg = <6>;
+				status = "disabled";
+			};
+		};
+
+		lptimer1: timer@40009000 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "st,stm32-lptimer";
+			reg = <0x40009000 0x400>;
+			interrupts-extended = <&exti 47 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&rcc LPTIM1_K>;
+			clock-names = "mux";
+			wakeup-source;
+			status = "disabled";
+
+			pwm {
+				compatible = "st,stm32-pwm-lp";
+				#pwm-cells = <3>;
+				status = "disabled";
+			};
+
+			trigger@0 {
+				compatible = "st,stm32-lptimer-trigger";
+				reg = <0>;
+				status = "disabled";
+			};
+
+			counter {
+				compatible = "st,stm32-lptimer-counter";
+				status = "disabled";
+			};
+
+			timer {
+				compatible = "st,stm32-lptimer-timer";
+				status = "disabled";
+			};
+		};
+
 		i2s2: audio-controller@4000b000 {
 			compatible = "st,stm32h7-i2s";
 			reg = <0x4000b000 0x400>;
@@ -227,6 +442,88 @@ i2c2: i2c@40013000 {
 			status = "disabled";
 		};
 
+		timers1: timer@44000000 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "st,stm32-timers";
+			reg = <0x44000000 0x400>;
+			interrupts = <GIC_SPI 25 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 26 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 27 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 28 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "brk", "up", "trg-com", "cc";
+			clocks = <&rcc TIM1_K>;
+			clock-names = "int";
+			dmas = <&dmamux1 11 0x400 0x1>,
+			       <&dmamux1 12 0x400 0x1>,
+			       <&dmamux1 13 0x400 0x1>,
+			       <&dmamux1 14 0x400 0x1>,
+			       <&dmamux1 15 0x400 0x1>,
+			       <&dmamux1 16 0x400 0x1>,
+			       <&dmamux1 17 0x400 0x1>;
+			dma-names = "ch1", "ch2", "ch3", "ch4",
+				    "up", "trig", "com";
+			status = "disabled";
+
+			pwm {
+				compatible = "st,stm32-pwm";
+				#pwm-cells = <3>;
+				status = "disabled";
+			};
+
+			timer@0 {
+				compatible = "st,stm32h7-timer-trigger";
+				reg = <0>;
+				status = "disabled";
+			};
+
+			counter {
+				compatible = "st,stm32-timer-counter";
+				status = "disabled";
+			};
+		};
+
+		timers8: timer@44001000 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "st,stm32-timers";
+			reg = <0x44001000 0x400>;
+			interrupts = <GIC_SPI 44 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 45 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 46 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 47 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "brk", "up", "trg-com", "cc";
+			clocks = <&rcc TIM8_K>;
+			clock-names = "int";
+			dmas = <&dmamux1 47 0x400 0x1>,
+			       <&dmamux1 48 0x400 0x1>,
+			       <&dmamux1 49 0x400 0x1>,
+			       <&dmamux1 50 0x400 0x1>,
+			       <&dmamux1 51 0x400 0x1>,
+			       <&dmamux1 52 0x400 0x1>,
+			       <&dmamux1 53 0x400 0x1>;
+			dma-names = "ch1", "ch2", "ch3", "ch4",
+				    "up", "trig", "com";
+			status = "disabled";
+
+			pwm {
+				compatible = "st,stm32-pwm";
+				#pwm-cells = <3>;
+				status = "disabled";
+			};
+
+			timer@7 {
+				compatible = "st,stm32h7-timer-trigger";
+				reg = <7>;
+				status = "disabled";
+			};
+
+			counter {
+				compatible = "st,stm32-timer-counter";
+				status = "disabled";
+			};
+		};
+
 		i2s1: audio-controller@44004000 {
 			compatible = "st,stm32h7-i2s";
 			reg = <0x44004000 0x400>;
@@ -544,6 +841,161 @@ i2c5: i2c@4c006000 {
 			status = "disabled";
 		};
 
+		timers12: timer@4c007000 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "st,stm32-timers";
+			reg = <0x4c007000 0x400>;
+			interrupts = <GIC_SPI 104 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "global";
+			clocks = <&rcc TIM12_K>;
+			clock-names = "int";
+			status = "disabled";
+
+			pwm {
+				compatible = "st,stm32-pwm";
+				#pwm-cells = <3>;
+				status = "disabled";
+			};
+
+			timer@11 {
+				compatible = "st,stm32h7-timer-trigger";
+				reg = <11>;
+				status = "disabled";
+			};
+		};
+
+		timers13: timer@4c008000 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "st,stm32-timers";
+			reg = <0x4c008000 0x400>;
+			interrupts = <GIC_SPI 111 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "global";
+			clocks = <&rcc TIM13_K>;
+			clock-names = "int";
+			status = "disabled";
+
+			pwm {
+				compatible = "st,stm32-pwm";
+				#pwm-cells = <3>;
+				status = "disabled";
+			};
+
+			timer@12 {
+				compatible = "st,stm32h7-timer-trigger";
+				reg = <12>;
+				status = "disabled";
+			};
+		};
+
+		timers14: timer@4c009000 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "st,stm32-timers";
+			reg = <0x4c009000 0x400>;
+			interrupts = <GIC_SPI 112 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "global";
+			clocks = <&rcc TIM14_K>;
+			clock-names = "int";
+			status = "disabled";
+
+			pwm {
+				compatible = "st,stm32-pwm";
+				#pwm-cells = <3>;
+				status = "disabled";
+			};
+
+			timer@13 {
+				compatible = "st,stm32h7-timer-trigger";
+				reg = <13>;
+				status = "disabled";
+			};
+		};
+
+		timers15: timer@4c00a000 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "st,stm32-timers";
+			reg = <0x4c00a000 0x400>;
+			interrupts = <GIC_SPI 101 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "global";
+			clocks = <&rcc TIM15_K>;
+			clock-names = "int";
+			dmas = <&dmamux1 105 0x400 0x1>,
+			       <&dmamux1 106 0x400 0x1>,
+			       <&dmamux1 107 0x400 0x1>,
+			       <&dmamux1 108 0x400 0x1>;
+			dma-names = "ch1", "up", "trig", "com";
+			status = "disabled";
+
+			pwm {
+				compatible = "st,stm32-pwm";
+				#pwm-cells = <3>;
+				status = "disabled";
+			};
+
+			timer@14 {
+				compatible = "st,stm32h7-timer-trigger";
+				reg = <14>;
+				status = "disabled";
+			};
+		};
+
+		timers16: timer@4c00b000 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "st,stm32-timers";
+			reg = <0x4c00b000 0x400>;
+			interrupts = <GIC_SPI 102 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "global";
+			clocks = <&rcc TIM16_K>;
+			clock-names = "int";
+			dmas = <&dmamux1 109 0x400 0x1>,
+			       <&dmamux1 110 0x400 0x1>;
+			dma-names = "ch1", "up";
+			status = "disabled";
+
+			pwm {
+				compatible = "st,stm32-pwm";
+				#pwm-cells = <3>;
+				status = "disabled";
+			};
+
+			timer@15 {
+				compatible = "st,stm32h7-timer-trigger";
+				reg = <15>;
+				status = "disabled";
+			};
+		};
+
+		timers17: timer@4c00c000 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "st,stm32-timers";
+			reg = <0x4c00c000 0x400>;
+			interrupts = <GIC_SPI 103 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "global";
+			clocks = <&rcc TIM17_K>;
+			clock-names = "int";
+			dmas = <&dmamux1 111 0x400 0x1>,
+			       <&dmamux1 112 0x400 0x1>;
+			dma-names = "ch1", "up";
+			status = "disabled";
+
+			pwm {
+				compatible = "st,stm32-pwm";
+				#pwm-cells = <3>;
+				status = "disabled";
+			};
+
+			timer@16 {
+				compatible = "st,stm32h7-timer-trigger";
+				reg = <16>;
+				status = "disabled";
+			};
+		};
+
 		rcc: rcc@50000000 {
 			compatible = "st,stm32mp13-rcc", "syscon";
 			reg = <0x50000000 0x1000>;
@@ -570,6 +1022,111 @@ syscfg: syscon@50020000 {
 			clocks = <&rcc SYSCFG>;
 		};
 
+		lptimer2: timer@50021000 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "st,stm32-lptimer";
+			reg = <0x50021000 0x400>;
+			interrupts-extended = <&exti 48 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&rcc LPTIM2_K>;
+			clock-names = "mux";
+			wakeup-source;
+			status = "disabled";
+
+			pwm {
+				compatible = "st,stm32-pwm-lp";
+				#pwm-cells = <3>;
+				status = "disabled";
+			};
+
+			trigger@1 {
+				compatible = "st,stm32-lptimer-trigger";
+				reg = <1>;
+				status = "disabled";
+			};
+
+			counter {
+				compatible = "st,stm32-lptimer-counter";
+				status = "disabled";
+			};
+
+			timer {
+				compatible = "st,stm32-lptimer-timer";
+				status = "disabled";
+			};
+		};
+
+		lptimer3: timer@50022000 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "st,stm32-lptimer";
+			reg = <0x50022000 0x400>;
+			interrupts-extended = <&exti 50 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&rcc LPTIM3_K>;
+			clock-names = "mux";
+			wakeup-source;
+			status = "disabled";
+
+			pwm {
+				compatible = "st,stm32-pwm-lp";
+				#pwm-cells = <3>;
+				status = "disabled";
+			};
+
+			trigger@2 {
+				compatible = "st,stm32-lptimer-trigger";
+				reg = <2>;
+				status = "disabled";
+			};
+
+			timer {
+				compatible = "st,stm32-lptimer-timer";
+				status = "disabled";
+			};
+		};
+
+		lptimer4: timer@50023000 {
+			compatible = "st,stm32-lptimer";
+			reg = <0x50023000 0x400>;
+			interrupts-extended = <&exti 52 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&rcc LPTIM4_K>;
+			clock-names = "mux";
+			wakeup-source;
+			status = "disabled";
+
+			pwm {
+				compatible = "st,stm32-pwm-lp";
+				#pwm-cells = <3>;
+				status = "disabled";
+			};
+
+			timer {
+				compatible = "st,stm32-lptimer-timer";
+				status = "disabled";
+			};
+		};
+
+		lptimer5: timer@50024000 {
+			compatible = "st,stm32-lptimer";
+			reg = <0x50024000 0x400>;
+			interrupts-extended = <&exti 53 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&rcc LPTIM5_K>;
+			clock-names = "mux";
+			wakeup-source;
+			status = "disabled";
+
+			pwm {
+				compatible = "st,stm32-pwm-lp";
+				#pwm-cells = <3>;
+				status = "disabled";
+			};
+
+			timer {
+				compatible = "st,stm32-lptimer-timer";
+				status = "disabled";
+			};
+		};
+
 		mdma: dma-controller@58000000 {
 			compatible = "st,stm32h7-mdma";
 			reg = <0x58000000 0x1000>;
-- 
2.25.1

