Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2425862A247
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 20:54:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231374AbiKOTyq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 14:54:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231331AbiKOTya (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 14:54:30 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2059.outbound.protection.outlook.com [40.107.220.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C19E22EF5B;
        Tue, 15 Nov 2022 11:54:21 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iysyIkb2qe+ZRjpP5tOEVfR+zxh+EnNRv//T6R3d6FJApLHGNd6arBiZrQGWQaaljZSGpYrG33Gh03BIzVds2GNPTjdU3rbZIehDqUinneOVXfm2PWj1uIVA94RoRgn4LpPtDVjWkdesApLFSfVSkvZw8xwPRvAyv5Ud5KYqgTYzSLl6oFKZqgJ2/YhnUFhIdkrmLyl5UQFJ5O0E7pP+bNtDYu5u8cvDarc3YoI6R02kXGbkFu7RS4efIZQcU0gxyU2lE2rHpW3NcyWP+kQp5OOcOiGDWDOlA1tDwlvfNgTxY4T8oQ8cVBMTdQwO41i5O4rYy0SsOtmE0+qcWsl1sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AIe4mKOyn70BXMu9ewRDR6BaGZiCjfn7IR9cPrqCt9M=;
 b=OoEyqfoDvqukhS5V31Qn5F6N3uk3Vlgk0bRG0H5c1wtW9DJ5xyrwc9zDpljGC0fe5z1A4w7ZgpYaCv6blA/kYsfG4V89TGmylBlAf+imqTtCvjL1NWasOWodQET2kvc2BsAWC3+ouGEEYd5GkVZbT0Fh5rwnb9qchS7Th8acq9xrgUA3UhYxgWjtwWs8FxsuENHw7r7THEUCerqdA0IJgkDZvuFYz8eWaDn/wy5iCzanTHvyyjvYro24y46z6kooEBbBBPksR2Z3bI58e23CJTdiPjoEM/Tb5bHaR15NbCroFwIXe31YV0gL/i82lKxEd9+If8EJgTG8SV3OrN0V3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AIe4mKOyn70BXMu9ewRDR6BaGZiCjfn7IR9cPrqCt9M=;
 b=JFSoxaegqJ3HA3Bv7/FbiSsofDuso7pZ1NoxtEB16S22Ls7Absj+/n2RYG+cwKKmyJLAjLXhbg5Lb1mYV04ATJhkj5nxrJZyo35Lsp5WVvT7Zqw6jRTexPZ/7QpQUV4vPFDhkT8HcyG6zx+E/puG4Df/ARhdKk/9cRxQzBj+0r9nx2jNs9TdzmaNDsdtKkivIMAWhk93I5hOO6PTm8vs3cuQ3XJgIlMG55uI3P95xt7mLhSumZih/uBhSdVW6FLKjyGe7BAiKLdyFqAEYCj8nx/xwUjroKrAS/rM3scNwBNjUGGIvEiE5AEC7fJ2aeyC7F6yeJq336UCihpKJ0sRKw==
Received: from DS7PR03CA0302.namprd03.prod.outlook.com (2603:10b6:8:2b::11) by
 DS0PR12MB7678.namprd12.prod.outlook.com (2603:10b6:8:135::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5813.17; Tue, 15 Nov 2022 19:54:20 +0000
Received: from DM6NAM11FT034.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:2b:cafe::17) by DS7PR03CA0302.outlook.office365.com
 (2603:10b6:8:2b::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.17 via Frontend
 Transport; Tue, 15 Nov 2022 19:54:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DM6NAM11FT034.mail.protection.outlook.com (10.13.173.47) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5834.8 via Frontend Transport; Tue, 15 Nov 2022 19:54:20 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Tue, 15 Nov
 2022 11:54:10 -0800
Received: from dev.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Tue, 15 Nov
 2022 11:54:09 -0800
From:   Chaitanya Kulkarni <kch@nvidia.com>
To:     <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <axboe@kernel.dk>, <kch@nvidia.com>,
        <damien.lemoal@opensource.wdc.com>, <johannes.thumshirn@wdc.com>,
        <bvanassche@acm.org>, <ming.lei@redhat.com>,
        <shinichiro.kawasaki@wdc.com>, <vincent.fu@samsung.com>,
        <yukuai3@huawei.com>
Subject: [PATCH V3 6/7] null_blk: add param to set max disacrd sectors
Date:   Tue, 15 Nov 2022 11:52:52 -0800
Message-ID: <20221115195253.182484-7-kch@nvidia.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20221115195253.182484-1-kch@nvidia.com>
References: <20221115195253.182484-1-kch@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT034:EE_|DS0PR12MB7678:EE_
X-MS-Office365-Filtering-Correlation-Id: ad003b49-0383-49cf-b811-08dac7432faf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TtL/gI3VI4vIMG4K5klqNxvmYDSRoLs2cPau0DRjTEG87Y9jbnCE0byoy+TWhSecqve7gDM74DfdUaTS3chalArv1++XByk9Y3yaSdjxFBlBdP+Ox46Q22msejjBdaDJ+vUasTe0hwnvdMrrNAfDYqEuwBw8skZ84C1bB8OJEpd9dNTc/302JwNnl56o/cxdQXPR/lH4V7FUbn9pYcQ6/tMWhLadOqo6dmQDPrHd5ry3hhQ4vRuW+tUX+P4Pi4esMtBxf9iDrf1RLmaiNYShQPWfoeEMrgbBpW8aYZx8KplH3iImrNj/1eKwBtBYm5pKFPycYmCE0WW2X9lgRlfZtvIhArSUOGWK0L9IQc9o8qm4t8+u3ZVMOffACVTqaavLld4M8naQsEZgEKYZ2PS92QYITZM6L06SqgGqruo6Az2sLSXJ1ZtK9eiUT2zcfetGjTojKDCUWxkNT7ykk1JQZnhc/wF2PIMZSnUy7Xns0b8ZHWNjFmUrIysmVebVp8jUFUUqBL5j++YQDDeufhPwpkIwZMdskeCpxJApHGqOlbsa5Rcih7yvHxwgJS3UsBdL4PvrJ5znl8dLrbGRrCSWCxKjgzilouZ2p61AgeIVdAOW1xaYtWdN7lB2Gn7rVuxXSNNG5Fn84L6h6BLncEeitWhR9s70Yzsd0+XfBeUma9wU46f0ZBQxt0hpmu5PWk8ZhBKUshYeXeVJUxiKEs4qkevu53pnjnxH5QIhJkrGE6E1tBFv6dItTTAHu4adNm+15cYZUnBNTHILEgas7kkeWg==
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(396003)(346002)(136003)(376002)(39860400002)(451199015)(36840700001)(40470700004)(46966006)(2616005)(47076005)(83380400001)(82740400003)(1076003)(426003)(356005)(7636003)(16526019)(36860700001)(186003)(7416002)(336012)(8936002)(2906002)(478600001)(8676002)(40480700001)(82310400005)(7696005)(5660300002)(4326008)(70586007)(70206006)(6666004)(26005)(41300700001)(54906003)(110136005)(316002)(40460700003)(36756003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2022 19:54:20.1565
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ad003b49-0383-49cf-b811-08dac7432faf
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT034.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7678
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

