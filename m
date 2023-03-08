Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B5836AD964
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 09:41:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229896AbjCGIlN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 03:41:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229907AbjCGIlH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 03:41:07 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on20625.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe5b::625])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD90B4D63F
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 00:41:04 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YjNbEBJcVkbb9IXdbJ5cN+vslS3esq3FynoV2muYknXOT/e3EWNNygzh7ICoCny7k5vWCHrIHIHtTLwCjPq9prQAHAYJooSJC13uSzVLdZNg0pB3yXorDkcCZxn3NVwPTzPEGVdyW+ozl50qZv97QvWWUUc6bV2Rp6aRMCAPTkIB4QFf34WQS60sQ/ZS5ZhQJC8io47vWJpBTBvt0OU9QkJCWQAsprcbWLRpStxr4u70wfoR0kv149oh6FMOYCY7iFIKOycxN4ecwXY17GwpewA9QIBtJEj4u1usDyObQjoZocwP06gLGi+9HHu/M5VvDBTSwlDFr/y49ttoWG+XQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BEwpYsLnbbxY3CztZlAHXbj7sO07miHGIO915JSHMh0=;
 b=a04X3NtMocG/rbqYTyf0KwNk0d9+iNfgA3Q0SwELHK+qxlYR8znRybV1GSKY1BaC0lVdT1RKPoDD2AlnnyOYAhJ9n7zscZjs4/EjTHR5rixdA280jm4ujKJGpzdILL4JS/7Z8yQnUkTciCp4n2iDRT5aCP6/1NsjgAhHiFjT3IibCA5rOxrG9Cve66DJiYlnlvQNOXLf10nQ5RgX0gRm7gp/A8ju2QByu5JShd2AlcnUmD7KdTh2mFpjbeMCn8HhhS2LNxKXoMp5+D0MUBeMHpqs/GR1t8tyFAixAMFZz/BAZ5HX511f3YFOBZZmkq6tYnd1p+ZxHdefMNOyhUSikQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BEwpYsLnbbxY3CztZlAHXbj7sO07miHGIO915JSHMh0=;
 b=bQVWvwm1VfdpshZiSiT+8lmwOcPhvgCo9M++KXj5x76h79nt8LXEnd0LAKotP6BTAHJxAGpuOLETuoA9B8TJB6BzQv5Sua5Z6vmssyyjckJWb9enSkESlCRB+QSKkZk5EYyGPH/o0T1BbEHFyqs9QeQWuOINC8QIhkU6DYr4g6w=
Received: from MW4PR04CA0158.namprd04.prod.outlook.com (2603:10b6:303:85::13)
 by DM6PR12MB4121.namprd12.prod.outlook.com (2603:10b6:5:220::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.29; Tue, 7 Mar
 2023 08:41:01 +0000
Received: from CO1NAM11FT024.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:85:cafe::d9) by MW4PR04CA0158.outlook.office365.com
 (2603:10b6:303:85::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.28 via Frontend
 Transport; Tue, 7 Mar 2023 08:41:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT024.mail.protection.outlook.com (10.13.174.162) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6178.14 via Frontend Transport; Tue, 7 Mar 2023 08:41:01 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 7 Mar
 2023 02:40:58 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 7 Mar
 2023 00:40:58 -0800
Received: from sof-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.34
 via Frontend Transport; Tue, 7 Mar 2023 02:40:48 -0600
From:   V sujith kumar Reddy <Vsujithkumar.Reddy@amd.com>
To:     <broonie@kernel.org>, <alsa-devel@alsa-project.org>
CC:     <Vijendar.Mukunda@amd.com>, <Basavaraj.Hiregoudar@amd.com>,
        <Sunil-kumar.Dommati@amd.com>, <ajitkumar.pandey@amd.com>,
        "V sujith kumar Reddy" <Vsujithkumar.Reddy@amd.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        "Ajit Kumar Pandey" <AjitKumar.Pandey@amd.com>,
        Rander Wang <rander.wang@intel.com>,
        "moderated list:SOUND - SOUND OPEN FIRMWARE (SOF) DRIVERS" 
        <sound-open-firmware@alsa-project.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/2] ASoC: SOF: amd: Add pcm pointer callback for amd platforms.
