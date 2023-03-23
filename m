Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B19746C5B3B
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 01:11:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231194AbjCWAL4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 20:11:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231140AbjCWALi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 20:11:38 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2485B35EE2;
        Wed, 22 Mar 2023 17:11:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=USkBcuwhHIBAs83nSELKcqH16k4B4+TvNdI3CieXGZ28rhI0Q1ukdwZrmW93O3HROw6KOihlsfFmZi55pfaSoZJQGmPf2NJi9XyF0vqyX6MrC7jN83WjPm3PIEWilcqZ4OUMEu8G3FQWXX2sNzmf745FXPdNqNDxv/NZdgzabVwl910jIbFsMm3MYzaSRSGdYRZVY08x12aRZzBEI0F7X+CJ1bhla1C1xwz8BG1j+5cnjSP9MtJhxZWGycPuTk6ZiCdGp3PV6qOJzjp3jOT8yRrXlz4B5mCP2lK+7nvefNn2Z6BZdMaVqVrtHdAIQRXwDXhuwhXUMrRNKCwLo7wh6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w/oYrqJ2MVHAPXs4YEdRHbzeuMzFW5jeOoSN8M0D6iw=;
 b=SH4TSJ2qQCMjaCMTosy6w5EIdcMthjZ3+8Ud6lpLzcM6cjU1T8MT7KMK+2KL+Wv8/HQXfVK2GfJ/4v6mciJIlX+rlDcXFEUm5xnE5rljoj01dTTqzQOc6T6Tw9fVsGbRdY0lA3PxB74O9+sxnhuZfwF2tDtNLJz9AuVKKVwlTdZ/9NagXi6yrPEYrUwYlexqsGkISOa3pPIyTLX6iIwAypLZs3KvgQfv2HvFiSIi74A/L3Sy4fXtqKtcpaV8Kgu2BghTMq68R2rPmpCRAfS2Elrkiru3jjtWxaxMUUIjyZ5Jd66ewH842rDBIbwZCnNiLgXNMWgfM7dmr+WZwqq51A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w/oYrqJ2MVHAPXs4YEdRHbzeuMzFW5jeOoSN8M0D6iw=;
 b=IaHiZfO0RDpSxgJ7xbRMaMFRHWwykZl2ZNKnTacaiuRFh21p4PqJQdT/2FH5n8mgB+hZAayo1qC0l2s9mjEv9C7U9G2M0pC6AUVQlhL4/3TmpbU7zyV7MRsbpHQvQuBB05uzmZRPEp6bW1/Pm1fz3W3Z+OYWwfmazM7C8F41rjQ=
Received: from BN9PR03CA0767.namprd03.prod.outlook.com (2603:10b6:408:13a::22)
 by MW4PR12MB5627.namprd12.prod.outlook.com (2603:10b6:303:16a::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.38; Thu, 23 Mar
 2023 00:10:34 +0000
Received: from BL02EPF000100D2.namprd05.prod.outlook.com
 (2603:10b6:408:13a:cafe::6c) by BN9PR03CA0767.outlook.office365.com
 (2603:10b6:408:13a::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37 via Frontend
 Transport; Thu, 23 Mar 2023 00:10:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF000100D2.mail.protection.outlook.com (10.167.241.206) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6178.30 via Frontend Transport; Thu, 23 Mar 2023 00:10:34 +0000
Received: from platform-dev1.pensando.io (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Wed, 22 Mar 2023 19:10:31 -0500
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
Subject: [PATCH v12 13/15] mmc: sdhci-cadence: Add AMD Pensando Elba SoC support
Date:   Wed, 22 Mar 2023 17:06:55 -0700
Message-ID: <20230323000657.28664-14-blarson@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230323000657.28664-1-blarson@amd.com>
References: <20230323000657.28664-1-blarson@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF000100D2:EE_|MW4PR12MB5627:EE_
X-MS-Office365-Filtering-Correlation-Id: fb2008a5-bb39-4e9b-e457-08db2b3305a9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: luoOiRiGmtwpMoPdG3HlX3wOrCnPgqFd5IgNfdDbFKEKQiJ7DmI7ySCOcnfGEMQvSb99JOiz9BEjAgR/98fahKbO4PhybxqYHyFmJSFKWSfuE1LdsOmmyshSIaCnp7z+0FmJ1GcJePpWeLe6UOTDvSHoNomfBNaeHlalZYQDVEslr0P40fiAvfvlpv89HW50uDDK5O8LV/kva/t44bmqIQ7glrP00+JfwyWs/Z3EdtVlXzuwLtcdwiYB6SqjTg6l9DBr6ccU9LMsRebEE6O9UKpwWZyeawwnB19VokO06GgWHWtorxMfyqv7gJ1UJz8i9Wt2dkuZAtYbwD734zgOKu0IBK4ek+UE6hT/1BxBnZ5qnU8cArf2gif2Y4F5VrsMcohmrrCFnBe7istl2bb7M10sykclMnp4uq6jFxPRbqRIOgVRsO0M50q5x9hiaaKxZr49bwQQwTFyehDj3RlGUcuKCC8Y475YnOnkYfRxNPwOXgAXnSzkVOuL73LuL/ZV/hpe+FnMWXqEvQqYV6C3mnRaSaJdEd+T8x2/mnuvTt+ZchZ7gk/ebIgMrDw5oa2nvaAVOJSi3z2TPeR1g3H36Sj97DT71f4qdzXrkODJrX9Ao5mX6HS1MLyMmGZ9Fdwa471wXEPjbyNKFCf4zVGPk3P96jAQ9lmZaeLp7XAL2F5SASCNzD4aCD66C7zbV2/yZCBEFxPV2Vg+L/YkfWZZk+xmW1ImV7MfCyr/uGiGCCg=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(136003)(396003)(376002)(346002)(451199018)(46966006)(36840700001)(40470700004)(36860700001)(41300700001)(54906003)(7416002)(7406005)(5660300002)(47076005)(4326008)(6916009)(8676002)(2616005)(70586007)(70206006)(82310400005)(8936002)(81166007)(82740400003)(316002)(16526019)(426003)(2906002)(83380400001)(336012)(186003)(40460700003)(40480700001)(6666004)(356005)(1076003)(26005)(478600001)(36756003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2023 00:10:34.0778
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fb2008a5-bb39-4e9b-e457-08db2b3305a9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF000100D2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB5627
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
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
 drivers/mmc/host/sdhci-cadence.c | 96 ++++++++++++++++++++++++++++++++
 2 files changed, 97 insertions(+)

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
index c528a25f48b8..c0024d1e69a8 100644
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
@@ -321,6 +323,89 @@ static void sdhci_cdns_set_uhs_signaling(struct sdhci_host *host,
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
@@ -337,6 +422,13 @@ static const struct sdhci_cdns_drv_data sdhci_cdns_uniphier_drv_data = {
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
@@ -477,6 +569,10 @@ static const struct of_device_id sdhci_cdns_match[] = {
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

