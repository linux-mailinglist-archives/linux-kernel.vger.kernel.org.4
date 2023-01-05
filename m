Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E20BC65F5B7
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 22:26:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235789AbjAEV0b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 16:26:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235756AbjAEV03 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 16:26:29 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 808F5631AD;
        Thu,  5 Jan 2023 13:26:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672953988; x=1704489988;
  h=message-id:date:mime-version:from:subject:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=OLDSHk6S591UWnRI9iI9am/z56fyHwzCKS1qiG1hkYI=;
  b=D9osJkzHAys/pNjQY21EWff9ZZ2F9aSJtUa1XCOh80pV+/mnKfEM2ZNB
   T82gmwSQ9dk2jVydSWtdUO4oQZtukPcoR8g0E8/sC6J3yW3xgzmSl8pEw
   cN/bWV1KUXuL9pRz7ONYXhSaFRd/mxzZuCBaBu00YNEX68LCQ0BO//P+p
   P7ltuwf+rpf0Vu3/8EG/13bsClbCv8wApym2J8Y3vEgI4IOx5LxE+bHVx
   Hx+r27/Y5naZcSDSYoVxTzTm2XghSWYPYiBjNdmI0wMEuyJx4C/elgDPI
   VqLJ9/2nOwUP7pfOYKP21SZxM2IF3KAonIBn24vMePaFapFWZh7hiojXY
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10581"; a="320034877"
X-IronPort-AV: E=Sophos;i="5.96,303,1665471600"; 
   d="scan'208";a="320034877"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2023 13:26:28 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10581"; a="657673236"
X-IronPort-AV: E=Sophos;i="5.96,303,1665471600"; 
   d="scan'208";a="657673236"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.249.42.126])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2023 13:26:25 -0800
Message-ID: <b1aa86ba-7a4e-21cc-b22b-b2f8d8b4bdcb@intel.com>
Date:   Thu, 5 Jan 2023 23:26:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.6.1
From:   Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH V6 06/24] mmc: core: Support UHS-II card control and
 access
To:     Victor Shih <victorshihgli@gmail.com>, ulf.hansson@linaro.org
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        benchuanggli@gmail.com, HL.Liu@genesyslogic.com.tw,
        Greg.tu@genesyslogic.com.tw, takahiro.akashi@linaro.org,
        dlunev@chromium.org, Victor Shih <victor.shih@genesyslogic.com.tw>,
        Jason Lai <jason.lai@genesyslogic.com.tw>
References: <20221213090047.3805-1-victor.shih@genesyslogic.com.tw>
 <20221213090047.3805-7-victor.shih@genesyslogic.com.tw>
Content-Language: en-US
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20221213090047.3805-7-victor.shih@genesyslogic.com.tw>
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
> Embed UHS-II access/control functionality into the MMC request
> processing flow.
> 
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> Signed-off-by: Jason Lai <jason.lai@genesyslogic.com.tw>
> Signed-off-by: Victor Shih <victor.shih@genesyslogic.com.tw>
> ---
>  drivers/mmc/core/block.c   |    6 +-
>  drivers/mmc/core/core.c    |   20 +
>  drivers/mmc/core/mmc_ops.c |   25 +-
>  drivers/mmc/core/mmc_ops.h |    1 +
>  drivers/mmc/core/sd.c      |   11 +-
>  drivers/mmc/core/sd.h      |    3 +
>  drivers/mmc/core/sd_ops.c  |   13 +
>  drivers/mmc/core/sd_ops.h  |    3 +
>  drivers/mmc/core/sd_uhs2.c | 1171 +++++++++++++++++++++++++++++++++++-
>  9 files changed, 1206 insertions(+), 47 deletions(-)
> 

<SNIP>

> diff --git a/drivers/mmc/core/sd_uhs2.c b/drivers/mmc/core/sd_uhs2.c
> index 800957f74632..a79eb08ec540 100644
> --- a/drivers/mmc/core/sd_uhs2.c
> +++ b/drivers/mmc/core/sd_uhs2.c

<SNIP>

> +/*
> + * Mask off any voltages we don't support and select
> + * the lowest voltage
> + */
> +u32 sd_uhs2_select_voltage(struct mmc_host *host, u32 ocr)
> +{
> +	int bit;
> +	int err;
> +
> +	/*
> +	 * Sanity check the voltages that the card claims to
> +	 * support.
> +	 */
> +	if (ocr & 0x7F) {
> +		dev_warn(mmc_dev(host), "card claims to support voltages below defined range\n");
> +		ocr &= ~0x7F;
> +	}
> +
> +	ocr &= host->ocr_avail;
> +	if (!ocr) {
> +		dev_warn(mmc_dev(host), "no support for card's volts\n");
> +		return 0;
> +	}
> +
> +	if (host->caps2 & MMC_CAP2_FULL_PWR_CYCLE) {
> +		bit = ffs(ocr) - 1;
> +		ocr &= 3 << bit;
> +		/* Power cycle */
> +		err = sd_uhs2_power_off(host);
> +		if (err)
> +			return 0;
> +		err = sd_uhs2_reinit(host);

This looks circular:

sd_uhs2_select_voltage
-> sd_uhs2_reinit
   -> sd_uhs2_init_card
      -> sd_uhs2_legacy_init
         -> sd_uhs2_select_voltage

> +		if (err)
> +			return 0;
> +	} else {
> +		bit = fls(ocr) - 1;
> +		ocr &= 3 << bit;
> +		if (bit != host->ios.vdd)
> +			dev_warn(mmc_dev(host), "exceeding card's volts\n");
> +	}
> +
> +	return ocr;
> +}
> +

<SNIP>

