Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B19770A908
	for <lists+linux-kernel@lfdr.de>; Sat, 20 May 2023 18:14:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231878AbjETQOy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 May 2023 12:14:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232025AbjETQOv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 May 2023 12:14:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E402121;
        Sat, 20 May 2023 09:14:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0BE1E61B59;
        Sat, 20 May 2023 16:14:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3F7CC433D2;
        Sat, 20 May 2023 16:14:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684599288;
        bh=6mwKiCUfa2rgYBc0Ypw84q7V/wE3MHOpufBrbmnvfVQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=BDepCgo1WriJFKCe5dEs1+d5YVSeOiKF1aBmAIMPJtkl/714NG4s1PCJ/goCrDk9k
         WZHZR0wj5M6DjFxGNXEcPGMOh+GGjGALHvtYH8nfpnTTMN5J3yrN9gRIA5aSlB5sy/
         +bn4u+O8x1XfvHnfUdk6ZIGIkGaWBgux2XOnCARqpwL7PMEvRhyJZtkvBASN0WxiDL
         z1Zrn8u0akH7rqz50tAMsAq6UnVrWjYvi37A3YMPhVwbkqKJ5V49KdLP2w1oijQTrw
         vklFQ662aZ7V7ZMKyYrGzNdmeMO3AdPmt8cQ2U8DQUPNXaMnVNwnSYD3aouCSIfxk5
         D50p2hBJqIKpw==
Date:   Sat, 20 May 2023 17:30:57 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Herve Codina <herve.codina@bootlin.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v4 2/3] iio: potentiometer: Add support for the Renesas
 X9250 potentiometers
Message-ID: <20230520173057.372355e8@jic23-huawei>
In-Reply-To: <20230515084416.399f47c8@bootlin.com>
References: <20230509160852.158101-1-herve.codina@bootlin.com>
        <20230509160852.158101-3-herve.codina@bootlin.com>
        <20230513193525.43a4475f@jic23-huawei>
        <20230514163233.0c048256@bootlin.com>
        <20230514181912.314ef781@jic23-huawei>
        <20230515084416.399f47c8@bootlin.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 May 2023 08:44:16 +0200
Herve Codina <herve.codina@bootlin.com> wrote:

> On Sun, 14 May 2023 18:19:12 +0100
> Jonathan Cameron <jic23@kernel.org> wrote:
>=20
> > On Sun, 14 May 2023 16:32:33 +0200
> > Herve Codina <herve.codina@bootlin.com> wrote:
> >  =20
> > > Hi Jonathan,
> > >=20
> > > On Sat, 13 May 2023 19:35:25 +0100
> > > Jonathan Cameron <jic23@kernel.org> wrote:
> > >    =20
> > > > On Tue,  9 May 2023 18:08:51 +0200
> > > > Herve Codina <herve.codina@bootlin.com> wrote:
> > > >      =20
> > > > > The Renesas X9250 integrates four digitally controlled potentiome=
ters.
> > > > > On each potentiometer, the X9250T has a 100 kOhms total resistanc=
e and
> > > > > the X9250U has a 50 kOhms total resistance.
> > > > >=20
> > > > > Signed-off-by: Herve Codina <herve.codina@bootlin.com>       =20
> > > >=20
> > > > As I only noticed one trivial thing I made the change whilst applyi=
ng.
> > > > diff --git a/drivers/iio/potentiometer/x9250.c b/drivers/iio/potent=
iometer/x9250.c
> > > > index 3d4ca18d1f14..7e145d7d14f1 100644
> > > > --- a/drivers/iio/potentiometer/x9250.c
> > > > +++ b/drivers/iio/potentiometer/x9250.c
> > > > @@ -176,10 +176,7 @@ static int x9250_probe(struct spi_device *spi)
> > > > =20
> > > >         x9250 =3D iio_priv(indio_dev);
> > > >         x9250->spi =3D spi;
> > > > -       x9250->cfg =3D device_get_match_data(&spi->dev);
> > > > -       if (!x9250->cfg)
> > > > -               x9250->cfg =3D &x9250_cfg[spi_get_device_id(spi)->d=
river_data];
> > > > -
> > > > +       x9250->cfg =3D spi_get_device_match_data(spi);
> > > >         x9250->wp_gpio =3D devm_gpiod_get_optional(&spi->dev, "wp",=
 GPIOD_OUT_LOW);
