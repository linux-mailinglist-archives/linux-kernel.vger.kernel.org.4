Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E964F6E6649
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 15:47:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232297AbjDRNre (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 09:47:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232374AbjDRNr0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 09:47:26 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2062.outbound.protection.outlook.com [40.107.220.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1900586B6;
        Tue, 18 Apr 2023 06:47:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I64dJU0rURSLHxsvc3DzLpd8OiYC5EPiCn1tKCj4gzknzPYS+OOPtcNcwjN6FO9iOmuKm/DR43hqDqM8wjI/Yk0kAcvHmqCTk3M5Q6u3nFxoHxgU+U1gfb2w+vWBFw/KIiXM3WlS3sEYFqTd5hQ+l/cRE6+Dd92j27BRuRHj8d2egHIG65fkdbQsFL0xIgzlAJ7UiVt4m6n1GMQMHRHbM3uXmUxAym48AhE2/yRcBGyjdDaAPZbzRWYsERZqq0T/raewBleScWsJz91kJdLyTuwQdD2DiZmOEF4pVBFWZoAKeApFctr1jtYVAFUZ0iDtAX78Bf61UMnfM8Jn51KTRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9g8YZbuYRdnBoUxiKuhyUAmL9+LLI/mBNycirPUi0Yk=;
 b=nKHDex9BrzqIlbOohZH7K0uuyv48IYsfmkUvA2RyydLfGmwleeni+FY+DVcXnDLRTEpIe2EUvEj0H8CMAxytdwzX2EBfTIQeNAGfhZvb1Bcn+1Q1UZbQ7ZJEDdqExeDgUaR7DpDbladhb98i94WyQKHKxtf0pRP2xH0GnjYXFMIAxxaHWqaiFNBf12eibvUKyX27c0z6YrtHvzuee4glOJzXkeYd6BK+65Ghwyn70Kfx6fsQnvUR+u3RgZjOvfklR3jpVsgngUBck0gurctKKh+O2ixMkz5NJ8nXJYNqNAv53/SlbEfjpB1T/nHF73Y9t+7Qi/MYnSHaIu7n8f3xog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9g8YZbuYRdnBoUxiKuhyUAmL9+LLI/mBNycirPUi0Yk=;
 b=UbIwagdlN4kDLwGDXzxxnmfB7f2iBaipJz07wDQc8Qi4fTlw7NcG25yLDcDLioWwdSn9P2s4Zr1/iA08VGwfhmEv+CeGneCyZTjHu0FLHIz/hw+3ck9UdAFO8rsyWS4Y2DA18vpcloD0RsjWKL3SPI9MPfVOpvLh0O0Ol+tE++w=
Received: from MN2PR15CA0052.namprd15.prod.outlook.com (2603:10b6:208:237::21)
 by MN0PR12MB5785.namprd12.prod.outlook.com (2603:10b6:208:374::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.45; Tue, 18 Apr
 2023 13:47:18 +0000
Received: from BL02EPF000145B8.namprd05.prod.outlook.com
 (2603:10b6:208:237:cafe::25) by MN2PR15CA0052.outlook.office365.com
 (2603:10b6:208:237::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.47 via Frontend
 Transport; Tue, 18 Apr 2023 13:47:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BL02EPF000145B8.mail.protection.outlook.com (10.167.241.208) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6319.16 via Frontend Transport; Tue, 18 Apr 2023 13:47:18 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 18 Apr
 2023 08:47:12 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 18 Apr
 2023 06:47:12 -0700
Received: from xhdvnc205.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Tue, 18 Apr 2023 08:47:10 -0500
From:   Srinivas Goud <srinivas.goud@amd.com>
To:     <broonie@kernel.org>
CC:     <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <git@amd.com>, <gcnu.goud@gmail.com>,
        Srinivas Goud <srinivas.goud@amd.com>
Subject: [PATCH v2 1/2] spi: spi-cadence: Switch to spi_controller structure
Date:   Tue, 18 Apr 2023 19:17:04 +0530
Message-ID: <1681825625-10265-2-git-send-email-srinivas.goud@amd.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1681825625-10265-1-git-send-email-srinivas.goud@amd.com>
References: <1681825625-10265-1-git-send-email-srinivas.goud@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF000145B8:EE_|MN0PR12MB5785:EE_
X-MS-Office365-Filtering-Correlation-Id: cc60f045-a6ba-4e9f-857e-08db40136d86
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2sotCwiOColZ8aUxfNzsyBzi2C4R/erz0DE6M11P4SETWFisgv5SvV172KOQG61qtMGCt/tO6Go0iYAq3huMYRFSs6WOC+LY67jqMkOjcwCsf/YQahGcAR3s8BAUPCgCuaibmss802Vme86KnlJ8EjDLMWMX5iudxdHww61z5pkOJn+hZbPqSc+NHvvVhMZ/QxP5e3X7oL7OcjDOxNiXpAL8kh0maCGjXhGfshfAdDcUDzpH8kLl+ZnQZs14sTbNfQEsEeAokTnJ7/MN6tjv3msqRwgpTg01x3EXAHhL8/660M878ktjIEiwCkPAbWRLmwcdmLa1nAAy3O3u3mqf24wQlBopjBFzdKVmgzOfVE56gqBLixNdocRL4vyT6lQuCbhWK0uGxpYaJy3hx33vw/oJcXDG+FdNUmr8gyUnkqz3S4c0IphsFXPcADg3tBhqj/CMeTG9gR1kbfk/hAZpLxRzBA2XFNy4c/3uIWkUdwWp+Yo0i0nKC72CsMqPRVKyEo0Qki7zKx+ksIji9rC+UeH2KmyrpWa5ss2jgj44N70L0L53OiET96w3Xr0hfHtA2+VqyrIpgvWECzgh6SVt5BhP9oX9Wyj2b4xQSLq5flOsgZ2trQ0KQHdYqI9eo8ShDGoP8V22UK6nbVPW6gPRBS64ILpgf0mshqDRLiN+D34QDK6J2RoFKemfQdMmek2Uj9XL0GdRADy3+c34/XOZDDIz/WgA2tbWYzhd98qrsbw=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(136003)(376002)(346002)(451199021)(46966006)(36840700001)(40470700004)(478600001)(6666004)(8936002)(8676002)(316002)(41300700001)(82740400003)(6916009)(4326008)(70586007)(70206006)(40480700001)(81166007)(54906003)(356005)(40460700003)(186003)(30864003)(2906002)(336012)(426003)(26005)(86362001)(83380400001)(36756003)(47076005)(82310400005)(2616005)(36860700001)(5660300002)(44832011)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2023 13:47:18.8677
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cc60f045-a6ba-4e9f-857e-08db40136d86
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF000145B8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5785
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

Replace spi_master structure with spi_controller structure.
spi_controller structure provides interface support for
both SPI master and slave controller.

Signed-off-by: Srinivas Goud <srinivas.goud@amd.com>
---
 drivers/spi/spi-cadence.c | 116 +++++++++++++++++++++++-----------------------
 1 file changed, 58 insertions(+), 58 deletions(-)

diff --git a/drivers/spi/spi-cadence.c b/drivers/spi/spi-cadence.c
index 4993623..99cebe1 100644
--- a/drivers/spi/spi-cadence.c
+++ b/drivers/spi/spi-cadence.c
@@ -173,7 +173,7 @@ static void cdns_spi_init_hw(struct cdns_spi *xspi)
  */
 static void cdns_spi_chipselect(struct spi_device *spi, bool is_high)
 {
-	struct cdns_spi *xspi = spi_master_get_devdata(spi->master);
+	struct cdns_spi *xspi = spi_controller_get_devdata(spi->controller);
 	u32 ctrl_reg;
 
 	ctrl_reg = cdns_spi_read(xspi, CDNS_SPI_CR);
@@ -204,7 +204,7 @@ static void cdns_spi_chipselect(struct spi_device *spi, bool is_high)
  */
 static void cdns_spi_config_clock_mode(struct spi_device *spi)
 {
-	struct cdns_spi *xspi = spi_master_get_devdata(spi->master);
+	struct cdns_spi *xspi = spi_controller_get_devdata(spi->controller);
 	u32 ctrl_reg, new_ctrl_reg;
 
 	new_ctrl_reg = cdns_spi_read(xspi, CDNS_SPI_CR);
@@ -247,7 +247,7 @@ static void cdns_spi_config_clock_mode(struct spi_device *spi)
 static void cdns_spi_config_clock_freq(struct spi_device *spi,
 				       struct spi_transfer *transfer)
 {
-	struct cdns_spi *xspi = spi_master_get_devdata(spi->master);
+	struct cdns_spi *xspi = spi_controller_get_devdata(spi->controller);
 	u32 ctrl_reg, baud_rate_val;
 	unsigned long frequency;
 
@@ -285,7 +285,7 @@ static void cdns_spi_config_clock_freq(struct spi_device *spi,
 static int cdns_spi_setup_transfer(struct spi_device *spi,
 				   struct spi_transfer *transfer)
 {
-	struct cdns_spi *xspi = spi_master_get_devdata(spi->master);
+	struct cdns_spi *xspi = spi_controller_get_devdata(spi->controller);
 
 	cdns_spi_config_clock_freq(spi, transfer);
 
@@ -340,8 +340,8 @@ static void cdns_spi_fill_tx_fifo(struct cdns_spi *xspi)
  */
 static irqreturn_t cdns_spi_irq(int irq, void *dev_id)
 {
-	struct spi_master *master = dev_id;
-	struct cdns_spi *xspi = spi_master_get_devdata(master);
+	struct spi_controller *ctlr = dev_id;
+	struct cdns_spi *xspi = spi_controller_get_devdata(ctlr);
 	irqreturn_t status;
 	u32 intr_status;
 
@@ -355,7 +355,7 @@ static irqreturn_t cdns_spi_irq(int irq, void *dev_id)
 		 * transferred is non-zero
 		 */
 		cdns_spi_write(xspi, CDNS_SPI_IDR, CDNS_SPI_IXR_DEFAULT);
-		spi_finalize_current_transfer(master);
+		spi_finalize_current_transfer(ctlr);
 		status = IRQ_HANDLED;
 	} else if (intr_status & CDNS_SPI_IXR_TXOW) {
 		unsigned long trans_cnt;
@@ -381,7 +381,7 @@ static irqreturn_t cdns_spi_irq(int irq, void *dev_id)
 			/* Transfer is completed */
 			cdns_spi_write(xspi, CDNS_SPI_IDR,
 				       CDNS_SPI_IXR_DEFAULT);
-			spi_finalize_current_transfer(master);
+			spi_finalize_current_transfer(ctlr);
 		}
 		status = IRQ_HANDLED;
 	}
@@ -389,7 +389,7 @@ static irqreturn_t cdns_spi_irq(int irq, void *dev_id)
 	return status;
 }
 
-static int cdns_prepare_message(struct spi_master *master,
+static int cdns_prepare_message(struct spi_controller *ctlr,
 				struct spi_message *msg)
 {
 	cdns_spi_config_clock_mode(msg->spi);
@@ -398,7 +398,7 @@ static int cdns_prepare_message(struct spi_master *master,
 
 /**
  * cdns_transfer_one - Initiates the SPI transfer
- * @master:	Pointer to spi_master structure
+ * @ctlr:	Pointer to spi_controller structure
  * @spi:	Pointer to the spi_device structure
  * @transfer:	Pointer to the spi_transfer structure which provides
  *		information about next transfer parameters
@@ -408,11 +408,11 @@ static int cdns_prepare_message(struct spi_master *master,
  *
  * Return:	Number of bytes transferred in the last transfer
  */
-static int cdns_transfer_one(struct spi_master *master,
+static int cdns_transfer_one(struct spi_controller *ctlr,
 			     struct spi_device *spi,
 			     struct spi_transfer *transfer)
 {
-	struct cdns_spi *xspi = spi_master_get_devdata(master);
+	struct cdns_spi *xspi = spi_controller_get_devdata(ctlr);
 
 	xspi->txbuf = transfer->tx_buf;
 	xspi->rxbuf = transfer->rx_buf;
@@ -429,16 +429,16 @@ static int cdns_transfer_one(struct spi_master *master,
 
 /**
  * cdns_prepare_transfer_hardware - Prepares hardware for transfer.
- * @master:	Pointer to the spi_master structure which provides
+ * @ctlr:	Pointer to the spi_controller structure which provides
  *		information about the controller.
  *
  * This function enables SPI master controller.
  *
  * Return:	0 always
  */
-static int cdns_prepare_transfer_hardware(struct spi_master *master)
+static int cdns_prepare_transfer_hardware(struct spi_controller *ctlr)
 {
-	struct cdns_spi *xspi = spi_master_get_devdata(master);
+	struct cdns_spi *xspi = spi_controller_get_devdata(ctlr);
 
 	cdns_spi_write(xspi, CDNS_SPI_ER, CDNS_SPI_ER_ENABLE);
 
@@ -447,16 +447,16 @@ static int cdns_prepare_transfer_hardware(struct spi_master *master)
 
 /**
  * cdns_unprepare_transfer_hardware - Relaxes hardware after transfer
- * @master:	Pointer to the spi_master structure which provides
+ * @ctlr:	Pointer to the spi_controller structure which provides
  *		information about the controller.
  *
  * This function disables the SPI master controller when no slave selected.
  *
  * Return:	0 always
  */
-static int cdns_unprepare_transfer_hardware(struct spi_master *master)
+static int cdns_unprepare_transfer_hardware(struct spi_controller *ctlr)
 {
-	struct cdns_spi *xspi = spi_master_get_devdata(master);
+	struct cdns_spi *xspi = spi_controller_get_devdata(ctlr);
 	u32 ctrl_reg;
 
 	/* Disable the SPI if slave is deselected */
@@ -497,42 +497,42 @@ static void cdns_spi_detect_fifo_depth(struct cdns_spi *xspi)
 static int cdns_spi_probe(struct platform_device *pdev)
 {
 	int ret = 0, irq;
-	struct spi_master *master;
+	struct spi_controller *ctlr;
 	struct cdns_spi *xspi;
 	u32 num_cs;
 
-	master = spi_alloc_master(&pdev->dev, sizeof(*xspi));
-	if (!master)
+	ctlr = spi_alloc_master(&pdev->dev, sizeof(*xspi));
+	if (!ctlr)
 		return -ENOMEM;
 
-	xspi = spi_master_get_devdata(master);
-	master->dev.of_node = pdev->dev.of_node;
-	platform_set_drvdata(pdev, master);
+	xspi = spi_controller_get_devdata(ctlr);
+	ctlr->dev.of_node = pdev->dev.of_node;
+	platform_set_drvdata(pdev, ctlr);
 
 	xspi->regs = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(xspi->regs)) {
 		ret = PTR_ERR(xspi->regs);
-		goto remove_master;
+		goto remove_ctlr;
 	}
 
 	xspi->pclk = devm_clk_get(&pdev->dev, "pclk");
 	if (IS_ERR(xspi->pclk)) {
 		dev_err(&pdev->dev, "pclk clock not found.\n");
 		ret = PTR_ERR(xspi->pclk);
-		goto remove_master;
+		goto remove_ctlr;
 	}
 
 	xspi->ref_clk = devm_clk_get(&pdev->dev, "ref_clk");
 	if (IS_ERR(xspi->ref_clk)) {
 		dev_err(&pdev->dev, "ref_clk clock not found.\n");
 		ret = PTR_ERR(xspi->ref_clk);
-		goto remove_master;
+		goto remove_ctlr;
 	}
 
 	ret = clk_prepare_enable(xspi->pclk);
 	if (ret) {
 		dev_err(&pdev->dev, "Unable to enable APB clock.\n");
-		goto remove_master;
+		goto remove_ctlr;
 	}
 
 	ret = clk_prepare_enable(xspi->ref_clk);
@@ -549,9 +549,9 @@ static int cdns_spi_probe(struct platform_device *pdev)
 
 	ret = of_property_read_u32(pdev->dev.of_node, "num-cs", &num_cs);
 	if (ret < 0)
-		master->num_chipselect = CDNS_SPI_DEFAULT_NUM_CS;
+		ctlr->num_chipselect = CDNS_SPI_DEFAULT_NUM_CS;
 	else
-		master->num_chipselect = num_cs;
+		ctlr->num_chipselect = num_cs;
 
 	ret = of_property_read_u32(pdev->dev.of_node, "is-decoded-cs",
 				   &xspi->is_decoded_cs);
@@ -570,35 +570,35 @@ static int cdns_spi_probe(struct platform_device *pdev)
 	}
 
 	ret = devm_request_irq(&pdev->dev, irq, cdns_spi_irq,
-			       0, pdev->name, master);
+			       0, pdev->name, ctlr);
 	if (ret != 0) {
 		ret = -ENXIO;
 		dev_err(&pdev->dev, "request_irq failed\n");
 		goto clk_dis_all;
 	}
 
-	master->use_gpio_descriptors = true;
-	master->prepare_transfer_hardware = cdns_prepare_transfer_hardware;
-	master->prepare_message = cdns_prepare_message;
-	master->transfer_one = cdns_transfer_one;
-	master->unprepare_transfer_hardware = cdns_unprepare_transfer_hardware;
-	master->set_cs = cdns_spi_chipselect;
-	master->auto_runtime_pm = true;
-	master->mode_bits = SPI_CPOL | SPI_CPHA | SPI_CS_HIGH;
+	ctlr->use_gpio_descriptors = true;
+	ctlr->prepare_transfer_hardware = cdns_prepare_transfer_hardware;
+	ctlr->prepare_message = cdns_prepare_message;
+	ctlr->transfer_one = cdns_transfer_one;
+	ctlr->unprepare_transfer_hardware = cdns_unprepare_transfer_hardware;
+	ctlr->set_cs = cdns_spi_chipselect;
+	ctlr->auto_runtime_pm = true;
+	ctlr->mode_bits = SPI_CPOL | SPI_CPHA | SPI_CS_HIGH;
 
 	xspi->clk_rate = clk_get_rate(xspi->ref_clk);
 	/* Set to default valid value */
-	master->max_speed_hz = xspi->clk_rate / 4;
-	xspi->speed_hz = master->max_speed_hz;
+	ctlr->max_speed_hz = xspi->clk_rate / 4;
+	xspi->speed_hz = ctlr->max_speed_hz;
 
-	master->bits_per_word_mask = SPI_BPW_MASK(8);
+	ctlr->bits_per_word_mask = SPI_BPW_MASK(8);
 
 	pm_runtime_mark_last_busy(&pdev->dev);
 	pm_runtime_put_autosuspend(&pdev->dev);
 
-	ret = spi_register_master(master);
+	ret = spi_register_controller(ctlr);
 	if (ret) {
-		dev_err(&pdev->dev, "spi_register_master failed\n");
+		dev_err(&pdev->dev, "spi_register_controller failed\n");
 		goto clk_dis_all;
 	}
 
@@ -610,8 +610,8 @@ static int cdns_spi_probe(struct platform_device *pdev)
 	clk_disable_unprepare(xspi->ref_clk);
 clk_dis_apb:
 	clk_disable_unprepare(xspi->pclk);
-remove_master:
-	spi_master_put(master);
+remove_ctlr:
+	spi_controller_put(ctlr);
 	return ret;
 }
 
@@ -627,8 +627,8 @@ static int cdns_spi_probe(struct platform_device *pdev)
  */
 static void cdns_spi_remove(struct platform_device *pdev)
 {
-	struct spi_master *master = platform_get_drvdata(pdev);
-	struct cdns_spi *xspi = spi_master_get_devdata(master);
+	struct spi_controller *ctlr = platform_get_drvdata(pdev);
+	struct cdns_spi *xspi = spi_controller_get_devdata(ctlr);
 
 	cdns_spi_write(xspi, CDNS_SPI_ER, CDNS_SPI_ER_DISABLE);
 
@@ -637,7 +637,7 @@ static void cdns_spi_remove(struct platform_device *pdev)
 	pm_runtime_set_suspended(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
 
-	spi_unregister_master(master);
+	spi_unregister_controller(ctlr);
 }
 
 /**
@@ -651,9 +651,9 @@ static void cdns_spi_remove(struct platform_device *pdev)
  */
 static int __maybe_unused cdns_spi_suspend(struct device *dev)
 {
-	struct spi_master *master = dev_get_drvdata(dev);
+	struct spi_controller *ctlr = dev_get_drvdata(dev);
 
-	return spi_master_suspend(master);
+	return spi_controller_suspend(ctlr);
 }
 
 /**
@@ -666,11 +666,11 @@ static int __maybe_unused cdns_spi_suspend(struct device *dev)
  */
 static int __maybe_unused cdns_spi_resume(struct device *dev)
 {
-	struct spi_master *master = dev_get_drvdata(dev);
-	struct cdns_spi *xspi = spi_master_get_devdata(master);
+	struct spi_controller *ctlr = dev_get_drvdata(dev);
+	struct cdns_spi *xspi = spi_controller_get_devdata(ctlr);
 
 	cdns_spi_init_hw(xspi);
-	return spi_master_resume(master);
+	return spi_controller_resume(ctlr);
 }
 
 /**
@@ -683,8 +683,8 @@ static int __maybe_unused cdns_spi_resume(struct device *dev)
  */
 static int __maybe_unused cdns_spi_runtime_resume(struct device *dev)
 {
-	struct spi_master *master = dev_get_drvdata(dev);
-	struct cdns_spi *xspi = spi_master_get_devdata(master);
+	struct spi_controller *ctlr = dev_get_drvdata(dev);
+	struct cdns_spi *xspi = spi_controller_get_devdata(ctlr);
 	int ret;
 
 	ret = clk_prepare_enable(xspi->pclk);
@@ -712,8 +712,8 @@ static int __maybe_unused cdns_spi_runtime_resume(struct device *dev)
  */
 static int __maybe_unused cdns_spi_runtime_suspend(struct device *dev)
 {
-	struct spi_master *master = dev_get_drvdata(dev);
-	struct cdns_spi *xspi = spi_master_get_devdata(master);
+	struct spi_controller *ctlr = dev_get_drvdata(dev);
+	struct cdns_spi *xspi = spi_controller_get_devdata(ctlr);
 
 	clk_disable_unprepare(xspi->ref_clk);
 	clk_disable_unprepare(xspi->pclk);
-- 
2.1.1

