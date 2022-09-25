Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 524695E954D
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Sep 2022 20:08:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233039AbiIYSIb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Sep 2022 14:08:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232971AbiIYSIU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Sep 2022 14:08:20 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2054.outbound.protection.outlook.com [40.107.243.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F135D2A94F;
        Sun, 25 Sep 2022 11:08:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=froe8U22lPAsyFYDKb8gz7GeeS/xXvArdu0Xi4i+37PC3J3lDOUMMbBndMK3YP8wZ3tuJv+BBczUUUNDe9AABE5YuZNgvj7OeFBpKEZ/koqAoZ0lc3hxitc9PFBxImCq6eDkTliBA7Hn8pTWxO4Mfpt9Z8ktDngHpGI9ZAm5hf5wXEjExrZNp6kKzHoMCj3dVSX/iMz2qPupggdhrVJETAQmZ+UTDxUEo1MfhxSVKPw2pL64KMh2wMF1YFAVL8XLCeD7V3AY8DKNHK28AcXcIR3ZjjjcQqnWzzeImQDJy8Ad33Gbu0qk4XLwN1JHOfMXjbjT7sNI0fuQxxEE6eDFqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n62TMUhbtw7CZp6V4FfxOA4/3OrlBP2cy/grjGanfkM=;
 b=LReMlCsj915Y0IglZqV9d2aRh1MytXqyko82jsIeeUQV5r7uHkbsEUO3ztCXhFdYspKfQ14cqpLtdUbYHUIlH+eK9SbhMarXT/U/qF0sgKEzAGMkmzgQ3gk2uWumQRU4hcEy8dxxE6Tj9xlvVRMX+xEIC6S1T9syTg0GGExoDVOkky+vL+V7udUzeL0hlQF22km4M9gemLl+JS9V/1fZl5GQSx1DFqvtygcBS9IJw6tCnn6Z11JzH4e0hwB8Bwlf1RSl/fkcFa4+CfgK5xfG3Asj0gmt/ayju80bfhFhNZbCx+iKeVtRYtrSCh3C/ZoDJhgYDw5P4LuMlgyyx0ZUmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n62TMUhbtw7CZp6V4FfxOA4/3OrlBP2cy/grjGanfkM=;
 b=AsshXKL4D52vuLLXA5Ef00XPel7D9etZ+OFbXfe0J/VDdaHhcpkE+9wf4aujrOGDwJp8J3y8Q22HhsinQ/7vqz/G6KhxZb8qN377BKf2WddPP3T7uGZedRaSpFnY2F0MjwxqWkeC7nU54gWc4huFWV1ousHcf0G6SN+dq3zZsdk=
Received: from SN7PR04CA0032.namprd04.prod.outlook.com (2603:10b6:806:120::7)
 by PH0PR02MB8534.namprd02.prod.outlook.com (2603:10b6:510:10d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.25; Sun, 25 Sep
 2022 18:08:17 +0000
Received: from SN1NAM02FT0014.eop-nam02.prod.protection.outlook.com
 (2603:10b6:806:120:cafe::f6) by SN7PR04CA0032.outlook.office365.com
 (2603:10b6:806:120::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.24 via Frontend
 Transport; Sun, 25 Sep 2022 18:08:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com; pr=C
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 SN1NAM02FT0014.mail.protection.outlook.com (10.97.4.112) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5654.14 via Frontend Transport; Sun, 25 Sep 2022 18:08:17 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.9; Sun, 25 Sep 2022 11:07:53 -0700
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2507.9 via Frontend Transport; Sun, 25 Sep 2022 11:07:53 -0700
Envelope-to: broonie@kernel.org,
 robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org,
 akumarma@amd.com,
 git@amd.com,
 linux-spi@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org,
 amit.kumar-mahapatra@amd.com
Received: from [10.140.6.18] (port=44788 helo=xhdlakshmis40.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <amit.kumar-mahapatra@xilinx.com>)
        id 1ocW2i-0001TD-V7; Sun, 25 Sep 2022 11:07:53 -0700
From:   Amit Kumar Mahapatra <amit.kumar-mahapatra@xilinx.com>
To:     <broonie@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>
CC:     <akumarma@amd.com>, <git@amd.com>, <michal.simek@xilinx.com>,
        <linux-spi@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <amit.kumar-mahapatra@amd.com>,
        Amit Kumar Mahapatra <amit.kumar-mahapatra@xilinx.com>
Subject: [PATCH v3 3/7] spi: spi-zynqmp-gqspi: Avoid setting baud rate multiple times for same SPI frequency
Date:   Sun, 25 Sep 2022 23:37:35 +0530
Message-ID: <20220925180739.21612-4-amit.kumar-mahapatra@xilinx.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220925180739.21612-1-amit.kumar-mahapatra@xilinx.com>
References: <20220925180739.21612-1-amit.kumar-mahapatra@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1NAM02FT0014:EE_|PH0PR02MB8534:EE_
X-MS-Office365-Filtering-Correlation-Id: 6421c1f0-69dc-410b-92ce-08da9f20ebf8
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RJE1+Ht+gTDdurc+Ilxtuk4LmHAKVWvSfWnVN464uAWagLj8V3qU9TV2wMxm104TOUjPhcMaz+F8q9+Q7k9ATRRgR5bXUMzKrGNRJlgcROknsmTqDVe9JQsRXkRYuTJrwCeKqOtlPirsVydbYFmWRLm9oMRnh1Cwe/7/aD2KMF1l8deTsgTOpYH7iv2OXPM9QAVsnSPB28jjizIJAHvW8EKnRubLhL5a1NGNvsYUr1xnmu0D9hblJI95izWJMNQc5tuGvsm9hjn9knk4NNXwEN/EWorquB/WgIkXBzY407OeFHokuMC3d/VaTaCIKxt0TNHUqVu8wW5oIGRF9IEUDsuGcrDeP2U+vxFv3WCCsJfHcXEC3pfbXqThPohmbBeWUapll1ntWJqb8J7G/B05a6HCfLLiIzGYCtF73rXiUWHCuba3Ee3PJMgdTMVhdBHvrpwAAs8MjA5zhCGZ9BXLn4sF+pNaxRVPacqnddTukJ36GXf8Sv89Um+O8qFsuRh1uqKXdLCb1ezZ5QS+TIjHpfhan6nhNylv4LOEGubQ81l4iXw6DCaTXLzQ/4WxbJhPR8F6OcbxQbTbVEkysaFszI1O7z6vjS35Gv4gxnRggegdMfX5HYJzeTpcm+aF8P5FU0mvozpaXhy6TjC4+LOuQ+jCfvrVxDbToGaYM5yR8thtTw43eiMZDIQEqF0bU4dlnAKDV81TGuaY8SyX/FsmbaIiD/aJmG+zha7fzd4hL3/zz+Ll/iLi6pFkYN+X0x+NMKKgsklk/IrTSrVtd9IQmqSz1z95UMX6lpqR2nVlPsE=
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(13230022)(4636009)(396003)(346002)(376002)(39860400002)(136003)(451199015)(46966006)(40470700004)(36840700001)(4326008)(8676002)(70206006)(70586007)(186003)(1076003)(426003)(47076005)(336012)(26005)(107886003)(6666004)(7696005)(54906003)(110136005)(2616005)(316002)(36756003)(356005)(2906002)(5660300002)(7416002)(82740400003)(7636003)(40460700003)(41300700001)(83380400001)(40480700001)(8936002)(9786002)(36860700001)(82310400005)(478600001)(102446001);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2022 18:08:17.2115
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6421c1f0-69dc-410b-92ce-08da9f20ebf8
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1NAM02FT0014.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR02MB8534
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
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

Signed-off-by: Amit Kumar Mahapatra <amit.kumar-mahapatra@xilinx.com>
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

