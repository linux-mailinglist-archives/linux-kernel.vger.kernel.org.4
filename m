Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2C006626B5
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 14:17:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236801AbjAINRc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 08:17:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236362AbjAINR0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 08:17:26 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2057.outbound.protection.outlook.com [40.107.223.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C1F7B1FF
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 05:17:25 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D3HlNjK0SvGf0rfDHbnkEIEOxzfHqsnvEy3x02Z32QaaBoXfu2AwRg/1EE/aMemhCQEwP8/Ni5Uq0PFZIP33tlKbZirPsORnUTkkqrpXdAZJ6d7VaCZ4CPcHNZ/88yeeLi569DdN3BO9tKqV8UVIou8vabMkgCdbhc31KsDWdtKL2/MuBj6QC1zqxHI9sULTPlWCJwiDpHzLjIj580M8D+gYlq8yFsIaQu0OnQQSamd1/qw027jZbyrMDJTsTowqhNOHqkwD1u9D10vUqDK/tkxrE/JjCJ6rEG32/ywjbvPZR9lghI+DJ/MXfszUvANCl+szFpQ71rRC3pYhqFOVQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RfclZNvBHapvGE/Y3fHTq9addqDu8tBou8Um1F8nuFY=;
 b=TJulgxnBkrPreF/8T3UY62J9zEuAu8Ppv61jqnIoZeXQ8WploRUocrzrV/uCa/BcxDGTUC+byN9d0xZD8ogYA3fKmBuKNmeVtUSGvbJAYkOiUdcostcMpZk36k3cB/H6WswL27x16RE2Lvy7n7J2b84S5U1n21zorMpGzllgAOeqkflKklnFKEdArPNzMfoGDyGjN/ajWE+d2wqx08m3MymHo5MVx+vvch1N8JAqOTJuDSqIoAUTOUSQtX847D99KoBZZwk1tPEkN5M3Vss/tQpaIvykbID+NFoSmyQUa4RKj/dg6pPvsvMQbEF3opxX13oZgRXhUQh0+ti/n2m1Ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RfclZNvBHapvGE/Y3fHTq9addqDu8tBou8Um1F8nuFY=;
 b=UFFkl8yw7HeODY030eVnSm3WAvfYjYltacs2X+aB/FlrOretz131mODJTxP32vo2E0AZnilTvMTV1rkA+9GxqqW7vWu2Y56z0JTR7Cm+k4Lo3WNOBfIIADxKTruG+sTOl1jKDRLvYydPnhdZfhCM81C+lOtTxeN+X59ozhSFQyg=
Received: from DM6PR02CA0046.namprd02.prod.outlook.com (2603:10b6:5:177::23)
 by SA0PR12MB4461.namprd12.prod.outlook.com (2603:10b6:806:9c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Mon, 9 Jan
 2023 13:17:22 +0000
Received: from DM6NAM11FT049.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:177:cafe::4f) by DM6PR02CA0046.outlook.office365.com
 (2603:10b6:5:177::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18 via Frontend
 Transport; Mon, 9 Jan 2023 13:17:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT049.mail.protection.outlook.com (10.13.172.188) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5986.18 via Frontend Transport; Mon, 9 Jan 2023 13:17:22 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 9 Jan
 2023 07:17:13 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 9 Jan
 2023 07:17:13 -0600
Received: from amd-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.34
 via Frontend Transport; Mon, 9 Jan 2023 07:17:03 -0600
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
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 2/5] ASoC: amd: acp: Refactor dai format implementation
Date:   Mon, 9 Jan 2023 18:51:01 +0530
Message-ID: <20230109132104.1259479-3-venkataprasad.potturu@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230109132104.1259479-1-venkataprasad.potturu@amd.com>
References: <20230109132104.1259479-1-venkataprasad.potturu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT049:EE_|SA0PR12MB4461:EE_
X-MS-Office365-Filtering-Correlation-Id: 42a378de-1a6a-4c44-7191-08daf243d7eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VW6WfOAKAh+hbzcrNJCUZYhK6pJlaXHEVvh6WlaZAvhhJiTnhH/huhKnye44peohg8NKo6y1/jYs6/M/mPsTSVHXcEGrgPS9FP96WkPRinnAw//LiT/cg9SfILoFOzBfVFL50qFAwWO/lUfq0YgWFvJfhPgPIY7XMaV9Vt24Y7tl9bCXeaQ4aVZHY6jYV50Xr7pjb9NexLVnCXu2rsca56w4UCZ5HAvhr/68ZurTboQP9bvBVMu0q04sKazc2RSc5SxqmSGinACir12NJiqgRGm5iJzctpmesGW5DhrHEUAxqJboYpORvzQDaL+BrVS/m2/T05kJFC8HHRD9mX4j1BHdVgQOn8gqJgQ8xqYH8CCb+qfbFY7iDo9NzUnjCGqXlElfws7wdET9rTjZ0WpNddKioPGmp8EkRNbawfxrsMf131k4+MytJKpV/FE6v2SbYj73ifFrU8657StzhK6FkyWX+4Wm3Q0vXlxIKbzMBPabtztdU9yeYNIByh85GkWN/+57/baWvPvxpZq2pBPFIE+54gXxMhERUfftGvibUSdwaEAzqXyMGG+HZONX4YqT7nSV2Og1D0UXQ9e5A8McLeoBX+gj8kyakzOLhGs/DGCHRUmULGjrkK55MimtS6k38caQXYHmSi17jDqEQMxz2WT2XozWaRk7QMcVx1lBm9dRYAETaQ/FbTRqxiV00FFZDqGLmGK+YE+C1xmbQimB4NTBm2qVpDV2mBq3Gzn2IW8=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(136003)(396003)(376002)(346002)(451199015)(36840700001)(46966006)(40470700004)(82310400005)(41300700001)(8936002)(36756003)(5660300002)(2906002)(8676002)(70586007)(70206006)(316002)(7696005)(110136005)(54906003)(47076005)(40480700001)(478600001)(26005)(336012)(4326008)(186003)(2616005)(1076003)(426003)(40460700003)(86362001)(83380400001)(36860700001)(82740400003)(81166007)(356005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2023 13:17:22.4514
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 42a378de-1a6a-4c44-7191-08daf243d7eb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT049.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4461
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
 sound/soc/amd/acp/acp-mach-common.c | 152 ++++++++++++++++++++++------
 1 file changed, 122 insertions(+), 30 deletions(-)

diff --git a/sound/soc/amd/acp/acp-mach-common.c b/sound/soc/amd/acp/acp-mach-common.c
index 86fc5ec5ea08..75beb6e41e99 100644
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
@@ -191,9 +184,41 @@ static void acp_card_shutdown(struct snd_pcm_substream *substream)
 		clk_disable_unprepare(drvdata->wclk);
 }
 
