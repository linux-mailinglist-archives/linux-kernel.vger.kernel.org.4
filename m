Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C02D5F5F6A
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 05:19:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229972AbiJFDTU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 23:19:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229886AbiJFDTE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 23:19:04 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2078.outbound.protection.outlook.com [40.107.223.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45926895EF;
        Wed,  5 Oct 2022 20:19:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AImP+QcyeM9+kmUVcVw7Hbraaq4DqimYQlPpNCw7bqdGtcgeB9jApGVetP97HFRTDd7+MRlnIYG36duPW5+UcdnQfcjeRyePYrUisQJoKjJp6gX8Nw+8ft1jRIOL3Gbm0TJVOpX0mlPprPbJp4JjI+kv+sdKFMl9kBy9ZbmncHgC1lvSMedCWgm8nOB0IIoZR11F9Mkv/yaG50EbEDktC3d7K/IXrVp1Dndi0JwYW+EmAQPuZpkXFtWB5GAMNYNEkHgGMv4tT2ku70K9fBBdx0LFylI+s/xhyNG5PqBPMJImp7ceakT88HORXo0wYK29FZhKSdiffRL/lKyw13Jo9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TQmv64da+NeRasr5CDRQ/fRlLIjqCt0lt59FOgxkGsA=;
 b=j2yzPXeQSKewpvExOKRm0U02gC7dZ/EpqVpDN7cWPeP0O0G3Dp5W7uNq6TjS9uH8xOf6mv3354T+mQtDKo2xAGEc4x4JE+WXHRVIH+PA7LpFFBDuRZxCvS1R1NCcQzD27pulSZ/aLhy4p4RuTbAf1/xzBzwKWn7jU9u2jc/lm4ty9bIGyv+YC4d9/n8NC0BgCzBN7Els1SBx1Lvn0+LYxq/xr2DazMxhgsyZnpDsIYYpPokS+mIgl9urYuvSBYjlFz7D9XtbiZ7D2zaSblfM12U3RcApW4FCTw0MTPFZdXDOMOU8P4UnTmaqPWGBsyU3SZJfk7QF89DqdVTVA+ynBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TQmv64da+NeRasr5CDRQ/fRlLIjqCt0lt59FOgxkGsA=;
 b=ShV53pzdufW90Mkoufjz3WrZZaG3bVJr07/MRL+ulptdJduC8lTn2OQ4LbulrezdIGgR2Vx9jOmtCVTHMXPn4//ROY/3M7nyoUVS4WX4UX9r07Ge2cX/GO3oEGLD61Z+F4jyPlOIx+7Fp84fwLgSErBVuBlqR9g7hCqE4z+AnS8+9VTcl4pzQVYyEDC3euUWgC/Hd2m3yY1/x6xbk/fg8NXAmikJ/zztPPNgtuqJfu3NqZDbimvLWzPpTRezxYfuhcgSWfjzXOAzgD4dNFjWRTe1/qhy4gEcF7k8aN3CQdRFgVmlwAwJv4jGnQCgiOw4pRzqKd54BXq9rMAQX8IvkA==
Received: from BN9PR03CA0108.namprd03.prod.outlook.com (2603:10b6:408:fd::23)
 by MW4PR12MB5667.namprd12.prod.outlook.com (2603:10b6:303:18a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.28; Thu, 6 Oct
 2022 03:19:00 +0000
Received: from BN8NAM11FT031.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:fd:cafe::98) by BN9PR03CA0108.outlook.office365.com
 (2603:10b6:408:fd::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.24 via Frontend
 Transport; Thu, 6 Oct 2022 03:19:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN8NAM11FT031.mail.protection.outlook.com (10.13.177.25) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5709.10 via Frontend Transport; Thu, 6 Oct 2022 03:18:59 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Wed, 5 Oct 2022
 20:18:52 -0700
Received: from dev.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Wed, 5 Oct 2022
 20:18:51 -0700
From:   Chaitanya Kulkarni <kch@nvidia.com>
To:     <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <axboe@kernel.dk>, <kch@nvidia.com>,
        <damien.lemoal@opensource.wdc.com>, <johannes.thumshirn@wdc.com>,
        <bvanassche@acm.org>, <ming.lei@redhat.com>,
        <shinichiro.kawasaki@wdc.com>, <vincent.fu@samsung.com>,
        <yukuai3@huawei.com>
Subject: [PATCH V2 1/7] null_blk: allow REQ_OP_WRITE_ZEROES
Date:   Wed, 5 Oct 2022 20:18:23 -0700
Message-ID: <20221006031829.37741-2-kch@nvidia.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20221006031829.37741-1-kch@nvidia.com>
References: <20221006031829.37741-1-kch@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT031:EE_|MW4PR12MB5667:EE_
X-MS-Office365-Filtering-Correlation-Id: eed496fd-a38f-4095-031c-08daa7498315
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sJEMVGf7kp7xaGrOHat3cBSdPASbfZ4nbOTXG7Yy82GZo+7Uy0iC8zpfs/9yLJuhabhxfZq7rFdhXE2peowMi3HdRNwnYbM7WgGPElre6a7B4kMszHsEBLJXJOmR+Ap0qgInT9PfKrIsPUTSPDb7mU5dDkRQnhGLW6XniJ6MmNqwEP7v2Zp9e4aqe+0yc/+REI3s+TSZZRHwuXkyE6kpIGkH17CPNzz+X9vSek6dXJs3/CScbOapie1w3gU97nsMYjfuhdLqW4X3wqN+6nClaV2hyzoxSv3V0ISlzApNYk432vfGN6sBtAurWX/f26VP9tQyV3L+d4rgjIssPPfUAwA5RBPEosD5pIPIjeiYX8YO+uMwoPckf8YUmR5EFBmllhGunTgEOEhH3cwRj2O9u9yn8P+otb/8zzCZafxERTfGtUhY/U25//rE7UfngS/0pKMJ9VRXfibr+LRnivUvHU3dU0FLsQeL7Pt5KxhsJ2SKJh258DIF7XYvtARHBJZXyUr6t7q0wIy+9MKMN0YcYTI65NVmige31tknzV7GyM8GSLUG89jwOPVzt6zWo8BOLZkgf2ooACmO9n0tP6Jbe8NHoFHo3ZwXu0IL6f38XmtQLerYE7Uk0EyiLEChpDhCXOEF9l3S9WuhJm/BtO+ZyXprPhBtKEsoedwmxGMbZMvUmTIr45kz8OQl3d79W6eNEw/R7Qgujb5exrjgnEQ8llKhJFBwDNskPPzwIIPbOwjff+oneVkFEJjVKbPmz099qPxCYWjONjQJ6pveS2WWeQ==
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(396003)(346002)(39860400002)(136003)(376002)(451199015)(40470700004)(46966006)(36840700001)(54906003)(6666004)(82310400005)(2616005)(110136005)(478600001)(8676002)(36756003)(316002)(40480700001)(82740400003)(4326008)(7696005)(356005)(7636003)(186003)(70586007)(47076005)(40460700003)(1076003)(336012)(426003)(83380400001)(36860700001)(16526019)(26005)(70206006)(41300700001)(7416002)(5660300002)(8936002)(2906002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2022 03:18:59.7802
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eed496fd-a38f-4095-031c-08daa7498315
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT031.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB5667
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a helper function to enable the REQ_OP_WRITE_ZEROES operations
when null_blk.

Since write-zeroes is a non-trivial I/O operation we need this to
add a blktest so we can test the non-trivial I/O path from the
application to the block layer.

Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
---
 drivers/block/null_blk/main.c     | 59 ++++++++++++++++++++++++++++++-
 drivers/block/null_blk/null_blk.h |  1 +
 2 files changed, 59 insertions(+), 1 deletion(-)

diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
index 1f154f92f4c2..2d592b4eb815 100644
--- a/drivers/block/null_blk/main.c
+++ b/drivers/block/null_blk/main.c
@@ -209,6 +209,10 @@ static bool g_discard;
 module_param_named(discard, g_discard, bool, 0444);
 MODULE_PARM_DESC(discard, "Support discard operations (requires memory-backed null_blk device). Default: false");
 
+static bool g_write_zeroes;
+module_param_named(write_zeroes, g_write_zeroes, bool, 0444);
+MODULE_PARM_DESC(write_zeroes, "Support write-zeores operations. Default: false");
+
 static unsigned long g_cache_size;
 module_param_named(cache_size, g_cache_size, ulong, 0444);
 MODULE_PARM_DESC(mbps, "Cache size in MiB for memory-backed device. Default: 0 (none)");
@@ -416,6 +420,7 @@ NULLB_DEVICE_ATTR(blocking, bool, NULL);
 NULLB_DEVICE_ATTR(use_per_node_hctx, bool, NULL);
 NULLB_DEVICE_ATTR(memory_backed, bool, NULL);
 NULLB_DEVICE_ATTR(discard, bool, NULL);
+NULLB_DEVICE_ATTR(write_zeroes, bool, NULL);
 NULLB_DEVICE_ATTR(mbps, uint, NULL);
 NULLB_DEVICE_ATTR(cache_size, ulong, NULL);
 NULLB_DEVICE_ATTR(zoned, bool, NULL);
@@ -540,6 +545,7 @@ static struct configfs_attribute *nullb_device_attrs[] = {
 	&nullb_device_attr_power,
 	&nullb_device_attr_memory_backed,
 	&nullb_device_attr_discard,
+	&nullb_device_attr_write_zeroes,
 	&nullb_device_attr_mbps,
 	&nullb_device_attr_cache_size,
 	&nullb_device_attr_badblocks,
@@ -614,7 +620,7 @@ static ssize_t memb_group_features_show(struct config_item *item, char *page)
 			"poll_queues,power,queue_mode,shared_tag_bitmap,size,"
 			"submit_queues,use_per_node_hctx,virt_boundary,zoned,"
 			"zone_capacity,zone_max_active,zone_max_open,"
-			"zone_nr_conv,zone_size\n");
+			"zone_nr_conv,zone_size,write_zeroes\n");
 }
 
 CONFIGFS_ATTR_RO(memb_group_, features);
@@ -678,6 +684,7 @@ static struct nullb_device *null_alloc_dev(void)
 	dev->blocking = g_blocking;
 	dev->memory_backed = g_memory_backed;
 	dev->discard = g_discard;
+	dev->write_zeroes = g_write_zeroes;
 	dev->cache_size = g_cache_size;
 	dev->mbps = g_mbps;
 	dev->use_per_node_hctx = g_use_per_node_hctx;
@@ -870,6 +877,24 @@ static void null_free_sector(struct nullb *nullb, sector_t sector,
 	}
 }
 
