Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9615C7478BB
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 21:36:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231531AbjGDTgH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 15:36:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjGDTgG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 15:36:06 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6693710C9
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jul 2023 12:36:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=A4IKew0kN3UlZ/53V8vTAFpGpJXOcLX/p8Q1Xyl4NZo=; b=mlsaLhBHoQBje1BQR2ufPx/gJu
        UzG8a+yaHAe6vPT4WeTAGvPuFNMNPyFZoYJ55MgU5Ug/vlosGKQZsNtOBdqn+YwjpGUr2MXiTAjlf
        Ti4Ia8ZHlWFTZIvUgXYK4SBqVM3XYYUgr+xlmMvtz7oMpkrreg+TjKMkgDPrlIqhUx8rqtWf8dzAB
        3zZyVZi0oQZlETbkSTSMhilFRevsNZFfh+EcMhJPaTRerfqzrhT5bkXFpxHh8EKKn1YBuUXji9N2J
        7dp4+XKpR1W7DL6ydA5sRIfTa5shVt1UtoEwa1DqOtLG2qbqb5rUQsPuZT78YWMtTbpZLyGMjpzUp
        6wdAWIjw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qGlod-009PfR-Mx; Tue, 04 Jul 2023 19:35:59 +0000
Date:   Tue, 4 Jul 2023 20:35:59 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Sidhartha Kumar <sidhartha.kumar@oracle.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org
Subject: Re: [PATCH 1/4] mm/memory: convert do_page_mkwrite() to use folios
Message-ID: <ZKR0n+lkqICOrWgr@casper.infradead.org>
References: <20230703055850.227169-1-sidhartha.kumar@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230703055850.227169-1-sidhartha.kumar@oracle.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 02, 2023 at 10:58:47PM -0700, Sidhartha Kumar wrote:
> @@ -2947,14 +2947,14 @@ static vm_fault_t do_page_mkwrite(struct vm_fault *vmf)
>  	if (unlikely(ret & (VM_FAULT_ERROR | VM_FAULT_NOPAGE)))
>  		return ret;
>  	if (unlikely(!(ret & VM_FAULT_LOCKED))) {
> -		lock_page(page);
> -		if (!page->mapping) {
> -			unlock_page(page);
> +		folio_lock(folio);
> +		if (!folio_mapping(folio)) {
> +			folio_unlock(folio);

I promised to explain this better once I had time, and I have time now.

folio->mapping is used for a multitude of purposes, unfortunately.
Maybe some future work will reduce that, but for now, These Are The Rules.

If the folio is marked as being Slab, it's used for something else.
The folio does not belong to an address space (nor can it be mapped,
so we're not going to see it here, but sometimes we see it in other
contexts where we call folio_mapping()).

The bottom two bits are used as PAGE_MAPPING_FLAGS.  If they're both
0, this folio belongs to a file, and the rest of folio->mapping is a
pointer to a struct address_space.  Or they're both 0 because the whole
thing is NULL.  More on that below.  If the bottom two bits are 01b,
this is an anonymous folio, and folio->mapping is actually a pointer
to an anon_vma (which is not the same thing as an anon vma).  If the
bottom two bits are 10b, this is a Movable page (anon & file memory is
also movable, but this is different).  The folio->mapping points to a
struct movable_operations.  If the bottom two bits are 11b, this is a
KSM allocation, and folio->mapping points to a struct ksm_stable_node.

When we remove a folio from the page cache, we reset folio->mapping
to NULL.  We often remove folios from the page cache before their
refcount drops to zero (the common case is to look up the folio in the
page cache, which grabs a reference, remove the folio from the page
cache which decrements the refcount, then put the folio which might be
the last refcount).  So it's entirely possible to see a folio in this
function with a NULL mapping; that means it's been removed from the
file through a truncate or siimlar, and we need to fail the mkwrite.
Userspace is about to get a segfault.

If you find all of that confusing, well, I agree, and I'm trying to
simplify it.

So, with all that background, what's going on here?  Part of the
"modern" protocol for handling page faults is to lock the folio
in vm_ops->page_mkwrite.  But we still support (... why?) drivers
that haven't been updated.  They return 0 on success instead of
VM_FAULT_LOCKED.  So we take the lock for them, then check that the
folio wasn't truncated, and bail out if it looks like it was.

If we have a really old-school driver that has allocated a page,
mapped it to userspace, and set page->mapping to be, eg, Movable, by
calling folio_mapping() instead of folio->mapping, we'll end up seeing
NULL instead of a non-NULL value, mistakenly believe it to have been
truncated and enter an endless loop.

Am I being paranoid here?  Maybe!  Drivers should have been updated by
now.  The "modern" way was introduced in 2007 (commit d0217ac04ca6), so
it'd be nice to turn this into a WARN_ON_ONCE so drivers fix their code.
There are only ~30 implementations of page_mkwrite in the kernel, so it
might not take too long to check everything's OK.
