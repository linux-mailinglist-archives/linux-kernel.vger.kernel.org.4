Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D7655EABA4
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 17:51:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233627AbiIZPvC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 11:51:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234257AbiIZPuf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 11:50:35 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7DD7DF8D;
        Mon, 26 Sep 2022 07:37:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K098K+8AAq5fkaSuSJF5xAK0IVKgmqauCehQmQtibBiNj9K+Fux+x/5mrI9OqCf0g9pLQwuFKcMhBj3u27h3I3zPlqXbMqJo5Lxn+I6XOW6xIwKh0MJh7RcxSwqJHT74ot5GS5MyJMaJZOtNMp6/hGqSTfrgod5vWI1NGxafHkmf6zub57xxr9PNdhqV8OHaOnbg1suzAq3YSu+eFV7qfPvBFBH3GwjR0tAxxm9fmXJ9MvtodX8NhgKvDbAInup6gMxGLTPQSl1XXeKSo9HNpPi2Lw24VUIK5tSuD3OKkwwaP+wQ0F8KtMSoeh4wuPz82SSxUyXnmf9BETYv1vzujQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oQCaz4lnZpdHQHT2AMgN7hvPAahdH+Z++2FKH3F5jx4=;
 b=TcPTYEiK15LHPbQ6vrkvFywCW6y3GEzU1UhI6pdFrlBIOSeD8l98mrK36/ktoQKgyAAqU6Bvd6cpoMPbgsRdbWzumGEfUyrdY4+aXf1t5vSUIAZB3ruYo47z9isPho6KXxLEpL3eUowX8R3Oiyy2UhrmpEVovq30MBuNPAniYAB0ID6fmNxph5inC3TPbrdQVdwCgsmdZXBsTER1VoV2oxwBqGYtyJRFEXEPgpbLpm9evvYuyHxnvyRe3aCZoRk8DpWZcMdcryzclIIuyXumvMhnA3DBn4MWoCSaYQSXcbOBVK2TQQZk5aWB/HxGoTnGDYvcb3tH57zjn6IiH5rkYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oQCaz4lnZpdHQHT2AMgN7hvPAahdH+Z++2FKH3F5jx4=;
 b=rbzBH7i5gVSqsHwPYRx0bNigEp0F8FZYFPSTMxFamUUyIULy51tRsWUd3G+rmEcdJbXZOYuyKqtGdot+ULb/8McTcgFNA4250zeiK4g+ybb1Ykl1XtpcHd9NjwKWxHqsU32yLnuYxe6e1KUxIoikXNstt4sNkHNXY0IGprfVK6VMWT07C7cOy4/KnRJFgaPEfZB9O5qj2w+UQHN+u3aGUIGYGYdnWsMH9n7ec/p2SnIUOjbipMQiFLxF041E7A78iQC0h6U1q2UClRCcgfiOQtD+sAQ9EozauZeQZekLb7JY83uIUrjv6LIGftom8oWqBh9QhzyRwjFKgbjEU/S7+g==
Received: from MW4PR03CA0261.namprd03.prod.outlook.com (2603:10b6:303:b4::26)
 by BY5PR12MB4275.namprd12.prod.outlook.com (2603:10b6:a03:20a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.26; Mon, 26 Sep
 2022 14:37:56 +0000
Received: from CO1NAM11FT111.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b4:cafe::4e) by MW4PR03CA0261.outlook.office365.com
 (2603:10b6:303:b4::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.25 via Frontend
 Transport; Mon, 26 Sep 2022 14:37:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1NAM11FT111.mail.protection.outlook.com (10.13.174.61) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5654.14 via Frontend Transport; Mon, 26 Sep 2022 14:37:55 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Mon, 26 Sep
 2022 07:37:38 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Mon, 26 Sep 2022 07:37:37 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Mon, 26 Sep 2022 07:37:37 -0700
Received: from kkartik-desktop.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.986.29 via Frontend
 Transport; Mon, 26 Sep 2022 07:37:34 -0700
From:   Kartik <kkartik@nvidia.com>
To:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <digetx@gmail.com>, <nathan@kernel.org>, <windhl@126.com>,
        <bbiswas@nvidia.com>, <skamble@nvidia.com>,
        <ulf.hansson@linaro.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] soc/tegra: fuse: use soc specific nvmem cells
