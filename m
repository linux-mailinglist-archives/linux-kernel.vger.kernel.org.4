Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAE996B28D7
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 16:27:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229916AbjCIP10 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 10:27:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229929AbjCIP1Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 10:27:24 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E4631BF8
        for <linux-kernel@vger.kernel.org>; Thu,  9 Mar 2023 07:27:23 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D5588B81F7A
        for <linux-kernel@vger.kernel.org>; Thu,  9 Mar 2023 15:27:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96BCAC433EF;
        Thu,  9 Mar 2023 15:27:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678375640;
        bh=jsK3tmby10Zy34nLJCJxkX/QS4loLNlyWVZ4G9+hhRU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LVulMktlIRbvD/FGHqyjw1/jbFDRkwJZgvCV11hU6NBtOVxLBeZDeqRKbet2/TFjS
         hxphOdBXISNO1uf4TcGzLLMR9xQT6rbqLwybzqSdyxyItxup0LBS5G3n9MOQyIxwa2
         jRRN5CZaVpK7L4JGc2hR/pwlQr9R8qmeX30rH7g135lFYd2twFV3unkEMwG12p7uSA
         ZV9dExQJ1HMeyH7ePsuillYdxJQw+zuAPI+n5YPQ3S6D9r7zh9r5uGrAInnQ28ObUG
         JhXWxxQhHGgVIl1+xx5m9pkNJoRjhniZPZPc+GQWeUmwzFnavDCxnsalrWIWUv6RW6
         Du+wmFGEseflQ==
Date:   Thu, 9 Mar 2023 17:27:06 +0200
From:   Mike Rapoport <rppt@kernel.org>
To:     Hyeonggon Yoo <42.hyeyoo@gmail.com>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Song Liu <song@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vlastimil Babka <vbabka@suse.cz>, linux-kernel@vger.kernel.org,
        x86@kernel.org
Subject: Re: [RFC PATCH 1/5] mm: intorduce __GFP_UNMAPPED and unmapped_alloc()
Message-ID: <ZAn6yuP3d0JbhlBZ@kernel.org>
References: <20230308094106.227365-1-rppt@kernel.org>
 <20230308094106.227365-2-rppt@kernel.org>
 <ZAl9PbMe1CRlvzva@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZAl9PbMe1CRlvzva@localhost>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 09, 2023 at 06:31:25AM +0000, Hyeonggon Yoo wrote:
> On Wed, Mar 08, 2023 at 11:41:02AM +0200, Mike Rapoport wrote:
> > From: "Mike Rapoport (IBM)" <rppt@kernel.org>
> > 
> > When set_memory or set_direct_map APIs used to change attribute or
> > permissions for chunks of several pages, the large PMD that maps these
> > pages in the direct map must be split. Fragmenting the direct map in such
> > manner causes TLB pressure and, eventually, performance degradation.
> > 
> > To avoid excessive direct map fragmentation, add ability to allocate
> > "unmapped" pages with __GFP_UNMAPPED flag that will cause removal of the
> > allocated pages from the direct map and use a cache of the unmapped pages.
> > 
> > This cache is replenished with higher order pages with preference for
> > PMD_SIZE pages when possible so that there will be fewer splits of large
> > pages in the direct map.
> > 
> > The cache is implemented as a buddy allocator, so it can serve high order
> > allocations of unmapped pages.
> 
> Hello,
> 
> To me it seems unnecessary to increase pageblock bitmap size just to
> distinguish if it is allocated with __GFP_UNMAPPED.
> 
> I think this can be implemented as an independent cache on top of
> buddy allocator, and introducing new API for unmapped page
> allocation and freeing?

Yes, it could. But with such API we'd also need to take care of
mapping/unmapping these pages for the modules use case which is not that
difficult, but still more complex than a flag to vmalloc().
As for secretmem, freeing of secretmem pages happens in the page cache, so
changing that to use, say, unmapped_free() would be quite intrusive.

Another reason to mark the entire pageblock as unmapped is possibility to
steal pages from that pageblock into the unmmaped cache when they become
free. When we allocate pages to replenish the unmapped cache, we split the
large mapping in the direct map, so even the pages in the same pageblock
that do not get into the cache are still mapped at PTE level. When they are
freed, they will be put in the cache and so fewer explicit cache refills
that split the large mappings will be required.
 
> Thanks,
> Hyeonggon

-- 
Sincerely yours,
Mike.
