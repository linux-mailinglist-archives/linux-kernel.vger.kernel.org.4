Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C767B635CA2
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 13:21:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237023AbiKWMUc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 07:20:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237089AbiKWMUR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 07:20:17 -0500
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2057.outbound.protection.outlook.com [40.107.100.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1837B490A2
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 04:20:12 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e4ODTzMwT/RfrRPJnqZP1ABZdf8Y12aVkhkByVA5FhvOR3KZtwHEsBKZbS7G+pnwRlQwcMGLx4v2atbTiR7r8EI9ritblVa/9Ju/RmW0S3yMo3mAP+N+pOuze+A92nHUkreA24ED92tDvznjGW/ZZydMBvlk8RAr1iPvXTR7eKdArfjhYRN8WTAAMGCvIoRVNG9hAlGXl5MSLt57xN9xGoMnvCIB8M70/fRL90Y1MJRtKkrvAUql1y6d11RlcpZyZWpCsJV5R74yz7LznKIGPVCnfPVNgoqkdgcOZdD+ZzAgHzcSJFLZGzagw+XFuXQ5VCZ/xJ57uH9fQB/f8mp9zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MYRKPH/S1XOqokAaSfdQoVH+BcxfQ5FO55P+rPeA9Dg=;
 b=V157ThACpYqekY9AZkO0xSrHZfaqGQoiMoM7AZQIOcRh7Pc57/2iU88hId2jDx4E6QBpMD3Qq/9meE1geCXDROethnyDd2BiadN4LgJogEezK0Zo21qXUsFr3wp2AIk1v4gMCKueK6dExsfvWdSWyF7ulFq4rN/8YEjUE3FmPdOdu2yqs6TSIewb5bVWzNwxnfk268RRS9UHHAgGp5j9IsnB/5PhJrzBrLAtQWw3Jf3FqhVi7EdeWeafRzfBh7i1sA9uiVOqeEHbXs/DpwdaoaR50k76c4IeD2XvUKTJ6lUNLbHroSlk0DeLOezsbOoMrC41Y7ISnM9xbAX3mOUt+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 165.204.84.17) smtp.rcpttodomain=kernel.org
 smtp.mailfrom=amd.corp-partner.google.com; dmarc=fail (p=reject sp=reject
 pct=100) action=oreject header.from=amd.corp-partner.google.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MYRKPH/S1XOqokAaSfdQoVH+BcxfQ5FO55P+rPeA9Dg=;
 b=DJACHXffOtGiY4/fgyRzReOgW4aDqf7x+WcM+s/feQ0c9+dS89asRnon2s8k3TlxuTCzcSjePkblRp7T6RcDb1Dcag/cX7iQSlEBDzTVWeNglxu/cUF56A28cITXfhHmkky4Ec2O/qQv1o4qqGfFhAqF6bKq60cfhSWBg88O0eiDsSgBB1H5QbFZTphMih2KCC4QNdRqtpe/KvhlsBbMKRWvyCYGCEegpWRhtIn7+mpmKVVGJVB88nvDY7U/dqfj3gGAAD/JiBcVS4nmHQHoLzz8njA7Dvb4mPnKtxeQeGkclnSrkrUvqdLy3s+dPZzsvGNZS0oPbirBvszgGSljnA==
Received: from MW2PR2101CA0015.namprd21.prod.outlook.com (2603:10b6:302:1::28)
 by IA0PR12MB7776.namprd12.prod.outlook.com (2603:10b6:208:430::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.15; Wed, 23 Nov
 2022 12:20:07 +0000
Received: from CO1NAM11FT078.eop-nam11.prod.protection.outlook.com
 (2603:10b6:302:1:cafe::fd) by MW2PR2101CA0015.outlook.office365.com
 (2603:10b6:302:1::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.3 via Frontend
 Transport; Wed, 23 Nov 2022 12:20:07 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 165.204.84.17) smtp.mailfrom=amd.corp-partner.google.com; dkim=none (message
 not signed) header.d=none;dmarc=fail action=oreject
 header.from=amd.corp-partner.google.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 amd.corp-partner.google.com discourages use of 165.204.84.17 as permitted
 sender)
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT078.mail.protection.outlook.com (10.13.175.177) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5834.8 via Frontend Transport; Wed, 23 Nov 2022 12:20:07 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 23 Nov
 2022 06:19:28 -0600
