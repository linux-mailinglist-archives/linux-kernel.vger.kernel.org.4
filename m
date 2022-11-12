Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59017626AA9
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Nov 2022 17:44:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234983AbiKLQom (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Nov 2022 11:44:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230170AbiKLQok (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Nov 2022 11:44:40 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4F6DDFC3;
        Sat, 12 Nov 2022 08:44:38 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 72CFEB80976;
        Sat, 12 Nov 2022 16:44:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BFF1C433D6;
        Sat, 12 Nov 2022 16:44:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668271476;
        bh=E21h76Ste+R/XmnRwrw2cGPAJ76iv8Ux/9BP47v6Mr8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=jnNOYgEaGy+D83UtdT3ITvAmvw+hiW1aeuAupgoO0Vygya+1Q8/3/uE9uNi5+Re84
         4VFRH5J14tCHmu4+XIC3BJs5NaP+7fQ8vG+ZsFZwNoBurjlDGXmgd+9rIl5eP5QIff
         EeMYFEeI+fHRXDX+fUNIpy1jVateIktbO8Q0o82zGz9+FfdAr/SINp1aj0BeWg76Or
         OBYMiKge3bEwzQF2fcyaItSMt/fu1LJCtVvalV0Ip7EJD1FBhoeLCqTt8MDQmNHATJ
         gTg1J4EA8SspfeIOMf93Rcrb3CpgMMCKk4GcshoEGytq1qxpm59uk61mTgEYRnoldv
         0stLsFNTGF69A==
Date:   Sat, 12 Nov 2022 16:56:49 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Cosmin Tanislav <cosmin.tanislav@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/5] iio: addac: ad74413r: implement support for
 optional refin-supply
Message-ID: <20221112165649.4e6c5cd3@jic23-huawei>
In-Reply-To: <20221111143921.742194-4-linux@rasmusvillemoes.dk>
References: <20221111143921.742194-1-linux@rasmusvillemoes.dk>
        <20221111143921.742194-4-linux@rasmusvillemoes.dk>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 11 Nov 2022 15:39:19 +0100
Rasmus Villemoes <linux@rasmusvillemoes.dk> wrote:

> The ad74412r/ad74413r has an internal 2.5V reference output, which (by
> tying the REFOUT pin to the REFIN pin) can be used in lieu of an
> external 2.5V input reference.
> 
> Support that case by using devm_regulator_get_optional(), and simply
> hardcode the 2500000 uV in ad74413r_get_output_current_scale().
> 
> I'm not sure this is completely correct, but it's certainly better
> than the current behaviour, where when refin-supply is not defined in
> device tree, the regulator framework helpfully does its
> 
>   supply refin not found, using dummy regulator

You could reasonably assume that's a bug in the firmware.. See suggestions
in reply to patch 2.  Given external wiring is involved, I don't think
we can assume absence of a regulator means that loop back is in place.
We need to indicate that explicitly in the binding in some way.

Jonathan


> 
> thing. When we then do the regulator_get_voltage(), that dummy
> regulator of course doesn't support that operation and thus returns
> -22 (-EINVAL) which is used without being checked.
> 
> Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> ---
>  drivers/iio/addac/ad74413r.c | 31 ++++++++++++++++++++-----------
>  1 file changed, 20 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/iio/addac/ad74413r.c b/drivers/iio/addac/ad74413r.c
> index 37485be88a63..9f77d2f514de 100644
> --- a/drivers/iio/addac/ad74413r.c
> +++ b/drivers/iio/addac/ad74413r.c
> @@ -608,7 +608,10 @@ static int ad74413r_get_output_voltage_scale(struct ad74413r_state *st,
>  static int ad74413r_get_output_current_scale(struct ad74413r_state *st,
>  					     int *val, int *val2)
>  {
> -	*val = regulator_get_voltage(st->refin_reg);
> +	if (st->refin_reg)
> +		*val = regulator_get_voltage(st->refin_reg);
> +	else
> +		*val = 2500000;
>  	*val2 = st->sense_resistor_ohms * AD74413R_DAC_CODE_MAX * 1000;
>  
>  	return IIO_VAL_FRACTIONAL;
> @@ -1313,19 +1316,25 @@ static int ad74413r_probe(struct spi_device *spi)
>  	if (IS_ERR(st->regmap))
>  		return PTR_ERR(st->regmap);
>  
> -	st->refin_reg = devm_regulator_get(st->dev, "refin");
> -	if (IS_ERR(st->refin_reg))
> -		return dev_err_probe(st->dev, PTR_ERR(st->refin_reg),
> -				     "Failed to get refin regulator\n");
> +	st->refin_reg = devm_regulator_get_optional(st->dev, "refin");
> +	if (IS_ERR(st->refin_reg)) {
> +		ret = PTR_ERR(st->refin_reg);
> +		if (ret != -ENODEV)
> +			return dev_err_probe(st->dev, ret,
> +					     "Failed to get refin regulator\n");
> +		st->refin_reg = NULL;
> +	}
>  
> -	ret = regulator_enable(st->refin_reg);
> -	if (ret)
> -		return ret;
> +	if (st->refin_reg) {
> +		ret = regulator_enable(st->refin_reg);
> +		if (ret)
> +			return ret;
>  
> -	ret = devm_add_action_or_reset(st->dev, ad74413r_regulator_disable,
> +		ret = devm_add_action_or_reset(st->dev, ad74413r_regulator_disable,
>  				       st->refin_reg);
> -	if (ret)
> -		return ret;
> +		if (ret)
> +			return ret;
> +	}
>  
>  	st->sense_resistor_ohms = 100000000;
>  	device_property_read_u32(st->dev, "shunt-resistor-micro-ohms",

