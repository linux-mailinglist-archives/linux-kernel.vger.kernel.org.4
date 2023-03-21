Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B68C6C2B20
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 08:14:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230303AbjCUHOM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 03:14:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229683AbjCUHOG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 03:14:06 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2071.outbound.protection.outlook.com [40.107.100.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80F4EAF02;
        Tue, 21 Mar 2023 00:14:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B1lw0bF9qft58cNN6QJd4YOO27IQ1pWYZbbF0DlE996wp/5CI4BKgdLf/xC5vPV8u0CEpzqH8r3hLFOswcsoRf4low80/RqePYqXMmbsbp2nNE7AeHI3DIddpEDu2bciirBodl6Zs9o3IY55+gFtpsdrgvx0wgrLM+sOM6oSSQBXJuTIFB6B9+SZZT0siitIY9HgkKcEshY1HndqMcgVyxj0VzdxlC0sc9daV7ahnzJ7/lZbOTh/MZXK/lz2opLU0NSwv9eXQ1m9v7W4r/3ObXomQc7+J+VklNmc1qNpPrXZGiSWSp1yCevYxTeIqMIlNLIMYa+0kNERIQz0QuwbaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qOIL8vt0Sc8cINGcpV1mPAcyMa+zjzRomlfvWqZPtyQ=;
 b=PdxzCl3o2I7Hv5m2jpMFhOd8i/vYI1pUm2am5Ica1epalWvegLMs+kgz08/1yqz0d0qXfpA94/yY7EDohDD8Cx0Oxy68w9t7ehsdiFZJq7ej2byssWDy3JHaOCzIHQwbJmlRu0DT9xCe7COSYRG1X9IrPUflsut4Ri8YUmBoLRIaijYNW3PGlcWf6POTUnFvNa0FqHNhzZqCRuUD5qhQbM0G+9XibaY1l25h294NTJm/aYx3O1mWYTruxqb2NZbT8asatTm3sFiATPn0V7YRP2XXzF9+ORDsoOpTJTOLQFCrwdFdiEpOZWKuHPkmH1uRXUQ9h1l1Qbw1MkhXYE5fkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qOIL8vt0Sc8cINGcpV1mPAcyMa+zjzRomlfvWqZPtyQ=;
 b=t2oLDkVxb+ibBZ2VrtHk/8JRGFQetnQfpqXRLDBbAvuJXOcGM+AkVuf/tWZ06JK7NCLNLfPCiCH+RJpueJVmf6TS3Ugkv0JSPl5eqGUMFxYMExk2awtMDZRNbGE4tKWBcGyjYJ5YbHCci0v2+9XlmlXQeceh52HUOgNnpvXSL6PvRmxPmNH82xI6MlxtdrIed9GFvGmDVtcL2Ucla38OVF9onLX7SgehEQn8PSILpEGGQl8MNXLnsNhvfei9apSQvcJysjUE3RRVp1/id7iBuMG4TNntEFXL2f7KFlyx3qXISCwtTQ1COoEp+wXxL77tDqftDTze7HoYl2+EHMUj3g==
Received: from DM6PR01CA0006.prod.exchangelabs.com (2603:10b6:5:296::11) by
 DM4PR12MB5151.namprd12.prod.outlook.com (2603:10b6:5:392::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6178.37; Tue, 21 Mar 2023 07:14:00 +0000
Received: from DM6NAM11FT048.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:296:cafe::90) by DM6PR01CA0006.outlook.office365.com
 (2603:10b6:5:296::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37 via Frontend
 Transport; Tue, 21 Mar 2023 07:14:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DM6NAM11FT048.mail.protection.outlook.com (10.13.173.114) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6222.16 via Frontend Transport; Tue, 21 Mar 2023 07:14:00 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Tue, 21 Mar 2023
 00:13:51 -0700
Received: from 0e64808-lcelt.nvidia.com (10.126.230.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Tue, 21 Mar 2023 00:13:48 -0700
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
Subject: [PATCH v3] usb: xhci: tegra: fix sleep in atomic call
Date:   Tue, 21 Mar 2023 15:13:39 +0800
Message-ID: <20230321071339.925636-1-haotienh@nvidia.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.37]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT048:EE_|DM4PR12MB5151:EE_
X-MS-Office365-Filtering-Correlation-Id: 128b98ee-bda2-4bc5-1ebb-08db29dbd84c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nrnWnt+feXPxKF8sZPW+fJzi1EYreEUmwIBVzARriw267EDwyD1QkEKTyvxjY5/z9OZTWD3S+EsoqaIGRJx6ax4lxEC/l3eIaZIU8t9pQs1HxNx6C0W8V5Avmk/QeV1Xf3du4F3fX26iWMjAslpwbaQ9285amE6/XL+3kPjOJ+ysJ/BLATqRSwTP0uiVmpFBO9rOGQsEsfBwLnhjEtSsiCZb/WTf4nuceCK4Pc6QPKeXYJhRSU3p+5p+yoM9nL9KQ7dsrmJYLAtY9r2wHlSQ2b4N/I3Mb6J892IprfoCx2Gy0mOtbagfwwtRXTrIx1A1otc9RMhuwGu3qR/YmiGEIdl9eOhAw1L/Z3zPSPDDR2LFXQ/uIE9JIGEYDqKfJXONNajwT0hxdlWLGv6a7gkglu5FqkL/SUKhVITlN4I1Fav6UAF8Gkp3b/c1y66j8mihXBC1P+rvVkpgDKUYL7/uG8OmPPwAfFWIHmiFOamxA46qfsnqoeACVvVRkGk91KiSCYwkhbV7/CeLoC+8A6ya6UJoN89Yy1+zK2H1RP5h6pkLHlijKFZnmc5FUbjernSeDdeCUsh8p4aKDPeMk5ifzyOUkBwf1foGdpQBBFyAEY81ngRd8RyhQa9NRvPGlDbThIYGaT+Liio9Fg2RzqLyD86ZWTQL5Lkt20Fufs9zoADFsa7kBqpy0vsBzcaFzxPLIqV7Y2nvPY9KyMd8r+H5FSODvgMDcJ1rqwR1xvMvvmpLN99/reSkVsmkP6Gyro9+
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(136003)(346002)(376002)(396003)(451199018)(46966006)(36840700001)(40470700004)(7696005)(82310400005)(83380400001)(47076005)(2616005)(426003)(110136005)(40460700003)(7636003)(86362001)(336012)(36860700001)(356005)(54906003)(40480700001)(82740400003)(8936002)(41300700001)(8676002)(36756003)(70586007)(70206006)(2906002)(5660300002)(186003)(1076003)(4326008)(26005)(16526019)(316002)(478600001)(6666004)(107886003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2023 07:14:00.4938
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 128b98ee-bda2-4bc5-1ebb-08db29dbd84c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT048.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5151
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
V2 -> V3: Add version information
V1 -> V2: Add "Fixes" and "Cc:" lines and update copyright years
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

