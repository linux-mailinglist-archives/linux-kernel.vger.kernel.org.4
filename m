Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B85A65FACA4
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 08:21:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229805AbiJKGVs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 02:21:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229821AbiJKGV1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 02:21:27 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2072.outbound.protection.outlook.com [40.107.244.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EC4F88DE3;
        Mon, 10 Oct 2022 23:21:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IqAp2uoH//XXVdJ9siCUIEq0ig4/LG8CqqIJG9th6WGucBfF8t5zpbHgPNJJMkbTiSN/HnfgwoDZtUCTg35rlC4QcVUQFMkHKspPbGiOzQCykZeMs3EDBvau2x1b1AZFaX+xm1Vh9VBjTdGrqwixn2noPRyWm07vOpR6/PLgvD6+KunHgXGDxGmmTsh9k1Ic8Di+RPqtAgg2Tru7JeD3wzZWJAoy0D35lq7EnW/sItJeUWf1XYLro+th8Z1rlVVagSyjPwNXm/Uh6qxpqUqgXaLz0enc/nUinZq6K0m4ZpNyOcUMM4c9Oe1W6yBFl7hpk4o9xCtMp9hQ3MWdKKF1Mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kcfZQjDxX4XdkBG74CPK2inNidp7/XDLVonjtd7Wed8=;
 b=CBIsNBDMFSCjRzumeE6J6xkdxR1vUmyBh2pmsgeXIF56cLv5aacm/MjCD08e1moXWk9W2kmnQNMdowDu6D1bnm96P1J1dUp0ReKObGcEMv+pOHKR6y/5U/496ISYFKAReLgXa53+++uLL4nvs7VGdzR0v0HnQBqHo8k973H+WxZASYLeTC/bn3KOAVJekTXeQ/JfPaDGGR7RnyzfWmq3XVYjWaZ1YyiNrpHDiRgtn90D+eUBqOMpocaN8feERSc+4VEFuOEkdK+A0Svwi2UD4LU2WyYfLSr94qZhIFM8PJ77H74mIgsBwOyub1BWSJ282Z+RiazpqSOifj9yK0ghtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kcfZQjDxX4XdkBG74CPK2inNidp7/XDLVonjtd7Wed8=;
 b=t6jTlhR8Ltbe8aLGcvtBQWBoq2FIyfE4BV3Qjo7epjzDNZfAPez8Yi0TnO3S3sSkmuUjbmwn+WOsvWfKTjHPp32RvOGcjaCpuarrNsrFlWHJ22SeBrfKndXIVl237sJbz8esv2qBZ87mHQ5XE95U3ZrhHZk1PiVKzrbKIgNp0Qg=
Received: from BN0PR04CA0006.namprd04.prod.outlook.com (2603:10b6:408:ee::11)
 by CY8PR12MB7147.namprd12.prod.outlook.com (2603:10b6:930:5d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.19; Tue, 11 Oct
 2022 06:21:08 +0000
Received: from BN8NAM11FT012.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ee:cafe::d2) by BN0PR04CA0006.outlook.office365.com
 (2603:10b6:408:ee::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.21 via Frontend
 Transport; Tue, 11 Oct 2022 06:21:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT012.mail.protection.outlook.com (10.13.177.55) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5709.10 via Frontend Transport; Tue, 11 Oct 2022 06:21:08 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 11 Oct
 2022 01:21:08 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Mon, 10 Oct
 2022 23:21:07 -0700
Received: from xhdlakshmis40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.28 via Frontend
 Transport; Tue, 11 Oct 2022 01:21:04 -0500
From:   Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>
To:     <broonie@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>
CC:     <git@amd.com>, <michal.simek@amd.com>, <linux-spi@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>,
        Naga Sureshkumar Relli <nagasure@xilinx.com>
Subject: [PATCH v4 7/7] spi: spi-zynqmp-gqspi: Add tap delay support for GQSPI controller on Versal platform
Date:   Tue, 11 Oct 2022 11:50:40 +0530
Message-ID: <20221011062040.12116-8-amit.kumar-mahapatra@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221011062040.12116-1-amit.kumar-mahapatra@amd.com>
References: <20221011062040.12116-1-amit.kumar-mahapatra@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT012:EE_|CY8PR12MB7147:EE_
X-MS-Office365-Filtering-Correlation-Id: faf42eb4-fb4e-40a3-f314-08daab50c902
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XNyFPn2AE7xsgrG8P2Ljlpyyc21rDOQ4afTWs6SgHXghntBBeHP0s9FFyHI2NUAr+D3sx3QzIFW/ZMqnT9wIRAIo9p+VX+yZC0z7HsRyxNi8/6K4BeU894Qr1ur4y7IMrYwUUQyoRveLjhC0JPZ/9+rTiE5DEDrVZmf83EzfUS6bzSMFhsTCjrmPXahcwFWbyrU9GGkCE014k/ke5Hf2vfyWg4zcSCWAbocQoOLuXItOIXNcM08fbxUd4qRzbSVutETZWWREHu3uD1+imXL7QOc4nqsFmotfpFnipEKnAPoblU0+valaQ2f8KwDDmFv2WPD9aNwoxQouBG9frUiwxfsgBCXvifqj09ZYQ5KWgxxZO8VO7RACCmlJg7UWCL3blG7ZIG/dRs+L3YEjm1gl6XA/IhBFaYlRRwwshV0VyZ/cBVXxP3Ml8X58tinXGQgr1W4jXUnCBnCd6EblV8BgDuwgx+7wyVwwNHGtktoWuf5t/4onReUwRc2X3xTaZS+4nIuDvhK9bIx+CqrttRyhc+/6eZPGu/ISg7c8KMdrlpuBPvxCRKj+5CR9aRq5ilQdtKI7V1vqC89iAUNU0yuuJMGKJvw1tolKk6JvvfK0PHB8JhOFU7anJFCWMUsPwwCDerS40hKYrrTUoqqrb0k+fKXkfQyUPb6wPZG6eZavlBmlsc9OH99t3waZEDUb5QHbbNRuht9IQS5wiGd/bJf25hyob3/l5NkJalDoYh/iYlqV6lAWp8rTuyO3CsAxMKe1YharCMe5V2cUVwk90jt1w3fLHcfq3kJRG1SB1lLOvYzTKTRVNzmuDBn770j0DsMY
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(346002)(39860400002)(136003)(396003)(376002)(451199015)(46966006)(40470700004)(36840700001)(82310400005)(47076005)(4326008)(336012)(426003)(8676002)(70206006)(70586007)(36860700001)(86362001)(110136005)(40460700003)(478600001)(356005)(316002)(107886003)(81166007)(6666004)(54906003)(40480700001)(36756003)(41300700001)(1076003)(186003)(26005)(2906002)(83380400001)(82740400003)(2616005)(5660300002)(8936002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2022 06:21:08.4024
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: faf42eb4-fb4e-40a3-f314-08daab50c902
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT012.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7147
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add tap delay support for GQSPI controller on Versal platform.

Signed-off-by: Naga Sureshkumar Relli <nagasure@xilinx.com>
Signed-off-by: Michal Simek <michal.simek@amd.com>
Signed-off-by: Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>
---
 drivers/spi/spi-zynqmp-gqspi.c | 86 ++++++++++++++++++++++++++--------
 1 file changed, 67 insertions(+), 19 deletions(-)

diff --git a/drivers/spi/spi-zynqmp-gqspi.c b/drivers/spi/spi-zynqmp-gqspi.c
index c11736d96f33..95ff15665d44 100644
--- a/drivers/spi/spi-zynqmp-gqspi.c
+++ b/drivers/spi/spi-zynqmp-gqspi.c
@@ -16,6 +16,7 @@
 #include <linux/module.h>
 #include <linux/of_irq.h>
 #include <linux/of_address.h>
+#include <linux/of_device.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
 #include <linux/spi/spi.h>
@@ -34,6 +35,7 @@
 #define GQSPI_RXD_OFST			0x00000120
 #define GQSPI_TX_THRESHOLD_OFST		0x00000128
 #define GQSPI_RX_THRESHOLD_OFST		0x0000012C
+#define IOU_TAPDLY_BYPASS_OFST		0x0000003C
 #define GQSPI_LPBK_DLY_ADJ_OFST		0x00000138
 #define GQSPI_GEN_FIFO_OFST		0x00000140
 #define GQSPI_SEL_OFST			0x00000144
@@ -141,6 +143,13 @@
 #define GQSPI_USE_DATA_DLY_SHIFT	31
 #define GQSPI_DATA_DLY_ADJ_VALUE	0x2
 #define GQSPI_DATA_DLY_ADJ_SHIFT	28
+#define GQSPI_LPBK_DLY_ADJ_DLY_1	0x1
+#define GQSPI_LPBK_DLY_ADJ_DLY_1_SHIFT	0x3
+#define TAP_DLY_BYPASS_LQSPI_RX_VALUE	0x1
+#define TAP_DLY_BYPASS_LQSPI_RX_SHIFT	0x2
+
+/* set to differentiate versal from zynqmp, 1=versal, 0=zynqmp */
+#define QSPI_QUIRK_HAS_TAPDELAY		BIT(0)
 
 #define GQSPI_FREQ_37_5MHZ	37500000
 #define GQSPI_FREQ_40MHZ	40000000
@@ -150,6 +159,14 @@
 #define SPI_AUTOSUSPEND_TIMEOUT		3000
 enum mode_type {GQSPI_MODE_IO, GQSPI_MODE_DMA};
 
+/**
+ * struct qspi_platform_data - zynqmp qspi platform data structure
+ * @quirks:    Flags is used to identify the platform
+ */
+struct qspi_platform_data {
+	u32 quirks;
+};
+
 /**
  * struct zynqmp_qspi - Defines qspi driver instance
  * @ctlr:		Pointer to the spi controller information
@@ -171,6 +188,7 @@ enum mode_type {GQSPI_MODE_IO, GQSPI_MODE_DMA};
  * @data_completion:	completion structure
  * @op_lock:		Operational lock
  * @speed_hz:          Current SPI bus clock speed in hz
+ * @has_tapdelay:	Used for tapdelay register available in qspi
  */
 struct zynqmp_qspi {
 	struct spi_controller *ctlr;
@@ -192,6 +210,7 @@ struct zynqmp_qspi {
 	struct completion data_completion;
 	struct mutex op_lock;
 	u32 speed_hz;
+	bool has_tapdelay;
 };
 
 /**
@@ -271,25 +290,44 @@ static void zynqmp_gqspi_selectslave(struct zynqmp_qspi *instanceptr,
  */
 static void zynqmp_qspi_set_tapdelay(struct zynqmp_qspi *xqspi, u32 baudrateval)
 {
-	u32 lpbkdlyadj = 0, datadlyadj = 0, clk_rate;
+	u32 tapdlybypass = 0, lpbkdlyadj = 0, datadlyadj = 0, clk_rate;
 	u32 reqhz = 0;
 
 	clk_rate = clk_get_rate(xqspi->refclk);
 	reqhz = (clk_rate / (GQSPI_BAUD_DIV_SHIFT << baudrateval));
 
-	if (reqhz <= GQSPI_FREQ_40MHZ) {
-		zynqmp_pm_set_tapdelay_bypass(PM_TAPDELAY_QSPI,
-					      PM_TAPDELAY_BYPASS_ENABLE);
-	} else if (reqhz <= GQSPI_FREQ_100MHZ) {
-		zynqmp_pm_set_tapdelay_bypass(PM_TAPDELAY_QSPI,
-					      PM_TAPDELAY_BYPASS_ENABLE);
-		lpbkdlyadj |= (GQSPI_LPBK_DLY_ADJ_USE_LPBK_MASK);
-		datadlyadj |= ((GQSPI_USE_DATA_DLY <<
-				GQSPI_USE_DATA_DLY_SHIFT) |
-			       (GQSPI_DATA_DLY_ADJ_VALUE <<
-				GQSPI_DATA_DLY_ADJ_SHIFT));
-	} else if (reqhz <= GQSPI_FREQ_150MHZ) {
-		lpbkdlyadj |= GQSPI_LPBK_DLY_ADJ_USE_LPBK_MASK;
+	if (!xqspi->has_tapdelay) {
+		if (reqhz <= GQSPI_FREQ_40MHZ) {
+			zynqmp_pm_set_tapdelay_bypass(PM_TAPDELAY_QSPI,
+						      PM_TAPDELAY_BYPASS_ENABLE);
+		} else if (reqhz <= GQSPI_FREQ_100MHZ) {
+			zynqmp_pm_set_tapdelay_bypass(PM_TAPDELAY_QSPI,
+						      PM_TAPDELAY_BYPASS_ENABLE);
+			lpbkdlyadj |= (GQSPI_LPBK_DLY_ADJ_USE_LPBK_MASK);
+			datadlyadj |= ((GQSPI_USE_DATA_DLY <<
+					GQSPI_USE_DATA_DLY_SHIFT)
+					| (GQSPI_DATA_DLY_ADJ_VALUE <<
+						GQSPI_DATA_DLY_ADJ_SHIFT));
+		} else if (reqhz <= GQSPI_FREQ_150MHZ) {
+			lpbkdlyadj |= GQSPI_LPBK_DLY_ADJ_USE_LPBK_MASK;
+		}
+	} else {
+		if (reqhz <= GQSPI_FREQ_37_5MHZ) {
+			tapdlybypass |= (TAP_DLY_BYPASS_LQSPI_RX_VALUE <<
+					TAP_DLY_BYPASS_LQSPI_RX_SHIFT);
+		} else if (reqhz <= GQSPI_FREQ_100MHZ) {
+			tapdlybypass |= (TAP_DLY_BYPASS_LQSPI_RX_VALUE <<
+					TAP_DLY_BYPASS_LQSPI_RX_SHIFT);
+			lpbkdlyadj |= (GQSPI_LPBK_DLY_ADJ_USE_LPBK_MASK);
+			datadlyadj |= (GQSPI_USE_DATA_DLY <<
+					GQSPI_USE_DATA_DLY_SHIFT);
+		} else if (reqhz <= GQSPI_FREQ_150MHZ) {
+			lpbkdlyadj |= (GQSPI_LPBK_DLY_ADJ_USE_LPBK_MASK
+				       | (GQSPI_LPBK_DLY_ADJ_DLY_1 <<
+					       GQSPI_LPBK_DLY_ADJ_DLY_1_SHIFT));
+		}
+		zynqmp_gqspi_write(xqspi,
+				   IOU_TAPDLY_BYPASS_OFST, tapdlybypass);
 	}
 	zynqmp_gqspi_write(xqspi, GQSPI_LPBK_DLY_ADJ_OFST, lpbkdlyadj);
 	zynqmp_gqspi_write(xqspi, GQSPI_DATA_DLY_ADJ_OFST, datadlyadj);
@@ -1156,6 +1194,16 @@ static const struct dev_pm_ops zynqmp_qspi_dev_pm_ops = {
 	SET_SYSTEM_SLEEP_PM_OPS(zynqmp_qspi_suspend, zynqmp_qspi_resume)
 };
 
+static const struct qspi_platform_data versal_qspi_def = {
+	.quirks = QSPI_QUIRK_HAS_TAPDELAY,
+};
+
+static const struct of_device_id zynqmp_qspi_of_match[] = {
+	{ .compatible = "xlnx,zynqmp-qspi-1.0"},
+	{ .compatible = "xlnx,versal-qspi-1.0", .data = &versal_qspi_def },
+	{ /* End of table */ }
+};
+
 static const struct spi_controller_mem_ops zynqmp_qspi_mem_ops = {
 	.exec_op = zynqmp_qspi_exec_op,
 };
@@ -1176,6 +1224,7 @@ static int zynqmp_qspi_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct device_node *np = dev->of_node;
 	u32 num_cs;
+	const struct qspi_platform_data *p_data;
 
 	ctlr = spi_alloc_master(&pdev->dev, sizeof(*xqspi));
 	if (!ctlr)
@@ -1186,6 +1235,10 @@ static int zynqmp_qspi_probe(struct platform_device *pdev)
 	xqspi->ctlr = ctlr;
 	platform_set_drvdata(pdev, xqspi);
 
+	p_data = of_device_get_match_data(&pdev->dev);
+	if (p_data && (p_data->quirks & QSPI_QUIRK_HAS_TAPDELAY))
+		xqspi->has_tapdelay = true;
+
 	xqspi->regs = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(xqspi->regs)) {
 		ret = PTR_ERR(xqspi->regs);
@@ -1324,11 +1377,6 @@ static int zynqmp_qspi_remove(struct platform_device *pdev)
 	return 0;
 }
 
-static const struct of_device_id zynqmp_qspi_of_match[] = {
-	{ .compatible = "xlnx,zynqmp-qspi-1.0", },
-	{ /* End of table */ }
-};
-
 MODULE_DEVICE_TABLE(of, zynqmp_qspi_of_match);
 
 static struct platform_driver zynqmp_qspi_driver = {
-- 
2.17.1

