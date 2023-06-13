Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38D8F72E505
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 16:09:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242881AbjFMOGf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 10:06:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242829AbjFMOGH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 10:06:07 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2082.outbound.protection.outlook.com [40.107.93.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E495271C
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 07:04:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R0Akt+DoED+5ttbMAHxLDI1SVRj5iL6y/LkGBlF+IfkfLxeTjWOuZ3ZmUJujbufo/wgFe54qfRo4bq/A3LhKK1GG3nufHoCwOlruG2j5Yw89i+zkKZYiPVpGeT9dYumzlojKlejIN0rJoLTanJNp4ysWpVZzHASwq/HBo3YUXXNRe3AVGnQZ8HoWf56kSkUzJ53ZaxO14+E6aeGxi9CDWF98Y16E/DtmHdYQM6uEq2BkjZYcK65sY5lABvmy6mgEIPt+VktbL49mcB4dmKggeaLVgW0z/YHPe+v+9KRs8RaqvFR8vPQ3klSWAcyVLgpp1i/T/ebY6JYNJueJ1v4kPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9mScI3bZ+AkMRvilAFPGzCCLjmmh5D57Hn3pXR0F+jU=;
 b=ObAQ1XemRJ9DYmtMj/NEigjjhh0D4Dgvd1bIX5b8KUarEKQ/Garyb3H42yUxvS2Rm7xAgO202h+HRUOrqXkcciWCc4xNXm1ZI59EIj1N0v0XI9q5NBf3KpQC32LvK9W07eOWC7KlXL1PX1a0mw5e8cF6A2DSNpIgIGOFJmh50Us7vkZg+cUOQNtWGlnkNwQu6FWgFZ09Zc333IagRYoj6kjm/hMVpNVkrx+rb39fPPL7vjTH3EdImGQ3+ZDY4Hqe7wC9xGqpVZ8+In+PrGuOKh9mp12SSKJG5Bk5ZxXdqjuP+Aab7nUaxRYHb91ET7OjKW6qLf35ADlmRhvWFvbc0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=xilinx.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9mScI3bZ+AkMRvilAFPGzCCLjmmh5D57Hn3pXR0F+jU=;
 b=j8tThdqZ+toPXRmC5Q9Gl5UnSW85abjN+oZFYnqeEMekXwLhxLB5SdNJ0zYY0MRZW5C8EJLs2L/gZmfZmBDBoWzzVHLFnmgiE5CF5zXUAtzPJVm0gP3JypJr8EyfLPApXPCdZdn3qb0Z8ThKQwZxGG5sUbeAHIj6yiFGIEK9go8=
Received: from BY3PR05CA0044.namprd05.prod.outlook.com (2603:10b6:a03:39b::19)
 by SJ0PR12MB6877.namprd12.prod.outlook.com (2603:10b6:a03:47f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.32; Tue, 13 Jun
 2023 14:04:03 +0000
Received: from DM6NAM11FT003.eop-nam11.prod.protection.outlook.com
 (2603:10b6:a03:39b:cafe::9f) by BY3PR05CA0044.outlook.office365.com
 (2603:10b6:a03:39b::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.22 via Frontend
 Transport; Tue, 13 Jun 2023 14:04:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT003.mail.protection.outlook.com (10.13.173.162) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6500.22 via Frontend Transport; Tue, 13 Jun 2023 14:03:50 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Tue, 13 Jun
 2023 09:03:44 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Tue, 13 Jun
 2023 09:03:18 -0500
Received: from xhdnavam40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.23 via Frontend
 Transport; Tue, 13 Jun 2023 09:03:16 -0500
From:   Piyush Mehta <piyush.mehta@amd.com>
To:     <anurag.kumar.vulisha@xilinx.com>,
        <laurent.pinchart@ideasonboard.com>, <vkoul@kernel.org>,
        <kishon@kernel.org>, <michal.simek@amd.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-phy@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>, <git@amd.com>,
        Piyush Mehta <piyush.mehta@amd.com>
Subject: [PATCH V2 1/2] phy: xilinx: add runtime PM support
Date:   Tue, 13 Jun 2023 19:32:49 +0530
Message-ID: <20230613140250.3018947-2-piyush.mehta@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230613140250.3018947-1-piyush.mehta@amd.com>
References: <20230613140250.3018947-1-piyush.mehta@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT003:EE_|SJ0PR12MB6877:EE_
X-MS-Office365-Filtering-Correlation-Id: feb9c74e-a734-414c-8ddb-08db6c170b50
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fi3C3lumLzLoqydIWzqjCPwDEJcUSvpGGSmup0gu4G1g2YongkgRI7ZZP5y7HeTFh3HojRXFCH4RoN9U4UlPTbSn5dMAunDPfr4mV4AQ38gQ4UdVCcUcixGV7HArk++i4iVSV/Cow/64Rxq8hU/CJvyDpbJw/+rn4RLIriU5B7ug9dYHdEm0LP5UzTyYOhZfKxE2Lb9MAYmkDIprwvt76QbILVwxUH4+Ulg1w/+COIyN/N1m3LYv5QyH/0CTvknsc6CFcuG2jA8wOgfdZrF9CSpsWGjcAuabjxSGQ97QIYzS4ZiucqlKJ+4Xjh84mN7kfMOkhTt5sz4l6OljXQw1Mi2U4aK5PV5WXx1Iq0g8CIy6/TIVv3PBf5sYGyql/WhsrD4t01lw7Gq0x6CE+vL/ShVb51YwYznpghlYN1wIaEdPiWXja7AGNcs7mk3ZkjK5B4BVDcEwUye25FfSMSEWOEPYPsB4Fc4oxvdxT7EDWyZEuoVBtfFDQnyR/SdSuger/Y6tDrh0JQYTf2kvpMrBNJD74f5woR+Fs/wIrIO7MEoZ+3JMA4X7hT7voM2iFTDlq5mKXiVFVXGmrXBwITHYRkXsuv+JlUjLTPfSvluTozsZ1BvGlGE4DsqC+O6KlOgZa+OmZ/brwLHoI0LN9psbEkwlG7RLNbII/9klgo2FBqP73W6DGkdiuU5nWfoYv1UG4cV7mAb+/8cmEzSQbmFtCBU9JB6VqqtrM8yfkRU7i5Y7tcyP0zj5dbiGCH1dE9JJahn8TVheE5JrWlQz2NIvGA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(396003)(376002)(39860400002)(451199021)(46966006)(36840700001)(40470700004)(81166007)(2906002)(44832011)(82310400005)(36756003)(40480700001)(40460700003)(356005)(82740400003)(6636002)(110136005)(186003)(54906003)(70206006)(478600001)(70586007)(4326008)(8936002)(426003)(336012)(2616005)(316002)(8676002)(36860700001)(83380400001)(41300700001)(6666004)(1076003)(86362001)(26005)(5660300002)(47076005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2023 14:03:50.5908
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: feb9c74e-a734-414c-8ddb-08db6c170b50
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT003.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6877
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

Added Runtime power management support to the xilinx phy driver and using
DEFINE_RUNTIME_DEV_PM_OPS new macros allows the compiler to remove the
unused dev_pm_ops structure and related functions if !CONFIG_PM without
the need to mark the functions __maybe_unused.

Signed-off-by: Piyush Mehta <piyush.mehta@amd.com>
---
 drivers/phy/xilinx/phy-zynqmp.c | 35 ++++++++++++++++++++++++++-------
 1 file changed, 28 insertions(+), 7 deletions(-)

diff --git a/drivers/phy/xilinx/phy-zynqmp.c b/drivers/phy/xilinx/phy-zynqmp.c
index 8833680923a1..aada18123c19 100644
--- a/drivers/phy/xilinx/phy-zynqmp.c
+++ b/drivers/phy/xilinx/phy-zynqmp.c
@@ -20,6 +20,7 @@
 #include <linux/of.h>
 #include <linux/phy/phy.h>
 #include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
 #include <linux/slab.h>
 
 #include <dt-bindings/phy/phy.h>
@@ -820,7 +821,7 @@ static struct phy *xpsgtr_xlate(struct device *dev,
  * Power Management
  */
 
-static int __maybe_unused xpsgtr_suspend(struct device *dev)
+static int xpsgtr_runtime_suspend(struct device *dev)
 {
 	struct xpsgtr_dev *gtr_dev = dev_get_drvdata(dev);
 	unsigned int i;
@@ -835,7 +836,7 @@ static int __maybe_unused xpsgtr_suspend(struct device *dev)
 	return 0;
 }
 
-static int __maybe_unused xpsgtr_resume(struct device *dev)
+static int xpsgtr_runtime_resume(struct device *dev)
 {
 	struct xpsgtr_dev *gtr_dev = dev_get_drvdata(dev);
 	unsigned int icm_cfg0, icm_cfg1;
@@ -876,10 +877,8 @@ static int __maybe_unused xpsgtr_resume(struct device *dev)
 	return err;
 }
 
-static const struct dev_pm_ops xpsgtr_pm_ops = {
-	SET_SYSTEM_SLEEP_PM_OPS(xpsgtr_suspend, xpsgtr_resume)
-};
-
+static DEFINE_RUNTIME_DEV_PM_OPS(xpsgtr_pm_ops, xpsgtr_runtime_suspend,
+				 xpsgtr_runtime_resume, NULL);
 /*
  * Probe & Platform Driver
  */
@@ -1005,6 +1004,16 @@ static int xpsgtr_probe(struct platform_device *pdev)
 		ret = PTR_ERR(provider);
 		goto err_clk_put;
 	}
+
+	pm_runtime_set_active(gtr_dev->dev);
+	pm_runtime_enable(gtr_dev->dev);
+
+	ret = pm_runtime_resume_and_get(gtr_dev->dev);
+	if (ret < 0) {
+		pm_runtime_disable(gtr_dev->dev);
+		goto err_clk_put;
+	}
+
 	return 0;
 
 err_clk_put:
@@ -1014,6 +1023,17 @@ static int xpsgtr_probe(struct platform_device *pdev)
 	return ret;
 }
 
+static int xpsgtr_remove(struct platform_device *pdev)
+{
+	struct xpsgtr_dev *gtr_dev = platform_get_drvdata(pdev);
+
+	pm_runtime_disable(gtr_dev->dev);
+	pm_runtime_put_noidle(gtr_dev->dev);
+	pm_runtime_set_suspended(gtr_dev->dev);
+
+	return 0;
+}
+
 static const struct of_device_id xpsgtr_of_match[] = {
 	{ .compatible = "xlnx,zynqmp-psgtr", },
 	{ .compatible = "xlnx,zynqmp-psgtr-v1.1", },
@@ -1023,10 +1043,11 @@ MODULE_DEVICE_TABLE(of, xpsgtr_of_match);
 
 static struct platform_driver xpsgtr_driver = {
 	.probe = xpsgtr_probe,
+	.remove	= xpsgtr_remove,
 	.driver = {
 		.name = "xilinx-psgtr",
 		.of_match_table	= xpsgtr_of_match,
-		.pm =  &xpsgtr_pm_ops,
+		.pm =  pm_ptr(&xpsgtr_pm_ops),
 	},
 };
 
-- 
2.25.1

