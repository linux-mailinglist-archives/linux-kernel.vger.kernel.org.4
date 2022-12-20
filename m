Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16C11651B84
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 08:25:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232918AbiLTHYw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 02:24:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229866AbiLTHYo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 02:24:44 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2056.outbound.protection.outlook.com [40.107.92.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0928F10FE6
        for <linux-kernel@vger.kernel.org>; Mon, 19 Dec 2022 23:24:43 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L8Ca0SMZapVJSiJ2vOR3aVwF2Up+ASy2aFXxcFSk4O0uXWutYS6QPSOw8LK+PuM9HtEHTX7BeRw6ak3wOu0QEDbEcECtP3sE+wz3PFmJeByetDVGF/EhAwdWzVV5gPdKaXExwSIAYZd7II+O1yaGb+d2kaw/5yqkFI2dcvynKAVmisiIskmo/lGyWJcD8IpKbDa9OrYiUMwcdCpqK6+Ln4qDgnSQqTwkPrMHGcasKdG0WxPUhnNgKR/5FdSdqJp93kAAU2xq7dItHq3ND7GvVNb+EsNavjhbRoCG7oubBcjV61uhmYdbIKaYnzCJqsRrjppZU89FGOiNxNUhHfWO+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mdNgbIcv5DunzMSQAN4qFyyoS+KexLcIFjidToiIkyA=;
 b=dw4uDouzBoQi2Np/KcXxJKMZtHj/kbY3q7diY20X6eqbZsE9JEwN5uCYe886L3Ohbe2BFhr1xreQ2MHUBeT6aLiCI1g6TOGrG8WphTGp0+3Y5gscsQvGnDKpJvx8J0yRebbCe4P0dADkNwEkehJXUfc8HafUZx2GkPz3/RK7gyoDNHbC+uajju9Bv9gy+OtakQTxunLPyIMKt7gs/DYSeyjFY/f/cSqikbKCMtK9Tp0sfNhLJrRXb0eA0mkQyKKPbBzoieHtzC0IC6vZmY4UCfj1k3lJrGaWz/+ipH7Mo0jR0wLvU3ncGtsVFF9fILo3GSrSDr389w1mhdYXwa7Z3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mdNgbIcv5DunzMSQAN4qFyyoS+KexLcIFjidToiIkyA=;
 b=wRixHSF8DypcpoaYiyhrhIuEhxMRUJZ6smto94ewDgRYr/PHF+0q02o0NuoHSW5UYFDWwfBsF1Gzjht86cD+Y8/bhK+sNFrNwXfpSQJJ+fGViNC25giHpxtP3aebN43xFyeTeOt2wrL01dzR7tqhpMIGHSCFKbSpJBdpL7mYt7g=
Received: from BN9PR03CA0614.namprd03.prod.outlook.com (2603:10b6:408:106::19)
 by BN9PR12MB5323.namprd12.prod.outlook.com (2603:10b6:408:104::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.16; Tue, 20 Dec
 2022 07:24:40 +0000
Received: from BN8NAM11FT040.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:106:cafe::61) by BN9PR03CA0614.outlook.office365.com
 (2603:10b6:408:106::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.21 via Frontend
 Transport; Tue, 20 Dec 2022 07:24:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT040.mail.protection.outlook.com (10.13.177.166) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5924.16 via Frontend Transport; Tue, 20 Dec 2022 07:24:40 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 20 Dec
 2022 01:23:38 -0600
Received: from amd-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.34
 via Frontend Transport; Tue, 20 Dec 2022 01:23:16 -0600
From:   Venkata Prasad Potturu <venkataprasad.potturu@amd.com>
To:     <broonie@kernel.org>, <alsa-devel@alsa-project.org>
CC:     <vsujithkumar.reddy@amd.com>, <Vijendar.Mukunda@amd.com>,
        <Basavaraj.Hiregoudar@amd.com>, <Sunil-kumar.Dommati@amd.com>,
        <ssabakar@amd.com>,
        Venkata Prasad Potturu <venkataprasad.potturu@amd.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Ajit Kumar Pandey <AjitKumar.Pandey@amd.com>,
        V sujith kumar Reddy <Vsujithkumar.Reddy@amd.com>,
        Akihiko Odaki <akihiko.odaki@gmail.com>,
        ye xingchen <ye.xingchen@zte.com.cn>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH 4/5] ASoC: amd: acp: Add tdm support in machine driver
Date:   Tue, 20 Dec 2022 12:57:04 +0530
Message-ID: <20221220072705.1456908-5-venkataprasad.potturu@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221220072705.1456908-1-venkataprasad.potturu@amd.com>
References: <20221220072705.1456908-1-venkataprasad.potturu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT040:EE_|BN9PR12MB5323:EE_
X-MS-Office365-Filtering-Correlation-Id: 95c98bc6-b28b-49e8-b7ec-08dae25b41e5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ta1+V/oVY+NUYVJKFyfqMiUEWOvZgRfMmpNOH1CbCWCYQZAPKC2HAgyPfjRQi/zanL7Rmlnh7/WU2/oFIcz5CgKcozIZTT4xKXJ7QztxM5V5x9+7Zd0bNPA9QVX52W2eMHZdnBeJBsmOXIQlFvQyT5FOjPEeo6iwEGchXDT2Ayzn3WjXay2NcbaMx7CBv+xZ7J8TUZWQ8yy2xlrTAupzXau4cgynnA7+mHblfGK9lG0GbGAzvaIVGwkeyvyRNaUtHzJswQSGAbqDupATT1Z/UR7bSdyq/o6is2q+wMdzNSjxJ99UnV0j/PEvWI2OR9cdeBuGVVrav5iR+FZt2CJU2eOT8pVIec/ZwoKsFIYdRyGoy3A0COXwo17Gl0HA3ojyZM/JmUP7lgjpvORUVvdxay0/kZrn11gI6PTSvB+fRSmqllrCENAiS63mq4szyCuH8AFWmcMBMz/gyd34XmM8lOpxmKzzVirpWBo7TOzzElhf3NmgTGF4eRwArBL+SAITmBgbIHRPcC2Tl3yTS5/OfeWDR2XWXBtWd0+pySRhkG2T7SyyAzQb7eyzpWd+NKdr8MfG8QdmmM5yRv1AmsyXZ4go5KdRUdcXR0GdabaxyjlD71xWsESXBqzXavXMU+R8CA3nBUp6Ew7hWFEMl6ylkpeT4c3z/c4l1UeRgXlZqeve+wtpTPBjCs/7pZPtmQ/H5yReoSshDrY7Rvi7KSnQGSEIe3Cgca6BbtFUlzDwmDM=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(396003)(376002)(346002)(136003)(39860400002)(451199015)(46966006)(36840700001)(40470700004)(70206006)(86362001)(70586007)(8676002)(40460700003)(4326008)(316002)(5660300002)(36756003)(8936002)(2616005)(41300700001)(186003)(1076003)(82310400005)(6666004)(7696005)(36860700001)(83380400001)(47076005)(426003)(336012)(356005)(26005)(54906003)(40480700001)(82740400003)(81166007)(478600001)(110136005)(2906002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2022 07:24:40.1352
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 95c98bc6-b28b-49e8-b7ec-08dae25b41e5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT040.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5323
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add tdm support for amd platforms.

Signed-off-by: Venkata Prasad Potturu <venkataprasad.potturu@amd.com>
---
 sound/soc/amd/acp/acp-legacy-mach.c |   5 ++
 sound/soc/amd/acp/acp-mach-common.c | 130 +++++++++++++++++++++++++---
 sound/soc/amd/acp/acp-mach.h        |   3 +
 sound/soc/amd/acp/acp-sof-mach.c    |   6 ++
 4 files changed, 133 insertions(+), 11 deletions(-)

diff --git a/sound/soc/amd/acp/acp-legacy-mach.c b/sound/soc/amd/acp/acp-legacy-mach.c
index 1f4878ff7d37..d508792dba4f 100644
--- a/sound/soc/amd/acp/acp-legacy-mach.c
+++ b/sound/soc/amd/acp/acp-legacy-mach.c
@@ -27,6 +27,7 @@ static struct acp_card_drvdata rt5682_rt1019_data = {
 	.hs_codec_id = RT5682,
 	.amp_codec_id = RT1019,
 	.dmic_codec_id = DMIC,
+	.tdm_mode = false,
 };
 
 static struct acp_card_drvdata rt5682s_max_data = {
@@ -36,6 +37,7 @@ static struct acp_card_drvdata rt5682s_max_data = {
 	.hs_codec_id = RT5682S,
 	.amp_codec_id = MAX98360A,
 	.dmic_codec_id = DMIC,
+	.tdm_mode = false,
 };
 
 static struct acp_card_drvdata rt5682s_rt1019_data = {
@@ -45,6 +47,7 @@ static struct acp_card_drvdata rt5682s_rt1019_data = {
 	.hs_codec_id = RT5682S,
 	.amp_codec_id = RT1019,
 	.dmic_codec_id = DMIC,
+	.tdm_mode = false,
 };
 
 static struct acp_card_drvdata max_nau8825_data = {
@@ -56,6 +59,7 @@ static struct acp_card_drvdata max_nau8825_data = {
 	.dmic_codec_id = DMIC,
 	.soc_mclk = true,
 	.platform = REMBRANDT,
+	.tdm_mode = false,
 };
 
 static struct acp_card_drvdata rt5682s_rt1019_rmb_data = {
@@ -67,6 +71,7 @@ static struct acp_card_drvdata rt5682s_rt1019_rmb_data = {
 	.dmic_codec_id = DMIC,
 	.soc_mclk = true,
 	.platform = REMBRANDT,
+	.tdm_mode = false,
 };
 
 static const struct snd_kcontrol_new acp_controls[] = {
diff --git a/sound/soc/amd/acp/acp-mach-common.c b/sound/soc/amd/acp/acp-mach-common.c
index 748cbefa8252..73a27f02b52b 100644
--- a/sound/soc/amd/acp/acp-mach-common.c
+++ b/sound/soc/amd/acp/acp-mach-common.c
@@ -183,10 +183,15 @@ static int acp_card_rt5682x_hw_params(struct snd_pcm_substream *substream,
 	int ret;
 	unsigned int fmt;
 
+	if (drvdata->tdm_mode)
+		fmt = SND_SOC_DAIFMT_DSP_A;
+	else
+		fmt = SND_SOC_DAIFMT_I2S;
+
 	if (drvdata->soc_mclk)
-		fmt = SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF | SND_SOC_DAIFMT_CBC_CFC;
+		fmt |= SND_SOC_DAIFMT_NB_NF | SND_SOC_DAIFMT_CBC_CFC;
 	else
-		fmt = SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF | SND_SOC_DAIFMT_CBP_CFP;
+		fmt |= SND_SOC_DAIFMT_NB_NF | SND_SOC_DAIFMT_CBP_CFP;
 
 	ret = snd_soc_dai_set_fmt(cpu_dai, fmt);
 	if (ret && ret != -ENOTSUPP) {
@@ -200,6 +205,23 @@ static int acp_card_rt5682x_hw_params(struct snd_pcm_substream *substream,
 		return ret;
 	}
 
+	if (drvdata->tdm_mode) {
+		/**
+		 * As codec supports slot 0 and slot 1 for playback and capture.
+		 */
+		ret = snd_soc_dai_set_tdm_slot(cpu_dai, 0x3, 0x3, 8, 16);
+		if (ret && ret != -ENOTSUPP) {
+			dev_err(rtd->dev, "set TDM slot err: %d\n", ret);
+			return ret;
+		}
+
+		ret = snd_soc_dai_set_tdm_slot(codec_dai, 0x3, 0x3, 8, 16);
+		if (ret < 0) {
+			dev_warn(rtd->dev, "set TDM slot err:%d\n", ret);
+			return ret;
+		}
+	}
+
 	return 0;
 }
 
@@ -364,10 +386,15 @@ static int acp_card_rt1019_hw_params(struct snd_pcm_substream *substream,
 	if (drvdata->amp_codec_id != RT1019)
 		return -EINVAL;
 
+	if (drvdata->tdm_mode)
+		fmt = SND_SOC_DAIFMT_DSP_A;
+	else
+		fmt = SND_SOC_DAIFMT_I2S;
+
 	if (drvdata->soc_mclk)
-		fmt = SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF | SND_SOC_DAIFMT_CBC_CFC;
+		fmt |= SND_SOC_DAIFMT_NB_NF | SND_SOC_DAIFMT_CBC_CFC;
 	else
-		fmt = SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF | SND_SOC_DAIFMT_CBP_CFP;
+		fmt |= SND_SOC_DAIFMT_NB_NF | SND_SOC_DAIFMT_CBP_CFP;
 
 	ret = snd_soc_dai_set_fmt(cpu_dai, fmt);
 	if (ret && ret != -ENOTSUPP) {
@@ -375,12 +402,27 @@ static int acp_card_rt1019_hw_params(struct snd_pcm_substream *substream,
 		return ret;
 	}
 
+	if (drvdata->tdm_mode) {
+		/**
+		 * As codec supports slot 2 and slot 3 for playback.
+		 */
+		ret = snd_soc_dai_set_tdm_slot(cpu_dai, 0xC, 0, 8, 16);
+		if (ret && ret != -ENOTSUPP) {
+			dev_err(rtd->dev, "set TDM slot err: %d\n", ret);
+			return ret;
+		}
+	}
 	for_each_rtd_codec_dais(rtd, i, codec_dai) {
 		if (strcmp(codec_dai->name, "rt1019-aif"))
 			continue;
 
-		ret = snd_soc_dai_set_pll(codec_dai, 0, RT1019_PLL_S_BCLK,
-					  ch * format * srate, 256 * srate);
+		if (drvdata->tdm_mode)
+			ret = snd_soc_dai_set_pll(codec_dai, 0, RT1019_PLL_S_BCLK,
+						  TDM_CHANNELS * format * srate, 256 * srate);
+		else
+			ret = snd_soc_dai_set_pll(codec_dai, 0, RT1019_PLL_S_BCLK,
+						  ch * format * srate, 256 * srate);
+
 		if (ret < 0)
 			return ret;
 
@@ -388,8 +430,34 @@ static int acp_card_rt1019_hw_params(struct snd_pcm_substream *substream,
 					     256 * srate, SND_SOC_CLOCK_IN);
 		if (ret < 0)
 			return ret;
-	}
 
+		if (drvdata->tdm_mode) {
+			ret = snd_soc_dai_set_fmt(codec_dai, SND_SOC_DAIFMT_DSP_A
+							| SND_SOC_DAIFMT_NB_NF);
+			if (ret < 0) {
+				dev_err(rtd->card->dev, "Failed to set dai fmt: %d\n", ret);
+				return ret;
+			}
+
+			/**
+			 * As codec supports slot 2 for left channel playback.
+			 */
+			if (!strcmp(codec_dai->component->name, "i2c-10EC1019:00")) {
+				ret = snd_soc_dai_set_tdm_slot(codec_dai, 0x4, 0x4, 8, 16);
+				if (ret < 0)
+					break;
+			}
+
+			/**
+			 * As codec supports slot 3 for right channel playback.
+			 */
+			if (!strcmp(codec_dai->component->name, "i2c-10EC1019:01")) {
+				ret = snd_soc_dai_set_tdm_slot(codec_dai, 0x8, 0x8, 8, 16);
+				if (ret < 0)
+					break;
+			}
+		}
+	}
 	return 0;
 }
 
@@ -448,19 +516,38 @@ static int acp_card_maxim_hw_params(struct snd_pcm_substream *substream,
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	struct snd_soc_dai *cpu_dai = asoc_rtd_to_cpu(rtd, 0);
+	struct snd_soc_card *card = rtd->card;
+	struct acp_card_drvdata *drvdata = card->drvdata;
 	unsigned int fmt;
 	int ret;
 
+
+	if (drvdata->tdm_mode)
+		fmt = SND_SOC_DAIFMT_DSP_A;
+	else
+		fmt = SND_SOC_DAIFMT_I2S;
+
 	if (drvdata->soc_mclk)
-		fmt = SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF | SND_SOC_DAIFMT_CBC_CFC;
+		fmt |= SND_SOC_DAIFMT_NB_NF | SND_SOC_DAIFMT_CBC_CFC;
 	else
-		fmt = SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF | SND_SOC_DAIFMT_CBP_CFP;
+		fmt |= SND_SOC_DAIFMT_NB_NF | SND_SOC_DAIFMT_CBP_CFP;
 
 	ret = snd_soc_dai_set_fmt(cpu_dai, fmt);
 	if (ret && ret != -ENOTSUPP) {
 		dev_err(rtd->dev, "Failed to set dai fmt: %d\n", ret);
 		return ret;
 	}
+
+	if (drvdata->tdm_mode) {
+		/**
+		 * As codec supports slot 2 and slot 3 for playback.
+		 */
+		ret = snd_soc_dai_set_tdm_slot(cpu_dai, 0xC, 0, 8, 16);
+		if (ret && ret != -ENOTSUPP) {
+			dev_err(rtd->dev, "set TDM slot err: %d\n", ret);
+			return ret;
+		}
+	}
 	return 0;
 }
 
@@ -539,10 +626,15 @@ static int acp_nau8825_hw_params(struct snd_pcm_substream *substream,
 		return ret;
 	}
 
+	if (drvdata->tdm_mode)
+		fmt = SND_SOC_DAIFMT_DSP_A;
+	else
+		fmt = SND_SOC_DAIFMT_I2S;
+
 	if (drvdata->soc_mclk)
-		fmt = SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF | SND_SOC_DAIFMT_CBC_CFC;
+		fmt |= SND_SOC_DAIFMT_NB_NF | SND_SOC_DAIFMT_CBC_CFC;
 	else
-		fmt = SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF | SND_SOC_DAIFMT_CBP_CFP;
+		fmt |= SND_SOC_DAIFMT_NB_NF | SND_SOC_DAIFMT_CBP_CFP;
 
 	ret = snd_soc_dai_set_fmt(cpu_dai, fmt);
 	if (ret && ret != -ENOTSUPP) {
@@ -556,6 +648,22 @@ static int acp_nau8825_hw_params(struct snd_pcm_substream *substream,
 		return ret;
 	}
 
+	if (drvdata->tdm_mode) {
+		/**
+		 * As codec supports slot 4 and slot 5 for playback and slot 6 for capture.
+		 */
+		ret = snd_soc_dai_set_tdm_slot(cpu_dai, 0x30, 0xC0, 8, 16);
+		if (ret && ret != -ENOTSUPP) {
+			dev_err(rtd->dev, "set TDM slot err: %d\n", ret);
+			return ret;
+		}
+
+		ret = snd_soc_dai_set_tdm_slot(codec_dai, 0x40, 0x30, 8, 16);
+		if (ret < 0) {
+			dev_warn(rtd->dev, "set TDM slot err:%d\n", ret);
+			return ret;
+		}
+	}
 	return ret;
 }
 
diff --git a/sound/soc/amd/acp/acp-mach.h b/sound/soc/amd/acp/acp-mach.h
index 20583ef902df..9f87439b3cfd 100644
--- a/sound/soc/amd/acp/acp-mach.h
+++ b/sound/soc/amd/acp/acp-mach.h
@@ -18,6 +18,8 @@
 #include <linux/module.h>
 #include <sound/soc.h>
 
+#define TDM_CHANNELS	8
+
 enum be_id {
 	HEADSET_BE_ID = 0,
 	AMP_BE_ID,
@@ -58,6 +60,7 @@ struct acp_card_drvdata {
 	struct clk *wclk;
 	struct clk *bclk;
 	bool soc_mclk;
+	bool tdm_mode;
 };
 
 int acp_sofdsp_dai_links_create(struct snd_soc_card *card);
diff --git a/sound/soc/amd/acp/acp-sof-mach.c b/sound/soc/amd/acp/acp-sof-mach.c
index f19f064a7527..f3ba22a25962 100644
--- a/sound/soc/amd/acp/acp-sof-mach.c
+++ b/sound/soc/amd/acp/acp-sof-mach.c
@@ -27,6 +27,7 @@ static struct acp_card_drvdata sof_rt5682_rt1019_data = {
 	.hs_codec_id = RT5682,
 	.amp_codec_id = RT1019,
 	.dmic_codec_id = DMIC,
+	.tdm_mode = false,
 };
 
 static struct acp_card_drvdata sof_rt5682_max_data = {
@@ -36,6 +37,7 @@ static struct acp_card_drvdata sof_rt5682_max_data = {
 	.hs_codec_id = RT5682,
 	.amp_codec_id = MAX98360A,
 	.dmic_codec_id = DMIC,
+	.tdm_mode = false,
 };
 
 static struct acp_card_drvdata sof_rt5682s_rt1019_data = {
@@ -45,6 +47,7 @@ static struct acp_card_drvdata sof_rt5682s_rt1019_data = {
 	.hs_codec_id = RT5682S,
 	.amp_codec_id = RT1019,
 	.dmic_codec_id = DMIC,
+	.tdm_mode = false,
 };
 
 static struct acp_card_drvdata sof_rt5682s_max_data = {
@@ -54,6 +57,7 @@ static struct acp_card_drvdata sof_rt5682s_max_data = {
 	.hs_codec_id = RT5682S,
 	.amp_codec_id = MAX98360A,
 	.dmic_codec_id = DMIC,
+	.tdm_mode = false,
 };
 
 static struct acp_card_drvdata sof_nau8825_data = {
@@ -64,6 +68,7 @@ static struct acp_card_drvdata sof_nau8825_data = {
 	.amp_codec_id = MAX98360A,
 	.dmic_codec_id = DMIC,
 	.soc_mclk = true,
+	.tdm_mode = false,
 };
 
 static struct acp_card_drvdata sof_rt5682s_hs_rt1019_data = {
@@ -74,6 +79,7 @@ static struct acp_card_drvdata sof_rt5682s_hs_rt1019_data = {
 	.amp_codec_id = RT1019,
 	.dmic_codec_id = DMIC,
 	.soc_mclk = true,
+	.tdm_mode = false,
 };
 
 static const struct snd_kcontrol_new acp_controls[] = {
-- 
2.25.1

