Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BD6567A911
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 04:05:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234107AbjAYDFJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 22:05:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230334AbjAYDFI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 22:05:08 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFA284997B;
        Tue, 24 Jan 2023 19:05:04 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4P1pby4fC3z4xFy;
        Wed, 25 Jan 2023 14:05:02 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1674615902;
        bh=7ryTXtVBcRP2bWvZBzv7PYn6hBfvbCRuRtN95kpSraY=;
        h=Date:From:To:Cc:Subject:From;
        b=BJqZckzztXIuSWMRNejL0d0kzEUBWEPsrRJBNTCFzjCON/xx05F7z9IZLXO/jLAsh
         MmM7uBoxCHT5ikossJQMTsJ52QOYvVfiIUnrRvHE3O1+RGYLSenz7dFiSHlFgfSw75
         qAx0ncHxhkvTNyVHDpIpdvJOlBC1HpCpRgioQ640/HCZUnBXfGPZOIwFXH35aw3TmJ
         hD169BQhIg1r6CCaqhLEPRwCh1zPZ88GUIYFWQUIp0YllUf7uey4la9xlJEvzSx0y+
         /n4ca8W3ulJZyYlJmDPdq+ba3jarVADCpnM2zryAUkdGDPTt8QxfDBC1KgUMeeLDDx
         G5RxER5diSLzg==
Date:   Wed, 25 Jan 2023 14:05:00 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     "Vishal Moola (Oracle)" <vishal.moola@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the mm tree
Message-ID: <20230125140500.4509de80@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/siTE7kg0Si9QYSf0zHD4Q/5";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/siTE7kg0Si9QYSf0zHD4Q/5
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the mm tree, today's linux-next build (x86_64 allnoconfig)
failed like this:

In file included from arch/x86/include/asm/page.h:85,
                 from arch/x86/include/asm/thread_info.h:12,
                 from include/linux/thread_info.h:60,
                 from arch/x86/include/asm/preempt.h:9,
                 from include/linux/preempt.h:78,
                 from include/linux/spinlock.h:56,
                 from include/linux/mmzone.h:8,
                 from include/linux/gfp.h:7,
                 from include/linux/slab.h:15,
                 from include/linux/crypto.h:20,
                 from arch/x86/kernel/asm-offsets.c:9:
include/linux/mm.h: In function 'folio_estimated_mapcount':
include/asm-generic/memory_model.h:35:21: error: implicit declaration of fu=
nction 'page_to_section'; did you mean 'present_section'? [-Werror=3Dimplic=
it-function-declaration]
   35 |         int __sec =3D page_to_section(__pg);                      \
      |                     ^~~~~~~~~~~~~~~
