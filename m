Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BA575E998F
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 08:34:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233210AbiIZGei (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 02:34:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233552AbiIZGe1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 02:34:27 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2061.outbound.protection.outlook.com [40.107.93.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E837932BB8;
        Sun, 25 Sep 2022 23:34:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F1u0TH1wzWrElu9M0oO6EQDhFmL1YRJiWRGURldhQrAVRl++5wPc1FU6B5hdRv84feD9uuBB4WAV/RBMBCeDiCuayprkou1SPzw2DZh2zQlkv3+LMKMEw4I9E89eZzZ3oAtsQg0P0dCvZ4GgVBNfIAVX4QhvN/EpRyO79DmlhIUJUAjpw6CahUdMWguzQwQsSu6Cs1KlKcpBMd5C3uGYU3tXiGukcJ5Gt4gH5yBIsHFYPBLBacUs0LThiuZoQRHZlmcujT5RQ3AbykoDPq5D4jtYTYfnK7tUQ5U8XzyOGaHWZpZ0BDe75Yq20B1jOdEFwImyvUoenyWIJBXT5IsZig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m00rNN/YwIzivhjuanyITfAsQ4WuBb+pG1kK9IBNtpo=;
 b=KGxLZeihofi/cd6AqtReQ8U7IL5ebe/fYeptefSrxSUAoev1QdPBGCQGfh2z9sRPf+rVzkbbOs4W+r9AWYnlVvPFKm01a65nhHdiSZmktT5rlMkIyP4Hl3K3pDngXpo1d1rxlXA30e7NCCDatk8jARILxk6cjoGZVFWhEMYPpdPmMo6fpPJh1I7fs6ysToD2EBGLYAfAro2mp+ZO16m+IJ4B5d/1QWCnkyvsU2bBf+k+gtOitD0CGDlOtpSTqtaFDsKKsZ2fPaqjRvvl2/oAII+9v60RCrwQQoRW5JKKPlUPuQAMntLk+cGEoMZRJFnSVoAAAcpG4me/HfYqypPS5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m00rNN/YwIzivhjuanyITfAsQ4WuBb+pG1kK9IBNtpo=;
 b=Kn0i93yXZE46gfc9nweN+W5ADAiU7gLj04/7Q8/bVL4YVHt8tNiQiEL99lvmUgehA8ZWZB2wflZeRxYIXUp4j3ll21PaxPWPYa1vb5vUGa2G+ryzc4pPQ3vya15iEztN1pzG/C8yNnAcIdOipxSUzKPwnV8rHCmNwHUEdmM/7Y8=
Received: from SA1P222CA0049.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:2d0::26)
 by PH0PR02MB8504.namprd02.prod.outlook.com (2603:10b6:510:105::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.24; Mon, 26 Sep
 2022 06:34:06 +0000
Received: from SN1NAM02FT0037.eop-nam02.prod.protection.outlook.com
 (2603:10b6:806:2d0:cafe::6e) by SA1P222CA0049.outlook.office365.com
 (2603:10b6:806:2d0::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.21 via Frontend
 Transport; Mon, 26 Sep 2022 06:34:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com; pr=C
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 SN1NAM02FT0037.mail.protection.outlook.com (10.97.4.243) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5654.14 via Frontend Transport; Mon, 26 Sep 2022 06:34:05 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Sun, 25 Sep 2022 23:33:50 -0700
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2507.9 via Frontend Transport; Sun, 25 Sep 2022 23:33:50 -0700
Envelope-to: broonie@kernel.org,
 robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org,
 akumarma@amd.com,
 git@amd.com,
 linux-spi@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org,
 amit.kumar-mahapatra@amd.com,
 michal.simek@amd.com
Received: from [10.140.6.18] (port=46254 helo=xhdlakshmis40.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <amit.kumar-mahapatra@xilinx.com>)
        id 1ochgc-000GAg-Du; Sun, 25 Sep 2022 23:33:50 -0700
From:   Amit Kumar Mahapatra <amit.kumar-mahapatra@xilinx.com>
To:     <broonie@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>
CC:     <akumarma@amd.com>, <git@amd.com>, <michal.simek@xilinx.com>,
        <linux-spi@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <amit.kumar-mahapatra@amd.com>,
        Naga Sureshkumar Relli <nagasure@xilinx.com>,
        Michal Simek <michal.simek@amd.com>,
        Amit Kumar Mahapatra <amit.kumar-mahapatra@xilinx.com>
Subject: [RESEND PATCH v3 5/7] spi: spi-zynqmp-gqspi: Add tap delay support for ZynqMP GQSPI Controller
Date:   Mon, 26 Sep 2022 12:03:25 +0530
Message-ID: <20220926063327.20753-6-amit.kumar-mahapatra@xilinx.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220926063327.20753-1-amit.kumar-mahapatra@xilinx.com>
References: <20220926063327.20753-1-amit.kumar-mahapatra@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1NAM02FT0037:EE_|PH0PR02MB8504:EE_
X-MS-Office365-Filtering-Correlation-Id: e84ee22d-0624-4ce5-552a-08da9f891c28
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PdScvESMjC5tvQuPYJJCasg1m6AP6tIF27fkRGcQiq+jCkXzCZvm3RJ3zqPgDc5TgnLgKmyuboM45eAN5GxezhEBY8ulHr4Pm8O5EZJKvEvfqXADGJXSozlxlzYNudEtBkV03+SFzslrAuudTxUkcP6zMZvQPP0lugPbEyjs4joIeVWT9xA8SDwnewjVGgjva8PHiHmFZ2Czk+p6yIml13tasWjZ+UFFt2bh/Z8JSxAt9rPF+b6N9shlm0mUu65FySgXn/ZGPLI8CDyWECsKAaDyZU3zQW+cZTbV/Lu02DbkjsZ1emchVTpre5tpRcY14+BSde/j+lofw0jv8t6EGrkGocx6VuhV3j4VNs1dpq0oA9Z4UaKJzE6s4ApJ+JEKiWYy8TFNFr2LQIh46eAxlSo+6zSHCzb0xPAAL/PWchyf1RRbgCJ0kF82Fvoc2ux0uf9xqAOVrdaalHWVasY7gntCbWQJqQS8Z+Ih1aYMZqjgc4mXmRawmWpvBrrxtStr0z8eBCU+dedOdO3Q4Qk7zSfeJGG0+PnBko4AF1YQw58vgmoeNlcAd5I7wSLUlOP5GV94ETB8CTnBVxInzhbORLFz2shiK+lIm2yWYYwVO9LQC7M624Rerf02MsmrG6FLpWMsTT8keiMMcEesVjL3C4DDE0miVS7GtJMyz7XAog2UI37Q5igw0iSsltkkZUU9Ddc6IthITy1ZXw76VFqRHi3ixlTwTzgKzsQg7CuuoVfCyBpqLehKpopd/w5MzS0BL/b9a2SYf/ISAWq/gvaGujJyT0tMFICJSU8xEAl3yG0=
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(136003)(396003)(346002)(376002)(451199015)(40470700004)(36840700001)(46966006)(1076003)(316002)(8676002)(40480700001)(356005)(4326008)(7636003)(336012)(82740400003)(70206006)(82310400005)(70586007)(186003)(478600001)(426003)(47076005)(26005)(7696005)(107886003)(6666004)(2616005)(36756003)(36860700001)(110136005)(54906003)(83380400001)(5660300002)(7416002)(40460700003)(2906002)(8936002)(41300700001)(9786002)(102446001);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2022 06:34:05.7150
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e84ee22d-0624-4ce5-552a-08da9f891c28
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1NAM02FT0037.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR02MB8504
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Naga Sureshkumar Relli <nagasure@xilinx.com>

GQSPI controller uses the internal clock for loopback mode. The loopback
mode is used with the high-speed Quad SPI timing mode, where the memory
interface clock needs to be greater than 40 MHz. Based on the tap delay
value programmed, the internal clock is delayed and used for capturing
the data.
Based upon the frequency of operation set the recommended tap delay
values in GQSPI driver.

Signed-off-by: Naga Sureshkumar Relli <nagasure@xilinx.com>
Signed-off-by: Michal Simek <michal.simek@amd.com>
Signed-off-by: Amit Kumar Mahapatra <amit.kumar-mahapatra@xilinx.com>
---
 drivers/spi/spi-zynqmp-gqspi.c | 50 +++++++++++++++++++++++++++++++---
 1 file changed, 46 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-zynqmp-gqspi.c b/drivers/spi/spi-zynqmp-gqspi.c
index 0fecea338027..c11736d96f33 100644
--- a/drivers/spi/spi-zynqmp-gqspi.c
+++ b/drivers/spi/spi-zynqmp-gqspi.c
@@ -48,6 +48,7 @@
 #define GQSPI_QSPIDMA_DST_I_MASK_OFST	0x00000820
 #define GQSPI_QSPIDMA_DST_ADDR_OFST	0x00000800
 #define GQSPI_QSPIDMA_DST_ADDR_MSB_OFST 0x00000828
+#define GQSPI_DATA_DLY_ADJ_OFST         0x000001F8
 
 /* GQSPI register bit masks */
 #define GQSPI_SEL_MASK				0x00000001
@@ -136,6 +137,16 @@
 
 #define GQSPI_MAX_NUM_CS	2	/* Maximum number of chip selects */
 
+#define GQSPI_USE_DATA_DLY		0x1
+#define GQSPI_USE_DATA_DLY_SHIFT	31
+#define GQSPI_DATA_DLY_ADJ_VALUE	0x2
+#define GQSPI_DATA_DLY_ADJ_SHIFT	28
+
+#define GQSPI_FREQ_37_5MHZ	37500000
+#define GQSPI_FREQ_40MHZ	40000000
+#define GQSPI_FREQ_100MHZ	100000000
+#define GQSPI_FREQ_150MHZ	150000000
+
 #define SPI_AUTOSUSPEND_TIMEOUT		3000
 enum mode_type {GQSPI_MODE_IO, GQSPI_MODE_DMA};
 
@@ -253,6 +264,37 @@ static void zynqmp_gqspi_selectslave(struct zynqmp_qspi *instanceptr,
 	}
 }
 
+/**
+ * zynqmp_qspi_set_tapdelay:   To configure qspi tap delays
+ * @xqspi:             Pointer to the zynqmp_qspi structure
+ * @baudrateval:       Buadrate to configure
+ */
+static void zynqmp_qspi_set_tapdelay(struct zynqmp_qspi *xqspi, u32 baudrateval)
+{
+	u32 lpbkdlyadj = 0, datadlyadj = 0, clk_rate;
+	u32 reqhz = 0;
+
+	clk_rate = clk_get_rate(xqspi->refclk);
+	reqhz = (clk_rate / (GQSPI_BAUD_DIV_SHIFT << baudrateval));
+
+	if (reqhz <= GQSPI_FREQ_40MHZ) {
+		zynqmp_pm_set_tapdelay_bypass(PM_TAPDELAY_QSPI,
+					      PM_TAPDELAY_BYPASS_ENABLE);
+	} else if (reqhz <= GQSPI_FREQ_100MHZ) {
+		zynqmp_pm_set_tapdelay_bypass(PM_TAPDELAY_QSPI,
+					      PM_TAPDELAY_BYPASS_ENABLE);
+		lpbkdlyadj |= (GQSPI_LPBK_DLY_ADJ_USE_LPBK_MASK);
+		datadlyadj |= ((GQSPI_USE_DATA_DLY <<
+				GQSPI_USE_DATA_DLY_SHIFT) |
+			       (GQSPI_DATA_DLY_ADJ_VALUE <<
+				GQSPI_DATA_DLY_ADJ_SHIFT));
+	} else if (reqhz <= GQSPI_FREQ_150MHZ) {
+		lpbkdlyadj |= GQSPI_LPBK_DLY_ADJ_USE_LPBK_MASK;
+	}
+	zynqmp_gqspi_write(xqspi, GQSPI_LPBK_DLY_ADJ_OFST, lpbkdlyadj);
+	zynqmp_gqspi_write(xqspi, GQSPI_DATA_DLY_ADJ_OFST, datadlyadj);
+}
+
 /**
  * zynqmp_qspi_init_hw - Initialize the hardware
  * @xqspi:	Pointer to the zynqmp_qspi structure
@@ -333,15 +375,14 @@ static void zynqmp_qspi_init_hw(struct zynqmp_qspi *xqspi)
 
 	zynqmp_gqspi_write(xqspi, GQSPI_CONFIG_OFST, config_reg);
 
+	/* Set the tapdelay for clock frequency */
+	zynqmp_qspi_set_tapdelay(xqspi, baud_rate_val);
+
 	/* Clear the TX and RX FIFO */
 	zynqmp_gqspi_write(xqspi, GQSPI_FIFO_CTRL_OFST,
 			   GQSPI_FIFO_CTRL_RST_RX_FIFO_MASK |
 			   GQSPI_FIFO_CTRL_RST_TX_FIFO_MASK |
 			   GQSPI_FIFO_CTRL_RST_GEN_FIFO_MASK);
-	/* Set by default to allow for high frequencies */
-	zynqmp_gqspi_write(xqspi, GQSPI_LPBK_DLY_ADJ_OFST,
-			   zynqmp_gqspi_read(xqspi, GQSPI_LPBK_DLY_ADJ_OFST) |
-			   GQSPI_LPBK_DLY_ADJ_USE_LPBK_MASK);
 	/* Reset thresholds */
 	zynqmp_gqspi_write(xqspi, GQSPI_TX_THRESHOLD_OFST,
 			   GQSPI_TX_FIFO_THRESHOLD_RESET_VAL);
@@ -501,6 +542,7 @@ static int zynqmp_qspi_config_op(struct zynqmp_qspi *xqspi,
 		config_reg &= ~GQSPI_CFG_BAUD_RATE_DIV_MASK;
 		config_reg |= (baud_rate_val << GQSPI_CFG_BAUD_RATE_DIV_SHIFT);
 		zynqmp_gqspi_write(xqspi, GQSPI_CONFIG_OFST, config_reg);
+		zynqmp_qspi_set_tapdelay(xqspi, baud_rate_val);
 	}
 	return 0;
 }
-- 
2.17.1

