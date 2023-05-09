Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80C9F6FCB84
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 18:42:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230029AbjEIQmN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 12:42:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbjEIQmG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 12:42:06 -0400
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35CEF3C35;
        Tue,  9 May 2023 09:42:05 -0700 (PDT)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 349GKZNL008998;
        Tue, 9 May 2023 11:41:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=PODMain02222019;
 bh=qQM04fH8wYbMYV9sluxk+y4zEawLXJoiozfeS8Zvv7M=;
 b=OuuAD7036JIIFa4hLIuHWmPNDMXr4O26A8SdnlCO6CRuI21Q1vwabgcDnLaVL2yfjmrJ
 qxzBj0lTfOjBTqSPQR/7DGUzhzdeiTexUxjRIVBXkYJTt0JfJTLOf/SGb9ErDQiGvSJH
 gmvfgrZxXXXrTry2CvhFEdY7BEsLcdKSL3jxJwz9SZE01PUO/5GJpOfmrM1KPrg4g8/i
 5pxMmWSGIoSQjYvwM8Jx9Z+XNDE0M9ODurjTYbOuq9y4/G6KKWxUfr8daefsHMlqa2bh
 Z5adhmtkOCA2oxSnFuYvh2SouD7y0JNKnWEKLb/0KnDxqTzOYGZ6JRKwzSWiYTyq8yM9 lw== 
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3qf7s41ahu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 09 May 2023 11:41:54 -0500
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.26; Tue, 9 May
 2023 11:41:53 -0500
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Tue, 9 May 2023 11:41:53 -0500
Received: from algalon.ad.cirrus.com (algalon.ad.cirrus.com [198.90.251.122])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 2C58011D4;
        Tue,  9 May 2023 16:41:53 +0000 (UTC)
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     <broonie@kernel.org>
CC:     <srinivas.goud@amd.com>, <linux-spi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>
Subject: [PATCH 1/2] spi: spi-cadence: Avoid read of RX FIFO before its ready
Date:   Tue, 9 May 2023 17:41:52 +0100
Message-ID: <20230509164153.3907694-1-ckeepax@opensource.cirrus.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: PMVYRC2i7GEEEdQKK_jielB5LHBdePS9
X-Proofpoint-GUID: PMVYRC2i7GEEEdQKK_jielB5LHBdePS9
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

Recent changes to cdns_spi_irq introduced some issues.

Firstly, when writing the end of a longer transaction, the code in
cdns_spi_irq will write data into the TX FIFO, then immediately
fall into the if (!xspi->tx_bytes) path and attempt to read data
from the RX FIFO. However this required waiting for the TX FIFO to
empty before the RX data was ready.

Secondly, the variable trans_cnt is now rather inaccurately named
since in cases, where the watermark is set to 1, trans_cnt will be
1 but the count of bytes transferred would be much longer.

Finally, when setting up the transaction we set the watermark to 50%
of the FIFO if the transaction is great than 50% of the FIFO. However,
there is no need to split a tranaction that is smaller than the
whole FIFO, so anything up to the FIFO size can be done in a single
transaction.

Tidy up the code a little, to avoid repeatedly calling
cdns_spi_read_rx_fifo with a count of 1, and correct the three issues
noted above.

Fixes: b1b90514eaa3 ("spi: spi-cadence: Add support for Slave mode")
Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---
 drivers/spi/spi-cadence.c | 42 ++++++++++++++-------------------------
 1 file changed, 15 insertions(+), 27 deletions(-)

diff --git a/drivers/spi/spi-cadence.c b/drivers/spi/spi-cadence.c
index ac85d55622127..b0ccb138e3566 100644
--- a/drivers/spi/spi-cadence.c
+++ b/drivers/spi/spi-cadence.c
@@ -304,13 +304,11 @@ static int cdns_spi_setup_transfer(struct spi_device *spi,
  * cdns_spi_fill_tx_fifo - Fills the TX FIFO with as many bytes as possible
  * @xspi:	Pointer to the cdns_spi structure
  */
-static void cdns_spi_fill_tx_fifo(struct cdns_spi *xspi)
+static void cdns_spi_fill_tx_fifo(struct cdns_spi *xspi, unsigned int avail)
 {
 	unsigned long trans_cnt = 0;
 
-	while ((trans_cnt < xspi->tx_fifo_depth) &&
-	       (xspi->tx_bytes > 0)) {
-
+	while ((trans_cnt < avail) && (xspi->tx_bytes > 0)) {
 		/* When xspi in busy condition, bytes may send failed,
 		 * then spi control did't work thoroughly, add one byte delay
 		 */
@@ -381,33 +379,23 @@ static irqreturn_t cdns_spi_irq(int irq, void *dev_id)
 		spi_finalize_current_transfer(ctlr);
 		status = IRQ_HANDLED;
 	} else if (intr_status & CDNS_SPI_IXR_TXOW) {
-		int trans_cnt = cdns_spi_read(xspi, CDNS_SPI_THLD);
+		int threshold = cdns_spi_read(xspi, CDNS_SPI_THLD);
+		int trans_cnt = xspi->rx_bytes - xspi->tx_bytes;
+
+		if (threshold > 1)
+			trans_cnt -= threshold;
+
 		/* Set threshold to one if number of pending are
 		 * less than half fifo
 		 */
 		if (xspi->tx_bytes < xspi->tx_fifo_depth >> 1)
 			cdns_spi_write(xspi, CDNS_SPI_THLD, 1);
 
-		while (trans_cnt) {
-			cdns_spi_read_rx_fifo(xspi, 1);
-
-			if (xspi->tx_bytes) {
-				if (xspi->txbuf)
-					cdns_spi_write(xspi, CDNS_SPI_TXD,
-						       *xspi->txbuf++);
-				else
-					cdns_spi_write(xspi, CDNS_SPI_TXD, 0);
-				xspi->tx_bytes--;
-			}
-			trans_cnt--;
-		}
-		if (!xspi->tx_bytes) {
-			/* Fixed delay due to controller limitation with
-			 * RX_NEMPTY incorrect status
-			 * Xilinx AR:65885 contains more details
-			 */
-			udelay(10);
-			cdns_spi_read_rx_fifo(xspi, xspi->rx_bytes);
+		cdns_spi_read_rx_fifo(xspi, trans_cnt);
+
+		if (xspi->tx_bytes) {
+			cdns_spi_fill_tx_fifo(xspi, trans_cnt);
+		} else {
 			cdns_spi_write(xspi, CDNS_SPI_IDR,
 				       CDNS_SPI_IXR_DEFAULT);
 			spi_finalize_current_transfer(ctlr);
@@ -456,10 +444,10 @@ static int cdns_transfer_one(struct spi_controller *ctlr,
 	/* Set TX empty threshold to half of FIFO depth
 	 * only if TX bytes are more than half FIFO depth.
 	 */
-	if (xspi->tx_bytes > (xspi->tx_fifo_depth >> 1))
+	if (xspi->tx_bytes > xspi->tx_fifo_depth)
 		cdns_spi_write(xspi, CDNS_SPI_THLD, xspi->tx_fifo_depth >> 1);
 
-	cdns_spi_fill_tx_fifo(xspi);
+	cdns_spi_fill_tx_fifo(xspi, xspi->tx_fifo_depth);
 	spi_transfer_delay_exec(transfer);
 
 	cdns_spi_write(xspi, CDNS_SPI_IER, CDNS_SPI_IXR_DEFAULT);
-- 
2.30.2

