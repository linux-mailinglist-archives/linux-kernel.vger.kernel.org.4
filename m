Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FDD7736133
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 03:38:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229632AbjFTBiI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 21:38:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjFTBiH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 21:38:07 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13592119;
        Mon, 19 Jun 2023 18:38:04 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4QlTmC05Myz4wgk;
        Tue, 20 Jun 2023 11:38:02 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1687225083;
        bh=4KyqwkMLpA8d4g7V9+oDFKaAaBX3iSBt4eegpKSuZXc=;
        h=Date:From:To:Cc:Subject:From;
        b=GLc/ZVkjdiPtAfg9Sl/qnh5Jeljw+7FUTI67co5wH1IzQfuxbjbxQvjpyZ6kz4peY
         pMuubEErgtBz9msOEFk1t98HcDOMTs+vqgeU89tny+jJKBSr869F4tPioGuR7s0fly
         l6ewdWkcNekUB11ZCAhIUfvjywI7JL5SFdoyHx0wohw0trl8RKbalTdB3Sz9YYrDkQ
         C8Lm3Y67c5qjW1sEmoi59KQ57ZqDUUxa7haG16sfl4QE1MwPHgI5+U9A0HxzIkjm86
         UJU5H0o8onxPSUhMgdZFJXwPsP8PE5pm77YwmAAx8NyOWxbS6+8+F9czVGeXOGiR9J
         TZQGaqbjt61gg==
Date:   Tue, 20 Jun 2023 11:38:00 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Helge Deller <deller@gmx.de>, Dave Airlie <airlied@redhat.com>
Cc:     DRI <dri-devel@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>
Subject: linux-next: manual merge of the fbdev tree with the drm tree
Message-ID: <20230620113800.5e76a964@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/qYumKycpnKA=iqL9zaIm9aI";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/qYumKycpnKA=iqL9zaIm9aI
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the fbdev tree got a conflict in:

  drivers/video/fbdev/hitfb.c

between commit:

  bb47f218fd01 ("fbdev/hitfb: Cast I/O offset to address")

from the drm tree and commit:

  dadeeffbe525 ("fbdev: hitfb: Use NULL for pointers")

from the fbdev tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc drivers/video/fbdev/hitfb.c
index 7737923b7a0a,5f544a177033..000000000000
--- a/drivers/video/fbdev/hitfb.c
+++ b/drivers/video/fbdev/hitfb.c
@@@ -444,10 -428,10 +444,10 @@@ static int hitfb_suspend(struct device=20
  {
  	u16 v;
 =20
- 	hitfb_blank(1,0);
+ 	hitfb_blank(1, NULL);
 -	v =3D fb_readw(HD64461_STBCR);
 +	v =3D hitfb_readw(HD64461_STBCR);
  	v |=3D HD64461_STBCR_SLCKE_IST;
 -	fb_writew(v, HD64461_STBCR);
 +	hitfb_writew(v, HD64461_STBCR);
 =20
  	return 0;
  }
@@@ -456,13 -440,13 +456,13 @@@ static int hitfb_resume(struct device *
  {
  	u16 v;
 =20
 -	v =3D fb_readw(HD64461_STBCR);
 +	v =3D hitfb_readw(HD64461_STBCR);
  	v &=3D ~HD64461_STBCR_SLCKE_OST;
  	msleep(100);
 -	v =3D fb_readw(HD64461_STBCR);
 +	v =3D hitfb_readw(HD64461_STBCR);
  	v &=3D ~HD64461_STBCR_SLCKE_IST;
 -	fb_writew(v, HD64461_STBCR);
 +	hitfb_writew(v, HD64461_STBCR);
- 	hitfb_blank(0,0);
+ 	hitfb_blank(0, NULL);
 =20
  	return 0;
  }

--Sig_/qYumKycpnKA=iqL9zaIm9aI
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmSRAvgACgkQAVBC80lX
0GySsQf7BWsuWkG09mM1yj5GkzofDWLSNeehyg1YSbzCLtQPlroldzHeApLNNGbX
2LWoXyXwYhemgA5PYN6uqIg9qzSmsrmYa0T/+6vNZt6rBKgiS4dhVZoppyUQAfcz
m6bMdCXnKzUR+4xXz8HR1SIE3S8gvY7wyM2d7shahdgHbmqmLZsLmbroacIhjjaN
PHSa7Eaa2yRl2nSaewY3IwgXOCKpqXY2pccw8o366PiauUDvcCb/H5sYprZJQcYT
PKDET2QryaEx4mGfqaws1hF8xfoFny52iEENuMMsCov2RhfZe8Hb6BOi6iBXEQMl
AWXlZ+WuePmORLxZzO/fC+K2Ate1KQ==
=et4K
-----END PGP SIGNATURE-----

--Sig_/qYumKycpnKA=iqL9zaIm9aI--
