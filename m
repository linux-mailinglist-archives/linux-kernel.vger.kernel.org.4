Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B940B703900
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 19:37:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244410AbjEORhi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 13:37:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244485AbjEORhR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 13:37:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11B7A14E68;
        Mon, 15 May 2023 10:34:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DB9A862DBD;
        Mon, 15 May 2023 17:34:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F0F4C4339B;
        Mon, 15 May 2023 17:34:33 +0000 (UTC)
Date:   Mon, 15 May 2023 18:34:30 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     Peter Collingbourne <pcc@google.com>,
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
Message-ID: <ZGJtJobLrBg3PtHm@arm.com>
References: <20230512235755.1589034-1-pcc@google.com>
 <20230512235755.1589034-2-pcc@google.com>
 <7471013e-4afb-e445-5985-2441155fc82c@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7471013e-4afb-e445-5985-2441155fc82c@redhat.com>
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 13, 2023 at 05:29:53AM +0200, David Hildenbrand wrote:
> On 13.05.23 01:57, Peter Collingbourne wrote:
> > diff --git a/mm/memory.c b/mm/memory.c
> > index 01a23ad48a04..83268d287ff1 100644
> > --- a/mm/memory.c
> > +++ b/mm/memory.c
> > @@ -3914,19 +3914,7 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
> >   		}
> >   	}
> > -	/*
> > -	 * Remove the swap entry and conditionally try to free up the swapcache.
> > -	 * We're already holding a reference on the page but haven't mapped it
> > -	 * yet.
> > -	 */
> > -	swap_free(entry);
> > -	if (should_try_to_free_swap(folio, vma, vmf->flags))
> > -		folio_free_swap(folio);
> > -
> > -	inc_mm_counter(vma->vm_mm, MM_ANONPAGES);
> > -	dec_mm_counter(vma->vm_mm, MM_SWAPENTS);
> >   	pte = mk_pte(page, vma->vm_page_prot);
> > -
> >   	/*
> >   	 * Same logic as in do_wp_page(); however, optimize for pages that are
> >   	 * certainly not shared either because we just allocated them without
> > @@ -3946,8 +3934,21 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
> >   		pte = pte_mksoft_dirty(pte);
> >   	if (pte_swp_uffd_wp(vmf->orig_pte))
> >   		pte = pte_mkuffd_wp(pte);
> > +	arch_do_swap_page(vma->vm_mm, vma, vmf->address, pte, vmf->orig_pte);
> >   	vmf->orig_pte = pte;
> > +	/*
> > +	 * Remove the swap entry and conditionally try to free up the swapcache.
> > +	 * We're already holding a reference on the page but haven't mapped it
> > +	 * yet.
> > +	 */
> > +	swap_free(entry);
> > +	if (should_try_to_free_swap(folio, vma, vmf->flags))
> > +		folio_free_swap(folio);
> > +
> > +	inc_mm_counter(vma->vm_mm, MM_ANONPAGES);
> > +	dec_mm_counter(vma->vm_mm, MM_SWAPENTS);
> > +
> >   	/* ksm created a completely new copy */
> >   	if (unlikely(folio != swapcache && swapcache)) {
> >   		page_add_new_anon_rmap(page, vma, vmf->address);
> > @@ -3959,7 +3960,6 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
> >   	VM_BUG_ON(!folio_test_anon(folio) ||
> >   			(pte_write(pte) && !PageAnonExclusive(page)));
> >   	set_pte_at(vma->vm_mm, vmf->address, vmf->pte, pte);
> > -	arch_do_swap_page(vma->vm_mm, vma, vmf->address, pte, vmf->orig_pte);
> >   	folio_unlock(folio);
> >   	if (folio != swapcache && swapcache) {
> 
> 
> You are moving the folio_free_swap() call after the folio_ref_count(folio)
> == 1 check, which means that such (previously) swapped pages that are
> exclusive cannot be detected as exclusive.
> 
> There must be a better way to handle MTE here.
> 
> Where are the tags stored, how is the location identified, and when are they
> effectively restored right now?

I haven't gone through Peter's patches yet but a pretty good description
of the problem is here:
https://lore.kernel.org/all/5050805753ac469e8d727c797c2218a9d780d434.camel@mediatek.com/.
I couldn't reproduce it with my swap setup but both Qun-wei and Peter
triggered it.

When a tagged page is swapped out, the arm64 code stores the metadata
(tags) in a local xarray indexed by the swap pte. When restoring from
swap, the arm64 set_pte_at() checks this xarray using the old swap pte
and spills the tags onto the new page. Apparently something changed in
the kernel recently that causes swap_range_free() to be called before
set_pte_at(). The arm64 arch_swap_invalidate_page() frees the metadata
from the xarray and the subsequent set_pte_at() won't find it.

If we have the page, the metadata can be restored before set_pte_at()
and I guess that's what Peter is trying to do (again, I haven't looked
at the details yet; leaving it for tomorrow).

Is there any other way of handling this? E.g. not release the metadata
in arch_swap_invalidate_page() but later in set_pte_at() once it was
restored. But then we may leak this metadata if there's no set_pte_at()
(the process mapping the swap entry died).

-- 
Catalin
