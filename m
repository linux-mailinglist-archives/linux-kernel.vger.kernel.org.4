Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12AE7672FD1
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 04:58:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230114AbjASD5J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 22:57:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229888AbjASDoY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 22:44:24 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DB776DB3D
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 19:41:14 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id bj3so1161596pjb.0
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 19:41:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pensando.io; s=google;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=CbqxDJadqrHHWLEsqeIAFGgTZLiSV774ziT3BrEvhqw=;
        b=OqFVgJ2CyegdNj4yCjQySTj/hxY5dmRFO2lZotk80k1FHPVx+fHgYVhtAA71OORn4O
         6B8/NVU1ONqJO9Mz4qipuHNDxcGGdXeoLKnKhfYCFgsEUcAfX12H89Yet1CD7dznb9c7
         w6KGjQQio9pf4mnHX/X6xgZ5vJVw0i9Ns32tXzFZH/8F0WwjqmJFkycp1IBL6HEcMsf3
         WU0h8MBL2WnETZKPFdEGQUrVw8ThhHF5wyRRRT9Oeec8T59/kGBHk5BfLSmVwB71VckY
         1a5EY7mfTP+xNocCdGuVHdSY85q1SERXEtFH5/hH1mAOQkkb82/Zo1V6VSLp55gqPCPP
         6kog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CbqxDJadqrHHWLEsqeIAFGgTZLiSV774ziT3BrEvhqw=;
        b=HVBv8ZKTrMN1tlSxEgdC0MDoXJ12ULERe+YZg4Ae5XIz4ocMHaYwMB1jwfMgdhghwu
         Hs31qYFVkngefD2j7OCr21w5MhZ1K+RaYN7n2phstPUyc9RC7JGCq30Qf+YgXgXscwDA
         Z1frYqivJ9WPA+g0O11LcVmokZc/K6mRO7yU0VY1V8u53odbwD+RW1UyqfYZx+NV7mAS
         0RdqeJN/LxUzdI45jYwWZvyO7cklrxWCo9zCyVCz8vkh4M5lZ+D5GMDilt3r94kSeQ4J
         5M1Oq22TPDBAdyjpf+ueQYl1cTojNt1hSOpif15ztwFwNMeyfR24Z0KObuLs8eSxmZFn
         H9lg==
X-Gm-Message-State: AFqh2kr/sC6oFkCM/IndHyPDpsjBZx2K6i3zor4tSf2gQ0MfiP2rqohh
        4fLb8WZpOvs40rd7++x1202LMw==
X-Google-Smtp-Source: AMrXdXvq1Zn+btSljOEN963muFuSxu9AHd46dZobV/seDM1fVcM/gK4DWUWqMjnkOmpVN5LOLuRBOA==
X-Received: by 2002:a05:6a20:4c8a:b0:b8:8e17:901c with SMTP id fq10-20020a056a204c8a00b000b88e17901cmr8034180pzb.52.1674099673971;
        Wed, 18 Jan 2023 19:41:13 -0800 (PST)
Received: from platform-dev1.pensando.io ([12.226.153.42])
        by smtp.gmail.com with ESMTPSA id f13-20020aa7968d000000b0056b4c5dde61sm11097879pfk.98.2023.01.18.19.41.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jan 2023 19:41:13 -0800 (PST)
From:   Brad Larson <brad@pensando.io>
X-Google-Original-From: Brad Larson <blarson@amd.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-spi@vger.kernel.org, adrian.hunter@intel.com,
        alcooperx@gmail.com, andy.shevchenko@gmail.com, arnd@arndb.de,
        brad@pensando.io, blarson@amd.com, brendan.higgins@linux.dev,
        briannorris@chromium.org, brijeshkumar.singh@amd.com,
        catalin.marinas@arm.com, davidgow@google.com, gsomlo@gmail.com,
        gerg@linux-m68k.org, krzk@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, lee@kernel.org,
        lee.jones@linaro.org, broonie@kernel.org,
        yamada.masahiro@socionext.com, p.zabel@pengutronix.de,
        piotrs@cadence.com, p.yadav@ti.com, rdunlap@infradead.org,
        robh+dt@kernel.org, samuel@sholland.org, fancer.lancer@gmail.com,
        skhan@linuxfoundation.org, suravee.suthikulpanit@amd.com,
        thomas.lendacky@amd.com, tonyhuang.sunplus@gmail.com,
        ulf.hansson@linaro.org, vaishnav.a@ti.com, will@kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH v9 13/15] mmc: sdhci-cadence: Add AMD Pensando Elba SoC support
Date:   Wed, 18 Jan 2023 19:39:16 -0800
Message-Id: <20230119033918.44117-14-blarson@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230119033918.44117-1-blarson@amd.com>
References: <20230119033918.44117-1-blarson@amd.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
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
IO memory accessors.

Signed-off-by: Brad Larson <blarson@amd.com>
---

Changes since v6:
- Previously patch 16/17

