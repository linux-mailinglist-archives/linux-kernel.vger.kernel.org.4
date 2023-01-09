Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7350F6626B3
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 14:17:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236362AbjAINRu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 08:17:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236851AbjAINRr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 08:17:47 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2079.outbound.protection.outlook.com [40.107.243.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2E7F12D2D
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 05:17:43 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LObz/BHuUMJruTrr3HcuPgpp85680dqLgsHfeQmtNu4oZR/Va7uf8ZG8Rk8+cgqiRRZNF4yc6dvjnsifRgjVFrtH5P++YzwEB80QEQwK/4TkEmpT44cdCO0jXqffSVscyuLNOZJApypqMPw/I06bifDT3qIvIdDfl7mknVT2VIynYJAXJzRjhK2npNqwOWxjyL0J9+ihKqYBNl2yD1OQUS6Twv8x1AW+JvFM6AcKjfN8BYnUUB8wttEX4V/Or05X9fpDPS7/IPtnVQ5M5ujYBc9iIFC+MAm9oF8X0uVrJ6uYd/NCqgF1lLGX8iyUCrJuQxV4EM+lSzUuqzRmzfoiOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KwIsoUV4Xz78gOWvHzmRckn1ERz6f/Vf2/LsuwvslEs=;
 b=MdUtyrcIpMnDBYezeMxiRfGs9xlh149PNtZSspxk/Vorp7lY2tQorI83SswlAizk9Lx1hj4jaY/Q1gMmDIiNWOFgBxrQ+mtGbhtbx6qPcr6SDS0ABj8i3hi9jMLkB6Vj5SP1YRK85xs/hR93lnO+oScP2jj24Lg2ShJVKZL9BDueP6gIhv+0/zoo0/Xpgu1CQ0KbppsFWz+lvQZm5pDUjdiZhbOQx1p/WeJRemb3mu0rAa0JzNcfOGgnqLyHcOnVdvWLfAW8GRpcTbCLdZnALpMqT73DBE5chiraVy6aB12nd6/UaOydxx5qfqcCy73sNvXyuukMuYBfJDzJcG0u1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KwIsoUV4Xz78gOWvHzmRckn1ERz6f/Vf2/LsuwvslEs=;
 b=TgbOObhr0/RzLx/2dKgwm9NtY1+R/cb7b/K1lkULxyUdplvWQzfUc8yDxv259VkydpWY8gyevqRt/raDzHmQaAVlT4sxHdPQLmNCKein4OYh+A7qdyShZlaLePAqta2+Z8mp7UgQ/YfQSrbmUMv006jakeAroibFGMH8tuq557Q=
Received: from DM6PR04CA0001.namprd04.prod.outlook.com (2603:10b6:5:334::6) by
 DM6PR12MB4482.namprd12.prod.outlook.com (2603:10b6:5:2a8::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5986.18; Mon, 9 Jan 2023 13:17:38 +0000
Received: from DM6NAM11FT035.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:334:cafe::b2) by DM6PR04CA0001.outlook.office365.com
 (2603:10b6:5:334::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18 via Frontend
 Transport; Mon, 9 Jan 2023 13:17:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT035.mail.protection.outlook.com (10.13.172.100) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5986.18 via Frontend Transport; Mon, 9 Jan 2023 13:17:38 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 9 Jan
 2023 07:17:38 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 9 Jan
 2023 07:17:37 -0600
Received: from amd-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.34
 via Frontend Transport; Mon, 9 Jan 2023 07:17:28 -0600
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
        Jia-Ju Bai <baijiaju1990@gmail.com>,
        ye xingchen <ye.xingchen@zte.com.cn>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 4/5] ASoC: amd: acp: Add i2s tdm support in machine driver
Date:   Mon, 9 Jan 2023 18:51:03 +0530
Message-ID: <20230109132104.1259479-5-venkataprasad.potturu@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230109132104.1259479-1-venkataprasad.potturu@amd.com>
References: <20230109132104.1259479-1-venkataprasad.potturu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT035:EE_|DM6PR12MB4482:EE_
X-MS-Office365-Filtering-Correlation-Id: b6ecddeb-c89e-4b68-f825-08daf243e195
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YgS9uDMdOpg1Rh7bhV7fs/AbKVC+Wi77K3LoOsy3Dh/nU/9ta27EIQLECFiuvOE2dvtOklSMxerEE08pC34wsVjOcP9QnmNPKS/qfZIm/0ks47Q3A24Lu+ZPvWhd7/YVsYR+pR+pemPoyVTI/V2maCiftTJoE9Dc//vYMDkn9ir7raRrc9tWosIcTP0Gw8/6vRlI176Mp2TejnofdugcveJS/X3oK470h0vy2pobUuXgN1VHohxnXMDOxbgGPZcbU7XMXWBTsLQdeK7SSav1SDaroKDmBI7dn0xBxeRTq6jRd9GjQIvvT+oL7wBodCRtj7O2aNe2oRkicusdjVBmE4Mht5aM4LX39j8ulXaxJIerLDne84r2SBYYn3j8v3Ml3qhyJjEXOdZn4fuGaMMA2DDhB2jbSJ3ieo04JPxSU93LAGLtU5Ttq1vxYn3RiMRI2EV89N15tq1eawb+QXgzLun1wdOFKjHntV1tjsrbmnJyKZg8A/SIYY4403ZHvEpIgSxv2kSD8d0Sk1W2PyHgXWGR3PP5mAYG+0aDpj9QgfCEc4ngMOfmxox5Bp+gHgFuxYU+hxG5Hz6oKlaBWJhqv6FzII1bxQgx0NcTkz5yGScJxSV5AbJuQlzh0b4e8hF0Gkuulelkmkb80FE/u7Y3Qi0dPFXYzqay8v9sZ05p080+ojGaDJiRuOXekgkJm5SLKb/zeQ31miFhxIDsiP59mqRFNvdEWbWZTnRo3vxDt1Q=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(376002)(136003)(346002)(396003)(39860400002)(451199015)(40470700004)(46966006)(36840700001)(81166007)(41300700001)(36860700001)(30864003)(70586007)(70206006)(4326008)(8936002)(8676002)(5660300002)(82310400005)(356005)(83380400001)(7696005)(316002)(336012)(47076005)(426003)(1076003)(40480700001)(86362001)(2906002)(82740400003)(6666004)(478600001)(40460700003)(2616005)(54906003)(186003)(26005)(36756003)(110136005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2023 13:17:38.6997
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b6ecddeb-c89e-4b68-f825-08daf243e195
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT035.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4482
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add i2s tdm support for amd platforms.

Signed-off-by: Venkata Prasad Potturu <venkataprasad.potturu@amd.com>
---
 sound/soc/amd/acp/acp-legacy-mach.c |   5 +
 sound/soc/amd/acp/acp-mach-common.c | 162 +++++++++++++++++++++++++---
 sound/soc/amd/acp/acp-mach.h        |   3 +
 sound/soc/amd/acp/acp-sof-mach.c    |   6 ++
 4 files changed, 162 insertions(+), 14 deletions(-)

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
index 88c194902157..ffab6328baf0 100644
--- a/sound/soc/amd/acp/acp-mach-common.c
+++ b/sound/soc/amd/acp/acp-mach-common.c
@@ -124,10 +124,15 @@ static int acp_card_hs_startup(struct snd_pcm_substream *substream)
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
 
 	ret =  snd_soc_dai_set_fmt(codec_dai, fmt);
 	if (ret < 0) {
@@ -169,10 +174,15 @@ static int acp_card_rt5682_hw_params(struct snd_pcm_substream *substream,
 	ch = params_channels(params);
 	format = 8 * params_format(params);
 
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
@@ -186,6 +196,23 @@ static int acp_card_rt5682_hw_params(struct snd_pcm_substream *substream,
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
 	ret = snd_soc_dai_set_pll(codec_dai, RT5682_PLL2, RT5682_PLL2_S_MCLK,
 				  PCO_PLAT_CLK, RT5682_PLL_FREQ);
 	if (ret < 0) {
@@ -291,10 +318,15 @@ static int acp_card_rt5682s_hw_params(struct snd_pcm_substream *substream,
 	ch = params_channels(params);
 	format = 8 * params_format(params);
 
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
@@ -308,6 +340,23 @@ static int acp_card_rt5682s_hw_params(struct snd_pcm_substream *substream,
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
 	ret = snd_soc_dai_set_pll(codec_dai, RT5682S_PLL2, RT5682S_PLL_S_MCLK,
 				  PCO_PLAT_CLK, RT5682_PLL_FREQ);
 	if (ret < 0) {
@@ -417,10 +466,15 @@ static int acp_card_rt1019_hw_params(struct snd_pcm_substream *substream,
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
@@ -428,12 +482,28 @@ static int acp_card_rt1019_hw_params(struct snd_pcm_substream *substream,
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
+
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
 
@@ -441,6 +511,33 @@ static int acp_card_rt1019_hw_params(struct snd_pcm_substream *substream,
 					     256 * srate, SND_SOC_CLOCK_IN);
 		if (ret < 0)
 			return ret;
+
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
 	}
 
 	if (!drvdata->soc_mclk) {
@@ -507,10 +604,15 @@ static int acp_card_maxim_hw_params(struct snd_pcm_substream *substream,
 	ch = params_channels(params);
 	format = 8 * params_format(params);
 
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
@@ -518,6 +620,17 @@ static int acp_card_maxim_hw_params(struct snd_pcm_substream *substream,
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
+
 	if (!drvdata->soc_mclk) {
 		ret = acp_clk_enable(drvdata, srate, ch * format);
 		if (ret < 0) {
@@ -603,10 +716,15 @@ static int acp_nau8825_hw_params(struct snd_pcm_substream *substream,
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
@@ -620,6 +738,22 @@ static int acp_nau8825_hw_params(struct snd_pcm_substream *substream,
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

