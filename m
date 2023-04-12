Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0F7C6DF68F
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 15:10:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229950AbjDLNKs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 09:10:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229904AbjDLNKq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 09:10:46 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8CC48A53;
        Wed, 12 Apr 2023 06:10:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681305026; x=1712841026;
  h=message-id:date:mime-version:from:subject:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=9Be/X9craJFcoBQg5V8IL9lqIUT0f1XmUNDglAbqKA0=;
  b=ZLNhz/hNsI8Yk/wdHU6ystBKOo7OZr4y62Y+df9rXbmSJsd65+SNAg5E
   ilzOOvOHATIr+wOKUG/qRJMDR6aEilff+0ClUwJEEoDUjQeHmmLBISDS2
   /GGbnM8xy+CTq/TK5m+USNtk9rUV2b4zliA2DdDUqz33WfnbYaGUzNX2X
   3Ul9Byexl/NCdbOvW4MzTnSm1NYPucT4yMtmasVnhQcMuZyBiZ3c+raNJ
   BCFH1n0VtFQ/m79qClfCHXzZNUJp/0Fh0SqeyuPVX1qnBMVqDcY2KnBKb
   QsIUcHNuqjK0DMc8OETQtmejZqd7nBzvgqj8qQusDIvJ/twIpzKH8Yk1c
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10678"; a="343894914"
X-IronPort-AV: E=Sophos;i="5.98,339,1673942400"; 
   d="scan'208";a="343894914"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2023 06:10:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10678"; a="758223964"
X-IronPort-AV: E=Sophos;i="5.98,339,1673942400"; 
   d="scan'208";a="758223964"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.251.212.63])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2023 06:10:22 -0700
Message-ID: <6d547b64-2030-a722-5e6a-0e0f7d0cd8cd@intel.com>
Date:   Wed, 12 Apr 2023 16:10:18 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.10.0
From:   Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH V7 11/23] mmc: sdhci-uhs2: add set_power() to support vdd2
To:     Victor Shih <victorshihgli@gmail.com>, ulf.hansson@linaro.org
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        benchuanggli@gmail.com, HL.Liu@genesyslogic.com.tw,
        Greg.tu@genesyslogic.com.tw, takahiro.akashi@linaro.org,
        dlunev@chromium.org, Victor Shih <victor.shih@genesyslogic.com.tw>,
        Ben Chuang <ben.chuang@genesyslogic.com.tw>
References: <20230331105546.13607-1-victor.shih@genesyslogic.com.tw>
 <20230331105546.13607-12-victor.shih@genesyslogic.com.tw>
Content-Language: en-US
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20230331105546.13607-12-victor.shih@genesyslogic.com.tw>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31/03/23 13:55, Victor Shih wrote:
> This is a UHS-II version of sdhci's set_power operation.
> VDD2, as well as VDD, is handled here.
> 
> Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
> Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> Signed-off-by: Victor Shih <victor.shih@genesyslogic.com.tw>
> ---
>  drivers/mmc/host/sdhci-uhs2.c | 49 ++++++++++++++++++++++++++++
>  drivers/mmc/host/sdhci.c      | 61 +++++++++++++++++++----------------
>  drivers/mmc/host/sdhci.h      |  1 +
>  3 files changed, 83 insertions(+), 28 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-uhs2.c b/drivers/mmc/host/sdhci-uhs2.c
> index 67621eaabafc..3f232f4e0820 100644
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
> @@ -95,6 +102,48 @@ void sdhci_uhs2_reset(struct sdhci_host *host, u16 mask)
>  }
>  EXPORT_SYMBOL_GPL(sdhci_uhs2_reset);
>  
> +static void sdhci_uhs2_set_power(struct sdhci_host *host, unsigned char mode,
> +			  unsigned short vdd)

CHECK: Alignment should match open parenthesis
#42: FILE: drivers/mmc/host/sdhci-uhs2.c:106:
+static void sdhci_uhs2_set_power(struct sdhci_host *host, unsigned char mode,
+                         unsigned short vdd)


> +{
> +	struct mmc_host *mmc = host->mmc;
> +	u8 pwr;

pwr needs initialize to 0 i.e.

	u8 pwr = 0;

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
> +		mmc_opt_regulator_set_ocr(mmc, mmc->supply.vmmc2, fls(MMC_VDD_165_195) - 1);
> +
> +		/* Clear the power reg before setting a new value */
> +		sdhci_writeb(host, 0, SDHCI_POWER_CONTROL);
> +
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
> index e79e1b5d5cd4..a68a2dce0efe 100644
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
> @@ -2061,41 +2061,46 @@ static void sdhci_set_power_reg(struct sdhci_host *host, unsigned char mode,
>  		sdhci_writeb(host, 0, SDHCI_POWER_CONTROL);
>  }
>  
> +unsigned short sdhci_get_vdd_value(unsigned short vdd)
> +{
> +	switch (1 << vdd) {
> +	case MMC_VDD_165_195:
> +	/*
> +	 * Without a regulator, SDHCI does not support 2.0v
> +	 * so we only get here if the driver deliberately
> +	 * added the 2.0v range to ocr_avail. Map it to 1.8v
> +	 * for the purpose of turning on the power.
> +	 */
> +	case MMC_VDD_20_21:
> +		return SDHCI_POWER_180;
> +	case MMC_VDD_29_30:
> +	case MMC_VDD_30_31:
> +		return SDHCI_POWER_300;
> +	case MMC_VDD_32_33:
> +	case MMC_VDD_33_34:
> +	/*
> +	 * 3.4V ~ 3.6V are valid only for those platforms where it's
> +	 * known that the voltage reange is supported by hardware.
> +	 */
> +	case MMC_VDD_34_35:
> +	case MMC_VDD_35_36:
> +		return SDHCI_POWER_330;
> +	default:
> +		return 0;
> +	}
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
> index 5dffa334d3fc..02ea4a00ad63 100644
> --- a/drivers/mmc/host/sdhci.h
> +++ b/drivers/mmc/host/sdhci.h
> @@ -838,6 +838,7 @@ void sdhci_set_power(struct sdhci_host *host, unsigned char mode,
>  void sdhci_set_power_and_bus_voltage(struct sdhci_host *host,
>  				     unsigned char mode,
>  				     unsigned short vdd);
> +unsigned short sdhci_get_vdd_value(unsigned short vdd);
>  void sdhci_set_power_noreg(struct sdhci_host *host, unsigned char mode,
>  			   unsigned short vdd);
>  int sdhci_get_cd_nogpio(struct mmc_host *mmc);

