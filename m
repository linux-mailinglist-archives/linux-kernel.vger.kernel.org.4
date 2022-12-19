Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74CDB650DA7
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Dec 2022 15:43:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232441AbiLSOnv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 09:43:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231926AbiLSOnU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 09:43:20 -0500
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 680596369;
        Mon, 19 Dec 2022 06:43:19 -0800 (PST)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BJ9PoPe009678;
        Mon, 19 Dec 2022 06:43:12 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=pfpt0220;
 bh=D0oUrq7Lqfz+ranVw2W6f2mza1kwCbji745cITFuHqc=;
 b=IC6C/QZbgLLEmPwZeJMmOrZMMy8NvWNxm8DmsjxTokUWJPbJuYMapxiaOGWc124o4ViD
 qGMOIFC7yYetQM4tm+sLQtjCYZnQJ1O2H6eSjufbg37tC4BWChEElIhrAfbZCemSV9Ny
 vLtJ7s9il1PMiSJr+cuGMjH3y0kZpWSDoIavISGWh7OOEwu77yu1LlwebZxzvKGEjZUw
 BTRdpSbKq23RCkFl0yU5yirECA06MLSWVtphATiN0wmIkldXdksPEn0hT5cheQFdRr79
 lyNLs3VQqlZdT2m1oe5dh4Kl61Ygd9HepcIUz3w9ONwbhWXTrBjuSbOBQjgtXdIg2g5N dg== 
Received: from dc5-exch01.marvell.com ([199.233.59.181])
        by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3mjnans4hr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 19 Dec 2022 06:43:12 -0800
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Mon, 19 Dec
 2022 06:43:10 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server id 15.0.1497.42 via Frontend
 Transport; Mon, 19 Dec 2022 06:43:10 -0800
Received: from localhost.localdomain (unknown [10.110.150.170])
        by maili.marvell.com (Postfix) with ESMTP id 978CF3F7091;
        Mon, 19 Dec 2022 06:43:10 -0800 (PST)
From:   Witold Sadowski <wsadowski@marvell.com>
To:     <broonie@kernel.org>
CC:     <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <jpawar@cadence.com>,
        <pthombar@cadence.com>, <konrad@cadence.com>,
        <wbartczak@marvell.com>, <wzmuda@marvell.com>,
        <wsadowski@marvell.com>
Subject: [PATCH 3/7] spi: cadence: Add polling mode support
Date:   Mon, 19 Dec 2022 06:42:50 -0800
Message-ID: <20221219144254.20883-4-wsadowski@marvell.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221219144254.20883-1-wsadowski@marvell.com>
References: <20221219144254.20883-1-wsadowski@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: xnGTGLksJn9DNQqJ4GRphIe_1LLxm7ET
X-Proofpoint-ORIG-GUID: xnGTGLksJn9DNQqJ4GRphIe_1LLxm7ET
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-19_01,2022-12-15_02,2022-06-22_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If IRQ is not configured, switch driver to polling
mode instead of returning with error.
Code is using SDMA interrupt flag to determine
SDMA operation status, and stig ready flag to
determine stig engine readiness.

Signed-off-by: Witold Sadowski <wsadowski@marvell.com>
Reviewed-by: Chandrakala Chavva <cchavva@marvell.com>
Reviewed-by: Sunil Kovvuri Goutham <sgoutham@marvell.com>
---
 drivers/spi/spi-cadence-xspi.c | 66 +++++++++++++++++++++++++++-------
 1 file changed, 53 insertions(+), 13 deletions(-)

diff --git a/drivers/spi/spi-cadence-xspi.c b/drivers/spi/spi-cadence-xspi.c
index 91db3c973167..25db0d55d5ef 100644
--- a/drivers/spi/spi-cadence-xspi.c
+++ b/drivers/spi/spi-cadence-xspi.c
@@ -190,6 +190,9 @@
 		((op)->data.dir == SPI_MEM_DATA_IN) ? \
 		CDNS_XSPI_STIG_CMD_DIR_READ : CDNS_XSPI_STIG_CMD_DIR_WRITE))
 
