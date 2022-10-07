Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4899E5F7682
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 11:52:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229734AbiJGJwK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Oct 2022 05:52:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229740AbiJGJvl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Oct 2022 05:51:41 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2078.outbound.protection.outlook.com [40.107.95.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2C5CB9780;
        Fri,  7 Oct 2022 02:51:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MM+xCxOO8D2+6ifjVlqpL1ZTuU3ktcreqpU5zXFikbOXpLg9e+TNoXJUkz0OtCOzyRFjpsCd37Mp76RbHuEFOr/cTwDdPZqoAfqjgcOr0QEdBL870wfmaFWOp1ttB/4oQyy+M6ICHRZl1BWWOHseEgxEz20kahXVA8YQzakZKadTXkKUhfi4vhLQWYoDnCbtHa7nWvcyGdWPKUfkCkxJsad+PFRZ124KV0NiIKngtTc1VQDRDB14TxjEyzD2iRtxIwk+G+JBJTRnEmjprGctmmAaLQGdhb3nJlAoPhL+j4tOr0wVq352D1JOduUE7Mscb/bd4/QH9RNePSpJ/1rOaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vNdu+1+k70fUve2hGwbHdwQfWzJWl3XzadDLa1jrh3s=;
 b=Vqs76La2RtmPRwtTpIsLCxb+COlyYA3nned2NR6nx9PeqLAhAwcX0H/yJ8lQ3lleJzZradPgkFHk1OUUp2hxFkGXeFC0ndThqR+7NoEixwrYiKzsRmQ9YGE/R7+Y5EB6K5/8zlM9W97EfEEjPXMlR8Ih/x5P3JmnS3E6M8UX8B8SrWDZIHSk2MWqo0AWdgFsBSHL2G3WS6MtNO0xJWFizs/e+f1qY0gSHNL5GtEM/yQVesNPrDTc7uCcXDLezmD4sfvqHd1I+nImsTagYz2c8ND6qoEee9/fSQ5qdwt/6qQfiZ2wm06eB9fvHk4ikOC1aQz0PAmALZ7tDqs/BU0JvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vNdu+1+k70fUve2hGwbHdwQfWzJWl3XzadDLa1jrh3s=;
 b=PGyBd0pC2OQ51c9bO/b29du6FZCrOrMSqAg7yr7LU7PRqqCvK7nXPIIi8LkjOSVd4znZfbqTwWbbWMVexiBCjdK+MviJY7jAAAvhltR9AvZCgCDNO1u+MhY7AcOx4zTksr+8rqH2ahN0eI6E/E/LPBsJ3zn56a7rAX1rrGOYzNs9vtLyUVx0wDudt4oMAQza4SzxKkW/D5SBEezGYNjIQvYzgYND0FrsSelp/RJQ6EZb5kVJVDZ8mAtg0VVxtkuoLY9js0uo5IxSzH0bBpGBnAq5dowGy8rmpztNukwfszKDSL/9c3XOe6PJH7xZigkP46puWlhPt+0RBXxPbqn8gg==
Received: from BN9PR03CA0427.namprd03.prod.outlook.com (2603:10b6:408:113::12)
 by IA1PR12MB6091.namprd12.prod.outlook.com (2603:10b6:208:3ed::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.32; Fri, 7 Oct
 2022 09:51:27 +0000
Received: from BN8NAM11FT080.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:113:cafe::7f) by BN9PR03CA0427.outlook.office365.com
 (2603:10b6:408:113::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.15 via Frontend
 Transport; Fri, 7 Oct 2022 09:51:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BN8NAM11FT080.mail.protection.outlook.com (10.13.176.82) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5709.10 via Frontend Transport; Fri, 7 Oct 2022 09:51:26 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Fri, 7 Oct 2022
 02:51:20 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Fri, 7 Oct 2022 02:51:20 -0700
Received: from kkartik-desktop.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.986.29 via Frontend
 Transport; Fri, 7 Oct 2022 02:51:17 -0700
From:   Kartik <kkartik@nvidia.com>
To:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <digetx@gmail.com>, <kkartik@nvidia.com>, <windhl@126.com>,
        <ndesaulniers@google.com>, <nathan@kernel.org>,
        <skamble@nvidia.com>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/3] soc/tegra: fuse: add fuse nvmem keepout list
Date:   Fri, 7 Oct 2022 15:21:07 +0530
Message-ID: <1665136268-29494-3-git-send-email-kkartik@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1665136268-29494-1-git-send-email-kkartik@nvidia.com>
References: <1665136268-29494-1-git-send-email-kkartik@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT080:EE_|IA1PR12MB6091:EE_
X-MS-Office365-Filtering-Correlation-Id: 800125be-d3c4-4590-1308-08daa84980ab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: R81CXVUJD/xEKJ/bUdtTLBre2XSM3nzQJ/lqd6Ugh0qj75l4cbvm7rPh39bn371Y7Z8SCFA0xkSfx5jXxWt0JfSJfiMx1uhMtWyEWgPmwfMO84nCUIxcWBZ92hXxqOgRtSriY6U45FXw/o+m3rKFA/DCRaHn05CRp/6OgsPBOMqnyg1l4CM9BDDjMwlarB/nxIZKE+zZOU+FVuGgaXP3mpXVj/2nXCNJU7Bmn7DVfNevCEeOk0T5QO1PmIOgKtUC2KyaYLoVvSuM4rwAUaNTpYrsuMeiNxsOvFM+wipF4bWjO0oevvZOHFvXGI2v4tOGTgiIR5cimuUE/25eW+/eYTCg7MxeksTQVMq/oOTF5bJTkNIs1cCByjXzb2hRGaZprYKB7ZtZsGEyoP7nPQ1nnj2Cp8gzVnmb1nRSP7ltbqA/6rWqqnZxNCeXz2MPpvg60VHA7sW4W6dQiqauksmA28X//en89z7csgEoK8Kzd0b2ii4qjlKaUFMsnOGnF9S9VKIcRSJJ/qQCDu61BAah8JLCbh5TGOT1sJNUHfB5CwXBMbIAVRrXBLjm76p3/0LIb8VutgsPNMk9L/kPPhqVT8lnQsiKr55jmg82ALlYJZyqPmDvn0dRgCtUFAI6cxtK143jrCOeqgUBQSj9gSm/P+DBAtlYMLyA7fKVC95blC2vQy1FQPCFkXKBnktZ5tMFrUxSRlfWpa3zXqdiqbDUB6yiF/9saMUkCK/1R6lm8JZ/aF8IV8DVn9nwfv5m6Z1UGOnJ96m6On7TcM+6yKrOew2IpI9hsYH5fvBQ2igtb2uiZ8wzXyXdt0vUeZz6QNZw0LkfaNf2tbTWprG/ZmD2tA==
X-Forefront-Antispam-Report: CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(396003)(39860400002)(346002)(376002)(136003)(451199015)(40470700004)(36840700001)(46966006)(40460700003)(316002)(356005)(478600001)(8936002)(921005)(5660300002)(47076005)(40480700001)(426003)(336012)(86362001)(83380400001)(7696005)(82740400003)(2616005)(7636003)(36756003)(6666004)(41300700001)(2906002)(26005)(36860700001)(82310400005)(186003)(8676002)(70586007)(70206006)(110136005)(2101003)(83996005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2022 09:51:26.9089
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 800125be-d3c4-4590-1308-08daa84980ab
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT080.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6091
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tegra186 onwards, various fuse offsets are restricted and cannot be
accessed from CCPLEX. Currently nvmem binary interface allows reading
such offsets from userspace, which results in RAS errors.

Add nvmem keepout lists to avoid any reads to restricted offsets.

Signed-off-by: Kartik <kkartik@nvidia.com>
---
 drivers/soc/tegra/fuse/fuse-tegra.c   |  2 ++
 drivers/soc/tegra/fuse/fuse-tegra30.c | 38 +++++++++++++++++++++++++++
 drivers/soc/tegra/fuse/fuse.h         |  2 ++
 3 files changed, 42 insertions(+)

diff --git a/drivers/soc/tegra/fuse/fuse-tegra.c b/drivers/soc/tegra/fuse/fuse-tegra.c
index cb97b59c2d89d..a68f36e1cab8f 100644
--- a/drivers/soc/tegra/fuse/fuse-tegra.c
+++ b/drivers/soc/tegra/fuse/fuse-tegra.c
@@ -149,6 +149,8 @@ static int tegra_fuse_probe(struct platform_device *pdev)
 	nvmem.owner = THIS_MODULE;
 	nvmem.cells = fuse->soc->cells;
 	nvmem.ncells = fuse->soc->num_cells;
+	nvmem.keepout = fuse->soc->keepouts;
+	nvmem.nkeepout = fuse->soc->num_keepouts;
 	nvmem.type = NVMEM_TYPE_OTP;
 	nvmem.read_only = true;
 	nvmem.root_only = true;
diff --git a/drivers/soc/tegra/fuse/fuse-tegra30.c b/drivers/soc/tegra/fuse/fuse-tegra30.c
index 86547be567af0..932a03c64534a 100644
--- a/drivers/soc/tegra/fuse/fuse-tegra30.c
+++ b/drivers/soc/tegra/fuse/fuse-tegra30.c
@@ -9,6 +9,7 @@
 #include <linux/io.h>
 #include <linux/kernel.h>
 #include <linux/nvmem-consumer.h>
+#include <linux/nvmem-provider.h>
 #include <linux/of_device.h>
 #include <linux/of_address.h>
 #include <linux/platform_device.h>
@@ -494,6 +495,14 @@ static const struct nvmem_cell_lookup tegra186_fuse_lookups[] = {
 	},
 };
 
+static const struct nvmem_keepout tegra186_fuse_keepouts[] = {
+	{ .start = 0x01c, .end = 0x0f0 },
+	{ .start = 0x138, .end = 0x198 },
+	{ .start = 0x1d8, .end = 0x250 },
+	{ .start = 0x280, .end = 0x290 },
+	{ .start = 0x340, .end = 0x344 }
+};
+
 static const struct tegra_fuse_info tegra186_fuse_info = {
 	.read = tegra30_fuse_read,
 	.size = 0x478,
@@ -507,6 +516,8 @@ const struct tegra_fuse_soc tegra186_fuse_soc = {
 	.num_lookups = ARRAY_SIZE(tegra186_fuse_lookups),
 	.cells = tegra186_fuse_cells,
 	.num_cells = ARRAY_SIZE(tegra186_fuse_cells),
+	.keepouts = tegra186_fuse_keepouts,
+	.num_keepouts = ARRAY_SIZE(tegra186_fuse_keepouts),
 	.soc_attr_group = &tegra_soc_attr_group,
 	.clk_suspend_on = false,
 };
@@ -576,6 +587,15 @@ static const struct nvmem_cell_lookup tegra194_fuse_lookups[] = {
 	},
 };
 
+static const struct nvmem_keepout tegra194_fuse_keepouts[] = {
+	{ .start = 0x01c, .end = 0x0b8 },
+	{ .start = 0x12c, .end = 0x198 },
+	{ .start = 0x1a0, .end = 0x1bc },
+	{ .start = 0x1d8, .end = 0x250 },
+	{ .start = 0x270, .end = 0x290 },
+	{ .start = 0x310, .end = 0x45c }
+};
+
 static const struct tegra_fuse_info tegra194_fuse_info = {
 	.read = tegra30_fuse_read,
 	.size = 0x650,
@@ -589,6 +609,8 @@ const struct tegra_fuse_soc tegra194_fuse_soc = {
 	.num_lookups = ARRAY_SIZE(tegra194_fuse_lookups),
 	.cells = tegra194_fuse_cells,
 	.num_cells = ARRAY_SIZE(tegra194_fuse_cells),
+	.keepouts = tegra194_fuse_keepouts,
+	.num_keepouts = ARRAY_SIZE(tegra194_fuse_keepouts),
 	.soc_attr_group = &tegra194_soc_attr_group,
 	.clk_suspend_on = false,
 };
@@ -625,6 +647,20 @@ static const struct nvmem_cell_lookup tegra234_fuse_lookups[] = {
 	},
 };
 
+static const struct nvmem_keepout tegra234_fuse_keepouts[] = {
+	{ .start = 0x01c, .end = 0x0c8 },
+	{ .start = 0x12c, .end = 0x184 },
+	{ .start = 0x190, .end = 0x198 },
+	{ .start = 0x1a0, .end = 0x204 },
+	{ .start = 0x21c, .end = 0x250 },
+	{ .start = 0x25c, .end = 0x2f0 },
+	{ .start = 0x310, .end = 0x3d8 },
+	{ .start = 0x400, .end = 0x4f0 },
+	{ .start = 0x4f8, .end = 0x7e8 },
+	{ .start = 0x8d0, .end = 0x8d8 },
+	{ .start = 0xacc, .end = 0xf00 }
+};
+
 static const struct tegra_fuse_info tegra234_fuse_info = {
 	.read = tegra30_fuse_read,
 	.size = 0x98c,
@@ -638,6 +674,8 @@ const struct tegra_fuse_soc tegra234_fuse_soc = {
 	.num_lookups = ARRAY_SIZE(tegra234_fuse_lookups),
 	.cells = tegra234_fuse_cells,
 	.num_cells = ARRAY_SIZE(tegra234_fuse_cells),
+	.keepouts = tegra234_fuse_keepouts,
+	.num_keepouts = ARRAY_SIZE(tegra234_fuse_keepouts),
 	.soc_attr_group = &tegra194_soc_attr_group,
 	.clk_suspend_on = false,
 };
diff --git a/drivers/soc/tegra/fuse/fuse.h b/drivers/soc/tegra/fuse/fuse.h
index 02442157b231c..90f23be738947 100644
--- a/drivers/soc/tegra/fuse/fuse.h
+++ b/drivers/soc/tegra/fuse/fuse.h
@@ -34,6 +34,8 @@ struct tegra_fuse_soc {
 	unsigned int num_lookups;
 	const struct nvmem_cell_info *cells;
 	unsigned int num_cells;
+	const struct nvmem_keepout *keepouts;
+	unsigned int num_keepouts;
 
 	const struct attribute_group *soc_attr_group;
 
-- 
2.17.1

