Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B13BD5F4EA6
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 05:29:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230078AbiJED3c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 23:29:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230090AbiJED2i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 23:28:38 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2058.outbound.protection.outlook.com [40.107.93.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DD0674BBF;
        Tue,  4 Oct 2022 20:26:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eILQJuxWv5QK82PYsOP1ifTBGmlSEd8DmNLb6nRr3FjLEjjaqqKPzwHJF9eBT5uKMbTC+Jne+7/KGHQO67+Tl6LyJmgTxW8N04ts+QljXeF1FkTGXV3Ntico+GsyosBTg06nDLMwuvgUVL9fCibPXStwsFPSZp7Mlva5QwGhYwy53uPFnkrA7sfPC9iKhaxFdz/WgvY9AGMNgUPX2vkr8g3hIFKgCn9DcP/kSf2NG7sqjpQJkUByatBaucWvWrGbK3MDIzbKnumakjzYgYFnOu/F5kps2m9ztUw4LTvEOLbuuvrcWy46o2S4dFUtGsqHEvsHW7ACIeuOx2JigS08fA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z9jMejWB/EUfr47XlGQr6GEGKwqscEUqlrud+Ig5cWM=;
 b=iRPtb8alz4jbm+u586AfN9GSXB13lRko3HDSi20AWH5GWXmWAGJ4x/nNO5T6NodiSfj7VldxQ8NqGob+Ky0z3yhgSb1GFtpjA9CR0K4q+xDw66AnwLcGh2JJ0go6t7Qms8xtuTt4x3q20G4Ri2TIRxojOTjYgwxhi21HB4FzLb6Cc8GJFFfcyqWnJi1Oj86vOpitpIqol6bvmJjJGeWQc5J223LKmQJWoVJtmnpi5/jS4yQFfpZNcmtBkC3ctbHq+y27+0rfw9/jl2Pf9nZohSXoY7FOgJ5e91NdepKYvkJCLjIbpXxl1/rSAeT3QOxEjnMsEwgx5dm53eeNy/ZsqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z9jMejWB/EUfr47XlGQr6GEGKwqscEUqlrud+Ig5cWM=;
 b=G/lt8Mi5qX4nAGCzdMNk/unjarsxGOsVDxKygFdj8LKDM3ynSsKenpoPbmyjbRvYovreieicI5a/HxWFDUgEiPsOx4X2yWnEwff59oL2xENW57rQFOgXe0Zs27lLpAJAUCcd2BrEALKtyk1z7x6u0LfLJVj19KcBIoDU1XMjKFZ/4joJyKL2R/NT1Ghqs4NAoJM7L7o0rNOybGC/q1iZp+pPI7TV8jUYsE6Zh6jWuBlit3CaI8KeSv5ICYujhr5twZt7/LjjoLmyFCmTcaX7aMdo9iG8IaSSM2aUPS5nQPfoXPTqhrYWXkPLc0a5mIlzRc4YvemL2pNrR+UMXNozag==
Received: from DM6PR04CA0018.namprd04.prod.outlook.com (2603:10b6:5:334::23)
 by MN2PR12MB4157.namprd12.prod.outlook.com (2603:10b6:208:1db::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.28; Wed, 5 Oct
 2022 03:26:07 +0000
Received: from DM6NAM11FT103.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:334:cafe::7f) by DM6PR04CA0018.outlook.office365.com
 (2603:10b6:5:334::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.24 via Frontend
 Transport; Wed, 5 Oct 2022 03:26:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DM6NAM11FT103.mail.protection.outlook.com (10.13.172.75) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5709.10 via Frontend Transport; Wed, 5 Oct 2022 03:26:07 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Tue, 4 Oct 2022
 20:26:06 -0700
Received: from dev.nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Tue, 4 Oct 2022
 20:26:03 -0700
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
Subject: [RFC PATCH 13/21] z3ram: use lib tagset init helper
Date:   Tue, 4 Oct 2022 20:22:49 -0700
Message-ID: <20221005032257.80681-14-kch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DM6NAM11FT103:EE_|MN2PR12MB4157:EE_
X-MS-Office365-Filtering-Correlation-Id: c8aaa151-e84f-40a6-da8b-08daa681575b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Pf++NxpYvbqLdqrAzne9XFM7eZ/N7HoNMI8nIYp2/nrRabZuknnGXZc206iRAe4Z9Q0I5he3Li5/08nGqI+i6arPaMylXU1GaVd2rFOVzWaFPfZIMFv9yAW/WaPYg2yBqRE74ldSRTWOAvJNZ1ukXpgX0PY39tkqt/OFeC0p71rVYV+NaSriEbju1d/Ii+RpZ6jQ0r39p3FUelgoclU0Dw5n2wRwk2qobumf7xqJ+g3Is5XGBvpLveBHGLJZL1ojlLnGZamPsWvLzR4dgUMbOJQbpvVrVGjUlVLc7Hqu4FEjqefO8om2zzG6TsMPl+rtlY83GsWlhJHEB3WRUBsBzf7aNdMfVKTdhfXlnNDuh209swGDrmfuqGCUulHhP2fuSD2TKtRQrEtYDnoxPIOtaDezgJqnuhhKWTTM4GBEfMiNawhSZ8Ic36Fd3mkQ9faDjyNvghH6+HK9/iDWv1cHoQ5vlV0MVLWrnTSX2VTKAWkc0HskmIM7KiD2crvOifwIa4AaFHOfMGOTal+DtlwkxuRUQx1bX9G6CZYtJq6n2M18IzahugB7ix3nY4tnc44KHXDPo+NqwkYKJIwSyzjbR4OYYVc++rYYKVb+WG99bdlRarIxLoVu35GwZC2E4PYN8jNbOQggr6aFltjUFT6iYT0mL66bBWDmKYrwVpxyiO0PrYwaM0WaUwOMY6AOH5V63K7ESiNLAI00OwXE108bMOFo/vwuj6dVuGtDmixH214t3Ky7gWTiCIOtFFILQqdLGcCVzxQFcUc1ZGDLHnxWLtqUf9PEQ9dQdra9u3oBTPvaq+c33ExKeb0DD6VTTWYS5y6PaQVAKD6iR2peyTQ70206zyxmsYmcQXXEykjliWmg/SoX/EfEY/XUVVMzJZL2
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(136003)(39860400002)(396003)(376002)(346002)(451199015)(46966006)(36840700001)(40470700004)(40480700001)(54906003)(356005)(921005)(478600001)(316002)(82740400003)(110136005)(7636003)(82310400005)(426003)(8676002)(1076003)(4326008)(70586007)(186003)(16526019)(70206006)(5660300002)(26005)(41300700001)(7416002)(7366002)(7696005)(36756003)(40460700003)(2906002)(36860700001)(8936002)(6666004)(2616005)(47076005)(7406005)(336012)(83380400001)(32563001)(21314003)(83996005)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2022 03:26:07.1569
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c8aaa151-e84f-40a6-da8b-08daa681575b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT103.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4157
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
 drivers/block/z2ram.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/block/z2ram.c b/drivers/block/z2ram.c
index c1e85f356e4d..b381d652d911 100644
--- a/drivers/block/z2ram.c
+++ b/drivers/block/z2ram.c
@@ -351,12 +351,9 @@ static int __init z2_init(void)
 	if (register_blkdev(Z2RAM_MAJOR, DEVICE_NAME))
 		return -EBUSY;
 
-	tag_set.ops = &z2_mq_ops;
-	tag_set.nr_hw_queues = 1;
 	tag_set.nr_maps = 1;
-	tag_set.queue_depth = 16;
-	tag_set.numa_node = NUMA_NO_NODE;
-	tag_set.flags = BLK_MQ_F_SHOULD_MERGE;
+	blk_mq_init_tag_set(&tag_set, &z2_mq_ops, 1, 18, 0, NUMA_NO_NODE, 0,
+			BLK_MQ_F_SHOULD_MERGE, NULL);
 	ret = blk_mq_alloc_tag_set(&tag_set);
 	if (ret)
 		goto out_unregister_blkdev;
-- 
2.29.0

