Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D591D6951C1
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 21:22:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231177AbjBMUWw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 15:22:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230267AbjBMUWu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 15:22:50 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A92F410C2;
        Mon, 13 Feb 2023 12:22:48 -0800 (PST)
Received: from mercury (unknown [185.209.196.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 884D26602154;
        Mon, 13 Feb 2023 20:22:46 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1676319766;
        bh=1TObA8dqXQ2thCA8DbnCx9SQXVRva5RI5dmI1MX6Nqk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=C8//q4KgudNFloPH8JX/tYaHDYFPFIUY2GBGaULdc7GgHSfq6oreC1+IRlLjh8/bP
         i1AEKizsmKQ1b6/q4Gve4lilaNKGuEG6OAzevnXLzcd1+/aQ7yNbhj/E55M564YyfJ
         TTnT93zCyqKegRYV0m5Tyx2mJSwKB7JU9AecJsCtsVDqIbaVERHNyOlEyzTzXMlDb5
         sXRbCXFIaj0I2P7QMWKmtONd2i8T/wlj9ZxHwoBb6r3Yugaf5GBmw6O4apJOo6kJdR
         xboXIvhYdWZTqg/Y+93OEz0kwOGU4KXhY7/gLf3mluXbktQXg7gleZR2fskYIPh5Tk
         G3RlGszvmOhbw==
Received: by mercury (Postfix, from userid 1000)
        id 076DB1060961; Mon, 13 Feb 2023 21:22:44 +0100 (CET)
Date:   Mon, 13 Feb 2023 21:22:43 +0100
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [PATCH] power: supply: max77650: Make max77650_charger_disable()
 return void
Message-ID: <20230213202243.pvixph4v2i7nypsv@mercury.elektranox.org>
References: <20230210212528.179627-1-u.kleine-koenig@pengutronix.de>
 <CAMRc=Md-997mohAyUGGrf28zvTX1voKO24DWgfCjCLDKsRYu+A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="fcva4ibhy5rewgna"
Content-Disposition: inline
In-Reply-To: <CAMRc=Md-997mohAyUGGrf28zvTX1voKO24DWgfCjCLDKsRYu+A@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--fcva4ibhy5rewgna
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Feb 13, 2023 at 02:53:07PM +0100, Bartosz Golaszewski wrote:
> On Fri, Feb 10, 2023 at 10:25 PM Uwe Kleine-K=F6nig
> <u.kleine-koenig@pengutronix.de> wrote:
> >
> > The return value of max77650_charger_disable() is ignored by all but one
> > caller. That one caller propagates the error code in the platform drive=
r's
> > remove function. The only effect of that is that the driver core emits
> > a generic error message (but still removes the device). As
> > max77650_charger_disable() already emits an error message, this can bet=
ter
> > be changed to return zero.
> >
> > This is a preparation for making struct platform_driver::remove return
> > void, too.
> >
> > Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> > ---
> >  drivers/power/supply/max77650-charger.c | 8 ++++----
> >  1 file changed, 4 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/power/supply/max77650-charger.c b/drivers/power/su=
pply/max77650-charger.c
> > index d913428bedc0..e8c25da40ab2 100644
> > --- a/drivers/power/supply/max77650-charger.c
> > +++ b/drivers/power/supply/max77650-charger.c
> > @@ -141,7 +141,7 @@ static int max77650_charger_enable(struct max77650_=
charger_data *chg)
> >         return rv;
> >  }
> >
> > -static int max77650_charger_disable(struct max77650_charger_data *chg)
> > +static void max77650_charger_disable(struct max77650_charger_data *chg)
> >  {
> >         int rv;
> >
> > @@ -151,8 +151,6 @@ static int max77650_charger_disable(struct max77650=
_charger_data *chg)
> >                                 MAX77650_CHARGER_DISABLED);
> >         if (rv)
> >                 dev_err(chg->dev, "unable to disable the charger: %d\n"=
, rv);
> > -
> > -       return rv;
> >  }
> >
> >  static irqreturn_t max77650_charger_check_status(int irq, void *data)
> > @@ -351,7 +349,9 @@ static int max77650_charger_remove(struct platform_=
device *pdev)
> >  {
> >         struct max77650_charger_data *chg =3D platform_get_drvdata(pdev=
);
> >
> > -       return max77650_charger_disable(chg);
> > +       max77650_charger_disable(chg);
> > +
> > +       return 0;
> >  }
> >
> >  static const struct of_device_id max77650_charger_of_match[] =3D {
> >
> > base-commit: 4f72a263e162938de26866b862ed6015f5725946
> > --
> > 2.39.0
> >
>=20
> Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Thanks, queued.

-- Sebastian

--fcva4ibhy5rewgna
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmPqnBAACgkQ2O7X88g7
+pq4cg//Rj0BlOAjxVkZApm61YnWxGpBnUfaKpI+kjRE3qj2h4vNsP1ZUdc7sg96
AhD6j39blniYlBC0l2UzNHgReBwKqUn+NVvCE74oqPRC6TpzuAe5TmJURvzx0ucZ
4wxjZ0/OzqDm9ajRdw1LLvVtHdphkWUp/rpZ1afEMxBqwAeFIkt/EYujZokSg/fw
ZBIiQWKB9H3cBdNz7xTsQXtZmJY1auWmUnfB+ZB+JPmjGzwpJq4tjxkMGtriWSmf
tnw54w16Drrnbcz+IpElbB2flq+isQQgt6j8eNY0LrJgrwOpGenNnihzHdpP8WMQ
rYR2QEcUrw0ce1IIOUQYewEe6UeYaLSXg9926KEZ5rNn4pSawBKMKLgZ0iubRvgF
NLauMVR/j7/SPMPtaJuJfdZZuj+Cxlhh+krxA5pJ83eSyeLJkEPMWvGf8/mU61xB
sT7HM+et1pMxI36wXXoqLBaEF2dm6UkW8UJ1OQbIb1GJZayLAkDxsKqyXgItlf+H
AgQnrRuCOeZYaYTTxGUBhToP6wBRoqijXKNQVGkZ0SrsSa8Py1ILeg8Vg5WAnZKE
iw/IA4Y9mxdNAfhF1ABS18k/jBcdcb7OtfHVdSsf0IT4xq6bCegst5EtvHCpStal
hxaLhoYbn4tKmnpGFMJD9IpiklgEcrPxRkivnZXq/zDQnd+VyOc=
=TLCJ
-----END PGP SIGNATURE-----

--fcva4ibhy5rewgna--
