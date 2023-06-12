Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57D8E72BE88
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 12:14:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233269AbjFLKOS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 06:14:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231304AbjFLKNx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 06:13:53 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2074.outbound.protection.outlook.com [40.107.220.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CA9C49F8
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 02:55:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hVb+RW4cgscoqw2wyAg8P19QJr8aQGdPDUP+DDKdCO5eb6EDTST+yR9TlflAQoC/elXB5Z2Tpi4rUQzs7mgtC/o4aEw9vUrm13kDG3BprZZVOzJ5dQ/E/QUGG+uhJ7EgTf7jiCSDBeaWeOxUDswHh9C9RoPRxd72aEwIHhbg1l9GS92KmXldwmeP6mBeMBOMb25TG+6ytizcjDKYdMX+6sCeHv2yEuCacOO+6/1YozkBXXfvc+B3nIMLz20iTWSDA0ZXL0jrOjHwPuKbEoL1PPcpmxa3kEx2jntrPcjntSondtbfSoeqV2og4kyboRkixlmBXBkQ/0EJpWtUDxGfGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+ip7ilKxJTP49WkipSwFVArmHRl9O5VxSIQEwYUTmtI=;
 b=dz5Tt3XIj31A+Hft02QLRDEAN/H4PZD0ccLqcphT61W7pe4GKQf+vS0OFLL3/jD+sNmyinnBfoAVj2VaqrcvQRIjSTWCJSLGxgRefBTNBqWTdtBisOGg293l5YwziJny6haQ6eJYmoa93TyXU9JxOgvo5gRQIllgR8OMuGyOsu5dccrLja7CoecK6jPI052SR0MIvdg253HPA6x1hoaBXqsSyTroA82mWoBEX1n5CBXLGuntKNa0UPLrsIhc2yYYiNNpqNMmZXTkjpt/d+BjCmcBV2AXqePwRRmtWitYXruqLfk9URCDpQRI7wGlqctMhmcmigHBfTpCoX3XMGj32w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+ip7ilKxJTP49WkipSwFVArmHRl9O5VxSIQEwYUTmtI=;
 b=E/7ZlOvMOOqRt6To0A+SIiRFt0+Jc6wDGmAQIMgHKyiBdJAHTfXfrFh4AfcXrhu+CFVheLiUhls68b7OGFDnaAvLWm8UbXsA6p0448ZxtfJpdKKQVB7Yaf32qsl2l4oD8LnyGcXduhwX8faau9oVh368vSTaKYj2TSbCKIEMLkw=
Received: from MW4PR03CA0212.namprd03.prod.outlook.com (2603:10b6:303:b9::7)
 by SA0PR12MB4416.namprd12.prod.outlook.com (2603:10b6:806:99::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.46; Mon, 12 Jun
 2023 09:55:13 +0000
Received: from CO1NAM11FT025.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b9:cafe::c7) by MW4PR03CA0212.outlook.office365.com
 (2603:10b6:303:b9::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.34 via Frontend
 Transport; Mon, 12 Jun 2023 09:55:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT025.mail.protection.outlook.com (10.13.175.232) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6500.22 via Frontend Transport; Mon, 12 Jun 2023 09:55:12 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Mon, 12 Jun
 2023 04:55:08 -0500
Received: from vijendar-X570-GAMING-X.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.23
 via Frontend Transport; Mon, 12 Jun 2023 04:55:04 -0500
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
Subject: [PATCH V4 3/9] ASoC: amd: ps: add SoundWire dma driver
Date:   Mon, 12 Jun 2023 15:28:57 +0530
Message-ID: <20230612095903.2113464-4-Vijendar.Mukunda@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230612095903.2113464-1-Vijendar.Mukunda@amd.com>
References: <20230612095903.2113464-1-Vijendar.Mukunda@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT025:EE_|SA0PR12MB4416:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a493c87-3f2d-4a14-859a-08db6b2b1d84
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: f45SWixYNYu7T4rr/SnUlC0eOdm7bVI1pQ/UVzmGJ5pIDJE9LkmtIzROmsW87QhcsNVQTDjmaBI7s0gJgMZx5ffXRt5+tAKSC2HKCAoG8fMU20fwWSct4gx0GHlcxrx0DZYitLAb4kDjnRSpADieIBxz9hZda+OLtGaQFgprTHBb9NX3mwTha8hbeRqgL9VNRTceZwhfYSDnnp8i6peFCTcbhjU5SIIA/sdYPxxT01ObKJqy1gOrdliUUVFLGbvV6+5NXNl6wqVcIKAmm7Zlc7nznqGRXDY5tP6/CfWYdcRNa8mJKBpuGcGBEHS3Q5+v7UMGBqHJNQDx99XjFw+wztaUKlYpGqqOFe0XwQI/bFehjnG/vwi5gZliDMUQQo0prIzt0et6Euvz4TaNKjm1edYwL8Dq8JJP1amsmGl8jLGS1/OLS7udcX2aEZGe+bu33F8duA6bmYfER2x41805KpS1OaoBuyjyJl5p7ct58K9xxi0Gg8oXWvhW5j4ZdvsCu56D+HOUZ1xhhm6Byc0LUPAh0AoiLbH7VtFSc/h0WYZu3aQxLo50VSSJtkH/n+8kl0TvtgUunvWSg+YxDTpmtfck6SNrn+OnqFrRLspnXLzAR9slL9Vj3Y8z/P5NOStITc1mb+hp+mwvH6Dea0AR3CXunvw+iCaAGavBGEoiFvhfOs1FWvHTWTImj3rVc2sMojZW4ZEw1kmWNAiEo3z2icJGvhVDvuSwSjcUcmzeJRaTk6iG0PsPowAaB+WSJOODhZm6NKJMbyutXKoYS+CYCA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(346002)(376002)(136003)(396003)(451199021)(46966006)(40470700004)(36840700001)(82310400005)(36860700001)(40480700001)(47076005)(83380400001)(426003)(336012)(356005)(81166007)(4326008)(82740400003)(36756003)(41300700001)(316002)(7696005)(6666004)(1076003)(26005)(6916009)(70206006)(70586007)(2906002)(86362001)(5660300002)(40460700003)(8936002)(8676002)(2616005)(54906003)(478600001)(186003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2023 09:55:12.4484
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a493c87-3f2d-4a14-859a-08db6b2b1d84
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT025.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4416
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
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
index 494f498bdc91..c95c57970a27 100644
--- a/sound/soc/amd/ps/acp63.h
+++ b/sound/soc/amd/ps/acp63.h
@@ -137,6 +137,11 @@ struct pdm_dev_data {
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

