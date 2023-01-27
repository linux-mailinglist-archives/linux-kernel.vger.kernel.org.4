Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D678567EA51
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 17:03:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234710AbjA0QDY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 11:03:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234497AbjA0QC4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 11:02:56 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2045.outbound.protection.outlook.com [40.107.243.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 377CC88CDD
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 08:02:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XbrLjjJdhcoFIzPdQTWF853Z4zXQZPhgOLooMV/00aLvJcYg9s+dHp7cSSS4dPgO27BX7PNa/OM7/ENV2C/9TBdB4w1gKFYLu4NOvenIrOBRRRcJdl0skED02AbGndwToghfst+YdChOs0525TZ49rnNhrkF6gjG7DEE7yuAiHWGlMRkYFmmqynvW027XTw9t5zIFi+BlcfpXQkA/G5Tu7+eskCRT9mNNPOAbHF3uZKbJJaJyI12Py5sFdfHWv3b5DGswW5M44BfqMcDCN3tadVHwvuMNv7hR1l0OGqf1mXM8vzgRYAD/ZdJ/CBUtmlJCaBGqvIUFg1Lp6ZW8eOHgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AjWg9XdNTQmSTSdudgNpCMwzZTc0xdNddsChchAD1yQ=;
 b=g8GVT73AUtjWNRPKvX2//Ov3lYW3sCcl+FnfkZ1RsCZpgbNBwQUOo9XiWPsdYAWsrVWd2z6MwY4zxAQAbWpOOcIaNofMOetcmS3tiNQ1L35LjJFICnRm50+ikcFcxaS6Ftl9o3XQ46h3XXJf70H9PVbKPSW12j1W1ujhVr976C+Dgr+1TI3d1XNpPB/8o78K9ni7Idz6EJJa3ChFSJylgmkFwWWsf34KD9ZG5QMc4PHev+1JCD0ZmaBCzlfEp/TPiJV3xvdfgg+4nrz4tWCEh1C93TtG461otyoCSYDWHVd7BrCznDB0aVz++sAtZCLftbmeuauHfzbRdYf4CQdy0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AjWg9XdNTQmSTSdudgNpCMwzZTc0xdNddsChchAD1yQ=;
 b=WYv5cL2k0+W+dDxsr1O+n6C9MMivSAK4l4hjBEQsVlZlIYKiwTYljQMRT6BiFK0p/a+T/vTWBqgiCDOgwsRUs2RsaPDdL6kjYYjOIy0DlAnlvs1dxgw8M6XYbm4pdyfeN95wN0jWxVKpFXahElFRiSeoY3xMxDwRYry1n/qT4ag=
Received: from MW4PR03CA0174.namprd03.prod.outlook.com (2603:10b6:303:8d::29)
 by SA0PR12MB4432.namprd12.prod.outlook.com (2603:10b6:806:98::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.22; Fri, 27 Jan
 2023 16:02:19 +0000
Received: from CO1PEPF00001A5F.namprd05.prod.outlook.com
 (2603:10b6:303:8d:cafe::60) by MW4PR03CA0174.outlook.office365.com
 (2603:10b6:303:8d::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.25 via Frontend
 Transport; Fri, 27 Jan 2023 16:02:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF00001A5F.mail.protection.outlook.com (10.167.241.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6043.10 via Frontend Transport; Fri, 27 Jan 2023 16:02:18 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 27 Jan
 2023 10:02:16 -0600
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     Jaroslav Kysela <jkysela@redhat.com>,
        Mukunda Vijendar <Vijendar.Mukunda@amd.com>,
        Saba Kareem Syed <Syed.SabaKareem@amd.com>,
        <linux-kernel@vger.kernel.org>
CC:     Pananchikkal Renjith <Renjith.Pananchikkal@amd.com>,
        Mark Pearson <mpearson@lenovo.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        "Liam Girdwood" <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        "Jaroslav Kysela" <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        <alsa-devel@alsa-project.org>
Subject: [PATCH 6/6] ASoC: amd: ps: Add a module parameter to influence pdm_gain
Date:   Fri, 27 Jan 2023 10:01:33 -0600
Message-ID: <20230127160134.2658-7-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230127160134.2658-1-mario.limonciello@amd.com>
References: <20230127160134.2658-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF00001A5F:EE_|SA0PR12MB4432:EE_
X-MS-Office365-Filtering-Correlation-Id: 43709aa8-bafb-4966-61b2-08db007fddd2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sRsQ+LZWN8sD+NO0MEAxd70koH9IVlaK5PuoFYn08zcjBNjg/i4PcgZcSVCZFWtiMe4AalhJ+5OoGijKJD+OERSI8Pousa6ruKHNrXil80CyBKWhlHCaILBEOH8KCpNo0EGOsgqa0un9H3ExiDr2VfYME2iY4du0gZcNd3QQYdeUJHeyDG6eRzYWa9nEsV/7kkqFqWsYZEVl8eklqL+EyOEFNw2U2I8d/LBQOkt+iQ+rBMpbn2FlBHMU4UO164LTpIMLBNTNkLo/9oan/8WvzR1w1s+ARGLCasVLczvyUyfnoxa5pGQmpZJ1BTeEGlQuekMG6a9C+96w3y5n+sDvnCiGMhQt3z5n5ne1rY4WJ5EHPPvXvZBddzkWhd84vithoLW47A01f/w814w1I2VIjfoVz+90642tjjiT5JSwPHzUpjGTA4HVzy6kNfNjIZ1lAZOZyAI+cufUz2+HIsEgd6feDZaVj3Lvd3Pz1uc+zd7hm4Bk11y23TP8BVfA9mrvt9JLWD8pnCVPpaD7rO+FMcSPWXlFrQrk9qxIE3oIRl4tvxz+CwBAj5kHx1MdAArpok4Wc/hspDSPbIw3+d0E/T9sBQw7zqSiSdIkVumHFvRNWMNOQb5EN6c53NV1aujLXgbNzSWwCfpBlkTunrOJeFKmYQA5GtrnIdrb20Pj5sYhZJxeWIRCTYEVHVK5pPCqD7stulBVK5QAEXHlZRIGgiAo+kSviqOhiiVxgJtzzVw=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(346002)(376002)(136003)(396003)(451199018)(46966006)(36840700001)(40470700004)(47076005)(8676002)(36756003)(40460700003)(7696005)(54906003)(40480700001)(356005)(336012)(16526019)(110136005)(81166007)(36860700001)(26005)(2616005)(83380400001)(86362001)(82310400005)(426003)(186003)(44832011)(6666004)(478600001)(316002)(1076003)(70586007)(41300700001)(82740400003)(8936002)(70206006)(5660300002)(4326008)(2906002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2023 16:02:18.2955
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 43709aa8-bafb-4966-61b2-08db007fddd2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF00001A5F.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4432
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In case of regressions for any users that the new pdm_gain value is
too high and for additional debugging, introduce a module parameter
that would let them configure it.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 sound/soc/amd/ps/acp63.h      | 2 +-
 sound/soc/amd/ps/ps-pdm-dma.c | 7 ++++++-
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/sound/soc/amd/ps/acp63.h b/sound/soc/amd/ps/acp63.h
index bae8288d8231c..bed4d51e226a5 100644
--- a/sound/soc/amd/ps/acp63.h
+++ b/sound/soc/amd/ps/acp63.h
@@ -30,7 +30,7 @@
 #define ACP_ERROR_STAT	29
 #define PDM_DECIMATION_FACTOR	2
 #define ACP_PDM_CLK_FREQ_MASK	7
-#define ACP_WOV_MISC_CTRL_MASK	0x18
+#define ACP_WOV_GAIN_CONTROL	GENMASK(4, 3)
 #define ACP_PDM_ENABLE		1
 #define ACP_PDM_DISABLE		0
 #define ACP_PDM_DMA_EN_STATUS	2
diff --git a/sound/soc/amd/ps/ps-pdm-dma.c b/sound/soc/amd/ps/ps-pdm-dma.c
index eea71a9d2ef1a..1e773c5496c5f 100644
--- a/sound/soc/amd/ps/ps-pdm-dma.c
+++ b/sound/soc/amd/ps/ps-pdm-dma.c
@@ -7,6 +7,7 @@
 
 #include <linux/platform_device.h>
 #include <linux/module.h>
+#include <linux/bitfield.h>
 #include <linux/err.h>
 #include <linux/io.h>
 #include <sound/pcm_params.h>
@@ -18,6 +19,10 @@
 
 #define DRV_NAME "acp_ps_pdm_dma"
 
+static int pdm_gain = 3;
+module_param(pdm_gain, int, 0644);
+MODULE_PARM_DESC(pdm_gain, "Gain control (0-3)");
+
 static const struct snd_pcm_hardware acp63_pdm_hardware_capture = {
 	.info = SNDRV_PCM_INFO_INTERLEAVED |
 		SNDRV_PCM_INFO_BLOCK_TRANSFER |
@@ -55,7 +60,7 @@ static void acp63_enable_pdm_clock(void __iomem *acp_base)
 
 	acp63_writel(pdm_clk_enable, acp_base + ACP_WOV_CLK_CTRL);
 	pdm_ctrl = acp63_readl(acp_base + ACP_WOV_MISC_CTRL);
-	pdm_ctrl |= ACP_WOV_MISC_CTRL_MASK;
+	pdm_ctrl |= FIELD_PREP(ACP_WOV_GAIN_CONTROL, pdm_gain);
 	acp63_writel(pdm_ctrl, acp_base + ACP_WOV_MISC_CTRL);
 }
 
-- 
2.34.1

