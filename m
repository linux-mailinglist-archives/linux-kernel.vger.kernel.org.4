Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E0A563BD71
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 11:01:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232051AbiK2KBS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 05:01:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229630AbiK2KBO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 05:01:14 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2065.outbound.protection.outlook.com [40.107.244.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66E5F165B5
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 02:01:13 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=StWipuOsZ0qAgyGSWfQzz+hCPgmeHGflcfmsVk2Q3DhHLWsruuDT63NFO86beGCSFCr10cAQ/D4CN1fPsD/lTRHVEXF9GVjPzHqiNEy2+jmN7BN6x/UsjcvHNm+bM7UguDSFfYf4agWx2ragvOnotnn19vpfa5gQu+pvtDTqKXOp9UcusGsHZ3ogyJ+zkdFiYX5RWpptS+2dTmm9oDvwM1VpaIIWPwoSD6utvV3z9J9L4vG3eu8VqeXE7PB0wSIhn/GsJ7iciYGE2cH8S8+xIf1+oHNgMg4e0/CxzzdaXGVwLSP1KwJEdXuUtL7BcFFV7SXVrE+WVV7KkQgOR03GzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/QT9zcfydyYsahX8yopwy9T44k/KOJPjfDNl7iTN7T4=;
 b=ERcpwcfQ0d2J3/6J2KkTs5Ubi3nkCmNzx+SUvGbcpJ2vyNmVFGZIEaJjfAuVH24vWG5JAlVQ1FiSG2IieGkFnfaNrOiL+vQEASAyX5wXWNujSAwSB2xPyvwBbt8LVXIoTp/nbGk47NODsqx90PtD7fNSfTwgB/w4pTwCtYOZbu5pqM+tbf5RWe67HOanGuvPCGHVSzc20mPucibtmfVHVO1soR+7yuANlW3rkZT7H/o4Tazsp+9UTxiwm+8LMc0EFMxqgBi9GrSQ1EwVCY9elwk5UxdCzTBtowG3tz+9XSZxhhms8JjWtA3QutCpEm0obyasP9V9hUUFG5344o0I4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 165.204.84.17) smtp.rcpttodomain=kernel.org
 smtp.mailfrom=amd.corp-partner.google.com; dmarc=fail (p=reject sp=reject
 pct=100) action=oreject header.from=amd.corp-partner.google.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/QT9zcfydyYsahX8yopwy9T44k/KOJPjfDNl7iTN7T4=;
 b=uqBmUXGIMvcoU/zlvQ+WBb8SZamyOcJwxnss1ItKGkiZXiEu5pQnkUFDxt3VA6cMJQfjCmQg5Gsn6xI61nW3qEaL4h8TTJhVrsi+dSh/3dBXtNlJV+AAKHEZv/rll20uOWGRWcHqYYpRoM0P+zSyu5aGi/zHofm5IR9Jh+B1ULrJvzNCXTKaTbA4OS52Nxptwe7WOiocfptMQ3x7x/2UOmbBP5PqQXyQuCXCObP9yaldcehZPWuE4AN5+Io2cQPc/vBPWnjFmKSJjeen2EhLRvu8aB4JzKWxBFYctiGLov+t+GhBRu12fmQYXddPfJ2DFGdWjTcL1udCaAYLLVgQ1Q==
Received: from DM6PR04CA0029.namprd04.prod.outlook.com (2603:10b6:5:334::34)
 by LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.23; Tue, 29 Nov
 2022 10:01:00 +0000
Received: from DM6NAM11FT093.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:334:cafe::c2) by DM6PR04CA0029.outlook.office365.com
 (2603:10b6:5:334::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.23 via Frontend
 Transport; Tue, 29 Nov 2022 10:01:00 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 165.204.84.17) smtp.mailfrom=amd.corp-partner.google.com; dkim=none (message
 not signed) header.d=none;dmarc=fail action=oreject
 header.from=amd.corp-partner.google.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 amd.corp-partner.google.com discourages use of 165.204.84.17 as permitted
 sender)
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT093.mail.protection.outlook.com (10.13.172.235) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5857.18 via Frontend Transport; Tue, 29 Nov 2022 10:01:00 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 29 Nov
 2022 04:00:59 -0600
