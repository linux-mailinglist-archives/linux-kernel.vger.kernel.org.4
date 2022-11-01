Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5707E61504A
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 18:14:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231259AbiKAROX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 13:14:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230146AbiKAROC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 13:14:02 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78685E33;
        Tue,  1 Nov 2022 10:13:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667322816; x=1698858816;
  h=message-id:date:mime-version:from:subject:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=Gk4ykGOQrrFGOZkX3n7veE6yahJppzXBMsWuGaLT/Yc=;
  b=Ui434w4tm2KvJeWIvF+rtKtZKcO5hMdG0OIpUP9wYl4wPT9Usnag0oXa
   5s8s4kaCMnQhtpnGmXQ3bLuuZEUEFWnaneU1tEMSxT1GptHlhFtx/73+U
   p7YM9+aBIzmKeX5niPlO9m2zU06jAEorzV7W5P9oLbu7L8o74bbJ542F+
   AYphqKRZ4tdfqkIYpWcHBivDQi+kNwSpB4WoeBLRbffU+EyUPmF4ewLdT
   foMNuwL+Z1pf90TlwJz5JlSVsXRxYoBOEhAljjwRC2txP+Dq4TW/JgqlM
   tdxTD9Yt7CqVLaxdhaLWGAbBuOnTKyUqAmt1ZaC7IHHsgwm4vO7fMvKiA
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10518"; a="310900038"
X-IronPort-AV: E=Sophos;i="5.95,231,1661842800"; 
   d="scan'208";a="310900038"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2022 10:13:35 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10518"; a="665219773"
X-IronPort-AV: E=Sophos;i="5.95,231,1661842800"; 
   d="scan'208";a="665219773"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.55.64])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2022 10:13:32 -0700
Message-ID: <96826b51-a980-0c25-f448-78bf726458fd@intel.com>
Date:   Tue, 1 Nov 2022 19:13:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.4.1
From:   Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH V5 12/26] mmc: sdhci-uhs2: add set_power() to support vdd2
To:     Victor Shih <victorshihgli@gmail.com>, ulf.hansson@linaro.org
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        benchuanggli@gmail.com, HL.Liu@genesyslogic.com.tw,
        Greg.tu@genesyslogic.com.tw, takahiro.akashi@linaro.org,
        dlunev@chromium.org, Victor Shih <victor.shih@genesyslogic.com.tw>,
        Ben Chuang <ben.chuang@genesyslogic.com.tw>
References: <20221019110647.11076-1-victor.shih@genesyslogic.com.tw>
 <20221019110647.11076-13-victor.shih@genesyslogic.com.tw>
