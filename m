Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FBC37324DF
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 03:51:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233575AbjFPBvK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 21:51:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230000AbjFPBvI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 21:51:08 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C49C3295E;
        Thu, 15 Jun 2023 18:51:03 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Qj2F20RLwz4x01;
        Fri, 16 Jun 2023 11:51:00 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1686880262;
        bh=8SMmXRXCjVgdiSPbdgGA7WXVYWlzZj//BnOQFRTD0Ak=;
        h=Date:From:To:Cc:Subject:From;
        b=DiUhZ0Zgt/xit3thlZSAhfj+VY3awcLdHRMX3sBdPdUNIax4PYWS5/9d5oAXroofY
         bH9+7BaOmc+tg+LHkNSvyiKj+c/XKqc9X1pGgd6W37V0I/kx396HBlTu2iddKX1fQt
         j80AQq5EyrRG846FleOyEfqBiF15ZLTf1HjDpzNqR0GbKSCm1CpztoZhD7CePVKMsL
         xqkLd7nBNzMYWa24FpnlrmXuZzdbk14YUZe3bMD2gjHeWjA71OXWa3mgZ4wSLLAHjI
         GYzLrPwIdpyHDUQz2kGVMIxzUulo9YCjYa0x4ywZbTIyNekVPyAv2KyJJ3h8+AKZpG
         7apijJRlXTjPA==
Date:   Fri, 16 Jun 2023 11:50:58 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Jens Axboe <axboe@kernel.dk>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     David Howells <dhowells@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Subject: linux-next: manual merge of the block tree with the mm tree
Message-ID: <20230616115058.57892241@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/Or+=NKnH+taR2WkTOpe7HmD";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/Or+=NKnH+taR2WkTOpe7HmD
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the block tree got a conflict in:

  include/linux/mm.h

between commit:

  3ed01074f441 ("mm: remove is_longterm_pinnable_page() and Reimplement fol=
io_is_longterm_pinnable()")

from the mm tree and commit:

  c8070b787519 ("mm: Don't pin ZERO_PAGE in pin_user_pages()")

from the block tree.

I fixed it up (I thinkl - see below) and can carry the fix as
necessary. This is now fixed as far as linux-next is concerned, but any
non trivial conflicts should be mentioned to your upstream maintainer
when your tree is submitted for merging.  You may also want to consider
cooperating with the maintainer of the conflicting tree to minimise any
particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc include/linux/mm.h
index e3e047735ccc,200068d98686..000000000000
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@@ -1902,18 -1910,40 +1902,40 @@@ static inline bool page_needs_cow_for_d
  	return page_maybe_dma_pinned(page);
  }
 =20
+ /**
+  * is_zero_page - Query if a page is a zero page
+  * @page: The page to query
+  *
+  * This returns true if @page is one of the permanent zero pages.
+  */
+ static inline bool is_zero_page(const struct page *page)
+ {
+ 	return is_zero_pfn(page_to_pfn(page));
+ }
+=20
+ /**
+  * is_zero_folio - Query if a folio is a zero page
+  * @folio: The folio to query
+  *
+  * This returns true if @folio is one of the permanent zero pages.
+  */
+ static inline bool is_zero_folio(const struct folio *folio)
+ {
+ 	return is_zero_page(&folio->page);
+ }
+=20
 -/* MIGRATE_CMA and ZONE_MOVABLE do not allow pin pages */
 +/* MIGRATE_CMA and ZONE_MOVABLE do not allow pin folios */
  #ifdef CONFIG_MIGRATION
 -static inline bool is_longterm_pinnable_page(struct page *page)
 +static inline bool folio_is_longterm_pinnable(struct folio *folio)
  {
  #ifdef CONFIG_CMA
 -	int mt =3D get_pageblock_migratetype(page);
 +	int mt =3D folio_migratetype(folio);
 =20
  	if (mt =3D=3D MIGRATE_CMA || mt =3D=3D MIGRATE_ISOLATE)
  		return false;
  #endif
- 	/* The zero page may always be pinned */
- 	if (is_zero_pfn(folio_pfn(folio)))
+ 	/* The zero page can be "pinned" but gets special handling. */
 -	if (is_zero_page(page))
++	if (is_zero_folio(folio))
  		return true;
 =20
  	/* Coherent device memory must always allow eviction. */

--Sig_/Or+=NKnH+taR2WkTOpe7HmD
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmSLwAMACgkQAVBC80lX
0GxiJwf9Fd1LbNdHJD2LmlbYkOvtxCcz6ybSbNzpARb8QM/tOBMOdd1VhyITvaYA
12j3zRj7zBuzAnLjEXqzlRHYuCOAv+uCAJtT3nLxsZrxaj1JforMBa9QrffaxSx/
1yge6PlgqML3rD65+xkQAb9yA0/4KrhGNSELsXuUAx3bY2n39BM6v4n6LXYmr6tA
gvy8yh7FFrVq0YX5s456vmoifpgSZijgBR6c+GH7wOBplQ+6i5PJstKq80NcLkyC
jpJ+sHCo4amDT9+B8sEkoe6LJRniYTnciDAc4hmIahO+pgqkQz3rSpC5Z0RYT0gS
gKmNM1Jf6mY0MNu1KAqgYR+GrNQe5A==
=Vv/N
-----END PGP SIGNATURE-----

--Sig_/Or+=NKnH+taR2WkTOpe7HmD--
