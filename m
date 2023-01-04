Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FB4E65E0FA
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 00:36:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234469AbjADXf1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 18:35:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230312AbjADXfZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 18:35:25 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 099CC42604;
        Wed,  4 Jan 2023 15:35:23 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4NnQvD5qPTz4y0Q;
        Thu,  5 Jan 2023 10:35:20 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1672875321;
        bh=yPWtUWuhKT5LMYjyGA+k1TObWc9g/oFcO/5wrE8UDlw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=B95rxWOf0rhsimoqMfO0IFGZ/Q7TS0tXcE62nYxDjJxFrLCRZ4sCNSOZe7eV1XZSm
         f8HfzvoEAvHlb5YnlZuzdAOEQ9/sI9C/dn7DIJO2TZofUohuCACIEP/tAHExhoL8U6
         amNeVQsiR+OtiAYYBzbHpzRlrVPrqIJh2nYIrUtKtHGoa405dpQ9WwhNgye9qBbMo1
         NvJoaH2xP/Pwq5+/3ys+XYcZDVrcQY7u+hU6l/f7OxZJ8gRQvmVCb49fEi869YOrgJ
         QCwZeEOvuKbosdEWmcIdgNSMZfzXGpWkgNf1dINufztFGUkuRHRHzhdq2Ig9uV2TiA
         x3D3fa9Qf9pZQ==
