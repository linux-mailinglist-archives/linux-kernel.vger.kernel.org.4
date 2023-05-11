Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A2B66FF9BB
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 21:04:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239018AbjEKTDt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 15:03:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238921AbjEKTDr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 15:03:47 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2079.outbound.protection.outlook.com [40.107.244.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C687525F;
        Thu, 11 May 2023 12:03:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IxzolSa5dlvcpD0o6dmbwEzANLeig9TIVN0ATHPLP5nz+U/gu/zWdZTVXflI2n0l4D19UuDvso7ZzNp0Sxpiodvqf2dksYEYs1P/bHLIuHahRcs4X0zNMFprSYq2xHIMYf/97mNxHK1Md0ONwjfoVgj+RxiT8Rn9oD1szFeBrtPayqMc/HibDAfmXQ2TfUej+8zGKNRfX6K7ebEhbhIF/yDTBOmNknr5BdPwTN9jZu4KujFEduQW3QlqDWYkjW8eRYD0ar3vBOy3IwqTHqcLFrQJqe85CWIrqLMFIVgedbty1Ep+lvPU1R7ozut97wTE/imqGz7p+rKqvc68/UG7xA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sDqNHYPIL6vanMn8Yj+2NCwT4/TcfeHrHP8z45/FHWE=;
 b=HznshgiH96DR3D5qYHhat6qd4ri11nqZEH59Iz+OsL8eOlC7y2SSX6J3ZjfEvoWlD1bhYxpI357RMKhBI5xILapvOy15/3Nj3saK9+OxKU1HVc0YfGKRKUO4cIhcZ74sM7MD0MYcS5i3j3JTnqZ0XpcptULXBWWNW5Sf8zI4an5GBBJL1EtnHuQfgjLIC2ghoNKp81H9whJ7jhjNYxaz6zZmrYA0NsmwqEzZFG/aWC73C7uxLVCZ0Q3BF/21Va5H7nfw/caGgKvgesoDBLXYfnNU1wSM2zovplnYsAD8APGoKCL+y+kB+5jg4Oz/LwumMg3ne6gEsqP1WWES7IVCdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sDqNHYPIL6vanMn8Yj+2NCwT4/TcfeHrHP8z45/FHWE=;
 b=jNyGDGrf7tvNu7bQYAATrVl6sIZNpGRBDteNPAV0zAvwbPJtHvzhU+bOzKXPeM6pYQyHuiY6ICNpnB61cgO/aWRsh8iXNqFpSOlLHJEP2LdHYoKGSJjX8+fKJaKb0cdhE6hAc9z4Pa1/5jltQLZwba+uNPxgEU1104zLECQSqFKf1yQKZxtGy4xmk4QG3mmC2oYVXI+1SGSFC5pm065cbkjLDQj7oJSV/Eq3WzAmQkoYmBC4xspeGEX0mnWm+GdIvImcaL3du9oj7DuNpd1H90W/pE135a9qYd7nlMY0cdTpSnPm4JQkLxuutMSfcMlS/TgehwuI6vOz48Gtle5Ctg==
Received: from BN8PR04CA0029.namprd04.prod.outlook.com (2603:10b6:408:70::42)
 by MN6PR12MB8515.namprd12.prod.outlook.com (2603:10b6:208:470::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.32; Thu, 11 May
 2023 19:03:44 +0000
Received: from BN8NAM11FT075.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:70:cafe::a1) by BN8PR04CA0029.outlook.office365.com
 (2603:10b6:408:70::42) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.21 via Frontend
 Transport; Thu, 11 May 2023 19:03:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN8NAM11FT075.mail.protection.outlook.com (10.13.176.208) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6387.22 via Frontend Transport; Thu, 11 May 2023 19:03:43 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Thu, 11 May 2023
 12:03:28 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Thu, 11 May
 2023 12:03:28 -0700
Received: from vdi.nvidia.com (10.127.8.12) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.986.37 via Frontend Transport; Thu, 11 May
 2023 12:03:27 -0700
From:   Liming Sun <limings@nvidia.com>
To:     Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        David Thompson <davthompson@nvidia.com>
CC:     Liming Sun <limings@nvidia.com>, <linux-mmc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v1 1/1] mmc: sdhci-of-dwcmshc: Add runtime PM operations for BlueField-3
Date:   Thu, 11 May 2023 15:03:17 -0400
Message-ID: <79137159a833c164ea8ea3f05d8d6d9537db2f42.1683747334.git.limings@nvidia.com>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT075:EE_|MN6PR12MB8515:EE_
X-MS-Office365-Filtering-Correlation-Id: dddb80ba-4746-4c16-c13f-08db52527104
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5+H01Zj6qJrFLFsJpRwl6wTY6Sq4WsP18IQccdmq4HMOz9Uq+uOLE2R7giW5lWno8smitFBC9SPqiQG4iq/5uOUq4jjsx7J1vr10rSYcEwkmSebp5F4vmF9uzuy9DHyrpiMpmLTZaO6nb+iK3JVv94r6Zf8Jd7xB9fepZR2DxJPGARwDif/bictkRu4+kuBXWOiEgQ0FKhgDl3yuhNeRbQtLl4op1uzKjnlh3dTVo++Ln0qaDHqyqbV7mWOUkr4JKSBO2XGsgJodYF6j9km8KoGtRgTxkgh3Nj1sjQpFb9mYZoyQybbda/RgLvTrtQBRC/B9xhsHJSII5935h6xNXAoMEDf120umHQSJLBHa4kmrPyJCFerAfPZz6wY6Ha8dXEtkNJWVFD9DNQ2erkR3DgwCVCqXJBOQZAWbyXxLZudQrfarc8gxKkh/sqcJkXErjUf1kTnS0rUj3bpnKocwcGO1kYj1gAwSx+a6PtN5O8zfJlq9LXxfPmA8MrouZe39TfG/shoHfwCBgviPt23d0u2LNdq9i2tQmOMcXY/mF8n3eKuKu4wIXCeqXeDwLkA/Wng090GTIK7gpBbRol4cidsRLdQonPEY0xe9Yn8OOp3e0UELKeDwlC3YNA+WLRZWwqrujvH5xEviSVzO0jLwgF4/LmSRdEKrV+nDhYZI5kbSfQfgkZptWfdJ9b9gSQwxuRXZvCCiRzpizHXYhSzjh6fnG+MnYM/76VMfj99wvTE=
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(136003)(396003)(39860400002)(346002)(376002)(451199021)(46966006)(40470700004)(36840700001)(40460700003)(7696005)(36756003)(82310400005)(70206006)(478600001)(6636002)(70586007)(4326008)(316002)(54906003)(110136005)(86362001)(47076005)(8676002)(26005)(6666004)(336012)(2616005)(36860700001)(186003)(2906002)(41300700001)(426003)(40480700001)(8936002)(356005)(5660300002)(7636003)(83380400001)(82740400003)(133343001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2023 19:03:43.8115
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dddb80ba-4746-4c16-c13f-08db52527104
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT075.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8515
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit implements the runtime PM operations for BlueField-3 SoC
to disable eMMC card clock when idle.

Reviewed-by: David Thompson <davthompson@nvidia.com>
Signed-off-by: Liming Sun <limings@nvidia.com>
---
 drivers/mmc/host/sdhci-of-dwcmshc.c | 76 ++++++++++++++++++++++++++++-
 1 file changed, 74 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/sdhci-of-dwcmshc.c b/drivers/mmc/host/sdhci-of-dwcmshc.c
index e68cd87998c8..19ce058fc5f0 100644
--- a/drivers/mmc/host/sdhci-of-dwcmshc.c
+++ b/drivers/mmc/host/sdhci-of-dwcmshc.c
@@ -15,6 +15,7 @@
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/of_device.h>
+#include <linux/pm_runtime.h>
 #include <linux/reset.h>
 #include <linux/sizes.h>
 
@@ -542,8 +543,10 @@ static int dwcmshc_probe(struct platform_device *pdev)
 	}
 
 #ifdef CONFIG_ACPI
