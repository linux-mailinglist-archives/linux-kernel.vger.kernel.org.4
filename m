Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 070565F73D9
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 07:14:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229562AbiJGFOU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Oct 2022 01:14:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbiJGFOR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Oct 2022 01:14:17 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F206C4596;
        Thu,  6 Oct 2022 22:14:15 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4MkGgn2ZQSz4xFv;
        Fri,  7 Oct 2022 16:14:13 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1665119653;
        bh=bBEDeipVgNbzmG+3HvynDelgIvaeB51mFotxCJoDvxM=;
        h=Date:From:To:Cc:Subject:From;
        b=DR81GCC2iM8M3BS5SjpggmrnsrreluL0cij46sqsoqh76eYT246sUaZ2LXJScRLQz
         UkMLA0UUNsoj2JyQlG/VbpvdbRtumzCXtpmvEM6vbIvQ3MDMefzJNkL9wwIYOPa9yH
         SmhvvYujrNsKEsLz3pbWK72pucQdWKqUN5asFueX7UETW+Zj6QFjyZefgmYpVN1OW6
         HifwDMwHhYhMufcbWugm7yNz257UaOu6vxIhhxmFNf6BVLlKh+bZ6gZciG03Vj1NJI
         Qq2Rw/A324JblRNWAOx6AwSSDbgxwgMysHD6REUY6vqW1t6OJQnIZUn9YI835wU3tP
         PPRTuEIjrE2Xw==
Date:   Fri, 7 Oct 2022 16:14:11 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Yury Norov <yury.norov@gmail.com>, Theodore Ts'o <tytso@mit.edu>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: manual merge of the bitmap tree with the random tree
Message-ID: <20221007161411.731900ea@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/OiUmqq1Gv.aK1CxN1TwQ72d";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/OiUmqq1Gv.aK1CxN1TwQ72d
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the bitmap tree got a conflict in:

  include/linux/nodemask.h

between commit:

  82f33a32b4d2 ("treewide: use prandom_u32_max() when possible")

from the random tree and commit:

  97848c10f9f8 ("lib/bitmap: remove bitmap_ord_to_pos")

from the bitmap tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc include/linux/nodemask.h
index 66ee9b4b7925,0c45fb066caa..000000000000
--- a/include/linux/nodemask.h
+++ b/include/linux/nodemask.h
@@@ -508,8 -508,7 +508,7 @@@ static inline int node_random(const nod
 =20
  	w =3D nodes_weight(*maskp);
  	if (w)
- 		bit =3D bitmap_ord_to_pos(maskp->bits,
- 			prandom_u32_max(w), MAX_NUMNODES);
 -		bit =3D find_nth_bit(maskp->bits, MAX_NUMNODES, get_random_int() % w);
++		bit =3D find_nth_bit(maskp->bits, MAX_NUMNODES, prandom_u32_max(w));
  	return bit;
  #else
  	return 0;

--Sig_/OiUmqq1Gv.aK1CxN1TwQ72d
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmM/taMACgkQAVBC80lX
0GzRaAf8CFkTkls6EB0rpUKgQ1v1+Ar7qEXVpfWeYjuB4oXySs6l4PhKs3QQjK0D
fF1ORKumvYs57W+3vV7p5yptr4liZ8YEYZXna4czbgFJSgtLtcVkfEETHtdKVjEN
BlhDUWnxSbgxpPvqfYC49sZOhMbFhDrSqWnXFeVyQcjrtw/kSczo6LN7poV9IN1a
We6JsJ3q9SDDTmL25MraCuYNXzKhkQNTqXkjXvnmCLpTB2eXc5/6teE6SP5Ydp99
9z65Sf3GV6LZe9JQFbyVZKxbHutAvWm0p7cj7lVapWqrw+AuDKJMcJmMZ46uFr1Q
21Ny0ZB0Vu6SbLoeGSoGcf2DgoJAIg==
=GCAe
-----END PGP SIGNATURE-----

--Sig_/OiUmqq1Gv.aK1CxN1TwQ72d--
