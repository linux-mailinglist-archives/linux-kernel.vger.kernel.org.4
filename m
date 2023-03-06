Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 532326AB57D
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 05:13:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229899AbjCFEN2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Mar 2023 23:13:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229891AbjCFEM5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Mar 2023 23:12:57 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2059.outbound.protection.outlook.com [40.107.243.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAABF1C7F9;
        Sun,  5 Mar 2023 20:11:47 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lSAxsGTTqI03Qltlx/VEG0Kb9/wFTyvleJbRkm4jrXXMkIpV0N3cyXLC7U9vFWrBqUeCXSH5LRT4L5kHkRTM4gtv/SOto9Swb8FXFX1OZXM7VRTwy7yF6IJeDZY5RykMWnvg7LodT06d7mYq67gGHiEgG+ViMgKEp7A2Dh/iJ9+Cf5uSYBgSwqXUGoT5VmyDW1ae3dEBxC9jNjRavCNO5ChAoZoRLj4+bEYuw2iGTwNqLfBqkA6khTIMKss9bIxw8dg+lKQdHOcuBS56EhhGmCDqbgYMPpMMWxcFffuzh15PhJnH6R1BUmoS5hLPDkNxLW1Y+Bm+kW8u8h6O8CL3bQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PKPYNtiAmuW7X2ASWiDM4ckmbhGhoI+/6LmT6HacMMg=;
 b=FimMA5Dng28FmS7q3ZuSCU1VuG1n76P33VmL+Cbh2fDguH4idf8FlXDPSMjrzkIheyIUvnTwCA4h3sS8ylcxQJvX91b2uRZwLglCrlk0JjfEXAOQ+4aWVVZUklAL8tfmPjEdMUlv5iIauCOk91NP4mify2zaI9GZLMnL5OvwEnPHSNojOPd9tHO4k6IIDeuyBjxWWbFNbv7OSh5PpBDUggO0gflnM2+J1yUoHFUWGhWFRWw7/+me90vtrzWFN1uBvReOz5qw1ib/ic3SCd96jHQ3io1/L9BYL1cFB74AJYejx9USIgoXAOPmsDDtqCIqsgPM3MMbQyZAZcG5zlhfUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PKPYNtiAmuW7X2ASWiDM4ckmbhGhoI+/6LmT6HacMMg=;
 b=rAZ3HhgklBYm8gNnubv2o5KDOwAQdLit6r85GVk/r2TMfCU/p+oMMBQKAR0bdB8NTyjCAvn/gFDKEapTCkuEwkXpAR+7V0r4bcnr3HgFgmbFqlEDElfMgQGC8JwP+lRWSzkap6o2nBy9tw4nWky4MRc30KaKd1+wK30S5Nfsy+4=
Received: from BN9PR03CA0083.namprd03.prod.outlook.com (2603:10b6:408:fc::28)
 by CY5PR12MB6647.namprd12.prod.outlook.com (2603:10b6:930:40::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.28; Mon, 6 Mar
 2023 04:10:51 +0000
Received: from BN8NAM11FT088.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:fc:cafe::6d) by BN9PR03CA0083.outlook.office365.com
 (2603:10b6:408:fc::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.28 via Frontend
 Transport; Mon, 6 Mar 2023 04:10:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT088.mail.protection.outlook.com (10.13.177.81) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6178.15 via Frontend Transport; Mon, 6 Mar 2023 04:10:50 +0000
Received: from platform-dev1.pensando.io (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Sun, 5 Mar 2023 22:10:45 -0600
From:   Brad Larson <blarson@amd.com>
To:     <linux-arm-kernel@lists.infradead.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-mmc@vger.kernel.org>,
        <linux-spi@vger.kernel.org>, <adrian.hunter@intel.com>,
        <alcooperx@gmail.com>, <andy.shevchenko@gmail.com>,
        <arnd@arndb.de>, <blarson@amd.com>, <brendan.higgins@linux.dev>,
        <briannorris@chromium.org>, <brijeshkumar.singh@amd.com>,
        <catalin.marinas@arm.com>, <davidgow@google.com>,
        <gsomlo@gmail.com>, <gerg@linux-m68k.org>, <krzk@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <lee@kernel.org>,
        <lee.jones@linaro.org>, <broonie@kernel.org>,
        <yamada.masahiro@socionext.com>, <p.zabel@pengutronix.de>,
        <piotrs@cadence.com>, <p.yadav@ti.com>, <rdunlap@infradead.org>,
        <robh+dt@kernel.org>, <samuel@sholland.org>,
        <fancer.lancer@gmail.com>, <skhan@linuxfoundation.org>,
        <suravee.suthikulpanit@amd.com>, <thomas.lendacky@amd.com>,
        <tonyhuang.sunplus@gmail.com>, <ulf.hansson@linaro.org>,
        <vaishnav.a@ti.com>, <will@kernel.org>,
        <devicetree@vger.kernel.org>
Subject: [PATCH v10 13/15] mmc: sdhci-cadence: Add AMD Pensando Elba SoC support
Date:   Sun, 5 Mar 2023 20:07:37 -0800
Message-ID: <20230306040739.51488-14-blarson@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230306040739.51488-1-blarson@amd.com>
References: <20230306040739.51488-1-blarson@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT088:EE_|CY5PR12MB6647:EE_
X-MS-Office365-Filtering-Correlation-Id: 721840bf-9603-4994-5a4c-08db1df8c592
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gUZeD3MhEYUO5sKcRSp5lz1jXoqPuwV7HGTZtRRVggFY63HqHtvTGCRVbQtx8bQ5R5HbHomxSdndLGpJb78+wi/cttIoLKDY0os7jHQ3bZNe7Sa+VPZg8M6LM7SnHnp0j0o7/DytX1UffeXFpGr45T4g7AvoIAIJfD4h6AgC9N4+hqFd3gUMtx5MHHeeF3L0/mtQzWLxjwUTQAf2VKgIGxESbDpUIaxNjmBeoqyLpXfWq6ATZbtRUdt8q3mabsxSQhb5r1asPt+GRNm7+4pcS8olh+HK+OsZMiFkKDsBwUt+CtSOHdHrGNIgtZSuuLH+0oPKmIX6rwC73UeCHytLYI+YoAqAKFuJuUPR90SDEkIrDYzq6x3zYJixFdGloF0azxqMhY8a+DmIAyqLzos18FC7ko769aUWKkfXELKbReZvBK4vvSkDO2oOTynqV0bt+N3WkX+nnyunKzHq5jcpN1AAUykio3nVDx2u4caASdev1vsjahVwP7wa6e4mN/wbXq69GL3XVaxI7T8IJdtdOMPmUgrmm7QqxSucO8l+gBdB8HdORWiQT0cfgyBcjWlYQj6Nfv7eS4XEwlWuldMno1Hcnw4sV5zd/vO5sP7y6ay84nXFnrDHPGNGHwysOdnJ/Tkiz1nBi97AatHJ/wWOJeDLHlzFslm6e/8AaOCE35v7oADPTRY6g46KJEk9D4YMCDNlVxSkFXCVgGSfN4ObDumU58ZGpNkwsW91hf4AhK0=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(396003)(136003)(376002)(346002)(451199018)(46966006)(36840700001)(40470700004)(1076003)(6666004)(36756003)(36860700001)(47076005)(426003)(82310400005)(83380400001)(356005)(40460700003)(40480700001)(81166007)(82740400003)(336012)(16526019)(186003)(26005)(2616005)(41300700001)(70206006)(70586007)(6916009)(8676002)(4326008)(2906002)(8936002)(5660300002)(7406005)(7416002)(316002)(54906003)(478600001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2023 04:10:50.6386
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 721840bf-9603-4994-5a4c-08db1df8c592
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT088.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6647
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for AMD Pensando Elba SoC which explicitly
controls byte-lane enables on writes.

Select MMC_SDHCI_IO_ACCESSORS for MMC_SDHCI_CADENCE which
allows Elba SoC sdhci_elba_ops to overwrite the SDHCI
IO memory accessors.

Signed-off-by: Brad Larson <blarson@amd.com>
---

v10 changes:
- Add Elba specific support into this 3rd patch.  This builds on the private
  writel() enabled in patch 1 followed by platform specific init() in patch 2.
- Specify when first used the reason for the spinlock use to order byte-enable
  prior to write data.

---
 drivers/mmc/host/Kconfig         |   1 +
 drivers/mmc/host/sdhci-cadence.c | 101 +++++++++++++++++++++++++++++++
 2 files changed, 102 insertions(+)

diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
index 4745fe217ade..9f793892123c 100644
--- a/drivers/mmc/host/Kconfig
+++ b/drivers/mmc/host/Kconfig
@@ -255,6 +255,7 @@ config MMC_SDHCI_CADENCE
 	tristate "SDHCI support for the Cadence SD/SDIO/eMMC controller"
 	depends on MMC_SDHCI_PLTFM
 	depends on OF
+	select MMC_SDHCI_IO_ACCESSORS
 	help
 	  This selects the Cadence SD/SDIO/eMMC driver.
 
diff --git a/drivers/mmc/host/sdhci-cadence.c b/drivers/mmc/host/sdhci-cadence.c
index c528a25f48b8..31c77d32aa7d 100644
--- a/drivers/mmc/host/sdhci-cadence.c
+++ b/drivers/mmc/host/sdhci-cadence.c
@@ -66,6 +66,8 @@ struct sdhci_cdns_phy_param {
 
 struct sdhci_cdns_priv {
 	void __iomem *hrs_addr;
+	void __iomem *ctl_addr;	/* write control */
+	spinlock_t wrlock;	/* write lock */
 	bool enhanced_strobe;
 	void (*priv_writel)(struct sdhci_cdns_priv *priv, u32 val, void __iomem *reg);
 	unsigned int nr_phy_params;
@@ -321,6 +323,94 @@ static void sdhci_cdns_set_uhs_signaling(struct sdhci_host *host,
 		sdhci_set_uhs_signaling(host, timing);
 }
 
+/* Elba control register bits [6:3] are byte-lane enables */
+#define ELBA_BYTE_ENABLE_MASK(x)	((x) << 3)
+
+/*
+ * The Pensando Elba SoC explicitly controls byte-lane enabling on writes
+ * which includes writes to the HRS registers.  The write lock (wrlock)
+ * is used to ensure byte-lane enable, using write control (ctl_addr),
+ * occurs before the data write.
+ */
+static void elba_priv_writel(struct sdhci_cdns_priv *priv, u32 val,
+			     void __iomem *reg)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&priv->wrlock, flags);
+	writel(ELBA_BYTE_ENABLE_MASK(0xf), priv->ctl_addr);
+	writel(val, reg);
+	spin_unlock_irqrestore(&priv->wrlock, flags);
+}
+
+static void elba_write_l(struct sdhci_host *host, u32 val, int reg)
+{
+	elba_priv_writel(sdhci_cdns_priv(host), val, host->ioaddr + reg);
+}
+
+static void elba_write_w(struct sdhci_host *host, u16 val, int reg)
+{
+	struct sdhci_cdns_priv *priv = sdhci_cdns_priv(host);
+	u32 byte_enables;
+	unsigned long flags;
+
+	byte_enables = GENMASK(1, 0) << (reg & 0x3);
+	spin_lock_irqsave(&priv->wrlock, flags);
+	writel(ELBA_BYTE_ENABLE_MASK(byte_enables), priv->ctl_addr);
+	writew(val, host->ioaddr + reg);
+	spin_unlock_irqrestore(&priv->wrlock, flags);
+}
+
+static void elba_write_b(struct sdhci_host *host, u8 val, int reg)
+{
+	struct sdhci_cdns_priv *priv = sdhci_cdns_priv(host);
+	u32 byte_enables;
+	unsigned long flags;
+
+	byte_enables = BIT(0) << (reg & 0x3);
+	spin_lock_irqsave(&priv->wrlock, flags);
+	writel(ELBA_BYTE_ENABLE_MASK(byte_enables), priv->ctl_addr);
+	writeb(val, host->ioaddr + reg);
+	spin_unlock_irqrestore(&priv->wrlock, flags);
+}
+
+static const struct sdhci_ops sdhci_elba_ops = {
+	.write_l = elba_write_l,
+	.write_w = elba_write_w,
+	.write_b = elba_write_b,
+	.set_clock = sdhci_set_clock,
+	.get_timeout_clock = sdhci_cdns_get_timeout_clock,
+	.set_bus_width = sdhci_set_bus_width,
+	.reset = sdhci_reset,
+	.set_uhs_signaling = sdhci_cdns_set_uhs_signaling,
+};
+
+static int elba_drv_init(struct platform_device *pdev)
+{
+	struct sdhci_host *host = platform_get_drvdata(pdev);
+	struct sdhci_cdns_priv *priv = sdhci_cdns_priv(host);
+	struct resource *iomem;
+	void __iomem *ioaddr;
+
+	host->mmc->caps |= (MMC_CAP_1_8V_DDR | MMC_CAP_8_BIT_DATA);
+
+	iomem = platform_get_resource(pdev, IORESOURCE_MEM, 1);
+	if (!iomem)
+		return -ENOMEM;
+
+	/* Byte-lane control register */
+	ioaddr = devm_platform_ioremap_resource(pdev, 1);
+	if (IS_ERR(ioaddr))
+		return PTR_ERR(ioaddr);
+
+	priv->ctl_addr = ioaddr;
+	priv->priv_writel = elba_priv_writel;
+	spin_lock_init(&priv->wrlock);
+	writel(ELBA_BYTE_ENABLE_MASK(0xf), priv->ctl_addr);
+
+	return 0;
+}
+
 static const struct sdhci_ops sdhci_cdns_ops = {
 	.set_clock = sdhci_set_clock,
 	.get_timeout_clock = sdhci_cdns_get_timeout_clock,
@@ -337,6 +427,13 @@ static const struct sdhci_cdns_drv_data sdhci_cdns_uniphier_drv_data = {
 	},
 };
 
+static const struct sdhci_cdns_drv_data sdhci_elba_drv_data = {
+	.init = elba_drv_init,
+	.pltfm_data = {
+		.ops = &sdhci_elba_ops,
+	},
+};
+
 static const struct sdhci_cdns_drv_data sdhci_cdns_drv_data = {
 	.pltfm_data = {
 		.ops = &sdhci_cdns_ops,
@@ -477,6 +574,10 @@ static const struct of_device_id sdhci_cdns_match[] = {
 		.compatible = "socionext,uniphier-sd4hc",
 		.data = &sdhci_cdns_uniphier_drv_data,
 	},
+	{
+		.compatible = "amd,pensando-elba-sd4hc",
+		.data = &sdhci_elba_drv_data,
+	},
 	{ .compatible = "cdns,sd4hc" },
 	{ /* sentinel */ }
 };
-- 
2.17.1

