Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D043469B02F
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 17:06:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229811AbjBQQGt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 11:06:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbjBQQGs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 11:06:48 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA28A6D7BB
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 08:06:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=COgV16QpVFvzSyezj8sQCRnnPRGtqN7Jdmva/Sfnf6s=; b=RECpzUKPshI8Gr0TMEm4IPdtUF
        sAEs6G2dshqrzDveO36GIvZT8g51OMfCJndtvNTg55RA8n/7m/0UG6ZAK1GFsSN8y1dk9KOTtXpl0
        BZws7o+RrILvSQjUBE5aWHre5Tp4+zXQrNBLI68HEk8qdrB9vD5ZaX+zYj80x5aJTzc8Np5/J9hJy
        rVHUrkhkUi0rDmWmvZWftItyP0vBb+2H4RtAzs0gycKAd9E4zBeMqNk6J+FV9oWWCrsMXg/BcRQ9i
        lXif2mYzZUBzqknhqsTIA4YtXMWVUAZkHCXQYWJxdB0JQFT4PLIViYkXx49ykdTfXHscRIcVpAC7t
        u2/OAI2g==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pT3F1-009RNk-2v; Fri, 17 Feb 2023 16:05:43 +0000
Date:   Fri, 17 Feb 2023 16:05:43 +0000
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
Message-ID: <Y++l181MMw+T70yt@casper.infradead.org>
References: <20230216051750.3125598-1-surenb@google.com>
 <20230216051750.3125598-27-surenb@google.com>
 <Y+5Pb4hGmV1YtNQp@casper.infradead.org>
 <CAJuCfpHR8k0GsrYPMjSBVLAbu3EZgDU081+5CnR1td0cLEyDFw@mail.gmail.com>
 <CAJuCfpHODBAV=riSPyvcmLbZVtXSdxrw2GMy8VOjvDV9yCyX8A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJuCfpHODBAV=riSPyvcmLbZVtXSdxrw2GMy8VOjvDV9yCyX8A@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 16, 2023 at 06:14:59PM -0800, Suren Baghdasaryan wrote:
> On Thu, Feb 16, 2023 at 11:43 AM Suren Baghdasaryan <surenb@google.com> wrote:
> >
> > On Thu, Feb 16, 2023 at 7:44 AM Matthew Wilcox <willy@infradead.org> wrote:
> > >
> > > On Wed, Feb 15, 2023 at 09:17:41PM -0800, Suren Baghdasaryan wrote:
> > > > When vma->anon_vma is not set, page fault handler will set it by either
> > > > reusing anon_vma of an adjacent VMA if VMAs are compatible or by
> > > > allocating a new one. find_mergeable_anon_vma() walks VMA tree to find
> > > > a compatible adjacent VMA and that requires not only the faulting VMA
> > > > to be stable but also the tree structure and other VMAs inside that tree.
> > > > Therefore locking just the faulting VMA is not enough for this search.
> > > > Fall back to taking mmap_lock when vma->anon_vma is not set. This
> > > > situation happens only on the first page fault and should not affect
> > > > overall performance.
> > >
> > > I think I asked this before, but don't remember getting an aswer.
> > > Why do we defer setting anon_vma to the first fault?  Why don't we
> > > set it up at mmap time?
> >
> > Yeah, I remember that conversation Matthew and I could not find the
> > definitive answer at the time. I'll look into that again or maybe
> > someone can answer it here.
> 
> After looking into it again I'm still under the impression that
> vma->anon_vma is populated lazily (during the first page fault rather
> than at mmap time) to avoid doing extra work for areas which are never
> faulted. Though I might be missing some important detail here.

How often does userspace call mmap() and then _never_ fault on it?
I appreciate that userspace might mmap() gigabytes of address space and
then only end up using a small amount of it, so populating it lazily
makes sense.  But creating a region and never faulting on it?  The only
use-case I can think of is loading shared libraries:

openat(AT_FDCWD, "/lib/x86_64-linux-gnu/libc.so.6", O_RDONLY|O_CLOEXEC) = 3
(...)
mmap(NULL, 1970000, PROT_READ, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0x7f0ce612e000
mmap(0x7f0ce6154000, 1396736, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x26000) = 0x7f0ce6154000
mmap(0x7f0ce62a9000, 339968, PROT_READ, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x17b000) = 0x7f0ce62a9000
mmap(0x7f0ce62fc000, 24576, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x1ce000) = 0x7f0ce62fc000
mmap(0x7f0ce6302000, 53072, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0x7f0ce6302000

but that's a file-backed VMA, not an anon VMA.
