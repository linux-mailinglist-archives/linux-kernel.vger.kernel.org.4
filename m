Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C33A05F4E40
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 05:24:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229885AbiJEDY3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 23:24:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229835AbiJEDYJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 23:24:09 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2046.outbound.protection.outlook.com [40.107.244.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68EBC72B70;
        Tue,  4 Oct 2022 20:23:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MyKT57hUL6ItsdcF1TrnBHmaqoFPWb8Hx6FfQbvb2FqeEnkuG/SPa0Pn2jMjZr/9XgtzjpJY/oLEIJRL6ndCMWx3PikpYbAvST5Ir9riioIB67Fe2ueuUdGNaD6LGc3ExTXGf79QPenZLM9FRCNvA5rp2/THbuqFiOrHSB9sAdsa47JXQtJIFzP6rl4l5+7JjCiui5ikUjwHBlhpfkPh3mCRvzeWa0QLH6UShvtoTr38HjTrUd44O63aTZpOpAajiBJqN7KixM9NLnrrzvqMvLgtE0GRMm7JrYpelw0AHXDQGXp6Oz/wm0qcDd4CB6VqkR4GaZT6cqR03sMNOq3BVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hiHRxXlu1J1E3jUYjrj4eJw9ZFg+tt2MKuM9A19wDFw=;
 b=KsJ7iHWhFP4B4HNDKzyGpHRGy3qL0hE1Z661+giqKyc6IaUTc5FXmF7aBARJnV3tQE7/Iy4ZhajIFx4SwduvjGQPM8YiEMv47pLelJ4r3DR4+ZbOMAjCT3gmgd9HUDDDxj7W44RfIB7kqjzJdXMaFGbbq2+wvHCO+g81eM47j+OCPXe0seTXjWwc7NpvG1/gDcWREShhNapSBmefI4ezSnZBxbyBV7IGuT+UVffzSPrGia7JdVxYw8gChwmNalrdTp+qMIAW9hDyfsI0TI2RbwONT4sDa3dBhaOCPmMl4GuDIAUr2d5M01sT+nYWfM9IKmBm0uNIZo/vEShsPTvqJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hiHRxXlu1J1E3jUYjrj4eJw9ZFg+tt2MKuM9A19wDFw=;
 b=DoYVtEw791EmsMdOG1OWHDqQg6qEQFrq2dzrnGsMcUfAjqvfAaE/QfUVZ1RlzvhQg7jMCwrnNJN8+KNLf58HkzzL49UUMdEehLOY6G4FouXH3oNT2ST/d2hT7CgpT4ojjWwpEb6HbDzkTtUf+JaU+x+XpGMudiOzMtg5VVtiCOSgnXaWx8/83znXOZCheygju+qros+hVQLz8h9Ejt4ufD941z2MrWCWbU1KY7bGFm8fJmZWrGrjTrdyaHhvF9dpBEAoyglok6NZdOLIvAXrG6HasK2Hd2PVfbRbXAlDI5NboUkLz59kt2eV9mAKXRz380MshI8ScM2AX5VO6bY4Gw==
Received: from BN1PR10CA0002.namprd10.prod.outlook.com (2603:10b6:408:e0::7)
 by BL1PR12MB5096.namprd12.prod.outlook.com (2603:10b6:208:316::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.24; Wed, 5 Oct
 2022 03:23:52 +0000
Received: from BN8NAM11FT107.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e0:cafe::2f) by BN1PR10CA0002.outlook.office365.com
 (2603:10b6:408:e0::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.24 via Frontend
 Transport; Wed, 5 Oct 2022 03:23:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN8NAM11FT107.mail.protection.outlook.com (10.13.176.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5709.10 via Frontend Transport; Wed, 5 Oct 2022 03:23:51 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Tue, 4 Oct 2022
 20:23:50 -0700
Received: from dev.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Tue, 4 Oct 2022
 20:23:47 -0700
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
Subject: [RFC PATCH 03/21] nbd: use lib tagset init helper
Date:   Tue, 4 Oct 2022 20:22:39 -0700
Message-ID: <20221005032257.80681-4-kch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN8NAM11FT107:EE_|BL1PR12MB5096:EE_
X-MS-Office365-Filtering-Correlation-Id: 785fbad4-5890-4cdc-8a27-08daa68106ba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: k2vi/KkKbm/nmuZraHEIir02mBSVgMOszxQbXhXuWKCY2Kq4MchHGd6/uqRbaZAVmtVtFBJ43pwLICzBWt+ggwkC+MVj4y4B1haU3rA+fNvruNt2pmxq2gRBj9CpyiGbhpeRL19OJgpQlv+ufyig6kchSEXWO/J3IbSphyG4n14sntJJVekNz1c4uKy6XcjeDSyPb/KVNWuf/lLZNppiBNZVdcfkW/tV6DGkBcTp45+n2MB9mLYWZkGtz0f+KkIbhRIN8YYE3ABlIvA0sCigaYPBZlUKjFZl3tpKnXAEt6WUIdWLHPvtt1PVIImN1M1Z2BU8rDiB31GzqvrS3VIxA8h+6xSB9+feKnTtVSpGwAIrOd4yrGUOeM02eYTOI85oBoDFGbNNEVIPhzEA9vXdSblhrb5Pp2IHDWKPe96QSTK+ngs3jqU7tPab8ZXWEniNFYvSlH70ViUouxZYcX47oxZfuHybfw12K6Ft7sLk1Mtkaz4Z3Bc3gWjLVaAYUn5iun9iBMRIlJebTH562bzpl7q/03eQucHtblOPNvi58uTK89m7bqh/xPzDEiarzir6JocaMl9fqSTOchduvBCt23Ya7bKOv+WMRxZxEKw3/g8AVv5mKj5/jTby2mAEI/NR1l0Sm7sEZSVYck2aCalcUEIFXpC2SPtDkCRA/vwV4e0O34pdRZzDP9T0lj49XMIcRdVL7n1yaFjKqvoLhh+WMTd0L8zAsPkxH/3Y2dAYnu6jvjSss+BeI6RggjqS8J2ugN5wEsg60vlkBJNgLgu8K+EvKn629oLUy0ckTvQ+Xe0wQbbIxwgjvWDB+rAT8W17X5teSkOcWKXNq/p2xkCk5rDKQW0MvM9ZoMZRzGg8yfQ=
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(396003)(346002)(39860400002)(376002)(136003)(451199015)(46966006)(36840700001)(40470700004)(40480700001)(36860700001)(478600001)(110136005)(54906003)(316002)(8936002)(7636003)(5660300002)(70586007)(70206006)(186003)(82740400003)(7406005)(356005)(26005)(36756003)(83380400001)(7366002)(921005)(7416002)(8676002)(82310400005)(41300700001)(1076003)(2616005)(7696005)(2906002)(336012)(6666004)(4326008)(47076005)(16526019)(426003)(40460700003)(21314003)(83996005)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2022 03:23:51.8664
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 785fbad4-5890-4cdc-8a27-08daa68106ba
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT107.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5096
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
 drivers/block/nbd.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index 2a2a1d996a57..01be68d1f722 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -1749,14 +1749,9 @@ static struct nbd_device *nbd_dev_add(int index, unsigned int refs)
 	if (!nbd)
 		goto out;
 
-	nbd->tag_set.ops = &nbd_mq_ops;
-	nbd->tag_set.nr_hw_queues = 1;
-	nbd->tag_set.queue_depth = 128;
-	nbd->tag_set.numa_node = NUMA_NO_NODE;
-	nbd->tag_set.cmd_size = sizeof(struct nbd_cmd);
-	nbd->tag_set.flags = BLK_MQ_F_SHOULD_MERGE |
-		BLK_MQ_F_BLOCKING;
-	nbd->tag_set.driver_data = nbd;
+	blk_mq_init_tag_set(&nbd->tag_set, &nbd_mq_ops, 1, 128,
+			sizeof(struct nbd_cmd), NUMA_NO_NODE, 0,
+			BLK_MQ_F_SHOULD_MERGE | BLK_MQ_F_BLOCKING, nbd);
 	INIT_WORK(&nbd->remove_work, nbd_dev_remove_work);
 	nbd->backend = NULL;
 
-- 
2.29.0

