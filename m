Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 805FE650D9F
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Dec 2022 15:43:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232328AbiLSOn2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 09:43:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231545AbiLSOnT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 09:43:19 -0500
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D5F362C5;
        Mon, 19 Dec 2022 06:43:18 -0800 (PST)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BJ9PqqE009699;
        Mon, 19 Dec 2022 06:43:12 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=pfpt0220;
 bh=zaMB3AHu3ynPWiKaemebld3Nh2wqXea1HpUvMiEtxv0=;
 b=KBCo5ZGMrDoxYUw++IkwPTavmsblZMnhuOBb7oIFwRSmnlkwD7d0mU6z98Lcg3B3Z1Sk
 kRXA0woRHcuGBcyWg3owj/jAJ/7KfRmr1BKM5q3SYS5+rVapixrQ7oIOWD5J+eFwkdoG
 HZoGSncXRDMZz66+wrNFXhoRHGaTZV8D9D0X2FxRTG/l/8KbC51QWqi+HGjJgZfHhbjt
 BHv5VoBHx4fXymUAyvJb/ZxcGs+1lV5ScF9+GaOuaDXM0utKMbU8xofiyO+AsfDyJHpd
 pr8YC9r5DB+ikYT2jV6ehFrvHhHPm4VOlU9wGDbS7m+x3EK8P8So+Ffo+e31RDNRkyUW yg== 
Received: from dc5-exch02.marvell.com ([199.233.59.182])
        by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3mjnans4hp-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 19 Dec 2022 06:43:12 -0800
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Mon, 19 Dec
 2022 06:43:11 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server id 15.0.1497.42 via Frontend
 Transport; Mon, 19 Dec 2022 06:43:11 -0800
Received: from localhost.localdomain (unknown [10.110.150.170])
        by maili.marvell.com (Postfix) with ESMTP id 53D5A3F7054;
        Mon, 19 Dec 2022 06:43:11 -0800 (PST)
From:   Witold Sadowski <wsadowski@marvell.com>
To:     <broonie@kernel.org>
CC:     <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <jpawar@cadence.com>,
        <pthombar@cadence.com>, <konrad@cadence.com>,
        <wbartczak@marvell.com>, <wzmuda@marvell.com>,
        <wsadowski@marvell.com>
Subject: [PATCH 5/7] spi: cadence: Add read access size switch
Date:   Mon, 19 Dec 2022 06:42:52 -0800
Message-ID: <20221219144254.20883-6-wsadowski@marvell.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221219144254.20883-1-wsadowski@marvell.com>
References: <20221219144254.20883-1-wsadowski@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: QyPaAvPnBBoBXIQwuFQ8pOscZWR-e-n4
X-Proofpoint-ORIG-GUID: QyPaAvPnBBoBXIQwuFQ8pOscZWR-e-n4
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

Allow to use different SDMA read size.
In Marvell implementation of that IP each SDMA
access will read 8 bytes at once, and is not
configurable.

Signed-off-by: Witold Sadowski <wsadowski@marvell.com>
Reviewed-by: Chandrakala Chavva <cchavva@marvell.com>
Tested-by: Sunil Kovvuri Goutham <sgoutham@marvell.com>
---
 drivers/spi/spi-cadence-xspi.c | 99 ++++++++++++++++++++++++++++++++--
 1 file changed, 95 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-cadence-xspi.c b/drivers/spi/spi-cadence-xspi.c
index 25db0d55d5ef..719c2f3b4771 100644
--- a/drivers/spi/spi-cadence-xspi.c
+++ b/drivers/spi/spi-cadence-xspi.c
@@ -209,6 +209,11 @@ enum cdns_xspi_stig_cmd_dir {
 	CDNS_XSPI_STIG_CMD_DIR_WRITE,
 };
 
+enum cdns_xspi_sdma_size {
+	CDNS_XSPI_SDMA_SIZE_8B = 0,
+	CDNS_XSPI_SDMA_SIZE_64B = 1,
+};
+
 struct cdns_xspi_dev {
 	struct platform_device *pdev;
 	struct device *dev;
@@ -230,6 +235,7 @@ struct cdns_xspi_dev {
 	const void *out_buffer;
 
 	u8 hw_num_banks;
+	enum cdns_xspi_sdma_size read_size;
 };
 
 static int cdns_xspi_wait_for_controller_idle(struct cdns_xspi_dev *cdns_xspi)
@@ -329,6 +335,82 @@ static int cdns_xspi_controller_init(struct cdns_xspi_dev *cdns_xspi)
 	return 0;
 }
 
