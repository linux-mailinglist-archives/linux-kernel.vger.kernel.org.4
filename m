Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 554CD5F7686
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 11:52:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229730AbiJGJwZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Oct 2022 05:52:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229805AbiJGJvv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Oct 2022 05:51:51 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8761FCA8B4;
        Fri,  7 Oct 2022 02:51:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M8mk5i+549jgcZf92MwgOVPLie1/mMaGDwuHm9QsbSagS+F4X/3IzwmuGnYMq09GQdYS9w+bUEHAzI7r4pe0ruCwldCKhVWFjxbeCCVGSc0pxwbxEeHBVix0pyCms+3tBo7tQNWzzyBmLvlCzj7tG44k2jNUBZEq3XgBkX6DPa1cPQ+gSxs02RYwyWcldOTcBjnsqOD+bfh6GvV/FhsnPGE9l/N7V7jwreYd+a6WTPu0tKDtktyFZNFU0sNkJeR6SXOqtmYn/fI0YYkUoNrD/yxQZycnp79katjgw4ltO8/dhrk6L8itSOjOkVvtSC8YuPlmRCuU00c1YHDG7JvwNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+8cSDXU0EPK12iY8g+Kd5atNI5mVyNKV0QQWHvTEnS0=;
 b=AIsWToCdw5nPmgpdVY0IRqei+ZdpshP9YncdQsFWtwEN0BANik8zKtbZR7HPiXr7hgYP3PFAsf8Er/Rsl6bCBvjtKk+SCNDWYLF7NXzd7vYwBz4l7/mSpSx5hdFKfoPvfALfDYO6pb8+0503g0rqx4hCtM3DZMn8jFqCZC8a1rw4D5i8IHI++uR2fqzWBsEmNoneGNtUZhjvNMZvxgRsvttDba7UJRil3oqOpygL3pglfbtsAuB9ryN/2vTQ5GZGZ/jl0aSnCgoamNFAlX3kdIWaTpJ9nTONV5E63+wOUFa55cvk72LGqz7KmsPoFTIdUfRDhlGbWjzPLB5zIvXxQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+8cSDXU0EPK12iY8g+Kd5atNI5mVyNKV0QQWHvTEnS0=;
 b=WSTO205e0CGZGxR5sHoMo4vJ88S8Jtx+yFL/9nocBHjxBZ5OVHru7vj+WaHvKzhIr9u8wjpOAhvh51Q1te4MwDoGDE51HXZQtSSuVSLTrsGjcskKHo18bxWqO2MT1ioNlURHcY6PJu9mxl/k5Vqa/tMi0hQsqWRu2h3mQBw1/yXJL2FoiXztRVEr/geHET3dyv7p7cS4KosYMkgvtmrsHFnMwi7EJL+5/l041PVA8cUyfHfWbAeXcfQu014zGg4HwVbxtEMQIRtuRIWZWG6vaYwNWwhKSeJ5APNMvLG2wDThh0Jl3iFstykIeV2VLGkvK8zmQtNgeLsMnsj8brztpg==
