Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81592728FF3
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 08:30:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237874AbjFIGab (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 02:30:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237860AbjFIGa3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 02:30:29 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2053.outbound.protection.outlook.com [40.107.244.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B1FD30D7;
        Thu,  8 Jun 2023 23:30:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NPA4rg6XzOgOmjXZvLHvcvAPjH8mb2FYlScVQDLHZx0K+Witb/rz3L/pMKgRPDKjGOBefESPp8dHjeIBMDe0CDHK4OxHsUEjALl3rizcgn/db3h00iY6F5ZX9XmiE8NoHrPbRsVV26TNTbLCKfr4G0mI9AaQJxlD0FzGEH0NPeOv3013BJ2kHI1bjMfzKPQlRhNMG6M/w3I2jG5VaSulFOT7dJbmJ3RynV6eEKaPss7xRNlFHymFRgqSnpV3ZtUA841/FHu23ahOE9kuS8BvB+LoN2tE+FNz+FcMSYPyR/PXUGiay5coMZ7B5OEENVwo/TPhdJtdkCiXd7YaLKTf/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ec8AdBwdEt64Hu/iVLQ8IB4m9QQq9B6IJ6KDhutYwkU=;
 b=NLm7SHZ6NGPMYnHZf+ZgzwwJtQAcF/pVOUnHIBO9AdmYRhMFTO7CXFKzwVC8rBDcKHD3XcYWYaA7ooOEovHjldYKMVs9vJcl9OejIYfbF4CA0Cyb0KDwnCgwN3o2O1Hk77tJ/SuSNoCmwJd9kNyllyrnoiAQbHUB61kiMRugDhwEJhfsYWr7MHJkc61AhZiiRfmQgG990bofE6qs6WAs+QY7PXOKMkUq/EXrHU2v2IJEHo+TMi9sD8GoCvtbRXAjmPxw2YBgBs6J31OHsh8pZ6BjGNxqN3J2cjqu9qWQxlo2qQoIV+o6mBGwA9cryY+3rZyM0Jb16VeQsWoD7gJ+lQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ec8AdBwdEt64Hu/iVLQ8IB4m9QQq9B6IJ6KDhutYwkU=;
 b=KZNf8uDb7sCOlJkwALmCTe4Mo4rwMgQLWHf2YEHWx5XrDrwatgfg29dAljkHbdD+aGkbpWqt7bfA1+Mb3e4kADHSCzG9Us09FajpiHJLCMHX07kIFTGRzJBHHbum0Va2FErjqOCRZPBZTutrZRkLetUrUmrvYzjomZBqW23zz9LFiQyO5fEc5oiaAqvZ9a3jaYGO53eFsfUN3BKPGtDwKIFuckRp8BenMuYaauEiowmjWkAKnzCuXgqgIhX2go7O++c9cGRLnoH678/utVv/wGw+UIQYVHDH182eKtpw+wJgxm6Xa7WmFtQIyPCsbnwiQGAOx6NgGLPIRcogdHxL0Q==
Received: from MW4PR04CA0168.namprd04.prod.outlook.com (2603:10b6:303:85::23)
 by BL0PR12MB5009.namprd12.prod.outlook.com (2603:10b6:208:1c2::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.39; Fri, 9 Jun
 2023 06:30:26 +0000
Received: from CO1NAM11FT076.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:85:cafe::62) by MW4PR04CA0168.outlook.office365.com
 (2603:10b6:303:85::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.19 via Frontend
 Transport; Fri, 9 Jun 2023 06:30:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1NAM11FT076.mail.protection.outlook.com (10.13.174.152) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6455.23 via Frontend Transport; Fri, 9 Jun 2023 06:30:25 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Thu, 8 Jun 2023
 23:30:09 -0700
Received: from 0e64808-lcelt.nvidia.com (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Thu, 8 Jun 2023 23:30:06 -0700
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
Subject: [PATCH v3] phy: tegra: xusb: Clear the driver reference in usb-phy dev
Date:   Fri, 9 Jun 2023 14:29:32 +0800
Message-ID: <20230609062932.3276509-1-haotienh@nvidia.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT076:EE_|BL0PR12MB5009:EE_
X-MS-Office365-Filtering-Correlation-Id: fcf67379-76da-45fb-87df-08db68b30297
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +rs2rP6WKJ0pFHDcQWnL1u2WnyY+XQ/H4zbFgC4oUZ7DRJHdBQe8M3Pe212dFf8ary/wPsJwGmuBcc2S/iCOYYhCUfGa+1bCtlhoH2Jo4zvodI8s+lxoUJxd+wEJLm0asvAvksVSZpuIpuRSw1UUDixX7bjA9z8M1Xca0n87Lqe7crHtjlsVPjtWMgjJxiC+4iREU1kmzGwVEw8kgqh9gFrx/nJYVf3LhzywPH+B+oRDeL18xv5Pbqg1opR2iaTk1/1VIDpPMd+BzD/V1h/dKtEpk+3t6JEMspzJTfVTyk+6tIzFQliKW4fhVKEwVhesW4ZVzVxoZSyia/iqdx0CefstyhrTwDF+39y2Ee72irqjv73K/u0cNFbhzGuiSJ2cdIVyb0cbe75QyRXQcT3DiBgcUUEzYiUzWvhEEXEXmO07QR9eiyolxhyWORK1Lp/gZddoWOtrI/c10zXgHj8Seo8k9aC6ANOfJzksOxQAfqfaOq+KC6A4bk56ZWOQFwrIPHSqqkXmdrPnmvxMAF3MtnDQnRpNiKXj/dkSadBzpGBmbBuih+DiZCecYPbAUWv0YdpIAyleMtjZbkQfKgfuHaMrMo0sUv6Caq1rtoR2ixxyOuZfJBLiKo1hTrbGRNN/nYTrmqNl3UVAwaG9bq5iQ3Mx86K4Rag00otN+4mWo0Bdazeyfp5WZhVfpQ9z50ttxGnj6HCgldXhKDTMFSpVNuxF0EJiRnqKljXPn81lLkW5tbW8KNxghNwR/+75aZnX8+V63apchbjmPjyasjTrUA==
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(396003)(136003)(39860400002)(451199021)(40470700004)(46966006)(36840700001)(7696005)(6666004)(36756003)(82310400005)(336012)(16526019)(426003)(83380400001)(36860700001)(47076005)(86362001)(40480700001)(7636003)(356005)(82740400003)(1076003)(26005)(107886003)(40460700003)(186003)(2616005)(316002)(8936002)(41300700001)(4326008)(8676002)(5660300002)(2906002)(478600001)(110136005)(54906003)(70206006)(70586007)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2023 06:30:25.3883
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fcf67379-76da-45fb-87df-08db68b30297
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT076.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB5009
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
Acked-by: Thierry Reding <treding@nvidia.com>
Acked-by: Jon Hunter <jonathanh@nvidia.com>
---
V1 -> V2: Remove extra movements to clarify the change
V2 -> V3: Update patch title
---
 drivers/phy/tegra/xusb.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/phy/tegra/xusb.c b/drivers/phy/tegra/xusb.c
index 78045bd6c214..26b66a668f3b 100644
--- a/drivers/phy/tegra/xusb.c
+++ b/drivers/phy/tegra/xusb.c
@@ -568,6 +568,7 @@ static void tegra_xusb_port_unregister(struct tegra_xusb_port *port)
 		usb_role_switch_unregister(port->usb_role_sw);
 		cancel_work_sync(&port->usb_phy_work);
 		usb_remove_phy(&port->usb_phy);
+		port->usb_phy.dev->driver = NULL;
 	}
 
 	if (port->ops->remove)
-- 
2.25.1

