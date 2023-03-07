Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9B426AF78B
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 22:28:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229940AbjCGV2E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 16:28:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229984AbjCGV2C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 16:28:02 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A04282B603
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 13:28:00 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1pZeqe-0003kp-Pb; Tue, 07 Mar 2023 22:27:52 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pZeqa-002ZcN-MU; Tue, 07 Mar 2023 22:27:48 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pZeqZ-0037IA-Tf; Tue, 07 Mar 2023 22:27:47 +0100
Date:   Tue, 7 Mar 2023 22:27:44 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     George Stark <gnstark@sberdevices.ru>
Cc:     thierry.reding@gmail.com, krzysztof.kozlowski@linaro.org,
        alim.akhtar@samsung.com, linux-pwm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, kernel@sberdevices.ru
Subject: Re: [RFC PATCH v1] Revert "pwm: Clear chip_data in pwm_put()"
Message-ID: <20230307212744.rx2julmzxe7nvhvr@pengutronix.de>
References: <20230307210014.1380102-1-gnstark@sberdevices.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ipjr5sesxsxhrren"
Content-Disposition: inline
In-Reply-To: <20230307210014.1380102-1-gnstark@sberdevices.ru>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ipjr5sesxsxhrren
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello George,

On Wed, Mar 08, 2023 at 12:00:14AM +0300, George Stark wrote:
> From: George Stark <GNStark@sberdevices.ru>
>=20
> This reverts commit e926b12c611c2095c7976e2ed31753ad6eb5ff1a.
>=20
> There're several issues with the original change:
>=20
> - it breaks generic semantics of set_driver_data-like routines that
> only client code controls lifetime of it's own data.
>=20
> - it breaks pwm-sti.c driver: pwm_set_chip_data is used only in probe sta=
ge
> then pwm_get_chip_data used in capture callback

pwm-sti is also broken in other regards. pwm_set_chip_data() is only
called after pwmchip_add(). But as soon as pwmchip_add() is called, the
callbacks (e.g. capture) might be called. Then the call to
pwm_set_chip_data() might be too late.

> Change-Id: I5787c6b4c520d4a0997567c416b26fa4e0806b94

Please don't add a Change-Id footer for Linux submissions.

If you ask me, better drop pwm_set_chip_data() completely. It adds no
useful value. It's just a variant of driver data and using both
complicates the driver and probably fragments memory allocations. Also
the sematic of driver data is better known as it's the same for all
subsystems.

Do you use the capture functionality? In my eyes the capture part of the
pwm subsystem is very alien. Only a small subset of the hardware
supports this and the counter framework should be better suited for such
tasks.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--ipjr5sesxsxhrren
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmQHrE0ACgkQwfwUeK3K
7An0VQf/Q8drCNWe2yFtZ7b5zIZL0ubg//PbtqdKFDUY0zikTrKiIHUMHhKuUjNt
pC+Ah0mQPePQa5bNstPwfdTjx4sOhQfIjIKgnxJWoDbgqQZX9AUcoZt6qhMm/uqA
SKA5wYQ98b2sjrIsE09WM8hBzIXEaY4YAsOM83TL2c0Fz0qMJaTtFz00QJgkZXFD
lbZxvH5ArBqUxKzMmkooWPxgY2XlZxcCQmlCSBz/DYymz9HyViNl8da9J8qjQY00
TJz64OVL4L2Bs9LthmjNXimxI26DtO595EWyYKzPPaxvVanqPMjxdW1n7fNDAffJ
OlhSpm5uqfjEPzlx9uK+opLtY/2SAQ==
=6gx+
-----END PGP SIGNATURE-----

--ipjr5sesxsxhrren--
