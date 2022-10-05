Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E2B35F4EBD
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 05:30:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230120AbiJEDav (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 23:30:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230050AbiJEDaK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 23:30:10 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2081.outbound.protection.outlook.com [40.107.95.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BACB372864;
        Tue,  4 Oct 2022 20:27:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EiVtJTW+oBh+kArG1fbzz2wSTi7APUws/Xy40O7+DN3s/E/jxabBHyePrtz6E3TX6GItVwmMGt2OTukdIVMRlX62xfACse6A5uLTkECdB3g5vVgCPZsYmLbrqdUCWhNH7FjQvDpvVWB3j9/XdAy4a+9eEIbQ+WiN4QlurZqLyB85NtqVtsV1e9hbJ04WA7b06ojBvS8NmI+DYKeM97GlA8LjRMYe5q8heIdDF6qmoR0mLqxCWA2d4w22fzO62cs91QDUC5MuxrliIFG4UGVxeYaE9+RJlHjDDsTVUE2HKwR5U0dy9dfbMgkTXMRNOjb4Q5FMtPhXXxtnbp8/wwIDIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MXVYl4Xl/zgbwGuqkrsF2gd8c3ru2Bj/s3kt/V+4v50=;
 b=GpMLa9V3jmKKflMFYgzM8wMtKYQzooDz+XTe4Q9F5FHFLyjGYAnsn1m0SKPVw+qApCOWhZcy7L+EvwYvMjNRBwO9pL6bi0cyYB+SIPu2na08FYa9eq3Hwx0MNAERWK1w+pR7+eEsCrkA9fH4r3Bn/eLW91OtMazmXrsv420haPENN7SyIuQBrmDec5YKfkpVQHS/cwKUsTjBWPx3GZXRCJALAPL4uvqNIyRmr++TD/BwNelhTIErTfBhTIccUpOHOporZkrMNjxinryzI1V8H13AhWmOkjGDbQDowU544YNdPFz+TulCq9b7P1+PSO3uAjtm4ojLiKkenHaxFwPgVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MXVYl4Xl/zgbwGuqkrsF2gd8c3ru2Bj/s3kt/V+4v50=;
 b=K0ZdxQrbmm5CPlX4VZZ6HT5iTMm+51AXdPahb0aloAfJIv2WLJD9lya+CaZpvyuZEBuRdvwLD0sVCQS1hJdeqlNC0aHPOeCW2ffLkDQX+q5KfpkXFFnKrxyrMzZF3ot4TusNIneghwYvZvAVV8vT6WOaIvy9h7TfPhWxQFwhGrwIvHE5xQ4j17T6qSU5jfc/1p6cGDQV7hD/mr88jrKddOmAvxpYwH/QatrCGb07UHBk95qxs9T42CuXsZU871OqQU7UypY/3CsSPy7VZd1KkLT3190kaAi+NadYSGWIFdP/plvK9sJG8f2WkUIktEoYUJTf8ilPgis4aLQmKNOhEQ==
Received: from DS7PR03CA0090.namprd03.prod.outlook.com (2603:10b6:5:3bb::35)
 by SA0PR12MB7004.namprd12.prod.outlook.com (2603:10b6:806:2c0::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.26; Wed, 5 Oct
 2022 03:27:07 +0000
Received: from DM6NAM11FT111.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3bb:cafe::8) by DS7PR03CA0090.outlook.office365.com
 (2603:10b6:5:3bb::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.28 via Frontend
 Transport; Wed, 5 Oct 2022 03:27:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DM6NAM11FT111.mail.protection.outlook.com (10.13.173.26) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5709.10 via Frontend Transport; Wed, 5 Oct 2022 03:27:06 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Tue, 4 Oct 2022
 20:27:01 -0700
Received: from dev.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Tue, 4 Oct 2022
 20:26:58 -0700
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
Subject: [RFC PATCH 17/21] dasd: use lib tagset init helper
Date:   Tue, 4 Oct 2022 20:22:53 -0700
Message-ID: <20221005032257.80681-18-kch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DM6NAM11FT111:EE_|SA0PR12MB7004:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a0f5998-fcd5-4800-6db9-08daa6817ae8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HmFdWdkVIaUwa279eRdbBxBAj67RNgjbT2j2HrUQhZD2HMg/5GcNl5P6P9V3GSyNiJPB5ViFej3iS91K03DEsEvUN6c6/qq3LR/UxKg3JGT6KlTC1t2mzxWBleBZbkIHPbUlMLaQUqcqWbUmcYf7YAXsw1dzfPLCr1bo+P1GLJV3BwoY2GtZAzgh762rlBxgFz15AQuUlfkl830SijeWc8VzosixZI4hyeaVJvvvpaUVH1qQ0smP+vnBcD7tIVdAXQjHOQTmdaoypYQk2pMB97483eVu5HyO+uqmhqn82wQ6+Q+4iRDxK3h7lnljvXVt6LQ21uDNLmX8VVdpcj3+P8VL9r0i4ff4reMyP51L39j8irLs5xSLpZIHdDWtw4A3YlWWAeFQ/LbZr54sMpaet6mMdj6GmJUc31Aqd2iToig76yI9iXQYvK4lGHvimc3C7ROUsBohvV6LeVN4NFydpTunW4xgewotUwijNCX2KqTKsw9P/YFSgWn69UaW0H3fChGtOgHV5o9GkfhwFNx+rU2Jo4aA31uv5LFxh+wPlMGL7sZfeYNQoC+trzIi0riEftKBRTyqWraw/yAnMiPpJeEtmz1GUuC68xj+oJPkXeu1IgBlJ3h3MjRT9pIikFzWfC/gpC/SaLLfsID+AkvW5te0UV+1EQqzkLMThYgeD6o14Z9IxY2uH7SBkUCGR/XOJAFTlwPakSH3Au7NzQQ5R+kWt83C2cbcpOyKlnXIebG14hvceyTnclzlh50qk+5K0LQv6c+UGufEyrqfgXTfSLToC+E9Ggn3KmCebAjq18g90kB0bJWfqAY3wq0gifYBzpwn9E/ZtzuzsIjbbRZaWQM+cc3CATw1XVihalmnHec=
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(346002)(396003)(136003)(39860400002)(376002)(451199015)(36840700001)(40470700004)(46966006)(7696005)(40480700001)(82310400005)(2616005)(36756003)(40460700003)(478600001)(41300700001)(6666004)(26005)(7636003)(83380400001)(70586007)(47076005)(2906002)(1076003)(186003)(426003)(336012)(8936002)(5660300002)(110136005)(7406005)(7416002)(16526019)(356005)(316002)(7366002)(36860700001)(921005)(4326008)(8676002)(54906003)(82740400003)(70206006)(21314003)(2101003)(83996005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2022 03:27:06.7985
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a0f5998-fcd5-4800-6db9-08daa6817ae8
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT111.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB7004
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
 drivers/s390/block/dasd_genhd.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/s390/block/dasd_genhd.c b/drivers/s390/block/dasd_genhd.c
index 998a961e1704..a7c55b7e5f6d 100644
--- a/drivers/s390/block/dasd_genhd.c
+++ b/drivers/s390/block/dasd_genhd.c
@@ -48,12 +48,9 @@ int dasd_gendisk_alloc(struct dasd_block *block)
 	if (base->devindex >= DASD_PER_MAJOR)
 		return -EBUSY;
 
-	block->tag_set.ops = &dasd_mq_ops;
-	block->tag_set.cmd_size = sizeof(struct dasd_ccw_req);
-	block->tag_set.nr_hw_queues = nr_hw_queues;
-	block->tag_set.queue_depth = queue_depth;
-	block->tag_set.flags = BLK_MQ_F_SHOULD_MERGE;
-	block->tag_set.numa_node = NUMA_NO_NODE;
+	blk_mq_alloc_tag_set(&block->tag_set, &dasd_mq_ops, nr_hw_queues,
+			queue_depth, sizeof(struct dasd_ccw_req), NUMA_NO_NODE,
+			0, BLK_MQ_F_SHOULD_MERGE, NULL);
 	rc = blk_mq_alloc_tag_set(&block->tag_set);
 	if (rc)
 		return rc;
-- 
2.29.0

