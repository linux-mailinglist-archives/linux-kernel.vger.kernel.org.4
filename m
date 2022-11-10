Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F51A623BBC
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 07:23:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232428AbiKJGXO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 01:23:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232444AbiKJGW7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 01:22:59 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D5512EF4E;
        Wed,  9 Nov 2022 22:22:55 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4N7BbD3G1Kz4xZ0;
        Thu, 10 Nov 2022 17:22:48 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1668061370;
        bh=gmweExB1iS+T+b9aVwFAzpsdiF1p2TuESW4E973DwR0=;
        h=Date:From:To:Cc:Subject:From;
        b=n/0tSIZC5kw/ZKiqdnIz1roP5UoKo19hUAf7a61uarMSCcBiT4bVxjiZDVkNqF/hA
         184LEbjUgSlvKpH6K0nNnTvopqqbd3ayoPzg9SK1BiYef0nQZ4BrZeK83japFMHXww
         OnhyqBw27jGmqJtoVgwfx/2mdFOZ5OjDo98cOSio2NbA7+imd8uP4pgOk2yzUyqVYO
         BAFczmyjz25V8izLcEzY4D8plmsVomlyeu9zwuRAZb9i5jU7EGOwFZBOqmtf8IFpSr
         xzUMRfcG2mttp5AxrphKD8KbS7OAuQ2JyxBOXb4PIv27dkPK6Fo0Qr033Qk098bE+/
         nnhymQVExneuA==
Date:   Thu, 10 Nov 2022 17:22:46 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Jens Axboe <axboe@kernel.dk>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Logan Gunthorpe <logang@deltatee.com>,
        Mike Kravetz <mike.kravetz@oracle.com>
Subject: linux-next: manual merge of the mm-stable tree with the block tree
Message-ID: <20221110172246.32792d6a@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/G8I5UT9GrY4iUkaFgTYRtJi";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/G8I5UT9GrY4iUkaFgTYRtJi
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the mm-stable tree got a conflict in:

  mm/hugetlb.c

between commit:

  0f0892356fa1 ("mm: allow multiple error returns in try_grab_page()")

from the block tree and commit:

  57a196a58421 ("hugetlb: simplify hugetlb handling in follow_page_mask")

from the mm-stable tree.

I fixed it up (I think - see below) and can carry the fix as necessary.
This is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc mm/hugetlb.c
index 3373d24e4a97,fdb36afea2b2..000000000000
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@@ -6222,6 -6199,62 +6212,62 @@@ static inline bool __follow_hugetlb_mus
  	return false;
  }
 =20
+ struct page *hugetlb_follow_page_mask(struct vm_area_struct *vma,
+ 				unsigned long address, unsigned int flags)
+ {
+ 	struct hstate *h =3D hstate_vma(vma);
+ 	struct mm_struct *mm =3D vma->vm_mm;
+ 	unsigned long haddr =3D address & huge_page_mask(h);
+ 	struct page *page =3D NULL;
+ 	spinlock_t *ptl;
+ 	pte_t *pte, entry;
+=20
+ 	/*
+ 	 * FOLL_PIN is not supported for follow_page(). Ordinary GUP goes via
+ 	 * follow_hugetlb_page().
+ 	 */
+ 	if (WARN_ON_ONCE(flags & FOLL_PIN))
+ 		return NULL;
+=20
+ retry:
+ 	pte =3D huge_pte_offset(mm, haddr, huge_page_size(h));
+ 	if (!pte)
+ 		return NULL;
+=20
+ 	ptl =3D huge_pte_lock(h, mm, pte);
+ 	entry =3D huge_ptep_get(pte);
+ 	if (pte_present(entry)) {
+ 		page =3D pte_page(entry) +
+ 				((address & ~huge_page_mask(h)) >> PAGE_SHIFT);
+ 		/*
+ 		 * Note that page may be a sub-page, and with vmemmap
+ 		 * optimizations the page struct may be read only.
+ 		 * try_grab_page() will increase the ref count on the
+ 		 * head page, so this will be OK.
+ 		 *
 -		 * try_grab_page() should always succeed here, because we hold
 -		 * the ptl lock and have verified pte_present().
++		 * try_grab_page() should always be able to get the page here,
++		 * because we hold the ptl lock and have verified pte_present().
+ 		 */
 -		if (WARN_ON_ONCE(!try_grab_page(page, flags))) {
++		if (try_grab_page(page, flags)) {
+ 			page =3D NULL;
+ 			goto out;
+ 		}
+ 	} else {
+ 		if (is_hugetlb_entry_migration(entry)) {
+ 			spin_unlock(ptl);
+ 			__migration_entry_wait_huge(pte, ptl);
+ 			goto retry;
+ 		}
+ 		/*
+ 		 * hwpoisoned entry is treated as no_page_table in
+ 		 * follow_page_mask().
+ 		 */
+ 	}
+ out:
+ 	spin_unlock(ptl);
+ 	return page;
+ }
+=20
  long follow_hugetlb_page(struct mm_struct *mm, struct vm_area_struct *vma,
  			 struct page **pages, struct vm_area_struct **vmas,
  			 unsigned long *position, unsigned long *nr_pages,

--Sig_/G8I5UT9GrY4iUkaFgTYRtJi
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmNsmLYACgkQAVBC80lX
0Gz9EQf+IvnQgbyxGzKmAduyxuE8/1KT+uNqxGq8qCbdawRXI4x3yg/PJB17Ims+
zWDVSnHjTooysQuc+nhxJmzd8KoEJA/m+YEmRqNxfLCJkSCunoKM/0Q9CnA3Brqx
V0bm+Mc/e7tDcUwffgSRbjPe7CulMG40HkwvBC3anjp+Ot+EdQ2QjlXMiaXcSl+O
gU2eRlnNeEMica0/ll0ubWNzeM6O42+ArQtqa701+6pKR8dzNaxOCdOPdF2FXPJB
jhLp4QFMyhaFkS5/PzYVzOu0m4PaVeXLYrFOEeCxx2ECvTQpeIZ7etdF6IXxGsp+
b4JwdxV3TGdYHCWW8YbllZhGsYcLdQ==
=E4g8
-----END PGP SIGNATURE-----

--Sig_/G8I5UT9GrY4iUkaFgTYRtJi--
