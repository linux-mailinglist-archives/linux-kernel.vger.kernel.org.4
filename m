Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BA4B696306
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 13:03:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231751AbjBNMDk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 07:03:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232254AbjBNMDc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 07:03:32 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18E1E2687D
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 04:03:08 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id z13so10814353wmp.2
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 04:03:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kRutVX22B1oLnaZMX6E8eMn06aJ87jJTtFK6Ct6W8WE=;
        b=Rtk+7Jn/UtqvaIl45CO5TizinaVJBzGR82Wqv+sHX1PoJ18pZYiQXnTQ5JPrB2ngnQ
         cHXWLge84SFvyf6lZMcmIGQ0Rf5nvm/aZKpIMjFuVxSqlL/Tl2LRBoFIn3vjx2DX04pS
         FKajVGl+/ROJ4tk50D1iR84Hwf+kzCtlCxXxsC6iGkrV895IYf9ZOdD+oPdsQ5sr1bS2
         k2AhsvLhCg4G/2ap9F3DVOeKAqira+IE/Rt9Yl0TnQP1G2fUg+54Q5PutGx2O0yTTMvs
         0KLq71WAA2LWG5EhHgN/kUCZYnIdGqc6ZMd+YxE8f9hu61Qtw3vGQxTIGlkHBTDG6OWO
         ifaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kRutVX22B1oLnaZMX6E8eMn06aJ87jJTtFK6Ct6W8WE=;
        b=CfZ0w8em4JeNOx2AN5QEBfezx2CBDa31LNn8WTy1PGxOxZz8zibrGNRheh56vm2K3t
         ER38peMBNy36ACJoBuE6mfq3hWaHTH52aH0BE9bbY5EjstrX1GhkZWKfYk+zKUMdIbBO
         rivOVOHFRtCIA1Q3jiaJPV5Z1ODImMDYNRQnvHvBzbkrKJdh08xod7sOkiSYoCmp4DvZ
         gPUoSefPGf/T6c4JLOvfH9zy+LVcDwdqdyV3OFulg+qClvcsg1Hy8SFnHCL1cgJQuYJY
         8Jjz944PBwo3npR0fJOWW7ijzZTxStZ+jO7fOi70EEF9+bQOX0ELtAH1pwTb/8YqTmuD
         BjDQ==
X-Gm-Message-State: AO0yUKV4ZLZna2nNnGDy2WUkcAAcBY964o8vT8ik44bCul2z9DbgLs7B
        WE2vYAcQa7Fu7F1YaIwLqfzebA==
X-Google-Smtp-Source: AK7set+QulmjQkBueD7+xMOuzjBRtMO14fm5Fp5nKeRK+WAqYEkGuLB9TWlX++e/Dk2bjZfC0ajBIg==
X-Received: by 2002:a05:600c:130f:b0:3dd:1bcc:eb17 with SMTP id j15-20020a05600c130f00b003dd1bcceb17mr1852219wmf.28.1676376187411;
        Tue, 14 Feb 2023 04:03:07 -0800 (PST)
Received: from hackbox.lan ([94.52.112.99])
        by smtp.gmail.com with ESMTPSA id l40-20020a05600c1d2800b003dd1b00bd9asm18834846wms.32.2023.02.14.04.03.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Feb 2023 04:03:06 -0800 (PST)
From:   Abel Vesa <abel.vesa@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Eric Biggers <ebiggers@google.com>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-mmc@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: [RFC PATCH 5/5] mmc: sdhci-msm: Switch to the new ICE API
Date:   Tue, 14 Feb 2023 14:02:53 +0200
Message-Id: <20230214120253.1098426-6-abel.vesa@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230214120253.1098426-1-abel.vesa@linaro.org>
References: <20230214120253.1098426-1-abel.vesa@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that there is a new dedicated ICE driver, drop the sdhci-msm ICE
implementation and use the new ICE api provided by the Qualcomm soc
driver qcom-ice.

Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---
 drivers/mmc/host/sdhci-msm.c | 252 ++++-------------------------------
 1 file changed, 25 insertions(+), 227 deletions(-)

diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
index 8ac81d57a3df..ac174d60641a 100644
--- a/drivers/mmc/host/sdhci-msm.c
+++ b/drivers/mmc/host/sdhci-msm.c
@@ -19,6 +19,8 @@
 #include <linux/pinctrl/consumer.h>
 #include <linux/reset.h>
 
+#include <soc/qcom/ice.h>
+
 #include "sdhci-cqhci.h"
 #include "sdhci-pltfm.h"
 #include "cqhci.h"
