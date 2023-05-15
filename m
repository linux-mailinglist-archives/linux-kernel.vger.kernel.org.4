Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CF92704171
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 01:40:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343575AbjEOXkM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 19:40:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245395AbjEOXkJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 19:40:09 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF9286A7C
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 16:40:07 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1aae90f5ebcso755685ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 16:40:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684194007; x=1686786007;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OVvfLhysB+0iy4Qip8pj9vBPM/PIR3p9BpZ5jtYRcn4=;
        b=oBqogYyzknr4yKRxw88qq274R/foRD0iU/4HpnVOmOYsJgB4y5e/onJdHb/QjS00Ed
         3Oz/6ggqipp+vbvqqyTlo1tQwx1kMcflJJiXMvfznOaemX9PTVS3ByDZYXsO8B3ksLSq
         K+SAlJQ/OtK/9aukf6yJMaDdbGwQU4fdViCLeVkzX/FppvxiLP4wSN7uUSFeQJr3Z1px
         ATNgFB5RUw9/DrL0w71804OatLnEKT5KVKQAG/AmmN6WkOOzxsj02txLLBVvt8AdYefl
         sGIk+rEemv4t/FX6klsq7LCxyCh4RfJkGSsJp3CQh4wlg/cyV3A3/pEXzqC9H7JEuWAS
         gPtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684194007; x=1686786007;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OVvfLhysB+0iy4Qip8pj9vBPM/PIR3p9BpZ5jtYRcn4=;
        b=a6zWG+Wydz0gdEeEpCs2K3Tki2R19W5hesh3Zpux9Q5MwKNWHc6gj1uHaMNAm3Tz+Q
         LTl77456foyRMbU9NORRPmNwlkdwy2WuKZkqbuPYVsZ061Gg2HW5aI21ZweUSCJ5SP+T
         fQh3iTrPESux+3c6yBq5/Nt92NXwBz4uGe3nYwsQBst7ft4ENtAuD+55IKXJ6qdaFBgG
         L0VOvXYHXxIzuJwtoHCWagAaMosqxX/34J6aJMNbQXFi0DdtAjg/9bOOxSOsAsssps/T
         d7HS9U8kTMaZp/LFOGI6RCofbxt4ZqeEUAnc0L8xfl+5knNJLpbLIvVS5ebl7pMw2VLr
         /DhQ==
X-Gm-Message-State: AC+VfDyCBFRvY7DL1/iU0V7G0ERWT2xN57Xo5ylvvPYPY7YyNycYOy6G
        NpG3xT8e4GefiprRp5HTHXXTkA==
X-Google-Smtp-Source: ACHHUZ4vbTiXqAKlKE7aAVYgqKytq/j0IcMhHUt5I1ncbJwmtNoHqSAS9l5md56bjM7O5Ol8rpfclQ==
X-Received: by 2002:a17:902:ec85:b0:1a6:970f:8572 with SMTP id x5-20020a170902ec8500b001a6970f8572mr17131plg.3.1684194006948;
        Mon, 15 May 2023 16:40:06 -0700 (PDT)
Received: from google.com ([2620:15c:2d3:205:c825:9c0b:b4be:8ee4])
        by smtp.gmail.com with ESMTPSA id d6-20020aa78686000000b00640ddad2e0dsm12303707pfo.47.2023.05.15.16.40.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 May 2023 16:40:06 -0700 (PDT)
Date:   Mon, 15 May 2023 16:40:01 -0700
From:   Peter Collingbourne <pcc@google.com>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     David Hildenbrand <david@redhat.com>,
        Qun-wei Lin =?utf-8?B?KOael+e+pOW0tCk=?= 
        <Qun-wei.Lin@mediatek.com>, linux-arm-kernel@lists.infradead.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        "surenb@google.com" <surenb@google.com>,
        Chinwen Chang =?utf-8?B?KOW8temMpuaWhyk=?= 
        <chinwen.chang@mediatek.com>,
        "kasan-dev@googlegroups.com" <kasan-dev@googlegroups.com>,
        Kuan-Ying Lee =?utf-8?B?KOadjuWGoOepjik=?= 
        <Kuan-Ying.Lee@mediatek.com>,
        Casper Li =?utf-8?B?KOadjuS4reamrik=?= <casper.li@mediatek.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        vincenzo.frascino@arm.com,
        Alexandru Elisei <alexandru.elisei@arm.com>, will@kernel.org,
        eugenis@google.com, Steven Price <steven.price@arm.com>,
        stable@vger.kernel.org
