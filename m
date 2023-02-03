Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A36A7689899
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 13:29:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232338AbjBCM2e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 07:28:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230230AbjBCM2c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 07:28:32 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4F734589B;
        Fri,  3 Feb 2023 04:28:29 -0800 (PST)
Received: from mercury (unknown [37.81.13.16])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 551486602F05;
        Fri,  3 Feb 2023 12:28:28 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1675427308;
        bh=ankdsVif0d1fL7mCl4lDLRZ/vP8sTysjLt9IkEZZA68=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gsrM4qTv8muDL6w1MWLad5latEjV4BmBVyb8ohp+2aTrUWOfkMkBcdduSywtxMkOP
         AjoC6EDldkPJ/v+cMSwE4BAKAXiy6rKwM7jyyG9DpwnbC5zvZIvwqWsYspgbRoHqih
         Xh8QpD+dZeLHg6tZaoHwc+/Ol1n34U4+zs4ituEXycN1d6Y8dZq0KWAHIasvTf27A6
         mI8gW0pzwX5ydwufkQCTU5PotXxE6b5R2THzFzG4NAR74rZddQ0/QcKk/HadJLG8nd
         96HGLCsupa55OmRA45imAeaSPsNB1RUso8ZixLucWCF55PAYJSU7pxBulcS+kr+k7e
         EFjYSuvKFFtWg==
Received: by mercury (Postfix, from userid 1000)
        id 5DC7F1060930; Fri,  3 Feb 2023 13:28:25 +0100 (CET)
Date:   Fri, 3 Feb 2023 13:28:25 +0100
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Andreas Kemnade <andreas@kemnade.info>
Cc:     error27@gmail.com, rafael.j.wysocki@intel.com,
        anton.vorontsov@linaro.org, ramakrishna.pallala@intel.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        hns@goldelico.com
