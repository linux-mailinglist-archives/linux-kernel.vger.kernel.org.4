Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DBD1629262
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 08:21:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232388AbiKOHVI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 02:21:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232361AbiKOHUy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 02:20:54 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2066.outbound.protection.outlook.com [40.107.223.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A89F20995
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 23:20:43 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EiAK1ks0o7jzKEM9e6g/Cu8tA4akdl31xWmn2cZRamJ2TA6PU9ZEtVnvIbt/GavAC8eHy0E01Ku9IVaRCyon3/rXXw4OhUZdRyE/5hxr3Xg4+h9tDpVr8jIy5TQsDXsVbZGzXuLsf/NVnMv49CDoUKD4J7P3uVK1k7SrDrTZ715dCVAXLCXQ9YQFv+GkS4YQ49faCSTo77nStppi7D/SI9q1/A/z2g4vb/5KtfVHiM4DfvFZZhPhHbiCHPRpnhfxfwIQ5hpgB19WnEfk+YhvlC0B/2McJh4Mn9jzDpAp/RM44CklEv+dFK7YXTmXcS/85IhGqtyAq0M5USDQutez0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sktex+Cr+nJJveF0gSzefdLFbimCxVcsgk2n1cK2lWM=;
 b=EHqI+OmeOY35rx4m5SPpyb8Nn97qU+LOVT2R0zFH6ZIHlEuhY692WekRTrE/FcxYIC9MwhCVBtdm/4qPLXdQxeTDp8agZPIWeyFi43lpF1McAuiawnqo0nupO+apJqdnwMMUGeanFgNhpC/746GLWJXRXPlrM8bqLDnaAnyH+NMvIqbce89YQsv9h9fFZyKasHyLkHx40tbmMc6Qvq/3891qL2H9f77jSnh/HDbnok+odOZFOVyH0aThIBn4Se3A89EloSr/BqUCwRrJT26wevNJbvdxlVIzDyHuNo9zzATTTuuD6WRAQaSWW2FxqvEnRMFfOrsgb+cUq9eXO/6vYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sktex+Cr+nJJveF0gSzefdLFbimCxVcsgk2n1cK2lWM=;
 b=wNYtARA8l8/G1dpEJvI/2LpDp32ryaeV6Nhrbg5p5TRLyUnvWQM2c+OlrnguuaMnolQPTMwFIlF9gTHvwU1D5DK8TorexmVjFEoEhUCMjKjD8apI2IkA7Okxds6ZBJAQzUR6XxWcpnxARo1Alx0qP9FOCL/qgQ49fvdIU0HBu3M=
Received: from BL1PR13CA0387.namprd13.prod.outlook.com (2603:10b6:208:2c0::32)
 by DM6PR12MB4878.namprd12.prod.outlook.com (2603:10b6:5:1b8::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.17; Tue, 15 Nov
 2022 07:20:41 +0000
Received: from BL02EPF0000EE3F.namprd05.prod.outlook.com
 (2603:10b6:208:2c0:cafe::41) by BL1PR13CA0387.outlook.office365.com
 (2603:10b6:208:2c0::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.17 via Frontend
 Transport; Tue, 15 Nov 2022 07:20:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0000EE3F.mail.protection.outlook.com (10.167.241.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5813.11 via Frontend Transport; Tue, 15 Nov 2022 07:20:40 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 15 Nov
 2022 01:20:35 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 14 Nov
 2022 23:20:17 -0800
Received: from sof-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.34
 via Frontend Transport; Tue, 15 Nov 2022 01:20:11 -0600
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
        "moderated list:SOUND - SOUND OPEN FIRMWARE (SOF) DRIVERS" 
        <sound-open-firmware@alsa-project.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH 4/4] ASoC: SOF: Add DAI configuration support for AMD platforms.
Date:   Tue, 15 Nov 2022 12:49:56 +0530
Message-ID: <20221115072001.1931617-4-Vsujithkumar.Reddy@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221115072001.1931617-1-Vsujithkumar.Reddy@amd.com>
References: <20221115072001.1931617-1-Vsujithkumar.Reddy@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0000EE3F:EE_|DM6PR12MB4878:EE_
X-MS-Office365-Filtering-Correlation-Id: b0841cfc-46ba-4da1-3acb-08dac6d9e6ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dilc/juPZxeTHsVFiL/TYAvUCm4YtzkU0cthr2H9FyqbhcNHwsuH/BAYj+lmgZHN49uWNcgDh8yStploN8n/TsPKd0ZzdIF/45PN7Iqhr+kE/iF8yhd7j5HFYBxXdEJc4PB4huO8xQTrXa+oElg8v2ON7DNlaj1JzAncajN3CmUL6BZJ6ytMrxz8+xVO0jO0faN13lvCzRd26iXzrbikKK8eKorknnr2sQLVOHcsePIV8OaYNSDKtH7LX/xUtPlNWLyBpAv8v5qo9FQcopO8NThQ1c18DM86iG1dI2VWKzTqy6hDMWpdblpLVrACGRgkojaYcTMwD1ztLK9qCr/t8+Kj8C372nbtjPG9C3G+kfrWRYAsyFCSDQRxMDE4ZgDJawGZlbxpFa0nAN4adEhoSkpistNaMwc/PsHivdEvqpW7IIg6x54r9ZuLKXlZ8DVtD4ZWpZmqT3Wq+EuejpRXAC1ry699df8ShK4RI8lqfnZgu+zfHLIbCx2ulVO0ZvTZZa+iYMHJqT/rENLQQ6a3akekqH39z9iOtAjXXBxG4/07VnqDTaOqvxfFYMD0Arsisr4PFYPEWxFlwtNN3UOu+xOWzmS2MuIqwBwNmkj+EmmzZPkwOG4IX//JycBQ3hF3EUGklyfa8Hv6N992qdX8v7qVaobzfGQ+0wfYSKv4OOJJDvq1uRtpFWIqKXySymYG67vLfMMeICrEfueOrVrhFAsriMwq6rdJxB0lwJM0oDrT9Bl/5WH9Uv4g2+T5uAJVxjhgisv1JfXQV7RNFVJyyyWO9QbL2AVbAAWoHaABqIM=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(396003)(346002)(136003)(376002)(39860400002)(451199015)(46966006)(36840700001)(40470700004)(6666004)(54906003)(7696005)(110136005)(478600001)(70206006)(8936002)(26005)(36756003)(4326008)(8676002)(70586007)(336012)(2616005)(7416002)(41300700001)(1076003)(5660300002)(186003)(83380400001)(82310400005)(40460700003)(81166007)(356005)(47076005)(426003)(36860700001)(2906002)(316002)(82740400003)(40480700001)(86362001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2022 07:20:40.6193
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b0841cfc-46ba-4da1-3acb-08dac6d9e6ad
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0000EE3F.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4878
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for configuring sp and hs DAI from topology.

Signed-off-by: V sujith kumar Reddy <Vsujithkumar.Reddy@amd.com>
---
 sound/soc/sof/ipc3-pcm.c      |  2 ++
 sound/soc/sof/ipc3-topology.c | 36 +++++++++++++++++++++++++++--------
 sound/soc/sof/sof-audio.h     |  1 +
 sound/soc/sof/topology.c      | 10 ++++++++++
 4 files changed, 41 insertions(+), 8 deletions(-)

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