Subject: Re: [PATCH 1/3] mm: Move arch_do_swap_page() call to before
 swap_free()
Message-ID: <ZGLC0T32sgVkG5kX@google.com>
References: <20230512235755.1589034-1-pcc@google.com>
 <20230512235755.1589034-2-pcc@google.com>
 <7471013e-4afb-e445-5985-2441155fc82c@redhat.com>
 <ZGJtJobLrBg3PtHm@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZGJtJobLrBg3PtHm@arm.com>
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

On Mon, May 15, 2023 at 06:34:30PM +0100, Catalin Marinas wrote:
> On Sat, May 13, 2023 at 05:29:53AM +0200, David Hildenbrand wrote:
> > On 13.05.23 01:57, Peter Collingbourne wrote:
> > > diff --git a/mm/memory.c b/mm/memory.c
> > > index 01a23ad48a04..83268d287ff1 100644
> > > --- a/mm/memory.c
> > > +++ b/mm/memory.c
> > > @@ -3914,19 +3914,7 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
> > >   		}
> > >   	}
> > > -	/*
> > > -	 * Remove the swap entry and conditionally try to free up the swapcache.
> > > -	 * We're already holding a reference on the page but haven't mapped it
> > > -	 * yet.
> > > -	 */
> > > -	swap_free(entry);
> > > -	if (should_try_to_free_swap(folio, vma, vmf->flags))
> > > -		folio_free_swap(folio);
> > > -
> > > -	inc_mm_counter(vma->vm_mm, MM_ANONPAGES);
> > > -	dec_mm_counter(vma->vm_mm, MM_SWAPENTS);
> > >   	pte = mk_pte(page, vma->vm_page_prot);
> > > -
> > >   	/*
> > >   	 * Same logic as in do_wp_page(); however, optimize for pages that are
> > >   	 * certainly not shared either because we just allocated them without
> > > @@ -3946,8 +3934,21 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
> > >   		pte = pte_mksoft_dirty(pte);
> > >   	if (pte_swp_uffd_wp(vmf->orig_pte))
> > >   		pte = pte_mkuffd_wp(pte);
> > > +	arch_do_swap_page(vma->vm_mm, vma, vmf->address, pte, vmf->orig_pte);
> > >   	vmf->orig_pte = pte;
> > > +	/*
> > > +	 * Remove the swap entry and conditionally try to free up the swapcache.
> > > +	 * We're already holding a reference on the page but haven't mapped it
> > > +	 * yet.
> > > +	 */
> > > +	swap_free(entry);
> > > +	if (should_try_to_free_swap(folio, vma, vmf->flags))
> > > +		folio_free_swap(folio);
> > > +
> > > +	inc_mm_counter(vma->vm_mm, MM_ANONPAGES);
> > > +	dec_mm_counter(vma->vm_mm, MM_SWAPENTS);
> > > +
> > >   	/* ksm created a completely new copy */
> > >   	if (unlikely(folio != swapcache && swapcache)) {
> > >   		page_add_new_anon_rmap(page, vma, vmf->address);
> > > @@ -3959,7 +3960,6 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
> > >   	VM_BUG_ON(!folio_test_anon(folio) ||
> > >   			(pte_write(pte) && !PageAnonExclusive(page)));
> > >   	set_pte_at(vma->vm_mm, vmf->address, vmf->pte, pte);
> > > -	arch_do_swap_page(vma->vm_mm, vma, vmf->address, pte, vmf->orig_pte);
> > >   	folio_unlock(folio);
> > >   	if (folio != swapcache && swapcache) {
> > 
> > 
> > You are moving the folio_free_swap() call after the folio_ref_count(folio)
> > == 1 check, which means that such (previously) swapped pages that are
> > exclusive cannot be detected as exclusive.
> > 
> > There must be a better way to handle MTE here.
> > 
> > Where are the tags stored, how is the location identified, and when are they
> > effectively restored right now?
> 
> I haven't gone through Peter's patches yet but a pretty good description
> of the problem is here:
> https://lore.kernel.org/all/5050805753ac469e8d727c797c2218a9d780d434.camel@mediatek.com/.
> I couldn't reproduce it with my swap setup but both Qun-wei and Peter
> triggered it.

In order to reproduce this bug it is necessary for the swap slot cache
to be disabled, which is unlikely to occur during normal operation. I
was only able to reproduce the bug by disabling it forcefully with the
following patch:

diff --git a/mm/swap_slots.c b/mm/swap_slots.c
index 0bec1f705f8e0..25afba16980c7 100644
--- a/mm/swap_slots.c
+++ b/mm/swap_slots.c
@@ -79,7 +79,7 @@ void disable_swap_slots_cache_lock(void)
 
 static void __reenable_swap_slots_cache(void)
 {
-	swap_slot_cache_enabled = has_usable_swap();
+	swap_slot_cache_enabled = false;
 }
 
 void reenable_swap_slots_cache_unlock(void)

With that I can trigger the bug on an MTE-utilizing process by running
a program that enumerates the process's private anonymous mappings and
calls process_madvise(MADV_PAGEOUT) on all of them.

> When a tagged page is swapped out, the arm64 code stores the metadata
> (tags) in a local xarray indexed by the swap pte. When restoring from
> swap, the arm64 set_pte_at() checks this xarray using the old swap pte
> and spills the tags onto the new page. Apparently something changed in
> the kernel recently that causes swap_range_free() to be called before
> set_pte_at(). The arm64 arch_swap_invalidate_page() frees the metadata
> from the xarray and the subsequent set_pte_at() won't find it.
> 
> If we have the page, the metadata can be restored before set_pte_at()
> and I guess that's what Peter is trying to do (again, I haven't looked
> at the details yet; leaving it for tomorrow).
> 
> Is there any other way of handling this? E.g. not release the metadata
> in arch_swap_invalidate_page() but later in set_pte_at() once it was
> restored. But then we may leak this metadata if there's no set_pte_at()
> (the process mapping the swap entry died).

Another problem that I can see with this approach is that it does not
respect reference counts for swap entries, and it's unclear whether that
can be done in a non-racy fashion.

Another approach that I considered was to move the hook to swap_readpage()
as in the patch below (sorry, it only applies to an older version
of Android's android14-6.1 branch and not mainline, but you get the
idea). But during a stress test (running the aforementioned program that
calls process_madvise(MADV_PAGEOUT) in a loop during an Android "monkey"
test) I discovered the following racy use-after-free that can occur when
two tasks T1 and T2 concurrently restore the same page:

T1:                  | T2:
arch_swap_readpage() |
                     | arch_swap_readpage() -> mte_restore_tags() -> xe_load()
swap_free()          |
                     | arch_swap_readpage() -> mte_restore_tags() -> mte_restore_page_tags()

We can avoid it by taking the swap_info_struct::lock spinlock in
mte_restore_tags(), but it seems like it would lead to lock contention.

Peter

diff --git a/arch/arm64/include/asm/mte.h b/arch/arm64/include/asm/mte.h
index 3f8199ba265a1..99c8be073f107 100644
--- a/arch/arm64/include/asm/mte.h
+++ b/arch/arm64/include/asm/mte.h
@@ -25,7 +25,7 @@ unsigned long mte_copy_tags_to_user(void __user *to, void *from,
 				    unsigned long n);
 int mte_save_tags(struct page *page);
 void mte_save_page_tags(const void *page_addr, void *tag_storage);
-bool mte_restore_tags(swp_entry_t entry, struct page *page);
+void mte_restore_tags(struct page *page);
 void mte_restore_page_tags(void *page_addr, const void *tag_storage);
 void mte_invalidate_tags(int type, pgoff_t offset);
 void mte_invalidate_tags_area(int type);
diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index 812373cff4eec..32d3c661a0eee 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -1054,11 +1054,11 @@ static inline void arch_swap_invalidate_area(int type)
 		mte_invalidate_tags_area(type);
 }
 
