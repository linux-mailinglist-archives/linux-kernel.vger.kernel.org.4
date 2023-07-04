Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 621E1747402
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 16:22:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231753AbjGDOWr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 10:22:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231654AbjGDOWp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 10:22:45 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BEDA10E0
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jul 2023 07:22:42 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qGgvF-0007G5-SE; Tue, 04 Jul 2023 16:22:29 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qGgvE-00C3ZN-Ts; Tue, 04 Jul 2023 16:22:28 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qGgvE-002CG3-1t; Tue, 04 Jul 2023 16:22:28 +0200
Date:   Tue, 4 Jul 2023 16:22:27 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Yangtao Li <frank.li@vivo.com>, rafael@kernel.org,
        daniel.lezcano@linaro.org, amitk@kernel.org, rui.zhang@intel.com,
        mmayer@broadcom.com, bcm-kernel-feedback-list@broadcom.com,
        florian.fainelli@broadcom.com, tglx@linutronix.de,
        matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
        bchihi@baylibre.com, wenst@chromium.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v3 2/5] thermal/drivers/armada: convert to use
 devm_request_threaded_irq_emsg()
Message-ID: <20230704142227.65k3kdrnyqqolf6t@pengutronix.de>
References: <20230703090455.62101-1-frank.li@vivo.com>
 <20230703090455.62101-3-frank.li@vivo.com>
 <20230704104608.29527ec3@xps-13>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="lrq6xzeoxwlvs4uu"
Content-Disposition: inline
In-Reply-To: <20230704104608.29527ec3@xps-13>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--lrq6xzeoxwlvs4uu
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Miquel,

On Tue, Jul 04, 2023 at 10:46:08AM +0200, Miquel Raynal wrote:
> Hi Yangtao,
>=20
> frank.li@vivo.com wrote on Mon,  3 Jul 2023 17:04:51 +0800:
>=20
> > There are more than 700 calls to the devm_request_threaded_irq method.
> > Most drivers only request one interrupt resource, and these error
> > messages are basically the same. If error messages are printed
> > everywhere, more than 1000 lines of code can be saved by removing the
> > msg in the driver.
> >=20
> > And tglx point out that:
> >=20
> >   If we actually look at the call sites of
> >   devm_request_threaded_irq() then the vast majority of them print more=
 or
> >   less lousy error messages. A quick grep/sed/awk/sort/uniq revealed
> >=20
> >      519 messages total (there are probably more)
> >=20
> >      352 unique messages
> >=20
> >      323 unique messages after lower casing
> >=20
> >          Those 323 are mostly just variants of the same patterns with
> >          slight modifications in formatting and information provided.
> >=20
> >      186 of these messages do not deliver any useful information,
> >          e.g. "no irq", "
> >=20
> >      The most useful one of all is: "could request wakeup irq: %d"
> >=20
> >   So there is certainly an argument to be made that this particular
> >   function should print a well formatted and informative error message.
> >=20
> >   It's not a general allocator like kmalloc(). It's specialized and in =
the
> >   vast majority of cases failing to request the interrupt causes the
> >   device probe to fail. So having proper and consistent information why
> >   the device cannot be used _is_ useful.
> >=20
> > Let's use devm_request_threaded_irq_emsg(), which ensure that all error
> > handling branches print error information. In this way, when this funct=
ion
> > fails, the upper-layer functions can directly return an error code with=
out
> > missing debugging information. Otherwise, the error message will be
> > printed redundantly or missing.
> >=20
> > Cc: Thomas Gleixner <tglx@linutronix.de>
> > Signed-off-by: Yangtao Li <frank.li@vivo.com>
> > ---
> >  drivers/thermal/armada_thermal.c | 13 +++++--------
> >  1 file changed, 5 insertions(+), 8 deletions(-)
> >=20
> > diff --git a/drivers/thermal/armada_thermal.c b/drivers/thermal/armada_=
thermal.c
> > index 9f6dc4fc9112..a5e140643f00 100644
> > --- a/drivers/thermal/armada_thermal.c
> > +++ b/drivers/thermal/armada_thermal.c
> > @@ -913,15 +913,12 @@ static int armada_thermal_probe(struct platform_d=
evice *pdev)
> > =20
> >  	/* The overheat interrupt feature is not mandatory */
> >  	if (irq > 0) {
> > -		ret =3D devm_request_threaded_irq(&pdev->dev, irq,
> > -						armada_overheat_isr,
> > -						armada_overheat_isr_thread,
> > -						0, NULL, priv);
> > -		if (ret) {
> > -			dev_err(&pdev->dev, "Cannot request threaded IRQ %d\n",
> > -				irq);
> > +		ret =3D devm_request_threaded_irq_emsg(&pdev->dev, irq,
> > +						     armada_overheat_isr,
> > +						     armada_overheat_isr_thread,
> > +						     0, NULL, priv, NULL);
> > +		if (ret)
>=20
> I don't see a patch renaming this helper with s/emsg//, do you plan to
> keep it like that? I bet nobody outside of this series will notice the
> new helper and will continue to add error messages because it kind
> of feels "right" to do so.
>=20
> I would rather prefer returning to the original function name which
> everybody knows/uses.

See https://lore.kernel.org/lkml/87h6qpyzkd.ffs@tglx for why there is a
new function name.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--lrq6xzeoxwlvs4uu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmSkKyIACgkQj4D7WH0S
/k72twf+KGXXuIhXaaGIjMSadyvpt6IVNAp9odJSncKrJJKTHkdnob2NMnm9PBrx
uo5d38ab3x3A5iTkUyD90rJsGlP6IPP52LnxUYVaWHTDMpc9rjuBQDjmpyhzToGZ
SB2wFpN6qwyb7+AgG4LxXaR3e+serv1HnOX2ziyFf6e3MU3tIJh4KiTR/Ye7cCUG
KvnLtEmudD43+n21FChUKQf7+aR6G64rOCvirHpgmoEQul/XTT5ADU8lksDiYx25
admLK5ESXwObImzHbZsjl5e/OadNYt5z73WvFQFijceJl+uYyqMBcH2R7lGHAG5M
pS95JZRrD8tsfo21JG1OhiH2xsO7kA==
=uBz7
-----END PGP SIGNATURE-----

--lrq6xzeoxwlvs4uu--
