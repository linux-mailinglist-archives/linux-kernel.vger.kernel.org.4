Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A13377064B0
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 11:55:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229975AbjEQJzh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 05:55:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229775AbjEQJzf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 05:55:35 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98100A6
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 02:55:34 -0700 (PDT)
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1pzDsW-0005cr-K3; Wed, 17 May 2023 11:55:28 +0200
Received: from pengutronix.de (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id DC2AA1C6F22;
        Wed, 17 May 2023 09:55:27 +0000 (UTC)
Date:   Wed, 17 May 2023 11:55:27 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Johan Hovold <johan@kernel.org>
Cc:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, kernel@pengutronix.de,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH] driver core: Call pm_runtime_put_sync() only after
 device_remove()
Message-ID: <20230517-amigo-depth-00436cd21520-mkl@pengutronix.de>
References: <20230511073428.10264-1-u.kleine-koenig@pengutronix.de>
 <CAJZ5v0gNPt=rq+pQtmoGL5nxzDQboOK4d6h7=NoY=LueVhZjAQ@mail.gmail.com>
 <20230511103923.hvibdyo5ges4bab2@pengutronix.de>
 <ZFzWCey825wSlr2v@hovoldconsulting.com>
 <CAJZ5v0jvJT4JkHtO3RCUEzkfawxLCwR=QO2Y2CsL=cYN9s4hXw@mail.gmail.com>
 <ZF3tUQFTeILXV_VT@hovoldconsulting.com>
 <20230512184925.d7w3j4r7oajtpsxi@pengutronix.de>
 <ZGSQEapCl5HfQpY8@hovoldconsulting.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="3wt7jlt2pkr75bmw"
Content-Disposition: inline
In-Reply-To: <ZGSQEapCl5HfQpY8@hovoldconsulting.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:b01:1d::7b
X-SA-Exim-Mail-From: mkl@pengutronix.de
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


--3wt7jlt2pkr75bmw
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 17.05.2023 10:28:01, Johan Hovold wrote:
> Right, but we do have drivers that have CONFIG_PM as an explicit
> dependency.
>=20
> > In the end something like 72362dcdf654 ("can: mcp251xfd:
> > mcp251xfd_unregister(): simplify runtime PM handling") might be an
> > approach. But IMHO it's more complicated than it should be and honestly
> > I'm not sure if it's safe and correct this way.
>=20
> Yeah, unfortunately runtime PM is fairly underspecified so we end up
> with this multitude of implementations, many of which are broken in
> various ways. A smaller API with documented best-practices may have
> helped, but that's not where we are right now.
>=20
> Looks like 72362dcdf654 ("can: mcp251xfd: mcp251xfd_unregister():
> simplify runtime PM handling") introduces yet another way to do things,
> and which will break if anyone enables (or tries to use this pattern in
> another driver with) autosuspend...

ACK - I think in that driver it works, as the runtime PM is resumed
during interface up and suspended in interface down. IMHO autosuspend
would not bring any benefits here...

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--3wt7jlt2pkr75bmw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEDs2BvajyNKlf9TJQvlAcSiqKBOgFAmRkpIwACgkQvlAcSiqK
BOhzbAf8DWsOJ0mjyWBBY0Q+gWS12dT8Rvj/nRDr0prMJppQqSwDt5fMVojtTcPO
tn520MDhPhYdS00ufsnJj7hHfjBHEs/UAtJcqOqNGvAaY9KSG0f3T4SfBEfwDUF3
YEAjr7fSYfl1MFfx815+m3kGse1nd4VMclqa0fsucc5z+0bO7MnhAszj22cXKPHZ
JztBSMB3MFa+YlhCU5uXTumqemLK8oUjyI9HOuyc+uO6QM7rKcnkKeNnz+4xS1Gc
HrgBZcpBqFie8qOO2K9FQbyXU00iJxRc12iteaX77Prsau9kXfbIdpEr3Plo/KXU
X+mLuXKrYuC1GAlHX6RPtP2xyU/LiQ==
=J+hB
-----END PGP SIGNATURE-----

--3wt7jlt2pkr75bmw--
