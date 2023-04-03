Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 904886D3DE8
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 09:14:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231709AbjDCHOD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 03:14:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231530AbjDCHNg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 03:13:36 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2045.outbound.protection.outlook.com [40.107.244.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0CF383E0
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 00:13:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EatI6ZKJk6jvgAazpQDfJoknxZZlhrXOqCB/O9SgAa+CnSujLwTwG2If0XrEW9x1qE7vPBh6eaG7wwYF+P12pp55vzfj3vBl89A70grCRzjRsmtYWXt6BMRaHkW1NyeNWm2FjzJ0rOfyn0wAV6IFtQPkPvtc5xKrbbuA1r4XBWg0M5LkNhyLfN9/jX6s57V6tailGBuGBqdOzgQM9fd3/hiVXXWwVVWbgDXzYYvPWXvEUA8aco3Axmjn1HhTbHkhLHObbGP9sNrCQGCnoJ6SAnIsFpvFAjIxZvR+PimPu38Z3vaTX3baYJux7RlD92wTbxhRkxVRbeqoPZYz8Q3QXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a8K0kPBo0TooEDURIhzOjlCFAL/SHOUXCK2CdNyCA6Y=;
 b=hMZepzat4YoMvnkIM7bSkFWXEzCSvqX8ksu3kXZBN0q6TPOsggKLVUQDAzMm/qr4O8P/gA+080GBHc5GmKNxeo40pAeSp42m8Ab70wxfTv1++lELsfjtB7WUoYX90jpDfIt2V4sHdZWFmD4LQDJwkzndHrwEN0kXqOY7YlWhl/PNAUBeP4FYyfBBCkreLpmVEGbSpB0KbKuATy9oD5qIorzzIm7U8VNfEFJ5ICggfxoDoeLt0WOcSQ38/ZSyrTYIoe5GjHtayW2sYD2APSFFhc2fK96eRFUMp82guU1yZtgiLRINq3UgkoVai3z4PTWTJyfnIii5/L/AT+jOs4Hudw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a8K0kPBo0TooEDURIhzOjlCFAL/SHOUXCK2CdNyCA6Y=;
 b=NvTVDFiqt++/kgEGuNHOnmFwq06pCFZr6FAr3hQXSotTrQs4OTNh9XuPl8GqCW/roDuZTVmbA9scLZt3jjdRp1gse+ZW5poXAJUWbfFep/aDhiECUhR6jPiPyrt4NNlsJ1701I+IzmuMQOgGQrE72jLXr7ByzLlGOsy4ie0W4iM=
Received: from MW4PR04CA0320.namprd04.prod.outlook.com (2603:10b6:303:82::25)
 by CH2PR12MB4214.namprd12.prod.outlook.com (2603:10b6:610:aa::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.33; Mon, 3 Apr
 2023 07:13:32 +0000
Received: from CO1NAM11FT063.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:82:cafe::28) by MW4PR04CA0320.outlook.office365.com
 (2603:10b6:303:82::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.22 via Frontend
 Transport; Mon, 3 Apr 2023 07:13:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT063.mail.protection.outlook.com (10.13.175.37) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6277.14 via Frontend Transport; Mon, 3 Apr 2023 07:13:31 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 3 Apr
 2023 02:13:29 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 3 Apr
 2023 02:13:29 -0500
Received: from vijendar-X570-GAMING-X.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.34
 via Frontend Transport; Mon, 3 Apr 2023 02:13:25 -0500
From:   Vijendar Mukunda <Vijendar.Mukunda@amd.com>
To:     <broonie@kernel.org>
CC:     <alsa-devel@alsa-project.org>, <Basavaraj.Hiregoudar@amd.com>,
        <Sunil-kumar.Dommati@amd.com>,
        Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
        "Bard Liao" <yung-chuan.liao@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        "V sujith kumar Reddy" <Vsujithkumar.Reddy@amd.com>,
        Ajit Kumar Pandey <AjitKumar.Pandey@amd.com>,
        "moderated list:SOUND - SOUND OPEN FIRMWARE (SOF) DRIVERS" 
        <sound-open-firmware@alsa-project.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/6] ASoC: SOF: amd: remove acp_dai_probe() function
Date:   Mon, 3 Apr 2023 12:46:42 +0530
Message-ID: <20230403071651.919027-2-Vijendar.Mukunda@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230403071651.919027-1-Vijendar.Mukunda@amd.com>
References: <20230403071651.919027-1-Vijendar.Mukunda@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT063:EE_|CH2PR12MB4214:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c8edd95-836a-40d4-9ce5-08db3412ee84
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Bh5Efio6CEkkC+S9C05gYEYWGCjH7jNBgabN8UzJdZB3vgxSoKXT73Vki0M6U9tgmyhCuo2DCojZObnkYv1tE3LyjGBYfI65fZG7fXnu5ZIJcEv3MrhvBPERf1UNVfNqjgzFRbtV3MLAktX4Y4pMWxCw+5gZMUuNBXvH142bdnMfUutkE3sqYMHb3pbBqhG3HN2gE8sM4FgCczl+m0y9aPNqo75Gdq4x9GcebHyYhWEcREhIhHizte7o3NkjsWf7YyziNFu+LF63LsXwyuBaKPvHGAZYaPLXoez8SWA/pCJJYXQ8rs2xwvSNnCECQJu5BfUzsbtCf/IShIlf3+ZgTSdoLX65bncRK/KFFLzATHuPXyeuELdq5MhNgP+tpBp+VZymbg1DwO8BdxTU0lsvWea2DbPgeoctzCgpMkiquny7BSki/ILBHnXL4Vb74zf1sACV3u/Ku2ElADIxCeUAlpoeV+9TsBxPbBgfaM96/fGXJRRtS7+tlpRN191EihVg9AL+x5Q40U7XzxggGXpzkXbi6YeY0A18AO9aYg++LYqyYUsim9JJyQGr2ctfPD4TOsTFdGzIxKPiVNBalY93MP4q2YDjXVLqTHOoTlO9U2C+wuDLMq3fzJBKnhUfiJj5KwDJ8uJtH1mC1P8UmFVbjyZ1RHVzafbJqtOIHe9BX0GPq7Hz87RybAbIkc5VFzLSnFzpe+CLI+PZlGSAigEDK+ndO1v73+2IqM/zo10mduQ=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(376002)(346002)(136003)(451199021)(46966006)(40470700004)(36840700001)(7416002)(41300700001)(4326008)(82740400003)(82310400005)(8936002)(81166007)(6916009)(26005)(356005)(316002)(5660300002)(86362001)(54906003)(70206006)(70586007)(8676002)(36860700001)(478600001)(2906002)(47076005)(83380400001)(336012)(426003)(7696005)(40460700003)(2616005)(186003)(40480700001)(36756003)(6666004)(1076003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2023 07:13:31.7375
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c8edd95-836a-40d4-9ce5-08db3412ee84
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT063.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4214
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ACP SOF driver supports different audio configurations.
Explicit condition check for I2S configuration will break
other audio endpoint configurations.

acp_dai_probe() function is not required as we have
machine select logic to select the exact machine.

Remove acp_dai_probe() from existing AMD PCI driver code base.

Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
---
 sound/soc/sof/amd/acp-common.c | 16 ----------------
 sound/soc/sof/amd/acp.h        |  1 -
 sound/soc/sof/amd/rembrandt.c  |  4 ----
 sound/soc/sof/amd/renoir.c     |  3 ---
 4 files changed, 24 deletions(-)

diff --git a/sound/soc/sof/amd/acp-common.c b/sound/soc/sof/amd/acp-common.c
index 8ce4c8956933..df36b411a12e 100644
--- a/sound/soc/sof/amd/acp-common.c
+++ b/sound/soc/sof/amd/acp-common.c
@@ -18,22 +18,6 @@
 #include "acp-dsp-offset.h"
 #include <sound/sof/xtensa.h>
 
-int acp_dai_probe(struct snd_soc_dai *dai)
-{
-	struct snd_sof_dev *sdev = snd_soc_component_get_drvdata(dai->component);
-	const struct sof_amd_acp_desc *desc = get_chip_info(sdev->pdata);
-	unsigned int val;
-
-	val = snd_sof_dsp_read(sdev, ACP_DSP_BAR, desc->i2s_pin_config_offset);
-	if (val != desc->i2s_mode) {
-		dev_err(sdev->dev, "I2S Mode is not supported (I2S_PIN_CONFIG: %#x)\n", val);
-		return -EINVAL;
-	}
-
-	return 0;
-}
-EXPORT_SYMBOL_NS(acp_dai_probe, SND_SOC_SOF_AMD_COMMON);
-
 /**
  * amd_sof_ipc_dump() - This function is called when IPC tx times out.
  * @sdev: SOF device.
diff --git a/sound/soc/sof/amd/acp.h b/sound/soc/sof/amd/acp.h
index acad57947616..d7fc24917b3c 100644
--- a/sound/soc/sof/amd/acp.h
+++ b/sound/soc/sof/amd/acp.h
@@ -248,7 +248,6 @@ int sof_renoir_ops_init(struct snd_sof_dev *sdev);
 extern struct snd_sof_dsp_ops sof_rembrandt_ops;
 int sof_rembrandt_ops_init(struct snd_sof_dev *sdev);
 
-int acp_dai_probe(struct snd_soc_dai *dai);
 struct snd_soc_acpi_mach *amd_sof_machine_select(struct snd_sof_dev *sdev);
 /* Machine configuration */
 int snd_amd_acp_find_config(struct pci_dev *pci);
diff --git a/sound/soc/sof/amd/rembrandt.c b/sound/soc/sof/amd/rembrandt.c
index 5288ab882fc9..f1d1ba57ab3a 100644
--- a/sound/soc/sof/amd/rembrandt.c
+++ b/sound/soc/sof/amd/rembrandt.c
@@ -48,7 +48,6 @@ static struct snd_soc_dai_driver rembrandt_sof_dai[] = {
 			.rate_min = 8000,
 			.rate_max = 48000,
 		},
-		.probe = &acp_dai_probe,
 	},
 
 	[I2S_BT_INSTANCE] = {
@@ -73,7 +72,6 @@ static struct snd_soc_dai_driver rembrandt_sof_dai[] = {
 			.rate_min = 8000,
 			.rate_max = 48000,
 		},
-		.probe = &acp_dai_probe,
 	},
 
 	[I2S_SP_INSTANCE] = {
@@ -98,7 +96,6 @@ static struct snd_soc_dai_driver rembrandt_sof_dai[] = {
 			.rate_min = 8000,
 			.rate_max = 48000,
 		},
-		.probe = &acp_dai_probe,
 	},
 
 	[PDM_DMIC_INSTANCE] = {
@@ -126,7 +123,6 @@ static struct snd_soc_dai_driver rembrandt_sof_dai[] = {
 			.rate_min = 8000,
 			.rate_max = 96000,
 		},
-		.probe = &acp_dai_probe,
 	},
 };
 
diff --git a/sound/soc/sof/amd/renoir.c b/sound/soc/sof/amd/renoir.c
index adade2e3d3be..47b863f6258c 100644
--- a/sound/soc/sof/amd/renoir.c
+++ b/sound/soc/sof/amd/renoir.c
@@ -47,7 +47,6 @@ static struct snd_soc_dai_driver renoir_sof_dai[] = {
 			.rate_min = 8000,
 			.rate_max = 48000,
 		},
-		.probe = &acp_dai_probe,
 	},
 
 	[I2S_SP_INSTANCE] = {
@@ -72,7 +71,6 @@ static struct snd_soc_dai_driver renoir_sof_dai[] = {
 			.rate_min = 8000,
 			.rate_max = 48000,
 		},
-		.probe = &acp_dai_probe,
 	},
 
 	[PDM_DMIC_INSTANCE] = {
@@ -100,7 +98,6 @@ static struct snd_soc_dai_driver renoir_sof_dai[] = {
 			.rate_min = 8000,
 			.rate_max = 96000,
 		},
-		.probe = &acp_dai_probe,
 	},
 };
 
-- 
2.34.1

