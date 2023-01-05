Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28F3F65F5BB
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 22:27:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235813AbjAEV1T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 16:27:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235807AbjAEV1R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 16:27:17 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74A9963F4B;
        Thu,  5 Jan 2023 13:27:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672954036; x=1704490036;
  h=message-id:date:mime-version:from:subject:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=epuSkSpTV05tOW5Nee19IGsto+DluCEjzQHE5p2lsag=;
  b=TOvbsiL/P4vfwRfV0ABY+E1fFT3OuDdD5TfiL6XC8zXeSzcn9dnndW//
   0EckoiNR6cBcW/5r5wXsw66bo7XC/jV7xz4yf/sjEx04CXeGlgPWhO79g
   1w781v2xHXeU5Xs7v1mdFZT93VdlpfCcIa8uDvSVQXaqsY5rBC0qGf0v7
   PMT5qR8oTXm4JxCHyp713+cBkqpSah802eAZnlMC5gDkxPQfUXwQTywzp
   nn1lKXqsyGjGwAUmQbBZfYZiy//EjOghyeZ6zXoAQ+ZxywNyoeCF+KESp
   apQxbcfm4gxWv64WOZtYt/25vImR6+i7uzyvGbqRzOxOC5zva6AQ82l2O
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10581"; a="320035003"
X-IronPort-AV: E=Sophos;i="5.96,303,1665471600"; 
   d="scan'208";a="320035003"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2023 13:27:16 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10581"; a="657673488"
X-IronPort-AV: E=Sophos;i="5.96,303,1665471600"; 
   d="scan'208";a="657673488"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.249.42.126])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2023 13:27:12 -0800
Message-ID: <d828948f-2cd4-9bc1-688d-5de6bd7b58bc@intel.com>
Date:   Thu, 5 Jan 2023 23:27:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.6.1
From:   Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH V6 11/24] mmc: sdhci-uhs2: add set_power() to support vdd2
To:     Victor Shih <victorshihgli@gmail.com>, ulf.hansson@linaro.org
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        benchuanggli@gmail.com, HL.Liu@genesyslogic.com.tw,
        Greg.tu@genesyslogic.com.tw, takahiro.akashi@linaro.org,
        dlunev@chromium.org, Victor Shih <victor.shih@genesyslogic.com.tw>,
        Ben Chuang <ben.chuang@genesyslogic.com.tw>
References: <20221213090047.3805-1-victor.shih@genesyslogic.com.tw>
 <20221213090047.3805-12-victor.shih@genesyslogic.com.tw>
Content-Language: en-US
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20221213090047.3805-12-victor.shih@genesyslogic.com.tw>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/12/22 11:00, Victor Shih wrote:
> This is a UHS-II version of sdhci's set_power operation.
> VDD2, as well as VDD, is handled here.
> 
> Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
> Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> Signed-off-by: Victor Shih <victor.shih@genesyslogic.com.tw>
> ---
>  drivers/mmc/host/sdhci-uhs2.c | 46 +++++++++++++++++++++++++
>  drivers/mmc/host/sdhci.c      | 63 +++++++++++++++++++----------------
>  drivers/mmc/host/sdhci.h      |  1 +
>  3 files changed, 82 insertions(+), 28 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-uhs2.c b/drivers/mmc/host/sdhci-uhs2.c
> index ae862e1eadab..780491781613 100644
> --- a/drivers/mmc/host/sdhci-uhs2.c
> +++ b/drivers/mmc/host/sdhci-uhs2.c
> @@ -57,6 +57,13 @@ EXPORT_SYMBOL_GPL(sdhci_uhs2_dump_regs);
>   *                                                                           *
>  \*****************************************************************************/
>  
> +static inline int mmc_opt_regulator_set_ocr(struct mmc_host *mmc,
> +					    struct regulator *supply,
> +					    unsigned short vdd_bit)
> +{
> +	return IS_ERR_OR_NULL(supply) ? 0 : mmc_regulator_set_ocr(mmc, supply, vdd_bit);
> +}
> +
>  bool sdhci_uhs2_mode(struct sdhci_host *host)
>  {
>  	return host->mmc->flags & MMC_UHS2_SUPPORT;
> @@ -95,6 +102,45 @@ void sdhci_uhs2_reset(struct sdhci_host *host, u16 mask)
>  }
>  EXPORT_SYMBOL_GPL(sdhci_uhs2_reset);
>  
> +static void sdhci_uhs2_set_power(struct sdhci_host *host, unsigned char mode,
> +			  unsigned short vdd)
> +{
> +	struct mmc_host *mmc = host->mmc;
> +	u8 pwr;
> +
> +	if (mode != MMC_POWER_OFF) {
> +		pwr = sdhci_get_vdd_value(vdd);
> +		if (!pwr)
> +			WARN(1, "%s: Invalid vdd %#x\n",
> +			     mmc_hostname(host->mmc), vdd);
> +		pwr |= SDHCI_VDD2_POWER_180;
> +	}
> +
> +	if (host->pwr == pwr)
> +		return;
> +	host->pwr = pwr;
> +
> +	if (pwr == 0) {
> +		sdhci_writeb(host, 0, SDHCI_POWER_CONTROL);
> +
> +		mmc_opt_regulator_set_ocr(mmc, mmc->supply.vmmc, 0);
> +		mmc_opt_regulator_set_ocr(mmc, mmc->supply.vmmc2, 0);
> +	} else {
> +		mmc_opt_regulator_set_ocr(mmc, mmc->supply.vmmc, vdd);
> +		/* support 1.8v only for now */
> +		mmc_opt_regulator_set_ocr(mmc, mmc->supply.vmmc2, fls(MMC_VDD2_165_195) - 1);
> +
		/* Clear the power reg before setting a new value */
		sdhci_writeb(host, 0, SDHCI_POWER_CONTROL);

> +		/* vdd first */
> +		pwr |= SDHCI_POWER_ON;
> +		sdhci_writeb(host, pwr & 0xf, SDHCI_POWER_CONTROL);
> +		mdelay(5);
> +
> +		pwr |= SDHCI_VDD2_POWER_ON;
> +		sdhci_writeb(host, pwr, SDHCI_POWER_CONTROL);
> +		mdelay(5);
> +	}
> +}
> +
>  /*****************************************************************************\
>   *                                                                           *
>   * Driver init/exit                                                          *
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index 9b66b9a32c72..99633a3ef549 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -23,7 +23,7 @@
>  #include <linux/regulator/consumer.h>
>  #include <linux/pm_runtime.h>
>  #include <linux/of.h>
> -
> +#include <linux/bug.h>
>  #include <linux/leds.h>
>  
>  #include <linux/mmc/mmc.h>
> @@ -2061,41 +2061,48 @@ static void sdhci_set_power_reg(struct sdhci_host *host, unsigned char mode,
>  		sdhci_writeb(host, 0, SDHCI_POWER_CONTROL);
>  }
>  
> +unsigned short sdhci_get_vdd_value(unsigned short vdd)
> +{
> +	u8 pwr;

It is simpler without pwr

> +
> +	switch (1 << vdd) {
> +	case MMC_VDD_165_195:
> +	/*
> +	 * Without a regulator, SDHCI does not support 2.0v
> +	 * so we only get here if the driver deliberately
> +	 * added the 2.0v range to ocr_avail. Map it to 1.8v
> +	 * for the purpose of turning on the power.
> +	 */
> +	case MMC_VDD_20_21:
> +		pwr = SDHCI_POWER_180;
> +		break;

		return SDHCI_POWER_180;

