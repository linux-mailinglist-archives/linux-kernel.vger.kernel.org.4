Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B774570B48C
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 07:28:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231991AbjEVF2E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 01:28:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229777AbjEVF2D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 01:28:03 -0400
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE0C5A8
        for <linux-kernel@vger.kernel.org>; Sun, 21 May 2023 22:28:01 -0700 (PDT)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-561e5014336so44501597b3.1
        for <linux-kernel@vger.kernel.org>; Sun, 21 May 2023 22:28:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684733281; x=1687325281;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=5QGRbISmNdiSrcRCSB3pJg16AgA7v+5ZDTS/B09Kn8o=;
        b=fVaNEVFFiBF4weUE59/pRbRilwRxpePXgogsf2ieUkcR0MbQmK9TAJMKwiY+Nl3wQv
         zKHe//Tgn/dCTvP7G0yKMDDCqiRigP7TN+cRzAhOy91u60ZDaLJj9pISGxGf7L/o9RQV
         RIdEDl0ysDGYdG9CQkCaefawPcW0Pu46VUAhGlWTpeI7kCMeXW2zSJd4jXBBPMxr+Sk7
         BBLjIT+TptnFiPfiUV09WlYuflTUtcZ1khoOvaNMb55o7+CG56Ax+prHX5PMQDGLuiD5
         5JiMmNrkUrTjybBbOntUDonvOeyTUvUndYAkHD0GpeLxqXMXoE3ar/hPCiH8QI5EkB9C
         IHZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684733281; x=1687325281;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5QGRbISmNdiSrcRCSB3pJg16AgA7v+5ZDTS/B09Kn8o=;
        b=amRV71fttttPb/ZxO5fCWtBl3Ur3yh46nHS8RcaGEnvN3mkmiX4jUY5sKjqn9OVoRf
         p+jG9WsElZMhtBDlRLKhYNqMRmZTiR9INpSVkCoTthdVz/K/KItG1BscqJoV/T55H2fO
         jQf8XbDpH0W1WzDXtQiohwN2NL2y6RGYos+9iT5DarvPqPb5psZQFbdh3vcqAr36hLuO
         RW0LvTd/yPCcVxIhok15c9DwuVWypjMT1NU+bsbhpmFHXTZMRnCqdMaPo9WygLno+iMU
         kyTrBOoYwWe68vs9Wg2O0ulk7rON4Va6SQJTKEUOf5UFxOaEb+bHwiR0niRzOPbOub2o
         76TA==
X-Gm-Message-State: AC+VfDwKTMx5mvg68DSTMBCn65jjPHPr9x2lmD5Hq7+aoe3cIdt5KJi1
        TXLUZwTy8AI2fRJiaPrPuJDjLQ==
X-Google-Smtp-Source: ACHHUZ7e18kwUgmVMtp2lWAMCU5Id6EnMaAFL78obg4zT8QsdVgO5fiVzPuIAxqLocTFuTV77qh/ag==
X-Received: by 2002:a81:a044:0:b0:561:e2df:c4d1 with SMTP id x65-20020a81a044000000b00561e2dfc4d1mr10124450ywg.9.1684733280842;
        Sun, 21 May 2023 22:28:00 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id k131-20020a816f89000000b0055a416529bbsm1831188ywc.24.2023.05.21.22.27.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 May 2023 22:28:00 -0700 (PDT)
Date:   Sun, 21 May 2023 22:27:57 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.attlocal.net
To:     Andrew Morton <akpm@linux-foundation.org>
cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@kernel.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Qi Zheng <zhengqi.arch@bytedance.com>,
        Yang Shi <shy828301@gmail.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Peter Xu <peterx@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>, Yu Zhao <yuzhao@google.com>,
        Alistair Popple <apopple@nvidia.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Steven Price <steven.price@arm.com>,
        SeongJae Park <sj@kernel.org>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Zack Rusin <zackr@vmware.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Minchan Kim <minchan@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Song Liu <song@kernel.org>,
        Thomas Hellstrom <thomas.hellstrom@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH 30/31] mm/pgtable: delete pmd_trans_unstable() and friends
