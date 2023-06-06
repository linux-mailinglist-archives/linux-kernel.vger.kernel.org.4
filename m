Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0E48723717
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 08:03:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234328AbjFFGD4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 02:03:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234266AbjFFGDg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 02:03:36 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2066.outbound.protection.outlook.com [40.107.93.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB8CDE53
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 23:03:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G74EanOnqsKIUVBBPgkfUShjJO5xmkdZXK6S9GQV5yMIcssbHPDg4hGodN1L7M/hgPuo/Ln+SikTRcJtCeZvehxZds+NiCKwCAyzD11dhFHdffogKEZ+dvY18kIhsexXiPIFI68XTmPdo2HnXFR/pOQEN+zeyz/JldzpoBYsEzBEz9VyF223XIXVtRYhElV7zy6BYeecaKTdXNu14ezkXvx+MOSMZhgslx5/oon3mmDPZ0ch54KHV4BJXWa5Qyl0lvVg4DmZZFxNH+oxKT21Zb67gpHqYGkJredRzLNX/Jx9/Bj7Go6tcTNT2z8PW/yxe2q0X38g/GQ/mvVTRUhlqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=twoCGJpQ6V/EExLrJq3iCdSBBhN9xGh7GPm+jOK6mcU=;
 b=Xiaw+KKzHisvMV0P00gOohVIaWcUqYdSC3nx07JDG5Si4lJ7F8yoZfsg0AbOMV3Tb4MIoZE67kZW2He4Wy/94ZNNhPiFXyIN7XeS/twml9jyAucoUhz68uTlULki/Xh1iAw0UD1SWuoJvnKlm9xNxP1tl0K3lgZAWFZYvJ18I7sLxHGiMxEHbhUNeL2EVHGKS0S/4YGKntUbC2yDgXj3kuiE6pNrxzUvhCj3FUIZX9ojF00nfjhzP5E58nTug43tev0TQ0ROeGC2XMn3DkRxm1gYgonUU6KVC9hOWuzFUOKFAKqZoQXYB9AaNkK1FVFUA/TbVJe2Z7JfpLV/7t2ILA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=twoCGJpQ6V/EExLrJq3iCdSBBhN9xGh7GPm+jOK6mcU=;
 b=HYJkfKV8/WtM43My9MHoIq8q0HSnYwKrZrkS0mcmaD/nEHH8pQK7HZs5N+kbQKUcnWY2ypkoPIekDCBTqVPNlOkzrgbBf9qdN4qrcvXG78b6hED8oopsIDOQgILNODGrE0+Sgzp9Um7J/8uZ2kivgQHeJn2tjtuUvO2pYP0jS7Y=
Received: from DM6PR07CA0073.namprd07.prod.outlook.com (2603:10b6:5:337::6) by
 CH3PR12MB8756.namprd12.prod.outlook.com (2603:10b6:610:17f::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6455.33; Tue, 6 Jun 2023 06:03:16 +0000
Received: from CY4PEPF0000EDD3.namprd03.prod.outlook.com
 (2603:10b6:5:337:cafe::d8) by DM6PR07CA0073.outlook.office365.com
 (2603:10b6:5:337::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33 via Frontend
 Transport; Tue, 6 Jun 2023 06:03:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EDD3.mail.protection.outlook.com (10.167.241.207) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6477.13 via Frontend Transport; Tue, 6 Jun 2023 06:03:15 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 6 Jun
 2023 01:03:15 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 6 Jun
 2023 01:02:59 -0500
Received: from vijendar-X570-GAMING-X.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.34
 via Frontend Transport; Tue, 6 Jun 2023 01:02:55 -0500
From:   Vijendar Mukunda <Vijendar.Mukunda@amd.com>
To:     <broonie@kernel.org>
CC:     <alsa-devel@alsa-project.org>,
        <pierre-louis.bossart@linux.intel.com>,
        <Basavaraj.Hiregoudar@amd.com>, <Sunil-kumar.Dommati@amd.com>,
        <Mastan.Katragadda@amd.com>, <Arungopal.kondaveeti@amd.com>,
        <mario.limonciello@amd.com>,
        Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Syed Saba Kareem <Syed.SabaKareem@amd.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH V3 3/9] ASoC: amd: ps: add SoundWire dma driver
Date:   Tue, 6 Jun 2023 11:37:18 +0530
Message-ID: <20230606060724.2038680-4-Vijendar.Mukunda@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230606060724.2038680-1-Vijendar.Mukunda@amd.com>
References: <20230606060724.2038680-1-Vijendar.Mukunda@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD3:EE_|CH3PR12MB8756:EE_
X-MS-Office365-Filtering-Correlation-Id: 2aef7b2c-c465-4e92-04f9-08db6653b818
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +zhxQgAG3jwSbteKo2ddLe4mFQT/AtZY72IAlJwXq9wEv0DsCeSEBBDzvPYjAOi48rfnzUZUkM32u28DJq6yciKn4ac4WAh/qgIE/cklCNi3xVXB4/k8+7VGST4tea/fU3fMxMWYhOtbXXx5L7LD/nSvaGDoYiwq5YvVCrNtfBKPRCpaQXtEFx7GF4A4R4upz77r6kfiv0jw5SB2GkOPN94yeI8vmnc/TfPc6CaoNAjZEAztJHaOnQZg/7q6+P+f1Cy1qsTbUls12TxPUtY8gLP3SdaM/B3ptk0iAjzckyIqi/A4hfYbXF0ISK7DhH5hDvd0wy1aMD4aRFOrj7lBS6jP3zy4bar6xb1z8JPqseZERW/MBPQS5DV0xRODIigNHs3cKmQwho1NHHYJgLMzYU4OnpUR7XdvSfTjht1O55356591pz7ObakWq37n9PEtvDbwoPWtMy+z6mpwbdc/2FDgzqfZTWOv+NTH+Pry6ToqlrJmT3gu5HxJp3J9BWjqsAuq0LZjGepWw5UHKGv3abnBxkuuIjM20pvUbMpXiE7GQkLH3N3ZE/hjAEQHjTrzrCpxe+Lcm3C/OEb9jyGMjBar2fHM3I/cKbbmiivIEDvKt46JFo7pK45oCBgeziIMbw4me/tnDvuhgtCmm7lwKMhdPD0uqzspTrmBFpaSdV0OMYF75LxR609mmRmiIRRRjKwhJLc1ZlwMUyr2mJ+xALiDrcM+X8EFzrrBxyyp3psKl1uNGxhyV45Hx9NzasLGk7oDoS0Fy4E5cW66hoTYTQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(376002)(396003)(39860400002)(451199021)(46966006)(40470700004)(36840700001)(54906003)(40460700003)(40480700001)(478600001)(6916009)(8936002)(8676002)(2906002)(36756003)(86362001)(5660300002)(82310400005)(4326008)(81166007)(316002)(70206006)(70586007)(356005)(82740400003)(2616005)(41300700001)(1076003)(26005)(36860700001)(47076005)(83380400001)(186003)(7696005)(6666004)(336012)(426003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2023 06:03:15.8864
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2aef7b2c-c465-4e92-04f9-08db6653b818
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD3.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8756
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

SoundWire DMA platform driver binds to the platform device created by
ACP PCI device. SoundWire DMA driver registers ALSA DMA component
with ASoC framework.

Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
---
 sound/soc/amd/ps/acp63.h      |  5 +++
 sound/soc/amd/ps/ps-sdw-dma.c | 70 +++++++++++++++++++++++++++++++++++
 2 files changed, 75 insertions(+)
 create mode 100644 sound/soc/amd/ps/ps-sdw-dma.c

diff --git a/sound/soc/amd/ps/acp63.h b/sound/soc/amd/ps/acp63.h
index d296059be4f0..eec58da7ec8b 100644
--- a/sound/soc/amd/ps/acp63.h
+++ b/sound/soc/amd/ps/acp63.h
@@ -148,6 +148,11 @@ struct pdm_dev_data {
 	struct snd_pcm_substream *capture_stream;
 };
 
+struct sdw_dma_dev_data {
+	void __iomem *acp_base;
+	struct mutex *acp_lock; /* used to protect acp common register access */
+};
+
 /**
  * struct acp63_dev_data - acp pci driver context
  * @acp63_base: acp mmio base
diff --git a/sound/soc/amd/ps/ps-sdw-dma.c b/sound/soc/amd/ps/ps-sdw-dma.c
new file mode 100644
index 000000000000..f4a8d4022dc8
--- /dev/null
+++ b/sound/soc/amd/ps/ps-sdw-dma.c
@@ -0,0 +1,70 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * AMD ALSA SoC Pink Sardine SoundWire DMA Driver
+ *
+ * Copyright 2023 Advanced Micro Devices, Inc.
+ */
+
+#include <linux/err.h>
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <sound/pcm_params.h>
+#include <sound/soc.h>
+#include <sound/soc-dai.h>
+#include "acp63.h"
+
+#define DRV_NAME "amd_ps_sdw_dma"
+
+static const struct snd_soc_component_driver acp63_sdw_component = {
+	.name		= DRV_NAME,
+};
+
+static int acp63_sdw_platform_probe(struct platform_device *pdev)
+{
+	struct resource *res;
+	struct sdw_dma_dev_data *sdw_data;
+	struct acp63_dev_data *acp_data;
+	struct device *parent;
+	int status;
+
+	parent = pdev->dev.parent;
+	acp_data = dev_get_drvdata(parent);
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!res) {
+		dev_err(&pdev->dev, "IORESOURCE_MEM FAILED\n");
+		return -ENODEV;
+	}
+
+	sdw_data = devm_kzalloc(&pdev->dev, sizeof(*sdw_data), GFP_KERNEL);
+	if (!sdw_data)
+		return -ENOMEM;
+
+	sdw_data->acp_base = devm_ioremap(&pdev->dev, res->start, resource_size(res));
+	if (!sdw_data->acp_base)
+		return -ENOMEM;
+
+	sdw_data->acp_lock = &acp_data->acp_lock;
+	dev_set_drvdata(&pdev->dev, sdw_data);
+	status = devm_snd_soc_register_component(&pdev->dev,
+						 &acp63_sdw_component,
+						 NULL, 0);
+	if (status)
+		dev_err(&pdev->dev, "Fail to register sdw dma component\n");
+
+	return status;
+}
+
+static struct platform_driver acp63_sdw_dma_driver = {
+	.probe = acp63_sdw_platform_probe,
+	.driver = {
+		.name = "amd_ps_sdw_dma",
+	},
+};
+
+module_platform_driver(acp63_sdw_dma_driver);
+
+MODULE_AUTHOR("Vijendar.Mukunda@amd.com");
+MODULE_DESCRIPTION("AMD ACP6.3 PS SDW DMA Driver");
+MODULE_LICENSE("GPL");
+MODULE_ALIAS("platform:" DRV_NAME);
-- 
2.34.1

