Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B61A63CBDC
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 00:30:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230207AbiK2XaQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 18:30:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229979AbiK2X3v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 18:29:51 -0500
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2042.outbound.protection.outlook.com [40.107.212.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09E1B71195;
        Tue, 29 Nov 2022 15:29:43 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RZZDjsEMLTSEpns8GiNKL03F3M2nWnJMheq5dg04Wugz8Erczh6F7xzAXz8tkvTanuy5fO1opDS4f7tKErV7k4Mzzkof49QTnxh0pun0lBiVtZ/Gmf4NynA7IxMTczOgSglHSEixJGUSDdg29hlfQ1WdCmbcVihQLm0l6GRs4enD/XnJel84WYoV94UV6mGMuNcbEhMlR3z5YXfrZVZvY4h5Nb0wyFQuRYzia6x6f+fnNGtPHOuJOPJQ/qv1QbZXXa2kfqwIfd+XCPyPuBTVsqLmZxRc4M5p72VZ0LRZjtqpdBRWXLWJ+6cCBzjdLj3fcWp9XPYp6ji8erNaAmmWTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AIe4mKOyn70BXMu9ewRDR6BaGZiCjfn7IR9cPrqCt9M=;
 b=L5N+ko/MoXO/PSPX4oqNCPe4zwnz5CcG1wbIEH+HIxDk2DubN+39zgdZTWng+VlFmoddiByQvu0aH2dLCN9T+JkeB1JitvqaWLA5NTKjBFBef86fiFM2Tptc2c+xAYrFGYpGbJv7avLeMa7TjPXRZa1ExIwwGSx0SgfHEbcInXx8mTJmawibVAV2eJJ9j3Ukg7/JSNq2ggtUVEdmmF5byICVsk2HOiSNV8e5khNPILFuXPyy4Is6uT8dC4JV6NAbIoJa36KLSKXDOHtZ2E3u3xPU7wsT8oMk9jc1ytg27+OYYKPMxEih9UW2uVb/t/eDWXzHeEDPLgbZFodJEjJ9sQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AIe4mKOyn70BXMu9ewRDR6BaGZiCjfn7IR9cPrqCt9M=;
 b=GTgtjxDADylS9Il+VOuY1MUuhSsy1cBPkDY4ziNNS2frPCCzeWjIgxZCIX563abPZzCFB5x/fycf81/Mg0ey98OjHyb/jUnaVz0tw5d6OoVWRHzYS+JDYlx08+60L+Y0pBRjyz2bfk/RSQU7fwpvm85UHGHBmdBZcpp7IoeAQezP2ffJJp+tyUtXav08hMfYJjOh46ex0GKEzas0XQ31buHhHaW65UeYp0Pvkzn5ZzjpucZF4ptd8G7VqKe9iH3nJ5BFks8Lahp9yNZynTuoc1tvkALMoJisP2GbnGfsKehOZhaI0UaK8FW4fBQED2M6hECMxPETEUkbB1yC8HZmKA==
Received: from DM6PR07CA0080.namprd07.prod.outlook.com (2603:10b6:5:337::13)
 by MW4PR12MB6729.namprd12.prod.outlook.com (2603:10b6:303:1ed::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.23; Tue, 29 Nov
 2022 23:29:39 +0000
Received: from DM6NAM11FT010.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:337:cafe::f3) by DM6PR07CA0080.outlook.office365.com
 (2603:10b6:5:337::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.23 via Frontend
 Transport; Tue, 29 Nov 2022 23:29:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DM6NAM11FT010.mail.protection.outlook.com (10.13.172.222) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5857.21 via Frontend Transport; Tue, 29 Nov 2022 23:29:39 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Tue, 29 Nov
 2022 15:29:30 -0800
Received: from dev.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Tue, 29 Nov
 2022 15:29:29 -0800
From:   Chaitanya Kulkarni <kch@nvidia.com>
To:     <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <axboe@kernel.dk>, <damien.lemoal@opensource.wdc.com>,
        <bvanassche@acm.org>, <shinichiro.kawasaki@wdc.com>,
        <vincent.fu@samsung.com>, Chaitanya Kulkarni <kch@nvidia.com>
Subject: [PATCH V4 6/8] null_blk: add param to set max disacrd sectors
Date:   Tue, 29 Nov 2022 15:28:11 -0800
Message-ID: <20221129232813.37968-7-kch@nvidia.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20221129232813.37968-1-kch@nvidia.com>
References: <20221129232813.37968-1-kch@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT010:EE_|MW4PR12MB6729:EE_
X-MS-Office365-Filtering-Correlation-Id: a2cae71b-d97c-432f-12cd-08dad26195f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LeVfjxuzxwNIPAI0hn7SyD/a45gUILPYe6+Kq+3YcrVtsrLd7EddXqAm5rB2xpzMKuwlJUE0E0xRS8Qw42vbUG5i5L+usI2yooVEHInb8wIU+XG6BSwwGKu/xKFzx/OKWNjqlp3NaQXdY6hcDfOYzHT8ONihjqV2qJybyera/YwtLCJuugtaI6XN55bDxcBD6uOMpNa75qq22vWWS0p/qyM4e+yq0skD/ftaj/0ZHwfEX7p3UUDJPCAQwonzIsGB+0ab/Dsg52AHKQqSTlsHWyo/XKAI6dUp+2Tx9NUCqH7kZFSdr9DSvacoJjG9J/fy/fIZmqOTmvqTH6Ve++K1MHxrNsmqJzY5sqfgbu3MV8K/TRLwXXnPsFM7sjwNbqoH8asoxJ5WMl04i3lw/9nOEborvwuhsWQKcOMvdi08HCR6GtavyFTHcHUDfR5J41ZrfWohlYmPOlhonyPSLIl/8HCRL6QdustVSIbkoEK8vo8N4B2QJvR76O2JglmV0lL2sGLN9SIHWjBn2We3NMToY8y9lqZj0QIO9UOcmKOPnaw10Ul7D/aexfo4IUqITK9eBpiJsq4zqhhoXEkp7TREFIiFosB8IlOkm0gavALTHZv5ZKuDFJgnidgGVKVwMoGKAXAjSxr3EUNFNH0a1TE+7DT/frk/s1PoJ7bkG/q23FV81Iza5xeOavZPuh1IQphoqpaMrvTec8DLcHr/I943Ow==
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(396003)(136003)(376002)(346002)(451199015)(40470700004)(46966006)(36840700001)(26005)(107886003)(6666004)(40480700001)(110136005)(54906003)(36756003)(40460700003)(7696005)(82740400003)(316002)(47076005)(426003)(7636003)(356005)(83380400001)(36860700001)(2906002)(8676002)(70586007)(4326008)(70206006)(8936002)(5660300002)(336012)(1076003)(82310400005)(41300700001)(186003)(16526019)(478600001)(2616005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2022 23:29:39.4114
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a2cae71b-d97c-432f-12cd-08dad26195f2
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT010.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6729
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

