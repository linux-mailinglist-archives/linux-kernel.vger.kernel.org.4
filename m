Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E8F3610E7D
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 12:31:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230133AbiJ1KbI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 06:31:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229727AbiJ1KbA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 06:31:00 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2042.outbound.protection.outlook.com [40.107.237.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A104C17C566
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 03:30:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H6YMWafJPkwVjm3sHbbRAzCP5ZcxImfoufzS75n9NfImUZTf0bGSgwMUJbFJ3bibblUEE6iXEPdCQ0fyBNMqrsEThK5HRKNmu1du1mjHpaLBny5UxquPIsOO8JkZFzfZFuVDlaYroVPg1w4MyUA7yQ+sau8NdI+gaw5Lh7KBKsx0McqjreajQT/RPOYVf+hbLh/S+srEYZ3YRWsNT28bN/gA9s+vO4/e9uiDP+BTN0+lbPfo+jwTusJg/WSBjU6JqFo5O6UwZHkEfZEnZpAHik3kkeq4TBgVKhuHIyisI0LGyeTfamDn+iuQNBcuv4DCpAEpSNORqRjBcsVKlvAsmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IsdpESYOBGXQmW0XFQPmUlEw6QeP3A9k4OpEFnX4vPM=;
 b=mtDqN8/kkQl1zOjqK23dZKAxlRgI/NCMVWBIlo2VoryXBAk2wM1i15rIpNEJtyS+3DwNvDJdgCqsQFItWb6wyxqLwlHSRGw0paZ3g5u8OgvGkMmc4dCjeqSD3elmRvLJnXPteOTMqJnRxLVZTszQaxrtYUC0MbvdtiMibheQx/XYafVoTfrWsGo3OomesAO1PaxnBUxcqTFmRYZt1/dPcyQww46DJC/TKvR1urw5+P/Njx5zsUKlLqO7Tsj3JJQ0SOchw1AvR3+iotgE1OFQn7lRpK9qYN0u5q4H5q5Df4oW9EHeZDnJskGaG7mg8FcMugqSd98V5oquQDLmd+SIkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 165.204.84.17) smtp.rcpttodomain=kernel.org
 smtp.mailfrom=amd.corp-partner.google.com; dmarc=fail (p=reject sp=reject
 pct=100) action=oreject header.from=amd.corp-partner.google.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IsdpESYOBGXQmW0XFQPmUlEw6QeP3A9k4OpEFnX4vPM=;
 b=nWDfJMPTsiEcoILIP6d3dcWg0xtmFa7kPEnlhqxFmDAj+3RTFy3eI8Ho4Ow6IWz1a2ADKj5JbW+GC6CuHFew+fmRUTOnYmAC9xv2Uyq3Vz+dwUhOcyuW3M+iRFrAowqRrtnbeiDCB8yeAhW+nl9s+W8aTS0KY+PxQYvu4w4aN/5RxqNVZGqg85bUbx0sYnjb5EwwBzfkKQAzJyihTT9O91qkEBhFPe4YM2NAN4G/aSXRcsnuK+cKuMI6QZKS6pl/sTtgRHt4fkUPWH8pHYMb7i/XxoT5VTN5m83p/nwz6cTTxPMKbcVZpxHvLWFFkMfw2+NTrVIUFAgqxV7TcTk3TA==
Received: from BN8PR07CA0028.namprd07.prod.outlook.com (2603:10b6:408:ac::41)
 by MN0PR12MB6102.namprd12.prod.outlook.com (2603:10b6:208:3ca::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.15; Fri, 28 Oct
 2022 10:30:52 +0000
Received: from BN8NAM11FT015.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ac:cafe::81) by BN8PR07CA0028.outlook.office365.com
 (2603:10b6:408:ac::41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.15 via Frontend
 Transport; Fri, 28 Oct 2022 10:30:52 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 165.204.84.17) smtp.mailfrom=amd.corp-partner.google.com; dkim=none (message
 not signed) header.d=none;dmarc=fail action=oreject
 header.from=amd.corp-partner.google.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 amd.corp-partner.google.com discourages use of 165.204.84.17 as permitted
 sender)
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT015.mail.protection.outlook.com (10.13.176.90) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5769.14 via Frontend Transport; Fri, 28 Oct 2022 10:30:52 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Fri, 28 Oct
 2022 05:30:52 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Fri, 28 Oct
 2022 05:30:52 -0500
