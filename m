Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F17BC5F4E73
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 05:26:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229912AbiJED0q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 23:26:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbiJED0C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 23:26:02 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2062a.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e83::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3DBB12D06;
        Tue,  4 Oct 2022 20:25:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TPiqAZkAETcCrLJS+EYFp6t+y6gHMYPRg5Ql/Chv2fhgfCrEuFaFT59ZpvKk0KAX9FvLHZbd+bdCz1U+uo0z1MvG5q967SOEgoxpnHEXu3Zp0vCf0VsP3ZcI6prOaGtF7y9fbWlAD0QbqgCTLMrm+0xz6/L8laeNffOgIWlknlpdx+eWvvsUmpYuYyNCga5GXa4BLZzWrGxzNL77pnG45A16bX2yxfFDp/SZAWIXUqXyT7bdwCXTWgms8+rInFlpUfm7Qfts/fNCYu1rF4iigRuHbXb7S21aoNAyGW8BaGXQK8out7jD0XwVKmQFeIG8zPv+LML7eawSfnvhBB57xA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IIaJtCmyBtmwNvlfCfTaROuISj3wP2X90OGXdFQZG1s=;
 b=c8Z18CAdRVXB9IaWMD1lK100+6/W12Dr1jhyGiSWOUf5RM9dc29b1YAq6m1+R7x+FflOmE7NTa1uG0ZKlRJf8EqHu17A/8VhjlRjowXIcacVhGY4lLdnQsnvLHN0N8/G3Jdo8vLxVGxASH2o0P/5hYXmUqYF5gXrdwZmjguWEoTc+bUCQBOoqDr0A3f9WhqWzHNUSL+7M23sX6Gy7HHZ+4DKZdYhyGwYrgft+dMMcIkSeoHWLvhGDRMHKPPuIYh8xu0q3Eg5y9Dmw8aT+mTYYiBQochDNdZGQGBgbwyIaeaL7NJqoFru3R4CbSTlXqaY1z16gh9v4VBka3/e/3wgtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IIaJtCmyBtmwNvlfCfTaROuISj3wP2X90OGXdFQZG1s=;
 b=IRHoSE6o4UX4VfbaZlGmjrcRVVCmghJqX408MMBzfknQwh89EVQGRE9gf5PZVavNij6pfR6793L0NG+pWzvWsWOEpgsAUhq9Y5WtwNDW7BUEHscf6OU76suDq5ScpOIEZ7hEp+rb45pVmDheSVs+uvJRQjQXyu1Q09MMZ7Xb8bJBzK0T9MIwj6AgptnMqCYoSyP6DF6PZ/CTI+1/cti/Rv1u8Zr0tDzKigG4+gJIXVsyWFexhYm5ROePf2EEZgQ1rrxm6QycgFS4UEmwTPloV/KGjWRgUZl9QnOx/qfxmGdO8sO6biqVaa02xqRn1FwsCqHgB/8yVaxnFctdAddnYw==
