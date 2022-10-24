Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F07DB6099CF
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 07:29:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229634AbiJXF3D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 01:29:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229907AbiJXF27 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 01:28:59 -0400
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE68A7B2A3
        for <linux-kernel@vger.kernel.org>; Sun, 23 Oct 2022 22:28:57 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id h2-20020a170902f54200b0018553a8b797so5776810plf.9
        for <linux-kernel@vger.kernel.org>; Sun, 23 Oct 2022 22:28:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=sOfhY6ymaaRiz2tIqe/6KSmlUjgNrp1ZhFMBg9VFg/E=;
        b=q3Cwas5rHaUkvREcs3dVNF37YXiqFoOkf6lSGn2lr9OPPCzeW4cctRZi+M6eM+FM6U
         eIzBHcRpUViYD4XGBbF1eT1hkaajUShpDABtQJKyGBIx7tKNG2N3ml3L004EFQTzwl/c
         QUFbs1AeQC2tzpGCONsH+X5jJzidbPkaR0A0MqMpI55NNwtkx87Ahw+HPyfQxGuZdbMU
         6gEo1g0R5beSn22NcyNp5iUOdloxpF4x0FKEPwOaKCtjAsLuYsm5FJndZ1+upfWVLJuH
         9QJKQK7qkLGDiQBI0U/JC8OXqq9VuebBix/DCtoBaM9h5gMRbzNSC+VD3fP9Bnks99+o
         enpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sOfhY6ymaaRiz2tIqe/6KSmlUjgNrp1ZhFMBg9VFg/E=;
        b=QvKwEi1MOoZwX1UWwMA/oz07kV1eSDCdgzYoXCApVjJ1nJgvvATqowua7KAsDQkVCQ
         47eVufLsrG8HT8qry1crcV0FhCncwhnixxpjLdK5X3/knPFtBI0/sueWvvMPX4N4c0mz
         DVrURZnfXsMEiP0ZXkxq7zPmDfdN5XJQj0Lab4XMuG+LroOpDwlbofjOCMW5Tmv8ypj/
         it0ESrVRrgOPz+kEe/Xzh7IvM1Cf3moPFuP+v3531uIZYdeKMmWxxIuexZsDn33oxLqB
         kBMscauz//K7qsD6axjHeLn0DPzaQ1kOADyrsnHCLQ0wBjBDD0nfAf8FRyctwR8qtTsD
         jVOg==
X-Gm-Message-State: ACrzQf39FJ82YEU2dwEc/HVxMlIQRjNHdVTBVrbKeKxN1wJGtSZ810fv
        3YhGsKqOB7EYlcjvXTgSMk7TtPsH+XDBLw==
X-Google-Smtp-Source: AMsMyM5aUoWlP9eavz+oPYQMusFGBVtUuLp4Yyl60VGOLbW8B19O2u7Qs6+sANo39zMJez8Hk3LojGMqDz8Ytw==
X-Received: from shakeelb.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:262e])
 (user=shakeelb job=sendgmr) by 2002:a17:90a:d14a:b0:203:7b4b:6010 with SMTP
 id t10-20020a17090ad14a00b002037b4b6010mr72452801pjw.237.1666589337176; Sun,
 23 Oct 2022 22:28:57 -0700 (PDT)
Date:   Mon, 24 Oct 2022 05:28:41 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.38.0.135.g90850a2211-goog
Message-ID: <20221024052841.3291983-1-shakeelb@google.com>
Subject: [PATCH] mm: convert mm's rss stats into percpu_counter
From:   Shakeel Butt <shakeelb@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Shakeel Butt <shakeelb@google.com>
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

Currently mm_struct maintains rss_stats which are updated on page fault
and the unmapping codepaths. For page fault codepath the updates are
cached per thread with the batch of TASK_RSS_EVENTS_THRESH which is 64.
The reason for caching is performance for multithreaded applications
otherwise the rss_stats updates may become hotspot for such
applications.

