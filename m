Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12A84615050
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 18:15:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230463AbiKARPG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 13:15:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229946AbiKAROZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 13:14:25 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 278BE5F58;
        Tue,  1 Nov 2022 10:14:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667322848; x=1698858848;
  h=message-id:date:mime-version:from:subject:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=XhFzZrI/fHUEnsZF8FOLeVipwFUNRO0s3JA4KitNpIA=;
  b=StLSSo1oH2ER9L/6oErusDfRea6uX/6Lsz08sd49l/M3QxM+33H5lJNN
   CJjZl8g2T1okDhVsptm7iqbtMQxsvGXH3GAtaLbYMgPOh4viz72MGaYmK
   hR+C5RRglAjkdZESVhhVIXeWja8kGTCx/vjt5Y0YHX2jyMUgGpg4UBc+h
   Pnx9Udvk9EF/dlN7OxdKGhfbcXeAA+Idz7Q+lliYw4ewlGi9s4+Cdrd0e
   CS0wxKICh7ZByGiCVe4dlQbLu1o6dYZZH/U2AvZrqoNHEATpAnkFZ1NYH
   25/x3zpUqXJ6sKUuxLPm9bEfl3NaFb/XNeInnSabGEdid+OcjjXB3Duhl
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10518"; a="309190348"
X-IronPort-AV: E=Sophos;i="5.95,231,1661842800"; 
   d="scan'208";a="309190348"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2022 10:14:07 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10518"; a="665220020"
X-IronPort-AV: E=Sophos;i="5.95,231,1661842800"; 
   d="scan'208";a="665220020"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.55.64])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2022 10:14:03 -0700
Message-ID: <f8b3feee-8372-a469-1853-45fb2738740d@intel.com>
Date:   Tue, 1 Nov 2022 19:14:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.4.1
From:   Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH V5 14/26] mmc: sdhci-uhs2: add set_timeout()
To:     Victor Shih <victorshihgli@gmail.com>, ulf.hansson@linaro.org
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        benchuanggli@gmail.com, HL.Liu@genesyslogic.com.tw,
        Greg.tu@genesyslogic.com.tw, takahiro.akashi@linaro.org,
        dlunev@chromium.org, Victor Shih <victor.shih@genesyslogic.com.tw>,
        Ben Chuang <ben.chuang@genesyslogic.com.tw>
References: <20221019110647.11076-1-victor.shih@genesyslogic.com.tw>
 <20221019110647.11076-15-victor.shih@genesyslogic.com.tw>
