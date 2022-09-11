Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E11C5B5854
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 12:29:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230332AbiILK3Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 06:29:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230215AbiILK2m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 06:28:42 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67D5826109;
        Mon, 12 Sep 2022 03:28:41 -0700 (PDT)
Received: from mercury (unknown [185.122.133.20])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id EB7A86601FE9;
        Mon, 12 Sep 2022 11:28:37 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1662978518;
        bh=4bnJgtENLYVGMbLnU95Hnc7KD/qta8A0ZG+UAGno1fo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ao4gwTK2kNZuiRxan7s17KMBYW+P96RPHV53/VrRpSjQyT18zShF0CgAeeFxvBAbD
         e/dAkO4g3addAMlfezVZzdTTE1mJdqCgt1D1/wmOfb+r5Puyyms/QAT6uZKLP8H6fi
         K+Js+r9rsDyRw1IVsCN0nmu4p3v7SjXYlhcBWKot8M/eQIvvJFizssUTjz2VBJz9z+
         h4G5EqhuoS9BZ+Qy7NKWYN94XYNRk1VLd4QFo9r0tz6OOvRApSQ/nBK3WYzspxbau8
         0K7UtSl2gzBdfHhenNaySSv8Svewroeo4sDAlwfMg+I/IwGXmy1md2Sn+9KmGI1qC7
         vGwlZng9BzVvQ==
Received: by mercury (Postfix, from userid 1000)
        id 908E71063361; Sun, 11 Sep 2022 15:04:23 +0200 (CEST)
Date:   Sun, 11 Sep 2022 15:04:23 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Ben Dooks <ben-linux@fluff.org>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH] power: supply: bq27xxx: fix __be16 warnings
Message-ID: <20220911130423.bvcvn2n3rubson5l@mercury.elektranox.org>
References: <20220721210735.451138-1-ben-linux@fluff.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ioq7dfpalwmuipdh"
Content-Disposition: inline
In-Reply-To: <20220721210735.451138-1-ben-linux@fluff.org>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DATE_IN_PAST_12_24,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ioq7dfpalwmuipdh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Jul 21, 2022 at 10:07:35PM +0100, Ben Dooks wrote:
> The bq27xxx_dm_reg_ptr() should return a __be16 as the result
> is being passed to be16_to_cpup() to convert to the proper
> cpu endian value. Move to using __be16 as appropriate to fix
> the following sparse warnings:
>=20
> drivers/power/supply/bq27xxx_battery.c:1293:26: warning: incorrect type i=
n argument 1 (different base types)
> drivers/power/supply/bq27xxx_battery.c:1293:26:    expected restricted __=
be16 const [usertype] *p
> drivers/power/supply/bq27xxx_battery.c:1293:26:    got unsigned short [us=
ertype] *prev
> drivers/power/supply/bq27xxx_battery.c:1304:17: warning: incorrect type i=
n argument 1 (different base types)
> drivers/power/supply/bq27xxx_battery.c:1304:17:    expected restricted __=
be16 const [usertype] *p
> drivers/power/supply/bq27xxx_battery.c:1304:17:    got unsigned short [us=
ertype] *prev
> drivers/power/supply/bq27xxx_battery.c:1316:15: warning: incorrect type i=
n assignment (different base types)
> drivers/power/supply/bq27xxx_battery.c:1316:15:    expected unsigned shor=
t [usertype]
> drivers/power/supply/bq27xxx_battery.c:1316:15:    got restricted __be16 =
[usertype]
>=20
> Signed-off-by: Ben Dooks <ben-linux@fluff.org>
> ---

Thanks, queued.

-- Sebastian

>  drivers/power/supply/bq27xxx_battery.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/power/supply/bq27xxx_battery.c b/drivers/power/suppl=
y/bq27xxx_battery.c
> index dccc2683455a..8bf048fbd36a 100644
> --- a/drivers/power/supply/bq27xxx_battery.c
> +++ b/drivers/power/supply/bq27xxx_battery.c
> @@ -1044,12 +1044,12 @@ struct bq27xxx_dm_buf {
>  	.block =3D (di)->dm_regs[i].offset / BQ27XXX_DM_SZ, \
>  }
> =20
> -static inline u16 *bq27xxx_dm_reg_ptr(struct bq27xxx_dm_buf *buf,
> +static inline __be16 *bq27xxx_dm_reg_ptr(struct bq27xxx_dm_buf *buf,
>  				      struct bq27xxx_dm_reg *reg)
>  {
>  	if (buf->class =3D=3D reg->subclass_id &&
>  	    buf->block =3D=3D reg->offset / BQ27XXX_DM_SZ)
> -		return (u16 *) (buf->data + reg->offset % BQ27XXX_DM_SZ);
> +		return (__be16 *) (buf->data + reg->offset % BQ27XXX_DM_SZ);
> =20
>  	return NULL;
>  }
> @@ -1275,7 +1275,7 @@ static void bq27xxx_battery_update_dm_block(struct =
bq27xxx_device_info *di,
>  {
>  	struct bq27xxx_dm_reg *reg =3D &di->dm_regs[reg_id];
>  	const char *str =3D bq27xxx_dm_reg_name[reg_id];
> -	u16 *prev =3D bq27xxx_dm_reg_ptr(buf, reg);
> +	__be16 *prev =3D bq27xxx_dm_reg_ptr(buf, reg);
> =20
>  	if (prev =3D=3D NULL) {
>  		dev_warn(di->dev, "buffer does not match %s dm spec\n", str);
> --=20
> 2.35.1
>=20

--ioq7dfpalwmuipdh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmMd3NYACgkQ2O7X88g7
+prXHBAAmjhhIWLgMyOvNGcUBmJfQyqx6YCSYZTwmhIiYmIWXyUEJKOecVI6OJq9
qrynfPc3eH7FOJAsDUT1sOf2bE7+m0Lc8M0dCKIbYtxm+F8vfpqIGDdllC/PnNOM
9KWQq7Ox7AhXzlGFNHICgXMX9rt6roh3BIvEIw6wEV0DDHWv+39961ahN/14j6Mg
KedSpA8HfAIlENr9lwW2LGx1g2yhjk4lHntBkvDuHcF83gcgJPoN76GbvK3ehC7S
5Q6X4I3ATWnhWpa+KI+UF9D+8+AZjXzsZlfNW0IaZsAf5yHPx+AaMfasyph0DNrc
hM3LkxFitrGTTMPTFAZRyshGuC1BO2jezoJTyUYEHXtj1a7qd0E7kI0sPJ8W5J9s
CBdPKn2VNkqiGjGvyaaksC7hbZCuO8FEepBUTZn96ghanut6IlOD+gCnRksVxUZa
aOy1lpWMBW1f4bElxKTYjHgw9rkDxNHtgHlDk2SQfW0tqIsbqo6ed1AY95gQeeNm
GWDNmVDM0G5Q0jiUnR1l/LeqGCZfxWo9MYAllFjeOXSbJHeWPYVmfMpHPNkmCqkd
5ThQVz1cS29SamQAAUD9sJf97UxKYf0tJEQPjuuqs0JBEat0O0EHRmoG0G1EtPxx
e3paNK5iQhmR8OHYqRp3WmKDgE3txi1LewQYOKuYjz79CXSuXng=
=LNav
-----END PGP SIGNATURE-----

--ioq7dfpalwmuipdh--
