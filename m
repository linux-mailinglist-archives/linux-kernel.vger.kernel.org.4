Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2084C72BE8F
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 12:15:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233243AbjFLKOk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 06:14:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230262AbjFLKN5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 06:13:57 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2040.outbound.protection.outlook.com [40.107.243.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0314E4C21
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 02:55:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kG17wBClboBn+mkaoIeBjH6jJqlWfL+Rz7chSSh/ym2cUe5zSQBQNNn+3/oSXxIsIV9+HW4k+Q9U3GliGtur74PBmRlQbzVbARLbpjf+hpEyhM28qtBUGbjs7kFLRoYscCVEaqwcamHlu13+WFZpoxVyD2SowdwOUeiHdiqR00t9uSWO6SL3zd+iLCxWmzM3SDWISnzGjr2AVTiU+wqSIlTVAXGubF8vht6mXltcAiHJCIJOcZKlL7LRDb7kR16KsLrYSRHpQW2ucSSkweVT8Zc0XuNRLLE5f9QJqIS/LUXUUPYdFdOeRxoRMmFwR8cY0HIJZRCfp95jz271jkLMwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HqVfCXwL2B/fl1phJVIPaeM+y2/V+cztliQfi8D3X6A=;
 b=CrvseDmslnyQAFEmMwGfLpPUF1CkyhGcO/7RbD2PfhsYdgALIMnN56m/kIGSSQXpTf3o4gQ1C+sY7uhKgmDNzcfKWuT7AWqXubQMOgvyUeKIyZlPz/f+1Xf7RoanclotplyxyfBR3UXoXGtAkGsA2OQZVMJDESNgr4HdhD8nf9G9/Hnl2lMVnUV6YSfEz517QCcK9Ty2UgrYZe1Sh51/whFyxddsBL4CjFMH6oykrSRRZr/jgzn5cmh6icP/uvP1ezpnpIGwqmc9PacN1s2jG4LH77YQ9xf6kwKN8mVIfAE+D9g5d24Pg29/gbnjZDtmN/riYTyBykDNxLLp0ZEbIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HqVfCXwL2B/fl1phJVIPaeM+y2/V+cztliQfi8D3X6A=;
 b=A8PlOfc10V96hCDT7Un6rrQyIIimZLmzHz/eLzG4+lnQnLOfw6pRe0/QmNekwRP++B6zc0M7Zl+5wrJBC11NN2mIG7m1JQuQMNHjiB2IcnwMmqW4tHZ2drbQ5kdhmYkXWhx4Adrd0hIjMKVQNMRQ8qkNRfItF5TmYD3Hn/jqFwA=
Received: from DS7PR03CA0007.namprd03.prod.outlook.com (2603:10b6:5:3b8::12)
 by SN7PR12MB7298.namprd12.prod.outlook.com (2603:10b6:806:2ae::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Mon, 12 Jun
 2023 09:55:32 +0000
Received: from CY4PEPF0000E9D7.namprd05.prod.outlook.com
 (2603:10b6:5:3b8:cafe::77) by DS7PR03CA0007.outlook.office365.com
 (2603:10b6:5:3b8::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.34 via Frontend
 Transport; Mon, 12 Jun 2023 09:55:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CY4PEPF0000E9D7.mail.protection.outlook.com (10.167.241.78) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6500.22 via Frontend Transport; Mon, 12 Jun 2023 09:55:31 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Mon, 12 Jun
 2023 04:55:31 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Mon, 12 Jun
 2023 04:55:30 -0500
Received: from vijendar-X570-GAMING-X.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.23
 via Frontend Transport; Mon, 12 Jun 2023 04:55:27 -0500
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
Subject: [PATCH V4 6/9] ASoC: amd: ps: add pm ops support for SoundWire dma driver
Date:   Mon, 12 Jun 2023 15:29:00 +0530
Message-ID: <20230612095903.2113464-7-Vijendar.Mukunda@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230612095903.2113464-1-Vijendar.Mukunda@amd.com>
References: <20230612095903.2113464-1-Vijendar.Mukunda@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D7:EE_|SN7PR12MB7298:EE_
X-MS-Office365-Filtering-Correlation-Id: efd42ab4-3574-4c52-ff2c-08db6b2b28f0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3+vizlV7iQz01xcycz6M/o8uv6WLlRt6JRyW3Ih/+QIygY2tycwHbuD4cpCYP7Ix7Q3Kg+RM570s95Is/oFPAoOXXSviETLuLsA4VXRA11YmnsfStucjox07B/KiHffDf5H04G/pohQiu243fdwQdeRdSRtmsUi3ntqPEkw/JZmrLihBhzCfdK8ronGemfTqnewsoB6j+HfHog1jARO+lAWyDBLjf55bh6aCX111TvPccxed/4DawTiyN68HKck8lKdcgXnKIf0dlBzXe11JYQmtAj8CS1JdsRl55trRWOAVHWW1imoJt13dTxLG1JLyyOVJt24ocqrglu/auE5Lw8/azVcbDU9Xi7fHERe8wpdUTA1q55PfUkQzD0iiaLZrI5jY4+of6kIAKcx/GXrU0Bo0UQHA6stJuEnklgdEQUO88dPEWi0zpacSfblcNLPLAq82W3XdxCGdxWI5IgOKRM2bIpjK+qEwNjfR1JSVa57/OfYYCaWqYlb415vZ+qqJ6U97dFHF+N1ZfDuaYsrpJfCf50ctCNyhO4NINz8TjI9iUCsWp9NRCDdS/VACGJx3rvwv57WahcIuNV6gk0IdsPJ23WBvsICFvqAJwPo8MSLzxLcWwFwCBQiFhn++CurN2tdxMmMIH4TWy+8jInm5bu4v91jpNvwDSNf/B1nN46oJ9osZZolydzULIzKBmMRG+ZOBsZ76Y8aU8gJ2QD7Vyt7eh3rfMHk9zsVIK6exJsNo28ugQsVXb9O8vnXUd8NmHx7i+Pb5M2luew1lVYmYpA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(346002)(39860400002)(376002)(396003)(136003)(451199021)(40470700004)(36840700001)(46966006)(41300700001)(6666004)(40480700001)(8936002)(36756003)(8676002)(6916009)(5660300002)(54906003)(70206006)(70586007)(316002)(4326008)(40460700003)(478600001)(2906002)(7696005)(83380400001)(426003)(26005)(36860700001)(82310400005)(1076003)(186003)(82740400003)(2616005)(356005)(81166007)(47076005)(336012)(86362001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2023 09:55:31.6768
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: efd42ab4-3574-4c52-ff2c-08db6b2b28f0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D7.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7298
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
 sound/soc/amd/ps/ps-sdw-dma.c | 98 ++++++++++++++++++++++++++++++++++-
 1 file changed, 96 insertions(+), 2 deletions(-)

diff --git a/sound/soc/amd/ps/ps-sdw-dma.c b/sound/soc/amd/ps/ps-sdw-dma.c
index 1de78948f859..ade130a8062a 100644
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
@@ -440,16 +464,86 @@ static int acp63_sdw_platform_probe(struct platform_device *pdev)
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

