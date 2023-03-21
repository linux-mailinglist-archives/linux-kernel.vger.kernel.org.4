Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 124066C3E8B
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 00:33:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229983AbjCUXdj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 19:33:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbjCUXdh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 19:33:37 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2B8929155;
        Tue, 21 Mar 2023 16:33:35 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Ph7G42xHHz4xDr;
        Wed, 22 Mar 2023 10:33:32 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1679441614;
        bh=cuvZvLenFo9xJZQ7H4/4pFSqWf7/jIa4h3NdxgYWnJw=;
        h=Date:From:To:Cc:Subject:From;
        b=WVchBg3ZUOYqF/VlinwU/JTI4dQTLhi+iEkMOl5RoVWjx85qNOtyPjL5pWg7fsRMw
         VkCbV7L9ZmvfrpAoc2XDXZyFa/n/P6Llid9PRI+GSAtKQxhi28cj6hRhNNsgm0Kh/G
         amYTLohIgDQ3P3Z9MoL11AgwrOAAXOh12SUmFkzW/v5uPiASmStF4NOBo/knuq3UsN
         VI2l1tbirW+gCLR4zX4FxDGQl+Ul2P4k0ZwLIt/3vnKPD6sN3v2Xbx7jjjvWNN0L1K
         mmC0SQu8qerV0bGWPBZo+Nrnygyer+SG+S72axrfLEMP50Yztkd1CW1vz9BoJQyqxD
         OtIfXo5tVkSjQ==
Date:   Wed, 22 Mar 2023 10:33:31 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Axel Rasmussen <axelrasmussen@google.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>
Subject: linux-next: manual merge of the tip tree with the mm tree
Message-ID: <20230322103331.2ba61f0f@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/a4F2en8=SKIez.S5yiCWMa+";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/a4F2en8=SKIez.S5yiCWMa+
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the tip tree got a conflict in:

  mm/userfaultfd.c

between commit:

  a3b8390c1550 ("mm: userfaultfd: combine 'mode' and 'wp_copy' arguments")

from the mm tree and commit:

  74fd30bd28e4 ("mm: Make pte_mkwrite() take a VMA")

from the tip tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc mm/userfaultfd.c
index 7f1b5f8b712c,3db6f87c0aca..000000000000
--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@@ -76,8 -75,8 +76,8 @@@ int mfill_atomic_install_pte(pmd_t *dst
  	if (page_in_cache && !vm_shared)
  		writable =3D false;
  	if (writable)
- 		_dst_pte =3D pte_mkwrite(_dst_pte);
+ 		_dst_pte =3D pte_mkwrite(_dst_pte, dst_vma);
 -	if (wp_copy)
 +	if (flags & MFILL_ATOMIC_WP)
  		_dst_pte =3D pte_mkuffd_wp(_dst_pte);
 =20
  	dst_pte =3D pte_offset_map_lock(dst_mm, dst_pmd, dst_addr, &ptl);

--Sig_/a4F2en8=SKIez.S5yiCWMa+
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmQaPssACgkQAVBC80lX
0GzQGgf/W9v00GBvSfX8jHUgsKI8uGjuCmtqfM3T5yfANnayzJ7pZqUwt+cUjZKb
h48idjvgD9PcJZSpndvCKrAW5tY/3ewHtaAavWq4S46eUm0m+S/hHh6BgIoOM7Eo
rGm9Bo/eZBH52m9/hLkWGw30DNiJUKL4vUmHiu+upsiVSHl6GKKgZaEFIOdDKWlb
z/9m2cV8wVG632lcIva729mXb7SH1OqnCym2iBqpXvRJhRkw5enWTu7v1GejK4/s
FaR9v5X269AtyWD5yAv1I5xu/2dBFFVYuFhUxTVSqT8KrqpnKZhOzHFpoqVUjtZ5
xDwZFU4Z1Khxyn9c4xyX89d7nSQsxw==
=YQKP
-----END PGP SIGNATURE-----

--Sig_/a4F2en8=SKIez.S5yiCWMa+--
