Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBD9A7007E1
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 14:28:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240684AbjELM20 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 08:28:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240096AbjELM2X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 08:28:23 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2050.outbound.protection.outlook.com [40.107.93.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D53611DB3;
        Fri, 12 May 2023 05:27:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eC68EnGDe5jb9CeUVwNDXZ8ktIabeHTgRRtoFyvOtXKZpJQ7V52Tn6J9bczC029TqVLHzpvjpMm7HiL365wrzhxLQ3NyMKR9TgmQ/Vo6v4hoV3LB28Hm1Z03fUjBgLzmUK7w8iHxE6PPZlwUbaChz8Cj/h47ma/ZV05eX0yP23962Zu81Kj3GFa+yBqYV4VzJkVaE9dtmnZ/pl/UFt9fdMSnabcIVPRS/0NMmIt5SutHBIdoU8qnhviy5XwTNZky4yjaAluTx1zjrKgl0c7HJItBS0hWlUpJPl4y8irdmZ3J8/Nu+zLli0GuEuuB6dS4+Dn2l67okfl1wQcoPeAolw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5XbEIJDk0X+Le9usaka27pFIyefAOzKUWuosEUJ4N7A=;
 b=OKmi1SHzmwnxn9ufW6wT2gxgWh8/jIoeNVNenS9gWjfO4qgL4kxfGKXRYExji+TxXlKJ3vaOi1HRnG8SpvoeKby+14CnO26+glPsnwvLNi/CLm8Xk6LrNvGEMpk9lEQe1+zzZ0NxKGJIpxu25wlODv5Q/kTo7y5NGhm09D2ck9xHMff53i1BDU7bMuHOmWNDp3iop1RrFR0rYI12FqOWLMEDdD3gPu50PPAzebV9keS89sNlZ4SEsv68IlfFHkcrl94ZE+S+7zloXOocDwnq4YAOHBuh6/7yFeKOkLo4lnSDQZ8WswO2OPP3Qs4emcEDkq8kiGCjZfJUV9XHYWu4ZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5XbEIJDk0X+Le9usaka27pFIyefAOzKUWuosEUJ4N7A=;
 b=EW9n0pRQvDO+p8zmUgntVFtlbIlYptrhOIeP2yH6YzznUizDgWijSNMcortQtFnLVUukPRMlR60XMoMhk5NTGNtsjG1gYibkE2jRmJYm5FAPSdK4RBlzesbl11eyc61E1fl82nqVZA5ZMJfLYdNGzfSjXqnRevyOa8rQEJUBKnpXw0qPfO9IESC1mWA5IkSBMoh1kAYokkRt74tgD093SEnfwjAwz+RTgC43VO+qPY27+yqDKOW/6AXEdb7pcggaf7sO9xYyxbjhMaPtdZH/5nSRachzZpZuN2UolF7pI6EPk5PBrRhDimb7Tq9DgsRqBkHzflp/t970chhkvO+9dg==
Received: from SJ0PR13CA0197.namprd13.prod.outlook.com (2603:10b6:a03:2c3::22)
 by CY8PR12MB7658.namprd12.prod.outlook.com (2603:10b6:930:9e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.18; Fri, 12 May
 2023 12:27:05 +0000
Received: from CO1NAM11FT006.eop-nam11.prod.protection.outlook.com
 (2603:10b6:a03:2c3:cafe::94) by SJ0PR13CA0197.outlook.office365.com
 (2603:10b6:a03:2c3::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.10 via Frontend
 Transport; Fri, 12 May 2023 12:27:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1NAM11FT006.mail.protection.outlook.com (10.13.174.246) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6387.24 via Frontend Transport; Fri, 12 May 2023 12:27:04 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Fri, 12 May 2023
 05:26:54 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Fri, 12 May
 2023 05:26:53 -0700
Received: from vdi.nvidia.com (10.127.8.12) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server id 15.2.986.37 via Frontend Transport; Fri, 12 May
 2023 05:26:52 -0700
From:   Liming Sun <limings@nvidia.com>
To:     Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        David Thompson <davthompson@nvidia.com>,
        Shawn Lin <shawn.lin@rock-chips.com>
CC:     Liming Sun <limings@nvidia.com>, <linux-mmc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v3] mmc: sdhci-of-dwcmshc: Add runtime PM operations
Date:   Fri, 12 May 2023 08:26:48 -0400
Message-ID: <20230512122648.223974-1-limings@nvidia.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <79137159a833c164ea8ea3f05d8d6d9537db2f42.1683747334.git.limings@nvidia.com>
References: <79137159a833c164ea8ea3f05d8d6d9537db2f42.1683747334.git.limings@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT006:EE_|CY8PR12MB7658:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b9b2f3d-1ced-4cf2-5efa-08db52e431e7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7v8zETP90kyQVj606kOd4lMMeEdyZboPVbf1pnkqswS0uEujWZ4DiirITkH2X/L+cbVxhzB6pvPiSm7Cc8RTUccqtJEbscZlrBgCPugohU6eHEnQtNgOxk1NlXkN82g4NEUd9PcAhMjt6eGHSruvGfKNVbuoBzpELdDnVLaHe4tptl7v62ipUXOR3b7LOCm46wwVb5oK6Qw/1TQDZ8wQDZHq37arOH1vQ++52rWQQ+96R0FNioZW7f/muGmgGOULUuqJBIvDiF9zERF/pZEOzy2VPCyT3a55ZkNL0HfeMbdcenOsn7Hcn5pifAkYmteFHXM9z/gB7V4SwqhjgkpSoJujyy31bccyoqgAlX8EDCR/udbr6J8FYQMzRszOZSSAZGRmq0a68fBh9efS5W5mPyLfr/fHhJjGeni2PWFZnH4DCyjAVPDxz60JgKaGrGC6EFJSaU8u/Yr+X1BunnLXDKLnLnQ+4Q50THVumfNMgVv25anuidBjnDhwXFP3hB6ynSgH9OgbcBNiAzke2OXX4G54l/1TRnWyzcTYskofZ+MWFvl6ZcRq+r2bl4xR6TLloxzEGG9Xw27JdOApVAS9rKa+cBSsN09xxAzdDuWmztLrznJcCKJ95WeGrZZsfCKF2JXzs6bIVcgi8zS0iVrda7uRWS7UVM8jMSUI/vSSxqGM5Y4klNdIdYcAimzwil7dqTb2KAzI8WUYNBTTahGKzVtLbJPj3Z6WSzS21u409Wr69ZgVjBL4s+EYIaTuooBFvoQ7ccrVn6GVqaFcTUlDVQ==
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(376002)(136003)(346002)(39860400002)(396003)(451199021)(36840700001)(46966006)(40470700004)(336012)(2616005)(40460700003)(426003)(186003)(83380400001)(47076005)(2906002)(82740400003)(36860700001)(82310400005)(86362001)(36756003)(7636003)(356005)(40480700001)(6666004)(8936002)(8676002)(5660300002)(70206006)(4326008)(70586007)(478600001)(41300700001)(7696005)(316002)(54906003)(26005)(110136005)(1076003)(133343001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2023 12:27:04.5231
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b9b2f3d-1ced-4cf2-5efa-08db52e431e7
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT006.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7658
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

This commit implements the runtime PM operations to disable eMMC
card clock when idle.

Reviewed-by: David Thompson <davthompson@nvidia.com>
Signed-off-by: Liming Sun <limings@nvidia.com>
---
v2->v3:
    - Revise the commit message;
v1->v2:
    Updates for comments from Ulf:
    - Make the runtime PM logic generic for sdhci-of-dwcmshc;
v1: Initial version.
---
 drivers/mmc/host/sdhci-of-dwcmshc.c | 56 ++++++++++++++++++++++++++++-
 1 file changed, 55 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-of-dwcmshc.c b/drivers/mmc/host/sdhci-of-dwcmshc.c
index e68cd87998c8..a3277f4d250d 100644
--- a/drivers/mmc/host/sdhci-of-dwcmshc.c
+++ b/drivers/mmc/host/sdhci-of-dwcmshc.c
@@ -15,6 +15,7 @@
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/of_device.h>
+#include <linux/pm_runtime.h>
 #include <linux/reset.h>
 #include <linux/sizes.h>
 
@@ -546,6 +547,8 @@ static int dwcmshc_probe(struct platform_device *pdev)
 		sdhci_enable_v4_mode(host);
 #endif
 
+	pm_runtime_enable(dev);
+
 	host->mmc->caps |= MMC_CAP_WAIT_WHILE_BUSY;
 
 	err = sdhci_setup_host(host);
@@ -646,7 +649,58 @@ static int dwcmshc_resume(struct device *dev)
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
+	int ret = 0;
+
+	ret = sdhci_runtime_suspend_host(host);
+	if (!ret)
+		dwcmshc_disable_card_clk(host);
+
+	return ret;
+}
+
+static int dwcmshc_runtime_resume(struct device *dev)
+{
+	struct sdhci_host *host = dev_get_drvdata(dev);
+	int ret = 0;
+
+	dwcmshc_enable_card_clk(host);
+	ret = sdhci_runtime_resume_host(host, 0);
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

