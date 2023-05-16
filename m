Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3B17704A91
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 12:31:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232281AbjEPKbI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 06:31:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232182AbjEPKbC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 06:31:02 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2040.outbound.protection.outlook.com [40.107.94.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3FABE7C
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 03:31:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nXQixsyTj5T/BwtKM/FC2YoY6RJi/8EgTpoNfF+0xXDplCDm8lPnDgmwUZZg1bo8dUKpLbBAEz/kWlS/no9BhThFPW2hDZNtyJ87mxI9K748hMXvAcjqYurL35fL5sz7f+IuyBBMJkohAyRfqtYffUizCQHoMgdBCDJbgMT1bYAYj4SbTE2TVJgNE/TNU+sHE0utmLjc1n7YbI+DfhMHi1Nh94J0OK1C4rroun8NtGLm9F85ue2ARETGImt1uV393/mSPN7eKQU68Q4MH//GOfrXsniTIO8vHqHAgyRD73P7MFAtp8vN3rVZ/qJkBsgNWIMsy9QCp/lgOSHyJa2aWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HmRtY0Txh3nYKUzW8rrx2Q5E0dHFV9b/LKE7cEM8gJ8=;
 b=PzxZ1NBc2FvBS/FWf/vb2BjpaMMk32+R/zkbTxlPFLn27A1EnGGVtqDcRn20uZv3mwm/dNV2apE9R8CtowgrOUP6I+FWYbELXRg3EzU7C/h4QjAop9nUhk+WX0MBqlqchkfhpvwLvUotDpio9AH18JGDI1YVRnXp+FJbFkYpDTC+Ftg5D3yUR5IImxEAN/iItx7LjjDAfVZWuLSIhEPB9/cc2lgbeelqDT4NlqvbfIdYx4e3OjmSbrtTuP5xV1jdv9HJYXNIk6RjyIwAlS8rRXd+FTA6wg8Gm9I/ozD2WjLPobOqVuk8T0gZTwzYlo+Zn14KI6ZJbCNB6nHtOXfVpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HmRtY0Txh3nYKUzW8rrx2Q5E0dHFV9b/LKE7cEM8gJ8=;
 b=b2s82C+D2CXvDszVmzyL0RfySmNEH7s/0ksehkZB+ATROiUyhjQl4abTvG71OxiL/424c28uJcDNz7vzrxCfDMaw7iVpvlTTN5gix1Tquv1RScZEfXzz7tJf3Aad6jIJqKDwWxQGG2j4uCUHsBqWzJq+zJYginIMRwMbaSj6nSE=
Received: from DM6PR05CA0065.namprd05.prod.outlook.com (2603:10b6:5:335::34)
 by SA0PR12MB7463.namprd12.prod.outlook.com (2603:10b6:806:24b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.33; Tue, 16 May
 2023 10:30:57 +0000
Received: from DM6NAM11FT029.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:335:cafe::f9) by DM6PR05CA0065.outlook.office365.com
 (2603:10b6:5:335::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.14 via Frontend
 Transport; Tue, 16 May 2023 10:30:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT029.mail.protection.outlook.com (10.13.173.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6411.15 via Frontend Transport; Tue, 16 May 2023 10:30:57 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 16 May
 2023 05:30:57 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 16 May
 2023 05:30:56 -0500
Received: from vijendar-X570-GAMING-X.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.34
 via Frontend Transport; Tue, 16 May 2023 05:30:52 -0500
From:   Vijendar Mukunda <Vijendar.Mukunda@amd.com>
To:     <--to=broonie@kernel.org>
CC:     <alsa-devel@alsa-project.org>, <Basavaraj.Hiregoudar@amd.com>,
        <Sunil-kumar.Dommati@amd.com>, <Mastan.Katragadda@amd.com>,
        <Arungopal.kondaveeti@amd.com>,
        Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        "Syed Saba Kareem" <Syed.SabaKareem@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH 3/9] ASoC: amd: ps: add soundwire dma driver
Date:   Tue, 16 May 2023 16:05:37 +0530
Message-ID: <20230516103543.2515097-4-Vijendar.Mukunda@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230516103543.2515097-1-Vijendar.Mukunda@amd.com>
References: <20230516103543.2515097-1-Vijendar.Mukunda@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT029:EE_|SA0PR12MB7463:EE_
X-MS-Office365-Filtering-Correlation-Id: 8fe1cb05-6305-4579-a387-08db55f8a2eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xJyfE3S6fealWsf5uHTUcHzc5COhLLVldu6cGAfh9bl5mrf1p7r2RryyH3m0AgydSY3ypA7qLKYJB1pVc/hW/Q9UaqoZsYMn8iOcF1Aou8cJBMnk81hpqoJb++JZuegOrZCDt/9kfrjDrcucEaDDtBfTRK0QjKcIjjac6iM964eSKz1ab3DxzbnC3MyGMM/4YpBL28qSJ+VaXjwVFdRhSTKxidjH1vlHKDzYAl0hTqXb3YsGprX6R3xp/asYTwZM2rRuF4hode5gqSD528z4vRawRXv288XfASZxFwTHAnc91/p41p3L2MZX+0TyCgb3JU0Mf5Rfxxd8n+Y+nfSw7MvMscfSpUQFbi1CcUuvW2n8S+hivk05dTBo6QIwWgdBLxYoqaK1BQB2DpQ9sHrZwXWyhKN4CQaQgR+F12/Od29XPedyQYm2AJyvfubUIpue0y8byh5OgcQyqFint2JgEJcLwW1z76S40MYRq25ENoEVXT9y/MUTtdtIh3CQ7EPwiaTBTIMBIgve71BMcflZv7e1nh8I5H5DbW4k/kzhuwL6Vd61lOIE1QuFrPcX6H2Q4hQs+sXDA5dX7oyxAq8Z/K9x7bI5poYa1KzSuw2IQ2q7Vnkg6XIUwt8wN/mFIRP0jpLJIzTWjmWtKqBRj3tw9BSpQdvVelgeyLgjlsiVEuNy2o8JPQGz05e+i4ztdcwsJqu01Pl4DMC6QJrgz/IAqxwa7eeGlhC/0KV0J0TCa8gXg8rRgdQ6sEb/8Iq9Kfwzyx7cTBXGeFJCLduW+hdOAQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(136003)(376002)(346002)(39860400002)(396003)(451199021)(36840700001)(40470700004)(46966006)(36756003)(86362001)(54906003)(316002)(70586007)(70206006)(4326008)(478600001)(7696005)(40480700001)(6666004)(82310400005)(8936002)(8676002)(5660300002)(41300700001)(2906002)(81166007)(82740400003)(356005)(2616005)(336012)(1076003)(186003)(26005)(426003)(36860700001)(83380400001)(47076005)(40460700003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2023 10:30:57.5878
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fe1cb05-6305-4579-a387-08db55f8a2eb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT029.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB7463
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

Soundwire DMA platform driver binds to the platform device created by
ACP PCI device. Soundwire DMA driver registers ALSA DMA component
with ASoC framework.

Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
---
 sound/soc/amd/ps/acp63.h      |  5 +++
 sound/soc/amd/ps/ps-sdw-dma.c | 71 +++++++++++++++++++++++++++++++++++
 2 files changed, 76 insertions(+)
 create mode 100644 sound/soc/amd/ps/ps-sdw-dma.c

diff --git a/sound/soc/amd/ps/acp63.h b/sound/soc/amd/ps/acp63.h
index faf7be4d77c2..f86c60cd1565 100644
--- a/sound/soc/amd/ps/acp63.h
+++ b/sound/soc/amd/ps/acp63.h
@@ -111,6 +111,11 @@ struct pdm_dev_data {
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
index 000000000000..0d0889842413
--- /dev/null
+++ b/sound/soc/amd/ps/ps-sdw-dma.c
@@ -0,0 +1,71 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * AMD ALSA SoC Pink Sardine Soundwire DMA Driver
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
+	int status;
+
+	if (!pdev->dev.platform_data) {
+		dev_err(&pdev->dev, "platform_data not retrieved\n");
+		return -ENODEV;
+	}
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
+	sdw_data->acp_lock = pdev->dev.platform_data;
+	dev_set_drvdata(&pdev->dev, sdw_data);
+	status = devm_snd_soc_register_component(&pdev->dev,
+						 &acp63_sdw_component,
+						 NULL, 0);
+	if (status) {
+		dev_err(&pdev->dev, "Fail to register sdw dma component\n");
+		return -ENODEV;
+	}
+	return 0;
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

