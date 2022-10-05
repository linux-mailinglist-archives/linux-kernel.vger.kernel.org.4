Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A29D25F4E37
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 05:24:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229766AbiJEDYT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 23:24:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229873AbiJEDYG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 23:24:06 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D3D9726AC;
        Tue,  4 Oct 2022 20:23:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nfhKkEgYv2aiNQEp3POyqtmYhWpzL5WgccX6YklyqA+GYvbaqcRS5cJlmb1QDwHxjSK0eSlZRZg0z7OHzPjtWJCtcLgj6f426N+pOZ4zEHn0GanIyvVCze1r9a+wWrUDrDiRJnh9Exdz5anBxwIuqyej06ZLpygPD115tHnaFYOZzwLSWyQZrGp7QxPc0lB5XNV9BPoiw8uWnMCOVHqZHvXcOnHx0J4JB4q6sZXuzU6DEXc4U9AkDDsHFMYnmh6a049gDhGQjQ7m1inQJNiW8Y54UAAyNTYz9anTLaqJ/p+hDCAr8zil0SujoaVKVF5mqkZX/uZ3Bu0s3kgXJkHsGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lChuMBUbOFhhqwMYG55HB+a43mZAtKoP2WF4KJFYW8s=;
 b=Q5VtezUk1JL04Mh/1YjitLKI9AgFxoxh1oTm3ks0XThwiZbRWUz7PxT89hq467nPnZqIgEK4GqdvPRSkSDj74NloZTtK5ARJook4dQJ0oaWl3bGdJaa/wMKCgFV+mhht7NuLIyx7a26pKCg7YIrF4fYQ9tU81u0Taa1q33LQnmfPdc8c3UXRJW6YIBRX973bcIzt/I8UReqNKEjH+4+sRoGiopoU19q9an4f+ApZZaUfR4IHbEdaX7719wL9BTOw8z9M3jAkrB0f3Br0bwsiYzp6BoBTyBpQ3LZkjWWc2IdTxBCxjP5TmF0rC9xmkCgbCy5jOmnqK1xXbYRzl6U6cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lChuMBUbOFhhqwMYG55HB+a43mZAtKoP2WF4KJFYW8s=;
 b=pzmTm6HkOUV3UVgyd5mMJFFUe/2vIyGMlnxER5JeWYVMUFHfe08nEQ4/VT+SCVOuZE73thu+aQhmAwdDVHwLl3BnaqHoejBMaxV88nuisJRQscpTDzyApQEFeqmp2ENnBe/JLeq1PaGUhzZv7u/8taN3F8if/XxI5K9NH2fP9IdYdhoSq4OmHs52xS3A2ZnGr+ZajYaOGW1KgN2lDYkb3cH6dYXc8R9ropyMtLm1cuR8CKEjP3I+GzeuzTNJjU8C9BIbKHFXKjj3srXiJvQV9LUGShaLpaiwVd00n4ASmV/KgVfVZq5jBJvbPM21Sq3u1qledUYx+t/doJEbMsV40Q==
