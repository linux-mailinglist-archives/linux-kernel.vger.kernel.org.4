Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF1636B6C12
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Mar 2023 23:50:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229619AbjCLWuV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Mar 2023 18:50:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229578AbjCLWuT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Mar 2023 18:50:19 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E5BE32E5D;
        Sun, 12 Mar 2023 15:50:17 -0700 (PDT)
Received: from mercury (unknown [185.254.75.29])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 33D7D6602F13;
        Sun, 12 Mar 2023 22:50:16 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1678661416;
        bh=M5+nSc1iWkLndW4q1iULDQ+SKPeVQwicOS2p4YvXLMg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=StDhfmUJlXV+oPEgIlhee7wlWGQ6o8gHfe245ShrtwlQQSeDlNj8lMEEe+JhPF0Ri
         WexywZk9xrkQ+ZkA3FPcd7IFjbAD0iHtHgnxKG7JfQQs+XZXJocn1wiG1d7hldpAPs
         vlvmdabSOEoRFcxoN445VC5pQ/AIjtfSJZ799oYvvWZmIq6IS1//twH1MdgSt5Plnj
         9MJ1OEkve8JRVIcdi1SwbZQa4LvxfIe171txSoVAvrXLHyLfP2VtZsXA/H36fhShCJ
         eLJf0QU8YCoCNHxh9xFxY2UKToUIiguOaWPTxXtES5wszBH9+lx4TehxC8huRaaSGu
         GqVu+qYfCJGVg==
Received: by mercury (Postfix, from userid 1000)
        id 8912A1060FD4; Sun, 12 Mar 2023 23:50:13 +0100 (CET)
Date:   Sun, 12 Mar 2023 23:50:13 +0100
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Hermes Zhang <chenhuiz@axis.com>
Cc:     kernel@axis.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] power: supply: bq256xx: Support to disable charger
Message-ID: <1fdf00a0-4830-465a-801c-147472fdcd22@mercury.local>
References: <20230309064104.79005-1-chenhuiz@axis.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="qoe3tbzunmzj3cl4"
Content-Disposition: inline
In-Reply-To: <20230309064104.79005-1-chenhuiz@axis.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--qoe3tbzunmzj3cl4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Mar 09, 2023 at 02:41:03PM +0800, Hermes Zhang wrote:
> To be able to control the charging process flexible, we need to able to
> disable the charger. This commit will allow to disable the charger by
> "echo 1 > /sys/class/power_supply/bq256xx-charger/charge_type"
> (1 =3D POWER_SUPPLY_CHARGE_TYPE_NONE) and enable the charger by set it to
> 2/3 (POWER_SUPPLY_CHARGE_TYPE_TRICKLE/POWER_SUPPLY_CHARGE_TYPE_FAST)
>=20
> Signed-off-by: Hermes Zhang <chenhuiz@axis.com>
> ---

Thanks, queued.

-- Sebastian

