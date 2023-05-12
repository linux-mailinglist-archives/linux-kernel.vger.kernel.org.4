Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA5EF700E74
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 20:16:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237672AbjELSP7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 14:15:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbjELSP5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 14:15:57 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2085.outbound.protection.outlook.com [40.107.237.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DC631FE4;
        Fri, 12 May 2023 11:15:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mBS3Tn9D/ypDLeIvNGhqfN46JCVl5+k93rwxG+2JsHby6cxlZl7xgvI1Ia2e2zj/4Zr4XktB3rJB1cRUf09ta0YFZBFn+ri64LiSLFH5Mlq7z5dNsJud3ETnj7ykrbPkPt5Gi0CVbJtXhtxfivr3A/aB7RPr0K1WFm4kufgWrjAeCV/hrMRamAhpzLGViyVoslmkIoxRfg7I7AVMZCa3P2pNzrnHTJvt09hXWM+pAUJO7S7iZQGW1u2pygC8ucDlutXYV9uM5iCQno5G+dFwMWaA3Fg1jnVxGLIXcdHTbJCAMxjc3Y0JhWzEZh3w/i6DoLkdqk552qYVc9lWt1m7Qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dZZixivFQ90kRh1WpwBqoyH6NViSEtOuonYHnpqu/oQ=;
 b=OKByICxbux23vlDK4oQCKrSjGUveDswPKfyZ4iUbO9VaI2aCpnnuTn4p83zhmTp24PRJAqN2e5lFprXuv8NROYMeM8SIuxXzaHEAPdt0xkP27YemYkN3J/JMnjbrlONxz00pm222myHbXsYNoKfHNuTgSVaeDCMEtjleEVYkBEC6zm6kG/AfrZLduFOTlXcIx0uFfGu34Vca21cYx/sg5siazAvcQFZa90D6nku2ozvLD3wD0OQ73fh3VM17GyKlDZBu3OOS4gBQz5DdJKzYxBMKZvGS6o5dkHWIseY+yikeLCbOf1sRn0N3+BT10oeY38JtnAq5k26K26aPiY/Rvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dZZixivFQ90kRh1WpwBqoyH6NViSEtOuonYHnpqu/oQ=;
 b=JAJDqI/Zw+DARdz5i8eZZL9QPQ7VdbmnamQ8eqWRzHhb5cDPnyiy4eubM6JAeiUDmU0TFgrkqfiAlgHKY1kX8gXJZ7r4PXlmzCdmg1202SfrZBXRtBfJO3nk823RXe9rNWFA5ehrvmB9rco0sJ0xq2fKNrAHscuI2hMsL8F/w0HfP9XJ1E665v4Miwj6OT7RczMhl0nxw6yzrIjbTzog4HUXVlaAaMqEA+yW8FQqh6hl1uRZoHFLXMF/ra+GKhoTegDKnUdEf4rNxc//jg96EjWxVtRERVBMutaVKl+/wxd6FnPsspyfRXDAJW/Ky+oMFN0xluojb+NIrJeV8VISJA==
Received: from MW3PR05CA0007.namprd05.prod.outlook.com (2603:10b6:303:2b::12)
 by MN6PR12MB8590.namprd12.prod.outlook.com (2603:10b6:208:47c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.22; Fri, 12 May
 2023 18:15:54 +0000
Received: from CO1NAM11FT005.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:2b:cafe::b2) by MW3PR05CA0007.outlook.office365.com
 (2603:10b6:303:2b::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.10 via Frontend
 Transport; Fri, 12 May 2023 18:15:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1NAM11FT005.mail.protection.outlook.com (10.13.174.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6387.24 via Frontend Transport; Fri, 12 May 2023 18:15:52 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Fri, 12 May 2023
 11:15:32 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Fri, 12 May
 2023 11:15:32 -0700
Received: from vdi.nvidia.com (10.127.8.12) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server id 15.2.986.37 via Frontend Transport; Fri, 12 May
 2023 11:15:31 -0700
From:   Liming Sun <limings@nvidia.com>
To:     Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        David Thompson <davthompson@nvidia.com>,
        Shawn Lin <shawn.lin@rock-chips.com>
CC:     Liming Sun <limings@nvidia.com>, <linux-mmc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v4] mmc: sdhci-of-dwcmshc: Add runtime PM operations
Date:   Fri, 12 May 2023 14:15:27 -0400
Message-ID: <20230512181527.189345-1-limings@nvidia.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <79137159a833c164ea8ea3f05d8d6d9537db2f42.1683747334.git.limings@nvidia.com>
References: <79137159a833c164ea8ea3f05d8d6d9537db2f42.1683747334.git.limings@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT005:EE_|MN6PR12MB8590:EE_
X-MS-Office365-Filtering-Correlation-Id: eee5e4ee-04f6-4032-c1b0-08db5314ebfc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XegYqlu/Hdf754ykMUqzdwJ1vKIoKCzUHmCR7wOJylXF2eE4PJH1NdISrnCJEYE6D9kEjXgIe3daSiZfeEcx2dgyXDhxHYhFSRkkgVALcH5muJxpMbK7nAb0A8tD60L8L+Rf9EEGmwsZo1l99qG72lP2CmUa/WfccprRHtmJmAyw3RyhRi0eiJoJrAr/GQvhZu+0d4Bhh/RoJxEW0u7wvzjDMq8NaDjQgbjdii7At6Y0cUx5Ied+rQDVgs5ocyEdWtB9/T53qcOIVW17Jft7FTYr2XLkpD0byYQqZzNNp99ogiSGLWgwwWZfryDDIb3LXzJtaVF0DGWdVm55hz4u02pj7XENTycJ/WsaveWwCcmg+6q4tLjUuMKNe1MKRGBUXm7fInrfkbZzwWyHe1ZMwfh4pZ1zPlp7kD/cSCD9dMSZg33SPBdxy/CVcIrvPLm36v3P6yh2R/0f4F7oFNh8OfEsr8yXM8Zqpjw2jyjMLwF+qC5Ka/vJY3jjPqeU4KEVeCQMNrWiugLnSRFm5Vsw/rDgVF/OGPJoTsGAYrN/PcsZYstLgpXH6zB75uqoPushgVtXbJsPXUUDZ9XNEF34h06dQuc7w+Muvma3Lt3S/Wq48JdbC+VEKRICi9QqRk/DW8YejPMc6F5JMyrjQCnYBzfjVKaiad+iTcdKZdrqlr1wm8hynbZRDidNsvES19d25e+GPxEsCPWDD2DYP6y8WVEuT7l7K8JYskkxwwE7n9GHSyWXUnRnaxYPyJ+8Zfv7wR571jxKuKUyoFJUbmlGew==
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(396003)(346002)(376002)(39860400002)(136003)(451199021)(46966006)(36840700001)(40470700004)(5660300002)(40460700003)(8936002)(8676002)(47076005)(36860700001)(2616005)(426003)(336012)(83380400001)(2906002)(36756003)(356005)(7636003)(186003)(82740400003)(86362001)(82310400005)(40480700001)(26005)(1076003)(4326008)(41300700001)(70586007)(70206006)(6666004)(316002)(478600001)(7696005)(54906003)(110136005)(133343001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2023 18:15:52.5312
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eee5e4ee-04f6-4032-c1b0-08db5314ebfc
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT005.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8590
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
v3->v4:
    - Fix compiling reported by 'kernel test robot';
v2->v3:
    - Revise the commit message;
v1->v2:
    Updates for comments from Ulf:
    - Make the runtime PM logic generic for sdhci-of-dwcmshc;
v1: Initial version.
---
 drivers/mmc/host/sdhci-of-dwcmshc.c | 54 ++++++++++++++++++++++++++++-
 1 file changed, 53 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-of-dwcmshc.c b/drivers/mmc/host/sdhci-of-dwcmshc.c
index e68cd87998c8..2d780a5bc8fb 100644
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
@@ -646,7 +649,56 @@ static int dwcmshc_resume(struct device *dev)
 }
 #endif
 
-static SIMPLE_DEV_PM_OPS(dwcmshc_pmops, dwcmshc_suspend, dwcmshc_resume);
+#ifdef CONFIG_PM
+
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