Received: from BN9PR03CA0686.namprd03.prod.outlook.com (2603:10b6:408:10e::31)
 by DM4PR12MB5343.namprd12.prod.outlook.com (2603:10b6:5:389::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.24; Wed, 5 Oct
 2022 03:23:46 +0000
Received: from BN8NAM11FT026.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:10e:cafe::d) by BN9PR03CA0686.outlook.office365.com
 (2603:10b6:408:10e::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.26 via Frontend
 Transport; Wed, 5 Oct 2022 03:23:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN8NAM11FT026.mail.protection.outlook.com (10.13.177.51) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5709.10 via Frontend Transport; Wed, 5 Oct 2022 03:23:46 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Tue, 4 Oct 2022
 20:23:37 -0700
Received: from dev.nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Tue, 4 Oct 2022
 20:23:33 -0700
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
Subject: [RFC PATCH 02/21] loop: use lib tagset init helper
Date:   Tue, 4 Oct 2022 20:22:38 -0700
Message-ID: <20221005032257.80681-3-kch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN8NAM11FT026:EE_|DM4PR12MB5343:EE_
X-MS-Office365-Filtering-Correlation-Id: 6eb8e058-cf52-44af-d469-08daa681035e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: N63D4c9Sqwhwd9gnirIdsjnXbpQpXuN3ZkesPglRqtt8pE3qiTm3uld9PDCR9Qa2Nx/t19Q0WG5hWcZb0r7coevO1VgcYZCJl/DpE6pEIPI1G3BRtSGa6blhImTbwes4m5ftw8+M2V0hQDrIVUBPbfMTyD7JoId9TYWh2GerO3708HILCtSj/911Sft9wvFGqXPtsDk3LZbQzh1Vd1QV6Ip6fd2E2vUl3eqyeWZh6rgM6YNUSZ2+MdeV3LTFqP2QpIEvNqsBHNSOsD8RuP89qwfk2RLdfCEk0BfGVaAAdThtnZYx+sqIDfd5JBaBoQ1SeRd08b/a3swgyg9m3gsJpG0yAnMpVlf+WeJwx59+91f6ZedfAAZVAc2flFfXniu1RlFW0tQoCRln/2+DpAnDn6mz9jVEIVQOrkV+OPhtfPfVm0AyB9cBt5PIw0DxgBCax52UiwSWlpklGwXwPP4nB4Fu5HqbzGJNlbcPJibYrR7bavmtUDxKulAdi/FfELrBKGUHZQnEiSzCNLZULkXmcDzvRRNNqZbRfeVw66Pzvb7mDwTsg/EwJgn2sK0J5gjnu1fdJzbKNAoBoggoYGsSFPwWvAhZ2u+MNzeFdfLuw0pLEedfXyn44nJ5/NqpR747j7yGR8w+256Di7Q3sA4VRm5SYRcJ9JLBT7t8jtUUvvR0eoNocYFiz8d9SBk15nTnD9syCqEfoSliDt+w7H+65aXgKSmcRJNTLE9x+UG2c8Yw4zUAOvjizvTsiCWXZsdf0I4qpXCqQfxiGjo7XTe52Fsd7jg770N6tkJdk1dicZDYPS6HyAli0Le5bPRLfOZfGnKNkqBgOjXAwZi9++9MrRgYKmkEZoeGLf6A6H4eAbI=
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(396003)(376002)(39860400002)(346002)(136003)(451199015)(46966006)(36840700001)(40470700004)(41300700001)(478600001)(110136005)(8676002)(54906003)(4326008)(40460700003)(70586007)(70206006)(7406005)(36756003)(47076005)(82740400003)(316002)(7636003)(36860700001)(83380400001)(7416002)(7366002)(7696005)(40480700001)(26005)(8936002)(426003)(5660300002)(336012)(921005)(2906002)(356005)(16526019)(2616005)(186003)(1076003)(82310400005)(21314003)(83996005)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2022 03:23:46.1697
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6eb8e058-cf52-44af-d469-08daa681035e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT026.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5343
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
 drivers/block/loop.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index ad92192c7d61..a915f25b4410 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -1937,6 +1937,8 @@ static const struct blk_mq_ops loop_mq_ops = {
 
 static int loop_add(int i)
 {
+	unsigned int flags = BLK_MQ_F_SHOULD_MERGE | BLK_MQ_F_STACKING |
+		BLK_MQ_F_NO_SCHED_BY_DEFAULT;
 	struct loop_device *lo;
 	struct gendisk *disk;
 	int err;
@@ -1967,14 +1969,8 @@ static int loop_add(int i)
 		goto out_free_dev;
 	i = err;
 
-	lo->tag_set.ops = &loop_mq_ops;
-	lo->tag_set.nr_hw_queues = 1;
-	lo->tag_set.queue_depth = hw_queue_depth;
-	lo->tag_set.numa_node = NUMA_NO_NODE;
-	lo->tag_set.cmd_size = sizeof(struct loop_cmd);
-	lo->tag_set.flags = BLK_MQ_F_SHOULD_MERGE | BLK_MQ_F_STACKING |
-		BLK_MQ_F_NO_SCHED_BY_DEFAULT;
-	lo->tag_set.driver_data = lo;
+	blk_mq_init_tag_set(&lo->tag_set, &loop_mq_ops, 1, hw_queue_depth,
+			sizeof(struct loop_cmd), NUMA_NO_NODE, 0, flags, lo);
 
 	err = blk_mq_alloc_tag_set(&lo->tag_set);
 	if (err)
-- 
2.29.0

