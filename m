Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A76773E13B
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 15:56:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230231AbjFZN4u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 09:56:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230268AbjFZN4k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 09:56:40 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2084.outbound.protection.outlook.com [40.107.223.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FF0410EB
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 06:56:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O+LY1Ykl5CWAdNAs9NFwBk+qmN0Sz8G3XKyT829eI/6F88TKJmHPbD7QNH6RsjIj4zJmXiJNd4hFDRkLLo9jjiSw0kuZluGwH2AXzHB/KnR+hEX/Tlf69etAhp1DBvdpWdV+d54gFpVLzyFynBfPYWKmMGuZ80QXsnBAwDpbgJ0uzNA4v8CxVlajxnA6JCKG0DlBQqiUCATT426aEKvEBOgVDnBBYTMUPkuZ97983TffN1KCSCL5RkS9cGP9HCm3GOpJss4lWotweJAcGej14mNmdYkgGp3q8luRf4wZjjEA2lrT9w7oHlynUuJmEiwotfED38RiQtPDRlwq65wnRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nZfTcuyRz0GAm+oLVWQWD9MJakVXKdCxvNhux3VcJ5o=;
 b=kiO0nyejWa9JOEyJpJyQ2ab/VyPpNCy4XxFbnd1BsXAUBe90+uMe/hpISIxAy3ewKyuyQ+6xuhEOJvz47YlSGiWnhaGVsmKRhaQoxJ/YDLgQbmy31o6zVrTd8nD1DGgz2/zWl0zADferg4yghoowUTFPr2kq12kTmZp2CLapAPj1qNsbQu0ZxttbtrIvR+JTcVbdFNBMuX0sZ3pm6V4djGA4CfBd5qEM2Z69ACNg5su3y/LOY1unrwWlLY1fzzkCIYlnpzXWh00JOh8f8jOQwqw/1Pehq4kELKmXB2FeRKHxIFoF693vh7JErDzW52SSiHMMCe3IuatuX35kAoj37Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nZfTcuyRz0GAm+oLVWQWD9MJakVXKdCxvNhux3VcJ5o=;
 b=VgGfDsRi6DqSeonkNQKe7gzcEqX8QMIhIHHtUGPWVTgThB2WFcFWCrnw21Y9x9fQwvSFUGFVjKPFVMmrjIyzSkSxHR92BRZmJoB/nvnT70ySpbgMtAStFZcs9ClNeJAVebk9kop/b+xjLkJME6H5DGaLxORNNOC9ZyBU7sMWGyY=
Received: from BN0PR04CA0009.namprd04.prod.outlook.com (2603:10b6:408:ee::14)
 by MW4PR12MB7000.namprd12.prod.outlook.com (2603:10b6:303:20a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Mon, 26 Jun
 2023 13:56:21 +0000
Received: from BN8NAM11FT035.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ee:cafe::69) by BN0PR04CA0009.outlook.office365.com
 (2603:10b6:408:ee::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.33 via Frontend
 Transport; Mon, 26 Jun 2023 13:56:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT035.mail.protection.outlook.com (10.13.177.116) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6500.47 via Frontend Transport; Mon, 26 Jun 2023 13:56:20 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Mon, 26 Jun
 2023 08:56:20 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Mon, 26 Jun
 2023 08:56:20 -0500
Received: from amd-B450M-DS3H.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.23 via Frontend
 Transport; Mon, 26 Jun 2023 08:56:15 -0500
From:   Syed Saba Kareem <Syed.SabaKareem@amd.com>
To:     <broonie@kernel.org>, <alsa-devel@alsa-project.org>
CC:     <Vijendar.Mukunda@amd.com>, <Basavaraj.Hiregoudar@amd.com>,
        <Sunil-kumar.Dommati@amd.com>,
        Syed Saba Kareem <Syed.SabaKareem@amd.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        V sujith kumar Reddy <Vsujithkumar.Reddy@amd.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Venkata Prasad Potturu <venkataprasad.potturu@amd.com>,
        Ajit Kumar Pandey <AjitKumar.Pandey@amd.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 03/10] ASoC: amd: acp: remove the redundant acp enable/disable interrupts functions
Date:   Mon, 26 Jun 2023 19:25:07 +0530
Message-ID: <20230626135515.1252063-4-Syed.SabaKareem@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230626135515.1252063-1-Syed.SabaKareem@amd.com>
References: <20230626135515.1252063-1-Syed.SabaKareem@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT035:EE_|MW4PR12MB7000:EE_
X-MS-Office365-Filtering-Correlation-Id: b4fea4b4-bdd7-45ce-a977-08db764d1f05
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Hr1mbeauK4LhD4Af51EiMs0vjxBP5tjVj6MW3LGqanwDHllNIzG+NLdJ4SiDbLIcKm7aDEv+LIQ9Oig99U2KzrxKrKflQwDUR3rNG4oy36kuD0/AWt0elPqoS5uN2LRy+VddiaMROU//zPQ/DHHVkWGKDjc6bD5sFViCiIqr6rrC06CplBJREhlzzMNsD7b3P9pv+fSO8VYmtDzxDKQjwciDTZuItinnvykv/3nnwoWxD7m13cBVsM/6F8KddjhACXWJ2WWS6EHYWdSWHN60Ct35ePHpkicmNNqBCOaMOrRc52Jz4npjvZqip+Ggsb/MlKfz/xhKCV48hVEIlKU/0laKtfQ8P2HDG4KTmvGudba1XwawU4Dhwh782Sy+R2tRW0UYVD8W83mvLFp6Jh7iTIWkF+SDgd1+x/RABTRi8+6mk6w/d8Gz0y00CMUY+mLXpP8aZDnRIip2yD+UtfFudbL/RWvPRBqTu+RDKrYhnBDyRzb7Lv7R4iwHnZ/wb3PC45neSPVZAzkoXXsZF2MWECnYgE5ggEPcz61sH5YY84iyeyJvaekIeur9xxzydBT00uCbvjyoV7EQl6JWCMClrH3PyqBeNRUIacEEFV2LVc+Z3ARDZKehH7eVX1iVgOVXSQ7OIovIdVlibtDFmVejRy/xw5dCxC+uK6AqELtcuPLJQFMy9X5SBjki0w7nOyj608Jw4cWhjdG2926P5+0G4sDPsbU3k/UGONiz5rWFRbCIaVIdepgnsCUmFE2e/XbJtp3kQ44QCvfH+Q1SQc7qaQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(346002)(396003)(376002)(136003)(39860400002)(451199021)(46966006)(40470700004)(36840700001)(36860700001)(82310400005)(47076005)(478600001)(6666004)(54906003)(7696005)(2616005)(426003)(110136005)(83380400001)(336012)(26005)(186003)(1076003)(2906002)(5660300002)(70206006)(40460700003)(36756003)(356005)(4326008)(40480700001)(82740400003)(70586007)(81166007)(316002)(86362001)(8936002)(8676002)(41300700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2023 13:56:20.7612
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b4fea4b4-bdd7-45ce-a977-08db764d1f05
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT035.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7000
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of having individual acp enable/disable interrupts functions for
each platform, implement common place holder to handle the same for all
AMD platforms.

Signed-off-by: Syed Saba Kareem <Syed.SabaKareem@amd.com>
---
 sound/soc/amd/acp/Kconfig             |  3 ++-
 sound/soc/amd/acp/acp-legacy-common.c | 21 +++++++++++++++++++++
 sound/soc/amd/acp/acp-rembrandt.c     | 24 ++----------------------
 sound/soc/amd/acp/acp-renoir.c        | 23 ++---------------------
 sound/soc/amd/acp/amd.h               |  2 ++
 5 files changed, 29 insertions(+), 44 deletions(-)

diff --git a/sound/soc/amd/acp/Kconfig b/sound/soc/amd/acp/Kconfig
index 6a369e5d825c..3aca8109475b 100644
--- a/sound/soc/amd/acp/Kconfig
+++ b/sound/soc/amd/acp/Kconfig
@@ -31,7 +31,6 @@ config SND_SOC_AMD_ACP_PCM
 config SND_SOC_AMD_ACP_PCI
 	tristate "AMD ACP PCI Driver Support"
 	depends on X86 && PCI
-	select SND_SOC_AMD_ACP_LEGACY_COMMON
 	help
 	  This options enables generic PCI driver for ACP device.
 
@@ -40,6 +39,7 @@ config SND_AMD_ASOC_RENOIR
 	select SND_SOC_AMD_ACP_PCM
 	select SND_SOC_AMD_ACP_I2S
 	select SND_SOC_AMD_ACP_PDM
+	select SND_SOC_AMD_ACP_LEGACY_COMMON
 	depends on X86 && PCI
 	help
 	  This option enables Renoir I2S support on AMD platform.
@@ -49,6 +49,7 @@ config SND_AMD_ASOC_REMBRANDT
 	select SND_SOC_AMD_ACP_PCM
 	select SND_SOC_AMD_ACP_I2S
 	select SND_SOC_AMD_ACP_PDM
+	select SND_SOC_AMD_ACP_LEGACY_COMMON
 	depends on X86 && PCI
 	help
 	  This option enables Rembrandt I2S support on AMD platform.
diff --git a/sound/soc/amd/acp/acp-legacy-common.c b/sound/soc/amd/acp/acp-legacy-common.c
index 4302d8db88a4..45a45d002915 100644
--- a/sound/soc/amd/acp/acp-legacy-common.c
+++ b/sound/soc/amd/acp/acp-legacy-common.c
@@ -16,6 +16,27 @@
 #include <linux/pci.h>
 #include <linux/export.h>
 
+void acp_enable_interrupts(struct acp_dev_data *adata)
+{
+	struct acp_resource *rsrc = adata->rsrc;
+	u32 ext_intr_ctrl;
+
+	writel(0x01, ACP_EXTERNAL_INTR_ENB(adata));
+	ext_intr_ctrl = readl(ACP_EXTERNAL_INTR_CNTL(adata, rsrc->irqp_used));
+	ext_intr_ctrl |= ACP_ERROR_MASK;
+	writel(ext_intr_ctrl, ACP_EXTERNAL_INTR_CNTL(adata, rsrc->irqp_used));
+}
+EXPORT_SYMBOL_NS_GPL(acp_enable_interrupts, SND_SOC_ACP_COMMON);
+
+void acp_disable_interrupts(struct acp_dev_data *adata)
+{
+	struct acp_resource *rsrc = adata->rsrc;
+
+	writel(ACP_EXT_INTR_STAT_CLEAR_MASK, ACP_EXTERNAL_INTR_STAT(adata, rsrc->irqp_used));
+	writel(0x00, ACP_EXTERNAL_INTR_ENB(adata));
+}
+EXPORT_SYMBOL_NS_GPL(acp_disable_interrupts, SND_SOC_ACP_COMMON);
+
 static int acp_power_on(struct acp_chip_info *chip)
 {
 	u32 val, acp_pgfsm_stat_reg, acp_pgfsm_ctrl_reg;
diff --git a/sound/soc/amd/acp/acp-rembrandt.c b/sound/soc/amd/acp/acp-rembrandt.c
index 82a1bf2ddfc6..ea3d4aadc8e1 100644
--- a/sound/soc/amd/acp/acp-rembrandt.c
+++ b/sound/soc/amd/acp/acp-rembrandt.c
@@ -185,26 +185,6 @@ static int acp6x_master_clock_generate(struct device *dev)
 	return 0;
 }
 
-static void acp6x_enable_interrupts(struct acp_dev_data *adata)
-{
-	struct acp_resource *rsrc = adata->rsrc;
-	u32 ext_intr_ctrl;
-
-	writel(0x01, ACP_EXTERNAL_INTR_ENB(adata));
-	ext_intr_ctrl = readl(ACP_EXTERNAL_INTR_CNTL(adata, rsrc->irqp_used));
-	ext_intr_ctrl |= ACP_ERROR_MASK;
-	writel(ext_intr_ctrl, ACP_EXTERNAL_INTR_CNTL(adata, rsrc->irqp_used));
-}
-
-static void acp6x_disable_interrupts(struct acp_dev_data *adata)
-{
-	struct acp_resource *rsrc = adata->rsrc;
-
-	writel(ACP_EXT_INTR_STAT_CLEAR_MASK,
-	       ACP_EXTERNAL_INTR_STAT(adata, rsrc->irqp_used));
-	writel(0x00, ACP_EXTERNAL_INTR_ENB(adata));
-}
-
 static int rembrandt_audio_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -254,7 +234,7 @@ static int rembrandt_audio_probe(struct platform_device *pdev)
 
 	dev_set_drvdata(dev, adata);
 	acp6x_master_clock_generate(dev);
-	acp6x_enable_interrupts(adata);
+	acp_enable_interrupts(adata);
 	acp_platform_register(dev);
 
 	return 0;
@@ -265,7 +245,7 @@ static void rembrandt_audio_remove(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct acp_dev_data *adata = dev_get_drvdata(dev);
 
-	acp6x_disable_interrupts(adata);
+	acp_disable_interrupts(adata);
 	acp_platform_unregister(dev);
 }
 
diff --git a/sound/soc/amd/acp/acp-renoir.c b/sound/soc/amd/acp/acp-renoir.c
index a73fd70171c1..1899658ab25d 100644
--- a/sound/soc/amd/acp/acp-renoir.c
+++ b/sound/soc/amd/acp/acp-renoir.c
@@ -140,25 +140,6 @@ static struct snd_soc_dai_driver acp_renoir_dai[] = {
 },
 };
 