include/asm-generic/memory_model.h:40:32: note: in definition of macro '__p=
fn_to_page'
   40 | ({      unsigned long __pfn =3D (pfn);                    \
      |                                ^~~
include/asm-generic/memory_model.h:52:21: note: in expansion of macro '__pa=
ge_to_pfn'
   52 | #define page_to_pfn __page_to_pfn
      |                     ^~~~~~~~~~~~~
include/linux/mm.h:216:38: note: in expansion of macro 'page_to_pfn'
  216 | #define nth_page(page,n) pfn_to_page(page_to_pfn((page)) + (n))
      |                                      ^~~~~~~~~~~
include/linux/page-flags.h:286:33: note: in expansion of macro 'nth_page'
  286 | #define folio_page(folio, n)    nth_page(&(folio)->page, n)
      |                                 ^~~~~~~~
include/linux/mm.h:918:30: note: in expansion of macro 'folio_page'
  918 |         return page_mapcount(folio_page(folio, 0));
      |                              ^~~~~~~~~~
In file included from include/linux/memcontrol.h:20,
                 from include/linux/swap.h:9,
                 from include/linux/suspend.h:5,
                 from arch/x86/kernel/asm-offsets.c:14:
include/linux/mm.h: At top level:
include/linux/mm.h:1626:29: error: conflicting types for 'page_to_section';=
 have 'long unsigned int(const struct page *)'
 1626 | static inline unsigned long page_to_section(const struct page *page)
      |                             ^~~~~~~~~~~~~~~
include/asm-generic/memory_model.h:35:21: note: previous implicit declarati=
on of 'page_to_section' with type 'int()'
   35 |         int __sec =3D page_to_section(__pg);                      \
      |                     ^~~~~~~~~~~~~~~
include/asm-generic/memory_model.h:40:32: note: in definition of macro '__p=
fn_to_page'
   40 | ({      unsigned long __pfn =3D (pfn);                    \
      |                                ^~~
include/asm-generic/memory_model.h:52:21: note: in expansion of macro '__pa=
ge_to_pfn'
   52 | #define page_to_pfn __page_to_pfn
      |                     ^~~~~~~~~~~~~
include/linux/mm.h:216:38: note: in expansion of macro 'page_to_pfn'
  216 | #define nth_page(page,n) pfn_to_page(page_to_pfn((page)) + (n))
      |                                      ^~~~~~~~~~~
include/linux/page-flags.h:286:33: note: in expansion of macro 'nth_page'
  286 | #define folio_page(folio, n)    nth_page(&(folio)->page, n)
      |                                 ^~~~~~~~
include/linux/mm.h:918:30: note: in expansion of macro 'folio_page'
  918 |         return page_mapcount(folio_page(folio, 0));
      |                              ^~~~~~~~~~
cc1: some warnings being treated as errors

Caused by commit

  59c975083d37 ("mm: add folio_estimated_mapcount()")

I applied the following fix patch (hack):

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Wed, 25 Jan 2023 13:42:20 +1100
Subject: [PATCH] fix up for "mm: add folio_estimated_mapcount()"

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 include/linux/mm.h | 5 -----
 mm/mempolicy.c     | 7 +++++++
 2 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index b7d6e290df99..78c766859fb7 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -913,11 +913,6 @@ static inline int page_mapcount(struct page *page)
 	return mapcount;
 }
=20
-static inline int folio_estimated_mapcount(struct folio *folio)
-{
-	return page_mapcount(folio_page(folio, 0));
-}
-
 int folio_total_mapcount(struct folio *folio);
=20
 /**
diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index 03220ba94074..c81db10612eb 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -558,6 +558,13 @@ static int queue_folios_pte_range(pmd_t *pmd, unsigned=
 long addr,
 	return addr !=3D end ? -EIO : 0;
 }
=20
+#if defined(CONFIG_HUGETLB_PAGE) || defined(CONFIG_MIGRATION)
+static inline int folio_estimated_mapcount(struct folio *folio)
+{
+	return page_mapcount(folio_page(folio, 0));
+}
+#endif
+
 static int queue_folios_hugetlb(pte_t *pte, unsigned long hmask,
 			       unsigned long addr, unsigned long end,
 			       struct mm_walk *walk)
--=20
2.35.1

--=20
Cheers,
Stephen Rothwell

--Sig_/siTE7kg0Si9QYSf0zHD4Q/5
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmPQnFwACgkQAVBC80lX
0GzmgAf9HkSGH96BLh/ymZr1E/UyhHijmmU8vn8c/2jiDbV+44FbZ9KQCDGCuBKS
Q166jzI6RKopN+u6/DdmCZ+87pjWUbwyi97fptkIw7oZJJWISD1sUARcTc1b+yPi
VVV42QLI8IHft/WbU9YNsdKHC5UBOleZy4HylbsmiRZsTYXk1ylj62Sof6Xh8af6
Ee+vuroGJNeVphyOZXOKWvL8qHy+XaLTcMXxH4W8/YCV6ZfAy3Cph+2PG/A9rX/f
MuPKT5oSTF5Dw1KeT47JRqMAhGYQ1x3iYjE5s0lHltfmutTupa3XEM9QWkr1Yobs
xa9DBTpslhkuAxWTqoqMxedk+xUj6g==
=VjDz
-----END PGP SIGNATURE-----

--Sig_/siTE7kg0Si9QYSf0zHD4Q/5--
