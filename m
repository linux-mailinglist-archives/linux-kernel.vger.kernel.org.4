Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E2B2613A5E
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 16:41:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231846AbiJaPlb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 11:41:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231932AbiJaPlK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 11:41:10 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB61111C1C;
        Mon, 31 Oct 2022 08:40:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=W0IxW07wGXfhbxB2t/U5m54gfxyvIPwy+2kvZkeZYCE=; b=UoMTE4fjFILoU9dWuD24Mpq1Cr
        X7plBmzOKe2nijiZ3IRKHkM6DGiKraDXfGZSMldphtKA52TEdWcvtPGn8jhsXaIB9NnJkJULCx/0a
        Gabp3e0nNm89mj0YkmqUUH99d0DeNLJDvhF7psO5GCZY+zHPd9gzRpGFWsbGWfIMpzeOJv9sy9E3w
        vIlbRhqyo+ef2RpQ1CgUTGIIDCv5LN5vA7kJzVoD68eR5e1aXAEP2Oh5df2p16K6v3LgL6OVlcuZ9
        W/dgL1qDNoBIDI4aKrC6NZ5vF4NFV+q/tr8/h74NcUDKHsH6k/pEy5n4NgoR8FugxF6DHzeG1t8sx
        XViht4uA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1opWu7-003muP-Qk; Mon, 31 Oct 2022 15:40:47 +0000
Date:   Mon, 31 Oct 2022 15:40:47 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Vlastimil Babka <vbabka@suse.cz>,
        Anders Roxell <anders.roxell@linaro.org>,
        kernel test robot <oliver.sang@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Rientjes <rientjes@google.com>,
        Marco Elver <elver@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        linux-mm@kvack.org, Andrey Konovalov <andreyknvl@gmail.com>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v4] mempool: Do not use ksize() for poisoning
Message-ID: <Y1/sf9xranqeCeBo@casper.infradead.org>
References: <20221028154823.you.615-kees@kernel.org>
 <20221031105514.GB69385@mutt>
 <13c4bd6e-09d3-efce-43a5-5a99be8bc96b@suse.cz>
 <Y1/l4Tacaw738UaX@casper.infradead.org>
 <202210310821.9F7AA27D12@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202210310821.9F7AA27D12@keescook>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 31, 2022 at 08:22:50AM -0700, Kees Cook wrote:
> On Mon, Oct 31, 2022 at 03:12:33PM +0000, Matthew Wilcox wrote:
> > On Mon, Oct 31, 2022 at 04:00:25PM +0100, Vlastimil Babka wrote:
> > > +++ b/mm/mempool.c
> > > @@ -57,8 +57,10 @@ static void __check_element(mempool_t *pool, void *element, size_t size)
> > >  static void check_element(mempool_t *pool, void *element)
> > >  {
> > >  	/* Mempools backed by slab allocator */
> > > -	if (pool->free == mempool_free_slab || pool->free == mempool_kfree) {
> > > +	if (pool->free == mempool_kfree) {
> > >  		__check_element(pool, element, (size_t)pool->pool_data);
> > > +	} else if (pool->free == mempool_free_slab) {
> > > +		__check_element(pool, element, kmem_cache_size(pool->pool_data));
> > >  	} else if (pool->free == mempool_free_pages) {
> > >  		/* Mempools backed by page allocator */
> > >  		int order = (int)(long)pool->pool_data;
> > 
> > I had a quick look at this to be sure I understood what was going on,
> > and I found a grotesque bug that has been with us since the introduction
> > of check_element() in 2015.
> > 
> > +       if (pool->free == mempool_free_pages) {
> > +               int order = (int)(long)pool->pool_data;
> > +               void *addr = kmap_atomic((struct page *)element);
> > +
> > +               __check_element(pool, addr, 1UL << (PAGE_SHIFT + order));
> > +               kunmap_atomic(addr);
> > 
> > kmap_atomic() and friends only map a single page.  So this is all
> > nonsense for HIGHMEM kernels, GFP_HIGHMEM allocations and order > 0.
> > The consequence of doing that will be calling memset(POISON_INUSE)
> > on random pages that we don't own.
> 
> Ah-ha! Thank you both! Seems like the first fix should be squashed and
> the latter one is separate? Or just put it all together?

Yes, I have no objection to Vlastimil's patch as-is.  I haven't really
reviewed it, just used it as an excuse to look at this code.  A fix for
the kmap_atomic() problem will necessarily be separate and should be
backported separately.
