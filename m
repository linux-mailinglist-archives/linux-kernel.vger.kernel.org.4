Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A246172F97B
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 11:40:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244041AbjFNJku (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 05:40:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244163AbjFNJjL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 05:39:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A465A2707;
        Wed, 14 Jun 2023 02:38:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B865763FC9;
        Wed, 14 Jun 2023 09:38:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC42FC43397;
        Wed, 14 Jun 2023 09:38:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686735519;
        bh=EMxDNm4ev9xj0MKdBl4jNlBQlsWHUtz9njbnGJPSDBI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=E8UA6MqL3myvg48jT7dNH4TMFpfxDV4V/Cr1ReANtQSWAUCYBRly6179sdVG+RN/6
         2jXDp2UnhJCOatAs+WTbBgEL6rGLdeaBbPmX6U06vKF1dIqwVQzbEw4iiJSc6MN7Km
         cx6X+mrliDTCA+oFe75Pu2blpGtvs0XtL5wAOo8M=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, jslaby@suse.cz,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Linux 5.15.117
Date:   Wed, 14 Jun 2023 11:38:23 +0200
Message-ID: <2023061423-clash-composure-9cd2@gregkh>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <2023061423-chubby-shredder-eb1a@gregkh>
References: <2023061423-chubby-shredder-eb1a@gregkh>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

diff --git a/Makefile b/Makefile
index 2a149be8d7a3..0fef90a53384 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 5
 PATCHLEVEL = 15
-SUBLEVEL = 116
+SUBLEVEL = 117
 EXTRAVERSION =
 NAME = Trick or Treat
 
diff --git a/arch/arm/boot/dts/at91-sama7g5ek.dts b/arch/arm/boot/dts/at91-sama7g5ek.dts
index 2038e387be28..0ba856066ffb 100644
--- a/arch/arm/boot/dts/at91-sama7g5ek.dts
+++ b/arch/arm/boot/dts/at91-sama7g5ek.dts
@@ -659,7 +659,7 @@ &sdmmc2 {
 };
 
 &shdwc {
-	atmel,shdwc-debouncer = <976>;
+	debounce-delay-us = <976>;
 	status = "okay";
 
 	input@0 {
diff --git a/arch/arm64/boot/dts/freescale/imx8-ss-dma.dtsi b/arch/arm64/boot/dts/freescale/imx8-ss-dma.dtsi
index 960a802b8b6e..c33892711138 100644
--- a/arch/arm64/boot/dts/freescale/imx8-ss-dma.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8-ss-dma.dtsi
@@ -26,6 +26,8 @@ lpuart0: serial@5a060000 {
 		clocks = <&uart0_lpcg IMX_LPCG_CLK_4>,
 			 <&uart0_lpcg IMX_LPCG_CLK_0>;
 		clock-names = "ipg", "baud";
+		assigned-clocks = <&clk IMX_SC_R_UART_0 IMX_SC_PM_CLK_PER>;
+		assigned-clock-rates = <80000000>;
 		power-domains = <&pd IMX_SC_R_UART_0>;
 		status = "disabled";
 	};
@@ -36,6 +38,8 @@ lpuart1: serial@5a070000 {
 		clocks = <&uart1_lpcg IMX_LPCG_CLK_4>,
 			 <&uart1_lpcg IMX_LPCG_CLK_0>;
 		clock-names = "ipg", "baud";
+		assigned-clocks = <&clk IMX_SC_R_UART_1 IMX_SC_PM_CLK_PER>;
+		assigned-clock-rates = <80000000>;
 		power-domains = <&pd IMX_SC_R_UART_1>;
 		status = "disabled";
 	};
@@ -46,6 +50,8 @@ lpuart2: serial@5a080000 {
 		clocks = <&uart2_lpcg IMX_LPCG_CLK_4>,
 			 <&uart2_lpcg IMX_LPCG_CLK_0>;
 		clock-names = "ipg", "baud";
+		assigned-clocks = <&clk IMX_SC_R_UART_2 IMX_SC_PM_CLK_PER>;
+		assigned-clock-rates = <80000000>;
 		power-domains = <&pd IMX_SC_R_UART_2>;
 		status = "disabled";
 	};
@@ -56,6 +62,8 @@ lpuart3: serial@5a090000 {
 		clocks = <&uart3_lpcg IMX_LPCG_CLK_4>,
 			 <&uart3_lpcg IMX_LPCG_CLK_0>;
 		clock-names = "ipg", "baud";
+		assigned-clocks = <&clk IMX_SC_R_UART_3 IMX_SC_PM_CLK_PER>;
+		assigned-clock-rates = <80000000>;
 		power-domains = <&pd IMX_SC_R_UART_3>;
 		status = "disabled";
 	};
diff --git a/arch/arm64/boot/dts/freescale/imx8mn-beacon-baseboard.dtsi b/arch/arm64/boot/dts/freescale/imx8mn-beacon-baseboard.dtsi
index e69fd41b46d0..4fc22448e411 100644
--- a/arch/arm64/boot/dts/freescale/imx8mn-beacon-baseboard.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mn-beacon-baseboard.dtsi
@@ -81,7 +81,7 @@ sound {
 &ecspi2 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_espi2>;
-	cs-gpios = <&gpio5 9 GPIO_ACTIVE_LOW>;
+	cs-gpios = <&gpio5 13 GPIO_ACTIVE_LOW>;
 	status = "okay";
 
 	eeprom@0 {
@@ -203,7 +203,7 @@ pinctrl_espi2: espi2grp {
 			MX8MN_IOMUXC_ECSPI2_SCLK_ECSPI2_SCLK		0x82
 			MX8MN_IOMUXC_ECSPI2_MOSI_ECSPI2_MOSI		0x82
 			MX8MN_IOMUXC_ECSPI2_MISO_ECSPI2_MISO		0x82
-			MX8MN_IOMUXC_ECSPI1_SS0_GPIO5_IO9		0x41
+			MX8MN_IOMUXC_ECSPI2_SS0_GPIO5_IO13		0x41
 		>;
 	};
 
diff --git a/arch/arm64/boot/dts/freescale/imx8qm-mek.dts b/arch/arm64/boot/dts/freescale/imx8qm-mek.dts
index ce9d3f0b98fc..607cd6b4e972 100644
--- a/arch/arm64/boot/dts/freescale/imx8qm-mek.dts
+++ b/arch/arm64/boot/dts/freescale/imx8qm-mek.dts
@@ -82,8 +82,8 @@ &usdhc2 {
 	pinctrl-0 = <&pinctrl_usdhc2>;
 	bus-width = <4>;
 	vmmc-supply = <&reg_usdhc2_vmmc>;
-	cd-gpios = <&lsio_gpio4 22 GPIO_ACTIVE_LOW>;
-	wp-gpios = <&lsio_gpio4 21 GPIO_ACTIVE_HIGH>;
+	cd-gpios = <&lsio_gpio5 22 GPIO_ACTIVE_LOW>;
+	wp-gpios = <&lsio_gpio5 21 GPIO_ACTIVE_HIGH>;
 	status = "okay";
 };
 
diff --git a/arch/arm64/boot/dts/qcom/sc7180-lite.dtsi b/arch/arm64/boot/dts/qcom/sc7180-lite.dtsi
index d8ed1d7b4ec7..4b306a59d9be 100644
--- a/arch/arm64/boot/dts/qcom/sc7180-lite.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7180-lite.dtsi
@@ -16,3 +16,11 @@ &cpu6_opp11 {
 &cpu6_opp12 {
 	opp-peak-kBps = <8532000 23347200>;
 };
+
+&cpu6_opp13 {
+	opp-peak-kBps = <8532000 23347200>;
+};
+
+&cpu6_opp14 {
+	opp-peak-kBps = <8532000 23347200>;
+};
diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index bf602e38962f..8dd7f01ee031 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -23,6 +23,7 @@ config RISCV
 	select ARCH_HAS_GIGANTIC_PAGE
 	select ARCH_HAS_KCOV
 	select ARCH_HAS_MMIOWB
+	select ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE
 	select ARCH_HAS_PTE_SPECIAL
 	select ARCH_HAS_SET_DIRECT_MAP if MMU
 	select ARCH_HAS_SET_MEMORY if MMU
diff --git a/block/blk-iocost.c b/block/blk-iocost.c
index 1717841196d2..43cf04966c74 100644
--- a/block/blk-iocost.c
+++ b/block/blk-iocost.c
@@ -258,6 +258,11 @@ enum {
 	VRATE_MIN		= VTIME_PER_USEC * VRATE_MIN_PPM / MILLION,
 	VRATE_CLAMP_ADJ_PCT	= 4,
 
+	/* switch iff the conditions are met for longer than this */
+	AUTOP_CYCLE_NSEC	= 10LLU * NSEC_PER_SEC,
+};
+
+enum {
 	/* if IOs end up waiting for requests, issue less */
 	RQ_WAIT_BUSY_PCT	= 5,
 
@@ -296,9 +301,6 @@ enum {
 	/* don't let cmds which take a very long time pin lagging for too long */
 	MAX_LAGGING_PERIODS	= 10,
 
-	/* switch iff the conditions are met for longer than this */
-	AUTOP_CYCLE_NSEC	= 10LLU * NSEC_PER_SEC,
-
 	/*
 	 * Count IO size in 4k pages.  The 12bit shift helps keeping
 	 * size-proportional components of cost calculation in closer
diff --git a/drivers/ata/ahci.h b/drivers/ata/ahci.h
index 60ae707a88cc..dcc2d92cf6b6 100644
--- a/drivers/ata/ahci.h
+++ b/drivers/ata/ahci.h
@@ -24,6 +24,7 @@
 #include <linux/libata.h>
 #include <linux/phy/phy.h>
 #include <linux/regulator/consumer.h>
+#include <linux/bits.h>
 
 /* Enclosure Management Control */
 #define EM_CTRL_MSG_TYPE              0x000f0000
@@ -54,12 +55,12 @@ enum {
 	AHCI_PORT_PRIV_FBS_DMA_SZ	= AHCI_CMD_SLOT_SZ +
 					  AHCI_CMD_TBL_AR_SZ +
 					  (AHCI_RX_FIS_SZ * 16),
-	AHCI_IRQ_ON_SG		= (1 << 31),
-	AHCI_CMD_ATAPI		= (1 << 5),
-	AHCI_CMD_WRITE		= (1 << 6),
-	AHCI_CMD_PREFETCH	= (1 << 7),
-	AHCI_CMD_RESET		= (1 << 8),
-	AHCI_CMD_CLR_BUSY	= (1 << 10),
+	AHCI_IRQ_ON_SG		= BIT(31),
+	AHCI_CMD_ATAPI		= BIT(5),
+	AHCI_CMD_WRITE		= BIT(6),
+	AHCI_CMD_PREFETCH	= BIT(7),
+	AHCI_CMD_RESET		= BIT(8),
+	AHCI_CMD_CLR_BUSY	= BIT(10),
 
 	RX_FIS_PIO_SETUP	= 0x20,	/* offset of PIO Setup FIS data */
 	RX_FIS_D2H_REG		= 0x40,	/* offset of D2H Register FIS data */
@@ -77,37 +78,37 @@ enum {
 	HOST_CAP2		= 0x24, /* host capabilities, extended */
 
 	/* HOST_CTL bits */
-	HOST_RESET		= (1 << 0),  /* reset controller; self-clear */
-	HOST_IRQ_EN		= (1 << 1),  /* global IRQ enable */
-	HOST_MRSM		= (1 << 2),  /* MSI Revert to Single Message */
-	HOST_AHCI_EN		= (1 << 31), /* AHCI enabled */
+	HOST_RESET		= BIT(0),  /* reset controller; self-clear */
+	HOST_IRQ_EN		= BIT(1),  /* global IRQ enable */
+	HOST_MRSM		= BIT(2),  /* MSI Revert to Single Message */
+	HOST_AHCI_EN		= BIT(31), /* AHCI enabled */
 
 	/* HOST_CAP bits */
-	HOST_CAP_SXS		= (1 << 5),  /* Supports External SATA */
-	HOST_CAP_EMS		= (1 << 6),  /* Enclosure Management support */
-	HOST_CAP_CCC		= (1 << 7),  /* Command Completion Coalescing */
-	HOST_CAP_PART		= (1 << 13), /* Partial state capable */
-	HOST_CAP_SSC		= (1 << 14), /* Slumber state capable */
-	HOST_CAP_PIO_MULTI	= (1 << 15), /* PIO multiple DRQ support */
-	HOST_CAP_FBS		= (1 << 16), /* FIS-based switching support */
-	HOST_CAP_PMP		= (1 << 17), /* Port Multiplier support */
-	HOST_CAP_ONLY		= (1 << 18), /* Supports AHCI mode only */
-	HOST_CAP_CLO		= (1 << 24), /* Command List Override support */
-	HOST_CAP_LED		= (1 << 25), /* Supports activity LED */
-	HOST_CAP_ALPM		= (1 << 26), /* Aggressive Link PM support */
-	HOST_CAP_SSS		= (1 << 27), /* Staggered Spin-up */
-	HOST_CAP_MPS		= (1 << 28), /* Mechanical presence switch */
-	HOST_CAP_SNTF		= (1 << 29), /* SNotification register */
-	HOST_CAP_NCQ		= (1 << 30), /* Native Command Queueing */
-	HOST_CAP_64		= (1 << 31), /* PCI DAC (64-bit DMA) support */
+	HOST_CAP_SXS		= BIT(5),  /* Supports External SATA */
+	HOST_CAP_EMS		= BIT(6),  /* Enclosure Management support */
+	HOST_CAP_CCC		= BIT(7),  /* Command Completion Coalescing */
+	HOST_CAP_PART		= BIT(13), /* Partial state capable */
+	HOST_CAP_SSC		= BIT(14), /* Slumber state capable */
+	HOST_CAP_PIO_MULTI	= BIT(15), /* PIO multiple DRQ support */
+	HOST_CAP_FBS		= BIT(16), /* FIS-based switching support */
+	HOST_CAP_PMP		= BIT(17), /* Port Multiplier support */
+	HOST_CAP_ONLY		= BIT(18), /* Supports AHCI mode only */
+	HOST_CAP_CLO		= BIT(24), /* Command List Override support */
+	HOST_CAP_LED		= BIT(25), /* Supports activity LED */
+	HOST_CAP_ALPM		= BIT(26), /* Aggressive Link PM support */
+	HOST_CAP_SSS		= BIT(27), /* Staggered Spin-up */
+	HOST_CAP_MPS		= BIT(28), /* Mechanical presence switch */
+	HOST_CAP_SNTF		= BIT(29), /* SNotification register */
+	HOST_CAP_NCQ		= BIT(30), /* Native Command Queueing */
+	HOST_CAP_64		= BIT(31), /* PCI DAC (64-bit DMA) support */
 
 	/* HOST_CAP2 bits */
-	HOST_CAP2_BOH		= (1 << 0),  /* BIOS/OS handoff supported */
-	HOST_CAP2_NVMHCI	= (1 << 1),  /* NVMHCI supported */
-	HOST_CAP2_APST		= (1 << 2),  /* Automatic partial to slumber */
-	HOST_CAP2_SDS		= (1 << 3),  /* Support device sleep */
-	HOST_CAP2_SADM		= (1 << 4),  /* Support aggressive DevSlp */
-	HOST_CAP2_DESO		= (1 << 5),  /* DevSlp from slumber only */
+	HOST_CAP2_BOH		= BIT(0),  /* BIOS/OS handoff supported */
+	HOST_CAP2_NVMHCI	= BIT(1),  /* NVMHCI supported */
+	HOST_CAP2_APST		= BIT(2),  /* Automatic partial to slumber */
+	HOST_CAP2_SDS		= BIT(3),  /* Support device sleep */
+	HOST_CAP2_SADM		= BIT(4),  /* Support aggressive DevSlp */
+	HOST_CAP2_DESO		= BIT(5),  /* DevSlp from slumber only */
 
 	/* registers for each SATA port */
 	PORT_LST_ADDR		= 0x00, /* command list DMA addr */
@@ -129,24 +130,24 @@ enum {
 	PORT_DEVSLP		= 0x44, /* device sleep */
 
 	/* PORT_IRQ_{STAT,MASK} bits */
-	PORT_IRQ_COLD_PRES	= (1 << 31), /* cold presence detect */
-	PORT_IRQ_TF_ERR		= (1 << 30), /* task file error */
-	PORT_IRQ_HBUS_ERR	= (1 << 29), /* host bus fatal error */
-	PORT_IRQ_HBUS_DATA_ERR	= (1 << 28), /* host bus data error */
-	PORT_IRQ_IF_ERR		= (1 << 27), /* interface fatal error */
-	PORT_IRQ_IF_NONFATAL	= (1 << 26), /* interface non-fatal error */
-	PORT_IRQ_OVERFLOW	= (1 << 24), /* xfer exhausted available S/G */
-	PORT_IRQ_BAD_PMP	= (1 << 23), /* incorrect port multiplier */
-
-	PORT_IRQ_PHYRDY		= (1 << 22), /* PhyRdy changed */
-	PORT_IRQ_DEV_ILCK	= (1 << 7), /* device interlock */
-	PORT_IRQ_CONNECT	= (1 << 6), /* port connect change status */
-	PORT_IRQ_SG_DONE	= (1 << 5), /* descriptor processed */
-	PORT_IRQ_UNK_FIS	= (1 << 4), /* unknown FIS rx'd */
-	PORT_IRQ_SDB_FIS	= (1 << 3), /* Set Device Bits FIS rx'd */
-	PORT_IRQ_DMAS_FIS	= (1 << 2), /* DMA Setup FIS rx'd */
-	PORT_IRQ_PIOS_FIS	= (1 << 1), /* PIO Setup FIS rx'd */
-	PORT_IRQ_D2H_REG_FIS	= (1 << 0), /* D2H Register FIS rx'd */
+	PORT_IRQ_COLD_PRES	= BIT(31), /* cold presence detect */
+	PORT_IRQ_TF_ERR		= BIT(30), /* task file error */
+	PORT_IRQ_HBUS_ERR	= BIT(29), /* host bus fatal error */
+	PORT_IRQ_HBUS_DATA_ERR	= BIT(28), /* host bus data error */
+	PORT_IRQ_IF_ERR		= BIT(27), /* interface fatal error */
+	PORT_IRQ_IF_NONFATAL	= BIT(26), /* interface non-fatal error */
+	PORT_IRQ_OVERFLOW	= BIT(24), /* xfer exhausted available S/G */
+	PORT_IRQ_BAD_PMP	= BIT(23), /* incorrect port multiplier */
+
+	PORT_IRQ_PHYRDY		= BIT(22), /* PhyRdy changed */
+	PORT_IRQ_DEV_ILCK	= BIT(7),  /* device interlock */
+	PORT_IRQ_CONNECT	= BIT(6),  /* port connect change status */
+	PORT_IRQ_SG_DONE	= BIT(5),  /* descriptor processed */
+	PORT_IRQ_UNK_FIS	= BIT(4),  /* unknown FIS rx'd */
+	PORT_IRQ_SDB_FIS	= BIT(3),  /* Set Device Bits FIS rx'd */
+	PORT_IRQ_DMAS_FIS	= BIT(2),  /* DMA Setup FIS rx'd */
+	PORT_IRQ_PIOS_FIS	= BIT(1),  /* PIO Setup FIS rx'd */
+	PORT_IRQ_D2H_REG_FIS	= BIT(0),  /* D2H Register FIS rx'd */
 
 	PORT_IRQ_FREEZE		= PORT_IRQ_HBUS_ERR |
 				  PORT_IRQ_IF_ERR |
@@ -162,34 +163,34 @@ enum {
 				  PORT_IRQ_PIOS_FIS | PORT_IRQ_D2H_REG_FIS,
 
 	/* PORT_CMD bits */
-	PORT_CMD_ASP		= (1 << 27), /* Aggressive Slumber/Partial */
-	PORT_CMD_ALPE		= (1 << 26), /* Aggressive Link PM enable */
-	PORT_CMD_ATAPI		= (1 << 24), /* Device is ATAPI */
-	PORT_CMD_FBSCP		= (1 << 22), /* FBS Capable Port */
-	PORT_CMD_ESP		= (1 << 21), /* External Sata Port */
-	PORT_CMD_HPCP		= (1 << 18), /* HotPlug Capable Port */
-	PORT_CMD_PMP		= (1 << 17), /* PMP attached */
-	PORT_CMD_LIST_ON	= (1 << 15), /* cmd list DMA engine running */
-	PORT_CMD_FIS_ON		= (1 << 14), /* FIS DMA engine running */
-	PORT_CMD_FIS_RX		= (1 << 4), /* Enable FIS receive DMA engine */
-	PORT_CMD_CLO		= (1 << 3), /* Command list override */
-	PORT_CMD_POWER_ON	= (1 << 2), /* Power up device */
-	PORT_CMD_SPIN_UP	= (1 << 1), /* Spin up device */
-	PORT_CMD_START		= (1 << 0), /* Enable port DMA engine */
-
-	PORT_CMD_ICC_MASK	= (0xf << 28), /* i/f ICC state mask */
-	PORT_CMD_ICC_ACTIVE	= (0x1 << 28), /* Put i/f in active state */
-	PORT_CMD_ICC_PARTIAL	= (0x2 << 28), /* Put i/f in partial state */
-	PORT_CMD_ICC_SLUMBER	= (0x6 << 28), /* Put i/f in slumber state */
+	PORT_CMD_ASP		= BIT(27), /* Aggressive Slumber/Partial */
+	PORT_CMD_ALPE		= BIT(26), /* Aggressive Link PM enable */
+	PORT_CMD_ATAPI		= BIT(24), /* Device is ATAPI */
+	PORT_CMD_FBSCP		= BIT(22), /* FBS Capable Port */
+	PORT_CMD_ESP		= BIT(21), /* External Sata Port */
+	PORT_CMD_HPCP		= BIT(18), /* HotPlug Capable Port */
+	PORT_CMD_PMP		= BIT(17), /* PMP attached */
+	PORT_CMD_LIST_ON	= BIT(15), /* cmd list DMA engine running */
+	PORT_CMD_FIS_ON		= BIT(14), /* FIS DMA engine running */
+	PORT_CMD_FIS_RX		= BIT(4),  /* Enable FIS receive DMA engine */
+	PORT_CMD_CLO		= BIT(3),  /* Command list override */
+	PORT_CMD_POWER_ON	= BIT(2),  /* Power up device */
+	PORT_CMD_SPIN_UP	= BIT(1),  /* Spin up device */
+	PORT_CMD_START		= BIT(0),  /* Enable port DMA engine */
+
+	PORT_CMD_ICC_MASK	= (0xfu << 28), /* i/f ICC state mask */
+	PORT_CMD_ICC_ACTIVE	= (0x1u << 28), /* Put i/f in active state */
+	PORT_CMD_ICC_PARTIAL	= (0x2u << 28), /* Put i/f in partial state */
+	PORT_CMD_ICC_SLUMBER	= (0x6u << 28), /* Put i/f in slumber state */
 
 	/* PORT_FBS bits */
 	PORT_FBS_DWE_OFFSET	= 16, /* FBS device with error offset */
 	PORT_FBS_ADO_OFFSET	= 12, /* FBS active dev optimization offset */
 	PORT_FBS_DEV_OFFSET	= 8,  /* FBS device to issue offset */
 	PORT_FBS_DEV_MASK	= (0xf << PORT_FBS_DEV_OFFSET),  /* FBS.DEV */
-	PORT_FBS_SDE		= (1 << 2), /* FBS single device error */
-	PORT_FBS_DEC		= (1 << 1), /* FBS device error clear */
-	PORT_FBS_EN		= (1 << 0), /* Enable FBS */
+	PORT_FBS_SDE		= BIT(2), /* FBS single device error */
+	PORT_FBS_DEC		= BIT(1), /* FBS device error clear */
+	PORT_FBS_EN		= BIT(0), /* Enable FBS */
 
 	/* PORT_DEVSLP bits */
 	PORT_DEVSLP_DM_OFFSET	= 25,             /* DITO multiplier offset */
@@ -197,52 +198,52 @@ enum {
 	PORT_DEVSLP_DITO_OFFSET	= 15,             /* DITO offset */
 	PORT_DEVSLP_MDAT_OFFSET	= 10,             /* Minimum assertion time */
 	PORT_DEVSLP_DETO_OFFSET	= 2,              /* DevSlp exit timeout */
-	PORT_DEVSLP_DSP		= (1 << 1),       /* DevSlp present */
-	PORT_DEVSLP_ADSE	= (1 << 0),       /* Aggressive DevSlp enable */
+	PORT_DEVSLP_DSP		= BIT(1),         /* DevSlp present */
+	PORT_DEVSLP_ADSE	= BIT(0),         /* Aggressive DevSlp enable */
 
 	/* hpriv->flags bits */
 
 #define AHCI_HFLAGS(flags)		.private_data	= (void *)(flags)
 
-	AHCI_HFLAG_NO_NCQ		= (1 << 0),
-	AHCI_HFLAG_IGN_IRQ_IF_ERR	= (1 << 1), /* ignore IRQ_IF_ERR */
-	AHCI_HFLAG_IGN_SERR_INTERNAL	= (1 << 2), /* ignore SERR_INTERNAL */
-	AHCI_HFLAG_32BIT_ONLY		= (1 << 3), /* force 32bit */
-	AHCI_HFLAG_MV_PATA		= (1 << 4), /* PATA port */
-	AHCI_HFLAG_NO_MSI		= (1 << 5), /* no PCI MSI */
-	AHCI_HFLAG_NO_PMP		= (1 << 6), /* no PMP */
-	AHCI_HFLAG_SECT255		= (1 << 8), /* max 255 sectors */
-	AHCI_HFLAG_YES_NCQ		= (1 << 9), /* force NCQ cap on */
-	AHCI_HFLAG_NO_SUSPEND		= (1 << 10), /* don't suspend */
-	AHCI_HFLAG_SRST_TOUT_IS_OFFLINE	= (1 << 11), /* treat SRST timeout as
-							link offline */
-	AHCI_HFLAG_NO_SNTF		= (1 << 12), /* no sntf */
-	AHCI_HFLAG_NO_FPDMA_AA		= (1 << 13), /* no FPDMA AA */
-	AHCI_HFLAG_YES_FBS		= (1 << 14), /* force FBS cap on */
-	AHCI_HFLAG_DELAY_ENGINE		= (1 << 15), /* do not start engine on
-						        port start (wait until
-						        error-handling stage) */
-	AHCI_HFLAG_NO_DEVSLP		= (1 << 17), /* no device sleep */
-	AHCI_HFLAG_NO_FBS		= (1 << 18), /* no FBS */
+	AHCI_HFLAG_NO_NCQ		= BIT(0),
+	AHCI_HFLAG_IGN_IRQ_IF_ERR	= BIT(1), /* ignore IRQ_IF_ERR */
+	AHCI_HFLAG_IGN_SERR_INTERNAL	= BIT(2), /* ignore SERR_INTERNAL */
+	AHCI_HFLAG_32BIT_ONLY		= BIT(3), /* force 32bit */
+	AHCI_HFLAG_MV_PATA		= BIT(4), /* PATA port */
+	AHCI_HFLAG_NO_MSI		= BIT(5), /* no PCI MSI */
+	AHCI_HFLAG_NO_PMP		= BIT(6), /* no PMP */
+	AHCI_HFLAG_SECT255		= BIT(8), /* max 255 sectors */
+	AHCI_HFLAG_YES_NCQ		= BIT(9), /* force NCQ cap on */
+	AHCI_HFLAG_NO_SUSPEND		= BIT(10), /* don't suspend */
+	AHCI_HFLAG_SRST_TOUT_IS_OFFLINE	= BIT(11), /* treat SRST timeout as
+						      link offline */
+	AHCI_HFLAG_NO_SNTF		= BIT(12), /* no sntf */
+	AHCI_HFLAG_NO_FPDMA_AA		= BIT(13), /* no FPDMA AA */
+	AHCI_HFLAG_YES_FBS		= BIT(14), /* force FBS cap on */
+	AHCI_HFLAG_DELAY_ENGINE		= BIT(15), /* do not start engine on
+						      port start (wait until
+						      error-handling stage) */
+	AHCI_HFLAG_NO_DEVSLP		= BIT(17), /* no device sleep */
+	AHCI_HFLAG_NO_FBS		= BIT(18), /* no FBS */
 
 #ifdef CONFIG_PCI_MSI
-	AHCI_HFLAG_MULTI_MSI		= (1 << 20), /* per-port MSI(-X) */
+	AHCI_HFLAG_MULTI_MSI		= BIT(20), /* per-port MSI(-X) */
 #else
 	/* compile out MSI infrastructure */
 	AHCI_HFLAG_MULTI_MSI		= 0,
 #endif
-	AHCI_HFLAG_WAKE_BEFORE_STOP	= (1 << 22), /* wake before DMA stop */
-	AHCI_HFLAG_YES_ALPM		= (1 << 23), /* force ALPM cap on */
-	AHCI_HFLAG_NO_WRITE_TO_RO	= (1 << 24), /* don't write to read
-							only registers */
-	AHCI_HFLAG_IS_MOBILE		= (1 << 25), /* mobile chipset, use
-							SATA_MOBILE_LPM_POLICY
-							as default lpm_policy */
-	AHCI_HFLAG_SUSPEND_PHYS		= (1 << 26), /* handle PHYs during
-							suspend/resume */
-	AHCI_HFLAG_IGN_NOTSUPP_POWER_ON	= (1 << 27), /* ignore -EOPNOTSUPP
-							from phy_power_on() */
-	AHCI_HFLAG_NO_SXS		= (1 << 28), /* SXS not supported */
+	AHCI_HFLAG_WAKE_BEFORE_STOP	= BIT(22), /* wake before DMA stop */
+	AHCI_HFLAG_YES_ALPM		= BIT(23), /* force ALPM cap on */
+	AHCI_HFLAG_NO_WRITE_TO_RO	= BIT(24), /* don't write to read
+						      only registers */
+	AHCI_HFLAG_IS_MOBILE            = BIT(25), /* mobile chipset, use
+						      SATA_MOBILE_LPM_POLICY
+						      as default lpm_policy */
+	AHCI_HFLAG_SUSPEND_PHYS		= BIT(26), /* handle PHYs during
+						      suspend/resume */
+	AHCI_HFLAG_IGN_NOTSUPP_POWER_ON	= BIT(27), /* ignore -EOPNOTSUPP
+						      from phy_power_on() */
+	AHCI_HFLAG_NO_SXS		= BIT(28), /* SXS not supported */
 
 	/* ap->flags bits */
 
@@ -258,22 +259,22 @@ enum {
 	EM_MAX_RETRY			= 5,
 
 	/* em_ctl bits */
-	EM_CTL_RST		= (1 << 9), /* Reset */
-	EM_CTL_TM		= (1 << 8), /* Transmit Message */
-	EM_CTL_MR		= (1 << 0), /* Message Received */
-	EM_CTL_ALHD		= (1 << 26), /* Activity LED */
-	EM_CTL_XMT		= (1 << 25), /* Transmit Only */
-	EM_CTL_SMB		= (1 << 24), /* Single Message Buffer */
-	EM_CTL_SGPIO		= (1 << 19), /* SGPIO messages supported */
-	EM_CTL_SES		= (1 << 18), /* SES-2 messages supported */
-	EM_CTL_SAFTE		= (1 << 17), /* SAF-TE messages supported */
-	EM_CTL_LED		= (1 << 16), /* LED messages supported */
+	EM_CTL_RST		= BIT(9), /* Reset */
+	EM_CTL_TM		= BIT(8), /* Transmit Message */
+	EM_CTL_MR		= BIT(0), /* Message Received */
+	EM_CTL_ALHD		= BIT(26), /* Activity LED */
+	EM_CTL_XMT		= BIT(25), /* Transmit Only */
+	EM_CTL_SMB		= BIT(24), /* Single Message Buffer */
+	EM_CTL_SGPIO		= BIT(19), /* SGPIO messages supported */
+	EM_CTL_SES		= BIT(18), /* SES-2 messages supported */
+	EM_CTL_SAFTE		= BIT(17), /* SAF-TE messages supported */
+	EM_CTL_LED		= BIT(16), /* LED messages supported */
 
 	/* em message type */
-	EM_MSG_TYPE_LED		= (1 << 0), /* LED */
-	EM_MSG_TYPE_SAFTE	= (1 << 1), /* SAF-TE */
-	EM_MSG_TYPE_SES2	= (1 << 2), /* SES-2 */
-	EM_MSG_TYPE_SGPIO	= (1 << 3), /* SGPIO */
+	EM_MSG_TYPE_LED		= BIT(0), /* LED */
+	EM_MSG_TYPE_SAFTE	= BIT(1), /* SAF-TE */
+	EM_MSG_TYPE_SES2	= BIT(2), /* SES-2 */
+	EM_MSG_TYPE_SGPIO	= BIT(3), /* SGPIO */
 };
 
 struct ahci_cmd_hdr {
diff --git a/drivers/block/Kconfig b/drivers/block/Kconfig
index 28ed157b1203..fb12311b87ff 100644
--- a/drivers/block/Kconfig
+++ b/drivers/block/Kconfig
@@ -271,15 +271,6 @@ config BLK_DEV_NBD
 
 	  If unsure, say N.
 
-config BLK_DEV_SX8
-	tristate "Promise SATA SX8 support"
-	depends on PCI
-	help
-	  Saying Y or M here will enable support for the 
-	  Promise SATA SX8 controllers.
-
-	  Use devices /dev/sx8/$N and /dev/sx8/$Np$M.
-
 config BLK_DEV_RAM
 	tristate "RAM block device support"
 	help
diff --git a/drivers/block/Makefile b/drivers/block/Makefile
index bc68817ef496..91220b251b46 100644
--- a/drivers/block/Makefile
+++ b/drivers/block/Makefile
@@ -27,8 +27,6 @@ obj-$(CONFIG_BLK_DEV_NBD)	+= nbd.o
 obj-$(CONFIG_BLK_DEV_CRYPTOLOOP) += cryptoloop.o
 obj-$(CONFIG_VIRTIO_BLK)	+= virtio_blk.o
 
-obj-$(CONFIG_BLK_DEV_SX8)	+= sx8.o
-
 obj-$(CONFIG_XEN_BLKDEV_FRONTEND)	+= xen-blkfront.o
 obj-$(CONFIG_XEN_BLKDEV_BACKEND)	+= xen-blkback/
 obj-$(CONFIG_BLK_DEV_DRBD)     += drbd/
diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index f9d298c5a2ab..a4188825bd19 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -1335,14 +1335,30 @@ static bool rbd_obj_is_tail(struct rbd_obj_request *obj_req)
 /*
  * Must be called after rbd_obj_calc_img_extents().
  */
-static bool rbd_obj_copyup_enabled(struct rbd_obj_request *obj_req)
+static void rbd_obj_set_copyup_enabled(struct rbd_obj_request *obj_req)
 {
-	if (!obj_req->num_img_extents ||
-	    (rbd_obj_is_entire(obj_req) &&
-	     !obj_req->img_request->snapc->num_snaps))
-		return false;
+	rbd_assert(obj_req->img_request->snapc);
 
-	return true;
+	if (obj_req->img_request->op_type == OBJ_OP_DISCARD) {
+		dout("%s %p objno %llu discard\n", __func__, obj_req,
+		     obj_req->ex.oe_objno);
+		return;
+	}
+
+	if (!obj_req->num_img_extents) {
+		dout("%s %p objno %llu not overlapping\n", __func__, obj_req,
+		     obj_req->ex.oe_objno);
+		return;
+	}
+
+	if (rbd_obj_is_entire(obj_req) &&
+	    !obj_req->img_request->snapc->num_snaps) {
+		dout("%s %p objno %llu entire\n", __func__, obj_req,
+		     obj_req->ex.oe_objno);
+		return;
+	}
+
+	obj_req->flags |= RBD_OBJ_FLAG_COPYUP_ENABLED;
 }
 
 static u64 rbd_obj_img_extents_bytes(struct rbd_obj_request *obj_req)
@@ -1443,6 +1459,7 @@ __rbd_obj_add_osd_request(struct rbd_obj_request *obj_req,
 static struct ceph_osd_request *
 rbd_obj_add_osd_request(struct rbd_obj_request *obj_req, int num_ops)
 {
+	rbd_assert(obj_req->img_request->snapc);
 	return __rbd_obj_add_osd_request(obj_req, obj_req->img_request->snapc,
 					 num_ops);
 }
@@ -1579,15 +1596,18 @@ static void rbd_img_request_init(struct rbd_img_request *img_request,
 	mutex_init(&img_request->state_mutex);
 }
 
+/*
+ * Only snap_id is captured here, for reads.  For writes, snapshot
+ * context is captured in rbd_img_object_requests() after exclusive
+ * lock is ensured to be held.
+ */
 static void rbd_img_capture_header(struct rbd_img_request *img_req)
 {
 	struct rbd_device *rbd_dev = img_req->rbd_dev;
 
 	lockdep_assert_held(&rbd_dev->header_rwsem);
 
-	if (rbd_img_is_write(img_req))
-		img_req->snapc = ceph_get_snap_context(rbd_dev->header.snapc);
-	else
+	if (!rbd_img_is_write(img_req))
 		img_req->snap_id = rbd_dev->spec->snap_id;
 
 	if (rbd_dev_parent_get(rbd_dev))
@@ -2234,9 +2254,6 @@ static int rbd_obj_init_write(struct rbd_obj_request *obj_req)
 	if (ret)
 		return ret;
 
-	if (rbd_obj_copyup_enabled(obj_req))
-		obj_req->flags |= RBD_OBJ_FLAG_COPYUP_ENABLED;
-
 	obj_req->write_state = RBD_OBJ_WRITE_START;
 	return 0;
 }
@@ -2342,8 +2359,6 @@ static int rbd_obj_init_zeroout(struct rbd_obj_request *obj_req)
 	if (ret)
 		return ret;
 
-	if (rbd_obj_copyup_enabled(obj_req))
-		obj_req->flags |= RBD_OBJ_FLAG_COPYUP_ENABLED;
 	if (!obj_req->num_img_extents) {
 		obj_req->flags |= RBD_OBJ_FLAG_NOOP_FOR_NONEXISTENT;
 		if (rbd_obj_is_entire(obj_req))
@@ -3288,6 +3303,7 @@ static bool rbd_obj_advance_write(struct rbd_obj_request *obj_req, int *result)
 	case RBD_OBJ_WRITE_START:
 		rbd_assert(!*result);
 
+		rbd_obj_set_copyup_enabled(obj_req);
 		if (rbd_obj_write_is_noop(obj_req))
 			return true;
 
@@ -3474,9 +3490,19 @@ static int rbd_img_exclusive_lock(struct rbd_img_request *img_req)
 
 static void rbd_img_object_requests(struct rbd_img_request *img_req)
 {
+	struct rbd_device *rbd_dev = img_req->rbd_dev;
 	struct rbd_obj_request *obj_req;
 
 	rbd_assert(!img_req->pending.result && !img_req->pending.num_pending);
+	rbd_assert(!need_exclusive_lock(img_req) ||
+		   __rbd_is_lock_owner(rbd_dev));
+
+	if (rbd_img_is_write(img_req)) {
+		rbd_assert(!img_req->snapc);
+		down_read(&rbd_dev->header_rwsem);
+		img_req->snapc = ceph_get_snap_context(rbd_dev->header.snapc);
+		up_read(&rbd_dev->header_rwsem);
+	}
 
 	for_each_obj_request(img_req, obj_req) {
 		int result = 0;
@@ -3494,7 +3520,6 @@ static void rbd_img_object_requests(struct rbd_img_request *img_req)
 
 static bool rbd_img_advance(struct rbd_img_request *img_req, int *result)
 {
-	struct rbd_device *rbd_dev = img_req->rbd_dev;
 	int ret;
 
 again:
@@ -3515,9 +3540,6 @@ static bool rbd_img_advance(struct rbd_img_request *img_req, int *result)
 		if (*result)
 			return true;
 
-		rbd_assert(!need_exclusive_lock(img_req) ||
-			   __rbd_is_lock_owner(rbd_dev));
-
 		rbd_img_object_requests(img_req);
 		if (!img_req->pending.num_pending) {
 			*result = img_req->pending.result;
@@ -3979,6 +4001,10 @@ static int rbd_post_acquire_action(struct rbd_device *rbd_dev)
 {
 	int ret;
 
+	ret = rbd_dev_refresh(rbd_dev);
+	if (ret)
+		return ret;
+
 	if (rbd_dev->header.features & RBD_FEATURE_OBJECT_MAP) {
 		ret = rbd_object_map_open(rbd_dev);
 		if (ret)
diff --git a/drivers/block/sx8.c b/drivers/block/sx8.c
deleted file mode 100644
index 420cd952ddc4..000000000000
--- a/drivers/block/sx8.c
+++ /dev/null
@@ -1,1575 +0,0 @@
-/*
- *  sx8.c: Driver for Promise SATA SX8 looks-like-I2O hardware
- *
- *  Copyright 2004-2005 Red Hat, Inc.
- *
- *  Author/maintainer:  Jeff Garzik <jgarzik@pobox.com>
- *
- *  This file is subject to the terms and conditions of the GNU General Public
- *  License.  See the file "COPYING" in the main directory of this archive
- *  for more details.
- */
-
-#include <linux/kernel.h>
-#include <linux/module.h>
-#include <linux/init.h>
-#include <linux/pci.h>
-#include <linux/slab.h>
-#include <linux/spinlock.h>
-#include <linux/blk-mq.h>
-#include <linux/sched.h>
-#include <linux/interrupt.h>
-#include <linux/compiler.h>
-#include <linux/workqueue.h>
-#include <linux/bitops.h>
-#include <linux/delay.h>
-#include <linux/ktime.h>
-#include <linux/hdreg.h>
-#include <linux/dma-mapping.h>
-#include <linux/completion.h>
-#include <linux/scatterlist.h>
-#include <asm/io.h>
-#include <linux/uaccess.h>
-
-#if 0
-#define CARM_DEBUG
-#define CARM_VERBOSE_DEBUG
-#else
-#undef CARM_DEBUG
-#undef CARM_VERBOSE_DEBUG
-#endif
-#undef CARM_NDEBUG
-
-#define DRV_NAME "sx8"
-#define DRV_VERSION "1.0"
-#define PFX DRV_NAME ": "
-
-MODULE_AUTHOR("Jeff Garzik");
-MODULE_LICENSE("GPL");
-MODULE_DESCRIPTION("Promise SATA SX8 block driver");
-MODULE_VERSION(DRV_VERSION);
-
-/*
- * SX8 hardware has a single message queue for all ATA ports.
- * When this driver was written, the hardware (firmware?) would
- * corrupt data eventually, if more than one request was outstanding.
- * As one can imagine, having 8 ports bottlenecking on a single
- * command hurts performance.
- *
- * Based on user reports, later versions of the hardware (firmware?)
- * seem to be able to survive with more than one command queued.
- *
- * Therefore, we default to the safe option -- 1 command -- but
- * allow the user to increase this.
- *
- * SX8 should be able to support up to ~60 queued commands (CARM_MAX_REQ),
- * but problems seem to occur when you exceed ~30, even on newer hardware.
- */
-static int max_queue = 1;
-module_param(max_queue, int, 0444);
-MODULE_PARM_DESC(max_queue, "Maximum number of queued commands. (min==1, max==30, safe==1)");
-
-
-#define NEXT_RESP(idx)	((idx + 1) % RMSG_Q_LEN)
-
-/* 0xf is just arbitrary, non-zero noise; this is sorta like poisoning */
-#define TAG_ENCODE(tag)	(((tag) << 16) | 0xf)
-#define TAG_DECODE(tag)	(((tag) >> 16) & 0x1f)
-#define TAG_VALID(tag)	((((tag) & 0xf) == 0xf) && (TAG_DECODE(tag) < 32))
-
-/* note: prints function name for you */
-#ifdef CARM_DEBUG
-#define DPRINTK(fmt, args...) printk(KERN_ERR "%s: " fmt, __func__, ## args)
-#ifdef CARM_VERBOSE_DEBUG
-#define VPRINTK(fmt, args...) printk(KERN_ERR "%s: " fmt, __func__, ## args)
-#else
-#define VPRINTK(fmt, args...)
-#endif	/* CARM_VERBOSE_DEBUG */
-#else
-#define DPRINTK(fmt, args...)
-#define VPRINTK(fmt, args...)
-#endif	/* CARM_DEBUG */
-
-#ifdef CARM_NDEBUG
-#define assert(expr)
-#else
-#define assert(expr) \
-        if(unlikely(!(expr))) {                                   \
-        printk(KERN_ERR "Assertion failed! %s,%s,%s,line=%d\n", \
-	#expr, __FILE__, __func__, __LINE__);          \
-        }
-#endif
-
-/* defines only for the constants which don't work well as enums */
-struct carm_host;
-
-enum {
-	/* adapter-wide limits */
-	CARM_MAX_PORTS		= 8,
-	CARM_SHM_SIZE		= (4096 << 7),
-	CARM_MINORS_PER_MAJOR	= 256 / CARM_MAX_PORTS,
-	CARM_MAX_WAIT_Q		= CARM_MAX_PORTS + 1,
-
-	/* command message queue limits */
-	CARM_MAX_REQ		= 64,	       /* max command msgs per host */
-	CARM_MSG_LOW_WATER	= (CARM_MAX_REQ / 4),	     /* refill mark */
-
-	/* S/G limits, host-wide and per-request */
-	CARM_MAX_REQ_SG		= 32,	     /* max s/g entries per request */
-	CARM_MAX_HOST_SG	= 600,		/* max s/g entries per host */
-	CARM_SG_LOW_WATER	= (CARM_MAX_HOST_SG / 4),   /* re-fill mark */
-
-	/* hardware registers */
-	CARM_IHQP		= 0x1c,
-	CARM_INT_STAT		= 0x10, /* interrupt status */
-	CARM_INT_MASK		= 0x14, /* interrupt mask */
-	CARM_HMUC		= 0x18, /* host message unit control */
-	RBUF_ADDR_LO		= 0x20, /* response msg DMA buf low 32 bits */
-	RBUF_ADDR_HI		= 0x24, /* response msg DMA buf high 32 bits */
-	RBUF_BYTE_SZ		= 0x28,
-	CARM_RESP_IDX		= 0x2c,
-	CARM_CMS0		= 0x30, /* command message size reg 0 */
-	CARM_LMUC		= 0x48,
-	CARM_HMPHA		= 0x6c,
-	CARM_INITC		= 0xb5,
-
-	/* bits in CARM_INT_{STAT,MASK} */
-	INT_RESERVED		= 0xfffffff0,
-	INT_WATCHDOG		= (1 << 3),	/* watchdog timer */
-	INT_Q_OVERFLOW		= (1 << 2),	/* cmd msg q overflow */
-	INT_Q_AVAILABLE		= (1 << 1),	/* cmd msg q has free space */
-	INT_RESPONSE		= (1 << 0),	/* response msg available */
-	INT_ACK_MASK		= INT_WATCHDOG | INT_Q_OVERFLOW,
-	INT_DEF_MASK		= INT_RESERVED | INT_Q_OVERFLOW |
-				  INT_RESPONSE,
-
-	/* command messages, and related register bits */
-	CARM_HAVE_RESP		= 0x01,
-	CARM_MSG_READ		= 1,
-	CARM_MSG_WRITE		= 2,
-	CARM_MSG_VERIFY		= 3,
-	CARM_MSG_GET_CAPACITY	= 4,
-	CARM_MSG_FLUSH		= 5,
-	CARM_MSG_IOCTL		= 6,
-	CARM_MSG_ARRAY		= 8,
-	CARM_MSG_MISC		= 9,
-	CARM_CME		= (1 << 2),
-	CARM_RME		= (1 << 1),
-	CARM_WZBC		= (1 << 0),
-	CARM_RMI		= (1 << 0),
-	CARM_Q_FULL		= (1 << 3),
-	CARM_MSG_SIZE		= 288,
-	CARM_Q_LEN		= 48,
-
-	/* CARM_MSG_IOCTL messages */
-	CARM_IOC_SCAN_CHAN	= 5,	/* scan channels for devices */
-	CARM_IOC_GET_TCQ	= 13,	/* get tcq/ncq depth */
-	CARM_IOC_SET_TCQ	= 14,	/* set tcq/ncq depth */
-
-	IOC_SCAN_CHAN_NODEV	= 0x1f,
-	IOC_SCAN_CHAN_OFFSET	= 0x40,
-
-	/* CARM_MSG_ARRAY messages */
-	CARM_ARRAY_INFO		= 0,
-
-	ARRAY_NO_EXIST		= (1 << 31),
-
-	/* response messages */
-	RMSG_SZ			= 8,	/* sizeof(struct carm_response) */
-	RMSG_Q_LEN		= 48,	/* resp. msg list length */
-	RMSG_OK			= 1,	/* bit indicating msg was successful */
-					/* length of entire resp. msg buffer */
-	RBUF_LEN		= RMSG_SZ * RMSG_Q_LEN,
-
-	PDC_SHM_SIZE		= (4096 << 7), /* length of entire h/w buffer */
-
-	/* CARM_MSG_MISC messages */
-	MISC_GET_FW_VER		= 2,
-	MISC_ALLOC_MEM		= 3,
-	MISC_SET_TIME		= 5,
-
-	/* MISC_GET_FW_VER feature bits */
-	FW_VER_4PORT		= (1 << 2), /* 1=4 ports, 0=8 ports */
-	FW_VER_NON_RAID		= (1 << 1), /* 1=non-RAID firmware, 0=RAID */
-	FW_VER_ZCR		= (1 << 0), /* zero channel RAID (whatever that is) */
-
-	/* carm_host flags */
-	FL_NON_RAID		= FW_VER_NON_RAID,
-	FL_4PORT		= FW_VER_4PORT,
-	FL_FW_VER_MASK		= (FW_VER_NON_RAID | FW_VER_4PORT),
-	FL_DYN_MAJOR		= (1 << 17),
-};
-
-enum {
-	CARM_SG_BOUNDARY	= 0xffffUL,	    /* s/g segment boundary */
-};
-
-enum scatter_gather_types {
-	SGT_32BIT		= 0,
-	SGT_64BIT		= 1,
-};
-
-enum host_states {
-	HST_INVALID,		/* invalid state; never used */
-	HST_ALLOC_BUF,		/* setting up master SHM area */
-	HST_ERROR,		/* we never leave here */
-	HST_PORT_SCAN,		/* start dev scan */
-	HST_DEV_SCAN_START,	/* start per-device probe */
-	HST_DEV_SCAN,		/* continue per-device probe */
-	HST_DEV_ACTIVATE,	/* activate devices we found */
-	HST_PROBE_FINISHED,	/* probe is complete */
-	HST_PROBE_START,	/* initiate probe */
-	HST_SYNC_TIME,		/* tell firmware what time it is */
-	HST_GET_FW_VER,		/* get firmware version, adapter port cnt */
-};
-
-#ifdef CARM_DEBUG
-static const char *state_name[] = {
-	"HST_INVALID",
-	"HST_ALLOC_BUF",
-	"HST_ERROR",
-	"HST_PORT_SCAN",
-	"HST_DEV_SCAN_START",
-	"HST_DEV_SCAN",
-	"HST_DEV_ACTIVATE",
-	"HST_PROBE_FINISHED",
-	"HST_PROBE_START",
-	"HST_SYNC_TIME",
-	"HST_GET_FW_VER",
-};
-#endif
-
-struct carm_port {
-	unsigned int			port_no;
-	struct gendisk			*disk;
-	struct carm_host		*host;
-
-	/* attached device characteristics */
-	u64				capacity;
-	char				name[41];
-	u16				dev_geom_head;
-	u16				dev_geom_sect;
-	u16				dev_geom_cyl;
-};
-
-struct carm_request {
-	int				n_elem;
-	unsigned int			msg_type;
-	unsigned int			msg_subtype;
-	unsigned int			msg_bucket;
-	struct scatterlist		sg[CARM_MAX_REQ_SG];
-};
-
-struct carm_host {
-	unsigned long			flags;
-	void				__iomem *mmio;
-	void				*shm;
-	dma_addr_t			shm_dma;
-
-	int				major;
-	int				id;
-	char				name[32];
-
-	spinlock_t			lock;
-	struct pci_dev			*pdev;
-	unsigned int			state;
-	u32				fw_ver;
-
-	struct blk_mq_tag_set		tag_set;
-	struct request_queue		*oob_q;
-	unsigned int			n_oob;
-
-	unsigned int			hw_sg_used;
-
-	unsigned int			resp_idx;
-
-	unsigned int			wait_q_prod;
-	unsigned int			wait_q_cons;
-	struct request_queue		*wait_q[CARM_MAX_WAIT_Q];
-
-	void				*msg_base;
-	dma_addr_t			msg_dma;
-
-	int				cur_scan_dev;
-	unsigned long			dev_active;
-	unsigned long			dev_present;
-	struct carm_port		port[CARM_MAX_PORTS];
-
-	struct work_struct		fsm_task;
-
-	struct completion		probe_comp;
-};
-
-struct carm_response {
-	__le32 ret_handle;
-	__le32 status;
-}  __attribute__((packed));
-
-struct carm_msg_sg {
-	__le32 start;
-	__le32 len;
-}  __attribute__((packed));
-
-struct carm_msg_rw {
-	u8 type;
-	u8 id;
-	u8 sg_count;
-	u8 sg_type;
-	__le32 handle;
-	__le32 lba;
-	__le16 lba_count;
-	__le16 lba_high;
-	struct carm_msg_sg sg[32];
-}  __attribute__((packed));
-
-struct carm_msg_allocbuf {
-	u8 type;
-	u8 subtype;
-	u8 n_sg;
-	u8 sg_type;
-	__le32 handle;
-	__le32 addr;
-	__le32 len;
-	__le32 evt_pool;
-	__le32 n_evt;
-	__le32 rbuf_pool;
-	__le32 n_rbuf;
-	__le32 msg_pool;
-	__le32 n_msg;
-	struct carm_msg_sg sg[8];
-}  __attribute__((packed));
-
-struct carm_msg_ioctl {
-	u8 type;
-	u8 subtype;
-	u8 array_id;
-	u8 reserved1;
-	__le32 handle;
-	__le32 data_addr;
-	u32 reserved2;
-}  __attribute__((packed));
-
-struct carm_msg_sync_time {
-	u8 type;
-	u8 subtype;
-	u16 reserved1;
-	__le32 handle;
-	u32 reserved2;
-	__le32 timestamp;
-}  __attribute__((packed));
-
-struct carm_msg_get_fw_ver {
-	u8 type;
-	u8 subtype;
-	u16 reserved1;
-	__le32 handle;
-	__le32 data_addr;
-	u32 reserved2;
-}  __attribute__((packed));
-
-struct carm_fw_ver {
-	__le32 version;
-	u8 features;
-	u8 reserved1;
-	u16 reserved2;
-}  __attribute__((packed));
-
-struct carm_array_info {
-	__le32 size;
-
-	__le16 size_hi;
-	__le16 stripe_size;
-
-	__le32 mode;
-
-	__le16 stripe_blk_sz;
-	__le16 reserved1;
-
-	__le16 cyl;
-	__le16 head;
-
-	__le16 sect;
-	u8 array_id;
-	u8 reserved2;
-
-	char name[40];
-
-	__le32 array_status;
-
-	/* device list continues beyond this point? */
-}  __attribute__((packed));
-
-static int carm_init_one (struct pci_dev *pdev, const struct pci_device_id *ent);
-static void carm_remove_one (struct pci_dev *pdev);
-static int carm_bdev_getgeo(struct block_device *bdev, struct hd_geometry *geo);
-
-static const struct pci_device_id carm_pci_tbl[] = {
-	{ PCI_VENDOR_ID_PROMISE, 0x8000, PCI_ANY_ID, PCI_ANY_ID, 0, 0, },
-	{ PCI_VENDOR_ID_PROMISE, 0x8002, PCI_ANY_ID, PCI_ANY_ID, 0, 0, },
-	{ }	/* terminate list */
-};
-MODULE_DEVICE_TABLE(pci, carm_pci_tbl);
-
-static struct pci_driver carm_driver = {
-	.name		= DRV_NAME,
-	.id_table	= carm_pci_tbl,
-	.probe		= carm_init_one,
-	.remove		= carm_remove_one,
-};
-
-static const struct block_device_operations carm_bd_ops = {
-	.owner		= THIS_MODULE,
-	.getgeo		= carm_bdev_getgeo,
-};
-
-static unsigned int carm_host_id;
-static unsigned long carm_major_alloc;
-
-
-
-static int carm_bdev_getgeo(struct block_device *bdev, struct hd_geometry *geo)
-{
-	struct carm_port *port = bdev->bd_disk->private_data;
-
-	geo->heads = (u8) port->dev_geom_head;
-	geo->sectors = (u8) port->dev_geom_sect;
-	geo->cylinders = port->dev_geom_cyl;
-	return 0;
-}
-
-static const u32 msg_sizes[] = { 32, 64, 128, CARM_MSG_SIZE };
-
-static inline int carm_lookup_bucket(u32 msg_size)
-{
-	int i;
-
-	for (i = 0; i < ARRAY_SIZE(msg_sizes); i++)
-		if (msg_size <= msg_sizes[i])
-			return i;
-
-	return -ENOENT;
-}
-
-static void carm_init_buckets(void __iomem *mmio)
-{
-	unsigned int i;
-
-	for (i = 0; i < ARRAY_SIZE(msg_sizes); i++)
-		writel(msg_sizes[i], mmio + CARM_CMS0 + (4 * i));
-}
-
-static inline void *carm_ref_msg(struct carm_host *host,
-				 unsigned int msg_idx)
-{
-	return host->msg_base + (msg_idx * CARM_MSG_SIZE);
-}
-
-static inline dma_addr_t carm_ref_msg_dma(struct carm_host *host,
-					  unsigned int msg_idx)
-{
-	return host->msg_dma + (msg_idx * CARM_MSG_SIZE);
-}
-
-static int carm_send_msg(struct carm_host *host,
-			 struct carm_request *crq, unsigned tag)
-{
-	void __iomem *mmio = host->mmio;
-	u32 msg = (u32) carm_ref_msg_dma(host, tag);
-	u32 cm_bucket = crq->msg_bucket;
-	u32 tmp;
-	int rc = 0;
-
-	VPRINTK("ENTER\n");
-
-	tmp = readl(mmio + CARM_HMUC);
-	if (tmp & CARM_Q_FULL) {
-#if 0
-		tmp = readl(mmio + CARM_INT_MASK);
-		tmp |= INT_Q_AVAILABLE;
-		writel(tmp, mmio + CARM_INT_MASK);
-		readl(mmio + CARM_INT_MASK);	/* flush */
-#endif
-		DPRINTK("host msg queue full\n");
-		rc = -EBUSY;
-	} else {
-		writel(msg | (cm_bucket << 1), mmio + CARM_IHQP);
-		readl(mmio + CARM_IHQP);	/* flush */
-	}
-
-	return rc;
-}
-
-static int carm_array_info (struct carm_host *host, unsigned int array_idx)
-{
-	struct carm_msg_ioctl *ioc;
-	u32 msg_data;
-	dma_addr_t msg_dma;
-	struct carm_request *crq;
-	struct request *rq;
-	int rc;
-
-	rq = blk_mq_alloc_request(host->oob_q, REQ_OP_DRV_OUT, 0);
-	if (IS_ERR(rq)) {
-		rc = -ENOMEM;
-		goto err_out;
-	}
-	crq = blk_mq_rq_to_pdu(rq);
-
-	ioc = carm_ref_msg(host, rq->tag);
-	msg_dma = carm_ref_msg_dma(host, rq->tag);
-	msg_data = (u32) (msg_dma + sizeof(struct carm_array_info));
-
-	crq->msg_type = CARM_MSG_ARRAY;
-	crq->msg_subtype = CARM_ARRAY_INFO;
-	rc = carm_lookup_bucket(sizeof(struct carm_msg_ioctl) +
-				sizeof(struct carm_array_info));
-	BUG_ON(rc < 0);
-	crq->msg_bucket = (u32) rc;
-
-	memset(ioc, 0, sizeof(*ioc));
-	ioc->type	= CARM_MSG_ARRAY;
-	ioc->subtype	= CARM_ARRAY_INFO;
-	ioc->array_id	= (u8) array_idx;
-	ioc->handle	= cpu_to_le32(TAG_ENCODE(rq->tag));
-	ioc->data_addr	= cpu_to_le32(msg_data);
-
-	spin_lock_irq(&host->lock);
-	assert(host->state == HST_DEV_SCAN_START ||
-	       host->state == HST_DEV_SCAN);
-	spin_unlock_irq(&host->lock);
-
-	DPRINTK("blk_execute_rq_nowait, tag == %u\n", rq->tag);
-	blk_execute_rq_nowait(NULL, rq, true, NULL);
-
-	return 0;
-
-err_out:
-	spin_lock_irq(&host->lock);
-	host->state = HST_ERROR;
-	spin_unlock_irq(&host->lock);
-	return rc;
-}
-
-typedef unsigned int (*carm_sspc_t)(struct carm_host *, unsigned int, void *);
-
-static int carm_send_special (struct carm_host *host, carm_sspc_t func)
-{
-	struct request *rq;
-	struct carm_request *crq;
-	struct carm_msg_ioctl *ioc;
-	void *mem;
-	unsigned int msg_size;
-	int rc;
-
-	rq = blk_mq_alloc_request(host->oob_q, REQ_OP_DRV_OUT, 0);
-	if (IS_ERR(rq))
-		return -ENOMEM;
-	crq = blk_mq_rq_to_pdu(rq);
-
-	mem = carm_ref_msg(host, rq->tag);
-
-	msg_size = func(host, rq->tag, mem);
-
-	ioc = mem;
-	crq->msg_type = ioc->type;
-	crq->msg_subtype = ioc->subtype;
-	rc = carm_lookup_bucket(msg_size);
-	BUG_ON(rc < 0);
-	crq->msg_bucket = (u32) rc;
-
-	DPRINTK("blk_execute_rq_nowait, tag == %u\n", rq->tag);
-	blk_execute_rq_nowait(NULL, rq, true, NULL);
-
-	return 0;
-}
-
-static unsigned int carm_fill_sync_time(struct carm_host *host,
-					unsigned int idx, void *mem)
-{
-	struct carm_msg_sync_time *st = mem;
-
-	time64_t tv = ktime_get_real_seconds();
-
-	memset(st, 0, sizeof(*st));
-	st->type	= CARM_MSG_MISC;
-	st->subtype	= MISC_SET_TIME;
-	st->handle	= cpu_to_le32(TAG_ENCODE(idx));
-	st->timestamp	= cpu_to_le32(tv);
-
-	return sizeof(struct carm_msg_sync_time);
-}
-
-static unsigned int carm_fill_alloc_buf(struct carm_host *host,
-					unsigned int idx, void *mem)
-{
-	struct carm_msg_allocbuf *ab = mem;
-
-	memset(ab, 0, sizeof(*ab));
-	ab->type	= CARM_MSG_MISC;
-	ab->subtype	= MISC_ALLOC_MEM;
-	ab->handle	= cpu_to_le32(TAG_ENCODE(idx));
-	ab->n_sg	= 1;
-	ab->sg_type	= SGT_32BIT;
-	ab->addr	= cpu_to_le32(host->shm_dma + (PDC_SHM_SIZE >> 1));
-	ab->len		= cpu_to_le32(PDC_SHM_SIZE >> 1);
-	ab->evt_pool	= cpu_to_le32(host->shm_dma + (16 * 1024));
-	ab->n_evt	= cpu_to_le32(1024);
-	ab->rbuf_pool	= cpu_to_le32(host->shm_dma);
-	ab->n_rbuf	= cpu_to_le32(RMSG_Q_LEN);
-	ab->msg_pool	= cpu_to_le32(host->shm_dma + RBUF_LEN);
-	ab->n_msg	= cpu_to_le32(CARM_Q_LEN);
-	ab->sg[0].start	= cpu_to_le32(host->shm_dma + (PDC_SHM_SIZE >> 1));
-	ab->sg[0].len	= cpu_to_le32(65536);
-
-	return sizeof(struct carm_msg_allocbuf);
-}
-
-static unsigned int carm_fill_scan_channels(struct carm_host *host,
-					    unsigned int idx, void *mem)
-{
-	struct carm_msg_ioctl *ioc = mem;
-	u32 msg_data = (u32) (carm_ref_msg_dma(host, idx) +
-			      IOC_SCAN_CHAN_OFFSET);
-
-	memset(ioc, 0, sizeof(*ioc));
-	ioc->type	= CARM_MSG_IOCTL;
-	ioc->subtype	= CARM_IOC_SCAN_CHAN;
-	ioc->handle	= cpu_to_le32(TAG_ENCODE(idx));
-	ioc->data_addr	= cpu_to_le32(msg_data);
-
-	/* fill output data area with "no device" default values */
-	mem += IOC_SCAN_CHAN_OFFSET;
-	memset(mem, IOC_SCAN_CHAN_NODEV, CARM_MAX_PORTS);
-
-	return IOC_SCAN_CHAN_OFFSET + CARM_MAX_PORTS;
-}
-
-static unsigned int carm_fill_get_fw_ver(struct carm_host *host,
-					 unsigned int idx, void *mem)
-{
-	struct carm_msg_get_fw_ver *ioc = mem;
-	u32 msg_data = (u32) (carm_ref_msg_dma(host, idx) + sizeof(*ioc));
-
-	memset(ioc, 0, sizeof(*ioc));
-	ioc->type	= CARM_MSG_MISC;
-	ioc->subtype	= MISC_GET_FW_VER;
-	ioc->handle	= cpu_to_le32(TAG_ENCODE(idx));
-	ioc->data_addr	= cpu_to_le32(msg_data);
-
-	return sizeof(struct carm_msg_get_fw_ver) +
-	       sizeof(struct carm_fw_ver);
-}
-
-static inline void carm_push_q (struct carm_host *host, struct request_queue *q)
-{
-	unsigned int idx = host->wait_q_prod % CARM_MAX_WAIT_Q;
-
-	blk_mq_stop_hw_queues(q);
-	VPRINTK("STOPPED QUEUE %p\n", q);
-
-	host->wait_q[idx] = q;
-	host->wait_q_prod++;
-	BUG_ON(host->wait_q_prod == host->wait_q_cons); /* overrun */
-}
-
-static inline struct request_queue *carm_pop_q(struct carm_host *host)
-{
-	unsigned int idx;
-
-	if (host->wait_q_prod == host->wait_q_cons)
-		return NULL;
-
-	idx = host->wait_q_cons % CARM_MAX_WAIT_Q;
-	host->wait_q_cons++;
-
-	return host->wait_q[idx];
-}
-
-static inline void carm_round_robin(struct carm_host *host)
-{
-	struct request_queue *q = carm_pop_q(host);
-	if (q) {
-		blk_mq_start_hw_queues(q);
-		VPRINTK("STARTED QUEUE %p\n", q);
-	}
-}
-
-static inline enum dma_data_direction carm_rq_dir(struct request *rq)
-{
-	return op_is_write(req_op(rq)) ? DMA_TO_DEVICE : DMA_FROM_DEVICE;
-}
-
-static blk_status_t carm_queue_rq(struct blk_mq_hw_ctx *hctx,
-				  const struct blk_mq_queue_data *bd)
-{
-	struct request_queue *q = hctx->queue;
-	struct request *rq = bd->rq;
-	struct carm_port *port = q->queuedata;
-	struct carm_host *host = port->host;
-	struct carm_request *crq = blk_mq_rq_to_pdu(rq);
-	struct carm_msg_rw *msg;
-	struct scatterlist *sg;
-	int i, n_elem = 0, rc;
-	unsigned int msg_size;
-	u32 tmp;
-
-	crq->n_elem = 0;
-	sg_init_table(crq->sg, CARM_MAX_REQ_SG);
-
-	blk_mq_start_request(rq);
-
-	spin_lock_irq(&host->lock);
-	if (req_op(rq) == REQ_OP_DRV_OUT)
-		goto send_msg;
-
-	/* get scatterlist from block layer */
-	sg = &crq->sg[0];
-	n_elem = blk_rq_map_sg(q, rq, sg);
-	if (n_elem <= 0)
-		goto out_ioerr;
-
-	/* map scatterlist to PCI bus addresses */
-	n_elem = dma_map_sg(&host->pdev->dev, sg, n_elem, carm_rq_dir(rq));
-	if (n_elem <= 0)
-		goto out_ioerr;
-
-	/* obey global hardware limit on S/G entries */
-	if (host->hw_sg_used >= CARM_MAX_HOST_SG - n_elem)
-		goto out_resource;
-
-	crq->n_elem = n_elem;
-	host->hw_sg_used += n_elem;
-
-	/*
-	 * build read/write message
-	 */
-
-	VPRINTK("build msg\n");
-	msg = (struct carm_msg_rw *) carm_ref_msg(host, rq->tag);
-
-	if (rq_data_dir(rq) == WRITE) {
-		msg->type = CARM_MSG_WRITE;
-		crq->msg_type = CARM_MSG_WRITE;
-	} else {
-		msg->type = CARM_MSG_READ;
-		crq->msg_type = CARM_MSG_READ;
-	}
-
-	msg->id		= port->port_no;
-	msg->sg_count	= n_elem;
-	msg->sg_type	= SGT_32BIT;
-	msg->handle	= cpu_to_le32(TAG_ENCODE(rq->tag));
-	msg->lba	= cpu_to_le32(blk_rq_pos(rq) & 0xffffffff);
-	tmp		= (blk_rq_pos(rq) >> 16) >> 16;
-	msg->lba_high	= cpu_to_le16( (u16) tmp );
-	msg->lba_count	= cpu_to_le16(blk_rq_sectors(rq));
-
-	msg_size = sizeof(struct carm_msg_rw) - sizeof(msg->sg);
-	for (i = 0; i < n_elem; i++) {
-		struct carm_msg_sg *carm_sg = &msg->sg[i];
-		carm_sg->start = cpu_to_le32(sg_dma_address(&crq->sg[i]));
-		carm_sg->len = cpu_to_le32(sg_dma_len(&crq->sg[i]));
-		msg_size += sizeof(struct carm_msg_sg);
-	}
-
-	rc = carm_lookup_bucket(msg_size);
-	BUG_ON(rc < 0);
-	crq->msg_bucket = (u32) rc;
-send_msg:
-	/*
-	 * queue read/write message to hardware
-	 */
-	VPRINTK("send msg, tag == %u\n", rq->tag);
-	rc = carm_send_msg(host, crq, rq->tag);
-	if (rc) {
-		host->hw_sg_used -= n_elem;
-		goto out_resource;
-	}
-
-	spin_unlock_irq(&host->lock);
-	return BLK_STS_OK;
-out_resource:
-	dma_unmap_sg(&host->pdev->dev, &crq->sg[0], n_elem, carm_rq_dir(rq));
-	carm_push_q(host, q);
-	spin_unlock_irq(&host->lock);
-	return BLK_STS_DEV_RESOURCE;
-out_ioerr:
-	carm_round_robin(host);
-	spin_unlock_irq(&host->lock);
-	return BLK_STS_IOERR;
-}
-
-static void carm_handle_array_info(struct carm_host *host,
-				   struct carm_request *crq, u8 *mem,
-				   blk_status_t error)
-{
-	struct carm_port *port;
-	u8 *msg_data = mem + sizeof(struct carm_array_info);
-	struct carm_array_info *desc = (struct carm_array_info *) msg_data;
-	u64 lo, hi;
-	int cur_port;
-	size_t slen;
-
-	DPRINTK("ENTER\n");
-
-	if (error)
-		goto out;
-	if (le32_to_cpu(desc->array_status) & ARRAY_NO_EXIST)
-		goto out;
-
-	cur_port = host->cur_scan_dev;
-
-	/* should never occur */
-	if ((cur_port < 0) || (cur_port >= CARM_MAX_PORTS)) {
-		printk(KERN_ERR PFX "BUG: cur_scan_dev==%d, array_id==%d\n",
-		       cur_port, (int) desc->array_id);
-		goto out;
-	}
-
-	port = &host->port[cur_port];
-
-	lo = (u64) le32_to_cpu(desc->size);
-	hi = (u64) le16_to_cpu(desc->size_hi);
-
-	port->capacity = lo | (hi << 32);
-	port->dev_geom_head = le16_to_cpu(desc->head);
-	port->dev_geom_sect = le16_to_cpu(desc->sect);
-	port->dev_geom_cyl = le16_to_cpu(desc->cyl);
-
-	host->dev_active |= (1 << cur_port);
-
-	strncpy(port->name, desc->name, sizeof(port->name));
-	port->name[sizeof(port->name) - 1] = 0;
-	slen = strlen(port->name);
-	while (slen && (port->name[slen - 1] == ' ')) {
-		port->name[slen - 1] = 0;
-		slen--;
-	}
-
-	printk(KERN_INFO DRV_NAME "(%s): port %u device %Lu sectors\n",
-	       pci_name(host->pdev), port->port_no,
-	       (unsigned long long) port->capacity);
-	printk(KERN_INFO DRV_NAME "(%s): port %u device \"%s\"\n",
-	       pci_name(host->pdev), port->port_no, port->name);
-
-out:
-	assert(host->state == HST_DEV_SCAN);
-	schedule_work(&host->fsm_task);
-}
-
-static void carm_handle_scan_chan(struct carm_host *host,
-				  struct carm_request *crq, u8 *mem,
-				  blk_status_t error)
-{
-	u8 *msg_data = mem + IOC_SCAN_CHAN_OFFSET;
-	unsigned int i, dev_count = 0;
-	int new_state = HST_DEV_SCAN_START;
-
-	DPRINTK("ENTER\n");
-
-	if (error) {
-		new_state = HST_ERROR;
-		goto out;
-	}
-
-	/* TODO: scan and support non-disk devices */
-	for (i = 0; i < 8; i++)
-		if (msg_data[i] == 0) { /* direct-access device (disk) */
-			host->dev_present |= (1 << i);
-			dev_count++;
-		}
-
-	printk(KERN_INFO DRV_NAME "(%s): found %u interesting devices\n",
-	       pci_name(host->pdev), dev_count);
-
-out:
-	assert(host->state == HST_PORT_SCAN);
-	host->state = new_state;
-	schedule_work(&host->fsm_task);
-}
-
-static void carm_handle_generic(struct carm_host *host,
-				struct carm_request *crq, blk_status_t error,
-				int cur_state, int next_state)
-{
-	DPRINTK("ENTER\n");
-
-	assert(host->state == cur_state);
-	if (error)
-		host->state = HST_ERROR;
-	else
-		host->state = next_state;
-	schedule_work(&host->fsm_task);
-}
-
-static inline void carm_handle_resp(struct carm_host *host,
-				    __le32 ret_handle_le, u32 status)
-{
-	u32 handle = le32_to_cpu(ret_handle_le);
-	unsigned int msg_idx;
-	struct request *rq;
-	struct carm_request *crq;
-	blk_status_t error = (status == RMSG_OK) ? 0 : BLK_STS_IOERR;
-	u8 *mem;
-
-	VPRINTK("ENTER, handle == 0x%x\n", handle);
-
-	if (unlikely(!TAG_VALID(handle))) {
-		printk(KERN_ERR DRV_NAME "(%s): BUG: invalid tag 0x%x\n",
-		       pci_name(host->pdev), handle);
-		return;
-	}
-
-	msg_idx = TAG_DECODE(handle);
-	VPRINTK("tag == %u\n", msg_idx);
-
-	rq = blk_mq_tag_to_rq(host->tag_set.tags[0], msg_idx);
-	crq = blk_mq_rq_to_pdu(rq);
-
-	/* fast path */
-	if (likely(crq->msg_type == CARM_MSG_READ ||
-		   crq->msg_type == CARM_MSG_WRITE)) {
-		dma_unmap_sg(&host->pdev->dev, &crq->sg[0], crq->n_elem,
-			     carm_rq_dir(rq));
-		goto done;
-	}
-
-	mem = carm_ref_msg(host, msg_idx);
-
-	switch (crq->msg_type) {
-	case CARM_MSG_IOCTL: {
-		switch (crq->msg_subtype) {
-		case CARM_IOC_SCAN_CHAN:
-			carm_handle_scan_chan(host, crq, mem, error);
-			goto done;
-		default:
-			/* unknown / invalid response */
-			goto err_out;
-		}
-		break;
-	}
-
-	case CARM_MSG_MISC: {
-		switch (crq->msg_subtype) {
-		case MISC_ALLOC_MEM:
-			carm_handle_generic(host, crq, error,
-					    HST_ALLOC_BUF, HST_SYNC_TIME);
-			goto done;
-		case MISC_SET_TIME:
-			carm_handle_generic(host, crq, error,
-					    HST_SYNC_TIME, HST_GET_FW_VER);
-			goto done;
-		case MISC_GET_FW_VER: {
-			struct carm_fw_ver *ver = (struct carm_fw_ver *)
-				(mem + sizeof(struct carm_msg_get_fw_ver));
-			if (!error) {
-				host->fw_ver = le32_to_cpu(ver->version);
-				host->flags |= (ver->features & FL_FW_VER_MASK);
-			}
-			carm_handle_generic(host, crq, error,
-					    HST_GET_FW_VER, HST_PORT_SCAN);
-			goto done;
-		}
-		default:
-			/* unknown / invalid response */
-			goto err_out;
-		}
-		break;
-	}
-
-	case CARM_MSG_ARRAY: {
-		switch (crq->msg_subtype) {
-		case CARM_ARRAY_INFO:
-			carm_handle_array_info(host, crq, mem, error);
-			break;
-		default:
-			/* unknown / invalid response */
-			goto err_out;
-		}
-		break;
-	}
-
-	default:
-		/* unknown / invalid response */
-		goto err_out;
-	}
-
-	return;
-
-err_out:
-	printk(KERN_WARNING DRV_NAME "(%s): BUG: unhandled message type %d/%d\n",
-	       pci_name(host->pdev), crq->msg_type, crq->msg_subtype);
-	error = BLK_STS_IOERR;
-done:
-	host->hw_sg_used -= crq->n_elem;
-	blk_mq_end_request(blk_mq_rq_from_pdu(crq), error);
-
-	if (host->hw_sg_used <= CARM_SG_LOW_WATER)
-		carm_round_robin(host);
-}
-
-static inline void carm_handle_responses(struct carm_host *host)
-{
-	void __iomem *mmio = host->mmio;
-	struct carm_response *resp = (struct carm_response *) host->shm;
-	unsigned int work = 0;
-	unsigned int idx = host->resp_idx % RMSG_Q_LEN;
-
-	while (1) {
-		u32 status = le32_to_cpu(resp[idx].status);
-
-		if (status == 0xffffffff) {
-			VPRINTK("ending response on index %u\n", idx);
-			writel(idx << 3, mmio + CARM_RESP_IDX);
-			break;
-		}
-
-		/* response to a message we sent */
-		else if ((status & (1 << 31)) == 0) {
-			VPRINTK("handling msg response on index %u\n", idx);
-			carm_handle_resp(host, resp[idx].ret_handle, status);
-			resp[idx].status = cpu_to_le32(0xffffffff);
-		}
-
-		/* asynchronous events the hardware throws our way */
-		else if ((status & 0xff000000) == (1 << 31)) {
-			u8 *evt_type_ptr = (u8 *) &resp[idx];
-			u8 evt_type = *evt_type_ptr;
-			printk(KERN_WARNING DRV_NAME "(%s): unhandled event type %d\n",
-			       pci_name(host->pdev), (int) evt_type);
-			resp[idx].status = cpu_to_le32(0xffffffff);
-		}
-
-		idx = NEXT_RESP(idx);
-		work++;
-	}
-
-	VPRINTK("EXIT, work==%u\n", work);
-	host->resp_idx += work;
-}
-
-static irqreturn_t carm_interrupt(int irq, void *__host)
-{
-	struct carm_host *host = __host;
-	void __iomem *mmio;
-	u32 mask;
-	int handled = 0;
-	unsigned long flags;
-
-	if (!host) {
-		VPRINTK("no host\n");
-		return IRQ_NONE;
-	}
-
-	spin_lock_irqsave(&host->lock, flags);
-
-	mmio = host->mmio;
-
-	/* reading should also clear interrupts */
-	mask = readl(mmio + CARM_INT_STAT);
-
-	if (mask == 0 || mask == 0xffffffff) {
-		VPRINTK("no work, mask == 0x%x\n", mask);
-		goto out;
-	}
-
-	if (mask & INT_ACK_MASK)
-		writel(mask, mmio + CARM_INT_STAT);
-
-	if (unlikely(host->state == HST_INVALID)) {
-		VPRINTK("not initialized yet, mask = 0x%x\n", mask);
-		goto out;
-	}
-
-	if (mask & CARM_HAVE_RESP) {
-		handled = 1;
-		carm_handle_responses(host);
-	}
-
-out:
-	spin_unlock_irqrestore(&host->lock, flags);
-	VPRINTK("EXIT\n");
-	return IRQ_RETVAL(handled);
-}
-
-static void carm_fsm_task (struct work_struct *work)
-{
-	struct carm_host *host =
-		container_of(work, struct carm_host, fsm_task);
-	unsigned long flags;
-	unsigned int state;
-	int rc, i, next_dev;
-	int reschedule = 0;
-	int new_state = HST_INVALID;
-
-	spin_lock_irqsave(&host->lock, flags);
-	state = host->state;
-	spin_unlock_irqrestore(&host->lock, flags);
-
-	DPRINTK("ENTER, state == %s\n", state_name[state]);
-
-	switch (state) {
-	case HST_PROBE_START:
-		new_state = HST_ALLOC_BUF;
-		reschedule = 1;
-		break;
-
-	case HST_ALLOC_BUF:
-		rc = carm_send_special(host, carm_fill_alloc_buf);
-		if (rc) {
-			new_state = HST_ERROR;
-			reschedule = 1;
-		}
-		break;
-
-	case HST_SYNC_TIME:
-		rc = carm_send_special(host, carm_fill_sync_time);
-		if (rc) {
-			new_state = HST_ERROR;
-			reschedule = 1;
-		}
-		break;
-
-	case HST_GET_FW_VER:
-		rc = carm_send_special(host, carm_fill_get_fw_ver);
-		if (rc) {
-			new_state = HST_ERROR;
-			reschedule = 1;
-		}
-		break;
-
-	case HST_PORT_SCAN:
-		rc = carm_send_special(host, carm_fill_scan_channels);
-		if (rc) {
-			new_state = HST_ERROR;
-			reschedule = 1;
-		}
-		break;
-
-	case HST_DEV_SCAN_START:
-		host->cur_scan_dev = -1;
-		new_state = HST_DEV_SCAN;
-		reschedule = 1;
-		break;
-
-	case HST_DEV_SCAN:
-		next_dev = -1;
-		for (i = host->cur_scan_dev + 1; i < CARM_MAX_PORTS; i++)
-			if (host->dev_present & (1 << i)) {
-				next_dev = i;
-				break;
-			}
-
-		if (next_dev >= 0) {
-			host->cur_scan_dev = next_dev;
-			rc = carm_array_info(host, next_dev);
-			if (rc) {
-				new_state = HST_ERROR;
-				reschedule = 1;
-			}
-		} else {
-			new_state = HST_DEV_ACTIVATE;
-			reschedule = 1;
-		}
-		break;
-
-	case HST_DEV_ACTIVATE: {
-		int activated = 0;
-		for (i = 0; i < CARM_MAX_PORTS; i++)
-			if (host->dev_active & (1 << i)) {
-				struct carm_port *port = &host->port[i];
-				struct gendisk *disk = port->disk;
-
-				set_capacity(disk, port->capacity);
-				add_disk(disk);
-				activated++;
-			}
-
-		printk(KERN_INFO DRV_NAME "(%s): %d ports activated\n",
-		       pci_name(host->pdev), activated);
-
-		new_state = HST_PROBE_FINISHED;
-		reschedule = 1;
-		break;
-	}
-
-	case HST_PROBE_FINISHED:
-		complete(&host->probe_comp);
-		break;
-
-	case HST_ERROR:
-		/* FIXME: TODO */
-		break;
-
-	default:
-		/* should never occur */
-		printk(KERN_ERR PFX "BUG: unknown state %d\n", state);
-		assert(0);
-		break;
-	}
-
-	if (new_state != HST_INVALID) {
-		spin_lock_irqsave(&host->lock, flags);
-		host->state = new_state;
-		spin_unlock_irqrestore(&host->lock, flags);
-	}
-	if (reschedule)
-		schedule_work(&host->fsm_task);
-}
-
-static int carm_init_wait(void __iomem *mmio, u32 bits, unsigned int test_bit)
-{
-	unsigned int i;
-
-	for (i = 0; i < 50000; i++) {
-		u32 tmp = readl(mmio + CARM_LMUC);
-		udelay(100);
-
-		if (test_bit) {
-			if ((tmp & bits) == bits)
-				return 0;
-		} else {
-			if ((tmp & bits) == 0)
-				return 0;
-		}
-
-		cond_resched();
-	}
-
-	printk(KERN_ERR PFX "carm_init_wait timeout, bits == 0x%x, test_bit == %s\n",
-	       bits, test_bit ? "yes" : "no");
-	return -EBUSY;
-}
-
-static void carm_init_responses(struct carm_host *host)
-{
-	void __iomem *mmio = host->mmio;
-	unsigned int i;
-	struct carm_response *resp = (struct carm_response *) host->shm;
-
-	for (i = 0; i < RMSG_Q_LEN; i++)
-		resp[i].status = cpu_to_le32(0xffffffff);
-
-	writel(0, mmio + CARM_RESP_IDX);
-}
-
-static int carm_init_host(struct carm_host *host)
-{
-	void __iomem *mmio = host->mmio;
-	u32 tmp;
-	u8 tmp8;
-	int rc;
-
-	DPRINTK("ENTER\n");
-
-	writel(0, mmio + CARM_INT_MASK);
-
-	tmp8 = readb(mmio + CARM_INITC);
-	if (tmp8 & 0x01) {
-		tmp8 &= ~0x01;
-		writeb(tmp8, mmio + CARM_INITC);
-		readb(mmio + CARM_INITC);	/* flush */
-
-		DPRINTK("snooze...\n");
-		msleep(5000);
-	}
-
-	tmp = readl(mmio + CARM_HMUC);
-	if (tmp & CARM_CME) {
-		DPRINTK("CME bit present, waiting\n");
-		rc = carm_init_wait(mmio, CARM_CME, 1);
-		if (rc) {
-			DPRINTK("EXIT, carm_init_wait 1 failed\n");
-			return rc;
-		}
-	}
-	if (tmp & CARM_RME) {
-		DPRINTK("RME bit present, waiting\n");
-		rc = carm_init_wait(mmio, CARM_RME, 1);
-		if (rc) {
-			DPRINTK("EXIT, carm_init_wait 2 failed\n");
-			return rc;
-		}
-	}
-
-	tmp &= ~(CARM_RME | CARM_CME);
-	writel(tmp, mmio + CARM_HMUC);
-	readl(mmio + CARM_HMUC);	/* flush */
-
-	rc = carm_init_wait(mmio, CARM_RME | CARM_CME, 0);
-	if (rc) {
-		DPRINTK("EXIT, carm_init_wait 3 failed\n");
-		return rc;
-	}
-
-	carm_init_buckets(mmio);
-
-	writel(host->shm_dma & 0xffffffff, mmio + RBUF_ADDR_LO);
-	writel((host->shm_dma >> 16) >> 16, mmio + RBUF_ADDR_HI);
-	writel(RBUF_LEN, mmio + RBUF_BYTE_SZ);
-
-	tmp = readl(mmio + CARM_HMUC);
-	tmp |= (CARM_RME | CARM_CME | CARM_WZBC);
-	writel(tmp, mmio + CARM_HMUC);
-	readl(mmio + CARM_HMUC);	/* flush */
-
-	rc = carm_init_wait(mmio, CARM_RME | CARM_CME, 1);
-	if (rc) {
-		DPRINTK("EXIT, carm_init_wait 4 failed\n");
-		return rc;
-	}
-
-	writel(0, mmio + CARM_HMPHA);
-	writel(INT_DEF_MASK, mmio + CARM_INT_MASK);
-
-	carm_init_responses(host);
-
-	/* start initialization, probing state machine */
-	spin_lock_irq(&host->lock);
-	assert(host->state == HST_INVALID);
-	host->state = HST_PROBE_START;
-	spin_unlock_irq(&host->lock);
-	schedule_work(&host->fsm_task);
-
-	DPRINTK("EXIT\n");
-	return 0;
-}
-
-static const struct blk_mq_ops carm_mq_ops = {
-	.queue_rq	= carm_queue_rq,
-};
-
-static int carm_init_disk(struct carm_host *host, unsigned int port_no)
-{
-	struct carm_port *port = &host->port[port_no];
-	struct gendisk *disk;
-
-	port->host = host;
-	port->port_no = port_no;
-
-	disk = blk_mq_alloc_disk(&host->tag_set, port);
-	if (IS_ERR(disk))
-		return PTR_ERR(disk);
-
-	port->disk = disk;
-	sprintf(disk->disk_name, DRV_NAME "/%u",
-		(unsigned int)host->id * CARM_MAX_PORTS + port_no);
-	disk->major = host->major;
-	disk->first_minor = port_no * CARM_MINORS_PER_MAJOR;
-	disk->minors = CARM_MINORS_PER_MAJOR;
-	disk->fops = &carm_bd_ops;
-	disk->private_data = port;
-
-	blk_queue_max_segments(disk->queue, CARM_MAX_REQ_SG);
-	blk_queue_segment_boundary(disk->queue, CARM_SG_BOUNDARY);
-	return 0;
-}
-
-static void carm_free_disk(struct carm_host *host, unsigned int port_no)
-{
-	struct carm_port *port = &host->port[port_no];
-	struct gendisk *disk = port->disk;
-
-	if (!disk)
-		return;
-
-	if (host->state > HST_DEV_ACTIVATE)
-		del_gendisk(disk);
-	blk_cleanup_disk(disk);
-}
-
-static int carm_init_shm(struct carm_host *host)
-{
-	host->shm = dma_alloc_coherent(&host->pdev->dev, CARM_SHM_SIZE,
-				       &host->shm_dma, GFP_KERNEL);
-	if (!host->shm)
-		return -ENOMEM;
-
-	host->msg_base = host->shm + RBUF_LEN;
-	host->msg_dma = host->shm_dma + RBUF_LEN;
-
-	memset(host->shm, 0xff, RBUF_LEN);
-	memset(host->msg_base, 0, PDC_SHM_SIZE - RBUF_LEN);
-
-	return 0;
-}
-
-static int carm_init_one (struct pci_dev *pdev, const struct pci_device_id *ent)
-{
-	struct carm_host *host;
-	int rc;
-	struct request_queue *q;
-	unsigned int i;
-
-	printk_once(KERN_DEBUG DRV_NAME " version " DRV_VERSION "\n");
-
-	rc = pci_enable_device(pdev);
-	if (rc)
-		return rc;
-
-	rc = pci_request_regions(pdev, DRV_NAME);
-	if (rc)
-		goto err_out;
-
-	rc = dma_set_mask(&pdev->dev, DMA_BIT_MASK(32));
-	if (rc) {
-		printk(KERN_ERR DRV_NAME "(%s): DMA mask failure\n",
-			pci_name(pdev));
-		goto err_out_regions;
-	}
-
-	host = kzalloc(sizeof(*host), GFP_KERNEL);
-	if (!host) {
-		rc = -ENOMEM;
-		goto err_out_regions;
-	}
-
-	host->pdev = pdev;
-	spin_lock_init(&host->lock);
-	INIT_WORK(&host->fsm_task, carm_fsm_task);
-	init_completion(&host->probe_comp);
-
-	host->mmio = ioremap(pci_resource_start(pdev, 0),
-			     pci_resource_len(pdev, 0));
-	if (!host->mmio) {
-		printk(KERN_ERR DRV_NAME "(%s): MMIO alloc failure\n",
-		       pci_name(pdev));
-		rc = -ENOMEM;
-		goto err_out_kfree;
-	}
-
-	rc = carm_init_shm(host);
-	if (rc) {
-		printk(KERN_ERR DRV_NAME "(%s): DMA SHM alloc failure\n",
-		       pci_name(pdev));
-		goto err_out_iounmap;
-	}
-
-	memset(&host->tag_set, 0, sizeof(host->tag_set));
-	host->tag_set.ops = &carm_mq_ops;
-	host->tag_set.cmd_size = sizeof(struct carm_request);
-	host->tag_set.nr_hw_queues = 1;
-	host->tag_set.nr_maps = 1;
-	host->tag_set.queue_depth = max_queue;
-	host->tag_set.numa_node = NUMA_NO_NODE;
-	host->tag_set.flags = BLK_MQ_F_SHOULD_MERGE;
-
-	rc = blk_mq_alloc_tag_set(&host->tag_set);
-	if (rc)
-		goto err_out_dma_free;
-
-	q = blk_mq_init_queue(&host->tag_set);
-	if (IS_ERR(q)) {
-		rc = PTR_ERR(q);
-		blk_mq_free_tag_set(&host->tag_set);
-		goto err_out_dma_free;
-	}
-
-	host->oob_q = q;
-	q->queuedata = host;
-
-	/*
-	 * Figure out which major to use: 160, 161, or dynamic
-	 */
-	if (!test_and_set_bit(0, &carm_major_alloc))
-		host->major = 160;
-	else if (!test_and_set_bit(1, &carm_major_alloc))
-		host->major = 161;
-	else
-		host->flags |= FL_DYN_MAJOR;
-
-	host->id = carm_host_id;
-	sprintf(host->name, DRV_NAME "%d", carm_host_id);
-
-	rc = register_blkdev(host->major, host->name);
-	if (rc < 0)
-		goto err_out_free_majors;
-	if (host->flags & FL_DYN_MAJOR)
-		host->major = rc;
-
-	for (i = 0; i < CARM_MAX_PORTS; i++) {
-		rc = carm_init_disk(host, i);
-		if (rc)
-			goto err_out_blkdev_disks;
-	}
-
-	pci_set_master(pdev);
-
-	rc = request_irq(pdev->irq, carm_interrupt, IRQF_SHARED, DRV_NAME, host);
-	if (rc) {
-		printk(KERN_ERR DRV_NAME "(%s): irq alloc failure\n",
-		       pci_name(pdev));
-		goto err_out_blkdev_disks;
-	}
-
-	rc = carm_init_host(host);
-	if (rc)
-		goto err_out_free_irq;
-
-	DPRINTK("waiting for probe_comp\n");
-	wait_for_completion(&host->probe_comp);
-
-	printk(KERN_INFO "%s: pci %s, ports %d, io %llx, irq %u, major %d\n",
-	       host->name, pci_name(pdev), (int) CARM_MAX_PORTS,
-	       (unsigned long long)pci_resource_start(pdev, 0),
-		   pdev->irq, host->major);
-
-	carm_host_id++;
-	pci_set_drvdata(pdev, host);
-	return 0;
-
-err_out_free_irq:
-	free_irq(pdev->irq, host);
-err_out_blkdev_disks:
-	for (i = 0; i < CARM_MAX_PORTS; i++)
-		carm_free_disk(host, i);
-	unregister_blkdev(host->major, host->name);
-err_out_free_majors:
-	if (host->major == 160)
-		clear_bit(0, &carm_major_alloc);
-	else if (host->major == 161)
-		clear_bit(1, &carm_major_alloc);
-	blk_cleanup_queue(host->oob_q);
-	blk_mq_free_tag_set(&host->tag_set);
-err_out_dma_free:
-	dma_free_coherent(&pdev->dev, CARM_SHM_SIZE, host->shm, host->shm_dma);
-err_out_iounmap:
-	iounmap(host->mmio);
-err_out_kfree:
-	kfree(host);
-err_out_regions:
-	pci_release_regions(pdev);
-err_out:
-	pci_disable_device(pdev);
-	return rc;
-}
-
-static void carm_remove_one (struct pci_dev *pdev)
-{
-	struct carm_host *host = pci_get_drvdata(pdev);
-	unsigned int i;
-
-	if (!host) {
-		printk(KERN_ERR PFX "BUG: no host data for PCI(%s)\n",
-		       pci_name(pdev));
-		return;
-	}
-
-	free_irq(pdev->irq, host);
-	for (i = 0; i < CARM_MAX_PORTS; i++)
-		carm_free_disk(host, i);
-	unregister_blkdev(host->major, host->name);
-	if (host->major == 160)
-		clear_bit(0, &carm_major_alloc);
-	else if (host->major == 161)
-		clear_bit(1, &carm_major_alloc);
-	blk_cleanup_queue(host->oob_q);
-	blk_mq_free_tag_set(&host->tag_set);
-	dma_free_coherent(&pdev->dev, CARM_SHM_SIZE, host->shm, host->shm_dma);
-	iounmap(host->mmio);
-	kfree(host);
-	pci_release_regions(pdev);
-	pci_disable_device(pdev);
-}
-
-module_pci_driver(carm_driver);
diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
index 8041155f3021..56b4b7248483 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -78,7 +78,8 @@ enum qca_flags {
 	QCA_HW_ERROR_EVENT,
 	QCA_SSR_TRIGGERED,
 	QCA_BT_OFF,
-	QCA_ROM_FW
+	QCA_ROM_FW,
+	QCA_DEBUGFS_CREATED,
 };
 
 enum qca_capabilities {
@@ -635,6 +636,9 @@ static void qca_debugfs_init(struct hci_dev *hdev)
 	if (!hdev->debugfs)
 		return;
 
+	if (test_and_set_bit(QCA_DEBUGFS_CREATED, &qca->flags))
+		return;
+
 	ibs_dir = debugfs_create_dir("ibs", hdev->debugfs);
 
 	/* read only */
diff --git a/drivers/firmware/arm_ffa/driver.c b/drivers/firmware/arm_ffa/driver.c
index f53d11eff65e..e4fb0c1ae486 100644
--- a/drivers/firmware/arm_ffa/driver.c
+++ b/drivers/firmware/arm_ffa/driver.c
@@ -454,6 +454,7 @@ ffa_setup_and_transmit(u32 func_id, void *buffer, u32 max_fragsize,
 		ep_mem_access->flag = 0;
 		ep_mem_access->reserved = 0;
 	}
+	mem_region->handle = 0;
 	mem_region->reserved_0 = 0;
 	mem_region->reserved_1 = 0;
 	mem_region->ep_count = args->nattrs;
diff --git a/drivers/gpu/drm/amd/amdgpu/vi.c b/drivers/gpu/drm/amd/amdgpu/vi.c
index bb414e7cf024..b9555ba6d32f 100644
--- a/drivers/gpu/drm/amd/amdgpu/vi.c
+++ b/drivers/gpu/drm/amd/amdgpu/vi.c
@@ -542,8 +542,15 @@ static u32 vi_get_xclk(struct amdgpu_device *adev)
 	u32 reference_clock = adev->clock.spll.reference_freq;
 	u32 tmp;
 
-	if (adev->flags & AMD_IS_APU)
-		return reference_clock;
+	if (adev->flags & AMD_IS_APU) {
+		switch (adev->asic_type) {
+		case CHIP_STONEY:
+			/* vbios says 48Mhz, but the actual freq is 100Mhz */
+			return 10000;
+		default:
+			return reference_clock;
+		}
+	}
 
 	tmp = RREG32_SMC(ixCG_CLKPIN_CNTL_2);
 	if (REG_GET_FIELD(tmp, CG_CLKPIN_CNTL_2, MUX_TCLK_TO_XCLK))
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
index dbcabaedb00d..d4fde146bd4c 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
@@ -1928,33 +1928,94 @@ static int sienna_cichlid_get_power_limit(struct smu_context *smu,
 	return 0;
 }
 
+static void sienna_cichlid_get_override_pcie_settings(struct smu_context *smu,
+						      uint32_t *gen_speed_override,
+						      uint32_t *lane_width_override)
+{
+	struct amdgpu_device *adev = smu->adev;
+
+	*gen_speed_override = 0xff;
+	*lane_width_override = 0xff;
+
+	switch (adev->pdev->device) {
+	case 0x73A0:
+	case 0x73A1:
+	case 0x73A2:
+	case 0x73A3:
+	case 0x73AB:
+	case 0x73AE:
+		/* Bit 7:0: PCIE lane width, 1 to 7 corresponds is x1 to x32 */
+		*lane_width_override = 6;
+		break;
+	case 0x73E0:
+	case 0x73E1:
+	case 0x73E3:
+		*lane_width_override = 4;
+		break;
+	case 0x7420:
+	case 0x7421:
+	case 0x7422:
+	case 0x7423:
+	case 0x7424:
+		*lane_width_override = 3;
+		break;
+	default:
+		break;
+	}
+}
+
+#define MAX(a, b)	((a) > (b) ? (a) : (b))
+
 static int sienna_cichlid_update_pcie_parameters(struct smu_context *smu,
 					 uint32_t pcie_gen_cap,
 					 uint32_t pcie_width_cap)
 {
 	struct smu_11_0_dpm_context *dpm_context = smu->smu_dpm.dpm_context;
-
-	uint32_t smu_pcie_arg;
+	struct smu_11_0_pcie_table *pcie_table = &dpm_context->dpm_tables.pcie_table;
+	uint32_t gen_speed_override, lane_width_override;
 	uint8_t *table_member1, *table_member2;
+	uint32_t min_gen_speed, max_gen_speed;
+	uint32_t min_lane_width, max_lane_width;
+	uint32_t smu_pcie_arg;
 	int ret, i;
 
 	GET_PPTABLE_MEMBER(PcieGenSpeed, &table_member1);
 	GET_PPTABLE_MEMBER(PcieLaneCount, &table_member2);
 
-	/* lclk dpm table setup */
-	for (i = 0; i < MAX_PCIE_CONF; i++) {
-		dpm_context->dpm_tables.pcie_table.pcie_gen[i] = table_member1[i];
-		dpm_context->dpm_tables.pcie_table.pcie_lane[i] = table_member2[i];
+	sienna_cichlid_get_override_pcie_settings(smu,
+						  &gen_speed_override,
+						  &lane_width_override);
+
+	/* PCIE gen speed override */
+	if (gen_speed_override != 0xff) {
+		min_gen_speed = MIN(pcie_gen_cap, gen_speed_override);
+		max_gen_speed = MIN(pcie_gen_cap, gen_speed_override);
+	} else {
+		min_gen_speed = MAX(0, table_member1[0]);
+		max_gen_speed = MIN(pcie_gen_cap, table_member1[1]);
+		min_gen_speed = min_gen_speed > max_gen_speed ?
+				max_gen_speed : min_gen_speed;
+	}
+	pcie_table->pcie_gen[0] = min_gen_speed;
+	pcie_table->pcie_gen[1] = max_gen_speed;
+
+	/* PCIE lane width override */
+	if (lane_width_override != 0xff) {
+		min_lane_width = MIN(pcie_width_cap, lane_width_override);
+		max_lane_width = MIN(pcie_width_cap, lane_width_override);
+	} else {
+		min_lane_width = MAX(1, table_member2[0]);
+		max_lane_width = MIN(pcie_width_cap, table_member2[1]);
+		min_lane_width = min_lane_width > max_lane_width ?
+				 max_lane_width : min_lane_width;
 	}
+	pcie_table->pcie_lane[0] = min_lane_width;
+	pcie_table->pcie_lane[1] = max_lane_width;
 
 	for (i = 0; i < NUM_LINK_LEVELS; i++) {
-		smu_pcie_arg = (i << 16) |
-			((table_member1[i] <= pcie_gen_cap) ?
-			 (table_member1[i] << 8) :
-			 (pcie_gen_cap << 8)) |
-			((table_member2[i] <= pcie_width_cap) ?
-			 table_member2[i] :
-			 pcie_width_cap);
+		smu_pcie_arg = (i << 16 |
+				pcie_table->pcie_gen[i] << 8 |
+				pcie_table->pcie_lane[i]);
 
 		ret = smu_cmn_send_smc_msg_with_param(smu,
 				SMU_MSG_OverridePcieParameters,
@@ -1962,11 +2023,6 @@ static int sienna_cichlid_update_pcie_parameters(struct smu_context *smu,
 				NULL);
 		if (ret)
 			return ret;
-
-		if (table_member1[i] > pcie_gen_cap)
-			dpm_context->dpm_tables.pcie_table.pcie_gen[i] = pcie_gen_cap;
-		if (table_member2[i] > pcie_width_cap)
-			dpm_context->dpm_tables.pcie_table.pcie_lane[i] = pcie_width_cap;
 	}
 
 	return 0;
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
index 6211570fb64f..a3723ba35923 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
@@ -456,11 +456,11 @@ int smu_v13_0_init_power(struct smu_context *smu)
 	if (smu_power->power_context || smu_power->power_context_size != 0)
 		return -EINVAL;
 
-	smu_power->power_context = kzalloc(sizeof(struct smu_13_0_dpm_context),
+	smu_power->power_context = kzalloc(sizeof(struct smu_13_0_power_context),
 					   GFP_KERNEL);
 	if (!smu_power->power_context)
 		return -ENOMEM;
-	smu_power->power_context_size = sizeof(struct smu_13_0_dpm_context);
+	smu_power->power_context_size = sizeof(struct smu_13_0_power_context);
 
 	return 0;
 }
diff --git a/drivers/gpu/drm/i915/display/intel_dp_aux.c b/drivers/gpu/drm/i915/display/intel_dp_aux.c
index fd7527a3087f..d507a20822db 100644
--- a/drivers/gpu/drm/i915/display/intel_dp_aux.c
+++ b/drivers/gpu/drm/i915/display/intel_dp_aux.c
@@ -119,6 +119,32 @@ static u32 skl_get_aux_clock_divider(struct intel_dp *intel_dp, int index)
 	return index ? 0 : 1;
 }
 
+static int intel_dp_aux_sync_len(void)
+{
+	int precharge = 16; /* 10-16 */
+	int preamble = 16;
+
+	return precharge + preamble;
+}
+
+static int intel_dp_aux_fw_sync_len(void)
+{
+	int precharge = 10; /* 10-16 */
+	int preamble = 8;
+
+	return precharge + preamble;
+}
+
+static int g4x_dp_aux_precharge_len(void)
+{
+	int precharge_min = 10;
+	int preamble = 16;
+
+	/* HW wants the length of the extra precharge in 2us units */
+	return (intel_dp_aux_sync_len() -
+		precharge_min - preamble) / 2;
+}
+
 static u32 g4x_get_aux_send_ctl(struct intel_dp *intel_dp,
 				int send_bytes,
 				u32 aux_clock_divider)
@@ -141,7 +167,7 @@ static u32 g4x_get_aux_send_ctl(struct intel_dp *intel_dp,
 	       timeout |
 	       DP_AUX_CH_CTL_RECEIVE_ERROR |
 	       (send_bytes << DP_AUX_CH_CTL_MESSAGE_SIZE_SHIFT) |
-	       (3 << DP_AUX_CH_CTL_PRECHARGE_2US_SHIFT) |
+	       (g4x_dp_aux_precharge_len() << DP_AUX_CH_CTL_PRECHARGE_2US_SHIFT) |
 	       (aux_clock_divider << DP_AUX_CH_CTL_BIT_CLOCK_2X_SHIFT);
 }
 
@@ -167,8 +193,8 @@ static u32 skl_get_aux_send_ctl(struct intel_dp *intel_dp,
 	      DP_AUX_CH_CTL_TIME_OUT_MAX |
 	      DP_AUX_CH_CTL_RECEIVE_ERROR |
 	      (send_bytes << DP_AUX_CH_CTL_MESSAGE_SIZE_SHIFT) |
-	      DP_AUX_CH_CTL_FW_SYNC_PULSE_SKL(24) |
-	      DP_AUX_CH_CTL_SYNC_PULSE_SKL(32);
+	      DP_AUX_CH_CTL_FW_SYNC_PULSE_SKL(intel_dp_aux_fw_sync_len()) |
+	      DP_AUX_CH_CTL_SYNC_PULSE_SKL(intel_dp_aux_sync_len());
 
 	if (intel_phy_is_tc(i915, phy) &&
 	    dig_port->tc_mode == TC_PORT_TBT_ALT)
diff --git a/drivers/gpu/drm/i915/gem/selftests/i915_gem_context.c b/drivers/gpu/drm/i915/gem/selftests/i915_gem_context.c
index 8eb5050f8cb3..907e02d4085c 100644
--- a/drivers/gpu/drm/i915/gem/selftests/i915_gem_context.c
+++ b/drivers/gpu/drm/i915/gem/selftests/i915_gem_context.c
@@ -182,97 +182,108 @@ static int live_nop_switch(void *arg)
 }
 
 struct parallel_switch {
-	struct task_struct *tsk;
+	struct kthread_worker *worker;
+	struct kthread_work work;
 	struct intel_context *ce[2];
+	int result;
 };
 
-static int __live_parallel_switch1(void *data)
+static void __live_parallel_switch1(struct kthread_work *work)
 {
-	struct parallel_switch *arg = data;
+	struct parallel_switch *arg =
+		container_of(work, typeof(*arg), work);
 	IGT_TIMEOUT(end_time);
 	unsigned long count;
 
 	count = 0;
+	arg->result = 0;
 	do {
 		struct i915_request *rq = NULL;
-		int err, n;
+		int n;
 
-		err = 0;
-		for (n = 0; !err && n < ARRAY_SIZE(arg->ce); n++) {
+		for (n = 0; !arg->result && n < ARRAY_SIZE(arg->ce); n++) {
 			struct i915_request *prev = rq;
 
 			rq = i915_request_create(arg->ce[n]);
 			if (IS_ERR(rq)) {
 				i915_request_put(prev);
-				return PTR_ERR(rq);
+				arg->result = PTR_ERR(rq);
+				break;
 			}
 
 			i915_request_get(rq);
 			if (prev) {
-				err = i915_request_await_dma_fence(rq, &prev->fence);
+				arg->result =
+					i915_request_await_dma_fence(rq,
+								     &prev->fence);
 				i915_request_put(prev);
 			}
 
 			i915_request_add(rq);
 		}
-		if (i915_request_wait(rq, 0, HZ / 5) < 0)
-			err = -ETIME;
+
+		if (IS_ERR_OR_NULL(rq))
+			break;
+
+		if (i915_request_wait(rq, 0, HZ) < 0)
+			arg->result = -ETIME;
+
 		i915_request_put(rq);
-		if (err)
-			return err;
 
 		count++;
-	} while (!__igt_timeout(end_time, NULL));
+	} while (!arg->result && !__igt_timeout(end_time, NULL));
 
-	pr_info("%s: %lu switches (sync)\n", arg->ce[0]->engine->name, count);
-	return 0;
+	pr_info("%s: %lu switches (sync) <%d>\n",
+		arg->ce[0]->engine->name, count, arg->result);
 }
 
-static int __live_parallel_switchN(void *data)
+static void __live_parallel_switchN(struct kthread_work *work)
 {
-	struct parallel_switch *arg = data;
+	struct parallel_switch *arg =
+		container_of(work, typeof(*arg), work);
 	struct i915_request *rq = NULL;
 	IGT_TIMEOUT(end_time);
 	unsigned long count;
 	int n;
 
 	count = 0;
+	arg->result = 0;
 	do {
-		for (n = 0; n < ARRAY_SIZE(arg->ce); n++) {
+		for (n = 0; !arg->result && n < ARRAY_SIZE(arg->ce); n++) {
 			struct i915_request *prev = rq;
-			int err = 0;
 
 			rq = i915_request_create(arg->ce[n]);
 			if (IS_ERR(rq)) {
 				i915_request_put(prev);
-				return PTR_ERR(rq);
+				arg->result = PTR_ERR(rq);
+				break;
 			}
 
 			i915_request_get(rq);
 			if (prev) {
-				err = i915_request_await_dma_fence(rq, &prev->fence);
+				arg->result =
+					i915_request_await_dma_fence(rq,
+								     &prev->fence);
 				i915_request_put(prev);
 			}
 
 			i915_request_add(rq);
-			if (err) {
-				i915_request_put(rq);
-				return err;
-			}
 		}
 
 		count++;
-	} while (!__igt_timeout(end_time, NULL));
-	i915_request_put(rq);
+	} while (!arg->result && !__igt_timeout(end_time, NULL));
 
-	pr_info("%s: %lu switches (many)\n", arg->ce[0]->engine->name, count);
-	return 0;
+	if (!IS_ERR_OR_NULL(rq))
+		i915_request_put(rq);
+
+	pr_info("%s: %lu switches (many) <%d>\n",
+		arg->ce[0]->engine->name, count, arg->result);
 }
 
 static int live_parallel_switch(void *arg)
 {
 	struct drm_i915_private *i915 = arg;
-	static int (* const func[])(void *arg) = {
+	static void (* const func[])(struct kthread_work *) = {
 		__live_parallel_switch1,
 		__live_parallel_switchN,
 		NULL,
@@ -280,7 +291,7 @@ static int live_parallel_switch(void *arg)
 	struct parallel_switch *data = NULL;
 	struct i915_gem_engines *engines;
 	struct i915_gem_engines_iter it;
-	int (* const *fn)(void *arg);
+	void (* const *fn)(struct kthread_work *);
 	struct i915_gem_context *ctx;
 	struct intel_context *ce;
 	struct file *file;
@@ -338,8 +349,10 @@ static int live_parallel_switch(void *arg)
 				continue;
 
 			ce = intel_context_create(data[m].ce[0]->engine);
-			if (IS_ERR(ce))
+			if (IS_ERR(ce)) {
+				err = PTR_ERR(ce);
 				goto out;
+			}
 
 			err = intel_context_pin(ce);
 			if (err) {
@@ -351,9 +364,24 @@ static int live_parallel_switch(void *arg)
 		}
 	}
 
+	for (n = 0; n < count; n++) {
+		struct kthread_worker *worker;
+
+		if (!data[n].ce[0])
+			continue;
+
+		worker = kthread_create_worker(0, "igt/parallel:%s",
+					       data[n].ce[0]->engine->name);
+		if (IS_ERR(worker)) {
+			err = PTR_ERR(worker);
+			goto out;
+		}
+
+		data[n].worker = worker;
+	}
+
 	for (fn = func; !err && *fn; fn++) {
 		struct igt_live_test t;
-		int n;
 
 		err = igt_live_test_begin(&t, i915, __func__, "");
 		if (err)
@@ -363,34 +391,23 @@ static int live_parallel_switch(void *arg)
 			if (!data[n].ce[0])
 				continue;
 
-			data[n].tsk = kthread_run(*fn, &data[n],
-						  "igt/parallel:%s",
-						  data[n].ce[0]->engine->name);
-			if (IS_ERR(data[n].tsk)) {
-				err = PTR_ERR(data[n].tsk);
-				break;
-			}
-			get_task_struct(data[n].tsk);
+			data[n].result = 0;
+			kthread_init_work(&data[n].work, *fn);
+			kthread_queue_work(data[n].worker, &data[n].work);
 		}
 
-		yield(); /* start all threads before we kthread_stop() */
-
 		for (n = 0; n < count; n++) {
-			int status;
-
-			if (IS_ERR_OR_NULL(data[n].tsk))
-				continue;
-
-			status = kthread_stop(data[n].tsk);
-			if (status && !err)
-				err = status;
-
-			put_task_struct(data[n].tsk);
-			data[n].tsk = NULL;
+			if (data[n].ce[0]) {
+				kthread_flush_work(&data[n].work);
+				if (data[n].result && !err)
+					err = data[n].result;
+			}
 		}
 
-		if (igt_live_test_end(&t))
-			err = -EIO;
+		if (igt_live_test_end(&t)) {
+			err = err ?: -EIO;
+			break;
+		}
 	}
 
 out:
@@ -402,6 +419,9 @@ static int live_parallel_switch(void *arg)
 			intel_context_unpin(data[n].ce[m]);
 			intel_context_put(data[n].ce[m]);
 		}
+
+		if (data[n].worker)
+			kthread_destroy_worker(data[n].worker);
 	}
 	kfree(data);
 out_file:
diff --git a/drivers/gpu/drm/i915/gt/selftest_execlists.c b/drivers/gpu/drm/i915/gt/selftest_execlists.c
index f12ffe797639..5d541bbcfeff 100644
--- a/drivers/gpu/drm/i915/gt/selftest_execlists.c
+++ b/drivers/gpu/drm/i915/gt/selftest_execlists.c
@@ -1531,8 +1531,8 @@ static int live_busywait_preempt(void *arg)
 	struct drm_i915_gem_object *obj;
 	struct i915_vma *vma;
 	enum intel_engine_id id;
-	int err = -ENOMEM;
 	u32 *map;
+	int err;
 
 	/*
 	 * Verify that even without HAS_LOGICAL_RING_PREEMPTION, we can
@@ -1540,13 +1540,17 @@ static int live_busywait_preempt(void *arg)
 	 */
 
 	ctx_hi = kernel_context(gt->i915, NULL);
-	if (!ctx_hi)
-		return -ENOMEM;
+	if (IS_ERR(ctx_hi))
+		return PTR_ERR(ctx_hi);
+
 	ctx_hi->sched.priority = I915_CONTEXT_MAX_USER_PRIORITY;
 
 	ctx_lo = kernel_context(gt->i915, NULL);
-	if (!ctx_lo)
+	if (IS_ERR(ctx_lo)) {
+		err = PTR_ERR(ctx_lo);
 		goto err_ctx_hi;
+	}
+
 	ctx_lo->sched.priority = I915_CONTEXT_MIN_USER_PRIORITY;
 
 	obj = i915_gem_object_create_internal(gt->i915, PAGE_SIZE);
@@ -3468,12 +3472,14 @@ static int random_priority(struct rnd_state *rnd)
 
 struct preempt_smoke {
 	struct intel_gt *gt;
+	struct kthread_work work;
 	struct i915_gem_context **contexts;
 	struct intel_engine_cs *engine;
 	struct drm_i915_gem_object *batch;
 	unsigned int ncontext;
 	struct rnd_state prng;
 	unsigned long count;
+	int result;
 };
 
 static struct i915_gem_context *smoke_context(struct preempt_smoke *smoke)
@@ -3533,34 +3539,31 @@ static int smoke_submit(struct preempt_smoke *smoke,
 	return err;
 }
 
-static int smoke_crescendo_thread(void *arg)
+static void smoke_crescendo_work(struct kthread_work *work)
 {
-	struct preempt_smoke *smoke = arg;
+	struct preempt_smoke *smoke = container_of(work, typeof(*smoke), work);
 	IGT_TIMEOUT(end_time);
 	unsigned long count;
 
 	count = 0;
 	do {
 		struct i915_gem_context *ctx = smoke_context(smoke);
-		int err;
 
-		err = smoke_submit(smoke,
-				   ctx, count % I915_PRIORITY_MAX,
-				   smoke->batch);
-		if (err)
-			return err;
+		smoke->result = smoke_submit(smoke, ctx,
+					     count % I915_PRIORITY_MAX,
+					     smoke->batch);
 
 		count++;
-	} while (count < smoke->ncontext && !__igt_timeout(end_time, NULL));
+	} while (!smoke->result && count < smoke->ncontext &&
+		 !__igt_timeout(end_time, NULL));
 
 	smoke->count = count;
-	return 0;
 }
 
 static int smoke_crescendo(struct preempt_smoke *smoke, unsigned int flags)
 #define BATCH BIT(0)
 {
-	struct task_struct *tsk[I915_NUM_ENGINES] = {};
+	struct kthread_worker *worker[I915_NUM_ENGINES] = {};
 	struct preempt_smoke *arg;
 	struct intel_engine_cs *engine;
 	enum intel_engine_id id;
@@ -3571,6 +3574,8 @@ static int smoke_crescendo(struct preempt_smoke *smoke, unsigned int flags)
 	if (!arg)
 		return -ENOMEM;
 
+	memset(arg, 0, I915_NUM_ENGINES * sizeof(*arg));
+
 	for_each_engine(engine, smoke->gt, id) {
 		arg[id] = *smoke;
 		arg[id].engine = engine;
@@ -3578,31 +3583,28 @@ static int smoke_crescendo(struct preempt_smoke *smoke, unsigned int flags)
 			arg[id].batch = NULL;
 		arg[id].count = 0;
 
-		tsk[id] = kthread_run(smoke_crescendo_thread, arg,
-				      "igt/smoke:%d", id);
-		if (IS_ERR(tsk[id])) {
-			err = PTR_ERR(tsk[id]);
+		worker[id] = kthread_create_worker(0, "igt/smoke:%d", id);
+		if (IS_ERR(worker[id])) {
+			err = PTR_ERR(worker[id]);
 			break;
 		}
-		get_task_struct(tsk[id]);
-	}
 
-	yield(); /* start all threads before we kthread_stop() */
+		kthread_init_work(&arg[id].work, smoke_crescendo_work);
+		kthread_queue_work(worker[id], &arg[id].work);
+	}
 
 	count = 0;
 	for_each_engine(engine, smoke->gt, id) {
-		int status;
-
-		if (IS_ERR_OR_NULL(tsk[id]))
+		if (IS_ERR_OR_NULL(worker[id]))
 			continue;
 
-		status = kthread_stop(tsk[id]);
-		if (status && !err)
-			err = status;
+		kthread_flush_work(&arg[id].work);
+		if (arg[id].result && !err)
+			err = arg[id].result;
 
 		count += arg[id].count;
 
-		put_task_struct(tsk[id]);
+		kthread_destroy_worker(worker[id]);
 	}
 
 	pr_info("Submitted %lu crescendo:%x requests across %d engines and %d contexts\n",
diff --git a/drivers/gpu/drm/i915/gt/selftest_hangcheck.c b/drivers/gpu/drm/i915/gt/selftest_hangcheck.c
index 2c1ed32ca5ac..f164912cea30 100644
--- a/drivers/gpu/drm/i915/gt/selftest_hangcheck.c
+++ b/drivers/gpu/drm/i915/gt/selftest_hangcheck.c
@@ -861,10 +861,13 @@ static int igt_reset_active_engine(void *arg)
 }
 
 struct active_engine {
-	struct task_struct *task;
+	struct kthread_worker *worker;
+	struct kthread_work work;
 	struct intel_engine_cs *engine;
 	unsigned long resets;
 	unsigned int flags;
+	bool stop;
+	int result;
 };
 
 #define TEST_ACTIVE	BIT(0)
@@ -895,10 +898,10 @@ static int active_request_put(struct i915_request *rq)
 	return err;
 }
 
-static int active_engine(void *data)
+static void active_engine(struct kthread_work *work)
 {
 	I915_RND_STATE(prng);
-	struct active_engine *arg = data;
+	struct active_engine *arg = container_of(work, typeof(*arg), work);
 	struct intel_engine_cs *engine = arg->engine;
 	struct i915_request *rq[8] = {};
 	struct intel_context *ce[ARRAY_SIZE(rq)];
@@ -908,16 +911,17 @@ static int active_engine(void *data)
 	for (count = 0; count < ARRAY_SIZE(ce); count++) {
 		ce[count] = intel_context_create(engine);
 		if (IS_ERR(ce[count])) {
-			err = PTR_ERR(ce[count]);
-			pr_err("[%s] Create context #%ld failed: %d!\n", engine->name, count, err);
+			arg->result = PTR_ERR(ce[count]);
+			pr_err("[%s] Create context #%ld failed: %d!\n",
+			       engine->name, count, arg->result);
 			while (--count)
 				intel_context_put(ce[count]);
-			return err;
+			return;
 		}
 	}
 
 	count = 0;
-	while (!kthread_should_stop()) {
+	while (!READ_ONCE(arg->stop)) {
 		unsigned int idx = count++ & (ARRAY_SIZE(rq) - 1);
 		struct i915_request *old = rq[idx];
 		struct i915_request *new;
@@ -962,7 +966,7 @@ static int active_engine(void *data)
 		intel_context_put(ce[count]);
 	}
 
-	return err;
+	arg->result = err;
 }
 
 static int __igt_reset_engines(struct intel_gt *gt,
@@ -1013,7 +1017,7 @@ static int __igt_reset_engines(struct intel_gt *gt,
 
 		memset(threads, 0, sizeof(threads));
 		for_each_engine(other, gt, tmp) {
-			struct task_struct *tsk;
+			struct kthread_worker *worker;
 
 			threads[tmp].resets =
 				i915_reset_engine_count(global, other);
@@ -1027,19 +1031,21 @@ static int __igt_reset_engines(struct intel_gt *gt,
 			threads[tmp].engine = other;
 			threads[tmp].flags = flags;
 
-			tsk = kthread_run(active_engine, &threads[tmp],
-					  "igt/%s", other->name);
-			if (IS_ERR(tsk)) {
-				err = PTR_ERR(tsk);
-				pr_err("[%s] Thread spawn failed: %d!\n", engine->name, err);
+			worker = kthread_create_worker(0, "igt/%s",
+						       other->name);
+			if (IS_ERR(worker)) {
+				err = PTR_ERR(worker);
+				pr_err("[%s] Worker create failed: %d!\n",
+				       engine->name, err);
 				goto unwind;
 			}
 
-			threads[tmp].task = tsk;
-			get_task_struct(tsk);
-		}
+			threads[tmp].worker = worker;
 
-		yield(); /* start all threads before we begin */
+			kthread_init_work(&threads[tmp].work, active_engine);
+			kthread_queue_work(threads[tmp].worker,
+					   &threads[tmp].work);
+		}
 
 		st_engine_heartbeat_disable_no_pm(engine);
 		set_bit(I915_RESET_ENGINE + id, &gt->reset.flags);
@@ -1187,17 +1193,20 @@ static int __igt_reset_engines(struct intel_gt *gt,
 		for_each_engine(other, gt, tmp) {
 			int ret;
 
-			if (!threads[tmp].task)
+			if (!threads[tmp].worker)
 				continue;
 
-			ret = kthread_stop(threads[tmp].task);
+			WRITE_ONCE(threads[tmp].stop, true);
+			kthread_flush_work(&threads[tmp].work);
+			ret = READ_ONCE(threads[tmp].result);
 			if (ret) {
 				pr_err("kthread for other engine %s failed, err=%d\n",
 				       other->name, ret);
 				if (!err)
 					err = ret;
 			}
-			put_task_struct(threads[tmp].task);
+
+			kthread_destroy_worker(threads[tmp].worker);
 
 			/* GuC based resets are not logged per engine */
 			if (!using_guc) {
diff --git a/drivers/gpu/drm/i915/selftests/i915_request.c b/drivers/gpu/drm/i915/selftests/i915_request.c
index d67710d10615..0e1a64b179a5 100644
--- a/drivers/gpu/drm/i915/selftests/i915_request.c
+++ b/drivers/gpu/drm/i915/selftests/i915_request.c
@@ -288,9 +288,18 @@ __live_request_alloc(struct intel_context *ce)
 	return intel_context_create_request(ce);
 }
 
-static int __igt_breadcrumbs_smoketest(void *arg)
+struct smoke_thread {
+	struct kthread_worker *worker;
+	struct kthread_work work;
+	struct smoketest *t;
+	bool stop;
+	int result;
+};
+
+static void __igt_breadcrumbs_smoketest(struct kthread_work *work)
 {
-	struct smoketest *t = arg;
+	struct smoke_thread *thread = container_of(work, typeof(*thread), work);
+	struct smoketest *t = thread->t;
 	const unsigned int max_batch = min(t->ncontexts, t->max_batch) - 1;
 	const unsigned int total = 4 * t->ncontexts + 1;
 	unsigned int num_waits = 0, num_fences = 0;
@@ -309,8 +318,10 @@ static int __igt_breadcrumbs_smoketest(void *arg)
 	 */
 
 	requests = kcalloc(total, sizeof(*requests), GFP_KERNEL);
-	if (!requests)
-		return -ENOMEM;
+	if (!requests) {
+		thread->result = -ENOMEM;
+		return;
+	}
 
 	order = i915_random_order(total, &prng);
 	if (!order) {
@@ -318,7 +329,7 @@ static int __igt_breadcrumbs_smoketest(void *arg)
 		goto out_requests;
 	}
 
-	while (!kthread_should_stop()) {
+	while (!READ_ONCE(thread->stop)) {
 		struct i915_sw_fence *submit, *wait;
 		unsigned int n, count;
 
@@ -426,7 +437,7 @@ static int __igt_breadcrumbs_smoketest(void *arg)
 	kfree(order);
 out_requests:
 	kfree(requests);
-	return err;
+	thread->result = err;
 }
 
 static int mock_breadcrumbs_smoketest(void *arg)
@@ -439,7 +450,7 @@ static int mock_breadcrumbs_smoketest(void *arg)
 		.request_alloc = __mock_request_alloc
 	};
 	unsigned int ncpus = num_online_cpus();
-	struct task_struct **threads;
+	struct smoke_thread *threads;
 	unsigned int n;
 	int ret = 0;
 
@@ -468,28 +479,37 @@ static int mock_breadcrumbs_smoketest(void *arg)
 	}
 
 	for (n = 0; n < ncpus; n++) {
-		threads[n] = kthread_run(__igt_breadcrumbs_smoketest,
-					 &t, "igt/%d", n);
-		if (IS_ERR(threads[n])) {
-			ret = PTR_ERR(threads[n]);
+		struct kthread_worker *worker;
+
+		worker = kthread_create_worker(0, "igt/%d", n);
+		if (IS_ERR(worker)) {
+			ret = PTR_ERR(worker);
 			ncpus = n;
 			break;
 		}
 
-		get_task_struct(threads[n]);
+		threads[n].worker = worker;
+		threads[n].t = &t;
+		threads[n].stop = false;
+		threads[n].result = 0;
+
+		kthread_init_work(&threads[n].work,
+				  __igt_breadcrumbs_smoketest);
+		kthread_queue_work(worker, &threads[n].work);
 	}
 
-	yield(); /* start all threads before we begin */
 	msleep(jiffies_to_msecs(i915_selftest.timeout_jiffies));
 
 	for (n = 0; n < ncpus; n++) {
 		int err;
 
-		err = kthread_stop(threads[n]);
+		WRITE_ONCE(threads[n].stop, true);
+		kthread_flush_work(&threads[n].work);
+		err = READ_ONCE(threads[n].result);
 		if (err < 0 && !ret)
 			ret = err;
 
-		put_task_struct(threads[n]);
+		kthread_destroy_worker(threads[n].worker);
 	}
 	pr_info("Completed %lu waits for %lu fence across %d cpus\n",
 		atomic_long_read(&t.num_waits),
@@ -1291,9 +1311,18 @@ static int live_sequential_engines(void *arg)
 	return err;
 }
 
-static int __live_parallel_engine1(void *arg)
+struct parallel_thread {
+	struct kthread_worker *worker;
+	struct kthread_work work;
+	struct intel_engine_cs *engine;
+	int result;
+};
+
+static void __live_parallel_engine1(struct kthread_work *work)
 {
-	struct intel_engine_cs *engine = arg;
+	struct parallel_thread *thread =
+		container_of(work, typeof(*thread), work);
+	struct intel_engine_cs *engine = thread->engine;
 	IGT_TIMEOUT(end_time);
 	unsigned long count;
 	int err = 0;
@@ -1324,12 +1353,14 @@ static int __live_parallel_engine1(void *arg)
 	intel_engine_pm_put(engine);
 
 	pr_info("%s: %lu request + sync\n", engine->name, count);
-	return err;
+	thread->result = err;
 }
 
-static int __live_parallel_engineN(void *arg)
+static void __live_parallel_engineN(struct kthread_work *work)
 {
-	struct intel_engine_cs *engine = arg;
+	struct parallel_thread *thread =
+		container_of(work, typeof(*thread), work);
+	struct intel_engine_cs *engine = thread->engine;
 	IGT_TIMEOUT(end_time);
 	unsigned long count;
 	int err = 0;
@@ -1351,7 +1382,7 @@ static int __live_parallel_engineN(void *arg)
 	intel_engine_pm_put(engine);
 
 	pr_info("%s: %lu requests\n", engine->name, count);
-	return err;
+	thread->result = err;
 }
 
 static bool wake_all(struct drm_i915_private *i915)
@@ -1377,9 +1408,11 @@ static int wait_for_all(struct drm_i915_private *i915)
 	return -ETIME;
 }
 
-static int __live_parallel_spin(void *arg)
+static void __live_parallel_spin(struct kthread_work *work)
 {
-	struct intel_engine_cs *engine = arg;
+	struct parallel_thread *thread =
+		container_of(work, typeof(*thread), work);
+	struct intel_engine_cs *engine = thread->engine;
 	struct igt_spinner spin;
 	struct i915_request *rq;
 	int err = 0;
@@ -1392,7 +1425,8 @@ static int __live_parallel_spin(void *arg)
 
 	if (igt_spinner_init(&spin, engine->gt)) {
 		wake_all(engine->i915);
-		return -ENOMEM;
+		thread->result = -ENOMEM;
+		return;
 	}
 
 	intel_engine_pm_get(engine);
@@ -1425,22 +1459,22 @@ static int __live_parallel_spin(void *arg)
 
 out_spin:
 	igt_spinner_fini(&spin);
-	return err;
+	thread->result = err;
 }
 
 static int live_parallel_engines(void *arg)
 {
 	struct drm_i915_private *i915 = arg;
-	static int (* const func[])(void *arg) = {
+	static void (* const func[])(struct kthread_work *) = {
 		__live_parallel_engine1,
 		__live_parallel_engineN,
 		__live_parallel_spin,
 		NULL,
 	};
 	const unsigned int nengines = num_uabi_engines(i915);
+	struct parallel_thread *threads;
 	struct intel_engine_cs *engine;
-	int (* const *fn)(void *arg);
-	struct task_struct **tsk;
+	void (* const *fn)(struct kthread_work *);
 	int err = 0;
 
 	/*
@@ -1448,8 +1482,8 @@ static int live_parallel_engines(void *arg)
 	 * tests that we load up the system maximally.
 	 */
 
-	tsk = kcalloc(nengines, sizeof(*tsk), GFP_KERNEL);
-	if (!tsk)
+	threads = kcalloc(nengines, sizeof(*threads), GFP_KERNEL);
+	if (!threads)
 		return -ENOMEM;
 
 	for (fn = func; !err && *fn; fn++) {
@@ -1466,37 +1500,44 @@ static int live_parallel_engines(void *arg)
 
 		idx = 0;
 		for_each_uabi_engine(engine, i915) {
-			tsk[idx] = kthread_run(*fn, engine,
-					       "igt/parallel:%s",
-					       engine->name);
-			if (IS_ERR(tsk[idx])) {
-				err = PTR_ERR(tsk[idx]);
+			struct kthread_worker *worker;
+
+			worker = kthread_create_worker(0, "igt/parallel:%s",
+						       engine->name);
+			if (IS_ERR(worker)) {
+				err = PTR_ERR(worker);
 				break;
 			}
-			get_task_struct(tsk[idx++]);
-		}
 
-		yield(); /* start all threads before we kthread_stop() */
+			threads[idx].worker = worker;
+			threads[idx].result = 0;
+			threads[idx].engine = engine;
+
+			kthread_init_work(&threads[idx].work, *fn);
+			kthread_queue_work(worker, &threads[idx].work);
+			idx++;
+		}
 
 		idx = 0;
 		for_each_uabi_engine(engine, i915) {
 			int status;
 
-			if (IS_ERR(tsk[idx]))
+			if (!threads[idx].worker)
 				break;
 
-			status = kthread_stop(tsk[idx]);
+			kthread_flush_work(&threads[idx].work);
+			status = READ_ONCE(threads[idx].result);
 			if (status && !err)
 				err = status;
 
-			put_task_struct(tsk[idx++]);
+			kthread_destroy_worker(threads[idx++].worker);
 		}
 
 		if (igt_live_test_end(&t))
 			err = -EIO;
 	}
 
-	kfree(tsk);
+	kfree(threads);
 	return err;
 }
 
@@ -1544,7 +1585,7 @@ static int live_breadcrumbs_smoketest(void *arg)
 	const unsigned int ncpus = num_online_cpus();
 	unsigned long num_waits, num_fences;
 	struct intel_engine_cs *engine;
-	struct task_struct **threads;
+	struct smoke_thread *threads;
 	struct igt_live_test live;
 	intel_wakeref_t wakeref;
 	struct smoketest *smoke;
@@ -1618,23 +1659,26 @@ static int live_breadcrumbs_smoketest(void *arg)
 			 smoke[idx].max_batch, engine->name);
 
 		for (n = 0; n < ncpus; n++) {
-			struct task_struct *tsk;
+			unsigned int i = idx * ncpus + n;
+			struct kthread_worker *worker;
 
-			tsk = kthread_run(__igt_breadcrumbs_smoketest,
-					  &smoke[idx], "igt/%d.%d", idx, n);
-			if (IS_ERR(tsk)) {
-				ret = PTR_ERR(tsk);
+			worker = kthread_create_worker(0, "igt/%d.%d", idx, n);
+			if (IS_ERR(worker)) {
+				ret = PTR_ERR(worker);
 				goto out_flush;
 			}
 
-			get_task_struct(tsk);
-			threads[idx * ncpus + n] = tsk;
+			threads[i].worker = worker;
+			threads[i].t = &smoke[idx];
+
+			kthread_init_work(&threads[i].work,
+					  __igt_breadcrumbs_smoketest);
+			kthread_queue_work(worker, &threads[i].work);
 		}
 
 		idx++;
 	}
 
-	yield(); /* start all threads before we begin */
 	msleep(jiffies_to_msecs(i915_selftest.timeout_jiffies));
 
 out_flush:
@@ -1643,17 +1687,19 @@ static int live_breadcrumbs_smoketest(void *arg)
 	num_fences = 0;
 	for_each_uabi_engine(engine, i915) {
 		for (n = 0; n < ncpus; n++) {
-			struct task_struct *tsk = threads[idx * ncpus + n];
+			unsigned int i = idx * ncpus + n;
 			int err;
 
-			if (!tsk)
+			if (!threads[i].worker)
 				continue;
 
-			err = kthread_stop(tsk);
+			WRITE_ONCE(threads[i].stop, true);
+			kthread_flush_work(&threads[i].work);
+			err = READ_ONCE(threads[i].result);
 			if (err < 0 && !ret)
 				ret = err;
 
-			put_task_struct(tsk);
+			kthread_destroy_worker(threads[i].worker);
 		}
 
 		num_waits += atomic_long_read(&smoke[idx].num_waits);
@@ -2763,9 +2809,18 @@ static int perf_series_engines(void *arg)
 	return err;
 }
 
-static int p_sync0(void *arg)
+struct p_thread {
+	struct perf_stats p;
+	struct kthread_worker *worker;
+	struct kthread_work work;
+	struct intel_engine_cs *engine;
+	int result;
+};
+
+static void p_sync0(struct kthread_work *work)
 {
-	struct perf_stats *p = arg;
+	struct p_thread *thread = container_of(work, typeof(*thread), work);
+	struct perf_stats *p = &thread->p;
 	struct intel_engine_cs *engine = p->engine;
 	struct intel_context *ce;
 	IGT_TIMEOUT(end_time);
@@ -2774,13 +2829,16 @@ static int p_sync0(void *arg)
 	int err = 0;
 
 	ce = intel_context_create(engine);
-	if (IS_ERR(ce))
-		return PTR_ERR(ce);
+	if (IS_ERR(ce)) {
+		thread->result = PTR_ERR(ce);
+		return;
+	}
 
 	err = intel_context_pin(ce);
 	if (err) {
 		intel_context_put(ce);
-		return err;
+		thread->result = err;
+		return;
 	}
 
 	if (intel_engine_supports_stats(engine)) {
@@ -2830,12 +2888,13 @@ static int p_sync0(void *arg)
 
 	intel_context_unpin(ce);
 	intel_context_put(ce);
-	return err;
+	thread->result = err;
 }
 
-static int p_sync1(void *arg)
+static void p_sync1(struct kthread_work *work)
 {
-	struct perf_stats *p = arg;
+	struct p_thread *thread = container_of(work, typeof(*thread), work);
+	struct perf_stats *p = &thread->p;
 	struct intel_engine_cs *engine = p->engine;
 	struct i915_request *prev = NULL;
 	struct intel_context *ce;
@@ -2845,13 +2904,16 @@ static int p_sync1(void *arg)
 	int err = 0;
 
 	ce = intel_context_create(engine);
-	if (IS_ERR(ce))
-		return PTR_ERR(ce);
+	if (IS_ERR(ce)) {
+		thread->result = PTR_ERR(ce);
+		return;
+	}
 
 	err = intel_context_pin(ce);
 	if (err) {
 		intel_context_put(ce);
-		return err;
+		thread->result = err;
+		return;
 	}
 
 	if (intel_engine_supports_stats(engine)) {
@@ -2903,12 +2965,13 @@ static int p_sync1(void *arg)
 
 	intel_context_unpin(ce);
 	intel_context_put(ce);
-	return err;
+	thread->result = err;
 }
 
-static int p_many(void *arg)
+static void p_many(struct kthread_work *work)
 {
-	struct perf_stats *p = arg;
+	struct p_thread *thread = container_of(work, typeof(*thread), work);
+	struct perf_stats *p = &thread->p;
 	struct intel_engine_cs *engine = p->engine;
 	struct intel_context *ce;
 	IGT_TIMEOUT(end_time);
@@ -2917,13 +2980,16 @@ static int p_many(void *arg)
 	bool busy;
 
 	ce = intel_context_create(engine);
-	if (IS_ERR(ce))
-		return PTR_ERR(ce);
+	if (IS_ERR(ce)) {
+		thread->result = PTR_ERR(ce);
+		return;
+	}
 
 	err = intel_context_pin(ce);
 	if (err) {
 		intel_context_put(ce);
-		return err;
+		thread->result = err;
+		return;
 	}
 
 	if (intel_engine_supports_stats(engine)) {
@@ -2964,26 +3030,23 @@ static int p_many(void *arg)
 
 	intel_context_unpin(ce);
 	intel_context_put(ce);
-	return err;
+	thread->result = err;
 }
 
 static int perf_parallel_engines(void *arg)
 {
 	struct drm_i915_private *i915 = arg;
-	static int (* const func[])(void *arg) = {
+	static void (* const func[])(struct kthread_work *) = {
 		p_sync0,
 		p_sync1,
 		p_many,
 		NULL,
 	};
 	const unsigned int nengines = num_uabi_engines(i915);
+	void (* const *fn)(struct kthread_work *);
 	struct intel_engine_cs *engine;
-	int (* const *fn)(void *arg);
 	struct pm_qos_request qos;
-	struct {
-		struct perf_stats p;
-		struct task_struct *tsk;
-	} *engines;
+	struct p_thread *engines;
 	int err = 0;
 
 	engines = kcalloc(nengines, sizeof(*engines), GFP_KERNEL);
@@ -3006,36 +3069,45 @@ static int perf_parallel_engines(void *arg)
 
 		idx = 0;
 		for_each_uabi_engine(engine, i915) {
+			struct kthread_worker *worker;
+
 			intel_engine_pm_get(engine);
 
 			memset(&engines[idx].p, 0, sizeof(engines[idx].p));
-			engines[idx].p.engine = engine;
 
-			engines[idx].tsk = kthread_run(*fn, &engines[idx].p,
-						       "igt:%s", engine->name);
-			if (IS_ERR(engines[idx].tsk)) {
-				err = PTR_ERR(engines[idx].tsk);
+			worker = kthread_create_worker(0, "igt:%s",
+						       engine->name);
+			if (IS_ERR(worker)) {
+				err = PTR_ERR(worker);
 				intel_engine_pm_put(engine);
 				break;
 			}
-			get_task_struct(engines[idx++].tsk);
-		}
+			engines[idx].worker = worker;
+			engines[idx].result = 0;
+			engines[idx].p.engine = engine;
+			engines[idx].engine = engine;
 
-		yield(); /* start all threads before we kthread_stop() */
+			kthread_init_work(&engines[idx].work, *fn);
+			kthread_queue_work(worker, &engines[idx].work);
+			idx++;
+		}
 
 		idx = 0;
 		for_each_uabi_engine(engine, i915) {
 			int status;
 
-			if (IS_ERR(engines[idx].tsk))
+			if (!engines[idx].worker)
 				break;
 
-			status = kthread_stop(engines[idx].tsk);
+			kthread_flush_work(&engines[idx].work);
+			status = READ_ONCE(engines[idx].result);
 			if (status && !err)
 				err = status;
 
 			intel_engine_pm_put(engine);
-			put_task_struct(engines[idx++].tsk);
+
+			kthread_destroy_worker(engines[idx].worker);
+			idx++;
 		}
 
 		if (igt_live_test_end(&t))
diff --git a/drivers/i2c/busses/i2c-mv64xxx.c b/drivers/i2c/busses/i2c-mv64xxx.c
index 103a05ecc3d6..9729a71b2567 100644
--- a/drivers/i2c/busses/i2c-mv64xxx.c
+++ b/drivers/i2c/busses/i2c-mv64xxx.c
@@ -520,6 +520,17 @@ mv64xxx_i2c_intr(int irq, void *dev_id)
 
 	while (readl(drv_data->reg_base + drv_data->reg_offsets.control) &
 						MV64XXX_I2C_REG_CONTROL_IFLG) {
+		/*
+		 * It seems that sometime the controller updates the status
+		 * register only after it asserts IFLG in control register.
+		 * This may result in weird bugs when in atomic mode. A delay
+		 * of 100 ns before reading the status register solves this
+		 * issue. This bug does not seem to appear when using
+		 * interrupts.
+		 */
+		if (drv_data->atomic)
+			ndelay(100);
+
 		status = readl(drv_data->reg_base + drv_data->reg_offsets.status);
 		mv64xxx_i2c_fsm(drv_data, status);
 		mv64xxx_i2c_do_action(drv_data);
diff --git a/drivers/i2c/busses/i2c-sprd.c b/drivers/i2c/busses/i2c-sprd.c
index 4fe15cd78907..ffc54fbf814d 100644
--- a/drivers/i2c/busses/i2c-sprd.c
+++ b/drivers/i2c/busses/i2c-sprd.c
@@ -576,12 +576,14 @@ static int sprd_i2c_remove(struct platform_device *pdev)
 	struct sprd_i2c *i2c_dev = platform_get_drvdata(pdev);
 	int ret;
 
-	ret = pm_runtime_resume_and_get(i2c_dev->dev);
+	ret = pm_runtime_get_sync(i2c_dev->dev);
 	if (ret < 0)
-		return ret;
+		dev_err(&pdev->dev, "Failed to resume device (%pe)\n", ERR_PTR(ret));
 
 	i2c_del_adapter(&i2c_dev->adap);
-	clk_disable_unprepare(i2c_dev->clk);
+
+	if (ret >= 0)
+		clk_disable_unprepare(i2c_dev->clk);
 
 	pm_runtime_put_noidle(i2c_dev->dev);
 	pm_runtime_disable(i2c_dev->dev);
diff --git a/drivers/input/input.c b/drivers/input/input.c
index ba246fabc6c1..5ca3f11d2d75 100644
--- a/drivers/input/input.c
+++ b/drivers/input/input.c
@@ -691,7 +691,7 @@ void input_close_device(struct input_handle *handle)
 
 	__input_release_device(handle);
 
-	if (!dev->inhibited && !--dev->users) {
+	if (!--dev->users && !dev->inhibited) {
 		if (dev->poller)
 			input_dev_poller_stop(dev->poller);
 		if (dev->close)
diff --git a/drivers/input/joystick/xpad.c b/drivers/input/joystick/xpad.c
index a7af9b56e338..57947874f26f 100644
--- a/drivers/input/joystick/xpad.c
+++ b/drivers/input/joystick/xpad.c
@@ -264,7 +264,6 @@ static const struct xpad_device {
 	{ 0x1430, 0xf801, "RedOctane Controller", 0, XTYPE_XBOX360 },
 	{ 0x146b, 0x0601, "BigBen Interactive XBOX 360 Controller", 0, XTYPE_XBOX360 },
 	{ 0x146b, 0x0604, "Bigben Interactive DAIJA Arcade Stick", MAP_TRIGGERS_TO_BUTTONS, XTYPE_XBOX360 },
-	{ 0x1532, 0x0037, "Razer Sabertooth", 0, XTYPE_XBOX360 },
 	{ 0x1532, 0x0a00, "Razer Atrox Arcade Stick", MAP_TRIGGERS_TO_BUTTONS, XTYPE_XBOXONE },
 	{ 0x1532, 0x0a03, "Razer Wildcat", 0, XTYPE_XBOXONE },
 	{ 0x15e4, 0x3f00, "Power A Mini Pro Elite", 0, XTYPE_XBOX360 },
diff --git a/drivers/input/mouse/elantech.c b/drivers/input/mouse/elantech.c
index ece97f8c6a3e..2118b2075f43 100644
--- a/drivers/input/mouse/elantech.c
+++ b/drivers/input/mouse/elantech.c
@@ -674,10 +674,11 @@ static void process_packet_head_v4(struct psmouse *psmouse)
 	struct input_dev *dev = psmouse->dev;
 	struct elantech_data *etd = psmouse->private;
 	unsigned char *packet = psmouse->packet;
-	int id = ((packet[3] & 0xe0) >> 5) - 1;
+	int id;
 	int pres, traces;
 
-	if (id < 0)
+	id = ((packet[3] & 0xe0) >> 5) - 1;
+	if (id < 0 || id >= ETP_MAX_FINGERS)
 		return;
 
 	etd->mt[id].x = ((packet[1] & 0x0f) << 8) | packet[2];
@@ -707,7 +708,7 @@ static void process_packet_motion_v4(struct psmouse *psmouse)
 	int id, sid;
 
 	id = ((packet[0] & 0xe0) >> 5) - 1;
-	if (id < 0)
+	if (id < 0 || id >= ETP_MAX_FINGERS)
 		return;
 
 	sid = ((packet[3] & 0xe0) >> 5) - 1;
@@ -728,7 +729,7 @@ static void process_packet_motion_v4(struct psmouse *psmouse)
 	input_report_abs(dev, ABS_MT_POSITION_X, etd->mt[id].x);
 	input_report_abs(dev, ABS_MT_POSITION_Y, etd->mt[id].y);
 
-	if (sid >= 0) {
+	if (sid >= 0 && sid < ETP_MAX_FINGERS) {
 		etd->mt[sid].x += delta_x2 * weight;
 		etd->mt[sid].y -= delta_y2 * weight;
 		input_mt_slot(dev, sid);
diff --git a/drivers/misc/eeprom/Kconfig b/drivers/misc/eeprom/Kconfig
index f0a7531f354c..2d240bfa819f 100644
--- a/drivers/misc/eeprom/Kconfig
+++ b/drivers/misc/eeprom/Kconfig
@@ -6,6 +6,7 @@ config EEPROM_AT24
 	depends on I2C && SYSFS
 	select NVMEM
 	select NVMEM_SYSFS
+	select REGMAP
 	select REGMAP_I2C
 	help
 	  Enable this driver to get read/write support to most I2C EEPROMs
diff --git a/drivers/net/dsa/lan9303-core.c b/drivers/net/dsa/lan9303-core.c
index 22547b10dfe5..63826553719b 100644
--- a/drivers/net/dsa/lan9303-core.c
+++ b/drivers/net/dsa/lan9303-core.c
@@ -1194,8 +1194,6 @@ static int lan9303_port_fdb_add(struct dsa_switch *ds, int port,
 	struct lan9303 *chip = ds->priv;
 
 	dev_dbg(chip->dev, "%s(%d, %pM, %d)\n", __func__, port, addr, vid);
-	if (vid)
-		return -EOPNOTSUPP;
 
 	return lan9303_alr_add_port(chip, addr, port, false);
 }
@@ -1207,8 +1205,6 @@ static int lan9303_port_fdb_del(struct dsa_switch *ds, int port,
 	struct lan9303 *chip = ds->priv;
 
 	dev_dbg(chip->dev, "%s(%d, %pM, %d)\n", __func__, port, addr, vid);
-	if (vid)
-		return -EOPNOTSUPP;
 	lan9303_alr_del_port(chip, addr, port);
 
 	return 0;
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 38fc2286f7cb..931bb40ac05b 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -8595,6 +8595,9 @@ static int bnxt_init_chip(struct bnxt *bp, bool irq_re_init)
 		goto err_out;
 	}
 
+	if (BNXT_VF(bp))
+		bnxt_hwrm_func_qcfg(bp);
+
 	rc = bnxt_setup_vnic(bp, 0);
 	if (rc)
 		goto err_out;
@@ -12698,26 +12701,37 @@ static void bnxt_cfg_ntp_filters(struct bnxt *bp)
 
 #endif /* CONFIG_RFS_ACCEL */
 
-static int bnxt_udp_tunnel_sync(struct net_device *netdev, unsigned int table)
+static int bnxt_udp_tunnel_set_port(struct net_device *netdev, unsigned int table,
+				    unsigned int entry, struct udp_tunnel_info *ti)
 {
 	struct bnxt *bp = netdev_priv(netdev);
-	struct udp_tunnel_info ti;
 	unsigned int cmd;
 
-	udp_tunnel_nic_get_port(netdev, table, 0, &ti);
-	if (ti.type == UDP_TUNNEL_TYPE_VXLAN)
+	if (ti->type == UDP_TUNNEL_TYPE_VXLAN)
 		cmd = TUNNEL_DST_PORT_FREE_REQ_TUNNEL_TYPE_VXLAN;
 	else
 		cmd = TUNNEL_DST_PORT_FREE_REQ_TUNNEL_TYPE_GENEVE;
 
-	if (ti.port)
-		return bnxt_hwrm_tunnel_dst_port_alloc(bp, ti.port, cmd);
+	return bnxt_hwrm_tunnel_dst_port_alloc(bp, ti->port, cmd);
+}
+
+static int bnxt_udp_tunnel_unset_port(struct net_device *netdev, unsigned int table,
+				      unsigned int entry, struct udp_tunnel_info *ti)
+{
+	struct bnxt *bp = netdev_priv(netdev);
+	unsigned int cmd;
+
+	if (ti->type == UDP_TUNNEL_TYPE_VXLAN)
+		cmd = TUNNEL_DST_PORT_FREE_REQ_TUNNEL_TYPE_VXLAN;
+	else
+		cmd = TUNNEL_DST_PORT_FREE_REQ_TUNNEL_TYPE_GENEVE;
 
 	return bnxt_hwrm_tunnel_dst_port_free(bp, cmd);
 }
 
 static const struct udp_tunnel_nic_info bnxt_udp_tunnels = {
-	.sync_table	= bnxt_udp_tunnel_sync,
+	.set_port	= bnxt_udp_tunnel_set_port,
+	.unset_port	= bnxt_udp_tunnel_unset_port,
 	.flags		= UDP_TUNNEL_NIC_INFO_MAY_SLEEP |
 			  UDP_TUNNEL_NIC_INFO_OPEN_ONLY,
 	.tables		= {
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
index 3c9ba116d5af..8ebc1c522a05 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
@@ -3597,7 +3597,7 @@ static int bnxt_reset(struct net_device *dev, u32 *flags)
 		}
 	}
 
-	if (req & BNXT_FW_RESET_AP) {
+	if (!BNXT_CHIP_P4_PLUS(bp) && (req & BNXT_FW_RESET_AP)) {
 		/* This feature is not supported in older firmware versions */
 		if (bp->hwrm_spec_code >= 0x10803) {
 			if (!bnxt_firmware_reset_ap(dev)) {
diff --git a/drivers/net/ethernet/freescale/enetc/enetc.c b/drivers/net/ethernet/freescale/enetc/enetc.c
index 8b7c93447770..e16bd2b7692f 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc.c
@@ -940,7 +940,13 @@ static int enetc_clean_rx_ring(struct enetc_bdr *rx_ring,
 		if (!skb)
 			break;
 
-		rx_byte_cnt += skb->len;
+		/* When set, the outer VLAN header is extracted and reported
+		 * in the receive buffer descriptor. So rx_byte_cnt should
+		 * add the length of the extracted VLAN header.
+		 */
+		if (bd_status & ENETC_RXBD_FLAG_VLAN)
+			rx_byte_cnt += VLAN_HLEN;
+		rx_byte_cnt += skb->len + ETH_HLEN;
 		rx_frm_cnt++;
 
 		napi_gro_receive(napi, skb);
diff --git a/drivers/net/ethernet/intel/i40e/i40e.h b/drivers/net/ethernet/intel/i40e/i40e.h
index 0f19c237cb58..a42ca847c8f8 100644
--- a/drivers/net/ethernet/intel/i40e/i40e.h
+++ b/drivers/net/ethernet/intel/i40e/i40e.h
@@ -1266,9 +1266,9 @@ void i40e_ptp_stop(struct i40e_pf *pf);
 int i40e_ptp_alloc_pins(struct i40e_pf *pf);
 int i40e_update_adq_vsi_queues(struct i40e_vsi *vsi, int vsi_offset);
 int i40e_is_vsi_uplink_mode_veb(struct i40e_vsi *vsi);
-i40e_status i40e_get_partition_bw_setting(struct i40e_pf *pf);
-i40e_status i40e_set_partition_bw_setting(struct i40e_pf *pf);
-i40e_status i40e_commit_partition_bw_setting(struct i40e_pf *pf);
+int i40e_get_partition_bw_setting(struct i40e_pf *pf);
+int i40e_set_partition_bw_setting(struct i40e_pf *pf);
+int i40e_commit_partition_bw_setting(struct i40e_pf *pf);
 void i40e_print_link_message(struct i40e_vsi *vsi, bool isup);
 
 void i40e_set_fec_in_flags(u8 fec_cfg, u32 *flags);
diff --git a/drivers/net/ethernet/intel/i40e/i40e_adminq.c b/drivers/net/ethernet/intel/i40e/i40e_adminq.c
index 593912b17609..20de187dc5f1 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_adminq.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_adminq.c
@@ -47,9 +47,9 @@ static void i40e_adminq_init_regs(struct i40e_hw *hw)
  *  i40e_alloc_adminq_asq_ring - Allocate Admin Queue send rings
  *  @hw: pointer to the hardware structure
  **/
-static i40e_status i40e_alloc_adminq_asq_ring(struct i40e_hw *hw)
+static int i40e_alloc_adminq_asq_ring(struct i40e_hw *hw)
 {
-	i40e_status ret_code;
+	int ret_code;
 
 	ret_code = i40e_allocate_dma_mem(hw, &hw->aq.asq.desc_buf,
 					 i40e_mem_atq_ring,
@@ -74,9 +74,9 @@ static i40e_status i40e_alloc_adminq_asq_ring(struct i40e_hw *hw)
  *  i40e_alloc_adminq_arq_ring - Allocate Admin Queue receive rings
  *  @hw: pointer to the hardware structure
  **/
-static i40e_status i40e_alloc_adminq_arq_ring(struct i40e_hw *hw)
+static int i40e_alloc_adminq_arq_ring(struct i40e_hw *hw)
 {
-	i40e_status ret_code;
+	int ret_code;
 
 	ret_code = i40e_allocate_dma_mem(hw, &hw->aq.arq.desc_buf,
 					 i40e_mem_arq_ring,
@@ -115,11 +115,11 @@ static void i40e_free_adminq_arq(struct i40e_hw *hw)
  *  i40e_alloc_arq_bufs - Allocate pre-posted buffers for the receive queue
  *  @hw: pointer to the hardware structure
  **/
-static i40e_status i40e_alloc_arq_bufs(struct i40e_hw *hw)
+static int i40e_alloc_arq_bufs(struct i40e_hw *hw)
 {
-	i40e_status ret_code;
 	struct i40e_aq_desc *desc;
 	struct i40e_dma_mem *bi;
+	int ret_code;
 	int i;
 
 	/* We'll be allocating the buffer info memory first, then we can
@@ -182,10 +182,10 @@ static i40e_status i40e_alloc_arq_bufs(struct i40e_hw *hw)
  *  i40e_alloc_asq_bufs - Allocate empty buffer structs for the send queue
  *  @hw: pointer to the hardware structure
  **/
-static i40e_status i40e_alloc_asq_bufs(struct i40e_hw *hw)
+static int i40e_alloc_asq_bufs(struct i40e_hw *hw)
 {
-	i40e_status ret_code;
 	struct i40e_dma_mem *bi;
+	int ret_code;
 	int i;
 
 	/* No mapped memory needed yet, just the buffer info structures */
@@ -266,9 +266,9 @@ static void i40e_free_asq_bufs(struct i40e_hw *hw)
  *
  *  Configure base address and length registers for the transmit queue
  **/
-static i40e_status i40e_config_asq_regs(struct i40e_hw *hw)
+static int i40e_config_asq_regs(struct i40e_hw *hw)
 {
-	i40e_status ret_code = 0;
+	int ret_code = 0;
 	u32 reg = 0;
 
 	/* Clear Head and Tail */
@@ -295,9 +295,9 @@ static i40e_status i40e_config_asq_regs(struct i40e_hw *hw)
  *
  * Configure base address and length registers for the receive (event queue)
  **/
-static i40e_status i40e_config_arq_regs(struct i40e_hw *hw)
+static int i40e_config_arq_regs(struct i40e_hw *hw)
 {
-	i40e_status ret_code = 0;
+	int ret_code = 0;
 	u32 reg = 0;
 
 	/* Clear Head and Tail */
@@ -334,9 +334,9 @@ static i40e_status i40e_config_arq_regs(struct i40e_hw *hw)
  *  Do *NOT* hold the lock when calling this as the memory allocation routines
  *  called are not going to be atomic context safe
  **/
-static i40e_status i40e_init_asq(struct i40e_hw *hw)
+static int i40e_init_asq(struct i40e_hw *hw)
 {
-	i40e_status ret_code = 0;
+	int ret_code = 0;
 
 	if (hw->aq.asq.count > 0) {
 		/* queue already initialized */
@@ -393,9 +393,9 @@ static i40e_status i40e_init_asq(struct i40e_hw *hw)
  *  Do *NOT* hold the lock when calling this as the memory allocation routines
  *  called are not going to be atomic context safe
  **/
-static i40e_status i40e_init_arq(struct i40e_hw *hw)
+static int i40e_init_arq(struct i40e_hw *hw)
 {
-	i40e_status ret_code = 0;
+	int ret_code = 0;
 
 	if (hw->aq.arq.count > 0) {
 		/* queue already initialized */
@@ -445,9 +445,9 @@ static i40e_status i40e_init_arq(struct i40e_hw *hw)
  *
  *  The main shutdown routine for the Admin Send Queue
  **/
-static i40e_status i40e_shutdown_asq(struct i40e_hw *hw)
+static int i40e_shutdown_asq(struct i40e_hw *hw)
 {
-	i40e_status ret_code = 0;
+	int ret_code = 0;
 
 	mutex_lock(&hw->aq.asq_mutex);
 
@@ -479,9 +479,9 @@ static i40e_status i40e_shutdown_asq(struct i40e_hw *hw)
  *
  *  The main shutdown routine for the Admin Receive Queue
  **/
-static i40e_status i40e_shutdown_arq(struct i40e_hw *hw)
+static int i40e_shutdown_arq(struct i40e_hw *hw)
 {
-	i40e_status ret_code = 0;
+	int ret_code = 0;
 
 	mutex_lock(&hw->aq.arq_mutex);
 
@@ -582,12 +582,12 @@ static void i40e_set_hw_flags(struct i40e_hw *hw)
  *     - hw->aq.arq_buf_size
  *     - hw->aq.asq_buf_size
  **/
-i40e_status i40e_init_adminq(struct i40e_hw *hw)
+int i40e_init_adminq(struct i40e_hw *hw)
 {
 	u16 cfg_ptr, oem_hi, oem_lo;
 	u16 eetrack_lo, eetrack_hi;
-	i40e_status ret_code;
 	int retry = 0;
+	int ret_code;
 
 	/* verify input for valid configuration */
 	if ((hw->aq.num_arq_entries == 0) ||
@@ -779,18 +779,18 @@ static bool i40e_asq_done(struct i40e_hw *hw)
  *  This is the main send command driver routine for the Admin Queue send
  *  queue.  It runs the queue, cleans the queue, etc
  **/
-i40e_status i40e_asq_send_command(struct i40e_hw *hw,
-				struct i40e_aq_desc *desc,
-				void *buff, /* can be NULL */
-				u16  buff_size,
-				struct i40e_asq_cmd_details *cmd_details)
+int i40e_asq_send_command(struct i40e_hw *hw,
+			  struct i40e_aq_desc *desc,
+			  void *buff, /* can be NULL */
+			  u16  buff_size,
+			  struct i40e_asq_cmd_details *cmd_details)
 {
-	i40e_status status = 0;
 	struct i40e_dma_mem *dma_buff = NULL;
 	struct i40e_asq_cmd_details *details;
 	struct i40e_aq_desc *desc_on_ring;
 	bool cmd_completed = false;
 	u16  retval = 0;
+	int status = 0;
 	u32  val = 0;
 
 	mutex_lock(&hw->aq.asq_mutex);
@@ -993,14 +993,14 @@ void i40e_fill_default_direct_cmd_desc(struct i40e_aq_desc *desc,
  *  the contents through e.  It can also return how many events are
  *  left to process through 'pending'
  **/
-i40e_status i40e_clean_arq_element(struct i40e_hw *hw,
-					     struct i40e_arq_event_info *e,
-					     u16 *pending)
+int i40e_clean_arq_element(struct i40e_hw *hw,
+			   struct i40e_arq_event_info *e,
+			   u16 *pending)
 {
-	i40e_status ret_code = 0;
 	u16 ntc = hw->aq.arq.next_to_clean;
 	struct i40e_aq_desc *desc;
 	struct i40e_dma_mem *bi;
+	int ret_code = 0;
 	u16 desc_idx;
 	u16 datalen;
 	u16 flags;
diff --git a/drivers/net/ethernet/intel/i40e/i40e_alloc.h b/drivers/net/ethernet/intel/i40e/i40e_alloc.h
index cb8689222c8b..a6c9a9e343d1 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_alloc.h
+++ b/drivers/net/ethernet/intel/i40e/i40e_alloc.h
@@ -20,16 +20,16 @@ enum i40e_memory_type {
 };
 
 /* prototype for functions used for dynamic memory allocation */
-i40e_status i40e_allocate_dma_mem(struct i40e_hw *hw,
-					    struct i40e_dma_mem *mem,
-					    enum i40e_memory_type type,
-					    u64 size, u32 alignment);
-i40e_status i40e_free_dma_mem(struct i40e_hw *hw,
-					struct i40e_dma_mem *mem);
-i40e_status i40e_allocate_virt_mem(struct i40e_hw *hw,
-					     struct i40e_virt_mem *mem,
-					     u32 size);
-i40e_status i40e_free_virt_mem(struct i40e_hw *hw,
-					 struct i40e_virt_mem *mem);
+int i40e_allocate_dma_mem(struct i40e_hw *hw,
+			  struct i40e_dma_mem *mem,
+			  enum i40e_memory_type type,
+			  u64 size, u32 alignment);
+int i40e_free_dma_mem(struct i40e_hw *hw,
+		      struct i40e_dma_mem *mem);
+int i40e_allocate_virt_mem(struct i40e_hw *hw,
+			   struct i40e_virt_mem *mem,
+			   u32 size);
+int i40e_free_virt_mem(struct i40e_hw *hw,
+		       struct i40e_virt_mem *mem);
 
 #endif /* _I40E_ALLOC_H_ */
diff --git a/drivers/net/ethernet/intel/i40e/i40e_client.c b/drivers/net/ethernet/intel/i40e/i40e_client.c
index 10d7a982a5b9..8bcb98b85e3d 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_client.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_client.c
@@ -541,7 +541,7 @@ static int i40e_client_virtchnl_send(struct i40e_info *ldev,
 {
 	struct i40e_pf *pf = ldev->pf;
 	struct i40e_hw *hw = &pf->hw;
-	i40e_status err;
+	int err;
 
 	err = i40e_aq_send_msg_to_vf(hw, vf_id, VIRTCHNL_OP_IWARP,
 				     0, msg, len, NULL);
@@ -674,7 +674,7 @@ static int i40e_client_update_vsi_ctxt(struct i40e_info *ldev,
 	struct i40e_vsi *vsi = pf->vsi[pf->lan_vsi];
 	struct i40e_vsi_context ctxt;
 	bool update = true;
-	i40e_status err;
+	int err;
 
 	/* TODO: for now do not allow setting VF's VSI setting */
 	if (is_vf)
@@ -686,8 +686,8 @@ static int i40e_client_update_vsi_ctxt(struct i40e_info *ldev,
 	ctxt.flags = I40E_AQ_VSI_TYPE_PF;
 	if (err) {
 		dev_info(&pf->pdev->dev,
-			 "couldn't get PF vsi config, err %s aq_err %s\n",
-			 i40e_stat_str(&pf->hw, err),
+			 "couldn't get PF vsi config, err %d aq_err %s\n",
+			 err,
 			 i40e_aq_str(&pf->hw,
 				     pf->hw.aq.asq_last_status));
 		return -ENOENT;
@@ -714,8 +714,8 @@ static int i40e_client_update_vsi_ctxt(struct i40e_info *ldev,
 		err = i40e_aq_update_vsi_params(&vsi->back->hw, &ctxt, NULL);
 		if (err) {
 			dev_info(&pf->pdev->dev,
-				 "update VSI ctxt for PE failed, err %s aq_err %s\n",
-				 i40e_stat_str(&pf->hw, err),
+				 "update VSI ctxt for PE failed, err %d aq_err %s\n",
+				 err,
 				 i40e_aq_str(&pf->hw,
 					     pf->hw.aq.asq_last_status));
 		}
diff --git a/drivers/net/ethernet/intel/i40e/i40e_common.c b/drivers/net/ethernet/intel/i40e/i40e_common.c
index b4d3fed0d2f2..7f91e04d75b8 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_common.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_common.c
@@ -14,9 +14,9 @@
  * This function sets the mac type of the adapter based on the
  * vendor ID and device ID stored in the hw structure.
  **/
-i40e_status i40e_set_mac_type(struct i40e_hw *hw)
+int i40e_set_mac_type(struct i40e_hw *hw)
 {
-	i40e_status status = 0;
+	int status = 0;
 
 	if (hw->vendor_id == PCI_VENDOR_ID_INTEL) {
 		switch (hw->device_id) {
@@ -122,154 +122,6 @@ const char *i40e_aq_str(struct i40e_hw *hw, enum i40e_admin_queue_err aq_err)
 	return hw->err_str;
 }
 
-/**
- * i40e_stat_str - convert status err code to a string
- * @hw: pointer to the HW structure
- * @stat_err: the status error code to convert
- **/
-const char *i40e_stat_str(struct i40e_hw *hw, i40e_status stat_err)
-{
-	switch (stat_err) {
-	case 0:
-		return "OK";
-	case I40E_ERR_NVM:
-		return "I40E_ERR_NVM";
-	case I40E_ERR_NVM_CHECKSUM:
-		return "I40E_ERR_NVM_CHECKSUM";
-	case I40E_ERR_PHY:
-		return "I40E_ERR_PHY";
-	case I40E_ERR_CONFIG:
-		return "I40E_ERR_CONFIG";
-	case I40E_ERR_PARAM:
-		return "I40E_ERR_PARAM";
-	case I40E_ERR_MAC_TYPE:
-		return "I40E_ERR_MAC_TYPE";
-	case I40E_ERR_UNKNOWN_PHY:
-		return "I40E_ERR_UNKNOWN_PHY";
-	case I40E_ERR_LINK_SETUP:
-		return "I40E_ERR_LINK_SETUP";
-	case I40E_ERR_ADAPTER_STOPPED:
-		return "I40E_ERR_ADAPTER_STOPPED";
-	case I40E_ERR_INVALID_MAC_ADDR:
-		return "I40E_ERR_INVALID_MAC_ADDR";
-	case I40E_ERR_DEVICE_NOT_SUPPORTED:
-		return "I40E_ERR_DEVICE_NOT_SUPPORTED";
-	case I40E_ERR_MASTER_REQUESTS_PENDING:
-		return "I40E_ERR_MASTER_REQUESTS_PENDING";
-	case I40E_ERR_INVALID_LINK_SETTINGS:
-		return "I40E_ERR_INVALID_LINK_SETTINGS";
-	case I40E_ERR_AUTONEG_NOT_COMPLETE:
-		return "I40E_ERR_AUTONEG_NOT_COMPLETE";
-	case I40E_ERR_RESET_FAILED:
-		return "I40E_ERR_RESET_FAILED";
-	case I40E_ERR_SWFW_SYNC:
-		return "I40E_ERR_SWFW_SYNC";
-	case I40E_ERR_NO_AVAILABLE_VSI:
-		return "I40E_ERR_NO_AVAILABLE_VSI";
-	case I40E_ERR_NO_MEMORY:
-		return "I40E_ERR_NO_MEMORY";
-	case I40E_ERR_BAD_PTR:
-		return "I40E_ERR_BAD_PTR";
-	case I40E_ERR_RING_FULL:
-		return "I40E_ERR_RING_FULL";
-	case I40E_ERR_INVALID_PD_ID:
-		return "I40E_ERR_INVALID_PD_ID";
-	case I40E_ERR_INVALID_QP_ID:
-		return "I40E_ERR_INVALID_QP_ID";
-	case I40E_ERR_INVALID_CQ_ID:
-		return "I40E_ERR_INVALID_CQ_ID";
-	case I40E_ERR_INVALID_CEQ_ID:
-		return "I40E_ERR_INVALID_CEQ_ID";
-	case I40E_ERR_INVALID_AEQ_ID:
-		return "I40E_ERR_INVALID_AEQ_ID";
-	case I40E_ERR_INVALID_SIZE:
-		return "I40E_ERR_INVALID_SIZE";
-	case I40E_ERR_INVALID_ARP_INDEX:
-		return "I40E_ERR_INVALID_ARP_INDEX";
-	case I40E_ERR_INVALID_FPM_FUNC_ID:
-		return "I40E_ERR_INVALID_FPM_FUNC_ID";
-	case I40E_ERR_QP_INVALID_MSG_SIZE:
-		return "I40E_ERR_QP_INVALID_MSG_SIZE";
-	case I40E_ERR_QP_TOOMANY_WRS_POSTED:
-		return "I40E_ERR_QP_TOOMANY_WRS_POSTED";
-	case I40E_ERR_INVALID_FRAG_COUNT:
-		return "I40E_ERR_INVALID_FRAG_COUNT";
-	case I40E_ERR_QUEUE_EMPTY:
-		return "I40E_ERR_QUEUE_EMPTY";
-	case I40E_ERR_INVALID_ALIGNMENT:
-		return "I40E_ERR_INVALID_ALIGNMENT";
-	case I40E_ERR_FLUSHED_QUEUE:
-		return "I40E_ERR_FLUSHED_QUEUE";
-	case I40E_ERR_INVALID_PUSH_PAGE_INDEX:
-		return "I40E_ERR_INVALID_PUSH_PAGE_INDEX";
-	case I40E_ERR_INVALID_IMM_DATA_SIZE:
-		return "I40E_ERR_INVALID_IMM_DATA_SIZE";
-	case I40E_ERR_TIMEOUT:
-		return "I40E_ERR_TIMEOUT";
-	case I40E_ERR_OPCODE_MISMATCH:
-		return "I40E_ERR_OPCODE_MISMATCH";
-	case I40E_ERR_CQP_COMPL_ERROR:
-		return "I40E_ERR_CQP_COMPL_ERROR";
-	case I40E_ERR_INVALID_VF_ID:
-		return "I40E_ERR_INVALID_VF_ID";
-	case I40E_ERR_INVALID_HMCFN_ID:
-		return "I40E_ERR_INVALID_HMCFN_ID";
-	case I40E_ERR_BACKING_PAGE_ERROR:
-		return "I40E_ERR_BACKING_PAGE_ERROR";
-	case I40E_ERR_NO_PBLCHUNKS_AVAILABLE:
-		return "I40E_ERR_NO_PBLCHUNKS_AVAILABLE";
-	case I40E_ERR_INVALID_PBLE_INDEX:
-		return "I40E_ERR_INVALID_PBLE_INDEX";
-	case I40E_ERR_INVALID_SD_INDEX:
-		return "I40E_ERR_INVALID_SD_INDEX";
-	case I40E_ERR_INVALID_PAGE_DESC_INDEX:
-		return "I40E_ERR_INVALID_PAGE_DESC_INDEX";
-	case I40E_ERR_INVALID_SD_TYPE:
-		return "I40E_ERR_INVALID_SD_TYPE";
-	case I40E_ERR_MEMCPY_FAILED:
-		return "I40E_ERR_MEMCPY_FAILED";
-	case I40E_ERR_INVALID_HMC_OBJ_INDEX:
-		return "I40E_ERR_INVALID_HMC_OBJ_INDEX";
-	case I40E_ERR_INVALID_HMC_OBJ_COUNT:
-		return "I40E_ERR_INVALID_HMC_OBJ_COUNT";
-	case I40E_ERR_INVALID_SRQ_ARM_LIMIT:
-		return "I40E_ERR_INVALID_SRQ_ARM_LIMIT";
-	case I40E_ERR_SRQ_ENABLED:
-		return "I40E_ERR_SRQ_ENABLED";
-	case I40E_ERR_ADMIN_QUEUE_ERROR:
-		return "I40E_ERR_ADMIN_QUEUE_ERROR";
-	case I40E_ERR_ADMIN_QUEUE_TIMEOUT:
-		return "I40E_ERR_ADMIN_QUEUE_TIMEOUT";
-	case I40E_ERR_BUF_TOO_SHORT:
-		return "I40E_ERR_BUF_TOO_SHORT";
-	case I40E_ERR_ADMIN_QUEUE_FULL:
-		return "I40E_ERR_ADMIN_QUEUE_FULL";
-	case I40E_ERR_ADMIN_QUEUE_NO_WORK:
-		return "I40E_ERR_ADMIN_QUEUE_NO_WORK";
-	case I40E_ERR_BAD_IWARP_CQE:
-		return "I40E_ERR_BAD_IWARP_CQE";
-	case I40E_ERR_NVM_BLANK_MODE:
-		return "I40E_ERR_NVM_BLANK_MODE";
-	case I40E_ERR_NOT_IMPLEMENTED:
-		return "I40E_ERR_NOT_IMPLEMENTED";
-	case I40E_ERR_PE_DOORBELL_NOT_ENABLED:
-		return "I40E_ERR_PE_DOORBELL_NOT_ENABLED";
-	case I40E_ERR_DIAG_TEST_FAILED:
-		return "I40E_ERR_DIAG_TEST_FAILED";
-	case I40E_ERR_NOT_READY:
-		return "I40E_ERR_NOT_READY";
-	case I40E_NOT_SUPPORTED:
-		return "I40E_NOT_SUPPORTED";
-	case I40E_ERR_FIRMWARE_API_VERSION:
-		return "I40E_ERR_FIRMWARE_API_VERSION";
-	case I40E_ERR_ADMIN_QUEUE_CRITICAL_ERROR:
-		return "I40E_ERR_ADMIN_QUEUE_CRITICAL_ERROR";
-	}
-
-	snprintf(hw->err_str, sizeof(hw->err_str), "%d", stat_err);
-	return hw->err_str;
-}
-
 /**
  * i40e_debug_aq
  * @hw: debug mask related to admin queue
@@ -353,13 +205,13 @@ bool i40e_check_asq_alive(struct i40e_hw *hw)
  * Tell the Firmware that we're shutting down the AdminQ and whether
  * or not the driver is unloading as well.
  **/
-i40e_status i40e_aq_queue_shutdown(struct i40e_hw *hw,
-					     bool unloading)
+int i40e_aq_queue_shutdown(struct i40e_hw *hw,
+			   bool unloading)
 {
 	struct i40e_aq_desc desc;
 	struct i40e_aqc_queue_shutdown *cmd =
 		(struct i40e_aqc_queue_shutdown *)&desc.params.raw;
-	i40e_status status;
+	int status;
 
 	i40e_fill_default_direct_cmd_desc(&desc,
 					  i40e_aqc_opc_queue_shutdown);
@@ -382,15 +234,15 @@ i40e_status i40e_aq_queue_shutdown(struct i40e_hw *hw,
  *
  * Internal function to get or set RSS look up table
  **/
-static i40e_status i40e_aq_get_set_rss_lut(struct i40e_hw *hw,
-					   u16 vsi_id, bool pf_lut,
-					   u8 *lut, u16 lut_size,
-					   bool set)
+static int i40e_aq_get_set_rss_lut(struct i40e_hw *hw,
+				   u16 vsi_id, bool pf_lut,
+				   u8 *lut, u16 lut_size,
+				   bool set)
 {
-	i40e_status status;
 	struct i40e_aq_desc desc;
 	struct i40e_aqc_get_set_rss_lut *cmd_resp =
 		   (struct i40e_aqc_get_set_rss_lut *)&desc.params.raw;
+	int status;
 
 	if (set)
 		i40e_fill_default_direct_cmd_desc(&desc,
@@ -435,8 +287,8 @@ static i40e_status i40e_aq_get_set_rss_lut(struct i40e_hw *hw,
  *
  * get the RSS lookup table, PF or VSI type
  **/
-i40e_status i40e_aq_get_rss_lut(struct i40e_hw *hw, u16 vsi_id,
-				bool pf_lut, u8 *lut, u16 lut_size)
+int i40e_aq_get_rss_lut(struct i40e_hw *hw, u16 vsi_id,
+			bool pf_lut, u8 *lut, u16 lut_size)
 {
 	return i40e_aq_get_set_rss_lut(hw, vsi_id, pf_lut, lut, lut_size,
 				       false);
@@ -452,8 +304,8 @@ i40e_status i40e_aq_get_rss_lut(struct i40e_hw *hw, u16 vsi_id,
  *
  * set the RSS lookup table, PF or VSI type
  **/
-i40e_status i40e_aq_set_rss_lut(struct i40e_hw *hw, u16 vsi_id,
-				bool pf_lut, u8 *lut, u16 lut_size)
+int i40e_aq_set_rss_lut(struct i40e_hw *hw, u16 vsi_id,
+			bool pf_lut, u8 *lut, u16 lut_size)
 {
 	return i40e_aq_get_set_rss_lut(hw, vsi_id, pf_lut, lut, lut_size, true);
 }
@@ -467,16 +319,16 @@ i40e_status i40e_aq_set_rss_lut(struct i40e_hw *hw, u16 vsi_id,
  *
  * get the RSS key per VSI
  **/
-static i40e_status i40e_aq_get_set_rss_key(struct i40e_hw *hw,
-				      u16 vsi_id,
-				      struct i40e_aqc_get_set_rss_key_data *key,
-				      bool set)
+static int i40e_aq_get_set_rss_key(struct i40e_hw *hw,
+				   u16 vsi_id,
+				   struct i40e_aqc_get_set_rss_key_data *key,
+				   bool set)
 {
-	i40e_status status;
 	struct i40e_aq_desc desc;
 	struct i40e_aqc_get_set_rss_key *cmd_resp =
 			(struct i40e_aqc_get_set_rss_key *)&desc.params.raw;
 	u16 key_size = sizeof(struct i40e_aqc_get_set_rss_key_data);
+	int status;
 
 	if (set)
 		i40e_fill_default_direct_cmd_desc(&desc,
@@ -507,9 +359,9 @@ static i40e_status i40e_aq_get_set_rss_key(struct i40e_hw *hw,
  * @key: pointer to key info struct
  *
  **/
-i40e_status i40e_aq_get_rss_key(struct i40e_hw *hw,
-				u16 vsi_id,
-				struct i40e_aqc_get_set_rss_key_data *key)
+int i40e_aq_get_rss_key(struct i40e_hw *hw,
+			u16 vsi_id,
+			struct i40e_aqc_get_set_rss_key_data *key)
 {
 	return i40e_aq_get_set_rss_key(hw, vsi_id, key, false);
 }
@@ -522,9 +374,9 @@ i40e_status i40e_aq_get_rss_key(struct i40e_hw *hw,
  *
  * set the RSS key per VSI
  **/
-i40e_status i40e_aq_set_rss_key(struct i40e_hw *hw,
-				u16 vsi_id,
-				struct i40e_aqc_get_set_rss_key_data *key)
+int i40e_aq_set_rss_key(struct i40e_hw *hw,
+			u16 vsi_id,
+			struct i40e_aqc_get_set_rss_key_data *key)
 {
 	return i40e_aq_get_set_rss_key(hw, vsi_id, key, true);
 }
@@ -794,10 +646,10 @@ struct i40e_rx_ptype_decoded i40e_ptype_lookup[BIT(8)] = {
  * hw_addr, back, device_id, vendor_id, subsystem_device_id,
  * subsystem_vendor_id, and revision_id
  **/
-i40e_status i40e_init_shared_code(struct i40e_hw *hw)
+int i40e_init_shared_code(struct i40e_hw *hw)
 {
-	i40e_status status = 0;
 	u32 port, ari, func_rid;
+	int status = 0;
 
 	i40e_set_mac_type(hw);
 
@@ -834,15 +686,16 @@ i40e_status i40e_init_shared_code(struct i40e_hw *hw)
  * @addrs: the requestor's mac addr store
  * @cmd_details: pointer to command details structure or NULL
  **/
-static i40e_status i40e_aq_mac_address_read(struct i40e_hw *hw,
-				   u16 *flags,
-				   struct i40e_aqc_mac_address_read_data *addrs,
-				   struct i40e_asq_cmd_details *cmd_details)
+static int
+i40e_aq_mac_address_read(struct i40e_hw *hw,
+			 u16 *flags,
+			 struct i40e_aqc_mac_address_read_data *addrs,
+			 struct i40e_asq_cmd_details *cmd_details)
 {
 	struct i40e_aq_desc desc;
 	struct i40e_aqc_mac_address_read *cmd_data =
 		(struct i40e_aqc_mac_address_read *)&desc.params.raw;
-	i40e_status status;
+	int status;
 
 	i40e_fill_default_direct_cmd_desc(&desc, i40e_aqc_opc_mac_address_read);
 	desc.flags |= cpu_to_le16(I40E_AQ_FLAG_BUF);
@@ -861,14 +714,14 @@ static i40e_status i40e_aq_mac_address_read(struct i40e_hw *hw,
  * @mac_addr: address to write
  * @cmd_details: pointer to command details structure or NULL
  **/
-i40e_status i40e_aq_mac_address_write(struct i40e_hw *hw,
-				    u16 flags, u8 *mac_addr,
-				    struct i40e_asq_cmd_details *cmd_details)
+int i40e_aq_mac_address_write(struct i40e_hw *hw,
+			      u16 flags, u8 *mac_addr,
+			      struct i40e_asq_cmd_details *cmd_details)
 {
 	struct i40e_aq_desc desc;
 	struct i40e_aqc_mac_address_write *cmd_data =
 		(struct i40e_aqc_mac_address_write *)&desc.params.raw;
-	i40e_status status;
+	int status;
 
 	i40e_fill_default_direct_cmd_desc(&desc,
 					  i40e_aqc_opc_mac_address_write);
@@ -891,11 +744,11 @@ i40e_status i40e_aq_mac_address_write(struct i40e_hw *hw,
  *
  * Reads the adapter's MAC address from register
  **/
-i40e_status i40e_get_mac_addr(struct i40e_hw *hw, u8 *mac_addr)
+int i40e_get_mac_addr(struct i40e_hw *hw, u8 *mac_addr)
 {
 	struct i40e_aqc_mac_address_read_data addrs;
-	i40e_status status;
 	u16 flags = 0;
+	int status;
 
 	status = i40e_aq_mac_address_read(hw, &flags, &addrs, NULL);
 
@@ -912,11 +765,11 @@ i40e_status i40e_get_mac_addr(struct i40e_hw *hw, u8 *mac_addr)
  *
  * Reads the adapter's Port MAC address
  **/
-i40e_status i40e_get_port_mac_addr(struct i40e_hw *hw, u8 *mac_addr)
+int i40e_get_port_mac_addr(struct i40e_hw *hw, u8 *mac_addr)
 {
 	struct i40e_aqc_mac_address_read_data addrs;
-	i40e_status status;
 	u16 flags = 0;
+	int status;
 
 	status = i40e_aq_mac_address_read(hw, &flags, &addrs, NULL);
 	if (status)
@@ -970,13 +823,13 @@ void i40e_pre_tx_queue_cfg(struct i40e_hw *hw, u32 queue, bool enable)
  *
  *  Reads the part number string from the EEPROM.
  **/
-i40e_status i40e_read_pba_string(struct i40e_hw *hw, u8 *pba_num,
-				 u32 pba_num_size)
+int i40e_read_pba_string(struct i40e_hw *hw, u8 *pba_num,
+			 u32 pba_num_size)
 {
-	i40e_status status = 0;
 	u16 pba_word = 0;
 	u16 pba_size = 0;
 	u16 pba_ptr = 0;
+	int status = 0;
 	u16 i = 0;
 
 	status = i40e_read_nvm_word(hw, I40E_SR_PBA_FLAGS, &pba_word);
@@ -1085,8 +938,8 @@ static enum i40e_media_type i40e_get_media_type(struct i40e_hw *hw)
  * @hw: pointer to the hardware structure
  * @retry_limit: how many times to retry before failure
  **/
-static i40e_status i40e_poll_globr(struct i40e_hw *hw,
-				   u32 retry_limit)
+static int i40e_poll_globr(struct i40e_hw *hw,
+			   u32 retry_limit)
 {
 	u32 cnt, reg = 0;
 
@@ -1112,7 +965,7 @@ static i40e_status i40e_poll_globr(struct i40e_hw *hw,
  * Assuming someone else has triggered a global reset,
  * assure the global reset is complete and then reset the PF
  **/
-i40e_status i40e_pf_reset(struct i40e_hw *hw)
+int i40e_pf_reset(struct i40e_hw *hw)
 {
 	u32 cnt = 0;
 	u32 cnt1 = 0;
@@ -1451,15 +1304,16 @@ void i40e_led_set(struct i40e_hw *hw, u32 mode, bool blink)
  *
  * Returns the various PHY abilities supported on the Port.
  **/
-i40e_status i40e_aq_get_phy_capabilities(struct i40e_hw *hw,
-			bool qualified_modules, bool report_init,
-			struct i40e_aq_get_phy_abilities_resp *abilities,
-			struct i40e_asq_cmd_details *cmd_details)
+int
+i40e_aq_get_phy_capabilities(struct i40e_hw *hw,
+			     bool qualified_modules, bool report_init,
+			     struct i40e_aq_get_phy_abilities_resp *abilities,
+			     struct i40e_asq_cmd_details *cmd_details)
 {
-	struct i40e_aq_desc desc;
-	i40e_status status;
 	u16 abilities_size = sizeof(struct i40e_aq_get_phy_abilities_resp);
 	u16 max_delay = I40E_MAX_PHY_TIMEOUT, total_delay = 0;
+	struct i40e_aq_desc desc;
+	int status;
 
 	if (!abilities)
 		return I40E_ERR_PARAM;
@@ -1530,14 +1384,14 @@ i40e_status i40e_aq_get_phy_capabilities(struct i40e_hw *hw,
  * of the PHY Config parameters. This status will be indicated by the
  * command response.
  **/
-enum i40e_status_code i40e_aq_set_phy_config(struct i40e_hw *hw,
-				struct i40e_aq_set_phy_config *config,
-				struct i40e_asq_cmd_details *cmd_details)
+int i40e_aq_set_phy_config(struct i40e_hw *hw,
+			   struct i40e_aq_set_phy_config *config,
+			   struct i40e_asq_cmd_details *cmd_details)
 {
 	struct i40e_aq_desc desc;
 	struct i40e_aq_set_phy_config *cmd =
 			(struct i40e_aq_set_phy_config *)&desc.params.raw;
-	enum i40e_status_code status;
+	int status;
 
 	if (!config)
 		return I40E_ERR_PARAM;
@@ -1552,7 +1406,7 @@ enum i40e_status_code i40e_aq_set_phy_config(struct i40e_hw *hw,
 	return status;
 }
 
-static noinline_for_stack enum i40e_status_code
+static noinline_for_stack int
 i40e_set_fc_status(struct i40e_hw *hw,
 		   struct i40e_aq_get_phy_abilities_resp *abilities,
 		   bool atomic_restart)
@@ -1610,11 +1464,11 @@ i40e_set_fc_status(struct i40e_hw *hw,
  *
  * Set the requested flow control mode using set_phy_config.
  **/
-enum i40e_status_code i40e_set_fc(struct i40e_hw *hw, u8 *aq_failures,
-				  bool atomic_restart)
+int i40e_set_fc(struct i40e_hw *hw, u8 *aq_failures,
+		bool atomic_restart)
 {
 	struct i40e_aq_get_phy_abilities_resp abilities;
-	enum i40e_status_code status;
+	int status;
 
 	*aq_failures = 0x0;
 
@@ -1653,13 +1507,13 @@ enum i40e_status_code i40e_set_fc(struct i40e_hw *hw, u8 *aq_failures,
  *
  * Tell the firmware that the driver is taking over from PXE
  **/
-i40e_status i40e_aq_clear_pxe_mode(struct i40e_hw *hw,
-				struct i40e_asq_cmd_details *cmd_details)
+int i40e_aq_clear_pxe_mode(struct i40e_hw *hw,
+			   struct i40e_asq_cmd_details *cmd_details)
 {
-	i40e_status status;
 	struct i40e_aq_desc desc;
 	struct i40e_aqc_clear_pxe *cmd =
 		(struct i40e_aqc_clear_pxe *)&desc.params.raw;
+	int status;
 
 	i40e_fill_default_direct_cmd_desc(&desc,
 					  i40e_aqc_opc_clear_pxe_mode);
@@ -1681,14 +1535,14 @@ i40e_status i40e_aq_clear_pxe_mode(struct i40e_hw *hw,
  *
  * Sets up the link and restarts the Auto-Negotiation over the link.
  **/
-i40e_status i40e_aq_set_link_restart_an(struct i40e_hw *hw,
-					bool enable_link,
-					struct i40e_asq_cmd_details *cmd_details)
+int i40e_aq_set_link_restart_an(struct i40e_hw *hw,
+				bool enable_link,
+				struct i40e_asq_cmd_details *cmd_details)
 {
 	struct i40e_aq_desc desc;
 	struct i40e_aqc_set_link_restart_an *cmd =
 		(struct i40e_aqc_set_link_restart_an *)&desc.params.raw;
-	i40e_status status;
+	int status;
 
 	i40e_fill_default_direct_cmd_desc(&desc,
 					  i40e_aqc_opc_set_link_restart_an);
@@ -1713,17 +1567,17 @@ i40e_status i40e_aq_set_link_restart_an(struct i40e_hw *hw,
  *
  * Returns the link status of the adapter.
  **/
-i40e_status i40e_aq_get_link_info(struct i40e_hw *hw,
-				bool enable_lse, struct i40e_link_status *link,
-				struct i40e_asq_cmd_details *cmd_details)
+int i40e_aq_get_link_info(struct i40e_hw *hw,
+			  bool enable_lse, struct i40e_link_status *link,
+			  struct i40e_asq_cmd_details *cmd_details)
 {
 	struct i40e_aq_desc desc;
 	struct i40e_aqc_get_link_status *resp =
 		(struct i40e_aqc_get_link_status *)&desc.params.raw;
 	struct i40e_link_status *hw_link_info = &hw->phy.link_info;
-	i40e_status status;
 	bool tx_pause, rx_pause;
 	u16 command_flags;
+	int status;
 
 	i40e_fill_default_direct_cmd_desc(&desc, i40e_aqc_opc_get_link_status);
 
@@ -1809,14 +1663,14 @@ i40e_status i40e_aq_get_link_info(struct i40e_hw *hw,
  *
  * Set link interrupt mask.
  **/
-i40e_status i40e_aq_set_phy_int_mask(struct i40e_hw *hw,
-				     u16 mask,
-				     struct i40e_asq_cmd_details *cmd_details)
+int i40e_aq_set_phy_int_mask(struct i40e_hw *hw,
+			     u16 mask,
+			     struct i40e_asq_cmd_details *cmd_details)
 {
 	struct i40e_aq_desc desc;
 	struct i40e_aqc_set_phy_int_mask *cmd =
 		(struct i40e_aqc_set_phy_int_mask *)&desc.params.raw;
-	i40e_status status;
+	int status;
 
 	i40e_fill_default_direct_cmd_desc(&desc,
 					  i40e_aqc_opc_set_phy_int_mask);
@@ -1836,13 +1690,13 @@ i40e_status i40e_aq_set_phy_int_mask(struct i40e_hw *hw,
  *
  * Reset the external PHY.
  **/
-i40e_status i40e_aq_set_phy_debug(struct i40e_hw *hw, u8 cmd_flags,
-				  struct i40e_asq_cmd_details *cmd_details)
+int i40e_aq_set_phy_debug(struct i40e_hw *hw, u8 cmd_flags,
+			  struct i40e_asq_cmd_details *cmd_details)
 {
 	struct i40e_aq_desc desc;
 	struct i40e_aqc_set_phy_debug *cmd =
 		(struct i40e_aqc_set_phy_debug *)&desc.params.raw;
-	i40e_status status;
+	int status;
 
 	i40e_fill_default_direct_cmd_desc(&desc,
 					  i40e_aqc_opc_set_phy_debug);
@@ -1877,9 +1731,9 @@ static bool i40e_is_aq_api_ver_ge(struct i40e_adminq_info *aq, u16 maj,
  *
  * Add a VSI context to the hardware.
 **/
-i40e_status i40e_aq_add_vsi(struct i40e_hw *hw,
-				struct i40e_vsi_context *vsi_ctx,
-				struct i40e_asq_cmd_details *cmd_details)
+int i40e_aq_add_vsi(struct i40e_hw *hw,
+		    struct i40e_vsi_context *vsi_ctx,
+		    struct i40e_asq_cmd_details *cmd_details)
 {
 	struct i40e_aq_desc desc;
 	struct i40e_aqc_add_get_update_vsi *cmd =
@@ -1887,7 +1741,7 @@ i40e_status i40e_aq_add_vsi(struct i40e_hw *hw,
 	struct i40e_aqc_add_get_update_vsi_completion *resp =
 		(struct i40e_aqc_add_get_update_vsi_completion *)
 		&desc.params.raw;
-	i40e_status status;
+	int status;
 
 	i40e_fill_default_direct_cmd_desc(&desc,
 					  i40e_aqc_opc_add_vsi);
@@ -1920,15 +1774,15 @@ i40e_status i40e_aq_add_vsi(struct i40e_hw *hw,
  * @seid: vsi number
  * @cmd_details: pointer to command details structure or NULL
  **/
-i40e_status i40e_aq_set_default_vsi(struct i40e_hw *hw,
-				    u16 seid,
-				    struct i40e_asq_cmd_details *cmd_details)
+int i40e_aq_set_default_vsi(struct i40e_hw *hw,
+			    u16 seid,
+			    struct i40e_asq_cmd_details *cmd_details)
 {
 	struct i40e_aq_desc desc;
 	struct i40e_aqc_set_vsi_promiscuous_modes *cmd =
 		(struct i40e_aqc_set_vsi_promiscuous_modes *)
 		&desc.params.raw;
-	i40e_status status;
+	int status;
 
 	i40e_fill_default_direct_cmd_desc(&desc,
 					  i40e_aqc_opc_set_vsi_promiscuous_modes);
@@ -1948,15 +1802,15 @@ i40e_status i40e_aq_set_default_vsi(struct i40e_hw *hw,
  * @seid: vsi number
  * @cmd_details: pointer to command details structure or NULL
  **/
-i40e_status i40e_aq_clear_default_vsi(struct i40e_hw *hw,
-				      u16 seid,
-				      struct i40e_asq_cmd_details *cmd_details)
+int i40e_aq_clear_default_vsi(struct i40e_hw *hw,
+			      u16 seid,
+			      struct i40e_asq_cmd_details *cmd_details)
 {
 	struct i40e_aq_desc desc;
 	struct i40e_aqc_set_vsi_promiscuous_modes *cmd =
 		(struct i40e_aqc_set_vsi_promiscuous_modes *)
 		&desc.params.raw;
-	i40e_status status;
+	int status;
 
 	i40e_fill_default_direct_cmd_desc(&desc,
 					  i40e_aqc_opc_set_vsi_promiscuous_modes);
@@ -1978,16 +1832,16 @@ i40e_status i40e_aq_clear_default_vsi(struct i40e_hw *hw,
  * @cmd_details: pointer to command details structure or NULL
  * @rx_only_promisc: flag to decide if egress traffic gets mirrored in promisc
  **/
-i40e_status i40e_aq_set_vsi_unicast_promiscuous(struct i40e_hw *hw,
-				u16 seid, bool set,
-				struct i40e_asq_cmd_details *cmd_details,
-				bool rx_only_promisc)
+int i40e_aq_set_vsi_unicast_promiscuous(struct i40e_hw *hw,
+					u16 seid, bool set,
+					struct i40e_asq_cmd_details *cmd_details,
+					bool rx_only_promisc)
 {
 	struct i40e_aq_desc desc;
 	struct i40e_aqc_set_vsi_promiscuous_modes *cmd =
 		(struct i40e_aqc_set_vsi_promiscuous_modes *)&desc.params.raw;
-	i40e_status status;
 	u16 flags = 0;
+	int status;
 
 	i40e_fill_default_direct_cmd_desc(&desc,
 					i40e_aqc_opc_set_vsi_promiscuous_modes);
@@ -2018,14 +1872,15 @@ i40e_status i40e_aq_set_vsi_unicast_promiscuous(struct i40e_hw *hw,
  * @set: set multicast promiscuous enable/disable
  * @cmd_details: pointer to command details structure or NULL
  **/
-i40e_status i40e_aq_set_vsi_multicast_promiscuous(struct i40e_hw *hw,
-				u16 seid, bool set, struct i40e_asq_cmd_details *cmd_details)
+int i40e_aq_set_vsi_multicast_promiscuous(struct i40e_hw *hw,
+					  u16 seid, bool set,
+					  struct i40e_asq_cmd_details *cmd_details)
 {
 	struct i40e_aq_desc desc;
 	struct i40e_aqc_set_vsi_promiscuous_modes *cmd =
 		(struct i40e_aqc_set_vsi_promiscuous_modes *)&desc.params.raw;
-	i40e_status status;
 	u16 flags = 0;
+	int status;
 
 	i40e_fill_default_direct_cmd_desc(&desc,
 					i40e_aqc_opc_set_vsi_promiscuous_modes);
@@ -2051,16 +1906,16 @@ i40e_status i40e_aq_set_vsi_multicast_promiscuous(struct i40e_hw *hw,
  * @vid: The VLAN tag filter - capture any multicast packet with this VLAN tag
  * @cmd_details: pointer to command details structure or NULL
  **/
-enum i40e_status_code i40e_aq_set_vsi_mc_promisc_on_vlan(struct i40e_hw *hw,
-							 u16 seid, bool enable,
-							 u16 vid,
-				struct i40e_asq_cmd_details *cmd_details)
+int i40e_aq_set_vsi_mc_promisc_on_vlan(struct i40e_hw *hw,
+				       u16 seid, bool enable,
+				       u16 vid,
+				       struct i40e_asq_cmd_details *cmd_details)
 {
 	struct i40e_aq_desc desc;
 	struct i40e_aqc_set_vsi_promiscuous_modes *cmd =
 		(struct i40e_aqc_set_vsi_promiscuous_modes *)&desc.params.raw;
-	enum i40e_status_code status;
 	u16 flags = 0;
+	int status;
 
 	i40e_fill_default_direct_cmd_desc(&desc,
 					  i40e_aqc_opc_set_vsi_promiscuous_modes);
@@ -2086,16 +1941,16 @@ enum i40e_status_code i40e_aq_set_vsi_mc_promisc_on_vlan(struct i40e_hw *hw,
  * @vid: The VLAN tag filter - capture any unicast packet with this VLAN tag
  * @cmd_details: pointer to command details structure or NULL
  **/
-enum i40e_status_code i40e_aq_set_vsi_uc_promisc_on_vlan(struct i40e_hw *hw,
-							 u16 seid, bool enable,
-							 u16 vid,
-				struct i40e_asq_cmd_details *cmd_details)
+int i40e_aq_set_vsi_uc_promisc_on_vlan(struct i40e_hw *hw,
+				       u16 seid, bool enable,
+				       u16 vid,
+				       struct i40e_asq_cmd_details *cmd_details)
 {
 	struct i40e_aq_desc desc;
 	struct i40e_aqc_set_vsi_promiscuous_modes *cmd =
 		(struct i40e_aqc_set_vsi_promiscuous_modes *)&desc.params.raw;
-	enum i40e_status_code status;
 	u16 flags = 0;
+	int status;
 
 	i40e_fill_default_direct_cmd_desc(&desc,
 					  i40e_aqc_opc_set_vsi_promiscuous_modes);
@@ -2127,15 +1982,15 @@ enum i40e_status_code i40e_aq_set_vsi_uc_promisc_on_vlan(struct i40e_hw *hw,
  * @vid: The VLAN tag filter - capture any broadcast packet with this VLAN tag
  * @cmd_details: pointer to command details structure or NULL
  **/
-i40e_status i40e_aq_set_vsi_bc_promisc_on_vlan(struct i40e_hw *hw,
-				u16 seid, bool enable, u16 vid,
-				struct i40e_asq_cmd_details *cmd_details)
+int i40e_aq_set_vsi_bc_promisc_on_vlan(struct i40e_hw *hw,
+				       u16 seid, bool enable, u16 vid,
+				       struct i40e_asq_cmd_details *cmd_details)
 {
 	struct i40e_aq_desc desc;
 	struct i40e_aqc_set_vsi_promiscuous_modes *cmd =
 		(struct i40e_aqc_set_vsi_promiscuous_modes *)&desc.params.raw;
-	i40e_status status;
 	u16 flags = 0;
+	int status;
 
 	i40e_fill_default_direct_cmd_desc(&desc,
 					i40e_aqc_opc_set_vsi_promiscuous_modes);
@@ -2162,14 +2017,14 @@ i40e_status i40e_aq_set_vsi_bc_promisc_on_vlan(struct i40e_hw *hw,
  *
  * Set or clear the broadcast promiscuous flag (filter) for a given VSI.
  **/
-i40e_status i40e_aq_set_vsi_broadcast(struct i40e_hw *hw,
-				u16 seid, bool set_filter,
-				struct i40e_asq_cmd_details *cmd_details)
+int i40e_aq_set_vsi_broadcast(struct i40e_hw *hw,
+			      u16 seid, bool set_filter,
+			      struct i40e_asq_cmd_details *cmd_details)
 {
 	struct i40e_aq_desc desc;
 	struct i40e_aqc_set_vsi_promiscuous_modes *cmd =
 		(struct i40e_aqc_set_vsi_promiscuous_modes *)&desc.params.raw;
-	i40e_status status;
+	int status;
 
 	i40e_fill_default_direct_cmd_desc(&desc,
 					i40e_aqc_opc_set_vsi_promiscuous_modes);
@@ -2195,15 +2050,15 @@ i40e_status i40e_aq_set_vsi_broadcast(struct i40e_hw *hw,
  * @enable: set MAC L2 layer unicast promiscuous enable/disable for a given VLAN
  * @cmd_details: pointer to command details structure or NULL
  **/
-i40e_status i40e_aq_set_vsi_vlan_promisc(struct i40e_hw *hw,
-				       u16 seid, bool enable,
-				       struct i40e_asq_cmd_details *cmd_details)
+int i40e_aq_set_vsi_vlan_promisc(struct i40e_hw *hw,
+				 u16 seid, bool enable,
+				 struct i40e_asq_cmd_details *cmd_details)
 {
 	struct i40e_aq_desc desc;
 	struct i40e_aqc_set_vsi_promiscuous_modes *cmd =
 		(struct i40e_aqc_set_vsi_promiscuous_modes *)&desc.params.raw;
-	i40e_status status;
 	u16 flags = 0;
+	int status;
 
 	i40e_fill_default_direct_cmd_desc(&desc,
 					i40e_aqc_opc_set_vsi_promiscuous_modes);
@@ -2225,9 +2080,9 @@ i40e_status i40e_aq_set_vsi_vlan_promisc(struct i40e_hw *hw,
  * @vsi_ctx: pointer to a vsi context struct
  * @cmd_details: pointer to command details structure or NULL
  **/
-i40e_status i40e_aq_get_vsi_params(struct i40e_hw *hw,
-				struct i40e_vsi_context *vsi_ctx,
-				struct i40e_asq_cmd_details *cmd_details)
+int i40e_aq_get_vsi_params(struct i40e_hw *hw,
+			   struct i40e_vsi_context *vsi_ctx,
+			   struct i40e_asq_cmd_details *cmd_details)
 {
 	struct i40e_aq_desc desc;
 	struct i40e_aqc_add_get_update_vsi *cmd =
@@ -2235,7 +2090,7 @@ i40e_status i40e_aq_get_vsi_params(struct i40e_hw *hw,
 	struct i40e_aqc_add_get_update_vsi_completion *resp =
 		(struct i40e_aqc_add_get_update_vsi_completion *)
 		&desc.params.raw;
-	i40e_status status;
+	int status;
 
 	i40e_fill_default_direct_cmd_desc(&desc,
 					  i40e_aqc_opc_get_vsi_parameters);
@@ -2267,9 +2122,9 @@ i40e_status i40e_aq_get_vsi_params(struct i40e_hw *hw,
  *
  * Update a VSI context.
  **/
-i40e_status i40e_aq_update_vsi_params(struct i40e_hw *hw,
-				struct i40e_vsi_context *vsi_ctx,
-				struct i40e_asq_cmd_details *cmd_details)
+int i40e_aq_update_vsi_params(struct i40e_hw *hw,
+			      struct i40e_vsi_context *vsi_ctx,
+			      struct i40e_asq_cmd_details *cmd_details)
 {
 	struct i40e_aq_desc desc;
 	struct i40e_aqc_add_get_update_vsi *cmd =
@@ -2277,7 +2132,7 @@ i40e_status i40e_aq_update_vsi_params(struct i40e_hw *hw,
 	struct i40e_aqc_add_get_update_vsi_completion *resp =
 		(struct i40e_aqc_add_get_update_vsi_completion *)
 		&desc.params.raw;
-	i40e_status status;
+	int status;
 
 	i40e_fill_default_direct_cmd_desc(&desc,
 					  i40e_aqc_opc_update_vsi_parameters);
@@ -2304,15 +2159,15 @@ i40e_status i40e_aq_update_vsi_params(struct i40e_hw *hw,
  *
  * Fill the buf with switch configuration returned from AdminQ command
  **/
-i40e_status i40e_aq_get_switch_config(struct i40e_hw *hw,
-				struct i40e_aqc_get_switch_config_resp *buf,
-				u16 buf_size, u16 *start_seid,
-				struct i40e_asq_cmd_details *cmd_details)
+int i40e_aq_get_switch_config(struct i40e_hw *hw,
+			      struct i40e_aqc_get_switch_config_resp *buf,
+			      u16 buf_size, u16 *start_seid,
+			      struct i40e_asq_cmd_details *cmd_details)
 {
 	struct i40e_aq_desc desc;
 	struct i40e_aqc_switch_seid *scfg =
 		(struct i40e_aqc_switch_seid *)&desc.params.raw;
-	i40e_status status;
+	int status;
 
 	i40e_fill_default_direct_cmd_desc(&desc,
 					  i40e_aqc_opc_get_switch_config);
@@ -2338,15 +2193,15 @@ i40e_status i40e_aq_get_switch_config(struct i40e_hw *hw,
  *
  * Set switch configuration bits
  **/
-enum i40e_status_code i40e_aq_set_switch_config(struct i40e_hw *hw,
-						u16 flags,
-						u16 valid_flags, u8 mode,
-				struct i40e_asq_cmd_details *cmd_details)
+int i40e_aq_set_switch_config(struct i40e_hw *hw,
+			      u16 flags,
+			      u16 valid_flags, u8 mode,
+			      struct i40e_asq_cmd_details *cmd_details)
 {
 	struct i40e_aq_desc desc;
 	struct i40e_aqc_set_switch_config *scfg =
 		(struct i40e_aqc_set_switch_config *)&desc.params.raw;
-	enum i40e_status_code status;
+	int status;
 
 	i40e_fill_default_direct_cmd_desc(&desc,
 					  i40e_aqc_opc_set_switch_config);
@@ -2375,16 +2230,16 @@ enum i40e_status_code i40e_aq_set_switch_config(struct i40e_hw *hw,
  *
  * Get the firmware version from the admin queue commands
  **/
-i40e_status i40e_aq_get_firmware_version(struct i40e_hw *hw,
-				u16 *fw_major_version, u16 *fw_minor_version,
-				u32 *fw_build,
-				u16 *api_major_version, u16 *api_minor_version,
-				struct i40e_asq_cmd_details *cmd_details)
+int i40e_aq_get_firmware_version(struct i40e_hw *hw,
+				 u16 *fw_major_version, u16 *fw_minor_version,
+				 u32 *fw_build,
+				 u16 *api_major_version, u16 *api_minor_version,
+				 struct i40e_asq_cmd_details *cmd_details)
 {
 	struct i40e_aq_desc desc;
 	struct i40e_aqc_get_version *resp =
 		(struct i40e_aqc_get_version *)&desc.params.raw;
-	i40e_status status;
+	int status;
 
 	i40e_fill_default_direct_cmd_desc(&desc, i40e_aqc_opc_get_version);
 
@@ -2414,14 +2269,14 @@ i40e_status i40e_aq_get_firmware_version(struct i40e_hw *hw,
  *
  * Send the driver version to the firmware
  **/
-i40e_status i40e_aq_send_driver_version(struct i40e_hw *hw,
+int i40e_aq_send_driver_version(struct i40e_hw *hw,
 				struct i40e_driver_version *dv,
 				struct i40e_asq_cmd_details *cmd_details)
 {
 	struct i40e_aq_desc desc;
 	struct i40e_aqc_driver_version *cmd =
 		(struct i40e_aqc_driver_version *)&desc.params.raw;
-	i40e_status status;
+	int status;
 	u16 len;
 
 	if (dv == NULL)
@@ -2456,9 +2311,9 @@ i40e_status i40e_aq_send_driver_version(struct i40e_hw *hw,
  *
  * Side effect: LinkStatusEvent reporting becomes enabled
  **/
-i40e_status i40e_get_link_status(struct i40e_hw *hw, bool *link_up)
+int i40e_get_link_status(struct i40e_hw *hw, bool *link_up)
 {
-	i40e_status status = 0;
+	int status = 0;
 
 	if (hw->phy.get_link_info) {
 		status = i40e_update_link_info(hw);
@@ -2477,10 +2332,10 @@ i40e_status i40e_get_link_status(struct i40e_hw *hw, bool *link_up)
  * i40e_update_link_info - update status of the HW network link
  * @hw: pointer to the hw struct
  **/
-noinline_for_stack i40e_status i40e_update_link_info(struct i40e_hw *hw)
+noinline_for_stack int i40e_update_link_info(struct i40e_hw *hw)
 {
 	struct i40e_aq_get_phy_abilities_resp abilities;
-	i40e_status status = 0;
+	int status = 0;
 
 	status = i40e_aq_get_link_info(hw, true, NULL, NULL);
 	if (status)
@@ -2527,19 +2382,19 @@ noinline_for_stack i40e_status i40e_update_link_info(struct i40e_hw *hw)
  * This asks the FW to add a VEB between the uplink and downlink
  * elements.  If the uplink SEID is 0, this will be a floating VEB.
  **/
-i40e_status i40e_aq_add_veb(struct i40e_hw *hw, u16 uplink_seid,
-				u16 downlink_seid, u8 enabled_tc,
-				bool default_port, u16 *veb_seid,
-				bool enable_stats,
-				struct i40e_asq_cmd_details *cmd_details)
+int i40e_aq_add_veb(struct i40e_hw *hw, u16 uplink_seid,
+		    u16 downlink_seid, u8 enabled_tc,
+		    bool default_port, u16 *veb_seid,
+		    bool enable_stats,
+		    struct i40e_asq_cmd_details *cmd_details)
 {
 	struct i40e_aq_desc desc;
 	struct i40e_aqc_add_veb *cmd =
 		(struct i40e_aqc_add_veb *)&desc.params.raw;
 	struct i40e_aqc_add_veb_completion *resp =
 		(struct i40e_aqc_add_veb_completion *)&desc.params.raw;
-	i40e_status status;
 	u16 veb_flags = 0;
+	int status;
 
 	/* SEIDs need to either both be set or both be 0 for floating VEB */
 	if (!!uplink_seid != !!downlink_seid)
@@ -2585,17 +2440,17 @@ i40e_status i40e_aq_add_veb(struct i40e_hw *hw, u16 uplink_seid,
  * This retrieves the parameters for a particular VEB, specified by
  * uplink_seid, and returns them to the caller.
  **/
-i40e_status i40e_aq_get_veb_parameters(struct i40e_hw *hw,
-				u16 veb_seid, u16 *switch_id,
-				bool *floating, u16 *statistic_index,
-				u16 *vebs_used, u16 *vebs_free,
-				struct i40e_asq_cmd_details *cmd_details)
+int i40e_aq_get_veb_parameters(struct i40e_hw *hw,
+			       u16 veb_seid, u16 *switch_id,
+			       bool *floating, u16 *statistic_index,
+			       u16 *vebs_used, u16 *vebs_free,
+			       struct i40e_asq_cmd_details *cmd_details)
 {
 	struct i40e_aq_desc desc;
 	struct i40e_aqc_get_veb_parameters_completion *cmd_resp =
 		(struct i40e_aqc_get_veb_parameters_completion *)
 		&desc.params.raw;
-	i40e_status status;
+	int status;
 
 	if (veb_seid == 0)
 		return I40E_ERR_PARAM;
@@ -2639,14 +2494,14 @@ i40e_status i40e_aq_get_veb_parameters(struct i40e_hw *hw,
  *
  * Add MAC/VLAN addresses to the HW filtering
  **/
-i40e_status i40e_aq_add_macvlan(struct i40e_hw *hw, u16 seid,
+int i40e_aq_add_macvlan(struct i40e_hw *hw, u16 seid,
 			struct i40e_aqc_add_macvlan_element_data *mv_list,
 			u16 count, struct i40e_asq_cmd_details *cmd_details)
 {
 	struct i40e_aq_desc desc;
 	struct i40e_aqc_macvlan *cmd =
 		(struct i40e_aqc_macvlan *)&desc.params.raw;
-	i40e_status status;
+	int status;
 	u16 buf_size;
 	int i;
 
@@ -2687,15 +2542,16 @@ i40e_status i40e_aq_add_macvlan(struct i40e_hw *hw, u16 seid,
  *
  * Remove MAC/VLAN addresses from the HW filtering
  **/
-i40e_status i40e_aq_remove_macvlan(struct i40e_hw *hw, u16 seid,
-			struct i40e_aqc_remove_macvlan_element_data *mv_list,
-			u16 count, struct i40e_asq_cmd_details *cmd_details)
+int
+i40e_aq_remove_macvlan(struct i40e_hw *hw, u16 seid,
+		       struct i40e_aqc_remove_macvlan_element_data *mv_list,
+		       u16 count, struct i40e_asq_cmd_details *cmd_details)
 {
 	struct i40e_aq_desc desc;
 	struct i40e_aqc_macvlan *cmd =
 		(struct i40e_aqc_macvlan *)&desc.params.raw;
-	i40e_status status;
 	u16 buf_size;
+	int status;
 
 	if (count == 0 || !mv_list || !hw)
 		return I40E_ERR_PARAM;
@@ -2736,19 +2592,19 @@ i40e_status i40e_aq_remove_macvlan(struct i40e_hw *hw, u16 seid,
  * Add/Delete a mirror rule to a specific switch. Mirror rules are supported for
  * VEBs/VEPA elements only
  **/
-static i40e_status i40e_mirrorrule_op(struct i40e_hw *hw,
-				u16 opcode, u16 sw_seid, u16 rule_type, u16 id,
-				u16 count, __le16 *mr_list,
-				struct i40e_asq_cmd_details *cmd_details,
-				u16 *rule_id, u16 *rules_used, u16 *rules_free)
+static int i40e_mirrorrule_op(struct i40e_hw *hw,
+			      u16 opcode, u16 sw_seid, u16 rule_type, u16 id,
+			      u16 count, __le16 *mr_list,
+			      struct i40e_asq_cmd_details *cmd_details,
+			      u16 *rule_id, u16 *rules_used, u16 *rules_free)
 {
 	struct i40e_aq_desc desc;
 	struct i40e_aqc_add_delete_mirror_rule *cmd =
 		(struct i40e_aqc_add_delete_mirror_rule *)&desc.params.raw;
 	struct i40e_aqc_add_delete_mirror_rule_completion *resp =
 	(struct i40e_aqc_add_delete_mirror_rule_completion *)&desc.params.raw;
-	i40e_status status;
 	u16 buf_size;
+	int status;
 
 	buf_size = count * sizeof(*mr_list);
 
@@ -2796,10 +2652,11 @@ static i40e_status i40e_mirrorrule_op(struct i40e_hw *hw,
  *
  * Add mirror rule. Mirror rules are supported for VEBs or VEPA elements only
  **/
-i40e_status i40e_aq_add_mirrorrule(struct i40e_hw *hw, u16 sw_seid,
-			u16 rule_type, u16 dest_vsi, u16 count, __le16 *mr_list,
-			struct i40e_asq_cmd_details *cmd_details,
-			u16 *rule_id, u16 *rules_used, u16 *rules_free)
+int i40e_aq_add_mirrorrule(struct i40e_hw *hw, u16 sw_seid,
+			   u16 rule_type, u16 dest_vsi, u16 count,
+			   __le16 *mr_list,
+			   struct i40e_asq_cmd_details *cmd_details,
+			   u16 *rule_id, u16 *rules_used, u16 *rules_free)
 {
 	if (!(rule_type == I40E_AQC_MIRROR_RULE_TYPE_ALL_INGRESS ||
 	    rule_type == I40E_AQC_MIRROR_RULE_TYPE_ALL_EGRESS)) {
@@ -2827,10 +2684,11 @@ i40e_status i40e_aq_add_mirrorrule(struct i40e_hw *hw, u16 sw_seid,
  *
  * Delete a mirror rule. Mirror rules are supported for VEBs/VEPA elements only
  **/
-i40e_status i40e_aq_delete_mirrorrule(struct i40e_hw *hw, u16 sw_seid,
-			u16 rule_type, u16 rule_id, u16 count, __le16 *mr_list,
-			struct i40e_asq_cmd_details *cmd_details,
-			u16 *rules_used, u16 *rules_free)
+int i40e_aq_delete_mirrorrule(struct i40e_hw *hw, u16 sw_seid,
+			      u16 rule_type, u16 rule_id, u16 count,
+			      __le16 *mr_list,
+			      struct i40e_asq_cmd_details *cmd_details,
+			      u16 *rules_used, u16 *rules_free)
 {
 	/* Rule ID has to be valid except rule_type: INGRESS VLAN mirroring */
 	if (rule_type == I40E_AQC_MIRROR_RULE_TYPE_VLAN) {
@@ -2859,14 +2717,14 @@ i40e_status i40e_aq_delete_mirrorrule(struct i40e_hw *hw, u16 sw_seid,
  *
  * send msg to vf
  **/
-i40e_status i40e_aq_send_msg_to_vf(struct i40e_hw *hw, u16 vfid,
-				u32 v_opcode, u32 v_retval, u8 *msg, u16 msglen,
-				struct i40e_asq_cmd_details *cmd_details)
+int i40e_aq_send_msg_to_vf(struct i40e_hw *hw, u16 vfid,
+			   u32 v_opcode, u32 v_retval, u8 *msg, u16 msglen,
+			   struct i40e_asq_cmd_details *cmd_details)
 {
 	struct i40e_aq_desc desc;
 	struct i40e_aqc_pf_vf_message *cmd =
 		(struct i40e_aqc_pf_vf_message *)&desc.params.raw;
-	i40e_status status;
+	int status;
 
 	i40e_fill_default_direct_cmd_desc(&desc, i40e_aqc_opc_send_msg_to_vf);
 	cmd->id = cpu_to_le32(vfid);
@@ -2894,14 +2752,14 @@ i40e_status i40e_aq_send_msg_to_vf(struct i40e_hw *hw, u16 vfid,
  *
  * Read the register using the admin queue commands
  **/
-i40e_status i40e_aq_debug_read_register(struct i40e_hw *hw,
+int i40e_aq_debug_read_register(struct i40e_hw *hw,
 				u32 reg_addr, u64 *reg_val,
 				struct i40e_asq_cmd_details *cmd_details)
 {
 	struct i40e_aq_desc desc;
 	struct i40e_aqc_debug_reg_read_write *cmd_resp =
 		(struct i40e_aqc_debug_reg_read_write *)&desc.params.raw;
-	i40e_status status;
+	int status;
 
 	if (reg_val == NULL)
 		return I40E_ERR_PARAM;
@@ -2929,14 +2787,14 @@ i40e_status i40e_aq_debug_read_register(struct i40e_hw *hw,
  *
  * Write to a register using the admin queue commands
  **/
-i40e_status i40e_aq_debug_write_register(struct i40e_hw *hw,
-					u32 reg_addr, u64 reg_val,
-					struct i40e_asq_cmd_details *cmd_details)
+int i40e_aq_debug_write_register(struct i40e_hw *hw,
+				 u32 reg_addr, u64 reg_val,
+				 struct i40e_asq_cmd_details *cmd_details)
 {
 	struct i40e_aq_desc desc;
 	struct i40e_aqc_debug_reg_read_write *cmd =
 		(struct i40e_aqc_debug_reg_read_write *)&desc.params.raw;
-	i40e_status status;
+	int status;
 
 	i40e_fill_default_direct_cmd_desc(&desc, i40e_aqc_opc_debug_write_reg);
 
@@ -2960,16 +2818,16 @@ i40e_status i40e_aq_debug_write_register(struct i40e_hw *hw,
  *
  * requests common resource using the admin queue commands
  **/
-i40e_status i40e_aq_request_resource(struct i40e_hw *hw,
-				enum i40e_aq_resources_ids resource,
-				enum i40e_aq_resource_access_type access,
-				u8 sdp_number, u64 *timeout,
-				struct i40e_asq_cmd_details *cmd_details)
+int i40e_aq_request_resource(struct i40e_hw *hw,
+			     enum i40e_aq_resources_ids resource,
+			     enum i40e_aq_resource_access_type access,
+			     u8 sdp_number, u64 *timeout,
+			     struct i40e_asq_cmd_details *cmd_details)
 {
 	struct i40e_aq_desc desc;
 	struct i40e_aqc_request_resource *cmd_resp =
 		(struct i40e_aqc_request_resource *)&desc.params.raw;
-	i40e_status status;
+	int status;
 
 	i40e_fill_default_direct_cmd_desc(&desc, i40e_aqc_opc_request_resource);
 
@@ -2999,15 +2857,15 @@ i40e_status i40e_aq_request_resource(struct i40e_hw *hw,
  *
  * release common resource using the admin queue commands
  **/
-i40e_status i40e_aq_release_resource(struct i40e_hw *hw,
-				enum i40e_aq_resources_ids resource,
-				u8 sdp_number,
-				struct i40e_asq_cmd_details *cmd_details)
+int i40e_aq_release_resource(struct i40e_hw *hw,
+			     enum i40e_aq_resources_ids resource,
+			     u8 sdp_number,
+			     struct i40e_asq_cmd_details *cmd_details)
 {
 	struct i40e_aq_desc desc;
 	struct i40e_aqc_request_resource *cmd =
 		(struct i40e_aqc_request_resource *)&desc.params.raw;
-	i40e_status status;
+	int status;
 
 	i40e_fill_default_direct_cmd_desc(&desc, i40e_aqc_opc_release_resource);
 
@@ -3031,15 +2889,15 @@ i40e_status i40e_aq_release_resource(struct i40e_hw *hw,
  *
  * Read the NVM using the admin queue commands
  **/
-i40e_status i40e_aq_read_nvm(struct i40e_hw *hw, u8 module_pointer,
-				u32 offset, u16 length, void *data,
-				bool last_command,
-				struct i40e_asq_cmd_details *cmd_details)
+int i40e_aq_read_nvm(struct i40e_hw *hw, u8 module_pointer,
+		     u32 offset, u16 length, void *data,
+		     bool last_command,
+		     struct i40e_asq_cmd_details *cmd_details)
 {
 	struct i40e_aq_desc desc;
 	struct i40e_aqc_nvm_update *cmd =
 		(struct i40e_aqc_nvm_update *)&desc.params.raw;
-	i40e_status status;
+	int status;
 
 	/* In offset the highest byte must be zeroed. */
 	if (offset & 0xFF000000) {
@@ -3077,14 +2935,14 @@ i40e_status i40e_aq_read_nvm(struct i40e_hw *hw, u8 module_pointer,
  *
  * Erase the NVM sector using the admin queue commands
  **/
-i40e_status i40e_aq_erase_nvm(struct i40e_hw *hw, u8 module_pointer,
-			      u32 offset, u16 length, bool last_command,
-			      struct i40e_asq_cmd_details *cmd_details)
+int i40e_aq_erase_nvm(struct i40e_hw *hw, u8 module_pointer,
+		      u32 offset, u16 length, bool last_command,
+		      struct i40e_asq_cmd_details *cmd_details)
 {
 	struct i40e_aq_desc desc;
 	struct i40e_aqc_nvm_update *cmd =
 		(struct i40e_aqc_nvm_update *)&desc.params.raw;
-	i40e_status status;
+	int status;
 
 	/* In offset the highest byte must be zeroed. */
 	if (offset & 0xFF000000) {
@@ -3125,8 +2983,8 @@ static void i40e_parse_discover_capabilities(struct i40e_hw *hw, void *buff,
 	u32 number, logical_id, phys_id;
 	struct i40e_hw_capabilities *p;
 	u16 id, ocp_cfg_word0;
-	i40e_status status;
 	u8 major_rev;
+	int status;
 	u32 i = 0;
 
 	cap = (struct i40e_aqc_list_capabilities_element_resp *) buff;
@@ -3367,14 +3225,14 @@ static void i40e_parse_discover_capabilities(struct i40e_hw *hw, void *buff,
  *
  * Get the device capabilities descriptions from the firmware
  **/
-i40e_status i40e_aq_discover_capabilities(struct i40e_hw *hw,
-				void *buff, u16 buff_size, u16 *data_size,
-				enum i40e_admin_queue_opc list_type_opc,
-				struct i40e_asq_cmd_details *cmd_details)
+int i40e_aq_discover_capabilities(struct i40e_hw *hw,
+				  void *buff, u16 buff_size, u16 *data_size,
+				  enum i40e_admin_queue_opc list_type_opc,
+				  struct i40e_asq_cmd_details *cmd_details)
 {
 	struct i40e_aqc_list_capabilites *cmd;
 	struct i40e_aq_desc desc;
-	i40e_status status = 0;
+	int status = 0;
 
 	cmd = (struct i40e_aqc_list_capabilites *)&desc.params.raw;
 
@@ -3416,15 +3274,15 @@ i40e_status i40e_aq_discover_capabilities(struct i40e_hw *hw,
  *
  * Update the NVM using the admin queue commands
  **/
-i40e_status i40e_aq_update_nvm(struct i40e_hw *hw, u8 module_pointer,
-			       u32 offset, u16 length, void *data,
-				bool last_command, u8 preservation_flags,
-			       struct i40e_asq_cmd_details *cmd_details)
+int i40e_aq_update_nvm(struct i40e_hw *hw, u8 module_pointer,
+		       u32 offset, u16 length, void *data,
+		       bool last_command, u8 preservation_flags,
+		       struct i40e_asq_cmd_details *cmd_details)
 {
 	struct i40e_aq_desc desc;
 	struct i40e_aqc_nvm_update *cmd =
 		(struct i40e_aqc_nvm_update *)&desc.params.raw;
-	i40e_status status;
+	int status;
 
 	/* In offset the highest byte must be zeroed. */
 	if (offset & 0xFF000000) {
@@ -3469,13 +3327,13 @@ i40e_status i40e_aq_update_nvm(struct i40e_hw *hw, u8 module_pointer,
  *
  * Rearrange NVM structure, available only for transition FW
  **/
-i40e_status i40e_aq_rearrange_nvm(struct i40e_hw *hw,
-				  u8 rearrange_nvm,
-				  struct i40e_asq_cmd_details *cmd_details)
+int i40e_aq_rearrange_nvm(struct i40e_hw *hw,
+			  u8 rearrange_nvm,
+			  struct i40e_asq_cmd_details *cmd_details)
 {
 	struct i40e_aqc_nvm_update *cmd;
-	i40e_status status;
 	struct i40e_aq_desc desc;
+	int status;
 
 	cmd = (struct i40e_aqc_nvm_update *)&desc.params.raw;
 
@@ -3509,17 +3367,17 @@ i40e_status i40e_aq_rearrange_nvm(struct i40e_hw *hw,
  *
  * Requests the complete LLDP MIB (entire packet).
  **/
-i40e_status i40e_aq_get_lldp_mib(struct i40e_hw *hw, u8 bridge_type,
-				u8 mib_type, void *buff, u16 buff_size,
-				u16 *local_len, u16 *remote_len,
-				struct i40e_asq_cmd_details *cmd_details)
+int i40e_aq_get_lldp_mib(struct i40e_hw *hw, u8 bridge_type,
+			 u8 mib_type, void *buff, u16 buff_size,
+			 u16 *local_len, u16 *remote_len,
+			 struct i40e_asq_cmd_details *cmd_details)
 {
 	struct i40e_aq_desc desc;
 	struct i40e_aqc_lldp_get_mib *cmd =
 		(struct i40e_aqc_lldp_get_mib *)&desc.params.raw;
 	struct i40e_aqc_lldp_get_mib *resp =
 		(struct i40e_aqc_lldp_get_mib *)&desc.params.raw;
-	i40e_status status;
+	int status;
 
 	if (buff_size == 0 || !buff)
 		return I40E_ERR_PARAM;
@@ -3559,14 +3417,14 @@ i40e_status i40e_aq_get_lldp_mib(struct i40e_hw *hw, u8 bridge_type,
  *
  * Set the LLDP MIB.
  **/
-enum i40e_status_code
+int
 i40e_aq_set_lldp_mib(struct i40e_hw *hw,
 		     u8 mib_type, void *buff, u16 buff_size,
 		     struct i40e_asq_cmd_details *cmd_details)
 {
 	struct i40e_aqc_lldp_set_local_mib *cmd;
-	enum i40e_status_code status;
 	struct i40e_aq_desc desc;
+	int status;
 
 	cmd = (struct i40e_aqc_lldp_set_local_mib *)&desc.params.raw;
 	if (buff_size == 0 || !buff)
@@ -3598,14 +3456,14 @@ i40e_aq_set_lldp_mib(struct i40e_hw *hw,
  * Enable or Disable posting of an event on ARQ when LLDP MIB
  * associated with the interface changes
  **/
-i40e_status i40e_aq_cfg_lldp_mib_change_event(struct i40e_hw *hw,
-				bool enable_update,
-				struct i40e_asq_cmd_details *cmd_details)
+int i40e_aq_cfg_lldp_mib_change_event(struct i40e_hw *hw,
+				      bool enable_update,
+				      struct i40e_asq_cmd_details *cmd_details)
 {
 	struct i40e_aq_desc desc;
 	struct i40e_aqc_lldp_update_mib *cmd =
 		(struct i40e_aqc_lldp_update_mib *)&desc.params.raw;
-	i40e_status status;
+	int status;
 
 	i40e_fill_default_direct_cmd_desc(&desc, i40e_aqc_opc_lldp_update_mib);
 
@@ -3627,14 +3485,14 @@ i40e_status i40e_aq_cfg_lldp_mib_change_event(struct i40e_hw *hw,
  * Restore LLDP Agent factory settings if @restore set to True. In other case
  * only returns factory setting in AQ response.
  **/
-enum i40e_status_code
+int
 i40e_aq_restore_lldp(struct i40e_hw *hw, u8 *setting, bool restore,
 		     struct i40e_asq_cmd_details *cmd_details)
 {
 	struct i40e_aq_desc desc;
 	struct i40e_aqc_lldp_restore *cmd =
 		(struct i40e_aqc_lldp_restore *)&desc.params.raw;
-	i40e_status status;
+	int status;
 
 	if (!(hw->flags & I40E_HW_FLAG_FW_LLDP_PERSISTENT)) {
 		i40e_debug(hw, I40E_DEBUG_ALL,
@@ -3664,14 +3522,14 @@ i40e_aq_restore_lldp(struct i40e_hw *hw, u8 *setting, bool restore,
  *
  * Stop or Shutdown the embedded LLDP Agent
  **/
-i40e_status i40e_aq_stop_lldp(struct i40e_hw *hw, bool shutdown_agent,
-				bool persist,
-				struct i40e_asq_cmd_details *cmd_details)
+int i40e_aq_stop_lldp(struct i40e_hw *hw, bool shutdown_agent,
+		      bool persist,
+		      struct i40e_asq_cmd_details *cmd_details)
 {
 	struct i40e_aq_desc desc;
 	struct i40e_aqc_lldp_stop *cmd =
 		(struct i40e_aqc_lldp_stop *)&desc.params.raw;
-	i40e_status status;
+	int status;
 
 	i40e_fill_default_direct_cmd_desc(&desc, i40e_aqc_opc_lldp_stop);
 
@@ -3699,13 +3557,13 @@ i40e_status i40e_aq_stop_lldp(struct i40e_hw *hw, bool shutdown_agent,
  *
  * Start the embedded LLDP Agent on all ports.
  **/
-i40e_status i40e_aq_start_lldp(struct i40e_hw *hw, bool persist,
-			       struct i40e_asq_cmd_details *cmd_details)
+int i40e_aq_start_lldp(struct i40e_hw *hw, bool persist,
+		       struct i40e_asq_cmd_details *cmd_details)
 {
 	struct i40e_aq_desc desc;
 	struct i40e_aqc_lldp_start *cmd =
 		(struct i40e_aqc_lldp_start *)&desc.params.raw;
-	i40e_status status;
+	int status;
 
 	i40e_fill_default_direct_cmd_desc(&desc, i40e_aqc_opc_lldp_start);
 
@@ -3731,14 +3589,14 @@ i40e_status i40e_aq_start_lldp(struct i40e_hw *hw, bool persist,
  * @dcb_enable: True if DCB configuration needs to be applied
  *
  **/
-enum i40e_status_code
+int
 i40e_aq_set_dcb_parameters(struct i40e_hw *hw, bool dcb_enable,
 			   struct i40e_asq_cmd_details *cmd_details)
 {
 	struct i40e_aq_desc desc;
 	struct i40e_aqc_set_dcb_parameters *cmd =
 		(struct i40e_aqc_set_dcb_parameters *)&desc.params.raw;
-	i40e_status status;
+	int status;
 
 	if (!(hw->flags & I40E_HW_FLAG_FW_LLDP_STOPPABLE))
 		return I40E_ERR_DEVICE_NOT_SUPPORTED;
@@ -3764,12 +3622,12 @@ i40e_aq_set_dcb_parameters(struct i40e_hw *hw, bool dcb_enable,
  *
  * Get CEE DCBX mode operational configuration from firmware
  **/
-i40e_status i40e_aq_get_cee_dcb_config(struct i40e_hw *hw,
-				       void *buff, u16 buff_size,
-				       struct i40e_asq_cmd_details *cmd_details)
+int i40e_aq_get_cee_dcb_config(struct i40e_hw *hw,
+			       void *buff, u16 buff_size,
+			       struct i40e_asq_cmd_details *cmd_details)
 {
 	struct i40e_aq_desc desc;
-	i40e_status status;
+	int status;
 
 	if (buff_size == 0 || !buff)
 		return I40E_ERR_PARAM;
@@ -3795,17 +3653,17 @@ i40e_status i40e_aq_get_cee_dcb_config(struct i40e_hw *hw,
  * and this function will call cpu_to_le16 to convert from Host byte order to
  * Little Endian order.
  **/
-i40e_status i40e_aq_add_udp_tunnel(struct i40e_hw *hw,
-				u16 udp_port, u8 protocol_index,
-				u8 *filter_index,
-				struct i40e_asq_cmd_details *cmd_details)
+int i40e_aq_add_udp_tunnel(struct i40e_hw *hw,
+			   u16 udp_port, u8 protocol_index,
+			   u8 *filter_index,
+			   struct i40e_asq_cmd_details *cmd_details)
 {
 	struct i40e_aq_desc desc;
 	struct i40e_aqc_add_udp_tunnel *cmd =
 		(struct i40e_aqc_add_udp_tunnel *)&desc.params.raw;
 	struct i40e_aqc_del_udp_tunnel_completion *resp =
 		(struct i40e_aqc_del_udp_tunnel_completion *)&desc.params.raw;
-	i40e_status status;
+	int status;
 
 	i40e_fill_default_direct_cmd_desc(&desc, i40e_aqc_opc_add_udp_tunnel);
 
@@ -3826,13 +3684,13 @@ i40e_status i40e_aq_add_udp_tunnel(struct i40e_hw *hw,
  * @index: filter index
  * @cmd_details: pointer to command details structure or NULL
  **/
-i40e_status i40e_aq_del_udp_tunnel(struct i40e_hw *hw, u8 index,
-				struct i40e_asq_cmd_details *cmd_details)
+int i40e_aq_del_udp_tunnel(struct i40e_hw *hw, u8 index,
+			   struct i40e_asq_cmd_details *cmd_details)
 {
 	struct i40e_aq_desc desc;
 	struct i40e_aqc_remove_udp_tunnel *cmd =
 		(struct i40e_aqc_remove_udp_tunnel *)&desc.params.raw;
-	i40e_status status;
+	int status;
 
 	i40e_fill_default_direct_cmd_desc(&desc, i40e_aqc_opc_del_udp_tunnel);
 
@@ -3851,13 +3709,13 @@ i40e_status i40e_aq_del_udp_tunnel(struct i40e_hw *hw, u8 index,
  *
  * This deletes a switch element from the switch.
  **/
-i40e_status i40e_aq_delete_element(struct i40e_hw *hw, u16 seid,
-				struct i40e_asq_cmd_details *cmd_details)
+int i40e_aq_delete_element(struct i40e_hw *hw, u16 seid,
+			   struct i40e_asq_cmd_details *cmd_details)
 {
 	struct i40e_aq_desc desc;
 	struct i40e_aqc_switch_seid *cmd =
 		(struct i40e_aqc_switch_seid *)&desc.params.raw;
-	i40e_status status;
+	int status;
 
 	if (seid == 0)
 		return I40E_ERR_PARAM;
@@ -3880,11 +3738,11 @@ i40e_status i40e_aq_delete_element(struct i40e_hw *hw, u16 seid,
  * recomputed and modified. The retval field in the descriptor
  * will be set to 0 when RPB is modified.
  **/
-i40e_status i40e_aq_dcb_updated(struct i40e_hw *hw,
-				struct i40e_asq_cmd_details *cmd_details)
+int i40e_aq_dcb_updated(struct i40e_hw *hw,
+			struct i40e_asq_cmd_details *cmd_details)
 {
 	struct i40e_aq_desc desc;
-	i40e_status status;
+	int status;
 
 	i40e_fill_default_direct_cmd_desc(&desc, i40e_aqc_opc_dcb_updated);
 
@@ -3904,15 +3762,15 @@ i40e_status i40e_aq_dcb_updated(struct i40e_hw *hw,
  *
  * Generic command handler for Tx scheduler AQ commands
  **/
-static i40e_status i40e_aq_tx_sched_cmd(struct i40e_hw *hw, u16 seid,
+static int i40e_aq_tx_sched_cmd(struct i40e_hw *hw, u16 seid,
 				void *buff, u16 buff_size,
-				 enum i40e_admin_queue_opc opcode,
+				enum i40e_admin_queue_opc opcode,
 				struct i40e_asq_cmd_details *cmd_details)
 {
 	struct i40e_aq_desc desc;
 	struct i40e_aqc_tx_sched_ind *cmd =
 		(struct i40e_aqc_tx_sched_ind *)&desc.params.raw;
-	i40e_status status;
+	int status;
 	bool cmd_param_flag = false;
 
 	switch (opcode) {
@@ -3962,14 +3820,14 @@ static i40e_status i40e_aq_tx_sched_cmd(struct i40e_hw *hw, u16 seid,
  * @max_credit: Max BW limit credits
  * @cmd_details: pointer to command details structure or NULL
  **/
-i40e_status i40e_aq_config_vsi_bw_limit(struct i40e_hw *hw,
+int i40e_aq_config_vsi_bw_limit(struct i40e_hw *hw,
 				u16 seid, u16 credit, u8 max_credit,
 				struct i40e_asq_cmd_details *cmd_details)
 {
 	struct i40e_aq_desc desc;
 	struct i40e_aqc_configure_vsi_bw_limit *cmd =
 		(struct i40e_aqc_configure_vsi_bw_limit *)&desc.params.raw;
-	i40e_status status;
+	int status;
 
 	i40e_fill_default_direct_cmd_desc(&desc,
 					  i40e_aqc_opc_configure_vsi_bw_limit);
@@ -3990,10 +3848,10 @@ i40e_status i40e_aq_config_vsi_bw_limit(struct i40e_hw *hw,
  * @bw_data: Buffer holding enabled TCs, relative TC BW limit/credits
  * @cmd_details: pointer to command details structure or NULL
  **/
-i40e_status i40e_aq_config_vsi_tc_bw(struct i40e_hw *hw,
-			u16 seid,
-			struct i40e_aqc_configure_vsi_tc_bw_data *bw_data,
-			struct i40e_asq_cmd_details *cmd_details)
+int i40e_aq_config_vsi_tc_bw(struct i40e_hw *hw,
+			     u16 seid,
+			     struct i40e_aqc_configure_vsi_tc_bw_data *bw_data,
+			     struct i40e_asq_cmd_details *cmd_details)
 {
 	return i40e_aq_tx_sched_cmd(hw, seid, (void *)bw_data, sizeof(*bw_data),
 				    i40e_aqc_opc_configure_vsi_tc_bw,
@@ -4008,11 +3866,12 @@ i40e_status i40e_aq_config_vsi_tc_bw(struct i40e_hw *hw,
  * @opcode: Tx scheduler AQ command opcode
  * @cmd_details: pointer to command details structure or NULL
  **/
-i40e_status i40e_aq_config_switch_comp_ets(struct i40e_hw *hw,
-		u16 seid,
-		struct i40e_aqc_configure_switching_comp_ets_data *ets_data,
-		enum i40e_admin_queue_opc opcode,
-		struct i40e_asq_cmd_details *cmd_details)
+int
+i40e_aq_config_switch_comp_ets(struct i40e_hw *hw,
+			       u16 seid,
+			       struct i40e_aqc_configure_switching_comp_ets_data *ets_data,
+			       enum i40e_admin_queue_opc opcode,
+			       struct i40e_asq_cmd_details *cmd_details)
 {
 	return i40e_aq_tx_sched_cmd(hw, seid, (void *)ets_data,
 				    sizeof(*ets_data), opcode, cmd_details);
@@ -4025,7 +3884,8 @@ i40e_status i40e_aq_config_switch_comp_ets(struct i40e_hw *hw,
  * @bw_data: Buffer holding enabled TCs, relative/absolute TC BW limit/credits
  * @cmd_details: pointer to command details structure or NULL
  **/
-i40e_status i40e_aq_config_switch_comp_bw_config(struct i40e_hw *hw,
+int
+i40e_aq_config_switch_comp_bw_config(struct i40e_hw *hw,
 	u16 seid,
 	struct i40e_aqc_configure_switching_comp_bw_config_data *bw_data,
 	struct i40e_asq_cmd_details *cmd_details)
@@ -4042,10 +3902,11 @@ i40e_status i40e_aq_config_switch_comp_bw_config(struct i40e_hw *hw,
  * @bw_data: Buffer to hold VSI BW configuration
  * @cmd_details: pointer to command details structure or NULL
  **/
-i40e_status i40e_aq_query_vsi_bw_config(struct i40e_hw *hw,
-			u16 seid,
-			struct i40e_aqc_query_vsi_bw_config_resp *bw_data,
-			struct i40e_asq_cmd_details *cmd_details)
+int
+i40e_aq_query_vsi_bw_config(struct i40e_hw *hw,
+			    u16 seid,
+			    struct i40e_aqc_query_vsi_bw_config_resp *bw_data,
+			    struct i40e_asq_cmd_details *cmd_details)
 {
 	return i40e_aq_tx_sched_cmd(hw, seid, (void *)bw_data, sizeof(*bw_data),
 				    i40e_aqc_opc_query_vsi_bw_config,
@@ -4059,10 +3920,11 @@ i40e_status i40e_aq_query_vsi_bw_config(struct i40e_hw *hw,
  * @bw_data: Buffer to hold VSI BW configuration per TC
  * @cmd_details: pointer to command details structure or NULL
  **/
-i40e_status i40e_aq_query_vsi_ets_sla_config(struct i40e_hw *hw,
-			u16 seid,
-			struct i40e_aqc_query_vsi_ets_sla_config_resp *bw_data,
-			struct i40e_asq_cmd_details *cmd_details)
+int
+i40e_aq_query_vsi_ets_sla_config(struct i40e_hw *hw,
+				 u16 seid,
+				 struct i40e_aqc_query_vsi_ets_sla_config_resp *bw_data,
+				 struct i40e_asq_cmd_details *cmd_details)
 {
 	return i40e_aq_tx_sched_cmd(hw, seid, (void *)bw_data, sizeof(*bw_data),
 				    i40e_aqc_opc_query_vsi_ets_sla_config,
@@ -4076,10 +3938,11 @@ i40e_status i40e_aq_query_vsi_ets_sla_config(struct i40e_hw *hw,
  * @bw_data: Buffer to hold switching component's per TC BW config
  * @cmd_details: pointer to command details structure or NULL
  **/
-i40e_status i40e_aq_query_switch_comp_ets_config(struct i40e_hw *hw,
-		u16 seid,
-		struct i40e_aqc_query_switching_comp_ets_config_resp *bw_data,
-		struct i40e_asq_cmd_details *cmd_details)
+int
+i40e_aq_query_switch_comp_ets_config(struct i40e_hw *hw,
+				     u16 seid,
+				     struct i40e_aqc_query_switching_comp_ets_config_resp *bw_data,
+				     struct i40e_asq_cmd_details *cmd_details)
 {
 	return i40e_aq_tx_sched_cmd(hw, seid, (void *)bw_data, sizeof(*bw_data),
 				   i40e_aqc_opc_query_switching_comp_ets_config,
@@ -4093,10 +3956,11 @@ i40e_status i40e_aq_query_switch_comp_ets_config(struct i40e_hw *hw,
  * @bw_data: Buffer to hold current ETS configuration for the Physical Port
  * @cmd_details: pointer to command details structure or NULL
  **/
-i40e_status i40e_aq_query_port_ets_config(struct i40e_hw *hw,
-			u16 seid,
-			struct i40e_aqc_query_port_ets_config_resp *bw_data,
-			struct i40e_asq_cmd_details *cmd_details)
+int
+i40e_aq_query_port_ets_config(struct i40e_hw *hw,
+			      u16 seid,
+			      struct i40e_aqc_query_port_ets_config_resp *bw_data,
+			      struct i40e_asq_cmd_details *cmd_details)
 {
 	return i40e_aq_tx_sched_cmd(hw, seid, (void *)bw_data, sizeof(*bw_data),
 				    i40e_aqc_opc_query_port_ets_config,
@@ -4110,10 +3974,11 @@ i40e_status i40e_aq_query_port_ets_config(struct i40e_hw *hw,
  * @bw_data: Buffer to hold switching component's BW configuration
  * @cmd_details: pointer to command details structure or NULL
  **/
-i40e_status i40e_aq_query_switch_comp_bw_config(struct i40e_hw *hw,
-		u16 seid,
-		struct i40e_aqc_query_switching_comp_bw_config_resp *bw_data,
-		struct i40e_asq_cmd_details *cmd_details)
+int
+i40e_aq_query_switch_comp_bw_config(struct i40e_hw *hw,
+				    u16 seid,
+				    struct i40e_aqc_query_switching_comp_bw_config_resp *bw_data,
+				    struct i40e_asq_cmd_details *cmd_details)
 {
 	return i40e_aq_tx_sched_cmd(hw, seid, (void *)bw_data, sizeof(*bw_data),
 				    i40e_aqc_opc_query_switching_comp_bw_config,
@@ -4132,8 +3997,9 @@ i40e_status i40e_aq_query_switch_comp_bw_config(struct i40e_hw *hw,
  * Returns 0 if the values passed are valid and within
  * range else returns an error.
  **/
-static i40e_status i40e_validate_filter_settings(struct i40e_hw *hw,
-				struct i40e_filter_control_settings *settings)
+static int
+i40e_validate_filter_settings(struct i40e_hw *hw,
+			      struct i40e_filter_control_settings *settings)
 {
 	u32 fcoe_cntx_size, fcoe_filt_size;
 	u32 pe_cntx_size, pe_filt_size;
@@ -4224,11 +4090,11 @@ static i40e_status i40e_validate_filter_settings(struct i40e_hw *hw,
  * for a single PF. It is expected that these settings are programmed
  * at the driver initialization time.
  **/
-i40e_status i40e_set_filter_control(struct i40e_hw *hw,
-				struct i40e_filter_control_settings *settings)
+int i40e_set_filter_control(struct i40e_hw *hw,
+			    struct i40e_filter_control_settings *settings)
 {
-	i40e_status ret = 0;
 	u32 hash_lut_size = 0;
+	int ret = 0;
 	u32 val;
 
 	if (!settings)
@@ -4298,11 +4164,11 @@ i40e_status i40e_set_filter_control(struct i40e_hw *hw,
  * In return it will update the total number of perfect filter count in
  * the stats member.
  **/
-i40e_status i40e_aq_add_rem_control_packet_filter(struct i40e_hw *hw,
-				u8 *mac_addr, u16 ethtype, u16 flags,
-				u16 vsi_seid, u16 queue, bool is_add,
-				struct i40e_control_filter_stats *stats,
-				struct i40e_asq_cmd_details *cmd_details)
+int i40e_aq_add_rem_control_packet_filter(struct i40e_hw *hw,
+					  u8 *mac_addr, u16 ethtype, u16 flags,
+					  u16 vsi_seid, u16 queue, bool is_add,
+					  struct i40e_control_filter_stats *stats,
+					  struct i40e_asq_cmd_details *cmd_details)
 {
 	struct i40e_aq_desc desc;
 	struct i40e_aqc_add_remove_control_packet_filter *cmd =
@@ -4311,7 +4177,7 @@ i40e_status i40e_aq_add_rem_control_packet_filter(struct i40e_hw *hw,
 	struct i40e_aqc_add_remove_control_packet_filter_completion *resp =
 		(struct i40e_aqc_add_remove_control_packet_filter_completion *)
 		&desc.params.raw;
-	i40e_status status;
+	int status;
 
 	if (vsi_seid == 0)
 		return I40E_ERR_PARAM;
@@ -4357,7 +4223,7 @@ void i40e_add_filter_to_drop_tx_flow_control_frames(struct i40e_hw *hw,
 		   I40E_AQC_ADD_CONTROL_PACKET_FLAGS_DROP |
 		   I40E_AQC_ADD_CONTROL_PACKET_FLAGS_TX;
 	u16 ethtype = I40E_FLOW_CONTROL_ETHTYPE;
-	i40e_status status;
+	int status;
 
 	status = i40e_aq_add_rem_control_packet_filter(hw, NULL, ethtype, flag,
 						       seid, 0, true, NULL,
@@ -4379,14 +4245,14 @@ void i40e_add_filter_to_drop_tx_flow_control_frames(struct i40e_hw *hw,
  * is not passed then only register at 'reg_addr0' is read.
  *
  **/
-static i40e_status i40e_aq_alternate_read(struct i40e_hw *hw,
-					  u32 reg_addr0, u32 *reg_val0,
-					  u32 reg_addr1, u32 *reg_val1)
+static int i40e_aq_alternate_read(struct i40e_hw *hw,
+				  u32 reg_addr0, u32 *reg_val0,
+				  u32 reg_addr1, u32 *reg_val1)
 {
 	struct i40e_aq_desc desc;
 	struct i40e_aqc_alternate_write *cmd_resp =
 		(struct i40e_aqc_alternate_write *)&desc.params.raw;
-	i40e_status status;
+	int status;
 
 	if (!reg_val0)
 		return I40E_ERR_PARAM;
@@ -4415,12 +4281,12 @@ static i40e_status i40e_aq_alternate_read(struct i40e_hw *hw,
  *
  * Suspend port's Tx traffic
  **/
-i40e_status i40e_aq_suspend_port_tx(struct i40e_hw *hw, u16 seid,
-				    struct i40e_asq_cmd_details *cmd_details)
+int i40e_aq_suspend_port_tx(struct i40e_hw *hw, u16 seid,
+			    struct i40e_asq_cmd_details *cmd_details)
 {
 	struct i40e_aqc_tx_sched_ind *cmd;
 	struct i40e_aq_desc desc;
-	i40e_status status;
+	int status;
 
 	cmd = (struct i40e_aqc_tx_sched_ind *)&desc.params.raw;
 	i40e_fill_default_direct_cmd_desc(&desc, i40e_aqc_opc_suspend_port_tx);
@@ -4437,11 +4303,11 @@ i40e_status i40e_aq_suspend_port_tx(struct i40e_hw *hw, u16 seid,
  *
  * Resume port's Tx traffic
  **/
-i40e_status i40e_aq_resume_port_tx(struct i40e_hw *hw,
-				   struct i40e_asq_cmd_details *cmd_details)
+int i40e_aq_resume_port_tx(struct i40e_hw *hw,
+			   struct i40e_asq_cmd_details *cmd_details)
 {
 	struct i40e_aq_desc desc;
-	i40e_status status;
+	int status;
 
 	i40e_fill_default_direct_cmd_desc(&desc, i40e_aqc_opc_resume_port_tx);
 
@@ -4511,18 +4377,18 @@ void i40e_set_pci_config_data(struct i40e_hw *hw, u16 link_status)
  * Dump internal FW/HW data for debug purposes.
  *
  **/
-i40e_status i40e_aq_debug_dump(struct i40e_hw *hw, u8 cluster_id,
-			       u8 table_id, u32 start_index, u16 buff_size,
-			       void *buff, u16 *ret_buff_size,
-			       u8 *ret_next_table, u32 *ret_next_index,
-			       struct i40e_asq_cmd_details *cmd_details)
+int i40e_aq_debug_dump(struct i40e_hw *hw, u8 cluster_id,
+		       u8 table_id, u32 start_index, u16 buff_size,
+		       void *buff, u16 *ret_buff_size,
+		       u8 *ret_next_table, u32 *ret_next_index,
+		       struct i40e_asq_cmd_details *cmd_details)
 {
 	struct i40e_aq_desc desc;
 	struct i40e_aqc_debug_dump_internals *cmd =
 		(struct i40e_aqc_debug_dump_internals *)&desc.params.raw;
 	struct i40e_aqc_debug_dump_internals *resp =
 		(struct i40e_aqc_debug_dump_internals *)&desc.params.raw;
-	i40e_status status;
+	int status;
 
 	if (buff_size == 0 || !buff)
 		return I40E_ERR_PARAM;
@@ -4563,12 +4429,12 @@ i40e_status i40e_aq_debug_dump(struct i40e_hw *hw, u8 cluster_id,
  *
  * Read bw from the alternate ram for the given pf
  **/
-i40e_status i40e_read_bw_from_alt_ram(struct i40e_hw *hw,
-				      u32 *max_bw, u32 *min_bw,
-				      bool *min_valid, bool *max_valid)
+int i40e_read_bw_from_alt_ram(struct i40e_hw *hw,
+			      u32 *max_bw, u32 *min_bw,
+			      bool *min_valid, bool *max_valid)
 {
-	i40e_status status;
 	u32 max_bw_addr, min_bw_addr;
+	int status;
 
 	/* Calculate the address of the min/max bw registers */
 	max_bw_addr = I40E_ALT_STRUCT_FIRST_PF_OFFSET +
@@ -4603,13 +4469,14 @@ i40e_status i40e_read_bw_from_alt_ram(struct i40e_hw *hw,
  *
  * Configure partitions guaranteed/max bw
  **/
-i40e_status i40e_aq_configure_partition_bw(struct i40e_hw *hw,
-			struct i40e_aqc_configure_partition_bw_data *bw_data,
-			struct i40e_asq_cmd_details *cmd_details)
+int
+i40e_aq_configure_partition_bw(struct i40e_hw *hw,
+			       struct i40e_aqc_configure_partition_bw_data *bw_data,
+			       struct i40e_asq_cmd_details *cmd_details)
 {
-	i40e_status status;
-	struct i40e_aq_desc desc;
 	u16 bwd_size = sizeof(*bw_data);
+	struct i40e_aq_desc desc;
+	int status;
 
 	i40e_fill_default_direct_cmd_desc(&desc,
 					  i40e_aqc_opc_configure_partition_bw);
@@ -4638,11 +4505,11 @@ i40e_status i40e_aq_configure_partition_bw(struct i40e_hw *hw,
  *
  * Reads specified PHY register value
  **/
-i40e_status i40e_read_phy_register_clause22(struct i40e_hw *hw,
-					    u16 reg, u8 phy_addr, u16 *value)
+int i40e_read_phy_register_clause22(struct i40e_hw *hw,
+				    u16 reg, u8 phy_addr, u16 *value)
 {
-	i40e_status status = I40E_ERR_TIMEOUT;
 	u8 port_num = (u8)hw->func_caps.mdio_port_num;
+	int status = I40E_ERR_TIMEOUT;
 	u32 command = 0;
 	u16 retry = 1000;
 
@@ -4683,11 +4550,11 @@ i40e_status i40e_read_phy_register_clause22(struct i40e_hw *hw,
  *
  * Writes specified PHY register value
  **/
-i40e_status i40e_write_phy_register_clause22(struct i40e_hw *hw,
-					     u16 reg, u8 phy_addr, u16 value)
+int i40e_write_phy_register_clause22(struct i40e_hw *hw,
+				     u16 reg, u8 phy_addr, u16 value)
 {
-	i40e_status status = I40E_ERR_TIMEOUT;
 	u8 port_num = (u8)hw->func_caps.mdio_port_num;
+	int status = I40E_ERR_TIMEOUT;
 	u32 command  = 0;
 	u16 retry = 1000;
 
@@ -4724,13 +4591,13 @@ i40e_status i40e_write_phy_register_clause22(struct i40e_hw *hw,
  *
  * Reads specified PHY register value
  **/
-i40e_status i40e_read_phy_register_clause45(struct i40e_hw *hw,
-				u8 page, u16 reg, u8 phy_addr, u16 *value)
+int i40e_read_phy_register_clause45(struct i40e_hw *hw,
+				    u8 page, u16 reg, u8 phy_addr, u16 *value)
 {
-	i40e_status status = I40E_ERR_TIMEOUT;
+	u8 port_num = hw->func_caps.mdio_port_num;
+	int status = I40E_ERR_TIMEOUT;
 	u32 command = 0;
 	u16 retry = 1000;
-	u8 port_num = hw->func_caps.mdio_port_num;
 
 	command = (reg << I40E_GLGEN_MSCA_MDIADD_SHIFT) |
 		  (page << I40E_GLGEN_MSCA_DEVADD_SHIFT) |
@@ -4798,13 +4665,13 @@ i40e_status i40e_read_phy_register_clause45(struct i40e_hw *hw,
  *
  * Writes value to specified PHY register
  **/
-i40e_status i40e_write_phy_register_clause45(struct i40e_hw *hw,
-				u8 page, u16 reg, u8 phy_addr, u16 value)
+int i40e_write_phy_register_clause45(struct i40e_hw *hw,
+				     u8 page, u16 reg, u8 phy_addr, u16 value)
 {
-	i40e_status status = I40E_ERR_TIMEOUT;
-	u32 command = 0;
-	u16 retry = 1000;
 	u8 port_num = hw->func_caps.mdio_port_num;
+	int status = I40E_ERR_TIMEOUT;
+	u16 retry = 1000;
+	u32 command = 0;
 
 	command = (reg << I40E_GLGEN_MSCA_MDIADD_SHIFT) |
 		  (page << I40E_GLGEN_MSCA_DEVADD_SHIFT) |
@@ -4865,10 +4732,10 @@ i40e_status i40e_write_phy_register_clause45(struct i40e_hw *hw,
  *
  * Writes value to specified PHY register
  **/
-i40e_status i40e_write_phy_register(struct i40e_hw *hw,
-				    u8 page, u16 reg, u8 phy_addr, u16 value)
+int i40e_write_phy_register(struct i40e_hw *hw,
+			    u8 page, u16 reg, u8 phy_addr, u16 value)
 {
-	i40e_status status;
+	int status;
 
 	switch (hw->device_id) {
 	case I40E_DEV_ID_1G_BASE_T_X722:
@@ -4903,10 +4770,10 @@ i40e_status i40e_write_phy_register(struct i40e_hw *hw,
  *
  * Reads specified PHY register value
  **/
-i40e_status i40e_read_phy_register(struct i40e_hw *hw,
-				   u8 page, u16 reg, u8 phy_addr, u16 *value)
+int i40e_read_phy_register(struct i40e_hw *hw,
+			   u8 page, u16 reg, u8 phy_addr, u16 *value)
 {
-	i40e_status status;
+	int status;
 
 	switch (hw->device_id) {
 	case I40E_DEV_ID_1G_BASE_T_X722:
@@ -4954,17 +4821,17 @@ u8 i40e_get_phy_address(struct i40e_hw *hw, u8 dev_num)
  *
  * Blinks PHY link LED
  **/
-i40e_status i40e_blink_phy_link_led(struct i40e_hw *hw,
-				    u32 time, u32 interval)
+int i40e_blink_phy_link_led(struct i40e_hw *hw,
+			    u32 time, u32 interval)
 {
-	i40e_status status = 0;
-	u32 i;
-	u16 led_ctl;
-	u16 gpio_led_port;
-	u16 led_reg;
 	u16 led_addr = I40E_PHY_LED_PROV_REG_1;
+	u16 gpio_led_port;
 	u8 phy_addr = 0;
+	int status = 0;
+	u16 led_ctl;
 	u8 port_num;
+	u16 led_reg;
+	u32 i;
 
 	i = rd32(hw, I40E_PFGEN_PORTNUM);
 	port_num = (u8)(i & I40E_PFGEN_PORTNUM_PORT_NUM_MASK);
@@ -5026,12 +4893,12 @@ i40e_status i40e_blink_phy_link_led(struct i40e_hw *hw,
  * @led_addr: LED register address
  * @reg_val: read register value
  **/
-static enum i40e_status_code i40e_led_get_reg(struct i40e_hw *hw, u16 led_addr,
-					      u32 *reg_val)
+static int i40e_led_get_reg(struct i40e_hw *hw, u16 led_addr,
+			    u32 *reg_val)
 {
-	enum i40e_status_code status;
 	u8 phy_addr = 0;
 	u8 port_num;
+	int status;
 	u32 i;
 
 	*reg_val = 0;
@@ -5060,12 +4927,12 @@ static enum i40e_status_code i40e_led_get_reg(struct i40e_hw *hw, u16 led_addr,
  * @led_addr: LED register address
  * @reg_val: register value to write
  **/
-static enum i40e_status_code i40e_led_set_reg(struct i40e_hw *hw, u16 led_addr,
-					      u32 reg_val)
+static int i40e_led_set_reg(struct i40e_hw *hw, u16 led_addr,
+			    u32 reg_val)
 {
-	enum i40e_status_code status;
 	u8 phy_addr = 0;
 	u8 port_num;
+	int status;
 	u32 i;
 
 	if (hw->flags & I40E_HW_FLAG_AQ_PHY_ACCESS_CAPABLE) {
@@ -5095,17 +4962,17 @@ static enum i40e_status_code i40e_led_set_reg(struct i40e_hw *hw, u16 led_addr,
  * @val: original value of register to use
  *
  **/
-i40e_status i40e_led_get_phy(struct i40e_hw *hw, u16 *led_addr,
-			     u16 *val)
+int i40e_led_get_phy(struct i40e_hw *hw, u16 *led_addr,
+		     u16 *val)
 {
-	i40e_status status = 0;
 	u16 gpio_led_port;
 	u8 phy_addr = 0;
-	u16 reg_val;
+	u32 reg_val_aq;
+	int status = 0;
 	u16 temp_addr;
+	u16 reg_val;
 	u8 port_num;
 	u32 i;
-	u32 reg_val_aq;
 
 	if (hw->flags & I40E_HW_FLAG_AQ_PHY_ACCESS_CAPABLE) {
 		status =
@@ -5150,12 +5017,12 @@ i40e_status i40e_led_get_phy(struct i40e_hw *hw, u16 *led_addr,
  * Set led's on or off when controlled by the PHY
  *
  **/
-i40e_status i40e_led_set_phy(struct i40e_hw *hw, bool on,
-			     u16 led_addr, u32 mode)
+int i40e_led_set_phy(struct i40e_hw *hw, bool on,
+		     u16 led_addr, u32 mode)
 {
-	i40e_status status = 0;
 	u32 led_ctl = 0;
 	u32 led_reg = 0;
+	int status = 0;
 
 	status = i40e_led_get_reg(hw, led_addr, &led_reg);
 	if (status)
@@ -5199,14 +5066,14 @@ i40e_status i40e_led_set_phy(struct i40e_hw *hw, bool on,
  * Use the firmware to read the Rx control register,
  * especially useful if the Rx unit is under heavy pressure
  **/
-i40e_status i40e_aq_rx_ctl_read_register(struct i40e_hw *hw,
-				u32 reg_addr, u32 *reg_val,
-				struct i40e_asq_cmd_details *cmd_details)
+int i40e_aq_rx_ctl_read_register(struct i40e_hw *hw,
+				 u32 reg_addr, u32 *reg_val,
+				 struct i40e_asq_cmd_details *cmd_details)
 {
 	struct i40e_aq_desc desc;
 	struct i40e_aqc_rx_ctl_reg_read_write *cmd_resp =
 		(struct i40e_aqc_rx_ctl_reg_read_write *)&desc.params.raw;
-	i40e_status status;
+	int status;
 
 	if (!reg_val)
 		return I40E_ERR_PARAM;
@@ -5230,8 +5097,8 @@ i40e_status i40e_aq_rx_ctl_read_register(struct i40e_hw *hw,
  **/
 u32 i40e_read_rx_ctl(struct i40e_hw *hw, u32 reg_addr)
 {
-	i40e_status status = 0;
 	bool use_register;
+	int status = 0;
 	int retry = 5;
 	u32 val = 0;
 
@@ -5265,14 +5132,14 @@ u32 i40e_read_rx_ctl(struct i40e_hw *hw, u32 reg_addr)
  * Use the firmware to write to an Rx control register,
  * especially useful if the Rx unit is under heavy pressure
  **/
-i40e_status i40e_aq_rx_ctl_write_register(struct i40e_hw *hw,
-				u32 reg_addr, u32 reg_val,
-				struct i40e_asq_cmd_details *cmd_details)
+int i40e_aq_rx_ctl_write_register(struct i40e_hw *hw,
+				  u32 reg_addr, u32 reg_val,
+				  struct i40e_asq_cmd_details *cmd_details)
 {
 	struct i40e_aq_desc desc;
 	struct i40e_aqc_rx_ctl_reg_read_write *cmd =
 		(struct i40e_aqc_rx_ctl_reg_read_write *)&desc.params.raw;
-	i40e_status status;
+	int status;
 
 	i40e_fill_default_direct_cmd_desc(&desc, i40e_aqc_opc_rx_ctl_reg_write);
 
@@ -5292,8 +5159,8 @@ i40e_status i40e_aq_rx_ctl_write_register(struct i40e_hw *hw,
  **/
 void i40e_write_rx_ctl(struct i40e_hw *hw, u32 reg_addr, u32 reg_val)
 {
-	i40e_status status = 0;
 	bool use_register;
+	int status = 0;
 	int retry = 5;
 
 	use_register = (((hw->aq.api_maj_ver == 1) &&
@@ -5355,16 +5222,16 @@ static void i40e_mdio_if_number_selection(struct i40e_hw *hw, bool set_mdio,
  * NOTE: In common cases MDIO I/F number should not be changed, thats why you
  * may use simple wrapper i40e_aq_set_phy_register.
  **/
-enum i40e_status_code i40e_aq_set_phy_register_ext(struct i40e_hw *hw,
-			     u8 phy_select, u8 dev_addr, bool page_change,
-			     bool set_mdio, u8 mdio_num,
-			     u32 reg_addr, u32 reg_val,
-			     struct i40e_asq_cmd_details *cmd_details)
+int i40e_aq_set_phy_register_ext(struct i40e_hw *hw,
+				 u8 phy_select, u8 dev_addr, bool page_change,
+				 bool set_mdio, u8 mdio_num,
+				 u32 reg_addr, u32 reg_val,
+				 struct i40e_asq_cmd_details *cmd_details)
 {
 	struct i40e_aq_desc desc;
 	struct i40e_aqc_phy_register_access *cmd =
 		(struct i40e_aqc_phy_register_access *)&desc.params.raw;
-	i40e_status status;
+	int status;
 
 	i40e_fill_default_direct_cmd_desc(&desc,
 					  i40e_aqc_opc_set_phy_register);
@@ -5400,16 +5267,16 @@ enum i40e_status_code i40e_aq_set_phy_register_ext(struct i40e_hw *hw,
  * NOTE: In common cases MDIO I/F number should not be changed, thats why you
  * may use simple wrapper i40e_aq_get_phy_register.
  **/
-enum i40e_status_code i40e_aq_get_phy_register_ext(struct i40e_hw *hw,
-			     u8 phy_select, u8 dev_addr, bool page_change,
-			     bool set_mdio, u8 mdio_num,
-			     u32 reg_addr, u32 *reg_val,
-			     struct i40e_asq_cmd_details *cmd_details)
+int i40e_aq_get_phy_register_ext(struct i40e_hw *hw,
+				 u8 phy_select, u8 dev_addr, bool page_change,
+				 bool set_mdio, u8 mdio_num,
+				 u32 reg_addr, u32 *reg_val,
+				 struct i40e_asq_cmd_details *cmd_details)
 {
 	struct i40e_aq_desc desc;
 	struct i40e_aqc_phy_register_access *cmd =
 		(struct i40e_aqc_phy_register_access *)&desc.params.raw;
-	i40e_status status;
+	int status;
 
 	i40e_fill_default_direct_cmd_desc(&desc,
 					  i40e_aqc_opc_get_phy_register);
@@ -5440,18 +5307,17 @@ enum i40e_status_code i40e_aq_get_phy_register_ext(struct i40e_hw *hw,
  * @error_info: returns error information
  * @cmd_details: pointer to command details structure or NULL
  **/
-enum
-i40e_status_code i40e_aq_write_ddp(struct i40e_hw *hw, void *buff,
-				   u16 buff_size, u32 track_id,
-				   u32 *error_offset, u32 *error_info,
-				   struct i40e_asq_cmd_details *cmd_details)
+int i40e_aq_write_ddp(struct i40e_hw *hw, void *buff,
+		      u16 buff_size, u32 track_id,
+		      u32 *error_offset, u32 *error_info,
+		      struct i40e_asq_cmd_details *cmd_details)
 {
 	struct i40e_aq_desc desc;
 	struct i40e_aqc_write_personalization_profile *cmd =
 		(struct i40e_aqc_write_personalization_profile *)
 		&desc.params.raw;
 	struct i40e_aqc_write_ddp_resp *resp;
-	i40e_status status;
+	int status;
 
 	i40e_fill_default_direct_cmd_desc(&desc,
 					  i40e_aqc_opc_write_personalization_profile);
@@ -5484,15 +5350,14 @@ i40e_status_code i40e_aq_write_ddp(struct i40e_hw *hw, void *buff,
  * @flags: AdminQ command flags
  * @cmd_details: pointer to command details structure or NULL
  **/
-enum
-i40e_status_code i40e_aq_get_ddp_list(struct i40e_hw *hw, void *buff,
-				      u16 buff_size, u8 flags,
-				      struct i40e_asq_cmd_details *cmd_details)
+int i40e_aq_get_ddp_list(struct i40e_hw *hw, void *buff,
+			 u16 buff_size, u8 flags,
+			 struct i40e_asq_cmd_details *cmd_details)
 {
 	struct i40e_aq_desc desc;
 	struct i40e_aqc_get_applied_profiles *cmd =
 		(struct i40e_aqc_get_applied_profiles *)&desc.params.raw;
-	i40e_status status;
+	int status;
 
 	i40e_fill_default_direct_cmd_desc(&desc,
 					  i40e_aqc_opc_get_personalization_profile_list);
@@ -5591,14 +5456,13 @@ i40e_find_section_in_profile(u32 section_type,
  * @hw: pointer to the hw struct
  * @aq: command buffer containing all data to execute AQ
  **/
-static enum
-i40e_status_code i40e_ddp_exec_aq_section(struct i40e_hw *hw,
-					  struct i40e_profile_aq_section *aq)
+static int i40e_ddp_exec_aq_section(struct i40e_hw *hw,
+				    struct i40e_profile_aq_section *aq)
 {
-	i40e_status status;
 	struct i40e_aq_desc desc;
 	u8 *msg = NULL;
 	u16 msglen;
+	int status;
 
 	i40e_fill_default_direct_cmd_desc(&desc, aq->opcode);
 	desc.flags |= cpu_to_le16(aq->flags);
@@ -5638,14 +5502,14 @@ i40e_status_code i40e_ddp_exec_aq_section(struct i40e_hw *hw,
  *
  * Validates supported devices and profile's sections.
  */
-static enum i40e_status_code
+static int
 i40e_validate_profile(struct i40e_hw *hw, struct i40e_profile_segment *profile,
 		      u32 track_id, bool rollback)
 {
 	struct i40e_profile_section_header *sec = NULL;
-	i40e_status status = 0;
 	struct i40e_section_table *sec_tbl;
 	u32 vendor_dev_id;
+	int status = 0;
 	u32 dev_cnt;
 	u32 sec_off;
 	u32 i;
@@ -5703,16 +5567,16 @@ i40e_validate_profile(struct i40e_hw *hw, struct i40e_profile_segment *profile,
  *
  * Handles the download of a complete package.
  */
-enum i40e_status_code
+int
 i40e_write_profile(struct i40e_hw *hw, struct i40e_profile_segment *profile,
 		   u32 track_id)
 {
-	i40e_status status = 0;
-	struct i40e_section_table *sec_tbl;
 	struct i40e_profile_section_header *sec = NULL;
 	struct i40e_profile_aq_section *ddp_aq;
-	u32 section_size = 0;
+	struct i40e_section_table *sec_tbl;
 	u32 offset = 0, info = 0;
+	u32 section_size = 0;
+	int status = 0;
 	u32 sec_off;
 	u32 i;
 
@@ -5766,15 +5630,15 @@ i40e_write_profile(struct i40e_hw *hw, struct i40e_profile_segment *profile,
  *
  * Rolls back previously loaded package.
  */
-enum i40e_status_code
+int
 i40e_rollback_profile(struct i40e_hw *hw, struct i40e_profile_segment *profile,
 		      u32 track_id)
 {
 	struct i40e_profile_section_header *sec = NULL;
-	i40e_status status = 0;
 	struct i40e_section_table *sec_tbl;
 	u32 offset = 0, info = 0;
 	u32 section_size = 0;
+	int status = 0;
 	u32 sec_off;
 	int i;
 
@@ -5818,15 +5682,15 @@ i40e_rollback_profile(struct i40e_hw *hw, struct i40e_profile_segment *profile,
  *
  * Register a profile to the list of loaded profiles.
  */
-enum i40e_status_code
+int
 i40e_add_pinfo_to_list(struct i40e_hw *hw,
 		       struct i40e_profile_segment *profile,
 		       u8 *profile_info_sec, u32 track_id)
 {
-	i40e_status status = 0;
 	struct i40e_profile_section_header *sec = NULL;
 	struct i40e_profile_info *pinfo;
 	u32 offset = 0, info = 0;
+	int status = 0;
 
 	sec = (struct i40e_profile_section_header *)profile_info_sec;
 	sec->tbl_size = 1;
@@ -5860,7 +5724,7 @@ i40e_add_pinfo_to_list(struct i40e_hw *hw,
  * of the function.
  *
  **/
-enum i40e_status_code
+int
 i40e_aq_add_cloud_filters(struct i40e_hw *hw, u16 seid,
 			  struct i40e_aqc_cloud_filters_element_data *filters,
 			  u8 filter_count)
@@ -5868,8 +5732,8 @@ i40e_aq_add_cloud_filters(struct i40e_hw *hw, u16 seid,
 	struct i40e_aq_desc desc;
 	struct i40e_aqc_add_remove_cloud_filters *cmd =
 	(struct i40e_aqc_add_remove_cloud_filters *)&desc.params.raw;
-	enum i40e_status_code status;
 	u16 buff_len;
+	int status;
 
 	i40e_fill_default_direct_cmd_desc(&desc,
 					  i40e_aqc_opc_add_cloud_filters);
@@ -5897,7 +5761,7 @@ i40e_aq_add_cloud_filters(struct i40e_hw *hw, u16 seid,
  * function.
  *
  **/
-enum i40e_status_code
+int
 i40e_aq_add_cloud_filters_bb(struct i40e_hw *hw, u16 seid,
 			     struct i40e_aqc_cloud_filters_element_bb *filters,
 			     u8 filter_count)
@@ -5905,8 +5769,8 @@ i40e_aq_add_cloud_filters_bb(struct i40e_hw *hw, u16 seid,
 	struct i40e_aq_desc desc;
 	struct i40e_aqc_add_remove_cloud_filters *cmd =
 	(struct i40e_aqc_add_remove_cloud_filters *)&desc.params.raw;
-	i40e_status status;
 	u16 buff_len;
+	int status;
 	int i;
 
 	i40e_fill_default_direct_cmd_desc(&desc,
@@ -5954,7 +5818,7 @@ i40e_aq_add_cloud_filters_bb(struct i40e_hw *hw, u16 seid,
  * of the function.
  *
  **/
-enum i40e_status_code
+int
 i40e_aq_rem_cloud_filters(struct i40e_hw *hw, u16 seid,
 			  struct i40e_aqc_cloud_filters_element_data *filters,
 			  u8 filter_count)
@@ -5962,8 +5826,8 @@ i40e_aq_rem_cloud_filters(struct i40e_hw *hw, u16 seid,
 	struct i40e_aq_desc desc;
 	struct i40e_aqc_add_remove_cloud_filters *cmd =
 	(struct i40e_aqc_add_remove_cloud_filters *)&desc.params.raw;
-	enum i40e_status_code status;
 	u16 buff_len;
+	int status;
 
 	i40e_fill_default_direct_cmd_desc(&desc,
 					  i40e_aqc_opc_remove_cloud_filters);
@@ -5991,7 +5855,7 @@ i40e_aq_rem_cloud_filters(struct i40e_hw *hw, u16 seid,
  * function.
  *
  **/
-enum i40e_status_code
+int
 i40e_aq_rem_cloud_filters_bb(struct i40e_hw *hw, u16 seid,
 			     struct i40e_aqc_cloud_filters_element_bb *filters,
 			     u8 filter_count)
@@ -5999,8 +5863,8 @@ i40e_aq_rem_cloud_filters_bb(struct i40e_hw *hw, u16 seid,
 	struct i40e_aq_desc desc;
 	struct i40e_aqc_add_remove_cloud_filters *cmd =
 	(struct i40e_aqc_add_remove_cloud_filters *)&desc.params.raw;
-	i40e_status status;
 	u16 buff_len;
+	int status;
 	int i;
 
 	i40e_fill_default_direct_cmd_desc(&desc,
diff --git a/drivers/net/ethernet/intel/i40e/i40e_dcb.c b/drivers/net/ethernet/intel/i40e/i40e_dcb.c
index 673f341f4c0c..90638b67f8dc 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_dcb.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_dcb.c
@@ -12,7 +12,7 @@
  *
  * Get the DCBX status from the Firmware
  **/
-i40e_status i40e_get_dcbx_status(struct i40e_hw *hw, u16 *status)
+int i40e_get_dcbx_status(struct i40e_hw *hw, u16 *status)
 {
 	u32 reg;
 
@@ -497,15 +497,15 @@ static void i40e_parse_org_tlv(struct i40e_lldp_org_tlv *tlv,
  *
  * Parse DCB configuration from the LLDPDU
  **/
-i40e_status i40e_lldp_to_dcb_config(u8 *lldpmib,
-				    struct i40e_dcbx_config *dcbcfg)
+int i40e_lldp_to_dcb_config(u8 *lldpmib,
+			    struct i40e_dcbx_config *dcbcfg)
 {
-	i40e_status ret = 0;
 	struct i40e_lldp_org_tlv *tlv;
-	u16 type;
-	u16 length;
 	u16 typelength;
 	u16 offset = 0;
+	int ret = 0;
+	u16 length;
+	u16 type;
 
 	if (!lldpmib || !dcbcfg)
 		return I40E_ERR_PARAM;
@@ -551,12 +551,12 @@ i40e_status i40e_lldp_to_dcb_config(u8 *lldpmib,
  *
  * Query DCB configuration from the Firmware
  **/
-i40e_status i40e_aq_get_dcb_config(struct i40e_hw *hw, u8 mib_type,
-				   u8 bridgetype,
-				   struct i40e_dcbx_config *dcbcfg)
+int i40e_aq_get_dcb_config(struct i40e_hw *hw, u8 mib_type,
+			   u8 bridgetype,
+			   struct i40e_dcbx_config *dcbcfg)
 {
-	i40e_status ret = 0;
 	struct i40e_virt_mem mem;
+	int ret = 0;
 	u8 *lldpmib;
 
 	/* Allocate the LLDPDU */
@@ -767,9 +767,9 @@ static void i40e_cee_to_dcb_config(
  *
  * Get IEEE mode DCB configuration from the Firmware
  **/
-static i40e_status i40e_get_ieee_dcb_config(struct i40e_hw *hw)
+static int i40e_get_ieee_dcb_config(struct i40e_hw *hw)
 {
-	i40e_status ret = 0;
+	int ret = 0;
 
 	/* IEEE mode */
 	hw->local_dcbx_config.dcbx_mode = I40E_DCBX_MODE_IEEE;
@@ -797,11 +797,11 @@ static i40e_status i40e_get_ieee_dcb_config(struct i40e_hw *hw)
  *
  * Get DCB configuration from the Firmware
  **/
-i40e_status i40e_get_dcb_config(struct i40e_hw *hw)
+int i40e_get_dcb_config(struct i40e_hw *hw)
 {
-	i40e_status ret = 0;
-	struct i40e_aqc_get_cee_dcb_cfg_resp cee_cfg;
 	struct i40e_aqc_get_cee_dcb_cfg_v1_resp cee_v1_cfg;
+	struct i40e_aqc_get_cee_dcb_cfg_resp cee_cfg;
+	int ret = 0;
 
 	/* If Firmware version < v4.33 on X710/XL710, IEEE only */
 	if ((hw->mac.type == I40E_MAC_XL710) &&
@@ -867,11 +867,11 @@ i40e_status i40e_get_dcb_config(struct i40e_hw *hw)
  *
  * Update DCB configuration from the Firmware
  **/
-i40e_status i40e_init_dcb(struct i40e_hw *hw, bool enable_mib_change)
+int i40e_init_dcb(struct i40e_hw *hw, bool enable_mib_change)
 {
-	i40e_status ret = 0;
 	struct i40e_lldp_variables lldp_cfg;
 	u8 adminstatus = 0;
+	int ret = 0;
 
 	if (!hw->func_caps.dcb)
 		return I40E_NOT_SUPPORTED;
@@ -940,13 +940,13 @@ i40e_status i40e_init_dcb(struct i40e_hw *hw, bool enable_mib_change)
  * Get status of FW Link Layer Discovery Protocol (LLDP) Agent.
  * Status of agent is reported via @lldp_status parameter.
  **/
-enum i40e_status_code
+int
 i40e_get_fw_lldp_status(struct i40e_hw *hw,
 			enum i40e_get_fw_lldp_status_resp *lldp_status)
 {
 	struct i40e_virt_mem mem;
-	i40e_status ret;
 	u8 *lldpmib;
+	int ret;
 
 	if (!lldp_status)
 		return I40E_ERR_PARAM;
@@ -1238,13 +1238,13 @@ static void i40e_add_dcb_tlv(struct i40e_lldp_org_tlv *tlv,
  *
  * Set DCB configuration to the Firmware
  **/
-i40e_status i40e_set_dcb_config(struct i40e_hw *hw)
+int i40e_set_dcb_config(struct i40e_hw *hw)
 {
 	struct i40e_dcbx_config *dcbcfg;
 	struct i40e_virt_mem mem;
 	u8 mib_type, *lldpmib;
-	i40e_status ret;
 	u16 miblen;
+	int ret;
 
 	/* update the hw local config */
 	dcbcfg = &hw->local_dcbx_config;
@@ -1274,8 +1274,8 @@ i40e_status i40e_set_dcb_config(struct i40e_hw *hw)
  *
  * send DCB configuration to FW
  **/
-i40e_status i40e_dcb_config_to_lldp(u8 *lldpmib, u16 *miblen,
-				    struct i40e_dcbx_config *dcbcfg)
+int i40e_dcb_config_to_lldp(u8 *lldpmib, u16 *miblen,
+			    struct i40e_dcbx_config *dcbcfg)
 {
 	u16 length, offset = 0, tlvid, typelength;
 	struct i40e_lldp_org_tlv *tlv;
@@ -1888,13 +1888,13 @@ void i40e_dcb_hw_rx_pb_config(struct i40e_hw *hw,
  *
  * Reads the LLDP configuration data from NVM using passed addresses
  **/
-static i40e_status _i40e_read_lldp_cfg(struct i40e_hw *hw,
-				       struct i40e_lldp_variables *lldp_cfg,
-				       u8 module, u32 word_offset)
+static int _i40e_read_lldp_cfg(struct i40e_hw *hw,
+			       struct i40e_lldp_variables *lldp_cfg,
+			       u8 module, u32 word_offset)
 {
 	u32 address, offset = (2 * word_offset);
-	i40e_status ret;
 	__le16 raw_mem;
+	int ret;
 	u16 mem;
 
 	ret = i40e_acquire_nvm(hw, I40E_RESOURCE_READ);
@@ -1950,10 +1950,10 @@ static i40e_status _i40e_read_lldp_cfg(struct i40e_hw *hw,
  *
  * Reads the LLDP configuration data from NVM
  **/
-i40e_status i40e_read_lldp_cfg(struct i40e_hw *hw,
-			       struct i40e_lldp_variables *lldp_cfg)
+int i40e_read_lldp_cfg(struct i40e_hw *hw,
+		       struct i40e_lldp_variables *lldp_cfg)
 {
-	i40e_status ret = 0;
+	int ret = 0;
 	u32 mem;
 
 	if (!lldp_cfg)
diff --git a/drivers/net/ethernet/intel/i40e/i40e_dcb.h b/drivers/net/ethernet/intel/i40e/i40e_dcb.h
index 2370ceecb061..6b60dc9b7736 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_dcb.h
+++ b/drivers/net/ethernet/intel/i40e/i40e_dcb.h
@@ -264,20 +264,20 @@ void i40e_dcb_hw_calculate_pool_sizes(struct i40e_hw *hw,
 void i40e_dcb_hw_rx_pb_config(struct i40e_hw *hw,
 			      struct i40e_rx_pb_config *old_pb_cfg,
 			      struct i40e_rx_pb_config *new_pb_cfg);
-i40e_status i40e_get_dcbx_status(struct i40e_hw *hw,
-				 u16 *status);
-i40e_status i40e_lldp_to_dcb_config(u8 *lldpmib,
-				    struct i40e_dcbx_config *dcbcfg);
-i40e_status i40e_aq_get_dcb_config(struct i40e_hw *hw, u8 mib_type,
-				   u8 bridgetype,
-				   struct i40e_dcbx_config *dcbcfg);
-i40e_status i40e_get_dcb_config(struct i40e_hw *hw);
-i40e_status i40e_init_dcb(struct i40e_hw *hw,
-			  bool enable_mib_change);
-enum i40e_status_code
+int i40e_get_dcbx_status(struct i40e_hw *hw,
+			 u16 *status);
+int i40e_lldp_to_dcb_config(u8 *lldpmib,
+			    struct i40e_dcbx_config *dcbcfg);
+int i40e_aq_get_dcb_config(struct i40e_hw *hw, u8 mib_type,
+			   u8 bridgetype,
+			   struct i40e_dcbx_config *dcbcfg);
+int i40e_get_dcb_config(struct i40e_hw *hw);
+int i40e_init_dcb(struct i40e_hw *hw,
+		  bool enable_mib_change);
+int
 i40e_get_fw_lldp_status(struct i40e_hw *hw,
 			enum i40e_get_fw_lldp_status_resp *lldp_status);
-i40e_status i40e_set_dcb_config(struct i40e_hw *hw);
-i40e_status i40e_dcb_config_to_lldp(u8 *lldpmib, u16 *miblen,
-				    struct i40e_dcbx_config *dcbcfg);
+int i40e_set_dcb_config(struct i40e_hw *hw);
+int i40e_dcb_config_to_lldp(u8 *lldpmib, u16 *miblen,
+			    struct i40e_dcbx_config *dcbcfg);
 #endif /* _I40E_DCB_H_ */
diff --git a/drivers/net/ethernet/intel/i40e/i40e_dcb_nl.c b/drivers/net/ethernet/intel/i40e/i40e_dcb_nl.c
index e32c61909b31..bba70bd5703b 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_dcb_nl.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_dcb_nl.c
@@ -135,8 +135,8 @@ static int i40e_dcbnl_ieee_setets(struct net_device *netdev,
 	ret = i40e_hw_dcb_config(pf, &pf->tmp_cfg);
 	if (ret) {
 		dev_info(&pf->pdev->dev,
-			 "Failed setting DCB ETS configuration err %s aq_err %s\n",
-			 i40e_stat_str(&pf->hw, ret),
+			 "Failed setting DCB ETS configuration err %d aq_err %s\n",
+			 ret,
 			 i40e_aq_str(&pf->hw, pf->hw.aq.asq_last_status));
 		return -EINVAL;
 	}
@@ -174,8 +174,8 @@ static int i40e_dcbnl_ieee_setpfc(struct net_device *netdev,
 	ret = i40e_hw_dcb_config(pf, &pf->tmp_cfg);
 	if (ret) {
 		dev_info(&pf->pdev->dev,
-			 "Failed setting DCB PFC configuration err %s aq_err %s\n",
-			 i40e_stat_str(&pf->hw, ret),
+			 "Failed setting DCB PFC configuration err %d aq_err %s\n",
+			 ret,
 			 i40e_aq_str(&pf->hw, pf->hw.aq.asq_last_status));
 		return -EINVAL;
 	}
@@ -225,8 +225,8 @@ static int i40e_dcbnl_ieee_setapp(struct net_device *netdev,
 	ret = i40e_hw_dcb_config(pf, &pf->tmp_cfg);
 	if (ret) {
 		dev_info(&pf->pdev->dev,
-			 "Failed setting DCB configuration err %s aq_err %s\n",
-			 i40e_stat_str(&pf->hw, ret),
+			 "Failed setting DCB configuration err %d aq_err %s\n",
+			 ret,
 			 i40e_aq_str(&pf->hw, pf->hw.aq.asq_last_status));
 		return -EINVAL;
 	}
@@ -290,8 +290,8 @@ static int i40e_dcbnl_ieee_delapp(struct net_device *netdev,
 	ret = i40e_hw_dcb_config(pf, &pf->tmp_cfg);
 	if (ret) {
 		dev_info(&pf->pdev->dev,
-			 "Failed setting DCB configuration err %s aq_err %s\n",
-			 i40e_stat_str(&pf->hw, ret),
+			 "Failed setting DCB configuration err %d aq_err %s\n",
+			 ret,
 			 i40e_aq_str(&pf->hw, pf->hw.aq.asq_last_status));
 		return -EINVAL;
 	}
diff --git a/drivers/net/ethernet/intel/i40e/i40e_ddp.c b/drivers/net/ethernet/intel/i40e/i40e_ddp.c
index e1069ae658ad..7e8183762fd9 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_ddp.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_ddp.c
@@ -36,7 +36,7 @@ static int i40e_ddp_does_profile_exist(struct i40e_hw *hw,
 {
 	struct i40e_ddp_profile_list *profile_list;
 	u8 buff[I40E_PROFILE_LIST_SIZE];
-	i40e_status status;
+	int status;
 	int i;
 
 	status = i40e_aq_get_ddp_list(hw, buff, I40E_PROFILE_LIST_SIZE, 0,
@@ -91,7 +91,7 @@ static int i40e_ddp_does_profile_overlap(struct i40e_hw *hw,
 {
 	struct i40e_ddp_profile_list *profile_list;
 	u8 buff[I40E_PROFILE_LIST_SIZE];
-	i40e_status status;
+	int status;
 	int i;
 
 	status = i40e_aq_get_ddp_list(hw, buff, I40E_PROFILE_LIST_SIZE, 0,
@@ -117,14 +117,14 @@ static int i40e_ddp_does_profile_overlap(struct i40e_hw *hw,
  *
  * Register a profile to the list of loaded profiles.
  */
-static enum i40e_status_code
+static int
 i40e_add_pinfo(struct i40e_hw *hw, struct i40e_profile_segment *profile,
 	       u8 *profile_info_sec, u32 track_id)
 {
 	struct i40e_profile_section_header *sec;
 	struct i40e_profile_info *pinfo;
-	i40e_status status;
 	u32 offset = 0, info = 0;
+	int status;
 
 	sec = (struct i40e_profile_section_header *)profile_info_sec;
 	sec->tbl_size = 1;
@@ -157,14 +157,14 @@ i40e_add_pinfo(struct i40e_hw *hw, struct i40e_profile_segment *profile,
  *
  * Removes DDP profile from the NIC.
  **/
-static enum i40e_status_code
+static int
 i40e_del_pinfo(struct i40e_hw *hw, struct i40e_profile_segment *profile,
 	       u8 *profile_info_sec, u32 track_id)
 {
 	struct i40e_profile_section_header *sec;
 	struct i40e_profile_info *pinfo;
-	i40e_status status;
 	u32 offset = 0, info = 0;
+	int status;
 
 	sec = (struct i40e_profile_section_header *)profile_info_sec;
 	sec->tbl_size = 1;
@@ -270,12 +270,12 @@ int i40e_ddp_load(struct net_device *netdev, const u8 *data, size_t size,
 	struct i40e_profile_segment *profile_hdr;
 	struct i40e_profile_info pinfo;
 	struct i40e_package_header *pkg_hdr;
-	i40e_status status;
 	struct i40e_netdev_priv *np = netdev_priv(netdev);
 	struct i40e_vsi *vsi = np->vsi;
 	struct i40e_pf *pf = vsi->back;
 	u32 track_id;
 	int istatus;
+	int status;
 
 	pkg_hdr = (struct i40e_package_header *)data;
 	if (!i40e_ddp_is_pkg_hdr_valid(netdev, pkg_hdr, size))
diff --git a/drivers/net/ethernet/intel/i40e/i40e_debugfs.c b/drivers/net/ethernet/intel/i40e/i40e_debugfs.c
index 9db5001297c7..c057343165a5 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_debugfs.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_debugfs.c
@@ -918,9 +918,9 @@ static ssize_t i40e_dbg_command_write(struct file *filp,
 		dev_info(&pf->pdev->dev, "deleting relay %d\n", veb_seid);
 		i40e_veb_release(pf->veb[i]);
 	} else if (strncmp(cmd_buf, "add pvid", 8) == 0) {
-		i40e_status ret;
-		u16 vid;
 		unsigned int v;
+		int ret;
+		u16 vid;
 
 		cnt = sscanf(&cmd_buf[8], "%i %u", &vsi_seid, &v);
 		if (cnt != 2) {
@@ -1284,7 +1284,7 @@ static ssize_t i40e_dbg_command_write(struct file *filp,
 		}
 	} else if (strncmp(cmd_buf, "send aq_cmd", 11) == 0) {
 		struct i40e_aq_desc *desc;
-		i40e_status ret;
+		int ret;
 
 		desc = kzalloc(sizeof(struct i40e_aq_desc), GFP_KERNEL);
 		if (!desc)
@@ -1330,9 +1330,9 @@ static ssize_t i40e_dbg_command_write(struct file *filp,
 		desc = NULL;
 	} else if (strncmp(cmd_buf, "send indirect aq_cmd", 20) == 0) {
 		struct i40e_aq_desc *desc;
-		i40e_status ret;
 		u16 buffer_len;
 		u8 *buff;
+		int ret;
 
 		desc = kzalloc(sizeof(struct i40e_aq_desc), GFP_KERNEL);
 		if (!desc)
diff --git a/drivers/net/ethernet/intel/i40e/i40e_diag.c b/drivers/net/ethernet/intel/i40e/i40e_diag.c
index ca229b0efeb6..97fe1787a8f4 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_diag.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_diag.c
@@ -10,8 +10,8 @@
  * @reg: reg to be tested
  * @mask: bits to be touched
  **/
-static i40e_status i40e_diag_reg_pattern_test(struct i40e_hw *hw,
-							u32 reg, u32 mask)
+static int i40e_diag_reg_pattern_test(struct i40e_hw *hw,
+				      u32 reg, u32 mask)
 {
 	static const u32 patterns[] = {
 		0x5A5A5A5A, 0xA5A5A5A5, 0x00000000, 0xFFFFFFFF
@@ -74,9 +74,9 @@ const struct i40e_diag_reg_test_info i40e_reg_list[] = {
  *
  * Perform registers diagnostic test
  **/
-i40e_status i40e_diag_reg_test(struct i40e_hw *hw)
+int i40e_diag_reg_test(struct i40e_hw *hw)
 {
-	i40e_status ret_code = 0;
+	int ret_code = 0;
 	u32 reg, mask;
 	u32 elements;
 	u32 i, j;
@@ -115,9 +115,9 @@ i40e_status i40e_diag_reg_test(struct i40e_hw *hw)
  *
  * Perform EEPROM diagnostic test
  **/
-i40e_status i40e_diag_eeprom_test(struct i40e_hw *hw)
+int i40e_diag_eeprom_test(struct i40e_hw *hw)
 {
-	i40e_status ret_code;
+	int ret_code;
 	u16 reg_val;
 
 	/* read NVM control word and if NVM valid, validate EEPROM checksum*/
diff --git a/drivers/net/ethernet/intel/i40e/i40e_diag.h b/drivers/net/ethernet/intel/i40e/i40e_diag.h
index 1db7c6d57231..c3ce5f35211f 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_diag.h
+++ b/drivers/net/ethernet/intel/i40e/i40e_diag.h
@@ -22,7 +22,7 @@ struct i40e_diag_reg_test_info {
 
 extern const struct i40e_diag_reg_test_info i40e_reg_list[];
 
-i40e_status i40e_diag_reg_test(struct i40e_hw *hw);
-i40e_status i40e_diag_eeprom_test(struct i40e_hw *hw);
+int i40e_diag_reg_test(struct i40e_hw *hw);
+int i40e_diag_eeprom_test(struct i40e_hw *hw);
 
 #endif /* _I40E_DIAG_H_ */
diff --git a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
index 813889604ff8..d124cb947ffa 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
@@ -1154,8 +1154,8 @@ static int i40e_set_link_ksettings(struct net_device *netdev,
 	struct i40e_vsi *vsi = np->vsi;
 	struct i40e_hw *hw = &pf->hw;
 	bool autoneg_changed = false;
-	i40e_status status = 0;
 	int timeout = 50;
+	int status = 0;
 	int err = 0;
 	u8 autoneg;
 
@@ -1357,8 +1357,8 @@ static int i40e_set_link_ksettings(struct net_device *netdev,
 		status = i40e_aq_set_phy_config(hw, &config, NULL);
 		if (status) {
 			netdev_info(netdev,
-				    "Set phy config failed, err %s aq_err %s\n",
-				    i40e_stat_str(hw, status),
+				    "Set phy config failed, err %d aq_err %s\n",
+				    status,
 				    i40e_aq_str(hw, hw->aq.asq_last_status));
 			err = -EAGAIN;
 			goto done;
@@ -1367,8 +1367,8 @@ static int i40e_set_link_ksettings(struct net_device *netdev,
 		status = i40e_update_link_info(hw);
 		if (status)
 			netdev_dbg(netdev,
-				   "Updating link info failed with err %s aq_err %s\n",
-				   i40e_stat_str(hw, status),
+				   "Updating link info failed with err %d aq_err %s\n",
+				   status,
 				   i40e_aq_str(hw, hw->aq.asq_last_status));
 
 	} else {
@@ -1387,7 +1387,7 @@ static int i40e_set_fec_cfg(struct net_device *netdev, u8 fec_cfg)
 	struct i40e_aq_get_phy_abilities_resp abilities;
 	struct i40e_pf *pf = np->vsi->back;
 	struct i40e_hw *hw = &pf->hw;
-	i40e_status status = 0;
+	int status = 0;
 	u32 flags = 0;
 	int err = 0;
 
@@ -1419,8 +1419,8 @@ static int i40e_set_fec_cfg(struct net_device *netdev, u8 fec_cfg)
 		status = i40e_aq_set_phy_config(hw, &config, NULL);
 		if (status) {
 			netdev_info(netdev,
-				    "Set phy config failed, err %s aq_err %s\n",
-				    i40e_stat_str(hw, status),
+				    "Set phy config failed, err %d aq_err %s\n",
+				    status,
 				    i40e_aq_str(hw, hw->aq.asq_last_status));
 			err = -EAGAIN;
 			goto done;
@@ -1433,8 +1433,8 @@ static int i40e_set_fec_cfg(struct net_device *netdev, u8 fec_cfg)
 			 * (e.g. no physical connection etc.)
 			 */
 			netdev_dbg(netdev,
-				   "Updating link info failed with err %s aq_err %s\n",
-				   i40e_stat_str(hw, status),
+				   "Updating link info failed with err %d aq_err %s\n",
+				   status,
 				   i40e_aq_str(hw, hw->aq.asq_last_status));
 	}
 
@@ -1449,7 +1449,7 @@ static int i40e_get_fec_param(struct net_device *netdev,
 	struct i40e_aq_get_phy_abilities_resp abilities;
 	struct i40e_pf *pf = np->vsi->back;
 	struct i40e_hw *hw = &pf->hw;
-	i40e_status status = 0;
+	int status = 0;
 	int err = 0;
 	u8 fec_cfg;
 
@@ -1536,12 +1536,12 @@ static int i40e_nway_reset(struct net_device *netdev)
 	struct i40e_pf *pf = np->vsi->back;
 	struct i40e_hw *hw = &pf->hw;
 	bool link_up = hw->phy.link_info.link_info & I40E_AQ_LINK_UP;
-	i40e_status ret = 0;
+	int ret = 0;
 
 	ret = i40e_aq_set_link_restart_an(hw, link_up, NULL);
 	if (ret) {
-		netdev_info(netdev, "link restart failed, err %s aq_err %s\n",
-			    i40e_stat_str(hw, ret),
+		netdev_info(netdev, "link restart failed, err %d aq_err %s\n",
+			    ret,
 			    i40e_aq_str(hw, hw->aq.asq_last_status));
 		return -EIO;
 	}
@@ -1601,9 +1601,9 @@ static int i40e_set_pauseparam(struct net_device *netdev,
 	struct i40e_link_status *hw_link_info = &hw->phy.link_info;
 	struct i40e_dcbx_config *dcbx_cfg = &hw->local_dcbx_config;
 	bool link_up = hw_link_info->link_info & I40E_AQ_LINK_UP;
-	i40e_status status;
 	u8 aq_failures;
 	int err = 0;
+	int status;
 	u32 is_an;
 
 	/* Changing the port's flow control is not supported if this isn't the
@@ -1657,20 +1657,20 @@ static int i40e_set_pauseparam(struct net_device *netdev,
 	status = i40e_set_fc(hw, &aq_failures, link_up);
 
 	if (aq_failures & I40E_SET_FC_AQ_FAIL_GET) {
-		netdev_info(netdev, "Set fc failed on the get_phy_capabilities call with err %s aq_err %s\n",
-			    i40e_stat_str(hw, status),
+		netdev_info(netdev, "Set fc failed on the get_phy_capabilities call with err %d aq_err %s\n",
+			    status,
 			    i40e_aq_str(hw, hw->aq.asq_last_status));
 		err = -EAGAIN;
 	}
 	if (aq_failures & I40E_SET_FC_AQ_FAIL_SET) {
-		netdev_info(netdev, "Set fc failed on the set_phy_config call with err %s aq_err %s\n",
-			    i40e_stat_str(hw, status),
+		netdev_info(netdev, "Set fc failed on the set_phy_config call with err %d aq_err %s\n",
+			    status,
 			    i40e_aq_str(hw, hw->aq.asq_last_status));
 		err = -EAGAIN;
 	}
 	if (aq_failures & I40E_SET_FC_AQ_FAIL_UPDATE) {
-		netdev_info(netdev, "Set fc failed on the get_link_info call with err %s aq_err %s\n",
-			    i40e_stat_str(hw, status),
+		netdev_info(netdev, "Set fc failed on the get_link_info call with err %d aq_err %s\n",
+			    status,
 			    i40e_aq_str(hw, hw->aq.asq_last_status));
 		err = -EAGAIN;
 	}
@@ -2481,8 +2481,8 @@ static u64 i40e_link_test(struct net_device *netdev, u64 *data)
 {
 	struct i40e_netdev_priv *np = netdev_priv(netdev);
 	struct i40e_pf *pf = np->vsi->back;
-	i40e_status status;
 	bool link_up = false;
+	int status;
 
 	netif_info(pf, hw, netdev, "link test\n");
 	status = i40e_get_link_status(&pf->hw, &link_up);
@@ -2705,11 +2705,11 @@ static int i40e_set_phys_id(struct net_device *netdev,
 			    enum ethtool_phys_id_state state)
 {
 	struct i40e_netdev_priv *np = netdev_priv(netdev);
-	i40e_status ret = 0;
 	struct i40e_pf *pf = np->vsi->back;
 	struct i40e_hw *hw = &pf->hw;
 	int blink_freq = 2;
 	u16 temp_status;
+	int ret = 0;
 
 	switch (state) {
 	case ETHTOOL_ID_ACTIVE:
@@ -5145,7 +5145,7 @@ static int i40e_set_priv_flags(struct net_device *dev, u32 flags)
 	struct i40e_vsi *vsi = np->vsi;
 	struct i40e_pf *pf = vsi->back;
 	u32 reset_needed = 0;
-	i40e_status status;
+	int status;
 	u32 i, j;
 
 	orig_flags = READ_ONCE(pf->flags);
@@ -5260,8 +5260,8 @@ static int i40e_set_priv_flags(struct net_device *dev, u32 flags)
 						0, NULL);
 		if (ret && pf->hw.aq.asq_last_status != I40E_AQ_RC_ESRCH) {
 			dev_info(&pf->pdev->dev,
-				 "couldn't set switch config bits, err %s aq_err %s\n",
-				 i40e_stat_str(&pf->hw, ret),
+				 "couldn't set switch config bits, err %d aq_err %s\n",
+				 ret,
 				 i40e_aq_str(&pf->hw,
 					     pf->hw.aq.asq_last_status));
 			/* not a fatal problem, just keep going */
@@ -5326,9 +5326,8 @@ static int i40e_set_priv_flags(struct net_device *dev, u32 flags)
 					return -EBUSY;
 				default:
 					dev_warn(&pf->pdev->dev,
-						 "Starting FW LLDP agent failed: error: %s, %s\n",
-						 i40e_stat_str(&pf->hw,
-							       status),
+						 "Starting FW LLDP agent failed: error: %d, %s\n",
+						 status,
 						 i40e_aq_str(&pf->hw,
 							     adq_err));
 					return -EINVAL;
@@ -5368,8 +5367,8 @@ static int i40e_get_module_info(struct net_device *netdev,
 	u32 sff8472_comp = 0;
 	u32 sff8472_swap = 0;
 	u32 sff8636_rev = 0;
-	i40e_status status;
 	u32 type = 0;
+	int status;
 
 	/* Check if firmware supports reading module EEPROM. */
 	if (!(hw->flags & I40E_HW_FLAG_AQ_PHY_ACCESS_CAPABLE)) {
@@ -5473,8 +5472,8 @@ static int i40e_get_module_eeprom(struct net_device *netdev,
 	struct i40e_pf *pf = vsi->back;
 	struct i40e_hw *hw = &pf->hw;
 	bool is_sfp = false;
-	i40e_status status;
 	u32 value = 0;
+	int status;
 	int i;
 
 	if (!ee || !ee->len || !data)
@@ -5515,10 +5514,10 @@ static int i40e_get_eee(struct net_device *netdev, struct ethtool_eee *edata)
 {
 	struct i40e_netdev_priv *np = netdev_priv(netdev);
 	struct i40e_aq_get_phy_abilities_resp phy_cfg;
-	enum i40e_status_code status = 0;
 	struct i40e_vsi *vsi = np->vsi;
 	struct i40e_pf *pf = vsi->back;
 	struct i40e_hw *hw = &pf->hw;
+	int status = 0;
 
 	/* Get initial PHY capabilities */
 	status = i40e_aq_get_phy_capabilities(hw, false, true, &phy_cfg, NULL);
@@ -5580,11 +5579,11 @@ static int i40e_set_eee(struct net_device *netdev, struct ethtool_eee *edata)
 {
 	struct i40e_netdev_priv *np = netdev_priv(netdev);
 	struct i40e_aq_get_phy_abilities_resp abilities;
-	enum i40e_status_code status = I40E_SUCCESS;
 	struct i40e_aq_set_phy_config config;
 	struct i40e_vsi *vsi = np->vsi;
 	struct i40e_pf *pf = vsi->back;
 	struct i40e_hw *hw = &pf->hw;
+	int status = I40E_SUCCESS;
 	__le16 eee_capability;
 
 	/* Deny parameters we don't support */
diff --git a/drivers/net/ethernet/intel/i40e/i40e_hmc.c b/drivers/net/ethernet/intel/i40e/i40e_hmc.c
index 163ee8c6311c..46f7950a0049 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_hmc.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_hmc.c
@@ -17,17 +17,17 @@
  * @type: what type of segment descriptor we're manipulating
  * @direct_mode_sz: size to alloc in direct mode
  **/
-i40e_status i40e_add_sd_table_entry(struct i40e_hw *hw,
-					      struct i40e_hmc_info *hmc_info,
-					      u32 sd_index,
-					      enum i40e_sd_entry_type type,
-					      u64 direct_mode_sz)
+int i40e_add_sd_table_entry(struct i40e_hw *hw,
+			    struct i40e_hmc_info *hmc_info,
+			    u32 sd_index,
+			    enum i40e_sd_entry_type type,
+			    u64 direct_mode_sz)
 {
 	enum i40e_memory_type mem_type __attribute__((unused));
 	struct i40e_hmc_sd_entry *sd_entry;
 	bool dma_mem_alloc_done = false;
+	int ret_code = I40E_SUCCESS;
 	struct i40e_dma_mem mem;
-	i40e_status ret_code = I40E_SUCCESS;
 	u64 alloc_len;
 
 	if (NULL == hmc_info->sd_table.sd_entry) {
@@ -106,19 +106,19 @@ i40e_status i40e_add_sd_table_entry(struct i40e_hw *hw,
  *	   aligned on 4K boundary and zeroed memory.
  *	2. It should be 4K in size.
  **/
-i40e_status i40e_add_pd_table_entry(struct i40e_hw *hw,
-					      struct i40e_hmc_info *hmc_info,
-					      u32 pd_index,
-					      struct i40e_dma_mem *rsrc_pg)
+int i40e_add_pd_table_entry(struct i40e_hw *hw,
+			    struct i40e_hmc_info *hmc_info,
+			    u32 pd_index,
+			    struct i40e_dma_mem *rsrc_pg)
 {
-	i40e_status ret_code = 0;
 	struct i40e_hmc_pd_table *pd_table;
 	struct i40e_hmc_pd_entry *pd_entry;
 	struct i40e_dma_mem mem;
 	struct i40e_dma_mem *page = &mem;
 	u32 sd_idx, rel_pd_idx;
-	u64 *pd_addr;
+	int ret_code = 0;
 	u64 page_desc;
+	u64 *pd_addr;
 
 	if (pd_index / I40E_HMC_PD_CNT_IN_SD >= hmc_info->sd_table.sd_cnt) {
 		ret_code = I40E_ERR_INVALID_PAGE_DESC_INDEX;
@@ -185,15 +185,15 @@ i40e_status i40e_add_pd_table_entry(struct i40e_hw *hw,
  *	1. Caller can deallocate the memory used by backing storage after this
  *	   function returns.
  **/
-i40e_status i40e_remove_pd_bp(struct i40e_hw *hw,
-					struct i40e_hmc_info *hmc_info,
-					u32 idx)
+int i40e_remove_pd_bp(struct i40e_hw *hw,
+		      struct i40e_hmc_info *hmc_info,
+		      u32 idx)
 {
-	i40e_status ret_code = 0;
 	struct i40e_hmc_pd_entry *pd_entry;
 	struct i40e_hmc_pd_table *pd_table;
 	struct i40e_hmc_sd_entry *sd_entry;
 	u32 sd_idx, rel_pd_idx;
+	int ret_code = 0;
 	u64 *pd_addr;
 
 	/* calculate index */
@@ -241,11 +241,11 @@ i40e_status i40e_remove_pd_bp(struct i40e_hw *hw,
  * @hmc_info: pointer to the HMC configuration information structure
  * @idx: the page index
  **/
-i40e_status i40e_prep_remove_sd_bp(struct i40e_hmc_info *hmc_info,
-					     u32 idx)
+int i40e_prep_remove_sd_bp(struct i40e_hmc_info *hmc_info,
+			   u32 idx)
 {
-	i40e_status ret_code = 0;
 	struct i40e_hmc_sd_entry *sd_entry;
+	int ret_code = 0;
 
 	/* get the entry and decrease its ref counter */
 	sd_entry = &hmc_info->sd_table.sd_entry[idx];
@@ -269,9 +269,9 @@ i40e_status i40e_prep_remove_sd_bp(struct i40e_hmc_info *hmc_info,
  * @idx: the page index
  * @is_pf: used to distinguish between VF and PF
  **/
-i40e_status i40e_remove_sd_bp_new(struct i40e_hw *hw,
-					    struct i40e_hmc_info *hmc_info,
-					    u32 idx, bool is_pf)
+int i40e_remove_sd_bp_new(struct i40e_hw *hw,
+			  struct i40e_hmc_info *hmc_info,
+			  u32 idx, bool is_pf)
 {
 	struct i40e_hmc_sd_entry *sd_entry;
 
@@ -290,11 +290,11 @@ i40e_status i40e_remove_sd_bp_new(struct i40e_hw *hw,
  * @hmc_info: pointer to the HMC configuration information structure
  * @idx: segment descriptor index to find the relevant page descriptor
  **/
-i40e_status i40e_prep_remove_pd_page(struct i40e_hmc_info *hmc_info,
-					       u32 idx)
+int i40e_prep_remove_pd_page(struct i40e_hmc_info *hmc_info,
+			     u32 idx)
 {
-	i40e_status ret_code = 0;
 	struct i40e_hmc_sd_entry *sd_entry;
+	int ret_code = 0;
 
 	sd_entry = &hmc_info->sd_table.sd_entry[idx];
 
@@ -318,9 +318,9 @@ i40e_status i40e_prep_remove_pd_page(struct i40e_hmc_info *hmc_info,
  * @idx: segment descriptor index to find the relevant page descriptor
  * @is_pf: used to distinguish between VF and PF
  **/
-i40e_status i40e_remove_pd_page_new(struct i40e_hw *hw,
-					      struct i40e_hmc_info *hmc_info,
-					      u32 idx, bool is_pf)
+int i40e_remove_pd_page_new(struct i40e_hw *hw,
+			    struct i40e_hmc_info *hmc_info,
+			    u32 idx, bool is_pf)
 {
 	struct i40e_hmc_sd_entry *sd_entry;
 
diff --git a/drivers/net/ethernet/intel/i40e/i40e_hmc.h b/drivers/net/ethernet/intel/i40e/i40e_hmc.h
index 3113792afaff..9960da07a573 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_hmc.h
+++ b/drivers/net/ethernet/intel/i40e/i40e_hmc.h
@@ -187,28 +187,28 @@ struct i40e_hmc_info {
 	/* add one more to the limit to correct our range */		\
 	*(pd_limit) += 1;						\
 }
-i40e_status i40e_add_sd_table_entry(struct i40e_hw *hw,
-					      struct i40e_hmc_info *hmc_info,
-					      u32 sd_index,
-					      enum i40e_sd_entry_type type,
-					      u64 direct_mode_sz);
-
-i40e_status i40e_add_pd_table_entry(struct i40e_hw *hw,
-					      struct i40e_hmc_info *hmc_info,
-					      u32 pd_index,
-					      struct i40e_dma_mem *rsrc_pg);
-i40e_status i40e_remove_pd_bp(struct i40e_hw *hw,
-					struct i40e_hmc_info *hmc_info,
-					u32 idx);
-i40e_status i40e_prep_remove_sd_bp(struct i40e_hmc_info *hmc_info,
-					     u32 idx);
-i40e_status i40e_remove_sd_bp_new(struct i40e_hw *hw,
-					    struct i40e_hmc_info *hmc_info,
-					    u32 idx, bool is_pf);
-i40e_status i40e_prep_remove_pd_page(struct i40e_hmc_info *hmc_info,
-					       u32 idx);
-i40e_status i40e_remove_pd_page_new(struct i40e_hw *hw,
-					      struct i40e_hmc_info *hmc_info,
-					      u32 idx, bool is_pf);
+
+int i40e_add_sd_table_entry(struct i40e_hw *hw,
+			    struct i40e_hmc_info *hmc_info,
+			    u32 sd_index,
+			    enum i40e_sd_entry_type type,
+			    u64 direct_mode_sz);
+int i40e_add_pd_table_entry(struct i40e_hw *hw,
+			    struct i40e_hmc_info *hmc_info,
+			    u32 pd_index,
+			    struct i40e_dma_mem *rsrc_pg);
+int i40e_remove_pd_bp(struct i40e_hw *hw,
+		      struct i40e_hmc_info *hmc_info,
+		      u32 idx);
+int i40e_prep_remove_sd_bp(struct i40e_hmc_info *hmc_info,
+			   u32 idx);
+int i40e_remove_sd_bp_new(struct i40e_hw *hw,
+			  struct i40e_hmc_info *hmc_info,
+			  u32 idx, bool is_pf);
+int i40e_prep_remove_pd_page(struct i40e_hmc_info *hmc_info,
+			     u32 idx);
+int i40e_remove_pd_page_new(struct i40e_hw *hw,
+			    struct i40e_hmc_info *hmc_info,
+			    u32 idx, bool is_pf);
 
 #endif /* _I40E_HMC_H_ */
diff --git a/drivers/net/ethernet/intel/i40e/i40e_lan_hmc.c b/drivers/net/ethernet/intel/i40e/i40e_lan_hmc.c
index d6e92ecddfbd..40c101f286d1 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_lan_hmc.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_lan_hmc.c
@@ -74,12 +74,12 @@ static u64 i40e_calculate_l2fpm_size(u32 txq_num, u32 rxq_num,
  * Assumptions:
  *   - HMC Resource Profile has been selected before calling this function.
  **/
-i40e_status i40e_init_lan_hmc(struct i40e_hw *hw, u32 txq_num,
-					u32 rxq_num, u32 fcoe_cntx_num,
-					u32 fcoe_filt_num)
+int i40e_init_lan_hmc(struct i40e_hw *hw, u32 txq_num,
+		      u32 rxq_num, u32 fcoe_cntx_num,
+		      u32 fcoe_filt_num)
 {
 	struct i40e_hmc_obj_info *obj, *full_obj;
-	i40e_status ret_code = 0;
+	int ret_code = 0;
 	u64 l2fpm_size;
 	u32 size_exp;
 
@@ -229,11 +229,11 @@ i40e_status i40e_init_lan_hmc(struct i40e_hw *hw, u32 txq_num,
  *	1. caller can deallocate the memory used by pd after this function
  *	   returns.
  **/
-static i40e_status i40e_remove_pd_page(struct i40e_hw *hw,
-						 struct i40e_hmc_info *hmc_info,
-						 u32 idx)
+static int i40e_remove_pd_page(struct i40e_hw *hw,
+			       struct i40e_hmc_info *hmc_info,
+			       u32 idx)
 {
-	i40e_status ret_code = 0;
+	int ret_code = 0;
 
 	if (!i40e_prep_remove_pd_page(hmc_info, idx))
 		ret_code = i40e_remove_pd_page_new(hw, hmc_info, idx, true);
@@ -256,11 +256,11 @@ static i40e_status i40e_remove_pd_page(struct i40e_hw *hw,
  *	1. caller can deallocate the memory used by backing storage after this
  *	   function returns.
  **/
-static i40e_status i40e_remove_sd_bp(struct i40e_hw *hw,
-					       struct i40e_hmc_info *hmc_info,
-					       u32 idx)
+static int i40e_remove_sd_bp(struct i40e_hw *hw,
+			     struct i40e_hmc_info *hmc_info,
+			     u32 idx)
 {
-	i40e_status ret_code = 0;
+	int ret_code = 0;
 
 	if (!i40e_prep_remove_sd_bp(hmc_info, idx))
 		ret_code = i40e_remove_sd_bp_new(hw, hmc_info, idx, true);
@@ -276,15 +276,15 @@ static i40e_status i40e_remove_sd_bp(struct i40e_hw *hw,
  * This will allocate memory for PDs and backing pages and populate
  * the sd and pd entries.
  **/
-static i40e_status i40e_create_lan_hmc_object(struct i40e_hw *hw,
-				struct i40e_hmc_lan_create_obj_info *info)
+static int i40e_create_lan_hmc_object(struct i40e_hw *hw,
+				      struct i40e_hmc_lan_create_obj_info *info)
 {
-	i40e_status ret_code = 0;
 	struct i40e_hmc_sd_entry *sd_entry;
 	u32 pd_idx1 = 0, pd_lmt1 = 0;
 	u32 pd_idx = 0, pd_lmt = 0;
 	bool pd_error = false;
 	u32 sd_idx, sd_lmt;
+	int ret_code = 0;
 	u64 sd_size;
 	u32 i, j;
 
@@ -435,13 +435,13 @@ static i40e_status i40e_create_lan_hmc_object(struct i40e_hw *hw,
  * - This function will be called after i40e_init_lan_hmc() and before
  *   any LAN/FCoE HMC objects can be created.
  **/
-i40e_status i40e_configure_lan_hmc(struct i40e_hw *hw,
-					     enum i40e_hmc_model model)
+int i40e_configure_lan_hmc(struct i40e_hw *hw,
+			   enum i40e_hmc_model model)
 {
 	struct i40e_hmc_lan_create_obj_info info;
-	i40e_status ret_code = 0;
 	u8 hmc_fn_id = hw->hmc.hmc_fn_id;
 	struct i40e_hmc_obj_info *obj;
+	int ret_code = 0;
 
 	/* Initialize part of the create object info struct */
 	info.hmc_info = &hw->hmc;
@@ -520,13 +520,13 @@ i40e_status i40e_configure_lan_hmc(struct i40e_hw *hw,
  * caller should deallocate memory allocated previously for
  * book-keeping information about PDs and backing storage.
  **/
-static i40e_status i40e_delete_lan_hmc_object(struct i40e_hw *hw,
-				struct i40e_hmc_lan_delete_obj_info *info)
+static int i40e_delete_lan_hmc_object(struct i40e_hw *hw,
+				      struct i40e_hmc_lan_delete_obj_info *info)
 {
-	i40e_status ret_code = 0;
 	struct i40e_hmc_pd_table *pd_table;
 	u32 pd_idx, pd_lmt, rel_pd_idx;
 	u32 sd_idx, sd_lmt;
+	int ret_code = 0;
 	u32 i, j;
 
 	if (NULL == info) {
@@ -632,10 +632,10 @@ static i40e_status i40e_delete_lan_hmc_object(struct i40e_hw *hw,
  * This must be called by drivers as they are shutting down and being
  * removed from the OS.
  **/
-i40e_status i40e_shutdown_lan_hmc(struct i40e_hw *hw)
+int i40e_shutdown_lan_hmc(struct i40e_hw *hw)
 {
 	struct i40e_hmc_lan_delete_obj_info info;
-	i40e_status ret_code;
+	int ret_code;
 
 	info.hmc_info = &hw->hmc;
 	info.rsrc_type = I40E_HMC_LAN_FULL;
@@ -915,9 +915,9 @@ static void i40e_write_qword(u8 *hmc_bits,
  * @context_bytes: pointer to the context bit array (DMA memory)
  * @hmc_type: the type of HMC resource
  **/
-static i40e_status i40e_clear_hmc_context(struct i40e_hw *hw,
-					u8 *context_bytes,
-					enum i40e_hmc_lan_rsrc_type hmc_type)
+static int i40e_clear_hmc_context(struct i40e_hw *hw,
+				  u8 *context_bytes,
+				  enum i40e_hmc_lan_rsrc_type hmc_type)
 {
 	/* clean the bit array */
 	memset(context_bytes, 0, (u32)hw->hmc.hmc_obj[hmc_type].size);
@@ -931,9 +931,9 @@ static i40e_status i40e_clear_hmc_context(struct i40e_hw *hw,
  * @ce_info:  a description of the struct to be filled
  * @dest:     the struct to be filled
  **/
-static i40e_status i40e_set_hmc_context(u8 *context_bytes,
-					struct i40e_context_ele *ce_info,
-					u8 *dest)
+static int i40e_set_hmc_context(u8 *context_bytes,
+				struct i40e_context_ele *ce_info,
+				u8 *dest)
 {
 	int f;
 
@@ -973,18 +973,18 @@ static i40e_status i40e_set_hmc_context(u8 *context_bytes,
  * base pointer.  This function is used for LAN Queue contexts.
  **/
 static
-i40e_status i40e_hmc_get_object_va(struct i40e_hw *hw, u8 **object_base,
-				   enum i40e_hmc_lan_rsrc_type rsrc_type,
-				   u32 obj_idx)
+int i40e_hmc_get_object_va(struct i40e_hw *hw, u8 **object_base,
+			   enum i40e_hmc_lan_rsrc_type rsrc_type,
+			   u32 obj_idx)
 {
 	struct i40e_hmc_info *hmc_info = &hw->hmc;
 	u32 obj_offset_in_sd, obj_offset_in_pd;
 	struct i40e_hmc_sd_entry *sd_entry;
 	struct i40e_hmc_pd_entry *pd_entry;
 	u32 pd_idx, pd_lmt, rel_pd_idx;
-	i40e_status ret_code = 0;
 	u64 obj_offset_in_fpm;
 	u32 sd_idx, sd_lmt;
+	int ret_code = 0;
 
 	if (NULL == hmc_info) {
 		ret_code = I40E_ERR_BAD_PTR;
@@ -1042,11 +1042,11 @@ i40e_status i40e_hmc_get_object_va(struct i40e_hw *hw, u8 **object_base,
  * @hw:    the hardware struct
  * @queue: the queue we care about
  **/
-i40e_status i40e_clear_lan_tx_queue_context(struct i40e_hw *hw,
-						      u16 queue)
+int i40e_clear_lan_tx_queue_context(struct i40e_hw *hw,
+				    u16 queue)
 {
-	i40e_status err;
 	u8 *context_bytes;
+	int err;
 
 	err = i40e_hmc_get_object_va(hw, &context_bytes,
 				     I40E_HMC_LAN_TX, queue);
@@ -1062,12 +1062,12 @@ i40e_status i40e_clear_lan_tx_queue_context(struct i40e_hw *hw,
  * @queue: the queue we care about
  * @s:     the struct to be filled
  **/
-i40e_status i40e_set_lan_tx_queue_context(struct i40e_hw *hw,
-						    u16 queue,
-						    struct i40e_hmc_obj_txq *s)
+int i40e_set_lan_tx_queue_context(struct i40e_hw *hw,
+				  u16 queue,
+				  struct i40e_hmc_obj_txq *s)
 {
-	i40e_status err;
 	u8 *context_bytes;
+	int err;
 
 	err = i40e_hmc_get_object_va(hw, &context_bytes,
 				     I40E_HMC_LAN_TX, queue);
@@ -1083,11 +1083,11 @@ i40e_status i40e_set_lan_tx_queue_context(struct i40e_hw *hw,
  * @hw:    the hardware struct
  * @queue: the queue we care about
  **/
-i40e_status i40e_clear_lan_rx_queue_context(struct i40e_hw *hw,
-						      u16 queue)
+int i40e_clear_lan_rx_queue_context(struct i40e_hw *hw,
+				    u16 queue)
 {
-	i40e_status err;
 	u8 *context_bytes;
+	int err;
 
 	err = i40e_hmc_get_object_va(hw, &context_bytes,
 				     I40E_HMC_LAN_RX, queue);
@@ -1103,12 +1103,12 @@ i40e_status i40e_clear_lan_rx_queue_context(struct i40e_hw *hw,
  * @queue: the queue we care about
  * @s:     the struct to be filled
  **/
-i40e_status i40e_set_lan_rx_queue_context(struct i40e_hw *hw,
-						    u16 queue,
-						    struct i40e_hmc_obj_rxq *s)
+int i40e_set_lan_rx_queue_context(struct i40e_hw *hw,
+				  u16 queue,
+				  struct i40e_hmc_obj_rxq *s)
 {
-	i40e_status err;
 	u8 *context_bytes;
+	int err;
 
 	err = i40e_hmc_get_object_va(hw, &context_bytes,
 				     I40E_HMC_LAN_RX, queue);
diff --git a/drivers/net/ethernet/intel/i40e/i40e_lan_hmc.h b/drivers/net/ethernet/intel/i40e/i40e_lan_hmc.h
index c46a2c449e60..9f960404c2b3 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_lan_hmc.h
+++ b/drivers/net/ethernet/intel/i40e/i40e_lan_hmc.h
@@ -137,22 +137,22 @@ struct i40e_hmc_lan_delete_obj_info {
 	u32 count;
 };
 
-i40e_status i40e_init_lan_hmc(struct i40e_hw *hw, u32 txq_num,
-					u32 rxq_num, u32 fcoe_cntx_num,
-					u32 fcoe_filt_num);
-i40e_status i40e_configure_lan_hmc(struct i40e_hw *hw,
-					     enum i40e_hmc_model model);
-i40e_status i40e_shutdown_lan_hmc(struct i40e_hw *hw);
-
-i40e_status i40e_clear_lan_tx_queue_context(struct i40e_hw *hw,
-						      u16 queue);
-i40e_status i40e_set_lan_tx_queue_context(struct i40e_hw *hw,
-						    u16 queue,
-						    struct i40e_hmc_obj_txq *s);
-i40e_status i40e_clear_lan_rx_queue_context(struct i40e_hw *hw,
-						      u16 queue);
-i40e_status i40e_set_lan_rx_queue_context(struct i40e_hw *hw,
-						    u16 queue,
-						    struct i40e_hmc_obj_rxq *s);
+int i40e_init_lan_hmc(struct i40e_hw *hw, u32 txq_num,
+		      u32 rxq_num, u32 fcoe_cntx_num,
+		      u32 fcoe_filt_num);
+int i40e_configure_lan_hmc(struct i40e_hw *hw,
+			   enum i40e_hmc_model model);
+int i40e_shutdown_lan_hmc(struct i40e_hw *hw);
+
+int i40e_clear_lan_tx_queue_context(struct i40e_hw *hw,
+				    u16 queue);
+int i40e_set_lan_tx_queue_context(struct i40e_hw *hw,
+				  u16 queue,
+				  struct i40e_hmc_obj_txq *s);
+int i40e_clear_lan_rx_queue_context(struct i40e_hw *hw,
+				    u16 queue);
+int i40e_set_lan_rx_queue_context(struct i40e_hw *hw,
+				  u16 queue,
+				  struct i40e_hmc_obj_rxq *s);
 
 #endif /* _I40E_LAN_HMC_H_ */
diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 3ebd589e56b5..8411f277d135 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -1691,13 +1691,13 @@ static int i40e_set_mac(struct net_device *netdev, void *p)
 	spin_unlock_bh(&vsi->mac_filter_hash_lock);
 
 	if (vsi->type == I40E_VSI_MAIN) {
-		i40e_status ret;
+		int ret;
 
 		ret = i40e_aq_mac_address_write(hw, I40E_AQC_WRITE_TYPE_LAA_WOL,
 						addr->sa_data, NULL);
 		if (ret)
-			netdev_info(netdev, "Ignoring error from firmware on LAA update, status %s, AQ ret %s\n",
-				    i40e_stat_str(hw, ret),
+			netdev_info(netdev, "Ignoring error from firmware on LAA update, status %d, AQ ret %s\n",
+				    ret,
 				    i40e_aq_str(hw, hw->aq.asq_last_status));
 	}
 
@@ -1728,8 +1728,8 @@ static int i40e_config_rss_aq(struct i40e_vsi *vsi, const u8 *seed,
 		ret = i40e_aq_set_rss_key(hw, vsi->id, seed_dw);
 		if (ret) {
 			dev_info(&pf->pdev->dev,
-				 "Cannot set RSS key, err %s aq_err %s\n",
-				 i40e_stat_str(hw, ret),
+				 "Cannot set RSS key, err %d aq_err %s\n",
+				 ret,
 				 i40e_aq_str(hw, hw->aq.asq_last_status));
 			return ret;
 		}
@@ -1740,8 +1740,8 @@ static int i40e_config_rss_aq(struct i40e_vsi *vsi, const u8 *seed,
 		ret = i40e_aq_set_rss_lut(hw, vsi->id, pf_lut, lut, lut_size);
 		if (ret) {
 			dev_info(&pf->pdev->dev,
-				 "Cannot set RSS lut, err %s aq_err %s\n",
-				 i40e_stat_str(hw, ret),
+				 "Cannot set RSS lut, err %d aq_err %s\n",
+				 ret,
 				 i40e_aq_str(hw, hw->aq.asq_last_status));
 			return ret;
 		}
@@ -2222,7 +2222,7 @@ void i40e_aqc_del_filters(struct i40e_vsi *vsi, const char *vsi_name,
 			  int num_del, int *retval)
 {
 	struct i40e_hw *hw = &vsi->back->hw;
-	i40e_status aq_ret;
+	int aq_ret;
 	int aq_err;
 
 	aq_ret = i40e_aq_remove_macvlan(hw, vsi->seid, list, num_del, NULL);
@@ -2232,8 +2232,8 @@ void i40e_aqc_del_filters(struct i40e_vsi *vsi, const char *vsi_name,
 	if (aq_ret && !(aq_err == I40E_AQ_RC_ENOENT)) {
 		*retval = -EIO;
 		dev_info(&vsi->back->pdev->dev,
-			 "ignoring delete macvlan error on %s, err %s, aq_err %s\n",
-			 vsi_name, i40e_stat_str(hw, aq_ret),
+			 "ignoring delete macvlan error on %s, err %d, aq_err %s\n",
+			 vsi_name, aq_ret,
 			 i40e_aq_str(hw, aq_err));
 	}
 }
@@ -2295,13 +2295,13 @@ void i40e_aqc_add_filters(struct i40e_vsi *vsi, const char *vsi_name,
  *
  * Returns status indicating success or failure;
  **/
-static i40e_status
+static int
 i40e_aqc_broadcast_filter(struct i40e_vsi *vsi, const char *vsi_name,
 			  struct i40e_mac_filter *f)
 {
 	bool enable = f->state == I40E_FILTER_NEW;
 	struct i40e_hw *hw = &vsi->back->hw;
-	i40e_status aq_ret;
+	int aq_ret;
 
 	if (f->vlan == I40E_VLAN_ANY) {
 		aq_ret = i40e_aq_set_vsi_broadcast(hw,
@@ -2340,7 +2340,7 @@ static int i40e_set_promiscuous(struct i40e_pf *pf, bool promisc)
 {
 	struct i40e_vsi *vsi = pf->vsi[pf->lan_vsi];
 	struct i40e_hw *hw = &pf->hw;
-	i40e_status aq_ret;
+	int aq_ret;
 
 	if (vsi->type == I40E_VSI_MAIN &&
 	    pf->lan_veb != I40E_NO_VEB &&
@@ -2360,8 +2360,8 @@ static int i40e_set_promiscuous(struct i40e_pf *pf, bool promisc)
 							   NULL);
 		if (aq_ret) {
 			dev_info(&pf->pdev->dev,
-				 "Set default VSI failed, err %s, aq_err %s\n",
-				 i40e_stat_str(hw, aq_ret),
+				 "Set default VSI failed, err %d, aq_err %s\n",
+				 aq_ret,
 				 i40e_aq_str(hw, hw->aq.asq_last_status));
 		}
 	} else {
@@ -2372,8 +2372,8 @@ static int i40e_set_promiscuous(struct i40e_pf *pf, bool promisc)
 						  true);
 		if (aq_ret) {
 			dev_info(&pf->pdev->dev,
-				 "set unicast promisc failed, err %s, aq_err %s\n",
-				 i40e_stat_str(hw, aq_ret),
+				 "set unicast promisc failed, err %d, aq_err %s\n",
+				 aq_ret,
 				 i40e_aq_str(hw, hw->aq.asq_last_status));
 		}
 		aq_ret = i40e_aq_set_vsi_multicast_promiscuous(
@@ -2382,8 +2382,8 @@ static int i40e_set_promiscuous(struct i40e_pf *pf, bool promisc)
 						  promisc, NULL);
 		if (aq_ret) {
 			dev_info(&pf->pdev->dev,
-				 "set multicast promisc failed, err %s, aq_err %s\n",
-				 i40e_stat_str(hw, aq_ret),
+				 "set multicast promisc failed, err %d, aq_err %s\n",
+				 aq_ret,
 				 i40e_aq_str(hw, hw->aq.asq_last_status));
 		}
 	}
@@ -2413,12 +2413,12 @@ int i40e_sync_vsi_filters(struct i40e_vsi *vsi)
 	unsigned int vlan_filters = 0;
 	char vsi_name[16] = "PF";
 	int filter_list_len = 0;
-	i40e_status aq_ret = 0;
 	u32 changed_flags = 0;
 	struct hlist_node *h;
 	struct i40e_pf *pf;
 	int num_add = 0;
 	int num_del = 0;
+	int aq_ret = 0;
 	int retval = 0;
 	u16 cmd_flags;
 	int list_size;
@@ -2682,9 +2682,9 @@ int i40e_sync_vsi_filters(struct i40e_vsi *vsi)
 			retval = i40e_aq_rc_to_posix(aq_ret,
 						     hw->aq.asq_last_status);
 			dev_info(&pf->pdev->dev,
-				 "set multi promisc failed on %s, err %s aq_err %s\n",
+				 "set multi promisc failed on %s, err %d aq_err %s\n",
 				 vsi_name,
-				 i40e_stat_str(hw, aq_ret),
+				 aq_ret,
 				 i40e_aq_str(hw, hw->aq.asq_last_status));
 		} else {
 			dev_info(&pf->pdev->dev, "%s allmulti mode.\n",
@@ -2702,10 +2702,10 @@ int i40e_sync_vsi_filters(struct i40e_vsi *vsi)
 			retval = i40e_aq_rc_to_posix(aq_ret,
 						     hw->aq.asq_last_status);
 			dev_info(&pf->pdev->dev,
-				 "Setting promiscuous %s failed on %s, err %s aq_err %s\n",
+				 "Setting promiscuous %s failed on %s, err %d aq_err %s\n",
 				 cur_promisc ? "on" : "off",
 				 vsi_name,
-				 i40e_stat_str(hw, aq_ret),
+				 aq_ret,
 				 i40e_aq_str(hw, hw->aq.asq_last_status));
 		}
 	}
@@ -2833,7 +2833,7 @@ int i40e_ioctl(struct net_device *netdev, struct ifreq *ifr, int cmd)
 void i40e_vlan_stripping_enable(struct i40e_vsi *vsi)
 {
 	struct i40e_vsi_context ctxt;
-	i40e_status ret;
+	int ret;
 
 	/* Don't modify stripping options if a port VLAN is active */
 	if (vsi->info.pvid)
@@ -2853,8 +2853,8 @@ void i40e_vlan_stripping_enable(struct i40e_vsi *vsi)
 	ret = i40e_aq_update_vsi_params(&vsi->back->hw, &ctxt, NULL);
 	if (ret) {
 		dev_info(&vsi->back->pdev->dev,
-			 "update vlan stripping failed, err %s aq_err %s\n",
-			 i40e_stat_str(&vsi->back->hw, ret),
+			 "update vlan stripping failed, err %d aq_err %s\n",
+			 ret,
 			 i40e_aq_str(&vsi->back->hw,
 				     vsi->back->hw.aq.asq_last_status));
 	}
@@ -2867,7 +2867,7 @@ void i40e_vlan_stripping_enable(struct i40e_vsi *vsi)
 void i40e_vlan_stripping_disable(struct i40e_vsi *vsi)
 {
 	struct i40e_vsi_context ctxt;
-	i40e_status ret;
+	int ret;
 
 	/* Don't modify stripping options if a port VLAN is active */
 	if (vsi->info.pvid)
@@ -2888,8 +2888,8 @@ void i40e_vlan_stripping_disable(struct i40e_vsi *vsi)
 	ret = i40e_aq_update_vsi_params(&vsi->back->hw, &ctxt, NULL);
 	if (ret) {
 		dev_info(&vsi->back->pdev->dev,
-			 "update vlan stripping failed, err %s aq_err %s\n",
-			 i40e_stat_str(&vsi->back->hw, ret),
+			 "update vlan stripping failed, err %d aq_err %s\n",
+			 ret,
 			 i40e_aq_str(&vsi->back->hw,
 				     vsi->back->hw.aq.asq_last_status));
 	}
@@ -3107,7 +3107,7 @@ static void i40e_restore_vlan(struct i40e_vsi *vsi)
 int i40e_vsi_add_pvid(struct i40e_vsi *vsi, u16 vid)
 {
 	struct i40e_vsi_context ctxt;
-	i40e_status ret;
+	int ret;
 
 	vsi->info.valid_sections = cpu_to_le16(I40E_AQ_VSI_PROP_VLAN_VALID);
 	vsi->info.pvid = cpu_to_le16(vid);
@@ -3120,8 +3120,8 @@ int i40e_vsi_add_pvid(struct i40e_vsi *vsi, u16 vid)
 	ret = i40e_aq_update_vsi_params(&vsi->back->hw, &ctxt, NULL);
 	if (ret) {
 		dev_info(&vsi->back->pdev->dev,
-			 "add pvid failed, err %s aq_err %s\n",
-			 i40e_stat_str(&vsi->back->hw, ret),
+			 "add pvid failed, err %d aq_err %s\n",
+			 ret,
 			 i40e_aq_str(&vsi->back->hw,
 				     vsi->back->hw.aq.asq_last_status));
 		return -ENOENT;
@@ -3284,8 +3284,8 @@ static int i40e_configure_tx_ring(struct i40e_ring *ring)
 	u16 pf_q = vsi->base_queue + ring->queue_index;
 	struct i40e_hw *hw = &vsi->back->hw;
 	struct i40e_hmc_obj_txq tx_ctx;
-	i40e_status err = 0;
 	u32 qtx_ctl = 0;
+	int err = 0;
 
 	if (ring_is_xdp(ring))
 		ring->xsk_pool = i40e_xsk_pool(ring);
@@ -3409,7 +3409,7 @@ static int i40e_configure_rx_ring(struct i40e_ring *ring)
 	u16 pf_q = vsi->base_queue + ring->queue_index;
 	struct i40e_hw *hw = &vsi->back->hw;
 	struct i40e_hmc_obj_rxq rx_ctx;
-	i40e_status err = 0;
+	int err = 0;
 	bool ok;
 	int ret;
 
@@ -5389,16 +5389,16 @@ static int i40e_vsi_get_bw_info(struct i40e_vsi *vsi)
 	struct i40e_aqc_query_vsi_bw_config_resp bw_config = {0};
 	struct i40e_pf *pf = vsi->back;
 	struct i40e_hw *hw = &pf->hw;
-	i40e_status ret;
 	u32 tc_bw_max;
+	int ret;
 	int i;
 
 	/* Get the VSI level BW configuration */
 	ret = i40e_aq_query_vsi_bw_config(hw, vsi->seid, &bw_config, NULL);
 	if (ret) {
 		dev_info(&pf->pdev->dev,
-			 "couldn't get PF vsi bw config, err %s aq_err %s\n",
-			 i40e_stat_str(&pf->hw, ret),
+			 "couldn't get PF vsi bw config, err %d aq_err %s\n",
+			 ret,
 			 i40e_aq_str(&pf->hw, pf->hw.aq.asq_last_status));
 		return -EINVAL;
 	}
@@ -5408,8 +5408,8 @@ static int i40e_vsi_get_bw_info(struct i40e_vsi *vsi)
 					       NULL);
 	if (ret) {
 		dev_info(&pf->pdev->dev,
-			 "couldn't get PF vsi ets bw config, err %s aq_err %s\n",
-			 i40e_stat_str(&pf->hw, ret),
+			 "couldn't get PF vsi ets bw config, err %d aq_err %s\n",
+			 ret,
 			 i40e_aq_str(&pf->hw, pf->hw.aq.asq_last_status));
 		return -EINVAL;
 	}
@@ -5450,7 +5450,7 @@ static int i40e_vsi_configure_bw_alloc(struct i40e_vsi *vsi, u8 enabled_tc,
 {
 	struct i40e_aqc_configure_vsi_tc_bw_data bw_data;
 	struct i40e_pf *pf = vsi->back;
-	i40e_status ret;
+	int ret;
 	int i;
 
 	/* There is no need to reset BW when mqprio mode is on.  */
@@ -5598,8 +5598,8 @@ int i40e_update_adq_vsi_queues(struct i40e_vsi *vsi, int vsi_offset)
 
 	ret = i40e_aq_update_vsi_params(hw, &ctxt, NULL);
 	if (ret) {
-		dev_info(&pf->pdev->dev, "Update vsi config failed, err %s aq_err %s\n",
-			 i40e_stat_str(hw, ret),
+		dev_info(&pf->pdev->dev, "Update vsi config failed, err %d aq_err %s\n",
+			 ret,
 			 i40e_aq_str(hw, hw->aq.asq_last_status));
 		return ret;
 	}
@@ -5654,8 +5654,8 @@ static int i40e_vsi_config_tc(struct i40e_vsi *vsi, u8 enabled_tc)
 						  &bw_config, NULL);
 		if (ret) {
 			dev_info(&pf->pdev->dev,
-				 "Failed querying vsi bw info, err %s aq_err %s\n",
-				 i40e_stat_str(hw, ret),
+				 "Failed querying vsi bw info, err %d aq_err %s\n",
+				 ret,
 				 i40e_aq_str(hw, hw->aq.asq_last_status));
 			goto out;
 		}
@@ -5721,8 +5721,8 @@ static int i40e_vsi_config_tc(struct i40e_vsi *vsi, u8 enabled_tc)
 	ret = i40e_aq_update_vsi_params(hw, &ctxt, NULL);
 	if (ret) {
 		dev_info(&pf->pdev->dev,
-			 "Update vsi tc config failed, err %s aq_err %s\n",
-			 i40e_stat_str(hw, ret),
+			 "Update vsi tc config failed, err %d aq_err %s\n",
+			 ret,
 			 i40e_aq_str(hw, hw->aq.asq_last_status));
 		goto out;
 	}
@@ -5734,8 +5734,8 @@ static int i40e_vsi_config_tc(struct i40e_vsi *vsi, u8 enabled_tc)
 	ret = i40e_vsi_get_bw_info(vsi);
 	if (ret) {
 		dev_info(&pf->pdev->dev,
-			 "Failed updating vsi bw info, err %s aq_err %s\n",
-			 i40e_stat_str(hw, ret),
+			 "Failed updating vsi bw info, err %d aq_err %s\n",
+			 ret,
 			 i40e_aq_str(hw, hw->aq.asq_last_status));
 		goto out;
 	}
@@ -5826,8 +5826,8 @@ int i40e_set_bw_limit(struct i40e_vsi *vsi, u16 seid, u64 max_tx_rate)
 					  I40E_MAX_BW_INACTIVE_ACCUM, NULL);
 	if (ret)
 		dev_err(&pf->pdev->dev,
-			"Failed set tx rate (%llu Mbps) for vsi->seid %u, err %s aq_err %s\n",
-			max_tx_rate, seid, i40e_stat_str(&pf->hw, ret),
+			"Failed set tx rate (%llu Mbps) for vsi->seid %u, err %d aq_err %s\n",
+			max_tx_rate, seid, ret,
 			i40e_aq_str(&pf->hw, pf->hw.aq.asq_last_status));
 	return ret;
 }
@@ -5902,8 +5902,8 @@ static void i40e_remove_queue_channels(struct i40e_vsi *vsi)
 			last_aq_status = pf->hw.aq.asq_last_status;
 			if (ret)
 				dev_info(&pf->pdev->dev,
-					 "Failed to delete cloud filter, err %s aq_err %s\n",
-					 i40e_stat_str(&pf->hw, ret),
+					 "Failed to delete cloud filter, err %d aq_err %s\n",
+					 ret,
 					 i40e_aq_str(&pf->hw, last_aq_status));
 			kfree(cfilter);
 		}
@@ -6037,8 +6037,8 @@ static int i40e_vsi_reconfig_rss(struct i40e_vsi *vsi, u16 rss_size)
 	ret = i40e_config_rss(vsi, seed, lut, vsi->rss_table_size);
 	if (ret) {
 		dev_info(&pf->pdev->dev,
-			 "Cannot set RSS lut, err %s aq_err %s\n",
-			 i40e_stat_str(hw, ret),
+			 "Cannot set RSS lut, err %d aq_err %s\n",
+			 ret,
 			 i40e_aq_str(hw, hw->aq.asq_last_status));
 		kfree(lut);
 		return ret;
@@ -6136,8 +6136,8 @@ static int i40e_add_channel(struct i40e_pf *pf, u16 uplink_seid,
 	ret = i40e_aq_add_vsi(hw, &ctxt, NULL);
 	if (ret) {
 		dev_info(&pf->pdev->dev,
-			 "add new vsi failed, err %s aq_err %s\n",
-			 i40e_stat_str(&pf->hw, ret),
+			 "add new vsi failed, err %d aq_err %s\n",
+			 ret,
 			 i40e_aq_str(&pf->hw,
 				     pf->hw.aq.asq_last_status));
 		return -ENOENT;
@@ -6168,7 +6168,7 @@ static int i40e_channel_config_bw(struct i40e_vsi *vsi, struct i40e_channel *ch,
 				  u8 *bw_share)
 {
 	struct i40e_aqc_configure_vsi_tc_bw_data bw_data;
-	i40e_status ret;
+	int ret;
 	int i;
 
 	memset(&bw_data, 0, sizeof(bw_data));
@@ -6204,9 +6204,9 @@ static int i40e_channel_config_tx_ring(struct i40e_pf *pf,
 				       struct i40e_vsi *vsi,
 				       struct i40e_channel *ch)
 {
-	i40e_status ret;
-	int i;
 	u8 bw_share[I40E_MAX_TRAFFIC_CLASS] = {0};
+	int ret;
+	int i;
 
 	/* Enable ETS TCs with equal BW Share for now across all VSIs */
 	for (i = 0; i < I40E_MAX_TRAFFIC_CLASS; i++) {
@@ -6382,8 +6382,8 @@ static int i40e_validate_and_set_switch_mode(struct i40e_vsi *vsi)
 					mode, NULL);
 	if (ret && hw->aq.asq_last_status != I40E_AQ_RC_ESRCH)
 		dev_err(&pf->pdev->dev,
-			"couldn't set switch config bits, err %s aq_err %s\n",
-			i40e_stat_str(hw, ret),
+			"couldn't set switch config bits, err %d aq_err %s\n",
+			ret,
 			i40e_aq_str(hw,
 				    hw->aq.asq_last_status));
 
@@ -6583,8 +6583,8 @@ int i40e_veb_config_tc(struct i40e_veb *veb, u8 enabled_tc)
 						   &bw_data, NULL);
 	if (ret) {
 		dev_info(&pf->pdev->dev,
-			 "VEB bw config failed, err %s aq_err %s\n",
-			 i40e_stat_str(&pf->hw, ret),
+			 "VEB bw config failed, err %d aq_err %s\n",
+			 ret,
 			 i40e_aq_str(&pf->hw, pf->hw.aq.asq_last_status));
 		goto out;
 	}
@@ -6593,8 +6593,8 @@ int i40e_veb_config_tc(struct i40e_veb *veb, u8 enabled_tc)
 	ret = i40e_veb_get_bw_info(veb);
 	if (ret) {
 		dev_info(&pf->pdev->dev,
-			 "Failed getting veb bw config, err %s aq_err %s\n",
-			 i40e_stat_str(&pf->hw, ret),
+			 "Failed getting veb bw config, err %d aq_err %s\n",
+			 ret,
 			 i40e_aq_str(&pf->hw, pf->hw.aq.asq_last_status));
 	}
 
@@ -6677,8 +6677,8 @@ static int i40e_resume_port_tx(struct i40e_pf *pf)
 	ret = i40e_aq_resume_port_tx(hw, NULL);
 	if (ret) {
 		dev_info(&pf->pdev->dev,
-			 "Resume Port Tx failed, err %s aq_err %s\n",
-			  i40e_stat_str(&pf->hw, ret),
+			 "Resume Port Tx failed, err %d aq_err %s\n",
+			  ret,
 			  i40e_aq_str(&pf->hw, pf->hw.aq.asq_last_status));
 		/* Schedule PF reset to recover */
 		set_bit(__I40E_PF_RESET_REQUESTED, pf->state);
@@ -6702,8 +6702,8 @@ static int i40e_suspend_port_tx(struct i40e_pf *pf)
 	ret = i40e_aq_suspend_port_tx(hw, pf->mac_seid, NULL);
 	if (ret) {
 		dev_info(&pf->pdev->dev,
-			 "Suspend Port Tx failed, err %s aq_err %s\n",
-			 i40e_stat_str(&pf->hw, ret),
+			 "Suspend Port Tx failed, err %d aq_err %s\n",
+			 ret,
 			 i40e_aq_str(&pf->hw, pf->hw.aq.asq_last_status));
 		/* Schedule PF reset to recover */
 		set_bit(__I40E_PF_RESET_REQUESTED, pf->state);
@@ -6742,8 +6742,8 @@ static int i40e_hw_set_dcb_config(struct i40e_pf *pf,
 	ret = i40e_set_dcb_config(&pf->hw);
 	if (ret) {
 		dev_info(&pf->pdev->dev,
-			 "Set DCB Config failed, err %s aq_err %s\n",
-			 i40e_stat_str(&pf->hw, ret),
+			 "Set DCB Config failed, err %d aq_err %s\n",
+			 ret,
 			 i40e_aq_str(&pf->hw, pf->hw.aq.asq_last_status));
 		goto out;
 	}
@@ -6859,8 +6859,8 @@ int i40e_hw_dcb_config(struct i40e_pf *pf, struct i40e_dcbx_config *new_cfg)
 		 i40e_aqc_opc_modify_switching_comp_ets, NULL);
 	if (ret) {
 		dev_info(&pf->pdev->dev,
-			 "Modify Port ETS failed, err %s aq_err %s\n",
-			 i40e_stat_str(&pf->hw, ret),
+			 "Modify Port ETS failed, err %d aq_err %s\n",
+			 ret,
 			 i40e_aq_str(&pf->hw, pf->hw.aq.asq_last_status));
 		goto out;
 	}
@@ -6897,8 +6897,8 @@ int i40e_hw_dcb_config(struct i40e_pf *pf, struct i40e_dcbx_config *new_cfg)
 	ret = i40e_aq_dcb_updated(&pf->hw, NULL);
 	if (ret) {
 		dev_info(&pf->pdev->dev,
-			 "DCB Updated failed, err %s aq_err %s\n",
-			 i40e_stat_str(&pf->hw, ret),
+			 "DCB Updated failed, err %d aq_err %s\n",
+			 ret,
 			 i40e_aq_str(&pf->hw, pf->hw.aq.asq_last_status));
 		goto out;
 	}
@@ -6981,8 +6981,8 @@ int i40e_dcb_sw_default_config(struct i40e_pf *pf)
 		 i40e_aqc_opc_enable_switching_comp_ets, NULL);
 	if (err) {
 		dev_info(&pf->pdev->dev,
-			 "Enable Port ETS failed, err %s aq_err %s\n",
-			 i40e_stat_str(&pf->hw, err),
+			 "Enable Port ETS failed, err %d aq_err %s\n",
+			 err,
 			 i40e_aq_str(&pf->hw, pf->hw.aq.asq_last_status));
 		err = -ENOENT;
 		goto out;
@@ -7061,8 +7061,8 @@ static int i40e_init_pf_dcb(struct i40e_pf *pf)
 		pf->flags |= I40E_FLAG_DISABLE_FW_LLDP;
 	} else {
 		dev_info(&pf->pdev->dev,
-			 "Query for DCB configuration failed, err %s aq_err %s\n",
-			 i40e_stat_str(&pf->hw, err),
+			 "Query for DCB configuration failed, err %d aq_err %s\n",
+			 err,
 			 i40e_aq_str(&pf->hw, pf->hw.aq.asq_last_status));
 	}
 
@@ -7280,15 +7280,15 @@ static void i40e_vsi_reinit_locked(struct i40e_vsi *vsi)
  * @pf: board private structure
  * @is_up: whether the link state should be forced up or down
  **/
-static i40e_status i40e_force_link_state(struct i40e_pf *pf, bool is_up)
+static int i40e_force_link_state(struct i40e_pf *pf, bool is_up)
 {
 	struct i40e_aq_get_phy_abilities_resp abilities;
 	struct i40e_aq_set_phy_config config = {0};
 	bool non_zero_phy_type = is_up;
 	struct i40e_hw *hw = &pf->hw;
-	i40e_status err;
 	u64 mask;
 	u8 speed;
+	int err;
 
 	/* Card might've been put in an unstable state by other drivers
 	 * and applications, which causes incorrect speed values being
@@ -7300,8 +7300,8 @@ static i40e_status i40e_force_link_state(struct i40e_pf *pf, bool is_up)
 					   NULL);
 	if (err) {
 		dev_err(&pf->pdev->dev,
-			"failed to get phy cap., ret =  %s last_status =  %s\n",
-			i40e_stat_str(hw, err),
+			"failed to get phy cap., ret =  %d last_status =  %s\n",
+			err,
 			i40e_aq_str(hw, hw->aq.asq_last_status));
 		return err;
 	}
@@ -7312,8 +7312,8 @@ static i40e_status i40e_force_link_state(struct i40e_pf *pf, bool is_up)
 					   NULL);
 	if (err) {
 		dev_err(&pf->pdev->dev,
-			"failed to get phy cap., ret =  %s last_status =  %s\n",
-			i40e_stat_str(hw, err),
+			"failed to get phy cap., ret =  %d last_status =  %s\n",
+			err,
 			i40e_aq_str(hw, hw->aq.asq_last_status));
 		return err;
 	}
@@ -7357,8 +7357,8 @@ static i40e_status i40e_force_link_state(struct i40e_pf *pf, bool is_up)
 
 	if (err) {
 		dev_err(&pf->pdev->dev,
-			"set phy config ret =  %s last_status =  %s\n",
-			i40e_stat_str(&pf->hw, err),
+			"set phy config ret =  %d last_status =  %s\n",
+			err,
 			i40e_aq_str(&pf->hw, pf->hw.aq.asq_last_status));
 		return err;
 	}
@@ -7521,11 +7521,11 @@ static void i40e_vsi_set_default_tc_config(struct i40e_vsi *vsi)
  * This function deletes a mac filter on the channel VSI which serves as the
  * macvlan. Returns 0 on success.
  **/
-static i40e_status i40e_del_macvlan_filter(struct i40e_hw *hw, u16 seid,
-					   const u8 *macaddr, int *aq_err)
+static int i40e_del_macvlan_filter(struct i40e_hw *hw, u16 seid,
+				   const u8 *macaddr, int *aq_err)
 {
 	struct i40e_aqc_remove_macvlan_element_data element;
-	i40e_status status;
+	int status;
 
 	memset(&element, 0, sizeof(element));
 	ether_addr_copy(element.mac_addr, macaddr);
@@ -7547,12 +7547,12 @@ static i40e_status i40e_del_macvlan_filter(struct i40e_hw *hw, u16 seid,
  * This function adds a mac filter on the channel VSI which serves as the
  * macvlan. Returns 0 on success.
  **/
-static i40e_status i40e_add_macvlan_filter(struct i40e_hw *hw, u16 seid,
-					   const u8 *macaddr, int *aq_err)
+static int i40e_add_macvlan_filter(struct i40e_hw *hw, u16 seid,
+				   const u8 *macaddr, int *aq_err)
 {
 	struct i40e_aqc_add_macvlan_element_data element;
-	i40e_status status;
 	u16 cmd_flags = 0;
+	int status;
 
 	ether_addr_copy(element.mac_addr, macaddr);
 	element.vlan_tag = 0;
@@ -7698,8 +7698,8 @@ static int i40e_fwd_ring_up(struct i40e_vsi *vsi, struct net_device *vdev,
 			rx_ring->netdev = NULL;
 		}
 		dev_info(&pf->pdev->dev,
-			 "Error adding mac filter on macvlan err %s, aq_err %s\n",
-			  i40e_stat_str(hw, ret),
+			 "Error adding mac filter on macvlan err %d, aq_err %s\n",
+			  ret,
 			  i40e_aq_str(hw, aq_err));
 		netdev_err(vdev, "L2fwd offload disabled to L2 filter error\n");
 	}
@@ -7771,8 +7771,8 @@ static int i40e_setup_macvlans(struct i40e_vsi *vsi, u16 macvlan_cnt, u16 qcnt,
 	ret = i40e_aq_update_vsi_params(hw, &ctxt, NULL);
 	if (ret) {
 		dev_info(&pf->pdev->dev,
-			 "Update vsi tc config failed, err %s aq_err %s\n",
-			 i40e_stat_str(hw, ret),
+			 "Update vsi tc config failed, err %d aq_err %s\n",
+			 ret,
 			 i40e_aq_str(hw, hw->aq.asq_last_status));
 		return ret;
 	}
@@ -7987,8 +7987,8 @@ static void i40e_fwd_del(struct net_device *netdev, void *vdev)
 				ch->fwd = NULL;
 			} else {
 				dev_info(&pf->pdev->dev,
-					 "Error deleting mac filter on macvlan err %s, aq_err %s\n",
-					  i40e_stat_str(hw, ret),
+					 "Error deleting mac filter on macvlan err %d, aq_err %s\n",
+					  ret,
 					  i40e_aq_str(hw, aq_err));
 			}
 			break;
@@ -8739,8 +8739,7 @@ static int i40e_delete_clsflower(struct i40e_vsi *vsi,
 	kfree(filter);
 	if (err) {
 		dev_err(&pf->pdev->dev,
-			"Failed to delete cloud filter, err %s\n",
-			i40e_stat_str(&pf->hw, err));
+			"Failed to delete cloud filter, err %d\n", err);
 		return i40e_aq_rc_to_posix(err, pf->hw.aq.asq_last_status);
 	}
 
@@ -9302,8 +9301,8 @@ static int i40e_handle_lldp_event(struct i40e_pf *pf,
 			pf->flags &= ~I40E_FLAG_DCB_CAPABLE;
 		} else {
 			dev_info(&pf->pdev->dev,
-				 "Failed querying DCB configuration data from firmware, err %s aq_err %s\n",
-				 i40e_stat_str(&pf->hw, ret),
+				 "Failed querying DCB configuration data from firmware, err %d aq_err %s\n",
+				 ret,
 				 i40e_aq_str(&pf->hw,
 					     pf->hw.aq.asq_last_status));
 		}
@@ -9751,8 +9750,8 @@ static void i40e_link_event(struct i40e_pf *pf)
 {
 	struct i40e_vsi *vsi = pf->vsi[pf->lan_vsi];
 	u8 new_link_speed, old_link_speed;
-	i40e_status status;
 	bool new_link, old_link;
+	int status;
 #ifdef CONFIG_I40E_DCB
 	int err;
 #endif /* CONFIG_I40E_DCB */
@@ -9963,9 +9962,9 @@ static void i40e_clean_adminq_subtask(struct i40e_pf *pf)
 	struct i40e_arq_event_info event;
 	struct i40e_hw *hw = &pf->hw;
 	u16 pending, i = 0;
-	i40e_status ret;
 	u16 opcode;
 	u32 oldval;
+	int ret;
 	u32 val;
 
 	/* Do not run clean AQ when PF reset fails */
@@ -10129,8 +10128,8 @@ static void i40e_enable_pf_switch_lb(struct i40e_pf *pf)
 	ret = i40e_aq_get_vsi_params(&pf->hw, &ctxt, NULL);
 	if (ret) {
 		dev_info(&pf->pdev->dev,
-			 "couldn't get PF vsi config, err %s aq_err %s\n",
-			 i40e_stat_str(&pf->hw, ret),
+			 "couldn't get PF vsi config, err %d aq_err %s\n",
+			 ret,
 			 i40e_aq_str(&pf->hw, pf->hw.aq.asq_last_status));
 		return;
 	}
@@ -10141,8 +10140,8 @@ static void i40e_enable_pf_switch_lb(struct i40e_pf *pf)
 	ret = i40e_aq_update_vsi_params(&vsi->back->hw, &ctxt, NULL);
 	if (ret) {
 		dev_info(&pf->pdev->dev,
-			 "update vsi switch failed, err %s aq_err %s\n",
-			 i40e_stat_str(&pf->hw, ret),
+			 "update vsi switch failed, err %d aq_err %s\n",
+			 ret,
 			 i40e_aq_str(&pf->hw, pf->hw.aq.asq_last_status));
 	}
 }
@@ -10165,8 +10164,8 @@ static void i40e_disable_pf_switch_lb(struct i40e_pf *pf)
 	ret = i40e_aq_get_vsi_params(&pf->hw, &ctxt, NULL);
 	if (ret) {
 		dev_info(&pf->pdev->dev,
-			 "couldn't get PF vsi config, err %s aq_err %s\n",
-			 i40e_stat_str(&pf->hw, ret),
+			 "couldn't get PF vsi config, err %d aq_err %s\n",
+			 ret,
 			 i40e_aq_str(&pf->hw, pf->hw.aq.asq_last_status));
 		return;
 	}
@@ -10177,8 +10176,8 @@ static void i40e_disable_pf_switch_lb(struct i40e_pf *pf)
 	ret = i40e_aq_update_vsi_params(&vsi->back->hw, &ctxt, NULL);
 	if (ret) {
 		dev_info(&pf->pdev->dev,
-			 "update vsi switch failed, err %s aq_err %s\n",
-			 i40e_stat_str(&pf->hw, ret),
+			 "update vsi switch failed, err %d aq_err %s\n",
+			 ret,
 			 i40e_aq_str(&pf->hw, pf->hw.aq.asq_last_status));
 	}
 }
@@ -10322,8 +10321,8 @@ static int i40e_get_capabilities(struct i40e_pf *pf,
 			buf_len = data_size;
 		} else if (pf->hw.aq.asq_last_status != I40E_AQ_RC_OK || err) {
 			dev_info(&pf->pdev->dev,
-				 "capability discovery failed, err %s aq_err %s\n",
-				 i40e_stat_str(&pf->hw, err),
+				 "capability discovery failed, err %d aq_err %s\n",
+				 err,
 				 i40e_aq_str(&pf->hw,
 					     pf->hw.aq.asq_last_status));
 			return -ENODEV;
@@ -10444,7 +10443,7 @@ static int i40e_rebuild_cloud_filters(struct i40e_vsi *vsi, u16 seid)
 	struct i40e_cloud_filter *cfilter;
 	struct i40e_pf *pf = vsi->back;
 	struct hlist_node *node;
-	i40e_status ret;
+	int ret;
 
 	/* Add cloud filters back if they exist */
 	hlist_for_each_entry_safe(cfilter, node, &pf->cloud_filter_list,
@@ -10460,8 +10459,8 @@ static int i40e_rebuild_cloud_filters(struct i40e_vsi *vsi, u16 seid)
 
 		if (ret) {
 			dev_dbg(&pf->pdev->dev,
-				"Failed to rebuild cloud filter, err %s aq_err %s\n",
-				i40e_stat_str(&pf->hw, ret),
+				"Failed to rebuild cloud filter, err %d aq_err %s\n",
+				ret,
 				i40e_aq_str(&pf->hw,
 					    pf->hw.aq.asq_last_status));
 			return ret;
@@ -10479,7 +10478,7 @@ static int i40e_rebuild_cloud_filters(struct i40e_vsi *vsi, u16 seid)
 static int i40e_rebuild_channels(struct i40e_vsi *vsi)
 {
 	struct i40e_channel *ch, *ch_tmp;
-	i40e_status ret;
+	int ret;
 
 	if (list_empty(&vsi->ch_list))
 		return 0;
@@ -10555,7 +10554,7 @@ static void i40e_clean_xps_state(struct i40e_vsi *vsi)
 static void i40e_prep_for_reset(struct i40e_pf *pf)
 {
 	struct i40e_hw *hw = &pf->hw;
-	i40e_status ret = 0;
+	int ret = 0;
 	u32 v;
 
 	clear_bit(__I40E_RESET_INTR_RECEIVED, pf->state);
@@ -10660,7 +10659,7 @@ static void i40e_get_oem_version(struct i40e_hw *hw)
 static int i40e_reset(struct i40e_pf *pf)
 {
 	struct i40e_hw *hw = &pf->hw;
-	i40e_status ret;
+	int ret;
 
 	ret = i40e_pf_reset(hw);
 	if (ret) {
@@ -10685,7 +10684,7 @@ static void i40e_rebuild(struct i40e_pf *pf, bool reinit, bool lock_acquired)
 	const bool is_recovery_mode_reported = i40e_check_recovery_mode(pf);
 	struct i40e_vsi *vsi = pf->vsi[pf->lan_vsi];
 	struct i40e_hw *hw = &pf->hw;
-	i40e_status ret;
+	int ret;
 	u32 val;
 	int v;
 
@@ -10701,8 +10700,8 @@ static void i40e_rebuild(struct i40e_pf *pf, bool reinit, bool lock_acquired)
 	/* rebuild the basics for the AdminQ, HMC, and initial HW switch */
 	ret = i40e_init_adminq(&pf->hw);
 	if (ret) {
-		dev_info(&pf->pdev->dev, "Rebuild AdminQ failed, err %s aq_err %s\n",
-			 i40e_stat_str(&pf->hw, ret),
+		dev_info(&pf->pdev->dev, "Rebuild AdminQ failed, err %d aq_err %s\n",
+			 ret,
 			 i40e_aq_str(&pf->hw, pf->hw.aq.asq_last_status));
 		goto clear_recovery;
 	}
@@ -10813,8 +10812,8 @@ static void i40e_rebuild(struct i40e_pf *pf, bool reinit, bool lock_acquired)
 					 I40E_AQ_EVENT_MEDIA_NA |
 					 I40E_AQ_EVENT_MODULE_QUAL_FAIL), NULL);
 	if (ret)
-		dev_info(&pf->pdev->dev, "set phy mask fail, err %s aq_err %s\n",
-			 i40e_stat_str(&pf->hw, ret),
+		dev_info(&pf->pdev->dev, "set phy mask fail, err %d aq_err %s\n",
+			 ret,
 			 i40e_aq_str(&pf->hw, pf->hw.aq.asq_last_status));
 
 	/* Rebuild the VSIs and VEBs that existed before reset.
@@ -10917,8 +10916,8 @@ static void i40e_rebuild(struct i40e_pf *pf, bool reinit, bool lock_acquired)
 		msleep(75);
 		ret = i40e_aq_set_link_restart_an(&pf->hw, true, NULL);
 		if (ret)
-			dev_info(&pf->pdev->dev, "link restart failed, err %s aq_err %s\n",
-				 i40e_stat_str(&pf->hw, ret),
+			dev_info(&pf->pdev->dev, "link restart failed, err %d aq_err %s\n",
+				 ret,
 				 i40e_aq_str(&pf->hw,
 					     pf->hw.aq.asq_last_status));
 	}
@@ -10949,9 +10948,9 @@ static void i40e_rebuild(struct i40e_pf *pf, bool reinit, bool lock_acquired)
 	ret = i40e_set_promiscuous(pf, pf->cur_promisc);
 	if (ret)
 		dev_warn(&pf->pdev->dev,
-			 "Failed to restore promiscuous setting: %s, err %s aq_err %s\n",
+			 "Failed to restore promiscuous setting: %s, err %d aq_err %s\n",
 			 pf->cur_promisc ? "on" : "off",
-			 i40e_stat_str(&pf->hw, ret),
+			 ret,
 			 i40e_aq_str(&pf->hw, pf->hw.aq.asq_last_status));
 
 	i40e_reset_all_vfs(pf, true);
@@ -12086,8 +12085,8 @@ static int i40e_get_rss_aq(struct i40e_vsi *vsi, const u8 *seed,
 			(struct i40e_aqc_get_set_rss_key_data *)seed);
 		if (ret) {
 			dev_info(&pf->pdev->dev,
-				 "Cannot get RSS key, err %s aq_err %s\n",
-				 i40e_stat_str(&pf->hw, ret),
+				 "Cannot get RSS key, err %d aq_err %s\n",
+				 ret,
 				 i40e_aq_str(&pf->hw,
 					     pf->hw.aq.asq_last_status));
 			return ret;
@@ -12100,8 +12099,8 @@ static int i40e_get_rss_aq(struct i40e_vsi *vsi, const u8 *seed,
 		ret = i40e_aq_get_rss_lut(hw, vsi->id, pf_lut, lut, lut_size);
 		if (ret) {
 			dev_info(&pf->pdev->dev,
-				 "Cannot get RSS lut, err %s aq_err %s\n",
-				 i40e_stat_str(&pf->hw, ret),
+				 "Cannot get RSS lut, err %d aq_err %s\n",
+				 ret,
 				 i40e_aq_str(&pf->hw,
 					     pf->hw.aq.asq_last_status));
 			return ret;
@@ -12376,11 +12375,11 @@ int i40e_reconfig_rss_queues(struct i40e_pf *pf, int queue_count)
  * i40e_get_partition_bw_setting - Retrieve BW settings for this PF partition
  * @pf: board private structure
  **/
-i40e_status i40e_get_partition_bw_setting(struct i40e_pf *pf)
+int i40e_get_partition_bw_setting(struct i40e_pf *pf)
 {
-	i40e_status status;
 	bool min_valid, max_valid;
 	u32 max_bw, min_bw;
+	int status;
 
 	status = i40e_read_bw_from_alt_ram(&pf->hw, &max_bw, &min_bw,
 					   &min_valid, &max_valid);
@@ -12399,10 +12398,10 @@ i40e_status i40e_get_partition_bw_setting(struct i40e_pf *pf)
  * i40e_set_partition_bw_setting - Set BW settings for this PF partition
  * @pf: board private structure
  **/
-i40e_status i40e_set_partition_bw_setting(struct i40e_pf *pf)
+int i40e_set_partition_bw_setting(struct i40e_pf *pf)
 {
 	struct i40e_aqc_configure_partition_bw_data bw_data;
-	i40e_status status;
+	int status;
 
 	memset(&bw_data, 0, sizeof(bw_data));
 
@@ -12421,12 +12420,12 @@ i40e_status i40e_set_partition_bw_setting(struct i40e_pf *pf)
  * i40e_commit_partition_bw_setting - Commit BW settings for this PF partition
  * @pf: board private structure
  **/
-i40e_status i40e_commit_partition_bw_setting(struct i40e_pf *pf)
+int i40e_commit_partition_bw_setting(struct i40e_pf *pf)
 {
 	/* Commit temporary BW setting to permanent NVM image */
 	enum i40e_admin_queue_err last_aq_status;
-	i40e_status ret;
 	u16 nvm_word;
+	int ret;
 
 	if (pf->hw.partition_id != 1) {
 		dev_info(&pf->pdev->dev,
@@ -12441,8 +12440,8 @@ i40e_status i40e_commit_partition_bw_setting(struct i40e_pf *pf)
 	last_aq_status = pf->hw.aq.asq_last_status;
 	if (ret) {
 		dev_info(&pf->pdev->dev,
-			 "Cannot acquire NVM for read access, err %s aq_err %s\n",
-			 i40e_stat_str(&pf->hw, ret),
+			 "Cannot acquire NVM for read access, err %d aq_err %s\n",
+			 ret,
 			 i40e_aq_str(&pf->hw, last_aq_status));
 		goto bw_commit_out;
 	}
@@ -12458,8 +12457,8 @@ i40e_status i40e_commit_partition_bw_setting(struct i40e_pf *pf)
 	last_aq_status = pf->hw.aq.asq_last_status;
 	i40e_release_nvm(&pf->hw);
 	if (ret) {
-		dev_info(&pf->pdev->dev, "NVM read error, err %s aq_err %s\n",
-			 i40e_stat_str(&pf->hw, ret),
+		dev_info(&pf->pdev->dev, "NVM read error, err %d aq_err %s\n",
+			 ret,
 			 i40e_aq_str(&pf->hw, last_aq_status));
 		goto bw_commit_out;
 	}
@@ -12472,8 +12471,8 @@ i40e_status i40e_commit_partition_bw_setting(struct i40e_pf *pf)
 	last_aq_status = pf->hw.aq.asq_last_status;
 	if (ret) {
 		dev_info(&pf->pdev->dev,
-			 "Cannot acquire NVM for write access, err %s aq_err %s\n",
-			 i40e_stat_str(&pf->hw, ret),
+			 "Cannot acquire NVM for write access, err %d aq_err %s\n",
+			 ret,
 			 i40e_aq_str(&pf->hw, last_aq_status));
 		goto bw_commit_out;
 	}
@@ -12492,8 +12491,8 @@ i40e_status i40e_commit_partition_bw_setting(struct i40e_pf *pf)
 	i40e_release_nvm(&pf->hw);
 	if (ret)
 		dev_info(&pf->pdev->dev,
-			 "BW settings NOT SAVED, err %s aq_err %s\n",
-			 i40e_stat_str(&pf->hw, ret),
+			 "BW settings NOT SAVED, err %d aq_err %s\n",
+			 ret,
 			 i40e_aq_str(&pf->hw, last_aq_status));
 bw_commit_out:
 
@@ -12514,7 +12513,7 @@ static bool i40e_is_total_port_shutdown_enabled(struct i40e_pf *pf)
 #define I40E_LINK_BEHAVIOR_WORD_LENGTH		0x1
 #define I40E_LINK_BEHAVIOR_OS_FORCED_ENABLED	BIT(0)
 #define I40E_LINK_BEHAVIOR_PORT_BIT_LENGTH	4
-	i40e_status read_status = I40E_SUCCESS;
+	int read_status = I40E_SUCCESS;
 	u16 sr_emp_sr_settings_ptr = 0;
 	u16 features_enable = 0;
 	u16 link_behavior = 0;
@@ -12547,8 +12546,8 @@ static bool i40e_is_total_port_shutdown_enabled(struct i40e_pf *pf)
 
 err_nvm:
 	dev_warn(&pf->pdev->dev,
-		 "total-port-shutdown feature is off due to read nvm error: %s\n",
-		 i40e_stat_str(&pf->hw, read_status));
+		 "total-port-shutdown feature is off due to read nvm error: %d\n",
+		 read_status);
 	return ret;
 }
 
@@ -12866,7 +12865,7 @@ static int i40e_udp_tunnel_set_port(struct net_device *netdev,
 	struct i40e_netdev_priv *np = netdev_priv(netdev);
 	struct i40e_hw *hw = &np->vsi->back->hw;
 	u8 type, filter_index;
-	i40e_status ret;
+	int ret;
 
 	type = ti->type == UDP_TUNNEL_TYPE_VXLAN ? I40E_AQC_TUNNEL_TYPE_VXLAN :
 						   I40E_AQC_TUNNEL_TYPE_NGE;
@@ -12874,8 +12873,8 @@ static int i40e_udp_tunnel_set_port(struct net_device *netdev,
 	ret = i40e_aq_add_udp_tunnel(hw, ntohs(ti->port), type, &filter_index,
 				     NULL);
 	if (ret) {
-		netdev_info(netdev, "add UDP port failed, err %s aq_err %s\n",
-			    i40e_stat_str(hw, ret),
+		netdev_info(netdev, "add UDP port failed, err %d aq_err %s\n",
+			    ret,
 			    i40e_aq_str(hw, hw->aq.asq_last_status));
 		return -EIO;
 	}
@@ -12890,12 +12889,12 @@ static int i40e_udp_tunnel_unset_port(struct net_device *netdev,
 {
 	struct i40e_netdev_priv *np = netdev_priv(netdev);
 	struct i40e_hw *hw = &np->vsi->back->hw;
-	i40e_status ret;
+	int ret;
 
 	ret = i40e_aq_del_udp_tunnel(hw, ti->hw_priv, NULL);
 	if (ret) {
-		netdev_info(netdev, "delete UDP port failed, err %s aq_err %s\n",
-			    i40e_stat_str(hw, ret),
+		netdev_info(netdev, "delete UDP port failed, err %d aq_err %s\n",
+			    ret,
 			    i40e_aq_str(hw, hw->aq.asq_last_status));
 		return -EIO;
 	}
@@ -13766,8 +13765,8 @@ static int i40e_add_vsi(struct i40e_vsi *vsi)
 		ctxt.flags = I40E_AQ_VSI_TYPE_PF;
 		if (ret) {
 			dev_info(&pf->pdev->dev,
-				 "couldn't get PF vsi config, err %s aq_err %s\n",
-				 i40e_stat_str(&pf->hw, ret),
+				 "couldn't get PF vsi config, err %d aq_err %s\n",
+				 ret,
 				 i40e_aq_str(&pf->hw,
 					     pf->hw.aq.asq_last_status));
 			return -ENOENT;
@@ -13796,8 +13795,8 @@ static int i40e_add_vsi(struct i40e_vsi *vsi)
 			ret = i40e_aq_update_vsi_params(hw, &ctxt, NULL);
 			if (ret) {
 				dev_info(&pf->pdev->dev,
-					 "update vsi failed, err %s aq_err %s\n",
-					 i40e_stat_str(&pf->hw, ret),
+					 "update vsi failed, err %d aq_err %s\n",
+					 ret,
 					 i40e_aq_str(&pf->hw,
 						     pf->hw.aq.asq_last_status));
 				ret = -ENOENT;
@@ -13816,8 +13815,8 @@ static int i40e_add_vsi(struct i40e_vsi *vsi)
 			ret = i40e_aq_update_vsi_params(hw, &ctxt, NULL);
 			if (ret) {
 				dev_info(&pf->pdev->dev,
-					 "update vsi failed, err %s aq_err %s\n",
-					 i40e_stat_str(&pf->hw, ret),
+					 "update vsi failed, err %d aq_err %s\n",
+					 ret,
 					 i40e_aq_str(&pf->hw,
 						    pf->hw.aq.asq_last_status));
 				ret = -ENOENT;
@@ -13839,9 +13838,9 @@ static int i40e_add_vsi(struct i40e_vsi *vsi)
 				 * message and continue
 				 */
 				dev_info(&pf->pdev->dev,
-					 "failed to configure TCs for main VSI tc_map 0x%08x, err %s aq_err %s\n",
+					 "failed to configure TCs for main VSI tc_map 0x%08x, err %d aq_err %s\n",
 					 enabled_tc,
-					 i40e_stat_str(&pf->hw, ret),
+					 ret,
 					 i40e_aq_str(&pf->hw,
 						    pf->hw.aq.asq_last_status));
 			}
@@ -13935,8 +13934,8 @@ static int i40e_add_vsi(struct i40e_vsi *vsi)
 		ret = i40e_aq_add_vsi(hw, &ctxt, NULL);
 		if (ret) {
 			dev_info(&vsi->back->pdev->dev,
-				 "add vsi failed, err %s aq_err %s\n",
-				 i40e_stat_str(&pf->hw, ret),
+				 "add vsi failed, err %d aq_err %s\n",
+				 ret,
 				 i40e_aq_str(&pf->hw,
 					     pf->hw.aq.asq_last_status));
 			ret = -ENOENT;
@@ -13967,8 +13966,8 @@ static int i40e_add_vsi(struct i40e_vsi *vsi)
 	ret = i40e_vsi_get_bw_info(vsi);
 	if (ret) {
 		dev_info(&pf->pdev->dev,
-			 "couldn't get vsi bw info, err %s aq_err %s\n",
-			 i40e_stat_str(&pf->hw, ret),
+			 "couldn't get vsi bw info, err %d aq_err %s\n",
+			 ret,
 			 i40e_aq_str(&pf->hw, pf->hw.aq.asq_last_status));
 		/* VSI is already added so not tearing that up */
 		ret = 0;
@@ -14414,8 +14413,8 @@ static int i40e_veb_get_bw_info(struct i40e_veb *veb)
 						  &bw_data, NULL);
 	if (ret) {
 		dev_info(&pf->pdev->dev,
-			 "query veb bw config failed, err %s aq_err %s\n",
-			 i40e_stat_str(&pf->hw, ret),
+			 "query veb bw config failed, err %d aq_err %s\n",
+			 ret,
 			 i40e_aq_str(&pf->hw, hw->aq.asq_last_status));
 		goto out;
 	}
@@ -14424,8 +14423,8 @@ static int i40e_veb_get_bw_info(struct i40e_veb *veb)
 						   &ets_data, NULL);
 	if (ret) {
 		dev_info(&pf->pdev->dev,
-			 "query veb bw ets config failed, err %s aq_err %s\n",
-			 i40e_stat_str(&pf->hw, ret),
+			 "query veb bw ets config failed, err %d aq_err %s\n",
+			 ret,
 			 i40e_aq_str(&pf->hw, hw->aq.asq_last_status));
 		goto out;
 	}
@@ -14621,8 +14620,8 @@ static int i40e_add_veb(struct i40e_veb *veb, struct i40e_vsi *vsi)
 	/* get a VEB from the hardware */
 	if (ret) {
 		dev_info(&pf->pdev->dev,
-			 "couldn't add VEB, err %s aq_err %s\n",
-			 i40e_stat_str(&pf->hw, ret),
+			 "couldn't add VEB, err %d aq_err %s\n",
+			 ret,
 			 i40e_aq_str(&pf->hw, pf->hw.aq.asq_last_status));
 		return -EPERM;
 	}
@@ -14632,16 +14631,16 @@ static int i40e_add_veb(struct i40e_veb *veb, struct i40e_vsi *vsi)
 					 &veb->stats_idx, NULL, NULL, NULL);
 	if (ret) {
 		dev_info(&pf->pdev->dev,
-			 "couldn't get VEB statistics idx, err %s aq_err %s\n",
-			 i40e_stat_str(&pf->hw, ret),
+			 "couldn't get VEB statistics idx, err %d aq_err %s\n",
+			 ret,
 			 i40e_aq_str(&pf->hw, pf->hw.aq.asq_last_status));
 		return -EPERM;
 	}
 	ret = i40e_veb_get_bw_info(veb);
 	if (ret) {
 		dev_info(&pf->pdev->dev,
-			 "couldn't get VEB bw info, err %s aq_err %s\n",
-			 i40e_stat_str(&pf->hw, ret),
+			 "couldn't get VEB bw info, err %d aq_err %s\n",
+			 ret,
 			 i40e_aq_str(&pf->hw, pf->hw.aq.asq_last_status));
 		i40e_aq_delete_element(&pf->hw, veb->seid, NULL);
 		return -ENOENT;
@@ -14851,8 +14850,8 @@ int i40e_fetch_switch_configuration(struct i40e_pf *pf, bool printconfig)
 						&next_seid, NULL);
 		if (ret) {
 			dev_info(&pf->pdev->dev,
-				 "get switch config failed err %s aq_err %s\n",
-				 i40e_stat_str(&pf->hw, ret),
+				 "get switch config failed err %d aq_err %s\n",
+				 ret,
 				 i40e_aq_str(&pf->hw,
 					     pf->hw.aq.asq_last_status));
 			kfree(aq_buf);
@@ -14897,8 +14896,8 @@ static int i40e_setup_pf_switch(struct i40e_pf *pf, bool reinit, bool lock_acqui
 	ret = i40e_fetch_switch_configuration(pf, false);
 	if (ret) {
 		dev_info(&pf->pdev->dev,
-			 "couldn't fetch switch config, err %s aq_err %s\n",
-			 i40e_stat_str(&pf->hw, ret),
+			 "couldn't fetch switch config, err %d aq_err %s\n",
+			 ret,
 			 i40e_aq_str(&pf->hw, pf->hw.aq.asq_last_status));
 		return ret;
 	}
@@ -14924,8 +14923,8 @@ static int i40e_setup_pf_switch(struct i40e_pf *pf, bool reinit, bool lock_acqui
 						NULL);
 		if (ret && pf->hw.aq.asq_last_status != I40E_AQ_RC_ESRCH) {
 			dev_info(&pf->pdev->dev,
-				 "couldn't set switch config bits, err %s aq_err %s\n",
-				 i40e_stat_str(&pf->hw, ret),
+				 "couldn't set switch config bits, err %d aq_err %s\n",
+				 ret,
 				 i40e_aq_str(&pf->hw,
 					     pf->hw.aq.asq_last_status));
 			/* not a fatal problem, just keep going */
@@ -15262,13 +15261,12 @@ static bool i40e_check_recovery_mode(struct i40e_pf *pf)
  *
  * Return 0 on success, negative on failure.
  **/
-static i40e_status i40e_pf_loop_reset(struct i40e_pf *pf)
+static int i40e_pf_loop_reset(struct i40e_pf *pf)
 {
 	/* wait max 10 seconds for PF reset to succeed */
 	const unsigned long time_end = jiffies + 10 * HZ;
-
 	struct i40e_hw *hw = &pf->hw;
-	i40e_status ret;
+	int ret;
 
 	ret = i40e_pf_reset(hw);
 	while (ret != I40E_SUCCESS && time_before(jiffies, time_end)) {
@@ -15314,9 +15312,9 @@ static bool i40e_check_fw_empr(struct i40e_pf *pf)
  * Return 0 if NIC is healthy or negative value when there are issues
  * with resets
  **/
-static i40e_status i40e_handle_resets(struct i40e_pf *pf)
+static int i40e_handle_resets(struct i40e_pf *pf)
 {
-	const i40e_status pfr = i40e_pf_loop_reset(pf);
+	const int pfr = i40e_pf_loop_reset(pf);
 	const bool is_empr = i40e_check_fw_empr(pf);
 
 	if (is_empr || pfr != I40E_SUCCESS)
@@ -15455,13 +15453,15 @@ static int i40e_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	struct i40e_aq_get_phy_abilities_resp abilities;
 #ifdef CONFIG_I40E_DCB
 	enum i40e_get_fw_lldp_status_resp lldp_status;
-	i40e_status status;
 #endif /* CONFIG_I40E_DCB */
 	struct i40e_pf *pf;
 	struct i40e_hw *hw;
 	static u16 pfs_found;
 	u16 wol_nvm_bits;
 	u16 link_status;
+#ifdef CONFIG_I40E_DCB
+	int status;
+#endif /* CONFIG_I40E_DCB */
 	int err;
 	u32 val;
 	u32 i;
@@ -15833,8 +15833,8 @@ static int i40e_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 					 I40E_AQ_EVENT_MEDIA_NA |
 					 I40E_AQ_EVENT_MODULE_QUAL_FAIL), NULL);
 	if (err)
-		dev_info(&pf->pdev->dev, "set phy mask fail, err %s aq_err %s\n",
-			 i40e_stat_str(&pf->hw, err),
+		dev_info(&pf->pdev->dev, "set phy mask fail, err %d aq_err %s\n",
+			 err,
 			 i40e_aq_str(&pf->hw, pf->hw.aq.asq_last_status));
 
 	/* Reconfigure hardware for allowing smaller MSS in the case
@@ -15852,8 +15852,8 @@ static int i40e_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 		msleep(75);
 		err = i40e_aq_set_link_restart_an(&pf->hw, true, NULL);
 		if (err)
-			dev_info(&pf->pdev->dev, "link restart failed, err %s aq_err %s\n",
-				 i40e_stat_str(&pf->hw, err),
+			dev_info(&pf->pdev->dev, "link restart failed, err %d aq_err %s\n",
+				 err,
 				 i40e_aq_str(&pf->hw,
 					     pf->hw.aq.asq_last_status));
 	}
@@ -15985,8 +15985,8 @@ static int i40e_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	/* get the requested speeds from the fw */
 	err = i40e_aq_get_phy_capabilities(hw, false, false, &abilities, NULL);
 	if (err)
-		dev_dbg(&pf->pdev->dev, "get requested speeds ret =  %s last_status =  %s\n",
-			i40e_stat_str(&pf->hw, err),
+		dev_dbg(&pf->pdev->dev, "get requested speeds ret =  %d last_status =  %s\n",
+			err,
 			i40e_aq_str(&pf->hw, pf->hw.aq.asq_last_status));
 	pf->hw.phy.link_info.requested_speeds = abilities.link_speed;
 
@@ -15996,8 +15996,8 @@ static int i40e_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	/* get the supported phy types from the fw */
 	err = i40e_aq_get_phy_capabilities(hw, false, true, &abilities, NULL);
 	if (err)
-		dev_dbg(&pf->pdev->dev, "get supported phy types ret =  %s last_status =  %s\n",
-			i40e_stat_str(&pf->hw, err),
+		dev_dbg(&pf->pdev->dev, "get supported phy types ret =  %d last_status =  %s\n",
+			err,
 			i40e_aq_str(&pf->hw, pf->hw.aq.asq_last_status));
 
 	/* make sure the MFS hasn't been set lower than the default */
@@ -16068,7 +16068,7 @@ static void i40e_remove(struct pci_dev *pdev)
 {
 	struct i40e_pf *pf = pci_get_drvdata(pdev);
 	struct i40e_hw *hw = &pf->hw;
-	i40e_status ret_code;
+	int ret_code;
 	int i;
 
 	i40e_dbg_pf_exit(pf);
@@ -16316,9 +16316,9 @@ static void i40e_pci_error_resume(struct pci_dev *pdev)
 static void i40e_enable_mc_magic_wake(struct i40e_pf *pf)
 {
 	struct i40e_hw *hw = &pf->hw;
-	i40e_status ret;
 	u8 mac_addr[6];
 	u16 flags = 0;
+	int ret;
 
 	/* Get current MAC address in case it's an LAA */
 	if (pf->vsi[pf->lan_vsi] && pf->vsi[pf->lan_vsi]->netdev) {
diff --git a/drivers/net/ethernet/intel/i40e/i40e_nvm.c b/drivers/net/ethernet/intel/i40e/i40e_nvm.c
index fe6dca846028..82af180cc5ee 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_nvm.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_nvm.c
@@ -13,10 +13,10 @@
  * in this file) as an equivalent of the FLASH part mapped into the SR.
  * We are accessing FLASH always thru the Shadow RAM.
  **/
-i40e_status i40e_init_nvm(struct i40e_hw *hw)
+int i40e_init_nvm(struct i40e_hw *hw)
 {
 	struct i40e_nvm_info *nvm = &hw->nvm;
-	i40e_status ret_code = 0;
+	int ret_code = 0;
 	u32 fla, gens;
 	u8 sr_size;
 
@@ -52,12 +52,12 @@ i40e_status i40e_init_nvm(struct i40e_hw *hw)
  * This function will request NVM ownership for reading
  * via the proper Admin Command.
  **/
-i40e_status i40e_acquire_nvm(struct i40e_hw *hw,
-				       enum i40e_aq_resource_access_type access)
+int i40e_acquire_nvm(struct i40e_hw *hw,
+		     enum i40e_aq_resource_access_type access)
 {
-	i40e_status ret_code = 0;
 	u64 gtime, timeout;
 	u64 time_left = 0;
+	int ret_code = 0;
 
 	if (hw->nvm.blank_nvm_mode)
 		goto i40e_i40e_acquire_nvm_exit;
@@ -111,7 +111,7 @@ i40e_status i40e_acquire_nvm(struct i40e_hw *hw,
  **/
 void i40e_release_nvm(struct i40e_hw *hw)
 {
-	i40e_status ret_code = I40E_SUCCESS;
+	int ret_code = I40E_SUCCESS;
 	u32 total_delay = 0;
 
 	if (hw->nvm.blank_nvm_mode)
@@ -138,9 +138,9 @@ void i40e_release_nvm(struct i40e_hw *hw)
  *
  * Polls the SRCTL Shadow RAM register done bit.
  **/
-static i40e_status i40e_poll_sr_srctl_done_bit(struct i40e_hw *hw)
+static int i40e_poll_sr_srctl_done_bit(struct i40e_hw *hw)
 {
-	i40e_status ret_code = I40E_ERR_TIMEOUT;
+	int ret_code = I40E_ERR_TIMEOUT;
 	u32 srctl, wait_cnt;
 
 	/* Poll the I40E_GLNVM_SRCTL until the done bit is set */
@@ -165,10 +165,10 @@ static i40e_status i40e_poll_sr_srctl_done_bit(struct i40e_hw *hw)
  *
  * Reads one 16 bit word from the Shadow RAM using the GLNVM_SRCTL register.
  **/
-static i40e_status i40e_read_nvm_word_srctl(struct i40e_hw *hw, u16 offset,
-					    u16 *data)
+static int i40e_read_nvm_word_srctl(struct i40e_hw *hw, u16 offset,
+				    u16 *data)
 {
-	i40e_status ret_code = I40E_ERR_TIMEOUT;
+	int ret_code = I40E_ERR_TIMEOUT;
 	u32 sr_reg;
 
 	if (offset >= hw->nvm.sr_size) {
@@ -216,13 +216,13 @@ static i40e_status i40e_read_nvm_word_srctl(struct i40e_hw *hw, u16 offset,
  *
  * Writes a 16 bit words buffer to the Shadow RAM using the admin command.
  **/
-static i40e_status i40e_read_nvm_aq(struct i40e_hw *hw,
-				    u8 module_pointer, u32 offset,
-				    u16 words, void *data,
-				    bool last_command)
+static int i40e_read_nvm_aq(struct i40e_hw *hw,
+			    u8 module_pointer, u32 offset,
+			    u16 words, void *data,
+			    bool last_command)
 {
-	i40e_status ret_code = I40E_ERR_NVM;
 	struct i40e_asq_cmd_details cmd_details;
+	int ret_code = I40E_ERR_NVM;
 
 	memset(&cmd_details, 0, sizeof(cmd_details));
 	cmd_details.wb_desc = &hw->nvm_wb_desc;
@@ -264,10 +264,10 @@ static i40e_status i40e_read_nvm_aq(struct i40e_hw *hw,
  *
  * Reads one 16 bit word from the Shadow RAM using the AdminQ
  **/
-static i40e_status i40e_read_nvm_word_aq(struct i40e_hw *hw, u16 offset,
-					 u16 *data)
+static int i40e_read_nvm_word_aq(struct i40e_hw *hw, u16 offset,
+				 u16 *data)
 {
-	i40e_status ret_code = I40E_ERR_TIMEOUT;
+	int ret_code = I40E_ERR_TIMEOUT;
 
 	ret_code = i40e_read_nvm_aq(hw, 0x0, offset, 1, data, true);
 	*data = le16_to_cpu(*(__le16 *)data);
@@ -286,8 +286,8 @@ static i40e_status i40e_read_nvm_word_aq(struct i40e_hw *hw, u16 offset,
  * Do not use this function except in cases where the nvm lock is already
  * taken via i40e_acquire_nvm().
  **/
-static i40e_status __i40e_read_nvm_word(struct i40e_hw *hw,
-					u16 offset, u16 *data)
+static int __i40e_read_nvm_word(struct i40e_hw *hw,
+				u16 offset, u16 *data)
 {
 	if (hw->flags & I40E_HW_FLAG_AQ_SRCTL_ACCESS_ENABLE)
 		return i40e_read_nvm_word_aq(hw, offset, data);
@@ -303,10 +303,10 @@ static i40e_status __i40e_read_nvm_word(struct i40e_hw *hw,
  *
  * Reads one 16 bit word from the Shadow RAM.
  **/
-i40e_status i40e_read_nvm_word(struct i40e_hw *hw, u16 offset,
-			       u16 *data)
+int i40e_read_nvm_word(struct i40e_hw *hw, u16 offset,
+		       u16 *data)
 {
-	i40e_status ret_code = 0;
+	int ret_code = 0;
 
 	if (hw->flags & I40E_HW_FLAG_NVM_READ_REQUIRES_LOCK)
 		ret_code = i40e_acquire_nvm(hw, I40E_RESOURCE_READ);
@@ -330,17 +330,17 @@ i40e_status i40e_read_nvm_word(struct i40e_hw *hw, u16 offset,
  * @words_data_size: Words to read from NVM
  * @data_ptr: Pointer to memory location where resulting buffer will be stored
  **/
-enum i40e_status_code i40e_read_nvm_module_data(struct i40e_hw *hw,
-						u8 module_ptr,
-						u16 module_offset,
-						u16 data_offset,
-						u16 words_data_size,
-						u16 *data_ptr)
+int i40e_read_nvm_module_data(struct i40e_hw *hw,
+			      u8 module_ptr,
+			      u16 module_offset,
+			      u16 data_offset,
+			      u16 words_data_size,
+			      u16 *data_ptr)
 {
-	i40e_status status;
 	u16 specific_ptr = 0;
 	u16 ptr_value = 0;
 	u32 offset = 0;
+	int status;
 
 	if (module_ptr != 0) {
 		status = i40e_read_nvm_word(hw, module_ptr, &ptr_value);
@@ -406,10 +406,10 @@ enum i40e_status_code i40e_read_nvm_module_data(struct i40e_hw *hw,
  * method. The buffer read is preceded by the NVM ownership take
  * and followed by the release.
  **/
-static i40e_status i40e_read_nvm_buffer_srctl(struct i40e_hw *hw, u16 offset,
-					      u16 *words, u16 *data)
+static int i40e_read_nvm_buffer_srctl(struct i40e_hw *hw, u16 offset,
+				      u16 *words, u16 *data)
 {
-	i40e_status ret_code = 0;
+	int ret_code = 0;
 	u16 index, word;
 
 	/* Loop thru the selected region */
@@ -437,13 +437,13 @@ static i40e_status i40e_read_nvm_buffer_srctl(struct i40e_hw *hw, u16 offset,
  * method. The buffer read is preceded by the NVM ownership take
  * and followed by the release.
  **/
-static i40e_status i40e_read_nvm_buffer_aq(struct i40e_hw *hw, u16 offset,
-					   u16 *words, u16 *data)
+static int i40e_read_nvm_buffer_aq(struct i40e_hw *hw, u16 offset,
+				   u16 *words, u16 *data)
 {
-	i40e_status ret_code;
-	u16 read_size;
 	bool last_cmd = false;
 	u16 words_read = 0;
+	u16 read_size;
+	int ret_code;
 	u16 i = 0;
 
 	do {
@@ -493,9 +493,9 @@ static i40e_status i40e_read_nvm_buffer_aq(struct i40e_hw *hw, u16 offset,
  * Reads 16 bit words (data buffer) from the SR using the i40e_read_nvm_srrd()
  * method.
  **/
-static i40e_status __i40e_read_nvm_buffer(struct i40e_hw *hw,
-					  u16 offset, u16 *words,
-					  u16 *data)
+static int __i40e_read_nvm_buffer(struct i40e_hw *hw,
+				  u16 offset, u16 *words,
+				  u16 *data)
 {
 	if (hw->flags & I40E_HW_FLAG_AQ_SRCTL_ACCESS_ENABLE)
 		return i40e_read_nvm_buffer_aq(hw, offset, words, data);
@@ -514,10 +514,10 @@ static i40e_status __i40e_read_nvm_buffer(struct i40e_hw *hw,
  * method. The buffer read is preceded by the NVM ownership take
  * and followed by the release.
  **/
-i40e_status i40e_read_nvm_buffer(struct i40e_hw *hw, u16 offset,
-				 u16 *words, u16 *data)
+int i40e_read_nvm_buffer(struct i40e_hw *hw, u16 offset,
+			 u16 *words, u16 *data)
 {
-	i40e_status ret_code = 0;
+	int ret_code = 0;
 
 	if (hw->flags & I40E_HW_FLAG_AQ_SRCTL_ACCESS_ENABLE) {
 		ret_code = i40e_acquire_nvm(hw, I40E_RESOURCE_READ);
@@ -544,12 +544,12 @@ i40e_status i40e_read_nvm_buffer(struct i40e_hw *hw, u16 offset,
  *
  * Writes a 16 bit words buffer to the Shadow RAM using the admin command.
  **/
-static i40e_status i40e_write_nvm_aq(struct i40e_hw *hw, u8 module_pointer,
-				     u32 offset, u16 words, void *data,
-				     bool last_command)
+static int i40e_write_nvm_aq(struct i40e_hw *hw, u8 module_pointer,
+			     u32 offset, u16 words, void *data,
+			     bool last_command)
 {
-	i40e_status ret_code = I40E_ERR_NVM;
 	struct i40e_asq_cmd_details cmd_details;
+	int ret_code = I40E_ERR_NVM;
 
 	memset(&cmd_details, 0, sizeof(cmd_details));
 	cmd_details.wb_desc = &hw->nvm_wb_desc;
@@ -594,14 +594,14 @@ static i40e_status i40e_write_nvm_aq(struct i40e_hw *hw, u8 module_pointer,
  * is customer specific and unknown. Therefore, this function skips all maximum
  * possible size of VPD (1kB).
  **/
-static i40e_status i40e_calc_nvm_checksum(struct i40e_hw *hw,
-						    u16 *checksum)
+static int i40e_calc_nvm_checksum(struct i40e_hw *hw,
+				  u16 *checksum)
 {
-	i40e_status ret_code;
 	struct i40e_virt_mem vmem;
 	u16 pcie_alt_module = 0;
 	u16 checksum_local = 0;
 	u16 vpd_module = 0;
+	int ret_code;
 	u16 *data;
 	u16 i = 0;
 
@@ -675,11 +675,11 @@ static i40e_status i40e_calc_nvm_checksum(struct i40e_hw *hw,
  * on ARQ completion event reception by caller.
  * This function will commit SR to NVM.
  **/
-i40e_status i40e_update_nvm_checksum(struct i40e_hw *hw)
+int i40e_update_nvm_checksum(struct i40e_hw *hw)
 {
-	i40e_status ret_code;
-	u16 checksum;
 	__le16 le_sum;
+	int ret_code;
+	u16 checksum;
 
 	ret_code = i40e_calc_nvm_checksum(hw, &checksum);
 	le_sum = cpu_to_le16(checksum);
@@ -698,12 +698,12 @@ i40e_status i40e_update_nvm_checksum(struct i40e_hw *hw)
  * Performs checksum calculation and validates the NVM SW checksum. If the
  * caller does not need checksum, the value can be NULL.
  **/
-i40e_status i40e_validate_nvm_checksum(struct i40e_hw *hw,
-						 u16 *checksum)
+int i40e_validate_nvm_checksum(struct i40e_hw *hw,
+			       u16 *checksum)
 {
-	i40e_status ret_code = 0;
-	u16 checksum_sr = 0;
 	u16 checksum_local = 0;
+	u16 checksum_sr = 0;
+	int ret_code = 0;
 
 	/* We must acquire the NVM lock in order to correctly synchronize the
 	 * NVM accesses across multiple PFs. Without doing so it is possible
@@ -732,36 +732,36 @@ i40e_status i40e_validate_nvm_checksum(struct i40e_hw *hw,
 	return ret_code;
 }
 
-static i40e_status i40e_nvmupd_state_init(struct i40e_hw *hw,
-					  struct i40e_nvm_access *cmd,
-					  u8 *bytes, int *perrno);
-static i40e_status i40e_nvmupd_state_reading(struct i40e_hw *hw,
-					     struct i40e_nvm_access *cmd,
-					     u8 *bytes, int *perrno);
-static i40e_status i40e_nvmupd_state_writing(struct i40e_hw *hw,
-					     struct i40e_nvm_access *cmd,
-					     u8 *bytes, int *errno);
+static int i40e_nvmupd_state_init(struct i40e_hw *hw,
+				  struct i40e_nvm_access *cmd,
+				  u8 *bytes, int *perrno);
+static int i40e_nvmupd_state_reading(struct i40e_hw *hw,
+				     struct i40e_nvm_access *cmd,
+				     u8 *bytes, int *perrno);
+static int i40e_nvmupd_state_writing(struct i40e_hw *hw,
+				     struct i40e_nvm_access *cmd,
+				     u8 *bytes, int *errno);
 static enum i40e_nvmupd_cmd i40e_nvmupd_validate_command(struct i40e_hw *hw,
 						struct i40e_nvm_access *cmd,
 						int *perrno);
-static i40e_status i40e_nvmupd_nvm_erase(struct i40e_hw *hw,
-					 struct i40e_nvm_access *cmd,
-					 int *perrno);
-static i40e_status i40e_nvmupd_nvm_write(struct i40e_hw *hw,
-					 struct i40e_nvm_access *cmd,
-					 u8 *bytes, int *perrno);
-static i40e_status i40e_nvmupd_nvm_read(struct i40e_hw *hw,
-					struct i40e_nvm_access *cmd,
-					u8 *bytes, int *perrno);
-static i40e_status i40e_nvmupd_exec_aq(struct i40e_hw *hw,
-				       struct i40e_nvm_access *cmd,
-				       u8 *bytes, int *perrno);
-static i40e_status i40e_nvmupd_get_aq_result(struct i40e_hw *hw,
-					     struct i40e_nvm_access *cmd,
-					     u8 *bytes, int *perrno);
-static i40e_status i40e_nvmupd_get_aq_event(struct i40e_hw *hw,
-					    struct i40e_nvm_access *cmd,
-					    u8 *bytes, int *perrno);
+static int i40e_nvmupd_nvm_erase(struct i40e_hw *hw,
+				 struct i40e_nvm_access *cmd,
+				 int *perrno);
+static int i40e_nvmupd_nvm_write(struct i40e_hw *hw,
+				 struct i40e_nvm_access *cmd,
+				 u8 *bytes, int *perrno);
+static int i40e_nvmupd_nvm_read(struct i40e_hw *hw,
+				struct i40e_nvm_access *cmd,
+				u8 *bytes, int *perrno);
+static int i40e_nvmupd_exec_aq(struct i40e_hw *hw,
+			       struct i40e_nvm_access *cmd,
+			       u8 *bytes, int *perrno);
+static int i40e_nvmupd_get_aq_result(struct i40e_hw *hw,
+				     struct i40e_nvm_access *cmd,
+				     u8 *bytes, int *perrno);
+static int i40e_nvmupd_get_aq_event(struct i40e_hw *hw,
+				    struct i40e_nvm_access *cmd,
+				    u8 *bytes, int *perrno);
 static inline u8 i40e_nvmupd_get_module(u32 val)
 {
 	return (u8)(val & I40E_NVM_MOD_PNT_MASK);
@@ -806,12 +806,12 @@ static const char * const i40e_nvm_update_state_str[] = {
  *
  * Dispatches command depending on what update state is current
  **/
-i40e_status i40e_nvmupd_command(struct i40e_hw *hw,
-				struct i40e_nvm_access *cmd,
-				u8 *bytes, int *perrno)
+int i40e_nvmupd_command(struct i40e_hw *hw,
+			struct i40e_nvm_access *cmd,
+			u8 *bytes, int *perrno)
 {
-	i40e_status status;
 	enum i40e_nvmupd_cmd upd_cmd;
+	int status;
 
 	/* assume success */
 	*perrno = 0;
@@ -922,12 +922,12 @@ i40e_status i40e_nvmupd_command(struct i40e_hw *hw,
  * Process legitimate commands of the Init state and conditionally set next
  * state. Reject all other commands.
  **/
-static i40e_status i40e_nvmupd_state_init(struct i40e_hw *hw,
-					  struct i40e_nvm_access *cmd,
-					  u8 *bytes, int *perrno)
+static int i40e_nvmupd_state_init(struct i40e_hw *hw,
+				  struct i40e_nvm_access *cmd,
+				  u8 *bytes, int *perrno)
 {
-	i40e_status status = 0;
 	enum i40e_nvmupd_cmd upd_cmd;
+	int status = 0;
 
 	upd_cmd = i40e_nvmupd_validate_command(hw, cmd, perrno);
 
@@ -1061,12 +1061,12 @@ static i40e_status i40e_nvmupd_state_init(struct i40e_hw *hw,
  * NVM ownership is already held.  Process legitimate commands and set any
  * change in state; reject all other commands.
  **/
-static i40e_status i40e_nvmupd_state_reading(struct i40e_hw *hw,
-					     struct i40e_nvm_access *cmd,
-					     u8 *bytes, int *perrno)
+static int i40e_nvmupd_state_reading(struct i40e_hw *hw,
+				     struct i40e_nvm_access *cmd,
+				     u8 *bytes, int *perrno)
 {
-	i40e_status status = 0;
 	enum i40e_nvmupd_cmd upd_cmd;
+	int status = 0;
 
 	upd_cmd = i40e_nvmupd_validate_command(hw, cmd, perrno);
 
@@ -1103,13 +1103,13 @@ static i40e_status i40e_nvmupd_state_reading(struct i40e_hw *hw,
  * NVM ownership is already held.  Process legitimate commands and set any
  * change in state; reject all other commands
  **/
-static i40e_status i40e_nvmupd_state_writing(struct i40e_hw *hw,
-					     struct i40e_nvm_access *cmd,
-					     u8 *bytes, int *perrno)
+static int i40e_nvmupd_state_writing(struct i40e_hw *hw,
+				     struct i40e_nvm_access *cmd,
+				     u8 *bytes, int *perrno)
 {
-	i40e_status status = 0;
 	enum i40e_nvmupd_cmd upd_cmd;
 	bool retry_attempt = false;
+	int status = 0;
 
 	upd_cmd = i40e_nvmupd_validate_command(hw, cmd, perrno);
 
@@ -1186,8 +1186,8 @@ static i40e_status i40e_nvmupd_state_writing(struct i40e_hw *hw,
 	 */
 	if (status && (hw->aq.asq_last_status == I40E_AQ_RC_EBUSY) &&
 	    !retry_attempt) {
-		i40e_status old_status = status;
 		u32 old_asq_status = hw->aq.asq_last_status;
+		int old_status = status;
 		u32 gtime;
 
 		gtime = rd32(hw, I40E_GLVFGEN_TIMER);
@@ -1369,17 +1369,17 @@ static enum i40e_nvmupd_cmd i40e_nvmupd_validate_command(struct i40e_hw *hw,
  *
  * cmd structure contains identifiers and data buffer
  **/
-static i40e_status i40e_nvmupd_exec_aq(struct i40e_hw *hw,
-				       struct i40e_nvm_access *cmd,
-				       u8 *bytes, int *perrno)
+static int i40e_nvmupd_exec_aq(struct i40e_hw *hw,
+			       struct i40e_nvm_access *cmd,
+			       u8 *bytes, int *perrno)
 {
 	struct i40e_asq_cmd_details cmd_details;
-	i40e_status status;
 	struct i40e_aq_desc *aq_desc;
 	u32 buff_size = 0;
 	u8 *buff = NULL;
 	u32 aq_desc_len;
 	u32 aq_data_len;
+	int status;
 
 	i40e_debug(hw, I40E_DEBUG_NVM, "NVMUPD: %s\n", __func__);
 	if (cmd->offset == 0xffff)
@@ -1428,8 +1428,8 @@ static i40e_status i40e_nvmupd_exec_aq(struct i40e_hw *hw,
 				       buff_size, &cmd_details);
 	if (status) {
 		i40e_debug(hw, I40E_DEBUG_NVM,
-			   "i40e_nvmupd_exec_aq err %s aq_err %s\n",
-			   i40e_stat_str(hw, status),
+			   "%s err %d aq_err %s\n",
+			   __func__, status,
 			   i40e_aq_str(hw, hw->aq.asq_last_status));
 		*perrno = i40e_aq_rc_to_posix(status, hw->aq.asq_last_status);
 		return status;
@@ -1453,9 +1453,9 @@ static i40e_status i40e_nvmupd_exec_aq(struct i40e_hw *hw,
  *
  * cmd structure contains identifiers and data buffer
  **/
-static i40e_status i40e_nvmupd_get_aq_result(struct i40e_hw *hw,
-					     struct i40e_nvm_access *cmd,
-					     u8 *bytes, int *perrno)
+static int i40e_nvmupd_get_aq_result(struct i40e_hw *hw,
+				     struct i40e_nvm_access *cmd,
+				     u8 *bytes, int *perrno)
 {
 	u32 aq_total_len;
 	u32 aq_desc_len;
@@ -1522,9 +1522,9 @@ static i40e_status i40e_nvmupd_get_aq_result(struct i40e_hw *hw,
  *
  * cmd structure contains identifiers and data buffer
  **/
-static i40e_status i40e_nvmupd_get_aq_event(struct i40e_hw *hw,
-					    struct i40e_nvm_access *cmd,
-					    u8 *bytes, int *perrno)
+static int i40e_nvmupd_get_aq_event(struct i40e_hw *hw,
+				    struct i40e_nvm_access *cmd,
+				    u8 *bytes, int *perrno)
 {
 	u32 aq_total_len;
 	u32 aq_desc_len;
@@ -1556,13 +1556,13 @@ static i40e_status i40e_nvmupd_get_aq_event(struct i40e_hw *hw,
  *
  * cmd structure contains identifiers and data buffer
  **/
-static i40e_status i40e_nvmupd_nvm_read(struct i40e_hw *hw,
-					struct i40e_nvm_access *cmd,
-					u8 *bytes, int *perrno)
+static int i40e_nvmupd_nvm_read(struct i40e_hw *hw,
+				struct i40e_nvm_access *cmd,
+				u8 *bytes, int *perrno)
 {
 	struct i40e_asq_cmd_details cmd_details;
-	i40e_status status;
 	u8 module, transaction;
+	int status;
 	bool last;
 
 	transaction = i40e_nvmupd_get_transaction(cmd->config);
@@ -1595,13 +1595,13 @@ static i40e_status i40e_nvmupd_nvm_read(struct i40e_hw *hw,
  *
  * module, offset, data_size and data are in cmd structure
  **/
-static i40e_status i40e_nvmupd_nvm_erase(struct i40e_hw *hw,
-					 struct i40e_nvm_access *cmd,
-					 int *perrno)
+static int i40e_nvmupd_nvm_erase(struct i40e_hw *hw,
+				 struct i40e_nvm_access *cmd,
+				 int *perrno)
 {
-	i40e_status status = 0;
 	struct i40e_asq_cmd_details cmd_details;
 	u8 module, transaction;
+	int status = 0;
 	bool last;
 
 	transaction = i40e_nvmupd_get_transaction(cmd->config);
@@ -1635,14 +1635,14 @@ static i40e_status i40e_nvmupd_nvm_erase(struct i40e_hw *hw,
  *
  * module, offset, data_size and data are in cmd structure
  **/
-static i40e_status i40e_nvmupd_nvm_write(struct i40e_hw *hw,
-					 struct i40e_nvm_access *cmd,
-					 u8 *bytes, int *perrno)
+static int i40e_nvmupd_nvm_write(struct i40e_hw *hw,
+				 struct i40e_nvm_access *cmd,
+				 u8 *bytes, int *perrno)
 {
-	i40e_status status = 0;
 	struct i40e_asq_cmd_details cmd_details;
 	u8 module, transaction;
 	u8 preservation_flags;
+	int status = 0;
 	bool last;
 
 	transaction = i40e_nvmupd_get_transaction(cmd->config);
diff --git a/drivers/net/ethernet/intel/i40e/i40e_osdep.h b/drivers/net/ethernet/intel/i40e/i40e_osdep.h
index 2f6815b2f8df..2bd4de03dafa 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_osdep.h
+++ b/drivers/net/ethernet/intel/i40e/i40e_osdep.h
@@ -56,5 +56,4 @@ do {								\
 			(h)->bus.func, ##__VA_ARGS__);		\
 } while (0)
 
-typedef enum i40e_status_code i40e_status;
 #endif /* _I40E_OSDEP_H_ */
diff --git a/drivers/net/ethernet/intel/i40e/i40e_prototype.h b/drivers/net/ethernet/intel/i40e/i40e_prototype.h
index aaea297640e0..c9e2b4875f06 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_prototype.h
+++ b/drivers/net/ethernet/intel/i40e/i40e_prototype.h
@@ -16,17 +16,17 @@
  */
 
 /* adminq functions */
-i40e_status i40e_init_adminq(struct i40e_hw *hw);
+int i40e_init_adminq(struct i40e_hw *hw);
 void i40e_shutdown_adminq(struct i40e_hw *hw);
 void i40e_adminq_init_ring_data(struct i40e_hw *hw);
-i40e_status i40e_clean_arq_element(struct i40e_hw *hw,
-					     struct i40e_arq_event_info *e,
-					     u16 *events_pending);
-i40e_status i40e_asq_send_command(struct i40e_hw *hw,
-				struct i40e_aq_desc *desc,
-				void *buff, /* can be NULL */
-				u16  buff_size,
-				struct i40e_asq_cmd_details *cmd_details);
+int i40e_clean_arq_element(struct i40e_hw *hw,
+			   struct i40e_arq_event_info *e,
+			   u16 *events_pending);
+int i40e_asq_send_command(struct i40e_hw *hw,
+			  struct i40e_aq_desc *desc,
+			  void *buff, /* can be NULL */
+			  u16  buff_size,
+			  struct i40e_asq_cmd_details *cmd_details);
 
 /* debug function for adminq */
 void i40e_debug_aq(struct i40e_hw *hw, enum i40e_debug_mask mask,
@@ -34,314 +34,269 @@ void i40e_debug_aq(struct i40e_hw *hw, enum i40e_debug_mask mask,
 
 void i40e_idle_aq(struct i40e_hw *hw);
 bool i40e_check_asq_alive(struct i40e_hw *hw);
-i40e_status i40e_aq_queue_shutdown(struct i40e_hw *hw, bool unloading);
+int i40e_aq_queue_shutdown(struct i40e_hw *hw, bool unloading);
 const char *i40e_aq_str(struct i40e_hw *hw, enum i40e_admin_queue_err aq_err);
-const char *i40e_stat_str(struct i40e_hw *hw, i40e_status stat_err);
 
-i40e_status i40e_aq_get_rss_lut(struct i40e_hw *hw, u16 seid,
-				bool pf_lut, u8 *lut, u16 lut_size);
-i40e_status i40e_aq_set_rss_lut(struct i40e_hw *hw, u16 seid,
-				bool pf_lut, u8 *lut, u16 lut_size);
-i40e_status i40e_aq_get_rss_key(struct i40e_hw *hw,
-				u16 seid,
-				struct i40e_aqc_get_set_rss_key_data *key);
-i40e_status i40e_aq_set_rss_key(struct i40e_hw *hw,
-				u16 seid,
-				struct i40e_aqc_get_set_rss_key_data *key);
+int i40e_aq_get_rss_lut(struct i40e_hw *hw, u16 seid,
+			bool pf_lut, u8 *lut, u16 lut_size);
+int i40e_aq_set_rss_lut(struct i40e_hw *hw, u16 seid,
+			bool pf_lut, u8 *lut, u16 lut_size);
+int i40e_aq_get_rss_key(struct i40e_hw *hw, u16 seid,
+			struct i40e_aqc_get_set_rss_key_data *key);
+int i40e_aq_set_rss_key(struct i40e_hw *hw, u16 seid,
+			struct i40e_aqc_get_set_rss_key_data *key);
 
 u32 i40e_led_get(struct i40e_hw *hw);
 void i40e_led_set(struct i40e_hw *hw, u32 mode, bool blink);
-i40e_status i40e_led_set_phy(struct i40e_hw *hw, bool on,
-			     u16 led_addr, u32 mode);
-i40e_status i40e_led_get_phy(struct i40e_hw *hw, u16 *led_addr,
-			     u16 *val);
-i40e_status i40e_blink_phy_link_led(struct i40e_hw *hw,
-				    u32 time, u32 interval);
+int i40e_led_set_phy(struct i40e_hw *hw, bool on, u16 led_addr, u32 mode);
+int i40e_led_get_phy(struct i40e_hw *hw, u16 *led_addr, u16 *val);
+int i40e_blink_phy_link_led(struct i40e_hw *hw, u32 time, u32 interval);
 
 /* admin send queue commands */
 
-i40e_status i40e_aq_get_firmware_version(struct i40e_hw *hw,
-				u16 *fw_major_version, u16 *fw_minor_version,
-				u32 *fw_build,
-				u16 *api_major_version, u16 *api_minor_version,
-				struct i40e_asq_cmd_details *cmd_details);
-i40e_status i40e_aq_debug_write_register(struct i40e_hw *hw,
-					u32 reg_addr, u64 reg_val,
-					struct i40e_asq_cmd_details *cmd_details);
-i40e_status i40e_aq_debug_read_register(struct i40e_hw *hw,
-				u32  reg_addr, u64 *reg_val,
-				struct i40e_asq_cmd_details *cmd_details);
-i40e_status i40e_aq_set_phy_debug(struct i40e_hw *hw, u8 cmd_flags,
-				struct i40e_asq_cmd_details *cmd_details);
-i40e_status i40e_aq_set_default_vsi(struct i40e_hw *hw, u16 vsi_id,
-				struct i40e_asq_cmd_details *cmd_details);
-i40e_status i40e_aq_clear_default_vsi(struct i40e_hw *hw, u16 vsi_id,
-				      struct i40e_asq_cmd_details *cmd_details);
-enum i40e_status_code i40e_aq_get_phy_capabilities(struct i40e_hw *hw,
-			bool qualified_modules, bool report_init,
-			struct i40e_aq_get_phy_abilities_resp *abilities,
-			struct i40e_asq_cmd_details *cmd_details);
-enum i40e_status_code i40e_aq_set_phy_config(struct i40e_hw *hw,
-				struct i40e_aq_set_phy_config *config,
-				struct i40e_asq_cmd_details *cmd_details);
-enum i40e_status_code i40e_set_fc(struct i40e_hw *hw, u8 *aq_failures,
-				  bool atomic_reset);
-i40e_status i40e_aq_set_phy_int_mask(struct i40e_hw *hw, u16 mask,
-				     struct i40e_asq_cmd_details *cmd_details);
-i40e_status i40e_aq_clear_pxe_mode(struct i40e_hw *hw,
-				struct i40e_asq_cmd_details *cmd_details);
-i40e_status i40e_aq_set_link_restart_an(struct i40e_hw *hw,
-					bool enable_link,
-					struct i40e_asq_cmd_details *cmd_details);
-i40e_status i40e_aq_get_link_info(struct i40e_hw *hw,
-				bool enable_lse, struct i40e_link_status *link,
-				struct i40e_asq_cmd_details *cmd_details);
-i40e_status i40e_aq_set_local_advt_reg(struct i40e_hw *hw,
-				u64 advt_reg,
-				struct i40e_asq_cmd_details *cmd_details);
-i40e_status i40e_aq_send_driver_version(struct i40e_hw *hw,
+int i40e_aq_get_firmware_version(struct i40e_hw *hw,
+				 u16 *fw_major_version, u16 *fw_minor_version,
+				 u32 *fw_build,
+				 u16 *api_major_version, u16 *api_minor_version,
+				 struct i40e_asq_cmd_details *cmd_details);
+int i40e_aq_debug_write_register(struct i40e_hw *hw, u32 reg_addr, u64 reg_val,
+				 struct i40e_asq_cmd_details *cmd_details);
+int i40e_aq_debug_read_register(struct i40e_hw *hw,
+				u32 reg_addr, u64 *reg_val,
+				struct i40e_asq_cmd_details *cmd_details);
+int i40e_aq_set_phy_debug(struct i40e_hw *hw, u8 cmd_flags,
+			  struct i40e_asq_cmd_details *cmd_details);
+int i40e_aq_set_default_vsi(struct i40e_hw *hw, u16 vsi_id,
+			    struct i40e_asq_cmd_details *cmd_details);
+int i40e_aq_clear_default_vsi(struct i40e_hw *hw, u16 vsi_id,
+			      struct i40e_asq_cmd_details *cmd_details);
+int i40e_aq_get_phy_capabilities(struct i40e_hw *hw,
+				 bool qualified_modules, bool report_init,
+				 struct i40e_aq_get_phy_abilities_resp *abilities,
+				 struct i40e_asq_cmd_details *cmd_details);
+int i40e_aq_set_phy_config(struct i40e_hw *hw, struct i40e_aq_set_phy_config *config,
+			   struct i40e_asq_cmd_details *cmd_details);
+int i40e_set_fc(struct i40e_hw *hw, u8 *aq_failures, bool atomic_reset);
+int i40e_aq_set_phy_int_mask(struct i40e_hw *hw, u16 mask,
+			     struct i40e_asq_cmd_details *cmd_details);
+int i40e_aq_clear_pxe_mode(struct i40e_hw *hw,
+			   struct i40e_asq_cmd_details *cmd_details);
+int i40e_aq_set_link_restart_an(struct i40e_hw *hw, bool enable_link,
+				struct i40e_asq_cmd_details *cmd_details);
+int i40e_aq_get_link_info(struct i40e_hw *hw, bool enable_lse,
+			  struct i40e_link_status *link,
+			  struct i40e_asq_cmd_details *cmd_details);
+int i40e_aq_set_local_advt_reg(struct i40e_hw *hw, u64 advt_reg,
+			       struct i40e_asq_cmd_details *cmd_details);
+int i40e_aq_send_driver_version(struct i40e_hw *hw,
 				struct i40e_driver_version *dv,
 				struct i40e_asq_cmd_details *cmd_details);
-i40e_status i40e_aq_add_vsi(struct i40e_hw *hw,
-				struct i40e_vsi_context *vsi_ctx,
-				struct i40e_asq_cmd_details *cmd_details);
-i40e_status i40e_aq_set_vsi_broadcast(struct i40e_hw *hw,
-				u16 vsi_id, bool set_filter,
-				struct i40e_asq_cmd_details *cmd_details);
-i40e_status i40e_aq_set_vsi_unicast_promiscuous(struct i40e_hw *hw,
-		u16 vsi_id, bool set, struct i40e_asq_cmd_details *cmd_details,
-		bool rx_only_promisc);
-i40e_status i40e_aq_set_vsi_multicast_promiscuous(struct i40e_hw *hw,
-		u16 vsi_id, bool set, struct i40e_asq_cmd_details *cmd_details);
-enum i40e_status_code i40e_aq_set_vsi_mc_promisc_on_vlan(struct i40e_hw *hw,
-							 u16 seid, bool enable,
-							 u16 vid,
-				struct i40e_asq_cmd_details *cmd_details);
-enum i40e_status_code i40e_aq_set_vsi_uc_promisc_on_vlan(struct i40e_hw *hw,
-							 u16 seid, bool enable,
-							 u16 vid,
-				struct i40e_asq_cmd_details *cmd_details);
-i40e_status i40e_aq_set_vsi_bc_promisc_on_vlan(struct i40e_hw *hw,
-				u16 seid, bool enable, u16 vid,
-				struct i40e_asq_cmd_details *cmd_details);
-i40e_status i40e_aq_set_vsi_vlan_promisc(struct i40e_hw *hw,
-				u16 seid, bool enable,
-				struct i40e_asq_cmd_details *cmd_details);
-i40e_status i40e_aq_get_vsi_params(struct i40e_hw *hw,
-				struct i40e_vsi_context *vsi_ctx,
-				struct i40e_asq_cmd_details *cmd_details);
-i40e_status i40e_aq_update_vsi_params(struct i40e_hw *hw,
-				struct i40e_vsi_context *vsi_ctx,
-				struct i40e_asq_cmd_details *cmd_details);
-i40e_status i40e_aq_add_veb(struct i40e_hw *hw, u16 uplink_seid,
-				u16 downlink_seid, u8 enabled_tc,
-				bool default_port, u16 *pveb_seid,
-				bool enable_stats,
-				struct i40e_asq_cmd_details *cmd_details);
-i40e_status i40e_aq_get_veb_parameters(struct i40e_hw *hw,
-				u16 veb_seid, u16 *switch_id, bool *floating,
-				u16 *statistic_index, u16 *vebs_used,
-				u16 *vebs_free,
-				struct i40e_asq_cmd_details *cmd_details);
-i40e_status i40e_aq_add_macvlan(struct i40e_hw *hw, u16 vsi_id,
+int i40e_aq_add_vsi(struct i40e_hw *hw,
+		    struct i40e_vsi_context *vsi_ctx,
+		    struct i40e_asq_cmd_details *cmd_details);
+int i40e_aq_set_vsi_broadcast(struct i40e_hw *hw, u16 vsi_id, bool set_filter,
+			      struct i40e_asq_cmd_details *cmd_details);
+int i40e_aq_set_vsi_unicast_promiscuous(struct i40e_hw *hw,
+					u16 vsi_id, bool set,
+					struct i40e_asq_cmd_details *cmd_details,
+					bool rx_only_promisc);
+int i40e_aq_set_vsi_multicast_promiscuous(struct i40e_hw *hw,
+					  u16 vsi_id, bool set,
+					  struct i40e_asq_cmd_details *cmd_details);
+int i40e_aq_set_vsi_mc_promisc_on_vlan(struct i40e_hw *hw, u16 seid,
+				       bool enable, u16 vid,
+				       struct i40e_asq_cmd_details *cmd_details);
+int i40e_aq_set_vsi_uc_promisc_on_vlan(struct i40e_hw *hw,
+				       u16 seid, bool enable, u16 vid,
+				       struct i40e_asq_cmd_details *cmd_details);
+int i40e_aq_set_vsi_bc_promisc_on_vlan(struct i40e_hw *hw,
+				       u16 seid, bool enable, u16 vid,
+				       struct i40e_asq_cmd_details *cmd_details);
+int i40e_aq_set_vsi_vlan_promisc(struct i40e_hw *hw,
+				 u16 seid, bool enable,
+				 struct i40e_asq_cmd_details *cmd_details);
+int i40e_aq_get_vsi_params(struct i40e_hw *hw,
+			   struct i40e_vsi_context *vsi_ctx,
+			   struct i40e_asq_cmd_details *cmd_details);
+int i40e_aq_update_vsi_params(struct i40e_hw *hw,
+			      struct i40e_vsi_context *vsi_ctx,
+			      struct i40e_asq_cmd_details *cmd_details);
+int i40e_aq_add_veb(struct i40e_hw *hw, u16 uplink_seid,
+		    u16 downlink_seid, u8 enabled_tc,
+		    bool default_port, u16 *pveb_seid,
+		    bool enable_stats,
+		    struct i40e_asq_cmd_details *cmd_details);
+int i40e_aq_get_veb_parameters(struct i40e_hw *hw,
+			       u16 veb_seid, u16 *switch_id, bool *floating,
+			       u16 *statistic_index, u16 *vebs_used,
+			       u16 *vebs_free,
+			       struct i40e_asq_cmd_details *cmd_details);
+int i40e_aq_add_macvlan(struct i40e_hw *hw, u16 vsi_id,
 			struct i40e_aqc_add_macvlan_element_data *mv_list,
 			u16 count, struct i40e_asq_cmd_details *cmd_details);
-i40e_status i40e_aq_remove_macvlan(struct i40e_hw *hw, u16 vsi_id,
-			struct i40e_aqc_remove_macvlan_element_data *mv_list,
-			u16 count, struct i40e_asq_cmd_details *cmd_details);
-i40e_status i40e_aq_add_mirrorrule(struct i40e_hw *hw, u16 sw_seid,
-			u16 rule_type, u16 dest_vsi, u16 count, __le16 *mr_list,
-			struct i40e_asq_cmd_details *cmd_details,
-			u16 *rule_id, u16 *rules_used, u16 *rules_free);
-i40e_status i40e_aq_delete_mirrorrule(struct i40e_hw *hw, u16 sw_seid,
-			u16 rule_type, u16 rule_id, u16 count, __le16 *mr_list,
-			struct i40e_asq_cmd_details *cmd_details,
-			u16 *rules_used, u16 *rules_free);
+int i40e_aq_remove_macvlan(struct i40e_hw *hw, u16 vsi_id,
+			   struct i40e_aqc_remove_macvlan_element_data *mv_list,
+			   u16 count, struct i40e_asq_cmd_details *cmd_details);
+int i40e_aq_add_mirrorrule(struct i40e_hw *hw, u16 sw_seid,
+			   u16 rule_type, u16 dest_vsi, u16 count,
+			   __le16 *mr_list,
+			   struct i40e_asq_cmd_details *cmd_details,
+			   u16 *rule_id, u16 *rules_used, u16 *rules_free);
+int i40e_aq_delete_mirrorrule(struct i40e_hw *hw, u16 sw_seid,
+			      u16 rule_type, u16 rule_id, u16 count, __le16 *mr_list,
+			      struct i40e_asq_cmd_details *cmd_details,
+			      u16 *rules_used, u16 *rules_free);
 
-i40e_status i40e_aq_send_msg_to_vf(struct i40e_hw *hw, u16 vfid,
-				u32 v_opcode, u32 v_retval, u8 *msg, u16 msglen,
-				struct i40e_asq_cmd_details *cmd_details);
-i40e_status i40e_aq_get_switch_config(struct i40e_hw *hw,
-				struct i40e_aqc_get_switch_config_resp *buf,
-				u16 buf_size, u16 *start_seid,
-				struct i40e_asq_cmd_details *cmd_details);
-enum i40e_status_code i40e_aq_set_switch_config(struct i40e_hw *hw,
-						u16 flags,
-						u16 valid_flags, u8 mode,
-				struct i40e_asq_cmd_details *cmd_details);
-i40e_status i40e_aq_request_resource(struct i40e_hw *hw,
-				enum i40e_aq_resources_ids resource,
-				enum i40e_aq_resource_access_type access,
-				u8 sdp_number, u64 *timeout,
-				struct i40e_asq_cmd_details *cmd_details);
-i40e_status i40e_aq_release_resource(struct i40e_hw *hw,
-				enum i40e_aq_resources_ids resource,
-				u8 sdp_number,
-				struct i40e_asq_cmd_details *cmd_details);
-i40e_status i40e_aq_read_nvm(struct i40e_hw *hw, u8 module_pointer,
-				u32 offset, u16 length, void *data,
-				bool last_command,
-				struct i40e_asq_cmd_details *cmd_details);
-i40e_status i40e_aq_erase_nvm(struct i40e_hw *hw, u8 module_pointer,
-			      u32 offset, u16 length, bool last_command,
+int i40e_aq_send_msg_to_vf(struct i40e_hw *hw, u16 vfid,
+			   u32 v_opcode, u32 v_retval, u8 *msg, u16 msglen,
+			   struct i40e_asq_cmd_details *cmd_details);
+int i40e_aq_get_switch_config(struct i40e_hw *hw,
+			      struct i40e_aqc_get_switch_config_resp *buf,
+			      u16 buf_size, u16 *start_seid,
 			      struct i40e_asq_cmd_details *cmd_details);
-i40e_status i40e_aq_discover_capabilities(struct i40e_hw *hw,
-				void *buff, u16 buff_size, u16 *data_size,
-				enum i40e_admin_queue_opc list_type_opc,
-				struct i40e_asq_cmd_details *cmd_details);
-i40e_status i40e_aq_update_nvm(struct i40e_hw *hw, u8 module_pointer,
-				u32 offset, u16 length, void *data,
-				bool last_command, u8 preservation_flags,
-				struct i40e_asq_cmd_details *cmd_details);
-i40e_status i40e_aq_rearrange_nvm(struct i40e_hw *hw,
-				  u8 rearrange_nvm,
-				  struct i40e_asq_cmd_details *cmd_details);
-i40e_status i40e_aq_get_lldp_mib(struct i40e_hw *hw, u8 bridge_type,
-				u8 mib_type, void *buff, u16 buff_size,
-				u16 *local_len, u16 *remote_len,
-				struct i40e_asq_cmd_details *cmd_details);
-enum i40e_status_code
-i40e_aq_set_lldp_mib(struct i40e_hw *hw,
-		     u8 mib_type, void *buff, u16 buff_size,
-		     struct i40e_asq_cmd_details *cmd_details);
-i40e_status i40e_aq_cfg_lldp_mib_change_event(struct i40e_hw *hw,
-				bool enable_update,
-				struct i40e_asq_cmd_details *cmd_details);
-enum i40e_status_code
-i40e_aq_restore_lldp(struct i40e_hw *hw, u8 *setting, bool restore,
+int i40e_aq_set_switch_config(struct i40e_hw *hw, u16 flags,
+			      u16 valid_flags, u8 mode,
+			      struct i40e_asq_cmd_details *cmd_details);
+int i40e_aq_request_resource(struct i40e_hw *hw,
+			     enum i40e_aq_resources_ids resource,
+			     enum i40e_aq_resource_access_type access,
+			     u8 sdp_number, u64 *timeout,
+			     struct i40e_asq_cmd_details *cmd_details);
+int i40e_aq_release_resource(struct i40e_hw *hw,
+			     enum i40e_aq_resources_ids resource, u8 sdp_number,
+			     struct i40e_asq_cmd_details *cmd_details);
+int i40e_aq_read_nvm(struct i40e_hw *hw, u8 module_pointer,
+		     u32 offset, u16 length, void *data, bool last_command,
 		     struct i40e_asq_cmd_details *cmd_details);
-i40e_status i40e_aq_stop_lldp(struct i40e_hw *hw, bool shutdown_agent,
-			      bool persist,
-				struct i40e_asq_cmd_details *cmd_details);
-i40e_status i40e_aq_set_dcb_parameters(struct i40e_hw *hw,
-				       bool dcb_enable,
-				       struct i40e_asq_cmd_details
-				       *cmd_details);
-i40e_status i40e_aq_start_lldp(struct i40e_hw *hw, bool persist,
+int i40e_aq_erase_nvm(struct i40e_hw *hw, u8 module_pointer,
+		      u32 offset, u16 length, bool last_command,
+		      struct i40e_asq_cmd_details *cmd_details);
+int i40e_aq_discover_capabilities(struct i40e_hw *hw,
+				  void *buff, u16 buff_size, u16 *data_size,
+				  enum i40e_admin_queue_opc list_type_opc,
+				  struct i40e_asq_cmd_details *cmd_details);
+int i40e_aq_update_nvm(struct i40e_hw *hw, u8 module_pointer,
+		       u32 offset, u16 length, void *data,
+		       bool last_command, u8 preservation_flags,
+		       struct i40e_asq_cmd_details *cmd_details);
+int i40e_aq_rearrange_nvm(struct i40e_hw *hw, u8 rearrange_nvm,
+			  struct i40e_asq_cmd_details *cmd_details);
+int i40e_aq_get_lldp_mib(struct i40e_hw *hw, u8 bridge_type,
+			 u8 mib_type, void *buff, u16 buff_size,
+			 u16 *local_len, u16 *remote_len,
+			 struct i40e_asq_cmd_details *cmd_details);
+int i40e_aq_set_lldp_mib(struct i40e_hw *hw, u8 mib_type,
+			 void *buff, u16 buff_size,
+			 struct i40e_asq_cmd_details *cmd_details);
+int i40e_aq_cfg_lldp_mib_change_event(struct i40e_hw *hw,
+				      bool enable_update,
+				      struct i40e_asq_cmd_details *cmd_details);
+int i40e_aq_restore_lldp(struct i40e_hw *hw, u8 *setting, bool restore,
+			 struct i40e_asq_cmd_details *cmd_details);
+int i40e_aq_stop_lldp(struct i40e_hw *hw, bool shutdown_agent, bool persist,
+		      struct i40e_asq_cmd_details *cmd_details);
+int i40e_aq_set_dcb_parameters(struct i40e_hw *hw, bool dcb_enable,
 			       struct i40e_asq_cmd_details *cmd_details);
-i40e_status i40e_aq_get_cee_dcb_config(struct i40e_hw *hw,
-				       void *buff, u16 buff_size,
-				       struct i40e_asq_cmd_details *cmd_details);
-i40e_status i40e_aq_add_udp_tunnel(struct i40e_hw *hw,
-				u16 udp_port, u8 protocol_index,
-				u8 *filter_index,
-				struct i40e_asq_cmd_details *cmd_details);
-i40e_status i40e_aq_del_udp_tunnel(struct i40e_hw *hw, u8 index,
-				struct i40e_asq_cmd_details *cmd_details);
-i40e_status i40e_aq_delete_element(struct i40e_hw *hw, u16 seid,
-				struct i40e_asq_cmd_details *cmd_details);
-i40e_status i40e_aq_mac_address_write(struct i40e_hw *hw,
-				    u16 flags, u8 *mac_addr,
-				    struct i40e_asq_cmd_details *cmd_details);
-i40e_status i40e_aq_config_vsi_bw_limit(struct i40e_hw *hw,
+int i40e_aq_start_lldp(struct i40e_hw *hw, bool persist,
+		       struct i40e_asq_cmd_details *cmd_details);
+int i40e_aq_get_cee_dcb_config(struct i40e_hw *hw,
+			       void *buff, u16 buff_size,
+			       struct i40e_asq_cmd_details *cmd_details);
+int i40e_aq_add_udp_tunnel(struct i40e_hw *hw, u16 udp_port,
+			   u8 protocol_index, u8 *filter_index,
+			   struct i40e_asq_cmd_details *cmd_details);
+int i40e_aq_del_udp_tunnel(struct i40e_hw *hw, u8 index,
+			   struct i40e_asq_cmd_details *cmd_details);
+int i40e_aq_delete_element(struct i40e_hw *hw, u16 seid,
+			   struct i40e_asq_cmd_details *cmd_details);
+int i40e_aq_mac_address_write(struct i40e_hw *hw, u16 flags, u8 *mac_addr,
+			      struct i40e_asq_cmd_details *cmd_details);
+int i40e_aq_config_vsi_bw_limit(struct i40e_hw *hw,
 				u16 seid, u16 credit, u8 max_credit,
 				struct i40e_asq_cmd_details *cmd_details);
-i40e_status i40e_aq_dcb_updated(struct i40e_hw *hw,
-				struct i40e_asq_cmd_details *cmd_details);
-i40e_status i40e_aq_config_switch_comp_bw_limit(struct i40e_hw *hw,
-				u16 seid, u16 credit, u8 max_bw,
-				struct i40e_asq_cmd_details *cmd_details);
-i40e_status i40e_aq_config_vsi_tc_bw(struct i40e_hw *hw, u16 seid,
-			struct i40e_aqc_configure_vsi_tc_bw_data *bw_data,
+int i40e_aq_dcb_updated(struct i40e_hw *hw,
 			struct i40e_asq_cmd_details *cmd_details);
-i40e_status i40e_aq_config_switch_comp_ets(struct i40e_hw *hw,
-		u16 seid,
-		struct i40e_aqc_configure_switching_comp_ets_data *ets_data,
-		enum i40e_admin_queue_opc opcode,
-		struct i40e_asq_cmd_details *cmd_details);
-i40e_status i40e_aq_config_switch_comp_bw_config(struct i40e_hw *hw,
-	u16 seid,
-	struct i40e_aqc_configure_switching_comp_bw_config_data *bw_data,
-	struct i40e_asq_cmd_details *cmd_details);
-i40e_status i40e_aq_query_vsi_bw_config(struct i40e_hw *hw,
-			u16 seid,
-			struct i40e_aqc_query_vsi_bw_config_resp *bw_data,
-			struct i40e_asq_cmd_details *cmd_details);
-i40e_status i40e_aq_query_vsi_ets_sla_config(struct i40e_hw *hw,
-			u16 seid,
-			struct i40e_aqc_query_vsi_ets_sla_config_resp *bw_data,
-			struct i40e_asq_cmd_details *cmd_details);
-i40e_status i40e_aq_query_switch_comp_ets_config(struct i40e_hw *hw,
-		u16 seid,
-		struct i40e_aqc_query_switching_comp_ets_config_resp *bw_data,
-		struct i40e_asq_cmd_details *cmd_details);
-i40e_status i40e_aq_query_port_ets_config(struct i40e_hw *hw,
-		u16 seid,
-		struct i40e_aqc_query_port_ets_config_resp *bw_data,
-		struct i40e_asq_cmd_details *cmd_details);
-i40e_status i40e_aq_query_switch_comp_bw_config(struct i40e_hw *hw,
-		u16 seid,
+int i40e_aq_config_switch_comp_bw_limit(struct i40e_hw *hw,
+					u16 seid, u16 credit, u8 max_bw,
+					struct i40e_asq_cmd_details *cmd_details);
+int i40e_aq_config_vsi_tc_bw(struct i40e_hw *hw, u16 seid,
+			     struct i40e_aqc_configure_vsi_tc_bw_data *bw_data,
+			     struct i40e_asq_cmd_details *cmd_details);
+int i40e_aq_config_switch_comp_ets(struct i40e_hw *hw, u16 seid,
+				   struct i40e_aqc_configure_switching_comp_ets_data *ets_data,
+				   enum i40e_admin_queue_opc opcode,
+				   struct i40e_asq_cmd_details *cmd_details);
+int i40e_aq_config_switch_comp_bw_config(struct i40e_hw *hw, u16 seid,
+					 struct i40e_aqc_configure_switching_comp_bw_config_data *bw_data,
+					 struct i40e_asq_cmd_details *cmd_details);
+int i40e_aq_query_vsi_bw_config(struct i40e_hw *hw, u16 seid,
+				struct i40e_aqc_query_vsi_bw_config_resp *bw_data,
+				struct i40e_asq_cmd_details *cmd_details);
+int i40e_aq_query_vsi_ets_sla_config(struct i40e_hw *hw, u16 seid,
+				     struct i40e_aqc_query_vsi_ets_sla_config_resp *bw_data,
+				     struct i40e_asq_cmd_details *cmd_details);
+int i40e_aq_query_switch_comp_ets_config(struct i40e_hw *hw, u16 seid,
+					 struct i40e_aqc_query_switching_comp_ets_config_resp *bw_data,
+					 struct i40e_asq_cmd_details *cmd_details);
+int i40e_aq_query_port_ets_config(struct i40e_hw *hw, u16 seid,
+				  struct i40e_aqc_query_port_ets_config_resp *bw_data,
+				  struct i40e_asq_cmd_details *cmd_details);
+int i40e_aq_query_switch_comp_bw_config(struct i40e_hw *hw, u16 seid,
 		struct i40e_aqc_query_switching_comp_bw_config_resp *bw_data,
 		struct i40e_asq_cmd_details *cmd_details);
-i40e_status i40e_aq_resume_port_tx(struct i40e_hw *hw,
-				   struct i40e_asq_cmd_details *cmd_details);
-enum i40e_status_code
-i40e_aq_add_cloud_filters_bb(struct i40e_hw *hw, u16 seid,
-			     struct i40e_aqc_cloud_filters_element_bb *filters,
-			     u8 filter_count);
-enum i40e_status_code
-i40e_aq_add_cloud_filters(struct i40e_hw *hw, u16 vsi,
-			  struct i40e_aqc_cloud_filters_element_data *filters,
-			  u8 filter_count);
-enum i40e_status_code
-i40e_aq_rem_cloud_filters(struct i40e_hw *hw, u16 vsi,
-			  struct i40e_aqc_cloud_filters_element_data *filters,
-			  u8 filter_count);
-enum i40e_status_code
-i40e_aq_rem_cloud_filters_bb(struct i40e_hw *hw, u16 seid,
-			     struct i40e_aqc_cloud_filters_element_bb *filters,
-			     u8 filter_count);
-i40e_status i40e_read_lldp_cfg(struct i40e_hw *hw,
-			       struct i40e_lldp_variables *lldp_cfg);
-enum i40e_status_code
-i40e_aq_suspend_port_tx(struct i40e_hw *hw, u16 seid,
-			struct i40e_asq_cmd_details *cmd_details);
+int i40e_aq_resume_port_tx(struct i40e_hw *hw, struct i40e_asq_cmd_details *cmd_details);
+int i40e_aq_add_cloud_filters_bb(struct i40e_hw *hw, u16 seid,
+				 struct i40e_aqc_cloud_filters_element_bb *filters,
+				 u8 filter_count);
+int i40e_aq_add_cloud_filters(struct i40e_hw *hw, u16 vsi,
+			      struct i40e_aqc_cloud_filters_element_data *filters,
+			      u8 filter_count);
+int i40e_aq_rem_cloud_filters(struct i40e_hw *hw, u16 vsi,
+			      struct i40e_aqc_cloud_filters_element_data *filters,
+			      u8 filter_count);
+int i40e_aq_rem_cloud_filters_bb(struct i40e_hw *hw, u16 seid,
+				 struct i40e_aqc_cloud_filters_element_bb *filters,
+				 u8 filter_count);
+int i40e_read_lldp_cfg(struct i40e_hw *hw, struct i40e_lldp_variables *lldp_cfg);
+int i40e_aq_suspend_port_tx(struct i40e_hw *hw, u16 seid,
+			    struct i40e_asq_cmd_details *cmd_details);
 /* i40e_common */
-i40e_status i40e_init_shared_code(struct i40e_hw *hw);
-i40e_status i40e_pf_reset(struct i40e_hw *hw);
+int i40e_init_shared_code(struct i40e_hw *hw);
+int i40e_pf_reset(struct i40e_hw *hw);
 void i40e_clear_hw(struct i40e_hw *hw);
 void i40e_clear_pxe_mode(struct i40e_hw *hw);
-i40e_status i40e_get_link_status(struct i40e_hw *hw, bool *link_up);
-i40e_status i40e_update_link_info(struct i40e_hw *hw);
-i40e_status i40e_get_mac_addr(struct i40e_hw *hw, u8 *mac_addr);
-i40e_status i40e_read_bw_from_alt_ram(struct i40e_hw *hw,
-				      u32 *max_bw, u32 *min_bw, bool *min_valid,
-				      bool *max_valid);
-i40e_status i40e_aq_configure_partition_bw(struct i40e_hw *hw,
-			struct i40e_aqc_configure_partition_bw_data *bw_data,
-			struct i40e_asq_cmd_details *cmd_details);
-i40e_status i40e_get_port_mac_addr(struct i40e_hw *hw, u8 *mac_addr);
-i40e_status i40e_read_pba_string(struct i40e_hw *hw, u8 *pba_num,
-				 u32 pba_num_size);
-i40e_status i40e_validate_mac_addr(u8 *mac_addr);
+int i40e_get_link_status(struct i40e_hw *hw, bool *link_up);
+int i40e_update_link_info(struct i40e_hw *hw);
+int i40e_get_mac_addr(struct i40e_hw *hw, u8 *mac_addr);
+int i40e_read_bw_from_alt_ram(struct i40e_hw *hw,
+			      u32 *max_bw, u32 *min_bw, bool *min_valid,
+			      bool *max_valid);
+int i40e_aq_configure_partition_bw(struct i40e_hw *hw,
+				   struct i40e_aqc_configure_partition_bw_data *bw_data,
+				   struct i40e_asq_cmd_details *cmd_details);
+int i40e_get_port_mac_addr(struct i40e_hw *hw, u8 *mac_addr);
+int i40e_read_pba_string(struct i40e_hw *hw, u8 *pba_num, u32 pba_num_size);
+int i40e_validate_mac_addr(u8 *mac_addr);
 void i40e_pre_tx_queue_cfg(struct i40e_hw *hw, u32 queue, bool enable);
 /* prototype for functions used for NVM access */
-i40e_status i40e_init_nvm(struct i40e_hw *hw);
-i40e_status i40e_acquire_nvm(struct i40e_hw *hw,
-				      enum i40e_aq_resource_access_type access);
+int i40e_init_nvm(struct i40e_hw *hw);
+int i40e_acquire_nvm(struct i40e_hw *hw, enum i40e_aq_resource_access_type access);
 void i40e_release_nvm(struct i40e_hw *hw);
-i40e_status i40e_read_nvm_word(struct i40e_hw *hw, u16 offset,
-					 u16 *data);
-enum i40e_status_code i40e_read_nvm_module_data(struct i40e_hw *hw,
-						u8 module_ptr,
-						u16 module_offset,
-						u16 data_offset,
-						u16 words_data_size,
-						u16 *data_ptr);
-i40e_status i40e_read_nvm_buffer(struct i40e_hw *hw, u16 offset,
-				 u16 *words, u16 *data);
-i40e_status i40e_update_nvm_checksum(struct i40e_hw *hw);
-i40e_status i40e_validate_nvm_checksum(struct i40e_hw *hw,
-						 u16 *checksum);
-i40e_status i40e_nvmupd_command(struct i40e_hw *hw,
-				struct i40e_nvm_access *cmd,
-				u8 *bytes, int *);
+int i40e_read_nvm_word(struct i40e_hw *hw, u16 offset, u16 *data);
+int i40e_read_nvm_module_data(struct i40e_hw *hw, u8 module_ptr,
+			      u16 module_offset, u16 data_offset,
+			      u16 words_data_size, u16 *data_ptr);
+int i40e_read_nvm_buffer(struct i40e_hw *hw, u16 offset, u16 *words, u16 *data);
+int i40e_update_nvm_checksum(struct i40e_hw *hw);
+int i40e_validate_nvm_checksum(struct i40e_hw *hw, u16 *checksum);
+int i40e_nvmupd_command(struct i40e_hw *hw, struct i40e_nvm_access *cmd,
+			u8 *bytes, int *);
 void i40e_nvmupd_check_wait_event(struct i40e_hw *hw, u16 opcode,
 				  struct i40e_aq_desc *desc);
 void i40e_nvmupd_clear_wait_state(struct i40e_hw *hw);
 void i40e_set_pci_config_data(struct i40e_hw *hw, u16 link_status);
 
-i40e_status i40e_set_mac_type(struct i40e_hw *hw);
+int i40e_set_mac_type(struct i40e_hw *hw);
 
 extern struct i40e_rx_ptype_decoded i40e_ptype_lookup[];
 
@@ -390,41 +345,41 @@ i40e_virtchnl_link_speed(enum i40e_aq_link_speed link_speed)
 /* i40e_common for VF drivers*/
 void i40e_vf_parse_hw_config(struct i40e_hw *hw,
 			     struct virtchnl_vf_resource *msg);
-i40e_status i40e_vf_reset(struct i40e_hw *hw);
-i40e_status i40e_aq_send_msg_to_pf(struct i40e_hw *hw,
-				enum virtchnl_ops v_opcode,
-				i40e_status v_retval,
-				u8 *msg, u16 msglen,
-				struct i40e_asq_cmd_details *cmd_details);
-i40e_status i40e_set_filter_control(struct i40e_hw *hw,
-				struct i40e_filter_control_settings *settings);
-i40e_status i40e_aq_add_rem_control_packet_filter(struct i40e_hw *hw,
-				u8 *mac_addr, u16 ethtype, u16 flags,
-				u16 vsi_seid, u16 queue, bool is_add,
-				struct i40e_control_filter_stats *stats,
-				struct i40e_asq_cmd_details *cmd_details);
-i40e_status i40e_aq_debug_dump(struct i40e_hw *hw, u8 cluster_id,
-			       u8 table_id, u32 start_index, u16 buff_size,
-			       void *buff, u16 *ret_buff_size,
-			       u8 *ret_next_table, u32 *ret_next_index,
-			       struct i40e_asq_cmd_details *cmd_details);
+int i40e_vf_reset(struct i40e_hw *hw);
+int i40e_aq_send_msg_to_pf(struct i40e_hw *hw,
+			   enum virtchnl_ops v_opcode,
+			   int v_retval,
+			   u8 *msg, u16 msglen,
+			   struct i40e_asq_cmd_details *cmd_details);
+int i40e_set_filter_control(struct i40e_hw *hw,
+			    struct i40e_filter_control_settings *settings);
+int i40e_aq_add_rem_control_packet_filter(struct i40e_hw *hw,
+					  u8 *mac_addr, u16 ethtype, u16 flags,
+					  u16 vsi_seid, u16 queue, bool is_add,
+					  struct i40e_control_filter_stats *stats,
+					  struct i40e_asq_cmd_details *cmd_details);
+int i40e_aq_debug_dump(struct i40e_hw *hw, u8 cluster_id,
+		       u8 table_id, u32 start_index, u16 buff_size,
+		       void *buff, u16 *ret_buff_size,
+		       u8 *ret_next_table, u32 *ret_next_index,
+		       struct i40e_asq_cmd_details *cmd_details);
 void i40e_add_filter_to_drop_tx_flow_control_frames(struct i40e_hw *hw,
 						    u16 vsi_seid);
-i40e_status i40e_aq_rx_ctl_read_register(struct i40e_hw *hw,
-				u32 reg_addr, u32 *reg_val,
-				struct i40e_asq_cmd_details *cmd_details);
+int i40e_aq_rx_ctl_read_register(struct i40e_hw *hw,
+				 u32 reg_addr, u32 *reg_val,
+				 struct i40e_asq_cmd_details *cmd_details);
 u32 i40e_read_rx_ctl(struct i40e_hw *hw, u32 reg_addr);
-i40e_status i40e_aq_rx_ctl_write_register(struct i40e_hw *hw,
-				u32 reg_addr, u32 reg_val,
-				struct i40e_asq_cmd_details *cmd_details);
+int i40e_aq_rx_ctl_write_register(struct i40e_hw *hw,
+				  u32 reg_addr, u32 reg_val,
+				  struct i40e_asq_cmd_details *cmd_details);
 void i40e_write_rx_ctl(struct i40e_hw *hw, u32 reg_addr, u32 reg_val);
-enum i40e_status_code
+int
 i40e_aq_set_phy_register_ext(struct i40e_hw *hw,
 			     u8 phy_select, u8 dev_addr, bool page_change,
 			     bool set_mdio, u8 mdio_num,
 			     u32 reg_addr, u32 reg_val,
 			     struct i40e_asq_cmd_details *cmd_details);
-enum i40e_status_code
+int
 i40e_aq_get_phy_register_ext(struct i40e_hw *hw,
 			     u8 phy_select, u8 dev_addr, bool page_change,
 			     bool set_mdio, u8 mdio_num,
@@ -437,43 +392,43 @@ i40e_aq_get_phy_register_ext(struct i40e_hw *hw,
 #define i40e_aq_get_phy_register(hw, ps, da, pc, ra, rv, cd)		\
 	i40e_aq_get_phy_register_ext(hw, ps, da, pc, false, 0, ra, rv, cd)
 
-i40e_status i40e_read_phy_register_clause22(struct i40e_hw *hw,
-					    u16 reg, u8 phy_addr, u16 *value);
-i40e_status i40e_write_phy_register_clause22(struct i40e_hw *hw,
-					     u16 reg, u8 phy_addr, u16 value);
-i40e_status i40e_read_phy_register_clause45(struct i40e_hw *hw,
-				u8 page, u16 reg, u8 phy_addr, u16 *value);
-i40e_status i40e_write_phy_register_clause45(struct i40e_hw *hw,
-				u8 page, u16 reg, u8 phy_addr, u16 value);
-i40e_status i40e_read_phy_register(struct i40e_hw *hw, u8 page, u16 reg,
-				   u8 phy_addr, u16 *value);
-i40e_status i40e_write_phy_register(struct i40e_hw *hw, u8 page, u16 reg,
-				    u8 phy_addr, u16 value);
+int i40e_read_phy_register_clause22(struct i40e_hw *hw,
+				    u16 reg, u8 phy_addr, u16 *value);
+int i40e_write_phy_register_clause22(struct i40e_hw *hw,
+				     u16 reg, u8 phy_addr, u16 value);
+int i40e_read_phy_register_clause45(struct i40e_hw *hw,
+				    u8 page, u16 reg, u8 phy_addr, u16 *value);
+int i40e_write_phy_register_clause45(struct i40e_hw *hw,
+				     u8 page, u16 reg, u8 phy_addr, u16 value);
+int i40e_read_phy_register(struct i40e_hw *hw, u8 page, u16 reg,
+			   u8 phy_addr, u16 *value);
+int i40e_write_phy_register(struct i40e_hw *hw, u8 page, u16 reg,
+			    u8 phy_addr, u16 value);
 u8 i40e_get_phy_address(struct i40e_hw *hw, u8 dev_num);
-i40e_status i40e_blink_phy_link_led(struct i40e_hw *hw,
-				    u32 time, u32 interval);
-i40e_status i40e_aq_write_ddp(struct i40e_hw *hw, void *buff,
-			      u16 buff_size, u32 track_id,
-			      u32 *error_offset, u32 *error_info,
-			      struct i40e_asq_cmd_details *
-			      cmd_details);
-i40e_status i40e_aq_get_ddp_list(struct i40e_hw *hw, void *buff,
-				 u16 buff_size, u8 flags,
-				 struct i40e_asq_cmd_details *
-				 cmd_details);
+int i40e_blink_phy_link_led(struct i40e_hw *hw,
+			    u32 time, u32 interval);
+int i40e_aq_write_ddp(struct i40e_hw *hw, void *buff,
+		      u16 buff_size, u32 track_id,
+		      u32 *error_offset, u32 *error_info,
+		      struct i40e_asq_cmd_details *
+		      cmd_details);
+int i40e_aq_get_ddp_list(struct i40e_hw *hw, void *buff,
+			 u16 buff_size, u8 flags,
+			 struct i40e_asq_cmd_details *
+			 cmd_details);
 struct i40e_generic_seg_header *
 i40e_find_segment_in_package(u32 segment_type,
 			     struct i40e_package_header *pkg_header);
 struct i40e_profile_section_header *
 i40e_find_section_in_profile(u32 section_type,
 			     struct i40e_profile_segment *profile);
-enum i40e_status_code
+int
 i40e_write_profile(struct i40e_hw *hw, struct i40e_profile_segment *i40e_seg,
 		   u32 track_id);
-enum i40e_status_code
+int
 i40e_rollback_profile(struct i40e_hw *hw, struct i40e_profile_segment *i40e_seg,
 		      u32 track_id);
-enum i40e_status_code
+int
 i40e_add_pinfo_to_list(struct i40e_hw *hw,
 		       struct i40e_profile_segment *profile,
 		       u8 *profile_info_sec, u32 track_id);
diff --git a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
index 7aedf20a1021..46758bbcb04f 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
@@ -17,7 +17,7 @@
  **/
 static void i40e_vc_vf_broadcast(struct i40e_pf *pf,
 				 enum virtchnl_ops v_opcode,
-				 i40e_status v_retval, u8 *msg,
+				 int v_retval, u8 *msg,
 				 u16 msglen)
 {
 	struct i40e_hw *hw = &pf->hw;
@@ -1246,13 +1246,13 @@ static void i40e_get_vlan_list_sync(struct i40e_vsi *vsi, u16 *num_vlans,
  * @vl: List of VLANs - apply filter for given VLANs
  * @num_vlans: Number of elements in @vl
  **/
-static i40e_status
+static int
 i40e_set_vsi_promisc(struct i40e_vf *vf, u16 seid, bool multi_enable,
 		     bool unicast_enable, s16 *vl, u16 num_vlans)
 {
-	i40e_status aq_ret, aq_tmp = 0;
 	struct i40e_pf *pf = vf->pf;
 	struct i40e_hw *hw = &pf->hw;
+	int aq_ret, aq_tmp = 0;
 	int i;
 
 	/* No VLAN to set promisc on, set on VSI */
@@ -1264,9 +1264,9 @@ i40e_set_vsi_promisc(struct i40e_vf *vf, u16 seid, bool multi_enable,
 			int aq_err = pf->hw.aq.asq_last_status;
 
 			dev_err(&pf->pdev->dev,
-				"VF %d failed to set multicast promiscuous mode err %s aq_err %s\n",
+				"VF %d failed to set multicast promiscuous mode err %d aq_err %s\n",
 				vf->vf_id,
-				i40e_stat_str(&pf->hw, aq_ret),
+				aq_ret,
 				i40e_aq_str(&pf->hw, aq_err));
 
 			return aq_ret;
@@ -1280,9 +1280,9 @@ i40e_set_vsi_promisc(struct i40e_vf *vf, u16 seid, bool multi_enable,
 			int aq_err = pf->hw.aq.asq_last_status;
 
 			dev_err(&pf->pdev->dev,
-				"VF %d failed to set unicast promiscuous mode err %s aq_err %s\n",
+				"VF %d failed to set unicast promiscuous mode err %d aq_err %s\n",
 				vf->vf_id,
-				i40e_stat_str(&pf->hw, aq_ret),
+				aq_ret,
 				i40e_aq_str(&pf->hw, aq_err));
 		}
 
@@ -1297,9 +1297,9 @@ i40e_set_vsi_promisc(struct i40e_vf *vf, u16 seid, bool multi_enable,
 			int aq_err = pf->hw.aq.asq_last_status;
 
 			dev_err(&pf->pdev->dev,
-				"VF %d failed to set multicast promiscuous mode err %s aq_err %s\n",
+				"VF %d failed to set multicast promiscuous mode err %d aq_err %s\n",
 				vf->vf_id,
-				i40e_stat_str(&pf->hw, aq_ret),
+				aq_ret,
 				i40e_aq_str(&pf->hw, aq_err));
 
 			if (!aq_tmp)
@@ -1313,9 +1313,9 @@ i40e_set_vsi_promisc(struct i40e_vf *vf, u16 seid, bool multi_enable,
 			int aq_err = pf->hw.aq.asq_last_status;
 
 			dev_err(&pf->pdev->dev,
-				"VF %d failed to set unicast promiscuous mode err %s aq_err %s\n",
+				"VF %d failed to set unicast promiscuous mode err %d aq_err %s\n",
 				vf->vf_id,
-				i40e_stat_str(&pf->hw, aq_ret),
+				aq_ret,
 				i40e_aq_str(&pf->hw, aq_err));
 
 			if (!aq_tmp)
@@ -1339,13 +1339,13 @@ i40e_set_vsi_promisc(struct i40e_vf *vf, u16 seid, bool multi_enable,
  * Called from the VF to configure the promiscuous mode of
  * VF vsis and from the VF reset path to reset promiscuous mode.
  **/
-static i40e_status i40e_config_vf_promiscuous_mode(struct i40e_vf *vf,
-						   u16 vsi_id,
-						   bool allmulti,
-						   bool alluni)
+static int i40e_config_vf_promiscuous_mode(struct i40e_vf *vf,
+					   u16 vsi_id,
+					   bool allmulti,
+					   bool alluni)
 {
-	i40e_status aq_ret = I40E_SUCCESS;
 	struct i40e_pf *pf = vf->pf;
+	int aq_ret = I40E_SUCCESS;
 	struct i40e_vsi *vsi;
 	u16 num_vlans;
 	s16 *vl;
@@ -1955,7 +1955,7 @@ static int i40e_vc_send_msg_to_vf(struct i40e_vf *vf, u32 v_opcode,
 	struct i40e_pf *pf;
 	struct i40e_hw *hw;
 	int abs_vf_id;
-	i40e_status aq_ret;
+	int aq_ret;
 
 	/* validate the request */
 	if (!vf || vf->vf_id >= vf->pf->num_alloc_vfs)
@@ -1987,7 +1987,7 @@ static int i40e_vc_send_msg_to_vf(struct i40e_vf *vf, u32 v_opcode,
  **/
 static int i40e_vc_send_resp_to_vf(struct i40e_vf *vf,
 				   enum virtchnl_ops opcode,
-				   i40e_status retval)
+				   int retval)
 {
 	return i40e_vc_send_msg_to_vf(vf, opcode, retval, NULL, 0);
 }
@@ -2091,9 +2091,9 @@ static int i40e_vc_get_vf_resources_msg(struct i40e_vf *vf, u8 *msg)
 {
 	struct virtchnl_vf_resource *vfres = NULL;
 	struct i40e_pf *pf = vf->pf;
-	i40e_status aq_ret = 0;
 	struct i40e_vsi *vsi;
 	int num_vsis = 1;
+	int aq_ret = 0;
 	size_t len = 0;
 	int ret;
 
@@ -2221,9 +2221,9 @@ static int i40e_vc_config_promiscuous_mode_msg(struct i40e_vf *vf, u8 *msg)
 	struct virtchnl_promisc_info *info =
 	    (struct virtchnl_promisc_info *)msg;
 	struct i40e_pf *pf = vf->pf;
-	i40e_status aq_ret = 0;
 	bool allmulti = false;
 	bool alluni = false;
+	int aq_ret = 0;
 
 	if (!i40e_sync_vf_state(vf, I40E_VF_STATE_ACTIVE)) {
 		aq_ret = I40E_ERR_PARAM;
@@ -2308,10 +2308,10 @@ static int i40e_vc_config_queues_msg(struct i40e_vf *vf, u8 *msg)
 	struct virtchnl_queue_pair_info *qpi;
 	u16 vsi_id, vsi_queue_id = 0;
 	struct i40e_pf *pf = vf->pf;
-	i40e_status aq_ret = 0;
 	int i, j = 0, idx = 0;
 	struct i40e_vsi *vsi;
 	u16 num_qps_all = 0;
+	int aq_ret = 0;
 
 	if (!i40e_sync_vf_state(vf, I40E_VF_STATE_ACTIVE)) {
 		aq_ret = I40E_ERR_PARAM;
@@ -2458,8 +2458,8 @@ static int i40e_vc_config_irq_map_msg(struct i40e_vf *vf, u8 *msg)
 	struct virtchnl_irq_map_info *irqmap_info =
 	    (struct virtchnl_irq_map_info *)msg;
 	struct virtchnl_vector_map *map;
+	int aq_ret = 0;
 	u16 vsi_id;
-	i40e_status aq_ret = 0;
 	int i;
 
 	if (!i40e_sync_vf_state(vf, I40E_VF_STATE_ACTIVE)) {
@@ -2574,7 +2574,7 @@ static int i40e_vc_enable_queues_msg(struct i40e_vf *vf, u8 *msg)
 	struct virtchnl_queue_select *vqs =
 	    (struct virtchnl_queue_select *)msg;
 	struct i40e_pf *pf = vf->pf;
-	i40e_status aq_ret = 0;
+	int aq_ret = 0;
 	int i;
 
 	if (!test_bit(I40E_VF_STATE_ACTIVE, &vf->vf_states)) {
@@ -2632,7 +2632,7 @@ static int i40e_vc_disable_queues_msg(struct i40e_vf *vf, u8 *msg)
 	struct virtchnl_queue_select *vqs =
 	    (struct virtchnl_queue_select *)msg;
 	struct i40e_pf *pf = vf->pf;
-	i40e_status aq_ret = 0;
+	int aq_ret = 0;
 
 	if (!i40e_sync_vf_state(vf, I40E_VF_STATE_ACTIVE)) {
 		aq_ret = I40E_ERR_PARAM;
@@ -2783,7 +2783,7 @@ static int i40e_vc_get_stats_msg(struct i40e_vf *vf, u8 *msg)
 	    (struct virtchnl_queue_select *)msg;
 	struct i40e_pf *pf = vf->pf;
 	struct i40e_eth_stats stats;
-	i40e_status aq_ret = 0;
+	int aq_ret = 0;
 	struct i40e_vsi *vsi;
 
 	memset(&stats, 0, sizeof(struct i40e_eth_stats));
@@ -2902,7 +2902,7 @@ static int i40e_vc_add_mac_addr_msg(struct i40e_vf *vf, u8 *msg)
 	    (struct virtchnl_ether_addr_list *)msg;
 	struct i40e_pf *pf = vf->pf;
 	struct i40e_vsi *vsi = NULL;
-	i40e_status ret = 0;
+	int ret = 0;
 	int i;
 
 	if (!i40e_sync_vf_state(vf, I40E_VF_STATE_ACTIVE) ||
@@ -2974,7 +2974,7 @@ static int i40e_vc_del_mac_addr_msg(struct i40e_vf *vf, u8 *msg)
 	bool was_unimac_deleted = false;
 	struct i40e_pf *pf = vf->pf;
 	struct i40e_vsi *vsi = NULL;
-	i40e_status ret = 0;
+	int ret = 0;
 	int i;
 
 	if (!i40e_sync_vf_state(vf, I40E_VF_STATE_ACTIVE) ||
@@ -3047,7 +3047,7 @@ static int i40e_vc_add_vlan_msg(struct i40e_vf *vf, u8 *msg)
 	    (struct virtchnl_vlan_filter_list *)msg;
 	struct i40e_pf *pf = vf->pf;
 	struct i40e_vsi *vsi = NULL;
-	i40e_status aq_ret = 0;
+	int aq_ret = 0;
 	int i;
 
 	if ((vf->num_vlan >= I40E_VC_MAX_VLAN_PER_VF) &&
@@ -3118,7 +3118,7 @@ static int i40e_vc_remove_vlan_msg(struct i40e_vf *vf, u8 *msg)
 	    (struct virtchnl_vlan_filter_list *)msg;
 	struct i40e_pf *pf = vf->pf;
 	struct i40e_vsi *vsi = NULL;
-	i40e_status aq_ret = 0;
+	int aq_ret = 0;
 	int i;
 
 	if (!i40e_sync_vf_state(vf, I40E_VF_STATE_ACTIVE) ||
@@ -3174,7 +3174,7 @@ static int i40e_vc_iwarp_msg(struct i40e_vf *vf, u8 *msg, u16 msglen)
 {
 	struct i40e_pf *pf = vf->pf;
 	int abs_vf_id = vf->vf_id + pf->hw.func_caps.vf_base_id;
-	i40e_status aq_ret = 0;
+	int aq_ret = 0;
 
 	if (!test_bit(I40E_VF_STATE_ACTIVE, &vf->vf_states) ||
 	    !test_bit(I40E_VF_STATE_IWARPENA, &vf->vf_states)) {
@@ -3203,7 +3203,7 @@ static int i40e_vc_iwarp_qvmap_msg(struct i40e_vf *vf, u8 *msg, bool config)
 {
 	struct virtchnl_iwarp_qvlist_info *qvlist_info =
 				(struct virtchnl_iwarp_qvlist_info *)msg;
-	i40e_status aq_ret = 0;
+	int aq_ret = 0;
 
 	if (!test_bit(I40E_VF_STATE_ACTIVE, &vf->vf_states) ||
 	    !test_bit(I40E_VF_STATE_IWARPENA, &vf->vf_states)) {
@@ -3239,7 +3239,7 @@ static int i40e_vc_config_rss_key(struct i40e_vf *vf, u8 *msg)
 		(struct virtchnl_rss_key *)msg;
 	struct i40e_pf *pf = vf->pf;
 	struct i40e_vsi *vsi = NULL;
-	i40e_status aq_ret = 0;
+	int aq_ret = 0;
 
 	if (!i40e_sync_vf_state(vf, I40E_VF_STATE_ACTIVE) ||
 	    !i40e_vc_isvalid_vsi_id(vf, vrk->vsi_id) ||
@@ -3269,7 +3269,7 @@ static int i40e_vc_config_rss_lut(struct i40e_vf *vf, u8 *msg)
 		(struct virtchnl_rss_lut *)msg;
 	struct i40e_pf *pf = vf->pf;
 	struct i40e_vsi *vsi = NULL;
-	i40e_status aq_ret = 0;
+	int aq_ret = 0;
 	u16 i;
 
 	if (!i40e_sync_vf_state(vf, I40E_VF_STATE_ACTIVE) ||
@@ -3304,7 +3304,7 @@ static int i40e_vc_get_rss_hena(struct i40e_vf *vf, u8 *msg)
 {
 	struct virtchnl_rss_hena *vrh = NULL;
 	struct i40e_pf *pf = vf->pf;
-	i40e_status aq_ret = 0;
+	int aq_ret = 0;
 	int len = 0;
 
 	if (!i40e_sync_vf_state(vf, I40E_VF_STATE_ACTIVE)) {
@@ -3341,7 +3341,7 @@ static int i40e_vc_set_rss_hena(struct i40e_vf *vf, u8 *msg)
 		(struct virtchnl_rss_hena *)msg;
 	struct i40e_pf *pf = vf->pf;
 	struct i40e_hw *hw = &pf->hw;
-	i40e_status aq_ret = 0;
+	int aq_ret = 0;
 
 	if (!i40e_sync_vf_state(vf, I40E_VF_STATE_ACTIVE)) {
 		aq_ret = I40E_ERR_PARAM;
@@ -3365,8 +3365,8 @@ static int i40e_vc_set_rss_hena(struct i40e_vf *vf, u8 *msg)
  **/
 static int i40e_vc_enable_vlan_stripping(struct i40e_vf *vf, u8 *msg)
 {
-	i40e_status aq_ret = 0;
 	struct i40e_vsi *vsi;
+	int aq_ret = 0;
 
 	if (!i40e_sync_vf_state(vf, I40E_VF_STATE_ACTIVE)) {
 		aq_ret = I40E_ERR_PARAM;
@@ -3391,8 +3391,8 @@ static int i40e_vc_enable_vlan_stripping(struct i40e_vf *vf, u8 *msg)
  **/
 static int i40e_vc_disable_vlan_stripping(struct i40e_vf *vf, u8 *msg)
 {
-	i40e_status aq_ret = 0;
 	struct i40e_vsi *vsi;
+	int aq_ret = 0;
 
 	if (!i40e_sync_vf_state(vf, I40E_VF_STATE_ACTIVE)) {
 		aq_ret = I40E_ERR_PARAM;
@@ -3591,8 +3591,8 @@ static void i40e_del_all_cloud_filters(struct i40e_vf *vf)
 			ret = i40e_add_del_cloud_filter(vsi, cfilter, false);
 		if (ret)
 			dev_err(&pf->pdev->dev,
-				"VF %d: Failed to delete cloud filter, err %s aq_err %s\n",
-				vf->vf_id, i40e_stat_str(&pf->hw, ret),
+				"VF %d: Failed to delete cloud filter, err %d aq_err %s\n",
+				vf->vf_id, ret,
 				i40e_aq_str(&pf->hw,
 					    pf->hw.aq.asq_last_status));
 
@@ -3618,7 +3618,7 @@ static int i40e_vc_del_cloud_filter(struct i40e_vf *vf, u8 *msg)
 	struct i40e_pf *pf = vf->pf;
 	struct i40e_vsi *vsi = NULL;
 	struct hlist_node *node;
-	i40e_status aq_ret = 0;
+	int aq_ret = 0;
 	int i, ret;
 
 	if (!i40e_sync_vf_state(vf, I40E_VF_STATE_ACTIVE)) {
@@ -3694,8 +3694,8 @@ static int i40e_vc_del_cloud_filter(struct i40e_vf *vf, u8 *msg)
 		ret = i40e_add_del_cloud_filter(vsi, &cfilter, false);
 	if (ret) {
 		dev_err(&pf->pdev->dev,
-			"VF %d: Failed to delete cloud filter, err %s aq_err %s\n",
-			vf->vf_id, i40e_stat_str(&pf->hw, ret),
+			"VF %d: Failed to delete cloud filter, err %d aq_err %s\n",
+			vf->vf_id, ret,
 			i40e_aq_str(&pf->hw, pf->hw.aq.asq_last_status));
 		goto err;
 	}
@@ -3749,7 +3749,7 @@ static int i40e_vc_add_cloud_filter(struct i40e_vf *vf, u8 *msg)
 	struct i40e_cloud_filter *cfilter = NULL;
 	struct i40e_pf *pf = vf->pf;
 	struct i40e_vsi *vsi = NULL;
-	i40e_status aq_ret = 0;
+	int aq_ret = 0;
 	int i, ret;
 
 	if (!i40e_sync_vf_state(vf, I40E_VF_STATE_ACTIVE)) {
@@ -3828,8 +3828,8 @@ static int i40e_vc_add_cloud_filter(struct i40e_vf *vf, u8 *msg)
 		ret = i40e_add_del_cloud_filter(vsi, cfilter, true);
 	if (ret) {
 		dev_err(&pf->pdev->dev,
-			"VF %d: Failed to add cloud filter, err %s aq_err %s\n",
-			vf->vf_id, i40e_stat_str(&pf->hw, ret),
+			"VF %d: Failed to add cloud filter, err %d aq_err %s\n",
+			vf->vf_id, ret,
 			i40e_aq_str(&pf->hw, pf->hw.aq.asq_last_status));
 		goto err_free;
 	}
@@ -3858,7 +3858,7 @@ static int i40e_vc_add_qch_msg(struct i40e_vf *vf, u8 *msg)
 	struct i40e_pf *pf = vf->pf;
 	struct i40e_link_status *ls = &pf->hw.phy.link_info;
 	int i, adq_request_qps = 0;
-	i40e_status aq_ret = 0;
+	int aq_ret = 0;
 	u64 speed = 0;
 
 	if (!i40e_sync_vf_state(vf, I40E_VF_STATE_ACTIVE)) {
@@ -3970,7 +3970,7 @@ static int i40e_vc_add_qch_msg(struct i40e_vf *vf, u8 *msg)
 static int i40e_vc_del_qch_msg(struct i40e_vf *vf, u8 *msg)
 {
 	struct i40e_pf *pf = vf->pf;
-	i40e_status aq_ret = 0;
+	int aq_ret = 0;
 
 	if (!i40e_sync_vf_state(vf, I40E_VF_STATE_ACTIVE)) {
 		aq_ret = I40E_ERR_PARAM;
diff --git a/drivers/net/ethernet/intel/ice/ice_fltr.c b/drivers/net/ethernet/intel/ice/ice_fltr.c
index 2418d4fff037..e27b4de7e7aa 100644
--- a/drivers/net/ethernet/intel/ice/ice_fltr.c
+++ b/drivers/net/ethernet/intel/ice/ice_fltr.c
@@ -128,7 +128,7 @@ void ice_fltr_remove_all(struct ice_vsi *vsi)
  * @mac: MAC address to add
  * @action: filter action
  */
-int
+enum ice_status
 ice_fltr_add_mac_to_list(struct ice_vsi *vsi, struct list_head *list,
 			 const u8 *mac, enum ice_sw_fwd_act_type action)
 {
diff --git a/drivers/net/ethernet/qlogic/qed/qed_l2.c b/drivers/net/ethernet/qlogic/qed/qed_l2.c
index ba8c7a31cce1..bc17bc36d346 100644
--- a/drivers/net/ethernet/qlogic/qed/qed_l2.c
+++ b/drivers/net/ethernet/qlogic/qed/qed_l2.c
@@ -1903,7 +1903,7 @@ void qed_get_vport_stats(struct qed_dev *cdev, struct qed_eth_stats *stats)
 {
 	u32 i;
 
-	if (!cdev) {
+	if (!cdev || cdev->recov_in_prog) {
 		memset(stats, 0, sizeof(*stats));
 		return;
 	}
diff --git a/drivers/net/ethernet/qlogic/qede/qede.h b/drivers/net/ethernet/qlogic/qede/qede.h
index f90dcfe9ee68..8a63f99d499c 100644
--- a/drivers/net/ethernet/qlogic/qede/qede.h
+++ b/drivers/net/ethernet/qlogic/qede/qede.h
@@ -271,6 +271,10 @@ struct qede_dev {
 #define QEDE_ERR_WARN			3
 
 	struct qede_dump_info		dump_info;
+	struct delayed_work		periodic_task;
+	unsigned long			stats_coal_ticks;
+	u32				stats_coal_usecs;
+	spinlock_t			stats_lock; /* lock for vport stats access */
 };
 
 enum QEDE_STATE {
diff --git a/drivers/net/ethernet/qlogic/qede/qede_ethtool.c b/drivers/net/ethernet/qlogic/qede/qede_ethtool.c
index 8284c4c1528f..28108f6324fb 100644
--- a/drivers/net/ethernet/qlogic/qede/qede_ethtool.c
+++ b/drivers/net/ethernet/qlogic/qede/qede_ethtool.c
@@ -426,6 +426,8 @@ static void qede_get_ethtool_stats(struct net_device *dev,
 		}
 	}
 
+	spin_lock(&edev->stats_lock);
+
 	for (i = 0; i < QEDE_NUM_STATS; i++) {
 		if (qede_is_irrelevant_stat(edev, i))
 			continue;
@@ -435,6 +437,8 @@ static void qede_get_ethtool_stats(struct net_device *dev,
 		buf++;
 	}
 
+	spin_unlock(&edev->stats_lock);
+
 	__qede_unlock(edev);
 }
 
@@ -817,6 +821,7 @@ static int qede_get_coalesce(struct net_device *dev,
 
 	coal->rx_coalesce_usecs = rx_coal;
 	coal->tx_coalesce_usecs = tx_coal;
+	coal->stats_block_coalesce_usecs = edev->stats_coal_usecs;
 
 	return rc;
 }
@@ -830,6 +835,19 @@ int qede_set_coalesce(struct net_device *dev, struct ethtool_coalesce *coal,
 	int i, rc = 0;
 	u16 rxc, txc;
 
+	if (edev->stats_coal_usecs != coal->stats_block_coalesce_usecs) {
+		edev->stats_coal_usecs = coal->stats_block_coalesce_usecs;
+		if (edev->stats_coal_usecs) {
+			edev->stats_coal_ticks = usecs_to_jiffies(edev->stats_coal_usecs);
+			schedule_delayed_work(&edev->periodic_task, 0);
+
+			DP_INFO(edev, "Configured stats coal ticks=%lu jiffies\n",
+				edev->stats_coal_ticks);
+		} else {
+			cancel_delayed_work_sync(&edev->periodic_task);
+		}
+	}
+
 	if (!netif_running(dev)) {
 		DP_INFO(edev, "Interface is down\n");
 		return -EINVAL;
@@ -2236,7 +2254,8 @@ static int qede_get_per_coalesce(struct net_device *dev,
 }
 
 static const struct ethtool_ops qede_ethtool_ops = {
-	.supported_coalesce_params	= ETHTOOL_COALESCE_USECS,
+	.supported_coalesce_params	= ETHTOOL_COALESCE_USECS |
+					  ETHTOOL_COALESCE_STATS_BLOCK_USECS,
 	.get_link_ksettings		= qede_get_link_ksettings,
 	.set_link_ksettings		= qede_set_link_ksettings,
 	.get_drvinfo			= qede_get_drvinfo,
@@ -2287,7 +2306,8 @@ static const struct ethtool_ops qede_ethtool_ops = {
 };
 
 static const struct ethtool_ops qede_vf_ethtool_ops = {
-	.supported_coalesce_params	= ETHTOOL_COALESCE_USECS,
+	.supported_coalesce_params	= ETHTOOL_COALESCE_USECS |
+					  ETHTOOL_COALESCE_STATS_BLOCK_USECS,
 	.get_link_ksettings		= qede_get_link_ksettings,
 	.get_drvinfo			= qede_get_drvinfo,
 	.get_msglevel			= qede_get_msglevel,
diff --git a/drivers/net/ethernet/qlogic/qede/qede_main.c b/drivers/net/ethernet/qlogic/qede/qede_main.c
index 2d3f0ae4f889..41f0a3433c3a 100644
--- a/drivers/net/ethernet/qlogic/qede/qede_main.c
+++ b/drivers/net/ethernet/qlogic/qede/qede_main.c
@@ -308,6 +308,8 @@ void qede_fill_by_demand_stats(struct qede_dev *edev)
 
 	edev->ops->get_vport_stats(edev->cdev, &stats);
 
+	spin_lock(&edev->stats_lock);
+
 	p_common->no_buff_discards = stats.common.no_buff_discards;
 	p_common->packet_too_big_discard = stats.common.packet_too_big_discard;
 	p_common->ttl0_discard = stats.common.ttl0_discard;
@@ -405,6 +407,8 @@ void qede_fill_by_demand_stats(struct qede_dev *edev)
 		p_ah->tx_1519_to_max_byte_packets =
 		    stats.ah.tx_1519_to_max_byte_packets;
 	}
+
+	spin_unlock(&edev->stats_lock);
 }
 
 static void qede_get_stats64(struct net_device *dev,
@@ -413,9 +417,10 @@ static void qede_get_stats64(struct net_device *dev,
 	struct qede_dev *edev = netdev_priv(dev);
 	struct qede_stats_common *p_common;
 
-	qede_fill_by_demand_stats(edev);
 	p_common = &edev->stats.common;
 
+	spin_lock(&edev->stats_lock);
+
 	stats->rx_packets = p_common->rx_ucast_pkts + p_common->rx_mcast_pkts +
 			    p_common->rx_bcast_pkts;
 	stats->tx_packets = p_common->tx_ucast_pkts + p_common->tx_mcast_pkts +
@@ -435,6 +440,8 @@ static void qede_get_stats64(struct net_device *dev,
 		stats->collisions = edev->stats.bb.tx_total_collisions;
 	stats->rx_crc_errors = p_common->rx_crc_errors;
 	stats->rx_frame_errors = p_common->rx_align_errors;
+
+	spin_unlock(&edev->stats_lock);
 }
 
 #ifdef CONFIG_QED_SRIOV
@@ -1000,6 +1007,23 @@ static void qede_unlock(struct qede_dev *edev)
 	rtnl_unlock();
 }
 
+static void qede_periodic_task(struct work_struct *work)
+{
+	struct qede_dev *edev = container_of(work, struct qede_dev,
+					     periodic_task.work);
+
+	qede_fill_by_demand_stats(edev);
+	schedule_delayed_work(&edev->periodic_task, edev->stats_coal_ticks);
+}
+
+static void qede_init_periodic_task(struct qede_dev *edev)
+{
+	INIT_DELAYED_WORK(&edev->periodic_task, qede_periodic_task);
+	spin_lock_init(&edev->stats_lock);
+	edev->stats_coal_usecs = USEC_PER_SEC;
+	edev->stats_coal_ticks = usecs_to_jiffies(USEC_PER_SEC);
+}
+
 static void qede_sp_task(struct work_struct *work)
 {
 	struct qede_dev *edev = container_of(work, struct qede_dev,
@@ -1019,6 +1043,7 @@ static void qede_sp_task(struct work_struct *work)
 	 */
 
 	if (test_and_clear_bit(QEDE_SP_RECOVERY, &edev->sp_flags)) {
+		cancel_delayed_work_sync(&edev->periodic_task);
 #ifdef CONFIG_QED_SRIOV
 		/* SRIOV must be disabled outside the lock to avoid a deadlock.
 		 * The recovery of the active VFs is currently not supported.
@@ -1209,6 +1234,7 @@ static int __qede_probe(struct pci_dev *pdev, u32 dp_module, u8 dp_level,
 		 */
 		INIT_DELAYED_WORK(&edev->sp_task, qede_sp_task);
 		mutex_init(&edev->qede_lock);
+		qede_init_periodic_task(edev);
 
 		rc = register_netdev(edev->ndev);
 		if (rc) {
@@ -1233,6 +1259,11 @@ static int __qede_probe(struct pci_dev *pdev, u32 dp_module, u8 dp_level,
 	edev->rx_copybreak = QEDE_RX_HDR_SIZE;
 
 	qede_log_probe(edev);
+
+	/* retain user config (for example - after recovery) */
+	if (edev->stats_coal_usecs)
+		schedule_delayed_work(&edev->periodic_task, 0);
+
 	return 0;
 
 err4:
@@ -1301,6 +1332,7 @@ static void __qede_remove(struct pci_dev *pdev, enum qede_remove_mode mode)
 		unregister_netdev(ndev);
 
 		cancel_delayed_work_sync(&edev->sp_task);
+		cancel_delayed_work_sync(&edev->periodic_task);
 
 		edev->ops->common->set_power_state(cdev, PCI_D0);
 
diff --git a/drivers/net/ethernet/sfc/ef100_tx.c b/drivers/net/ethernet/sfc/ef100_tx.c
index 26ef51d6b542..e92379bd8f44 100644
--- a/drivers/net/ethernet/sfc/ef100_tx.c
+++ b/drivers/net/ethernet/sfc/ef100_tx.c
@@ -349,7 +349,8 @@ void ef100_ev_tx(struct efx_channel *channel, const efx_qword_t *p_event)
  * Returns 0 on success, error code otherwise. In case of an error this
  * function will free the SKB.
  */
-int ef100_enqueue_skb(struct efx_tx_queue *tx_queue, struct sk_buff *skb)
+netdev_tx_t ef100_enqueue_skb(struct efx_tx_queue *tx_queue,
+			      struct sk_buff *skb)
 {
 	unsigned int old_insert_count = tx_queue->insert_count;
 	struct efx_nic *efx = tx_queue->efx;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
index 37bc307c1971..2f0ba8a75d71 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
@@ -869,7 +869,10 @@ void mt7615_mac_sta_poll(struct mt7615_dev *dev)
 
 		msta = list_first_entry(&sta_poll_list, struct mt7615_sta,
 					poll_list);
+
+		spin_lock_bh(&dev->sta_poll_lock);
 		list_del_init(&msta->poll_list);
+		spin_unlock_bh(&dev->sta_poll_lock);
 
 		addr = mt7615_mac_wtbl_addr(dev, msta->wcid.idx) + 19 * 4;
 
diff --git a/drivers/pinctrl/meson/pinctrl-meson-axg.c b/drivers/pinctrl/meson/pinctrl-meson-axg.c
index 7bfecdfba177..d249a035c2b9 100644
--- a/drivers/pinctrl/meson/pinctrl-meson-axg.c
+++ b/drivers/pinctrl/meson/pinctrl-meson-axg.c
@@ -400,6 +400,7 @@ static struct meson_pmx_group meson_axg_periphs_groups[] = {
 	GPIO_GROUP(GPIOA_15),
 	GPIO_GROUP(GPIOA_16),
 	GPIO_GROUP(GPIOA_17),
+	GPIO_GROUP(GPIOA_18),
 	GPIO_GROUP(GPIOA_19),
 	GPIO_GROUP(GPIOA_20),
 
diff --git a/drivers/platform/surface/aggregator/controller.c b/drivers/platform/surface/aggregator/controller.c
index f23f7128cf2b..5542b768890c 100644
--- a/drivers/platform/surface/aggregator/controller.c
+++ b/drivers/platform/surface/aggregator/controller.c
@@ -825,7 +825,7 @@ static int ssam_cplt_init(struct ssam_cplt *cplt, struct device *dev)
 
 	cplt->dev = dev;
 
-	cplt->wq = create_workqueue(SSAM_CPLT_WQ_NAME);
+	cplt->wq = alloc_workqueue(SSAM_CPLT_WQ_NAME, WQ_UNBOUND | WQ_MEM_RECLAIM, 0);
 	if (!cplt->wq)
 		return -ENOMEM;
 
diff --git a/drivers/s390/block/dasd_ioctl.c b/drivers/s390/block/dasd_ioctl.c
index 468cbeb539ff..7b76491f4fe9 100644
--- a/drivers/s390/block/dasd_ioctl.c
+++ b/drivers/s390/block/dasd_ioctl.c
@@ -502,10 +502,10 @@ static int __dasd_ioctl_information(struct dasd_block *block,
 
 	memcpy(dasd_info->type, base->discipline->name, 4);
 
-	spin_lock_irqsave(&block->queue_lock, flags);
+	spin_lock_irqsave(get_ccwdev_lock(base->cdev), flags);
 	list_for_each(l, &base->ccw_queue)
 		dasd_info->chanq_len++;
-	spin_unlock_irqrestore(&block->queue_lock, flags);
+	spin_unlock_irqrestore(get_ccwdev_lock(base->cdev), flags);
 	return 0;
 }
 
diff --git a/drivers/spi/spi-qup.c b/drivers/spi/spi-qup.c
index 8bf58510cca6..2cc9bb413c10 100644
--- a/drivers/spi/spi-qup.c
+++ b/drivers/spi/spi-qup.c
@@ -1030,23 +1030,8 @@ static int spi_qup_probe(struct platform_device *pdev)
 		return -ENXIO;
 	}
 
-	ret = clk_prepare_enable(cclk);
-	if (ret) {
-		dev_err(dev, "cannot enable core clock\n");
-		return ret;
-	}
-
-	ret = clk_prepare_enable(iclk);
-	if (ret) {
-		clk_disable_unprepare(cclk);
-		dev_err(dev, "cannot enable iface clock\n");
-		return ret;
-	}
-
 	master = spi_alloc_master(dev, sizeof(struct spi_qup));
 	if (!master) {
-		clk_disable_unprepare(cclk);
-		clk_disable_unprepare(iclk);
 		dev_err(dev, "cannot allocate master\n");
 		return -ENOMEM;
 	}
@@ -1092,6 +1077,19 @@ static int spi_qup_probe(struct platform_device *pdev)
 	spin_lock_init(&controller->lock);
 	init_completion(&controller->done);
 
+	ret = clk_prepare_enable(cclk);
+	if (ret) {
+		dev_err(dev, "cannot enable core clock\n");
+		goto error_dma;
+	}
+
+	ret = clk_prepare_enable(iclk);
+	if (ret) {
+		clk_disable_unprepare(cclk);
+		dev_err(dev, "cannot enable iface clock\n");
+		goto error_dma;
+	}
+
 	iomode = readl_relaxed(base + QUP_IO_M_MODES);
 
 	size = QUP_IO_M_OUTPUT_BLOCK_SIZE(iomode);
@@ -1121,7 +1119,7 @@ static int spi_qup_probe(struct platform_device *pdev)
 	ret = spi_qup_set_state(controller, QUP_STATE_RESET);
 	if (ret) {
 		dev_err(dev, "cannot set RESET state\n");
-		goto error_dma;
+		goto error_clk;
 	}
 
 	writel_relaxed(0, base + QUP_OPERATIONAL);
@@ -1145,7 +1143,7 @@ static int spi_qup_probe(struct platform_device *pdev)
 	ret = devm_request_irq(dev, irq, spi_qup_qup_irq,
 			       IRQF_TRIGGER_HIGH, pdev->name, controller);
 	if (ret)
-		goto error_dma;
+		goto error_clk;
 
 	pm_runtime_set_autosuspend_delay(dev, MSEC_PER_SEC);
 	pm_runtime_use_autosuspend(dev);
@@ -1160,11 +1158,12 @@ static int spi_qup_probe(struct platform_device *pdev)
 
 disable_pm:
 	pm_runtime_disable(&pdev->dev);
+error_clk:
+	clk_disable_unprepare(cclk);
+	clk_disable_unprepare(iclk);
 error_dma:
 	spi_qup_release_dma(master);
 error:
-	clk_disable_unprepare(cclk);
-	clk_disable_unprepare(iclk);
 	spi_master_put(master);
 	return ret;
 }
diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
index 52d7dc5b2905..48c696df8d01 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
@@ -49,9 +49,9 @@ static const struct rtl819x_ops rtl819xp_ops = {
 };
 
 static struct pci_device_id rtl8192_pci_id_tbl[] = {
-	{PCI_DEVICE(0x10ec, 0x8192)},
-	{PCI_DEVICE(0x07aa, 0x0044)},
-	{PCI_DEVICE(0x07aa, 0x0047)},
+	{RTL_PCI_DEVICE(0x10ec, 0x8192, rtl819xp_ops)},
+	{RTL_PCI_DEVICE(0x07aa, 0x0044, rtl819xp_ops)},
+	{RTL_PCI_DEVICE(0x07aa, 0x0047, rtl819xp_ops)},
 	{}
 };
 
diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_core.h b/drivers/staging/rtl8192e/rtl8192e/rtl_core.h
index 197f1e3d7aca..698552a92100 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_core.h
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_core.h
@@ -55,6 +55,11 @@
 #define IS_HARDWARE_TYPE_8192SE(_priv)		\
 	(((struct r8192_priv *)rtllib_priv(dev))->card_8192 == NIC_8192SE)
 
+#define RTL_PCI_DEVICE(vend, dev, cfg) \
+	.vendor = (vend), .device = (dev), \
+	.subvendor = PCI_ANY_ID, .subdevice = PCI_ANY_ID, \
+	.driver_data = (kernel_ulong_t)&(cfg)
+
 #define TOTAL_CAM_ENTRY		32
 #define CAM_CONTENT_COUNT	8
 
diff --git a/drivers/tee/amdtee/amdtee_if.h b/drivers/tee/amdtee/amdtee_if.h
index ff48c3e47375..e2014e21530a 100644
--- a/drivers/tee/amdtee/amdtee_if.h
+++ b/drivers/tee/amdtee/amdtee_if.h
@@ -118,16 +118,18 @@ struct tee_cmd_unmap_shared_mem {
 
 /**
  * struct tee_cmd_load_ta - load Trusted Application (TA) binary into TEE
- * @low_addr:    [in] bits [31:0] of the physical address of the TA binary
- * @hi_addr:     [in] bits [63:32] of the physical address of the TA binary
- * @size:        [in] size of TA binary in bytes
- * @ta_handle:   [out] return handle of the loaded TA
+ * @low_addr:       [in] bits [31:0] of the physical address of the TA binary
+ * @hi_addr:        [in] bits [63:32] of the physical address of the TA binary
+ * @size:           [in] size of TA binary in bytes
+ * @ta_handle:      [out] return handle of the loaded TA
+ * @return_origin:  [out] origin of return code after TEE processing
  */
 struct tee_cmd_load_ta {
 	u32 low_addr;
 	u32 hi_addr;
 	u32 size;
 	u32 ta_handle;
+	u32 return_origin;
 };
 
 /**
diff --git a/drivers/tee/amdtee/call.c b/drivers/tee/amdtee/call.c
index 07f36ac834c8..63d428423e90 100644
--- a/drivers/tee/amdtee/call.c
+++ b/drivers/tee/amdtee/call.c
@@ -423,19 +423,23 @@ int handle_load_ta(void *data, u32 size, struct tee_ioctl_open_session_arg *arg)
 	if (ret) {
 		arg->ret_origin = TEEC_ORIGIN_COMMS;
 		arg->ret = TEEC_ERROR_COMMUNICATION;
-	} else if (arg->ret == TEEC_SUCCESS) {
-		ret = get_ta_refcount(load_cmd.ta_handle);
-		if (!ret) {
-			arg->ret_origin = TEEC_ORIGIN_COMMS;
-			arg->ret = TEEC_ERROR_OUT_OF_MEMORY;
-
-			/* Unload the TA on error */
-			unload_cmd.ta_handle = load_cmd.ta_handle;
-			psp_tee_process_cmd(TEE_CMD_ID_UNLOAD_TA,
-					    (void *)&unload_cmd,
-					    sizeof(unload_cmd), &ret);
-		} else {
-			set_session_id(load_cmd.ta_handle, 0, &arg->session);
+	} else {
+		arg->ret_origin = load_cmd.return_origin;
+
+		if (arg->ret == TEEC_SUCCESS) {
+			ret = get_ta_refcount(load_cmd.ta_handle);
+			if (!ret) {
+				arg->ret_origin = TEEC_ORIGIN_COMMS;
+				arg->ret = TEEC_ERROR_OUT_OF_MEMORY;
+
+				/* Unload the TA on error */
+				unload_cmd.ta_handle = load_cmd.ta_handle;
+				psp_tee_process_cmd(TEE_CMD_ID_UNLOAD_TA,
+						    (void *)&unload_cmd,
+						    sizeof(unload_cmd), &ret);
+			} else {
+				set_session_id(load_cmd.ta_handle, 0, &arg->session);
+			}
 		}
 	}
 	mutex_unlock(&ta_refcount_mutex);
diff --git a/drivers/usb/core/buffer.c b/drivers/usb/core/buffer.c
index fbb087b728dc..268ccbec88f9 100644
--- a/drivers/usb/core/buffer.c
+++ b/drivers/usb/core/buffer.c
@@ -172,3 +172,44 @@ void hcd_buffer_free(
 	}
 	dma_free_coherent(hcd->self.sysdev, size, addr, dma);
 }
+
+void *hcd_buffer_alloc_pages(struct usb_hcd *hcd,
+		size_t size, gfp_t mem_flags, dma_addr_t *dma)
+{
+	if (size == 0)
+		return NULL;
+
+	if (hcd->localmem_pool)
+		return gen_pool_dma_alloc_align(hcd->localmem_pool,
+				size, dma, PAGE_SIZE);
+
+	/* some USB hosts just use PIO */
+	if (!hcd_uses_dma(hcd)) {
+		*dma = DMA_MAPPING_ERROR;
+		return (void *)__get_free_pages(mem_flags,
+				get_order(size));
+	}
+
+	return dma_alloc_coherent(hcd->self.sysdev,
+			size, dma, mem_flags);
+}
+
+void hcd_buffer_free_pages(struct usb_hcd *hcd,
+		size_t size, void *addr, dma_addr_t dma)
+{
+	if (!addr)
+		return;
+
+	if (hcd->localmem_pool) {
+		gen_pool_free(hcd->localmem_pool,
+				(unsigned long)addr, size);
+		return;
+	}
+
+	if (!hcd_uses_dma(hcd)) {
+		free_pages((unsigned long)addr, get_order(size));
+		return;
+	}
+
+	dma_free_coherent(hcd->self.sysdev, size, addr, dma);
+}
diff --git a/drivers/usb/core/devio.c b/drivers/usb/core/devio.c
index 656ba91c3283..5e34986fac96 100644
--- a/drivers/usb/core/devio.c
+++ b/drivers/usb/core/devio.c
@@ -174,6 +174,7 @@ static int connected(struct usb_dev_state *ps)
 static void dec_usb_memory_use_count(struct usb_memory *usbm, int *count)
 {
 	struct usb_dev_state *ps = usbm->ps;
+	struct usb_hcd *hcd = bus_to_hcd(ps->dev->bus);
 	unsigned long flags;
 
 	spin_lock_irqsave(&ps->lock, flags);
@@ -182,8 +183,8 @@ static void dec_usb_memory_use_count(struct usb_memory *usbm, int *count)
 		list_del(&usbm->memlist);
 		spin_unlock_irqrestore(&ps->lock, flags);
 
-		usb_free_coherent(ps->dev, usbm->size, usbm->mem,
-				usbm->dma_handle);
+		hcd_buffer_free_pages(hcd, usbm->size,
+				usbm->mem, usbm->dma_handle);
 		usbfs_decrease_memory_usage(
 			usbm->size + sizeof(struct usb_memory));
 		kfree(usbm);
@@ -222,7 +223,7 @@ static int usbdev_mmap(struct file *file, struct vm_area_struct *vma)
 	size_t size = vma->vm_end - vma->vm_start;
 	void *mem;
 	unsigned long flags;
-	dma_addr_t dma_handle;
+	dma_addr_t dma_handle = DMA_MAPPING_ERROR;
 	int ret;
 
 	ret = usbfs_increase_memory_usage(size + sizeof(struct usb_memory));
@@ -235,8 +236,8 @@ static int usbdev_mmap(struct file *file, struct vm_area_struct *vma)
 		goto error_decrease_mem;
 	}
 
-	mem = usb_alloc_coherent(ps->dev, size, GFP_USER | __GFP_NOWARN,
-			&dma_handle);
+	mem = hcd_buffer_alloc_pages(hcd,
+			size, GFP_USER | __GFP_NOWARN, &dma_handle);
 	if (!mem) {
 		ret = -ENOMEM;
 		goto error_free_usbm;
@@ -252,7 +253,14 @@ static int usbdev_mmap(struct file *file, struct vm_area_struct *vma)
 	usbm->vma_use_count = 1;
 	INIT_LIST_HEAD(&usbm->memlist);
 
-	if (hcd->localmem_pool || !hcd_uses_dma(hcd)) {
+	/*
+	 * In DMA-unavailable cases, hcd_buffer_alloc_pages allocates
+	 * normal pages and assigns DMA_MAPPING_ERROR to dma_handle. Check
+	 * whether we are in such cases, and then use remap_pfn_range (or
+	 * dma_mmap_coherent) to map normal (or DMA) pages into the user
+	 * space, respectively.
+	 */
+	if (dma_handle == DMA_MAPPING_ERROR) {
 		if (remap_pfn_range(vma, vma->vm_start,
 				    virt_to_phys(usbm->mem) >> PAGE_SHIFT,
 				    size, vma->vm_page_prot) < 0) {
diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/vduse_dev.c
index 3467c75f310a..30ae4237f3dd 100644
--- a/drivers/vdpa/vdpa_user/vduse_dev.c
+++ b/drivers/vdpa/vdpa_user/vduse_dev.c
@@ -1254,6 +1254,9 @@ static bool vduse_validate_config(struct vduse_dev_config *config)
 	if (config->vq_num > 0xffff)
 		return false;
 
+	if (!config->name[0])
+		return false;
+
 	if (!device_is_allowed(config->device_id))
 		return false;
 
diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
index 299a99532618..9ca8b92d92ae 100644
--- a/drivers/vhost/vdpa.c
+++ b/drivers/vhost/vdpa.c
@@ -392,7 +392,14 @@ static long vhost_vdpa_vring_ioctl(struct vhost_vdpa *v, unsigned int cmd,
 		if (r)
 			return r;
 
-		vq->last_avail_idx = vq_state.split.avail_index;
+		if (vhost_has_feature(vq, VIRTIO_F_RING_PACKED)) {
+			vq->last_avail_idx = vq_state.packed.last_avail_idx |
+					     (vq_state.packed.last_avail_counter << 15);
+			vq->last_used_idx = vq_state.packed.last_used_idx |
+					    (vq_state.packed.last_used_counter << 15);
+		} else {
+			vq->last_avail_idx = vq_state.split.avail_index;
+		}
 		break;
 	}
 
@@ -410,9 +417,15 @@ static long vhost_vdpa_vring_ioctl(struct vhost_vdpa *v, unsigned int cmd,
 		break;
 
 	case VHOST_SET_VRING_BASE:
-		vq_state.split.avail_index = vq->last_avail_idx;
-		if (ops->set_vq_state(vdpa, idx, &vq_state))
-			r = -EINVAL;
+		if (vhost_has_feature(vq, VIRTIO_F_RING_PACKED)) {
+			vq_state.packed.last_avail_idx = vq->last_avail_idx & 0x7fff;
+			vq_state.packed.last_avail_counter = !!(vq->last_avail_idx & 0x8000);
+			vq_state.packed.last_used_idx = vq->last_used_idx & 0x7fff;
+			vq_state.packed.last_used_counter = !!(vq->last_used_idx & 0x8000);
+		} else {
+			vq_state.split.avail_index = vq->last_avail_idx;
+		}
+		r = ops->set_vq_state(vdpa, idx, &vq_state);
 		break;
 
 	case VHOST_SET_VRING_CALL:
diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index c0f926a9c298..047fa2faef56 100644
--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -1628,17 +1628,25 @@ long vhost_vring_ioctl(struct vhost_dev *d, unsigned int ioctl, void __user *arg
 			r = -EFAULT;
 			break;
 		}
-		if (s.num > 0xffff) {
-			r = -EINVAL;
-			break;
+		if (vhost_has_feature(vq, VIRTIO_F_RING_PACKED)) {
+			vq->last_avail_idx = s.num & 0xffff;
+			vq->last_used_idx = (s.num >> 16) & 0xffff;
+		} else {
+			if (s.num > 0xffff) {
+				r = -EINVAL;
+				break;
+			}
+			vq->last_avail_idx = s.num;
 		}
-		vq->last_avail_idx = s.num;
 		/* Forget the cached index value. */
 		vq->avail_idx = vq->last_avail_idx;
 		break;
 	case VHOST_GET_VRING_BASE:
 		s.index = idx;
-		s.num = vq->last_avail_idx;
+		if (vhost_has_feature(vq, VIRTIO_F_RING_PACKED))
+			s.num = (u32)vq->last_avail_idx | ((u32)vq->last_used_idx << 16);
+		else
+			s.num = vq->last_avail_idx;
 		if (copy_to_user(argp, &s, sizeof s))
 			r = -EFAULT;
 		break;
diff --git a/drivers/vhost/vhost.h b/drivers/vhost/vhost.h
index f2675c0aa08e..6378f020e6d5 100644
--- a/drivers/vhost/vhost.h
+++ b/drivers/vhost/vhost.h
@@ -86,13 +86,17 @@ struct vhost_virtqueue {
 	/* The routine to call when the Guest pings us, or timeout. */
 	vhost_work_fn_t handle_kick;
 
-	/* Last available index we saw. */
+	/* Last available index we saw.
+	 * Values are limited to 0x7fff, and the high bit is used as
+	 * a wrap counter when using VIRTIO_F_RING_PACKED. */
 	u16 last_avail_idx;
 
 	/* Caches available index value from user. */
 	u16 avail_idx;
 
-	/* Last index we used. */
+	/* Last index we used.
+	 * Values are limited to 0x7fff, and the high bit is used as
+	 * a wrap counter when using VIRTIO_F_RING_PACKED. */
 	u16 last_used_idx;
 
 	/* Used flags */
diff --git a/fs/afs/dir.c b/fs/afs/dir.c
index 948a808a964d..cec18f9f8bd7 100644
--- a/fs/afs/dir.c
+++ b/fs/afs/dir.c
@@ -1394,6 +1394,7 @@ static int afs_mkdir(struct user_namespace *mnt_userns, struct inode *dir,
 	op->dentry	= dentry;
 	op->create.mode	= S_IFDIR | mode;
 	op->create.reason = afs_edit_dir_for_mkdir;
+	op->mtime	= current_time(dir);
 	op->ops		= &afs_mkdir_operation;
 	return afs_do_sync_operation(op);
 }
@@ -1697,6 +1698,7 @@ static int afs_create(struct user_namespace *mnt_userns, struct inode *dir,
 	op->dentry	= dentry;
 	op->create.mode	= S_IFREG | mode;
 	op->create.reason = afs_edit_dir_for_create;
+	op->mtime	= current_time(dir);
 	op->ops		= &afs_create_operation;
 	return afs_do_sync_operation(op);
 
@@ -1832,6 +1834,7 @@ static int afs_symlink(struct user_namespace *mnt_userns, struct inode *dir,
 	op->ops			= &afs_symlink_operation;
 	op->create.reason	= afs_edit_dir_for_symlink;
 	op->create.symlink	= content;
+	op->mtime		= current_time(dir);
 	return afs_do_sync_operation(op);
 
 error:
diff --git a/fs/ceph/caps.c b/fs/ceph/caps.c
index 67b782b0a90a..6ff3aaebaf93 100644
--- a/fs/ceph/caps.c
+++ b/fs/ceph/caps.c
@@ -1624,6 +1624,7 @@ void ceph_flush_snaps(struct ceph_inode_info *ci,
 	struct inode *inode = &ci->vfs_inode;
 	struct ceph_mds_client *mdsc = ceph_inode_to_client(inode)->mdsc;
 	struct ceph_mds_session *session = NULL;
+	bool need_put = false;
 	int mds;
 
 	dout("ceph_flush_snaps %p\n", inode);
@@ -1668,8 +1669,13 @@ void ceph_flush_snaps(struct ceph_inode_info *ci,
 		ceph_put_mds_session(session);
 	/* we flushed them all; remove this inode from the queue */
 	spin_lock(&mdsc->snap_flush_lock);
+	if (!list_empty(&ci->i_snap_flush_item))
+		need_put = true;
 	list_del_init(&ci->i_snap_flush_item);
 	spin_unlock(&mdsc->snap_flush_lock);
+
+	if (need_put)
+		iput(inode);
 }
 
 /*
diff --git a/fs/ceph/snap.c b/fs/ceph/snap.c
index f7dd1dfd07f2..bfa7e146f526 100644
--- a/fs/ceph/snap.c
+++ b/fs/ceph/snap.c
@@ -657,8 +657,10 @@ int __ceph_finish_cap_snap(struct ceph_inode_info *ci,
 	     capsnap->size);
 
 	spin_lock(&mdsc->snap_flush_lock);
-	if (list_empty(&ci->i_snap_flush_item))
+	if (list_empty(&ci->i_snap_flush_item)) {
+		ihold(inode);
 		list_add_tail(&ci->i_snap_flush_item, &mdsc->snap_flush_list);
+	}
 	spin_unlock(&mdsc->snap_flush_lock);
 	return 1;  /* caller may want to ceph_flush_snaps */
 }
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index ebe2abc064e7..acbecefae316 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -5748,7 +5748,6 @@ static int ext4_remount(struct super_block *sb, int *flags, char *data)
 	struct ext4_mount_options old_opts;
 	ext4_group_t g;
 	int err = 0;
-	int enable_rw = 0;
 #ifdef CONFIG_QUOTA
 	int enable_quota = 0;
 	int i, j;
@@ -5949,7 +5948,7 @@ static int ext4_remount(struct super_block *sb, int *flags, char *data)
 			if (err)
 				goto restore_opts;
 
-			enable_rw = 1;
+			sb->s_flags &= ~SB_RDONLY;
 			if (ext4_has_feature_mmp(sb)) {
 				err = ext4_multi_mount_protect(sb,
 						le64_to_cpu(es->s_mmp_block));
@@ -5996,9 +5995,6 @@ static int ext4_remount(struct super_block *sb, int *flags, char *data)
 	if (!test_opt(sb, BLOCK_VALIDITY) && sbi->s_system_blks)
 		ext4_release_system_zone(sb);
 
-	if (enable_rw)
-		sb->s_flags &= ~SB_RDONLY;
-
 	/*
 	 * Reinitialize lazy itable initialization thread based on
 	 * current settings
diff --git a/fs/ext4/xattr.c b/fs/ext4/xattr.c
index 55d6eb9319f5..6c982869f101 100644
--- a/fs/ext4/xattr.c
+++ b/fs/ext4/xattr.c
@@ -2006,8 +2006,9 @@ ext4_xattr_block_set(handle_t *handle, struct inode *inode,
 			else {
 				u32 ref;
 
+#ifdef EXT4_XATTR_DEBUG
 				WARN_ON_ONCE(dquot_initialize_needed(inode));
-
+#endif
 				/* The old block is released after updating
 				   the inode. */
 				error = dquot_alloc_block(inode,
@@ -2070,8 +2071,9 @@ ext4_xattr_block_set(handle_t *handle, struct inode *inode,
 			/* We need to allocate a new block */
 			ext4_fsblk_t goal, block;
 
+#ifdef EXT4_XATTR_DEBUG
 			WARN_ON_ONCE(dquot_initialize_needed(inode));
-
+#endif
 			goal = ext4_group_first_block_no(sb,
 						EXT4_I(inode)->i_block_group);
 			block = ext4_new_meta_blocks(handle, inode, goal, 0,
diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
index 8b36e61fe7ed..63af1573ebca 100644
--- a/fs/f2fs/sysfs.c
+++ b/fs/f2fs/sysfs.c
@@ -491,9 +491,9 @@ static ssize_t __sbi_store(struct f2fs_attr *a,
 	if (!strcmp(a->attr.name, "iostat_period_ms")) {
 		if (t < MIN_IOSTAT_PERIOD_MS || t > MAX_IOSTAT_PERIOD_MS)
 			return -EINVAL;
-		spin_lock(&sbi->iostat_lock);
+		spin_lock_irq(&sbi->iostat_lock);
 		sbi->iostat_period_ms = (unsigned int)t;
-		spin_unlock(&sbi->iostat_lock);
+		spin_unlock_irq(&sbi->iostat_lock);
 		return count;
 	}
 #endif
diff --git a/fs/xfs/xfs_buf_item_recover.c b/fs/xfs/xfs_buf_item_recover.c
index 991fbf1eb564..e04e44ef14c6 100644
--- a/fs/xfs/xfs_buf_item_recover.c
+++ b/fs/xfs/xfs_buf_item_recover.c
@@ -934,6 +934,16 @@ xlog_recover_buf_commit_pass2(
 	if (lsn && lsn != -1 && XFS_LSN_CMP(lsn, current_lsn) >= 0) {
 		trace_xfs_log_recover_buf_skip(log, buf_f);
 		xlog_recover_validate_buf_type(mp, bp, buf_f, NULLCOMMITLSN);
+
+		/*
+		 * We're skipping replay of this buffer log item due to the log
+		 * item LSN being behind the ondisk buffer.  Verify the buffer
+		 * contents since we aren't going to run the write verifier.
+		 */
+		if (bp->b_ops) {
+			bp->b_ops->verify_read(bp);
+			error = bp->b_error;
+		}
 		goto out_release;
 	}
 
diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 5b6c38f74807..823f5ed4ec0c 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -737,8 +737,11 @@ static inline void rps_record_sock_flow(struct rps_sock_flow_table *table,
 		/* We only give a hint, preemption can change CPU under us */
 		val |= raw_smp_processor_id();
 
-		if (table->ents[index] != val)
-			table->ents[index] = val;
+		/* The following WRITE_ONCE() is paired with the READ_ONCE()
+		 * here, and another one in get_rps_cpu().
+		 */
+		if (READ_ONCE(table->ents[index]) != val)
+			WRITE_ONCE(table->ents[index], val);
 	}
 }
 
diff --git a/include/linux/usb/hcd.h b/include/linux/usb/hcd.h
index 98d1921f02b1..e4e18a5faa9f 100644
--- a/include/linux/usb/hcd.h
+++ b/include/linux/usb/hcd.h
@@ -515,6 +515,11 @@ void *hcd_buffer_alloc(struct usb_bus *bus, size_t size,
 void hcd_buffer_free(struct usb_bus *bus, size_t size,
 	void *addr, dma_addr_t dma);
 
+void *hcd_buffer_alloc_pages(struct usb_hcd *hcd,
+		size_t size, gfp_t mem_flags, dma_addr_t *dma);
+void hcd_buffer_free_pages(struct usb_hcd *hcd,
+		size_t size, void *addr, dma_addr_t dma);
+
 /* generic bus glue, needed for host controllers that don't use PCI */
 extern irqreturn_t usb_hcd_irq(int irq, void *__hcd);
 
diff --git a/include/net/bond_alb.h b/include/net/bond_alb.h
index 191c36afa1f4..9dc082b2d543 100644
--- a/include/net/bond_alb.h
+++ b/include/net/bond_alb.h
@@ -156,8 +156,8 @@ int bond_alb_init_slave(struct bonding *bond, struct slave *slave);
 void bond_alb_deinit_slave(struct bonding *bond, struct slave *slave);
 void bond_alb_handle_link_change(struct bonding *bond, struct slave *slave, char link);
 void bond_alb_handle_active_change(struct bonding *bond, struct slave *new_slave);
-int bond_alb_xmit(struct sk_buff *skb, struct net_device *bond_dev);
-int bond_tlb_xmit(struct sk_buff *skb, struct net_device *bond_dev);
+netdev_tx_t bond_alb_xmit(struct sk_buff *skb, struct net_device *bond_dev);
+netdev_tx_t bond_tlb_xmit(struct sk_buff *skb, struct net_device *bond_dev);
 struct slave *bond_xmit_alb_slave_get(struct bonding *bond,
 				      struct sk_buff *skb);
 struct slave *bond_xmit_tlb_slave_get(struct bonding *bond,
diff --git a/include/net/neighbour.h b/include/net/neighbour.h
index d5767e25509c..abb22cfd4827 100644
--- a/include/net/neighbour.h
+++ b/include/net/neighbour.h
@@ -174,7 +174,7 @@ struct pneigh_entry {
 	struct net_device	*dev;
 	u8			flags;
 	u8			protocol;
-	u8			key[];
+	u32			key[];
 };
 
 /*
diff --git a/include/net/netns/ipv6.h b/include/net/netns/ipv6.h
index ff82983b7ab4..181b44f6fb68 100644
--- a/include/net/netns/ipv6.h
+++ b/include/net/netns/ipv6.h
@@ -53,7 +53,7 @@ struct netns_sysctl_ipv6 {
 	int seg6_flowlabel;
 	u32 ioam6_id;
 	u64 ioam6_id_wide;
-	bool skip_notify_on_dev_down;
+	int skip_notify_on_dev_down;
 	u8 fib_notify_on_flag_change;
 };
 
diff --git a/include/net/pkt_sched.h b/include/net/pkt_sched.h
index 9e7b21c0b3a6..9cd2d4e84913 100644
--- a/include/net/pkt_sched.h
+++ b/include/net/pkt_sched.h
@@ -134,6 +134,8 @@ static inline void qdisc_run(struct Qdisc *q)
 	}
 }
 
+extern const struct nla_policy rtm_tca_policy[TCA_MAX + 1];
+
 /* Calculate maximal size of packet seen by hard_start_xmit
    routine of this device.
  */
diff --git a/include/net/rpl.h b/include/net/rpl.h
index 308ef0a05cae..30fe780d1e7c 100644
--- a/include/net/rpl.h
+++ b/include/net/rpl.h
@@ -23,9 +23,6 @@ static inline int rpl_init(void)
 static inline void rpl_exit(void) {}
 #endif
 
-/* Worst decompression memory usage ipv6 address (16) + pad 7 */
-#define IPV6_RPL_SRH_WORST_SWAP_SIZE (sizeof(struct in6_addr) + 7)
-
 size_t ipv6_rpl_srh_size(unsigned char n, unsigned char cmpri,
 			 unsigned char cmpre);
 
diff --git a/include/net/sock.h b/include/net/sock.h
index 104d80d850e4..0eb6a4d07a4d 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -1093,8 +1093,12 @@ static inline void sock_rps_record_flow(const struct sock *sk)
 		 * OR	an additional socket flag
 		 * [1] : sk_state and sk_prot are in the same cache line.
 		 */
-		if (sk->sk_state == TCP_ESTABLISHED)
-			sock_rps_record_flow_hash(sk->sk_rxhash);
+		if (sk->sk_state == TCP_ESTABLISHED) {
+			/* This READ_ONCE() is paired with the WRITE_ONCE()
+			 * from sock_rps_save_rxhash() and sock_rps_reset_rxhash().
+			 */
+			sock_rps_record_flow_hash(READ_ONCE(sk->sk_rxhash));
+		}
 	}
 #endif
 }
@@ -1103,15 +1107,19 @@ static inline void sock_rps_save_rxhash(struct sock *sk,
 					const struct sk_buff *skb)
 {
 #ifdef CONFIG_RPS
-	if (unlikely(sk->sk_rxhash != skb->hash))
-		sk->sk_rxhash = skb->hash;
+	/* The following WRITE_ONCE() is paired with the READ_ONCE()
+	 * here, and another one in sock_rps_record_flow().
+	 */
+	if (unlikely(READ_ONCE(sk->sk_rxhash) != skb->hash))
+		WRITE_ONCE(sk->sk_rxhash, skb->hash);
 #endif
 }
 
 static inline void sock_rps_reset_rxhash(struct sock *sk)
 {
 #ifdef CONFIG_RPS
-	sk->sk_rxhash = 0;
+	/* Paired with READ_ONCE() in sock_rps_record_flow() */
+	WRITE_ONCE(sk->sk_rxhash, 0);
 #endif
 }
 
diff --git a/kernel/fork.c b/kernel/fork.c
index 68eab6ce3085..1906230a000e 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -470,6 +470,7 @@ void free_task(struct task_struct *tsk)
 	arch_release_task_struct(tsk);
 	if (tsk->flags & PF_KTHREAD)
 		free_kthread_struct(tsk);
+	bpf_task_storage_free(tsk);
 	free_task_struct(tsk);
 }
 EXPORT_SYMBOL(free_task);
@@ -753,7 +754,6 @@ void __put_task_struct(struct task_struct *tsk)
 	cgroup_free(tsk);
 	task_numa_free(tsk, true);
 	security_task_free(tsk);
-	bpf_task_storage_free(tsk);
 	exit_creds(tsk);
 	delayacct_tsk_free(tsk);
 	put_signal_struct(tsk->signal);
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index b314e71a008c..8b3531172d8e 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -849,13 +849,23 @@ static const struct bpf_func_proto bpf_send_signal_thread_proto = {
 
 BPF_CALL_3(bpf_d_path, struct path *, path, char *, buf, u32, sz)
 {
+	struct path copy;
 	long len;
 	char *p;
 
 	if (!sz)
 		return 0;
 
-	p = d_path(path, buf, sz);
+	/*
+	 * The path pointer is verified as trusted and safe to use,
+	 * but let's double check it's valid anyway to workaround
+	 * potentially broken verifier.
+	 */
+	len = copy_from_kernel_nofault(&copy, path, sizeof(*path));
+	if (len < 0)
+		return len;
+
+	p = d_path(&copy, buf, sz);
 	if (IS_ERR(p)) {
 		len = PTR_ERR(p);
 	} else {
diff --git a/lib/cpu_rmap.c b/lib/cpu_rmap.c
index e77f12bb3c77..1833ad73de6f 100644
--- a/lib/cpu_rmap.c
+++ b/lib/cpu_rmap.c
@@ -268,8 +268,8 @@ static void irq_cpu_rmap_release(struct kref *ref)
 	struct irq_glue *glue =
 		container_of(ref, struct irq_glue, notify.kref);
 
-	cpu_rmap_put(glue->rmap);
 	glue->rmap->obj[glue->index] = NULL;
+	cpu_rmap_put(glue->rmap);
 	kfree(glue);
 }
 
diff --git a/lib/debugobjects.c b/lib/debugobjects.c
index 4c39678c03ee..579406c1e9ed 100644
--- a/lib/debugobjects.c
+++ b/lib/debugobjects.c
@@ -590,16 +590,6 @@ static struct debug_obj *lookup_object_or_alloc(void *addr, struct debug_bucket
 	return NULL;
 }
 
-static void debug_objects_fill_pool(void)
-{
-	/*
-	 * On RT enabled kernels the pool refill must happen in preemptible
-	 * context:
-	 */
-	if (!IS_ENABLED(CONFIG_PREEMPT_RT) || preemptible())
-		fill_pool();
-}
-
 static void
 __debug_object_init(void *addr, const struct debug_obj_descr *descr, int onstack)
 {
@@ -608,7 +598,12 @@ __debug_object_init(void *addr, const struct debug_obj_descr *descr, int onstack
 	struct debug_obj *obj;
 	unsigned long flags;
 
-	debug_objects_fill_pool();
+	/*
+	 * On RT enabled kernels the pool refill must happen in preemptible
+	 * context:
+	 */
+	if (!IS_ENABLED(CONFIG_PREEMPT_RT) || preemptible())
+		fill_pool();
 
 	db = get_bucket((unsigned long) addr);
 
@@ -693,8 +688,6 @@ int debug_object_activate(void *addr, const struct debug_obj_descr *descr)
 	if (!debug_objects_enabled)
 		return 0;
 
-	debug_objects_fill_pool();
-
 	db = get_bucket((unsigned long) addr);
 
 	raw_spin_lock_irqsave(&db->lock, flags);
@@ -904,8 +897,6 @@ void debug_object_assert_init(void *addr, const struct debug_obj_descr *descr)
 	if (!debug_objects_enabled)
 		return;
 
-	debug_objects_fill_pool();
-
 	db = get_bucket((unsigned long) addr);
 
 	raw_spin_lock_irqsave(&db->lock, flags);
diff --git a/net/batman-adv/distributed-arp-table.c b/net/batman-adv/distributed-arp-table.c
index 2f008e329007..42dcdf5fd76a 100644
--- a/net/batman-adv/distributed-arp-table.c
+++ b/net/batman-adv/distributed-arp-table.c
@@ -101,7 +101,6 @@ static void batadv_dat_purge(struct work_struct *work);
  */
 static void batadv_dat_start_timer(struct batadv_priv *bat_priv)
 {
-	INIT_DELAYED_WORK(&bat_priv->dat.work, batadv_dat_purge);
 	queue_delayed_work(batadv_event_workqueue, &bat_priv->dat.work,
 			   msecs_to_jiffies(10000));
 }
@@ -819,6 +818,7 @@ int batadv_dat_init(struct batadv_priv *bat_priv)
 	if (!bat_priv->dat.hash)
 		return -ENOMEM;
 
+	INIT_DELAYED_WORK(&bat_priv->dat.work, batadv_dat_purge);
 	batadv_dat_start_timer(bat_priv);
 
 	batadv_tvlv_handler_register(bat_priv, batadv_dat_tvlv_ogm_handler_v1,
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index cabe8eb4c14f..682a09e7fea6 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -2697,10 +2697,10 @@ int hci_remove_link_key(struct hci_dev *hdev, bdaddr_t *bdaddr)
 
 int hci_remove_ltk(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 bdaddr_type)
 {
-	struct smp_ltk *k;
+	struct smp_ltk *k, *tmp;
 	int removed = 0;
 
-	list_for_each_entry_rcu(k, &hdev->long_term_keys, list) {
+	list_for_each_entry_safe(k, tmp, &hdev->long_term_keys, list) {
 		if (bacmp(bdaddr, &k->bdaddr) || k->bdaddr_type != bdaddr_type)
 			continue;
 
@@ -2716,9 +2716,9 @@ int hci_remove_ltk(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 bdaddr_type)
 
 void hci_remove_irk(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 addr_type)
 {
-	struct smp_irk *k;
+	struct smp_irk *k, *tmp;
 
-	list_for_each_entry_rcu(k, &hdev->identity_resolving_keys, list) {
+	list_for_each_entry_safe(k, tmp, &hdev->identity_resolving_keys, list) {
 		if (bacmp(bdaddr, &k->bdaddr) || k->addr_type != addr_type)
 			continue;
 
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index f01b77b03787..9dd54247029a 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -4307,6 +4307,10 @@ static int l2cap_connect_create_rsp(struct l2cap_conn *conn,
 	result = __le16_to_cpu(rsp->result);
 	status = __le16_to_cpu(rsp->status);
 
+	if (result == L2CAP_CR_SUCCESS && (dcid < L2CAP_CID_DYN_START ||
+					   dcid > L2CAP_CID_DYN_END))
+		return -EPROTO;
+
 	BT_DBG("dcid 0x%4.4x scid 0x%4.4x result 0x%2.2x status 0x%2.2x",
 	       dcid, scid, result, status);
 
@@ -4338,6 +4342,11 @@ static int l2cap_connect_create_rsp(struct l2cap_conn *conn,
 
 	switch (result) {
 	case L2CAP_CR_SUCCESS:
+		if (__l2cap_get_chan_by_dcid(conn, dcid)) {
+			err = -EBADSLT;
+			break;
+		}
+
 		l2cap_state_change(chan, BT_CONFIG);
 		chan->ident = 0;
 		chan->dcid = dcid;
@@ -4664,7 +4673,9 @@ static inline int l2cap_disconnect_req(struct l2cap_conn *conn,
 
 	chan->ops->set_shutdown(chan);
 
+	l2cap_chan_unlock(chan);
 	mutex_lock(&conn->chan_lock);
+	l2cap_chan_lock(chan);
 	l2cap_chan_del(chan, ECONNRESET);
 	mutex_unlock(&conn->chan_lock);
 
@@ -4703,7 +4714,9 @@ static inline int l2cap_disconnect_rsp(struct l2cap_conn *conn,
 		return 0;
 	}
 
+	l2cap_chan_unlock(chan);
 	mutex_lock(&conn->chan_lock);
+	l2cap_chan_lock(chan);
 	l2cap_chan_del(chan, 0);
 	mutex_unlock(&conn->chan_lock);
 
diff --git a/net/can/j1939/main.c b/net/can/j1939/main.c
index 82671a882716..e82b91509258 100644
--- a/net/can/j1939/main.c
+++ b/net/can/j1939/main.c
@@ -122,7 +122,7 @@ static void j1939_can_recv(struct sk_buff *iskb, void *data)
 #define J1939_CAN_ID CAN_EFF_FLAG
 #define J1939_CAN_MASK (CAN_EFF_FLAG | CAN_RTR_FLAG)
 
-static DEFINE_SPINLOCK(j1939_netdev_lock);
+static DEFINE_MUTEX(j1939_netdev_lock);
 
 static struct j1939_priv *j1939_priv_create(struct net_device *ndev)
 {
@@ -216,7 +216,7 @@ static void __j1939_rx_release(struct kref *kref)
 	j1939_can_rx_unregister(priv);
 	j1939_ecu_unmap_all(priv);
 	j1939_priv_set(priv->ndev, NULL);
-	spin_unlock(&j1939_netdev_lock);
+	mutex_unlock(&j1939_netdev_lock);
 }
 
 /* get pointer to priv without increasing ref counter */
@@ -244,9 +244,9 @@ static struct j1939_priv *j1939_priv_get_by_ndev(struct net_device *ndev)
 {
 	struct j1939_priv *priv;
 
-	spin_lock(&j1939_netdev_lock);
+	mutex_lock(&j1939_netdev_lock);
 	priv = j1939_priv_get_by_ndev_locked(ndev);
-	spin_unlock(&j1939_netdev_lock);
+	mutex_unlock(&j1939_netdev_lock);
 
 	return priv;
 }
@@ -256,14 +256,14 @@ struct j1939_priv *j1939_netdev_start(struct net_device *ndev)
 	struct j1939_priv *priv, *priv_new;
 	int ret;
 
-	spin_lock(&j1939_netdev_lock);
+	mutex_lock(&j1939_netdev_lock);
 	priv = j1939_priv_get_by_ndev_locked(ndev);
 	if (priv) {
 		kref_get(&priv->rx_kref);
-		spin_unlock(&j1939_netdev_lock);
+		mutex_unlock(&j1939_netdev_lock);
 		return priv;
 	}
-	spin_unlock(&j1939_netdev_lock);
+	mutex_unlock(&j1939_netdev_lock);
 
 	priv = j1939_priv_create(ndev);
 	if (!priv)
@@ -273,29 +273,31 @@ struct j1939_priv *j1939_netdev_start(struct net_device *ndev)
 	spin_lock_init(&priv->j1939_socks_lock);
 	INIT_LIST_HEAD(&priv->j1939_socks);
 
-	spin_lock(&j1939_netdev_lock);
+	mutex_lock(&j1939_netdev_lock);
 	priv_new = j1939_priv_get_by_ndev_locked(ndev);
 	if (priv_new) {
 		/* Someone was faster than us, use their priv and roll
 		 * back our's.
 		 */
 		kref_get(&priv_new->rx_kref);
-		spin_unlock(&j1939_netdev_lock);
+		mutex_unlock(&j1939_netdev_lock);
 		dev_put(ndev);
 		kfree(priv);
 		return priv_new;
 	}
 	j1939_priv_set(ndev, priv);
-	spin_unlock(&j1939_netdev_lock);
 
 	ret = j1939_can_rx_register(priv);
 	if (ret < 0)
 		goto out_priv_put;
 
+	mutex_unlock(&j1939_netdev_lock);
 	return priv;
 
  out_priv_put:
 	j1939_priv_set(ndev, NULL);
+	mutex_unlock(&j1939_netdev_lock);
+
 	dev_put(ndev);
 	kfree(priv);
 
@@ -304,7 +306,7 @@ struct j1939_priv *j1939_netdev_start(struct net_device *ndev)
 
 void j1939_netdev_stop(struct j1939_priv *priv)
 {
-	kref_put_lock(&priv->rx_kref, __j1939_rx_release, &j1939_netdev_lock);
+	kref_put_mutex(&priv->rx_kref, __j1939_rx_release, &j1939_netdev_lock);
 	j1939_priv_put(priv);
 }
 
diff --git a/net/can/j1939/socket.c b/net/can/j1939/socket.c
index d1d4bdc1de46..dfce84f2349f 100644
--- a/net/can/j1939/socket.c
+++ b/net/can/j1939/socket.c
@@ -1088,6 +1088,11 @@ void j1939_sk_errqueue(struct j1939_session *session,
 
 void j1939_sk_send_loop_abort(struct sock *sk, int err)
 {
+	struct j1939_sock *jsk = j1939_sk(sk);
+
+	if (jsk->state & J1939_SOCK_ERRQUEUE)
+		return;
+
 	sk->sk_err = err;
 
 	sk_error_report(sk);
diff --git a/net/core/dev.c b/net/core/dev.c
index 56a3bff7249d..24d711fe376a 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -4458,8 +4458,10 @@ static int get_rps_cpu(struct net_device *dev, struct sk_buff *skb,
 		u32 next_cpu;
 		u32 ident;
 
-		/* First check into global flow table if there is a match */
-		ident = sock_flow_table->ents[hash & sock_flow_table->mask];
+		/* First check into global flow table if there is a match.
+		 * This READ_ONCE() pairs with WRITE_ONCE() from rps_record_sock_flow().
+		 */
+		ident = READ_ONCE(sock_flow_table->ents[hash & sock_flow_table->mask]);
 		if ((ident ^ hash) & ~rps_cpu_mask)
 			goto try_rps;
 
diff --git a/net/ipv6/exthdrs.c b/net/ipv6/exthdrs.c
index 3a871a09f962..d273f6fe19c2 100644
--- a/net/ipv6/exthdrs.c
+++ b/net/ipv6/exthdrs.c
@@ -564,24 +564,6 @@ static int ipv6_rpl_srh_rcv(struct sk_buff *skb)
 		return -1;
 	}
 
-	if (skb_cloned(skb)) {
-		if (pskb_expand_head(skb, IPV6_RPL_SRH_WORST_SWAP_SIZE, 0,
-				     GFP_ATOMIC)) {
-			__IP6_INC_STATS(net, ip6_dst_idev(skb_dst(skb)),
-					IPSTATS_MIB_OUTDISCARDS);
-			kfree_skb(skb);
-			return -1;
-		}
-	} else {
-		err = skb_cow_head(skb, IPV6_RPL_SRH_WORST_SWAP_SIZE);
-		if (unlikely(err)) {
-			kfree_skb(skb);
-			return -1;
-		}
-	}
-
-	hdr = (struct ipv6_rpl_sr_hdr *)skb_transport_header(skb);
-
 	if (!pskb_may_pull(skb, ipv6_rpl_srh_size(n, hdr->cmpri,
 						  hdr->cmpre))) {
 		kfree_skb(skb);
@@ -627,6 +609,17 @@ static int ipv6_rpl_srh_rcv(struct sk_buff *skb)
 	skb_pull(skb, ((hdr->hdrlen + 1) << 3));
 	skb_postpull_rcsum(skb, oldhdr,
 			   sizeof(struct ipv6hdr) + ((hdr->hdrlen + 1) << 3));
+	if (unlikely(!hdr->segments_left)) {
+		if (pskb_expand_head(skb, sizeof(struct ipv6hdr) + ((chdr->hdrlen + 1) << 3), 0,
+				     GFP_ATOMIC)) {
+			__IP6_INC_STATS(net, ip6_dst_idev(skb_dst(skb)), IPSTATS_MIB_OUTDISCARDS);
+			kfree_skb(skb);
+			kfree(buf);
+			return -1;
+		}
+
+		oldhdr = ipv6_hdr(skb);
+	}
 	skb_push(skb, ((chdr->hdrlen + 1) << 3) + sizeof(struct ipv6hdr));
 	skb_reset_network_header(skb);
 	skb_mac_header_rebuild(skb);
diff --git a/net/netfilter/ipset/ip_set_core.c b/net/netfilter/ipset/ip_set_core.c
index ae061b27e446..c911fc09f363 100644
--- a/net/netfilter/ipset/ip_set_core.c
+++ b/net/netfilter/ipset/ip_set_core.c
@@ -1694,6 +1694,14 @@ call_ad(struct net *net, struct sock *ctnl, struct sk_buff *skb,
 	bool eexist = flags & IPSET_FLAG_EXIST, retried = false;
 
 	do {
+		if (retried) {
+			__ip_set_get(set);
+			nfnl_unlock(NFNL_SUBSYS_IPSET);
+			cond_resched();
+			nfnl_lock(NFNL_SUBSYS_IPSET);
+			__ip_set_put(set);
+		}
+
 		ip_set_lock(set);
 		ret = set->variant->uadt(set, tb, adt, &lineno, flags, retried);
 		ip_set_unlock(set);
diff --git a/net/netfilter/nf_conntrack_core.c b/net/netfilter/nf_conntrack_core.c
index 7ff0da5f998a..10622760f894 100644
--- a/net/netfilter/nf_conntrack_core.c
+++ b/net/netfilter/nf_conntrack_core.c
@@ -2224,6 +2224,9 @@ static int nf_confirm_cthelper(struct sk_buff *skb, struct nf_conn *ct,
 		return 0;
 
 	helper = rcu_dereference(help->helper);
+	if (!helper)
+		return 0;
+
 	if (!(helper->flags & NF_CT_HELPER_F_USERSPACE))
 		return 0;
 
diff --git a/net/sched/act_police.c b/net/sched/act_police.c
index d44b933b821d..db1d021c16be 100644
--- a/net/sched/act_police.c
+++ b/net/sched/act_police.c
@@ -366,23 +366,23 @@ static int tcf_police_dump(struct sk_buff *skb, struct tc_action *a,
 	opt.burst = PSCHED_NS2TICKS(p->tcfp_burst);
 	if (p->rate_present) {
 		psched_ratecfg_getrate(&opt.rate, &p->rate);
-		if ((police->params->rate.rate_bytes_ps >= (1ULL << 32)) &&
+		if ((p->rate.rate_bytes_ps >= (1ULL << 32)) &&
 		    nla_put_u64_64bit(skb, TCA_POLICE_RATE64,
-				      police->params->rate.rate_bytes_ps,
+				      p->rate.rate_bytes_ps,
 				      TCA_POLICE_PAD))
 			goto nla_put_failure;
 	}
 	if (p->peak_present) {
 		psched_ratecfg_getrate(&opt.peakrate, &p->peak);
-		if ((police->params->peak.rate_bytes_ps >= (1ULL << 32)) &&
+		if ((p->peak.rate_bytes_ps >= (1ULL << 32)) &&
 		    nla_put_u64_64bit(skb, TCA_POLICE_PEAKRATE64,
-				      police->params->peak.rate_bytes_ps,
+				      p->peak.rate_bytes_ps,
 				      TCA_POLICE_PAD))
 			goto nla_put_failure;
 	}
 	if (p->pps_present) {
 		if (nla_put_u64_64bit(skb, TCA_POLICE_PKTRATE64,
-				      police->params->ppsrate.rate_pkts_ps,
+				      p->ppsrate.rate_pkts_ps,
 				      TCA_POLICE_PAD))
 			goto nla_put_failure;
 		if (nla_put_u64_64bit(skb, TCA_POLICE_PKTBURST64,
diff --git a/net/sched/cls_api.c b/net/sched/cls_api.c
index 501e05943f02..d88a0946301c 100644
--- a/net/sched/cls_api.c
+++ b/net/sched/cls_api.c
@@ -41,8 +41,6 @@
 #include <net/tc_act/tc_gate.h>
 #include <net/flow_offload.h>
 
-extern const struct nla_policy rtm_tca_policy[TCA_MAX + 1];
-
 /* The list of all installed classifier types */
 static LIST_HEAD(tcf_proto_base);
 
@@ -2768,6 +2766,7 @@ static int tc_chain_tmplt_add(struct tcf_chain *chain, struct net *net,
 		return PTR_ERR(ops);
 	if (!ops->tmplt_create || !ops->tmplt_destroy || !ops->tmplt_dump) {
 		NL_SET_ERR_MSG(extack, "Chain templates are not supported with specified classifier");
+		module_put(ops->owner);
 		return -EOPNOTSUPP;
 	}
 
diff --git a/net/sched/sch_fq_pie.c b/net/sched/sch_fq_pie.c
index 35c35465226b..ce7833f95214 100644
--- a/net/sched/sch_fq_pie.c
+++ b/net/sched/sch_fq_pie.c
@@ -201,6 +201,11 @@ static int fq_pie_qdisc_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 	return NET_XMIT_CN;
 }
 
+static struct netlink_range_validation fq_pie_q_range = {
+	.min = 1,
+	.max = 1 << 20,
+};
+
 static const struct nla_policy fq_pie_policy[TCA_FQ_PIE_MAX + 1] = {
 	[TCA_FQ_PIE_LIMIT]		= {.type = NLA_U32},
 	[TCA_FQ_PIE_FLOWS]		= {.type = NLA_U32},
@@ -208,7 +213,8 @@ static const struct nla_policy fq_pie_policy[TCA_FQ_PIE_MAX + 1] = {
 	[TCA_FQ_PIE_TUPDATE]		= {.type = NLA_U32},
 	[TCA_FQ_PIE_ALPHA]		= {.type = NLA_U32},
 	[TCA_FQ_PIE_BETA]		= {.type = NLA_U32},
-	[TCA_FQ_PIE_QUANTUM]		= {.type = NLA_U32},
+	[TCA_FQ_PIE_QUANTUM]		=
+			NLA_POLICY_FULL_RANGE(NLA_U32, &fq_pie_q_range),
 	[TCA_FQ_PIE_MEMORY_LIMIT]	= {.type = NLA_U32},
 	[TCA_FQ_PIE_ECN_PROB]		= {.type = NLA_U32},
 	[TCA_FQ_PIE_ECN]		= {.type = NLA_U32},
diff --git a/net/smc/smc_llc.c b/net/smc/smc_llc.c
index 0ef15f8fba90..d5ee961ca72d 100644
--- a/net/smc/smc_llc.c
+++ b/net/smc/smc_llc.c
@@ -716,6 +716,8 @@ static int smc_llc_add_link_cont(struct smc_link *link,
 	addc_llc->num_rkeys = *num_rkeys_todo;
 	n = *num_rkeys_todo;
 	for (i = 0; i < min_t(u8, n, SMC_LLC_RKEYS_PER_CONT_MSG); i++) {
+		while (*buf_pos && !(*buf_pos)->used)
+			*buf_pos = smc_llc_get_next_rmb(lgr, buf_lst, *buf_pos);
 		if (!*buf_pos) {
 			addc_llc->num_rkeys = addc_llc->num_rkeys -
 					      *num_rkeys_todo;
@@ -731,8 +733,6 @@ static int smc_llc_add_link_cont(struct smc_link *link,
 
 		(*num_rkeys_todo)--;
 		*buf_pos = smc_llc_get_next_rmb(lgr, buf_lst, *buf_pos);
-		while (*buf_pos && !(*buf_pos)->used)
-			*buf_pos = smc_llc_get_next_rmb(lgr, buf_lst, *buf_pos);
 	}
 	addc_llc->hd.common.type = SMC_LLC_ADD_LINK_CONT;
 	addc_llc->hd.length = sizeof(struct smc_llc_msg_add_link_cont);
diff --git a/net/wireless/core.c b/net/wireless/core.c
index 441136646f89..d10686f4bf15 100644
--- a/net/wireless/core.c
+++ b/net/wireless/core.c
@@ -368,12 +368,12 @@ static void cfg80211_sched_scan_stop_wk(struct work_struct *work)
 	rdev = container_of(work, struct cfg80211_registered_device,
 			   sched_scan_stop_wk);
 
-	rtnl_lock();
+	wiphy_lock(&rdev->wiphy);
 	list_for_each_entry_safe(req, tmp, &rdev->sched_scan_req_list, list) {
 		if (req->nl_owner_dead)
 			cfg80211_stop_sched_scan_req(rdev, req, false);
 	}
-	rtnl_unlock();
+	wiphy_unlock(&rdev->wiphy);
 }
 
 static void cfg80211_propagate_radar_detect_wk(struct work_struct *work)
diff --git a/scripts/gcc-plugins/gcc-common.h b/scripts/gcc-plugins/gcc-common.h
index 0c087614fc3e..3f3c37bc14e8 100644
--- a/scripts/gcc-plugins/gcc-common.h
+++ b/scripts/gcc-plugins/gcc-common.h
@@ -77,7 +77,9 @@
 #include "varasm.h"
 #include "stor-layout.h"
 #include "internal-fn.h"
+#include "gimple.h"
 #include "gimple-expr.h"
+#include "gimple-iterator.h"
 #include "gimple-fold.h"
 #include "context.h"
 #include "tree-ssa-alias.h"
@@ -91,11 +93,9 @@
 #include "tree-eh.h"
 #include "stmt.h"
 #include "gimplify.h"
-#include "gimple.h"
 #include "tree-ssa-operands.h"
 #include "tree-phinodes.h"
 #include "tree-cfg.h"
-#include "gimple-iterator.h"
 #include "gimple-ssa.h"
 #include "ssa-iterators.h"
 
diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 4ef66ebe4cac..abe7f1de0933 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -9205,6 +9205,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x1558, 0x5101, "Clevo S510WU", ALC293_FIXUP_SYSTEM76_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1558, 0x5157, "Clevo W517GU1", ALC293_FIXUP_SYSTEM76_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1558, 0x51a1, "Clevo NS50MU", ALC293_FIXUP_SYSTEM76_MIC_NO_PRESENCE),
+	SND_PCI_QUIRK(0x1558, 0x51b1, "Clevo NS50AU", ALC256_FIXUP_SYSTEM76_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1558, 0x5630, "Clevo NP50RNJS", ALC256_FIXUP_SYSTEM76_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1558, 0x70a1, "Clevo NB70T[HJK]", ALC293_FIXUP_SYSTEM76_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1558, 0x70b3, "Clevo NK70SB", ALC293_FIXUP_SYSTEM76_MIC_NO_PRESENCE),
@@ -11249,6 +11250,7 @@ static const struct snd_pci_quirk alc662_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x103c, 0x8719, "HP", ALC897_FIXUP_HP_HSMIC_VERB),
 	SND_PCI_QUIRK(0x103c, 0x872b, "HP", ALC897_FIXUP_HP_HSMIC_VERB),
 	SND_PCI_QUIRK(0x103c, 0x873e, "HP", ALC671_FIXUP_HP_HEADSET_MIC2),
+	SND_PCI_QUIRK(0x103c, 0x8768, "HP Slim Desktop S01", ALC671_FIXUP_HP_HEADSET_MIC2),
 	SND_PCI_QUIRK(0x103c, 0x877e, "HP 288 Pro G6", ALC671_FIXUP_HP_HEADSET_MIC2),
 	SND_PCI_QUIRK(0x103c, 0x885f, "HP 288 Pro G8", ALC671_FIXUP_HP_HEADSET_MIC2),
 	SND_PCI_QUIRK(0x1043, 0x1080, "Asus UX501VW", ALC668_FIXUP_HEADSET_MODE),
@@ -11270,6 +11272,7 @@ static const struct snd_pci_quirk alc662_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x14cd, 0x5003, "USI", ALC662_FIXUP_USI_HEADSET_MODE),
 	SND_PCI_QUIRK(0x17aa, 0x1036, "Lenovo P520", ALC662_FIXUP_LENOVO_MULTI_CODECS),
 	SND_PCI_QUIRK(0x17aa, 0x1057, "Lenovo P360", ALC897_FIXUP_HEADSET_MIC_PIN),
+	SND_PCI_QUIRK(0x17aa, 0x1064, "Lenovo P3 Tower", ALC897_FIXUP_HEADSET_MIC_PIN),
 	SND_PCI_QUIRK(0x17aa, 0x32ca, "Lenovo ThinkCentre M80", ALC897_FIXUP_HEADSET_MIC_PIN),
 	SND_PCI_QUIRK(0x17aa, 0x32cb, "Lenovo ThinkCentre M70", ALC897_FIXUP_HEADSET_MIC_PIN),
 	SND_PCI_QUIRK(0x17aa, 0x32cf, "Lenovo ThinkCentre M950", ALC897_FIXUP_HEADSET_MIC_PIN),
diff --git a/sound/soc/codecs/wsa881x.c b/sound/soc/codecs/wsa881x.c
index 0222370ff95d..855904769487 100644
--- a/sound/soc/codecs/wsa881x.c
+++ b/sound/soc/codecs/wsa881x.c
@@ -646,7 +646,6 @@ static struct regmap_config wsa881x_regmap_config = {
 	.readable_reg = wsa881x_readable_register,
 	.reg_format_endian = REGMAP_ENDIAN_NATIVE,
 	.val_format_endian = REGMAP_ENDIAN_NATIVE,
-	.can_multi_write = true,
 };
 
 enum {
diff --git a/sound/soc/mediatek/mt8195/mt8195-afe-clk.c b/sound/soc/mediatek/mt8195/mt8195-afe-clk.c
index 8420b2c71332..d1939e08d333 100644
--- a/sound/soc/mediatek/mt8195/mt8195-afe-clk.c
+++ b/sound/soc/mediatek/mt8195/mt8195-afe-clk.c
@@ -136,11 +136,6 @@ int mt8195_afe_init_clock(struct mtk_base_afe *afe)
 	return 0;
 }
 
-void mt8195_afe_deinit_clock(struct mtk_base_afe *afe)
-{
-	mt8195_audsys_clk_unregister(afe);
-}
-
 int mt8195_afe_enable_clk(struct mtk_base_afe *afe, struct clk *clk)
 {
 	int ret;
diff --git a/sound/soc/mediatek/mt8195/mt8195-afe-clk.h b/sound/soc/mediatek/mt8195/mt8195-afe-clk.h
index f8e6eeb29a89..24eb2f06682f 100644
--- a/sound/soc/mediatek/mt8195/mt8195-afe-clk.h
+++ b/sound/soc/mediatek/mt8195/mt8195-afe-clk.h
@@ -90,7 +90,6 @@ int mt8195_afe_get_mclk_source_clk_id(int sel);
 int mt8195_afe_get_mclk_source_rate(struct mtk_base_afe *afe, int apll);
 int mt8195_afe_get_default_mclk_source_by_rate(int rate);
 int mt8195_afe_init_clock(struct mtk_base_afe *afe);
-void mt8195_afe_deinit_clock(struct mtk_base_afe *afe);
 int mt8195_afe_enable_clk(struct mtk_base_afe *afe, struct clk *clk);
 void mt8195_afe_disable_clk(struct mtk_base_afe *afe, struct clk *clk);
 int mt8195_afe_prepare_clk(struct mtk_base_afe *afe, struct clk *clk);
diff --git a/sound/soc/mediatek/mt8195/mt8195-afe-pcm.c b/sound/soc/mediatek/mt8195/mt8195-afe-pcm.c
index 2edb40fe27cc..4e817542dd74 100644
--- a/sound/soc/mediatek/mt8195/mt8195-afe-pcm.c
+++ b/sound/soc/mediatek/mt8195/mt8195-afe-pcm.c
@@ -3237,18 +3237,13 @@ static int mt8195_afe_pcm_dev_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int mt8195_afe_pcm_dev_remove(struct platform_device *pdev)
+static void mt8195_afe_pcm_dev_remove(struct platform_device *pdev)
 {
-	struct mtk_base_afe *afe = platform_get_drvdata(pdev);
-
 	snd_soc_unregister_component(&pdev->dev);
 
 	pm_runtime_disable(&pdev->dev);
 	if (!pm_runtime_status_suspended(&pdev->dev))
 		mt8195_afe_runtime_suspend(&pdev->dev);
-
-	mt8195_afe_deinit_clock(afe);
-	return 0;
 }
 
 static const struct of_device_id mt8195_afe_pcm_dt_match[] = {
@@ -3271,7 +3266,7 @@ static struct platform_driver mt8195_afe_pcm_driver = {
 #endif
 	},
 	.probe = mt8195_afe_pcm_dev_probe,
-	.remove = mt8195_afe_pcm_dev_remove,
+	.remove_new = mt8195_afe_pcm_dev_remove,
 };
 
 module_platform_driver(mt8195_afe_pcm_driver);
diff --git a/sound/soc/mediatek/mt8195/mt8195-audsys-clk.c b/sound/soc/mediatek/mt8195/mt8195-audsys-clk.c
index 740aa6ddda0e..353aa1732364 100644
--- a/sound/soc/mediatek/mt8195/mt8195-audsys-clk.c
+++ b/sound/soc/mediatek/mt8195/mt8195-audsys-clk.c
@@ -148,6 +148,29 @@ static const struct afe_gate aud_clks[CLK_AUD_NR_CLK] = {
 	GATE_AUD6(CLK_AUD_GASRC19, "aud_gasrc19", "asm_h_sel", 19),
 };
 
+static void mt8195_audsys_clk_unregister(void *data)
+{
+	struct mtk_base_afe *afe = data;
+	struct mt8195_afe_private *afe_priv = afe->platform_priv;
+	struct clk *clk;
+	struct clk_lookup *cl;
+	int i;
+
+	if (!afe_priv)
+		return;
+
+	for (i = 0; i < CLK_AUD_NR_CLK; i++) {
+		cl = afe_priv->lookup[i];
+		if (!cl)
+			continue;
+
+		clk = cl->clk;
+		clk_unregister_gate(clk);
+
+		clkdev_drop(cl);
+	}
+}
+
 int mt8195_audsys_clk_register(struct mtk_base_afe *afe)
 {
 	struct mt8195_afe_private *afe_priv = afe->platform_priv;
@@ -188,27 +211,5 @@ int mt8195_audsys_clk_register(struct mtk_base_afe *afe)
 		afe_priv->lookup[i] = cl;
 	}
 
-	return 0;
-}
-
-void mt8195_audsys_clk_unregister(struct mtk_base_afe *afe)
-{
-	struct mt8195_afe_private *afe_priv = afe->platform_priv;
-	struct clk *clk;
-	struct clk_lookup *cl;
-	int i;
-
-	if (!afe_priv)
-		return;
-
-	for (i = 0; i < CLK_AUD_NR_CLK; i++) {
-		cl = afe_priv->lookup[i];
-		if (!cl)
-			continue;
-
-		clk = cl->clk;
-		clk_unregister_gate(clk);
-
-		clkdev_drop(cl);
-	}
+	return devm_add_action_or_reset(afe->dev, mt8195_audsys_clk_unregister, afe);
 }
diff --git a/sound/soc/mediatek/mt8195/mt8195-audsys-clk.h b/sound/soc/mediatek/mt8195/mt8195-audsys-clk.h
index 239d31016ba7..69db2dd1c9e0 100644
--- a/sound/soc/mediatek/mt8195/mt8195-audsys-clk.h
+++ b/sound/soc/mediatek/mt8195/mt8195-audsys-clk.h
@@ -10,6 +10,5 @@
 #define _MT8195_AUDSYS_CLK_H_
 
 int mt8195_audsys_clk_register(struct mtk_base_afe *afe);
-void mt8195_audsys_clk_unregister(struct mtk_base_afe *afe);
 
 #endif
diff --git a/tools/testing/selftests/bpf/prog_tests/sockopt_sk.c b/tools/testing/selftests/bpf/prog_tests/sockopt_sk.c
index 4b937e5dbaca..f3cd8db26bf7 100644
--- a/tools/testing/selftests/bpf/prog_tests/sockopt_sk.c
+++ b/tools/testing/selftests/bpf/prog_tests/sockopt_sk.c
@@ -3,6 +3,7 @@
 #include "cgroup_helpers.h"
 
 #include <linux/tcp.h>
+#include <linux/netlink.h>
 #include "sockopt_sk.skel.h"
 
 #ifndef SOL_TCP
@@ -183,6 +184,33 @@ static int getsetsockopt(void)
 		goto err;
 	}
 
+	/* optval=NULL case is handled correctly */
+
+	close(fd);
+	fd = socket(AF_NETLINK, SOCK_RAW, 0);
+	if (fd < 0) {
+		log_err("Failed to create AF_NETLINK socket");
+		return -1;
+	}
+
+	buf.u32 = 1;
+	optlen = sizeof(__u32);
+	err = setsockopt(fd, SOL_NETLINK, NETLINK_ADD_MEMBERSHIP, &buf, optlen);
+	if (err) {
+		log_err("Unexpected getsockopt(NETLINK_ADD_MEMBERSHIP) err=%d errno=%d",
+			err, errno);
+		goto err;
+	}
+
+	optlen = 0;
+	err = getsockopt(fd, SOL_NETLINK, NETLINK_LIST_MEMBERSHIPS, NULL, &optlen);
+	if (err) {
+		log_err("Unexpected getsockopt(NETLINK_LIST_MEMBERSHIPS) err=%d errno=%d",
+			err, errno);
+		goto err;
+	}
+	ASSERT_EQ(optlen, 8, "Unexpected NETLINK_LIST_MEMBERSHIPS value");
+
 	free(big_buf);
 	close(fd);
 	return 0;
diff --git a/tools/testing/selftests/bpf/progs/sockopt_sk.c b/tools/testing/selftests/bpf/progs/sockopt_sk.c
index 79c8139b63b8..9cf72ae13202 100644
--- a/tools/testing/selftests/bpf/progs/sockopt_sk.c
+++ b/tools/testing/selftests/bpf/progs/sockopt_sk.c
@@ -32,6 +32,12 @@ int _getsockopt(struct bpf_sockopt *ctx)
 	__u8 *optval_end = ctx->optval_end;
 	__u8 *optval = ctx->optval;
 	struct sockopt_sk *storage;
+	struct bpf_sock *sk;
+
+	/* Bypass AF_NETLINK. */
+	sk = ctx->sk;
+	if (sk && sk->family == AF_NETLINK)
+		return 1;
 
 	/* Make sure bpf_get_netns_cookie is callable.
 	 */
@@ -130,6 +136,12 @@ int _setsockopt(struct bpf_sockopt *ctx)
 	__u8 *optval_end = ctx->optval_end;
 	__u8 *optval = ctx->optval;
 	struct sockopt_sk *storage;
+	struct bpf_sock *sk;
+
+	/* Bypass AF_NETLINK. */
+	sk = ctx->sk;
+	if (sk && sk->family == AF_NETLINK)
+		return 1;
 
 	/* Make sure bpf_get_netns_cookie is callable.
 	 */
