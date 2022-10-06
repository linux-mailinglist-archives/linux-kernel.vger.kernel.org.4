Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 176125F5F8B
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 05:21:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230122AbiJFDVy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 23:21:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230189AbiJFDUi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 23:20:38 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2046.outbound.protection.outlook.com [40.107.92.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3D4588DC1;
        Wed,  5 Oct 2022 20:20:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JWF7UdtvIrhwSBl3z8epaQiafXqM0Rt8eU2GjZrY5MzJStjROVI2hIOai00NQfJWuhjzJRczbcXapeh0jwb8tu+ABtlwMbH5CvhzTUuQNgY3l13ZXulTdi/VPQkVoCuFznCXxspaKvjlHGxIgdNP0lkqhwq7sE0Xn8QNNlLA0LhOhGOFnLgMmD1/UBOpFvmZZGaMFiIC0rKKbbW2JEpo9OmBDHp5NnJprr9MnYXCJ0gSBTWT2hnTrNAA63te3I964Ladb2Du2pjtNP1+KxWdFscNgtYeL8ZpvdyCBETOcq4k7uFWI6fM/eSsZU+i4DE5DIog5QKOugcXOHyBqJ2BzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nFqgZ6hkvB+UNHlLEnApNNs+eawUZVXnNm+limTbryI=;
 b=aPz4hniV9+7w6Q8zy9JCkPcJr0nXtOIDqUxt0MiIssFAoao4PEdjJAz2raiaYamCx4B3yuAhiSOG+QUWC1l3S6SKj/Q5P+IEdoo14uFolFseafQ0tlV8nb3S69W2dB/78l8yA7w766JZN2BdKcUBhHLtu8/RPvFxtT78aFYhqLJviu5BQ3V4wpnUu2PzUmPc34XUuJQqLB/kLnW9EUkWf08FJ+nRiFgoBaf5KaHVFS1Ztf+eGPaCxbmY9WSWU+O0qX8CVTVjACHwwAjgkfCCEzuclbz7gjFjfCxEvg8bBY+ibnG6ELmxJtwnvqra+ngMUd/tOMhbf3r/YFo9pzip4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nFqgZ6hkvB+UNHlLEnApNNs+eawUZVXnNm+limTbryI=;
 b=NtJoBb5iBFifQEhCjGiXBlop1y3YmUvBadilEnoqPKwqr9nVr6k5QDtVOdJp8TS4mcdDuhSb4gTSkPkNvRpTQBWa/WRFzjWFIZWX6jpTAG/Y2d3yKI6dc5EvF7u9/8eE5PsR3cSwzhUbX6/5UMNXAnSv2Jv8KjNJBDx0XYNAvOAZ7R+e3xb6viOFFs5YODs5hJXX7rFNyhOq5yKRHCf8BdL5N8FeopPitIAhsUyStgfWR6PTePul6XSKubL2CAkRT9nOQ1ZVYTO1s+PIWxjoJn+HLfStKcDAVWgp9imP6YbYfiAZALsnMJUKZSGNsU2pZalO7ZzTtUGx+4pkW7oxCQ==
Received: from DM6PR18CA0005.namprd18.prod.outlook.com (2603:10b6:5:15b::18)
 by BL1PR12MB5732.namprd12.prod.outlook.com (2603:10b6:208:387::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.28; Thu, 6 Oct
 2022 03:20:06 +0000
Received: from DM6NAM11FT066.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:15b:cafe::10) by DM6PR18CA0005.outlook.office365.com
 (2603:10b6:5:15b::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.31 via Frontend
 Transport; Thu, 6 Oct 2022 03:20:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DM6NAM11FT066.mail.protection.outlook.com (10.13.173.179) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5709.10 via Frontend Transport; Thu, 6 Oct 2022 03:20:06 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Wed, 5 Oct 2022
 20:20:01 -0700
Received: from dev.nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Wed, 5 Oct 2022
 20:20:00 -0700
From:   Chaitanya Kulkarni <kch@nvidia.com>
To:     <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <axboe@kernel.dk>, <kch@nvidia.com>,
        <damien.lemoal@opensource.wdc.com>, <johannes.thumshirn@wdc.com>,
        <bvanassche@acm.org>, <ming.lei@redhat.com>,
        <shinichiro.kawasaki@wdc.com>, <vincent.fu@samsung.com>,
        <yukuai3@huawei.com>
Subject: [PATCH V2 7/7] null_blk: add param to set max write-zeroes sects
Date:   Wed, 5 Oct 2022 20:18:29 -0700
Message-ID: <20221006031829.37741-8-kch@nvidia.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20221006031829.37741-1-kch@nvidia.com>
References: <20221006031829.37741-1-kch@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT066:EE_|BL1PR12MB5732:EE_
X-MS-Office365-Filtering-Correlation-Id: a732949e-ade9-4721-ec95-08daa749aabb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FEEdvXolkIKyG17UMTtvrzOAhEoDox2pNPVChpmJcv3HMfQKDXKVDl+Fnlxcuc3cXOwKx76Ze0WxmnmstYQSCWxzciwctZB8zbLZRyCzYdst/lm86+zjVHDuOhozvtSorTUnkHCiFy1GHgmzY04UYQM5dIQiWMpqv9wCJFlLXU7/QEkH9fIOLMulzPc1AZ5EQPH9plztNLtIA6VSBju1PkUEZ0BWRE+M46m/drizdfqOsvMZY2PoAz82zsBIRSlOXA2a/9ejE2Q4pf/2OOGUcVC7OhZD2+cMfnH7BucFWEwVBy0Be1DG16EpyeLs0gYDiwvw19tYENqHneREYZTmbGUkXjmyuMjnJMldO/+mY3ZiOhlUztGQx2RNuJQeTS1iFUiNjzpXSUakDIMf5aerOp5YFtU5yR5VIoGVcGxaAhgC++cjJcqDwEGJn2mzq4hqrfyuxtCa3Rt97W+3Q+rrkb3WdTSAe47Y0YQ5DoLLWctNB+hHiFot5rfhmNUUPyvv6dJipjpjpYRVm7dmzU+I7yx/iJqxim9FnlgZ7SqYEF76QD5UrooBtYiCG9WY+9hg7NzKhqJVsavO73ADIZg9M5t2yfEEXzT5LCwpogV9+dYOyGsAJT4fbEs8NsNm2I1UHrxcGds4JdqYES9YdQlClV9hitnySDpsZdHV+qryDyRCHrz8Zr0mM/2ieLYbCmkp6pXu+/YGvX9JEQJu9uc7fYD4TArVGWmj5xRGbJQO7yi/Hvi28iyOWBSPpVhu+5ZIMggkWAYCYWjge0RapNySBQ==
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(376002)(136003)(396003)(39860400002)(346002)(451199015)(40470700004)(46966006)(36840700001)(8936002)(36756003)(54906003)(356005)(5660300002)(7416002)(478600001)(82310400005)(110136005)(40460700003)(6666004)(36860700001)(186003)(426003)(336012)(82740400003)(1076003)(47076005)(2616005)(26005)(7636003)(16526019)(83380400001)(40480700001)(2906002)(316002)(8676002)(4326008)(70206006)(70586007)(41300700001)(7696005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2022 03:20:06.3677
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a732949e-ade9-4721-ec95-08daa749aabb
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT066.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5732
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of hardcoding value for the maximum write-zeroes sector to
UINT_MAX >> 9, allow user to set the value with newly added module
parameter max_write_zeroes_sectors.

Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
---
 drivers/block/null_blk/main.c     | 10 +++++++++-
 drivers/block/null_blk/null_blk.h |  1 +
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
index 2f787807cf63..8b7f42024f14 100644
--- a/drivers/block/null_blk/main.c
+++ b/drivers/block/null_blk/main.c
@@ -224,6 +224,10 @@ static bool g_write_zeroes;
 module_param_named(write_zeroes, g_write_zeroes, bool, 0444);
 MODULE_PARM_DESC(write_zeroes, "Support write-zeores operations. Default: false");
 
+static unsigned int g_max_write_zeroes_sectors = UINT_MAX >> 9;
+module_param_named(max_write_zeroes_sectors, g_max_write_zeroes_sectors, uint, 0444);
+MODULE_PARM_DESC(max_write_zeroes_sectors, "Maximum size of a REQ_OP_WRITE_ZEROES command (in 512B sectors).");
+
 static unsigned long g_cache_size;
 module_param_named(cache_size, g_cache_size, ulong, 0444);
 MODULE_PARM_DESC(mbps, "Cache size in MiB for memory-backed device. Default: 0 (none)");
@@ -425,6 +429,7 @@ NULLB_DEVICE_ATTR(queue_mode, uint, NULL);
 NULLB_DEVICE_ATTR(blocksize, uint, NULL);
 NULLB_DEVICE_ATTR(max_sectors, uint, NULL);
 NULLB_DEVICE_ATTR(max_discard_sectors, uint, NULL);
+NULLB_DEVICE_ATTR(max_write_zeroes_sectors, uint, NULL);
 NULLB_DEVICE_ATTR(irqmode, uint, NULL);
 NULLB_DEVICE_ATTR(hw_queue_depth, uint, NULL);
 NULLB_DEVICE_ATTR(index, uint, NULL);
@@ -550,6 +555,7 @@ static struct configfs_attribute *nullb_device_attrs[] = {
 	&nullb_device_attr_blocksize,
 	&nullb_device_attr_max_sectors,
 	&nullb_device_attr_max_discard_sectors,
+	&nullb_device_attr_max_write_zeroes_sectors,
 	&nullb_device_attr_irqmode,
 	&nullb_device_attr_hw_queue_depth,
 	&nullb_device_attr_index,
@@ -693,6 +699,7 @@ static struct nullb_device *null_alloc_dev(void)
 	dev->blocksize = g_bs;
 	dev->max_sectors = g_max_sectors;
 	dev->max_discard_sectors = g_max_discard_sectors;
+	dev->max_write_zeroes_sectors = g_max_write_zeroes_sectors;
 	dev->irqmode = g_irqmode;
 	dev->hw_queue_depth = g_hw_queue_depth;
 	dev->blocking = g_blocking;
@@ -1865,7 +1872,8 @@ static void null_config_write_zeroes(struct nullb *nullb)
 {
 	if (!nullb->dev->write_zeroes)
 		return;
-	blk_queue_max_write_zeroes_sectors(nullb->q, UINT_MAX >> 9);
+	blk_queue_max_write_zeroes_sectors(nullb->q,
+			nullb->dev->max_write_zeroes_sectors);
 }
 
 static const struct block_device_operations null_bio_ops = {
diff --git a/drivers/block/null_blk/null_blk.h b/drivers/block/null_blk/null_blk.h
index 09940211326d..e692c2a7369e 100644
--- a/drivers/block/null_blk/null_blk.h
+++ b/drivers/block/null_blk/null_blk.h
@@ -103,6 +103,7 @@ struct nullb_device {
 	unsigned int blocksize; /* block size */
 	unsigned int max_sectors; /* Max sectors per command */
 	unsigned int max_discard_sectors; /* Max discard sectors per command */
+	unsigned int max_write_zeroes_sectors; /* Max write-zeroes sectors per command */
 	unsigned int irqmode; /* IRQ completion handler */
 	unsigned int hw_queue_depth; /* queue depth */
 	unsigned int index; /* index of the disk, only valid with a disk */
-- 
2.29.0

