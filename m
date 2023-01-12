Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7345667ACE
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 17:29:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235762AbjALQ3d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 11:29:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240087AbjALQ2r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 11:28:47 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 938F8647F
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 08:27:27 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 91B753F815;
        Thu, 12 Jan 2023 16:27:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1673540845; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CoFdIiaCdJPZ37/eD6kvPHPCYmjfaHPnsw8Xt6ZE5SM=;
        b=xEk3xo63Lt4BHr9jhe8bqSG1/x7gzUDcbXGkGYPrGhMnIeCKNITekDg1PYjlSBdCnZ23ol
        fmc0Mp4dmpij0WSlNZEEZ664h/PgK+MKcfLyTaT/fnLcrxRLLhNUUexzXYZwh1yFTvIkjF
        /xFqDK/sAxldgYGTDQ9oRV8bSLE+0zo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1673540845;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CoFdIiaCdJPZ37/eD6kvPHPCYmjfaHPnsw8Xt6ZE5SM=;
        b=mMVEpGS4IBY+0DwRxrMN4mhAuFI1wyJ5siXlzkOS2ncEKSMzN/ocpHCcp/Zsv2YQOp2aas
        JgulQEmUEGIoKrAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 49D4C13585;
        Thu, 12 Jan 2023 16:27:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id f0w7Ee00wGNpRAAAMHmgww
        (envelope-from <vbabka@suse.cz>); Thu, 12 Jan 2023 16:27:25 +0000
Message-ID: <15fda061-72d9-2ee9-0e9f-6f0f732a7382@suse.cz>
Date:   Thu, 12 Jan 2023 17:27:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [RFC v3 2/4] mm: move PG_slab flag to page_type
Content-Language: en-US
To:     Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <roman.gushchin@linux.dev>
Cc:     =?UTF-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPoyDnm7TkuZ8p?= 
        <naoya.horiguchi@nec.com>, Joe Perches <joe@perches.com>,
        Petr Mladek <pmladek@suse.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Matthew WilCox <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>
References: <20221218101901.373450-1-42.hyeyoo@gmail.com>
 <20221218101901.373450-3-42.hyeyoo@gmail.com>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20221218101901.373450-3-42.hyeyoo@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_SOFTFAIL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/18/22 11:18, Hyeonggon Yoo wrote:
> For now, only SLAB uses _mapcount field as a number of active objects in
> a slab, and other slab allocators do not. As 16 bits are enough for that,
> use remaining 16 bits of _mapcount as page_type even when SLAB is used.
> And then move PG_slab flag to page_type.
> 
> As suggested by Matthew, store number of active objects in negative
> form and use helper when accessing or modifying it.
> 
> page_type is always placed in upper half of _mapcount to avoid
> confusing normal _mapcount as page_type. As underflow (actually I mean,
> yeah, overflow) is not a concern anymore, use more lower bits.
> 
> Add more folio helpers for PAGE_TYPE_OPS() not to break existing
> slab implementations. To preserve current behavior apply page policy
> in PAGE_TYPE_OPS() and use PF_NO_TAIL for slab pages and PF_ANY for others.
> 
> Remove PG_slab check from PAGE_FLAGS_CHECK_AT_FREE. buddy will still
> check if _mapcount is properly set at free.
> 
> Note that with this change, page_mapped() and folio_mapped() always return
> false for a slab page.
> 
> Signed-off-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>

Seems like quite some changes to page_type to accomodate SLAB, which is
hopefully going away soon(TM). Could we perhaps avoid that?

- Alternative 1: convert only SLUB for now, let SLAB keep using PG_slab
until it's gone.

- Alternative 2: SLAB's s_mem field seems wasteful to be a full blown
pointer, it could share the word with "active" if it was an offset from
page_addr(), see how it's normally set up:

void *addr = slab_address(slab);
slab->s_mem = addr + colour_off;

so basically we would store the colour_off and perform this calculation
on-demand.

