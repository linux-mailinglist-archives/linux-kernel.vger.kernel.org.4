Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B32B5F4EB2
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 05:30:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230108AbiJEDaM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 23:30:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229845AbiJED3Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 23:29:25 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2061.outbound.protection.outlook.com [40.107.243.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8BCF74E15;
        Tue,  4 Oct 2022 20:26:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TWOlD87FBwG2JBf1jXQSicFR/4P5xTZ8GRa1SOaLU7Qald4UO23V2zjTqyY6jRIJDFh58qYLw4euQAn5rzMW+WLKOuywMUFJcAiI7p1aZsLACpIaFTdWJmwniAvIz5OCjCNlbX48Ua+v2IpEZBW+Waa3ILYIjYVFkFtlzAiPqVIgVSkR11+HtrFxDhWklTAal3zenkCoPQVDg+X+3gYsuizLHh1X7KxNw/wzDuwaPML7C1kGGbJ9Y+t/08Av3A3QlH2e+KUMYaom9Tju49fqisdV68IaDd9MQZbeqEuJlHHnqjw9xY04UXTPZuP52jchn5xsnH/FrP+XKPqom4v9oQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=obomK0T5klYaa4A2eSWQ0K2Y/38kN9AyUn331teBaM4=;
 b=M8AWB9Dl2SmmgNkXt7TRCwRHKmDKsCuIH3U5Gp+PMjEiUsDsVgNx7NalJ/f3UvPPH8tZRVxlDV2QLOD51RgsfRHwB9dGcRMNVU9BpPJtIysvlyY/A7rxJW+mCh0PuW5htJZWrHbOxuJd70Grsb4v1xFN4QkHI0ONIpzDQZmdQxVnx4zb8cljqzP01wv4m5T3UVSAi056rWO7i6/oCOc/2bjWErfiRZBc6b/KEe6X43tBA2gg4kDK3dzX6nl3uyTBfFIQH/jH4rR66LOgocd91ifIwxvijc+VveUdsME0tcjvB3i7c6oWrdoC+2gMV+CZFB+NEMZtQrz79C3x2FYkZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=obomK0T5klYaa4A2eSWQ0K2Y/38kN9AyUn331teBaM4=;
 b=OZKUA2/qhsCcJAcq4fyol9bp5kq70bdRuEco1VIBQ00gh8RWyc8sNHVPi5krAY3ChYS5p0fCAKjOnoZC1sekuyO8uaflkJ6yrP1kdFdYsUoG+syfSueW2srVtaemgdzB6XxBKBjDNeBnu42de/U71beNOKgLwDl66i36kC67XZlk5RalMnVj9gfIo8A7PQr4CcfTp9+e3BxCt6nSYYAOU1RbrmSYhKuZMI/mJvctQjiz/ZojlRRYdUtkNz1vuzUvYRQXWAKCEKAFNB4wvs3XMtkqOXvasPLfSgNZI8OZ/43HJVro5jBiC4QJeE6CwDwlf3MzDpQpYjlE1ozm+Th7RA==
Received: from BN0PR04CA0095.namprd04.prod.outlook.com (2603:10b6:408:ec::10)
 by DS0PR12MB6631.namprd12.prod.outlook.com (2603:10b6:8:d1::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.28; Wed, 5 Oct
 2022 03:26:48 +0000
Received: from BN8NAM11FT059.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ec:cafe::18) by BN0PR04CA0095.outlook.office365.com
 (2603:10b6:408:ec::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.19 via Frontend
 Transport; Wed, 5 Oct 2022 03:26:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN8NAM11FT059.mail.protection.outlook.com (10.13.177.120) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5709.10 via Frontend Transport; Wed, 5 Oct 2022 03:26:47 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Tue, 4 Oct 2022
 20:26:34 -0700
Received: from dev.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Tue, 4 Oct 2022
 20:26:31 -0700
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
Subject: [RFC PATCH 15/21] ubi: use lib tagset init helper
Date:   Tue, 4 Oct 2022 20:22:51 -0700
Message-ID: <20221005032257.80681-16-kch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN8NAM11FT059:EE_|DS0PR12MB6631:EE_
X-MS-Office365-Filtering-Correlation-Id: 925da003-08c3-45fe-274d-08daa6816f90
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dZrENzI9XzqP6EmAtr50TJ9YpeDJ5arWWovZUfvvoQRpvNXLOITt9r7WvsiquDqrizW7aWaP/6yoGqnR0NhTgEWaNprn+LFlLPGafSZhPXOl+kaJyz7BMuD6mz1iI41mTtkNIvPBLnStBEUzk4PC+sCB0B3haQ00bf/iXwimsK/ovjQJM6WvLBJWugT/opghklyVk5Kzt4kAZxVuULjFEVS6kAv/EMWKAdfWLgeFRy0MfGongrp/Uzg1GzX8yPcCxxDGxShi1PE6ebWjlM67tF/h4RomMBaxsCaTsAwU9ifvdgSNAa+S6E9fMmVVL2xc26i4beyqrTdovVi2hl0LFdwMgiHgyeGH5bNDx2atMJF96Jn6LiGtUryrOKz1+0thQq8xR+N5PtkEcm+rccxEB/hKNIzKfTCMoWonKuuzj+3RcwNiYvOn28uL2B1DkuSEgfOJorElSkM4ALPRmo1Zj4JBdscmy2GJ3kMESfGwECWjdF4yv2X2OQDOBiJIvjj4aDaEEwUyYX3uwjrlzKvhhgyVfP4XSy1OzWgD9WGJBiMeokGLer6/hSfRu6PELMqg9aQGDra0tDd4ifKbvoRxpg4rOhtP9yqFa7+VcIaflnzxxdKlnjNTybUG4Y+1Rgo17t8N/8AR+2wTp2WjmX8tklZdd5AfOEGmbJR4BZQVT2+MtonetnLHBg9x10KxgnY3mXOQ2K4Rg741Sk/AF89iLtPIg2XvWVIejDx+DuwDbTH0MyOsJwDLrHGG9brRrcmDO9AaXnXtL1FvxCRLyJLQGO6ZtlqdoGuxo301w7wRAptHHxKfF+wD9/vhTaHDyrbRx4rxNh3wX5Suxr1YOAuY4aqBg31lA3l/+gtsPRqgBe8=
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(376002)(346002)(136003)(396003)(39860400002)(451199015)(40470700004)(46966006)(36840700001)(7696005)(316002)(110136005)(36756003)(54906003)(2616005)(26005)(356005)(7366002)(7406005)(1076003)(82740400003)(7416002)(47076005)(83380400001)(426003)(16526019)(186003)(7636003)(921005)(336012)(6666004)(82310400005)(4326008)(70586007)(70206006)(478600001)(8676002)(8936002)(36860700001)(2906002)(5660300002)(41300700001)(40480700001)(40460700003)(21314003)(2101003)(83996005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2022 03:26:47.7494
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 925da003-08c3-45fe-274d-08daa6816f90
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT059.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6631
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
 drivers/mtd/ubi/block.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/mtd/ubi/block.c b/drivers/mtd/ubi/block.c
index 4cf67a2a0d04..809e946cfc93 100644
--- a/drivers/mtd/ubi/block.c
+++ b/drivers/mtd/ubi/block.c
@@ -398,14 +398,9 @@ int ubiblock_create(struct ubi_volume_info *vi)
 	dev->vol_id = vi->vol_id;
 	dev->leb_size = vi->usable_leb_size;
 
-	dev->tag_set.ops = &ubiblock_mq_ops;
-	dev->tag_set.queue_depth = 64;
-	dev->tag_set.numa_node = NUMA_NO_NODE;
-	dev->tag_set.flags = BLK_MQ_F_SHOULD_MERGE;
-	dev->tag_set.cmd_size = sizeof(struct ubiblock_pdu);
-	dev->tag_set.driver_data = dev;
-	dev->tag_set.nr_hw_queues = 1;
-
+	blk_mq_init_tag_set(&dev->tag_set, &ubiblock_mq_ops, 1, 64,
+			sizeof(struct ubiblock_pdu), NUMA_NO_NODE, 0,
+			BLK_MQ_F_SHOULD_MERGE, dev);
 	ret = blk_mq_alloc_tag_set(&dev->tag_set);
 	if (ret) {
 		dev_err(disk_to_dev(dev->gd), "blk_mq_alloc_tag_set failed");
-- 
2.29.0