---
 drivers/mmc/host/Kconfig         |   1 +
 drivers/mmc/host/sdhci-cadence.c | 131 ++++++++++++++++++++++++++++---
 2 files changed, 123 insertions(+), 9 deletions(-)

diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
index 5e19a961c34d..9e41115cc753 100644
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
index 708d4297f241..e92aa79a8be2 100644
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
@@ -77,6 +79,11 @@ struct sdhci_cdns_phy_cfg {
 	u8 addr;
 };
 
+struct sdhci_cdns_drv_data {
+	int (*init)(struct platform_device *pdev);
+	const struct sdhci_pltfm_data pltfm_data;
+};
+
 static const struct sdhci_cdns_phy_cfg sdhci_cdns_phy_cfgs[] = {
 	{ "cdns,phy-input-delay-sd-highspeed", SDHCI_CDNS_PHY_DLY_SD_HS, },
 	{ "cdns,phy-input-delay-legacy", SDHCI_CDNS_PHY_DLY_SD_DEFAULT, },
@@ -316,6 +323,92 @@ static void sdhci_cdns_set_uhs_signaling(struct sdhci_host *host,
 		sdhci_set_uhs_signaling(host, timing);
 }
 
+/* Elba control register bits [6:3] are byte-lane enables */
+#define ELBA_BYTE_ENABLE_MASK(x)	((x) << 3)
+
+/*
+ * The Pensando Elba SoC explicitly controls byte-lane enabling on writes
+ * which includes writes to the HRS registers.
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
@@ -325,13 +418,24 @@ static const struct sdhci_ops sdhci_cdns_ops = {
 	.set_uhs_signaling = sdhci_cdns_set_uhs_signaling,
 };
 
-static const struct sdhci_pltfm_data sdhci_cdns_uniphier_pltfm_data = {
-	.ops = &sdhci_cdns_ops,
-	.quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN,
+static const struct sdhci_cdns_drv_data sdhci_cdns_uniphier_drv_data = {
+	.pltfm_data = {
+		.ops = &sdhci_cdns_ops,
+		.quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN,
+	},
 };
 
-static const struct sdhci_pltfm_data sdhci_cdns_pltfm_data = {
-	.ops = &sdhci_cdns_ops,
+static const struct sdhci_cdns_drv_data sdhci_elba_drv_data = {
+	.init = elba_drv_init,
+	.pltfm_data = {
+		.ops = &sdhci_elba_ops,
+	},
+};
+
+static const struct sdhci_cdns_drv_data sdhci_cdns_drv_data = {
+	.pltfm_data = {
+		.ops = &sdhci_cdns_ops,
+	},
 };
 
 static void sdhci_cdns_hs400_enhanced_strobe(struct mmc_host *mmc,
@@ -357,7 +461,7 @@ static void sdhci_cdns_hs400_enhanced_strobe(struct mmc_host *mmc,
 static int sdhci_cdns_probe(struct platform_device *pdev)
 {
 	struct sdhci_host *host;
-	const struct sdhci_pltfm_data *data;
+	const struct sdhci_cdns_drv_data *data;
 	struct sdhci_pltfm_host *pltfm_host;
 	struct sdhci_cdns_priv *priv;
 	struct clk *clk;
@@ -376,10 +480,10 @@ static int sdhci_cdns_probe(struct platform_device *pdev)
 
 	data = of_device_get_match_data(dev);
 	if (!data)
-		data = &sdhci_cdns_pltfm_data;
+		data = &sdhci_cdns_drv_data;
 
 	nr_phy_params = sdhci_cdns_phy_param_count(dev->of_node);
-	host = sdhci_pltfm_init(pdev, data,
+	host = sdhci_pltfm_init(pdev, &data->pltfm_data,
 				struct_size(priv, phy_params, nr_phy_params));
 	if (IS_ERR(host)) {
 		ret = PTR_ERR(host);
@@ -397,6 +501,11 @@ static int sdhci_cdns_probe(struct platform_device *pdev)
 	host->ioaddr += SDHCI_CDNS_SRS_BASE;
 	host->mmc_host_ops.hs400_enhanced_strobe =
 				sdhci_cdns_hs400_enhanced_strobe;
+	if (data->init) {
+		ret = data->init(pdev);
+		if (ret)
+			goto free;
+	}
 	sdhci_enable_v4_mode(host);
 	__sdhci_read_caps(host, &version, NULL, NULL);
 
@@ -461,7 +570,11 @@ static const struct dev_pm_ops sdhci_cdns_pm_ops = {
 static const struct of_device_id sdhci_cdns_match[] = {
 	{
 		.compatible = "socionext,uniphier-sd4hc",
-		.data = &sdhci_cdns_uniphier_pltfm_data,
+		.data = &sdhci_cdns_uniphier_drv_data,
+	},
+	{
+		.compatible = "amd,pensando-elba-sd4hc",
+		.data = &sdhci_elba_drv_data,
 	},
 	{ .compatible = "cdns,sd4hc" },
 	{ /* sentinel */ }
-- 
2.17.1

