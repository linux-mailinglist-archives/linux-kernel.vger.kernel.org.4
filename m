Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38E9C5B9A76
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 14:09:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230155AbiIOMJL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 08:09:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230433AbiIOMIg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 08:08:36 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 698F580F77;
        Thu, 15 Sep 2022 05:08:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YXXtRf8hdyHE5xLfQp83HEnWjMEW8tBb7BYeoz6zUGPqC8FxDmJFtUK/KZjBEwKMPEcHdANOuyCN0ledniNU7ohnvnzEfh0M8zjzOHQEIdaFig8AUm4VeaCn/vf8+wczSZQLxSI2Kb/suC7LfXIPpdd5nDWlWyG4DX20O0M8q4eh6iFMEEI5TT/EDIkayqiLGELpbbEOTAmB1JcbV92cJ+anD6TKWeQNK2AXhJGfegNUsJtfTtvFcfdskZ+Vdg0TWNqeSd5I7c6wSDdKV6n6a2OgATKxHXfUlgn2kI7nuELpHQwjYnq14gEhCHhf5icvo5yX74wrV82VAu3IzRI35Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L15GJ9kyqYzgbi6n1DKPWCvNS5HxgMoDJWURebXlZ/4=;
 b=NS8mxNj6TGhQCCkZMeo1CmDlyPupuJo4CIPNnAnn5ixL4eacZoYwA0vdEfUa8pW415RRb76WcCKyY8Kt9gkxRvejNG4vv9gRjH+Pr+9wKDu+/bI2ACBRQe64Zcr/bx6Y6if/F6J7GNmjWXPJ5yP6vifl5RcwW5Q0qb9d+crT8lBgmsuYEAuKeNXEa82fzm/Dz18mXHeG1bz8xG2ps0koSOg+FoMVPk35oUw6gnaF8OLE8WIwYTX/IjvI2b/eiX/Q48dI3cYvb0KR2/WNPmrZ3ihdWXGY7YVfnUBHbBiaMjTuvAF8iXvDhAcOPzYJf5KhosWD986mfMkhf17g9ya+RQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L15GJ9kyqYzgbi6n1DKPWCvNS5HxgMoDJWURebXlZ/4=;
 b=pMMu4FP+xWo7G2vkjR4uwPAp7wULAoTKBew0PeyrLhNf/zb369ixFkhPV0FI630peJCscd+fOyheIEjPDmQyWYTC0yx1uvJlpMSYlT07sRDMagWGc/y6Fdoc5Ei+qs7tKw3bPKOsTSX8J/hJQJmI70kt1/cVNtXC5fHOzYpDTPg=
