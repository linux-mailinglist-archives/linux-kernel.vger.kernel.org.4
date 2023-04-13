Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E6FF6E1232
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 18:24:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230046AbjDMQY5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 12:24:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230247AbjDMQYt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 12:24:49 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E29A8A5F;
        Thu, 13 Apr 2023 09:24:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1681403081; x=1712939081;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=jVY1i24b8wmguS7lTARjG/b+rm7QVdbGV2S7Z0o8Omg=;
  b=Mqa/MR5Sr4sTzBbKNgD8PeqQtrrkWJwPLD2EINC0h1IgNp9xJk4Ezmka
   b7ERUy09i/iw1gewZoKg8OVbkXgv3ZLSa+D3C4VJ5e78sZkN25TB1xIYS
   7y6fv4a/j1D4tFyvUI7KLfdBmnDHFcK/XFYtpKnRmEw+l254DgvO25Ku1
   4oURpaNeshS/6y8mBSueDhk465Lui0kabhgHSlc0OcpQL05CY/Reoi+xe
   WuZQ/yeL/qXwv+Qk44+0XobLqMZQKRm7stjJsha0EE291Zhx/EpB5IchO
   2z1RdrfaXDa96q8Q18u1a1Jr0bsqhhlIWItEk1uMGbWpLkepIOsDwBJLi
   w==;
X-IronPort-AV: E=Sophos;i="5.99,194,1677567600"; 
   d="scan'208";a="208983650"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 13 Apr 2023 09:24:40 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 13 Apr 2023 09:24:40 -0700
Received: from [10.12.72.144] (10.10.115.15) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server id 15.1.2507.21 via Frontend
 Transport; Thu, 13 Apr 2023 09:24:38 -0700
Message-ID: <9338a2c2-fda5-d1d6-e4ad-c37de6bb5636@microchip.com>
Date:   Thu, 13 Apr 2023 18:24:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [linux][PATCH] pinctrl: at91-pio4: Add push-pull drive
 configuration
Content-Language: en-US
To:     <Ryan.Wanner@microchip.com>, <ludovic.desroches@microchip.com>,
        <linus.walleij@linaro.org>, <alexandre.belloni@bootlin.com>,
        <claudiu.beznea@microchip.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-gpio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20230412175146.886684-1-Ryan.Wanner@microchip.com>
From:   Nicolas Ferre <nicolas.ferre@microchip.com>
Organization: microchip
In-Reply-To: <20230412175146.886684-1-Ryan.Wanner@microchip.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/04/2023 at 19:51, Ryan.Wanner@microchip.com wrote:
> From: Ryan Wanner <Ryan.Wanner@microchip.com>
> 
> The PIO4 does support push-pull configuration as this is the default
> state of the open-drain register. Adapt the driver for this.
> 
> Signed-off-by: Ryan Wanner <Ryan.Wanner@microchip.com>
> ---
> This patch also fixes the warning of unsupported
> configuration param 8.
> 
> This was tested on both sama5d2-som1-ek and sama7g5ek. I used dbg_show
> fucntion to test if the configuration was correct when adding
> drive-open-drain or drive-push-pull to the dts file.
> 
>   drivers/pinctrl/pinctrl-at91-pio4.c | 17 ++++++++++++-----
>   1 file changed, 12 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/pinctrl/pinctrl-at91-pio4.c b/drivers/pinctrl/pinctrl-at91-pio4.c
> index a30c6f7c9016..9a0cddfeaf92 100644
> --- a/drivers/pinctrl/pinctrl-at91-pio4.c
> +++ b/drivers/pinctrl/pinctrl-at91-pio4.c
> @@ -776,6 +776,11 @@ static int atmel_conf_pin_config_group_get(struct pinctrl_dev *pctldev,
>   			return -EINVAL;
>   		arg = 1;
>   		break;
> +	case PIN_CONFIG_DRIVE_PUSH_PULL:
> +		if ((res & ATMEL_PIO_OPD_MASK))
> +			return -EINVAL;
> +		arg = 1;
> +		break;
>   	case PIN_CONFIG_INPUT_SCHMITT_ENABLE:
>   		if (!(res & ATMEL_PIO_SCHMITT_MASK))
>   			return -EINVAL;
> @@ -839,10 +844,10 @@ static int atmel_conf_pin_config_group_set(struct pinctrl_dev *pctldev,
>   			conf &= (~ATMEL_PIO_PUEN_MASK);
>   			break;
>   		case PIN_CONFIG_DRIVE_OPEN_DRAIN:
> -			if (arg == 0)
> -				conf &= (~ATMEL_PIO_OPD_MASK);
> -			else
> -				conf |= ATMEL_PIO_OPD_MASK;
> +			conf |= ATMEL_PIO_OPD_MASK;
> +			break;

This chunk seems to change the behavior of the driver in case of 
OPEN_DRAIN by ignoring the "arg" encoded parameter.

It seems that arg was used equal to 0 at least here:
https://elixir.bootlin.com/linux/latest/source/drivers/gpio/gpiolib.c#L2504

(we talked about this internally, but I didn't see it this way: sorry Ryan)

Now we set the OPD bit unconditionally, which seems the proper way, but 
it changes things: I would advice to separate this change into another 
patch.

I'm very surprised we didn't see this "bug" earlier because it seems to 
be present since the creation of the file.

The rest of the addition looks good to me.

> +		case PIN_CONFIG_DRIVE_PUSH_PULL:
> +			conf &= (~ATMEL_PIO_OPD_MASK);
>   			break;
>   		case PIN_CONFIG_INPUT_SCHMITT_ENABLE:
>   			if (arg == 0)
> @@ -937,8 +942,10 @@ static void atmel_conf_pin_config_dbg_show(struct pinctrl_dev *pctldev,
>   		seq_printf(s, "%s ", "pull-down");
>   	if (conf & ATMEL_PIO_IFEN_MASK)
>   		seq_printf(s, "%s ", "debounce");
> -	if (conf & ATMEL_PIO_OPD_MASK)
> +	if ((conf & ATMEL_PIO_OPD_MASK) > 0)

The 2 lines are equivalent, keep the former one.

>   		seq_printf(s, "%s ", "open-drain");
> +	if ((conf & ATMEL_PIO_OPD_MASK) == 0)

here, simply a "else" does the trick

> +		seq_printf(s, "%s ", "push-pull");
>   	if (conf & ATMEL_PIO_SCHMITT_MASK)
>   		seq_printf(s, "%s ", "schmitt");
>   	if (atmel_pioctrl->slew_rate_support && (conf & ATMEL_PIO_SR_MASK))

Thanks, best regards,
   Nicolas

-- 
Nicolas Ferre