Received: from sof-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.34
 via Frontend Transport; Tue, 29 Nov 2022 04:00:53 -0600
From:   V sujith kumar Reddy 
        <vsujithkumar.reddy@amd.corp-partner.google.com>
To:     <broonie@kernel.org>, <alsa-devel@alsa-project.org>
CC:     <Vijendar.Mukunda@amd.com>, <Basavaraj.Hiregoudar@amd.com>,
        <Sunil-kumar.Dommati@amd.com>, <venkataprasad.potturu@amd.com>,
        <ssabakar@amd.com>,
        V sujith kumar Reddy <Vsujithkumar.Reddy@amd.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        "Pierre-Louis Bossart" <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
        "Bard Liao" <yung-chuan.liao@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        "Ajit Kumar Pandey" <AjitKumar.Pandey@amd.com>,
        Rander Wang <rander.wang@intel.com>,
        Chao Song <chao.song@linux.intel.com>,
        open list <linux-kernel@vger.kernel.org>,
        "moderated list:SOUND - SOUND OPEN FIRMWARE (SOF) DRIVERS" 
        <sound-open-firmware@alsa-project.org>
Subject: [PATCH v2 1/1] ASoC: SOF: Add DAI configuration support for AMD platforms.
Date:   Tue, 29 Nov 2022 15:30:59 +0530
Message-ID: <20221129100102.826781-1-vsujithkumar.reddy@amd.corp-partner.google.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT093:EE_|LV2PR12MB5869:EE_
X-MS-Office365-Filtering-Correlation-Id: bcd2f180-bbb0-46af-6b08-08dad1f09e1e
X-MS-Exchange-SenderADCheck: 2
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dkw5N3/GVt+fH3fy9+ix4hcm/PlpXRvzWSXiG+njK6Tnq5hcE+6fd2DsqruOlT5omOiZ4aHW/U9/HjyIWw9viUvMYTyjYKpw+gg326XXo+xQ9yHByI7nxg22Wf6E+UGHBNCKw+Hm/rMzDkKkz0lvbIJu+mmqjj17u+G5IfPU09OwHsmhknUhYfsPyLfXmdeBgpNPlD9qLo0rqPqNtO3Bpnz+vLf3x3yT6b7WdHK+wkgDqpPpaNS4Nkf5eSHgaIRS8UBmktwKA5Blg7H5TQURa57Ic1HSAHvSuVQmj7n4G6QUol+sulOwf8jdX3/VqNTMp0FDMkwG/k68z1xJiIK6NRtRk9c/vMqEF9upL8m2+EKhp3U3fPcdUHxnnyk9n3pqw8AbBWw6tqHzH9IumOCmQ2e/dyqubTTejdRQkhZBHtSPogZOctfIoYy8JeVLgNRFq/ci1bfeBzyVFY69yDhfCwCh+MYl7af7QyjmQqazhXWkYfvg2AlK7a8fZ3kBBsKJtYpk3xn2/oR0g4cNzgpNYNAyAivfgXuu22TXkNLysx12nlRv8IRPjgs9rAXqbmD0+7Q+IB/0Cbw8xND7DIWtDNyBHqiKoXN6Oylc/mvfM7o4mvmiIK6shD/ufuqoAB+5u0JPDHo2XzFkDpMfzqIDgm8DaEYxeiNmUix0opRhcOcjBZJ/LzeG/L27Aijc5f5ZORa+mfV54HylUCV9sVdccA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(396003)(136003)(346002)(376002)(39860400002)(451199015)(40470700004)(46966006)(7416002)(8936002)(2906002)(40480700001)(35950700001)(40460700003)(86362001)(82740400003)(81166007)(356005)(1076003)(2616005)(498600001)(336012)(82310400005)(70206006)(70586007)(5660300002)(54906003)(316002)(76482006)(83380400001)(41300700001)(4326008)(47076005)(110136005)(8676002)(26005);DIR:OUT;SFP:1101;
X-OriginatorOrg: amdcloud.onmicrosoft.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2022 10:01:00.0715
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bcd2f180-bbb0-46af-6b08-08dad1f09e1e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT093.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5869
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: V sujith kumar Reddy <Vsujithkumar.Reddy@amd.com>

