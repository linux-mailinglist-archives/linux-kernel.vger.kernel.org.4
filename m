Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 288BE6B67AB
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Mar 2023 16:50:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229915AbjCLPu3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Mar 2023 11:50:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbjCLPu1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Mar 2023 11:50:27 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9562311D2;
        Sun, 12 Mar 2023 08:50:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 48143B80CB9;
        Sun, 12 Mar 2023 15:50:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7F28C433EF;
        Sun, 12 Mar 2023 15:50:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678636222;
        bh=r6zbn2PEjre8vb+/z8aYQaXJDHn0lYrd9Rmz92pUt6U=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=gYV8ZRYsUc5P43x9C7YPk2GrBBS6O5yB4ntf3VjndXUXqPf3vnG3xN8DN+8VLug4e
         zG9H1xM9PE+DuQhEbBXcKem11hDJWRGZOOwlOCmmyHp8IhYOq57ynZAQQ5lrPf7ltZ
         PPv/bjut05HI20nYSvJythCokTL0tUd6U1oeaziwlsLKgzM83X/a386TvMpKb0Ipq7
         oAsd5U7RFRJxTP6c8XiqeWzwq5HchlT0hswkaa6JcnJgQlaEb0eQ8vsEFKAO7QgTk8
         32+EQNHoER2SoVYS+kMlLoSqgUuF3FhyOPQQ0FIcFMk+7I5VZYwfJOTIhT9RZZtDq3
         rB8F+8E+5EvYg==
Date:   Sun, 12 Mar 2023 15:50:28 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Cosmin Tanislav <cosmin.tanislav@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: addac: ad74413r: fix Current Input, Loop Powered
 Mode
Message-ID: <20230312155028.40a1c122@jic23-huawei>
In-Reply-To: <20230304171542.642d88e3@jic23-huawei>
References: <20230301115511.849418-1-linux@rasmusvillemoes.dk>
        <20230304171542.642d88e3@jic23-huawei>
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

On Sat, 4 Mar 2023 17:15:42 +0000
Jonathan Cameron <jic23@kernel.org> wrote:

> On Wed,  1 Mar 2023 12:55:11 +0100
> Rasmus Villemoes <linux@rasmusvillemoes.dk> wrote:
>=20
> > Currently, the driver handles CH_FUNC_CURRENT_INPUT_LOOP_POWER and
> > CH_FUNC_CURRENT_INPUT_EXT_POWER completely identically. But that's not
> > correct. In order for CH_FUNC_CURRENT_INPUT_LOOP_POWER to work, two
> > changes must be made:
> >=20
> > (1) expose access to the DAC_CODE_x register so that the intended
> > output current can be set, i.e. expose the channel as both current
> > output and current input, and
> >=20
> > (2) per the data sheet
> >=20
> >   When selecting the current input loop powered function, tie the
> >   VIOUTN_x pin to ground via the on-chip 200 k=CE=A9 resistor by enabli=
ng
> >   the CH_200K_TO_GND bit in the ADC_CONFIGx registers.
> >=20
> > Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> > ---
> > There's of course also CH_FUNC_CURRENT_INPUT_LOOP_POWER_HART which is
> > likely to require a similar fix, but as I don't have a ad74413r I
> > can't test that.  =20
>=20
> Looks correct to me based on the "current input, loop powered" section
> of the datasheet, but want to leave a little more time for someone
> familiar with the part to comment.
>=20
> Given me a poke if I seem to have lost this in 2 weeks.  (That happens
> less now I track with patchwork, but you never know ;)
>=20
> Thanks,
>=20
> Jonathan
Applied, Thanks

Jonathan

