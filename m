Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97CEA69CF97
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 15:43:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232179AbjBTOni (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 09:43:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231933AbjBTOng (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 09:43:36 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD6D512F09
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 06:43:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=VeqL6y623h+FMhkEfavLpT75Tlfn0L2408lWtNODo6o=; b=EledkTINaaMwY15VWWJ0YF4EPm
        jTww9uFc+igziLg5X+BwRijrnJh7sE2pL4oNdUnknWXb/Oa3aR3x8z1Urlyc0At8XV9jDwssM5WV+
        qIPxVxvRMoRc6XAjHabcy3exsxlYvK4+MdofR4b63RkphkjSWo/bollQ26oXFHXeb+ngaRS7+KN4Z
        PQbamb35BvY5yoW9WtTGXrSMFSeA8Jz9P/OKpENrgxAjpY7B6S+MM+gSHMwiMiOiFSi3AEUsofq0y
        lAUcQ5MatT2Kk0YnrwTDGCVCH1u+ukA0ZHE//cn6Cep96xPfocBq31F9cGmy/kHN0eNioqyDrQ59E
        2PDPqtpQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pU7Nz-00BnYk-FD; Mon, 20 Feb 2023 14:43:23 +0000
Date:   Mon, 20 Feb 2023 14:43:23 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Hyeonggon Yoo <42.hyeyoo@gmail.com>
Cc:     linux-mm@kvack.org, liam.howlett@oracle.com, surenb@google.com,
        ldufour@linux.ibm.com, michel@lespinasse.org, vbabka@suse.cz,
        linux-kernel@vger.kernel.org
Subject: Re: [QUESTION] about the maple tree and current status of mmap_lock
 scalability
Message-ID: <Y/OHC33YLedMXTlD@casper.infradead.org>
References: <EC51CFA7-2BC8-4F72-A7D4-3B1A778EDB37@gmail.com>
 <Y6ysHNPvKayTfeq8@casper.infradead.org>
 <Y62ipKlWGEbJZKXv@hyeyoo>
 <Y63FmaNoLAcdsLaU@casper.infradead.org>
 <Y7LIPOc/ESmhRzYk@hyeyoo>
 <Y7LsDgMxHh8NHzDY@casper.infradead.org>
 <Y/ODKQFj446+KBSy@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y/ODKQFj446+KBSy@localhost>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 20, 2023 at 02:26:49PM +0000, Hyeonggon Yoo wrote:
> On Mon, Jan 02, 2023 at 02:37:02PM +0000, Matthew Wilcox wrote:
> > On Mon, Jan 02, 2023 at 09:04:12PM +0900, Hyeonggon Yoo wrote:
> > > > https://www.infradead.org/~willy/linux/store-free-page-faults.html
> > > > outlines how I intend to proceed from Suren's current scheme (where
> > > > RCU is only used to protect the tree walk) to using RCU for the
> > > > entire page fault.
> > > 
> > > Thank you for sharing this your outlines.
> > > Okay, so the planned scheme is:
> > > 
> > > 	1. Try to process entire page fault under RCU protection
> > > 		- if failed, goto 2. if succeeded, goto 4.
> > > 
> > > 	2. Fall back to Suren's scheme (try to take VMA rwsem)
> > > 		- if failed, goto 3. if succeeded, goto 4.
> > 
> > Right.  The question is whether to restart the page fault under Suren's
> > scheme, or just grab the VMA rwsem and continue.  Experimentation
> > needed.
> > 
> > It's also worth noting that Michel has an alternative proposal, which
> > is to drop out of RCU protection before trying to allocate memory, then
> > re-enter RCU mode and check the sequence count hasn't changed on the
> > entire MM.  His proposal has the advantage of not trying to allocate
> > memory while holding the RCU read lock, but the disadvantage of having
> > to retry the page fault if anyone has called mmap() or munmap().  Which
> > alternative is better is going to depend on the workload; do we see more
> > calls to mmap()/munmap(), or do we need to enter page reclaim more often?
> > I think they're largely equivalent performance-wise in the fast path.
> > Another metric to consider is code complexity; he thinks his method
> > is easier to understand and I think mine is easier.  To be expected,
> > I suppose ;-)
> 
> I'm planning to suggest a cooperative project to my colleagues
> that would involve making __p?d_alloc() take gfp flags.
> 
> Wondering if there was any progress or conclusion made on which
> approach is better for full RCU page faults, or was there another
> solution proposed?
> 
> Asking this because I don't want to waste my time if the approach
> has been abandoned.

Thanks for checking, but nobody's made any progress on this, that I know
of.

(The __p?d_alloc() approach may also be useful to support vmalloc()
with flags that aren't GFP_KERNEL compatible)
