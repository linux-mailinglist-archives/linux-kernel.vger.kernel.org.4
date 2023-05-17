Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 888AC706E32
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 18:32:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229739AbjEQQcO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 12:32:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229721AbjEQQcN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 12:32:13 -0400
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E5DB7AB2;
        Wed, 17 May 2023 09:32:10 -0700 (PDT)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34H5D8YH023779;
        Wed, 17 May 2023 11:31:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=PODMain02222019;
 bh=FHKtiJcMAexLeq/mGQuPV2ftG2sf3W8GTjsMKBwGQu0=;
 b=YnkldFt4jx2NYZyWMioWm30Q1TcbM2Ofpw2XI4VOb0ysqi3ArXhET9t3Oskg6apHdLxA
 9KZbTkk2BzJ/OdP/6K1kR3Kh7yRzSqlYQT8OcREFKNzHX1gZZaNfXPiDMoonhwSzy7xr
 SpnU+On7F+0m87Tdkaz/F2/5Tf/L/XvdlR7q8VIawxeol2NWM3pcj8W0EmmKZzrPgWaH
 /uOWMpNwx+gdTGNZ+Qh8x0vDqV373nBqHPEEZna/KCg5cnyV/icQFsAD76DEwcrAQ0Lv
 UYaH22953AULVa3nNg1JjcjTCI6nHtzecj8vhhjo1oB0CzAisMYDGf/u8LP+IGuMTl13 vA== 
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3qj6ymx7cv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 17 May 2023 11:31:59 -0500
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.26; Wed, 17 May
 2023 11:31:57 -0500
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.2.1118.26 via Frontend
 Transport; Wed, 17 May 2023 11:31:57 -0500
Received: from algalon.ad.cirrus.com (algalon.ad.cirrus.com [198.90.251.122])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id D6F4F11CA;
        Wed, 17 May 2023 16:31:57 +0000 (UTC)
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     <broonie@kernel.org>
CC:     <srinivas.goud@amd.com>, <linux-spi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>
Subject: [PATCH] spi: spi-cadence: Interleave write of TX and read of RX FIFO
Date:   Wed, 17 May 2023 17:31:57 +0100
Message-ID: <20230517163157.639974-1-ckeepax@opensource.cirrus.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: GJjC7YcdrcR4XyHntFEtx79i0Zb1ekuY
X-Proofpoint-ORIG-GUID: GJjC7YcdrcR4XyHntFEtx79i0Zb1ekuY
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When working in slave mode it seems the timing is exceedingly tight.
The TX FIFO can never empty, because the master is driving the clock so
zeros would be sent for those bytes where the FIFO is empty.

Return to interleaving the writing of the TX FIFO and the reading
of the RX FIFO to try to ensure the data is available when required.

Fixes: a84c11e16dc2 ("spi: spi-cadence: Avoid read of RX FIFO before its ready")
Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---

This patch puts the interleaving back it tests out fine even on
longer transfers on my master setup. We should probably wait for a
tested-by from Srinivas before we merge it. I can't test slave mode,
and it sounds like the timing is exceedingly tight on his system.

Thanks,
Charles

 drivers/spi/spi-cadence.c | 60 ++++++++++++++++++---------------------
 1 file changed, 27 insertions(+), 33 deletions(-)

diff --git a/drivers/spi/spi-cadence.c b/drivers/spi/spi-cadence.c
index ff02d81041319..08136bbb34030 100644
--- a/drivers/spi/spi-cadence.c
+++ b/drivers/spi/spi-cadence.c
@@ -12,6 +12,7 @@
 #include <linux/gpio/consumer.h>
 #include <linux/interrupt.h>
 #include <linux/io.h>
+#include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/of_irq.h>
 #include <linux/of_address.h>