@@ -258,12 +260,12 @@ struct sdhci_msm_variant_info {
 struct sdhci_msm_host {
 	struct platform_device *pdev;
 	void __iomem *core_mem;	/* MSM SDCC mapped address */
-	void __iomem *ice_mem;	/* MSM ICE mapped address (if available) */
 	int pwr_irq;		/* power irq */
 	struct clk *bus_clk;	/* SDHC bus voter clock */
 	struct clk *xo_clk;	/* TCXO clk needed for FLL feature of cm_dll*/
-	/* core, iface, cal, sleep, and ice clocks */
-	struct clk_bulk_data bulk_clks[5];
+	/* core, iface, cal and sleep clocks */
+	struct clk_bulk_data bulk_clks[4];
+	struct qcom_ice *ice;
 	unsigned long clk_rate;
 	struct mmc_host *mmc;
 	bool use_14lpp_dll_reset;
@@ -1802,233 +1804,28 @@ static void sdhci_msm_set_clock(struct sdhci_host *host, unsigned int clock)
  *                                                                           *
 \*****************************************************************************/
 
-#ifdef CONFIG_MMC_CRYPTO
-
-#define AES_256_XTS_KEY_SIZE			64
-
-/* QCOM ICE registers */
-
-#define QCOM_ICE_REG_VERSION			0x0008
-
-#define QCOM_ICE_REG_FUSE_SETTING		0x0010
-#define QCOM_ICE_FUSE_SETTING_MASK		0x1
-#define QCOM_ICE_FORCE_HW_KEY0_SETTING_MASK	0x2
-#define QCOM_ICE_FORCE_HW_KEY1_SETTING_MASK	0x4
-
-#define QCOM_ICE_REG_BIST_STATUS		0x0070
-#define QCOM_ICE_BIST_STATUS_MASK		0xF0000000
-
-#define QCOM_ICE_REG_ADVANCED_CONTROL		0x1000
-
-#define sdhci_msm_ice_writel(host, val, reg)	\
-	writel((val), (host)->ice_mem + (reg))
-#define sdhci_msm_ice_readl(host, reg)	\
-	readl((host)->ice_mem + (reg))
-
-static bool sdhci_msm_ice_supported(struct sdhci_msm_host *msm_host)
-{
-	struct device *dev = mmc_dev(msm_host->mmc);
-	u32 regval = sdhci_msm_ice_readl(msm_host, QCOM_ICE_REG_VERSION);
-	int major = regval >> 24;
-	int minor = (regval >> 16) & 0xFF;
-	int step = regval & 0xFFFF;
-
-	/* For now this driver only supports ICE version 3. */
-	if (major != 3) {
-		dev_warn(dev, "Unsupported ICE version: v%d.%d.%d\n",
-			 major, minor, step);
-		return false;
-	}
-
-	dev_info(dev, "Found QC Inline Crypto Engine (ICE) v%d.%d.%d\n",
-		 major, minor, step);
-
-	/* If fuses are blown, ICE might not work in the standard way. */
-	regval = sdhci_msm_ice_readl(msm_host, QCOM_ICE_REG_FUSE_SETTING);
-	if (regval & (QCOM_ICE_FUSE_SETTING_MASK |
-		      QCOM_ICE_FORCE_HW_KEY0_SETTING_MASK |
-		      QCOM_ICE_FORCE_HW_KEY1_SETTING_MASK)) {
-		dev_warn(dev, "Fuses are blown; ICE is unusable!\n");
-		return false;
-	}
-	return true;
-}
-
-static inline struct clk *sdhci_msm_ice_get_clk(struct device *dev)
-{
-	return devm_clk_get(dev, "ice");
-}
-
-static int sdhci_msm_ice_init(struct sdhci_msm_host *msm_host,
-			      struct cqhci_host *cq_host)
-{
-	struct mmc_host *mmc = msm_host->mmc;
-	struct device *dev = mmc_dev(mmc);
-	struct resource *res;
-
-	if (!(cqhci_readl(cq_host, CQHCI_CAP) & CQHCI_CAP_CS))
-		return 0;
-
-	res = platform_get_resource_byname(msm_host->pdev, IORESOURCE_MEM,
-					   "ice");
-	if (!res) {
-		dev_warn(dev, "ICE registers not found\n");
-		goto disable;
-	}
-
-	if (!qcom_scm_ice_available()) {
-		dev_warn(dev, "ICE SCM interface not found\n");
-		goto disable;
-	}
-
-	msm_host->ice_mem = devm_ioremap_resource(dev, res);
-	if (IS_ERR(msm_host->ice_mem))
-		return PTR_ERR(msm_host->ice_mem);
-
-	if (!sdhci_msm_ice_supported(msm_host))
-		goto disable;
-
-	mmc->caps2 |= MMC_CAP2_CRYPTO;
-	return 0;
-
-disable:
-	dev_warn(dev, "Disabling inline encryption support\n");
-	return 0;
-}
-
-static void sdhci_msm_ice_low_power_mode_enable(struct sdhci_msm_host *msm_host)
-{
-	u32 regval;
-
-	regval = sdhci_msm_ice_readl(msm_host, QCOM_ICE_REG_ADVANCED_CONTROL);
-	/*
-	 * Enable low power mode sequence
-	 * [0]-0, [1]-0, [2]-0, [3]-E, [4]-0, [5]-0, [6]-0, [7]-0
-	 */
-	regval |= 0x7000;
-	sdhci_msm_ice_writel(msm_host, regval, QCOM_ICE_REG_ADVANCED_CONTROL);
-}
-
-static void sdhci_msm_ice_optimization_enable(struct sdhci_msm_host *msm_host)
-{
-	u32 regval;
-
-	/* ICE Optimizations Enable Sequence */
-	regval = sdhci_msm_ice_readl(msm_host, QCOM_ICE_REG_ADVANCED_CONTROL);
-	regval |= 0xD807100;
-	/* ICE HPG requires delay before writing */
-	udelay(5);
-	sdhci_msm_ice_writel(msm_host, regval, QCOM_ICE_REG_ADVANCED_CONTROL);
-	udelay(5);
-}
-
-/*
- * Wait until the ICE BIST (built-in self-test) has completed.
- *
- * This may be necessary before ICE can be used.
- *
- * Note that we don't really care whether the BIST passed or failed; we really
- * just want to make sure that it isn't still running.  This is because (a) the
- * BIST is a FIPS compliance thing that never fails in practice, (b) ICE is
- * documented to reject crypto requests if the BIST fails, so we needn't do it
- * in software too, and (c) properly testing storage encryption requires testing
- * the full storage stack anyway, and not relying on hardware-level self-tests.
- */
-static int sdhci_msm_ice_wait_bist_status(struct sdhci_msm_host *msm_host)
-{
-	u32 regval;
-	int err;
-
-	err = readl_poll_timeout(msm_host->ice_mem + QCOM_ICE_REG_BIST_STATUS,
-				 regval, !(regval & QCOM_ICE_BIST_STATUS_MASK),
-				 50, 5000);
-	if (err)
-		dev_err(mmc_dev(msm_host->mmc),
-			"Timed out waiting for ICE self-test to complete\n");
-	return err;
-}
-
-static void sdhci_msm_ice_enable(struct sdhci_msm_host *msm_host)
-{
-	if (!(msm_host->mmc->caps2 & MMC_CAP2_CRYPTO))
-		return;
-	sdhci_msm_ice_low_power_mode_enable(msm_host);
-	sdhci_msm_ice_optimization_enable(msm_host);
-	sdhci_msm_ice_wait_bist_status(msm_host);
-}
-
-static int __maybe_unused sdhci_msm_ice_resume(struct sdhci_msm_host *msm_host)
-{
-	if (!(msm_host->mmc->caps2 & MMC_CAP2_CRYPTO))
-		return 0;
-	return sdhci_msm_ice_wait_bist_status(msm_host);
-}
-
 /*
  * Program a key into a QC ICE keyslot, or evict a keyslot.  QC ICE requires
  * vendor-specific SCM calls for this; it doesn't support the standard way.
  */
+#ifdef CONFIG_MMC_CRYPTO
+
 static int sdhci_msm_program_key(struct cqhci_host *cq_host,
 				 const union cqhci_crypto_cfg_entry *cfg,
 				 int slot)
 {
-	struct device *dev = mmc_dev(cq_host->mmc);
+	struct sdhci_host *host = mmc_priv(cq_host->mmc);
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+	struct sdhci_msm_host *msm_host = sdhci_pltfm_priv(pltfm_host);
 	union cqhci_crypto_cap_entry cap;
-	union {
-		u8 bytes[AES_256_XTS_KEY_SIZE];
-		u32 words[AES_256_XTS_KEY_SIZE / sizeof(u32)];
-	} key;
-	int i;
-	int err;
-
-	if (!(cfg->config_enable & CQHCI_CRYPTO_CONFIGURATION_ENABLE))
-		return qcom_scm_ice_invalidate_key(slot);
+	bool config_enable = cfg->config_enable & CQHCI_CRYPTO_CONFIGURATION_ENABLE;
 
 	/* Only AES-256-XTS has been tested so far. */
 	cap = cq_host->crypto_cap_array[cfg->crypto_cap_idx];
-	if (cap.algorithm_id != CQHCI_CRYPTO_ALG_AES_XTS ||
-	    cap.key_size != CQHCI_CRYPTO_KEY_SIZE_256) {
-		dev_err_ratelimited(dev,
-				    "Unhandled crypto capability; algorithm_id=%d, key_size=%d\n",
-				    cap.algorithm_id, cap.key_size);
-		return -EINVAL;
-	}
-
-	memcpy(key.bytes, cfg->crypto_key, AES_256_XTS_KEY_SIZE);
 
-	/*
-	 * The SCM call byte-swaps the 32-bit words of the key.  So we have to
-	 * do the same, in order for the final key be correct.
-	 */
-	for (i = 0; i < ARRAY_SIZE(key.words); i++)
-		__cpu_to_be32s(&key.words[i]);
-
-	err = qcom_scm_ice_set_key(slot, key.bytes, AES_256_XTS_KEY_SIZE,
-				   QCOM_SCM_ICE_CIPHER_AES_256_XTS,
-				   cfg->data_unit_size);
-	memzero_explicit(&key, sizeof(key));
-	return err;
-}
-#else /* CONFIG_MMC_CRYPTO */
-static inline struct clk *sdhci_msm_ice_get_clk(struct device *dev)
-{
-	return NULL;
-}
-
-static inline int sdhci_msm_ice_init(struct sdhci_msm_host *msm_host,
-				     struct cqhci_host *cq_host)
-{
-	return 0;
-}
-
-static inline void sdhci_msm_ice_enable(struct sdhci_msm_host *msm_host)
-{
-}
-
-static inline int __maybe_unused
-sdhci_msm_ice_resume(struct sdhci_msm_host *msm_host)
-{
-	return 0;
+	return qcom_ice_program_key(msm_host->ice, config_enable,
+				   cfg->crypto_cap_idx, cap.algorithm_id,
+				   cap.key_size, cfg->crypto_key, cfg->data_unit_size, slot);
 }
 #endif /* !CONFIG_MMC_CRYPTO */
 
@@ -2057,7 +1854,7 @@ static void sdhci_msm_cqe_enable(struct mmc_host *mmc)
 	struct sdhci_msm_host *msm_host = sdhci_pltfm_priv(pltfm_host);
 
 	sdhci_cqe_enable(mmc);
-	sdhci_msm_ice_enable(msm_host);
+	qcom_ice_enable(msm_host->ice);
 }
 
 static void sdhci_msm_cqe_disable(struct mmc_host *mmc, bool recovery)
@@ -2149,9 +1946,13 @@ static int sdhci_msm_cqe_add_host(struct sdhci_host *host,
 
 	dma64 = host->flags & SDHCI_USE_64_BIT_DMA;
 
-	ret = sdhci_msm_ice_init(msm_host, cq_host);
-	if (ret)
-		goto cleanup;
+	if (cqhci_readl(cq_host, CQHCI_CAP) & CQHCI_CAP_CS) {
+		msm_host->ice = of_qcom_ice_get(&pdev->dev);
+		if (IS_ERR(msm_host->ice)) {
+			ret = PTR_ERR(msm_host->ice);
+			goto cleanup;
+		}
+	}
 
 	ret = cqhci_init(cq_host, host->mmc, dma64);
 	if (ret) {
@@ -2630,11 +2431,6 @@ static int sdhci_msm_probe(struct platform_device *pdev)
 		clk = NULL;
 	msm_host->bulk_clks[3].clk = clk;
 
-	clk = sdhci_msm_ice_get_clk(&pdev->dev);
-	if (IS_ERR(clk))
-		clk = NULL;
-	msm_host->bulk_clks[4].clk = clk;
-
 	ret = clk_bulk_prepare_enable(ARRAY_SIZE(msm_host->bulk_clks),
 				      msm_host->bulk_clks);
 	if (ret)
@@ -2853,7 +2649,9 @@ static __maybe_unused int sdhci_msm_runtime_resume(struct device *dev)
 
 	dev_pm_opp_set_rate(dev, msm_host->clk_rate);
 
-	return sdhci_msm_ice_resume(msm_host);
+	if (!(msm_host->mmc->caps2 & MMC_CAP2_CRYPTO))
+		return 0;
+	return qcom_ice_resume(msm_host->ice);
 }
 
 static const struct dev_pm_ops sdhci_msm_pm_ops = {
-- 
2.34.1