+#define CDNS_XSPI_POLL_TIMEOUT_US	1000
+#define CDNS_XSPI_POLL_DELAY_US	10
+
 enum cdns_xspi_stig_instr_type {
 	CDNS_XSPI_STIG_INSTR_TYPE_0,
 	CDNS_XSPI_STIG_INSTR_TYPE_1,
@@ -293,6 +296,9 @@ static void cdns_xspi_set_interrupts(struct cdns_xspi_dev *cdns_xspi,
 {
 	u32 intr_enable;
 
+	if (!cdns_xspi->irq)
+		return;
+
 	intr_enable = readl(cdns_xspi->iobase + CDNS_XSPI_INTR_ENABLE_REG);
 	if (enabled)
 		intr_enable |= CDNS_XSPI_INTR_MASK;
@@ -345,6 +351,28 @@ static void cdns_xspi_sdma_handle(struct cdns_xspi_dev *cdns_xspi)
 	}
 }
 
+bool cdns_xspi_stig_ready(struct cdns_xspi_dev *cdns_xspi)
+{
+	u32 ctrl_stat;
+
+	return readl_relaxed_poll_timeout
+		(cdns_xspi->iobase + CDNS_XSPI_CTRL_STATUS_REG,
+		ctrl_stat,
+		((ctrl_stat & BIT(3)) == 0),
+		CDNS_XSPI_POLL_DELAY_US, CDNS_XSPI_POLL_TIMEOUT_US);
+}
+
+bool cdns_xspi_sdma_ready(struct cdns_xspi_dev *cdns_xspi)
+{
+	u32 ctrl_stat;
+
+	return readl_relaxed_poll_timeout
+		(cdns_xspi->iobase + CDNS_XSPI_INTR_STATUS_REG,
+		ctrl_stat,
+		(ctrl_stat & CDNS_XSPI_SDMA_TRIGGER),
+		CDNS_XSPI_POLL_DELAY_US, CDNS_XSPI_POLL_TIMEOUT_US);
+}
+
 static int cdns_xspi_send_stig_command(struct cdns_xspi_dev *cdns_xspi,
 				       const struct spi_mem_op *op,
 				       bool data_phase)
@@ -385,16 +413,26 @@ static int cdns_xspi_send_stig_command(struct cdns_xspi_dev *cdns_xspi,
 
 		cdns_xspi_trigger_command(cdns_xspi, cmd_regs);
 
-		wait_for_completion(&cdns_xspi->sdma_complete);
-		if (cdns_xspi->sdma_error) {
-			cdns_xspi_set_interrupts(cdns_xspi, false);
-			return -EIO;
+		if (cdns_xspi->irq) {
+			wait_for_completion(&cdns_xspi->sdma_complete);
+			if (cdns_xspi->sdma_error) {
+				cdns_xspi_set_interrupts(cdns_xspi, false);
+				return -EIO;
+			}
+		} else {
+			if (cdns_xspi_sdma_ready(cdns_xspi))
+				return -EIO;
 		}
 		cdns_xspi_sdma_handle(cdns_xspi);
 	}
 
-	wait_for_completion(&cdns_xspi->cmd_complete);
-	cdns_xspi_set_interrupts(cdns_xspi, false);
+	if (cdns_xspi->irq) {
+		wait_for_completion(&cdns_xspi->cmd_complete);
+		cdns_xspi_set_interrupts(cdns_xspi, false);
+	} else {
+		if (cdns_xspi_stig_ready(cdns_xspi))
+			return -EIO;
+	}
 
 	cmd_status = cdns_xspi_check_command_status(cdns_xspi);
 	if (cmd_status)
@@ -580,13 +618,15 @@ static int cdns_xspi_probe(struct platform_device *pdev)
 
 	cdns_xspi->irq = platform_get_irq(pdev, 0);
 	if (cdns_xspi->irq < 0)
-		return -ENXIO;
-
-	ret = devm_request_irq(dev, cdns_xspi->irq, cdns_xspi_irq_handler,
-			       IRQF_SHARED, pdev->name, cdns_xspi);
-	if (ret) {
-		dev_err(dev, "Failed to request IRQ: %d\n", cdns_xspi->irq);
-		return ret;
+		cdns_xspi->irq = 0;
+
+	if (cdns_xspi->irq) {
+		ret = devm_request_irq(dev, cdns_xspi->irq, cdns_xspi_irq_handler,
+				IRQF_SHARED, pdev->name, cdns_xspi);
+		if (ret) {
+			dev_err(dev, "Failed to request IRQ: %d\n", cdns_xspi->irq);
+			return ret;
+		}
 	}
 
 	cdns_xspi_print_phy_config(cdns_xspi);
-- 
2.17.1

