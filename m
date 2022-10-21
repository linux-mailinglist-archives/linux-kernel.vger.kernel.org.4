Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02F7C607C76
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 18:39:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231214AbiJUQjQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 12:39:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230417AbiJUQiP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 12:38:15 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBA24285B77
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 09:37:38 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id f9-20020a25b089000000b006be298e2a8dso3755480ybj.20
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 09:37:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=8wv1ndA1KF8oaMnIrotaSvG0oK1F475ZCcDJjASpTlQ=;
        b=hA8J326O7a0EqIeFifBsH7a/imYAoEv3Fjm/FsWS/2l67p7YL4UTp4delGk3izcl+P
         yUMlvya8wwiX0QoCutq/CYssZPSkjElnj1/ElmaX1Yv0en/RWLhHh7JnxK7ihEFGucid
         sPn7Jj6tEBM2NrRJYPvUv4K5hnyaC9+Ddpv1Ik/07iw1wk6iQd8BFDrNfG9dJysMepUC
         Rk6k301F/i5SC3oHp9J/MopKdD70L4fAd+UF5uQtHniRZAMT/o0Qu3QtZI+LtO+vEwiz
         1K/dd5p1zQhugJO2OzYe1+HctzunUY0PXuEreoURlPTPkCfYe98jsMbHS423j8l/98PY
         A6zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8wv1ndA1KF8oaMnIrotaSvG0oK1F475ZCcDJjASpTlQ=;
        b=YIF891OxMVAA8HgRpv4ltLYgkf8dJFqR3hvWlFf7s1sxVUKYomhPnCs3WuIIdLH9X4
         7yAtpkDEoS3HUiDDHKeeraR/X2wv4YiQg0u93DsBgqYS2XM+/CUKrnX3lEWhWsgMQb72
         BD55CegNH5RLRij3/LnIBf67nKLGHq/rFxBQvNOvuf/ifhyvkGf1FgZzjiCLDLJrfl8/
         YmTQBlS2okonYX1e4yMZkKfufU79LKMspAu7IvaiYNj7wy3VxTH3wBlQGM+gO9gFuvx3
         MgnShFlWXWmRwOYp/gGX1o2hlllq4wI5eReGB7KtpnZb0UJC6ETnfqX88a9SGMbONWOd
         ggZw==
X-Gm-Message-State: ACrzQf1MaMPNul0YCxMccZqX/iDlsSTr8IHkkNmYdruB05oC8ZAXhTyn
        sCnfnSBYl28qTYdUcbAGPdy0LqhJjMoaQ+qM
X-Google-Smtp-Source: AMsMyM7U6QtOfjRtLEvHhafVxd2Typ3vGFACBScGTzt4dGpN5ExRr+u3NtmZyooil8Yr5UMNKl7jIoiR4PCD61EC
X-Received: from jthoughton.c.googlers.com ([fda3:e722:ac3:cc00:14:4d90:c0a8:2a4f])
 (user=jthoughton job=sendgmr) by 2002:a05:6902:110e:b0:66d:e6dc:5f31 with
 SMTP id o14-20020a056902110e00b0066de6dc5f31mr17202827ybu.628.1666370256631;
 Fri, 21 Oct 2022 09:37:36 -0700 (PDT)
Date:   Fri, 21 Oct 2022 16:36:38 +0000
In-Reply-To: <20221021163703.3218176-1-jthoughton@google.com>
Mime-Version: 1.0
References: <20221021163703.3218176-1-jthoughton@google.com>
X-Mailer: git-send-email 2.38.0.135.g90850a2211-goog
Message-ID: <20221021163703.3218176-23-jthoughton@google.com>
Subject: [RFC PATCH v2 22/47] mm: rmap: make page_vma_mapped_walk callers use pte_order
From:   James Houghton <jthoughton@google.com>
To:     Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Peter Xu <peterx@redhat.com>
Cc:     David Hildenbrand <david@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Mina Almasry <almasrymina@google.com>,
        "Zach O'Keefe" <zokeefe@google.com>,
        Manish Mishra <manish.mishra@nutanix.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Yang Shi <shy828301@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        James Houghton <jthoughton@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This also updates the callers' hugetlb mapcounting code to handle
