Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63A7C6656B3
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 10:01:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236455AbjAKJBH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 04:01:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232469AbjAKJAh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 04:00:37 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2050.outbound.protection.outlook.com [40.107.223.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3489610543
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 01:00:36 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oL7tEuG5rG6wfHOaul792IYvFNLvPwNxipByK5wyO5BrLVhFAc3cd8pVipFnLRns5pD2NybbBNRbwnfJ8DJ7EHLKiGyNjDwCXNZR4lRtgs2768JV9l3MnbE/3q2jWukRwJaHhdlSZMrxHMOyMJltnG6P9KrB14dq0WLZWBdzfB/QLk9j1uYIHh3Rr/oaykn8ftVJn7ZUn0Kzak1Y3zVeqwz4kPLlgdaxogDz98u9sWBLI7c9R2rCmXWs0tyHmyst3akbpj4m+UtfG6CxdFkAHrj+AqTJfocm+55fh84IqEFFlLPIiw55GKF2FNSlR8jXUgonsyG5obyg0vkL/jj6xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W8u/irJTwCcmWnAXydVByr309oN5TGX1ukn4tq8NZnc=;
 b=TZifiZd2/j/MXEq2C1M/aZH9C98oMubvhsUYFNNDSN6uNGqpdVlaIYNgzCRXmdZsM2MONQH+rxugx5rW+43jgudiVoX+bKWNeNXghI+QlbekZHvhdhhQoHgCiyBWFmkURhyEtU2vLv181RuC1GHZ1OlNhsp9XooKbjdu3VnGBg86MrpK4WZTW5rSCtogZbQMHxGiKo0ELiiMAF+N/8a4VTFqjXvwopOXgrwr89p/xC7JcnND4zVPR3n3wOKS4oHRuesqMmfOK02gRo9+mYbg01yTAw2O3+fbYPjNMXdCyXJZk30iOAU0CyNoWW3xM0ma5N/mNp7ILCjgwxlby4LPwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W8u/irJTwCcmWnAXydVByr309oN5TGX1ukn4tq8NZnc=;
 b=P2ZT1pxcrCIyII5LHmyc85XqvQqi9aoteWHGuh5JSEYQtGrsx7pQ4+8vHPXeXKCbdAlIQttqAajboLSk4EPNPDt0wxeXLn6Riq4EjVPHoNiWrATRT4XWadnKp7dtSdPM4S1t9YgK2JuE1K8MKufzzBWo7yLdgy+wnaScKliip+E=
Received: from DM6PR06CA0096.namprd06.prod.outlook.com (2603:10b6:5:336::29)
 by BY5PR12MB4888.namprd12.prod.outlook.com (2603:10b6:a03:1d8::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Wed, 11 Jan
 2023 09:00:33 +0000
Received: from DM6NAM11FT084.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:336:cafe::41) by DM6PR06CA0096.outlook.office365.com
 (2603:10b6:5:336::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.13 via Frontend
 Transport; Wed, 11 Jan 2023 09:00:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT084.mail.protection.outlook.com (10.13.172.132) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5986.18 via Frontend Transport; Wed, 11 Jan 2023 09:00:32 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 11 Jan
 2023 03:00:20 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 11 Jan
 2023 01:00:19 -0800
Received: from vijendar-X570-GAMING-X.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.34
 via Frontend Transport; Wed, 11 Jan 2023 03:00:14 -0600
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
        Syed Saba Kareem <Syed.SabaKareem@amd.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH 06/19] ASoC: amd: ps: add support for soundwire interrupts in acp pci driver
Date:   Wed, 11 Jan 2023 14:32:09 +0530
Message-ID: <20230111090222.2016499-7-Vijendar.Mukunda@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230111090222.2016499-1-Vijendar.Mukunda@amd.com>
References: <20230111090222.2016499-1-Vijendar.Mukunda@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT084:EE_|BY5PR12MB4888:EE_
X-MS-Office365-Filtering-Correlation-Id: df68ed91-0e74-44da-02ed-08daf3b24be0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lqIMcXT3UThITRZcEXJmOSANE+6Uf/vb273Ins6YPn37wCvTPmsGADyciOBzXMeCcbeG3w3BmQGy+h6kTCt/CUSSZq/16ULSxjSCsA8m01Hr6vuIf/a1+0za6Zi93Bukq0WMY3u1R139exM1GjjrPSD4+HMi7OL1J9ptNAbT1UQDYVjDpoWYERtHd3tLccaFAORnZms4y/Hnuk2xi2suYrPqZthlUbUxJLHF+d9fu/aOW2I3fegLbocoNlqrXmOrLUY6FA9u5tjsq62ehglQb1PFC4NdeSvSjlSK8xmNs0Xbwt5T0x0Chf52JEUstkGlLrqKB7cmgivaReQh3blxDvql8xRJxgj76Tcqe4ZbACLuRy/uQxk7kIJG+bDdZxzCJWmdFevmyoGmV3Kb6jIgz9B4aarnfcPJiqzeaIhV7UgHnt53DY8q4ekgmgeneLucnI2sDtdCXsEQdjxwFjx0yn9JVJ4mzPQPQ5afitOQW1l46IceCCW1O8ezXt2EBtTj3kfBk1Vhj+oyWo6padp3vYDWjqES4EQMdRALLrPgYPaayc1gBJxd/AzJjr2j9A+ggVO+3Ys/xlRQqoT0xqN/dSQlMUK81859p9PY16K35xXXn59ypmPqIHZ8YVdfbQfCvKh5yfUahwov53Nq6LYRz6CTgee2v1PJdTPOG4HTinlMPzxdf5xpOfYlp2XfbrQffrjwcAv6DQgThuhVbovMVz4VjTeDzR6Yll8DKuJEnz+5aIYhNVCEhBwq8YDxvIlAD4gKjTGDknVf2Sk/DVPBU5nlcK5Ht2sI8KLZXwcyWyY=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(396003)(136003)(376002)(346002)(451199015)(40470700004)(36840700001)(46966006)(8676002)(40460700003)(478600001)(4326008)(70586007)(70206006)(336012)(40480700001)(316002)(36756003)(54906003)(356005)(81166007)(186003)(110136005)(82740400003)(2616005)(26005)(7696005)(2906002)(1076003)(47076005)(426003)(86362001)(6666004)(83380400001)(82310400005)(41300700001)(8936002)(36860700001)(5660300002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2023 09:00:32.8265
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: df68ed91-0e74-44da-02ed-08daf3b24be0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT084.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4888
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Handle soundwire controller related interrupts in ACP PCI driver irq
handler and schedule controller work queue for further processing.

Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
---
 sound/soc/amd/ps/acp63.h  |  4 ++++
 sound/soc/amd/ps/pci-ps.c | 40 ++++++++++++++++++++++++++++++++++-----
 2 files changed, 39 insertions(+), 5 deletions(-)

diff --git a/sound/soc/amd/ps/acp63.h b/sound/soc/amd/ps/acp63.h
index ed979e6d0c1d..0bd9dc363461 100644
--- a/sound/soc/amd/ps/acp63.h
+++ b/sound/soc/amd/ps/acp63.h
@@ -64,6 +64,10 @@
 #define ACP63_SDW_ADDR			5
 #define AMD_SDW_MAX_CONTROLLERS		2
 
+#define ACP_SDW0_IRQ_MASK	21
+#define ACP_SDW1_IRQ_MASK	2
+#define ACP_ERROR_IRQ_MASK      29
+
 enum acp_config {
 	ACP_CONFIG_0 = 0,
 	ACP_CONFIG_1,
diff --git a/sound/soc/amd/ps/pci-ps.c b/sound/soc/amd/ps/pci-ps.c
index 85154cf0b2a2..0fbe5e27f3fb 100644
--- a/sound/soc/amd/ps/pci-ps.c
+++ b/sound/soc/amd/ps/pci-ps.c
@@ -67,6 +67,7 @@ static int acp63_reset(void __iomem *acp_base)
 static void acp63_enable_interrupts(void __iomem *acp_base)
 {
 	acp63_writel(1, acp_base + ACP_EXTERNAL_INTR_ENB);
+	acp63_writel(BIT(ACP_ERROR_IRQ_MASK), acp_base + ACP_EXTERNAL_INTR_CNTL);
 }
 
 static void acp63_disable_interrupts(void __iomem *acp_base)
@@ -116,23 +117,52 @@ static irqreturn_t acp63_irq_handler(int irq, void *dev_id)
 {
 	struct acp63_dev_data *adata;
 	struct pdm_dev_data *ps_pdm_data;
-	u32 val;
+	struct amd_sdwc_ctrl *ctrl;
+	u32 ext_intr_stat, ext_intr_stat1;
+	u16 irq_flag = 0;
 	u16 pdev_index;
 
 	adata = dev_id;
 	if (!adata)
 		return IRQ_NONE;
+	ext_intr_stat = acp63_readl(adata->acp63_base + ACP_EXTERNAL_INTR_STAT);
+	if (ext_intr_stat & BIT(ACP_SDW0_IRQ_MASK)) {
+		pdev_index = adata->sdw0_dev_index;
+		ctrl = dev_get_drvdata(&adata->pdev[pdev_index]->dev);
+		acp63_writel(BIT(ACP_SDW0_IRQ_MASK), adata->acp63_base + ACP_EXTERNAL_INTR_STAT);
+		schedule_work(&ctrl->amd_sdw_irq_thread);
+		irq_flag = 1;
+	}
 
-	val = acp63_readl(adata->acp63_base + ACP_EXTERNAL_INTR_STAT);
-	if (val & BIT(PDM_DMA_STAT)) {
+	ext_intr_stat1 = acp63_readl(adata->acp63_base + ACP_EXTERNAL_INTR_STAT1);
+	if (ext_intr_stat1 & BIT(ACP_SDW1_IRQ_MASK)) {
+		pdev_index = adata->sdw1_dev_index;
+		ctrl = dev_get_drvdata(&adata->pdev[pdev_index]->dev);
+		acp63_writel(BIT(ACP_SDW1_IRQ_MASK), adata->acp63_base + ACP_EXTERNAL_INTR_STAT1);
+		schedule_work(&ctrl->amd_sdw_irq_thread);
+		irq_flag = 1;
+	}
+
+	if (ext_intr_stat & BIT(ACP_ERROR_IRQ_MASK)) {
+		acp63_writel(BIT(ACP_ERROR_IRQ_MASK), adata->acp63_base + ACP_EXTERNAL_INTR_STAT);
+		acp63_writel(0, adata->acp63_base + ACP_SW_I2S_ERROR_REASON);
+		acp63_writel(0, adata->acp63_base + ACP_P1_SW_I2S_ERROR_REASON);
+		acp63_writel(0, adata->acp63_base + ACP_ERROR_STATUS);
+		irq_flag = 1;
+	}
+
+	if (ext_intr_stat & BIT(PDM_DMA_STAT)) {
 		pdev_index = adata->pdm_dev_index;
 		ps_pdm_data = dev_get_drvdata(&adata->pdev[pdev_index]->dev);
 		acp63_writel(BIT(PDM_DMA_STAT), adata->acp63_base + ACP_EXTERNAL_INTR_STAT);
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

