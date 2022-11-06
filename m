Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2538061E51A
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Nov 2022 18:51:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229984AbiKFRvw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Nov 2022 12:51:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229947AbiKFRvu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Nov 2022 12:51:50 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 370F0244;
        Sun,  6 Nov 2022 09:51:49 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CF97E60C55;
        Sun,  6 Nov 2022 17:51:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B18C0C433C1;
        Sun,  6 Nov 2022 17:51:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667757108;
        bh=ngeGRJrDFN8bc4IHbWSf91d8o8lEG+vzXG7Fqs3t3+I=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=QsrMwSsgNC55WS0Tws2Tsu0REVWXZdLPB0YyF2UGjvPQDJzlXojp1xlExKdQFwiJN
         yf6alM2EUtFO+u51c3GIhXuzzfpV8i9kjI/BDRmXwWlwpRAJvvObm1GTeEMA+Hv7O3
         4Lok/Zyr2d3zFUoqLVLUpT5G+izh8Jm6YzsJ3oxYFqO8sPLU+59/fI7WK6aKQ8TSEu
         OZiHIrUKuvLIhaF12mU/572i8vroZJYmMpsbUzeRcvnEOzWVvIasXJbiqpBNsSdUQ4
         HFPIiK3AP732HDqzyrWH5H1nCUZg4cle/xekfuBDnrm0sWT6ZQ1VHzyjiHKS37q2X0
         hpxP4nDKsuM/g==
Date:   Sun, 6 Nov 2022 17:51:39 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Nuno =?UTF-8?B?U8Oh?= <noname.nuno@gmail.com>
Cc:     Antoniu Miclaus <antoniu.miclaus@analog.com>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] iio: frequency: adf4377: add support for ADF4377
Message-ID: <20221106175139.093edcd9@jic23-huawei>
In-Reply-To: <3417a0fd87e6f13207690e49b797f2d2689f802a.camel@gmail.com>
References: <20221104092802.90725-1-antoniu.miclaus@analog.com>
        <20221104092802.90725-3-antoniu.miclaus@analog.com>
        <3417a0fd87e6f13207690e49b797f2d2689f802a.camel@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.34; x86_64-pc-linux-gnu)
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

On Fri, 04 Nov 2022 12:38:07 +0100
Nuno S=C3=A1 <noname.nuno@gmail.com> wrote:

> On Fri, 2022-11-04 at 11:28 +0200, Antoniu Miclaus wrote:
> > The ADF4377 is a high performance, ultralow jitter, dual output
> > integer-N
> > phased locked loop (PLL) with integrated voltage controlled
> > oscillator
> > (VCO) ideally suited for data converter and mixed signal front end
> > (MxFE)
> > clock applications.
> >=20
> > Datasheet:
> > https://www.analog.com/media/en/technical-documentation/data-sheets/adf=
4377.pdf
> > Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>

Nuno, please crop to the bit you comment on.  Doom scrolling isn't fun ;)

A few follow up comments inline.

Jonathan

> > ---
> > =C2=A0drivers/iio/frequency/Kconfig=C2=A0=C2=A0 |=C2=A0=C2=A0 10 +
> > =C2=A0drivers/iio/frequency/Makefile=C2=A0 |=C2=A0=C2=A0=C2=A0 1 +
> > =C2=A0drivers/iio/frequency/adf4377.c | 1154

...
> > +static ssize_t adf4377_read(struct iio_dev *indio_dev, uintptr_t
> > private,
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 const struct iio_chan_spec *chan, char
> > *buf)
> > +{
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct adf4377_state *st =3D=
 iio_priv(indio_dev);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0u64 val =3D 0;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0int ret;
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0switch ((u32)private) {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0case ADF4377_FREQ:
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0ret =3D adf4377_get_freq(st, &val);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0break;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0default:
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0ret =3D -EINVAL;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0val =3D 0;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0break;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return ret ?: sysfs_emit(buf=
, "%llu\n", val); =20
>=20
> I would also return in place. I've come to prefer it but that's me :)

Definitely if alternative is a ternary!


> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return ret ? : FIELD_GET(ADF=
4377_MUXOUT_MSK, mode);
> > +}
> > +
> > +static const struct iio_enum adf4377_muxout_enum =3D {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0.items =3D adf4377_muxout_mo=
des,
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0.num_items =3D ARRAY_SIZE(ad=
f4377_muxout_modes),
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0.get =3D adf4377_get_muxout_=
mode,
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0.set =3D adf4377_set_muxout_=
mode,
> > +};
> > +
> > +#define _ADF4377_EXT_INFO(_name, _shared, _ident) { \
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0.name =3D _name, \
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0.read =3D adf4377_read, \
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0.write =3D adf4377_write, \
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0.private =3D _ident, \
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0.shared =3D _shared, \
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
> > +
> > +static const struct iio_chan_spec_ext_info adf4377_ext_info[] =3D {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/*
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * Usually we use IIO_CHAN_I=
NFO_FREQUENCY, but there are
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * values > 2^32 in order to=
 support the entire frequency
> > range
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * in Hz.
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0_ADF4377_EXT_INFO("frequency=
", IIO_SHARED_BY_ALL,
> > ADF4377_FREQ), =20
>=20
> Can't we have u64 already in IIO_CHAN_INFO_FREQUENCY? I know the write
> side is a bit awkward but I think we can make it better.

hmm. I think we only have s64. If 63 bits is enough then we are good to go =
:)

(in the annals of bad design decisions, thinking years ago that no one would
 go beyond 32 bits... oops).

> =20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0IIO_ENUM("muxout_select", II=
O_SHARED_BY_ALL,
> > &adf4377_muxout_enum),
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0IIO_ENUM_AVAILABLE("muxout_s=
elect", IIO_SHARED_BY_ALL,
> > &adf4377_muxout_enum),
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0{ },
> > +};
> > +

...

> > +
> > +static int adf4377_probe(struct spi_device *spi)
> > +{
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct iio_dev *indio_dev;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct regmap *regmap;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct adf4377_state *st;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0int ret;
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0indio_dev =3D devm_iio_devic=
e_alloc(&spi->dev, sizeof(*st));
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (!indio_dev)
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0return -ENOMEM;
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0regmap =3D devm_regmap_init_=
spi(spi, &adf4377_regmap_config);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (IS_ERR(regmap))
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0return PTR_ERR(regmap);
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0st =3D iio_priv(indio_dev);
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0indio_dev->info =3D &adf4377=
_info;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0indio_dev->name =3D "adf4377=
";
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0indio_dev->channels =3D adf4=
377_channels;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0indio_dev->num_channels =3D =
ARRAY_SIZE(adf4377_channels);
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0st->regmap =3D regmap;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0st->spi =3D spi;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0st->type =3D spi_get_device_=
id(spi)->driver_data; =20
>=20
> Hmm this is something that came up internally the other day. Are we
> guaranteed that this will always work? For OF I think it is but I'm not
> sure about ACPI? At first glance, it seems that it might be ok but I
> did not went too deep in the ACPI code.

Better indeed to not assume it and indeed ACPI can't do this magic, because
there isn't a match between the actual ACPI ID and the spi_device_ids.
Not sure what it does with PRP0001 case (where it uses the of_device_id tab=
le).


	st->type =3D device_get_match_id()->driver_data;
	if (!st->type) {
		const struct spi_device_id *id =3D spi_get_device_id(spi);

		if (!id)
			return -EINVAL;

		st->type =3D spi_get_device_id(spi)->driver_data;
	}
would be my preferred pattern. Andy had a suggestion to roll this
up in a standard function, but not gone anywhere yet.

>=20

Jonathan


