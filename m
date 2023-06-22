Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BA5073A4D6
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 17:26:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232446AbjFVP0z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 11:26:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232431AbjFVP0p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 11:26:45 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2087.outbound.protection.outlook.com [40.107.92.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A5FA1FDC
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 08:26:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HH9beaWM3mhd7ya8egdfcyIXmP595QDYJM+FBJvGEUqsBwbrlwvBm+MoU6BjzJmM9c7MdsMmZjk762OrwCKFIGqBr+0vWErwD0PHa8YGOTnQaB/QirR9kK99AIrC3oez4lsH3VJO6JHHu3rEpV2zTXxrpeZu4xQc4+raGjsdgROXYHfGQDZpDoU4J0y/+wkXDjReSGme5m+gCXVHThGh1orVDa0qpHkY2b9Bbk9rpQDXLQ+saUA6mgJeg0uTTg2SJX6DMP++Dd9oD3jpkblciXgztftvsjgk3ApXcD+yXEGiK6Ti7TzW9qpcC8Zau5ynTWlygnD3jeWlO69VjGTAvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yI3RABJT8UJ6M1AbIKgLcTBeQk/w3uJCYhqBgvHJTQg=;
 b=YwERGQuNFbHSLoAZHsRU8KQzrqB/p/IcOWscUXtWXLt1EAiCHzOp2gLFZ3X4xFzmkpRrJxtV2vly/iO5aRgL4QRd/iDgUPuyemE2DD+DilAasgYPobK+kQLCpbzRy8NcPjxJI3Ab58cPwbY2czQmJPr/9kAsJ9BrATAzxIXAqQ8EhE6M/BiYD47s0D93IsmOZIED1lofYq/z5xHAF2gnUqMH5vgzeG0EadqlMNpl4hiUfTpygMSv3EvgtFFpzLaexCwWqUbzRhifBAoj2HkiROPgiIdGsp06Y7nvZMudjsoJoIoCH4/KPGEqQACxLsu+Q+4479gYiuVnyH/FLxin5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yI3RABJT8UJ6M1AbIKgLcTBeQk/w3uJCYhqBgvHJTQg=;
 b=zzyTTJAKFc3JKUfNPnMEU33rPD32RwuhhQKbtol38JSjawy3HJYxxogxdd7JWDW4VDriEbsl0tcCgsBSYTWe+eciYXuWvMj8ondcCZ4gNb63s4862a/FcgQOHBefIOXPkKgwtSqbVUmJgrjAFU081UpoveITup1fOi5uYgSts+U=
Received: from SA1PR04CA0010.namprd04.prod.outlook.com (2603:10b6:806:2ce::16)
 by IA0PR12MB8421.namprd12.prod.outlook.com (2603:10b6:208:40f::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Thu, 22 Jun
 2023 15:26:22 +0000
Received: from SA2PEPF00001509.namprd04.prod.outlook.com
 (2603:10b6:806:2ce:cafe::5d) by SA1PR04CA0010.outlook.office365.com
 (2603:10b6:806:2ce::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24 via Frontend
 Transport; Thu, 22 Jun 2023 15:26:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SA2PEPF00001509.mail.protection.outlook.com (10.167.242.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6521.19 via Frontend Transport; Thu, 22 Jun 2023 15:26:22 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Thu, 22 Jun
 2023 10:26:21 -0500
Received: from amd-B450M-DS3H.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.23 via Frontend
 Transport; Thu, 22 Jun 2023 10:26:18 -0500
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
        ye xingchen <ye.xingchen@zte.com.cn>,
        V sujith kumar Reddy <Vsujithkumar.Reddy@amd.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH 07/12] ASoC: amd: acp: add pm ops support for acp pci driver
Date:   Thu, 22 Jun 2023 20:53:50 +0530
Message-ID: <20230622152406.3709231-13-Syed.SabaKareem@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230622152406.3709231-1-Syed.SabaKareem@amd.com>
References: <20230622152406.3709231-1-Syed.SabaKareem@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001509:EE_|IA0PR12MB8421:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b21ad13-63ad-4d8c-a4fb-08db733508e9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: K6f1qX8r7WE4Ln30k6oIwvbpcLWfaCQMzUvFWvAmRTcDPCBynxJQ5Ucd/+S0tTNpRToKFQcLezm6Onv0Iej7wLMQLCI64/cR0Oq+RgUx2mT+3K6bxx7xU47Z3wuS3uz+IP8kEeYbdmN4oqdwYJaxeWzw8lvEwBvw/1l7Xl+Q4p8GfV26QTlvQttzXo37jal1vFW3acg440CuN4UmrA+5fCADi5wRXmLI0o2t4ZUgd7V39ElhAiJV1r2WNjmN37sDpdtqqw8Q5RDtF+x6Yjb/4yu7s6Ei1LEad0ocbeAoHOvO9HfHCbIa4GJOB6QARUAbVGWLK/7m7+ZAo387nrokA2eeBg7o1jUh2/9Jz4mjNRynBzL2KodyPqr+YkyYG1MvBJdV+vuSTMsaFrGEaKR23z/1GmzRLV9vOuip93YutfOFvtc1HBbEXZTbexfCx9d7E7I3H5aZe236cVVrgriclEw2LabFCzwHThB6vbe13PFgtuFw9ngHeKoYLK6jyFoeI8tB+9tqPaHnKkmnTuFQ/t8iGduWSoR721o2oi/68miBu01ggTKYqhvRuBcoRTbgtSU8BMdedIoYCmkvD1d310NeFE1fhg706KpwZd8wwQeLi+8SG8EvqMzYQIZ6hSQRy922KwnQVcbfGCYXvJxlejkkr7iA2yVVWsQCr+QPmdcKygJld7Lhg9pExC5T0YBDJcure7ThsAusGBZL1m5lVAebX/XtIxXDnMCRIh05hmxMjfsp4AiqLOGNHCeHDeBnbWmIAMmWA57noDvKnQDgZw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(396003)(376002)(39860400002)(451199021)(40470700004)(46966006)(36840700001)(54906003)(2616005)(86362001)(110136005)(478600001)(40480700001)(7696005)(6666004)(186003)(4326008)(41300700001)(316002)(47076005)(83380400001)(336012)(426003)(1076003)(26005)(70206006)(70586007)(82310400005)(8936002)(8676002)(5660300002)(36756003)(40460700003)(36860700001)(2906002)(82740400003)(356005)(81166007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2023 15:26:22.2422
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b21ad13-63ad-4d8c-a4fb-08db733508e9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00001509.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8421
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
 sound/soc/amd/acp/acp-pci.c | 45 +++++++++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/sound/soc/amd/acp/acp-pci.c b/sound/soc/amd/acp/acp-pci.c
index 0d91181364e3..73115ae78b6e 100644
--- a/sound/soc/amd/acp/acp-pci.c
+++ b/sound/soc/amd/acp/acp-pci.c
@@ -142,6 +142,11 @@ static int acp_pci_probe(struct pci_dev *pci, const struct pci_device_id *pci_id
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
@@ -154,12 +159,49 @@ static int acp_pci_probe(struct pci_dev *pci, const struct pci_device_id *pci_id
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
@@ -182,6 +224,9 @@ static struct pci_driver snd_amd_acp_pci_driver = {
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

