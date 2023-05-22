Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98E6A70BFB8
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 15:27:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233642AbjEVN1Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 09:27:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233897AbjEVN1V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 09:27:21 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2044.outbound.protection.outlook.com [40.107.237.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8DA21A1
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 06:27:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yg5ypslMDfkV9j8bvfAgOsIv9T5sg9NgB6hCGyVNjY/vOOMTnVcveRW1SHJk4lTQauATSvAPnBFmg8eV3CoIRA6k8A6IlbwFK+NtwPSPtm42JETbSyqLbgeQVDr8dcxKqCyEAsYLENonZuGlTgjo/KNjSVHVCvWkBFoD07PAionYebBOAsDbBWPQlGzm2x2uedWisiYPOg3jwSFBkf0C4V2NjUJQwLmE2TjMJ8cAkcBSBlmBPv4t9snBpb04l1JUiOSQId6wv/iZRKCnUdLyN/QMP5QUrj/0DNqQiny/YwfbLcXpZF71GpPWkXMgox0FT4419xvh20BvSIeDWLTTsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P9pq5lYF0uuopdRMs91mGerNUEwlLmqZ0IhzMdamLmc=;
 b=jMQqSXewNxfpnb/spL7MM0atO5JMCwPeLzq4S4/6cNsBZ9XewVO1Z5qEJzER+qCmk17Vv7cHQxKJacG7rvt+Xx3QFJKi/dpC1lD7Oq+8kQpS84pktV5k7is2UpyudNfF+Dfg4Q+N9DdVAPeV2BV0YmhdZ/PoITirLBx6B9p7dHK2Og9rxlY6n4mOSqe565eV5SLBxXAiWaRJZ9E/N6uve+J+CfIubBN7SD7tifuFYwu304JUYx9FQTCnDwFfwn6p+JeI+2hE8IH8wEeUrZdiGHtexNhy2vSzz9zpi7nFDU7Tl4dwUg5euJFvAl1iAb0mca0a2asyFc3oVI/xBwd0UA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P9pq5lYF0uuopdRMs91mGerNUEwlLmqZ0IhzMdamLmc=;
 b=yYcuw3lkQTw4dOCNwZ610/4oJ5121Qd/LVXTTUXmGDjSYSwX5Lf1R7Y/WHXJVV57kCbf+mFDoUosAJNXJJBk6fHxmKXKw7x6p8zWv0TfLWutppsYgdzoyAYNuMVVP6TVBtRa//b8SFEt5zm0VeI4kBM3X/fr5w1sa6HJbdWAVwE=
Received: from MW4PR03CA0333.namprd03.prod.outlook.com (2603:10b6:303:dc::8)
 by DM8PR12MB5480.namprd12.prod.outlook.com (2603:10b6:8:24::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28; Mon, 22 May
 2023 13:27:08 +0000
Received: from CO1NAM11FT106.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:dc:cafe::5a) by MW4PR03CA0333.outlook.office365.com
 (2603:10b6:303:dc::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28 via Frontend
 Transport; Mon, 22 May 2023 13:27:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT106.mail.protection.outlook.com (10.13.175.44) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6411.28 via Frontend Transport; Mon, 22 May 2023 13:27:07 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 22 May
 2023 08:27:06 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 22 May
 2023 06:27:06 -0700
Received: from vijendar-X570-GAMING-X.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.34
 via Frontend Transport; Mon, 22 May 2023 08:27:03 -0500
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
Subject: [PATCH V2 6/9] ASoC: amd: ps: add pm ops support for SoundWire dma driver
Date:   Mon, 22 May 2023 19:01:19 +0530
Message-ID: <20230522133122.166841-7-Vijendar.Mukunda@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230522133122.166841-1-Vijendar.Mukunda@amd.com>
References: <20230522133122.166841-1-Vijendar.Mukunda@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT106:EE_|DM8PR12MB5480:EE_
X-MS-Office365-Filtering-Correlation-Id: db3a02c3-15d8-42c9-4870-08db5ac83daf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cTHdXZdva8D0A7QjDjjiFZ1u8njv7b+bISgeWoa4+LogoIWs5KSizn6UwP2RyzR7It/YsUYkwqg54eV2V1qd5ZLE1Mo+lQVNR1nXZCfct6MvX70msV5N4Mnm0E2mE0RaSlWnXBLardSgsgPitoLZ7mpWFzhFU4bsREaW+2KhobWFKsMfq2msUseHia/MKeYuNHP70fNL/wFrfKn1cJL4hdRFHhEwHsiC8YbF5OxEA7xwTDY7Jd53p2480YyPptiaG0SrSk/WkmBgiT2JHtsTvNDspHjx8cBVpn2Afn4x7S+WeHH5X7ElBfDX54zdUqTrWEJnbC/NCQmcv8+p2g7ms4AS6teIO/+QVLuGvbDo6or2DX7aJOHUvKgN6TyFOnUJDyC/EcK4XTtckDg7X2igMIsfB+05mHewtgQJOgWd2nhXZ4G4DiO0kbEQAFZnTgxlFYNcP1QQIMbwCEnl3Bru3qvExvgE7ofSVWKqavvUwV7M32UkbQQ3zW9GpKvWjQB8Pt6IF4B89oVQKkwGczeNvqajqi8+WAuSuB8H5ms23W0zZPIX6QeEv5DUbQ1sGoEPgQumBoTHOhd/YiW9oRgvLoULAWt8eRT0oE0AyJ56R8VAVhhh6ToQw0AIonHW93g2z2f2CfEzeZ+7y+hwPKj9cUf0Ou6pRiAFXKRuxe2d6Hejf90W7Yfm4WzQtLNirnwd2OJf+rMdAadbVGXFXiQpT+etn3TWRxN6f1Pg6j9p8Bf2ohSYv97nbB899pzhqrVH9zf4LmmSLtUfuX40hJ6zQg==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(136003)(376002)(396003)(346002)(451199021)(36840700001)(40470700004)(46966006)(2906002)(54906003)(5660300002)(36860700001)(82310400005)(47076005)(8676002)(8936002)(40460700003)(41300700001)(316002)(70206006)(70586007)(478600001)(6916009)(4326008)(36756003)(40480700001)(6666004)(7696005)(336012)(1076003)(81166007)(86362001)(2616005)(26005)(186003)(83380400001)(82740400003)(356005)(426003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2023 13:27:07.6507
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: db3a02c3-15d8-42c9-4870-08db5ac83daf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT106.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR12MB5480
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support pm ops support for SoundWire dma driver.

Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
---
 sound/soc/amd/ps/ps-sdw-dma.c | 91 ++++++++++++++++++++++++++++++++++-
 1 file changed, 89 insertions(+), 2 deletions(-)

diff --git a/sound/soc/amd/ps/ps-sdw-dma.c b/sound/soc/amd/ps/ps-sdw-dma.c
index be68003cbd67..54cf971589c0 100644
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
@@ -464,16 +488,79 @@ static int acp63_sdw_platform_probe(struct platform_device *pdev)
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
+	pm_runtime_enable(&pdev->dev);
+	pm_runtime_allow(&pdev->dev);
+	return 0;
+}
 
-	return status;
+static int acp63_sdw_platform_remove(struct platform_device *pdev)
+{
+	pm_runtime_disable(&pdev->dev);
+	return 0;
 }
 
+static int __maybe_unused acp63_sdw_pcm_resume(struct device *dev)
+{
+	struct sdw_dma_dev_data *sdw_data;
+	struct acp_sdw_dma_stream *stream;
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
+			stream = runtime->private_data;
+			period_bytes = frames_to_bytes(runtime, runtime->period_size);
+			buf_size = frames_to_bytes(runtime, runtime->buffer_size);
+			acp63_config_dma(stream, sdw_data->acp_base, index);
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
+			stream = runtime->private_data;
+			period_bytes = frames_to_bytes(runtime, runtime->period_size);
+			buf_size = frames_to_bytes(runtime, runtime->buffer_size);
+			acp63_config_dma(stream, sdw_data->acp_base, index);
+			ret = acp63_configure_sdw_ringbuffer(sdw_data->acp_base, index,
+							     buf_size, ACP_SDW1);
+			if (ret)
+				return ret;
+			writel(period_bytes, sdw_data->acp_base + water_mark_size_reg);
+		}
+	}
+	acp63_enable_disable_sdw_dma_interrupts(sdw_data->acp_base, true);
+	return 0;
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

