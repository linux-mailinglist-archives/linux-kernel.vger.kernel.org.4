Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C7B761E36C
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Nov 2022 17:27:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230126AbiKFQ1m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Nov 2022 11:27:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229894AbiKFQ1f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Nov 2022 11:27:35 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7272265AC
        for <linux-kernel@vger.kernel.org>; Sun,  6 Nov 2022 08:27:34 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1oriUc-0000iA-6U; Sun, 06 Nov 2022 17:27:30 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1oriUW-002h0X-JA; Sun, 06 Nov 2022 17:27:25 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1oriUW-00EnDH-Ja; Sun, 06 Nov 2022 17:27:24 +0100
Date:   Sun, 6 Nov 2022 17:27:24 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Yang Yingliang <yangyingliang@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Thorsten Scherer <t.scherer@eckelmann.de>,
        kernel@pengutronix.de
Subject: Re: [PATCH] siox: fix possible memory leak in siox_device_add()
Message-ID: <20221106162724.dwlwep32wxkcxd5z@pengutronix.de>
References: <20221104021334.618189-1-yangyingliang@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="27dzadorfidvq2uu"
Content-Disposition: inline
In-Reply-To: <20221104021334.618189-1-yangyingliang@huawei.com>
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


--27dzadorfidvq2uu
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Fri, Nov 04, 2022 at 10:13:34AM +0800, Yang Yingliang wrote:
> If device_register() returns error in siox_device_add(),
> the name allocated by dev_set_name() need be freed. As
> comment of device_register() says, it should use put_device()
> to give up the reference in the error path. So fix this
> by calling put_device(), then the name can be freed in
> kobject_cleanup(), and sdevice is freed in siox_device_release(),
> set it to null in error path.
>=20
> Fixes: bbecb07fa0af ("siox: new driver framework for eckelmann SIOX")
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
> ---
>  drivers/siox/siox-core.c | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/drivers/siox/siox-core.c b/drivers/siox/siox-core.c
> index 7c4f32d76966..561408583b2b 100644
> --- a/drivers/siox/siox-core.c
> +++ b/drivers/siox/siox-core.c
> @@ -839,6 +839,8 @@ static struct siox_device *siox_device_add(struct sio=
x_master *smaster,
> =20
>  err_device_register:
>  	/* don't care to make the buffer smaller again */
> +	put_device(&sdevice->dev);
> +	sdevice =3D NULL;

The problem is real and the fix works as intended. I don't like the
necessity to set sdevice to NULL, but that's the easiest approach here,
so:

Reviewed-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>

>  err_buf_alloc:
>  	siox_master_unlock(smaster);

@gregkh: Could you pick up this patch please[1]? While I don't consider it
very urgent, it's technically a fix. I don't care much if it goes in now
or during the next merge window.

Best regards
Uwe

[1] the original Message-Id is
    20221104021334.618189-1-yangyingliang@huawei.com. Maybe this helps
    you to apply the patch even if you didn't get a Cc.

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--27dzadorfidvq2uu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmNn4FgACgkQwfwUeK3K
7Ak/GQf+Pw+TSsEGpowlbtHa+ekY78jy1eQAcWiQr9jxJGznBF4Ym13NKvszWzug
lnLCLG44KDB19BaTnzIYB+vXCJJas7dUpR/gy0Yl2XtjQgpEHEhp+wCY1bfpaQMY
64+dGyaFmYaY0sz5kphJgGRxBjgn6E34e06Tphv/qmwv46aApFzCV1FGpp7pDbXJ
bmJXY+uJCfEcKBKqIAwWgDxyMxY6RzfAExejZJs7Z8FwFm+MMDrvxQNd9pP1hnAB
Qr0aevg7B/xbEbniqr8fLnpjINc8YsP5W3W9tgEXYPAstoplG8talpgElDmtnLpU
szRIWs6pQ3svPILvZKQV6yadczkJSg==
=nzFJ
-----END PGP SIGNATURE-----

--27dzadorfidvq2uu--
