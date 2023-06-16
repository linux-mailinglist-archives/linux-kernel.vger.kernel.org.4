Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3960E7324F0
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 03:59:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239312AbjFPB7D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 21:59:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239295AbjFPB7C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 21:59:02 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB5B61FE8;
        Thu, 15 Jun 2023 18:58:59 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Qj2QB3STfz4wgH;
        Fri, 16 Jun 2023 11:58:58 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1686880738;
        bh=nGXAVqcuQCj/AhaQov4ey6oWhNQZQLuD88nrYkvIJ/c=;
        h=Date:From:To:Cc:Subject:From;
        b=XFSst6v/PjotB/RVnhUNyBjIoQzHaYilq/R/vX3CU5AhXh3wEi+cn0AgoK3fvwPqa
         p7WMocOwL7acb4qALjpDzSOQX2gCTq3YxJ4DMQvJzAk62AZQfHLu1fZ6PK0Ln2QdqL
         mF0+9lKugZIoDSEBb9AcFv3lu6D1meSjussvDqoM4IHVSLWV9rMI2wSeMm8HvmzRqr
         bqjzIzAlmSsxWnd62kAcZIZszRYLmmDXkqjHZNB4wMZj4NiIRdqBurj1wxxmmCLMgp
         zoFfvPv2OIbQjJGnUtmYP+Iqmue4GYnH84u13+HvAEhiM++bqTQr4P1NiNeFe1XeC4
         tPSMpW6SdLtMg==
Date:   Fri, 16 Jun 2023 11:58:56 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Jens Axboe <axboe@kernel.dk>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     David Howells <dhowells@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Subject: linux-next: manual merge of the block tree with the mm tree
Message-ID: <20230616115856.3ce7682c@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/gsMi0nEeny+pRoWwPMREG7C";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/gsMi0nEeny+pRoWwPMREG7C
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the block tree got a conflict in:

  mm/gup.c

between commit:

  0f3f569eca46 ("mm/gup.c: reorganize try_get_folio()")

from the mm tree and commit:

  c8070b787519 ("mm: Don't pin ZERO_PAGE in pin_user_pages()")

from the block tree.

