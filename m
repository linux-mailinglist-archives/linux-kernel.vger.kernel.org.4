Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A181E7212AF
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Jun 2023 22:30:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230455AbjFCUad (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Jun 2023 16:30:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbjFCUab (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Jun 2023 16:30:31 -0400
Received: from fgw23-7.mail.saunalahti.fi (fgw23-7.mail.saunalahti.fi [62.142.5.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFA0F12E
        for <linux-kernel@vger.kernel.org>; Sat,  3 Jun 2023 13:30:30 -0700 (PDT)
Received: from localhost (88-113-26-95.elisa-laajakaista.fi [88.113.26.95])
        by fgw23.mail.saunalahti.fi (Halon) with ESMTP
        id 7a2b1d70-024d-11ee-b972-005056bdfda7;
        Sat, 03 Jun 2023 23:30:28 +0300 (EEST)
From:   andy.shevchenko@gmail.com
Date:   Sat, 3 Jun 2023 23:30:27 +0300
To:     Nikita Shubin <nikita.shubin@maquefel.me>
Cc:     Alexander Sverdlin <alexander.sverdlin@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Hartley Sweeten <hsweeten@visionengravers.com>,
        Russell King <linux@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Michael Peters <mpeters@embeddedts.com>,
        Kris Bahnsen <kris@embeddedts.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org
Subject: Re: [PATCH v1 20/43] net: cirrus: add DT support for Cirrus EP93xx
Message-ID: <ZHui4znexQPAq9hj@surfacebook>
References: <20230424123522.18302-1-nikita.shubin@maquefel.me>
 <20230601054549.10843-2-nikita.shubin@maquefel.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230601054549.10843-2-nikita.shubin@maquefel.me>
X-Spam-Status: No, score=0.7 required=5.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
        FORGED_GMAIL_RCVD,FREEMAIL_FROM,NML_ADSP_CUSTOM_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thu, Jun 01, 2023 at 08:45:25AM +0300, Nikita Shubin kirjoitti:
> - find register range from the device tree
> - get "copy_addr" from the device tree
> - get phy_id from the device tree

...

> -#include <linux/platform_data/eth-ep93xx.h>
>  #include <linux/reboot.h>
> +#include <linux/platform_data/eth-ep93xx.h>

Stray change.

...

>  	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>  	irq = platform_get_irq(pdev, 0);
>  	if (!mem || irq < 0)
>  		return -ENXIO;
>  
> -	dev = ep93xx_dev_alloc(data);
> +	base_addr = ioremap(mem->start, resource_size(mem));
> +	if (!base_addr) {
> +		dev_err(&pdev->dev, "Failed to ioremap ethernet registers\n");
> +		return -EIO;
> +	}

Why not switching to devm_platform_ioremap_resource()?

...

> +	if (of_property_read_u32(np, "reg", &phy_id)) {
> +		dev_err(&pdev->dev, "Failed to locate \"phy_id\"\n");
> +		return -ENOENT;

		return dev_err_probe(...); ?
> +	}

-- 
With Best Regards,
Andy Shevchenko


