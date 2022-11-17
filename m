Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E764662D423
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 08:32:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239365AbiKQHcZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 02:32:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239318AbiKQHcX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 02:32:23 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56B645E9F2;
        Wed, 16 Nov 2022 23:32:21 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4NCWp96HpFz4xGH;
        Thu, 17 Nov 2022 18:32:17 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1668670339;
        bh=q0FbdAqaG0HNIjHKwNowfghEhjynAez7A03pBstoQU0=;
        h=Date:From:To:Cc:Subject:From;
        b=KhymOuqAGJV6FLwllpoWvdHL3c6MPLTEPt6wzaRAARKGgKnZC1vPW8zU+8yfuorhg
         kLhWjuukYjimYj9XUz3EpMO8+wvSziCXSVI1/CZZC3+QEnkrogBkwV/Lc8kaO4mODp
         OGOdnkNSZHS/40YQF7Jb41P51BjHuluYhT8x0rGG0y4XXWQOopjjHGmuvaYFqbQAMs
         awFoU/CbewKhxjgTWc1Vh65i+CIkVrJZ8c0OOl8pdm9xqeAd+C4Zur1Q0Cj+EW081B
         3rnPWpZizIf5R0zG+3D3/jlOS+7VGmyLH2Zl0OvtI+rIX13m6Kw3FOJFWQ7tLZeNhk
         E7ooCiVbw9uSw==
Date:   Thu, 17 Nov 2022 18:32:14 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Daniel Vetter <daniel.vetter@ffwll.ch>
Cc:     Thomas Zimmermann <tzimmermann@suse.de>,
        Intel Graphics <intel-gfx@lists.freedesktop.org>,
        DRI <dri-devel@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the drm-misc tree
Message-ID: <20221117183214.2473e745@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/wjNg7IVu0VNo1vCy4/HXkgH";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/wjNg7IVu0VNo1vCy4/HXkgH
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the drm-misc tree, today's linux-next build (powerpc
ppc44x_defconfig) failed like this:

ld: drivers/video/fbdev/core/fbmon.o: in function `fb_modesetting_disabled':
fbmon.c:(.text+0x1e4): multiple definition of `fb_modesetting_disabled'; dr=
ivers/video/fbdev/core/fbmem.o:fbmem.c:(.text+0x1bac): first defined here
ld: drivers/video/fbdev/core/fbcmap.o: in function `fb_modesetting_disabled=
':
fbcmap.c:(.text+0x478): multiple definition of `fb_modesetting_disabled'; d=
rivers/video/fbdev/core/fbmem.o:fbmem.c:(.text+0x1bac): first defined here
ld: drivers/video/fbdev/core/fbsysfs.o: in function `fb_modesetting_disable=
d':
fbsysfs.c:(.text+0xb64): multiple definition of `fb_modesetting_disabled'; =
drivers/video/fbdev/core/fbmem.o:fbmem.c:(.text+0x1bac): first defined here
ld: drivers/video/fbdev/core/modedb.o: in function `fb_modesetting_disabled=
':
modedb.c:(.text+0x129c): multiple definition of `fb_modesetting_disabled'; =
drivers/video/fbdev/core/fbmem.o:fbmem.c:(.text+0x1bac): first defined here
ld: drivers/video/fbdev/core/fbcvt.o: in function `fb_modesetting_disabled':
fbcvt.c:(.text+0x0): multiple definition of `fb_modesetting_disabled'; driv=
ers/video/fbdev/core/fbmem.o:fbmem.c:(.text+0x1bac): first defined here

Caused by commit

  0ba2fa8cbd29 ("fbdev: Add support for the nomodeset kernel parameter")

This build does not have CONFIG_VIDEO_NOMODESET set.

I applied the following patch for today.

=46rom 63f957a050c62478ed1348c5b204bc65c68df4d7 Mon Sep 17 00:00:00 2001
From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Thu, 17 Nov 2022 18:19:22 +1100
Subject: [PATCH] fix up for "fbdev: Add support for the nomodeset kernel pa=
rameter"

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 include/linux/fb.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/fb.h b/include/linux/fb.h
index 3a822e4357b1..ea421724f733 100644
--- a/include/linux/fb.h
+++ b/include/linux/fb.h
@@ -807,7 +807,7 @@ extern int fb_find_mode(struct fb_var_screeninfo *var,
 #if defined(CONFIG_VIDEO_NOMODESET)
 bool fb_modesetting_disabled(const char *drvname);
 #else
-bool fb_modesetting_disabled(const char *drvname)
+static inline bool fb_modesetting_disabled(const char *drvname)
 {
 	return false;
 }
--=20
2.35.1

--=20
Cheers,
Stephen Rothwell

--Sig_/wjNg7IVu0VNo1vCy4/HXkgH
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmN1434ACgkQAVBC80lX
0Gy73gf/bE1WqkOYNnd03HSmw1cf24Ym206L30fBc7j1ARYlcmBfl/RBOwERxccN
rtP7JkTzYkOI1lcGwSqWkzUUf4Y8SK0z4ZawWnXJ3OIyN8PMC6fjrFQBAvjvuB3l
wYnRs/a2E+kj7bijRu6Ad/oF3BXJ/oXY8vC85MNz/1NQmFxLOitpghLuXu0obG7P
bhjmG/LddlNVgUjkyNijTqH9Dm+DID2+zfOd67Z93OUs2Rm0wteJdRaneRXXmcuI
0OBL0y67tstzrAYCGEQRoqJTWKA/GDlIkvBcHpnTL5Vl8COZBukwu7OY8CipO+ym
z6fSdt1WjmGNOG0KetVbrxPa2Kx1iQ==
=L3k7
-----END PGP SIGNATURE-----

--Sig_/wjNg7IVu0VNo1vCy4/HXkgH--
