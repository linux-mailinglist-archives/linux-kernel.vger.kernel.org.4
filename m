Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DBE96E6646
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 15:47:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232314AbjDRNrZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 09:47:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231875AbjDRNrV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 09:47:21 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2070.outbound.protection.outlook.com [40.107.94.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01DB2B76E;
        Tue, 18 Apr 2023 06:47:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ak3SV86a0LxqzixCFYGbZedokMIpBWqWwwC/CN3DiAdBk7xy/NLuryW8Uai09NfeXKgDce4sjqbdcfL41oXVNb0PJ+3EMhu3l57mJ6UZ61OESckgc+qNu09J5NOizQ45ZQ/k1aJSuFB0xsacgoIjw1vu0hQSN9kmFuQzd1+RDvgB5Q1OrvR0eLblDew5HR5FeIQGSUhiP8AK6gHH/utpdoBrJXtfagnClLwKvV4RkXWZ3tTw7xCFjjZbHVENoI5G1LPG9Bqv2G8dD48Ltla3ricm5STD7vZ3ZyYoyp/QfZ8a4senMt2OXEB50yCWFz4Ece+/VUB09IVTrzo7BOY1qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n+2cTgDkNQRVqB0OYOjtImXZUJxePJMau94Bm1t7vxQ=;
 b=k6xE1Hz3twKFVloiZ1A9NC/PPp97kgwsLjct+0i+Lcyh3El5nSO3FoMYatRrn4nhP6Yr4ZABu5I7W/jzuO1zviD4JPiwwRoI7EszEENgzDYTe46D808oW6m9BB2yaNH92STFtBIpltamOjOMeRQMGMBEjvB4wrk6wZDLd8OZ7Eyd4OCvcn1rSxLo2X69k5A5MVmvHirn2dWOUoY67eDMu+Jcb7otN1FsvTbb1F+cQYXVuijfW6rN3WMWr4YPjRFxSm3Ymy9L7KtDE8TTrtzQMmEEW8x+8lGM/yAJgx8Qs7CV/1uUXp09+kzAr1j3jjnB2R3PK1/gIIUFbeCH3Mirog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n+2cTgDkNQRVqB0OYOjtImXZUJxePJMau94Bm1t7vxQ=;
 b=bGzPl81Kj9SM+u8KjxKtVZD+g9LJdPu9lPIZRpFZDFhpnjVB7386wfQmfjy61wi3yotdHbZez0TfwMbJODGdQbH7gIcfQx9HJqIgh4zuakluOG5YiE40jJaGij+8WneUGXxKf6H4DNqu2EeXxOp4p8pSXdhuVVRLBwInj2SQwtE=
Received: from DM6PR17CA0004.namprd17.prod.outlook.com (2603:10b6:5:1b3::17)
 by CY8PR12MB7610.namprd12.prod.outlook.com (2603:10b6:930:9a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.45; Tue, 18 Apr
 2023 13:47:16 +0000
Received: from DM6NAM11FT075.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1b3:cafe::bc) by DM6PR17CA0004.outlook.office365.com
 (2603:10b6:5:1b3::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.47 via Frontend
 Transport; Tue, 18 Apr 2023 13:47:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT075.mail.protection.outlook.com (10.13.173.42) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6319.20 via Frontend Transport; Tue, 18 Apr 2023 13:47:16 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 18 Apr
 2023 08:47:14 -0500
Received: from xhdvnc205.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Tue, 18 Apr 2023 08:47:12 -0500
From:   Srinivas Goud <srinivas.goud@amd.com>
To:     <broonie@kernel.org>
CC:     <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <git@amd.com>, <gcnu.goud@gmail.com>,
        Srinivas Goud <srinivas.goud@amd.com>
Subject: [PATCH v2 2/2] spi: spi-cadence: Add support for Slave mode
Date:   Tue, 18 Apr 2023 19:17:05 +0530
Message-ID: <1681825625-10265-3-git-send-email-srinivas.goud@amd.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1681825625-10265-1-git-send-email-srinivas.goud@amd.com>
References: <1681825625-10265-1-git-send-email-srinivas.goud@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT075:EE_|CY8PR12MB7610:EE_
X-MS-Office365-Filtering-Correlation-Id: fd669522-6f6d-43d9-d8d9-08db40136c1a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VtWWlEzRcYjnoXJ2+F3N1VPwLhy6ARMXQ5FSGEB7Z4n8zmPlfAFdMmYrZCkcNDoC12ymPmQDzupxHAend2tgSbEstqP9TPd2fz0CUgfWiAB6/zzLGGmIGcLYswTUjRXsq/7FSof2pBpqpaUSO9KEFqa89Xuomz4UH/Y46PK23S1VoKcqR4S64/55MGmv47r7CsES3/I8Kqpn7Bw0za/rKf5slM1Y25NWvT7ZT7TvvAjasdsr+UqD1wk3fJzAaZGgHYcVC8SiOS7zmgmrfQs/rxdgAsE1I8AwLiEnI1387FPIybdP1C7kyOzwHtvU80m4tdxZilB1bi43b8q0zclHrPdx0VhsrdBts8I7fr1ChwsNIhmilov2l5nIMCSVJJg7IKNSY9gP2g/Mz2KlWShO6RMlW0pAI1+8lq9eSYuZUU6S9PaEZgbn2WhPag/lcL41FZD/Ex4zheyhTW6456phvXNZAo5yAUyGm6xmCiWbidrBvgOa0Y/dwdiEmChUuhHl8P1S2r3YFbEI70haG1dL21bqX2ahSMXcaM3tJNhTJwnsb/iYsUlTisDeblli/n39VoCndGaV9ZQNpoVbokCpQb0hwNjJgO3pfv52mhwmouaQ5m82Vi78NoPDZ1d2Fk1a1HnK+NQyrzcV3sXol6J1prIEpz62oyS9yYr/TdCTWrogvDHdQaJ8mmE4krOakDnQcfU9rfax53F3wRXNki24NVAjNzSb3DtJeNpw6b20fGk=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(376002)(396003)(136003)(39860400002)(346002)(451199021)(46966006)(36840700001)(40470700004)(36756003)(4326008)(6916009)(54906003)(316002)(70586007)(70206006)(478600001)(6666004)(41300700001)(5660300002)(82310400005)(8676002)(8936002)(40480700001)(30864003)(2906002)(44832011)(82740400003)(86362001)(81166007)(356005)(426003)(2616005)(336012)(40460700003)(26005)(186003)(36860700001)(47076005)(83380400001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2023 13:47:16.4531
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fd669522-6f6d-43d9-d8d9-08db40136c1a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT075.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7610
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently SPI Cadence controller works only in Master mode.
Updated interrupt handler for Full duplex transfer in Slave mode.
Interrupt handler rely on the TX empty interrupt even for Slave mode
transfer due to below HW limitation.

HW limitation:
AR 65885 - SPI Controller Might Not Update RX_NEMPTY Flag, Showing
Incorrect Status Of The Receive FIFO

SPI Slave mode works in the following manner:
1.      One transfer can be finished only after all transfer->len
data been transferred to master device.
2.      Slave device only accepts transfer->len data. Any data longer
than this from master device will be dropped. Any data shorter than
this from master will cause SPI to be stuck due to the above behavior.
3.      The stale data present in RXFIFO will be dropped in unprepared
hardware transfer function.

Signed-off-by: Srinivas Goud <srinivas.goud@amd.com>
---
 drivers/spi/spi-cadence.c | 224 +++++++++++++++++++++++++++++++---------------
 1 file changed, 153 insertions(+), 71 deletions(-)

diff --git a/drivers/spi/spi-cadence.c b/drivers/spi/spi-cadence.c
index 99cebe1..ac85d55 100644
--- a/drivers/spi/spi-cadence.c
+++ b/drivers/spi/spi-cadence.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 /*
- * Cadence SPI controller driver (master mode only)
+ * Cadence SPI controller driver (master and slave mode)
  *
  * Copyright (C) 2008 - 2014 Xilinx, Inc.
  *
@@ -139,17 +139,21 @@ static inline void cdns_spi_write(struct cdns_spi *xspi, u32 offset, u32 val)
 /**
  * cdns_spi_init_hw - Initialize the hardware and configure the SPI controller
  * @xspi:	Pointer to the cdns_spi structure
+ * @is_slave:	Flag to indicate slave or master mode
+ * * On reset the SPI controller is configured to slave or  master mode.
+ * In master mode baud rate divisor is set to 4, threshold value for TX FIFO
+ * not full interrupt is set to 1 and size of the word to be transferred as 8 bit.
  *
- * On reset the SPI controller is configured to be in master mode, baud rate
- * divisor is set to 4, threshold value for TX FIFO not full interrupt is set
- * to 1 and size of the word to be transferred as 8 bit.
  * This function initializes the SPI controller to disable and clear all the
  * interrupts, enable manual slave select and manual start, deselect all the
  * chip select lines, and enable the SPI controller.
  */
-static void cdns_spi_init_hw(struct cdns_spi *xspi)
+static void cdns_spi_init_hw(struct cdns_spi *xspi, bool is_slave)
 {
-	u32 ctrl_reg = CDNS_SPI_CR_DEFAULT;
+	u32 ctrl_reg = 0;
+
+	if (!is_slave)
+		ctrl_reg |= CDNS_SPI_CR_DEFAULT;
 
 	if (xspi->is_decoded_cs)
 		ctrl_reg |= CDNS_SPI_CR_PERI_SEL;
@@ -325,6 +329,25 @@ static void cdns_spi_fill_tx_fifo(struct cdns_spi *xspi)
 }
 
 /**
+ * cdns_spi_read_rx_fifo - Reads the RX FIFO with as many bytes as possible
+ * @xspi:       Pointer to the cdns_spi structure
+ * @count:	Read byte count
+ */
+static void cdns_spi_read_rx_fifo(struct cdns_spi *xspi, unsigned long count)
+{
+	u8 data;
+
+	/* Read out the data from the RX FIFO */
+	while (count > 0) {
+		data = cdns_spi_read(xspi, CDNS_SPI_RXD);
+		if (xspi->rxbuf)
+			*xspi->rxbuf++ = data;
+		xspi->rx_bytes--;
+		count--;
+	}
+}
+
+/**
  * cdns_spi_irq - Interrupt service routine of the SPI controller
  * @irq:	IRQ number
  * @dev_id:	Pointer to the xspi structure
@@ -358,27 +381,33 @@ static irqreturn_t cdns_spi_irq(int irq, void *dev_id)
 		spi_finalize_current_transfer(ctlr);
 		status = IRQ_HANDLED;
 	} else if (intr_status & CDNS_SPI_IXR_TXOW) {
-		unsigned long trans_cnt;
-
-		trans_cnt = xspi->rx_bytes - xspi->tx_bytes;
+		int trans_cnt = cdns_spi_read(xspi, CDNS_SPI_THLD);
+		/* Set threshold to one if number of pending are
+		 * less than half fifo
+		 */
+		if (xspi->tx_bytes < xspi->tx_fifo_depth >> 1)
+			cdns_spi_write(xspi, CDNS_SPI_THLD, 1);
 
-		/* Read out the data from the RX FIFO */
 		while (trans_cnt) {
-			u8 data;
-
-			data = cdns_spi_read(xspi, CDNS_SPI_RXD);
-			if (xspi->rxbuf)
-				*xspi->rxbuf++ = data;
-
-			xspi->rx_bytes--;
+			cdns_spi_read_rx_fifo(xspi, 1);
+
+			if (xspi->tx_bytes) {
+				if (xspi->txbuf)
+					cdns_spi_write(xspi, CDNS_SPI_TXD,
+						       *xspi->txbuf++);
+				else
+					cdns_spi_write(xspi, CDNS_SPI_TXD, 0);
+				xspi->tx_bytes--;
+			}
 			trans_cnt--;
 		}
-
-		if (xspi->tx_bytes) {
-			/* There is more data to send */
-			cdns_spi_fill_tx_fifo(xspi);
-		} else {
-			/* Transfer is completed */
+		if (!xspi->tx_bytes) {
+			/* Fixed delay due to controller limitation with
+			 * RX_NEMPTY incorrect status
+			 * Xilinx AR:65885 contains more details
+			 */
+			udelay(10);
+			cdns_spi_read_rx_fifo(xspi, xspi->rx_bytes);
 			cdns_spi_write(xspi, CDNS_SPI_IDR,
 				       CDNS_SPI_IXR_DEFAULT);
 			spi_finalize_current_transfer(ctlr);
@@ -392,7 +421,8 @@ static irqreturn_t cdns_spi_irq(int irq, void *dev_id)
 static int cdns_prepare_message(struct spi_controller *ctlr,
 				struct spi_message *msg)
 {
-	cdns_spi_config_clock_mode(msg->spi);
+	if (!spi_controller_is_slave(ctlr))
+		cdns_spi_config_clock_mode(msg->spi);
 	return 0;
 }
 
@@ -403,8 +433,9 @@ static int cdns_prepare_message(struct spi_controller *ctlr,
  * @transfer:	Pointer to the spi_transfer structure which provides
  *		information about next transfer parameters
  *
- * This function fills the TX FIFO, starts the SPI transfer and
+ * This function in master mode fills the TX FIFO, starts the SPI transfer and
  * returns a positive transfer count so that core will wait for completion.
+ * This function in slave mode fills the TX FIFO and wait for transfer trigger.
  *
  * Return:	Number of bytes transferred in the last transfer
  */
@@ -419,7 +450,15 @@ static int cdns_transfer_one(struct spi_controller *ctlr,
 	xspi->tx_bytes = transfer->len;
 	xspi->rx_bytes = transfer->len;
 
-	cdns_spi_setup_transfer(spi, transfer);
+	if (!spi_controller_is_slave(ctlr))
+		cdns_spi_setup_transfer(spi, transfer);
+
+	/* Set TX empty threshold to half of FIFO depth
+	 * only if TX bytes are more than half FIFO depth.
+	 */
+	if (xspi->tx_bytes > (xspi->tx_fifo_depth >> 1))
+		cdns_spi_write(xspi, CDNS_SPI_THLD, xspi->tx_fifo_depth >> 1);
+
 	cdns_spi_fill_tx_fifo(xspi);
 	spi_transfer_delay_exec(transfer);
 
@@ -451,6 +490,7 @@ static int cdns_prepare_transfer_hardware(struct spi_controller *ctlr)
  *		information about the controller.
  *
  * This function disables the SPI master controller when no slave selected.
+ * This function flush out if any pending data in FIFO.
  *
  * Return:	0 always
  */
@@ -458,13 +498,21 @@ static int cdns_unprepare_transfer_hardware(struct spi_controller *ctlr)
 {
 	struct cdns_spi *xspi = spi_controller_get_devdata(ctlr);
 	u32 ctrl_reg;
+	unsigned int cnt = xspi->tx_fifo_depth;
+
+	if (spi_controller_is_slave(ctlr)) {
+		while (cnt--)
+			cdns_spi_read(xspi, CDNS_SPI_RXD);
+	}
 
 	/* Disable the SPI if slave is deselected */
 	ctrl_reg = cdns_spi_read(xspi, CDNS_SPI_CR);
 	ctrl_reg = (ctrl_reg & CDNS_SPI_CR_SSCTRL) >>  CDNS_SPI_SS_SHIFT;
-	if (ctrl_reg == CDNS_SPI_NOSS)
+	if (ctrl_reg == CDNS_SPI_NOSS || spi_controller_is_slave(ctlr))
 		cdns_spi_write(xspi, CDNS_SPI_ER, CDNS_SPI_ER_DISABLE);
 
+	/* Reset to default */
+	cdns_spi_write(xspi, CDNS_SPI_THLD, 0x1);
 	return 0;
 }
 
@@ -487,6 +535,27 @@ static void cdns_spi_detect_fifo_depth(struct cdns_spi *xspi)
 }
 
 /**
+ * cdns_slave_abort - Abort slave transfer
+ * @ctlr:	Pointer to the spi_controller structure
+ *
+ * This function abort slave transfer if there any transfer timeout.
+ *
+ * Return:      0 always
+ */
+static int cdns_slave_abort(struct spi_controller *ctlr)
+{
+	struct cdns_spi *xspi = spi_controller_get_devdata(ctlr);
+	u32 intr_status;
+
+	intr_status = cdns_spi_read(xspi, CDNS_SPI_ISR);
+	cdns_spi_write(xspi, CDNS_SPI_ISR, intr_status);
+	cdns_spi_write(xspi, CDNS_SPI_IDR, (CDNS_SPI_IXR_MODF | CDNS_SPI_IXR_RXNEMTY));
+	spi_finalize_current_transfer(ctlr);
+
+	return 0;
+}
+
+/**
  * cdns_spi_probe - Probe method for the SPI driver
  * @pdev:	Pointer to the platform_device structure
  *
@@ -500,8 +569,14 @@ static int cdns_spi_probe(struct platform_device *pdev)
 	struct spi_controller *ctlr;
 	struct cdns_spi *xspi;
 	u32 num_cs;
+	bool slave;
+
+	slave = of_property_read_bool(pdev->dev.of_node, "spi-slave");
+	if (slave)
+		ctlr = spi_alloc_slave(&pdev->dev, sizeof(*xspi));
+	else
+		ctlr = spi_alloc_master(&pdev->dev, sizeof(*xspi));
 
-	ctlr = spi_alloc_master(&pdev->dev, sizeof(*xspi));
 	if (!ctlr)
 		return -ENOMEM;
 
@@ -522,46 +597,48 @@ static int cdns_spi_probe(struct platform_device *pdev)
 		goto remove_ctlr;
 	}
 
-	xspi->ref_clk = devm_clk_get(&pdev->dev, "ref_clk");
-	if (IS_ERR(xspi->ref_clk)) {
-		dev_err(&pdev->dev, "ref_clk clock not found.\n");
-		ret = PTR_ERR(xspi->ref_clk);
-		goto remove_ctlr;
-	}
-
 	ret = clk_prepare_enable(xspi->pclk);
 	if (ret) {
 		dev_err(&pdev->dev, "Unable to enable APB clock.\n");
 		goto remove_ctlr;
 	}
 
-	ret = clk_prepare_enable(xspi->ref_clk);
-	if (ret) {
-		dev_err(&pdev->dev, "Unable to enable device clock.\n");
-		goto clk_dis_apb;
-	}
+	if (!spi_controller_is_slave(ctlr)) {
+		xspi->ref_clk = devm_clk_get(&pdev->dev, "ref_clk");
+		if (IS_ERR(xspi->ref_clk)) {
+			dev_err(&pdev->dev, "ref_clk clock not found.\n");
+			ret = PTR_ERR(xspi->ref_clk);
+			goto clk_dis_apb;
+		}
 
-	pm_runtime_use_autosuspend(&pdev->dev);
-	pm_runtime_set_autosuspend_delay(&pdev->dev, SPI_AUTOSUSPEND_TIMEOUT);
-	pm_runtime_get_noresume(&pdev->dev);
-	pm_runtime_set_active(&pdev->dev);
-	pm_runtime_enable(&pdev->dev);
+		ret = clk_prepare_enable(xspi->ref_clk);
+		if (ret) {
+			dev_err(&pdev->dev, "Unable to enable device clock.\n");
+			goto clk_dis_apb;
+		}
 
-	ret = of_property_read_u32(pdev->dev.of_node, "num-cs", &num_cs);
-	if (ret < 0)
-		ctlr->num_chipselect = CDNS_SPI_DEFAULT_NUM_CS;
-	else
-		ctlr->num_chipselect = num_cs;
+		pm_runtime_use_autosuspend(&pdev->dev);
+		pm_runtime_set_autosuspend_delay(&pdev->dev, SPI_AUTOSUSPEND_TIMEOUT);
+		pm_runtime_get_noresume(&pdev->dev);
+		pm_runtime_set_active(&pdev->dev);
+		pm_runtime_enable(&pdev->dev);
 
-	ret = of_property_read_u32(pdev->dev.of_node, "is-decoded-cs",
-				   &xspi->is_decoded_cs);
-	if (ret < 0)
-		xspi->is_decoded_cs = 0;
+		ret = of_property_read_u32(pdev->dev.of_node, "num-cs", &num_cs);
+		if (ret < 0)
+			ctlr->num_chipselect = CDNS_SPI_DEFAULT_NUM_CS;
+		else
+			ctlr->num_chipselect = num_cs;
+
+		ret = of_property_read_u32(pdev->dev.of_node, "is-decoded-cs",
+					   &xspi->is_decoded_cs);
+		if (ret < 0)
+			xspi->is_decoded_cs = 0;
+	}
 
 	cdns_spi_detect_fifo_depth(xspi);
 
 	/* SPI controller initializations */
-	cdns_spi_init_hw(xspi);
+	cdns_spi_init_hw(xspi, spi_controller_is_slave(ctlr));
 
 	irq = platform_get_irq(pdev, 0);
 	if (irq <= 0) {
@@ -582,20 +659,23 @@ static int cdns_spi_probe(struct platform_device *pdev)
 	ctlr->prepare_message = cdns_prepare_message;
 	ctlr->transfer_one = cdns_transfer_one;
 	ctlr->unprepare_transfer_hardware = cdns_unprepare_transfer_hardware;
-	ctlr->set_cs = cdns_spi_chipselect;
-	ctlr->auto_runtime_pm = true;
-	ctlr->mode_bits = SPI_CPOL | SPI_CPHA | SPI_CS_HIGH;
-
-	xspi->clk_rate = clk_get_rate(xspi->ref_clk);
-	/* Set to default valid value */
-	ctlr->max_speed_hz = xspi->clk_rate / 4;
-	xspi->speed_hz = ctlr->max_speed_hz;
-
+	ctlr->mode_bits = SPI_CPOL | SPI_CPHA;
 	ctlr->bits_per_word_mask = SPI_BPW_MASK(8);
 
-	pm_runtime_mark_last_busy(&pdev->dev);
-	pm_runtime_put_autosuspend(&pdev->dev);
-
+	if (!spi_controller_is_slave(ctlr)) {
+		ctlr->mode_bits |=  SPI_CS_HIGH;
+		ctlr->set_cs = cdns_spi_chipselect;
+		ctlr->auto_runtime_pm = true;
+		xspi->clk_rate = clk_get_rate(xspi->ref_clk);
+		/* Set to default valid value */
+		ctlr->max_speed_hz = xspi->clk_rate / 4;
+		xspi->speed_hz = ctlr->max_speed_hz;
+		pm_runtime_mark_last_busy(&pdev->dev);
+		pm_runtime_put_autosuspend(&pdev->dev);
+	} else {
+		ctlr->mode_bits |= SPI_NO_CS;
+		ctlr->slave_abort = cdns_slave_abort;
+	}
 	ret = spi_register_controller(ctlr);
 	if (ret) {
 		dev_err(&pdev->dev, "spi_register_controller failed\n");
@@ -605,9 +685,11 @@ static int cdns_spi_probe(struct platform_device *pdev)
 	return ret;
 
 clk_dis_all:
-	pm_runtime_set_suspended(&pdev->dev);
-	pm_runtime_disable(&pdev->dev);
-	clk_disable_unprepare(xspi->ref_clk);
+	if (!spi_controller_is_slave(ctlr)) {
+		pm_runtime_set_suspended(&pdev->dev);
+		pm_runtime_disable(&pdev->dev);
+		clk_disable_unprepare(xspi->ref_clk);
+	}
 clk_dis_apb:
 	clk_disable_unprepare(xspi->pclk);
 remove_ctlr:
@@ -669,7 +751,7 @@ static int __maybe_unused cdns_spi_resume(struct device *dev)
 	struct spi_controller *ctlr = dev_get_drvdata(dev);
 	struct cdns_spi *xspi = spi_controller_get_devdata(ctlr);
 
-	cdns_spi_init_hw(xspi);
+	cdns_spi_init_hw(xspi, spi_controller_is_slave(ctlr));
 	return spi_controller_resume(ctlr);
 }
 
-- 
2.1.1

