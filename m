Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9BEC6D518D
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 21:50:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232518AbjDCTuS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 15:50:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230102AbjDCTuR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 15:50:17 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B07FA2D4C
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 12:50:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=HGctQB0MsRBtisRk2++z/+GWlNTueM1Ui8YvixFhQlY=; b=X60NF2viHjNcrKZmmtR7mlOIcZ
        1Y36Pe07ymKNMV3a8raWrlb4MRrCcrdjoAvIbIQjODociXLvioH6LYHzwVlwfWsvJq+Coq+a/0z/B
        cslo4SZh7ylCbnShU+ddLnjAk0nBSLoWs32ZKkGIAbvH2yttKqc7lXMcYSOWSd/dkFhurl+0xKNX0
        2gzCwU/YVPspZTaLjZf6xB7foALpxqVWfVraXkGPwiT1Nn/4ptB2CYzNFQb9qpeeVUrymrRKh9Tt0
        2WSTo+eQKqG+msljYC8OzkjMwNhCnm+5sQ4ESwLx/A81NxHyIciWE+1QzEz+kzcR0GJ0bZUGMIsmV
        QcRYx6yg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pjQB8-00ES6a-Ln; Mon, 03 Apr 2023 19:49:22 +0000
Date:   Mon, 3 Apr 2023 20:49:22 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     akpm@linux-foundation.org, michel@lespinasse.org,
        jglisse@google.com, mhocko@suse.com, vbabka@suse.cz,
        hannes@cmpxchg.org, mgorman@techsingularity.net, dave@stgolabs.net,
        liam.howlett@oracle.com, peterz@infradead.org,
        ldufour@linux.ibm.com, paulmck@kernel.org, mingo@redhat.com,
        will@kernel.org, luto@kernel.org, songliubraving@fb.com,
        peterx@redhat.com, david@redhat.com, dhowells@redhat.com,
        hughd@google.com, bigeasy@linutronix.de, kent.overstreet@linux.dev,
        punit.agrawal@bytedance.com, lstoakes@gmail.com,
        peterjung1337@gmail.com, rientjes@google.com, chriscli@google.com,
        axelrasmussen@google.com, joelaf@google.com, minchan@google.com,
        rppt@kernel.org, jannh@google.com, shakeelb@google.com,
        tatashin@google.com, edumazet@google.com, gthelen@google.com,
        gurua@google.com, arjunroy@google.com, soheil@google.com,
        leewalsh@google.com, posk@google.com,
        michalechner92@googlemail.com, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@android.com
Subject: Re: [PATCH v3 26/35] mm: fall back to mmap_lock if vma->anon_vma is
 not yet set
Message-ID: <ZCstwjKhn76/mxIa@casper.infradead.org>
References: <20230216051750.3125598-1-surenb@google.com>
 <20230216051750.3125598-27-surenb@google.com>
 <Y+5Pb4hGmV1YtNQp@casper.infradead.org>
 <CAJuCfpHR8k0GsrYPMjSBVLAbu3EZgDU081+5CnR1td0cLEyDFw@mail.gmail.com>
 <CAJuCfpHODBAV=riSPyvcmLbZVtXSdxrw2GMy8VOjvDV9yCyX8A@mail.gmail.com>
 <Y++l181MMw+T70yt@casper.infradead.org>
 <CAJuCfpG_ZWJs3mZkL0z7m-bBe1SmeoTZydfFocZaRbHob_89Hg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJuCfpG_ZWJs3mZkL0z7m-bBe1SmeoTZydfFocZaRbHob_89Hg@mail.gmail.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 17, 2023 at 08:10:35AM -0800, Suren Baghdasaryan wrote:
> On Fri, Feb 17, 2023 at 8:05 AM Matthew Wilcox <willy@infradead.org> wrote:
> >
> > On Thu, Feb 16, 2023 at 06:14:59PM -0800, Suren Baghdasaryan wrote:
> > > On Thu, Feb 16, 2023 at 11:43 AM Suren Baghdasaryan <surenb@google.com> wrote:
> > > >
> > > > On Thu, Feb 16, 2023 at 7:44 AM Matthew Wilcox <willy@infradead.org> wrote:
> > > > >
> > > > > On Wed, Feb 15, 2023 at 09:17:41PM -0800, Suren Baghdasaryan wrote:
> > > > > > When vma->anon_vma is not set, page fault handler will set it by either
> > > > > > reusing anon_vma of an adjacent VMA if VMAs are compatible or by
> > > > > > allocating a new one. find_mergeable_anon_vma() walks VMA tree to find
> > > > > > a compatible adjacent VMA and that requires not only the faulting VMA
> > > > > > to be stable but also the tree structure and other VMAs inside that tree.
> > > > > > Therefore locking just the faulting VMA is not enough for this search.
> > > > > > Fall back to taking mmap_lock when vma->anon_vma is not set. This
> > > > > > situation happens only on the first page fault and should not affect
> > > > > > overall performance.
> > > > >
> > > > > I think I asked this before, but don't remember getting an aswer.
> > > > > Why do we defer setting anon_vma to the first fault?  Why don't we
> > > > > set it up at mmap time?
> > > >
> > > > Yeah, I remember that conversation Matthew and I could not find the
> > > > definitive answer at the time. I'll look into that again or maybe
> > > > someone can answer it here.
> > >
> > > After looking into it again I'm still under the impression that
> > > vma->anon_vma is populated lazily (during the first page fault rather
> > > than at mmap time) to avoid doing extra work for areas which are never
> > > faulted. Though I might be missing some important detail here.
> >
> > How often does userspace call mmap() and then _never_ fault on it?
> > I appreciate that userspace might mmap() gigabytes of address space and
> > then only end up using a small amount of it, so populating it lazily
> > makes sense.  But creating a region and never faulting on it?  The only
> > use-case I can think of is loading shared libraries:
> >
> > openat(AT_FDCWD, "/lib/x86_64-linux-gnu/libc.so.6", O_RDONLY|O_CLOEXEC) = 3
> > (...)
> > mmap(NULL, 1970000, PROT_READ, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0x7f0ce612e000
> > mmap(0x7f0ce6154000, 1396736, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x26000) = 0x7f0ce6154000
> > mmap(0x7f0ce62a9000, 339968, PROT_READ, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x17b000) = 0x7f0ce62a9000
> > mmap(0x7f0ce62fc000, 24576, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x1ce000) = 0x7f0ce62fc000
> > mmap(0x7f0ce6302000, 53072, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0x7f0ce6302000
> >
> > but that's a file-backed VMA, not an anon VMA.
> 
> Might the case of dup_mmap() while forking be the reason why a VMA in
> the child process might be never used while parent uses it (or visa
> versa)? Again, I'm not sure this is the reason but I can find no other
> good explanation.

I found an explanation!  Well, a partial one.  If we MAP_PRIVATE a file
mapping (like, er those ones up there) and only take read faults on it,
we can postpone allocation of the anon_vma indefinitely.  But once we
take a write fault in that VMA, we need to allocate an anon_vma for it
so that we can track the anonymous pages that have been allocated to
satisfy the copy-on-write (see do_cow_fault()).

However, I think in that caase, we could probably skip the
find_mergeable_anon_vma() step.  We don't today; we check whether
a->vm_file == b->vm_file in anon_vma_compatible, but I wonder if that
triggers often.