Content-Language: en-US
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20221019110647.11076-15-victor.shih@genesyslogic.com.tw>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/10/22 14:06, Victor Shih wrote:
> From: AKASHI Takahiro <takahiro.akashi@linaro.org>
> 
> This is a UHS-II version of sdhci's set_timeout() operation.
> 
> Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
> Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> ---
>  drivers/mmc/host/sdhci-uhs2.c | 85 +++++++++++++++++++++++++++++++++++
>  drivers/mmc/host/sdhci-uhs2.h |  1 +
>  2 files changed, 86 insertions(+)
> 
> diff --git a/drivers/mmc/host/sdhci-uhs2.c b/drivers/mmc/host/sdhci-uhs2.c
> index 4dc3e904d7d2..2b90e5308764 100644
> --- a/drivers/mmc/host/sdhci-uhs2.c
> +++ b/drivers/mmc/host/sdhci-uhs2.c
> @@ -196,6 +196,91 @@ void sdhci_uhs2_set_power(struct sdhci_host *host, unsigned char mode,
>  }
>  EXPORT_SYMBOL_GPL(sdhci_uhs2_set_power);
>  
> +static u8 sdhci_calc_timeout_uhs2(struct sdhci_host *host, u8 *cmd_res,
> +				  u8 *dead_lock)
> +{
> +	u8 count;
> +	unsigned int cmd_res_timeout, dead_lock_timeout, current_timeout;
> +
> +	/*
> +	 * If the host controller provides us with an incorrect timeout
> +	 * value, just skip the check and use 0xE.  The hardware may take
> +	 * longer to time out, but that's much better than having a too-short
> +	 * timeout value.
> +	 */
> +	if (host->quirks & SDHCI_QUIRK_BROKEN_TIMEOUT_VAL) {
> +		*cmd_res = 0xE;
> +		*dead_lock = 0xE;
> +		return 0xE;
> +	}

Let's skip quirks you don't need for now.

> +
> +	/* timeout in us */
> +	cmd_res_timeout = 5 * 1000;
> +	dead_lock_timeout = 1 * 1000 * 1000;
> +
> +	/*
> +	 * Figure out needed cycles.
> +	 * We do this in steps in order to fit inside a 32 bit int.
> +	 * The first step is the minimum timeout, which will have a
> +	 * minimum resolution of 6 bits:
> +	 * (1) 2^13*1000 > 2^22,
> +	 * (2) host->timeout_clk < 2^16
> +	 *     =>
> +	 *     (1) / (2) > 2^6
> +	 */
> +	count = 0;
> +	current_timeout = (1 << 13) * 1000 / host->timeout_clk;
> +	while (current_timeout < cmd_res_timeout) {
> +		count++;
> +		current_timeout <<= 1;
> +		if (count >= 0xF)
> +			break;
> +	}
> +
> +	if (count >= 0xF) {
> +		DBG("%s: Too large timeout 0x%x requested for CMD_RES!\n",
> +		    mmc_hostname(host->mmc), count);
> +		count = 0xE;
> +	}
> +	*cmd_res = count;
> +
> +	count = 0;
> +	current_timeout = (1 << 13) * 1000 / host->timeout_clk;
> +	while (current_timeout < dead_lock_timeout) {
> +		count++;
> +		current_timeout <<= 1;
> +		if (count >= 0xF)
> +			break;
> +	}
> +
> +	if (count >= 0xF) {
> +		DBG("%s: Too large timeout 0x%x requested for DEADLOCK!\n",
> +		    mmc_hostname(host->mmc), count);
> +		count = 0xE;
> +	}
> +	*dead_lock = count;
> +
> +	return count;
> +}
> +
> +static void __sdhci_uhs2_set_timeout(struct sdhci_host *host)
> +{
> +	u8 cmd_res, dead_lock;
> +
> +	sdhci_calc_timeout_uhs2(host, &cmd_res, &dead_lock);
> +	cmd_res |= dead_lock << SDHCI_UHS2_TIMER_CTRL_DEADLOCK_SHIFT;

GENMASK() and FIELD_PREP() please

> +	sdhci_writeb(host, cmd_res, SDHCI_UHS2_TIMER_CTRL);
> +}
> +
> +void sdhci_uhs2_set_timeout(struct sdhci_host *host, struct mmc_command *cmd)
> +{
> +	__sdhci_set_timeout(host, cmd);
> +
> +	if (host->mmc->flags & MMC_UHS2_SUPPORT)

	if (sdhci_uhs2_mode(host))

> +		__sdhci_uhs2_set_timeout(host);
> +}
> +EXPORT_SYMBOL_GPL(sdhci_uhs2_set_timeout);
> +
>  /*****************************************************************************\
>   *                                                                           *
>   * MMC callbacks                                                             *
> diff --git a/drivers/mmc/host/sdhci-uhs2.h b/drivers/mmc/host/sdhci-uhs2.h
> index 3179915f7f79..5ea235b14108 100644
> --- a/drivers/mmc/host/sdhci-uhs2.h
> +++ b/drivers/mmc/host/sdhci-uhs2.h
> @@ -215,5 +215,6 @@ bool sdhci_uhs2_mode(struct sdhci_host *host);
>  void sdhci_uhs2_reset(struct sdhci_host *host, u16 mask);
>  void sdhci_uhs2_set_power(struct sdhci_host *host, unsigned char mode,
>  			  unsigned short vdd);
> +void sdhci_uhs2_set_timeout(struct sdhci_host *host, struct mmc_command *cmd);
>  
>  #endif /* __SDHCI_UHS2_H */

