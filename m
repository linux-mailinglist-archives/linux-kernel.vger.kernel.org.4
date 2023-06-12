Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 541A872BE84
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 12:14:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231821AbjFLKOP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 06:14:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229946AbjFLKNw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 06:13:52 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2080.outbound.protection.outlook.com [40.107.94.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E56649EC
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 02:55:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UArtrm1o3NOqdXDs+fFMbI9c9q6wvu26xmtRwmOHvDtkIIYWAwpuHxPSShlllxp/8O93uHUAQ1kvakyLZXmuz9C6tlWrD5CmTB8BAe7FYV4z0EcQ2dehMtiy3mU47EFflseiaVKYRC5BL8alnnyzEbp6idqC0dUsdPeadvhR7zRRpQHU+rvTk2jK2I7NthYPT7TS2xWcon36EoAS667m0ScKJMYrKO0N5BzhMqXeVfpPiyGRsMtv1fSvpH6QOTArvDJZdmeLBAJn/mvRWlap2cZfVOQYDguyMeOWopbLDLXAubbhXBsrjj3G3aiZiRbksIXnOl0Z1GcQ0VKO0Zg6UQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BhJ7USWykBjKEdB1OSsc+Ll8sHZ6/IAGpuK8A9buF4I=;
 b=XTpNYbAYqzEvH1ZphCHYqPgK36ObUC2c0z6BPkxeqL9jT5iFyoCatcJ4ZNDeFx1tXs/nKpxE2nabFMGixbWP1H/SFvMg6s+8sVumNDcGad7uMKcTyRYSnlG5wEA3uv78PY1zglMYU40V0ZyEXO7kBxrKDeo1CoZtv+KRChX37MjDNEnesaVYxT2sPeCJxTsQx/S9jHlt7bRmJbIMCKZq9WUZKZThyt7GwZ23RNWcYkkTR/pVGOWVY/mSmCYYDdBnukpEFLhtQs2dlbeHNjr0R2kpqPBHgxlHKS4XqGznJQNGw7PP/jlduO4PELNLJ9CuELTnfBFd0waOJWIeqKjCIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BhJ7USWykBjKEdB1OSsc+Ll8sHZ6/IAGpuK8A9buF4I=;
 b=eGRJgyOaYVxguLL0I2JRdObWOd2M9qj/VnKuy/N2duBZWhCS2Fuifs4F+5pEMoPQrEtt6RV7d4cfntAEVP4tfE8Q22/+eqkvBNQZwwzfkR+pxn6xdA8t0/87iDXBikqL755HjpF6OrYiaTadF6tCpwErS36p0uWDUQ0J+cPVTaY=
Received: from DS7PR05CA0095.namprd05.prod.outlook.com (2603:10b6:8:56::29) by
 SN7PR12MB7156.namprd12.prod.outlook.com (2603:10b6:806:2a7::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Mon, 12 Jun
 2023 09:55:08 +0000
Received: from CY4PEPF0000E9DB.namprd05.prod.outlook.com
 (2603:10b6:8:56:cafe::be) by DS7PR05CA0095.outlook.office365.com
 (2603:10b6:8:56::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.22 via Frontend
 Transport; Mon, 12 Jun 2023 09:55:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CY4PEPF0000E9DB.mail.protection.outlook.com (10.167.241.81) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6500.22 via Frontend Transport; Mon, 12 Jun 2023 09:55:07 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Mon, 12 Jun
 2023 04:54:59 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Mon, 12 Jun
 2023 02:54:35 -0700
Received: from vijendar-X570-GAMING-X.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.23
 via Frontend Transport; Mon, 12 Jun 2023 04:54:31 -0500
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
Subject: [PATCH V4 2/9] ASoC: amd: ps: handle SoundWire interrupts in acp pci driver
Date:   Mon, 12 Jun 2023 15:28:56 +0530
Message-ID: <20230612095903.2113464-3-Vijendar.Mukunda@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230612095903.2113464-1-Vijendar.Mukunda@amd.com>
References: <20230612095903.2113464-1-Vijendar.Mukunda@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9DB:EE_|SN7PR12MB7156:EE_
X-MS-Office365-Filtering-Correlation-Id: f12d3135-660f-4f7c-970f-08db6b2b1a6c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WrqRydAML/XgWkeiwJX4QHiY4VftrM0ALarNxgXDtZVgrbO0CKROsFBo/qjfrK7gostDWy7n0R25d8qUBMJQDV1jW91Ir7oa7laz86+9Psr+2iiMbQXeyO/iFO9F+kFeFAqXamULJ1bfLpsqoTMjGdOHYqt7VWlLWDFQs5i3pB3mKOH12a9TeB5X2QY4o3fp6SeFFNXCXGuKhlKcpC8nHsbTXvd2mkrC1JxazKRoCX7rQk5kY1+LQxSFp7G2pgBu5J/D6+HNnrOxTcxQ4PaKWc+IO+fbzj2Y4QaWfc37wEfkpCpreU5EhpbTQnI7HgD4KLYPDu1bIlgqGFWqOA8bEFGtZnUp4+S5SWpOLicXZr336rI6tAqThm/XiSXagtpSAyN+grax0/+shhdZkDwrtVDWEvoj4suGAqIHCOBYiauLN5puUwyJ2zQr7ovg4/cl+sZTSX8x8IbahFEqo4lkYl6VoT6gQqTUNzbb8JBF5yE/iem+cTCg+9H3D7AGRySk6XeoeyJddwKNew0jH4JjSl79IRqKkopbTBaqXDGHFZHDOyXDrzE/CKp55eTRnmri29G8cyZPSEEFjv0xyHM+/TJGPNJRNo6bvxF+meAC1X03zyf8KOQ22WwgGe2AzEm6ze2jCpEH2yFhyB6OUCC/a3hpBPSY3l24WCWTdjLz4S0x3znrgB2lk2GOlWIjkvRQgo21sNYTEuqqm7hQF04s2KfB/mmtDAn+xtqGVeeD7W5dTXTN2xwho4HfofkLOZDp/w7KJD6RFoCA8PGD0+vb/A==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(376002)(136003)(39860400002)(396003)(346002)(451199021)(36840700001)(46966006)(40470700004)(6916009)(478600001)(70206006)(2906002)(8936002)(4326008)(316002)(41300700001)(8676002)(54906003)(6666004)(70586007)(5660300002)(7696005)(40460700003)(26005)(1076003)(40480700001)(82740400003)(356005)(2616005)(336012)(47076005)(36860700001)(186003)(83380400001)(36756003)(81166007)(82310400005)(86362001)(426003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2023 09:55:07.3053
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f12d3135-660f-4f7c-970f-08db6b2b1a6c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9DB.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7156
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
 sound/soc/amd/ps/acp63.h  |  3 +++
 sound/soc/amd/ps/pci-ps.c | 48 +++++++++++++++++++++++++++++++++++----
 2 files changed, 46 insertions(+), 5 deletions(-)

diff --git a/sound/soc/amd/ps/acp63.h b/sound/soc/amd/ps/acp63.h
index 80ab542529a7..494f498bdc91 100644
--- a/sound/soc/amd/ps/acp63.h
+++ b/sound/soc/amd/ps/acp63.h
@@ -99,6 +99,9 @@
  * manager instance combination.
  */
 #define ACP63_SDW_PDM_DEV_CONFIG	GENMASK(1, 0)
+#define ACP_SDW0_STAT			BIT(21)
+#define ACP_SDW1_STAT			BIT(2)
+#define ACP_ERROR_IRQ			BIT(29)
 
 enum acp_config {
 	ACP_CONFIG_0 = 0,
diff --git a/sound/soc/amd/ps/pci-ps.c b/sound/soc/amd/ps/pci-ps.c
index cf57ad2d7ccc..ac82dbe13351 100644
--- a/sound/soc/amd/ps/pci-ps.c
+++ b/sound/soc/amd/ps/pci-ps.c
@@ -56,6 +56,7 @@ static int acp63_reset(void __iomem *acp_base)
 static void acp63_enable_interrupts(void __iomem *acp_base)
 {
 	writel(1, acp_base + ACP_EXTERNAL_INTR_ENB);
+	writel(ACP_ERROR_IRQ, acp_base + ACP_EXTERNAL_INTR_CNTL);
 }
 
 static void acp63_disable_interrupts(void __iomem *acp_base)
@@ -102,23 +103,60 @@ static irqreturn_t acp63_irq_handler(int irq, void *dev_id)
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
+	/* ACP interrupts will be cleared by reading particular bit and writing
+	 * same value to the status register. writing zero's doesn't have any
+	 * effect.
+	 * Bit by bit checking of IRQ field is implemented.
+	 */
+	ext_intr_stat = readl(adata->acp63_base + ACP_EXTERNAL_INTR_STAT);
+	if (ext_intr_stat & ACP_SDW0_STAT) {
+		writel(ACP_SDW0_STAT, adata->acp63_base + ACP_EXTERNAL_INTR_STAT);
+		pdev_index = adata->sdw0_dev_index;
+		amd_manager = dev_get_drvdata(&adata->pdev[pdev_index]->dev);
+		if (amd_manager)
+			schedule_work(&amd_manager->amd_sdw_irq_thread);
+		irq_flag = 1;
+	}
+
+	ext_intr_stat1 = readl(adata->acp63_base + ACP_EXTERNAL_INTR_STAT1);
+	if (ext_intr_stat1 & ACP_SDW1_STAT) {
+		writel(ACP_SDW1_STAT, adata->acp63_base + ACP_EXTERNAL_INTR_STAT1);
+		pdev_index = adata->sdw1_dev_index;
+		amd_manager = dev_get_drvdata(&adata->pdev[pdev_index]->dev);
+		if (amd_manager)
+			schedule_work(&amd_manager->amd_sdw_irq_thread);
+		irq_flag = 1;
+	}
 
-	val = readl(adata->acp63_base + ACP_EXTERNAL_INTR_STAT);
-	if (val & BIT(PDM_DMA_STAT)) {
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

