Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA569642C76
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 17:03:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232179AbiLEQDt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 11:03:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232141AbiLEQDn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 11:03:43 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE2361C438
        for <linux-kernel@vger.kernel.org>; Mon,  5 Dec 2022 08:03:42 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1p2DwJ-0001gk-7V; Mon, 05 Dec 2022 17:03:31 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1p2DwH-002VOo-9V; Mon, 05 Dec 2022 17:03:30 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1p2DwG-002pBF-Tw; Mon, 05 Dec 2022 17:03:28 +0100
Date:   Mon, 5 Dec 2022 17:03:28 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Conor Dooley <conor.dooley@microchip.com>
Cc:     Conor Dooley <conor@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Daire McNamara <daire.mcnamara@microchip.com>,
        linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH v12 1/2] pwm: add microchip soft ip corePWM driver
Message-ID: <20221205160328.wn4rcs6uxuuaxftd@pengutronix.de>
References: <20221110093512.333881-1-conor.dooley@microchip.com>
 <20221110093512.333881-2-conor.dooley@microchip.com>
 <20221117164950.cssukd63fywzuwua@pengutronix.de>
 <Y3Zxkt3OSPQc46Q2@spud>
 <20221117210433.n5j7upqqksld42mu@pengutronix.de>
 <Y3avobkvYK3ydKTS@spud>
 <Y3uZY5mt/ZIWk3sS@wendy>
 <Y4coL74qQX80TNaT@wendy>
 <20221130103755.lhil2jaw3oufr2sf@pengutronix.de>
 <Y44Mk2nGu1Zeq7QQ@wendy>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="4zwxtzrofb5skakh"
Content-Disposition: inline
In-Reply-To: <Y44Mk2nGu1Zeq7QQ@wendy>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--4zwxtzrofb5skakh
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Conor,

On Mon, Dec 05, 2022 at 03:21:55PM +0000, Conor Dooley wrote:
> I came into work today thinking that I could just rebase on top of your
> patchset and send out a v13, but that was unfortunately not the case :/
>=20
> So uh, it turns out that I was wrong about the behaviour of the
> sync_update register's bit.
> It turns out that that bit holds it's value until the IP block is reset,
> and /does not/ get cleared at the start of the next period.
> I'm really not sure how it worked when I tested the other week [0], so I
> spent the first half of the day trying to figure out what on earth had
> happened to my FPGA image. I must've picked the wrong image when I went
> to test it the other week that had the wrong configuration somehow.
>=20
> As a result, I've gone and hacked up another way of transferring the
> burden of waiting - setting a timer for the period, backed by a
> completion. get_state() and apply() now both check for the completion
> and time out otherwise. I'm half tempted to tack RFC back onto the
> series as I have not really messed with timers at all before and may
> have done something off the wall.
>=20
> I pushed it out (see [1] in case you'd like to look) so that the bots
> can have a play with it, since it'll be a few weeks before I'll have a
> chance to properly test that I've broken nothing with this.

I didn't look, but I'm convinced you don't need a timer. Something like
the following should work, shouldn't it?:

 - in .apply() check the current time, add the current period and store
   the result to ddata->updatetimestamp
 - in .get_state do:
     if (current_time >=3D ddata->updatetimestamp)
       process fine
     else:
       timeout (or wait until ddata->updatetimestamp?)

Actually I'd prefer to wait instead of -ETIMEOUT.
=20
Best regards
Uwe



--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--4zwxtzrofb5skakh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmOOFk0ACgkQwfwUeK3K
7Am4Lgf/fv9edPfJKrkZU9qkFGEmRFODwJ7+JvDFuOvR0sZmDxn9JIDIn5kLQNoD
4WDDJM8i8PQvzDBlSy4wJ+hn9Gm9D6F9WgIRRHTmcc5RdN/csoM/cmFkbNonmZZC
lOaEbX1I02orVuen7mkBzWrwM5WBOsCm3Vmn0oaNeXFlnM2GXlR2zjKFoa5aEC9l
qjQ63WX6Jcp7KBMlfRxOuOUhykFYosE+zEPoTFz7nI4uL4w1QhSyINk8SDkNzcDH
c0/X2ATGj9hmZTOatujovzWVAZEPNeqd4j51+0+lU+jHlUgcxm0gvgZVy7HE4keR
r5gqCh0sz0azMsfDjKtaMz8qLd7V/A==
=3pIO
-----END PGP SIGNATURE-----

--4zwxtzrofb5skakh--
