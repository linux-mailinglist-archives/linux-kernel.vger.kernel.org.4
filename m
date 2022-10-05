Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BED175F4EAA
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 05:29:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229534AbiJED3j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 23:29:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230092AbiJED2i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 23:28:38 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2044.outbound.protection.outlook.com [40.107.220.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C31E1A3B1;
        Tue,  4 Oct 2022 20:26:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZDkEflIwJDiee9RVNkb6G2DJqnte3FhT2iuOesNpa4or4MUI5QGIhc+XLHfZ/zjXG1XQwZwYZ9ojbVedh7k76PuDnDUUeD2wmgtT0xQcgPrbdU51RudREumASwz01Hz5PgWdZQs7ihcDx5AAQmhfMrsUxFjF0TeXvhqA6jYPYriSge3c/egEu++txJr8Gdx1/gLa1v76Z9YOYHNok3F3jY3JSkFFBvtOai82xtyvvSFeBIKhx7Uf+5f9BGQ/PrQfAok29ZNHSS/1gSSUYlDFwWWQ6f03sPRS68noAMNCv6Vo/4fnQFzk6TYp6WA14lawtEemekO9ySP0Ew9amzWobQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=brGahmz6/Yn19CwPPv+FuH1xTbcRVg6GZEDil5JgBik=;
 b=cqg5Ofndu9BnL5khJT0n/JRSVJJawS/wWpBn0mgYCS4Z8ycjA4RQQT9lWXMU34ByOssMdJYfPayguov48+o+W3L5fYYvUTZzlVB/ghOuL2qUWwgdKWBEtiGVGHPC74U5Q5G9n/atM1WlTmdb08m2fMntmZwvWKOOhVKHwoJ1jA0he9UJqki2RwxVClWQNBqZHBrWEr5STDmZoMaczAL5Vf4nXguToktPiqixs2Vizc0gD7ki0riVrXR8p1dnuyktgHyvPWjGtvqTuWaILG3iN/vU782uxpGgVczzGLiDjhZamYwVbBpDwO6NPaSsGFubkFR11izD2/pHP8SThU/luA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=brGahmz6/Yn19CwPPv+FuH1xTbcRVg6GZEDil5JgBik=;
 b=l7tLMWde7BVgBQSqFGbYziBx8v2xb4dpTEKVnpR9T8AG6Qrqeh70/vFB8mXhUE8WzxD2s3NQaNYQqVsKDFqfZtibKECHb8ss1oHgeQbzC1AwtWDqFUYy1EjbkLVbR74NfHkNqTrbbVLShclmGN/J71CtQjzDpBBSvXTuon4IwwPdNpVM4TiejKDza7WMt4LGSLMnWKwi3SAlMnTqEjSu5LNM+y9c7+JDwoWG9p/o6FJ7PUIDEChTDO73pH9MSN/FjFpypq1mkGMYhzFIMMybptsqqYEImaAINYc4MWZ+Nfy0hilNBEtv8leKG89XL7Di/gxJSOJff9WZnCqMNiVjsw==
Received: from DM6PR05CA0054.namprd05.prod.outlook.com (2603:10b6:5:335::23)
 by MW3PR12MB4474.namprd12.prod.outlook.com (2603:10b6:303:2e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.24; Wed, 5 Oct
 2022 03:26:27 +0000
Received: from DM6NAM11FT091.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:335:cafe::90) by DM6PR05CA0054.outlook.office365.com
 (2603:10b6:5:335::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.5 via Frontend
 Transport; Wed, 5 Oct 2022 03:26:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DM6NAM11FT091.mail.protection.outlook.com (10.13.173.108) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5709.10 via Frontend Transport; Wed, 5 Oct 2022 03:26:27 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Tue, 4 Oct 2022
 20:26:20 -0700
Received: from dev.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Tue, 4 Oct 2022
 20:26:17 -0700
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
Subject: [RFC PATCH 14/21] scm_blk: use lib tagset init helper
Date:   Tue, 4 Oct 2022 20:22:50 -0700
Message-ID: <20221005032257.80681-15-kch@nvidia.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20221005032257.80681-1-kch@nvidia.com>
References: <20221005032257.80681-1-kch@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT091:EE_|MW3PR12MB4474:EE_
X-MS-Office365-Filtering-Correlation-Id: c0a5060f-56c1-4865-d609-08daa681633a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1WGT2eEVX5DQGLgtMoD7iQK37NW9+CMRzidYwWIx+lpzd2qBNz0CTblYj1fCp3/X5gGqNHjHeEwhhrhygvB+BZni0NquTTbhW94qD/Xa1+czgwKwVhNAjz6+Nbo/wXTMqxdUCCM54b9nNOcRF7IARMM2CuDRuIyuggvdjCuPNcJw5D4V1c/7LiiF8L8Ed8qzJ3tG0w12SSnE8SD95dBUndT5tnK4cOLoAkuvcYeCBCellqAtXrswIQ8xtes5lmCy0pr2EeQ4hyBRVbuRM0ci6EhMhevdmjfMbjIGNZCa57vutK0zf11ENuovyiM00fkPxWl/cc5RECaQ5GekvPwuLGqOh7OPPRbvxxIyR2GdVAmHsRmktFFMFWgZd76Z2wdBXvWHOi+6Rcf2lDttTgic9S3WAOmHVvFJetNBsK8eIBqb8jNEcRBpy++EUJrSr3ndlMCR/eYWsh/i8rP3u1U9JHVYiIjKhKUa6MQ/QoVYFhHZTl6pTw4HC/eW41wVelS0D7whtL++M7ay3X7tkZPmQAnUYSp6nZ7P+KidY+rQ90MA0wmzH5KOz/Lbhe3kNlwzKNH7GmL6BPSSunF3qgLJBYXjtuEodkyIGdRpH8DkhDt4TsEz94D8MOypOuuvmNnK1epXH+c0skJ+e5dxZSaXrcUy11SSsNGK56w573wCY0De8j39SmO5YeGrU84KvDH6jN1t+nxbiRAfOYaKPhAOc7i1s5ByKJMSnjSpx/Vf0v/vA8cYdQ4i8/9mII9mRkc+Sh7G38SZ69lJX0BX0ADv8+ae8le2y80pq6VzSTiMI74dtcAXo0XjbZDHnK66wlpccmfgvpSkfBU+Efg/48moCtLmW2uXfER4hK6A4dAxSTQ=
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(346002)(376002)(396003)(39860400002)(136003)(451199015)(36840700001)(46966006)(40470700004)(7696005)(26005)(82740400003)(356005)(6666004)(921005)(316002)(2906002)(5660300002)(82310400005)(40480700001)(1076003)(36756003)(36860700001)(8936002)(70206006)(70586007)(8676002)(2616005)(4326008)(186003)(16526019)(41300700001)(426003)(7636003)(83380400001)(47076005)(7416002)(7366002)(110136005)(7406005)(54906003)(336012)(478600001)(40460700003)(21314003)(83996005)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2022 03:26:27.0576
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c0a5060f-56c1-4865-d609-08daa681633a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT091.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4474
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
 drivers/s390/block/scm_blk.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/s390/block/scm_blk.c b/drivers/s390/block/scm_blk.c
index 0c1df1d5f1ac..4b1653fd71a5 100644
--- a/drivers/s390/block/scm_blk.c
+++ b/drivers/s390/block/scm_blk.c
@@ -450,13 +450,9 @@ int scm_blk_dev_setup(struct scm_blk_dev *bdev, struct scm_device *scmdev)
 	spin_lock_init(&bdev->lock);
 	atomic_set(&bdev->queued_reqs, 0);
 
-	bdev->tag_set.ops = &scm_mq_ops;
-	bdev->tag_set.cmd_size = sizeof(blk_status_t);
-	bdev->tag_set.nr_hw_queues = nr_requests;
-	bdev->tag_set.queue_depth = nr_requests_per_io * nr_requests;
-	bdev->tag_set.flags = BLK_MQ_F_SHOULD_MERGE;
-	bdev->tag_set.numa_node = NUMA_NO_NODE;
-
+	blk_mq_init_tag_set(&bdev->tag_set, nr_requests,
+			nr_requests_per_io * nr_requests, sizeof(blk_status_t),
+			NUMA_NO_NODE, BLK_MQ_F_SHOULD_MERGE, NULL);
 	ret = blk_mq_alloc_tag_set(&bdev->tag_set);
 	if (ret)
 		goto out;
-- 
2.29.0