Received: from BN1PR10CA0011.namprd10.prod.outlook.com (2603:10b6:408:e0::16)
 by MN2PR12MB4360.namprd12.prod.outlook.com (2603:10b6:208:266::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.28; Wed, 5 Oct
 2022 03:24:59 +0000
Received: from BN8NAM11FT107.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e0:cafe::57) by BN1PR10CA0011.outlook.office365.com
 (2603:10b6:408:e0::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.26 via Frontend
 Transport; Wed, 5 Oct 2022 03:24:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN8NAM11FT107.mail.protection.outlook.com (10.13.176.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5709.10 via Frontend Transport; Wed, 5 Oct 2022 03:24:59 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Tue, 4 Oct 2022
 20:24:58 -0700
Received: from dev.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Tue, 4 Oct 2022
 20:24:55 -0700
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
Subject: [RFC PATCH 08/21] scsi: use lib tagset init helper
Date:   Tue, 4 Oct 2022 20:22:44 -0700
Message-ID: <20221005032257.80681-9-kch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN8NAM11FT107:EE_|MN2PR12MB4360:EE_
X-MS-Office365-Filtering-Correlation-Id: 2abf6aa3-a07f-4b92-c659-08daa6812ef5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lO7XEwWXA1z04/6uQNT2ClHlA130jYGz/M9PpTeM3PWZNymRpv9Ccm+e3zypkzSBUDKuCw5avmnkgxh+iFOtpnTkAPA/Fl/2uOYOSnoaWlg1Zef/N+TOI9JbAVCYHm2LPBKEMGEW+QzZtFgHgMx6dt4j6iybU0Bd7b3qqMZma8zHUcu6YX9nD0nxhFo/K9kbjxJww0Uo7Q3hGVmXpLo1uv5YiAJ/GMFD/yNdM+4k+BPnEXqDz4p2aSFHyxHYnPCHimpyfOy0JDvEyAsX8mewzPJOf1mtUBSTDdMRolyMsA9q4Ua3RVStN9ePhVS4ZiY+exR47w7bFqg42JT6cL4HYbnj2hQ9PoLY2zf9K6sqNPFv3LdtJG3q6uau3swhAFw7S0tpg83ZkrRXY5auTP0gvvk75AW0aKFB/ynmM65aOIYAGrH1WDGDOa13KwJL8wEyLAT5sz9DwBStrtvFUueUZcH+5HQP+n/mpkFZ5jdlvFFXOpQkBVLZTiibIixSQw+x2QzSM3zcES9gENk9at+fO+h5nrzxwCmJ/sTyDiDX9W7w4NBq9eCDrG8pAK6BGQHhpiBRNG8aE9CYy6bVTDk7oeOaXf4GG7Vx8Wct9c0ahXeT6Xb/cSTWeOTWBJkIM4vxkCEr4RuClZIZmPQsa7EILNHEIy+ClheydPS4N+kTd3dcktO6QE70uHZbpAwIIlS9ZJqkSwQDJdhE8u9ISs+vHLOCfpE7GTWLW28atyr63OGzE1iAegnqc9+CAhQVl4mzmxDtHo6gviJSL/Bd/wbbB6ru1eNpSZeOjnstE2Fsn3fMscjdhpucXxeuzecGeBxbKWWSSZCc8DiEzEhXVcXw2msH283OzzydmdZvc8zj9Cg=
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(376002)(39860400002)(136003)(346002)(396003)(451199015)(40470700004)(46966006)(36840700001)(16526019)(36756003)(47076005)(7636003)(921005)(36860700001)(7696005)(82740400003)(356005)(26005)(336012)(2906002)(82310400005)(110136005)(7406005)(7416002)(70206006)(83380400001)(8676002)(70586007)(5660300002)(7366002)(8936002)(426003)(4326008)(40480700001)(186003)(41300700001)(2616005)(1076003)(6666004)(478600001)(40460700003)(316002)(54906003)(21314003)(83996005)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2022 03:24:59.3635
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2abf6aa3-a07f-4b92-c659-08daa6812ef5
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT107.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4360
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        SPF_HELO_PASS,SPF_NONE autolearn=no autolearn_force=no version=3.4.6
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
 drivers/scsi/scsi_lib.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
index d7ec4ab2b111..121f292ba0d8 100644
--- a/drivers/scsi/scsi_lib.c
+++ b/drivers/scsi/scsi_lib.c
@@ -1955,6 +1955,8 @@ int scsi_mq_setup_tags(struct Scsi_Host *shost)
 {
 	unsigned int cmd_size, sgl_size;
 	struct blk_mq_tag_set *tag_set = &shost->tag_set;
+	unsigned int flags = BLK_MQ_F_SHOULD_MERGE |
+		BLK_ALLOC_POLICY_TO_MQ_FLAG(shost->hostt->tag_alloc_policy);
 
 	sgl_size = max_t(unsigned int, sizeof(struct scatterlist),
 				scsi_mq_inline_sgl_size(shost));
@@ -1964,19 +1966,14 @@ int scsi_mq_setup_tags(struct Scsi_Host *shost)
 			sizeof(struct scatterlist) * SCSI_INLINE_PROT_SG_CNT;
 
 	memset(tag_set, 0, sizeof(*tag_set));
+	blk_mq_init_tag_set(tag_set, NULL, shost->nr_hw_queues ? : 1,
+			shost->can_queue, cmd_size, dev_to_node(shost->dma_dev),
+			0, flags, shost);
 	if (shost->hostt->commit_rqs)
 		tag_set->ops = &scsi_mq_ops;
 	else
 		tag_set->ops = &scsi_mq_ops_no_commit;
-	tag_set->nr_hw_queues = shost->nr_hw_queues ? : 1;
 	tag_set->nr_maps = shost->nr_maps ? : 1;
-	tag_set->queue_depth = shost->can_queue;
-	tag_set->cmd_size = cmd_size;
-	tag_set->numa_node = dev_to_node(shost->dma_dev);
-	tag_set->flags = BLK_MQ_F_SHOULD_MERGE;
-	tag_set->flags |=
-		BLK_ALLOC_POLICY_TO_MQ_FLAG(shost->hostt->tag_alloc_policy);
-	tag_set->driver_data = shost;
 	if (shost->host_tagset)
 		tag_set->flags |= BLK_MQ_F_TAG_HCTX_SHARED;
 
-- 
2.29.0

