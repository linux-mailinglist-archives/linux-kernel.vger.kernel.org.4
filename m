Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FEE55F4E10
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 05:18:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229750AbiJEDR6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 23:17:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229634AbiJEDRm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 23:17:42 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2082.outbound.protection.outlook.com [40.107.223.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E681719AD;
        Tue,  4 Oct 2022 20:17:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gUaegdD1LwUY9kwoyWEleGvfDJ5No0VCl22+vCV13LeJ2slFfB1JqRui5ZHDg7AMFG7gzHA3X/HAJyV5PRUatq9OxS7Pn3CMWmzrAaDqxPxJYDAcHUHBxXJXHivUxzgAOFDhNOMwIjWZ4F59f8YKkfjPMJFE1WmMUf2rlr7fhF9+2tvURXFHJx5hPAFCj6+WCRbZid4wjhSsDkdICEbvNcl8+n+QnS2/mDlcv6KyjarWEQIqnvl7JCHIwgWvYmmiLgaJiiskwN0pygoK0zjoPP7UiVojbII7UQky2GImiyHqpY7jywShldymoFuGtUpClh+XzaknsJztVXADH+YNNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CeiX4viiHDFd5u/mwQnYqmQtoX77JIvmvAuld9O/lCs=;
 b=L3LbZH2q0jHOt90nzeAc2y36QHIcpcUYXhAdaHo1KsE4cTHr1ug03jKVTelYpuzRoZ+qCCDAkHYcXxgMglUWYhW4Hm2LO3G57JWxktH6qfPJMWtdwA0xQMfno6ejCb5lG5JTjugUWDJntqsVHsQ5I66QLpvbXO95qpOKZNTcLoekax/wtUbF6hwrFylzZlXJvQInOHNKnQWrKw8tlpVGsmhnnCLJw0zgR/TAEkzBFkgT7Yxx659FNWQxGY0YFXFPe27Z5AT9Hqm0iLcgoMDLKLDmgIia+eQYLI1adaVpeJndyz+DuV/B/dJAegk/OXPltLBTuLhTRjFvD9MNduDMXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CeiX4viiHDFd5u/mwQnYqmQtoX77JIvmvAuld9O/lCs=;
 b=hHVZLGAevxbaY59x1Rilah//L+reAqarfupHpy2jhkUNyKte/DnjFnXW6gi8KdBrMGxIMsFLZ0b5XrCCKyanAOt4jhwsltoLxmeuFVJC1ef0ocxUplyZYywuqc3RTQB5kFezUMfioonpCVGFskaNBKKio/M50dPLfRNDheu7KhIteake/T5V8y3MCbkMmv8uqB0N5qsE5r5RO6gLejireBhm3L3HLWxI57hA6eBVz4Ta/4wpBIXodv44n/Kg79CxggKqvVe0gLqYMjEl8H3fmyk9U5izP17r0lILASL2a74c4Ubw4ZEaVdXZu7c0PHXuWLPaM9ZC/W/1LkNy0LZN0Q==
Received: from MW4PR04CA0198.namprd04.prod.outlook.com (2603:10b6:303:86::23)
 by DS0PR12MB6630.namprd12.prod.outlook.com (2603:10b6:8:d2::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.20; Wed, 5 Oct
 2022 03:17:35 +0000
Received: from CO1NAM11FT008.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:86:cafe::ef) by MW4PR04CA0198.outlook.office365.com
 (2603:10b6:303:86::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.30 via Frontend
 Transport; Wed, 5 Oct 2022 03:17:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1NAM11FT008.mail.protection.outlook.com (10.13.175.191) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5709.10 via Frontend Transport; Wed, 5 Oct 2022 03:17:35 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Tue, 4 Oct 2022
 20:17:33 -0700
Received: from dev.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Tue, 4 Oct 2022
 20:17:32 -0700
From:   Chaitanya Kulkarni <kch@nvidia.com>
To:     <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <axboe@kernel.dk>, <kch@nvidia.com>,
        <damien.lemoal@opensource.wdc.com>, <johannes.thumshirn@wdc.com>,
        <bvanassche@acm.org>, <ming.lei@redhat.com>,
        <shinichiro.kawasaki@wdc.com>, <vincent.fu@samsung.com>,
        <yukuai3@huawei.com>
Subject: [PATCH 2/6] null_blk: allow write zeores on membacked
Date:   Tue, 4 Oct 2022 20:16:57 -0700
Message-ID: <20221005031701.79077-3-kch@nvidia.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20221005031701.79077-1-kch@nvidia.com>
References: <20221005031701.79077-1-kch@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT008:EE_|DS0PR12MB6630:EE_
X-MS-Office365-Filtering-Correlation-Id: 3948006a-e3d9-4343-72cf-08daa6802633
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZMGlggu7tnv0lP0PVzTtlK10di6qJO2tZfmP7EELsm3i50hxo4uOKMfIDaddkgBe79hOqIbEWkTH6V3WhAAt/aVQMEMjLHeWyyHXGK/efS2Q+8/fAxcCtbRgHrgxZ60E7BYjNPMuST/FYY2kyRqNTrq3TLs0i2gWv5LY0zAmilhB725oePYpd2WELoO1rBnjS2dH6qzPB3xESinyLrMlqUURxeyPX9b2z99P+tG1IkUMUBsCJ/KFMw3lfi5S5iQazXA7Zk2C8A4QZNBeeOLZS5vuTEMPwFS3/2Ut6a0NlgSEQGQSzcY4+O1bBc45kKi50r5qdzTpPdUTFbKn6CFtUnDA4b/Thc7ll19bJRu78hDHOxrbfgF02ApT0Btf5VGKzCUbdohqbKvEltpa0Ycls4x449SmDsoGJMeIgGormdpSLqI651fla02+9s7G6VqLWtW5e3K1jPHDL8mjQ6Hu9djMzQzy2ToOMwTWh7OedmpShAOCnBC3zupyWdFZ3VDLm4hlRnG2MNRgEyH0d0+wkUOMoHjjB1q3yWhJrD2LUIvTiwD84v90fXcIV/hEYzc3rzOdzndX0G5kCBCI/VIHykig5oijQVZHp4fSPGSnt2W+hSDVPCUlRx344TqyyJjCvOtEMV2iwCJvpBRYko0InV4qE2mLuM/KvVAbVa3uc15M9zT3mEXH8yBJDEMhUH/a0e3gRKVxrU90GCGO3bXG589OA28McJ7qP2qOhoN8F4MIPYKFXc9GeQ1Rr+LnwljI2ki6UniL46ta8jMjtmYhNQ==
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(376002)(136003)(346002)(396003)(451199015)(46966006)(36840700001)(40470700004)(110136005)(82740400003)(478600001)(36860700001)(5660300002)(40460700003)(7636003)(186003)(356005)(2616005)(16526019)(8676002)(82310400005)(7696005)(47076005)(54906003)(2906002)(6666004)(26005)(4326008)(426003)(7416002)(316002)(36756003)(41300700001)(1076003)(70206006)(70586007)(40480700001)(336012)(83380400001)(8936002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2022 03:17:35.2183
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3948006a-e3d9-4343-72cf-08daa6802633
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT008.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6630
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a helper functions to enable the REQ_OP_WRITE_ZEROES operations
when null_blk is configured with the membacked mode.

Since write-zeroes is a non-trivial I/O operation we need this to
add a blktest so we can test the non-trivial I/O path from the
application to the block layer.

Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
---
 drivers/block/null_blk/main.c | 46 ++++++++++++++++++++++++++++++++++-
 1 file changed, 45 insertions(+), 1 deletion(-)

diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
index fc3e883f7b84..2d592b4eb815 100644
--- a/drivers/block/null_blk/main.c
+++ b/drivers/block/null_blk/main.c
@@ -420,6 +420,7 @@ NULLB_DEVICE_ATTR(blocking, bool, NULL);
 NULLB_DEVICE_ATTR(use_per_node_hctx, bool, NULL);
 NULLB_DEVICE_ATTR(memory_backed, bool, NULL);
 NULLB_DEVICE_ATTR(discard, bool, NULL);
+NULLB_DEVICE_ATTR(write_zeroes, bool, NULL);
 NULLB_DEVICE_ATTR(mbps, uint, NULL);
 NULLB_DEVICE_ATTR(cache_size, ulong, NULL);
 NULLB_DEVICE_ATTR(zoned, bool, NULL);
@@ -544,6 +545,7 @@ static struct configfs_attribute *nullb_device_attrs[] = {
 	&nullb_device_attr_power,
 	&nullb_device_attr_memory_backed,
 	&nullb_device_attr_discard,
+	&nullb_device_attr_write_zeroes,
 	&nullb_device_attr_mbps,
 	&nullb_device_attr_cache_size,
 	&nullb_device_attr_badblocks,
@@ -618,7 +620,7 @@ static ssize_t memb_group_features_show(struct config_item *item, char *page)
 			"poll_queues,power,queue_mode,shared_tag_bitmap,size,"
 			"submit_queues,use_per_node_hctx,virt_boundary,zoned,"
 			"zone_capacity,zone_max_active,zone_max_open,"
-			"zone_nr_conv,zone_size\n");
+			"zone_nr_conv,zone_size,write_zeroes\n");
 }
 
 CONFIGFS_ATTR_RO(memb_group_, features);
@@ -875,6 +877,24 @@ static void null_free_sector(struct nullb *nullb, sector_t sector,
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
@@ -1191,6 +1211,27 @@ blk_status_t null_handle_discard(struct nullb_device *dev,
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
@@ -1357,6 +1398,9 @@ static inline blk_status_t null_handle_memory_backed(struct nullb_cmd *cmd,
 	if (op == REQ_OP_DISCARD)
 		return null_handle_discard(dev, sector, nr_sectors);
 
+	if (op == REQ_OP_WRITE_ZEROES)
+		return null_handle_write_zeroes(dev, sector, nr_sectors);
+
 	if (dev->queue_mode == NULL_Q_BIO)
 		err = null_handle_bio(cmd);
 	else
-- 
2.29.0

