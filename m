Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CC605F3CB4
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 08:23:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229678AbiJDGXM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 02:23:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbiJDGXL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 02:23:11 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D17313C17C
        for <linux-kernel@vger.kernel.org>; Mon,  3 Oct 2022 23:23:09 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1ofbKY-0003ds-Dw; Tue, 04 Oct 2022 08:23:02 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1ofbKX-004Vig-BV; Tue, 04 Oct 2022 08:22:59 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1ofbKV-005Spi-1t; Tue, 04 Oct 2022 08:22:59 +0200
Date:   Tue, 4 Oct 2022 08:22:59 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Mike Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Alex Helms <alexander.helms.jy@renesas.com>
Cc:     Wolfram Sang <wsa@the-dreams.de>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the i2c tree
Message-ID: <20221004062259.r5hktwp4vwjmzqiv@pengutronix.de>
References: <20221004112059.5677a13e@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="csiwm45eunbsf5du"
Content-Disposition: inline
In-Reply-To: <20221004112059.5677a13e@canb.auug.org.au>
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


--csiwm45eunbsf5du
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello clk guys,

On Tue, Oct 04, 2022 at 11:20:59AM +1100, Stephen Rothwell wrote:
> Hi all,
>=20
> After merging the i2c tree, today's linux-next build (x86_64 allmodconfig)
> failed like this:
>=20
> drivers/clk/clk-versaclock7.c:1304:19: error: initialization of 'void (*)=
(struct i2c_client *)' from incompatible pointer type 'int (*)(struct i2c_c=
lient *)' [-Werror=3Dincompatible-pointer-types]
>  1304 |         .remove =3D vc7_remove,
>       |                   ^~~~~~~~~~
> drivers/clk/clk-versaclock7.c:1304:19: note: (near initialization for 'vc=
7_i2c_driver.remove')
>=20
> Caused by commit
>=20
>   48c5e98fedd9 ("clk: Renesas versaclock7 ccf device driver")
>=20
> from the clk tree interacting with commit
>=20
>   ed5c2f5fd10d ("i2c: Make remove callback return void")
>=20
> from the i2c tree.

You might want to pull

	https://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git i2c/make_rem=
ove_callback_void-immutable

to fix this in your tree.

> I have applied the following merge fix patch.
>=20
> From: Stephen Rothwell <sfr@canb.auug.org.au>
> Date: Tue, 4 Oct 2022 11:13:45 +1100
> Subject: [PATCH] clk: fix up for "i2c: Make remove callback return void"
>=20
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
> ---
>  drivers/clk/clk-versaclock7.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>=20
> diff --git a/drivers/clk/clk-versaclock7.c b/drivers/clk/clk-versaclock7.c
> index 050807cf971f..8e4f86e852aa 100644
> --- a/drivers/clk/clk-versaclock7.c
> +++ b/drivers/clk/clk-versaclock7.c
> @@ -1235,14 +1235,12 @@ static int vc7_probe(struct i2c_client *client)
>  	return ret;
>  }
> =20
> -static int vc7_remove(struct i2c_client *client)
> +static void vc7_remove(struct i2c_client *client)
>  {
>  	struct vc7_driver_data *vc7 =3D i2c_get_clientdata(client);
> =20
>  	of_clk_del_provider(client->dev.of_node);
>  	clk_unregister_fixed_rate(vc7->clk_apll.clk);
> -
> -	return 0;
>  }

Looks good.

Thanks
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--csiwm45eunbsf5du
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmM70UAACgkQwfwUeK3K
7AmUigf+KHzTAeWUcIZaqYWQpPxNAwp7r2R80K9XZ2f0untk1SLzpQV0UpY/zQu+
zdfq6qJOcwGA88Ywb6lHyCgoTk+8jUNTxnbFARdEEhsfbSe83WFgSZ5O3g4ElSqk
l1yh5JzaBrls+URn1KfpJyLuNRSZSwNz5Zw+nHCMVb2JjI8/eYvlCpPS+5OMGLx5
GtPVPaaelvnD/moEuQKCCnHc8FI++gf410Qhgz++L6N7/rHsTVNmFW8bz+K06UmO
SAd/+dM6VCLRa2wKsMDZVcj6gbMBdv6eP7YJ0E/EtfSR55cIuaUEeZ5LQE0h/0vi
p3mk/4yiyu5PTtupWgB5v4CO88ZBWw==
=GRDH
-----END PGP SIGNATURE-----

--csiwm45eunbsf5du--
