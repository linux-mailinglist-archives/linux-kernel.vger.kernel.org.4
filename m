Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 075266451A9
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 03:01:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229923AbiLGCBv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 21:01:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229782AbiLGCBs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 21:01:48 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71B75537ED;
        Tue,  6 Dec 2022 18:01:45 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4NRgWT4PNNz4xVH;
        Wed,  7 Dec 2022 13:01:41 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1670378503;
        bh=zO0dx04DxkzFC3o1/kc6xtCJwgaBYBqwH0WHUuSOgwo=;
        h=Date:From:To:Cc:Subject:From;
        b=j5/F7vcTZUPptctXFs1F8VsK+wUZqbXjGF2k5IUFcwPaQGksrtCOargB5mnsRKE9H
         ef7fbxiYrYFnVn98I2CmNll9LpuPVwLuzOeUyV8lomTKX8u2rIo232axANvRXeuhvI
         ekrW1653iD5IJZfLyxjhSvCYgjovVh7/57BuW0s/IbeYBEAOJi7QOqTq4lOiTPIgTt
         mFuEvNaDUT66Uy1n9Xp7107cYxWw8VtNfULK9TzRS7PguGDbvuQEfdN2tydScPJsdB
         8F8y3gcL/NaMVx9f712s1KKbY8vskeeWOkHqTSkP/nyDLmnu0uypWfEcjOPGfCuUww
         k7c91TZxH2GYQ==
Date:   Wed, 7 Dec 2022 13:01:40 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     David Hildenbrand <david@redhat.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Hirokazu Honda <hiroh@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: manual merge of the mm-stable tree with the
 v4l-dvb-next tree
Message-ID: <20221207130140.7c014015@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/_NidvPG3PnO.Dtn9hOjdR=9";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/_NidvPG3PnO.Dtn9hOjdR=9
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the mm-stable tree got a conflict in:

  drivers/media/common/videobuf2/frame_vector.c

between commit:

  e2fc6edd37ba ("media: videobuf2: revert "get_userptr: buffers are always =
writable"")

from the v4l-dvb-next tree and commit:

  cb78a634f3f7 ("mm/frame-vector: remove FOLL_FORCE usage")

from the mm-stable tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc drivers/media/common/videobuf2/frame_vector.c
index 0a8a9dd34782,062e98148c53..000000000000
--- a/drivers/media/common/videobuf2/frame_vector.c
+++ b/drivers/media/common/videobuf2/frame_vector.c
@@@ -33,11 -32,14 +33,11 @@@
   *
   * This function takes care of grabbing mmap_lock as necessary.
   */
 -int get_vaddr_frames(unsigned long start, unsigned int nr_frames,
 +int get_vaddr_frames(unsigned long start, unsigned int nr_frames, bool wr=
ite,
  		     struct frame_vector *vec)
  {
 -	struct mm_struct *mm =3D current->mm;
 -	struct vm_area_struct *vma;
 -	int ret_pin_user_pages_fast =3D 0;
 -	int ret =3D 0;
 -	int err;
 +	int ret;
- 	unsigned int gup_flags =3D FOLL_FORCE | FOLL_LONGTERM;
++	unsigned int gup_flags =3D FOLL_LONGTERM;
 =20
  	if (nr_frames =3D=3D 0)
  		return 0;

--Sig_/_NidvPG3PnO.Dtn9hOjdR=9
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmOP9AQACgkQAVBC80lX
0GwvOwf/f/AIlb1NHAQakG7CNPf9KHu5nbiZY55yTVsLM3CqfJeU489v0F/zUjNV
Zdm1T6lm4ZD3eQdqgcd/YVGhExqZUbhz52S0jJ3knehSmvP1vivh3Ta4PgMnkvr2
CfelO3gK97sWWPDqSI5zh+qKGfiybDSh1WLXRcCFNX8qkhtHU81YpN1NF0GQC2dY
8DY49n+m5HdbM3GP9oJAqdKPeproeD4m8NGzrTcJ1n+275g6yI/lFZ/wlK+5wEFv
KFHePknG0/eud5Bz7BhM3TJn/xNnXb9u9cUQ6E4Yn/Gep8ZyxLd1NLR3GC1yR3W5
SOPQwFsgA9kvMZIzcsXj/IgaXAPnUA==
=MnOh
-----END PGP SIGNATURE-----

--Sig_/_NidvPG3PnO.Dtn9hOjdR=9--
