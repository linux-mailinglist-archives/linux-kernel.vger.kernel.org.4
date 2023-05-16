Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCCA1704A8F
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 12:30:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231881AbjEPKa5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 06:30:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231240AbjEPKa4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 06:30:56 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2060.outbound.protection.outlook.com [40.107.94.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1176BE
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 03:30:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DRGPwEJyWQro2vOsIL69Zepxjkf2fIm1IdW2OH4TlZAB0VxX55Kb7v9lyxfuhAc/gjDWsNkKgrVf0cbI+Gw1fDMBZea0LAKmt8nbHPkddwA1dwqIsFojhFilxBTBSlx+9DWeyk277ao/E4nMqP3dxdMclDMY/bjI4lvudZCOfMh1K9fmjzFySZd6C9dXyEe+Mfi8a2EB8QJiCopT3svA3J+qHR0ePGGTxCqbwU6a9UXsSc2yxy6Wd2PB/LfGpeR9gxyp/cL7SIoKiSKBvhr9SK7esFj/gCsUp9DHt+CpM4C7NSVAlYteS/M8cJJoLYzakdeSoxP0r+0ot79mTGSaWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3hqCuF5fUMwMhS/RCGDoVpRpCuC4LY1cjk46vvTKiXA=;
 b=ID6/6WsAdJNwZ0JA+Ie8Wf8hwaXo1wQ72TvF35MxFJXStcb1B0V3MU3Y0phviiXhRvdfDEYrUL4GLM7v6UFxg9aOFLn76qb3Jn+57+FDUjJXi9bcs7h/PqKduxo7/mG5LQkuKWlhkKuSxDunTsHP9qYJ65qkrVpCQIEednqOSrqa1UxJRx+1mGl0d21ZhzjgMkxWlvKfpMeocZOTHUfaqQVLaP9BL8NgWbcNBxwFONiOdpeZW0aEtNJR5B6GQRtEAxkVwkJb9B5d8q6Wv0SRkCXPJgykU6yo7yg+PSeLZ3rkz2EUIHwGWrd7tIowIyRMZeqQiR7XLRGSp05hy3gwBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3hqCuF5fUMwMhS/RCGDoVpRpCuC4LY1cjk46vvTKiXA=;
 b=MIIY75fENzZoUf5WGvFOID6lDp/glew1SdpK4+A2z0VIfQosGfeUUpOvRZZoMoPak2g7lU8pFYVLGpz1TmSNLD+eAgUI3BFh0Hc91flo2n2k//Ut18Yt5WZn+dqZFjenKsD5zh8fLVuYUjli1Sx+MP2fnOUORYJMGcVtj/YxSeY=
Received: from DM6PR08CA0015.namprd08.prod.outlook.com (2603:10b6:5:80::28) by
 DM4PR12MB5104.namprd12.prod.outlook.com (2603:10b6:5:393::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6387.33; Tue, 16 May 2023 10:30:51 +0000
Received: from DM6NAM11FT115.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:80:cafe::49) by DM6PR08CA0015.outlook.office365.com
 (2603:10b6:5:80::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.33 via Frontend
 Transport; Tue, 16 May 2023 10:30:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT115.mail.protection.outlook.com (10.13.173.33) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6411.15 via Frontend Transport; Tue, 16 May 2023 10:30:51 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 16 May
 2023 05:30:47 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 16 May
 2023 05:30:47 -0500
Received: from vijendar-X570-GAMING-X.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.34
 via Frontend Transport; Tue, 16 May 2023 05:30:43 -0500
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
        "Syed Saba Kareem" <Syed.SabaKareem@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/9] ASoC: amd: ps: handle soundwire interrupts in acp pci driver
Date:   Tue, 16 May 2023 16:05:36 +0530
Message-ID: <20230516103543.2515097-3-Vijendar.Mukunda@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230516103543.2515097-1-Vijendar.Mukunda@amd.com>
References: <20230516103543.2515097-1-Vijendar.Mukunda@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT115:EE_|DM4PR12MB5104:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b7a8141-e884-4498-5fad-08db55f89f1d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NhUIGJt+wQPfupRZm1CLp00AUvtPrCpPOD2bMuU2YwZZGvd4e9OIIrT/0aOG/TjadM0a8WcBpBpYJpP/a8LXiwPegiLGuLKwpXFrDBkWX7CsG7QG1TJIcDx4iqM5tz12N2MThy27s+3xlKdFc0xoWh5jale15Wuc5XvBXy3N/x3Ws6IlCsZQLPvAiygWnAZTPSZSJdAcO9paLP0kkUiluifR4VGiY5FIMkHYiEjE7zxwb4mvPvAnqC8Bo/kI9Y0DtYU9D5XVtfa8+iwQIsMDJAHOqqYKNJe6sm3B4mozyhr+cf8O99ltcgTzfI9l3Up6YHy3Oij0iaXugae0zXQUwKw6lbTzgOXQ3uWTWaBEGWsxPtSQ1PvMJI+Fhytkdf8g446ZyH/YOX5Pu8sSZJhbc0es7ynMePfdd6w2NKcJu70XTAeytU/8iaXgWlJI2VVjIKe87xCsZxi6K8Fkgh6qhMlftjvOswerVtWpAltpFIkHz3CEuBS+AjZ8YmnJahinXtNhDOHjZWtBjmr2e5+KUYKmF5/tdkBxhUDfFtUpR7VsMLevZYTUmquG2BvfHcP9bpWhqwbpsDJz4ca4UF164FQN2Ybp8RLhZyvrTlpLUYlwAcqSwi8UMspi9gReQL8zzW1vSlypckAIFwVDWJY2ZEVRfX9PL0hDedCuAPm/ReJzRUmus7KS48p+lrp0rm2AIJOuF5cJbH5yTO4Nq6VwC1TextpG4hyKjctZxzPohfAunijNSnbuQdEYUbjpxKlyCnOZeVRjjwbHLXpd2XBXUw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(136003)(39860400002)(396003)(346002)(376002)(451199021)(46966006)(36840700001)(40470700004)(40460700003)(1076003)(26005)(83380400001)(47076005)(426003)(336012)(36756003)(36860700001)(40480700001)(2616005)(81166007)(86362001)(82310400005)(356005)(82740400003)(186003)(2906002)(54906003)(478600001)(5660300002)(4326008)(8676002)(8936002)(70206006)(70586007)(316002)(6666004)(7696005)(41300700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2023 10:30:51.2028
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b7a8141-e884-4498-5fad-08db55f89f1d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT115.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5104
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

Handle soundwire manager related interrupts in ACP PCI driver
interrupt handler and schedule soundwire manager work queue for
further processing.

Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
---
 sound/soc/amd/ps/acp63.h  |  4 ++++
 sound/soc/amd/ps/pci-ps.c | 42 ++++++++++++++++++++++++++++++++++-----
 2 files changed, 41 insertions(+), 5 deletions(-)

diff --git a/sound/soc/amd/ps/acp63.h b/sound/soc/amd/ps/acp63.h
index f27f71116598..faf7be4d77c2 100644
--- a/sound/soc/amd/ps/acp63.h
+++ b/sound/soc/amd/ps/acp63.h
@@ -67,6 +67,10 @@
 /* time in ms for acp timeout */
 #define ACP_TIMEOUT		500
 
+#define ACP_SDW0_IRQ_MASK		21
+#define ACP_SDW1_IRQ_MASK		2
+#define ACP_ERROR_IRQ_MASK		29
+
 enum acp_config {
 	ACP_CONFIG_0 = 0,
 	ACP_CONFIG_1,
diff --git a/sound/soc/amd/ps/pci-ps.c b/sound/soc/amd/ps/pci-ps.c
index f3aa08dc05b2..6566ee14d300 100644
--- a/sound/soc/amd/ps/pci-ps.c
+++ b/sound/soc/amd/ps/pci-ps.c
@@ -56,6 +56,7 @@ static int acp63_reset(void __iomem *acp_base)
 static void acp63_enable_interrupts(void __iomem *acp_base)
 {
 	writel(1, acp_base + ACP_EXTERNAL_INTR_ENB);
+	writel(BIT(ACP_ERROR_IRQ_MASK), acp_base + ACP_EXTERNAL_INTR_CNTL);
 }
 
 static void acp63_disable_interrupts(void __iomem *acp_base)
@@ -102,23 +103,54 @@ static irqreturn_t acp63_irq_handler(int irq, void *dev_id)
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
+	if (ext_intr_stat & BIT(ACP_SDW0_IRQ_MASK)) {
+		writel(BIT(ACP_SDW0_IRQ_MASK), adata->acp63_base + ACP_EXTERNAL_INTR_STAT);
+		pdev_index = adata->sdw0_dev_index;
+		amd_manager = dev_get_drvdata(&adata->pdev[pdev_index]->dev);
+		if (amd_manager)
+			schedule_work(&amd_manager->amd_sdw_irq_thread);
+		irq_flag = 1;
+	}
 
-	val = readl(adata->acp63_base + ACP_EXTERNAL_INTR_STAT);
-	if (val & BIT(PDM_DMA_STAT)) {
+	ext_intr_stat1 = readl(adata->acp63_base + ACP_EXTERNAL_INTR_STAT1);
+	if (ext_intr_stat1 & BIT(ACP_SDW1_IRQ_MASK)) {
+		writel(BIT(ACP_SDW1_IRQ_MASK), adata->acp63_base + ACP_EXTERNAL_INTR_STAT1);
+		pdev_index = adata->sdw1_dev_index;
+		amd_manager = dev_get_drvdata(&adata->pdev[pdev_index]->dev);
+		if (amd_manager)
+			schedule_work(&amd_manager->amd_sdw_irq_thread);
+		irq_flag = 1;
+	}
+
+	if (ext_intr_stat & BIT(ACP_ERROR_IRQ_MASK)) {
+		writel(BIT(ACP_ERROR_IRQ_MASK), adata->acp63_base + ACP_EXTERNAL_INTR_STAT);
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

