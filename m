Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A39E6BC35B
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 02:35:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229546AbjCPBfB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 21:35:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229581AbjCPBe7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 21:34:59 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99A1839BB3
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 18:34:57 -0700 (PDT)
Received: from mercury (unknown [185.254.75.29])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 051716602FA0;
        Thu, 16 Mar 2023 01:34:56 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1678930496;
        bh=bTtTzUU2wpinLOOLThqUHwsERJNSZVn+r31EKIN9j+0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EX3WZO6VzyURJH6Wu9AMskKbJeloJpkZfgHXI2EDuPBflw/NEAcTd/albVAkSS88S
         Uf8kfx2/SkXmnquDElTPcYGNuMgUBnPM9qmg8LNXnkR+ajfVkxZhJCD6ZyAdfstOX8
         wc8f7BbYF4GhzH84XT0vHHCWPmFNJzv+QFun4gmKWT+JWQgQpw0S1Z2UEoMpi7fZCi
         TdBszez0UGxHynOKj19L8/EwZNxdTVrda+AZSSs04B+iYlt8PRAOL7KFrsiaG8t0fc
         3Lk5zDmuQg4hQE5CdAfQhgKjh21bOdsscc6zMZCBqMm723ZLLaPh0l3almHfo3/Zj+
         +0UfvymTY9wpA==
Received: by mercury (Postfix, from userid 1000)
        id 0840510609DC; Thu, 16 Mar 2023 02:34:53 +0100 (CET)
Date:   Thu, 16 Mar 2023 02:34:53 +0100
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org
Cc:     Lee Jones <lee@kernel.org>
Subject: Re: [PATCHv7 10/11] regulator: expose regulator_find_closest_bigger
Message-ID: <20230316013453.qtbdfxcfcnvsp43x@mercury.elektranox.org>
References: <20230307153617.643260-1-sebastian.reichel@collabora.com>
 <20230307153617.643260-11-sebastian.reichel@collabora.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="jplrorzno7i7afes"
Content-Disposition: inline
In-Reply-To: <20230307153617.643260-11-sebastian.reichel@collabora.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--jplrorzno7i7afes
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Mark and Liam,

On Tue, Mar 07, 2023 at 04:36:16PM +0100, Sebastian Reichel wrote:
> Expose and document the table lookup logic used by
> regulator_set_ramp_delay_regmap, so that it can be
> reused for devices that cannot be configured via
> regulator_set_ramp_delay_regmap.
>=20
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> ---

Can you please Ack and the following patch?
(they needs to go through MFD tree)

Thanks,

-- Sebastian

