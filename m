Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E283373A4D1
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 17:26:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232441AbjFVP0q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 11:26:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229832AbjFVP0k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 11:26:40 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2064.outbound.protection.outlook.com [40.107.102.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58E45E6E
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 08:26:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bd/jMEhVUb1FhrgHdlSJFLRjYo6CTD2kipb3VgGh3TCG/8nKCy1kBjiPjZCKcdklAcPXY1MitsbUK0T1tELJM2exsNtEDXrALS+bhhcF13aRjtmoG5OKSxslFa8ITVVCMdZOoU4aPVPeE/nkl+6l408BLUeQPRYKDSGOHt709lm4/X+NfSlf5OVsOPgV900Eq3kyp/S7V5RSf+6olyISMoWxWZGLbvv6kz+LjIoBs8iaBFLOKG9GEwd083978AGxhU5ZDSIeox3scs+4eCZKv80X0W7FyhrVuRwM98IOs8l07p9l6upyb19uxCYuwDtqrRAuWtbwJ7j57bLV2lSG0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yI3RABJT8UJ6M1AbIKgLcTBeQk/w3uJCYhqBgvHJTQg=;
 b=l2vr7UPYzkkpNzcExbIzwtvyMbTFn+XoRKcoSIxuoLNj9seI/Gb8fDesKIlMN9haXtwsC7S2g5wBdOIqn9SIFtlN4Mow3J1oWJCPUf7OzOSnIkiCOgJPx5my5GBMjS1CIRiyTAmQArMvAK+5yDHmUQzAget0jBa9I/TcwMLluV7is+3b1fAnDeLT5qRIOvO20CaUzNtLj0qYJixgY3IVqMO4ZSu/S/6OmHWQrAJePmSE8KToTnPVeQzp4njXiNMWuuZln0aIxllcsI2ta4/Q5smkfPGihJFnB6E/y2AJlTWZ69mnGFafGql58kcJ0YxRJoEWOmhz2FQCtJIsQej+aQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yI3RABJT8UJ6M1AbIKgLcTBeQk/w3uJCYhqBgvHJTQg=;
 b=iSox3bTCRVWosEqS5kgoJCsbu58Ow8rSPOhDE8Tf5rwYvUqVmFpH14pGE3MLQ71b2UfBKjpJvm2dYbtVn1DKoTlScW8B2h40Mv89yNimqkLItwtaGKVU9oYxAT99zoA6Tf7jGGvShwDSvyhZ6qFU9xZHu42y/wn/g9w4ZpZcL8M=
Received: from BY5PR04CA0025.namprd04.prod.outlook.com (2603:10b6:a03:1d0::35)
 by DM4PR12MB7574.namprd12.prod.outlook.com (2603:10b6:8:10e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.21; Thu, 22 Jun
 2023 15:26:16 +0000
Received: from CO1PEPF000042AC.namprd03.prod.outlook.com
 (2603:10b6:a03:1d0:cafe::32) by BY5PR04CA0025.outlook.office365.com
 (2603:10b6:a03:1d0::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24 via Frontend
 Transport; Thu, 22 Jun 2023 15:26:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000042AC.mail.protection.outlook.com (10.167.243.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6477.13 via Frontend Transport; Thu, 22 Jun 2023 15:26:16 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Thu, 22 Jun
 2023 10:26:10 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Thu, 22 Jun
 2023 10:26:10 -0500
Received: from amd-B450M-DS3H.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.23 via Frontend
 Transport; Thu, 22 Jun 2023 10:26:06 -0500
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
        V sujith kumar Reddy <Vsujithkumar.Reddy@amd.com>,
        ye xingchen <ye.xingchen@zte.com.cn>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH 06/11] ASoC: amd: acp: add pm ops support for acp pci driver
Date:   Thu, 22 Jun 2023 20:53:48 +0530
Message-ID: <20230622152406.3709231-11-Syed.SabaKareem@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230622152406.3709231-1-Syed.SabaKareem@amd.com>
References: <20230622152406.3709231-1-Syed.SabaKareem@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AC:EE_|DM4PR12MB7574:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ca7f38e-1f12-45de-4e9e-08db73350590
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Z2/AoygkLC4DGZIqX+r5okpKhmNeYD5mfyCSR8oiC3dAMWc/vkWGgN3Sj4tHSOhiGc1GZYng+HSVndvyL/FUh0CxEGi5mFcOwiWfq1hSZU2gSI7jokcIUPth5buPm8hFLkARcQr6//ouGMpMw2cdIKi93jvu+9Srgpa57xFVIZgABpEfUAzFaWnjdiQHuIRCNqlCWaKBy+JDpVJjQM96JQWXnWcGv7ksxluF/l/1ptQOK4sGTwWkKCKKF+Jo6X/pJAUHX9EZ3rSCYqIBbC9aBBBEZWSNP14ICvloBMpXwOnMYUCZLDLlT4wEo6i190m7RuLKhJlwcdzjZY3k0MenqNrpeR8ap8kxy59/iGBs99Gan0wK0wo4UWMPLzynvcuSzm00fhmOgVp7qgAixUVyyO3w21y5+3UelzXkSBlOmeiZCytiI0KXbweNBZcW8dcGukOxKqIf4IMPy+TUO6euJu6I+kdaY53sYFMcVjBMRuR+WmZMnaPXStQLdKVSBRCHl5ksBWMQNXQXCXgKh0bSQCB92e4R6ho3W88Mcxdo/zjCAMzL7WsrhnPCkOLbwQ897CCveXUQpKUpGkdJ/5eb9IAyvcK8hC4sMqkSpW1oSZM1x1lYFwSRdLl31HPCw6LAqUqmkAoM/sjAlm3beWmXZr7iX09wmgKvnN7HmUs10k3B8PtIotk/UDPl65NX+sFOvPVdXxnkHNaYF3LoeVxN7PxO5oZ5PDnOKDqZ86DjoaDZn8Hc+SXcpgkAcuJl11nRM+6VX0+RMyyRhpKCpEVKbg==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(376002)(39860400002)(396003)(346002)(136003)(451199021)(46966006)(36840700001)(40470700004)(40460700003)(5660300002)(2906002)(40480700001)(82310400005)(8676002)(81166007)(47076005)(356005)(83380400001)(426003)(36860700001)(36756003)(86362001)(82740400003)(6666004)(4326008)(8936002)(478600001)(70206006)(70586007)(110136005)(7696005)(54906003)(26005)(41300700001)(186003)(336012)(2616005)(316002)(1076003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2023 15:26:16.5298
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ca7f38e-1f12-45de-4e9e-08db73350590
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000042AC.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7574
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