I fixed it up (I think - see below) and can carry the fix as necessary.
This is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc mm/gup.c
index ce14d4d28503,0814576b7366..000000000000
--- a/mm/gup.c
+++ b/mm/gup.c
@@@ -132,50 -127,62 +133,57 @@@ struct folio *try_grab_folio(struct pag
  	if (unlikely(!(flags & FOLL_PCI_P2PDMA) && is_pci_p2pdma_page(page)))
  		return NULL;
 =20
 +	folio =3D try_get_folio(page, refs);
 +
  	if (flags & FOLL_GET)
 -		return try_get_folio(page, refs);
 -	else if (flags & FOLL_PIN) {
 -		struct folio *folio;
 -
 -		/*
 -		 * Don't take a pin on the zero page - it's not going anywhere
 -		 * and it is used in a *lot* of places.
 -		 */
 -		if (is_zero_page(page))
 -			return page_folio(page);
 -
 -		/*
 -		 * Can't do FOLL_LONGTERM + FOLL_PIN gup fast path if not in a
 -		 * right zone, so fail and let the caller fall back to the slow
 -		 * path.
 -		 */
 -		if (unlikely((flags & FOLL_LONGTERM) &&
 -			     !is_longterm_pinnable_page(page)))
 -			return NULL;
 -
 -		/*
 -		 * CAUTION: Don't use compound_head() on the page before this
 -		 * point, the result won't be stable.
 -		 */
 -		folio =3D try_get_folio(page, refs);
 -		if (!folio)
 -			return NULL;
 -
 -		/*
 -		 * When pinning a large folio, use an exact count to track it.
 -		 *
 -		 * However, be sure to *also* increment the normal folio
 -		 * refcount field at least once, so that the folio really
 -		 * is pinned.  That's why the refcount from the earlier
 -		 * try_get_folio() is left intact.
 -		 */
 -		if (folio_test_large(folio))
 -			atomic_add(refs, &folio->_pincount);
 -		else
 -			folio_ref_add(folio,
 -					refs * (GUP_PIN_COUNTING_BIAS - 1));
 -		/*
 -		 * Adjust the pincount before re-checking the PTE for changes.
 -		 * This is essentially a smp_mb() and is paired with a memory
 -		 * barrier in page_try_share_anon_rmap().
 -		 */
 -		smp_mb__after_atomic();
 -
 -		node_stat_mod_folio(folio, NR_FOLL_PIN_ACQUIRED, refs);
 -
  		return folio;
 +
 +	/* FOLL_PIN is set */
 +	if (!folio)
 +		return NULL;
 +
++	/*
++	 * Don't take a pin on the zero page - it's not going anywhere
++	 * and it is used in a *lot* of places.
++	 */
++	if (is_zero_page(page))
++		return page_folio(page);
++
 +	/*
 +	 * Can't do FOLL_LONGTERM + FOLL_PIN gup fast path if not in a
 +	 * right zone, so fail and let the caller fall back to the slow
 +	 * path.
 +	 */
 +	if (unlikely((flags & FOLL_LONGTERM) &&
 +		     !folio_is_longterm_pinnable(folio))) {
 +		if (!put_devmap_managed_page_refs(&folio->page, refs))
 +			folio_put_refs(folio, refs);
 +		return NULL;
  	}
 =20
 -	WARN_ON_ONCE(1);
 -	return NULL;
 +	/*
 +	 * When pinning a large folio, use an exact count to track it.
 +	 *
 +	 * However, be sure to *also* increment the normal folio
 +	 * refcount field at least once, so that the folio really
 +	 * is pinned.  That's why the refcount from the earlier
 +	 * try_get_folio() is left intact.
 +	 */
 +	if (folio_test_large(folio))
 +		atomic_add(refs, &folio->_pincount);
 +	else
 +		folio_ref_add(folio,
 +				refs * (GUP_PIN_COUNTING_BIAS - 1));
 +	/*
 +	 * Adjust the pincount before re-checking the PTE for changes.
 +	 * This is essentially a smp_mb() and is paired with a memory
 +	 * barrier in page_try_share_anon_rmap().
 +	 */
 +	smp_mb__after_atomic();
 +
 +	node_stat_mod_folio(folio, NR_FOLL_PIN_ACQUIRED, refs);
 +
 +	return folio;
  }
 =20
  static void gup_put_folio(struct folio *folio, int refs, unsigned int fla=
gs)
@@@ -3250,9 -3193,13 +3300,12 @@@ EXPORT_SYMBOL(pin_user_pages_remote)
   *
   * FOLL_PIN means that the pages must be released via unpin_user_page(). =
Please
   * see Documentation/core-api/pin_user_pages.rst for details.
+  *
+  * Note that if a zero_page is amongst the returned pages, it will not ha=
ve
+  * pins in it and unpin_user_page*() will not remove pins from it.
   */
  long pin_user_pages(unsigned long start, unsigned long nr_pages,
 -		    unsigned int gup_flags, struct page **pages,
 -		    struct vm_area_struct **vmas)
 +		    unsigned int gup_flags, struct page **pages)
  {
  	int locked =3D 1;
 =20

--Sig_/gsMi0nEeny+pRoWwPMREG7C
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmSLweAACgkQAVBC80lX
0Gyetwf/V0ICnO3Vf/RgXADQZrPUXOZBFo108A0x9qizewjitx8BZWbrI9W38lLG
kBCTqLaWw2DL2NxWFeakbgKADzCdsj8MCcQCN7G6nDaJs7Mvrf3eLQa8mLBO8tVR
rczOJr7DHWPZPf6ALt6akxJyD4kXRiMHVd8KenVy2dagVYGDcRz8iagSP1XRJQsG
Dcy8vcks9pX6Lqc51ZSlGIQi2btGXEEA66EXAHzXSBG08OKhwAepLNgJoxR3Ec5m
ynUryYXD+BWhhG8HezErwgqRXM2AGKuRGXrfp5E2VAavW6KVMCHj2xjJtKE54hX/
Szuq3v1lDCYjIgUq9iOYSV1xcKjKHg==
=nIrF
-----END PGP SIGNATURE-----

--Sig_/gsMi0nEeny+pRoWwPMREG7C--
