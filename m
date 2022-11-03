Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92E5E618670
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 18:46:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231718AbiKCRqO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 13:46:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231168AbiKCRpr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 13:45:47 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2041.outbound.protection.outlook.com [40.107.244.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4EB01ADAF;
        Thu,  3 Nov 2022 10:45:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ME9gXLXuzsd5QH/+K0kk67/JtI9YRd8g+0WLubrHO27WV9+6ESwlAxb7bYKlLhu0/ev0w2dKmyv5LcgPdpZAgMfp9vv+IFer5Wgt/8UmKAsUzKXtKOMx76yMFyNkCnh5IsgsrEgAth1zX7v4dT2VKGqC4yrHShCsQc/URZwAdjXE13NnaYLnuELPpI481TV37iU9jB5j1ElGQPe7q74tX6y9RYoJkMzCORkuZ/08zF52RoRAe6HK7fWZHYx+Cv+ORKkRhEPUwlHHq5E9EG6ccRf3WRsQCiQC12IdRMbuoX1td0qhxFcSDi94xoKL4hCtAkmvBuxCrf4t0GsRiuGSjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pstXmg6urw7LmGRYp+ddqAdzwMYZNxqun98oEwstrbo=;
 b=BADfBW2inX6Zoz9r3nAbHqXVkvIgccyT8dY0XHg+A1VbxbJJLDB7M+vcI6JQgdS3TvdqUir2C6aEpmhIFoJe+sG0U/OqWKRgEqTUfBS2vOEA34+1gFPOg0vHDdk2b/VZDbsg4c+W9jRIecIwwXvBywh+/Nj3JbqeyMW9inGxL9ZaUZ0GEpVsvhrYLACHhRsfGjBMV/nq0Le33HxHreX5Igxc+Qtk4cKFudFbOI5agK+cQpDFMgVkck7bJSmeX5h1lp6Q1BPqHRx7SQxa6njzWcQ7jNM4Fop0gsKMrw7xgERMHcDclJwSJpo6GLEIWvaXkdFaGZIqVuntzLJg2dq0Xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pstXmg6urw7LmGRYp+ddqAdzwMYZNxqun98oEwstrbo=;
 b=gQ0HnwpqWbuBolKwteLfM0acdFElVKLLbfoqdrnhO2Wn5reHtq0C6wUdlamDx9686cHEMhxrs8RDWdPTBofuT7GeBbfKmOCM89V5wz1z3YX1bljF5UQf12CNXzx0Q/b3AvXj/A8ZuC6Ehic4oT7Fwt4N0vZ1Yd/bQB0K9ybwl6fhWFK5K7zBYRP7OAOBrlA4S+u1QTy15ap5AklOWAsgGup/PNE4avIUGO0GaXjcL8gr80YUEf7EkkYkjAaAvXPA0SFiUz2D6bCCxuohvG2FehUroxoYBG0TSS/RCInd91w/M0iA8fPDx4Vpw8k0VgwAqCOO1DNbNwz5bSL4GV2W2g==
Received: from MW4PR04CA0230.namprd04.prod.outlook.com (2603:10b6:303:87::25)
 by DM4PR12MB5357.namprd12.prod.outlook.com (2603:10b6:5:39b::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.22; Thu, 3 Nov
 2022 17:45:45 +0000
Received: from CO1NAM11FT058.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:87:cafe::33) by MW4PR04CA0230.outlook.office365.com
 (2603:10b6:303:87::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.22 via Frontend
 Transport; Thu, 3 Nov 2022 17:45:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CO1NAM11FT058.mail.protection.outlook.com (10.13.174.164) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5791.20 via Frontend Transport; Thu, 3 Nov 2022 17:45:44 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Thu, 3 Nov 2022
 10:45:35 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Thu, 3 Nov 2022 10:45:35 -0700
Received: from dipenp.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.986.29 via Frontend
 Transport; Thu, 3 Nov 2022 10:45:35 -0700
From:   Dipen Patel <dipenp@nvidia.com>
To:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <linux-kernel@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-gpio@vger.kernel.org>, <linus.walleij@linaro.org>,
        <devicetree@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <robh+dt@kernel.org>
CC:     Dipen Patel <dipenp@nvidia.com>
Subject: [PATCH 2/7] hte: Add Tegra234 provider
Date:   Thu, 3 Nov 2022 10:45:18 -0700
Message-ID: <20221103174523.29592-3-dipenp@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221103174523.29592-1-dipenp@nvidia.com>
References: <20221103174523.29592-1-dipenp@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT058:EE_|DM4PR12MB5357:EE_
X-MS-Office365-Filtering-Correlation-Id: ff83a33d-fd21-4fab-4880-08dabdc33c18
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pA4utFYPXiP4DCRGt8R8WlRQ/fhlBQCqG72iOIf1u3pv6ypgF7IAM12TGb79xMPo3201x3YEFIx5Tr8NxrGEYCIE8p9ei0e8z44D7UZs8PM0LSmpZexpgPuRxRGKkZjz5I6KltgFWS3jm8adkaStseuBS4Bsrmu2vx+eFfl54U1uemPh/G5mupU3ZLrpppz8+r+l/igAaFAuZolJEwToWaNglB39StBYrffete1fEMYjNh4qsOkKIycQuyrBNzHhHauLEoieqKkRDHMx07HFTDjUgR9IU6Asm0bB43iYLrMHoaunYF+8s7ELsfCcGby83O9gtpoqzaGWIh66cCX/RXUwgDwr7nqAuQvf8cQefp8QyHRk/KXthOG387/s0PaB8uhNug0MdmRwSqe7SXpWoTzCyEIDh3RtBW7n8vhOtDfsP11lMdcHVk4C29CJcASJee/ANCexG1i6rAYWTLaIGiRgxKABUT5CY3aD8YPEgyLnZfPeSoMazpytOJXztOEzaRByFd7eqLMrw8ThsTn7olRy1u+WfVQ1umGUxyfhUOG4QDZZQHCSS1Xcl6Vx7KmnuufguNECWl5nqpMA1Y9lLXmJ14NucV/XFaDgDylmqUYsResnRu29DzoEk5H2BsrVsdLlrYYgPa6hakqZ2gM692J+sGubm88e7KouQloY9uChgseZ82c15kw1j4xIM/a02+/S8um8lOZeSsZuSZMv+GakeaW7gBkJ/S7zkigM0zExodWuDbhpIpfR4d95cOODN/6HHA/Q/mPWAYIOWAPO+6IJjGfAH0IZv3edotN1lwI=
X-Forefront-Antispam-Report: CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(376002)(396003)(136003)(346002)(451199015)(36840700001)(40470700004)(46966006)(186003)(336012)(1076003)(2616005)(107886003)(7696005)(26005)(36860700001)(83380400001)(6666004)(426003)(47076005)(2906002)(40480700001)(40460700003)(82310400005)(110136005)(5660300002)(478600001)(41300700001)(70206006)(8936002)(8676002)(70586007)(4326008)(316002)(36756003)(7636003)(356005)(86362001)(82740400003)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2022 17:45:44.9905
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ff83a33d-fd21-4fab-4880-08dabdc33c18
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT058.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5357
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Tegra234 AON GPIO instance and LIC IRQ support HTE. For the GPIO
HTE support, it requires to add mapping between GPIO and HTE framework.

Signed-off-by: Dipen Patel <dipenp@nvidia.com>
---
 drivers/hte/hte-tegra194-test.c |   2 +-
 drivers/hte/hte-tegra194.c      | 124 ++++++++++++++++++++++++++++++--
 2 files changed, 121 insertions(+), 5 deletions(-)

diff --git a/drivers/hte/hte-tegra194-test.c b/drivers/hte/hte-tegra194-test.c
index 5d776a185bd6..d79c28a80517 100644
--- a/drivers/hte/hte-tegra194-test.c
+++ b/drivers/hte/hte-tegra194-test.c
@@ -16,7 +16,7 @@
 #include <linux/hte.h>
 
 /*
- * This sample HTE GPIO test driver demonstrates HTE API usage by enabling
+ * This sample HTE test driver demonstrates HTE API usage by enabling
  * hardware timestamp on gpio_in and specified LIC IRQ lines.
  *
  * Note: gpio_out and gpio_in need to be shorted externally in order for this
diff --git a/drivers/hte/hte-tegra194.c b/drivers/hte/hte-tegra194.c
index 49a27af22742..5d1f947db0f6 100644
--- a/drivers/hte/hte-tegra194.c
+++ b/drivers/hte/hte-tegra194.c
@@ -62,6 +62,10 @@
 #define NV_AON_HTE_SLICE2_IRQ_GPIO_25	25
 #define NV_AON_HTE_SLICE2_IRQ_GPIO_26	26
 #define NV_AON_HTE_SLICE2_IRQ_GPIO_27	27
+#define NV_AON_HTE_SLICE2_IRQ_GPIO_28	28
+#define NV_AON_HTE_SLICE2_IRQ_GPIO_29	29
+#define NV_AON_HTE_SLICE2_IRQ_GPIO_30	30
+#define NV_AON_HTE_SLICE2_IRQ_GPIO_31	31
 
 #define HTE_TECTRL		0x0
 #define HTE_TETSCH		0x4
@@ -220,7 +224,100 @@ static const struct tegra_hte_line_mapped tegra194_aon_gpio_sec_map[] = {
 	[39] = {NV_AON_SLICE_INVALID, 0},
 };
 
-static const struct tegra_hte_data aon_hte = {
+static const struct tegra_hte_line_mapped tegra234_aon_gpio_map[] = {
+	/* gpio, slice, bit_index */
+	/* AA port */
+	[0]  = {2, NV_AON_HTE_SLICE2_IRQ_GPIO_11},
+	[1]  = {2, NV_AON_HTE_SLICE2_IRQ_GPIO_10},
+	[2]  = {2, NV_AON_HTE_SLICE2_IRQ_GPIO_9},
+	[3]  = {2, NV_AON_HTE_SLICE2_IRQ_GPIO_8},
+	[4]  = {2, NV_AON_HTE_SLICE2_IRQ_GPIO_7},
+	[5]  = {2, NV_AON_HTE_SLICE2_IRQ_GPIO_6},
+	[6]  = {2, NV_AON_HTE_SLICE2_IRQ_GPIO_5},
+	[7]  = {2, NV_AON_HTE_SLICE2_IRQ_GPIO_4},
+	/* BB port */
+	[8]  = {2, NV_AON_HTE_SLICE2_IRQ_GPIO_3},
+	[9]  = {2, NV_AON_HTE_SLICE2_IRQ_GPIO_2},
+	[10] = {2, NV_AON_HTE_SLICE2_IRQ_GPIO_1},
+	[11] = {2, NV_AON_HTE_SLICE2_IRQ_GPIO_0},
+	/* CC port */
+	[12] = {2, NV_AON_HTE_SLICE2_IRQ_GPIO_22},
+	[13] = {2, NV_AON_HTE_SLICE2_IRQ_GPIO_21},
+	[14] = {2, NV_AON_HTE_SLICE2_IRQ_GPIO_20},
+	[15] = {2, NV_AON_HTE_SLICE2_IRQ_GPIO_19},
+	[16] = {2, NV_AON_HTE_SLICE2_IRQ_GPIO_18},
+	[17] = {2, NV_AON_HTE_SLICE2_IRQ_GPIO_17},
+	[18] = {2, NV_AON_HTE_SLICE2_IRQ_GPIO_16},
+	[19] = {2, NV_AON_HTE_SLICE2_IRQ_GPIO_15},
+	/* DD port */
+	[20] = {2, NV_AON_HTE_SLICE2_IRQ_GPIO_14},
+	[21] = {2, NV_AON_HTE_SLICE2_IRQ_GPIO_13},
+	[22] = {2, NV_AON_HTE_SLICE2_IRQ_GPIO_12},
+	/* EE port */
+	[23] = {2, NV_AON_HTE_SLICE2_IRQ_GPIO_31},
+	[24] = {2, NV_AON_HTE_SLICE2_IRQ_GPIO_30},
+	[25] = {2, NV_AON_HTE_SLICE2_IRQ_GPIO_29},
+	[26] = {2, NV_AON_HTE_SLICE2_IRQ_GPIO_28},
+	[27] = {2, NV_AON_HTE_SLICE2_IRQ_GPIO_27},
+	[28] = {2, NV_AON_HTE_SLICE2_IRQ_GPIO_26},
+	[29] = {2, NV_AON_HTE_SLICE2_IRQ_GPIO_25},
+	[30] = {2, NV_AON_HTE_SLICE2_IRQ_GPIO_24},
+	/* GG port */
+	[31] = {2, NV_AON_HTE_SLICE2_IRQ_GPIO_23},
+};
+
+static const struct tegra_hte_line_mapped tegra234_aon_gpio_sec_map[] = {
+	/* gpio, slice, bit_index */
+	/* AA port */
+	[0]  = {2, NV_AON_HTE_SLICE2_IRQ_GPIO_11},
+	[1]  = {2, NV_AON_HTE_SLICE2_IRQ_GPIO_10},
+	[2]  = {2, NV_AON_HTE_SLICE2_IRQ_GPIO_9},
+	[3]  = {2, NV_AON_HTE_SLICE2_IRQ_GPIO_8},
+	[4]  = {2, NV_AON_HTE_SLICE2_IRQ_GPIO_7},
+	[5]  = {2, NV_AON_HTE_SLICE2_IRQ_GPIO_6},
+	[6]  = {2, NV_AON_HTE_SLICE2_IRQ_GPIO_5},
+	[7]  = {2, NV_AON_HTE_SLICE2_IRQ_GPIO_4},
+	/* BB port */
+	[8]  = {2, NV_AON_HTE_SLICE2_IRQ_GPIO_3},
+	[9]  = {2, NV_AON_HTE_SLICE2_IRQ_GPIO_2},
+	[10] = {2, NV_AON_HTE_SLICE2_IRQ_GPIO_1},
+	[11] = {2, NV_AON_HTE_SLICE2_IRQ_GPIO_0},
+	[12] = {NV_AON_SLICE_INVALID, 0},
+	[13] = {NV_AON_SLICE_INVALID, 0},
+	[14] = {NV_AON_SLICE_INVALID, 0},
+	[15] = {NV_AON_SLICE_INVALID, 0},
+	/* CC port */
+	[16] = {2, NV_AON_HTE_SLICE2_IRQ_GPIO_22},
+	[17] = {2, NV_AON_HTE_SLICE2_IRQ_GPIO_21},
+	[18] = {2, NV_AON_HTE_SLICE2_IRQ_GPIO_20},
+	[19] = {2, NV_AON_HTE_SLICE2_IRQ_GPIO_19},
+	[20] = {2, NV_AON_HTE_SLICE2_IRQ_GPIO_18},
+	[21] = {2, NV_AON_HTE_SLICE2_IRQ_GPIO_17},
+	[22] = {2, NV_AON_HTE_SLICE2_IRQ_GPIO_16},
+	[23] = {2, NV_AON_HTE_SLICE2_IRQ_GPIO_15},
+	/* DD port */
+	[24] = {2, NV_AON_HTE_SLICE2_IRQ_GPIO_14},
+	[25] = {2, NV_AON_HTE_SLICE2_IRQ_GPIO_13},
+	[26] = {2, NV_AON_HTE_SLICE2_IRQ_GPIO_12},
+	[27] = {NV_AON_SLICE_INVALID, 0},
+	[28] = {NV_AON_SLICE_INVALID, 0},
+	[29] = {NV_AON_SLICE_INVALID, 0},
+	[30] = {NV_AON_SLICE_INVALID, 0},
+	[31] = {NV_AON_SLICE_INVALID, 0},
+	/* EE port */
+	[32] = {2, NV_AON_HTE_SLICE2_IRQ_GPIO_31},
+	[33] = {2, NV_AON_HTE_SLICE2_IRQ_GPIO_30},
+	[34] = {2, NV_AON_HTE_SLICE2_IRQ_GPIO_29},
+	[35] = {2, NV_AON_HTE_SLICE2_IRQ_GPIO_28},
+	[36] = {2, NV_AON_HTE_SLICE2_IRQ_GPIO_27},
+	[37] = {2, NV_AON_HTE_SLICE2_IRQ_GPIO_26},
+	[38] = {2, NV_AON_HTE_SLICE2_IRQ_GPIO_25},
+	[39] = {2, NV_AON_HTE_SLICE2_IRQ_GPIO_24},
+	/* GG port */
+	[40] = {2, NV_AON_HTE_SLICE2_IRQ_GPIO_23},
+};
+
+static const struct tegra_hte_data t194_aon_hte = {
 	.map_sz = ARRAY_SIZE(tegra194_aon_gpio_map),
 	.map = tegra194_aon_gpio_map,
 	.sec_map_sz = ARRAY_SIZE(tegra194_aon_gpio_sec_map),
@@ -228,6 +325,14 @@ static const struct tegra_hte_data aon_hte = {
 	.type = HTE_TEGRA_TYPE_GPIO,
 };
 
+static const struct tegra_hte_data t234_aon_hte = {
+	.map_sz = ARRAY_SIZE(tegra234_aon_gpio_map),
+	.map = tegra234_aon_gpio_map,
+	.sec_map_sz = ARRAY_SIZE(tegra234_aon_gpio_sec_map),
+	.sec_map = tegra234_aon_gpio_sec_map,
+	.type = HTE_TEGRA_TYPE_GPIO,
+};
+
 static const struct tegra_hte_data lic_hte = {
 	.map_sz = 0,
 	.map = NULL,
@@ -535,7 +640,9 @@ static bool tegra_hte_match_from_linedata(const struct hte_chip *chip,
 
 static const struct of_device_id tegra_hte_of_match[] = {
 	{ .compatible = "nvidia,tegra194-gte-lic", .data = &lic_hte},
-	{ .compatible = "nvidia,tegra194-gte-aon", .data = &aon_hte},
+	{ .compatible = "nvidia,tegra194-gte-aon", .data = &t194_aon_hte},
+	{ .compatible = "nvidia,tegra234-gte-lic", .data = &lic_hte},
+	{ .compatible = "nvidia,tegra234-gte-aon", .data = &t234_aon_hte},
 	{ }
 };
 MODULE_DEVICE_TABLE(of, tegra_hte_of_match);
@@ -635,8 +742,17 @@ static int tegra_hte_probe(struct platform_device *pdev)
 
 		gc->match_from_linedata = tegra_hte_match_from_linedata;
 
-		hte_dev->c = gpiochip_find("tegra194-gpio-aon",
-					   tegra_get_gpiochip_from_name);
+		if (of_device_is_compatible(dev->of_node,
+					    "nvidia,tegra194-gte-aon"))
+			hte_dev->c = gpiochip_find("tegra194-gpio-aon",
+						tegra_get_gpiochip_from_name);
+		else if (of_device_is_compatible(dev->of_node,
+						 "nvidia,tegra234-gte-aon"))
+			hte_dev->c = gpiochip_find("tegra234-gpio-aon",
+						tegra_get_gpiochip_from_name);
+		else
+			return -ENODEV;
+
 		if (!hte_dev->c)
 			return dev_err_probe(dev, -EPROBE_DEFER,
 					     "wait for gpio controller\n");
-- 
2.17.1

