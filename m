Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C700462EB17
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 02:37:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240943AbiKRBhN convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 17 Nov 2022 20:37:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240942AbiKRBgo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 20:36:44 -0500
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B13A6635F;
        Thu, 17 Nov 2022 17:36:12 -0800 (PST)
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
        by fd01.gateway.ufhost.com (Postfix) with ESMTP id 91ED124E035;
        Fri, 18 Nov 2022 09:06:34 +0800 (CST)
Received: from EXMBX072.cuchost.com (172.16.6.82) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Fri, 18 Nov
 2022 09:06:34 +0800
Received: from ubuntu.localdomain (183.27.96.116) by EXMBX072.cuchost.com
 (172.16.6.82) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Fri, 18 Nov
 2022 09:06:33 +0800
From:   Hal Feng <hal.feng@starfivetech.com>
To:     <linux-riscv@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-clk@vger.kernel.org>
CC:     Conor Dooley <conor@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        "Rob Herring" <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        "Michael Turquette" <mturquette@baylibre.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        Hal Feng <hal.feng@starfivetech.com>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 07/14] dt-bindings: clock: Add StarFive JH7110 system and always-on clock definitions
Date:   Fri, 18 Nov 2022 09:06:20 +0800
Message-ID: <20221118010627.70576-8-hal.feng@starfivetech.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221118010627.70576-1-hal.feng@starfivetech.com>
References: <20221118010627.70576-1-hal.feng@starfivetech.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [183.27.96.116]
X-ClientProxiedBy: EXCAS064.cuchost.com (172.16.6.24) To EXMBX072.cuchost.com
 (172.16.6.82)
X-YovoleRuleAgent: yovoleflag
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Emil Renner Berthing <kernel@esmil.dk>

Add all clock outputs for the StarFive JH7110 system (SYS) and
always-on (AON) clock generator.

Signed-off-by: Emil Renner Berthing <kernel@esmil.dk>
Signed-off-by: Hal Feng <hal.feng@starfivetech.com>
---
 MAINTAINERS                                 |   5 +-
 include/dt-bindings/clock/starfive-jh7110.h | 234 ++++++++++++++++++++
 2 files changed, 237 insertions(+), 2 deletions(-)
 create mode 100644 include/dt-bindings/clock/starfive-jh7110.h

diff --git a/MAINTAINERS b/MAINTAINERS
index e6f1060e7964..e97dac9c0ee4 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -19598,12 +19598,13 @@ M:	Ion Badulescu <ionut@badula.org>
 S:	Odd Fixes
 F:	drivers/net/ethernet/adaptec/starfire*
 
-STARFIVE JH7100 CLOCK DRIVERS
+STARFIVE CLOCK DRIVERS
 M:	Emil Renner Berthing <kernel@esmil.dk>
+M:	Hal Feng <hal.feng@starfivetech.com>
 S:	Maintained
 F:	Documentation/devicetree/bindings/clock/starfive,jh7100-*.yaml
 F:	drivers/clk/starfive/
-F:	include/dt-bindings/clock/starfive-jh7100*.h
+F:	include/dt-bindings/clock/starfive*
 
 STARFIVE JH7100 PINCTRL DRIVER
 M:	Emil Renner Berthing <kernel@esmil.dk>
