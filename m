Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 986AA6C0B84
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 08:41:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230160AbjCTHlT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 03:41:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230169AbjCTHlQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 03:41:16 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2079.outbound.protection.outlook.com [40.107.244.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F2F622DCA;
        Mon, 20 Mar 2023 00:41:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EUF+KsUROMNBjNBm2BAekdNRegFL5E0pi/vSmHeQRk+aSUjCeBFFWljTYYdUfjpMh5l0blEmullnmv/A+YrP+a2hzJJUBmJljczVfHGZ7sFfcSk/OiOuD0F8gYPJsFANTWmRCXkSoWfssmT6EWjUBBIX07e5oURl9VONY2SiGFXs2pWaZA8zpgKGcPZue8BK7++gythb7VxBQXi4J3C3mwRcuFsOE52DEtX3pCa5tAgSA4ewefZ9pdkZWdqgiAlCLnv5W60d7wibwX4Jpq2Oh3u3Yr2oA2dH2rTSnYBkbpj5xLkwDfRQDtSomzC8vwpJxvO5DVeWQmSVuW9NO6YCow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QSxouwOK2KkL7KaaL1BE4ocUJWENL04IVm0JkGJ2gHs=;
 b=hp6M+yi763fmZ99V94qyiUk37oIBTA4JHgtteuCU8YrIgdZ1TT7xA07IeAlkJQEtCRt6F0Q5kqQ2lnpXme1EF+6iKbqN8ZNs74YpZ5eG6zjl9daeOjY+eue+zuCXj9KqXmFNBue/FHJLG79WQCVIVhVenLMPqpQvsXbudX7cfikSxRQkW2PhCTr1xEDsZ6hB9KPvRL8N/sSHDpRpdF+VqlwgVwm7QgpnHPvWJs+oBAkb2pfE4r//gxi/aa2OUw4hkXTSaxwiNux9VNx2CktYhejWzJXdzDCaHWSX4j8qMl2VhycM7Jvh6gpf9PsxIGgC4zoY/9f/JcTu61yAX+S8iA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QSxouwOK2KkL7KaaL1BE4ocUJWENL04IVm0JkGJ2gHs=;
 b=hD/s0dxcgUbQw7P595qBek4fCZt/z7s3z2KNBlVMQYuLD6qYMujYhOM2ivs+TIoYJ/0hU0UDYh5Bv5MeQR0EI3bwohGsqd7Hkfv8OFkMknagyOlh5eWISww3uyxvi8RTvewOX19lv6Ada+19UrNpBGhs0vexQ9Msa6Cq7k9sLJ8Z7fDpfFIJzxQ8c4QGZCRlN4bEmL0YJbpU3LZbH/aHle2u24tGJyQ2EfjXzOIf8RxAw3kgiUqhZWf7CqBs0ZwSsZN74+HLnLQWsLGdcHfPt4vjtYiAqFjVbYDDYnYr1DmOiz8hXEvW6SX2PHpEt1lArUhMytt5MlcmFLHAyxr8Ag==
Received: from SJ0PR05CA0196.namprd05.prod.outlook.com (2603:10b6:a03:330::21)
 by IA0PR12MB7530.namprd12.prod.outlook.com (2603:10b6:208:440::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Mon, 20 Mar
 2023 07:40:54 +0000
Received: from CO1PEPF00001A5D.namprd05.prod.outlook.com
 (2603:10b6:a03:330:cafe::7d) by SJ0PR05CA0196.outlook.office365.com
 (2603:10b6:a03:330::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.15 via Frontend
 Transport; Mon, 20 Mar 2023 07:40:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1PEPF00001A5D.mail.protection.outlook.com (10.167.241.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6178.30 via Frontend Transport; Mon, 20 Mar 2023 07:40:57 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Mon, 20 Mar 2023
 00:40:42 -0700
Received: from 0e64808-lcelt.nvidia.com (10.126.231.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Mon, 20 Mar 2023 00:40:40 -0700
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
Subject: [PATCH] usb: xhci: tegra: fix sleep in atomic call
Date:   Mon, 20 Mar 2023 15:40:28 +0800
Message-ID: <20230320074028.186282-1-haotienh@nvidia.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.37]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF00001A5D:EE_|IA0PR12MB7530:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b6a5a82-163f-41ba-e10b-08db2916719f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mV0+TZtKd0m2Qdd9M/g6ONm8ik1kIxfchFWs6AnghiiBQ2uxfMvzlctArTLSdV+d28zDT9rgrbe9ToGrMckAtNcTgnM7rR8Ib5apfqG6tk9OBTdhCqHZVwIaoOO/qu8fH9/3qHXXght+b04UjGE8VL/Oa5PkdNKwPkZ7FXhkcyr4yvqParBPft+UGcw5dn0+zijmWjP75gctsImysrvBg12jKdEtTd2S9H8ZCiC8iwScLMm86cpI1rwXnX20ZssK6JVz08I32QvM1BVc9J2gzITHSm9XmHx7d0QiGGKvIT7Z9PV1nqqKH6W54CwT4tcbG+ZWA0nByvz8U2zJCcbt8xwF0rBJadYN9DXRS0KbpPXSz6xVaeXoEj0EdOcOFQ4Dt5tKAyDpBvHfzhQJ3ud8h4810aNJYOKUotbh/VeIauohxrvOzVX4TjIO4NJLP9GUqq2AZ55SvY6SKM5lHiUzhEfRiGKIzq++idBQoHNUiT1XYqm/GfJTsyefUlVCOjY2EwvDy33LFO+g8ehOYbvmMilbWhLzjluanIpMTnL9wKN1dFbvBV2tbE1ehDC4TTDAp0fcfvAlHD2AKkV8UOZ7yB5MsdYsk1WdfxdoJDqdHSD8mrMpHb6mScS+17egc7eh1v371XDWPdRc7uCDGpyLMJHrwLIeeSvuMmaPt9ohrblAEdQJJ1iGkEWpb89m5ccwPPhRi7HgikQoseMTV8XtHsF4ypDXRPiwVDnOwXXAdPR0c/3CpBcK+ZOuBHEqQRpc
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(396003)(136003)(376002)(346002)(39860400002)(451199018)(40470700004)(46966006)(36840700001)(2616005)(426003)(478600001)(47076005)(7696005)(336012)(83380400001)(107886003)(6666004)(316002)(54906003)(8676002)(70586007)(70206006)(186003)(16526019)(26005)(1076003)(110136005)(4326008)(36860700001)(8936002)(5660300002)(41300700001)(40460700003)(82740400003)(2906002)(7636003)(356005)(40480700001)(82310400005)(36756003)(86362001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2023 07:40:57.4130
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b6a5a82-163f-41ba-e10b-08db2916719f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF00001A5D.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7530
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
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

Signed-off-by: Wayne Chang <waynec@nvidia.com>
Signed-off-by: Haotien Hsu <haotienh@nvidia.com>
---
 drivers/usb/host/xhci-tegra.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/host/xhci-tegra.c b/drivers/usb/host/xhci-tegra.c
index 1ff22f675930..af0185bacc70 100644
--- a/drivers/usb/host/xhci-tegra.c
+++ b/drivers/usb/host/xhci-tegra.c
@@ -2,7 +2,7 @@
 /*
  * NVIDIA Tegra xHCI host controller driver
  *
- * Copyright (c) 2014-2020, NVIDIA CORPORATION. All rights reserved.
+ * Copyright (c) 2014-2023, NVIDIA CORPORATION. All rights reserved.
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

