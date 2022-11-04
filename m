Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0B62619C6C
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 17:01:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232258AbiKDQBv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 12:01:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231565AbiKDQBq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 12:01:46 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 495073205C
        for <linux-kernel@vger.kernel.org>; Fri,  4 Nov 2022 09:01:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=wpJfP/2Wf+9TM1Ly0AcXL7cMe2wzVyoEhqWc7Sdl3rA=; b=Tu5ihBp3rXsAbF7+JMo/NqT3Tv
        ZBN4eAbFJ+9th7ufkgd8BpOqLU5vZ1FneT2oBzXuae+q8VkC00nj+pt4w1hlLYggUKN6Zg8SV1Ilb
        bJSDhBvhinllMAEv+UkmivmZ+FHKOBjB0z3In3OiyFCO2lxxFzNopLBLTX5oz18aKylZAD1dWYEDZ
        fKLPQnNbpk+n4i/G+Ymt23rMY9llgLcs/PmU0LMPRAdgCSSD8yrn26agWeINnCbtzJniBee5l8t00
        VUAoP/B3NVGQCzmOaVARnFna5S6x21LsB1mqYk4Vno6RkI7VJCmYs8CuW7jybidPO5sbXN6bh0e6Y
        ELHW5L7g==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oqz8R-007Tvp-0g; Fri, 04 Nov 2022 16:01:35 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 3942430008D;
        Fri,  4 Nov 2022 17:01:29 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 229E5209E95D6; Fri,  4 Nov 2022 17:01:29 +0100 (CET)
Date:   Fri, 4 Nov 2022 17:01:29 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Uros Bizjak <ubizjak@gmail.com>, x86@kernel.org,
        willy@infradead.org, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        aarcange@redhat.com, kirill.shutemov@linux.intel.com,
        jroedel@suse.de
Subject: Re: [PATCH 11/13] x86_64: Remove pointless set_64bit() usage
Message-ID: <Y2U3WdU61FvYlpUh@hirez.programming.kicks-ass.net>
References: <20221022111403.531902164@infradead.org>
 <20221022114425.168036718@infradead.org>
 <Y2QR/BRHjjYUNszh@dev-arch.thelio-3990X>
 <CAFULd4bkn3i0ds1ywhxAZBQH+1O-zbPWscUqjoEcv4xvnxOnSw@mail.gmail.com>
 <Y2QYHZsZNs33NXZB@dev-arch.thelio-3990X>
 <CAHk-=wjCBOwSWec+=h08q3Gbr4UjSfX46GrQjzHZLFokziS7nA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjCBOwSWec+=h08q3Gbr4UjSfX46GrQjzHZLFokziS7nA@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 03, 2022 at 01:39:17PM -0700, Linus Torvalds wrote:

> And even after I checked *that*, I then checked the 'struct irte' to
> check that it's actually properly defined, and it isn't. Considering
> that this all requires 16-byte alignment to work, I think that type
> should also be marked as being 16-byte aligned.
> 
> In fact, I wonder if we should aim to actually force compile-time
> checking, because right now we have
> 
>         VM_BUG_ON((unsigned long)(p1) % (2 * sizeof(long)));
>         VM_BUG_ON((unsigned long)((p1) + 1) != (unsigned long)(p2));
> 
> in our x86-64 __cmpxchg_double() macro, and honestly, that first one
> might be better as a compile time check of __alignof__, and the second
> one shouldn't exisrt at all because our interface shouldn't be using
> two different pointers when the only possible use is for one single
> aligned value.

So cmpxchg_double() does a cmpxchg on a double long value and is
currently supported by: i386, x86_64, arm64 and s390.

On all those, except i386, two longs are u128.

So how about we introduce u128 and cmpxchg128 -- then it directly
mirrors the u64 and cmpxchg64 usage we already have. It then also
naturally imposses the alignment thing.

Afaict the only cmpxchg_double() users are:

  arch/s390/kernel/perf_cpum_sf.c
  drivers/iommu/amd/iommu.c
  drivers/iommu/intel/irq_remapping.c
  mm/slub.c

Of those slub.c is the only one that cares about 32bit and would need
some 'compat' code to pick between cmpxchg64 / cmpxchg128, but it
already has everything wrapped in helpers so that shouldn't be too big
of a worry.

Then we can convert these few users over and simply delete the whole
cmpxchg_double() thing.

