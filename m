Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 841355F741A
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 08:05:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229495AbiJGGFv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Oct 2022 02:05:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbiJGGFr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Oct 2022 02:05:47 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF92689AF9;
        Thu,  6 Oct 2022 23:05:44 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4MkHqC2rxVz4xGR;
        Fri,  7 Oct 2022 17:05:43 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1665122743;
        bh=IuzOLYlDmKAReAVENiwg9bqkNmjWfF6Paz8MXK4+c8k=;
        h=Date:From:To:Cc:Subject:From;
        b=sal45leu0vqaHR1rY5qVz8LPCEF36/pcgfQS6Z9MetKJcJTLIetYyqTddg9goIfb8
         xVlYTIk1CCOI6L6zCHm63ccS6hHofiEAD3cs29qd8nnKpg82jpHWfT8NfIO780ysA/
         rLtd3eBppVBiKFKvB/WdYg7drCVB9epYX7Q4VdmVUp/8Jrmu+FujmFSylqfpSij+jO
         trQVXbykTq7BgzeDne3LLOFgfq1Nl1bG0EZuARsMwUZRogbMfuuLi98mZYGbJPDJIT
         ocae6Va/WUx2Pq564G3nU3DvK5LuTEEWWP6G6sxcpSNEe557hFN9oM+mEmHp6iUU2W
         QYEBVkYUodiHg==
Date:   Fri, 7 Oct 2022 17:05:42 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Theodore Ts'o <tytso@mit.edu>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: manual merge of the mm-stable tree with the random tree
Message-ID: <20221007170542.1a117005@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/EZ8COJNN.hayHXnv_YBZXaX";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/EZ8COJNN.hayHXnv_YBZXaX
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the mm-stable tree got a conflict in:

  mm/migrate.c

between commit:

  82f33a32b4d2 ("treewide: use prandom_u32_max() when possible")

from the random tree and commit:

  6c542ab75714 ("mm/demotion: build demotion targets based on explicit memo=
ry tiers")

from the mm-stable tree.

I fixed it up (the call to get_random_int() was replaced by node_random()
by the latter commit) and can carry the fix as necessary. This is now
fixed as far as linux-next is concerned, but any non trivial conflicts
should be mentioned to your upstream maintainer when your tree is
submitted for merging.  You may also want to consider cooperating with
the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

--Sig_/EZ8COJNN.hayHXnv_YBZXaX
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmM/wbYACgkQAVBC80lX
0GycUAf+KA3awlUL017m7uNPqAXoWjGhndEZfBlSQFhsifJwfQs5PI51e67Tse+C
pCwSiKn1+urNfwp6qNaSl25abzO1R3ZfXn8GBqgbnnra1juJ2y294OP3zoNdyO2G
gIAephb/pHYv/+sgQLCS1U7/+mzMGfWDcZp9VNwuAKjlE2Jw6bgNAMtnCpZcEjoz
WaF5dc/mDWORQCVYmBMZJ+D7TXg1XTRorbpPiOGmxsJVda2ucRfWC/3jrMLWy7de
VParLtzIpa5EPVteumexcSSnhB5oUbGLPvMgVJs5ptje8BYuAmb7gAztxmL/+PZg
boD2hX7IxrBL+xDCj0hGTvFU1s3ftQ==
=2Z+0
-----END PGP SIGNATURE-----

--Sig_/EZ8COJNN.hayHXnv_YBZXaX--
