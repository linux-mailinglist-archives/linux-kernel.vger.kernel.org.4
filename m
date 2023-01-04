Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5D1265CCAB
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 06:52:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231182AbjADFwh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 00:52:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230251AbjADFwe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 00:52:34 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2085.outbound.protection.outlook.com [40.107.93.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DD4013DE6
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 21:52:31 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lGTjleWoGhk3xszs1huFgen/jEx+/e+xtHE4NxuFDpyihnQcpDVRCmTye0QATk+La4CNttiXRnQnY/eDzpT0u+MJnSPHv6hGb6vGmq04+hrf1qQfFKWPyBK3X34YKhEp+xe2ZH4sg2f7quBEy+F+OV1NqpX/CFNW4zHrsZuTD0BeR4z71bFevA24jZc0AyCtZYcAegs2XohaTBUuEeNf3J7Wx0l4YRarZKwWZdOBwxhFTOfrfhHHqvKIplOt54Ks5Vc5cjQ8oTsm2EwwZ3/LECNeDiCSvknnccOre1cCbfFKe0cJUunVab1T6RNlFsKTRI6gWNgeBXa6Y574x8sMaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8+nKbPVyX5niL8SFTJW0M6tCw6naP9EGagVYfPmG1lQ=;
 b=XyxQevrhoXion2sP2lyvUE9xEaE4POMxeDBOZydJY5lVwBfM2MnUoIEijhthpl7idgn5MkkFuak6wJ/09dPu7ur54eF/F56CSOt5VZbK1UBpsoX04dR1kH+JY/srBVcAnmQdgbaty6uTVxmv1w94hLgBEAO4xq5mf8kKsocxDhIqjoSTu4O1z9N+HsL0KTa5mevxMgtzL+rp4e0tMdzS5/UKMzqfmlQUV7ZOzHkdv2B5DhIkfQE3OsgN8Pxj59HKWASj2JgC00WtZl2dZwaPuu7OmMiyF617CEeuWYpKOyG8irwO79/N9gyTsIZY/awHDY3k4D9Kmwjfn1GVXNH6vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8+nKbPVyX5niL8SFTJW0M6tCw6naP9EGagVYfPmG1lQ=;
 b=YS4w1/eZgedsydPGmyX5jxJNAM+K8pLpTaEo2JlJPRPBWz8+NXmC9+v3Ny2eRuolx7/FJbSLc7FmXTYIewz1ZjedVgOjwGJIh0HcP5OrpWU6bKPgHwfAQBvc3siQ0RMn+gQqPQadW8uZZyyW0XFO2mnRaU4AGsAF+mTExf90bTk=
Received: from BN0PR04CA0160.namprd04.prod.outlook.com (2603:10b6:408:eb::15)
 by SN7PR12MB7978.namprd12.prod.outlook.com (2603:10b6:806:34b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Wed, 4 Jan
 2023 05:52:29 +0000
Received: from BL02EPF0000EE3F.namprd05.prod.outlook.com
 (2603:10b6:408:eb:cafe::a9) by BN0PR04CA0160.outlook.office365.com
 (2603:10b6:408:eb::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5966.19 via Frontend
 Transport; Wed, 4 Jan 2023 05:52:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BL02EPF0000EE3F.mail.protection.outlook.com (10.167.241.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5944.10 via Frontend Transport; Wed, 4 Jan 2023 05:52:29 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 3 Jan
 2023 23:52:28 -0600
Received: from vijendar-X570-GAMING-X.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.34
 via Frontend Transport; Tue, 3 Jan 2023 23:52:19 -0600
From:   Vijendar Mukunda <Vijendar.Mukunda@amd.com>
To:     <broonie@kernel.org>, <alsa-devel@alsa-project.org>,
        <syed.sabakareem@amd.com>
CC:     <Sunil-kumar.Dommati@amd.com>, <mario.limonciello@amd.com>,
        <basavaraj.hiregoudar@amd.com>,
        Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Syed Saba Kareem <Syed.SabaKareem@amd.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/3] ASoC: amd: ps: use acp_lock to protect common registers in pdm driver
Date:   Wed, 4 Jan 2023 11:24:30 +0530
Message-ID: <20230104055435.321327-2-Vijendar.Mukunda@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230104055435.321327-1-Vijendar.Mukunda@amd.com>
References: <20230104055435.321327-1-Vijendar.Mukunda@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0000EE3F:EE_|SN7PR12MB7978:EE_
X-MS-Office365-Filtering-Correlation-Id: 4028d5e4-1787-4426-7c44-08daee17dd59
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fucM5/WiTHHNUXWTokXm/yVJFSn+TTq6gko5mY7RPFbwHyJr9EXnIEeeERYtlLjod5HxPiOx5P88Ajd7VrNJqVIr3VQYqlszIMvMyuROHDMJWZKjf0wA4JQzTgleh+JmfAPZ4nRWudP20baFF1HyuEFtewHwnGG4Aye3jrYLir27w033r1uP8656sQzWrZ/jISaXmOV+Uv74allCBbOeH+E5jLiyV4OZ1IT7yu/2AA7fZ3QVvtU4lA/Ggj2YIc9q3wWCmND3iO4/sY1Nl+sIa00an00RbTQmD0Qoz8Q8NmASDgIWCTJUEOSLpYFKlUFC06tVYD/8BeoBcYG8UwokDXfcbg32opUCK/GoUPctbvHSt8jyYtCGvqrZIph5IbDSogUo3DjztvwciHGJXFbRn/wWzF/JW62EG4pkBetf1naepeaexiV2W9C5pHygl/BN67Vl2Nei2Iaapu5xxChxrQtn6DlUKuwBTM63OeCUQCQAEAIujOaCTRFjDzQrjQs4BuZYgiM7g4SDrj8tx6lxfr+WY4thT3JJX+Ib9x4/7ZVIpIiMgnrPALHJaxDWcDBxJg6sWhVX2rzSiF/B+x86sTJzRchCLfh5Px1JldkS6MMvQUpVddeBZOoAQXjFJ2Drlw7isDJ4oLGpH/aMbjqITcCMfwCABzBv/F1WYC3BynhoSJvBGBci6HFDuvq281NWpq72goHu4xHVm+UealKlsepJOjW9HZac2Iu4sSCXUT4=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(396003)(39860400002)(136003)(346002)(376002)(451199015)(40470700004)(46966006)(36840700001)(8676002)(8936002)(5660300002)(4326008)(2906002)(6636002)(41300700001)(54906003)(110136005)(70586007)(70206006)(316002)(6666004)(7696005)(478600001)(186003)(26005)(40460700003)(1076003)(47076005)(426003)(81166007)(336012)(2616005)(83380400001)(36756003)(82740400003)(82310400005)(356005)(36860700001)(40480700001)(86362001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2023 05:52:29.1166
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4028d5e4-1787-4426-7c44-08daee17dd59
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0000EE3F.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7978
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Retrieve acp_lock mutex as platform data and use it for protecting
ACP common registers access in acp pdm driver.

Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
---
 sound/soc/amd/ps/acp63.h      |  1 +
 sound/soc/amd/ps/ps-pdm-dma.c | 32 ++++++++++++++++++++------------
 2 files changed, 21 insertions(+), 12 deletions(-)

diff --git a/sound/soc/amd/ps/acp63.h b/sound/soc/amd/ps/acp63.h
index 47854280dd4b..e0160cbf5447 100644
--- a/sound/soc/amd/ps/acp63.h
+++ b/sound/soc/amd/ps/acp63.h
@@ -88,6 +88,7 @@ struct pdm_stream_instance {
 struct pdm_dev_data {
 	u32 pdm_irq;
 	void __iomem *acp63_base;
+	struct mutex *acp_lock;
 	struct snd_pcm_substream *capture_stream;
 };
 
diff --git a/sound/soc/amd/ps/ps-pdm-dma.c b/sound/soc/amd/ps/ps-pdm-dma.c
index eea71a9d2ef1..8957d8f8d3c6 100644
--- a/sound/soc/amd/ps/ps-pdm-dma.c
+++ b/sound/soc/amd/ps/ps-pdm-dma.c
@@ -59,22 +59,26 @@ static void acp63_enable_pdm_clock(void __iomem *acp_base)
 	acp63_writel(pdm_ctrl, acp_base + ACP_WOV_MISC_CTRL);
 }
 
-static void acp63_enable_pdm_interrupts(void __iomem *acp_base)
+static void acp63_enable_pdm_interrupts(struct pdm_dev_data *adata)
 {
 	u32 ext_int_ctrl;
 
-	ext_int_ctrl = acp63_readl(acp_base + ACP_EXTERNAL_INTR_CNTL);
+	mutex_lock(adata->acp_lock);
+	ext_int_ctrl = acp63_readl(adata->acp63_base + ACP_EXTERNAL_INTR_CNTL);
 	ext_int_ctrl |= PDM_DMA_INTR_MASK;
-	acp63_writel(ext_int_ctrl, acp_base + ACP_EXTERNAL_INTR_CNTL);
+	acp63_writel(ext_int_ctrl, adata->acp63_base + ACP_EXTERNAL_INTR_CNTL);
+	mutex_unlock(adata->acp_lock);
 }
 
-static void acp63_disable_pdm_interrupts(void __iomem *acp_base)
+static void acp63_disable_pdm_interrupts(struct pdm_dev_data *adata)
 {
 	u32 ext_int_ctrl;
 
-	ext_int_ctrl = acp63_readl(acp_base + ACP_EXTERNAL_INTR_CNTL);
+	mutex_lock(adata->acp_lock);
+	ext_int_ctrl = acp63_readl(adata->acp63_base + ACP_EXTERNAL_INTR_CNTL);
 	ext_int_ctrl &= ~PDM_DMA_INTR_MASK;
-	acp63_writel(ext_int_ctrl, acp_base + ACP_EXTERNAL_INTR_CNTL);
+	acp63_writel(ext_int_ctrl, adata->acp63_base + ACP_EXTERNAL_INTR_CNTL);
+	mutex_unlock(adata->acp_lock);
 }
 
 static bool acp63_check_pdm_dma_status(void __iomem *acp_base)
@@ -196,7 +200,7 @@ static int acp63_pdm_dma_open(struct snd_soc_component *component,
 		return ret;
 	}
 
-	acp63_enable_pdm_interrupts(adata->acp63_base);
+	acp63_enable_pdm_interrupts(adata);
 
 	if (substream->stream == SNDRV_PCM_STREAM_CAPTURE)
 		adata->capture_stream = substream;
@@ -272,7 +276,7 @@ static int acp63_pdm_dma_close(struct snd_soc_component *component,
 	struct pdm_dev_data *adata = dev_get_drvdata(component->dev);
 	struct snd_pcm_runtime *runtime = substream->runtime;
 
-	acp63_disable_pdm_interrupts(adata->acp63_base);
+	acp63_disable_pdm_interrupts(adata);
 	adata->capture_stream = NULL;
 	kfree(runtime->private_data);
 	return 0;
@@ -353,6 +357,10 @@ static int acp63_pdm_audio_probe(struct platform_device *pdev)
 	struct pdm_dev_data *adata;
 	int status;
 
+	if (!pdev->dev.platform_data) {
+		dev_err(&pdev->dev, "platform_data not retrieved\n");
+		return -ENODEV;
+	}
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	if (!res) {
 		dev_err(&pdev->dev, "IORESOURCE_MEM FAILED\n");
@@ -368,7 +376,7 @@ static int acp63_pdm_audio_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	adata->capture_stream = NULL;
-
+	adata->acp_lock = pdev->dev.platform_data;
 	dev_set_drvdata(&pdev->dev, adata);
 	status = devm_snd_soc_register_component(&pdev->dev,
 						 &acp63_pdm_component,
@@ -408,7 +416,7 @@ static int __maybe_unused acp63_pdm_resume(struct device *dev)
 		acp63_init_pdm_ring_buffer(PDM_MEM_WINDOW_START, buffer_len,
 					   period_bytes, adata->acp63_base);
 	}
-	acp63_enable_pdm_interrupts(adata->acp63_base);
+	acp63_enable_pdm_interrupts(adata);
 	return 0;
 }
 
@@ -417,7 +425,7 @@ static int __maybe_unused acp63_pdm_suspend(struct device *dev)
 	struct pdm_dev_data *adata;
 
 	adata = dev_get_drvdata(dev);
-	acp63_disable_pdm_interrupts(adata->acp63_base);
+	acp63_disable_pdm_interrupts(adata);
 	return 0;
 }
 
@@ -426,7 +434,7 @@ static int __maybe_unused acp63_pdm_runtime_resume(struct device *dev)
 	struct pdm_dev_data *adata;
 
 	adata = dev_get_drvdata(dev);
-	acp63_enable_pdm_interrupts(adata->acp63_base);
+	acp63_enable_pdm_interrupts(adata);
 	return 0;
 }
 
-- 
2.34.1

