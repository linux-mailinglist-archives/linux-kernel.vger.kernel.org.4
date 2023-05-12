Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B441700F0D
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 20:49:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239162AbjELSth (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 14:49:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231327AbjELStf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 14:49:35 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A6EC5585
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 11:49:34 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1pxXpX-0004Ty-Ri; Fri, 12 May 2023 20:49:27 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pxXpW-0031s5-UK; Fri, 12 May 2023 20:49:26 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pxXpV-003odu-IK; Fri, 12 May 2023 20:49:25 +0200
Date:   Fri, 12 May 2023 20:49:25 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Johan Hovold <johan@kernel.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [PATCH] driver core: Call pm_runtime_put_sync() only after
 device_remove()
Message-ID: <20230512184925.d7w3j4r7oajtpsxi@pengutronix.de>
References: <20230511073428.10264-1-u.kleine-koenig@pengutronix.de>
 <CAJZ5v0gNPt=rq+pQtmoGL5nxzDQboOK4d6h7=NoY=LueVhZjAQ@mail.gmail.com>
 <20230511103923.hvibdyo5ges4bab2@pengutronix.de>
 <ZFzWCey825wSlr2v@hovoldconsulting.com>
 <CAJZ5v0jvJT4JkHtO3RCUEzkfawxLCwR=QO2Y2CsL=cYN9s4hXw@mail.gmail.com>
 <ZF3tUQFTeILXV_VT@hovoldconsulting.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="nbpmey6zhsjg25lq"
Content-Disposition: inline
In-Reply-To: <ZF3tUQFTeILXV_VT@hovoldconsulting.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--nbpmey6zhsjg25lq
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 12, 2023 at 09:40:01AM +0200, Johan Hovold wrote:
> On Thu, May 11, 2023 at 04:44:25PM +0200, Rafael J. Wysocki wrote:
> > On Thu, May 11, 2023 at 1:48=E2=80=AFPM Johan Hovold <johan@kernel.org>=
 wrote:
>=20
> > > No, this seems like very bad idea and even violates the documentation
> > > which clearly states that the usage counter is balanced before calling
> > > remove() so that drivers can use pm_runtime_suspend() to put devices
> > > into suspended state.
> >=20
> > I missed that, sorry.
> >=20
> > > There's is really no good reason to even try to change as this is in =
no
> > > way a fast path.
> >=20
> > Still, I think that while the "put" part needs to be done before
> > device_remove(), the actual state change can be carried out later.
> >=20
> > So something like
> >=20
> >     pm_runtime_put_noidle(dev);
> >=20
> >     device_remove(dev);
> >=20
> >     pm_runtime_suspend(dev);
> >=20
> > would generally work, wouldn't it?
>=20
> No, as drivers typically disable runtime pm in their remove callbacks,
> that pm_runtime_suspend() would amount to a no-op (and calling the
> driver pm ops post unbind and the driver having freed its data would
> not work either).

However if a driver author also cares for the CONFIG_PM=3Dn case, calling
pm_runtime_suspend() doesn't have the intended effect and so it's
unfortunately complicated to rely on runtime-pm to power down your
device and you have to do it by hand anyhow (unless you let your driver
depend on CONFIG_PM). So I'm not convinced that "A driver can call
pm_runtime_suspend() to power down" is a useful thing to have.

In the end something like 72362dcdf654 ("can: mcp251xfd:
mcp251xfd_unregister(): simplify runtime PM handling") might be an
approach. But IMHO it's more complicated than it should be and honestly
I'm not sure if it's safe and correct this way.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=C3=B6nig         =
   |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--nbpmey6zhsjg25lq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmReijQACgkQj4D7WH0S
/k658ggAsjeo7koFj/nx0LObSxTtW1vC0fPsg5HchvVtxqz0ao1nfod+ObPuJiTW
hLsNGqOClxHV7e3W4zddJBm5dP39jPENLn5AOlCfYx2Z5S597ASE8WO/Rj34/RNq
v60rAe/FwHq8ymexsT4NFV62YY7PtLM4NLldmoc3uffZfTWzm0vLlQMFHlurXUHe
bJFBQqwNzQIOqlz0hzb8U4CKPZm+jv9RO6V2DSQKi4Sde/08tK9mY70N86P/cbOV
9LOAys+3svuHLNzWNk8tXtUFbZVmzCiQ8laI5WKDDNAIo6tTXEB2Oo9yaIv/XVkR
2fYQFjGfs4P7iBoI37KpcAZ6LM5mzQ==
=Atyz
-----END PGP SIGNATURE-----

--nbpmey6zhsjg25lq--
