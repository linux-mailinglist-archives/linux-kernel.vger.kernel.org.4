Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5104E6DCB24
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Apr 2023 20:48:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230053AbjDJSsc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Apr 2023 14:48:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229721AbjDJSsW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 14:48:22 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2052.outbound.protection.outlook.com [40.107.94.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AFB22128;
        Mon, 10 Apr 2023 11:47:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nyDEclPRTC94lSkICdaEo89eZ8GTi1VVYId38EA3ssaiL+jX2wEvwr5IhMi7soxdoINKe8y8TVZzmODVOOhOCO2zBR9IIlDsjmpvjLwj/q1tab86SHzfdyqNxoUpaw6ZO74ImOYH9R0wWVqoLkwp2MLCJG0Ry5N2FofQAghwyQK6ozFmb2kt2IhU+ES2nQV8ttunNd07ZM0YCvo/BQziACJkVLRB00jCkyRZfw3IDh/x/Ps2Cpm0SLI0Rtjx7uJx7EB4Ic6AZIBjThOsM3j1Ct2NgZlPuBaokj65IB2jmO9+S4eWlqStKLKyhZDiq54hGW//CYchsHpc131X8dfHhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ya09CqokIksgvEDTvz2049aCEW8QiLjxhjKXDbEAz4I=;
 b=NOxOUkxZzFDzSr7OVaAELGbPmTNqQm1Jbk+/185rEze9lLWn69umS/mmCaRt4x+WNiQzZNrujj553vjc28P+Hb3sEyfMnFilCibvX4MXaZD5o2+5RxHgE7Aa+TkBivqaYoBmk5PDE711OpPEh6OjK4h5HPlPVmu0WKsi7OwVQUUBgVzeSVqL8oTb/woVe7cTAj9WpcfqLvScnMz0hJ7oNVGuaKV299otRpQnlIk8RA20lLxUvbHo1zCooOgJW1OQaE8Chj6cnOX/h+UyeiC9dPzr1oinQCcr9vtoN3cRFpwbzM7ZGCAdSXH8cTKQR9eknR92KKX2lfsC6hnCSKp8Lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ya09CqokIksgvEDTvz2049aCEW8QiLjxhjKXDbEAz4I=;
 b=gidcR0PtAATO+NWC37IosyO3gYzUw+L3IHAOB5/9b93AvzxuWw4sb7i1OfaxLcD5+zJjeR0G/Sff2pOlBOtd7EUWw8cY4ef5f2Q0egCU3sajRYbZnwlgrnLcShDhciqujHY0B/oqUeL4P1X4znSM9zr4D0V9p+dkHxnGGxskc6s=
Received: from DS7PR06CA0016.namprd06.prod.outlook.com (2603:10b6:8:2a::29) by
 DS7PR12MB5935.namprd12.prod.outlook.com (2603:10b6:8:7e::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6277.33; Mon, 10 Apr 2023 18:47:50 +0000
Received: from DM6NAM11FT103.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:2a:cafe::3b) by DS7PR06CA0016.outlook.office365.com
 (2603:10b6:8:2a::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.39 via Frontend
 Transport; Mon, 10 Apr 2023 18:47:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT103.mail.protection.outlook.com (10.13.172.75) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6298.27 via Frontend Transport; Mon, 10 Apr 2023 18:47:49 +0000
Received: from platform-dev1.pensando.io (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Mon, 10 Apr 2023 13:47:46 -0500
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
Subject: [PATCH v13 13/15] mmc: sdhci-cadence: Add AMD Pensando Elba SoC support
Date:   Mon, 10 Apr 2023 11:45:24 -0700
Message-ID: <20230410184526.15990-14-blarson@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230410184526.15990-1-blarson@amd.com>
References: <20230410184526.15990-1-blarson@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT103:EE_|DS7PR12MB5935:EE_
X-MS-Office365-Filtering-Correlation-Id: ac6a6a63-7dac-47e8-aa11-08db39f41594
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IGUCWk+08nxlOIEwIu1fPzjOSgQL84fHP1Q2OmEdr9IaSPRG0HGDLKyD/A4RrN85W2XgNln5u4dq2mYZ/120KgPSlOZIqbQIboJC3wu5F28RROCbMH4EZ/3mpPCD81XfWjRh7j3jqxlpKlkE9pr5Burag5CRzKCDHnTWQc1IcTwR2yUDzA8oLDgzkq9GVVbJCs2xDVMB8G1/uikFVcEdMPChXc2WBAP1vput8yq6uBueOO0TEFKeia7WJh1SpzhZFYYXfU+lq0xnBL06KNjqgzKhYyec2s42BpzNBEo7Q8dXEWNAKN+I+QM3egxAORu3mDQSAJMC6k3I5YaPlVh1UviRAQUvAsrnvTT2DGsjWE7Ph4Cw+i3KLLqZZkZzsRovYbOHWegBX9DO6b74ScFo/LcJ6VADUlniKhhwdVMaUcXqKEQgxDEiTWRIa+MR88HoljfF1GcSw8SjJ+d6VuonvpUhYAyrPZUzsV7a0St09kStlLoqDfvpIZ5Aqgcct3BKzZqKmTLY3HFYMjvOr+85mSftp5O8PxMNfRsoM9H6zodOQg1tlXEAO7FOS4GHRNKq5T4ds6atPRyBYlmHzOXtGij9L1WGhfbO2yQqSjg3KsiUS5EVXTeklk38B/VGM4xLVhDcuT06Ju2n+tiefe/O9f69Dav2pj/8JKtjcLPxvYVizODFpeo1J5GeKFAFrLdM8gGIKPhyAIQK/2eoy5XwqeImwf/exrMRfEkoZcEUhxc=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(136003)(346002)(376002)(451199021)(36840700001)(46966006)(40470700004)(40460700003)(6916009)(7416002)(8676002)(4326008)(70586007)(82310400005)(82740400003)(70206006)(2906002)(316002)(81166007)(356005)(36756003)(5660300002)(8936002)(41300700001)(36860700001)(478600001)(7406005)(40480700001)(54906003)(426003)(336012)(2616005)(1076003)(26005)(186003)(16526019)(6666004)(83380400001)(47076005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2023 18:47:49.9143
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ac6a6a63-7dac-47e8-aa11-08db39f41594
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT103.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5935
X-Spam-Status: No, score=0.8 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for AMD Pensando Elba SoC which explicitly
controls byte-lane enables on writes.

Select MMC_SDHCI_IO_ACCESSORS for MMC_SDHCI_CADENCE which
allows Elba SoC sdhci_elba_ops to overwrite the SDHCI
IO memory accessors

Signed-off-by: Brad Larson <blarson@amd.com>
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
---

v13 changes:
- Use GENMASK(7, 3) in elba_priv_writel() to set all byte enables
- Add a variable 'shift' with GENMASK(1, 0) in elba_write_w() and
  elba_write_b() to set the byte enable variable.
 
v11 changes:
- Remove elba-drv_init() call to platform_get_resource() since that
  check is done inside devm_platform_ioremap_resource()
- Move spin_lock_init() before error check
- Remove extra parentheses

v10 changes:
- Add Elba specific support into this 3rd patch.  This builds on the private
  writel() enabled in patch 1 followed by platform specific init() in patch 2.
- Specify when first used the reason for the spinlock use to order byte-enable
  prior to write data.

---
 drivers/mmc/host/Kconfig         |  1 +
 drivers/mmc/host/sdhci-cadence.c | 98 ++++++++++++++++++++++++++++++++
 2 files changed, 99 insertions(+)

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
index c528a25f48b8..5d1e9cef74f5 100644
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
@@ -321,6 +323,91 @@ static void sdhci_cdns_set_uhs_signaling(struct sdhci_host *host,
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
+	writel(GENMASK(7, 3), priv->ctl_addr);
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
+	u32 shift = reg & GENMASK(1, 0);
+	unsigned long flags;
+	u32 byte_enables;
+
+	byte_enables = GENMASK(1, 0) << shift;
+	spin_lock_irqsave(&priv->wrlock, flags);
+	writel(ELBA_BYTE_ENABLE_MASK(byte_enables), priv->ctl_addr);
+	writew(val, host->ioaddr + reg);
+	spin_unlock_irqrestore(&priv->wrlock, flags);
+}
+
+static void elba_write_b(struct sdhci_host *host, u8 val, int reg)
+{
+	struct sdhci_cdns_priv *priv = sdhci_cdns_priv(host);
+	u32 shift = reg & GENMASK(1, 0);
+	unsigned long flags;
+	u32 byte_enables;
+
+	byte_enables = BIT(0) << shift;
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
+	void __iomem *ioaddr;
+
+	host->mmc->caps |= MMC_CAP_1_8V_DDR | MMC_CAP_8_BIT_DATA;
+	spin_lock_init(&priv->wrlock);
+
+	/* Byte-lane control register */
+	ioaddr = devm_platform_ioremap_resource(pdev, 1);
+	if (IS_ERR(ioaddr))
+		return PTR_ERR(ioaddr);
+
+	priv->ctl_addr = ioaddr;
+	priv->priv_writel = elba_priv_writel;
+	writel(ELBA_BYTE_ENABLE_MASK(0xf), priv->ctl_addr);
+
+	return 0;
+}
+
 static const struct sdhci_ops sdhci_cdns_ops = {
 	.set_clock = sdhci_set_clock,
 	.get_timeout_clock = sdhci_cdns_get_timeout_clock,
@@ -337,6 +424,13 @@ static const struct sdhci_cdns_drv_data sdhci_cdns_uniphier_drv_data = {
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
@@ -477,6 +571,10 @@ static const struct of_device_id sdhci_cdns_match[] = {
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