Add support for configuring sp and hs DAI from topology.

Signed-off-by: V sujith kumar Reddy <Vsujithkumar.Reddy@amd.com>

Changes since v1
    -- Apply on latest broonie-git for-next

---
 include/sound/sof/dai-amd.h     |  1 +
 include/sound/sof/dai.h         |  2 ++
 include/uapi/sound/sof/tokens.h |  5 +++++
 sound/soc/sof/ipc3-pcm.c        |  2 ++
 sound/soc/sof/ipc3-topology.c   | 36 +++++++++++++++++++++++++--------
 sound/soc/sof/sof-audio.h       |  1 +
 sound/soc/sof/topology.c        | 10 +++++++++
 7 files changed, 49 insertions(+), 8 deletions(-)

diff --git a/include/sound/sof/dai-amd.h b/include/sound/sof/dai-amd.h
index 92f45c180b7c..9df7ac824efe 100644
--- a/include/sound/sof/dai-amd.h
+++ b/include/sound/sof/dai-amd.h
@@ -17,6 +17,7 @@ struct sof_ipc_dai_acp_params {
 
 	uint32_t fsync_rate;    /* FSYNC frequency in Hz */
 	uint32_t tdm_slots;
+	uint32_t tdm_mode;
 } __packed;
 
 /* ACPDMIC Configuration Request - SOF_IPC_DAI_AMD_CONFIG */
diff --git a/include/sound/sof/dai.h b/include/sound/sof/dai.h
index 9fbd3832bcdc..3041f5805b7b 100644
--- a/include/sound/sof/dai.h
+++ b/include/sound/sof/dai.h
@@ -86,6 +86,8 @@ enum sof_ipc_dai_type {
 	SOF_DAI_AMD_DMIC,		/**< AMD ACP DMIC */
 	SOF_DAI_MEDIATEK_AFE,		/**< Mediatek AFE */
 	SOF_DAI_AMD_HS,			/**< Amd HS */
+	SOF_DAI_AMD_SP_VIRTUAL,		/**< AMD ACP SP VIRTUAL */
+	SOF_DAI_AMD_HS_VIRTUAL,		/**< AMD ACP HS VIRTUAL */
 };
 
 /* general purpose DAI configuration */
diff --git a/include/uapi/sound/sof/tokens.h b/include/uapi/sound/sof/tokens.h
index f187dfbd9325..bacaf8a6317e 100644
--- a/include/uapi/sound/sof/tokens.h
+++ b/include/uapi/sound/sof/tokens.h
@@ -198,4 +198,9 @@
 /* COPIER */
 #define SOF_TKN_INTEL_COPIER_NODE_TYPE		1980
 
+/* ACP I2S */
+#define SOF_TKN_AMD_ACPI2S_RATE			1700
+#define SOF_TKN_AMD_ACPI2S_CH			1701
+#define SOF_TKN_AMD_ACPI2S_TDM_MODE		1702
+
 #endif
diff --git a/sound/soc/sof/ipc3-pcm.c b/sound/soc/sof/ipc3-pcm.c
index dad57bef38f6..f10bfc9bd5cb 100644
--- a/sound/soc/sof/ipc3-pcm.c
+++ b/sound/soc/sof/ipc3-pcm.c
@@ -336,6 +336,7 @@ static int sof_ipc3_pcm_dai_link_fixup(struct snd_soc_pcm_runtime *rtd,
 			channels->min, channels->max);
 		break;
 	case SOF_DAI_AMD_SP:
+	case SOF_DAI_AMD_SP_VIRTUAL:
 		rate->min = private->dai_config->acpsp.fsync_rate;
 		rate->max = private->dai_config->acpsp.fsync_rate;
 		channels->min = private->dai_config->acpsp.tdm_slots;
@@ -347,6 +348,7 @@ static int sof_ipc3_pcm_dai_link_fixup(struct snd_soc_pcm_runtime *rtd,
 			channels->min, channels->max);
 		break;
 	case SOF_DAI_AMD_HS:
+	case SOF_DAI_AMD_HS_VIRTUAL:
 		rate->min = private->dai_config->acphs.fsync_rate;
 		rate->max = private->dai_config->acphs.fsync_rate;
 		channels->min = private->dai_config->acphs.tdm_slots;
