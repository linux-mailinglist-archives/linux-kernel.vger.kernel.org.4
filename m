Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 980AA6F47CC
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 17:55:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234627AbjEBPzK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 11:55:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234389AbjEBPzI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 11:55:08 -0400
Received: from fgw23-7.mail.saunalahti.fi (fgw23-7.mail.saunalahti.fi [62.142.5.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9333F1BF
        for <linux-kernel@vger.kernel.org>; Tue,  2 May 2023 08:55:07 -0700 (PDT)
Received: from localhost (88-113-26-95.elisa-laajakaista.fi [88.113.26.95])
        by fgw23.mail.saunalahti.fi (Halon) with ESMTP
        id b418ae39-e901-11ed-b972-005056bdfda7;
        Tue, 02 May 2023 18:55:04 +0300 (EEST)
From:   andy.shevchenko@gmail.com
Date:   Tue, 2 May 2023 18:55:04 +0300
To:     Okan Sahin <okan.sahin@analog.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] gpio: ds4520: Add ADI DS4520 GPIO Expander Support
Message-ID: <ZFEyWH9PmtJIyeCK@surfacebook>
References: <20230501230517.4491-1-okan.sahin@analog.com>
 <20230501230517.4491-3-okan.sahin@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230501230517.4491-3-okan.sahin@analog.com>
X-Spam-Status: No, score=0.7 required=5.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
        FORGED_GMAIL_RCVD,FREEMAIL_FROM,NML_ADSP_CUSTOM_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tue, May 02, 2023 at 02:05:16AM +0300, Okan Sahin kirjoitti:
> The DS4520 is a 9-bit nonvolatile (NV) I/O expander.
> It offers users a digitally programmable alternative
> to hardware jumpers and mechanical switches that are
> being used to control digital logic node.

...

> +#include <linux/device.h>
> +#include <linux/gpio/driver.h>
> +#include <linux/gpio/regmap.h>
> +#include <linux/i2c.h>

Missing property.h.

> +#include <linux/regmap.h>

...

> +#define NUMBER_OF_GPIO	9
> +
> +#define PULLUP0		0xF0
> +#define IO_CONTROL0	0xF2
> +#define IO_STATUS0	0xF8

No namespace for the above?

...

> +	struct gpio_regmap_config config = {0};

0 is not needed.

> +	ngpio = NUMBER_OF_GPIO;

Do you really need this? Can Device Tree be sufficient here? (We have a
GPIO-wide property for that).

...

> +	ret = device_property_read_u32(dev, "reg", &base);
> +	if (ret)
> +		return -EINVAL;

Why shadowing error?

...

> +	regmap = devm_regmap_init_i2c(client, &ds4520_regmap_config);
> +	if (IS_ERR(regmap)) {

> +		ret = PTR_ERR(regmap);
> +		dev_err_probe(dev, ret,
> +			      "Failed to allocate register map\n");
> +		return ret;

	return dev_err_probe();

> +	}

...

> +	config.ngpio = ngpio;

Why do you use temporary variable ngpio and not assign directly here?

-- 
With Best Regards,
Andy Shevchenko


