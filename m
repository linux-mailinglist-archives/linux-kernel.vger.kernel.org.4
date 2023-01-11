Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4E896656D2
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 10:04:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237809AbjAKJDx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 04:03:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238264AbjAKJDU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 04:03:20 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2071.outbound.protection.outlook.com [40.107.92.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B242113FA1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 01:02:05 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ekEYr70zHq8sKbnrnH7bRMypdXx2+4vsw0+SeR8Jz2afGGM1fxrU6vEonY9wCgfDVTO0RSEoX8AKTpMMD26PWgnAuV0PpwVcdbcIJ2MrsI1oR/37lZT/OyuzXgRcYTmZ6pmvxayhEMSBPzP7CQ3hnCrnNUjUOuCH+wR3pWa/Jw7eEXb3ZaOtQ04g97Djba5MXBbfo29bvf+sv2wCU8qERVX+Ul1Ik1DJV1JPUzSEFTwBSokJM7tzZ77gmMNsJC8//I292bMQjo1MkGBl2ZOAppwoVBTmEMJXYZdWkGg4j5+1YcwrwUjAd7mTc3AUqkDdBR1Z42OcZvPGd606kxpW+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ae4ehQKMdSLn9XALRAPMG46D6I8GsK7uzgwpr42I1x0=;
 b=eY5XH283SDUiE6/8b9MzlVEs6VB1YC33kqxJG+suADUXjp/mLJz3HOPiwolqjG3xuAkGW5IRSgvgEiV+G6BkXAcJcEtijDlblYPPnsAka1pAs4wKJDPjP/PBaiNk/KukvC8CdPHWBn8L9FN8BK5Y3kVqZKIbQUmKhRNUy30A+Bk2mcbhQ+PeWUnP+BgrkSGYvoM2/PHUoXaGrDKDYPIHtpqtoPBTvXUlSu9LWZRGsyqtJlo0rGrz+vD8+zTZf0W9p/RLF+86ATuIu+tza8S06cQbpb2dnIekVcEc1FegdU30I/rmbeP0bW7GibtEhVMUzB6v693AJWEROCv/i5E3jA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ae4ehQKMdSLn9XALRAPMG46D6I8GsK7uzgwpr42I1x0=;
 b=gZXW9xAaJWIMsH9v/XPwRuKk+Hd8sA3mHu5lUH9uJTFXw2fhOd7CEwZT23DndftUuCspHwZsmhHNdwi1avcoWCUj+5mIRL5Jnrqjk7U9vDIvtdiPQKvA9GaNGbkXwFFScHo0j01ZGDBjKgcKGWAAQUEaU+OoLJ8ci5kj5wa/Bpk=
Received: from BN0PR07CA0023.namprd07.prod.outlook.com (2603:10b6:408:141::6)
 by PH7PR12MB6719.namprd12.prod.outlook.com (2603:10b6:510:1b2::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Wed, 11 Jan
 2023 09:02:01 +0000
Received: from BN8NAM11FT085.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:141:cafe::90) by BN0PR07CA0023.outlook.office365.com
 (2603:10b6:408:141::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.13 via Frontend
 Transport; Wed, 11 Jan 2023 09:02:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT085.mail.protection.outlook.com (10.13.176.100) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6002.13 via Frontend Transport; Wed, 11 Jan 2023 09:02:01 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 11 Jan
 2023 03:01:09 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 11 Jan
 2023 01:00:45 -0800
Received: from vijendar-X570-GAMING-X.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.34
 via Frontend Transport; Wed, 11 Jan 2023 03:00:41 -0600
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
Subject: [PATCH 09/19] ASoC: amd: ps: add support for Soundwire DMA interrupts
Date:   Wed, 11 Jan 2023 14:32:12 +0530
Message-ID: <20230111090222.2016499-10-Vijendar.Mukunda@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230111090222.2016499-1-Vijendar.Mukunda@amd.com>
References: <20230111090222.2016499-1-Vijendar.Mukunda@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT085:EE_|PH7PR12MB6719:EE_
X-MS-Office365-Filtering-Correlation-Id: 8129a384-f5f3-4d7d-ffbf-08daf3b2806c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4+cqvRGL49pGSA566TYlCOvlGoLjrnO/rGiDPvMhgaB2Xex93d7zNTmSlyWiyQ453W4WG3emLwDirR21mx0k19Y3871N0T5dgosBakbO+q2GsfaphKhLhkpy0Hj880of4nhP3TTNfKrEB6mn0j8LqwmyK/Rg21vaQ3ii3VleE3Py6QE53OeqxEfwGFuWFhtGJlduuPWlFLxxDLSskdk5iRJ+ARrY7f59XMvkSWi9mLva9p8pYAC6XCXeHMT4KuWI2Wg12VEpxuBlUmWvX+cLxcUV7VB6HEN/qQ7/x9UEE1KrD8aYWq2Zuigd60YEdsIRpSi6U7gh4lsdObOfRc1fcLmbESkFbgL2JXCLSnOVuntz1o/5iuXklW6ZCOAgJpQir7IKsY2lGIeKaFoqav4Lt62TuRS3tE0lLYgf2yl6GPv/hrIWuFc7hmNoginem9uY1IJB5BhjdAWt7VNakM2LSYj5mUKswClA/mYOGfoEjdAIMpb448qFGfIQ4a9ez3hjnXd/scemOiBbvJq5rx85CZMQLRogSC9bZO9ztpwAvxI5m396xQHJbs4Vg9LdBJfo+W8qfmTKMFy5rB+TcHE35HnkB17h84guycIDLupVNZMRq0QNtp3jWl5Vmc7q+GpYsQhx0+XQXXR1uWGOBam7Iisg+yRePKevC6zNyG2heE3Nls0RooRYEqbOnKVq4Yt0uB4pmLoPIPB3CmusFZ/GXV6wqEMRHNzat797ObeqDac=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(136003)(346002)(39860400002)(376002)(396003)(451199015)(36840700001)(40470700004)(46966006)(82310400005)(2906002)(36756003)(5660300002)(8936002)(70206006)(6666004)(8676002)(41300700001)(2616005)(70586007)(316002)(7696005)(4326008)(54906003)(110136005)(478600001)(40480700001)(26005)(186003)(336012)(1076003)(426003)(86362001)(47076005)(83380400001)(36860700001)(40460700003)(356005)(81166007)(82740400003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2023 09:02:01.0389
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8129a384-f5f3-4d7d-ffbf-08daf3b2806c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT085.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6719
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Initialize workqueue for DMA interrupts handling.
Whenever audio data equal to the Soundwire FIFO watermark level are
produced/consumed, interrupt is generated.
Acknowledge the interrupt and schedule the workqueue.

Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
---
 sound/soc/amd/ps/acp63.h  |  2 +
 sound/soc/amd/ps/pci-ps.c | 81 ++++++++++++++++++++++++++++++++++++++-
 2 files changed, 82 insertions(+), 1 deletion(-)

diff --git a/sound/soc/amd/ps/acp63.h b/sound/soc/amd/ps/acp63.h
index 8963cfb6120d..833d0b5aa73d 100644
--- a/sound/soc/amd/ps/acp63.h
+++ b/sound/soc/amd/ps/acp63.h
@@ -167,9 +167,11 @@ struct acp63_dev_data {
 	struct platform_device *pdev[ACP63_DEVS];
 	struct mutex acp_lock; /* protect shared registers */
 	struct fwnode_handle *sdw_fw_node;
+	struct work_struct acp_sdw_dma_work;
 	u16 pdev_mask;
 	u16 pdev_count;
 	u16 pdm_dev_index;
+	u16 dma_intr_stat[ACP63_SDW_MAX_STREAMS];
 	u8 sdw_master_count;
 	u16 sdw0_dev_index;
 	u16 sdw1_dev_index;
diff --git a/sound/soc/amd/ps/pci-ps.c b/sound/soc/amd/ps/pci-ps.c
index 0fbe5e27f3fb..5b82ee8e3ad8 100644
--- a/sound/soc/amd/ps/pci-ps.c
+++ b/sound/soc/amd/ps/pci-ps.c
@@ -113,14 +113,37 @@ static int acp63_deinit(void __iomem *acp_base, struct device *dev)
 	return 0;
 }
 
+static void acp63_sdw_dma_workthread(struct work_struct *work)
+{
+	struct acp63_dev_data *adata = container_of(work, struct acp63_dev_data,
+						    acp_sdw_dma_work);
+	struct sdw_dma_dev_data *sdw_dma_data;
+	u32 stream_index;
+	u16 pdev_index;
+
+	pdev_index = adata->sdw_dma_dev_index;
+	sdw_dma_data = dev_get_drvdata(&adata->pdev[pdev_index]->dev);
+
+	for (stream_index = 0; stream_index < ACP63_SDW_MAX_STREAMS; stream_index++) {
+		if (adata->dma_intr_stat[stream_index]) {
+			if (sdw_dma_data->sdw_stream[stream_index])
+				snd_pcm_period_elapsed(sdw_dma_data->sdw_stream[stream_index]);
+			adata->dma_intr_stat[stream_index] = 0;
+		}
+	}
+}
+
 static irqreturn_t acp63_irq_handler(int irq, void *dev_id)
 {
 	struct acp63_dev_data *adata;
 	struct pdm_dev_data *ps_pdm_data;
 	struct amd_sdwc_ctrl *ctrl;
 	u32 ext_intr_stat, ext_intr_stat1;
+	u32 stream_id = 0;
 	u16 irq_flag = 0;
+	u16 sdw_dma_irq_flag = 0;
 	u16 pdev_index;
+	u16 index;
 
 	adata = dev_id;
 	if (!adata)
@@ -159,7 +182,58 @@ static irqreturn_t acp63_irq_handler(int irq, void *dev_id)
 			snd_pcm_period_elapsed(ps_pdm_data->capture_stream);
 		irq_flag = 1;
 	}
-	if (irq_flag)
+	if (ext_intr_stat & ACP_SDW_DMA_IRQ_MASK) {
+		for (index = ACP_HS_RX_THRESHOLD; index <= ACP_AUDIO_TX_THRESHOLD; index++) {
+			if (ext_intr_stat & BIT(index)) {
+				acp63_writel(BIT(index),
+					     adata->acp63_base + ACP_EXTERNAL_INTR_STAT);
+				switch (index) {
+				case ACP_AUDIO_TX_THRESHOLD:
+					stream_id = ACP_SDW_AUDIO_TX;
+					break;
+				case ACP_BT_TX_THRESHOLD:
+					stream_id = ACP_SDW_BT_TX;
+					break;
+				case ACP_HS_TX_THRESHOLD:
+					stream_id = ACP_SDW_HS_TX;
+					break;
+				case ACP_AUDIO_RX_THRESHOLD:
+					stream_id = ACP_SDW_AUDIO_RX;
+					break;
+				case ACP_BT_RX_THRESHOLD:
+					stream_id = ACP_SDW_BT_RX;
+					break;
+				case ACP_HS_RX_THRESHOLD:
+					stream_id = ACP_SDW_HS_RX;
+					break;
+				}
+
+				adata->dma_intr_stat[stream_id] = 1;
+				sdw_dma_irq_flag = 1;
+			}
+		}
+	}
+
+	/* SDW1 BT RX */
+	if (ext_intr_stat1 & BIT(ACP_P1_BT_RX_THRESHOLD)) {
+		acp63_writel(BIT(ACP_P1_BT_RX_THRESHOLD),
+			     adata->acp63_base + ACP_EXTERNAL_INTR_STAT1);
+		adata->dma_intr_stat[ACP_SDW1_BT_RX] = 1;
+		sdw_dma_irq_flag = 1;
+	}
+
+	/* SDW1 BT TX*/
+	if (ext_intr_stat1 & BIT(ACP_P1_BT_TX_THRESHOLD)) {
+		acp63_writel(BIT(ACP_P1_BT_TX_THRESHOLD),
+			     adata->acp63_base + ACP_EXTERNAL_INTR_STAT1);
+		adata->dma_intr_stat[ACP_SDW1_BT_TX] = 1;
+		sdw_dma_irq_flag = 1;
+	}
+
+	if (sdw_dma_irq_flag)
+		schedule_work(&adata->acp_sdw_dma_work);
+
+	if (irq_flag || sdw_dma_irq_flag)
 		return IRQ_HANDLED;
 	else
 		return IRQ_NONE;
@@ -240,6 +314,7 @@ static int get_acp63_device_config(u32 config, struct pci_dev *pci, struct acp63
 	if (sdw_dev) {
 		is_sdw_dev = true;
 		acp_data->sdw_fw_node = acpi_fwnode_handle(sdw_dev);
+		INIT_WORK(&acp_data->acp_sdw_dma_work, acp63_sdw_dma_workthread);
 		ret = sdw_amd_scan_controller(dev);
 		if (ret)
 			return ret;
@@ -612,6 +687,10 @@ static void snd_acp63_remove(struct pci_dev *pci)
 	int ret, index;
 
 	adata = pci_get_drvdata(pci);
+
+	if (adata->pdev_mask & ACP63_SDW_DEV_MASK)
+		cancel_work_sync(&adata->acp_sdw_dma_work);
+
 	for (index = 0; index < adata->pdev_count; index++)
 		platform_device_unregister(adata->pdev[index]);
 	ret = acp63_deinit(adata->acp63_base, &pci->dev);
-- 
2.34.1

