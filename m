Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0AE76CB309
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 03:16:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230432AbjC1BQW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 21:16:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbjC1BQV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 21:16:21 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1AFA1990;
        Mon, 27 Mar 2023 18:16:18 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4PlsFm4Fsvz4wj7;
        Tue, 28 Mar 2023 12:16:12 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1679966173;
        bh=irygyRkRlyX2cdL/E2vtShPNtwz4329GDBAPOp7SEl0=;
        h=Date:From:To:Cc:Subject:From;
        b=Q5vrpyoTsDF5+0B+vlRql4IaKVdbiOpbR89urQHTpRhixTy8iWXTOm3xUjbv0w5Zq
         Pu+Q4PWDYxvyF3C6UzFEOijDD8y+IqfnCIX36cr3VyuE678AYWy9gLwoyEg00PLokK
         UwjiqinGa0TpdsenRa2ITm3qj4sZOdy08yVCmWBjNySgM/mLEntw2rjl2kfGF/xc0r
         Lhc/uRwllasyUOjPbOcZZ/yI2ss3/Y5lkkVYUPvzfGeUU+WMyKtV+9kHBgR/WJs8ZZ
         P0rq1CLX8awa82+pWI4wb6aFaB5Pn0XnYWNRAITIfgQ/VleVCHlFm9c6HToB+jBwN2
         53Wst2b6xY8oQ==
Date:   Tue, 28 Mar 2023 12:16:09 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Bob Pearson <rpearsonhpe@gmail.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: manual merge of the rcu tree with the rdma tree
Message-ID: <20230328121609.68105dd5@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/bfS8Ymd/nxdZ._8SdcwmK4t";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/bfS8Ymd/nxdZ._8SdcwmK4t
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

FIXME: Add owner of second tree to To:
       Add author(s)/SOB of conflicting commits.

Today's linux-next merge of the rcu tree got a conflict in:

  drivers/infiniband/sw/rxe/rxe_mr.c

between commit:

  5bf944f24129 ("RDMA/rxe: Add error messages")

from the rdma tree and commit:

  330f72b82ab0 ("RDMA/rxe: Rename kfree_rcu() to kvfree_rcu_mightsleep()")

from the rcu tree.

I fixed it up (the code modified by the latter was moved by the former,
so I used this files from the former and applied the following merge fix
patch) and can carry the fix as necessary. This is now fixed as far as
linux-next is concerned, but any non trivial conflicts should be mentioned
to your upstream maintainer when your tree is submitted for merging.
You may also want to consider cooperating with the maintainer of the
conflicting tree to minimise any particularly complex conflicts.

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Tue, 28 Mar 2023 12:12:24 +1100
Subject: [PATCH] fixup for "RDMA/rxe: Add error messages"

interacting with "RDMA/rxe: Rename kfree_rcu() to kvfree_rcu_mightsleep()"

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 drivers/infiniband/sw/rxe/rxe_verbs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.c b/drivers/infiniband/sw/=
rxe/rxe_verbs.c
index 84b53c070fc5..bbdfbff5c752 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.c
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.c
@@ -1341,7 +1341,7 @@ static int rxe_dereg_mr(struct ib_mr *ibmr, struct ib=
_udata *udata)
 	if (cleanup_err)
 		rxe_err_mr(mr, "cleanup failed, err =3D %d", cleanup_err);
=20
-	kfree_rcu(mr);
+	kfree(mr);
 	return 0;
=20
 err_out:
--=20
2.39.2

--=20
Cheers,
Stephen Rothwell

--Sig_/bfS8Ymd/nxdZ._8SdcwmK4t
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmQiP9oACgkQAVBC80lX
0Gx9Tgf/eeuAd19cygA14gyTfW2H9c7btla27HFqlUK4zuMPCKigw6/BgUF72I4a
2KQIapTEnBy0jzPgvTvlqLFqMjVOGyuCV293i4vRPh2c+kyA2KQSdxGrKedp6dMj
CSKHUk42ly77tr+1n7v5AeOjriqs0k0zGYw1C8w4TCde9Fzt21ypsSxMg8R/fTkE
4/5S5MKqoIvPqc5JkvfoRAgEAFR4JHfdn+rsSk/YaDqj9VUZTh1CmDBgG0MkpYYV
pq25W6bx1NIKUySICTw64xqElSbxfVkBoxkPzRgTPG6eYC93dKY3lfssrIzQkrwI
g3CT7V67TqQZ9PlwrPyOKFCGhKR8tA==
=AccV
-----END PGP SIGNATURE-----

--Sig_/bfS8Ymd/nxdZ._8SdcwmK4t--
