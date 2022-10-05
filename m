Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D9F95F4ED6
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 05:31:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230166AbiJEDbw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 23:31:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230133AbiJEDbA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 23:31:00 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2062.outbound.protection.outlook.com [40.107.244.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 094A7753BB;
        Tue,  4 Oct 2022 20:28:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QUCQ4Xnn4sD2QyrY2Vu5wJroCqd9EU4zgDNbpMr0Mwo7Vze2D/iv0a/VnhfqEoxUdsIPiguIfRI90ZZrX23jx0CjTgu/ViILtfUUERQD02Bbaa7c2KvADedUNADds6QMX84HlMiikoq8hwyQ5tXOA1kO9OVM9+/9Z1RmZvbO05HCTCoNvT1BN1fyy+sU61Vmn7A+qLolciG/LfnSgvAf0+FHWD7JPGdNhTNVmySf0P59kvlexZYPcu1yTAx+nNwb7MNew94/Jix+NQezjFwxbv/uBPPQ2a1oBdojAClKFJoXFaXpX1W9qORWzuKed7TpqFWD36lC2NeNdp5NI+2uGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tb/wwQvNf07yDtPUDm64uX8WlaDt++cz8quN/6R8z6Q=;
 b=TBKRyr1GlHxLinAffXtr6Qtlxx9pY03LFj/D9zpTffzsi3lhz+c5+ZWouNOVa1NAXJYB2CBLT6PoY4uPf4mFLsolpXa/VMkeISLVwvaqXP3Wj/aynRhrTP6jb6iGDNnpKsOKdFLsGm0FkUueXyyvFgJ/FDnmsrtWnevQYqBUDU6B5v0xHAxIo68ajMu/v/UkWt5Wqf0o9e1WuLYRfT9YjE9xOD1TL8TDBjhKNoM24QD86mlhpTFCt4ootcaRUaI/IQS9+JxUHkhJLEeFPOkE1D1tpR130i+9GyFCdY9t5UVGQdvoWqVzxM8cvtcpxQFfZRn2y2QwYZQBBa6epbfP6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tb/wwQvNf07yDtPUDm64uX8WlaDt++cz8quN/6R8z6Q=;
 b=Pi3gJ1rLN1Gv18HTXxXeJ1WFNR0+Yk/lC6W5FGNI49UDqhB0do8TENxR36hbluBiMmjkUnBCxKK7xFTKEf0t5kaAJPgjWNheX6zGJCugBxbvB1Xi41UGRYju4VtFYLWFsEXNrZXKnmVrNqpwc85z/F3OacUdmsVPoPQ6UUL0WI9pZpVjnbUmRAoJBldmb8LKmiWw7Rapeyd4yZL6B1ey6vX9qax/zItoJi5K0s9zg3xiLVDac0Zqv77ICBOgHr57TRT+XfF34kdp9vvxzBIq7VWek36SN8Cv8WkvZaucll5p2hwdcFbltkYvTeTmrTM+sn/ywZc/WeIbRoq6zsqunA==
Received: from BN8PR07CA0018.namprd07.prod.outlook.com (2603:10b6:408:ac::31)
 by BY5PR12MB4196.namprd12.prod.outlook.com (2603:10b6:a03:205::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.28; Wed, 5 Oct
 2022 03:27:40 +0000
Received: from BN8NAM11FT105.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ac:cafe::81) by BN8PR07CA0018.outlook.office365.com
 (2603:10b6:408:ac::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.24 via Frontend
 Transport; Wed, 5 Oct 2022 03:27:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN8NAM11FT105.mail.protection.outlook.com (10.13.176.183) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5709.10 via Frontend Transport; Wed, 5 Oct 2022 03:27:39 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Tue, 4 Oct 2022
 20:27:27 -0700
Received: from dev.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Tue, 4 Oct 2022
 20:27:24 -0700
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
Subject: [RFC PATCH 19/21] nvme-core: use lib tagset init helper for adminq
Date:   Tue, 4 Oct 2022 20:22:55 -0700
Message-ID: <20221005032257.80681-20-kch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN8NAM11FT105:EE_|BY5PR12MB4196:EE_
X-MS-Office365-Filtering-Correlation-Id: db4832a3-7c98-439d-1e96-08daa6818e5d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: a0B4uVwG6AnIzPBsM6zm98BEgwW+kRuL9A00MlfmYAjd2HFWunBR0YUFWplrJix0G5AM6qYXWfMRn4/jve1yCalT/ZwcZeiE75RCBFHatt7bZbH2kGNgzQ3oxE4Pykp+apDXjeGcnGd2t1bnSVAmMKvVtTdCELq+eD/ia8nP9N/KWHIqF/VTZdyrpVhtoEvDnyQgi9t5O3Ojupo0Y6whGwaY28zB+PMhfCjsqQIKbGFprknHNW4iFvnyr/QMMF3LxLtJybTNUFF0Dea6NYN2YTNnyZwVSbPye+kI6QxFZL+w1ifqFHTwB1yFt+vEEOfinPkvk5Ii1dIo2NsCowSDZ5Q93aALP07RhB8v4tmyMZC7ojFQ2338UxzGh6RvSSi2nORyPgKD/UScIAZc3FcjFJxwAr7Vmg72ge+F8aAjRUKKoJujHOSknsGq3SUtI7mJqiQGYGM2kAz4dIM3P29bsUosNLsm81RhZOZwV/BO6PC31iR+NAJZJlCLe8FxZp84cwrlJlZbBFYKqwT0OgqECRS7Y94vj2vSEErp3Rdoo9Ydpn5Q6fioNehqzJG1oxw7AVH99DkLeHYpTbBLaHbclC/WX04VArPVY56cJ2uEAu1su1jDkN4r3JL6qMJw7cfrdaW4TuPhLZ3kxqJI7kuQC/xeTUNIxnIe3O5YSkZ4hBoQWiEn40gjBjT6QTAP2sqegZm7e5vZQFXGdjDYMQdITGLtJ+7uc6kL872DjNP1CWHAkdbjEqNdL1vPBO003/T/4D0HC8nOhy8Y/DF8htwj1zOLyTKSDoF4+R3+m3ZikvMsf8Tzy93e41hxLI4EzVKrrehO3wFKfQ+zmUDa/MCtnedsck9x84j07oG1AuO2NhY=
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(396003)(39860400002)(346002)(136003)(376002)(451199015)(40470700004)(36840700001)(46966006)(8936002)(1076003)(7366002)(7406005)(7416002)(5660300002)(82310400005)(336012)(83380400001)(426003)(2616005)(186003)(16526019)(47076005)(40480700001)(4326008)(8676002)(6666004)(26005)(36756003)(7696005)(70206006)(36860700001)(41300700001)(70586007)(478600001)(7636003)(921005)(356005)(40460700003)(82740400003)(54906003)(316002)(2906002)(110136005)(21314003)(83996005)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2022 03:27:39.4243
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: db4832a3-7c98-439d-1e96-08daa6818e5d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT105.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4196
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
 drivers/nvme/host/core.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 639767759c41..69789c2c1ba1 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -4814,16 +4814,10 @@ int nvme_alloc_admin_tag_set(struct nvme_ctrl *ctrl, struct blk_mq_tag_set *set,
 	int ret;
 
 	memset(set, 0, sizeof(*set));
-	set->ops = ops;
-	set->queue_depth = NVME_AQ_MQ_TAG_DEPTH;
 	if (ctrl->ops->flags & NVME_F_FABRICS)
 		set->reserved_tags = NVMF_RESERVED_TAGS;
-	set->numa_node = ctrl->numa_node;
-	set->flags = flags;
-	set->cmd_size = cmd_size;
-	set->driver_data = ctrl;
-	set->nr_hw_queues = 1;
-	set->timeout = NVME_ADMIN_TIMEOUT;
+	blk_mq_init_tag_set(set, ops, 1, NVME_AQ_MQ_TAG_DEPTH, cmd_size,
+			ctrl->numa_node, NVME_ADMIN_TIMEOUT, flags, ctrl);
 	ret = blk_mq_alloc_tag_set(set);
 	if (ret)
 		return ret;
-- 
2.29.0

