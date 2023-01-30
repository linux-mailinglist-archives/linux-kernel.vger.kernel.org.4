Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 353BB681F65
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 00:10:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229868AbjA3XKL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 18:10:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229573AbjA3XKK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 18:10:10 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64E587293;
        Mon, 30 Jan 2023 15:10:03 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4P5P5y1gbLz4x1d;
        Tue, 31 Jan 2023 10:09:58 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1675120198;
        bh=xXKRVa/x3vbppHXeb1afCumE2vg369DYRlNy9rhGf+A=;
        h=Date:From:To:Cc:Subject:From;
        b=AAFxoZTz4mxRTdDn6j1GqmFieD8qI7mh6L0eAWVmuLa8Mixqa7Seu9rcusXSL36UA
         5hpKpKc1bOa5nGkaNsv4ZTs0tNWDdk3E08QKLDJb8LmQybxMc/CaiDzgYGYAmsfON/
         GK2J1VkFG0XItnFB/iEFPGe+R+gtjTm1d6hhKtA7+f/nBEE9h5P8ABStwVAO864Sb3
         YxE3vORv2h34DAIRzUrur1bLfPREyFp6OcAvhIcMtlke3X0vRTDiEgUB3wAO3/GdV8
         jp5mUJ8L0xCeAnmxlG62AfkWK/JOcr8laIt+2i08DhOBaZgusdDFkc1Vvdmfwfyduu
         K8NPzelKmHmWA==
Date:   Tue, 31 Jan 2023 10:07:28 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Jaegeuk Kim <jaegeuk@kernel.org>,
        Christian Brauner <christian@brauner.io>,
        Seth Forshee <sforshee@kernel.org>
Cc:     Christian Brauner <brauner@kernel.org>,
        Daeho Jeong <daehojeong@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: manual merge of the f2fs tree with the vfs-idmapping
 tree
Message-ID: <20230131100728.6efdb3c5@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/m/=CYt.5H9XPjtvaJipS7Fe";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/m/=CYt.5H9XPjtvaJipS7Fe
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the f2fs tree got a conflict in:

  fs/f2fs/file.c

between commit:

  f2d40141d5d9 ("fs: port inode_init_owner() to mnt_idmap")

from the vfs-idmapping tree and commit:

  81712a1f56dc ("f2fs: synchronize atomic write aborts")

from the f2fs tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc fs/f2fs/file.c
index b90617639743,3efb0852fd48..000000000000
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@@ -2087,19 -2090,28 +2090,28 @@@ static int f2fs_ioc_start_atomic_write(
  		goto out;
  	}
 =20
- 	/* Create a COW inode for atomic write */
- 	pinode =3D f2fs_iget(inode->i_sb, fi->i_pino);
- 	if (IS_ERR(pinode)) {
- 		f2fs_up_write(&fi->i_gc_rwsem[WRITE]);
- 		ret =3D PTR_ERR(pinode);
- 		goto out;
- 	}
+ 	/* Check if the inode already has a COW inode */
+ 	if (fi->cow_inode =3D=3D NULL) {
+ 		/* Create a COW inode for atomic write */
+ 		pinode =3D f2fs_iget(inode->i_sb, fi->i_pino);
+ 		if (IS_ERR(pinode)) {
+ 			f2fs_up_write(&fi->i_gc_rwsem[WRITE]);
+ 			ret =3D PTR_ERR(pinode);
+ 			goto out;
+ 		}
 =20
- 	ret =3D f2fs_get_tmpfile(idmap, pinode, &fi->cow_inode);
- 	iput(pinode);
- 	if (ret) {
- 		f2fs_up_write(&fi->i_gc_rwsem[WRITE]);
- 		goto out;
 -		ret =3D f2fs_get_tmpfile(mnt_userns, pinode, &fi->cow_inode);
++		ret =3D f2fs_get_tmpfile(idmap, pinode, &fi->cow_inode);
+ 		iput(pinode);
+ 		if (ret) {
+ 			f2fs_up_write(&fi->i_gc_rwsem[WRITE]);
+ 			goto out;
+ 		}
+=20
+ 		set_inode_flag(fi->cow_inode, FI_COW_FILE);
+ 		clear_inode_flag(fi->cow_inode, FI_INLINE_DATA);
+ 	} else {
+ 		/* Reuse the already created COW inode */
+ 		f2fs_do_truncate_blocks(fi->cow_inode, 0, true);
  	}
 =20
  	f2fs_write_inode(inode, NULL);

--Sig_/m/=CYt.5H9XPjtvaJipS7Fe
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmPYTbAACgkQAVBC80lX
0GzuVQf9FMT4XLNAAARH64bDGUySddufOR0b5g9cO2piyP2+3nO+zG3fp/TAjsaX
5Pc3fS/+nXtBq0c+J+/Hmuo01oJYe4cXIeqK8g+KGUR73lrIDc9j/dUMt3MrhhjB
P5cpgSzAUYgZX0zEA0Qmv21OuT/FQYY6RaccRG5f5Fj0GXtiIa109/na8OsBlo2X
S9MotDAJqrIFXwg1T4KW6BUrJ6vRijnmA6AC462Ks4kzacbpeGMIpuRSt+aoWno8
Bwd77bR5Xe1iFvKyX52pdYFyoVsLa4pDj6i21SXdJ6uj3bD+0V+rNIjg2rLftNcT
mYNzD7294yl070T4xqmn5xnf9NT+cA==
=ORrA
-----END PGP SIGNATURE-----

--Sig_/m/=CYt.5H9XPjtvaJipS7Fe--
