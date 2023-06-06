Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 807E7723719
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 08:04:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234638AbjFFGEC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 02:04:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234050AbjFFGDj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 02:03:39 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2052.outbound.protection.outlook.com [40.107.244.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EAD0E5D
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 23:03:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=guEDIWGq7PfZ7aYVp4aC3H0DnUd6YbktbqpxIndfS/v/twgIWalrAMHPShAu5ofN5l2kVmMx6/JLAjF5anYQC1ez72nLQjni4pcjBS7zFBQW1HiiXAZr9OnZRV67YC1IHz9QEL+nu3abPSVRjfTzhmqeHwsK8pyUFrWsDEwCszqNKPZneIForJGKj/tB6orMwkhm/Wt7KL6MPkm2KMBmgLSBq7y/H5txdzMcRek/aZ3iilTxx2Rr6EEvJj26kYCU9XMhFMLF/GM7ff2doayWtr4N3o4sC/lE1VXlZRhF+MirVFWAin6JjfFI6HtCFcwbBO26UHll7Ccq9IKpSmZVXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zGoQxjYqHo1ec0cAyGhnXY0fduMTxAF72NonLHDnHFg=;
 b=YU3Rm/lpmIg8ORPeMTpXLAuPqGfqYVYANmY8V6RFjm58m1LLYrBgO0rzmTEylf9PkDmA0BlYT7brNWa5/sAPZmpHGNI/4RKbe0bWyw5agBR6QtBVnQmi7dLDXVH6BYNN0Kr0rzTjUepoiUm9kal6uDeKxT4PSO43LwL3/MCJS4/wftqIiJJYYD7CsQNkYjqcNbtYA7xivtvMFlG0c9XuFysbPF/iV9rocHiV76Rqa1ebtLa5Z7j+cQZJmwedp8ZDz7AonpP3aed1cvuChHrRsx9RonVAw4mowA1H90A5FHzyfvw66eAc5p5vD1f9C19+DMMkSRyGOENlzKErKJg5lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zGoQxjYqHo1ec0cAyGhnXY0fduMTxAF72NonLHDnHFg=;
 b=NsV30WCzTChyEIjvW2JkWe08qJ8vrTP9oHV8YGFpWscwpP+aY6NNFdZ+R4+r2fXSs6u9M44zStM7jgjIxM2657D0b+yXz0EN4FA4Ow22UEgcdh3+5a3/th3JcDQlMzDsj1F+l3OUpl51NNtAtZJrZ/hP5twBhsLsJg63PwPnLUM=
Received: from DM6PR02CA0037.namprd02.prod.outlook.com (2603:10b6:5:177::14)
 by BL1PR12MB5921.namprd12.prod.outlook.com (2603:10b6:208:398::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Tue, 6 Jun
 2023 06:03:28 +0000
Received: from CY4PEPF0000EDD7.namprd03.prod.outlook.com
 (2603:10b6:5:177:cafe::87) by DM6PR02CA0037.outlook.office365.com
 (2603:10b6:5:177::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33 via Frontend
 Transport; Tue, 6 Jun 2023 06:03:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EDD7.mail.protection.outlook.com (10.167.241.211) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6477.13 via Frontend Transport; Tue, 6 Jun 2023 06:03:28 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 6 Jun
 2023 01:03:22 -0500
Received: from vijendar-X570-GAMING-X.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.34
 via Frontend Transport; Tue, 6 Jun 2023 01:03:18 -0500
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
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH V3 6/9] ASoC: amd: ps: add pm ops support for SoundWire dma driver
Date:   Tue, 6 Jun 2023 11:37:21 +0530
Message-ID: <20230606060724.2038680-7-Vijendar.Mukunda@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230606060724.2038680-1-Vijendar.Mukunda@amd.com>
References: <20230606060724.2038680-1-Vijendar.Mukunda@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD7:EE_|BL1PR12MB5921:EE_
X-MS-Office365-Filtering-Correlation-Id: fb1080bf-1d84-43dd-1a20-08db6653bf53
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CpU4ibb16Ule96QkXyYlzjCCxel4B8N7Q3CeejJ+gyxwbq0/RxgnmeQnIIT6R463NjAFJ0w5edZYwlF7ycsLJyvkG7Eu8C9A4780hiNRfijJik9MQ5WYDZAk2Z+CFzD+c97CyrXgbT2q1/M6nHEByDGDuZ7H9bQ/hC6Q2y1hVXWj0S6Uop36NwsWJZr3E5MXDir5jmftEgByar85+ix1mJGIeOHpeKdnPk+L6UzkEQBFPaWjhBCqUVB6CfeSXkGvPl7GqluB1K6YwHpbuNi+IlJnisA/avtfCaK1eVY06qTssGxuIQ0IJ4JTt2YkZyrYDqP7rKy3lfcmVvBfdF/DlyJ6EDU1rKHM5s+ab4w89gYFqSGFMoBplpDJtPLCOnCt9jjaK6oBDcfetkV4D/DzXh3CibMOmhErhcNHnNtogmEiP4HEJfcW5YLaCQQCT6mCk3/pU33i7iLePhwR/YQQVcFkcNyCLhtgnMWK+5FeSKGlWnf2jJHwVoOF4UBdqMfQCyJ6fAyWXjYyJVJcruuyV07HLIS5YnL6FIOlWcnmpfogN6J//skj5sHT1FOjTZ3LisnWwMVGir3+ITFBD/RMiSmFFYSVrYueChHjnlkuHthp9z/GVDhFcewVfn3S6yXpADSuV0webi5fDB5kF7KMskMbqnwV8OpiMv/lNpzqTmRSHTkKfo9FaNzoex9FnEPrWVvQuA6McQva9Gfd2n23ufFYG3oJFfnvkvMrCvAnZqAWtSgmrXQqNJK5Wms/benV6Pd16sZxftzlcqYacyxY8Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(376002)(396003)(39860400002)(451199021)(46966006)(40470700004)(36840700001)(54906003)(40460700003)(40480700001)(478600001)(6916009)(8936002)(8676002)(2906002)(36756003)(86362001)(5660300002)(82310400005)(4326008)(81166007)(316002)(70206006)(70586007)(356005)(82740400003)(2616005)(41300700001)(1076003)(26005)(36860700001)(47076005)(83380400001)(186003)(7696005)(6666004)(336012)(426003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2023 06:03:28.0332
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fb1080bf-1d84-43dd-1a20-08db6653bf53
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD7.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5921
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

Add support pm ops support for SoundWire dma driver.

Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
---
 sound/soc/amd/ps/ps-sdw-dma.c | 98 ++++++++++++++++++++++++++++++++++-
 1 file changed, 96 insertions(+), 2 deletions(-)

diff --git a/sound/soc/amd/ps/ps-sdw-dma.c b/sound/soc/amd/ps/ps-sdw-dma.c
index 06d847c6a50e..118f4c3674ab 100644
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
 static void acp63_config_dma(struct acp_sdw_dma_stream *stream, void __iomem *acp_base,
 			     u32 stream_id)
 {
@@ -464,16 +488,86 @@ static int acp63_sdw_platform_probe(struct platform_device *pdev)
 	status = devm_snd_soc_register_component(&pdev->dev,
 						 &acp63_sdw_component,
 						 NULL, 0);
-	if (status)
+	if (status) {
 		dev_err(&pdev->dev, "Fail to register sdw dma component\n");
+		return status;
+	}
+	pm_runtime_set_autosuspend_delay(&pdev->dev, ACP_SUSPEND_DELAY_MS);
+	pm_runtime_use_autosuspend(&pdev->dev);
+	pm_runtime_mark_last_busy(&pdev->dev);
+	pm_runtime_set_active(&pdev->dev);
+	pm_runtime_enable(&pdev->dev);
+	return 0;
+}
 
-	return status;
+static int acp63_sdw_platform_remove(struct platform_device *pdev)
+{
+	pm_runtime_disable(&pdev->dev);
+	return 0;
 }
 
+static int acp_restore_sdw_dma_config(struct sdw_dma_dev_data *sdw_data)
+{
+	struct acp_sdw_dma_stream *stream;
+	struct snd_pcm_substream *substream;
+	struct snd_pcm_runtime *runtime;
+	u32 period_bytes, buf_size, water_mark_size_reg;
+	u32 stream_count;
+	int index, instance, ret;
+
+	for (instance = 0; instance < AMD_SDW_MAX_MANAGERS; instance++) {
+		if (instance == ACP_SDW0)
+			stream_count = ACP63_SDW0_DMA_MAX_STREAMS;
+		else
+			stream_count = ACP63_SDW1_DMA_MAX_STREAMS;
+
+		for (index = 0; index < stream_count; index++) {
+			if (instance == ACP_SDW0) {
+				substream = sdw_data->sdw0_dma_stream[index];
+				water_mark_size_reg =
+						sdw0_dma_ring_buf_reg[index].water_mark_size_reg;
+			} else {
+				substream = sdw_data->sdw1_dma_stream[index];
+				water_mark_size_reg =
+						sdw1_dma_ring_buf_reg[index].water_mark_size_reg;
+			}
+
+			if (substream && substream->runtime) {
+				runtime = substream->runtime;
+				stream = runtime->private_data;
+				period_bytes = frames_to_bytes(runtime, runtime->period_size);
+				buf_size = frames_to_bytes(runtime, runtime->buffer_size);
+				acp63_config_dma(stream, sdw_data->acp_base, index);
+				ret = acp63_configure_sdw_ringbuffer(sdw_data->acp_base, index,
+								     buf_size, instance);
+				if (ret)
+					return ret;
+				writel(period_bytes, sdw_data->acp_base + water_mark_size_reg);
+			}
+		}
+	}
+	acp63_enable_disable_sdw_dma_interrupts(sdw_data->acp_base, true);
+	return 0;
+}
+
+static int __maybe_unused acp63_sdw_pcm_resume(struct device *dev)
+{
+	struct sdw_dma_dev_data *sdw_data;
+
+	sdw_data = dev_get_drvdata(dev);
+	return acp_restore_sdw_dma_config(sdw_data);
+}
+
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

