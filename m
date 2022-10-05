Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C50065F4E55
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 05:25:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229970AbiJEDZQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 23:25:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbiJEDY2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 23:24:28 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1anam02on2068.outbound.protection.outlook.com [40.107.96.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8C2472B5E;
        Tue,  4 Oct 2022 20:24:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cEJzhJtv7KeHwSHv6LhGg+m3n+P3nvgkmf9fNdEd/R6KfD0UkAOyXxpDKnd3tLpHelgwvq9/tJFWWH2vThHJDyVOj5rcdumOdJMDkJh8pI4QmKCYb61Wsyf9ep6UdlunffRNLvFt2qSfb9FpxA650n5YCbIiXBWB+/9cXZwjCVN9M9yrVNZ9Dc0kUwmmlK3t3SuWqr7r3dzYpiFq4tg8ZMUTq3bB7JB7vSMppgx+nIC8ldKFpNV32M35613JrLtxaEo1hu0ib2BaItGEHOA/9Gj7+neFHgYIKdhdOO/Gqi6x6y4RI8tpK3vXkk1kkzmik+G5YJqg9vr63oEkQxmv4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/TkGj0VL9HqhEuTnfL0YyC2vFcckdgMqb6lAf6o0lVI=;
 b=eDMA2BvDQ5GI2xelmEbjwPSgtY/mr3Fsgl7eMhUPlH5BmL59lps5FXK2FW+WdJC/Iq3fGt9hCaPXfT2UfJG9yKuQY37PY49ZOzZHvd8e7yzBjTofvv1eXlHTWLUWhxglatk6zoBvPb9/T1gBYelI/dki5BBgDkgwhOOGRh/kWpBaN0OvZgNcK4LpvfoSRbPiY0C29VSdb/IpoRs9mEUcPTGqIHscIJ89sMbZC+D/WvfL4j6hbLVF6HejJBDTJIEypHoKgaAR8tLxDnmfZj+SsJ9QoioFlQn0G6e/Bo0ivnb5WLST18rA88ao4sF6L7mG5sWCQiMf80xr6sinpCI2Zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/TkGj0VL9HqhEuTnfL0YyC2vFcckdgMqb6lAf6o0lVI=;
 b=txh88/V6Y3XuTUrDB3OXcjW8uvHQzbL520zXv48MD1DIhqmNotnrrB7eUw1NLwXgJQKOMcC7l6u7+9Pb7tYVDprFWezKsSWbMTB4U0YRrVLIFHmOMr7w+s9tTJEvWyuXuDxShC8gs7jCnJUF6+k40UEKa6i//9DHeaNlia8I2jAxHRA+/NQItrjQkEOW82aB05vThp6ZjayqyKAEYnpVgkPFPLEAC16M95OOod05RWCSzXimliABQ9ZAzKQP1oFHf44bhgghttZgNOuGgpBqLPtj/A68dHrU9u6mVyg8Q6iJVsGGiE2ckvxLQZ+bBQDjcfadkd9txxxrA8N7aoK/6g==
Received: from BN0PR04CA0071.namprd04.prod.outlook.com (2603:10b6:408:ea::16)
 by MN2PR12MB4358.namprd12.prod.outlook.com (2603:10b6:208:24f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.28; Wed, 5 Oct
 2022 03:24:20 +0000
Received: from BN8NAM11FT032.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ea:cafe::f4) by BN0PR04CA0071.outlook.office365.com
 (2603:10b6:408:ea::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.26 via Frontend
 Transport; Wed, 5 Oct 2022 03:24:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN8NAM11FT032.mail.protection.outlook.com (10.13.177.88) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5709.10 via Frontend Transport; Wed, 5 Oct 2022 03:24:20 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Tue, 4 Oct 2022
 20:24:16 -0700
Received: from dev.nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Tue, 4 Oct 2022
 20:24:14 -0700
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
Subject: [RFC PATCH 05/21] bsg-lib: use lib tagset init helper
Date:   Tue, 4 Oct 2022 20:22:41 -0700
Message-ID: <20221005032257.80681-6-kch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN8NAM11FT032:EE_|MN2PR12MB4358:EE_
X-MS-Office365-Filtering-Correlation-Id: 67a9676d-4f48-4322-ab38-08daa68117e3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iC1jgkGtbsfq5vcPXcyDmTK3H7PJgoR6iU1vIIfzOU4hILm7lSpHHn0icG1AsrmXPTUnCBMywJtTb9xuoDMsXUaenI07CbmWFiNv8Cmzypw+eSXjVKW1xGxrGCGf7v0pV0m+ZYyB4iTU8jgddDHQ9Vu3rLd55dLHKygzQx/YTz/Q9FhtQGPQAGRAWwwYd6mMF7PlDZQCCoDhHHdMBchf5gSUvVyY8jdQa9wPicaaCqxFeEfGNSnDSdSFwyJBI3lpjylh5cVMMs0H2wM49AvR3U5Rkm/sMfex/bmOY4ibLZTHz8Uh+kKzvSL4RCZ/jD4/bVctL6F0nTNLdhyZYRpihSCEzeWWEsXNP3kcTLyJfbtbnyLzlwiafsY9S/U2HpJwLRF/xLYcfrctl+X7IrIpq4zXVAjS/tOOSo0Aa+DeiyQDrmsxoxNL9BPs9Khg9MaBWjUpPs41pOAfrVpJiJYW+le21DwTjzyCB+8x6z1nIXNnBJ445JZmRi/6s/pGR5NprxkSg0u4IB3wutll7O0bb0jgr0e0X9oktAkEBgX9wfx+6fuJffIynmTYiz1/KEJOLwVbeu8YyvNtkrglMTyr69dKvhcD3nkOpAEtvsNiLX2ifk8hfltDD8HckP1u98yr3miFXZBn/LrwMpp8IOMiWznR5XcFe6KYBg4htVtHNvv7nF+Vf+OZINuiAPr7UdELDLrmuEsl0IB3ABkr5zk3A4eqyzMk3EW5wmzAifZOf+kHSCUaQdY5HcNQQ24/OQwWrLDh0uBBnib9/+ol4FdV+PhFOSz/+Gxa46Ru5Rl7vE9H/EQK9w+ixUEeY3qAjZz3dXQ6q0qmBxldeIH4H8YntRXWpieZVjfk0Rf0EYgQeOw=
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(376002)(136003)(346002)(39860400002)(396003)(451199015)(36840700001)(46966006)(40470700004)(110136005)(36756003)(316002)(54906003)(70206006)(4326008)(8676002)(478600001)(7366002)(26005)(82310400005)(36860700001)(40480700001)(5660300002)(6666004)(8936002)(7416002)(7696005)(41300700001)(7406005)(1076003)(2616005)(83380400001)(40460700003)(47076005)(356005)(70586007)(7636003)(921005)(2906002)(336012)(426003)(16526019)(82740400003)(186003)(21314003)(83996005)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2022 03:24:20.6572
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 67a9676d-4f48-4322-ab38-08daa68117e3
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT032.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4358
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
 block/bsg-lib.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/block/bsg-lib.c b/block/bsg-lib.c
index d6f5dcdce748..3f28e24faa50 100644
--- a/block/bsg-lib.c
+++ b/block/bsg-lib.c
@@ -373,12 +373,9 @@ struct request_queue *bsg_setup_queue(struct device *dev, const char *name,
 	bset->timeout_fn = timeout;
 
 	set = &bset->tag_set;
-	set->ops = &bsg_mq_ops;
-	set->nr_hw_queues = 1;
-	set->queue_depth = 128;
-	set->numa_node = NUMA_NO_NODE;
-	set->cmd_size = sizeof(struct bsg_job) + dd_job_size;
-	set->flags = BLK_MQ_F_NO_SCHED | BLK_MQ_F_BLOCKING;
+	blk_mq_init_tag_set(set, &bsg_mq_ops, 1, 128,
+			sizeof(struct bsg_job) + dd_job_size, NUMA_NO_NODE,
+			0, BLK_MQ_F_NO_SCHED | BLK_MQ_F_BLOCKING, NULL);
 	if (blk_mq_alloc_tag_set(set))
 		goto out_tag_set;
 
-- 
2.29.0