+static void null_zero_sector(struct nullb_device *d, sector_t sect,
+			     sector_t nr_sects, bool cache)
+{
+	struct radix_tree_root *root = cache ? &d->cache : &d->data;
+	struct nullb_page *t_page;
+	unsigned int offset;
+	void *dest;
+
+	t_page = radix_tree_lookup(root, sect >> PAGE_SECTORS_SHIFT);
+	if (!t_page)
+		return;
+
+	offset = (sect & SECTOR_MASK) << SECTOR_SHIFT;
+	dest = kmap_atomic(t_page->page);
+	memset(dest + offset, 0, SECTOR_SIZE * nr_sects);
+	kunmap_atomic(dest);
+}
+
 static struct nullb_page *null_radix_tree_insert(struct nullb *nullb, u64 idx,
 	struct nullb_page *t_page, bool is_cache)
 {
@@ -1186,6 +1211,27 @@ blk_status_t null_handle_discard(struct nullb_device *dev,
 	return BLK_STS_OK;
 }
 
+static blk_status_t null_handle_write_zeroes(struct nullb_device *dev,
+					     sector_t sector, sector_t nr_sectors)
+{
+	unsigned int bytes_left = nr_sectors << 9;
+	struct nullb *nullb = dev->nullb;
+	size_t curr_bytes;
+
+	spin_lock_irq(&nullb->lock);
+	while (bytes_left > 0) {
+		curr_bytes = min_t(size_t, bytes_left, nullb->dev->blocksize);
+		nr_sectors = curr_bytes >> SECTOR_SHIFT;
+		null_zero_sector(nullb->dev, sector, nr_sectors, false);
+		if (null_cache_active(nullb))
+			null_zero_sector(nullb->dev, sector, nr_sectors, true);
+		sector += nr_sectors;
+		bytes_left -= curr_bytes;
+	}
+	spin_unlock_irq(&nullb->lock);
+	return BLK_STS_OK;
+}
+
 static int null_handle_flush(struct nullb *nullb)
 {
 	int err;
@@ -1352,6 +1398,9 @@ static inline blk_status_t null_handle_memory_backed(struct nullb_cmd *cmd,
 	if (op == REQ_OP_DISCARD)
 		return null_handle_discard(dev, sector, nr_sectors);
 
+	if (op == REQ_OP_WRITE_ZEROES)
+		return null_handle_write_zeroes(dev, sector, nr_sectors);
+
 	if (dev->queue_mode == NULL_Q_BIO)
 		err = null_handle_bio(cmd);
 	else
@@ -1800,6 +1849,13 @@ static void null_config_discard(struct nullb *nullb)
 	blk_queue_max_discard_sectors(nullb->q, UINT_MAX >> 9);
 }
 
+static void null_config_write_zeroes(struct nullb *nullb)
+{
+	if (!nullb->dev->write_zeroes)
+		return;
+	blk_queue_max_write_zeroes_sectors(nullb->q, UINT_MAX >> 9);
+}
+
 static const struct block_device_operations null_bio_ops = {
 	.owner		= THIS_MODULE,
 	.submit_bio	= null_submit_bio,
@@ -2111,6 +2167,7 @@ static int null_add_dev(struct nullb_device *dev)
 		blk_queue_virt_boundary(nullb->q, PAGE_SIZE - 1);
 
 	null_config_discard(nullb);
+	null_config_write_zeroes(nullb);
 
 	if (config_item_name(&dev->item)) {
 		/* Use configfs dir name as the device name */
diff --git a/drivers/block/null_blk/null_blk.h b/drivers/block/null_blk/null_blk.h
index 94ff68052b1e..2c0c9c29158f 100644
--- a/drivers/block/null_blk/null_blk.h
+++ b/drivers/block/null_blk/null_blk.h
@@ -111,6 +111,7 @@ struct nullb_device {
 	bool power; /* power on/off the device */
 	bool memory_backed; /* if data is stored in memory */
 	bool discard; /* if support discard */
+	bool write_zeroes; /* if support write_zeroes */
 	bool zoned; /* if device is zoned */
 	bool virt_boundary; /* virtual boundary on/off for the device */
 	bool no_sched; /* no IO scheduler for the device */
-- 
2.29.0

