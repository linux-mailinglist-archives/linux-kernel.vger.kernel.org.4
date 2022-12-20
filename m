Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 087FC651B83
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 08:24:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233311AbiLTHYs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 02:24:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233314AbiLTHYl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 02:24:41 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2041.outbound.protection.outlook.com [40.107.244.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 615DF1274F
        for <linux-kernel@vger.kernel.org>; Mon, 19 Dec 2022 23:24:40 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bnhxRs0c0sM/zRWHWvFaAh5YDLREJRbbLaEoZf58tQ38EbKA+c1DRIr6MBZwilY5W2V6GZ5rOWmy9XZP4bYO/Lolb2W+w4vRLxi4lv14XQtb3lGXm3L4DJZWWbZhGXviEu0MO81h/6DAT63OlrTDJX7Pfm6e3ll3w33JPXX5JkzrqDFavv+Wds/wYJ6sGJ1JphQ8MVL/v3uQHI+/kg4qPCVcUkvx0kL1ZlIxsi65qIPZzKgXD+kIIH/fhyCbTuYvPSeCBBVrW1znhGvjE/7iGgE3/AUXgTDcJA2R8T83dyfh8ysDexWsAViERQsIuhKk33i8ymAYwmbdXx9F02x4Bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8xbCPOLaQLH0IsHAexek5YCEs/b2MJhpyvwcEOaY5Fc=;
 b=HH40FAHrzT8C8cRo6cxk9OiOJhe48bzRNoZSy0hgv+gxirmWAMmPMNQK7uKC0hCc3NrWa1foGqFBErE0sH+pPH7iruaDr2YyvsE3/c1fLlWKq7KAWLNbOcj5eCm411PPiCnlyC/324Y4mJvM6uYQ145hjrt4rsarylYUA7ZTsElSDZm5sM+Vib1zHaAFejXzF3NamMHggSAitnFT9JIJdGObG0FGCxhn/8xcgdBADE8Yga6AFtTKRhKJ0RsJRL7i1XW36wfSYxAbNDUmI2A1xN+A/RhkZvJUi9X2ZGDh6KMD4QyOvS3m/xnZUgefysX0onrA8TLXn+tuPCbVYiarTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8xbCPOLaQLH0IsHAexek5YCEs/b2MJhpyvwcEOaY5Fc=;
 b=IOD5lqZedNVN+9hxqtrQlAXCr6jyeqfL2L8EonI6YbBNXC2gLXKV/O1oZRr/hhuZHSF8a4XfSuIYYSQYcj0SKtkk6DhkQ30C/6dUQNQLv6Q3s0Fq2Y7dKJuCkiVLRxnGX5mrw760OSwljEHCwp8mExlTeWiZmZIMvbwfbowbUn4=
Received: from DS7P222CA0014.NAMP222.PROD.OUTLOOK.COM (2603:10b6:8:2e::34) by
 DS0PR12MB8043.namprd12.prod.outlook.com (2603:10b6:8:14d::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5924.16; Tue, 20 Dec 2022 07:24:38 +0000
Received: from DM6NAM11FT052.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:2e:cafe::f2) by DS7P222CA0014.outlook.office365.com
 (2603:10b6:8:2e::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.21 via Frontend
 Transport; Tue, 20 Dec 2022 07:24:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT052.mail.protection.outlook.com (10.13.172.111) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5924.16 via Frontend Transport; Tue, 20 Dec 2022 07:24:37 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 20 Dec
 2022 01:23:38 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 19 Dec
 2022 23:23:12 -0800
Received: from amd-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.34
 via Frontend Transport; Tue, 20 Dec 2022 01:23:02 -0600
From:   Venkata Prasad Potturu <venkataprasad.potturu@amd.com>
To:     <broonie@kernel.org>, <alsa-devel@alsa-project.org>
CC:     <vsujithkumar.reddy@amd.com>, <Vijendar.Mukunda@amd.com>,
        <Basavaraj.Hiregoudar@amd.com>, <Sunil-kumar.Dommati@amd.com>,
        <ssabakar@amd.com>,
        Venkata Prasad Potturu <venkataprasad.potturu@amd.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        V sujith kumar Reddy <Vsujithkumar.Reddy@amd.com>,
        Ajit Kumar Pandey <AjitKumar.Pandey@amd.com>,
        Akihiko Odaki <akihiko.odaki@gmail.com>,
        Jia-Ju Bai <baijiaju1990@gmail.com>,
        ye xingchen <ye.xingchen@zte.com.cn>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH 3/5] ASoC: amd: acp: Refactor dai format implementation
Date:   Tue, 20 Dec 2022 12:57:03 +0530
Message-ID: <20221220072705.1456908-4-venkataprasad.potturu@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221220072705.1456908-1-venkataprasad.potturu@amd.com>
References: <20221220072705.1456908-1-venkataprasad.potturu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT052:EE_|DS0PR12MB8043:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b789f64-c15c-4622-8371-08dae25b4077
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6yJX3p0GSZbmbAez2ZFDA24ozQOumS0lujJz58K7/ret05AlA+c0+2/qtSbsiRD1aNaEtgpFl+Rm4lcPGAHlAEq9XluYoZhfz8g7spBS3nupAjCKPfgxTxLHQ8Lh6MtrE4wAPCtAUZB2WACZdcH0Hn9E+nrHF1KZg/psRCspPbat8XmwgJpZq6SZT/+cYd4CgZFauzeNscArAt+0G3CgRb51Aq8lzEgxkUnzJvR8gythM6+duyjT0xiTXLHbKeTR6lbwdYlzHIuRigkOLhSjtsT2tlPqDp30iWRwzXzS09U0+g0ucOut/0DR3I4S6GFNKPtGopUZGWYf2c3b2qJsg2T6XMpqlHcXq0Kwuk4E4ftnpbUfMQEAzvG/YQekoXLI8jXOmWGBBNOh6A9e+NrcryNVwsPLpZ6j6HB0ExmmPICaugpLkDYg9HmZVSgDtlf9fW3wz+UT+GV81n3WGejsAXvDmVBprp/KBnojn4Vj/Ymwq11zEZ7SNmQHFeyh1j3AA8H+5DYOKTFKe+csHVP/GnMJxBirC0CXnCsl8LiqQYIgOkO63GWisAK1BscGzE8gQ/RSO2v12PAwprSwjxSA5A6K/7pHfef+9HmXdFxJkPzbnDsSZI+KAOSn3Ye4GuSU+SWoM3zUSkKG0fzwMo6JfbsDiqOcqzOFWAXQxpKUYKkgraU+UQhE3xUOHwC14hKXkr1fW3u+ptGs+RAxT3T7xWFKVHkKTTGwt4kxvMTIwmY=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(396003)(376002)(346002)(136003)(451199015)(36840700001)(46966006)(40470700004)(40480700001)(41300700001)(86362001)(70206006)(5660300002)(356005)(4326008)(54906003)(8676002)(81166007)(70586007)(316002)(8936002)(2906002)(110136005)(7696005)(82310400005)(26005)(186003)(82740400003)(83380400001)(40460700003)(36756003)(426003)(2616005)(1076003)(47076005)(336012)(36860700001)(478600001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2022 07:24:37.7040
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b789f64-c15c-4622-8371-08dae25b4077
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT052.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8043
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Refactor dai format implementation in dai_link specific
snd_soc_ops.

Signed-off-by: Venkata Prasad Potturu <venkataprasad.potturu@amd.com>
---
 sound/soc/amd/acp/acp-mach-common.c | 134 +++++++++++++++++++---------
 1 file changed, 90 insertions(+), 44 deletions(-)

diff --git a/sound/soc/amd/acp/acp-mach-common.c b/sound/soc/amd/acp/acp-mach-common.c
index 5132fedef00f..748cbefa8252 100644
--- a/sound/soc/amd/acp/acp-mach-common.c
+++ b/sound/soc/amd/acp/acp-mach-common.c
@@ -86,13 +86,6 @@ static int acp_card_rt5682_init(struct snd_soc_pcm_runtime *rtd)
 	if (drvdata->hs_codec_id != RT5682)
 		return -EINVAL;
 
-	ret =  snd_soc_dai_set_fmt(codec_dai, SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF
-				   | SND_SOC_DAIFMT_CBP_CFP);
-	if (ret < 0) {
-		dev_err(rtd->card->dev, "Failed to set dai fmt: %d\n", ret);
-		return ret;
-	}
-
 	ret = snd_soc_dai_set_pll(codec_dai, RT5682_PLL2, RT5682_PLL2_S_MCLK,
 				  PCO_PLAT_CLK, RT5682_PLL_FREQ);
 	if (ret < 0) {
@@ -148,19 +141,7 @@ static int acp_card_hs_startup(struct snd_pcm_substream *substream)
 	struct snd_soc_card *card = rtd->card;
 	struct acp_card_drvdata *drvdata = card->drvdata;
 	struct snd_soc_dai *codec_dai = asoc_rtd_to_codec(rtd, 0);
-	int ret;
-	unsigned int fmt;
-
-	if (drvdata->soc_mclk)
-		fmt = SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF | SND_SOC_DAIFMT_CBC_CFC;
-	else
-		fmt = SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF | SND_SOC_DAIFMT_CBP_CFP;
-
-	ret =  snd_soc_dai_set_fmt(codec_dai, fmt);
-	if (ret < 0) {
-		dev_err(rtd->card->dev, "Failed to set dai fmt: %d\n", ret);
-		return ret;
-	}
+	int ret = 0;
 
 	runtime->hw.channels_max = DUAL_CHANNEL;
 	snd_pcm_hw_constraint_list(runtime, 0, SNDRV_PCM_HW_PARAM_CHANNELS,
@@ -191,9 +172,41 @@ static void acp_card_shutdown(struct snd_pcm_substream *substream)
 		clk_disable_unprepare(drvdata->wclk);
 }
 
+static int acp_card_rt5682x_hw_params(struct snd_pcm_substream *substream,
+				      struct snd_pcm_hw_params *params)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_card *card = rtd->card;
+	struct acp_card_drvdata *drvdata = card->drvdata;
+	struct snd_soc_dai *codec_dai = asoc_rtd_to_codec(rtd, 0);
+	struct snd_soc_dai *cpu_dai = asoc_rtd_to_cpu(rtd, 0);
+	int ret;
+	unsigned int fmt;
+
+	if (drvdata->soc_mclk)
+		fmt = SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF | SND_SOC_DAIFMT_CBC_CFC;
+	else
+		fmt = SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF | SND_SOC_DAIFMT_CBP_CFP;
+
+	ret = snd_soc_dai_set_fmt(cpu_dai, fmt);
+	if (ret && ret != -ENOTSUPP) {
+		dev_err(rtd->dev, "Failed to set dai fmt: %d\n", ret);
+		return ret;
+	}
+
+	ret =  snd_soc_dai_set_fmt(codec_dai, fmt);
+	if (ret < 0) {
+		dev_err(rtd->card->dev, "Failed to set dai fmt: %d\n", ret);
+		return ret;
+	}
+
+	return 0;
+}
+
 static const struct snd_soc_ops acp_card_rt5682_ops = {
 	.startup = acp_card_hs_startup,
 	.shutdown = acp_card_shutdown,
+	.hw_params = acp_card_rt5682x_hw_params,
 };
 
 /* Define RT5682S CODEC component*/
@@ -212,7 +225,6 @@ static int acp_card_rt5682s_init(struct snd_soc_pcm_runtime *rtd)
 	struct acp_card_drvdata *drvdata = card->drvdata;
 	struct snd_soc_dai *codec_dai = asoc_rtd_to_codec(rtd, 0);
 	struct snd_soc_component *component = codec_dai->component;
-	unsigned int fmt;
 	int ret;
 
 	dev_info(rtd->dev, "codec dai name = %s\n", codec_dai->name);
@@ -220,17 +232,6 @@ static int acp_card_rt5682s_init(struct snd_soc_pcm_runtime *rtd)
 	if (drvdata->hs_codec_id != RT5682S)
 		return -EINVAL;
 
-	if (drvdata->soc_mclk)
-		fmt = SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF | SND_SOC_DAIFMT_CBC_CFC;
-	else
-		fmt = SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF | SND_SOC_DAIFMT_CBP_CFP;
-
-	ret =  snd_soc_dai_set_fmt(codec_dai, fmt);
-	if (ret < 0) {
-		dev_err(rtd->card->dev, "Failed to set dai fmt: %d\n", ret);
-		return ret;
-	}
-
 	ret = snd_soc_dai_set_pll(codec_dai, RT5682S_PLL2, RT5682S_PLL_S_MCLK,
 				  PCO_PLAT_CLK, RT5682_PLL_FREQ);
 	if (ret < 0) {
@@ -283,6 +284,7 @@ static int acp_card_rt5682s_init(struct snd_soc_pcm_runtime *rtd)
 
 static const struct snd_soc_ops acp_card_rt5682s_ops = {
 	.startup = acp_card_hs_startup,
+	.hw_params = acp_card_rt5682x_hw_params,
 };
 
 static const unsigned int dmic_channels[] = {
@@ -351,8 +353,9 @@ static int acp_card_rt1019_hw_params(struct snd_pcm_substream *substream,
 	struct snd_soc_card *card = rtd->card;
 	struct acp_card_drvdata *drvdata = card->drvdata;
 	struct snd_soc_dai *codec_dai;
+	struct snd_soc_dai *cpu_dai = asoc_rtd_to_cpu(rtd, 0);
 	int srate, i, ret = 0;
-	unsigned int ch, format;
+	unsigned int ch, format, fmt;
 
 	srate = params_rate(params);
 	ch = params_channels(params);
@@ -361,6 +364,17 @@ static int acp_card_rt1019_hw_params(struct snd_pcm_substream *substream,
 	if (drvdata->amp_codec_id != RT1019)
 		return -EINVAL;
 
+	if (drvdata->soc_mclk)
+		fmt = SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF | SND_SOC_DAIFMT_CBC_CFC;
+	else
+		fmt = SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF | SND_SOC_DAIFMT_CBP_CFP;
+
+	ret = snd_soc_dai_set_fmt(cpu_dai, fmt);
+	if (ret && ret != -ENOTSUPP) {
+		dev_err(rtd->dev, "Failed to set dai fmt: %d\n", ret);
+		return ret;
+	}
+
 	for_each_rtd_codec_dais(rtd, i, codec_dai) {
 		if (strcmp(codec_dai->name, "rt1019-aif"))
 			continue;
@@ -429,9 +443,31 @@ static int acp_card_maxim_init(struct snd_soc_pcm_runtime *rtd)
 				       ARRAY_SIZE(max98360a_map));
 }
 
+static int acp_card_maxim_hw_params(struct snd_pcm_substream *substream,
+				    struct snd_pcm_hw_params *params)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_dai *cpu_dai = asoc_rtd_to_cpu(rtd, 0);
+	unsigned int fmt;
+	int ret;
+
+	if (drvdata->soc_mclk)
+		fmt = SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF | SND_SOC_DAIFMT_CBC_CFC;
+	else
+		fmt = SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF | SND_SOC_DAIFMT_CBP_CFP;
+
+	ret = snd_soc_dai_set_fmt(cpu_dai, fmt);
+	if (ret && ret != -ENOTSUPP) {
+		dev_err(rtd->dev, "Failed to set dai fmt: %d\n", ret);
+		return ret;
+	}
+	return 0;
+}
+
 static const struct snd_soc_ops acp_card_maxim_ops = {
 	.startup = acp_card_amp_startup,
 	.shutdown = acp_card_shutdown,
+	.hw_params = acp_card_maxim_hw_params,
 };
 
 /* Declare nau8825 codec components */
@@ -449,7 +485,6 @@ static int acp_card_nau8825_init(struct snd_soc_pcm_runtime *rtd)
 	struct acp_card_drvdata *drvdata = card->drvdata;
 	struct snd_soc_dai *codec_dai = asoc_rtd_to_codec(rtd, 0);
 	struct snd_soc_component *component = codec_dai->component;
-	unsigned int fmt;
 	int ret;
 
 	dev_info(rtd->dev, "codec dai name = %s\n", codec_dai->name);
@@ -457,16 +492,6 @@ static int acp_card_nau8825_init(struct snd_soc_pcm_runtime *rtd)
 	if (drvdata->hs_codec_id != NAU8825)
 		return -EINVAL;
 
-	if (drvdata->soc_mclk)
-		fmt = SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF | SND_SOC_DAIFMT_CBC_CFC;
-	else
-		fmt = SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF | SND_SOC_DAIFMT_CBP_CFP;
-
-	ret =  snd_soc_dai_set_fmt(codec_dai, fmt);
-	if (ret < 0) {
-		dev_err(rtd->card->dev, "Failed to set dai fmt: %d\n", ret);
-		return ret;
-	}
 	ret = snd_soc_card_jack_new(card, "Headset Jack",
 					 SND_JACK_HEADSET | SND_JACK_LINEOUT |
 					 SND_JACK_BTN_0 | SND_JACK_BTN_1 |
@@ -495,8 +520,12 @@ static int acp_nau8825_hw_params(struct snd_pcm_substream *substream,
 				 struct snd_pcm_hw_params *params)
 {
 	struct snd_soc_pcm_runtime *rtd = asoc_substream_to_rtd(substream);
+	struct snd_soc_card *card = rtd->card;
+	struct acp_card_drvdata *drvdata = card->drvdata;
 	struct snd_soc_dai *codec_dai = asoc_rtd_to_codec(rtd, 0);
+	struct snd_soc_dai *cpu_dai = asoc_rtd_to_cpu(rtd, 0);
 	int ret;
+	unsigned int fmt;
 
 	ret = snd_soc_dai_set_sysclk(codec_dai, NAU8825_CLK_FLL_FS,
 				     (48000 * 256), SND_SOC_CLOCK_IN);
@@ -510,6 +539,23 @@ static int acp_nau8825_hw_params(struct snd_pcm_substream *substream,
 		return ret;
 	}
 
+	if (drvdata->soc_mclk)
+		fmt = SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF | SND_SOC_DAIFMT_CBC_CFC;
+	else
+		fmt = SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF | SND_SOC_DAIFMT_CBP_CFP;
+
+	ret = snd_soc_dai_set_fmt(cpu_dai, fmt);
+	if (ret && ret != -ENOTSUPP) {
+		dev_err(rtd->dev, "Failed to set dai fmt: %d\n", ret);
+		return ret;
+	}
+
+	ret =  snd_soc_dai_set_fmt(codec_dai, fmt);
+	if (ret < 0) {
+		dev_err(rtd->card->dev, "Failed to set dai fmt: %d\n", ret);
+		return ret;
+	}
+
 	return ret;
 }
 
-- 
2.25.1