Content-Language: en-US
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20221019110647.11076-13-victor.shih@genesyslogic.com.tw>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/10/22 14:06, Victor Shih wrote:
> This is a UHS-II version of sdhci's set_power operation.
> VDD2, as well as VDD, is handled here.
> 
> Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
> Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> Signed-off-by: Victor Shih <victor.shih@genesyslogic.com.tw>
> ---
>  drivers/mmc/host/sdhci-uhs2.c | 79 +++++++++++++++++++++++++++++++++++
>  drivers/mmc/host/sdhci-uhs2.h |  2 +
>  drivers/mmc/host/sdhci.c      | 66 ++++++++++++++++-------------
>  drivers/mmc/host/sdhci.h      |  2 +
>  4 files changed, 120 insertions(+), 29 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-uhs2.c b/drivers/mmc/host/sdhci-uhs2.c
> index 0e82f98d1967..896a1c8e55cf 100644
> --- a/drivers/mmc/host/sdhci-uhs2.c
> +++ b/drivers/mmc/host/sdhci-uhs2.c
> @@ -117,6 +117,85 @@ void sdhci_uhs2_reset(struct sdhci_host *host, u16 mask)
>  }
>  EXPORT_SYMBOL_GPL(sdhci_uhs2_reset);
>  
> +void sdhci_uhs2_set_power(struct sdhci_host *host, unsigned char mode,
> +			  unsigned short vdd)
> +{
> +	struct mmc_host *mmc = host->mmc;
> +	u8 pwr;
> +
> +	/* FIXME: check if flags & MMC_UHS2_SUPPORT? */
> +	if (!(sdhci_uhs2_mode(host))) {
> +		sdhci_set_power(host, mode, vdd);
> +		return;
> +	}

sdhci_uhs2_set_power() is called via ->uhs2_set_ios().  That should
not be called if not in UHS2 mode, so no check should be needed here.


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
> +		if (!IS_ERR(host->mmc->supply.vmmc))
> +			mmc_regulator_set_ocr(mmc, mmc->supply.vmmc, 0);

Seems to be a common if-clause.  Looks like we could use a
helper like:

static inline int mmc_opt_regulator_set_ocr(struct mmc_host *mmc,
					    struct regulator *supply,
					    unsigned short vdd_bit)
{
	return IS_ERR_OR_NULL(supply) ? 0 : mmc_regulator_set_ocr(mmc, supply, vdd_bit);
}


> +		if (!IS_ERR_OR_NULL(host->mmc->supply.vmmc2))
> +			mmc_regulator_set_ocr(mmc, mmc->supply.vmmc2, 0);
> +
> +		if (host->quirks2 & SDHCI_QUIRK2_CARD_ON_NEEDS_BUS_ON)
> +			sdhci_runtime_pm_bus_off(host);

Let's not support quirks that you don't need like
SDHCI_QUIRK2_CARD_ON_NEEDS_BUS_ON

> +	} else {
> +		if (!IS_ERR(host->mmc->supply.vmmc))
> +			mmc_regulator_set_ocr(mmc, mmc->supply.vmmc, vdd);
> +		if (!IS_ERR_OR_NULL(host->mmc->supply.vmmc2))
> +			/* support 1.8v only for now */
> +			mmc_regulator_set_ocr(mmc, mmc->supply.vmmc2,
> +					      fls(MMC_VDD2_165_195) - 1);
> +
> +		/*
> +		 * Spec says that we should clear the power reg before setting
> +		 * a new value. Some controllers don't seem to like this though.
> +		 */
> +		if (!(host->quirks & SDHCI_QUIRK_SINGLE_POWER_WRITE))

Let's not support quirks that you don't need like
SDHCI_QUIRK_SINGLE_POWER_WRITE
note this one is !

> +			sdhci_writeb(host, 0, SDHCI_POWER_CONTROL);
> +
> +		/*
> +		 * At least the Marvell CaFe chip gets confused if we set the
> +		 * voltage and set turn on power at the same time, so set the
> +		 * voltage first.
> +		 */
> +		if (host->quirks & SDHCI_QUIRK_NO_SIMULT_VDD_AND_POWER)
> +			sdhci_writeb(host, pwr, SDHCI_POWER_CONTROL);

Let's not support quirks that you don't need like
SDHCI_QUIRK_NO_SIMULT_VDD_AND_POWER

> +
> +		/* vdd first */
> +		pwr |= SDHCI_POWER_ON;
> +		sdhci_writeb(host, pwr & 0xf, SDHCI_POWER_CONTROL);
> +		mdelay(5);
> +
> +		pwr |= SDHCI_VDD2_POWER_ON;
> +		sdhci_writeb(host, pwr, SDHCI_POWER_CONTROL);
> +		mdelay(5);
> +
> +		if (host->quirks2 & SDHCI_QUIRK2_CARD_ON_NEEDS_BUS_ON)
> +			sdhci_runtime_pm_bus_on(host);

Let's not support quirks that you don't need like
SDHCI_QUIRK2_CARD_ON_NEEDS_BUS_ON

> +
> +		/*
> +		 * Some controllers need an extra 10ms delay of 10ms before
> +		 * they can apply clock after applying power
> +		 */
> +		if (host->quirks & SDHCI_QUIRK_DELAY_AFTER_POWER)
> +			mdelay(10);

Let's not support quirks that you don't need like
SDHCI_QUIRK_DELAY_AFTER_POWER

> +	}
> +}
> +EXPORT_SYMBOL_GPL(sdhci_uhs2_set_power);

