Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F5216B76DA
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 12:53:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231144AbjCMLxl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 07:53:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231423AbjCMLwp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 07:52:45 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D50664B38
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 04:52:20 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id o5-20020a05600c510500b003ec0e4ec6deso4648429wms.3
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 04:52:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678708338;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uRIW2zbp7MHqHx3c6UP9xAGWM5wcqXWcFdnNET+ThmQ=;
        b=z4bV5Z/kzaWyHAbljSYTLoVJZaLLiuN0W7E0VafYtUua1rxIbhjd/6sK7unW2rlsse
         6uB/k3KPdiddCPUY+jGj9EEg3/Klf+I9ciUae4AFGxIfavxS1MNjMCiU2p9Jeia20gKr
         JuKs7TZ4GjTM+vcIO5t9DRWkdtZJ0f0F7ys9W4147qJbV+lgNIvx61aYJ9D6LcGCJPsa
         g65s5YYRkVwt4T1LYiWyzFMFevKXiQ6FiIy+y/dpaCbbAxidBl5kHDQC7vVztOxd2r/6
         Av/tphPV6Q2s+mow/5UVEAy88AoqDzNV3GTzwb5wXKwl016DWpKdJWwfIRugS71Eqnqk
         aHlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678708338;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uRIW2zbp7MHqHx3c6UP9xAGWM5wcqXWcFdnNET+ThmQ=;
        b=7vG6JslkD7KZr17gI6O+9PEpz0fM1d/g5Qh4ipCS9eB3bzMaMEfvuF14bPNOyJEKyX
         JrGph0UeeQkqqDi38idskYlc8mJw7M8CAG1f6t40DoKqR/+o9vRsxF13gGNEkbE9U0EM
         Je8kepKF5Fk1UNZrTY0XYt13ODv4Up5Psp98Uk2GAYl6vxbBNAcmd6r6kiTAxI/UNCZ3
         FfyOrvCl/oKxta00U18QpUDw586mw/3n4dU2cLeBo4g6EC4KjG24/u5TupXjNV8zptJx
         7dVvNgrZJykzlsuIyoeMBKL+DZ2/yNAsmJbxlcydjeJtVPBSw3LyqNmd8IE/6BR96eS/
         qIVw==
X-Gm-Message-State: AO0yUKWDdWCj3PJS95WUDFju+WqPJ157qcFrzLUIA0RIX0ED0Q45O09o
        RFu8KjK6wHtv7UFQ0Tc8M8uDIw==
X-Google-Smtp-Source: AK7set9zeZ2Nx7PmlEnsRpcHcGPEm/iUhVy7d50+0gwnxi8fsyDyYiB3oO3FnbK9mqX+nNELjEB7mw==
X-Received: by 2002:a05:600c:1d84:b0:3eb:2de8:b72a with SMTP id p4-20020a05600c1d8400b003eb2de8b72amr10361650wms.7.1678708338647;
        Mon, 13 Mar 2023 04:52:18 -0700 (PDT)
Received: from localhost.localdomain ([94.52.112.99])
        by smtp.gmail.com with ESMTPSA id u15-20020a05600c440f00b003e21dcccf9fsm8801090wmn.16.2023.03.13.04.52.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Mar 2023 04:52:18 -0700 (PDT)
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
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Biggers <ebiggers@kernel.org>
Cc:     linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-scsi@vger.kernel.org
Subject: [RFC PATCH v3 6/7] mmc: sdhci-msm: Switch to the new ICE API
Date:   Mon, 13 Mar 2023 13:52:01 +0200
Message-Id: <20230313115202.3960700-7-abel.vesa@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230313115202.3960700-1-abel.vesa@linaro.org>
References: <20230313115202.3960700-1-abel.vesa@linaro.org>
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
driver ice. The platforms that already have ICE support will use the
API as library since there will not be a devicetree node, but instead
they have reg range. In this case, the of_qcom_ice_get will return an
ICE instance created for the consumer's device. But if there are
platforms that do not have ice reg in the consumer devicetree node
and instead provide a dedicated ICE devicetree node, theof_qcom_ice_get
will look up the device based on qcom,ice property and will get the ICE
instance registered by the probe function of the ice driver.

Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---

Changes since v2:
 * added the suspend API call for ICE
 * kept old wrappers over ICE API in

