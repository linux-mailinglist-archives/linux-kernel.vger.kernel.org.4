Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C72E65E0C5
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 00:17:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234920AbjADXLW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 18:11:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234716AbjADXLG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 18:11:06 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9325A3AAB0;
        Wed,  4 Jan 2023 15:11:00 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4NnQM36fTqz4y0B;
        Thu,  5 Jan 2023 10:10:55 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1672873856;
        bh=PXmp30zvcQFuC4GZ4OQKzqf2SY2TOmoGmQfIS836Mk4=;
        h=Date:From:To:Cc:Subject:From;
        b=P02N9hEwJtnIHrFJsoz+YVboyOAximFh21q16HeQgQxf8Hkw1tCMvTVSRHyQiDGTA
         yqYn1vAbnfdON+X3TrZAI+e4k5eFqVXv42k130sWfRO/WDcMHuHLPm2pePs8YQduXt
         1IEU2rovZx83v8ksLCSSOFm/0GsK9fhEGY7m4S6TGugVKULOt2e+GdpUbeTZXZFxUp
         T8GbibnE6V/4m3rqE5+eVeScoLmh/1AwalU0LqmuCb9FL2a3IZf9jja9N+WtkPRlNG
         3jRh2woZ6afwIFR587FSkYnk3fRPzh1wpwaEolXMVrqnqvCJiZ53J2wNEWqgxsd69C
         lfjlcuQ7sPpKw==
Date:   Thu, 5 Jan 2023 10:10:54 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Daniel Lezcano <daniel.lezcano@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: linux-next: manual merge of the thermal tree with the pm tree
Message-ID: <20230105101054.108ad186@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/3H73zaCamYyexIuG.r.mt0F";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/3H73zaCamYyexIuG.r.mt0F
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the thermal tree got a conflict in:

  drivers/thermal/intel/x86_pkg_temp_thermal.c

between commit:

  58374a3970a0 ("thermal/x86_pkg_temp_thermal: Add support for handling dyn=
amic tjmax")

from the pm tree and commit:

  03b2e86a24aa ("thermal/drivers/intel: Use generic thermal_zone_get_trip()=
 function")

from the thermal tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc drivers/thermal/intel/x86_pkg_temp_thermal.c
index 9e08d8c8f5fb,494f25250c2d..000000000000
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
@@@ -338,10 -348,17 +333,16 @@@ static int pkg_temp_thermal_device_add(
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

--Sig_/3H73zaCamYyexIuG.r.mt0F
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmO2B38ACgkQAVBC80lX
0Gw6zggAjSGDyNXC9fM0Mll+GJEY6FWLzbpkTkdHFePxt5VUH+0lZpGiLGX9hsoT
OpEqcLTPIzBhi7tjhE4FYl7WdPG7GoJyuv/NUfgw/I6bW90gcoh3VRffnOAqoFbv
UYNvKawZPci45Gie7AoeiXKEV+4JOQaf1S1YGZt1+sGv2Y6I9JdNBAIFpbEJWnEu
ZqtyQ0UHS7Qa7PTb6dr1oPZ2HAZK1QR+mdRI9c1dKjQ0Q5ldFYGltwYj7kjOkicR
Y7beHM9Tr9Y1DfQTXRqKJVnMAhrKMUe8+EtMG4eZboT/qedYz/Pcj1vxwAuKC95l
L6DGi4PskUAvJAijG7Mc4NYyJiO2NA==
=9aP7
-----END PGP SIGNATURE-----

--Sig_/3H73zaCamYyexIuG.r.mt0F--
