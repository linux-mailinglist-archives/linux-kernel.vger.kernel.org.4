Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82EC17394EB
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 03:53:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229624AbjFVBw6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 21:52:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230158AbjFVBw4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 21:52:56 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 914D31BD9;
        Wed, 21 Jun 2023 18:52:52 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Qmk0H5YbVz4x04;
        Thu, 22 Jun 2023 11:52:47 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1687398768;
        bh=7C1ysdxUmJFw6qFlaEcbsPZAGNkDZMoL+CemQaGVg9E=;
        h=Date:From:To:Cc:Subject:From;
        b=OlgEXyTxjIPNuS+26+vBmH/saS/0llUCBIsYxPdzW1TP/FEdmVWmsyeaw6UqP0Q0T
         64OKz50lQKPncGgdKuK+SUACO9+u4pM1s/h7x/H+0q4ADWQJdygzHtGfxmcY1McFoy
         s85npCb2tbP+K+rR67CDUDFAihVguST11oc+/VSdhuXzxBj0/cf7aQbCccH5vvSgMG
         pGmkN7R/dBbeTAODHCKZjxdVnymEreW9FKttP9n+Rej2GoJc4VEEzzZUZTUNi/armF
         rIIai8dzmVcs6nY/9qOb0zpUl+TJqMC8sMTx9dLGhlmOjh8NjksnQkVDT/g0ueULcS
         jOU7OOVajmCww==
Date:   Thu, 22 Jun 2023 11:52:46 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Bob Pearson <rpearsonhpe@gmail.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: manual merge of the rdma tree with Linus' tree
Message-ID: <20230622115246.365d30ad@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/gJH==1cKP9Yw_mWFpNapbUz";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/gJH==1cKP9Yw_mWFpNapbUz
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the rdma tree got a conflict in:

  drivers/infiniband/sw/rxe/rxe_cq.c

between commit:

  0c7e314a6352 ("RDMA/rxe: Fix rxe_cq_post")

from the origin tree and commit:

  350b6dd4b2f8 ("RDMA/rxe: Simplify cq->notify code")

from the rdma tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc drivers/infiniband/sw/rxe/rxe_cq.c
index 6ca2a05b6a2a,31a25aaa44a0..000000000000
--- a/drivers/infiniband/sw/rxe/rxe_cq.c
+++ b/drivers/infiniband/sw/rxe/rxe_cq.c
@@@ -113,10 -113,11 +113,9 @@@ int rxe_cq_post(struct rxe_cq *cq, stru
 =20
  	queue_advance_producer(cq->queue, QUEUE_TYPE_TO_CLIENT);
 =20
- 	if ((cq->notify =3D=3D IB_CQ_NEXT_COMP) ||
- 	    (cq->notify =3D=3D IB_CQ_SOLICITED && solicited)) {
 -	spin_unlock_irqrestore(&cq->cq_lock, flags);
 -
+ 	if ((cq->notify & IB_CQ_NEXT_COMP) ||
+ 	    (cq->notify & IB_CQ_SOLICITED && solicited)) {
  		cq->notify =3D 0;
-=20
  		cq->ibcq.comp_handler(&cq->ibcq, cq->ibcq.cq_context);
  	}
 =20

--Sig_/gJH==1cKP9Yw_mWFpNapbUz
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmSTqW4ACgkQAVBC80lX
0Gw4uwf+KLzc62nxBw6zlD4lV17Wc1xyxIUIACuA0iXfe5/5dhp68eYTiILXYa1+
79S7sspc/uRO8YNVRYfnMH+2sO4lp00cVOFrw2YDi8mltA+EpUp5WZPvoYKUnzrl
ThAixpUbRaf544B9nwPBZLvlmJ/rs/CeIpRu2PwA2nNfQrdJo8qp77HxC5hWTPhS
Ak8HX1mKDOde+oGhCUWFVJ5qoBemamfFUDHlYYV639cwSCwE1ZROW6qYtXPKueNH
YaMuTtWikmhe/01yoWjp0cmtp1AfJYvuK9nafa+/bqek8TtYJVFIMsHYQvVtsaDH
m79NdflDGlC0Y3Wp+JTlZtVG6nhd5A==
=Xl0E
-----END PGP SIGNATURE-----

--Sig_/gJH==1cKP9Yw_mWFpNapbUz--
