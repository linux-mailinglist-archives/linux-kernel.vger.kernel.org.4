Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0E0D727E8D
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 13:14:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233994AbjFHLOP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 07:14:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230033AbjFHLON (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 07:14:13 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83A33199D
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 04:14:10 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 373E41FDE4;
        Thu,  8 Jun 2023 11:14:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1686222849; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gXmZC4yZXoGwet096gORxV7dAuBZSkjs3aTqliULLLk=;
        b=LyxQrjH+PhhWLWgPoHRsHMtGDHtTtq7+1YQGgCO97O6KiEAZR80zEe6sOtbA7dNRU2sb5f
        CMMQfNcOEEdAU1GVr05yJx2WT/GyszsQMcXUwpmdPI1FbYSvLKjtH/BV60Rqv1FyzuVR8m
        fG/4JtDtliw9zFHqYtUzqvByXeKJqOk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1686222849;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gXmZC4yZXoGwet096gORxV7dAuBZSkjs3aTqliULLLk=;
        b=9XSTaFiWyDnfAKs2GHzbCTrfNYuo+bu8yr2udfHt03nP9IpQ5cw1fZ1sGapkbb/jOIUwFt
        VUX87jI/hRAb5JCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 22E6413480;
        Thu,  8 Jun 2023 11:14:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id iRR2CAG4gWR6HgAAMHmgww
        (envelope-from <jack@suse.cz>); Thu, 08 Jun 2023 11:14:09 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id A5985A0749; Thu,  8 Jun 2023 13:14:08 +0200 (CEST)
Date:   Thu, 8 Jun 2023 13:14:08 +0200
From:   Jan Kara <jack@suse.cz>
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, mhocko@suse.cz, vbabka@suse.cz,
        regressions@lists.linux.dev, Yu Ma <yu.ma@intel.com>
Subject: Re: [PATCH] mm: convert mm's rss stats into percpu_counter
Message-ID: <20230608111408.s2minsenlcjow7q3@quack3>
References: <20221024052841.3291983-1-shakeelb@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221024052841.3291983-1-shakeelb@google.com>
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 24-10-22 05:28:41, Shakeel Butt wrote:
> Currently mm_struct maintains rss_stats which are updated on page fault
> and the unmapping codepaths. For page fault codepath the updates are
> cached per thread with the batch of TASK_RSS_EVENTS_THRESH which is 64.
> The reason for caching is performance for multithreaded applications
> otherwise the rss_stats updates may become hotspot for such
> applications.
> 
> However this optimization comes with the cost of error margin in the rss
> stats. The rss_stats for applications with large number of threads can
> be very skewed. At worst the error margin is (nr_threads * 64) and we
> have a lot of applications with 100s of threads, so the error margin can
> be very high. Internally we had to reduce TASK_RSS_EVENTS_THRESH to 32.
> 
> Recently we started seeing the unbounded errors for rss_stats for
> specific applications which use TCP rx0cp. It seems like
> vm_insert_pages() codepath does not sync rss_stats at all.
> 
> This patch converts the rss_stats into percpu_counter to convert the
> error margin from (nr_threads * 64) to approximately (nr_cpus ^ 2).
> However this conversion enable us to get the accurate stats for
> situations where accuracy is more important than the cpu cost. Though
> this patch does not make such tradeoffs.
> 
> Signed-off-by: Shakeel Butt <shakeelb@google.com>

Somewhat late to the game but our performance testing grid has noticed this
commit causes a performance regression on shell-heavy workloads. For
example running 'make test' in git sources on our test machine with 192
CPUs takes about 4% longer, system time is increased by about 9%:

                       before (9cd6ffa6025)  after (f1a7941243c1)
Amean     User         471.12 *   0.30%*     481.77 *  -1.96%*
Amean     System       244.47 *   0.90%*     269.13 *  -9.09%*
Amean     Elapsed      709.22 *   0.45%*     742.27 *  -4.19%*
Amean     CPU          100.00 (   0.20%)     101.00 *  -0.80%*

Essentially this workload spawns in sequence a lot of short-lived tasks and
the task startup + teardown cost is what this patch increases. To
demonstrate this more clearly, I've written trivial (and somewhat stupid)
benchmark shell_bench.sh:

for (( i = 0; i < 20000; i++ )); do
	/bin/true
done

And when run like:

numactl -C 1 ./shell_bench.sh

(I've forced physical CPU binding to avoid task migrating over the machine
and cpu frequency scaling interfering which makes the numbers much more
noisy) I get the following elapsed times:

         9cd6ffa6025    f1a7941243c1
Avg      6.807429       7.631571
Stddev   0.021797       0.016483

So some 12% regression in elapsed time. Just to be sure I've verified that
per-cpu allocator patch [1] does not improve these numbers in any
significant way.

Where do we go from here? I think in principle the problem could be fixed
by being clever and when the task has only a single thread, we don't bother
with allocating pcpu counter (and summing it at the end) and just account
directly in mm_struct. When the second thread is spawned, we bite the
bullet, allocate pcpu counter and start with more scalable accounting.
These shortlived tasks in shell workloads or similar don't spawn any
threads so this should fix the regression. But this is obviously easier
said than done...

								Honza

[1] https://lore.kernel.org/all/20230606125404.95256-1-yu.ma@intel.com/

> ---
>  include/linux/mm.h             | 26 ++++--------
>  include/linux/mm_types.h       |  7 +---
>  include/linux/mm_types_task.h  | 13 ------
>  include/linux/percpu_counter.h |  1 -
>  include/linux/sched.h          |  3 --
>  include/trace/events/kmem.h    |  8 ++--
>  kernel/fork.c                  | 16 +++++++-
>  mm/memory.c                    | 73 +++++-----------------------------
>  8 files changed, 40 insertions(+), 107 deletions(-)
> 
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 9dec25c7d631..a8a9c3a20534 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -2000,40 +2000,30 @@ static inline bool get_user_page_fast_only(unsigned long addr,
>   */
>  static inline unsigned long get_mm_counter(struct mm_struct *mm, int member)
>  {
> -	long val = atomic_long_read(&mm->rss_stat.count[member]);
> -
> -#ifdef SPLIT_RSS_COUNTING
> -	/*
> -	 * counter is updated in asynchronous manner and may go to minus.
> -	 * But it's never be expected number for users.
> -	 */
> -	if (val < 0)
> -		val = 0;
> -#endif
> -	return (unsigned long)val;
> +	return percpu_counter_read_positive(&mm->rss_stat[member]);
>  }
>  
> -void mm_trace_rss_stat(struct mm_struct *mm, int member, long count);
> +void mm_trace_rss_stat(struct mm_struct *mm, int member);
>  
>  static inline void add_mm_counter(struct mm_struct *mm, int member, long value)
>  {
> -	long count = atomic_long_add_return(value, &mm->rss_stat.count[member]);
> +	percpu_counter_add(&mm->rss_stat[member], value);
>  
> -	mm_trace_rss_stat(mm, member, count);
> +	mm_trace_rss_stat(mm, member);
>  }
>  
>  static inline void inc_mm_counter(struct mm_struct *mm, int member)
>  {
> -	long count = atomic_long_inc_return(&mm->rss_stat.count[member]);
> +	percpu_counter_inc(&mm->rss_stat[member]);
>  
> -	mm_trace_rss_stat(mm, member, count);
> +	mm_trace_rss_stat(mm, member);
>  }
>  
>  static inline void dec_mm_counter(struct mm_struct *mm, int member)
>  {
> -	long count = atomic_long_dec_return(&mm->rss_stat.count[member]);
> +	percpu_counter_dec(&mm->rss_stat[member]);
>  
> -	mm_trace_rss_stat(mm, member, count);
> +	mm_trace_rss_stat(mm, member);
>  }
>  
>  /* Optimized variant when page is already known not to be PageAnon */
> diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
> index a82f06ab18a1..834022721bc6 100644
> --- a/include/linux/mm_types.h
> +++ b/include/linux/mm_types.h
> @@ -18,6 +18,7 @@
>  #include <linux/page-flags-layout.h>
>  #include <linux/workqueue.h>
>  #include <linux/seqlock.h>
> +#include <linux/percpu_counter.h>
>  
>  #include <asm/mmu.h>
>  
> @@ -626,11 +627,7 @@ struct mm_struct {
>  
>  		unsigned long saved_auxv[AT_VECTOR_SIZE]; /* for /proc/PID/auxv */
>  
> -		/*
> -		 * Special counters, in some configurations protected by the
> -		 * page_table_lock, in other configurations by being atomic.
> -		 */
> -		struct mm_rss_stat rss_stat;
> +		struct percpu_counter rss_stat[NR_MM_COUNTERS];
>  
>  		struct linux_binfmt *binfmt;
>  
> diff --git a/include/linux/mm_types_task.h b/include/linux/mm_types_task.h
> index 0bb4b6da9993..5414b5c6a103 100644
> --- a/include/linux/mm_types_task.h
> +++ b/include/linux/mm_types_task.h
> @@ -36,19 +36,6 @@ enum {
>  	NR_MM_COUNTERS
>  };
>  
> -#if USE_SPLIT_PTE_PTLOCKS && defined(CONFIG_MMU)
> -#define SPLIT_RSS_COUNTING
> -/* per-thread cached information, */
> -struct task_rss_stat {
> -	int events;	/* for synchronization threshold */
> -	int count[NR_MM_COUNTERS];
> -};
> -#endif /* USE_SPLIT_PTE_PTLOCKS */
> -
> -struct mm_rss_stat {
> -	atomic_long_t count[NR_MM_COUNTERS];
> -};
> -
>  struct page_frag {
>  	struct page *page;
>  #if (BITS_PER_LONG > 32) || (PAGE_SIZE >= 65536)
> diff --git a/include/linux/percpu_counter.h b/include/linux/percpu_counter.h
> index 8ed5fba6d156..bde6c4c1f405 100644
> --- a/include/linux/percpu_counter.h
> +++ b/include/linux/percpu_counter.h
> @@ -13,7 +13,6 @@
>  #include <linux/threads.h>
>  #include <linux/percpu.h>
>  #include <linux/types.h>
> -#include <linux/gfp.h>
>  
>  /* percpu_counter batch for local add or sub */
>  #define PERCPU_COUNTER_LOCAL_BATCH	INT_MAX
> diff --git a/include/linux/sched.h b/include/linux/sched.h
> index ffb6eb55cd13..079d299fa465 100644
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -870,9 +870,6 @@ struct task_struct {
>  	struct mm_struct		*mm;
>  	struct mm_struct		*active_mm;
>  
> -#ifdef SPLIT_RSS_COUNTING
> -	struct task_rss_stat		rss_stat;
> -#endif
>  	int				exit_state;
>  	int				exit_code;
>  	int				exit_signal;
> diff --git a/include/trace/events/kmem.h b/include/trace/events/kmem.h
> index 243073cfc29d..58688768ef0f 100644
> --- a/include/trace/events/kmem.h
> +++ b/include/trace/events/kmem.h
> @@ -346,10 +346,9 @@ TRACE_MM_PAGES
>  TRACE_EVENT(rss_stat,
>  
>  	TP_PROTO(struct mm_struct *mm,
> -		int member,
> -		long count),
> +		int member),
>  
> -	TP_ARGS(mm, member, count),
> +	TP_ARGS(mm, member),
>  
>  	TP_STRUCT__entry(
>  		__field(unsigned int, mm_id)
> @@ -362,7 +361,8 @@ TRACE_EVENT(rss_stat,
>  		__entry->mm_id = mm_ptr_to_hash(mm);
>  		__entry->curr = !!(current->mm == mm);
>  		__entry->member = member;
> -		__entry->size = (count << PAGE_SHIFT);
> +		__entry->size = (percpu_counter_sum_positive(&mm->rss_stat[member])
> +							    << PAGE_SHIFT);
>  	),
>  
>  	TP_printk("mm_id=%u curr=%d type=%s size=%ldB",
> diff --git a/kernel/fork.c b/kernel/fork.c
> index cfb09ca1b1bc..f56ad06240e1 100644
> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> @@ -756,7 +756,7 @@ static void check_mm(struct mm_struct *mm)
>  			 "Please make sure 'struct resident_page_types[]' is updated as well");
>  
>  	for (i = 0; i < NR_MM_COUNTERS; i++) {
> -		long x = atomic_long_read(&mm->rss_stat.count[i]);
> +		long x = percpu_counter_sum(&mm->rss_stat[i]);
>  
>  		if (unlikely(x))
>  			pr_alert("BUG: Bad rss-counter state mm:%p type:%s val:%ld\n",
> @@ -782,6 +782,8 @@ static void check_mm(struct mm_struct *mm)
>   */
>  void __mmdrop(struct mm_struct *mm)
>  {
> +	int i;
> +
>  	BUG_ON(mm == &init_mm);
>  	WARN_ON_ONCE(mm == current->mm);
>  	WARN_ON_ONCE(mm == current->active_mm);
> @@ -791,6 +793,9 @@ void __mmdrop(struct mm_struct *mm)
>  	check_mm(mm);
>  	put_user_ns(mm->user_ns);
>  	mm_pasid_drop(mm);
> +
> +	for (i = 0; i < NR_MM_COUNTERS; i++)
> +		percpu_counter_destroy(&mm->rss_stat[i]);
>  	free_mm(mm);
>  }
>  EXPORT_SYMBOL_GPL(__mmdrop);
> @@ -1110,6 +1115,8 @@ static void mm_init_uprobes_state(struct mm_struct *mm)
>  static struct mm_struct *mm_init(struct mm_struct *mm, struct task_struct *p,
>  	struct user_namespace *user_ns)
>  {
> +	int i;
> +
>  	mt_init_flags(&mm->mm_mt, MM_MT_FLAGS);
>  	mt_set_external_lock(&mm->mm_mt, &mm->mmap_lock);
>  	atomic_set(&mm->mm_users, 1);
> @@ -1151,10 +1158,17 @@ static struct mm_struct *mm_init(struct mm_struct *mm, struct task_struct *p,
>  	if (init_new_context(p, mm))
>  		goto fail_nocontext;
>  
> +	for (i = 0; i < NR_MM_COUNTERS; i++)
> +		if (percpu_counter_init(&mm->rss_stat[i], 0, GFP_KERNEL_ACCOUNT))
> +			goto fail_pcpu;
> +
>  	mm->user_ns = get_user_ns(user_ns);
>  	lru_gen_init_mm(mm);
>  	return mm;
>  
> +fail_pcpu:
> +	while (i > 0)
> +		percpu_counter_destroy(&mm->rss_stat[--i]);
>  fail_nocontext:
>  	mm_free_pgd(mm);
>  fail_nopgd:
> diff --git a/mm/memory.c b/mm/memory.c
> index 8e72f703ed99..fea8d737e8c0 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -162,58 +162,11 @@ static int __init init_zero_pfn(void)
>  }
>  early_initcall(init_zero_pfn);
>  
> -void mm_trace_rss_stat(struct mm_struct *mm, int member, long count)
> +void mm_trace_rss_stat(struct mm_struct *mm, int member)
>  {
> -	trace_rss_stat(mm, member, count);
> +	trace_rss_stat(mm, member);
>  }
>  
> -#if defined(SPLIT_RSS_COUNTING)
> -
> -void sync_mm_rss(struct mm_struct *mm)
> -{
> -	int i;
> -
> -	for (i = 0; i < NR_MM_COUNTERS; i++) {
> -		if (current->rss_stat.count[i]) {
> -			add_mm_counter(mm, i, current->rss_stat.count[i]);
> -			current->rss_stat.count[i] = 0;
> -		}
> -	}
> -	current->rss_stat.events = 0;
> -}
> -
> -static void add_mm_counter_fast(struct mm_struct *mm, int member, int val)
> -{
> -	struct task_struct *task = current;
> -
> -	if (likely(task->mm == mm))
> -		task->rss_stat.count[member] += val;
> -	else
> -		add_mm_counter(mm, member, val);
> -}
> -#define inc_mm_counter_fast(mm, member) add_mm_counter_fast(mm, member, 1)
> -#define dec_mm_counter_fast(mm, member) add_mm_counter_fast(mm, member, -1)
> -
> -/* sync counter once per 64 page faults */
> -#define TASK_RSS_EVENTS_THRESH	(64)
> -static void check_sync_rss_stat(struct task_struct *task)
> -{
> -	if (unlikely(task != current))
> -		return;
> -	if (unlikely(task->rss_stat.events++ > TASK_RSS_EVENTS_THRESH))
> -		sync_mm_rss(task->mm);
> -}
> -#else /* SPLIT_RSS_COUNTING */
> -
> -#define inc_mm_counter_fast(mm, member) inc_mm_counter(mm, member)
> -#define dec_mm_counter_fast(mm, member) dec_mm_counter(mm, member)
> -
> -static void check_sync_rss_stat(struct task_struct *task)
> -{
> -}
> -
> -#endif /* SPLIT_RSS_COUNTING */
> -
>  /*
>   * Note: this doesn't free the actual pages themselves. That
>   * has been handled earlier when unmapping all the memory regions.
> @@ -1860,7 +1813,7 @@ static int insert_page_into_pte_locked(struct vm_area_struct *vma, pte_t *pte,
>  		return -EBUSY;
>  	/* Ok, finally just insert the thing.. */
>  	get_page(page);
> -	inc_mm_counter_fast(vma->vm_mm, mm_counter_file(page));
> +	inc_mm_counter(vma->vm_mm, mm_counter_file(page));
>  	page_add_file_rmap(page, vma, false);
>  	set_pte_at(vma->vm_mm, addr, pte, mk_pte(page, prot));
>  	return 0;
> @@ -3156,12 +3109,11 @@ static vm_fault_t wp_page_copy(struct vm_fault *vmf)
>  	if (likely(pte_same(*vmf->pte, vmf->orig_pte))) {
>  		if (old_page) {
>  			if (!PageAnon(old_page)) {
> -				dec_mm_counter_fast(mm,
> -						mm_counter_file(old_page));
> -				inc_mm_counter_fast(mm, MM_ANONPAGES);
> +				dec_mm_counter(mm, mm_counter_file(old_page));
> +				inc_mm_counter(mm, MM_ANONPAGES);
>  			}
>  		} else {
> -			inc_mm_counter_fast(mm, MM_ANONPAGES);
> +			inc_mm_counter(mm, MM_ANONPAGES);
>  		}
>  		flush_cache_page(vma, vmf->address, pte_pfn(vmf->orig_pte));
>  		entry = mk_pte(new_page, vma->vm_page_prot);
> @@ -3968,8 +3920,8 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
>  	if (should_try_to_free_swap(folio, vma, vmf->flags))
>  		folio_free_swap(folio);
>  
> -	inc_mm_counter_fast(vma->vm_mm, MM_ANONPAGES);
> -	dec_mm_counter_fast(vma->vm_mm, MM_SWAPENTS);
> +	inc_mm_counter(vma->vm_mm, MM_ANONPAGES);
> +	dec_mm_counter(vma->vm_mm, MM_SWAPENTS);
>  	pte = mk_pte(page, vma->vm_page_prot);
>  
>  	/*
> @@ -4148,7 +4100,7 @@ static vm_fault_t do_anonymous_page(struct vm_fault *vmf)
>  		return handle_userfault(vmf, VM_UFFD_MISSING);
>  	}
>  
> -	inc_mm_counter_fast(vma->vm_mm, MM_ANONPAGES);
> +	inc_mm_counter(vma->vm_mm, MM_ANONPAGES);
>  	page_add_new_anon_rmap(page, vma, vmf->address);
>  	lru_cache_add_inactive_or_unevictable(page, vma);
>  setpte:
> @@ -4338,11 +4290,11 @@ void do_set_pte(struct vm_fault *vmf, struct page *page, unsigned long addr)
>  		entry = pte_mkuffd_wp(pte_wrprotect(entry));
>  	/* copy-on-write page */
>  	if (write && !(vma->vm_flags & VM_SHARED)) {
> -		inc_mm_counter_fast(vma->vm_mm, MM_ANONPAGES);
> +		inc_mm_counter(vma->vm_mm, MM_ANONPAGES);
>  		page_add_new_anon_rmap(page, vma, addr);
>  		lru_cache_add_inactive_or_unevictable(page, vma);
>  	} else {
> -		inc_mm_counter_fast(vma->vm_mm, mm_counter_file(page));
> +		inc_mm_counter(vma->vm_mm, mm_counter_file(page));
>  		page_add_file_rmap(page, vma, false);
>  	}
>  	set_pte_at(vma->vm_mm, addr, vmf->pte, entry);
> @@ -5194,9 +5146,6 @@ vm_fault_t handle_mm_fault(struct vm_area_struct *vma, unsigned long address,
>  	count_vm_event(PGFAULT);
>  	count_memcg_event_mm(vma->vm_mm, PGFAULT);
>  
> -	/* do counter updates before entering really critical section. */
> -	check_sync_rss_stat(current);
> -
>  	if (!arch_vma_access_permitted(vma, flags & FAULT_FLAG_WRITE,
>  					    flags & FAULT_FLAG_INSTRUCTION,
>  					    flags & FAULT_FLAG_REMOTE))
> -- 
> 2.38.0.135.g90850a2211-goog
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
