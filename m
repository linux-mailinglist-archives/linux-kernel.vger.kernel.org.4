Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5C686D98A0
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 15:54:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229982AbjDFNyK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 09:54:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbjDFNyI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 09:54:08 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0696C7AAC
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 06:54:07 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1pkQ3s-0002xV-Ik; Thu, 06 Apr 2023 15:54:00 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pkQ3r-009Oe4-CN; Thu, 06 Apr 2023 15:53:59 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pkQ3q-00B44I-5w; Thu, 06 Apr 2023 15:53:58 +0200
Date:   Thu, 6 Apr 2023 15:53:58 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Lorenz Brun <lorenz@brun.one>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v2] pwm: mediatek: support inverted polarity
Message-ID: <20230406135358.x3et6gvvxqsknfn6@pengutronix.de>
References: <20230309010410.2106525-1-lorenz@brun.one>
 <ZC7LaC19YjNwTIi1@orome>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="rhxflvtrefdf7zep"
Content-Disposition: inline
In-Reply-To: <ZC7LaC19YjNwTIi1@orome>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-2.3 required=5.0 tests=RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--rhxflvtrefdf7zep
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Thierry,

On Thu, Apr 06, 2023 at 03:38:48PM +0200, Thierry Reding wrote:
> On Thu, Mar 09, 2023 at 02:04:10AM +0100, Lorenz Brun wrote:
> > +	 * appear to have the capability to invert the output.
> > +	 * This means that inverted mode can not be fully supported as the
> > +	 * waveform will always start with the low period and end with the hi=
gh
> > +	 * period. Thus reject non-normal polarity if the shape of the wavefo=
rm
> > +	 * matters, i.e. usage_power is not set.
> > +	 */
> > +	if (state->polarity !=3D PWM_POLARITY_NORMAL && !state->usage_power)
> >  		return -EINVAL;
> > =20
> >  	if (!state->enabled) {
> > @@ -213,7 +221,11 @@ static int pwm_mediatek_apply(struct pwm_chip *chi=
p, struct pwm_device *pwm,
> >  		return 0;
> >  	}
> > =20
> > -	err =3D pwm_mediatek_config(pwm->chip, pwm, state->duty_cycle, state-=
>period);
> > +	duty_cycle =3D state->duty_cycle;
> > +	if (state->polarity =3D=3D PWM_POLARITY_INVERSED)
> > +		duty_cycle =3D state->period - state->duty_cycle;
>=20
> That's not really what state->usage_power was meant to address.

I don't understand your concern here. I don't like .usage_power, but
AFAICT this is a legitimite use. With .usage_power =3D true, the lowlevel
driver is free to shift the phase_offset and even modify the period size
and the goal is just that the average power-output matches.

Lorenz's patch does exactly this: It even keeps the period and only
shifts the phase (by period - duty_cycle). If you consider this not
legitmate, I think we have to improve the docs about .usage_power.

> What's wrong with just reversing the duty cycle in the pwm-fan? If you
> use DT it's quite trivial to do that by just reversing the entries in
> your cooling-levels property. Does that not work for you?

That's an option, too. With a different PWM (i.e. one that can do proper
inverted polarity) Lorenz's solution would be ok, though, right? And the
pwm-fan only cares about the relative duty_cycle and not the phase
shift, so setting .usage_power =3D true is fine, too?!

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--rhxflvtrefdf7zep
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmQuzvUACgkQj4D7WH0S
/k4/Egf+Ox1VxLypTm6cyDNz+uIgbTFzaY+WA5DZQt5FTjYJnYoqqalVgZiTzIUm
7IhDK/qgyDfmbUf/X4HFNtTIq6cbIpcbWwhFQjpGtx6yaVhs9By8CISv0mCYBjV6
QHEDQQXNVgjppdqv7jJo0Ivxf4WO7cnoKREQ7atIoxoHBT//qIsWL0GLAG1rs45B
FUDUod7VU2lWVdOAD/GVeeBcGVyjONuWbEshw0V9rxKoxT39ULRn/GiWv7WUmOa0
7ZrR0zSgdedKZHgS4mj2i/IdvYV7OWYpEr1BbvmnUZT5BR4KS/kGJ8WhO2ko+g35
hsWHH/KPjVFc4pv/9yC/CAh2LNkR8w==
=rRPg
-----END PGP SIGNATURE-----

--rhxflvtrefdf7zep--
