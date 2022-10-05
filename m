Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9994D5F4EE6
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 05:32:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230112AbiJEDc3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 23:32:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230061AbiJEDbi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 23:31:38 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2046.outbound.protection.outlook.com [40.107.92.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9784CC6C;
        Tue,  4 Oct 2022 20:28:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gNHHChjs/AkDBiJ1dF9js+2SW6vnlzAJEa1ORrQBLKLep8QG+itYNkdqC1kBxwRLWQDKqcK1glmSmb4bzS2OZkcAW7iQcBs9UMrmpiWHKz0IcDOgs0uVrkZpv6iSrwBruH8AS+oeM2owt2S2tiIvzQLsgpj+qWIAOiO5DArEu0I9r3NEOARYL47203M5Ahf6NwyILZewaAAVRVU6dq0umPTmxDhiEvpL32fKhoBoDfyfuj3nfeEM4ELObW5as9hSo1XEPncT0GVuGSl7xcStB0BcrJHdjFfc1my5yxVNBhmHvoLJDk660Qw+3JAM6543i9S/mfc25owaHCJGU7S7Uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oblMpQq619HIhyjlIt0b4jfS6oWBZErXTImX4wIgeCk=;
 b=mDs2nmiJWINiTpd88qIp0dD7r+xb731GnGvI8blCpFAzWHL2iCkSu5Ovrra2Tu7QuDllROQ/AuhNxFw3qpi8uGm0lshvhg8ha3izHOvtb6Quk1JiAdEQjDcnWa3m2Wv7FdUTDpVM0ta6dW7dXHw1G85e+LiVuMfpGkH3xgvKCgnsJ3LPClQC3lux5RHB1FjdhzwKCPUG0Nbfk+w9tQy83fKFwhmOrP4eNgKiWEeRa7k9lUisgLUlvmcgBmwwXtIvvLKrMnOpRpORk8Psz33cFhYDq7BstfC40HjEWYYGwUUvH0SgMO+a5mjEQznFg48vEEkVUmugpeiJpkPBQUMATw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oblMpQq619HIhyjlIt0b4jfS6oWBZErXTImX4wIgeCk=;
 b=S53n2lWGiK17kAZi0DUcCxrsutrP42By8ibAHb8PotTtOOY6KKr2jvK1W3EbDoD+hnNkPg5rh2fNyHz+VC0rcjcYFZRuV/fEpmSdb2WWC4yHR3qgLfPrRAdfOYOIWR9Uw4nfkLFHZ+w//mdkFvz68dHSVlptzhloqFXxKHlNlZTsTRSRq04vzEaOtnMm++3OckPhRYDxcG+vJjF6DnQsQTvKR+0jSEbBUi+DK/gm/y8mHR8o8mgOuIrNGagoWHKJ85IBX5HKtMtSzAjyjfmcXRXbChAr42Ba8vaDkZD6pvO2NRWnlQ52Uo1qYWlCWhKtSewkksHhuc6B6rgjkS/1yQ==
Received: from BN1PR10CA0022.namprd10.prod.outlook.com (2603:10b6:408:e0::27)
 by PH7PR12MB7140.namprd12.prod.outlook.com (2603:10b6:510:200::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.24; Wed, 5 Oct
 2022 03:27:56 +0000
Received: from BN8NAM11FT056.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e0:cafe::c7) by BN1PR10CA0022.outlook.office365.com
 (2603:10b6:408:e0::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.26 via Frontend
 Transport; Wed, 5 Oct 2022 03:27:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN8NAM11FT056.mail.protection.outlook.com (10.13.177.26) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5709.10 via Frontend Transport; Wed, 5 Oct 2022 03:27:55 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Tue, 4 Oct 2022
 20:27:41 -0700
Received: from dev.nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Tue, 4 Oct 2022
 20:27:37 -0700
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
Subject: [RFC PATCH 20/21] nvme-apple: use lib tagset init helper
Date:   Tue, 4 Oct 2022 20:22:56 -0700
Message-ID: <20221005032257.80681-21-kch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN8NAM11FT056:EE_|PH7PR12MB7140:EE_
X-MS-Office365-Filtering-Correlation-Id: 76a61f25-0d2a-4882-fcde-08daa6819814
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FGIF5osfqfQkh1ec2COmx+HNMFVrUJjU721/aWw8p7s7v4nTGXCTW75jLuc/zjImrsQRlebD6B0bVHt1aDvmBiT/4kkRSDsyHXhezUZraeqzlYrAcin/WHLRAsWNJBCLU1JPlCewTHYuW5z0o8z2uWRJl86mMfbqv/kOdG9P0Qy1kujSUiIDpHMLd4blMRH1z4lgyffnx5EQq92a54NEcOdZIOmQJoipG4epPytnNL1kMqROL/QVp+h804v9D9Gpya66PvBs5fTopP1uYCiqXNv6rGjtp0Nz3w7TEPcFbnXzxRar3Lr8xxUMb7t0IdqIc3Uzlz/0U5QPuBG88RgBX5gVqzHnyUh1uASbHEAut3mwepYcZLW12+wb636nXB5K9x9ECN6rWl/+FnvtsxKbXyczioZ671+iGqZxIwq+DW7pfd5wusyn9fX/73zqjxb61F6BYBRKO07BwYJ1yzOFfw/PI88Mx76xJ0NH4fWqqZcke5reA97dRZdlk6UyzTYW2hsGzRs1laaQLDJlW5x1pwwcu9d2CLlzBuuQkVrQwcoQnq4pj9zfAtiDoJNB0XuyBrCV/6/lfMek0XCePDEawZt61IGFHdMjiAXmiEnQrm8ZctpCAq9CUEw7Ki783SJiGg0OKM3NSg1nrJK5T8ruf4XbLfmYusypV6HhFfzVrZR3C//cdabzwt93mIOQ32uhf+haFHlQRJFuiyaRZ4jYTWXpca+BPS/aSpxWavysGXJh4L7KWPBZ3qq3Ahhn2sfmmdXv/B9wmyyepSQK2AI7eX+1N4heSyXnY10XWXqLQj1O6568oRXKkGbq3CldJTkjfk1J6AFExH1eBqippUYats6PGOFeC0Yutahwt7SebY1NVZhcPazXF3XPdzce884v0jAv8O6Bym4tG4hF+80VvA==
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(346002)(136003)(396003)(376002)(47660400002)(451199015)(46966006)(40470700004)(36840700001)(316002)(921005)(26005)(5660300002)(4326008)(8676002)(2616005)(36756003)(8936002)(36860700001)(6666004)(2906002)(82740400003)(41300700001)(16526019)(7696005)(186003)(1076003)(70206006)(70586007)(82310400005)(356005)(40480700001)(426003)(7636003)(83380400001)(47076005)(7416002)(7366002)(110136005)(7406005)(54906003)(336012)(478600001)(40460700003)(46800400005)(21314003)(83996005)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2022 03:27:55.7288
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 76a61f25-0d2a-4882-fcde-08daa6819814
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT056.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7140
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
 drivers/nvme/host/apple.c | 25 ++++++++-----------------
 1 file changed, 8 insertions(+), 17 deletions(-)

diff --git a/drivers/nvme/host/apple.c b/drivers/nvme/host/apple.c
index 5fc5ea196b40..bc95c3d93c57 100644
--- a/drivers/nvme/host/apple.c
+++ b/drivers/nvme/host/apple.c
@@ -1228,15 +1228,10 @@ static int apple_nvme_alloc_tagsets(struct apple_nvme *anv)
 {
 	int ret;
 
-	anv->admin_tagset.ops = &apple_nvme_mq_admin_ops;
-	anv->admin_tagset.nr_hw_queues = 1;
-	anv->admin_tagset.queue_depth = APPLE_NVME_AQ_MQ_TAG_DEPTH;
-	anv->admin_tagset.timeout = NVME_ADMIN_TIMEOUT;
-	anv->admin_tagset.numa_node = NUMA_NO_NODE;
-	anv->admin_tagset.cmd_size = sizeof(struct apple_nvme_iod);
-	anv->admin_tagset.flags = BLK_MQ_F_NO_SCHED;
-	anv->admin_tagset.driver_data = &anv->adminq;
-
+	blk_mq_init_tag_set(&anv->admin_tagset, &apple_nvme_mq_admin_ops, 1,
+			APPLE_NVME_AQ_MQ_TAG_DEPTH, sizeof(struct apple_nvme_iod),
+			NUMA_NO_NODE, NVME_ADMIN_TIMEOUT, BLK_MQ_F_NO_SCHED,
+			&anv->adminq);
 	ret = blk_mq_alloc_tag_set(&anv->admin_tagset);
 	if (ret)
 		return ret;
@@ -1245,8 +1240,6 @@ static int apple_nvme_alloc_tagsets(struct apple_nvme *anv)
 	if (ret)
 		return ret;
 
-	anv->tagset.ops = &apple_nvme_mq_ops;
-	anv->tagset.nr_hw_queues = 1;
 	anv->tagset.nr_maps = 1;
 	/*
 	 * Tags are used as an index to the NVMMU and must be unique across
@@ -1254,13 +1247,11 @@ static int apple_nvme_alloc_tagsets(struct apple_nvme *anv)
 	 * must be marked as reserved in the IO queue.
 	 */
 	anv->tagset.reserved_tags = APPLE_NVME_AQ_DEPTH;
-	anv->tagset.queue_depth = APPLE_ANS_MAX_QUEUE_DEPTH - 1;
-	anv->tagset.timeout = NVME_IO_TIMEOUT;
-	anv->tagset.numa_node = NUMA_NO_NODE;
-	anv->tagset.cmd_size = sizeof(struct apple_nvme_iod);
-	anv->tagset.flags = BLK_MQ_F_SHOULD_MERGE;
-	anv->tagset.driver_data = &anv->ioq;
 
+	blk_mq_init_tag_set(&anv->admin_tagset, &apple_nvme_mq_admin_ops, 1,
+			APPLE_ANS_MAX_QUEUE_DEPTH - 1, sizeof(struct apple_nvme_iod),
+			NUMA_NO_NODE, NVME_IO_TIMEOUT, BLK_MQ_F_SHOULD_MERGE,
+			&anv->ioq);
 	ret = blk_mq_alloc_tag_set(&anv->tagset);
 	if (ret)
 		return ret;
-- 
2.29.0

