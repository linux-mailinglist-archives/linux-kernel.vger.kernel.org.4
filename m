Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 150AF5B7569
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 17:42:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236621AbiIMPkL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 11:40:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236832AbiIMPjI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 11:39:08 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2061f.outbound.protection.outlook.com [IPv6:2a01:111:f400:7eab::61f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A26326AC7
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 07:44:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c/ZGX1UpS8jy6rCNOy1jIFlxtog5odvoVXkpZHQg95YQhqTXCPxdc1aNxHiMmM0Tf9FUomhtK6GgotyMvtzU8/PJ46JAVmkbLzUvQU/D0rwV/N14ltErpvOE+FBfBK1pFm6R6RDHNo5blW+md7BlIiI5cjVh1txAbnYR9iaaluUrVZT39xqLtJLzyu5AqkWtKgNGnFpOLCSc/fiHi4bljeDh3v3Hzb3c9/clEjHVQzxTebhwuM16hgxsHvXKATrIDvFsTFb4LzrhX51Xsdq6MwNCDGMcK+74nqS/Mr+jExW7/HQADZFyqKeUyGUJx4yaJDLWXL268PBVZNiTdO9rqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DCLQwzfUXzDcaChmXgFFiE8RHiTeNZQqS+yBDMDu/38=;
 b=WrjkpxcE5Z7B2k+5G7FAi/6h824u23yhcUUlycdWnLTHRIlHcgGn8cxf1KkNd58wq6i9wCWvpESsvaCpw7edaI/S/SboDlb5i89cV1RA2fJfhXD2/rKbTBW45AHc9gAEpmqFUuNu4F/Ji+MB+eOXCa0xIdYyfZGjCXnmh7YGVZb1Q+yMcQhbILLUf/o/dgxcC4I8fykLMXG+QNuIbg92Npmkb5gVOCrnm6PF/ISUIXaOCqAXKEUYkxckVogg/lJsHN2Ug8PJgilZCbsmsMAmJ60tmOT7iyaA0OMGEnN+OXWkzw4yteA4ZGPp4H8/3OQPfUWAwSbbgtiHjmvNVSBeRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DCLQwzfUXzDcaChmXgFFiE8RHiTeNZQqS+yBDMDu/38=;
 b=0oKMZ+WGKp1H9/2sYud2KO8qD4FCxHDoT+O5cAGqwBfGcjwRUct7gZIFaTpm5VxufhYavuJrCNfvofGiNA2/RVS7iRrth06o7PdmNKKdvIIvBmPqmH0dbpsxz23hc7TTgmUPZOBe1D1davsr82NbibdFR3/0SNEMBtb3KAXU+7s=
Received: from BN9P223CA0015.NAMP223.PROD.OUTLOOK.COM (2603:10b6:408:10b::20)
 by SJ1PR12MB6267.namprd12.prod.outlook.com (2603:10b6:a03:456::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.22; Tue, 13 Sep
 2022 14:41:52 +0000
Received: from BN8NAM11FT098.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:10b:cafe::9d) by BN9P223CA0015.outlook.office365.com
 (2603:10b6:408:10b::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.18 via Frontend
 Transport; Tue, 13 Sep 2022 14:41:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT098.mail.protection.outlook.com (10.13.177.196) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5612.13 via Frontend Transport; Tue, 13 Sep 2022 14:41:51 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 13 Sep
 2022 09:41:50 -0500
Received: from sof-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.28
 via Frontend Transport; Tue, 13 Sep 2022 09:41:45 -0500
From:   V sujith kumar Reddy <Vsujithkumar.Reddy@amd.com>
To:     <broonie@kernel.org>, <alsa-devel@alsa-project.org>
CC:     <Vijendar.Mukunda@amd.com>, <Basavaraj.Hiregoudar@amd.com>,
        <Sunil-kumar.Dommati@amd.com>, <venkataprasad.potturu@amd.com>,
        <ssabakar@amd.com>,
        V sujith kumar Reddy <Vsujithkumar.Reddy@amd.com>,
        "Ajit Kumar Pandey" <AjitKumar.Pandey@amd.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Rander Wang <rander.wang@intel.com>,
        Zheng Bin <zhengbin13@huawei.com>,
        "Guennadi Liakhovetski" <guennadi.liakhovetski@linux.intel.com>,
        open list <linux-kernel@vger.kernel.org>,
        "moderated list:SOUND - SOUND OPEN FIRMWARE (SOF) DRIVERS" 
        <sound-open-firmware@alsa-project.org>
Subject: [PATCH 2/4] ASoC: SOF: amd: Add support for Rembrandt plaform.
Date:   Tue, 13 Sep 2022 20:13:16 +0530
Message-ID: <20220913144319.1055302-3-Vsujithkumar.Reddy@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220913144319.1055302-1-Vsujithkumar.Reddy@amd.com>
References: <20220913144319.1055302-1-Vsujithkumar.Reddy@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT098:EE_|SJ1PR12MB6267:EE_
X-MS-Office365-Filtering-Correlation-Id: 355bf83c-51ea-44d4-bf65-08da959618b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eZp2WdC2ouwPxk4euF5ieu2LouZkNkvDrTtcz8cSwux8f/FNQCl46ywZ4svAmxocsyDUlPe7bLukrwA6Q+9dCQcyQCVtwk0VfcL5JWl6wffBWMHJvBsP3mnEmw8YijUdQoxp9oIfNZvWWn3XDQsYSTAEbq69Et1u0Hqs1Stz1OW9QEKdN06eAB8r6U4zeMOtp+Sz/0xbBC/DL0//RCUUN8prRsnIdDg/Ok2t93KFPZQdVlZEm2vkvlQ+IwjhwYKS0Ku/Y9HypNEjx2RuVVWex2OvYWtsMpvuDdBxcVtMJDqEax0vnoeYCUsRWNwYA1Er+72oKfhusqB7b8MrU6Z+GXy25BWxWbX2PdRhqzSQnbj/B8+A/3LD44H7kDjJdzUgsHZoQ8N5P62WuaR+5mxWjJ5p5b8XftkeF+dCd/AGgqWDt/Ecr5Viy+DExhsaXLjBVdDBkY5ddU958BV6jmBLKpGto/tlniOKDPHmB/mc3N2uNPhjNPxBGinHrxir6G0W07sflwlAO6j8KKREkbW5gfuPoWjUU5ArDoxryrEN469RGFWOOeq0HiYRxsD/PBpEZyMNeISEX41NQ2CZDs/UbqRu9kHkZzeNdBSWfLEFS9DGVAh1sYW7/yFCVpT2TVQzy52SdgrL3614f7WVyg0OMSNB3uVpkZx5Zy906WEHCV8c1kcekd+lD4ag4dP4I45/pf0Bf0vBnYDAJbJJOduKrFuQZxL+BWkPUR7EJsxHmO503GE3z8AKirS8DnpUc25DMabPwCjEuzVrHf1XB4VD/zSJzUentYqiXItU7X0yg09pk0SJPXD0UAnlM5D47Iqm
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(346002)(136003)(376002)(396003)(39860400002)(451199015)(40470700004)(36840700001)(46966006)(41300700001)(316002)(7416002)(47076005)(426003)(186003)(4326008)(70586007)(2906002)(70206006)(82740400003)(5660300002)(8676002)(26005)(36756003)(40480700001)(30864003)(8936002)(478600001)(54906003)(82310400005)(2616005)(86362001)(6666004)(40460700003)(110136005)(356005)(1076003)(83380400001)(7696005)(336012)(81166007)(36860700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2022 14:41:51.7893
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 355bf83c-51ea-44d4-bf65-08da959618b7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT098.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6267
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add pci driver and platform driver to enable SOF support on ACP6x
architecture based Rembrandt platform.

Signed-off-by: Ajit Kumar Pandey <AjitKumar.Pandey@amd.com>
Signed-off-by: V sujith kumar Reddy <Vsujithkumar.Reddy@amd.com>
---
 sound/soc/sof/amd/Kconfig          |  10 ++
 sound/soc/sof/amd/Makefile         |   2 +
 sound/soc/sof/amd/acp-dsp-offset.h |   8 +-
 sound/soc/sof/amd/acp-loader.c     |   7 ++
 sound/soc/sof/amd/acp.h            |   5 +
 sound/soc/sof/amd/pci-rmb.c        | 186 +++++++++++++++++++++++++++++
 sound/soc/sof/amd/rembrandt.c      | 134 +++++++++++++++++++++
 7 files changed, 351 insertions(+), 1 deletion(-)
 create mode 100644 sound/soc/sof/amd/pci-rmb.c
 create mode 100644 sound/soc/sof/amd/rembrandt.c

diff --git a/sound/soc/sof/amd/Kconfig b/sound/soc/sof/amd/Kconfig
index 190c85d57047..a305ea6efea9 100644
--- a/sound/soc/sof/amd/Kconfig
+++ b/sound/soc/sof/amd/Kconfig
@@ -31,4 +31,14 @@ config SND_SOC_SOF_AMD_RENOIR
 	select SND_SOC_SOF_AMD_COMMON
 	help
 	  Select this option for SOF support on AMD Renoir platform
+
+config SND_SOC_SOF_AMD_REMBRANDT
+	tristate "SOF support for REMBRANDT"
+	depends on SND_SOC_SOF_PCI
+	select SND_SOC_SOF_AMD_COMMON
+	help
+	  Select this option for SOF support on AMD Rembrandt platform
+	  Say Y if you want to enable SOF on Rembrandt.
+	  If unsure select "N".
+
 endif
diff --git a/sound/soc/sof/amd/Makefile b/sound/soc/sof/amd/Makefile
index efea92f62a86..5626d13b3e69 100644
--- a/sound/soc/sof/amd/Makefile
+++ b/sound/soc/sof/amd/Makefile
@@ -6,6 +6,8 @@
 
 snd-sof-amd-acp-objs := acp.o acp-loader.o acp-ipc.o acp-pcm.o acp-stream.o acp-trace.o acp-common.o
 snd-sof-amd-renoir-objs := pci-rn.o renoir.o
+snd-sof-amd-rembrandt-objs := pci-rmb.o rembrandt.o
 
 obj-$(CONFIG_SND_SOC_SOF_AMD_COMMON) += snd-sof-amd-acp.o
 obj-$(CONFIG_SND_SOC_SOF_AMD_RENOIR) +=snd-sof-amd-renoir.o
+obj-$(CONFIG_SND_SOC_SOF_AMD_REMBRANDT) +=snd-sof-amd-rembrandt.o
diff --git a/sound/soc/sof/amd/acp-dsp-offset.h b/sound/soc/sof/amd/acp-dsp-offset.h
index 47151a84f90b..de5726251dc6 100644
--- a/sound/soc/sof/amd/acp-dsp-offset.h
+++ b/sound/soc/sof/amd/acp-dsp-offset.h
@@ -49,22 +49,28 @@
 #define ACP_CONTROL				0x1004
 
 #define ACP3X_I2S_PIN_CONFIG			0x1400
+#define ACP6X_I2S_PIN_CONFIG			0x1440
 
 /* Registers offsets from ACP_PGFSM block */
 #define ACP3X_PGFSM_BASE			0x141C
+#define ACP6X_PGFSM_BASE                        0x1024
 #define PGFSM_CONTROL_OFFSET			0x0
 #define PGFSM_STATUS_OFFSET			0x4
 #define ACP3X_CLKMUX_SEL			0x1424
+#define ACP6X_CLKMUX_SEL			0x102C
 
 /* Registers from ACP_INTR block */
 #define ACP3X_EXT_INTR_STAT			0x1808
+#define ACP6X_EXT_INTR_STAT                     0x1A0C
 
 #define ACP3X_DSP_SW_INTR_BASE			0x1814
+#define ACP6X_DSP_SW_INTR_BASE                  0x1808
 #define DSP_SW_INTR_CNTL_OFFSET			0x0
 #define DSP_SW_INTR_STAT_OFFSET			0x4
 #define DSP_SW_INTR_TRIG_OFFSET			0x8
 #define ACP_ERROR_STATUS			0x18C4
 #define ACP3X_AXI2DAGB_SEM_0			0x1880
+#define ACP6X_AXI2DAGB_SEM_0			0x1874
 
 /* Registers from ACP_SHA block */
 #define ACP_SHA_DSP_FW_QUALIFIER		0x1C70
@@ -78,5 +84,5 @@
 #define ACP_SHA_PSP_ACK                         0x1C74
 
 #define ACP_SCRATCH_REG_0			0x10000
-
+#define ACP6X_DSP_FUSION_RUNSTALL		0x0644
 #endif
diff --git a/sound/soc/sof/amd/acp-loader.c b/sound/soc/sof/amd/acp-loader.c
index f372f93094f3..d1e74baf5d8b 100644
--- a/sound/soc/sof/amd/acp-loader.c
+++ b/sound/soc/sof/amd/acp-loader.c
@@ -198,12 +198,19 @@ EXPORT_SYMBOL_NS(acp_dsp_pre_fw_run, SND_SOC_SOF_AMD_COMMON);
 
 int acp_sof_dsp_run(struct snd_sof_dev *sdev)
 {
+	const struct sof_amd_acp_desc *desc = get_chip_info(sdev->pdata);
 	int val;
 
 	snd_sof_dsp_write(sdev, ACP_DSP_BAR, ACP_DSP0_RUNSTALL, ACP_DSP_RUN);
 	val = snd_sof_dsp_read(sdev, ACP_DSP_BAR, ACP_DSP0_RUNSTALL);
 	dev_dbg(sdev->dev, "ACP_DSP0_RUNSTALL : 0x%0x\n", val);
 
+	/* Some platforms won't support fusion DSP,keep offset zero for no support */
+	if (desc->fusion_dsp_offset) {
+		snd_sof_dsp_write(sdev, ACP_DSP_BAR, desc->fusion_dsp_offset, ACP_DSP_RUN);
+		val = snd_sof_dsp_read(sdev, ACP_DSP_BAR, desc->fusion_dsp_offset);
+		dev_dbg(sdev->dev, "ACP_DSP0_FUSION_RUNSTALL : 0x%0x\n", val);
+	}
 	return 0;
 }
 EXPORT_SYMBOL_NS(acp_sof_dsp_run, SND_SOC_SOF_AMD_COMMON);
diff --git a/sound/soc/sof/amd/acp.h b/sound/soc/sof/amd/acp.h
index bc024be76e09..e59a8655d859 100644
--- a/sound/soc/sof/amd/acp.h
+++ b/sound/soc/sof/amd/acp.h
@@ -31,6 +31,7 @@
 
 #define ACP_DSP_INTR_EN_MASK			0x00000001
 #define ACP3X_SRAM_PTE_OFFSET			0x02050000
+#define ACP6X_SRAM_PTE_OFFSET			0x03800000
 #define PAGE_SIZE_4K_ENABLE			0x2
 #define ACP_PAGE_SIZE				0x1000
 #define ACP_DMA_CH_RUN				0x02
@@ -54,6 +55,7 @@
 #define ACP_DSP_TO_HOST_IRQ			0x04
 
 #define HOST_BRIDGE_CZN				0x1630
+#define HOST_BRIDGE_RMB				0x14B5
 #define ACP_SHA_STAT				0x8000
 #define ACP_PSP_TIMEOUT_COUNTER			5
 #define ACP_EXT_INTR_ERROR_STAT			0x20000000
@@ -150,6 +152,7 @@ struct sof_amd_acp_desc {
 	u32 i2s_pin_config_offset;
 	u32 hw_semaphore_offset;
 	u32 acp_clkmux_sel;
+	u32 fusion_dsp_offset;
 };
 
 /* Common device data struct for ACP devices */
@@ -223,6 +226,8 @@ extern struct snd_sof_dsp_ops sof_acp_common_ops;
 
 extern struct snd_sof_dsp_ops sof_renoir_ops;
 int sof_renoir_ops_init(struct snd_sof_dev *sdev);
+extern struct snd_sof_dsp_ops sof_rembrandt_ops;
+int sof_rembrandt_ops_init(struct snd_sof_dev *sdev);
 
 int acp_dai_probe(struct snd_soc_dai *dai);
 struct snd_soc_acpi_mach *amd_sof_machine_select(struct snd_sof_dev *sdev);
diff --git a/sound/soc/sof/amd/pci-rmb.c b/sound/soc/sof/amd/pci-rmb.c
new file mode 100644
index 000000000000..4e1de462b431
--- /dev/null
+++ b/sound/soc/sof/amd/pci-rmb.c
@@ -0,0 +1,186 @@
+// SPDX-License-Identifier: (GPL-2.0-only OR BSD-3-Clause)
+//
+// This file is provided under a dual BSD/GPLv2 license. When using or
+// redistributing this file, you may do so under either license.
+//
+// Copyright(c) 2022 Advanced Micro Devices, Inc. All rights reserved.
+//
+// Authors: Ajit Kumar Pandey <AjitKumar.Pandey@amd.com>
+
+/*.
+ * PCI interface for Rembrandt ACP device
+ */
+
+#include <linux/module.h>
+#include <linux/pci.h>
+#include <linux/platform_device.h>
+#include <sound/sof.h>
+#include <sound/soc-acpi.h>
+
+#include "../ops.h"
+#include "../sof-pci-dev.h"
+#include "../../amd/mach-config.h"
+#include "acp.h"
+#include "acp-dsp-offset.h"
+
+#define ACP6x_REG_START		0x1240000
+#define ACP6x_REG_END		0x125C000
+
+static struct platform_device *dmic_dev;
+static struct platform_device *pdev;
+
+static const struct resource rembrandt_res[] = {
+	{
+		.start = 0,
+		.end = ACP6x_REG_END - ACP6x_REG_START,
+		.name = "acp_mem",
+		.flags = IORESOURCE_MEM,
+	},
+	{
+		.start = 0,
+		.end = 0,
+		.name = "acp_dai_irq",
+		.flags = IORESOURCE_IRQ,
+	},
+};
+
+static const struct sof_amd_acp_desc rembrandt_chip_info = {
+	.rev		= 6,
+	.host_bridge_id = HOST_BRIDGE_RMB,
+	.i2s_mode	= 0x0a,
+	.pgfsm_base	= ACP6X_PGFSM_BASE,
+	.ext_intr_stat	= ACP6X_EXT_INTR_STAT,
+	.dsp_intr_base	= ACP6X_DSP_SW_INTR_BASE,
+	.sram_pte_offset = ACP6X_SRAM_PTE_OFFSET,
+	.i2s_pin_config_offset = ACP6X_I2S_PIN_CONFIG,
+	.hw_semaphore_offset = ACP6X_AXI2DAGB_SEM_0,
+	.acp_clkmux_sel = ACP6X_CLKMUX_SEL,
+	.fusion_dsp_offset = ACP6X_DSP_FUSION_RUNSTALL,
+};
+
+static const struct sof_dev_desc rembrandt_desc = {
+	.machines		= snd_soc_acpi_amd_rmb_sof_machines,
+	.resindex_lpe_base	= 0,
+	.resindex_pcicfg_base	= -1,
+	.resindex_imr_base	= -1,
+	.irqindex_host_ipc	= -1,
+	.chip_info		= &rembrandt_chip_info,
+	.ipc_supported_mask     = BIT(SOF_IPC),
+	.ipc_default            = SOF_IPC,
+	.default_fw_path	= {
+		[SOF_IPC] = "amd/sof",
+	},
+	.default_tplg_path	= {
+		[SOF_IPC] = "amd/sof-tplg",
+	},
+	.default_fw_filename	= {
+		[SOF_IPC] = "sof-rmb.ri",
+	},
+	.nocodec_tplg_filename	= "sof-acp.tplg",
+	.ops			= &sof_rembrandt_ops,
+	.ops_init		= sof_rembrandt_ops_init,
+};
+
+static int acp_pci_rmb_probe(struct pci_dev *pci, const struct pci_device_id *pci_id)
+{
+	struct platform_device_info pdevinfo;
+	struct device *dev = &pci->dev;
+	const struct resource *res_i2s;
+	struct resource *res;
+	unsigned int flag, i, addr;
+	int ret;
+
+	flag = snd_amd_acp_find_config(pci);
+	if (flag != FLAG_AMD_SOF && flag != FLAG_AMD_SOF_ONLY_DMIC)
+		return -ENODEV;
+
+	ret = sof_pci_probe(pci, pci_id);
+	if (ret != 0)
+		return ret;
+
+	dmic_dev = platform_device_register_data(dev, "dmic-codec", PLATFORM_DEVID_NONE, NULL, 0);
+	if (IS_ERR(dmic_dev)) {
+		dev_err(dev, "failed to create DMIC device\n");
+		sof_pci_remove(pci);
+		return PTR_ERR(dmic_dev);
+	}
+
+	/* Register platform device only if flag set to FLAG_AMD_SOF_ONLY_DMIC */
+	if (flag != FLAG_AMD_SOF_ONLY_DMIC)
+		return 0;
+
+	addr = pci_resource_start(pci, 0);
+	res = devm_kzalloc(&pci->dev, sizeof(struct resource) * ARRAY_SIZE(rembrandt_res),
+			   GFP_KERNEL);
+	if (!res) {
+		platform_device_unregister(dmic_dev);
+		sof_pci_remove(pci);
+		return -ENOMEM;
+	}
+
+	res_i2s = rembrandt_res;
+	for (i = 0; i < ARRAY_SIZE(rembrandt_res); i++, res_i2s++) {
+		res[i].name = res_i2s->name;
+		res[i].flags = res_i2s->flags;
+		res[i].start = addr + res_i2s->start;
+		res[i].end = addr + res_i2s->end;
+		if (res_i2s->flags == IORESOURCE_IRQ) {
+			res[i].start = pci->irq;
+			res[i].end = res[i].start;
+		}
+	}
+
+	memset(&pdevinfo, 0, sizeof(pdevinfo));
+
+	/*
+	 * We have common PCI driver probe for ACP device but we have to support I2S without SOF
+	 * for some distributions. Register platform device that will be used to support non dsp
+	 * ACP's audio ends points on some machines.
+	 */
+	pdevinfo.name = "acp_asoc_rembrandt";
+	pdevinfo.id = 0;
+	pdevinfo.parent = &pci->dev;
+	pdevinfo.num_res = ARRAY_SIZE(rembrandt_res);
+	pdevinfo.res = &res[0];
+
+	pdev = platform_device_register_full(&pdevinfo);
+	if (IS_ERR(pdev)) {
+		dev_err(&pci->dev, "cannot register %s device\n", pdevinfo.name);
+		platform_device_unregister(dmic_dev);
+		sof_pci_remove(pci);
+		ret = PTR_ERR(pdev);
+	}
+
+	return ret;
+};
+
+static void acp_pci_rmb_remove(struct pci_dev *pci)
+{
+	if (dmic_dev)
+		platform_device_unregister(dmic_dev);
+	if (pdev)
+		platform_device_unregister(pdev);
+
+	sof_pci_remove(pci);
+}
+
+/* PCI IDs */
+static const struct pci_device_id rmb_pci_ids[] = {
+		{ PCI_DEVICE(PCI_VENDOR_ID_AMD, ACP_PCI_DEV_ID),
+		.driver_data = (unsigned long)&rembrandt_desc},
+		{ 0, }
+};
+MODULE_DEVICE_TABLE(pci, rmb_pci_ids);
+
+/* pci_driver definition */
+static struct pci_driver snd_sof_pci_amd_rmb_driver = {
+	.name = KBUILD_MODNAME,
+	.id_table = rmb_pci_ids,
+	.probe = acp_pci_rmb_probe,
+	.remove = acp_pci_rmb_remove,
+};
+module_pci_driver(snd_sof_pci_amd_rmb_driver);
+
+MODULE_LICENSE("Dual BSD/GPL");
+MODULE_IMPORT_NS(SND_SOC_SOF_AMD_COMMON);
+MODULE_IMPORT_NS(SND_SOC_SOF_PCI_DEV);
diff --git a/sound/soc/sof/amd/rembrandt.c b/sound/soc/sof/amd/rembrandt.c
new file mode 100644
index 000000000000..dcb64a23e121
--- /dev/null
+++ b/sound/soc/sof/amd/rembrandt.c
@@ -0,0 +1,134 @@
+// SPDX-License-Identifier: (GPL-2.0-only OR BSD-3-Clause)
+//
+// This file is provided under a dual BSD/GPLv2 license. When using or
+// redistributing this file, you may do so under either license.
+//
+// Copyright(c) 2022 Advanced Micro Devices, Inc.
+//
+// Authors: Ajit Kumar Pandey <AjitKumar.Pandey@amd.com>
+
+/*
+ * Hardware interface for Audio DSP on Rembrandt platform
+ */
+
+#include <linux/platform_device.h>
+#include <linux/module.h>
+
+#include "../ops.h"
+#include "../sof-audio.h"
+#include "acp.h"
+#include "acp-dsp-offset.h"
+
+#define I2S_HS_INSTANCE		0
+#define I2S_BT_INSTANCE		1
+#define I2S_SP_INSTANCE		2
+#define PDM_DMIC_INSTANCE	3
+
+static struct snd_soc_dai_driver rembrandt_sof_dai[] = {
+	[I2S_HS_INSTANCE] = {
+		.id = I2S_HS_INSTANCE,
+		.name = "acp-sof-hs",
+		.playback = {
+			.rates = SNDRV_PCM_RATE_8000_96000,
+			.formats = SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S8 |
+				   SNDRV_PCM_FMTBIT_U8 | SNDRV_PCM_FMTBIT_S32_LE,
+			.channels_min = 2,
+			.channels_max = 8,
+			.rate_min = 8000,
+			.rate_max = 96000,
+		},
+		.capture = {
+			.rates = SNDRV_PCM_RATE_8000_48000,
+			.formats = SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S8 |
+				   SNDRV_PCM_FMTBIT_U8 | SNDRV_PCM_FMTBIT_S32_LE,
+			/* Supporting only stereo for I2S HS controller capture */
+			.channels_min = 2,
+			.channels_max = 2,
+			.rate_min = 8000,
+			.rate_max = 48000,
+		},
+		.probe = &acp_dai_probe,
+	},
+
+	[I2S_BT_INSTANCE] = {
+		.id = I2S_BT_INSTANCE,
+		.name = "acp-sof-bt",
+		.playback = {
+			.rates = SNDRV_PCM_RATE_8000_96000,
+			.formats = SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S8 |
+				   SNDRV_PCM_FMTBIT_U8 | SNDRV_PCM_FMTBIT_S32_LE,
+			.channels_min = 2,
+			.channels_max = 8,
+			.rate_min = 8000,
+			.rate_max = 96000,
+		},
+		.capture = {
+			.rates = SNDRV_PCM_RATE_8000_48000,
+			.formats = SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S8 |
+				   SNDRV_PCM_FMTBIT_U8 | SNDRV_PCM_FMTBIT_S32_LE,
+			/* Supporting only stereo for I2S BT controller capture */
+			.channels_min = 2,
+			.channels_max = 2,
+			.rate_min = 8000,
+			.rate_max = 48000,
+		},
+		.probe = &acp_dai_probe,
+	},
+
+	[I2S_SP_INSTANCE] = {
+		.id = I2S_SP_INSTANCE,
+		.name = "acp-sof-sp",
+		.playback = {
+			.rates = SNDRV_PCM_RATE_8000_96000,
+			.formats = SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S8 |
+				   SNDRV_PCM_FMTBIT_U8 | SNDRV_PCM_FMTBIT_S32_LE,
+			.channels_min = 2,
+			.channels_max = 8,
+			.rate_min = 8000,
+			.rate_max = 96000,
+		},
+		.capture = {
+			.rates = SNDRV_PCM_RATE_8000_48000,
+			.formats = SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S8 |
+				   SNDRV_PCM_FMTBIT_U8 | SNDRV_PCM_FMTBIT_S32_LE,
+			/* Supporting only stereo for I2S SP controller capture */
+			.channels_min = 2,
+			.channels_max = 2,
+			.rate_min = 8000,
+			.rate_max = 48000,
+		},
+		.probe = &acp_dai_probe,
+	},
+
+	[PDM_DMIC_INSTANCE] = {
+		.id = PDM_DMIC_INSTANCE,
+		.name = "acp-sof-dmic",
+		.capture = {
+			.rates = SNDRV_PCM_RATE_8000_48000,
+			.formats = SNDRV_PCM_FMTBIT_S32_LE,
+			.channels_min = 2,
+			.channels_max = 4,
+			.rate_min = 8000,
+			.rate_max = 48000,
+		},
+	},
+};
+
+/* Rembrandt ops */
+struct snd_sof_dsp_ops sof_rembrandt_ops;
+EXPORT_SYMBOL_NS(sof_rembrandt_ops, SND_SOC_SOF_AMD_COMMON);
+
+int sof_rembrandt_ops_init(struct snd_sof_dev *sdev)
+{
+	/* common defaults */
+	memcpy(&sof_rembrandt_ops, &sof_acp_common_ops, sizeof(struct snd_sof_dsp_ops));
+
+	sof_rembrandt_ops.drv = rembrandt_sof_dai;
+	sof_rembrandt_ops.num_drv = ARRAY_SIZE(rembrandt_sof_dai);
+
+	return 0;
+}
+
+MODULE_IMPORT_NS(SND_SOC_SOF_AMD_COMMON);
+MODULE_DESCRIPTION("REMBRANDT SOF Driver");
+MODULE_LICENSE("Dual BSD/GPL");
-- 
2.25.1

