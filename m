Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E60A1698792
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 22:57:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229956AbjBOV5k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 16:57:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbjBOV5i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 16:57:38 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47C852823B;
        Wed, 15 Feb 2023 13:57:36 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4PHBl22lZzz4x5W;
        Thu, 16 Feb 2023 08:57:34 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1676498254;
        bh=QoLAwLkVtozEsvdsuAJema5OVbM2ERGyI8jwSMCtMmA=;
        h=Date:From:To:Cc:Subject:From;
        b=ZQqdKkmfsdnZ1xmqt1gHGY/xkzfj3IelN70APSAE3O76+Na8Wlwys6wbn6M2XzaQG
         /VIIUbJPr0MI5N80JbWLt+GkroLf5dfyIj2iZsrFh+MILZvgW4ulQfy7yVdtQl1LFf
         gIu28LMkJIt5c7unous7sOHJb7NoGDIjmLFDJGSIbGiGFhlgeOa0RLzpnzvlFoi+vC
         GPdEjrvQwAyNZPQNtxGGyCDbMjUCMmL6WutNqE2ohwxH8yp0s7fJrzftLNUC+Efg60
         CRuDoaubQkvWyJDZdUYoAHJBLRJPm3ZAV44wqlYbu/1ANXK7VewD43azIKUPM9xp2/
         xrqeLj9lODhtw==
Date:   Thu, 16 Feb 2023 08:57:33 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        Christian Brauner <christian@brauner.io>,
        Seth Forshee <sforshee@kernel.org>
Cc:     Christian Brauner <brauner@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: manual merge of the ntfs3 tree with the vfs-idmapping
 tree
Message-ID: <20230216085733.5a40fe6b@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/eofISrFWMZSNk9lF0mNkCJF";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/eofISrFWMZSNk9lF0mNkCJF
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the ntfs3 tree got a conflict in:

  fs/ntfs3/ntfs_fs.h
  fs/ntfs3/xattr.c

between commits:

  77435322777d ("fs: port ->get_acl() to pass mnt_idmap")
  13e83a4923be ("fs: port ->set_acl() to pass mnt_idmap")
  4609e1f18e19 ("fs: port ->permission() to pass mnt_idmap")

from the vfs-idmapping tree and commits:

  d1468d48fe7a ("fs/ntfs3: Remove noacsrules")
  fa578fb1810a ("fs/ntfs3: Changed ntfs_get_acl() to use dentry")

