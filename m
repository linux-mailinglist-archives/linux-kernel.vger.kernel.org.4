Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB2AA5EDFEB
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 17:15:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234313AbiI1PPi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 11:15:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232294AbiI1PPf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 11:15:35 -0400
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id BD8CF3F1D5
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 08:15:32 -0700 (PDT)
Received: (qmail 489543 invoked by uid 1000); 28 Sep 2022 11:15:31 -0400
Date:   Wed, 28 Sep 2022 11:15:31 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] usb: host: ehci-exynos: switch to using gpiod API
Message-ID: <YzRlE3u7cIBL8Y1k@rowland.harvard.edu>
References: <20220927220504.3744878-1-dmitry.torokhov@gmail.com>
 <20220927220504.3744878-2-dmitry.torokhov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220927220504.3744878-2-dmitry.torokhov@gmail.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 27, 2022 at 03:05:04PM -0700, Dmitry Torokhov wrote:
> This patch switches the driver from using legacy gpio API to the newer
> gpiod API.
> 
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> ---

Acked-by: Alan Stern <stern@rowland.harvard.edu>

>  drivers/usb/host/ehci-exynos.c | 17 +++++------------
>  1 file changed, 5 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/usb/host/ehci-exynos.c b/drivers/usb/host/ehci-exynos.c
> index c8e152c2e0ce..a333231616f4 100644
> --- a/drivers/usb/host/ehci-exynos.c
> +++ b/drivers/usb/host/ehci-exynos.c
> @@ -13,7 +13,7 @@
>  #include <linux/kernel.h>
>  #include <linux/module.h>
>  #include <linux/of.h>
> -#include <linux/of_gpio.h>
> +#include <linux/gpio/consumer.h>
>  #include <linux/phy/phy.h>
>  #include <linux/platform_device.h>
>  #include <linux/usb.h>
> @@ -131,20 +131,13 @@ static void exynos_ehci_phy_disable(struct device *dev)
>  
>  static void exynos_setup_vbus_gpio(struct device *dev)
>  {
> +	struct gpio_desc *gpio;
>  	int err;
> -	int gpio;
>  
> -	if (!dev->of_node)
> -		return;
> -
> -	gpio = of_get_named_gpio(dev->of_node, "samsung,vbus-gpio", 0);
> -	if (!gpio_is_valid(gpio))
> -		return;
> -
> -	err = devm_gpio_request_one(dev, gpio, GPIOF_OUT_INIT_HIGH,
> -				    "ehci_vbus_gpio");
> +	gpio = devm_gpiod_get_optional(dev, "samsung,vbus", GPIOD_OUT_HIGH);
> +	err = PTR_ERR_OR_ZERO(gpio);
>  	if (err)
> -		dev_err(dev, "can't request ehci vbus gpio %d", gpio);
> +		dev_err(dev, "can't request ehci vbus gpio: %d\n", err);
>  }
>  
>  static int exynos_ehci_probe(struct platform_device *pdev)
> -- 
> 2.38.0.rc1.362.ged0d419d3c-goog
> 
