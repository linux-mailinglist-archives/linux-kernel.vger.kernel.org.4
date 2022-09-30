Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5841C5F0EA1
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 17:16:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231720AbiI3PQg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 11:16:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231810AbiI3PQU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 11:16:20 -0400
Received: from elvis.franken.de (elvis.franken.de [193.175.24.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5EF5011DFEF;
        Fri, 30 Sep 2022 08:16:17 -0700 (PDT)
Received: from uucp (helo=alpha)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1oeHkN-0003TJ-00; Fri, 30 Sep 2022 17:16:15 +0200
Received: by alpha.franken.de (Postfix, from userid 1000)
        id 14E97C0D1E; Fri, 30 Sep 2022 17:15:25 +0200 (CEST)
Date:   Fri, 30 Sep 2022 17:15:25 +0200
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC/PATCH v2] MIPS: pci: lantiq: switch to using gpiod API
Message-ID: <20220930151525.GC12989@alpha.franken.de>
References: <YzE9E+Esv/rqO0MA@google.com>
 <YzKDFCq3M2gxlJ2e@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YzKDFCq3M2gxlJ2e@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 26, 2022 at 09:59:00PM -0700, Dmitry Torokhov wrote:
> This patch switches the driver from legacy gpio API to the newer
> gpiod API.
> 
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> ---
> v2 - actually compiles.

I have some doubts...

>  arch/mips/pci/pci-lantiq.c | 27 ++++++++++++---------------
>  1 file changed, 12 insertions(+), 15 deletions(-)
> 
> diff --git a/arch/mips/pci/pci-lantiq.c b/arch/mips/pci/pci-lantiq.c
> index 1ca42f482130..377b4a2577e1 100644
> --- a/arch/mips/pci/pci-lantiq.c
> +++ b/arch/mips/pci/pci-lantiq.c
> @@ -9,11 +9,11 @@
>  #include <linux/kernel.h>
>  #include <linux/init.h>
>  #include <linux/delay.h>
> +#include <linux/gpio/consumer.h>
>  #include <linux/mm.h>
>  #include <linux/vmalloc.h>
>  #include <linux/clk.h>
>  #include <linux/of_platform.h>
> -#include <linux/of_gpio.h>
>  #include <linux/of_irq.h>
>  #include <linux/of_pci.h>
>  
> @@ -62,7 +62,7 @@
>  __iomem void *ltq_pci_mapped_cfg;
>  static __iomem void *ltq_pci_membase;
>  
> -static int reset_gpio;
> +static gpio_desc *reset_gpio;

/local/tbogendoerfer/korg/linux/arch/mips/pci/pci-lantiq.c:65:8: error: unknown type name ‘gpio_desc’
 static gpio_desc *reset_gpio;


>  static struct clk *clk_pci, *clk_external;
>  static struct resource pci_io_resource;
>  static struct resource pci_mem_resource;
> @@ -123,17 +123,14 @@ static int ltq_pci_startup(struct platform_device *pdev)
>  		clk_disable(clk_external);
>  
>  	/* setup reset gpio used by pci */
> -	reset_gpio = of_get_named_gpio(node, "gpio-reset", 0);
> -	if (gpio_is_valid(reset_gpio)) {
> -		int ret = devm_gpio_request(&pdev->dev,
> -						reset_gpio, "pci-reset");
> -		if (ret) {
> -			dev_err(&pdev->dev,
> -				"failed to request gpio %d\n", reset_gpio);
> -			return ret;
> -		}
> -		gpio_direction_output(reset_gpio, 1);
> +	reset_gpio = devm_gpiod_get_optional(&pdev->dev, "reset",
> +					     GPIOD_OUT_LOW);
> +	ret = PTR_ERR_OR_ZERO(reset_gpio);

/local/tbogendoerfer/korg/linux/arch/mips/pci/pci-lantiq.c:128:2: error: ‘ret’ undeclared (first use in this function)
  ret = PTR_ERR_OR_ZERO(reset_gpio);

Thomas.


-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
