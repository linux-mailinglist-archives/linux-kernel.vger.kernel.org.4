Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED01562925A
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 08:20:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232114AbiKOHUI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 02:20:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230033AbiKOHUD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 02:20:03 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2069.outbound.protection.outlook.com [40.107.244.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52123201A6
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 23:20:01 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UEdyknLonhkUkDc1Eu+AS+wzmoIJFYccUGjxUW1k82kWy7E2E4So+8QpJ+uMOzllpMTCIJmTkfpNM0FdiFdqRyuFVm5ZxPbINafBtQ2ov3G73FnFt9Rzz8bPz2Sk6p3a3aHVV7tPF8MYeoEgyjJlX8xgS6gKS4hg1piyhcHcODS6C0EKTjN4QNLvL1VZSjRkFw8A5FJG44WhfiWDvPaRkSXvFT99LdLMcwq1XsJFW+zmFGk+G96nT4E2xO1yRm4/M5zBb8DFbViw3Vj16AHzQ/Oa5NTiIEdHGSBtO9Mo8rsIUS+sGNkiO6c29jLMG8KVrHDIs+RXDfZG8m1VWjrWuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3pgG9VSFuO6OG8GM/Y0pcfImjhIJDDUBwo/trrE3kRw=;
 b=NqWgVSBv5tY0ZHk3b2iYM9cWa95annHlg16MncV+JHmkrfS7EIQT4+1uDOD9Q+H4PV2yTcuWQW19eTHzQRJ42ejmF/iTz8L87d18gLmkm4hcu4wVt3pVMEyhJlsLwDyU83PrfFhS91Ia/mhEETX+6KzsqwIoCUCfduwND0zD0q8Gtw7b9V3Tv+v4ZNx49a51K2yw6fSfgdCxC3wFCPyhx6qbwt2AUNDZpsd7GPxcBk2qQtSs2b3Ucgd2/ITg0xeVHSxelis743lTlqONcAIANUjjfdgLy8XM9boqQd2p6dyPXlPZxnRzCzDFB4PYGtRYAssMXGyJJMthlhiCXNttNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3pgG9VSFuO6OG8GM/Y0pcfImjhIJDDUBwo/trrE3kRw=;
 b=Ip+sE7+kAVorjS1DhJq110zwJp5u/GiiYk4HYcnH7Ht2CqXkRKwWKSaKzdilgHUcP28peMLn/DMI/5dZ4Wnfz7IZ+d4lG/XPYUshUq3x+FuaYTfS3w+HLvVHcWfX0pGTeuXPSWOE9I+0nMOwOXbBBGMwGbyFswRI8/g0t8iVHAU=
Received: from BN7PR06CA0063.namprd06.prod.outlook.com (2603:10b6:408:34::40)
 by SN7PR12MB7249.namprd12.prod.outlook.com (2603:10b6:806:2a9::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.13; Tue, 15 Nov
 2022 07:19:58 +0000
Received: from BL02EPF0000EE3E.namprd05.prod.outlook.com
 (2603:10b6:408:34:cafe::17) by BN7PR06CA0063.outlook.office365.com
 (2603:10b6:408:34::40) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.17 via Frontend
 Transport; Tue, 15 Nov 2022 07:19:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0000EE3E.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5813.11 via Frontend Transport; Tue, 15 Nov 2022 07:19:58 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 15 Nov
 2022 01:19:53 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 14 Nov
 2022 23:19:49 -0800
Received: from sof-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.34
 via Frontend Transport; Tue, 15 Nov 2022 01:19:44 -0600
From:   V sujith kumar Reddy <Vsujithkumar.Reddy@amd.com>
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
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        "moderated list:SOUND - SOUND OPEN FIRMWARE (SOF) DRIVERS" 
        <sound-open-firmware@alsa-project.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/4] ASoC: SOF: amd: Fix for reading position updates from stream box.
Date:   Tue, 15 Nov 2022 12:49:53 +0530
Message-ID: <20221115072001.1931617-1-Vsujithkumar.Reddy@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0000EE3E:EE_|SN7PR12MB7249:EE_
X-MS-Office365-Filtering-Correlation-Id: 507890a3-c8eb-41ed-5356-08dac6d9cd88
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BvqL5Z+GirOquKgsGFfIYVWRBNHS/nbjN2L0uFJb5vFo8vcjHVGN9sX/1kw3WExVMGHMJVQv9d1x7dBq/C6cvl/7HDadNZunIFHTJoGw0X9w+KGHB3fS/+ZWvsd4Ms3DRuQ40+xF8zvXaNBDLnxjcNIfiIojM0G+sbnKqTl1F9LE11gKGaym8HGuGKLgwB0KSKJ0pH9ltjEYlBP4+pyUu+nIm2NdaA9B+jwVBuz7DrbNxd+er0YNLbFguhA7N43OX9qaMOng0FPcU8TvsXsJWI+mg4VCgNOoqmWWbyHuU53NZELm/a/T2TNfJhe9rnKDJZ9Kzr4WnLk/wI9HraLkAiaFpWztaRmMZDnb6OFJd83qpfGkH2OOveFSyu0DDgEfWwiAl5awbgWP/NRLkmRy4URAMEUNpYbYJws/KnKb0es7O3qNfsRgmZUcSatfHK6bO4MiuzLPIMTidUtntcJaDfSrulb0NHGeQsE8emMTh6fBbfaSScHfP7zeMWsggczgLPAe5FTAxLBdkPj52HII+hEl8d4DbtqJPgqAttQIYcymh45zuYTct1aS7ZJubWR43griyHno46iPtlca2vmjQUqD6RJ8Jp4tIGrnEGsSu0gXdvyFGJpHIL4ju0JdtyW3bvnK5N1zIt/7b8Bb4bb1zQeze8xUrUEmz2JvAa6OnGpkO4mKr5PFlG4BErFjeipZCKe5VH9/gKKP5+zOjRoKh0frbHXd/a13ZOlKOtIhxEsXetyjfhmZZe9QcrQme/HgD8H24Z471Fc7OwD4VTsDb1CFdZNlH+Eq9NW+yE0/w+3PPEIawVjHz/OefL7ONivm
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(346002)(376002)(396003)(39860400002)(136003)(451199015)(36840700001)(40470700004)(46966006)(81166007)(426003)(15650500001)(478600001)(1076003)(47076005)(356005)(2906002)(336012)(82310400005)(186003)(40460700003)(41300700001)(110136005)(83380400001)(6666004)(54906003)(40480700001)(7416002)(7696005)(36756003)(82740400003)(8936002)(4326008)(26005)(70586007)(86362001)(70206006)(8676002)(5660300002)(36860700001)(316002)(2616005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2022 07:19:58.4343
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 507890a3-c8eb-41ed-5356-08dac6d9cd88
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0000EE3E.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7249
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

By default the position updates are read from dsp box when streambox
size is not defined.if the streambox size is defined to some value
then position updates can be read from the streambox.

Signed-off-by: V sujith kumar Reddy <Vsujithkumar.Reddy@amd.com>
---
 sound/soc/sof/amd/acp-common.c |  1 +
 sound/soc/sof/amd/acp-ipc.c    | 30 +++++++++++++++++++++++++++++-
 sound/soc/sof/amd/acp.h        |  4 ++++
 3 files changed, 34 insertions(+), 1 deletion(-)

diff --git a/sound/soc/sof/amd/acp-common.c b/sound/soc/sof/amd/acp-common.c
index 27b95187356e..150e042e4039 100644
--- a/sound/soc/sof/amd/acp-common.c
+++ b/sound/soc/sof/amd/acp-common.c
@@ -76,6 +76,7 @@ struct snd_sof_dsp_ops sof_acp_common_ops = {
 	/*IPC */
 	.send_msg		= acp_sof_ipc_send_msg,
 	.ipc_msg_data		= acp_sof_ipc_msg_data,
+	.set_stream_data_offset = acp_set_stream_data_offset,
 	.get_mailbox_offset	= acp_sof_ipc_get_mailbox_offset,
 	.get_window_offset      = acp_sof_ipc_get_window_offset,
 	.irq_thread		= acp_sof_ipc_irq_thread,
diff --git a/sound/soc/sof/amd/acp-ipc.c b/sound/soc/sof/amd/acp-ipc.c
index dd030566e372..dd6e53c63407 100644
--- a/sound/soc/sof/amd/acp-ipc.c
+++ b/sound/soc/sof/amd/acp-ipc.c
@@ -192,13 +192,41 @@ int acp_sof_ipc_msg_data(struct snd_sof_dev *sdev, struct snd_pcm_substream *sub
 {
 	unsigned int offset = sdev->dsp_box.offset;
 
-	if (!substream || !sdev->stream_box.size)
+	if (!substream || !sdev->stream_box.size) {
 		acp_mailbox_read(sdev, offset, p, sz);
+	} else {
+		struct acp_dsp_stream *stream = substream->runtime->private_data;
+
+		if (!stream)
+			return -ESTRPIPE;
+
+		acp_mailbox_read(sdev, stream->posn_offset, p, sz);
+	}
 
 	return 0;
 }
 EXPORT_SYMBOL_NS(acp_sof_ipc_msg_data, SND_SOC_SOF_AMD_COMMON);
 
+int acp_set_stream_data_offset(struct snd_sof_dev *sdev,
+			       struct snd_pcm_substream *substream,
+			       size_t posn_offset)
+{
+	struct acp_dsp_stream *stream = substream->runtime->private_data;
+
+	/* check for unaligned offset or overflow */
+	if (posn_offset > sdev->stream_box.size ||
+	    posn_offset % sizeof(struct sof_ipc_stream_posn) != 0)
+		return -EINVAL;
+
+	stream->posn_offset = sdev->stream_box.offset + posn_offset;
+
+	dev_dbg(sdev->dev, "pcm: stream dir %d, posn mailbox offset is %zu",
+		substream->stream, stream->posn_offset);
+
+	return 0;
+}
+EXPORT_SYMBOL_NS(acp_set_stream_data_offset, SND_SOC_SOF_AMD_COMMON);
+
 int acp_sof_ipc_get_mailbox_offset(struct snd_sof_dev *sdev)
 {
 	const struct sof_amd_acp_desc *desc = get_chip_info(sdev->pdata);
diff --git a/sound/soc/sof/amd/acp.h b/sound/soc/sof/amd/acp.h
index dd3c072d0172..1529c6d9bf9b 100644
--- a/sound/soc/sof/amd/acp.h
+++ b/sound/soc/sof/amd/acp.h
@@ -138,6 +138,7 @@ struct acp_dsp_stream {
 	int stream_tag;
 	int active;
 	unsigned int reg_offset;
+	size_t posn_offset;
 };
 
 struct sof_amd_acp_desc {
@@ -199,6 +200,9 @@ int acp_dsp_block_read(struct snd_sof_dev *sdev, enum snd_sof_fw_blk_type blk_ty
 irqreturn_t acp_sof_ipc_irq_thread(int irq, void *context);
 int acp_sof_ipc_msg_data(struct snd_sof_dev *sdev, struct snd_pcm_substream *substream,
 			 void *p, size_t sz);
+int acp_set_stream_data_offset(struct snd_sof_dev *sdev,
+			       struct snd_pcm_substream *substream,
+			       size_t posn_offset);
 int acp_sof_ipc_send_msg(struct snd_sof_dev *sdev,
 			 struct snd_sof_ipc_msg *msg);
 int acp_sof_ipc_get_mailbox_offset(struct snd_sof_dev *sdev);
-- 
2.25.1

