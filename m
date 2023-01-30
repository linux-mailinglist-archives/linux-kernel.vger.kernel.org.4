Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8B17681F76
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 00:14:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230062AbjA3XOk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 18:14:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230058AbjA3XOi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 18:14:38 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CDD81CAEF;
        Mon, 30 Jan 2023 15:14:31 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4P5PC95lNtz4x1d;
        Tue, 31 Jan 2023 10:14:29 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1675120470;
        bh=1NPCECl8cFvSKrhix1qJjN0ZBmuleVasqwSfFxjJOQc=;
        h=Date:From:To:Cc:Subject:From;
        b=IsR3sChAJkHQFoG60SBLza3p6WGbXEESoICU7jTuaRqZ6mN03MACFwGIpki3O/uU0
         AVEwMpKEgCG/qqoT4dzZXkTKUnLt4ZQiaShzJZZSKZ0TT+XcKVu5Uh7Y8GPvQe/nak
         Mb67Z6LiYm6FGMjoTdrvOKyDlBrH12nOzk+0JUhals3ESpkkNiBeYsj0No+4qpa0tw
         Nosh9mfXimwPfbokIRerFiEvanq0IjuT6h58GK0VqFVzZrfxizwZu7KFMyCYjPd1hl
         j1N1oMjkhywPKIFSkS8Omdp6cOf1puX/FNEh2b0drHmLkU3zKyyr6oVvFDO1rlVybn
         7gMcHULAa6Jzg==
Date:   Tue, 31 Jan 2023 10:12:44 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Jaegeuk Kim <jaegeuk@kernel.org>,
        Christian Brauner <christian@brauner.io>,
        Seth Forshee <sforshee@kernel.org>
Cc:     Chao Yu <chao@kernel.org>, Christian Brauner <brauner@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: manual merge of the f2fs tree with the vfs-idmapping
 tree
Message-ID: <20230131101244.26f85f35@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/Jy=oOH1dTIlGK12s8WfgmxL";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/Jy=oOH1dTIlGK12s8WfgmxL
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the f2fs tree got a conflict in:

  fs/f2fs/namei.c

between commit:

  f2d40141d5d9 ("fs: port inode_init_owner() to mnt_idmap")

from the vfs-idmapping tree and commit:

  8abe4be45132 ("f2fs: remove unneeded f2fs_cp_error() in f2fs_create_white=
out()")

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

diff --cc fs/f2fs/namei.c
index d8e01bbbf27f,82923273f4bb..000000000000
--- a/fs/f2fs/namei.c
+++ b/fs/f2fs/namei.c
@@@ -923,13 -923,10 +923,10 @@@ static int f2fs_tmpfile(struct mnt_idma
  	return finish_open_simple(file, err);
  }
 =20
 -static int f2fs_create_whiteout(struct user_namespace *mnt_userns,
 +static int f2fs_create_whiteout(struct mnt_idmap *idmap,
  				struct inode *dir, struct inode **whiteout)
  {
- 	if (unlikely(f2fs_cp_error(F2FS_I_SB(dir))))
- 		return -EIO;
-=20
 -	return __f2fs_tmpfile(mnt_userns, dir, NULL,
 +	return __f2fs_tmpfile(idmap, dir, NULL,
  				S_IFCHR | WHITEOUT_MODE, true, whiteout);
  }
 =20

--Sig_/Jy=oOH1dTIlGK12s8WfgmxL
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmPYTuwACgkQAVBC80lX
0GwBagf/TGt9UbacvbykFcjl7F9l9hxIQmz028e7wYvp1YX5thIU8sK4rI/VZcCA
7GfzNxj5xzBW7GkMJN1Lnb62VW9N39Y1891h/1b2neQQb8MG6COK1tEvCVYFmUoQ
DN42Ili9ryjpwNkXl3VwTljuDw4eXRjS0oeKftYIAP6NBRrkWSY6jz6VCMbuvc8j
x8q/tVve8ooNztrxHPTnHNQGl1Dba+dO9xg07o/kj7QmX+gLBhRFIsoqlwQ0EuLI
rbe3YZtRCCLR3AekEhxryhoecEAiqRvqLds2jwDCjnNUVvza83gJX8KwW5WWrhDO
ZXgWJc+rZ64cUX7z1sX3vAO4ozkD5w==
=KBPc
-----END PGP SIGNATURE-----

--Sig_/Jy=oOH1dTIlGK12s8WfgmxL--
