Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64E9773D054
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Jun 2023 13:14:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231523AbjFYLOK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Jun 2023 07:14:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231743AbjFYLOB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Jun 2023 07:14:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FBAAE7D;
        Sun, 25 Jun 2023 04:14:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D8EB960BAA;
        Sun, 25 Jun 2023 11:13:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8803BC433C0;
        Sun, 25 Jun 2023 11:13:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687691639;
        bh=0oW07HJ3CQShYA29Fp6HIbstg7j5BlNXfhMMNk6cg+0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=GkTM9OGbvv7E/j0Sr71lUfvDO9zsEubEPWgsXBErpaWx7SJtKMax8MI9I7GryGuXx
         Bzv+bmuwlbX42XDyWiFexOJwdaxHbCsRXflJkFMzQ/xOOCvC0k2qX3fQkU3Mw9ZFE2
         z1NSoZYoZgOyOum3U1xVcHYAtDsKvZYiSMaizYmelE+Oqj4fs6qFmZ35XiV9zYqKTF
         0NOgAoFBHcT0MKNYN2pOgF1EYPR7yI5X48CZiLZnaKoteVdnbAkZrO8cgTsqE4nNo6
         8Rr8blOqAesoWj+lbYFZcIhkbzX+n/kNX0JInTFpoYPvRHZfOPEXDoT6W7C18hwsGm
         f0XehQI0d1qOQ==
Date:   Sun, 25 Jun 2023 12:14:01 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Cosmin Tanislav <cosmin.tanislav@analog.com>,
        devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] iio: addac: ad74413r: wire up
 digital-input-threshold-microvolt DT property
Message-ID: <20230625121401.0fd87cc8@jic23-huawei>
In-Reply-To: <20230623113327.1062170-3-linux@rasmusvillemoes.dk>
References: <20230623113327.1062170-1-linux@rasmusvillemoes.dk>
        <20230623113327.1062170-3-linux@rasmusvillemoes.dk>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 23 Jun 2023 13:33:26 +0200
Rasmus Villemoes <linux@rasmusvillemoes.dk> wrote:

> The threshold is common to all channels configured as digital
> input.
> 
> So far, we have not seen the settings in the DIN_THRESH affecting
> functions other than digital input, but with a4cba07e64e6 ("iio:
> addac: ad74413: don't set DIN_SINK for functions other than digital
> input") in mind, do not read and apply the
> digital-input-threshold-microvolt setting unless at least one channel
> has been configured as one of the digital input variants.
> 
> Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
LGTM. Will pick up once the minor change in binding is done if no
other feedback comes in.

Thanks,

Jonathan

> ---
>  drivers/iio/addac/ad74413r.c | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 
> diff --git a/drivers/iio/addac/ad74413r.c b/drivers/iio/addac/ad74413r.c
> index e3366cf5eb31..efdd7fdd7ab9 100644
> --- a/drivers/iio/addac/ad74413r.c
> +++ b/drivers/iio/addac/ad74413r.c
> @@ -129,6 +129,12 @@ struct ad74413r_state {
>  #define AD74413R_GPO_CONFIG_COMPARATOR		0b011
>  #define AD74413R_GPO_CONFIG_HIGH_IMPEDANCE	0b100
>  
> +#define AD74413R_REG_DIN_THRESH		0x22
> +#define AD74413R_DIN_COMP_THRESH_MASK	GENMASK(5, 1)
> +#define AD74413R_DIN_THRESH_MODE	BIT(0)
> +#define AD74413R_DIN_THRESH_MODE_16V	BIT(0)
> +#define AD74413R_DIN_THRESH_MODE_AVDD	0
> +
>  #define AD74413R_REG_ADC_CONV_CTRL	0x23
>  #define AD74413R_CONV_SEQ_MASK		GENMASK(9, 8)
>  #define AD74413R_CONV_SEQ_ON		0b00
> @@ -1446,6 +1452,20 @@ static int ad74413r_probe(struct spi_device *spi)
>  	}
>  
>  	if (st->num_comparator_gpios) {
> +		u32 thresh, val, mask;
> +
> +		if (!device_property_read_u32(st->dev, "digital-input-threshold-microvolt",
> +					      &thresh)) {
> +			val = thresh/500000 - 1;
> +			val = FIELD_PREP(AD74413R_DIN_COMP_THRESH_MASK, val);
> +			val |= AD74413R_DIN_THRESH_MODE_16V;
> +			mask = AD74413R_DIN_COMP_THRESH_MASK | AD74413R_DIN_THRESH_MODE;
> +			ret = regmap_update_bits(st->regmap, AD74413R_REG_DIN_THRESH,
> +						 mask, val);
> +			if (ret)
> +				return ret;
> +		}
> +
>  		st->comp_gpiochip.owner = THIS_MODULE;
>  		st->comp_gpiochip.label = st->chip_info->name;
>  		st->comp_gpiochip.base = -1;

