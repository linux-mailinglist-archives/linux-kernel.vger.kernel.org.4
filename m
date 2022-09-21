Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B01C5BFA0E
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 11:04:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230247AbiIUJEr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 05:04:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230149AbiIUJEh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 05:04:37 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1anam02on2067.outbound.protection.outlook.com [40.107.96.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63B4F10A1
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 02:04:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LUAatbUXc2IEv/ICiIPZ7FyRxXB8/OG3xvh0Kc+It8eg+8y4Jw9q3adMYQIi8i+FB2a5H7Hc/6DiTEhjx0UHjiXOr+TBWQPlyLJkawREaD+Pou/a7Ax40jECWuxMmnR/Wp3onQ++wEv+6TbcwaKJ8cAZVSAOfGtJG5maNzH7OOG3jXi128U15m+6Y6GiLtxj4D8GxE84FZntW4krFt97GLTv+9gdIR4CJm5GBitULsN0BsGIIyZz6WbvF1t3IV6qze9LZEuw6/icYv9U8gIrLXARJ+EwooUzuz484jsfuc4ljRCFkTfVypwO5EPAnSERauC11d3u6eZfGjsvbSqveA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AOlvoD3TS2h5CgXe/v5JKQ/yb/nzawbVASZBO3Ok/Xg=;
 b=HtZtgePOfZHX0JjbjOX19p/CkgbpBCfcB1K40VL+imP22xDx1NsyiFtM7u8RzyRQyTyqy4JRRtbW95t12LsnaA680L289KSIriNn3Sgtxsz/lE6DpgT2yng5MkEgaDXgJqQD5ktxWB5yvLe/RTShIdAjUH43MKRW0KlVHag8D2Pf1eUjnhIJSjywJlqovG0gWBWWoVGcdDWEuIXHRZg9Tb18qtu0I0Ja4xAY0rVDmtncUhm4EeQHQsuyubpARc1JGvYm9gUYwyUI3myrsVI9m2f6GmYcdXphyqQ1SdkdhP6wnH3jOJQeBwsRAuSRhMSlfj84M61AFi2K53MZVjJPNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AOlvoD3TS2h5CgXe/v5JKQ/yb/nzawbVASZBO3Ok/Xg=;
 b=ppvlEWAoWLdARJ4rBIJSC5dlWqIU8TJv00QTY0sKdAs8gwqegqqW6EEjZbx1XjjBxd4jUE5eEGqGWW8Qy669Ri8u6ZGy6i2wNXBzref8lNm1o9i4J7QIzfp6XSrY3y5K9Y+t5f/1qlJfC+B2zD1EaQD4/VtVejXZXrTU3ApjIr4=
Received: from MW4PR03CA0262.namprd03.prod.outlook.com (2603:10b6:303:b4::27)
 by MN0PR12MB5835.namprd12.prod.outlook.com (2603:10b6:208:37a::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.17; Wed, 21 Sep
 2022 09:04:33 +0000
Received: from CO1NAM11FT092.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b4:cafe::66) by MW4PR03CA0262.outlook.office365.com
 (2603:10b6:303:b4::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.17 via Frontend
 Transport; Wed, 21 Sep 2022 09:04:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT092.mail.protection.outlook.com (10.13.175.225) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5654.14 via Frontend Transport; Wed, 21 Sep 2022 09:04:32 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 21 Sep
 2022 04:04:29 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 21 Sep
 2022 02:04:07 -0700
Received: from amd-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.28
 via Frontend Transport; Wed, 21 Sep 2022 04:03:58 -0500
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
Subject: [PATCH] ASoC: amd: acp: Add setbias level for rt5682s codec in machine driver
Date:   Wed, 21 Sep 2022 14:37:44 +0530
Message-ID: <20220921090750.3833256-1-venkataprasad.potturu@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT092:EE_|MN0PR12MB5835:EE_
X-MS-Office365-Filtering-Correlation-Id: d8d988b1-4d29-4bbb-6980-08da9bb04ccf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +2nJDdbctICFyPLP1Ib82orDyH12T3OmHCxoF6OL8ACm0wUypjH9IFQ6BZBqcQ0fvK5kbAlmsZpmWlV8pjqvxjoiIaV1YLVr0by0htjoJT3kWEbmG+7JwUzrKSBzr19LYyha8qC0Ggx7yQiphG4FWpBUiHetXRO4KaW0XunuvtHg5nwFE9EykUJ+KsbMYc6lXidSmn1vUXoj/ifeeOc2A32jUf1EAfMLGlck6ZtIL8eUS+3QE6lE3wDeCEm2Vy6lXUcWWRNZ4Gzr61+Hx69OiNCBaicpATG9WDw9h5XGftVAKhANYUK5L3UqoUA38cB2dBp0HCnGejAgZlrYWqC6JrbA1AwVWnFW90n6P4MDfklWziOwnKKAOJNhOh13X2eH1NSD5eAHuYRU6w1rnvBXdYcKBBKaA7fVFYsbWSapUxeWIedViAOdVKsvXKT/vJLfEJfBeanCXk8Nj1LBPHzGgrFKQC5frRpEIwcJcZwAlOAxZwm/gmTrVbf7uHwvhrMkmwrjHPhCALHSfHJf7DUwXnOMiVbE0VK2FL77TDSKgfxYR5IHOTfx6/RH9HCoMAv7YxRfdQDsOzl/MCZB798JRLfxfruCIuFoRhB0NdyoRumbSdLSlBqifFlOwDo92b+y17rcqaag4iwWuBV4WQDxgQ4K8ojMOfJCLDSfES1ievZtQIziHP5xsXErl6aiz6ss6yBlfzi/kM6A/mKgDYemn+D4iVVbjH255qb0KPlA2jCvi00RNPg60Re2/2Fq/8AOBQ8bFZnThGn9qOj0YS3iaPpUzORP6dYoegaSc0bcM7ASzQpALQMLUCEbgtOQdyrb
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(396003)(346002)(136003)(376002)(451199015)(36840700001)(46966006)(40470700004)(82740400003)(336012)(6666004)(478600001)(186003)(47076005)(40480700001)(70206006)(41300700001)(70586007)(1076003)(2616005)(426003)(7696005)(40460700003)(26005)(2906002)(82310400005)(54906003)(316002)(110136005)(8936002)(4326008)(8676002)(5660300002)(81166007)(36756003)(36860700001)(356005)(86362001)(83380400001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2022 09:04:32.9682
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d8d988b1-4d29-4bbb-6980-08da9bb04ccf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT092.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5835
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add set_bais_level function for rt5682s codec to enable bclk and lrclk
before codec widgets power on and disable bclk and lrclk after widgets
power down, to avoid pop noise

Signed-off-by: Venkata Prasad Potturu <venkataprasad.potturu@amd.com>
---
 sound/soc/amd/acp/acp-mach-common.c | 62 ++++++++++++++++++++++++++---
 1 file changed, 56 insertions(+), 6 deletions(-)

diff --git a/sound/soc/amd/acp/acp-mach-common.c b/sound/soc/amd/acp/acp-mach-common.c
index 4c69cb6e3400..a78cf29387a7 100644
--- a/sound/soc/amd/acp/acp-mach-common.c
+++ b/sound/soc/amd/acp/acp-mach-common.c
@@ -167,11 +167,14 @@ static int acp_card_hs_startup(struct snd_pcm_substream *substream)
 				      &constraints_channels);
 	snd_pcm_hw_constraint_list(runtime, 0, SNDRV_PCM_HW_PARAM_RATE,
 				      &constraints_rates);
-	if (!drvdata->soc_mclk) {
-		ret = acp_clk_enable(drvdata);
-		if (ret < 0) {
-			dev_err(rtd->card->dev, "Failed to enable HS clk: %d\n", ret);
-			return ret;
+
+	if (strcmp(codec_dai->name, "rt5682s-aif1") && strcmp(codec_dai->name, "rt5682s-aif2")) {
+		if (!drvdata->soc_mclk) {
+			ret = acp_clk_enable(drvdata);
+			if (ret < 0) {
+				dev_err(rtd->card->dev, "Failed to enable HS clk: %d\n", ret);
+				return ret;
+			}
 		}
 	}
 
@@ -280,7 +283,6 @@ static int acp_card_rt5682s_init(struct snd_soc_pcm_runtime *rtd)
 
 static const struct snd_soc_ops acp_card_rt5682s_ops = {
 	.startup = acp_card_hs_startup,
-	.shutdown = acp_card_shutdown,
 };
 
 static const unsigned int dmic_channels[] = {
@@ -570,6 +572,52 @@ SND_SOC_DAILINK_DEF(sof_dmic,
 SND_SOC_DAILINK_DEF(pdm_dmic,
 	DAILINK_COMP_ARRAY(COMP_CPU("acp-pdm-dmic")));
 
+static int acp_rtk_set_bias_level(struct snd_soc_card *card,
+				  struct snd_soc_dapm_context *dapm,
+				  enum snd_soc_bias_level level)
+{
+	struct snd_soc_component *component = dapm->component;
+	struct acp_card_drvdata *drvdata = card->drvdata;
+	int ret = 0;
+
+	if (!component)
+		return 0;
+
+	if (strncmp(component->name, "i2c-RTL5682", 11) &&
+	    strncmp(component->name, "i2c-10EC1019", 12))
+		return 0;
+
+	/*
+	 * For Realtek's codec and amplifier components,
+	 * the lrck and bclk must be enabled brfore their all dapms be powered on,
+	 * and must be disabled after their all dapms be powered down
+	 * to avoid any pop.
+	 */
+	switch (level) {
+	case SND_SOC_BIAS_STANDBY:
+		if (snd_soc_dapm_get_bias_level(dapm) == SND_SOC_BIAS_OFF) {
+			clk_set_rate(drvdata->wclk, 48000);
+			clk_set_rate(drvdata->bclk, 48000 * 64);
+
+			/* Increase bclk's enable_count */
+			ret = clk_prepare_enable(drvdata->bclk);
+			if (ret < 0)
+				dev_err(component->dev, "Failed to enable bclk %d\n", ret);
+		} else {
+			/*
+			 * Decrease bclk's enable_count.
+			 * While the enable_count is 0, the bclk would be closed.
+			 */
+			clk_disable_unprepare(drvdata->bclk);
+		}
+		break;
+	default:
+		break;
+	}
+
+	return ret;
+}
+
 int acp_sofdsp_dai_links_create(struct snd_soc_card *card)
 {
 	struct snd_soc_dai_link *links;
@@ -730,6 +778,7 @@ int acp_sofdsp_dai_links_create(struct snd_soc_card *card)
 
 	card->dai_link = links;
 	card->num_links = num_links;
+	card->set_bias_level = acp_rtk_set_bias_level;
 
 	return 0;
 }
@@ -907,6 +956,7 @@ int acp_legacy_dai_links_create(struct snd_soc_card *card)
 
 	card->dai_link = links;
 	card->num_links = num_links;
+	card->set_bias_level = acp_rtk_set_bias_level;
 
 	return 0;
 }
-- 
2.25.1

