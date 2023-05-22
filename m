Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DC7970BFB2
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 15:27:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233584AbjEVN1B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 09:27:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233176AbjEVN0s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 09:26:48 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2073.outbound.protection.outlook.com [40.107.220.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6323CD
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 06:26:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HSwFulvY3E3OJe7p4HwTGJ2rNEm+HsY1y1ba3z0cXTL1WYW9qQOJ8eTKuLSOqQXMM4mNsD66LuyWJGwqLzp8jhAWXY/r+yQGlZan5pDS+wGaHO+LYiXWlPeGwiNCCLd4ZQ/7sihJQCxolfbx2DJrCTExtpoWLIU/FoGt+CO6sOgoX5O9qJCNXebS1lfrl0E9+qT3QzJDgBe/9x+OJrfgcAfW65sv1/8HLJFhcK0g/GbOhBTDQtgWl32QY5FyJRNej4xMjf6XKpcwlVGqvsD2c7gREJsECDh2ghdm3UU9q9duzzxjwaeDRqcn1oWHFC+6CXHqni6EXzoS6qsivxx+xQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y/ofSN9zfDdAe7BRAIYTLFaYuoG8RAQs1kvAFiSqByE=;
 b=IwJGhVqOu/enlTTPgzxxt6ax+9U60vtvmtQCB7A6Y6v8EAA44/P4ziZXAZtPK1lHZoQqui2Dh0KC+POJvq9RU1KWBbDI6l1WyDlsf0fcrEw2iiXrpattgoZ37sOzH+ZK3e/K0R6RV7FzlXG3o5EkDTyhMP+ZhnUQRPBykZXbL7edr8IbLxeY+jOLu4g/9LB8wAI2O48uN57X+1L5RJ+H92sErNxvQZ0ehOCpWlIU0tCMDML9in3nkjfjOEQQ9tyK5pheXzMEF+1OsWrDvq5iXmiq0d6Wk/qmZ3ZOMJNzzaUxsp1b6dYfAAIDVoVJOCfZ+rVRcKKva1n9S2WU2R7GqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y/ofSN9zfDdAe7BRAIYTLFaYuoG8RAQs1kvAFiSqByE=;
 b=fS8+NYkifSLkwKk0CGHrYv+PjUgOmfKhv/Z1ZYbmJKPp7uMJtOlAkVrCtqMN1qXr54jig+dqGpv/je1ZO/VorHC1St+BKggbvAMFq/lK6Q5Vt+Jdq5VGkb7w3+ho/63TVIbCr0py9f3lQ4kTdyfzKdRwXRn1hXtaiIjju7ejyi8=
Received: from MW4PR02CA0017.namprd02.prod.outlook.com (2603:10b6:303:16d::24)
 by IA0PR12MB7556.namprd12.prod.outlook.com (2603:10b6:208:43c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28; Mon, 22 May
 2023 13:26:36 +0000
Received: from CO1NAM11FT052.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:16d:cafe::79) by MW4PR02CA0017.outlook.office365.com
 (2603:10b6:303:16d::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28 via Frontend
 Transport; Mon, 22 May 2023 13:26:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT052.mail.protection.outlook.com (10.13.174.225) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6411.28 via Frontend Transport; Mon, 22 May 2023 13:26:35 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 22 May
 2023 08:26:34 -0500
Received: from vijendar-X570-GAMING-X.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.34
 via Frontend Transport; Mon, 22 May 2023 08:26:31 -0500
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
Subject: [PATCH V2 2/9] ASoC: amd: ps: handle SoundWire interrupts in acp pci driver
Date:   Mon, 22 May 2023 19:01:15 +0530
Message-ID: <20230522133122.166841-3-Vijendar.Mukunda@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230522133122.166841-1-Vijendar.Mukunda@amd.com>
References: <20230522133122.166841-1-Vijendar.Mukunda@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT052:EE_|IA0PR12MB7556:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b2ebdb2-dad4-4115-5c16-08db5ac82a99
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Enu3MmLXC43MfIrDJNFeY7ly5avHLq/C+rHADwr0e+D1BsZ8kNM65GpZHeUNBV9BJknzU/VMiXodO3ghLHqRnoKkBv47hhCa9UOYoSKaTxqK29B9mgEnm40OLCC32wXXgZnNXcJ5sC/uyRMp29ejt0+QXHjzrmuHVTUZPH0IalKe2usCwm9fM95FKu6W6NvfxMA+7zUnnUo0pWrDlBjrK5oO3V/slG3TNGoAhkRm4cLtrVqFdK+NKnws6YTpDikEIa4CWrNmgqEScya/Sy/Tg29+9+eTbh3VdnJY8TeBrOpMNFLPrS1ujivzHI4uT8Wc73OGDAK3xUzR5/iPM8Lrwm3970Xax+O75Qjh7EGrzow4Xed+qbfLfSCuPf4jUzxZWBUK/pReyeQ6ebNKTu/c8N1dxYd0bRff4Q1ntyJCuowGc0DqGwFhmdGjoI29RYBRfNacJr9pVsvvaOLa/uqwZvlDH5rqfDmRHUzUpqZy62Q+7cw5g7UYczg/lgIluMbvMl81UE4hQOHMKPNITspOMiJqjykNVqIbAUklgWVcwFtTTtfTXToBZNAlYzs4slEbdRSKyKzn5tdMomxXQk5pDS7VEN3QL8kKFi6xpmcIBRLjmV6AW3QPTORIJlGAkQET7na6COiru+hn4sOwhD9YaN6mVJZw3TiRkYo/sLvXKQBsT/5U58bm/ywBTUAmwbtzn2K5NR6k2K66yvN9GsUUYRDqTZJ5GNuL5grKtSNPzGniBM3uQ4rh4Y/bn50RyiGOrkNgTmnJVSr9GxUIKtQqLg==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(396003)(136003)(39860400002)(451199021)(36840700001)(46966006)(40470700004)(2906002)(5660300002)(83380400001)(8676002)(8936002)(82310400005)(36756003)(70586007)(70206006)(4326008)(6916009)(54906003)(316002)(478600001)(41300700001)(6666004)(40480700001)(7696005)(426003)(86362001)(336012)(26005)(2616005)(356005)(81166007)(82740400003)(1076003)(36860700001)(47076005)(186003)(40460700003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2023 13:26:35.6303
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b2ebdb2-dad4-4115-5c16-08db5ac82a99
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT052.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7556
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Handle SoundWire manager related interrupts in ACP PCI driver
interrupt handler and schedule SoundWire manager work queue for
further processing.

Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
---
 sound/soc/amd/ps/acp63.h  |  4 ++++
 sound/soc/amd/ps/pci-ps.c | 43 ++++++++++++++++++++++++++++++++++-----
 2 files changed, 42 insertions(+), 5 deletions(-)

diff --git a/sound/soc/amd/ps/acp63.h b/sound/soc/amd/ps/acp63.h
index 95bb1cef900a..d296059be4f0 100644
--- a/sound/soc/amd/ps/acp63.h
+++ b/sound/soc/amd/ps/acp63.h
@@ -88,6 +88,10 @@
 /* time in ms for acp timeout */
 #define ACP_TIMEOUT		500
 
+#define ACP_SDW0_STAT		BIT(21)
+#define ACP_SDW1_STAT		BIT(2)
+#define ACP_ERROR_IRQ		BIT(29)
+
 enum acp_config {
 	ACP_CONFIG_0 = 0,
 	ACP_CONFIG_1,
diff --git a/sound/soc/amd/ps/pci-ps.c b/sound/soc/amd/ps/pci-ps.c
index 02caae6968ad..26514e340a33 100644
--- a/sound/soc/amd/ps/pci-ps.c
+++ b/sound/soc/amd/ps/pci-ps.c
@@ -56,6 +56,7 @@ static int acp63_reset(void __iomem *acp_base)
 static void acp63_enable_interrupts(void __iomem *acp_base)
 {
 	writel(1, acp_base + ACP_EXTERNAL_INTR_ENB);
+	writel(ACP_ERROR_IRQ, acp_base + ACP_EXTERNAL_INTR_CNTL);
 }
 
 static void acp63_disable_interrupts(void __iomem *acp_base)
@@ -102,23 +103,55 @@ static irqreturn_t acp63_irq_handler(int irq, void *dev_id)
 {
 	struct acp63_dev_data *adata;
 	struct pdm_dev_data *ps_pdm_data;
-	u32 val;
+	struct amd_sdw_manager *amd_manager;
+	u32 ext_intr_stat, ext_intr_stat1;
+	u16 irq_flag = 0;
 	u16 pdev_index;
 
 	adata = dev_id;
 	if (!adata)
 		return IRQ_NONE;
+	ext_intr_stat = readl(adata->acp63_base + ACP_EXTERNAL_INTR_STAT);
+	if (ext_intr_stat & ACP_SDW0_STAT) {
+		writel(ACP_SDW0_STAT, adata->acp63_base + ACP_EXTERNAL_INTR_STAT);
+		pdev_index = adata->sdw0_dev_index;
+		amd_manager = dev_get_drvdata(&adata->pdev[pdev_index]->dev);
+		if (amd_manager)
+			schedule_work(&amd_manager->amd_sdw_irq_thread);
+		irq_flag = 1;
+	}
 
-	val = readl(adata->acp63_base + ACP_EXTERNAL_INTR_STAT);
-	if (val & BIT(PDM_DMA_STAT)) {
+	ext_intr_stat1 = readl(adata->acp63_base + ACP_EXTERNAL_INTR_STAT1);
+	if (ext_intr_stat1 & ACP_SDW1_STAT) {
+		writel(ACP_SDW1_STAT, adata->acp63_base + ACP_EXTERNAL_INTR_STAT1);
+		pdev_index = adata->sdw1_dev_index;
+		amd_manager = dev_get_drvdata(&adata->pdev[pdev_index]->dev);
+		if (amd_manager)
+			schedule_work(&amd_manager->amd_sdw_irq_thread);
+		irq_flag = 1;
+	}
+
+	if (ext_intr_stat & ACP_ERROR_IRQ) {
+		writel(ACP_ERROR_IRQ, adata->acp63_base + ACP_EXTERNAL_INTR_STAT);
+		/* TODO: Report SoundWire Manager instance errors */
+		writel(0, adata->acp63_base + ACP_SW0_I2S_ERROR_REASON);
+		writel(0, adata->acp63_base + ACP_SW1_I2S_ERROR_REASON);
+		writel(0, adata->acp63_base + ACP_ERROR_STATUS);
+		irq_flag = 1;
+	}
+
+	if (ext_intr_stat & BIT(PDM_DMA_STAT)) {
 		pdev_index = adata->pdm_dev_index;
 		ps_pdm_data = dev_get_drvdata(&adata->pdev[pdev_index]->dev);
 		writel(BIT(PDM_DMA_STAT), adata->acp63_base + ACP_EXTERNAL_INTR_STAT);
 		if (ps_pdm_data->capture_stream)
 			snd_pcm_period_elapsed(ps_pdm_data->capture_stream);
-		return IRQ_HANDLED;
+		irq_flag = 1;
 	}
-	return IRQ_NONE;
+	if (irq_flag)
+		return IRQ_HANDLED;
+	else
+		return IRQ_NONE;
 }
 
 static int sdw_amd_scan_controller(struct device *dev)
-- 
2.34.1

