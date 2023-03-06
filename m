Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA63E6ACF27
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 21:28:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230070AbjCFU2l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 15:28:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230064AbjCFU2f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 15:28:35 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB74038669;
        Mon,  6 Mar 2023 12:28:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678134510; x=1709670510;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=CA7BTCx5BD3LXUxERremA+1xEefI7Dn8mQX68Jkkois=;
  b=jh3WDihcvOgc43U67iGS6frgwBEx2YfS/4WWuabLIlkJWljprHh91IQx
   UgmulqVlbwekvPzWMVQqWob7+ubi/H0y107uxcXL4oTsC1NpxqFjhDVHd
   kaliLvd+U6jtkWuzU9w8l7JSc3nTsn0bhKRhEDlFTeWH9LoC2pMYXFhLW
   quPUkLA4uDIW3zIjKISj6BASe1lfnw3YNkUvVnehAqVJ+xsqkTv3RwlwT
   WSVmSkEz7AQbXTRCi1esZi/6adlRVg/EfLnsDg16k7EtXa1EHH1P/Y1fS
   qyMzBw5+SFXNetqh6DvSUzcXijq1B6QmipJ87BzgT64XQ1Iz1ykCtUAHx
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10641"; a="316066542"
X-IronPort-AV: E=Sophos;i="5.98,238,1673942400"; 
   d="scan'208";a="316066542"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2023 12:28:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10641"; a="850432582"
X-IronPort-AV: E=Sophos;i="5.98,238,1673942400"; 
   d="scan'208";a="850432582"
Received: from donaldjo-mobl.amr.corp.intel.com (HELO [10.212.158.155]) ([10.212.158.155])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2023 12:28:29 -0800
Message-ID: <29e8ec12-4d16-748c-569a-dba5073e4819@linux.intel.com>
Date:   Mon, 6 Mar 2023 12:28:29 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.4.2
Subject: Re: [PATCH v1 13/16] gpio: wcove: Utilize helpers from
 string_choices.h
Content-Language: en-US
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Schspa Shi <schspa@gmail.com>, Marc Zyngier <maz@kernel.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        patches@opensource.cirrus.com
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Doug Berger <opendmb@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Andy Shevchenko <andy@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Nandor Han <nandor.han@ge.com>,
        Semi Malinen <semi.malinen@ge.com>
References: <20230306195556.55475-1-andriy.shevchenko@linux.intel.com>
 <20230306195556.55475-14-andriy.shevchenko@linux.intel.com>
From:   Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20230306195556.55475-14-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 3/6/23 11:55 AM, Andy Shevchenko wrote:
> There are a few helpers available to convert a boolean variable
> to the dedicated string literals depending on the application.
> Use them in the driver.
> 
> While at, utilize specifier field for padding the strings where
> it's required.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Looks good to me.

Acked-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>

> ---
>  drivers/gpio/gpio-wcove.c | 15 ++++++++-------
>  1 file changed, 8 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/gpio/gpio-wcove.c b/drivers/gpio/gpio-wcove.c
> index c18b6b47384f..8d30fd04dede 100644
> --- a/drivers/gpio/gpio-wcove.c
> +++ b/drivers/gpio/gpio-wcove.c
> @@ -15,6 +15,7 @@
>  #include <linux/platform_device.h>
>  #include <linux/regmap.h>
>  #include <linux/seq_file.h>
> +#include <linux/string_choices.h>
>  
>  /*
>   * Whiskey Cove PMIC has 13 physical GPIO pins divided into 3 banks:
> @@ -391,14 +392,14 @@ static void wcove_gpio_dbg_show(struct seq_file *s, struct gpio_chip *chip)
>  			break;
>  		}
>  
> -		seq_printf(s, " gpio-%-2d %s %s %s %s ctlo=%2x,%s %s\n",
> -			   gpio, ctlo & CTLO_DIR_OUT ? "out" : "in ",
> -			   ctli & 0x1 ? "hi" : "lo",
> -			   ctli & CTLI_INTCNT_NE ? "fall" : "    ",
> -			   ctli & CTLI_INTCNT_PE ? "rise" : "    ",
> +		seq_printf(s, " gpio-%-2d %-3.3s %-2.2s %-4.4s %-4.4s ctlo=%2x,%-6.6s %s\n",
> +			   gpio, str_out_in(ctlo & CTLO_DIR_OUT),
> +			   str_hi_lo(ctli & BIT(0)),
> +			   ctli & CTLI_INTCNT_NE ? "fall" : "",
> +			   ctli & CTLI_INTCNT_PE ? "rise" : "",
>  			   ctlo,
> -			   irq_mask & mask ? "mask  " : "unmask",
> -			   irq_status & mask ? "pending" : "       ");
> +			   irq_mask & mask ? "mask" : "unmask",
> +			   irq_status & mask ? "pending" : "");
>  	}
>  }
>  

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
