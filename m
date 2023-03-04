Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E2A16AAB86
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Mar 2023 18:15:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229596AbjCDRPu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Mar 2023 12:15:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjCDRPs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Mar 2023 12:15:48 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D6B1113E7;
        Sat,  4 Mar 2023 09:15:48 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A4C0B60018;
        Sat,  4 Mar 2023 17:15:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF55DC433D2;
        Sat,  4 Mar 2023 17:15:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677950147;
        bh=j/TApz3U33B9vesBBlPnTG3qx/jqs/qy1gdag8qdsuQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=POAMaCrCRJ3Y+iUq60qguxB6v93fFgmMxOoUxApLYS0uhj2y7BkOazQHQPUOfhV76
         kmJqaU749ERbghlMNmAnxPm1bd3O2K0ICZ0Zgq4uKDFhDrAon9WouZ+XBds1SoU/kw
         3DwOmrjzNBbGbVvehzC8WMRqfebA2G/NPaugxIZNrKrGYvupEbyGkwzA1inDkCZO0m
         0PMRCfLcPcxgnDVqNYUtku+K7iCMLkEOa8Fe2LeXFk40vYZisW3oDD+83Ef9XT+0mv
         uVMimzsfJu15FOnIPCX32SPm28ZEfzf1Pc3NVhHd/7xHRWhS2+K8DIRI0PSk42794T
         bBe7WC1IR+RWA==
Date:   Sat, 4 Mar 2023 17:15:42 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Cosmin Tanislav <cosmin.tanislav@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: addac: ad74413r: fix Current Input, Loop Powered
 Mode
Message-ID: <20230304171542.642d88e3@jic23-huawei>
In-Reply-To: <20230301115511.849418-1-linux@rasmusvillemoes.dk>
References: <20230301115511.849418-1-linux@rasmusvillemoes.dk>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed,  1 Mar 2023 12:55:11 +0100
Rasmus Villemoes <linux@rasmusvillemoes.dk> wrote:

> Currently, the driver handles CH_FUNC_CURRENT_INPUT_LOOP_POWER and
> CH_FUNC_CURRENT_INPUT_EXT_POWER completely identically. But that's not
> correct. In order for CH_FUNC_CURRENT_INPUT_LOOP_POWER to work, two
> changes must be made:
>=20
> (1) expose access to the DAC_CODE_x register so that the intended
> output current can be set, i.e. expose the channel as both current
> output and current input, and
>=20
> (2) per the data sheet
>=20
>   When selecting the current input loop powered function, tie the
>   VIOUTN_x pin to ground via the on-chip 200 k=CE=A9 resistor by enabling
>   the CH_200K_TO_GND bit in the ADC_CONFIGx registers.
>=20
> Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> ---
> There's of course also CH_FUNC_CURRENT_INPUT_LOOP_POWER_HART which is
> likely to require a similar fix, but as I don't have a ad74413r I
> can't test that.=20

Looks correct to me based on the "current input, loop powered" section
of the datasheet, but want to leave a little more time for someone
familiar with the part to comment.

Given me a poke if I seem to have lost this in 2 weeks.  (That happens
less now I track with patchwork, but you never know ;)

Thanks,

Jonathan

>=20
>  drivers/iio/addac/ad74413r.c | 21 +++++++++++++++++++--
>  1 file changed, 19 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/iio/addac/ad74413r.c b/drivers/iio/addac/ad74413r.c
> index f32c8c2fb26d..f5d072092709 100644
> --- a/drivers/iio/addac/ad74413r.c
> +++ b/drivers/iio/addac/ad74413r.c
> @@ -99,6 +99,7 @@ struct ad74413r_state {
>  #define AD74413R_REG_ADC_CONFIG_X(x)		(0x05 + (x))
>  #define AD74413R_ADC_CONFIG_RANGE_MASK		GENMASK(7, 5)
>  #define AD74413R_ADC_CONFIG_REJECTION_MASK	GENMASK(4, 3)
> +#define AD74413R_ADC_CONFIG_CH_200K_TO_GND	BIT(2)
>  #define AD74413R_ADC_RANGE_10V			0b000
>  #define AD74413R_ADC_RANGE_2P5V_EXT_POW		0b001
>  #define AD74413R_ADC_RANGE_2P5V_INT_POW		0b010
> @@ -424,9 +425,20 @@ static int ad74413r_set_channel_dac_code(struct ad74=
413r_state *st,
>  static int ad74413r_set_channel_function(struct ad74413r_state *st,
>  					 unsigned int channel, u8 func)
>  {
> -	return regmap_update_bits(st->regmap,
> +	int ret;
> +
> +	ret =3D regmap_update_bits(st->regmap,
>  				  AD74413R_REG_CH_FUNC_SETUP_X(channel),
>  				  AD74413R_CH_FUNC_SETUP_MASK, func);
> +	if (ret)
> +		return ret;
> +
> +	if (func =3D=3D CH_FUNC_CURRENT_INPUT_LOOP_POWER)
> +		ret =3D regmap_set_bits(st->regmap,
> +				      AD74413R_REG_ADC_CONFIG_X(channel),
> +				      AD74413R_ADC_CONFIG_CH_200K_TO_GND);
> +
> +	return ret;
>  }
> =20
>  static int ad74413r_set_adc_conv_seq(struct ad74413r_state *st,
> @@ -1112,6 +1124,11 @@ static struct iio_chan_spec ad74413r_current_input=
_channels[] =3D {
>  	AD74413R_ADC_CURRENT_CHANNEL,
>  };
> =20
> +static struct iio_chan_spec ad74413r_current_input_loop_channels[] =3D {
> +	AD74413R_DAC_CHANNEL(IIO_CURRENT, BIT(IIO_CHAN_INFO_SCALE)),
> +	AD74413R_ADC_CURRENT_CHANNEL,
> +};
> +
>  static struct iio_chan_spec ad74413r_resistance_input_channels[] =3D {
>  	AD74413R_ADC_CHANNEL(IIO_RESISTANCE, BIT(IIO_CHAN_INFO_PROCESSED)),
>  };
> @@ -1135,7 +1152,7 @@ static const struct ad74413r_channels ad74413r_chan=
nels_map[] =3D {
>  	[CH_FUNC_CURRENT_OUTPUT] =3D AD74413R_CHANNELS(current_output),
>  	[CH_FUNC_VOLTAGE_INPUT] =3D AD74413R_CHANNELS(voltage_input),
>  	[CH_FUNC_CURRENT_INPUT_EXT_POWER] =3D AD74413R_CHANNELS(current_input),
> -	[CH_FUNC_CURRENT_INPUT_LOOP_POWER] =3D AD74413R_CHANNELS(current_input),
> +	[CH_FUNC_CURRENT_INPUT_LOOP_POWER] =3D AD74413R_CHANNELS(current_input_=
loop),
>  	[CH_FUNC_RESISTANCE_INPUT] =3D AD74413R_CHANNELS(resistance_input),
>  	[CH_FUNC_DIGITAL_INPUT_LOGIC] =3D AD74413R_CHANNELS(digital_input),
>  	[CH_FUNC_DIGITAL_INPUT_LOOP_POWER] =3D AD74413R_CHANNELS(digital_input),

