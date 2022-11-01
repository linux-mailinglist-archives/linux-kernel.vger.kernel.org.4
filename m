Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 471C9615044
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 18:13:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230124AbiKARNp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 13:13:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230503AbiKARNa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 13:13:30 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCB281DA59;
        Tue,  1 Nov 2022 10:13:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667322799; x=1698858799;
  h=message-id:date:mime-version:from:subject:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=bes3jvsXT+BQrafwLQpWTF9YBHCdZpiEHfnkSVTlnZc=;
  b=IPr6wJYBzUJ6d7WR8vxZLqdWO+0e6HygCtmN1LKTq+YfDgrHVJ9gVJWU
   uzgw3DfcOQcOoiwHGok9vqZpu9iP3JznkP5mTREk8JD2uviiU++cBabG/
   8uwxeQnTqzKSKzWDxEGpsIQT5K6T1r2BRetaDr8e1Pd66OMHKkjYojbcC
   EcKGK0VGiVBzjyJr6zpjecxKFiSYTKw5vU4YMLojq7WpRTvtPiGegmTfS
   uOA6GngKVbRcq5rDaxSewRuU8bRTL5Q6VCtgoQ0Oz7a4GXLCd1FOKYPnQ
   urSDdF+NF51RBBzqz6ueDsPs+ieZLQgx6ge+Zu41WR2CrJDVj5tt7sa+0
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10518"; a="395503867"
X-IronPort-AV: E=Sophos;i="5.95,231,1661842800"; 
   d="scan'208";a="395503867"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2022 10:13:19 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10518"; a="723228977"
X-IronPort-AV: E=Sophos;i="5.95,231,1661842800"; 
   d="scan'208";a="723228977"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.55.64])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2022 10:13:15 -0700
Message-ID: <feab70af-0255-e7b2-9ff7-f26ee852ee00@intel.com>
Date:   Tue, 1 Nov 2022 19:13:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.4.1
From:   Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH V5 11/26] mmc: sdhci-uhs2: add reset function and
 uhs2_mode function
To:     Victor Shih <victorshihgli@gmail.com>, ulf.hansson@linaro.org
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        benchuanggli@gmail.com, HL.Liu@genesyslogic.com.tw,
        Greg.tu@genesyslogic.com.tw, takahiro.akashi@linaro.org,
        dlunev@chromium.org, Victor Shih <victor.shih@genesyslogic.com.tw>,
        Ben Chuang <ben.chuang@genesyslogic.com.tw>
References: <20221019110647.11076-1-victor.shih@genesyslogic.com.tw>
 <20221019110647.11076-12-victor.shih@genesyslogic.com.tw>
