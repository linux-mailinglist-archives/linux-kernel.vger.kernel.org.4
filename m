Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E421F70883B
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 21:15:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230037AbjERTPS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 15:15:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229635AbjERTPQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 15:15:16 -0400
Received: from out-57.mta0.migadu.com (out-57.mta0.migadu.com [IPv6:2001:41d0:1004:224b::39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A7C710D
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 12:15:15 -0700 (PDT)
Date:   Thu, 18 May 2023 15:15:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1684437313;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iJOcOo25k/wjXyas4+FHmqw1p9KvUt01mEjs8lvvZV8=;
        b=UQPwjzIZOMERMSv3XDHRDtcnkGzMKBEQ6yX9N4FHhDUNLB5Iy9LafDBREGZ94SM+U/fzWe
        zJzi5CPNEMSCP9TtcpEmr5cMT8eDwPtWLqQStII4YNUT8PIZ+UF/WOCbg3YB9TxdWNhYGC
        WlR+T9+6vMcBdBJqBeGx6GekxSFNhIQ=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Kent Overstreet <kent.overstreet@linux.dev>
To:     Song Liu <song@kernel.org>
Cc:     Mike Rapoport <rppt@kernel.org>, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vlastimil Babka <vbabka@suse.cz>, linux-kernel@vger.kernel.org,
        x86@kernel.org
Subject: Re: [RFC PATCH 1/5] mm: intorduce __GFP_UNMAPPED and unmapped_alloc()
Message-ID: <ZGZ5PuQxDnjHlxAY@moria.home.lan>
References: <20230308094106.227365-1-rppt@kernel.org>
 <20230308094106.227365-2-rppt@kernel.org>
 <ZGWdHC3Jo7tFUC59@moria.home.lan>
 <20230518152354.GD4967@kernel.org>
 <CAPhsuW541pcsMKYah=2U8mUs8is3jAiNKC8Erte=RkAUGFO9EA@mail.gmail.com>
 <ZGZW0v3nRShO7r+Z@moria.home.lan>
 <CAPhsuW5BbbxinaH2aO=2Wa0aSQ3pkNwvnrgJv7fG4QcPr_j7+Q@mail.gmail.com>
 <ZGZfLHA8vuRJwa0f@moria.home.lan>
 <CAPhsuW6B3O_kWjWwr+UfYO3WRkznFqBNtcecFCSECBSiZBJDsA@mail.gmail.com>
 <CAPhsuW4Mm8z4kbVo8-sPU=QL2B1Sb32ZO7teWT8qienGNuxaeQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPhsuW4Mm8z4kbVo8-sPU=QL2B1Sb32ZO7teWT8qienGNuxaeQ@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 18, 2023 at 12:03:03PM -0700, Song Liu wrote:
> On Thu, May 18, 2023 at 11:47 AM Song Liu <song@kernel.org> wrote:
> >
> > On Thu, May 18, 2023 at 10:24 AM Kent Overstreet
> > <kent.overstreet@linux.dev> wrote:
> > >
> > > On Thu, May 18, 2023 at 10:00:39AM -0700, Song Liu wrote:
> > > > On Thu, May 18, 2023 at 9:48 AM Kent Overstreet
> > > > <kent.overstreet@linux.dev> wrote:
> > > > >
> > > > > On Thu, May 18, 2023 at 09:33:20AM -0700, Song Liu wrote:
> > > > > > I am working on patches based on the discussion in [1]. I am planning to
> > > > > > send v1 for review in a week or so.
> > > > >
> > > > > Hey Song, I was reviewing that thread too,
> > > > >
> > > > > Are you taking a different approach based on Thomas's feedback? I think
> > > > > he had some fair points in that thread.
> > > >
> > > > Yes, the API is based on Thomas's suggestion, like 90% from the discussions.
> > > >
> > > > >
> > > > > My own feeling is that the buddy allocator is our tool for allocating
> > > > > larger variable sized physically contiguous allocations, so I'd like to
> > > > > see something based on that - I think we could do a hybrid buddy/slab
> > > > > allocator approach, like we have for regular memory allocations.
> > > >
> > > > I am planning to implement the allocator based on this (reuse
> > > > vmap_area logic):
> > >
> > > Ah, you're still doing vmap_area approach.
> > >
> > > Mike's approach looks like it'll be _much_ lighter weight and higher
> > > performance, to me. vmalloc is known to be slow compared to the buddy
> > > allocator, and with Mike's approach we're only modifying mappings once
> > > per 2 MB chunk.
> > >
> > > I don't see anything in your code for sub-page sized allocations too, so
> > > perhaps I should keep going with my slab allocator.
> >
> > The vmap_area approach handles sub-page allocations. In 5/5 of set [2],
> > we showed that multiple BPF programs share the same page with some
> > kernel text (_etext).
> >
> > > Could you share your thoughts on your approach vs. Mike's? I'm newer to
> > > this area of the code than you two so maybe there's an angle I've missed
> > > :)
> >
> > AFAICT, tree based solution (vmap_area) is more efficient than bitmap
> > based solution.

Tree based requires quite a bit of overhead for the rbtree pointers, and
additional vmap_area structs.

With a buddy allocator based approach, there's no additional state that
needs to be allocated, since it all fits in struct page.

> > First, for 2MiB page with 64B chunk size, we need a bitmap of
> >      2MiB / 64B = 32k bit = 4k bytes
> > While the tree based solution can adapt to the number of allocations within
> > This 2MiB page. Also, searching a free range within 4kB of bitmap may
> > actually be slower than searching in the tree.
> >
> > Second, bitmap based solution cannot handle > 2MiB allocation cleanly,
> > while tree based solution can. For example, if a big driver uses 3MiB, the
> > tree based allocator can allocate 4MiB for it, and use the rest 1MiB for
> > smaller allocations.

We're not talking about a bitmap based solution for >= PAGE_SIZE
allocations, the alternative is a buddy allocator - so no searching,
just per power-of-two freelists.

> 
>  Missed one:
> 
> Third, bitmap based solution requires a "size" parameter in free(). It is an
> overhead for the user. Tree based solution doesn't have this issue.

No, we can recover the size of the allocation via compound_order() -
hasn't historically been done for alloc_pages() allocations to avoid
setting up the state in each page for compound head/tail, but it perhaps
should be (and is with folios, which we've generally been switching to).
