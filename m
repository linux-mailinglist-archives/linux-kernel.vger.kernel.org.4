Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0957672C53
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 00:14:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229663AbjARXOe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 18:14:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229734AbjARXO1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 18:14:27 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D26C62D00;
        Wed, 18 Jan 2023 15:14:26 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Ny1mc5BTcz4x1D;
        Thu, 19 Jan 2023 10:14:24 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1674083664;
        bh=/GozQ/28etYB2mSeEg206cjkeKjWt741SJTFQg3Rngc=;
        h=Date:From:To:Cc:Subject:From;
        b=j+AHs2nCwDjebL33wxFnRDHBSQE+L3KWuNRpIIhfTcs0pVJ/xtsW2ecf7C9iTH/nf
         1/U1cHhayarnXdgJi3k5DQ0fLlb0bD1eoQIXSXVKKai4eIMIVew2JTGDJYUQ4DwCY3
         SWa+nwuDmH8yp/88XCMGtrrvrKOjWKk8QgVfGgplULtNN0+UTxfU3qp9JxDxtlsfwC
         5xR9HYdaLzrK+wqyRn2TFqSSVlM4xPyvpGtGhc2roLwwIC6q3bDajOW6k5wel99tPj
         Ckuh2ErXEDSScTCqILHtOSsMGC3mgeMMkCmOSy6NbPFrKN8OLHssYJruqFYXJZnbIn
         Sz1v8ZaHjWrNw==
Date:   Thu, 19 Jan 2023 10:14:23 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Jeff Layton <jlayton@kernel.org>,
        Christian Brauner <christian@brauner.io>,
        Seth Forshee <sforshee@kernel.org>
Cc:     Christian Brauner <brauner@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: manual merge of the iversion tree with the
 vfs-idmapping tree
Message-ID: <20230119101423.547b48b7@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/tGcWqULL3ronA.xvNnjuZKN";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/tGcWqULL3ronA.xvNnjuZKN
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the iversion tree got a conflict in:

  fs/stat.c

between commit:

  9a516a5ea11a ("fs: port ->getattr() to pass mnt_idmap")

from the vfs-idmapping tree and commit:

  d84b698e9362 ("vfs: plumb i_version handling into struct kstat")

from the iversion tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc fs/stat.c
index f540047e1177,06fd3fc1ab84..000000000000
--- a/fs/stat.c
+++ b/fs/stat.c
@@@ -122,12 -120,17 +123,17 @@@ int vfs_getattr_nosec(const struct pat
  	stat->attributes_mask |=3D (STATX_ATTR_AUTOMOUNT |
  				  STATX_ATTR_DAX);
 =20
+ 	if ((request_mask & STATX_CHANGE_COOKIE) && IS_I_VERSION(inode)) {
+ 		stat->result_mask |=3D STATX_CHANGE_COOKIE;
+ 		stat->change_cookie =3D inode_query_iversion(inode);
+ 	}
+=20
 -	mnt_userns =3D mnt_user_ns(path->mnt);
 +	idmap =3D mnt_idmap(path->mnt);
  	if (inode->i_op->getattr)
 -		return inode->i_op->getattr(mnt_userns, path, stat,
 +		return inode->i_op->getattr(idmap, path, stat,
  					    request_mask, query_flags);
 =20
 -	generic_fillattr(mnt_userns, inode, stat);
 +	generic_fillattr(idmap, inode, stat);
  	return 0;
  }
  EXPORT_SYMBOL(vfs_getattr_nosec);

--Sig_/tGcWqULL3ronA.xvNnjuZKN
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmPIfU8ACgkQAVBC80lX
0GzkaAf9G8ktjbsuDfA3XVSCXSFy+v97J2FQz7yg9hExaTMLS20KNEmP8HUgcbSx
x8CHM8mbcittZg3Y9V54QhnuAbQ9UOu5M2mFSbO5uOQs0LmwIRikoDsH+vVy9e9x
SQou8ZF9Douko5PHHT1+V/8hIEtJCnOROuJ+FVyfCna98qNF30ZspDYgpbS1uMuI
IpJN2P9TMnmM4bintMja5kqI522+tofbQ0kmGt0RnYnth1DCEFf196qyUnK4+7z8
JY4rqvXWC+3yaAMOzchVVUCyEJR6yRzpHZNmO2k4KPEFUs3FmGnF4uBqbigaT2jW
13Y5cQjjmqUqnE9DO6da+Mv2mCzkmA==
=qWW8
-----END PGP SIGNATURE-----

--Sig_/tGcWqULL3ronA.xvNnjuZKN--
