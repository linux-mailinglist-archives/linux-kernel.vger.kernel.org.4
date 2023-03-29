Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE4316CD8BA
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 13:47:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229882AbjC2LrL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 07:47:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229802AbjC2LrH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 07:47:07 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2045.outbound.protection.outlook.com [40.107.244.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBC2B4233;
        Wed, 29 Mar 2023 04:47:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VnRudTuvvfraKG3X4hp8+Muk3RW+/A1lebilL2O+5vvmHJ9oUs69LC0aSDQnDaHtVZMABhBucx90XB1EYyo4gFXMBd2DVGbr/rtX/gmffNrSFh8FXFoMxPu1CSjtpQnpN50fMeTJ/bZuayYXppXADYMg+0R/Mr/MSDC07565hrLLQES4EHrzoRoHsbOrnFwsZZE2WbeibTY43ZK2Jbv/lDpBTANaLlCbvBIqWdk10UruIGXEiUMzDSejpsPf9D4+nRUr9NdIkoZLNB7n9rLQ2i+xON70oRJCIPjpF8KoGsMqsabpd5p/AqpjUEEx/wYKu2kI3VxurcgumGnWf4D4wA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s/0eiLSM787CK1+nXe2cHwE3vsKGCJBifz25dmIM5a8=;
 b=by7IJdYF/OnnCLLppiKDiGb3M6xk6Cf2R8B4aXzeQmgXTjoG4VzFmaa3PhkunFJLziKEjURypRXVCNdkk6Qb4iXAcMio4TMHZGuTr6a8JSu8nOc9bP9JGjfs8ev1BQe1xON4FYjzG3t5AsouDG15A/d1RVLJjapp53VZ66qa2DA3hR+qCJSNt4WKZoGRpFwFRNvbe8SjKfDTtc3CB1iHZiEyAAieleJAekLmtdj4VWL8a4NwAZbewHnKdSSgtPmcZB7fJTGJV9fvSj+Vu9TLfa1W2v3iUNGXGyLETJ2MeGrId3sIj8R7ze4riYOY9uHYEvfcF9yF/cvXoKuewm2Bzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=amd.com smtp.mailfrom=xilinx.com;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s/0eiLSM787CK1+nXe2cHwE3vsKGCJBifz25dmIM5a8=;
 b=EFpvb0k5S7vxAlWPM1jQc6vZkgYrySmhnsFzxAemg66SM3qRNZHOoObnCDv8bgx7PcDczWIO2UYUi6F4FjC7dhfOeZg7qgWMm/GOZWovC6q2o+K3p3/2KOeC/MS07s2JflWON9LSLC9/DyZApNdt25V68Ub+Bh5XclTKggq2KzA=
Received: from BN9PR03CA0273.namprd03.prod.outlook.com (2603:10b6:408:f5::8)
 by PH0PR02MB7110.namprd02.prod.outlook.com (2603:10b6:510:1b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.28; Wed, 29 Mar
 2023 11:47:03 +0000
Received: from BN1NAM02FT027.eop-nam02.prod.protection.outlook.com
 (2603:10b6:408:f5:cafe::f0) by BN9PR03CA0273.outlook.office365.com
 (2603:10b6:408:f5::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.20 via Frontend
 Transport; Wed, 29 Mar 2023 11:47:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com; pr=C
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 BN1NAM02FT027.mail.protection.outlook.com (10.13.2.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6222.21 via Frontend Transport; Wed, 29 Mar 2023 11:47:02 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 29 Mar 2023 04:46:59 -0700
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2507.16 via Frontend Transport; Wed, 29 Mar 2023 04:46:59 -0700
Envelope-to: git@amd.com,
 srinivas.goud@amd.com,
 gcnu.goud@gmail.com,
 broonie@kernel.org,
 linux-kernel@vger.kernel.org,
 linux-spi@vger.kernel.org
Received: from [172.23.64.2] (port=58555 helo=xhdvnc102.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <srinivas.goud@xilinx.com>)
        id 1phUGZ-000CGH-40; Wed, 29 Mar 2023 04:46:59 -0700
Received: by xhdvnc102.xilinx.com (Postfix, from userid 10378)
        id 5DE28104571; Wed, 29 Mar 2023 17:16:31 +0530 (IST)
From:   Srinivas Goud <srinivas.goud@amd.com>
To:     <broonie@kernel.org>
CC:     <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <git@amd.com>, <gcnu.goud@gmail.com>,
        Srinivas Goud <srinivas.goud@amd.com>
Subject: [PATCH 2/2] spi: spi-cadence: Add support for Slave mode
Date:   Wed, 29 Mar 2023 17:16:24 +0530
Message-ID: <1680090384-25769-3-git-send-email-srinivas.goud@amd.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1680090384-25769-1-git-send-email-srinivas.goud@amd.com>
References: <1680090384-25769-1-git-send-email-srinivas.goud@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1NAM02FT027:EE_|PH0PR02MB7110:EE_
X-MS-Office365-Filtering-Correlation-Id: dbd0e4de-787d-47c7-29b8-08db304b502e
X-MS-Exchange-SenderADCheck: 0
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tMEO3IyBpdEscdt2NzFHQ+gZdQCu1dkqvvPwjXH9isTvDhoXZvj+6BgoSiraexuOz2UcEmtYJ8eIKf7h3Gvj1yTDsT5Mc8+oEIOVKAbGNtiEXzHFig41QT/D4KL8/RoFz+wEkbUNLJJubatMptyfquevPoNN4MrMRK2En9W5sMl+8v4sgy+Gz+CSqeBB7HrYq4jGtvSkqViYldXhFKaBmffMSRKIMfasVISQLZVaS1LQ8b3D9B3jBYf1cVx9mbtespCklGtE+HDGeosFXXf9dnK0nS2y4VolbeOCynuE+7ZiA+bVLArcnNWDeJtJ0TIjNadbnuE7GIkf6dAhaJDzf2E60ZTZyt2RmGNqW4iRgQAVe3ItB/w8T7hrCCwKXg7ycBrnxoxxj/e09AuSy5NgMrPMfRGnykvqC9yDfj6/rKCywBLCLXj8Ed27+LyJ8f5Ni4JckpMSlJEv6Qk7EEXpDcWnK+NFnKdFzQYsx9XIOUqbWnL+uTLZNEn9CN+fzvIUShbXXGM7Zn5otYPxyPLP7Gp+a++LD57hCnRGbNo+vx9/lkVtdGAlJZ2f4sg/qkFVI242VU3V32INErZxhG79KOS4Vogi+9NnJqiZ2eXskOpw8VTMJI9rjRMiflJ/JWjn+m12aYZAWRcfpuJ0dg82Uvf+KCqU/3f4zSlOTy8VwHbUYo1FzBnL8ByxTyPU4D5noSvOOUx21xtDiR40PwrpKopg89POI2jFFk79+ykh6NE=
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(13230028)(136003)(376002)(346002)(39860400002)(396003)(451199021)(36840700001)(40470700004)(46966006)(47076005)(2906002)(2616005)(83380400001)(336012)(42882007)(6916009)(8676002)(4326008)(70206006)(70586007)(478600001)(42186006)(54906003)(6266002)(316002)(26005)(83170400001)(82310400005)(186003)(30864003)(6666004)(44832011)(36756003)(36860700001)(41300700001)(82740400003)(5660300002)(356005)(40480700001)(7636003)(40460700003)(8936002)(102446001);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2023 11:47:02.7534
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dbd0e4de-787d-47c7-29b8-08db304b502e
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1NAM02FT027.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR02MB7110
X-Spam-Status: No, score=0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
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
1.	One transfer can be finished only after all transfer->len
data been transferred to master device.
2.	Slave device only accepts transfer->len data. Any data longer
than this from master device will be dropped. Any data shorter than
this from master will cause SPI to be stuck due to the above behavior.
3.	The stale data present in RXFIFO will be dropped in unprepared
hardware transfer function.

Signed-off-by: Srinivas Goud <srinivas.goud@amd.com>
---
 drivers/spi/spi-cadence.c | 224 +++++++++++++++++++++++++++++++---------------
 1 file changed, 153 insertions(+), 71 deletions(-)

diff --git a/drivers/spi/spi-cadence.c b/drivers/spi/spi-cadence.c
index e18df53..4fbcbe0 100644
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
@@ -671,7 +753,7 @@ static int __maybe_unused cdns_spi_resume(struct device *dev)
 	struct spi_controller *ctlr = dev_get_drvdata(dev);
 	struct cdns_spi *xspi = spi_controller_get_devdata(ctlr);
 
-	cdns_spi_init_hw(xspi);
+	cdns_spi_init_hw(xspi, spi_controller_is_slave(ctlr));
 	return spi_controller_resume(ctlr);
 }
 
-- 
2.1.1