Received: from BN9PR03CA0188.namprd03.prod.outlook.com (2603:10b6:408:f9::13)
 by SA1PR12MB5657.namprd12.prod.outlook.com (2603:10b6:806:234::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.28; Fri, 7 Oct
 2022 09:51:42 +0000
Received: from BN8NAM11FT106.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:f9:cafe::4a) by BN9PR03CA0188.outlook.office365.com
 (2603:10b6:408:f9::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.24 via Frontend
 Transport; Fri, 7 Oct 2022 09:51:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BN8NAM11FT106.mail.protection.outlook.com (10.13.177.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5709.10 via Frontend Transport; Fri, 7 Oct 2022 09:51:36 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Fri, 7 Oct 2022
 02:51:24 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Fri, 7 Oct 2022 02:51:23 -0700
Received: from kkartik-desktop.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.986.29 via Frontend
 Transport; Fri, 7 Oct 2022 02:51:20 -0700
From:   Kartik <kkartik@nvidia.com>
To:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <digetx@gmail.com>, <kkartik@nvidia.com>, <windhl@126.com>,
        <ndesaulniers@google.com>, <nathan@kernel.org>,
        <skamble@nvidia.com>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 3/3] soc/tegra: fuse: add opt-dla-disable nvmem cell
Date:   Fri, 7 Oct 2022 15:21:08 +0530
Message-ID: <1665136268-29494-4-git-send-email-kkartik@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1665136268-29494-1-git-send-email-kkartik@nvidia.com>
References: <1665136268-29494-1-git-send-email-kkartik@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT106:EE_|SA1PR12MB5657:EE_
X-MS-Office365-Filtering-Correlation-Id: 18398717-e322-4258-8a78-08daa8498672
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 55b2B1+LMt/itKwoaQjEERznOgDpG1zav4HRbncUnRhY5vdO0G5T505GV1N+NeS/iQHMDgHh43KH+25J4YRQXlFsEV07v1Ya+r5Tf/YZmW0RZPqAODEsPhSlCK4K3NwuhsWz8q7lWYqiwkyTZcgZ2Swz1IdSfrMHDjOhBj2yHHZJ1C7EVToOdB2TjTh/YJSZlv+ALGy6oObHeMRQ/9/fZMjYs8KRDHOu6e7hXDV8nlRaWoxl1Px9wFpQgmQpZ2g1ku+qXLlrUsorsZgrOB4bmqp6/zwbhB5/9w3UZq0WIo4olqA0YSDwAiu96IAMnQz3nPsHpqKHK0avgbt9lyaSzYDM1U73sF23llkT7TxD+iyrEFvvCqw1BJx1uGw1IwVCAEuK1afKnYxwsZlNn3JuvwxRRhvKe8zGHLN5cM/XjL+L7/aJpyb37rvtl30Pjkdlfe/Z/bYAnFCXYBRd4SrKs13xshKN9MiYMuIvj5huPY6y3qouWoN3VLzRGA8esWxbbF0/HSYi6hTiYJEMfk8v7oiN/7USSF3luou9VkyTab/IzAGtWfn19MN2mr02Ssr1nNNfxt23fKhDfejsl3YCo/OU9KwjQHgYEejA7xN61oICWkq7PZL6fdwmTXKs9JkfASu/Tl5SLkYZ1NKjsVMsEL6A+msRAmxkIjHYGjlY39ZtmCdtHm4gFG3jdUhk/7GXWPFmxEmjCeBZgS5SEkZrCyXscXLb0QTkqyWwEf/VuGvcBg7q8TNUQ8U9+8XAN1WkkWExFl2nChthQos0yv4C2XfZokKvfSPp88TVrVceoX6yFxIjZ5ehnvs6yPPtN9nfjiLIA/eCBSYH2CtY/hnrIw==
X-Forefront-Antispam-Report: CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(396003)(39860400002)(346002)(376002)(136003)(451199015)(46966006)(40470700004)(36840700001)(6666004)(70206006)(8676002)(86362001)(82310400005)(40460700003)(7696005)(70586007)(36860700001)(82740400003)(921005)(40480700001)(336012)(356005)(2616005)(186003)(478600001)(36756003)(2906002)(26005)(316002)(7636003)(8936002)(47076005)(426003)(110136005)(83380400001)(41300700001)(5660300002)(2101003)(83996005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2022 09:51:36.6204
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 18398717-e322-4258-8a78-08daa8498672
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT106.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB5657
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tegra234 DLA (Deep Learning Accelerator) driver requires access to
opt_dla_disable fuse to correctly identify internal or production
boards.

Add nvmem cell "opt-dla-disable" for Tegra234 SOC, this allows DLA
driver to read opt_dla_disable fuse via nvmem interface.

Signed-off-by: Kartik <kkartik@nvidia.com>
---
 drivers/soc/tegra/fuse/fuse-tegra30.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/soc/tegra/fuse/fuse-tegra30.c b/drivers/soc/tegra/fuse/fuse-tegra30.c
index 932a03c64534a..0ee907af655b3 100644
--- a/drivers/soc/tegra/fuse/fuse-tegra30.c
+++ b/drivers/soc/tegra/fuse/fuse-tegra30.c
@@ -630,6 +630,12 @@ static const struct nvmem_cell_info tegra234_fuse_cells[] = {
 		.bytes = 4,
 		.bit_offset = 0,
 		.nbits = 32,
+	}, {
+		.name = "opt-dla-disable",
+		.offset = 0x3f0,
+		.bytes = 4,
+		.bit_offset = 0,
+		.nbits = 32,
 	},
 };
 
@@ -644,6 +650,16 @@ static const struct nvmem_cell_lookup tegra234_fuse_lookups[] = {
 		.cell_name = "xusb-pad-calibration-ext",
 		.dev_id = "3520000.padctl",
 		.con_id = "calibration-ext",
+	}, {
+		.nvmem_name = "fuse",
+		.cell_name = "opt-dla-disable",
+		.dev_id = "15880000.nvdla0",
+		.con_id = "dla-disable",
+	}, {
+		.nvmem_name = "fuse",
+		.cell_name = "opt-dla-disable",
+		.dev_id = "158c0000.nvdla1",
+		.con_id = "dla-disable",
 	},
 };
 
-- 
2.17.1