Received: from sof-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.34
 via Frontend Transport; Wed, 23 Nov 2022 06:19:22 -0600
From:   V sujith kumar Reddy 
        <vsujithkumar.reddy@amd.corp-partner.google.com>
To:     <broonie@kernel.org>, <alsa-devel@alsa-project.org>
CC:     <Vijendar.Mukunda@amd.com>, <Basavaraj.Hiregoudar@amd.com>,
        <Sunil-kumar.Dommati@amd.com>, <venkataprasad.potturu@amd.com>,
        <ssabakar@amd.com>,
        V sujith kumar Reddy <Vsujithkumar.Reddy@amd.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
        "Bard Liao" <yung-chuan.liao@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        "Ajit Kumar Pandey" <AjitKumar.Pandey@amd.com>,
        Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>,
        Rander Wang <rander.wang@intel.com>,
        "moderated list:SOUND - SOUND OPEN FIRMWARE (SOF) DRIVERS" 
        <sound-open-firmware@alsa-project.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH v1 3/4] ASoC: SOF: amd: ADD HS and SP virtual DAI.
Date:   Wed, 23 Nov 2022 17:49:10 +0530
Message-ID: <20221123121911.3446224-4-vsujithkumar.reddy@amd.corp-partner.google.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221123121911.3446224-1-vsujithkumar.reddy@amd.corp-partner.google.com>
References: <20221123121911.3446224-1-vsujithkumar.reddy@amd.corp-partner.google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT078:EE_|IA0PR12MB7776:EE_
X-MS-Office365-Filtering-Correlation-Id: 5be7c558-97f9-4383-7579-08dacd4d0f08
X-MS-Exchange-SenderADCheck: 2
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: V1/sG1BxTeADR9fO6WzJR4sWD5SKG7sBg/JYrv9kBk+LmoAx3JY3nRWQ89XRmPHLGL1VFHdn61aistrasrNlo9IPQeZYRtldsVYAGZr/q7EUBlw5E6tqVKhlzqXYwVUE/h/adI19TF2FN0PQDQrRii75XUsEQO5TRZ9x41MuNOGT3YwO7gIVBQ29IuFpnELK46fmN08WyogUPkH9DEFFQnO8vhlT9yU9oD2rUI4OwEyc2ofdMoZhDTvLfeUQrdayK5yS8Aou0FAU08Lsdk5KGYdxyc+dc4UPE+NP69AMDrVhH21LzRyaeGU+Kfc+Glt8CixJ3oee830zFNCvpYms9UgX8kFI7fhnpZpIzXX42vf9VMOJuyaHAArXJZHt+PqEanX8rG7yvMBwD9gbCC7RIRpqsswcJeBJMcCDW9OkwshdtXLj5jFZ1+kvl8H0kVvOiXakbK3epdOFfNsKD8az7lVLhkph2yTuIEJzoUByGUYilYcmCiiv9RwlX+0YKw4CfFgs0fiaqPpWoMxmzMudLmxZtXPLA1lBguFSAcRK2h/DZ+xBLX03mF10LJPDcuoYcR3jLB9rG4uxNCp3ZMH9p3So13yDmyMOaSFmrDglRX5F4PrxcLcyfaTEhK9PK2YIoFi3yiTx4Noy3Lcf6qkjANJ5dTwJLENM3dheaiz6TWQhoPHFMwsEGYTplyTYRbG6j4kHEHBkFbEYVvSfbev2ww==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(136003)(376002)(346002)(396003)(451199015)(46966006)(40470700004)(86362001)(81166007)(26005)(356005)(82740400003)(82310400005)(2616005)(2906002)(336012)(1076003)(110136005)(54906003)(40460700003)(35950700001)(47076005)(8936002)(5660300002)(40480700001)(7416002)(498600001)(6666004)(41300700001)(8676002)(316002)(70206006)(76482006)(70586007)(4326008);DIR:OUT;SFP:1101;
X-OriginatorOrg: amdcloud.onmicrosoft.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2022 12:20:07.3172
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5be7c558-97f9-4383-7579-08dacd4d0f08
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT078.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7776
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: V sujith kumar Reddy <Vsujithkumar.Reddy@amd.com>

