Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6CCA6FCB86
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 18:42:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229489AbjEIQm1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 12:42:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233293AbjEIQmK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 12:42:10 -0400
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28D684225;
        Tue,  9 May 2023 09:42:07 -0700 (PDT)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 349GKtb4009501;
        Tue, 9 May 2023 11:41:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=OjQmmXmIcH9+jcR8c3ItshyYbkN74w1OkLiozi3slDA=;
 b=L9r7qoasMnNbqSDBoKFDEqNM/N6u8SEfS3QNG54ncBAZPWp1Xmcy/kb716TgH+qZ/DDR
 dMoxzP7slx5O3ekxAX/x3yWSXL3rOCNAum1QHfuzJCr5iAvzBVaqiXMbMStcvP623Aqc
 EbyqTF2P6WNWn0OrXvN8LNiXjsYYC2/rz787mhJrzB7Ny3VhsVnpHaHGW1ddFLLjJlZ9
 AFGRy772quyv2NmOJQNRAACW+dWjHnXrbM2fV1FwuL3A4AF+LB3/oT8ZWoTBU0YtSPJ1
 TJOekg5m0Vz4hrByS+iMS0ibuEbzL8M7WmgOPYDTR0w/pVE6TpRL/u6kCOGM0tXZareF qg== 
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3qf7s41aht-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 09 May 2023 11:41:54 -0500
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.26; Tue, 9 May
 2023 11:41:53 -0500
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.2.1118.26 via Frontend
 Transport; Tue, 9 May 2023 11:41:53 -0500
Received: from algalon.ad.cirrus.com (algalon.ad.cirrus.com [198.90.251.122])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 3E37E45;
        Tue,  9 May 2023 16:41:53 +0000 (UTC)
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     <broonie@kernel.org>
CC:     <srinivas.goud@amd.com>, <linux-spi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>
Subject: [PATCH 2/2] spi: spi-cadence: Only overlap FIFO transactions in slave mode
Date:   Tue, 9 May 2023 17:41:53 +0100
Message-ID: <20230509164153.3907694-2-ckeepax@opensource.cirrus.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230509164153.3907694-1-ckeepax@opensource.cirrus.com>
References: <20230509164153.3907694-1-ckeepax@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: cGxDQoXFL9mc-Nc8A6YsQtY593bxSw-h
X-Proofpoint-GUID: cGxDQoXFL9mc-Nc8A6YsQtY593bxSw-h
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

Commit b1b90514eaa3 ("spi: spi-cadence: Add support for Slave mode")
updated the code to trigger the IRQ when the FIFO was half empty,
overlapping filling more data into the FIFO and sending what is left.
This appears to cause regressions on the Zynq 7000, for transactions
longer than the FIFO size, below that no overlapping occurs.

It would appear from my testing that any attempt to put new data into
the FIFO whilst data is still transmitting causes data corruption
on both send and receive. If I am reading the commit message right
on commit 49530e641178 ("spi: cadence: Add usleep_range() for
cdns_spi_fill_tx_fifo()"), that would also seem to imply this is the
case.

On the assumption that this isn't an issue on the platform
the original slave mode support was added for, update the
cdns_transfer_one to only set the watermark to 50% of the FIFO size
when in slave mode. There by retaining the new behaviour for slave
mode but reverting to the older behaviour when the SPI is used a
master.

Fixes: b1b90514eaa3 ("spi: spi-cadence: Add support for Slave mode")
Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---
 drivers/spi/spi-cadence.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/spi/spi-cadence.c b/drivers/spi/spi-cadence.c
index b0ccb138e3566..ff02d81041319 100644
--- a/drivers/spi/spi-cadence.c
+++ b/drivers/spi/spi-cadence.c
@@ -438,14 +438,15 @@ static int cdns_transfer_one(struct spi_controller *ctlr,
 	xspi->tx_bytes = transfer->len;
 	xspi->rx_bytes = transfer->len;
 
-	if (!spi_controller_is_slave(ctlr))
+	if (!spi_controller_is_slave(ctlr)) {
 		cdns_spi_setup_transfer(spi, transfer);
-
-	/* Set TX empty threshold to half of FIFO depth
-	 * only if TX bytes are more than half FIFO depth.
-	 */
-	if (xspi->tx_bytes > xspi->tx_fifo_depth)
-		cdns_spi_write(xspi, CDNS_SPI_THLD, xspi->tx_fifo_depth >> 1);
+	} else {
+		/* Set TX empty threshold to half of FIFO depth
+		 * only if TX bytes are more than half FIFO depth.
+		 */
+		if (xspi->tx_bytes > xspi->tx_fifo_depth)
+			cdns_spi_write(xspi, CDNS_SPI_THLD, xspi->tx_fifo_depth >> 1);
+	}
 
 	cdns_spi_fill_tx_fifo(xspi, xspi->tx_fifo_depth);
 	spi_transfer_delay_exec(transfer);
-- 
2.30.2

