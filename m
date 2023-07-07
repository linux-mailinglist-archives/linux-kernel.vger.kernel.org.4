Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14F8174B075
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 14:09:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232319AbjGGMIU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 08:08:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231623AbjGGMIT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 08:08:19 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2077.outbound.protection.outlook.com [40.107.237.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F1842118
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jul 2023 05:08:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eJg5LpfzuRWw5eFxjiRYR0NkMnHzSXLM+53LJDpsZmGhsf/pgn8ZgFUC5qE/96XQjJ2ncl+znh+GdDFZXG+VDAesIms+xiB9OO7353/owQNFZoon9YP2edeIxnJALXYITXmSZEvTZRoIVo4stGwXLr6362xLEAhKOLuTKIkfmR8gPAmqUN1W79w6wPjzN087SSoHEWDn6m+JK5rUPyXeAUmf1t4UNi4pmuaXCw6ahjDmNbEFLMM2z0dXm1chhaonh8edLIIFfLK/6OXHcTGY7njriOFXb1TczwWwuLuIkKYI2935cAStsZZGLPswfOUfsPTI1m9JnkwO9UnQ5YZROg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gCn8FglKTYIilpz6R0Gkp41+EE/dijPY1zYQTuZTIek=;
 b=GDtxS9SJwxkpLcFo5zUMGSgKw78wPXKHtkiOHJ5hhqaQoPtl525HPGsa0zpvGMwgonR1/JiFHiIK3GdGKMO4rRYTZMNAQ5oJesN7/wum5LnALFwtKKqOem0mfetesbRVGcL+bTjK5oUVhEH0WahSlADhTTBfhKVhar54oKaldpfkbSF+GsgPNfwXlCPDavM4bLBP+E97oR1aChio/tf86mJcPaISsvV6ctNT5NVjturCCrUD75kpQTM4I4ZP3X+9+tq0CzpIkl2lhGY4iBZVMbrI6J6W2gmegVTwXF1gToLhRWoOhoGDFLjv54+cUE9wJ1StlT9FJ5+DwpPtNepozw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gCn8FglKTYIilpz6R0Gkp41+EE/dijPY1zYQTuZTIek=;
 b=ZLKC2z/hc2mlqTZTR3gegvahVWc/03bFdhIbT8rtjJcU5D39n3vyFXe1hNQXEfd5PAfKR2TGWwD7PEMS/yZWnqRX9GVDK+TwXysVOdJI38TJUHQ19n9gvssvbjSjkjZMWCwjg615tz5arxHhjTAmKyyhEbZin7PMgODpaF94IhA=
Received: from DM6PR21CA0026.namprd21.prod.outlook.com (2603:10b6:5:174::36)
 by DM4PR12MB5746.namprd12.prod.outlook.com (2603:10b6:8:5d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.25; Fri, 7 Jul
 2023 12:08:05 +0000
Received: from DM6NAM11FT100.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:174:cafe::35) by DM6PR21CA0026.outlook.office365.com
 (2603:10b6:5:174::36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.13 via Frontend
 Transport; Fri, 7 Jul 2023 12:08:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT100.mail.protection.outlook.com (10.13.172.247) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6521.45 via Frontend Transport; Fri, 7 Jul 2023 12:08:04 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Fri, 7 Jul
 2023 07:08:01 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Fri, 7 Jul
 2023 07:08:01 -0500
Received: from amd-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.23
 via Frontend Transport; Fri, 7 Jul 2023 07:07:50 -0500
From:   Venkata Prasad Potturu <venkataprasad.potturu@amd.com>
To:     <broonie@kernel.org>, <alsa-devel@alsa-project.org>
CC:     <vsujithkumar.reddy@amd.com>, <Vijendar.Mukunda@amd.com>,
        <Basavaraj.Hiregoudar@amd.com>, <Sunil-kumar.Dommati@amd.com>,
        <syed.sabakareem@amd.com>, <mastan.katragadda@amd.com>,
        <arungopal.kondaveeti@amd.com>,
        Venkata Prasad Potturu <venkataprasad.potturu@amd.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        "V sujith kumar Reddy" <Vsujithkumar.Reddy@amd.com>,
        Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        ye xingchen <ye.xingchen@zte.com.cn>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/4] ASoC: amd: acp: Add machine driver support for max98388 codec
Date:   Fri, 7 Jul 2023 17:37:28 +0530
Message-ID: <20230707120730.1948445-3-venkataprasad.potturu@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230707120730.1948445-1-venkataprasad.potturu@amd.com>
References: <20230707120730.1948445-1-venkataprasad.potturu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT100:EE_|DM4PR12MB5746:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e41b665-b885-4167-41cb-08db7ee2d166
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zkBpl+wkQ7yT3eqwbxtidmXdGNPp2BNwkr/fxm5FooznWjUDT/rYjzDfCCOMSEjgdL6viLTRj2ifzUvHcEUalucVRf3QMV617ycmGiwictFJf37HaAYBVYD/+xazHTlL9EQLu3VT/kSH23WgWxzDF+g+gOKwynYfPVZn95EdkjfAg1WWmVCvo0UlDJlRjT+so2a33XpJc8p54PIA8guXLqrJNlOVvtEdIzgjph1AcQyAnQNe4NDiVpPNeLvo+npDytp9YPcAJttYeF9MwQ99ogTEmH11+UAPVYtmydirAzI/vcN5BetGYyVaV6qYjy1cQIF+BP/cM+QsTPc0bD6sr7xp9D+xXnOylTCEky6Dk31bMh0zeE+fsSTL2L5+HxjZpoEOSRUiDS4GoN+V6Zm+UYd4ggrb62Smx/NZD5wJ8HKQTksV2Ls0ZYss07R9bGdyC47VL9cagEKj/A72vyMTQ1Rjt8BhLNJgofYANyfeIQGlOmAh4aAad/14y/byiz3m3wVEt5PNYeQ+ZYoKbRuCFJuZjtUMbtkRRv/yrljKeVcZrfiL83BiNsOSZhLaAop9KVwbC0UWYn9M/CEUE6lhKeaFUU9MZ2/z3Ahh0ziefOS8DTca7f1VZQ0XnykUiFEG0IwqhytC93BfOGhu4SqKL0Ww2rsUcK46eZmsxJbdvtN2ifA/YbmU4e/C+i2s1kSf568h1KTWyqIwlo3wqdiviFiBKCCnNHTReF00mAmY48G3hxSDXW4vxpwiYD8if/bJcJClktBOjtEWP1v+QFAr+g==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(346002)(396003)(39860400002)(136003)(376002)(451199021)(36840700001)(46966006)(40470700004)(7696005)(6666004)(478600001)(110136005)(54906003)(70586007)(36860700001)(47076005)(426003)(2616005)(36756003)(86362001)(40480700001)(40460700003)(2906002)(82310400005)(186003)(1076003)(26005)(336012)(70206006)(81166007)(82740400003)(356005)(4326008)(41300700001)(316002)(8936002)(8676002)(5660300002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2023 12:08:04.3124
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e41b665-b885-4167-41cb-08db7ee2d166
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT100.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5746
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

In newer platforms max98388 codec as amplifier codec. Add support for
maxim codec in generic machine driver.

Signed-off-by: Venkata Prasad Potturu <venkataprasad.potturu@amd.com>
---
 sound/soc/amd/acp/Kconfig           |   1 +
 sound/soc/amd/acp/acp-mach-common.c | 100 ++++++++++++++++++++++++++++
 sound/soc/amd/acp/acp-mach.h        |   1 +
 3 files changed, 102 insertions(+)

diff --git a/sound/soc/amd/acp/Kconfig b/sound/soc/amd/acp/Kconfig
index a68bbe106b73..d7f1c3c90484 100644
--- a/sound/soc/amd/acp/Kconfig
+++ b/sound/soc/amd/acp/Kconfig
@@ -62,6 +62,7 @@ config SND_SOC_AMD_MACH_COMMON
 	select SND_SOC_RT5682S
 	select SND_SOC_NAU8825
 	select SND_SOC_NAU8821
+	select SND_SOC_MAX98388
 	help
 	  This option enables common Machine driver module for ACP.
 
diff --git a/sound/soc/amd/acp/acp-mach-common.c b/sound/soc/amd/acp/acp-mach-common.c
index 48abb8e9665d..ff5cbc4a6427 100644
--- a/sound/soc/amd/acp/acp-mach-common.c
+++ b/sound/soc/amd/acp/acp-mach-common.c
@@ -36,6 +36,7 @@ static struct snd_soc_jack vg_headset;
 #define NAU8821_CODEC_DAI	"nau8821-hifi"
 #define NAU8821_BCLK		1536000
 #define NAU8821_FREQ_OUT	12288000
+#define MAX98388_CODEC_DAI	"max98388-aif1"
 
 #define TDM_MODE_ENABLE 1
 
@@ -666,6 +667,97 @@ static const struct snd_soc_ops acp_card_maxim_ops = {
 	.hw_params = acp_card_maxim_hw_params,
 };
 
+SND_SOC_DAILINK_DEF(max98388,
+		    DAILINK_COMP_ARRAY(COMP_CODEC("i2c-ADS8388:00", "max98388-aif1"),
+				       COMP_CODEC("i2c-ADS8388:01", "max98388-aif1")));
+
+static const struct snd_soc_dapm_widget max98388_widgets[] = {
+	SND_SOC_DAPM_SPK("SPK", NULL),
+};
+
+static const struct snd_soc_dapm_route max98388_map[] = {
+	{ "SPK", NULL, "Left BE_OUT" },
+	{ "SPK", NULL, "Right BE_OUT" },
+};
+
+static struct snd_soc_codec_conf max98388_conf[] = {
+	{
+		.dlc = COMP_CODEC_CONF("i2c-ADS8388:00"),
+		.name_prefix = "Left",
+	},
+	{
+		.dlc = COMP_CODEC_CONF("i2c-ADS8388:01"),
+		.name_prefix = "Right",
+	},
+};
+
+static const unsigned int max98388_format[] = {16};
+
+static struct snd_pcm_hw_constraint_list constraints_sample_bits_max = {
+	.list = max98388_format,
+	.count = ARRAY_SIZE(max98388_format),
+};
+
+static int acp_card_max98388_startup(struct snd_pcm_substream *substream)
+{
+	struct snd_pcm_runtime *runtime = substream->runtime;
+
+	runtime->hw.channels_max = DUAL_CHANNEL;
+	snd_pcm_hw_constraint_list(runtime, 0, SNDRV_PCM_HW_PARAM_CHANNELS,
+				   &constraints_channels);
+	snd_pcm_hw_constraint_list(runtime, 0, SNDRV_PCM_HW_PARAM_RATE,
+				   &constraints_rates);
+	snd_pcm_hw_constraint_list(runtime, 0, SNDRV_PCM_HW_PARAM_SAMPLE_BITS,
+				   &constraints_sample_bits_max);
+
+	return 0;
+}
+
+static int acp_card_max98388_init(struct snd_soc_pcm_runtime *rtd)
+{
+	struct snd_soc_card *card = rtd->card;
+	struct acp_card_drvdata *drvdata = card->drvdata;
+	int ret;
+
+	if (drvdata->amp_codec_id != MAX98388)
+		return -EINVAL;
+
+	ret = snd_soc_dapm_new_controls(&card->dapm, max98388_widgets,
+					ARRAY_SIZE(max98388_widgets));
+
+	if (ret) {
+		dev_err(rtd->dev, "unable to add widget dapm controls, ret %d\n", ret);
+		/* Don't need to add routes if widget addition failed */
+		return ret;
+	}
+	return snd_soc_dapm_add_routes(&rtd->card->dapm, max98388_map,
+				       ARRAY_SIZE(max98388_map));
+}
+
+static int acp_max98388_hw_params(struct snd_pcm_substream *substream,
+				  struct snd_pcm_hw_params *params)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_card *card = rtd->card;
+	struct snd_soc_dai *codec_dai =
+			snd_soc_card_get_codec_dai(card,
+						   MAX98388_CODEC_DAI);
+	int ret;
+
+	ret = snd_soc_dai_set_fmt(codec_dai,
+				  SND_SOC_DAIFMT_CBS_CFS | SND_SOC_DAIFMT_I2S |
+				  SND_SOC_DAIFMT_NB_NF);
+	if (ret < 0)
+		return ret;
+
+	return ret;
+}
+
+static const struct snd_soc_ops acp_max98388_ops = {
+	.startup = acp_card_max98388_startup,
+	.hw_params = acp_max98388_hw_params,
+};
+
 /* Declare nau8825 codec components */
 SND_SOC_DAILINK_DEF(nau8825,
 		    DAILINK_COMP_ARRAY(COMP_CODEC("i2c-10508825:00", "nau8825-hifi")));
@@ -1174,6 +1266,14 @@ int acp_sofdsp_dai_links_create(struct snd_soc_card *card)
 			links[i].ops = &acp_card_maxim_ops;
 			links[i].init = acp_card_maxim_init;
 		}
+		if (drv_data->amp_codec_id == MAX98388) {
+			links[i].codecs = max98388;
+			links[i].num_codecs = ARRAY_SIZE(max98388);
+			links[i].ops = &acp_max98388_ops;
+			links[i].init = acp_card_max98388_init;
+			card->codec_conf = max98388_conf;
+			card->num_configs = ARRAY_SIZE(max98388_conf);
+		}
 		if (drv_data->amp_codec_id == RT1019) {
 			links[i].codecs = rt1019;
 			links[i].num_codecs = ARRAY_SIZE(rt1019);
diff --git a/sound/soc/amd/acp/acp-mach.h b/sound/soc/amd/acp/acp-mach.h
index f2b44a6189a6..2b3ec6594023 100644
--- a/sound/soc/amd/acp/acp-mach.h
+++ b/sound/soc/amd/acp/acp-mach.h
@@ -42,6 +42,7 @@ enum codec_endpoints {
 	RT5682S,
 	NAU8825,
 	NAU8821,
+	MAX98388,
 };
 
 enum platform_end_point {
-- 
2.25.1