diff --git a/sound/soc/sof/ipc3-topology.c b/sound/soc/sof/ipc3-topology.c
index 0720e1eae084..b94cc40485ed 100644
--- a/sound/soc/sof/ipc3-topology.c
+++ b/sound/soc/sof/ipc3-topology.c
@@ -276,6 +276,16 @@ static const struct sof_topology_token acpdmic_tokens[] = {
 		offsetof(struct sof_ipc_dai_acpdmic_params, pdm_ch)},
 };
 
+/* ACPI2S */
+static const struct sof_topology_token acpi2s_tokens[] = {
+	{SOF_TKN_AMD_ACPI2S_RATE, SND_SOC_TPLG_TUPLE_TYPE_WORD, get_token_u32,
+		offsetof(struct sof_ipc_dai_acp_params, fsync_rate)},
+	{SOF_TKN_AMD_ACPI2S_CH, SND_SOC_TPLG_TUPLE_TYPE_WORD, get_token_u32,
+		offsetof(struct sof_ipc_dai_acp_params, tdm_slots)},
+	{SOF_TKN_AMD_ACPI2S_TDM_MODE, SND_SOC_TPLG_TUPLE_TYPE_WORD, get_token_u32,
+		offsetof(struct sof_ipc_dai_acp_params, tdm_mode)},
+};
+
 /* Core tokens */
 static const struct sof_topology_token core_tokens[] = {
 	{SOF_TKN_COMP_CORE_ID, SND_SOC_TPLG_TUPLE_TYPE_WORD, get_token_u32,
@@ -311,6 +321,7 @@ static const struct sof_token_info ipc3_token_list[SOF_TOKEN_COUNT] = {
 	[SOF_SAI_TOKENS] = {"SAI tokens", sai_tokens, ARRAY_SIZE(sai_tokens)},
 	[SOF_AFE_TOKENS] = {"AFE tokens", afe_tokens, ARRAY_SIZE(afe_tokens)},
 	[SOF_ACPDMIC_TOKENS] = {"ACPDMIC tokens", acpdmic_tokens, ARRAY_SIZE(acpdmic_tokens)},
+	[SOF_ACPI2S_TOKENS]   = {"ACPI2S tokens", acpi2s_tokens, ARRAY_SIZE(acpi2s_tokens)},
 };
 
 /**
@@ -1193,6 +1204,7 @@ static int sof_link_acp_sp_load(struct snd_soc_component *scomp, struct snd_sof_
 	struct snd_soc_tplg_hw_config *hw_config = slink->hw_configs;
 	struct sof_dai_private_data *private = dai->private;
 	u32 size = sizeof(*config);
+	int ret;
 
 	/* handle master/slave and inverted clocks */
 	sof_dai_set_format(hw_config, config);
@@ -1201,12 +1213,15 @@ static int sof_link_acp_sp_load(struct snd_soc_component *scomp, struct snd_sof_
 	memset(&config->acpsp, 0, sizeof(config->acpsp));
 	config->hdr.size = size;
 
-	config->acpsp.fsync_rate = le32_to_cpu(hw_config->fsync_rate);
-	config->acpsp.tdm_slots = le32_to_cpu(hw_config->tdm_slots);
+	ret = sof_update_ipc_object(scomp, &config->acpsp, SOF_ACPI2S_TOKENS, slink->tuples,
+				    slink->num_tuples, size, slink->num_hw_configs);
+	if (ret < 0)
+		return ret;
 
-	dev_info(scomp->dev, "ACP_SP config ACP%d channel %d rate %d\n",
+
+	dev_info(scomp->dev, "ACP_SP config ACP%d channel %d rate %d tdm_mode %d\n",
 		 config->dai_index, config->acpsp.tdm_slots,
-		 config->acpsp.fsync_rate);
+		 config->acpsp.fsync_rate, config->acpsp.tdm_mode);
 
 	dai->number_configs = 1;
 	dai->current_config = 0;
@@ -1223,6 +1238,7 @@ static int sof_link_acp_hs_load(struct snd_soc_component *scomp, struct snd_sof_
 	struct snd_soc_tplg_hw_config *hw_config = slink->hw_configs;
 	struct sof_dai_private_data *private = dai->private;
 	u32 size = sizeof(*config);
+	int ret;
 
 	/* Configures the DAI hardware format and inverted clocks */
 	sof_dai_set_format(hw_config, config);
@@ -1231,12 +1247,14 @@ static int sof_link_acp_hs_load(struct snd_soc_component *scomp, struct snd_sof_
 	memset(&config->acphs, 0, sizeof(config->acphs));
 	config->hdr.size = size;
 
-	config->acphs.fsync_rate = le32_to_cpu(hw_config->fsync_rate);
-	config->acphs.tdm_slots = le32_to_cpu(hw_config->tdm_slots);
+	ret = sof_update_ipc_object(scomp, &config->acphs, SOF_ACPI2S_TOKENS, slink->tuples,
+				    slink->num_tuples, size, slink->num_hw_configs);
+	if (ret < 0)
+		return ret;
 
-	dev_info(scomp->dev, "ACP_HS config ACP%d channel %d rate %d\n",
+	dev_info(scomp->dev, "ACP_HS config ACP%d channel %d rate %d tdm_mode %d\n",
 		 config->dai_index, config->acphs.tdm_slots,
-		 config->acphs.fsync_rate);
+		 config->acphs.fsync_rate, config->acphs.tdm_mode);
 
 	dai->number_configs = 1;
 	dai->current_config = 0;
@@ -1545,9 +1563,11 @@ static int sof_ipc3_widget_setup_comp_dai(struct snd_sof_widget *swidget)
 			ret = sof_link_acp_bt_load(scomp, slink, config, dai);
 			break;
 		case SOF_DAI_AMD_SP:
+		case SOF_DAI_AMD_SP_VIRTUAL:
 			ret = sof_link_acp_sp_load(scomp, slink, config, dai);
 			break;
 		case SOF_DAI_AMD_HS:
+		case SOF_DAI_AMD_HS_VIRTUAL:
 			ret = sof_link_acp_hs_load(scomp, slink, config, dai);
 			break;
 		case SOF_DAI_AMD_DMIC:
diff --git a/sound/soc/sof/sof-audio.h b/sound/soc/sof/sof-audio.h
index 1b5b3ea53a6e..29cf951e3526 100644
--- a/sound/soc/sof/sof-audio.h
+++ b/sound/soc/sof/sof-audio.h
@@ -248,6 +248,7 @@ enum sof_tokens {
 	SOF_COPIER_FORMAT_TOKENS,
 	SOF_GAIN_TOKENS,
 	SOF_ACPDMIC_TOKENS,
+	SOF_ACPI2S_TOKENS,
 
 	/* this should be the last */
 	SOF_TOKEN_COUNT,
diff --git a/sound/soc/sof/topology.c b/sound/soc/sof/topology.c
index 9d9fcaa2a948..c668bd9d21ec 100644
--- a/sound/soc/sof/topology.c
+++ b/sound/soc/sof/topology.c
@@ -289,6 +289,9 @@ static const struct sof_dai_types sof_dais[] = {
 	{"ACPDMIC", SOF_DAI_AMD_DMIC},
 	{"ACPHS", SOF_DAI_AMD_HS},
 	{"AFE", SOF_DAI_MEDIATEK_AFE},
+	{"ACPSP_VIRTUAL", SOF_DAI_AMD_SP_VIRTUAL},
+	{"ACPHS_VIRTUAL", SOF_DAI_AMD_HS_VIRTUAL},
+
 };
 
 static enum sof_ipc_dai_type find_dai(const char *name)
@@ -1895,6 +1898,13 @@ static int sof_link_load(struct snd_soc_component *scomp, int index, struct snd_
 		token_id = SOF_ACPDMIC_TOKENS;
 		num_tuples += token_list[SOF_ACPDMIC_TOKENS].count;
 		break;
+	case SOF_DAI_AMD_SP:
+	case SOF_DAI_AMD_HS:
+	case SOF_DAI_AMD_SP_VIRTUAL:
+	case SOF_DAI_AMD_HS_VIRTUAL:
+		token_id = SOF_ACPI2S_TOKENS;
+		num_tuples += token_list[SOF_ACPI2S_TOKENS].count;
+		break;
 	default:
 		break;
 	}
-- 
2.25.1