> +	case MMC_VDD_29_30:
> +	case MMC_VDD_30_31:
> +		pwr = SDHCI_POWER_300;
> +		break;
		
		return SDHCI_POWER_300;

> +	case MMC_VDD_32_33:
> +	case MMC_VDD_33_34:

Missing:

	/*
	 * 3.4 ~ 3.6V are valid only for those platforms where it's
	 * known that the voltage range is supported by hardware.
	 */
	case MMC_VDD_34_35:
	case MMC_VDD_35_36:


> +		pwr = SDHCI_POWER_330;
> +		break;

		return SDHCI_POWER_330;

> +	default:
> +		pwr = 0;
> +		break;

		return 0;

> +	}
> +
> +	return pwr;

Not needed. Control never reaches it anymore.

> +}
> +EXPORT_SYMBOL_GPL(sdhci_get_vdd_value);
> +
>  void sdhci_set_power_noreg(struct sdhci_host *host, unsigned char mode,
>  			   unsigned short vdd)
>  {
>  	u8 pwr = 0;
>  
>  	if (mode != MMC_POWER_OFF) {
> -		switch (1 << vdd) {
> -		case MMC_VDD_165_195:
> -		/*
> -		 * Without a regulator, SDHCI does not support 2.0v
> -		 * so we only get here if the driver deliberately
> -		 * added the 2.0v range to ocr_avail. Map it to 1.8v
> -		 * for the purpose of turning on the power.
> -		 */
> -		case MMC_VDD_20_21:
> -			pwr = SDHCI_POWER_180;
> -			break;
> -		case MMC_VDD_29_30:
> -		case MMC_VDD_30_31:
> -			pwr = SDHCI_POWER_300;
> -			break;
> -		case MMC_VDD_32_33:
> -		case MMC_VDD_33_34:
> -		/*
> -		 * 3.4 ~ 3.6V are valid only for those platforms where it's
> -		 * known that the voltage range is supported by hardware.
> -		 */
> -		case MMC_VDD_34_35:
> -		case MMC_VDD_35_36:
> -			pwr = SDHCI_POWER_330;
> -			break;
> -		default:
> +		pwr = sdhci_get_vdd_value(vdd);
> +		if (!pwr) {
>  			WARN(1, "%s: Invalid vdd %#x\n",
>  			     mmc_hostname(host->mmc), vdd);
> -			break;
>  		}
>  	}
>  
> diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
> index f41c19c76994..df7fa0c0ebf8 100644
> --- a/drivers/mmc/host/sdhci.h
> +++ b/drivers/mmc/host/sdhci.h
> @@ -840,6 +840,7 @@ void sdhci_set_power(struct sdhci_host *host, unsigned char mode,
>  void sdhci_set_power_and_bus_voltage(struct sdhci_host *host,
>  				     unsigned char mode,
>  				     unsigned short vdd);
> +unsigned short sdhci_get_vdd_value(unsigned short vdd);
>  void sdhci_set_power_noreg(struct sdhci_host *host, unsigned char mode,
>  			   unsigned short vdd);
>  int sdhci_get_cd_nogpio(struct mmc_host *mmc);

