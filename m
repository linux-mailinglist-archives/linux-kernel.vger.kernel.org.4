Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 542B467DAB4
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 01:23:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230433AbjA0AXA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 19:23:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjA0AW4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 19:22:56 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98E327EC9;
        Thu, 26 Jan 2023 16:22:29 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4P2ytk583gz4xN1;
        Fri, 27 Jan 2023 11:21:50 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1674778911;
        bh=HViW9Me7YJOaBsw5QSGbFRC0eMlpQKUZBgSymIkZ1cg=;
        h=Date:From:To:Cc:Subject:From;
        b=H/CjgGlpY4N61tApkudioZUZG+YqXQ7qNnMOT/EdizdD6qi1DTPs0u4CUPY0+55q3
         YjI/csYarR1GXxOdaOnqEGzogF4N1jo7T7UF2N9tYWWR4tpuW8GuB78vDQTlLPfFvE
         Dr4xw04rowWP0LBHN/d5w0eDgPuHFClSoP9CcRX0E7VLCfXA1m1dl3wJqedEWkmSEZ
         UeCsbNC7i7YanBjiroI94wlmTFBxpT+bkaMyCCZ7nI4KlOUyds5Y297sUB8l7B/FKJ
         FDu/boJOLsOVl2+GWGl6i9fFD89dPkHaxwsAEMLz+cYks6PhBONO7Cm5cmUPl4bNm6
         4Lfwe6j53TKpA==
Date:   Fri, 27 Jan 2023 11:21:49 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Eric Van Hensbergen <ericvh@gmail.com>,
        Christian Brauner <christian@brauner.io>,
        Seth Forshee <sforshee@kernel.org>
Cc:     Christian Brauner <brauner@kernel.org>,
        Eric Van Hensbergen <ericvh@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: manual merge of the v9fs-ericvh tree with the
 vfs-idmapping tree
Message-ID: <20230127112149.283a466f@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/g1rpF6bNsxU0/JEjdiDyK0O";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/g1rpF6bNsxU0/JEjdiDyK0O
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the v9fs-ericvh tree got conflicts in:

  fs/9p/vfs_inode.c
  fs/9p/vfs_inode_dotl.c

between commit:

  b74d24f7a74f ("fs: port ->getattr() to pass mnt_idmap")

from the vfs-idmapping tree and commit:

  a905b430e998 ("fs/9p: writeback mode fixes")

from the v9fs-ericvh tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc fs/9p/vfs_inode.c
index 4344e7a7865f,c61709d98934..000000000000
--- a/fs/9p/vfs_inode.c
+++ b/fs/9p/vfs_inode.c
@@@ -1038,8 -1009,11 +1009,11 @@@ v9fs_vfs_getattr(struct mnt_idmap *idma
  	p9_debug(P9_DEBUG_VFS, "dentry: %p\n", dentry);
  	v9ses =3D v9fs_dentry2v9ses(dentry);
  	if (v9ses->cache =3D=3D CACHE_LOOSE || v9ses->cache =3D=3D CACHE_FSCACHE=
) {
- 		generic_fillattr(&nop_mnt_idmap, d_inode(dentry), stat);
 -		generic_fillattr(&init_user_ns, inode, stat);
++		generic_fillattr(&nop_mnt_idmap, inode, stat);
  		return 0;
+ 	} else if (v9ses->cache >=3D CACHE_WRITEBACK) {
+ 		if (S_ISREG(inode->i_mode))
+ 			filemap_write_and_wait(inode->i_mapping);
  	}
  	fid =3D v9fs_fid_lookup(dentry);
  	if (IS_ERR(fid))
diff --cc fs/9p/vfs_inode_dotl.c
index 3bed3eb3a0e2,3ad48474bf29..000000000000
--- a/fs/9p/vfs_inode_dotl.c
+++ b/fs/9p/vfs_inode_dotl.c
@@@ -462,8 -452,11 +452,11 @@@ v9fs_vfs_getattr_dotl(struct mnt_idmap=20
  	p9_debug(P9_DEBUG_VFS, "dentry: %p\n", dentry);
  	v9ses =3D v9fs_dentry2v9ses(dentry);
  	if (v9ses->cache =3D=3D CACHE_LOOSE || v9ses->cache =3D=3D CACHE_FSCACHE=
) {
- 		generic_fillattr(&nop_mnt_idmap, d_inode(dentry), stat);
 -		generic_fillattr(&init_user_ns, inode, stat);
++		generic_fillattr(&nop_mnt_idmap, inode, stat);
  		return 0;
+ 	} else if (v9ses->cache) {
+ 		if (S_ISREG(inode->i_mode))
+ 			filemap_write_and_wait(inode->i_mapping);
  	}
  	fid =3D v9fs_fid_lookup(dentry);
  	if (IS_ERR(fid))
@@@ -592,12 -589,17 +589,17 @@@ int v9fs_vfs_setattr_dotl(struct mnt_id
  		return retval;
  	}
 =20
- 	if ((iattr->ia_valid & ATTR_SIZE) &&
- 	    iattr->ia_size !=3D i_size_read(inode))
+ 	if ((iattr->ia_valid & ATTR_SIZE) && iattr->ia_size !=3D
+ 		 i_size_read(inode)) {
  		truncate_setsize(inode, iattr->ia_size);
+ 		truncate_pagecache(inode, iattr->ia_size);
+=20
+ 		if (v9ses->cache =3D=3D CACHE_FSCACHE)
+ 			fscache_resize_cookie(v9fs_inode_cookie(v9inode), iattr->ia_size);
+ 	}
 =20
  	v9fs_invalidate_inode_attr(inode);
 -	setattr_copy(&init_user_ns, inode, iattr);
 +	setattr_copy(&nop_mnt_idmap, inode, iattr);
  	mark_inode_dirty(inode);
  	if (iattr->ia_valid & ATTR_MODE) {
  		/* We also want to update ACL when we update mode bits */

--Sig_/g1rpF6bNsxU0/JEjdiDyK0O
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmPTGR0ACgkQAVBC80lX
0GwN3ggAmMgP8dChrtldhgo8l+bZ9skT5YwR9t/T9ilc/gVL2bWsTqOWeGU/EPb0
P1Az0StnnIx2WvuOoaUETZg3sWNG+Xf15mR3D80pKPC1YoU4Dhrn51Z8PewBVIyi
A/qk2Aj3/aVm1gAFBZZ5Aq9B3LnRAZr6u5ibmlbe2wXdnpuRW1GmnwCMc+bpsPGK
/39tBV2KwPIT4l6HjQbdqyfggH9DNFFkaebvd0oJTNQWbsQiui5f7zwEIAayJteI
324n8SLYGAAqBy0OMy7pl/rLfaETyvwGdSrCw3FhpPtpUst9oEZlsNojz91xkkie
HGvqGwS5TGkPgIuAUBYWn1mpT8Vamw==
=f8Z1
-----END PGP SIGNATURE-----

--Sig_/g1rpF6bNsxU0/JEjdiDyK0O--
