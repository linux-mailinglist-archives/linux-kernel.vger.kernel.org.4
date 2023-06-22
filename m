Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 614C373A4C4
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 17:25:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232391AbjFVPZq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 11:25:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232369AbjFVPZm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 11:25:42 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2081.outbound.protection.outlook.com [40.107.94.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D826E6E
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 08:25:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ja7CW6rsBCt6sJie/UwgLG274fdZUyMGJOf87cQnU5R7mEzN0RfHEgxsz4f+szjY32XHaE4ZEPXNfzV7+mInhSa9XbTfDaWYF5gQj5DFqAUrhbm6cFlzD1OMiknY3JPT6G48Td9jsyFbv5mtEpOdh3N3sWhlkWaxtJtfu+CkBihOow0STIwopUVcUG6qHGuxfDifLnikhDTjb3WVsqzNlIA5IhtvgNBtpFdBGXLGQZgZuwoo8KpHGq/dn5+rMxxYR91f7FQnRC4gqHE7iA6FqNs05MrfMjh/3P8BfKf5+r0/3nsvu2DIAw2paIkqnC2/JTdGYLeqIozq1GeLKm9Deg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gycwDhAyFF+K1xbN3kqPBoobKHCJK/+BUp0Tu2LksTU=;
 b=UeO8pJX2TMY9txk5mWPC/fX3zXWBdotCAFHRzOZhqTIsEM3oMf+CJH5Sfdzzp/nzfk6b04SKMP2so68q504ZaPc4VHUdQcWi2x4IPCXiVyaWLlnNXvYg0xkCDt0oWc8RnUark71zAWaUnbL5noSCb2bae3aAInQXRkpQVAlwkZpGlL58k+InoirwdpUjO7p59/cjfwCsW4Q2TrMVWYbGRDd8PpjWczLgkkMkpVDKSBwxfQ9FGWaMQdVmuZGIYd8OwT0/g3oHiQ8/Ys79wz3+A9MLPpjy67IsqQ3yhCKQdX9thwg640JTT0huLQIknBCHCDND2g50qKEgDK2epY10Ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gycwDhAyFF+K1xbN3kqPBoobKHCJK/+BUp0Tu2LksTU=;
 b=dmzc10NUEpjOP+8/2gwAV7+lFB+UdRkiLP0HhyBXRHdFQx1vberrFb5vbt9Tm+Sm8A6M0Eyyy0D+lMjRQ/LmuPxQm6pPQyvoA5fYkriqeduVWemnweMGRIKyOB3/CLMvWUGo84U4yZohbBUcNxPiP3lZp9aGDd5bjHxybRycp50=
Received: from MW4PR04CA0221.namprd04.prod.outlook.com (2603:10b6:303:87::16)
 by CY5PR12MB6035.namprd12.prod.outlook.com (2603:10b6:930:2d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23; Thu, 22 Jun
 2023 15:25:23 +0000
Received: from MWH0EPF000971E8.namprd02.prod.outlook.com
 (2603:10b6:303:87:cafe::94) by MW4PR04CA0221.outlook.office365.com
 (2603:10b6:303:87::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24 via Frontend
 Transport; Thu, 22 Jun 2023 15:25:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 MWH0EPF000971E8.mail.protection.outlook.com (10.167.243.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6521.17 via Frontend Transport; Thu, 22 Jun 2023 15:25:21 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Thu, 22 Jun
 2023 10:25:21 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Thu, 22 Jun
 2023 10:25:20 -0500
Received: from amd-B450M-DS3H.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.23 via Frontend
 Transport; Thu, 22 Jun 2023 10:25:16 -0500
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
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        "Ajit Kumar Pandey" <AjitKumar.Pandey@amd.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH 03/12] ASoC: amd: acp: refactor the acp init and de-init sequence
Date:   Thu, 22 Jun 2023 20:53:43 +0530
Message-ID: <20230622152406.3709231-6-Syed.SabaKareem@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230622152406.3709231-1-Syed.SabaKareem@amd.com>
References: <20230622152406.3709231-1-Syed.SabaKareem@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E8:EE_|CY5PR12MB6035:EE_
X-MS-Office365-Filtering-Correlation-Id: 49c02349-33a5-4ab6-ef7e-08db7334e50b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: F/KayTk/RkMTN5WItat2G2Sq99kvZNiyEw1zJD7el/JZau2VBTzksDDfuhVkh6ZAUQaHqyaohl8ZLaD8+J+//l5a7w10R0ySarmBv6Jj6X+ulK0KBLavxX7vGVt3tvjLdqBJp1bI1o5TVI7vzzWBLYf8XIBJxyFjKcGffbIWIh7mFZUzOwPpSJ9MfPhFb1KBp4Ry27MElLFVXkqU2eTwVAWwR9lljX9LO7OLUglhN5XNxkGReVaQ0ijrUXvap6EzWI//F68/jhGsxTFS8OpETU9UwX1jFDGQitooRiE96O8V6sOYE5F78u5MspOCixZMZHtClNss0C/ABKKMbR1ze9ja9C+mPJ3p6MQtd0vZY5Z9Ilyv0kXP5QqaCMQy0ffrOGR/FL3IrVHHoIgLjF5kwo4Dmlq/4ci9E5OYTvuY7LBMCFyJPjiGmt8tK4modUQzeR+QU0RLxOyLe/4oo0a2rqdPlUV4SGPl2IrlPyvSaPUYROLzEMztHXqw9rrglqSc9Hs3yIYO8dPAIAFESFbBD3eHfqotbTCP1L5SA62T0czgm58sjlU4fJazy5FnbvcsPCG7a+RefjbZgIMcisFdHmpSzzC67R76Qw/i/7Y4GcZ2uQqjRDy5onFvi6DkbicDfmZNizHZZaMbKXCGc+cDZjF8fser2poL+EIm8sn7IrgsM+0mxK+VLW0GLazKIVQjOswWHs+BOJfQY46v6FDQpjhOLCxZkh/C08ubznMqZiQoyFJxtspz+s+X/Kc/3fKkfLZOHespf7NncFzRfON7rw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(136003)(376002)(396003)(346002)(451199021)(36840700001)(40470700004)(46966006)(70206006)(1076003)(186003)(26005)(8676002)(2616005)(336012)(7416002)(82740400003)(83380400001)(426003)(7696005)(82310400005)(36756003)(2906002)(47076005)(36860700001)(478600001)(6666004)(30864003)(316002)(54906003)(40480700001)(4326008)(70586007)(40460700003)(110136005)(86362001)(41300700001)(81166007)(5660300002)(8936002)(356005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2023 15:25:21.9127
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 49c02349-33a5-4ab6-ef7e-08db7334e50b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000971E8.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6035
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