Date:   Mon, 26 Sep 2022 20:07:33 +0530
Message-ID: <1664203053-20716-1-git-send-email-kkartik@nvidia.com>
X-Mailer: git-send-email 2.7.4
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT111:EE_|BY5PR12MB4275:EE_
X-MS-Office365-Filtering-Correlation-Id: 48371039-5084-4108-99a7-08da9fccb389
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IFx42VAmSUgYv+vBWeFM1sfW73BZKCQE0C5TS8gIA4kDngpNJ1y4IMYVjASf4M8Ge5MNDOwbRcQe/x4pvWP2mvEj+hxPFzwcM9F7yqvKxAQEGIY8vxrL4CA3QFjtXBM/W+YcsXNCri+RrriKsca6b57K20bw27fyXDF1B3WyJmkkk/4Te2Dof/ryo0C5koGV0qwdDCxPsVwFhroU//s1ZJMM/nxY5A0Hi1fRP+w8oDaD98mNiw5Yiwofa5B+CCAfMboe5P/JePI9L1Oe3Onl+n3H/Wx6Q2bdETfHGXDgLwX1xT5sZey5ASOOeaGToM8ICCuKd6e5fwbmgOMZUJHXFz+DVw0x9fSPpwdrU3MnOl42HeNIoPo13DPegGynPlrAf1QmPTIDTKJZ8Lk14QS0Az9ct2LttqB8ZFedWEwDMw5JRzcbPzoQi11IER7Dcp2I1A1dtVhh8BgbAN0h3YXhzxAKR4PApQ/UcTImSq1g2mLQPlk7xcfF3Yv2wzoYhuQD3gBcR9cndKmLbOFNlt9DPhHqafnrF7g5V/fmwhKxCB/UG3g9V4gE+loTgouHoOzZ7zb822sjcV6UPA6AirVuVp8lGZf6bMloZr8GPlVikaSZisCAoBfQHtgUaHcR+21PRgZQnhP5K+WLQ/qNNBfU40ZxhjiLmtkfsCjzSiyMV2mBaaAOnnEIljj/9/r9VvaDJ+TPYoUYxhPvLW7FIOYPcs0g3/+vXC4I+XzJVsU61DyqlZR5s4VS18eke68+PVcQhxHLHUEt1Z8t/mft6HqpgEl9ynCAckxesJiviLLSlBw=
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(346002)(136003)(39860400002)(396003)(376002)(451199015)(36840700001)(46966006)(40470700004)(110136005)(2616005)(36756003)(2906002)(186003)(86362001)(30864003)(5660300002)(8936002)(7636003)(336012)(426003)(47076005)(41300700001)(921005)(26005)(40480700001)(8676002)(356005)(70206006)(70586007)(82740400003)(40460700003)(83380400001)(82310400005)(36860700001)(316002)(7696005)(478600001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2022 14:37:55.8912
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 48371039-5084-4108-99a7-08da9fccb389
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT111.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4275
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tegra fuse availability and offsets can vary from one SOC to another.

Make Tegra fuse nvmem cells SOC specific.

Signed-off-by: Kartik <kkartik@nvidia.com>
---
 drivers/soc/tegra/fuse/fuse-tegra.c   | 110 +-----------
 drivers/soc/tegra/fuse/fuse-tegra30.c | 236 +++++++++++++++++++++++++-
 drivers/soc/tegra/fuse/fuse.h         |   2 +
 3 files changed, 239 insertions(+), 109 deletions(-)

diff --git a/drivers/soc/tegra/fuse/fuse-tegra.c b/drivers/soc/tegra/fuse/fuse-tegra.c
index 8ee6092753b1..ce0b45beb22d 100644
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
index f01d8a2547b6..2db1cbc012cb 100644
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
index 2bb1f9d6a6e6..02442157b231 100644
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

