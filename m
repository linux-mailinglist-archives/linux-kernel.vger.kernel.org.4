Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46E8773A4BB
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 17:24:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232330AbjFVPYz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 11:24:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232388AbjFVPYt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 11:24:49 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2040.outbound.protection.outlook.com [40.107.93.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECEFEE75
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 08:24:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QhRd8AK5DysTdA/gMZIVZpOE0B787K6azNewMNEJzvXdsHyCpbekoLYPqCXmO+Juy67ZII0XxK14hyULVqII/kw4cYHWi4ntpfvn0KJWHIddc6qbjOD7f9stXjuRIBTsTR0L/fVEOmeszXZT9NsyiRqSifJY+r10Q1bRt4u7lCPEeu2A9t21+ZsrvGw4hJx2Dwl42olvw+KzudhwYhC0MKAuzJGEeFijVVm+ReRd7sZPtnrztvZ6g4RmI9nsLybjQkie6cLzOm1ByUJYir4Zfo4W8vGIybKoTCJtZmZ/60ZXDMaIAwKEtkhTcucMzLGRUOm2jUkaW/VDBaEQM03MoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gycwDhAyFF+K1xbN3kqPBoobKHCJK/+BUp0Tu2LksTU=;
 b=Yv8BxllOBy+/M2UGrWmD/dOzH9INsov0ufOob14UXjjoSnxFz6V/tGvcc40+T1Rx02GtUTYOc1OL/294GlLYEaLxzcDAep2uQu5IGT0Yc0kDoQxSWvpEmYUIL34JSFkZ/bjpe/nnGv50gsSNiopUME5Hclsrt15L31oqjJs1TA7D4+0513O+9KgJ6IrCQ9+EMRABbwP7Z8uBCw/4wjKFvHpkm+aTkZOq3+kqdjA6lHW5ZXe3WUit3HuW5dWa8iJOrOlMxs9BU117WCG4o4jL6IgVTv0NRQo3nvcmMwNur3go94L7atzsDiiwHQtGUjO4H3k9kXJykzAV0xLPSfvIAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gycwDhAyFF+K1xbN3kqPBoobKHCJK/+BUp0Tu2LksTU=;
 b=kTgoSKG26E2TDBH1EqNBtwdGdoE4L7cP09JpN3SLYVI9pVqWFL+asZCmrUK00T7AjSurITUbtRHJXqBod1hr0Gsh/pE4gAOiZT5eJvY0K9fOKsz6E6XZCBgukcQ2z4VQKOY2Ejwib+reEQQdk2hwRBE7Fy4f2FHrNXxDkwqz908=
Received: from MW4PR03CA0020.namprd03.prod.outlook.com (2603:10b6:303:8f::25)
 by IA1PR12MB6089.namprd12.prod.outlook.com (2603:10b6:208:3ef::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23; Thu, 22 Jun
 2023 15:24:44 +0000
Received: from CO1PEPF000042AA.namprd03.prod.outlook.com
 (2603:10b6:303:8f:cafe::78) by MW4PR03CA0020.outlook.office365.com
 (2603:10b6:303:8f::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24 via Frontend
 Transport; Thu, 22 Jun 2023 15:24:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000042AA.mail.protection.outlook.com (10.167.243.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6521.17 via Frontend Transport; Thu, 22 Jun 2023 15:24:43 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Thu, 22 Jun
 2023 10:24:43 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Thu, 22 Jun
 2023 08:24:42 -0700
Received: from amd-B450M-DS3H.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.23 via Frontend
 Transport; Thu, 22 Jun 2023 10:24:38 -0500
From:   Syed Saba Kareem <Syed.SabaKareem@amd.com>
To:     <broonie@kernel.org>, <alsa-devel@alsa-project.org>
CC:     <Vijendar.Mukunda@amd.com>, <Basavaraj.Hiregoudar@amd.com>,
        <Sunil-kumar.Dommati@amd.com>,
        Syed Saba Kareem <Syed.SabaKareem@amd.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        V sujith kumar Reddy <Vsujithkumar.Reddy@amd.com>,
        Yang Yingliang <yangyingliang@huawei.com>,
        Venkata Prasad Potturu <venkataprasad.potturu@amd.com>,
        ye xingchen <ye.xingchen@zte.com.cn>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Ajit Kumar Pandey <AjitKumar.Pandey@amd.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH 02/11] ASoC: amd: acp: refactor the acp init and de-init sequence
Date:   Thu, 22 Jun 2023 20:53:40 +0530
Message-ID: <20230622152406.3709231-3-Syed.SabaKareem@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230622152406.3709231-1-Syed.SabaKareem@amd.com>
References: <20230622152406.3709231-1-Syed.SabaKareem@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AA:EE_|IA1PR12MB6089:EE_
X-MS-Office365-Filtering-Correlation-Id: 91332e55-c33d-4ede-2952-08db7334ce3d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wmTNq3T3shNl5itN5lJx2YmcueQmomwQ47W+OeyoQxMQiRxRV+ljtwamOhDVywhe6Z3HYjedoHQBv/eijk8M7dnA75TSUGOOy7bTT5KVkHBPoZY1B3zDlmVcXhS672gh1M5vk+L8ZgJJDRifltaUAEUarXL7l3O8DgU4pZkKMHRzTJU3T0AJJ3Bge/zbCAwCT5tlDScDTBolvrba2UaRi3TXAU8jmme8hyNXPsa8dKK2Qu/Z94GTL5NWQV+urqu9mtib+CQijj2wslLibB7wUSlREYXWHhTm5SycDAGDhoO5NDcOEhNvd+366NHCRezYPv7WHAywbQjXzR2fL+PjmdCKX7Kh67arM3uD9y1ZYGgEIE2RTj7KxZnns1/9ohKUcGriK0Y+WFhZU9e5et0IsH/GdXVCH0q0xyeq6rVJ+gq5Q8hL11bPZVjx7pln+tbp+oZvjFZgV3AyDVl3y0mH+gDt/KJKhnRuuoyd7OjVHEt6RXO6xubTR+oUSYwvHuTdS3m2sud8HztDEHfYXO0LHbIoKCuwifV6vha2U2vvbkiIzVGgDJEzo8gcsv2MpV4v2B1q7FZUtiVHI2yIIySJwhQM5EVuJN5yaj5SywcabISXHWANUQU7ld0hLxyA8h/n9AuExRnq4WPXXVerjXwI3j3tH1Y7ihiqV5xBUTk/m7m2D1QPi3ikGyx3izxRiTPgMLDD3A9Oed17Nri8IIXSNjpliCCKy+lWJyK/V215LbqRPkM2wBLXgf0nCh3/tiR4+LJNHwJVL8voNL6g0v1XjQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(136003)(396003)(39860400002)(451199021)(40470700004)(46966006)(36840700001)(478600001)(110136005)(6666004)(54906003)(4326008)(47076005)(40480700001)(83380400001)(426003)(2616005)(336012)(86362001)(36756003)(36860700001)(40460700003)(30864003)(70586007)(2906002)(82310400005)(1076003)(186003)(7696005)(26005)(81166007)(356005)(82740400003)(70206006)(316002)(41300700001)(8676002)(8936002)(5660300002)(7416002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2023 15:24:43.6946
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 91332e55-c33d-4ede-2952-08db7334ce3d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000042AA.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6089
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the individual acp init and de-init functions from different
variants of acp pci driver(for renoir/rembrandt platforms) and use a
common file to define callbacks and refactor the callbacks to support
existing platforms.

Signed-off-by: Syed Saba Kareem <Syed.SabaKareem@amd.com>
---
 sound/soc/amd/acp/Kconfig             |   4 +
 sound/soc/amd/acp/Makefile            |   2 +
 sound/soc/amd/acp/acp-legacy-common.c |  99 +++++++++++++++++++++++
 sound/soc/amd/acp/acp-pci.c           |   9 +++
 sound/soc/amd/acp/acp-rembrandt.c     | 110 --------------------------
 sound/soc/amd/acp/acp-renoir.c        |  92 ---------------------
 sound/soc/amd/acp/amd.h               |  21 +++++
 7 files changed, 135 insertions(+), 202 deletions(-)
 create mode 100644 sound/soc/amd/acp/acp-legacy-common.c

diff --git a/sound/soc/amd/acp/Kconfig b/sound/soc/amd/acp/Kconfig
index ce0037810743..6a369e5d825c 100644
--- a/sound/soc/amd/acp/Kconfig
+++ b/sound/soc/amd/acp/Kconfig
@@ -18,6 +18,9 @@ if SND_SOC_AMD_ACP_COMMON
 config SND_SOC_AMD_ACP_PDM
 	tristate
 
+config SND_SOC_AMD_ACP_LEGACY_COMMON
+	tristate
+
 config SND_SOC_AMD_ACP_I2S
 	tristate
 
@@ -28,6 +31,7 @@ config SND_SOC_AMD_ACP_PCM
 config SND_SOC_AMD_ACP_PCI
 	tristate "AMD ACP PCI Driver Support"
 	depends on X86 && PCI
+	select SND_SOC_AMD_ACP_LEGACY_COMMON
 	help
 	  This options enables generic PCI driver for ACP device.
 
diff --git a/sound/soc/amd/acp/Makefile b/sound/soc/amd/acp/Makefile
index d9abb0ee5218..4e65fdbc8dca 100644
--- a/sound/soc/amd/acp/Makefile
+++ b/sound/soc/amd/acp/Makefile
@@ -8,6 +8,7 @@
 snd-acp-pcm-objs     := acp-platform.o
 snd-acp-i2s-objs     := acp-i2s.o
 snd-acp-pdm-objs     := acp-pdm.o
+snd-acp-legacy-common-objs   := acp-legacy-common.o
 snd-acp-pci-objs     := acp-pci.o
 
 #platform specific driver
@@ -22,6 +23,7 @@ snd-acp-sof-mach-objs     := acp-sof-mach.o
 obj-$(CONFIG_SND_SOC_AMD_ACP_PCM) += snd-acp-pcm.o
 obj-$(CONFIG_SND_SOC_AMD_ACP_I2S) += snd-acp-i2s.o
 obj-$(CONFIG_SND_SOC_AMD_ACP_PDM) += snd-acp-pdm.o
+obj-$(CONFIG_SND_SOC_AMD_ACP_LEGACY_COMMON) += snd-acp-legacy-common.o
 obj-$(CONFIG_SND_SOC_AMD_ACP_PCI) += snd-acp-pci.o
 
 obj-$(CONFIG_SND_AMD_ASOC_RENOIR) += snd-acp-renoir.o
diff --git a/sound/soc/amd/acp/acp-legacy-common.c b/sound/soc/amd/acp/acp-legacy-common.c
new file mode 100644
index 000000000000..5b7000eae693
--- /dev/null
+++ b/sound/soc/amd/acp/acp-legacy-common.c
@@ -0,0 +1,99 @@
+// SPDX-License-Identifier: (GPL-2.0-only OR BSD-3-Clause)
+//
+// This file is provided under a dual BSD/GPLv2 license. When using or
+// redistributing this file, you may do so under either license.
+//
+// Copyright(c) 2023 Advanced Micro Devices, Inc.
+//
+// Authors: Syed Saba Kareem <Syed.SabaKareem@amd.com>
+//
+
+/*
+ * Common file to be used by amd platforms
+ */
+
+#include "amd.h"
+#include <linux/export.h>
+
+static int acp_power_on(struct acp_chip_info *chip)
+{
+	u32 val, acp_pgfsm_stat_reg, acp_pgfsm_ctrl_reg;
+	void __iomem *base;
+
+	base = chip->base;
+	switch (chip->acp_rev) {
+	case ACP3X_DEV:
+		acp_pgfsm_stat_reg = ACP_PGFSM_STATUS;
+		acp_pgfsm_ctrl_reg = ACP_PGFSM_CONTROL;
+		break;
+	case ACP6X_DEV:
+		acp_pgfsm_stat_reg = ACP6X_PGFSM_STATUS;
+		acp_pgfsm_ctrl_reg = ACP6X_PGFSM_CONTROL;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	val = readl(base + acp_pgfsm_stat_reg);
+	if (val == ACP_POWERED_ON)
+		return 0;
+
+	if ((val & ACP_PGFSM_STATUS_MASK) != ACP_POWER_ON_IN_PROGRESS)
+		writel(ACP_PGFSM_CNTL_POWER_ON_MASK, base + acp_pgfsm_ctrl_reg);
+
+	return readl_poll_timeout(base + acp_pgfsm_stat_reg, val,
+				  !val, DELAY_US, ACP_TIMEOUT);
+}
+
+static int acp_reset(void __iomem *base)
+{
+	u32 val;
+	int ret;
+
+	writel(1, base + ACP_SOFT_RESET);
+	ret = readl_poll_timeout(base + ACP_SOFT_RESET, val, val & ACP_SOFT_RST_DONE_MASK,
+				 DELAY_US, ACP_TIMEOUT);
+	if (ret)
+		return ret;
+
+	writel(0, base + ACP_SOFT_RESET);
+	return readl_poll_timeout(base + ACP_SOFT_RESET, val, !val, DELAY_US, ACP_TIMEOUT);
+}
+
+int acp_init(struct acp_chip_info *chip)
+{
+	int ret;
+
+	/* power on */
+	ret = acp_power_on(chip);
+	if (ret) {
+		pr_err("ACP power on failed\n");
+		return ret;
+	}
+	writel(0x01, chip->base + ACP_CONTROL);
+
+	/* Reset */
+	ret = acp_reset(chip->base);
+	if (ret) {
+		pr_err("ACP reset failed\n");
+		return ret;
+	}
+	return 0;
+}
+EXPORT_SYMBOL_NS_GPL(acp_init, SND_SOC_ACP_COMMON);
+
+int acp_deinit(void __iomem *base)
+{
+	int ret;
+
+	/* Reset */
+	ret = acp_reset(base);
+	if (ret)
+		return ret;
+
+	writel(0, base + ACP_CONTROL);
+	return 0;
+}
+EXPORT_SYMBOL_NS_GPL(acp_deinit, SND_SOC_ACP_COMMON);
+
+MODULE_LICENSE("Dual BSD/GPL");
diff --git a/sound/soc/amd/acp/acp-pci.c b/sound/soc/amd/acp/acp-pci.c
index a0c84cd07fde..d3b2ccbe7fd8 100644
--- a/sound/soc/amd/acp/acp-pci.c
+++ b/sound/soc/amd/acp/acp-pci.c
@@ -107,6 +107,7 @@ static int acp_pci_probe(struct pci_dev *pci, const struct pci_device_id *pci_id
 		goto unregister_dmic_dev;
 	}
 
+	acp_init(chip);
 	res = devm_kcalloc(&pci->dev, num_res, sizeof(struct resource), GFP_KERNEL);
 	if (!res) {
 		ret = -ENOMEM;
@@ -155,10 +156,17 @@ static int acp_pci_probe(struct pci_dev *pci, const struct pci_device_id *pci_id
 
 static void acp_pci_remove(struct pci_dev *pci)
 {
+	struct acp_chip_info *chip;
+	int ret;
+
+	chip = pci_get_drvdata(pci);
 	if (dmic_dev)
 		platform_device_unregister(dmic_dev);
 	if (pdev)
 		platform_device_unregister(pdev);
+	ret = acp_deinit(chip->base);
+	if (ret)
+		dev_err(&pci->dev, "ACP de-init failed\n");
 }
 
 /* PCI IDs */
@@ -178,4 +186,5 @@ static struct pci_driver snd_amd_acp_pci_driver = {
 module_pci_driver(snd_amd_acp_pci_driver);
 
 MODULE_LICENSE("Dual BSD/GPL");
+MODULE_IMPORT_NS(SND_SOC_ACP_COMMON);
 MODULE_ALIAS(DRV_NAME);
diff --git a/sound/soc/amd/acp/acp-rembrandt.c b/sound/soc/amd/acp/acp-rembrandt.c
index 1b997837c7d8..59b1653b8479 100644
--- a/sound/soc/amd/acp/acp-rembrandt.c
+++ b/sound/soc/amd/acp/acp-rembrandt.c
@@ -24,26 +24,6 @@
 
 #define DRV_NAME "acp_asoc_rembrandt"
 
-#define ACP6X_PGFSM_CONTROL			0x1024
-#define ACP6X_PGFSM_STATUS			0x1028
-
-#define ACP_SOFT_RESET_SOFTRESET_AUDDONE_MASK	0x00010001
-
-#define ACP_PGFSM_CNTL_POWER_ON_MASK		0x01
-#define ACP_PGFSM_CNTL_POWER_OFF_MASK		0x00
-#define ACP_PGFSM_STATUS_MASK			0x03
-#define ACP_POWERED_ON				0x00
-#define ACP_POWER_ON_IN_PROGRESS		0x01
-#define ACP_POWERED_OFF				0x02
-#define ACP_POWER_OFF_IN_PROGRESS		0x03
-
-#define ACP_ERROR_MASK				0x20000000
-#define ACP_EXT_INTR_STAT_CLEAR_MASK		0xFFFFFFFF
-
-
-static int rmb_acp_init(void __iomem *base);
-static int rmb_acp_deinit(void __iomem *base);
-
 static struct acp_resource rsrc = {
 	.offset = 0,
 	.no_of_ctrls = 2,
@@ -180,54 +160,6 @@ static struct snd_soc_dai_driver acp_rmb_dai[] = {
 },
 };
 
-static int acp6x_power_on(void __iomem *base)
-{
-	u32 val;
-	int timeout;
-
-	val = readl(base + ACP6X_PGFSM_STATUS);
-
-	if (val == ACP_POWERED_ON)
-		return 0;
-
-	if ((val & ACP_PGFSM_STATUS_MASK) !=
-				ACP_POWER_ON_IN_PROGRESS)
-		writel(ACP_PGFSM_CNTL_POWER_ON_MASK,
-		       base + ACP6X_PGFSM_CONTROL);
-	timeout = 0;
-	while (++timeout < 500) {
-		val = readl(base + ACP6X_PGFSM_STATUS);
-		if (!val)
-			return 0;
-		udelay(1);
-	}
-	return -ETIMEDOUT;
-}
-
-static int acp6x_reset(void __iomem *base)
-{
-	u32 val;
-	int timeout;
-
-	writel(1, base + ACP_SOFT_RESET);
-	timeout = 0;
-	while (++timeout < 500) {
-		val = readl(base + ACP_SOFT_RESET);
-		if (val & ACP_SOFT_RESET_SOFTRESET_AUDDONE_MASK)
-			break;
-		cpu_relax();
-	}
-	writel(0, base + ACP_SOFT_RESET);
-	timeout = 0;
-	while (++timeout < 500) {
-		val = readl(base + ACP_SOFT_RESET);
-		if (!val)
-			return 0;
-		cpu_relax();
-	}
-	return -ETIMEDOUT;
-}
-
 static void acp6x_enable_interrupts(struct acp_dev_data *adata)
 {
 	struct acp_resource *rsrc = adata->rsrc;
@@ -248,43 +180,6 @@ static void acp6x_disable_interrupts(struct acp_dev_data *adata)
 	writel(0x00, ACP_EXTERNAL_INTR_ENB(adata));
 }
 
-static int rmb_acp_init(void __iomem *base)
-{
-	int ret;
-
-	/* power on */
-	ret = acp6x_power_on(base);
-	if (ret) {
-		pr_err("ACP power on failed\n");
-		return ret;
-	}
-	writel(0x01, base + ACP_CONTROL);
-
-	/* Reset */
-	ret = acp6x_reset(base);
-	if (ret) {
-		pr_err("ACP reset failed\n");
-		return ret;
-	}
-
-	return 0;
-}
-
-static int rmb_acp_deinit(void __iomem *base)
-{
-	int ret = 0;
-
-	/* Reset */
-	ret = acp6x_reset(base);
-	if (ret) {
-		pr_err("ACP reset failed\n");
-		return ret;
-	}
-
-	writel(0x00, base + ACP_CONTROL);
-	return 0;
-}
-
 static int rembrandt_audio_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -303,8 +198,6 @@ static int rembrandt_audio_probe(struct platform_device *pdev)
 		return -ENODEV;
 	}
 
-	rmb_acp_init(chip->base);
-
 	adata = devm_kzalloc(dev, sizeof(struct acp_dev_data), GFP_KERNEL);
 	if (!adata)
 		return -ENOMEM;
@@ -345,9 +238,6 @@ static void rembrandt_audio_remove(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct acp_dev_data *adata = dev_get_drvdata(dev);
-	struct acp_chip_info *chip = dev_get_platdata(dev);
-
-	rmb_acp_deinit(chip->base);
 
 	acp6x_disable_interrupts(adata);
 	acp_platform_unregister(dev);
diff --git a/sound/soc/amd/acp/acp-renoir.c b/sound/soc/amd/acp/acp-renoir.c
index f188365fe214..a73fd70171c1 100644
--- a/sound/soc/amd/acp/acp-renoir.c
+++ b/sound/soc/amd/acp/acp-renoir.c
@@ -25,20 +25,6 @@
 
 #define DRV_NAME "acp_asoc_renoir"
 
-#define ACP_SOFT_RST_DONE_MASK	0x00010001
-
-#define ACP_PWR_ON_MASK		0x01
-#define ACP_PWR_OFF_MASK	0x00
-#define ACP_PGFSM_STAT_MASK	0x03
-#define ACP_POWERED_ON		0x00
-#define ACP_PWR_ON_IN_PROGRESS	0x01
-#define ACP_POWERED_OFF		0x02
-#define DELAY_US		5
-#define ACP_TIMEOUT		500
-
-#define ACP_ERROR_MASK 0x20000000
-#define ACP_EXT_INTR_STAT_CLEAR_MASK 0xFFFFFFFF
-
 static struct acp_resource rsrc = {
 	.offset = 20,
 	.no_of_ctrls = 1,
@@ -154,38 +140,6 @@ static struct snd_soc_dai_driver acp_renoir_dai[] = {
 },
 };
 
-static int acp3x_power_on(void __iomem *base)
-{
-	u32 val;
-
-	val = readl(base + ACP_PGFSM_STATUS);
-
-	if (val == ACP_POWERED_ON)
-		return 0;
-
-	if ((val & ACP_PGFSM_STAT_MASK) != ACP_PWR_ON_IN_PROGRESS)
-		writel(ACP_PWR_ON_MASK, base + ACP_PGFSM_CONTROL);
-
-	return readl_poll_timeout(base + ACP_PGFSM_STATUS, val, !val, DELAY_US, ACP_TIMEOUT);
-}
-
-static int acp3x_reset(void __iomem *base)
-{
-	u32 val;
-	int ret;
-
-	writel(1, base + ACP_SOFT_RESET);
-
-	ret = readl_poll_timeout(base + ACP_SOFT_RESET, val, val & ACP_SOFT_RST_DONE_MASK,
-				 DELAY_US, ACP_TIMEOUT);
-	if (ret)
-		return ret;
-
-	writel(0, base + ACP_SOFT_RESET);
-
-	return readl_poll_timeout(base + ACP_SOFT_RESET, val, !val, DELAY_US, ACP_TIMEOUT);
-}
-
 static void acp3x_enable_interrupts(struct acp_dev_data *adata)
 {
 	struct acp_resource *rsrc = adata->rsrc;
@@ -206,37 +160,6 @@ static void acp3x_disable_interrupts(struct acp_dev_data *adata)
 	writel(0x00, ACP_EXTERNAL_INTR_ENB(adata));
 }
 
-static int rn_acp_init(void __iomem *base)
-{
-	int ret;
-
-	/* power on */
-	ret = acp3x_power_on(base);
-	if (ret)
-		return ret;
-
-	writel(0x01, base + ACP_CONTROL);
-
-	/* Reset */
-	ret = acp3x_reset(base);
-	if (ret)
-		return ret;
-
-	return 0;
-}
-
-static int rn_acp_deinit(void __iomem *base)
-{
-	int ret = 0;
-
-	/* Reset */
-	ret = acp3x_reset(base);
-	if (ret)
-		return ret;
-
-	writel(0x00, base + ACP_CONTROL);
-	return 0;
-}
 static int renoir_audio_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -256,12 +179,6 @@ static int renoir_audio_probe(struct platform_device *pdev)
 		return -ENODEV;
 	}
 
-	ret = rn_acp_init(chip->base);
-	if (ret) {
-		dev_err(&pdev->dev, "ACP Init failed\n");
-		return -EINVAL;
-	}
-
 	adata = devm_kzalloc(dev, sizeof(struct acp_dev_data), GFP_KERNEL);
 	if (!adata)
 		return -ENOMEM;
@@ -300,17 +217,8 @@ static void renoir_audio_remove(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct acp_dev_data *adata = dev_get_drvdata(dev);
-	struct acp_chip_info *chip;
-	int ret;
-
-	chip = dev_get_platdata(&pdev->dev);
 
 	acp3x_disable_interrupts(adata);
-
-	ret = rn_acp_deinit(chip->base);
-	if (ret)
-		dev_err(&pdev->dev, "ACP de-init Failed (%pe)\n", ERR_PTR(ret));
-
 	acp_platform_unregister(dev);
 }
 
diff --git a/sound/soc/amd/acp/amd.h b/sound/soc/amd/acp/amd.h
index 5f2119f42271..83c9a3ba8584 100644
--- a/sound/soc/amd/acp/amd.h
+++ b/sound/soc/amd/acp/amd.h
@@ -92,6 +92,25 @@
 #define SLOT_WIDTH_24	0x18
 #define SLOT_WIDTH_32	0x20
 
+#define ACP6X_PGFSM_CONTROL                     0x1024
+#define ACP6X_PGFSM_STATUS                      0x1028
+
+#define ACP_SOFT_RST_DONE_MASK	0x00010001
+
+#define ACP_PGFSM_CNTL_POWER_ON_MASK            0x01
+#define ACP_PGFSM_CNTL_POWER_OFF_MASK           0x00
+#define ACP_PGFSM_STATUS_MASK                   0x03
+#define ACP_POWERED_ON                          0x00
+#define ACP_POWER_ON_IN_PROGRESS                0x01
+#define ACP_POWERED_OFF                         0x02
+#define ACP_POWER_OFF_IN_PROGRESS               0x03
+
+#define ACP_ERROR_MASK                          0x20000000
+#define ACP_EXT_INTR_STAT_CLEAR_MASK            0xffffffff
+
+#define ACP_TIMEOUT		500
+#define DELAY_US		5
+
 struct acp_chip_info {
 	char *name;		/* Platform name */
 	unsigned int acp_rev;	/* ACP Revision id */
@@ -168,6 +187,8 @@ int acp_platform_unregister(struct device *dev);
 
 int acp_machine_select(struct acp_dev_data *adata);
 
+int acp_init(struct acp_chip_info *chip);
+int acp_deinit(void __iomem *base);
 /* Machine configuration */
 int snd_amd_acp_find_config(struct pci_dev *pci);
 
-- 
2.25.1

