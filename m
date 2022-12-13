Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A73864B042
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 08:16:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234637AbiLMHQp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 02:16:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233753AbiLMHQk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 02:16:40 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2058.outbound.protection.outlook.com [40.107.223.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23C9F16489
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 23:16:39 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BbKOaiZp1OHHYGDhwA8RvZNwi7WclsuS23BoZGgYQJ4uK8o8rXlL+9b8z4SQ7R1hLZVf+o9As9BVNEmnaRwnNpGruBEjTTXkehXFsnhJlylGcwOTHaSVEmeiZVr8g+MrOmPYA0O8yAvU5Wmm5sq+RegfH6ubxq1oZkZk3opZFtpIQiZ5zFZA+pnNY8W3UHjwPTD3gdx9ErTz16MRcA4ksGy7lt46ID4NCKuJpKJK15kr0d7WmNlhwowLk0fj/zZTDpehyZd/8k0wJIsxvAhQmG0BR06w5pnZ6oK1f7RmS08veLi12Ch5gVTmY97uH40WLRCEC0Aylx/9fkxNaVG9yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5UTrk22fcqRCRP2DO8efONbvSqECO9AEARhvPb2xNEE=;
 b=h8uBmO9PVmJkc0zGAa0Mm6Kg6FRKK4L6Kv1bm+ULypSRF3qrFpHlDZIw5onRk6p2v57rmlMjXfsHL3ccwYZxNMOSXB89fRZaiZxTUq4UM7HGvi6RWevQI0YdX0zVlOv3hh+2cfJEonHce2qMz+TC1PEXZNBG6yja9Q49HmHsaUnzNPOhYdWRPjm8nwJkAztPPfTa62jzUI4kEVlLcfveDLjh6GBpBfZA79+T2IMddSwNGD7YN4651P5TTWNoftO7zODU3F/8AdTt9F9FSEEe5MFNdq9tTO5VBoL18a6mwaCwmswSNVUhPMLI9GGvMAvdPdymqUoflsAK4ID/bgfUOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5UTrk22fcqRCRP2DO8efONbvSqECO9AEARhvPb2xNEE=;
 b=vlHz6tGFgfyLJxeL1shQyUBNspFr5Vy+/vGck6p85PGN39Qjems6AyxcUf//o6Jb4CH0hjMb2AK2tHJIL7fglMrMeL9qrIS+iWPBQUZcAGB6Ea+Dm2NIuOG5xn9RnUtTlZBLSp5AUU7z9dNVmDEMFLjh+b27mIUeOm7gAsK0SXE=
Received: from BLAPR05CA0008.namprd05.prod.outlook.com (2603:10b6:208:36e::11)
 by IA1PR12MB7759.namprd12.prod.outlook.com (2603:10b6:208:420::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.19; Tue, 13 Dec
 2022 07:16:37 +0000
Received: from BL02EPF0000C409.namprd05.prod.outlook.com
 (2603:10b6:208:36e:cafe::cf) by BLAPR05CA0008.outlook.office365.com
 (2603:10b6:208:36e::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.6 via Frontend
 Transport; Tue, 13 Dec 2022 07:16:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BL02EPF0000C409.mail.protection.outlook.com (10.167.241.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5924.9 via Frontend Transport; Tue, 13 Dec 2022 07:16:36 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 13 Dec
 2022 01:16:36 -0600
Received: from sof-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.34
 via Frontend Transport; Tue, 13 Dec 2022 01:16:30 -0600
From:   V sujith kumar Reddy <Vsujithkumar.Reddy@amd.com>
To:     <broonie@kernel.org>, <alsa-devel@alsa-project.org>
CC:     <Vijendar.Mukunda@amd.com>, <Basavaraj.Hiregoudar@amd.com>,
        <Sunil-kumar.Dommati@amd.com>, <venkataprasad.potturu@amd.com>,
        <ssabakar@amd.com>,
        V sujith kumar Reddy <Vsujithkumar.Reddy@amd.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
        "Bard Liao" <yung-chuan.liao@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        "Ajit Kumar Pandey" <AjitKumar.Pandey@amd.com>,
        "moderated list:SOUND - SOUND OPEN FIRMWARE (SOF) DRIVERS" 
        <sound-open-firmware@alsa-project.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH] ASoC: SOF: amd: Enable cache for AMD Rembrandt platform
Date:   Tue, 13 Dec 2022 12:46:37 +0530
Message-ID: <20221213071640.3038853-1-Vsujithkumar.Reddy@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0000C409:EE_|IA1PR12MB7759:EE_
X-MS-Office365-Filtering-Correlation-Id: 1cab2fce-c168-4378-2cc1-08dadcd9f8fb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Xv3DS4qcS7XsAwOKrCgMrpKUqSCU/YGUEr3Lhvpz7iHVGHdEkUCbOdHe8bZ0sZ0khuC2WAai3CI0WDk9VKqzo8LbYx20dtOAZ/VlLy+GkCBk2oZyyk0wnk37nFpkzRTbKd9cF4+QpaGW1RRbqUzTaRbSeDuG2Wxrj/lD9LQnwU3pSHZQ+rPhUuPyHc1fc5mO7opIY0KHU5br48G9rFnuM173oa/+PcAFD6sY0ajZJ9AVlAki5QgI+n47VcHnXdR/tL4Vu/JGEqZTa4coKNLMp9eq1KB3IJwut6B148X+E2V+6aj24urwUy9Mxu4F+7TyxsI9vuf+ZGRCg4yFBxsH4Gc2AExab2asCRUFQO4I3RRZ/8rF5cuMdIgXZ9VfE39ZW6TQa0s9+hFLi+i33RrRpaZTN0tpjn93Z7ZMWzEerTnqi/4qbmiqjfEKJ2DMqwl4bYPHgSBj2TAzbjD4TGdFReVdbKp+J34vm1jd3MUe81BTrtkdlzmbsKKQcacFJbN1Wq0/o2EJouTBs+fXWaUHQUyU96SE7+ckAf8aaPvCav+MXFSd4F3sggf4OsgTrQcews8UwheMAngFSAYtQO3tPN//CyeLcJbniM/cmdArZrYVL6bXvm1rmI74dGYFPQnLDUyFpWo9gsrYztylE4S8xa0Zn+jdmZKT38uWImG7pDMNqMtM1igW97F5trCo/n6TbMiXWuGNp4bEvoSh77a3Eb2SzTj1FIBFVLegjzgPjio=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:CA;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(376002)(136003)(39860400002)(346002)(396003)(451199015)(40470700004)(36840700001)(46966006)(186003)(81166007)(8936002)(478600001)(26005)(82740400003)(83380400001)(70206006)(70586007)(356005)(36756003)(86362001)(4326008)(40460700003)(47076005)(2616005)(426003)(7696005)(41300700001)(1076003)(82310400005)(336012)(5660300002)(7416002)(110136005)(54906003)(2906002)(36860700001)(40480700001)(8676002)(316002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2022 07:16:36.9102
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1cab2fce-c168-4378-2cc1-08dadcd9f8fb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0000C409.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7759
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable DSP cache for ACP memory

Signed-off-by: V sujith kumar Reddy <Vsujithkumar.Reddy@amd.com>
---
 sound/soc/sof/amd/acp-dsp-offset.h | 4 ++++
 sound/soc/sof/amd/acp-loader.c     | 7 +++++++
 sound/soc/sof/amd/acp.h            | 2 ++
 3 files changed, 13 insertions(+)

diff --git a/sound/soc/sof/amd/acp-dsp-offset.h b/sound/soc/sof/amd/acp-dsp-offset.h
index de5726251dc6..920155dee819 100644
--- a/sound/soc/sof/amd/acp-dsp-offset.h
+++ b/sound/soc/sof/amd/acp-dsp-offset.h
@@ -85,4 +85,8 @@
 
 #define ACP_SCRATCH_REG_0			0x10000
 #define ACP6X_DSP_FUSION_RUNSTALL		0x0644
+
+/* Cache window registers */
+#define ACP_DSP0_CACHE_OFFSET0			0x0420
+#define ACP_DSP0_CACHE_SIZE0			0x0424
 #endif
diff --git a/sound/soc/sof/amd/acp-loader.c b/sound/soc/sof/amd/acp-loader.c
index 090c8b18c83c..a4bce5a3ae48 100644
--- a/sound/soc/sof/amd/acp-loader.c
+++ b/sound/soc/sof/amd/acp-loader.c
@@ -151,6 +151,7 @@ static void configure_pte_for_fw_loading(int type, int num_pages, struct acp_dev
 int acp_dsp_pre_fw_run(struct snd_sof_dev *sdev)
 {
 	struct pci_dev *pci = to_pci_dev(sdev->dev);
+	const struct sof_amd_acp_desc *desc = get_chip_info(sdev->pdata);
 	struct acp_dev_data *adata;
 	unsigned int src_addr, size_fw;
 	u32 page_count, dma_size;
@@ -183,6 +184,12 @@ int acp_dsp_pre_fw_run(struct snd_sof_dev *sdev)
 	if (ret < 0)
 		dev_err(sdev->dev, "acp dma transfer status: %d\n", ret);
 
+	if (desc->rev > 3) {
+		/* Cache Window enable */
+		snd_sof_dsp_write(sdev, ACP_DSP_BAR, ACP_DSP0_CACHE_OFFSET0, desc->sram_pte_offset);
+		snd_sof_dsp_write(sdev, ACP_DSP_BAR, ACP_DSP0_CACHE_SIZE0, SRAM1_SIZE | BIT(31));
+	}
+
 	/* Free memory once DMA is complete */
 	dma_size =  (PAGE_ALIGN(sdev->basefw.fw->size) >> PAGE_SHIFT) * ACP_PAGE_SIZE;
 	dma_free_coherent(&pci->dev, dma_size, adata->bin_buf, adata->sha_dma_addr);
diff --git a/sound/soc/sof/amd/acp.h b/sound/soc/sof/amd/acp.h
index 09e16ef8afa0..4314094a97fd 100644
--- a/sound/soc/sof/amd/acp.h
+++ b/sound/soc/sof/amd/acp.h
@@ -72,6 +72,8 @@
 #define EXCEPT_MAX_HDR_SIZE			0x400
 #define AMD_STACK_DUMP_SIZE			32
 
+#define SRAM1_SIZE				0x13A000
+
 enum clock_source {
 	ACP_CLOCK_96M = 0,
 	ACP_CLOCK_48M,
-- 
2.25.1

