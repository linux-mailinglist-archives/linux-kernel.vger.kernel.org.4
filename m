Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73D286746F6
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 00:13:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231164AbjASXNg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 18:13:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230459AbjASXNA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 18:13:00 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D18171BDA;
        Thu, 19 Jan 2023 15:07:05 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4NydYg5Y5Pz4xyB;
        Fri, 20 Jan 2023 10:07:03 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1674169624;
        bh=AUNkEbOWS6yryE3zKFWOtGrLQV0LUL9PLQAx+MWRktw=;
        h=Date:From:To:Cc:Subject:From;
        b=LZsC1RlsVMz2rVsQM6pn/Iyns396gjQBynzMYaovl1mh7ydQut8uKnLaQLLfZ7+qa
         dhbvlHtsAv+X6kM3c6fS4rJVckLBIcLWUO7/Sgs5QARtxb0Eg9Azh81ZHGed43Qyfs
         YW7FHC7NCKoTwGuZrehX3rgwSbbt5P6f3rq2mXFqk/DZ75NZ9lJKNW6T3Nkb4d2Kyc
         l4HdB5ikNXxhwbhf2tGRpn/sLvyye3b6MY1moHHQhohLH4emtoZPPpewf8z5BLvhHQ
         BXpE9rXgs8HXZ4MM6ptwYXwtq3izlRyxCdHbw9N4vqlYaICdbYWQLnNp6T9qWRrW/P
         nmLi2HzZpKTAg==
Date:   Fri, 20 Jan 2023 10:07:02 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Jens Axboe <axboe@kernel.dk>,
        Christian Brauner <christian@brauner.io>,
        Seth Forshee <sforshee@kernel.org>
Cc:     Christian Brauner <brauner@kernel.org>,
        Ming Lei <ming.lei@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the block tree
Message-ID: <20230120100702.3d50dbb8@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/XU/02PuEmecstByf5LvN/aR";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/XU/02PuEmecstByf5LvN/aR
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the block tree, today's linux-next build (x86_64
allmodconfig) failed like this:

drivers/block/ublk_drv.c: In function 'ublk_char_dev_permission':
drivers/block/ublk_drv.c:2032:32: error: passing argument 1 of 'inode_permi=
ssion' from incompatible pointer type [-Werror=3Dincompatible-pointer-types]
 2032 |         err =3D inode_permission(&init_user_ns,
      |                                ^~~~~~~~~~~~~
      |                                |
      |                                struct user_namespace *
In file included from drivers/block/ublk_drv.c:15:
include/linux/fs.h:2474:22: note: expected 'struct mnt_idmap *' but argumen=
t is of type 'struct user_namespace *'
 2474 | int inode_permission(struct mnt_idmap *, struct inode *, int);
      |                      ^~~~~~~~~~~~~~~~~~

Caused by commit

  56f5160bc1b8 ("ublk_drv: add mechanism for supporting unprivileged ublk d=
evice")

interacting with commit

  4609e1f18e19 ("fs: port ->permission() to pass mnt_idmap")

from the vfs-idmapping tree.

I have applied the following merge fix patch.

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Fri, 20 Jan 2023 09:58:46 +1100
Subject: [PATCH] fixup for "ublk_drv: add mechanism for supporting unprivil=
eged ublk device"

interacting with "fs: port ->permission() to pass mnt_idmap"

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 drivers/block/ublk_drv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 9f32553cb938..d47d87be098f 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -2029,7 +2029,7 @@ static int ublk_char_dev_permission(struct ublk_devic=
e *ub,
 	if (stat.rdev !=3D ub->cdev_dev.devt || !S_ISCHR(stat.mode))
 		goto exit;
=20
-	err =3D inode_permission(&init_user_ns,
+	err =3D inode_permission(&nop_mnt_idmap,
 			d_backing_inode(path.dentry), mask);
 exit:
 	path_put(&path);
--=20
2.35.1

--=20
Cheers,
Stephen Rothwell

--Sig_/XU/02PuEmecstByf5LvN/aR
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmPJzRYACgkQAVBC80lX
0GxWFwgAnfHhaol7tcVGBA2EHWoRw+YqWK8SwDX9Kyd9oZe3aJFsM2mrrCFC+x2z
g7qB9yFNh4HmHNcAdGjC4mPQpGgJgoo/XKYM3ui5Rt+tFt6KyQWXk0N7GwtySzeA
a7HIRv900oE5b7JlqwBEU7zhrGF5G588COj6vn5RrWaLTy4WHk0wSpXbzvF3h9zT
o5flxK0QZvHXRlbK8Wx6uGjbfFe8xB2gOo290szdaBqruGKX7SR5CqXSGxVF2SKB
lQQ0ARQgWFEmgg2sayZ/ugvGYN2YFP93MVyzixp+kSW24tMvKWdl0y0dinkzf51p
sP1xMpmxPShYP3jA33eCURiGW91r9A==
=yC4Q
-----END PGP SIGNATURE-----

--Sig_/XU/02PuEmecstByf5LvN/aR--