Content-Language: en-US
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20221019110647.11076-12-victor.shih@genesyslogic.com.tw>
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
> Sdhci_uhs2_reset() does a UHS-II specific reset operation.
> 
> Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
> Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> Signed-off-by: Victor Shih <victor.shih@genesyslogic.com.tw>
> ---
>  drivers/mmc/host/sdhci-pci-core.c |  1 +
>  drivers/mmc/host/sdhci-pci-gli.c  |  1 +
>  drivers/mmc/host/sdhci-uhs2.c     | 68 +++++++++++++++++++++++++++++++
>  drivers/mmc/host/sdhci-uhs2.h     |  3 ++
>  drivers/mmc/host/sdhci.c          |  3 +-
>  drivers/mmc/host/sdhci.h          | 14 +++++++
>  6 files changed, 89 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/sdhci-pci-core.c b/drivers/mmc/host/sdhci-pci-core.c
> index 34ea1acbb3cc..cba5bba994b8 100644
> --- a/drivers/mmc/host/sdhci-pci-core.c
> +++ b/drivers/mmc/host/sdhci-pci-core.c
> @@ -1955,6 +1955,7 @@ static const struct sdhci_ops sdhci_pci_ops = {
>  	.reset		= sdhci_reset,
>  	.set_uhs_signaling = sdhci_set_uhs_signaling,
>  	.hw_reset		= sdhci_pci_hw_reset,
> +	.uhs2_reset		= sdhci_uhs2_reset,

AFAICT this isn't needed

>  };
>  
>  /*****************************************************************************\
> diff --git a/drivers/mmc/host/sdhci-pci-gli.c b/drivers/mmc/host/sdhci-pci-gli.c
> index 4d509f656188..607cf69f45d0 100644
> --- a/drivers/mmc/host/sdhci-pci-gli.c
> +++ b/drivers/mmc/host/sdhci-pci-gli.c
> @@ -1097,6 +1097,7 @@ static const struct sdhci_ops sdhci_gl9755_ops = {
>  	.reset			= sdhci_reset,
>  	.set_uhs_signaling	= sdhci_set_uhs_signaling,
>  	.voltage_switch		= sdhci_gli_voltage_switch,
> +	.uhs2_reset		= sdhci_uhs2_reset,
>  };
>  
>  const struct sdhci_pci_fixes sdhci_gl9755 = {
> diff --git a/drivers/mmc/host/sdhci-uhs2.c b/drivers/mmc/host/sdhci-uhs2.c
> index 08905ed081fb..0e82f98d1967 100644
> --- a/drivers/mmc/host/sdhci-uhs2.c
> +++ b/drivers/mmc/host/sdhci-uhs2.c
> @@ -10,6 +10,7 @@
>   *  Author: AKASHI Takahiro <takahiro.akashi@linaro.org>
>   */
>  
> +#include <linux/delay.h>
>  #include <linux/module.h>
>  
>  #include "sdhci.h"
> @@ -49,6 +50,73 @@ void sdhci_uhs2_dump_regs(struct sdhci_host *host)
>  }
>  EXPORT_SYMBOL_GPL(sdhci_uhs2_dump_regs);
>  
> +/*****************************************************************************\
> + *                                                                           *
> + * Low level functions                                                       *
> + *                                                                           *
> +\*****************************************************************************/
> +
> +bool sdhci_uhs2_mode(struct sdhci_host *host)
> +{
> +	if ((host->mmc->caps2 & MMC_CAP2_SD_UHS2) &&
> +	    (IS_ENABLED(CONFIG_MMC_SDHCI_UHS2) &&
> +		(host->version >= SDHCI_SPEC_400) &&
> +		(host->mmc->flags & MMC_UHS2_SUPPORT)))
> +		return true;
> +	else
> +		return false;

For now, let's just make this:

	return host->mmc->flags & MMC_UHS2_SUPPORT;

> +}
> +
> +/**
> + * sdhci_uhs2_reset - invoke SW reset
> + * @host: SDHCI host
> + * @mask: Control mask
> + *
> + * Invoke SW reset, depending on a bit in @mask and wait for completion.
> + */
> +void sdhci_uhs2_reset(struct sdhci_host *host, u16 mask)
> +{
> +	unsigned long timeout;
> +	u32 val;
> +
> +	if (!(sdhci_uhs2_mode(host))) {

That isn't possible.

> +		/**
> +		 * u8  mask for legacy.
> +		 * u16 mask for uhs-2.
> +		 */
> +		u8 u8_mask;
> +
> +		u8_mask = (mask & 0xFF);
> +		sdhci_reset(host, u8_mask);

Probably should call host->ops->reset() but !sdhci_uhs2_mode(host)
isn't possible

> +
> +		return;
> +	}
> +
> +	sdhci_writew(host, mask, SDHCI_UHS2_SW_RESET);
> +
> +	if (mask & SDHCI_UHS2_SW_RESET_FULL) {
> +		host->clock = 0;
> +		/* Reset-all turns off SD Bus Power */
> +		if (host->quirks2 & SDHCI_QUIRK2_CARD_ON_NEEDS_BUS_ON)
> +			sdhci_runtime_pm_bus_off(host);

We don't know what other drivers will opt for UHS-II
support, but I doubt this quirk will be used, so  let's
not support SDHCI_QUIRK2_CARD_ON_NEEDS_BUS_ON for UHS-II

> +	}
> +
> +	/* Wait max 100 ms */
> +	timeout = 10000;

Isn't that 10ms

> +
> +	/* hw clears the bit when it's done */
> +	if (read_poll_timeout_atomic(sdhci_readw, val, !(val & mask), 10,
> +				     timeout, true, host, SDHCI_UHS2_SW_RESET)) {
> +		pr_err("%s: %s: Reset 0x%x never completed.\n",
> +					       __func__, mmc_hostname(host->mmc), (int)mask);
> +		pr_err("%s: clean reset bit\n",
> +					       mmc_hostname(host->mmc));
> +		sdhci_writeb(host, 0, SDHCI_UHS2_SW_RESET);
> +		return;
> +	}
> +}
> +EXPORT_SYMBOL_GPL(sdhci_uhs2_reset);
> +
>  /*****************************************************************************\
>   *                                                                           *
>   * Driver init/exit                                                          *
> diff --git a/drivers/mmc/host/sdhci-uhs2.h b/drivers/mmc/host/sdhci-uhs2.h
> index afdb05d6056b..31776dcca5cf 100644
> --- a/drivers/mmc/host/sdhci-uhs2.h
> +++ b/drivers/mmc/host/sdhci-uhs2.h
> @@ -11,6 +11,7 @@
>  #define __SDHCI_UHS2_H
>  
>  #include <linux/bits.h>
> +#include <linux/iopoll.h>

Not needed in header.  Can just be in .c

>  
>  /*
>   * UHS-II Controller registers
> @@ -210,5 +211,7 @@
>  struct sdhci_host;
>  
>  void sdhci_uhs2_dump_regs(struct sdhci_host *host);
> +bool sdhci_uhs2_mode(struct sdhci_host *host);
> +void sdhci_uhs2_reset(struct sdhci_host *host, u16 mask);
>  
>  #endif /* __SDHCI_UHS2_H */
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index 2cdd183c8ada..bd017c59a020 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -194,13 +194,14 @@ static void sdhci_runtime_pm_bus_on(struct sdhci_host *host)
>  	pm_runtime_get_noresume(mmc_dev(host->mmc));
>  }
>  
> -static void sdhci_runtime_pm_bus_off(struct sdhci_host *host)
> +void sdhci_runtime_pm_bus_off(struct sdhci_host *host)
>  {
>  	if (!host->bus_on)
>  		return;
>  	host->bus_on = false;
>  	pm_runtime_put_noidle(mmc_dev(host->mmc));
>  }
> +EXPORT_SYMBOL_GPL(sdhci_runtime_pm_bus_off);

