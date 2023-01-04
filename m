Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16AC265E0A4
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 00:10:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234616AbjADXDJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 18:03:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229967AbjADXDH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 18:03:07 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37C139E;
        Wed,  4 Jan 2023 15:03:06 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4NnQB01lDCz4y0W;
        Thu,  5 Jan 2023 10:03:04 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1672873385;
        bh=YB0hJcpraawuKA1dE5txTbZJubHg4syLjM+ce6VinJI=;
        h=Date:From:To:Cc:Subject:From;
        b=U1l29gCWEE3CA0htK9qJVDQNQdqmJqpXjGX1STDqp07j8lwBzx8b/5hcBA+Vxn8eK
         QChZdv+lG67w9CDW8E3lpXD6LJTjwxlXKlGUfQkDfPZJ1V97wB03uooU3kS5dU0t0B
         7m7dcsqyVPz+pKPC4VL+OiToNPk1RbBnJHZprbF74HKUdrxPuVOyfNTtGFAKfj0VJx
         lqa2n3CmlGE8yMhBxQAezI7LYbmLHMSgyUdSXv8KcltS6O3poHqIDwRqSAXx+/g3TY
         QYiieDMPu7nfkuSAcJ+5n9/O4vOWroSqiFmpIlSwzczzO+XjYNdEvtSyefxEYtrnVs
         q71Uu9/NuZ9oQ==
Date:   Thu, 5 Jan 2023 10:03:02 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Daniel Lezcano <daniel.lezcano@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: linux-next: manual merge of the thermal tree with the pm tree
Message-ID: <20230105100302.00b1c5cd@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/Th_1jjRpUTa/0Qt/QlTJHeC";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/Th_1jjRpUTa/0Qt/QlTJHeC
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the thermal tree got a conflict in:

  drivers/thermal/intel/int340x_thermal/processor_thermal_device.c

between commit:

  d91a4714e54e ("thermal/int340x/processor_thermal: Use Intel TCC library")

from the pm tree and commit:

  e503a68ebfe3 ("thermal/intel/int340x: Replace parameter to simplify")

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

diff --cc drivers/thermal/intel/int340x_thermal/processor_thermal_device.c
index a2ea22f2bffd,317703027ce9..000000000000
--- a/drivers/thermal/intel/int340x_thermal/processor_thermal_device.c
+++ b/drivers/thermal/intel/int340x_thermal/processor_thermal_device.c
@@@ -118,22 -174,39 +118,18 @@@ static int proc_thermal_get_zone_temp(s
  	*temp =3D 0;
 =20
  	for_each_online_cpu(cpu) {
 -		err =3D rdmsr_safe_on_cpu(cpu, MSR_IA32_THERM_STATUS, &eax,
 -					&edx);
 -		if (err)
 -			goto err_ret;
 -		else {
 -			if (eax & 0x80000000) {
 -				curr_temp_off =3D (eax >> 16) & 0x7f;
 -				if (!*temp || curr_temp_off < *temp)
 -					*temp =3D curr_temp_off;
 -			} else {
 -				err =3D -EINVAL;
 -				goto err_ret;
 -			}
 -		}
 +		curr_temp =3D intel_tcc_get_temp(cpu, false);
 +		if (curr_temp < 0)
 +			return curr_temp;
 +		if (!*temp || curr_temp > *temp)
 +			*temp =3D curr_temp;
  	}
 =20
 -	return 0;
 -err_ret:
 -	return err;
 -}
 -
 -static int proc_thermal_get_zone_temp(struct thermal_zone_device *zone,
 -					 int *temp)
 -{
 -	int ret;
 -
 -	ret =3D read_temp_msr(temp);
 -	if (!ret)
 -		*temp =3D (stored_tjmax - *temp) * 1000;
 +	*temp *=3D 1000;
 =20
 -	return ret;
 +	return 0;
  }
 =20
- static struct thermal_zone_device_ops proc_thermal_local_ops =3D {
- 	.get_temp       =3D proc_thermal_get_zone_temp,
- };
-=20
  static int proc_thermal_read_ppcc(struct proc_thermal_device *proc_priv)
  {
  	int i;
@@@ -225,11 -298,12 +221,11 @@@ int proc_thermal_add(struct device *dev
  	status =3D acpi_evaluate_integer(adev->handle, "_TMP", NULL, &tmp);
  	if (ACPI_FAILURE(status)) {
  		/* there is no _TMP method, add local method */
 -		stored_tjmax =3D get_tjmax();
 -		if (stored_tjmax > 0)
 +		if (intel_tcc_get_tjmax(-1) > 0)
- 			ops =3D &proc_thermal_local_ops;
+ 			get_temp =3D proc_thermal_get_zone_temp;
  	}
 =20
- 	proc_priv->int340x_zone =3D int340x_thermal_zone_add(adev, ops);
+ 	proc_priv->int340x_zone =3D int340x_thermal_zone_add(adev, get_temp);
  	if (IS_ERR(proc_priv->int340x_zone)) {
  		return PTR_ERR(proc_priv->int340x_zone);
  	} else

--Sig_/Th_1jjRpUTa/0Qt/QlTJHeC
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmO2BaYACgkQAVBC80lX
0Gzw+wf9Gh6CpmkHgDqujTh8ujmvQavwIDZ6aTZ1av6xXKI+lwCdNpfhrJ7aSssB
z7vB70gFhmIHdhOKqR9gVq3zE0mzNCPrX47Hwo8ZIKCfMByK6cAs2TJSanunNDIi
1NolP8fJJ3T7b+qQq83QdNIP3wj1rhYKs13u3cWI2iXymQRimMIZOXSBGlRWSLIc
Y/JmisDSRkHYdVHs7sHAM/HAFzzl0b3UPi9DYbBUn6YxKy6hSujjoGuUpKiqkKfN
8x99VBm/VFolbEYbM6hufFF5sg2WFDYNFKn+5/SKoAp4Xvu3IAnLZzfLmjEECS9p
vNK3AC95PQ6IkZKSeruMg/GkqSdc5g==
=qDGI
-----END PGP SIGNATURE-----

--Sig_/Th_1jjRpUTa/0Qt/QlTJHeC--