+static int acp_card_rt5682_hw_params(struct snd_pcm_substream *substream,
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
+	.hw_params = acp_card_rt5682_hw_params,
 };
 
 /* Define RT5682S CODEC component*/
@@ -212,7 +237,6 @@ static int acp_card_rt5682s_init(struct snd_soc_pcm_runtime *rtd)
 	struct acp_card_drvdata *drvdata = card->drvdata;
 	struct snd_soc_dai *codec_dai = asoc_rtd_to_codec(rtd, 0);
 	struct snd_soc_component *component = codec_dai->component;
-	unsigned int fmt;
 	int ret;
 
 	dev_info(rtd->dev, "codec dai name = %s\n", codec_dai->name);
@@ -220,17 +244,6 @@ static int acp_card_rt5682s_init(struct snd_soc_pcm_runtime *rtd)
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
@@ -281,8 +294,40 @@ static int acp_card_rt5682s_init(struct snd_soc_pcm_runtime *rtd)
 	return snd_soc_dapm_add_routes(&rtd->card->dapm, rt5682s_map, ARRAY_SIZE(rt5682s_map));
 }
 
+static int acp_card_rt5682s_hw_params(struct snd_pcm_substream *substream,
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
 static const struct snd_soc_ops acp_card_rt5682s_ops = {
 	.startup = acp_card_hs_startup,
+	.hw_params = acp_card_rt5682s_hw_params,
 };
 
 static const unsigned int dmic_channels[] = {
@@ -351,13 +396,26 @@ static int acp_card_rt1019_hw_params(struct snd_pcm_substream *substream,
 	struct snd_soc_card *card = rtd->card;
 	struct acp_card_drvdata *drvdata = card->drvdata;
 	struct snd_soc_dai *codec_dai;
+	struct snd_soc_dai *cpu_dai = asoc_rtd_to_cpu(rtd, 0);
 	int srate, i, ret = 0;
+	unsigned int fmt;
 
 	srate = params_rate(params);
 
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
@@ -426,9 +484,33 @@ static int acp_card_maxim_init(struct snd_soc_pcm_runtime *rtd)
 				       ARRAY_SIZE(max98360a_map));
 }
 
+static int acp_card_maxim_hw_params(struct snd_pcm_substream *substream,
+				    struct snd_pcm_hw_params *params)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_card *card = rtd->card;
+	struct acp_card_drvdata *drvdata = card->drvdata;
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
@@ -446,7 +528,6 @@ static int acp_card_nau8825_init(struct snd_soc_pcm_runtime *rtd)
 	struct acp_card_drvdata *drvdata = card->drvdata;
 	struct snd_soc_dai *codec_dai = asoc_rtd_to_codec(rtd, 0);
 	struct snd_soc_component *component = codec_dai->component;
-	unsigned int fmt;
 	int ret;
 
 	dev_info(rtd->dev, "codec dai name = %s\n", codec_dai->name);
@@ -454,16 +535,6 @@ static int acp_card_nau8825_init(struct snd_soc_pcm_runtime *rtd)
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
@@ -492,8 +563,12 @@ static int acp_nau8825_hw_params(struct snd_pcm_substream *substream,
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
@@ -507,6 +582,23 @@ static int acp_nau8825_hw_params(struct snd_pcm_substream *substream,
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

