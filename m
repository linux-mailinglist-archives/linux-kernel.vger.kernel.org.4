Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DB01621D1E
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 20:42:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229707AbiKHTl4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 14:41:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbiKHTlo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 14:41:44 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DB07716CA
        for <linux-kernel@vger.kernel.org>; Tue,  8 Nov 2022 11:41:43 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0B946B81C1F
        for <linux-kernel@vger.kernel.org>; Tue,  8 Nov 2022 19:41:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D899C433D7;
        Tue,  8 Nov 2022 19:41:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1667936500;
        bh=bgbt2enUCqI8iRJ3RLKDZTlxwyLbgJ8OtsM1oeqQotc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yqjVAyZd9QMNx7zvF9RtUrYl2DUpE3QM9v79JHlipIOyabYoezYTfg7mvFoKlO5HA
         u+Be86X/jvDj085UDR3r30GnW1oO8qZQUTKVkgquJotczGNAYXFFbsqWbny7SRK37i
         dvVjGLO4A8tis77odWALXcqs8tdGEWCYKv256b/U=
From:   Linus Torvalds <torvalds@linux-foundation.org>
To:     Hugh Dickins <hughd@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH 2/4] mm: teach release_pages() to take an array of encoded page pointers too
Date:   Tue,  8 Nov 2022 11:41:37 -0800
Message-Id: <20221108194139.57604-2-torvalds@linux-foundation.org>
X-Mailer: git-send-email 2.38.1.284.gfd9468d787
In-Reply-To: <CAHk-=wh6MxaCA4pXpt1F5Bn2__6MxCq0Dr-rES4i=MOL9ibjpg@mail.gmail.com>
References: <CAHk-=wh6MxaCA4pXpt1F5Bn2__6MxCq0Dr-rES4i=MOL9ibjpg@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

release_pages() already could take either an array of page pointers, or
an array of folio pointers.  Expand it to also accept an array of
encoded page pointers, which is what both the existing mlock() use and
the upcoming mmu_gather use of encoded page pointers wants.

Note that release_pages() won't actually use, or react to, any extra
encoded bits.  Instead, this is very much a case of "I have walked the
array of encoded pages and done everything the extra bits tell me to do,
now release it all".

Also, while the "either page or folio pointers" dual use was handled
with a cast of the pointer in "release_folios()", this takes a slightly
different approach and uses the "transparent union" attribute to
describe the set of arguments to the function:

  https://gcc.gnu.org/onlinedocs/gcc/Common-Type-Attributes.html

which has been supported by gcc forever, but the kernel hasn't used
before.

That allows us to avoid using various wrappers with casts, and just use
the same function regardless of use.

Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
---
 include/linux/mm.h | 21 +++++++++++++++++++--
 mm/swap.c          | 16 ++++++++++++----
 2 files changed, 31 insertions(+), 6 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 8bbcccbc5565..d9fb5c3e3045 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1179,7 +1179,24 @@ static inline void folio_put_refs(struct folio *folio, int refs)
 		__folio_put(folio);
 }
 
-void release_pages(struct page **pages, int nr);
+/**
+ * release_pages - release an array of pages or folios
+ *
+ * This just releases a simple array of multiple pages, and
+ * accepts various different forms of said page array: either
+ * a regular old boring array of pages, an array of folios, or
+ * an array of encoded page pointers.
+ *
+ * The transparent union syntax for this kind of "any of these
+ * argument types" is all kinds of ugly, so look away.
+ */
+typedef union {
+	struct page **pages;
+	struct folio **folios;
+	struct encoded_page **encoded_pages;
+} release_pages_arg __attribute__ ((__transparent_union__));
+
+void release_pages(release_pages_arg, int nr);
 
 /**
  * folios_put - Decrement the reference count on an array of folios.
@@ -1195,7 +1212,7 @@ void release_pages(struct page **pages, int nr);
  */
 static inline void folios_put(struct folio **folios, unsigned int nr)
 {
-	release_pages((struct page **)folios, nr);
+	release_pages(folios, nr);
 }
 
 static inline void put_page(struct page *page)
diff --git a/mm/swap.c b/mm/swap.c
index 955930f41d20..596ed226ddb8 100644
--- a/mm/swap.c
+++ b/mm/swap.c
@@ -968,22 +968,30 @@ void lru_cache_disable(void)
 
 /**
  * release_pages - batched put_page()
- * @pages: array of pages to release
+ * @arg: array of pages to release
  * @nr: number of pages
  *
- * Decrement the reference count on all the pages in @pages.  If it
+ * Decrement the reference count on all the pages in @arg.  If it
  * fell to zero, remove the page from the LRU and free it.
+ *
+ * Note that the argument can be an array of pages, encoded pages,
+ * or folio pointers. We ignore any encoded bits, and turn any of
+ * them into just a folio that gets free'd.
  */
-void release_pages(struct page **pages, int nr)
+void release_pages(release_pages_arg arg, int nr)
 {
 	int i;
+	struct encoded_page **encoded = arg.encoded_pages;
 	LIST_HEAD(pages_to_free);
 	struct lruvec *lruvec = NULL;
 	unsigned long flags = 0;
 	unsigned int lock_batch;
 
 	for (i = 0; i < nr; i++) {
-		struct folio *folio = page_folio(pages[i]);
+		struct folio *folio;
+
+		/* Turn any of the argument types into a folio */
+		folio = page_folio(encoded_page_ptr(encoded[i]));
 
 		/*
 		 * Make sure the IRQ-safe lock-holding time does not get
-- 
2.38.1.284.gfd9468d787

