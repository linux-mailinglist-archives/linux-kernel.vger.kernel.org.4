Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B964D6247C2
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 17:59:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230315AbiKJQ7p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 11:59:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232739AbiKJQ7k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 11:59:40 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66ABA6272
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 08:58:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1668099517;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=36ke+tu+rzNrTaQ8ipToLCK8AjSuu0u9J5kXXC26KEk=;
        b=Qlf9arDlVNcgYGwIO17aPthc5njFdnaS5mF9XkYxdY3fGCmnDQfz+8tbEGtlCglJYrMX1w
        l9F1M7fzHWuWWhS09E+j/Qc5z9O/0BnPrpHx6i6a/OnLnTtjEQoYmSKA4eHtj1M/T4+Pgd
        IereF9cDVWP+vzxEBkrFP/eXAdW40ww=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-126-XI_2MemeMFWeyhqB7u1y4w-1; Thu, 10 Nov 2022 11:58:36 -0500
X-MC-Unique: XI_2MemeMFWeyhqB7u1y4w-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E32C93C025D1;
        Thu, 10 Nov 2022 16:58:35 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.24])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4AE631121330;
        Thu, 10 Nov 2022 16:58:35 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH] mm: Make some folio function arguments const
From:   David Howells <dhowells@redhat.com>
To:     willy@infradead.org
Cc:     dhowells@redhat.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Date:   Thu, 10 Nov 2022 16:58:32 +0000
Message-ID: <166809951250.3381741.3113541135557341907.stgit@warthog.procyon.org.uk>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mark the folio* argument to some of the folio accessor functions as a const
pointer.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 include/linux/mm.h         |   20 ++++++++++----------
 include/linux/page-flags.h |    4 ++--
 2 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 7a7a287818ad..a069f6f70aed 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -711,7 +711,7 @@ int vma_is_stack_for_current(struct vm_area_struct *vma);
 struct mmu_gather;
 struct inode;
 
-static inline unsigned int compound_order(struct page *page)
+static inline unsigned int compound_order(const struct page *page)
 {
 	if (!PageHead(page))
 		return 0;
@@ -727,7 +727,7 @@ static inline unsigned int compound_order(struct page *page)
  *
  * Return: The order of the folio.
  */
-static inline unsigned int folio_order(struct folio *folio)
+static inline unsigned int folio_order(const struct folio *folio)
 {
 	if (!folio_test_large(folio))
 		return 0;
@@ -945,7 +945,7 @@ static inline void set_compound_order(struct page *page, unsigned int order)
 }
 
 /* Returns the number of pages in this potentially compound page. */
-static inline unsigned long compound_nr(struct page *page)
+static inline unsigned long compound_nr(const struct page *page)
 {
 	if (!PageHead(page))
 		return 1;
@@ -1519,7 +1519,7 @@ static inline unsigned long page_to_section(const struct page *page)
  *
  * Return: The Page Frame Number of the first page in the folio.
  */
-static inline unsigned long folio_pfn(struct folio *folio)
+static inline unsigned long folio_pfn(const struct folio *folio)
 {
 	return page_to_pfn(&folio->page);
 }
@@ -1600,7 +1600,7 @@ static inline bool page_needs_cow_for_dma(struct vm_area_struct *vma,
 
 /* MIGRATE_CMA and ZONE_MOVABLE do not allow pin pages */
 #ifdef CONFIG_MIGRATION
-static inline bool is_longterm_pinnable_page(struct page *page)
+static inline bool is_longterm_pinnable_page(const struct page *page)
 {
 #ifdef CONFIG_CMA
 	int mt = get_pageblock_migratetype(page);
@@ -1620,13 +1620,13 @@ static inline bool is_longterm_pinnable_page(struct page *page)
 	return !is_zone_movable_page(page);
 }
 #else
-static inline bool is_longterm_pinnable_page(struct page *page)
+static inline bool is_longterm_pinnable_page(const struct page *page)
 {
 	return true;
 }
 #endif
 
-static inline bool folio_is_longterm_pinnable(struct folio *folio)
+static inline bool folio_is_longterm_pinnable(const struct folio *folio)
 {
 	return is_longterm_pinnable_page(&folio->page);
 }
@@ -1659,7 +1659,7 @@ static inline void set_page_links(struct page *page, enum zone_type zone,
  *
  * Return: A positive power of two.
  */
-static inline long folio_nr_pages(struct folio *folio)
+static inline long folio_nr_pages(const struct folio *folio)
 {
 	if (!folio_test_large(folio))
 		return 1;
@@ -1701,7 +1701,7 @@ static inline struct folio *folio_next(struct folio *folio)
  * it from being split.  It is not necessary for the folio to be locked.
  * Return: The base-2 logarithm of the size of this folio.
  */
-static inline unsigned int folio_shift(struct folio *folio)
+static inline unsigned int folio_shift(const struct folio *folio)
 {
 	return PAGE_SHIFT + folio_order(folio);
 }
@@ -1714,7 +1714,7 @@ static inline unsigned int folio_shift(struct folio *folio)
  * it from being split.  It is not necessary for the folio to be locked.
  * Return: The number of bytes in this folio.
  */
-static inline size_t folio_size(struct folio *folio)
+static inline size_t folio_size(const struct folio *folio)
 {
 	return PAGE_SIZE << folio_order(folio);
 }
diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
index 0b0ae5084e60..89599570c895 100644
--- a/include/linux/page-flags.h
+++ b/include/linux/page-flags.h
@@ -243,7 +243,7 @@ static inline const struct page *page_fixed_fake_head(const struct page *page)
 }
 #endif
 
-static __always_inline int page_is_fake_head(struct page *page)
+static __always_inline int page_is_fake_head(const struct page *page)
 {
 	return page_fixed_fake_head(page) != page;
 }
@@ -782,7 +782,7 @@ static __always_inline bool folio_test_head(struct folio *folio)
 	return test_bit(PG_head, folio_flags(folio, FOLIO_PF_ANY));
 }
 
-static __always_inline int PageHead(struct page *page)
+static __always_inline int PageHead(const struct page *page)
 {
 	PF_POISONED_CHECK(page);
 	return test_bit(PG_head, &page->flags) && !page_is_fake_head(page);


