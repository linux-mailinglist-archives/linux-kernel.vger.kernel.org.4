Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CDC25F4EE8
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 05:32:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230208AbiJEDcf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 23:32:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229953AbiJEDcC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 23:32:02 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2072.outbound.protection.outlook.com [40.107.95.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1E6575CC8;
        Tue,  4 Oct 2022 20:28:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mtEEV/2g+OZEmvyf7CGY/gv3L3o5L+uhcb/9tQAtsqpqQyfB7l7YzognVjN0VyIpKebhXgQCCatYggAqE08wgPYbNKzOhoXpAYE4AmOJTiNxW43P3GJ/CTa73a4mZxbbu9jKoRWP6BC86ZcSUow3Iwm/9CbHxisdj3m5HFjxqEi+GOMOagop3poZTiVVJ42cXaM3QVhwB6knJrNKfh2v6ANr4gK00ScGKLW+JTXiUmxtjqOn0T9RER5BiWDh60FerF7aeg7jYp0XUUcwv79TgMgskseD+xnGHQXVO1au01w1QyvApxfX+fuamHs16lFdFFr5Df9V2HqcdCi+AdqLrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gHz7Dp/+F4b/Hkk0H5bmoMnwFHpir4BLHeQHPx4VfbM=;
 b=gAHtV/IZjz+T2VM3sgbRe/EJT3puh1pbVa6KmLT7IDcWaMThYonjPJxbE3Ya74TzKXgi6Ro2RkANe/7FYk/sUep5ZK03hkO8dXCLDZIBrE53sU9Dbxj+vzZKB7PKqY/xXr8aN5Mqxp2wWGPaxRHjJVa1+RspW7o/0tys9JjeWu0ETLChGyrkmTde6AcdGnYfZkFaZSMP4KdD9lWD2zXSoNs358q49P9y41yxlwJCKg/RHsV+0hSVjB7Y4X4rZMNzF3Pj2939Ng00iN0n8x805ayjzH+HvzjMvMoy7En2GtKKHU2E68/Upfjo30sDCr4P6wWedKrLxLRhyHvGI9N6HQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gHz7Dp/+F4b/Hkk0H5bmoMnwFHpir4BLHeQHPx4VfbM=;
 b=T4W+aTNTibT//scjWp8lEYnBLxbLb2CZGiOoSTy3i0NRNz4Gtt23L+lPmf2oFcOp/8Z4NUZatkQA7YRgfPqIlAkU6eV2HW6A/uAzYeXHoKTsU9wZEPec3Zk4C11M1BVXhm3u5qwHiZlGZxMfVeTqSkKjEaLuwtmF6TFbUX5C3TwmMLnYoFzEBphFd7chdUGWrp/UFIOBw+gwMYd5A/kHuWEqYNXgqVHON71kjItGtJ2ZaqwZ4ywGYwBiYrWpcaLxkT3HWbJmNIq3sq0OiEpNJEj8IOoBrt6pABfTL1IEp0mOqa9IVgF6Jar2zeyouqXO9QPES7T6WQoMMMUA2z4p8w==
Received: from DM6PR02CA0122.namprd02.prod.outlook.com (2603:10b6:5:1b4::24)
 by MN0PR12MB5932.namprd12.prod.outlook.com (2603:10b6:208:37f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.31; Wed, 5 Oct
 2022 03:27:56 +0000
Received: from DM6NAM11FT037.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1b4:cafe::74) by DM6PR02CA0122.outlook.office365.com
 (2603:10b6:5:1b4::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.23 via Frontend
 Transport; Wed, 5 Oct 2022 03:27:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DM6NAM11FT037.mail.protection.outlook.com (10.13.172.122) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5709.10 via Frontend Transport; Wed, 5 Oct 2022 03:27:56 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Tue, 4 Oct 2022
 20:27:54 -0700
Received: from dev.nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Tue, 4 Oct 2022
 20:27:51 -0700
From:   Chaitanya Kulkarni <kch@nvidia.com>
To:     <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-omap@vger.kernel.org>, <linux-remoteproc@vger.kernel.org>,
        <linux-mmc@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-nvme@lists.infradead.org>, <linux-s390@vger.kernel.org>,
        <linux-scsi@vger.kernel.org>
CC:     <axboe@kernel.dk>, <efremov@linux.com>, <josef@toxicpanda.com>,
        <idryomov@gmail.com>, <dongsheng.yang@easystack.cn>,
        <haris.iqbal@ionos.com>, <jinpu.wang@ionos.com>, <mst@redhat.com>,
        <jasowang@redhat.com>, <pbonzini@redhat.com>,
        <stefanha@redhat.com>, <ohad@wizery.com>, <andersson@kernel.org>,
        <baolin.wang@linux.alibaba.com>, <ulf.hansson@linaro.org>,
        <richard@nod.at>, <miquel.raynal@bootlin.com>, <vigneshr@ti.com>,
        <marcan@marcan.st>, <sven@svenpeter.dev>, <alyssa@rosenzweig.io>,
        <kbusch@kernel.org>, <hch@lst.de>, <sagi@grimberg.me>,
        <sth@linux.ibm.com>, <hoeppner@linux.ibm.com>, <hca@linux.ibm.com>,
        <gor@linux.ibm.com>, <agordeev@linux.ibm.com>,
        <borntraeger@linux.ibm.com>, <svens@linux.ibm.com>,
        <jejb@linux.ibm.com>, <martin.petersen@oracle.com>, <hare@suse.de>,
        <kch@nvidia.com>, <bhelgaas@google.com>, <john.garry@huawei.com>,
        <mcgrof@kernel.org>, <christophe.jaillet@wanadoo.fr>,
        <vaibhavgupta40@gmail.com>, <wsa+renesas@sang-engineering.com>,
        <damien.lemoal@opensource.wdc.com>, <johannes.thumshirn@wdc.com>,
        <bvanassche@acm.org>, <ming.lei@redhat.com>,
        <shinichiro.kawasaki@wdc.com>, <vincent.fu@samsung.com>,
        <christoph.boehmwalder@linbit.com>, <joel@jms.id.au>,
        <vincent.whitchurch@axis.com>, <nbd@other.debian.org>,
        <ceph-devel@vger.kernel.org>,
        <virtualization@lists.linux-foundation.org>,
        <asahi@lists.linux.dev>
Subject: [RFC PATCH 21/21] nvme-pci: use lib tagset init helper
Date:   Tue, 4 Oct 2022 20:22:57 -0700
Message-ID: <20221005032257.80681-22-kch@nvidia.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20221005032257.80681-1-kch@nvidia.com>
References: <20221005032257.80681-1-kch@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT037:EE_|MN0PR12MB5932:EE_
X-MS-Office365-Filtering-Correlation-Id: 20d8c758-a3e9-403e-afa8-08daa6819884
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1IwHhpF45Lv+E1FLJ2N0fDaKfgLEQRdw8iFZ8hB8o7fuwj86Gy6LTWnzK2rgIfRETVDsjcyrIP7qIRwNkqVSmI95hhQXxtY/2rvy6h7L1bzE70WQHO8MM+u8ExXS1MhRsOJkByqQW3UMMgCNQQTdoOTHcXFm/5+5P32/gc2x31LrXp8ynt/8FTWvNY85kW6Y5hlO7KbQNFU2ENIgHwJCoZHNmB+1n5GPp2+EwzA8/gEuxe2iVYOb38DYtOfD5mSDHSIzLvyT2bXfPTkFzQ2b3NyOjXGTMcNWn9OJr0ULmi9ju3EC1C9CGy/VxMNTE36rb7lB6YcUGKy4Ojy6zG+VMXJmB0e180tFd1m6dz4A5cp1SF3zLL0vrYNXqvjnavov7z3jQkZaRduizhX/rQs1dfKC0NinLLqjfF5cjDJ5bkg5CiBhng+63nUI/fv+mY79PC8JuoX33qHFWe9sAD8q4RSiJjRZRbFcymRkP7EAxqut4o3IxhYLaSwFrvjaNujO5dXOGAmdFRFrZ7mvlKLsyLlgo/9PRuqw72oPQ/ZEiLWu/uR27IMoz6R2VDgDsBdVJdkK53Snix1APCJ6RSMi3tcy9dj5kfal4r2yy8OFQWtcfaKePJpX4BVxaEAFX3F9XuOPLwQzqVG7Ncz6MMJfKSEFD60I626R1LD7Si3/e4vBovQMKX0L+rmNa4Vrn6VdVO+tzwaEA3dGnnweAcT3C9jU1m9Kf0SeJuh3mUJiaCFoeY5w3K63B3gcx2eoKmWrUzVjkujhdsNLDTT2z5zblJ1wN/pBaErrjT6i45CGl12dMSuQGA0OfTPB0ug/0yIrBjInFteR3zV9PJlQDvhIJ4x5hyOYKojXzivb82o6FK4=
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(376002)(346002)(396003)(136003)(39860400002)(451199015)(46966006)(40470700004)(36840700001)(2616005)(82740400003)(7636003)(70206006)(7696005)(40460700003)(4326008)(8676002)(26005)(40480700001)(70586007)(356005)(921005)(36756003)(83380400001)(478600001)(1076003)(316002)(110136005)(16526019)(336012)(47076005)(426003)(36860700001)(186003)(54906003)(82310400005)(8936002)(7416002)(7406005)(5660300002)(7366002)(2906002)(41300700001)(21314003)(2101003)(83996005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2022 03:27:56.4764
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 20d8c758-a3e9-403e-afa8-08daa6819884
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT037.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5932
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the block layer helper to initialize the common fields of tag_set
such as blk_mq_ops, number of h/w queues, queue depth, command size,
numa_node, timeout, BLK_MQ_F_XXX flags, driver data. This initialization
is spread all over the block drivers. This avoids the code repetation of
the inialization code of the tag set in current block drivers and any
future ones.

Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
---
 drivers/nvme/host/pci.c | 25 +++++++------------------
 1 file changed, 7 insertions(+), 18 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 7bbffd2a9beb..52af4b2bb668 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1757,15 +1757,9 @@ static int nvme_pci_alloc_admin_tag_set(struct nvme_dev *dev)
 {
 	struct blk_mq_tag_set *set = &dev->admin_tagset;
 
-	set->ops = &nvme_mq_admin_ops;
-	set->nr_hw_queues = 1;
-
-	set->queue_depth = NVME_AQ_MQ_TAG_DEPTH;
-	set->timeout = NVME_ADMIN_TIMEOUT;
-	set->numa_node = dev->ctrl.numa_node;
-	set->cmd_size = sizeof(struct nvme_iod);
-	set->flags = BLK_MQ_F_NO_SCHED;
-	set->driver_data = dev;
+	blk_mq_init_tag_set(set, &nvme_mq_admin_ops, 1, NVME_AQ_MQ_TAG_DEPTH,
+			sizeof(struct nvme_iod), dev->ctrl.numa_node,
+			NVME_ADMIN_TIMEOUT, BLK_MQ_F_NO_SCHED, dev);
 
 	if (blk_mq_alloc_tag_set(set))
 		return -ENOMEM;
@@ -2528,20 +2522,15 @@ static void nvme_pci_alloc_tag_set(struct nvme_dev *dev)
 	struct blk_mq_tag_set * set = &dev->tagset;
 	int ret;
 
-	set->ops = &nvme_mq_ops;
-	set->nr_hw_queues = dev->online_queues - 1;
 	set->nr_maps = 1;
 	if (dev->io_queues[HCTX_TYPE_READ])
 		set->nr_maps = 2;
 	if (dev->io_queues[HCTX_TYPE_POLL])
 		set->nr_maps = 3;
-	set->timeout = NVME_IO_TIMEOUT;
-	set->numa_node = dev->ctrl.numa_node;
-	set->queue_depth = min_t(unsigned, dev->q_depth, BLK_MQ_MAX_DEPTH) - 1;
-	set->cmd_size = sizeof(struct nvme_iod);
-	set->flags = BLK_MQ_F_SHOULD_MERGE;
-	set->driver_data = dev;
-
+	blk_mq_init_tag_set(set, &nvme_mq_ops, dev->online_queues - 1,
+			min_t(unsigned, dev->q_depth, BLK_MQ_MAX_DEPTH) - 1,
+			sizeof(struct nvme_iod), dev->ctrl.numa_node,
+			NVME_IO_TIMEOUT, BLK_MQ_F_SHOULD_MERGE, dev);
 	/*
 	 * Some Apple controllers requires tags to be unique
 	 * across admin and IO queue, so reserve the first 32
-- 
2.29.0