However this optimization comes with the cost of error margin in the rss
stats. The rss_stats for applications with large number of threads can
be very skewed. At worst the error margin is (nr_threads * 64) and we
have a lot of applications with 100s of threads, so the error margin can
be very high. Internally we had to reduce TASK_RSS_EVENTS_THRESH to 32.

Recently we started seeing the unbounded errors for rss_stats for
specific applications which use TCP rx0cp. It seems like
vm_insert_pages() codepath does not sync rss_stats at all.

This patch converts the rss_stats into percpu_counter to convert the
error margin from (nr_threads * 64) to approximately (nr_cpus ^ 2).
However this conversion enable us to get the accurate stats for
situations where accuracy is more important than the cpu cost. Though
this patch does not make such tradeoffs.

Signed-off-by: Shakeel Butt <shakeelb@google.com>
---
 include/linux/mm.h             | 26 ++++--------
 include/linux/mm_types.h       |  7 +---
 include/linux/mm_types_task.h  | 13 ------
 include/linux/percpu_counter.h |  1 -
 include/linux/sched.h          |  3 --
 include/trace/events/kmem.h    |  8 ++--
 kernel/fork.c                  | 16 +++++++-
 mm/memory.c                    | 73 +++++-----------------------------
 8 files changed, 40 insertions(+), 107 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 9dec25c7d631..a8a9c3a20534 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2000,40 +2000,30 @@ static inline bool get_user_page_fast_only(unsigned long addr,
  */
 static inline unsigned long get_mm_counter(struct mm_struct *mm, int member)
 {
-	long val = atomic_long_read(&mm->rss_stat.count[member]);
-
-#ifdef SPLIT_RSS_COUNTING
-	/*
-	 * counter is updated in asynchronous manner and may go to minus.
-	 * But it's never be expected number for users.
-	 */
-	if (val < 0)
-		val = 0;
-#endif
-	return (unsigned long)val;
+	return percpu_counter_read_positive(&mm->rss_stat[member]);
 }
 
-void mm_trace_rss_stat(struct mm_struct *mm, int member, long count);
+void mm_trace_rss_stat(struct mm_struct *mm, int member);
 
 static inline void add_mm_counter(struct mm_struct *mm, int member, long value)
 {
-	long count = atomic_long_add_return(value, &mm->rss_stat.count[member]);
+	percpu_counter_add(&mm->rss_stat[member], value);
 
-	mm_trace_rss_stat(mm, member, count);
+	mm_trace_rss_stat(mm, member);
 }
 
 static inline void inc_mm_counter(struct mm_struct *mm, int member)
 {
-	long count = atomic_long_inc_return(&mm->rss_stat.count[member]);
+	percpu_counter_inc(&mm->rss_stat[member]);
 
-	mm_trace_rss_stat(mm, member, count);
+	mm_trace_rss_stat(mm, member);
 }
 
 static inline void dec_mm_counter(struct mm_struct *mm, int member)
 {
-	long count = atomic_long_dec_return(&mm->rss_stat.count[member]);
+	percpu_counter_dec(&mm->rss_stat[member]);
 
-	mm_trace_rss_stat(mm, member, count);
+	mm_trace_rss_stat(mm, member);
 }
 
 /* Optimized variant when page is already known not to be PageAnon */
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index a82f06ab18a1..834022721bc6 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -18,6 +18,7 @@
 #include <linux/page-flags-layout.h>
 #include <linux/workqueue.h>
 #include <linux/seqlock.h>
+#include <linux/percpu_counter.h>
 
 #include <asm/mmu.h>
 
@@ -626,11 +627,7 @@ struct mm_struct {
 
 		unsigned long saved_auxv[AT_VECTOR_SIZE]; /* for /proc/PID/auxv */
 
-		/*
-		 * Special counters, in some configurations protected by the
-		 * page_table_lock, in other configurations by being atomic.
-		 */
-		struct mm_rss_stat rss_stat;
+		struct percpu_counter rss_stat[NR_MM_COUNTERS];
 
 		struct linux_binfmt *binfmt;
 
diff --git a/include/linux/mm_types_task.h b/include/linux/mm_types_task.h
index 0bb4b6da9993..5414b5c6a103 100644
--- a/include/linux/mm_types_task.h
+++ b/include/linux/mm_types_task.h
@@ -36,19 +36,6 @@ enum {
 	NR_MM_COUNTERS
 };
 
-#if USE_SPLIT_PTE_PTLOCKS && defined(CONFIG_MMU)
-#define SPLIT_RSS_COUNTING
-/* per-thread cached information, */
-struct task_rss_stat {
-	int events;	/* for synchronization threshold */
-	int count[NR_MM_COUNTERS];
-};
-#endif /* USE_SPLIT_PTE_PTLOCKS */
-
-struct mm_rss_stat {
-	atomic_long_t count[NR_MM_COUNTERS];
-};
-
 struct page_frag {
 	struct page *page;
 #if (BITS_PER_LONG > 32) || (PAGE_SIZE >= 65536)
diff --git a/include/linux/percpu_counter.h b/include/linux/percpu_counter.h
index 8ed5fba6d156..bde6c4c1f405 100644
--- a/include/linux/percpu_counter.h
+++ b/include/linux/percpu_counter.h
@@ -13,7 +13,6 @@
 #include <linux/threads.h>
 #include <linux/percpu.h>
 #include <linux/types.h>
-#include <linux/gfp.h>
 
 /* percpu_counter batch for local add or sub */
 #define PERCPU_COUNTER_LOCAL_BATCH	INT_MAX
diff --git a/include/linux/sched.h b/include/linux/sched.h
index ffb6eb55cd13..079d299fa465 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -870,9 +870,6 @@ struct task_struct {
 	struct mm_struct		*mm;
 	struct mm_struct		*active_mm;
 
-#ifdef SPLIT_RSS_COUNTING
-	struct task_rss_stat		rss_stat;
-#endif
 	int				exit_state;
 	int				exit_code;
 	int				exit_signal;
diff --git a/include/trace/events/kmem.h b/include/trace/events/kmem.h
index 243073cfc29d..58688768ef0f 100644
--- a/include/trace/events/kmem.h
+++ b/include/trace/events/kmem.h
@@ -346,10 +346,9 @@ TRACE_MM_PAGES
 TRACE_EVENT(rss_stat,
 
 	TP_PROTO(struct mm_struct *mm,
-		int member,
-		long count),
+		int member),
 
-	TP_ARGS(mm, member, count),
+	TP_ARGS(mm, member),
 
 	TP_STRUCT__entry(
 		__field(unsigned int, mm_id)
@@ -362,7 +361,8 @@ TRACE_EVENT(rss_stat,
 		__entry->mm_id = mm_ptr_to_hash(mm);
 		__entry->curr = !!(current->mm == mm);
 		__entry->member = member;
-		__entry->size = (count << PAGE_SHIFT);
+		__entry->size = (percpu_counter_sum_positive(&mm->rss_stat[member])
+							    << PAGE_SHIFT);
 	),
 
 	TP_printk("mm_id=%u curr=%d type=%s size=%ldB",
diff --git a/kernel/fork.c b/kernel/fork.c
index cfb09ca1b1bc..f56ad06240e1 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -756,7 +756,7 @@ static void check_mm(struct mm_struct *mm)
 			 "Please make sure 'struct resident_page_types[]' is updated as well");
 
 	for (i = 0; i < NR_MM_COUNTERS; i++) {
-		long x = atomic_long_read(&mm->rss_stat.count[i]);
+		long x = percpu_counter_sum(&mm->rss_stat[i]);
 
 		if (unlikely(x))
 			pr_alert("BUG: Bad rss-counter state mm:%p type:%s val:%ld\n",
@@ -782,6 +782,8 @@ static void check_mm(struct mm_struct *mm)
  */
 void __mmdrop(struct mm_struct *mm)
 {
+	int i;
+
 	BUG_ON(mm == &init_mm);
 	WARN_ON_ONCE(mm == current->mm);
 	WARN_ON_ONCE(mm == current->active_mm);
@@ -791,6 +793,9 @@ void __mmdrop(struct mm_struct *mm)
 	check_mm(mm);
 	put_user_ns(mm->user_ns);
 	mm_pasid_drop(mm);
+
+	for (i = 0; i < NR_MM_COUNTERS; i++)
+		percpu_counter_destroy(&mm->rss_stat[i]);
 	free_mm(mm);
 }
 EXPORT_SYMBOL_GPL(__mmdrop);
@@ -1110,6 +1115,8 @@ static void mm_init_uprobes_state(struct mm_struct *mm)
 static struct mm_struct *mm_init(struct mm_struct *mm, struct task_struct *p,
 	struct user_namespace *user_ns)
 {
+	int i;
+
 	mt_init_flags(&mm->mm_mt, MM_MT_FLAGS);
 	mt_set_external_lock(&mm->mm_mt, &mm->mmap_lock);
 	atomic_set(&mm->mm_users, 1);
@@ -1151,10 +1158,17 @@ static struct mm_struct *mm_init(struct mm_struct *mm, struct task_struct *p,
 	if (init_new_context(p, mm))
 		goto fail_nocontext;
 
+	for (i = 0; i < NR_MM_COUNTERS; i++)
+		if (percpu_counter_init(&mm->rss_stat[i], 0, GFP_KERNEL_ACCOUNT))
+			goto fail_pcpu;
+
 	mm->user_ns = get_user_ns(user_ns);
 	lru_gen_init_mm(mm);
 	return mm;
 
+fail_pcpu:
+	while (i > 0)
+		percpu_counter_destroy(&mm->rss_stat[--i]);
 fail_nocontext:
 	mm_free_pgd(mm);
 fail_nopgd:
diff --git a/mm/memory.c b/mm/memory.c
index 8e72f703ed99..fea8d737e8c0 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -162,58 +162,11 @@ static int __init init_zero_pfn(void)
 }
 early_initcall(init_zero_pfn);
 
-void mm_trace_rss_stat(struct mm_struct *mm, int member, long count)
+void mm_trace_rss_stat(struct mm_struct *mm, int member)
 {
-	trace_rss_stat(mm, member, count);
+	trace_rss_stat(mm, member);
 }
 
-#if defined(SPLIT_RSS_COUNTING)
-
-void sync_mm_rss(struct mm_struct *mm)
-{
-	int i;
-
-	for (i = 0; i < NR_MM_COUNTERS; i++) {
-		if (current->rss_stat.count[i]) {
-			add_mm_counter(mm, i, current->rss_stat.count[i]);
-			current->rss_stat.count[i] = 0;
-		}
-	}
-	current->rss_stat.events = 0;
-}
-
-static void add_mm_counter_fast(struct mm_struct *mm, int member, int val)
-{
-	struct task_struct *task = current;
-
-	if (likely(task->mm == mm))
-		task->rss_stat.count[member] += val;
-	else
-		add_mm_counter(mm, member, val);
-}
-#define inc_mm_counter_fast(mm, member) add_mm_counter_fast(mm, member, 1)
-#define dec_mm_counter_fast(mm, member) add_mm_counter_fast(mm, member, -1)
-
-/* sync counter once per 64 page faults */
-#define TASK_RSS_EVENTS_THRESH	(64)
-static void check_sync_rss_stat(struct task_struct *task)
-{
-	if (unlikely(task != current))
-		return;
-	if (unlikely(task->rss_stat.events++ > TASK_RSS_EVENTS_THRESH))
-		sync_mm_rss(task->mm);
-}
-#else /* SPLIT_RSS_COUNTING */
-
-#define inc_mm_counter_fast(mm, member) inc_mm_counter(mm, member)
-#define dec_mm_counter_fast(mm, member) dec_mm_counter(mm, member)
-
-static void check_sync_rss_stat(struct task_struct *task)
-{
-}
-
-#endif /* SPLIT_RSS_COUNTING */
-
 /*
  * Note: this doesn't free the actual pages themselves. That
  * has been handled earlier when unmapping all the memory regions.
@@ -1860,7 +1813,7 @@ static int insert_page_into_pte_locked(struct vm_area_struct *vma, pte_t *pte,
 		return -EBUSY;
 	/* Ok, finally just insert the thing.. */
 	get_page(page);
-	inc_mm_counter_fast(vma->vm_mm, mm_counter_file(page));
+	inc_mm_counter(vma->vm_mm, mm_counter_file(page));
 	page_add_file_rmap(page, vma, false);
 	set_pte_at(vma->vm_mm, addr, pte, mk_pte(page, prot));
 	return 0;
@@ -3156,12 +3109,11 @@ static vm_fault_t wp_page_copy(struct vm_fault *vmf)
 	if (likely(pte_same(*vmf->pte, vmf->orig_pte))) {
 		if (old_page) {
 			if (!PageAnon(old_page)) {
-				dec_mm_counter_fast(mm,
-						mm_counter_file(old_page));
-				inc_mm_counter_fast(mm, MM_ANONPAGES);
+				dec_mm_counter(mm, mm_counter_file(old_page));
+				inc_mm_counter(mm, MM_ANONPAGES);
 			}
 		} else {
-			inc_mm_counter_fast(mm, MM_ANONPAGES);
+			inc_mm_counter(mm, MM_ANONPAGES);
 		}
 		flush_cache_page(vma, vmf->address, pte_pfn(vmf->orig_pte));
 		entry = mk_pte(new_page, vma->vm_page_prot);
@@ -3968,8 +3920,8 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 	if (should_try_to_free_swap(folio, vma, vmf->flags))
 		folio_free_swap(folio);
 
-	inc_mm_counter_fast(vma->vm_mm, MM_ANONPAGES);
-	dec_mm_counter_fast(vma->vm_mm, MM_SWAPENTS);
+	inc_mm_counter(vma->vm_mm, MM_ANONPAGES);
+	dec_mm_counter(vma->vm_mm, MM_SWAPENTS);
 	pte = mk_pte(page, vma->vm_page_prot);
 
 	/*
@@ -4148,7 +4100,7 @@ static vm_fault_t do_anonymous_page(struct vm_fault *vmf)
 		return handle_userfault(vmf, VM_UFFD_MISSING);
 	}
 
-	inc_mm_counter_fast(vma->vm_mm, MM_ANONPAGES);
+	inc_mm_counter(vma->vm_mm, MM_ANONPAGES);
 	page_add_new_anon_rmap(page, vma, vmf->address);
 	lru_cache_add_inactive_or_unevictable(page, vma);
 setpte:
@@ -4338,11 +4290,11 @@ void do_set_pte(struct vm_fault *vmf, struct page *page, unsigned long addr)
 		entry = pte_mkuffd_wp(pte_wrprotect(entry));
 	/* copy-on-write page */
 	if (write && !(vma->vm_flags & VM_SHARED)) {
-		inc_mm_counter_fast(vma->vm_mm, MM_ANONPAGES);
+		inc_mm_counter(vma->vm_mm, MM_ANONPAGES);
 		page_add_new_anon_rmap(page, vma, addr);
 		lru_cache_add_inactive_or_unevictable(page, vma);
 	} else {
-		inc_mm_counter_fast(vma->vm_mm, mm_counter_file(page));
+		inc_mm_counter(vma->vm_mm, mm_counter_file(page));
 		page_add_file_rmap(page, vma, false);
 	}
 	set_pte_at(vma->vm_mm, addr, vmf->pte, entry);
@@ -5194,9 +5146,6 @@ vm_fault_t handle_mm_fault(struct vm_area_struct *vma, unsigned long address,
 	count_vm_event(PGFAULT);
 	count_memcg_event_mm(vma->vm_mm, PGFAULT);
 
-	/* do counter updates before entering really critical section. */
-	check_sync_rss_stat(current);
-
 	if (!arch_vma_access_permitted(vma, flags & FAULT_FLAG_WRITE,
 					    flags & FAULT_FLAG_INSTRUCTION,
 					    flags & FAULT_FLAG_REMOTE))
-- 
2.38.0.135.g90850a2211-goog