from the ntfs3 tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc fs/ntfs3/ntfs_fs.h
index 80072e5f96f7,9a2d965f183e..000000000000
--- a/fs/ntfs3/ntfs_fs.h
+++ b/fs/ntfs3/ntfs_fs.h
@@@ -858,19 -854,18 +856,18 @@@ unsigned long ntfs_names_hash(const u1
 =20
  /* globals from xattr.c */
  #ifdef CONFIG_NTFS3_FS_POSIX_ACL
- struct posix_acl *ntfs_get_acl(struct inode *inode, int type, bool rcu);
 -struct posix_acl *ntfs_get_acl(struct user_namespace *mnt_userns,
++struct posix_acl *ntfs_get_acl(struct mnt_idmap *idmap,
+ 			       struct dentry *dentry, int type);
 -int ntfs_set_acl(struct user_namespace *mnt_userns, struct dentry *dentry,
 +int ntfs_set_acl(struct mnt_idmap *idmap, struct dentry *dentry,
  		 struct posix_acl *acl, int type);
 -int ntfs_init_acl(struct user_namespace *mnt_userns, struct inode *inode,
 +int ntfs_init_acl(struct mnt_idmap *idmap, struct inode *inode,
  		  struct inode *dir);
  #else
  #define ntfs_get_acl NULL
  #define ntfs_set_acl NULL
  #endif
 =20
 -int ntfs_acl_chmod(struct user_namespace *mnt_userns, struct dentry *dent=
ry);
 +int ntfs_acl_chmod(struct mnt_idmap *idmap, struct dentry *dentry);
- int ntfs_permission(struct mnt_idmap *idmap, struct inode *inode,
- 		    int mask);
  ssize_t ntfs_listxattr(struct dentry *dentry, char *buffer, size_t size);
  extern const struct xattr_handler *ntfs_xattr_handlers[];
 =20
diff --cc fs/ntfs3/xattr.c
index ff64302e87e5,0a6d2ec8c340..000000000000
--- a/fs/ntfs3/xattr.c
+++ b/fs/ntfs3/xattr.c
@@@ -517,9 -520,14 +520,14 @@@ out
  }
 =20
  #ifdef CONFIG_NTFS3_FS_POSIX_ACL
- static struct posix_acl *ntfs_get_acl_ex(struct inode *inode, int type,
- 					 int locked)
+=20
+ /*
+  * ntfs_get_acl - inode_operations::get_acl
+  */
 -struct posix_acl *ntfs_get_acl(struct user_namespace *mnt_userns,
++struct posix_acl *ntfs_get_acl(struct mnt_idmap *idmap,
+ 			       struct dentry *dentry, int type)
  {
+ 	struct inode *inode =3D d_inode(dentry);
  	struct ntfs_inode *ni =3D ntfs_i(inode);
  	const char *name;
  	size_t name_len;
@@@ -567,18 -573,7 +573,7 @@@
  	return acl;
  }
 =20
- /*
-  * ntfs_get_acl - inode_operations::get_acl
-  */
- struct posix_acl *ntfs_get_acl(struct inode *inode, int type, bool rcu)
- {
- 	if (rcu)
- 		return ERR_PTR(-ECHILD);
-=20
- 	return ntfs_get_acl_ex(inode, type, 0);
- }
-=20
 -static noinline int ntfs_set_acl_ex(struct user_namespace *mnt_userns,
 +static noinline int ntfs_set_acl_ex(struct mnt_idmap *idmap,
  				    struct inode *inode, struct posix_acl *acl,
  				    int type, bool init_acl)
  {
@@@ -708,23 -703,9 +703,9 @@@ int ntfs_acl_chmod(struct mnt_idmap *id
  	if (S_ISLNK(inode->i_mode))
  		return -EOPNOTSUPP;
 =20
 -	return posix_acl_chmod(mnt_userns, dentry, inode->i_mode);
 +	return posix_acl_chmod(idmap, dentry, inode->i_mode);
  }
 =20
- /*
-  * ntfs_permission - inode_operations::permission
-  */
- int ntfs_permission(struct mnt_idmap *idmap, struct inode *inode,
- 		    int mask)
- {
- 	if (ntfs_sb(inode->i_sb)->options->noacsrules) {
- 		/* "No access rules" mode - Allow all changes. */
- 		return 0;
- 	}
-=20
- 	return generic_permission(idmap, inode, mask);
- }
-=20
  /*
   * ntfs_listxattr - inode_operations::listxattr
   */

--Sig_/eofISrFWMZSNk9lF0mNkCJF
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmPtVU0ACgkQAVBC80lX
0GzTNgf/YSwn+5l2bDL6m/oddaT50jJL3YQxBC9CfN9acM7lCD9ZtOB9FOG7o90y
E2KZRbQwelXNKZt0EPD8poPdgG667FzXH5KOmEDsWJvYLQiJC1TCcDsD1nm1GKIJ
OLYVV0riIC3c51eL//YTfzeBpjRyZPFEcj193nnY33pB5vphiJh7IZ4z7dY4xvaj
82PbrwMXbXpjZXLscZavjdUodEfW6Bz3rheF4TRfQNcyxaXqmaF84YAKJSFC297t
bHyjeQ3S/CmT7zGbYRa0J+ocE1hYEjvfJREy3O6MVLgZydYUZ29DWpY3xjvm0Mom
LqGEFPoX8AZHaL/KUJUC3WuE4luYTA==
=JH//
-----END PGP SIGNATURE-----

--Sig_/eofISrFWMZSNk9lF0mNkCJF--