One caveat is KFENCE's kfence_guarded_alloc() which seems to be creating
some fake slab? And setting s_mem to something that maybe isn't an offset up
to 16 bits from slab_address(). That has to be investigated. Worst case,
SLAB is going away soon(TM) so it's fine if KFENCE only works with SLUB?

> ---
>  fs/proc/page.c                 | 13 ++----
>  include/linux/mm_types.h       | 11 +++--
>  include/linux/page-flags.h     | 77 ++++++++++++++++++++++++----------
>  include/trace/events/mmflags.h |  1 -
>  kernel/crash_core.c            |  3 +-
>  mm/slab.c                      | 44 ++++++++++++-------
>  mm/slab.h                      |  3 +-
>  7 files changed, 98 insertions(+), 54 deletions(-)
> 
> diff --git a/fs/proc/page.c b/fs/proc/page.c
> index 6249c347809a..e7524f21cefe 100644
> --- a/fs/proc/page.c
> +++ b/fs/proc/page.c
> @@ -67,7 +67,7 @@ static ssize_t kpagecount_read(struct file *file, char __user *buf,
>  		 */
>  		ppage = pfn_to_online_page(pfn);
>  
> -		if (!ppage || PageSlab(ppage) || page_has_type(ppage))
> +		if (!ppage || page_has_type(ppage))
>  			pcount = 0;
>  		else
>  			pcount = page_mapcount(ppage);
> @@ -124,11 +124,8 @@ u64 stable_page_flags(struct page *page)
>  
>  	/*
>  	 * pseudo flags for the well known (anonymous) memory mapped pages
> -	 *
> -	 * Note that page->_mapcount is overloaded in SLOB/SLUB/SLQB, so the
> -	 * simple test in page_mapped() is not enough.
>  	 */
> -	if (!PageSlab(page) && page_mapped(page))
> +	if (page_mapped(page))
>  		u |= 1 << KPF_MMAP;
>  	if (PageAnon(page))
>  		u |= 1 << KPF_ANON;
> @@ -178,16 +175,14 @@ u64 stable_page_flags(struct page *page)
>  		u |= 1 << KPF_OFFLINE;
>  	if (PageTable(page))
>  		u |= 1 << KPF_PGTABLE;
> +	if (PageSlab(page))
> +		u |= 1 << KPF_SLAB;
>  
>  	if (page_is_idle(page))
>  		u |= 1 << KPF_IDLE;
>  
>  	u |= kpf_copy_bit(k, KPF_LOCKED,	PG_locked);
>  
> -	u |= kpf_copy_bit(k, KPF_SLAB,		PG_slab);
> -	if (PageTail(page) && PageSlab(compound_head(page)))
> -		u |= 1 << KPF_SLAB;
> -
>  	u |= kpf_copy_bit(k, KPF_ERROR,		PG_error);
>  	u |= kpf_copy_bit(k, KPF_DIRTY,		PG_dirty);
>  	u |= kpf_copy_bit(k, KPF_UPTODATE,	PG_uptodate);
> diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
> index 3b8475007734..6b04ae65241d 100644
> --- a/include/linux/mm_types.h
> +++ b/include/linux/mm_types.h
> @@ -207,10 +207,13 @@ struct page {
>  		atomic_t _mapcount;
>  
>  		/*
> -		 * If the page is neither PageSlab nor mappable to userspace,
> -		 * the value stored here may help determine what this page
> -		 * is used for.  See page-flags.h for a list of page types
> -		 * which are currently stored here.
> +		 * If the page is not mappable to userspace, the value
> +		 * stored here may help determine what this page is used for.
> +		 * See page-flags.h for a list of page types which are currently
> +		 * stored here.
> +		 *
> +		 * Note that only upper half is used for page types and lower
> +		 * half is reserved for SLAB.
>  		 */
>  		unsigned int page_type;
>  	};
> diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
> index 69e93a0c1277..07063d60efe3 100644
> --- a/include/linux/page-flags.h
> +++ b/include/linux/page-flags.h
> @@ -107,7 +107,6 @@ enum pageflags {
>  	PG_workingset,
>  	PG_waiters,		/* Page has waiters, check its waitqueue. Must be bit #7 and in the same byte as "PG_locked" */
>  	PG_error,
> -	PG_slab,
>  	PG_owner_priv_1,	/* Owner use. If pagecache, fs may use*/
>  	PG_arch_1,
>  	PG_reserved,
> @@ -482,7 +481,6 @@ PAGEFLAG(Active, active, PF_HEAD) __CLEARPAGEFLAG(Active, active, PF_HEAD)
>  	TESTCLEARFLAG(Active, active, PF_HEAD)
>  PAGEFLAG(Workingset, workingset, PF_HEAD)
>  	TESTCLEARFLAG(Workingset, workingset, PF_HEAD)
> -__PAGEFLAG(Slab, slab, PF_NO_TAIL)
>  __PAGEFLAG(SlobFree, slob_free, PF_NO_TAIL)
>  PAGEFLAG(Checked, checked, PF_NO_COMPOUND)	   /* Used by some filesystems */
>  
> @@ -906,42 +904,72 @@ static inline bool is_page_hwpoison(struct page *page)
>  }
>  
>  /*
> - * For pages that are never mapped to userspace (and aren't PageSlab),
> - * page_type may be used.  Because it is initialised to -1, we invert the
> - * sense of the bit, so __SetPageFoo *clears* the bit used for PageFoo, and
> - * __ClearPageFoo *sets* the bit used for PageFoo.  We reserve a few high and
> - * low bits so that an underflow or overflow of page_mapcount() won't be
> - * mistaken for a page type value.
> + * For pages that are never mapped to userspace, page_type may be used.
> + * Because it is initialised to -1, we invert the sense of the bit,
> + * so __SetPageFoo *clears* the bit used for PageFoo, and __ClearPageFoo
> + * *sets* the bit used for PageFoo.  We reserve a few high and low bits
> + * so that an underflow or overflow of page_mapcount() won't be mistaken
> + * for a page type value.
>   */
>  
>  #define PAGE_TYPE_BASE	0xf0000000
> -/* Reserve		0x0000007f to catch underflows of page_mapcount */
> -#define PAGE_MAPCOUNT_RESERVE	-128
> -#define PG_buddy	0x00000080
> -#define PG_offline	0x00000100
> -#define PG_table	0x00000200
> -#define PG_guard	0x00000400
> +#define PG_buddy	0x00010000
> +#define PG_offline	0x00020000
> +#define PG_table	0x00040000
> +#define PG_guard	0x00080000
> +#define PG_slab		0x00100000
>  
>  #define PageType(page, flag)						\
>  	((page->page_type & (PAGE_TYPE_BASE | flag)) == PAGE_TYPE_BASE)
>  
> -static inline int page_has_type(struct page *page)
> +#define PAGE_TYPE_MASK	0xffff0000
> +
> +static inline bool page_type_has_type(unsigned int page_type)
>  {
> -	return (int)page->page_type < PAGE_MAPCOUNT_RESERVE;
> +	return ((int)page_type < (int)PAGE_TYPE_MASK);
>  }
>  
> -#define PAGE_TYPE_OPS(uname, lname)					\
> +static inline bool page_has_type(struct page *page)
> +{
> +	return page_type_has_type(page->page_type);
> +}
> +
> +
> +#define PAGE_TYPE_OPS(uname, lname, policy)				\
>  static __always_inline int Page##uname(struct page *page)		\
>  {									\
> +	page = policy(page, 0);						\
> +	return PageType(page, PG_##lname);				\
> +}									\
> +static __always_inline int folio_test_##lname(struct folio *folio)	\
> +{									\
> +	struct page *page = &folio->page;				\
> +									\
>  	return PageType(page, PG_##lname);				\
>  }									\
>  static __always_inline void __SetPage##uname(struct page *page)		\
>  {									\
> +	page = policy(page, 1);						\
> +	VM_BUG_ON_PAGE(!PageType(page, 0), page);			\
> +	page->page_type &= ~PG_##lname;					\
> +}									\
> +static __always_inline void __folio_set_##lname(struct folio *folio)	\
> +{									\
> +	struct page *page = &folio->page;				\
> +									\
>  	VM_BUG_ON_PAGE(!PageType(page, 0), page);			\
>  	page->page_type &= ~PG_##lname;					\
>  }									\
>  static __always_inline void __ClearPage##uname(struct page *page)	\
>  {									\
> +	page = policy(page, 1);						\
> +	VM_BUG_ON_PAGE(!Page##uname(page), page);			\
> +	page->page_type |= PG_##lname;					\
> +}									\
> +static __always_inline void __folio_clear_##lname(struct folio *folio)	\
> +{									\
> +	struct page *page = &folio->page;				\
> +									\
>  	VM_BUG_ON_PAGE(!Page##uname(page), page);			\
>  	page->page_type |= PG_##lname;					\
>  }
> @@ -950,7 +978,7 @@ static __always_inline void __ClearPage##uname(struct page *page)	\
>   * PageBuddy() indicates that the page is free and in the buddy system
>   * (see mm/page_alloc.c).
>   */
> -PAGE_TYPE_OPS(Buddy, buddy)
> +PAGE_TYPE_OPS(Buddy, buddy, PF_ANY)
>  
>  /*
>   * PageOffline() indicates that the page is logically offline although the
> @@ -974,7 +1002,10 @@ PAGE_TYPE_OPS(Buddy, buddy)
>   * pages should check PageOffline() and synchronize with such drivers using
>   * page_offline_freeze()/page_offline_thaw().
>   */
> -PAGE_TYPE_OPS(Offline, offline)
> +PAGE_TYPE_OPS(Offline, offline, PF_ANY)
> +
> +/* PageSlab() indicates that the page is used by slab subsystem. */
> +PAGE_TYPE_OPS(Slab, slab, PF_NO_TAIL)
>  
>  extern void page_offline_freeze(void);
>  extern void page_offline_thaw(void);
> @@ -984,12 +1015,12 @@ extern void page_offline_end(void);
>  /*
>   * Marks pages in use as page tables.
>   */
> -PAGE_TYPE_OPS(Table, table)
> +PAGE_TYPE_OPS(Table, table, PF_ANY)
>  
>  /*
>   * Marks guardpages used with debug_pagealloc.
>   */
> -PAGE_TYPE_OPS(Guard, guard)
> +PAGE_TYPE_OPS(Guard, guard, PF_ANY)
>  
>  extern bool is_free_buddy_page(struct page *page);
>  
> @@ -1037,8 +1068,8 @@ static __always_inline void __ClearPageAnonExclusive(struct page *page)
>  	(1UL << PG_lru		| 1UL << PG_locked	|	\
>  	 1UL << PG_private	| 1UL << PG_private_2	|	\
>  	 1UL << PG_writeback	| 1UL << PG_reserved	|	\
> -	 1UL << PG_slab		| 1UL << PG_active 	|	\
> -	 1UL << PG_unevictable	| __PG_MLOCKED | LRU_GEN_MASK)
> +	 1UL << PG_active 	| 1UL << PG_unevictable |	\
> +	 __PG_MLOCKED | LRU_GEN_MASK)
>  
>  /*
>   * Flags checked when a page is prepped for return by the page allocator.
> diff --git a/include/trace/events/mmflags.h b/include/trace/events/mmflags.h
> index 412b5a46374c..8301912f8c25 100644
> --- a/include/trace/events/mmflags.h
> +++ b/include/trace/events/mmflags.h
> @@ -113,7 +113,6 @@
>  	{1UL << PG_lru,			"lru"		},		\
>  	{1UL << PG_active,		"active"	},		\
>  	{1UL << PG_workingset,		"workingset"	},		\
> -	{1UL << PG_slab,		"slab"		},		\
>  	{1UL << PG_owner_priv_1,	"owner_priv_1"	},		\
>  	{1UL << PG_arch_1,		"arch_1"	},		\
>  	{1UL << PG_reserved,		"reserved"	},		\
> diff --git a/kernel/crash_core.c b/kernel/crash_core.c
> index 87ef6096823f..1ea8198c26e1 100644
> --- a/kernel/crash_core.c
> +++ b/kernel/crash_core.c
> @@ -482,13 +482,14 @@ static int __init crash_save_vmcoreinfo_init(void)
>  	VMCOREINFO_NUMBER(PG_private);
>  	VMCOREINFO_NUMBER(PG_swapcache);
>  	VMCOREINFO_NUMBER(PG_swapbacked);
> -	VMCOREINFO_NUMBER(PG_slab);
>  #ifdef CONFIG_MEMORY_FAILURE
>  	VMCOREINFO_NUMBER(PG_hwpoison);
>  #endif
>  	VMCOREINFO_NUMBER(PG_head_mask);
>  #define PAGE_BUDDY_MAPCOUNT_VALUE	(~PG_buddy)
>  	VMCOREINFO_NUMBER(PAGE_BUDDY_MAPCOUNT_VALUE);
> +#define PAGE_SLAB_MAPCOUNT_VALUE	(~PG_slab)
> +	VMCOREINFO_NUMBER(PAGE_SLAB_MAPCOUNT_VALUE);
>  #ifdef CONFIG_HUGETLB_PAGE
>  	VMCOREINFO_NUMBER(HUGETLB_PAGE_DTOR);
>  #define PAGE_OFFLINE_MAPCOUNT_VALUE	(~PG_offline)
> diff --git a/mm/slab.c b/mm/slab.c
> index 7a269db050ee..eee46f71c4b8 100644
> --- a/mm/slab.c
> +++ b/mm/slab.c
> @@ -2269,6 +2269,21 @@ void __kmem_cache_release(struct kmem_cache *cachep)
>  	}
>  }
>  
> +static inline unsigned int slab_get_active(struct slab *slab)
> +{
> +	return ~(slab->page_type | PG_slab);
> +}
> +
> +static inline void slab_inc_active(struct slab *slab)
> +{
> +	slab->page_type--;
> +}
> +
> +static inline void slab_dec_active(struct slab *slab)
> +{
> +	slab->page_type++;
> +}
> +
>  /*
>   * Get the memory for a slab management obj.
>   *
> @@ -2291,7 +2306,6 @@ static void *alloc_slabmgmt(struct kmem_cache *cachep,
>  	void *addr = slab_address(slab);
>  
>  	slab->s_mem = addr + colour_off;
> -	slab->active = 0;
>  
>  	if (OBJFREELIST_SLAB(cachep))
>  		freelist = NULL;
> @@ -2510,8 +2524,8 @@ static void *slab_get_obj(struct kmem_cache *cachep, struct slab *slab)
>  {
>  	void *objp;
>  
> -	objp = index_to_obj(cachep, slab, get_free_obj(slab, slab->active));
> -	slab->active++;
> +	objp = index_to_obj(cachep, slab, get_free_obj(slab, slab_get_active(slab)));
> +	slab_inc_active(slab);
>  
>  	return objp;
>  }
> @@ -2524,7 +2538,7 @@ static void slab_put_obj(struct kmem_cache *cachep,
>  	unsigned int i;
>  
>  	/* Verify double free bug */
> -	for (i = slab->active; i < cachep->num; i++) {
> +	for (i = slab_get_active(slab); i < cachep->num; i++) {
>  		if (get_free_obj(slab, i) == objnr) {
>  			pr_err("slab: double free detected in cache '%s', objp %px\n",
>  			       cachep->name, objp);
> @@ -2532,11 +2546,11 @@ static void slab_put_obj(struct kmem_cache *cachep,
>  		}
>  	}
>  #endif
> -	slab->active--;
> +	slab_dec_active(slab);
>  	if (!slab->freelist)
>  		slab->freelist = objp + obj_offset(cachep);
>  
> -	set_free_obj(slab, slab->active, objnr);
> +	set_free_obj(slab, slab_get_active(slab), objnr);
>  }
>  
>  /*
> @@ -2635,14 +2649,14 @@ static void cache_grow_end(struct kmem_cache *cachep, struct slab *slab)
>  
>  	raw_spin_lock(&n->list_lock);
>  	n->total_slabs++;
> -	if (!slab->active) {
> +	if (!slab_get_active(slab)) {
>  		list_add_tail(&slab->slab_list, &n->slabs_free);
>  		n->free_slabs++;
>  	} else
>  		fixup_slab_list(cachep, n, slab, &list);
>  
>  	STATS_INC_GROWN(cachep);
> -	n->free_objects += cachep->num - slab->active;
> +	n->free_objects += cachep->num - slab_get_active(slab);
>  	raw_spin_unlock(&n->list_lock);
>  
>  	fixup_objfreelist_debug(cachep, &list);
> @@ -2744,7 +2758,7 @@ static inline void fixup_slab_list(struct kmem_cache *cachep,
>  {
>  	/* move slabp to correct slabp list: */
>  	list_del(&slab->slab_list);
> -	if (slab->active == cachep->num) {
> +	if (slab_get_active(slab) == cachep->num) {
>  		list_add(&slab->slab_list, &n->slabs_full);
>  		if (OBJFREELIST_SLAB(cachep)) {
>  #if DEBUG
> @@ -2783,7 +2797,7 @@ static noinline struct slab *get_valid_first_slab(struct kmem_cache_node *n,
>  
>  	/* Move pfmemalloc slab to the end of list to speed up next search */
>  	list_del(&slab->slab_list);
> -	if (!slab->active) {
> +	if (!slab_get_active(slab)) {
>  		list_add_tail(&slab->slab_list, &n->slabs_free);
>  		n->free_slabs++;
>  	} else
> @@ -2865,9 +2879,9 @@ static __always_inline int alloc_block(struct kmem_cache *cachep,
>  	 * There must be at least one object available for
>  	 * allocation.
>  	 */
> -	BUG_ON(slab->active >= cachep->num);
> +	BUG_ON(slab_get_active(slab) >= cachep->num);
>  
> -	while (slab->active < cachep->num && batchcount--) {
> +	while (slab_get_active(slab) < cachep->num && batchcount--) {
>  		STATS_INC_ALLOCED(cachep);
>  		STATS_INC_ACTIVE(cachep);
>  		STATS_SET_HIGH(cachep);
> @@ -3162,7 +3176,7 @@ static void *____cache_alloc_node(struct kmem_cache *cachep, gfp_t flags,
>  	STATS_INC_ACTIVE(cachep);
>  	STATS_SET_HIGH(cachep);
>  
> -	BUG_ON(slab->active == cachep->num);
> +	BUG_ON(slab_get_active(slab) == cachep->num);
>  
>  	obj = slab_get_obj(cachep, slab);
>  	n->free_objects--;
> @@ -3297,7 +3311,7 @@ static void free_block(struct kmem_cache *cachep, void **objpp,
>  		STATS_DEC_ACTIVE(cachep);
>  
>  		/* fixup slab chains */
> -		if (slab->active == 0) {
> +		if (slab_get_active(slab) == 0) {
>  			list_add(&slab->slab_list, &n->slabs_free);
>  			n->free_slabs++;
>  		} else {
> @@ -3352,7 +3366,7 @@ static void cache_flusharray(struct kmem_cache *cachep, struct array_cache *ac)
>  		struct slab *slab;
>  
>  		list_for_each_entry(slab, &n->slabs_free, slab_list) {
> -			BUG_ON(slab->active);
> +			BUG_ON(slab_get_active(slab));
>  
>  			i++;
>  		}
> diff --git a/mm/slab.h b/mm/slab.h
> index 7cc432969945..c6ffe6799436 100644
> --- a/mm/slab.h
> +++ b/mm/slab.h
> @@ -20,7 +20,8 @@ struct slab {
>  		};
>  		struct rcu_head rcu_head;
>  	};
> -	unsigned int active;
> +	/* lower half of page_type is used as active objects counter */
> +	unsigned int page_type;
>  
>  #elif defined(CONFIG_SLUB)
>  

