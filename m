Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58BB96E67D2
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 17:09:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231593AbjDRPJe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 11:09:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230357AbjDRPJb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 11:09:31 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74D9A3C2B
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 08:09:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=8yOGpdRF4UCqqQfqFDrE2rgMF8gNHIdalLte7kmTZ4E=; b=C+Z2qKczB8op70IFq+kz0Og7Ak
        Cb1CZeP4mu8+k7nhUnyW9Ts7AjzlKFrscW2HrctkFvS0ljy/ATzznsvfE+yCVF0uEr02pFqZIzb+B
        +jSpdzagz36KlmjEIzuY7wDVcKXwb97SUlLq+cPSfRM6mVz4cFw5EV/klQHikKPxuVFMYKdpxafRK
        8rSRw4TCkWq8osMhX3LD9T3HVIcDkQu8psQeXNZ3EoWqHD8jGOGI/jdtuzoy1nk4V7CIhhuhVR02r
        lCvqWH7XXkK+BY5VkFK/NxWPRLoOaK1MVuPjFRsYEUcI/7+X4CKXdvbnsw4ST9qAaLX94qIk2VVIQ
        4h1Qsx9A==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pomx0-00COUG-Cx; Tue, 18 Apr 2023 15:08:58 +0000
Date:   Tue, 18 Apr 2023 16:08:58 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     Peter Xu <peterx@redhat.com>, akpm@linux-foundation.org,
        hannes@cmpxchg.org, mhocko@suse.com, josef@toxicpanda.com,
        jack@suse.cz, ldufour@linux.ibm.com, laurent.dufour@fr.ibm.com,
        michel@lespinasse.org, liam.howlett@oracle.com, jglisse@google.com,
        vbabka@suse.cz, minchan@google.com, dave@stgolabs.net,
        punit.agrawal@bytedance.com, lstoakes@gmail.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com
Subject: Re: [PATCH v2 1/1] mm: do not increment pgfault stats when page
 fault handler retries
Message-ID: <ZD6yirD6Ob+1xG32@casper.infradead.org>
References: <20230415000818.1955007-1-surenb@google.com>
 <ZD2gsbN2K66oXT69@x1n>
 <ZD3Nk0u+nxOT4snZ@casper.infradead.org>
 <CAJuCfpFPziNK65qpzd5dEYSnoE-94UHAsM-CX080VTTJC5ZZKA@mail.gmail.com>
 <ZD6oVgIi/yY1+t1L@casper.infradead.org>
 <CAJuCfpFJ0owZELS2COukb0rHCOpqNMW-x9vVonkhknReZb=Zsg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJuCfpFJ0owZELS2COukb0rHCOpqNMW-x9vVonkhknReZb=Zsg@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 18, 2023 at 07:54:01AM -0700, Suren Baghdasaryan wrote:
> On Tue, Apr 18, 2023 at 7:25 AM Matthew Wilcox <willy@infradead.org> wrote:
> >
> > On Mon, Apr 17, 2023 at 04:17:45PM -0700, Suren Baghdasaryan wrote:
> > > On Mon, Apr 17, 2023 at 3:52 PM Matthew Wilcox <willy@infradead.org> wrote:
> > > >
> > > > On Mon, Apr 17, 2023 at 03:40:33PM -0400, Peter Xu wrote:
> > > > > >     /*
> > > > > > -    * We don't do accounting for some specific faults:
> > > > > > -    *
> > > > > > -    * - Unsuccessful faults (e.g. when the address wasn't valid).  That
> > > > > > -    *   includes arch_vma_access_permitted() failing before reaching here.
> > > > > > -    *   So this is not a "this many hardware page faults" counter.  We
> > > > > > -    *   should use the hw profiling for that.
> > > > > > -    *
> > > > > > -    * - Incomplete faults (VM_FAULT_RETRY).  They will only be counted
> > > > > > -    *   once they're completed.
> > > > > > +    * Do not account for incomplete faults (VM_FAULT_RETRY). They will be
> > > > > > +    * counted upon completion.
> > > > > >      */
> > > > > > -   if (ret & (VM_FAULT_ERROR | VM_FAULT_RETRY))
> > > > > > +   if (ret & VM_FAULT_RETRY)
> > > > > > +           return;
> > > > > > +
> > > > > > +   /* Register both successful and failed faults in PGFAULT counters. */
> > > > > > +   count_vm_event(PGFAULT);
> > > > > > +   count_memcg_event_mm(mm, PGFAULT);
> > > > >
> > > > > Is there reason on why vm events accountings need to be explicitly
> > > > > different from perf events right below on handling ERROR?
> > > >
> > > > I think so.  ERROR is quite different from RETRY.  If we are, for
> > > > example, handling a SIGSEGV (perhaps a GC language?) that should be
> > > > accounted.  If we can't handle a page fault right now, and need to
> > > > retry within the kernel, that should not be accounted.
> > >
> > > IIUC, the question was about the differences in vm vs perf accounting
> > > for errors, not the difference between ERROR and RETRY cases. Matthew,
> > > are you answering the right question or did I misunderstand your
> > > answer?
> >
> > Maybe I'm misunderstanding what you're proposing.  I thought the
> > proposal was to make neither ERROR nor RETRY increment the counters,
> > but if the proposal is to make ERROR increment the perf counters
> > instead, then that's cool with me.
> 
> Oh, I think now I understand your answer. You were not highlighting
> the difference between the who but objecting to the proposal of not
> counting both ERROR and RETRY. Am I on the same page now?

I think so.  Let's see your patch and then we can be sure we're talking
about the same thing ;-)
