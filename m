Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2FAB6656DA
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 10:05:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238259AbjAKJE4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 04:04:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238284AbjAKJEF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 04:04:05 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2073.outbound.protection.outlook.com [40.107.92.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3D1315816
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 01:02:41 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EAplgbQ4nUldM8xN3j4hUmGhFxGecHkHV8Qy4BERsXQVL2xcYxYkC997yzF5RdnsogU2myNWH6plDubZ8y8nTvgtXXKxjeINrImhy6q5wtwv5RwncQ2lBAcgJ+1IUSAZ3NzGbOB4qbSiPRrg8O6VsmmRj69kvtboNuROOmQ0lcjrUQF4ngyUnhtoONccJ9KJV2bYWGcxISTsJYROnG94KiFIL2Za1algAonn5TkeNKa2NKGeMG4gptd1ndEanMfpvqcQO8Z9c9O7BbCQXzz+SP5nZ2+cH0++o4NsNqpOXPSFWPmuwhH3Z1bHjZz8um2PcWMQyrxnIMSWNsG8e0GlQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=76mezMuevE9lC+/RR1ZkbSJx9XxLC+0W9HK8/vNNwUA=;
 b=b+PWWrvkuPlrdT6f6Ufg7EwKXgtS1TYJ/v27uPCypwH0M9nZEQldJDYw8UKkJrLBQ/n9g7NgFIXQesMQPJMHiiu3qT41jeodiUhZ2GVJTL14plIHGfKt1fLfMon1GEs4rQhcZB5KiC3d0RL6xJMdlPYTDORGYXoKJk2bJRu/IGoMIYELGZgyncOHCORcciWr7UCHDI2uEj1zuKtVkrUxq5FYSmdUr210guyfdYU33X6Nevdg6TQqSt6+TpL2mc6fOsHy4EYRW8u7sbMkmSJr7Ib4L/yGB/nGx7jzQuGpCyQ38ZJJ6yMho/qhhPc4MmJu9h10ZOQSra5Xkzl94hjoGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=76mezMuevE9lC+/RR1ZkbSJx9XxLC+0W9HK8/vNNwUA=;
 b=HqCNd/XdA106EBLu8kz5DcGoRS7KegeM+C6B5Ec5E0oGz9XwrFgA5vzHANqCs9nFTuIkwCmi/MCam1AIWwpcOzfL7ErW2HJODmkBdQimOi5eyvfwoU+KsvkPgjTMI27u28vOBa5jBELT6Rgz7w+LdbOw7rcgft9LF6PvGpcaq2w=
Received: from DS7PR05CA0057.namprd05.prod.outlook.com (2603:10b6:8:2f::21) by
 DM4PR12MB8572.namprd12.prod.outlook.com (2603:10b6:8:17d::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5986.18; Wed, 11 Jan 2023 09:02:12 +0000
Received: from DM6NAM11FT004.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:2f:cafe::bb) by DS7PR05CA0057.outlook.office365.com
 (2603:10b6:8:2f::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.12 via Frontend
 Transport; Wed, 11 Jan 2023 09:02:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT004.mail.protection.outlook.com (10.13.172.217) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5986.18 via Frontend Transport; Wed, 11 Jan 2023 09:02:12 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 11 Jan
 2023 03:02:04 -0600
Received: from vijendar-X570-GAMING-X.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.34
 via Frontend Transport; Wed, 11 Jan 2023 03:02:00 -0600
From:   Vijendar Mukunda <Vijendar.Mukunda@amd.com>
To:     <broonie@kernel.org>, <vkoul@kernel.org>,
        <alsa-devel@alsa-project.org>
CC:     <Basavaraj.Hiregoudar@amd.com>, <Sunil-kumar.Dommati@amd.com>,
        <Mario.Limonciello@amd.com>, <Mastan.Katragadda@amd.com>,
        <arungopal.kondaveeti@amd.com>,
        Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH 13/19] ASoC: amd: ps: add support for runtime pm ops for soundwire dma driver
Date:   Wed, 11 Jan 2023 14:32:16 +0530
Message-ID: <20230111090222.2016499-14-Vijendar.Mukunda@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230111090222.2016499-1-Vijendar.Mukunda@amd.com>
References: <20230111090222.2016499-1-Vijendar.Mukunda@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT004:EE_|DM4PR12MB8572:EE_
X-MS-Office365-Filtering-Correlation-Id: 93f59832-5fb2-4155-a7bc-08daf3b28715
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CFLXhYESgBYKay7IiujiyoQrCqGXb2BcfWEVEz3nFD/d5CcywT6Gr3buSxGHos94Ok8fevQBo/2UdSnCXMTVxlyHoW/l0dA4Yp8jg4edaBMAy8qM7HV/fJ6XfyX2+CWtfxvp/ca1ShavYmaTNHdHAiw0b5XdsXZZk9EtAnC7GOKdHySYRqJobcFB3rKsB6699EV2OTB1QA9ApEoMUtzEsv83SeSzzBYrrtsT4BhPNdTx0YxBTnv3ix8L0vLYmp4QEZAy38fI5xcshL5XzFU+aqWXvbIsoBW7e0cFwpVO4+hxmWWLqPwzT3eSBbqD6vlHvcu6ihwlK0J6tPlAY50iS8Y7DH3v72ol/BniotGSuvHKQWEHQHdFlG8ytZVnwxM62k1c0p603p6dncVoBJLOjJN0eZLYZUgbfP3LkgVRBCW9G9o/a/pbe8WvoiGnkmNHVtnOsqVvVr8eW3ArU7fx5H7ZgEb6j//CsUpo+hJfO+GwSvFOISCsmJ2nSwZvOlhSOhZ5LluC447oUFi+I5fsLQ9CSEBC6swwZesSQQzL2Gk7zX0WVcy8FJLP3k8VlqJidLtOzJchSkNDp8rBoD2n4H7hFVhaV9O1R06ZM/0nM8yO70M2Yo8KPDsdL6FfcKZKGqpxbQnsoiyQgh6KCAEjg2ueAJfARm8TBGXgDNwzxqn3Z/3ulU6W9A9RctnZ0nbvtEhDzS5IWuR3ASsfjtz96DcWwF48gwIoGwMoz0SKOVc=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(376002)(346002)(396003)(136003)(451199015)(46966006)(40470700004)(36840700001)(36860700001)(82740400003)(6666004)(81166007)(2906002)(356005)(478600001)(2616005)(1076003)(26005)(7696005)(186003)(5660300002)(40480700001)(316002)(8936002)(83380400001)(40460700003)(82310400005)(36756003)(86362001)(426003)(47076005)(41300700001)(110136005)(8676002)(336012)(70586007)(54906003)(70206006)(4326008)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2023 09:02:12.1636
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 93f59832-5fb2-4155-a7bc-08daf3b28715
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT004.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8572
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for runtime pm ops for soundwire dma driver.

Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
---
 sound/soc/amd/ps/ps-sdw-dma.c | 66 +++++++++++++++++++++++++++++++++++
 1 file changed, 66 insertions(+)

diff --git a/sound/soc/amd/ps/ps-sdw-dma.c b/sound/soc/amd/ps/ps-sdw-dma.c
index e94f76053c66..960c0bc5e848 100644
--- a/sound/soc/amd/ps/ps-sdw-dma.c
+++ b/sound/soc/amd/ps/ps-sdw-dma.c
@@ -12,6 +12,7 @@
 #include <sound/pcm_params.h>
 #include <sound/soc.h>
 #include <sound/soc-dai.h>
+#include <linux/pm_runtime.h>
 #include <linux/soundwire/sdw_amd.h>
 #include "acp63.h"
 
@@ -56,6 +57,30 @@ static const struct snd_pcm_hardware acp63_sdw_hardware_capture = {
 	.periods_max = SDW_CAPTURE_MAX_NUM_PERIODS,
 };
 
+static void acp63_enable_disable_sdw_dma_interrupts(void __iomem *acp_base, bool enable)
+{
+	u32 ext_intr_cntl, ext_intr_cntl1, irq_mask, irq_mask1;
+
+	irq_mask = ACP_SDW_DMA_IRQ_MASK;
+	irq_mask1 = ACP_P1_SDW_DMA_IRQ_MASK;
+
+	if (enable) {
+		ext_intr_cntl = acp63_readl(acp_base + ACP_EXTERNAL_INTR_CNTL);
+		ext_intr_cntl |= irq_mask;
+		acp63_writel(ext_intr_cntl, acp_base + ACP_EXTERNAL_INTR_CNTL);
+		ext_intr_cntl1 = acp63_readl(acp_base + ACP_EXTERNAL_INTR_CNTL1);
+		ext_intr_cntl1 |= irq_mask1;
+		acp63_writel(ext_intr_cntl1, acp_base + ACP_EXTERNAL_INTR_CNTL1);
+	} else {
+		ext_intr_cntl = acp63_readl(acp_base + ACP_EXTERNAL_INTR_CNTL);
+		ext_intr_cntl &= ~irq_mask;
+		acp63_writel(ext_intr_cntl, acp_base + ACP_EXTERNAL_INTR_CNTL);
+		ext_intr_cntl1 = acp63_readl(acp_base + ACP_EXTERNAL_INTR_CNTL1);
+		ext_intr_cntl1 &= ~irq_mask1;
+		acp63_writel(ext_intr_cntl1, acp_base + ACP_EXTERNAL_INTR_CNTL1);
+	}
+}
+
 static void acp63_config_dma(struct sdw_stream_instance *sdw_ins, u32 stream_id)
 {
 	u16 page_idx;
@@ -585,13 +610,54 @@ static int acp63_sdw_platform_probe(struct platform_device *pdev)
 
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
+static int __maybe_unused acp63_sdw_pcm_runtime_suspend(struct device *dev)
+{
+	struct sdw_dma_dev_data *sdw_dma_data;
+
+	sdw_dma_data = dev_get_drvdata(dev);
+	mutex_lock(sdw_dma_data->acp_lock);
+	acp63_enable_disable_sdw_dma_interrupts(sdw_dma_data->acp_base, false);
+	mutex_unlock(sdw_dma_data->acp_lock);
+
+	return 0;
+}
+
+static int __maybe_unused acp63_sdw_pcm_runtime_resume(struct device *dev)
+{
+	struct sdw_dma_dev_data *sdw_dma_data;
+
+	sdw_dma_data = dev_get_drvdata(dev);
+	mutex_lock(sdw_dma_data->acp_lock);
+	acp63_enable_disable_sdw_dma_interrupts(sdw_dma_data->acp_base, true);
+	mutex_unlock(sdw_dma_data->acp_lock);
+
 	return 0;
 }
 
+static const struct dev_pm_ops acp63_pm_ops = {
+	SET_RUNTIME_PM_OPS(acp63_sdw_pcm_runtime_suspend,
+			   acp63_sdw_pcm_runtime_resume, NULL)
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

