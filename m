Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6186E6D180B
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 09:04:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230463AbjCaHE1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 03:04:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230375AbjCaHEK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 03:04:10 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE798191E2
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 00:04:08 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1pi8nd-0005QG-EE; Fri, 31 Mar 2023 09:03:49 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pi8na-007w9x-9N; Fri, 31 Mar 2023 09:03:46 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pi8nZ-009NeF-ES; Fri, 31 Mar 2023 09:03:45 +0200
Date:   Fri, 31 Mar 2023 09:03:44 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Lee Jones <lee@kernel.org>, Wolfram Sang <wsa@kernel.org>,
        Min Li <min.li.xe@renesas.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: [PATCH] mfd: rsmu_i2c: Convert to i2c's .probe_new() again
Message-ID: <20230331070344.czphnnmvu2ojzo5l@pengutronix.de>
References: <20230331121525.42c861fe@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ezycuy6j4mgog2ec"
Content-Disposition: inline
In-Reply-To: <20230331121525.42c861fe@canb.auug.org.au>
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


--ezycuy6j4mgog2ec
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

This commit reapplies commit 601e6d48ee35 ("mfd: rsmu_i2c: Convert to
i2c's .probe_new()") which was accidently reverted by commit
1b3b1d6c27cc ("mfd: rsmu: Support 32-bit address space").

Without this change the driver fails to build in combination with commit
03c835f498b5 ("i2c: Switch .probe() to not take an id parameter") which
is contained in v6.3-rc2.

Fixes: 1b3b1d6c27cc ("mfd: rsmu: Support 32-bit address space")
Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
---
Hello,

On Fri, Mar 31, 2023 at 12:15:25PM +1100, Stephen Rothwell wrote:
> Hi all,
>=20
> After merging the mfd tree, today's linux-next build (x86_64 allmodconfig)
> failed like this:
>=20
> drivers/mfd/rsmu_i2c.c:282:18: error: initialization of 'int (*)(struct i=
2c_client *)' from incompatible pointer type 'int (*)(struct i2c_client *, =
const struct i2c_device_id *)' [-Werror=3Dincompatible-pointer-types]
>   282 |         .probe =3D rsmu_i2c_probe,
>       |                  ^~~~~~~~~~~~~~
> drivers/mfd/rsmu_i2c.c:282:18: note: (near initialization for 'rsmu_i2c_d=
river.<anonymous>.probe')
>=20
> Caused by commit
>=20
>   1b3b1d6c27cc ("mfd: rsmu: Support 32-bit address space")

This commit is strange as it undoes commit
601e6d48ee3519648679177a0647dd3b3cbaefbb without mentioning that. I
guess the reason is a wrong conflict resolution when the address space
patch was rebased.

> interacting with commit
>=20
>   03c835f498b5 ("i2c: Switch .probe() to not take an id parameter")
>=20
> from Linus' tree (v6.3-rc2).
>=20
> I applied the following merge fix patch (which may not be right :-():
>=20
> From: Stephen Rothwell <sfr@canb.auug.org.au>
> Date: Fri, 31 Mar 2023 12:05:44 +1100
> Subject: [PATCH] fixup for "mfd: rsmu: Support 32-bit address space"
>=20
> interacting with "i2c: Switch .probe() to not take an id parameter"
>=20
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
> ---
>  drivers/mfd/rsmu_i2c.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/mfd/rsmu_i2c.c b/drivers/mfd/rsmu_i2c.c
> index 221023faaadf..26972a5aff45 100644
> --- a/drivers/mfd/rsmu_i2c.c
> +++ b/drivers/mfd/rsmu_i2c.c
> @@ -201,9 +201,9 @@ static const struct regmap_config rsmu_sl_regmap_conf=
ig =3D {
>  	.can_multi_write =3D true,
>  };
> =20
> -static int rsmu_i2c_probe(struct i2c_client *client,
> -			  const struct i2c_device_id *id)
> +static int rsmu_i2c_probe(struct i2c_client *client)
>  {
> +	const struct i2c_device_id *id =3D i2c_client_get_device_id(client);
>  	const struct regmap_config *cfg;
>  	struct rsmu_ddata *rsmu;
>  	int ret;

Nearly right. This works as fix for a tree that has the above mentioned
commits. But in the mfd tree sturct i2c_driver::probe still takes the id
parameter. So to actually prevent the build failure between the merge of
mfd and Linus's tree, the right thing is to reapply commit 601e6d48ee35
("mfd: rsmu_i2c: Convert to i2c's .probe_new()") on the mfd tree.

Best regards
Uwe

 drivers/mfd/rsmu_i2c.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/mfd/rsmu_i2c.c b/drivers/mfd/rsmu_i2c.c
index 221023faaadf..807c32101460 100644
--- a/drivers/mfd/rsmu_i2c.c
+++ b/drivers/mfd/rsmu_i2c.c
@@ -201,9 +201,9 @@ static const struct regmap_config rsmu_sl_regmap_config=
 =3D {
 	.can_multi_write =3D true,
 };
=20
-static int rsmu_i2c_probe(struct i2c_client *client,
-			  const struct i2c_device_id *id)
+static int rsmu_i2c_probe(struct i2c_client *client)
 {
+	const struct i2c_device_id *id =3D i2c_client_get_device_id(client);
 	const struct regmap_config *cfg;
 	struct rsmu_ddata *rsmu;
 	int ret;
@@ -279,7 +279,7 @@ static struct i2c_driver rsmu_i2c_driver =3D {
 		.name =3D "rsmu-i2c",
 		.of_match_table =3D of_match_ptr(rsmu_i2c_of_match),
 	},
-	.probe =3D rsmu_i2c_probe,
+	.probe_new =3D rsmu_i2c_probe,
 	.remove	=3D rsmu_i2c_remove,
 	.id_table =3D rsmu_i2c_id,
 };

base-commit: 1b3b1d6c27cc0bfda4326de574f9d73f13a26bc4
--=20
2.39.2

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--ezycuy6j4mgog2ec
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmQmhc8ACgkQj4D7WH0S
/k7iGwf+Pk49loXopqBS4wjkZWKCVUj/9CUVC0nMrpRZ4kunq+aodJhfd9ZSLKpG
+H1DtEnxty4kkaEdVokY+EaaG3mKbB0TYQL0bHVK0DRiQeCzu9UKZr9a710cLZqy
IJhUZXgeRcjMfMUlYp8d3u1hvm3NJ5VEgMZ+NW66L+DcYdvF448wIEFnHTjfTSX0
Io1OcccnmtQWpcCBkDipxvtv2VFBttIWzcN0AIshGpZCF1407WgzgEnRC2/Ibntc
zbLR9AnQEw6MVa0zAl/jWfISTPi4r/eMOoCW/s3ohPQNAnAVZz1v798jpCnBiVXr
p51DAO8vCGC82PpYYTZw374tQ3oWOw==
=RAQm
-----END PGP SIGNATURE-----

--ezycuy6j4mgog2ec--