Received: from DM6PR08CA0003.namprd08.prod.outlook.com (2603:10b6:5:80::16) by
 BL0PR02MB6483.namprd02.prod.outlook.com (2603:10b6:208:1cb::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.15; Thu, 15 Sep
 2022 12:08:28 +0000
Received: from DM3NAM02FT016.eop-nam02.prod.protection.outlook.com
 (2603:10b6:5:80:cafe::cf) by DM6PR08CA0003.outlook.office365.com
 (2603:10b6:5:80::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.14 via Frontend
 Transport; Thu, 15 Sep 2022 12:08:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com; pr=C
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 DM3NAM02FT016.mail.protection.outlook.com (10.13.4.77) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5632.12 via Frontend Transport; Thu, 15 Sep 2022 12:08:27 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.9; Thu, 15 Sep 2022 05:08:19 -0700
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2507.9 via Frontend Transport; Thu, 15 Sep 2022 05:08:19 -0700
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
        id 1oYnfG-000Fci-La; Thu, 15 Sep 2022 05:08:19 -0700
From:   Amit Kumar Mahapatra <amit.kumar-mahapatra@xilinx.com>
To:     <broonie@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>
CC:     <git@amd.com>, <michal.simek@amd.com>, <linux-spi@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <akumarma@amd.com>,
        Amit Kumar Mahapatra <amit.kumar-mahapatra@xilinx.com>,
        Naga Sureshkumar Relli <nagasure@xilinx.com>
Subject: [PATCH v2 7/7] spi: spi-zynqmp-gqspi: Add tap delay support for GQSPI controller on Versal platform
Date:   Thu, 15 Sep 2022 17:37:50 +0530
Message-ID: <20220915120750.1424984-8-amit.kumar-mahapatra@xilinx.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220915120750.1424984-1-amit.kumar-mahapatra@xilinx.com>
References: <20220915120750.1424984-1-amit.kumar-mahapatra@xilinx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM3NAM02FT016:EE_|BL0PR02MB6483:EE_
X-MS-Office365-Filtering-Correlation-Id: 132413b8-5f4a-462c-8f07-08da9712ffa9
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ww1cPDWjhuLgX+2PZ0uqdW8LxQ8HikcrCTh9uRIdQSZ8Ka57USTq2VzLVuAHiLukjb+by7V3ucwkjDds7ZbZnSOPBJM4UAaxQYO9DM8JQyaVgFOBmzb7AOvhDbZCRisFcDBVhi6OichS/DBNbCaOYD2Hmvb6Iecf8f9X3JBU6z66utiT++Pq1r/rnQQqaoOSGPgxupASICN5351mGVjpeJ2c7CJIT/i/a70sUq26pLQZ3OLHzYfUdEPz7BsKZt+3s8wGKesBhbY7M15V+Rk4mmOHqyWcDORHG80LNg+yQyeQWL/+ykMLRnX8o5ai1kr4g1b9CPZe7oQnWn2y25GwFVJT6SIhzOxiXVFQJw9Q2iuYOp0GKvjTaRAKAlN3U7LxmWjZWoTo6SpWeQYVhuK7WAedu6c9SaFUnNIBwV/ZlBZNk6QwvIBs6yRFLMWmnLtphYaq3ww2w5z0slGuC50msj2TLXm1bP1BOMKq0443+S8gwofuYmtvE9MaFfTsLQBOgaOQJvIUtFN7pDirG3L/2lLPDJHbiJfLnbg3DJWLILuE2i/PmXhTHcklrB6IiL0AL/OpQ9wMtCbPf8pfK6fACXE4OCPUCTYX2Ali0K9PedEQj4OiP0jsC8a5+hqAj5oKRGwWilEQcKACENXaPtW2Y9DfTgNEN8PHKD44hoRrPjGuizlP+wn6ofTtBr+Z6hcs0dAVAjlidPgSHh8L5I9RADttM9y6sIQ0PlNgak36ChL4tBVWaEXXuBE+d9kjlAWqTZWOe8xYAjnpBCn6t9qBXkA/qc8Xpo9oK7IpEsqrIqo=
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(396003)(376002)(136003)(346002)(451199015)(46966006)(40470700004)(36840700001)(36756003)(5660300002)(9786002)(8936002)(4326008)(70206006)(70586007)(2906002)(7416002)(8676002)(478600001)(36860700001)(41300700001)(26005)(6666004)(7696005)(107886003)(40480700001)(316002)(54906003)(110136005)(2616005)(83380400001)(82310400005)(40460700003)(356005)(82740400003)(47076005)(336012)(186003)(1076003)(426003)(7636003)(102446001);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2022 12:08:27.9916
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 132413b8-5f4a-462c-8f07-08da9712ffa9
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: DM3NAM02FT016.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR02MB6483
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds tap delay support for GQSPI controller on Versal
platform.

Signed-off-by: Naga Sureshkumar Relli <nagasure@xilinx.com>
Signed-off-by: Michal Simek <michal.simek@amd.com>
Signed-off-by: Amit Kumar Mahapatra <amit.kumar-mahapatra@xilinx.com>
---
 drivers/spi/spi-zynqmp-gqspi.c | 86 ++++++++++++++++++++++++++--------
 1 file changed, 67 insertions(+), 19 deletions(-)

diff --git a/drivers/spi/spi-zynqmp-gqspi.c b/drivers/spi/spi-zynqmp-gqspi.c
index 0e6423ff33f4..223c321fc609 100644
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
@@ -134,10 +136,17 @@
 #define GQSPI_SELECT_MODE_QUADSPI	0x4
 #define GQSPI_DMA_UNALIGN		0x3
 #define GQSPI_DEFAULT_NUM_CS	1	/* Default number of chip selects */
+#define GQSPI_LPBK_DLY_ADJ_DLY_1	0x1
+#define GQSPI_LPBK_DLY_ADJ_DLY_1_SHIFT	3
 #define GQSPI_USE_DATA_DLY              0x1
 #define GQSPI_USE_DATA_DLY_SHIFT        31
 #define GQSPI_DATA_DLY_ADJ_VALUE        0x2
 #define GQSPI_DATA_DLY_ADJ_SHIFT        28
+#define TAP_DLY_BYPASS_LQSPI_RX_VALUE	0x1
+#define TAP_DLY_BYPASS_LQSPI_RX_SHIFT	2
+
+/* set to differentiate versal from zynqmp, 1=versal, 0=zynqmp */
+#define QSPI_QUIRK_HAS_TAPDELAY	BIT(0)
 
 #define GQSPI_FREQ_37_5MHZ      37500000
 #define GQSPI_FREQ_40MHZ        40000000
@@ -147,6 +156,14 @@
 #define SPI_AUTOSUSPEND_TIMEOUT		3000
 enum mode_type {GQSPI_MODE_IO, GQSPI_MODE_DMA};
 
+/**
+ * struct qspi_platform_data - zynqmp qspi platform data structure
+ * @quirks:	Flags is used to identify the platform
+ */
+struct qspi_platform_data {
+	u32 quirks;
+};
+
 /**
  * struct zynqmp_qspi - Defines qspi driver instance
  * @ctlr:		Pointer to the spi controller information
@@ -167,7 +184,9 @@ enum mode_type {GQSPI_MODE_IO, GQSPI_MODE_DMA};
  * @mode:		Defines the mode in which QSPI is operating
  * @data_completion:	completion structure
  * @op_lock:		Operational lock
+
  * @speed_hz:		Current SPI bus clock speed in hz
+ * @has_tapdelay:	Used for tapdelay register available in qspi
  */
 struct zynqmp_qspi {
 	struct spi_controller *ctlr;
@@ -189,6 +208,7 @@ struct zynqmp_qspi {
 	struct completion data_completion;
 	struct mutex op_lock;
 	u32 speed_hz;
+	bool has_tapdelay;
 };
 
 /**
@@ -268,26 +288,46 @@ static void zynqmp_gqspi_selectslave(struct zynqmp_qspi *instanceptr,
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
-				GQSPI_USE_DATA_DLY_SHIFT)
-				| (GQSPI_DATA_DLY_ADJ_VALUE <<
-					GQSPI_DATA_DLY_ADJ_SHIFT));
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
+
 	zynqmp_gqspi_write(xqspi, GQSPI_LPBK_DLY_ADJ_OFST, lpbkdlyadj);
 	zynqmp_gqspi_write(xqspi, GQSPI_DATA_DLY_ADJ_OFST, datadlyadj);
 }
@@ -1147,6 +1187,15 @@ static const struct dev_pm_ops zynqmp_qspi_dev_pm_ops = {
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
 static const struct spi_controller_mem_ops zynqmp_qspi_mem_ops = {
 	.exec_op = zynqmp_qspi_exec_op,
 };
@@ -1166,6 +1215,7 @@ static int zynqmp_qspi_probe(struct platform_device *pdev)
 	struct zynqmp_qspi *xqspi;
 	struct device *dev = &pdev->dev;
 	struct device_node *np = dev->of_node;
+	const struct qspi_platform_data *p_data;
 
 	ctlr = spi_alloc_master(&pdev->dev, sizeof(*xqspi));
 	if (!ctlr)
@@ -1176,6 +1226,9 @@ static int zynqmp_qspi_probe(struct platform_device *pdev)
 	xqspi->ctlr = ctlr;
 	platform_set_drvdata(pdev, xqspi);
 
+	p_data = of_device_get_match_data(&pdev->dev);
+	if (p_data && (p_data->quirks & QSPI_QUIRK_HAS_TAPDELAY))
+		xqspi->has_tapdelay = true;
 	xqspi->regs = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(xqspi->regs)) {
 		ret = PTR_ERR(xqspi->regs);
@@ -1303,11 +1356,6 @@ static int zynqmp_qspi_remove(struct platform_device *pdev)
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
2.25.1

