Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9715E6139BA
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 16:12:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231244AbiJaPMu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 11:12:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230244AbiJaPMm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 11:12:42 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1279511458;
        Mon, 31 Oct 2022 08:12:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=TPvWvXv6yMZaf0wVZxcvo68g3rMsA09BUEC3iTc6qFw=; b=AbB4efg2oN0nlQRcssIl97nOp4
        aJBp9PyNs5SQKw2famHTJ4in7RQFV1yUqbz4sYmVMAMPes41F7Q3X4Tz1m8RR/3eLkCwqFNJGAyzo
        5bvzi4+MOxZ5cxJ5f+yGKDfdFQ4snxwymgMPNQleo8SUclrsdUiJ825BVB31FJ/SfOBw5JjdXi1Ha
        NwDwZxfyPLnQReBaA1aonsbAd0vEzehOOrZ9zIZ7yfL7hpUJZ3anvkINNSdwFEgWQF9eOKTtIeDOQ
        Yl9m4rxWfF5q+o27J61YnjK9k2tkoRps9fdCMZhjqKMOtiGsO6Ysqi01JxwFGDiE9xT0ZzFpD3Pds
        PYeFYYIA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1opWSn-003ljY-G1; Mon, 31 Oct 2022 15:12:33 +0000
Date:   Mon, 31 Oct 2022 15:12:33 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Anders Roxell <anders.roxell@linaro.org>,
        Kees Cook <keescook@chromium.org>,
        kernel test robot <oliver.sang@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Rientjes <rientjes@google.com>,
        Marco Elver <elver@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        linux-mm@kvack.org, Andrey Konovalov <andreyknvl@gmail.com>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v4] mempool: Do not use ksize() for poisoning
Message-ID: <Y1/l4Tacaw738UaX@casper.infradead.org>
References: <20221028154823.you.615-kees@kernel.org>
 <20221031105514.GB69385@mutt>
 <13c4bd6e-09d3-efce-43a5-5a99be8bc96b@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <13c4bd6e-09d3-efce-43a5-5a99be8bc96b@suse.cz>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 31, 2022 at 04:00:25PM +0100, Vlastimil Babka wrote:
> +++ b/mm/mempool.c
> @@ -57,8 +57,10 @@ static void __check_element(mempool_t *pool, void *element, size_t size)
>  static void check_element(mempool_t *pool, void *element)
>  {
>  	/* Mempools backed by slab allocator */
> -	if (pool->free == mempool_free_slab || pool->free == mempool_kfree) {
> +	if (pool->free == mempool_kfree) {
>  		__check_element(pool, element, (size_t)pool->pool_data);
> +	} else if (pool->free == mempool_free_slab) {
> +		__check_element(pool, element, kmem_cache_size(pool->pool_data));
>  	} else if (pool->free == mempool_free_pages) {
>  		/* Mempools backed by page allocator */
>  		int order = (int)(long)pool->pool_data;

I had a quick look at this to be sure I understood what was going on,
and I found a grotesque bug that has been with us since the introduction
of check_element() in 2015.

+       if (pool->free == mempool_free_pages) {
+               int order = (int)(long)pool->pool_data;
+               void *addr = kmap_atomic((struct page *)element);
+
+               __check_element(pool, addr, 1UL << (PAGE_SHIFT + order));
+               kunmap_atomic(addr);

kmap_atomic() and friends only map a single page.  So this is all
nonsense for HIGHMEM kernels, GFP_HIGHMEM allocations and order > 0.
The consequence of doing that will be calling memset(POISON_INUSE)
on random pages that we don't own.

