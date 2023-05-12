Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F76E70078D
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 14:21:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240614AbjELMVW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 08:21:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240338AbjELMVT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 08:21:19 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2079.outbound.protection.outlook.com [40.107.244.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF1578A7F;
        Fri, 12 May 2023 05:21:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bCK5JNWKbX2NVD5QB6gMD61rcA6ZNcrJVF6S+I25AMrXTBzUYVEA+HU750LnpVK6Fd966s4k9bm0hMCp/fPdKZoNXXVaHa2V6pTm8qPZR8MBUud+AEQDB3GQ2qexi5PEROsDNuauwsa0LvgXZQCiwhNEew9r6sD6IPVNaqDwAAa526FBm7TgcXt/JxRtCQNhZz1y6OY7vlWl1Scfweppclv3EIcXpAjNU2O3wyPqHCf5DM3gODTUjCFzkUbHn0QQfUqlmCdzqlulLV4697mDKnqAed3mP7He9VzdJdDmfiQadWJoLoGX2X6NBq5ivxKUnqzFlGVSo10VFfthmz4iBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B20a5gzSh43AMXrj0HIWHEThmg4z6S/3NF7Eau3L5jE=;
 b=QI99OhsuYGbKa98OuwtzrvLx3nts1SIc+IZc02vJb0jfOc9g0Ds7JYnqVEAXG3h2AQLf2r5wf1fTp8n5+xE/1HfbUHDxSJUPdysr7MoXhjtG3loaZP3HtrJtlHQR2SglfSYFS0hzID3Nvl4Zi9vKSvVp7uPuNpGz5kiEbgMTMI/OxlIBcmpc6tdDcmR0OpR/LdF4jjhxkCvDr/tXJ2wGejXi0amkOrh6Skk78f04lvfciAexK3ipNiDZi+vcmYmjEcFRHMn/b6sjrXQVL8dHLDf89kekkCQBvAZryOmKt5MFUJhKLk4M731xno8YNM8JAM0zEPTwuUerVW+mrdA6WA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B20a5gzSh43AMXrj0HIWHEThmg4z6S/3NF7Eau3L5jE=;
 b=t0TKrCVztkm2kzS/fQOXGkQ3t6kmMwNCUSxfM7h1GcnWptFzwxgTK/JIBaSdPVoistqTCZBJGXrrlhKZueAncHN/Ov9SP6u4Daj2bI8WcpnqfG1SS/4IfYdL3ZkRGQVmvFEAlJ/CzT8Lfg+uiNRzi2a8Fy1SnY8px2u2bqMf69MVeS8f5rql7boPiHs9FRdPfLbykusa0ySywvU23fG/YSwV3PF6ofOPTpnJ9gY2qTKi0cEjtX6itWvWQ/Rjx4cH/rEbhIFbBA0LfVUO8ZAObeUelIDRvQy9TXB+nndkK9N6maliOYV4QXgTan9a1/EFYLVdDTe+DCCRaeINRjdEZQ==
Received: from MW4PR04CA0047.namprd04.prod.outlook.com (2603:10b6:303:6a::22)
 by CH3PR12MB9217.namprd12.prod.outlook.com (2603:10b6:610:195::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.23; Fri, 12 May
 2023 12:21:15 +0000
Received: from CO1NAM11FT055.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:6a:cafe::44) by MW4PR04CA0047.outlook.office365.com
 (2603:10b6:303:6a::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.24 via Frontend
 Transport; Fri, 12 May 2023 12:21:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1NAM11FT055.mail.protection.outlook.com (10.13.175.129) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6387.24 via Frontend Transport; Fri, 12 May 2023 12:21:14 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Fri, 12 May 2023
 05:21:03 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Fri, 12 May
 2023 05:21:03 -0700
Received: from vdi.nvidia.com (10.127.8.12) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.986.37 via Frontend Transport; Fri, 12 May
 2023 05:21:02 -0700
From:   Liming Sun <limings@nvidia.com>
To:     Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        David Thompson <davthompson@nvidia.com>,
        Shawn Lin <shawn.lin@rock-chips.com>
CC:     Liming Sun <limings@nvidia.com>, <linux-mmc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v2] mmc: sdhci-of-dwcmshc: Add runtime PM operations for BlueField-3
Date:   Fri, 12 May 2023 08:20:56 -0400
Message-ID: <20230512122056.223677-1-limings@nvidia.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <79137159a833c164ea8ea3f05d8d6d9537db2f42.1683747334.git.limings@nvidia.com>
References: <79137159a833c164ea8ea3f05d8d6d9537db2f42.1683747334.git.limings@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT055:EE_|CH3PR12MB9217:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e7bd378-e386-4d93-64af-08db52e36118
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Bm29y2dr5JbiYJiWxV8tYyxZIzZDTq8I6trEhBkCQnA9Bc7ManAX5IQPNzO2GeGc7jqCmY4FLEniPdem/dHRIrUxPLy7m2porM4375J5WeoMVvX6+OmV+I5/mjEuYAHaPldxuGcg0hBnzxMzbME0fJ/r3TSMBf7xREYbgmnqhnc+UmLneGx6600YWD2z+UMIgWp+YjtMLAaO7qawK3BFisJqdzAkTwokBQSvNrByCByXNePsNMp0mW+MMfwuIEQRKP9tvvaOvdSMfzOhf6xaeHbTxCAWwN+0lQDUbxvARp6OLM7trArSZ73XujZs70G9pime6RVa/EtJ/R3EsXrFzJ5vv3TaI340JvGAJkTu7udQjtvViTT0bO7Y4E3tWdCQHIje4U6fCGuXk6yTqZxVh3MrE3KvnliN8Mtm3r0IQtxajI2DjfFWqzq4LHm+E2ouoppAmyq+uJa9O1G+y7EVz2lHI6s3HWniEuI5YkMVfdZwiuR6nGjxYukUFUxbXkODvJS0f4iA/imx0x7dpFDtdQzi4dw+bjtPsDJsGLIPDKBBqTZPbdLfl7M2sh/frlC4GTDoZmw1kibisKh6fIPksJD/3DMrZfCTxqhyHEyAa+aUWX+22BYG6xAEM7/eDY3ey9YRioOCq+J/e1xzEmjnneukHv1y5QgeLIAfiHejwVo/hhn7HTXiuBiuOkU4OnrzZZmOkZECYAip2B3YOleIn1tHkBu9GcEQ2p/IQHyxppcekKh2B5aNye/SC5NESG2hmqy7OX66IpRi7KyNRyhSWg==
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(396003)(136003)(346002)(376002)(39860400002)(451199021)(40470700004)(36840700001)(46966006)(8676002)(5660300002)(47076005)(2616005)(82310400005)(83380400001)(70586007)(336012)(36860700001)(70206006)(426003)(8936002)(36756003)(54906003)(86362001)(316002)(4326008)(41300700001)(110136005)(6666004)(186003)(1076003)(356005)(26005)(7696005)(478600001)(40460700003)(7636003)(2906002)(82740400003)(40480700001)(133343001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2023 12:21:14.2162
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e7bd378-e386-4d93-64af-08db52e36118
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT055.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9217
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

This commit implements the runtime PM operations for BlueField-3 SoC
to disable eMMC card clock when idle.

Signed-off-by: Liming Sun <limings@nvidia.com>
---
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

