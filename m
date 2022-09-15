Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D40FF5B9A75
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 14:09:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230304AbiIOMJB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 08:09:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230426AbiIOMId (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 08:08:33 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2077.outbound.protection.outlook.com [40.107.237.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C45AD7DF6F;
        Thu, 15 Sep 2022 05:08:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WJ6NYz6XNmPRYSFNKGcueG0ns0vUVEGHdTP1gg0O1OjxeUvuaw/J6no1ms6qBxZSsJNBrkyWy8OBgpH4Lpbo99bAEnEXhWmioGGAKM/kfGpdzsUjSpbCRW9PP0MSqoSCg4FWHBYJYMioVWqFl5QTDDI5brpLqGB0LqdqH7Wg8O4mdjNDKrYTDncTdvVAMXL5a58Vq0s0KU/ZKO82aspVMXbnVztlchLbQfVdUmJugECAcjTb0lK93kATvJRWoEho4xL5pLGIRHVyhXu1Sg6hDpqwoIk0WMaq4k9L1e/B8UHrs48uPET7RWSkPC5jr8CYpp3Z/fLGody5rGY6OVOvWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jF+avYRFtw+sblqZhKWREzCpZ71V6yLkcNlEVHHxFMQ=;
 b=b+vR3SRpN+nHS88v6bqvc36R5kjily0fyY6JaDlUwCs5FkSZMWtTBtnB1cDH/rQV9aQ2fYVgnSopPGyzn0niFo4G4aTuActrKDFtSARrBrE3BLZ1SVu8TwajAicX27HsXoUslytYUExKEvv/a64DkRVZUSZMflmHXm4nvmiMsJ5xAKo2hrxea5NzToYIcOICAz78Jc5XUnuKLqCZhFSY38ZaRoLI4eYyQO6HHsfM07qGxj6H38A3m6WV3tAiMdlW0K9WTxFcCPOmbpPPzlQfU9Cr9KwN1eS6mC11zLPXELwXtKcMqRe62tOKmNOjkwIOVBoe6KzwJx0BCDWP+CGV+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jF+avYRFtw+sblqZhKWREzCpZ71V6yLkcNlEVHHxFMQ=;
 b=Ctb3DmqeCrU6i5PNFa/JvDE74kXWbK81NdAoaPNXbsSZwL3jp3l31yKj2UUM4TNLJ2MOuW+VDWkfN9dWIt6hVVNGTtc+6SjCAPElwwoRo+R9M0uaLKKb6iHniiWUebAePlTXofUavkrpDA+Z/HEpVTu6AAf+/YqQapwyl/Nyycw=
Received: from DM6PR01CA0014.prod.exchangelabs.com (2603:10b6:5:296::19) by
 SN4PR0201MB8774.namprd02.prod.outlook.com (2603:10b6:806:201::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.22; Thu, 15 Sep
 2022 12:08:25 +0000
Received: from DM3NAM02FT032.eop-nam02.prod.protection.outlook.com
 (2603:10b6:5:296:cafe::60) by DM6PR01CA0014.outlook.office365.com
 (2603:10b6:5:296::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.18 via Frontend
 Transport; Thu, 15 Sep 2022 12:08:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com; pr=C
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 DM3NAM02FT032.mail.protection.outlook.com (10.13.5.65) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5632.12 via Frontend Transport; Thu, 15 Sep 2022 12:08:24 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.9; Thu, 15 Sep 2022 05:08:12 -0700
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2507.9 via Frontend Transport; Thu, 15 Sep 2022 05:08:12 -0700
Envelope-to: broonie@kernel.org,
 robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org,
 git@amd.com,
 michal.simek@amd.com,
 linux-spi@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org,
 akumarma@amd.com
Received: from [10.140.6.39] (port=33420 helo=xhdsgoud40.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <amit.kumar-mahapatra@xilinx.com>)
        id 1oYnfA-000Fci-5H; Thu, 15 Sep 2022 05:08:12 -0700
From:   Amit Kumar Mahapatra <amit.kumar-mahapatra@xilinx.com>
To:     <broonie@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>
CC:     <git@amd.com>, <michal.simek@amd.com>, <linux-spi@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <akumarma@amd.com>, Naga Sureshkumar Relli <nagasure@xilinx.com>,
        Amit Kumar Mahapatra <amit.kumar-mahapatra@xilinx.com>
Subject: [PATCH v2 5/7] spi: spi-zynqmp-gqspi: Add tap delay support for ZynqMP GQSPI Controller
Date:   Thu, 15 Sep 2022 17:37:48 +0530
Message-ID: <20220915120750.1424984-6-amit.kumar-mahapatra@xilinx.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220915120750.1424984-1-amit.kumar-mahapatra@xilinx.com>
References: <20220915120750.1424984-1-amit.kumar-mahapatra@xilinx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM3NAM02FT032:EE_|SN4PR0201MB8774:EE_
X-MS-Office365-Filtering-Correlation-Id: 7805f122-336a-4388-d1c8-08da9712fdb3
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hVY1W9iU2bwuxVgxBJUWgcvtzV7fvrSrERu4IHVGG6Xt8fsBbjFULIHa8xnPKIuQz3+FJKkJMwTcLwZVklVjqRqgXBA5oYTz7hEB8PGTqAMrWCyqhl7gyIeUaEVdnTpspB9AloYZ+cvR6AjyOzy0uTnHmhxkPz3iLKgoF+M3A0U/lVVYq+ohbWY3Q5B5d5kIvJRFK6IDwm7y0C7hy95rR2WOfZ6WoOefrRQZOdxzyJ8algXOKPh1QKJlnnWTXaD9PJXQK5GAUEF3UR68Bm1nhsQ2PFiU7BT+CXxWHBUu3DmslmJ+OK5zU0lC687H05CO14RvICUdOWcu6fwLmFBo37joU8aneDCfQB0bG5avcCT7tXW7b7IYkfFYopN8OUpckMs3PY9Axr4txpyTxifcXbR9ZdP9KnWa9zFZo7p320qJMw+EjQ7mXiGc74JABzdkzpK+/f6vvqvjf8HyuQWjvWSAOG+wXhnz7Ys9q4No1Kd7Mjef0ZRHgiVeIuirPKvRuHm1JkKy2Bbgl6fPe51mK9JNNH8O60pgzpzrAxog5oWc1hHt2QOod7vHIJMn8b/tRDshIWc/fIDb3ahEQJRhaGy4vcUT1XvQcW5mSTqml5nDS4yRm5NGdODx2x8r1nqS23RSj1iR53ZtjcemtjWFObOfEXeDoZk5FiHvwB9udzgRLSpZv+sQ74KDHHRpLoHx3cG/KdWvO1g+/14QADAbhfrvoymFAoQTLuv1mU0NzSQn/AeJdcolT5E9juHb+cw0J0+8+HlVgxk7GyOj03IC6rYagjAdFlplr899v13a5xg=
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(13230022)(4636009)(346002)(136003)(376002)(396003)(39860400002)(451199015)(46966006)(36840700001)(40470700004)(41300700001)(478600001)(36756003)(26005)(36860700001)(40480700001)(40460700003)(8676002)(1076003)(5660300002)(316002)(2616005)(70586007)(4326008)(7416002)(356005)(2906002)(83380400001)(426003)(54906003)(107886003)(82310400005)(8936002)(6666004)(9786002)(110136005)(7636003)(336012)(47076005)(70206006)(7696005)(82740400003)(186003)(102446001);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2022 12:08:24.6878
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7805f122-336a-4388-d1c8-08da9712fdb3
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: DM3NAM02FT032.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0201MB8774
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
Based upon the frequency of operation this patch sets the recommended
tap delay values.

Signed-off-by: Naga Sureshkumar Relli <nagasure@xilinx.com>
Signed-off-by: Michal Simek <michal.simek@amd.com>
Signed-off-by: Amit Kumar Mahapatra <amit.kumar-mahapatra@xilinx.com>
---
 drivers/spi/spi-zynqmp-gqspi.c | 48 +++++++++++++++++++++++++++++++---
 1 file changed, 44 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-zynqmp-gqspi.c b/drivers/spi/spi-zynqmp-gqspi.c
index 024085098515..0e6423ff33f4 100644
--- a/drivers/spi/spi-zynqmp-gqspi.c
+++ b/drivers/spi/spi-zynqmp-gqspi.c
@@ -48,6 +48,7 @@
 #define GQSPI_QSPIDMA_DST_I_MASK_OFST	0x00000820
 #define GQSPI_QSPIDMA_DST_ADDR_OFST	0x00000800
 #define GQSPI_QSPIDMA_DST_ADDR_MSB_OFST 0x00000828
+#define GQSPI_DATA_DLY_ADJ_OFST         0x000001F8
 
 /* GQSPI register bit masks */
 #define GQSPI_SEL_MASK				0x00000001
@@ -133,6 +134,15 @@
 #define GQSPI_SELECT_MODE_QUADSPI	0x4
 #define GQSPI_DMA_UNALIGN		0x3
 #define GQSPI_DEFAULT_NUM_CS	1	/* Default number of chip selects */
+#define GQSPI_USE_DATA_DLY              0x1
+#define GQSPI_USE_DATA_DLY_SHIFT        31
+#define GQSPI_DATA_DLY_ADJ_VALUE        0x2
+#define GQSPI_DATA_DLY_ADJ_SHIFT        28
+
+#define GQSPI_FREQ_37_5MHZ      37500000
+#define GQSPI_FREQ_40MHZ        40000000
+#define GQSPI_FREQ_100MHZ       100000000
+#define GQSPI_FREQ_150MHZ       150000000
 
 #define SPI_AUTOSUSPEND_TIMEOUT		3000
 enum mode_type {GQSPI_MODE_IO, GQSPI_MODE_DMA};
@@ -251,6 +261,37 @@ static void zynqmp_gqspi_selectslave(struct zynqmp_qspi *instanceptr,
 	}
 }
 
+/**
+ * zynqmp_qspi_set_tapdelay:	To configure qspi tap delays
+ * @xqspi:		Pointer to the zynqmp_qspi structure
+ * @baudrateval:	Buadrate to configure
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
+				GQSPI_USE_DATA_DLY_SHIFT)
+				| (GQSPI_DATA_DLY_ADJ_VALUE <<
+					GQSPI_DATA_DLY_ADJ_SHIFT));
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
@@ -330,16 +371,14 @@ static void zynqmp_qspi_init_hw(struct zynqmp_qspi *xqspi)
 	config_reg |= (baud_rate_val << GQSPI_CFG_BAUD_RATE_DIV_SHIFT);
 
 	zynqmp_gqspi_write(xqspi, GQSPI_CONFIG_OFST, config_reg);
+	/* Set the tapdelay for clock frequency */
+	zynqmp_qspi_set_tapdelay(xqspi, baud_rate_val);
 
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
@@ -494,6 +533,7 @@ static int zynqmp_qspi_config_op(struct zynqmp_qspi *xqspi,
 		config_reg &= ~GQSPI_CFG_BAUD_RATE_DIV_MASK;
 		config_reg |= (baud_rate_val << GQSPI_CFG_BAUD_RATE_DIV_SHIFT);
 		zynqmp_gqspi_write(xqspi, GQSPI_CONFIG_OFST, config_reg);
+		zynqmp_qspi_set_tapdelay(xqspi, baud_rate_val);
 	}
 	return 0;
 }
-- 
2.25.1