Subject: Re: [PATCH] power: supply: disable faulty cooling logic
Message-ID: <20230203122825.c2zlrdgavcn3jpsj@mercury.elektranox.org>
References: <20230121111621.2821558-1-andreas@kemnade.info>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="r7tju7gzfh3z3k6p"
Content-Disposition: inline
In-Reply-To: <20230121111621.2821558-1-andreas@kemnade.info>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--r7tju7gzfh3z3k6p
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sat, Jan 21, 2023 at 12:16:21PM +0100, Andreas Kemnade wrote:
> The rn5t618 power driver fails to register
> a cooling device because POWER_SUPPLY_PROP_CHARGE_CONTROL_LIMIT_MAX
> is missing but availability is not checked before registering
> cooling device. After improved error checking in the thermal
> code, the registration of the power supply fails entirely.
>=20
> Checking for availability of _MAX before registering cooling device
> fixes the rn5t618 problem. But the whole logic feels questionable.
>=20
> First, the logic is inverted here:
> the code tells: max_current =3D max_cooling but
> 0 =3D max_cooling, so there needs to be some inversion
> in the code which cannot be found. Comparing with other
> cooling devices, it can be found that value for fan speed is not
> inverted, value for cpufreq cooling is inverted (similar situation
> as here lowest frequency =3D max cooling)
>=20
> Second, analyzing usage of _MAX: it is seems that maximum capabilities
> of charging controller are specified and not of the battery. Probably
> there is not too much mismatch in the drivers actually implementing
> that. So nothing has exploded yet.  So there is no easy and safe way
> to specifify a max cooling value now.
>=20
> Conclusion for now (as a regression fix) just remove the cooling device
> registration and do it properly later on.
>=20
> Fixes: e49a1e1ee078 ("thermal/core: fix error code in __thermal_cooling_d=
evice_register()")
> Fixes: 952aeeb3ee28 ("power_supply: Register power supply for thermal coo=
ling device")
> Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
> ---

Thanks, queued to for-next.

-- Sebastian

>  drivers/power/supply/power_supply_core.c | 93 ------------------------
>  1 file changed, 93 deletions(-)
>=20
> diff --git a/drivers/power/supply/power_supply_core.c b/drivers/power/sup=
ply/power_supply_core.c
> index 7c790c41e2fe..cc5b2e22b42a 100644
> --- a/drivers/power/supply/power_supply_core.c
> +++ b/drivers/power/supply/power_supply_core.c
> @@ -1186,83 +1186,6 @@ static void psy_unregister_thermal(struct power_su=
pply *psy)
>  	thermal_zone_device_unregister(psy->tzd);
>  }
> =20
> -/* thermal cooling device callbacks */
> -static int ps_get_max_charge_cntl_limit(struct thermal_cooling_device *t=
cd,
> -					unsigned long *state)
> -{
> -	struct power_supply *psy;
> -	union power_supply_propval val;
> -	int ret;
> -
> -	psy =3D tcd->devdata;
> -	ret =3D power_supply_get_property(psy,
> -			POWER_SUPPLY_PROP_CHARGE_CONTROL_LIMIT_MAX, &val);
> -	if (ret)
> -		return ret;
> -
> -	*state =3D val.intval;
> -
> -	return ret;
> -}
> -
> -static int ps_get_cur_charge_cntl_limit(struct thermal_cooling_device *t=
cd,
> -					unsigned long *state)
> -{
> -	struct power_supply *psy;
> -	union power_supply_propval val;
> -	int ret;
> -
> -	psy =3D tcd->devdata;
> -	ret =3D power_supply_get_property(psy,
> -			POWER_SUPPLY_PROP_CHARGE_CONTROL_LIMIT, &val);
> -	if (ret)
> -		return ret;
> -
> -	*state =3D val.intval;
> -
> -	return ret;
> -}
> -
> -static int ps_set_cur_charge_cntl_limit(struct thermal_cooling_device *t=
cd,
> -					unsigned long state)
> -{
> -	struct power_supply *psy;
> -	union power_supply_propval val;
> -	int ret;
> -
> -	psy =3D tcd->devdata;
> -	val.intval =3D state;
> -	ret =3D psy->desc->set_property(psy,
> -		POWER_SUPPLY_PROP_CHARGE_CONTROL_LIMIT, &val);
> -
> -	return ret;
> -}
> -
> -static const struct thermal_cooling_device_ops psy_tcd_ops =3D {
> -	.get_max_state =3D ps_get_max_charge_cntl_limit,
> -	.get_cur_state =3D ps_get_cur_charge_cntl_limit,
> -	.set_cur_state =3D ps_set_cur_charge_cntl_limit,
> -};
> -
> -static int psy_register_cooler(struct power_supply *psy)
> -{
> -	/* Register for cooling device if psy can control charging */
> -	if (psy_has_property(psy->desc, POWER_SUPPLY_PROP_CHARGE_CONTROL_LIMIT)=
) {
> -		psy->tcd =3D thermal_cooling_device_register(
> -			(char *)psy->desc->name,
> -			psy, &psy_tcd_ops);
> -		return PTR_ERR_OR_ZERO(psy->tcd);
> -	}
> -
> -	return 0;
> -}
> -
> -static void psy_unregister_cooler(struct power_supply *psy)
> -{
> -	if (IS_ERR_OR_NULL(psy->tcd))
> -		return;
> -	thermal_cooling_device_unregister(psy->tcd);
> -}
>  #else
>  static int psy_register_thermal(struct power_supply *psy)
>  {
> @@ -1272,15 +1195,6 @@ static int psy_register_thermal(struct power_suppl=
y *psy)
>  static void psy_unregister_thermal(struct power_supply *psy)
>  {
>  }
> -
> -static int psy_register_cooler(struct power_supply *psy)
> -{
> -	return 0;
> -}
> -
> -static void psy_unregister_cooler(struct power_supply *psy)
> -{
> -}
>  #endif
> =20
>  static struct power_supply *__must_check
> @@ -1354,10 +1268,6 @@ __power_supply_register(struct device *parent,
>  	if (rc)
>  		goto register_thermal_failed;
> =20
> -	rc =3D psy_register_cooler(psy);
> -	if (rc)
> -		goto register_cooler_failed;
> -
>  	rc =3D power_supply_create_triggers(psy);
>  	if (rc)
>  		goto create_triggers_failed;
> @@ -1387,8 +1297,6 @@ __power_supply_register(struct device *parent,
>  add_hwmon_sysfs_failed:
>  	power_supply_remove_triggers(psy);
>  create_triggers_failed:
> -	psy_unregister_cooler(psy);
> -register_cooler_failed:
>  	psy_unregister_thermal(psy);
>  register_thermal_failed:
>  wakeup_init_failed:
> @@ -1540,7 +1448,6 @@ void power_supply_unregister(struct power_supply *p=
sy)
>  	sysfs_remove_link(&psy->dev.kobj, "powers");
>  	power_supply_remove_hwmon_sysfs(psy);
>  	power_supply_remove_triggers(psy);
> -	psy_unregister_cooler(psy);
>  	psy_unregister_thermal(psy);
>  	device_init_wakeup(&psy->dev, false);
>  	device_unregister(&psy->dev);
> --=20
> 2.30.2
>=20

--r7tju7gzfh3z3k6p
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmPc/eUACgkQ2O7X88g7
+pokWw/+KC7J17Uoki3HceBrHKmRAJNf/kqKdD0x0oXN3lBUaiRZaGL32S4eD8qd
MTOIjmFMWJ/311Cj9961ixWP0beb+faI9GqAriH6nfvdjlZLgMtD1Ms2HQWsqkFQ
7RPzQbHgrfAsQH+2W8ykoiyqHkR/my+ix5fa0z3MIyRrnLclpDEa7w97uL9mePoH
hBLDXYeRjJNX/hZBFHLXJo1NfYt69t1HPF01LGsp2p2dTkBBZak+Teskb9/tU1GH
kvo7Yn8dX5Q8JXc1jWeSdstP31KwbMhbldKWCCPF08Kd4/9lLUraxf/OoMsPvf/2
qEo/5Z1TdE2QaTF8DKrnnBTUq72tJ8hagaWAUVdSQ1CeIAJ/2HCl9gEK8z8zGbBa
GzFltmMWbEfFpIeiWutqWL5LrnNjL/QXz2jzB8sgeB3vYJHe468uwrpzYaaL5tlK
cteW/IlLr9muetdLS8EY8VNpfRip57waAr9glA2BxA57SST8bB6fOHlXfznmTT0+
NW6HkStF8+YHcsvsDEAeTSAOftulYtJWzW85xym56PWascjkg1lkUE7iUR0AHFz5
TBIEmgT9Jay+RsURJ9ojFbe48C1Go7tNNViSME8h8zqjdTh3khg49iP0woBSgkJE
TWRh+HHjwNfE/fvXm7jg4EtLRGuhug5qzTUgdHOsSDQWF4F3Khk=
=XKPb
-----END PGP SIGNATURE-----

--r7tju7gzfh3z3k6p--
