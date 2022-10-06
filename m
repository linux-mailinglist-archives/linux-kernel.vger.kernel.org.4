Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F8485F5F87
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 05:21:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230230AbiJFDVa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 23:21:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230167AbiJFDUY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 23:20:24 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2048.outbound.protection.outlook.com [40.107.237.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52B302AE23;
        Wed,  5 Oct 2022 20:20:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lBjz67kQWIHllXfgfdCybLerehTkGbwr/PrqXPRpGaTxFzkCUnqfd/St0iWt1UViLG/vUQp55le2u4Exk2S51hYRUwJA0eWlkhpSJb+BqbhIMMijRt7bpyeRq7HIa2slOH0GfFERTsjrKRMbqlNhc3WH2XmKpk+HGd8jEDQnkDObce0IrtQn6yIt8QW0/znipDKAVbyS1phCg3rXToqHb9wEjeBP1/XEEodKQM9r+RqvN1rFLgVs/7/AlMLv2z51hf2MwNmcgysKAhsF8TDCRlpUrY19kWvH89EkiSY5xCiqPtnLj3JSY3FPz0EBICIMGxEVn5ZAwPplaIhTW8sFWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AIe4mKOyn70BXMu9ewRDR6BaGZiCjfn7IR9cPrqCt9M=;
 b=aFVy1/ld0MXgw+oE1K9nLlfO29EK9HG7qOWDWSGBJHxX/bfJNPIqCZhSPcRcYu9CeIxko7F1INbShIYdYitFOPbNKKrn3iSvC38STJKiTwQ5fb7NkpcORj7Ol3Fu/DRHaAkbHn62Nl/7xYecCPXQp+wupixO743jfJgULxB11BB7YfunhpFPQ79E4XeCzfYaMap1uSpJ3UbbHXAdlAOeSoxs4pxtGy9e5fsA1nlcTpgppG68rlOgSgvj01CScCtPVNvh8FAroN/yJ7MeyuYKHZhNUjswsXJ88R2jO8o5tuq2MhUduAX2MLZbq3PSiPK86dr3suQ8fTfvQ9Wxo643Gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AIe4mKOyn70BXMu9ewRDR6BaGZiCjfn7IR9cPrqCt9M=;
 b=lmDEtdU2bvNHkP+gGSrh8jAAvMAZaOfAmfE47NS0VAIOrRaSETdA1NUviuBTFS0YRBkKWF8gyDLpeCpjRE6KtrNkNYIiEjlkMNIsYBqNAzHecaHokdbDhOo11DhnDqCQe+WB6RkP3uCw3tJlCx1ciDBbOiBcDfKcfVP9qWHveej2I5+c7Ckw2NAEIL1Iw9RIIoiPVsOzfR60+mYJdgrhLkmIQVYWEzt+4kk0PotVPcVr8hAW7+uZKqHQtcpcfC+K6LCskPvfVxlxg54QvMJ8ueM+54tFcxYgJPoKMSeeIZdlDrugq9dj2be9dYtqO64Pa0N6tC2B5JcKzDeV5BImFQ==
Received: from BN8PR15CA0048.namprd15.prod.outlook.com (2603:10b6:408:80::25)
 by PH7PR12MB6609.namprd12.prod.outlook.com (2603:10b6:510:213::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.31; Thu, 6 Oct
 2022 03:19:59 +0000
Received: from BN8NAM11FT092.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:80:cafe::4c) by BN8PR15CA0048.outlook.office365.com
 (2603:10b6:408:80::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.31 via Frontend
 Transport; Thu, 6 Oct 2022 03:19:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN8NAM11FT092.mail.protection.outlook.com (10.13.176.180) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5709.10 via Frontend Transport; Thu, 6 Oct 2022 03:19:58 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Wed, 5 Oct 2022
 20:19:49 -0700
Received: from dev.nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Wed, 5 Oct 2022
 20:19:48 -0700
From:   Chaitanya Kulkarni <kch@nvidia.com>
To:     <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <axboe@kernel.dk>, <kch@nvidia.com>,
        <damien.lemoal@opensource.wdc.com>, <johannes.thumshirn@wdc.com>,
        <bvanassche@acm.org>, <ming.lei@redhat.com>,
        <shinichiro.kawasaki@wdc.com>, <vincent.fu@samsung.com>,
        <yukuai3@huawei.com>
Subject: [PATCH V2 6/7] null_blk: add param to set max disacrd sectors
Date:   Wed, 5 Oct 2022 20:18:28 -0700
Message-ID: <20221006031829.37741-7-kch@nvidia.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20221006031829.37741-1-kch@nvidia.com>
References: <20221006031829.37741-1-kch@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT092:EE_|PH7PR12MB6609:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e4c1c3a-cb2c-46ff-2477-08daa749a634
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jlh+nN4bNYy4zJ27/mK9iu/QoqElfMPj2xkye2EdHa6yifHVIWjbsQtKfZCWy2FNlmt4FTo8J+RM2BaIX6NrxITNFWr+iTpITuDRvlG8MFEYebtDeK/tIuXMp/z6ndp5znQVZLZSi2j5bAcvvOoXt4qvfnD5bvD2X8/HRV5Pu3he/LxiGuBsflpx+/cp+LkwdAORm5AggndaTgGWcw/SwmBtZbh12cG5N7jg66eMIDGZ8B/FkzXsCg3VfNPKhIlSt5LArOXeW4UfssecYQjMC5iSjhPk5PXOh7ZlbA6vPHmISvnaypmZyidMEwHpyhzC6etOWer3mx7jo9RC1QjmYSQI2tdNewFMBz7/ZlkrE8+IF8swNsKT0BD8Gp5SaawXcHr7hh16SbFwngWrJIjMvxOCj2FiE6AGR+4Cgf9GPMG08TpRZRB0Q2n/2YgBJeVrpUDdzJ60/obQomcg6SRLTwl4adM5ZlWqH7eJqnSaKRS/JNrh0gVlyABIA3bI9CAE7qrwRwXiEvTI8t0DHMy4tnMRLG33kBPVnnyoEXbR8j8VJkfdJkY/uqHyixKeuFSDU3LU8ObO+xDgQKXgpteaAQdqpB/87tJBn3rDIRSPdZ04v3aH3sjjXGyhB2ZfOkc5PVoX86EhnDYFF7y3pZAxOJ2J428TBlJ8BZeSbh1m0E478QYCilHfpK0G85jFqeYi4ZqXIzfqbqE9oT35ZZlFJrlH7Rx/Tz6hzzrHBHV1uaE0z4xphcrgkAaf8h+WOHxs3zyGWnq7JhQOirnJaaUoOg==
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(136003)(396003)(376002)(39860400002)(346002)(451199015)(36840700001)(46966006)(40470700004)(82310400005)(7636003)(5660300002)(356005)(82740400003)(478600001)(2906002)(7416002)(16526019)(1076003)(186003)(47076005)(426003)(83380400001)(70586007)(6666004)(54906003)(41300700001)(7696005)(8676002)(4326008)(26005)(70206006)(336012)(36860700001)(40460700003)(110136005)(36756003)(316002)(8936002)(40480700001)(2616005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2022 03:19:58.6889
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e4c1c3a-cb2c-46ff-2477-08daa749a634
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT092.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6609
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of hardcoding value for the maximum discard sector to
UINT_MAX >> 9, allow user to set the value with newly added module
parameter max_discard_sectors.

To retain the backward compatibility make set default value to
UINT_MAX >> 9.

Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
---
 drivers/block/null_blk/main.c     | 10 +++++++++-
 drivers/block/null_blk/null_blk.h |  1 +
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
index 96b8aca5abda..2f787807cf63 100644
--- a/drivers/block/null_blk/main.c
+++ b/drivers/block/null_blk/main.c
@@ -216,6 +216,10 @@ static bool g_discard;
 module_param_named(discard, g_discard, bool, 0444);
 MODULE_PARM_DESC(discard, "Support discard operations (requires memory-backed null_blk device). Default: false");
 
+static unsigned int g_max_discard_sectors = UINT_MAX >> 9;
+module_param_named(max_discard_sectors, g_max_discard_sectors, uint, 0444);
+MODULE_PARM_DESC(max_discard_sectors, "Maximum size of a REQ_OP_DISCARD command (in 512B sectors).");
+
 static bool g_write_zeroes;
 module_param_named(write_zeroes, g_write_zeroes, bool, 0444);
 MODULE_PARM_DESC(write_zeroes, "Support write-zeores operations. Default: false");
@@ -420,6 +424,7 @@ NULLB_DEVICE_ATTR(home_node, uint, NULL);
 NULLB_DEVICE_ATTR(queue_mode, uint, NULL);
 NULLB_DEVICE_ATTR(blocksize, uint, NULL);
 NULLB_DEVICE_ATTR(max_sectors, uint, NULL);
+NULLB_DEVICE_ATTR(max_discard_sectors, uint, NULL);
 NULLB_DEVICE_ATTR(irqmode, uint, NULL);
 NULLB_DEVICE_ATTR(hw_queue_depth, uint, NULL);
 NULLB_DEVICE_ATTR(index, uint, NULL);
@@ -544,6 +549,7 @@ static struct configfs_attribute *nullb_device_attrs[] = {
 	&nullb_device_attr_queue_mode,
 	&nullb_device_attr_blocksize,
 	&nullb_device_attr_max_sectors,
+	&nullb_device_attr_max_discard_sectors,
 	&nullb_device_attr_irqmode,
 	&nullb_device_attr_hw_queue_depth,
 	&nullb_device_attr_index,
@@ -686,6 +692,7 @@ static struct nullb_device *null_alloc_dev(void)
 	dev->queue_mode = g_queue_mode;
 	dev->blocksize = g_bs;
 	dev->max_sectors = g_max_sectors;
+	dev->max_discard_sectors = g_max_discard_sectors;
 	dev->irqmode = g_irqmode;
 	dev->hw_queue_depth = g_hw_queue_depth;
 	dev->blocking = g_blocking;
@@ -1850,7 +1857,8 @@ static void null_config_discard(struct nullb *nullb)
 	}
 
 	nullb->q->limits.discard_granularity = nullb->dev->blocksize;
-	blk_queue_max_discard_sectors(nullb->q, UINT_MAX >> 9);
+	blk_queue_max_discard_sectors(nullb->q,
+				      nullb->dev->max_discard_sectors);
 }
 
 static void null_config_write_zeroes(struct nullb *nullb)
diff --git a/drivers/block/null_blk/null_blk.h b/drivers/block/null_blk/null_blk.h
index 2c0c9c29158f..09940211326d 100644
--- a/drivers/block/null_blk/null_blk.h
+++ b/drivers/block/null_blk/null_blk.h
@@ -102,6 +102,7 @@ struct nullb_device {
 	unsigned int queue_mode; /* block interface */
 	unsigned int blocksize; /* block size */
 	unsigned int max_sectors; /* Max sectors per command */
+	unsigned int max_discard_sectors; /* Max discard sectors per command */
 	unsigned int irqmode; /* IRQ completion handler */
 	unsigned int hw_queue_depth; /* queue depth */
 	unsigned int index; /* index of the disk, only valid with a disk */
-- 
2.29.0

