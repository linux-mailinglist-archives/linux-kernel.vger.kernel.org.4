Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D7E45EEE63
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 09:05:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235146AbiI2HFi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 03:05:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235088AbiI2HE7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 03:04:59 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2073.outbound.protection.outlook.com [40.107.220.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D32004D4D7
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 00:04:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=byb8DHhSp41RLv2gd7YEluYWc+UQ1s0VqHSlETCuEcDe6K9LDnxC/0WEbr0RXipwLP5U4JYaqeyZLIvWKf5HwI/NeiMX8s1XCZgC2E/onrQkeeaxpYfr4g+8rCB4NbqxdW74IIgpBdvEcFiWATfoeiugAEEzhhNrGFmxvRTZA/gIAwzlVV43dhIDwETHo9g4hMb9srrg3wWayhMoeBpzPpuq75IF/mSG9MJsl3NtNG+JJ3ZVoJVdckndDwMsq2SyYgWV0dqKZQuad0gfeSGpbB8ARuHNXsJtOg0Gdr5Fr/hQE1mKx7CYjONC0dznE7m4GiHDAiI7V9RHkC8kVdHC6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SRBvrNbhaekA6FzbEIf/QMK2T8FBx1p60Iq7a30WkuM=;
 b=m8lScyfLXWfMbphE0KQHMg1w6/pl/nrYcValQ21Et6brzKiO7Gl+HfZl/w93tEFZ8uRaWjaIFzZPWqxTW1OjoEue45eOSFNHWe1XJDVUGc5mPw1aMJ1uPJYhdDlMtZarCnewdMQj7cooK+VMTnGhcwOxZeyrM0nSx0f5Neh2E/dW4iGTNECio2Jw9xMjVDPuRkzYA2CyQkEwJ+msGmcW7Uz+ch7tIR/mUhNFgj2709B0dWUy6B2cZXeLXGO3Wr6dfJw7+kL+Ff1+UNrgdiEsTdsPoen5iIZkZKRxQ+kEApZCqz5iT1kWFVedlPDNvuHdX4DvQD5abH4FUqvNFz0FpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 165.204.84.17) smtp.rcpttodomain=kernel.org
 smtp.mailfrom=amd.corp-partner.google.com; dmarc=fail (p=reject sp=reject
 pct=100) action=oreject header.from=amd.corp-partner.google.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SRBvrNbhaekA6FzbEIf/QMK2T8FBx1p60Iq7a30WkuM=;
 b=b3MxUawjYwJegZR6ipHTsz0uVpG090Auj98BKrBiaXAu7IvoNVuMyxow8yC6Nt/5ywG/d5zRDdAJU7FhmMuPciVe8Q3kKDhtyXLa2ob8pj3xCWip1dH6rXpfMJ43lR5xfaJgxBBKJdUDhl3UwqWpwSEG20758jwNId44P0NCXJOamDdffg856UvoD0HFQFuQvcB7CSByAvvQbAdJTvhnXopz2bBUKLGdFxFmOc8BrrBbU3RYRL0etDCuiVUnI+QvomzyTGUgzv8UWqDu0eBXp5K2PodY6Xk6+5/DasYWyozW0PIetTAAGXbs81p7v8VBPWja+msLW36twcZao7SZJQ==
Received: from BN9PR03CA0293.namprd03.prod.outlook.com (2603:10b6:408:f5::28)
 by BN9PR12MB5258.namprd12.prod.outlook.com (2603:10b6:408:11f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.20; Thu, 29 Sep
 2022 07:04:51 +0000
Received: from BN8NAM11FT064.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:f5:cafe::51) by BN9PR03CA0293.outlook.office365.com
 (2603:10b6:408:f5::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.17 via Frontend
 Transport; Thu, 29 Sep 2022 07:04:51 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 165.204.84.17) smtp.mailfrom=amd.corp-partner.google.com; dkim=none (message
 not signed) header.d=none;dmarc=fail action=oreject
 header.from=amd.corp-partner.google.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 amd.corp-partner.google.com discourages use of 165.204.84.17 as permitted
 sender)
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT064.mail.protection.outlook.com (10.13.176.160) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5676.17 via Frontend Transport; Thu, 29 Sep 2022 07:04:51 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Thu, 29 Sep
 2022 02:04:50 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Thu, 29 Sep
 2022 00:04:49 -0700
