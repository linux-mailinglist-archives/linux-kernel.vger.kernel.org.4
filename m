Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5469C622B7C
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 13:24:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230074AbiKIMYU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 07:24:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230034AbiKIMYS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 07:24:18 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A21E8165B7;
        Wed,  9 Nov 2022 04:24:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 48279619B0;
        Wed,  9 Nov 2022 12:24:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2340C433C1;
        Wed,  9 Nov 2022 12:24:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667996656;
        bh=DI1kLMp44xPVivyHSAligYnyPf6dFzjoVZS6wmJz3vI=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=eHdjWLt/D/I6Taff/2jooQHAvslWkKHU6ukiP4v30Dpwr6niXIzlfm6J1oh4A0LOb
         FhricsW+pWU6T0vcC7kx7q2f/u5HMBWg4yQA5PjSqAcUQqtmnBJhASjFjua3PxFMUQ
         n9ErCO4lk0M4DX01a2T6bBoA0+hawX0p6WTLANsfH9F1b1aIG37cD1cMmHsozV6C4K
         e8lzz+JwXp/+tlKwGJ6dswbatIvBidiiU3Z5w4sspScq85QXxD9M8vssWok2yXNer0
         9Vtilwh7bu/DRujyg9IhhMgZhOFQsmP7xsJ1A1qQAdqY2QD3vPoS1U6p8lJUVL68ce
         WJ/51EHeqbmpQ==
Message-ID: <b2509306-7d41-ff78-90ec-0d34dec762e6@kernel.org>
Date:   Wed, 9 Nov 2022 14:24:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] memory: omap-gpmc: fix coverity issue "Control flow
 issues"
Content-Language: en-US
To:     "B. Niedermayr" <benedikt.niedermayr@siemens.com>,
        linux-next@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-hardening@vger.kernel.org, keescook@chromium.org,
        krzysztof.kozlowski@linaro.org, tony@atomide.com,
        gustavo@embeddedor.com
References: <20221109102454.174320-1-benedikt.niedermayr@siemens.com>
From:   Roger Quadros <rogerq@kernel.org>
In-Reply-To: <20221109102454.174320-1-benedikt.niedermayr@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 09/11/2022 12:24, B. Niedermayr wrote:
> From: Benedikt Niedermayr <benedikt.niedermayr@siemens.com>
> 
> Assign a big positive integer instead of an negative integer to an
> u32 variable. Also remove the check for ">= 0" which doesn't make sense
> for unsigned integers.
> 
> Reported-by: coverity-bot <keescook+coverity-bot@chromium.org>
> Addresses-Coverity-ID: 1527139 ("Control flow issues")
> Fixes: 89aed3cd5cb9 ("memory: omap-gpmc: wait pin additions")
> Signed-off-by: Benedikt Niedermayr <benedikt.niedermayr@siemens.com>

Reviewed-by: Roger Quadros <rogerq@kernel.org>

> ---
>  drivers/memory/omap-gpmc.c              | 2 +-
>  include/linux/platform_data/gpmc-omap.h | 4 ++--
>  2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/memory/omap-gpmc.c b/drivers/memory/omap-gpmc.c
> index e427572712e2..57d9f91fe89b 100644
> --- a/drivers/memory/omap-gpmc.c
> +++ b/drivers/memory/omap-gpmc.c
> @@ -1045,7 +1045,7 @@ EXPORT_SYMBOL(gpmc_cs_free);
>  
>  static bool gpmc_is_valid_waitpin(u32 waitpin)
>  {
> -	return waitpin >= 0 && waitpin < gpmc_nr_waitpins;
> +	return waitpin < gpmc_nr_waitpins;
>  }
>  
>  static int gpmc_alloc_waitpin(struct gpmc_device *gpmc,
> diff --git a/include/linux/platform_data/gpmc-omap.h b/include/linux/platform_data/gpmc-omap.h
> index 296b080c5c67..dcca6c5e23bb 100644
> --- a/include/linux/platform_data/gpmc-omap.h
> +++ b/include/linux/platform_data/gpmc-omap.h
> @@ -137,11 +137,11 @@ struct gpmc_device_timings {
>  #define GPMC_MUX_AD			2	/* Addr-Data multiplex */
>  
>  /* Wait pin polarity values */
> -#define GPMC_WAITPINPOLARITY_INVALID -1
> +#define GPMC_WAITPINPOLARITY_INVALID UINT_MAX
>  #define GPMC_WAITPINPOLARITY_ACTIVE_LOW 0
>  #define GPMC_WAITPINPOLARITY_ACTIVE_HIGH 1
>  
> -#define GPMC_WAITPIN_INVALID -1
> +#define GPMC_WAITPIN_INVALID UINT_MAX
>  
>  struct gpmc_settings {
>  	bool burst_wrap;	/* enables wrap bursting */

--
cheers,
-roger
