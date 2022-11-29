Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D472563CBD2
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 00:28:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230112AbiK2X2y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 18:28:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229944AbiK2X2q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 18:28:46 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2045.outbound.protection.outlook.com [40.107.223.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2BEE6E575;
        Tue, 29 Nov 2022 15:28:45 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FcbKGwjOSOCkElwUttJS2jRYLZye1pUnj5wKYXd0CWsx4/9O3HVMg9Q0DVy3ksysO2auxRBBTzxG/pvTimrFkU3zb0gdJA+Qfyo7Xzy3aczSykXsM3nqrCShMr8gxMyryQ3iV75tX3KdtKwW1z1SaKPYz6QeE2DuA6/Gc2sjTHYZ2GWYwqTS4UN2o5VWLrotPQEoriFh5kxel/SxlqoVq0zaAJo8rnDSa07y6SyTP0uszRxDMU5dgQdMnbIlCYuvnKt5YfbMl6bTxe+VjhQu7CEzpG1XjZlT7JnC+G1IQ7LxB1njfw0uZ1vuCFRlsGzJ/4Q6DABb05mWlFrI9UbBbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TQmv64da+NeRasr5CDRQ/fRlLIjqCt0lt59FOgxkGsA=;
 b=T7JOW3Ic23tlkxB16H/09fe9a4/ARumo5g8miGqlqhWDJo7jH/Gg7OacT1xRFIHuHXK7qqPMYC4iP9l+0B4RI1s891zHf866CS89EgvjIqcvkc5AFMOj0efMUVcQMc36cyjsazBHKk0jzhqFGObg6gDTFOwZZ5Z1L69onN0G3Zv47yGwX6Yy3oCappAxWue2pUhG1Q8n+NGMB8AmdpT9QLwOZzjrkT3l/yXpOyjVlySrsRJXgMSN/LV4/7f4FDS8ecKuwZan88IMuGp7MpuuGFdQSMcQQzGARkmrKchx9Z8z9k71FwR6DNyjcXDl0Io4fjnAx8jg2LrZmk0UDuWASg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TQmv64da+NeRasr5CDRQ/fRlLIjqCt0lt59FOgxkGsA=;
 b=MepFH9UnfnEUEszWK8738xulL5TSUqKrqxPHoCHQxKmEhlKlO49y4FA8lgnpVbPU99uFXOV99AvluA9BjADUtsxFLZR8tYqw12UYUBYcP5cbOZ0pOYnvLV8GoIjkJRoGVmkSAAYZhd+LD/RGig4Wdck8D/T7Kx+8WXvWYsSYLY1pOwBH6z/ekMC1xbkI8TXtBf/vDlvvRr9g78MsSgfBLpb1YOwMhQ0FkNNQjxyPz9E8ntAXniN0Oj7yN6pCsGSQi2gQCdB9G/7dftKiHTG8iD6ZY1DKnPXRni//TR8fUbD5GHty/nePIWIMeQnRA8QjUAqPXG08SPnTJMZGL/IPNA==
Received: from DM6PR07CA0039.namprd07.prod.outlook.com (2603:10b6:5:74::16) by
 MN2PR12MB4237.namprd12.prod.outlook.com (2603:10b6:208:1d6::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5857.23; Tue, 29 Nov 2022 23:28:44 +0000
Received: from DM6NAM11FT025.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:74:cafe::e6) by DM6PR07CA0039.outlook.office365.com
 (2603:10b6:5:74::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.23 via Frontend
 Transport; Tue, 29 Nov 2022 23:28:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DM6NAM11FT025.mail.protection.outlook.com (10.13.172.197) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5857.18 via Frontend Transport; Tue, 29 Nov 2022 23:28:43 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Tue, 29 Nov
 2022 15:28:33 -0800
Received: from dev.nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Tue, 29 Nov
 2022 15:28:33 -0800
From:   Chaitanya Kulkarni <kch@nvidia.com>
To:     <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <axboe@kernel.dk>, <damien.lemoal@opensource.wdc.com>,
        <bvanassche@acm.org>, <shinichiro.kawasaki@wdc.com>,
        <vincent.fu@samsung.com>, Chaitanya Kulkarni <kch@nvidia.com>
Subject: [PATCH V4 1/8] null_blk: allow REQ_OP_WRITE_ZEROES
Date:   Tue, 29 Nov 2022 15:28:06 -0800
Message-ID: <20221129232813.37968-2-kch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DM6NAM11FT025:EE_|MN2PR12MB4237:EE_
X-MS-Office365-Filtering-Correlation-Id: ecc8fd12-1137-4ebb-0f25-08dad261747b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XIV/OimGYvsmtlDdvWDk5QDnwXz2h5IEkKxjkOZYfmW9F+PBXdBUtd6gW33z9iQOZx5cbmukhJ1r4iCkAQSbAhEupDVCa96HTu/k5tCow+LcBJBx0dfGibxdTXv41uMrJ9jhCor4vZHQgzLegbaXRYtBgRMrLSu11CUJ9/0sOzGKP7OmblNjAhl5tu0qd3W9DVkUyXekpARs50RIdVeO76kw9oAdComt2tgL2aA1H/tT6RsNMKB7C9TwFi/Sa99XuDUrmraMQU6KoMnp2foRMZjQhdES2TEGdJFG99LGmFnUhb4FZUXaSaHtcImDcOOcFM6X7wQkHbSyhhAkbL1Uu3w273ptsR8Eh5CEMwVJbdGhyOQcaVKNg7KcdDNWURVW2/JEVSkxYqmnwjBJRzS1lbpyoqdPAXiZHKD1AToWB9U2sqtZtpDasQm/HGDGj5RarWb++YCXcE/jTvupNxtulBdedIz17OTJ7dcoFBpRF2pHrO6UCFxZbxnmES9rQEkNbvViSedX32Dxa0cXx5+dPw1lqpslXEz3vDishapoVz/KSq837dYXaP/eRiVA1PXSr59dGDyGlyi35IpJL+pt/bCzN+M6MEg0a9qr1ATF+HlwHXA4kCZKuPiIBm8sPUm0eFp+MRPuzoCVX0ix5R2EsiRqRZoQVcqPe4tfFG7kZ57esGqRPKNoIRvtrit1D1zthMBCDNXfaOUaCLUbuQjT6w==
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(396003)(136003)(376002)(39860400002)(346002)(451199015)(40470700004)(46966006)(36840700001)(47076005)(36860700001)(8676002)(83380400001)(2906002)(82740400003)(7636003)(426003)(356005)(41300700001)(40460700003)(7696005)(82310400005)(8936002)(40480700001)(4326008)(5660300002)(336012)(16526019)(107886003)(6666004)(26005)(186003)(1076003)(316002)(2616005)(54906003)(70206006)(70586007)(36756003)(478600001)(110136005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2022 23:28:43.2510
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ecc8fd12-1137-4ebb-0f25-08dad261747b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT025.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4237
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

