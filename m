Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 719A26D3DE7
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 09:13:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231482AbjDCHNu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 03:13:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231329AbjDCHN1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 03:13:27 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2061.outbound.protection.outlook.com [40.107.220.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8DB9CC1B
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 00:13:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MmMqEwrluihVwR+n1fvlixp6o3f6MuUP0ZBzHU7p5KnEI0B1SBv9pRyTmOVLHZt3Ta6l9Uz7SaTrzRLEut7lMM5CopD/WZNufBUzCP2FdbkVkCI1VWp0Aocu283tpM8jczTT8dDF7Oofdt5/PPK8e0Tk7BpbXWHW1VZ/3yjC76YjxbtxVPIYz95QYgeBgyVxDC/xikpmCxJeby0qiraKeCOoeYCsvwPwb5u8KzvW2fsLlrT6iyH4El9i73XKV+0ZDIGzDy804Ue6OxI9dcZVGu+ySCGiqdgUOTY/XrBdnHkUhjr29cMDZ0kA7VM4juypz35S8upQ7bgVfCNWyXTW8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8n/53dGixqmTf7EBH7T0wScMI5OtjUU7wS6fFwxFPYE=;
 b=GFdDfWUYRZLV/w6iiQx/2U5O2c4NX+1KCnQnSKYhRk6HD9C9MkL111ECl/qN1gVQIt3jCLx622h8j9FzhEPH0abik1yzWCmQHTUeKcv0TAmwXKXoTAC56NslwwktP/Z6PIRwNO/cTvwIlxGoUXrZG4biB1wgXNnGi8FfXdV9L+vEIcicJOrFLDgK6M6gh/JDCiSvR/+p0tInW+SG7hO9hcrJTWGOVlL4qCw6MjD9drnN/yzLMfHp7YGdNoyQpgS4XiXI/S8WO4fECh23SfmzmWRUxgW8C02DiUB5As7nahfAG9bCgGxdZF2TILipmGUJTv1mq4S8azRRrqmWrbTXuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8n/53dGixqmTf7EBH7T0wScMI5OtjUU7wS6fFwxFPYE=;
 b=bNc/eP21yulsZfkb4iGujmDgUAXjPh9sglMza7eGfyS0Wz92J1rtQkZZwpIgwU6IZpiJqTUftyk3fHetYuZnJWa17PJkxvfPhcU6meatZ/E9TRx0qWd0bX767gLhO4Qr4gApXhByLNvehruxEVfybdwdq3PFnKcOfq0o/K6yeQQ=
Received: from MW4PR03CA0143.namprd03.prod.outlook.com (2603:10b6:303:8c::28)
 by MN2PR12MB4343.namprd12.prod.outlook.com (2603:10b6:208:26f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.33; Mon, 3 Apr
 2023 07:13:19 +0000
Received: from CO1NAM11FT036.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8c:cafe::cd) by MW4PR03CA0143.outlook.office365.com
 (2603:10b6:303:8c::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.20 via Frontend
 Transport; Mon, 3 Apr 2023 07:13:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT036.mail.protection.outlook.com (10.13.174.124) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6277.16 via Frontend Transport; Mon, 3 Apr 2023 07:13:19 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 3 Apr
 2023 02:13:17 -0500
Received: from vijendar-X570-GAMING-X.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.34
 via Frontend Transport; Mon, 3 Apr 2023 02:13:13 -0500
From:   Vijendar Mukunda <Vijendar.Mukunda@amd.com>
To:     <broonie@kernel.org>
CC:     <alsa-devel@alsa-project.org>, <Basavaraj.Hiregoudar@amd.com>,
        <Sunil-kumar.Dommati@amd.com>,
        Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
        "Bard Liao" <yung-chuan.liao@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        "Ajit Kumar Pandey" <AjitKumar.Pandey@amd.com>,
        Rander Wang <rander.wang@intel.com>,
        "V sujith kumar Reddy" <Vsujithkumar.Reddy@amd.com>,
        Zheng Bin <zhengbin13@huawei.com>,
        "moderated list:SOUND - SOUND OPEN FIRMWARE (SOF) DRIVERS" 
        <sound-open-firmware@alsa-project.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/6] ASoC: SOF: amd: remove unused code
Date:   Mon, 3 Apr 2023 12:46:41 +0530
Message-ID: <20230403071651.919027-1-Vijendar.Mukunda@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT036:EE_|MN2PR12MB4343:EE_
X-MS-Office365-Filtering-Correlation-Id: 65a52ce6-16a6-4c62-cc45-08db3412e704
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Lusrul71Vey2OEtv9RLtKtGlf98I9JP17VvLKdogXbOEiewPlbq0GfB4uud0Px7J1yoF/ScHS1NgY2bCYo4rdImLBqIpj6SNoSQeU/5qc8vH2C8PhGu6iE9EgAPTLSBcOUio+fWQU78ZFgy7QOQx2/VuM841+xlMcGxYM1Hf5702BA0hBKguGhJIll12i78cwy+8fNm1WW4RSG1tDuaPgdxweAf5qfh77C+I/lFqndKPIhhOYmEFFKtv6KQrmzU5U2FbUMqs2SG6529KClIbIiDnEZZa7vSb8zx4rQz72mm7ray/0RBxjcLbOrQmzvV1efP9YuGEw54vhIKrK27uLRqmmrv6s13F0ZvBcah95o383HhWfnz8thRcUHHPQy6F3FLjot9kuCKclwIjuge+Ugy/DIJSHOsyuv5MJijGgjNvLnsl7Cq65GMMy1LMoEuISq0oi7bXvwrW3JTOjRLa9Ju6nOHWVM+1CfCEjmpXLzbZjK7yfHRNzCMZsCF9P+E+f7TUghgopr3V++tSMgftO1znivzlphaVF/L2Ov1BrVhH2Wri64APvi+LIW6kh+djXuNpBmy4M6vKbgYdQIZV5+YHmJWsKrukaDhR33qTUnFBi8vywOjPAx7Nlg2uNuVWELQo1Tjr2TSJDo15EYZTk44yp/+t+vTv7Im+dMHlC6r5L3AUale7ZxBOtZ5FLBGiI9/Mog3iBwwqno2Uy0kosN0U/ZpZv7yYipXsM3SKcOg=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(136003)(39860400002)(396003)(451199021)(40470700004)(46966006)(36840700001)(86362001)(36756003)(82310400005)(2906002)(40480700001)(2616005)(7696005)(336012)(426003)(83380400001)(186003)(47076005)(26005)(1076003)(6666004)(6916009)(4326008)(36860700001)(70586007)(8676002)(70206006)(40460700003)(41300700001)(81166007)(82740400003)(5660300002)(356005)(7416002)(316002)(54906003)(478600001)(8936002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2023 07:13:19.1401
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 65a52ce6-16a6-4c62-cc45-08db3412e704
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT036.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4343
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

During initial SOF driver bring up on AMD platforms, only DMIC
support was added. As of today, we have a complete SOF solution for
I2S endpoints along with DMIC endpoint.
This code is no longer required.
Remove unused code from RMB and RN platform ACP PCI driver.

Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
---
 sound/soc/sof/amd/pci-rmb.c | 70 +------------------------------------
 sound/soc/sof/amd/pci-rn.c  | 70 +------------------------------------
 2 files changed, 2 insertions(+), 138 deletions(-)

diff --git a/sound/soc/sof/amd/pci-rmb.c b/sound/soc/sof/amd/pci-rmb.c
index 4e1de462b431..d0a56e8f09c0 100644
--- a/sound/soc/sof/amd/pci-rmb.c
+++ b/sound/soc/sof/amd/pci-rmb.c
@@ -27,22 +27,6 @@
 #define ACP6x_REG_END		0x125C000
 
 static struct platform_device *dmic_dev;
-static struct platform_device *pdev;
-
-static const struct resource rembrandt_res[] = {
-	{
-		.start = 0,
-		.end = ACP6x_REG_END - ACP6x_REG_START,
-		.name = "acp_mem",
-		.flags = IORESOURCE_MEM,
-	},
-	{
-		.start = 0,
-		.end = 0,
-		.name = "acp_dai_irq",
-		.flags = IORESOURCE_IRQ,
-	},
-};
 
 static const struct sof_amd_acp_desc rembrandt_chip_info = {
 	.rev		= 6,
@@ -83,11 +67,8 @@ static const struct sof_dev_desc rembrandt_desc = {
 
 static int acp_pci_rmb_probe(struct pci_dev *pci, const struct pci_device_id *pci_id)
 {
-	struct platform_device_info pdevinfo;
 	struct device *dev = &pci->dev;
-	const struct resource *res_i2s;
-	struct resource *res;
-	unsigned int flag, i, addr;
+	unsigned int flag;
 	int ret;
 
 	flag = snd_amd_acp_find_config(pci);
@@ -104,53 +85,6 @@ static int acp_pci_rmb_probe(struct pci_dev *pci, const struct pci_device_id *pc
 		sof_pci_remove(pci);
 		return PTR_ERR(dmic_dev);
 	}
-
-	/* Register platform device only if flag set to FLAG_AMD_SOF_ONLY_DMIC */
-	if (flag != FLAG_AMD_SOF_ONLY_DMIC)
-		return 0;
-
-	addr = pci_resource_start(pci, 0);
-	res = devm_kzalloc(&pci->dev, sizeof(struct resource) * ARRAY_SIZE(rembrandt_res),
-			   GFP_KERNEL);
-	if (!res) {
-		platform_device_unregister(dmic_dev);
-		sof_pci_remove(pci);
-		return -ENOMEM;
-	}
-
-	res_i2s = rembrandt_res;
-	for (i = 0; i < ARRAY_SIZE(rembrandt_res); i++, res_i2s++) {
-		res[i].name = res_i2s->name;
-		res[i].flags = res_i2s->flags;
-		res[i].start = addr + res_i2s->start;
-		res[i].end = addr + res_i2s->end;
-		if (res_i2s->flags == IORESOURCE_IRQ) {
-			res[i].start = pci->irq;
-			res[i].end = res[i].start;
-		}
-	}
-
-	memset(&pdevinfo, 0, sizeof(pdevinfo));
-
-	/*
-	 * We have common PCI driver probe for ACP device but we have to support I2S without SOF
-	 * for some distributions. Register platform device that will be used to support non dsp
-	 * ACP's audio ends points on some machines.
-	 */
-	pdevinfo.name = "acp_asoc_rembrandt";
-	pdevinfo.id = 0;
-	pdevinfo.parent = &pci->dev;
-	pdevinfo.num_res = ARRAY_SIZE(rembrandt_res);
-	pdevinfo.res = &res[0];
-
-	pdev = platform_device_register_full(&pdevinfo);
-	if (IS_ERR(pdev)) {
-		dev_err(&pci->dev, "cannot register %s device\n", pdevinfo.name);
-		platform_device_unregister(dmic_dev);
-		sof_pci_remove(pci);
-		ret = PTR_ERR(pdev);
-	}
-
 	return ret;
 };
 
@@ -158,8 +92,6 @@ static void acp_pci_rmb_remove(struct pci_dev *pci)
 {
 	if (dmic_dev)
 		platform_device_unregister(dmic_dev);
-	if (pdev)
-		platform_device_unregister(pdev);
 
 	sof_pci_remove(pci);
 }
diff --git a/sound/soc/sof/amd/pci-rn.c b/sound/soc/sof/amd/pci-rn.c
index fca40b261671..faab4c33a24d 100644
--- a/sound/soc/sof/amd/pci-rn.c
+++ b/sound/soc/sof/amd/pci-rn.c
@@ -27,22 +27,6 @@
 #define ACP3x_REG_END		0x125C000
 
 static struct platform_device *dmic_dev;
-static struct platform_device *pdev;
-
-static const struct resource renoir_res[] = {
-	{
-		.start = 0,
-		.end = ACP3x_REG_END - ACP3x_REG_START,
-		.name = "acp_mem",
-		.flags = IORESOURCE_MEM,
-	},
-	{
-		.start = 0,
-		.end = 0,
-		.name = "acp_dai_irq",
-		.flags = IORESOURCE_IRQ,
-	},
-};
 
 static const struct sof_amd_acp_desc renoir_chip_info = {
 	.rev		= 3,
@@ -83,11 +67,8 @@ static const struct sof_dev_desc renoir_desc = {
 
 static int acp_pci_rn_probe(struct pci_dev *pci, const struct pci_device_id *pci_id)
 {
-	struct platform_device_info pdevinfo;
 	struct device *dev = &pci->dev;
-	const struct resource *res_i2s;
-	struct resource *res;
-	unsigned int flag, i, addr;
+	unsigned int flag;
 	int ret;
 
 	flag = snd_amd_acp_find_config(pci);
@@ -104,53 +85,6 @@ static int acp_pci_rn_probe(struct pci_dev *pci, const struct pci_device_id *pci
 		sof_pci_remove(pci);
 		return PTR_ERR(dmic_dev);
 	}
-
-	/* Register platform device only if flag set to FLAG_AMD_SOF_ONLY_DMIC */
-	if (flag != FLAG_AMD_SOF_ONLY_DMIC)
-		return 0;
-
-	addr = pci_resource_start(pci, 0);
-	res = devm_kzalloc(&pci->dev, sizeof(struct resource) * ARRAY_SIZE(renoir_res), GFP_KERNEL);
-	if (!res) {
-		sof_pci_remove(pci);
-		platform_device_unregister(dmic_dev);
-		return -ENOMEM;
-	}
-
-	res_i2s = renoir_res;
-	for (i = 0; i < ARRAY_SIZE(renoir_res); i++, res_i2s++) {
-		res[i].name = res_i2s->name;
-		res[i].flags = res_i2s->flags;
-		res[i].start = addr + res_i2s->start;
-		res[i].end = addr + res_i2s->end;
-		if (res_i2s->flags == IORESOURCE_IRQ) {
-			res[i].start = pci->irq;
-			res[i].end = res[i].start;
-		}
-	}
-
-	memset(&pdevinfo, 0, sizeof(pdevinfo));
-
-	/*
-	 * We have common PCI driver probe for ACP device but we have to support I2S without SOF
-	 * for some distributions. Register platform device that will be used to support non dsp
-	 * ACP's audio ends points on some machines.
-	 */
-
-	pdevinfo.name = "acp_asoc_renoir";
-	pdevinfo.id = 0;
-	pdevinfo.parent = &pci->dev;
-	pdevinfo.num_res = ARRAY_SIZE(renoir_res);
-	pdevinfo.res = &res[0];
-
-	pdev = platform_device_register_full(&pdevinfo);
-	if (IS_ERR(pdev)) {
-		dev_err(&pci->dev, "cannot register %s device\n", pdevinfo.name);
-		sof_pci_remove(pci);
-		platform_device_unregister(dmic_dev);
-		ret = PTR_ERR(pdev);
-	}
-
 	return ret;
 };
 
@@ -158,8 +92,6 @@ static void acp_pci_rn_remove(struct pci_dev *pci)
 {
 	if (dmic_dev)
 		platform_device_unregister(dmic_dev);
-	if (pdev)
-		platform_device_unregister(pdev);
 
 	return sof_pci_remove(pci);
 }
-- 
2.34.1

