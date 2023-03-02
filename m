Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BB036A7F3D
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 10:58:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229872AbjCBJ5k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 04:57:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229801AbjCBJ4t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 04:56:49 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 446C441B59;
        Thu,  2 Mar 2023 01:56:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677751002; x=1709287002;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=aLxp+1URLRVPcenJzUKCKdScjsWjaSh1cHEs+9h3X/E=;
  b=NFmbSpTm8EoelAZKBJ6jzen/t2aafelHlq8r7sO/Tu1pbpC4rvJY4qih
   wLI49Higeu0uAeykfV7m6C1nVSWrdadETuE9FS3X/gJlq4pqFc5E2EODV
   OgHCGgD6aIYX/A7k5WBUpt0Njb+LTwClW7ZwhsLceBjLNB0gO8NLj92hF
   GkEtfIaYI+5yn72LvaAoEPnnn53k47kwG6CYwlRxhqD2htNQGHrINEKrx
   UTfUuCCRO0C7BeRQd9e31Lg1XNbR+WQdTEcwgSl51gPempIKRNLghdMp/
   mSEFY2hncLKA4wkTv9yHrB5BgdvtWCncSA1L5sz4Y6abMVtrh80Z5/Tgu
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10636"; a="336976138"
X-IronPort-AV: E=Sophos;i="5.98,227,1673942400"; 
   d="scan'208";a="336976138"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2023 01:56:40 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10636"; a="743799670"
X-IronPort-AV: E=Sophos;i="5.98,227,1673942400"; 
   d="scan'208";a="743799670"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.251.217.72])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2023 01:56:35 -0800
Message-ID: <f291754f-222d-3809-78e0-5b57822733fa@intel.com>
Date:   Thu, 2 Mar 2023 11:56:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.8.0
Subject: Re: [RFC PATCH 5/5] mmc: sdhci-msm: Switch to the new ICE API
Content-Language: en-US
To:     Abel Vesa <abel.vesa@linaro.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Eric Biggers <ebiggers@google.com>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-mmc@vger.kernel.org, linux-scsi@vger.kernel.org
References: <20230214120253.1098426-1-abel.vesa@linaro.org>
 <20230214120253.1098426-6-abel.vesa@linaro.org>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20230214120253.1098426-6-abel.vesa@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/02/23 14:02, Abel Vesa wrote:
