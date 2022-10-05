Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D83385F4E2C
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 05:23:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229774AbiJEDXq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 23:23:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229823AbiJEDXe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 23:23:34 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2041.outbound.protection.outlook.com [40.107.237.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1538726A7;
        Tue,  4 Oct 2022 20:23:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nbglDdDAmY6J90uXPtILOSouk8IdP/M07tZi979tt6d8gCw6mhOj2rPMOUIagshu+UHdesvfgRF45LdWV1gBgX2T1NyqffZesXP3I+1eGqvZ/obd0Jk1w+Wc9dyKDEPOm1nNmFmHUcBwQeXTAuBKfFSjQKgFjM4azrSHSRv8GWtymtr56pu5gRBJnOwwO3Sd6AFGCn3e6alZMyOxGAvyFDdHV2HtdqhvDTTKH5sT0G2LJFjCUiz44l/krQ54hGSh2JiGIv6lM7whxZ2ufHr0wF/nxJN1keAnvR/EZTFLrNOAtlGeSm8aiWAmD3ltmf48Uf3R8mtzeE/+DOkJeq0/1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z4qlNjHi3JY0sOhIfgnmcxhWd4Fx6Ycmkfd/Klj+n2s=;
 b=ZrgilvyjaiBktRF2FiwFf/tyvDQF3GtqQuCSwBG1HGchFw2NUJfHTB07puMjpjJFPdYifGUoZCld6txEtAxupMrhkecNykoaJxAt5R2Hhf11yE/JfWidkGvoXBtRMez0lnaBhGq65ePaNcxv/Xi73DuGdxZVKJZrk2vlpY0TMhL7YEFvdFAPjsEjfl2wAI0f0vE1zCyDt/Ka6OxFIp68EpB6y52p2F4VdZWt3ZvLRN4GPMXP2ft0YmMuSJkhkJbeSDMXylLWO2yrqkJzEFR2L+gCM68YrUFgjABckFNguQa+lUAXGNSdtZ/8SKV4Rv4iDPeUDnFBHQfYJPdb6DTGhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z4qlNjHi3JY0sOhIfgnmcxhWd4Fx6Ycmkfd/Klj+n2s=;
 b=WIeOhnvRfHhYxvIVBVoW/XosBKfTmfyda9YPdX1Wss1uRnin1yGp/jDSSOf+03XdSSxJKkZuvrWklcoqBzS6peIuIkK0qEHG+jIxnPi3BG2dyEyCzhUEhSTMz7Arf4rrNSACPfbbf8Y3lZ85Ijzr6tjKMzbnNWxzlpsXx2gDCS6evf6qvh5XUaBhXiIPRlgkITIzVbN5wCIOuwq9a53l6eLcKGBUY/p/P6TLStu7Bcz9uIB18+YXzjXOghl9tvoKaRGaVEA4o6wAlyZ8MAggaRsGbmn5b6edHpfWQAv7zNm7VZDpH+1OVrBhNr64ByaV8oJ4pY+wafZbttVgf+xigQ==
Received: from BN8PR04CA0037.namprd04.prod.outlook.com (2603:10b6:408:d4::11)
 by DM4PR12MB5916.namprd12.prod.outlook.com (2603:10b6:8:69::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.28; Wed, 5 Oct
 2022 03:23:24 +0000
Received: from BN8NAM11FT030.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:d4:cafe::65) by BN8PR04CA0037.outlook.office365.com
 (2603:10b6:408:d4::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.26 via Frontend
 Transport; Wed, 5 Oct 2022 03:23:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN8NAM11FT030.mail.protection.outlook.com (10.13.177.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5709.10 via Frontend Transport; Wed, 5 Oct 2022 03:23:23 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Tue, 4 Oct 2022
 20:23:22 -0700
Received: from dev.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Tue, 4 Oct 2022
 20:23:19 -0700
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
Subject: [RFC PATCH 01/21] block: add and use init tagset helper
Date:   Tue, 4 Oct 2022 20:22:37 -0700
Message-ID: <20221005032257.80681-2-kch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN8NAM11FT030:EE_|DM4PR12MB5916:EE_
X-MS-Office365-Filtering-Correlation-Id: 550229cf-3ca7-4a46-32ba-08daa680f5e4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TCBU5hYTks2cz4q+8GY5aqi1NxVCX4sK/xLIvlsir3K0NBWSc80Z6hInbNhIrawuc5X+MzftYJPzZyE1RWgQsc+GNT1puaDegzjT/VBKdWYv8vtXZFoomd3knJMXPlUOyjt9yjWkRMTjQaJVIXmCeRPT7oJpyMnmTHt388aqeX5PmLe8hoQwYWLHX/VnixHIo3/xJtWdWJaDu7AZmyPJ07wNEHLIgfA900meOadPqEo1Vozy3Xfrt1F+FMgtuG9fp1pDlTNLqfoOrWwM1Pi828uK/pd+j5YDGG7/XP15znfexE0LZPANMptN5T3FpszNVAi0zvFeMZ5XVRm4Gkl2BxaPP8sLSuf4Y8Ck4yWvtW9L1L7UGjDztzf1wzlKedwbyERtKopLlwH8vY/vfcYiAplQRf+o+pi+3sBsuFl7asG380/568iNZ49VpsjP/YNmpSu7XGl60BIPXtaZdOhhtoL2RKLv1XNLqHZahfAMePzqzhSVct+hsr5qwDkdjVIojwz7FogMKTJ5FEVHoiqP4slSif3r0pTd5vQDosK2aIBdO9GNA1db2+3dtYH8unQE8Ccz8b3Fhq3C3Vrek767MkT3VZs4TI+ZI+DM7z95ffde1TPJtwlZUMie6FcV4QEhTs8xHs2M4F7+X2ufz0EqaISCa+cqWPQeC43u2hlqn4wLQNtvjPrIkWKdyPcIkyNIBninDfIKILsKuu3KNU9/XGihbCVvkdLNVtGaWcqh9+vCNnTR08eleAwPhtLF96fkQSgMkzEdmhLPTy8Eu44DHUK5FJZzDPjyrkWYSRPBAXuzvTpnb2cWWTRbdvhzx/oELN9hNwR0gb4gTMVWfvl8IPWBhSNiH2DrZ7s3CX+AJqI=
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(396003)(136003)(346002)(376002)(39860400002)(451199015)(46966006)(40470700004)(36840700001)(6666004)(54906003)(2616005)(82740400003)(70586007)(8676002)(70206006)(316002)(7696005)(36756003)(478600001)(40480700001)(110136005)(47076005)(82310400005)(4326008)(26005)(356005)(83380400001)(336012)(186003)(16526019)(1076003)(36860700001)(7636003)(426003)(40460700003)(921005)(5660300002)(7406005)(7416002)(41300700001)(7366002)(8936002)(2906002)(21314003)(83996005)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2022 03:23:23.6181
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 550229cf-3ca7-4a46-32ba-08daa680f5e4
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT030.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5916
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add and use the helper to initialize the common fields of the tag_set
such as blk_mq_ops, number of h/w queues, queue depth, command size,
numa_node, timeout, BLK_MQ_F_XXX flags, driver data. This initialization
is spread all over the block drivers. This avoids the code repetation of
the inialization code of the tag set in current block drivers and any
future ones.

Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
---
 block/blk-mq.c                | 20 ++++++++++++++++++++
 drivers/block/null_blk/main.c | 10 +++-------
 include/linux/blk-mq.h        |  5 +++++
 3 files changed, 28 insertions(+), 7 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 8070b6c10e8d..e3a8dd81bbe2 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -4341,6 +4341,26 @@ static int blk_mq_alloc_tag_set_tags(struct blk_mq_tag_set *set,
 	return blk_mq_realloc_tag_set_tags(set, 0, new_nr_hw_queues);
 }
 
+void blk_mq_init_tag_set(struct blk_mq_tag_set *set,
+		const struct blk_mq_ops *ops, unsigned int nr_hw_queues,
+		unsigned int queue_depth, unsigned int cmd_size, int numa_node,
+		unsigned int timeout, unsigned int flags, void *driver_data)
+{
+	if (!set)
+		return;
+
+	set->ops = ops;
+	set->nr_hw_queues = nr_hw_queues;
+	set->queue_depth = queue_depth;
+	set->cmd_size = cmd_size;
+	set->numa_node = numa_node;
+	set->timeout = timeout;
+	set->flags = flags;
+	set->driver_data = driver_data;
+}
+
+EXPORT_SYMBOL_GPL(blk_mq_init_tag_set);
+
 /*
  * Alloc a tag set to be associated with one or more request queues.
  * May fail with EINVAL for various error conditions. May adjust the
diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
index 1f154f92f4c2..0b07aab980c4 100644
--- a/drivers/block/null_blk/main.c
+++ b/drivers/block/null_blk/main.c
@@ -1926,13 +1926,9 @@ static int null_init_tag_set(struct nullb *nullb, struct blk_mq_tag_set *set)
 			flags |= BLK_MQ_F_BLOCKING;
 	}
 
-	set->ops = &null_mq_ops;
-	set->cmd_size	= sizeof(struct nullb_cmd);
-	set->flags = flags;
-	set->driver_data = nullb;
-	set->nr_hw_queues = hw_queues;
-	set->queue_depth = queue_depth;
-	set->numa_node = numa_node;
+	blk_mq_init_tag_set(set, &null_mq_ops, hw_queues, queue_depth,
+			sizeof(struct nullb_cmd), numa_node, 0, flags, nullb);
+
 	if (poll_queues) {
 		set->nr_hw_queues += poll_queues;
 		set->nr_maps = 3;
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index ba18e9bdb799..06087a8e4398 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -708,6 +708,11 @@ int blk_mq_init_allocated_queue(struct blk_mq_tag_set *set,
 		struct request_queue *q);
 void blk_mq_destroy_queue(struct request_queue *);
 
+
+void blk_mq_init_tag_set(struct blk_mq_tag_set *set,
+		const struct blk_mq_ops *ops, unsigned int nr_hw_queues,
+		unsigned int queue_depth, unsigned int cmd_size, int numa_node,
+		unsigned int timeout, unsigned int flags, void *driver_data);
 int blk_mq_alloc_tag_set(struct blk_mq_tag_set *set);
 int blk_mq_alloc_sq_tag_set(struct blk_mq_tag_set *set,
 		const struct blk_mq_ops *ops, unsigned int queue_depth,
-- 
2.29.0

