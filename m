Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99615635C9B
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 13:20:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236545AbiKWMTd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 07:19:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235838AbiKWMTb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 07:19:31 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2062.outbound.protection.outlook.com [40.107.237.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 356703F045
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 04:19:30 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LX2d8jjAVESCnZYxw1cS30oJw8/VtUh+USmR5EIneVP04zT7PIpGzByQxzthHh+R3WJ3ZiYMrc2aIjGOJz7DEszW9R9ejX12P7OiWLyDwTUBQ5wGSsLJU5t6fX7vqksoU03cF4OYJr3PwT9EPYhvOBn2gMnlLP9rleWTRahwp43YIN2aXefuj4BBtGWxB6xG0//nN5xsOfvi1YKNYaKtTlUXsLhS6dNzQfH75fyyFOYOVHugXi8yhldERPsPm7UvZL+ymHQ1M0NfFbfaFgfwd+6qGBnW3LeCHvoyZRavfkzHmZUudmiGAkdaiLMcJHhsw+BrtVRTZ63nYiaU78MFfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4Ejb8QJKQlT9PWx8UhIOs03cvecKzqPiNJNEMm0UUhA=;
 b=NGpzn9i9adU2gwXP1lVfe4S5VjlWHogSWrkujcyuguU9VC+5CCMH0+7ZmG+5WydDWuBJJxiORjWjxaVrHDCgdeGhvQFIqS44IYLObyYHt0Ov+OwHGRBaOedg3vXkneG7DTi7pBc7NllUham0Tq80wpxMH4oJ6b1EHFEpD/6Ama6qXZTLLjblrURq6j3s9cNCESDs6QOygDyaSA3FKM6GwydvpKHEzwmDtzkq+YrUWQoIugJFzXZK6usVMpaCCd5PTOKWG/n8Mv9Sp5PjjH3W3oNVC/oqXXeCJ3XzjChjuyXPe0+EZY3L0VhKSNXiRgD35geQGNj6zXDfIq5I52xubQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 165.204.84.17) smtp.rcpttodomain=kernel.org
 smtp.mailfrom=amd.corp-partner.google.com; dmarc=fail (p=reject sp=reject
 pct=100) action=oreject header.from=amd.corp-partner.google.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4Ejb8QJKQlT9PWx8UhIOs03cvecKzqPiNJNEMm0UUhA=;
 b=qlaCka3OAINs22Sv+yPpiZE5YM6nMLv6t+Vzxa5oRugaBsicsLILnpq6u0MMb/FZiaP+cYe8W2mqIUQIW/Ce5ZmROguEvOp0IvCUpPLSu/BXlfH3xK+ySSurEgJHlVRsyMh3lhQbNrtRlvyBnNxx02K3EcM+/X4g2mRgRPjOQD1LBf452dT/r/dHb4FjFZi4CYbx5HRG1/AOxJnWhHdu7DgbcNWzQef01FgglcodvLgByHK6ZsK+92S4Z3ecIppTK5Xe+OqZyc95gIelmCdKBF0beF0eUP1DaR3QdEEPdiuUmeFjsQzPktwsfZb7Orsjv+LGc+K3UYx73hD4OyMBKA==
Received: from MW4PR03CA0308.namprd03.prod.outlook.com (2603:10b6:303:dd::13)
 by SA3PR12MB7950.namprd12.prod.outlook.com (2603:10b6:806:31c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.15; Wed, 23 Nov
 2022 12:19:28 +0000
Received: from CO1NAM11FT089.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:dd:cafe::76) by MW4PR03CA0308.outlook.office365.com
 (2603:10b6:303:dd::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.17 via Frontend
 Transport; Wed, 23 Nov 2022 12:19:27 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 165.204.84.17) smtp.mailfrom=amd.corp-partner.google.com; dkim=none (message
 not signed) header.d=none;dmarc=fail action=oreject
 header.from=amd.corp-partner.google.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 amd.corp-partner.google.com discourages use of 165.204.84.17 as permitted
 sender)
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT089.mail.protection.outlook.com (10.13.175.179) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5834.8 via Frontend Transport; Wed, 23 Nov 2022 12:19:27 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 23 Nov
 2022 06:19:25 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 23 Nov
 2022 04:19:11 -0800
Received: from sof-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.34
 via Frontend Transport; Wed, 23 Nov 2022 06:19:05 -0600
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
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        "moderated list:SOUND - SOUND OPEN FIRMWARE (SOF) DRIVERS" 
        <sound-open-firmware@alsa-project.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH v1 1/4] ASoC: SOF: amd: Fix for reading position updates from stream box.
Date:   Wed, 23 Nov 2022 17:49:08 +0530
Message-ID: <20221123121911.3446224-2-vsujithkumar.reddy@amd.corp-partner.google.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221123121911.3446224-1-vsujithkumar.reddy@amd.corp-partner.google.com>
References: <20221123121911.3446224-1-vsujithkumar.reddy@amd.corp-partner.google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT089:EE_|SA3PR12MB7950:EE_
X-MS-Office365-Filtering-Correlation-Id: aecd2e85-7321-4aa6-950c-08dacd4cf767
X-MS-Exchange-SenderADCheck: 2
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: y4G5xQ5rfqsWGtrCfH5dODKfX+j957wYewfxwZtHt8Ofzy70OkU9nKsxOcODm7k0GgjI1LID0em5a1yQC6GWX5ZY0tURCKQXhH4bwMyZi6EZOLJfIFemfLDgyDEo64GoSV4AvH0W3S90+YY+9fIsHFVcufN4gA2Ln3htyL0O/jF8Inaor9VbuZtUAFTTnhvA42Qt9vXLl7SWAqYF8MLJudh19iWTxoKj1yWV4p6fvoXO8ulbqfW+9xRXSl2DMqS1/KxNiah124oWO9Sk9vn+8enErDqo0Mc9cJq/jsuSbv7Dphwx9nPxn1ILk3rDiGjiXckFlSp3shcFItwKll/I0ajqzATc0nnGB7z+MI2Kh+/77dfZDgpuJNNMd1lP0RNzGufPyntuCYjCG3Aqd9inBrm02aly9pXu3UMHvHIJL+yq+h0kICb44eEX2NSTk08Jd/XTVTX6U52EvXfCKV2yvyITnWd9XXFf0LyYxOeQx0qJClZQZkTA+7KPi0ynWEvzrZ2zjguxUrSNUqLu+Mig5/tLzP108fS8oPPSDNpojLHucLRs0yF4BMqk+MTqqcqkX0VlgVzc2B3ALrkIpwsKLKMcHdPySWjTIu5Fa0FkcooBZNmb/Z8YnD69m2ruIsuDSzglBxcnDwHQxGxX/z+QV5wtiVRbWXeXow9KEHA8v9AGkfYDu4Zvuk67j1mAAsn4JskmbK6KcKYG3j28+qHUQA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(346002)(396003)(136003)(39860400002)(376002)(451199015)(46966006)(40470700004)(110136005)(2616005)(336012)(47076005)(1076003)(2906002)(26005)(498600001)(35950700001)(40460700003)(86362001)(40480700001)(81166007)(356005)(15650500001)(82740400003)(83380400001)(82310400005)(4326008)(5660300002)(70586007)(8936002)(7416002)(8676002)(70206006)(316002)(54906003)(76482006)(41300700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amdcloud.onmicrosoft.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2022 12:19:27.6753
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aecd2e85-7321-4aa6-950c-08dacd4cf767
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT089.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7950
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

