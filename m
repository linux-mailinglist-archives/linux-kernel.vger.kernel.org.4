Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D54106C2B5F
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 08:30:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229767AbjCUHaQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 03:30:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbjCUHaN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 03:30:13 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2076.outbound.protection.outlook.com [40.107.96.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 466FC35247;
        Tue, 21 Mar 2023 00:30:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UcDuHc+lFiGKddAAaq2pxoT3Da8saW13mrmypycFO00GdGXJwq+qKFEplXcXjhr68k1q978aBZfLwXWgIRuC89XCqu6r650tTkysS3aevC+Um3mhgGU8Iq1q+f4wfZ8SintsIoC7dfC/n1kuh1SEEv6VYqmk4Q0vkX5Ub0HJxaMPj/2legIWFxdTnDgawEWuTe5dXfmEKa+AcqOh9zWd9e0uUYsavoFJzcVnGzSqz4+HhgyFvPuwmTZH9dG2NaEM1P0aJbyYQ5MEraoelqC3fP5KwWJRf75TChajyTLIYydqTq4d4Lcz32hN7ihesrk2Jqgnr0G94zkVKCLoaoq+uA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gU9CjJf864Aq0/iVXS3JAav2H6/gfzdhuzbEb/K6mv0=;
 b=d/hw69fxO1VAS8rcrK0Fxq/hMT0KpJOB/ymjOxrnHoM/xyRr/3+5SFVq9ATOcd7/tIuntm7zkjJ8nMETMDievQbOVu1jWDwkre8aGV7NaPTdhsKDZjoLSDmvuSnlPS2jsLMugcc5M4AEWyRc631csMl3483XuiUeENcjemgDmaZHNZ6/Kri/zfBrpSZLa1DCnfIR/LGPRZbnHXI3MVUAfMeGBYhHWkHnazjRVTrrcVYV+SAjQAjDtjArN3rcK13w3MPCV9TRbLF7Fvir2OvA+u2BY4R6glyZaU3DqUpIAkWQxBBfBCYrbDZCsHvNzERDw9X5x65eqwe6jnRBq8iuAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gU9CjJf864Aq0/iVXS3JAav2H6/gfzdhuzbEb/K6mv0=;
 b=DJjL90wzG3OCkL6gxDQliFZyAoFVkO4t+3JRS7CimzzvYoYPmrEs670e4rmJzlW+0naQAt3T9IHb98iB+kH6kMht6dtGRV5FkmiR7JmQl1hdH83n4BzsjJBPpfzjPMU/WROCDGcPX33aTI0adBGwziN3HNQHNz4+zE3QmvF/kkyNPgnYTcTSj93+m0PzxV+Bg5L2lN2xbGOWtNcm8I1KAdT6DAd5iv/8zpZxOo8E2oVGGkuWX2yQgGiea1lxgOCTIo3abe3MjZ9h/Mya16ON+/ZqYNmKRpHsuirzgZ5K0mz/ZlBzaHZFazgKNS7ak5TrGFnEA78md6Bl/9nNYL+gSg==
Received: from BN8PR15CA0019.namprd15.prod.outlook.com (2603:10b6:408:c0::32)
 by SJ1PR12MB6268.namprd12.prod.outlook.com (2603:10b6:a03:455::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Tue, 21 Mar
 2023 07:30:08 +0000
Received: from BN8NAM11FT069.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:c0:cafe::c8) by BN8PR15CA0019.outlook.office365.com
 (2603:10b6:408:c0::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37 via Frontend
 Transport; Tue, 21 Mar 2023 07:30:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN8NAM11FT069.mail.protection.outlook.com (10.13.176.152) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6222.16 via Frontend Transport; Tue, 21 Mar 2023 07:30:08 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Tue, 21 Mar 2023
 00:29:58 -0700
Received: from 0e64808-lcelt.nvidia.com (10.126.230.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Tue, 21 Mar 2023 00:29:55 -0700
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
Subject: [PATCH v4] usb: xhci: tegra: fix sleep in atomic call
Date:   Tue, 21 Mar 2023 15:29:46 +0800
Message-ID: <20230321072946.935211-1-haotienh@nvidia.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.37]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT069:EE_|SJ1PR12MB6268:EE_
X-MS-Office365-Filtering-Correlation-Id: cfceffa8-6313-4854-41c9-08db29de1904
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SndbQ2iht6+UNe59p9103bfRdi3xSJVbat4RAm1vt7xFprHdUU+y0Xs3Hwis0Ntr4rnyFZTgDrWiJw06Tt/K1hB7TylPgyOvCAk1KF6tzRFAoe/6KcrJ48JKwOkpaYhdEAZwQ7S7YjpSUk6sDpqXmBiaGSy5n+92mylG0/32kLc23vzqDk/8AORbpxF0drYPJq0VQjb/CUnctbpxRY9bptR4pcmUilMoPhAhSwPXftsjgJsK0y83pZXOIX4xvMkOKudqrxZrO6TA6kN5IT446Dn5+jFiMnfSRkwpTy9dj0WZMCsWkJUH7+B3TEjv6HgsCW8+cvfJUOEeqCkGoksx52AIqNBfX6OXOrEQtbBhbSRigRKuXky9v0zXR6p2XKxCIIDYJBXmDDB23abWx7q1/dpE9u4rgBxGn7QNex5BHW+tBKrjnJmePPLHG63zEl5NugtFTCczuLctESKmyEy7Qw0ihh4jd+0YdEVZkxpUdruE4LDplN2O+N6+eqEMGW2yVnAOjPJYtI590SfzpGS2fBlXqLuUuOhZwKFnw5IQh8T3Kqy+hIHtlQFBqpiZO2mrxP80mmaWE/Kl2B/tR4QC24tSuyAcqko7up5Foymj26sU7l3pbdo9VwDqB8Dss45VbWX4KDlepwIyhVBKeefM7QPHQhGugIzfKvwJVu/Mn5rttBdd5AG1A0/lS6ITpOuco/Aalv0N1RKwzeitCtEs4Pajr7XZ24PqA+Xy+H81DfBV2cKZ8bfRAoHLvI6agIIF
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(376002)(396003)(136003)(346002)(451199018)(46966006)(36840700001)(40470700004)(86362001)(40460700003)(36756003)(4326008)(41300700001)(70586007)(8936002)(8676002)(54906003)(70206006)(5660300002)(478600001)(110136005)(82310400005)(2906002)(26005)(36860700001)(356005)(83380400001)(7696005)(6666004)(107886003)(40480700001)(316002)(426003)(186003)(7636003)(1076003)(47076005)(16526019)(2616005)(336012)(82740400003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2023 07:30:08.0213
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cfceffa8-6313-4854-41c9-08db29de1904
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT069.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6268
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
V3 -> V4: Remove copyright change from this patch
V2 -> V3: Add version information
V1 -> V2: Add "Fixes" and "Cc:" lines and update copyright years
---
 drivers/usb/host/xhci-tegra.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/host/xhci-tegra.c b/drivers/usb/host/xhci-tegra.c
index 1ff22f675930..b40e897ec092 100644
--- a/drivers/usb/host/xhci-tegra.c
+++ b/drivers/usb/host/xhci-tegra.c
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

