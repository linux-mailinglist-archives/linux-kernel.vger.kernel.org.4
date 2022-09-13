Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 066A65B755A
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 17:42:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236467AbiIMPkv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 11:40:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235056AbiIMPjx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 11:39:53 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2062c.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e8a::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8993348CBA
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 07:45:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y0nP5Lr6cVWEfZ8JvHPznYz1Z0hkE62RG4+XMke7SZ0mRaqfCaJqpabtRN5V69Y4KCjhGSeY4O5qyq7zkFfDy7iN3WWa6xrzWn9PffxeVoHbMFQYgJth3S1MqDTGBX+Usx5A/+iMFmhny5NeY2f23pQZH/BG5bP7Vg7mniuZf4GmLYWU2O1XkDktDvj236zbcePEWgdYc9SzE2u5KRTBL4zTA2fK/2JGDI9cx9nZUm4mj6nbu8v6gNlFrK+xAV9j76bIGMaD52ENcmvC2Qr0fl+X01Amvvk58hppTVZUOfxXg+hFyQcMuadQcNaT9gbb3eOGuFN3+b9QEGMy7LtUeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vtD/HO9Y6FfIxjwvPJsMWHC9OtkRL8fWMmU51IIaSrw=;
 b=myo+hl9/UO5+wot0YjYEBLwdLm6povgEA25NorsCvC3k7DSCp+stFK40IshA797S+TGpN8tD3CS06FU6iqxTYjcRG4u7aa3lTv8kDkZ8hw9I75GV8IjKRa+zmb+JIU+MIu36uSqzIokv+ECiHANsN7fYFJtG5hcZ8Qa1T9eGz/OBTt8vTEWKrjqw/OMPEBYFgTOVOsATQch4lnFBIeWiBniTHCZS2jEzteryUgihEG+kPlHOj+DQnGq4Is7T/c177XC/RMA7/B43wI8L3MNOV2BPVcFrMRQGvA5FipBf/b5Ae2I5GU2V7G+7H+Pvb1c5zSxhiU1l8yU9Dx2uOAVhUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vtD/HO9Y6FfIxjwvPJsMWHC9OtkRL8fWMmU51IIaSrw=;
 b=u+h2KDaRL5mEj0waxCQUhv5ePI0y3aDwa+9KEShVZmqIdMOcYO9Dhk78VukRtNyK2E23oIbAI4rDyXybufSa1JYyaCA2qtmi4yAUa0IbQuF15V6ZbLceeQomsGtJEYKfiA0m1pXTDuIVuj3RqgmTo5NvCIqXUikIb1MpTwuOGOg=
Received: from DM6PR12CA0010.namprd12.prod.outlook.com (2603:10b6:5:1c0::23)
 by SA1PR12MB7344.namprd12.prod.outlook.com (2603:10b6:806:2b7::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.14; Tue, 13 Sep
 2022 14:42:23 +0000
Received: from DM6NAM11FT068.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1c0:cafe::ce) by DM6PR12CA0010.outlook.office365.com
 (2603:10b6:5:1c0::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.18 via Frontend
 Transport; Tue, 13 Sep 2022 14:42:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT068.mail.protection.outlook.com (10.13.173.67) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5612.13 via Frontend Transport; Tue, 13 Sep 2022 14:42:22 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 13 Sep
 2022 09:42:22 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 13 Sep
 2022 09:42:21 -0500
Received: from sof-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.28
 via Frontend Transport; Tue, 13 Sep 2022 09:42:16 -0500
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
        Rander Wang <rander.wang@intel.com>,
        "moderated list:SOUND - SOUND OPEN FIRMWARE (SOF) DRIVERS" 
        <sound-open-firmware@alsa-project.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH 4/4] ASoC: SOF: amd: increase SRAM inbox and outbox size to 1024
