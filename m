Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8C4F6F6494
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 07:55:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229723AbjEDFza (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 01:55:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229706AbjEDFz1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 01:55:27 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2084.outbound.protection.outlook.com [40.107.223.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDB141737;
        Wed,  3 May 2023 22:55:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nFGc3OXTK3iEDZr/Czg9RoD6CDTwXtfh8hk8Oq8HgOYG6HN8YvnQecqzk7za+B6ospyNEIy0P8Qx/peecEFZFTZyw+bWpvdZ6ChrGFsXClGnKf1+VPqh+HV9NNM/giW2qI3ZDCztLJfcR5iN7BizhMGxXRywXSmXZO0W856etAGNhwBuqYJawQ4BzKj1HMCybl090tFWfg+8F6PLgMR3CDkuID7ATRucrtsFrDJ2RIU/Q8qUiVKg25/xASimlDDjp/94NrakCg+mGN9sChisZs/lA5Q5zHOKItDtl79HRhCFS7Q7MJEHjfNltc//SAmbhNbfCElGcMtJT5oLovaWPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fsk3/RldXT2w9iuRaYKD1M5QGVxMavvlE5HZXcOCnZU=;
 b=EonBbsd9+JMqOzdfMshG2XPZtsouAe9od5hCBNvgstI2GRxwH9ia+ujgcBW0bQpqNUfGir93xzTCdYquemXr4XOuHQT6IXLH/15PczS/v9/Eoc2cklUMr3M2rlRl75UtrKSZOpM7Y01DHDweKKSCPAkPfe1dfIX6gW/5gtTjWAkOGZc9Jt6vyiSAls1eQ9bKi+84+owxACM+2eFSqHMATxj6cmOT+7FG6hL26SQdV+H2HIHSx44uPP2reJlW1r7RWbz4tp4owuqYna/J8L1WSNsMm16o3UoD7S3v6sqmWgpYmb6Loc55JIuhlljnl8/EF6K6m5eskDfCyMfMR2hIIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fsk3/RldXT2w9iuRaYKD1M5QGVxMavvlE5HZXcOCnZU=;
 b=rxiFiLZwuDVdqSKtn77CsxdME0RRoRb/d13o9qQzvZDwKuwOWg8Vk7/tQHRT2g5A7WGUF9FKKy8/DUQEMqeVCj6L1ZvEgxr8zge/cNjFl0l2yjbWNa3UleB/biEsGUzO5YSUcruXbSguouEMnV4O1Hc5nP0Dmxvj3uguf6SXAkyQ7Fg8UyfVg7EKynPH+rT2KUA+Zr5a8HFAa/DU7pkw1te/3NSbD3AikjiT2yrrXNpFFrgB4XdiuR5O9YHqN2FUf7ToT3X9CTZq4DU7jBjyND3cP5zG/3u4SeygEnMqpkwxuC2EdXpeq9wS1DiBD257bCg3qFcOgyJo/aLOap1mhg==
Received: from BYAPR02CA0012.namprd02.prod.outlook.com (2603:10b6:a02:ee::25)
 by DM4PR12MB8474.namprd12.prod.outlook.com (2603:10b6:8:181::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.20; Thu, 4 May
 2023 05:55:23 +0000
Received: from CO1NAM11FT073.eop-nam11.prod.protection.outlook.com
 (2603:10b6:a02:ee:cafe::e0) by BYAPR02CA0012.outlook.office365.com
 (2603:10b6:a02:ee::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.26 via Frontend
 Transport; Thu, 4 May 2023 05:55:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1NAM11FT073.mail.protection.outlook.com (10.13.174.196) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6363.26 via Frontend Transport; Thu, 4 May 2023 05:55:22 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Wed, 3 May 2023
 22:55:09 -0700
Received: from 0e64808-lcelt.nvidia.com (10.126.231.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Wed, 3 May 2023 22:55:07 -0700
From:   Haotien Hsu <haotienh@nvidia.com>
To:     JC Kuo <jckuo@nvidia.com>, Vinod Koul <vkoul@kernel.org>,
        "Kishon Vijay Abraham I" <kishon@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        <linux-phy@lists.infradead.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Wayne Chang <waynec@nvidia.com>, EJ Hsu <ejh@nvidia.com>,
        Haotien Hsu <haotienh@nvidia.com>
Subject: [PATCH] phy: tegra: xusb: Fix use-after-free issue
Date:   Thu, 4 May 2023 13:54:46 +0800
Message-ID: <20230504055446.2039372-1-haotienh@nvidia.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.37]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT073:EE_|DM4PR12MB8474:EE_
X-MS-Office365-Filtering-Correlation-Id: fd61de34-4801-4e18-7a2d-08db4c642666
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rQQbkk86WQhJGI+1vc0yJ4/SYAENJExcah2CQqB8FRRcKTQn6L8uaUZ38xuNeCzHrH3BrFOkvjek8ZelAvvPwx/BIz3VwjMMuuBI+fOBgXh5qRh4734a6Yb2TpQoqN7aKUCosCLXJbUTBDgADjRSVLSLJA9ag7bnNS48FbPZXRbhMq1kbTNMCTuBSgeVfrkRSOCnjaXkCBUm7o3tArZrp7amFYQP2f9FcbHKAN9gX7q+BPZepNFlmmXRXtkSstExhW5SZRpJjqYe+RMPiZZQ9w1C7NxwfKXJF9fPNuH3O1ZPfa+ACAtWteV4qnMGTLEf4+HU6ntigbRK9U7BfptADYnDmDOBkFXxDohngqfNyIRjBI26NUCCRXQ2lKOAqkv0bHM6yI9MTZIUgE2NjSpfx1mjRjlJ+Spfe5NGe+OSuiDUTgKajy5rCwQ31ewCrgRyz5z6ZVm42cXnyDmIKLdePHcCnsn9QfWQDQ1PMhs7b9D40q7fn0+GGsNYr8RvbC+D54y41FKIsgCN/jGWwD23PFMFunHJdZ9vxqRglmMm0++eYL0AUFJP6vw70m/iKhoZR+n/dXr5ODf60rvppIb80IAlBx+R1pvSeYdbAwCTUZ88MpRVxlOnc4g1PEGzjJOiByunHSsbUECoQBqYVmLNfaWe10bhtc+95ZkSPh2+hczHmdw5wi+ZMUWtqnuQuSXXeLHmG9feHj4S9pIexD/WSVtmNSugqHTTplmIw/7c7w8=
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(136003)(376002)(346002)(396003)(39860400002)(451199021)(46966006)(36840700001)(40470700004)(86362001)(36756003)(82310400005)(2906002)(40460700003)(40480700001)(6666004)(36860700001)(47076005)(16526019)(2616005)(336012)(83380400001)(426003)(1076003)(107886003)(4326008)(26005)(186003)(54906003)(478600001)(110136005)(70206006)(70586007)(316002)(82740400003)(356005)(41300700001)(7636003)(5660300002)(7696005)(8676002)(8936002)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2023 05:55:22.6810
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fd61de34-4801-4e18-7a2d-08db4c642666
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT073.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8474
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: EJ Hsu <ejh@nvidia.com>

For the dual-role port, it will assign the phy dev to usb-phy dev and
use the port dev driver as the dev driver of usb-phy.

When we try to destroy the port dev, it will destroy its dev driver
as well. But we did not remove the reference from usb-phy dev. This
might cause the use-after-free issue in KASAN.

Fixes: e8f7d2f409a1 ("phy: tegra: xusb: Add usb-phy support")
Cc: stable@vger.kernel.org

Signed-off-by: EJ Hsu <ejh@nvidia.com>
Signed-off-by: Haotien Hsu <haotienh@nvidia.com>
---
 drivers/phy/tegra/xusb.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/phy/tegra/xusb.c b/drivers/phy/tegra/xusb.c
index 78045bd6c214..515298a9a433 100644
--- a/drivers/phy/tegra/xusb.c
+++ b/drivers/phy/tegra/xusb.c
@@ -563,13 +563,6 @@ static int tegra_xusb_port_init(struct tegra_xusb_port *port,
 
 static void tegra_xusb_port_unregister(struct tegra_xusb_port *port)
 {
-	if (!IS_ERR_OR_NULL(port->usb_role_sw)) {
-		of_platform_depopulate(&port->dev);
-		usb_role_switch_unregister(port->usb_role_sw);
-		cancel_work_sync(&port->usb_phy_work);
-		usb_remove_phy(&port->usb_phy);
-	}
-
 	if (port->ops->remove)
 		port->ops->remove(port);
 
@@ -832,6 +825,14 @@ void tegra_xusb_usb2_port_remove(struct tegra_xusb_port *port)
 {
 	struct tegra_xusb_usb2_port *usb2 = to_usb2_port(port);
 
+	if (!IS_ERR_OR_NULL(port->usb_role_sw)) {
+		of_platform_depopulate(&port->dev);
+		usb_role_switch_unregister(port->usb_role_sw);
+		cancel_work_sync(&port->usb_phy_work);
+		usb_remove_phy(&port->usb_phy);
+		port->usb_phy.dev->driver = NULL;
+	}
+
 	regulator_put(usb2->supply);
 }
 
-- 
2.25.1