Let's not support SDHCI_QUIRK2_CARD_ON_NEEDS_BUS_ON for UHS-II

>  
>  void sdhci_reset(struct sdhci_host *host, u8 mask)
>  {
> diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
> index bbed850241d4..28716105da61 100644
> --- a/drivers/mmc/host/sdhci.h
> +++ b/drivers/mmc/host/sdhci.h
> @@ -715,6 +715,19 @@ struct sdhci_ops {
>  					     u8 power_mode);
>  	unsigned int    (*get_ro)(struct sdhci_host *host);
>  	void		(*reset)(struct sdhci_host *host, u8 mask);
> +	/**
> +	 * The sdhci_uhs2_reset callback is to implement for reset
> +	 * @host: SDHCI host
> +	 * @mask: Control mask
> +	 *
> +	 * Invoke reset, depending on a bit in @mask and wait for completion.
> +	 * SD mode				UHS-II mode
> +	 * SDHCI_RESET_ALL		SDHCI_UHS2_SW_RESET_FULL
> +	 * SDHCI_RESET_CMD		SDHCI_RESET_CMD
> +	 * SDHCI_RESET_DATA		SDHCI_UHS2_SW_RESET_SD
> +	 *
> +	 **/
> +	void (*uhs2_reset)(struct sdhci_host *host, u16 mask);

This is only being called from sdhci_uhs2.c so let's just call it
directly for now, instead of using a callback.

>  	int	(*platform_execute_tuning)(struct sdhci_host *host, u32 opcode);
>  	void	(*set_uhs_signaling)(struct sdhci_host *host, unsigned int uhs);
>  	void	(*hw_reset)(struct sdhci_host *host);
> @@ -837,6 +850,7 @@ static inline void sdhci_read_caps(struct sdhci_host *host)
>  	__sdhci_read_caps(host, NULL, NULL, NULL);
>  }
>  
> +void sdhci_runtime_pm_bus_off(struct sdhci_host *host);

Let's not support SDHCI_QUIRK2_CARD_ON_NEEDS_BUS_ON for UHS-II

>  u16 sdhci_calc_clk(struct sdhci_host *host, unsigned int clock,
>  		   unsigned int *actual_clock);
>  void sdhci_set_clock(struct sdhci_host *host, unsigned int clock);

