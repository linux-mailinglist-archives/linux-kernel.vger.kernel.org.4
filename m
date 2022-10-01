Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 015A65F1C28
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Oct 2022 14:22:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229639AbiJAMWp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Oct 2022 08:22:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229657AbiJAMWb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Oct 2022 08:22:31 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2059.outbound.protection.outlook.com [40.107.94.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A34798261B;
        Sat,  1 Oct 2022 05:22:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KEsZ7y+FJL5WRiH8JqhIl85TrV5+IErz9Ou0j1h5uX3enZzbm7YVR5d9C2sCv3TuHCiDe8Y4LT00bft69U5yrxMWf3zZ8UYqP+jT7T5aZO0Zzm6qSf2HQPxaxGLDZJimiKJIuNOMo6rkSbnXSNj6RFIpDUg5L+YKg4DXgK+7T92QR93h1dHffV9jab1P3EG/obXjp2LTiNGgTdeEExNBHeBorq+m/ZDA24/jkv6m4d8/syWgx2FH62il4mI2bEmgKSRLrVDiH7SYfLfHmIzb8mYZwsAtbNL2YAbMkKC1RhPqIpt3s0W3EYGl4+QfzwS2J4hYuVP4f19ofnX9JQxzNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nYneFldGyERSULklzguxk8pqj7OenUpAAElEEjg7zLY=;
 b=IRd1qPnH9Qma2rXNAIojV4VGd5KrRp2cTf45XgUnaYLZzG4w0v1rqWZKXOLnuzPEB05Y3bKqqyM8Fo3nyfOnnc9Tm89/uRl5t0AUsQT4OC+j+Y+njARpR5ub1BS2j+EcYFv7UCHr5lx0wZ3zNMjpX5cm2OHxomiFKPTu4q8f6vtsKBYf+IlgnMp0QxLVSM61lnv9tV/ip3ME0JuCXPKN19q2wm5IsiT6RCUsSHDnw03h7NEWCbUQ4yMLcCd6fRCgwp++1lvq7p/FJe4FDjeUN+vpVZw4NuUlRRWPqamp8EzywM8Cv1r6/eVtIOHGazrhGYel+P6+GbJZIo8Pumpkfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nYneFldGyERSULklzguxk8pqj7OenUpAAElEEjg7zLY=;
 b=YWYxST96XDLAzctYY8Gtmx9gUuyYGhyhDRRkkFGiR0m7fMn9KSqa9lguQ2s2YHMsw9e3nlLN1YTipbPuOYatIRqF/BIeKvrIsZHXYQtInz67RP8xV/A1Xz2GQfVLoQPJucP7XUK2nRwqh+kMBsdqIJCP5T7SHazVzXkAZqfJ6MDIK8OpAkAQkDfZbeVLvaiME1OJXm3E2+j9f7dAPUvyXlJtc8omB3K4nHsGY4cumtuyaZBlIi8f4h6H9e7m2itx2dBhstXYwaCv3oqiQ4gKgcHQ/J1zxQL+Ho7DchBnamjdSqr8BDiwXd1QEzhSbyOP8xu9IR73v7P5WhUg4zKXmA==
Received: from BN9PR03CA0123.namprd03.prod.outlook.com (2603:10b6:408:fe::8)
 by MN2PR12MB4288.namprd12.prod.outlook.com (2603:10b6:208:1d2::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.24; Sat, 1 Oct
 2022 12:22:20 +0000
Received: from BN8NAM11FT034.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:fe:cafe::bf) by BN9PR03CA0123.outlook.office365.com
 (2603:10b6:408:fe::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.20 via Frontend
 Transport; Sat, 1 Oct 2022 12:22:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN8NAM11FT034.mail.protection.outlook.com (10.13.176.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5676.17 via Frontend Transport; Sat, 1 Oct 2022 12:22:19 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Sat, 1 Oct 2022
 05:22:09 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Sat, 1 Oct 2022
 05:22:09 -0700
Received: from BUILDSERVER-IO-L4T.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.986.29 via Frontend
 Transport; Sat, 1 Oct 2022 05:22:07 -0700
From:   Krishna Yarlagadda <kyarlagadda@nvidia.com>
To:     <broonie@kernel.org>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <linux-spi@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>
CC:     <skomatineni@nvidia.com>, <ldewangan@nvidia.com>,
        <linux-kernel@vger.kernel.org>,
        Krishna Yarlagadda <kyarlagadda@nvidia.com>
Subject: [PATCH 5/5] spi: tegra210-quad: native dma support
Date:   Sat, 1 Oct 2022 17:51:48 +0530
Message-ID: <20221001122148.9158-5-kyarlagadda@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221001122148.9158-1-kyarlagadda@nvidia.com>
References: <20221001122148.9158-1-kyarlagadda@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT034:EE_|MN2PR12MB4288:EE_
X-MS-Office365-Filtering-Correlation-Id: 137f52ce-a893-4f8e-8774-08daa3a7960f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1KE4961YMY0eftrKLI+KP3CFlwC6B2J/mFFqRwKSVFqXuVQRMVuNBJonFOlNEuGRzuYITc/cxvzk+bUosPwhc07rsqftQOkUXrR6bfQTmbgO38tYgutP+aI6+7FHfa1LRaggGJqnOEIq1Y/UHkAOcXdlR7Re1GXxwJ+08onYo8o+XVrtA+8f0XVb/oIpbHpjVxDreYFL0M/wk4yCHI7aHxxIFIJHPaPapfLCxku49uTMGZIid4PhgRx1KpVt9FeRDrJDdkEXqubBtGa6WYy41D5dz7HsT4Bf9L1FywdB2fcZXC4aqFoznix7HySHxx33nWJOZHCFBUMOs3gljAF5X9be2u/4MIcdFshe32ey2BTGeeR775RBw0qPKRaD9WSXdBALIJUeMF4AONgjYFHsJ5jvuT341fb9+eKoypP3lierqO9qrStfmMsssh1i5kh4vJvK5zTBx+XBCdfGO5SAyNBBphSukhTHNdQhOttuXeVGSeNanbE4xd4sDDtRCQfExpX3qtrMGVZLMmg9A6/Da1G4QHIbHcXNsyDPGYmhYQvGZ/+DOhUdBmBaCwCoxXtkj4CJwHCIPlnNbYuxneSNeS0fPlCBKpW63BIXHhukB4EPUeIikTS6mmvMna1N3sgWUFZP2N6cI1ej2eK75kErelq96OD+mh2msRmn6AEYimPJ5t9bSZ7tVn7eJx8ObLSTVeZQfIWEdfHEWItgniJ6VGYfxMoLLg8fxSofFSrpIE0zbrNK76neK6brnF3KjTmQ95r+YIVYIcfw52q6vaV7vQ==
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(376002)(396003)(39860400002)(346002)(136003)(451199015)(40470700004)(46966006)(36840700001)(478600001)(110136005)(54906003)(4326008)(8676002)(70206006)(70586007)(26005)(5660300002)(107886003)(6666004)(36756003)(82740400003)(186003)(1076003)(426003)(336012)(8936002)(41300700001)(2906002)(2616005)(7696005)(47076005)(36860700001)(86362001)(40460700003)(316002)(83380400001)(82310400005)(40480700001)(356005)(7636003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2022 12:22:19.6781
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 137f52ce-a893-4f8e-8774-08daa3a7960f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT034.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4288
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable Native DMA support for Tegra23 & Tegra24

Signed-off-by: Krishna Yarlagadda <kyarlagadda@nvidia.com>
---
 drivers/spi/spi-tegra210-quad.c | 136 +++++++++++++++++++++++---------
 1 file changed, 97 insertions(+), 39 deletions(-)

diff --git a/drivers/spi/spi-tegra210-quad.c b/drivers/spi/spi-tegra210-quad.c
index 99811509dafa..edecb999a614 100644
--- a/drivers/spi/spi-tegra210-quad.c
+++ b/drivers/spi/spi-tegra210-quad.c
@@ -111,6 +111,9 @@
 #define QSPI_DMA_BLK				0x024
 #define QSPI_DMA_BLK_SET(x)			(((x) & 0xffff) << 0)
 
+#define QSPI_DMA_MEM_ADDRESS_REG		0x028
+#define QSPI_DMA_HI_ADDRESS_REG			0x02c
+
 #define QSPI_TX_FIFO				0x108
 #define QSPI_RX_FIFO				0x188
 
@@ -155,6 +158,9 @@
 #define DATA_DIR_TX				BIT(0)
 #define DATA_DIR_RX				BIT(1)
 
+#define QSPI_DMA_EXT				BIT(0)
+#define QSPI_DMA_INT				BIT(1)
+
 #define QSPI_DMA_TIMEOUT			(msecs_to_jiffies(1000))
 #define DEFAULT_QSPI_DMA_BUF_LEN		(64 * 1024)
 #define CMD_TRANSFER				0
@@ -163,7 +169,7 @@
 #define DATA_TRANSFER				3
 
 struct tegra_qspi_soc_data {
-	bool has_dma;
+	int has_dma;
 	bool cmb_xfer_capable;
 	unsigned int cs_count;
 };
@@ -600,17 +606,22 @@ static void tegra_qspi_dma_unmap_xfer(struct tegra_qspi *tqspi, struct spi_trans
 
 	len = DIV_ROUND_UP(tqspi->curr_dma_words * tqspi->bytes_per_word, 4) * 4;
 
-	dma_unmap_single(tqspi->dev, t->tx_dma, len, DMA_TO_DEVICE);
-	dma_unmap_single(tqspi->dev, t->rx_dma, len, DMA_FROM_DEVICE);
+	if (t->tx_buf)
+		dma_unmap_single(tqspi->dev, t->tx_dma, len, DMA_TO_DEVICE);
+	if (t->rx_buf)
+		dma_unmap_single(tqspi->dev, t->rx_dma, len, DMA_FROM_DEVICE);
 }
 
 static int tegra_qspi_start_dma_based_transfer(struct tegra_qspi *tqspi, struct spi_transfer *t)
 {
 	struct dma_slave_config dma_sconfig = { 0 };
+	dma_addr_t rx_dma_phys, tx_dma_phys;
 	unsigned int len;
 	u8 dma_burst;
 	int ret = 0;
 	u32 val;
+	bool has_ext_dma = (tqspi->soc_data->has_dma &
+			    QSPI_DMA_EXT) ? true : false;
 
 	if (tqspi->is_packed) {
 		ret = tegra_qspi_dma_map_xfer(tqspi, t);
@@ -629,23 +640,35 @@ static int tegra_qspi_start_dma_based_transfer(struct tegra_qspi *tqspi, struct
 		len = tqspi->curr_dma_words * 4;
 
 	/* set attention level based on length of transfer */
-	val = 0;
-	if (len & 0xf) {
-		val |= QSPI_TX_TRIG_1 | QSPI_RX_TRIG_1;
-		dma_burst = 1;
-	} else if (((len) >> 4) & 0x1) {
-		val |= QSPI_TX_TRIG_4 | QSPI_RX_TRIG_4;
-		dma_burst = 4;
-	} else {
-		val |= QSPI_TX_TRIG_8 | QSPI_RX_TRIG_8;
-		dma_burst = 8;
+	if (has_ext_dma) {
+		val = 0;
+		if (len & 0xf) {
+			val |= QSPI_TX_TRIG_1 | QSPI_RX_TRIG_1;
+			dma_burst = 1;
+		} else if (((len) >> 4) & 0x1) {
+			val |= QSPI_TX_TRIG_4 | QSPI_RX_TRIG_4;
+			dma_burst = 4;
+		} else {
+			val |= QSPI_TX_TRIG_8 | QSPI_RX_TRIG_8;
+			dma_burst = 8;
+		}
 	}
 
 	tegra_qspi_writel(tqspi, val, QSPI_DMA_CTL);
 	tqspi->dma_control_reg = val;
 
 	dma_sconfig.device_fc = true;
-	if (tqspi->cur_direction & DATA_DIR_TX) {
+	if ((tqspi->cur_direction & DATA_DIR_TX) && !has_ext_dma) {
+		if (tqspi->is_packed)
+			tx_dma_phys = t->tx_dma;
+		else
+			tx_dma_phys = tqspi->tx_dma_phys;
+		tegra_qspi_copy_client_txbuf_to_qspi_txbuf(tqspi, t);
+		tegra_qspi_writel(tqspi, (tx_dma_phys & 0xffffffff),
+				  QSPI_DMA_MEM_ADDRESS_REG);
+		tegra_qspi_writel(tqspi, ((tx_dma_phys >> 32) & 0xff),
+				  QSPI_DMA_HI_ADDRESS_REG);
+	} else if ((tqspi->cur_direction & DATA_DIR_TX) && has_ext_dma) {
 		dma_sconfig.dst_addr = tqspi->phys + QSPI_TX_FIFO;
 		dma_sconfig.dst_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
 		dma_sconfig.dst_maxburst = dma_burst;
@@ -663,7 +686,16 @@ static int tegra_qspi_start_dma_based_transfer(struct tegra_qspi *tqspi, struct
 		}
 	}
 
-	if (tqspi->cur_direction & DATA_DIR_RX) {
+	if ((tqspi->cur_direction & DATA_DIR_RX) && !has_ext_dma) {
+		if (tqspi->is_packed)
+			rx_dma_phys = t->rx_dma;
+		else
+			rx_dma_phys = tqspi->rx_dma_phys;
+		tegra_qspi_writel(tqspi, (rx_dma_phys & 0xffffffff),
+				  QSPI_DMA_MEM_ADDRESS_REG);
+		tegra_qspi_writel(tqspi, ((rx_dma_phys >> 32) & 0xff),
+				  QSPI_DMA_HI_ADDRESS_REG);
+	} else if ((tqspi->cur_direction & DATA_DIR_RX) && has_ext_dma) {
 		dma_sconfig.src_addr = tqspi->phys + QSPI_RX_FIFO;
 		dma_sconfig.src_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
 		dma_sconfig.src_maxburst = dma_burst;
@@ -751,13 +783,29 @@ static int tegra_qspi_init_dma(struct tegra_qspi *tqspi)
 	u32 *dma_buf;
 	int err;
 
-	dma_chan = dma_request_chan(tqspi->dev, "rx");
-	if (IS_ERR(dma_chan)) {
-		err = PTR_ERR(dma_chan);
-		goto err_out;
-	}
+	if (!tqspi->soc_data->has_dma)
+		return -ENODEV;
+
+	if (tqspi->soc_data->has_dma & QSPI_DMA_EXT) {
+		dma_chan = dma_request_chan(tqspi->dev, "rx");
+		if (IS_ERR(dma_chan)) {
+			err = PTR_ERR(dma_chan);
+			goto err_out;
+		}
 
-	tqspi->rx_dma_chan = dma_chan;
+		tqspi->rx_dma_chan = dma_chan;
+
+		dma_chan = dma_request_chan(tqspi->dev, "tx");
+		if (IS_ERR(dma_chan)) {
+			err = PTR_ERR(dma_chan);
+			goto err_out;
+		}
+
+		tqspi->tx_dma_chan = dma_chan;
+	} else {
+		tqspi->rx_dma_chan = NULL;
+		tqspi->tx_dma_chan = NULL;
+	}
 
 	dma_buf = dma_alloc_coherent(tqspi->dev, tqspi->dma_buf_size, &dma_phys, GFP_KERNEL);
 	if (!dma_buf) {
@@ -768,14 +816,6 @@ static int tegra_qspi_init_dma(struct tegra_qspi *tqspi)
 	tqspi->rx_dma_buf = dma_buf;
 	tqspi->rx_dma_phys = dma_phys;
 
-	dma_chan = dma_request_chan(tqspi->dev, "tx");
-	if (IS_ERR(dma_chan)) {
-		err = PTR_ERR(dma_chan);
-		goto err_out;
-	}
-
-	tqspi->tx_dma_chan = dma_chan;
-
 	dma_buf = dma_alloc_coherent(tqspi->dev, tqspi->dma_buf_size, &dma_phys, GFP_KERNEL);
 	if (!dma_buf) {
 		err = -ENOMEM;
@@ -1045,6 +1085,8 @@ static int tegra_qspi_combined_seq_xfer(struct tegra_qspi *tqspi,
 					struct spi_message *msg)
 {
 	bool is_first_msg = true;
+	bool has_ext_dma = (tqspi->soc_data->has_dma &
+			    QSPI_DMA_EXT) ? true : false;
 	struct spi_transfer *xfer;
 	struct spi_device *spi = msg->spi;
 	u8 transfer_phase = 0;
@@ -1109,12 +1151,12 @@ static int tegra_qspi_combined_seq_xfer(struct tegra_qspi *tqspi,
 			if (WARN_ON(ret == 0)) {
 				dev_err(tqspi->dev, "QSPI Transfer failed with timeout: %d\n",
 					ret);
-				if (tqspi->is_curr_dma_xfer &&
+				if (tqspi->is_curr_dma_xfer && has_ext_dma &&
 				    (tqspi->cur_direction & DATA_DIR_TX))
 					dmaengine_terminate_all
 						(tqspi->tx_dma_chan);
 
-				if (tqspi->is_curr_dma_xfer &&
+				if (tqspi->is_curr_dma_xfer && has_ext_dma &&
 				    (tqspi->cur_direction & DATA_DIR_RX))
 					dmaengine_terminate_all
 						(tqspi->rx_dma_chan);
@@ -1178,6 +1220,8 @@ static int tegra_qspi_non_combined_seq_xfer(struct tegra_qspi *tqspi,
 	struct spi_device *spi = msg->spi;
 	struct spi_transfer *transfer;
 	bool is_first_msg = true;
+	bool has_ext_dma = (tqspi->soc_data->has_dma &
+			    QSPI_DMA_EXT) ? true : false;
 	int ret = 0, val = 0;
 
 	msg->status = 0;
@@ -1230,9 +1274,11 @@ static int tegra_qspi_non_combined_seq_xfer(struct tegra_qspi *tqspi,
 						  QSPI_DMA_TIMEOUT);
 		if (WARN_ON(ret == 0)) {
 			dev_err(tqspi->dev, "transfer timeout\n");
-			if (tqspi->is_curr_dma_xfer && (tqspi->cur_direction & DATA_DIR_TX))
+			if (tqspi->is_curr_dma_xfer && has_ext_dma &&
+			    (tqspi->cur_direction & DATA_DIR_TX))
 				dmaengine_terminate_all(tqspi->tx_dma_chan);
-			if (tqspi->is_curr_dma_xfer && (tqspi->cur_direction & DATA_DIR_RX))
+			if (tqspi->is_curr_dma_xfer && has_ext_dma &&
+			    (tqspi->cur_direction & DATA_DIR_RX))
 				dmaengine_terminate_all(tqspi->rx_dma_chan);
 			tegra_qspi_handle_error(tqspi);
 			ret = -EIO;
@@ -1365,8 +1411,20 @@ static irqreturn_t handle_dma_based_xfer(struct tegra_qspi *tqspi)
 	unsigned long flags;
 	long wait_status;
 	int err = 0;
+	bool has_ext_dma = (tqspi->soc_data->has_dma &
+			    QSPI_DMA_EXT) ? true : false;
+
+	if (tqspi->cur_direction & DATA_DIR_TX && !has_ext_dma) {
+		if (tqspi->tx_status)
+			err += 1;
+	}
+
+	if (tqspi->cur_direction & DATA_DIR_RX && !has_ext_dma) {
+		if (tqspi->rx_status)
+			err += 2;
+	}
 
-	if (tqspi->cur_direction & DATA_DIR_TX) {
+	if (tqspi->cur_direction & DATA_DIR_TX && has_ext_dma) {
 		if (tqspi->tx_status) {
 			dmaengine_terminate_all(tqspi->tx_dma_chan);
 			err += 1;
@@ -1381,7 +1439,7 @@ static irqreturn_t handle_dma_based_xfer(struct tegra_qspi *tqspi)
 		}
 	}
 
-	if (tqspi->cur_direction & DATA_DIR_RX) {
+	if (tqspi->cur_direction & DATA_DIR_RX && has_ext_dma) {
 		if (tqspi->rx_status) {
 			dmaengine_terminate_all(tqspi->rx_dma_chan);
 			err += 2;
@@ -1454,25 +1512,25 @@ static irqreturn_t tegra_qspi_isr_thread(int irq, void *context_data)
 }
 
 static struct tegra_qspi_soc_data tegra210_qspi_soc_data = {
-	.has_dma = true,
+	.has_dma = QSPI_DMA_EXT,
 	.cmb_xfer_capable = false,
 	.cs_count = 1,
 };
 
 static struct tegra_qspi_soc_data tegra186_qspi_soc_data = {
-	.has_dma = true,
+	.has_dma = QSPI_DMA_EXT,
 	.cmb_xfer_capable = true,
 	.cs_count = 1,
 };
 
 static struct tegra_qspi_soc_data tegra234_qspi_soc_data = {
-	.has_dma = false,
+	.has_dma = QSPI_DMA_INT,
 	.cmb_xfer_capable = true,
 	.cs_count = 1,
 };
 
 static struct tegra_qspi_soc_data tegra241_qspi_soc_data = {
-	.has_dma = false,
+	.has_dma = QSPI_DMA_INT,
 	.cmb_xfer_capable = true,
 	.cs_count = 4,
 };
-- 
2.17.1