diff --git a/include/dt-bindings/clock/starfive-jh7110.h b/include/dt-bindings/clock/starfive-jh7110.h
new file mode 100644
index 000000000000..204f63d4d821
--- /dev/null
+++ b/include/dt-bindings/clock/starfive-jh7110.h
@@ -0,0 +1,234 @@
+/* SPDX-License-Identifier: GPL-2.0 OR MIT */
+/*
+ * Copyright 2022 Emil Renner Berthing <kernel@esmil.dk>
+ */
+
+#ifndef __DT_BINDINGS_CLOCK_STARFIVE_JH7110_H__
+#define __DT_BINDINGS_CLOCK_STARFIVE_JH7110_H__
+
+/* SYSCRG clocks */
+#define JH7110_SYSCLK_CPU_ROOT			0
+#define JH7110_SYSCLK_CPU_CORE			1
+#define JH7110_SYSCLK_CPU_BUS			2
+#define JH7110_SYSCLK_GPU_ROOT			3
+#define JH7110_SYSCLK_PERH_ROOT			4
+#define JH7110_SYSCLK_BUS_ROOT			5
+#define JH7110_SYSCLK_NOCSTG_BUS		6
+#define JH7110_SYSCLK_AXI_CFG0			7
+#define JH7110_SYSCLK_STG_AXIAHB		8
+#define JH7110_SYSCLK_AHB0			9
+#define JH7110_SYSCLK_AHB1			10
+#define JH7110_SYSCLK_APB_BUS_FUNC		11
+#define JH7110_SYSCLK_APB0			12
+#define JH7110_SYSCLK_PLL0_DIV2			13
+#define JH7110_SYSCLK_PLL1_DIV2			14
+#define JH7110_SYSCLK_PLL2_DIV2			15
+#define JH7110_SYSCLK_AUDIO_ROOT		16
+#define JH7110_SYSCLK_MCLK_INNER		17
+#define JH7110_SYSCLK_MCLK			18
+#define JH7110_SYSCLK_MCLK_OUT			19
+#define JH7110_SYSCLK_ISP_2X			20
+#define JH7110_SYSCLK_ISP_AXI			21
+#define JH7110_SYSCLK_GCLK0			22
+#define JH7110_SYSCLK_GCLK1			23
+#define JH7110_SYSCLK_GCLK2			24
+#define JH7110_SYSCLK_CORE			25
+#define JH7110_SYSCLK_CORE1			26
+#define JH7110_SYSCLK_CORE2			27
+#define JH7110_SYSCLK_CORE3			28
+#define JH7110_SYSCLK_CORE4			29
+#define JH7110_SYSCLK_DEBUG			30
+#define JH7110_SYSCLK_RTC_TOGGLE		31
+#define JH7110_SYSCLK_TRACE0			32
+#define JH7110_SYSCLK_TRACE1			33
+#define JH7110_SYSCLK_TRACE2			34
+#define JH7110_SYSCLK_TRACE3			35
+#define JH7110_SYSCLK_TRACE4			36
+#define JH7110_SYSCLK_TRACE_COM			37
+#define JH7110_SYSCLK_NOC_BUS_CPU_AXI		38
+#define JH7110_SYSCLK_NOC_BUS_AXICFG0_AXI	39
+#define JH7110_SYSCLK_OSC_DIV2			40
+#define JH7110_SYSCLK_PLL1_DIV4			41
+#define JH7110_SYSCLK_PLL1_DIV8			42
+#define JH7110_SYSCLK_DDR_BUS			43
+#define JH7110_SYSCLK_DDR_AXI			44
+#define JH7110_SYSCLK_GPU_CORE			45
+#define JH7110_SYSCLK_GPU_CORE_CLK		46
+#define JH7110_SYSCLK_GPU_SYS_CLK		47
+#define JH7110_SYSCLK_GPU_APB			48
+#define JH7110_SYSCLK_GPU_RTC_TOGGLE		49
+#define JH7110_SYSCLK_NOC_BUS_GPU_AXI		50
+#define JH7110_SYSCLK_ISP_TOP_ISPCORE_2X	51
+#define JH7110_SYSCLK_ISP_TOP_ISP_AXI		52
+#define JH7110_SYSCLK_NOC_BUS_ISP_AXI		53
+#define JH7110_SYSCLK_HIFI4_CORE		54
+#define JH7110_SYSCLK_HIFI4_AXI			55
+#define JH7110_SYSCLK_AXI_CFG1_DEC_MAIN		56
+#define JH7110_SYSCLK_AXI_CFG1_DEC_AHB		57
+#define JH7110_SYSCLK_VOUT_SRC			58
+#define JH7110_SYSCLK_VOUT_AXI			59
+#define JH7110_SYSCLK_NOC_BUS_DISP_AXI		60
+#define JH7110_SYSCLK_VOUT_TOP_VOUT_AHB		61
+#define JH7110_SYSCLK_VOUT_TOP_VOUT_AXI		62
+#define JH7110_SYSCLK_VOUT_TOP_HDMITX0_MCLK	63
+#define JH7110_SYSCLK_VOUT_TOP_MIPIPHY_REF	64
+#define JH7110_SYSCLK_JPEGC_AXI			65
+#define JH7110_SYSCLK_CODAJ12_AXI		66
+#define JH7110_SYSCLK_CODAJ12_CORE		67
+#define JH7110_SYSCLK_CODAJ12_APB		68
+#define JH7110_SYSCLK_VDEC_AXI			69
+#define JH7110_SYSCLK_WAVE511_AXI		70
+#define JH7110_SYSCLK_WAVE511_BPU		71
+#define JH7110_SYSCLK_WAVE511_VCE		72
+#define JH7110_SYSCLK_WAVE511_APB		73
+#define JH7110_SYSCLK_VDEC_JPG_ARB_JPG		74
+#define JH7110_SYSCLK_VDEC_JPG_ARB_MAIN		75
+#define JH7110_SYSCLK_NOC_BUS_VDEC_AXI		76
+#define JH7110_SYSCLK_VENC_AXI			77
+#define JH7110_SYSCLK_WAVE420L_AXI		78
+#define JH7110_SYSCLK_WAVE420L_BPU		79
+#define JH7110_SYSCLK_WAVE420L_VCE		80
+#define JH7110_SYSCLK_WAVE420L_APB		81
+#define JH7110_SYSCLK_NOC_BUS_VENC_AXI		82
+#define JH7110_SYSCLK_AXI_CFG0_DEC_MAIN_DIV	83
+#define JH7110_SYSCLK_AXI_CFG0_DEC_MAIN		84
+#define JH7110_SYSCLK_AXI_CFG0_DEC_HIFI4	85
+#define JH7110_SYSCLK_AXIMEM2_128B_AXI		86
+#define JH7110_SYSCLK_QSPI_AHB			87
+#define JH7110_SYSCLK_QSPI_APB			88
+#define JH7110_SYSCLK_QSPI_REF_SRC		89
+#define JH7110_SYSCLK_QSPI_REF			90
+#define JH7110_SYSCLK_SDIO0_AHB			91
+#define JH7110_SYSCLK_SDIO1_AHB			92
+#define JH7110_SYSCLK_SDIO0_SDCARD		93
+#define JH7110_SYSCLK_SDIO1_SDCARD		94
+#define JH7110_SYSCLK_USB_125M			95
+#define JH7110_SYSCLK_NOC_BUS_STG_AXI		96
+#define JH7110_SYSCLK_GMAC1_AHB			97
+#define JH7110_SYSCLK_GMAC1_AXI			98
+#define JH7110_SYSCLK_GMAC_SRC			99
+#define JH7110_SYSCLK_GMAC1_GTXCLK		100
+#define JH7110_SYSCLK_GMAC1_RMII_RTX		101
+#define JH7110_SYSCLK_GMAC1_PTP			102
+#define JH7110_SYSCLK_GMAC1_RX			103
+#define JH7110_SYSCLK_GMAC1_RX_INV		104
+#define JH7110_SYSCLK_GMAC1_TX			105
+#define JH7110_SYSCLK_GMAC1_TX_INV		106
+#define JH7110_SYSCLK_GMAC1_GTXC		107
+#define JH7110_SYSCLK_GMAC0_GTXCLK		108
+#define JH7110_SYSCLK_GMAC0_PTP			109
+#define JH7110_SYSCLK_GMAC_PHY			110
+#define JH7110_SYSCLK_GMAC0_GTXC		111
+#define JH7110_SYSCLK_IOMUX			112
+#define JH7110_SYSCLK_MAILBOX			113
+#define JH7110_SYSCLK_INT_CTRL_APB		114
+#define JH7110_SYSCLK_CAN0_APB			115
+#define JH7110_SYSCLK_CAN0_TIMER		116
+#define JH7110_SYSCLK_CAN0_CAN			117
+#define JH7110_SYSCLK_CAN1_APB			118
+#define JH7110_SYSCLK_CAN1_TIMER		119
+#define JH7110_SYSCLK_CAN1_CAN			120
+#define JH7110_SYSCLK_PWM_APB			121
+#define JH7110_SYSCLK_WDT_APB			122
+#define JH7110_SYSCLK_WDT_CORE			123
+#define JH7110_SYSCLK_TIMER_APB			124
+#define JH7110_SYSCLK_TIMER0			125
+#define JH7110_SYSCLK_TIMER1			126
+#define JH7110_SYSCLK_TIMER2			127
+#define JH7110_SYSCLK_TIMER3			128
+#define JH7110_SYSCLK_TEMP_APB			129
+#define JH7110_SYSCLK_TEMP_CORE			130
+#define JH7110_SYSCLK_SPI0_APB			131
+#define JH7110_SYSCLK_SPI1_APB			132
+#define JH7110_SYSCLK_SPI2_APB			133
+#define JH7110_SYSCLK_SPI3_APB			134
+#define JH7110_SYSCLK_SPI4_APB			135
+#define JH7110_SYSCLK_SPI5_APB			136
+#define JH7110_SYSCLK_SPI6_APB			137
+#define JH7110_SYSCLK_I2C0_APB			138
+#define JH7110_SYSCLK_I2C1_APB			139
+#define JH7110_SYSCLK_I2C2_APB			140
+#define JH7110_SYSCLK_I2C3_APB			141
+#define JH7110_SYSCLK_I2C4_APB			142
+#define JH7110_SYSCLK_I2C5_APB			143
+#define JH7110_SYSCLK_I2C6_APB			144
+#define JH7110_SYSCLK_UART0_APB			145
+#define JH7110_SYSCLK_UART0_CORE		146
+#define JH7110_SYSCLK_UART1_APB			147
+#define JH7110_SYSCLK_UART1_CORE		148
+#define JH7110_SYSCLK_UART2_APB			149
+#define JH7110_SYSCLK_UART2_CORE		150
+#define JH7110_SYSCLK_UART3_APB			151
+#define JH7110_SYSCLK_UART3_CORE		152
+#define JH7110_SYSCLK_UART4_APB			153
+#define JH7110_SYSCLK_UART4_CORE		154
+#define JH7110_SYSCLK_UART5_APB			155
+#define JH7110_SYSCLK_UART5_CORE		156
+#define JH7110_SYSCLK_PWMDAC_APB		157
+#define JH7110_SYSCLK_PWMDAC_CORE		158
+#define JH7110_SYSCLK_SPDIF_APB			159
+#define JH7110_SYSCLK_SPDIF_CORE		160
+#define JH7110_SYSCLK_I2STX0_APB		161
+#define JH7110_SYSCLK_I2STX0_BCLK_MST		162
+#define JH7110_SYSCLK_I2STX0_BCLK_MST_INV	163
+#define JH7110_SYSCLK_I2STX0_LRCK_MST		164
+#define JH7110_SYSCLK_I2STX0_BCLK		165
+#define JH7110_SYSCLK_I2STX0_BCLK_INV		166
+#define JH7110_SYSCLK_I2STX0_LRCK		167
+#define JH7110_SYSCLK_I2STX1_APB		168
+#define JH7110_SYSCLK_I2STX1_BCLK_MST		169
+#define JH7110_SYSCLK_I2STX1_BCLK_MST_INV	170
+#define JH7110_SYSCLK_I2STX1_LRCK_MST		171
+#define JH7110_SYSCLK_I2STX1_BCLK		172
+#define JH7110_SYSCLK_I2STX1_BCLK_INV		173
+#define JH7110_SYSCLK_I2STX1_LRCK		174
+#define JH7110_SYSCLK_I2SRX_APB			175
+#define JH7110_SYSCLK_I2SRX_BCLK_MST		176
+#define JH7110_SYSCLK_I2SRX_BCLK_MST_INV	177
+#define JH7110_SYSCLK_I2SRX_LRCK_MST		178
+#define JH7110_SYSCLK_I2SRX_BCLK		179
+#define JH7110_SYSCLK_I2SRX_BCLK_INV		180
+#define JH7110_SYSCLK_I2SRX_LRCK		181
+#define JH7110_SYSCLK_PDM_DMIC			182
+#define JH7110_SYSCLK_PDM_APB			183
+#define JH7110_SYSCLK_TDM_AHB			184
+#define JH7110_SYSCLK_TDM_APB			185
+#define JH7110_SYSCLK_TDM_INTERNAL		186
+#define JH7110_SYSCLK_TDM_CLK_TDM		187
+#define JH7110_SYSCLK_TDM_CLK_TDM_N		188
+#define JH7110_SYSCLK_JTAG_CERTIFICATION_TRNG	189
+
+#define JH7110_SYSCLK_PLL0_OUT			190
+#define JH7110_SYSCLK_PLL1_OUT			191
+#define JH7110_SYSCLK_PLL2_OUT			192
+#define JH7110_SYSCLK_PCLK2_MUX_FUNC		193
+#define JH7110_SYSCLK_PCLK2_MUX			194
+#define JH7110_SYSCLK_APB_BUS			195
+#define JH7110_SYSCLK_AXI_CFG1			196
+#define JH7110_SYSCLK_APB12			197
+#define JH7110_SYSCLK_VOUT_ROOT			198
+#define JH7110_SYSCLK_VENC_ROOT			199
+#define JH7110_SYSCLK_VDEC_ROOT			200
+#define JH7110_SYSCLK_GMACUSB_ROOT		201
+
+#define JH7110_SYSCLK_END			202
+
+/* AONCRG clocks */
+#define JH7110_AONCLK_OSC_DIV4			0
+#define JH7110_AONCLK_APB_FUNC			1
+#define JH7110_AONCLK_GMAC0_AHB			2
+#define JH7110_AONCLK_GMAC0_AXI			3
+#define JH7110_AONCLK_GMAC0_RMII_RTX		4
+#define JH7110_AONCLK_GMAC0_TX			5
+#define JH7110_AONCLK_GMAC0_TX_INV		6
+#define JH7110_AONCLK_GMAC0_RX			7
+#define JH7110_AONCLK_GMAC0_RX_INV		8
+#define JH7110_AONCLK_OTPC_APB			9
+#define JH7110_AONCLK_RTC_APB			10
+#define JH7110_AONCLK_RTC_INTERNAL		11
+#define JH7110_AONCLK_RTC_32K			12
+#define JH7110_AONCLK_RTC_CAL			13
+
+#define JH7110_AONCLK_END			14
+
+#endif /* __DT_BINDINGS_CLOCK_STARFIVE_JH7110_H__ */
-- 
2.38.1