>=20
> >=20
> >  drivers/iio/addac/ad74413r.c | 21 +++++++++++++++++++--
> >  1 file changed, 19 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/drivers/iio/addac/ad74413r.c b/drivers/iio/addac/ad74413r.c
> > index f32c8c2fb26d..f5d072092709 100644
> > --- a/drivers/iio/addac/ad74413r.c
> > +++ b/drivers/iio/addac/ad74413r.c
> > @@ -99,6 +99,7 @@ struct ad74413r_state {
> >  #define AD74413R_REG_ADC_CONFIG_X(x)		(0x05 + (x))
> >  #define AD74413R_ADC_CONFIG_RANGE_MASK		GENMASK(7, 5)
> >  #define AD74413R_ADC_CONFIG_REJECTION_MASK	GENMASK(4, 3)
> > +#define AD74413R_ADC_CONFIG_CH_200K_TO_GND	BIT(2)
> >  #define AD74413R_ADC_RANGE_10V			0b000
> >  #define AD74413R_ADC_RANGE_2P5V_EXT_POW		0b001
> >  #define AD74413R_ADC_RANGE_2P5V_INT_POW		0b010
> > @@ -424,9 +425,20 @@ static int ad74413r_set_channel_dac_code(struct ad=
74413r_state *st,
> >  static int ad74413r_set_channel_function(struct ad74413r_state *st,
> >  					 unsigned int channel, u8 func)
> >  {
> > -	return regmap_update_bits(st->regmap,
> > +	int ret;
> > +
> > +	ret =3D regmap_update_bits(st->regmap,
> >  				  AD74413R_REG_CH_FUNC_SETUP_X(channel),
> >  				  AD74413R_CH_FUNC_SETUP_MASK, func);
> > +	if (ret)
> > +		return ret;
> > +
> > +	if (func =3D=3D CH_FUNC_CURRENT_INPUT_LOOP_POWER)
> > +		ret =3D regmap_set_bits(st->regmap,
> > +				      AD74413R_REG_ADC_CONFIG_X(channel),
> > +				      AD74413R_ADC_CONFIG_CH_200K_TO_GND);
> > +
> > +	return ret;
> >  }
> > =20
> >  static int ad74413r_set_adc_conv_seq(struct ad74413r_state *st,
> > @@ -1112,6 +1124,11 @@ static struct iio_chan_spec ad74413r_current_inp=
ut_channels[] =3D {
> >  	AD74413R_ADC_CURRENT_CHANNEL,
> >  };
> > =20
> > +static struct iio_chan_spec ad74413r_current_input_loop_channels[] =3D=
 {
> > +	AD74413R_DAC_CHANNEL(IIO_CURRENT, BIT(IIO_CHAN_INFO_SCALE)),
> > +	AD74413R_ADC_CURRENT_CHANNEL,
> > +};
> > +
> >  static struct iio_chan_spec ad74413r_resistance_input_channels[] =3D {
> >  	AD74413R_ADC_CHANNEL(IIO_RESISTANCE, BIT(IIO_CHAN_INFO_PROCESSED)),
> >  };
> > @@ -1135,7 +1152,7 @@ static const struct ad74413r_channels ad74413r_ch=
annels_map[] =3D {
> >  	[CH_FUNC_CURRENT_OUTPUT] =3D AD74413R_CHANNELS(current_output),
> >  	[CH_FUNC_VOLTAGE_INPUT] =3D AD74413R_CHANNELS(voltage_input),
> >  	[CH_FUNC_CURRENT_INPUT_EXT_POWER] =3D AD74413R_CHANNELS(current_input=
),
> > -	[CH_FUNC_CURRENT_INPUT_LOOP_POWER] =3D AD74413R_CHANNELS(current_inpu=
t),
> > +	[CH_FUNC_CURRENT_INPUT_LOOP_POWER] =3D AD74413R_CHANNELS(current_inpu=
t_loop),
> >  	[CH_FUNC_RESISTANCE_INPUT] =3D AD74413R_CHANNELS(resistance_input),
> >  	[CH_FUNC_DIGITAL_INPUT_LOGIC] =3D AD74413R_CHANNELS(digital_input),
> >  	[CH_FUNC_DIGITAL_INPUT_LOOP_POWER] =3D AD74413R_CHANNELS(digital_inpu=
t), =20
>=20