-#define __HAVE_ARCH_SWAP_RESTORE
-static inline void arch_swap_restore(swp_entry_t entry, struct folio *folio)
+#define __HAVE_ARCH_SWAP_READPAGE
+static inline void arch_swap_readpage(struct page *page)
 {
-	if (system_supports_mte() && mte_restore_tags(entry, &folio->page))
-		set_page_mte_tagged(&folio->page);
+	if (system_supports_mte())
+  		mte_restore_tags(page);
 }
 
 #endif /* CONFIG_ARM64_MTE */
diff --git a/arch/arm64/kernel/mte.c b/arch/arm64/kernel/mte.c
index 84a085d536f84..176f094ecaa1e 100644
--- a/arch/arm64/kernel/mte.c
+++ b/arch/arm64/kernel/mte.c
@@ -38,15 +38,6 @@ EXPORT_SYMBOL_GPL(mte_async_or_asymm_mode);
 static void mte_sync_page_tags(struct page *page, pte_t old_pte,
 			       bool check_swap, bool pte_is_tagged)
 {
-	if (check_swap && is_swap_pte(old_pte)) {
-		swp_entry_t entry = pte_to_swp_entry(old_pte);
-
-		if (!non_swap_entry(entry) && mte_restore_tags(entry, page)) {
-			set_page_mte_tagged(page);
-			return;
-		}
-	}
-
 	if (!pte_is_tagged)
 		return;
 
diff --git a/arch/arm64/mm/mteswap.c b/arch/arm64/mm/mteswap.c
index 70f913205db99..3fe7774f32b3c 100644
--- a/arch/arm64/mm/mteswap.c
+++ b/arch/arm64/mm/mteswap.c
@@ -46,21 +46,23 @@ int mte_save_tags(struct page *page)
 	return 0;
 }
 