ADD HS and SP virtual DAI driver to support AMD platforms.

Signed-off-by: V sujith kumar Reddy <Vsujithkumar.Reddy@amd.com>
---
 sound/soc/sof/amd/rembrandt.c | 16 ++++++++++++++++
 sound/soc/sof/amd/renoir.c    | 16 ++++++++++++++++
 2 files changed, 32 insertions(+)

diff --git a/sound/soc/sof/amd/rembrandt.c b/sound/soc/sof/amd/rembrandt.c
index dcb64a23e121..5288ab882fc9 100644
--- a/sound/soc/sof/amd/rembrandt.c
+++ b/sound/soc/sof/amd/rembrandt.c
@@ -23,6 +23,7 @@
 #define I2S_BT_INSTANCE		1
 #define I2S_SP_INSTANCE		2
 #define PDM_DMIC_INSTANCE	3
+#define I2S_HS_VIRTUAL_INSTANCE	4
 
 static struct snd_soc_dai_driver rembrandt_sof_dai[] = {
 	[I2S_HS_INSTANCE] = {
@@ -112,6 +113,21 @@ static struct snd_soc_dai_driver rembrandt_sof_dai[] = {
 			.rate_max = 48000,
 		},
 	},
+
+	[I2S_HS_VIRTUAL_INSTANCE] = {
+		.id = I2S_HS_VIRTUAL_INSTANCE,
+		.name = "acp-sof-hs-virtual",
+		.playback = {
+			.rates = SNDRV_PCM_RATE_8000_96000,
+			.formats = SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S8 |
+				   SNDRV_PCM_FMTBIT_U8 | SNDRV_PCM_FMTBIT_S32_LE,
+			.channels_min = 2,
+			.channels_max = 8,
+			.rate_min = 8000,
+			.rate_max = 96000,
+		},
+		.probe = &acp_dai_probe,
+	},
 };
 
 /* Rembrandt ops */
diff --git a/sound/soc/sof/amd/renoir.c b/sound/soc/sof/amd/renoir.c
index 6ea8727f977e..adade2e3d3be 100644
--- a/sound/soc/sof/amd/renoir.c
+++ b/sound/soc/sof/amd/renoir.c
@@ -22,6 +22,7 @@
 #define I2S_BT_INSTANCE		0
 #define I2S_SP_INSTANCE		1
 #define PDM_DMIC_INSTANCE	2
+#define I2S_SP_VIRTUAL_INSTANCE	3
 
 static struct snd_soc_dai_driver renoir_sof_dai[] = {
 	[I2S_BT_INSTANCE] = {
@@ -86,6 +87,21 @@ static struct snd_soc_dai_driver renoir_sof_dai[] = {
 			.rate_max = 48000,
 		},
 	},
+
+	[I2S_SP_VIRTUAL_INSTANCE] = {
+		.id = I2S_SP_VIRTUAL_INSTANCE,
+		.name = "acp-sof-sp-virtual",
+		.playback = {
+			.rates = SNDRV_PCM_RATE_8000_96000,
+			.formats = SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S8 |
+				   SNDRV_PCM_FMTBIT_U8 | SNDRV_PCM_FMTBIT_S32_LE,
+			.channels_min = 2,
+			.channels_max = 8,
+			.rate_min = 8000,
+			.rate_max = 96000,
+		},
+		.probe = &acp_dai_probe,
+	},
 };
 
 /* Renoir ops */
-- 
2.25.1