In-Reply-To: <68a97fbe-5c1e-7ac6-72c-7b9c6290b370@google.com>
Message-ID: <a4dc7989-9026-67f7-f07c-570645ec577@google.com>
References: <68a97fbe-5c1e-7ac6-72c-7b9c6290b370@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Delete pmd_trans_unstable, pmd_none_or_trans_huge_or_clear_bad() and
pmd_devmap_trans_unstable(), all now unused.

With mixed feelings, delete all the comments on pmd_trans_unstable().
That was very good documentation of a subtle state, and this series does
not even eliminate that state: but rather, normalizes and extends it,
asking pte_offset_map[_lock]() callers to anticipate failure, without
regard for whether mmap_read_lock() or mmap_write_lock() is held.

Retain pud_trans_unstable(), which has one use in __handle_mm_fault(),
but delete its equivalent pud_none_or_trans_huge_or_dev_or_clear_bad().
While there, move the default arch_needs_pgtable_deposit() definition
up near where pgtable_trans_huge_deposit() and withdraw() are declared.

Signed-off-by: Hugh Dickins <hughd@google.com>
---
 include/linux/pgtable.h | 103 +++-------------------------------------
 mm/khugepaged.c         |   4 --
 2 files changed, 7 insertions(+), 100 deletions(-)

diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
index 3fabbb018557..a1326e61d7ee 100644
--- a/include/linux/pgtable.h
+++ b/include/linux/pgtable.h
@@ -599,6 +599,10 @@ extern void pgtable_trans_huge_deposit(struct mm_struct *mm, pmd_t *pmdp,
 extern pgtable_t pgtable_trans_huge_withdraw(struct mm_struct *mm, pmd_t *pmdp);
 #endif
 
+#ifndef arch_needs_pgtable_deposit
+#define arch_needs_pgtable_deposit() (false)
+#endif
+
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
 /*
  * This is an implementation of pmdp_establish() that is only suitable for an
@@ -1300,9 +1304,10 @@ static inline int pud_trans_huge(pud_t pud)
 }
 #endif
 
-/* See pmd_none_or_trans_huge_or_clear_bad for discussion. */
-static inline int pud_none_or_trans_huge_or_dev_or_clear_bad(pud_t *pud)
+static inline int pud_trans_unstable(pud_t *pud)
 {
+#if defined(CONFIG_TRANSPARENT_HUGEPAGE) && \
+	defined(CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD)
 	pud_t pudval = READ_ONCE(*pud);
 
 	if (pud_none(pudval) || pud_trans_huge(pudval) || pud_devmap(pudval))
@@ -1311,104 +1316,10 @@ static inline int pud_none_or_trans_huge_or_dev_or_clear_bad(pud_t *pud)
 		pud_clear_bad(pud);
 		return 1;
 	}
-	return 0;
-}
-
-/* See pmd_trans_unstable for discussion. */
-static inline int pud_trans_unstable(pud_t *pud)
-{
-#if defined(CONFIG_TRANSPARENT_HUGEPAGE) &&			\
-	defined(CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD)
-	return pud_none_or_trans_huge_or_dev_or_clear_bad(pud);
-#else
-	return 0;
 #endif
-}
-
-#ifndef arch_needs_pgtable_deposit
-#define arch_needs_pgtable_deposit() (false)
-#endif
-/*
- * This function is meant to be used by sites walking pagetables with
- * the mmap_lock held in read mode to protect against MADV_DONTNEED and
- * transhuge page faults. MADV_DONTNEED can convert a transhuge pmd
- * into a null pmd and the transhuge page fault can convert a null pmd
- * into an hugepmd or into a regular pmd (if the hugepage allocation
- * fails). While holding the mmap_lock in read mode the pmd becomes
- * stable and stops changing under us only if it's not null and not a
- * transhuge pmd. When those races occurs and this function makes a
- * difference vs the standard pmd_none_or_clear_bad, the result is
- * undefined so behaving like if the pmd was none is safe (because it
- * can return none anyway). The compiler level barrier() is critically
- * important to compute the two checks atomically on the same pmdval.
- *
- * For 32bit kernels with a 64bit large pmd_t this automatically takes
- * care of reading the pmd atomically to avoid SMP race conditions
- * against pmd_populate() when the mmap_lock is hold for reading by the
- * caller (a special atomic read not done by "gcc" as in the generic
- * version above, is also needed when THP is disabled because the page
- * fault can populate the pmd from under us).
- */
-static inline int pmd_none_or_trans_huge_or_clear_bad(pmd_t *pmd)
-{
-	pmd_t pmdval = pmdp_get_lockless(pmd);
-	/*
-	 * !pmd_present() checks for pmd migration entries
-	 *
-	 * The complete check uses is_pmd_migration_entry() in linux/swapops.h
-	 * But using that requires moving current function and pmd_trans_unstable()
-	 * to linux/swapops.h to resolve dependency, which is too much code move.
-	 *
-	 * !pmd_present() is equivalent to is_pmd_migration_entry() currently,
-	 * because !pmd_present() pages can only be under migration not swapped
-	 * out.
-	 *
-	 * pmd_none() is preserved for future condition checks on pmd migration
-	 * entries and not confusing with this function name, although it is
-	 * redundant with !pmd_present().
-	 */
-	if (pmd_none(pmdval) || pmd_trans_huge(pmdval) ||
-		(IS_ENABLED(CONFIG_ARCH_ENABLE_THP_MIGRATION) && !pmd_present(pmdval)))
-		return 1;
-	if (unlikely(pmd_bad(pmdval))) {
-		pmd_clear_bad(pmd);
-		return 1;
-	}
 	return 0;
 }
 
