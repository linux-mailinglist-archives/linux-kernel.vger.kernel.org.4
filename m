Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D062713A46
	for <lists+linux-kernel@lfdr.de>; Sun, 28 May 2023 17:02:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229561AbjE1PCi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 May 2023 11:02:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjE1PCe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 May 2023 11:02:34 -0400
Received: from fgw23-7.mail.saunalahti.fi (fgw23-7.mail.saunalahti.fi [62.142.5.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9324FB2
        for <linux-kernel@vger.kernel.org>; Sun, 28 May 2023 08:02:29 -0700 (PDT)
Received: from localhost (88-113-26-95.elisa-laajakaista.fi [88.113.26.95])
        by fgw23.mail.saunalahti.fi (Halon) with ESMTP
        id a4b9b0ec-fd68-11ed-b972-005056bdfda7;
        Sun, 28 May 2023 18:02:20 +0300 (EEST)
From:   andy.shevchenko@gmail.com
Date:   Sun, 28 May 2023 18:02:19 +0300
To:     Wells Lu <wellslutw@gmail.com>
Cc:     linus.walleij@linaro.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, wells.lu@sunplus.com
Subject: Re: [PATCH v2] pinctrl:sunplus: Add check for kmalloc
Message-ID: <ZHNs-5zTZyzVt0b8@surfacebook>
References: <1685277277-12209-1-git-send-email-wellslutw@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1685277277-12209-1-git-send-email-wellslutw@gmail.com>
X-Spam-Status: No, score=0.7 required=5.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
        FORGED_GMAIL_RCVD,FREEMAIL_FROM,NML_ADSP_CUSTOM_MED,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sun, May 28, 2023 at 08:34:37PM +0800, Wells Lu kirjoitti:
> Fix Smatch static checker warning:
> potential null dereference 'configs'. (kmalloc returns null)

> Changes in v2:
> 1. Add free allocated memory before returned -ENOMEM.
> 2. Add call of_node_put() before returned -ENOMEM.

The placeholder for this is after the cutter '---' line.
I think it may be fixed during application by Linus W.

Otherwise LGTM,
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> Fixes: aa74c44be19c ("pinctrl: Add driver for Sunplus SP7021")
> Signed-off-by: Wells Lu <wellslutw@gmail.com>
> ---
>  drivers/pinctrl/sunplus/sppctl.c | 24 ++++++++++++++++++------
>  1 file changed, 18 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/pinctrl/sunplus/sppctl.c b/drivers/pinctrl/sunplus/sppctl.c
> index 6bbbab3..e91ce5b 100644
> --- a/drivers/pinctrl/sunplus/sppctl.c
> +++ b/drivers/pinctrl/sunplus/sppctl.c
> @@ -834,11 +834,6 @@ static int sppctl_dt_node_to_map(struct pinctrl_dev *pctldev, struct device_node
>  	int i, size = 0;
>  
>  	list = of_get_property(np_config, "sunplus,pins", &size);
> -
> -	if (nmG <= 0)
> -		nmG = 0;
> -
> -	parent = of_get_parent(np_config);
>  	*num_maps = size / sizeof(*list);
>  
>  	/*
> @@ -866,10 +861,14 @@ static int sppctl_dt_node_to_map(struct pinctrl_dev *pctldev, struct device_node
>  		}
>  	}
>  
> +	if (nmG <= 0)
> +		nmG = 0;
> +
>  	*map = kcalloc(*num_maps + nmG, sizeof(**map), GFP_KERNEL);
> -	if (*map == NULL)
> +	if (!(*map))
>  		return -ENOMEM;
>  
> +	parent = of_get_parent(np_config);
>  	for (i = 0; i < (*num_maps); i++) {
>  		dt_pin = be32_to_cpu(list[i]);
>  		pin_num = FIELD_GET(GENMASK(31, 24), dt_pin);
> @@ -883,6 +882,8 @@ static int sppctl_dt_node_to_map(struct pinctrl_dev *pctldev, struct device_node
>  			(*map)[i].data.configs.num_configs = 1;
>  			(*map)[i].data.configs.group_or_pin = pin_get_name(pctldev, pin_num);
>  			configs = kmalloc(sizeof(*configs), GFP_KERNEL);
> +			if (!configs)
> +				goto sppctl_map_err;
>  			*configs = FIELD_GET(GENMASK(7, 0), dt_pin);
>  			(*map)[i].data.configs.configs = configs;
>  
> @@ -896,6 +897,8 @@ static int sppctl_dt_node_to_map(struct pinctrl_dev *pctldev, struct device_node
>  			(*map)[i].data.configs.num_configs = 1;
>  			(*map)[i].data.configs.group_or_pin = pin_get_name(pctldev, pin_num);
>  			configs = kmalloc(sizeof(*configs), GFP_KERNEL);
> +			if (!configs)
> +				goto sppctl_map_err;
>  			*configs = SPPCTL_IOP_CONFIGS;
>  			(*map)[i].data.configs.configs = configs;
>  
> @@ -965,6 +968,15 @@ static int sppctl_dt_node_to_map(struct pinctrl_dev *pctldev, struct device_node
>  	of_node_put(parent);
>  	dev_dbg(pctldev->dev, "%d pins mapped\n", *num_maps);
>  	return 0;
> +
> +sppctl_map_err:
> +	for (i = 0; i < (*num_maps); i++)
> +		if (((*map)[i].type == PIN_MAP_TYPE_CONFIGS_PIN) &&
> +		    (*map)[i].data.configs.configs)
> +			kfree((*map)[i].data.configs.configs);
> +	kfree(*map);
> +	of_node_put(parent);
> +	return -ENOMEM;
>  }
>  
>  static const struct pinctrl_ops sppctl_pctl_ops = {
> -- 
> 2.7.4
> 

-- 
With Best Regards,
Andy Shevchenko