>  drivers/power/supply/bq256xx_charger.c | 40 ++++++++++++++++++++++++++
>  1 file changed, 40 insertions(+)
>=20
> diff --git a/drivers/power/supply/bq256xx_charger.c b/drivers/power/suppl=
y/bq256xx_charger.c
> index 9cf4936440c9..e624834ae66c 100644
> --- a/drivers/power/supply/bq256xx_charger.c
> +++ b/drivers/power/supply/bq256xx_charger.c
> @@ -70,6 +70,9 @@
>  #define BQ25611D_VBATREG_THRESH_uV	4290000
>  #define BQ25618_VBATREG_THRESH_uV	4300000
> =20
> +#define BQ256XX_CHG_CONFIG_MASK		BIT(4)
> +#define BQ256XX_CHG_CONFIG_BIT_SHIFT	4
> +
>  #define BQ256XX_ITERM_MASK		GENMASK(3, 0)
>  #define BQ256XX_ITERM_STEP_uA		60000
>  #define BQ256XX_ITERM_OFFSET_uA		60000
> @@ -259,6 +262,7 @@ struct bq256xx_device {
>   * @bq256xx_set_iterm: pointer to instance specific set_iterm function
>   * @bq256xx_set_iprechg: pointer to instance specific set_iprechg functi=
on
>   * @bq256xx_set_vindpm: pointer to instance specific set_vindpm function
> + * @bq256xx_set_charge_type: pointer to instance specific set_charge_typ=
e function
>   *
>   * @bq256xx_def_ichg: default ichg value in microamps
>   * @bq256xx_def_iindpm: default iindpm value in microamps
> @@ -290,6 +294,7 @@ struct bq256xx_chip_info {
>  	int (*bq256xx_set_iterm)(struct bq256xx_device *bq, int iterm);
>  	int (*bq256xx_set_iprechg)(struct bq256xx_device *bq, int iprechg);
>  	int (*bq256xx_set_vindpm)(struct bq256xx_device *bq, int vindpm);
> +	int (*bq256xx_set_charge_type)(struct bq256xx_device *bq, int type);
> =20
>  	int bq256xx_def_ichg;
>  	int bq256xx_def_iindpm;
> @@ -449,6 +454,27 @@ static int bq256xx_get_state(struct bq256xx_device *=
bq,
>  	return 0;
>  }
> =20
> +static int bq256xx_set_charge_type(struct bq256xx_device *bq, int type)
> +{
> +	int chg_config =3D 0;
> +
> +	switch (type) {
> +	case POWER_SUPPLY_CHARGE_TYPE_NONE:
> +		chg_config =3D 0x0;
> +		break;
> +	case POWER_SUPPLY_CHARGE_TYPE_TRICKLE:
> +	case POWER_SUPPLY_CHARGE_TYPE_FAST:
> +		chg_config =3D 0x1;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	return regmap_update_bits(bq->regmap, BQ256XX_CHARGER_CONTROL_0,
> +				BQ256XX_CHG_CONFIG_MASK,
> +				(chg_config ? 1 : 0) << BQ256XX_CHG_CONFIG_BIT_SHIFT);
> +}
> +
>  static int bq256xx_get_ichg_curr(struct bq256xx_device *bq)
>  {
>  	unsigned int charge_current_limit;
> @@ -915,6 +941,12 @@ static int bq256xx_set_charger_property(struct power=
_supply *psy,
>  			return ret;
>  		break;
> =20
> +	case POWER_SUPPLY_PROP_CHARGE_TYPE:
> +		ret =3D bq->chip_info->bq256xx_set_charge_type(bq, val->intval);
> +		if (ret)
> +			return ret;
> +		break;
> +
>  	default:
>  		break;
>  	}
> @@ -1197,6 +1229,7 @@ static int bq256xx_property_is_writeable(struct pow=
er_supply *psy,
>  	case POWER_SUPPLY_PROP_CHARGE_TERM_CURRENT:
>  	case POWER_SUPPLY_PROP_STATUS:
>  	case POWER_SUPPLY_PROP_INPUT_VOLTAGE_LIMIT:
> +	case POWER_SUPPLY_PROP_CHARGE_TYPE:
>  		return true;
>  	default:
>  		return false;
> @@ -1286,6 +1319,7 @@ static const struct bq256xx_chip_info bq256xx_chip_=
info_tbl[] =3D {
>  		.bq256xx_set_iterm =3D bq256xx_set_term_curr,
>  		.bq256xx_set_iprechg =3D bq256xx_set_prechrg_curr,
>  		.bq256xx_set_vindpm =3D bq256xx_set_input_volt_lim,
> +		.bq256xx_set_charge_type =3D bq256xx_set_charge_type,
> =20
>  		.bq256xx_def_ichg =3D BQ2560X_ICHG_DEF_uA,
>  		.bq256xx_def_iindpm =3D BQ256XX_IINDPM_DEF_uA,
> @@ -1316,6 +1350,7 @@ static const struct bq256xx_chip_info bq256xx_chip_=
info_tbl[] =3D {
>  		.bq256xx_set_iterm =3D bq256xx_set_term_curr,
>  		.bq256xx_set_iprechg =3D bq256xx_set_prechrg_curr,
>  		.bq256xx_set_vindpm =3D bq256xx_set_input_volt_lim,
> +		.bq256xx_set_charge_type =3D bq256xx_set_charge_type,
> =20
>  		.bq256xx_def_ichg =3D BQ2560X_ICHG_DEF_uA,
>  		.bq256xx_def_iindpm =3D BQ256XX_IINDPM_DEF_uA,
> @@ -1346,6 +1381,7 @@ static const struct bq256xx_chip_info bq256xx_chip_=
info_tbl[] =3D {
>  		.bq256xx_set_iterm =3D bq256xx_set_term_curr,
>  		.bq256xx_set_iprechg =3D bq256xx_set_prechrg_curr,
>  		.bq256xx_set_vindpm =3D bq256xx_set_input_volt_lim,
> +		.bq256xx_set_charge_type =3D bq256xx_set_charge_type,
> =20
>  		.bq256xx_def_ichg =3D BQ2560X_ICHG_DEF_uA,
>  		.bq256xx_def_iindpm =3D BQ256XX_IINDPM_DEF_uA,
> @@ -1376,6 +1412,7 @@ static const struct bq256xx_chip_info bq256xx_chip_=
info_tbl[] =3D {
>  		.bq256xx_set_iterm =3D bq256xx_set_term_curr,
>  		.bq256xx_set_iprechg =3D bq256xx_set_prechrg_curr,
>  		.bq256xx_set_vindpm =3D bq256xx_set_input_volt_lim,
> +		.bq256xx_set_charge_type =3D bq256xx_set_charge_type,
> =20
>  		.bq256xx_def_ichg =3D BQ2560X_ICHG_DEF_uA,
>  		.bq256xx_def_iindpm =3D BQ256XX_IINDPM_DEF_uA,
> @@ -1406,6 +1443,7 @@ static const struct bq256xx_chip_info bq256xx_chip_=
info_tbl[] =3D {
>  		.bq256xx_set_iterm =3D bq256xx_set_term_curr,
>  		.bq256xx_set_iprechg =3D bq256xx_set_prechrg_curr,
>  		.bq256xx_set_vindpm =3D bq256xx_set_input_volt_lim,
> +		.bq256xx_set_charge_type =3D bq256xx_set_charge_type,
> =20
>  		.bq256xx_def_ichg =3D BQ25611D_ICHG_DEF_uA,
>  		.bq256xx_def_iindpm =3D BQ256XX_IINDPM_DEF_uA,
> @@ -1436,6 +1474,7 @@ static const struct bq256xx_chip_info bq256xx_chip_=
info_tbl[] =3D {
>  		.bq256xx_set_iterm =3D bq25618_619_set_term_curr,
>  		.bq256xx_set_iprechg =3D bq25618_619_set_prechrg_curr,
>  		.bq256xx_set_vindpm =3D bq256xx_set_input_volt_lim,
> +		.bq256xx_set_charge_type =3D bq256xx_set_charge_type,
> =20
>  		.bq256xx_def_ichg =3D BQ25618_ICHG_DEF_uA,
>  		.bq256xx_def_iindpm =3D BQ256XX_IINDPM_DEF_uA,
> @@ -1466,6 +1505,7 @@ static const struct bq256xx_chip_info bq256xx_chip_=
info_tbl[] =3D {
>  		.bq256xx_set_iterm =3D bq25618_619_set_term_curr,
>  		.bq256xx_set_iprechg =3D bq25618_619_set_prechrg_curr,
>  		.bq256xx_set_vindpm =3D bq256xx_set_input_volt_lim,
> +		.bq256xx_set_charge_type =3D bq256xx_set_charge_type,
> =20
>  		.bq256xx_def_ichg =3D BQ25618_ICHG_DEF_uA,
>  		.bq256xx_def_iindpm =3D BQ256XX_IINDPM_DEF_uA,
> --=20
> 2.30.2
>=20

--qoe3tbzunmzj3cl4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmQOVyUACgkQ2O7X88g7
+pq18A//fKNA9oreZmLLVfBcno87KV1EzcerqLASBIhTm71l67H+bcJlrfj6MtiN
JwZljO5B0OBpd0VgbSCgPZDxrdvcOkRnK7d97F9Ld214DngO1MWIlknrEJc2iwCX
KQtQS0x8E2FSu/ac4jg7UnnL7psJvWct65uy5FNNpFpvUJQBOP3SNyb/8mEfO3rk
ImuZn4+B6j7WJzM3/qGK0+5VdilllFmsGvtvCUcChWkOY1PvD4BLJnTbEdGbEZ5J
wWFsDoAXUQOqCPV0Hqt8+FRwH/tAduFqzURo2epVBONefJ3qZgS783aLfD3ALqUQ
o0RT4Y8UPFJs81nJlubbg3BGTDETsD33XTJHZznB5WbVTTWueOh/JpHuRzt+v9UG
J0FjNjex5/kMHueBOd5NduS+GRK8G8Hv3OXURms/2Y4r5YpSLjgOI9VZc7OM8mZl
NVBIdTEr5xg0jE2TryefsnXdPcB56LVB985Qz7UBAXXVxrtIRQ9AcTpaEXhPoodb
xrzsQiq4WK5h+BPJiQCc3N10LM5PAExFCqLIKZNTF2vZptsjfBKAwqauqOZWIxlQ
rke3rMoR3KIgzv7gv8odv46oMdznfW37igg3ctQG/BuFHNOihfFttwA/ij4gFIpC
ayIWS2ERpK1HxEFJk+bWOorZJtKkZtoziwhjhgrWP0bUNeSzBIQ=
=e7OE
-----END PGP SIGNATURE-----

--qoe3tbzunmzj3cl4--
