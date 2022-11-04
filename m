Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DFF761911A
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 07:31:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230526AbiKDGa5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 02:30:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbiKDGay (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 02:30:54 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2079.outbound.protection.outlook.com [40.107.220.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33E531EADC
        for <linux-kernel@vger.kernel.org>; Thu,  3 Nov 2022 23:30:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OtGw+1FtMQ297jU6QSXAndlJ07rOWGrMkinbC1oB9FHfx33mUb4znrQgXg4VfQJl3B7IEwdql2yeDnxq+1jOpylKF1qQK34eArxgxdrzRH5MQCQsNT3kHP+mssdK4zXp93oTIlo1wg9Rdb2AFLmD5+b99XPy5k7EbJaGFnKaLYZ785fbiO1IL37MxuE1qZPWrezc7rgmb8AKOrgZJ4Lvg6Ia3WziVrrO9V/n5MUCkUKn6BP1vCUXsWDgs+Jfm0hdMeRrIf6Lk9KunWiHi8lTACWrSkGME2FoWtoDVHg2gfZ8u5hbAZL4jHnQMPTlPym6JgQrqO+3juqLMc9ylk2OZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rqsccLYPFoFXuwsT4o/r45oeBYQ40R2oEXVOH1RmfYo=;
 b=BINaaITNhUArYek/9ySAryGCOmdwQZsrb9Uo84RhFhTbiG8s2CyjaGIcjHq0yIBC3TxYbRWd3tSKNLbA1hY3JcqDkbiSujkLomP/ISpkOlc/81mKCWGNpWCLwycxRrAH6INp4Ho8Y+W/Yzgk53R8S0h1T6J9krd5mjwhcQStd7heomooQkE8LlidqWrtVvQGp+VRvaJmmdwp61B4TxTTHt33NNSTgpxIJ5naPCz3MFa2vKIFhA6NWnYItrnTvLbiApxSNxKjWf6QlRJKBVQ4ldggzjzJAwHa61XWvBfDE6BgZD/p6If42v+0SQ92Hq554rkjk/TtmDizRcisirhq1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rqsccLYPFoFXuwsT4o/r45oeBYQ40R2oEXVOH1RmfYo=;
 b=mYBX49rYVHo5+ZwyjsHFxP1Sri6oYPnA78fN41AFzXS3xPew6MXYvT2Px7+Rw1eF754bBqhVRpni0lN/Sxr6P8byiww7LUJu/bOkDJFR1t+4RQbyDIVsozpyGX8puVvlTyuSLDboD9LZghkOhaehHW8slLluxnrj6a2aGV4Ht6Q=
Received: from DS7PR03CA0004.namprd03.prod.outlook.com (2603:10b6:5:3b8::9) by
 CH0PR12MB5203.namprd12.prod.outlook.com (2603:10b6:610:ba::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5791.22; Fri, 4 Nov 2022 06:30:48 +0000
Received: from DM6NAM11FT038.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b8:cafe::f0) by DS7PR03CA0004.outlook.office365.com
 (2603:10b6:5:3b8::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.22 via Frontend
 Transport; Fri, 4 Nov 2022 06:30:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT038.mail.protection.outlook.com (10.13.173.137) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5791.20 via Frontend Transport; Fri, 4 Nov 2022 06:30:47 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Fri, 4 Nov
 2022 01:30:47 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Fri, 4 Nov
 2022 01:30:46 -0500
Received: from amd-Z97X-UD7-TH.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.31 via Frontend
 Transport; Fri, 4 Nov 2022 01:30:37 -0500
From:   Syed Saba Kareem <Syed.SabaKareem@amd.com>
To:     <broonie@kernel.org>, <alsa-devel@alsa-project.org>
CC:     <Vijendar.Mukunda@amd.com>, <Basavaraj.Hiregoudar@amd.com>,
        <Sunil-kumar.Dommati@amd.com>, <mario.limonciello@amd.com>,
        syed saba kareem <syed.sabakareem@amd.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Syed Saba kareem <Syed.SabaKareem@amd.com>,
        Ajit Kumar Pandey <AjitKumar.Pandey@amd.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Lucas Tanure <tanureal@opensource.cirrus.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        "open list" <linux-kernel@vger.kernel.org>
Subject: [PATCH] ASoC: amd: fix ACP version typo mistake
Date:   Fri, 4 Nov 2022 17:39:07 +0530
Message-ID: <20221104121001.207992-1-Syed.SabaKareem@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT038:EE_|CH0PR12MB5203:EE_
X-MS-Office365-Filtering-Correlation-Id: 6bcf3e28-e4a2-4680-047c-08dabe2e1c56
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WOo2sVfcbgAafaB+Mb6O2vHooz/s1sKds8HbOFUGUc3JX3FEYyn77yl0S/gYAV7vjKiwowR4CkrBy+PH9P/T3gmNmH6snNYZihBld5TMmas0Cbc0MECN49eqtyBb1VGv2UkWWHS1BFfKJwbkHakVbfjXigAiiYBebQtXpwN6JGedBygzulll+2V6bFqR7E/AaVIRnbvAY9fmw2w3z1c1UXFpEbilE8gsznQ2BCjxU7eXKojf0VJqrPlv/iHK2z+lhY3Ou3OKXTKboHDmVEte9yRAlZmyL/q7SUqWIPOINsfxBO4sK47mkIeQ6VauVNvZs6899c/FpBwtbf3sos+42Py1Hm/IDqTzuUwXdEQwJ5wW1ISyPgEj9sikMdNwBEaYXXxjlf2u02m7mrLcB2kFAQTYAJbHSu9WBiK6vavnH2bfHIUk31DArNEZxwO0Y08xZ4anC6wmxiwMJDlwjzwQX7+lk2psEAiIg/PGhvxDBhdu6iScRw1FqIqH1//8kwaWKUke1wJQM/UVlQHB2sOZoBvL97JD/z1VfBUUgmLo4Zw6ztxmvK/pXIF/NUdmabSGbaGE6Cmub2LNGIv4UyJNLzSNb0dyLwyolCUxRkewLjoS29+pdZNr13kcKlpZ38yGnDseoPguznl8Y7TunvY4gp897mbbRBCVGroB5du1fSlRcNsqu6Us/7KW2yGL0gQ1n7F/HIP3cEhu77gS/6aH2ctujBbhx2Q/oLaPwIruAo0rl4tY4w/0AOWAUPRe5Ab0R8LfTFYkxc16hFqBqd1gcq7EZJ7WEXpbzw+uNgEnxqI=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(376002)(346002)(136003)(396003)(39860400002)(451199015)(46966006)(36840700001)(40470700004)(8676002)(5660300002)(26005)(2616005)(1076003)(4326008)(478600001)(336012)(81166007)(41300700001)(7416002)(186003)(83380400001)(2906002)(70206006)(7696005)(426003)(40480700001)(356005)(86362001)(30864003)(110136005)(54906003)(316002)(40460700003)(36860700001)(82740400003)(8936002)(70586007)(82310400005)(47076005)(36756003)(6666004)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2022 06:30:47.8268
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6bcf3e28-e4a2-4680-047c-08dabe2e1c56
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT038.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5203
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_03_06,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: syed saba kareem <syed.sabakareem@amd.com>

Pink Sardine is based on ACP6.3 architecture.
This patch fixes the typo mistake acp6.2 -> acp6.3

Signed-off-by: syed saba kareem <syed.sabakareem@amd.com>
---
 ...offset_byte.h => acp63_chip_offset_byte.h} |   2 +-
 sound/soc/amd/Kconfig                         |   4 +-
 sound/soc/amd/ps/{acp62.h => acp63.h}         |  10 +-
 sound/soc/amd/ps/pci-ps.c                     | 132 ++++++------
 sound/soc/amd/ps/ps-mach.c                    |  30 +--
 sound/soc/amd/ps/ps-pdm-dma.c                 | 188 +++++++++---------
 6 files changed, 183 insertions(+), 183 deletions(-)
 rename include/sound/{acp62_chip_offset_byte.h => acp63_chip_offset_byte.h} (99%)
 rename sound/soc/amd/ps/{acp62.h => acp63.h} (90%)

diff --git a/include/sound/acp62_chip_offset_byte.h b/include/sound/acp63_chip_offset_byte.h
similarity index 99%
rename from include/sound/acp62_chip_offset_byte.h
rename to include/sound/acp63_chip_offset_byte.h
index ca38f8a0966e..c9260e1640ae 100644
--- a/include/sound/acp62_chip_offset_byte.h
+++ b/include/sound/acp63_chip_offset_byte.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0+ */
 /*
- * AMD ACP 6.2 Register Documentation
+ * AMD ACP 6.3 Register Documentation
  *
  * Copyright 2022 Advanced Micro Devices, Inc.
  */
diff --git a/sound/soc/amd/Kconfig b/sound/soc/amd/Kconfig
index 150786279257..c88ebd84bdd5 100644
--- a/sound/soc/amd/Kconfig
+++ b/sound/soc/amd/Kconfig
@@ -129,10 +129,10 @@ config SND_SOC_AMD_RPL_ACP6x
           If unsure select "N".
 
 config SND_SOC_AMD_PS
-        tristate "AMD Audio Coprocessor-v6.2 Pink Sardine support"
+        tristate "AMD Audio Coprocessor-v6.3 Pink Sardine support"
         depends on X86 && PCI && ACPI
         help
-          This option enables Audio Coprocessor i.e ACP v6.2 support on
+          This option enables Audio Coprocessor i.e ACP v6.3 support on
           AMD Pink sardine platform. By enabling this flag build will be
           triggered for ACP PCI driver, ACP PDM DMA driver.
           Say m if you have such a device.
diff --git a/sound/soc/amd/ps/acp62.h b/sound/soc/amd/ps/acp63.h
similarity index 90%
rename from sound/soc/amd/ps/acp62.h
rename to sound/soc/amd/ps/acp63.h
index 8b30aefa4cd0..85f869c2229f 100644
--- a/sound/soc/amd/ps/acp62.h
+++ b/sound/soc/amd/ps/acp63.h
@@ -5,7 +5,7 @@
  * Copyright (C) 2022 Advanced Micro Devices, Inc. All rights reserved.
  */
 
-#include <sound/acp62_chip_offset_byte.h>
+#include <sound/acp63_chip_offset_byte.h>
 
 #define ACP_DEVICE_ID 0x15E2
 #define ACP6x_REG_START		0x1240000
@@ -78,21 +78,21 @@ struct pdm_stream_instance {
 	u16 channels;
 	dma_addr_t dma_addr;
 	u64 bytescount;
-	void __iomem *acp62_base;
+	void __iomem *acp63_base;
 };
 
 struct pdm_dev_data {
 	u32 pdm_irq;
-	void __iomem *acp62_base;
+	void __iomem *acp63_base;
 	struct snd_pcm_substream *capture_stream;
 };
 
-static inline u32 acp62_readl(void __iomem *base_addr)
+static inline u32 acp63_readl(void __iomem *base_addr)
 {
 	return readl(base_addr);
 }
 
-static inline void acp62_writel(u32 val, void __iomem *base_addr)
+static inline void acp63_writel(u32 val, void __iomem *base_addr)
 {
 	writel(val, base_addr);
 }
diff --git a/sound/soc/amd/ps/pci-ps.c b/sound/soc/amd/ps/pci-ps.c
index dff2e2376bbf..08c4b9bef055 100644
--- a/sound/soc/amd/ps/pci-ps.c
+++ b/sound/soc/amd/ps/pci-ps.c
@@ -15,30 +15,30 @@
 #include <sound/pcm_params.h>
 #include <linux/pm_runtime.h>
 
-#include "acp62.h"
+#include "acp63.h"
 
-struct acp62_dev_data {
-	void __iomem *acp62_base;
+struct acp63_dev_data {
+	void __iomem *acp63_base;
 	struct resource *res;
-	bool acp62_audio_mode;
+	bool acp63_audio_mode;
 	struct platform_device *pdev[ACP6x_DEVS];
 };
 
-static int acp62_power_on(void __iomem *acp_base)
+static int acp63_power_on(void __iomem *acp_base)
 {
 	u32 val;
 	int timeout;
 
-	val = acp62_readl(acp_base + ACP_PGFSM_STATUS);
+	val = acp63_readl(acp_base + ACP_PGFSM_STATUS);
 
 	if (!val)
 		return val;
 
 	if ((val & ACP_PGFSM_STATUS_MASK) != ACP_POWER_ON_IN_PROGRESS)
-		acp62_writel(ACP_PGFSM_CNTL_POWER_ON_MASK, acp_base + ACP_PGFSM_CONTROL);
+		acp63_writel(ACP_PGFSM_CNTL_POWER_ON_MASK, acp_base + ACP_PGFSM_CONTROL);
 	timeout = 0;
 	while (++timeout < 500) {
-		val = acp62_readl(acp_base + ACP_PGFSM_STATUS);
+		val = acp63_readl(acp_base + ACP_PGFSM_STATUS);
 		if (!val)
 			return 0;
 		udelay(1);
@@ -46,23 +46,23 @@ static int acp62_power_on(void __iomem *acp_base)
 	return -ETIMEDOUT;
 }
 
-static int acp62_reset(void __iomem *acp_base)
+static int acp63_reset(void __iomem *acp_base)
 {
 	u32 val;
 	int timeout;
 
-	acp62_writel(1, acp_base + ACP_SOFT_RESET);
+	acp63_writel(1, acp_base + ACP_SOFT_RESET);
 	timeout = 0;
 	while (++timeout < 500) {
-		val = acp62_readl(acp_base + ACP_SOFT_RESET);
+		val = acp63_readl(acp_base + ACP_SOFT_RESET);
 		if (val & ACP_SOFT_RESET_SOFTRESET_AUDDONE_MASK)
 			break;
 		cpu_relax();
 	}
-	acp62_writel(0, acp_base + ACP_SOFT_RESET);
+	acp63_writel(0, acp_base + ACP_SOFT_RESET);
 	timeout = 0;
 	while (++timeout < 500) {
-		val = acp62_readl(acp_base + ACP_SOFT_RESET);
+		val = acp63_readl(acp_base + ACP_SOFT_RESET);
 		if (!val)
 			return 0;
 		cpu_relax();
@@ -70,57 +70,57 @@ static int acp62_reset(void __iomem *acp_base)
 	return -ETIMEDOUT;
 }
 
-static void acp62_enable_interrupts(void __iomem *acp_base)
+static void acp63_enable_interrupts(void __iomem *acp_base)
 {
-	acp62_writel(1, acp_base + ACP_EXTERNAL_INTR_ENB);
+	acp63_writel(1, acp_base + ACP_EXTERNAL_INTR_ENB);
 }
 
-static void acp62_disable_interrupts(void __iomem *acp_base)
+static void acp63_disable_interrupts(void __iomem *acp_base)
 {
-	acp62_writel(ACP_EXT_INTR_STAT_CLEAR_MASK, acp_base +
+	acp63_writel(ACP_EXT_INTR_STAT_CLEAR_MASK, acp_base +
 		     ACP_EXTERNAL_INTR_STAT);
-	acp62_writel(0, acp_base + ACP_EXTERNAL_INTR_CNTL);
-	acp62_writel(0, acp_base + ACP_EXTERNAL_INTR_ENB);
+	acp63_writel(0, acp_base + ACP_EXTERNAL_INTR_CNTL);
+	acp63_writel(0, acp_base + ACP_EXTERNAL_INTR_ENB);
 }
 
-static int acp62_init(void __iomem *acp_base, struct device *dev)
+static int acp63_init(void __iomem *acp_base, struct device *dev)
 {
 	int ret;
 
-	ret = acp62_power_on(acp_base);
+	ret = acp63_power_on(acp_base);
 	if (ret) {
 		dev_err(dev, "ACP power on failed\n");
 		return ret;
 	}
-	acp62_writel(0x01, acp_base + ACP_CONTROL);
-	ret = acp62_reset(acp_base);
+	acp63_writel(0x01, acp_base + ACP_CONTROL);
+	ret = acp63_reset(acp_base);
 	if (ret) {
 		dev_err(dev, "ACP reset failed\n");
 		return ret;
 	}
-	acp62_writel(0x03, acp_base + ACP_CLKMUX_SEL);
-	acp62_enable_interrupts(acp_base);
+	acp63_writel(0x03, acp_base + ACP_CLKMUX_SEL);
+	acp63_enable_interrupts(acp_base);
 	return 0;
 }
 
-static int acp62_deinit(void __iomem *acp_base, struct device *dev)
+static int acp63_deinit(void __iomem *acp_base, struct device *dev)
 {
 	int ret;
 
-	acp62_disable_interrupts(acp_base);
-	ret = acp62_reset(acp_base);
+	acp63_disable_interrupts(acp_base);
+	ret = acp63_reset(acp_base);
 	if (ret) {
 		dev_err(dev, "ACP reset failed\n");
 		return ret;
 	}
-	acp62_writel(0, acp_base + ACP_CLKMUX_SEL);
-	acp62_writel(0, acp_base + ACP_CONTROL);
+	acp63_writel(0, acp_base + ACP_CLKMUX_SEL);
+	acp63_writel(0, acp_base + ACP_CONTROL);
 	return 0;
 }
 
-static irqreturn_t acp62_irq_handler(int irq, void *dev_id)
+static irqreturn_t acp63_irq_handler(int irq, void *dev_id)
 {
-	struct acp62_dev_data *adata;
+	struct acp63_dev_data *adata;
 	struct pdm_dev_data *ps_pdm_data;
 	u32 val;
 
@@ -128,10 +128,10 @@ static irqreturn_t acp62_irq_handler(int irq, void *dev_id)
 	if (!adata)
 		return IRQ_NONE;
 
-	val = acp62_readl(adata->acp62_base + ACP_EXTERNAL_INTR_STAT);
+	val = acp63_readl(adata->acp63_base + ACP_EXTERNAL_INTR_STAT);
 	if (val & BIT(PDM_DMA_STAT)) {
 		ps_pdm_data = dev_get_drvdata(&adata->pdev[0]->dev);
-		acp62_writel(BIT(PDM_DMA_STAT), adata->acp62_base + ACP_EXTERNAL_INTR_STAT);
+		acp63_writel(BIT(PDM_DMA_STAT), adata->acp63_base + ACP_EXTERNAL_INTR_STAT);
 		if (ps_pdm_data->capture_stream)
 			snd_pcm_period_elapsed(ps_pdm_data->capture_stream);
 		return IRQ_HANDLED;
@@ -139,10 +139,10 @@ static irqreturn_t acp62_irq_handler(int irq, void *dev_id)
 	return IRQ_NONE;
 }
 
-static int snd_acp62_probe(struct pci_dev *pci,
+static int snd_acp63_probe(struct pci_dev *pci,
 			   const struct pci_device_id *pci_id)
 {
-	struct acp62_dev_data *adata;
+	struct acp63_dev_data *adata;
 	struct platform_device_info pdevinfo[ACP6x_DEVS];
 	int index, ret;
 	int val = 0x00;
@@ -157,7 +157,7 @@ static int snd_acp62_probe(struct pci_dev *pci,
 	case 0x63:
 		break;
 	default:
-		dev_dbg(&pci->dev, "acp62 pci device not found\n");
+		dev_dbg(&pci->dev, "acp63 pci device not found\n");
 		return -ENODEV;
 	}
 	if (pci_enable_device(pci)) {
@@ -170,7 +170,7 @@ static int snd_acp62_probe(struct pci_dev *pci,
 		dev_err(&pci->dev, "pci_request_regions failed\n");
 		goto disable_pci;
 	}
-	adata = devm_kzalloc(&pci->dev, sizeof(struct acp62_dev_data),
+	adata = devm_kzalloc(&pci->dev, sizeof(struct acp63_dev_data),
 			     GFP_KERNEL);
 	if (!adata) {
 		ret = -ENOMEM;
@@ -178,18 +178,18 @@ static int snd_acp62_probe(struct pci_dev *pci,
 	}
 
 	addr = pci_resource_start(pci, 0);
-	adata->acp62_base = devm_ioremap(&pci->dev, addr,
+	adata->acp63_base = devm_ioremap(&pci->dev, addr,
 					 pci_resource_len(pci, 0));
-	if (!adata->acp62_base) {
+	if (!adata->acp63_base) {
 		ret = -ENOMEM;
 		goto release_regions;
 	}
 	pci_set_master(pci);
 	pci_set_drvdata(pci, adata);
-	ret = acp62_init(adata->acp62_base, &pci->dev);
+	ret = acp63_init(adata->acp63_base, &pci->dev);
 	if (ret)
 		goto release_regions;
-	val = acp62_readl(adata->acp62_base + ACP_PIN_CONFIG);
+	val = acp63_readl(adata->acp63_base + ACP_PIN_CONFIG);
 	switch (val) {
 	case ACP_CONFIG_0:
 	case ACP_CONFIG_1:
@@ -220,7 +220,7 @@ static int snd_acp62_probe(struct pci_dev *pci,
 			adata->res->flags = IORESOURCE_MEM;
 			adata->res->start = addr;
 			adata->res->end = addr + (ACP6x_REG_END - ACP6x_REG_START);
-			adata->acp62_audio_mode = ACP6x_PDM_MODE;
+			adata->acp63_audio_mode = ACP6x_PDM_MODE;
 
 			memset(&pdevinfo, 0, sizeof(pdevinfo));
 			pdevinfo[0].name = "acp_ps_pdm_dma";
@@ -248,7 +248,7 @@ static int snd_acp62_probe(struct pci_dev *pci,
 					ret = PTR_ERR(adata->pdev[index]);
 					goto unregister_devs;
 				}
-				ret = devm_request_irq(&pci->dev, pci->irq, acp62_irq_handler,
+				ret = devm_request_irq(&pci->dev, pci->irq, acp63_irq_handler,
 						       irqflags, "ACP_PCI_IRQ", adata);
 				if (ret) {
 					dev_err(&pci->dev, "ACP PCI IRQ request failed\n");
@@ -267,7 +267,7 @@ static int snd_acp62_probe(struct pci_dev *pci,
 	for (--index; index >= 0; index--)
 		platform_device_unregister(adata->pdev[index]);
 de_init:
-	if (acp62_deinit(adata->acp62_base, &pci->dev))
+	if (acp63_deinit(adata->acp63_base, &pci->dev))
 		dev_err(&pci->dev, "ACP de-init failed\n");
 release_regions:
 	pci_release_regions(pci);
@@ -277,46 +277,46 @@ static int snd_acp62_probe(struct pci_dev *pci,
 	return ret;
 }
 
-static int __maybe_unused snd_acp62_suspend(struct device *dev)
+static int __maybe_unused snd_acp63_suspend(struct device *dev)
 {
-	struct acp62_dev_data *adata;
+	struct acp63_dev_data *adata;
 	int ret;
 
 	adata = dev_get_drvdata(dev);
-	ret = acp62_deinit(adata->acp62_base, dev);
+	ret = acp63_deinit(adata->acp63_base, dev);
 	if (ret)
 		dev_err(dev, "ACP de-init failed\n");
 	return ret;
 }
 
-static int __maybe_unused snd_acp62_resume(struct device *dev)
+static int __maybe_unused snd_acp63_resume(struct device *dev)
 {
-	struct acp62_dev_data *adata;
+	struct acp63_dev_data *adata;
 	int ret;
 
 	adata = dev_get_drvdata(dev);
-	ret = acp62_init(adata->acp62_base, dev);
+	ret = acp63_init(adata->acp63_base, dev);
 	if (ret)
 		dev_err(dev, "ACP init failed\n");
 	return ret;
 }
 
-static const struct dev_pm_ops acp62_pm_ops = {
-	SET_RUNTIME_PM_OPS(snd_acp62_suspend, snd_acp62_resume, NULL)
-	SET_SYSTEM_SLEEP_PM_OPS(snd_acp62_suspend, snd_acp62_resume)
+static const struct dev_pm_ops acp63_pm_ops = {
+	SET_RUNTIME_PM_OPS(snd_acp63_suspend, snd_acp63_resume, NULL)
+	SET_SYSTEM_SLEEP_PM_OPS(snd_acp63_suspend, snd_acp63_resume)
 };
 
-static void snd_acp62_remove(struct pci_dev *pci)
+static void snd_acp63_remove(struct pci_dev *pci)
 {
-	struct acp62_dev_data *adata;
+	struct acp63_dev_data *adata;
 	int ret, index;
 
 	adata = pci_get_drvdata(pci);
-	if (adata->acp62_audio_mode == ACP6x_PDM_MODE) {
+	if (adata->acp63_audio_mode == ACP6x_PDM_MODE) {
 		for (index = 0; index < ACP6x_DEVS; index++)
 			platform_device_unregister(adata->pdev[index]);
 	}
-	ret = acp62_deinit(adata->acp62_base, &pci->dev);
+	ret = acp63_deinit(adata->acp63_base, &pci->dev);
 	if (ret)
 		dev_err(&pci->dev, "ACP de-init failed\n");
 	pm_runtime_forbid(&pci->dev);
@@ -325,25 +325,25 @@ static void snd_acp62_remove(struct pci_dev *pci)
 	pci_disable_device(pci);
 }
 
-static const struct pci_device_id snd_acp62_ids[] = {
+static const struct pci_device_id snd_acp63_ids[] = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, ACP_DEVICE_ID),
 	.class = PCI_CLASS_MULTIMEDIA_OTHER << 8,
 	.class_mask = 0xffffff },
 	{ 0, },
 };
-MODULE_DEVICE_TABLE(pci, snd_acp62_ids);
+MODULE_DEVICE_TABLE(pci, snd_acp63_ids);
 
-static struct pci_driver ps_acp62_driver  = {
+static struct pci_driver ps_acp63_driver  = {
 	.name = KBUILD_MODNAME,
-	.id_table = snd_acp62_ids,
-	.probe = snd_acp62_probe,
-	.remove = snd_acp62_remove,
+	.id_table = snd_acp63_ids,
+	.probe = snd_acp63_probe,
+	.remove = snd_acp63_remove,
 	.driver = {
-		.pm = &acp62_pm_ops,
+		.pm = &acp63_pm_ops,
 	}
 };
 
-module_pci_driver(ps_acp62_driver);
+module_pci_driver(ps_acp63_driver);
 
 MODULE_AUTHOR("Vijendar.Mukunda@amd.com");
 MODULE_AUTHOR("Syed.SabaKareem@amd.com");
diff --git a/sound/soc/amd/ps/ps-mach.c b/sound/soc/amd/ps/ps-mach.c
index b3e97093481d..3ffbe4fdafdf 100644
--- a/sound/soc/amd/ps/ps-mach.c
+++ b/sound/soc/amd/ps/ps-mach.c
@@ -13,11 +13,11 @@
 #include <linux/io.h>
 #include <linux/dmi.h>
 
-#include "acp62.h"
+#include "acp63.h"
 
 #define DRV_NAME "acp_ps_mach"
 
-SND_SOC_DAILINK_DEF(acp62_pdm,
+SND_SOC_DAILINK_DEF(acp63_pdm,
 		    DAILINK_COMP_ARRAY(COMP_CPU("acp_ps_pdm_dma.0")));
 
 SND_SOC_DAILINK_DEF(dmic_codec,
@@ -27,31 +27,31 @@ SND_SOC_DAILINK_DEF(dmic_codec,
 SND_SOC_DAILINK_DEF(pdm_platform,
 		    DAILINK_COMP_ARRAY(COMP_PLATFORM("acp_ps_pdm_dma.0")));
 
-static struct snd_soc_dai_link acp62_dai_pdm[] = {
+static struct snd_soc_dai_link acp63_dai_pdm[] = {
 	{
-		.name = "acp62-dmic-capture",
+		.name = "acp63-dmic-capture",
 		.stream_name = "DMIC capture",
 		.capture_only = 1,
-		SND_SOC_DAILINK_REG(acp62_pdm, dmic_codec, pdm_platform),
+		SND_SOC_DAILINK_REG(acp63_pdm, dmic_codec, pdm_platform),
 	},
 };
 
-static struct snd_soc_card acp62_card = {
-	.name = "acp62",
+static struct snd_soc_card acp63_card = {
+	.name = "acp63",
 	.owner = THIS_MODULE,
-	.dai_link = acp62_dai_pdm,
+	.dai_link = acp63_dai_pdm,
 	.num_links = 1,
 };
 
-static int acp62_probe(struct platform_device *pdev)
+static int acp63_probe(struct platform_device *pdev)
 {
-	struct acp62_pdm *machine = NULL;
+	struct acp63_pdm *machine = NULL;
 	struct snd_soc_card *card;
 	int ret;
 
-	platform_set_drvdata(pdev, &acp62_card);
+	platform_set_drvdata(pdev, &acp63_card);
 	card = platform_get_drvdata(pdev);
-	acp62_card.dev = &pdev->dev;
+	acp63_card.dev = &pdev->dev;
 
 	snd_soc_card_set_drvdata(card, machine);
 	ret = devm_snd_soc_register_card(&pdev->dev, card);
@@ -64,15 +64,15 @@ static int acp62_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static struct platform_driver acp62_mach_driver = {
+static struct platform_driver acp63_mach_driver = {
 	.driver = {
 		.name = "acp_ps_mach",
 		.pm = &snd_soc_pm_ops,
 	},
-	.probe = acp62_probe,
+	.probe = acp63_probe,
 };
 
-module_platform_driver(acp62_mach_driver);
+module_platform_driver(acp63_mach_driver);
 
 MODULE_AUTHOR("Syed.SabaKareem@amd.com");
 MODULE_LICENSE("GPL v2");
diff --git a/sound/soc/amd/ps/ps-pdm-dma.c b/sound/soc/amd/ps/ps-pdm-dma.c
index b207b726cd82..eea71a9d2ef1 100644
--- a/sound/soc/amd/ps/ps-pdm-dma.c
+++ b/sound/soc/amd/ps/ps-pdm-dma.c
@@ -14,11 +14,11 @@
 #include <sound/soc-dai.h>
 #include <linux/pm_runtime.h>
 
-#include "acp62.h"
+#include "acp63.h"
 
 #define DRV_NAME "acp_ps_pdm_dma"
 
-static const struct snd_pcm_hardware acp62_pdm_hardware_capture = {
+static const struct snd_pcm_hardware acp63_pdm_hardware_capture = {
 	.info = SNDRV_PCM_INFO_INTERLEAVED |
 		SNDRV_PCM_INFO_BLOCK_TRANSFER |
 		SNDRV_PCM_INFO_MMAP |
@@ -37,61 +37,61 @@ static const struct snd_pcm_hardware acp62_pdm_hardware_capture = {
 	.periods_max = CAPTURE_MAX_NUM_PERIODS,
 };
 
-static void acp62_init_pdm_ring_buffer(u32 physical_addr, u32 buffer_size,
+static void acp63_init_pdm_ring_buffer(u32 physical_addr, u32 buffer_size,
 				       u32 watermark_size, void __iomem *acp_base)
 {
-	acp62_writel(physical_addr, acp_base + ACP_WOV_RX_RINGBUFADDR);
-	acp62_writel(buffer_size, acp_base + ACP_WOV_RX_RINGBUFSIZE);
-	acp62_writel(watermark_size, acp_base + ACP_WOV_RX_INTR_WATERMARK_SIZE);
-	acp62_writel(0x01, acp_base + ACPAXI2AXI_ATU_CTRL);
+	acp63_writel(physical_addr, acp_base + ACP_WOV_RX_RINGBUFADDR);
+	acp63_writel(buffer_size, acp_base + ACP_WOV_RX_RINGBUFSIZE);
+	acp63_writel(watermark_size, acp_base + ACP_WOV_RX_INTR_WATERMARK_SIZE);
+	acp63_writel(0x01, acp_base + ACPAXI2AXI_ATU_CTRL);
 }
 
-static void acp62_enable_pdm_clock(void __iomem *acp_base)
+static void acp63_enable_pdm_clock(void __iomem *acp_base)
 {
 	u32 pdm_clk_enable, pdm_ctrl;
 
 	pdm_clk_enable = ACP_PDM_CLK_FREQ_MASK;
 	pdm_ctrl = 0x00;
 
-	acp62_writel(pdm_clk_enable, acp_base + ACP_WOV_CLK_CTRL);
-	pdm_ctrl = acp62_readl(acp_base + ACP_WOV_MISC_CTRL);
+	acp63_writel(pdm_clk_enable, acp_base + ACP_WOV_CLK_CTRL);
+	pdm_ctrl = acp63_readl(acp_base + ACP_WOV_MISC_CTRL);
 	pdm_ctrl |= ACP_WOV_MISC_CTRL_MASK;
-	acp62_writel(pdm_ctrl, acp_base + ACP_WOV_MISC_CTRL);
+	acp63_writel(pdm_ctrl, acp_base + ACP_WOV_MISC_CTRL);
 }
 
-static void acp62_enable_pdm_interrupts(void __iomem *acp_base)
+static void acp63_enable_pdm_interrupts(void __iomem *acp_base)
 {
 	u32 ext_int_ctrl;
 
-	ext_int_ctrl = acp62_readl(acp_base + ACP_EXTERNAL_INTR_CNTL);
+	ext_int_ctrl = acp63_readl(acp_base + ACP_EXTERNAL_INTR_CNTL);
 	ext_int_ctrl |= PDM_DMA_INTR_MASK;
-	acp62_writel(ext_int_ctrl, acp_base + ACP_EXTERNAL_INTR_CNTL);
+	acp63_writel(ext_int_ctrl, acp_base + ACP_EXTERNAL_INTR_CNTL);
 }
 
-static void acp62_disable_pdm_interrupts(void __iomem *acp_base)
+static void acp63_disable_pdm_interrupts(void __iomem *acp_base)
 {
 	u32 ext_int_ctrl;
 
-	ext_int_ctrl = acp62_readl(acp_base + ACP_EXTERNAL_INTR_CNTL);
+	ext_int_ctrl = acp63_readl(acp_base + ACP_EXTERNAL_INTR_CNTL);
 	ext_int_ctrl &= ~PDM_DMA_INTR_MASK;
-	acp62_writel(ext_int_ctrl, acp_base + ACP_EXTERNAL_INTR_CNTL);
+	acp63_writel(ext_int_ctrl, acp_base + ACP_EXTERNAL_INTR_CNTL);
 }
 
-static bool acp62_check_pdm_dma_status(void __iomem *acp_base)
+static bool acp63_check_pdm_dma_status(void __iomem *acp_base)
 {
 	bool pdm_dma_status;
 	u32 pdm_enable, pdm_dma_enable;
 
 	pdm_dma_status = false;
-	pdm_enable = acp62_readl(acp_base + ACP_WOV_PDM_ENABLE);
-	pdm_dma_enable = acp62_readl(acp_base + ACP_WOV_PDM_DMA_ENABLE);
+	pdm_enable = acp63_readl(acp_base + ACP_WOV_PDM_ENABLE);
+	pdm_dma_enable = acp63_readl(acp_base + ACP_WOV_PDM_DMA_ENABLE);
 	if ((pdm_enable & ACP_PDM_ENABLE) && (pdm_dma_enable & ACP_PDM_DMA_EN_STATUS))
 		pdm_dma_status = true;
 
 	return pdm_dma_status;
 }
 
-static int acp62_start_pdm_dma(void __iomem *acp_base)
+static int acp63_start_pdm_dma(void __iomem *acp_base)
 {
 	u32 pdm_enable;
 	u32 pdm_dma_enable;
@@ -100,12 +100,12 @@ static int acp62_start_pdm_dma(void __iomem *acp_base)
 	pdm_enable = 0x01;
 	pdm_dma_enable  = 0x01;
 
-	acp62_enable_pdm_clock(acp_base);
-	acp62_writel(pdm_enable, acp_base + ACP_WOV_PDM_ENABLE);
-	acp62_writel(pdm_dma_enable, acp_base + ACP_WOV_PDM_DMA_ENABLE);
+	acp63_enable_pdm_clock(acp_base);
+	acp63_writel(pdm_enable, acp_base + ACP_WOV_PDM_ENABLE);
+	acp63_writel(pdm_dma_enable, acp_base + ACP_WOV_PDM_DMA_ENABLE);
 	timeout = 0;
 	while (++timeout < ACP_COUNTER) {
-		pdm_dma_enable = acp62_readl(acp_base + ACP_WOV_PDM_DMA_ENABLE);
+		pdm_dma_enable = acp63_readl(acp_base + ACP_WOV_PDM_DMA_ENABLE);
 		if ((pdm_dma_enable & 0x02) == ACP_PDM_DMA_EN_STATUS)
 			return 0;
 		udelay(DELAY_US);
@@ -113,7 +113,7 @@ static int acp62_start_pdm_dma(void __iomem *acp_base)
 	return -ETIMEDOUT;
 }
 
-static int acp62_stop_pdm_dma(void __iomem *acp_base)
+static int acp63_stop_pdm_dma(void __iomem *acp_base)
 {
 	u32 pdm_enable, pdm_dma_enable;
 	int timeout;
@@ -121,14 +121,14 @@ static int acp62_stop_pdm_dma(void __iomem *acp_base)
 	pdm_enable = 0x00;
 	pdm_dma_enable  = 0x00;
 
-	pdm_enable = acp62_readl(acp_base + ACP_WOV_PDM_ENABLE);
-	pdm_dma_enable = acp62_readl(acp_base + ACP_WOV_PDM_DMA_ENABLE);
+	pdm_enable = acp63_readl(acp_base + ACP_WOV_PDM_ENABLE);
+	pdm_dma_enable = acp63_readl(acp_base + ACP_WOV_PDM_DMA_ENABLE);
 	if (pdm_dma_enable & 0x01) {
 		pdm_dma_enable = 0x02;
-		acp62_writel(pdm_dma_enable, acp_base + ACP_WOV_PDM_DMA_ENABLE);
+		acp63_writel(pdm_dma_enable, acp_base + ACP_WOV_PDM_DMA_ENABLE);
 		timeout = 0;
 		while (++timeout < ACP_COUNTER) {
-			pdm_dma_enable = acp62_readl(acp_base + ACP_WOV_PDM_DMA_ENABLE);
+			pdm_dma_enable = acp63_readl(acp_base + ACP_WOV_PDM_DMA_ENABLE);
 			if ((pdm_dma_enable & 0x02) == 0x00)
 				break;
 			udelay(DELAY_US);
@@ -138,13 +138,13 @@ static int acp62_stop_pdm_dma(void __iomem *acp_base)
 	}
 	if (pdm_enable == ACP_PDM_ENABLE) {
 		pdm_enable = ACP_PDM_DISABLE;
-		acp62_writel(pdm_enable, acp_base + ACP_WOV_PDM_ENABLE);
+		acp63_writel(pdm_enable, acp_base + ACP_WOV_PDM_ENABLE);
 	}
-	acp62_writel(0x01, acp_base + ACP_WOV_PDM_FIFO_FLUSH);
+	acp63_writel(0x01, acp_base + ACP_WOV_PDM_FIFO_FLUSH);
 	return 0;
 }
 
-static void acp62_config_dma(struct pdm_stream_instance *rtd, int direction)
+static void acp63_config_dma(struct pdm_stream_instance *rtd, int direction)
 {
 	u16 page_idx;
 	u32 low, high, val;
@@ -154,24 +154,24 @@ static void acp62_config_dma(struct pdm_stream_instance *rtd, int direction)
 	val = PDM_PTE_OFFSET;
 
 	/* Group Enable */
-	acp62_writel(ACP_SRAM_PTE_OFFSET | BIT(31), rtd->acp62_base +
+	acp63_writel(ACP_SRAM_PTE_OFFSET | BIT(31), rtd->acp63_base +
 		     ACPAXI2AXI_ATU_BASE_ADDR_GRP_1);
-	acp62_writel(PAGE_SIZE_4K_ENABLE, rtd->acp62_base +
+	acp63_writel(PAGE_SIZE_4K_ENABLE, rtd->acp63_base +
 		     ACPAXI2AXI_ATU_PAGE_SIZE_GRP_1);
 	for (page_idx = 0; page_idx < rtd->num_pages; page_idx++) {
 		/* Load the low address of page int ACP SRAM through SRBM */
 		low = lower_32_bits(addr);
 		high = upper_32_bits(addr);
 
-		acp62_writel(low, rtd->acp62_base + ACP_SCRATCH_REG_0 + val);
+		acp63_writel(low, rtd->acp63_base + ACP_SCRATCH_REG_0 + val);
 		high |= BIT(31);
-		acp62_writel(high, rtd->acp62_base + ACP_SCRATCH_REG_0 + val + 4);
+		acp63_writel(high, rtd->acp63_base + ACP_SCRATCH_REG_0 + val + 4);
 		val += 8;
 		addr += PAGE_SIZE;
 	}
 }
 
-static int acp62_pdm_dma_open(struct snd_soc_component *component,
+static int acp63_pdm_dma_open(struct snd_soc_component *component,
 			      struct snd_pcm_substream *substream)
 {
 	struct snd_pcm_runtime *runtime;
@@ -186,7 +186,7 @@ static int acp62_pdm_dma_open(struct snd_soc_component *component,
 		return -EINVAL;
 
 	if (substream->stream == SNDRV_PCM_STREAM_CAPTURE)
-		runtime->hw = acp62_pdm_hardware_capture;
+		runtime->hw = acp63_pdm_hardware_capture;
 
 	ret = snd_pcm_hw_constraint_integer(runtime,
 					    SNDRV_PCM_HW_PARAM_PERIODS);
@@ -196,17 +196,17 @@ static int acp62_pdm_dma_open(struct snd_soc_component *component,
 		return ret;
 	}
 
-	acp62_enable_pdm_interrupts(adata->acp62_base);
+	acp63_enable_pdm_interrupts(adata->acp63_base);
 
 	if (substream->stream == SNDRV_PCM_STREAM_CAPTURE)
 		adata->capture_stream = substream;
 
-	pdm_data->acp62_base = adata->acp62_base;
+	pdm_data->acp63_base = adata->acp63_base;
 	runtime->private_data = pdm_data;
 	return ret;
 }
 
-static int acp62_pdm_dma_hw_params(struct snd_soc_component *component,
+static int acp63_pdm_dma_hw_params(struct snd_soc_component *component,
 				   struct snd_pcm_substream *substream,
 				   struct snd_pcm_hw_params *params)
 {
@@ -220,26 +220,26 @@ static int acp62_pdm_dma_hw_params(struct snd_soc_component *component,
 	period_bytes = params_period_bytes(params);
 	rtd->dma_addr = substream->runtime->dma_addr;
 	rtd->num_pages = (PAGE_ALIGN(size) >> PAGE_SHIFT);
-	acp62_config_dma(rtd, substream->stream);
-	acp62_init_pdm_ring_buffer(PDM_MEM_WINDOW_START, size,
-				   period_bytes, rtd->acp62_base);
+	acp63_config_dma(rtd, substream->stream);
+	acp63_init_pdm_ring_buffer(PDM_MEM_WINDOW_START, size,
+				   period_bytes, rtd->acp63_base);
 	return 0;
 }
 
-static u64 acp62_pdm_get_byte_count(struct pdm_stream_instance *rtd,
+static u64 acp63_pdm_get_byte_count(struct pdm_stream_instance *rtd,
 				    int direction)
 {
 	u32 high, low;
 	u64 byte_count;
 
-	high = acp62_readl(rtd->acp62_base + ACP_WOV_RX_LINEARPOSITIONCNTR_HIGH);
+	high = acp63_readl(rtd->acp63_base + ACP_WOV_RX_LINEARPOSITIONCNTR_HIGH);
 	byte_count = high;
-	low = acp62_readl(rtd->acp62_base + ACP_WOV_RX_LINEARPOSITIONCNTR_LOW);
+	low = acp63_readl(rtd->acp63_base + ACP_WOV_RX_LINEARPOSITIONCNTR_LOW);
 	byte_count = (byte_count << 32) | low;
 	return byte_count;
 }
 
-static snd_pcm_uframes_t acp62_pdm_dma_pointer(struct snd_soc_component *comp,
+static snd_pcm_uframes_t acp63_pdm_dma_pointer(struct snd_soc_component *comp,
 					       struct snd_pcm_substream *stream)
 {
 	struct pdm_stream_instance *rtd;
@@ -249,14 +249,14 @@ static snd_pcm_uframes_t acp62_pdm_dma_pointer(struct snd_soc_component *comp,
 	rtd = stream->runtime->private_data;
 	buffersize = frames_to_bytes(stream->runtime,
 				     stream->runtime->buffer_size);
-	bytescount = acp62_pdm_get_byte_count(rtd, stream->stream);
+	bytescount = acp63_pdm_get_byte_count(rtd, stream->stream);
 	if (bytescount > rtd->bytescount)
 		bytescount -= rtd->bytescount;
 	pos = do_div(bytescount, buffersize);
 	return bytes_to_frames(stream->runtime, pos);
 }
 
-static int acp62_pdm_dma_new(struct snd_soc_component *component,
+static int acp63_pdm_dma_new(struct snd_soc_component *component,
 			     struct snd_soc_pcm_runtime *rtd)
 {
 	struct device *parent = component->dev->parent;
@@ -266,19 +266,19 @@ static int acp62_pdm_dma_new(struct snd_soc_component *component,
 	return 0;
 }
 
-static int acp62_pdm_dma_close(struct snd_soc_component *component,
+static int acp63_pdm_dma_close(struct snd_soc_component *component,
 			       struct snd_pcm_substream *substream)
 {
 	struct pdm_dev_data *adata = dev_get_drvdata(component->dev);
 	struct snd_pcm_runtime *runtime = substream->runtime;
 
-	acp62_disable_pdm_interrupts(adata->acp62_base);
+	acp63_disable_pdm_interrupts(adata->acp63_base);
 	adata->capture_stream = NULL;
 	kfree(runtime->private_data);
 	return 0;
 }
 
-static int acp62_pdm_dai_trigger(struct snd_pcm_substream *substream,
+static int acp63_pdm_dai_trigger(struct snd_pcm_substream *substream,
 				 int cmd, struct snd_soc_dai *dai)
 {
 	struct pdm_stream_instance *rtd;
@@ -299,20 +299,20 @@ static int acp62_pdm_dai_trigger(struct snd_pcm_substream *substream,
 	case SNDRV_PCM_TRIGGER_START:
 	case SNDRV_PCM_TRIGGER_RESUME:
 	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
-		acp62_writel(ch_mask, rtd->acp62_base + ACP_WOV_PDM_NO_OF_CHANNELS);
-		acp62_writel(PDM_DECIMATION_FACTOR, rtd->acp62_base +
+		acp63_writel(ch_mask, rtd->acp63_base + ACP_WOV_PDM_NO_OF_CHANNELS);
+		acp63_writel(PDM_DECIMATION_FACTOR, rtd->acp63_base +
 			     ACP_WOV_PDM_DECIMATION_FACTOR);
-		rtd->bytescount = acp62_pdm_get_byte_count(rtd, substream->stream);
-		pdm_status = acp62_check_pdm_dma_status(rtd->acp62_base);
+		rtd->bytescount = acp63_pdm_get_byte_count(rtd, substream->stream);
+		pdm_status = acp63_check_pdm_dma_status(rtd->acp63_base);
 		if (!pdm_status)
-			ret = acp62_start_pdm_dma(rtd->acp62_base);
+			ret = acp63_start_pdm_dma(rtd->acp63_base);
 		break;
 	case SNDRV_PCM_TRIGGER_STOP:
 	case SNDRV_PCM_TRIGGER_SUSPEND:
 	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
-		pdm_status = acp62_check_pdm_dma_status(rtd->acp62_base);
+		pdm_status = acp63_check_pdm_dma_status(rtd->acp63_base);
 		if (pdm_status)
-			ret = acp62_stop_pdm_dma(rtd->acp62_base);
+			ret = acp63_stop_pdm_dma(rtd->acp63_base);
 		break;
 	default:
 		ret = -EINVAL;
@@ -321,11 +321,11 @@ static int acp62_pdm_dai_trigger(struct snd_pcm_substream *substream,
 	return ret;
 }
 
-static const struct snd_soc_dai_ops acp62_pdm_dai_ops = {
-	.trigger   = acp62_pdm_dai_trigger,
+static const struct snd_soc_dai_ops acp63_pdm_dai_ops = {
+	.trigger   = acp63_pdm_dai_trigger,
 };
 
-static struct snd_soc_dai_driver acp62_pdm_dai_driver = {
+static struct snd_soc_dai_driver acp63_pdm_dai_driver = {
 	.name = "acp_ps_pdm_dma.0",
 	.capture = {
 		.rates = SNDRV_PCM_RATE_48000,
@@ -335,19 +335,19 @@ static struct snd_soc_dai_driver acp62_pdm_dai_driver = {
 		.rate_min = 48000,
 		.rate_max = 48000,
 	},
-	.ops = &acp62_pdm_dai_ops,
+	.ops = &acp63_pdm_dai_ops,
 };
 
-static const struct snd_soc_component_driver acp62_pdm_component = {
+static const struct snd_soc_component_driver acp63_pdm_component = {
 	.name		= DRV_NAME,
-	.open		= acp62_pdm_dma_open,
-	.close		= acp62_pdm_dma_close,
-	.hw_params	= acp62_pdm_dma_hw_params,
-	.pointer	= acp62_pdm_dma_pointer,
-	.pcm_construct	= acp62_pdm_dma_new,
+	.open		= acp63_pdm_dma_open,
+	.close		= acp63_pdm_dma_close,
+	.hw_params	= acp63_pdm_dma_hw_params,
+	.pointer	= acp63_pdm_dma_pointer,
+	.pcm_construct	= acp63_pdm_dma_new,
 };
 
-static int acp62_pdm_audio_probe(struct platform_device *pdev)
+static int acp63_pdm_audio_probe(struct platform_device *pdev)
 {
 	struct resource *res;
 	struct pdm_dev_data *adata;
@@ -363,16 +363,16 @@ static int acp62_pdm_audio_probe(struct platform_device *pdev)
 	if (!adata)
 		return -ENOMEM;
 
-	adata->acp62_base = devm_ioremap(&pdev->dev, res->start, resource_size(res));
-	if (!adata->acp62_base)
+	adata->acp63_base = devm_ioremap(&pdev->dev, res->start, resource_size(res));
+	if (!adata->acp63_base)
 		return -ENOMEM;
 
 	adata->capture_stream = NULL;
 
 	dev_set_drvdata(&pdev->dev, adata);
 	status = devm_snd_soc_register_component(&pdev->dev,
-						 &acp62_pdm_component,
-						 &acp62_pdm_dai_driver, 1);
+						 &acp63_pdm_component,
+						 &acp63_pdm_dai_driver, 1);
 	if (status) {
 		dev_err(&pdev->dev, "Fail to register acp pdm dai\n");
 
@@ -385,13 +385,13 @@ static int acp62_pdm_audio_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int acp62_pdm_audio_remove(struct platform_device *pdev)
+static int acp63_pdm_audio_remove(struct platform_device *pdev)
 {
 	pm_runtime_disable(&pdev->dev);
 	return 0;
 }
 
-static int __maybe_unused acp62_pdm_resume(struct device *dev)
+static int __maybe_unused acp63_pdm_resume(struct device *dev)
 {
 	struct pdm_dev_data *adata;
 	struct snd_pcm_runtime *runtime;
@@ -404,47 +404,47 @@ static int __maybe_unused acp62_pdm_resume(struct device *dev)
 		rtd = runtime->private_data;
 		period_bytes = frames_to_bytes(runtime, runtime->period_size);
 		buffer_len = frames_to_bytes(runtime, runtime->buffer_size);
-		acp62_config_dma(rtd, SNDRV_PCM_STREAM_CAPTURE);
-		acp62_init_pdm_ring_buffer(PDM_MEM_WINDOW_START, buffer_len,
-					   period_bytes, adata->acp62_base);
+		acp63_config_dma(rtd, SNDRV_PCM_STREAM_CAPTURE);
+		acp63_init_pdm_ring_buffer(PDM_MEM_WINDOW_START, buffer_len,
+					   period_bytes, adata->acp63_base);
 	}
-	acp62_enable_pdm_interrupts(adata->acp62_base);
+	acp63_enable_pdm_interrupts(adata->acp63_base);
 	return 0;
 }
 
-static int __maybe_unused acp62_pdm_suspend(struct device *dev)
+static int __maybe_unused acp63_pdm_suspend(struct device *dev)
 {
 	struct pdm_dev_data *adata;
 
 	adata = dev_get_drvdata(dev);
-	acp62_disable_pdm_interrupts(adata->acp62_base);
+	acp63_disable_pdm_interrupts(adata->acp63_base);
 	return 0;
 }
 
-static int __maybe_unused acp62_pdm_runtime_resume(struct device *dev)
+static int __maybe_unused acp63_pdm_runtime_resume(struct device *dev)
 {
 	struct pdm_dev_data *adata;
 
 	adata = dev_get_drvdata(dev);
-	acp62_enable_pdm_interrupts(adata->acp62_base);
+	acp63_enable_pdm_interrupts(adata->acp63_base);
 	return 0;
 }
 
-static const struct dev_pm_ops acp62_pdm_pm_ops = {
-	SET_RUNTIME_PM_OPS(acp62_pdm_suspend, acp62_pdm_runtime_resume, NULL)
-	SET_SYSTEM_SLEEP_PM_OPS(acp62_pdm_suspend, acp62_pdm_resume)
+static const struct dev_pm_ops acp63_pdm_pm_ops = {
+	SET_RUNTIME_PM_OPS(acp63_pdm_suspend, acp63_pdm_runtime_resume, NULL)
+	SET_SYSTEM_SLEEP_PM_OPS(acp63_pdm_suspend, acp63_pdm_resume)
 };
 
-static struct platform_driver acp62_pdm_dma_driver = {
-	.probe = acp62_pdm_audio_probe,
-	.remove = acp62_pdm_audio_remove,
+static struct platform_driver acp63_pdm_dma_driver = {
+	.probe = acp63_pdm_audio_probe,
+	.remove = acp63_pdm_audio_remove,
 	.driver = {
 		.name = "acp_ps_pdm_dma",
-		.pm = &acp62_pdm_pm_ops,
+		.pm = &acp63_pdm_pm_ops,
 	},
 };
 
-module_platform_driver(acp62_pdm_dma_driver);
+module_platform_driver(acp63_pdm_dma_driver);
 
 MODULE_AUTHOR("Syed.SabaKareem@amd.com");
 MODULE_DESCRIPTION("AMD PINK SARDINE PDM Driver");
-- 
2.25.1

