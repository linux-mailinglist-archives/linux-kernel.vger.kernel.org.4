Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A33F0623C2B
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 07:56:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232318AbiKJG4H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 01:56:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232714AbiKJG4A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 01:56:00 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C0CD31EF9;
        Wed,  9 Nov 2022 22:55:55 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4N7CKP4MH3z4xYY;
        Thu, 10 Nov 2022 17:55:53 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1668063354;
        bh=TiZs+SEY1PgsVCWcuX9sf03rYQ9hc0zKFA0Q8uNqsXQ=;
        h=Date:From:To:Cc:Subject:From;
        b=M7MtsNyoelh+ptrpbponh/mYrNdgkqI2XNOSb9PPVucxUnvVLQ3kbvrEuRPxMERq/
         6S7UJs27yMB+FEVGm13oaLdTaEeNSbu+YFSiKgsBvOQcwGHc2j9rZes0otnsbj6A7J
         +xsiIKCgCIWo2w7OFdfV8YDcK+5BSdCf8GXJ+T7ABh8hfV/U+78VwTELtbfwAeKFqZ
         B8nSK+wIP8+jrnX1pTlGUw3IpDR0fbRw5ShR+iZntohFVdaLXFf5ECvwrOO4Wy36co
         hj1ht4R4ancodGYUVs6ohccX19nRyK8IGg0lZkLjEU3nIpGLYnWwQYUxpps8evjhMi
         YWULYmLVVyINw==
Date:   Thu, 10 Nov 2022 17:55:52 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Jens Axboe <axboe@kernel.dk>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Logan Gunthorpe <logang@deltatee.com>
Subject: linux-next: manual merge of the mm tree with the block tree
Message-ID: <20221110175552.20587f28@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/bdPeSYhZzibRieP0Jg7JKnO";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/bdPeSYhZzibRieP0Jg7JKnO
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the mm tree got conflicts in:

  mm/gup.c
  mm/huge_memory.c

between commits:

  0f0892356fa1 ("mm: allow multiple error returns in try_grab_page()")
  4003f107fa2e ("mm: introduce FOLL_PCI_P2PDMA to gate getting PCI P2PDMA p=
ages")

from the block tree and commit:

  7928e6cb4ec6 ("mm/gup: drop DAX pgmap accounting")

from the mm tree.

I fixed it up (I think - see below) and can carry the fix as
necessary. This is now fixed as far as linux-next is concerned, but any
non trivial conflicts should be mentioned to your upstream maintainer
when your tree is submitted for merging.  You may also want to consider
cooperating with the maintainer of the conflicting tree to minimise any
particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc mm/gup.c
index 8a4b1a783cb6,5182abaaecde..000000000000
--- a/mm/gup.c
+++ b/mm/gup.c
@@@ -2482,26 -2394,10 +2406,13 @@@ static int __gup_device_huge(unsigned l
  	do {
  		struct page *page =3D pfn_to_page(pfn);
 =20
- 		pgmap =3D get_dev_pagemap(pfn, pgmap);
- 		if (unlikely(!pgmap)) {
- 			undo_dev_pagemap(nr, nr_start, flags, pages);
- 			break;
- 		}
-=20
- 		if (!(flags & FOLL_PCI_P2PDMA) && is_pci_p2pdma_page(page)) {
- 			undo_dev_pagemap(nr, nr_start, flags, pages);
++		if (!(flags & FOLL_PCI_P2PDMA) && is_pci_p2pdma_page(page))
 +			break;
- 		}
 +
  		SetPageReferenced(page);
  		pages[*nr] =3D page;
- 		if (unlikely(try_grab_page(page, flags))) {
- 			undo_dev_pagemap(nr, nr_start, flags, pages);
 -		if (unlikely(!try_grab_page(page, flags)))
++		if (unlikely(try_grab_page(page, flags)))
  			break;
- 		}
  		(*nr)++;
  		pfn++;
  	} while (addr +=3D PAGE_SIZE, addr !=3D end);
diff --cc mm/huge_memory.c
index a075e3803e5e,ed12cd3acbfd..000000000000
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@@ -1225,14 -1179,9 +1180,11 @@@ struct page *follow_devmap_pud(struct v
  		return ERR_PTR(-EEXIST);
 =20
  	pfn +=3D (addr & ~PUD_MASK) >> PAGE_SHIFT;
- 	*pgmap =3D get_dev_pagemap(pfn, *pgmap);
- 	if (!*pgmap)
- 		return ERR_PTR(-EFAULT);
  	page =3D pfn_to_page(pfn);
 -	if (!try_grab_page(page, flags))
 -		page =3D ERR_PTR(-ENOMEM);
 +
 +	ret =3D try_grab_page(page, flags);
 +	if (ret)
 +		page =3D ERR_PTR(ret);
 =20
  	return page;
  }

--Sig_/bdPeSYhZzibRieP0Jg7JKnO
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmNsoHgACgkQAVBC80lX
0GyKggf+MgLrRQq6JXdCgAl4M+fD6N1WmxctiKjMJ/IqphZYxFvPn153IV2gh6gF
l7MCpDcT4TlJeSvDoEu2wcf3F4ot8zVtbNpOxiSSyneuX0+ZyqyziU9iaX1kKxMZ
4MDQBKefarsOVMyf02U0Mw+C2oSmPNQCCL84xSI2gsQvC+M3gjV/eLAAyFVW4UTc
4sHC8iwni1SnE1pSEzsiWJUooGKTpLWAqlbnXWwnEWAwd1yT4zyzD7QR4Fig6rma
xD862QS4pZ4gtQ9SPRN6KQ+RwHwPBPWj7tdDyYamPtjd/24PdW6Ac6nAYRYtM0VZ
USgPZsDazFZjqHOwtBTIQ41BcKwOjQ==
=kD/Y
-----END PGP SIGNATURE-----

--Sig_/bdPeSYhZzibRieP0Jg7JKnO--
