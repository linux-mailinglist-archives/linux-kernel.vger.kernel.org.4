Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CB5465B368
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Jan 2023 15:37:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236180AbjABOhV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 09:37:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236183AbjABOhM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 09:37:12 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ED6D300
        for <linux-kernel@vger.kernel.org>; Mon,  2 Jan 2023 06:37:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=IHJbXSStoTOW1TXphXY3233q5587iv+dojH9JRS4b8Y=; b=QUih8KNnF4kH+vRtjaGFtkBLuH
        MbB3v3V26JuxZSmYx6Dy7uAi0QLvocEqVUwx2EvpvGDRzPpItDue6/4aCsjlPiZrbE8Bj17mzGVTR
        EtBlzaG9hKTvWDND3awzE6yfycMcaVfV1pyz2RiB3eHGvP6Vte49xtWNgWJka4g/1nkaXIuxYGsLe
        i1J3vWgwk6RoRU6q5t6aj7QIXiOLoQWUC2xqxZyphwn1B90KfcL1SOQwcnldjZxxblpu1TXF1gY3p
        JLBc9TVTsgCY3OmpksAeKpiV2XrWUyd2QunTEpnu8Si/hruDP06mcucZpY/jWSP7VqvksLWJbfDYf
        hhSm9S0A==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pCLvz-00DEAH-0q; Mon, 02 Jan 2023 14:37:03 +0000
Date:   Mon, 2 Jan 2023 14:37:02 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Hyeonggon Yoo <42.hyeyoo@gmail.com>
Cc:     linux-mm@kvack.org, liam.howlett@oracle.com, surenb@google.com,
        ldufour@linux.ibm.com, michel@lespinasse.org, vbabka@suse.cz,
        linux-kernel@vger.kernel.org
Subject: Re: [QUESTION] about the maple tree and current status of mmap_lock
 scalability
Message-ID: <Y7LsDgMxHh8NHzDY@casper.infradead.org>
References: <EC51CFA7-2BC8-4F72-A7D4-3B1A778EDB37@gmail.com>
 <Y6ysHNPvKayTfeq8@casper.infradead.org>
 <Y62ipKlWGEbJZKXv@hyeyoo>
 <Y63FmaNoLAcdsLaU@casper.infradead.org>
 <Y7LIPOc/ESmhRzYk@hyeyoo>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y7LIPOc/ESmhRzYk@hyeyoo>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 02, 2023 at 09:04:12PM +0900, Hyeonggon Yoo wrote:
> > https://www.infradead.org/~willy/linux/store-free-page-faults.html
> > outlines how I intend to proceed from Suren's current scheme (where
> > RCU is only used to protect the tree walk) to using RCU for the
> > entire page fault.
> 
> Thank you for sharing this your outlines.
> Okay, so the planned scheme is:
> 
> 	1. Try to process entire page fault under RCU protection
> 		- if failed, goto 2. if succeeded, goto 4.
> 
> 	2. Fall back to Suren's scheme (try to take VMA rwsem)
> 		- if failed, goto 3. if succeeded, goto 4.

Right.  The question is whether to restart the page fault under Suren's
scheme, or just grab the VMA rwsem and continue.  Experimentation
needed.

It's also worth noting that Michel has an alternative proposal, which
is to drop out of RCU protection before trying to allocate memory, then
re-enter RCU mode and check the sequence count hasn't changed on the
entire MM.  His proposal has the advantage of not trying to allocate
memory while holding the RCU read lock, but the disadvantage of having
to retry the page fault if anyone has called mmap() or munmap().  Which
alternative is better is going to depend on the workload; do we see more
calls to mmap()/munmap(), or do we need to enter page reclaim more often?
I think they're largely equivalent performance-wise in the fast path.
Another metric to consider is code complexity; he thinks his method
is easier to understand and I think mine is easier.  To be expected,
I suppose ;-)

> 	3. Fall back to mmap_lock
> 		- goto 4.
> 
> 	4. Finish page fault.
> 
> To implement 1, __p*d_alloc() need to take gfp flags
> not to sleep in RCU read-side critical section.
> 
> What about introducing PF_MEMALLOC_NOWAIT process flag forcing
> GFP_NOWAIT | __GFP_NOWARN
> 
> similar to PF_MEMALLOC_NO{FS,IO}, looking like this?
> 
> Will be less churn.

Certainly less churn, but also far more risky.  All of a sudden,
codepaths which used to always succeed will now start failing, and
either there aren't checks for memory allocation failures or those
paths have never been tested before.
