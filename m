Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90F9C720FF9
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Jun 2023 14:03:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229796AbjFCMDa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Jun 2023 08:03:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229595AbjFCMD3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Jun 2023 08:03:29 -0400
Received: from fgw23-7.mail.saunalahti.fi (fgw23-7.mail.saunalahti.fi [62.142.5.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B9B9196
        for <linux-kernel@vger.kernel.org>; Sat,  3 Jun 2023 05:03:27 -0700 (PDT)
Received: from localhost (88-113-26-95.elisa-laajakaista.fi [88.113.26.95])
        by fgw23.mail.saunalahti.fi (Halon) with ESMTP
        id a4cb2b86-0206-11ee-b972-005056bdfda7;
        Sat, 03 Jun 2023 15:03:25 +0300 (EEST)
From:   andy.shevchenko@gmail.com
Date:   Sat, 3 Jun 2023 15:03:25 +0300
To:     fl.scratchpad@gmail.com
Cc:     jic23@kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Alexandru Tachici <alexandru.tachici@analog.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v3 3/5] iio: adc: ad7192: Use VRef instead of AVdd as
 reference voltage source
Message-ID: <ZHssDS57yx46RvFA@surfacebook>
References: <20230530075311.400686-1-fl.scratchpad@gmail.com>
 <20230530075311.400686-4-fl.scratchpad@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230530075311.400686-4-fl.scratchpad@gmail.com>
X-Spam-Status: No, score=0.7 required=5.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
        FORGED_GMAIL_RCVD,FREEMAIL_FROM,NML_ADSP_CUSTOM_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tue, May 30, 2023 at 09:53:09AM +0200, fl.scratchpad@gmail.com kirjoitti:
> From: Fabrizio Lamarque <fl.scratchpad@gmail.com>
> 
> Add missing vref-supply and fix avdd-supply used as if it were vref.
> 
> AD7192 requires three independent voltage sources, digital supply (on
> pin DVdd), analog supply (on AVdd) and reference voltage (VRef on
> alternate pin pair REFIN1 or REFIN2).
> 
> Emit a warning message when AVdd is used in place of VRef for backwards
> compatibility.

...

> +	st->vref = devm_regulator_get_optional(&spi->dev, "vref");
> +	if (!IS_ERR(st->vref)) {
> +		ret = regulator_enable(st->vref);
> +		if (ret)
> +			return dev_err_probe(&spi->dev, ret,
> +					     "Failed to enable specified VRef supply\n");
> +
> +		ret = devm_add_action_or_reset(&spi->dev, ad7192_reg_disable, st->vref);
> +		if (ret)
> +			return ret;
> +	} else if (PTR_ERR(st->vref) != -ENODEV) {
> +		return PTR_ERR(st->vref);
> +	}

Wouldn't this be better?

	if (IS_ERR(st->vref)) {
		if (PTR_ERR(st->vref) != -ENODEV)
			return PTR_ERR(st->vref);
	} else {

...

>  	if (ret)
>  		return dev_err_probe(&spi->dev, ret, "Failed to enable specified DVdd supply\n");
>  
> -	ret = regulator_get_voltage(st->avdd);
> +

One blank line is enough.

> +	if (!IS_ERR(st->vref)) {
> +		ret = regulator_get_voltage(st->vref);

Why negative conditional? Usual pattern is to check for errors first, so

	if (IS_ERR(st->vref)) {
		dev_warn(...);
		...
	} else {
		ret = regulator_get_voltage(st->vref);
	}

> +	} else {
> +		dev_warn(&spi->dev, "Using AVdd in place of VRef. Likely an old DTS\n");
> +		ret = regulator_get_voltage(st->avdd);
> +	}

-- 
With Best Regards,
Andy Shevchenko


