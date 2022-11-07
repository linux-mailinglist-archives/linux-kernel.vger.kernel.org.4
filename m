Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEB3462026C
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 23:42:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232461AbiKGWmm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 17:42:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231796AbiKGWmj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 17:42:39 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECEC9205D3;
        Mon,  7 Nov 2022 14:42:36 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4N5mT34M5xz4xFs;
        Tue,  8 Nov 2022 09:42:31 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1667860951;
        bh=U+kbxtJxTH9fYySssrNYMYYLIujmaNtFz3LKMtodLE0=;
        h=Date:From:To:Cc:Subject:From;
        b=Q4MhUbZ6rtV7MYZbRlc8m/Go/9+1iHwlVG3PBC8B+M4n7C+JOCa1OJIqxCoaPXQzx
         OkpX/VjviwRrZMZurWTCOWC2T2Fc4auJA7dY+SYLrCN5q3T1eILDuOMqT4nkvnlntc
         W7/sFyhNTw8Omp/TDSONI1CRGckvVLVzebA9JhmK4S/PpxMPtA98O/BvVQX3bMRk37
         ygXl166HbE8KH4rmGwk9aoD37Ecdp5AAWrrjzlqQLQMMCLF7IAowYM5dgzGmDtYGhl
         F7DD9ZRRuvxPsTltNvymMh552jB4GYoD4JtXj34m4Kt4BpUmq2ZYPAo88qaFeAjYWK
         y8LgQnuC8X+wQ==
Date:   Tue, 8 Nov 2022 09:42:29 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     David Sterba <dsterba@suse.cz>
Cc:     David Sterba <dsterba@suse.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the btrfs tree
Message-ID: <20221108094229.1b530fec@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/oq=4tGTJq3rnBrFV.9E+Tky";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/oq=4tGTJq3rnBrFV.9E+Tky
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the btrfs tree, today's linux-next build (powerpc
ppc64_defconfig) failed like this:

ld: fs/btrfs/messages.o:(.opd+0x90): multiple definition of `abort_should_p=
rint_stack'; fs/btrfs/ctree.o:(.opd+0x270): first defined here
ld: fs/btrfs/messages.o: in function `.abort_should_print_stack':
messages.c:(.text.unlikely+0x55c): multiple definition of `.abort_should_pr=
int_stack'; fs/btrfs/ctree.o:ctree.c:(.text.unlikely+0x0): first defined he=
re

Caused by commit

  8bb808c6ad91 ("btrfs: don't print stack trace when transaction is aborted=
 due to ENOMEM")

from the btrfs-fixes tree interacting with commit

  c6f1e8101ccc ("btrfs: don't print stack trace when transaction is aborted=
 due to ENOMEM")

from the btrfs tree.

I applied the following merge fix for today.

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Tue, 8 Nov 2022 09:30:57 +1100
Subject: [PATCH] btrfs: fix up for "btrfs: don't print stack trace when
 transaction is aborted due to ENOMEM"

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 fs/btrfs/ctree.c | 16 ----------------
 1 file changed, 16 deletions(-)

diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
index 2e4a7b25ba81..8443a2e42fd5 100644
--- a/fs/btrfs/ctree.c
+++ b/fs/btrfs/ctree.c
@@ -120,22 +120,6 @@ noinline void btrfs_release_path(struct btrfs_path *p)
 	}
 }
=20
-/*
- * We want the transaction abort to print stack trace only for errors wher=
e the
- * cause could be a bug, eg. due to ENOSPC, and not for common errors that=
 are
- * caused by external factors.
- */
-bool __cold abort_should_print_stack(int errno)
-{
-	switch (errno) {
-	case -EIO:
-	case -EROFS:
-	case -ENOMEM:
-		return false;
-	}
-	return true;
-}
-
 /*
  * safely gets a reference on the root node of a tree.  A lock
  * is not taken, so a concurrent writer may put a different node
--=20
2.35.1

--=20
Cheers,
Stephen Rothwell

--Sig_/oq=4tGTJq3rnBrFV.9E+Tky
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmNpidUACgkQAVBC80lX
0GwsMwf/Yo57BmamBzthT5n24b76a3FASjnevkQEfAq474KGTmyFl9S++8MModXl
Bv5bZe6O4UhH9GGqp8OXU59AMPoV14R/qh3Q/CE1zFnomAZbfQm3UMtYMLjWhv9n
6ed6cbKMwmOo0z8YLYOsdQf80t62g1+VrciN98MXyUvucgdB6WmnnbqQxv/q6ses
gHdN1mXVl9+gJWPq7/3PjWgcdjDCexMQaVm7GLOcFFY3Symxc6SJAAn1iMCG1hnt
RzKy81Svx0PFYITNo2kt1zxGQqy3ovoGkxSeMYWczyz8IoOv/SvtOzLfowLqQlu6
RjGf5osNKjN6LGMTS961hL9TRyuHKA==
=BpnA
-----END PGP SIGNATURE-----

--Sig_/oq=4tGTJq3rnBrFV.9E+Tky--
