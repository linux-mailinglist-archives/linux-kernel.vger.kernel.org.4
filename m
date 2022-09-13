Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F2CD5B75EF
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 18:00:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229575AbiIMP7x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 11:59:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234766AbiIMP7T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 11:59:19 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam07on20623.outbound.protection.outlook.com [IPv6:2a01:111:f400:7eb2::623])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9475894EDF
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 07:57:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LKa2lKopzCuNTxRLOF3JW3wv5Ekb5nYczlR20J8Um7cT2IIQLrDZt0ZvEqoWj5DdURcfOiso7qf4zNm11CCT5BpTvEgU8UOuCRVpEnFIfAV06o2t6MldKDKattLjzCbRNVCYzMXLWd+6UU5TeZMxt+Urur7i/akCAunA992YDDSC8UVZhTc6Nek8H+tUBwmUxWGAW1Pf8jPcbNfxYIpAZL4jKJp0V+wJbBrABVmI0CofrGFXQQbHWGR//cnk4L+xF3x1EDEWIs6y/RX8CCcxiAxCou4V5bqPC0y70UR5GviGNmsV4NgMlME8SGHagxIDUZsELJgZvw8EcEcDeresGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bTSV7T/MPCSazMmb/UnoSefD7UoMCwrtkJdxLjFhkoo=;
 b=B6cwvLkCdn/Ge2WxzZWZLHl2eIogfNgBNqwR3v+ltYTGQatTPRR98Hu8TcnvwWZpa6fnUINjOSltB2Pz7UzfQoNJLZy3dFvSRTaeEzBuYcG/xAD1hTolw3krhuOXV+1XL9yy7VEShY2hho1zD1TzJw7sTTFF5eL0b53FxyjI5CDQxQnnEDl4gG5m+9YjjmXGlBbY1ypviCgomkpUnugc2WaEypHC0959m/1hxUkkAzmmD1+eRpE9p2we1AgSryAWNS2W8OD+XAl5F4WVKd+ettOjUP7nGKe4u+VEjC46uHvbJJNjhJ4G++TRHj1FKSxdvDZ0MzXOqkRciDZ37v2eAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bTSV7T/MPCSazMmb/UnoSefD7UoMCwrtkJdxLjFhkoo=;
 b=g/Yf+WOCtBGTaKVjNzp8hz8pmYPdbSUcApSCnZgNIgHKotNJA2YFHYnZh8i1wVRystXE1wMfZnqwciIHnJrw+UA1WiXBTXEd+IzNevbj9iWLhowYwC0f1QfE9K38gZ3axxKxqlq/mHB939F9Trta32/koMVM2jhVvOcRzIHH9Vk=