Date:   Thu, 5 Jan 2023 10:35:19 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Daniel Lezcano <daniel.lezcano@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: Re: linux-next: manual merge of the thermal tree with the pm tree
Message-ID: <20230105103519.4e849420@canb.auug.org.au>
In-Reply-To: <20230105101054.108ad186@canb.auug.org.au>
References: <20230105101054.108ad186@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/cxUdS2=HvIhlCp64bT_L5XX";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/cxUdS2=HvIhlCp64bT_L5XX
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Thu, 5 Jan 2023 10:10:54 +1100 Stephen Rothwell <sfr@canb.auug.org.au> w=
rote:
>=20
> Today's linux-next merge of the thermal tree got a conflict in:
>=20
>   drivers/thermal/intel/x86_pkg_temp_thermal.c
>=20
> between commit:
>=20
>   58374a3970a0 ("thermal/x86_pkg_temp_thermal: Add support for handling d=
ynamic tjmax")
>=20
> from the pm tree and commit:
>=20
>   03b2e86a24aa ("thermal/drivers/intel: Use generic thermal_zone_get_trip=
() function")
>=20
> from the thermal tree.
>=20
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.

Actually, the resolution I needed was this:

diff --cc drivers/thermal/intel/x86_pkg_temp_thermal.c
index 9e08d8c8f5fb,494f25250c2d..24c7774cc4a9
--- a/drivers/thermal/intel/x86_pkg_temp_thermal.c
+++ b/drivers/thermal/intel/x86_pkg_temp_thermal.c
@@@ -107,56 -108,37 +108,17 @@@ static struct zone_device *pkg_temp_the
  static int sys_get_curr_temp(struct thermal_zone_device *tzd, int *temp)
  {
  	struct zone_device *zonedev =3D tzd->devdata;
 -	u32 eax, edx;
 +	int val;
 =20
 -	rdmsr_on_cpu(zonedev->cpu, MSR_IA32_PACKAGE_THERM_STATUS,
 -			&eax, &edx);
 -	if (eax & 0x80000000) {
 -		*temp =3D zonedev->tj_max - ((eax >> 16) & 0x7f) * 1000;
 -		pr_debug("sys_get_curr_temp %d\n", *temp);
 -		return 0;
 -	}
 -	return -EINVAL;
 +	val =3D intel_tcc_get_temp(zonedev->cpu, true);
 +	if (val < 0)
 +		return val;
 +
 +	*temp =3D val * 1000;
 +	pr_debug("sys_get_curr_temp %d\n", *temp);
 +	return 0;
  }
 =20
- static int sys_get_trip_temp(struct thermal_zone_device *tzd,
- 			     int trip, int *temp)
- {
- 	struct zone_device *zonedev =3D tzd->devdata;
- 	unsigned long thres_reg_value;
- 	u32 mask, shift, eax, edx;
- 	int tj_max, ret;
-=20
- 	if (trip >=3D MAX_NUMBER_OF_TRIPS)
- 		return -EINVAL;
-=20
- 	if (trip) {
- 		mask =3D THERM_MASK_THRESHOLD1;
- 		shift =3D THERM_SHIFT_THRESHOLD1;
- 	} else {
- 		mask =3D THERM_MASK_THRESHOLD0;
- 		shift =3D THERM_SHIFT_THRESHOLD0;
- 	}
-=20
- 	tj_max =3D intel_tcc_get_tjmax(zonedev->cpu);
- 	if (tj_max < 0)
- 		return tj_max;
- 	tj_max *=3D 1000;
-=20
- 	ret =3D rdmsr_on_cpu(zonedev->cpu, MSR_IA32_PACKAGE_THERM_INTERRUPT,
- 			   &eax, &edx);
- 	if (ret < 0)
- 		return ret;
-=20
- 	thres_reg_value =3D (eax & mask) >> shift;
- 	if (thres_reg_value)
- 		*temp =3D tj_max - thres_reg_value * 1000;
- 	else
- 		*temp =3D THERMAL_TEMP_INVALID;
- 	pr_debug("sys_get_trip_temp %d\n", *temp);
-=20
- 	return 0;
- }
-=20
  static int
  sys_set_trip_temp(struct thermal_zone_device *tzd, int trip, int temp)
  {
@@@ -330,18 -340,25 +325,25 @@@ static int pkg_temp_thermal_device_add(
 =20
  	thres_count =3D clamp_val(thres_count, 0, MAX_NUMBER_OF_TRIPS);
 =20
- 	err =3D intel_tcc_get_tjmax(cpu);
- 	if (err < 0)
 -	err =3D get_tj_max(cpu, &tj_max);
 -	if (err)
--		return err;
++	tj_max =3D intel_tcc_get_tjmax(cpu);
++	if (tj_max < 0)
++		return tj_max;
++	tj_max *=3D 1000;
 =20
  	zonedev =3D kzalloc(sizeof(*zonedev), GFP_KERNEL);
  	if (!zonedev)
  		return -ENOMEM;
 =20
+ 	zonedev->trips =3D pkg_temp_thermal_trips_init(cpu, tj_max, thres_count);
+ 	if (IS_ERR(zonedev->trips)) {
+ 		err =3D PTR_ERR(zonedev->trips);
+ 		goto out_kfree_zonedev;
+ 	}
+=20
  	INIT_DELAYED_WORK(&zonedev->work, pkg_temp_thermal_threshold_work_fn);
  	zonedev->cpu =3D cpu;
- 	zonedev->tzone =3D thermal_zone_device_register("x86_pkg_temp",
- 			thres_count,
 -	zonedev->tj_max =3D tj_max;
+ 	zonedev->tzone =3D thermal_zone_device_register_with_trips("x86_pkg_temp=
",
+ 			zonedev->trips, thres_count,
  			(thres_count =3D=3D MAX_NUMBER_OF_TRIPS) ? 0x03 : 0x01,
  			zonedev, &tzone_ops, &pkg_temp_tz_params, 0, 0);
  	if (IS_ERR(zonedev->tzone)) {

--=20
Cheers,
Stephen Rothwell

--Sig_/cxUdS2=HvIhlCp64bT_L5XX
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmO2DTcACgkQAVBC80lX
0Gwk5ggAlDLN0jQ8yc4u3iD1B8OXVew2BvXEKREM0tu5DHXUuvaR/JDq6IYj9MJT
k2yszqpnPXfjtowNJMR1b4icL4K1Mu36JQIX9eLSsXUAvM5fbMt/Gkzoh4ltPyEe
O/rI6rcyilXkpGt6jHFuNwBVDsSmCs1c4AdEXxPmgQ8rKEofwlXRWbLWrpJKJzk7
iqdyomxVRh/8W7uviD0UA9+HzdFMmn9akWKEejkiaf4K0+RQN/tWEaYVlT8ifIe8
N3YDng9dLS2rDRM3ml+fBmhP20TbD/17AV5PmqXzP12aAwolZuos6gfXpOYe43kw
4jHqGtWxlzqEnV7jFV7jwr8DnUG2Jw==
=eVLW
-----END PGP SIGNATURE-----

--Sig_/cxUdS2=HvIhlCp64bT_L5XX--