Changes since v1:
 * Added a check for supported algorithm and key size
   and passed the ICE defined values for algorithm and key size
 * Added call to evict function

 drivers/mmc/host/Kconfig     |   2 +-
 drivers/mmc/host/sdhci-msm.c | 215 ++++++-----------------------------
 2 files changed, 36 insertions(+), 181 deletions(-)

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
index 8ac81d57a3df..870bc466be44 100644
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
@@ -258,12 +260,14 @@ struct sdhci_msm_variant_info {
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
+#ifdef CONFIG_MMC_CRYPTO
+	struct qcom_ice *ice;
+#endif
 	unsigned long clk_rate;
 	struct mmc_host *mmc;
 	bool use_14lpp_dll_reset;
@@ -1804,164 +1808,39 @@ static void sdhci_msm_set_clock(struct sdhci_host *host, unsigned int clock)
 
 #ifdef CONFIG_MMC_CRYPTO
 
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
 static int sdhci_msm_ice_init(struct sdhci_msm_host *msm_host,
 			      struct cqhci_host *cq_host)
 {
 	struct mmc_host *mmc = msm_host->mmc;
 	struct device *dev = mmc_dev(mmc);
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
+	int ret = 0;
 
-	if (!qcom_scm_ice_available()) {
-		dev_warn(dev, "ICE SCM interface not found\n");
-		goto disable;
+	if (cqhci_readl(cq_host, CQHCI_CAP) & CQHCI_CAP_CS) {
+		msm_host->ice = of_qcom_ice_get(dev);
+		if (IS_ERR(msm_host->ice))
+			ret = PTR_ERR(msm_host->ice);
 	}
 
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
+	return ret;
 }
 
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
+static void sdhci_msm_ice_enable(struct sdhci_msm_host *msm_host)
 {
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
+	qcom_ice_enable(msm_host->ice);
 }
 
-static void sdhci_msm_ice_enable(struct sdhci_msm_host *msm_host)
+static int __maybe_unused sdhci_msm_ice_resume(struct sdhci_msm_host *msm_host)
 {
 	if (!(msm_host->mmc->caps2 & MMC_CAP2_CRYPTO))
-		return;
-	sdhci_msm_ice_low_power_mode_enable(msm_host);
-	sdhci_msm_ice_optimization_enable(msm_host);
-	sdhci_msm_ice_wait_bist_status(msm_host);
+		return 0;
+	return qcom_ice_resume(msm_host->ice);
 }
 
-static int __maybe_unused sdhci_msm_ice_resume(struct sdhci_msm_host *msm_host)
+static int __maybe_unused sdhci_msm_ice_suspend(struct sdhci_msm_host *msm_host)
 {
 	if (!(msm_host->mmc->caps2 & MMC_CAP2_CRYPTO))
 		return 0;
-	return sdhci_msm_ice_wait_bist_status(msm_host);
+	return qcom_ice_suspend(msm_host->ice);
 }
 
 /*
@@ -1972,48 +1851,29 @@ static int sdhci_msm_program_key(struct cqhci_host *cq_host,
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
 
-	err = qcom_scm_ice_set_key(slot, key.bytes, AES_256_XTS_KEY_SIZE,
-				   QCOM_SCM_ICE_CIPHER_AES_256_XTS,
-				   cfg->data_unit_size);
-	memzero_explicit(&key, sizeof(key));
-	return err;
+	if (cfg->config_enable & CQHCI_CRYPTO_CONFIGURATION_ENABLE)
+		return qcom_ice_program_key(msm_host->ice,
+					    cfg->crypto_cap_idx,
+					    QCOM_ICE_CRYPTO_ALG_AES_XTS,
+					    QCOM_ICE_CRYPTO_KEY_SIZE_256,
+					    cfg->crypto_key,
+					    cfg->data_unit_size, slot);
+	else
+		return qcom_ice_evict_key(msm_host->ice, slot);
 }
+
 #else /* CONFIG_MMC_CRYPTO */
-static inline struct clk *sdhci_msm_ice_get_clk(struct device *dev)
-{
-	return NULL;
-}
 
 static inline int sdhci_msm_ice_init(struct sdhci_msm_host *msm_host,
 				     struct cqhci_host *cq_host)
@@ -2630,11 +2490,6 @@ static int sdhci_msm_probe(struct platform_device *pdev)
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
@@ -2827,7 +2682,7 @@ static __maybe_unused int sdhci_msm_runtime_suspend(struct device *dev)
 	clk_bulk_disable_unprepare(ARRAY_SIZE(msm_host->bulk_clks),
 				   msm_host->bulk_clks);
 
-	return 0;
+	return sdhci_msm_ice_suspend(msm_host);
 }
 
 static __maybe_unused int sdhci_msm_runtime_resume(struct device *dev)
-- 
2.34.1

