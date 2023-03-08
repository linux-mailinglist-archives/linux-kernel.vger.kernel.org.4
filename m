Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62FB06B0E02
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 17:00:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232398AbjCHQAo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 11:00:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232417AbjCHP7w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 10:59:52 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1418738EA4
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 07:59:21 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id j3so10129053wms.2
        for <linux-kernel@vger.kernel.org>; Wed, 08 Mar 2023 07:59:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678291158;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ck/palmYTP8fasbvz+Rpi5Ka2XmfXpWoqV0Vrpy+1GU=;
        b=tHML1VDhmT05adbczODJ/hRNqaIMrv9ogdrixBdRE/VYRgEEOWKXDqKHCvNyi7IG4B
         dUsSyjNLVIkjlB0tRWk/wuUsDsPyT1S9Bm6bmGEkRhwzuWKYQXeL1u8v/1NEs+8lItd9
         zWIMTZ41WR2wu1vSMtLIFgqoTeXoAMfmzdwvge7sYWSyxCrYxWSBLq0lAq0ILmEoSjLK
         mgWgQpDQlpBvZO/XoRdH2acC3s/bdhrcZRG0CZtd5Bjv0lS4C8jZ4kXqkWt5nXWFPV9y
         tXCXdWoN5cICE2COZs3brxUiixz0UaR2/epYKBvgZlGdG7u8Z1IHcLGODLMCmaz7uKTl
         BLdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678291158;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ck/palmYTP8fasbvz+Rpi5Ka2XmfXpWoqV0Vrpy+1GU=;
        b=IdP3FPzrw0i7xVQGpT5G8wLRdQykRTnsAjwLKvhPwTW9++H5Z1yrK5yaaC76DVxg89
         NT5NvQRQV6wxIEbC79fKIgrXyW638EthXB0DeJi4mU6Fz5PyKWYDIYNi/pF8BeTBJkty
         +kb6pcf9HlFVw8O0muiMserpEuXyXdrJ07aXIGbRRk6j1WdEcUgOi0bdT2psU7s9N87z
         8gtOAi8CWzD4XFFs/9/YwUj4wSTF67NuhhxRoXG2RYAPnsQFoDF4yPy58OesH3768m7X
         lUwFjBKlUc5NdEyIEz2r+/AcIJuLWQsWojp3viehawY3ubuwvW8KO9tUu5Covdb24w24
         JLmA==
X-Gm-Message-State: AO0yUKV0TOGahpAki+RxSPb8M7cNN+dl2cUMJb4AQ0bAY5oTUhYz1yXC
        6pvn2/grrr+ZnDFLmMFMEsPP3g==
X-Google-Smtp-Source: AK7set+vYdFej2O2qQrEUer1x6h1WTgLgpIdQUhzLpZw25pZJfbJKiyOMbkOfihLqQ7pnTlPz0Z5fw==
X-Received: by 2002:a05:600c:a49:b0:3eb:3692:644e with SMTP id c9-20020a05600c0a4900b003eb3692644emr16408043wmq.33.1678291158562;
        Wed, 08 Mar 2023 07:59:18 -0800 (PST)
Received: from hackbox.lan ([94.52.112.99])
        by smtp.gmail.com with ESMTPSA id 16-20020a05600c229000b003eb2e33f327sm2548430wmf.2.2023.03.08.07.59.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Mar 2023 07:59:17 -0800 (PST)
From:   Abel Vesa <abel.vesa@linaro.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>
Cc:     linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: [RFC PATCH v2 6/7] mmc: sdhci-msm: Switch to the new ICE API
Date:   Wed,  8 Mar 2023 17:58:37 +0200
Message-Id: <20230308155838.1094920-7-abel.vesa@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230308155838.1094920-1-abel.vesa@linaro.org>
References: <20230308155838.1094920-1-abel.vesa@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
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

Changes since v1:
 * Added a check for supported algorithm and key size
   and passed the ICE defined values for algorithm and key size
 * Added call to evict function

 drivers/mmc/host/Kconfig     |   2 +-
 drivers/mmc/host/sdhci-msm.c | 257 +++++------------------------------
 2 files changed, 33 insertions(+), 226 deletions(-)

diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
index 4745fe217ade..09f837df5435 100644
--- a/drivers/mmc/host/Kconfig
+++ b/drivers/mmc/host/Kconfig
@@ -549,7 +549,7 @@ config MMC_SDHCI_MSM
 	depends on MMC_SDHCI_PLTFM
 	select MMC_SDHCI_IO_ACCESSORS
 	select MMC_CQHCI
-	select QCOM_SCM if MMC_CRYPTO
+	select QCOM_INLINE_CRYPTO_ENGINE if MMC_CRYPTO
 	help
 	  This selects the Secure Digital Host Controller Interface (SDHCI)
 	  support present in Qualcomm SOCs. The controller supports
diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
index 8ac81d57a3df..5f00c0695527 100644
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
@@ -1802,233 +1804,37 @@ static void sdhci_msm_set_clock(struct sdhci_host *host, unsigned int clock)
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
 	if (cap.algorithm_id != CQHCI_CRYPTO_ALG_AES_XTS ||
-	    cap.key_size != CQHCI_CRYPTO_KEY_SIZE_256) {
-		dev_err_ratelimited(dev,
-				    "Unhandled crypto capability; algorithm_id=%d, key_size=%d\n",
-				    cap.algorithm_id, cap.key_size);
+		cap.key_size != CQHCI_CRYPTO_KEY_SIZE_256)
 		return -EINVAL;
-	}
-
-	memcpy(key.bytes, cfg->crypto_key, AES_256_XTS_KEY_SIZE);
-
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
 
-static inline int __maybe_unused
-sdhci_msm_ice_resume(struct sdhci_msm_host *msm_host)
-{
-	return 0;
+	if (config_enable)
+		return qcom_ice_program_key(msm_host->ice,
+					    cfg->crypto_cap_idx,
+					    QCOM_ICE_CRYPTO_ALG_AES_XTS,
+					    QCOM_ICE_CRYPTO_KEY_SIZE_256,
+					    cfg->crypto_key,
+					    cfg->data_unit_size, slot);
+	else
+		return qcom_ice_evict_key(msm_host->ice, slot);
 }
 #endif /* !CONFIG_MMC_CRYPTO */
 
@@ -2057,7 +1863,7 @@ static void sdhci_msm_cqe_enable(struct mmc_host *mmc)
 	struct sdhci_msm_host *msm_host = sdhci_pltfm_priv(pltfm_host);
 
 	sdhci_cqe_enable(mmc);
-	sdhci_msm_ice_enable(msm_host);
+	qcom_ice_enable(msm_host->ice);
 }
 
 static void sdhci_msm_cqe_disable(struct mmc_host *mmc, bool recovery)
@@ -2149,9 +1955,13 @@ static int sdhci_msm_cqe_add_host(struct sdhci_host *host,
 
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
@@ -2630,11 +2440,6 @@ static int sdhci_msm_probe(struct platform_device *pdev)
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
@@ -2853,7 +2658,9 @@ static __maybe_unused int sdhci_msm_runtime_resume(struct device *dev)
 
 	dev_pm_opp_set_rate(dev, msm_host->clk_rate);
 
-	return sdhci_msm_ice_resume(msm_host);
+	if (!(msm_host->mmc->caps2 & MMC_CAP2_CRYPTO))
+		return 0;
+	return qcom_ice_resume(msm_host->ice);
 }
 
 static const struct dev_pm_ops sdhci_msm_pm_ops = {
-- 
2.34.1