>  drivers/regulator/helpers.c      | 22 ++++++++++++++++++----
>  include/linux/regulator/driver.h |  2 ++
>  2 files changed, 20 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/regulator/helpers.c b/drivers/regulator/helpers.c
> index ad2237a95572..586f42e378ee 100644
> --- a/drivers/regulator/helpers.c
> +++ b/drivers/regulator/helpers.c
> @@ -902,8 +902,21 @@ bool regulator_is_equal(struct regulator *reg1, stru=
ct regulator *reg2)
>  }
>  EXPORT_SYMBOL_GPL(regulator_is_equal);
> =20
> -static int find_closest_bigger(unsigned int target, const unsigned int *=
table,
> -			       unsigned int num_sel, unsigned int *sel)
> +/**
> + * regulator_find_closest_bigger - helper to find offset in ramp delay t=
able
> + *
> + * @target: targeted ramp_delay
> + * @table: table with supported ramp delays
> + * @num_sel: number of entries in the table
> + * @sel: Pointer to store table offset
> + *
> + * This is the internal helper used by regulator_set_ramp_delay_regmap to
> + * map ramp delay to register value. It should only be used directly if
> + * regulator_set_ramp_delay_regmap cannot handle a specific device setup
> + * (e.g. because the value is split over multiple registers).
> + */
> +int regulator_find_closest_bigger(unsigned int target, const unsigned in=
t *table,
> +				  unsigned int num_sel, unsigned int *sel)
>  {
>  	unsigned int s, tmp, max, maxsel =3D 0;
>  	bool found =3D false;
> @@ -933,6 +946,7 @@ static int find_closest_bigger(unsigned int target, c=
onst unsigned int *table,
> =20
>  	return 0;
>  }
> +EXPORT_SYMBOL_GPL(regulator_find_closest_bigger);
> =20
>  /**
>   * regulator_set_ramp_delay_regmap - set_ramp_delay() helper
> @@ -951,8 +965,8 @@ int regulator_set_ramp_delay_regmap(struct regulator_=
dev *rdev, int ramp_delay)
>  	if (WARN_ON(!rdev->desc->n_ramp_values || !rdev->desc->ramp_delay_table=
))
>  		return -EINVAL;
> =20
> -	ret =3D find_closest_bigger(ramp_delay, rdev->desc->ramp_delay_table,
> -				  rdev->desc->n_ramp_values, &sel);
> +	ret =3D regulator_find_closest_bigger(ramp_delay, rdev->desc->ramp_dela=
y_table,
> +					    rdev->desc->n_ramp_values, &sel);
> =20
>  	if (ret) {
>  		dev_warn(rdev_get_dev(rdev),
> diff --git a/include/linux/regulator/driver.h b/include/linux/regulator/d=
river.h
> index d3b4a3d4514a..c6ef7d68eb9a 100644
> --- a/include/linux/regulator/driver.h
> +++ b/include/linux/regulator/driver.h
> @@ -758,6 +758,8 @@ int regulator_set_current_limit_regmap(struct regulat=
or_dev *rdev,
>  				       int min_uA, int max_uA);
>  int regulator_get_current_limit_regmap(struct regulator_dev *rdev);
>  void *regulator_get_init_drvdata(struct regulator_init_data *reg_init_da=
ta);
> +int regulator_find_closest_bigger(unsigned int target, const unsigned in=
t *table,
> +				  unsigned int num_sel, unsigned int *sel);
>  int regulator_set_ramp_delay_regmap(struct regulator_dev *rdev, int ramp=
_delay);
>  int regulator_sync_voltage_rdev(struct regulator_dev *rdev);
> =20
> --=20
> 2.39.2
>=20
>=20
> --=20
> To unsubscribe, send mail to kernel-unsubscribe@lists.collabora.co.uk.

--jplrorzno7i7afes
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmQScjwACgkQ2O7X88g7
+prJpxAAoHYduEM+v/ahKmf9e8gro+8MB93vfATZQQldIZmfvpRL3HiBi9Uuf5T3
yc7FVFoRAB0qp790diASeMSKyU4qB/M16vJFhAF6FM0e5eAGNS/DbZ7qizlh8BU2
7pQ7hx5/E2qQo4J8r//hoG6UhgCQK45SZejYPhZActZ0kbnfYGYnuk1TruRv+vyB
DKfc+C1Q1g30sxyM3dJX3mKpCNgYH90arlrUdcljxKRhsM9YIuC0OeOdQEyp3cZ0
PAJk7/5PCdCy7tBLH2n442RG9lHBOqApRIHX5rBvExvdEL5tJjWXnmyrrS+K1nLe
aQMLMQH+NA4AC7Tc37ig3SOMmW+c/9/OpvrqQgZ+sahR9FSZaMrHOZDnO1aD17A7
pGMAyjArDazUqObBZ6adO75GpOBTgtza1MuDE5h3ccrUdUlx+K9AC4kgXXdBv5Nj
seUvmzY4W18U5hSfe3siGlDTbb8ZK24ZdQTs5LC5YN4IofRHp0RwTo8ZZvR8OFf6
8HitYwgEXCB4J5LgLFrzdjhsTWXR9ys8CRu9yvyvVtYYZ1GmxsDo+H0ceF3R+Dug
ErDCavo28vQxX8+64VIbLURJH3y3rT6dxqLdST+qvDK9jgx/kykpZEH3BhHw44PO
aRtNXYHZ5W445rmX+UJ4XqsT1E43S49FKMXFw9h+9wDxaqyXCWQ=
=hEZq
-----END PGP SIGNATURE-----

--jplrorzno7i7afes--
