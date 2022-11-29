Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7940A63CBDE
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 00:30:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230247AbiK2Xag (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 18:30:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230006AbiK2X37 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 18:29:59 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2058.outbound.protection.outlook.com [40.107.220.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B8CC6E57C;
        Tue, 29 Nov 2022 15:29:54 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m0MKENUU+7VBJHI0InFyKjDNZIh0PUdB5L7lD9WflVJCDs/bTvvC5VAIRKnfJpnfGnCYgnPsZpSrFvYLQ5XWfoYbkrk17YulkWMpUgq8TSzfQ424l1ofJ53FP779zTGzhNqkKsKENdhX5GI0j/2jYxJoZd3o5OB799FYZfX286uasPEkk6Ba4zUUpn0qclUpyM2raDH+dtuqKdpH96E4dYsV8DWDk8T8JW4gMkKbO5vZ5XmTVfC9yQrlymmYmusLYmUHkePfcnIzjOHXtYOa9+BHemNwPZG6NOR7fbUyJtk6UAOZkszAgxXtS8Oe/XY+tnd38WAWXM2C98L1SzY+Hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nFqgZ6hkvB+UNHlLEnApNNs+eawUZVXnNm+limTbryI=;
 b=SW+EAkj1FJ2Mrycaxng+5scVYisjZRBgvOLl+K1GQyFwGDS8VL6pGQcRITe8HizK/DDea1x8v3Z42C5vjmQVQv4X7sdual6XwIZC2DloygqVQpofP/Dn1BL2itzLQOBax/7tjkSFqvmeccNrWuTnoKsUNDh1TahaDDJC/LX24Q1+yUVqZX9TSCGeamlsrQSqmgICZLqHP620olxrjX4aHgKnQsy/aULLLV0h1+THubKC5SucNFg4K58R/pDlx9nScF913MC3nGNZuKUqshAfOkuvioRH0AU/XjqZ8HutRrnEBB1sj24vJN4qxQnHE502y69qSEpebmgVUERjJzU4dQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nFqgZ6hkvB+UNHlLEnApNNs+eawUZVXnNm+limTbryI=;
 b=Y7V7L1cB5YntI4uRFgyB31ntPDInqwUV9yJq+ALmeRGlcv/fMUwAHEhow8oGy/+GTejDv+aqJt+tvet5MQrKTlLhqZtFPMID/vCUp/SCK/rQETAb5RzZeHnIhrUY0elf14FdvBDtMKEJGZVUk55jI5ka9lOghqCAX+Rp+/WUC7w1CPtrYE6K8ysVTAcybUud1GPIeN5b+T9Ud6fBkarRMnOvIvssqytdbjdsg2dssWiz3nBizHtKJGnARqjg3NGyz3Ksiep/1C4wN8MIbRlIrP/juwHFdDXUccNu5WE0Vzrl3EvhlVAG9mJ6Scuc/f/s03naaJIkmu2yc2hy5PUPZw==
Received: from DS7PR05CA0086.namprd05.prod.outlook.com (2603:10b6:8:56::7) by
 DM4PR12MB6109.namprd12.prod.outlook.com (2603:10b6:8:ae::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5857.21; Tue, 29 Nov 2022 23:29:52 +0000
Received: from DM6NAM11FT087.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:56:cafe::4b) by DS7PR05CA0086.outlook.office365.com
 (2603:10b6:8:56::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.13 via Frontend
 Transport; Tue, 29 Nov 2022 23:29:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DM6NAM11FT087.mail.protection.outlook.com (10.13.172.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5834.8 via Frontend Transport; Tue, 29 Nov 2022 23:29:52 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Tue, 29 Nov
 2022 15:29:41 -0800
Received: from dev.nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Tue, 29 Nov
 2022 15:29:41 -0800
From:   Chaitanya Kulkarni <kch@nvidia.com>
To:     <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <axboe@kernel.dk>, <damien.lemoal@opensource.wdc.com>,
        <bvanassche@acm.org>, <shinichiro.kawasaki@wdc.com>,
        <vincent.fu@samsung.com>, Chaitanya Kulkarni <kch@nvidia.com>
Subject: [PATCH V4 7/8] null_blk: add param to set max write-zeroes sects
Date:   Tue, 29 Nov 2022 15:28:12 -0800
Message-ID: <20221129232813.37968-8-kch@nvidia.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20221129232813.37968-1-kch@nvidia.com>
References: <20221129232813.37968-1-kch@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT087:EE_|DM4PR12MB6109:EE_
X-MS-Office365-Filtering-Correlation-Id: fe1bca24-d97e-4c79-e16e-08dad2619d7f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: P+2ZIYSWRSc8rAfl6sMhkVe/UkNDTuoPY9h2W3fvk2tb5udpOpzw+D2Yk2sJHmRpVgr3CSi5cv2+zs4jYG9Ysg9PvHDoMteptC6DAbbsA4PPsdZfY/VRgx6CwtfW9QjZ9X/1F8aXX4bVHPgLtnNMc8bSwcP7SRj//uQYgiVFUK1fJSPSGoGvcNl3Snf/elIos3IXJpjUq8gh2RhjtE8NaApnmlM7mUnMSxQcAspB08US9ddkKy7wgSQ9M71/Hav/WIImtc6txO8Ad2udYz0EjmDOe4JrTrZshPMYuMnWKqDHV4MiX4xi//iDvd34kKW9yRyLivv+SHJrW4wjXY7wrppKMvAeoHAEeVjYQOI953g4ptskdXe0/swfBnc4aTVqm+Bz4nTfUXM0eWd99S0NTjd57RJ7WMZjp5bvOrQJnLGQMim58OKkCgxilru6Mld/DE13Kvqd4v9lsCFrf/AgtVY7ftAR/xQ9VqMK3nBI1xp+XQLkdqtEZP9B6u3KtaWYT67UeylcTCTUglZm/NzC6Vdc2MRuxLipZaANP0+XND68XUwmz1x0SyDpSc3Iq8k3CJqvTN9Jek2IyLM//rs9dT2ZWD6FfWYu8R1HFZoEUvK8AcJZnS2Y/vegqdygOyRx0uGzjj5BtMWGu1EYIYJdpitR4MLa17g8JwT9riUyCG8yyRA7UFzKhHZKr2CPrVb31rqBpRuZiCC7AUrtFZ9GEQ==
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(136003)(346002)(376002)(39860400002)(396003)(451199015)(36840700001)(40470700004)(46966006)(316002)(8676002)(110136005)(54906003)(26005)(426003)(16526019)(186003)(2616005)(36756003)(41300700001)(5660300002)(4326008)(70586007)(70206006)(336012)(2906002)(8936002)(82310400005)(356005)(7636003)(36860700001)(83380400001)(47076005)(82740400003)(1076003)(40460700003)(40480700001)(478600001)(7696005)(107886003)(6666004);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2022 23:29:52.0848
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fe1bca24-d97e-4c79-e16e-08dad2619d7f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT087.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6109
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