-bool mte_restore_tags(swp_entry_t entry, struct page *page)
+void mte_restore_tags(struct page *page)
 {
+	swp_entry_t entry = folio_swap_entry(page_folio(page));
 	void *tags = xa_load(&mte_pages, entry.val);
 
 	if (!tags)
-		return false;
+		return;
 
 	/*
 	 * Test PG_mte_tagged again in case it was racing with another
 	 * set_pte_at().
 	 */
-	if (!test_and_set_bit(PG_mte_tagged, &page->flags))
+	if (!test_and_set_bit(PG_mte_tagged, &page->flags)) {
 		mte_restore_page_tags(page_address(page), tags);
-
-	return true;
+		if (kasan_hw_tags_enabled())
+			page_kasan_tag_reset(page);
+	}
 }
 
 void mte_invalidate_tags(int type, pgoff_t offset)
diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
index 5f0d7d0b9471b..eea1e545595ca 100644
--- a/include/linux/pgtable.h
+++ b/include/linux/pgtable.h
@@ -793,8 +793,8 @@ static inline void arch_swap_invalidate_area(int type)
 }
 #endif
 
-#ifndef __HAVE_ARCH_SWAP_RESTORE
-static inline void arch_swap_restore(swp_entry_t entry, struct folio *folio)
+#ifndef __HAVE_ARCH_SWAP_READPAGE
+static inline void arch_swap_readpage(struct page *page)
 {
 }
 #endif
diff --git a/mm/page_io.c b/mm/page_io.c
index 3a5f921b932e8..a2f53dbeca7b3 100644
--- a/mm/page_io.c
+++ b/mm/page_io.c
@@ -470,6 +470,12 @@ int swap_readpage(struct page *page, bool synchronous,
 	}
 	delayacct_swapin_start();
 
+	/*
+	 * Some architectures may have to restore extra metadata to the
+	 * page when reading from swap.
+	 */
+	arch_swap_readpage(page);
+
 	if (frontswap_load(page) == 0) {
 		SetPageUptodate(page);
 		unlock_page(page);
diff --git a/mm/shmem.c b/mm/shmem.c
index 0b335607bf2ad..82ccf1e6efe5d 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -1784,12 +1784,6 @@ static int shmem_swapin_folio(struct inode *inode, pgoff_t index,
 	}
 	folio_wait_writeback(folio);
 
-	/*
-	 * Some architectures may have to restore extra metadata to the
-	 * folio after reading from swap.
-	 */
-	arch_swap_restore(swap, folio);
-
 	if (shmem_should_replace_folio(folio, gfp)) {
 		error = shmem_replace_folio(&folio, gfp, info, index);
 		if (error)
