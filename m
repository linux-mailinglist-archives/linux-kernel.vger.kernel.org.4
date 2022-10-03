Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA3DA5F395D
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 00:52:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229820AbiJCWwR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 18:52:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229699AbiJCWwL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 18:52:11 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B19F25AA31;
        Mon,  3 Oct 2022 15:52:02 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4MhGL76HbJz4xGm;
        Tue,  4 Oct 2022 09:51:59 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1664837520;
        bh=NH2fXVb5QPJSxdCwtiNP9l5D5uYongrN5XYSj/TBT+Y=;
        h=Date:From:To:Cc:Subject:From;
        b=RVjpuXK6u2TdwT9SnHxVHcrJ1U/WCbRUD/T5MryTTdDv2s8w9I9N3tmY92KaZ83/C
         lgYRtyYZvhOoEseJ4B3sDoFdr0CNSeXvE3MR0pJB6q4RgUBxIZV9T2zeYHPSd9D+Mm
         1tTqkoFzeVXSHQU3pqzAK3ANDk4uROz5hnKvfR7NFi8Vc2EiV9anxtkEJ5KS6/QUFn
         0UVqZNf+sPfVvRjIuafXCtyhQe9CTAXft3hjWz5SN9s3P1moTF7rdu2SxZKGr1uuJG
         hEuddfRtriiqY/Y749Ut753Th1qmV2MCEthPs7Y1UKACBZOoDtLT9e0Oe5m20uYJjI
         VLBE6y6hQrUiQ==
Date:   Tue, 4 Oct 2022 09:51:58 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Eric Biggers <ebiggers@kernel.org>,
        Jaegeuk Kim <jaegeuk@kernel.org>
Cc:     Eric Biggers <ebiggers@google.com>,
        Eunhee Rho <eunhee83.rho@samsung.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: manual merge of the statx-dioalign tree with the f2fs
 tree
Message-ID: <20221004095158.46d920d0@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/YoSfrYe09LcF.ZOKojuncHc";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/YoSfrYe09LcF.ZOKojuncHc
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the statx-dioalign tree got a conflict in:

  fs/f2fs/f2fs.h

between commit:

  2958e881d590 ("f2fs: allow direct read for zoned device")

from the f2fs tree and commit:

  2db0487faa21 ("f2fs: move f2fs_force_buffered_io() into file.c")

from the statx-dioalign tree.

I fixed it up (I used the latter version of this file and applied the
following merge fix patch) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

=46rom c5beb9e5e8c4a68c68dfbca7ddd21afa4ba3fa57 Mon Sep 17 00:00:00 2001
From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Tue, 4 Oct 2022 09:48:22 +1100
Subject: [PATCH] f2fs: fix up for "f2fs: allow direct read for zoned device"

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 fs/f2fs/file.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index b1135f584677..996aad7c1e34 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -822,7 +822,12 @@ static bool f2fs_force_buffered_io(struct inode *inode=
, int rw)
 	/* disallow direct IO if any of devices has unaligned blksize */
 	if (f2fs_is_multi_device(sbi) && !sbi->aligned_blksize)
 		return true;
-
+	/*
+	 * for blkzoned device, fallback direct IO to buffered IO, so
+	 * all IOs can be serialized by log-structured write.
+	 */
+	if (f2fs_sb_has_blkzoned(sbi) && (rw =3D=3D WRITE))
+		return true;
 	if (f2fs_lfs_mode(sbi) && rw =3D=3D WRITE && F2FS_IO_ALIGNED(sbi))
 		return true;
 	if (is_sbi_flag_set(sbi, SBI_CP_DISABLED))
--=20
2.35.1

--=20
Cheers,
Stephen Rothwell

--Sig_/YoSfrYe09LcF.ZOKojuncHc
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmM7Z44ACgkQAVBC80lX
0GzSaAf6At+Cku82hhJVoxsLwMuvF7E1jcw8xuG6etosolGx4MJ7Hw64hk7a+B6X
Y9MOPIRZKg4PBeVnXLHva5efllbV2nLajpp6LwNVn1/5ry8n7HeJhpSW3vHQseYD
ILSWglOmr0F394e3dOARzGDLptbynBGWv2PXpG6GkKfqz5jWOz/xixUC8GeDqnRW
MXseL+OpsqxVOL95W/MG4NyywrD+huT4srnqmKTIebmE479C2zk2gXfrd/LfAP+C
1emaFEZoAqrIjmsQ33+TkfNLXpYB9uHgsl7nxJUlhqOdYeVL8J5OamwGcCaMKss4
pAfNfviNASmcqakCjZK2cAFqQ5+enA==
=22ew
-----END PGP SIGNATURE-----

--Sig_/YoSfrYe09LcF.ZOKojuncHc--
