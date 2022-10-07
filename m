Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AE235F740A
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 07:56:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229566AbiJGFz5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Oct 2022 01:55:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbiJGFzz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Oct 2022 01:55:55 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C682B7EEF;
        Thu,  6 Oct 2022 22:55:52 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4MkHbp309rz4xFv;
        Fri,  7 Oct 2022 16:55:50 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1665122151;
        bh=50czjMLwbxFJmkK7HEnTwMee46IDmtFmhjT3QySpFLw=;
        h=Date:From:To:Cc:Subject:From;
        b=l4f04jwjrebnewIlj0KixAQMB9JM3xYSZ49go1jqfg5FnON2pkfuWWm0fVxaGE6Ve
         SW+jsHzgbOGM3nkZ6nGxuO9ue+3Tn6Wu3g6otjkYtJFtgj3GBQIK5w6ItBVICg0laY
         bWNzHpqTqNAolMLxNlHBgJw0Wui7M4nRTd5iV3Z08rn6aNFFGQ+SCqh2dWYtJKop5h
         LnswLrHRiMwC92mEpKkk/pE1rKAQyMKYRbwr5sa965rET7/grcejzrDQwVJTehptGg
         PDtJ/BpAhFYJDXXWGCE+KqUBjprDjh+hQlmwB0mdXGbi7rarr+X/d0VNoyZYCLAn+6
         3hkf3kNIhJDtw==
Date:   Fri, 7 Oct 2022 16:55:48 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Theodore Ts'o <tytso@mit.edu>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: manual merge of the mm-stable tree with the random tree
Message-ID: <20221007165548.0b07e256@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/zFPSr2/ECX_g6sc81=MTxSB";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/zFPSr2/ECX_g6sc81=MTxSB
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the mm-stable tree got a conflict in:

  include/linux/nodemask.h

between commit:

  82f33a32b4d2 ("treewide: use prandom_u32_max() when possible")

from the random tree and commit:

  3e061d924fe9 ("lib/nodemask: optimize node_random for nodemask with singl=
e NUMA node")

from the mm-stable tree.

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
index 6f8a09e41cec,e66742db741c..000000000000
--- a/include/linux/nodemask.h
+++ b/include/linux/nodemask.h
@@@ -504,11 -505,21 +505,20 @@@ static inline int num_node_state(enum n
  static inline int node_random(const nodemask_t *maskp)
  {
  #if defined(CONFIG_NUMA) && (MAX_NUMNODES > 1)
- 	int w, bit =3D NUMA_NO_NODE;
+ 	int w, bit;
 =20
  	w =3D nodes_weight(*maskp);
- 	if (w)
+ 	switch (w) {
+ 	case 0:
+ 		bit =3D NUMA_NO_NODE;
+ 		break;
+ 	case 1:
+ 		bit =3D first_node(*maskp);
+ 		break;
+ 	default:
 -		bit =3D bitmap_ord_to_pos(maskp->bits,
 -					get_random_int() % w, MAX_NUMNODES);
 +		bit =3D find_nth_bit(maskp->bits, MAX_NUMNODES, prandom_u32_max(w));
+ 		break;
+ 	}
  	return bit;
  #else
  	return 0;

--Sig_/zFPSr2/ECX_g6sc81=MTxSB
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmM/v2QACgkQAVBC80lX
0GyH1Af/TTgOxNqWFq1DhB/STWGG1izW4Evqz7xiNk4Y3LcVOu5CyZhfdiNxJmy3
7VwCFW2+untJLGIvUwYKpXyi3fu+8TZMsQ0woAba+dJnWFt6PwYkwuZgJzW9fSNw
9yYgiv7xO51ET2zA/emyZ7ifx5oyV+UCczGr7eD+J2I1OEhkLOEl8fNtAs6gbHVC
bj6XYlLTna5ezXf3WCxCLOxOc79DjNueU6I+dqzGVj+/8zQbLzC4mSU+ypzIdBnj
SjOE6uyuyJrczMK2czLx+cr8bBWf0wjhVJLrbqGtlddx4CRqeOBNl8ceBlNXcsjK
rk6b2H1MgGh0wcAxdBBvuiuQNJnHbA==
=bSBi
-----END PGP SIGNATURE-----

--Sig_/zFPSr2/ECX_g6sc81=MTxSB--