Date:   Tue, 13 Sep 2022 20:13:18 +0530
Message-ID: <20220913144319.1055302-5-Vsujithkumar.Reddy@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220913144319.1055302-1-Vsujithkumar.Reddy@amd.com>
References: <20220913144319.1055302-1-Vsujithkumar.Reddy@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT068:EE_|SA1PR12MB7344:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d7d6efe-d0c5-440f-107c-08da95962b3c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YNeAk/te5lwzI73tdamc0swzgeE/dgUVX0CpdgdN1v5WE5CvSOncLGOJvns5HBrvkWOFuCkVHGNLmRVJWRIZFdyX93cmEomW1+ZiKrtaC48j6uUzmFc0Wj6YDK/tHt4Kaf38sdTA7WSGQOzWrha1srY6FE5gtO0xeeVOIaZVrezXh6ByF3Fy5oIPjubUtvxiFu5aOeUc1pJVyUjfKnJK1h+0fUGaUVHhwIUMN/KPbR5bhx7AzPOOvcGsjpYGUTeYjt5RfHcLllHDMf2SF1aoDTxBbaTp5KxYWWE/eCXaIF3gqQl6ikD8vHArzWTQQZzJQOmnHG0sCH5xBvfAmDX8ME+HmVc/a++HpUbvBcIGBAtKyaudeySZadv2N2J3YEUN5iERq8xlPSACOU6f82bmJJcQopJWgwtYcWdlolYuUPvwgUPSv8lQO1Rgtl/tqENkgP/kA5sXBF+PJLYKfNiQPnDlNJmm32meYfJM3lDdljlSvBD4p7aW+iFL7MqqfxlHaPlnn8AofJ6CYBUe4zprXVB+KEXPS5cSNV5g7e0KDFz5CyvBugGeb/SJEPWkpPKlY3VQQh12W1Zh74Xw7lZA67QBm1GUYL80XZ8VCBrvKogoHikj0ju5FClWB0/s6gZrrs4azh6PoHHLPhMRJ9X9PyaqSxmA3j26OtId0mYlwElA2NEZ1CE7eLKWeSakGlMqDisReyFHEMMPI4ucNG4/c73Fm6NYFBwXjFhUeeoY6DmY/fKm2VHS083GOOFBOa56n9xnl1B4MdiBidDiy3h7Po6Ji4XWohAlLZSXvj7u4ABBKMS1WJt+PoDGUFrF1M6m
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(346002)(396003)(376002)(136003)(39860400002)(451199015)(46966006)(40470700004)(36840700001)(82740400003)(81166007)(110136005)(186003)(336012)(41300700001)(356005)(426003)(40460700003)(36756003)(478600001)(70586007)(82310400005)(4326008)(86362001)(8676002)(40480700001)(8936002)(316002)(7416002)(36860700001)(26005)(2616005)(1076003)(70206006)(83380400001)(7696005)(54906003)(47076005)(5660300002)(2906002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2022 14:42:22.8242
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d7d6efe-d0c5-440f-107c-08da95962b3c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT068.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7344
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Increase inbox and outbox mailbox size from 512 to 1024 to
support thirdparty DTS integration ipc tx/rx messages communication.
This is done through firmware window get info.

Signed-off-by: V sujith kumar Reddy <Vsujithkumar.Reddy@amd.com>
---
 sound/soc/sof/amd/acp-common.c |  1 +
 sound/soc/sof/amd/acp-ipc.c    | 33 +++++++++++++++++++++++++--------
 sound/soc/sof/amd/acp-pcm.c    |  3 ++-
 sound/soc/sof/amd/acp-stream.c |  4 +++-
 sound/soc/sof/amd/acp.c        | 17 ++++++++++++++---
 sound/soc/sof/amd/acp.h        |  7 +++----
 6 files changed, 48 insertions(+), 17 deletions(-)

diff --git a/sound/soc/sof/amd/acp-common.c b/sound/soc/sof/amd/acp-common.c
index 12bdd97c1aae..27b95187356e 100644
--- a/sound/soc/sof/amd/acp-common.c
+++ b/sound/soc/sof/amd/acp-common.c
@@ -77,6 +77,7 @@ struct snd_sof_dsp_ops sof_acp_common_ops = {
 	.send_msg		= acp_sof_ipc_send_msg,
 	.ipc_msg_data		= acp_sof_ipc_msg_data,
 	.get_mailbox_offset	= acp_sof_ipc_get_mailbox_offset,
+	.get_window_offset      = acp_sof_ipc_get_window_offset,
 	.irq_thread		= acp_sof_ipc_irq_thread,
 
 	/* stream callbacks */
diff --git a/sound/soc/sof/amd/acp-ipc.c b/sound/soc/sof/amd/acp-ipc.c
index e09392498f4c..dd030566e372 100644
--- a/sound/soc/sof/amd/acp-ipc.c
+++ b/sound/soc/sof/amd/acp-ipc.c
@@ -42,21 +42,24 @@ static void acpbus_trigger_host_to_dsp_swintr(struct acp_dev_data *adata)
 
 static void acp_ipc_host_msg_set(struct snd_sof_dev *sdev)
 {
-	unsigned int host_msg = offsetof(struct scratch_ipc_conf, sof_host_msg_write);
+	unsigned int host_msg = sdev->debug_box.offset +
+				offsetof(struct scratch_ipc_conf, sof_host_msg_write);
 
 	snd_sof_dsp_write(sdev, ACP_DSP_BAR, ACP_SCRATCH_REG_0 + host_msg, 1);
 }
 
 static void acp_dsp_ipc_host_done(struct snd_sof_dev *sdev)
 {
-	unsigned int dsp_msg = offsetof(struct scratch_ipc_conf, sof_dsp_msg_write);
+	unsigned int dsp_msg = sdev->debug_box.offset +
+			       offsetof(struct scratch_ipc_conf, sof_dsp_msg_write);
 
 	snd_sof_dsp_write(sdev, ACP_DSP_BAR, ACP_SCRATCH_REG_0 + dsp_msg, 0);
 }
 
 static void acp_dsp_ipc_dsp_done(struct snd_sof_dev *sdev)
 {
-	unsigned int dsp_ack = offsetof(struct scratch_ipc_conf, sof_dsp_ack_write);
+	unsigned int dsp_ack = sdev->debug_box.offset +
+			       offsetof(struct scratch_ipc_conf, sof_dsp_ack_write);
 
 	snd_sof_dsp_write(sdev, ACP_DSP_BAR, ACP_SCRATCH_REG_0 + dsp_ack, 0);
 }
@@ -65,7 +68,7 @@ int acp_sof_ipc_send_msg(struct snd_sof_dev *sdev, struct snd_sof_ipc_msg *msg)
 {
 	struct acp_dev_data *adata = sdev->pdata->hw_pdata;
 	const struct sof_amd_acp_desc *desc = get_chip_info(sdev->pdata);
-	unsigned int offset = offsetof(struct scratch_ipc_conf, sof_in_box);
+	unsigned int offset = sdev->host_box.offset;
 	unsigned int count = ACP_HW_SEM_RETRY_COUNT;
 
 	while (snd_sof_dsp_read(sdev, ACP_DSP_BAR, desc->hw_semaphore_offset)) {
@@ -95,7 +98,7 @@ static void acp_dsp_ipc_get_reply(struct snd_sof_dev *sdev)
 	struct snd_sof_ipc_msg *msg = sdev->msg;
 	struct sof_ipc_reply reply;
 	struct sof_ipc_cmd_hdr *hdr;
-	unsigned int offset = offsetof(struct scratch_ipc_conf, sof_in_box);
+	unsigned int offset = sdev->host_box.offset;
 	int ret = 0;
 
        /*
@@ -145,11 +148,19 @@ static void acp_dsp_ipc_get_reply(struct snd_sof_dev *sdev)
 irqreturn_t acp_sof_ipc_irq_thread(int irq, void *context)
 {
 	struct snd_sof_dev *sdev = context;
-	unsigned int dsp_msg_write = offsetof(struct scratch_ipc_conf, sof_dsp_msg_write);
-	unsigned int dsp_ack_write = offsetof(struct scratch_ipc_conf, sof_dsp_ack_write);
+	unsigned int dsp_msg_write = sdev->debug_box.offset +
+				     offsetof(struct scratch_ipc_conf, sof_dsp_msg_write);
+	unsigned int dsp_ack_write = sdev->debug_box.offset +
+				     offsetof(struct scratch_ipc_conf, sof_dsp_ack_write);
 	bool ipc_irq = false;
 	int dsp_msg, dsp_ack;
 
+	if (sdev->first_boot && sdev->fw_state != SOF_FW_BOOT_COMPLETE) {
+		snd_sof_ipc_msgs_rx(sdev);
+		acp_dsp_ipc_host_done(sdev);
+		return IRQ_HANDLED;
+	}
+
 	dsp_msg = snd_sof_dsp_read(sdev, ACP_DSP_BAR, ACP_SCRATCH_REG_0 + dsp_msg_write);
 	if (dsp_msg) {
 		snd_sof_ipc_msgs_rx(sdev);
@@ -179,7 +190,7 @@ EXPORT_SYMBOL_NS(acp_sof_ipc_irq_thread, SND_SOC_SOF_AMD_COMMON);
 int acp_sof_ipc_msg_data(struct snd_sof_dev *sdev, struct snd_pcm_substream *substream,
 			 void *p, size_t sz)
 {
-	unsigned int offset = offsetof(struct scratch_ipc_conf, sof_out_box);
+	unsigned int offset = sdev->dsp_box.offset;
 
 	if (!substream || !sdev->stream_box.size)
 		acp_mailbox_read(sdev, offset, p, sz);
@@ -196,4 +207,10 @@ int acp_sof_ipc_get_mailbox_offset(struct snd_sof_dev *sdev)
 }
 EXPORT_SYMBOL_NS(acp_sof_ipc_get_mailbox_offset, SND_SOC_SOF_AMD_COMMON);
 
+int acp_sof_ipc_get_window_offset(struct snd_sof_dev *sdev, u32 id)
+{
+	return 0;
+}
+EXPORT_SYMBOL_NS(acp_sof_ipc_get_window_offset, SND_SOC_SOF_AMD_COMMON);
+
 MODULE_DESCRIPTION("AMD ACP sof-ipc driver");
diff --git a/sound/soc/sof/amd/acp-pcm.c b/sound/soc/sof/amd/acp-pcm.c
index 0ba8ae46bd76..727c3a784a20 100644
--- a/sound/soc/sof/amd/acp-pcm.c
+++ b/sound/soc/sof/amd/acp-pcm.c
@@ -42,7 +42,8 @@ int acp_pcm_hw_params(struct snd_sof_dev *sdev, struct snd_pcm_substream *substr
 
 	/* write buffer size of stream in scratch memory */
 
-	buf_offset = offsetof(struct scratch_reg_conf, buf_size);
+	buf_offset = sdev->debug_box.offset +
+		     offsetof(struct scratch_reg_conf, buf_size);
 	index = stream->stream_tag - 1;
 	buf_offset = buf_offset + index * 4;
 
diff --git a/sound/soc/sof/amd/acp-stream.c b/sound/soc/sof/amd/acp-stream.c
index f71b4e660b14..6f40ef7ba85e 100644
--- a/sound/soc/sof/amd/acp-stream.c
+++ b/sound/soc/sof/amd/acp-stream.c
@@ -89,7 +89,8 @@ int acp_dsp_stream_config(struct snd_sof_dev *sdev, struct acp_dsp_stream *strea
 
 	/* write phy_addr in scratch memory */
 
-	phy_addr_offset = offsetof(struct scratch_reg_conf, reg_offset);
+	phy_addr_offset = sdev->debug_box.offset +
+			  offsetof(struct scratch_reg_conf, reg_offset);
 	index = stream_tag - 1;
 	phy_addr_offset = phy_addr_offset + index * 4;
 
@@ -97,6 +98,7 @@ int acp_dsp_stream_config(struct snd_sof_dev *sdev, struct acp_dsp_stream *strea
 			  phy_addr_offset, stream->reg_offset);
 
 	/* Group Enable */
+	offset = offset + sdev->debug_box.offset;
 	reg_val = desc->sram_pte_offset + offset;
 	snd_sof_dsp_write(sdev, ACP_DSP_BAR, pte_reg, reg_val | BIT(31));
 	snd_sof_dsp_write(sdev, ACP_DSP_BAR, pte_size, PAGE_SIZE_4K_ENABLE);
diff --git a/sound/soc/sof/amd/acp.c b/sound/soc/sof/amd/acp.c
index 47eaabc95aa5..36966643e36a 100644
--- a/sound/soc/sof/amd/acp.c
+++ b/sound/soc/sof/amd/acp.c
@@ -42,7 +42,8 @@ static void init_dma_descriptor(struct acp_dev_data *adata)
 	const struct sof_amd_acp_desc *desc = get_chip_info(sdev->pdata);
 	unsigned int addr;
 
-	addr = desc->sram_pte_offset + offsetof(struct scratch_reg_conf, dma_desc);
+	addr = desc->sram_pte_offset + sdev->debug_box.offset +
+	       offsetof(struct scratch_reg_conf, dma_desc);
 
 	snd_sof_dsp_write(sdev, ACP_DSP_BAR, ACP_DMA_DESC_BASE_ADDR, addr);
 	snd_sof_dsp_write(sdev, ACP_DSP_BAR, ACP_DMA_DESC_MAX_NUM_DSCR, ACP_MAX_DESC_CNT);
@@ -54,8 +55,9 @@ static void configure_dma_descriptor(struct acp_dev_data *adata, unsigned short
 	struct snd_sof_dev *sdev = adata->dev;
 	unsigned int offset;
 
-	offset = ACP_SCRATCH_REG_0 + offsetof(struct scratch_reg_conf, dma_desc) +
-		 idx * sizeof(struct dma_descriptor);
+	offset = ACP_SCRATCH_REG_0 + sdev->debug_box.offset +
+		offsetof(struct scratch_reg_conf, dma_desc) +
+		idx * sizeof(struct dma_descriptor);
 
 	snd_sof_dsp_write(sdev, ACP_DSP_BAR, offset, dscr_info->src_addr);
 	snd_sof_dsp_write(sdev, ACP_DSP_BAR, offset + 0x4, dscr_info->dest_addr);
@@ -516,6 +518,15 @@ int amd_sof_acp_probe(struct snd_sof_dev *sdev)
 		return ret;
 	}
 
+	sdev->dsp_box.offset = 0;
+	sdev->dsp_box.size = BOX_SIZE_512;
+
+	sdev->host_box.offset = sdev->dsp_box.offset + sdev->dsp_box.size;
+	sdev->host_box.size = BOX_SIZE_512;
+
+	sdev->debug_box.offset = sdev->host_box.offset + sdev->host_box.size;
+	sdev->debug_box.size = BOX_SIZE_1024;
+
 	acp_memory_init(sdev);
 
 	acp_dsp_stream_init(sdev);
diff --git a/sound/soc/sof/amd/acp.h b/sound/soc/sof/amd/acp.h
index e59a8655d859..dd3c072d0172 100644
--- a/sound/soc/sof/amd/acp.h
+++ b/sound/soc/sof/amd/acp.h
@@ -66,6 +66,9 @@
 #define MBOX_READY_MASK				0x80000000
 #define MBOX_STATUS_MASK			0xFFFF
 
+#define BOX_SIZE_512				0x200
+#define BOX_SIZE_1024				0x400
+
 struct  acp_atu_grp_pte {
 	u32 low;
 	u32 high;
@@ -90,10 +93,6 @@ struct dma_descriptor {
 
 /* Scratch memory structure for communication b/w host and dsp */
 struct  scratch_ipc_conf {
-	/* DSP mailbox */
-	u8 sof_out_box[512];
-	/* Host mailbox */
-	u8 sof_in_box[512];
 	/* Debug memory */
 	u8 sof_debug_box[1024];
 	/* Exception memory*/
-- 
2.25.1

