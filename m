Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBE2D5F7685
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 11:52:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229469AbiJGJwU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Oct 2022 05:52:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229791AbiJGJvt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Oct 2022 05:51:49 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D769DA4BB5;
        Fri,  7 Oct 2022 02:51:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TefgQztbfUiWFVK9hUZTD34JRADLj9Nx4rddztDJnyVh4w4cyW1Uzr85SYvtY93mdMWtrpP5KjGiEvO5xUDf82k6e3irDr1QMLQ7HKGBx+JNPw5Mm6bss7rfk/L5NeVeehZ69K2JdccNlTDhz/N5A+HUlcP5sAenHQvhDTXe2pQwdDB4YemRG6RmR36rp/V4c1QNXE2vU7KwCYkKw8ZgwsTN3RXjBAReoH5uYSXxORLKGyKzvxEerMd2ha6iXGX9GteTw12P8AuxA4pgpNS9Sqx9+uhOX/smBMX1pTzbXuAFfs+CKlcUKjp6zTHXhPrQnRdtYySTLVQiN8EZMgmBcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XS2h8BUZhoLiUYl6A7BR8kAikK29rYY2kK/opfVVzsY=;
 b=SYubtHsoSDtkC8o5aZ4B+R+y4HGU4LEAM+J5v/MH/vylsiLPLouy5TH3xMP5owsbxDn/M8rrbV+KJ8yRXI1l2rj4WXLjyz75uQUbMaJnf8vlEdtTxBj5Pwwsr7cdAWd9B6M/HESP6TeVRzU2Z4REh4O4VeVc1Sed+rxY/fKZYFpCT4rxDCyYIay6OxpgNdLMsXPHlQ+DMeSvquQn6cy1sTw6bOnFQlHhik347FzBDWC8OPQ16pVi3O6R7y17kgUESBfQF4itvHqya+Fc3DJyDMlDAR5tQF+UK3ICHaciaG/c6DrmhvUt4gQILXI0Gejk8f/IoLzudte9xfNqmZf5cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XS2h8BUZhoLiUYl6A7BR8kAikK29rYY2kK/opfVVzsY=;
 b=D0nEjMyaQ6NbuCj45unuRPp4QIwk9pey/cf2JUgrk8+GsN9txDfRknfU6vKTE3sgoLUZL6N9ONP36cL/cmpTEnsSvJp0MUcQiLLJ7vP0aP3vk0JMt/vzKfmmI/rjfxyEMYsAeEXCil4jENa2G4H5w7iV8PhxFa1xDPyIn+D24hryKtC6G/T6UWleilzbiJaQbailsovk1QvWKdgS+VTG9If61Z3xrFMF9LbQTZ9/x9Yw6nQZe9lg6qe/lF6RxZxC+xVi9oXiqJMBELW4ZhyIvSXHJEd7KFBLpiohATBe364T3JeTQ214nefrZD9gbKypp6zi6dc07ve0mJSx7+3ygw==
