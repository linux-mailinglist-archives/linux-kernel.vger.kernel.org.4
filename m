Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 975AE5BB28E
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 20:56:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230292AbiIPS4y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 14:56:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229930AbiIPS4w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 14:56:52 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E83289E6BF;
        Fri, 16 Sep 2022 11:56:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1663354611; x=1694890611;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=7Va/DYPNKbbJai+lRV3qrEI+vxwZRFIOBNvnM7bFZYU=;
  b=J9CJlgsHZz6F7fCoXDr0ZqlghNUkIjY9/dU9b+uULlBzW5qHUB2+kf9d
   ALzmslYtFaqky+3vaSO6ePz1FgzEfcflx1ma/63VMJN7O8I023hn98u1w
   WpRLNcxi6H3TToixbSOQUkpW+tMJlPgYNiIjeyZIy3evqIyZyIsWGG/DB
   kBkwaFUES8ml6l820W7xQdQ/udUoW0Tqy8BNokJfzRXNMDPBKcKNvbXW1
   Lwn7+jEsHemsyZQTDxqgS6ONgUHJPq6liTWaO/kaR7E0ngnD1vPu45NS8
   hk4v+/iLYqOBthyAGepzCa+QepiC3DrKQQaOZY45uh1FLluMeSBLWuFLC
   g==;
X-IronPort-AV: E=Sophos;i="5.93,321,1654585200"; 
   d="scan'208";a="177558779"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 16 Sep 2022 11:56:50 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Fri, 16 Sep 2022 11:56:50 -0700
Received: from localhost (10.10.115.15) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server id 15.1.2507.12 via Frontend
 Transport; Fri, 16 Sep 2022 11:56:50 -0700
Date:   Fri, 16 Sep 2022 21:01:14 +0200
From:   Horatiu Vultur <horatiu.vultur@microchip.com>
To:     Yang Yingliang <yangyingliang@huawei.com>
CC:     <linux-gpio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linus.walleij@linaro.org>, <p.zabel@pengutronix.de>
Subject: Re: [PATCH -next 1/2] pinctrl: ocelot: add missing
 destroy_workqueue() in error path in ocelot_pinctrl_probe()
Message-ID: <20220916190114.nnzc54nvv76jbd7k@soft-dev3-1.localhost>
References: <20220915151438.699763-1-yangyingliang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <20220915151438.699763-1-yangyingliang@huawei.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The 09/15/2022 23:14, Yang Yingliang wrote:

Hi Yang,

> 
> Add the missing destroy_workqueue() before return from ocelot_pinctrl_probe()
> in error path.
> 
> Fixes: c297561bc98a ("pinctrl: ocelot: Fix interrupt controller")
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
> ---
>  drivers/pinctrl/pinctrl-ocelot.c | 25 +++++++++++++++++--------
>  1 file changed, 17 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/pinctrl/pinctrl-ocelot.c b/drivers/pinctrl/pinctrl-ocelot.c
> index d9c0184c077f..83703a3d291c 100644
> --- a/drivers/pinctrl/pinctrl-ocelot.c
> +++ b/drivers/pinctrl/pinctrl-ocelot.c
> @@ -2072,15 +2072,19 @@ static int ocelot_pinctrl_probe(struct platform_device *pdev)
>         info->pincfg_data = &data->pincfg_data;
> 
>         reset = devm_reset_control_get_optional_shared(dev, "switch");
> -       if (IS_ERR(reset))
> -               return dev_err_probe(dev, PTR_ERR(reset),
> -                                    "Failed to get reset\n");
> +       if (IS_ERR(reset)) {
> +               ret = dev_err_probe(dev, PTR_ERR(reset),
> +                                   "Failed to get reset\n");
> +               goto err_out;
> +       }
>         reset_control_reset(reset);
> 
>         base = devm_ioremap_resource(dev,
>                         platform_get_resource(pdev, IORESOURCE_MEM, 0));
> -       if (IS_ERR(base))
> -               return PTR_ERR(base);
> +       if (IS_ERR(base)) {
> +               ret = PTR_ERR(base);
> +               goto err_out;
> +       }
> 
>         info->stride = 1 + (info->desc->npins - 1) / 32;
> 
> @@ -2089,7 +2093,8 @@ static int ocelot_pinctrl_probe(struct platform_device *pdev)
>         info->map = devm_regmap_init_mmio(dev, base, &regmap_config);
>         if (IS_ERR(info->map)) {
>                 dev_err(dev, "Failed to create regmap\n");
> -               return PTR_ERR(info->map);
> +               ret = PTR_ERR(info->map);
> +               goto err_out;
>         }
>         dev_set_drvdata(dev, info);
>         info->dev = dev;
> @@ -2105,15 +2110,19 @@ static int ocelot_pinctrl_probe(struct platform_device *pdev)
> 
>         ret = ocelot_pinctrl_register(pdev, info);
>         if (ret)
> -               return ret;
> +               goto err_out;

Wouldn't be better actually to add the allocation of the workqueue here?
In this way, you will not need all the previous changes.

> 
>         ret = ocelot_gpiochip_register(pdev, info);
>         if (ret)
> -               return ret;
> +               goto err_out;
> 
>         dev_info(dev, "driver registered\n");
> 
>         return 0;
> +
> +err_out:
> +       destroy_workqueue(info->wq);
> +       return ret;
>  }
> 
>  static int ocelot_pinctrl_remove(struct platform_device *pdev)
> --
> 2.25.1
> 

-- 
/Horatiu
