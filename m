Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A140D63CBE0
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 00:31:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230339AbiK2Xa5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 18:30:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229877AbiK2Xa0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 18:30:26 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2071.outbound.protection.outlook.com [40.107.93.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FA7F711A4;
        Tue, 29 Nov 2022 15:30:07 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ty+rTS/PcEyucpnhOxECoXjw9ZRuWBOMfaqO+kWgXyySD5EtBvr25lmwuAyyLNWVPET6vAQZ8WLLUaY7txA43sJdU9ey1xwUpVXnJugpq9nZ3PIt4ZukKov1wQLLPFjqwrL6G0VyCzxWiNzyk/VqoNnxGvipkJjCu0N7u3odQyDvECJk4aNgqBMkaqWCkHd4R5iuz7bf8F9DbNbzJbhI2ed/J19EVYxf0TYtIYValQXi5cu26OhH9g49soDBMolaQFQSsW5PZieUsIWy2q+ZhDHNKwBTBGXzmOVumEKzT9npLj1JdtTFGJkU1BSSkT/36/4L2OuCc0B6qqlvU9biBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=93bHBBtS0wv2XFC3NpfyeM7QV18vLpAd7mLOdv0Ca3U=;
 b=ABw5W/RQPRJUNKF5b1xy68uUY4B4/aPs0jquUK82/TOu9yuSh3YA4ecZBQlHkMr+pjFAEJNMXRQ646v4JqHntJvZtsoHjTQQ4pQq4dX5thEfe2LwBs01XfaQduTi18hVWkXctfGpTuzWJO2BKClzIft0wdbX8F6t2ALAXDe16RIGToQP3HCWpNFNXuEY/IV41Ge0lpWZEC0LCP3wzfaVTsaAi1LQ4n/ree2seCLlYbpG89w5AkXkLupUJMtU4r1qBrSGYy8SdjmdF+ASAea7BWj6U0EClDpge1eJtkjcW0zIYq0mTKAZMzoy5XF1eW9maWbiqveVQ9h6Ec5ZO9MikQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=93bHBBtS0wv2XFC3NpfyeM7QV18vLpAd7mLOdv0Ca3U=;
 b=EkDtE7/4dOc9nADw7CTWcX8cnXRrMxW0tTWwqR5RicwH7OtYSme37kzOMZimjht29YxZ1J8bbLLWFoGnCgt1IzPF47aP8SmCm2h8NsG6pH2GFha271ENEbBPorwsJpBbosPaW7OiNp0MKb05VsGnCLYxDEosivkXgFg7guawRCWLenGOmBWxdMSPvZeOEhpQ+VMeeCWLzLvpW8K7ccKSlbojEbzaUsq2rJdHpi282yD7lXEq1YSZjZfIaADHh4NAIlf/rqYPgSnwwO5FP9n7rsyjis4BG39Jopcu7jXI5+XNiXwFobYw0TTpnKaVK9W+tebrlayclhlXYrHBX/lNDQ==
Received: from DM6PR07CA0040.namprd07.prod.outlook.com (2603:10b6:5:74::17) by
 CH0PR12MB5371.namprd12.prod.outlook.com (2603:10b6:610:d6::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5857.23; Tue, 29 Nov 2022 23:30:05 +0000
Received: from DM6NAM11FT025.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:74:cafe::8c) by DM6PR07CA0040.outlook.office365.com
 (2603:10b6:5:74::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.23 via Frontend
 Transport; Tue, 29 Nov 2022 23:30:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DM6NAM11FT025.mail.protection.outlook.com (10.13.172.197) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5857.18 via Frontend Transport; Tue, 29 Nov 2022 23:30:05 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Tue, 29 Nov
 2022 15:29:53 -0800
Received: from dev.nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Tue, 29 Nov
 2022 15:29:52 -0800
From:   Chaitanya Kulkarni <kch@nvidia.com>
To:     <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <axboe@kernel.dk>, <damien.lemoal@opensource.wdc.com>,
        <bvanassche@acm.org>, <shinichiro.kawasaki@wdc.com>,
        <vincent.fu@samsung.com>, Chaitanya Kulkarni <kch@nvidia.com>
Subject: [PATCH V4 8/8] null-blk: allow REQ_OP_ZONE_RESET_ALL to configure
Date:   Tue, 29 Nov 2022 15:28:13 -0800
Message-ID: <20221129232813.37968-9-kch@nvidia.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20221129232813.37968-1-kch@nvidia.com>
References: <20221129232813.37968-1-kch@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT025:EE_|CH0PR12MB5371:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f769a18-bbae-478d-1157-08dad261a564
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dsNU3nUqq26GInb0yTDhWKXOX3RBQEncqWf19M6FgZkgA14gWDQGdpnN2sazGpOf6oFW/Sw5YQ5FKqvolJs5jPsqzpDTPgRgYTOimVCZ/jiU9nebYkP/GCxYJColtgxpEbOJqfeqyxtmSahRI9Wtwz4QiqNGMIzo5rtRh1u6+ELSSxmlAz89mvcIhe9HI2lnBCl60da+SUhySYUcKdse2CW6QYVPqz0Y6/UyRzdnYZ8l4ZGI9uvsp67PdCx8yrZRC5zwNGTelVaEn0I1iBAjq6Z8N5eRQE1Jbjd6VDdPa8TH7hWuhPb4X6D2sE1IKnEcnCkRRunlnkgafp41eAibdOB0kDs5yIFkLk0x0WjzUC2aAtR0FviBCLDrBQjX47XmFIPInUfyC99G7i8uCL98Z0c/WBCG8dgQWulvBjxS71RHNspQ/kUKScMSGvYton2OYJ62TaPrtGhEjOSwJ3Z39op5XISE0tZUi/Nry6QJSxzt4CjbDyWMSrpRoMJOe9dfH2A2lcTu6ZYQkdw5D+ElTNhsdL6lUk0K+mcPnshEEWkUWarDzxNadU6TO8fgwLj4CZp4xuGc6pGldOna6RJFfivQJ1oyLtZn742Df/YPlDszyRY8IG+xXEe+Gz2/k4t259nj5oIdUwwC4gVf1sK6L0dby4AS60/WxdoXnMz4HkDu23H8TLDfCtbYzolBua4kyp9AqHEYn8x8oFCuBMk0xg==
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(346002)(39860400002)(376002)(136003)(396003)(451199015)(36840700001)(46966006)(40470700004)(426003)(47076005)(2906002)(83380400001)(2616005)(41300700001)(5660300002)(8936002)(186003)(16526019)(1076003)(336012)(36756003)(40480700001)(36860700001)(40460700003)(82740400003)(82310400005)(107886003)(356005)(7636003)(7696005)(54906003)(110136005)(26005)(478600001)(316002)(6666004)(70206006)(4326008)(8676002)(70586007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2022 23:30:05.3399
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f769a18-bbae-478d-1157-08dad261a564
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT025.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5371
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For a Zoned Block Device zone reset all is emulated if underlaying
device doesn't support REQ_OP_ZONE_RESET_ALL operation. In null_blk
Zoned mode there is no way to test zone reset all emulation present in
the block layer since we enable it by default :-

blkdev_zone_mgmt()
 blkdev_zone_reset_all_emulation() <---
 blkdev_zone_reset_all()

Add a module parameter zone_reset_all to enable or disable
REQ_OP_ZONE_RESET_ALL, enable it by default to retain the existing
behaviour.

Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
---
 drivers/block/null_blk/main.c     | 9 ++++++++-
 drivers/block/null_blk/null_blk.h | 1 +
 drivers/block/null_blk/zoned.c    | 3 ++-
 3 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
index 8b7f42024f14..5dc69f42b46c 100644
--- a/drivers/block/null_blk/main.c
+++ b/drivers/block/null_blk/main.c
@@ -260,6 +260,10 @@ static unsigned int g_zone_max_active;
 module_param_named(zone_max_active, g_zone_max_active, uint, 0444);
 MODULE_PARM_DESC(zone_max_active, "Maximum number of active zones when block device is zoned. Default: 0 (no limit)");
 
+static bool g_zone_reset_all = true;
+module_param_named(zone_reset_all, g_zone_reset_all, bool, 0444);
+MODULE_PARM_DESC(zone_reset_all, "Allow REQ_OP_ZONE_RESET_ALL. Default: true");
+
 static struct nullb_device *null_alloc_dev(void);
 static void null_free_dev(struct nullb_device *dev);
 static void null_del_dev(struct nullb *nullb);
@@ -446,6 +450,7 @@ NULLB_DEVICE_ATTR(zone_capacity, ulong, NULL);
 NULLB_DEVICE_ATTR(zone_nr_conv, uint, NULL);
 NULLB_DEVICE_ATTR(zone_max_open, uint, NULL);
 NULLB_DEVICE_ATTR(zone_max_active, uint, NULL);
+NULLB_DEVICE_ATTR(zone_reset_all, bool, NULL);
 NULLB_DEVICE_ATTR(virt_boundary, bool, NULL);
 NULLB_DEVICE_ATTR(no_sched, bool, NULL);
 NULLB_DEVICE_ATTR(shared_tag_bitmap, bool, NULL);
@@ -574,6 +579,7 @@ static struct configfs_attribute *nullb_device_attrs[] = {
 	&nullb_device_attr_zone_nr_conv,
 	&nullb_device_attr_zone_max_open,
 	&nullb_device_attr_zone_max_active,
+	&nullb_device_attr_zone_reset_all,
 	&nullb_device_attr_virt_boundary,
 	&nullb_device_attr_no_sched,
 	&nullb_device_attr_shared_tag_bitmap,
@@ -639,7 +645,7 @@ static ssize_t memb_group_features_show(struct config_item *item, char *page)
 			"poll_queues,power,queue_mode,shared_tag_bitmap,size,"
 			"submit_queues,use_per_node_hctx,virt_boundary,zoned,"
 			"zone_capacity,zone_max_active,zone_max_open,"
-			"zone_nr_conv,zone_size,write_zeroes\n");
+			"zone_nr_conv,zone_size,zone_reset_all,write_zeroes\n");
 }
 
 CONFIGFS_ATTR_RO(memb_group_, features);
@@ -715,6 +721,7 @@ static struct nullb_device *null_alloc_dev(void)
 	dev->zone_nr_conv = g_zone_nr_conv;
 	dev->zone_max_open = g_zone_max_open;
 	dev->zone_max_active = g_zone_max_active;
+	dev->zone_reset_all = g_zone_reset_all;
 	dev->virt_boundary = g_virt_boundary;
 	dev->no_sched = g_no_sched;
 	dev->shared_tag_bitmap = g_shared_tag_bitmap;
diff --git a/drivers/block/null_blk/null_blk.h b/drivers/block/null_blk/null_blk.h
index e692c2a7369e..e7efe8de4ebf 100644
--- a/drivers/block/null_blk/null_blk.h
+++ b/drivers/block/null_blk/null_blk.h
@@ -115,6 +115,7 @@ struct nullb_device {
 	bool discard; /* if support discard */
 	bool write_zeroes; /* if support write_zeroes */
 	bool zoned; /* if device is zoned */
+	bool zone_reset_all; /* if support REQ_OP_ZONE_RESET_ALL */
 	bool virt_boundary; /* virtual boundary on/off for the device */
 	bool no_sched; /* no IO scheduler for the device */
 	bool shared_tag_bitmap; /* use hostwide shared tags */
diff --git a/drivers/block/null_blk/zoned.c b/drivers/block/null_blk/zoned.c
index 55a69e48ef8b..7310d1c3f9ec 100644
--- a/drivers/block/null_blk/zoned.c
+++ b/drivers/block/null_blk/zoned.c
@@ -160,7 +160,8 @@ int null_register_zoned_dev(struct nullb *nullb)
 	struct request_queue *q = nullb->q;
 
 	disk_set_zoned(nullb->disk, BLK_ZONED_HM);
-	blk_queue_flag_set(QUEUE_FLAG_ZONE_RESETALL, q);
+	if (dev->zone_reset_all)
+		blk_queue_flag_set(QUEUE_FLAG_ZONE_RESETALL, q);
 	blk_queue_required_elevator_features(q, ELEVATOR_F_ZBD_SEQ_WRITE);
 
 	if (queue_is_mq(q)) {
-- 
2.29.0

