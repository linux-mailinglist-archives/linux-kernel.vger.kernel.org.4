Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 294FB5F3F33
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 11:09:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230463AbiJDJJV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 05:09:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229735AbiJDJJS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 05:09:18 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FFBA36873;
        Tue,  4 Oct 2022 02:09:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1664874557; x=1696410557;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=d0Q4O+kmvKaauRU9ZS3xkd85MWtpgvf4CT6+vWYRHb0=;
  b=UWvjRFjJWYZiDVV5Ch4LmHnb5ycRmOrX2V1hWgsW4ofljXeqDM6BK88p
   54XTyW+5v+uNDuXjunMBq+hddE95IGYfM6Zz/o87DwO0q67R5hfSsQWUQ
   4CKvgocbpUS1Iojn1GDeADKnN6PpvD2sKKx3Sh30EuMXVbDY24SPvKcaD
   hoB6b2KLlcDJPZ3dZn1xcdQWBVU7Q2mxLslybiMQ+THAdncwX8YHimKiS
   ogtyabzv0tfBoe838P+l7F0MFh9Lj0LmUp+h8JBSDiR42+Ic9H2CU0SE/
   x7CrroY57EusdkbSAPj769CIMTZEW5SjN+d4+xy6w8jUrQLCoNJVFXC4g
   w==;
X-IronPort-AV: E=Sophos;i="5.93,367,1654585200"; 
   d="scan'208";a="176912392"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 04 Oct 2022 02:09:16 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Tue, 4 Oct 2022 02:09:15 -0700
Received: from localhost (10.10.115.15) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server id 15.1.2507.12 via Frontend
 Transport; Tue, 4 Oct 2022 02:09:15 -0700
Date:   Tue, 4 Oct 2022 11:13:47 +0200
From:   Horatiu Vultur <horatiu.vultur@microchip.com>
To:     Yang Yingliang <yangyingliang@huawei.com>
CC:     <linux-gpio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linus.walleij@linaro.org>, <p.zabel@pengutronix.de>,
        <andy.shevchenko@gmail.com>
Subject: Re: [PATCH -next v3] pinctrl: ocelot: add missing
 destroy_workqueue() in error path in ocelot_pinctrl_probe()
Message-ID: <20221004091347.fotcdx75ut7zaly5@soft-dev3-1.localhost>
References: <20220925021258.1492905-1-yangyingliang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <20220925021258.1492905-1-yangyingliang@huawei.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The 09/25/2022 10:12, Yang Yingliang wrote:
> 
> Using devm_add_action_or_reset() to make workqueue device-managed, so it can be
> destroy whenever the driver is unbound.

Reviewed-by: Horatiu Vultur <horatiu.vultur@microchip.com>

> 
> Fixes: c297561bc98a ("pinctrl: ocelot: Fix interrupt controller")
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
> ---
> v3:
>   Using devm_add_action_or_reset().
> 
> v2:
>   move alloc_ordered_workqueue() after ocelot_pinctrl_register().
> ---
>  drivers/pinctrl/pinctrl-ocelot.c | 20 ++++++++++----------
>  1 file changed, 10 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/pinctrl/pinctrl-ocelot.c b/drivers/pinctrl/pinctrl-ocelot.c
> index 62ce3957abe4..266fbc957273 100644
> --- a/drivers/pinctrl/pinctrl-ocelot.c
> +++ b/drivers/pinctrl/pinctrl-ocelot.c
> @@ -2038,6 +2038,11 @@ static struct regmap *ocelot_pinctrl_create_pincfg(struct platform_device *pdev,
>         return devm_regmap_init_mmio(&pdev->dev, base, &regmap_config);
>  }
> 
> +static void ocelot_destroy_workqueue(void *data)
> +{
> +       destroy_workqueue(data);
> +}
> +
>  static int ocelot_pinctrl_probe(struct platform_device *pdev)
>  {
>         const struct ocelot_match_data *data;
> @@ -2069,6 +2074,11 @@ static int ocelot_pinctrl_probe(struct platform_device *pdev)
>         if (!info->wq)
>                 return -ENOMEM;
> 
> +       ret = devm_add_action_or_reset(dev, ocelot_destroy_workqueue,
> +                                      info->wq);
> +       if (ret)
> +               return ret;
> +
>         info->pincfg_data = &data->pincfg_data;
> 
>         reset = devm_reset_control_get_optional_shared(dev, "switch");
> @@ -2110,15 +2120,6 @@ static int ocelot_pinctrl_probe(struct platform_device *pdev)
>         return 0;
>  }
> 
> -static int ocelot_pinctrl_remove(struct platform_device *pdev)
> -{
> -       struct ocelot_pinctrl *info = platform_get_drvdata(pdev);
> -
> -       destroy_workqueue(info->wq);
> -
> -       return 0;
> -}
> -
>  static struct platform_driver ocelot_pinctrl_driver = {
>         .driver = {
>                 .name = "pinctrl-ocelot",
> @@ -2126,7 +2127,6 @@ static struct platform_driver ocelot_pinctrl_driver = {
>                 .suppress_bind_attrs = true,
>         },
>         .probe = ocelot_pinctrl_probe,
> -       .remove = ocelot_pinctrl_remove,
>  };
>  module_platform_driver(ocelot_pinctrl_driver);
> 
> --
> 2.25.1
> 

-- 
/Horatiu
