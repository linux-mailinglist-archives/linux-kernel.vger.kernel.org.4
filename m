Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 843046A7A31
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 04:52:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229760AbjCBDwo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 22:52:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjCBDwm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 22:52:42 -0500
X-Greylist: delayed 868 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 01 Mar 2023 19:52:41 PST
Received: from mail-m11874.qiye.163.com (mail-m11874.qiye.163.com [115.236.118.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BF5532532;
        Wed,  1 Mar 2023 19:52:41 -0800 (PST)
Received: from [172.16.12.93] (unknown [58.22.7.114])
        by mail-m11874.qiye.163.com (Hmail) with ESMTPA id 946593C0196;
        Thu,  2 Mar 2023 11:29:45 +0800 (CST)
Message-ID: <b86a53d7-778e-5ec7-cc5b-8e741af10986@rock-chips.com>
Date:   Thu, 2 Mar 2023 11:29:45 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v2 3/8] gpio: gpio-rockchip: parse gpio-ranges for bank id
Content-Language: en-US
To:     Johan Jonker <jbx6244@gmail.com>, linus.walleij@linaro.org,
        brgl@bgdev.pl
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        heiko@sntech.de, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        sjg@chromium.org, philipp.tomsich@vrull.eu, john@metanate.com,
        quentin.schulz@theobroma-systems.com
References: <03627216-54b5-5d9b-f91d-adcd637819e3@gmail.com>
 <890be9a0-8e82-a8f4-bc15-d5d1597343c2@gmail.com>
From:   Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <890be9a0-8e82-a8f4-bc15-d5d1597343c2@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
        tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQ0JDTlYfTktCTExMSR1PHktVEwETFh
        oSFyQUDg9ZV1kYEgtZQVlOQ1VJSVVMVUpKT1lXWRYaDxIVHRRZQVlPS0hVSkpLT0tDVUpLS1VLWQ
        Y+
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6MTo6ASo*Aj0QPkIoOQ0SLjAW
        FglPC1ZVSlVKTUxMTElMTENNTk9DVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
        EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFIQkhONwY+
X-HM-Tid: 0a86a05e64182eb0kusn946593c0196
X-HM-MType: 1
X-Spam-Status: No, score=-0.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Johan,

On 2023/1/21 19:08, Johan Jonker wrote:
> Parse the gpio-ranges property in Rockchip gpio nodes to be
> independent from aliases and probe order for our bank id.
>
> Signed-off-by: Johan Jonker <jbx6244@gmail.com>

Looks good to me.

Reviewed-by: Kever Yang <kever.yang@rock-chips.com>


Thanks,
- Kever
> ---
>   drivers/gpio/gpio-rockchip.c | 24 ++++++++++++++++++------
>   1 file changed, 18 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/gpio/gpio-rockchip.c b/drivers/gpio/gpio-rockchip.c
> index e5de15a2a..df74b71aa 100644
> --- a/drivers/gpio/gpio-rockchip.c
> +++ b/drivers/gpio/gpio-rockchip.c
> @@ -702,24 +702,36 @@ static int rockchip_gpio_probe(struct platform_device *pdev)
>   {
>   	struct device *dev = &pdev->dev;
>   	struct device_node *np = dev->of_node;
> -	struct device_node *pctlnp = of_get_parent(np);
> +	struct device_node *pctlnp;
>   	struct pinctrl_dev *pctldev = NULL;
>   	struct rockchip_pin_bank *bank = NULL;
>   	struct rockchip_pin_deferred *cfg;
> +	struct of_phandle_args args;
>   	static int gpio;
>   	int id, ret;
>
> -	if (!np || !pctlnp)
> +	if (!np)
> +		return -ENODEV;
> +
> +	ret = of_parse_phandle_with_fixed_args(np, "gpio-ranges", 3, 0, &args);
> +	if (ret == 0) {
> +		pctlnp = args.np;
> +		id = args.args[1] / 32;
> +	} else {
> +		pctlnp = of_get_parent(np);
> +		id = of_alias_get_id(np, "gpio");
> +		if (id < 0)
> +			id = gpio++;
> +	}
> +
> +	if (!pctlnp)
>   		return -ENODEV;
>
>   	pctldev = of_pinctrl_get(pctlnp);
> +	of_node_put(pctlnp);
>   	if (!pctldev)
>   		return -EPROBE_DEFER;
>
> -	id = of_alias_get_id(np, "gpio");
> -	if (id < 0)
> -		id = gpio++;
> -
>   	bank = rockchip_gpio_find_bank(pctldev, id);
>   	if (!bank)
>   		return -EINVAL;
> --
> 2.20.1
>
>
> _______________________________________________
> Linux-rockchip mailing list
> Linux-rockchip@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-rockchip
