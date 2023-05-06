Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40F556F931C
	for <lists+linux-kernel@lfdr.de>; Sat,  6 May 2023 18:31:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229658AbjEFQbB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 May 2023 12:31:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjEFQbA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 May 2023 12:31:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74E7616091;
        Sat,  6 May 2023 09:30:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0C27A60CFB;
        Sat,  6 May 2023 16:30:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3DA3C433D2;
        Sat,  6 May 2023 16:30:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683390658;
        bh=0boAHKV9f8V2cRpIz+JEHdVMwVef54ODhw8WXZCFHik=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=TWWNrwEZtLK/mzdgUrH8UCwL9j5MxvVNsyasUDDvKSEi3FoWY658tmkZ8BCEvvH13
         nlsKssETppd8BwEuuNW7UCUPAyyZcTqHeq2sGxHvhInoONxdgYCC0Y6SV7M9ndpGUS
         IDdwRUGzgjFypSYuux9FZZHunLGQMeoTDEcXTPi/t9/tyEo0k6YA5Iw7VLsod3BArN
         WLHYDvlwcoTPukTqKNWIlhBux2CecheUiq44MB4LNRJzJkURAdxMcRkahcokwZ6W/1
         /RgTW9G3bNyS3Ldg8RaO6iFY6N/cSvvR6QSL6xA9sxZYT9AEbAF4YPK16OdA9M+8Fh
         9y8+nnfrlX7Xg==
Date:   Sat, 6 May 2023 17:46:51 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Mehdi Djait <mehdi.djait.k@gmail.com>
Cc:     mazziesaccount@gmail.com, krzysztof.kozlowski+dt@linaro.org,
        andriy.shevchenko@linux.intel.com, robh+dt@kernel.org,
        lars@metafoo.de, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v3 7/7] iio: accel: Add support for Kionix/ROHM
 KX132-1211 accelerometer
Message-ID: <20230506174651.5c5740d9@jic23-huawei>
In-Reply-To: <ZFVG1cyY/Ge/nXOh@carbian>
References: <cover.1682373451.git.mehdi.djait.k@gmail.com>
        <593798a44c8ba45f969b86aa29e172d59065958c.1682373451.git.mehdi.djait.k@gmail.com>
        <20230501155645.435242f0@jic23-huawei>
        <ZFVG1cyY/Ge/nXOh@carbian>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 5 May 2023 20:11:33 +0200
Mehdi Djait <mehdi.djait.k@gmail.com> wrote:

> Hello Jonathan,
>=20
> On Mon, May 01, 2023 at 03:56:45PM +0100, Jonathan Cameron wrote:
> > On Tue, 25 Apr 2023 00:22:27 +0200
> > Mehdi Djait <mehdi.djait.k@gmail.com> wrote:
> >  =20
> > > Kionix KX132-1211 is a tri-axis 16-bit accelerometer that can support
> > > ranges from =C2=B12G to =C2=B116G, digital output through I=C2=B2C/SP=
I.
> > > Add support for basic accelerometer features such as reading accelera=
tion
> > > via IIO using raw reads, triggered buffer (data-ready), or the WMI IR=
Q.
> > >=20
> > > Datasheet: https://kionixfs.azureedge.net/en/document/KX132-1211-Tech=
nical-Reference-Manual-Rev-5.0.pdf
> > > Signed-off-by: Mehdi Djait <mehdi.djait.k@gmail.com> =20
> >=20
> > Two tiny things inline. =20
> >  =20
> > > +static int kx132_get_fifo_bytes(struct kx022a_data *data)
> > > +{
> > > +	struct device *dev =3D regmap_get_device(data->regmap);
> > > +	__le16 buf_status;
> > > +	int ret, fifo_bytes;
> > > +
> > > +	ret =3D regmap_bulk_read(data->regmap, data->chip_info->buf_status1,
> > > +			       &buf_status, sizeof(buf_status));
> > > +	if (ret) {
> > > +		dev_err(dev, "Error reading buffer status\n");
> > > +		return ret;
> > > +	}
> > > +
> > > +	fifo_bytes =3D le16_to_cpu(buf_status);
> > > +	fifo_bytes &=3D data->chip_info->buf_smp_lvl_mask; =20
> >=20
> > Slight preference for FIELD_GET() as it saves me checking the mask incl=
udes
> > lowest bits. =20
>=20
> This will mean I have the remove the chip_info member buf_smp_lvl_mask
> and use KX132_MASK_BUF_SMP_LVL directly because otherwise the
> __builtin_constant_p function will cause an error when building.=20
> Check: https://elixir.bootlin.com/linux/latest/source/include/linux/bitfi=
eld.h#L65
>=20
> I can change it to FIELD_GET() if you want to.

Good point.  You could use le16_get_bits() though which I'm fairly sure wil=
l take
a variable just fine.

>=20
> >=20
> >  =20
> > > +
> > > +	return fifo_bytes;
> > > +}
> > > +
> > >  static int __kx022a_fifo_flush(struct iio_dev *idev, unsigned int sa=
mples,
> > >  			       bool irq)
> > >  {
> > > @@ -1036,6 +1157,32 @@ const struct kx022a_chip_info kx022a_chip_info=
 =3D {
> > >  };
> > >  EXPORT_SYMBOL_NS_GPL(kx022a_chip_info, IIO_KX022A);
> > > =20
> > > +const struct kx022a_chip_info kx132_chip_info =3D {
> > > +	.name		  =3D "kx132-1211",
> > > +	.regmap_config	  =3D &kx132_regmap_config,
> > > +	.channels	  =3D kx132_channels,
> > > +	.num_channels	  =3D ARRAY_SIZE(kx132_channels),
> > > +	.fifo_length	  =3D KX132_FIFO_LENGTH,
> > > +	.who		  =3D KX132_REG_WHO,
> > > +	.id		  =3D KX132_ID,
> > > +	.cntl		  =3D KX132_REG_CNTL,
> > > +	.cntl2		  =3D KX132_REG_CNTL2,
> > > +	.odcntl		  =3D KX132_REG_ODCNTL,
> > > +	.buf_cntl1	  =3D KX132_REG_BUF_CNTL1,
> > > +	.buf_cntl2	  =3D KX132_REG_BUF_CNTL2,
> > > +	.buf_clear	  =3D KX132_REG_BUF_CLEAR,
> > > +	.buf_status1	  =3D KX132_REG_BUF_STATUS_1,
> > > +	.buf_smp_lvl_mask =3D KX132_MASK_BUF_SMP_LVL, =20
> >=20
> > There are some things in here (typically where the define isn't used
> > anywhere else) where I think it would be easier to follow if the
> > value was listed here.  Masks and IDs for example.=20
> >  =20
>=20
> After removing buf_smp_lvl_mask, which members will be easier to understa=
nd (besides id) ?=20

I haven't gone through them.  Length seems an obvious one.  It's a number n=
ot a magic value.
Register addresses might also be simpler if they aren't used elsewhere.

Not really about understanding just about a define that adds nothing if all=
 we do is
assign it to a variable of the same name.

>=20
> --
> Kind Regards
> Mehdi Djait

