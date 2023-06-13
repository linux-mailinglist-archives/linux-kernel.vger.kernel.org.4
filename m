Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D688A72E4FE
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 16:09:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242963AbjFMOGm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 10:06:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242670AbjFMOGH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 10:06:07 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2080.outbound.protection.outlook.com [40.107.92.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96A0A1BF5
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 07:04:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NsfK46ICztKLI9fejw+rF5sQDPfE8EP93tc+q78ldA/BNPeXNnAvw4g+/1CVmHOI8ntqKjdUYleDS2pCQQB/GHxgWpDwUxdttumUkDquYiUv3fjEXSNj4m3bd3QyJKRLwGB5g36PbYMkiSyeYlpjG04VPNYSYmQPUUqsxpkF6/w9KW3mRYHGAn667GXDgPiQvaCdKRbAVZC7bWh04FXaOQGT4qrbJ25mNDdsSRDvIYbBODB0juBT4hcmZuI6be+mcJlH33fnVBYlPEVDiYV46grQPL88TkrsBAyY6ktsMswJ+YV1UUew4MSwEfvhsEhhMP1zRjHLDAbX8MlOUqBoeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c942uaubACSy7wzt2ONoxJ3Xp7mv8g8ws85JhXodQAo=;
 b=C7h0orCmMd3wqbI5cOkSOchURqAlhl7GsTZfJOgi+u4SHAlIixHUJ4SHBmBVuTql3wvfD/JMF8XctqA5tuw+VNUNu2uNT87+ukWQyfYfF0KpxDy71ememnSIK1nm+h5lIkWaXJHT+jZSELNW9zeSU8R7d3/xRc9wkxVuz5t0CcEXIZ1nrZCwpehUuaYjoA3cPViqxII8nOiRf6iUy8psGR7K98nuFLNoQAnxpil1Ln9sgFplBNkSSa+ZvENXhQzvkUvMjPFPTPnnKD3GaLrR+yCW6FOOnQuKB/EqlVt7s6Ji55YZjBu1yZ4rw7HPMuVNRrIhdvkUJ+jJflx650hg/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=xilinx.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c942uaubACSy7wzt2ONoxJ3Xp7mv8g8ws85JhXodQAo=;
 b=Okzv2moGKwtxSGdTW5Yoq7OBUdDunAP67nBLc0/NJIn14WGPEVYWPcYQo+OogfBimoXmUqsFPnZEbzuBBXNEvmKqNrRa25xI9l6o+mvn4hr/SUshldKEZzsjdj+eOBuNlYvvjEjH4iWl18tAH/qDH6BL6f/2XDyzF2umnWlZBu0=
Received: from DS7PR03CA0142.namprd03.prod.outlook.com (2603:10b6:5:3b4::27)
 by MN0PR12MB5761.namprd12.prod.outlook.com (2603:10b6:208:374::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Tue, 13 Jun
 2023 14:04:03 +0000
Received: from DM6NAM11FT081.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b4:cafe::92) by DS7PR03CA0142.outlook.office365.com
 (2603:10b6:5:3b4::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.35 via Frontend
 Transport; Tue, 13 Jun 2023 14:04:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT081.mail.protection.outlook.com (10.13.172.136) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6455.23 via Frontend Transport; Tue, 13 Jun 2023 14:04:03 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Tue, 13 Jun
 2023 09:03:44 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Tue, 13 Jun
 2023 09:03:21 -0500
Received: from xhdnavam40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.23 via Frontend
 Transport; Tue, 13 Jun 2023 09:03:19 -0500
From:   Piyush Mehta <piyush.mehta@amd.com>
To:     <anurag.kumar.vulisha@xilinx.com>,
        <laurent.pinchart@ideasonboard.com>, <vkoul@kernel.org>,
        <kishon@kernel.org>, <michal.simek@amd.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-phy@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>, <git@amd.com>,
        Piyush Mehta <piyush.mehta@amd.com>
Subject: [PATCH V2 2/2] phy: xilinx: phy-zynqmp: dynamic clock support for power-save
Date:   Tue, 13 Jun 2023 19:32:50 +0530
Message-ID: <20230613140250.3018947-3-piyush.mehta@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230613140250.3018947-1-piyush.mehta@amd.com>
References: <20230613140250.3018947-1-piyush.mehta@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT081:EE_|MN0PR12MB5761:EE_
X-MS-Office365-Filtering-Correlation-Id: da348367-23e0-4026-550b-08db6c170b8c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nyypsTELipksdvbb1yx9kaCSp3oF04bJ2a7DFrZjE4k2cJ8JEsCXy3EO8ialbOkOCGO/DywnWXTyuROfA1eeRHcTUxtV8c7zcSRQI5jcCQw8tVTF67j74yxUmu3MchuxBNmglARrz6aUD9oYPNigf38EYdvNK2qD/GisWruFLYYNo4hKgDtYa5YP0Atz5vS8j2gt/wOEHsDjtYZHfjR7nTgn8cfCzkL55utLWqfw/KVmDuRvWOtKp+iTmqy1QfLWU0M7yXruIIKmDD7WedVuTKucaqe5gCGcvZ2kw+O3Je0NcwWzMvxRKz0auBsGk4V6mUWm9812G9ousb7O2DYw4XDQVuJbnemTOC3mjRb0dfJEznrUXjlq/Cu5f98BgzfCqIPQSGHWObFIrGZboc+xz9fnJHX8xEt0JKN9ZDX95bsMslp6CaAgfWBWmqUzWbwuu7bQbPpRXxbRUkze8dW4wP97vU8AIiQpcM2NvBJ9onfcy84wIJDycVqmA5q1+I+P9dbuqKDowa50cqz8TZHEsJJhkU7+s/vpOvNeB4GRPZH+Yz483OuO+G/VcyDGjJxNG1AU2FPur4809865oghXDWw37ngjbnd2DS9oV7xkrSnj7yUTiehVD45/01ymCvcIi1zBvhKbqqpxZziLpNKE6dnReOyP44ziyVsaKTWrbG5rHlRbemzDiAPqNneEnq0qfEiIIGpi7YQj2P2bTpv3o4sBPMLE8/IjZ5+m6ZX4VZ03tSEM2uDUBaNFytdI521mU4BByax8/oQyWoUXsQFno7Jyylf/4DVMONmwD8d4Zu/WtcySGcyO5ORSdjdGrUtI
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(346002)(376002)(396003)(136003)(451199021)(36840700001)(46966006)(40470700004)(40480700001)(40460700003)(54906003)(110136005)(81166007)(82740400003)(356005)(6636002)(41300700001)(8676002)(8936002)(5660300002)(2616005)(70206006)(4326008)(478600001)(316002)(70586007)(426003)(36860700001)(83380400001)(1076003)(47076005)(6666004)(336012)(186003)(26005)(86362001)(82310400005)(44832011)(2906002)(36756003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2023 14:04:03.6069
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: da348367-23e0-4026-550b-08db6c170b8c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT081.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5761
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enabling clock for all the lanes consumes power even PHY is active or
inactive. To resolve this, enable/disable clocks in phy_init/phy_exit.

By default clock is disabled for all the lanes. Whenever phy_init called
from USB, SATA, or display driver, etc. It enabled the required clock
for requested lane. On phy_exit cycle, it disabled clock for the active
PHYs.

During the suspend/resume cycle, each USB/ SATA/ display driver called
phy_exit/phy_init individually. It disabled clock on exit, and enabled
on initialization for the active PHYs.

Signed-off-by: Piyush Mehta <piyush.mehta@amd.com>
---
 drivers/phy/xilinx/phy-zynqmp.c | 61 ++++++++-------------------------
 1 file changed, 15 insertions(+), 46 deletions(-)

diff --git a/drivers/phy/xilinx/phy-zynqmp.c b/drivers/phy/xilinx/phy-zynqmp.c
index aada18123c19..b0c2045b886e 100644
--- a/drivers/phy/xilinx/phy-zynqmp.c
+++ b/drivers/phy/xilinx/phy-zynqmp.c
@@ -572,6 +572,10 @@ static int xpsgtr_phy_init(struct phy *phy)
 
 	mutex_lock(&gtr_dev->gtr_mutex);
 
+	/* Configure and enable the clock when peripheral phy_init call */
+	if (clk_prepare_enable(gtr_dev->clk[gtr_phy->lane]))
+		goto out;
+
 	/* Skip initialization if not required. */
 	if (!xpsgtr_phy_init_required(gtr_phy))
 		goto out;
@@ -616,9 +620,13 @@ static int xpsgtr_phy_init(struct phy *phy)
 static int xpsgtr_phy_exit(struct phy *phy)
 {
 	struct xpsgtr_phy *gtr_phy = phy_get_drvdata(phy);
+	struct xpsgtr_dev *gtr_dev = gtr_phy->dev;
 
 	gtr_phy->skip_phy_init = false;
 
+	/* Ensure that disable clock only, which configure for lane */
+	clk_disable_unprepare(gtr_dev->clk[gtr_phy->lane]);
+
 	return 0;
 }
 
@@ -824,15 +832,11 @@ static struct phy *xpsgtr_xlate(struct device *dev,
 static int xpsgtr_runtime_suspend(struct device *dev)
 {
 	struct xpsgtr_dev *gtr_dev = dev_get_drvdata(dev);
-	unsigned int i;
 
 	/* Save the snapshot ICM_CFG registers. */
 	gtr_dev->saved_icm_cfg0 = xpsgtr_read(gtr_dev, ICM_CFG0);
 	gtr_dev->saved_icm_cfg1 = xpsgtr_read(gtr_dev, ICM_CFG1);
 
-	for (i = 0; i < ARRAY_SIZE(gtr_dev->clk); i++)
-		clk_disable_unprepare(gtr_dev->clk[i]);
-
 	return 0;
 }
 
@@ -842,13 +846,6 @@ static int xpsgtr_runtime_resume(struct device *dev)
 	unsigned int icm_cfg0, icm_cfg1;
 	unsigned int i;
 	bool skip_phy_init;
-	int err;
-
-	for (i = 0; i < ARRAY_SIZE(gtr_dev->clk); i++) {
-		err = clk_prepare_enable(gtr_dev->clk[i]);
-		if (err)
-			goto err_clk_put;
-	}
 
 	icm_cfg0 = xpsgtr_read(gtr_dev, ICM_CFG0);
 	icm_cfg1 = xpsgtr_read(gtr_dev, ICM_CFG1);
@@ -869,12 +866,6 @@ static int xpsgtr_runtime_resume(struct device *dev)
 		gtr_dev->phys[i].skip_phy_init = skip_phy_init;
 
 	return 0;
-
-err_clk_put:
-	while (i--)
-		clk_disable_unprepare(gtr_dev->clk[i]);
-
-	return err;
 }
 
 static DEFINE_RUNTIME_DEV_PM_OPS(xpsgtr_pm_ops, xpsgtr_runtime_suspend,
@@ -886,7 +877,6 @@ static DEFINE_RUNTIME_DEV_PM_OPS(xpsgtr_pm_ops, xpsgtr_runtime_suspend,
 static int xpsgtr_get_ref_clocks(struct xpsgtr_dev *gtr_dev)
 {
 	unsigned int refclk;
-	int ret;
 
 	for (refclk = 0; refclk < ARRAY_SIZE(gtr_dev->refclk_sscs); ++refclk) {
 		unsigned long rate;
@@ -897,19 +887,14 @@ static int xpsgtr_get_ref_clocks(struct xpsgtr_dev *gtr_dev)
 		snprintf(name, sizeof(name), "ref%u", refclk);
 		clk = devm_clk_get_optional(gtr_dev->dev, name);
 		if (IS_ERR(clk)) {
-			ret = dev_err_probe(gtr_dev->dev, PTR_ERR(clk),
-					    "Failed to get reference clock %u\n",
-					    refclk);
-			goto err_clk_put;
+			return dev_err_probe(gtr_dev->dev, PTR_ERR(clk),
+					     "Failed to get ref clock %u\n",
+					     refclk);
 		}
 
 		if (!clk)
 			continue;
 
-		ret = clk_prepare_enable(clk);
-		if (ret)
-			goto err_clk_put;
-
 		gtr_dev->clk[refclk] = clk;
 
 		/*
@@ -929,18 +914,11 @@ static int xpsgtr_get_ref_clocks(struct xpsgtr_dev *gtr_dev)
 			dev_err(gtr_dev->dev,
 				"Invalid rate %lu for reference clock %u\n",
 				rate, refclk);
-			ret = -EINVAL;
-			goto err_clk_put;
+			return -EINVAL;
 		}
 	}
 
 	return 0;
-
-err_clk_put:
-	while (refclk--)
-		clk_disable_unprepare(gtr_dev->clk[refclk]);
-
-	return ret;
 }
 
 static int xpsgtr_probe(struct platform_device *pdev)
@@ -949,7 +927,6 @@ static int xpsgtr_probe(struct platform_device *pdev)
 	struct xpsgtr_dev *gtr_dev;
 	struct phy_provider *provider;
 	unsigned int port;
-	unsigned int i;
 	int ret;
 
 	gtr_dev = devm_kzalloc(&pdev->dev, sizeof(*gtr_dev), GFP_KERNEL);
@@ -989,8 +966,7 @@ static int xpsgtr_probe(struct platform_device *pdev)
 		phy = devm_phy_create(&pdev->dev, np, &xpsgtr_phyops);
 		if (IS_ERR(phy)) {
 			dev_err(&pdev->dev, "failed to create PHY\n");
-			ret = PTR_ERR(phy);
-			goto err_clk_put;
+			return PTR_ERR(phy);
 		}
 
 		gtr_phy->phy = phy;
@@ -1001,8 +977,7 @@ static int xpsgtr_probe(struct platform_device *pdev)
 	provider = devm_of_phy_provider_register(&pdev->dev, xpsgtr_xlate);
 	if (IS_ERR(provider)) {
 		dev_err(&pdev->dev, "registering provider failed\n");
-		ret = PTR_ERR(provider);
-		goto err_clk_put;
+		return PTR_ERR(provider);
 	}
 
 	pm_runtime_set_active(gtr_dev->dev);
@@ -1011,16 +986,10 @@ static int xpsgtr_probe(struct platform_device *pdev)
 	ret = pm_runtime_resume_and_get(gtr_dev->dev);
 	if (ret < 0) {
 		pm_runtime_disable(gtr_dev->dev);
-		goto err_clk_put;
+		return ret;
 	}
 
 	return 0;
-
-err_clk_put:
-	for (i = 0; i < ARRAY_SIZE(gtr_dev->clk); i++)
-		clk_disable_unprepare(gtr_dev->clk[i]);
-
-	return ret;
 }
 
 static int xpsgtr_remove(struct platform_device *pdev)
-- 
2.25.1