mapcount properly for subpage-mapped hugetlb pages.

Signed-off-by: James Houghton <jthoughton@google.com>
---
 mm/migrate.c |  2 +-
 mm/rmap.c    | 17 +++++++++++++----
 2 files changed, 14 insertions(+), 5 deletions(-)

diff --git a/mm/migrate.c b/mm/migrate.c
index a0105fa6e3b2..8712b694c5a7 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -235,7 +235,7 @@ static bool remove_migration_pte(struct folio *folio,
 
 #ifdef CONFIG_HUGETLB_PAGE
 		if (folio_test_hugetlb(folio)) {
-			unsigned int shift = huge_page_shift(hstate_vma(vma));
+			unsigned int shift = pvmw.pte_order + PAGE_SHIFT;
 
 			pte = arch_make_huge_pte(pte, shift, vma->vm_flags);
 			if (folio_test_anon(folio))
diff --git a/mm/rmap.c b/mm/rmap.c
index 9bba65b30e4d..19850d955aea 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -1626,7 +1626,7 @@ static bool try_to_unmap_one(struct folio *folio, struct vm_area_struct *vma,
 		if (PageHWPoison(subpage) && !(flags & TTU_IGNORE_HWPOISON)) {
 			pteval = swp_entry_to_pte(make_hwpoison_entry(subpage));
 			if (folio_test_hugetlb(folio)) {
-				hugetlb_count_sub(folio_nr_pages(folio), mm);
+				hugetlb_count_sub(1UL << pvmw.pte_order, mm);
 				set_huge_pte_at(mm, address, pvmw.pte, pteval);
 			} else {
 				dec_mm_counter(mm, mm_counter(&folio->page));
@@ -1785,7 +1785,11 @@ static bool try_to_unmap_one(struct folio *folio, struct vm_area_struct *vma,
 		 *
 		 * See Documentation/mm/mmu_notifier.rst
 		 */
-		page_remove_rmap(subpage, vma, folio_test_hugetlb(folio));
+		if (folio_test_hugetlb(folio))
+			page_remove_rmap(&folio->page, vma, true);
+		else
+			page_remove_rmap(subpage, vma, false);
+
 		if (vma->vm_flags & VM_LOCKED)
 			mlock_page_drain_local();
 		folio_put(folio);
@@ -2034,7 +2038,7 @@ static bool try_to_migrate_one(struct folio *folio, struct vm_area_struct *vma,
 		} else if (PageHWPoison(subpage)) {
 			pteval = swp_entry_to_pte(make_hwpoison_entry(subpage));
 			if (folio_test_hugetlb(folio)) {
-				hugetlb_count_sub(folio_nr_pages(folio), mm);
+				hugetlb_count_sub(1L << pvmw.pte_order, mm);
 				set_huge_pte_at(mm, address, pvmw.pte, pteval);
 			} else {
 				dec_mm_counter(mm, mm_counter(&folio->page));
@@ -2126,7 +2130,10 @@ static bool try_to_migrate_one(struct folio *folio, struct vm_area_struct *vma,
 		 *
 		 * See Documentation/mm/mmu_notifier.rst
 		 */
-		page_remove_rmap(subpage, vma, folio_test_hugetlb(folio));
+		if (folio_test_hugetlb(folio))
+			page_remove_rmap(&folio->page, vma, true);
+		else
+			page_remove_rmap(subpage, vma, false);
 		if (vma->vm_flags & VM_LOCKED)
 			mlock_page_drain_local();
 		folio_put(folio);
@@ -2210,6 +2217,8 @@ static bool page_make_device_exclusive_one(struct folio *folio,
 				      args->owner);
 	mmu_notifier_invalidate_range_start(&range);
 
+	VM_BUG_ON_FOLIO(folio_test_hugetlb(folio), folio);
+
 	while (page_vma_mapped_walk(&pvmw)) {
 		/* Unexpected PMD-mapped THP? */
 		VM_BUG_ON_FOLIO(!pvmw.pte, folio);
-- 
2.38.0.135.g90850a2211-goog