@@ -304,44 +305,38 @@ static int cdns_spi_setup_transfer(struct spi_device *spi,
  * cdns_spi_fill_tx_fifo - Fills the TX FIFO with as many bytes as possible
  * @xspi:	Pointer to the cdns_spi structure
  */
-static void cdns_spi_fill_tx_fifo(struct cdns_spi *xspi, unsigned int avail)
+static void cdns_spi_process_fifo(struct cdns_spi *xspi, int ntx, int nrx)
 {
-	unsigned long trans_cnt = 0;
+	ntx = clamp(ntx, 0, xspi->tx_bytes);
+	nrx = clamp(nrx, 0, xspi->rx_bytes);
 
-	while ((trans_cnt < avail) && (xspi->tx_bytes > 0)) {
+	xspi->tx_bytes -= ntx;
+	xspi->rx_bytes -= nrx;
+
+	while (ntx || nrx) {
 		/* When xspi in busy condition, bytes may send failed,
 		 * then spi control did't work thoroughly, add one byte delay
 		 */
-		if (cdns_spi_read(xspi, CDNS_SPI_ISR) &
-		    CDNS_SPI_IXR_TXFULL)
+		if (cdns_spi_read(xspi, CDNS_SPI_ISR) & CDNS_SPI_IXR_TXFULL)
 			udelay(10);
 
-		if (xspi->txbuf)
-			cdns_spi_write(xspi, CDNS_SPI_TXD, *xspi->txbuf++);
-		else
-			cdns_spi_write(xspi, CDNS_SPI_TXD, 0);
+		if (ntx) {
+			if (xspi->txbuf)
+				cdns_spi_write(xspi, CDNS_SPI_TXD, *xspi->txbuf++);
+			else
+				cdns_spi_write(xspi, CDNS_SPI_TXD, 0);
 
-		xspi->tx_bytes--;
-		trans_cnt++;
-	}
-}
+			ntx--;
+		}
 
-/**
- * cdns_spi_read_rx_fifo - Reads the RX FIFO with as many bytes as possible
- * @xspi:       Pointer to the cdns_spi structure
- * @count:	Read byte count
- */
-static void cdns_spi_read_rx_fifo(struct cdns_spi *xspi, unsigned long count)
-{
-	u8 data;
-
-	/* Read out the data from the RX FIFO */
-	while (count > 0) {
-		data = cdns_spi_read(xspi, CDNS_SPI_RXD);
-		if (xspi->rxbuf)
-			*xspi->rxbuf++ = data;
-		xspi->rx_bytes--;
-		count--;
+		if (nrx) {
+			u8 data = cdns_spi_read(xspi, CDNS_SPI_RXD);
+
+			if (xspi->rxbuf)
+				*xspi->rxbuf++ = data;
+
+			nrx--;
+		}
 	}
 }
 
@@ -391,11 +386,10 @@ static irqreturn_t cdns_spi_irq(int irq, void *dev_id)
 		if (xspi->tx_bytes < xspi->tx_fifo_depth >> 1)
 			cdns_spi_write(xspi, CDNS_SPI_THLD, 1);
 
-		cdns_spi_read_rx_fifo(xspi, trans_cnt);
-
 		if (xspi->tx_bytes) {
-			cdns_spi_fill_tx_fifo(xspi, trans_cnt);
+			cdns_spi_process_fifo(xspi, trans_cnt, trans_cnt);
 		} else {
+			cdns_spi_process_fifo(xspi, 0, trans_cnt);
 			cdns_spi_write(xspi, CDNS_SPI_IDR,
 				       CDNS_SPI_IXR_DEFAULT);
 			spi_finalize_current_transfer(ctlr);
@@ -448,7 +442,7 @@ static int cdns_transfer_one(struct spi_controller *ctlr,
 			cdns_spi_write(xspi, CDNS_SPI_THLD, xspi->tx_fifo_depth >> 1);
 	}
 
-	cdns_spi_fill_tx_fifo(xspi, xspi->tx_fifo_depth);
+	cdns_spi_process_fifo(xspi, xspi->tx_fifo_depth, 0);
 	spi_transfer_delay_exec(transfer);
 
 	cdns_spi_write(xspi, CDNS_SPI_IER, CDNS_SPI_IXR_DEFAULT);
-- 
2.30.2

