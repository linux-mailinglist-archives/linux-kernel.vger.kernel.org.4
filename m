Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A8D7672C46
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 00:07:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229618AbjARXH1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 18:07:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbjARXH0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 18:07:26 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 224705926C;
        Wed, 18 Jan 2023 15:07:25 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Ny1cS4Wqlz4xFv;
        Thu, 19 Jan 2023 10:07:20 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1674083241;
        bh=nncDruzc9cmICuiqMB8vXhoJpYdB6sWaZLRYgwC41UY=;
        h=Date:From:To:Cc:Subject:From;
        b=LvOHb/4i7tG6wRGWcuJfYOJoM14+/wxOPu2apM9gxcQRLZuiAet+bqDlOsMezEOs8
         nBbBwMjMYSBN+hOPbozDkYOon6stb8Z3SNXDH+tLfYyMpE+UtLhpmmNDCd6K7Y8fK8
         en6/Nru55eTerg3y3xPFzZtHKC37vmjgK35pGO8R3w5y0tUYXqbs4DP/Oe56qSyPqB
         bO1qh6+dWCrr+kAsaD/Co2jeDSWUqFkxvTBxoSdjgBz9JWs9HOFRWZ05V9+1EsRN3/
         DCt3UndC+9QGmEz+FEwENQ0KxHB9TU0HX9pzPKt6sAOJVSXrKJNjEdQg6QvyqV/aR7
         VS0/kRyranRcA==
Date:   Thu, 19 Jan 2023 10:07:18 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Christian Brauner <christian@brauner.io>,
        Seth Forshee <sforshee@kernel.org>
Cc:     "Christian Brauner (Microsoft)" <brauner@kernel.org>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        David Sterba <dsterba@suse.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: manual merge of the vfs-idmapping tree with Linus' tree
Message-ID: <20230119100718.346ffa0e@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/eH55zf.L1BzZwpZBmfCpMTy";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/eH55zf.L1BzZwpZBmfCpMTy
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the vfs-idmapping tree got a conflict in:

  fs/btrfs/inode.c

between commit:

  abe3bf7425fb ("btrfs: fix an error handling path in btrfs_rename()")

from Linus' tree and commit:

  7ddfa7d0d7d1 ("fs: port inode_init_owner() to mnt_idmap")

from the vfs-idmapping tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc fs/btrfs/inode.c
index 98a800b8bd43,8d74d042c626..000000000000
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@@ -9376,11 -9376,9 +9376,11 @@@ static int btrfs_rename(struct mnt_idma
  		filemap_flush(old_inode->i_mapping);
 =20
  	if (flags & RENAME_WHITEOUT) {
- 		whiteout_args.inode =3D new_whiteout_inode(mnt_userns, old_dir);
+ 		whiteout_args.inode =3D new_whiteout_inode(idmap, old_dir);
 -		if (!whiteout_args.inode)
 -			return -ENOMEM;
 +		if (!whiteout_args.inode) {
 +			ret =3D -ENOMEM;
 +			goto out_fscrypt_names;
 +		}
  		ret =3D btrfs_new_inode_prepare(&whiteout_args, &trans_num_items);
  		if (ret)
  			goto out_whiteout_inode;

--Sig_/eH55zf.L1BzZwpZBmfCpMTy
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmPIe6cACgkQAVBC80lX
0GxpNwf9G5HHltX/eG8bdCCtGG1F7AcVx11eL1k3J9r5PPpM0VPmNyVXPt0S4+Pv
JliNYdIXXtKeK3XIZJOPEoMQfgBi2M+8trvdJSGgbSmoKAWKdasQe86eS2Py08KD
4TG51DBawC/zq2M3woxlU+FZUus6Na0mSyxeK6GCPUXZQyunfsHYyKlXVF/v6/qN
VKBaCa580g7lfaYMvx7CbEpasJjJYmMDMkDV7Y4deAlhY+NrhETSgJ3zAqaJartQ
ESoeVi4PVNWxliqkI0zIrse2WFPs4VdJORcoF68yHfDBj37HSgAiXPmy+iQtVFmt
RWD4X0PoPlahZ+lNakVultLas+1vSA==
=xQ+9
-----END PGP SIGNATURE-----

--Sig_/eH55zf.L1BzZwpZBmfCpMTy--