Received: from DM6PR02CA0153.namprd02.prod.outlook.com (2603:10b6:5:332::20)
 by SJ1PR12MB6099.namprd12.prod.outlook.com (2603:10b6:a03:45e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.22; Tue, 13 Sep
 2022 14:41:29 +0000
Received: from DM6NAM11FT057.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:332:cafe::92) by DM6PR02CA0153.outlook.office365.com
 (2603:10b6:5:332::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.18 via Frontend
 Transport; Tue, 13 Sep 2022 14:41:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT057.mail.protection.outlook.com (10.13.172.252) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5612.13 via Frontend Transport; Tue, 13 Sep 2022 14:41:29 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 13 Sep
 2022 09:41:22 -0500
Received: from sof-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.28
 via Frontend Transport; Tue, 13 Sep 2022 09:41:16 -0500
From:   V sujith kumar Reddy <Vsujithkumar.Reddy@amd.com>
To:     <broonie@kernel.org>, <alsa-devel@alsa-project.org>
CC:     <Vijendar.Mukunda@amd.com>, <Basavaraj.Hiregoudar@amd.com>,
        <Sunil-kumar.Dommati@amd.com>, <venkataprasad.potturu@amd.com>,
        <ssabakar@amd.com>, Ajit Kumar Pandey <AjitKumar.Pandey@amd.com>,
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
        "Jiapeng Chong" <jiapeng.chong@linux.alibaba.com>,
        Zheng Bin <zhengbin13@huawei.com>,
        Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>,
        open list <linux-kernel@vger.kernel.org>,
        "moderated list:SOUND - SOUND OPEN FIRMWARE (SOF) DRIVERS" 
        <sound-open-firmware@alsa-project.org>
Subject: [PATCH 1/4] ASoC: SOF: amd: Make ACP core code generic for newer SOC transition
Date:   Tue, 13 Sep 2022 20:13:15 +0530
Message-ID: <20220913144319.1055302-2-Vsujithkumar.Reddy@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220913144319.1055302-1-Vsujithkumar.Reddy@amd.com>
References: <20220913144319.1055302-1-Vsujithkumar.Reddy@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT057:EE_|SJ1PR12MB6099:EE_
X-MS-Office365-Filtering-Correlation-Id: edead262-ab3a-43e3-be86-08da95960b70
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: v2Rx4S079BKhZyK3qpl6x5Lo6XvRg4nCg92waZ79785/luV04SiU0KLvhMY+P7XY3h6KbnKmDpfgg6wXy/F4xz/wu+qITfwvQoZtHBi1cleXye31G8k3VdzSdEANA+u1NT3haDCWGoBbsCvPuav07QznhHct4vvH5d82Ya6/9x5g2O9m4czRu5S+Yta6fxfjfXg3eeBnsfM2HAVuyNBAIrlqMFqp3g+zLD7zYlsu/sJtSp40H7ZA1b3Ou9WjrT5J+GF8FdbSUi+hwLLeBmOb2beUx6Wtip/fQi3sj8lFu8roIJtHisyK26JGlS6JqIpJGLwsfpIo5WwEl/4O75Q2QBK1COAQE8yjzm3IuUWbYZhG5CUbXG3fT4fa15276c93JfpTu42hxaQ/Eud2o9pb+jkElPEfPcYpe38oS6Pw3PJAkvErr1fF/Nm+xnCpZ6C2vEUM3jkLBGWF/nZWYGPoZoluycr2l+7U5dAuaHOwpr0tLZcq95P2NhSe9fLETKelN5VKzh479TLPSflxLLpOsK5/VKNnOAK6l7ZSeGXF4Vj5WbsUQZDjamYPSH+3yKw3WWAfK+4aVkiSa29c+V3uifL8RqWYCeaXUeHgy546vuwWO0bshm6zRRxsjva64rtMRbUQ9/TKTwPokOZpvqS5dyrKXQwvSsjAqyxWAwlobby+NYUbvami2zXnsZEuTS1IspLqRJFildP3/gAjrWUZkYnid9+08q5R0hCRL9ObJshk2B+8PixaDW38iLRQzvp8yB9NKWorpGKCjjW11eMMg2VxD1XBhL3oNzicv+FaWPIifdnhA9aOlqL/izThWGWBDRSxN3EfwAtOv31qwsjptw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(346002)(396003)(376002)(39860400002)(136003)(451199015)(46966006)(36840700001)(40470700004)(2616005)(110136005)(81166007)(316002)(1076003)(26005)(356005)(336012)(8676002)(70586007)(7696005)(82740400003)(47076005)(36860700001)(30864003)(5660300002)(7416002)(54906003)(478600001)(83380400001)(86362001)(4326008)(186003)(41300700001)(2906002)(36756003)(82310400005)(426003)(40460700003)(40480700001)(70206006)(8936002)(41533002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2022 14:41:29.4980
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: edead262-ab3a-43e3-be86-08da95960b70
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT057.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6099
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ajit Kumar Pandey <AjitKumar.Pandey@amd.com>

Newer AMD SOC differs slightly in terms of few registers offset and
configuration. Add offsets into chip_info struct to make core ACP
code more generic and resusable on newer SOC.

Signed-off-by: Ajit Kumar Pandey <AjitKumar.Pandey@amd.com>
Signed-off-by: V sujith kumar Reddy <Vsujithkumar.Reddy@amd.com>
---
 sound/soc/sof/amd/Makefile         |   2 +-
 sound/soc/sof/amd/acp-common.c     | 110 +++++++++++++++++++++++++++++
 sound/soc/sof/amd/acp-dsp-offset.h |  25 +++----
 sound/soc/sof/amd/acp-ipc.c        |  16 +++--
 sound/soc/sof/amd/acp-loader.c     |  13 ++--
 sound/soc/sof/amd/acp-stream.c     |   3 +-
 sound/soc/sof/amd/acp.c            |  37 ++++++----
 sound/soc/sof/amd/acp.h            |  26 +++++--
 sound/soc/sof/amd/pci-rn.c         |  11 +++
 sound/soc/sof/amd/renoir.c         | 101 ++++----------------------
 10 files changed, 210 insertions(+), 134 deletions(-)
 create mode 100644 sound/soc/sof/amd/acp-common.c

diff --git a/sound/soc/sof/amd/Makefile b/sound/soc/sof/amd/Makefile
index 7b9f1a0af3c8..efea92f62a86 100644
--- a/sound/soc/sof/amd/Makefile
+++ b/sound/soc/sof/amd/Makefile
@@ -4,7 +4,7 @@
 #
 # Copyright(c) 2021 Advanced Micro Devices, Inc. All rights reserved.
 
-snd-sof-amd-acp-objs := acp.o acp-loader.o acp-ipc.o acp-pcm.o acp-stream.o acp-trace.o
+snd-sof-amd-acp-objs := acp.o acp-loader.o acp-ipc.o acp-pcm.o acp-stream.o acp-trace.o acp-common.o
 snd-sof-amd-renoir-objs := pci-rn.o renoir.o
 
 obj-$(CONFIG_SND_SOC_SOF_AMD_COMMON) += snd-sof-amd-acp.o
diff --git a/sound/soc/sof/amd/acp-common.c b/sound/soc/sof/amd/acp-common.c
new file mode 100644
index 000000000000..12bdd97c1aae
--- /dev/null
+++ b/sound/soc/sof/amd/acp-common.c
@@ -0,0 +1,110 @@
+// SPDX-License-Identifier: (GPL-2.0-only OR BSD-3-Clause)
+//
+// This file is provided under a dual BSD/GPLv2 license. When using or
+// redistributing this file, you may do so under either license.
+//
+// Copyright(c) 2022 Advanced Micro Devices, Inc.
+//
+// Authors: Ajit Kumar Pandey <AjitKumar.Pandey@amd.com>
+//	    V sujith kumar Reddy <Vsujithkumar.Reddy@amd.com>
+
+/* ACP-specific Common code */
+
+#include "../sof-priv.h"
+#include "../sof-audio.h"
+#include "../ops.h"
+#include "../sof-audio.h"
+#include "acp.h"
+#include "acp-dsp-offset.h"
+
+int acp_dai_probe(struct snd_soc_dai *dai)
+{
+	struct snd_sof_dev *sdev = snd_soc_component_get_drvdata(dai->component);
+	const struct sof_amd_acp_desc *desc = get_chip_info(sdev->pdata);
+	unsigned int val;
+
+	val = snd_sof_dsp_read(sdev, ACP_DSP_BAR, desc->i2s_pin_config_offset);
+	if (val != desc->i2s_mode) {
+		dev_err(sdev->dev, "I2S Mode is not supported (I2S_PIN_CONFIG: %#x)\n", val);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_NS(acp_dai_probe, SND_SOC_SOF_AMD_COMMON);
+
+struct snd_soc_acpi_mach *amd_sof_machine_select(struct snd_sof_dev *sdev)
+{
+	struct snd_sof_pdata *sof_pdata = sdev->pdata;
+	const struct sof_dev_desc *desc = sof_pdata->desc;
+	struct snd_soc_acpi_mach *mach;
+
+	mach = snd_soc_acpi_find_machine(desc->machines);
+	if (!mach) {
+		dev_warn(sdev->dev, "No matching ASoC machine driver found\n");
+		return NULL;
+	}
+
+	sof_pdata->tplg_filename = mach->sof_tplg_filename;
+	sof_pdata->fw_filename = mach->fw_filename;
+
+	return mach;
+}
+
+/* AMD Common DSP ops */
+struct snd_sof_dsp_ops sof_acp_common_ops = {
+	/* probe and remove */
+	.probe			= amd_sof_acp_probe,
+	.remove			= amd_sof_acp_remove,
+
+	/* Register IO */
+	.write			= sof_io_write,
+	.read			= sof_io_read,
+
+	/* Block IO */
+	.block_read		= acp_dsp_block_read,
+	.block_write		= acp_dsp_block_write,
+
+	/*Firmware loading */
+	.load_firmware		= snd_sof_load_firmware_memcpy,
+	.pre_fw_run		= acp_dsp_pre_fw_run,
+	.get_bar_index		= acp_get_bar_index,
+
+	/* DSP core boot */
+	.run			= acp_sof_dsp_run,
+
+	/*IPC */
+	.send_msg		= acp_sof_ipc_send_msg,
+	.ipc_msg_data		= acp_sof_ipc_msg_data,
+	.get_mailbox_offset	= acp_sof_ipc_get_mailbox_offset,
+	.irq_thread		= acp_sof_ipc_irq_thread,
+
+	/* stream callbacks */
+	.pcm_open		= acp_pcm_open,
+	.pcm_close		= acp_pcm_close,
+	.pcm_hw_params		= acp_pcm_hw_params,
+
+	.hw_info		= SNDRV_PCM_INFO_MMAP |
+				  SNDRV_PCM_INFO_MMAP_VALID |
+				  SNDRV_PCM_INFO_INTERLEAVED |
+				  SNDRV_PCM_INFO_PAUSE |
+				  SNDRV_PCM_INFO_NO_PERIOD_WAKEUP,
+
+	/* Machine driver callbacks */
+	.machine_select		= amd_sof_machine_select,
+	.machine_register	= sof_machine_register,
+	.machine_unregister	= sof_machine_unregister,
+
+	/* Trace Logger */
+	.trace_init		= acp_sof_trace_init,
+	.trace_release		= acp_sof_trace_release,
+
+	/* PM */
+	.suspend                = amd_sof_acp_suspend,
+	.resume                 = amd_sof_acp_resume,
+};
+EXPORT_SYMBOL_NS(sof_acp_common_ops, SND_SOC_SOF_AMD_COMMON);
+
+MODULE_IMPORT_NS(SND_SOC_SOF_AMD_COMMON);
+MODULE_DESCRIPTION("ACP SOF COMMON Driver");
+MODULE_LICENSE("Dual BSD/GPL");
diff --git a/sound/soc/sof/amd/acp-dsp-offset.h b/sound/soc/sof/amd/acp-dsp-offset.h
index 56cefd4a84fc..47151a84f90b 100644
--- a/sound/soc/sof/amd/acp-dsp-offset.h
+++ b/sound/soc/sof/amd/acp-dsp-offset.h
@@ -48,22 +48,23 @@
 #define ACP_SOFT_RESET				0x1000
 #define ACP_CONTROL				0x1004
 
-#define ACP_I2S_PIN_CONFIG			0x1400
+#define ACP3X_I2S_PIN_CONFIG			0x1400
 
-/* Registers from ACP_PGFSM block */
-#define ACP_PGFSM_CONTROL			0x141C
-#define ACP_PGFSM_STATUS			0x1420
-#define ACP_CLKMUX_SEL				0x1424
+/* Registers offsets from ACP_PGFSM block */
+#define ACP3X_PGFSM_BASE			0x141C
+#define PGFSM_CONTROL_OFFSET			0x0
+#define PGFSM_STATUS_OFFSET			0x4
+#define ACP3X_CLKMUX_SEL			0x1424
 
 /* Registers from ACP_INTR block */
-#define ACP_EXTERNAL_INTR_ENB			0x1800
-#define ACP_EXTERNAL_INTR_CNTL			0x1804
-#define ACP_EXTERNAL_INTR_STAT			0x1808
-#define ACP_DSP_SW_INTR_CNTL			0x1814
-#define ACP_DSP_SW_INTR_STAT                    0x1818
-#define ACP_SW_INTR_TRIG                        0x181C
+#define ACP3X_EXT_INTR_STAT			0x1808
+
+#define ACP3X_DSP_SW_INTR_BASE			0x1814
+#define DSP_SW_INTR_CNTL_OFFSET			0x0
+#define DSP_SW_INTR_STAT_OFFSET			0x4
+#define DSP_SW_INTR_TRIG_OFFSET			0x8
 #define ACP_ERROR_STATUS			0x18C4
-#define ACP_AXI2DAGB_SEM_0			0x1880
+#define ACP3X_AXI2DAGB_SEM_0			0x1880
 
 /* Registers from ACP_SHA block */
 #define ACP_SHA_DSP_FW_QUALIFIER		0x1C70
diff --git a/sound/soc/sof/amd/acp-ipc.c b/sound/soc/sof/amd/acp-ipc.c
index e1842f037083..e09392498f4c 100644
--- a/sound/soc/sof/amd/acp-ipc.c
+++ b/sound/soc/sof/amd/acp-ipc.c
@@ -30,11 +30,14 @@ EXPORT_SYMBOL_NS(acp_mailbox_read, SND_SOC_SOF_AMD_COMMON);
 static void acpbus_trigger_host_to_dsp_swintr(struct acp_dev_data *adata)
 {
 	struct snd_sof_dev *sdev = adata->dev;
+	const struct sof_amd_acp_desc *desc = get_chip_info(sdev->pdata);
 	u32 swintr_trigger;
 
-	swintr_trigger = snd_sof_dsp_read(sdev, ACP_DSP_BAR, ACP_SW_INTR_TRIG);
+	swintr_trigger = snd_sof_dsp_read(sdev, ACP_DSP_BAR, desc->dsp_intr_base +
+						DSP_SW_INTR_TRIG_OFFSET);
 	swintr_trigger |= 0x01;
-	snd_sof_dsp_write(sdev, ACP_DSP_BAR, ACP_SW_INTR_TRIG, swintr_trigger);
+	snd_sof_dsp_write(sdev, ACP_DSP_BAR, desc->dsp_intr_base + DSP_SW_INTR_TRIG_OFFSET,
+			  swintr_trigger);
 }
 
 static void acp_ipc_host_msg_set(struct snd_sof_dev *sdev)
@@ -61,10 +64,11 @@ static void acp_dsp_ipc_dsp_done(struct snd_sof_dev *sdev)
 int acp_sof_ipc_send_msg(struct snd_sof_dev *sdev, struct snd_sof_ipc_msg *msg)
 {
 	struct acp_dev_data *adata = sdev->pdata->hw_pdata;
+	const struct sof_amd_acp_desc *desc = get_chip_info(sdev->pdata);
 	unsigned int offset = offsetof(struct scratch_ipc_conf, sof_in_box);
 	unsigned int count = ACP_HW_SEM_RETRY_COUNT;
 
-	while (snd_sof_dsp_read(sdev, ACP_DSP_BAR, ACP_AXI2DAGB_SEM_0)) {
+	while (snd_sof_dsp_read(sdev, ACP_DSP_BAR, desc->hw_semaphore_offset)) {
 		/* Wait until acquired HW Semaphore Lock or timeout*/
 		count--;
 		if (!count) {
@@ -80,7 +84,7 @@ int acp_sof_ipc_send_msg(struct snd_sof_dev *sdev, struct snd_sof_ipc_msg *msg)
 	acpbus_trigger_host_to_dsp_swintr(adata);
 
 	/* Unlock or Release HW Semaphore */
-	snd_sof_dsp_write(sdev, ACP_DSP_BAR, ACP_AXI2DAGB_SEM_0, 0x0);
+	snd_sof_dsp_write(sdev, ACP_DSP_BAR, desc->hw_semaphore_offset, 0x0);
 
 	return 0;
 }
@@ -186,7 +190,9 @@ EXPORT_SYMBOL_NS(acp_sof_ipc_msg_data, SND_SOC_SOF_AMD_COMMON);
 
 int acp_sof_ipc_get_mailbox_offset(struct snd_sof_dev *sdev)
 {
-	return ACP_SCRATCH_MEMORY_ADDRESS;
+	const struct sof_amd_acp_desc *desc = get_chip_info(sdev->pdata);
+
+	return desc->sram_pte_offset;
 }
 EXPORT_SYMBOL_NS(acp_sof_ipc_get_mailbox_offset, SND_SOC_SOF_AMD_COMMON);
 
diff --git a/sound/soc/sof/amd/acp-loader.c b/sound/soc/sof/amd/acp-loader.c
index 7ca51e0f3b1b..f372f93094f3 100644
--- a/sound/soc/sof/amd/acp-loader.c
+++ b/sound/soc/sof/amd/acp-loader.c
@@ -30,9 +30,10 @@
 int acp_dsp_block_read(struct snd_sof_dev *sdev, enum snd_sof_fw_blk_type blk_type,
 		       u32 offset, void *dest, size_t size)
 {
+	const struct sof_amd_acp_desc *desc = get_chip_info(sdev->pdata);
 	switch (blk_type) {
 	case SOF_FW_BLK_TYPE_SRAM:
-		offset = offset - ACP_SCRATCH_MEMORY_ADDRESS;
+		offset = offset - desc->sram_pte_offset;
 		memcpy_from_scratch(sdev, offset, dest, size);
 		break;
 	default:
@@ -49,6 +50,7 @@ int acp_dsp_block_write(struct snd_sof_dev *sdev, enum snd_sof_fw_blk_type blk_t
 {
 	struct snd_sof_pdata *plat_data = sdev->pdata;
 	struct pci_dev *pci = to_pci_dev(sdev->dev);
+	const struct sof_amd_acp_desc *desc = get_chip_info(sdev->pdata);
 	struct acp_dev_data *adata;
 	void *dest;
 	u32 dma_size, page_count;
@@ -84,7 +86,7 @@ int acp_dsp_block_write(struct snd_sof_dev *sdev, enum snd_sof_fw_blk_type blk_t
 		adata->fw_data_bin_size = size + offset;
 		break;
 	case SOF_FW_BLK_TYPE_SRAM:
-		offset = offset - ACP_SCRATCH_MEMORY_ADDRESS;
+		offset = offset - desc->sram_pte_offset;
 		memcpy_to_scratch(sdev, offset, src, size);
 		return 0;
 	default:
@@ -105,14 +107,13 @@ EXPORT_SYMBOL_NS(acp_get_bar_index, SND_SOC_SOF_AMD_COMMON);
 
 static void configure_pte_for_fw_loading(int type, int num_pages, struct acp_dev_data *adata)
 {
-	struct snd_sof_dev *sdev;
+	struct snd_sof_dev *sdev = adata->dev;
+	const struct sof_amd_acp_desc *desc = get_chip_info(sdev->pdata);
 	unsigned int low, high;
 	dma_addr_t addr;
 	u16 page_idx;
 	u32 offset;
 
-	sdev = adata->dev;
-
 	switch (type) {
 	case FW_BIN:
 		offset = FW_BIN_PTE_OFFSET;
@@ -129,7 +130,7 @@ static void configure_pte_for_fw_loading(int type, int num_pages, struct acp_dev
 
 	/* Group Enable */
 	snd_sof_dsp_write(sdev, ACP_DSP_BAR, ACPAXI2AXI_ATU_BASE_ADDR_GRP_1,
-			  ACP_SRAM_PTE_OFFSET | BIT(31));
+			  desc->sram_pte_offset | BIT(31));
 	snd_sof_dsp_write(sdev, ACP_DSP_BAR, ACPAXI2AXI_ATU_PAGE_SIZE_GRP_1,
 			  PAGE_SIZE_4K_ENABLE);
 
diff --git a/sound/soc/sof/amd/acp-stream.c b/sound/soc/sof/amd/acp-stream.c
index b3ca4a90dbf8..f71b4e660b14 100644
--- a/sound/soc/sof/amd/acp-stream.c
+++ b/sound/soc/sof/amd/acp-stream.c
@@ -26,6 +26,7 @@
 
 int acp_dsp_stream_config(struct snd_sof_dev *sdev, struct acp_dsp_stream *stream)
 {
+	const struct sof_amd_acp_desc *desc = get_chip_info(sdev->pdata);
 	unsigned int pte_reg, pte_size, phy_addr_offset, index;
 	int stream_tag = stream->stream_tag;
 	u32 low, high, offset, reg_val;
@@ -96,7 +97,7 @@ int acp_dsp_stream_config(struct snd_sof_dev *sdev, struct acp_dsp_stream *strea
 			  phy_addr_offset, stream->reg_offset);
 
 	/* Group Enable */
-	reg_val = ACP_SRAM_PTE_OFFSET + offset;
+	reg_val = desc->sram_pte_offset + offset;
 	snd_sof_dsp_write(sdev, ACP_DSP_BAR, pte_reg, reg_val | BIT(31));
 	snd_sof_dsp_write(sdev, ACP_DSP_BAR, pte_size, PAGE_SIZE_4K_ENABLE);
 
diff --git a/sound/soc/sof/amd/acp.c b/sound/soc/sof/amd/acp.c
index c40d2900dd36..47eaabc95aa5 100644
--- a/sound/soc/sof/amd/acp.c
+++ b/sound/soc/sof/amd/acp.c
@@ -39,9 +39,10 @@ static int smn_read(struct pci_dev *dev, u32 smn_addr, u32 *data)
 static void init_dma_descriptor(struct acp_dev_data *adata)
 {
 	struct snd_sof_dev *sdev = adata->dev;
+	const struct sof_amd_acp_desc *desc = get_chip_info(sdev->pdata);
 	unsigned int addr;
 
-	addr = ACP_SRAM_PTE_OFFSET + offsetof(struct scratch_reg_conf, dma_desc);
+	addr = desc->sram_pte_offset + offsetof(struct scratch_reg_conf, dma_desc);
 
 	snd_sof_dsp_write(sdev, ACP_DSP_BAR, ACP_DMA_DESC_BASE_ADDR, addr);
 	snd_sof_dsp_write(sdev, ACP_DSP_BAR, ACP_DMA_DESC_MAX_NUM_DSCR, ACP_MAX_DESC_CNT);
@@ -300,8 +301,9 @@ void memcpy_to_scratch(struct snd_sof_dev *sdev, u32 offset, unsigned int *src,
 static int acp_memory_init(struct snd_sof_dev *sdev)
 {
 	struct acp_dev_data *adata = sdev->pdata->hw_pdata;
+	const struct sof_amd_acp_desc *desc = get_chip_info(sdev->pdata);
 
-	snd_sof_dsp_update_bits(sdev, ACP_DSP_BAR, ACP_DSP_SW_INTR_CNTL,
+	snd_sof_dsp_update_bits(sdev, ACP_DSP_BAR, desc->dsp_intr_base + DSP_SW_INTR_CNTL_OFFSET,
 				ACP_DSP_INTR_EN_MASK, ACP_DSP_INTR_EN_MASK);
 	init_dma_descriptor(adata);
 
@@ -311,18 +313,20 @@ static int acp_memory_init(struct snd_sof_dev *sdev)
 static irqreturn_t acp_irq_thread(int irq, void *context)
 {
 	struct snd_sof_dev *sdev = context;
+	const struct sof_amd_acp_desc *desc = get_chip_info(sdev->pdata);
+	unsigned int base = desc->dsp_intr_base;
 	unsigned int val, count = ACP_HW_SEM_RETRY_COUNT;
 
-	val = snd_sof_dsp_read(sdev, ACP_DSP_BAR, ACP_EXTERNAL_INTR_STAT);
+	val = snd_sof_dsp_read(sdev, ACP_DSP_BAR, desc->ext_intr_stat);
 	if (val & ACP_SHA_STAT) {
 		/* Clear SHA interrupt raised by PSP */
-		snd_sof_dsp_write(sdev, ACP_DSP_BAR, ACP_EXTERNAL_INTR_STAT, val);
+		snd_sof_dsp_write(sdev, ACP_DSP_BAR, desc->ext_intr_stat, val);
 		return IRQ_HANDLED;
 	}
 
-	val = snd_sof_dsp_read(sdev, ACP_DSP_BAR, ACP_DSP_SW_INTR_STAT);
+	val = snd_sof_dsp_read(sdev, ACP_DSP_BAR, base + DSP_SW_INTR_STAT_OFFSET);
 	if (val & ACP_DSP_TO_HOST_IRQ) {
-		while (snd_sof_dsp_read(sdev, ACP_DSP_BAR, ACP_AXI2DAGB_SEM_0)) {
+		while (snd_sof_dsp_read(sdev, ACP_DSP_BAR, desc->hw_semaphore_offset)) {
 			/* Wait until acquired HW Semaphore lock or timeout */
 			count--;
 			if (!count) {
@@ -333,10 +337,10 @@ static irqreturn_t acp_irq_thread(int irq, void *context)
 
 		sof_ops(sdev)->irq_thread(irq, sdev);
 		val |= ACP_DSP_TO_HOST_IRQ;
-		snd_sof_dsp_write(sdev, ACP_DSP_BAR, ACP_DSP_SW_INTR_STAT, val);
+		snd_sof_dsp_write(sdev, ACP_DSP_BAR, base + DSP_SW_INTR_STAT_OFFSET, val);
 
 		/* Unlock or Release HW Semaphore */
-		snd_sof_dsp_write(sdev, ACP_DSP_BAR, ACP_AXI2DAGB_SEM_0, 0x0);
+		snd_sof_dsp_write(sdev, ACP_DSP_BAR, desc->hw_semaphore_offset, 0x0);
 
 		return IRQ_HANDLED;
 	}
@@ -347,9 +351,11 @@ static irqreturn_t acp_irq_thread(int irq, void *context)
 static irqreturn_t acp_irq_handler(int irq, void *dev_id)
 {
 	struct snd_sof_dev *sdev = dev_id;
+	const struct sof_amd_acp_desc *desc = get_chip_info(sdev->pdata);
+	unsigned int base = desc->dsp_intr_base;
 	unsigned int val;
 
-	val = snd_sof_dsp_read(sdev, ACP_DSP_BAR, ACP_DSP_SW_INTR_STAT);
+	val = snd_sof_dsp_read(sdev, ACP_DSP_BAR, base + DSP_SW_INTR_STAT_OFFSET);
 	if (val)
 		return IRQ_WAKE_THREAD;
 
@@ -358,20 +364,22 @@ static irqreturn_t acp_irq_handler(int irq, void *dev_id)
 
 static int acp_power_on(struct snd_sof_dev *sdev)
 {
+	const struct sof_amd_acp_desc *desc = get_chip_info(sdev->pdata);
+	unsigned int base = desc->pgfsm_base;
 	unsigned int val;
 	int ret;
 
-	val = snd_sof_dsp_read(sdev, ACP_DSP_BAR, ACP_PGFSM_STATUS);
+	val = snd_sof_dsp_read(sdev, ACP_DSP_BAR, base + PGFSM_STATUS_OFFSET);
 
 	if (val == ACP_POWERED_ON)
 		return 0;
 
 	if (val & ACP_PGFSM_STATUS_MASK)
-		snd_sof_dsp_write(sdev, ACP_DSP_BAR, ACP_PGFSM_CONTROL,
+		snd_sof_dsp_write(sdev, ACP_DSP_BAR, base + PGFSM_CONTROL_OFFSET,
 				  ACP_PGFSM_CNTL_POWER_ON_MASK);
 
-	ret = snd_sof_dsp_read_poll_timeout(sdev, ACP_DSP_BAR, ACP_PGFSM_STATUS, val, !val,
-					    ACP_REG_POLL_INTERVAL, ACP_REG_POLL_TIMEOUT_US);
+	ret = snd_sof_dsp_read_poll_timeout(sdev, ACP_DSP_BAR, base + PGFSM_STATUS_OFFSET, val,
+					    !val, ACP_REG_POLL_INTERVAL, ACP_REG_POLL_TIMEOUT_US);
 	if (ret < 0)
 		dev_err(sdev->dev, "timeout in ACP_PGFSM_STATUS read\n");
 
@@ -437,6 +445,7 @@ EXPORT_SYMBOL_NS(amd_sof_acp_suspend, SND_SOC_SOF_AMD_COMMON);
 
 int amd_sof_acp_resume(struct snd_sof_dev *sdev)
 {
+	const struct sof_amd_acp_desc *desc = get_chip_info(sdev->pdata);
 	int ret;
 
 	ret = acp_init(sdev);
@@ -445,7 +454,7 @@ int amd_sof_acp_resume(struct snd_sof_dev *sdev)
 		return ret;
 	}
 
-	snd_sof_dsp_write(sdev, ACP_DSP_BAR, ACP_CLKMUX_SEL, 0x03);
+	snd_sof_dsp_write(sdev, ACP_DSP_BAR, desc->acp_clkmux_sel, 0x03);
 
 	ret = acp_memory_init(sdev);
 
diff --git a/sound/soc/sof/amd/acp.h b/sound/soc/sof/amd/acp.h
index 4c42b8fd6abf..bc024be76e09 100644
--- a/sound/soc/sof/amd/acp.h
+++ b/sound/soc/sof/amd/acp.h
@@ -30,7 +30,7 @@
 #define ACP_SOFT_RESET_DONE_MASK		0x00010001
 
 #define ACP_DSP_INTR_EN_MASK			0x00000001
-#define ACP_SRAM_PTE_OFFSET			0x02050000
+#define ACP3X_SRAM_PTE_OFFSET			0x02050000
 #define PAGE_SIZE_4K_ENABLE			0x2
 #define ACP_PAGE_SIZE				0x1000
 #define ACP_DMA_CH_RUN				0x02
@@ -45,7 +45,7 @@
 #define ACPBUS_REG_BASE_OFFSET			ACP_DMA_CNTL_0
 
 #define ACP_DEFAULT_DRAM_LENGTH			0x00080000
-#define ACP_SCRATCH_MEMORY_ADDRESS		0x02050000
+#define ACP3X_SCRATCH_MEMORY_ADDRESS		0x02050000
 #define ACP_SYSTEM_MEMORY_WINDOW		0x4000000
 #define ACP_IRAM_BASE_ADDRESS			0x000000
 #define ACP_DATA_RAM_BASE_ADDRESS		0x01000000
@@ -139,6 +139,19 @@ struct acp_dsp_stream {
 	unsigned int reg_offset;
 };
 
+struct sof_amd_acp_desc {
+	unsigned int rev;
+	unsigned int host_bridge_id;
+	unsigned int i2s_mode;
+	u32 pgfsm_base;
+	u32 ext_intr_stat;
+	u32 dsp_intr_base;
+	u32 sram_pte_offset;
+	u32 i2s_pin_config_offset;
+	u32 hw_semaphore_offset;
+	u32 acp_clkmux_sel;
+};
+
 /* Common device data struct for ACP devices */
 struct acp_dev_data {
 	struct snd_sof_dev  *dev;
@@ -206,8 +219,13 @@ int acp_pcm_hw_params(struct snd_sof_dev *sdev, struct snd_pcm_substream *substr
 		      struct snd_pcm_hw_params *params,
 		      struct snd_sof_platform_stream_params *platform_params);
 
+extern struct snd_sof_dsp_ops sof_acp_common_ops;
+
 extern struct snd_sof_dsp_ops sof_renoir_ops;
+int sof_renoir_ops_init(struct snd_sof_dev *sdev);
 
+int acp_dai_probe(struct snd_soc_dai *dai);
+struct snd_soc_acpi_mach *amd_sof_machine_select(struct snd_sof_dev *sdev);
 /* Machine configuration */
 int snd_amd_acp_find_config(struct pci_dev *pci);
 
@@ -220,10 +238,6 @@ int acp_sof_trace_release(struct snd_sof_dev *sdev);
 int amd_sof_acp_suspend(struct snd_sof_dev *sdev, u32 target_state);
 int amd_sof_acp_resume(struct snd_sof_dev *sdev);
 
-struct sof_amd_acp_desc {
-	unsigned int host_bridge_id;
-};
-
 static inline const struct sof_amd_acp_desc *get_chip_info(struct snd_sof_pdata *pdata)
 {
 	const struct sof_dev_desc *desc = pdata->desc;
diff --git a/sound/soc/sof/amd/pci-rn.c b/sound/soc/sof/amd/pci-rn.c
index 3a7fed25a226..fca40b261671 100644
--- a/sound/soc/sof/amd/pci-rn.c
+++ b/sound/soc/sof/amd/pci-rn.c
@@ -21,6 +21,7 @@
 #include "../sof-pci-dev.h"
 #include "../../amd/mach-config.h"
 #include "acp.h"
+#include "acp-dsp-offset.h"
 
 #define ACP3x_REG_START		0x1240000
 #define ACP3x_REG_END		0x125C000
@@ -44,7 +45,16 @@ static const struct resource renoir_res[] = {
 };
 
 static const struct sof_amd_acp_desc renoir_chip_info = {
+	.rev		= 3,
 	.host_bridge_id = HOST_BRIDGE_CZN,
+	.i2s_mode	= 0x04,
+	.pgfsm_base	= ACP3X_PGFSM_BASE,
+	.ext_intr_stat	= ACP3X_EXT_INTR_STAT,
+	.dsp_intr_base	= ACP3X_DSP_SW_INTR_BASE,
+	.sram_pte_offset = ACP3X_SRAM_PTE_OFFSET,
+	.i2s_pin_config_offset = ACP3X_I2S_PIN_CONFIG,
+	.hw_semaphore_offset = ACP3X_AXI2DAGB_SEM_0,
+	.acp_clkmux_sel	= ACP3X_CLKMUX_SEL,
 };
 
 static const struct sof_dev_desc renoir_desc = {
@@ -68,6 +78,7 @@ static const struct sof_dev_desc renoir_desc = {
 	},
 	.nocodec_tplg_filename	= "sof-acp.tplg",
 	.ops			= &sof_renoir_ops,
+	.ops_init		= sof_renoir_ops_init,
 };
 
 static int acp_pci_rn_probe(struct pci_dev *pci, const struct pci_device_id *pci_id)
diff --git a/sound/soc/sof/amd/renoir.c b/sound/soc/sof/amd/renoir.c
index 9261c8bc2236..6ea8727f977e 100644
--- a/sound/soc/sof/amd/renoir.c
+++ b/sound/soc/sof/amd/renoir.c
@@ -23,22 +23,6 @@
 #define I2S_SP_INSTANCE		1
 #define PDM_DMIC_INSTANCE	2
 
-#define I2S_MODE		0x04
-
-static int renoir_dai_probe(struct snd_soc_dai *dai)
-{
-	struct snd_sof_dev *sdev = snd_soc_component_get_drvdata(dai->component);
-	unsigned int val;
-
-	val = snd_sof_dsp_read(sdev, ACP_DSP_BAR, ACP_I2S_PIN_CONFIG);
-	if (val != I2S_MODE) {
-		dev_err(sdev->dev, "I2S Mode is not supported (I2S_PIN_CONFIG: %#x)\n", val);
-		return -EINVAL;
-	}
-
-	return 0;
-}
-
 static struct snd_soc_dai_driver renoir_sof_dai[] = {
 	[I2S_BT_INSTANCE] = {
 		.id = I2S_BT_INSTANCE,
@@ -62,7 +46,7 @@ static struct snd_soc_dai_driver renoir_sof_dai[] = {
 			.rate_min = 8000,
 			.rate_max = 48000,
 		},
-		.probe = &renoir_dai_probe,
+		.probe = &acp_dai_probe,
 	},
 
 	[I2S_SP_INSTANCE] = {
@@ -87,7 +71,7 @@ static struct snd_soc_dai_driver renoir_sof_dai[] = {
 			.rate_min = 8000,
 			.rate_max = 48000,
 		},
-		.probe = &renoir_dai_probe,
+		.probe = &acp_dai_probe,
 	},
 
 	[PDM_DMIC_INSTANCE] = {
@@ -104,82 +88,21 @@ static struct snd_soc_dai_driver renoir_sof_dai[] = {
 	},
 };
 
-static struct snd_soc_acpi_mach *amd_sof_machine_select(struct snd_sof_dev *sdev)
-{
-	struct snd_sof_pdata *sof_pdata = sdev->pdata;
-	const struct sof_dev_desc *desc = sof_pdata->desc;
-	struct snd_soc_acpi_mach *mach;
+/* Renoir ops */
+struct snd_sof_dsp_ops sof_renoir_ops;
+EXPORT_SYMBOL_NS(sof_renoir_ops, SND_SOC_SOF_AMD_COMMON);
 
-	mach = snd_soc_acpi_find_machine(desc->machines);
-	if (!mach) {
-		dev_warn(sdev->dev, "No matching ASoC machine driver found\n");
-		return NULL;
-	}
+int sof_renoir_ops_init(struct snd_sof_dev *sdev)
+{
+	/* common defaults */
+	memcpy(&sof_renoir_ops, &sof_acp_common_ops, sizeof(struct snd_sof_dsp_ops));
 
-	sof_pdata->tplg_filename = mach->sof_tplg_filename;
-	sof_pdata->fw_filename = mach->fw_filename;
+	sof_renoir_ops.drv = renoir_sof_dai;
+	sof_renoir_ops.num_drv = ARRAY_SIZE(renoir_sof_dai);
 
-	return mach;
+	return 0;
 }
 
-/* AMD Renoir DSP ops */
-struct snd_sof_dsp_ops sof_renoir_ops = {
-	/* probe and remove */
-	.probe			= amd_sof_acp_probe,
-	.remove			= amd_sof_acp_remove,
-
-	/* Register IO */
-	.write			= sof_io_write,
-	.read			= sof_io_read,
-
-	/* Block IO */
-	.block_read		= acp_dsp_block_read,
-	.block_write		= acp_dsp_block_write,
-
-	/*Firmware loading */
-	.load_firmware		= snd_sof_load_firmware_memcpy,
-	.pre_fw_run		= acp_dsp_pre_fw_run,
-	.get_bar_index		= acp_get_bar_index,
-
-	/* DSP core boot */
-	.run			= acp_sof_dsp_run,
-
-	/*IPC */
-	.send_msg		= acp_sof_ipc_send_msg,
-	.ipc_msg_data		= acp_sof_ipc_msg_data,
-	.get_mailbox_offset	= acp_sof_ipc_get_mailbox_offset,
-	.irq_thread		= acp_sof_ipc_irq_thread,
-
-	/* DAI drivers */
-	.drv			= renoir_sof_dai,
-	.num_drv		= ARRAY_SIZE(renoir_sof_dai),
-
-	/* stream callbacks */
-	.pcm_open		= acp_pcm_open,
-	.pcm_close		= acp_pcm_close,
-	.pcm_hw_params		= acp_pcm_hw_params,
-
-	.hw_info		= SNDRV_PCM_INFO_MMAP |
-				  SNDRV_PCM_INFO_MMAP_VALID |
-				  SNDRV_PCM_INFO_INTERLEAVED |
-				  SNDRV_PCM_INFO_PAUSE |
-				  SNDRV_PCM_INFO_NO_PERIOD_WAKEUP,
-
-	/* Machine driver callbacks */
-	.machine_select		= amd_sof_machine_select,
-	.machine_register	= sof_machine_register,
-	.machine_unregister	= sof_machine_unregister,
-
-	/* Trace Logger */
-	.trace_init		= acp_sof_trace_init,
-	.trace_release		= acp_sof_trace_release,
-
-	/* PM */
-	.suspend                = amd_sof_acp_suspend,
-	.resume                 = amd_sof_acp_resume,
-};
-EXPORT_SYMBOL(sof_renoir_ops);
-
 MODULE_IMPORT_NS(SND_SOC_SOF_AMD_COMMON);
 MODULE_DESCRIPTION("RENOIR SOF Driver");
 MODULE_LICENSE("Dual BSD/GPL");
-- 
2.25.1

