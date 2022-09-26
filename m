Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2B845E9989
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 08:34:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233513AbiIZGeD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 02:34:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233074AbiIZGd5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 02:33:57 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2078.outbound.protection.outlook.com [40.107.101.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 761D8326CB;
        Sun, 25 Sep 2022 23:33:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CxUtNaQDXl7XcjPPZJxzdF+9/AVsUf5OrGda8B7DN2rfeOWQXG41aUmAw9TMc93ImEiXsG6E3aqBOwfVCmZf1GnNidfXF7Ym+zQjBtOPbyNTsjG19lprF0E5/SzVqURvTSgo/G7Ym0+Ll/htSD/yLk+MoX9jf7wr1Ynf9pQOTGgbxQ25bpjzkApUif6KHRG9Lgq4H0NSL03tG4YaqY7pXZGJbpcU4viWuC9SQaX4QkagT3ay+KIT5bn66fLN0siswS4tY900I0NVQHukGVIKkMxxmpL3QqrU8VOH/Xzxq1OdxfQmC081v0wnYIFc4pm+hX0ufXrHq/WmS/4vJiFFDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n62TMUhbtw7CZp6V4FfxOA4/3OrlBP2cy/grjGanfkM=;
 b=gpxD8EwhcaUSRn8D9mPRaFFYPpy+j/JP2pac08v4Fn316xxQ7OeHWWE0LKlUGBICFmZZ6p3Xb9LavX/+2q/liKUb2UDSmnK0Orn8KrRmleTDyrO0o9GRcvnNpG6JtMWTZVm9JKg3alt/THsJWQRBfHf9B+yBDtBEls1iI/Bea8ubgKHragFEH+aTSa3ZVcyIXfrdof6FfyonI+N83vEPGDqo5VFsO4gwr/xw/+Juvfp5b2zbhgAYmhz6J2pmICVJh4tHISu9jm0dt3IdMH4NW1uQ5DS2o63yax6G5cD///gOeE10UH18a4qZu4ARrvh7zYG4g+VToiTaz4HKrnmElA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n62TMUhbtw7CZp6V4FfxOA4/3OrlBP2cy/grjGanfkM=;
 b=NjnDahIZRWjKR4MeT6FV43A+bsl6/L96UNoFdOw0y5trLrP6ipMU4X45lQ419E7U8nLiJ23RlgdpdO/5qd3o0Drt8KgPVl5EZ4ua/YNIEcZsvindRJepnKL0Mvdu81p1p9o/EiwlvLdx1rgPREratiKcwNLObzCKUw/BwL8Bkis=
Received: from SN4PR0501CA0130.namprd05.prod.outlook.com
 (2603:10b6:803:42::47) by CH0PR02MB8027.namprd02.prod.outlook.com
 (2603:10b6:610:108::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.25; Mon, 26 Sep
 2022 06:33:52 +0000
Received: from SN1NAM02FT0057.eop-nam02.prod.protection.outlook.com
 (2603:10b6:803:42:cafe::7f) by SN4PR0501CA0130.outlook.office365.com
 (2603:10b6:803:42::47) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.9 via Frontend
 Transport; Mon, 26 Sep 2022 06:33:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com; pr=C
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 SN1NAM02FT0057.mail.protection.outlook.com (10.97.4.123) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5654.14 via Frontend Transport; Mon, 26 Sep 2022 06:33:52 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Sun, 25 Sep 2022 23:33:43 -0700
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2507.9 via Frontend Transport; Sun, 25 Sep 2022 23:33:43 -0700
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
        id 1ochgU-000GAg-SU; Sun, 25 Sep 2022 23:33:43 -0700
From:   Amit Kumar Mahapatra <amit.kumar-mahapatra@xilinx.com>
To:     <broonie@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>
CC:     <akumarma@amd.com>, <git@amd.com>, <michal.simek@xilinx.com>,
        <linux-spi@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <amit.kumar-mahapatra@amd.com>,
        Amit Kumar Mahapatra <amit.kumar-mahapatra@xilinx.com>
Subject: [RESEND PATCH v3 3/7] spi: spi-zynqmp-gqspi: Avoid setting baud rate multiple times for same SPI frequency
Date:   Mon, 26 Sep 2022 12:03:23 +0530
Message-ID: <20220926063327.20753-4-amit.kumar-mahapatra@xilinx.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220926063327.20753-1-amit.kumar-mahapatra@xilinx.com>
References: <20220926063327.20753-1-amit.kumar-mahapatra@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1NAM02FT0057:EE_|CH0PR02MB8027:EE_
X-MS-Office365-Filtering-Correlation-Id: 4dbb073a-80ee-41e8-fb75-08da9f891437
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gJ0GUJ+3hL8UBZBzNVgT2yDNJr3lHInv5efjkkDTnosY5G9OZhtC5Aav21gysdTaD/m+7HxmVs4mzWNvt0pBzZtw5PugRXP3pyXW81NZvyWOo5nw2PjQbDHWPvwT/OzH5fg6p4MaHGALybLKDSSgDChdtQuQne5RHz+kkspDu9H6gffst3JT99GcMaV9gkalu61jkqtLQWw/Lv0D3X2l6l2YJR/mIY9SZxZC6fNGdGZK2y6/A5KWkfR56q0RQi2ccr42ajuK4tfHDDSPn8RHgvOEMmT2W3fBKcG3bwUhpeNySgGH7sEpXyDVpmms9ePtOsuy1yuO3X/oCxw/5ei5KUo/g3pYsFxZEBOQqZhh2EYMwXXmjh0SFcaOA5jhiW6Ryn5H/oiI7LAyTyBFiSwdwiFzrl1Ur0C46Xc+pPPGb6vGjaLbz66SchvE0kRpnElOGn7bLXICyKsk5LN2oJM6SnRjyvkbGMWOMxM38Yc5Jm2GJK3iPgla0aPOuzRAuZDTouu20gwWWeSHKE1K1Ms6ExeQe2aBxezWok2KNmqqCIdlq39PucZJmrhzpUFeOFaxU5fR3a4Rec3Qr2Pf0pZFZM9K8+RuYAov2qwyrvUHCSaEaqx/K0FXGS3fsaybmX9ACYpeBnPr3vLM+3Fr6gYxXNi93mOXXFmLUZs14Exc9JvPL3Epw0ziK1BY5870WIjwJ/HvEm7ibk6lxJZThE8e7+6gamhGvp1VEajlwWTsAFHcq2eOx+aumCbZpKp/JTdJ+NVL89MG8IRABxo8066YHa7AsV2VH/JEY3aLFpKOx78=
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(13230022)(4636009)(376002)(346002)(136003)(396003)(39860400002)(451199015)(46966006)(40470700004)(36840700001)(478600001)(36756003)(83380400001)(36860700001)(47076005)(356005)(82740400003)(336012)(426003)(2616005)(1076003)(186003)(5660300002)(7636003)(6666004)(7416002)(7696005)(26005)(41300700001)(40460700003)(110136005)(8936002)(316002)(107886003)(54906003)(40480700001)(8676002)(4326008)(70206006)(70586007)(9786002)(2906002)(82310400005)(102446001);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2022 06:33:52.3958
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4dbb073a-80ee-41e8-fb75-08da9f891437
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1NAM02FT0057.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR02MB8027
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

