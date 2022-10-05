Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C56935F4E0D
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 05:17:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229677AbiJEDRi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 23:17:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbiJEDR0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 23:17:26 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2048.outbound.protection.outlook.com [40.107.223.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF7CA70E5E;
        Tue,  4 Oct 2022 20:17:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z2/DZ9Qci7JdUF5+sGUEY3nRaDbNsWDyaJDWW7hECVa6NR4mpTepblCfx7y86Qs0tV6Z0xeaQRTfd7JWguJDf+Q6dt1AEHCuhvwqHTRFj5d03kRe+la65PH80C0fzE2n21Q2aT+OlA/+Kdke8QSsgwqbAfdhHPZ6q4frYyCV4/6AIJzvy6dELmacOwSclqxVHSBY/jj7wNrGrqPR1VOPtRF15zqOmqJr9JCkwWFLZQ9l0LPO9BOEtCzjXPV9rTdNAcuN0noVBreo3TqRqKzN4MebAEH22TrqnyPpu22xQoG11iYU22pE7XWpbbwbh5BUgUIe4XvEhiZt+3e5KAwjTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nyxT5L72cfmTiZ0Lz0Oo9N+HKWGDddaVBSnCu0PbFxc=;
 b=YmRQa3pg2B1HFIxGwbFNjSwcvwmwMCMOXWkFdcbEjYrzLSpcoNJCBABGL8/TyRvu71MPxwjUN6U6WO3+wx8LzSdYCHkuk9KN9MJ1UPA8maQMC39vgo0RX00TMWzq9tFbKeq9iGqMmavD4PYwOu8g4/PhB1SA/bxOonG8VxOoBx9TxgJO4xhmlSS34lNB2JHMmuSyBWggSqh9VNsxBy6MY3nSZMIvVGdffOlckc4J2XtvetChCwjKO4Lp/AacuLKIcmyA0zWI8LJjxBphFWJo9PYeoNpgm9afX0lGav1ttN0sitk7h8lfq0PuNmboZTrymlq+jWA7ginPi7y1nZZRUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nyxT5L72cfmTiZ0Lz0Oo9N+HKWGDddaVBSnCu0PbFxc=;
 b=k2ZILX/8Nk3WzakKhT9nezV8jzoGOVAw8Cyr53G9VMro3wzM/GiyB6JaJBF9tU/vtfGlpob+/QM/PhwlDeEYTVPhoJlnsnfs1J+Vyxt5lkdfbVU1l4MMLYftm8f5sg6+CKpt8XBzU8wryxmew2DPMJnV7sLo6Cds7WyERHXDtl94xzh6uCxa0wYdO3Qi7BfPDmUWYmVo4j4lZFumAUTn9gwti0ODO0Pknt2qzYVtQKZgICc62UrrAZeKpOW7oXCXT0fi644o5GyLgYcWa3SOqIfpkR6dQ3bx4PTtstRBpfnh4KDpck8Rd0fYHFPDqRk+MMkiONk8IlQyIfEAUiEeoQ==
Received: from DM6PR08CA0011.namprd08.prod.outlook.com (2603:10b6:5:80::24) by
 MN0PR12MB6002.namprd12.prod.outlook.com (2603:10b6:208:37e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.31; Wed, 5 Oct
 2022 03:17:23 +0000
Received: from DM6NAM11FT013.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:80:cafe::df) by DM6PR08CA0011.outlook.office365.com
 (2603:10b6:5:80::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.25 via Frontend
 Transport; Wed, 5 Oct 2022 03:17:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DM6NAM11FT013.mail.protection.outlook.com (10.13.173.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5709.10 via Frontend Transport; Wed, 5 Oct 2022 03:17:22 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Tue, 4 Oct 2022
 20:17:21 -0700
Received: from dev.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Tue, 4 Oct 2022
 20:17:21 -0700
From:   Chaitanya Kulkarni <kch@nvidia.com>
To:     <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <axboe@kernel.dk>, <kch@nvidia.com>,
        <damien.lemoal@opensource.wdc.com>, <johannes.thumshirn@wdc.com>,
        <bvanassche@acm.org>, <ming.lei@redhat.com>,
        <shinichiro.kawasaki@wdc.com>, <vincent.fu@samsung.com>,
        <yukuai3@huawei.com>
Subject: [PATCH 1/6] null_blk: allow write zeores on non-membacked
Date:   Tue, 4 Oct 2022 20:16:56 -0700
Message-ID: <20221005031701.79077-2-kch@nvidia.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20221005031701.79077-1-kch@nvidia.com>
References: <20221005031701.79077-1-kch@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT013:EE_|MN0PR12MB6002:EE_
X-MS-Office365-Filtering-Correlation-Id: 3897439f-54ed-47e1-f6c0-08daa6801ebd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7jjNdR7nGi2mnYwRf4NkduSv3Oq/ei/sU+gstEZvdCZMQuS7pECUVB7dEWW2eU4RHSj6jCrYsCZ6SUv0q1hBkuIRScmHMzwSn49XHkclKUCugxKAb5WtcFUUQkWEci8wk9jBZBfIfiaD7i8lqwg0eCuTdprAjdICvv9tWVg6MufEsFFcQk8Z4ywZbgyJ4Hkh/64OIAKsyTXK46UVz1yLMXTL4zZL9CTyFYr3B6EPAF1uVv8YoQZmW32ES9Arya0ZK+KGpHc1RQrEV1DZKxg2D8vbxDyPqFOqiheF+XEqwD3gB03M5xlQasbO68eXEGOTfbaFzaKX1hUp9DXAdLvP+zwxga6Hi8CBnMkYbouEWbvG/0pml0KUsNckYvHTHm58U9W7YupOlGfheaLrHc7gpZahqScLyDZBpunGjL2dWH7f14Q67iD2MfdegBM8c0toKeAfK00EB06L6AWMYT40dmU/9Wjf4rVnz493wBxxK2LKcB5IvFkipjsZdjq1wME+BVSTlq+2kpI6+VLJhq45f57hEZREpkaZIUzmnmuDWoSIbdjsr4LdLkN5frQju5YeP1+kX3zZdQ6ZmR/uQn0qUK4F8wSLrK1B00cfnhtf3H/UA0XXbDvicq2DAim0Eblxvs8ZKVVaEkhdIg5Ed6qQvchwbMqWpdvD4M9hBENk6U99mL47etxLPeRnXcdzVESCMMuKz+IvNu36meMwkoxg6p5z8tNLVnX5O6L56JpTBD/vpt7KQsCn6QDZm10PcZjA3MigkxtSBwsdpFZmWv/zsg==
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(136003)(39860400002)(346002)(376002)(396003)(451199015)(36840700001)(46966006)(40470700004)(1076003)(186003)(2616005)(16526019)(82310400005)(2906002)(356005)(316002)(70206006)(6666004)(40460700003)(54906003)(70586007)(110136005)(4326008)(8676002)(478600001)(41300700001)(5660300002)(7416002)(7696005)(7636003)(26005)(336012)(426003)(40480700001)(8936002)(47076005)(36756003)(82740400003)(83380400001)(36860700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2022 03:17:22.6262
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3897439f-54ed-47e1-f6c0-08daa6801ebd
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT013.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6002
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a helper function to enable the REQ_OP_WRITE_ZEROES operations
when null_blk is configured with the non-membacked operations.

Since write-zeroes is a non-trivial I/O operation we need this to
add a blktest so we can test the non-trivial I/O path from the
application to the block layer.

Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
---
 drivers/block/null_blk/main.c     | 13 +++++++++++++
 drivers/block/null_blk/null_blk.h |  1 +
 2 files changed, 14 insertions(+)

diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
index 1f154f92f4c2..fc3e883f7b84 100644
--- a/drivers/block/null_blk/main.c
+++ b/drivers/block/null_blk/main.c
@@ -209,6 +209,10 @@ static bool g_discard;
 module_param_named(discard, g_discard, bool, 0444);
 MODULE_PARM_DESC(discard, "Support discard operations (requires memory-backed null_blk device). Default: false");
 
+static bool g_write_zeroes;
+module_param_named(write_zeroes, g_write_zeroes, bool, 0444);
+MODULE_PARM_DESC(write_zeroes, "Support write-zeores operations. Default: false");
+
 static unsigned long g_cache_size;
 module_param_named(cache_size, g_cache_size, ulong, 0444);
 MODULE_PARM_DESC(mbps, "Cache size in MiB for memory-backed device. Default: 0 (none)");
@@ -678,6 +682,7 @@ static struct nullb_device *null_alloc_dev(void)
 	dev->blocking = g_blocking;
 	dev->memory_backed = g_memory_backed;
 	dev->discard = g_discard;
+	dev->write_zeroes = g_write_zeroes;
 	dev->cache_size = g_cache_size;
 	dev->mbps = g_mbps;
 	dev->use_per_node_hctx = g_use_per_node_hctx;
@@ -1800,6 +1805,13 @@ static void null_config_discard(struct nullb *nullb)
 	blk_queue_max_discard_sectors(nullb->q, UINT_MAX >> 9);
 }
 
+static void null_config_write_zeroes(struct nullb *nullb)
+{
+	if (!nullb->dev->write_zeroes)
+		return;
+	blk_queue_max_write_zeroes_sectors(nullb->q, UINT_MAX >> 9);
+}
+
 static const struct block_device_operations null_bio_ops = {
 	.owner		= THIS_MODULE,
 	.submit_bio	= null_submit_bio,
@@ -2111,6 +2123,7 @@ static int null_add_dev(struct nullb_device *dev)
 		blk_queue_virt_boundary(nullb->q, PAGE_SIZE - 1);
 
 	null_config_discard(nullb);
+	null_config_write_zeroes(nullb);
 
 	if (config_item_name(&dev->item)) {
 		/* Use configfs dir name as the device name */
diff --git a/drivers/block/null_blk/null_blk.h b/drivers/block/null_blk/null_blk.h
index 94ff68052b1e..2c0c9c29158f 100644
--- a/drivers/block/null_blk/null_blk.h
+++ b/drivers/block/null_blk/null_blk.h
@@ -111,6 +111,7 @@ struct nullb_device {
 	bool power; /* power on/off the device */
 	bool memory_backed; /* if data is stored in memory */
 	bool discard; /* if support discard */
+	bool write_zeroes; /* if support write_zeroes */
 	bool zoned; /* if device is zoned */
 	bool virt_boundary; /* virtual boundary on/off for the device */
 	bool no_sched; /* no IO scheduler for the device */
-- 
2.29.0