-	if (pltfm_data == &sdhci_dwcmshc_bf3_pdata)
+	if (pltfm_data == &sdhci_dwcmshc_bf3_pdata) {
 		sdhci_enable_v4_mode(host);
+		pm_runtime_enable(dev);
+	}
 #endif
 
 	host->mmc->caps |= MMC_CAP_WAIT_WHILE_BUSY;
@@ -646,7 +649,76 @@ static int dwcmshc_resume(struct device *dev)
 }
 #endif
 
-static SIMPLE_DEV_PM_OPS(dwcmshc_pmops, dwcmshc_suspend, dwcmshc_resume);
+#ifdef CONFIG_PM
+
+#ifdef CONFIG_ACPI
+static void dwcmshc_enable_card_clk(struct sdhci_host *host)
+{
+	u16 ctrl;
+
+	ctrl = sdhci_readw(host, SDHCI_CLOCK_CONTROL);
+	ctrl |= SDHCI_CLOCK_CARD_EN;
+	sdhci_writew(host, ctrl, SDHCI_CLOCK_CONTROL);
+}
+
+static void dwcmshc_disable_card_clk(struct sdhci_host *host)
+{
+	u16 ctrl;
+
+	ctrl = sdhci_readw(host, SDHCI_CLOCK_CONTROL);
+	ctrl &= ~SDHCI_CLOCK_CARD_EN;
+	sdhci_writew(host, ctrl, SDHCI_CLOCK_CONTROL);
+}
+#endif
+
+static int dwcmshc_runtime_suspend(struct device *dev)
+{
+	struct sdhci_host *host = dev_get_drvdata(dev);
+	const struct sdhci_pltfm_data *pltfm_data;
+	int ret = 0;
+
+	pltfm_data = device_get_match_data(dev);
+	if (!pltfm_data)
+		return -ENODEV;
+
+#ifdef CONFIG_ACPI
+	if (pltfm_data == &sdhci_dwcmshc_bf3_pdata) {
+		ret = sdhci_runtime_suspend_host(host);
+		if (!ret)
+			dwcmshc_disable_card_clk(host);
+	}
+#endif
+
+	return ret;
+}
+
+static int dwcmshc_runtime_resume(struct device *dev)
+{
+	struct sdhci_host *host = dev_get_drvdata(dev);
+	const struct sdhci_pltfm_data *pltfm_data;
+	int ret = 0;
+
+	pltfm_data = device_get_match_data(dev);
+	if (!pltfm_data)
+		return -ENODEV;
+
+#ifdef CONFIG_ACPI
+	if (pltfm_data == &sdhci_dwcmshc_bf3_pdata) {
+		dwcmshc_enable_card_clk(host);
+		ret = sdhci_runtime_resume_host(host, 0);
+	}
+#endif
+
+	return ret;
+}
+
+#endif
+
+static const struct dev_pm_ops dwcmshc_pmops = {
+	SET_SYSTEM_SLEEP_PM_OPS(dwcmshc_suspend, dwcmshc_resume)
+	SET_RUNTIME_PM_OPS(dwcmshc_runtime_suspend,
+			   dwcmshc_runtime_resume, NULL)
+};
 
 static struct platform_driver sdhci_dwcmshc_driver = {
 	.driver	= {
-- 
2.30.1

