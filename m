Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39A515E9986
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 08:34:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233424AbiIZGd6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 02:33:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232357AbiIZGd4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 02:33:56 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54A7F31230;
        Sun, 25 Sep 2022 23:33:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NDM+qS9uPTSJU1eY/O+QSeRI+bB19ohupGYGrnxrV4vqqgUR+qAy34kEaTMDI6uXjYdJoydDN3gJIH4TZ+YWpktcgRaFMd6l7tjrQLRxE1B8YP7i4eyCJUfQgTvwRCAnS//x8+71kyAlf4RHOLBYnuEIYY1GlpoR63J55ZgHDaOtZOoQNeF3lj9optvJ33kPzHpDIKv+B/8nUXZwTiyTrQuvqoZLroDZOhbCDDL1UIO83voDhj2oXWeEXrhf/qy2PBwy2RI4mRojjVHKbSkPupDbBg0AIGBmtdNsKuh0KxivqzCELouavjmYxEmrl+D5WzmC989InJnkjJPkHqKX7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e0XSmwsYhzBzkLphw6Dkc/Poa9iVIJtLOAXsA3sEI8g=;
 b=Hi31IwaQxJXx6ZcoYQsfVwcAQIdsVQ1YkrzBQqXKplLoLIDIgJe3bCcz3hRdNGgMOzaYj+HMughanDvT7fGyweqtHw/+PIcc2x1P50Tp3bcLSYR7A7aq5ctxbNFdAfZG77Qokeh1+5u67UUuxQZUj/UTxqJCA+HFGLs/CU1xtFl9qZHy7hryeF5dtEKttoweqtVbB/ftyRnp+zFRg2wx17H5scbpUSaOr3g/WMA9YBW/TZ4cYYvXleN/IqsP8jU2jnusiTpfJFDFWfPpiszHH/UwneuztOto1FI/mpHVYfKbGMOofC/zNe/cmkqQioGYsnbUxAnbj0jcXI8JlNJwtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e0XSmwsYhzBzkLphw6Dkc/Poa9iVIJtLOAXsA3sEI8g=;
 b=EE5jq6+CS3OfzmBV4TJDVyhfPLWe67f6ILd8AW3yhJj44kKG9G3Eube7lL1Sz3R2MJdbqVeIhUPVekMzXamNWiDsgL1r4bZekWGzwUK3SMtrOUxs3srqlAabJ4Nsy1VnssHdgbgjU9X9bMVKrAhf7u4e5zwmlKrccIx6xE1k0sE=
