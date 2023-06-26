Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0D3873E13E
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 15:57:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230326AbjFZN5H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 09:57:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230340AbjFZN44 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 09:56:56 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54ABD19B2
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 06:56:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lpixx9zlQD9eE5fsEseDfTnFCZPb5F0/y2V1HLA6pDEfiVmhwC77wb2Yhqc83mW4XrxWaCks/i3uLCamcJg7DvTUjYKq079MykTN0+DEptzKdIvM76jNZfLs+KU5k10y5xRkUS4lWPM0kZfrOu0WkS5GhLxM7nw2g5Bjfs+P66XYhtEpfZQ89qbVGus0oiM5fQw6UzuX1S3uT5zIvU++nO5fVpahqqW1Y7eDvPFQSG4RrcH6WkC5ADKRii5VQfkyLw+CSiODhvzZcJhetg2uhlx9BegmWNBkchlIH3MlgC+9tOtRqL5Hd5ijeRW6NdMdnN9rgU4PQu5SWEGCdbJHkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BdPaERuCtjsdY/S8TxeN4zDOW7M7MUou1Je8PsF8w7A=;
 b=f+dKPC28H0TefZQ1Kp0vPc9Dd660w7m82FFHWfqBJjErXeI7WAJj+DmbZSmVJIHc5BypOVVmnIT+80x+5POTECkYZklUyvT795or10EAjSuL+KID0ltOrb5SJIZONhHNKO7CDkQiunXOCd8i5O8zh5IYdjh0ykcGmdU6Pe/CJa4fAojvcwRnjcaKfG/6qF/WxgP/LzYg9x1duicIV5od9zRSJ4q4MYN6ff83TXFST3Ow6rsuIhxdii7B4Y6Kq8TceY/B4el/m8bdxT66L4DQGKmZZR7hbgngwT2bADCMcHH2jzxOOgaZh3FQ7itBRcbl9bUBynOgtgOKZAwY+yNHoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BdPaERuCtjsdY/S8TxeN4zDOW7M7MUou1Je8PsF8w7A=;
 b=xKyd98YTUUL2ZNOdPxjWC8S3CIBHC1E4K9KsSqU7ifxQp+mgT3/5mzxYTN5OUX2jOt+DIwoWHQqZNNXyhUd3JCZsLKNsTpg4M9UFmtU6vYthOw4gfTlS5T736DcT6K95T7xFBVPbaezpOWi//g70YKn4zBibPbiUS3OZGd+cFP4=
Received: from BN9PR03CA0782.namprd03.prod.outlook.com (2603:10b6:408:13f::7)
 by PH7PR12MB6395.namprd12.prod.outlook.com (2603:10b6:510:1fd::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Mon, 26 Jun
 2023 13:56:33 +0000
Received: from BN8NAM11FT098.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:13f:cafe::d2) by BN9PR03CA0782.outlook.office365.com
 (2603:10b6:408:13f::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.33 via Frontend
 Transport; Mon, 26 Jun 2023 13:56:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT098.mail.protection.outlook.com (10.13.177.196) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6500.47 via Frontend Transport; Mon, 26 Jun 2023 13:56:33 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Mon, 26 Jun
 2023 08:56:32 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Mon, 26 Jun
 2023 08:56:32 -0500
Received: from amd-B450M-DS3H.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.23 via Frontend
 Transport; Mon, 26 Jun 2023 08:56:28 -0500
From:   Syed Saba Kareem <Syed.SabaKareem@amd.com>
To:     <broonie@kernel.org>, <alsa-devel@alsa-project.org>
CC:     <Vijendar.Mukunda@amd.com>, <Basavaraj.Hiregoudar@amd.com>,
        <Sunil-kumar.Dommati@amd.com>,
        Syed Saba Kareem <Syed.SabaKareem@amd.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Yang Yingliang <yangyingliang@huawei.com>,
        Venkata Prasad Potturu <venkataprasad.potturu@amd.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        ye xingchen <ye.xingchen@zte.com.cn>,
        "V sujith kumar Reddy" <Vsujithkumar.Reddy@amd.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 05/10] ASoC: amd: acp: add pm ops support for acp pci driver
