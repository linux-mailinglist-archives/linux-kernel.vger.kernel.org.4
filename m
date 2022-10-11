Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 751B75FAC96
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 08:21:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229779AbiJKGVO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 02:21:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbiJKGVC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 02:21:02 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2058.outbound.protection.outlook.com [40.107.243.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A46385FF6F;
        Mon, 10 Oct 2022 23:20:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mdyGAZcNTrBnW2nte9k1yQi+Lyi5r4ecG+l3JtpxAVy7OLQ3C+OSHcBcNdS1C9nIQQH/ClhrOLJVNQekeq7AYXmPiUwT/QEM7Sjp+jH97VbBJ4NV16wjmNF+0F4m8PXE4Uq4Wlr2UakX6FKy5OV1pxdkAaIsTsCuLWb8WcN+CqLXSGWY6R3ipJx1GbVucMvuG3IGYabpfMu4eV5NKcsEkOtA5Qvb3OCHJkmYpJ0+G3F0fn1r7kcefnZYYhAUDT3U07UTaJltPhGtucO9Uq/efywJOWua0irzwJw4GZfwUqM0Aols8XZdi2ws0hvWlBx69i0y/X/iZULEtC+YVhRqjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7YD45q83STiGTiA0MQuWej3uWkYVXktRm5yXX8gCdYo=;
 b=Mx7btrgTCuffvz8WVL6rQ/d2aMrmPAnPjKO/QZ6BFAukus2ORhiWK528Au74VW1D5f8uuNwk3z3tfHJlcSrqtnRzViBmDaq/POI1MunJvogzMz/4qks8TJZfBcKjvP68o8nbo3klzf/mu/3jqiY7pocKObjn9zEP5AygCklsTn5qFv7+KS3i7OChu7/2gQSUdJyD4zZNUVfoOKam0PP42uZkZ01u7E0rWYlgw/jHiohsrrYjOq1JJZMHoiViypH8uZskZxC/QWXDx/a9Fu/eoXYJoMJNZ9VMTk/XVSz4P5syKpvtfmpt/OBGqns1dJPSz1kK4PF0UeC6NX/Oea5C6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7YD45q83STiGTiA0MQuWej3uWkYVXktRm5yXX8gCdYo=;
 b=sMPjQHzeJba/q2NqgLE0lJqltrdqbNvjktQkwSrAdsov2tkaMoljNOyjiqqAe/wiRFtQCIvtk4srsUBdeTKzlpTm38nuvvBVTn6oX6cpeDEPLXR6fmg6ecNacpcT7tbIB9PGDPPm0YM3EFtu+JewVe+e3WDtZaOB2Nteq4xHQP4=
Received: from BN9PR03CA0406.namprd03.prod.outlook.com (2603:10b6:408:111::21)
 by SA0PR12MB4542.namprd12.prod.outlook.com (2603:10b6:806:73::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.19; Tue, 11 Oct
 2022 06:20:57 +0000
Received: from BN8NAM11FT004.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:111:cafe::da) by BN9PR03CA0406.outlook.office365.com
 (2603:10b6:408:111::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.20 via Frontend
 Transport; Tue, 11 Oct 2022 06:20:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT004.mail.protection.outlook.com (10.13.176.164) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5709.10 via Frontend Transport; Tue, 11 Oct 2022 06:20:57 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 11 Oct
 2022 01:20:52 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 11 Oct
 2022 01:20:51 -0500
Received: from xhdlakshmis40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.28 via Frontend
 Transport; Tue, 11 Oct 2022 01:20:48 -0500
From:   Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>
To:     <broonie@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>
CC:     <git@amd.com>, <michal.simek@amd.com>, <linux-spi@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>
Subject: [PATCH v4 2/7] spi: spi-zynqmp-gqspi: Set CPOL and CPHA during hardware init
Date:   Tue, 11 Oct 2022 11:50:35 +0530
Message-ID: <20221011062040.12116-3-amit.kumar-mahapatra@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221011062040.12116-1-amit.kumar-mahapatra@amd.com>
References: <20221011062040.12116-1-amit.kumar-mahapatra@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT004:EE_|SA0PR12MB4542:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c6444a2-7da2-4963-2db6-08daab50c25e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: j8IVbn0ATNGaMX5/4SfthfLTaSTGx38JXx7gat1WV+808SMvFGqRLgPvWpzrtp8yJHAYvp+t6GvI9VjtZyiVwL4UDS6w3pfzdrUTqSEHQK/f0h1QWGR3Rgszs5qsRepSLwDpY6HZSAnlsCSxCcJnLZoO1ZAmp3rQxx8cZhjRMpMSaEouYdIUzbyVGZ4WqFYaQVZQvyx4n6GkO2xlnEgKXjMENryABD4sRpbhztgU1x0TR7TuycEj8iRacZEXXp6t8mWfBW3M2aoRlBP7odoBd099u5dI8KKoBHqLkYscPn5W0/hutN6cr4ccUtmGAtVgKE6Bz/h7csGKXCYWzc0B/jUsYaoqkNo9Wz7mhQYefD8vLZKrs4Z5UmhiE1IoBi1IaMqVshTcbAoRI3Kmdrnkv2232EEUQcsPl0dYN6u9G+m1o4zrFkBGa9fgo6K8yQuqAy7BAjxOw4IZEie575eDRIT19RGh7omxsAYaiLlrcLjlv45ANuUIrqAKr3zmG/MonnJasf573/DBlw5n66VLymzbGeOM5jP1Dyfl94kzG2ElevWOyMX+s+Eqvabj68+Npbvh5joWWO2HHlVgovyzTi5DH/LpBBGdk4ZlgjMBrk0jejA4BPH145WA6dNKMsHy6pUhUHCAAcDXMeOLoOkobDsuhZ7K+XMr7IUJ7WtNcT6CX1LzFPKwoEZxh9h0K+H0PxXOxFVVnbu3sbVUvEcCfe6uGmB4jed2A9ntmTPodZbDiBD0PQnYn605fkStlA5RnpW/Oi6MWgJ+Yj4WyFn6g10zCdmAeafE4HvBV1cHL460VYxciSqN1MkXq/BrOBys
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(136003)(376002)(39860400002)(396003)(346002)(451199015)(36840700001)(40470700004)(46966006)(5660300002)(8936002)(110136005)(86362001)(54906003)(70586007)(70206006)(8676002)(4326008)(316002)(478600001)(36756003)(356005)(26005)(6666004)(40480700001)(40460700003)(81166007)(83380400001)(82310400005)(47076005)(41300700001)(2906002)(426003)(186003)(1076003)(2616005)(36860700001)(82740400003)(336012)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2022 06:20:57.2719
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c6444a2-7da2-4963-2db6-08daab50c25e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT004.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4542
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

During every transfer GQSPI driver writes the CPOL & CPHA values to the
configuration register. But the CPOL & CPHA values do not change in between
multiple transfers, so moved the CPOL & CPHA initialization to hardware
init so that the values are written only once.

Signed-off-by: Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>
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

