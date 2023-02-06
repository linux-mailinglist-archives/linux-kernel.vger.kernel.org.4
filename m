Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2BFD68C902
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 22:51:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230265AbjBFVv1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 16:51:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230208AbjBFVvP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 16:51:15 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0AB02D179
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 13:50:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=5Noehyrdxp65AYgU/Rd0icw/+mGSqeNpyRsqa5UmVf0=; b=Mi1QFEngUyC1llEFYrqKh3LtNp
        0O4sjmkE4MgCoHGrnVAesfI8v/VdeaPjzZoYrwmYszk71leLLTfPuClpZb2P0XQQubnNgz4hn4y1d
        acfq6/mOgTU5KCMFLV1BghkRjWujSkr/JqVg9oj8UOmZF0t7F/8+OUv7VXe3o75bpDxSqymberSiy
        tW7vCqxUN3PcnUIc4grtNN0SENOjc8wGs4KkNVzFOEnZ6v9TO2vSC/iUbz3cf2mwilaZyBnzLsTl9
        NSihnMnWrLlxQ4+ihpDj47EuTKjhKUYonSrzTXSOi2WCZTKUyUcFu6uPCFcXjpVIaChEtY2krZmlw
        xKt3YVMg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pP9NZ-00H76P-65; Mon, 06 Feb 2023 21:50:25 +0000
Date:   Mon, 6 Feb 2023 21:50:25 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Peter Xu <peterx@redhat.com>
Cc:     David Stevens <stevensd@chromium.org>, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Yang Shi <shy828301@gmail.com>,
        David Hildenbrand <david@redhat.com>,
        Hugh Dickins <hughd@google.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mm/khugepaged: skip shmem with userfaultfd
Message-ID: <Y+F2IdXhqc5187s+@casper.infradead.org>
References: <20230206112856.1802547-1-stevensd@google.com>
 <Y+FOk+ty7OKmkwLL@casper.infradead.org>
 <Y+Fog2dO1kpRBMvr@x1n>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y+Fog2dO1kpRBMvr@x1n>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 06, 2023 at 03:52:19PM -0500, Peter Xu wrote:
> On Mon, Feb 06, 2023 at 07:01:39PM +0000, Matthew Wilcox wrote:
> > On Mon, Feb 06, 2023 at 08:28:56PM +0900, David Stevens wrote:
> > > This change first makes sure that the intermediate page cache state
> > > during collapse is not visible by moving when gaps are filled to after
> > > the page cache lock is acquired for the final time. This is necessary
> > > because the synchronization provided by locking hpage is insufficient
> > > for functions which operate on the page cache without actually locking
> > > individual pages to examine their content (e.g. shmem_mfill_atomic_pte).
> > 
> > I've been a little scared of touching khugepaged because, well, look at
> > that function.  But if we are going to touch it, how about this patch
> > first?  It does _part_ of what you need by not filling in the holes,
> > but obviously not the part that looks at uffd.  
> > 
> > It leaves the old pages in-place and frozen.  I think this should be
> > safe, but I haven't booted it (not entirely sure what test I'd run
> > to prove that it's not broken)
> 
> That logic existed since Kirill's original commit to add shmem thp support
> on khugepaged, so Kirill should be the best to tell.. but so far it seems
> reasonalbe to me to have that extra operation.
> 
> The problem is khugepaged will release pgtable lock during collapsing, so
> AFAICT there can be a race where some other thread tries to insert pages
> into page cache in parallel with khugepaged right after khugepaged released
> the page cache lock.
> 
> For example, it seems to me new page cache can be inserted when khugepaged
> is copying small page content to the new hpage.

Mmm, yes, we need to have _something_ in the page cache to block new
pages from being added.  It can be either the new or the old pages,
but it can't be NULL.  It could even be a RETRY entry, since that'll
have the same effect as a frozen page.

But both David's patch and mine are wrong.  Not sure what to do for
David's problem -- maybe it's OK to have the holes temporarily filled
with frozen / RETRY entries until we get to the point where we check
for an uffd marker?