-/*
- * This is a noop if Transparent Hugepage Support is not built into
- * the kernel. Otherwise it is equivalent to
- * pmd_none_or_trans_huge_or_clear_bad(), and shall only be called in
- * places that already verified the pmd is not none and they want to
- * walk ptes while holding the mmap sem in read mode (write mode don't
- * need this). If THP is not enabled, the pmd can't go away under the
- * code even if MADV_DONTNEED runs, but if THP is enabled we need to
- * run a pmd_trans_unstable before walking the ptes after
- * split_huge_pmd returns (because it may have run when the pmd become
- * null, but then a page fault can map in a THP and not a regular page).
- */
-static inline int pmd_trans_unstable(pmd_t *pmd)
-{
-#ifdef CONFIG_TRANSPARENT_HUGEPAGE
-	return pmd_none_or_trans_huge_or_clear_bad(pmd);
-#else
-	return 0;
-#endif
-}
-
-/*
- * the ordering of these checks is important for pmds with _page_devmap set.
- * if we check pmd_trans_unstable() first we will trip the bad_pmd() check
- * inside of pmd_none_or_trans_huge_or_clear_bad(). this will end up correctly
- * returning 1 but not before it spams dmesg with the pmd_clear_bad() output.
- */
-static inline int pmd_devmap_trans_unstable(pmd_t *pmd)
-{
-	return pmd_devmap(*pmd) || pmd_trans_unstable(pmd);
-}
-
 #ifndef CONFIG_NUMA_BALANCING
 /*
  * Technically a PTE can be PROTNONE even when not doing NUMA balancing but
diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index c11db2e78e95..1083f0e38a07 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -946,10 +946,6 @@ static int hugepage_vma_revalidate(struct mm_struct *mm, unsigned long address,
 	return SCAN_SUCCEED;
 }
 
-/*
- * See pmd_trans_unstable() for how the result may change out from
- * underneath us, even if we hold mmap_lock in read.
- */
 static int find_pmd_or_thp_or_none(struct mm_struct *mm,
 				   unsigned long address,
 				   pmd_t **pmd)
-- 
2.35.3