Date:   Mon, 26 Jun 2023 19:25:09 +0530
Message-ID: <20230626135515.1252063-6-Syed.SabaKareem@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230626135515.1252063-1-Syed.SabaKareem@amd.com>
References: <20230626135515.1252063-1-Syed.SabaKareem@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT098:EE_|PH7PR12MB6395:EE_
X-MS-Office365-Filtering-Correlation-Id: 239b0479-60cf-4b9b-8364-08db764d2686
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fRdGlBTMh8froZlhVTklVewoNvUrJlRBUiozhdJh/M6YhssBOOW8UHSJ/C/B3Z5YjyatPTOTqP+o8kqN7CGKe14dAKGQ+sNyCccu6wnt9+kk6J8ZDD6N3AHg/BmxOoZoQ6EqJr3u6q7faD2djbPxDM3V6OK0uW/s4OhTaRN2oWTeGTXd+UoeFPNuRh8XOPQPzbVDgzgrasU6NNngCCizEqkUXsEPR1OGEI47qiRHidcEtjcW5JBb8tJjaTh3fNbB5QnwOaIXlem4JOljE1AEAVO/AvDruLhSS/tnEg4A6xMt0W7vQMzCsODaLFcBaEtU6UnMQOzJUnwXzqfZY7lvkzeeCmxT3oECIYrZv4FWWectgA3Uv4ZPKbuW23/pKzMzPHV0UBpMPVEqStU+13SqyLJwvRDqTTYiTOxR/uHMVLhMkCrrx21jZLgLA3snPhJQPdbgRwEGA/rM0fMUDPT2ioh6dWaiZBo0SNP+MUEj/D2DupaV7oGzFrrjr3Ws7/mDQHBK7Tnr4YOAVNwOGuqMvUvBgicoF0Eus/KygkIRrbgtfjwphwIS6Uf5IVl1b7LhBsLMYvX22FqmO0KcmgVxg1dFOS1e18x3fdslBsiN5X66l2G6k11q3AI5ipH8+Brx20MTQaRQxETtkw3nvbKS+8dqphZZ3PfxYfB7VHkt0LIL3pD5j+WJexO+tTxLXFfw4GdTzR9QsNObHnojL1rN8CmiClynunsBJCSAaYoJKoCgZzcAXpW6IZV7JGGOPbB2ht0RYVBAJxGHM2dGoFkj2w==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(376002)(136003)(346002)(396003)(451199021)(40470700004)(36840700001)(46966006)(40460700003)(2906002)(7696005)(82310400005)(82740400003)(356005)(6666004)(81166007)(2616005)(83380400001)(336012)(426003)(186003)(1076003)(47076005)(26005)(36860700001)(41300700001)(86362001)(54906003)(110136005)(478600001)(40480700001)(70586007)(70206006)(36756003)(316002)(4326008)(8936002)(8676002)(5660300002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2023 13:56:33.3497
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 239b0479-60cf-4b9b-8364-08db764d2686
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT098.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6395
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add pm ops support for common acp pci driver.

Signed-off-by: Syed Saba Kareem <Syed.SabaKareem@amd.com>
---
 sound/soc/amd/acp/acp-pci.c | 46 +++++++++++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/sound/soc/amd/acp/acp-pci.c b/sound/soc/amd/acp/acp-pci.c
index 4fedad1b740e..a32c14a109b7 100644
--- a/sound/soc/amd/acp/acp-pci.c
+++ b/sound/soc/amd/acp/acp-pci.c
@@ -16,6 +16,7 @@
 #include <linux/pci.h>
 #include <linux/platform_device.h>
 #include <linux/module.h>
+#include <linux/pm_runtime.h>
 
 #include "amd.h"
 #include "../mach-config.h"
@@ -141,6 +142,11 @@ static int acp_pci_probe(struct pci_dev *pci, const struct pci_device_id *pci_id
 		goto unregister_dmic_dev;
 	}
 	chip->chip_pdev = pdev;
+	dev_set_drvdata(&pci->dev, chip);
+	pm_runtime_set_autosuspend_delay(&pci->dev, 2000);
+	pm_runtime_use_autosuspend(&pci->dev);
+	pm_runtime_put_noidle(&pci->dev);
+	pm_runtime_allow(&pci->dev);
 	return ret;
 
 unregister_dmic_dev:
@@ -153,12 +159,49 @@ static int acp_pci_probe(struct pci_dev *pci, const struct pci_device_id *pci_id
 	return ret;
 };
 
+static int __maybe_unused snd_acp_suspend(struct device *dev)
+{
+	struct acp_chip_info *chip;
+	int ret;
+
+	chip = dev_get_drvdata(dev);
+	ret = acp_deinit(chip->base);
+	if (ret)
+		dev_err(dev, "ACP de-init failed\n");
+	return ret;
+}
+
+static int __maybe_unused snd_acp_resume(struct device *dev)
+{
+	struct acp_chip_info *chip;
+	struct acp_dev_data *adata;
+	struct device child;
+	int ret;
+
+	chip = dev_get_drvdata(dev);
+	ret = acp_init(chip);
+	if (ret)
+		dev_err(dev, "ACP init failed\n");
+	child = chip->chip_pdev->dev;
+	adata = dev_get_drvdata(&child);
+	if (adata)
+		acp_enable_interrupts(adata);
+	return ret;
+}
+
+static const struct dev_pm_ops acp_pm_ops = {
+	SET_RUNTIME_PM_OPS(snd_acp_suspend, snd_acp_resume, NULL)
+	SET_SYSTEM_SLEEP_PM_OPS(snd_acp_suspend, snd_acp_resume)
+};
+
 static void acp_pci_remove(struct pci_dev *pci)
 {
 	struct acp_chip_info *chip;
 	int ret;
 
 	chip = pci_get_drvdata(pci);
+	pm_runtime_forbid(&pci->dev);
+	pm_runtime_get_noresume(&pci->dev);
 	if (dmic_dev)
 		platform_device_unregister(dmic_dev);
 	if (pdev)
@@ -181,6 +224,9 @@ static struct pci_driver snd_amd_acp_pci_driver = {
 	.id_table = acp_pci_ids,
 	.probe = acp_pci_probe,
 	.remove = acp_pci_remove,
+	.driver = {
+		.pm = &acp_pm_ops,
+	},
 };
 module_pci_driver(snd_amd_acp_pci_driver);
 
-- 
2.25.1

