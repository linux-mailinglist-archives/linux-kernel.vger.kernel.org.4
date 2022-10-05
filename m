Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53CF75F4E60
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 05:25:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229751AbiJEDZt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 23:25:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbiJEDZJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 23:25:09 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2083.outbound.protection.outlook.com [40.107.220.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1893BFC1;
        Tue,  4 Oct 2022 20:24:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W57sPNsGekLwtkL07/wnwSdw6UMFDT3Cu4FmilT+/G/NaED1Evvklt72Gq8oAm+JwHw2zTB2/LrIdoigHDPwsK17npmr3DNlygwK9hOQ+Ddcd4sWQ5x8E7IDKGk9AGnN4C9UVBqjFRQ3/2ELNlIoXShq4ZY8zoGJSJRBdiKISH1wsX4W7h6FwWvfizoKXoKj1+4u37mwZ9jm6yzgZlDak3kNKmxjARqCae1bCw+T9uLQEVrBfGkkBRCd+AAWTpDCZI93JUWGLfF5Z+PxZY1AU4+qkjY9Vn7Zi0Mzn4qXbfaNvd/USXdmb2zNtG9RY421QdK1gQpzaz7spRmYYwewSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2TjTeSVeDJKhYfrKaFcN6TJ+NYAZJNOZl9L2P0tbCrQ=;
 b=l8rfS/a/9aSA9KzKoh7/whF1VnnlYOtxb+zQMdnpKf07RiMmsHSLfVMOPa09kMahS2MPvmCU5IR5YT0vCrl0mZT48o4m2S3NPiT7cb5MLRNkeKUFFWuYzgQ/mXdXyV9J0gSmA5kzLoVgl8qvdiXXI1aJMDsf+/YLE/JuATL63FpR5iKFI0YW4JO7j+NMwTFimhIZKs1C2Rz6M6RSRTZI/BidBrzcFYEK4c9nbU1zZcxw7KXoKN9wVLGrneB3N25/ibgymkEKQdfZj8Y9UhHF5X+4NF+9PNribcZlsXNXnOwOysR/wmKBTBwvwAQzfB2MkRWsmIISwNa61GTjN1TUGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2TjTeSVeDJKhYfrKaFcN6TJ+NYAZJNOZl9L2P0tbCrQ=;
 b=q05Pg+2QcOc82giKNJIjnflMRh7/pPbhD3VQcGEzc1fsC5ZtAJkV50hpC+m/q68XzwpcOx4fapsWcVqUPCWM2RJxp5kBPGzMO1HlP5M7j52WkfopUCQjP+KgNzs/vJUUI6yczqJ2j61d4PuwZGJEzzDb8d1qBGytajBG5NnT47IWX/S2IfqqNdwMLEK99+ki8igZCP2zy4rL+wFVYPRZn2svZ5NdQn+23RH6IljwcvqJNgPLC/lwScLNZib0oUQFSuUk7ol5lD9DTR9WwVkQ5TCc4Gt2566DedCNuLd+HPcT/CZgZwCWu7UIw6ZeO9U7PzONlLmsfgoKYeXsSsYYkA==
Received: from BN7PR06CA0040.namprd06.prod.outlook.com (2603:10b6:408:34::17)
 by DM6PR12MB4106.namprd12.prod.outlook.com (2603:10b6:5:221::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.28; Wed, 5 Oct
 2022 03:24:33 +0000
Received: from BN8NAM11FT089.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:34:cafe::82) by BN7PR06CA0040.outlook.office365.com
 (2603:10b6:408:34::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.23 via Frontend
 Transport; Wed, 5 Oct 2022 03:24:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN8NAM11FT089.mail.protection.outlook.com (10.13.176.105) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5709.10 via Frontend Transport; Wed, 5 Oct 2022 03:24:32 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Tue, 4 Oct 2022
 20:24:31 -0700
Received: from dev.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Tue, 4 Oct 2022
 20:24:27 -0700
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
Subject: [RFC PATCH 06/21] rnbd-clt: use lib tagset init helper
Date:   Tue, 4 Oct 2022 20:22:42 -0700
Message-ID: <20221005032257.80681-7-kch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN8NAM11FT089:EE_|DM6PR12MB4106:EE_
X-MS-Office365-Filtering-Correlation-Id: 8765208f-722a-4fa0-2032-08daa6811f30
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3/au/d84MAunj6ShDV+GzIzamuZV44K7xPCuoWO9s4o8zERef5z56zAmy8m9VzXA153MKBfpKpc42C+9iBxb0OukG4j/8eJ+1DqD/mOtzzDNzXcTBoP9mTIxyoNmnNUrzocPUUW8huEw9QGKn96z5v1lzMQCJiIetTex2/XkK4WLSQtsD0gLKe2Phq/2gnoeKauISv9UjqBCwhb668zc6zDmOtPkC8FUAZXTr9eCaXAHvV2Ik71Rigz5w2qdJvJlh19Xd2HmNCGH93XeFZia237UaLbH7c5VXB0VNu3gIRiNHpIpv8AwwrsCWNT4bPA6g0gc+O4ScU0+4JOoXLGf/oWbMOFY00SPQiuFgmSb3EomIKGeH2U+uqWxtmk+0uX6uEL3B42EKx1YFA/XoMvo0sql9yA+mAJF2FE6hfSh+1BbcBmF/dIgQznNNMt5L8Uz2V5S54mFVuQCaf6/0XF3qOpIOCIVj8My2ooA+ubEZL04CpZ1Tu4bqn39oflKVb1szJwpR7C3UmZ7FqUne0ZZevDZSHMlfzHeiYR6ChRQhyrjLRMcx1b7Q8+T/hBtACTqyIJUi0JO08Q+WYzvvw9FLRQqBI8D7w7/t9A146czHI8G/F/XREAwWzeX2EtzqSbL8GGWIpAa3Nnm0t6xi4ECPaWcTFK9SdQZP5wDMKHvzXVbw8IAzBP/5xPvAhCTGMhfQb/KoEGtEWZx9XpLyZdzXnTbSkscGYKn1W+7+DUqw/kZi97dOxO7WFTjHhfkqciQZtxJfUdduQZXkg2QLHFQKT1gmb5cTQlVET9aKJTuqcN6jZ3xxV4I3ORWCZgjsWvbPgI3VAsujydtHjCA1pgIxywP3JMjyUCJeNTUt0Xk/eg=
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(136003)(39860400002)(346002)(376002)(396003)(451199015)(36840700001)(46966006)(40470700004)(1076003)(186003)(2616005)(16526019)(921005)(82310400005)(2906002)(356005)(316002)(70206006)(6666004)(40460700003)(7406005)(54906003)(70586007)(110136005)(4326008)(8676002)(478600001)(41300700001)(5660300002)(7416002)(7366002)(7696005)(7636003)(26005)(336012)(426003)(40480700001)(8936002)(47076005)(36756003)(82740400003)(83380400001)(36860700001)(21314003)(83996005)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2022 03:24:32.9023
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8765208f-722a-4fa0-2032-08daa6811f30
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT089.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4106
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
 drivers/block/rnbd/rnbd-clt.c | 25 +++++++++++--------------
 1 file changed, 11 insertions(+), 14 deletions(-)

diff --git a/drivers/block/rnbd/rnbd-clt.c b/drivers/block/rnbd/rnbd-clt.c
index 78334da74d8b..8f67a7e5299a 100644
--- a/drivers/block/rnbd/rnbd-clt.c
+++ b/drivers/block/rnbd/rnbd-clt.c
@@ -1203,25 +1203,22 @@ static struct blk_mq_ops rnbd_mq_ops = {
 
 static int setup_mq_tags(struct rnbd_clt_session *sess)
 {
-	struct blk_mq_tag_set *tag_set = &sess->tag_set;
-
-	memset(tag_set, 0, sizeof(*tag_set));
-	tag_set->ops		= &rnbd_mq_ops;
-	tag_set->queue_depth	= sess->queue_depth;
-	tag_set->numa_node		= NUMA_NO_NODE;
-	tag_set->flags		= BLK_MQ_F_SHOULD_MERGE |
-				  BLK_MQ_F_TAG_QUEUE_SHARED;
-	tag_set->cmd_size	= sizeof(struct rnbd_iu) + RNBD_RDMA_SGL_SIZE;
-
-	/* for HCTX_TYPE_DEFAULT, HCTX_TYPE_READ, HCTX_TYPE_POLL */
-	tag_set->nr_maps        = sess->nr_poll_queues ? HCTX_MAX_TYPES : 2;
 	/*
 	 * HCTX_TYPE_DEFAULT and HCTX_TYPE_READ share one set of queues
 	 * others are for HCTX_TYPE_POLL
 	 */
-	tag_set->nr_hw_queues	= num_online_cpus() + sess->nr_poll_queues;
-	tag_set->driver_data    = sess;
+	unsigned int nr_hw_queue = num_online_cpus() + sess->nr_poll_queues;
+	struct blk_mq_tag_set *tag_set = &sess->tag_set;
 
+	memset(tag_set, 0, sizeof(*tag_set));
+	blk_mq_init_tag_set(tag_set, &rnbd_mq_ops, nr_hw_queue,
+			sess->queue_depth,
+			sizeof(struct rnbd_iu) + RNBD_RDMA_SGL_SIZE,
+			NUMA_NO_NODE, 0,
+			BLK_MQ_F_SHOULD_MERGE | BLK_MQ_F_TAG_QUEUE_SHARED, sess);
+	/* for HCTX_TYPE_DEFAULT, HCTX_TYPE_READ, HCTX_TYPE_POLL */
+
+	tag_set->nr_maps        = sess->nr_poll_queues ? HCTX_MAX_TYPES : 2;
 	return blk_mq_alloc_tag_set(tag_set);
 }
 
-- 
2.29.0

