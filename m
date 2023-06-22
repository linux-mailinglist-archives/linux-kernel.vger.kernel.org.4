Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABEEB73A4C6
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 17:26:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232420AbjFVP0G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 11:26:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232396AbjFVPZ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 11:25:59 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2048.outbound.protection.outlook.com [40.107.92.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5B811BD1
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 08:25:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ectumxovtPGFn2ABv6teSi0Axgs+1vlHpmTDkumNRWmm3LQGAN1BpXtukwAlza4sCq27AUxNafuQq13nGzzbj5eb7VHV6+5OOHTI04JnP2RCTqfCDkD2WeF0lCRN/VbPZ2fiXjHfAbGpUn1CBK4O5ij0UDzxdD7NoB9xfZuqEF20xSAKvSKfG5P2tmgNCE+nwU8jJN1tbFJqT2ipFrcLbuiYSF35bK8vJetju56k5bDkN1Nk2D8UlwiWmvrMhcIM1tVgpOnYntikF0GolLbfQd5NfnySJIQal3u3d1KUqpHEtBUOISScufQns2tBtpZNGjWwebUnIOSLrPQMnCia3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lyb4oUKPqZp6YQRg2tTH63rwDvDI64BEIOp/IMCkntM=;
 b=OA2XWmQu3WDe6Z+gfn15Lqgu+Ichwu5Qm9uW9VHegbTukWyHsUXYywA72cdHpKMqlu1OyzO4BSl4b7Pqr2IcbXjatVSGmKmbDlQLkHQpHcAxPNNCQ6xyDLY0dw45aCwdU0jhDsM2hqqIugrkm5ArBbvN/1kYUXIfNlAjD89VYN0Ytk3ZhaVbnaF6nCbkx8ERloV5+kzyM28pN1shLkekXCw/s92ibRIVfccDKYeVzba2izv1b3HEvhYEssd0DCn25wqLpTXy/bUufGLUZyho66MOoHFlvYtsYy6SXsc0P9SkcIdvEGG21RBXgbU8mvWZKqH4ZxOWV8EYMwy83SpJrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lyb4oUKPqZp6YQRg2tTH63rwDvDI64BEIOp/IMCkntM=;
 b=eij3R0BTPRNqJGHio7G/TxljvihpTKM/n/x2QCEfa+fc2yxEm8Ww3LJqWRXOENu4euAcjlCC+zCcdvSa0fvfUpoD0hcdm0rOzDCZJ/861Gk+x7EgsaVBFmfb22RvDjkm0We5SYWl/GVekhiclUB/cvd9BjHo+0p4Qy8AiZ2N9fE=
Received: from SA1PR02CA0019.namprd02.prod.outlook.com (2603:10b6:806:2cf::12)
 by PH0PR12MB7791.namprd12.prod.outlook.com (2603:10b6:510:280::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23; Thu, 22 Jun
 2023 15:25:46 +0000
Received: from SA2PEPF00001508.namprd04.prod.outlook.com
 (2603:10b6:806:2cf:cafe::57) by SA1PR02CA0019.outlook.office365.com
 (2603:10b6:806:2cf::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24 via Frontend
 Transport; Thu, 22 Jun 2023 15:25:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SA2PEPF00001508.mail.protection.outlook.com (10.167.242.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6521.19 via Frontend Transport; Thu, 22 Jun 2023 15:25:46 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Thu, 22 Jun
 2023 10:25:45 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Thu, 22 Jun
 2023 10:25:45 -0500
Received: from amd-B450M-DS3H.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.23 via Frontend
 Transport; Thu, 22 Jun 2023 10:25:41 -0500
From:   Syed Saba Kareem <Syed.SabaKareem@amd.com>
To:     <broonie@kernel.org>, <alsa-devel@alsa-project.org>
CC:     <Vijendar.Mukunda@amd.com>, <Basavaraj.Hiregoudar@amd.com>,
        <Sunil-kumar.Dommati@amd.com>,
        Syed Saba Kareem <Syed.SabaKareem@amd.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        V Sujith Kumar Reddy <vsujithkumar.reddy@amd.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Venkata Prasad Potturu <venkataprasad.potturu@amd.com>,
        Ajit Kumar Pandey <AjitKumar.Pandey@amd.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH 04/11] ASoC: amd: acp: remove the redundant acp enable/disable interrupts functions
Date:   Thu, 22 Jun 2023 20:53:45 +0530
Message-ID: <20230622152406.3709231-8-Syed.SabaKareem@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230622152406.3709231-1-Syed.SabaKareem@amd.com>
References: <20230622152406.3709231-1-Syed.SabaKareem@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001508:EE_|PH0PR12MB7791:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f7914ac-77cc-4c0c-6aa4-08db7334f357
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PbKAxFdhXsToY88g0aulNCkzyOz+uCYwR9ZvQwUBKrQWaW0gSY+z1qhkstMeaOSSpmRs6Pyfhhqwd8odQQUx7B88PWKFRSw9tgrASUx4SB9qFQuQAzDCGtna+G4F1mvSDTIyAdVKlkniiWHxR3rrm9G59+t+NZQc7o5x/LxHchwej4i2ZeSrigXzmJAHxmNPxX23aXlPaa5D1U1M4kHBiRf8YLmgNHYzo9Tpy8TEyiUWjeQ2ksn+4wkF1m9G2WN24NikfW2VXHlitQNnabr3xCAcT0sH3km9mHvEmnomC0OI4Ibpx04FWcK0It4bbJZIBiM+d0EJYFnSvtZFvPdzarQJlqfQ2S7Quqecu2Fy08e6He82gOiZNt1nCifpRRvHWochIvurZZcUSfygAFypeXXhA9FaOLWq62Bc5Ghpdhh5ZUGGUmEfSFBLxMfvEgjp2rf0ATrBgbr/VJdgdh950eFHHLjvxdnx5CfWsu10W7YqIS40uCKKTti/dSzxzwqlHC7ateEp4Ijo4kqyedOe0OPPyMC5CD+jPbAjEPvaPcPs7H/Y9k7HgWAaY5t+cVUXb330a8D3PUelzrKsmfqUkd6lZVwl14KUeLZVXqJb45a0zWwA+NlrJ/JVLNIOkpb6raoOPcf1TJXmw8wHRv9CR7Pg3uph+vOHEzHzNPIUz7cDqBZHHIBgy662JwBO4WIElXbWVnPdyoQw0I0TjfoTOnDBpvD3Eu31y/U+j81uCqf0wpi2M8jqACm/EAR1JuVa/wlmiT9XeLbAyZQrm0pbFw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(136003)(396003)(346002)(376002)(451199021)(36840700001)(46966006)(40470700004)(82310400005)(478600001)(70206006)(36756003)(316002)(70586007)(40460700003)(54906003)(110136005)(4326008)(7696005)(426003)(86362001)(83380400001)(186003)(2616005)(81166007)(336012)(82740400003)(36860700001)(26005)(8936002)(1076003)(2906002)(356005)(8676002)(41300700001)(5660300002)(40480700001)(47076005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2023 15:25:46.0674
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f7914ac-77cc-4c0c-6aa4-08db7334f357
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00001508.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7791
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
 sound/soc/amd/acp/acp-legacy-common.c | 21 +++++++++++++++++++++
 sound/soc/amd/acp/acp-rembrandt.c     | 24 ++----------------------
 sound/soc/amd/acp/acp-renoir.c        | 23 ++---------------------
 sound/soc/amd/acp/amd.h               |  2 ++
 4 files changed, 27 insertions(+), 43 deletions(-)

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
index 83515ee753f3..bc8e1de45170 100644
--- a/sound/soc/amd/acp/acp-rembrandt.c
+++ b/sound/soc/amd/acp/acp-rembrandt.c
@@ -185,26 +185,6 @@ int acp6x_master_clock_generate(struct device *dev)
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

