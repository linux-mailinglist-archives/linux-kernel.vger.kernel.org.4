Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAD625F4E92
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 05:28:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229870AbiJED20 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 23:28:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229723AbiJED1U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 23:27:20 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2048.outbound.protection.outlook.com [40.107.93.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC75038B5;
        Tue,  4 Oct 2022 20:25:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FUVpAbkDVN4IreVchS+eUx1cBYyco6Hutl7neHXyGGVfkFem5tBrs3RAOUJEJT8wqs9jyhztBYob9/t9Xo9RV6j1VGSMvDEulWM3TwJxJaD7hae4cUxeqiNxRFtgbeabnP3qqyjRakFLigEeHAof5OiE0q+tJOc2tVpFiRlJQQN3zBz9h9+KkK5TCbh5NgkWAo5g2fFj3JN8qUpkfds5A9RZ1B2kLgQ0eiNlC9IBHI9QdxUXfysYLHJP2WDB1EZD4NkOcXrkkcoJjYB2Z0a7vRGfckpaykwtHz4+aVECHgAqa+ovZV9oHlPENZl02LZPIjhtyMvhT9RVqMe9PWdCMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7gT+10pDQC1w6Tn1sBgYEJpAeTubFKXdAduf8ubzbV8=;
 b=a/FsFjHNRGu0oRUth3ul+zlnbOX2BSScqj6BVllaxcLX+fR2E7X1a0Mi5M89SHH2K2qr10ypVG8KccUssEDvlOjfrEKz6eJrSBRHUpb5Negb0f5puoAyIrId9bkF+D/1MblbTBunFWLDkXXzHLwCcvT2ZLMjkYtkyRxOFF871Q6EoFR9hVjUA4J6wruZx8KkUNi3MDmFDkL807QTliY5A7xujlhbqbw+cr8ryMbfujGh6JNr43CVSKbs+ULmmP+fsRvbhuBeJUXntGomyrDpGFXJ7kLupVQ2eo9Wc7iTQmExnIjaEN3QkGdvz5EPhIBqSzhp7gLX/J9n6kag+v+WhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7gT+10pDQC1w6Tn1sBgYEJpAeTubFKXdAduf8ubzbV8=;
 b=OKEv6Bt72J3itoNcQrdY+zvtAZIXLrgqVXp9renFaH3jM7+y1R4FNlJRQT/zFXV1PvWvtonLed2ZBqKyQEUjZU4pio2DSTAKYun3lizRp/CBFQGfqjzL58QPn/oYvLId4vFx0A/4FfgbCKWh0y6dmIjUDPenqDjpHQl26uvQceSCIxJuBNqH7qe4YA1QRWMQKfxhL00Kx8mF4/GWu0nQxIPOq7ZMlObOmd8APFJqSG2jD/jPc+9uWk/oJpXdZckGkSdsJVDaxyNL0DrO+a58XX36Ab0Nix5DxuRWMln3/l3cGAktCER2ue+WxZ/dArOCOn/DXJ77Oyh7oiMa0lLGlA==
Received: from BN9PR03CA0454.namprd03.prod.outlook.com (2603:10b6:408:139::9)
 by DM6PR12MB4137.namprd12.prod.outlook.com (2603:10b6:5:218::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.24; Wed, 5 Oct
 2022 03:25:45 +0000
Received: from BN8NAM11FT086.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:139:cafe::34) by BN9PR03CA0454.outlook.office365.com
 (2603:10b6:408:139::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.24 via Frontend
 Transport; Wed, 5 Oct 2022 03:25:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN8NAM11FT086.mail.protection.outlook.com (10.13.176.220) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5709.10 via Frontend Transport; Wed, 5 Oct 2022 03:25:45 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Tue, 4 Oct 2022
 20:25:39 -0700
Received: from dev.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Tue, 4 Oct 2022
 20:25:36 -0700
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
Subject: [RFC PATCH 11/21] floppy: use lib tagset init helper
Date:   Tue, 4 Oct 2022 20:22:47 -0700
Message-ID: <20221005032257.80681-12-kch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN8NAM11FT086:EE_|DM6PR12MB4137:EE_
X-MS-Office365-Filtering-Correlation-Id: 34b57df4-117c-4e22-28c9-08daa6814a4f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: guM/R1/cRXzBKw3iPcsYx6a8B3EskUdDsmquewC+QvnCRhyD4rGzoT315bufk8BxayV7Kw6MxleXXs5wtKSR8MoPzoZ5V9pTv+irrZj0NdTabSwgs0MFZyGNfFS4EUEkS+++aeHudUWd05XY0f0PKO8NNePvgDsAIOk5AnklK8u3skPV1bo/y7i1ppiCn+yPW/aK+dnGqRl4Q65NKXS1I+pcpG+H+PN7GtjxL36xQqDWk5xxOViwwdJJLd/7se3qrZeyssPMdQNCXrKN5gaXof1htBtrTv5uu/UwEDx/caHGcxqVyI14iyj/qFMQzvE/xEc1xMNVSSeC83GHM2iUx3I+kpsZ5JVybb+776XngxgentFZPpkIH52CXz7Z423a5nn3A9cPngRTCJnhkOeLGkXcM/6be43+ctZSc2erD+qmy50konaqtfvZQ/iSWheiAGaCFOfmz8QC5jtL7iGZbOxhR+PLuwotG2ZA+P9U3r8i7r7Mzskn+qMh4aB0yLPuGKn95TLJZNccma6Y+J1jKqhS9EFbLq+M3YD9h7R4ITeRmWgaFM6J/DDhCirv5XlFViKTFL4sOA6xgwbmyq7R4Hhd2lfJWfyQld2WkWP2c9HG0RD82gr86SHzr/tlVFbtXIoUvyjkRly5Ga/2Lwc3MzrhHztKxQy1BOaNLoM1Hxnbcky3jL8uLc+phK2tCmmHCapzbtfKwS+tFATbmULrcw4KbJdtyst2IGnapyRuQnDziV3hSgt8GQV9VThqe+qfTE7cHg7lBaTNp6LD6lcLTGel+d/goNRpFLHi/OEFMK1lFOx2/BeHqelyinpt2M3ZEiYzUAOElPDP3gvHfegqnW+wVMe2xAfP/T/mtQvhUEI=
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(376002)(136003)(396003)(39860400002)(346002)(451199015)(46966006)(36840700001)(40470700004)(7636003)(921005)(40460700003)(186003)(356005)(82740400003)(40480700001)(8936002)(6666004)(82310400005)(7696005)(41300700001)(7416002)(4326008)(70206006)(70586007)(36756003)(7406005)(5660300002)(478600001)(7366002)(16526019)(26005)(110136005)(54906003)(316002)(8676002)(426003)(2616005)(1076003)(36860700001)(83380400001)(47076005)(336012)(2906002)(21314003)(83996005)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2022 03:25:45.2477
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 34b57df4-117c-4e22-28c9-08daa6814a4f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT086.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4137
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
 drivers/block/floppy.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/block/floppy.c b/drivers/block/floppy.c
index ccad3d7b3ddd..3a3260e6ac5c 100644
--- a/drivers/block/floppy.c
+++ b/drivers/block/floppy.c
@@ -4582,12 +4582,9 @@ static int __init do_floppy_init(void)
 
 	for (drive = 0; drive < N_DRIVE; drive++) {
 		memset(&tag_sets[drive], 0, sizeof(tag_sets[drive]));
-		tag_sets[drive].ops = &floppy_mq_ops;
-		tag_sets[drive].nr_hw_queues = 1;
+		blk_mq_init_tag_set(&tag_sets[drive], &floppy_mq_ops, 1, 2,
+				0, NUMA_NO_NODE, 0, BLK_MQ_F_SHOULD_MERGE, NULL);
 		tag_sets[drive].nr_maps = 1;
-		tag_sets[drive].queue_depth = 2;
-		tag_sets[drive].numa_node = NUMA_NO_NODE;
-		tag_sets[drive].flags = BLK_MQ_F_SHOULD_MERGE;
 		err = blk_mq_alloc_tag_set(&tag_sets[drive]);
 		if (err)
 			goto out_put_disk;
-- 
2.29.0