Date:   Wed, 8 Mar 2023 14:15:08 +0530
Message-ID: <20230308084509.1496256-2-Vsujithkumar.Reddy@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230308084509.1496256-1-Vsujithkumar.Reddy@amd.com>
References: <20230308084509.1496256-1-Vsujithkumar.Reddy@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT024:EE_|DM6PR12MB4121:EE_
X-MS-Office365-Filtering-Correlation-Id: edc140d5-84c6-412a-981d-08db1ee7ae4c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1XaKtAefwLWNTtRrjPoRzLt5TuRsJa1NTwqAECAfzF4KxD+LZXv3OyGJMuCrp6/t4k/8LFnWiFaFvGCE9mGu7SN504QTsCSjhELZLDZt1s49iulgG21ejXT4+ZkcbfTNs/UMcaKy6vV/naWif/JZgasnvkWjgjd4T81cE9TOyzgNofkNgWBbt8+M9jzBkWRJgKAw9VdqpmKfdgP5rfKIfeXOa4++qzPpXtjwuK36IuwFiCFSJbj12mOv6Awb6JwHf6HoAKZxnPzM9nQrkGneFN3NTXw7xcFZeGnWP0jW1GN5proi3BBsL4Q1KRDi7QVAR0dJw7Nz5S1bAIe+B8G3L2qrtb9cmz8ccbiyujDuFH7nYJ/VFvQhCbfYCFV7pRi1bi/RcTglaubKLpmGH9zHARdg5oDGH5IsmBOPEPb5KkmD791YR40x821t7FSOvpz2YbKwrkJMmnYR6CsgQmJH5BymK7VpKSz0cj2t3ZYeBtr/2I8C4pFAfm1Jtv0xDMPpAbTXG7DeUNHsLb/ddmP7Nxv8hRXz1Apd25a7aI0ZYzlrnJ5pHNRnMt7JPT8LryLQdBFuV/GPnEb5ktsWBxurn+FNs7bhB2te41aoflQYFvoHscPT3AyL7Y/krqqeUelCvU6bjJB6Wh2f8s0yOFeAdXiCjmeLuAIslpngNPUHccl86I6NuQ+23RCe5+RqwXt/l6Lc6ePe4mNWXp+2bY49DlsukogZRAYhHSstSkDCwRA=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(136003)(376002)(396003)(346002)(451199018)(46966006)(36840700001)(40470700004)(8676002)(36756003)(40480700001)(70586007)(70206006)(4326008)(41300700001)(5660300002)(7416002)(2906002)(82740400003)(81166007)(356005)(86362001)(36860700001)(8936002)(6666004)(1076003)(26005)(7696005)(478600001)(316002)(110136005)(54906003)(82310400005)(83380400001)(426003)(47076005)(336012)(2616005)(40460700003)(186003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2023 08:41:01.2028
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: edc140d5-84c6-412a-981d-08db1ee7ae4c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT024.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4121
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_24_48,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add pcm pointer callback for amd platforms to read host position
update from stream box.

Signed-off-by: V sujith kumar Reddy <Vsujithkumar.Reddy@amd.com>
---
 sound/soc/sof/amd/acp-common.c |  1 +
 sound/soc/sof/amd/acp-pcm.c    | 33 +++++++++++++++++++++++++++++++++
 sound/soc/sof/amd/acp.h        |  2 ++
 3 files changed, 36 insertions(+)

diff --git a/sound/soc/sof/amd/acp-common.c b/sound/soc/sof/amd/acp-common.c
index bd6c1b198736..8ce4c8956933 100644
--- a/sound/soc/sof/amd/acp-common.c
+++ b/sound/soc/sof/amd/acp-common.c
@@ -187,6 +187,7 @@ struct snd_sof_dsp_ops sof_acp_common_ops = {
 	.pcm_open		= acp_pcm_open,
 	.pcm_close		= acp_pcm_close,
 	.pcm_hw_params		= acp_pcm_hw_params,
+	.pcm_pointer		= acp_pcm_pointer,
 
 	.hw_info		= SNDRV_PCM_INFO_MMAP |
 				  SNDRV_PCM_INFO_MMAP_VALID |
diff --git a/sound/soc/sof/amd/acp-pcm.c b/sound/soc/sof/amd/acp-pcm.c
index 727c3a784a20..f342f0bac4a3 100644
--- a/sound/soc/sof/amd/acp-pcm.c
+++ b/sound/soc/sof/amd/acp-pcm.c
@@ -84,3 +84,36 @@ int acp_pcm_close(struct snd_sof_dev *sdev, struct snd_pcm_substream *substream)
 	return acp_dsp_stream_put(sdev, stream);
 }
 EXPORT_SYMBOL_NS(acp_pcm_close, SND_SOC_SOF_AMD_COMMON);
+
+snd_pcm_uframes_t acp_pcm_pointer(struct snd_sof_dev *sdev,
+				  struct snd_pcm_substream *substream)
+{
+	struct snd_soc_pcm_runtime *rtd = asoc_substream_to_rtd(substream);
+	struct snd_soc_component *scomp = sdev->component;
+	struct snd_sof_pcm_stream *stream;
+	struct sof_ipc_stream_posn posn;
+	struct snd_sof_pcm *spcm;
+	snd_pcm_uframes_t pos;
+	int ret;
+
+	spcm = snd_sof_find_spcm_dai(scomp, rtd);
+	if (!spcm) {
+		dev_warn_ratelimited(sdev->dev, "warn: can't find PCM with DAI ID %d\n",
+				     rtd->dai_link->id);
+		return 0;
+	}
+
+	stream = &spcm->stream[substream->stream];
+	ret = snd_sof_ipc_msg_data(sdev, stream, &posn, sizeof(posn));
+	if (ret < 0) {
+		dev_warn(sdev->dev, "failed to read stream position: %d\n", ret);
+		return 0;
+	}
+
+	memcpy(&stream->posn, &posn, sizeof(posn));
+	pos = spcm->stream[substream->stream].posn.host_posn;
+	pos = bytes_to_frames(substream->runtime, pos);
+
+	return pos;
+}
+EXPORT_SYMBOL_NS(acp_pcm_pointer, SND_SOC_SOF_AMD_COMMON);
diff --git a/sound/soc/sof/amd/acp.h b/sound/soc/sof/amd/acp.h
index 39165ebf684b..acad57947616 100644
--- a/sound/soc/sof/amd/acp.h
+++ b/sound/soc/sof/amd/acp.h
@@ -238,6 +238,8 @@ int acp_pcm_close(struct snd_sof_dev *sdev, struct snd_pcm_substream *substream)
 int acp_pcm_hw_params(struct snd_sof_dev *sdev, struct snd_pcm_substream *substream,
 		      struct snd_pcm_hw_params *params,
 		      struct snd_sof_platform_stream_params *platform_params);
+snd_pcm_uframes_t acp_pcm_pointer(struct snd_sof_dev *sdev,
+				  struct snd_pcm_substream *substream);
 
 extern struct snd_sof_dsp_ops sof_acp_common_ops;
 
-- 
2.25.1

