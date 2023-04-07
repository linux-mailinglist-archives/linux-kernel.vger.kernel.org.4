Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 466FB6DB19D
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 19:29:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229598AbjDGR3H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 13:29:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjDGR3G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 13:29:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D9D1A5FA;
        Fri,  7 Apr 2023 10:29:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9BACF6522F;
        Fri,  7 Apr 2023 17:29:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DC2CC433EF;
        Fri,  7 Apr 2023 17:29:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680888544;
        bh=HM8yc0g7zGvNrkwC2ClMGSBe7mAsX0QqDan2d5P6KwY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Rd/h7GqijfTNutX8NAo+CaMU+YWQ1znP5am7XaLwcvHwBjwp65GehhJpoeBLMo9iT
         IoRsGhuBJnpH7OOruHRJqz+yon7jcUhgXG51r0kNxVthRwCiVx40u8s2l37kPefVrJ
         8e05txpqmETRLafFloQJmCDjzBJLYgizstLIqxUiZb9BNjrTIRPPQ5nyvvlpWD5ZKX
         K94moDNpTMTUN8oM8ivZdZgXiYDmHq2HWj1NOh141VCBL/moDD4JyO5y106xI09p93
         3YkfTCfy8P5fwFqNh2dIHzavvdfgW5WfUDjlZRel+Owl6YyXjZHch0XuqUdI7U/F29
         7uO2ZIVSCY+EA==
Date:   Fri, 7 Apr 2023 18:44:20 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Nicolas Frattaroli <frattaroli.nicolas@gmail.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] iio: dac: mcp4922: get and enable vdd regulator
Message-ID: <20230407184420.1cd54af0@jic23-huawei>
In-Reply-To: <20230405140114.99011-3-frattaroli.nicolas@gmail.com>
References: <20230405140114.99011-1-frattaroli.nicolas@gmail.com>
        <20230405140114.99011-3-frattaroli.nicolas@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed,  5 Apr 2023 16:01:12 +0200
Nicolas Frattaroli <frattaroli.nicolas@gmail.com> wrote:

> The MCP4922 family of chips has a vdd power input, which we
> model in our device tree binding for it. The driver should get
> and enable the vdd regulator as is appropriate.
> 
> Signed-off-by: Nicolas Frattaroli <frattaroli.nicolas@gmail.com>

If, before doing this you add a patch using devm for all the
unwinding currently being done by hand in remove() you can
simplify this further use devm_regulator_get_enable()
(Note you can only do that for this regulator as we never touch it
 after enable - more complex handling needed for the vref one as
 described in review of patch 4.)

That conversion patch is pretty simple, so whilst I don't like asking
people to implement extra features, in this case the simplifications
to what you are doing here make that precusor work justified

Jonathan


> ---
>  drivers/iio/dac/mcp4922.c | 24 ++++++++++++++++++++----
>  1 file changed, 20 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iio/dac/mcp4922.c b/drivers/iio/dac/mcp4922.c
> index da4327624d45..0b9458cbbcff 100644
> --- a/drivers/iio/dac/mcp4922.c
> +++ b/drivers/iio/dac/mcp4922.c
> @@ -31,6 +31,7 @@ struct mcp4922_state {
>  	unsigned int value[MCP4922_NUM_CHANNELS];
>  	unsigned int vref_mv;
>  	struct regulator *vref_reg;
> +	struct regulator *vdd_reg;
>  	u8 mosi[2] __aligned(IIO_DMA_MINALIGN);
>  };
>  
> @@ -148,10 +149,23 @@ static int mcp4922_probe(struct spi_device *spi)
>  	if (ret < 0) {
>  		dev_err(&spi->dev, "Failed to read vref regulator: %d\n",
>  				ret);
> -		goto error_disable_reg;
> +		goto error_disable_vref_reg;
>  	}
>  	state->vref_mv = ret / 1000;
>  
> +	state->vdd_reg = devm_regulator_get(&spi->dev, "vdd");
> +	if (IS_ERR(state->vdd_reg)) {
> +		ret = dev_err_probe(&spi->dev, PTR_ERR(state->vdd_reg),
> +				    "vdd regulator not specified\n");
> +		goto error_disable_vref_reg;
> +	}
> +	ret = regulator_enable(state->vdd_reg);
> +	if (ret) {
> +		dev_err(&spi->dev, "Failed to enable vdd regulator: %d\n",
> +			ret);
> +		goto error_disable_vref_reg;
> +	}
> +
>  	spi_set_drvdata(spi, indio_dev);
>  	id = spi_get_device_id(spi);
>  	indio_dev->info = &mcp4922_info;
> @@ -167,12 +181,13 @@ static int mcp4922_probe(struct spi_device *spi)
>  	if (ret) {
>  		dev_err(&spi->dev, "Failed to register iio device: %d\n",
>  				ret);
> -		goto error_disable_reg;
> +		goto error_disable_vdd_reg;
>  	}
>  
>  	return 0;
> -
> -error_disable_reg:
> +error_disable_vdd_reg:
> +	regulator_disable(state->vdd_reg);
> +error_disable_vref_reg:
>  	regulator_disable(state->vref_reg);
>  
>  	return ret;
> @@ -185,6 +200,7 @@ static void mcp4922_remove(struct spi_device *spi)
>  
>  	iio_device_unregister(indio_dev);
>  	state = iio_priv(indio_dev);
> +	regulator_disable(state->vdd_reg);
>  	regulator_disable(state->vref_reg);
>  }
>  