+static void cdns_ioreadq(void __iomem  *addr, void *buf, int len)
+{
+	int i = 0;
+	int rcount = len / 8;
+	int rcount_nf = len % 8;
+	uint64_t tmp;
+	uint64_t *buf64 = (uint64_t *)buf;
+
+	if (((uint64_t)buf % 8) == 0) {
+		for (i = 0; i < rcount; i++)
+			*buf64++ = readq(addr);
+	} else {
+		for (i = 0; i < rcount; i++) {
+			tmp = readq(addr);
+			memcpy(buf+(i*8), &tmp, 8);
+		}
+	}
+
+	if (rcount_nf != 0) {
+		tmp = readq(addr);
+		memcpy(buf+(i*8), &tmp, rcount_nf);
+	}
+}
+
+static void cdns_iowriteq(void __iomem *addr, const void *buf, int len)
+{
+	int i = 0;
+	int rcount = len / 8;
+	int rcount_nf = len % 8;
+	uint64_t tmp;
+	uint64_t *buf64 = (uint64_t *)buf;
+
+	if (((uint64_t)buf % 8) == 0) {
+		for (i = 0; i < rcount; i++)
+			writeq(*buf64++, addr);
+	} else {
+		for (i = 0; i < rcount; i++) {
+			memcpy(&tmp, buf+(i*8), 8);
+			writeq(tmp, addr);
+		}
+	}
+
+	if (rcount_nf != 0) {
+		memcpy(&tmp, buf+(i*8), rcount_nf);
+		writeq(tmp, addr);
+	}
+}
+
+static void cdns_xspi_sdma_memread(struct cdns_xspi_dev *cdns_xspi,
+				   enum cdns_xspi_sdma_size size, int len)
+{
+	switch (size) {
+	case CDNS_XSPI_SDMA_SIZE_8B:
+		ioread8_rep(cdns_xspi->sdmabase,
+			    cdns_xspi->in_buffer, len);
+		break;
+	case CDNS_XSPI_SDMA_SIZE_64B:
+		cdns_ioreadq(cdns_xspi->sdmabase, cdns_xspi->in_buffer, len);
+		break;
+	}
+}
+
+static void cdns_xspi_sdma_memwrite(struct cdns_xspi_dev *cdns_xspi,
+				    enum cdns_xspi_sdma_size size, int len)
+{
+	switch (size) {
+	case CDNS_XSPI_SDMA_SIZE_8B:
+		iowrite8_rep(cdns_xspi->sdmabase,
+			     cdns_xspi->out_buffer, len);
+		break;
+	case CDNS_XSPI_SDMA_SIZE_64B:
+		cdns_iowriteq(cdns_xspi->sdmabase, cdns_xspi->out_buffer, len);
+		break;
+	}
+}
+
 static void cdns_xspi_sdma_handle(struct cdns_xspi_dev *cdns_xspi)
 {
 	u32 sdma_size, sdma_trd_info;
@@ -340,13 +422,15 @@ static void cdns_xspi_sdma_handle(struct cdns_xspi_dev *cdns_xspi)
 
 	switch (sdma_dir) {
 	case CDNS_XSPI_SDMA_DIR_READ:
-		ioread8_rep(cdns_xspi->sdmabase,
-			    cdns_xspi->in_buffer, sdma_size);
+		cdns_xspi_sdma_memread(cdns_xspi,
+				       cdns_xspi->read_size,
+				       sdma_size);
 		break;
 
 	case CDNS_XSPI_SDMA_DIR_WRITE:
-		iowrite8_rep(cdns_xspi->sdmabase,
-			     cdns_xspi->out_buffer, sdma_size);
+		cdns_xspi_sdma_memwrite(cdns_xspi,
+					cdns_xspi->read_size,
+					sdma_size);
 		break;
 	}
 }
@@ -526,7 +610,14 @@ static int cdns_xspi_of_get_plat_data(struct platform_device *pdev)
 {
 	struct device_node *node_prop = pdev->dev.of_node;
 	struct device_node *node_child;
+	struct spi_master *master = platform_get_drvdata(pdev);
+	struct cdns_xspi_dev *cdns_xspi = spi_master_get_devdata(master);
 	unsigned int cs;
+	unsigned int read_size = 0;
+
+	if (of_property_read_u32(node_prop, "cdns,read-size", &read_size))
+		dev_info(&pdev->dev, "Missing read size property, usining byte access\n");
+	cdns_xspi->read_size = read_size;
 
 	for_each_child_of_node(node_prop, node_child) {
 		if (!of_device_is_available(node_child))
-- 
2.17.1

