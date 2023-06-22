Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8029E73A4CA
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 17:26:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231860AbjFVP0R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 11:26:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231211AbjFVP0O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 11:26:14 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2043.outbound.protection.outlook.com [40.107.102.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31B71211F
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 08:26:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j+VChYyt+gpDe5bBboFM+KtTz/Ye4jGvEEI02j+CV3D7TefjqjL5aeDTJd6V7syTSzQB0BtbZmSwtEmSJ5XPTsIl24T32oZ9inHnJS6jXeN9tCZueYIpY914uKyChiXUxI/SxhYnXW6cPHGIBGGYHvHCFSU1gYweJyZAzuDYviu3x5cuYeEK+jq23kpb1udbDVUrdTR2nDte8t9NwZTqNFi/RwuUmV0I/YRTObXUj97LHTdv7w3UFf2nfrCNc9lA1zDCO9bzqPGPpnfF+AN4GbLN50JlalUN9hjXtDa2m3Gvi7cAkQPncmxz8bUSctsKeDwrfxrG6rv8JQjS/vKGDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lyb4oUKPqZp6YQRg2tTH63rwDvDI64BEIOp/IMCkntM=;
 b=aXDwDyNL3If/AlWn1TbJV/u4A5BBNvkOUV0I15IAzdPvZPCpqxdIarL8TlP1YtPMuw7Ijzv0xy+CVqd79vLaWeUqW6Khv/O3TZHmeNko7flPLvdd3nLSI3pjNPdwvbEoWc9DNiB49fuaGK3o5/faL2hi2oR0EHzyTlAyaqnRnEEv0vVUNphbfvPPPKdHLgXIyRfj7kSP3qocxkn8tUnF51ntWyzwnrUxt7xN5GVXtUn4bqwThUD8CXNSftW41Agj/p00c1BsfZloi0yd8NX0M4y79aWlzwckq5HqcE1iB5+rH8PBPVJ5uYsJ+k0FG5qv53ZUBFg+mLvoZNCUOIRRCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lyb4oUKPqZp6YQRg2tTH63rwDvDI64BEIOp/IMCkntM=;
 b=PaQwTS/FKjj4kXXVYIyjqNi4PwSSYtJYewhljMqpu9sOMpCiDI0WLKWGP5PPkJPv77+jC+gBPUYpOeSwGZePU+QkehirC+JvwUWh9/dtWmCrQ3niB07hHXkOVAQhr5qjOzwYl/B00T7/mjSKIiJRaHuRitcXDjgz7fLVIiYK2MU=
Received: from SA1PR02CA0014.namprd02.prod.outlook.com (2603:10b6:806:2cf::21)
 by LV3PR12MB9096.namprd12.prod.outlook.com (2603:10b6:408:198::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23; Thu, 22 Jun
 2023 15:25:59 +0000
Received: from SA2PEPF00001508.namprd04.prod.outlook.com
 (2603:10b6:806:2cf:cafe::e8) by SA1PR02CA0014.outlook.office365.com
 (2603:10b6:806:2cf::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24 via Frontend
 Transport; Thu, 22 Jun 2023 15:25:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SA2PEPF00001508.mail.protection.outlook.com (10.167.242.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6521.19 via Frontend Transport; Thu, 22 Jun 2023 15:25:58 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Thu, 22 Jun
 2023 10:25:58 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Thu, 22 Jun
 2023 10:25:58 -0500
Received: from amd-B450M-DS3H.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.23 via Frontend
 Transport; Thu, 22 Jun 2023 10:25:54 -0500
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
Subject: [PATCH 05/12] ASoC: amd: acp: remove the redundant acp enable/disable interrupts functions
Date:   Thu, 22 Jun 2023 20:53:46 +0530
Message-ID: <20230622152406.3709231-9-Syed.SabaKareem@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230622152406.3709231-1-Syed.SabaKareem@amd.com>
References: <20230622152406.3709231-1-Syed.SabaKareem@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001508:EE_|LV3PR12MB9096:EE_
X-MS-Office365-Filtering-Correlation-Id: ebd7b68c-101e-4943-4da0-08db7334faf3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HsU5gIQfByngOmQivmzUFV65gKD0yUGXysXWNR1UrKtHzY1c8MCo3Ch6A3b7jlqNVCx06QqNV1iOZc+KNfoxRkoFQUZ1D+G43DEYMV5ILAcmHlMXkV8p35SXq5VjdzYdYzPt9peofm0bBBhqz3neu51jvg1gpKt8Z0E0kudmObKLErzOrVNBR5P4SMd4ZfAZG03F3RIKTz7Xq1KGoW3no10P/cifXSA54tYviR/GPjIPiZrkbyOgfIfkOQKMDApIqcBhqgEH2z+BhLmtrt6JARGx41ylKD0oSCyGGm79yD1zcLXc9p2kSbNP9lV9l+FRGvFpnCv7i2AEBxlExFdwLKX2513eG0En9YVMZE3ZsS+HN4dF+4qKtYZqZ2Sh09J8hLf0WHeHFkfkdjJchllDOyIPeDX1ZU9VQ3ouRK+oAGdcVSasAGwTdcRp06bhBwp1krIuKPOrGVhPMsNtUKblwK8KUOF9LKZHj3E4J3ibb/oMg912x4Vg2qs86MfxFGxRtS5h+k+rUJL9ZopmYlnqlp/S7ePpIPcNwdGOKiPLoDRFwcDFgtanyr3ucu55E+n98yBKK4UnTg5GwDGhO2DizxMLIxEeza/aN8/dzmsabOOR+fESES9KyzcI4npRXgYk/Dxmg1HUBn3DlhPVNjvUbR7SyzRuB/W+LdOPnRn9uUEVYYf+H2ScHaPorv4eDs0Bqdkg9tlbn3zzfnE77ja3IT82iU+3ZOx8uDf0ZR7Y3MWL2jbPWudBvGWG7vONJ8z0PWJH97gbC7LZZX9ovVqS2w==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(346002)(136003)(39860400002)(451199021)(36840700001)(40470700004)(46966006)(70586007)(82310400005)(7696005)(8936002)(8676002)(41300700001)(316002)(356005)(70206006)(36756003)(2906002)(81166007)(82740400003)(83380400001)(26005)(6666004)(336012)(426003)(110136005)(54906003)(478600001)(4326008)(86362001)(40460700003)(47076005)(5660300002)(40480700001)(2616005)(186003)(36860700001)(1076003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2023 15:25:58.8174
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ebd7b68c-101e-4943-4da0-08db7334faf3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00001508.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9096
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