It is only used in this file, so let's not export it.

> +
>  /*****************************************************************************\
>   *                                                                           *
>   * Driver init/exit                                                          *
> diff --git a/drivers/mmc/host/sdhci-uhs2.h b/drivers/mmc/host/sdhci-uhs2.h
> index 31776dcca5cf..3179915f7f79 100644
> --- a/drivers/mmc/host/sdhci-uhs2.h
> +++ b/drivers/mmc/host/sdhci-uhs2.h
> @@ -213,5 +213,7 @@ struct sdhci_host;
>  void sdhci_uhs2_dump_regs(struct sdhci_host *host);
>  bool sdhci_uhs2_mode(struct sdhci_host *host);
>  void sdhci_uhs2_reset(struct sdhci_host *host, u16 mask);
> +void sdhci_uhs2_set_power(struct sdhci_host *host, unsigned char mode,
> +			  unsigned short vdd);

Let's not export it for now.

>  
>  #endif /* __SDHCI_UHS2_H */
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index bd017c59a020..dfa0939a9058 100644
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
> @@ -186,13 +186,14 @@ static void sdhci_disable_card_detection(struct sdhci_host *host)
>  	sdhci_set_card_detection(host, false);
>  }
>  
> -static void sdhci_runtime_pm_bus_on(struct sdhci_host *host)
> +void sdhci_runtime_pm_bus_on(struct sdhci_host *host)
>  {
>  	if (host->bus_on)
>  		return;
>  	host->bus_on = true;
>  	pm_runtime_get_noresume(mmc_dev(host->mmc));
>  }
> +EXPORT_SYMBOL_GPL(sdhci_runtime_pm_bus_on);
>  
>  void sdhci_runtime_pm_bus_off(struct sdhci_host *host)
>  {
> @@ -2071,41 +2072,48 @@ static void sdhci_set_power_reg(struct sdhci_host *host, unsigned char mode,
>  		sdhci_writeb(host, 0, SDHCI_POWER_CONTROL);
>  }
>  
> +unsigned short sdhci_get_vdd_value(unsigned short vdd)
> +{
> +	u8 pwr;
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
> +	case MMC_VDD_29_30:
> +	case MMC_VDD_30_31:
> +		pwr = SDHCI_POWER_300;
> +		break;
> +	case MMC_VDD_32_33:
> +	case MMC_VDD_33_34:
> +		pwr = SDHCI_POWER_330;
> +		break;
> +	default:
> +		pwr = 0;
> +		break;
> +	}
> +
> +	return pwr;
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
> index 28716105da61..c34ca6ffbff6 100644
> --- a/drivers/mmc/host/sdhci.h
> +++ b/drivers/mmc/host/sdhci.h
> @@ -850,6 +850,7 @@ static inline void sdhci_read_caps(struct sdhci_host *host)
>  	__sdhci_read_caps(host, NULL, NULL, NULL);
>  }
>  
> +void sdhci_runtime_pm_bus_on(struct sdhci_host *host);
>  void sdhci_runtime_pm_bus_off(struct sdhci_host *host);
>  u16 sdhci_calc_clk(struct sdhci_host *host, unsigned int clock,
>  		   unsigned int *actual_clock);
> @@ -860,6 +861,7 @@ void sdhci_set_power(struct sdhci_host *host, unsigned char mode,
>  void sdhci_set_power_and_bus_voltage(struct sdhci_host *host,
>  				     unsigned char mode,
>  				     unsigned short vdd);
> +unsigned short sdhci_get_vdd_value(unsigned short vdd);
>  void sdhci_set_power_noreg(struct sdhci_host *host, unsigned char mode,
>  			   unsigned short vdd);
>  int sdhci_get_cd_nogpio(struct mmc_host *mmc);

