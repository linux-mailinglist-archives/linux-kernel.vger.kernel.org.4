Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C5505F9BA1
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 11:09:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231609AbiJJJJD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 05:09:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231469AbiJJJJA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 05:09:00 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8553D46616;
        Mon, 10 Oct 2022 02:08:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1665392939; x=1696928939;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=KiaXUf4gF15Ux8A6qcf1bYa4KmiVRrNsO45czAps/+g=;
  b=hJqj5hp+12U97GXG1TVowCIn5JV0BWe/Ov65beFLxMbctFD/qb/dEsV7
   Oz2gZJ80iZNGO0iWIIIvS1kWWv6AfwL+mKrexyg072Oqd6cOGxTTxDjgV
   HwEGvazx+g/3UretsE+h1IZwE77NNDyuQSHngkdfkgIjaMoR6UCgpKoAC
   SLlwjNr0TK+QYWtK66iQ2zbfwkSkk56z1rQ+iU+5rNosq2HyMvB5EZZy9
   JJ3daSChyscIcoZSI6aMa0FJdOf7mBVzg+arBiN5fG/JodwRwQGs5TbcK
   UgUfbpg0jPDHc/yn69qMOppfmsLstWku/SL8nOdcEX6kjfHHKRxOQkqQo
   Q==;
X-IronPort-AV: E=Sophos;i="5.95,173,1661842800"; 
   d="scan'208";a="194657043"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 10 Oct 2022 02:08:58 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Mon, 10 Oct 2022 02:08:41 -0700
Received: from [10.12.72.60] (10.10.115.15) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server id 15.1.2507.12 via Frontend
 Transport; Mon, 10 Oct 2022 02:08:40 -0700
Message-ID: <11901f5c-a1c8-1470-8bf5-82f73c1ace01@microchip.com>
Date:   Mon, 10 Oct 2022 11:08:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 2/2] pinctrl: at91-pio4: Add persist state case in config
Content-Language: en-US
To:     <Ryan.Wanner@microchip.com>, <ludovic.desroches@microchip.com>,
        <linus.walleij@linaro.org>, <alexandre.belloni@bootlin.com>,
        <claudiu.beznea@microchip.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-gpio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20221007151647.98222-1-Ryan.Wanner@microchip.com>
 <20221007151647.98222-3-Ryan.Wanner@microchip.com>
From:   Nicolas Ferre <nicolas.ferre@microchip.com>
Organization: microchip
In-Reply-To: <20221007151647.98222-3-Ryan.Wanner@microchip.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/10/2022 at 17:16, Ryan.Wanner@microchip.com wrote:
> From: Ryan Wanner <Ryan.Wanner@microchip.com>
> 
> Adding persist state case to atmel_conf_pin_config_group_set() function.
> After adding configuration support for userspace gpiod api, there was an
> extra flag PIN_CONFIG_PERSIST_STATE that was not passed in before.
> 
> Based on other drivers like TI drivers, added a switch case and return
> ENOTSUPP in that case.
> 
> Signed-off-by: Ryan Wanner <Ryan.Wanner@microchip.com>

Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>

Thanks, best regards,
   Nicolas

> ---
>   drivers/pinctrl/pinctrl-at91-pio4.c | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/pinctrl/pinctrl-at91-pio4.c b/drivers/pinctrl/pinctrl-at91-pio4.c
> index 13b77f1eb6e2..40f1b9397767 100644
> --- a/drivers/pinctrl/pinctrl-at91-pio4.c
> +++ b/drivers/pinctrl/pinctrl-at91-pio4.c
> @@ -780,6 +780,8 @@ static int atmel_conf_pin_config_group_get(struct pinctrl_dev *pctldev,
>   			return -EINVAL;
>   		arg = (res & ATMEL_PIO_DRVSTR_MASK) >> ATMEL_PIO_DRVSTR_OFFSET;
>   		break;
> +	case PIN_CONFIG_PERSIST_STATE:
> +		return -ENOTSUPP;
>   	default:
>   		return -ENOTSUPP;
>   	}
> @@ -888,6 +890,8 @@ static int atmel_conf_pin_config_group_set(struct pinctrl_dev *pctldev,
>   				dev_warn(pctldev->dev, "drive strength not updated (incorrect value)\n");
>   			}
>   			break;
> +		case PIN_CONFIG_PERSIST_STATE:
> +			return -ENOTSUPP;
>   		default:
>   			dev_warn(pctldev->dev,
>   				 "unsupported configuration parameter: %u\n",


-- 
Nicolas Ferre
