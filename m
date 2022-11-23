Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E62E0635C9C
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 13:20:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236922AbiKWMTz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 07:19:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236938AbiKWMTo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 07:19:44 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2056.outbound.protection.outlook.com [40.107.244.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87A254091D
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 04:19:40 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l281Q+asI3DfT+azDATRfWHghNo+2+oSVe2dP4+wN9WLPG2kGEpFv5Qf4qGLD1zHPCuSvsmDCxCKXb3tetWOVnzpbc+njjyyihWhFf+t85OxshCvp2/uVPt87iloOLQc9Aw/dizkL3VN/IGxbDvnVx1Oa6lOVaHnOKdoYhwUUAHcgPtBSei4fA451ONO34SR1i9VYU1tGDD7Y0yJiMLt0jfdYCN6R6TtgiJ5RHOJB6Tw2MaJWaB1S+pjf27b4WN4btLO2tadwJDrW+DJOTY4mnONge9XS88/8vJUAn/naU2kPR0wjDyEzCfva0HgAd/NNXqC1eJr8sSrj4kU7HpBuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=crKYZqsur+4gEYhSzBzo+HEuxihufxYk2GKO/860hgY=;
 b=IdJmy6xPueZKzR/ZyA1Kme2kCWtoiIlnnss0eYBiiq7GZvS1I1mkH4r2HPq4rRYfEtulQGdZ/hjO86T1GaGzp3eOKVkHgl6MTttfx9QB0UVtQVm/2WcN/vL6/IjW14Q/Q0tR/LHEgS0EflAnO/z+61FvoMit+PpJ7I3es7Eu0MTnT40CtnlF47hRxlwUm50LMCSdJ8mTjpiZG/VTa3ZN0A/v3Q6AR4gytHQMgfmSR1WmS9SLA0+84VAgfuaGEMSB9OF5y7mxegWarJQDt8iyQRoesc64KmWrsXltKtnFpmU1pIBe93xzQA1KGp7fzWf91yixReV53o7NwWLk6kHegg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 165.204.84.17) smtp.rcpttodomain=kernel.org
 smtp.mailfrom=amd.corp-partner.google.com; dmarc=fail (p=reject sp=reject
 pct=100) action=oreject header.from=amd.corp-partner.google.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=crKYZqsur+4gEYhSzBzo+HEuxihufxYk2GKO/860hgY=;
 b=Z40G6vK0/SB02WijZ95i3j9qpQwN2CuXPxYxQIkyEFo4c6PzHxcqg+oJMguCiPpMinKoclMgjWOI2VcC2w7RAJTw4+wH9b+DrqINyQ9bp0fcPVdx0+N022FvwzQK14qcMkmUReWcZ1OYK73pEmBMC+6RjEFw8ZtFs7s2huvoAJGwHvviN3F18jxQF9piLk8YvolIs/LnMZpEeyezrgCkHt4NheqMmnLAj/DXV6RcAnXCv67b6CbHoqnzlf2lfSEdjE17PVK/9Ssv//oss/1xlN+iQD7DuVYlzs8gY4l81eDcfQ8jH3aAcJ48bV8d4S35fbZn/liAiZgGHym0kdrlwQ==
Received: from MW4PR03CA0104.namprd03.prod.outlook.com (2603:10b6:303:b7::19)
 by BL3PR12MB6593.namprd12.prod.outlook.com (2603:10b6:208:38c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.15; Wed, 23 Nov
 2022 12:19:38 +0000
Received: from CO1NAM11FT046.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b7:cafe::1e) by MW4PR03CA0104.outlook.office365.com
 (2603:10b6:303:b7::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.15 via Frontend
 Transport; Wed, 23 Nov 2022 12:19:37 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 165.204.84.17) smtp.mailfrom=amd.corp-partner.google.com; dkim=none (message
 not signed) header.d=none;dmarc=fail action=oreject
 header.from=amd.corp-partner.google.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 amd.corp-partner.google.com discourages use of 165.204.84.17 as permitted
 sender)
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT046.mail.protection.outlook.com (10.13.174.203) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5834.8 via Frontend Transport; Wed, 23 Nov 2022 12:19:37 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 23 Nov
 2022 06:19:36 -0600
Received: from sof-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.34
 via Frontend Transport; Wed, 23 Nov 2022 06:19:31 -0600
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
Subject: [PATCH v1 4/4] ASoC: SOF: Add DAI configuration support for AMD platforms.
Date:   Wed, 23 Nov 2022 17:49:11 +0530
Message-ID: <20221123121911.3446224-5-vsujithkumar.reddy@amd.corp-partner.google.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221123121911.3446224-1-vsujithkumar.reddy@amd.corp-partner.google.com>
References: <20221123121911.3446224-1-vsujithkumar.reddy@amd.corp-partner.google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT046:EE_|BL3PR12MB6593:EE_
X-MS-Office365-Filtering-Correlation-Id: f5ac891a-9ace-4523-867c-08dacd4cfd57
X-MS-Exchange-SenderADCheck: 2
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VkQqM6UVC6gWAsi8SVLcKVOJ5PiFB/leXFWorHmboWilL2zd9ocRadfqH8tYwhWk8Y2LubeQBq3+YP8KMY5hd8mJxFCTZwketp0R9WNu7yiUEUbQVJFiREy/hGjqyZwzJU9ajufNGkiEoNYyPF2WSCe3eciIQ0xdC3yU/eDRNGVabKbLf7EmfAz5GEryNa1WsapjkhxrG4wrlCFvDzD3zIoFle0ErYDcpLnCeWoW+u7T8+fnkrSWj/bz5whaCyAmyxI9a9AMPJad/m1xLGwAl1l8QNbxC1YXLtHfk8NmFLXt/H7QwsmBjzXa9SZ7vVCBXK20L/kKEJWgYmE56FA/jQgM+74L9o8GkxAZOcbikWHWv+uC31b4EkDmPWuPc7cUsLMndSaALPDY5zOY1gmyZyxSBohqJp1P+cYyxHhqtv9J0JLXlvJ9Mz6LaMhKQGgWOQsZHyUDSmD5FKD5i9t2qzbSoLngwMdDabpHGMrbfUYfWKnprsy8XMUHkSE2J4Fx6FRcuNM0q2IGXYpG6Rf1YC4l10Jwcmyx8nZ/vM+00QbNuoRbnRuUjhxv6QDqYn5TdtI4sDoeQVH5gqyqRwmyGan2irR+AF6w1ZRp4DP8Am0D9HehIu5bNUOda1JI83VyQ0LoUvl3wOosAZLZLSmL7w7KUpMR1Taj9e1NSAodsN9hIjRVTqmIhi7kDHEDMhC8gPPv0oaOeoeJIqqDMuQfmA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(346002)(136003)(39860400002)(396003)(376002)(451199015)(46966006)(40470700004)(8676002)(41300700001)(40480700001)(8936002)(7416002)(54906003)(316002)(76482006)(5660300002)(4326008)(70586007)(70206006)(86362001)(82740400003)(83380400001)(6666004)(498600001)(26005)(356005)(81166007)(110136005)(2906002)(2616005)(336012)(82310400005)(47076005)(1076003)(40460700003)(35950700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amdcloud.onmicrosoft.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2022 12:19:37.6364
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f5ac891a-9ace-4523-867c-08dacd4cfd57
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT046.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6593
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

