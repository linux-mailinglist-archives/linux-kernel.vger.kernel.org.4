Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09D015FAC92
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 08:21:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229517AbiJKGVJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 02:21:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229742AbiJKGU6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 02:20:58 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2049.outbound.protection.outlook.com [40.107.223.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5014A5F7E2;
        Mon, 10 Oct 2022 23:20:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dfZcwYVH+i8v/6iNFFL/FkoTFtG/r6Kl9A4GDpvH3lo9RIBXLeptoDU+/MWHlnA71ogIKdxEadYEziTM4jDeCXUjWNKXlWG926CeGgIsM6aj5mP1Dxp1gYhxYq7LHlCW2DcJBaWT6C3cDcVcJQZxInkhEJ4cGz7/PlXfD86x3ldiqzz4WS5G59wFPLaPVLK93uUsniSEKCcOyey5lH/LhheSXpK0zbrXxzvmDaThRHL3m+zRsfmk3TosIVLbMEZAeslp6t99gh3L8zeow7QZslKP+opDhgorquahzOPqsfsHFh/yn/mnBH2CrfPpyrBIaBPGGgmdVq1RUfVNuFOKCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ivn3+biUXoUE/6NG65aupg0Z9GutVeq0abMh5qHoMUo=;
 b=Y+B8HHYFIHB0OCtEeK57mxnnAKnDFMdcMCso90J0OZttblTrtOr3p3RDYLSHXivPWQidPWh1h8jGZhfwRTAagze/qZC42Vi/TI8/FUVelyb7OBT9oI0DAnRL4NB+7Sy70g8Mp1OkUtt7+RinlH7OKez5nnoT/NcUXebGxd5mGSRbSMnJXAPWGaGw8dKkjMCB1u8rjjJvP6yZ0AjLXCnmpADLBgugqkuHWyT3yb/8F6PDAR4/+ougjRn6tNDW/sOjP/ENvo8Z+h7RuWHOHqEobSpv80wmvIaUBHTuyYPmAuXb4m33d3Ofj5/LmH0wwmdOd3+e9Il8y2FkdzHyZ50Fdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ivn3+biUXoUE/6NG65aupg0Z9GutVeq0abMh5qHoMUo=;
 b=GNs9bcabJrDgPAq4BpS1MHGS+bBGwtVLAwCUlCioj9hk35c7ef+gaLQBZ1F5hi8JWe3DH6ZalcaMvGQFXJvcc4BNj3p6c5+a5Nt8IRPKdnwH4+dVlBh/9bWzAFA5OPzH/PqDa9HCACe1/gOyzr6Ba6Fm5ayvFCDb14Zig1Khq0k=
Received: from BN9PR03CA0391.namprd03.prod.outlook.com (2603:10b6:408:111::6)
 by DS0PR12MB6533.namprd12.prod.outlook.com (2603:10b6:8:c2::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.19; Tue, 11 Oct
 2022 06:20:55 +0000
Received: from BN8NAM11FT106.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:111:cafe::65) by BN9PR03CA0391.outlook.office365.com
 (2603:10b6:408:111::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.19 via Frontend
 Transport; Tue, 11 Oct 2022 06:20:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT106.mail.protection.outlook.com (10.13.177.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5709.10 via Frontend Transport; Tue, 11 Oct 2022 06:20:55 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 11 Oct
 2022 01:20:55 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 11 Oct
 2022 01:20:54 -0500
Received: from xhdlakshmis40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.28 via Frontend
 Transport; Tue, 11 Oct 2022 01:20:51 -0500
From:   Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>
To:     <broonie@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>
CC:     <git@amd.com>, <michal.simek@amd.com>, <linux-spi@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>
Subject: [PATCH v4 3/7] spi: spi-zynqmp-gqspi: Avoid setting baud rate multiple times for same SPI frequency
Date:   Tue, 11 Oct 2022 11:50:36 +0530
Message-ID: <20221011062040.12116-4-amit.kumar-mahapatra@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221011062040.12116-1-amit.kumar-mahapatra@amd.com>
References: <20221011062040.12116-1-amit.kumar-mahapatra@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT106:EE_|DS0PR12MB6533:EE_
X-MS-Office365-Filtering-Correlation-Id: 93aadddb-3d3c-4618-9115-08daab50c138
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QPBT7FACp1ER6u1Mjes06EXgsYpus6GScxQEJ45ZbTqEc1dv/jj8pVNc0467P6JBGLUnvwP+w1CWT5bvEfXRNYyrGTYBUUAx5JZTpDfjyE6Cq151EATwtT/ms/AgHSglQKYZhzeS3/iZNfUHrnR+8DxrxZ2gnOFZ+pvewPT9nDAFqZe2mOkr8tYFbNdoDhrosfEc4T45bhys8jQCIWHu4N/m0PNWAhVslW5c62hBixtW0stbDUib/hwRbvjLdv8gAGLsHS/qOWvFYmPHwGPShf+FsREmXpqDlrcuJfUDu2P+AAMLUJLHBZL57I6MBDLayEPngziG+uUxp5cF2CLdpnDWdu1bure2szkdAIVrBbSbRxJt7ZKlIgq+R8s2TNIgB0VFL6W8kotAA0abLvPcRAerubfP8VwB6riDZtWhssUL6r3vKRtiyWceM8YnbjRxAQxMj88e/7uMuZoogW0w+IAyxFn7SitURMpK8Tz/4RAvVcwSEvG8z6JgL/QjJwerpF3dIb2S3C6JOIc0kp2RaIOOmc7cy1Iczc9h769tvSnCdTbCwftjpYrWKpR8rTXYJwo1ryGMzo/Rh49GnJZiuHmLoSHVJdB94zZmiBUKSj93HrNfW+LoeLgSaJqpAfhkZZYEV6JOgh1n+kF/av6/8/oFF6hviSXexYHoSfWB1Nfh54XnXZ/MpNO47obBZaLqq3MfDC1dhnkx7OeiPrwwFNiLtZTjBQJRytnTKJCxMYeeo9cQaQEaiMR1HGLXaObmgbS6QwRu81Ied5LE5dwkoANG/xv+j80jbzWsTjdQQTd3JiRJfnnEPnQcff9EHOA3
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(396003)(136003)(346002)(39860400002)(376002)(451199015)(46966006)(36840700001)(40470700004)(1076003)(186003)(2616005)(336012)(47076005)(426003)(356005)(81166007)(36860700001)(82740400003)(5660300002)(83380400001)(41300700001)(2906002)(4326008)(8936002)(82310400005)(40480700001)(40460700003)(6666004)(478600001)(26005)(8676002)(316002)(70206006)(70586007)(110136005)(54906003)(36756003)(86362001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2022 06:20:55.3477
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 93aadddb-3d3c-4618-9115-08daab50c138
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT106.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6533
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

During every transfer the GQSPI driver configures the baud rate value. But
when there is no change in the SPI clock frequency the driver should avoid
rewriting the same baud rate value to the configuration register. Update
GQSPI driver to rewrite the baud rate value if there is any change in SPI
clock frequency.

Signed-off-by: Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>
---
 drivers/spi/spi-zynqmp-gqspi.c | 49 ++++++++++++++++++++++++----------
 1 file changed, 35 insertions(+), 14 deletions(-)

diff --git a/drivers/spi/spi-zynqmp-gqspi.c b/drivers/spi/spi-zynqmp-gqspi.c
index 1b56dd29057f..0fecea338027 100644
--- a/drivers/spi/spi-zynqmp-gqspi.c
+++ b/drivers/spi/spi-zynqmp-gqspi.c
@@ -159,6 +159,7 @@ enum mode_type {GQSPI_MODE_IO, GQSPI_MODE_DMA};
  * @mode:		Defines the mode in which QSPI is operating
  * @data_completion:	completion structure
  * @op_lock:		Operational lock
+ * @speed_hz:          Current SPI bus clock speed in hz
  */
 struct zynqmp_qspi {
 	struct spi_controller *ctlr;
@@ -179,6 +180,7 @@ struct zynqmp_qspi {
 	enum mode_type mode;
 	struct completion data_completion;
 	struct mutex op_lock;
+	u32 speed_hz;
 };
 
 /**
@@ -273,7 +275,8 @@ static void zynqmp_gqspi_selectslave(struct zynqmp_qspi *instanceptr,
  */
 static void zynqmp_qspi_init_hw(struct zynqmp_qspi *xqspi)
 {
-	u32 config_reg;
+	u32 config_reg, baud_rate_val = 0;
+	ulong clk_rate;
 
 	/* Select the GQSPI mode */
 	zynqmp_gqspi_write(xqspi, GQSPI_SEL_OFST, GQSPI_SEL_MASK);
@@ -318,6 +321,16 @@ static void zynqmp_qspi_init_hw(struct zynqmp_qspi *xqspi)
 	else
 		config_reg &= ~GQSPI_CFG_CLK_POL_MASK;
 
+	/* Set the clock frequency */
+	clk_rate = clk_get_rate(xqspi->refclk);
+	while ((baud_rate_val < GQSPI_BAUD_DIV_MAX) &&
+	       (clk_rate /
+		(GQSPI_BAUD_DIV_SHIFT << baud_rate_val)) > xqspi->speed_hz)
+		baud_rate_val++;
+
+	config_reg &= ~GQSPI_CFG_BAUD_RATE_DIV_MASK;
+	config_reg |= (baud_rate_val << GQSPI_CFG_BAUD_RATE_DIV_SHIFT);
+
 	zynqmp_gqspi_write(xqspi, GQSPI_CONFIG_OFST, config_reg);
 
 	/* Clear the TX and RX FIFO */
@@ -466,22 +479,29 @@ static int zynqmp_qspi_config_op(struct zynqmp_qspi *xqspi,
 				 struct spi_device *qspi)
 {
 	ulong clk_rate;
-	u32 config_reg, baud_rate_val = 0;
+	u32 config_reg, req_speed_hz, baud_rate_val = 0;
 
-	/* Set the clock frequency */
-	/* If req_hz == 0, default to lowest speed */
-	clk_rate = clk_get_rate(xqspi->refclk);
+	req_speed_hz = qspi->max_speed_hz;
 
-	while ((baud_rate_val < GQSPI_BAUD_DIV_MAX) &&
-	       (clk_rate /
-		(GQSPI_BAUD_DIV_SHIFT << baud_rate_val)) > qspi->max_speed_hz)
-		baud_rate_val++;
+	if (xqspi->speed_hz != req_speed_hz) {
+		xqspi->speed_hz = req_speed_hz;
 
-	config_reg = zynqmp_gqspi_read(xqspi, GQSPI_CONFIG_OFST);
+		/* Set the clock frequency */
+		/* If req_speed_hz == 0, default to lowest speed */
+		clk_rate = clk_get_rate(xqspi->refclk);
 
-	config_reg &= ~GQSPI_CFG_BAUD_RATE_DIV_MASK;
-	config_reg |= (baud_rate_val << GQSPI_CFG_BAUD_RATE_DIV_SHIFT);
-	zynqmp_gqspi_write(xqspi, GQSPI_CONFIG_OFST, config_reg);
+		while ((baud_rate_val < GQSPI_BAUD_DIV_MAX) &&
+		       (clk_rate /
+			(GQSPI_BAUD_DIV_SHIFT << baud_rate_val)) >
+		       req_speed_hz)
+			baud_rate_val++;
+
+		config_reg = zynqmp_gqspi_read(xqspi, GQSPI_CONFIG_OFST);
+
+		config_reg &= ~GQSPI_CFG_BAUD_RATE_DIV_MASK;
+		config_reg |= (baud_rate_val << GQSPI_CFG_BAUD_RATE_DIV_SHIFT);
+		zynqmp_gqspi_write(xqspi, GQSPI_CONFIG_OFST, config_reg);
+	}
 	return 0;
 }
 
@@ -1173,6 +1193,8 @@ static int zynqmp_qspi_probe(struct platform_device *pdev)
 
 	ctlr->mode_bits = SPI_CPOL | SPI_CPHA | SPI_RX_DUAL | SPI_RX_QUAD |
 		SPI_TX_DUAL | SPI_TX_QUAD;
+	ctlr->max_speed_hz = clk_get_rate(xqspi->refclk) / 2;
+	xqspi->speed_hz = ctlr->max_speed_hz;
 
 	/* QSPI controller initializations */
 	zynqmp_qspi_init_hw(xqspi);
@@ -1209,7 +1231,6 @@ static int zynqmp_qspi_probe(struct platform_device *pdev)
 	ctlr->bits_per_word_mask = SPI_BPW_MASK(8);
 	ctlr->mem_ops = &zynqmp_qspi_mem_ops;
 	ctlr->setup = zynqmp_qspi_setup_op;
-	ctlr->max_speed_hz = clk_get_rate(xqspi->refclk) / 2;
 	ctlr->bits_per_word_mask = SPI_BPW_MASK(8);
 	ctlr->dev.of_node = np;
 	ctlr->auto_runtime_pm = true;
-- 
2.17.1

