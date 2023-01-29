Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 989AD6802F6
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 00:32:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233637AbjA2Xb4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Jan 2023 18:31:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbjA2Xby (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jan 2023 18:31:54 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 021C01CF64;
        Sun, 29 Jan 2023 15:31:51 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4P4ndf41TXz4x1h;
        Mon, 30 Jan 2023 10:31:50 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1675035110;
        bh=MeK0MWegMnTL5j08BS6OVCn91+RP6fBtwkizE8TegEU=;
        h=Date:From:To:Cc:Subject:From;
        b=cBJtMT9kj8v5ayVfMgpEq9dSAfOHSIVqcntyksWhceX09PAaZJao54gT20yW34tW0
         S51g07hrclpLmM/LJRJ3Ns11VS35JmOT0xFZXmU8v5j7bZF0af12NGZ4cpQbX7wxrm
         AZSTwfSICAM4zQxZBV6hqlrDNdUDNqWrlffMsaUV5Hvz14uj6LGLyOrfnzjhEYdqvw
         aOY8oXPs6jwIBOQTEdfgRMwONK1c7UhcEUvP9TFh37D5dvWdSURCcSisxxt6K0E83E
         Ej4Is45mP3FQS6wo+TGS291t5Err4YVyglEfWXlJHwkPHWeoGh9T34ictgjXQ48aPs
         pvb1cJSCfScJg==
Date:   Mon, 30 Jan 2023 10:31:49 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Christian Brauner <christian@brauner.io>,
        Seth Forshee <sforshee@kernel.org>
Cc:     Christian Brauner <brauner@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: manual merge of the vfs-idmapping tree with Linus' tree
Message-ID: <20230130103149.7d09e239@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/ADAmrXeNq_nWtc_qwTwmyXx";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/ADAmrXeNq_nWtc_qwTwmyXx
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the vfs-idmapping tree got conflicts in:

  fs/fuse/acl.c
  fs/fuse/fuse_i.h
  fs/fuse/xattr.c

between commit:

  facd61053cff ("fuse: fixes after adapting to new posix acl api")

from Linus' tree and various commits from the vfs-idmapping tree.

Christian: thanks for supplying the resolution.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc fs/fuse/acl.c
index ad670369955f,23d1c263891f..000000000000
--- a/fs/fuse/acl.c
+++ b/fs/fuse/acl.c
@@@ -11,10 -11,9 +11,10 @@@
  #include <linux/posix_acl.h>
  #include <linux/posix_acl_xattr.h>
 =20
 -struct posix_acl *fuse_get_acl(struct inode *inode, int type, bool rcu)
 +static struct posix_acl *__fuse_get_acl(struct fuse_conn *fc,
- 					struct user_namespace *mnt_userns,
++					struct mnt_idmap *idmap,
 +					struct inode *inode, int type, bool rcu)
  {
 -	struct fuse_conn *fc =3D get_fuse_conn(inode);
  	int size;
  	const char *name;
  	void *value =3D NULL;
@@@ -54,47 -53,7 +54,47 @@@
  	return acl;
  }
 =20
 +static inline bool fuse_no_acl(const struct fuse_conn *fc,
 +			       const struct inode *inode)
 +{
 +	/*
 +	 * Refuse interacting with POSIX ACLs for daemons that
 +	 * don't support FUSE_POSIX_ACL and are not mounted on
 +	 * the host to retain backwards compatibility.
 +	 */
 +	return !fc->posix_acl && (i_user_ns(inode) !=3D &init_user_ns);
 +}
 +
- struct posix_acl *fuse_get_acl(struct user_namespace *mnt_userns,
++struct posix_acl *fuse_get_acl(struct mnt_idmap *idmap,
 +			       struct dentry *dentry, int type)
 +{
 +	struct inode *inode =3D d_inode(dentry);
 +	struct fuse_conn *fc =3D get_fuse_conn(inode);
 +
 +	if (fuse_no_acl(fc, inode))
 +		return ERR_PTR(-EOPNOTSUPP);
 +
- 	return __fuse_get_acl(fc, mnt_userns, inode, type, false);
++	return __fuse_get_acl(fc, idmap, inode, type, false);
 +}
 +
 +struct posix_acl *fuse_get_inode_acl(struct inode *inode, int type, bool =
rcu)
 +{
 +	struct fuse_conn *fc =3D get_fuse_conn(inode);
 +
 +	/*
 +	 * FUSE daemons before FUSE_POSIX_ACL was introduced could get and set
 +	 * POSIX ACLs without them being used for permission checking by the
 +	 * vfs. Retain that behavior for backwards compatibility as there are
 +	 * filesystems that do all permission checking for acls in the daemon
 +	 * and not in the kernel.
 +	 */
 +	if (!fc->posix_acl)
 +		return NULL;
 +
- 	return __fuse_get_acl(fc, &init_user_ns, inode, type, rcu);
++	return __fuse_get_acl(fc, &nop_mnt_idmap, inode, type, rcu);
 +}
 +
- int fuse_set_acl(struct user_namespace *mnt_userns, struct dentry *dentry,
+ int fuse_set_acl(struct mnt_idmap *idmap, struct dentry *dentry,
  		 struct posix_acl *acl, int type)
  {
  	struct inode *inode =3D d_inode(dentry);
@@@ -140,14 -99,8 +140,14 @@@
  			return ret;
  		}
 =20
 -		if (!vfsgid_in_group_p(i_gid_into_vfsgid(&nop_mnt_idmap, inode)) &&
 +		/*
 +		 * Fuse daemons without FUSE_POSIX_ACL never changed the passed
 +		 * through POSIX ACLs. Such daemons don't expect setgid bits to
 +		 * be stripped.
 +		 */
 +		if (fc->posix_acl &&
- 		    !vfsgid_in_group_p(i_gid_into_vfsgid(&init_user_ns, inode)) &&
- 		    !capable_wrt_inode_uidgid(&init_user_ns, inode, CAP_FSETID))
++		    !vfsgid_in_group_p(i_gid_into_vfsgid(&nop_mnt_idmap, inode)) &&
+ 		    !capable_wrt_inode_uidgid(&nop_mnt_idmap, inode, CAP_FSETID))
  			extra_flags |=3D FUSE_SETXATTR_ACL_KILL_SGID;
 =20
  		ret =3D fuse_setxattr(inode, name, value, size, 0, extra_flags);
diff --cc fs/fuse/fuse_i.h
index 46797a171a84,ee084cead402..000000000000
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@@ -1264,12 -1264,12 +1264,12 @@@ ssize_t fuse_getxattr(struct inode *ino
  ssize_t fuse_listxattr(struct dentry *entry, char *list, size_t size);
  int fuse_removexattr(struct inode *inode, const char *name);
  extern const struct xattr_handler *fuse_xattr_handlers[];
 -extern const struct xattr_handler *fuse_acl_xattr_handlers[];
 -extern const struct xattr_handler *fuse_no_acl_xattr_handlers[];
 =20
  struct posix_acl;
 -struct posix_acl *fuse_get_acl(struct inode *inode, int type, bool rcu);
 +struct posix_acl *fuse_get_inode_acl(struct inode *inode, int type, bool =
rcu);
- struct posix_acl *fuse_get_acl(struct user_namespace *mnt_userns,
++struct posix_acl *fuse_get_acl(struct mnt_idmap *idmap,
 +			       struct dentry *dentry, int type);
- int fuse_set_acl(struct user_namespace *mnt_userns, struct dentry *dentry,
+ int fuse_set_acl(struct mnt_idmap *idmap, struct dentry *dentry,
  		 struct posix_acl *acl, int type);
 =20
  /* readdir.c */
diff --cc fs/fuse/xattr.c
index 9fe571ab569e,30aaaa4b3bfb..000000000000
--- a/fs/fuse/xattr.c
+++ b/fs/fuse/xattr.c

--Sig_/ADAmrXeNq_nWtc_qwTwmyXx
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmPXAeUACgkQAVBC80lX
0GzrgggAglqNpT91F1+bwu0VIAgD04hjm2h2rZI6pCvKQTqW4ttHOOrAbyDFkVVk
3KS3lLV6x3AU64XAqOHCpQJmgGzIXxjDNQ4WoJo8mQcgQumu/n8a+el2g+myBhNW
SA5wsRlemu/dWnPfleekL9szVGr8K4YNIpnlBf9ds2d9FXSNG6Af1Lus0eG6wPnS
4zzHTt7pTr2YePo6wxkCOp3yDsaRZJYI28L6brTZKE1kh9p/kp5N84i+YEGr4P9i
Us53oxJ5Zj5X+q0mbzD4+D4aZu/3k1zcDfWPqYiHNkMOWDN/LOFoo49WBGvL6HWf
wA7g2gzOf7XdYW/5PBUWz+jOPA6CHQ==
=ULwG
-----END PGP SIGNATURE-----

--Sig_/ADAmrXeNq_nWtc_qwTwmyXx--
