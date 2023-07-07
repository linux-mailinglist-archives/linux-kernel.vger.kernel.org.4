Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA02A74B071
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 14:08:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231421AbjGGMH5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 08:07:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229631AbjGGMHz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 08:07:55 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2074.outbound.protection.outlook.com [40.107.212.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27628210C
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jul 2023 05:07:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jr/hb+tfEa+FYvBKEkQnwQig3df2tvJ5VlAz1rrxXG/0lILi8UJk7NOtUevBEfYT2ZWXeBOCUv5+8nafzjcJR29UE4uXDg6u89581GFCg5Bf2zcwlicQC2BUadOwZ4h5cYFOQSmDFFyrUHj9Qu9AFbRpQodOCLh557IBVn7LVkm66lFyoRxaguXM9kWqN1xG8lApCQ5/w+xT0BVkz8sT1Fco5803GJVN3T/vy70yWSA+iEt2ZQdzCknjSZgVOsjs0NoHS7vGC4thasBYJFaan2U11VkgeGz9jAlKM/1xQ7+YwitZDXfC1znUB0rhJytMXMZ4zYXdrrpTXf/9hE7fLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PNdmyhn7zUaGrD9Lw16oYD+BcahXH7C57xq5kGjUVho=;
 b=BEH36JoZ5gCyjSgeS0N1rCkXXMK07nGeTJfQy5C8+v912FkKo/k6udtcXWvNqtFvo5psfPMiKczTrHwRJXeAK50Yzn925aiyTBP2Mo0t6zc17kTnASXPp6H7ncGrQwtC1YXFcfURAmDCO/N1Aboy5NNLwY3n32nC5tVvd26azB/+oQBj9J/FyBhk4wOrWaRj5OJC2Ly4drzeMj+2E0nSDPhroG/ccQKz707Uz7PMniYnTAH68FTFIAcZUDVNZVHTucVPAZHbuXq+mCf+6o1gIButEN8f2QXHVx5SHofso6/xr8LRXpshPiSOjkU56Z/NlfncFgGmUjX1iAmqYEUG0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PNdmyhn7zUaGrD9Lw16oYD+BcahXH7C57xq5kGjUVho=;
 b=BSX72JtobmQxgeUMbYVK7Z//jzaKa5Py0fEY5fHO8Yi4gdnzL70wSXjSdMHHdyUUuzEfbRB6naxxicLGEjOcUr1Yf+h0YzwkE82qMh4CPlNg8+e963hDm1GrDjRUA/nHKbIt8K1Z8duNJ0ANo/aB1A4RQg896I8LrVEpetAZHjk=
Received: from MW4PR03CA0331.namprd03.prod.outlook.com (2603:10b6:303:dc::6)
 by CH0PR12MB5203.namprd12.prod.outlook.com (2603:10b6:610:ba::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.25; Fri, 7 Jul
 2023 12:07:49 +0000
Received: from CO1NAM11FT111.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:dc:cafe::4b) by MW4PR03CA0331.outlook.office365.com
 (2603:10b6:303:dc::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.25 via Frontend
 Transport; Fri, 7 Jul 2023 12:07:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT111.mail.protection.outlook.com (10.13.174.61) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6500.47 via Frontend Transport; Fri, 7 Jul 2023 12:07:49 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Fri, 7 Jul
 2023 07:07:48 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Fri, 7 Jul 2023
 05:07:48 -0700
Received: from amd-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.23
 via Frontend Transport; Fri, 7 Jul 2023 07:07:38 -0500
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
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
        ye xingchen <ye.xingchen@zte.com.cn>,
        "open list" <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/4] ASoC: amd: acp: Add machine driver support for nau8821 codec
Date:   Fri, 7 Jul 2023 17:37:27 +0530
Message-ID: <20230707120730.1948445-2-venkataprasad.potturu@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230707120730.1948445-1-venkataprasad.potturu@amd.com>
References: <20230707120730.1948445-1-venkataprasad.potturu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT111:EE_|CH0PR12MB5203:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b62d635-1c57-4990-3677-08db7ee2c868
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ex8tNdNyTRg2Zjj27pvcOB30rqaf7c3j60zY4tvKqogXF6r7gu0GLTone2XUmXQifFEyiUaMczRh4Vr3HCl1q3pTveNf05FrT9Y81SMnvrNRyexo6sM6A+XM2YT3nnfY31W6WQTYQnZrhzGI4DjBYZCkxABWIYvNlHc5qFXnYTIUqAz+eCn22hUt2mTqRWvnjFkvELGmhDSCcikOkJcELAVzIvs6UNi2sFvnQvoRpnZ1zCuPA+J/7ZDJhThsH/xV8xciAOzZE55uX1I0Y14Nwas4+iI6jC5tPYbjWxT0dEPQt8hyOxSLOhSh0oGPGgJelOxEmZGSZB/xGrSeP+krUrQgICrsEcnMnnjGtqdpaozHo/jj1C0hDuEgf6TDD91sACtiydNBmsN0Qu+m0BhFAD1DIsO4rDdNZrLjGnguxgxhd/+lIKrDTX3F19t4P3DKfw7n85YsZMv9jVhvA/y5/6TdwqsWYh63yEQmwtEbYw5anOFrNCgUlRuordsVqPAYEVA8rNQ/+N0DJb7tAcN3jgnKTqgT5pTUADCJxYmfAOPSrZ+S4F1nCqWNQ8Kom30qu0SmsxIkwCegp/3rzbTIFYFrsAPCACeon3tLQW049WeoVEoY3viKq+mKEVLn+TvpqrU4sa0H9PPNU1d6y/VmmHgVVYOv92k/AdmYjJB/eUJxJijqMXX0C1fHjb22KLoBF8FS4Ch+qLCXUE6w2Bj/eSbWg1vUJOTAStAXBVPBkay00qc82F32/wwzWynjEFyxFLkUIpdjcviTJVGOcN8uUA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(346002)(39860400002)(136003)(451199021)(36840700001)(46966006)(40470700004)(40460700003)(70206006)(70586007)(82740400003)(4326008)(2616005)(81166007)(356005)(82310400005)(186003)(336012)(86362001)(26005)(1076003)(36860700001)(83380400001)(47076005)(426003)(36756003)(6666004)(478600001)(7696005)(40480700001)(110136005)(54906003)(41300700001)(5660300002)(8936002)(8676002)(2906002)(316002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2023 12:07:49.1476
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b62d635-1c57-4990-3677-08db7ee2c868
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT111.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5203
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

In newer variants nau8821 as primary codec. Add support for nau8821
codec in generic machine driver.

Signed-off-by: Venkata Prasad Potturu <venkataprasad.potturu@amd.com>
---
 sound/soc/amd/acp/Kconfig           |   1 +
 sound/soc/amd/acp/acp-mach-common.c | 167 ++++++++++++++++++++++++++++
 sound/soc/amd/acp/acp-mach.h        |   1 +
 3 files changed, 169 insertions(+)

diff --git a/sound/soc/amd/acp/Kconfig b/sound/soc/amd/acp/Kconfig
index ce0037810743..a68bbe106b73 100644
--- a/sound/soc/amd/acp/Kconfig
+++ b/sound/soc/amd/acp/Kconfig
@@ -61,6 +61,7 @@ config SND_SOC_AMD_MACH_COMMON
 	select SND_SOC_MAX98357A
 	select SND_SOC_RT5682S
 	select SND_SOC_NAU8825
+	select SND_SOC_NAU8821
 	help
 	  This option enables common Machine driver module for ACP.
 
diff --git a/sound/soc/amd/acp/acp-mach-common.c b/sound/soc/amd/acp/acp-mach-common.c
index 6da17140beea..48abb8e9665d 100644
--- a/sound/soc/amd/acp/acp-mach-common.c
+++ b/sound/soc/amd/acp/acp-mach-common.c
@@ -25,12 +25,17 @@
 #include "../../codecs/rt1019.h"
 #include "../../codecs/rt5682s.h"
 #include "../../codecs/nau8825.h"
+#include "../../codecs/nau8821.h"
 #include "acp-mach.h"
 
+static struct snd_soc_jack vg_headset;
 #define PCO_PLAT_CLK 48000000
 #define RT5682_PLL_FREQ (48000 * 512)
 #define DUAL_CHANNEL	2
 #define FOUR_CHANNEL	4
+#define NAU8821_CODEC_DAI	"nau8821-hifi"
+#define NAU8821_BCLK		1536000
+#define NAU8821_FREQ_OUT	12288000
 
 #define TDM_MODE_ENABLE 1
 
@@ -790,6 +795,162 @@ static const struct snd_soc_ops acp_card_nau8825_ops = {
 	.hw_params = acp_nau8825_hw_params,
 };
 
+static int platform_clock_control(struct snd_soc_dapm_widget *w,
+				  struct snd_kcontrol *k, int  event)
+{
+	struct snd_soc_dapm_context *dapm = w->dapm;
+	struct snd_soc_card *card = dapm->card;
+	struct snd_soc_dai *codec_dai;
+	int ret = 0;
+
+	codec_dai = snd_soc_card_get_codec_dai(card, NAU8821_CODEC_DAI);
+	if (!codec_dai) {
+		dev_err(card->dev, "Codec dai not found\n");
+		return -EIO;
+	}
+
+	if (SND_SOC_DAPM_EVENT_OFF(event)) {
+		ret = snd_soc_dai_set_sysclk(codec_dai, NAU8821_CLK_INTERNAL,
+					     0, SND_SOC_CLOCK_IN);
+		if (ret < 0) {
+			dev_err(card->dev, "set sysclk err = %d\n", ret);
+			return -EIO;
+		}
+	} else {
+		ret = snd_soc_dai_set_sysclk(codec_dai, NAU8821_CLK_FLL_BLK, 0,
+					     SND_SOC_CLOCK_IN);
+		if (ret < 0)
+			dev_err(codec_dai->dev, "can't set FS clock %d\n", ret);
+		ret = snd_soc_dai_set_pll(codec_dai, 0, 0, NAU8821_BCLK,
+					  NAU8821_FREQ_OUT);
+		if (ret < 0)
+			dev_err(codec_dai->dev, "can't set FLL: %d\n", ret);
+	}
+	return ret;
+}
+
+static const struct snd_soc_dapm_widget nau8821_widgets[] = {
+	SND_SOC_DAPM_HP("Headphone jack", NULL),
+	SND_SOC_DAPM_MIC("Headset Mic", NULL),
+	SND_SOC_DAPM_MIC("Int Mic", NULL),
+	SND_SOC_DAPM_SUPPLY("Platform Clock", SND_SOC_NOPM, 0, 0,
+			    platform_clock_control, SND_SOC_DAPM_PRE_PMU |
+			    SND_SOC_DAPM_POST_PMD),
+};
+
+static const struct snd_soc_dapm_route nau8821_audio_route[] = {
+	/* HP jack connectors - unknown if we have jack detection */
+	{ "Headphone jack", NULL, "HPOL" },
+	{ "Headphone jack", NULL, "HPOR" },
+	{ "MICL", NULL, "Headset Mic" },
+	{ "MICR", NULL, "Headset Mic" },
+	{ "DMIC", NULL, "Int Mic" },
+	{ "Headphone jack", NULL, "Platform Clock" },
+	{ "Headset Mic", NULL, "Platform Clock" },
+	{ "Int Mic", NULL, "Platform Clock" },
+};
+
+static const unsigned int nau8821_format[] = {16};
+
+static struct snd_pcm_hw_constraint_list constraints_sample_bits = {
+	.list = nau8821_format,
+	.count = ARRAY_SIZE(nau8821_format),
+};
+
+static int acp_8821_init(struct snd_soc_pcm_runtime *rtd)
+{
+	struct snd_soc_card *card = rtd->card;
+	struct snd_soc_dai *codec_dai = asoc_rtd_to_codec(rtd, 0);
+	struct snd_soc_component *component = codec_dai->component;
+	int ret;
+
+	dev_info(rtd->dev, "codec dai name = %s\n", codec_dai->name);
+
+	ret = snd_soc_dapm_new_controls(&card->dapm, nau8821_widgets,
+					ARRAY_SIZE(nau8821_widgets));
+	if (ret) {
+		dev_err(rtd->dev, "unable to add widget dapm controls, ret %d\n", ret);
+		// Don't need to add routes if widget addition failed
+		return ret;
+	}
+
+	ret = snd_soc_card_jack_new(card, "Headset Jack",
+				    SND_JACK_HEADSET | SND_JACK_LINEOUT |
+				    SND_JACK_BTN_0 | SND_JACK_BTN_1 |
+				    SND_JACK_BTN_2 | SND_JACK_BTN_3,
+				    &vg_headset);
+	if (ret) {
+		dev_err(rtd->dev, "Headset Jack creation failed %d\n", ret);
+		return ret;
+	}
+	snd_jack_set_key(vg_headset.jack, SND_JACK_BTN_0, KEY_PLAYPAUSE);
+	snd_jack_set_key(vg_headset.jack, SND_JACK_BTN_1, KEY_VOICECOMMAND);
+	snd_jack_set_key(vg_headset.jack, SND_JACK_BTN_2, KEY_VOLUMEUP);
+	snd_jack_set_key(vg_headset.jack, SND_JACK_BTN_3, KEY_VOLUMEDOWN);
+
+	nau8821_enable_jack_detect(component, &vg_headset);
+
+	return snd_soc_dapm_add_routes(&rtd->card->dapm, nau8821_audio_route,
+				       ARRAY_SIZE(nau8821_audio_route));
+}
+
+static int acp_8821_startup(struct snd_pcm_substream *substream)
+{
+	struct snd_pcm_runtime *runtime = substream->runtime;
+
+	runtime->hw.channels_max = DUAL_CHANNEL;
+	snd_pcm_hw_constraint_list(runtime, 0, SNDRV_PCM_HW_PARAM_CHANNELS,
+				   &constraints_channels);
+	snd_pcm_hw_constraint_list(runtime, 0, SNDRV_PCM_HW_PARAM_RATE,
+				   &constraints_rates);
+	snd_pcm_hw_constraint_list(substream->runtime, 0,
+				   SNDRV_PCM_HW_PARAM_SAMPLE_BITS,
+				   &constraints_sample_bits);
+	return 0;
+}
+
+static int acp_nau8821_hw_params(struct snd_pcm_substream *substream,
+				 struct snd_pcm_hw_params *params)
+{
+	struct snd_soc_pcm_runtime *rtd = asoc_substream_to_rtd(substream);
+	struct snd_soc_card *card = rtd->card;
+	struct acp_card_drvdata *drvdata = card->drvdata;
+	struct snd_soc_dai *codec_dai = asoc_rtd_to_codec(rtd, 0);
+	int ret;
+	unsigned int fmt;
+
+	if (drvdata->soc_mclk)
+		fmt = SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF | SND_SOC_DAIFMT_CBC_CFC;
+	else
+		fmt = SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF | SND_SOC_DAIFMT_CBP_CFP;
+
+	ret =  snd_soc_dai_set_fmt(codec_dai, fmt);
+	if (ret < 0) {
+		dev_err(rtd->card->dev, "Failed to set dai fmt: %d\n", ret);
+		return ret;
+	}
+
+	ret = snd_soc_dai_set_sysclk(codec_dai, NAU8821_CLK_FLL_BLK, 0,
+				     SND_SOC_CLOCK_IN);
+	if (ret < 0)
+		dev_err(card->dev, "can't set FS clock %d\n", ret);
+	ret = snd_soc_dai_set_pll(codec_dai, 0, 0, snd_soc_params_to_bclk(params),
+				  params_rate(params) * 256);
+	if (ret < 0)
+		dev_err(card->dev, "can't set FLL: %d\n", ret);
+
+	return ret;
+}
+
+static const struct snd_soc_ops acp_8821_ops = {
+	.startup = acp_8821_startup,
+	.hw_params = acp_nau8821_hw_params,
+};
+
+SND_SOC_DAILINK_DEF(nau8821,
+		    DAILINK_COMP_ARRAY(COMP_CODEC("i2c-NVTN2020:00",
+						  "nau8821-hifi")));
+
 /* Declare DMIC codec components */
 SND_SOC_DAILINK_DEF(dmic_codec,
 		DAILINK_COMP_ARRAY(COMP_CODEC("dmic-codec", "dmic-hifi")));
@@ -920,6 +1081,12 @@ int acp_sofdsp_dai_links_create(struct snd_soc_card *card)
 			links[i].init = acp_card_rt5682s_init;
 			links[i].ops = &acp_card_rt5682s_ops;
 		}
+		if (drv_data->hs_codec_id == NAU8821) {
+			links[i].codecs = nau8821;
+			links[i].num_codecs = ARRAY_SIZE(nau8821);
+			links[i].init = acp_8821_init;
+			links[i].ops = &acp_8821_ops;
+		}
 		i++;
 	}
 
diff --git a/sound/soc/amd/acp/acp-mach.h b/sound/soc/amd/acp/acp-mach.h
index 165f407697c0..f2b44a6189a6 100644
--- a/sound/soc/amd/acp/acp-mach.h
+++ b/sound/soc/amd/acp/acp-mach.h
@@ -41,6 +41,7 @@ enum codec_endpoints {
 	MAX98360A,
 	RT5682S,
 	NAU8825,
+	NAU8821,
 };
 
 enum platform_end_point {
-- 
2.25.1

