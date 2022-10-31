Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F34986141CE
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 00:29:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229970AbiJaX3l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 19:29:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229707AbiJaX3X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 19:29:23 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1CF015FFC;
        Mon, 31 Oct 2022 16:28:53 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4N1Tqh6gmWz4xG6;
        Tue,  1 Nov 2022 10:28:48 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1667258929;
        bh=EobGCR5OS2bog5PZfGzOEYsmFg5dsfh7cCbyk4MhpG8=;
        h=Date:From:To:Cc:Subject:From;
        b=TY6YGwrCCzMunKpwsSnRYSg3y2HrCLb9BaLICyw15/W04SIBxaORLcFS9hXAmRuXT
         H/SQlGm9z7NHE/MzrEQilKHo9Gz0hLHUG/dBhQxnxh8Edbj6o0Wle6vdN96TGCgpvP
         tqRzsGxQqe7hGM7fMRv2euFBpmEZbnvDGybqsTQ6NXBxYUbHp3VuF7S91dooIPfUrD
         VX/CiQBlOvBLNNsRIAjvr4cg2NzrlNhtUYG1cE9DsS4A360DWsDF7sFgWOa9ahNCjf
         gZsrLJQhyVCgxtNtXkVa/E0ZLEij5qGwLYdQ2XcxZv1BiNpYIaN7lotMnhFoo2+6xw
         AtymNNjaqJnBg==
Date:   Tue, 1 Nov 2022 10:28:28 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     David Sterba <dsterba@suse.cz>
Cc:     David Sterba <dsterba@suse.com>, Filipe Manana <fdmanana@suse.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: manual merge of the btrfs tree with the btrfs-fixes
 tree
Message-ID: <20221101102828.7c6e1597@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/AuxTFf5vpZqD2Bfakwc9L3/";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/AuxTFf5vpZqD2Bfakwc9L3/
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the btrfs tree got a conflict in:

  fs/btrfs/ctree.h

between commit:

  8184620ae212 ("btrfs: fix lost file sync on direct IO write with nowait a=
nd dsync iocb")

from the btrfs-fixes tree and commit:

  d98f802c975e ("btrfs: move inode prototypes to btrfs_inode.h")

from the btrfs tree.

I fixed it up (I used the latter version of this file and applied the
following merge fix patch) and can carry the fix as necessary. This is
now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your
tree is submitted for merging.  You may also want to consider
cooperating with the maintainer of the conflicting tree to minimise any
particularly complex conflicts.

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Tue, 1 Nov 2022 10:24:24 +1100
Subject: [PATCH] fix up for "btrfs: fix lost file sync on direct IO write w=
ith nowait and dsync iocb"

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 fs/btrfs/btrfs_inode.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/btrfs_inode.h b/fs/btrfs/btrfs_inode.h
index 79a9f06c2434..d21c30bf7053 100644
--- a/fs/btrfs/btrfs_inode.h
+++ b/fs/btrfs/btrfs_inode.h
@@ -526,7 +526,10 @@ ssize_t btrfs_encoded_read(struct kiocb *iocb, struct =
iov_iter *iter,
 ssize_t btrfs_do_encoded_write(struct kiocb *iocb, struct iov_iter *from,
 			       const struct btrfs_ioctl_encoded_io_args *encoded);
=20
-ssize_t btrfs_dio_rw(struct kiocb *iocb, struct iov_iter *iter, size_t don=
e_before);
+ssize_t btrfs_dio_read(struct kiocb *iocb, struct iov_iter *iter,
+		       size_t done_before);
+struct iomap_dio *btrfs_dio_write(struct kiocb *iocb, struct iov_iter *ite=
r,
+				  size_t done_before);
=20
 extern const struct dentry_operations btrfs_dentry_operations;
=20
--=20
2.35.1

--=20
Cheers,
Stephen Rothwell

--Sig_/AuxTFf5vpZqD2Bfakwc9L3/
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmNgWhwACgkQAVBC80lX
0Gx20gf/TXJ/+Ec7eGO7JJvwaR5oh8UHMcgnaaNkDITZKlzmooFg+IGWnGagnveK
WyD5cJpiUXerKa0wq49OkuPv2rM2Y4YueyyvxHIcVWE55sVo4uYC/vcXRcq5ysd1
lmzRLWIjxh6Jo0Ft9z99zMQhpFDI7wROY82j1HuR6hWIramouFCAPt0UYrKGWJ6N
yIsmEzJHhzzaACIUJvU41cubxOg5grXOWIZ7bjQfB03ozOhJ4jomgSpBwkSi1hX/
1e19xpxCGazgO++HQhrNJrXZK54rD8U51h3+3x8vGMS42x9lVUBu4n7S2Q9D5Dnk
EjCrIthbXtNNb+thWmV9YAAJkL4kcw==
=P/BP
-----END PGP SIGNATURE-----

--Sig_/AuxTFf5vpZqD2Bfakwc9L3/--