Received: from BN9PR03CA0189.namprd03.prod.outlook.com (2603:10b6:408:f9::14)
 by MW4PR12MB6899.namprd12.prod.outlook.com (2603:10b6:303:208::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.23; Fri, 7 Oct
 2022 09:51:32 +0000
Received: from BN8NAM11FT106.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:f9:cafe::28) by BN9PR03CA0189.outlook.office365.com
 (2603:10b6:408:f9::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.24 via Frontend
 Transport; Fri, 7 Oct 2022 09:51:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BN8NAM11FT106.mail.protection.outlook.com (10.13.177.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5709.10 via Frontend Transport; Fri, 7 Oct 2022 09:51:31 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Fri, 7 Oct 2022
 02:51:17 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Fri, 7 Oct 2022 02:51:16 -0700
Received: from kkartik-desktop.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.986.29 via Frontend
 Transport; Fri, 7 Oct 2022 02:51:13 -0700
From:   Kartik <kkartik@nvidia.com>
To:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <digetx@gmail.com>, <kkartik@nvidia.com>, <windhl@126.com>,
        <ndesaulniers@google.com>, <nathan@kernel.org>,
        <skamble@nvidia.com>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/3] soc/tegra: fuse: use soc specific nvmem cells
Date:   Fri, 7 Oct 2022 15:21:06 +0530
Message-ID: <1665136268-29494-2-git-send-email-kkartik@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1665136268-29494-1-git-send-email-kkartik@nvidia.com>
References: <1665136268-29494-1-git-send-email-kkartik@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT106:EE_|MW4PR12MB6899:EE_
X-MS-Office365-Filtering-Correlation-Id: e97cba46-09f7-43c8-5960-08daa8498388
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Foe4oPuZ8/RxKj2A6wRD5jywJv0so/eBEfz/aPOQjh9U4tmr4CEUqgs6diLhKeLHk9jxC52t5vY9wndgaTq8mNTtfiAK2jtLq1PkPsjYzHGsykPIt1+TU9xYha28T9SR5+OV2h2xx60qxiYZdZ8Q2kyj2HD7bL3dTJGvgc90KmlCwD6LvnUGujKmIIYRP/BlLPLhyKZ0QwO6R3PJlr094sScKJKODeMMVDihuUczN2dfySiS9J84pgVYbKuaFk2hvc78Zuf7stAPa3DuC7bFbJNjlUHCvy08y1uZPCaZGlNxmCYrwlvw3wlqqvh29D1W/CL0mxpG43F8rctiOwzIfJOz0NSKNG8GV7+/xruUfBezWWtGB2uIV/1yV/6GFLaoZjPiNz4zuGHRNfpiz/9MF2rixVMZAwu8tdNojTWh9XfjWcSSoRV3byaXDBBzZZpW+E73bzTu8fouz/81FF0m44z9PyO4s4CCIPIT7t/lbIASr8fxrBX3VI0FIDUwjlheAAUNX4wNPaKGYm0Wu2acPgS072BQPbU8ADgueiT3mRPbHDdbJI6Dirc37507stxvQGTd/CuXgbyqjOY2+UH17ySxSKPiQv+71kMBDAUmlHGKmM0XeZFHhKneLEGomfPwyUr/kQpAwwhohDYeIOrqB7YyRbzOikV3JVe0slWmBY31EDshFj78MQLLOPgS2WPOFsNam0Yo4is/B/RgEf0vOwmYm7K6FMcKYCMCkd2codhObc0OyRgTMGK6NAm3R8ezQZ3rKf6e1jBTEmDqODghoQSEXlGuTkdrwSj5L8NIVLY/Naz1LzdH/VcPumD7yBF6IBbPAUeU/X7KuuLoZA1i+Q==
X-Forefront-Antispam-Report: CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(376002)(396003)(136003)(346002)(451199015)(46966006)(36840700001)(40470700004)(7696005)(6666004)(5660300002)(26005)(41300700001)(70206006)(8676002)(40480700001)(36756003)(336012)(921005)(47076005)(82740400003)(2616005)(426003)(83380400001)(356005)(7636003)(8936002)(30864003)(186003)(86362001)(82310400005)(40460700003)(70586007)(2906002)(478600001)(36860700001)(316002)(110136005)(83996005)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2022 09:51:31.7145
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e97cba46-09f7-43c8-5960-08daa8498388
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT106.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6899
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tegra fuse block size, availability and offsets can vary from
one SOC to another.

Fix Tegra fuse size and use SOC specific nvmem cells.

Signed-off-by: Kartik <kkartik@nvidia.com>
---
 drivers/soc/tegra/fuse/fuse-tegra.c   | 110 +-----------
 drivers/soc/tegra/fuse/fuse-tegra30.c | 240 +++++++++++++++++++++++++-
 drivers/soc/tegra/fuse/fuse.h         |   2 +
 3 files changed, 241 insertions(+), 111 deletions(-)

diff --git a/drivers/soc/tegra/fuse/fuse-tegra.c b/drivers/soc/tegra/fuse/fuse-tegra.c
index b0a8405dbdb19..cb97b59c2d89d 100644
--- a/drivers/soc/tegra/fuse/fuse-tegra.c
+++ b/drivers/soc/tegra/fuse/fuse-tegra.c
@@ -94,112 +94,6 @@ static int tegra_fuse_read(void *priv, unsigned int offset, void *value,
 	return 0;
 }
 
-static const struct nvmem_cell_info tegra_fuse_cells[] = {
-	{
-		.name = "tsensor-cpu1",
-		.offset = 0x084,
-		.bytes = 4,
-		.bit_offset = 0,
-		.nbits = 32,
-	}, {
-		.name = "tsensor-cpu2",
-		.offset = 0x088,
-		.bytes = 4,
-		.bit_offset = 0,
-		.nbits = 32,
-	}, {
-		.name = "tsensor-cpu0",
-		.offset = 0x098,
-		.bytes = 4,
-		.bit_offset = 0,
-		.nbits = 32,
-	}, {
-		.name = "xusb-pad-calibration",
-		.offset = 0x0f0,
-		.bytes = 4,
-		.bit_offset = 0,
-		.nbits = 32,
-	}, {
-		.name = "tsensor-cpu3",
-		.offset = 0x12c,
-		.bytes = 4,
-		.bit_offset = 0,
-		.nbits = 32,
-	}, {
-		.name = "sata-calibration",
-		.offset = 0x124,
-		.bytes = 1,
-		.bit_offset = 0,
-		.nbits = 2,
-	}, {
-		.name = "tsensor-gpu",
-		.offset = 0x154,
-		.bytes = 4,
-		.bit_offset = 0,
-		.nbits = 32,
-	}, {
-		.name = "tsensor-mem0",
-		.offset = 0x158,
-		.bytes = 4,
-		.bit_offset = 0,
-		.nbits = 32,
-	}, {
-		.name = "tsensor-mem1",
-		.offset = 0x15c,
-		.bytes = 4,
-		.bit_offset = 0,
-		.nbits = 32,
-	}, {
-		.name = "tsensor-pllx",
-		.offset = 0x160,
-		.bytes = 4,
-		.bit_offset = 0,
-		.nbits = 32,
-	}, {
-		.name = "tsensor-common",
-		.offset = 0x180,
-		.bytes = 4,
-		.bit_offset = 0,
-		.nbits = 32,
-	}, {
-		.name = "gpu-gcplex-config-fuse",
-		.offset = 0x1c8,
-		.bytes = 4,
-		.bit_offset = 0,
-		.nbits = 32,
-	}, {
-		.name = "tsensor-realignment",
-		.offset = 0x1fc,
-		.bytes = 4,
-		.bit_offset = 0,
-		.nbits = 32,
-	}, {
-		.name = "gpu-calibration",
-		.offset = 0x204,
-		.bytes = 4,
-		.bit_offset = 0,
-		.nbits = 32,
-	}, {
-		.name = "xusb-pad-calibration-ext",
-		.offset = 0x250,
-		.bytes = 4,
-		.bit_offset = 0,
-		.nbits = 32,
-	}, {
-		.name = "gpu-pdi0",
-		.offset = 0x300,
-		.bytes = 4,
-		.bit_offset = 0,
-		.nbits = 32,
-	}, {
-		.name = "gpu-pdi1",
-		.offset = 0x304,
-		.bytes = 4,
-		.bit_offset = 0,
-		.nbits = 32,
-	},
-};
-
 static void tegra_fuse_restore(void *base)
 {
 	fuse->base = (void __iomem *)base;
@@ -253,8 +147,8 @@ static int tegra_fuse_probe(struct platform_device *pdev)
 	nvmem.name = "fuse";
 	nvmem.id = -1;
 	nvmem.owner = THIS_MODULE;
-	nvmem.cells = tegra_fuse_cells;
-	nvmem.ncells = ARRAY_SIZE(tegra_fuse_cells);
+	nvmem.cells = fuse->soc->cells;
+	nvmem.ncells = fuse->soc->num_cells;
 	nvmem.type = NVMEM_TYPE_OTP;
 	nvmem.read_only = true;
 	nvmem.root_only = true;
diff --git a/drivers/soc/tegra/fuse/fuse-tegra30.c b/drivers/soc/tegra/fuse/fuse-tegra30.c
index f01d8a2547b6d..86547be567af0 100644
--- a/drivers/soc/tegra/fuse/fuse-tegra30.c
+++ b/drivers/soc/tegra/fuse/fuse-tegra30.c
@@ -133,6 +133,82 @@ const struct tegra_fuse_soc tegra114_fuse_soc = {
 #endif
 
 #if defined(CONFIG_ARCH_TEGRA_124_SOC) || defined(CONFIG_ARCH_TEGRA_132_SOC)
+static const struct nvmem_cell_info tegra124_fuse_cells[] = {
+	{
+		.name = "tsensor-cpu1",
+		.offset = 0x084,
+		.bytes = 4,
+		.bit_offset = 0,
+		.nbits = 32,
+	}, {
+		.name = "tsensor-cpu2",
+		.offset = 0x088,
+		.bytes = 4,
+		.bit_offset = 0,
+		.nbits = 32,
+	}, {
+		.name = "tsensor-cpu0",
+		.offset = 0x098,
+		.bytes = 4,
+		.bit_offset = 0,
+		.nbits = 32,
+	}, {
+		.name = "xusb-pad-calibration",
+		.offset = 0x0f0,
+		.bytes = 4,
+		.bit_offset = 0,
+		.nbits = 32,
+	}, {
+		.name = "tsensor-cpu3",
+		.offset = 0x12c,
+		.bytes = 4,
+		.bit_offset = 0,
+		.nbits = 32,
+	}, {
+		.name = "sata-calibration",
+		.offset = 0x124,
+		.bytes = 4,
+		.bit_offset = 0,
+		.nbits = 32,
+	}, {
+		.name = "tsensor-gpu",
+		.offset = 0x154,
+		.bytes = 4,
+		.bit_offset = 0,
+		.nbits = 32,
+	}, {
+		.name = "tsensor-mem0",
+		.offset = 0x158,
+		.bytes = 4,
+		.bit_offset = 0,
+		.nbits = 32,
+	}, {
+		.name = "tsensor-mem1",
+		.offset = 0x15c,
+		.bytes = 4,
+		.bit_offset = 0,
+		.nbits = 32,
+	}, {
+		.name = "tsensor-pllx",
+		.offset = 0x160,
+		.bytes = 4,
+		.bit_offset = 0,
+		.nbits = 32,
+	}, {
+		.name = "tsensor-common",
+		.offset = 0x180,
+		.bytes = 4,
+		.bit_offset = 0,
+		.nbits = 32,
+	}, {
+		.name = "tsensor-realignment",
+		.offset = 0x1fc,
+		.bytes = 4,
+		.bit_offset = 0,
+		.nbits = 32,
+	},
+};
+
 static const struct nvmem_cell_lookup tegra124_fuse_lookups[] = {
 	{
 		.nvmem_name = "fuse",
@@ -209,12 +285,96 @@ const struct tegra_fuse_soc tegra124_fuse_soc = {
 	.info = &tegra124_fuse_info,
 	.lookups = tegra124_fuse_lookups,
 	.num_lookups = ARRAY_SIZE(tegra124_fuse_lookups),
+	.cells = tegra124_fuse_cells,
+	.num_cells = ARRAY_SIZE(tegra124_fuse_cells),
 	.soc_attr_group = &tegra_soc_attr_group,
 	.clk_suspend_on = true,
 };
 #endif
 
 #if defined(CONFIG_ARCH_TEGRA_210_SOC)
+static const struct nvmem_cell_info tegra210_fuse_cells[] = {
+	{
+		.name = "tsensor-cpu1",
+		.offset = 0x084,
+		.bytes = 4,
+		.bit_offset = 0,
+		.nbits = 32,
+	}, {
+		.name = "tsensor-cpu2",
+		.offset = 0x088,
+		.bytes = 4,
+		.bit_offset = 0,
+		.nbits = 32,
+	}, {
+		.name = "tsensor-cpu0",
+		.offset = 0x098,
+		.bytes = 4,
+		.bit_offset = 0,
+		.nbits = 32,
+	}, {
+		.name = "xusb-pad-calibration",
+		.offset = 0x0f0,
+		.bytes = 4,
+		.bit_offset = 0,
+		.nbits = 32,
+	}, {
+		.name = "tsensor-cpu3",
+		.offset = 0x12c,
+		.bytes = 4,
+		.bit_offset = 0,
+		.nbits = 32,
+	}, {
+		.name = "sata-calibration",
+		.offset = 0x124,
+		.bytes = 4,
+		.bit_offset = 0,
+		.nbits = 32,
+	}, {
+		.name = "tsensor-gpu",
+		.offset = 0x154,
+		.bytes = 4,
+		.bit_offset = 0,
+		.nbits = 32,
+	}, {
+		.name = "tsensor-mem0",
+		.offset = 0x158,
+		.bytes = 4,
+		.bit_offset = 0,
+		.nbits = 32,
+	}, {
+		.name = "tsensor-mem1",
+		.offset = 0x15c,
+		.bytes = 4,
+		.bit_offset = 0,
+		.nbits = 32,
+	}, {
+		.name = "tsensor-pllx",
+		.offset = 0x160,
+		.bytes = 4,
+		.bit_offset = 0,
+		.nbits = 32,
+	}, {
+		.name = "tsensor-common",
+		.offset = 0x180,
+		.bytes = 4,
+		.bit_offset = 0,
+		.nbits = 32,
+	}, {
+		.name = "gpu-calibration",
+		.offset = 0x204,
+		.bytes = 4,
+		.bit_offset = 0,
+		.nbits = 32,
+	}, {
+		.name = "xusb-pad-calibration-ext",
+		.offset = 0x250,
+		.bytes = 4,
+		.bit_offset = 0,
+		.nbits = 32,
+	},
+};
+
 static const struct nvmem_cell_lookup tegra210_fuse_lookups[] = {
 	{
 		.nvmem_name = "fuse",
@@ -295,6 +455,8 @@ const struct tegra_fuse_soc tegra210_fuse_soc = {
 	.speedo_init = tegra210_init_speedo_data,
 	.info = &tegra210_fuse_info,
 	.lookups = tegra210_fuse_lookups,
+	.cells = tegra210_fuse_cells,
+	.num_cells = ARRAY_SIZE(tegra210_fuse_cells),
 	.num_lookups = ARRAY_SIZE(tegra210_fuse_lookups),
 	.soc_attr_group = &tegra_soc_attr_group,
 	.clk_suspend_on = false,
@@ -302,6 +464,22 @@ const struct tegra_fuse_soc tegra210_fuse_soc = {
 #endif
 
 #if defined(CONFIG_ARCH_TEGRA_186_SOC)
+static const struct nvmem_cell_info tegra186_fuse_cells[] = {
+	{
+		.name = "xusb-pad-calibration",
+		.offset = 0x0f0,
+		.bytes = 4,
+		.bit_offset = 0,
+		.nbits = 32,
+	}, {
+		.name = "xusb-pad-calibration-ext",
+		.offset = 0x250,
+		.bytes = 4,
+		.bit_offset = 0,
+		.nbits = 32,
+	},
+};
+
 static const struct nvmem_cell_lookup tegra186_fuse_lookups[] = {
 	{
 		.nvmem_name = "fuse",
@@ -318,7 +496,7 @@ static const struct nvmem_cell_lookup tegra186_fuse_lookups[] = {
 
 static const struct tegra_fuse_info tegra186_fuse_info = {
 	.read = tegra30_fuse_read,
-	.size = 0x300,
+	.size = 0x478,
 	.spare = 0x280,
 };
 
@@ -327,12 +505,48 @@ const struct tegra_fuse_soc tegra186_fuse_soc = {
 	.info = &tegra186_fuse_info,
 	.lookups = tegra186_fuse_lookups,
 	.num_lookups = ARRAY_SIZE(tegra186_fuse_lookups),
+	.cells = tegra186_fuse_cells,
+	.num_cells = ARRAY_SIZE(tegra186_fuse_cells),
 	.soc_attr_group = &tegra_soc_attr_group,
 	.clk_suspend_on = false,
 };
 #endif
 
 #if defined(CONFIG_ARCH_TEGRA_194_SOC)
+static const struct nvmem_cell_info tegra194_fuse_cells[] = {
+	{
+		.name = "xusb-pad-calibration",
+		.offset = 0x0f0,
+		.bytes = 4,
+		.bit_offset = 0,
+		.nbits = 32,
+	}, {
+		.name = "gpu-gcplex-config-fuse",
+		.offset = 0x1c8,
+		.bytes = 4,
+		.bit_offset = 0,
+		.nbits = 32,
+	}, {
+		.name = "xusb-pad-calibration-ext",
+		.offset = 0x250,
+		.bytes = 4,
+		.bit_offset = 0,
+		.nbits = 32,
+	}, {
+		.name = "gpu-pdi0",
+		.offset = 0x300,
+		.bytes = 4,
+		.bit_offset = 0,
+		.nbits = 32,
+	}, {
+		.name = "gpu-pdi1",
+		.offset = 0x304,
+		.bytes = 4,
+		.bit_offset = 0,
+		.nbits = 32,
+	},
+};
+
 static const struct nvmem_cell_lookup tegra194_fuse_lookups[] = {
 	{
 		.nvmem_name = "fuse",
@@ -364,7 +578,7 @@ static const struct nvmem_cell_lookup tegra194_fuse_lookups[] = {
 
 static const struct tegra_fuse_info tegra194_fuse_info = {
 	.read = tegra30_fuse_read,
-	.size = 0x300,
+	.size = 0x650,
 	.spare = 0x280,
 };
 
@@ -373,12 +587,30 @@ const struct tegra_fuse_soc tegra194_fuse_soc = {
 	.info = &tegra194_fuse_info,
 	.lookups = tegra194_fuse_lookups,
 	.num_lookups = ARRAY_SIZE(tegra194_fuse_lookups),
+	.cells = tegra194_fuse_cells,
+	.num_cells = ARRAY_SIZE(tegra194_fuse_cells),
 	.soc_attr_group = &tegra194_soc_attr_group,
 	.clk_suspend_on = false,
 };
 #endif
 
 #if defined(CONFIG_ARCH_TEGRA_234_SOC)
+static const struct nvmem_cell_info tegra234_fuse_cells[] = {
+	{
+		.name = "xusb-pad-calibration",
+		.offset = 0x0f0,
+		.bytes = 4,
+		.bit_offset = 0,
+		.nbits = 32,
+	}, {
+		.name = "xusb-pad-calibration-ext",
+		.offset = 0x250,
+		.bytes = 4,
+		.bit_offset = 0,
+		.nbits = 32,
+	},
+};
+
 static const struct nvmem_cell_lookup tegra234_fuse_lookups[] = {
 	{
 		.nvmem_name = "fuse",
@@ -395,7 +627,7 @@ static const struct nvmem_cell_lookup tegra234_fuse_lookups[] = {
 
 static const struct tegra_fuse_info tegra234_fuse_info = {
 	.read = tegra30_fuse_read,
-	.size = 0x300,
+	.size = 0x98c,
 	.spare = 0x280,
 };
 
@@ -404,6 +636,8 @@ const struct tegra_fuse_soc tegra234_fuse_soc = {
 	.info = &tegra234_fuse_info,
 	.lookups = tegra234_fuse_lookups,
 	.num_lookups = ARRAY_SIZE(tegra234_fuse_lookups),
+	.cells = tegra234_fuse_cells,
+	.num_cells = ARRAY_SIZE(tegra234_fuse_cells),
 	.soc_attr_group = &tegra194_soc_attr_group,
 	.clk_suspend_on = false,
 };
diff --git a/drivers/soc/tegra/fuse/fuse.h b/drivers/soc/tegra/fuse/fuse.h
index 2bb1f9d6a6e6d..02442157b231c 100644
--- a/drivers/soc/tegra/fuse/fuse.h
+++ b/drivers/soc/tegra/fuse/fuse.h
@@ -32,6 +32,8 @@ struct tegra_fuse_soc {
 
 	const struct nvmem_cell_lookup *lookups;
 	unsigned int num_lookups;
+	const struct nvmem_cell_info *cells;
+	unsigned int num_cells;
 
 	const struct attribute_group *soc_attr_group;
 
-- 
2.17.1

