Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 169985F1C25
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Oct 2022 14:22:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229665AbiJAMWZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Oct 2022 08:22:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbiJAMWM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Oct 2022 08:22:12 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2063.outbound.protection.outlook.com [40.107.93.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D04E7F26B;
        Sat,  1 Oct 2022 05:22:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IMHnISlN9XlIqXlAKr2c/P4CpdtiNpzz2jiWK6XZIoJq+LT3z9VC8h0QSJ7RrMEvVskTIRn+0AXKVYmgj1I9u/728XSG/9pD6CGOWXc8od4dkNbH62vf3JcbGZFmlqYwFdfMqCuxBlVE69c5cbw1eTU9OodpsnEVhJhPyxGIogIQWLjI0iAj69Fl4DeiAhiuKAD5M3nZbfEm3TmjvpfkFGayxo0ERaHaWJJ0Zb7LiWlXSVbsmmjEs1sPPMCwCVJ9pV8fTOWm92W713LcJGl9YSsFBSZzkw4GkCYFdd/v7TtFl1t1JlOqTDmVitUp5nt2Gv2c10Yxw3WpGJG8UPxMsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/0eZZhQtvstzy2F+fCPqsyoHZyxPL7oAvmzOWAVavLk=;
 b=eh7+AaAbnC0BJ6HEyZ3MkpvsguFG/G7NVBeAWuPymRBRDMEqN9VyGyNFrFulnHI7mLzrsw00wFxSRtNbh7JPRW6CGyiIWnfKV088itajyOSFxVoXbwNzuDw8Ha1njonAgHrK6dl3K8U85VUiNXEs7D0a4jjE/ukIkESspkPSTpntXYi/0RNEvXb4rTIlm9B/YjwSEGCVGaJ2xs9BZLUYfIRG/QWlNsZVmeNPtcMVIBEMGgQlYJj4ETZPpoQIlb03XstQgPT2hnElMjZkrOXmPf4Etf9LojIhLXz6s8XBrHcgfv0qDjaNNPie6L2UB88nNxC6mrlmBKYLLZ4+BX6k7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/0eZZhQtvstzy2F+fCPqsyoHZyxPL7oAvmzOWAVavLk=;
 b=BSg5ufd5ENYknO2GQDePAtRMhR1SfVdrbXzgF3Hpnfoe6wtc26GJSAwMgMryNpSVnjfK3buo+IR36x5IYjnU5BGwQ1EmVo9HFtOiIWYi5l7XybwrTqA60vFdUs8e2aFi8sY5TzLg79tFriRgmd2Jdpmeg3K30PiO8NmeAia5AzbRC+DoWbvb9PunPVnrKpnfth5JZrUTzeaIUXsTgficA+kKGDU03axF9Jn9jHBBn7LJSgrGl1u+M0cxL5vJLCad2cojryBKrps48R1eL0BQbwAef4kg05hdXjedLEq0NLCJ9Fhmvx5JaHOZnzuhdQxnxy87f4jzXfGdPr/S5J5y4w==
Received: from MW4PR04CA0387.namprd04.prod.outlook.com (2603:10b6:303:81::32)
 by BL1PR12MB5174.namprd12.prod.outlook.com (2603:10b6:208:31c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.24; Sat, 1 Oct
 2022 12:22:10 +0000
Received: from CO1NAM11FT097.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:81:cafe::99) by MW4PR04CA0387.outlook.office365.com
 (2603:10b6:303:81::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.24 via Frontend
 Transport; Sat, 1 Oct 2022 12:22:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1NAM11FT097.mail.protection.outlook.com (10.13.175.185) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5676.17 via Frontend Transport; Sat, 1 Oct 2022 12:22:10 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Sat, 1 Oct 2022
 05:22:06 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Sat, 1 Oct 2022
 05:22:06 -0700
Received: from BUILDSERVER-IO-L4T.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.986.29 via Frontend
 Transport; Sat, 1 Oct 2022 05:22:04 -0700
From:   Krishna Yarlagadda <kyarlagadda@nvidia.com>
To:     <broonie@kernel.org>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <linux-spi@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>
CC:     <skomatineni@nvidia.com>, <ldewangan@nvidia.com>,
        <linux-kernel@vger.kernel.org>,
        Krishna Yarlagadda <kyarlagadda@nvidia.com>
Subject: [PATCH 4/5] spi: tegra210-quad: combined seq for 4READ
Date:   Sat, 1 Oct 2022 17:51:47 +0530
Message-ID: <20221001122148.9158-4-kyarlagadda@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221001122148.9158-1-kyarlagadda@nvidia.com>
References: <20221001122148.9158-1-kyarlagadda@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT097:EE_|BL1PR12MB5174:EE_
X-MS-Office365-Filtering-Correlation-Id: 946e657f-01bc-4129-96d4-08daa3a79043
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dmovqLBqorsNAFtW68OeoHaF+toJlS8N/C/4KA6D30pplpCqFPUe2tnKGmAkeGUwIynv+30rfXG8qVqq1iyI5QHf50nExjN71NbjKhCSNleCEkqWRnNkkeQxrRKo5XpscFkkIMED/S+GfdIn4H9A4M4s5RtpGl2E7i+LNtO7zcZqHi5YHu8EU+UbYVK/lQACFsPUXZGYvhYlgFH7oRekqMBuwUDO+uePpDL82uc4wA+4LfDLTYoet0HSz3zMuCLxyoLOv0TrBeqCTxwxlmRMM23ryup1UR9mDPsNa/+vFFOZyGs9F8Fkj3rXXmH+VrUQoKnuhK2H/AdWa09OvjxhwioBV7PQQciFCOrlv2PgDyL9uXTYFfODeF1AnmVXprqeVnY6nP8j9e9OdzADjJ3oEwM7cn10IuOqlVJ396ieW+t65atxP+IxJ/YYuBU0vgV5lX1CmHKMTt1KBcQrsGSi92M4o+Ib3peUe/yfeAhR8I6e4WjKbxL+8Er69PuvQsHI0dD/wufOD0oZPLU0et0jAy6FrTPElVE4CIpFJCpdib0Nzn1D/nVdnwpVOlXJ+CQNkkP6SOV6JkmvrVMJ70uCugA9EZi2jT9jdJou3/PIfEyJGUoWUHnBZqeoBlkL04e7xHAqQ9GU78NILidvgxAaBaw/oYSXxjBW2AnKA+lr82/ir7gw22AdZReNWavoStRnT6QHg5U0XD5y1SwOTDXryM8haUIdxgu5YS26rMugU0MFdNljD17AIATbTBqcbqiLS6aM0hBFqAzK4ateW75zKA==
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(396003)(346002)(376002)(39860400002)(136003)(451199015)(36840700001)(40470700004)(46966006)(86362001)(107886003)(41300700001)(6666004)(4326008)(8676002)(70206006)(70586007)(186003)(2906002)(1076003)(426003)(8936002)(47076005)(2616005)(336012)(40460700003)(83380400001)(7696005)(36756003)(36860700001)(5660300002)(40480700001)(26005)(7636003)(54906003)(82310400005)(478600001)(356005)(110136005)(82740400003)(316002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2022 12:22:10.0467
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 946e657f-01bc-4129-96d4-08daa3a79043
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT097.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5174
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

X2 and X4 reads require dummy cycles. Use hardware dummy clock cycles
programming to use combined sequence for X2, X4 transfers as well.

Signed-off-by: Krishna Yarlagadda <kyarlagadda@nvidia.com>
---
 drivers/spi/spi-tegra210-quad.c | 22 +++++++++++++++++++---
 1 file changed, 19 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-tegra210-quad.c b/drivers/spi/spi-tegra210-quad.c
index be11daafb7d4..99811509dafa 100644
--- a/drivers/spi/spi-tegra210-quad.c
+++ b/drivers/spi/spi-tegra210-quad.c
@@ -159,7 +159,8 @@
 #define DEFAULT_QSPI_DMA_BUF_LEN		(64 * 1024)
 #define CMD_TRANSFER				0
 #define ADDR_TRANSFER				1
-#define DATA_TRANSFER				2
+#define DUMMY_TRANSFER				2
+#define DATA_TRANSFER				3
 
 struct tegra_qspi_soc_data {
 	bool has_dma;
@@ -1072,7 +1073,12 @@ static int tegra_qspi_combined_seq_xfer(struct tegra_qspi *tqspi,
 							     xfer->len);
 			address_value = *((const u32 *)(xfer->tx_buf));
 			break;
+		case DUMMY_TRANSFER:
 		case DATA_TRANSFER:
+			if (xfer->dummy_data) {
+				tqspi->dummy_cycles = xfer->len * 8 / xfer->tx_nbits;
+				break;
+			}
 			/* Program Command, Address value in register */
 			tegra_qspi_writel(tqspi, cmd_value, QSPI_CMB_SEQ_CMD);
 			tegra_qspi_writel(tqspi, address_value,
@@ -1277,7 +1283,9 @@ static bool tegra_qspi_validate_cmb_seq(struct tegra_qspi *tqspi,
 	list_for_each_entry(xfer, &msg->transfers, transfer_list) {
 		transfer_count++;
 	}
-	if (!tqspi->soc_data->cmb_xfer_capable || transfer_count != 3)
+	if (!tqspi->soc_data->cmb_xfer_capable)
+		return false;
+	if (transfer_count > 4 || transfer_count < 3)
 		return false;
 	xfer = list_first_entry(&msg->transfers, typeof(*xfer),
 				transfer_list);
@@ -1287,7 +1295,15 @@ static bool tegra_qspi_validate_cmb_seq(struct tegra_qspi *tqspi,
 	if (xfer->len > 4 || xfer->len < 3)
 		return false;
 	xfer = list_next_entry(xfer, transfer_list);
-	if (!tqspi->soc_data->has_dma || xfer->len > (QSPI_FIFO_DEPTH << 2))
+	if (transfer_count == 4) {
+		if (xfer->dummy_data != 1)
+			return false;
+		if ((xfer->len * 8 / xfer->tx_nbits) >
+		   QSPI_DUMMY_CYCLES_MAX)
+			return false;
+		xfer = list_next_entry(xfer, transfer_list);
+	}
+	if (!tqspi->soc_data->has_dma && xfer->len > (QSPI_FIFO_DEPTH << 2))
 		return false;
 
 	return true;
-- 
2.17.1

