Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1742D6092B5
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Oct 2022 14:40:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230148AbiJWMkZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Oct 2022 08:40:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229728AbiJWMkU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Oct 2022 08:40:20 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDAC4558E3;
        Sun, 23 Oct 2022 05:40:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1809FB80D94;
        Sun, 23 Oct 2022 12:40:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72B35C433D6;
        Sun, 23 Oct 2022 12:40:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666528814;
        bh=ZEiIzMSDpIkZt7/SPHRln4v4bjyPf/a+k7QaV+LPBFM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Nynx9eZWNn/hKOx1JDTdE41rYub+ZHZRKQ2AOro5ymdPlhfmRVMI3In521M9ndeIE
         y18Fs+5jzHiSV9JbzVl91u5oFC/oWwG8B7XIG1RYbAK7WULnj7cm1y98/qFnGfgkoo
         iE93ISEbaiBkEZWNkcelYX8MJ+S1oiHqQBlsWp/mwk7UxNH6CxcFE/PgTcDS0RrBF6
         1GBqca+PWiwX6xZrughhmUoexEjNLlVTmK2CR8ITDjMdvUI+VhtLADY5/iBQzE8r0P
         C3Bfcsh3jBMtPkmDiPxQqBoqjWADI2kDj8X9VzbPulXVOGZCoCc3h/faPz2FQfsYj5
         6is9x+78D3WYw==
Date:   Sun, 23 Oct 2022 13:40:48 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Cosmin Tanislav <demonsingur@gmail.com>
Cc:     Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Cosmin Tanislav <cosmin.tanislav@analog.com>
Subject: Re: [PATCH v2 1/5] iio: temperature: ltc2983: allocate iio channels
 once
Message-ID: <20221023134048.5a1dd6d9@jic23-huawei>
In-Reply-To: <20221020090257.1717053-2-demonsingur@gmail.com>
References: <20221020090257.1717053-1-demonsingur@gmail.com>
        <20221020090257.1717053-2-demonsingur@gmail.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 20 Oct 2022 12:02:53 +0300
Cosmin Tanislav <demonsingur@gmail.com> wrote:

> From: Cosmin Tanislav <cosmin.tanislav@analog.com>
> 
> Currently, every time the device wakes up from sleep, the
> iio_chan array is reallocated, leaking the previous one
> until the device is removed (basically never).
> 
> Move the allocation to the probe function to avoid this.
> 
> Fixes: f110f3188e56 ("iio: temperature: Add support for LTC2983")
> Signed-off-by: Cosmin Tanislav <cosmin.tanislav@analog.com>
Note I already have this queued as a fix and I've sent the pull request to Greg this
morning.  For future versions of this series, maybe just put a note in the cover
letter to cover the dependency.

Jonathan

> ---
>  drivers/iio/temperature/ltc2983.c | 13 ++++++-------
>  1 file changed, 6 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/iio/temperature/ltc2983.c b/drivers/iio/temperature/ltc2983.c
> index b652d2b39bcf..a60ccf183687 100644
> --- a/drivers/iio/temperature/ltc2983.c
> +++ b/drivers/iio/temperature/ltc2983.c
> @@ -1385,13 +1385,6 @@ static int ltc2983_setup(struct ltc2983_data *st, bool assign_iio)
>  		return ret;
>  	}
>  
> -	st->iio_chan = devm_kzalloc(&st->spi->dev,
> -				    st->iio_channels * sizeof(*st->iio_chan),
> -				    GFP_KERNEL);
> -
> -	if (!st->iio_chan)
> -		return -ENOMEM;
> -
>  	ret = regmap_update_bits(st->regmap, LTC2983_GLOBAL_CONFIG_REG,
>  				 LTC2983_NOTCH_FREQ_MASK,
>  				 LTC2983_NOTCH_FREQ(st->filter_notch_freq));
> @@ -1514,6 +1507,12 @@ static int ltc2983_probe(struct spi_device *spi)
>  		gpiod_set_value_cansleep(gpio, 0);
>  	}
>  
> +	st->iio_chan = devm_kzalloc(&spi->dev,
> +				    st->iio_channels * sizeof(*st->iio_chan),
> +				    GFP_KERNEL);
> +	if (!st->iio_chan)
> +		return -ENOMEM;
> +
>  	ret = ltc2983_setup(st, true);
>  	if (ret)
>  		return ret;

