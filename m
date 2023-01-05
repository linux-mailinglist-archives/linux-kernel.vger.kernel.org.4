Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A5FB65F5A6
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 22:22:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235678AbjAEVWR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 16:22:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235751AbjAEVWK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 16:22:10 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 923F56319A;
        Thu,  5 Jan 2023 13:22:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672953729; x=1704489729;
  h=message-id:date:mime-version:from:subject:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=yMy1iqMTv3nnfF56KyQiFz7RFUrbN5NhKiRVliHdnAs=;
  b=CTiRkwp4WFfMjqex/W+Dz5DQ3hE9Te1j2sU9YZnAaYUc+cpGtp1Zi4u4
   ihHfh+rwwfvk4eruUSMfeol7efxRqyu6Bp33RHiMS48q/hanc4ubb042J
   CLQA2TeReX6R3eyFu208hJur+FlXDBcfLR3blPa5zmmWtUJgyuICdefXP
   IWMXHvUzBaGS9p3eVkc05sI6vQS3RRnFY3E50I4QOKndMIAJd1NGuBM/S
   TGYxLYKKz6UnAlL14N+wSjDhYQDfa4NE1Bx9ruvpqjXKKYebiy91hZ8q2
   CGAQFRCWo0RoFXN1/Qey5rvltuIOzw4FKdWdbPBzQf0bhOyRKHwrGPbhl
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10581"; a="302026842"
X-IronPort-AV: E=Sophos;i="5.96,303,1665471600"; 
   d="scan'208";a="302026842"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2023 13:22:09 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10581"; a="718969842"
X-IronPort-AV: E=Sophos;i="5.96,303,1665471600"; 
   d="scan'208";a="718969842"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.249.42.126])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2023 13:22:06 -0800
Message-ID: <1dc8942d-b7c7-144b-f5a1-a3f614f159ff@intel.com>
Date:   Thu, 5 Jan 2023 23:22:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.6.1
From:   Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH V6 01/24] mmc: core: Cleanup printing of speed mode at
 card insertion
To:     Victor Shih <victorshihgli@gmail.com>, ulf.hansson@linaro.org
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        benchuanggli@gmail.com, HL.Liu@genesyslogic.com.tw,
        Greg.tu@genesyslogic.com.tw, takahiro.akashi@linaro.org,
        dlunev@chromium.org, Victor Shih <victor.shih@genesyslogic.com.tw>
References: <20221213090047.3805-1-victor.shih@genesyslogic.com.tw>
 <20221213090047.3805-2-victor.shih@genesyslogic.com.tw>
Content-Language: en-US
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20221213090047.3805-2-victor.shih@genesyslogic.com.tw>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/12/22 11:00, Victor Shih wrote:
> The current print of the bus speed mode in mmc_add_card() has grown over
> the years and is now difficult to parse. Let's clean up the code and also
> take the opportunity to properly announce "DDR" for eMMCs as
> "high speed DDR", which is according to the eMMC spec.
> 
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> Signed-off-by: Victor Shih <victor.shih@genesyslogic.com.tw>
> ---
>  drivers/mmc/core/bus.c | 35 ++++++++++++++++++++---------------
>  1 file changed, 20 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/mmc/core/bus.c b/drivers/mmc/core/bus.c
> index 36679f4e9acc..bbbbdbca5366 100644
> --- a/drivers/mmc/core/bus.c
> +++ b/drivers/mmc/core/bus.c
> @@ -299,6 +299,7 @@ int mmc_add_card(struct mmc_card *card)
>  {
>  	int ret;
>  	const char *type;
> +	const char *speed_mode = "";
>  	const char *uhs_bus_speed_mode = "";
>  	static const char *const uhs_speeds[] = {
>  		[UHS_SDR12_BUS_SPEED] = "SDR12 ",
> @@ -337,25 +338,29 @@ int mmc_add_card(struct mmc_card *card)
>  		break;
>  	}
>  
> +	if (mmc_card_hs(card))
> +		speed_mode = "high speed ";
> +	else if (mmc_card_uhs(card))
> +		speed_mode = "ultra high speed ";
> +	else if	(mmc_card_ddr52(card))
> +		speed_mode = "high speed DDR ";
> +	else if (mmc_card_hs200(card))
> +		speed_mode = "HS200 ";
> +	else if (mmc_card_hs400es(card))
> +		speed_mode = "HS400 Enhanced strobe ";
> +	else if (mmc_card_hs400(card))
> +		speed_mode = "HS400 ";
> +
>  	if (mmc_card_uhs(card) &&
>  		(card->sd_bus_speed < ARRAY_SIZE(uhs_speeds)))
>  		uhs_bus_speed_mode = uhs_speeds[card->sd_bus_speed];
>  
> -	if (mmc_host_is_spi(card->host)) {
> -		pr_info("%s: new %s%s%s card on SPI\n",
> -			mmc_hostname(card->host),
> -			mmc_card_hs(card) ? "high speed " : "",
> -			mmc_card_ddr52(card) ? "DDR " : "",
> -			type);
> -	} else {
> -		pr_info("%s: new %s%s%s%s%s%s card at address %04x\n",
> -			mmc_hostname(card->host),
> -			mmc_card_uhs(card) ? "ultra high speed " :
> -			(mmc_card_hs(card) ? "high speed " : ""),
> -			mmc_card_hs400(card) ? "HS400 " :
> -			(mmc_card_hs200(card) ? "HS200 " : ""),
> -			mmc_card_hs400es(card) ? "Enhanced strobe " : "",
> -			mmc_card_ddr52(card) ? "DDR " : "",
> +	if (mmc_host_is_spi(card->host))
> +		pr_info("%s: new %s%s card on SPI\n",
> +			mmc_hostname(card->host), speed_mode, type);
> +	else {

This bracket wasn't in V5.  Brackets should be on both
branches of the if-clause or neither.

> +		pr_info("%s: new %s%s%s card at address %04x\n",
> +			mmc_hostname(card->host), speed_mode,
>  			uhs_bus_speed_mode, type, card->rca);
>  	}
>  

