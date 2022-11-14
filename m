Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 755D8628D44
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 00:18:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237933AbiKNXSH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 18:18:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230144AbiKNXSF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 18:18:05 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A02617044;
        Mon, 14 Nov 2022 15:18:04 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4NB4wk30hLz4xGW;
        Tue, 15 Nov 2022 10:17:58 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1668467879;
        bh=AkO5wUq+48NJL2GIFo2A3/BMLuj1DJya+5H8AbpVMB0=;
        h=Date:From:To:Cc:Subject:From;
        b=CDG0Qb2g6tb24y6QtEq3szJa6QpIO/Zc0CmQ/zXfO/jVBUUOCCOS3ClzvkJDw/F+h
         9HpXUdTyPveTZ0J0U/vSodODVzFel2K+mgcwxhE29EvpdyyYxdlAkN4E/YjYaJTZ/7
         pYPvrzvAd9/MZ0fxCV+zaSLXdnv2s+1Rp2u5jGSyqJdpsYgXOR4zze08e2GRevUq52
         Vjm4DbiFVDp41EfCwGDjGZnUjv156G0Nzkh8LYevKYlZs8pueI24K2Wvv2PtRvsyDp
         hLUBaA/TlE7Ys6LpS/ZNlkTYpcccNW1gPJf/5Jb6Ketowg8vKyQpqeAvGHG5KXYU4X
         at4YjmxcYJ0sA==
Date:   Tue, 15 Nov 2022 10:17:56 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        Christian Brauner <christian@brauner.io>,
        Seth Forshee <sforshee@kernel.org>
Cc:     "Christian Brauner (Microsoft)" <brauner@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the ntfs3 tree
Message-ID: <20221115101756.5d311f25@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_///Rd_36Lzfbtrb5J/ICyBMj";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_///Rd_36Lzfbtrb5J/ICyBMj
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the ntfs3 tree, today's linux-next build (x86_64
allmodconfig) failed like this:

fs/ntfs3/namei.c: In function 'ntfs_atomic_open':
fs/ntfs3/namei.c:374:39: error: implicit declaration of function 'get_acl' =
[-Werror=3Dimplicit-function-declaration]
  374 |                 struct posix_acl *p =3D get_acl(dir, ACL_TYPE_DEFAU=
LT);
      |                                       ^~~~~~~
fs/ntfs3/namei.c:374:39: error: initialization of 'struct posix_acl *' from=
 'int' makes pointer from integer without a cast [-Werror=3Dint-conversion]

Caused by commit

  2b108260ea2c ("fs/ntfs3: atomic_open implementation")

interacting with commit

  cac2f8b8d8b5 ("fs: rename current get acl method")

I have applied the following merge fix patch for today.

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Tue, 15 Nov 2022 10:07:59 +1100
Subject: [PATCH] fix up for "fs: rename current get acl method"

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 fs/ntfs3/namei.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ntfs3/namei.c b/fs/ntfs3/namei.c
index 20a6ac883312..c8db35e2ae17 100644
--- a/fs/ntfs3/namei.c
+++ b/fs/ntfs3/namei.c
@@ -371,7 +371,7 @@ static int ntfs_atomic_open(struct inode *dir, struct d=
entry *dentry,
 		 * ntfs_create_inode -> ntfs_init_acl -> posix_acl_create ->
 		 * ntfs_get_acl -> ntfs_get_acl_ex -> ni_lock
 		 */
-		struct posix_acl *p =3D get_acl(dir, ACL_TYPE_DEFAULT);
+		struct posix_acl *p =3D get_inode_acl(dir, ACL_TYPE_DEFAULT);
=20
 		if (IS_ERR(p)) {
 			err =3D PTR_ERR(p);
--=20
2.35.1

--=20
Cheers,
Stephen Rothwell

--Sig_///Rd_36Lzfbtrb5J/ICyBMj
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmNyzKQACgkQAVBC80lX
0Gxa/gf+JlK/GyThY4UbYKWO20W7DyJvmXQjPdvkRrMu9Zv4mWLNeao5rfba8ZKm
GfYGEU8Itj261EvSflpcOKAGSHRDqpj6g7z2WdU45W1ILyEe7Addhzg2Wl153FDA
GquyxC5sDRNsJHp46frUDSqSeRYs+K3K+foWogrBCkjw3OSuzbBRcN9Xuq22aQqv
B0ErY41ADYLOUug9U4ZcqW0C+oeRU377cchfAQJPKsU/dAu5KSNlnn8RhLk+0J5D
pnTrHXbo/U3Ipx/cUrC6y5Cy/mp12XduMdmX3Z+D5QWa3/kS2Br5A/UZtXlmeC0F
NtoZvEWR/ERDdVCR8e2ntcGEqFQ/2A==
=7QN7
-----END PGP SIGNATURE-----

--Sig_///Rd_36Lzfbtrb5J/ICyBMj--
