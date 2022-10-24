Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68FB660BB75
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 23:00:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233345AbiJXVAd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 17:00:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233073AbiJXU7h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 16:59:37 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19AEE244C59
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 12:06:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=t9FHfeIcloVdmFbUJWpclGjePHUA/HlGyPuL3wK+kr0=; b=tCmUJuvA77NpSI0qj14vZyfAqC
        XkRqamylOY2ncbRiW/TvVx3cmRphmaPB9fzoLsV5xqRkIWJxnzVjLY8fKwe4rKDCtIhJ4IxpQyf54
        fpZZ31JcJYxZNTcWN2NXjbVnCdhRXQOBSedBlYztVQmLQe+nHU8/wTHTTy5CchnforEZSGLVanqGe
        pXFOj/SQXIqSUIaGIOnIKQDv1P4/nYA8F5iEtaDSgET1K7oaCjk/inmHoeKok+qrfQSOrKI04BxNq
        YNGRdOdmafgr89NVU+KhpKmKKV78Dne39j/ZO1sbfdJxEq6RrWZ3vYE+6VXPv1Fw+77QHIq6ZxcQn
        v3PYj9HQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1on22A-00Fdca-8R; Mon, 24 Oct 2022 18:18:46 +0000
Date:   Mon, 24 Oct 2022 19:18:46 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Ira Weiny <ira.weiny@intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Peter Xu <peterx@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        kernel test robot <yujie.liu@intel.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH for rc] mm/shmem: Ensure proper fallback if page faults
Message-ID: <Y1bXBtGTCym77/oD@casper.infradead.org>
References: <20221024043305.1491403-1-ira.weiny@intel.com>
 <Y1bDRpmPdYdilJzp@iweiny-mobl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y1bDRpmPdYdilJzp@iweiny-mobl>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 24, 2022 at 09:54:30AM -0700, Ira Weiny wrote:
> On Sun, Oct 23, 2022 at 09:33:05PM -0700, Ira wrote:
> > From: Ira Weiny <ira.weiny@intel.com>
> > 
> > The kernel test robot flagged a recursive lock as a result of a
> > conversion from kmap_atomic() to kmap_local_folio()[Link]
> > 
> > The cause was due to the code depending on the kmap_atomic() side effect
> > of disabling page faults.  In that case the code expects the fault to
> > fail and take the fallback case.
> > 
> > git archaeology implied that the recursion may not be an actual bug.[1]
> > However, the mmap_lock needed in the fault may be the one held.[2]
> > 
> > Add an explicit pagefault_disable() and a big comment to explain this
> > for future souls looking at this code.
> > 
> > [1] https://lore.kernel.org/all/Y1MymJ%2FINb45AdaY@iweiny-desk3/
> > [2] https://lore.kernel.org/all/Y1M2p9OtBGnKwGUE@x1n/
> > 
> > Fixes: 7a7256d5f512 ("shmem: convert shmem_mfill_atomic_pte() to use a folio")
> > Cc: Andrew Morton <akpm@linux-foundation.org>
> > Cc: Randy Dunlap <rdunlap@infradead.org>
> > Cc: Peter Xu <peterx@redhat.com>
> > Cc: Andrea Arcangeli <aarcange@redhat.com>
> > Reported-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> > Reported-by: kernel test robot <yujie.liu@intel.com>
> > Link: https://lore.kernel.org/r/202210211215.9dc6efb5-yujie.liu@intel.com
> > Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> > 
> > ---
> > Thanks to Matt and Andrew for initial diagnosis.
> > Thanks to Randy for pointing out C code needs ';'  :-D
> > Thanks to Andrew for suggesting an elaborate comment
> > Thanks to Peter for pointing out that the mm's may be the same.
> > ---
> >  mm/shmem.c | 7 +++++++
> >  1 file changed, 7 insertions(+)
> > 
> > diff --git a/mm/shmem.c b/mm/shmem.c
> > index 8280a5cb48df..c1bca31cd485 100644
> > --- a/mm/shmem.c
> > +++ b/mm/shmem.c
> > @@ -2424,9 +2424,16 @@ int shmem_mfill_atomic_pte(struct mm_struct *dst_mm,
> >  
> >  		if (!zeropage) {	/* COPY */
> >  			page_kaddr = kmap_local_folio(folio, 0);
> > +			/*
> > +			 * The mmap_lock is held here.  Disable page faults to
> > +			 * prevent deadlock should copy_from_user() fault.  The
> > +			 * copy will be retried outside the mmap_lock.
> > +			 */
> 
> Offline Dave Hansen and I were discussing this and he was concerned that this
> comment implies that a deadlock would always occur rather than might occur.
> 
> I was not clear on this as I was thinking the read mmap_lock was non-recursive.
> 
> So I think we have 3 cases only 1 of which will actually deadlock and is, as
> Dave puts it, currently theoretical.
> 
> 	1) Different mm's are in play (no issue)
> 	2) Readlock implementation is recursive and same mm is in play (no issue)
> 	3) Readlock implementation is _not_ recursive (issue)
> 
> In both 1 and 2 lockdep is incorrectly flagging the issue but 3 is a problem
> and I think this is what Andrea was thinking.

The readlock implementation is only recursive if nobody else has taken a
write lock.  AIUI, no other process can take a write lock on the
mmap_lock (other processes can take read locks by examining
/proc/$pid/maps, for example), although maybe ptrace can take the
mmap_lock for write?

But if you have a multithreaded process, one of the other threads can
call mmap() and that will prevent recursion (due to fairness).  Even if
it's a different process that you're trying to acquire the mmap read
lock on, you can still get into a deadly embrace.  eg:

process A thread 1 takes read lock on own mmap_lock
process A thread 2 calls mmap, blocks taking write lock
process B thread 1 takes page fault, read lock on own mmap lock
process B thread 2 calls mmap, blocks taking write lock
process A thread 1 blocks taking read lock on process B
process B thread 1 blocks taking read lock on process A

Now all four threads are blocked waiting for each other.
