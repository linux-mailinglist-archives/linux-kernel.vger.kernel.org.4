Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 705C562A249
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 20:55:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231638AbiKOTzB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 14:55:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231666AbiKOTyh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 14:54:37 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2089.outbound.protection.outlook.com [40.107.243.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6336E275EA;
        Tue, 15 Nov 2022 11:54:36 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jOG0VlSJf/PIbhD0UGV3ega4ruCv1Kc+gtrkGHBNAhmNX1y4xuTfIbz3gamWOaqDFrHRX1dFmN6idZomItLdUCyH5VH5jIVMV0Yl6dRbsYvRM8rs5skZpaJN2uUi4dRdTHHGHvFAdZUWJnnaHRgA96PEt7LKS2C0V2JTU2/CmoedmPJBuB6pvCK/J6AAUK8ZgMuwUMJPXCl2jIrrei/OP20plwdQvqqLCeflkdpauBlj3BDLzQio7rKxtTygCM72JqAQ4A4OBLepViyc5PkAE8/Z60lKxW3GN8YTKlE48nTnX38rIU9ay6Ps3m86nKUJ8dToH+30HE5Go3nFY7OR6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nFqgZ6hkvB+UNHlLEnApNNs+eawUZVXnNm+limTbryI=;
 b=DbNfWzJHOdyOEBkKDQahHFuycq8yi4+zkGROgvB+iN/JfEGfyFS87GVI81Y8VxkomMazHoGQeIEqLtsGMziGLGiQoef9FSshdj1i4Xsgp7haPLuhHqt0QJ3jY/Y/AbOFKK42kYl0KMP0+QFd1RBFjWoHFsnnqNY1I50NtcSfjfbltw5zxyAlcEFcc1EbLhDVP8QXULfDt5PZ5shhWH64UMfQGx2t53+G41fnkVRTqs3cGvQA3Zl2gjD1C4G5uUIK+uvIJStmdOsxoNu0PoyqCuF1H1F+979HXgxyXNaE2+60V7VnqtdsQu6YqL8XlTyFLpsG7wnxNE3ICjzChhiS/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nFqgZ6hkvB+UNHlLEnApNNs+eawUZVXnNm+limTbryI=;
 b=SRf6Z2BKdQhsuU33647aSajLJfjUcK6ybXKiekPU/pH3IUQZ7FvKPCXqjBtY9Eseky4z2wyAl0qHDKqUMpEjrdhyDqe/CiSUhTvYHA5D3oF13lQMcR4So41pfxuJuhxsNdM8QEbj3SqJHu59P0BIHBTluVYhqjBcEwwoFeQwAvKTjSmfP9iBE52LU0T25Q+A93vHYqtg0MvowUOORHLMAhcvCkOhTqyV9MjRO+LkEqSpGJk+W2rZfqnSEa7d4utOmexJwFhTxGt468Ovj0duycU2JBejG0G+7ZJDE3v+Krowq6eM2yg1aTJnatKgC8rbRE5TX50oSNlz2zgWO/G0nw==
Received: from MW4PR03CA0171.namprd03.prod.outlook.com (2603:10b6:303:8d::26)
 by CH2PR12MB4101.namprd12.prod.outlook.com (2603:10b6:610:a8::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.17; Tue, 15 Nov
 2022 19:54:34 +0000
Received: from CO1NAM11FT080.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8d:cafe::55) by MW4PR03CA0171.outlook.office365.com
 (2603:10b6:303:8d::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.17 via Frontend
 Transport; Tue, 15 Nov 2022 19:54:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1NAM11FT080.mail.protection.outlook.com (10.13.174.99) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5834.8 via Frontend Transport; Tue, 15 Nov 2022 19:54:33 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Tue, 15 Nov
 2022 11:54:21 -0800
Received: from dev.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Tue, 15 Nov
 2022 11:54:21 -0800
From:   Chaitanya Kulkarni <kch@nvidia.com>
To:     <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <axboe@kernel.dk>, <kch@nvidia.com>,
        <damien.lemoal@opensource.wdc.com>, <johannes.thumshirn@wdc.com>,
        <bvanassche@acm.org>, <ming.lei@redhat.com>,
        <shinichiro.kawasaki@wdc.com>, <vincent.fu@samsung.com>,
        <yukuai3@huawei.com>
Subject: [PATCH V3 7/7] null_blk: add param to set max write-zeroes sects
Date:   Tue, 15 Nov 2022 11:52:53 -0800
Message-ID: <20221115195253.182484-8-kch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CO1NAM11FT080:EE_|CH2PR12MB4101:EE_
X-MS-Office365-Filtering-Correlation-Id: 6baf2f32-42e4-4f89-6d23-08dac74337cb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: o5cU8cZD0U6dJeJN3vW/vRnGe4XvmYF7+UHk51li3YiEtR9/d8zYQhXu/958YH9U4xynD+PlWqDjlJCkT6hXDhxFnmr8WssTfoafV1S7+EptNsTDYCN2Yh7pGNdm5J70D73m4pl+IckpTr2lHbR0iGmbFgSRzoSchoYueD2VqiozoZUI+1EmQElXO69Y0ceS/STgtEkpIlnBx6WsTTkIF35aDqSP9IimpgxI3h34g7lBgwP73gFlcphS6k65ybSJgYnl9zJYZqxpI0nQPEatvF4kufUWD8jVmvpP8eLEnQUtBLUNGVwFyiFNGeTyIJcgQEc1/kqKS10khQ/7cUgsukJQK8Zf/iroJf1LIFFbYJ7my9Wbu0dkouj06YJLM+SKY3vntahK7Ll3Nuw8ALdcl7nVmp0BYY4h/SQ65BevMcHtpdwxMq+cQZhj0RSvim7QbqHJ6FmIjI1i34zMDJMPRQGKIzo58HJ6ays77bXWhKIXkRF+dILjojkQ/3tPIVOR4kkoVByUtPaKdNscfB8zx2PrOvvR8AI2UI/C4s+FPNjzmOT9+kEbLMCC1C7AdXEjehEqsOfRPjDGm+MbaF5UVzgBYHFGSCmXOvoUhoNX3bM4k1QDyKzJ84yAA9hBbEVdrFQck8r7HeSSz9ba7eVQDO9I3rhc0dWR+GsuIo8SQiUmmb38Pqkk8Sp/blYXs+xb52C/tP9sxxAvp+OJhQmU7UgGgROAcva9XecD9o3qkr2e7Go18hTKzPyKc4p/iJ69h2CMp3cmRHmnYPxuWxUMeA==
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(376002)(346002)(396003)(136003)(39860400002)(451199015)(40470700004)(36840700001)(46966006)(41300700001)(36860700001)(40480700001)(478600001)(2616005)(4326008)(70586007)(8676002)(36756003)(70206006)(110136005)(2906002)(54906003)(40460700003)(1076003)(16526019)(6666004)(336012)(186003)(47076005)(426003)(83380400001)(5660300002)(82740400003)(316002)(7696005)(356005)(7416002)(8936002)(26005)(7636003)(82310400005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2022 19:54:33.7598
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6baf2f32-42e4-4f89-6d23-08dac74337cb
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT080.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4101
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of hardcoding value for the maximum write-zeroes sector to
UINT_MAX >> 9, allow user to set the value with newly added module
parameter max_write_zeroes_sectors.

Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
---
 drivers/block/null_blk/main.c     | 10 +++++++++-
 drivers/block/null_blk/null_blk.h |  1 +
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
index 2f787807cf63..8b7f42024f14 100644
--- a/drivers/block/null_blk/main.c
+++ b/drivers/block/null_blk/main.c
@@ -224,6 +224,10 @@ static bool g_write_zeroes;
 module_param_named(write_zeroes, g_write_zeroes, bool, 0444);
 MODULE_PARM_DESC(write_zeroes, "Support write-zeores operations. Default: false");
 
+static unsigned int g_max_write_zeroes_sectors = UINT_MAX >> 9;
+module_param_named(max_write_zeroes_sectors, g_max_write_zeroes_sectors, uint, 0444);
+MODULE_PARM_DESC(max_write_zeroes_sectors, "Maximum size of a REQ_OP_WRITE_ZEROES command (in 512B sectors).");
+
 static unsigned long g_cache_size;
 module_param_named(cache_size, g_cache_size, ulong, 0444);
 MODULE_PARM_DESC(mbps, "Cache size in MiB for memory-backed device. Default: 0 (none)");
@@ -425,6 +429,7 @@ NULLB_DEVICE_ATTR(queue_mode, uint, NULL);
 NULLB_DEVICE_ATTR(blocksize, uint, NULL);
 NULLB_DEVICE_ATTR(max_sectors, uint, NULL);
 NULLB_DEVICE_ATTR(max_discard_sectors, uint, NULL);
+NULLB_DEVICE_ATTR(max_write_zeroes_sectors, uint, NULL);
 NULLB_DEVICE_ATTR(irqmode, uint, NULL);
 NULLB_DEVICE_ATTR(hw_queue_depth, uint, NULL);
 NULLB_DEVICE_ATTR(index, uint, NULL);
@@ -550,6 +555,7 @@ static struct configfs_attribute *nullb_device_attrs[] = {
 	&nullb_device_attr_blocksize,
 	&nullb_device_attr_max_sectors,
 	&nullb_device_attr_max_discard_sectors,
+	&nullb_device_attr_max_write_zeroes_sectors,
 	&nullb_device_attr_irqmode,
 	&nullb_device_attr_hw_queue_depth,
 	&nullb_device_attr_index,
@@ -693,6 +699,7 @@ static struct nullb_device *null_alloc_dev(void)
 	dev->blocksize = g_bs;
 	dev->max_sectors = g_max_sectors;
 	dev->max_discard_sectors = g_max_discard_sectors;
+	dev->max_write_zeroes_sectors = g_max_write_zeroes_sectors;
 	dev->irqmode = g_irqmode;
 	dev->hw_queue_depth = g_hw_queue_depth;
 	dev->blocking = g_blocking;
@@ -1865,7 +1872,8 @@ static void null_config_write_zeroes(struct nullb *nullb)
 {
 	if (!nullb->dev->write_zeroes)
 		return;
-	blk_queue_max_write_zeroes_sectors(nullb->q, UINT_MAX >> 9);
+	blk_queue_max_write_zeroes_sectors(nullb->q,
+			nullb->dev->max_write_zeroes_sectors);
 }
 
 static const struct block_device_operations null_bio_ops = {
diff --git a/drivers/block/null_blk/null_blk.h b/drivers/block/null_blk/null_blk.h
index 09940211326d..e692c2a7369e 100644
--- a/drivers/block/null_blk/null_blk.h
+++ b/drivers/block/null_blk/null_blk.h
@@ -103,6 +103,7 @@ struct nullb_device {
 	unsigned int blocksize; /* block size */
 	unsigned int max_sectors; /* Max sectors per command */
 	unsigned int max_discard_sectors; /* Max discard sectors per command */
+	unsigned int max_write_zeroes_sectors; /* Max write-zeroes sectors per command */
 	unsigned int irqmode; /* IRQ completion handler */
 	unsigned int hw_queue_depth; /* queue depth */
 	unsigned int index; /* index of the disk, only valid with a disk */
-- 
2.29.0

