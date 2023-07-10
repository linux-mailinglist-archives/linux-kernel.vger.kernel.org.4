Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8B5974DAAB
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 18:02:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233475AbjGJQCC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 12:02:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233735AbjGJQB6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 12:01:58 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C537A1AA;
        Mon, 10 Jul 2023 09:01:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689004908; x=1720540908;
  h=message-id:date:mime-version:from:subject:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=OfmvTlOQtPcCYQ7bsLnrzoUFFm3uHjLmmkaXcpLdxMg=;
  b=KRCoJ1IHrqheFrGyO3+VU1rqN+inADctKZTk2yLbZCHm9BtS9snAsnuQ
   JoBN/TP/zr5/ifvBHHv0xCWMIMCJFLj+vkR7twtYTgTwjqdJkiRMtf8YP
   LjXWkBsm/P6do3UMibT7RJEwUyL2W8ZZiaA36eR7qQs/SSzAVLlSgGcSm
   aTwu3sr4+aN2TRHT6zItBDkwDdQN8SwOnuKab7e6SD0nSo9C9VvF3lHuH
   6Mi1Ym69GgTIJ2Ay7Ir675abqv00eJm7svrF0y0WIQT2184xYMSM2dBwl
   uWjNHixXoAPmpSFXB68RxK+ipgN2RiJ8bw7MRZe11lStjCvcJAdlOccAV
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10767"; a="364421110"
X-IronPort-AV: E=Sophos;i="6.01,194,1684825200"; 
   d="scan'208";a="364421110"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2023 09:01:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10767"; a="834320123"
X-IronPort-AV: E=Sophos;i="6.01,194,1684825200"; 
   d="scan'208";a="834320123"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.251.220.97])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2023 09:01:43 -0700
Message-ID: <22c0134f-205e-e14d-f0ed-480cd779beff@intel.com>
Date:   Mon, 10 Jul 2023 19:01:40 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.13.0
From:   Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH V8 11/23] mmc: sdhci-uhs2: add set_power() to support vdd2
To:     Victor Shih <victorshihgli@gmail.com>, ulf.hansson@linaro.org
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        benchuanggli@gmail.com, HL.Liu@genesyslogic.com.tw,
        Greg.tu@genesyslogic.com.tw, takahiro.akashi@linaro.org,
        dlunev@chromium.org, Ben Chuang <ben.chuang@genesyslogic.com.tw>,
        Victor Shih <victor.shih@genesyslogic.com.tw>
References: <20230621100151.6329-1-victorshihgli@gmail.com>
 <20230621100151.6329-12-victorshihgli@gmail.com>
Content-Language: en-US
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20230621100151.6329-12-victorshihgli@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/06/23 13:01, Victor Shih wrote:
> From: Victor Shih <victor.shih@genesyslogic.com.tw>
> 
> This is a UHS-II version of sdhci's set_power operation.
> VDD2, as well as VDD, is handled here.
> 
> Updates in V8:
>  - Adjust the position of matching brackets.
>  - Add the initial value of the pwr in
>    sdhci_uhs2_set_power().
> 
> Updates in V7:
>  - Add clear the power reg before setting a new value
>    in sdhci_uhs2_set_power().
>  - Add MMC_VDD_34_35 case and MMC_VDD_35_36 case in
>    sdhci_get_vdd_value().
>  - Drop pwr variable in sdhci_get_vdd_value().
> 
> Updates in V6:
>  - Add mmc_opt_regulator_set_ocr().
>  - Remove unnecessary functions.
> 
> Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
> Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> Signed-off-by: Victor Shih <victor.shih@genesyslogic.com.tw>
> ---
>  drivers/mmc/host/sdhci-uhs2.c | 48 +++++++++++++++++++++++++++
>  drivers/mmc/host/sdhci.c      | 61 +++++++++++++++++++----------------
>  drivers/mmc/host/sdhci.h      |  1 +
>  3 files changed, 82 insertions(+), 28 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-uhs2.c b/drivers/mmc/host/sdhci-uhs2.c
> index dfc80a7f1bad..fc37a34629c2 100644
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
> @@ -94,6 +101,47 @@ void sdhci_uhs2_reset(struct sdhci_host *host, u16 mask)
>  }
>  EXPORT_SYMBOL_GPL(sdhci_uhs2_reset);
>  
> +static void sdhci_uhs2_set_power(struct sdhci_host *host, unsigned char mode, unsigned short vdd)
> +{
> +	struct mmc_host *mmc = host->mmc;
> +	u8 pwr = 0;
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
> index 753b251179f2..ef344d4edf8f 100644
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

reange -> range

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
> index 43ad3f4b7672..f3bd558b337f 100644
> --- a/drivers/mmc/host/sdhci.h
> +++ b/drivers/mmc/host/sdhci.h
> @@ -837,6 +837,7 @@ void sdhci_set_power(struct sdhci_host *host, unsigned char mode,
>  void sdhci_set_power_and_bus_voltage(struct sdhci_host *host,
>  				     unsigned char mode,
>  				     unsigned short vdd);
> +unsigned short sdhci_get_vdd_value(unsigned short vdd);
>  void sdhci_set_power_noreg(struct sdhci_host *host, unsigned char mode,
>  			   unsigned short vdd);
>  int sdhci_get_cd_nogpio(struct mmc_host *mmc);