> > > >         if (IS_ERR(x9250->wp_gpio))
> > > >                 return dev_err_probe(&spi->dev, PTR_ERR(x9250->wp_g=
pio),
> > > >      =20
> > >=20
> > > Are you sure about your modification ?
> > >=20
> > > I am not sure (maybe I am wrong) that
> > >   x9250->cfg =3D spi_get_device_match_data(spi);
> > > is equivalent to
> > >   x9250->cfg =3D &x9250_cfg[spi_get_device_id(spi)->driver_data];
> > >=20
> > > The spi_get_device_id(spi)->driver_data value I used is a simple inte=
ger
> > > (X9250T or X9250U) and not the x9250_cfg item.
> > > Maybe the x9250_id_table should be modified to replace X9250T by
> > > &x9250_cfg[X9250T] to have your modification working.   =20
> >=20
> > Excellent point.  I'm was  clearly half asleep. The mod should have inc=
luded
> > switching them over to be pointers.
> >  =20
> > >=20
> > > The data defined in the driver are the following:
> > > --- 8< ---
> > > static const struct x9250_cfg x9250_cfg[] =3D {
> > > 	[X9250T] =3D { .name =3D "x9250t", .kohms =3D  100, },
> > > 	[X9250U] =3D { .name =3D "x9250u", .kohms =3D  50, },
> > > };
> > >=20
> > > ...
> > >=20
> > > static const struct of_device_id x9250_of_match[] =3D {
> > > 	{ .compatible =3D "renesas,x9250t", &x9250_cfg[X9250T]},
> > > 	{ .compatible =3D "renesas,x9250u", &x9250_cfg[X9250U]},
> > > 	{ }
> > > };
> > > MODULE_DEVICE_TABLE(of, x9250_of_match);
> > >=20
> > > static const struct spi_device_id x9250_id_table[] =3D {
> > > 	{ "x9250t", X9250T },
> > > 	{ "x9250u", X9250U },   =20
> > So these should be (kernel_ulong_t)&x9250_cfg[X9250T] etc for the data.
> > I've tweaked it so that is now the case. Oops and thanks for sanity che=
cking.
> > Sometimes we see what we expect to see rather than what is there.
> >=20
> > Tweak on top of original tweak is:
> > diff --git a/drivers/iio/potentiometer/x9250.c b/drivers/iio/potentiome=
ter/x9250.c
> > index 7e145d7d14f1..0cc7f72529be 100644
> > --- a/drivers/iio/potentiometer/x9250.c
> > +++ b/drivers/iio/potentiometer/x9250.c
> > @@ -198,8 +198,8 @@ static const struct of_device_id x9250_of_match[] =
=3D {
> >  MODULE_DEVICE_TABLE(of, x9250_of_match);
> > =20
> >  static const struct spi_device_id x9250_id_table[] =3D {
> > -       { "x9250t", X9250T },
> > -       { "x9250u", X9250U },
> > +       { "x9250t", (kernel_ulong_t)&x9250_cfg[X9250T] },
> > +       { "x9250u", (kernel_ulong_t)&x9250_cfg[X9250U] },
> >         { }
> >  };
> >=20
> >  =20
>=20
> Pefect, thanks.
>=20
> Also can you add a last modification (my bad, I should see that before):
>=20
>  static const struct of_device_id x9250_of_match[] =3D {
> -       { .compatible =3D "renesas,x9250t", &x9250_cfg[X9250T]},
> -       { .compatible =3D "renesas,x9250u", &x9250_cfg[X9250U]},
> +       { .compatible =3D "renesas,x9250t", .data =3D &x9250_cfg[X9250T]},
> +       { .compatible =3D "renesas,x9250u", .data =3D &x9250_cfg[X9250U]},
>         { }
>  };
>=20
> I think adding '.data =3D ' would be better and avoid to have some quite =
tricky
> bug in case of struct of_device_id modification.
>=20
> Regards,
> Herv=C3=A9
Done

>=20
>=20
> > Jonathan
> >  =20
> > > 	{ }
> > > };
> > > MODULE_DEVICE_TABLE(spi, x9250_id_table);
> > >=20
> > > static struct spi_driver x9250_spi_driver =3D {
> > > 	.driver  =3D {
> > > 		.name =3D "x9250",
> > > 		.of_match_table =3D x9250_of_match,
> > > 	},
> > > 	.id_table =3D x9250_id_table,
> > > 	.probe  =3D x9250_probe,
> > > };
> > > --- 8< ---
> > >=20
> > >=20
> > > Best regards,
> > > Herv=C3=A9
> > >    =20
> >  =20

