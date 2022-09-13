Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0024A5B7583
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 17:46:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234598AbiIMPqY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 11:46:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236684AbiIMPp0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 11:45:26 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2062f.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e83::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C5EA868B9
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 07:49:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aXMpKP20A3kywi5rv3nPSK9EVfP8BwqZveYsTHXKrFG72gYpMpdywbEgsOzKmK8Ow+XDcGJ76dvfqM0cwqqNrFxBrsYQ+DSDMDZPNaTcx+HbZx1rHYpRUdoJjbmBa7Eclza5PLnetw88tPitd8yxfa++Uo0a4XCfk62FeCXaY5h8OlHogKFg5Qu6jMMWgbvRYCujbNu6rWjq/AHv825qBVw5e2YawPjEzy+T4LX2bzFBTdkSTwDrr4h8fofE72m4Sw/rm0pzTuqi1ZRUu8RWEPlfRT3YMoWk+J7sIbfyE5XVQ9zPp0lHH/djgxhaynKv6SvwTsHLHp9VGM6dWSfadA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JgtBKzAhNOXSTwZwHWf3JZmAoZuQpSiXFgO5H3lTP5g=;
 b=ATI7obfspqGJyklxsnb3k2kXtoW3zK0W9G3j7F8CzYxShMgFVAIMQgmHTuPvqaUhZijLan5yhCqU7mwjARfDGw0bgtyfbIigPw4NPG1SQn0X2TjGzKmOSmEMoMu2f8ihp91wUdLlhtyvr3HBRe0klPAVZQ78lTY+km29/dPLJDXTTAuCWDkNYk4PHVhpsGt9TgKHGfMRyvCKtPFwKrw6vonOOjtyflC8TOnmY5MoI9/aDGHLSxPu6E689QASwGobkQ9EoRCyVf9VO572aJ6qBz3Rde7SmS65ELntcLVFJBTye4EwPTY3NpAh0r1Svwhb8kq+Ic9btkWetRpEs5EfDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JgtBKzAhNOXSTwZwHWf3JZmAoZuQpSiXFgO5H3lTP5g=;
 b=HRh9iNr3UWqqMYJ1UDItFPlkc1yEfPP68v4ieODwY3uihZFe3ICoU12Ygilm1r4suRIVuVZdsfTQ0By9nuY4BJKceVFEtPDKIH011amBO2OtsVxxrk0ZD3T4D60SdzkOe4gAprVu0qs3KfWx1BKWK9vLO5L+ENG4bbjW3loo9lk=
