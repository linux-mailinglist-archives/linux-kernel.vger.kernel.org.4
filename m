Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1CBF5FAC9D
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 08:21:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229872AbiJKGVk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 02:21:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229755AbiJKGVY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 02:21:24 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2040.outbound.protection.outlook.com [40.107.94.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAC3E87F8E;
        Mon, 10 Oct 2022 23:21:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I0TGVM4Vq2ch3ZLWVtqiWuFP7ygzauun4jdR7fgSHswdRE+WkWojIkwTys2Xn05+XmjGLhVM3qzy6lTaqqSl8gfEm/Z/sLn6P5Gz1mCgVCLPJzFS4MC2dFlUrH5fDweYqlc63bPvSRVEtYeXr0MnlOnf0rgKA58TsD+f3y/+2EzPTDwKvezcyEWYfjuXzQYPO2CJXniIH7zqjkxbSgmf151mn5eHtaCAcPSfcAE89mRnZ3Q5U7WxFEHnfIP4l7q74A8uN9VDY4BBMop6tFL8Y7BT39jqFqCeKwwSPOg0SjObzxnCP6eIGOplFzlXQtfJ89KmI7QDDKwqfJb6udkR8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jrYG587qA3RzBMIm00PpvSRmeRdJO+WIRFIP1bkVgqA=;
 b=VEKwdJodisjlXH2OPP/m56zDmgkiCKT/cab4hVOWSr124V3664jVohyWw0ZkmPdu8FyT6inqK5G6MYeitt5MFlbbkCpzcSsPeFvHYIuaO//YsGSAVKNBBR17vVMPoacTy6WLttPvHZyzmHKbHAXYKM1YvqL7gS9Yzu+TtoMab6YXElg1X65uSDnfo9NHqLna/ABDEs9LhmHswx5lBlJDpw0mwU/VHHU9VcfneSAXW2InTrZu8G3RkUH5Lh6Qko2NF6rJQNufVcvUmKzyaM5fr74SrSLP3nhe9zdxqaYWRJqgdHLhUu0zhOkE/icw3PKEEc0HAzALVjVUro8ZgUYYqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jrYG587qA3RzBMIm00PpvSRmeRdJO+WIRFIP1bkVgqA=;
 b=J44zD5qKXjAdjhqeL7kbqR2ITH860g5pUflb0f/mIMx3jtPclufAJAVCrain8N380vgiduXwnFQb8VKbBfm7W3RPRh6KSfoxFIvMjv8wRy0c4TOR0Qfqdj/P1x1Yq1KtJif9f8PQnhPafBIzNQQ5SdYp8X59t/Hw1rnwHyPfroE=
Received: from BN9PR03CA0073.namprd03.prod.outlook.com (2603:10b6:408:fc::18)
 by DM4PR12MB5088.namprd12.prod.outlook.com (2603:10b6:5:38b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.15; Tue, 11 Oct
 2022 06:21:02 +0000
Received: from BN8NAM11FT048.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:fc:cafe::7e) by BN9PR03CA0073.outlook.office365.com
 (2603:10b6:408:fc::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.21 via Frontend
 Transport; Tue, 11 Oct 2022 06:21:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT048.mail.protection.outlook.com (10.13.177.117) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5709.10 via Frontend Transport; Tue, 11 Oct 2022 06:21:02 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 11 Oct
 2022 01:21:01 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Mon, 10 Oct
 2022 23:21:00 -0700
Received: from xhdlakshmis40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.28 via Frontend
 Transport; Tue, 11 Oct 2022 01:20:58 -0500
From:   Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>
To:     <broonie@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>
CC:     <git@amd.com>, <michal.simek@amd.com>, <linux-spi@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Naga Sureshkumar Relli <nagasure@xilinx.com>,
        Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>
Subject: [PATCH v4 5/7] spi: spi-zynqmp-gqspi: Add tap delay support for ZynqMP GQSPI Controller
Date:   Tue, 11 Oct 2022 11:50:38 +0530
Message-ID: <20221011062040.12116-6-amit.kumar-mahapatra@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221011062040.12116-1-amit.kumar-mahapatra@amd.com>
References: <20221011062040.12116-1-amit.kumar-mahapatra@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT048:EE_|DM4PR12MB5088:EE_
X-MS-Office365-Filtering-Correlation-Id: b58b4d0e-ea4e-4b9e-18ed-08daab50c53e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ozzYWG4noA3VRcqmoMPg9i9psKgVVNIDuzaiogcgk8GXXi2san0aUAkGM/hrs9CObR3X8xYtksfLMqCkI2/SxvYMRp9lcwFF/1pg9Jw8QALarLpGXvKc7s3IJY1NSRPqoHoUDO955JIRS+OBrDlR9PGxFsXnyWD7EDqSSP+J+D3PEhLuUMK+EO1f9inKObiuens8FIKvAlMIYbdf7aX+NeAdap9eb76vFQf9so5G6ebD1ZlbWtpSUK/9dQCgZgdoVslJc+allAwVV6RaoTqYS8Ky11QnLRtRft+5GML7ouzsm/okr3/fvwXS2GJsz0wl1Zqd/GZf83TERJ4DXWEo/I/5gkKLHqARuwSJZ3O0GvoCVRVss1QsPM3Cx2FsYr91UqCL5PcHVzYoPcI0To1f31Zo9e2jyBjm9RUinPCLqOmQnHBPRdzY7Icvr7Hgha3kCxn0TUd5wcxXYjDJzlW847+8Bmz2Om0vINZO6mmyaVuoo1sxpR3NDN1BQEzP784V5BOb9G3aG/4s6z5/0dHAo3mUotl6qGoV48Y83I5Gf5RZNpQ9vWvOM239h63FnBl6h/NV/9b/oviSeNftRsowTTNCIjY2EAPRZLv9Y35SaHj0f2XSqMQsHlU6ntvEgl1GpEFXKWNdR1x2bx+cE+E5I1vLmg7j5ZrcDdzlrL3rJep+xKPLJomuiPm9uafTinDxnvln1w4cJKJ6tRpmxJl/doSVc5FV9yXu2p7Zcpwl47Z+zEaTnH6uMx002+iEVwU/ZWocdk1xmjsWwIfhVamt97PrwYKmLV639WsiDlE+AgPfDDErBL3MvNmw7yDcUto4
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(346002)(376002)(39860400002)(136003)(396003)(451199015)(40470700004)(36840700001)(46966006)(356005)(82740400003)(41300700001)(83380400001)(5660300002)(426003)(8676002)(2616005)(70206006)(4326008)(1076003)(47076005)(70586007)(2906002)(36756003)(26005)(336012)(186003)(8936002)(86362001)(6666004)(36860700001)(40480700001)(82310400005)(478600001)(316002)(40460700003)(81166007)(54906003)(110136005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2022 06:21:02.0636
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b58b4d0e-ea4e-4b9e-18ed-08daab50c53e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT048.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5088
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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
Signed-off-by: Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>
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

