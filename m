Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A8CC6962D3
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 12:56:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232459AbjBNL4Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 06:56:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232234AbjBNL4N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 06:56:13 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2058.outbound.protection.outlook.com [40.107.244.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 728A624133;
        Tue, 14 Feb 2023 03:56:11 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hVurhpdi9m6r+TxKXGGNMXErLbq+jgVJpsl1CtM9u1dM8IZYKCUk0YSF3eJVJiDowuTPIG1pBqHdoKreO15tmkzN9KY6Jtk2wWNS4co59AFALWtn5OSPC4muyNNYoSqNThztSCr9reHV8Cs6irfMRvF7z2KkpyrWfGO7DDxqsSpCwYacIrZkQDk4KNKq1nao018RzFwgYNLJUhID6hwwqhV68o7JfplSoCyePUJKaCihc7Nbgumcaju3lQXTz1Gks4dt72J2AprrcyXI86U7013Vt9eEV2H14hMS5wWg9oMKSU2PMTLhaN1xKLjyPWn/WG9uITA7b1iNpAvNvCbI+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q9tk4ARCk6AIkrPGuyN1R40IOh/PGMhlHTCbvJejsHE=;
 b=VELER5HsLz5tL378I3m4NFP5jIv1A7giSLARbyjav3So9mPA4a9Wr7Ltm7YG5OcdL7o9Vm+ctz1cB/Dr/OZ0slLeiaqGmnjxD0c2U3/hh0Sn8D7MUnPGuRfdcSOstczR92k3wq1GvEfGnYey2PQpd+c6dLVRGMualPRiXr9gKAfNjnxKbzFoq0Fp9Bw1ppjrKI5eloRUS+2QlZKjxuVL33wRUExbYVB3cQTyGDiVmOgt0MF7OcpMKIv2VwTF41vqOXDCcrb6kZO0h/5+dqpZ1ZVICBkxJz+3vHZNyXp5dX6bVkdqQyqXMhtYll5n9emU3K2yOC2qg6bLMMqCiFapfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q9tk4ARCk6AIkrPGuyN1R40IOh/PGMhlHTCbvJejsHE=;
 b=BpqZFds7Rf761rettAJW/pBCWxzbeznqqTGRWwIuh7cDWx4BYApaq7x7stemkJhqtQimDLAHiREkytXcpyzLZM+xyyeNTDcb9YBwvqNdr1HC7RTDvfBQxImIdK3kuVfL7TQJMKO6Qd6ORwFo2DfoLYODneuN1d6PBsYYEn6sZuhLDRvLRgcU28KW5vZV2NIaPI4lnFqZtbIOM/6o3sahfK1zXw/qZIHu9umvyEslUuVtejuEWslLpTHCQkbdYsVnYDYc7CJoOfJywOmaou6jIxKpIZeXAQK48Q4AHa4DBMrRU5x/QAxhu+a3+EGX80knC4BRVOfcMjlO/DYzmuQ4pw==
Received: from DS7PR05CA0074.namprd05.prod.outlook.com (2603:10b6:8:57::22) by
 DS7PR12MB8323.namprd12.prod.outlook.com (2603:10b6:8:ec::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6086.24; Tue, 14 Feb 2023 11:56:09 +0000
Received: from DM6NAM11FT105.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:57:cafe::df) by DS7PR05CA0074.outlook.office365.com
 (2603:10b6:8:57::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.10 via Frontend
 Transport; Tue, 14 Feb 2023 11:56:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DM6NAM11FT105.mail.protection.outlook.com (10.13.173.164) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6086.24 via Frontend Transport; Tue, 14 Feb 2023 11:56:08 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Tue, 14 Feb
 2023 03:56:00 -0800
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Tue, 14 Feb
 2023 03:56:00 -0800
Received: from dipenp.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server id 15.2.986.36 via Frontend
 Transport; Tue, 14 Feb 2023 03:56:00 -0800
From:   Dipen Patel <dipenp@nvidia.com>
To:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <linux-kernel@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-gpio@vger.kernel.org>, <linus.walleij@linaro.org>,
        <devicetree@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <robh+dt@kernel.org>, <timestamp@lists.linux.dev>
CC:     Dipen Patel <dipenp@nvidia.com>
Subject: [PATCH V2 2/6] hte: Add Tegra234 provider
Date:   Tue, 14 Feb 2023 03:55:49 -0800
Message-ID: <20230214115553.10416-3-dipenp@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230214115553.10416-1-dipenp@nvidia.com>
References: <20230214115553.10416-1-dipenp@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT105:EE_|DS7PR12MB8323:EE_
X-MS-Office365-Filtering-Correlation-Id: bec962f8-5d9b-4e3b-705d-08db0e8275f6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JRaYjTGuiLtAT9cYz4mgFz/kgd24V4JYC2W+jSjF4/oq7nUIt/3xixr4Op3ryYdBkYrx9tUY6jQ/FSAq0y6id1g1Vuz+UZDEGWQFIIlxlP3xF62SfTyOyfV1hieC/SnNNkw8LNvEZCoFYoR7YZ04IlpuLsRI+uYUYLdW8wcnna+4SVNeIdD2A99nLMDXsvmUET+lwpnNxp7cLxK+8E7fbpxEpxrcE+iv3sqCOdEaFdhcz84k4Esjnta1XTAP/h5hIuY2rbDZrjrqNNR1ZXw4dg6Rwd9izLNz2ltJMEUpK7ld5O8OXTTJQPruoR8vQUTgbLaa7+0J8jVM1ff7U1tFRsbtJAW2R0cJfiGhOE51ca6aXm8fYLWH30WWyDh/pco89HPnYuPREtHa4cNNThFiCxLFH+0DDW/tJPpCN1FF4qMEahF4krAUNhc7wS0jzlzaB80YvYzgZhVN8IydgfIhblyopnSGV4ji67thWc0+EeY7R611zq+bElUy+4VGv3Kx09v1n/6ceciImOwQdaRsye9w7YSzud6EV/LBVQvUN8y8rwXwq4iTEQ5Maz34wbNdJCA/tVjGVLMIv66ZDW2k++lxtQvw3luNuLc39qN8CICkmjjuyxhkBOFgKCqk86ZxNzjFqBw8yTU2fqYYFeyiNKdKUfw7iyzXiCujCnonOslPQdf09syHw4e/AQsdBgLAMiwmqbZyos8Tdb8i1rtK8H5XGDJoVa50FFjl6L0294NairrM08+aW2V8J3GFFufNAhy6HYtGcbSnk87yQku1aQ==
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(376002)(39860400002)(346002)(396003)(136003)(451199018)(36840700001)(46966006)(40470700004)(36756003)(356005)(921005)(40460700003)(86362001)(316002)(8676002)(70206006)(4326008)(110136005)(70586007)(478600001)(7696005)(41300700001)(8936002)(82310400005)(5660300002)(2906002)(40480700001)(36860700001)(83380400001)(7636003)(82740400003)(26005)(186003)(6666004)(107886003)(1076003)(47076005)(426003)(2616005)(336012)(2101003)(83996005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2023 11:56:08.9273
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bec962f8-5d9b-4e3b-705d-08db0e8275f6
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT105.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8323
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Tegra234 AON GPIO instance and LIC IRQ support HTE. For the GPIO
HTE support, it requires to add mapping between GPIO and HTE framework.

Signed-off-by: Dipen Patel <dipenp@nvidia.com>
---
v2: Changed how gpio_chip could be aquired for the mapping

 drivers/hte/hte-tegra194-test.c |   2 +-
 drivers/hte/hte-tegra194.c      | 153 ++++++++++++++++++++++++++++----
 2 files changed, 139 insertions(+), 16 deletions(-)

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
index 49a27af22742..7f0d6e7efd34 100644
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
@@ -114,6 +118,7 @@ struct tegra_hte_line_data {
 
 struct tegra_hte_data {
 	enum tegra_hte_type type;
+	u32 slices;
 	u32 map_sz;
 	u32 sec_map_sz;
 	const struct tegra_hte_line_mapped *map;
@@ -220,18 +225,129 @@ static const struct tegra_hte_line_mapped tegra194_aon_gpio_sec_map[] = {
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
 	.sec_map = tegra194_aon_gpio_sec_map,
 	.type = HTE_TEGRA_TYPE_GPIO,
+	.slices = 3,
 };
 
-static const struct tegra_hte_data lic_hte = {
+static const struct tegra_hte_data t234_aon_hte = {
+	.map_sz = ARRAY_SIZE(tegra234_aon_gpio_map),
+	.map = tegra234_aon_gpio_map,
+	.sec_map_sz = ARRAY_SIZE(tegra234_aon_gpio_sec_map),
+	.sec_map = tegra234_aon_gpio_sec_map,
+	.type = HTE_TEGRA_TYPE_GPIO,
+	.slices = 3,
+};
+
+static const struct tegra_hte_data t194_lic_hte = {
 	.map_sz = 0,
 	.map = NULL,
 	.type = HTE_TEGRA_TYPE_LIC,
+	.slices = 11,
+};
+
+static const struct tegra_hte_data t234_lic_hte = {
+	.map_sz = 0,
+	.map = NULL,
+	.type = HTE_TEGRA_TYPE_LIC,
+	.slices = 17,
 };
 
 static inline u32 tegra_hte_readl(struct tegra_hte_soc *hte, u32 reg)
@@ -534,8 +650,10 @@ static bool tegra_hte_match_from_linedata(const struct hte_chip *chip,
 }
 
 static const struct of_device_id tegra_hte_of_match[] = {
-	{ .compatible = "nvidia,tegra194-gte-lic", .data = &lic_hte},
-	{ .compatible = "nvidia,tegra194-gte-aon", .data = &aon_hte},
+	{ .compatible = "nvidia,tegra194-gte-lic", .data = &t194_lic_hte},
+	{ .compatible = "nvidia,tegra194-gte-aon", .data = &t194_aon_hte},
+	{ .compatible = "nvidia,tegra234-gte-lic", .data = &t234_lic_hte},
+	{ .compatible = "nvidia,tegra234-gte-aon", .data = &t234_aon_hte},
 	{ }
 };
 MODULE_DEVICE_TABLE(of, tegra_hte_of_match);
@@ -556,9 +674,9 @@ static void tegra_gte_disable(void *data)
 	tegra_hte_writel(gs, HTE_TECTRL, 0);
 }
 
-static int tegra_get_gpiochip_from_name(struct gpio_chip *chip, void *data)
+static int tegra_get_gpiochip_from_of_node(struct gpio_chip *chip, void *data)
 {
-	return !strcmp(chip->label, data);
+	return chip->of_node == data;
 }
 
 static int tegra_hte_probe(struct platform_device *pdev)
@@ -569,16 +687,10 @@ static int tegra_hte_probe(struct platform_device *pdev)
 	struct device *dev;
 	struct tegra_hte_soc *hte_dev;
 	struct hte_chip *gc;
+	struct device_node *gpio_ctrl;
 
 	dev = &pdev->dev;
 
-	ret = of_property_read_u32(dev->of_node, "nvidia,slices", &slices);
-	if (ret != 0) {
-		dev_err(dev, "Could not read slices\n");
-		return -EINVAL;
-	}
-	nlines = slices << 5;
-
 	hte_dev = devm_kzalloc(dev, sizeof(*hte_dev), GFP_KERNEL);
 	if (!hte_dev)
 		return -ENOMEM;
@@ -590,6 +702,9 @@ static int tegra_hte_probe(struct platform_device *pdev)
 	dev_set_drvdata(&pdev->dev, hte_dev);
 	hte_dev->prov_data = of_device_get_match_data(&pdev->dev);
 
+	slices = hte_dev->prov_data->slices;
+	nlines = slices << 5;
+
 	hte_dev->regs = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(hte_dev->regs))
 		return PTR_ERR(hte_dev->regs);
@@ -635,8 +750,16 @@ static int tegra_hte_probe(struct platform_device *pdev)
 
 		gc->match_from_linedata = tegra_hte_match_from_linedata;
 
-		hte_dev->c = gpiochip_find("tegra194-gpio-aon",
-					   tegra_get_gpiochip_from_name);
+		gpio_ctrl = of_parse_phandle(dev->of_node,
+					     "nvidia,gpio-controller", 0);
+		if (!gpio_ctrl) {
+			dev_err(dev, "gpio controller node not found\n");
+			return -ENODEV;
+		}
+
+		hte_dev->c = gpiochip_find(gpio_ctrl,
+					   tegra_get_gpiochip_from_of_node);
+		of_node_put(gpio_ctrl);
 		if (!hte_dev->c)
 			return dev_err_probe(dev, -EPROBE_DEFER,
 					     "wait for gpio controller\n");
-- 
2.17.1

