Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C1DF6AB9A8
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 10:23:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229766AbjCFJXo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 04:23:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjCFJXm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 04:23:42 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BAAB10CB
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 01:23:40 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1pZ74A-0000jh-L6; Mon, 06 Mar 2023 10:23:34 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pZ749-002D9t-Du; Mon, 06 Mar 2023 10:23:33 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pZ748-002crS-DN; Mon, 06 Mar 2023 10:23:32 +0100
Date:   Mon, 6 Mar 2023 10:23:32 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Lee Jones <lee@kernel.org>
Cc:     Jiri Slaby <jirislaby@kernel.org>, Florian Eckert <fe@dev.tdt.de>,
        gregkh@linuxfoundation.org, pavel@ucw.cz,
        linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org,
        Eckert.Florian@googlemail.com
Subject: Re: [PATCH v7 2/2] trigger: ledtrig-tty: add additional modes
Message-ID: <20230306092332.rrwg45b4bhda4ssw@pengutronix.de>
References: <20230222083335.847655-1-fe@dev.tdt.de>
 <20230222083335.847655-3-fe@dev.tdt.de>
 <20230303141139.GP2420672@google.com>
 <be7c90cf-4c65-1cf0-3001-8706415c3d34@kernel.org>
 <20230306090456.GA9667@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ydbisql6sb23xhwq"
Content-Disposition: inline
In-Reply-To: <20230306090456.GA9667@google.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ydbisql6sb23xhwq
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 06, 2023 at 09:04:56AM +0000, Lee Jones wrote:
> On Mon, 06 Mar 2023, Jiri Slaby wrote:
>=20
> > On 03. 03. 23, 15:11, Lee Jones wrote:
> > > On Wed, 22 Feb 2023, Florian Eckert wrote:
> > > > @@ -113,21 +207,38 @@ static void ledtrig_tty_work(struct work_stru=
ct *work)
> > > >   		trigger_data->tty =3D tty;
> > > >   	}
> > > > -	ret =3D tty_get_icount(trigger_data->tty, &icount);
> > > > -	if (ret) {
> > > > -		dev_info(trigger_data->tty->dev, "Failed to get icount, stopped =
polling\n");
> > > > -		mutex_unlock(&trigger_data->mutex);
> > > > -		return;
> > > > -	}
> > > > -
> > > > -	if (icount.rx !=3D trigger_data->rx ||
> > > > -	    icount.tx !=3D trigger_data->tx) {
> > > > -		led_set_brightness_sync(trigger_data->led_cdev, LED_ON);
> > > > -
> > > > -		trigger_data->rx =3D icount.rx;
> > > > -		trigger_data->tx =3D icount.tx;
> > > > -	} else {
> > > > -		led_set_brightness_sync(trigger_data->led_cdev, LED_OFF);
> > > > +	switch (trigger_data->mode) {
> > > > +	case TTY_LED_CTS:
> > > > +		ledtrig_tty_flags(trigger_data, TIOCM_CTS);
> > > > +		break;
> > > > +	case TTY_LED_DSR:
> > > > +		ledtrig_tty_flags(trigger_data, TIOCM_DSR);
> > > > +		break;
> > > > +	case TTY_LED_CAR:
> > > > +		ledtrig_tty_flags(trigger_data, TIOCM_CAR);
> > > > +		break;
> > > > +	case TTY_LED_RNG:
> > > > +		ledtrig_tty_flags(trigger_data, TIOCM_RNG);
> > > > +		break;
> > > > +	case TTY_LED_CNT:
> > >=20
> > > I believe this requires a 'fall-through' statement.
> >=20
> > I don't think this is the case. Isn't fallthrough required only in cases
> > when there is at least one statement, i.e. a block?
>=20
> There's no mention of this caveat in the document.
>=20
> To my untrained eyes, the rule looks fairly explicit, starting with "All".
>=20
> "
>   All switch/case blocks must end in one of:
>=20
>   * break;
>   * fallthrough;
>   * continue;
>   * goto <label>;
>   * return [expression];
> "
>=20
> If you're aware of something I'm not, please consider updating the doc.

Just to add my 0.02=E2=82=AC: I think this case (i.e.

	case TTY_LED_CNT:
	default:
		...

) doesn't need a fall-through for two reasons:

 a) The compilers don't warn about this construct even with the
    fall-through warning enabled; and
 b) I wouldn't call the TTY_LED_CNT line a "block", so the quoted
    document[1] doesn't apply. (Though I agree that there is some
    potential for improvement by mentioning this case. (haha))

Best regards
Uwe

[1] Documentation/process/deprecated.rst

--=20
Pengutronix e.K.                           | Uwe Kleine-K=C3=B6nig         =
   |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--ydbisql6sb23xhwq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmQFsREACgkQwfwUeK3K
7AmgaQgAntstqH4NxocLX98IcNzJGSN1QcSlOgPZlNgGVyvItsrbDfGUYKEPHjUI
gr4K4Y9WOoJKW9mriSLQEO1YZKCbOGjghleQdK02JYTAaigV6i3pAIqvSSVOy+xf
yANjJFHXHYCVEmQM30Y0kBee8f4qVWQ06J67uCP6uRY5046Emh3+cdTiPYnfbL4R
iLHuPiyPWmMDDfHhiOCsK5PnjQL3ArF61F9BvxJrn/lv12bknnHYEHvii7xNSfSQ
zkgc93HalThzWWXUHZ0Ojya8rgUovlQ5Rg9TZdtXDQ7OgAvxIkQiClY9Kh2y+2bX
6Bu0QPqJcXEwA0ucaRwWKiQrqca8EA==
=47sA
-----END PGP SIGNATURE-----

--ydbisql6sb23xhwq--