Received: from amd-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.31
 via Frontend Transport; Fri, 28 Oct 2022 05:30:42 -0500
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
        V sujith kumar Reddy <Vsujithkumar.Reddy@amd.com>,
        Ajit Kumar Pandey <AjitKumar.Pandey@amd.com>,
        Akihiko Odaki <akihiko.odaki@gmail.com>,
        ye xingchen <ye.xingchen@zte.com.cn>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH] CHROMIUM: ASoC: amd: acp: Add tdm support for codecs in machine driver
Date:   Fri, 28 Oct 2022 16:04:41 +0530
Message-ID: <20221028103443.30375-1-venkataprasad.potturu@amd.corp-partner.google.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT015:EE_|MN0PR12MB6102:EE_
X-MS-Office365-Filtering-Correlation-Id: a984a1ac-7f54-45aa-c710-08dab8cf7d6d
X-MS-Exchange-SenderADCheck: 2
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kEbhoJe1BPn/zWNG+bcSkNvr1BzzlhqYhmaQGeSEIl1nbzzCPnh3NhNTPWgmtvdD6rhhhtho+CrAzJ8H3lyszDHKb/OQrFSNq7jV3vDJu7SyvEVXvTIe7GSwmgDrdWM80PI2QuuVCAvHcyq+LLJZ9lT3sdmZ5NR87FLA5UEc4vITFFkM6L+BvVILmLYSZ6xQLzCMsz5FNqW0/H77RGFgnZKGzFh0bcPbk+CAlUj8TwEYoL3R5u+XtANg2J6/4C1pIW3XXscQARFtdz4JZemkAGg1phfsv9aLltlMYeD5Vs4KLEIv6nGrWto0vVDGn1ZLH5qRKTRep+WYN6wn0fM4vPkTo8ZyPYN6quMr2jxvL8IPVWXvUA7JWdbLWOxIvqwOCx9RoFmouNAXraQ/Jxo7xNBHc7/f/VJlPnZDJnYb5Ctn0Dtq4UKOl1aApQlJXRcuXypHcLduCudWogMjnL1jLRL13g17QNc9XY2p0HPqfFVkWyzGSnUh9kd01E7v/s88pMEOoAlu3OCmRzXwRXvt/HXJDrZQcX9HMh240Ol6P6+2MJ+f6rZst+jyyphGBBWcYDHLXeiv0EqVWbVVW/GmwVlPILu+pt8rXLVf815VFwcwQahy1gzH8PGdIVrfGBAisnHDSmr8SdNxOLfTjWsw1JB6zqMOM91TOhzPhU5BGDVIokX3HnZPLEbjhf7kQ7RX1wP7n+CvaCPqOxB8T6LF/1p0A4OYY0u4krk2n4lpBr8aSEvIwltwpHbgXAlif5bjn/FXu+f52lu6U5CM/hYeFA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(376002)(346002)(136003)(396003)(451199015)(40470700004)(46966006)(26005)(4326008)(41300700001)(8676002)(356005)(81166007)(40460700003)(47076005)(83380400001)(2616005)(30864003)(35950700001)(5660300002)(8936002)(336012)(2906002)(1076003)(82740400003)(498600001)(110136005)(86362001)(54906003)(316002)(82310400005)(70206006)(40480700001)(70586007)(76482006);DIR:OUT;SFP:1101;
X-OriginatorOrg: amdcloud.onmicrosoft.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2022 10:30:52.7965
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a984a1ac-7f54-45aa-c710-08dab8cf7d6d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT015.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6102
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

Add tdm support for rt5682, rt5682s, rt1019 and nau8825 codec in
machine driver.

Signed-off-by: Venkata Prasad Potturu <venkataprasad.potturu@amd.com>
---
 sound/soc/amd/acp/acp-mach-common.c | 255 ++++++++++++++++++++++++++--
 1 file changed, 243 insertions(+), 12 deletions(-)

