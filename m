Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BD055F0FB2
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 18:15:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231979AbiI3QPg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 12:15:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232019AbiI3QPY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 12:15:24 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2089.outbound.protection.outlook.com [40.107.94.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAC8D4B989;
        Fri, 30 Sep 2022 09:15:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jx3ZxbTR7Ce4gBbZi8m6Wg0Pxjf1cVCzo7dx6+mBQXp99eww6vCXJMEgFqTvE3L4m44nhHEm2a9ypgDAQbm+pZLlqA1Yrn2FEZWDnQAbv0foQVFhLFF0ulk/ya0rUTJJKpq6t4E+WgR+sPib1+V9ap6LVKd7I2d4qOfbKHteklEMc1N76vnwg05vylm1FtyMWu1MNGDnSNHuHaU/c2SutElvIiN/bergeaW8b5rOXuR8XoGJtqJkITHOtABDewVPyoEoNOkv4JMhQtait8yrdxEX3Xu6FB7DZcUd8a8v1vMjXPXJKKmTCdGtnqD5wvnopBmx9qGXcYOOz1KrcpOYsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E/Zx6nnxbIg7/lPRrspbDYoHoxOHvE4Ge5rBO2hrczI=;
 b=IDx2AU2e++BAFdnFTA6UOk7oWnfD1H+CGTDcVe4+/U7EEl79KDPhcORj2h0XvSiSe+yg7oI/sHlaISJ9lpcFqz/6QjgpV6daZGCy50IhwAAPvvYzQfbNIjAMWPswKPFfFzZaDFKGDr3rPIJ/W+qIvE9ry6nHo/bpjjzgiOBhUYkFBpdMTDqvi0//EZnxk7d7DxL0dnkgQTYShupyq9IexybmY4Se5TjLsHpnpOCRQnqO4JcQuJaCjBxGGcHtBKm2KO+Teoqb1peijg5uB0hEnuI2WJYPjLrrfcVmkzbYiy+wjqVCCq288hnfBZ0AJ0LDyXGDuM21OyfkEiDm6Mf3Gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E/Zx6nnxbIg7/lPRrspbDYoHoxOHvE4Ge5rBO2hrczI=;
 b=WDzklrxM8AM8NpzTYVPsuYYBltsoHJC1SQilXl0VKnNXU/vUVdG4R7ppA/hdHGmIyKJOOu4GtEOM7k8NrCTEBpeVTz1jtKM1cVWEO/co2cV2hyq4gotqFMpKGLTBIEdXeJdmjP0PaPWfeww6ZShxCjUd8F0+B3+Nnv3SitL/nJ3b8l4RWT8/QikJtAtFzjRFeQcvFNnNQveLgRXBhUY1AoGLjbESiF5SHFeutg2dOVYHfx7MDegcn57FlipJpxtaDS9Bruwiwusx3iZxMiR/2kiHam27sRfVxsgU116SSFHK7cVV4Zga4YpTmzzrm7ru6da0vYSP9YExJhWa17enUg==
Received: from BN0PR08CA0022.namprd08.prod.outlook.com (2603:10b6:408:142::7)
 by CY8PR12MB7585.namprd12.prod.outlook.com (2603:10b6:930:98::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.19; Fri, 30 Sep
 2022 16:15:15 +0000
Received: from BN8NAM11FT086.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:142:cafe::54) by BN0PR08CA0022.outlook.office365.com
 (2603:10b6:408:142::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.17 via Frontend
 Transport; Fri, 30 Sep 2022 16:15:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN8NAM11FT086.mail.protection.outlook.com (10.13.176.220) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5676.17 via Frontend Transport; Fri, 30 Sep 2022 16:15:14 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Fri, 30 Sep
 2022 09:15:01 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Fri, 30 Sep
 2022 09:15:01 -0700
Received: from build-petlozup-20220913T015306864.nvidia.com (10.127.8.12) by
 mail.nvidia.com (10.129.68.8) with Microsoft SMTP Server id 15.2.986.29 via
 Frontend Transport; Fri, 30 Sep 2022 09:15:00 -0700
From:   Petlozu Pravareshwar <petlozup@nvidia.com>
To:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <p.zabel@pengutronix.de>, <dmitry.osipenko@collabora.com>,
        <ulf.hansson@linaro.org>, <kkartik@nvidia.com>,
        <cai.huoqing@linux.dev>, <spatra@nvidia.com>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <petlozup@nvidia.com>, Stefan Kristiansson <stefank@nvidia.com>
Subject: [PATCH v2] soc/tegra: pmc: Fix dual edge triggered wakes
Date:   Fri, 30 Sep 2022 16:14:52 +0000
Message-ID: <20220930161452.2618450-1-petlozup@nvidia.com>
X-Mailer: git-send-email 2.17.1
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT086:EE_|CY8PR12MB7585:EE_
X-MS-Office365-Filtering-Correlation-Id: 5653bbaa-58ee-4ea7-66fb-08daa2fef531
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Kboj1YW/wHPZSCd1nH3gy/Sn8oLGsfHK+qOh5ld8bmAvUrLsDHkBAjj/O1WC6B797W3nmSzcCeDyP/FuRiOwlQXRBJDU+vdPRXvwRvYm55MwspJ6FSfWDdegCN9tOS7Vc719y6gdGNk9hqehoJunAnLMxt/lLovVCtICyypCjCDTVgfBpKrmlCt510/PRykzb68LhIIeOr2f3qd6pPcivvW3cKVn6scNZevtKmpNKSjDIclgNMzNOr+0hvdNrpYOLnrbG7zvk7vFIY0hFbTHg+3xZavf8lQfLLnBByDJhEmxHZ+cUL1qeCyuG57HCRMei/IpRIAGOAS0pFU2rSG2V92tBfaFe6l5Nvnzog2WIuZT17WopEVyjZYpRjeNCVNG+y3408BXxnWOu8dAbn1VAoMV3bj7uKqIfOxwqAzEVTuQDAFvdxln1O5pslsEU/FPnYpfQvGQQ6NM4zKUpRO9VmGHskLKvKI1vjIssi9PoZxZUJtG8JSz/WTj4CZ1afPnCozzZmMF2XubnlXsECsZFd6gWEHuvmYtqJMSIYIdf6fg1G4LN+qu4Gxm4UeFmWh9VDOOvFUHjGX5YoBJLvrMHI2PgtLj1uEy2TSOPzXse4QZ5vsB/Q0x/hltVCLQLAz80HFr+dnQAGtrDu2QMBFIkaDHuOKxG3FmKOL6mbhOiifRYePpvQ7tv0f15SroWtB00oCa5HikaE3bfodSjUNM1UDMGlG2gLaZXMWFdIdUtvxEtsLaINTx0+mL4/YhVm/TPA2d+L45QWergo4uEit/wrW5Al92yuHq10uH3KeNBd4=
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(396003)(376002)(136003)(39860400002)(346002)(451199015)(46966006)(36840700001)(40470700004)(110136005)(54906003)(86362001)(40460700003)(41300700001)(8936002)(7696005)(6666004)(107886003)(2616005)(8676002)(30864003)(1076003)(2906002)(186003)(316002)(70586007)(82740400003)(36756003)(70206006)(4326008)(36860700001)(336012)(426003)(5660300002)(26005)(47076005)(83380400001)(7636003)(40480700001)(356005)(82310400005)(478600001)(921005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2022 16:15:14.3207
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5653bbaa-58ee-4ea7-66fb-08daa2fef531
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT086.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7585
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When a wake event is defined to be triggered on both positive
and negative edge of the input wake signal, it is crucial to
know the current state of the signal when going into suspend.
The intended way to obtain the current state of the wake
signals is to read the WAKE_AOWAKE_SW_STATUS register,
which should contains the raw state of the wake signals.

However, this register is edge triggered, an edge will not
be generated for signals that are already asserted prior to
the assertion of WAKE_LATCH_SW.

To workaround this, change the polarity of the wake level
from '0' to '1' while latching the signals, as this will
generate an edge for signals that are set to '1'.

Signed-off-by: Stefan Kristiansson <stefank@nvidia.com>
Signed-off-by: Petlozu Pravareshwar <petlozup@nvidia.com>
---
v1->v2:
* Addressing review comments from Thierry Reding.
---
 drivers/soc/tegra/pmc.c | 188 ++++++++++++++++++++++++++++++++++++++--
 1 file changed, 183 insertions(+), 5 deletions(-)

diff --git a/drivers/soc/tegra/pmc.c b/drivers/soc/tegra/pmc.c
index a27870fe917a..6b56dbdc4caa 100644
--- a/drivers/soc/tegra/pmc.c
+++ b/drivers/soc/tegra/pmc.c
@@ -46,6 +46,7 @@
 #include <linux/seq_file.h>
 #include <linux/slab.h>
 #include <linux/spinlock.h>
+#include <linux/syscore_ops.h>
 
 #include <soc/tegra/common.h>
 #include <soc/tegra/fuse.h>
@@ -182,6 +183,9 @@
 #define WAKE_AOWAKE_TIER0_ROUTING(x) (0x4b4 + ((x) << 2))
 #define WAKE_AOWAKE_TIER1_ROUTING(x) (0x4c0 + ((x) << 2))
 #define WAKE_AOWAKE_TIER2_ROUTING(x) (0x4cc + ((x) << 2))
+#define WAKE_AOWAKE_SW_STATUS_W_0	0x49c
+#define WAKE_AOWAKE_SW_STATUS(x)	(0x4a0 + ((x) << 2))
+#define WAKE_LATCH_SW			0x498
 
 #define WAKE_AOWAKE_CTRL 0x4f4
 #define  WAKE_AOWAKE_CTRL_INTR_POLARITY BIT(0)
@@ -356,6 +360,8 @@ struct tegra_pmc_soc {
 	 */
 	const struct tegra_wake_event *wake_events;
 	unsigned int num_wake_events;
+	unsigned int max_wake_events;
+	unsigned int max_wake_vectors;
 
 	const struct pmc_clk_init_data *pmc_clks_data;
 	unsigned int num_pmc_clks;
@@ -396,6 +402,11 @@ struct tegra_pmc_soc {
  * @clk_nb: pclk clock changes handler
  * @core_domain_state_synced: flag marking the core domain's state as synced
  * @core_domain_registered: flag marking the core domain as registered
+ * @wake_type_level_map: Bitmap indicating level type for non-dual edge wakes
+ * @wake_type_dual_edge_map: Bitmap indicating if a wake is dual-edge or not
+ * @wake_sw_status_map: Bitmap to hold raw status of wakes without mask
+ * @wake_cntrl_level_map: Bitmap to hold wake levels to be programmed in
+ *     cntrl register associated with each wake during system suspend.
  */
 struct tegra_pmc {
 	struct device *dev;
@@ -436,6 +447,11 @@ struct tegra_pmc {
 
 	bool core_domain_state_synced;
 	bool core_domain_registered;
+
+	unsigned long *wake_type_level_map;
+	unsigned long *wake_type_dual_edge_map;
+	unsigned long *wake_sw_status_map;
+	unsigned long *wake_cntrl_level_map;
 };
 
 static struct tegra_pmc *pmc = &(struct tegra_pmc) {
@@ -1913,10 +1929,35 @@ static int tegra_pmc_parse_dt(struct tegra_pmc *pmc, struct device_node *np)
 	return 0;
 }
 
-static void tegra_pmc_init(struct tegra_pmc *pmc)
+static int tegra_pmc_init(struct tegra_pmc *pmc)
 {
+	if (pmc->soc->max_wake_events > 0) {
+		pmc->wake_type_level_map = kcalloc(BITS_TO_LONGS(
+				pmc->soc->max_wake_events),
+				sizeof(unsigned long), GFP_KERNEL);
+		if (!pmc->wake_type_level_map)
+			return -ENOMEM;
+		pmc->wake_type_dual_edge_map = kcalloc(BITS_TO_LONGS(
+				pmc->soc->max_wake_events),
+				sizeof(unsigned long), GFP_KERNEL);
+		if (!pmc->wake_type_dual_edge_map)
+			return -ENOMEM;
+		pmc->wake_sw_status_map = kcalloc(BITS_TO_LONGS(
+				pmc->soc->max_wake_events),
+				sizeof(unsigned long), GFP_KERNEL);
+		if (!pmc->wake_sw_status_map)
+			return -ENOMEM;
+		pmc->wake_cntrl_level_map = kcalloc(BITS_TO_LONGS(
+				pmc->soc->max_wake_events),
+				sizeof(unsigned long), GFP_KERNEL);
+		if (!pmc->wake_cntrl_level_map)
+			return -ENOMEM;
+	}
+
 	if (pmc->soc->init)
 		pmc->soc->init(pmc);
+
+	return 0;
 }
 
 static void tegra_pmc_init_tsense_reset(struct tegra_pmc *pmc)
@@ -2399,15 +2440,21 @@ static int tegra186_pmc_irq_set_type(struct irq_data *data, unsigned int type)
 	case IRQ_TYPE_EDGE_RISING:
 	case IRQ_TYPE_LEVEL_HIGH:
 		value |= WAKE_AOWAKE_CNTRL_LEVEL;
+		set_bit(data->hwirq, pmc->wake_type_level_map);
+		clear_bit(data->hwirq, pmc->wake_type_dual_edge_map);
 		break;
 
 	case IRQ_TYPE_EDGE_FALLING:
 	case IRQ_TYPE_LEVEL_LOW:
 		value &= ~WAKE_AOWAKE_CNTRL_LEVEL;
+		clear_bit(data->hwirq, pmc->wake_type_level_map);
+		clear_bit(data->hwirq, pmc->wake_type_dual_edge_map);
 		break;
 
 	case IRQ_TYPE_EDGE_RISING | IRQ_TYPE_EDGE_FALLING:
 		value ^= WAKE_AOWAKE_CNTRL_LEVEL;
+		clear_bit(data->hwirq, pmc->wake_type_level_map);
+		set_bit(data->hwirq, pmc->wake_type_dual_edge_map);
 		break;
 
 	default:
@@ -2946,7 +2993,11 @@ static int tegra_pmc_probe(struct platform_device *pdev)
 
 	pmc->dev = &pdev->dev;
 
-	tegra_pmc_init(pmc);
+	err = tegra_pmc_init(pmc);
+	if (err) {
+		dev_err(&pdev->dev, "failed to init pmc: %d\n", err);
+		return err;
+	}
 
 	tegra_pmc_init_tsense_reset(pmc);
 
@@ -2997,6 +3048,118 @@ static int tegra_pmc_probe(struct platform_device *pdev)
 	return err;
 }
 
+/*
+ * Ensures that sufficient time is passed for a register write to
+ * serialize into the 32KHz domain.
+ */
+static void wke_32kwritel(u32 val, u32 reg)
+{
+	writel(val, pmc->wake + reg);
+	udelay(130);
+}
+
+static void wke_write_wake_level(int wake, int level)
+{
+	u32 val;
+	u32 reg = WAKE_AOWAKE_CNTRL(wake);
+
+	val = readl(pmc->wake + reg);
+	if (level)
+		val |= WAKE_AOWAKE_CNTRL_LEVEL;
+	else
+		val &= ~WAKE_AOWAKE_CNTRL_LEVEL;
+	writel(val, pmc->wake + reg);
+}
+
+static void wke_write_wake_levels(void)
+{
+	int i;
+
+	for (i = 0; i < pmc->soc->max_wake_events; i++)
+		wke_write_wake_level(i, test_bit(i, pmc->wake_cntrl_level_map));
+}
+
+static void wke_clear_sw_wake_status(void)
+{
+	wke_32kwritel(1, WAKE_AOWAKE_SW_STATUS_W_0);
+}
+
+static void wke_read_sw_wake_status(void)
+{
+	unsigned long status;
+	int wake, i;
+
+	for (i = 0; i < pmc->soc->max_wake_events; i++)
+		wke_write_wake_level(i, 0);
+
+	wke_clear_sw_wake_status();
+
+	wke_32kwritel(1, WAKE_LATCH_SW);
+
+	/*
+	 * WAKE_AOWAKE_SW_STATUS is edge triggered, so in order to
+	 * obtain the current status of the input wake signals, change
+	 * the polarity of the wake level from 0->1 while latching to force
+	 * a positive edge if the sampled signal is '1'.
+	 */
+	for (i = 0; i < pmc->soc->max_wake_events; i++)
+		wke_write_wake_level(i, 1);
+
+	/*
+	 * Wait for the update to be synced into the 32kHz domain,
+	 * and let enough time lapse, so that the wake signals have time to
+	 * be sampled.
+	 */
+	udelay(300);
+
+	wke_32kwritel(0, WAKE_LATCH_SW);
+
+	bitmap_zero(pmc->wake_sw_status_map, pmc->soc->max_wake_events);
+	for (i = 0; i < pmc->soc->max_wake_vectors; i++) {
+		status = (unsigned long)readl(pmc->wake +
+					WAKE_AOWAKE_SW_STATUS(i));
+		for_each_set_bit(wake, &status, 32)
+			set_bit(wake + (i * 32), pmc->wake_sw_status_map);
+	}
+}
+
+static void wke_clear_wake_status(void)
+{
+	u32 status;
+	int i, wake;
+	unsigned long ulong_status;
+
+	for (i = 0; i < pmc->soc->max_wake_vectors; i++) {
+		status = readl(pmc->wake + WAKE_AOWAKE_STATUS_R(i));
+		status = status & readl(pmc->wake +
+				WAKE_AOWAKE_TIER2_ROUTING(i));
+		ulong_status = (unsigned long)status;
+		for_each_set_bit(wake, &ulong_status, 32)
+			wke_32kwritel(0x1,
+				WAKE_AOWAKE_STATUS_W((i * 32) + wake));
+	}
+}
+
+static int tegra186_pmc_wake_syscore_suspend(void)
+{
+	wke_read_sw_wake_status();
+
+	/* flip the wakeup trigger for dual-edge triggered pads
+	 * which are currently asserting as wakeups
+	 */
+	bitmap_andnot(pmc->wake_cntrl_level_map, pmc->wake_type_dual_edge_map,
+		pmc->wake_sw_status_map, pmc->soc->max_wake_events);
+	bitmap_or(pmc->wake_cntrl_level_map, pmc->wake_cntrl_level_map,
+		pmc->wake_type_level_map, pmc->soc->max_wake_events);
+
+	/* Clear PMC Wake Status registers while going to suspend */
+	wke_clear_wake_status();
+
+	wke_write_wake_levels();
+
+	return 0;
+}
+
 #if defined(CONFIG_PM_SLEEP) && defined(CONFIG_ARM)
 static int tegra_pmc_suspend(struct device *dev)
 {
@@ -3652,6 +3815,15 @@ static const struct tegra_pmc_regs tegra186_pmc_regs = {
 	.rst_level_mask = 0x3,
 };
 
+static struct syscore_ops tegra186_pmc_wake_syscore_ops = {
+	.suspend = tegra186_pmc_wake_syscore_suspend,
+};
+
+static void tegra186_pmc_init(struct tegra_pmc *pmc)
+{
+	register_syscore_ops(&tegra186_pmc_wake_syscore_ops);
+}
+
 static void tegra186_pmc_setup_irq_polarity(struct tegra_pmc *pmc,
 					    struct device_node *np,
 					    bool invert)
@@ -3731,7 +3903,7 @@ static const struct tegra_pmc_soc tegra186_pmc_soc = {
 	.num_pin_descs = ARRAY_SIZE(tegra186_pin_descs),
 	.pin_descs = tegra186_pin_descs,
 	.regs = &tegra186_pmc_regs,
-	.init = NULL,
+	.init = tegra186_pmc_init,
 	.setup_irq_polarity = tegra186_pmc_setup_irq_polarity,
 	.irq_set_wake = tegra186_pmc_irq_set_wake,
 	.irq_set_type = tegra186_pmc_irq_set_type,
@@ -3741,6 +3913,8 @@ static const struct tegra_pmc_soc tegra186_pmc_soc = {
 	.num_reset_levels = ARRAY_SIZE(tegra186_reset_levels),
 	.num_wake_events = ARRAY_SIZE(tegra186_wake_events),
 	.wake_events = tegra186_wake_events,
+	.max_wake_events = 96,
+	.max_wake_vectors = 3,
 	.pmc_clks_data = NULL,
 	.num_pmc_clks = 0,
 	.has_blink_output = false,
@@ -3910,7 +4084,7 @@ static const struct tegra_pmc_soc tegra194_pmc_soc = {
 	.num_pin_descs = ARRAY_SIZE(tegra194_pin_descs),
 	.pin_descs = tegra194_pin_descs,
 	.regs = &tegra194_pmc_regs,
-	.init = NULL,
+	.init = tegra186_pmc_init,
 	.setup_irq_polarity = tegra186_pmc_setup_irq_polarity,
 	.irq_set_wake = tegra186_pmc_irq_set_wake,
 	.irq_set_type = tegra186_pmc_irq_set_type,
@@ -3920,6 +4094,8 @@ static const struct tegra_pmc_soc tegra194_pmc_soc = {
 	.num_reset_levels = ARRAY_SIZE(tegra186_reset_levels),
 	.num_wake_events = ARRAY_SIZE(tegra194_wake_events),
 	.wake_events = tegra194_wake_events,
+	.max_wake_events = 96,
+	.max_wake_vectors = 3,
 	.pmc_clks_data = NULL,
 	.num_pmc_clks = 0,
 	.has_blink_output = false,
@@ -4037,7 +4213,7 @@ static const struct tegra_pmc_soc tegra234_pmc_soc = {
 	.num_pin_descs = ARRAY_SIZE(tegra234_pin_descs),
 	.pin_descs = tegra234_pin_descs,
 	.regs = &tegra234_pmc_regs,
-	.init = NULL,
+	.init = tegra186_pmc_init,
 	.setup_irq_polarity = tegra186_pmc_setup_irq_polarity,
 	.irq_set_wake = tegra186_pmc_irq_set_wake,
 	.irq_set_type = tegra186_pmc_irq_set_type,
@@ -4047,6 +4223,8 @@ static const struct tegra_pmc_soc tegra234_pmc_soc = {
 	.num_reset_levels = ARRAY_SIZE(tegra186_reset_levels),
 	.num_wake_events = ARRAY_SIZE(tegra234_wake_events),
 	.wake_events = tegra234_wake_events,
+	.max_wake_events = 96,
+	.max_wake_vectors = 3,
 	.pmc_clks_data = NULL,
 	.num_pmc_clks = 0,
 	.has_blink_output = false,
-- 
2.17.1

