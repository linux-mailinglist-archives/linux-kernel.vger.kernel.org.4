Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EC2B6CA09B
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 11:56:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233243AbjC0J4W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 05:56:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232307AbjC0J4T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 05:56:19 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11hn2200.outbound.protection.outlook.com [52.100.171.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E205A49DD;
        Mon, 27 Mar 2023 02:56:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dyVO74EyXsChydjFvWspkbsDzIAAV3PMZh6eLxdLfb6DOG2nkKINI4M217JmwyQpj+Oq8Nq2wjqUtizqHm4xPrgpY8HYMLMKpQKj80ULB1sKlBN5vYnE2/3N/wMHVfI4DunGL59ky7XEU5wJXcpKnkmsuUzyCn850H9YArAWpxCVtP86ugIFuA5rqmi8bGFbcPgbaEPZJBA5sCxi01E4PfrCWSWIq/GucalkwUg1z9UCc3EV6nzOpfaDIMS4n1nC+S7ovS8Bha2amsAd4ndgXQDA124e2wQ/t2tYoBg+4RurrUolhEcC0Udi8OiYcpzp54S0sl7O/uCz8dCV6Un2Zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7plBS8a5XxvCxm1FqZtDJDHWgxJ4J4W/dpZkThQSBjo=;
 b=PnPG/00ppXNSfZjkmge2rBXGSXdB8cQ8O1q78TI7tsBrmfl2DcQEErybbxMLtFicF8lWnmIPZ+yliblgW/Gqqs95nbLyqeMAPNPY7R0TY9xLmzq+nyCCAlDkUE37oJEi8EHVX1SRl4rSmwWxTaj1hQB8CNNNxLSVC0O+aMvXqbOMciTLdbNBiX5H3HaS5ir4pH2gummgDuW+j7OI5XhbLHIzuogkPqGTBXGcLQdTCp/36vxi+lx/okujgHXFx+GOs7f6teTyAVa4UVBl93jt3LA8JBFDyUxac1KfxtcN8nEASv5zCFFVbCG06Q/QWwNCK+LjPdy6iEnxrXU0yOMlXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7plBS8a5XxvCxm1FqZtDJDHWgxJ4J4W/dpZkThQSBjo=;
 b=Lzr2wRD8cQoShNkDziRvR97l+82hJMzrk37WLOqGbAr9K+5q/efi129RAH3m3PrvJATEKucXTBrl1mGKzSf0xBCgsiXuGwEz1BdzVb5OMzYRu8h0jriWbod4yC4KJxNsny5m6aW7jMRYnDSEED3ZWl12rb9xVot8umCQ5X6rGHoQDuFFW05Tz6MXubcQRDJ4HoXBhyIW7gD1rLhWdaIqQxzsnNL+p2D+ce07JA8IxWU7SoBrI+w64aLQm9lAnTZvgs7ZoZEEJGfSwueYW/e2vny1UtYRQ1SGU7fquX6z3WiEx/b+Pi4jc1Q7AQBiMGokcS3yNj4xWj7NNYRs4/4giA==
Received: from MW4PR04CA0229.namprd04.prod.outlook.com (2603:10b6:303:87::24)
 by SA0PR12MB4589.namprd12.prod.outlook.com (2603:10b6:806:92::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.30; Mon, 27 Mar
 2023 09:56:16 +0000
Received: from CO1NAM11FT084.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:87:cafe::e1) by MW4PR04CA0229.outlook.office365.com
 (2603:10b6:303:87::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.41 via Frontend
 Transport; Mon, 27 Mar 2023 09:56:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1NAM11FT084.mail.protection.outlook.com (10.13.174.194) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6222.22 via Frontend Transport; Mon, 27 Mar 2023 09:56:16 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Mon, 27 Mar 2023
 02:56:01 -0700
Received: from 0e64808-lcelt.nvidia.com (10.126.231.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Mon, 27 Mar 2023 02:55:58 -0700
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
Subject: [PATCH v5] usb: xhci: tegra: fix sleep in atomic call
Date:   Mon, 27 Mar 2023 17:55:48 +0800
Message-ID: <20230327095548.1599470-1-haotienh@nvidia.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.37]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT084:EE_|SA0PR12MB4589:EE_
X-MS-Office365-Filtering-Correlation-Id: 79f2771e-5235-44eb-013f-08db2ea9819c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HupJ8ORFP7ZyXF5S/YM8GVlUgYwTB5CRjV60Noh7faTXG8UOnlHUOD0ILV0VjPTeLFfrtubj7ElEPaSvcXq3raRoFXC6DZ6xNoq4lVB2TwdclfNZQzg4YcUl6rVeM6UCFXajN417ICZ/ISMqoMtcvyC6C1a/reiUGVXpY6sCrVQXlNNbw+emzrWTRN+JciQEBjNg4JmS1e44StKQIx5LYxptk/aIFbjNTn6y+PMImzlpjEXKWG9li2PqZHojgpHnMmx5iYbbqUjJ5tc7GAUFFOR3k7EPJY5zv0iCwBGxP+WlJJ3r00AqJlHmbofxa8uNJfw9qyWjexUrwx8hpp+H1p+U8FcY+foM5t/YIQ2Td7aDp0KXxOsl6RLLLCBwpNV/LRw+OsrD9Er0IVzVGO79GR6t3ozQbuReEqAUD/CtbW/4ySSTJXX6/KeLo0D+GXXpOcJF3JiXFIZpXr0jF0Ufh8rS0Ut4XzYDq5fuBHsp+DpsIoqSae1ffRBEKAfe3+ff86AzJp0zazX4Vbw1P07oIjJA9cGtA0/XLAF0TUr8FBoKcnpKnRQuDo9rDpXE9GiRsT8E7qlNO0jo0i2DjxBMKs9xPHIwdk+dg2jf4dv1Jysyv8JoFGxegQ8DN8hxETZ32VgPInQfxs4OFNw7DbxIMLwjt3f6u9dWhzlmhidcIdi6AXog5KnicGPjt2IHe+uGa2nfGbnKwY6/VKkoOlepmG4G95voobeW409zEXLynMCxM3/eZGCEK8wswYONKEoK7z0WUcjLvve7QTBWgwP1ayqVY6X1hddTab8gChBqmfnCx4vk6Pbyvatfcs4MBptX
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(136003)(346002)(396003)(376002)(5400799015)(451199021)(46966006)(40470700004)(36840700001)(1076003)(26005)(16526019)(40480700001)(41300700001)(6666004)(186003)(107886003)(7696005)(83380400001)(426003)(336012)(2616005)(47076005)(478600001)(54906003)(110136005)(34020700004)(316002)(36860700001)(40460700003)(4326008)(2906002)(8676002)(70206006)(70586007)(7636003)(82740400003)(356005)(36756003)(82310400005)(86362001)(5660300002)(8936002)(12100799027);DIR:OUT;SFP:1501;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2023 09:56:16.0017
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 79f2771e-5235-44eb-013f-08db2ea9819c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT084.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4589
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wayne Chang <waynec@nvidia.com>

When we set the dual-role port to Host mode, we observed the following
splat:
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
V4 -> V5: Update commit message and code layout with 100 columns
V3 -> V4: Remove copyright change from this patch
V2 -> V3: Add version information
V1 -> V2: Add "Fixes" and "Cc:" lines and update copyright years
---
 drivers/usb/host/xhci-tegra.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/host/xhci-tegra.c b/drivers/usb/host/xhci-tegra.c
index 1ff22f675930..a88c39e525c2 100644
--- a/drivers/usb/host/xhci-tegra.c
+++ b/drivers/usb/host/xhci-tegra.c
@@ -1360,6 +1360,9 @@ static void tegra_xhci_id_work(struct work_struct *work)
 
 	mutex_unlock(&tegra->lock);
 
+	tegra->otg_usb3_port = tegra_xusb_padctl_get_usb3_companion(tegra->padctl,
+								    tegra->otg_usb2_port);
+
 	if (tegra->host_mode) {
 		/* switch to host mode */
 		if (tegra->otg_usb3_port >= 0) {
@@ -1474,9 +1477,6 @@ static int tegra_xhci_id_notify(struct notifier_block *nb,
 	}
 
 	tegra->otg_usb2_port = tegra_xusb_get_usb2_port(tegra, usbphy);
-	tegra->otg_usb3_port = tegra_xusb_padctl_get_usb3_companion(
-							tegra->padctl,
-							tegra->otg_usb2_port);
 
 	tegra->host_mode = (usbphy->last_event == USB_EVENT_ID) ? true : false;
 
-- 
2.25.1

