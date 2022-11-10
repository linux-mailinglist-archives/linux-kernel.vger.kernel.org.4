Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05FC46239B3
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 03:19:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232420AbiKJCS6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 21:18:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232323AbiKJCSz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 21:18:55 -0500
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C8101EC5A
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 18:18:54 -0800 (PST)
Received: by mail-ot1-x32e.google.com with SMTP id a7-20020a056830008700b0066c82848060so428433oto.4
        for <linux-kernel@vger.kernel.org>; Wed, 09 Nov 2022 18:18:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=V/sKlKCbpgUtzEcBcF+ss08Lsp8wPn6ZAnVQ9HGwACQ=;
        b=PW006J3ueOBj82zFgxrbPGGxQunPTPYs0Xc/xF1sBy9K2VpGF7fi+0kPUlW4q9xARk
         9P4lDFY6Qz3fMkUda/AzlftOsjm7TJamY1xT0omvQiggk0EF2Fm6bJXFi3mu7RmEXsyd
         YSjpL+IbIRbMVSuSGPEtPMNSEwjXjMFFXlIl7TyBR5C/I397ZFTFztXm9+FP6pIXL3r8
         UXnVYzLxbmBdk4Ipi/UtjlOHYmrRN5i+mepZNQVt7WDg7hiAGVhPOJV063RUO3udicHg
         EqR4OcRikkCnJWjuMZkToqaxhHPOgMnzHxSHBhkQCnFGp5X+PYsYWxmJhMOQP9LVZR4b
         9hEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=V/sKlKCbpgUtzEcBcF+ss08Lsp8wPn6ZAnVQ9HGwACQ=;
        b=npBU00NK70T5tSVums2X+hJfEou93NTXlqK1GpFtSwwQM1lFq4y9EK/PVJS+uV5kMP
         5onJmEgwAEHrWG7e0hHBr/QW/QORML6j7pH72ZZ2eV4E3mIwivZAQ5D7SquEKf/o8V6Z
         gUChc/EyvEhQJlt6/g9Vkip4WtrdRGi38eUGtsFioqToDwFXXt8A/waHC13T4Bh+J3kT
         sGIWMVB6F/WO2XXH0k1JmIbzo6mGVhafg7axWixL510KRj05Bvxrrtv9J2eDmpbKwWoe
         W88IkMPRq7mWJHFYuyGpCxKy2TSJMO1NWlp7Y17jYs07x1AMYCwZ0qzeps4d+zjrESeT
         R72g==
X-Gm-Message-State: ACrzQf0F85kMWH5M6wxu9y9OkzfKbHYPbpNIAhjpJdsJ21LW62ZAUTDS
        TFYnGdZi98AQ66XqeuXctxqTeA==
X-Google-Smtp-Source: AMsMyM5cLNNIkZ7RP/8svDlaN6ev3dQDSPxxDpbu+hrx5NpsXhIhPwOg/1aRDxr7/7qIDXNB8X2phw==
X-Received: by 2002:a05:6830:2364:b0:66c:34c2:538a with SMTP id r4-20020a056830236400b0066c34c2538amr854838oth.315.1668046733376;
        Wed, 09 Nov 2022 18:18:53 -0800 (PST)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id h25-20020a056870171900b0013d9bd4ad2esm6935156oae.12.2022.11.09.18.18.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Nov 2022 18:18:52 -0800 (PST)
Date:   Wed, 9 Nov 2022 18:18:49 -0800 (PST)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.attlocal.net
To:     Andrew Morton <akpm@linux-foundation.org>
cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxcg.org>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Matthew Wilcox <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>, Peter Xu <peterx@redhat.com>,
        Yang Shi <shy828301@gmail.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        Mina Almasry <almasrymina@google.com>,
        James Houghton <jthoughton@google.com>,
        Zach O'Keefe <zokeefe@google.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH 4/3] mm,thp,rmap: handle the normal !PageCompound case
 first
In-Reply-To: <5f52de70-975-e94f-f141-543765736181@google.com>
Message-ID: <fca2f694-2098-b0ef-d4e-f1d8b94d318c@google.com>
References: <5f52de70-975-e94f-f141-543765736181@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit ("mm,thp,rmap: lock_compound_mapcounts() on THP mapcounts")
propagated the "if (compound) {lock} else if (PageCompound) {lock} else
{atomic}" pattern throughout; but Linus hated the way that gives primacy
to the uncommon case: switch to "if (!PageCompound) {atomic} else if
(compound) {lock} else {lock}" throughout.  Linus has a bigger idea
for how to improve it all, but here just make that rearrangement.

Signed-off-by: Hugh Dickins <hughd@google.com>
---
 mm/rmap.c | 54 +++++++++++++++++++++++++++---------------------------
 1 file changed, 27 insertions(+), 27 deletions(-)

