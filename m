Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C55306C2846
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 03:37:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229754AbjCUChJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 22:37:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbjCUChH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 22:37:07 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2066.outbound.protection.outlook.com [40.107.102.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12CE67DB8;
        Mon, 20 Mar 2023 19:37:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nOVDDrQzXy5lx+QNVGzLm7WYdKvoJL/nl+DqHDDBnoZa2rNkajUDVouuZVLqlQuwflItEpsIcv9VshxR6zIXK16qWhOifSgCnIiQ0SmAwwfzSG8L4Nd3wTJFxUK1FI/4FUlku5CwKrEhekHVPbh2tE8WfLJoJRvMq+2UuBPavum9L+uYYBeY9J9DEM6rWuHhhC4mAlZVz55fXMGvUygrmlDjRUtk1EMJaCZwrs5cEtrTEGR4auMus4zI/7RLD71ZmAzPx/Fa7/mQ+mi2cZdzf68j+bR9ovZ/Xtm3LIXtfQZd8IylHxJOKZivUSkw77js+1SAMCFJoJn/RtqdapaGZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XsJjOccahbojjway2MR9K2kcF97x8b8KTIPgmJ74SY0=;
 b=H0Vo6KTRmuq2JRkt0FqDIeSw98NnaKnv7bnFg1s4MytUQun7xF0gfcbzmptAU9Uoe5kqPvuqwOMVjSAjdHxFWTTEvrtdjO7bB6FJvBYtdAD6FPi+beoYNimxEZS3YKjUfxZfeiyHMoHcM+J3WTqY21OUlpDmgYH42qQv3PKUTbqXKwurTvFcqekO+Jh91iaQVN67d6/ZGDxdZYJo/U400kXr87SmJWNhYpC+yvRZ+Z4JdqT0KZUEKVQVm6c1hRq8D48crW4yrj2h13U0MwIlkBeBB6ILY947/unRKgvZLVJZ7XKVt3aKQ0icG5xRI5DyuuKU+tt0HReXkmWccvbr/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XsJjOccahbojjway2MR9K2kcF97x8b8KTIPgmJ74SY0=;
 b=daINecRZGg3H8YvvbGRuMl1VJvrm+U6SwqhS7zBdPrETHaBJGNoZz2ihZ06j8hUxrhVphxBiAmh9nzbokRl9Moxf3gxOn96vqqlq2Cx8XKwl+9r1kaULuUOjoAPmeKQgsC7cQGcrSHLaliscumnkn+0KMrr9pSlYpQjkyvxMoIlvNUzMC7RHvb6kZrtoVP2uiDNmM+1c7JqSuQOb2jV48kvxZqVhDOq+UeN4elG7d0od3XRIhLNTfrvDeDzySNt41+9g4kCc0+9B8/tVNxlC7ZlN+MKCfI8ItrSmMR5QVqp6vLnutOfMWEk5dqdXKl2PSUSSycCOLGruwRXNevUicg==
Received: from DM6PR08CA0044.namprd08.prod.outlook.com (2603:10b6:5:1e0::18)
 by SJ2PR12MB8926.namprd12.prod.outlook.com (2603:10b6:a03:53b::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Tue, 21 Mar
 2023 02:37:02 +0000
Received: from DM6NAM11FT104.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1e0:cafe::1f) by DM6PR08CA0044.outlook.office365.com
 (2603:10b6:5:1e0::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37 via Frontend
 Transport; Tue, 21 Mar 2023 02:37:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DM6NAM11FT104.mail.protection.outlook.com (10.13.173.232) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6222.16 via Frontend Transport; Tue, 21 Mar 2023 02:37:01 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Mon, 20 Mar 2023
 19:36:49 -0700
Received: from 0e64808-lcelt.nvidia.com (10.126.231.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Mon, 20 Mar 2023 19:36:47 -0700
From:   Haotien Hsu <haotienh@nvidia.com>
To:     Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        <linux-usb@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     JC Kuo <jckuo@nvidia.com>, Wayne Chang <waynec@nvidia.com>,
        Haotien Hsu <haotienh@nvidia.com>
Subject: [PATCH v2] usb: xhci: tegra: fix sleep in atomic call
Date:   Tue, 21 Mar 2023 10:36:36 +0800
Message-ID: <20230321023636.771729-1-haotienh@nvidia.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.37]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT104:EE_|SJ2PR12MB8926:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d453d9d-a454-4bfa-5255-08db29b526c3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: scpH3ar7zrcG9x2vEQ+aZ59OCWTPnts1zTZ5h4A1ME4tc9levQdnyd00i/aVdO8asMqnzhTMSIA7Brc8ai249PLApsWgZmmtw74/hhRNyeZQuBc7qQ1nsTU0gastWbsS9aDSTLK8ywtoGSiQ/wj1vQ0ebNfNqevW2SZ2k/hvd0FhBqdygTSYTE51IeZxR9K7i6RZG1P2kHi1jE8Hyw6RUWKghf3b5bw6bbQPVsRBroOT9RD6byoWfQm2CVG3FlG5F+1EQtyjcC2bhCuizbDRit7L9KQQ4grOXGEqIPyA8L6azLDqdjege8mPaq55LoKPRAf+Dr3Vsu3NLgopZl0IXbhiqFUMy2Ncn8F2AtRNFxy09fJJXW14Ho1virQCAhc7WXpjavo/dUG+Nn+E4t+rn+L3HlP6/PiDNybso5Hu8R10q7xISU2kfaE2GKS6jROIFVc6Nzx0AzYQmXaCHAiLkiyBNoPZYWETxi+fa6F8TrGotsuBWAHmeBTXlJBgRIkmM6oJF5m1Ax0zPpe0uhDijDMcnvJsgTjCeWXEuoewgFeptxAGQyYe5GNBV+0/kBjajAbwzyfffYXoojtglaDhk++I9/YgHu38zAAVZG97ChcK8GVXRsX28dc9tSG61xdbQ7hQe0tDMRus2BkhGfPLIXK9UIlFD47rCrpFB0zIcMb7ucqi25sOXmeQMLGnNtplnaQvu3PBTJxMcWeXqk5RkhFL95bBBqwgoihIklXhuELRI91THJ0IUhqJ4ARReKzl
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(346002)(376002)(39860400002)(396003)(136003)(451199018)(40470700004)(46966006)(36840700001)(86362001)(356005)(7636003)(36860700001)(82740400003)(36756003)(40480700001)(5660300002)(41300700001)(40460700003)(4326008)(2906002)(8676002)(82310400005)(8936002)(2616005)(336012)(1076003)(186003)(16526019)(83380400001)(110136005)(26005)(47076005)(426003)(70206006)(70586007)(316002)(6666004)(7696005)(107886003)(478600001)(54906003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2023 02:37:01.7805
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d453d9d-a454-4bfa-5255-08db29b526c3
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT104.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8926
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wayne Chang <waynec@nvidia.com>

When we set the OTG port to Host mode, we observed the following splat:
[  167.057718] BUG: sleeping function called from invalid context at
include/linux/sched/mm.h:229
[  167.057872] Workqueue: events tegra_xusb_usb_phy_work
[  167.057954] Call trace:
[  167.057962]  dump_backtrace+0x0/0x210
[  167.057996]  show_stack+0x30/0x50
[  167.058020]  dump_stack_lvl+0x64/0x84
[  167.058065]  dump_stack+0x14/0x34
[  167.058100]  __might_resched+0x144/0x180
[  167.058140]  __might_sleep+0x64/0xd0
[  167.058171]  slab_pre_alloc_hook.constprop.0+0xa8/0x110
[  167.058202]  __kmalloc_track_caller+0x74/0x2b0
[  167.058233]  kvasprintf+0xa4/0x190
[  167.058261]  kasprintf+0x58/0x90
[  167.058285]  tegra_xusb_find_port_node.isra.0+0x58/0xd0
[  167.058334]  tegra_xusb_find_port+0x38/0xa0
[  167.058380]  tegra_xusb_padctl_get_usb3_companion+0x38/0xd0
[  167.058430]  tegra_xhci_id_notify+0x8c/0x1e0
[  167.058473]  notifier_call_chain+0x88/0x100
[  167.058506]  atomic_notifier_call_chain+0x44/0x70
[  167.058537]  tegra_xusb_usb_phy_work+0x60/0xd0
[  167.058581]  process_one_work+0x1dc/0x4c0
[  167.058618]  worker_thread+0x54/0x410
[  167.058650]  kthread+0x188/0x1b0
[  167.058672]  ret_from_fork+0x10/0x20

The function tegra_xusb_padctl_get_usb3_companion eventually calls
tegra_xusb_find_port and this in turn calls kasprintf which might sleep
and so cannot be called from an atomic context.

Fix this by moving the call to tegra_xusb_padctl_get_usb3_companion to
the tegra_xhci_id_work function where it is really needed.

Fixes: f836e7843036 ("usb: xhci-tegra: Add OTG support")
Cc: stable@vger.kernel.org
Signed-off-by: Wayne Chang <waynec@nvidia.com>
Signed-off-by: Haotien Hsu <haotienh@nvidia.com>
---
 drivers/usb/host/xhci-tegra.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/host/xhci-tegra.c b/drivers/usb/host/xhci-tegra.c
index 1ff22f675930..8dbce2cdb7e4 100644
--- a/drivers/usb/host/xhci-tegra.c
+++ b/drivers/usb/host/xhci-tegra.c
@@ -2,7 +2,7 @@
 /*
  * NVIDIA Tegra xHCI host controller driver
  *
- * Copyright (c) 2014-2020, NVIDIA CORPORATION. All rights reserved.
+ * Copyright (c) 2014-2020,2023, NVIDIA CORPORATION. All rights reserved.
  * Copyright (C) 2014 Google, Inc.
  */
 
@@ -1360,6 +1360,10 @@ static void tegra_xhci_id_work(struct work_struct *work)
 
 	mutex_unlock(&tegra->lock);
 
+	tegra->otg_usb3_port = tegra_xusb_padctl_get_usb3_companion(
+							tegra->padctl,
+							tegra->otg_usb2_port);
+
 	if (tegra->host_mode) {
 		/* switch to host mode */
 		if (tegra->otg_usb3_port >= 0) {
@@ -1474,9 +1478,6 @@ static int tegra_xhci_id_notify(struct notifier_block *nb,
 	}
 
 	tegra->otg_usb2_port = tegra_xusb_get_usb2_port(tegra, usbphy);
-	tegra->otg_usb3_port = tegra_xusb_padctl_get_usb3_companion(
-							tegra->padctl,
-							tegra->otg_usb2_port);
 
 	tegra->host_mode = (usbphy->last_event == USB_EVENT_ID) ? true : false;
 
-- 
2.25.1

