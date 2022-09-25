Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D8965E954C
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Sep 2022 20:08:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232953AbiIYSIX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Sep 2022 14:08:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232887AbiIYSIS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Sep 2022 14:08:18 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 447442A94F;
        Sun, 25 Sep 2022 11:08:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bo+2Roe6CF0GvZ0w4hEgja3WPsQplXYOpBDqDKNNWyFvvWFHKFNoWEWPZOUAIuqubS6M9P4v6TBv55IxRY9Qt3tXTQ2t5IoVoC8XVIyOOZ961mkbhXt6NmBlvdMQA/m6s+qUdgJJLOq4cRs4MqpVMipb4qCFe5z9OdvXBFvPkKI6skGhn1EtnD3pSGmHNAyOsDbHyK6QcKwG4F5Eo3XE/N+dbBEeAoFoeNYt/zKWdy6ZUtMUQmj51UVLrmY1dnUnUzE/ZDVqwhANsQLR0OXbTr7aI4U4l+linmdcTRshmhbiaIueXUKp7CPGDgLmoqzNh2wLwOWtjKHTihDTp8x6jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e0XSmwsYhzBzkLphw6Dkc/Poa9iVIJtLOAXsA3sEI8g=;
 b=PsnKyhFSQAf9+ka/HGB/HL4bsXZRKGloBL9n1ATLR7bQYv2RvrLKsqXvs3T35u1lkDQpJzy/xpHitWIAErO0FmJfFfCGrqmXX/SlSDpDBmSRT6YsQSCkS40udT3d7YCUT3Bi40aerYsh1ZUMIa+4hwsFUpESVY6UzvNTFQ0+2WJA1eTxLzWoMy9yCNXwDwcapImwSIrnRyIegcNmwRCZ2lPKY9/fj0rTDebQiAq7Zihfmar13ICfIFR8vDsy7tGXM4kbHx6YvMXVJ6g6u2NJ5JPO5vGHt+oRzXgyvn7DNn40yDwS7V5DNbB7bPm0waFTVOh/KZBd6fqbbC1pIJX7KA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e0XSmwsYhzBzkLphw6Dkc/Poa9iVIJtLOAXsA3sEI8g=;
 b=bE66IjamRSXHpTUZXdJNBa+V2W831TAMD8JzMWWoMFUUP/nDnvZyxYgEoTGpSGqKZGO0uum0xRN4v8FvsvzvQ5OId9a3BhdYyjxtjviglafi2cc6fvvKyZ7QhfbbbGvPFNLeDtZoweCJWM0fw1s1eAFH7QM/8CmJyA99G3W3JdE=
Received: from SN7PR04CA0051.namprd04.prod.outlook.com (2603:10b6:806:120::26)
 by CO6PR02MB7697.namprd02.prod.outlook.com (2603:10b6:303:ad::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.24; Sun, 25 Sep
 2022 18:08:14 +0000
Received: from SN1NAM02FT0014.eop-nam02.prod.protection.outlook.com
 (2603:10b6:806:120:cafe::50) by SN7PR04CA0051.outlook.office365.com
 (2603:10b6:806:120::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.24 via Frontend
 Transport; Sun, 25 Sep 2022 18:08:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com; pr=C
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 SN1NAM02FT0014.mail.protection.outlook.com (10.97.4.112) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5654.14 via Frontend Transport; Sun, 25 Sep 2022 18:08:13 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.9; Sun, 25 Sep 2022 11:07:50 -0700
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2507.9 via Frontend Transport; Sun, 25 Sep 2022 11:07:50 -0700
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
        id 1ocW2f-0001TD-Id; Sun, 25 Sep 2022 11:07:50 -0700
From:   Amit Kumar Mahapatra <amit.kumar-mahapatra@xilinx.com>
To:     <broonie@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>
CC:     <akumarma@amd.com>, <git@amd.com>, <michal.simek@xilinx.com>,
        <linux-spi@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <amit.kumar-mahapatra@amd.com>,
        Amit Kumar Mahapatra <amit.kumar-mahapatra@xilinx.com>
Subject: [PATCH v3 2/7] spi: spi-zynqmp-gqspi: Set CPOL and CPHA during hardware init
Date:   Sun, 25 Sep 2022 23:37:34 +0530
Message-ID: <20220925180739.21612-3-amit.kumar-mahapatra@xilinx.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220925180739.21612-1-amit.kumar-mahapatra@xilinx.com>
References: <20220925180739.21612-1-amit.kumar-mahapatra@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1NAM02FT0014:EE_|CO6PR02MB7697:EE_
X-MS-Office365-Filtering-Correlation-Id: e0a629be-bff3-4022-182f-08da9f20e9ec
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WEu2OI6J1nZ9zjwwSPmKYkQ2JXtuvIQEBXRnERFJgmrkT9W+hJoK7HgBlL0nsG5YQu6t2nzKHoC/pnzYrZgEWtZfydBvS6pMbJDcowKsuuk5xZvSUSeukJGdFQMcCqw8Rf89dPpfIGVAdE8CZm4bIqOwUugDl8bLqe/6BIN7h1j8h5mPYuf7rf07FPgyDtu3L3cI55kiuuLcShIXaUuW9172hEvwe0D+cUT1XQ72omuuQVsLOh10DMKvDCXPntBb8t3Ov5nPOxEtbziUXrfm8h8JJ7GPGVnqwxvyBvhR4/bbKFshCOtYHvEoYQeFiPxn9k9LAJFMROP6ijcdh+BnvPmd6Bakl8PTAHsTDAGhXW0CDtl9Ox/KuAx/Uuu57v98qRXVxUfXT5rqGD+8d5o6T8Eox9fh9m4PX1PX942ul/YJJEOX57Ei7fBhFIfw/mvy3eDen2EGDqT8SIpOTcKfC4+701q8fhcJOH3A3aCQzCEbt7zyVZZkOi4+Xl9d3hS0Z8KsmYE5BXDdFjHcbknDiWgLQo//T7WsvLFWp57CCPno2ZIhdV6Ds6RgeJBBQEMPbnGV3Lx4Djv4fW1ctuyh3hUxCylt9cpafMUUZXtVfqE8IUaZcgTjAmbeWBI70n4CnMJccMZVihurWUEucKteVEUjUTpGkG7C7nS7FhRoQr3KXAk2G/AbUOmnKch4uBOK1VavhW6/JDz/nuOXlY2BG72ClCQnLXlr0VoLWNnIYAs08brStz/5UevaaABJczcWPM30vXkFpURyz3o14vtN27eyoGGEikb/lEsYud7CApo=
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(13230022)(4636009)(346002)(376002)(136003)(39860400002)(396003)(451199015)(46966006)(40470700004)(36840700001)(478600001)(316002)(54906003)(6666004)(41300700001)(70206006)(70586007)(186003)(9786002)(5660300002)(8936002)(7416002)(26005)(2616005)(1076003)(2906002)(336012)(82740400003)(107886003)(7696005)(36860700001)(36756003)(426003)(47076005)(110136005)(4326008)(8676002)(40460700003)(40480700001)(356005)(83380400001)(82310400005)(7636003)(102446001);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2022 18:08:13.7742
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e0a629be-bff3-4022-182f-08da9f20e9ec
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1NAM02FT0014.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR02MB7697
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

