Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 865D470787F
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 05:36:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229724AbjERDgL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 23:36:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbjERDgH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 23:36:07 -0400
Received: from out-2.mta0.migadu.com (out-2.mta0.migadu.com [IPv6:2001:41d0:1004:224b::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC92D30E6
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 20:36:03 -0700 (PDT)
Date:   Wed, 17 May 2023 23:35:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1684380961;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=R/xSxkO34rTHB5jgYq+EIG5zjckP6E+hsO+vx3uRhUA=;
        b=kYDZkSKo3Vd+Vlz3v1TqKnv5UZZxWD+B7u0uWz6Dkfqr9ZyJBFtS6MByThfEB+n4utJGLM
        rNGCmqvF4gzQQHhf299ssyn7P7e2uN7wJt5+ZNmfgQshSe4hzV+RJ++vjONiskQT+QYUZt
        XF9WSVQIfHOOCRmlRkgYsI2hqFoVZfo=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Kent Overstreet <kent.overstreet@linux.dev>
To:     Mike Rapoport <rppt@kernel.org>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Song Liu <song@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vlastimil Babka <vbabka@suse.cz>, linux-kernel@vger.kernel.org,
        x86@kernel.org
Subject: Re: [RFC PATCH 1/5] mm: intorduce __GFP_UNMAPPED and unmapped_alloc()
Message-ID: <ZGWdHC3Jo7tFUC59@moria.home.lan>
References: <20230308094106.227365-1-rppt@kernel.org>
 <20230308094106.227365-2-rppt@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230308094106.227365-2-rppt@kernel.org>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 08, 2023 at 11:41:02AM +0200, Mike Rapoport wrote:
> From: "Mike Rapoport (IBM)" <rppt@kernel.org>
> 
> When set_memory or set_direct_map APIs used to change attribute or
> permissions for chunks of several pages, the large PMD that maps these
> pages in the direct map must be split. Fragmenting the direct map in such
> manner causes TLB pressure and, eventually, performance degradation.
> 
> To avoid excessive direct map fragmentation, add ability to allocate
> "unmapped" pages with __GFP_UNMAPPED flag that will cause removal of the
> allocated pages from the direct map and use a cache of the unmapped pages.
> 
> This cache is replenished with higher order pages with preference for
> PMD_SIZE pages when possible so that there will be fewer splits of large
> pages in the direct map.
> 
> The cache is implemented as a buddy allocator, so it can serve high order
> allocations of unmapped pages.

So I'm late to this discussion, I stumbled in because of my own run in
with executable memory allocation.

I understand that post LSF this patchset seems to not be going anywhere,
but OTOH there's also been a desire for better executable memory
allocation; as noted by tglx and elsewhere, there _is_ a definite
performance impact on page size with kernel text - I've seen numbers in
the multiple single digit percentage range in the past.

This patchset does seem to me to be roughly the right approach for that,
and coupled with the slab allocator for sub-page sized allocations it
seems there's the potential for getting a nice interface that spans the
full range of allocation sizes, from small bpf/trampoline allocations up
to modules.

Is this patchset worth reviving/continuing with? Was it really just the
needed module refactoring that was the blocker?