diff --git a/mm/rmap.c b/mm/rmap.c
index 512e53cae2ca..4833d28c5e1a 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -1311,7 +1311,11 @@ void page_add_anon_rmap(struct page *page,
 	else
 		VM_BUG_ON_PAGE(!PageLocked(page), page);
 
-	if (compound && PageTransHuge(page)) {
+	if (likely(!PageCompound(page))) {
+		first = atomic_inc_and_test(&page->_mapcount);
+		nr = first;
+
+	} else if (compound && PageTransHuge(page)) {
 		lock_compound_mapcounts(page, &mapcounts);
 		first = !mapcounts.compound_mapcount;
 		mapcounts.compound_mapcount++;
@@ -1321,8 +1325,7 @@ void page_add_anon_rmap(struct page *page,
 				nr = nr_subpages_unmapped(page, nr_pmdmapped);
 		}
 		unlock_compound_mapcounts(page, &mapcounts);
-
-	} else if (PageCompound(page)) {
+	} else {
 		struct page *head = compound_head(page);
 
 		lock_compound_mapcounts(head, &mapcounts);
@@ -1330,10 +1333,6 @@ void page_add_anon_rmap(struct page *page,
 		first = subpage_mapcount_inc(page);
 		nr = first && !mapcounts.compound_mapcount;
 		unlock_compound_mapcounts(head, &mapcounts);
-
-	} else {
-		first = atomic_inc_and_test(&page->_mapcount);
-		nr = first;
 	}
 
 	VM_BUG_ON_PAGE(!first && (flags & RMAP_EXCLUSIVE), page);
@@ -1373,20 +1372,23 @@ void page_add_anon_rmap(struct page *page,
 void page_add_new_anon_rmap(struct page *page,
 	struct vm_area_struct *vma, unsigned long address)
 {
-	const bool compound = PageCompound(page);
-	int nr = compound ? thp_nr_pages(page) : 1;
+	int nr;
 
 	VM_BUG_ON_VMA(address < vma->vm_start || address >= vma->vm_end, vma);
 	__SetPageSwapBacked(page);
-	if (compound) {
+
+	if (likely(!PageCompound(page))) {
+		/* increment count (starts at -1) */
+		atomic_set(&page->_mapcount, 0);
+		nr = 1;
+	} else {
 		VM_BUG_ON_PAGE(!PageTransHuge(page), page);
 		/* increment count (starts at -1) */
 		atomic_set(compound_mapcount_ptr(page), 0);
+		nr = thp_nr_pages(page);
 		__mod_lruvec_page_state(page, NR_ANON_THPS, nr);
-	} else {
-		/* increment count (starts at -1) */
-		atomic_set(&page->_mapcount, 0);
 	}
+
 	__mod_lruvec_page_state(page, NR_ANON_MAPPED, nr);
 	__page_set_anon_rmap(page, vma, address, 1);
 }
@@ -1409,7 +1411,11 @@ void page_add_file_rmap(struct page *page,
 	VM_BUG_ON_PAGE(compound && !PageTransHuge(page), page);
 	lock_page_memcg(page);
 
-	if (compound && PageTransHuge(page)) {
+	if (likely(!PageCompound(page))) {
+		first = atomic_inc_and_test(&page->_mapcount);
+		nr = first;
+
+	} else if (compound && PageTransHuge(page)) {
 		lock_compound_mapcounts(page, &mapcounts);
 		first = !mapcounts.compound_mapcount;
 		mapcounts.compound_mapcount++;
@@ -1419,8 +1425,7 @@ void page_add_file_rmap(struct page *page,
 				nr = nr_subpages_unmapped(page, nr_pmdmapped);
 		}
 		unlock_compound_mapcounts(page, &mapcounts);
-
-	} else if (PageCompound(page)) {
+	} else {
 		struct page *head = compound_head(page);
 
 		lock_compound_mapcounts(head, &mapcounts);
@@ -1428,10 +1433,6 @@ void page_add_file_rmap(struct page *page,
 		first = subpage_mapcount_inc(page);
 		nr = first && !mapcounts.compound_mapcount;
 		unlock_compound_mapcounts(head, &mapcounts);
-
-	} else {
-		first = atomic_inc_and_test(&page->_mapcount);
-		nr = first;
 	}
 
 	if (nr_pmdmapped)
@@ -1471,7 +1472,11 @@ void page_remove_rmap(struct page *page,
 	lock_page_memcg(page);
 
 	/* page still mapped by someone else? */
-	if (compound && PageTransHuge(page)) {
+	if (likely(!PageCompound(page))) {
+		last = atomic_add_negative(-1, &page->_mapcount);
+		nr = last;
+
+	} else if (compound && PageTransHuge(page)) {
 		lock_compound_mapcounts(page, &mapcounts);
 		mapcounts.compound_mapcount--;
 		last = !mapcounts.compound_mapcount;
@@ -1481,8 +1486,7 @@ void page_remove_rmap(struct page *page,
 				nr = nr_subpages_unmapped(page, nr_pmdmapped);
 		}
 		unlock_compound_mapcounts(page, &mapcounts);
-
-	} else if (PageCompound(page)) {
+	} else {
 		struct page *head = compound_head(page);
 
 		lock_compound_mapcounts(head, &mapcounts);
@@ -1490,10 +1494,6 @@ void page_remove_rmap(struct page *page,
 		last = subpage_mapcount_dec(page);
 		nr = last && !mapcounts.compound_mapcount;
 		unlock_compound_mapcounts(head, &mapcounts);
-
-	} else {
-		last = atomic_add_negative(-1, &page->_mapcount);
-		nr = last;
 	}
 
 	if (nr_pmdmapped) {
-- 
2.35.3