diff --git a/sound/soc/amd/acp/acp-mach-common.c b/sound/soc/amd/acp/acp-mach-common.c
index a78cf29387a7..bce3d8ed48ec 100644
--- a/sound/soc/amd/acp/acp-mach-common.c
+++ b/sound/soc/amd/acp/acp-mach-common.c
@@ -27,6 +27,21 @@
 #include "../../codecs/nau8825.h"
 #include "acp-mach.h"
 
+static int tdm_mode = 0;
+module_param_named(tdm_mode, tdm_mode, int, 0444);
+MODULE_PARM_DESC(tdm_mode, "Set 1 for tdm mode, set 0 for i2s mode");
+
+#define TDM_CHANNELS	8
+#define BIT_WIDTH	16
+#define SLOT0	BIT(0)
+#define SLOT1	BIT(1)
+#define SLOT2	BIT(2)
+#define SLOT3	BIT(3)
+#define SLOT4	BIT(4)
+#define SLOT5	BIT(5)
+#define SLOT6	BIT(6)
+#define SLOT7	BIT(7)
+
 #define PCO_PLAT_CLK 48000000
 #define RT5682_PLL_FREQ (48000 * 512)
 #define DUAL_CHANNEL	2
@@ -80,13 +95,19 @@ static int acp_card_rt5682_init(struct snd_soc_pcm_runtime *rtd)
 	struct snd_soc_dai *codec_dai = asoc_rtd_to_codec(rtd, 0);
 	struct snd_soc_component *component = codec_dai->component;
 	int ret;
+	unsigned int fmt;
 
 	dev_info(rtd->dev, "codec dai name = %s\n", codec_dai->name);
 
 	if (drvdata->hs_codec_id != RT5682)
 		return -EINVAL;
 
