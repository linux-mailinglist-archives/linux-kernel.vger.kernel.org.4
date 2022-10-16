Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1725F600102
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Oct 2022 18:03:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229791AbiJPQDl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Oct 2022 12:03:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229794AbiJPQDi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Oct 2022 12:03:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39E0038463;
        Sun, 16 Oct 2022 09:03:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C33FB60B82;
        Sun, 16 Oct 2022 16:03:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A257EC433D6;
        Sun, 16 Oct 2022 16:03:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665936216;
        bh=LDnbhYKu0OaoJUAfN10WZM+9a0MDfjpL5G3rRHFG/7Y=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=u7auC+zfaqK2y0cmSZw0TkB5fiszAgLtdm/bkN2RonZTDcYajpVbh+raRdQlm5oA8
         jefA+yw6jpyjnOxBYeLVkj8CcPOA76wTO8pXSuQhB+9xUV7BEIJCp/STx9d9n6mK6V
         2hG1GK68rJMMpxbMAo0znqznBjfpnXs5Lp4AqROF4A5F7wfcEqY9bceh/R9gP9S43+
         hNVkDQv3nJexYFe2AScuWF/k0lF8H4xkXU7y3x32M9lFMtOFY396IPm+zLcynH3Jyb
         fK2jb+WztoBVJbzhFsqFeXRYLk+njYOD2EXw7NftWTL9RVa73edxcdeLmH+cT+cxMn
         /Z9qM7y3VnE3A==
Date:   Sun, 16 Oct 2022 17:04:04 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Matti Vaittinen <mazziesaccount@gmail.com>
Cc:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 07/14] iio: ltc2688: Simplify using
 devm_regulator_*get_enable()
Message-ID: <20221016170404.411932d6@jic23-huawei>
In-Reply-To: <a29493f594c84b3bd852e462bbd3e591a8575a27.1660934107.git.mazziesaccount@gmail.com>
References: <cover.1660934107.git.mazziesaccount@gmail.com>
        <a29493f594c84b3bd852e462bbd3e591a8575a27.1660934107.git.mazziesaccount@gmail.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 19 Aug 2022 22:19:17 +0300
Matti Vaittinen <mazziesaccount@gmail.com> wrote:

> Use devm_regulator_bulk_get_enable() instead of open coded bulk-get,
> bulk-enable, add-action-to-disable-at-detach - pattern.
> 
> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>

Applied with the ordering tweaked as per Andy's review.
Also tweaked the patch title to iio: dac: ltc2688: 
just to make it a bit easier to go from patch title to driver.

> 
> ---
> v2 => v3
> Split to own patch.
> ---
>  drivers/iio/dac/ltc2688.c | 23 +++--------------------
>  1 file changed, 3 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/iio/dac/ltc2688.c b/drivers/iio/dac/ltc2688.c
> index 28bdde2d3088..fcad3efe62ea 100644
> --- a/drivers/iio/dac/ltc2688.c
> +++ b/drivers/iio/dac/ltc2688.c
> @@ -84,7 +84,6 @@ struct ltc2688_chan {
>  struct ltc2688_state {
>  	struct spi_device *spi;
>  	struct regmap *regmap;
> -	struct regulator_bulk_data regulators[2];
>  	struct ltc2688_chan channels[LTC2688_DAC_CHANNELS];
>  	struct iio_chan_spec *iio_chan;
>  	/* lock to protect against multiple access to the device and shared data */
> @@ -902,13 +901,6 @@ static int ltc2688_setup(struct ltc2688_state *st, struct regulator *vref)
>  			       LTC2688_CONFIG_EXT_REF);
>  }
>  
> -static void ltc2688_disable_regulators(void *data)
> -{
> -	struct ltc2688_state *st = data;
> -
> -	regulator_bulk_disable(ARRAY_SIZE(st->regulators), st->regulators);
> -}
> -
>  static void ltc2688_disable_regulator(void *regulator)
>  {
>  	regulator_disable(regulator);
> @@ -970,6 +962,7 @@ static int ltc2688_probe(struct spi_device *spi)
>  	struct regulator *vref_reg;
>  	struct device *dev = &spi->dev;
>  	int ret;
> +	static const char * const regulators[] = {"vcc", "iovcc"};
>  
>  	indio_dev = devm_iio_device_alloc(dev, sizeof(*st));
>  	if (!indio_dev)
> @@ -988,21 +981,11 @@ static int ltc2688_probe(struct spi_device *spi)
>  		return dev_err_probe(dev, PTR_ERR(st->regmap),
>  				     "Failed to init regmap");
>  
> -	st->regulators[0].supply = "vcc";
> -	st->regulators[1].supply = "iovcc";
> -	ret = devm_regulator_bulk_get(dev, ARRAY_SIZE(st->regulators),
> -				      st->regulators);
> -	if (ret)
> -		return dev_err_probe(dev, ret, "Failed to get regulators\n");
> -
> -	ret = regulator_bulk_enable(ARRAY_SIZE(st->regulators), st->regulators);
> +	ret = devm_regulator_bulk_get_enable(dev, ARRAY_SIZE(regulators),
> +					     regulators);
>  	if (ret)
>  		return dev_err_probe(dev, ret, "Failed to enable regulators\n");
>  
> -	ret = devm_add_action_or_reset(dev, ltc2688_disable_regulators, st);
> -	if (ret)
> -		return ret;
> -
>  	vref_reg = devm_regulator_get_optional(dev, "vref");
>  	if (IS_ERR(vref_reg)) {
>  		if (PTR_ERR(vref_reg) != -ENODEV)

