Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3B8E714107
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 00:35:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229958AbjE1Wfw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 May 2023 18:35:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbjE1Wfu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 May 2023 18:35:50 -0400
Received: from fgw23-7.mail.saunalahti.fi (fgw23-7.mail.saunalahti.fi [62.142.5.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E6E2BD
        for <linux-kernel@vger.kernel.org>; Sun, 28 May 2023 15:35:49 -0700 (PDT)
Received: from localhost (88-113-26-95.elisa-laajakaista.fi [88.113.26.95])
        by fgw23.mail.saunalahti.fi (Halon) with ESMTP
        id fd17a03d-fda7-11ed-b972-005056bdfda7;
        Mon, 29 May 2023 01:35:47 +0300 (EEST)
From:   andy.shevchenko@gmail.com
Date:   Mon, 29 May 2023 01:35:46 +0300
To:     Herve Codina <herve.codina@bootlin.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v4 2/3] iio: potentiometer: Add support for the Renesas
 X9250 potentiometers
Message-ID: <ZHPXQiD7GlBhBiCx@surfacebook>
References: <20230509160852.158101-1-herve.codina@bootlin.com>
 <20230509160852.158101-3-herve.codina@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230509160852.158101-3-herve.codina@bootlin.com>
X-Spam-Status: No, score=0.7 required=5.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
        FORGED_GMAIL_RCVD,FREEMAIL_FROM,NML_ADSP_CUSTOM_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tue, May 09, 2023 at 06:08:51PM +0200, Herve Codina kirjoitti:
> The Renesas X9250 integrates four digitally controlled potentiometers.
> On each potentiometer, the X9250T has a 100 kOhms total resistance and
> the X9250U has a 50 kOhms total resistance.

...

> +/*

> + *

Redundant blank line.

> + * x9250.c  --  Renesas X9250 potentiometers IIO driver

Please, no filename in the file itself. It adds an additional burden in case
the module will be renamed in the future.

> + * Copyright 2023 CS GROUP France
> + *
> + * Author: Herve Codina <herve.codina@bootlin.com>
> + */

> +#include <linux/delay.h>
> +#include <linux/gpio/consumer.h>
> +#include <linux/iio/iio.h>
> +#include <linux/limits.h>
> +#include <linux/module.h>
> +#include <linux/regulator/consumer.h>
> +#include <linux/slab.h>
> +#include <linux/spi/spi.h>

...

> +	return spi_write_then_read(x9250->spi, txbuf, ARRAY_SIZE(txbuf), NULL, 0);

sizeof() suffice.

...

> +	return spi_write_then_read(x9250->spi, txbuf, ARRAY_SIZE(txbuf), val, 1);

Ditto.

...

> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		ret = x9250_read8(x9250, X9250_CMD_RD_WCR(ch), &v);
> +		if (ret)
> +			return ret;
> +		*val = v;
> +		return IIO_VAL_INT;
> +
> +	case IIO_CHAN_INFO_SCALE:
> +		*val = 1000 * x9250->cfg->kohms;
> +		*val2 = U8_MAX;
> +		return IIO_VAL_FRACTIONAL;
> +	}

> +	return -EINVAL;

Just make it part of default: case.

...

> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		*length = ARRAY_SIZE(range);
> +		*vals = range;
> +		*type = IIO_VAL_INT;
> +		return IIO_AVAIL_RANGE;
> +	}
> +
> +	return -EINVAL;

Same.

...

> +	if (val > U8_MAX || val < 0)
> +		return -EINVAL;

ERANGE ?

...

> +

Redundant blank line.

> +module_spi_driver(x9250_spi_driver);

-- 
With Best Regards,
Andy Shevchenko