-	ret =  snd_soc_dai_set_fmt(codec_dai, SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF
+	if (tdm_mode)
+		fmt = SND_SOC_DAIFMT_DSP_A;
+	else
+		fmt = SND_SOC_DAIFMT_I2S;
+
+	ret =  snd_soc_dai_set_fmt(codec_dai, fmt | SND_SOC_DAIFMT_NB_NF
 				   | SND_SOC_DAIFMT_CBP_CFP);
 	if (ret < 0) {
 		dev_err(rtd->card->dev, "Failed to set dai fmt: %d\n", ret);
@@ -151,10 +172,15 @@ static int acp_card_hs_startup(struct snd_pcm_substream *substream)
 	int ret;
 	unsigned int fmt;
 
+	if (tdm_mode)
+		fmt = SND_SOC_DAIFMT_DSP_A;
+	else
+		fmt = SND_SOC_DAIFMT_I2S;
+
 	if (drvdata->soc_mclk)
-		fmt = SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF | SND_SOC_DAIFMT_CBC_CFC;
+		fmt = fmt | SND_SOC_DAIFMT_NB_NF | SND_SOC_DAIFMT_CBC_CFC;
 	else
-		fmt = SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF | SND_SOC_DAIFMT_CBP_CFP;
+		fmt = fmt | SND_SOC_DAIFMT_NB_NF | SND_SOC_DAIFMT_CBP_CFP;
 
 	ret =  snd_soc_dai_set_fmt(codec_dai, fmt);
 	if (ret < 0) {
@@ -191,9 +217,65 @@ static void acp_card_shutdown(struct snd_pcm_substream *substream)
 		clk_disable_unprepare(drvdata->wclk);
 }
 
+static int acp_card_rt5682x_hw_params(struct snd_pcm_substream *substream,
+				      struct snd_pcm_hw_params *params)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_dai *codec_dai = asoc_rtd_to_codec(rtd, 0);
+		struct snd_soc_dai *cpu_dai = asoc_rtd_to_cpu(rtd, 0);
+	int ret;
+	unsigned int fmt;
+
+	if (tdm_mode)
+		fmt = SND_SOC_DAIFMT_DSP_A;
+	else
+		fmt = SND_SOC_DAIFMT_I2S;
+
+	ret = snd_soc_dai_set_fmt(cpu_dai, fmt | SND_SOC_DAIFMT_NB_NF
+				   | SND_SOC_DAIFMT_CBP_CFP);
+	if (ret && ret != -ENOTSUPP) {
+		dev_err(rtd->dev, "Failed to set dai fmt: %d\n", ret);
+		return ret;
+	}
+
+	if (tdm_mode) {
+		/**
+		 * As codec supports slot 0 and slot 1 for playback and capture.
+		 */
+		ret = snd_soc_dai_set_tdm_slot(cpu_dai, SLOT0 | SLOT1, SLOT0 | SLOT1,
+					       TDM_CHANNELS, BIT_WIDTH);
+		if (ret && ret != -ENOTSUPP) {
+			dev_err(rtd->dev, "set TDM slot err: %d\n", ret);
+			return ret;
+		}
+	}
+
+	ret =  snd_soc_dai_set_fmt(codec_dai, fmt | SND_SOC_DAIFMT_NB_NF
+				   | SND_SOC_DAIFMT_CBC_CFC);
+	if (ret < 0) {
+		dev_err(rtd->card->dev, "Failed to set dai fmt: %d\n", ret);
+		return ret;
+	}
+
+	if (tdm_mode) {
+		/**
+		 * As codec supports slot 0 and slot 1 for playback and capture.
+		 */
+		ret = snd_soc_dai_set_tdm_slot(codec_dai, SLOT0 | SLOT1, SLOT0 | SLOT1,
+					       TDM_CHANNELS, BIT_WIDTH);
+		if (ret < 0) {
+			dev_warn(rtd->dev, "set TDM slot err:%d\n", ret);
+			return ret;
+		}
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
@@ -220,10 +302,15 @@ static int acp_card_rt5682s_init(struct snd_soc_pcm_runtime *rtd)
 	if (drvdata->hs_codec_id != RT5682S)
 		return -EINVAL;
 
+	if (tdm_mode)
+		fmt = SND_SOC_DAIFMT_DSP_A;
+	else
+		fmt = SND_SOC_DAIFMT_I2S;
+
 	if (drvdata->soc_mclk)
-		fmt = SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF | SND_SOC_DAIFMT_CBC_CFC;
+		fmt = fmt | SND_SOC_DAIFMT_NB_NF | SND_SOC_DAIFMT_CBC_CFC;
 	else
-		fmt = SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF | SND_SOC_DAIFMT_CBP_CFP;
+		fmt = fmt | SND_SOC_DAIFMT_NB_NF | SND_SOC_DAIFMT_CBP_CFP;
 
 	ret =  snd_soc_dai_set_fmt(codec_dai, fmt);
 	if (ret < 0) {
@@ -283,6 +370,7 @@ static int acp_card_rt5682s_init(struct snd_soc_pcm_runtime *rtd)
 
 static const struct snd_soc_ops acp_card_rt5682s_ops = {
 	.startup = acp_card_hs_startup,
+	.hw_params = acp_card_rt5682x_hw_params,
 };
 
 static const unsigned int dmic_channels[] = {
@@ -351,19 +439,48 @@ static int acp_card_rt1019_hw_params(struct snd_pcm_substream *substream,
 	struct snd_soc_card *card = rtd->card;
 	struct acp_card_drvdata *drvdata = card->drvdata;
 	struct snd_soc_dai *codec_dai;
+	struct snd_soc_dai *cpu_dai = asoc_rtd_to_cpu(rtd, 0);
 	int srate, i, ret = 0;
+	unsigned int fmt;
 
 	srate = params_rate(params);
 
 	if (drvdata->amp_codec_id != RT1019)
 		return -EINVAL;
 
+	if (tdm_mode)
+		fmt = SND_SOC_DAIFMT_DSP_A;
+	else
+		fmt = SND_SOC_DAIFMT_I2S;
+
+	ret = snd_soc_dai_set_fmt(cpu_dai, fmt | SND_SOC_DAIFMT_NB_NF
+				   | SND_SOC_DAIFMT_CBP_CFP);
+	if (ret && ret != -ENOTSUPP) {
+		dev_err(rtd->dev, "Failed to set dai fmt: %d\n", ret);
+		return ret;
+	}
+
+	if (tdm_mode) {
+		/**
+		 * As codec supports slot 2 and slot 3 for playback.
+		 */
+		ret = snd_soc_dai_set_tdm_slot(cpu_dai, SLOT2 | SLOT3, 0, TDM_CHANNELS, BIT_WIDTH);
+		if (ret && ret != -ENOTSUPP) {
+			dev_err(rtd->dev, "set TDM slot err: %d\n", ret);
+			return ret;
+		}
+	}
 	for_each_rtd_codec_dais(rtd, i, codec_dai) {
 		if (strcmp(codec_dai->name, "rt1019-aif"))
 			continue;
 
-		ret = snd_soc_dai_set_pll(codec_dai, 0, RT1019_PLL_S_BCLK,
-					  64 * srate, 256 * srate);
+		if (tdm_mode)
+			ret = snd_soc_dai_set_pll(codec_dai, 0, RT1019_PLL_S_BCLK,
+						  128 * srate, 256 * srate);
+		else
+			ret = snd_soc_dai_set_pll(codec_dai, 0, RT1019_PLL_S_BCLK,
+						  64 * srate, 256 * srate);
+
 		if (ret < 0)
 			return ret;
 
@@ -371,8 +488,36 @@ static int acp_card_rt1019_hw_params(struct snd_pcm_substream *substream,
 					     256 * srate, SND_SOC_CLOCK_IN);
 		if (ret < 0)
 			return ret;
-	}
 
+		if (tdm_mode) {
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
+				ret = snd_soc_dai_set_tdm_slot(codec_dai, SLOT2, SLOT2,
+							       TDM_CHANNELS, BIT_WIDTH);
+				if (ret < 0)
+					break;
+			}
+
+			/**
+			 * As codec supports slot 3 for right channel playback.
+			 */
+			if (!strcmp(codec_dai->component->name, "i2c-10EC1019:01")) {
+				ret = snd_soc_dai_set_tdm_slot(codec_dai, SLOT3, SLOT3,
+							       TDM_CHANNELS, BIT_WIDTH);
+				if (ret < 0)
+					break;
+			}
+		}
+	}
 	return 0;
 }
 
@@ -426,9 +571,43 @@ static int acp_card_maxim_init(struct snd_soc_pcm_runtime *rtd)
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
+	if (tdm_mode)
+		fmt = SND_SOC_DAIFMT_DSP_A;
+	else
+		fmt = SND_SOC_DAIFMT_I2S;
+
+	ret = snd_soc_dai_set_fmt(cpu_dai, fmt | SND_SOC_DAIFMT_NB_NF
+				   | SND_SOC_DAIFMT_CBP_CFP);
+	if (ret && ret != -ENOTSUPP) {
+		dev_err(rtd->dev, "Failed to set dai fmt: %d\n", ret);
+		return ret;
+	}
+
+	if (tdm_mode) {
+		/**
+		 * As codec supports slot 2 and slot 3 for playback.
+		 */
+		ret = snd_soc_dai_set_tdm_slot(cpu_dai, SLOT2 | SLOT3, 0, TDM_CHANNELS, BIT_WIDTH);
+		if (ret && ret != -ENOTSUPP) {
+			dev_err(rtd->dev, "set TDM slot err: %d\n", ret);
+			return ret;
+		}
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
@@ -454,10 +633,15 @@ static int acp_card_nau8825_init(struct snd_soc_pcm_runtime *rtd)
 	if (drvdata->hs_codec_id != NAU8825)
 		return -EINVAL;
 
+	if (tdm_mode)
+		fmt = SND_SOC_DAIFMT_DSP_A;
+	else
+		fmt = SND_SOC_DAIFMT_I2S;
+
 	if (drvdata->soc_mclk)
-		fmt = SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF | SND_SOC_DAIFMT_CBC_CFC;
+		fmt = fmt | SND_SOC_DAIFMT_NB_NF | SND_SOC_DAIFMT_CBC_CFC;
 	else
-		fmt = SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF | SND_SOC_DAIFMT_CBP_CFP;
+		fmt = fmt | SND_SOC_DAIFMT_NB_NF | SND_SOC_DAIFMT_CBP_CFP;
 
 	ret =  snd_soc_dai_set_fmt(codec_dai, fmt);
 	if (ret < 0) {
@@ -493,8 +677,34 @@ static int acp_nau8825_hw_params(struct snd_pcm_substream *substream,
 {
 	struct snd_soc_pcm_runtime *rtd = asoc_substream_to_rtd(substream);
 	struct snd_soc_dai *codec_dai = asoc_rtd_to_codec(rtd, 0);
+	struct snd_soc_dai *cpu_dai = asoc_rtd_to_cpu(rtd, 0);
 	int ret;
+	unsigned int fmt;
 
+	if (tdm_mode)
+		fmt = SND_SOC_DAIFMT_DSP_A;
+	else
+		fmt = SND_SOC_DAIFMT_I2S;
+
+	ret = snd_soc_dai_set_fmt(cpu_dai, fmt | SND_SOC_DAIFMT_NB_NF
+				   | SND_SOC_DAIFMT_CBP_CFP);
+	if (ret && ret != -ENOTSUPP) {
+		dev_err(rtd->dev, "Failed to set dai fmt: %d\n", ret);
+		return ret;
+	}
+
+	if (tdm_mode) {
+		/**
+		 * As codec supports slot 4 and slot 5 for playback
+		 * and slot 6 and slot 7 for capture.
+		 */
+		ret = snd_soc_dai_set_tdm_slot(cpu_dai, SLOT4 | SLOT5, SLOT6 | SLOT7,
+					       TDM_CHANNELS, BIT_WIDTH);
+		if (ret && ret != -ENOTSUPP) {
+			dev_err(rtd->dev, "set TDM slot err: %d\n", ret);
+			return ret;
+		}
+	}
 	ret = snd_soc_dai_set_sysclk(codec_dai, NAU8825_CLK_FLL_FS,
 				     (48000 * 256), SND_SOC_CLOCK_IN);
 	if (ret < 0)
@@ -507,6 +717,25 @@ static int acp_nau8825_hw_params(struct snd_pcm_substream *substream,
 		return ret;
 	}
 
+	ret =  snd_soc_dai_set_fmt(codec_dai, fmt | SND_SOC_DAIFMT_NB_NF
+				   | SND_SOC_DAIFMT_CBC_CFC);
+	if (ret < 0) {
+		dev_err(rtd->card->dev, "Failed to set dai fmt: %d\n", ret);
+		return ret;
+	}
+
+	if (tdm_mode) {
+		/**
+		 * As codec supports slot 4 and slot 5 for playback and slot 6 for capture.
+		 */
+		ret = snd_soc_dai_set_tdm_slot(codec_dai, SLOT6, SLOT4 | SLOT5,
+					       TDM_CHANNELS, BIT_WIDTH);
+		if (ret < 0) {
+			dev_warn(rtd->dev, "set TDM slot err:%d\n", ret);
+			return ret;
+		}
+	}
+
 	return ret;
 }
 
@@ -567,6 +796,8 @@ SND_SOC_DAILINK_DEF(sof_sp,
 	DAILINK_COMP_ARRAY(COMP_CPU("acp-sof-sp")));
 SND_SOC_DAILINK_DEF(sof_hs,
 		    DAILINK_COMP_ARRAY(COMP_CPU("acp-sof-hs")));
+SND_SOC_DAILINK_DEF(sof_hs_virtual,
+		    DAILINK_COMP_ARRAY(COMP_CPU("acp-sof-hs-virtual")));
 SND_SOC_DAILINK_DEF(sof_dmic,
 	DAILINK_COMP_ARRAY(COMP_CPU("acp-sof-dmic")));
 SND_SOC_DAILINK_DEF(pdm_dmic,
@@ -733,8 +964,8 @@ int acp_sofdsp_dai_links_create(struct snd_soc_card *card)
 	if (drv_data->amp_cpu_id == I2S_HS) {
 		links[i].name = "acp-amp-codec";
 		links[i].id = AMP_BE_ID;
-		links[i].cpus = sof_hs;
-		links[i].num_cpus = ARRAY_SIZE(sof_hs);
+		links[i].cpus = sof_hs_virtual;
+		links[i].num_cpus = ARRAY_SIZE(sof_hs_virtual);
 		links[i].platforms = sof_component;
 		links[i].num_platforms = ARRAY_SIZE(sof_component);
 		links[i].dpcm_playback = 1;
-- 
2.25.1

