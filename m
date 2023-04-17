Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0019E6E54CD
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 00:52:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229872AbjDQWwj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 18:52:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229863AbjDQWwh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 18:52:37 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55C664690
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 15:52:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=BhYkL3fl4BPydJO+2j7+oAWmuWRCeGIdPDHX0xx+V6Q=; b=j0Y8fbPq10O1A+H8pMet/NiryP
        qkB9ffB4c+xC7UTRaFpxRTJb7ShyoevTbseu/2a/s1b8vAgAJAaKXhF4PqSs4TS9UGFpc1S7/0aQI
        UzjGEOhtlhfpRw4TZndr60Xz4Z9CioA/WRhUldgullpkiq8Hnl9PBGF73lxXBcDdiM7V1nRcS76Xa
        ZJQHqsELDp0eyXeb034GltLZ0uLQxSeg8X6u32Ux5f74zuSoDkesaI84/vqg6E0192T5VMuTyQKgO
        bze0H1Xs3EbMpqg7udw0PKejW2VsUWJUUQSgexo/nbtdoxgrYdrberVlQxzU5bZk6+zragAztnokE
        opJRY5Gw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1poXhb-00Bks9-Ts; Mon, 17 Apr 2023 22:52:03 +0000
Date:   Mon, 17 Apr 2023 23:52:03 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Peter Xu <peterx@redhat.com>
Cc:     Suren Baghdasaryan <surenb@google.com>, akpm@linux-foundation.org,
        hannes@cmpxchg.org, mhocko@suse.com, josef@toxicpanda.com,
        jack@suse.cz, ldufour@linux.ibm.com, laurent.dufour@fr.ibm.com,
        michel@lespinasse.org, liam.howlett@oracle.com, jglisse@google.com,
        vbabka@suse.cz, minchan@google.com, dave@stgolabs.net,
        punit.agrawal@bytedance.com, lstoakes@gmail.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com
Subject: Re: [PATCH v2 1/1] mm: do not increment pgfault stats when page
 fault handler retries
Message-ID: <ZD3Nk0u+nxOT4snZ@casper.infradead.org>
References: <20230415000818.1955007-1-surenb@google.com>
 <ZD2gsbN2K66oXT69@x1n>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZD2gsbN2K66oXT69@x1n>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 17, 2023 at 03:40:33PM -0400, Peter Xu wrote:
> >  	/*
> > -	 * We don't do accounting for some specific faults:
> > -	 *
> > -	 * - Unsuccessful faults (e.g. when the address wasn't valid).  That
> > -	 *   includes arch_vma_access_permitted() failing before reaching here.
> > -	 *   So this is not a "this many hardware page faults" counter.  We
> > -	 *   should use the hw profiling for that.
> > -	 *
> > -	 * - Incomplete faults (VM_FAULT_RETRY).  They will only be counted
> > -	 *   once they're completed.
> > +	 * Do not account for incomplete faults (VM_FAULT_RETRY). They will be
> > +	 * counted upon completion.
> >  	 */
> > -	if (ret & (VM_FAULT_ERROR | VM_FAULT_RETRY))
> > +	if (ret & VM_FAULT_RETRY)
> > +		return;
> > +
> > +	/* Register both successful and failed faults in PGFAULT counters. */
> > +	count_vm_event(PGFAULT);
> > +	count_memcg_event_mm(mm, PGFAULT);
> 
> Is there reason on why vm events accountings need to be explicitly
> different from perf events right below on handling ERROR?

I think so.  ERROR is quite different from RETRY.  If we are, for
example, handling a SIGSEGV (perhaps a GC language?) that should be
accounted.  If we can't handle a page fault right now, and need to
retry within the kernel, that should not be accounted.