Received: from DS7PR03CA0008.namprd03.prod.outlook.com (2603:10b6:5:3b8::13)
 by DS0PR12MB7557.namprd12.prod.outlook.com (2603:10b6:8:133::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.14; Tue, 13 Sep
 2022 14:42:00 +0000
Received: from DM6NAM11FT093.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b8:cafe::86) by DS7PR03CA0008.outlook.office365.com
 (2603:10b6:5:3b8::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.22 via Frontend
 Transport; Tue, 13 Sep 2022 14:42:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT093.mail.protection.outlook.com (10.13.172.235) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5612.13 via Frontend Transport; Tue, 13 Sep 2022 14:41:59 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 13 Sep
 2022 09:41:58 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 13 Sep
 2022 09:41:58 -0500
Received: from sof-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.28
 via Frontend Transport; Tue, 13 Sep 2022 09:41:53 -0500
From:   V sujith kumar Reddy <Vsujithkumar.Reddy@amd.com>
To:     <broonie@kernel.org>, <alsa-devel@alsa-project.org>
CC:     <Vijendar.Mukunda@amd.com>, <Basavaraj.Hiregoudar@amd.com>,
        <Sunil-kumar.Dommati@amd.com>, <venkataprasad.potturu@amd.com>,
        <ssabakar@amd.com>,
        V sujith kumar Reddy <Vsujithkumar.Reddy@amd.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
        "Bard Liao" <yung-chuan.liao@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        "Ajit Kumar Pandey" <AjitKumar.Pandey@amd.com>,
        YC Hung <yc.hung@mediatek.com>,
        open list <linux-kernel@vger.kernel.org>,
        "moderated list:SOUND - SOUND OPEN FIRMWARE (SOF) DRIVERS" 
        <sound-open-firmware@alsa-project.org>
Subject: [PATCH 3/4] ASoC: SOF: Adding amd HS functionality to the sof core
Date:   Tue, 13 Sep 2022 20:13:17 +0530
Message-ID: <20220913144319.1055302-4-Vsujithkumar.Reddy@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220913144319.1055302-1-Vsujithkumar.Reddy@amd.com>
References: <20220913144319.1055302-1-Vsujithkumar.Reddy@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT093:EE_|DS0PR12MB7557:EE_
X-MS-Office365-Filtering-Correlation-Id: f8650b13-186f-468d-6c8d-08da95961d94
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ovS3a1PU8QbsGBcE4i7c4F8v+i5Nl2VoeIh/4phd8i2TDxMdb+b+bvMPX3mtKB7LcWfhvnjMmiNpfSuqqq4icUZ7q9Q9kiu2FHkcqwnhHgO2FL8PAWwdOdcPgfofw1O8m4VKkUmyWrFjzzcRIPhaStoMDqSCMTQJdLSvtBn7wsZPLr2IX4h4hr1QEfilX2csX4pB9U0eDW2ypZ+iWDdLjzSG0HfxX3pflBpQj3itEsp/lZsUWH2r/H2oPC0c2XAX+idvmHgVh0X5TMcIddN7VsxrsuBraoRGRTNqZV+zvk4IXnz3V9m80y7JIJYnDHXD5FpP1nGA5tTgqDG1mY68qdcn2IjJh+ofiDp243Ocx3sAzgwN2KrMmdzMnbzukmqQYrp9dwTkjU/hPU7XezhbRo858tX1GWf4lzmA8/i9wYHd8/bgughS74gggW4HuIp1kWKDdWz9XQwR0guWr/HCzeHDZlkZqE38vkVZH67E8dk5Q137MV3smoREhvAYerMvC+JESMTEZi2mz11viC99pIbr2dM77ZOxi01r2b4O4EnI2JO62PTub/pCLy4ei9kxJ1cxq/27ANd/srdFygTfTGvQG7YruzA62hqFliOuECZhDrU/No5OUFRhnlSGKXLnT+s9aRpqCdXLd7lJ+aK6/bjhw9cLQjhyDdhn9wvptYgyvxLFRH7/H2ppsTJ8xtEPU9y6RhraKDrxBPiceAYB18jE9tyu4BnLPWumOb/pbxxa9Qj+/qPcdE+L8Nr0P/CVy8O+WjKfmCcfNj2uAJKRuvYQBs8b5g8kR248eHAPx50hZCU+fVieBR6dqgdfP1Ve
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(346002)(136003)(39860400002)(376002)(396003)(451199015)(40470700004)(46966006)(36840700001)(70206006)(47076005)(86362001)(70586007)(316002)(5660300002)(40460700003)(336012)(2906002)(7696005)(7416002)(83380400001)(426003)(8676002)(4326008)(41300700001)(82310400005)(6666004)(82740400003)(40480700001)(8936002)(1076003)(110136005)(36756003)(81166007)(356005)(478600001)(36860700001)(2616005)(186003)(26005)(54906003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2022 14:41:59.9308
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f8650b13-186f-468d-6c8d-08da95961d94
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT093.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7557
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add I2S HS control instance to the sof core.
This will help the amd topology to use the I2S HS Dai.

Signed-off-by: V sujith kumar Reddy <Vsujithkumar.Reddy@amd.com>
---
 include/sound/sof/dai.h       |  2 ++
 sound/soc/sof/ipc3-pcm.c      |  9 +++++++++
 sound/soc/sof/ipc3-topology.c | 33 +++++++++++++++++++++++++++++++++
 sound/soc/sof/topology.c      |  1 +
 4 files changed, 45 insertions(+)

diff --git a/include/sound/sof/dai.h b/include/sound/sof/dai.h
index 21d98f31a9ca..83fd81c82e4c 100644
--- a/include/sound/sof/dai.h
+++ b/include/sound/sof/dai.h
@@ -84,6 +84,7 @@ enum sof_ipc_dai_type {
 	SOF_DAI_AMD_BT,			/**< AMD ACP BT*/
 	SOF_DAI_AMD_SP,			/**< AMD ACP SP */
 	SOF_DAI_AMD_DMIC,		/**< AMD ACP DMIC */
+	SOF_DAI_AMD_HS,			/**< Amd HS */
 	SOF_DAI_MEDIATEK_AFE,		/**< Mediatek AFE */
 };
 
@@ -112,6 +113,7 @@ struct sof_ipc_dai_config {
 		struct sof_ipc_dai_acp_params acpbt;
 		struct sof_ipc_dai_acp_params acpsp;
 		struct sof_ipc_dai_acpdmic_params acpdmic;
+		struct sof_ipc_dai_acp_params acphs;
 		struct sof_ipc_dai_mtk_afe_params afe;
 	};
 } __packed;
diff --git a/sound/soc/sof/ipc3-pcm.c b/sound/soc/sof/ipc3-pcm.c
index 9c6a84bdeca7..dad57bef38f6 100644
--- a/sound/soc/sof/ipc3-pcm.c
+++ b/sound/soc/sof/ipc3-pcm.c
@@ -346,6 +346,15 @@ static int sof_ipc3_pcm_dai_link_fixup(struct snd_soc_pcm_runtime *rtd,
 		dev_dbg(component->dev, "AMD_SP channels_min: %d channels_max: %d\n",
 			channels->min, channels->max);
 		break;
+	case SOF_DAI_AMD_HS:
+		rate->min = private->dai_config->acphs.fsync_rate;
+		rate->max = private->dai_config->acphs.fsync_rate;
+		channels->min = private->dai_config->acphs.tdm_slots;
+		channels->max = private->dai_config->acphs.tdm_slots;
+
+		dev_dbg(component->dev,
+			"AMD_HS channel_max: %d rate_max: %d\n", channels->max, rate->max);
+		break;
 	case SOF_DAI_AMD_DMIC:
 		rate->min = private->dai_config->acpdmic.pdm_rate;
 		rate->max = private->dai_config->acpdmic.pdm_rate;
diff --git a/sound/soc/sof/ipc3-topology.c b/sound/soc/sof/ipc3-topology.c
index 65923e7a5976..64f0bf60a11d 100644
--- a/sound/soc/sof/ipc3-topology.c
+++ b/sound/soc/sof/ipc3-topology.c
@@ -1217,6 +1217,36 @@ static int sof_link_acp_sp_load(struct snd_soc_component *scomp, struct snd_sof_
 	return 0;
 }
 
+static int sof_link_acp_hs_load(struct snd_soc_component *scomp, struct snd_sof_dai_link *slink,
+				struct sof_ipc_dai_config *config, struct snd_sof_dai *dai)
+{
+	struct snd_soc_tplg_hw_config *hw_config = slink->hw_configs;
+	struct sof_dai_private_data *private = dai->private;
+	u32 size = sizeof(*config);
+
+	/* Configures the DAI hardware format and inverted clocks */
+	sof_dai_set_format(hw_config, config);
+
+	/* init IPC */
+	memset(&config->acphs, 0, sizeof(config->acphs));
+	config->hdr.size = size;
+
+	config->acphs.fsync_rate = le32_to_cpu(hw_config->fsync_rate);
+	config->acphs.tdm_slots = le32_to_cpu(hw_config->tdm_slots);
+
+	dev_info(scomp->dev, "ACP_HS config ACP%d channel %d rate %d\n",
+		 config->dai_index, config->acphs.tdm_slots,
+		 config->acphs.fsync_rate);
+
+	dai->number_configs = 1;
+	dai->current_config = 0;
+	private->dai_config = kmemdup(config, size, GFP_KERNEL);
+	if (!private->dai_config)
+		return -ENOMEM;
+
+	return 0;
+}
+
 static int sof_link_afe_load(struct snd_soc_component *scomp, struct snd_sof_dai_link *slink,
 			     struct sof_ipc_dai_config *config, struct snd_sof_dai *dai)
 {
@@ -1510,6 +1540,9 @@ static int sof_ipc3_widget_setup_comp_dai(struct snd_sof_widget *swidget)
 		case SOF_DAI_AMD_SP:
 			ret = sof_link_acp_sp_load(scomp, slink, config, dai);
 			break;
+		case SOF_DAI_AMD_HS:
+			ret = sof_link_acp_hs_load(scomp, slink, config, dai);
+			break;
 		case SOF_DAI_AMD_DMIC:
 			ret = sof_link_acp_dmic_load(scomp, slink, config, dai);
 			break;
diff --git a/sound/soc/sof/topology.c b/sound/soc/sof/topology.c
index 9273a70fec25..f7b3302ec202 100644
--- a/sound/soc/sof/topology.c
+++ b/sound/soc/sof/topology.c
@@ -287,6 +287,7 @@ static const struct sof_dai_types sof_dais[] = {
 	{"ACP", SOF_DAI_AMD_BT},
 	{"ACPSP", SOF_DAI_AMD_SP},
 	{"ACPDMIC", SOF_DAI_AMD_DMIC},
+	{"ACPHS", SOF_DAI_AMD_HS},
 	{"AFE", SOF_DAI_MEDIATEK_AFE},
 };
 
-- 
2.25.1

