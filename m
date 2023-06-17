Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA8F073435D
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Jun 2023 21:48:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233935AbjFQTsh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Jun 2023 15:48:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbjFQTsd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Jun 2023 15:48:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D169CE4;
        Sat, 17 Jun 2023 12:48:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6655E610E7;
        Sat, 17 Jun 2023 19:48:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAA55C433C8;
        Sat, 17 Jun 2023 19:48:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687031311;
        bh=WjHfdWYHWQp9ZF20XQ2bFJYdb5Ej6liaTwZ2tTeQqSg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=LjCKwgxTpgAFMq3bjlJAGKdhqWJNQivhg+6advoXBN+Bs7VEDTkqeVTsXvfkhL8Mb
         RFhJN2gsMPuhjb1bbvumum6omXBAShXAY1saFKm7nuQpoLeAHNZ4S2jzb5eVAz88+e
         8U17V48G/Ee8pitlmcG0WzvGbYgphYxttFzxtU9yV28Y0FrzwLmUw+oegyIrGf2boy
         Yx5qZZkLaunnDigDPxDSqb/rnbeMg1w1aK3Zb0GzrumVZ9s3N664X4BglWpi8Xpkvz
         MOQIKXNLyet/WUPmu+8DSQ9z2ea3L4oaPoI1Qh7N57vWFpikeMUzLHzLvZLhVxUb6m
         GSuZl2fYQOSVg==
Date:   Sat, 17 Jun 2023 20:48:24 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Matti Vaittinen <mazziesaccount@gmail.com>
Cc:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] iio: light: bu27008: add chip info
Message-ID: <20230617204824.6f3d9b20@jic23-huawei>
In-Reply-To: <e898bb74afdbc9aa030932e82c36b4ce6d13bab7.1686651445.git.mazziesaccount@gmail.com>
References: <cover.1686650184.git.mazziesaccount@gmail.com>
        <e898bb74afdbc9aa030932e82c36b4ce6d13bab7.1686651445.git.mazziesaccount@gmail.com>
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

On Tue, 13 Jun 2023 13:20:07 +0300
Matti Vaittinen <mazziesaccount@gmail.com> wrote:

> The ROHM BU27010 RGB + flickering sensor is in many regards similar to
> the BU27008. Prepare for adding support for BU27010 by allowing
> chip-specific properties to be brought from the of_device_id data.
> 
> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
A few things inline - including some commented out code you missed
when tidying up before sending.

Jonathan

> ---
>  drivers/iio/light/rohm-bu27008.c | 185 +++++++++++++++++++++++--------
>  1 file changed, 138 insertions(+), 47 deletions(-)
> 
> diff --git a/drivers/iio/light/rohm-bu27008.c b/drivers/iio/light/rohm-bu27008.c
> index b50bf8973d9a..8c7f6f20a523 100644
> --- a/drivers/iio/light/rohm-bu27008.c
> +++ b/drivers/iio/light/rohm-bu27008.c
> @@ -211,7 +211,33 @@ static const struct iio_chan_spec bu27008_channels[] = {
>  	IIO_CHAN_SOFT_TIMESTAMP(BU27008_NUM_CHANS),
>  };
>  
> +struct bu27008_data;
> +
> +struct bu27_chip_data {
> +	const char *name;
> +	int (*chip_init)(struct bu27008_data *data);
> +	int (*get_gain_sel)(struct bu27008_data *data, int *sel);
> +	int (*write_gain_sel)(struct bu27008_data *data, int sel);
> +	const struct regmap_config *regmap_cfg;
> +	const struct iio_gain_sel_pair *gains;
> +	const struct iio_gain_sel_pair *gains_ir;
> +	int num_gains;
> +	int num_gains_ir;
> +	int scale1x;
> +
> +	int drdy_en_reg;
> +	int drdy_en_mask;
> +	int meas_en_reg;
> +	int meas_en_mask;
> +	int valid_reg;
> +	int chan_sel_reg;
> +	int chan_sel_mask;
> +	int int_time_mask;
> +	u8 part_id;
> +};
> +
>  struct bu27008_data {
> +	const struct bu27_chip_data *cd;
>  	struct regmap *regmap;
>  	struct iio_trigger *trig;
>  	struct device *dev;
> @@ -282,6 +308,32 @@ static const struct regmap_config bu27008_regmap = {
>  	.disable_locking = true,
>  };
>  
> +static int bu27008_chip_init(struct bu27008_data *data);
> +static int bu27008_write_gain_sel(struct bu27008_data *data, int sel);
> +static int bu27008_get_gain_sel(struct bu27008_data *data, int *sel);
> +
> +static const struct bu27_chip_data bu27008_chip = {
> +	.name = "bu27008",
> +	.chip_init = bu27008_chip_init,
> +	.scale1x = BU27008_SCALE_1X,

I'd keep this in same order as the definition unless there is a
strong reason for a different ordering (perhaps the structure
is ordered for packing purposes or something like that and assigning
can be done in an order that groups things better?)
Cost of out of order is that it's hard to check if everything is assigned.

> +	.get_gain_sel = bu27008_get_gain_sel,
> +	.write_gain_sel = bu27008_write_gain_sel,
> +	.part_id = BU27008_ID,
> +	.regmap_cfg = &bu27008_regmap,
> +	.drdy_en_reg = BU27008_REG_MODE_CONTROL3,
> +	.drdy_en_mask = BU27008_MASK_INT_EN,
> +	.valid_reg = BU27008_REG_MODE_CONTROL3,
> +	.meas_en_reg = BU27008_REG_MODE_CONTROL3,
> +	.meas_en_mask = BU27008_MASK_MEAS_EN,
> +	.chan_sel_reg = BU27008_REG_MODE_CONTROL3,
> +	.chan_sel_mask = BU27008_MASK_CHAN_SEL,
> +	.int_time_mask = BU27008_MASK_MEAS_MODE,
> +	.gains = &bu27008_gains[0],
> +	.num_gains = ARRAY_SIZE(bu27008_gains),
> +	.gains_ir = &bu27008_gains_ir[0],
> +	.num_gains_ir = ARRAY_SIZE(bu27008_gains_ir),
> +};

Could you move this down to below all the callbacks so that no need for forward
definitions of the functions? 

> +
>  #define BU27008_MAX_VALID_RESULT_WAIT_US	50000
>  #define BU27008_VALID_RESULT_WAIT_QUANTA_US	1000

> -	idev->channels = bu27008_channels;
> -	idev->num_channels = ARRAY_SIZE(bu27008_channels);
> -	idev->name = "bu27008";
> +	idev->channels = /* data->cd->cspec; */ &bu27008_channels[0];
?   Seems you didn't put the channels cd

> +	idev->num_channels = /* data->cd->num_channels; */ ARRAY_SIZE(bu27008_channels);
?


> +	idev->name = data->cd->name;
>  	idev->info = &bu27008_info;
>  	idev->modes = INDIO_DIRECT_MODE;
>  	idev->available_scan_masks = bu27008_scan_masks;
>  
> -	ret = bu27008_chip_init(data);
> +	ret = data->cd->chip_init(data);
>  	if (ret)
>  		return ret;
>  
> @@ -1021,7 +1112,7 @@ static int bu27008_probe(struct i2c_client *i2c)
>  }
>  
>  static const struct of_device_id bu27008_of_match[] = {
> -	{ .compatible = "rohm,bu27008" },
> +	{ .compatible = "rohm,bu27008", .data = &bu27008_chip },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(of, bu27008_of_match);

