Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7513C610698
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 01:58:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235384AbiJ0X6J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 19:58:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbiJ0X6G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 19:58:06 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAFF6719BF;
        Thu, 27 Oct 2022 16:58:04 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Mz2gC1Qsxz4x1V;
        Fri, 28 Oct 2022 10:57:59 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1666915080;
        bh=ddrk81J8bHwCRad9ZM5gwOArNofx9a2KFHicAz+ouIc=;
        h=Date:From:To:Cc:Subject:From;
        b=RWKsvQBStioNmK5S90nGAkHGeQSQ/cdH0nKoINqdTlu/FTk7I/PHDYFVfmflU6eOu
         oyxVz09AoORPWaSd5IY8lvamT+QxwxCVQJSXepLYPvWymVGVM5UCQ9Vy0263QtagwO
         DNVBvOM8GGekl5nmEKwkzJqmrgF2yw9ETUHfeoZbxc3qgnoSPSbuiwQSmhsnIoKg+F
         erIjnZ6isfP4q4S+vEyIcCU0m+UJCp7aSrKZlbsPswME3EBNlMWxtETGUQ8NG2nQi/
         umyD+UedHPn6RBzbccuDFnTPu/YvlW4AdhC/d3Wu1nBHFz+5oWq72DP6J5hEKagcAp
         U581BMDOKzxDA==
Date:   Fri, 28 Oct 2022 10:57:57 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Alex Deucher <alexdeucher@gmail.com>,
        Dave Airlie <airlied@redhat.com>
Cc:     DRI <dri-devel@lists.freedesktop.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Yifan Zhang <yifan1.zhang@amd.com>,
        Zack Rusin <zackr@vmware.com>
Subject: linux-next: manual merge of the amdgpu tree with the drm tree
Message-ID: <20221028105757.123c05c9@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/AFy6pOsv//9MyZ397vV/N8=";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/AFy6pOsv//9MyZ397vV/N8=
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the amdgpu tree got a conflict in:

  drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c

between commit:

  7c99616e3fe7 ("drm: Remove drm_mode_config::fb_base")

from the drm tree and commit:

  887e8cec55f2 ("drm/amdgpu: set fb_modifiers_not_supported in vkms")

from the amdgpu tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c
index 09dec2561adf,500a1dc4fe02..000000000000
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c
@@@ -498,6 -498,10 +498,8 @@@ static int amdgpu_vkms_sw_init(void *ha
  	adev_to_drm(adev)->mode_config.preferred_depth =3D 24;
  	adev_to_drm(adev)->mode_config.prefer_shadow =3D 1;
 =20
 -	adev_to_drm(adev)->mode_config.fb_base =3D adev->gmc.aper_base;
 -
+ 	adev_to_drm(adev)->mode_config.fb_modifiers_not_supported =3D true;
+=20
  	r =3D amdgpu_display_modeset_create_props(adev);
  	if (r)
  		return r;

--Sig_/AFy6pOsv//9MyZ397vV/N8=
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmNbGwUACgkQAVBC80lX
0GzRNQf+OVrLfblP62Bj+U4EfeXhKTAuSeVAhuNfEDEpl8YrGQ6l1uBVe3FPjpR6
DaKO2cMY6W/EjClLH5LreDFKp5fZ3ChxYUHA1/FEiYrfyoetdBya0x85ioYA1tYq
mTzOCLEJ44P86BV0E4RhqriXJwbyRLdGlL+cZSmeZBhAE7j/sMavp1OhrosgyFF7
Go9SJ0qOVdHrBgemqUEj3b5T4xdjUGSZJ+oKV+UnWbb45J8hskOgxVB1kQRSJvg9
HRGxOYPFhIqvpQBDuC8ssjMPsFVQnPBjC2YcqPv4/4LikeYPNvgT7XbrHI6Y5GV+
AFnGhMXPqkPDIBi+SRYG0XyHKoykjg==
=XT7Y
-----END PGP SIGNATURE-----

--Sig_/AFy6pOsv//9MyZ397vV/N8=--