Received: from amd-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.28
 via Frontend Transport; Thu, 29 Sep 2022 02:04:40 -0500
From:   Venkata Prasad Potturu 
        <venkataprasad.potturu@amd.corp-partner.google.com>
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
        Jia-Ju Bai <baijiaju1990@gmail.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: [RESEND] ASoC: amd: acp: Add setbias level for rt5682s codec in machine driver
Date:   Thu, 29 Sep 2022 12:38:22 +0530
Message-ID: <20220929070828.3950101-1-venkataprasad.potturu@amd.corp-partner.google.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT064:EE_|BN9PR12MB5258:EE_
X-MS-Office365-Filtering-Correlation-Id: e749195f-f870-4edb-1837-08daa1e8e753
X-MS-Exchange-SenderADCheck: 2
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vWpZ/IXrcZnVNCisRoyXdRXTbPIxsJIwFP4Wq9gJ6zfVI2IdU/d0U3MmekhZbu3gYhiGRaOU56+Hrl/DzpTdUhzxvkc56Nysk0sNyzr7WRMS0xM/6O+L99r5udDdQK6SKQuJslyRp2orkVuZPC8S6Gl2o1plKHkzPO+6sJfuDvsQLMi7G2OyHJYT0YwrJCb47M5GfheAWhnEBcn0Cb2dR6qw6nX/K1EC78bbxX1/meXa+iB4i/f1RoH2x7mLoBvdZSsgxONavwgy6imse7CwW6Juhbw5Nhv9diiRtkINELWAif2kBZg2efGkQ2j75037TCjU4dae6spvhgakbW2hZVdhFrAiGTOeMxAj9+Tc6jlgXE8Ey5VMnbPux5UVotEi6FeNedATYXI/J19Bp7K32APDPUcIgUVh1JXm1+pjnrKWlZIdy8tWxQSoaWk3cG5REdbT+wO4u2j7OwVK4BPWOPdV/0td25+TA8zSF05KAmNVguYqTqMvi8KLCwcDjPl/yBcSa5V1NBVO006QrIB9OKHArHHqqoo8teGQGl0e9L/DcXFdPQI2Q3vMzQLX/xeyscuejD95s/Jucd7L+AO9zfq2xzUEcd444VB74kIxjO5MBlWeVgKWuZ6jCF4/TrQ3NS+fUaa+atzcxdmIVj87mfXbO/DkQvyp6k9cnR5DRRvlkCqOdNcv+5MRg8iYdDezp4z9YUkp+Doy0lhNmaceQ4jZLoZpgjnfRTZwcMq7MinY7D8IuXiJtayZIhvEyBiJtI5c03ZqqUnH7Gn+aIDSOg==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(396003)(376002)(136003)(346002)(39860400002)(451199015)(40470700004)(46966006)(47076005)(35950700001)(356005)(83380400001)(81166007)(1076003)(2616005)(336012)(86362001)(82740400003)(5660300002)(8936002)(70206006)(70586007)(4326008)(41300700001)(82310400005)(2906002)(6666004)(498600001)(40460700003)(26005)(316002)(54906003)(110136005)(40480700001)(8676002)(76482006);DIR:OUT;SFP:1101;
X-OriginatorOrg: amdcloud.onmicrosoft.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2022 07:04:51.1188
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e749195f-f870-4edb-1837-08daa1e8e753
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT064.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5258
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Venkata Prasad Potturu <venkataprasad.potturu@amd.com>

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

