Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A45C704AA5
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 12:33:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232369AbjEPKdA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 06:33:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232374AbjEPKcm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 06:32:42 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2087.outbound.protection.outlook.com [40.107.237.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E5034C17
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 03:32:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CmvjF5o/B6x38/Ag0WRClkQHvnBJhH49Z1RJnjTCiXHliRlhmlWavnRfN/TmwO4NGztxjyoU7HOypg3GxZTSAzFgx4paaxoXqeUGLVWOSu5Jf3Bkctxhl6HxXCV9HCMK6M560rW07qvsNOEFNrb0gc4Alm7S4RHWUJ76BNZvamZ3UsyR3jioJkYT+d/uVW/OSE9AgTGqJbV40K5CSRPpPkEnhpbkW8R7iGS2Vy80jPoW78J0jE4FAHBB7KZv80LW1tU0D4lqNjZRQpidLnRT5Ze7bjH+pwHqHGMCpAqjm3I1wvJlwu73IRPlM7+A0Nik/Ai6vVjA0haX2UcXHS1gkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uyWwwoknsvZ+DWv23QWheh4/7uOVTiAwU1AjB8FHoR8=;
 b=niEALK7kiLMHEszNIWyhalVL9rPQaZ95R4PmK2cKVfuh1PgsyLjJKdqoZMFgNyBPR5hLj6ldl5i5FZNgmvwDvvmllvPw5zBZ+lxQn57iFcZs0us+dzPM92pST0GPDzQsI5/bCjg9LiwKeYmOhrMAZR1D08837c7kaVr5lDpYzS+SqSUR/+xf2qz512Xih2CaSHLI6AYRrxpBRUWZSZA6KrtAe6DJB/ohycQ8svKDPWAHD/4p5RNb3ZVEQjInj0MWmturq1kkX8BDxyxYsNhhgyJUJYAD54Zfgbk+6T5oAcS/dJLnnzjSjisYYzxODL8W+xRQF6apvPAk2R241xov2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uyWwwoknsvZ+DWv23QWheh4/7uOVTiAwU1AjB8FHoR8=;
 b=2i9KPl4yCsdxBRv2l47LIAcxvT48ftR5JGJ9uCce8sfFmAy67NHooy6MFMyCNtYbyS4S5lfs0+BmcdXB6FEQjMVaJJYeQBMhuJMcg6+8aJEIotad2brPlIGGeCldiZ6BEt7QlOYv4G3VvhRMBrYktCugU3FCP7Wuv9tNwL0R3is=
Received: from DS7PR05CA0103.namprd05.prod.outlook.com (2603:10b6:8:56::18) by
 PH7PR12MB6393.namprd12.prod.outlook.com (2603:10b6:510:1ff::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.30; Tue, 16 May
 2023 10:32:11 +0000
Received: from DM6NAM11FT040.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:56:cafe::d9) by DS7PR05CA0103.outlook.office365.com
 (2603:10b6:8:56::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.15 via Frontend
 Transport; Tue, 16 May 2023 10:32:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT040.mail.protection.outlook.com (10.13.173.133) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6411.15 via Frontend Transport; Tue, 16 May 2023 10:32:10 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 16 May
 2023 05:31:25 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 16 May
 2023 03:31:18 -0700
Received: from vijendar-X570-GAMING-X.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.34
 via Frontend Transport; Tue, 16 May 2023 05:31:15 -0500
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
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH 6/9] ASoC: amd: ps: add pm ops support for soundwire dma driver
Date:   Tue, 16 May 2023 16:05:40 +0530
Message-ID: <20230516103543.2515097-7-Vijendar.Mukunda@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230516103543.2515097-1-Vijendar.Mukunda@amd.com>
References: <20230516103543.2515097-1-Vijendar.Mukunda@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT040:EE_|PH7PR12MB6393:EE_
X-MS-Office365-Filtering-Correlation-Id: cf9279ae-2178-4049-916d-08db55f8ce93
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: h78Z2wG7dNWFVaxICHNBdnIUK9s7xibMo7iT5rLtCmyhgb6114npDIJQvBkNknOYVqrgmBjnBkke5+1DGDEQkHqyMvvSQPGHvf5Hq+Gn9u88sCxp2htCSAs+XrgAUEZGpPIpEeMphsBSW1ZqHB0b3jHQf8aNZX/IHQhXMFn/8LOLscU5W28T3dWrKIedn2u8Xc8/E6jMiXgRPAyG2+WxcV0yj56mxnQc+VF0rgcRZdbJxSjUK1p+YFTjMRRDUsDw9O253BCIPs/VxE8xMW5i4oQQP2gi2LlRDHq8xEn+Dw5KD9874o5M2s9z0Midys1Yko4fX28cBb2LOcRY6nUo0+LQkCWLgXZRWp+OLMY6QNXQVOQutsT7KmzSytGLgOcQLX/JJH9T1nRslPYQ1Uan0z+wYGkkKZRuRSeYte/aLrfoqrF8wX9wzbtPQuxHjQQY6TGSoqpFDzvXZoQHrD4twPVRk3YliP8acReNz5IcgeAFaunTm8whowu1xKUyVMg9LXyDMq4m+nP1avrnOSKAWWXAJd3lYn5zN1bl01wuQ7MN9Xosjdft/Nel9I31Gf7N+Eo/E1Y49jObltH7+p/bUIyv4EVKDNbTiHNl0h1CDI47iBlNH4Ivr8jkSddmt4SlxFG5fF17qaoPljneiFFAFvgadaZUgfVHt/PY3cUqoecTRyHCNHNGzaKcwr02dm11I21B6cbHMfhBNFeC1PKh0hIr1V4FccIu29YGcQPmzSEWBV8OYZgGDVparb6HVSN3lH//Xaf/WQUU+gxSlZjiHg==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(136003)(39860400002)(396003)(451199021)(40470700004)(36840700001)(46966006)(83380400001)(336012)(36860700001)(47076005)(426003)(70586007)(70206006)(2616005)(7696005)(26005)(1076003)(40480700001)(478600001)(54906003)(6666004)(186003)(40460700003)(8676002)(86362001)(2906002)(5660300002)(8936002)(41300700001)(36756003)(4326008)(82740400003)(316002)(81166007)(356005)(82310400005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2023 10:32:10.8303
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cf9279ae-2178-4049-916d-08db55f8ce93
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT040.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6393
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

Add support pm ops support for soundwire dma driver.

Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
---
 sound/soc/amd/ps/ps-sdw-dma.c | 86 +++++++++++++++++++++++++++++++++++
 1 file changed, 86 insertions(+)

diff --git a/sound/soc/amd/ps/ps-sdw-dma.c b/sound/soc/amd/ps/ps-sdw-dma.c
index 5002ef16d980..8901a52f7498 100644
--- a/sound/soc/amd/ps/ps-sdw-dma.c
+++ b/sound/soc/amd/ps/ps-sdw-dma.c
@@ -12,6 +12,7 @@
 #include <sound/pcm_params.h>
 #include <sound/soc.h>
 #include <sound/soc-dai.h>
+#include <linux/pm_runtime.h>
 #include <linux/soundwire/sdw_amd.h>
 #include "acp63.h"
 
@@ -102,6 +103,29 @@ static const struct snd_pcm_hardware acp63_sdw_hardware_capture = {
 	.periods_max = SDW_CAPTURE_MAX_NUM_PERIODS,
 };
 
+static void acp63_enable_disable_sdw_dma_interrupts(void __iomem *acp_base, bool enable)
+{
+	u32 ext_intr_cntl, ext_intr_cntl1;
+	u32 irq_mask = ACP_SDW_DMA_IRQ_MASK;
+	u32 irq_mask1 = ACP_P1_SDW_DMA_IRQ_MASK;
+
+	if (enable) {
+		ext_intr_cntl = readl(acp_base + ACP_EXTERNAL_INTR_CNTL);
+		ext_intr_cntl |= irq_mask;
+		writel(ext_intr_cntl, acp_base + ACP_EXTERNAL_INTR_CNTL);
+		ext_intr_cntl1 = readl(acp_base + ACP_EXTERNAL_INTR_CNTL1);
+		ext_intr_cntl1 |= irq_mask1;
+		writel(ext_intr_cntl1, acp_base + ACP_EXTERNAL_INTR_CNTL1);
+	} else {
+		ext_intr_cntl = readl(acp_base + ACP_EXTERNAL_INTR_CNTL);
+		ext_intr_cntl &= ~irq_mask;
+		writel(ext_intr_cntl, acp_base + ACP_EXTERNAL_INTR_CNTL);
+		ext_intr_cntl1 = readl(acp_base + ACP_EXTERNAL_INTR_CNTL1);
+		ext_intr_cntl1 &= ~irq_mask1;
+		writel(ext_intr_cntl1, acp_base + ACP_EXTERNAL_INTR_CNTL1);
+	}
+}
+
 static void acp63_config_dma(struct sdw_dma_stream_instance *sdw_ins, void __iomem *acp_base,
 			     u32 stream_id)
 {
@@ -470,13 +494,75 @@ static int acp63_sdw_platform_probe(struct platform_device *pdev)
 		dev_err(&pdev->dev, "Fail to register sdw dma component\n");
 		return -ENODEV;
 	}
+	pm_runtime_set_autosuspend_delay(&pdev->dev, ACP_SUSPEND_DELAY_MS);
+	pm_runtime_use_autosuspend(&pdev->dev);
+	pm_runtime_enable(&pdev->dev);
+	pm_runtime_allow(&pdev->dev);
+	return 0;
+}
+
+static int acp63_sdw_platform_remove(struct platform_device *pdev)
+{
+	pm_runtime_disable(&pdev->dev);
+	return 0;
+}
+
+static int __maybe_unused acp63_sdw_pcm_resume(struct device *dev)
+{
+	struct sdw_dma_dev_data *sdw_data;
+	struct sdw_dma_stream_instance *sdw_ins;
+	struct snd_pcm_runtime *runtime;
+	u32 period_bytes, buf_size, water_mark_size_reg;
+	int ret;
+	int index;
+
+	sdw_data = dev_get_drvdata(dev);
+	for (index = 0; index < ACP63_SDW0_DMA_MAX_STREAMS; index++) {
+		if (sdw_data->sdw0_dma_stream[index] &&
+		    sdw_data->sdw0_dma_stream[index]->runtime) {
+			water_mark_size_reg = sdw0_dma_ring_buf_reg[index].water_mark_size_reg;
+			runtime = sdw_data->sdw0_dma_stream[index]->runtime;
+			sdw_ins = runtime->private_data;
+			period_bytes = frames_to_bytes(runtime, runtime->period_size);
+			buf_size = frames_to_bytes(runtime, runtime->buffer_size);
+			acp63_config_dma(sdw_ins, sdw_data->acp_base, index);
+			ret = acp63_configure_sdw_ringbuffer(sdw_data->acp_base, index,
+							     buf_size, ACP_SDW0);
+			if (ret)
+				return ret;
+			writel(period_bytes, sdw_data->acp_base + water_mark_size_reg);
+		}
+	}
+	for (index = 0; index < ACP63_SDW1_DMA_MAX_STREAMS; index++) {
+		if (sdw_data->sdw1_dma_stream[index] &&
+		    sdw_data->sdw1_dma_stream[index]->runtime) {
+			water_mark_size_reg = sdw1_dma_ring_buf_reg[index].water_mark_size_reg;
+			runtime = sdw_data->sdw1_dma_stream[index]->runtime;
+			sdw_ins = runtime->private_data;
+			period_bytes = frames_to_bytes(runtime, runtime->period_size);
+			buf_size = frames_to_bytes(runtime, runtime->buffer_size);
+			acp63_config_dma(sdw_ins, sdw_data->acp_base, index);
+			ret = acp63_configure_sdw_ringbuffer(sdw_data->acp_base, index,
+							     buf_size, ACP_SDW1);
+			if (ret)
+				return ret;
+			writel(period_bytes, sdw_data->acp_base + water_mark_size_reg);
+		}
+	}
+	acp63_enable_disable_sdw_dma_interrupts(sdw_data->acp_base, true);
 	return 0;
 }
 
+static const struct dev_pm_ops acp63_pm_ops = {
+	SET_SYSTEM_SLEEP_PM_OPS(NULL, acp63_sdw_pcm_resume)
+};
+
 static struct platform_driver acp63_sdw_dma_driver = {
 	.probe = acp63_sdw_platform_probe,
+	.remove = acp63_sdw_platform_remove,
 	.driver = {
 		.name = "amd_ps_sdw_dma",
+		.pm = &acp63_pm_ops,
 	},
 };
 
-- 
2.34.1

