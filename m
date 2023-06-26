Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB89873E131
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 15:56:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230169AbjFZN4D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 09:56:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229986AbjFZN4A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 09:56:00 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2069.outbound.protection.outlook.com [40.107.237.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16CC5DD
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 06:55:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CdUMZsg2ORrzlH+N5kdRo9rDNGQCu2vJgOPmbG5F0cF2rag6EmkMzU2chLu5TjbvFD7+M76rmqa44YKnRi+qpP591nAH/t7R6H6tVeVO2ON4kgp78L0ADwqSCTuExlN5TevYu9Lw3Lp289EvyB8A6l0ETEJ1pAvqSO69OVki4OXuQrek0LhSD01kRp5lVi9t4n/TzDT2rBP6+F2QDudVK9bBkDIigp6N8CJFzKoxhZ8Qgo1Ivjd+zqgVkfTNUaTnmtWDQhw8iSuspmyf5XatAdgrT+lc5kzqU7roIVwiaKsllnfEhiXslZxf4VDZ33S7o7/gG5Wjw5QS4NHp8DzmVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UbI9ILpD1hBLiPbajlJP+NSVqXaQBaSS6i31eqGeTZM=;
 b=IbpZ46wMezSaP6o+IXagR7GRY6+mNKZi1sY40vZdQLGy4wWgHcax+o4NjasGmnpbvRHuk8/lmQctWcteI0EufkVIjMtLwlLadofa8B7Z8yYPM6EdmWuiIB1LE+rc01kxahOIT+M5VvHyWXeO0CH09RyTOsSPRggzVwxGLZD3aqOfR6to1aRKhgTxq2bBmSYFAk30pxgsHlo3f5/DYXSKiNVgH1PGS31yEiFMw9LhsYTpn+Yy13IySSVWPpjNR4n4tSgq6QmdywXC3ZCX5RlJgS3ER7j5uoN9iN4m7M1ntJ4I8bVtQHNEtPlN4Q8scrlbT0Ac2V6+Vwu31DbuZLHOAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UbI9ILpD1hBLiPbajlJP+NSVqXaQBaSS6i31eqGeTZM=;
 b=mz7IsXc1cUOwq3Gpl4qGZdMo17jXZPHrvWeuSYwOkDwWT65YdI/Jnt4doWeY9FNdhkLs0geWvT4kMfMBP8/9gxGAvwlQb9ES18sIiNGRForvUqysm/5nkELAhuTqKSbfwiK1cZ/ycs35CI4SkhlEcEigbXKgXjpiCDyriM5e/tw=
Received: from BN9PR03CA0726.namprd03.prod.outlook.com (2603:10b6:408:110::11)
 by BL3PR12MB6595.namprd12.prod.outlook.com (2603:10b6:208:38e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.26; Mon, 26 Jun
 2023 13:55:53 +0000
Received: from BN8NAM11FT034.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:110:cafe::c5) by BN9PR03CA0726.outlook.office365.com
 (2603:10b6:408:110::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.33 via Frontend
 Transport; Mon, 26 Jun 2023 13:55:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT034.mail.protection.outlook.com (10.13.176.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6500.47 via Frontend Transport; Mon, 26 Jun 2023 13:55:53 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Mon, 26 Jun
 2023 08:55:53 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Mon, 26 Jun
 2023 06:55:52 -0700
Received: from amd-B450M-DS3H.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.23 via Frontend
 Transport; Mon, 26 Jun 2023 08:55:47 -0500
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
Subject: [PATCH v2 01/10] ASoC: amd: acp: refactor the acp init and de-init sequence
Date:   Mon, 26 Jun 2023 19:25:05 +0530
Message-ID: <20230626135515.1252063-2-Syed.SabaKareem@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230626135515.1252063-1-Syed.SabaKareem@amd.com>
References: <20230626135515.1252063-1-Syed.SabaKareem@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT034:EE_|BL3PR12MB6595:EE_
X-MS-Office365-Filtering-Correlation-Id: 4abdf23e-36f6-449d-2ae2-08db764d0eb2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vZZr7E908hnfIx/w/2c/k6CAn2m8Sdq0sFcjpJcz94waT752/MgJMIVeYaWfzgEfULb4N/P5iGwnCsz8Yld6GQvc9l8Jj1RWGmZmUoqstD7GWJfx8LoTgrAwjpgQfqh8cboyl0wSfGgCuD/oWL98gnXt/ODP4N9GhV39+EdD5Ntp5WwIXfs4L/41Z6Z6AUR67dvzy6mBDxu8Wpp7NUplnyVHdPmexfu4UHfD0pVyCIDmKyNMQtEXc6JcpO9LdHku/UKfLRa+PVvPNt1NOrquey3aeL21i0P5b1xYHcMI0V0YsA4qFHNbyXz9BnyjXo/EFAHa/gL2XmQ2bmJvD9p5WZVEJ9ERM8u4yDEoMlsBa75PGph1BWLRzhH82HhZWyZMc5y8QvX9Mk61C45YN1GOBwSkHcEaW2tIgb+fkjHsWi/yS/iLZvbPVLQeUziVB3PIJzRfhWgf3G0SpZXLfvMGhOYO2USvYh2L55ZT222yAiVw/GJBqWlsT3FSElQFK073X9iTFAl2cCKwMqls68UQAVH4ZmJR0xdjYoz44AIi0+PzyFSm9wsaTjunVg+nGhc6nSug/67NJowCVUJu3UV647apC/2W6Gh0BvJ/yyZ4PHJQbAK5j1tw0y5yWJWeWOPhAeDhp4Yt2il121v2wgUTXMNnQ86AO4/rzKrLA305BvmbZwUJ7KNdG61cnmKedyR7x0zNvEssTSbdfEpcrs3crcASZVAAhS7Ob5qDOEnuRl5sbpNZE0S+ssbPbBWJQfpdvhdLslytFW4CO7NR11YFUg==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(376002)(136003)(346002)(396003)(451199021)(40470700004)(36840700001)(46966006)(40460700003)(2906002)(30864003)(7696005)(82310400005)(82740400003)(356005)(6666004)(81166007)(2616005)(83380400001)(336012)(426003)(186003)(1076003)(47076005)(26005)(36860700001)(41300700001)(86362001)(54906003)(110136005)(478600001)(40480700001)(70586007)(70206006)(36756003)(316002)(4326008)(8936002)(8676002)(5660300002)(7416002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2023 13:55:53.3705
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4abdf23e-36f6-449d-2ae2-08db764d0eb2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT034.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6595
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
index 8154fbfd1229..a51cf7f32f7d 100644
--- a/sound/soc/amd/acp/acp-pci.c
+++ b/sound/soc/amd/acp/acp-pci.c
@@ -106,6 +106,7 @@ static int acp_pci_probe(struct pci_dev *pci, const struct pci_device_id *pci_id
 		goto unregister_dmic_dev;
 	}
 
+	acp_init(chip);
 	res = devm_kcalloc(&pci->dev, num_res, sizeof(struct resource), GFP_KERNEL);
 	if (!res) {
 		ret = -ENOMEM;
@@ -154,10 +155,17 @@ static int acp_pci_probe(struct pci_dev *pci, const struct pci_device_id *pci_id
 
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
@@ -177,4 +185,5 @@ static struct pci_driver snd_amd_acp_pci_driver = {
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