-static void acp3x_enable_interrupts(struct acp_dev_data *adata)
-{
-	struct acp_resource *rsrc = adata->rsrc;
-	u32 ext_intr_ctrl;
-
-	writel(0x01, ACP_EXTERNAL_INTR_ENB(adata));
-	ext_intr_ctrl = readl(ACP_EXTERNAL_INTR_CNTL(adata, rsrc->irqp_used));
-	ext_intr_ctrl |= ACP_ERROR_MASK;
-	writel(ext_intr_ctrl, ACP_EXTERNAL_INTR_CNTL(adata, rsrc->irqp_used));
-}
-
-static void acp3x_disable_interrupts(struct acp_dev_data *adata)
-{
-	struct acp_resource *rsrc = adata->rsrc;
-
-	writel(ACP_EXT_INTR_STAT_CLEAR_MASK,
-	       ACP_EXTERNAL_INTR_STAT(adata, rsrc->irqp_used));
-	writel(0x00, ACP_EXTERNAL_INTR_ENB(adata));
-}
 
 static int renoir_audio_probe(struct platform_device *pdev)
 {
@@ -207,7 +188,7 @@ static int renoir_audio_probe(struct platform_device *pdev)
 	acp_machine_select(adata);
 
 	dev_set_drvdata(dev, adata);
-	acp3x_enable_interrupts(adata);
+	acp_enable_interrupts(adata);
 	acp_platform_register(dev);
 
 	return 0;
@@ -218,7 +199,7 @@ static void renoir_audio_remove(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct acp_dev_data *adata = dev_get_drvdata(dev);
 
-	acp3x_disable_interrupts(adata);
+	acp_disable_interrupts(adata);
 	acp_platform_unregister(dev);
 }
 
diff --git a/sound/soc/amd/acp/amd.h b/sound/soc/amd/acp/amd.h
index 96bd87290eee..0d8c0febbbfc 100644
--- a/sound/soc/amd/acp/amd.h
+++ b/sound/soc/amd/acp/amd.h
@@ -192,6 +192,8 @@ int smn_write(struct pci_dev *dev, u32 smn_addr, u32 data);
 
 int acp_init(struct acp_chip_info *chip);
 int acp_deinit(void __iomem *base);
+void acp_enable_interrupts(struct acp_dev_data *adata);
+void acp_disable_interrupts(struct acp_dev_data *adata);
 /* Machine configuration */
 int snd_amd_acp_find_config(struct pci_dev *pci);
 
-- 
2.25.1

