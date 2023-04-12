Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3968C6DE873
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 02:19:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229602AbjDLATy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 20:19:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbjDLATx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 20:19:53 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7E90171F;
        Tue, 11 Apr 2023 17:19:50 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Px3Hh3wjbz4x84;
        Wed, 12 Apr 2023 10:19:44 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1681258785;
        bh=7DoPsnkMElumDpbjNEW92q+xjDyj1+B3uUaBrzAhsyo=;
        h=Date:From:To:Cc:Subject:From;
        b=rI940riiIN3UJwKKS3inbat5LIpOO4KgbtZgInBmasV7SWPSKevansh372Ho/azGO
         VMO1wNNsuW9hy0lOgB8H6dncH08OJkuA74PBrgod0ksQTKY+dovcHVE6Z9+G0cJyQL
         LObcMa6bDW/8aZdiPLBrvYC1sPxy9qSp0IE9ZkDG5GhK1XZKHAJeL3VO0KFCfpe7y1
         O8KiXagIsv5JJPnvPobYICwLqi21IuucixuTBvY7+yQbWFgr3BmubEExXiyIFQLIo7
         5uSpd4Rf5awR7rAT+4/zQiehGzFsZj3nbqOZcnur6anjjdwXMq3C3cSkiTBIx8seWp
         imvm6MuICE32Q==
Date:   Wed, 12 Apr 2023 10:19:42 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Gao Xiang <xiang@kernel.org>,
        Christian Brauner <christian@brauner.io>,
        Seth Forshee <sforshee@kernel.org>
Cc:     "Christian Brauner (Microsoft)" <brauner@kernel.org>,
        Gao Xiang <hsiangkao@linux.alibaba.com>,
        Jingbo Xu <jefflexu@linux.alibaba.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: manual merge of the erofs tree with the vfs-idmapping
 tree
Message-ID: <20230412101942.75e3efa9@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/.xtQAdYkhqRQfAhjDYL6Ugx";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/.xtQAdYkhqRQfAhjDYL6Ugx
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the erofs tree got a conflict in:

  fs/erofs/xattr.c

between commit:

  a5488f29835c ("fs: simplify ->listxattr() implementation")

from the vfs-idmapping tree and commit:

  3f43a25918ac ("erofs: handle long xattr name prefixes properly")

from the erofs tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc fs/erofs/xattr.c
index 015462763bdd,a04724c816e5..000000000000
--- a/fs/erofs/xattr.c
+++ b/fs/erofs/xattr.c
@@@ -483,12 -517,28 +513,25 @@@ static int xattr_entrylist(struct xattr
  {
  	struct listxattr_iter *it =3D
  		container_of(_it, struct listxattr_iter, it);
- 	unsigned int prefix_len;
- 	const char *prefix;
+ 	unsigned int base_index =3D entry->e_name_index;
+ 	unsigned int prefix_len, infix_len =3D 0;
+ 	const char *prefix, *infix =3D NULL;
 -	const struct xattr_handler *h;
+=20
+ 	if (entry->e_name_index & EROFS_XATTR_LONG_PREFIX) {
+ 		struct erofs_sb_info *sbi =3D EROFS_SB(_it->sb);
+ 		struct erofs_xattr_prefix_item *pf =3D sbi->xattr_prefixes +
+ 			(entry->e_name_index & EROFS_XATTR_LONG_PREFIX_MASK);
+=20
+ 		if (pf >=3D sbi->xattr_prefixes + sbi->xattr_prefix_count)
+ 			return 1;
+ 		infix =3D pf->prefix->infix;
+ 		infix_len =3D pf->infix_len;
+ 		base_index =3D pf->prefix->base_index;
+ 	}
 =20
- 	prefix =3D erofs_xattr_prefix(entry->e_name_index, it->dentry);
 -	h =3D erofs_xattr_handler(base_index);
 -	if (!h || (h->list && !h->list(it->dentry)))
++	prefix =3D erofs_xattr_prefix(base_index, it->dentry);
 +	if (!prefix)
  		return 1;
 -
 -	prefix =3D xattr_prefix(h);
  	prefix_len =3D strlen(prefix);
 =20
  	if (!it->buffer) {

--Sig_/.xtQAdYkhqRQfAhjDYL6Ugx
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmQ1+R4ACgkQAVBC80lX
0GybjAf/X+LntMu+EtDw+XNnc7gPqGLEhfuTkSh9+1GlHt/QrYeelSixY39DRaUG
2XcbC7TjT7lL+pj5M4UDGLID7y/gR+tnfxd86H6JOOZ3IxIFWauNi1zWWCtY1IuP
Ckk/Ft0/jhDiPKhaKduWTqJUzyjx7Xd3yhlA0lkgMXaAjKTyy4nws/oGnrKdsolT
qAfkYbJb35mWdoMFfUGQio5GeBQ3d10E09MSBX/4h7/JL6hV2MsB+5wHi2VGSx4y
/k47ysnZ0QXUgSziGXT9V3JHOLqfoxKdz0gfo6bK7T6A6KSr8Dc6ouMkY1O6xgzP
9j3UPmfgNTETk1fH4NFpYe9M3qNiqA==
=JwzJ
-----END PGP SIGNATURE-----

--Sig_/.xtQAdYkhqRQfAhjDYL6Ugx--
