Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E00D723714
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 08:03:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233954AbjFFGDA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 02:03:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229693AbjFFGC4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 02:02:56 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2089.outbound.protection.outlook.com [40.107.93.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 975A411B
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 23:02:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vtxd9g23Vz5PqLgIVKuEkxMUXimKKS1Zy22dJRCO33mg9R+NbdWyVa9UMxKA2LU+nKhSNYmeIw+6uKa1HtJkona26i2cI2AtMQxfy7lKUoOFd4KzpFAfrglnwHO+Z/cl1XgSENzfFm9jNGxvVpOwXug0guuIDPKHc2jxhUD2kor+3ByXDlT3aAq3JPPCE6s71ctEiiR0u1v/codv//tXzLnJnc3tiMYuw7VkVFXwahlCsGFEPxpbb56aZj3ZRmWid2+mxJ9ONJybcV9QXXhgNV6NJImDv33VE5r37SQDp6FzlUdDqz6kFgmO9sZoH77AwckzG6YizcmE+TXmDMwvlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3PoK1XVLAquVef4kgmijbs9B3i2NbZg7iTanOO2NWyo=;
 b=Mu8lirlGXvUdnZ5sT0uw0uLVp0L7/sg77mm6FTqDyjKVl4M9laeJR8mGo6YOQPDPc9XAO522p9LU94bkzl7AxdLM/cqmxyhPT9zYyck3aeLjXUmD1Ghjh+Br+vDnLo6sORnYnSmsxNZSM071ZloODgcHvwBuUnTkB2gAMQsZgJ7LjD6z0yL7DsiVxYenCByNAlEy+gAD4Qr+B9F3aBa8dtZTypOBFCopIEZkKqkJPc1P8R2Kr5/LVZr/b7IQdzeQqz66fp/e4MNBk/ROKXd+jc4H/vvD/yewNeeyj58/EN0+8KYnhiaXLwXIYkl2XDfMuczWEOsie/XDgkNRExtyyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3PoK1XVLAquVef4kgmijbs9B3i2NbZg7iTanOO2NWyo=;
 b=RMBkefmLjc0rN7OPFcoL2VQtqA76JtRcJXfFLyGDOfFm8qMAFlk+VEisjXQOy8FbcwwVt1T1e+R+sseKyNYNKAqO/RseqH44Yis3km05WkH+JdxqBQong9+q2VeC28Z5h/XIgJUXq67BE6cNuDljUOv2Z00II9zu9gnhanEzYN4=
Received: from BN0PR02CA0011.namprd02.prod.outlook.com (2603:10b6:408:e4::16)
 by DS0PR12MB7702.namprd12.prod.outlook.com (2603:10b6:8:130::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.32; Tue, 6 Jun
 2023 06:02:52 +0000
Received: from BN8NAM11FT087.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e4:cafe::98) by BN0PR02CA0011.outlook.office365.com
 (2603:10b6:408:e4::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33 via Frontend
 Transport; Tue, 6 Jun 2023 06:02:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT087.mail.protection.outlook.com (10.13.177.24) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6455.33 via Frontend Transport; Tue, 6 Jun 2023 06:02:51 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 6 Jun
 2023 01:02:50 -0500
Received: from vijendar-X570-GAMING-X.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.34
 via Frontend Transport; Tue, 6 Jun 2023 01:02:46 -0500
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
Subject: [PATCH V3 2/9] ASoC: amd: ps: handle SoundWire interrupts in acp pci driver
Date:   Tue, 6 Jun 2023 11:37:17 +0530
Message-ID: <20230606060724.2038680-3-Vijendar.Mukunda@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230606060724.2038680-1-Vijendar.Mukunda@amd.com>
References: <20230606060724.2038680-1-Vijendar.Mukunda@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT087:EE_|DS0PR12MB7702:EE_
X-MS-Office365-Filtering-Correlation-Id: 672246f8-64df-4866-43d5-08db6653a960
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 09pF4RBITbeYhblkm9qqrHvO0MkAWEUsaYpPHQxapQAHSPoiOCt9yj5C7LUPNvQGtZuQ+8ltBEDF01ImMjX7Fyvo7o09OMLO0CUJ7cgEZCRVBRnLVZye6OwQXj30Y9QCcdIJu1UPSaXnvxNflVkkY2o47Pk2z521wnSOHkdToinoEbGBKJUT4m8Q+Qe6xEjiVa8rSGq8jtT9psktr20N705jCH+q36lQbgvB/6Bhw30IHkHLGbs1TwVXPS5qOBX0N8jU32CpEekGK6LMTsf0LMP3DG10qNXeRHa75R2oWg18CJQeGy+J39eD3gsh4e8xzOXQVrmTVAOE+4xpljF0jt/0qLCy5//YbwLuy526RZZML4FWJVyA3s9QKOmf+fIsgMlYTA6YHFlTNG3IUkSi1jihvlhuo0rBja62u5/Lhpy12HyYeK8Ki4PnTl+PcuBNBDIHADn+Eh1zmX6IIh8tdeTh5qtfuxC/4d3ZmCNt4CMRKEpqy2zyzOa+i7fkGQUAvprMlsOE6Lbw7zOEeUWLBbkq5y94A1nY8KvWxt6SFERAOD4WejsgbtRbTsT172dYvIZVZf4rIRxT+qE/UZUMBCEF96XMAQUwQmcb+u3FwqRENb7S22JWXxCEHx4lDwW73p+SxXpjSig3Vc8y+FLYnASZ7ImB75Yg9gwTLFBkLfL7C2KFZAS4URyPOodTOIEZGN7bJo9RLHY7U46EuztlDnkTRwu+Vx+dcr1v/agFQ+GOLsH3S8rGVT6rfEu5o73EWiEV1OZKmHu4aZbGwwWjdQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(136003)(346002)(376002)(451199021)(40470700004)(46966006)(36840700001)(40460700003)(426003)(336012)(2906002)(47076005)(83380400001)(2616005)(36756003)(82310400005)(86362001)(356005)(81166007)(82740400003)(36860700001)(40480700001)(7696005)(41300700001)(316002)(6666004)(5660300002)(8936002)(8676002)(54906003)(478600001)(70206006)(4326008)(70586007)(26005)(1076003)(6916009)(186003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2023 06:02:51.2565
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 672246f8-64df-4866-43d5-08db6653a960
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT087.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7702
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

Handle SoundWire manager related interrupts in ACP PCI driver
interrupt handler and schedule SoundWire manager work queue for
further processing.

Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
---
 sound/soc/amd/ps/acp63.h  |  4 ++++
 sound/soc/amd/ps/pci-ps.c | 48 +++++++++++++++++++++++++++++++++++----
 2 files changed, 47 insertions(+), 5 deletions(-)

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
index 816c22e7f1ab..17e29a3e1c21 100644
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

