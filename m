Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6198367DC46
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 03:28:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233481AbjA0C2K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 21:28:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233242AbjA0C2J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 21:28:09 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EC0542BF5;
        Thu, 26 Jan 2023 18:28:07 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4P31hP2vbqz4xN1;
        Fri, 27 Jan 2023 13:28:05 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1674786486;
        bh=DvR++yNqf5j2bKXvDXzXqvFKPNIHalGVvCBtT8bOoKs=;
        h=Date:From:To:Cc:Subject:From;
        b=GuBKfdcHIyWWLQm2TG/hdPWQJ1Zw4xMb7Bi6F3LttJfzp4TOdvZS7+uO/Th1rhA/r
         VR5GeucHuY6NT5i1Iusvm46wYTz3qrpgnUZMd0e3cZDW2eL9bmVJ9Wk6Y+mQKiDPNw
         ac1hLShhQKv4n4f1DmkdpRqWZcVc887PNGFnVyi9P9YCU4zx6jei224pavk2wwmuRZ
         iutQmvGtJSrNHxgr1VyKfks3lKhdXGMCvnDOArvNVk6WQR3yr8Y9HWMrSO/IkyJeM9
         jdyLYo6UeIK8JYvz1xhgqxBfpRnE3Jf/WLlHX+PQdV/xCkoA6O+WW7fu1uo8WXrR8h
         Xvjt7ONz1cz4A==
Date:   Fri, 27 Jan 2023 13:28:04 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Daniel Vetter <daniel.vetter@ffwll.ch>
Cc:     Intel Graphics <intel-gfx@lists.freedesktop.org>,
        DRI <dri-devel@lists.freedesktop.org>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>
Subject: linux-next: manual merge of the drm-misc tree with the
 drm-misc-fixes tree
Message-ID: <20230127132804.636960bb@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/uuTcGR_pR=i0SrKlg7E3+B/";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/uuTcGR_pR=i0SrKlg7E3+B/
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the drm-misc tree got a conflict in:

  drivers/gpu/drm/drm_fbdev_generic.c

between commits:

  cc88ad784e42 ("drm/fb-helper: Check fb_deferred_io_init() return value")
  d6591da5f3ff ("drm/fb-helper: Use a per-driver FB deferred I/O handler")

from the drm-misc-fixes tree and commit:

  6ca80b9e5cc0 ("drm/fbdev-generic: Rename struct fb_info 'fbi' to 'info'")

from the drm-misc tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc drivers/gpu/drm/drm_fbdev_generic.c
index bd1f8f28297c,43f94aa9e015..000000000000
--- a/drivers/gpu/drm/drm_fbdev_generic.c
+++ b/drivers/gpu/drm/drm_fbdev_generic.c
@@@ -200,31 -189,25 +184,31 @@@ static int drm_fbdev_fb_probe(struct dr
  	fb_helper->fb =3D buffer->fb;
  	fb =3D buffer->fb;
 =20
- 	fbi =3D drm_fb_helper_alloc_info(fb_helper);
- 	if (IS_ERR(fbi))
- 		return PTR_ERR(fbi);
+ 	info =3D drm_fb_helper_alloc_info(fb_helper);
+ 	if (IS_ERR(info))
+ 		return PTR_ERR(info);
 =20
- 	fbi->fbops =3D &drm_fbdev_fb_ops;
- 	fbi->screen_size =3D sizes->surface_height * fb->pitches[0];
- 	fbi->fix.smem_len =3D fbi->screen_size;
- 	fbi->flags =3D FBINFO_DEFAULT;
+ 	info->fbops =3D &drm_fbdev_fb_ops;
+ 	info->screen_size =3D sizes->surface_height * fb->pitches[0];
+ 	info->fix.smem_len =3D info->screen_size;
+ 	info->flags =3D FBINFO_DEFAULT;
 =20
- 	drm_fb_helper_fill_info(fbi, fb_helper, sizes);
+ 	drm_fb_helper_fill_info(info, fb_helper, sizes);
 =20
  	if (drm_fbdev_use_shadow_fb(fb_helper)) {
- 		fbi->screen_buffer =3D vzalloc(fbi->screen_size);
- 		if (!fbi->screen_buffer)
+ 		info->screen_buffer =3D vzalloc(info->screen_size);
+ 		if (!info->screen_buffer)
  			return -ENOMEM;
- 		fbi->flags |=3D FBINFO_VIRTFB | FBINFO_READS_FAST;
+ 		info->flags |=3D FBINFO_VIRTFB | FBINFO_READS_FAST;
 =20
 -		info->fbdefio =3D &drm_fbdev_defio;
 -		fb_deferred_io_init(info);
 +		/* Set a default deferred I/O handler */
 +		fb_helper->fbdefio.delay =3D HZ / 20;
 +		fb_helper->fbdefio.deferred_io =3D drm_fb_helper_deferred_io;
 +
- 		fbi->fbdefio =3D &fb_helper->fbdefio;
- 		ret =3D fb_deferred_io_init(fbi);
++		info->fbdefio =3D &fb_helper->fbdefio;
++		ret =3D fb_deferred_io_init(info);
 +		if (ret)
 +			return ret;
  	} else {
  		/* buffer is mapped for HW framebuffer */
  		ret =3D drm_client_buffer_vmap(fb_helper->buffer, &map);

--Sig_/uuTcGR_pR=i0SrKlg7E3+B/
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmPTNrQACgkQAVBC80lX
0GyWXAf+OHhK8GDvQmPeit0XGXCqRhnV89RNnebh0SmsRLp3Eft/z8y7sayTC3eN
3nN3Pd8YJRPe+0kHC5FV7zXDW/ZV3gnoTtj72pekA0sMVTQVwzH9GfamLew7DQMv
rsNp6xvXPQ8mxRrY74wqgcoDlOqLomFXwDdhiZ9btc6rUv9uuKsqb4F54sJRoDAe
HBzd8x10ykgsTM98YJWaA2kJEfkXXuhy0DfCrTFkLxrGgiuNe8RDNP1LDZ17wnbX
JHcMv1oT9dK9ed+Ig9unRsAVE3jk+MUFWnrADhAlqNXXVrdD4zXLPG+C2F/K++0w
3LIwJ5d1HwdKwqphJikcdLsv9IUeQw==
=ZvkD
-----END PGP SIGNATURE-----

--Sig_/uuTcGR_pR=i0SrKlg7E3+B/--