> Now that there is a new dedicated ICE driver, drop the sdhci-msm ICE
> implementation and use the new ICE api provided by the Qualcomm soc
> driver qcom-ice.
> 
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> ---
>  drivers/mmc/host/sdhci-msm.c | 252 ++++-------------------------------
>  1 file changed, 25 insertions(+), 227 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
> index 8ac81d57a3df..ac174d60641a 100644
> --- a/drivers/mmc/host/sdhci-msm.c
> +++ b/drivers/mmc/host/sdhci-msm.c
> @@ -19,6 +19,8 @@
>  #include <linux/pinctrl/consumer.h>
>  #include <linux/reset.h>
>  
> +#include <soc/qcom/ice.h>
> +
>  #include "sdhci-cqhci.h"
>  #include "sdhci-pltfm.h"
>  #include "cqhci.h"
> @@ -258,12 +260,12 @@ struct sdhci_msm_variant_info {
>  struct sdhci_msm_host {
>  	struct platform_device *pdev;
>  	void __iomem *core_mem;	/* MSM SDCC mapped address */
> -	void __iomem *ice_mem;	/* MSM ICE mapped address (if available) */
>  	int pwr_irq;		/* power irq */
>  	struct clk *bus_clk;	/* SDHC bus voter clock */
>  	struct clk *xo_clk;	/* TCXO clk needed for FLL feature of cm_dll*/
> -	/* core, iface, cal, sleep, and ice clocks */
> -	struct clk_bulk_data bulk_clks[5];
> +	/* core, iface, cal and sleep clocks */
> +	struct clk_bulk_data bulk_clks[4];
> +	struct qcom_ice *ice;
>  	unsigned long clk_rate;
>  	struct mmc_host *mmc;
>  	bool use_14lpp_dll_reset;
> @@ -1802,233 +1804,28 @@ static void sdhci_msm_set_clock(struct sdhci_host *host, unsigned int clock)
>   *                                                                           *
>  \*****************************************************************************/
>  
> -#ifdef CONFIG_MMC_CRYPTO
> -
> -#define AES_256_XTS_KEY_SIZE			64
> -
> -/* QCOM ICE registers */
> -
> -#define QCOM_ICE_REG_VERSION			0x0008
> -
> -#define QCOM_ICE_REG_FUSE_SETTING		0x0010
> -#define QCOM_ICE_FUSE_SETTING_MASK		0x1
> -#define QCOM_ICE_FORCE_HW_KEY0_SETTING_MASK	0x2
> -#define QCOM_ICE_FORCE_HW_KEY1_SETTING_MASK	0x4
> -
> -#define QCOM_ICE_REG_BIST_STATUS		0x0070
> -#define QCOM_ICE_BIST_STATUS_MASK		0xF0000000
> -
> -#define QCOM_ICE_REG_ADVANCED_CONTROL		0x1000
> -
> -#define sdhci_msm_ice_writel(host, val, reg)	\
> -	writel((val), (host)->ice_mem + (reg))
> -#define sdhci_msm_ice_readl(host, reg)	\
> -	readl((host)->ice_mem + (reg))
> -
> -static bool sdhci_msm_ice_supported(struct sdhci_msm_host *msm_host)
> -{
> -	struct device *dev = mmc_dev(msm_host->mmc);
> -	u32 regval = sdhci_msm_ice_readl(msm_host, QCOM_ICE_REG_VERSION);
> -	int major = regval >> 24;
> -	int minor = (regval >> 16) & 0xFF;
> -	int step = regval & 0xFFFF;
> -
> -	/* For now this driver only supports ICE version 3. */
> -	if (major != 3) {
> -		dev_warn(dev, "Unsupported ICE version: v%d.%d.%d\n",
> -			 major, minor, step);
> -		return false;
> -	}
> -
> -	dev_info(dev, "Found QC Inline Crypto Engine (ICE) v%d.%d.%d\n",
> -		 major, minor, step);
> -
> -	/* If fuses are blown, ICE might not work in the standard way. */
> -	regval = sdhci_msm_ice_readl(msm_host, QCOM_ICE_REG_FUSE_SETTING);
> -	if (regval & (QCOM_ICE_FUSE_SETTING_MASK |
> -		      QCOM_ICE_FORCE_HW_KEY0_SETTING_MASK |
> -		      QCOM_ICE_FORCE_HW_KEY1_SETTING_MASK)) {
> -		dev_warn(dev, "Fuses are blown; ICE is unusable!\n");
> -		return false;
> -	}
> -	return true;
> -}
> -
> -static inline struct clk *sdhci_msm_ice_get_clk(struct device *dev)
> -{
> -	return devm_clk_get(dev, "ice");
> -}
> -
> -static int sdhci_msm_ice_init(struct sdhci_msm_host *msm_host,
> -			      struct cqhci_host *cq_host)
> -{
> -	struct mmc_host *mmc = msm_host->mmc;
> -	struct device *dev = mmc_dev(mmc);
> -	struct resource *res;
> -
> -	if (!(cqhci_readl(cq_host, CQHCI_CAP) & CQHCI_CAP_CS))
> -		return 0;
> -
> -	res = platform_get_resource_byname(msm_host->pdev, IORESOURCE_MEM,
> -					   "ice");
> -	if (!res) {
> -		dev_warn(dev, "ICE registers not found\n");
> -		goto disable;
> -	}
> -
> -	if (!qcom_scm_ice_available()) {
> -		dev_warn(dev, "ICE SCM interface not found\n");
> -		goto disable;
> -	}
> -
> -	msm_host->ice_mem = devm_ioremap_resource(dev, res);
> -	if (IS_ERR(msm_host->ice_mem))
> -		return PTR_ERR(msm_host->ice_mem);
> -
> -	if (!sdhci_msm_ice_supported(msm_host))
> -		goto disable;
> -
> -	mmc->caps2 |= MMC_CAP2_CRYPTO;
> -	return 0;
> -
> -disable:
> -	dev_warn(dev, "Disabling inline encryption support\n");
> -	return 0;
> -}
> -
> -static void sdhci_msm_ice_low_power_mode_enable(struct sdhci_msm_host *msm_host)
> -{
> -	u32 regval;
> -
> -	regval = sdhci_msm_ice_readl(msm_host, QCOM_ICE_REG_ADVANCED_CONTROL);
> -	/*
> -	 * Enable low power mode sequence
> -	 * [0]-0, [1]-0, [2]-0, [3]-E, [4]-0, [5]-0, [6]-0, [7]-0
> -	 */
> -	regval |= 0x7000;
> -	sdhci_msm_ice_writel(msm_host, regval, QCOM_ICE_REG_ADVANCED_CONTROL);
> -}
> -
> -static void sdhci_msm_ice_optimization_enable(struct sdhci_msm_host *msm_host)
> -{
> -	u32 regval;
> -
> -	/* ICE Optimizations Enable Sequence */
> -	regval = sdhci_msm_ice_readl(msm_host, QCOM_ICE_REG_ADVANCED_CONTROL);
> -	regval |= 0xD807100;
> -	/* ICE HPG requires delay before writing */
> -	udelay(5);
> -	sdhci_msm_ice_writel(msm_host, regval, QCOM_ICE_REG_ADVANCED_CONTROL);
> -	udelay(5);
> -}
> -
> -/*
> - * Wait until the ICE BIST (built-in self-test) has completed.
> - *
> - * This may be necessary before ICE can be used.
> - *
> - * Note that we don't really care whether the BIST passed or failed; we really
> - * just want to make sure that it isn't still running.  This is because (a) the
> - * BIST is a FIPS compliance thing that never fails in practice, (b) ICE is
> - * documented to reject crypto requests if the BIST fails, so we needn't do it
> - * in software too, and (c) properly testing storage encryption requires testing
> - * the full storage stack anyway, and not relying on hardware-level self-tests.
> - */
> -static int sdhci_msm_ice_wait_bist_status(struct sdhci_msm_host *msm_host)
> -{
> -	u32 regval;
> -	int err;
> -
> -	err = readl_poll_timeout(msm_host->ice_mem + QCOM_ICE_REG_BIST_STATUS,
> -				 regval, !(regval & QCOM_ICE_BIST_STATUS_MASK),
> -				 50, 5000);
> -	if (err)
> -		dev_err(mmc_dev(msm_host->mmc),
> -			"Timed out waiting for ICE self-test to complete\n");
> -	return err;
> -}
> -
> -static void sdhci_msm_ice_enable(struct sdhci_msm_host *msm_host)
> -{
> -	if (!(msm_host->mmc->caps2 & MMC_CAP2_CRYPTO))
> -		return;
> -	sdhci_msm_ice_low_power_mode_enable(msm_host);
> -	sdhci_msm_ice_optimization_enable(msm_host);
> -	sdhci_msm_ice_wait_bist_status(msm_host);
> -}
> -
> -static int __maybe_unused sdhci_msm_ice_resume(struct sdhci_msm_host *msm_host)
> -{
> -	if (!(msm_host->mmc->caps2 & MMC_CAP2_CRYPTO))
> -		return 0;
> -	return sdhci_msm_ice_wait_bist_status(msm_host);
> -}
> -
>  /*
>   * Program a key into a QC ICE keyslot, or evict a keyslot.  QC ICE requires
>   * vendor-specific SCM calls for this; it doesn't support the standard way.
>   */
> +#ifdef CONFIG_MMC_CRYPTO
> +
>  static int sdhci_msm_program_key(struct cqhci_host *cq_host,
>  				 const union cqhci_crypto_cfg_entry *cfg,
>  				 int slot)
>  {
> -	struct device *dev = mmc_dev(cq_host->mmc);
> +	struct sdhci_host *host = mmc_priv(cq_host->mmc);
> +	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> +	struct sdhci_msm_host *msm_host = sdhci_pltfm_priv(pltfm_host);
>  	union cqhci_crypto_cap_entry cap;
> -	union {
> -		u8 bytes[AES_256_XTS_KEY_SIZE];
> -		u32 words[AES_256_XTS_KEY_SIZE / sizeof(u32)];
> -	} key;
> -	int i;
> -	int err;
> -
> -	if (!(cfg->config_enable & CQHCI_CRYPTO_CONFIGURATION_ENABLE))
> -		return qcom_scm_ice_invalidate_key(slot);
> +	bool config_enable = cfg->config_enable & CQHCI_CRYPTO_CONFIGURATION_ENABLE;
>  
>  	/* Only AES-256-XTS has been tested so far. */
>  	cap = cq_host->crypto_cap_array[cfg->crypto_cap_idx];
> -	if (cap.algorithm_id != CQHCI_CRYPTO_ALG_AES_XTS ||
> -	    cap.key_size != CQHCI_CRYPTO_KEY_SIZE_256) {
> -		dev_err_ratelimited(dev,
> -				    "Unhandled crypto capability; algorithm_id=%d, key_size=%d\n",
> -				    cap.algorithm_id, cap.key_size);
> -		return -EINVAL;
> -	}
> -
> -	memcpy(key.bytes, cfg->crypto_key, AES_256_XTS_KEY_SIZE);
>  
> -	/*
> -	 * The SCM call byte-swaps the 32-bit words of the key.  So we have to
> -	 * do the same, in order for the final key be correct.
> -	 */
> -	for (i = 0; i < ARRAY_SIZE(key.words); i++)
> -		__cpu_to_be32s(&key.words[i]);
> -
> -	err = qcom_scm_ice_set_key(slot, key.bytes, AES_256_XTS_KEY_SIZE,
> -				   QCOM_SCM_ICE_CIPHER_AES_256_XTS,
> -				   cfg->data_unit_size);
> -	memzero_explicit(&key, sizeof(key));
> -	return err;
> -}
> -#else /* CONFIG_MMC_CRYPTO */
> -static inline struct clk *sdhci_msm_ice_get_clk(struct device *dev)
> -{
> -	return NULL;
> -}
> -
> -static inline int sdhci_msm_ice_init(struct sdhci_msm_host *msm_host,
> -				     struct cqhci_host *cq_host)
> -{
> -	return 0;
> -}
> -
> -static inline void sdhci_msm_ice_enable(struct sdhci_msm_host *msm_host)
> -{
> -}
> -
> -static inline int __maybe_unused
> -sdhci_msm_ice_resume(struct sdhci_msm_host *msm_host)
> -{
> -	return 0;
> +	return qcom_ice_program_key(msm_host->ice, config_enable,
> +				   cfg->crypto_cap_idx, cap.algorithm_id,
> +				   cap.key_size, cfg->crypto_key, cfg->data_unit_size, slot);
>  }
>  #endif /* !CONFIG_MMC_CRYPTO */
>  
> @@ -2057,7 +1854,7 @@ static void sdhci_msm_cqe_enable(struct mmc_host *mmc)
>  	struct sdhci_msm_host *msm_host = sdhci_pltfm_priv(pltfm_host);
>  
>  	sdhci_cqe_enable(mmc);
> -	sdhci_msm_ice_enable(msm_host);
> +	qcom_ice_enable(msm_host->ice);
>  }
>  
>  static void sdhci_msm_cqe_disable(struct mmc_host *mmc, bool recovery)
> @@ -2149,9 +1946,13 @@ static int sdhci_msm_cqe_add_host(struct sdhci_host *host,
>  
>  	dma64 = host->flags & SDHCI_USE_64_BIT_DMA;
>  
> -	ret = sdhci_msm_ice_init(msm_host, cq_host);
> -	if (ret)
> -		goto cleanup;
> +	if (cqhci_readl(cq_host, CQHCI_CAP) & CQHCI_CAP_CS) {
> +		msm_host->ice = of_qcom_ice_get(&pdev->dev);
> +		if (IS_ERR(msm_host->ice)) {

This is not exactly equivalent to what was happening before
because in the case !defined(CONFIG_MMC_CRYPTO) there would
be no error here, but now there will be if
!IS_ENABLED(CONFIG_QCOM_INLINE_CRYPTO_ENGINE).

That may be what you want, but ideally this patch should only
change over to the new API and other changes, if desired,
should go on top as separate patches.

> +			ret = PTR_ERR(msm_host->ice);
> +			goto cleanup;
> +		}
> +	}
>  
>  	ret = cqhci_init(cq_host, host->mmc, dma64);
>  	if (ret) {
> @@ -2630,11 +2431,6 @@ static int sdhci_msm_probe(struct platform_device *pdev)
>  		clk = NULL;
>  	msm_host->bulk_clks[3].clk = clk;
>  
> -	clk = sdhci_msm_ice_get_clk(&pdev->dev);
> -	if (IS_ERR(clk))
> -		clk = NULL;
> -	msm_host->bulk_clks[4].clk = clk;
> -
>  	ret = clk_bulk_prepare_enable(ARRAY_SIZE(msm_host->bulk_clks),
>  				      msm_host->bulk_clks);
>  	if (ret)
> @@ -2853,7 +2649,9 @@ static __maybe_unused int sdhci_msm_runtime_resume(struct device *dev)
>  
>  	dev_pm_opp_set_rate(dev, msm_host->clk_rate);
>  
> -	return sdhci_msm_ice_resume(msm_host);
> +	if (!(msm_host->mmc->caps2 & MMC_CAP2_CRYPTO))
> +		return 0;
> +	return qcom_ice_resume(msm_host->ice);
>  }
>  
>  static const struct dev_pm_ops sdhci_msm_pm_ops = {