Received: from SN4PR0501CA0124.namprd05.prod.outlook.com
 (2603:10b6:803:42::41) by MN2PR02MB7069.namprd02.prod.outlook.com
 (2603:10b6:208:20e::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.24; Mon, 26 Sep
 2022 06:33:52 +0000
Received: from SN1NAM02FT0057.eop-nam02.prod.protection.outlook.com
 (2603:10b6:803:42:cafe::1b) by SN4PR0501CA0124.outlook.office365.com
 (2603:10b6:803:42::41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.9 via Frontend
 Transport; Mon, 26 Sep 2022 06:33:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com; pr=C
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 SN1NAM02FT0057.mail.protection.outlook.com (10.97.4.123) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5654.14 via Frontend Transport; Mon, 26 Sep 2022 06:33:51 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Sun, 25 Sep 2022 23:33:40 -0700
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2507.9 via Frontend Transport; Sun, 25 Sep 2022 23:33:39 -0700
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
Received: from [10.140.6.18] (port=46254 helo=xhdlakshmis40.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <amit.kumar-mahapatra@xilinx.com>)
        id 1ochgR-000GAg-H9; Sun, 25 Sep 2022 23:33:39 -0700
From:   Amit Kumar Mahapatra <amit.kumar-mahapatra@xilinx.com>
To:     <broonie@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>
CC:     <akumarma@amd.com>, <git@amd.com>, <michal.simek@xilinx.com>,
        <linux-spi@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <amit.kumar-mahapatra@amd.com>,
        Amit Kumar Mahapatra <amit.kumar-mahapatra@xilinx.com>
Subject: [RESEND PATCH v3 2/7] spi: spi-zynqmp-gqspi: Set CPOL and CPHA during hardware init
Date:   Mon, 26 Sep 2022 12:03:22 +0530
Message-ID: <20220926063327.20753-3-amit.kumar-mahapatra@xilinx.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220926063327.20753-1-amit.kumar-mahapatra@xilinx.com>
References: <20220926063327.20753-1-amit.kumar-mahapatra@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1NAM02FT0057:EE_|MN2PR02MB7069:EE_
X-MS-Office365-Filtering-Correlation-Id: d7ccbe5d-489b-40e9-65c5-08da9f8913be
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CqG5rXyDTKUfmBed0V1SCpUEtjq7+9NzmlBxVR5PU1/fT77o0m03uh9xlqkKNZRLVz5zSN9nPzfPgBaYWvUbbkTl6zbC4oxuRkohFQiSp0yuK1/rn1FdOpZS2vGsq9VDLRChtFUWQ5t01xgWpQYAjRGFuWimcWPdJBPOu9eA2+BZeruT+HBIaQFxKktijRuGZ715YOqONHtUKXtffH7LzMd4LJKxeGqKg8iwXnrYNoZiH3nErPcpaIkif44M3f3QRFbI4eyHtltZtEeta0ax5KOO+n55bFjbIJIiwuEoq9BSTpo2PliwJG9Fbe7SgAz+dyDWF1WyGZQZoTZ38xr583U/RBJGl8aoyUCDaL+4ITOnNLRqGROjPSyNn0hnG4Iw3f9WarX7BfouRMVLCxeErevmQ3UEmqpcZ+GtQnAK2dw/wmjxePmXeDgUnoUY8kURS0TaXi2gKc2fVBzmn3tEMBGYFGfeAiJByX554EeaZAGmQTGtKAXCyzCAiv9dmAy4XmrqmGSIIeH36lQIGS8BaM6soY3H2UY5PC1T5OkzOyRUOIsFxnxMV6qUCBXj5RFYFbncPHwsqtSkDncKF4rD4k9lJWlsT+tOaUZMWrOoELzgzqKdp2qOYvScuZv5naxwURd23Kw1nrxHKjZK2MMR8gQ66mqZ3dUXpHefSy9PbdWIBrvTwLMY9am0pVQ95hOQzn4LIwBToKSHo6I819ZJ0S6nYDWMVDT7rvCJgqqTd9QSBLNTUv5qhYtVuawnjoMVVD5/ATwUV+enh6BRvnWSjQ8sepcPVVZpVGLSVZ6oscA=
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(346002)(136003)(396003)(376002)(451199015)(36840700001)(46966006)(40470700004)(36860700001)(83380400001)(8676002)(4326008)(70206006)(5660300002)(70586007)(7696005)(9786002)(8936002)(7416002)(47076005)(426003)(7636003)(336012)(54906003)(110136005)(186003)(1076003)(356005)(316002)(478600001)(2616005)(82310400005)(36756003)(2906002)(40460700003)(41300700001)(26005)(82740400003)(6666004)(107886003)(40480700001)(102446001);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2022 06:33:51.5989
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d7ccbe5d-489b-40e9-65c5-08da9f8913be
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1NAM02FT0057.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR02MB7069
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

During every transfer GQSPI driver writes the CPOL & CPHA values to the
configuration register. But the CPOL & CPHA values do not change in between
multiple transfers, so moved the CPOL & CPHA initialization to hardware
init so that the values are written only once.

Signed-off-by: Amit Kumar Mahapatra <amit.kumar-mahapatra@xilinx.com>
---
 drivers/spi/spi-zynqmp-gqspi.c | 32 +++++++++++++++++---------------
 1 file changed, 17 insertions(+), 15 deletions(-)

diff --git a/drivers/spi/spi-zynqmp-gqspi.c b/drivers/spi/spi-zynqmp-gqspi.c
index 973008a30a09..1b56dd29057f 100644
--- a/drivers/spi/spi-zynqmp-gqspi.c
+++ b/drivers/spi/spi-zynqmp-gqspi.c
@@ -266,7 +266,9 @@ static void zynqmp_gqspi_selectslave(struct zynqmp_qspi *instanceptr,
  *	- Enable manual slave select
  *	- Enable manual start
  *	- Deselect all the chip select lines
- *	- Set the little endian mode of TX FIFO and
+ *	- Set the little endian mode of TX FIFO
+ *	- Set clock phase
+ *	- Set clock polarity and
  *	- Enable the QSPI controller
  */
 static void zynqmp_qspi_init_hw(struct zynqmp_qspi *xqspi)
@@ -305,10 +307,17 @@ static void zynqmp_qspi_init_hw(struct zynqmp_qspi *xqspi)
 	config_reg |= GQSPI_CFG_WP_HOLD_MASK;
 	/* Clear pre-scalar by default */
 	config_reg &= ~GQSPI_CFG_BAUD_RATE_DIV_MASK;
-	/* CPHA 0 */
-	config_reg &= ~GQSPI_CFG_CLK_PHA_MASK;
-	/* CPOL 0 */
-	config_reg &= ~GQSPI_CFG_CLK_POL_MASK;
+	/* Set CPHA */
+	if (xqspi->ctlr->mode_bits & SPI_CPHA)
+		config_reg |= GQSPI_CFG_CLK_PHA_MASK;
+	else
+		config_reg &= ~GQSPI_CFG_CLK_PHA_MASK;
+	/* Set CPOL */
+	if (xqspi->ctlr->mode_bits & SPI_CPOL)
+		config_reg |= GQSPI_CFG_CLK_POL_MASK;
+	else
+		config_reg &= ~GQSPI_CFG_CLK_POL_MASK;
+
 	zynqmp_gqspi_write(xqspi, GQSPI_CONFIG_OFST, config_reg);
 
 	/* Clear the TX and RX FIFO */
@@ -470,14 +479,6 @@ static int zynqmp_qspi_config_op(struct zynqmp_qspi *xqspi,
 
 	config_reg = zynqmp_gqspi_read(xqspi, GQSPI_CONFIG_OFST);
 
-	/* Set the QSPI clock phase and clock polarity */
-	config_reg &= (~GQSPI_CFG_CLK_PHA_MASK) & (~GQSPI_CFG_CLK_POL_MASK);
-
-	if (qspi->mode & SPI_CPHA)
-		config_reg |= GQSPI_CFG_CLK_PHA_MASK;
-	if (qspi->mode & SPI_CPOL)
-		config_reg |= GQSPI_CFG_CLK_POL_MASK;
-
 	config_reg &= ~GQSPI_CFG_BAUD_RATE_DIV_MASK;
 	config_reg |= (baud_rate_val << GQSPI_CFG_BAUD_RATE_DIV_SHIFT);
 	zynqmp_gqspi_write(xqspi, GQSPI_CONFIG_OFST, config_reg);
@@ -1170,6 +1171,9 @@ static int zynqmp_qspi_probe(struct platform_device *pdev)
 		goto clk_dis_all;
 	}
 
+	ctlr->mode_bits = SPI_CPOL | SPI_CPHA | SPI_RX_DUAL | SPI_RX_QUAD |
+		SPI_TX_DUAL | SPI_TX_QUAD;
+
 	/* QSPI controller initializations */
 	zynqmp_qspi_init_hw(xqspi);
 
@@ -1207,8 +1211,6 @@ static int zynqmp_qspi_probe(struct platform_device *pdev)
 	ctlr->setup = zynqmp_qspi_setup_op;
 	ctlr->max_speed_hz = clk_get_rate(xqspi->refclk) / 2;
 	ctlr->bits_per_word_mask = SPI_BPW_MASK(8);
-	ctlr->mode_bits = SPI_CPOL | SPI_CPHA | SPI_RX_DUAL | SPI_RX_QUAD |
-			    SPI_TX_DUAL | SPI_TX_QUAD;
 	ctlr->dev.of_node = np;
 	ctlr->auto_runtime_pm = true;
 
-- 
2.17.1

