Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBB0D69875A
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 22:30:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229974AbjBOVaO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 16:30:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229831AbjBOVaL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 16:30:11 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3443C2365A;
        Wed, 15 Feb 2023 13:30:09 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4PHB7H3TQ3z4x5X;
        Thu, 16 Feb 2023 08:30:03 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1676496603;
        bh=mG1gvaBbO8hTzuz96CL94P7Xf50HvLn1KywUiJJme8A=;
        h=Date:From:To:Cc:Subject:From;
        b=Eq9CiDZKzvf4iAgAUBtyVdXN3ae1cQ3Ur16K++R0noMVpFMThq+N0jL4vOX1ARZJ6
         EKDx1uxSrtv2dUxK2JtDwW1hH2tNiMm+8qiZ9vsVtDoWbAHYvy2uI5jrGYRwLMyoxh
         eQUiS1s/88VRcW4+4hBapeGrupph3nO2B76k8PbgeRdlstCwq0t8SRV5XHvMqzm+7a
         X8nUvRStT9Hk9SzgnHnswBeoq+fb+nqNg3OwC6LazEpgdbZeIGRcC4BJG3q3mDAhGk
         9Y6j3jKFBXNHxb/6mH8K+srfTeNcNTjt652LQdIpZ2VPN4KDktK2qssau+Ky0OydBq
         6KqcInth2KBrw==
Date:   Thu, 16 Feb 2023 08:30:02 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        Christian Brauner <christian@brauner.io>,
        Seth Forshee <sforshee@kernel.org>
Cc:     Christian Brauner <brauner@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: manual merge of the ntfs3 tree with the vfs-idmapping
 tree
Message-ID: <20230216083002.6227ba81@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/fE1=pPJH3eojyBI4sc0.Zfe";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/fE1=pPJH3eojyBI4sc0.Zfe
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the ntfs3 tree got conflicts in:

  fs/ntfs3/file.c

between commit:

  c1632a0f1120 ("fs: port ->setattr() to pass mnt_idmap")

from the vfs-idmapping tree and commit:

  d1468d48fe7a ("fs/ntfs3: Remove noacsrules")

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

diff --cc fs/ntfs3/file.c
index e9bdc1ff08c9,a10a905ec7ce..000000000000
--- a/fs/ntfs3/file.c
+++ b/fs/ntfs3/file.c
@@@ -657,26 -653,16 +653,16 @@@ out
  /*
   * ntfs3_setattr - inode_operations::setattr
   */
 -int ntfs3_setattr(struct user_namespace *mnt_userns, struct dentry *dentr=
y,
 +int ntfs3_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
  		  struct iattr *attr)
  {
- 	struct super_block *sb =3D dentry->d_sb;
- 	struct ntfs_sb_info *sbi =3D sb->s_fs_info;
  	struct inode *inode =3D d_inode(dentry);
  	struct ntfs_inode *ni =3D ntfs_i(inode);
  	u32 ia_valid =3D attr->ia_valid;
  	umode_t mode =3D inode->i_mode;
  	int err;
 =20
- 	if (sbi->options->noacsrules) {
- 		/* "No access rules" - Force any changes of time etc. */
- 		attr->ia_valid |=3D ATTR_FORCE;
- 		/* and disable for editing some attributes. */
- 		attr->ia_valid &=3D ~(ATTR_UID | ATTR_GID | ATTR_MODE);
- 		ia_valid =3D attr->ia_valid;
- 	}
-=20
 -	err =3D setattr_prepare(mnt_userns, dentry, attr);
 +	err =3D setattr_prepare(idmap, dentry, attr);
  	if (err)
  		goto out;
 =20

--Sig_/fE1=pPJH3eojyBI4sc0.Zfe
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmPtTtoACgkQAVBC80lX
0GwscQgAnGY2jw2hDLEhW12se8Zp6Fek6Sek6sYQ+7HFJI/HS/GqPa6jjOhv4o7L
CHLpT0qFffu+HBXvfejAqVRREAn9L4oQiz/vnSx/mwxXN2Vxi11Do94mVlnMgVza
W7Sw6uFfwaYw3wkXBAY/bx8B90Bt1BMhcUubq0a/OlvPIiQ+HrjlPgDDsbvTWcHf
IzCSl5MIVhD/RCuqS5sdKULrOzX+zlLL8wt6uSFtSrKRT3sk28NIk/P5vEMLvOMW
XbSGETTGHrduZ9HMFTIJqfdxlRDcsxjLKZqPak1U0Kwmk+Xpk3uZ4nQfQ5tEkWYh
EPV7dCijDzAVl5YbARPnlg7ouMd59w==
=jLdb
-----END PGP SIGNATURE-----

--Sig_/fE1=pPJH3eojyBI4sc0.Zfe--
