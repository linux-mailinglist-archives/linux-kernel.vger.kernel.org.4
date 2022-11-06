Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57D8161E38D
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Nov 2022 17:55:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230079AbiKFQzO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Nov 2022 11:55:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230003AbiKFQzM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Nov 2022 11:55:12 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7E92D2DB
        for <linux-kernel@vger.kernel.org>; Sun,  6 Nov 2022 08:55:11 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1oriuk-0002rz-RM; Sun, 06 Nov 2022 17:54:30 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1oriuc-002h3E-6Q; Sun, 06 Nov 2022 17:54:23 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1oriuc-00EnGf-DQ; Sun, 06 Nov 2022 17:54:22 +0100
Date:   Sun, 6 Nov 2022 17:54:22 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Dawei Li <set_pte_at@outlook.com>
Cc:     rafael@kernel.org, gregkh@linuxfoundation.org,
        dvhart@infradead.org, andy@infradead.org, lenb@kernel.org,
        arnd@arndb.de, peterhuewe@gmx.de, kys@microsoft.com,
        kronos.it@gmail.com, dmitry.torokhov@gmail.com,
        bleung@chromium.org, sujith.thomas@intel.com, vithampi@vmware.com,
        lee@kernel.org, wim@linux-watchdog.org, jgross@suse.com,
        davem@davemloft.net, linux-acpi@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] acpi: make remove callback of acpi driver void
Message-ID: <20221106165422.nzfw36oj5q2splnc@pengutronix.de>
References: <TYCP286MB232348AC39E6F4966FA9494BCA3D9@TYCP286MB2323.JPNP286.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="5moduzi7cpupfm5g"
Content-Disposition: inline
In-Reply-To: <TYCP286MB232348AC39E6F4966FA9494BCA3D9@TYCP286MB2323.JPNP286.PROD.OUTLOOK.COM>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--5moduzi7cpupfm5g
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Sun, Nov 06, 2022 at 10:57:53PM +0800, Dawei Li wrote:
> For bus-based driver, device removal is implemented as:
> 1 device_remove()->
> 2   bus->remove()->
> 3     driver->remove()
>=20
> Driver core needs _no_ inform from callee(bus driver) about the
> result of remove callback. In that case,
> commit <fc7a6209d571> ("bus: Make remove callback return void")
> forces struct bus_type::remove() be void-returned.
>=20
> Now we have the situation that both 1 & 2 of calling chain are
> void-returned, so it does _not_ make much sense for 3(driver->remove)
> to return non-void to its caller.
>=20
> So the basic idea behind this change is making remove() callback of
> any bus-based driver to be void-returned.
>=20
> This change itself, is for device drivers based on acpi-bus.
>=20
> Signed-off-by: Dawei Li <set_pte_at@outlook.com>

Nice,

Acked-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>

It might be worth to point out that the callers of the remove callback
(i.e. acpi_device_probe and acpi_device_remove) silently ignore the
return value already today and even since before commit fc7a6209d571
("bus: Make remove callback return void").

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--5moduzi7cpupfm5g
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmNn5rUACgkQwfwUeK3K
7AlTjQf+K0rkXg+pdZx8uSNDOuTNU9kQ72zhGVpvKFigssmjZaOEF/wS3Oo1tevR
vGR5P6PS0KxA9M8H7DnALX6kZzdCzshaPOm9DIpr3HsouslN7IPEiUzM9NJuq4ln
TFlBJWxxcZgevgQJ2UlzE8uPEFEyfAsBlfuhBMhfd0zrmfnskphEhyxaGT9FesZ3
LwMnVGzRAT4KHsAS+TkVh3200gQVpBCjZz3ZcVRcjJ72faWxdpXaDYtvTgWRid2X
QmEXwBMpcMjUWtdbNbFzev4DY/dW4INYKejXKYeG8Kjn7dtdVxzRWGlz8NjHWuD2
wI3uD23kdo0lU3Ls+bxqVidZP0w9Wg==
=flOm
-----END PGP SIGNATURE-----

--5moduzi7cpupfm5g--
